---@meta

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xDEEDE7C41742E011)  
---It's unclear what exactly this does, but I assume it marks the blip as "no longer needed"
---@param blip Blip
function AbandonBlip(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x64C59DD6834FA942)  
---This native does not have an official description.
---@param x number
---@param y number
---@param z number
---@param p3 boolean
function AddPointToGpsMultiRoute(x, y, z, p3) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x1392105DA88BBFFB)  
---list of minimap props: https://github.com/femga/rdr3_discoveries/tree/master/graphics/minimap/minimapObjects
---variations parameter are the interior locations you see on the map like these bellow
---variation 0 https://i.imgur.com/jkLhn3Z.png
---variation 2  https://i.imgur.com/eKV0Tcm.png
---variation 4 https://i.imgur.com/rjwOgEH.png
---there are more and you can find them in the decompiles
---@param minimapProp Hash | string
---@param x number
---@param y number
---@param rotation number
---@param variation integer
function AddPropToMinimap(minimapProp, x, y, rotation, variation) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6E6E64788C07D2E0)  
---This native does not have an official description.
---@param toggle boolean
function AllowSonarBlips(toggle) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xEC174ADBCB611ECC)  
---This native does not have an official description.
---@param blipHash Hash | string
---@param x number
---@param y number
---@param z number
---@param scaleX number
---@param scaleY number
---@param scaleZ number
---@param p7 integer
---@return Blip
function BlipAddForArea(blipHash, x, y, z, scaleX, scaleY, scaleZ, p7) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x554D9D53F696D002)  
---https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips
---https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/textures/blips_mp
---@param blipHash Hash | string
---@param x number
---@param y number
---@param z number
---@return Blip
function BlipAddForCoords(blipHash, x, y, z) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x23F74C2FDA6E7C61)  
---This native does not have an official description.
---@param blipHash Hash | string
---@param entity Entity
---@return Blip
function BlipAddForEntity(blipHash, entity) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xA486008892065FB9)  
---This native does not have an official description.
---@param blipHash Hash | string
---@param pickup Pickup
---@return Blip
function BlipAddForPickupPlacement(blipHash, pickup) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x45F13B7E0A15C880)  
---This native does not have an official description.
---@param blipHash Hash | string
---@param x number
---@param y number
---@param z number
---@param radius number
---@return Blip
function BlipAddForRadius(blipHash, x, y, z, radius) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3E593DF9C2962EC6)  
---This native does not have an official description.
---@param styleHash Hash | string
---@return Blip
function BlipAddForStyle(styleHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xA6EF0C54A3443E70)  
---This native does not have an official description.
---@param blipHash Hash | string
---@param volume Volume
---@return Blip
function BlipAddForVolume(blipHash, volume) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x662D364ABF16DE2F)  
---https://alloc8or.re/rdr3/doc/enums/eBlipModifier.txt
---https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/blip_modifiers
---
---Old name: _BLIP_SET_MODIFIER
---@param blip Blip
---@param modifierHash Hash | string
---@return boolean
function BlipAddModifier(blip, modifierHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xBD62D98799A3DAF0)  
---This native does not have an official description.
---@param blip Blip
---@param styleHash Hash | string
---@return boolean
function BlipAddStyle(blip, styleHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x250C75EB1728CC0D)  
---Not official native name
---Removes the blip from an entity and makes it static on the map, try it on GetMainPlayerBlipId() for a demonstration
---@param blip Blip
function BlipDetachFromEntity(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xB059D7BD3D78C16F)  
---If modifierHash is 0, ALL modifiers will be removed.
---@param blip Blip
---@param modifierHash Hash | string
---@return boolean
function BlipRemoveModifier(blip, modifierHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xEDD964B7984AC291)  
---https://github.com/femga/rdr3_discoveries/tree/master/useful_info_from_rpfs/blip_styles
---Removes any existing modifiers and sets the style.
---@param blip Blip
---@param styleHash Hash | string
---@return boolean
function BlipSetStyle(blip, styleHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x01B928CA2E198B01)  
---Clear blip data. It must be used before RemoveBlip I'm pretty sure that blips are handled internally with databinding. This function should then allow you to clear blip container and therefore free up memory?.
---@param blip Blip
---@return any
function ClearBlip(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x44813684F72B563C)  
---will remove the blip icon from the entity lockon prompt,p1 = GET_BLIP_FROM_ENTITY
---@param entity Entity
---@param blip integer
function ClearBlipIconFromLockonEntityPrompt(entity, blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x1EAA5674B4D181C5)  
---This native does not have an official description.
function ClearGpsCustomRoute() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4D3771237C79FF41)  
---Clears the GPS flags.
function ClearGpsFlags() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x9E0AB9AAEE87CE28)  
---Does the same as SET_GPS_MULTI_ROUTE_RENDER(false);
function ClearGpsMultiRoute() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x08FDC6F796E350D1)  
---This native does not have an official description.
function ClearGpsPlayerWaypoint() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x7C9F4CDF402CA82A)  
---Clears the previously set coordinates for the pause map view, removing any specified focal point and radius that were set using `SetPausemapCoordsWithRadius - 0xE0884C184728C75B`
function ClearPausemapCoords() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x1B3DA717B9AFF828)  
---If Minimap / Radar should be displayed.
---@param toggle boolean
function DisplayRadar(toggle) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xCD82FA174080B3B1)  
---This native does not have an official description.
---@param blip Blip
---@return boolean
function DoesBlipExist(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x9FA00E2FC134A9D0)  
---This native does not have an official description.
---@param entity Entity
---@return boolean
function DoesEntityHaveBlip(entity) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3FDA2B79AEEE351C)  
---This native does not have an official description.
---@param x number
---@param y number
---@param z number
---@return boolean, vector3 outPosition
function FindClosestGpsPosition(x, y, z) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xEE1C7BA69BB74B08)  
---Doesn't actually return anything.
---@return any
function ForceSonarBlipsThisFrame() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x201C319797BDA603)  
---This native does not have an official description.
---@param blip Blip
---@return vector3
function GetBlipCoords(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6D2C41A8BD6D6FD0)  
---Returns the Blip handle of given Entity.
---@param entity Entity
---@return Blip
function GetBlipFromEntity(entity) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x5CD2889B2B381D45)  
---This native does not have an official description.
---@return Blip
function GetMainPlayerBlipId() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x29B30D07C3F7873B)  
---This native does not have an official description.
---@return vector3
function GetWaypointCoords() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF08E42BFA46BDFF8)  
---Unlike `GET_WAYPOINT_COORDS - 0x29B30D07C3F7873B`, which returns a single value, this native returns the x and y coordinates of the waypoint separately as floats from pointer. To retrieve each coordinate, `Citizen.PointerValueFloat()` must be used with this function.
---@return any, number x, number y
function GetWaypointPosition() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xA1B4052C2A3DCC1E)  
---This native does not have an official description.
function HideActivePointsOfInterest() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xE9F676788F8D5E1E)  
---This native does not have an official description.
---@param blip Blip
---@return boolean
function IsBlipAttachedToAnyEntity(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3CB8859F04763C78)  
---checks if the entity lockon prompt contains an icon
---@param entity Entity
---@param blip integer
---@return boolean
function IsBlipIconOnLockonEntityPrompt(entity, blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x46534526B9CD2D17)  
---This native does not have an official description.
---@param blip Blip
---@return boolean
function IsBlipOnMinimap(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF47A1EB2A538A3A3)  
---Checks if the GPS route to the waypoint is navigable along a road. If a route exists but there is no valid road path, this function returns false.
---@return boolean
function IsGpsRouteOnRoad() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x202B1BBFC6AB5EE4)  
---This native does not have an official description.
---@return boolean
function IsWaypointActive() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x0BFD145EF819FB3A)  
---Locks the minimap to the specified angle in integer degrees.
---
---angle: The angle in whole degrees. If less than 0 or greater than 360, unlocks the angle.
---@param angle integer
function LockMinimapAngle(angle) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6786D7AFAC3162B3)  
---This native does not have an official description.
---@param regionHash Hash | string
function MapDisableRegionBlip(regionHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xD8C7162AB2E2AF45)  
---This native does not have an official description.
---@param discoveryHash Hash | string
function MapDiscoverRegion(discoveryHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xDA98246C7A3C2189)  
---This native does not have an official description.
---@param discoveryHash Hash | string
function MapDiscoverySetEnabled(discoveryHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x563FCB6620523917)  
---regionHash: https://github.com/femga/rdr3_discoveries/tree/master/graphics/minimap/wanted_regions
---@param regionHash Hash | string
---@param styleHash Hash | string
function MapEnableRegionBlip(regionHash, styleHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3F81EA4275D39D6F)  
---This native does not have an official description.
---@param discoveryHash Hash | string
---@return boolean
function MapIsDiscoveryActive(discoveryHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xE38450DBCBC70E3D)  
---This native does not have an official description.
---@param regionHash Hash | string
---@param styleHash Hash | string
---@return boolean
function MapIsRegionHighlightedWithStyle(regionHash, styleHash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xD3F58E9316B7FC2A)  
---This native does not have an official description.
---@param p0 any
function N_0xd3f58e9316b7fc2a(p0) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF2C3C9DA47AAA54A)  
---This native does not have an official description.
---@param blip Blip
function RemoveBlip(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xBB68D4D3CA3DE402)  
---
---in the decompiles this doesnt seem to ever be executed the param needed needs to be above 0 but its always passed as 0
--- removes the icon from lockon prompt
---@param entity Entity
---@param p1 integer
function RemoveBlipIconFromEntityLockonPrompt(entity, p1) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xE057FEA9A22EB3EE)  
---This native does not have an official description.
---@param minimapProp Hash | string
function RemovePropFromMinimap(minimapProp) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xEB3CB3386C775D72)  
---This native does not have an official description.
---@param hash Hash | string
function ResetMinimapFow(hash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF8096DF9B87246E3)  
---This native does not have an official description.
---@param hash Hash | string
function RevealMinimapFow(hash) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4FF674F5E23D49CE)  
---This native does not have an official description.
---@param blip Blip
---@param posX number
---@param posY number
---@param posZ number
function SetBlipCoords(blip, posX, posY, posZ) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x0DF2B55F717DDB10)  
---_GET_BLIP_MAP_CARD_INFO this should be the name there is no flash timer for blips
---
---@param blip Blip
---@return boolean, integer p1, Hash p2
function SetBlipFlashes(blip) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x02FF4CF43B7209D1)  
---_SET_BLIP_MAP_CARD_INFO this should be the name there is no flash timer for blips
---blipType can be any number, but you can use blipTypes
---mapCardId joaat("SHOP_MOONSHINE_STILL") possibly to get the card info by this hash
---@param blip Blip
---@param blipType integer
---@param mapCardId Hash | string
function SetBlipFlashTimer(blip, blipType, mapCardId) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x1726963E6049DB53)  
---It adds blip a icon to active prompts like from scenarios or pickups without the need to use lockon
---@param entity Entity
---@param blipIcon Hash | string
function SetBlipIconOnEntityActivePrompt(entity, blipIcon) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x7563CBCA99253D1A)  
---will add a blip icon to the entity lockon prompt that you specify
---@param entity Entity
---@param blipIcon Hash | string
function SetBlipIconToLockonEntityPrompt(entity, blipIcon) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x9CB1A1623062F402)  
---This native does not have an official description.
---@param blip Blip
---@param name string
function SetBlipName(blip, name) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x0A062D6D7C0B2C2C)  
---This native does not have an official description.
---@param blip Blip
---@param textLabel string
function SetBlipNameFromTextFile(blip, textLabel) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x093DD5A31BC2B459)  
---This native does not have an official description.
---@param blip Blip
---@param player Player
function SetBlipNameToPlayerName(blip, player) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6049966A94FBE706)  
---This native does not have an official description.
---@param blip Blip
---@param rotation integer
function SetBlipRotation(blip, rotation) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xD38744167B2FA257)  
---only works for BLIP_ADD_FOR_RADIUS AND BLIP_ADD_FOR_AREA, this native works as a radius not really a scale
---@param blip Blip
---@param scale number
function SetBlipScale(blip, scale) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x74F74D3207ED525C)  
---This native does not have an official description.
---@param blip Blip
---@param hash Hash | string
---@param p2 boolean
function SetBlipSprite(blip, hash, p2) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x97F6F158CC5B5CA2)  
---adds the entity blip icon to the entity lockon prompt if wrong param will remove the icon if had any
---@param entity Entity
---@param blipId integer
function SetEntityBlipIconToLockonEntityPrompt(entity, blipId) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x63E7279D04160477)  
---Used for GUARMA MODE; Enabled: toggle = false, 0; Disabled: toggle = true, 0
---Hash p1 seems to be unused, always 0
---@param toggle boolean
---@param p1 Hash | string
function SetFowUpdatePlayerOverride(toggle, p1) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xF6CEF599FC470B33)  
---This native does not have an official description.
---@param p0 boolean
---@param p1 integer
---@param p2 integer
function SetGpsCustomRouteRender(p0, p1, p2) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x5DE61C90DDECFA2D)  
---https://alloc8or.re/rdr3/doc/enums/rage__eGpsFlags.txt
---@param p0 integer
---@param p1 number
function SetGpsFlags(p0, p1) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4426D65E029A4DC0)  
---This native does not have an official description.
---@param toggle boolean
function SetGpsMultiRouteRender(toggle) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xE5A7F70B7C0F3271)  
---This native does not have an official description.
---@param scale number
---@param p1 Hash | string
function SetMinimapFowOverrideRevealScale(scale, p1) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x73348402566ECB6E)  
---Up to eight coordinates may be revealed per frame
---@param x number
---@param y number
---@param z number
---@param p3 Hash | string
function SetMinimapFowRevealCoordinate(x, y, z, p3) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x63CBBD6CA6F321F9)  
---This native does not have an official description.
---@param volume Volume
---@param p1 Hash | string
function SetMinimapFowRevealVolume(volume, p1) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x632AA10BF7EA53D3)  
---This native does not have an official description.
---@param toggle boolean
---@param p1 Hash | string
function SetMinimapFowShouldUpdate(toggle, p1) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x4B8F743A4A6D2FF8)  
---Reveals the entire minimap (FOW = Fog of War)
---@param toggle boolean
function SetMinimapHideFow(toggle) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xA657EC9DBC6CC900)  
---hash can be the hash of "guarma" or "world".
---@param zone Hash | string
function SetMinimapZone(zone) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xE0884C184728C75B)  
---This native does not have an official description.
---@param x number
---@param y number
---@param z number
---@param radius number
function SetPausemapCoordsWithRadius(x, y, z, radius) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xA8EBBAE986FB5457)  
---This native does not have an official description.
function SetRadarAsExteriorThisFrame() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x9C113883487FD53C)  
---https://github.com/femga/rdr3_discoveries/blob/master/graphics/minimap/radar/radar_configs.lua
---configHash: -1943724816, 347777538, -117986897, -789269373, -547506804, -1986542417, 2080113112
---p1: usually 898171178 or 0 in R* scripts (doesn't seems to have any effect)
---@param configHash Hash | string
---@param p1 Hash | string
function SetRadarConfigType(configHash, p1) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xCAF6489DA2C8DD9E)  
---This native does not have an official description.
---@param zoomLevel integer
function SetRadarZoom(zoomLevel) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xFA8C41E8020D3439)  
---This native does not have an official description.
function SetWaypointOff() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3FBB838AEA30C1D8)  
---This native does not have an official description.
function ShowActivePointsOfInterest() end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6B44F13D888F770D)  
---This native does not have an official description.
---@param waypointRecording string
---@param point integer
---@param numPoints integer
---@param colorNameHash Hash | string
---@param p4 boolean
---@param p5 boolean
function StartGpsCustomRouteFromWaypointRecordingRoute(waypointRecording, point, numPoints, colorNameHash, p4, p5) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x3D3D15AF7BCAAF83)  
---This native does not have an official description.
---@param colorNameHash Hash | string
---@param onFoot boolean
---@param inVehicle boolean
function StartGpsMultiRoute(colorNameHash, onFoot, inVehicle) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x72DD432F3CDFC0EE)  
---This native does not have an official description.
---@param typeHash Hash | string
---@param x number
---@param y number
---@param z number
function TriggerSonarBlip(typeHash, x, y, z) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x0C7A2289A5C4D7C9)  
---This native does not have an official description.
---@param typeHash Hash | string
---@param entity Entity
function TriggerSonarBlipOnEntity(typeHash, entity) end

---**`MAP` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x5373DE8E179BC2A0)  
---This native does not have an official description.
function UnlockMinimapAngle() end

