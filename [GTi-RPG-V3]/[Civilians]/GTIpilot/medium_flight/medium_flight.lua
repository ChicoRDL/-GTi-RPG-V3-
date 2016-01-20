----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 13 Jul 2014
-- Resource: GTIpilot/medium_flight/medium_flight.lua
-- Version: 1.0
----------------------------------------->>

local validVehicles = {
	[553] = true,	-- Nevada
	[519] = true,	-- Shamal
}

local vehTimers = {
	[553] = 1.286,	-- Nevada
		-- 93,224 meters per hour (57.925 miles)
	[519] = 0.908,	-- Shamal
		-- 131,965 meters per hour (81.999 miles)
}

local LOAD_TIME = 10000
local PASSMIN, PASSMAX = 5, 20
local CARGMIN, CARGMAX = 1350, 2700

local bindRender	-- Are render functions handled?
local delMarker		-- Delivery Marker
local distance = 0	-- Distance Traveled (For Payment Purposes)
local isLoading		-- Is Plane being loaded or unloaded?
local missionType	-- Mission Branch
local oldArpt = 0	-- Old Airport Location
local passengers	-- Number of Passengers/Cargo
local plane			-- The aircraft that the player is flying in
local r_passengers	-- Number of Passengers/Cargo Displayed in the HUD
local timerDest		-- Timer that handles the destination part
local timerETA		-- ETA Timer
local timerLoad		-- Loading Passengers/Cargo Timer

local SEC_OFFSET = 0.6852
	-- 192,583 meters per hour (119.666 miles)

local EXT_OFFSET = 1997.75	-- Distance/Minute (Extreme)
local EXT_HNDCP = 0.95		-- Additional handicap time (Extreme)
local srceArpt = 0  		-- First Airport (Extreme)
local timerExt				-- Mission Timer (Extreme)
local timeExtLeft			-- Remaining Time (Extreme)

local mfc = {}		-- Table of Functions

-- Pre-clearance
----------------->>

function mfc.isPilot(player, ignoreGround)
	if (player ~= localPlayer) then return false end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Pilot" or getElementData(player, "division") ~= "Medium Flight") then return false end
	if (not isPedInVehicle(player)) then return false end
	local vehicle = getPedOccupiedVehicle(player)
	if (not validVehicles[getElementModel(vehicle)]) then return false end
	if (getElementModel(vehicle) == 519) then
		if (not ignoreGround and not isVehicleOnGround(vehicle)) then return false end
	else
		local x,y,z1 = getElementPosition(vehicle)
		local z2 = getGroundPosition(x, y, z1)
		if (not ignoreGround and z1 - z2 > 3) then return false end
	end
	return true
end

function mfc.isPassengerPlane(player)
	if (not isPedInVehicle(player)) then return false end
	local vehicle = getPedOccupiedVehicle(player)
	if (getElementModel(vehicle) ~= 519) then return false end
	return true
end

-- Start Mission
----------------->>

function mfc.startMission(player, seat)
	if (seat ~= 0 or not mfc.isPilot(player, true) or isElement(delMarker)) then return end
	
	missionType = math.random(20)
	
	local arpt = getNearestAirport(player)
	local loc = math.random(#PilotGates[arpt])
	local x,y,z = PilotGates[arpt][loc][1], PilotGates[arpt][loc][2], PilotGates[arpt][loc][3]
	
	delMarker = createMarker(x, y, z, "checkpoint", 6, 255, 200, 0, 175)
	addEventHandler("onClientMarkerHit", delMarker, mfc.pickupPassanger)
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, z, 41)
	
	if (not bindRender) then
		addEventHandler("onClientRender", root, renderDistance)
		timerETA = setTimer(updateETA, 1000, 0) updateETA()
		bindRender = true
	end
	
	if (not plane) then
		plane = getPedOccupiedVehicle(player)
		addEventHandler("onClientVehicleExit", plane, mfc.terminateJobOnExit)
		addEventHandler("onClientElementDestroy", plane, mfc.terminateJobOnDestroy)
	end
	
	local pX,pY,pZ = getElementPosition(player)
	distance = getDistanceBetweenPoints2D(pX, pY, x, y)
	
	if (mfc.isPassengerPlane(player)) then
		outputChatBox("* (RADIO) ATC Tower: #FFFFFFA group of passengers need to be picked up. Make your way to the appropriate hangar, over.", 255, 175, 0, true)
		exports.GTIhud:dm("PILOT: A group of passengers need to be picked up. Make your way to the appropriate hangar", 255, 200, 0)
		exports.GTIhud:drawStat("Pilot", "Passengers", "0", 255, 200, 0)
	else
		outputChatBox("* (RADIO) ATC Tower: #FFFFFFSome cargo needs to be transferred to another airport. Make your way to the appropriate hangar, over.", 255, 175, 0, true)
		exports.GTIhud:dm("PILOT: Some cargo needs to be transferred to another airport. Make your way to the appropriate hangar", 255, 200, 0)
		exports.GTIhud:drawStat("Pilot", "Cargo (kg)", "0", 255, 200, 0)
	end
	oldArpt = arpt
	srceArpt = arpt
	
	toggleControl("accelerate", true)
	toggleControl("brake_reverse", true)
