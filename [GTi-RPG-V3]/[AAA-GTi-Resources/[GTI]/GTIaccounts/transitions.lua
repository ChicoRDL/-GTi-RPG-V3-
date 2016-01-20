------------------------------------------->>
-- GTI: Grand Theft International Server
-- Date: 20 Sept 2012
-- Resource: GTIaccounts/transitions.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local tTimer    -- Transition Timer
local timer1    -- Warp Camera to Transition Start Point Timer
local timer2    -- Fade Camera In
local fTimer    -- Fade Camera Out

local tSound    -- Login Scree Music

local TRANSITION_TIME = 20000

-- Intro Sounds
---------------->>

    -- Intro Sounds Located @ http://gtirpg.net/MTA/files/...
local intro_songs = {
    "gta3_theme.mp3", 
    "gtavc_theme.mp3", 
    "gtasa_theme.mp3", 
    "gtalcs_theme.mp3",
    "gtavcs_theme.mp3",
    "gtaiv_theme.mp3", 
    "gtav_theme.mp3", 
    "gtavtrailer1.mp3",
    --"sleepwalking.mp3",
    "rcal.mp3",
    "thesetup.mp3",
}

-- Transition Location Table

local trans = {
-- Los Santos
{ matrix1={2459.912, -1700.152, 85.667, 2461.332, -1698.511, 82.071},
    matrix2={2200.635, -1477.014, 87.037, 2201.717, -1475.764, 84.297} }, -- Grove Street
{ matrix1={1401.705, -1702.828, 60.863, 1402.226, -1703.469, 60.300},
    matrix2={1540.333, -1588.954, 61.427, 1541.793, -1590.749, 59.849} }, -- LS Police Dept.
{ matrix1={2881.527, -2278.559, 65.569, 2880.718, -2279.290, 65.066},
    matrix2={2889.208, -2584.543, 65.297, 2887.876, -2583.550, 64.604} }, -- Ocean Docks
{ matrix1={2045.397, -2327.580, 82.291, 2044.889, -2326.976, 81.387},
    matrix2={1597.129, -2705.626, 82.291, 1596.791, -2705.223, 81.688} }, -- LS Airport
{ matrix1={369.900, -1940.950, 9.023, 369.929, -1944.547, 9.161},
    matrix2={307.285, -2051.150, 40.873, 308.203, -2051.158, 40.476} }, -- Santa Maria Pier
{ matrix1={1310.700, -1403.519, 50.871, 1309.646, -1403.872, 50.419},
    matrix2={1254.105, -1232.171, 51.248, 1251.821, -1232.938, 50.269} }, -- All Saints Hospital
{ matrix1={1419.854, -1301.385, 51.697, 1421.395, -1301.373, 51.268},
    matrix2={1693.813, -1300.860, 22.372, 1695.408, -1300.848, 22.243} }, -- Downtown LS Grnd
{ matrix1={1411.175, -2036.013, 161.715, 1409.126, -2036.018, 160.913},
    matrix2={1137.425, -2037.162, 71.914, 1136.627, -2037.164, 71.860} }, -- Verdant Bluffs
{ matrix1={1415.640, -810.827, 82.045, 1415.613, -810.234, 81.959},
    matrix2={1432.792, -914.792, 98.513, 1432.629, -914.215, 98.496} }, -- Vinewood
{ matrix1={1832.260, -1622.243, 34.163, 1832.007, -1621.933, 34.161},
    matrix2={1646.111, -1387.090, 128.211, 1644.955, -1385.599, 128.878} }, -- LS Skyline
-- Badlands
{ matrix1={-772.213, -2634.926, 173.001, -774.435, -2633.580, 173.069},
    matrix2={-1455.704, -2220.684, 193.975, -1462.887, -2216.337, 194.195} }, -- Flint County -> Mt. Chiliad
{ matrix1={-2053.968, -2598.530, 96.237, -2054.615, -2597.213, 95.597},
    matrix2={-2155.393, -2377.562, 73.364, -2155.049, -2374.648, 72.084} }, -- Angle Pine
{ matrix1={-1356.362, -1422.341, 150.708, -1357.120, -1423.176, 150.299},
    matrix2={-1742.208, -1586.019, 57.613, -1742.832, -1586.438, 57.341} }, -- Angle Pine Dump
{ matrix1={-69.443, -428.806, 77.716, -70.005, -428.080, 77.319},
    matrix2={359.662, -77.175, 46.607, 358.979, -77.539, 46.406} }, -- Blueberry
{ matrix1={1242.975, 142.801, 23.915, 1243.458, 143.899, 23.885},
    matrix2={1374.560, 440.180, 20.308, 1375.305, 441.819, 20.308} }, -- Montgomery
-- San Fierro
{ matrix1={-2534.157, 1488.876, -4.064, -2535.207, 1491.993, -3.204},
    matrix2={-2637.882, 1796.414, 80.724, -2639.117, 1800.081, 81.735} }, -- Gant Bridge
{ matrix1={-907.498, 631.100, 104.825, -915.299, 634.209, 104.591},
    matrix2={-1530.853, 879.547, 86.150, -1534.567, 881.027, 86.039} }, -- SF Bridges
{ matrix1={-2423.993, -290.962, 59.835, -2424.180, -291.873, 60.204},
    matrix2={-2498.568, -675.101, 218.122, -2498.913, -676.784, 218.657} }, -- News Station
{ matrix1={-2684.123, -149.287, 72.363, -2683.738, -150.113, 71.952},
    matrix2={-2884.485, -241.828, 72.610, -2883.947, -242.985, 72.034} }, -- Country Club
{ matrix1={-2506.903, 378.487, 117.658, -2507.453, 378.485, 117.418},
    matrix2={-2741.962, 375.766, 16.231, -2743.161, 375.763, 16.211} }, -- City Hall
{ matrix1={-2374.073, 555.966, 78.225, -2374.592, 555.499, 77.832},
    matrix2={-2611.150, 665.126, 62.986, -2611.120, 663.151, 62.674} }, -- SF Hospital
{ matrix1={-2267.592, 1607.764, 50.756, -2268.229, 1606.643, 50.212},
    matrix2={-2531.770, 1616.049, 51.610, -2531.340, 1615.217, 51.257} }, -- Cargo Ship
{ matrix1={-1910.010, -1087.720, 73.529, -1911.185, -1087.033, 73.199},
    matrix2={-1916.727, -694.149, 65.519, -1917.595, -694.626, 65.383} }, -- Foster Valley
{ matrix1={-2046.349, 117.496, 52.411, -2044.101, 116.726, 51.359},
    matrix2={-2008.271, 305.339, 41.456, -2005.394, 304.554, 41.124} }, -- Cranberry Station
{ matrix1={-2038.880, 1152.022, 69.296, -2037.148, 1150.127, 69.702},
    matrix2={-1824.589, 917.736, 127.843, -1823.667, 916.728, 128.149} }, -- Downtown SF
-- Desert
{ matrix1={-2302.722, 2350.187, 42.244, -2302.349, 2351.837, 41.631},
    matrix2={-2567.135, 2346.727, 38.131, -2569.920, 2350.152, 36.842} }, -- Bayside Marina
{ matrix1={369.222, 2440.516, 16.002, 366.574, 2439.136, 16.281},
    matrix2={221.487, 2363.463, 31.602, 217.956, 2361.623, 31.975} }, -- Verdant Meadows
{ matrix1={-1243.178, 2479.405, 114.816, -1248.963, 2483.190, 113.724},
    matrix2={-1500.260, 2654.950, 104.965, -1503.559, 2656.991, 103.991} }, -- El Quebrados
{ matrix1={-935.581, 2118.632, 122.096, -928.805, 2110.150, 118.004},
    matrix2={-505.412, 2145.507, 136.724, -512.403, 2136.081, 130.684} }, -- Sherman Dam
{ matrix1={531.197, 1592.097, 53.098, 534.933, 1586.901, 51.492},
    matrix2={109.936, 1552.181, 65.508, 114.395, 1546.449, 64.075} }, -- Oil Refinery
-- Las Venturas
{ matrix1={2040.102, 2142.494, 97.282, 2045.922, 2142.502, 94.621},
    matrix2={2377.518, 2142.901, 31.025, 2381.917, 2142.906, 30.931} }, -- Old Venturas Strip
{ matrix1={1249.745, 2634.587, 12.527, 1251.944, 2634.547, 12.462},
    matrix2={1567.291, 2633.805, 13.330, 1570.890, 2633.832, 13.270} }, -- Prickle Pine RR
{ matrix1={1206.457, 2718.384, 63.900, 1206.414, 2720.567, 61.562},
    matrix2={1485.088, 2722.189, 65.653, 1485.059, 2723.691, 64.046} }, -- Yellow Bell Golf Course
{ matrix1={1581.467, 2549.862, 49.689, 1580.153, 2552.319, 48.117},
    matrix2={1841.059, 2745.910, 65.927, 1839.626, 2747.503, 64.453} }, -- Prickle Pine
{ matrix1={2406.291, 2373.051, 58.041, 2405.162, 2376.132, 56.559},
    matrix2={2192.313, 2372.169, 52.442, 2198.136, 2379.176, 48.326} }, -- LV Police Dept.
{ matrix1={2172.072, 1285.661, 34.182, 2175.071, 1285.579, 34.094},
    matrix2={2067.940, 1227.488, 48.232, 2074.699, 1229.703, 47.108} }, -- The Camel's Toe
{ matrix1={2112.009, 1010.998, 65.757, 2105.767, 1007.995, 63.147},
    matrix2={2099.388, 1653.104, 49.527, 2095.397, 1651.488, 48.620} }, -- The Strip
{ matrix1={2223.551, 1095.096, 55.104, 2225.323, 1094.181, 54.943},
    matrix2={2022.696, 1197.975, 96.227, 2028.545, 1194.958, 93.842} }, -- Come-A-Lot
{ matrix1={1296.424, 1393.446, 49.557, 1288.446, 1393.396, 47.662},
    matrix2={1295.108, 1726.541, 49.741, 1290.438, 1726.512, 48.632} }, -- LV Stadium
{ matrix1={1791.269, 1401.217, 65.657, 1789.144, 1399.306, 63.469},
    matrix2={1384.059, 1766.397, 76.476, 1382.404, 1754.419, 69.034} }, -- LV Airport
}

-- Transition Functions
------------------------>>

function areTransitionsRunning()
    if (tTimer) then return true else return false end
end

function startTransitions()
    tTimer = setTimer(triggerNextTransitions, TRANSITION_TIME, 0)
    local intro_music = intro_songs[math.random(#intro_songs)]
    --tSound = playSound("http://gtirpg.net/MTA/files/"..intro_music, true)
    tSound = playSound("http://gcrpg.net/afrojack.mp3", true)
    triggerNextTransitions()
    fadeCamera(false, 0)
    addEventHandler("onClientPreRender", root, renderCameraMovement)
end

function stopTransitions()
    killTimer(tTimer)
    if isTimer(timer1) then killTimer(timer1) end
    if isTimer(timer2) then killTimer(timer2) end
    if isTimer(fTimer) then killTimer(fTimer) end
    destroyElement(tSound)
    fadeCamera(true, 0)
    removeEventHandler("onClientPreRender", root, renderCameraMovement)
    
    tTimer = false
    timer1 = false
    timer2 = false
    fTimer = false
    tSound = false
end

local oldLoc = 0
function triggerNextTransitions()
    if isTimer(timer1) then killTimer(timer1) end
    if isTimer(timer2) then killTimer(timer2) end
    loc = math.random(#trans)
    if loc == oldLoc then triggerNextTransitions() end
    timer1 = setTimer(setCameraMatrix, 500, 1, trans[loc].matrix1[1], trans[loc].matrix1[2], trans[loc].matrix1[3], trans[loc].matrix1[4], trans[loc].matrix1[5], trans[loc].matrix1[6])
    timer2 = setTimer(fadeCamera, 1000, 1, true)
    fTimer = setTimer(fadeCamera, TRANSITION_TIME-1100, 1, false, 1)
    oldLoc = loc
end

function renderCameraMovement()
    if isTimer(tTimer) and not isTimer(timer1) then
        local rTime = getTimerDetails(tTimer)+1000
        local x1, y1, z1, lx1, ly1, lz1 = trans[loc].matrix1[1], trans[loc].matrix1[2], trans[loc].matrix1[3], trans[loc].matrix1[4], trans[loc].matrix1[5], trans[loc].matrix1[6]
        local x2, y2, z2, lx2, ly2, lz2 = trans[loc].matrix2[1], trans[loc].matrix2[2], trans[loc].matrix2[3], trans[loc].matrix2[4], trans[loc].matrix2[5], trans[loc].matrix2[6]
        setCameraMatrix((((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(x2-x1))+x1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(y2-y1))+y1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(z2-z1))+z1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(lx2-lx1))+lx1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(ly2-ly1))+ly1, (((TRANSITION_TIME-rTime)/TRANSITION_TIME)*(lz2-lz1))+lz1)
        local sW,sH = guiGetScreenSize()
        dxDrawRectangle(0, 0, sW, sH*0.12, tocolor(0,0,0,255))
        dxDrawRectangle(0, sH*0.88, sW, sH, tocolor(0,0,0,255))
    end
end
