----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 16 Mar 2015
-- Resource: GTIplayerStats/weapon_skills.lua
-- Version: 1.0
----------------------------------------->>

local weapon_levels = {
	[22] = {"Pistol",		69,		20,	40},	-- Pistol
	[23] = {"Taser",		70,		20,	500},	-- Taser
	[24] = {"Desert Eagle",		71,		10, 	200},	-- Desert Eagle
	[25] = {"Shotgun",		72,		10,	200},	-- Shotgun
	[26] = {"Sawn-Off Shotgun",	73,		5,	200},	-- Sawn-off Shotgun
	[27] = {"Combat Shotgun",	74,		5,	200},	-- Combat Shotgun
	[28] = {"Machine Pistol",	75,		10,	50},	-- Micro Uzi
	[32] = {"Machine Pistol",	75,		10,	50},	-- Tec-9
	[29] = {"SMG",			76,		2,	250},	-- SMG		-- Org Int: 1.5
	[30] = {"AK-47",		77,		5,	200},	-- AK-47	-- Org Int: 3
	[31] = {"M4",			78,		5,	200},	-- M4		-- Org Int: 2
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
local hitmanLevel = false

--[[ Ammunation Weapon skill training

local training = false

local markers = { 
	{2179.112, 951.546, 10.096},
	{2178.957, 954.375, 10.096},
	{2179.237, 948.231, 10.096},
}

-- Ped 1, 2, 3, 4, 5, 6, 7, 8
local peds = {
	{2187.602, 951.493, 10.096, 2187.708, 947.652, 10.096, 2185.902, 949.369, 10.096, 2187.241, 955.203, 10.096, 2194.533, 950.899, 10.096, 2192.916, 945.972, 10.096, 2186.513, 956.673, 10.096, 2202.281, 951.206, 10.096, 2201.908, 948.093, 10.096, 2200.621, 956.107, 10.096},
	{2185.105, 956.070, 10.096, 2189.073, 956.194, 10.096, 2192.653, 956.078, 10.096, 2196.167, 956.176, 10.096, 2199.893, 956.201, 10.096, 2201.282, 951.561, 10.096, 2201.542, 948.467, 10.096, 2197.157, 946.637, 10.096, 2193.918, 946.733, 10.096, 2190.118, 946.846, 10.096},
	{2187.007, 944.579, 10.096, 2186.804, 946.752, 10.096, 2186.848, 949.161, 10.096, 2186.892, 951.566, 10.096, 2186.925, 953.399, 10.096, 2186.969, 955.803, 10.096, 2187.014, 958.211, 10.096, 2183.827, 958.509, 10.096, 2182.461, 958.534, 10.096, 2200.906, 951.936, 10.096},
	{2205.848, 956.784, 10.096, 2205.404, 953.806, 10.096, 2205.234, 951.270, 10.096, 2205.087, 949.094, 10.096, 2204.925, 946.683, 10.096, 2204.800, 944.826, 10.096, 2200.935, 945.073, 10.096, 2200.546, 948.944, 10.096, 2200.010, 953.343, 10.096, 2200.241, 956.790, 10.096},
}

function createMarkers ( )
	for i, v in ipairs ( markers ) do
		local x = v[1]
		local y = v[2]
		local z = v[3]
		Marker = createMarker ( x, y, z, "cylinder", 1, 255, 0, 255, 100 )
		addEventHandler ("onClientMarkerHit", Marker, startMission )
    end   
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )

function startMission ( player )
	if player == localPlayer and training == false then
		training = true
		loc = math.random ( #peds )
		ped1 = createPed ( 0, peds[loc][1], peds[loc][2], peds[loc][3]+1 )
		ped2 = createPed ( 0, peds[loc][4], peds[loc][5], peds[loc][6]+1 )
		ped3 = createPed ( 0, peds[loc][7], peds[loc][8], peds[loc][9]+1 )
		ped4 = createPed ( 0, peds[loc][10], peds[loc][11], peds[loc][12]+1 )
		ped5 = createPed ( 0, peds[loc][13], peds[loc][14], peds[loc][15]+1 )
		ped6 = createPed ( 0, peds[loc][16], peds[loc][17], peds[loc][18]+1 )
		ped7 = createPed ( 0, peds[loc][19], peds[loc][20], peds[loc][21]+1 )
		ped8 = createPed ( 0, peds[loc][22], peds[loc][23], peds[loc][24]+1 )
		ped9 = createPed ( 0, peds[loc][25], peds[loc][26], peds[loc][27]+1 )
		ped10 = createPed ( 0, peds[loc][28], peds[loc][29], peds[loc][30]+1 )
		exports.GTIhud:dm("Shoot the peds to train your weapon skills, you have 1 minute!", 255, 255, 0 )
		seconds = 60
		timer1 = setTimer ( timerCountDown, 1000, 60 )
	end
end

function convertSecsToTime(seconds)
        local hours = 0
        local minutes = 0
        local secs = 0
        local theseconds = seconds
        if theseconds >= 60*60 then
            hours = math.floor(theseconds / (60*60))
            theseconds = theseconds - ((60*60)*hours)
        end
        if theseconds >= 60 then
            minutes = math.floor(theseconds / (60))
            theseconds = theseconds - ((60)*minutes)
        end
        if theseconds >= 1 then
            secs = theseconds
        end
        if minutes < 10 then
            minutes = "0"..minutes
        end
        if secs < 10 then
            secs = "0"..secs
        end
    return minutes,secs
end

function timerCountDown()
        seconds = seconds - 1
        local mins,secds = convertSecsToTime(seconds)
        if mins == "00" and secds == "00" then --time is up
            killTimer(timer1)
            destroyPeds()
            exports.GTIhud:drawStat("ammuRangeTimer", "", "", 200, 0, 0)
        else
            exports.GTIhud:drawStat("ammuRangeTimer", "Time left", mins..":"..secds, 200, 0, 0)
        end
    end
	
function destroyPeds ( )
	training = false
    if isElement ( ped1 ) then
	    destroyElement ( ped1 )
	end
    if isElement ( ped2 ) then
	    destroyElement ( ped2 )
	end
    if isElement ( ped3 ) then
	    destroyElement ( ped3 )
	end
    if isElement ( ped4 ) then
	    destroyElement ( ped4 )
	end
    if isElement ( ped5 ) then
	    destroyElement ( ped5 )
	end
    if isElement ( ped6 ) then
	    destroyElement ( ped6 )
	end
    if isElement ( ped7 ) then
	    destroyElement ( ped7 )
	end
    if isElement ( ped8 ) then
	    destroyElement ( ped8 )
	end
    if isElement ( ped9 ) then
	    destroyElement ( ped9 )
	end
    if isElement ( ped10 ) then
	    destroyElement ( ped10 )
	end
end
]]
-- Increase Skill
------------------>>

function increaseWeaponSkill(weapon, amount)
	if (not weapon_levels[weapon] or not tonumber(amount) or hitmanLevel) then return end
	local skill = weapon_levels[weapon]
	local cur_skill = weapon_stats[skill[2]]
	local stat = getPedStat(localPlayer, skill[2])
	weapon_stats[skill[2]] = weapon_stats[skill[2]] + amount

	if ( stat+cur_skill >= 1000 ) then -- Hitman level reached
		hitmanLevel = true
		local notice = hitman_level[weapon]
		notice = split(notice, "\n")
		exports.GTIhud:dm(notice[1], 255, 215, 0)
		if (notice[2]) then
			exports.GTIhud:dm(notice[2], 255, 215, 0)
		end
		updateStats()
	elseif ( stat+cur_skill >= skill[4] and stat+cur_skill <= 999 and stat+cur_skill % 200 == 0 ) then -- Close to Hitman
		exports.GTIhud:dm(skill[4].." Skill Upgraded. Keep practicing and you'll reach hitman level.", 255, 215, 0)
		if (weapon == 22 or weapon == 26 or weapon == 28 or weapon == 32) then
			exports.GTIhud:dm("Hitman level allows you to wield two "..string.lower(skill[1]).."s simultaneously", 255, 215, 0)
		end
		updateStats()
	elseif ( stat+cur_skill == skill[4] ) then -- Gangster level reached
		local notice = gangster_level[weapon]
		notice = split(notice, "\n")
		exports.GTIhud:dm(notice[1], 255, 215, 0)
		if (notice[2]) then
			exports.GTIhud:dm(notice[2], 255, 215, 0)
		end
		updateStats()
	elseif ( stat+cur_skill <= skill[4] and stat+cur_skill % 200 == 0  ) then -- Close to gangster
		exports.GTIhud:dm(skill[4].." Skill Upgraded. Keep practicing and you'll reach gangster level.", 255, 215, 0)
		updateStats()
	end
end


function updateStats ()
	triggerServerEvent("GTIplayerStats.modifyWeaponStats", resourceRoot, weapon_stats)
	weapon_stats = {
		[69] = 0, [70] = 0, [71] = 0, [72] = 0, [73] = 0, 
		[74] = 0, [75] = 0, [76] = 0, [77] = 0, [78] = 0, 
	}
end
setTimer(updateStats, STAT_UPDATE, 0)
addEventHandler("onClientResourceStop", resourceRoot, updateStats)

-- Record Weapon Stats
----------------------->>

addEventHandler("onClientPlayerDamage", root, 
	function (attacker, weapon, _, loss)
		if (attacker ~= localPlayer or source == localPlayer or not weapon_levels[weapon] or weapon == 34) then return end
		if ( wasEventCancelled ( ) ) then return end
		if ( getPedStat ( localPlayer, weapon_levels[weapon][2] ) == 1000 ) then return end
		if ( getElementData(source,"groupID") == getElementData(attacker,"groupID")) then return end
		if ( exports.GTIsafezones:isElementWithinSafezone( source ) ) then return end
		if ( exports.GTIgangTerritories:canPlayerTurf ( source ) and not exports.GTIgangTerritories:canPlayerTurf ( attacker ) ) then return end
		if ( exports.GTIgangTerritories:canPlayerTurf ( attacker ) and not exports.GTIgangTerritories:canPlayerTurf ( source ) ) then return end
		if ( exports.GTIutil:isPlayerInTeam(source, "Government") ) then return end
		if ( exports.GTIutil:isPlayerInTeam(source, "Law Enforcement") and exports.GTIutil:isPlayerInTeam(attacker, "Law Enforcement") ) then return end
		if ( getElementData(attacker, "job") == "Police Officer" and getElementData(source, "wanted") == 0 ) then return end
		if ( getElementData(attacker, "job") == "Police Officer" and getElementData(attacker, "isWorking") ~= 1 ) then return end
		if ( getElementData(source,"freecam:state") ) then return end
		outputDebugString("Increasing weapon stats...")
		increaseWeaponSkill(weapon, weapon_levels[weapon][3])
	end
)

--[[
addEventHandler ("onClientPedDamage", root,
	function ( attacker, weapon, _, loss )
		if (attacker ~= localPlayer or source == localPlayer or not weapon_levels[weapon] or weapon == 34) then return end
		if training == false then return end
		outputDebugString("Increasing weapon stats...")
		increaseWeaponSkill(weapon, weapon_levels[weapon][3])
	end
)]]
