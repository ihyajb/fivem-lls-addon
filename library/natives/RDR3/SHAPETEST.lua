---@meta

---**`SHAPETEST` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xEDE8AC7C5108FB1D)  
---Returns the result of a shape test: 0 if the handle is invalid, 1 if the shape test is still pending, or 2 if the shape test has completed, and the handle should be invalidated.
---
---When used with an asynchronous shape test, this native should be looped until returning 0 or 2, after which the handle is invalidated.
---
---enum eShapeTestStatus
---{
---	SHAPETEST_STATUS_NONEXISTENT,
---	SHAPETEST_STATUS_RESULTS_NOTREADY,
---	SHAPETEST_STATUS_RESULTS_READY
---};
---@param shapeTestHandle ScrHandle
---@return integer, boolean hit, vector3 endCoords, vector3 surfaceNormal, Entity entityHit
function GetShapeTestResult(shapeTestHandle) end

---**`SHAPETEST` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x04AA59CA40571C2E)  
---This native does not have an official description.
---@param p0 any
---@param p1 any
---@return any
function N_0x04aa59ca40571c2e(p0, p1) end

---**`SHAPETEST` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x377906D8A31E5586)  
---Does the same as 0x7EE9F5D83DD4F90E, except blocking until the shape test completes.
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@param flags integer
---@param entityToIgnore Entity
---@param p8 integer
---@return ScrHandle
function StartExpensiveSynchronousShapeTestLosProbe(x1, y1, z1, x2, y2, z2, flags, entityToIgnore, p8) end

---**`SHAPETEST` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xFE466162C4401D18)  
---This native does not have an official description.
---@param posX number
---@param posY number
---@param posZ number
---@param dimensionsX number
---@param dimensionsY number
---@param dimensionsZ number
---@param rotX number
---@param rotY number
---@param rotZ number
---@param rotationOrder integer
---@param flags integer
---@param entityToIgnore Entity
---@param options integer
---@return ScrHandle
function StartShapeTestBox(posX, posY, posZ, dimensionsX, dimensionsY, dimensionsZ, rotX, rotY, rotZ, rotationOrder, flags, entityToIgnore, options) end

---**`SHAPETEST` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x28579D1B8F8AAC80)  
---This native does not have an official description.
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@param radius number
---@param flags integer
---@param entityToIgnore Entity
---@param p9 integer
---@return ScrHandle
function StartShapeTestCapsule(x1, y1, z1, x2, y2, z2, radius, flags, entityToIgnore, p9) end

---**`SHAPETEST` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x7EE9F5D83DD4F90E)  
---Asynchronously starts a line-of-sight (raycast) world probe shape test.
---
---Use the handle with 0x3D87450E15D98694 or 0x65287525D951F6BE until it returns 0 or 2.
---
---p8 is a bit mask with bits 1, 2 and/or 4, relating to collider types; 4 should usually be used. flags used are mostly 83 and 3167 
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@param flags integer
---@param entity Entity
---@param p8 integer
---@return ScrHandle
function StartShapeTestLosProbe(x1, y1, z1, x2, y2, z2, flags, entity, p8) end

---**`SHAPETEST` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0x9839013D8B6014F1)  
---Old name: _START_SHAPE_TEST_SURROUNDING_COORDS
---@param flag integer
---@param entity Entity
---@param flag2 integer
---@return ScrHandle, vector3 pVec1, vector3 pVec2
function StartShapeTestMouseCursorLosProbe(flag, entity, flag2) end

---**`SHAPETEST` `client`**  
---[Native Documentation](https://rdr3natives.com/?native=0xAA5B7C8309F73230)  
---This native does not have an official description.
---@param x1 number
---@param y1 number
---@param z1 number
---@param x2 number
---@param y2 number
---@param z2 number
---@param radius number
---@param flags integer
---@param entity Entity
---@param p9 any
---@return ScrHandle
function StartShapeTestSweptSphere(x1, y1, z1, x2, y2, z2, radius, flags, entity, p9) end

