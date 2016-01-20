------------------------------------------->>
-- GTI-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: GTIevents
-- Type: Client Side
-- Author: ChicoGTI & RedBand
----------------------------------------->>

eventMax = 50000
warp_warpedUsers = {}
warp_savePos = {}
warp_warpLimit = 0
warp_warps = 0
warp_event = false
wapx, wapy, wapz = 0, 0, 0
warp_dimension = 0
warp_interior = 0
warp_wantedStarsLimit = 1
warp_allowMultiple = false
warp_vipOnly = false
forbidJobTeams = nil
jobTeams = {}
warp_freeze = false
local eventDimension = 336
clientFeatures = {}
eventDimFeatures = {}
booleanList = {}
peopleWhoCanUseEventJetpack = {}
local actionAmount = 27
for i=1,actionAmount do
    booleanList[i] = false
end
--- BOOLEANLIST INFO ---
--1 = Freeze players
--2 = Freeze vehicles
--3 = Lock vehicles
--4 = Disable falling from bike
--5 = Disable shooting
--6 = Not synced, useless
--7 = Disable player damage
--8 = Disable vehicle damage

function onResourceStart()
    for k, v in ipairs(getElementsByType("player")) do
        if (getElementData(v, "e")) then
            removeElementData(v, "e")
        end
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), onResourceStart)

addEvent("EMcheck", true)
addEventHandler("EMcheck", root,
function()
    if (isElement(client) and getElementType(client) == "player") then
        if (hasObjectPermissionTo(client, "command.eventm", false)) then
            triggerClientEvent(client, "showEMW", client, getVIPamount(), booleanList, warp_event, {warp_warps, warp_warpLimit})
        else
            outputChatBox("[ERROR] You are not an EM.", client, 255, 0, 0)
        end
    end
end)

function createEvent(player, limit, mul, vip, freeze, jtlist, forbid, pos)
    if (tonumber(limit)) then
        if (warp_event) then 
            outputChatBox("There is already an event going on. If this is an error, please hit stop event.", player, 255, 0, 0) 
            return 
        end
        wapx, wapy, wapz = pos[1], pos[2], pos[3]
        warp_dimension = pos[4]
        warp_interior = pos[5]
        warp_warpLimit = tonumber(limit)
        warp_warpedUsers = {}
        warp_savePos = {}
        warp_warps = 0
        warp_event = true
        warp_allowMultiple = mul
        warp_vipOnly = vip
        warp_freeze = freeze
        booleanList[1] = freeze
        forbidJobTeams = forbid
        jobTeams = jtlist
        if (tonumber(limit) > 0) then
            if (vip) then
                outputChatBox("A VIP only event has been created, type /eventwarp to be warped to the event ( limit: "..limit.." )", root, 0, 255, 0, true)
            else
                outputChatBox("An event has been created, type /eventwarp to be warped to the event ( limit: "..limit.." )", root, 0, 255, 0, true)
            end
        else
            outputChatBox("You've created a testing eventwarp, to add people to the event use /event add", player, 0, 255, 0, true)
        end
    end
end

function preCreateEvent(limit, mul, vip, freeze, jtlist, forbid)
    local x, y, z = getElementPosition(client)
    local dim = getElementDimension(client)
    local int = getElementInterior(client)
    outputChatBox("Warps will be enabled in 5 seconds", client, 0, 255, 0)
    setTimer(createEvent, 5000, 1, client, limit, mul, vip, freeze, jtlist, forbid, {x, y, z, dim, int})
end
addEvent("GTIevents.PreCreateEvent", true)
addEventHandler("GTIevents.PreCreateEvent", root, preCreateEvent)

function stopEvent(player)
    if (warp_event) then
        returnPlayersToLastLocation()
        warp_warpedUsers = {}
        warp_savePos = {}
        warp_warpLimit = 0
        warp_warps = 0
        warp_event = false
        warp_allowMultiple = false
        warp_vipOnly = false
        warp_freeze = false
        warp_aJT = nil
        warp_fJT = nil
        resetRaceStuff()
    end
end
addEvent("GTIevents.StopEvent", true)
addEventHandler("GTIevents.StopEvent", root, stopEvent)

