----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 16 Mar 2015
-- Resource: GTIplayerStats/weapon_skills.lua
-- Version: 1.0
----------------------------------------->>

local weapon_levels = {
	[22] = {"Pistol",			69,		0.8,	40},	-- Pistol
	[23] = {"Taser",			70,		5,		500},	-- Taser
	[24] = {"Desert Eagle",		71,		3, 		200},	-- Desert Eagle
	[25] = {"Shotgun",			72,		0.6,	200},	-- Shotgun
	[26] = {"Sawn-Off Shotgun",	73,		0.6,	200},	-- Sawn-off Shotgun
	[27] = {"Combat Shotgun",	74,		0.6,	200},	-- Combat Shotgun
	[28] = {"Machine Pistol",	75,		0.4,	50},	-- Micro Uzi
	[32] = {"Machine Pistol",	75,		0.4,	50},	-- Tec-9
	[29] = {"SMG",				76,		0.35,	250},	-- SMG		-- Org Int: 1.5
	[30] = {"AK-47",			77,		0.3,	200},	-- AK-47	-- Org Int: 3
	[31] = {"M4",				78,		0.2,	200},	-- M4		-- Org Int: 2
}

local weapon_stats = {
	[69] = 0, [70] = 0, [71] = 0, [72] = 0, [73] = 0, 
	[74] = 0, [75] = 0, [76] = 0, [77] = 0, [78] = 0, 
}

local gangster_level = {
	[22] = "Pistol: Gangster level reached. Lock-on range, accuracy and rate of fire have all increased.",
	[23] = "Taser: Gangster level reached. You can now move while in the aiming stance.\nLock-on range, accuracy, rate of fire and strafe speed have all increased.",
	[24] = "Desert Eagle: Gangster level reached. You can now move while in the aiming stance.\nLock-on range, accuracy, rate of fire and strafe speed have all increased.",
	[25] = "Shotgun: Gangster level reached. You can now move while in the aiming stance.\nLock-on range, accuracy, rate of fire and strafe speed have all increased.",
	[26] = "Sawn-Off Shotgun: Gangster level reached. Your lock-on range, accuracy and rate of fire have increased.",
	[27] = "Combat Shotgun: Gangster level reached. You can now move while in the aiming stance.\nLock-on range, rate of fire and strafe speed have all increased.",
	[28] = "Machine Pistol: Gangster level reached. Your lock-on range and accuracy have increased.",
	[32] = "Machine Pistol: Gangster level reached. Your lock-on range and accuracy have increased.",
	[29] = "SMG: Gangster level reached. You can now move while in the aiming stance.\nLock-on range, accuracy and strafe speed have all increased.",
	[30] = "AK-47: Gangster level reached. You can now move while in the aiming stance.\nLock-on range, accuracy and strafe speed have all increased.",
	[31] = "M4:  Gangster level reached. You can now move while in the aiming stance.\nLock-on range, accuracy and strafe speed have all increased.",
}

local hitman_level = {
	[22] = "Pistol: Hitman level reached. You can now wield two pistols simultaneously and your lock-on range has increased.",
	[23] = "Taser: Hitman level reached. You can now fire while moving.\nLock-on range, accuracy, rate of fire and strafe speed have all increased.",
	[24] = "Desert Eagle: Hitman level reached. You can now fire while moving.\nLock-on range, accuracy, rate of fire and strafe speed have all increased.",
	[25] = "Shotgun: Hitman level reached. You can now fire while moving.\nLock-on range, accuracy, rate of fire and strafe speed have all increased.",
	[26] = "Sawn-Off Shotgun: Hitman level reached.\nYou may now wield two sawn-off shotguns simultaneously and your lock-on range has increased.",
	[27] = "Combat Shotgun: Hitman level reached. You can now fire while moving.\nLock-on range and strafe speed have both increased.",
	[28] = "Machine Pistol: Hitman level reached.\nYou can now wield two Machine Pistols simultaneously and your lock-on range has increased.",
	[32] = "Machine Pistol: Hitman level reached.\nYou can now wield two Machine Pistols simultaneously and your lock-on range has increased.",
	[29] = "SMG: Hitman level reached. You can now fire while moving.\nLock-on range, accuracy and strafe speed have all increased.",
	[30] = "AK-47: Hitman level reached. You can now fire while moving.\nLock-on range, accuracy and strafe speed have all increased.",
	[31] = "M4: Hitman level reached. You can now fire while moving.\nLock-on range, accuracy and strafe speed have all increased.",
}

local STAT_UPDATE = 2.5*60000	-- Interval to update stats

-- Increase Skill
------------------>>

function increaseWeaponSkill(weapon, amount)
	if (not weapon_levels[weapon] or not tonumber(amount)) then return end
	
	local skill = weapon_levels[weapon]
	local cur_skill = weapon_stats[skill[2]]
	local stat = getPedStat(localPlayer, skill[2])
	if (stat == 1000) then return end
	weapon_stats[skill[2]] = weapon_stats[skill[2]] + amount
	
	if (stat+cur_skill < skill[4] and stat+weapon_stats[skill[2]] >= skill[4]) then
		local notice = gangster_level[weapon]
		notice = split(notice, "\n")
		exports.GTIhud:dm(notice[1], 255, 215, 0)
		if (notice[2]) then
			exports.GTIhud:dm(notice[2], 255, 215, 0)
		end
		return
		
	elseif (stat+cur_skill > skill[4] and (stat+cur_skill) % 200 > (stat+weapon_stats[skill[2]]) % 200) then
		exports.GTIhud:dm(skill[4].." Skill Upgraded. Keep practicing and you'll reach hitman level.", 255, 215, 0)
		if (weapon == 22 or weapon == 26 or weapon == 28 or weapon == 29) then
			exports.GTIhud:dm("Hitman level allows you to wield two "..string.lower(skill[1]).."s simultaneously", 255, 215, 0)
		end		

	elseif (stat+cur_skill < skill[4] and (stat+cur_skill) % 200 > (stat+weapon_stats[skill[2]]) % 200) then
		exports.GTIhud:dm(skill[4].." Skill Upgraded. Keep practicing and you'll reach gangster level.", 255, 215, 0)

	elseif ((stat+cur_skill) % 1000 > (stat+weapon_stats[skill[2]]) % 1000) then
		local notice = gangster_level[weapon]
		notice = split(notice, "\n")
		exports.GTIhud:dm(notice[1], 255, 215, 0)
		if (notice[2]) then
			exports.GTIhud:dm(notice[2], 255, 215, 0)
		end
	
	end
end

setTimer(function()
	triggerServerEvent("GTIplayerStats.modifyWeaponStats", resourceRoot, weapon_stats)
	weapon_stats = {
		[69] = 0, [70] = 0, [71] = 0, [72] = 0, [73] = 0, 
		[74] = 0, [75] = 0, [76] = 0, [77] = 0, [78] = 0, 
	}
end, STAT_UPDATE, 0)

-- Record Weapon Stats
----------------------->>

addEventHandler("onClientPlayerDamage", root, function(attacker, weapon, _, loss)
	if (attacker ~= localPlayer or source == localPlayer or not weapon_levels[weapon] or loss == 0) then return end
	if (wasEventCancelled()) then return end
	increaseWeaponSkill(weapon, weapon_levels[weapon][3])
end)

addEventHandler("onClientVehicleDamage", root, function(attacker, weapon, loss)
	if (attacker ~= localPlayer or not weapon_levels[weapon] or loss == 0) then return end
	if (wasEventCancelled()) then return end
	increaseWeaponSkill(weapon, weapon_levels[weapon][3])
end)
