----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 22 March 2015
-- Resource: GTIgroups/blips.lua
-- Type: Client Side
-- Author: Jack Johnson (Jack)
----------------------------------------->>

local blips = {}
local group_members = {}
local BLIP_VISIBLE_DISTANCE = 750
local group
local blipID	-- Current Blip ID

addEvent("groupsBlips:onPlayerRemoved",true)

addEventHandler("onClientResourceStart",resourceRoot,
function()
	group = getElementData(localPlayer,"groupID")
end)
	
function createGroupBlip(player, bID)
	blip = createBlipAttachedTo(player,bID,1,0,0,0,255,0,BLIP_VISIBLE_DISTANCE)
	blips[player] = blip
	return true
end

function setGroupBlipID(player, bID)
	setBlipIcon(blips[player], bID)
	return true
end

function destroyGroupBlip(player)
	if not blips[player] then return false end
	
	destroyElement(blips[player])
	return true
end

function cleanup()
	for k,v in pairs(group_members) do
		destroyGroupBlip(k)
		group_members[k] = nil --Clear group_members
	end
end

function update()
	--Update group
	group = getElementData(localPlayer,"group")
	groupID = getElementData(localPlayer,"groupID")
	
	
	if not group then
		cleanup()
		return
	end
	
	--Check if any of the group members have left and delete the blips if they have
	for k,v in pairs(group_members) do
		if (not k or not isElement(k)) then
			destroyGroupBlip(blips[k]) --Destroy the blip
			blips[k] = nil --Clear blips
			group_members[k] = nil --Clear group members
		end
	end
	
	if group == nil then return false end --We'll stop here since we're not in a group.
	local gbe = getElementData(root,"group_blips") or false
	
	--Check group data and stop if group_blips is false
	if gbe then
		gbe = gbe[groupID]
	end
	
	--Cleanup
	if not gbe then
		cleanup()
		return
	end
	
	--Scan all the players and add new players to group_members
	for k,v in ipairs(getElementsByType("player")) do
		if (v ~= localPlayer) then
			local pGroup = getElementData(v,"group")
			if ((pGroup == group)) then
				if (not group_members[v]) then --Check if the player is in the same group, and the player is not already added.
					createGroupBlip(v, gbe) --Create the new blip
					group_members[v] = true --Add him to group_members
				elseif (blipID ~= gbe) then
					setGroupBlipID(v, gbe)
				end
			else
				if (group_members[v]) then
					destroyGroupBlip(v)
					group_members[v] = nil
				end
			end
		end
	end
	blipID = gbe
end
setTimer(update,1000,0)


addEventHandler("onClientPlayerQuit",root,
function()
	if group_members[source] then
		destroyGroupBlip(source)
		group_members[source] = nil
	end
end)

addEventHandler("groupBlips:onPlayerRemoved",root,
function(player)
	if (group_members[player]) then
		destroyGroupBlip(player)
		group_members[player] = nil
	end
end)