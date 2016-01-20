----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 21 Dec 2013
-- Resource: GTIpilot/small_flight/small_flight.lua
-- Version: 1.0
----------------------------------------->>

local validVehicles = {
	[593] = true,	-- Dodo
	[511] = true,	-- Beagle
}

local vehTimers = {
	[593] = 1.000,	-- Dodo
		-- 119,865 meters per hour (74.481 miles)
	[511] = 1.079,	-- Beagle
		-- 111,124 meters per hour (69.049 miles)
}

local CONTINUE_TIMER = 2500

local oldArpt = 0	-- Old Airport Location
local distance = 0	-- Distance Traveled (For Payment Purposes)
local delMarker		-- Delivery Marker
local delPed		-- Delivery Ped
local bindRender	-- Are render functions handled?
local timerETA		-- ETA Timer
local plane			-- The aircraft that the player is flying in
local missionType	-- Mission Branch

local srceArpt = 0  -- First Airport (Secondary)
local srcePsgr 		-- Name of Original Passenger (Secondary)

local TER_OFFSET = 1997.75	-- Distance/Minute (Tertiary)
local TER_HNDCP = 1.0		-- Additional handicap time (Tertiary)
local timerTer				-- Mission Timer (Tertiary)
local timeTerLeft			-- Mission Time Left (Tertiary)

local sfc = {}		-- Table of Functions

-- Pre-clearance
----------------->>

function sfc.isPilot(player, ignoreGround)
	if (player ~= localPlayer) then return false end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Pilot" or getElementData(player, "division") ~= "Small Flight") then return false end
	if (not isPedInVehicle(player)) then return false end
	local vehicle = getPedOccupiedVehicle(player)
	if (not validVehicles[getElementModel(vehicle)]) then return false end
	if (not ignoreGround and not isVehicleOnGround(vehicle)) then return false end
	return true
end

-- Start Mission
----------------->>

function sfc.startMission(player, seat)
	if (seat ~= 0 or not sfc.isPilot(player, true) or isElement(delMarker)) then return end
	
	missionType = math.random(20)
	
	local arpt = getNearestAirport(player)
	local loc = math.random(#PilotGates[arpt])
	local x,y,z = PilotGates[arpt][loc][1], PilotGates[arpt][loc][2], PilotGates[arpt][loc][3]
	
	delMarker = createMarker(x, y, z, "checkpoint", 4.0, 255, 200, 0, 175)
	addEventHandler("onClientMarkerHit", delMarker, sfc.pickupPassanger)
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, z, 41)
	repeat delPed = createPed(math.random(312), x, y, z+1) until delPed
	setElementFrozen(delPed, true)
	addEventHandler("onClientPedDamage", delPed, cancelEvent)
	
	if (not bindRender) then
		addEventHandler("onClientRender", root, sfc.renderLookAt)
		addEventHandler("onClientRender", root, renderDistance)
		timerETA = setTimer(updateETA, 1000, 0) updateETA()
		bindRender = true
	end
	
	if (not plane) then
		plane = getPedOccupiedVehicle(player)
		addEventHandler("onClientVehicleExit", plane, sfc.terminateJobOnExit)
		addEventHandler("onClientElementDestroy", plane, sfc.terminateJobOnDestroy)
	end
	
	local pX,pY,pZ = getElementPosition(player)
	distance = getDistanceBetweenPoints2D(pX, pY, x, y)
	
	outputChatBox("* (RADIO) ATC Tower: #FFFFFFSomeone has ordered a flight to another airport. Make your way to the appropriate hangar, over.", 255, 175, 0, true)
	exports.GTIhud:dm("PILOT: Someone has ordered a flight to another airport. Make your way to the appropriate hangar", 255, 200, 0)
	exports.GTIhud:drawStat("Pilot", "Passengers", "0", 255, 200, 0)
	oldArpt = arpt
	srceArpt = arpt
end
addEventHandler("onClientVehicleEnter", root, sfc.startMission)

-- Pickup Passenger
-------------------->>

