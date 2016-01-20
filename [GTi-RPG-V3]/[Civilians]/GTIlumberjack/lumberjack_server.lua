local treesToCut = { 
    {38.562614, 790, 0, -1989.7812, -2462.3281, 34.75781},
    {63.015308, 791, 785, -1984.9375, -2507.8516, 29.96094},
    {63.015308, 791, 785, -1934.3437, -2401.9297, 26.5},
    {38.562614, 790, 0, -2035.7266, -2432.6562, 34.75781},
    {31.324816, 698, 0, -2057.4375, -2417.0859, 34.8125},
    {38.562614, 790, 0, -2069.9297, -2401.0469, 34.75781},
    {31.324816, 698, 0, -2041.8281, -2448.4062, 34.8125},
    {38.562614, 790, 0, -2028.1875, -2480.0234, 34.75781},
    {38.562614, 790, 0, -2051.2812, -2316.875, 34.75781},
    {31.324816, 698, 0, -2051.9687, -2293.1172, 34.8125},
    {38.562614, 790, 0, -1979.7187, -2371.9062, 34.75781},
    --{radius, modelid, lodid, x, y, z},
}
local transportLocations = {
    {-1885.725, -1599.274, 19.756},
    {-116.265, -321.708, 0.430},
    --{-1708.959, -2749.267, 45.074},
}
local treesToPut ={
    {615,-2049.1538000,-2399.1060000,29.6250000,0.0000000,0.0000000,0.0000000},
    {618,-2055.4788000,-2406.8091000,29.6250000,0.0000000,0.0000000,0.0000000},
    {654,-2061.6028000,-2392.4380000,29.6250000,0.0000000,0.0000000,0.0000000},
    {661,-2081.7949000,-2395.5173000,29.6250000,0.0000000,0.0000000,0.0000000},
    {669,-2084.3799000,-2376.7310000,29.6250000,0.0000000,0.0000000,0.0000000},
    {686,-2070.9961000,-2405.8003000,29.6250000,0.0000000,0.0000000,0.0000000},
    {615,-2070.3372000,-2395.8926000,29.6250000,0.0000000,0.0000000,0.0000000},
    {615,-2093.0205000,-2399.0559000,29.6250000,0.0000000,0.0000000,0.0000000},
    {661,-2059.5134000,-2419.9380000,29.6250000,0.0000000,0.0000000,0.0000000},
    {661,-2037.5551000,-2415.4011000,29.6250000,0.0000000,0.0000000,0.0000000},
    {661,-2033.3114000,-2435.0483000,29.6250000,0.0000000,0.0000000,0.0000000},
    {615,-2038.0953000,-2425.8801000,29.6250000,0.0000000,0.0000000,0.0000000},
    {693,-2051.1487000,-2414.1716000,29.6250000,0.0000000,0.0000000,0.0000000},
    {661,-2023.0980000,-2460.3503000,29.6250000,0.0000000,0.0000000,0.0000000},
    {615,-2002.0538000,-2444.8943000,29.6250000,0.0000000,0.0000000,0.0000000},
    {618,-2027.0198000,-2449.4551000,29.6250000,0.0000000,0.0000000,0.0000000},
    {669,-2019.0696000,-2437.3801000,29.6250000,0.0000000,0.0000000,0.0000000},
    {722,-1957.7017000,-2494.6182000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-1936.8452000,-2460.8325000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-1919.6991000,-2433.6658000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-1937.4911000,-2395.2512000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-1940.8380000,-2364.1589000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-1963.2181000,-2356.4062000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-1965.3145000,-2322.2603000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-1997.0724000,-2313.8220000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-1994.8918000,-2337.5630000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-2019.1956000,-2309.8879000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-2008.5394000,-2453.3735000,28.4451800,0.0000000,0.0000000,0.0000000},
    {722,-2027.2628000,-2422.9133000,17.6951800,0.0000000,0.0000000,0.0000000},
    {722,-2060.8601000,-2382.5859000,13.4451800,0.0000000,0.0000000,0.0000000},
    {725,-1981.6924000,-2363.1245000,26.6317800,0.0000000,0.0000000,0.0000000},
    --{modelid, x, y, z, rotx, roty, rotz}
    -- Around the lumberjack job (Author: EnemyCRO0}
    --[[{731, -1728.9, -2675, 46.3, 0, 0, 0},
    {731, -1734.7, -2664.5, 46.3, 0, 0, 0},
    {731, -1741.7, -2670.6001, 46.3, 0, 0, 0},
    {731, -1764.1, -2652, 46.3, 0, 0, 0},
    {731, -1754.7, -2666.1001, 46.3, 0, 0, 0},
    {731, -1747.4, -2659.6001, 46.3, 0, 0, 0},
    {731, -1751.9, -2647.1001, 46.3, 0, 0, 0},
    {731, -1765.7, -2668.3, 46.3, 0, 0, 0},
    {731, -1778.1, -2665.3999, 46.3, 0, 0, 0},
    {731, -1779.3, -2647.5, 46.3, 0, 0, 0},
    {731, -1765.1, -2636.8, 46.3, 0, 0, 0},
    {731, -1773, -2654.1001, 46.3, 0, 0, 0},
    {731, -1779.3, -2631.7, 46.3, 0, 0, 0},
    {731, -1798.5, -2632.3999, 46.3, 0, 0, 0},
    {731, -1786.8, -2624.3, 46.3, 0, 0, 0},
    {731, -1800.7, -2620.3999, 46.3, 0, 0, 0},
    {731, -1813.7, -2623.8999, 46.3, 0, 0, 0},
    {731, -1810.7, -2637.5, 46.3, 0, 0, 0},
    {731, -1821, -2612.3999, 46.3, 0, 0, 0},
    {731, -1795.9, -2644.8, 46.3, 0, 0, 0},
    {731, -1802.8, -2660.5, 46.3, 0, 0, 0},
    {731, -1814.9, -2649.1001, 46.3, 0, 0, 0},
    {731, -1825.8, -2664.2, 46.3, 0, 0, 0},
    {731, -1827.8, -2632.7, 46.3, 0, 0, 0},
    {731, -1844.2, -2620.1001, 46.3, 0, 0, 0},
    {731, -1850, -2635.3, 46.3, 0, 0, 0},
    {731, -1830, -2647, 46.3, 0, 0, 0},
    {731, -1845.7, -2653.8, 46.3, 0, 0, 0},
    {731, -1842.2, -2669.3999, 46.3, 0, 0, 0},
    {731, -1861.8, -2675.2, 46.3, 0, 0, 0},
    {731, -1869.7, -2657.6001, 46.3, 0, 0, 0},
    {731, -1865.3, -2636.2, 46.3, 0, 0, 0},
    {731, -1855.9, -2612.5, 46.3, 0, 0, 0},
    {731, -1880.2, -2623.3999, 46.3, 0, 0, 0},
    {731, -1878.9, -2636.8, 46.3, 0, 0, 0},
    {731, -1881.3, -2651, 46.3, 0, 0, 0},
    {731, -1880.3, -2669, 46.3, 0, 0, 0},
    {731, -1894.4, -2655.7, 46.3, 0, 0, 0},
    {731, -1903.3, -2638.8999, 46.3, 0, 0, 0},
    -- Around all SA (Author: EnemyCRO)
    {720, -318.1, 142.3, 4, 0, 0, 0},
    {720, -338.7, 122.1, 9.1, 0, 0, 0},
    {720, -331.7, 148.3, 2.5, 0, 0, 0},
    {720, -306.2, 166.6, 4.4, 0, 0, 0},
    {670, -359, 76.3, 20.2, 0, 0, 0},
    {670, -303.4004, 151.9004, 5.3, 0, 0, 0},
    {670, -355.4, 98.1, 14.4, 0, 0, 0},
    {720, -372.8, 98.2, 16.8, 0, 0, 0},
    {670, -324.0996, 99.7002, 11.4, 0, 0, 0},
    {777, -355.8, 119.5, 10.8, 0, 0, 0},
    {777, -340.3, 77.1, 19.2, 0, 0, 0},
    {777, -311.9, 120.5, 5.6, 0, 0, 0},
    {777, -318.5, 157.7002, 5.3, 0, 0, 0},
    {777, -343.6, 134.2, 7.9, 0, 0, 0},
    {740, -396.4, 295.4, 0.7, 0, 0, 0},
    {740, -350.5, 291.7, 1, 0, 0, 0},
    {740, -441.7, 297.2, 0.9, 0, 0, 0},
    {740, -475.8, 300, 1.4, 0, 0, 0},
    {740, -514.8, 294.7, 1.4, 0, 0, 0},
    {740, -593, 294.4, 1.4, 0, 0, 0},
    {740, -546.5, 301.0996, 1.4, 0, 0, 0},
    {740, -644.3, 282.4, 1.1, 0, 0, 0},
    {740, -681.4, 268.5, 1, 0, 0, 0},
    {740, -717.5, 250.3, 1.3, 0, 0, 0},
    {740, -746.3, 230.9, 1.8, 0, 0, 0},
    {708, -442.7, 226.4, 8.5, 0, 0, 0},
    {708, -480.6, 231.1, 9, 0, 0, 0},
    {708, -560.8, 203.3, 12.3, 0, 0, 0},
    {708, -480.2998, 190.0996, 6.7, 0, 0, 0},
    {708, -448.2002, 173.5996, 5.6, 0, 0, 0},
    {708, -506.4004, 249.7998, 11.5, 0, 0, 0},
    {709, -363.2, 192.2, 2.4, 0, 0, 0},
    {709, -419.6, 142.8, 15.3, 0, 0, 40},
    {709, -340.7002, 208.9004, 8.7, 0, 0, 0},
    {715, -374.5, 28.5, 43.2, 0, 0, 0},
    {715, -380.4, 1.8, 44, 0, 0, 0},
    {715, -371.5, -17.2, 45.2, 0, 0, 0},
    {731, -259.5, 189.7, 7.1, 0, 0, 0},
    {731, -330.2, 40, 28.5, 0, 0, 0},
    {731, -264.2002, 152.7998, 4.3, 0, 0, 0},
    {731, -327.6, 27.9, 31.7, 0, 0, 0},
    {708, -9.8, -425.8, 3.7, 0, 0, 0},
    {708, -38.5996, -426.5996, 1.4, 0, 0, 0},
    {708, -22.7, -447.9, 1.5, 0, 0, 0},
    {708, 8, -449.4, 5, 0, 0, 0},
    {708, -7.1, -460, 2.3, 0, 0, 0},
    {708, 28.5, -447, 7.8, 0, 0, 0},
    {708, 46.1, -456.2, 7.1, 0, 0, 0},
    {708, 17.8, -463.7, 4.8, 0, 0, 0},
    {708, -21.2, -430.6, 1.6, 0, 0, 0},
    {708, -26.6, -414.1, 1.6, 0, 0, 0},
    {708, 7.4, -407.6, 5.4, 0, 0, 0},
    {708, 29.2, -414.2, 7.7, 0, 0, 0},
    {708, 28.4, -394.9, 5.2, 0, 0, 0},
    {720, -299, 138.7002, 3.4, 0, 0, 0},
    {720, -154.3, -411.8, 6.8, 0, 0, 0},
    {720, -172.6, -399.4, 6.5, 0, 0, 0},
    {720, -190, -385, 7.3, 0, 0, 0},
    {720, -167.5, -383.5, 3, 0, 0, 0},
    {720, -153.5, -393.2, 2.2, 0, 0, 0},
    {720, -165.8, -403.2, 6.3, 0, 0, 0},
    {720, -185.3, -371.9, 4.3, 0, 0, 0},
    {720, -216.4, -370.7, 4.8, 0, 0, 0},
    {720, -188.6, -358.7, 2.2, 0, 0, 0},
    {720, -132.8, -400.8, 0.4, 0, 0, 0},
    {720, -144.1, -419.8, 7.4, 0, 0, 0},
    {720, -125.8, -418.3, 2.8, 0, 0, 0},
    {720, -145.8, -406.3, 3.8, 0, 0, 0},
    {720, -155.8, -384, 0.5, 0, 0, 0},
    {720, -173.7, -369.5, 1, 0, 0, 0},
    {720, -181.3, -387.8, 5.9, 0, 0, 0},
    {720, -232.7, -347.9, 6.1, 0, 0, 0},
    {720, -200.1, -348.2, 2.5, 0, 0, 0},
    {720, -217.9, -352.9, 6, 0, 0, 0},
    {720, -255.6, -325.5, 6.2, 0, 0, 0},
    {720, -248.9, -305.8, 2.5, 0, 0, 0},
    {720, -211.3, -331.2, 1.1, 0, 0, 0},
    {720, -235.3, -330.3, 5.5, 0, 0, 0},
    {720, -217.2, -342.5, 5, 0, 0, 0},
    {720, -231.1, -310.9, 1.3, 0, 0, 0},
    {720, -222.4, -321, 1.3, 0, 0, 0},
    {720, -673.5, -65.6, 67.2, 0, 0, 0},
    {720, -668.3, -55.5, 67.6, 0, 0, 0},
    {720, -660.8, -34, 68.7, 0, 0, 0},
    {720, -645.3, -72, 62.9, 0, 0, 0},
    {720, -659.6, -62.3, 65.2, 0, 0, 0},
    {720, -649.9, -39.1, 66.2, 0, 0, 0},
    {720, -640.8, -57.2, 63.7, 0, 0, 0},
    {720, -660.1, -45.7, 67.2, 0, 0, 0},
    {720, -636.8, -36.2, 64.1, 0, 0, 0},
    {720, -636.2, -14.4, 62.2, 0, 0, 0},
    {720, -653.5, -23.6, 68, 0, 0, 0},
    {720, -640.1, -6.6, 62.9, 0, 0, 0},
    {720, -656.8, -12.4, 68.9, 0, 0, 0},
    {720, -656.9, 7.6, 68.2, 0, 0, 0},
    {720, -642.4, 3.9, 63.4, 0, 0, 0},
    {720, -620.7, 16, 57.2, 0, 0, 0},
    {720, -639.5, 25.2, 55.2, 0, 0, 0},
    {720, -626.1, 0.5, 59.9, 0, 0, 0},
    {720, -651.4, 17.7, 61.1, 0, 0, 0},
    {720, -663.6, 26, 61.8, 0, 0, 0},
    {708, -414.4004, 241.7002, 10.2, 0, 0, 0},
    {708, -261.8, -315.4, 5.6, 0, 0, 0},
    {708, -243.8, -319.6, 5, 0, 0, 0},
    {708, -242.4, -339.7, 6.1, 0, 0, 0},
    {708, -223.5, -335.3, 4.9, 0, 0, 0},
    {708, -225.4, -358.7, 5.9, 0, 0, 0},
    {708, -208.3, -357.2, 5.7, 0, 0, 0},
    {708, -205.1, -376.8, 6, 0, 0, 0},
    {708, -175.2, -392.3, 5.8, 0, 0, 0},
    {708, -143, -415, 5.7, 0, 0, 0},
    {708, -197.7, -385.4, 6.4, 0, 0, 0},
    {708, -145.4, -399.1, 1.9, 0, 0, 0},
    {708, -93.8, -442.5, 2.1, 0, 0, 0},
    {708, -59.9, -456.2, 0.6, 0, 0, 0},
    {708, -99.4, -461.8, 4.6, 0, 0, 0},
    {708, -88.6, -483.2, 4.1, 0, 0, 0},
    {708, -110.7, -477, 7.3, 0, 0, 0},
    {708, -39.2, -468.9, 1.3, 0, 0, 0},
    {708, -64.8, -483.7, 2.2, 0, 0, 0},
    {708, -24.3, -499.3, 2.7, 0, 0, 0},
    {708, -51.2, -515.7, 3.5, 0, 0, 0},
    {708, -84, -508.4, 4.2, 0, 0, 0},
    {708, -63.4, -526.6, 3.8, 0, 0, 0},
    {708, -39.9, -480, 1.8, 0, 0, 0},
    {708, -10.6, -491.5, 3.4, 0, 0, 0},
    {708, 11.3, -510.9, 7.8, 0, 0, 0},
    {708, -6.6, -525.1, 4.7, 0, 0, 0},
    {708, -28.9, -521.5, 3.7, 0, 0, 0},
    {708, -40, -535.4, 2.9, 0, 0, 0},
    {708, 28.2, -477.5, 5.5, 0, 0, 0},
    {708, -2422.8999, -2309.8999, 14.9, 0, 0, 0},
    {708, -2416.5, -2336.3999, 19.1, 0, 0, 0},
    {708, -2393.1001, -2349.1001, 22.2, 0, 0, 0},
    {708, -2399.3, -2298.5, 15.3, 0, 0, 0},
    {708, -2396.7, -2323.5, 18.6, 0, 0, 0},
    {708, -2410.6001, -2417.3, 28.3, 0, 0, 0},
    {708, -2383.8999, -2409.7, 24.9, 0, 0, 0},
    {708, -2365.6001, -2384.3, 23.7, 0, 0, 0},
    {708, -2387.5, -2367.3999, 23.7, 0, 0, 0},
    {708, -2488.8999, -2234, 26.9, 0, 0, 0},
    {708, -2474.3999, -2240.6001, 22.8, 0, 0, 0},
    {708, -2481.5, -2260.7, 22.9, 0, 0, 0},
    {708, -2465.6001, -2251.5, 19.7, 0, 0, 0},
    {708, -2478.2, -2274.5, 18.9, 0, 0, 0},
    {708, -2455.2, -2263, 16.3, 0, 0, 0},
    {708, -2469.3999, -2265.8999, 20.1, 0, 0, 0},
    {708, -2472.7, -2287.1001, 15, 0, 0, 0},
    {708, -2451.8, -2277.6001, 14.1, 0, 0, 0},
    {708, -2465.2, -2275.3999, 17.7, 0, 0, 0},
    {708, -2538.8, -2169.1001, 30.1, 0, 0, 2},
    {708, -2537.1001, -2186.5, 29.3, 0, 0, 2},
    {708, -2526.8999, -2197, 28.4, 0, 0, 2},
    {708, -2529.6001, -2213.3, 28.6, 0, 0, 2},
    {708, -2517.1001, -2226.3, 28.1, 0, 0, 2},
    {708, -2518.8, -2241.2, 28.1, 0, 0, 2},
    --{-2577.219, -2375.254, 13.947},
    --(708, -2576.2, -2374.1001, 16.5, 0, 0, 2),
    {708, -2554.8999, -2324.6001, 13.5, 0, 0, 2},
    {708, -2553.1001, -2357.2, 13.8, 0, 0, 2},
    {708, -2562.6001, -2385.2, 14.9, 0, 0, 2},
    {708, -2582.3999, -2394.1001, 15.7, 0, 0, 2},
    {708, -2600, -2413.6001, 17.3, 0, 0, 2},
    {708, -2607.7, -2391, 14.9, 0, 0, 2},
    {708, -2576.2, -2374.1001, 13.5, 0, 0, 2},
    {708, -2568.7, -2342.2, 12.5, 0, 0, 2},
    {708, -2594.8, -2378.1001, 14, 0, 0, 2},
    {708, -2607.8999, -2361.7, 12.3, 0, 0, 2},
    {708, -2574.8999, -2361.2, 13.2, 0, 0, 2},
    {708, -2569.8, -2323.2, 12.2, 0, 0, 2},
    {708, -2592, -2360.3, 12.3, 0, 0, 2},
    {708, -2582, -2349.1001, 12.1, 0, 0, 2},--]]
}
local restoreTrees = {}
local groundPosition
function onRequestCutTree(x , y, z, id, lodid, hitElement)
    if hitElement ~= nil then
        local elementModel = getElementModel(hitElement)
        local x, y, z = getElementPosition(hitElement)
        setTimer(function()
            createObject(elementModel, x, y, z)
        end, 180000, 1)
        destroyElement(hitElement)
            for i=1, #treesToPut do
                if math.ceil(treesToPut[i][2]) == math.ceil(x) and math.ceil(treesToPut[i][3]) == math.ceil(y) then
                    local fakeCutTree = createObject(848, x, y, treesToPut[i][4]+1.2)
                    setElementDoubleSided ( fakeCutTree, true )
                    setTimer(function()
                        destroyElement(fakeCutTree)
                    end, 180000, 1)
                end
            end
    else
        removeWorldModel ( id, 3, x , y, z)
        removeWorldModel ( lodid, 3, x , y, z) 
        table.insert(restoreTrees, {x, y, z, id, lodid})
        setTimer(function()
            for i=1, #restoreTrees do
            if restoreTrees[i][1] == x and restoreTrees[i][2] == y and restoreTrees[i][3] == y and restoreTrees[i][5] == lodid then
            restoreTrees[i] = nil
            end
            end
            restoreWorldModel ( id, 3, x, y, z)
            restoreWorldModel ( lodid, 3, x, y, z)
        end, 180000, 1)
        local fakeCutTree
        triggerClientEvent("GTIlumberjack.getGroundPosition", getResourceRootElement(getThisResource()), x, y, z)
        setTimer(function()
            fakeCutTree = createObject(848, x, y, groundPosition+1.2)
            setElementDoubleSided ( fakeCutTree, true )
        end, 1000, 1)
        setTimer(function()
            destroyElement(fakeCutTree)
        end, 180000, 1)
    end
    if not getElementData(source,"GTIlumberjack.cuttenTrees") == false then
        setElementData(source, "GTIlumberjack.cuttenTrees", getElementData(source, "GTIlumberjack.cuttenTrees")+1)
    else
        setElementData(source, "GTIlumberjack.cuttenTrees", 1)
    end
