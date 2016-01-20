local mtimer
local timer
local eventRunning = false
local currentEvent = false
local currentResource = false
local lastEvent = false
local blip
local atroll

addEvent("onCnREventStart", true)
addEvent("onCnREventStop", true)
addEvent("onCnRPointEnter", true)
addEvent("onCnRPointLeave", true)

local teams = {}
local killed = {}
local takeBank = {}
local captured = {}

local eventMax = false
local int, dim = 0, 0

local pause = 60 -- In CMinutes

local epCount = 0
local alarm = ""

eData = {
    warps = {},
    data = {},
    entry = {},
    markers = {},
    blips = {},
}

events = {
    --{ Name, Abbreviation}
    [1] = { "Airport Bomber", "GTIap"},
    [2] = { "Caligula's Casino Robbery", "GTIccr"},
    [3] = { "LS Police Raid", "GTIpdr"}
    --[3] = { "A-Test Event", "GTIatest"},
}

function readCNRSettings(theReadingFile)
    --local settings, exenp, points = exports.eRes:getEventDetails()
    --local settings, exenp, points = call(cnrRes, "getEventDetails")
    local settings, exenp, warps, points, objects, blippos = exports[theReadingFile]:getEventDetails()

    local bdata = split(blippos, ",")
    local bX, bY, bZ = bdata[1], bdata[2], bdata[3]

    if not isElement(blip) then
        blip = createBlip(bX, bY, bZ, 25, 2, 255, 0, 0, 255, 0, 450)
    end

    --Manage Settings
    local name = settings[1]
    local timer_time = settings[2]
    local max_plr = settings[3]
    local inte = settings[4]
    local dime = settings[5]

    local alarm_loc = settings[6]

    currentEvent = name
    eventMax = max_plr
    int = inte
    dim = dime
    alarm = alarm_loc

    if getServerPort() ~= 22003 then
        cnrst = 1
    else
        cnrst = timer_time
    end
    timer = setTimer(startEvent, cnrst*60000, 1)
    mtimer = setTimer(function() end, 60000, cnrst)
    if cnrst > 1 then
        exports.killmessages:outputMessage(currentEvent.." will start in "..cnrst.." minutes", root, 25, 255, 25)
    else
        exports.killmessages:outputMessage(currentEvent.." will start in "..cnrst.." minute", root, 25, 255, 25)
    end
    if not isTimer(eDTimer) then
        eDTimer = setTimer(isEventDone, 2500, 0)
    end

    -- Create Anti-Troll Zones
    if not isElement(atroll) then
        atroll = createColCircle(bX, bY, 25)
    end
    -- Create Entrances/Exits
    for i, entex in ipairs (exenp) do
        local x, y, z = entex[1], entex[2], entex[3]

        local worldtag = split(entex[4], ";")
        local enint = worldtag[1]
        local endim = worldtag[2]

        local entype = split(entex[5], ";")
        local en1 = entype[1]
        local lock = entype[2]

        local marker = createMarker(x, y, z+2, "arrow", 1.5, 255, 0, 0, 150)
        epCount = epCount + 1

        setElementInterior(marker, enint)
        setElementDimension(marker, endim)

        eData.entry["marker."..i] = createColTube(x, y, z, 1.25, 2)

        eData.data["marker."..i] = marker
        setElementInterior(eData.entry["marker."..i], enint)
        setElementDimension(eData.entry["marker."..i], endim)

        --setElementData(eData.entry["marker."..i], "binded", marker)
        setElementData(eData.entry["marker."..i], "etype", en1)
        setElementData(eData.entry["marker."..i], "lock", lock)
        setElementData(eData.entry["marker."..i], "name", "marker."..i)
        --eData.entry.data[i] = marker

        addEventHandler("onColShapeHit", eData.entry["marker."..i], colHit)

        setEntryStatus("marker."..i, true)
    end
    --
    -- Create Warps
    for i, warp in ipairs (warps) do
        local x, y, z = warp[1], warp[2], warp[3]
        local warpdata = split(warp[5], ";")
        local w1 = warpdata[1]
        local w2 = warpdata[2]
        if not eData.warps[w1] then
            eData.warps[w1] = {}
        end
        eData.warps[w1][w2] = x..";"..y..";"..z..";"..warp[4]
        --table.insert(eData.warps, { warp[4], x..";"..y..";"..z})
    end
    -- Create Points
    for i, point in ipairs (points) do
        local x, y, z = point[1], point[2], point[3]
        local marker = createMarker(x, y, z, "cylinder", 1.5, 255, 255, 255, 150)

        eData.markers[i] = createColTube(x, y, z, 1.25, 2)
        setElementInterior(eData.markers[i], int)
        setElementDimension(eData.markers[i], dim)
        setElementData(eData.markers[i], "point", true)
        if point[4] then
            setElementData(eData.markers[i], "pointData", point[4])
        end

        eData.data[eData.markers[i]] = marker
        captured[eData.markers[i]] = nil

        addEventHandler("onColShapeHit", eData.markers[i], pointHit)
        addEventHandler("onColShapeLeave", eData.markers[i], pointLeave)

        eData.blips[eData.markers[i]] = createBlipAttachedTo(marker, 0, 1, 255, 255, 255, 255, 0, 400)
        setElementInterior(marker, int)
        setElementDimension(marker, dim)
    end
