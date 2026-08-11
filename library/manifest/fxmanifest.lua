---@meta

-- Definitions for the resource manifest DSL used by `fxmanifest.lua` and the
-- legacy `__resource.lua`.
--
-- A manifest also accepts arbitrary metadata keys — anything the resource or a
-- framework wants to read back with GetResourceMetadata — so `undefined-global`
-- stays disabled for manifest files in plugin.lua. These declarations are here
-- for completion, hover text and argument checking on the keys that do have a
-- defined meaning.
--
-- Values are suggested for completion but never enforced: every value-taking key
-- below accepts a plain string as well as the listed values. The platform adds
-- new ones, and a manifest must never be flagged for using one this file has not
-- heard of.
--
-- Reference: https://docs.fivem.net/docs/scripting-reference/resource-manifest/resource-manifest/

---@alias fxversion
---Latest. Requires escaped event names and `set` in place of `setr`.
---| 'cerulean'
---Adds `AddEventHandler` return values and state bags.
---| 'bodacious'
---Legacy.
---| 'adamant'

---@alias fxgame
---Grand Theft Auto V (FiveM).
---| 'gta5'
---Red Dead Redemption 2 (RedM).
---| 'rdr3'
---Any game.
---| 'common'

---@alias fxtoggle 'yes' | 'no' | 'true' | 'false' | 'on' | 'off'

---@alias fxfiles string | string[]

---Declares which manifest format the resource uses. Required.
---@param version fxversion | string
function fx_version(version) end

---The game this resource targets. Use `games` for more than one.
---@param game fxgame | string
function game(game) end

---The games this resource targets.
---@param games (fxgame | string)[]
function games(games) end

---Acknowledges that RedM support is unfinished. Required by RedM resources.
---@param message string
function rdr3_warning(message) end

---Human-readable resource name.
---@param name string
function name(name) end

---@param author string
function author(author) end

---@param version string
function version(version) end

---@param description string
function description(description) end

---@param url string
function repository(repository) end

---@param license string
function license(license) end

---Enables the Lua 5.4 runtime, which is required for the type definitions and
---nonstandard operators this extension configures.
---@param enabled fxtoggle | string
function lua54(enabled) end

---Opts into the experimental fxv2 object-oriented API layer.
---@param enabled fxtoggle | string
function use_experimental_fxv2_oal(enabled) end

---Scripts loaded on the client.
---@param files fxfiles
function client_script(files) end

---Scripts loaded on the client.
---@param files fxfiles
function client_scripts(files) end

---Scripts loaded on the server.
---@param files fxfiles
function server_script(files) end

---Scripts loaded on the server.
---@param files fxfiles
function server_scripts(files) end

---Scripts loaded on both the client and the server.
---@param files fxfiles
function shared_script(files) end

---Scripts loaded on both the client and the server.
---@param files fxfiles
function shared_scripts(files) end

---Files sent to the client, such as NUI assets and stream files.
---@param files fxfiles
function file(files) end

---Files sent to the client, such as NUI assets and stream files.
---@param files fxfiles
function files(files) end

---HTML file to use as this resource's NUI page.
---@param path string
function ui_page(path) end

---Use this resource's `ui_page` as the game's loading screen.
---@param path string
function loadscreen(path) end

---Keep the loading screen up until the resource shuts it down itself.
---@param enabled fxtoggle | string
function loadscreen_manual_shutdown(enabled) end

---Show the cursor on the loading screen.
---@param enabled fxtoggle | string
function loadscreen_cursor(enabled) end

---Registers a game data file. Called as `data_file 'TYPE' 'path'`.
---@overload fun(fileType: string, path: fxfiles)
---@param fileType string
---@return fun(path: fxfiles)
function data_file(fileType) end

---Marks this resource as a map, so the game loads it as one.
---@param enabled fxtoggle | string
function this_is_a_map(enabled) end

---Prevents the resource from starting on the client.
---@param enabled fxtoggle | string
function server_only(enabled) end

---Another resource that must start before this one.
---@param resource string
function dependency(resource) end

---Other resources that must start before this one.
---@param resources string[]
function dependencies(resources) end

---Declares that this resource replaces another, so dependencies on that name
---resolve to this resource.
---@param resource string
function provide(resource) end

---Exports a client function for other resources to call.
---@param name string
function export(name) end

---Exports client functions for other resources to call.
---@param names string[]
function exports(names) end

---Exports a server function for other resources to call.
---@param name string
function server_export(name) end

---Exports server functions for other resources to call.
---@param names string[]
function server_exports(names) end

---Chat theme registered by this resource.
---@overload fun(name: string, definition: table)
---@param name string
---@return fun(definition: table)
function chat_theme(name) end

---Files the escrow system should leave readable in a protected resource.
---@param files fxfiles
function escrow_ignore(files) end

---Turns off lazy native loading for this resource.
---@param enabled fxtoggle | string
function disable_lazy_natives(enabled) end

---Turns off the CLR task scheduler for this resource.
---@param enabled fxtoggle | string
function clr_disable_task_scheduler(enabled) end

---Requires NUI callbacks to be registered before they are used.
---@param enabled fxtoggle | string
function nui_callback_strict_mode(enabled) end

---Groups this resource's convars under a category in the server UI.
---@overload fun(name: string, definition: table)
---@param name string
---@return fun(definition: table)
function convar_category(name) end

---Level meta file to load before the game's own.
---@param path string
function before_level_meta(path) end

---Level meta file to load after the game's own.
---@param path string
function after_level_meta(path) end

---Level meta file to load instead of the game's own.
---@param path string
function replace_level_meta(path) end

---Webpack config used to build this resource's NUI assets.
---@param path string
function webpack_config(path) end

---Manifest version used by the legacy `__resource.lua` format. Prefer
---`fx_version` in `fxmanifest.lua`.
---@param uuid string
function resource_manifest_version(uuid) end