end
addEvent( "GTIlumberjack.onRequestCutTree", true )
addEventHandler( "GTIlumberjack.onRequestCutTree", root, onRequestCutTree )
function recieveGroundPosition(newZ)
    groundPosition = newZ
end
addEvent("GTIlumberjack.recieveGroundPosition", true )
addEventHandler("GTIlumberjack.recieveGroundPosition", root, recieveGroundPosition)
local allNewTrees = {}
function onResourceStopRestoreTrees(res)
    if res == getThisResource() then
        for i=1, #restoreTrees do
            restoreWorldModel(restoreTrees[i][4], 3, restoreTrees[i][1], restoreTrees[i][2], restoreTrees[i][3])
            restoreWorldModel(restoreTrees[i][5], 3, restoreTrees[i][1], restoreTrees[i][2], restoreTrees[i][3])
        end
		--
        for i=1, #treesToCut do
            restoreWorldModel(treesToCut[i][2], treesToCut[i][1], treesToCut[i][4], treesToCut[i][5], treesToCut[i][6] )
            restoreWorldModel(treesToCut[i][3], treesToCut[i][1], treesToCut[i][4], treesToCut[i][5], treesToCut[i][6] )
        end
end
end
addEventHandler("onResourceStop", root, onResourceStopRestoreTrees)
function onResourceStartCutTrees(res) -- Cut the unnecessary trees near Sawmill, Angel Pine
    if res == getThisResource() then
        for i=1, #treesToCut do
            removeWorldModel(treesToCut[i][2], treesToCut[i][1], treesToCut[i][4], treesToCut[i][5], treesToCut[i][6] )
            removeWorldModel(treesToCut[i][3], treesToCut[i][1], treesToCut[i][4], treesToCut[i][5], treesToCut[i][6] )
        end
		--
        for i=1, #treesToPut do
            local newTree = createObject(treesToPut[i][1], treesToPut[i][2], treesToPut[i][3], treesToPut[i][4])
        end
    end
