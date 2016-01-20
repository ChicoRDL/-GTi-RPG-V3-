----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 27 Jul 2014
-- Resource: GTIbusdriver/bus_driver.lua
-- Version: 1.0
----------------------------------------->>

local vehicles = {
	[431] = true,	-- Bus
	[437] = true,	-- Coach
}

local LOAD_TIME = 5000
local PMIN, PMAX = 5, 35

local cur_stop		-- Current Stop in Table
local passengers	-- Number of Passengers in Bus
local r_passengers	-- Passengers as show in the stat
local r_pass_last	-- Last Load of r_passengers
local load_timer	-- Load/Unload timer
local delMarker		-- Delivery Marker
local delBlip		-- Delivery Blip
local bus			-- The bus you're driving
local timerA

-- Pre-Clearence
----------------->>

function isBusDriver(player)
	if (player ~= localPlayer) then return false end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Bus Driver") then return false end
	if (not isPedInVehicle(player)) then return false end
	if (not vehicles[getElementModel(getPedOccupiedVehicle(player))]) then return false end
	return true
end

-- Start Mission
----------------->>

function startMission(player, seat)
	if (not isBusDriver(player) or seat ~= 0) then return end
	
	if (not cur_stop) then cur_stop = 1 end
	local x,y,z = unpack(routes[cur_stop])
	
	delMarker = createMarker(x, y, z, "checkpoint", 4.0, 255, 25, 25, 175)
	addEventHandler("onClientMarkerHit", delMarker, loadPassangers)
	setElementData(delMarker, "creator", player)
	delBlip = exports.GTIblips:createCustomBlip(x, y, 16, 16, "bus_stop.png", 9999)
	
	if (not bus) then
		bus = getPedOccupiedVehicle(player)
		addEventHandler("onClientVehicleExit", bus, terminateJobOnExit)
		addEventHandler("onClientElementDestroy", bus, terminateJobOnDestroy)
	end
	
	exports.GTIhud:dm("BUS DRIVER: Make your way to your first destination in "..getZoneName(x, y, z), 255, 200, 0)
	exports.GTIhud:drawStat("BusDriver", "Passengers", "0", 255, 200, 0)
end
addEventHandler("onClientVehicleEnter", root, startMission)

-- Load Passengers
------------------->>

function loadPassangers(player, dim)
	if (not dim or not isBusDriver(player)) then return end
	if (getElementData(source, "creator") ~= player) then return end
	if (exports.GTIutil:getElementSpeed(getPedOccupiedVehicle(player)) > 30) then
		exports.GTIhud:dm("BUS DRIVER: You must be going slower than 30 mph in order for passengers to board your bus.", 255, 125, 0)
		return
	end
	
	triggerServerEvent("GTIbusdriver.completeMission", resourceRoot)
	
	for i,ctrl in ipairs({"accelerate", "brake_reverse", "handbrake", "enter_exit"}) do
		toggleControl(ctrl, false)
	end
	for i,ctrl in ipairs({"brake_reverse", "handbrake"}) do
		setControlState(ctrl, true)
	end
	
	removeEventHandler("onClientMarkerHit", delMarker, loadPassangers)
	destroyElement(delMarker)
	exports.GTIblips:destroyCustomBlip(delBlip)
	delBlip = nil
	setElementFrozen(bus, true)
	
	exports.GTIhud:drawProgressBar("BusLoad", "Now Boarding...", 25, 255, 25, LOAD_TIME)
	passengers = math.random(PMIN, PMAX)
	load_timer = setTimer(function() r_passangers = passengers end, LOAD_TIME, 1)
	r_pass_last = r_passengers or 0
	addEventHandler("onClientRender", root, renderLoadPassengers)
	
	timerA = setTimer(function()
		cur_stop = cur_stop + 1
		if (cur_stop > #routes) then cur_stop = 1 end
		local x,y,z = unpack(routes[cur_stop])
		
		delMarker = createMarker(x, y, z, "checkpoint", 4.0, 255, 25, 25, 175)
		addEventHandler("onClientMarkerHit", delMarker, loadPassangers)
		setElementData(delMarker, "creator", player)
		delBlip = exports.GTIblips:createCustomBlip(x, y, 16, 16, "bus_stop.png", 9999)
		
		exports.GTIhud:dm("BUS DRIVER: Your next stop is in "..getZoneName(x, y, z)..", make your way there.", 255, 200, 0)
		
		setElementFrozen(bus,false)
		
		for i,ctrl in ipairs({"accelerate", "brake_reverse", "handbrake", "enter_exit"}) do
			toggleControl(ctrl, true)
		end
		for i,ctrl in ipairs({"brake_reverse", "handbrake"}) do
			setControlState(ctrl, false)
		end
		completeMiss = true
	end, LOAD_TIME, 1)
end

-- Terminate Job
----------------->>

function terminateJob(job)
	if (job ~= "Bus Driver") then return end
	
	if (isElement(delMarker)) then
		removeEventHandler("onClientMarkerHit", delMarker, loadPassangers)
		destroyElement(delMarker)
		delMarker = nil
	end
	if (delBlip) then
		exports.GTIblips:destroyCustomBlip(delBlip)
		delBlip = nil
	end
	
	if (bus) then
		removeEventHandler("onClientVehicleExit", bus, terminateJobOnExit)
		removeEventHandler("onClientElementDestroy", bus, terminateJobOnDestroy)
		setElementFrozen(bus,false)
		bus = nil
	end
	
	if (isTimer(load_timer)) then
		killTimer(load_timer)
		load_timer = nil
	end
	if (isTimer(timerA)) then
		killTimer(timerA)
		timerA = nil
		cur_stop = cur_stop + 1
	end
	
	r_passengers = nil
	r_pass_last = nil
	passengers = nil
	
	for i,ctrl in ipairs({"accelerate", "brake_reverse", "enter_exit"}) do
		toggleControl(ctrl, true)
	end
	for i,ctrl in ipairs({"brake_reverse", "handbrake"}) do
		setControlState(ctrl, false)
	end
	
	exports.GTIhud:drawStat("BusDriver", "", "")
	exports.GTIhud:drawProgressBar("BusLoad", "")
end
addEvent("onClientPlayerQuitJob", true)
addEventHandler("onClientPlayerQuitJob", root, terminateJob)

function terminateJobOnExit(player, seat)
	if (player ~= localPlayer or seat ~= 0) then return end
	terminateJob("Bus Driver")
end

function terminateJobOnDestroy()
	terminateJob("Bus Driver")
end
addEventHandler("onClientResourceStop", resourceRoot, terminateJobOnDestroy)
	
-- Miscellaneous
----------------->>	

function renderLoadPassengers()
	if (not isTimer(load_timer) or r_passengers == passengers) then
		removeEventHandler("onClientRender", root, renderLoadPassengers)
	return end
	local timeLeft = getTimerDetails(load_timer)
	if (not r_passengers) then r_passengers = 0 end
	if (r_pass_last <= passengers) then
		r_passengers = r_pass_last + math.floor( ( (LOAD_TIME-timeLeft)/LOAD_TIME ) * (passengers-r_pass_last) )
	else
		r_passengers = passengers + math.floor( ( timeLeft/LOAD_TIME ) * (r_pass_last-passengers) )
	end
	
	exports.GTIhud:drawStat("BusDriver", "Passengers", r_passengers, 255, 200, 0)
end