function sfc.pickupPassanger(player, dim)
	if (not dim or not sfc.isPilot(player)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	
	stopVehicle()
	repeat arpt = math.random(#PilotGates) until arpt ~= oldArpt and arpt ~= srceArpt
	
	local locTable
	if (missionType ~= 20) then locTable = PilotGates[arpt] else locTable = PilotExtreme end
	local loc = math.random(#locTable)
	local x,y,z = locTable[loc][1], locTable[loc][2], locTable[loc][3]
	oldArpt = arpt
	
	removeEventHandler("onClientMarkerHit", delMarker, sfc.pickupPassanger)
	destroyElement(delMarker)
	destroyElement(delBlip)
	removeEventHandler("onClientPedDamage", delPed, cancelEvent)
	destroyElement(delPed)
	
	delMarker = createMarker(x, y, z, "checkpoint", 4.0, 255, 200, 0, 175)
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, z, 41)
	
	local pX,pY,pZ = getElementPosition(player)
	distance = distance + getDistanceBetweenPoints2D(pX, pY, x, y)
	
	local message
	local zone = getZoneName(x, y, z)
	local name = exports.GTIutil:getGenericName()
	
	-- Pick Message from Mission Type
	if (missionType < 20) then
		message = randomResponses[math.random(#randomResponses)]
	elseif (missionType == 20) then
		message = "I'll pay you 20% more if you drop me off [airport]"
		zone = locTable[loc][4]
	elseif (missionType == 21) then
		message = mistakeResponses[math.random(#mistakeResponses)]
		missionType = 1
	end
	
	message = string.gsub(message, "%[airport%]", zone)
	outputChatBox("(Local)[1] "..(srcePsgr or name)..": "..message, 255, 255, 255)
	srcePsgr = name
	
	exports.GTIhud:drawStat("Pilot", "Passengers", "1", 255, 200, 0)
	
		-- Pick Mission Type
	if (missionType <= 14 or missionType == 20) then
		addEventHandler("onClientMarkerHit", delMarker, sfc.dropoffPassenger)
	elseif (missionType >= 15 and missionType <= 17) then
		addEventHandler("onClientMarkerHit", delMarker, sfc.pickupPassanger)
		missionType = 21
	elseif (missionType >= 18 and missionType <= 19) then
		addEventHandler("onClientMarkerHit", delMarker, sfc.dropoffPassenger)
		timeTerLeft = math.ceil( getDistanceBetweenPoints2D(pX, pY, x, y) / TER_OFFSET * 60 * TER_HNDCP * vehTimers[getElementModel(getPedOccupiedVehicle(player))] )
		killTimer(timerETA)
		timerTer = setTimer(sfc.renderMissionTimer, 1000, 0) sfc.renderMissionTimer()
		exports.GTIhud:dm("PILOT: This mission is timed! Rush to your destination before time runs out.", 255, 200, 0)
	end
end

-- Drop off Passenger
---------------------->>

function sfc.dropoffPassenger(player, dim)
	if (not dim or not sfc.isPilot(player)) then return false end
	if (getElementData(source, "creator") ~= player) then return end
	
	stopVehicle()
	removeEventHandler("onClientMarkerHit", delMarker, sfc.dropoffPassenger)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
		-- Tertiary Mission Failed
	local pay_offset
	if (timeTerLeft and timeTerLeft < 0) then
		pay_offset = 0.5
		exports.GTIhud:dm("PILOT: You ran out of time. Your pay for this mission has been reduced by 50%.", 255, 25, 25)
		-- Extreme Mission Bonus
	elseif (missionType == 20) then
		pay_offset = 1.2
	end
	
	triggerServerEvent("GTIpilot.completeMission", resourceRoot, distance, pay_offset)
	setTimer(sfc.startMission, CONTINUE_TIMER, 1, player, 0)
	exports.GTIhud:drawStat("Pilot", "Passengers", "0", 255, 200, 0)
	
		-- Tertiary Mission
	if (isTimer(timerTer)) then
		timerETA = setTimer(updateETA, 1000, 0) updateETA()
		killTimer(timerTer)
		timerTer = nil
		timeTerLeft = nil
	end
end

-- Terminate Mission
--------------------->>

function sfc.terminateJob(job, _, division)
	if (job ~= "Pilot" or division ~= "Small Flight") then return end
	
	oldArpt = 0
	distance = 0
	srceArpt = 0
	srcePsgr = nil
	
	if (isElement(delMarker)) then
		destroyElement(delMarker)
		delMarker = nil
	end
	if (isElement(delBlip)) then
		destroyElement(delBlip)
		delBlip = nil
	end
	if (isElement(delPed)) then
		removeEventHandler("onClientPedDamage", delPed, cancelEvent)
		destroyElement(delPed)
		delPed = nil
	end
	
	if (bindRender) then
		removeEventHandler("onClientRender", root, sfc.renderLookAt)
		removeEventHandler("onClientRender", root, renderDistance)
		killTimer(timerETA)
		bindRender = nil
	end
	
	if (plane) then
		removeEventHandler("onClientVehicleExit", plane, sfc.terminateJobOnExit)
		removeEventHandler("onClientElementDestroy", plane, sfc.terminateJobOnDestroy)
		plane = nil
	end
	
	if (isTimer(timerTer)) then
		killTimer(timerTer)
		timerTer = nil
		timeTerLeft = nil
	end
	
	exports.GTIhud:drawStat("Pilot", "", "")
	exports.GTIhud:drawStat("PilotDist", "", "")
	exports.GTIhud:drawStat("PilotETA", "", "")
end
addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", root, sfc.terminateJob)

function sfc.terminateJobOnExit(player, seat)
	if (player ~= localPlayer or seat ~= 0) then return end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Pilot") then return end
	sfc.terminateJob("Pilot", nil, "Small Flight")
end

function sfc.terminateJobOnDestroy()
	sfc.terminateJob("Pilot", nil, "Small Flight")
end

-- Utilities
------------->>

function sfc.renderLookAt()
	if (not delPed or not isElement(delPed)) then return end
	
	local x,y = getElementPosition(localPlayer)
	local pX,pY = getElementPosition(delPed)
	local rot = exports.GTIutil:findRotation(pX,pY, x,y)
	setElementRotation(delPed, 0, 0, rot)
end

function sfc.renderMissionTimer()
	if (timeTerLeft < 0) then
		killTimer(timerTer)
		timerETA = setTimer(updateETA, 1000, 0) updateETA()
	return end
	local M = math.floor(timeTerLeft/60)
	local S = string.format( "%02d", math.floor( timeTerLeft - (M*60) ) )
	exports.GTIhud:drawStat("PilotETA", "Time Remaining", M..":"..S, 255, 25, 25, 1500)
	timeTerLeft = timeTerLeft - 1
end
