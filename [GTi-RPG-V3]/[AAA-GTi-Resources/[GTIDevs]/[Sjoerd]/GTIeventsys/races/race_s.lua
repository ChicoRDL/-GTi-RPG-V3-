positions = {}
winners = {}
raceParticipants = {}
raceCreators = {}
markerType = "checkpoint"
markerSize = 10
raceType = 1
raceStarted = false

function addMarker(player)
    if (hasObjectPermissionTo(player, "command.eventm", false)) then
        if (getElementDimension(player) == 802) then
            if (not raceStarted) then
                local x, y, z = getElementPosition(player)
                table.insert(positions, {math.floor(x), math.floor(y), math.floor(z)})
                outputChatBox("Coordinates taken, total markers: "..#positions, player)
                for plyr in pairs(raceCreators) do
                    triggerClientEvent(plyr, "GTIeventsys.AddCheck", plyr, {#positions, x, y, z}, markerType, markerSize)
                end
            else
                exports.GTIhud:dm("You can't use this when a race is going on", 255, 0, 0)
            end
        end
    end
end
addCommandHandler("addcheck", addMarker)

function startRace(player, mode)
    if (getElementDimension(player) == 802) then
        if (eventOn) then
            if (not raceStarted) then
                raceStarted = true
                raceType = mode
                for k,v in ipairs(getEventParticipants()) do
                    raceParticipants[v] = true
                    triggerClientEvent(v, "GTIeventsys.CreateRaceStuff", v, positions, markerType, markerSize, raceType)
                end
                outputChatBox("Markers should now be created for all players. Using racemode: "..raceType, player, 0, 255, 0)
            else
                outputChatBox("There's a race going on", player, 255, 0, 0)
            end
        else
            outputChatBox("There must be an active event to start the race", player, 255, 0, 0)
        end
    end
end

function preStartRace(player, _, arg)
    if (getElementDimension(player) == 802) then 
        if (not arg2) then
            arg2 = 1
        end
        startRace(player, 1)
        raceHolder = player
    end
end
addCommandHandler("startrace", preStartRace, true)
    
local raceHolder = nil

function onPlayerQuit()
    if (raceParticipants[source]) then
        raceParticipants[source] = nil
    end
    if (raceCreators[source]) then
        raceCreators[source] = nil
    end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

function resetRaceStuff()
    for player in pairs(raceParticipants) do
        if (player) then
            triggerClientEvent(player, "GTIeventsys.DestroyRaceStuff", player)
        end
    end
    raceParticipants = {}
    positions = {}
    winners = {}
    raceStarted = false  
end

function stopRace(p)
    if (not raceStarted) then return end
    if ( exports.GTIutil:isPlayerInACLGroup(p, "Event1", "Admin2", "Admin3", "Admin4", "Admin5", "Dev5", "Dev1" ) ) then
        for player in pairs(raceParticipants) do
            if (player) then
                triggerClientEvent(player, "GTIeventsys.DestroyRaceStuff", player)
            end
        end
        raceParticipants = {}
        positions = {}
        winners = {}
        raceStarted = false
        exports.GTIhud:dm("You stopped the race.", p, 255, 0, 0)
    end    
end
addCommandHandler("stoprace", stopRace)

function setWinner()
    if (not winners[1]) then 
        if (raceType == 1) then
            outputEventPlayers(getPlayerName(client).." has won the race!")
            outputChatBox(getPlayerName(client).." has won the race!", raceHolder, 255, 0, 125)
            raceHolder = nil
            setTimer(resetRaceStuff, 60000, 1)
        else
            outputEventPlayers(getPlayerName(client).." has won!")
            outputChatBox(getPlayerName(client).." has won the race!", raceHolder, 255, 0, 125)
            raceHolder = nil
        end
    end
    table.insert(winners, getAccountName(getPlayerAccount(client)))
end
addEvent("GTIeventsys.SetRaceWinner", true)
addEventHandler("GTIeventsys.SetRaceWinner", root, setWinner)

function raceWinners(src, amount)
    if (hasObjectPermissionTo(src, "command.eventm", false)) then
        if (winners[1]) then
            if (not tonumber(amount)) then
                outputChatBox("Syntax: /event racewinners [1-"..#winners.."]", src)
                return
            end
            outputChatBox("Place: Ingame Name (Account Name)", src)
            for i=1, tonumber(amount) do
                if (winners[i]) then
                    local player = getAccountPlayer(getAccount(winners[i]))
                    local playerName = "Player Offline"
                    if (player) then
                        playerName = getPlayerName(player)
                    end
                    outputChatBox(i..": "..playerName.." ("..winners[i]..")", src)
                end
            end
        else
            outputChatBox("No winners or race hasn't started", src)
        end
    end
end

function delCheck(player)
    if (hasObjectPermissionTo(player, "command.eventm", false)) then
        if (getElementDimension(player) == 802) then
            if (#positions > 0) then
                positions[#positions] = nil
                outputChatBox("Check "..(#positions + 1).." has been deleted", player)
                for plyr in pairs(raceCreators) do
                    triggerClientEvent(plyr, "GTIeventsys.DelPrevCheck", plyr)    
                end
            end
        end
    end
end
addCommandHandler("delcheck", delCheck)

function showChecks(player)
    if (hasObjectPermissionTo(player, "command.eventm", false)) then
        if (getElementDimension(player) == 802) then
            if (raceCreators[player]) then
                raceCreators[player] = nil
                outputChatBox("showchecks: false", player)
                triggerClientEvent(player, "GTIeventsys.UpdateMarkers", player, {})
            else
                raceCreators[player] = true
                outputChatBox("showchecks: true", player)
                triggerClientEvent(player, "GTIeventsys.UpdateMarkers", player, positions, markerType, markerSize)
            end
        end
    end
end
addCommandHandler("showchecks", showChecks)

function deleteAllChecks(player)
    if (hasObjectPermissionTo(player, "command.eventm", false)) then
        if (getElementDimension(player) == 802) then
            outputChatBox("All checkpoints were deleted", player)
            positions = {}
            for plyr in pairs(raceCreators) do
                triggerClientEvent(player, "GTIeventsys.DestroyRaceStuff", player)
            end
        end
    end
end
addCommandHandler("delallchecks", deleteAllChecks)

function updateChecks(player)
    if (hasObjectPermissionTo(player, "command.eventm", false)) then
        if (getElementDimension(player) == 802) then
            for plyr in pairs(raceCreators) do
                triggerClientEvent(plyr, "GTIeventsys.UpdateMarkers", plyr, positions, markerType, markerSize)    
            end
        end
    end
end
addCommandHandler("updatechecks", deleteAllChecks)

function rmsize(player, _, size)
    if (hasObjectPermissionTo(player, "command.eventm", false)) then
        if (getElementDimension(player) == 802) then
            if (size and tonumber(size) and tonumber(size) <= 50) then
                markerSize = size
                for plyr in pairs(raceCreators) do
                    triggerClientEvent(plyr, "GTIeventsys.UpdateMarkers", plyr, positions, markerType, markerSize)    
                end
                exports.GTIhud:dm("Marker size set to "..size, player, 0, 255, 0)
            else
                exports.GTIhud:dm("Syntax is: /rmtype [1-50] Current marker size: "..markerSize, player, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("rmsize", rmsize)

function rmtype(player, _, mtype)
    if (hasObjectPermissionTo(player, "command.eventm", false)) then
        if (getElementDimension(player) == 802) then
            if (mtype and (mtype == "checkpoint" or mtype == "ring")) then
                markerType = mtype
                for plyr in pairs(raceCreators) do
                    triggerClientEvent(plyr, "GTIeventsys.UpdateMarkers", plyr, positions, markerType, markerSize)    
                end
                exports.GTIhud:dm("Marker type set to "..mtype, player, 0, 255, 0)
            else
                exports.GTIhud:dm("Syntax is: /rmtype [checkpoint - ring] Current marker type: "..markerType, player, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("rmtype", rmtype)