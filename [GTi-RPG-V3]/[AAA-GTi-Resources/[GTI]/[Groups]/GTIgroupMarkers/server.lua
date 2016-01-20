local con = dbConnect("sqlite", "baseMarker.db" )
dbExec(con, "CREATE TABLE IF NOT EXISTS baseMarkers ('x', 'y', 'z', 'group', 'text')")

local baseManagers = {
    ["Mitch"] = true,
    ["ChicoRDL"] = true,
	["TomasitoCaram"] = true,
}

local createdMarkers = {}

function getBaseManager(player)
    local accountname = getAccountName(getPlayerAccount(player))
    if (baseManagers[accountname]) then
        return true
    end
    return false
end

function addBaseMarker(player, commandname, groupID)
    if (getBaseManager(player) and groupID) then
        --local group = table.concat({...}, " ")
		local group = tonumber(groupID)
        local x,y,z = getElementPosition(player)
        dbExec(con, "INSERT INTO baseMarkers VALUES (?, ?, ?, ?, '')", x, y, z-1, group)
        local newMarker = createMarker(x, y, z - 1, "cylinder", 1.5, 0, 255, 0, 75)
        addEventHandler("onMarkerHit", newMarker, baseMarkerHit)
        createdMarkers[newMarker] = {group, ""}
        triggerEvent("onBaseInfoMarkerAdded", root, group)
    end
end
addCommandHandler("basemarker", addBaseMarker)

function loadMarkers()
    dbQuery(spawnBaseMarkers, {}, con, "SELECT * FROM baseMarkers")
end
addEventHandler("onResourceStart", resourceRoot, loadMarkers)

function spawnBaseMarkers(markerQuery)
    baseMarkers = dbPoll(markerQuery, 0)
    for i, markerData in ipairs(baseMarkers) do
        if (markerData['group']) then
            local marker = createMarker(markerData['x'], markerData['y'], markerData['z'], "cylinder", 1.5, 0, 255, 0, 75)
            createdMarkers[marker] = {markerData["group"], markerData["text"]}
            addEventHandler("onMarkerHit", marker, baseMarkerHit)
        end
    end
end

function baseMarkerHit(player, matchDimension)
    if (matchDimension and isElement(player) and getElementType(player) == "player" and not isPedInVehicle(player)) then
        local x, y, z = getElementPosition(source)
        local isBaseManager = false
		local canEdit = false
        local playerAccount = getAccountName(getPlayerAccount(player))
        local cache = createdMarkers[source]
        if (exports.GTIgroups:getPlayerGroup(player) == tonumber(cache[1]) and exports.GTIgroups:hasMemberPermissionTo(player, "mod_group_info")) then
			canEdit = true
        end
        triggerClientEvent(player, "onBaseMarkerHit", player, cache[2], canEdit, getBaseManager(player), source, exports.GTIgroups:getGroupName(cache[1]))
    end
end

function deleteBaseMarker()
    if (not getBaseManager(client)) then return end
    local x, y, z = getElementPosition(source)
    dbExec(con, "DELETE FROM baseMarkers WHERE x=? AND y=? and z=?", x, y, z)
	exports.GTIlogs:outputLog(getPlayerName(client).." deleted the info marker of group "..tostring(createdMarkers[source][1]), "groups", client)
    triggerEvent("onBaseInfoMarkerRemoved", root, createdMarkers[source][1])
    if (isElement(source)) then
        destroyElement(source)
    end
	exports.GTIhud:dm("Deleted base marker", client, 0, 255, 0)
end
addEvent("onBaseMarkerDelete", true)
addEventHandler("onBaseMarkerDelete", root, deleteBaseMarker)

function saveBaseMarker(text)
    local x, y, z = getElementPosition(source)
    createdMarkers[source][2] = text
    dbExec(con, "UPDATE baseMarkers SET text=? WHERE x=? AND y=? and z=?", text, x, y, z)
	exports.GTIlogs:outputLog(getPlayerName(client).." updated the info marker of group "..tostring(createdMarkers[source][1]), "groups", client)
	exports.GTIhud:dm("Updated base marker", client, 0, 255, 0)
end
addEvent("onBaseMarkerSave", true)
addEventHandler("onBaseMarkerSave", root, saveBaseMarker)

addCommandHandler("groupid", 
	function (player, _, name)
		if ( name ) then
			local name = exports.GTIutil:findPlayer(name)
			if ( name ) then
				local group = exports.GTIgroups:getPlayerGroup(name)
					if ( group ) then
						outputChatBox(group, player)
					else
						outputChatBox("nope.avi", player)
					end
			end
		end
	end
)

		