end

function getEntryStatus(entrance)
    if type(entrance) == "string" then
    else
        if isElement(entrance) then
            if getElementData(entrance, "CnRopen") then
                local status = getElementData(entrance, "CnRopen") or false
                if status then
                    return true
                else
                    return false
                end
            else
                return false
            end
        else
            return false
        end
    end
end

function setEntryStatus(entrance, status)
    if isElement(eData.entry[entrance]) then
        local marker = eData.data[entrance]
        local _, _, _, alpha = getMarkerColor(marker)
        if status then
            setMarkerColor(marker, 0, 255, 0, alpha)
            setElementData(marker, "CnRopen", true)
        else
            setMarkerColor(marker, 255, 0, 0, alpha)
            setElementData(marker, "CnRopen", false)
        end
    end
end

function prepareEvent(theEvent, prepType, eMax)
    if not currentEvent then
        if prepType == "prestart" then
            eventMax = eMax
        elseif prepType == "start" then
        end
    end
end

function startEvent()
    for i = 0, epCount do
        if isElement(eData.entry["marker."..i]) then
            setEntryStatus("marker."..i, false)
        end
    end
    triggerEvent("onCnREventStart", root, currentEvent)
    eventRunning = true
    for i, player in ipairs (getElementsByType("player")) do
        if teams["law"][player] or teams["crim"][player] or teams["medic"][player] then
            totalKills[player] = 0
            --outputChatBox("You would be charged now by me", player, 255, 255, 0)
            if getPlayerEventSide(player) ~= "medic" then
                exports.GTIpoliceWanted:chargePlayer(player, 23)
            end
            triggerClientEvent(player, "GTIcnr.startAlarm", player, alarm_loc, dim)
            killed[player] = false
        end
    end
    if teams["crim"]["count"] == 0 and teams["law"]["count"] == 0 then
        endEvent()
    end
end

function endEvent()
    triggerEvent("onCnREventStop", root, currentEvent)
    if isTimer(timer) then
        killTimer(timer)
    end
    --[[
    table.sort(totalKills)
    for i, v in pairs(totalKills) do
        outputDebugString(getPlayerName(i)" : "..v)
    end
    --]]
    totalKills = {}
    --if is
    timer = nil
    eventRunning = false
    currentEvent = false
    lastEvent = false
    if isElement(blip) then
        destroyElement(blip)
    end
    blip = nil
    if isElement(atroll) then
        destroyElement(atroll)
    end
    atroll = nil

    teams = {}
    captured = {}

    eData.warps = {}
    eData.data = {}
    eData.entry = {}
    eData.markers = {}
    eventMax = false



    if currentResource and getResourceFromName(currentResource) and getResourceState(getResourceFromName(currentResource)) == "running" then
        stopResource(getResourceFromName(currentResource))
    end
    --restartResource(getResourceFromName("GTIcnr"))
    cycleEvent()
end

allowed_teams = {
    ["Criminals"] = true,
    ["General Population"] = true,
    ["Law Enforcement"] = true,
    ["Emergency Services"] = true,
}

allowed_jobs = {
    ["Criminal"] = true,
    ["Police Officer"] = true,
    ["Paramedic"] = true,
}

function isPlayerInCnREvent(element)
    --if eventRunning then
        if teams["law"] and teams["crim"] and teams["medic"] then
            if teams["law"][element] or teams["crim"][element] or teams["medic"][element] then
                return true
            else
                return false
            end
        else
            return false
        end
    --else
        --return false
    --end
end

function isPlayerInCnRArea(element)
    if isElement(atroll) then
        if isElementWithinColShape(element, atroll) then
            return true
        else
            return false
        end
    else
        return false
    end
end

