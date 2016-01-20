----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 03 Aug 2014
-- Resource: GTIturfing/points_mode.lua
-- Version: 1.0
----------------------------------------->>

local TOT_ROUNDS = 2 	-- Number of Wins Required to Take Turf

-- Turf War HUD Stats
---------------------->>

function drawTurfWarStatsA(turf, owner, o_name, o_color, attacker, a_name, a_color)
	local owner_pts = getElementData(turf, "owner_pts") or 0
	local attack_pts = getElementData(turf, "attack_pts") or 0
	local round = getElementData(turf, "round") or 0
	local owner_rounds = getElementData(turf, "owner_rnds") or 0
	local attack_rnds = getElementData(turf, "attack_rnds") or 0
	local time_left = getElementData(turf, "time") or 0
	
		-- Rounds
	exports.GTIhud:drawStat("turf.round", "Round", round.." of "..(TOT_ROUNDS*2) - 1, 135, 30, 75)
	
		-- Time Left
	local M,S = math.floor(time_left/60), time_left - (math.floor(time_left/60)*60)
	if (S < 10) then S = "0"..S end
	exports.GTIhud:drawStat("turf.time", "Turf War Round End", M..":"..S, 135, 30, 75)
	
		-- Owner Score
	if (owner) then
		local r,g,b = unpack(o_color)
		exports.GTIhud:drawStat("turf.ownerpts", o_name, owner_pts.." ("..owner_rounds..")", r, g, b)
	else
		exports.GTIhud:drawStat("turf.ownerpts", "Law Enforcement", owner_pts.." ("..owner_rounds..")", 255, 255, 255)
	end
	
		-- Attacker Score
	if (attacker) then
		local r,g,b = unpack(a_color)
		exports.GTIhud:drawStat("turf.attackerpts", a_name, attack_pts.." ("..attack_rnds..")", r, g, b)
	else
		exports.GTIhud:drawStat("turf.attackerpts", "Law Enforcement", attack_pts.." ("..attack_rnds..")", 255, 255, 255)
	end
end
addEvent("GTIgangTerritories.drawTurfWarStatsA", true)
addEventHandler("GTIgangTerritories.drawTurfWarStatsA", root, drawTurfWarStatsA)

function stopDrawingTurfStatsA(player)
	exports.GTIhud:drawStat("turf.round")
	exports.GTIhud:drawStat("turf.time")
	exports.GTIhud:drawStat("turf.ownerpts")
	exports.GTIhud:drawStat("turf.attackerpts")
end
addEvent("GTIgangTerritories.stopDrawingTurfStatsA", true)
addEventHandler("GTIgangTerritories.stopDrawingTurfStatsA", root, stopDrawingTurfStatsA)

addEventHandler("onClientResourceStop", resourceRoot, function()
	stopDrawingTurfStatsA()
end)


local ghostMode = false

function event ( )
    cancelEvent ( )
end

function setPlayerSpawnProtectionOn ( )
	local job = exports.GTIemployment:getPlayerJob ( source, true )
    if ( source == localPlayer and ghostMode == false and job == "Gangster" ) then
	    triggerServerEvent ("MitchMiscGhostOn", source )
		setTimer ( setPlayerSpawnProtectionOff, 5000, 1 )
		addEventHandler ("onClientPlayerDamage", source, event )
		toggleControl  ( "fire", false )
		ghostMode = true
	end
end
addEventHandler ("onClientPlayerSpawn", localPlayer, setPlayerSpawnProtectionOn )

function setPlayerSpawnProtectionOff ( )
    triggerServerEvent ("MitchMiscGhostOff", localPlayer )
	removeEventHandler ("onClientPlayerDamage", localPlayer, event )
	toggleControl  ( "fire", true )
	ghostMode = false
end