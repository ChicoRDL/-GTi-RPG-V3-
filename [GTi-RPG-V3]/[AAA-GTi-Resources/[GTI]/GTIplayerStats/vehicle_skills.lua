----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 16 Mar 2015
-- Resource: GTIplayerStats/vehicle_skills.lua
-- Version: 1.0
----------------------------------------->>

local BIKE_SKILL = 25	-- Bike Skill Increased by...
local CYC_SKILL = 50	-- Cycling Skill Increased by...
local DRIV_SKILL = 20	-- Driving Skill Increased by...

local BIKE_TIME = 180	-- Seconds to update Bike Skill
local CYC_TIME = 120	-- Seconds to update Cycling Skill
local DRIV_TIME = 300	-- Seconds to update Driving Skill

local STAT_UPDATE = 2.5*60000	-- Interval to update stats

local bike_amt = 0		-- Record of Bike Skill
local cyc_amt = 0		-- Record of Cycling Skill
local driv_amt = 0		-- Record of Driving Skill

local lastAccel			-- Record of Last Time Accelerated

-- Increase Vehicle Skill
-------------------------->>

function increaseVehicleSkill(skill, amount)
	if (not skill or not tonumber(amount)) then return end
	if (skill == "bike") then
		local cur_bike = bike_amt
		local stat = getPedStat(localPlayer, 229)
		if (stat+cur_bike >= 1000) then return end
		bike_amt = bike_amt + amount
		if ((stat+cur_bike) % 25 > (stat+bike_amt) % 25) then
			exports.GTIhud:drawNote("playerStats.bike", "+ Bike Skill ("..string.format("%.1f", (stat + bike_amt)/10).."%)", 255, 215, 0, 7500)
		end
		
		if ((stat+cur_bike) % 1000 > (stat+bike_amt) % 1000) then
			exports.GTIhud:dm("Bike Skill Upgraded. Maximum reached.", 255, 215, 0)
		elseif ((stat+cur_bike) % 200 > (stat+bike_amt) % 200) then
			exports.GTIhud:dm("Bike Skill Upgraded. You have less chance of falling from your motorbike.", 255, 215, 0)
		end
		--outputDebugString("Skill: "..skill.."; Amount: "..bike_amt)
	elseif (skill == "cycling") then
		local cur_cyc = cyc_amt
		local stat = getPedStat(localPlayer, 230)
		if (stat+cur_cyc >= 999) then return end
		cyc_amt = cyc_amt + amount
		if ((stat+cur_cyc) % 50 > (stat+cyc_amt) % 50) then
			exports.GTIhud:drawNote("playerStats.cycling", "+ Cycling Skill ("..string.format("%.1f", (stat + cyc_amt)/10).."%)", 255, 215, 0, 7500)
		end
		
		if ((stat+cur_cyc) % 999 >= (stat+cyc_amt) % 999) then
			exports.GTIhud:dm("Cycling Skill Upgraded. Maximum reached.", 255, 215, 0)
			exports.GTIhud:drawNote("playerStats.cycling", "+ Cycling Skill (100.0%)", 255, 215, 0, 7500)
		elseif ((stat+cur_cyc) % 200 > (stat+cyc_amt) % 200) then
			exports.GTIhud:dm("Cycling Skill Upgraded. You can bunny hop higher and can reverse at higher speeds without falling off.", 255, 215, 0)
		end
		--outputDebugString("Skill: "..skill.."; Amount: "..cyc_amt)
	elseif (skill == "driving") then
		local cur_driv = driv_amt
		local stat = getPedStat(localPlayer, 160)
		if (stat+cur_driv >= 1000) then return end
		driv_amt = driv_amt + amount
		if (cur_driv % 20 > driv_amt % 20) then
			exports.GTIhud:drawNote("playerStats.driving", "+ Driving Skill ("..string.format("%.1f", (stat + cyc_amt)/10).."%)", 255, 215, 0, 7500)
		end
		--outputDebugString("Skill: "..skill.."; Amount: "..driv_amt)
	end
	
end

setTimer(function()
	triggerServerEvent("GTIplayerStats.modifyPlayerStat", resourceRoot, 229, bike_amt)
	bike_amt = 0
	triggerServerEvent("GTIplayerStats.modifyPlayerStat", resourceRoot, 230, cyc_amt)
	cyc_amt = 0
	triggerServerEvent("GTIplayerStats.modifyPlayerStat", resourceRoot, 160, driv_amt)
	driv_amt = 0
end, STAT_UPDATE, 0)

-- Record Vehicle Skill
------------------------>>

setTimer(function()
	if (not isPedInVehicle(localPlayer)) then return end
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (getVehicleOccupant(vehicle) ~= localPlayer) then return end
	
	if (not isPlayerAccelerating()) then return end
	
	-- Increase Bike Skill
	if (getVehicleType(vehicle) == "Bike") then
		increaseVehicleSkill("bike", BIKE_SKILL/BIKE_TIME)
	-- Increase Cycling Skill
	elseif (getVehicleType(vehicle) == "BMX") then
		increaseVehicleSkill("cycling", CYC_SKILL/CYC_TIME)
	-- Increase Driving Skill
	elseif (getVehicleType(vehicle) == "Automobile" or getVehicleType(vehicle) == "Train" or getVehicleType(vehicle) == "Monster Truck" or getVehicleType(vehicle) == "Quad") then
		increaseVehicleSkill("driving", DRIV_SKILL/DRIV_TIME)
	end
	
end, 5000, 0)

-- Record Acceleration
----------------------->>

addEventHandler("onClientRender", root, function()
	if (getControlState("accelerate") and not getControlState("brake_reverse") and not getControlState("handbrake")) then
		lastAccel = getTickCount()
	end
end)

function isPlayerAccelerating()
	if (not isPedInVehicle(localPlayer) or not lastAccel) then return false end
	return getTickCount() - lastAccel < 500
end