function returnPlayersToLastLocation(player)
    if (player) then
        local accName = getAccountName(getPlayerAccount(player))
        if (not warp_savePos[accName]) then
            killPed(player)
            outputChatBox("Due to you not having a saved position, you have been killed instead", player, 0, 255, 255)
        else
            if (doesPedHaveJetPack(player)) then removePedJetPack(player) end
            if (isPedInVehicle(player)) then removePedFromVehicle(player) end
            local px, py, pz = warp_savePos[accName][1], warp_savePos[accName][2], warp_savePos[accName][3]
            local pint = warp_savePos[accName][4]
            local pdim = warp_savePos[accName][5]
            setElementInterior(player, pint)
            setElementPosition(player, px, py, pz)
            setElementDimension(player, pdim)
            toggleAllControls(player, true)
            removePlayerFromEvent(player)
            exports.GTIhud:dm("You have been returned to your previous position", player, 0, 255, 255)
        end
    else
        for k,v in ipairs(getEventParticipants()) do
            local accName = getAccountName(getPlayerAccount(v))
            if (not warp_savePos[accName]) then
                killPed(v)
                outputChatBox("Due to you not having a saved position, you have been killed instead", v, 0, 255, 255)
            else
                if (doesPedHaveJetPack(v)) then removePedJetPack(v) end
                if (isPedInVehicle(v)) then removePedFromVehicle(v) end
                local px, py, pz = warp_savePos[accName][1], warp_savePos[accName][2], warp_savePos[accName][3]
                local pint = warp_savePos[accName][4]
                local pdim = warp_savePos[accName][5]
                setElementInterior(v, pint)
                setElementPosition(v, px, py, pz)
                setElementDimension(v, pdim)
                toggleAllControls(v, true)
                removePlayerFromEvent(v)
                exports.GTIhud:dm("You have been returned to your previous position", v, 0, 255, 255)
            end
        end
    end
end

function addWarps(player, amount, mul, freeze, jtlist, forbid, pos)
    wapx, wapy, wapz = pos[1], pos[2], pos[3]
    warp_warpLimit = warp_warpLimit + amount
    warp_dimension = pos[4]
    warp_interior = pos[5]
    warp_allowMultiple = mul
    warp_vipOnly = vip
    warp_freeze = freeze
    booleanList[1] = freeze
    forbidJobTeams = forbid
    jobTeams = jtlist
    outputChatBox("There are "..amount.." warps remaining for the event, type /eventwarp to be warped to the event", root, 0, 255, 0)
end

function addMoreWarps(amount, mul, freeze, jtlist, forbid)
    if (amount) then
        if (warp_warps >= warp_warpLimit) then
            local x, y, z = getElementPosition(client)
            local dim = getElementDimension(client)
            local int = getElementInterior(client)
            outputChatBox("Warps will be enabled in 5 seconds", client, 0, 255, 0)
            setTimer(addWarps, 5000, 1, client, amount, mul, freeze, jtlist, forbid, {x, y, z, dim, int})
        else
            outputChatBox("You can only perform this action when the warp limit has been reached", client, 255, 0, 0)
        end
    end
end
addEvent("GTIevents.AddWarps", true)
addEventHandler("GTIevents.AddWarps", root, addMoreWarps)