function addCount(element, eTeam)
    if not teams[eTeam] then
        teams[eTeam] = {}
        teams[eTeam]["count"] = 0
    end
    if not teams[eTeam][element] then
        teams[eTeam][element] = true
        teams[eTeam]["count"] = teams[eTeam]["count"]+1
    end
end

function didPlayerDieInEvent(element)
    if killed[element] then
        return true
    else
        return false
    end
end

function takeCount(element, eTeam, reason)
    if takeBank[element] then
        takeBank[element] = nil
    end
    if not teams[eTeam] then
        teams[eTeam] = {}
        teams[eTeam]["count"] = 0
    end
    if teams[eTeam][element] then
        teams[eTeam][element] = false
        teams[eTeam]["count"] = teams[eTeam]["count"]-1
    end
    if (teams["law"]["count"] == 0 and teams["crim"]["count"] == 0 and eventRunning) then
        endEvent()
    end
end

local wC = {
    ["Law Enforcement"] = "law",
    ["Criminals"] = "crim",
    ["General Population"] = "crim",
    ["Emergency Services"] = "medic",
}

local wA = {
    ["law"] = "Police",
    ["crim"] = "Criminals",
}

totalKills = {}

function playerKilled(ammo, attacker)
    if isElement(attacker) then
        if isPlayerInCnREvent(source) and isPlayerInCnREvent(attacker) then
            local aside = getPlayerEventSide(attacker)
            local sside = getPlayerEventSide(source)
            totalKills[attacker] = totalKills[attacker] + 1
            if aside == "law" then
                addMoneyToScore(attacker, 5000)
            elseif aside == "crim" then
                addMoneyToScore(attacker, 2500)
            end
            warp_player(source, "killed", sside)
            
                -- CnR Event Stats -->>
            exports.GTIstats:modifyPlayerStatData(attacker, "cnrKills", 1)
            exports.GTIstats:modifyPlayerStatData(source, "cnrDeaths", 1)
            if (aside == "law") then
                exports.GTIstats:modifyPlayerStatData(attacker, "kill_police_cnr", 1)
            else
                exports.GTIstats:modifyPlayerStatData(attacker, "kill_criminal_cnr", 1)
            end
                -- End CnR Event Stats -->>
                if teams["crim"]["count"] == 0 or teams["law"]["count"] == 0 then
                    if (currentEvent == "Airport Bomber") then
                        if (exports.GTIap:isBombExploded()) then
                            for i, v in ipairs(getElementsByType("player")) do
                                if (isPlayerInCnREvent(v)) then
                                    local sside = getPlayerEventSide(v)
                                    warp_player(v, "ended", sside)
                                end
                            end    
                            endEvent()
                        end    
                    end
                end
            --emptyMoneyBank(source)
            if takeBank[source] and takeBank[source] ~= 0 then
                exports.GTIbank:GPM(source, takeBank[source], "CnR: Money won from various tasks.")
            end
        end
    else
        local side = getPlayerEventSide(source)
        warp_player(source, "killed", side)
        --emptyMoneyBank(source)
        if takeBank[source] and takeBank[source] ~= 0 then
            exports.GTIbank:GPM(source, takeBank[source], "CnR: Money won from various tasks.")
        end
    end
end
addEventHandler("onPlayerWasted", root, playerKilled)

addEventHandler("onPlayerJailed", root,
    function()
        if isPlayerInCnREvent(source) then
            local etype = getPlayerEventSide(source)
            takeCount(source, etype)
        end
    end
)

addEventHandler("onPlayerCommand", root,
    function(cmd)
        if isPlayerInCnREvent(source) then
            local side = getPlayerEventSide(source)
            if cmd == "turf" then
                warp_player(source, "kicked", side)
            elseif cmd == "criminal" then
                if side == "medic" then
                    warp_player(source, "kicked", side)
                end
            end
        end
    end
)

function onQuit()
    if isPlayerInCnREvent(source) then
        local etype = getPlayerEventSide(source)
        takeCount(source, etype)
    end
end

