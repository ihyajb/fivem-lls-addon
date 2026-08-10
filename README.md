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

## The native index

`natives-index.json.gz` holds every native as data — name, hash, namespace,
apiset, parameter names and types, return types, and the deprecated aliases —
without the descriptions, which the language server already shows on hover. It is
what lets an editor offer native search, resolve a hash back to a name, and check
whether a native can be called from the file it appears in, none of which the
`.lua` definitions can answer.

It is derived from the definitions that ship rather than from upstream, so the
two cannot disagree:

```sh
bun scripts/build-index.mjs          # rebuild
bun scripts/build-index.mjs --check  # verify the committed index is current
```

CI runs it under [Bun](https://bun.sh); the script uses only `node:` built-ins, so
`node scripts/build-index.mjs` works identically if that is what you have.

The builder refuses to write an index that is missing a hash, that parses fewer
declarations than the files contain, that falls below a per-game floor, or that
would shrink a set by more than 2% (`--allow-shrink` overrides the last).

## License

MIT
