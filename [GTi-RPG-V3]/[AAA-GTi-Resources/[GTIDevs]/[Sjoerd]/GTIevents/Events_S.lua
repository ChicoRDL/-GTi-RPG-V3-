------------------------------------------->>
-- GTI-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: GTIevents
-- Type: Client Side
-- Author: ChicoGTI & RedBand
----------------------------------------->>

Evehs = {}
occupiedEvehs = {}
eventMarker = nil
eventMarkerCreator = nil
eventVehicle = nil
local HPM = nil
local SM = nil
locked = false
local randomMarker = nil
local randomBlipMarker = nil
local eventJetpackEnabled = false
local spawnerCreator = nil

function eventmarker(player, command, r, g, b, blip)
    local access = hasObjectPermissionTo(player, "command.givevehicle", false)
    if (not access) then return end
    if (randomMarker and randomBlipMarker) then outputChatBox("There is already an event marker spawned.", player, 255, 0, 0) return end
    if (not tonumber(r)) then
        r, g, b = math.random(255), math.random(255), math.random(255)
    end
    if (not tonumber(blip)) then
        blip = 49
    end
    local x, y, z = getElementPosition(player)
    local dim, int = getElementDimension(player), getElementInterior(player)
    randomMarker = createMarker(x, y, z - 1, "checkpoint", 2, r, g, b, 150, root)
    randomBlipMarker = createBlip(x, y, z, blip, 2)
    setElementInterior(randomMarker, int)
    setElementDimension(randomMarker, dim)
    if (isElement(randomBlipMarker)) then
        setElementInterior(randomBlipMarker, int)
        setElementDimension(randomBlipMarker, dim)
    end
    exports.GTIhud:dm("Event Marker created.", player, 0, 255, 0)
end
addCommandHandler("addmarker", eventmarker)

function eventmarker(player, command)
    local access = hasObjectPermissionTo(player, "command.givevehicle", false)
    if (not access) then return end
    if (isElement(randomMarker)) or (isElement(randomMarker)) then
        if (isElement(randomMarker)) then destroyElement(randomMarker) end
        if (isElement(randomBlipMarker)) then destroyElement(randomBlipMarker) end
        randomMarker = nil
        randomBlipMarker = nil
        exports.GTIhud:dm("Event Marker deleted.", player, 0, 255, 0)
    else
        exports.GTIhud:dm("There is nothing to destroy", player, 0, 255, 0)
    end
end
addCommandHandler("delmarker", eventmarker)

function spawnEventMarker(player, command, r, g, b, ...)
    local access = hasObjectPermissionTo(player, "command.givevehicle", false)
    if (not access) then return end
    local arg1 = table.concat({...}, " ")
    if (not r) then outputChatBox("Please use /addem R G B VEHICLE", player, 255, 0, 0) return end
    if (not tonumber(r) and not tonumber(g) and not tonumber(b)) then
        if (tostring(r) and tostring(g) and tostring(b)) then
            if (tostring (r) ~= "r" and tostring (g) ~= "r" and tostring (b) ~= "r") then
                outputChatBox("To use a random color please use r r r", player, 255, 0, 0)
                return
            end
        end
        r, g, b = math.random(255), math.random(255), math.random(255)
    end
    if (eventMarker) then
        exports.GTIhud:dm("An event marker is already spawned, check with "..tostring(eventMarkerCreator).." to make sure you can destroy it", player, 255, 0, 0)
        return false
    end
    if (not arg1 or not getVehicleModelFromName(arg1)) then
        exports.GTIhud:dm("Specify a vehicle name to spawn!", player, 255, 0, 0)
        return false
    end
    local x, y, z = getElementPosition(player)
    local dim = getElementDimension(player)
    local int = getElementInterior(player)
    eventMarker = createMarker(x, y, z - 1, "cylinder", 2, tonumber(r), tonumber(g), tonumber(b), 200, root)
    setElementData(eventMarker, "rgb", r..","..g..","..b)
    setElementInterior(eventMarker, int)
    setElementDimension(eventMarker, dim)
    eventMarkerCreator = getPlayerName(player)
    spawnerCreator = getAccountName(getPlayerAccount(player))
    eventVehicle = getVehicleModelFromName(arg1)
    addEventHandler("onMarkerHit", eventMarker, givePlayerVehicle)
    exports.GTIhud:dm("You have created an event Marker.", player, 0, 255, 0)
end
addCommandHandler("addem", spawnEventMarker)

function removeEventStuff()
    if (eventMarker) then
        destroyElement(eventMarker)
        eventMarker = nil
        eventMarkerCreator = nil
        eventVehicle = nil
        exports.GTIhud:dm("Marker destroyed!", client, 0, 255, 0)
    else
        if (Evehs) then
            for ind, veh in pairs(Evehs) do
                if (isElement(veh) and getElementType(veh) == "vehicle") then
                    local driver = getVehicleController(veh)
                    if (driver and isElement(driver)) then
                        exports.GTIhud:dm("Event vehicles destroyed by "..getPlayerName(client), driver, 255, 0, 0)
                    end
                    destroyElement(veh)
                end
            end
            Evehs = {}
        end
    end
end
addEvent("GTIevents.DelVehStuff", true)
addEventHandler("GTIevents.DelVehStuff", root, removeEventStuff)

function givePlayerVehicle(player, sameDim)
    if (not eventVehicle) then return end
    if (sameDim and player and isElement(player) and getElementType(player) == "player" and not isPedInVehicle(player)) then
        local x, y, z = getElementPosition(player)
        local int = getElementInterior(player)
        local dim = getElementDimension(player)
        local rot = getPedRotation(player)
        local color
        local rgb = getElementData(eventMarker, "rgb")
        if (rgb) then
            color = split(rgb, string.byte(","))
        end
        local veh = createEventVehicle(eventVehicle, x, y, z, 0, 0, rot, dim, int, spawnerCreator, color)
        warpPedIntoVehicle(player, veh)
    end
end

function createEventVehicle(id, x, y, z, rx, ry, rz, dim, int, creator, color)
    local vehicle = createVehicle(id, x, y, z, rx, ry, rz)
    if (vehicle) then
        setElementDimension(vehicle, dim)
        setElementInterior(vehicle, int)
        setElementData(vehicle, "creator", creator, false)
        setElementData(vehicle, "l", booleanList[3])
        if (booleanList[13]) then
            local ramp = createObject(1634, x, y, z)
            setElementDimension(ramp, dim)
            setElementInterior(ramp, int)
            attachElements(ramp, vehicle, 0, 7, -1.5 , 0, 0, 180)
            addEventHandler("onElementDestroy", vehicle, function() destroyElement(ramp) end)
        end
        addEventHandler("onVehicleDamage", vehicle, vehicleDamage)
        addEventHandler("onVehicleStartExit", vehicle, vehHijackExit)
        addEventHandler("onVehicleStartEnter", vehicle, vehHijackEnter)
        Evehs[#Evehs + 1] = vehicle
        -- Fuel Export here
        exports.GTIfuel:setVehicleFuel(vehicle, 100)
        if (color) then
            setVehicleColor(vehicle, color[1] or 255, color[2] or 255, color[3] or 255, color[4] or 255, color[5] or 255, color[6] or 255, color[7] or 255, color[8] or 255, color[9] or 255, color[10] or 255, color[11] or 255, color[12] or 255)
        end
        return vehicle
    end
end

function vehHijackEnter(ePlayer, seat, jacked)
    if (booleanList[22] and isPlayerInEvent(ePlayer)) then
        if (jacked) then
            cancelEvent()
        end
    end
end

function vehHijackExit(ePlayer, seat)
    if (booleanList[17] and isPlayerInEvent(ePlayer)) then
        cancelEvent()
    end
end

function fixall(player, command)
    if (hasObjectPermissionTo(player, "command.givevehicle", false)) then
        if (Evehs) then
            for ind, veh in pairs(Evehs) do
                if (isElement(veh)) then
                    fixVehicle(veh)
                end
            end
            exports.GTIhud:drawNote("FixAll", "Vehicles Fixed", player, 255, 0, 0, 3000)
        end
    end
end
addCommandHandler("fixall", fixall)

function upgradeC(player, command)
    if (hasObjectPermissionTo(player, "command.givevehicle", false)) then
        if (Evehs) then
            for ind, veh in pairs(Evehs) do
                if (isElement(veh)) then
                    addVehicleUpgrade(veh, 1010)
                end
            end
            exports.GTIhud:drawNote("VehNitro", "Vehicles now have NITRO", player, 255, 0, 0, 3000)         
        end
    end
end
addCommandHandler("vehnitro", upgradeC)

function vehiclec(player, command)
    if (hasObjectPermissionTo(player, "command.givevehicle", false)) then
        if (Evehs) then
            if (#Evehs == 1) then
                outputChatBox("(EVENT) There is "..tonumber(#Evehs).." vehicle currently spawned up.", player, 0, 255, 255)
            elseif (#Evehs > 1) then
                outputChatBox("(EVENT) There are "..tonumber(#Evehs).." vehicles currently spawned up.", player, 0, 255, 255)
            elseif (#Evehs < 1) then
                outputChatBox("(EVENT) There are no vehicles currently spawned up.", player, 0, 255, 255)
            end
        end
    end
end
addCommandHandler("vc", vehiclec)

addEvent("eventDim", true)
addEventHandler("eventDim", root, 
    function()
        if (isElement(client)) then
            local dim = getElementDimension(client)
            if (dim ~= 336) then
                setElementDimension(client, 336)
                exports.GTIhud:dm( "Your dimension was set to 336", client, 255, 120, 0)
                sendEventDimFeatures(player)
            elseif (dim == 336) then
                setElementDimension(client, 0)
                exports.GTIhud:dm("Your dimension was set to 0", client, 255, 120, 0)
                getNormalFeaturesState(player)
            end
        end
    end
)

function eventPay(source, command, player, amount, ...)
    local access = hasObjectPermissionTo(source, "command.givevehicle", false)
    if (access and getTeamName(getPlayerTeam(source)) == "Government" and getElementDimension(source) == 336) then
        if (not ...) then outputChatBox("You must include a reason.", source, 255, 0, 0) return end
        local reason = table.concat({...}," ")
        if (tonumber(amount) and tonumber(amount) <= eventMax) then
            local player = exports.GTIutil:findPlayer(player)
            if ((player) and isElement(player) and isPlayerInEvent(player)) then
                if (getElementDimension(player) == 336 and player ~= source) then
                --- Money Part - Important CODE | DO NOT FORGOT TO ENABLE&CHANGE LOG EXPORT HERE
                    -- exports.GTIlogs:logSomething("(EM) "..getPlayerName(source).." has given "..getPlayerName(player).." $"..tonumber(amount).." for reason: "..reason..".", "admin", source, player)
                    exports.GTIhud:dm(getPlayerName(source).." has given you $"..tonumber(amount).." for reason: "..reason..".", player, 0, 255, 0)
                    exports.GTIbank:GPM(player, amount, reason, false)
                    exports.GTIhud:dm("You have given "..getPlayerName(player).." $"..tonumber(amount).." for reason: "..reason..".", source, 0, 255, 0)
                else
                    outputChatBox("Either you tried to use it on yourself or the player is not in the event dimension.", source, 255, 0, 0)
                end
            else
                outputChatBox("That player is not in the event.", source, 255, 0, 0)
            end
        else
            outputChatBox("You can only pay up to "..eventMax.." at a time.", source, 255, 0, 0)
        end
    end
end
addCommandHandler("gcash", eventPay)

function setint(source, command, int, x, y, z)
    if (hasObjectPermissionTo(source, "command.givevehicle", false)) then
        if (tonumber(int) and tonumber(x) and tonumber(y) and tonumber(z)) then
            setElementInterior(source, tonumber(int))
            setElementPosition(source, tonumber(x), tonumber(y), tonumber(z))
        end
    end
end
addCommandHandler("eint", setint)

function vehiclesCheck()
    for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
        if (isVehicleBlown(v)) then
            destroyElement(v)
        end
    end
end
setTimer(vehiclesCheck, 5000, 0)