function warp_player(element, mtype, wtype)
    if isElement(element) then
        if mtype ~= "killed" and mtype ~= "kicked" then
            if eData.warps[mtype][wtype] then
                local pos = split(eData.warps[mtype][wtype], ";")
                local rotZ = pos[4]
                local x, y, z = pos[1], pos[2], pos[3]
                local rx, ry, rz = getElementRotation(element)
                setElementPosition(element, x, y, z+0.50)
                setElementRotation(element, rx, ry, rotZ)
                setElementInterior(element, int)
                setElementDimension(element, dim)
            end
            if mtype == "enter" then
                addCount(element, wtype)
                setPedWeaponSlot(element, 0)    -- Stop Players entering with Taser/Nightstick
            elseif mtype == "leave" then
                takeCount(element, wtype)
                setElementInterior(element, 0)
                setElementDimension(element, 0)
            elseif mtype == "ended" then
                takeCount(element, wtype)
                setElementInterior(element, 0)
                setElementDimension(element, 0)
                if (currentEvent == "Airport Bomber") then
                    local x, y, z = exports.GTIap:getStartPoint()
                    setElementPosition(element, x, y, z)
                end    
            end
        else
            if mtype == "killed" then
                if takeBank[element] and takeBank[element] ~= 0 then
                    exports.GTIbank:GPM(element, takeBank[element], "CnR: Money won from various tasks.")
                --else
                    --exports.GTIbank:GPM(element, 1000, "CnR: Money won from participation.")
                end
                local side = getPlayerEventSide(element)
                if side == "law" then
                    exports.GTIhud:dm("You failed to help stop criminal advancement.", element, 255, 0, 0)
                elseif side == "crim" then
                    exports.GTIhud:dm("You failed to help complete the event.", element, 255, 0, 0)
                end
                takeCount(element, wtype)
            elseif mtype == "kicked" then
                --[[
                if eData.warps[mtype][wtype] then
                    local pos = split(eData.warps[mtype][wtype], ";")
                    local rotZ = pos[4]
                    local x, y, z = pos[1], pos[2], pos[3]
                    local rx, ry, rz = getElementRotation(element)
                    setElementPosition(element, x, y, z+0.50)
                    setElementRotation(element, rx, ry, rotZ)
                    setElementInterior(element, 0)
                    setElementDimension(element, 0)
                end
                --]]
                setElementHealth(element, 0)
                takeCount(element, wtype)
                exports.GTIhud:dm("You were kicked from the CnR Event.", element, 255, 0, 0)
            end    
        end
    end
end

function showCnRPlayers()
    for i,player in ipairs(getElementsByType("player")) do
        if (isElement(player)) then
            --if teams[player] then
            if isPlayerInCnREvent(player) then
                local side = getPlayerEventSide(player)
                if isPlayerInCnREvent(player) and not didPlayerDieInEvent(player) then

                    exports.GTIhud:drawStat("lawcount", "Police", teams["law"]["count"].."/"..eventMax, player, 77, 77, 255)
                    exports.GTIhud:drawStat("mediccount", "Medics", teams["medic"]["count"], player, 153, 255, 255)
                    exports.GTIhud:drawStat("crimcount", "Criminals", teams["crim"]["count"].."/"..eventMax, player, 255, 77, 77)

                    if eventRunning then
                        if teams["law"][player] then
                            exports.GTIhud:drawStat("CnRearning", "Recovered", "$"..(takeBank[player] or 0), player, 51, 153, 51)
                        elseif teams["crim"][player] then
                            exports.GTIhud:drawStat("CnRearning", "Taken", "$"..(takeBank[player] or 0), player, 51, 153, 51)
                        end
                    end
                    -- Show Timer
                    if isTimer(timer) then
                        local milliSecs = getTimerDetails(timer)
                        local secs, a, b = getTimerDetails(mtimer)
                        local sec = math.ceil(secs/1000)
                        if (sec <= 9) then sec = "0"..sec end
                        local min = math.ceil(milliSecs/(60*1000))
                        --local sec = math.ceil(milliSecs/1000)

                        exports.GTIhud:drawStat("eventStarting", "Event Starting in: ", (min-1)..":"..sec, player, 120, 120, 120)
                    else
                        exports.GTIhud:drawStat("eventStarting", "", "", player, 120, 120, 120)
                    end
                end
            else
                exports.GTIhud:drawStat("lawcount", "", "", player, 77, 77, 255)
                exports.GTIhud:drawStat("mediccount", "", "", player, 153, 255, 255)
                exports.GTIhud:drawStat("crimcount", "", "", player, 255, 77, 77)
                exports.GTIhud:drawStat("eventStarting", "", "", player, 120, 120, 120)
                exports.GTIhud:drawStat("CnRearning", "", "", player, 51, 153, 51)
            end
        end
    end
end
setTimer(showCnRPlayers, 1000, 0)

