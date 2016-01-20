----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

local foodStores = {
	-- Burger Shots
{1200.413, -918.528, 43.112, 10},   -- Mulholland, LS
{810.830, -1616.094, 13.546, 10},   -- Marina, LS
{1176.936, -1437.629, 15.796, 10},  -- Market, LS
{-2336.182, -166.779, 35.554, 10},  -- Garcia, SF
{-1912.099, 828.147, 35.205, 10},   -- Downtown, SF
{-2356.808, 1008.071, 50.898, 10},  -- Juniper Hollow, SF
{1158.207, 2072.208, 11.062, 10},   -- Whitewood Estates, LV
{1872.776, 2071.883, 11.062, 10},   -- Redsands East, LV
{2170.282, 2795.774, 10.820, 10},   -- Spinybed, LV
{2366.213, 2070.998, 10.820, 10},   -- Old Venturas Strip, LV
{2472.069, 2034.090, 11.062, 10},   -- Old Venturas Strip, LV
    -- Cluckin Bell
{2397.749, -1898.438, 13.546, 14},  -- Willowfield, LS
{2420.372, -1508.951, 24, 14},      -- East LS, LS
{934.940, -1358.942, 12.351, 14},   -- Market, LS
{-2154.987, -2460.417, 30.851, 14}, -- Whetstone, SF
{-2672.449, 258.561, 4.632, 14},    -- Ocean Flats, SF
{-1816.506, 617.286, 35.171, 14},   -- Downtown, SF
{-2490.391, 2287.956, 5.156, 14},	-- Bayside, SF
{-1213.416, 1830.782, 41.929, 14},  -- Tierra Robada, LV
{172.791, 1176.790, 14.757, 14},    -- Bone County, LV
{2102.897, 2228.837, 11.023, 14},   -- The Emerald Isle, LV
{2846.290, 2414.998, 11.068, 14},   -- Creek, LV
{2392.984, 2042.247, 10.820, 14},   -- Old Venturas Strip, LV
{2637.669, 1671.942, 11.023, 14},   -- Starfish Casino, LV
    -- Well Stacked Pizza Co.
{2105.479, -1806.513, 13.554, 29},  -- Idlewood, LS
{1084.639, -1448.527, 21.742, 29},  -- Market, LS
{1379.854, 238.539, 18.568, 29},    -- Montomery, LS
{206.508, -186.751, 0.585, 29},     -- Blueberry, LS
{-1808.0712, 945.398, 24.890, 29},  -- Financial, SF
{-1721.782, 1359.757, 7.185, 29},   -- Esplanade North, SF
{2083.343, 2224.089, 11.0234, 29},  -- The Emerald Isle, LV
{2351.811, 2532.613, 10.820, 29},   -- Roca Escalante, LV
{2756.495, 2477.017, 11.062, 29},   -- Creek, LV
{2637.850, 1849.898, 11.023, 29},   -- Starfish Casino, LV
    -- Rusty Brown's Ring Donuts
{1038.270, -1340.133, 13.737, 17},  -- Market, LS
{-2767.755, 788.823, 52.781, 17},   -- Palisades, SF
}

