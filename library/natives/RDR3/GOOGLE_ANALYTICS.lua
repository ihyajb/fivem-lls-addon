---@meta

---**`GOOGLE_ANALYTICS` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x87BBCC4360A9BDE3)  
---This native does not have an official description.
---@return boolean
function GoogleAnalyticsEndEvent() end

---**`GOOGLE_ANALYTICS` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xC6DE040378364798)  
---This native does not have an official description.
---@param pageName string
function GoogleAnalyticsPopPage(pageName) end

---**`GOOGLE_ANALYTICS` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xD43A616AE3AC4EF6)  
---This native does not have an official description.
---@param pageName string
function GoogleAnalyticsPushPage(pageName) end

---**`GOOGLE_ANALYTICS` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x1C54F031D7C0F7AC)  
---This native does not have an official description.
---@param eventCategory string
---@param eventAction string
---@param eventLabel string
---@param eventValue integer
---@return boolean
function GoogleAnalyticsStartEvent(eventCategory, eventAction, eventLabel, eventValue) end

