#!/usr/bin/env node
/**
 * Builds the two data artifacts an editor needs alongside the Lua definitions.
 *
 *   native-scopes.json.gz   name -> which sides it can be called from
 *   natives-index.json.gz   full detail: hash, namespace, parameters, returns
 *
 * They are split because they are needed at different times. The scope table is
 * read whenever a Lua file is checked, so it has to be cheap; the full index is
 * only read when someone searches the natives or hovers a hash, so it can be
 * four times the size and load lazily.
 *
 * Both are derived from the definitions that actually ship rather than from
 * upstream, so the data and the definitions cannot disagree. Descriptions are
 * excluded: they are the bulk of the bytes and the language server already
 * surfaces them on hover.
 *
 *   node scripts/build-index.mjs [--check] [--allow-shrink]
 *
 * `--check` verifies the committed artifacts match the library and exits
 * non-zero if they do not, without writing anything.
 */

import { readdir, readFile, writeFile } from 'node:fs/promises';
import * as path from 'node:path';
import { fileURLToPath } from 'node:url';
import { gunzipSync, gzipSync } from 'node:zlib';

const ROOT = path.join(path.dirname(fileURLToPath(import.meta.url)), '..');
const NATIVES_DIR = path.join(ROOT, 'library', 'natives');
const RUNTIME_DIR = path.join(ROOT, 'library', 'runtime');

const INDEX_FILE = path.join(ROOT, 'natives-index.json.gz');
const SCOPES_FILE = path.join(ROOT, 'native-scopes.json.gz');

/** Directories to index. */
const SETS = ['CFX-NATIVE', 'GTAV', 'RDR3'];

/** The set loaded alongside whichever game the user selected. */
const SHARED_SET = 'CFX-NATIVE';

/** Games, each paired with the shared set at lookup time. */
const GAMES = ['GTAV', 'RDR3'];

/**
 * Files that hold no declarations. Everything else is a namespace, including
 * RDR3's `_NAMESPACE4.lua` — an underscore prefix is not a marker here.
 */
const SKIP_FILES = new Set(['_handles.lua']);

/** Minimum natives expected per set, as a guard against a gutted library. */
const FLOORS = { 'CFX-NATIVE': 900, GTAV: 6000, RDR3: 6500 };

/** Side bits, as stored in the scope table. */
const CLIENT = 1;
const SERVER = 2;