local repair = {
    -- Pay 'n Sprays
{2063.756, -1830.898, 12.579, 63},  -- Idlewood, LS
{1024.893, -1023.755, 31.156, 63},  -- Temple, LS
{487.884, -1739.575, 10.173, 63},   -- Santa Maria Beach, LS
{720.099, -455.197, 15.370, 63},    -- Dillimore, LS
{2414.073, 96.293, 25.512, 63},     -- Palomino Creek, LS
{272.565, 10.850, 1.437, 63},       -- Blueberry, LS
{-2106.065, -2242.464, 29.662, 63}, -- Angel Pine, WS
{-1904.306, 285.392, 40.081, 63},   -- Doherty, SF
{-1786.758, 1215.358, 24.153, 63},  -- Downtown, SF
{-2425.901, 1020.659, 49.428, 63},  -- Juniper Hollow, SF
{-1420.836, 2583.315, 54.872, 63},  -- El Quebrados, LV
{-99.972, 1119.257, 18.773, 63},    -- Fort Carson, LV
{1976.324, 2162.446, 10.101, 63},   -- Redsands East, LV
{2393.914, 1491.271, 9.853, 63},    -- The Camel's Toe, LV
{1999.705, -2539.229, 12.547, 63},  -- LS Airport
{-1657.041, -371.911, 13.148, 63},  -- SF Airport
{1325.233, 1488.135, 9.820, 63},    -- LV Airport
{389.487, 2536.321, 15.539, 63},    -- Verdant Meadows
{2386.662, 1051.640, 9.820, 63},    -- Come'A'Lot, LV
{-2406.114, 2357.008, 4.306, 63},   -- Bayside, SF
{1629.675, 568.285, 0, 63},          -- LV's sea
    -- Vehicle Mod Shops
{1041.39, -1018.62, 31.5, 27},      -- Temple, LS
{2412.27, -2471.46, 12.5, 27},      -- Ocean Docks, LS
{1643.7539, -1516.0722, 12.56, 27}, -- Downtown Los Santos, LS
{1431.993, -2439.917, 12.555, 27},  -- LS Airport, LS
{94.862, -2008.983, 0, 27},         -- Santa Maria Beach, LS
{2414.339, 86.644, 25.512, 27},     -- Palomino Creek, LS
{263.860, 9.043, 1.441, 27},        -- Blueberry, LS
{-2723.7060, 217.2689, 2.6133, 27}, -- Ocean Flats, SF
{-2027.204, 124.581, 28.107, 27},   -- Doherty, SF
{-1936.240, 245.037, 33.461, 27},   -- Doherty, SF
{-1598.853, -631.776, 13.148, 27},  -- Easter Bay Airport, SF
{-1561.03, 1247.93, 0.53, 27},      -- SF Boat Shop
{1990.6890, 2056.8046, 9.3844, 27}, -- LV Transfender
{1409.777, 1811.573, 9.82, 27},     -- Las Venturas Airport, LV
{2171.190, 1393.786, 9.991, 27},    -- Royal Casino, LV
}

local stores = {
    -- Clothing Stores
{2244.47, -1665.36, 14.4839, 45},   -- Binco
{-2375.32, 910.293, 44.4578, 45},   -- Binco
{1657.01, 1733.33, 10.0209, 45},    -- Binco
{2102.69, 2257.49, 10.0579, 45},    -- Binco
{2112.73, -1211.7, 22.9614, 45},    -- Sub Urban
{-2491.98, -29.1065, 24.817, 45},   -- Sub Urban
{2779.12, 2453.54, 10.061, 45},     -- Sub Urban
{499.637, -1360.4, 15.4261, 45},    -- ProLaps
{2825.74, 2407.44, 10.061, 45},     -- ProLaps
{1456.77, -1138.02, 23.2872, 45},   -- Zip
{-1883.2, 865.473, 34.2601, 45},    -- Zip
{2572.07, 1904.83, 10.0231, 45},    -- Zip
{2090.58, 2224.2, 10.0579, 45},     -- Zip
{461.158, -1499.98, 30.1742, 45},   -- Victim
{-1694.76, 951.599, 24.2706, 45},   -- Victim
{2802.34, 2430.6, 10.061, 45},      -- Victim
{453.868, -1478.07, 29.9609, 45},   -- Didier Sachs
    -- Car Dealerships
{-1955.125, 281.136, 34.469, 55},
{543.406, -1286.679, 16.242, 55},
{2131.485, -1148.304, 0, 55},
{2217.884, -2229.984, 0, 55},
{1011.199, -1302.447, 13.102, 55},
{2168.244, 1439.720, 10.095, 55},
    -- Banks
{-2055.835, 455.381, 34.172, 52},   -- San Fierro
{1571.137, -1336.688, 15.484, 52},  -- Los Santos
{1043.151, 1011.417, 10.000, 52},   -- Las Venturas
    -- Boat Dealerships
{92.075, -1936.041, -1.550, 9},
{-1450.850, 732.765, 14.195, 9},
{2325.390, 542.573, 15.285, 9},
    -- Aircraft Dealerships
{1895.694, -2216.447, 13.665, 5},
{-1394.028, -512.793, 14.214, 5},
{1553.362, 1190.182, 38.023, 5},
    -- Gyms
{2229.629, -1721.630, 13.564, 54},  -- LS
{1968.490, 2294.082, 16.455, 54},   -- SF
{-2267.939, -155.663, 35.320, 54},  -- LV
{656.849, -1864.334, 4.460, 54},    -- Verona Beach, LS
	-- 24/7 Stores
{1833.191, -1843.100, 12.471, 36},
{1315.682, -898.317, 38.471, 36},
{-1561.899, -2733.909, 47.774, 36},
{2452.904, 2064.314, 9.836, 36},
{2247.829, 2396.553, 9.852, 36},
{2334.470, 74.189, 25.484, 36},
{251.660, -63.474, 0.578, 36},
}

