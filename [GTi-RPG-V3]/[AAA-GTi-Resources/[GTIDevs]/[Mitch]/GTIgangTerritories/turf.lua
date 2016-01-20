----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 29 Jul 2014
-- Resource: GTIturfing/turfs.slua
-- Version: 1.0
----------------------------------------->>

-- Can Player Turf
------------------->>

function canPlayerTurf(player, skip_veh)
	if (not isElement(player) or getElementType(player) ~= "player") then return false end
	if (isPedDead(player)) then return false end
	if (not skip_veh and isPedInVehicle(player)) then return false end
	if (not isGangster(player) and not isSWAT(player)) then return false end
	return true
end

function isGangster(player)
	if (not exports.GTIutil:isPlayerInTeam(player, "Criminals")) then return false end
	if (not getElementData(player, "group")) then return false end
	if (getElementData(player, "job") == "Gangster" and getElementData(player, "isWorking") == 1) then
		return true
	end
	return false
end

function isSWAT(player)
	if (not exports.GTIutil:isPlayerInTeam(player, "Law Enforcement")) then return false end
	if (getElementData(player, "division") == "SWAT Division" and getElementData(player, "isWorking") == 1) then
		return true
	end
	return false
end

