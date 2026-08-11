import { describe, expect, it } from 'bun:test';
import { readFileSync } from 'node:fs';
import * as path from 'node:path';
import { fileURLToPath } from 'node:url';

/**
 * Guards the manifest definitions against the two mistakes that produce a
 * warning on every resource: a wrong value in an enum, and an enum that binds.
 */
const source = readFileSync(
  path.join(
    path.dirname(fileURLToPath(import.meta.url)),
    '..',
    '..',
    'library',
    'manifest',
    'fxmanifest.lua',
  ),
  'utf8',
);

describe('game values', () => {
  it('uses gta5, which is what the manifest accepts', () => {
    expect(source).toContain("---| 'gta5'");
  });

  it('never mentions gtav, which is only the definition folder name', () => {
    expect(source).not.toContain('gtav');
  });

  it('does not claim server is a game', () => {
    expect(source).not.toContain("---| 'server'");
  });
});

describe('value enums do not bind', () => {
  const enums = ['fxversion', 'fxgame', 'fxtoggle'];

  it.each(enums)('%s is declared', (name) => {
    expect(source).toContain(`---@alias ${name}`);
  });

  it.each(enums)('every %s parameter also accepts a plain string', (name) => {
    // A parameter typed as the bare enum is flagged the moment the platform adds
    // a value this file has not heard of, which is a warning on somebody's
    // perfectly correct manifest.
    const strict = source
      .split('\n')
      .filter((line) => new RegExp(`^---@param \\w+ ${name}\\s*$`).test(line));

    expect(strict).toEqual([]);
  });

  it('the array form accepts plain strings too', () => {
    expect(source).toContain('---@param games (fxgame | string)[]');
  });
});

describe('script keys', () => {
  it('declares both the singular and plural spellings', () => {
    for (const side of ['client', 'server', 'shared']) {
      expect(source).toContain(`function ${side}_script(files) end`);
      expect(source).toContain(`function ${side}_scripts(files) end`);
    }
  });
});