local ammu = {
    -- Ammu-Nations
{2551.356, 2086.977, 28.457, 6},
{2177.172, 949.439, 24.555, 6},
{780.521, 1870.890, 15.036, 6},
{-1506.479, 2608.674, 66.235, 6},
{-2627.385, 214.201, 15.361, 6},
{-2097.466, -2466.751, 40.008, 6},
{242.550, -178.419, 1.578, 6},
{2337.398, 63.850, 26.479, 6},
{2397.520, -1978.633, 13.546, 6},
{1365.328, -1280.046, 13.546, 6},
{-314.784, 832.984, 14.242, 6},
}

local atms = {
	{2072.3999, -1825.6, 12.5, 0},
	{1367.1, -1275.5, 12.5},
	{1030, -1030.4, 31},
	{2334.8999, 67.9, 25.4},
	{-304.5, 1054.4, 18.7},
	{1268.1, 346.9, 18.6},
	{-1505.1, 2612.1001, 54.8},
	{-824, 1502.1, 18.5},
	{-79.3, -1170.8, 1.1},
	{-2475.3, 2312.6001, 4},
	{-2101, -2434.8, 29.6},
	{2667.1001, -2514.3, 12.6},
	{1663.9, -1171.3, 23},
	{1837.7, -1449.9, 12.6},
	{2235.3999, -1149.8, 24.8},
	{485.5, -1733.2, 10},
	{1938.3, 2292.3, 9.8},
	{2660.7, -1440, 29.5},
	{2024, 1017.6, 9.7},
	{2043.4, 1733.1, 9.8},
	{1626.6, 1815, 9.8},
	{2548.8, 1972.1, 9.8},
	{2383.1001, 1543.3, 9.8},
	{-1473, -266.9, 13.1},
	{1458.5, 2778.1001, 9.8},
	{2141.7, 2734.5, 10.1},
	{-2282, 582.6, 34},
	{-2269.1001, -51.9, 34.3},
	{-1908.9, 276.6, 40},
	{-2354, 1001.3, 49.7},
	{-1570.8, 687, 6.1},
	{2299.630, 2431.838, 9.820},
}

local BLIP_DISTANCE = 250 -- Blip visible distance
local Food_Blips = {}
local Pay_Spray_Blips = {}
local Store_Blips = {}
local Ammunation_Blips = {}
local ATM_Blips = {}

