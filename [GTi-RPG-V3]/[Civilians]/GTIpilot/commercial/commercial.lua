----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 25 Oct 2014
-- Resource: GTIpilot/commercial/commercial.lua
-- Version: 1.0
----------------------------------------->>

local validVehicles = {
	[577] = true,	-- AT-400
	[592] = true,	-- Andromada
}

local second_offset = {
	[577] = 1.643,	-- AT-400
		-- 72,954 meters (45.331 miles)
	[592] = 1.358,	-- Andromada
		-- 88,210 meters (54.811 miles)
}

local LOAD_TIME = 30000
local PASSMIN, PASSMAX = 50, 250
local CARGMIN, CARGMAX = 40000, 80000

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

local panel_names = {"rudder", "elevators", "ailerons"}
	-- Panel Names (Extreme)
	
local com = {}		-- Table of Functions

-- Pre-clearance
----------------->>

function com.isPilot(player, ignoreGround)
	if (player ~= localPlayer) then return false end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Pilot" or getElementData(player, "division") ~= "Commercial") then return false end
	if (not isPedInVehicle(player)) then return false end
	local vehicle = getPedOccupiedVehicle(player)
	if (not validVehicles[getElementModel(vehicle)]) then return false end
	if (not ignoreGround and not isVehicleOnGround(vehicle)) then return false end
	return true
end

function com.isPassengerPlane(player)
	if (not isPedInVehicle(player)) then return false end
	local vehicle = getPedOccupiedVehicle(player)
	if (getElementModel(vehicle) ~= 577) then return false end
	return true
end

-- Start Mission
----------------->>

function com.startMission(player, seat)
	if (seat ~= 0 or not com.isPilot(player, true) or isElement(delMarker)) then return end
	
	missionType = math.random(20)
	
	local arpt = getNearestAirport(player, true)
	local loc = math.random(#commGates[arpt])
	local x,y,z = unpack(commGates[arpt][loc])
	
	delMarker = createMarker(x, y, z, "checkpoint", 10, 255, 200, 0, 175)
	addEventHandler("onClientMarkerHit", delMarker, com.pickupPassanger)
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, z, 41)
	
	if (not bindRender) then
		addEventHandler("onClientRender", root, renderDistance)
		timerETA = setTimer(updateETA, 1000, 0) updateETA()
		bindRender = true
	end
	
	if (not plane) then
		plane = getPedOccupiedVehicle(player)
		addEventHandler("onClientVehicleExit", plane, com.terminateJobOnExit)
		addEventHandler("onClientElementDestroy", plane, com.terminateJobOnDestroy)
	end
	
	local pX,pY,pZ = getElementPosition(player)
	distance = getDistanceBetweenPoints2D(pX, pY, x, y)
	
	outputChatBox("* (RADIO) ATC Tower: #FFFFFFTaxi to your assigned gate to prepare for your flight, over.", 255, 175, 0, true)
	exports.GTIhud:dm("PILOT: Taxi to your assigned gate to prepare for your flight", 255, 200, 0)
	if (com.isPassengerPlane(player)) then
		exports.GTIhud:drawStat("Pilot", "Passengers", "0", 255, 200, 0)
	else
		exports.GTIhud:drawStat("Pilot", "Cargo (kg)", "0", 255, 200, 0)
	end
	oldArpt = arpt
	
	toggleControl("accelerate", true)
	toggleControl("brake_reverse", true)
end
addEventHandler("onClientVehicleEnter", root, com.startMission)

-- Pickup Passenger
-------------------->>

