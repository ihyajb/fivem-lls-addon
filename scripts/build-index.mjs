#!/usr/bin/env node
/**
 * Builds `natives-index.json.gz` from the definition files in `library/natives`.
 *
 * The Lua library is what the language server consumes; editors need the same
 * information as data to offer native search, hash lookup and client/server
 * checks without shipping a second copy of the upstream JSON. Deriving the index
 * from the definitions that actually ship — rather than from upstream — means the
 * two can never disagree.
 *
 * Descriptions are deliberately excluded: they are the bulk of the bytes and the
 * language server already surfaces them on hover.
 *
 *   node scripts/build-index.mjs [--check]
 *
 * `--check` verifies the committed index matches the library and exits non-zero
 * if it does not, without writing anything.
 */

import { createHash } from 'node:crypto';
import { readdir, readFile, writeFile } from 'node:fs/promises';
import * as path from 'node:path';
import { fileURLToPath } from 'node:url';
import { gunzipSync, gzipSync } from 'node:zlib';

const ROOT = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');
const NATIVES_DIR = path.join(ROOT, 'library', 'natives');
const OUTPUT = path.join(ROOT, 'natives-index.json.gz');

/** Directories to index. */
const SETS = ['CFX-NATIVE', 'GTAV', 'RDR3'];

/**
 * Files that hold no declarations. Everything else is a namespace, including
 * RDR3's `_NAMESPACE4.lua` — an underscore prefix is not a marker here.
 */
const SKIP_FILES = new Set(['_handles.lua']);

/** Minimum natives expected per set, as a guard against a gutted library. */
const FLOORS = { 'CFX-NATIVE': 900, GTAV: 6000, RDR3: 6500 };