end
addEventHandler("onClientVehicleEnter", root, mfc.startMission)

-- Pickup Passenger
-------------------->>

function mfc.pickupPassanger(player, dim)
	if (not dim or not mfc.isPilot(player)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	
	stopVehicle(true)	
	removeEventHandler("onClientMarkerHit", delMarker, mfc.pickupPassanger)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
	if (mfc.isPassengerPlane(player)) then
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Boarding...", 30, 150, 255, LOAD_TIME)
		passengers = math.random(PASSMIN, PASSMAX)
	else
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Loading Cargo...", 30, 150, 255, LOAD_TIME)
		passengers = math.random(CARGMIN, CARGMAX)
	end	
	isLoading = true
	timerLoad = setTimer(function() r_passengers = passengers end, LOAD_TIME, 1)
	addEventHandler("onClientRender", root, mfc.renderLoadPassengers)
	
	timerDest = setTimer(function(player)
			-- Standard Mission
		if (missionType <= 14 or missionType >= 18) then
			mfc.createDestination(player)
			-- Secondary Mission
		elseif (missionType >= 15 and missionType <= 17) then
			mfc.secondaryMission(player)
		end
	end, LOAD_TIME, 1, player)
end

-- Create Destination
---------------------->>

function mfc.createDestination(player, tertiary)
	repeat arpt = math.random(#PilotGates) until arpt ~= oldArpt and arpt ~= srceArpt
	local loc = math.random(#PilotGates[arpt])
	local x,y,z = PilotGates[arpt][loc][1], PilotGates[arpt][loc][2], PilotGates[arpt][loc][3]
	oldArpt = arpt
	
	local pX,pY,pZ = getElementPosition(player)
	distance = distance + getDistanceBetweenPoints2D(pX, pY, x, y)
	
	if (missionType <= 17) then
		-- Standard Mission
		delMarker = createMarker(x, y, z, "checkpoint", 6, 255, 200, 0, 175)
		addEventHandler("onClientMarkerHit", delMarker, mfc.dropoffPassenger)
	elseif (missionType >= 18 and missionType <= 19) then
		-- Tertiary Mission
		delMarker = createMarker(x, y, z, "checkpoint", 6, 255, 200, 0, 175)
		addEventHandler("onClientMarkerHit", delMarker, mfc.tertiaryMission)	
	elseif (missionType == 20) then
		-- Extreme Mission
		delMarker = createColTube(x, y, 0, getDistanceBetweenPoints2D(pX, pY, x, y)/2, 850)
		addEventHandler("onClientColShapeHit", delMarker, mfc.extremeMission)
	end
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, z, 41)
	
	local zone = getZoneName(x, y, z)
	if (not tertiary) then	
		outputChatBox("* (RADIO) ATC Tower: #FFFFFFYour destination is "..zone..". Take off and make your way there, over.", 255, 175, 0, true)
		exports.GTIhud:dm("PILOT: Your destination is "..zone..". Take off and make your way there", 255, 200, 0)
	else
		outputChatBox("* (RADIO) ATC Tower: #FFFFFFYou have been assigned a second destination. Take off and fly to "..zone..", over.", 255, 175, 0, true)
		exports.GTIhud:dm("PILOT: You have been assigned a second destination. Take off and fly to "..zone, 255, 200, 0)
	end
	
	toggleControl("accelerate", true)
	toggleControl("brake_reverse", true)
end

-- Secondary Destination
------------------------->>

function mfc.secondaryMission(player)
	local x,y
	repeat x,y = math.random(-8192, 8192), math.random(-8192, 8192) until getDistanceBetweenPoints2D(x,y,0,0) > 8192
	
	delMarker = createColTube(x, y, 0, 250, 850)
	addEventHandler("onClientColShapeHit", delMarker, mfc.createDestination2)
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, 0, 41)
	
	local pX,pY,pZ = getElementPosition(player)
	distance = distance + getDistanceBetweenPoints2D(pX, pY, x, y)
	
	outputChatBox("* (RADIO) ATC Tower: #FFFFFFYou've been given an international flight. Take off and make your way there, over.", 255, 175, 0, true)
	exports.GTIhud:dm("PILOT: You've been given an international flight. Take off and make your way there", 255, 200, 0)
	
	toggleControl("accelerate", true)
	toggleControl("brake_reverse", true)
end

function mfc.createDestination2(player, dim)
	if (not dim or not mfc.isPilot(player, true)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	
	removeEventHandler("onClientColShapeHit", delMarker, mfc.createDestination2)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
	mfc.createDestination(player)
end

-- Tertiary Mission
-------------------->>

function mfc.tertiaryMission(player, dim)
	if (not dim or not mfc.isPilot(player)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	
	stopVehicle(true)
	removeEventHandler("onClientColShapeHit", delMarker, mfc.tertiaryMission)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
	if (mfc.isPassengerPlane(player)) then
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Deplaning...", 30, 150, 255, LOAD_TIME)
	else
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Unloading Cargo...", 30, 150, 255, LOAD_TIME)
	end	
	isLoading = false
	timerLoad = setTimer(function() r_passengers = passengers/2 end, LOAD_TIME/2, 1)
	addEventHandler("onClientRender", root, mfc.renderLoadPassengers)
	
	timerDest = setTimer(function(player)
		passengers = passengers / 2
		missionType = 1
		mfc.createDestination(player, true)
	end, LOAD_TIME, 1, player)
end

-- Extreme Mission
------------------->>

function mfc.extremeMission(player, dim)
	if (not dim or not mfc.isPilot(player, true)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	
	removeEventHandler("onClientColShapeHit", delMarker, mfc.extremeMission)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
	local x,y,z = unpack(PilotMFCExtreme[srceArpt])
	delMarker = createMarker(x, y, z, "checkpoint", 6, 255, 200, 0, 175)
	addEventHandler("onClientMarkerHit", delMarker, mfc.dropoffPassenger)
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, z, 41)
	
	local pX,pY,pZ = getElementPosition(player)
	timeExtLeft = math.ceil( getDistanceBetweenPoints2D(pX, pY, x, y) / EXT_OFFSET * 60 * EXT_HNDCP * vehTimers[getElementModel(getPedOccupiedVehicle(player))] )
	killTimer(timerETA)
	timerExt = setTimer(mfc.renderMissionTimer, 1000, 0) mfc.renderMissionTimer()
		
	if (mfc.isPassengerPlane(player)) then
		exports.GTIhud:dm("PILOT: A passenger is having a medical emergency. Quickly return to the airport before the passenger dies!", 255, 25, 25)
	else
		exports.GTIhud:dm("PILOT: Suspicious cargo has been discovered on this aircraft. Quickly return to the airport before it explodes!", 255, 25, 25)
	end
end

function mfc.extremeMissionFailed(player)
	missionType = 1
	if (not mfc.isPassengerPlane(player)) then
		mfc.terminateJob("Pilot", nil, "Medium Flight")
		triggerServerEvent("GTIpilot.blowVehicle", getPedOccupiedVehicle(player))
	else
		exports.GTIhud:dm("PILOT: You were not quick enough, you let the passenger die. Return to the airport anyway to discard the body.", 255, 25, 25)
	end
end

-- Drop off Passenger
---------------------->>

function mfc.dropoffPassenger(player, dim)
	if (not dim or not mfc.isPilot(player)) then return false end
	if (getElementData(source, "creator") ~= player) then return end
	
	stopVehicle(true)
	removeEventHandler("onClientMarkerHit", delMarker, mfc.dropoffPassenger)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
		-- Distance Modifier (Secondary)
	local pay_offset
	if (missionType >= 15 and missionType <= 17) then 
		distance = distance * SEC_OFFSET
		-- Pay Modifier (Extreme)
	elseif (missionType == 20) then
		pay_offset = 1.25
		exports.GTIhud:dm("PILOT: Great work! For your speed, you have received a 25% pay bonus.", 255, 200, 0)
	end
	triggerServerEvent("GTIpilot.completeMission", resourceRoot, distance, pay_offset)
	
	if (mfc.isPassengerPlane(player)) then
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Deplaning...", 30, 150, 255, LOAD_TIME)
	else
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Unloading Cargo...", 30, 150, 255, LOAD_TIME)
	end	
	isLoading = nil
	timerLoad = setTimer(function() r_passengers = passengers end, LOAD_TIME, 1)
	addEventHandler("onClientRender", root, mfc.renderLoadPassengers)
	
	setTimer(mfc.startMission, LOAD_TIME, 1, player, 0)
	
		-- Clean Up Extreme
	if (isTimer(timerExt)) then
		killTimer(timerExt)
		timerExt = nil
		timeExtLeft = nil
		timerETA = setTimer(updateETA, 1000, 0) updateETA()
	end
end

-- Terminate Mission
--------------------->>

function mfc.terminateJob(job, _, division)
	if (job ~= "Pilot" or division ~= "Medium Flight") then return end
	
	oldArpt = 0
	srceArpt = 0
	distance = 0
	
	if (isElement(delMarker)) then
		destroyElement(delMarker)
		delMarker = nil
	end
	if (isElement(delBlip)) then
		destroyElement(delBlip)
		delBlip = nil
	end
	
	if (isTimer(loadTimer)) then
		killTimer(loadTimer)
		loadTimer = nil
	end
	if (isTimer(timerDest)) then
		killTimer(timerDest)
		timerDest = nil
	end
	
	if (bindRender) then
		removeEventHandler("onClientRender", root, renderDistance)
		killTimer(timerETA)
		bindRender = nil
	end
	
	if (plane) then
		removeEventHandler("onClientVehicleExit", plane, mfc.terminateJobOnExit)
		removeEventHandler("onClientElementDestroy", plane, mfc.terminateJobOnDestroy)
		plane = nil
	end
	
	if (isTimer(timerExt)) then
		killTimer(timerExt)
		timerExt = nil
		timeExtLeft = nil
	end
	
	passengers = nil
	r_passengers = nil
	isLoading = nil
	
	exports.GTIhud:drawStat("Pilot", "", "")
	exports.GTIhud:drawStat("PilotDist", "", "")
	exports.GTIhud:drawStat("PilotETA", "", "")
	exports.GTIhud:drawProgressBar("PilotLoad", nil)
end
addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", root, mfc.terminateJob)

function mfc.terminateJobOnExit(player, seat)
	if (player ~= localPlayer) then return end
	if (seat ~= 0) then return end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Pilot") then return end
	if (not source == plane) then return end
	
	mfc.terminateJob("Pilot", nil, "Medium Flight")
end
addEventHandler("onClientVehicleExit", root, mfc.terminateJobOnExit)

function mfc.terminateJobOnDestroy()
	if (getElementType(source) ~= "vehicle") then return end
	if (source ~= plane) then return end
	
	mfc.terminateJob("Pilot", nil, "Medium Flight")
end
addEventHandler("onClientElementDestroy", root, mfc.terminateJobOnDestroy)

-- Utilities
------------->>

function mfc.renderLoadPassengers()
	if (not isTimer(timerLoad) or (isLoading and r_passengers == passengers)) then
		removeEventHandler("onClientRender", root, mfc.renderLoadPassengers)
	return end
	
	local timeLeft = getTimerDetails(timerLoad)
	if (not r_passengers) then r_passengers = 0 end
	
	if (isLoading) then
		r_passengers = math.floor( ( (LOAD_TIME-timeLeft)/LOAD_TIME ) * passengers )
	elseif (isLoading == false) then
		r_passengers = math.floor( ( (timeLeft+(LOAD_TIME/2))/LOAD_TIME ) * passengers )
	elseif (isLoading == nil) then
		r_passengers = math.floor( ( timeLeft/LOAD_TIME ) * passengers )
	end
	
	if (mfc.isPassengerPlane(localPlayer)) then
		exports.GTIhud:drawStat("Pilot", "Passengers", r_passengers, 255, 200, 0)
	else
		exports.GTIhud:drawStat("Pilot", "Cargo (kg)", exports.GTIutil:tocomma(r_passengers), 255, 200, 0)
	end	
end

function mfc.renderMissionTimer()
	if (timeExtLeft < 0) then
		killTimer(timerExt)
		timerETA = setTimer(updateETA, 1000, 0) updateETA()
		mfc.extremeMissionFailed(localPlayer)
	return end
	local M = math.floor(timeExtLeft/60)
	local S = string.format( "%02d", math.floor( timeExtLeft - (M*60) ) )
	exports.GTIhud:drawStat("PilotETA", "EMERGENCY", M..":"..S, 255, 25, 25, 1500)
	timeExtLeft = timeExtLeft - 1
end