function com.pickupPassanger(player, dim)
	if (not dim or not com.isPilot(player)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	
	stopVehicle(true)	
	removeEventHandler("onClientMarkerHit", delMarker, com.pickupPassanger)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
	if (com.isPassengerPlane(player)) then
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Boarding...", 30, 150, 255, LOAD_TIME)
		passengers = math.random(PASSMIN, PASSMAX)
	else
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Loading Cargo...", 30, 150, 255, LOAD_TIME)
		passengers = math.random(CARGMIN, CARGMAX)
	end	
	isLoading = true
	timerLoad = setTimer(function() r_passengers = passengers end, LOAD_TIME, 1)
	addEventHandler("onClientRender", root, com.renderLoadPassengers)
	
	timerDest = setTimer(function(player)
			-- Standard Mission
		if (missionType <= 14 or missionType >= 18) then
			com.createDestination(player)
			-- Secondary Mission
		elseif (missionType >= 15 and missionType <= 17) then
			com.secondaryMission(player)
		end
	end, LOAD_TIME, 1, player)
end

-- Create Destination
---------------------->>

function com.createDestination(player, tertiary)
	local x,y
	local pX,pY,pZ = getElementPosition(player)
	repeat x,y = math.random(-8192, 8192), math.random(-8192, 8192) until getDistanceBetweenPoints2D(pX,pY,x,y) > 8192 and getDistanceBetweenPoints2D(pX,pY,x,y) < 16384
	
	if (missionType ~= 20) then
		-- Standard Mission
		delMarker = createColTube(x, y, 0, 250, 850)
	else
		-- Extreme Mission
		delMarker = createColTube(x, y, 0, getDistanceBetweenPoints2D(pX,pY,x,y)/2, 850)
	end
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, 0, 41)
	
	if (missionType <= 14 or missionType == 20) then
		-- Standard Mission
		addEventHandler("onClientColShapeHit", delMarker, com.createReturnFlight)
	else
		-- Tertiary Mission
		addEventHandler("onClientColShapeHit", delMarker, com.tertiaryMission)
	end
	
	distance = distance + getDistanceBetweenPoints2D(pX,pY,x,y)
	
	if (not tertiary) then
		-- Standard Mission
		outputChatBox("* (RADIO) ATC Tower: #FFFFFFTake off and begin your flight to your destination, over.", 255, 175, 0, true)
		exports.GTIhud:dm("PILOT: Take off and begin your flight to your destination", 255, 200, 0)
	else
		-- Tertiary Mission
		outputChatBox("* (RADIO) ATC Tower: #FFFFFFYou've been assigned a second flight. Change course and fly to that location, over.", 255, 175, 0, true)
		exports.GTIhud:dm("PILOT: You've been assigned a second flight. Change course and fly to that location", 255, 200, 0)
	end
	
	toggleControl("accelerate", true)
	toggleControl("brake_reverse", true)
end