function joinEvent(hitElement)
    if isElement(hitElement) and getElementType(hitElement) == "player" then
        if isPedInVehicle(hitElement) then
            exports.GTIhud:dm("Please leave your current vehicle before trying to enter the event.", hitElement, 255, 0, 0)
            return
        end
        local team = getPlayerTeam(hitElement)
        local team = getTeamName(team)
        if allowed_teams[team] then
            local job = exports.GTIemployment:getPlayerJob(hitElement, true)
            if allowed_jobs[job] then
                if not didPlayerDieInEvent(hitElement) then
                    if job == "Police Officer" then
                        warp_player(hitElement, "enter", "law")
                        --outputChatBox("You're a cop, check done", hitElement, 255, 255, 0)
                    elseif job == "Criminal" then
                        warp_player(hitElement, "enter", "crim")
                        --outputChatBox("You're a crim, check done", hitElement, 255, 255, 0)
                    elseif job == "Paramedic" then
                        warp_player(hitElement, "enter", "medic")
                        --outputChatBox("You're a medic, check done", hitElement, 255, 255, 0)
                    end
                else
                    exports.GTIhud:dm("You did not successfully complete this event. Wait till you're allowed to attend another event.", hitElement, 255, 0, 0)
                end
            else
        if not job then
            warp_player(hitElement, "enter", "crim")
        return end
                exports.GTIhud:dm("Your current job doesn't permit you to join the event.", hitElement, 255, 0, 0)
            end
        else
            exports.GTIhud:dm("Your current team doesn't permit you to join the event.", hitElement, 255, 0, 0)
        end
    end
end

function getPlayerEventSide(theElement)
    if isElement(theElement) and isPlayerInCnREvent(theElement) then
        local team = getPlayerTeam(theElement)
        local team = getTeamName(team)
        local side = wC[team]
        if side then
            return side
        else
            return false
        end
    else
        return false
    end
end

function colHit(hitElement, matching)
    local name = getElementData(source, "name")
    local marker = eData.data[name]

    --if isElement(hitElement) and matching then
    if hitElement and isElement(hitElement) and getElementType(hitElement) == "player" and matching then
        if getEntryStatus(marker) then
            local etype = getElementData(source, "etype")
            local lock = getElementData(source, "lock")
            if etype == "enter" then
                if not eventRunning then
                    local team = getPlayerTeam(hitElement)
                    local team = getTeamName(team)
                    local team = wC[team]
                    if team then
                        if lock == "all" then
                            joinEvent(hitElement)
                        else
                            if lock == team then
                                joinEvent(hitElement)
                            else
                                if lock == "law" and team == "medic" then
                                    joinEvent(hitElement)
                                elseif lock == "crim" and team == "medic" then
                                    joinEvent(hitElement)
                                else
                                    if lock == "law" then
                                        exports.GTIhud:dm("You can only join an event if you are a Law or Medic.", hitElement, 255, 0, 0)
                                    elseif lock == "crim" then
                                        exports.GTIhud:dm("You can only join an event if you are a Criminal or Medic.", hitElement, 255, 0, 0)
                                    end
                                end
                            end
                        end
                    else
                        if not isTimer(ct1) then
                            exports.GTIhud:dm("Your current team doesn't permit you to join the event.", hitElement, 255, 0, 0)
                            ct1 = setTimer(function() end, 1000, 1)
                        end
                    end
                else
                    exports.GTIhud:dm("The event is already in progress. You were too late.", hitElement, 255, 0, 0)
                end
            elseif etype == "leave" then
                local tcL = getPlayerEventSide(hitElement)
                if tcL then
                    --emptyMoneyBank(hitElement)
                    if eventRunning then
                        --if takeBank[hitElement] and takeBank[hitElement] ~= 0 then
                        local extraM = tonumber(takeBank[hitElement]) or 0
                        if getPlayerEventSide(hitElement) and getPlayerEventSide(hitElement) == "crim" then
                            exports.GTIcriminals:modifyPlayerCriminalRep(hitElement, 2500, "CnR Robbery")
                            exports.GTIcriminals:modifyPlayerTaskProgress(hitElement, "CnR Robbery", 1)
                            exports.GTIbank:modifyPlayerBankBalance(hitElement, extraM, "CnR: Extra Money Won from participation")
                            exports.GTIbank:GPM(hitElement, 10000, "CnR: Successfully Completed Event")
                            exports.GTIdrugsv2:givePlayerDrug(hitElement, "Cocaine", 25)
                            exports.GTIhud:drawNote("cnrDrugNote", "Cocaine +25", hitElement, 255, 255, 255, 7500)
                        elseif getPlayerEventSide(hitElement) and getPlayerEventSide(hitElement) == "law" then
                            exports.GTIbank:GPM(hitElement, 10000, "CnR: Successfully Completed Event")
                            exports.GTIbank:modifyPlayerBankBalance(hitElement, extraM, "CnR: Extra Money Won from participation")
                        end
                        takeBank[hitElement] = 0
                        --else
                            --exports.GTIbank:GPM(hitElement, 10000, "CnR: Successfully Completed Event")
                        --end
                    end
                    warp_player(hitElement, "leave", tcL)
                    if eventRunning then
                        if teams["crim"]["count"] == 0 and teams["law"]["count"] == 0 then
                            endEvent()
                        end
                    end
                else
                    warp_player(hitElement, "leave", "law")
                end
            end
        else
            exports.GTIhud:dm("This entrypoint is currently disabled.", hitElement, 255, 0, 0)
        end
    end