end
addEventHandler("onResourceStart", root, onResourceStartCutTrees)
local woodAttached = {}
local rewardMarker = {}
local rewardBlip = {}
function onPlayerEnterDFT(vehicle, seat)
    if seat == 0 then
        if exports.GTIemployment:getPlayerJob(source, true) and exports.GTIemployment:getPlayerJob(source) == "Lumberjack" then 
            if getElementModel(vehicle) == 578 and getElementData(source, "GTIlumberjack.cuttenTrees") and getElementData(source, "GTIlumberjack.cuttenTrees") > 0 then
                woodAttached[source] = createObject ( 18609, 0, 0, 0 )
                attachElements ( woodAttached[source], vehicle, 0, -5, 0.98)
                rewardMarker[source] = {}
                rewardBlip[source] = {}
                    for i=1, #transportLocations do
                        rewardMarker[source][i] = createMarker(transportLocations[i][1], transportLocations[i][2], transportLocations[i][3], "cylinder", 4, 255, 255, 0, 255, source)
                        rewardBlip[source][i] = createBlip(transportLocations[i][1], transportLocations[i][2], transportLocations[i][3], 19, 2, 255, 0, 0, 255, 0, 99999.0, source)
                        setElementData(rewardMarker[source][i], "GTIlumberjack.accName", getAccountName(getPlayerAccount(source)))
                        addEventHandler("onMarkerHit", rewardMarker[source][i], onMarkerHitGiveReward)
                    end
                exports.GTIhud:dm("Transport the wood in your car to the furniture factory (red flag blip on your map)", source, 255, 255, 0)
            end
        end
    end
