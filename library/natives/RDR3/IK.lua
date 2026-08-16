---@meta

---**`IK` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x6098139150DCC745)  
---Get the ped ik activity state.
---@param ped Ped
---@param ik integer
---@return boolean
function InverseKinematicsIsActive(ped, ik) end

---**`IK` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x0B9F7A01EC50448D)  
---Make the ped point at with arms, must be called every frame.
---@param ped Ped
---@return any parameters
function InverseKinematicsPointAt(ped) end

---**`IK` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x66F9EB44342BB4C5)  
---This native does not have an official description.
---@param ped Ped
---@return any args
function InverseKinematicsRequestLookAt(ped) end

---**`IK` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x0EABF182FBB63D72)  
---Seems to disable IK on ped
---@param ped Ped
---@param p1 integer
---@param p2 boolean
function InverseKinematicsSetDisabledForPed(ped, p1, p2) end

---**`IK` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x873C792E07A32C8B)  
---This native does not have an official description.
---@param ped1 Ped
---@param ped2 Ped
function N_0x873c792e07a32c8b(ped1, ped2) end