function warpPerson(player)
    local team = getPlayerTeam(player)
    if (not team) then return end
    if (warp_event == false) then return end
    if (isPlayerInEvent(player) and warp_allowMultiple == false) then
        outputChatBox("You have already used /eventwarp", player, 0, 255, 0, true)
        return
    end
    
    if (exports.GTIpoliceArrest:isPlayerInPoliceCustody(player, true, true, true, true, true )) then
        exports.GTIhud:dm("You can't warp while in custody!", player, 255, 0, 0, true)
        return
    end
    if (exports.GTIpoliceWanted:isPlayerWanted(player)) then
        exports.GTIhud:dm("You can't warp while wanted!", player, 255, 0, 0, true)
        return
    end
    if not exports.GTIutil:isPlayerLoggedIn(player) then
        exports.GTIhud:dm("You have to login before you join an event!", player, 255, 0, 0, true)
        return
    end
    if isPedDead(player) then
        exports.GTIhud:dm("You can't warp while dead!", player, 255, 0, 0, true)
        return
    end
    local playerTeam = getTeamName(team)
    local playerJob = exports.GTIemployment:getPlayerJob(player)
    if (forbidJobTeams) or (forbidJobTeams == false) then
        if (forbidJobTeams) then
            for k,v in ipairs(jobTeams) do
                if (v == playerTeam) or (v == playerJob) then
                    exports.GTIhud:dm("Your team/job is not allowed to join this event", player, 255, 0, 0)
                    return
                end
            end
        elseif (forbidJobTeams == false) then
            for k,v in ipairs(jobTeams) do
                if (v == playerTeam) or (v == playerJob) then
                    break
                elseif (k == #jobTeams) then
                    exports.GTIhud:dm("Your team/job is not allowed to join this event", player, 255, 0, 0)
                    return
                end
            end
        end
    end
    if (tonumber(warp_warps) < tonumber(warp_warpLimit) and warp_event) then
        if (not getPedOccupiedVehicle(player)) then
            if (not isPlayerInEvent(player)) then
                local px, py, pz = getElementPosition(player)
                local pint, pdim = getElementInterior(player), getElementDimension(player)
                warp_savePos[getAccountName(getPlayerAccount(player))] = {px, py, pz, pint, pdim}
            end
            if (warp_interior == 0) then
                if (getElementInterior(player) ~= 0 ) then
                    setElementInterior(player, 0)
                end
                setElementPosition(player, wapx, wapy, wapz)
            else
                setElementInterior(player, warp_interior, wapx, wapy, wapz)
            end
            setElementDimension(player, warp_dimension)
            if (warp_freeze) then
                toggleAllControls(player, false)
                exports.GTIhud:dm("You have been Frozen. Please do not talk.", player, 0, 255, 255)
            end
            if (booleanList[11]) then
                givePedJetPack(player)
            else
                if (doesPedHaveJetPack(player)) then
                    removePedJetPack(player)
                end
            end
            addPlayerToEvent(player)
            warp_warps = warp_warps + 1
            if (tonumber(warp_warps) >= tonumber(warp_warpLimit)) then
                outputChatBox("The event is now full", root, 0, 255, 0, true)
            end
        end
    else
        outputChatBox("The event has reached the limit of " .. (warp_warpLimit) .. " warps", player, 0, 255, 0, true)
    end
end 
addCommandHandler("eventwarp", warpPerson)

function onAction(action, index, arg1, arg2)
    if (getElementDimension(client) == 336) then
        booleanList[index] = not booleanList[index]
        triggerClientEvent(client, "GTIevents.RefreshCData", client, booleanList)
        if (action == "TogglePlayerFreeze") then
            for k,v in ipairs(getEventParticipants()) do
                toggleAllControls(v, not booleanList[index])
            end
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm(getPlayerName(client).." has enabled player freezing", v, 255, 0, 0)
                else
                    exports.GTIhud:dm(getPlayerName(client).." has disabled player freezing", v, 0, 255, 0)
                end
            end
        elseif (action == "ToggleVehicleFreeze") then
            for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
                setElementFrozen(v, booleanList[index])
            end
            for k,v in ipairs(getElementsByType("player")) do
                if (getElementDimension(v) == 336) then
                    if (booleanList[index]) then
                        exports.GTIhud:dm("Event vehicles have been frozen by "..getPlayerName(client), v, 255, 0, 0)
                    else
                        exports.GTIhud:dm("Event vehicles have been unfrozen by "..getPlayerName(client), v, 0, 255, 0)
                    end
                end
            end
        elseif (action == "ToggleVehicleLock") then
            for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
                setElementData(v, "l", booleanList[index])
            end
            for k,v in ipairs(getElementsByType("player")) do
                if (getElementDimension(v) == 336) then
                    if (booleanList[index]) then
                        exports.GTIhud:dm("Event vehicles have been locked by "..getPlayerName(client), v, 255, 0, 0)
                    else
                        exports.GTIhud:dm("Event vehicles have been unlocked by "..getPlayerName(client), v, 0, 255, 0)
                    end
                end
            end
        elseif (action == "ToggleFallingFromBike") then
            clientFeatures[1] = booleanList[index]
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Falling from bike has been disabled by "..getPlayerName(client), v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Falling from bike has been enabled by "..getPlayerName(client), v, 255, 0, 0)
                end
            end
            sendClientFeatures()
        elseif (action == "ToggleShooting") then
            for k,v in ipairs(getEventParticipants()) do
                if (booleanList[index]) then
                    toggleControl(v, "fire", false)
                    toggleControl(v, "vehicle_fire", false)
                    toggleControl(v, "vehicle_secondary_fire", false)
                else
                    toggleControl(v, "fire", true)
                    toggleControl(v, "vehicle_fire", true)
                    toggleControl(v, "vehicle_secondary_fire", true)
                end
            end
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Weapon Fire has been disabled by " ..getPlayerName(client), v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Weapon Fire has been enabled by " ..getPlayerName(client), v, 255, 0, 0)
                end
            end
        elseif (action == "TogglePlayerDamage") then
            clientFeatures[2] = booleanList[index]
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Damage has been disabled by "..getPlayerName(client), v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Damage has been enabled by "..getPlayerName(client), v, 255, 0, 0)
                end
            end
            sendClientFeatures()
        elseif (action == "ToggleVehicleDamage") then
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Vehicle damage is now disabled", v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Vehicle damage is now enabled", v, 255, 0, 0)
                end
            end
        elseif (action == "FixEventVehicles") then
            for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
                fixVehicle(v)
            end
            for k,v in ipairs(getPlayersInEventDimension()) do
                exports.GTIhud:dm("Vehicles have been fixed by "..getPlayerName(client), v, 0, 255, 0)
            end
        elseif (action == "ToggleVehicleFlying") then
            clientFeatures[3] = booleanList[index]
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Vehicle flying is now enabled", v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Vehicle flying is now disabled", v, 255, 0, 0)
                end
            end
            sendClientFeatures()
        elseif (action == "GivePlayersJetpack") then
            for k,v in ipairs(getEventParticipants()) do
                if (booleanList[index]) then
                    givePedJetPack(v)
                    exports.GTIhud:dm("You have been given a jetpack by "..getPlayerName(client), v, 0, 255, 0)
                else
                    removePedJetPack(v)
                    exports.GTIhud:dm("Your jetpack has been removed by "..getPlayerName(client), v, 255, 0, 0)
                end
            end
        elseif (action == "ToggleVehicleRampSpawning") then
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Ramps enabled. Changes will be applied in new vehicles", v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Ramps disabled. Changes will be applied in new vehicles", v, 255, 0, 0)
                end
            end
        elseif (action == "WarpEventPlayersToEM") then
            for k,v in ipairs(getPlayersInEventDimension()) do
                exports.GTIhud:dm("Event players warped to "..getPlayerName(client), v, 0, 255, 255)
            end
            local x, y, z, dim, int = getElementPosition(client)
            local dim = getElementDimension(client)
            local int = getElementInterior(client)
            local r = getPedRotation(client)
            x = x - math.sin(math.rad(r)) * 2
            y = y + math.cos(math.rad(r)) * 2
            for k,v in ipairs(getEventParticipants()) do
                setElementPosition(v, x, y, z)
                setElementInterior(v, int)
                setElementDimension(v, dim)
            end
        elseif (action == "ToggleVehicleLeaving") then
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Vehicle leaving has been disabled", v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Vehicle leaving has been enabled", v, 255, 0, 0)
                end
            end
        elseif (action == "ToggleCollisions") then
            clientFeatures[4] = booleanList[index]
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Collisions are now disabled", v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Collisions are now enabled", v, 255, 0, 0)
                end
            end
            sendClientFeatures()
        elseif (action == "TogglePlayerWorking") then
            for k,v in ipairs(getEventParticipants()) do
                if (booleanList[index]) then
                --exports.GTIbusiness:editShiftStatusForEvents(v, false)
                else
                --exports.GTIbusiness:editShiftStatusForEvents(v, true)
                end
            end
        elseif (action == "ToggleWeapons") then
            clientFeatures[5] = booleanList[index]
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Weapons are now disabled", v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Weapons are now enabled", v, 255, 0, 0)
                end
            end
            sendClientFeatures()
        elseif (action == "ToggleVehicleHijacking") then
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Hijacking is now disabled", v, 0, 255, 0)
                else
                    exports.GTIhud:dm("Hijacking is now enabled", v, 255, 0, 0)
                end
            end
        elseif (action == "ToggleTeamKilling") then
            for k,v in ipairs(getPlayersInEventDimension()) do
                if (booleanList[index]) then
                    exports.GTIhud:dm("Team-killing is now disabled", v, 255, 0, 0)
                else
                    exports.GTIhud:dm("Team-killing is now enabled", v, 0, 255, 0)
                end
            end
            clientFeatures[6] = booleanList[index]
            sendClientFeatures()
        elseif (action == "ChangeWeather") then
            if (arg1 and tonumber(arg1)) then
                for k,v in ipairs(getPlayersInEventDimension()) do
                    exports.GTIhud:dm("Weather has been changed", v, 0, 255, 0)
                end
                eventDimFeatures[1] = arg1
                sendEventDimFeatures()
            end
        elseif (action == "ChangeWaveHeight") then
            if (arg1 and tonumber(arg1)) then
                for k,v in ipairs(getPlayersInEventDimension()) do
                    exports.GTIhud:dm("Wave height has been changed", v, 0, 255, 0)
                end
                eventDimFeatures[2] = arg1
                sendEventDimFeatures()
            end
        end
    else
        outputChatBox("You must be in event dimension to perform this action", client, 255, 0, 0)
    end
