----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 21 Dec 2013
-- Resource: GTIpilot/pilot.lua
-- Version: 1.0
----------------------------------------->>

local METERS_IN_MILE = 1609.34

local dist			-- Distance (for dxStat)
local freezeOnStop	-- Freeze Plane when it stops? (vehicleBrake)
delBlip	= nil		-- Delivery Blip

-- Get Nearest Airport
----------------------->>

function getNearestAirport(player, limit3)
	local x,y,z = getElementPosition(player)
	local zone = getZoneName(x,y,z, true)
	if (not limit3 and (zone == "Tierra Robada" or zone == "Bone County")) then
		return 4
	elseif (x > 0 and y <= 0) then
		return 1
	elseif (x <= 0) then
		return 2
	elseif (x > 0 and y > 0) then
		return 3
	end
end

-- Is Vehicle Accelerating?
---------------------------->>

function isVehicleAccelerating(vehicle)
	local x,y,z = getElementVelocity(vehicle)
	local rx,ry,rot = getElementRotation(vehicle)
	if (rot >= 0 and rot < 90) then
		if (x < 0 and y >= 0) then
			return true
		end
	elseif (rot >= 90 and rot < 180) then
		if (x < 0 and y < 0) then
			return true
		end
	elseif (rot >= 180 and rot < 270) then
		if (x >= 0 and y < 0) then
			return true
		end
	elseif (rot >= 270 and rot < 360) then
		if (x >= 0 and y >= 0) then
			return true
		end
	end
	return false
end

-- Remove HUD Functions on Stop
-------------------------------->>

addEventHandler("onClientResourceStop", resourceRoot, function()
	exports.GTIhud:drawStat("Pilot", "", "")
	exports.GTIhud:drawStat("PilotDist", "", "")
	exports.GTIhud:drawStat("PilotETA", "", "")
end)

-- Render Distance and ETA
---------------------------->>

function renderDistance()
		-- Render Distance
	if (delBlip and isElement(delBlip)) then
		local x,y,z = getElementPosition(localPlayer)
		local bX,bY,bZ = getElementPosition(delBlip)
		dist = getDistanceBetweenPoints3D(x,y,z, bX,bY,bZ)
		dist = dist / METERS_IN_MILE
	else
		dist = 0
	end
	dist = string.format("%.3f", dist)
	exports.GTIhud:drawStat("PilotDist", "Distance", dist.." miles", 25, 150, 255, 1000)
end

function updateETA()
	-- Render ETA
	local ETA
	if (isPedInVehicle(localPlayer) and delBlip and isElement(delBlip)) then
		local vehicle = getPedOccupiedVehicle(localPlayer)
		local vx,vy,vz = getElementVelocity(vehicle)
		local speed = math.sqrt( vx^2 + vy^2 + vz^2 ) * 50
		if (speed > 3) then
			ETA = (dist * METERS_IN_MILE) / speed
		end
	end
	if (not ETA) then
		exports.GTIhud:drawStat("PilotETA", "ETA", "?:??", 25, 255, 25, 1500)
	else
		local M = math.floor(ETA/60)
		local S = math.floor(ETA-(M*60))
		if (S < 10) then S = "0"..S end
		exports.GTIhud:drawStat("PilotETA", "ETA", M..":"..S, 25, 255, 25, 1500)
	end
end

-- Stop Plane
-------------->>

function stopVehicle(freeze)
	if (not isPedInVehicle(localPlayer)) then return end
	for i,ctrl in ipairs({"accelerate", "brake_reverse"}) do
		toggleControl(ctrl, false)
		setControlState(ctrl, false)
	end
	
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local x,y,z = getElementVelocity(vehicle)
	local speed = math.sqrt(x^2 + y^2 + z^2)*100
	if (speed >= 15) then
		local div = math.sqrt(x^2 + y^2 + z^2)*100/15
		setElementVelocity(vehicle, x/div, y/div, z/div)
	end
		
	addEventHandler("onClientRender", root, vehicleBrake)
	if (isVehicleAccelerating(vehicle)) then
		setControlState("brake_reverse", true)
	else
		setControlState("accelerate", true)
	end
	freezeOnStop = freeze
end

function vehicleBrake()
	if (exports.GTIemployment:getPlayerJob(true) ~= "Pilot" or not isPedInVehicle(localPlayer)) then 
		removeEventHandler("onClientRender", root, vehicleBrake)
		for i,ctrl in ipairs({"accelerate", "brake_reverse"}) do
			toggleControl(ctrl, true)
			setControlState(ctrl, false)
		end
	return end
	
	local vehicle = getPedOccupiedVehicle(localPlayer)
	local x,y,z = getElementVelocity(vehicle)
	local speed = math.sqrt(x^2 + y^2 + z^2)*100
	if (speed <= 2) then
		for i,ctrl in ipairs({"accelerate", "brake_reverse"}) do
			if (not freezeOnStop) then
				toggleControl(ctrl, true)
			end
			setControlState(ctrl, false)
		end
		setElementVelocity(vehicle, 0, 0, 0)
		removeEventHandler("onClientRender", root, vehicleBrake)
		freezeOnStop = nil
	end
end

-- Airport Ambiance
-------------------->>

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i=144,146 do
		local sound = playSound3D("files/airport_sounds.mp3", -1861.688, 54.772, 1060.184, true)
		setSoundMaxDistance(sound, 200)
		setElementInterior(sound, 14)
		setElementDimension(sound, i)
	end
end)