end
addEventHandler ( "onPlayerVehicleEnter", root, onPlayerEnterDFT)

function onMarkerHitGiveReward(hitElement, matchingDimension)
    if matchingDimension and getElementType(hitElement) == "vehicle" then
        if getElementModel(hitElement) == 578 then
        local player = getVehicleOccupant(hitElement)
            if getElementData(source, "GTIlumberjack.accName") == getAccountName(getPlayerAccount(player)) then
                if exports.GTIemployment:getPlayerJob(player, true) and exports.GTIemployment:getPlayerJob(player) == "Lumberjack" then
                    exports.GTIhud:drawProgressBar("GTIlumberjack.waitTimeToReward", " ", player, 255, 255, 0, 5000)
                    setElementFrozen(hitElement, true)
                    setTimer(function() 
                        if isElement(woodAttached[player]) then
                        destroyElement(woodAttached[player])
                        for i=1, #transportLocations do
                        destroyElement(rewardMarker[player][i])
                        destroyElement(rewardBlip[player][i])
                        end
                        end
                        woodAttached[player] = nil
                        rewardMarker[player] = nil
                        rewardBlip[player] = nil
                        setElementFrozen(hitElement, false)
                        
                        local payOffset = exports.GTIemployment:getPlayerJobPayment(player, "Lumberjack")
                        local hrPay = exports.GTIemployment:getPlayerHourlyPay(player)
                        local hrExp = exports.GTIemployment:getHourlyExperience()
                        
                        local progress = getElementData(player, "GTIlumberjack.cuttenTrees")
                        local pay = math.ceil(progress*payOffset)
                        local Exp = math.ceil((pay/hrPay)*hrExp)
                        
                        exports.GTIemployment:givePlayerJobMoney(player, "Lumberjack", pay)
                        exports.GTIemployment:modifyPlayerJobProgress(player, "Lumberjack", progress)
                        exports.GTIemployment:modifyPlayerEmploymentExp(player, Exp,  "Lumberjack")
                        
                        setElementData(player, "GTIlumberjack.cuttenTrees", 0)
                    end, 5000, 1)
                end
            end
        end
    end