const DECLARATION = /^function ([A-Za-z0-9_]+)\(([^)]*)\) end$/;
const ALIAS = /^([A-Za-z0-9_]+) = ([A-Za-z0-9_]+)$/;
const HEADER = /^---\*\*`([^`]+)` `([^`]+)`\*\*/;
const DOC_LINK = /^---\[Native Documentation\]\(.*?(0[xX][0-9a-fA-F]+)\)/;
const PARAM = /^---@param ([A-Za-z0-9_]+) (.+)$/;
const RETURN = /^---@return (.+)$/;

/** Globals declared by the hand-written runtime definitions. */
const RUNTIME_FUNCTION = /^function ([A-Za-z_][A-Za-z0-9_]*)/;
const RUNTIME_ASSIGNMENT = /^([A-Za-z_][A-Za-z0-9_]*)\s*=/;

function sideBit(apiset) {
  if (apiset === 'shared') return CLIENT | SERVER;

  return apiset === 'server' ? SERVER : CLIENT;
}

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
 *
 * Lines are dispatched on their first character before any regular expression
 * runs. Nearly every line in the library starts with `-`, and of those only a
 * few kinds carry information, so this skips most of the pattern matching that a
 * regex-per-line pass would do.
 */
function parseFile(text, counts) {
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
    const line = raw.trimEnd();

    if (line === '') continue;

    const first = line.charCodeAt(0);

    // '-' — a comment or an annotation
    if (first === 45) {
      if (line === '---@deprecated') {
        deprecated = true;
        continue;
      }

      // All of the annotations we read are `---@…` or `---*` or `---[`.
      const marker = line.charCodeAt(3);

      if (marker === 64) {
        // '@'
        const paramMatch = PARAM.exec(line);

        if (paramMatch) {
          params.push({ name: paramMatch[1], type: paramMatch[2].trim() });
          continue;
        }

        const returnMatch = RETURN.exec(line);

        if (returnMatch) {
          returns = parseReturns(returnMatch[1]);
        }

        continue;
      }

      if (marker === 42) {
        // '*' — the namespace and apiset header starts a new declaration, so
        // anything half-collected belongs to something that never closed.
        const headerMatch = HEADER.exec(line);

        if (headerMatch) {
          reset();
          header = { ns: headerMatch[1], apiset: headerMatch[2] };
        }

        continue;
      }

      if (marker === 91) {
        // '['
        const linkMatch = DOC_LINK.exec(line);

        if (linkMatch) hash = linkMatch[1].toLowerCase();
      }

      continue;
    }

    // 'f' — a declaration
    if (first === 102) {
      const declarationMatch = DECLARATION.exec(line);

      if (declarationMatch) {
        counts.declarations++;

        const collected = params;

        natives.push({
          name: declarationMatch[1],
          hash,
          ns: header === undefined ? undefined : header.ns,
          apiset: header === undefined ? 'client' : header.apiset,
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
          returns,
        });

        reset();
        continue;
      }

      reset();
      continue;
    }

    if (deprecated) {
      const aliasMatch = ALIAS.exec(line);

      if (aliasMatch) {
        aliases.push({ name: aliasMatch[1], target: aliasMatch[2] });
        reset();
        continue;
      }
    }

    reset();
  }

  return { natives, aliases };
}

/**
 * Counts `function … end` lines independently of {@link parseFile}, so a
 * regression in annotation handling shows up as a mismatch rather than a quietly
 * smaller index.
 */
function countDeclarations(text) {
  let count = 0;
  let index = 0;

  // Only lines starting with `function` can match, so search for that directly
  // rather than splitting the file a second time.
  while (true) {
    index = text.indexOf('\nfunction ', index);

    if (index === -1) break;

    const end = text.indexOf('\n', index + 1);
    const line = text.slice(index + 1, end === -1 ? undefined : end);

    if (DECLARATION.test(line.trimEnd())) count++;

    index = end === -1 ? text.length : end;
  }

  return count;
}

async function definitionFiles(set) {
  const entries = await readdir(path.join(NATIVES_DIR, set));

  return entries
    .filter((file) => file.endsWith('.lua') && !SKIP_FILES.has(file))
    .sort();
}

/**
 * Globals the Cfx Lua runtime provides itself.
 *
 * These take precedence over any native of the same name and exist on both
 * sides, so they are removed from the scope table: the game natives include a
 * `WAIT`, which would otherwise make every `Wait(0)` in a server script look
 * like a client-only call. Read from the runtime definitions rather than listed
 * by hand so a future collision is handled without anyone noticing it.
 */
async function runtimeGlobals() {
  const names = new Set();
  const files = (await readdir(RUNTIME_DIR)).filter((file) =>
    file.endsWith('.lua'),
  );

  for (const file of files) {
    const text = await readFile(path.join(RUNTIME_DIR, file), 'utf8');

    for (const raw of text.split('\n')) {
      const line = raw.trim();
      const match = RUNTIME_FUNCTION.exec(line) ?? RUNTIME_ASSIGNMENT.exec(line);

      if (match) names.add(match[1]);
    }
  }

  return names;
}

async function parseSet(set) {
  const dir = path.join(NATIVES_DIR, set);
  const files = await definitionFiles(set);

  const natives = {};
  const aliases = {};
  const counts = { declarations: 0 };
  let expected = 0;

  for (const file of files) {
    const text = await readFile(path.join(dir, file), 'utf8');

    expected += countDeclarations(`\n${text}`);

    const parsed = parseFile(text, counts);

    for (const native of parsed.natives) {
      if (natives[native.name] !== undefined) continue;

      const entry = {
        h: native.hash,
        ns: native.ns === undefined ? path.basename(file, '.lua') : native.ns,
        a: native.apiset,
      };

      // Joined rather than kept as arrays: three arrays per native is 43,000
      // arrays for the library, and a consumer only ever splits the handful it
      // is about to display.
      if (native.params.length > 0) {
        entry.p = native.params.map((param) => param.name).join(',');
        entry.t = native.params.map((param) => param.type).join(',');
      }

      if (native.returns.length > 0) {
        entry.r = native.returns
          .map((value) =>
            value.name === undefined ? value.type : `${value.type} ${value.name}`,
          )
          .join(',');
      }

      natives[native.name] = entry;
    }

    for (const alias of parsed.aliases) aliases[alias.name] = alias.target;
  }

  return {
    natives,
    aliases,
    declarations: counts.declarations,
    expected,
    files: files.length,
  };
}

async function build() {
  const runtime = await runtimeGlobals();
  const sets = {};
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

    sets[set] = { natives: parsed.natives, aliases: parsed.aliases };

    report.push(
      `${set}: ${unique} natives, ${
        Object.keys(parsed.aliases).length
      } deprecated aliases, ${parsed.files} files`,
    );
  }

  // A native that exists in both the game set and the shared set is callable
  // from both sides — 159 of them are — so the bits are merged here rather than
  // left for every consumer to work out.
  const games = {};

  for (const game of GAMES) {
    const table = {};

    for (const set of [game, SHARED_SET]) {
      for (const [name, native] of Object.entries(sets[set].natives)) {
        if (runtime.has(name)) continue;

        table[name] = (table[name] ?? 0) | sideBit(native.a);
      }
    }

    games[game] = table;

    const both = Object.values(table).filter((bits) => bits === 3).length;

    report.push(
      `${game} scopes: ${Object.keys(table).length} natives, ${both} on both sides`,
    );
  }

  report.push(`excluded ${runtime.size} runtime globals from the scope table`);

  return {
    index: { version: 1, sets },
    scopes: { version: 1, games },
    report,
  };
}

