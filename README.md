# fivem-lls-addon

[Lua Language Server](https://github.com/LuaLS/lua-language-server) definitions
for the Lua runtime used by [FiveM](https://fivem.net/) and
[RedM](https://redm.gg/).

Consumed by the
[FiveM/RedM Lua IntelliSense](https://github.com/ihyajb/cfxlua-vscode) VS Code
extension, and usable directly by any editor that speaks to the Lua Language
Server.

## Contents

| Path | What it is |
|------|------------|
| `library/runtime/` | Hand-written definitions for the Cfx runtime: `Citizen`, events, promises, statebags, `json`, `msgpack`, LuaGLM vectors and matrices |
| `library/manifest/` | The `fxmanifest.lua` / `__resource.lua` manifest DSL |
| `library/natives/CFX-NATIVE/` | CFX natives, plus `_handles.lua` declaring the shared handle aliases |
| `library/natives/GTAV/` | GTA V natives |
| `library/natives/RDR3/` | RDR3 natives |
| `plugin.lua` | Language server plugin handling Cfx syntax the parser does not know |
| `config.json` | Addon manifest and the settings the addon expects |
| `native-scopes.json.gz` | Which sides each native can be called from |
| `natives-index.json.gz` | The same natives as data, for editor features |

`library/natives/` is generated weekly by
[rage-lua-natives](https://github.com/ihyajb/rage-lua-natives) — edits there will
be overwritten. The other directories are maintained by hand.

Only one of `GTAV/` and `RDR3/` is loaded at a time; `CFX-NATIVE/` is always
loaded, which is why the handle aliases live there.

## Using it without the extension

Point `Lua.workspace.library` at the directories you want and apply the settings
in `config.json`:

```json
{
  "Lua.runtime.version": "Lua 5.4",
  "Lua.runtime.plugin": "path/to/fivem-lls-addon/plugin.lua",
  "Lua.workspace.library": [
    "path/to/fivem-lls-addon/library/runtime",
    "path/to/fivem-lls-addon/library/manifest",
    "path/to/fivem-lls-addon/library/natives/CFX-NATIVE",
    "path/to/fivem-lls-addon/library/natives/GTAV"
  ]
}
```

## The data artifacts

Two files carry the same natives as data, so an editor can answer questions the
`.lua` definitions cannot — native search, resolving a hash back to a name, and
whether a native can be called from the file it appears in.

They are split by how often they are needed:

| File | Size | Holds | Read when |
|------|------|-------|-----------|
| `native-scopes.json.gz` | 119 KiB | Name to a side bitmask: 1 client, 2 server, 3 both | A Lua file is checked |
| `natives-index.json.gz` | 354 KiB | Hash, namespace, apiset, parameter names and types, return values, deprecated aliases | Someone searches natives or hovers a hash |

The scope table is the one a normal editing session needs, and keeping it apart
means the editor loads a quarter of the data rather than all of it. Apisets are
already merged across the sets a game loads, so a native with a server-side RPC
equivalent is marked as valid on both sides, and every global the runtime
definitions declare — `Wait`, `CreateThread` — is left out, because those are not
natives whichever side you are on.

Both are derived from the definitions that ship rather than from upstream, so the
data and the definitions cannot disagree:

```sh
bun scripts/build-index.mjs          # rebuild
bun scripts/build-index.mjs --check  # verify the committed index is current
```

CI runs it under [Bun](https://bun.sh); the script uses only `node:` built-ins, so
`node scripts/build-index.mjs` works identically if that is what you have.

The builder refuses to write artifacts that are missing a hash, that parse fewer
declarations than the files contain, that fall below a per-game floor, or that
would shrink a set by more than 2% (`--allow-shrink` overrides the last).

## Development

```sh
bun install
bun test                             # runs plugin.lua in a real Lua 5.4 runtime
bun run index                        # rebuild the data artifacts
bun run index:check                  # verify the committed artifacts are current
```

`plugin.lua` is the hottest code here — the language server calls `OnSetText` for
every Lua file in the workspace on every edit — so it has its own test suite,
executed against Lua 5.4 compiled to WebAssembly rather than mocked.

## License

MIT
