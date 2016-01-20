------------------------------------------->>
-- GTI-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: GTIevents
-- Type: Client Side
-- Author: ChicoGTI & RedBand
----------------------------------------->>

roadblocks = {}
local port = getServerPort()

function spawnRoadblock(id, x, y, z, rx, ry, rz, dim, int)
    if (hasObjectPermissionTo(client, "command.rb", false)) then
        if (not id) then return end
        if (id == 1225 and dim == 0) then
            outputChatBox("Explosive barrels can not be placed in main dimension", client, 255, 0, 0)
            return
        end
        if (id == 978) then
            z = z-1
        end
        local accName = getAccountName(getPlayerAccount(client))
        local object = createObject(tonumber(id), x, y, z, rx, ry, rz)
        setElementDoubleSided(object, true)
        setElementFrozen(object, true)
        setElementData(object, "creator", accName, false)
        roadblocks[object] = {object, getAccountName(getPlayerAccount(client))}
        if (tonumber(dim) ~= 0) then
            setElementDimension(object, dim)
        end
        if (tonumber(int) ~= 0) then
            setElementInterior(object, int)
        end
        if (id ~= 1225) then
            triggerClientEvent(client, "nobreak", client, object)
        end
    end
end
addEvent("GTIevents.RB.AddRoadblock", true)
addEventHandler("GTIevents.RB.AddRoadblock", root, spawnRoadblock)

function spawnRBVehicle(id, x, y, z, rx, ry, rz, dim, int, color)
    if (hasObjectPermissionTo(client, "command.rb", false)) then
        local accName = getAccountName(getPlayerAccount(client))
        createEventVehicle(id, x, y, z, rx, ry, rz, dim, int, accName, color)
    end
end
addEvent("GTIevents.RB.SpawnVeh", true)
addEventHandler("GTIevents.RB.SpawnVeh", root, spawnRBVehicle)

function command_rbc(player)
    if (hasObjectPermissionTo(player, "command.rb", false)) then
        local count = 0
        for k,v in pairs(roadblocks) do
            if (isElement(v[1])) then
                count = count + 1
            end
        end
        outputChatBox("Total roadblocks: "..count, player)
    end
end
addCommandHandler("rbc", command_rbc)

function destroyRoadblocks()
    for k, v in pairs(roadblocks) do
        if (v[2] == getAccountName(getPlayerAccount(client))) then
            if (isElement(v[1])) then
                destroyElement(v[1])
                v = nil
            end
        end
    end
    exports.GTIhud:drawNote("YourRBsDel", "Your roadblocks have been deleted", client, 255, 0, 0, 2000)
end
addEvent("GTIevents.RB.DestroyRoadblocks", true)
addEventHandler("GTIevents.RB.DestroyRoadblocks", root, destroyRoadblocks)

function destroyRoadblock(rb)
    local creator, x, y, z, dim, int, id
    for k, v in pairs(roadblocks) do
        if (v[1] == rb) then
            x, y, z = getElementPosition(v[1])
            dim = getElementDimension(v[1])
            int = getElementInterior(v[1])
            id = getElementModel(v[1])
            destroyElement(v[1])
            creator = v[2]
            v[1] = nil
        end
    end
    if (client) then
        exports.GTIhud:drawNote("YourRBDel", "Roadblock deleted", client, 255, 0, 0, 2000)  
        if (creator) then
        end
    end
end
addEvent("GTIevents.RB.DestroyRoadblock", true)
addEventHandler("GTIevents.RB.DestroyRoadblock", root, destroyRoadblock)

function destroyALLRoadblocks()
    for k, v in pairs(roadblocks) do
        destroyElement(v[1])
    end
    roadblocks = {}
    exports.GTIhud:drawNote("RBsDel", "All roadblocks have been deleted", client, 255, 0, 0, 2000)
end
addEvent("GTIevents.RB.DestroyALLRoadblocks", true)
addEventHandler("GTIevents.RB.DestroyALLRoadblocks", root, destroyALLRoadblocks)

function roadblockDestroyed()
    if (roadblocks[source]) then roadblocks[source] = nil end
end
addEventHandler("onElementDestroy", root, roadblockDestroyed)

local adminLvl = 2
function checkLVL()
    if (isElement(client) and getElementType(client) == "player") then
        if (hasObjectPermissionTo(client, "command.rb", false)) then
            triggerClientEvent(client, "showRB", client)
        end
    end
end
addEvent("GTIevents.RB.CheckAdminLevel", true)
addEventHandler("GTIevents.RB.CheckAdminLevel", root, checkLVL)

function destroyVehViaRB(vehicle)
    if (hasObjectPermissionTo(client, "command.rb", false)) then
        if (isElement(vehicle)) then
            destroyElement(vehicle)
        end
    end
end
addEvent("GTIevents.RB.DestroyVeh", true)
addEventHandler("GTIevents.RB.DestroyVeh", root, destroyVehViaRB)