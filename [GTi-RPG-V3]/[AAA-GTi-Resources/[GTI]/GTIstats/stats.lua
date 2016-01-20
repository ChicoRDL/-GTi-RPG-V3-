----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 12 Feb 2015
-- Resource: GTIstats/stats.lua
-- Version: 1.0
----------------------------------------->>

local bullets_fired = 0		-- Bullets Fired by Player
local bullets_that_hit = 0	-- Bullets that Hit the intended target
local kg_explosives = 0		-- KGs of Explosives Used

local dist_foot = 0		-- Distance Traveled by Foot
local dist_car = 0		-- Distance Traveled by Car
local dist_boat = 0		-- Distance Traveled by Baot
local dist_bike = 0		-- Distance Traveled by Bike
local dist_plane = 0	-- Distance Traveled by Plane
local dist_moto = 0		-- Distance Traveled by Motorcylce
local dist_swim = 0		-- Distance Swam
local dist_total = 0	-- Total Distance Traveled

local lx, ly, lz 	-- Previous x, y, z

local STAT_UPDATE = 2.5*60000	-- Interval to update stats

-- Distance Traveled
--------------------->>

setTimer(function()
	local x, y, z = getElementPosition(localPlayer)
	if (not lx) then
		lx, ly, lz = x, y, z
		return
	end
	
	local distance = getDistanceBetweenPoints3D(lx, ly, lz, x, y, z)
	if (distance == 0) then return end
	
	local vehicle = getPedOccupiedVehicle(localPlayer)
	
		-- Distance Traveled by Foot
	if (not isPedInVehicle(localPlayer) and isPedOnGround(localPlayer)) then
		dist_foot = dist_foot + distance
		-- Distance Traveled by Boat
	elseif (isPedInVehicle(localPlayer) and getVehicleType(vehicle) == "Boat") then
		dist_boat = dist_boat + distance
		-- Distance Traveled by Bike
	elseif (isPedInVehicle(localPlayer) and getVehicleType(vehicle) == "BMX") then
		dist_bike = dist_bike + distance
		-- Distance Traveled by Plane
	elseif (isPedInVehicle(localPlayer) and (getVehicleType(vehicle) == "Plane" or getVehicleType(vehicle) == "Helicopter")) then
		dist_plane = dist_plane + distance
		-- Distance Traveled by Motorcycle
	elseif (isPedInVehicle(localPlayer) and getVehicleType(vehicle) == "Bike") then
		dist_moto = dist_moto + distance
		-- Distance Traveled by Car
	elseif (isPedInVehicle(localPlayer)) then
		dist_car = dist_car + distance
		-- Distance Swam
	elseif (not isPedInVehicle(localPlayer) and isElementInWater(localPlayer)) then
		dist_swim = dist_swim + distance
	else return end
		-- Total Distance Traveled
	dist_total = dist_total + distance
	
	lx, ly, lz = getElementPosition(localPlayer)
end, 5000, 0)

setTimer(function()
	triggerServerEvent("GTIstats.addDistanceStats", resourceRoot, dist_foot, dist_car, dist_boat, dist_bike, dist_plane, dist_moto, dist_swim, dist_total)
	dist_foot = 0		-- Distance Traveled by Foot
	dist_car = 0		-- Distance Traveled by Car
	dist_boat = 0		-- Distance Traveled by Baot
	dist_bike = 0		-- Distance Traveled by Bike
	dist_plane = 0		-- Distance Traveled by Plane
	dist_moto = 0		-- Distance Traveled by Motorcylce
	dist_swim = 0		-- Distance Swam
	dist_total = 0		-- Total Distance Traveled
end, STAT_UPDATE, 0)

-- Weapon Stats
---------------->>

addEventHandler("onClientPlayerWeaponFire", localPlayer, 
	function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
		if (weapon >= 22 and weapon <= 34 or weapon == 38) then
			bullets_fired = bullets_fired + 1
			if (hitElement and isElement(hitElement)) then
				bullets_that_hit = bullets_that_hit + 1
			end
		elseif (weapon >= 16 and weapon <= 18 or weapon == 35 or weapon == 36 or weapon == 39) then
			kg_explosives = kg_explosives + 1
		end
	end
)

setTimer(function()
	triggerServerEvent("GTIstats.addWeaponStats", resourceRoot, bullets_fired, bullets_that_hit, kg_explosives)
	bullets_fired = 0		-- Bullets Fired by Player
	bullets_that_hit = 0	-- Bullets that Hit the intended target
	kg_explosives = 0		-- KGs of Explosives Used
end, STAT_UPDATE, 0)

--------------->>

addEventHandler("onClientResourceStop", resourceRoot, function()
	triggerServerEvent("GTIstats.addWeaponStats", resourceRoot, bullets_fired, bullets_that_hit, kg_explosives)
	triggerServerEvent("GTIstats.addDistanceStats", resourceRoot, dist_foot, dist_car, dist_boat, dist_bike, dist_plane, dist_moto, dist_swim, dist_total)
end)
