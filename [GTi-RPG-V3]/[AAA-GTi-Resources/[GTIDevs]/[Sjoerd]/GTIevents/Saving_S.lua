------------------------------------------->>
-- GTI-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: GTIevents
-- Type: Client Side
-- Author: ChicoGTI & RedBand
----------------------------------------->>

eventsDB = dbConnect("mysql", "dbname=gti;host=127.0.0.1", "GTI", "")
local cachedEventData = {}
maxSize = 65535
dbExec(eventsDB, "CREATE TABLE IF NOT EXISTS `events` (`id` int(11) NOT NULL AUTO_INCREMENT, `name` text, `data` text, PRIMARY KEY(id))")

function loadData(query)
    local d = dbPoll(query, 0)
    for k,v in ipairs(d) do
        local eData = fromJSON(v.data)
        if (eData and eData.info.name) then
            cachedEventData[#cachedEventData + 1] = {eData.info.name, eData.info.creator, eData.info.pos}
        end
    end
end
dbQuery(loadData, eventsDB, "SELECT * FROM events")

function getEvents()
    if (hasObjectPermissionTo(client, "command.eventm", false)) then
        triggerClientEvent(client, "GTIevents.SendEvents", client, getFormattedEventsTable())
    end
end
addEvent("GTIevents.GetEvents", true)
addEventHandler("GTIevents.GetEvents", root, getEvents)

function getFormattedEventsTable()
    local t = {}
    local i = 1
    for k,v in ipairs(cachedEventData) do
        if (type(v) == "table") then
            t[i] = {}
            t[i].creator = v[2]
            t[i].name = v[1]
            local x, y, z = v[3][1], v[3][2], v[3][3]
            t[i].zone = getZoneName(x, y, z, false)..", "..getZoneName(x, y, z, true)
            i = i + 1
        end
    end
    return t
end

function saveEvent(name, conditions, onlyMyStuff)
    if (hasObjectPermissionTo(client, "command.eventm", false)) then
        if (not getTableIndexFromName(name)) then
            local strToSave, creator, pos = getEventString(client, conditions, name, onlyMyStuff)
            if (strToSave and #strToSave <= maxSize) then
                cachedEventData[#cachedEventData + 1] = {name, creator, pos}
                dbExec(eventsDB, "INSERT INTO events (name, data) VALUES (?, ?)", name, strToSave)
                triggerClientEvent(client, "GTIevents.SendEvents", client, getFormattedEventsTable())
                outputChatBox("Added, size: "..exports.GTIutil:tocomma(math.floor(#strToSave)).." bytes", client, 0, 255, 0)
                --exports.GTIlogs:logSomething("(EM) "..getPlayerName(client).." saved event '"..name.."', size: "..#strToSave.." bytes", "events", client)
            else
                outputChatBox("Event can't be saved because it exceeds the limit of "..maxSize.." bytes. Current size: "..#strToSave, client, 0, 255, 0)
            end
        else
            outputChatBox("That name is already in use", client, 255, 0, 255)
        end
    end
end
addEvent("GTIevents.SaveEvent", true)
addEventHandler("GTIevents.SaveEvent", root, saveEvent)

function loadEvent(query, player, name)
    local data = dbPoll(query, 0)
    if (not data) or (#data == 0) then
        outputChatBox("Failed to load '"..name.."'", player, 255, 0, 0)
        return
    end
    local accName = getAccountName(getPlayerAccount(player))
    if (getTableIndexFromName(name)) then
        local tempTable = fromJSON(data[1].data)
        if (tempTable["objects"] and #tempTable["objects"] > 0) then
            for k,v in pairs(roadblocks) do
                if (isElement(v[1])) then
                    destroyElement(v[1])
                end
                roadblocks[k] = nil
            end
            for k,v in ipairs(tempTable["objects"]) do
                if (v[9] ~= 1225) or (v[8] ~= 0) then
                    local object = createObject(v[9], v[1], v[2], v[3], v[4], v[5], v[6])
                    setElementDimension(object, v[8])
                    setElementInterior(object, v[7])
                    setElementDoubleSided(object, true)
                    setElementFrozen(object, true)
                    roadblocks[object] = {object, accName}
                    if (v[9] ~= 1225) then
                        triggerClientEvent(player, "nobreak", player, object)
                    end
                end
            end
        end
        if (tempTable["checkpoints"]) then
            positions = fromJSON(tempTable["checkpoints"])
            if (tempTable["info"]["rmsize"] and tempTable["info"]["rmtype"]) then
                markerSize = tempTable["info"]["rmsize"]
                markerType = tempTable["info"]["rmtype"]
                raceType = tempTable["info"]["rtype"] or 1
            else
                markerType = "checkpoint"
                markerSize = 10
                raceType = 1
            end
            for plyr in pairs(raceCreators) do
                triggerClientEvent(plyr, "GTIevents.UpdateMarkers", plyr, positions, markerType, markerSize)    
            end
        end
        if (tempTable["pickups"]) then
            destroyAllPickups()
            for k,v in pairs(tempTable["pickups"]) do
                for key, value in pairs(v) do
                    createEventPickup(nil, k, value[6], {value[1], value[2], value[3], value[4], value[5]}, player)
                end
            end
        end
        if (tempTable["vehicles"] and #tempTable["vehicles"] > 0) then
            for k,v in ipairs(Evehs) do
                if (isElement(v)) then
                    destroyElement(v)
                    Evehs[k] = nil
                end
            end
            for k,v in ipairs(tempTable["vehicles"]) do
                createEventVehicle(v[9], v[1], v[2], v[3], v[4], v[5], v[6], v[8], v[7], accName, {v[10], v[11], v[12]})
            end
        end
        outputChatBox("'"..name.."' loaded", player, 0, 255, 0)
        --exports.GTIlogs:logSomething("(EM) "..getPlayerName(player).." loaded event '"..name.."'", "events", player)
    end
end

function preLoadEvent(name)
    if (hasObjectPermissionTo(client, "command.eventm", false)) then
        dbQuery(loadEvent, {client, name}, eventsDB, "SELECT * FROM events WHERE name=?", name)
    end
end
addEvent("GTIevents.LoadEvent", true)
addEventHandler("GTIevents.LoadEvent", root, preLoadEvent)

function deleteEvent(name)
    if (hasObjectPermissionTo(client, "command.eventm", false)) then
        local index = getTableIndexFromName(name)
        if (index) then
            dbExec(eventsDB, "DELETE FROM events WHERE name=?", name)
            cachedEventData[index] = "nil"
            triggerClientEvent(client, "GTIevents.SendEvents", client, getFormattedEventsTable())
            outputChatBox("'"..name.."' deleted", client, 0, 255, 0)
            --exports.GTIlogs:logSomething("(EM) "..getPlayerName(client).." deleted event '"..name.."'", "events", client)
        else
            outputChatBox("doesnt exist", client)
        end
    end
end
addEvent("GTIevents.DeleteEvent", true)
addEventHandler("GTIevents.DeleteEvent", root, deleteEvent)

function warpTo(name)
    if (hasObjectPermissionTo(client, "command.eventm", false)) then
        local index = getTableIndexFromName(name)
        if (index) then
            local pos = cachedEventData[index][3]
            setElementPosition(client, pos[1], pos[2], pos[3])
            setElementDimension(client, pos[5])
            setElementInterior(client, pos[4])
            --exports.GTIlogs:logSomething("(EM) "..getPlayerName(client).." warped to "..getZoneName(pos[1], pos[2], pos[3], false)..", "..getZoneName(pos[1], pos[2], pos[3], true).." dim: "..pos[5].." int: "..pos[4], "events", client)
        end
    end
end
addEvent("GTIevents.Warp", true)
addEventHandler("GTIevents.Warp", root, warpTo)

function getTableIndexFromName(ename)
    for k,v in ipairs(cachedEventData) do
        if (type(v) == "table" and v[1] == ename) then
            return k
        end
    end
end

function getEventString(player, conditions, name, onlyMyStuff)
    local tempTable = {}
    local x, y, z = getElementPosition(player)
    local int = getElementInterior(player)
    local dim = getElementDimension(player)
    local creator = getAccountName(getPlayerAccount(player))
    tempTable["info"] = {
        ["name"] = name,
        ["pos"] = {x, y, z, int, dim},
        ["zone"] = getZoneName(x, y, z)..", "..getZoneName(x, y, z, true),
        ["creator"] = creator,
    }
    if (conditions[1]) then
        tempTable["vehicles"] = {}
        for k,v in pairs(Evehs) do
            if (isElement(v)) then
                if (onlyMyStuff and getElementOwner(v) == creator) or (not onlyMyStuff) then 
                    local x, y, z = getElementPosition(v)
                    local rx, ry, rz = getElementRotation(v)
                    local int = getElementInterior(v)
                    local dim = getElementDimension(v)
                    local ID = getElementModel(v)
                    local r, g, b = getVehicleColor(v, true)
                    tempTable["vehicles"][#tempTable["vehicles"] + 1] = {x, y, z, rx, ry, rz, int, dim, ID, r, g, b}
                end
            end
        end
    end
    if (conditions[2]) then
        tempTable["objects"] = {}
        for k,v in pairs(roadblocks) do
            if (isElement(v[1])) then
                if (onlyMyStuff and getElementOwner(v[1]) == creator) or (not onlyMyStuff) then 
                    local x, y, z = getElementPosition(v[1])
                    local rx, ry, rz = getElementRotation(v[1])
                    local int = getElementInterior(v[1])
                    local dim = getElementDimension(v[1])
                    local ID = getElementModel(v[1])
                    tempTable["objects"][#tempTable["objects"] + 1] = {x, y, z, rx, ry, rz, int, dim, ID}
                end
            end
        end
    end
    if (conditions[3]) then
        tempTable["checkpoints"] = toJSON(positions)
        tempTable["info"]["rmsize"] = markerSize
        tempTable["info"]["rmtype"] = markerType
        tempTable["info"]["rtype"] = raceType
    end
    if (conditions[4]) then
        tempTable["pickups"] = {
            ["hp"] = {},
            ["armor"] = {},
            ["vfix"] = {},
            ["vnitro"] = {},
            ["vid"] = {},
            ["pct"] = {},
        }
        for k,v in pairs(pickups) do
            for key, value in pairs(v) do
                if (isElement(value[1])) then
                    if (onlyMyStuff and getElementOwner(value[1]) == creator) or (not onlyMyStuff) then 
                        local x, y, z = getElementPosition(value[1])
                        local int = getElementInterior(value[1])
                        local dim = getElementDimension(value[1])
                        tempTable["pickups"][k][#tempTable["pickups"][k] + 1] = {x, y, z, dim, int, value[3]}
                    end
                end
            end
        end
    end
    return toJSON(tempTable), tempTable.info.creator, tempTable.info.pos
end