----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 16 Mar 2015
-- Resource: GTIplayerStats/wep_training/wep_training.lua
-- Version: 1.0
----------------------------------------->>

local training = false
local Peds = {}

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

local Markers = { 
	{2179.112, 951.546, 10.096},
	{2178.957, 954.375, 10.096},
	{2179.237, 948.231, 10.096},
	{2558.738, 2094.409, 10.107},
	{2559.016, 2091.404, 10.107},
	{2558.736, 2088.299, 10.107},
	{1385.970, -1287.527, 17.010},
	{1386.158, -1290.223, 17.010},
	{1386.037, -1293.297, 17.010},
	{1385.999, -1296.319, 17.010},
	{2322.223, 44.549, 20.585},
	{2320.747, 44.841, 20.585},
	{2319.373, 44.841, 20.585},
	{2317.899, 44.841, 20.585},
	{215.326, -158.340, -4.744},
	{218.061, -158.660, -4.744},
	{221.037, -158.605, -4.744},
}


local Locations = {
	[1] = { "Come-A-Lot", 10.096, {
		{2187.602, 951.493}, 
		{2187.708, 947.652},
		{2185.902, 949.369},
		{2187.241, 955.203},
		{2194.533, 950.899},
		{2192.916, 945.972},
		{2186.513, 956.673},
		{2202.281, 951.206},
		{2201.908, 948.093},
		{2200.621, 956.107},
		{2185.105, 956.070},
		{2189.073, 956.194},
					},
	},
	[2] = { "Old Venturas Strip", 10.107, {
		{2573.735, 2096.411},
		{2573.772, 2092.276},
		{2577.568, 2090.037},
		{2571.874, 2087.785},
		{2581.567, 2088.011},
		{2582.143, 2094.744},
		{2570.183, 2094.273},
		{2568.525, 2088.855},
		{2581.630, 2097.552},
		{2584.831, 2092.323},
		{2568.162, 2088.948},
		{2567.729, 2085.088},
					},
	},
	[3] = { "Downtown Los Santos", 18.002, {
		{1397.820, -1285.592},
		{1402.663, -1285.632},
		{1406.888, -1285.667},
		{1407.711, -1290.119},
		{1407.674, -1294.545},
		{1403.564, -1294.745},
		{1399.763, -1294.714},
		{1396.789, -1294.689},
		{1396.576, -1291.970},
		{1396.600, -1289.034},
		{1399.547, -1290.828},
		{1402.555, -1290.853},
					},
	},
	[4] = { "Palomino Creek", 21.300, {
		{2318.315, 31.575},
		{2321.368, 23.677},
		{2318.756, 22.081},
		{2323.706, 32.366},
		{2323.840, 22.088},
		{2318.736, 21.291},
		{2316.311, 31.696},
		{2324.679, 34.960},
		{2324.824, 24.281},
		{2320.474, 41.055},
		{2317.842, 40.714}, 
		{2317.842, 40.914},
					},
	},
	[5] = { "Red County", -3.400, {
		{215.805, -152.422},
		{215.406, -148.556},
		{214.954, -144.589},
		{214.466, -140.6034},
		{217.202, -139.779},
		{219.915, -139.559},
		{221.640, -141.049},
		{222.228, -143.821},
		{222.713, -146.106},
		{223.087, -147.870},
		{221.030, -148.547},
		{220.312, -146.233},
					},
	},

}


function createPeds (player)
	if ( player ~= localPlayer ) then return end
	if ( not isPedOnGround(player) ) then return end
	if ( training ) then return end
	training = true
	killed = 0
	for index, data in pairs (Locations) do
		local Location, Height, PedsInfo = data[1], data[2], data[3]
			if ( Location == getZoneName(getElementPosition(localPlayer)) ) then
				for pedIndex, dataPeds in pairs (PedsInfo) do
					Peds[pedIndex] = createPed(0, dataPeds[1], dataPeds[2], Height)
					startMoving(Peds[pedIndex])
				end
			end
	end
	updateKilled(true)
end

addEventHandler ("onClientResourceStart", resourceRoot, 
	function ()
		for i,v in ipairs (Markers) do
			marker = createMarker(v[1], v[2], v[3], "cylinder", 1, 255, 0, 255, 100 )
			colshape = createColSphere ( v[1], v[2], v[3]+1, 1 )
			addEventHandler("onClientColShapeHit", colshape, createPeds)
		end
	end
)

local Moving = {}

function startMoving(Ped)
	setPedAnimation(Ped, "ped", "WALK_player", -1, true, true, false, false)
	Moving[Ped] = setTimer(
		function (thePed)
			setElementRotation(thePed, 0, 0, math.random(1, 360), "default", true)
		end, 2500, 0, Ped)
end

addEventHandler("onClientPedWasted", root,
	function (killer)
		if ( not killer == localPlayer ) then return end
		if ( isTimer(Moving[source]) ) then
			killTimer(Moving[source])
			killed = killed + 1
			updateKilled()
		end
	end
)

function updateKilled(start, finish)
	exports.GTIhud:drawStat("ammu_killed", "Killed peds", killed.."/"..#getElementsByType("ped", resourceRoot), 200, 0, 0)
		if ( start ) then
			exports.GTIhud:dm("Shoot the peds to train your weapon skills, you have 1 minute!", 255, 255, 0 )
			seconds = 60
			timer1 = setTimer ( timerCountDown, 1000, 60 )
		elseif ( finish ) then
			training = false
			killTimer(timer1)
         	exports.GTIhud:drawStat("ammuRangeTimer", "", "", 200, 0, 0)
			exports.GTIhud:drawStat("ammu_killed", "", 200, 0, 0)
			exports.GTIhud:dm("To Increase weapon to max Skill you need to reach Hitman level, you can redo the training!", 255, 255, 0 )
				for _, peds in ipairs ( getElementsByType("ped", resourceRoot) ) do
					destroyElement(peds)
					if isTimer ( Moving[peds] ) then killTimer(Moving[peds]) 
				end
			end
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
		updateKilled(false, true)
		training = false
        else
            exports.GTIhud:drawStat("ammuRangeTimer", "Time left", mins..":"..secds, 200, 0, 0)
        end
    end

addEventHandler ("onClientPedDamage", root,
	function ( attacker, weapon, _, loss )
		--if ( not attacker == localPlayer ) then return end 
		if (attacker ~= localPlayer or not weapon_levels[weapon] or weapon == 34) then return end
		if ( not training ) then return end
		--if ( not weapon_levels[weapon] or weapon == 34 ) then return end
		outputDebugString("Increasing weapon stats...", 3)
		increaseWeaponSkill(weapon, weapon_levels[weapon][3])
	end
)
