import { afterAll, describe, expect, it } from 'bun:test';
import { readFileSync } from 'node:fs';
import * as path from 'node:path';
import { fileURLToPath } from 'node:url';
import { LuaFactory } from 'wasmoon';

/**
 * Exercises plugin.lua, the Lua Language Server plugin, in a real Lua 5.4
 * runtime (compiled to WebAssembly).
 *
 * This is the hottest code in the project: the language server calls OnSetText
 * for every Lua file in the workspace on every edit. It had no tests, which made
 * the fast path added for that reason unverifiable.
 */
const PLUGIN = path.join(
  path.dirname(fileURLToPath(import.meta.url)),
  '..',
  '..',
  'plugin.lua',
);

const factory = new LuaFactory();
const source = readFileSync(PLUGIN, 'utf8');

const lua = await factory.createEngine();
await lua.doString(source);
const onSetText = lua.global.get('OnSetText');

afterAll(() => lua.global.close());

/**
 * Normalises a result so "no rewrites" has one representation: the plugin may
 * return nil or an empty table, and both mean the file is left alone.
 */
function rewrites(uri, text) {
  const result = onSetText(uri, text);

  if (result === undefined || result === null) return [];
  if (typeof result === 'string') return result;

  return Object.values(result)
    .map((diff) => `${diff.start}:${diff.finish}:${diff.text}`)
    .sort();
}

const DISABLE = '1:0:---@diagnostic disable: undefined-global\n';

describe('files the plugin leaves alone', () => {
  it('an ordinary script with nothing to rewrite', () => {
    expect(rewrites('file:///r/s.lua', 'Wait(0)\nprint("hi")\n')).toEqual([]);
  });

  it('definition files', () => {
    expect(rewrites('file:///r/l.lua', '---@meta\nfunction Foo() end\n')).toEqual(
      [],
    );
  });

  it('anything under .vscode, even with syntax it would otherwise rewrite', () => {
    expect(rewrites('file:///r/.vscode/s.lua', 'local a = b?.c\n')).toEqual([]);
    expect(rewrites('file:///C:/r/.vscode/s.lua', 'local a = b?.c\n')).toEqual(
      [],
    );
  });
});

describe('asset protection', () => {
  it('blanks a file with an FXAP header, which is not readable Lua', () => {
    expect(rewrites('file:///r/e.lua', 'FXAP encrypted')).toBe('');
  });
});

describe('resource manifests', () => {
  it('suppresses undefined-global for both manifest names', () => {
    expect(rewrites('file:///r/fxmanifest.lua', "game 'gtav'\n")).toEqual([
      DISABLE,
    ]);
    expect(rewrites('file:///r/__resource.lua', "game 'gtav'\n")).toEqual([
      DISABLE,
    ]);
  });

  it('does not suppress it for a file merely named like one', () => {
    expect(rewrites('file:///r/fxmanifest.lua.bak', "game 'gtav'\n")).toEqual(
      [],
    );
  });

  it('still rewrites safe navigation inside a manifest', () => {
    const result = rewrites(
      'file:///r/fxmanifest.lua',
      "game 'gtav'\nlocal v = a?.b\n",
    );

    expect(result).toContain(DISABLE);
    expect(result.length).toBe(3);
  });
});

describe('safe navigation', () => {
  it('removes the question mark for dot access', () => {
    expect(rewrites('file:///r/c.lua', 'local v = cfg?.key\n')).toEqual([
      '10:13:(cfg or {})',
      '14:14:',
    ]);
  });

  it('removes it for index access', () => {
    expect(rewrites('file:///r/c.lua', 'local v = cfg?["k"]\n')).toEqual([
      '10:13:(cfg or {})',
      '14:14:',
    ]);
  });

  it('handles an argument position', () => {
    expect(rewrites('file:///r/c.lua', 'foo(a, b?.c)\n')).toEqual([
      '7:8:(b or {})',
      '9:9:',
    ]);
  });

  it('handles a chain, guarding only the first index', () => {
    const result = rewrites('file:///r/c.lua', 'local v = a?.b?.c\n');

    // Two question marks removed, one nil guard inserted.
    expect(result.filter((diff) => diff.endsWith(':')).length).toBe(2);
  });

  it('keeps the preceding character when there is no whitespace to reuse', () => {
    expect(rewrites('file:///r/c.lua', 'local v =   cfg?.key\n')).toEqual([
      '12:15:(cfg or {})',
      '16:16:',
    ]);
  });
});