const DECLARATION = /^function ([A-Za-z0-9_]+)\(([^)]*)\) end$/;
const ALIAS = /^([A-Za-z0-9_]+) = ([A-Za-z0-9_]+)$/;
const HEADER = /^---\*\*`([^`]+)` `([^`]+)`\*\*/;
const DOC_LINK = /^---\[Native Documentation\]\(.*?(0[xX][0-9a-fA-F]+)\)/;
const PARAM = /^---@param ([A-Za-z0-9_]+) (.+)$/;
const RETURN = /^---@return (.+)$/;

/**
 * Splits a `---@return` annotation into its values. Each entry is `type` or
 * `type name`; a type may itself contain spaces (`Hash | string`), so a name is
 * only taken when the last word is a bare identifier and something precedes it.
 */
function parseReturns(annotation) {
  return annotation.split(',').map((entry) => {
    const parts = entry.trim().split(/\s+/);
    const last = parts[parts.length - 1];

    if (parts.length > 1 && /^[A-Za-z_][A-Za-z0-9_]*$/.test(last)) {
      return { type: parts.slice(0, -1).join(' '), name: last };
    }

    return { type: parts.join(' ') };
  });
}

/**
 * Reads one definition file. Annotations accumulate until a `function` line
 * closes the declaration, mirroring how the generator emits them.
 */
function parseFile(text) {
  const natives = [];
  const aliases = [];

  let header;
  let hash;
  let params = [];
  let returns = [];
  let deprecated = false;

  const reset = () => {
    header = undefined;
    hash = undefined;
    params = [];
    returns = [];
    deprecated = false;
  };

  reset();

  for (const raw of text.split('\n')) {
    const line = raw.trim();

    if (line === '---@deprecated') {
      deprecated = true;
      continue;
    }

    const headerMatch = HEADER.exec(line);
    if (headerMatch) {
      // A new header starts a new declaration; drop anything half-collected.
      reset();
      header = { ns: headerMatch[1], apiset: headerMatch[2] };
      continue;
    }

    const linkMatch = DOC_LINK.exec(line);
    if (linkMatch) {
      hash = linkMatch[1].toLowerCase();
      continue;
    }

    const paramMatch = PARAM.exec(line);
    if (paramMatch) {
      params.push({ name: paramMatch[1], type: paramMatch[2].trim() });
      continue;
    }

    const returnMatch = RETURN.exec(line);
    if (returnMatch) {
      returns = parseReturns(returnMatch[1]);
      continue;
    }

    const declarationMatch = DECLARATION.exec(line);
    if (declarationMatch) {
      const name = declarationMatch[1];
      const collected = params;
      const collectedReturns = returns;
      const nativeHeader = header;
      const nativeHash = hash;

      natives.push({
        name,
        hash: nativeHash,
        ns: nativeHeader === undefined ? undefined : nativeHeader.ns,
        apiset: nativeHeader === undefined ? 'client' : nativeHeader.apiset,
        // The signature is authoritative for parameter order: annotations for
        // output parameters were moved to the return list by the generator.
        params: declarationMatch[2]
          .split(',')
          .map((arg) => arg.trim())
          .filter(Boolean)
          .map((arg) => {
            const annotated = collected.find((param) => param.name === arg);

            return { name: arg, type: annotated ? annotated.type : 'any' };
          }),
        returns: collectedReturns,
      });

      reset();
      continue;
    }

    const aliasMatch = ALIAS.exec(line);
    if (aliasMatch && deprecated) {
      aliases.push({ name: aliasMatch[1], target: aliasMatch[2] });
      reset();
      continue;
    }

    if (line === '' || line.startsWith('--')) continue;

    reset();
  }

  return { natives, aliases };
}

async function definitionFiles(set) {
  const dir = path.join(NATIVES_DIR, set);
  const entries = await readdir(dir);

  return entries
    .filter((file) => file.endsWith('.lua') && !SKIP_FILES.has(file))
    .sort();
}

async function parseSet(set) {
  const dir = path.join(NATIVES_DIR, set);
  const files = await definitionFiles(set);

  const natives = {};
  const aliases = {};
  let declarations = 0;
  let expected = 0;

  for (const file of files) {
    const text = await readFile(path.join(dir, file), 'utf8');

    // Counted independently of the parser so a regression in annotation
    // handling shows up as a mismatch rather than a quietly smaller index.
    for (const line of text.split('\n')) {
      if (DECLARATION.test(line.trim())) expected++;
    }

    const parsed = parseFile(text);

    for (const native of parsed.natives) {
      declarations++;

      if (natives[native.name] !== undefined) continue;

      natives[native.name] = {
        h: native.hash,
        ns: native.ns === undefined ? path.basename(file, '.lua') : native.ns,
        a: native.apiset,
        p: native.params.map((param) => param.name),
        t: native.params.map((param) => param.type),
        r: native.returns.map((value) =>
          value.name === undefined ? value.type : `${value.type} ${value.name}`,
        ),
      };
    }

    for (const alias of parsed.aliases) aliases[alias.name] = alias.target;
  }

  return { natives, aliases, declarations, expected, files: files.length };
}

async function build() {
  const index = { version: 1, sets: {} };
  const report = [];

  for (const set of SETS) {
    const parsed = await parseSet(set);

    if (parsed.declarations !== parsed.expected) {
      throw new Error(
        `${set}: parsed ${parsed.declarations} declarations but the files contain ${parsed.expected}`,
      );
    }

    const unique = Object.keys(parsed.natives).length;

    if (unique < FLOORS[set]) {
      throw new Error(
        `${set}: ${unique} natives, expected at least ${FLOORS[set]}`,
      );
    }

    // Every native needs a hash for the extension's hash lookup to work.
    const missingHash = Object.keys(parsed.natives).filter(
      (name) => !parsed.natives[name].h,
    );

    if (missingHash.length > 0) {
      throw new Error(
        `${set}: ${missingHash.length} natives have no hash (e.g. ${missingHash
          .slice(0, 3)
          .join(', ')})`,
      );
    }

    index.sets[set] = { natives: parsed.natives, aliases: parsed.aliases };

    report.push(
      `${set}: ${unique} natives, ${
        Object.keys(parsed.aliases).length
      } deprecated aliases, ${parsed.files} files`,
    );
  }

  return { index, report };
}

/**
 * Compares against the index already committed. Floors catch a library that came
 * back empty; this catches the subtler case where upstream returns a partial
 * document and a few hundred natives quietly disappear.
 */
async function guardAgainstShrink(index) {
  let previous;

  try {
    previous = JSON.parse(gunzipSync(await readFile(OUTPUT)).toString('utf8'));
  } catch {
    return; // No index yet, or an unreadable one; nothing to compare against.
  }

  for (const set of SETS) {
    const before = Object.keys(previous.sets?.[set]?.natives ?? {}).length;
    const after = Object.keys(index.sets[set].natives).length;

    if (before > 0 && after < before * 0.98) {
      throw new Error(
        `${set}: ${after} natives, down from ${before} — refusing to shrink the library by more than 2%. Pass --allow-shrink if this is intended.`,
      );
    }
  }
}

const { index, report } = await build();

if (!process.argv.includes('--allow-shrink')) {
  await guardAgainstShrink(index);
}

const payload = gzipSync(Buffer.from(JSON.stringify(index)), { level: 9 });
const checking = process.argv.includes('--check');

if (checking) {
  let current;

  try {
    current = await readFile(OUTPUT);
  } catch {
    console.error(
      'natives-index.json.gz is missing; run node scripts/build-index.mjs',
    );
    process.exit(1);
  }

  const digest = (buffer) => createHash('sha256').update(buffer).digest('hex');

  // gzip output is deterministic for identical input and settings, so comparing
  // the compressed bytes is enough to detect a stale index.
  if (digest(current) !== digest(payload)) {
    console.error(
      'natives-index.json.gz is out of date; run node scripts/build-index.mjs',
    );
    process.exit(1);
  }

  console.log('natives-index.json.gz is up to date');
} else {
  await writeFile(OUTPUT, payload);
}

for (const line of report) console.log(line);

console.log(
  `${checking ? 'checked' : 'wrote'} natives-index.json.gz (${(
    payload.length / 1024
  ).toFixed(0)} KiB)`,
);