end

function outputToParticipants(text, n)
    for i, player in ipairs (getElementsByType("player")) do
        if isPlayerInCnREvent(player) then
            if n then
                if not notified[player] then
                    exports.GTIhud:dm(text, player, 255, 0, 0)
                    notified[player] = true
                end
            else
                if not isTimer(antispam) then
                    exports.GTIhud:dm(text, player, 255, 0, 0)
                    antispam = setTimer(function() end, 1500, 1)
                end
            end
        end
    end
end

function addMoneyToScore(theElement, theMoney)
    if not takeBank[theElement] and type(takeBank[theElement]) ~= "number" then
        takeBank[theElement] = 0
    end
    takeBank[theElement] = takeBank[theElement] + theMoney
end

function emptyMoneyBank(theElement)
    if takeBank[theElement] and takeBank[theElement] ~= 0 then
        exports.GTIbank:GPM(theElement, takeBank[theElement], "CnR: Money Earned from completing various tasks.")
        takeBank[theElement] = 0
    end
end

notified = {}
ed = true

function isEventDone()
    local cols = 0
    local capt = 0
    for i, col in ipairs (getElementsByType("colshape", resourceRoot)) do
        if getElementData(col, "point") then
            cols = cols + 1
            if captured[col] then
                capt = capt + 1
            end
        end
    end
    if cols == capt then
        for i = 0, epCount do
            if isElement(eData.entry["marker."..i]) then
                --if not getEntryStatus("marker."..i) then
                    setEntryStatus("marker."..i, true)
                    outputToParticipants("The event is now complete, please exit the event to earn money.", true)
                    if teams["crim"]["count"] == 0 and teams["law"]["count"] == 0 then
                        if ed then
                            endEvent()
                            ed = false
                        end
                        if isTimer(eDTimer) then
                            killTimer(eDTimer)
                        end
                    end
                --end
            end
        end
    else
        if teams["crim"]["count"] ~= 0 or teams["law"]["count"] ~= 0 then
            for i = 0, epCount do
                setEntryStatus("markers."..i)
            end
        end
    end
    cols = 0
    capt = 0
end
eDTimer = setTimer(isEventDone, 2500, 0)

function capturePoint(thePoint, theElement)
    if isElement(thePoint) and eData.data[thePoint] then
        local marker = eData.data[thePoint]
        local r, g, b, a = getMarkerColor(marker)
        if isElement(theElement) and isPlayerInCnREvent(theElement) then
            if eventRunning then
                if not captured[thePoint] then
                    local side = getPlayerEventSide(theElement)
                    local money = math.random(750, 1500)
                    if side == "crim" then
                        setMarkerColor(marker, 255, 0, 0, a)
                        if isElement(eData.blips[thePoint]) then
                            destroyElement(eData.blips[thePoint])
                            --setBlipColor(eData.blips[thePoint], 255, 20, 20)
                        end
                        addMoneyToScore(theElement, money)
                        outputToParticipants("The criminals have captured a point.")
                    elseif side == "law" then
                        setMarkerColor(marker, 0, 0, 255, a)
                        if isElement(eData.blips[thePoint]) then
                            destroyElement(eData.blips[thePoint])
                            --setBlipColor(eData.blips[thePoint], 20, 20, 255)
                        end
                        addMoneyToScore(theElement, money)
                        outputToParticipants("The police have captured a point.")
                    end
                    captured[thePoint] = side
                else
                    local capturing_side = captured[thePoint]
                    local capturing_side = wA[capturing_side]
                    exports.GTIhud:dm("This point has already been captured by "..capturing_side..".", theElement, 255, 0, 0)
                end
            else
                exports.GTIhud:dm("You can't capture a point because the event isn't running", theElement, 255, 0, 0)
            end
        end
    end
end