end

function destroyAttachedWood()
    if getElementType(source) == "vehicle" then
        if getElementModel(source) == 578 then
		local player = getVehicleOccupant (source)
        local allAttachedElements = getAttachedElements ( source )
            for k, object in ipairs(allAttachedElements) do
                if getElementModel(object) == 18609 then
                    --destroyElement(object)
					cancelTransportMission(player)
                end
            end
        end
    end
end
addEventHandler("onElementDestroy", root, destroyAttachedWood)
function cancelTransportMission(player)
    --if getElementModel(vehicle) == 578 and seat == 0 then
        --if exports.GTIemployment:getPlayerJob(source, true) and exports.GTIemployment:getPlayerJob(source) == "Lumberjack" then
            if rewardMarker[player] or rewardBlip[player] then -- or woodAttached[player]
            destroyElement(woodAttached[player])
                for i=1, #transportLocations do
                    destroyElement(rewardMarker[player][i])
                    destroyElement(rewardBlip[player][i])
                end
                woodAttached[player] = nil
                rewardMarker[player] = nil
                rewardBlip[player] = nil
            end
        --end
   --end
end
addEventHandler("onPlayerVehicleExit", root, function(vehicle, seat)
    if getElementModel(vehicle) == 578 and seat == 0 then
        if exports.GTIemployment:getPlayerJob(source, true) and exports.GTIemployment:getPlayerJob(source) == "Lumberjack" then
		cancelTransportMission(source)
		end
	end
end)