addEvent ("GTIblips_BurgerBlips", true )
addEventHandler ("GTIblips_BurgerBlips", root,
	function ( )
		local setting = exports.GTIsettings:getSetting("foodblips")
		if setting == "No" then
			if ( Food_Blips[localPlayer] ) then
				for i, blipsFood in ipairs ( Food_Blips[localPlayer] ) do
					if (isElement(blipsFood)) then
						destroyElement(blipsFood)
					end
				end
			end
				Food_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( foodStores ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ID = Table_Data[4]
					Food_Blip = createBlip ( x, y, z, ID, 1, 0, 0, 0, 0, 0, BLIP_DISTANCE )
            
					if not ( Food_Blips[localPlayer] ) then Food_Blips[localPlayer] = {} end
					table.insert( Food_Blips[localPlayer], Food_Blip )   
				end
			end
		end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function ( setting, old, new )
		local setting = exports.GTIsettings:getSetting("foodblips")
		if setting == "No" then
			if ( Food_Blips[localPlayer] ) then
				for i, blipsFood in ipairs ( Food_Blips[localPlayer] ) do
					if (isElement(blipsFood)) then
						destroyElement(blipsFood)
					end
				end
			end
				Food_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( foodStores ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ID = Table_Data[4]
					Food_Blip = createBlip ( x, y, z, ID, 1, 0, 0, 0, 0, 0, BLIP_DISTANCE )
            
					if not ( Food_Blips[localPlayer] ) then Food_Blips[localPlayer] = {} end
					table.insert( Food_Blips[localPlayer], Food_Blip )   
				end
			end
		end
)

addEvent ("GTIblips_RepairBlips", true )
addEventHandler ("GTIblips_RepairBlips", root,
	function ( )
		local setting = exports.GTIsettings:getSetting("repairmodblips")
		if setting == "No" then
			if ( Pay_Spray_Blips[localPlayer] ) then
				for i, blipsFood in ipairs ( Pay_Spray_Blips[localPlayer] ) do
					if (isElement(blipsFood)) then
						destroyElement(blipsFood)
					end
				end
			end
				Pay_Spray_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( repair ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ID = Table_Data[4]
					Repair_Blip = createBlip ( x, y, z, ID, 1, 0, 0, 0, 0, 0, BLIP_DISTANCE )
            
					if not ( Pay_Spray_Blips[localPlayer] ) then Pay_Spray_Blips[localPlayer] = {} end
					table.insert( Pay_Spray_Blips[localPlayer], Repair_Blip )   
				end
			end
		end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function ( setting, old, new )
		local setting = exports.GTIsettings:getSetting("repairmodblips")
		if setting == "No" then
			if ( Pay_Spray_Blips[localPlayer] ) then
				for i, blipsFood in ipairs ( Pay_Spray_Blips[localPlayer] ) do
					if (isElement(blipsFood)) then
						destroyElement(blipsFood)
					end
				end
			end
				Pay_Spray_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( repair ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ID = Table_Data[4]
					Repair_Blip = createBlip ( x, y, z, ID, 1, 0, 0, 0, 0, 0, BLIP_DISTANCE )
            
					if not ( Pay_Spray_Blips[localPlayer] ) then Pay_Spray_Blips[localPlayer] = {} end
					table.insert( Pay_Spray_Blips[localPlayer], Repair_Blip )   
				end
			end
		end
)

addEvent ("GTIblips_StoreBlips", true )
addEventHandler ("GTIblips_StoreBlips", root,
	function ( )
		local setting = exports.GTIsettings:getSetting("storeblips")
		if setting == "No" then
			if ( Store_Blips[localPlayer] ) then
				for i, blipsFood in ipairs ( Store_Blips[localPlayer] ) do
					if (isElement(blipsFood)) then
						destroyElement(blipsFood)
					end
				end
			end
				Store_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( stores ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ID = Table_Data[4]
					Store_Blip = createBlip ( x, y, z, ID, 1, 0, 0, 0, 0, 0, BLIP_DISTANCE )
            
					if not ( Store_Blips[localPlayer] ) then Store_Blips[localPlayer] = {} end
					table.insert( Store_Blips[localPlayer], Store_Blip )   
				end
			end
		end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function ( setting, old, new )
		local setting = exports.GTIsettings:getSetting("storeblips")
		if setting == "No" then
			if ( Store_Blips[localPlayer] ) then
				for i, blipsFood in ipairs ( Store_Blips[localPlayer] ) do
					if (isElement(blipsFood)) then
						destroyElement(blipsFood)
					end
				end
			end
				Store_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( stores ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ID = Table_Data[4]
					Store_Blip = createBlip ( x, y, z, ID, 1, 0, 0, 0, 0, 0, BLIP_DISTANCE )
            
					if not ( Store_Blips[localPlayer] ) then Store_Blips[localPlayer] = {} end
					table.insert( Store_Blips[localPlayer], Store_Blip )   
				end
			end
		end
)

addEvent ("GTIblips_AmmuBlips", true )
addEventHandler ("GTIblips_AmmuBlips", root,
	function ( )
		local setting = exports.GTIsettings:getSetting("ammublips")
		if setting == "No" then
			if ( Store_Blips[localPlayer] ) then
				for i, blipsFood in ipairs ( Ammunation_Blips[localPlayer] ) do
					if (isElement(blipsFood)) then
						destroyElement(blipsFood)
					end
				end
			end
				Ammunation_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( ammu ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ID = Table_Data[4]
					Ammunation_Blip = createBlip ( x, y, z, ID, 1, 0, 0, 0, 0, 0, BLIP_DISTANCE )
            
					if not ( Ammunation_Blips[localPlayer] ) then Ammunation_Blips[localPlayer] = {} end
					table.insert( Ammunation_Blips[localPlayer], Ammunation_Blip )   
				end
			end
		end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function ( setting, old, new )
		local setting = exports.GTIsettings:getSetting("ammublips")
		if setting == "No" then
			if ( Ammunation_Blips[localPlayer] ) then
				for i, blipsFood in ipairs ( Ammunation_Blips[localPlayer] ) do
					if (isElement(blipsFood)) then
						destroyElement(blipsFood)
					end
				end
			end
				Ammunation_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( ammu ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ID = Table_Data[4]
					Ammunation_Blip = createBlip ( x, y, z, ID, 1, 0, 0, 0, 0, 0, BLIP_DISTANCE )
            
					if not ( Ammunation_Blips[localPlayer] ) then Ammunation_Blips[localPlayer] = {} end
					table.insert( Ammunation_Blips[localPlayer], Ammunation_Blip )   
				end
			end
		end
)

addEvent ("GTIblips_ATMBlips", true )
addEventHandler ("GTIblips_ATMBlips", root,
	function ( )
		local setting = exports.GTIsettings:getSetting("atmblips")
		if setting == "No" then
			if ( ATM_Blips[localPlayer] ) then
				for i, blips in ipairs ( ATM_Blips[localPlayer] ) do
					if (isElement(blips)) then
						destroyElement(blips)
					end
				end
			end
				ATM_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( atms ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ATM_Blip = createBlip ( x, y, z, 52, 3, 255, 0, 0, 255, 0, BLIP_DISTANCE )
            
            
					if not ( ATM_Blips[localPlayer] ) then ATM_Blips[localPlayer] = {} end
					table.insert( ATM_Blips[localPlayer], ATM_Blip )
				end     
			end
		end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function ( )
		local setting = exports.GTIsettings:getSetting("atmblips")
		if setting == "No" then
			if ( ATM_Blips[localPlayer] ) then
				for i, blips in ipairs ( ATM_Blips[localPlayer] ) do
					if (isElement(blips)) then
						destroyElement(blips)
					end
				end
			end
				ATM_Blips[localPlayer] = nil
			elseif setting == "Yes" then
				for i, Table_Data in ipairs ( atms ) do
					local x = Table_Data[1]
					local y = Table_Data[2]
					local z = Table_Data[3]
					local ATM_Blip = createBlip ( x, y, z, 52, 3, 255, 0, 0, 255, 0, BLIP_DISTANCE )
            
            
					if not ( ATM_Blips[localPlayer] ) then ATM_Blips[localPlayer] = {} end
					table.insert( ATM_Blips[localPlayer], ATM_Blip )
				end     
			end
		end
)