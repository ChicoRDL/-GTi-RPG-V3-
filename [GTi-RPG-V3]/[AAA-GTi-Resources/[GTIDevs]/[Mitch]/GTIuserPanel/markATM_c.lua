----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

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

local blipATM = {}

function toggleStuntBlip( )
    if ( blipATM[localPlayer] ) then
        for i, blips in ipairs ( blipATM[localPlayer] ) do
            if (isElement(blips)) then
                destroyElement(blips)
            end
        end
        blipATM[localPlayer] = nil
    else
        for i, atmTableData in ipairs ( atms ) do
            local x = atmTableData[1]
            local y = atmTableData[2]
            local z = atmTableData[3]
            local atmBlip = createBlip ( x, y, z, 52, 3, 255, 0, 0, 255, 0, 1000 )
            
            
            if not ( blipATM[localPlayer] ) then blipATM[localPlayer] = {} end
            table.insert( blipATM[localPlayer], atmBlip )
        end     
    end
end
addEvent ("GTIuserpanel_markATMS", true )
addEventHandler ("GTIuserpanel_markATMS", root, toggleStuntBlip )