function pointHit(hitElement, matching)
    if eventRunning and isPlayerInCnREvent(hitElement) then
        if getPlayerEventSide(hitElement) ~= "medic" then
            triggerEvent("onCnRPointEnter", source, hitElement, matching)
        else
            exports.GTIhud:dm("Medics cannot capture points.", hitElement, 255, 0, 0)
        end
    end
end

function pointLeave(leaveElement, matching)
    if eventRunning and isPlayerInCnREvent(leaveElement) then
        triggerEvent("onCnRPointLeave", source, leaveElement, matching)
    end
end

addEvent("onCnRPointCapture")
addEventHandler("onCnRPointCapture", root,
    function(player)
        if isPlayerInCnREvent(player) then
            capturePoint(source, player)
        end
    end
)

function eventTime(player)
    local eX, eY, eZ = getElementPosition(blip)
    local loc = getZoneName(eX, eY, eZ)
    local city = getZoneName(eX, eY, eZ, true)
    if not isPlayerInCnREvent(player) then
        if isTimer(timer) then
            cms = math.floor(getTimerDetails(timer))
            local cm = cms / 60000
            local cs = cm * 60
            if math.ceil(cs) >= 60 and math.ceil(cs) <= 90 then
                exports.GTIhud:dm(currentEvent.." will start in "..math.ceil(cm).." minutes ("..math.ceil(cs).." seconds). [Located in "..loc..", "..city.."]", player, 0, 255, 0)
            elseif math.ceil(cs) < 60 then
                exports.GTIhud:dm(currentEvent.." will start in "..math.ceil(cs).." seconds. [Located in "..loc..", "..city.."]", player, 0, 255, 0)
            else
                exports.GTIhud:dm(currentEvent.." will start in "..math.ceil(cm).." minutes ("..math.ceil(cs).." seconds). [Located in "..loc..", "..city.."]", player, 0, 255, 0)
            end
        else
            if eventRunning then
                exports.GTIhud:dm(currentEvent.." is currently in progress", player, 255, 255, 0)
            else
                exports.GTIhud:dm("There is no event currently running.", player, 255, 0, 0)
            end
        end
    else
        exports.GTIhud:dm("You are already inside the CnR event.", player, 255, 0, 0)
    end
end
addCommandHandler("cnrtime", eventTime)

local index = 0
local lastIndex = 0
local increase = 0

addEventHandler("onResourceStart", resourceRoot,
    function()
        cycleEvent()

        if (not getResourceFromName("GTIirc") or getResourceState(getResourceFromName("GTIirc")) ~= "running") then return end
        exports.GTIirc:addIRCCommandHandler("!cnr",'irc_cnr',0,true)
    end
)

function cycleEvent()
    --if not ed then
    ed = true
    --end
    eData.warps = {}
    eData.data = {}
    eData.entry = {}
    eData.markers = {}
    eventMax = false
    --
    if events[index] and type(events[index]) == "table" and index ~= lastIndex then
        if lastEvent ~= #events then
            for i, elem in ipairs (getElementsByType("blip", resourceRoot)) do
                destroyElement(elem)
            end
            for i, elem in ipairs (getElementsByType("colshape", resourceRoot)) do
                destroyElement(elem)
            end
            for i, elem in ipairs (getElementsByType("marker", resourceRoot)) do
                destroyElement(elem)
            end
            eData.warps = {}
            eData.data = {}
            eData.entry = {}
            eData.markers = {}
            eData.blips = {}
            local eventName = events[index][1]
            local eRes = events[index][2]

            if getResourceFromName(eRes) then
                local cnrRes = getResourceFromName(eRes)
                if getResourceState(cnrRes) == "loaded" then
                    startResource(cnrRes)
                elseif getResourceState(cnrRes) == "running" then
                    restartResource(cnrRes)
                end
                currentResource = eRes
            end

            teams["law"] = {}
            teams["crim"] = {}
            teams["medic"] = {}

            teams["law"]["count"] = 0
            teams["crim"]["count"] = 0
            teams["medic"]["count"] = 0

            for i, player in ipairs (getElementsByType("player")) do
                teams["law"][player] = false
                teams["crim"][player] = false
                teams["medic"][player] = false
            end

            lastIndex = index
            readCNRSettings(currentResource)
        else
            index = 0
            lastIndex = 0
            cycleEvent()
            --endEvent()
            --restartResource(getResourceFromName("GTIcnr"))
        end
    else
        if lastIndex ~= #events then
            --if increase == 5 then
                index = index + 1
            --end
            endEvent()
            --cycleEvent()
        else
            index = 0
            lastIndex = 0
            --cycleEvent()
            --endEvent()
            restartResource(getResourceFromName("GTIcnr"))
        end
    end