function com.createReturnFlight(player, dim)
	if (not dim or not com.isPilot(player, true)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	
	removeEventHandler("onClientColShapeHit", delMarker, com.createReturnFlight)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
	if (missionType ~= 20) then
		-- Standard Mission
		repeat arpt = math.random(#commGates) until arpt ~= oldArpt
	else
		-- Extreme Mission
		arpt = oldArpt
	end
	local loc = math.random(#commGates[arpt])
	local x,y,z = commGates[arpt][loc][1], commGates[arpt][loc][2], commGates[arpt][loc][3]
	oldArpt = arpt
	
	local pX,pY,pZ = getElementPosition(player)
	distance = distance + getDistanceBetweenPoints2D(pX, pY, x, y)
	
	delMarker = createMarker(x, y, z, "checkpoint", 10, 255, 200, 0, 175)
	addEventHandler("onClientMarkerHit", delMarker, com.dropoffPassenger)
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, z, 41)
	
	local zone = getZoneName(x, y, z)
	if (missionType ~= 20) then
		-- Standard Mission
		outputChatBox("* (RADIO) ATC Tower: #FFFFFFYour destination is "..zone..". Take off and make your way there, over.", 255, 175, 0, true)
		exports.GTIhud:dm("PILOT: Your destination is "..zone..". Take off and make your way there", 255, 200, 0)
	else
		-- Extreme Mission
		local panel = math.random(2,4)
		triggerServerEvent("GTIpilot.damagePanels", getPedOccupiedVehicle(player), panel)
		outputChatBox("* (RADIO) ATC Tower: #FFFFFFYour "..panel_names[panel-1].." "..(panel == 2 and "has" or "have").." been damaged! Conduct an emergency landing at "..zone.." quickly, over.", 255, 175, 0, true)
		exports.GTIhud:dm("PILOT: Your "..panel_names[panel-1] .. (panel == 2 and "has" or "have").." been damaged! Conduct an emergency landing at "..zone.." quickly", 255, 25, 25)
	end
end

-- Secondary Mission
--------------------->>

function com.secondaryMission(player)
	repeat arpt = math.random(#commGates) until arpt ~= oldArpt
	local loc = math.random(#commGates[arpt])
	local x,y,z = commGates[arpt][loc][1], commGates[arpt][loc][2], commGates[arpt][loc][3]
	oldArpt = arpt
	
	local pX,pY,pZ = getElementPosition(player)
	distance = distance + getDistanceBetweenPoints2D(pX, pY, x, y)
	
	delMarker = createMarker(x, y, z, "checkpoint", 10, 255, 200, 0, 175)
	addEventHandler("onClientMarkerHit", delMarker, com.dropoffPassenger)
	setElementData(delMarker, "creator", player, true)
	delBlip = createBlip(x, y, z, 41)
	
	local zone = getZoneName(x, y, z)
	outputChatBox("* (RADIO) ATC Tower: #FFFFFFYour destination is "..zone..". Take off and make your way there, over.", 255, 175, 0, true)
	exports.GTIhud:dm("PILOT: Your destination is "..zone..". Take off and make your way there", 255, 200, 0)
	
	toggleControl("accelerate", true)
	toggleControl("brake_reverse", true)
end

-- Tertiary Mission
-------------------->>

function com.tertiaryMission(player, dim)
	if (not dim or not com.isPilot(player, true)) then return false end
	if (getElementData(source, "creator") ~= player) then return end
	
	removeEventHandler("onClientMarkerHit", delMarker, com.tertiaryMission)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
	passengers = math.floor(passengers * math.random(40,60)/100)
	r_passengers = passengers
	if (com.isPassengerPlane(player)) then
		exports.GTIhud:drawStat("Pilot", "Passengers", passengers, 255, 200, 0)
	else
		exports.GTIhud:drawStat("Pilot", "Cargo (kg)", exports.GTIutil:tocomma(passengers), 255, 200, 0)
	end
	
	missionType = 1
	com.createDestination(player, true)
end

-- Drop off Passenger
---------------------->>

function com.dropoffPassenger(player, dim)
	if (not dim or not com.isPilot(player)) then return false end
	if (getElementData(source, "creator") ~= player) then return end
	
	stopVehicle(true)
	removeEventHandler("onClientMarkerHit", delMarker, com.dropoffPassenger)
	destroyElement(delMarker)
	destroyElement(delBlip)
	
	if (missionType >= 15 and missionType <= 17) then
		-- Tertiary Mission Offset
		distance = distance * second_offset[getElementModel(getPedOccupiedVehicle(player))]
	end
	triggerServerEvent("GTIpilot.repairPlane", getPedOccupiedVehicle(player))
	triggerServerEvent("GTIpilot.completeMission", resourceRoot, distance)
	
	if (com.isPassengerPlane(player)) then
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Deplaning...", 30, 150, 255, LOAD_TIME)
	else
		exports.GTIhud:drawProgressBar("PilotLoad", "Now Unloading Cargo...", 30, 150, 255, LOAD_TIME)
	end	
	isLoading = nil
	timerLoad = setTimer(function() r_passengers = passengers end, LOAD_TIME, 1)
	addEventHandler("onClientRender", root, com.renderLoadPassengers)
	
	setTimer(com.startMission, LOAD_TIME, 1, player, 0)
end

-- Terminate Mission
--------------------->>

function com.terminateJob(job, _, division)
	if (job ~= "Pilot" or division ~= "Commercial") then return end
	
	oldArpt = 0
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
		removeEventHandler("onClientVehicleExit", plane, com.terminateJobOnExit)
		removeEventHandler("onClientElementDestroy", plane, com.terminateJobOnDestroy)
		plane = nil
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
addEventHandler("onClientPlayerQuitJob", root, com.terminateJob)

function com.terminateJobOnExit(player, seat)
	if (player ~= localPlayer) then return end
	if (seat ~= 0) then return end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Pilot") then return end
	if (not source == plane) then return end
	
	com.terminateJob("Pilot", nil, "Commercial")
end
addEventHandler("onClientVehicleExit", root, com.terminateJobOnExit)

function com.terminateJobOnDestroy()
	if (getElementType(source) ~= "vehicle") then return end
	if (source ~= plane) then return end
	
	com.terminateJob("Pilot", nil, "Commercial")
end
addEventHandler("onClientElementDestroy", root, com.terminateJobOnDestroy)

-- Utilities
------------->>

function com.renderLoadPassengers()
	if (not isTimer(timerLoad) or (isLoading and r_passengers == passengers)) then
		removeEventHandler("onClientRender", root, com.renderLoadPassengers)
	return end
	
	local timeLeft = getTimerDetails(timerLoad)
	if (not r_passengers) then r_passengers = 0 end
	
	if (isLoading) then
		r_passengers = math.floor( ( (LOAD_TIME-timeLeft)/LOAD_TIME ) * passengers )
	else
		r_passengers = math.floor( ( timeLeft/LOAD_TIME ) * passengers )
	end
	
	if (com.isPassengerPlane(localPlayer)) then
		exports.GTIhud:drawStat("Pilot", "Passengers", r_passengers, 255, 200, 0)
	else
		exports.GTIhud:drawStat("Pilot", "Cargo (kg)", exports.GTIutil:tocomma(r_passengers), 255, 200, 0)
	end	
end
