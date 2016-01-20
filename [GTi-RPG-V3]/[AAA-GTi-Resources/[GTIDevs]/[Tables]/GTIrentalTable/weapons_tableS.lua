----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 07 Mar 2015
-- Resource: GTIrentals/weapons_table.slua
-- Version: 1.0
----------------------------------------->>

function weaponsTable()	return weapons end

weapons = {
-- Police Officer (LS)
----------------------->>
-- Basic Tools
{id=3,	ammo=1, 	pos={1564.780, -1672.129, 15.191},	res={"Police"}},	-- Nightstick
{id=23,	ammo=150, 	pos={1562.477, -1672.129, 15.191},	res={"Police"}},	-- Taser (Silenced Pistol)
-- Advanced Tools
{id=43,	ammo=50, 	pos={1548, -1635.200, 12.555},	res={"Police;2"}},	-- Camera
{id=25,	ammo=50, 	pos={1551, -1635.200, 12.555},	res={"Police"}},	-- Shotgun
{id=24,	ammo=150, 	pos={1554, -1635.200, 12.555},	res={"Police;3"}},	-- Desert Eagle
{id=28,	ammo=300, 	pos={1557, -1635.200, 12.555},	res={"Police;2"}},	-- Uzi
{id=29,	ammo=300, 	pos={1563, -1635.200, 12.555},	res={"Police;3"}},	-- MP5
{id=31,	ammo=500, 	pos={1566, -1635.200, 12.555},	res={"Police;3"}},	-- AK-47
{id=33,	ammo=20, 	pos={1569, -1635.200, 12.555},	res={"Police;4"}},	-- Country Rifle
{id=45,	ammo=1, 	pos={1572, -1635.200, 12.555},	res={"Police;5"}},	-- IR Goggles

-- Police Officer (Dillimore)
----------------------->>
-- Basic Tools
{id=3,	ammo=1, 	pos={629.552, -552.551, 71.209, 24, 122},	res={"Police"}},	-- Nightstick
{id=23,	ammo=150, 	pos={629.901, -550.148, 71.20924, 24, 122},	res={"Police"}},	-- Taser (Silenced Pistol)

-- Police Officer (Angel Pine)
----------------------->>
-- Basic Tools
{id=3,	ammo=1, 	pos={629.552, -552.551, 71.209, 23, 123},	res={"Police"}},	-- Nightstick
{id=23,	ammo=150, 	pos={629.901, -550.148, 71.20924, 23, 123},	res={"Police"}},	-- Taser (Silenced Pistol)

-- Police Officer (SF)
----------------------->>
-- Basic Tools
{id=3,	ammo=1, 	pos={241.507, 118.507, 1002.219, 10, 142},	res={"Police"}},	-- Nightstick
{id=23,	ammo=150, 	pos={243.808, 118.523, 1002.219, 10, 142},	res={"Police"}},	-- Taser (Silenced Pistol)
-- Advanced Tools
{id=43,	ammo=50, 	pos={251.835, 107.854, 1002.219, 10, 142},	res={"Police;2"}},	-- Camera
{id=25,	ammo=50, 	pos={240.764, 113.186, 1002.219, 10, 142},	res={"Police"}},	-- Shotgun
{id=24,	ammo=150, 	pos={240.772, 115.014, 1002.219, 10, 142},	res={"Police;3"}},	-- Desert Eagle
{id=28,	ammo=300, 	pos={251.547, 117.103, 1002.219, 10, 142},	res={"Police;2"}},	-- Uzi
{id=29,	ammo=300, 	pos={251.526, 113.663, 1002.219, 10, 142},	res={"Police;3"}},	-- MP5
{id=31,	ammo=500, 	pos={251.523, 112.098, 1002.219, 10, 142},	res={"Police;3"}},	-- AK-47
{id=33,	ammo=20, 	pos={240.770, 111.374, 1002.219, 10, 142},	res={"Police;4"}},	-- Country Rifle
{id=45,	ammo=1, 	pos={249.386, 108.248, 1002.219, 10, 142},	res={"Police;5"}},	-- IR Goggles

-- Police Officer (LV)
----------------------->>
-- int:0,dim:0
-- Basic Tools
{id=3,	ammo=1, 	pos={2339.992, 2481.769, 13.987, 0, 0},	res={"Police"}},	-- Nightstick
{id=23,	ammo=150, 	pos={2340.124, 2479.205, 13.987, 0, 0},	res={"Police"}},	-- Taser (Silenced Pistol)
-- Advanced Tools
{id=43,	ammo=50, 	pos={2351.595, 2471.983, 13.979, 0, 0},	res={"Police;2"}},	-- Camera
{id=25,	ammo=50, 	pos={2351.540, 2469.477, 13.979, 0, 0},	res={"Police"}},	-- Shotgun
{id=24,	ammo=150, 	pos={2351.595, 2467.389, 13.979, 0, 0},	res={"Police;3"}},	-- Desert Eagle
{id=28,	ammo=300, 	pos={2351.616, 2464.554, 13.979, 0, 0},	res={"Police;2"}},	-- Uzi
{id=29,	ammo=300, 	pos={2348.396, 2464.608, 13.979, 0, 0},	res={"Police;3"}},	-- MP5
{id=31,	ammo=500, 	pos={2344.575, 2464.676, 13.979, 0, 0},	res={"Police;3"}},	-- M4
{id=33,	ammo=20, 	pos={2334.217, 2464.604, 13.979, 0, 0},	res={"Police;4"}},	-- Country Rifle
{id=45,	ammo=1, 	pos={2330.667, 2464.562, 13.979, 0, 0},	res={"Police;5"}},	-- IR Goggles

-- Police Officer El Cebrados(Desert)
----------------------->>
{id=3,	ammo=1, 	pos={326.815, 308.741, 998.148, 5, 0},	res={"Police"}},	-- Nightstick
{id=23,	ammo=150, 	pos={326.827, 306.696, 998.148, 5, 0},	res={"Police"}},	-- Taser (Silenced Pistol)

-- Police Officer Fort Carson(Desert)
----------------------->>
{id=3,	ammo=1, 	pos={-216.010, 984.605, 18.380, 0, 0},	res={"Police"}},	-- Nightstick
{id=23,	ammo=150, 	pos={-216.189, 987.490, 18.437, 0, 0},	res={"Police"}},	-- Taser (Silenced Pistol)


-- Medic (LS)
----------------------->>
{id=41,	ammo=5000, 	pos={1161.941, -1326.484, 14.386},			res={"Paramedic"}},	-- SprayCan		All Saints Hospital
{id=41,	ammo=5000, 	pos={2036.777, -1389.629, 16.238},			res={"Paramedic"}},	-- SprayCan		Jefferson Hospital
-- Medic (SF)
----------------------->>
{id=41,	ammo=5000, 	pos={693.606, 501.382, 228.152, 1, 176},	res={"Paramedic"}},	-- SprayCan
-- Medic (LV)
----------------------->>
{id=41,	ammo=5000, 	pos={685.882, 501.325, 228.152, 1, 174},	res={"Paramedic"}},	-- SprayCan

-- Quarry Miner (LV)
----------------------->>
{id=6,	ammo=1, 	pos={319.176, 857.368, 19.406},			res={"Quarry Miner"}},	-- Shovel

-- Firefighter [LV]
----------------------->>
{id=42,	ammo=5000, 	pos={1771.700, 2080.510, 9.820},		res={"Firefighter"}},	-- Fire Extinguisher

-- Firefighter [LS]
----------------------->>
{id=42,	ammo=5000, 	pos={1280.854, -1245.275, 12.669},		res={"Firefighter"}},	-- Fire Extinguisher

-- Firefighter [SF]
----------------------->>
{id=42,	ammo=5000, 	pos={-2025.188, 70.050, 27.433},		res={"Firefighter"}},	-- Fire Extinguisher


-- Pilot Job [SF]
----------------------->>
{id=46,	ammo=1, 	pos={-1868.234, 43.970, 1054.184, 14, 145},		res={"Pilot"}},	--Parachute
-- Pilot Job [LS]
----------------------->>
{id=46,	ammo=1, 	pos={-1868.116, 43.975, 1054.184, 14, 144},		res={"Pilot"}},	--Parachute
-- Pilot Job [LV]
----------------------->>
{id=46,	ammo=1, 	pos={-1868.371, 43.985, 1054.184, 14, 146},		res={"Pilot"}},	--Parachute

-- Journalist Job [LS]
----------------------->>
{id=43,	ammo=100, 	pos={648.395, -1352.915, 12.559},		res={"Journalist"}},	--Camera

-- Star Tower Parachute
----------------------->>
{id=46,	ammo=1, 	pos={1537.812, -1365.778, 328.461, 0, 0}},	--Parachute

-- Groups

-- GHoST
{id=46,	ammo=1, 	pos={1375.881, 718.714, 0.135}}, -- Parachute
{id=45,	ammo=1, 	pos={1377.135, 724.187, 0.135}}, -- InfraRed
{id=44,	ammo=1, 	pos={1377.240, 728.004, 0.135}}, -- Night Vison

-- Quality 7
{id=46,	ammo=1, 	pos={2605.383, 658.739, 13.793}},
{id=45,	ammo=1, 	pos={2578.918, 616.932, 15.208}},
{id=44,	ammo=1, 	pos={2579.004, 615.703, 15.208}},

--[[ Dem Boys
{id=46,	ammo=1, 	pos={2389.523, 1928.113, 19.639}}, -- Parachute
{id=45,	ammo=1, 	pos={2407.480, 1925.769, 10.669}}, -- InfraRed]]

-- CIA
{id=46,	ammo=1, 	pos={1934.011, -1300.548, 14.828}}, -- Parachute
{id=45,	ammo=1, 	pos={1957.131, -1291.405, 19.769}}, -- InfraRed
{id=44,	ammo=1, 	pos={1961.184, -1291.400, 19.769}}, -- Night Vison

-- Rude Prawns
{id=46,	ammo=1, 	pos={1585.711, 1057.150, 9.909}}, -- Parachute
{id=45,	ammo=1, 	pos={1586.339, 1051.217, 9.909}}, -- InfraRed
{id=44,	ammo=1, 	pos={1586.497, 1054.479, 9.909}}, -- Night Vison
}