/**
 * Compares against the artifacts already committed. Floors catch a library that
 * came back empty; this catches the subtler case where upstream returns a
 * partial document and a few hundred natives quietly disappear.
 */
async function guardAgainstShrink(index) {
  let previous;

  try {
    previous = JSON.parse(gunzipSync(await readFile(INDEX_FILE)).toString('utf8'));
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

/** Reads a committed artifact, returning its JSON text or undefined. */
async function readArtifact(file) {
  try {
    return gunzipSync(await readFile(file)).toString('utf8');
  } catch {
    return undefined;
  }
}

const { index, scopes, report } = await build();

if (!process.argv.includes('--allow-shrink')) {
  await guardAgainstShrink(index);
}

const artifacts = [
  { file: SCOPES_FILE, value: scopes },
  { file: INDEX_FILE, value: index },
];

const checking = process.argv.includes('--check');
let written = 0;
let total = 0;

for (const { file, value } of artifacts) {
  const json = JSON.stringify(value);
  const name = path.basename(file);
  // Compared after decompression: gzip output is only byte-identical for the
  // same zlib build and settings, and this runs under both node and bun.
  const current = await readArtifact(file);

  if (checking) {
    if (current === undefined) {
      console.error(`${name} is missing; run node scripts/build-index.mjs`);
      process.exit(1);
    }

    if (current !== json) {
      console.error(`${name} is out of date; run node scripts/build-index.mjs`);
      process.exit(1);
    }

    continue;
  }

  // An artifact whose content is unchanged is left alone. Recompressing it
  // would still rewrite the file — the bytes differ between zlib builds — and
  // the CI job reads the diff to decide whether there is anything to commit.
  if (current === json) continue;

  // Compressed once: gzip at level 9 over two megabytes is the bulk of this
  // script's runtime, so it is not worth doing twice to report a size.
  const payload = gzipSync(Buffer.from(json), { level: 9 });

  await writeFile(file, payload);
  written++;
  total += payload.length;
}

for (const line of report) console.log(line);

console.log(
  checking
    ? `checked ${artifacts.length} artifacts`
    : written === 0
      ? `${artifacts.length} artifacts already current`
      : `wrote ${written} of ${artifacts.length} artifacts (${(
          total / 1024
        ).toFixed(0)} KiB written)`,
);