end

addEventHandler("onResourceStop", resourceRoot,
    function()
        if currentResource then
            if getResourceState(getResourceFromName(currentResource)) == "running" then
                stopResource(getResourceFromName(currentResource))
            end
        end
        if isTimer(timer) then
            killTimer(timer)
        end
        timer = nil
        currentEvent = false
        lastEvent = false
        if isElement(blip) then
            destroyElement(blip)
        end
        blip = nil

        law = {}
        lC = 0
        crim = {}
        cC = 0
        medics = {}
        mC = 0
        int = 0
        dim = 0

        killed = {}
        captured = {}

        eData.warps = {}
        eData.data = {}
        eData.entry = {}
        eData.markers = {}
        eventMax = false
    end
)

addCommandHandler("skipEvent",
    function()
        endEvent()
    end
)

--[[addCommandHandler("captureAll",
    function()
        for i, col in ipairs (getElementsByType("colshape", resourceRoot)) do
            capturePoint(col, getPlayerFromPartialName("LilDolla"))
        end
    end
)]]

-- Kill Player if in event
addEventHandler("onPlayerQuit", root, function()
    if (isPlayerInCnREvent(source)) then
        local etype = getPlayerEventSide(source)
        local armor = getPedArmor(source)
        exports.GTIaccounts:SAD(getPlayerAccount(source), "health", armor..",0")
        takeCount(source, etype)
    end
end)

-- Cancel Team Killing
addEventHandler("onPlayerDamage", root,
    function(attacker, weapon, part, loss)
        if isPlayerInCnREvent(source) and isPlayerInCnREvent(attacker) then
            local sTeam = getPlayerEventSide(source)
            local hp = getElementHealth(source) + loss
            local aTeam = getPlayerEventSide(attacker)
            if sTeam == aTeam then
                --cancelEvent()
                setElementHealth(source, hp)
            end
        end
    end
)

--Command for players to see how many cops/crims/medics are in the current event
addCommandHandler("cnrplayers",
function(player)
    local crims
    local cops
    local medics

    if currentEvent ~= false then
        crims = teams["crim"]["count"] or 0
        cops = teams["law"]["count"] or 0
        medics = teams["medic"]["count"] or 0
    else
        return outputChatBox("CnR: No events are currently running.",player,255,0,0)
    end

    outputChatBox("#FF0000Criminals: #FFFFFF"..crims.." #0000FFCops: #FFFFFF"..cops.." #1EFF7DMedics: #FFFFFF"..medics,player,255,255,255,true)
end)

function irc_cnr(server,channel,user,command,setting)
    if currentEvent ~= false then
        if not setting then exports.GTIirc:ircNotice(user,"Syntax is !cnr <setting [time or players]>") return end
        --local player = getPlayerFromPartialName(name)
        if setting == "time" then
            if isTimer(timer) then
                cms = math.floor(getTimerDetails(timer))
                local cm = cms / 60000
                local cs = cm * 60
                if math.ceil(cs) >= 60 and math.ceil(cs) <= 90 then
                    exports.GTIirc:ircNotice(user, currentEvent.." will start in "..math.ceil(cm).." minutes ("..math.ceil(cs).." seconds).")
                elseif math.ceil(cs) < 60 then
                    exports.GTIirc:ircNotice(user, currentEvent.." will start in "..math.ceil(cs).." seconds.", player, 0, 255, 0)
                else
                    exports.GTIirc:ircNotice(user, currentEvent.." will start in "..math.ceil(cm).." minutes ("..math.ceil(cs).." seconds).")
                end
            else
                if eventRunning then
                    exports.GTIirc:ircNotice(user, currentEvent.." is currently in progress")
                else
                    exports.GTIirc:ircNotice(user, "There is no event currently running.")
                end
            end
        elseif setting == "players" then
            exports.GTIirc:ircNotice(user, "Criminals: "..(teams["crim"]["count"] or 0).." -|- Police: "..(teams["law"]["count"] or 0).." -|- Medics: "..(teams["medic"]["count"] or 0))
        end
    else
        exports.GTIirc:ircNotice(user, "There is no CnR Event currently running.")
    end
    --[[
    if player then
        local job = exports.GTIemployment:getPlayerJob(player) or 'Unknown'
        exports.GTIirc:ircNotice(user,getPlayerName(player).." is working as "..job..".")
    else
        exports.GTIirc:ircNotice(user,"'"..name.."' no such player")
    end
    --]]
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end