end
addEvent("GTIevents.Action", true)
addEventHandler("GTIevents.Action", root, onAction)

function onSingleAction(action, players, arg1, arg2)
    if (action == "FreezePlayer") then
        if (#players == 1) then
            if (isElement(players[1])) then
                if (isElementFrozen(players[1])) then
                    eventControl(client, "", "freeze", getPlayerName(players[1]), "off")
                else
                    eventControl(client, "", "freeze", getPlayerName(players[1]), "on")
                end
            end
        end
    elseif (action == "KickPlayer") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                if (isPlayerInEvent(v)) then
                    eventControl(client, "", "kick", getPlayerName(v))
                else
                    outputChatBox("Not processing "..getPlayerName(v).." because: Player is not in event", client)
                end
            end
        end
    elseif (action == "GiveCash") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                if (v ~= client) then 
                    if (isPlayerInEvent(v)) then
                        eventPay(client, "", getPlayerName(v), arg1, arg2)
                    else
                        outputChatBox("Not processing "..getPlayerName(v).." because: Player is not in event", client)
                    end
                else
                    outputChatBox("Not processing "..getPlayerName(v).." because: You can't give money to yourself..", client)
                end
            end
        end
    elseif (action == "ToggleEventJetpack") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                if (not canPlayerUseEventJetpack(v)) then
                    peopleWhoCanUseEventJetpack[v] = true
                    outputChatBox("You can now use /eventjetpack", v, 0, 255, 0)
                    outputChatBox(getPlayerName(v).." can now use /eventjetpack", client, 0, 255, 0)
                else
                    outputChatBox("Not processing "..getPlayerName(v).." because: Player already has access to /eventjetpack", client)
                end
            end
        end
    elseif (action == "ToggleJetpack") then
        if (#players == 1) then
            if (isElement(players[1])) then
                if (doesPedHaveJetPack(players[1])) then
                    removePedJetPack(players[1])
                else
                    givePedJetPack(players[1])
                end
            end
        end
    elseif (action == "SetHealth") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                setElementHealth(v, tonumber(arg1))
            end
        end
    elseif (action == "SetArmor") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                setPedArmor(v, tonumber(arg1))
            end
        end
    elseif (action == "ResendCF") then
        for k,v in ipairs(players) do
            if (isElement(v)) then
                if (isPlayerInEvent(v)) then
                    sendClientFeatures(v)
                else
                    outputChatBox("Not processing "..getPlayerName(v).." because: Player is not in event", client)
                end
            end
        end
    end
end
addEvent("GTIevents.SingleAction", true)
addEventHandler("GTIevents.SingleAction", root, onSingleAction)

function vehicleDamage()
    if (booleanList[8]) then
        if (isElement(source)) then
            setElementHealth(source, 1000)
        end
    end
end

function eventControl(player, _, arg, victim, bool)
    if (hasObjectPermissionTo(player, "command.givevehicle", false)) then
        local arg2 = victim
        if (victim) then
            victim = exports.GTIutil:findPlayer(victim)
        end
        if (arg == "dimension") then
            setElementDimension(player, eventDimension)
            exports.GTIhud:dm("Changed dimension to " .. eventDimension, player, 0, 255, 255)
            sendEventDimFeatures(player)
        elseif (arg == "norm") then
            setElementDimension(player, 0)
            exports.GTIhud:dm("Changed dimension to 0", player, 0, 255, 255)
            getNormalFeaturesState(player)
        elseif (arg == "return") then
            for a in pairs(getEventParticipants()) do
                if (isElement(a)) then
                    returnPlayersToLastLocation(a)
                end
            end
        elseif (arg == "freeze") then
            if (victim) then
                if (bool) then
                    if (tostring(bool) == "on") then
                        setElementFrozen(victim, true)
                        toggleAllControls (victim, false)
                        exports.GTIhud:dm(getPlayerName(victim).." has been frozen.", player, 0, 255, 0)
                        exports.GTIhud:dm("[Event Control] You have been frozen by "..getPlayerName(player)..".", victim, 0, 255, 255)
                    else
                        setElementFrozen(victim, false)
                        toggleAllControls (victim, true)
                        exports.GTIhud:dm(getPlayerName(victim).." has been unfrozen.", player, 0, 255, 0)
                        exports.GTIhud:dm("[Event Control] You have been unfrozen by "..getPlayerName(player)..".", victim, 0, 255, 255)
                    end
                else
                    exports.GTIhud:dm("You must specify 'on' or 'off'", player, 255, 0, 0)
                end
            end
        elseif (arg == "kick") then
            if (victim) then
                if (isPlayerInEvent(victim)) then
                    returnPlayersToLastLocation(victim)
                    exports.GTIhud:dm(getPlayerName(victim).." has been kicked from the event", player, 0, 255, 0)
                end
            end
        elseif (arg == "add") then
            if (victim) then
                if (not isPlayerInEvent(victim)) then
                    if (warp_event) then
                        if (warp_warps >= warp_warpLimit) then
                            addPlayerToEvent(victim)
                            removePedFromVehicle(victim)
                            removePedJetPack(victim)
                            local px, py, pz = getElementPosition(victim)
                            local pint, pdim = getElementInterior(victim), getElementDimension(victim)
                            warp_savePos[getAccountName(getPlayerAccount(victim))] = {px, py, pz, pint, pdim}
                            setElementPosition(victim, wapx, wapy, wapz)
                            setElementInterior(victim, warp_interior)
                            setElementDimension(victim, warp_dimension)
                            warp_warps = warp_warps + 1
                            warp_warpLimit = warp_warpLimit + 1
                            outputChatBox("Added "..getPlayerName(victim).." successfully to the event", player, 0, 255, 0)
                            exports.GTIhud:dm("You have been warped to the event by "..getPlayerName(player), victim, 0, 255, 255)
                        else
                            outputChatBox("You can only perform this action when the warp limit has been reached", player, 255, 0, 0)
                        end
                    else
                        outputChatBox("There isn't an event going on", player, 255, 0, 0)
                    end
                else
                    outputChatBox("This player is already in the event", player, 255, 0, 0)
                end
            end
        elseif (arg == "disable") then
            warp_warpLimit = warp_warps
            for k,v in ipairs(getPlayersInEventDimension()) do
                exports.GTIhud:dm("Event warps have been disabled by "..getPlayerName(player), v, 0, 255, 255)
            end
        elseif (arg == "startrace") then
            if (not arg2) then
                arg2 = 1
            end
            if (getElementDimension(player) == 336 and tonumber(arg2) and (tonumber(arg2) == 1 or tonumber(arg2) == 2)) then
                startRace(player, tonumber(arg2))
            end
        elseif (arg == "racewinners") then
            raceWinners(player, arg2)
        elseif (arg == "resendcf") then
            outputChatBox("Client features have been resent", player)
            sendClientFeatures()
        elseif (arg == "destroyall") then
            for k,v in pairs(Evehs) do
                if (isElement(v)) then
                    destroyElement(v)
                end
                if (isElement(eventMarker)) then
                    destroyElement(eventMarker)
                    eventMarker = nil
                    eventMarkerCreator = nil
                    eventVehicle = nil
                end
            end
            Evehs = {}
            for k,v in pairs(roadblocks) do
                if (isElement(v[1])) then
                    destroyElement(v[1])
                end
                roadblocks[k] = nil
            end
            positions = {}
            for plyr in pairs(raceCreators) do
                triggerClientEvent(plyr, "GTIevents.UpdateMarkers", plyr, positions, markerType, markerSize)    
            end
            for i=1,actionAmount do
                booleanList[i] = false
            end
            destroyAllPickups()
            eventDimFeatures = {}
            clientFeatures = {}
        elseif (arg == "epd") then
            if (pickupDestroyers[getPlayerAccount(player)]) then
                pickupDestroyers[getPlayerAccount(player)] = nil
                outputChatBox("Pickup destroy disabled", player)
            else
                pickupDestroyers[getPlayerAccount(player)] = true
                outputChatBox("All the pickups you hit will be destroyed", player)
            end
        elseif (arg == "destroypickups") then
            destroyAllPickups()
            outputChatBox("All pickups have been destroyed", player)
        elseif (arg == "size") then
            local eventString = getEventString(player, {true, true, true, true})
            outputChatBox("Current event size: "..exports.GTIutil:tocomma(math.floor(#eventString))..", max: "..exports.GTIutil:tocomma(maxSize).." ("..math.floor((#eventString / maxSize) * 100).."% used)", player)
        end
    end
end
addCommandHandler("event", eventControl)

function getVIPamount()
    local VIPC = 0
    for k, v in ipairs(getElementsByType("player")) do
    --if (exports.GTIvip:isPlayerVIP(v)) then
    -- VIPC = VIPC + 1
            --end
    end
    return VIPC
end

peopleTable = {}
countdown = false
function startCountdown(player, command, count)
    if (hasObjectPermissionTo(player, "command.givevehicle", false)) then
        if (countdown == false) then
            peopleTable = {}
            countdown = true
        if (not tonumber(count)) then
            count = 5
        end
            for _,v in ipairs(getElementsByType("player")) do
                if (getElementDimension(v) == getElementDimension(player) and getElementInterior(v) == getElementInterior(player)) then
                    table.insert(peopleTable, v)
                end
            end
            setTimer(showText, 1000, 1, count)
        end
    end
end
addCommandHandler("countd", startCountdown)

function showText(counting)
    if (counting == 0) then
        textItem = "GO"
    else
        textItem = tostring(counting)
    end
    for _,v in ipairs(peopleTable) do
        if (isElement(v)) then
            exports.GTIhud:dm(textItem, v, math.random(255), math.random(255), math.random(255))
        end
    end
    if (counting == 0) then countdown = false counting = counting return end
    setTimer(showText, 1000, 1, counting-1)
end

function onPlayerLogin()
    if (isPlayerInEvent(source)) then
        if (getElementDimension(source) == warp_dimension) then
            triggerClientEvent(source, "GTIevents.ToggleClientFeature", source, clientFeatures)
            if (booleanList[11]) then
                givePedJetPack(source)
            end
            setElementData(source, "e", true)
        else
            removePlayerFromEvent(source)
        end
    end
    if (getElementDimension(source) == 336) then
        sendEventDimFeatures(source)
    end
end
addEventHandler("onPlayerLogin", root, onPlayerLogin)

function onPlayerQuit()
    if (isPlayerInEvent(source)) then
        if (getElementDimension(source) ~= warp_dimension) then
            removePlayerFromEvent(source)
        end
    end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

function onPlayerWasted()
    if (isPlayerInEvent(source)) then
        toggleAllControls(source, true)
        removePlayerFromEvent(source)
    end
end
addEventHandler("onPlayerWasted", root, onPlayerWasted)

function addPlayerToEvent(player)
    if (isElement(player)) then
        if (warp_dimension == 336) then
            sendClientFeatures(player)
            sendEventDimFeatures(player)
        end
        setElementData(player, "e", true)
        warp_warpedUsers[getAccountName(getPlayerAccount(player))] = true
    end
end

function sendClientFeatures(player)
    if (player and isElement(player)) then
        triggerClientEvent(player, "GTIevents.ToggleClientFeature", player, clientFeatures)
    else
        for k,v in ipairs(getEventParticipants()) do
            triggerClientEvent(v, "GTIevents.ToggleClientFeature", v, clientFeatures)
        end
    end
end

function sendEventDimFeatures(player)
    if (player and isElement(player)) then
        triggerClientEvent(player, "GTIevents.SendEventDimFeature", player, eventDimFeatures)
    else
        for k,v in ipairs(getPlayersInEventDimension()) do
            triggerClientEvent(v, "GTIevents.SendEventDimFeature", v, eventDimFeatures)
        end
    end
end

function getEventParticipants()
    local pTable = {}
    local index = 0
    for acc in pairs(warp_warpedUsers) do
        if (getAccountPlayer(getAccount(acc))) then
            index = index + 1
            pTable[index] = getAccountPlayer(getAccount(acc))
        end
    end
    return pTable
end

function removePlayerFromEvent(player)
    if (isElement(player)) then
        if (isPlayerInEvent(player)) then
            warp_warpedUsers[getAccountName(getPlayerAccount(player))] = nil
            warp_savePos[getAccountName(getPlayerAccount(player))] = nil
            triggerClientEvent(player, "GTIevents.ToggleClientFeature", player, {})
            getNormalFeaturesState(player)
            if (booleanList[11]) then
                removePedJetPack(player)
            end
            if (booleanList[18]) then
                setElementCollisionsEnabled(player, true)
            end
            removeElementData(player, "e")
        end
    end
end

function isQuitJobDisabledForEvents()
    return booleanList[14]
end

function isEndShiftDisabledForEvents()
    return booleanList[15]
end

function isPlayerInEvent(player)
    if (warp_event) then
        for k,v in ipairs(getEventParticipants()) do
            if (v == player) then
                return true
            end
        end
    end
    return false
end

function cmd_leaveEvent(player)
    if (isPlayerInEvent(player)) then
        returnPlayersToLastLocation(player)
    else
        outputChatBox("You are not in a event", 255, 0, 0)
    end
end
addCommandHandler("leaveevent", cmd_leaveEvent)

function canPlayerUseEventJetpack(player)
    if (getTeamName(getPlayerTeam(player)) == "Government") or (isPlayerInEvent(player) and booleanList[11]) or (peopleWhoCanUseEventJetpack[player]) then
        return true
    end
    return false
end

function cmd_eventjetpack(player)
    if (isGuestAccount(getPlayerAccount(player))) then return end
    if (doesPedHaveJetPack(player)) then
        removePedJetPack(player)
        return
    end
    if (getElementDimension(player) ~= 336) then return end
    if (canPlayerUseEventJetpack(player)) then
        if (not doesPedHaveJetPack(player)) then
            givePedJetPack(player)
        end
    end
end
addCommandHandler("eventjetpack", cmd_eventjetpack)

function requestEventDimFeatures()
    triggerClientEvent(client, "GTIevents.SendEventDimFeature", client, eventDimFeatures)
end
addEvent("GTIevents.GetEventDimFeatures", true)
addEventHandler("GTIevents.GetEventDimFeatures", root, requestEventDimFeatures)

function getNormalFeaturesState(player)
    triggerClientEvent(client or player, "GTIevents.RemoveEventDimFeatures", client or player, {getWeather(), getWaveHeight()})
end
addEvent("GTIevents.GetNormalFeaturesState", true)
addEventHandler("GTIevents.GetNormalFeaturesState", root, getNormalFeaturesState)

function getPlayersInEventDimension()
    local dim = 336
    local dimTable = {}
    for i, players in ipairs (getElementsByType("player")) do
        local dimension = getElementDimension(players)
        if dimension == dim then
            table.insert(dimTable, players)
        end
    end
    if (#dimTable == 0) then return false
    else return dimTable 
    end
end