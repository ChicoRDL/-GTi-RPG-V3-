----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 01 Jan 2014
-- Resource: GTIinteriors/interiorsTable.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

--[[
{
    { pos={x, y, z}, rot=0, int=0, size=1.5, color={200, 0, 255}, dim=0, size=1.5, color={r, g, b}, res={team={"Team 1", "Team 2"}, job={"Job 1", "Job 2"}} } -- ENTRY
    { pos={x, y, z}, rot=0, int=0, size=1.5, color={200, 0, 255}, dim=0, size=1.5, color={r, g, b}, res={team={"Team 1", "Team 2"}, job={"Job 1", "Job 2"}} } -- RETURN
},

id and refid are not needed nor used. They only exist to make conversion between the default interiors resource easier

* EACH NEW INTERIOR SHOULD BE LOCATED IN ITS OWN DIMENSION
    - Dimensions Start at 100 for mapped interiors

* THE MARKER OUTSIDE THE INTERIOR GOES FIRST (Entry Points)
* THE MARKER INSIDE THE INTERIOR GOES LAST (Exit Points)
--]]
 
interiors = {
-- Ammu-Nations
---------------->>
{
    {refid="Ammo2", pos={-2625.88, 209.26, 3.61}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {id="Ammo2", pos={286.15, -41.54, 1000.57}, rot=0, size=1.5, color={200, 0, 255}, dim=101, int=1},
},

{
    {refid="Ammo5", pos={-1508.91, 2609.73, 54.835}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {id="Ammo5", pos={316.366, -169.369, 998.601}, rot=0, size=1.5, color={200, 0, 255}, dim=104, int=6},
},
--[[{
    {refid="Ammo6", pos={-315.08, 829.89, 13.242}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {id="Ammo6", pos={296.774, -111.540, 1000.516}, rot=0, size=1.5, color={200, 0, 255}, dim=105, int=6},
},--]]
{
    {refid="Ammo7", pos={777.81, 1871.40, 3.906}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {id="Ammo7", pos={296.774, -111.540, 1000.516}, rot=0, size=1.5, color={200, 0, 255}, dim=106, int=6},
},


--[[ {
    {refid="Ammo9", pos={2538.68, 2083.99, 9.820}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {id="Ammo9", pos={285.48, -85.56, 1000.51}, rot=0, size=1.5, color={200, 0, 255}, dim=108, int=4},
}, ]]

-- Cluckin' Bells
------------------>>
{
    {id="CB3", pos={364.820, -11.593, 1000.851}, rot=360, size=1.5, color={200, 0, 255}, dim=114, int=9},
    {refid="CB3", pos={-2672.449, 258.561, 3.632}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="CB4", pos={364.820, -11.593, 1000.851}, rot=360, size=1.5, color={200, 0, 255}, dim=115, int=9},
    {refid="CB4", pos={-1816.506, 617.286, 34.171}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="CB5", pos={364.820, -11.593, 1000.851}, rot=360, size=1.5, color={200, 0, 255}, dim=116, int=9},
    {refid="CB5", pos={-1213.416, 1830.782, 40.929}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="CB6", pos={364.820, -11.593, 1000.851}, rot=360, size=1.5, color={200, 0, 255}, dim=117, int=9},
    {refid="CB6", pos={172.791, 1176.790, 13.757}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    --[[{id="CB7", pos={364.820, -11.593, 1000.851}, rot=360, size=1.5, color={200, 0, 255}, dim=118, int=9},
    {refid="CB7", pos={2102.897, 2228.837, 10.023}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},]]
},
{
    {id="CB8", pos={364.820, -11.593, 1000.851}, rot=360, size=1.5, color={200, 0, 255}, dim=119, int=9},
    {refid="CB8", pos={2846.290, 2414.998, 10.068}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},

--[[
{
    {id="CB9", pos={364.820, -11.593, 1000.851}, rot=360, size=1.5, color={200, 0, 255}, dim=120, int=9},
    {refid="CB9", pos={2392.984, 2042.247, 9.820}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
]]


-- Burger Shots
---------------->>
{
    {id="BS1", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=122, int=10},
    {refid="BS1", pos={1200.413, -918.528, 42.112}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="BS2", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=123, int=10},
    {refid="BS2", pos={810.830, -1616.094, 12.546}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="BS3", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=124, int=10},
    {refid="BS3", pos={-2336.182, -166.779, 34.554}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="BS4", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=125, int=10},
    {refid="BS4", pos={-1912.099, 828.147, 34.205}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="BS5", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=126, int=10},
    {refid="BS5", pos={-2356.808, 1008.071, 49.898}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="BS6", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=127, int=10},
    {refid="BS6", pos={1158.207, 2072.208, 10.062}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="BS7", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=128, int=10},
    {refid="BS7", pos={1872.776, 2071.883, 10.062}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="BS8", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=129, int=10},
    {refid="BS8", pos={2170.282, 2795.774, 9.820}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},

--[[
{
    {id="BS9", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=130, int=10},
    {refid="BS9", pos={2366.213, 2070.998, 9.820}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
]]

{
    {id="BS10", pos={363.161, -74.797, 1000.507}, rot=360, size=1.5, color={200, 0, 255}, dim=131, int=10},
    {refid="BS10", pos={2472.069, 2034.090, 10.062}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},

-- Well Stacked Pizza's
------------------------>>
{
    {id="WSP2", pos={372.340, -133.0791, 1000.492}, rot=360, size=1.5, color={200, 0, 255}, dim=133, int=5},
    {refid="WPS2", pos={-1808.0712, 945.398, 23.890}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    {id="WSP3", pos={372.340, -133.0791, 1000.492}, rot=360, size=1.5, color={200, 0, 255}, dim=134, int=5},
    {refid="WPS3", pos={-1721.782, 1359.757, 6.185}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},
{
    --[[{id="WSP4", pos={372.340, -133.0791, 1000.492}, rot=360, size=1.5, color={200, 0, 255}, dim=135, int=5},
    {refid="WPS4", pos={2083.343, 2224.089, 10.0234}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},]]
},
{
    --[[{id="WSP5", pos={372.340, -133.0791, 1000.492}, rot=360, size=1.5, color={200, 0, 255}, dim=136, int=5},
    {refid="WPS5", pos={2351.811, 2532.613, 9.820}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},]]
},
{
    {id="WSP6", pos={372.340, -133.0791, 1000.492}, rot=360, size=1.5, color={200, 0, 255}, dim=137, int=5},
    {refid="WPS6", pos={2756.495, 2477.017, 10.062}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},

-- Rusty Brown's Ring Donuts
----------------------------->>
{
    {id="RBRD2", pos={377.112, -193.208, 999.632}, rot=360, size=1.5, color={200, 0, 255}, dim=140, int=17},
    {refid="RBRD2", pos={-2767.755, 788.823, 51.781}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
},

-- Police Departments
---------------------->>
{
    {id="HelipadLS", pos={1560.324, -1671.363, 15.191}, rot=180, size=1.5, color={30, 125, 255}, dim=0, int=0, res={job={"Police Officer"}}},
    {refid="HelipadLS", pos={1564.902, -1666.535, 27.396}, rot=346, int=0, size=1.5, color={30, 125, 255}, dim=0, res={job={"Police Officer"}}},
},

{
    {id="GarageLS", pos={1581.383, -1675.201, 15.191}, rot=85, size=1.5, color={30, 125, 255}, dim=0, int=0, res={job={"Police Officer"}}},
    {refid="GarageLS", pos={1568.608, -1689.972, 5.219}, rot=180, int=0, size=1.5, color={30, 125, 255}, dim=0, res={job={"Police Officer"}}},
},


{ -- San Fierro PD
    {pos={-1605.542, 711.151, 12.867}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={246.442, 108.074, 1002.219}, rot=0, size=1.5, color={200, 0, 255}, dim=142, int=10},
},

{
    {id="GarageSF", pos={214.364, 117.749, 1002.219}, rot=267, size=1.5, color={30, 125, 255}, dim=142, int=10, res={job={"Police Officer"}}},
    {refid="GarageSF", pos={-1594.110, 716.206, -5.906}, rot=270, int=0, size=1.5, color={30, 125, 255}, dim=0, res={job={"Police Officer"}}},
},

{ -- Las Venturas PD Lower
    --[[{pos={2287.063, 2431.928, 9.820}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={238.66, 139.35, 1002.05}, rot=0, size=1.5, color={200, 0, 255}, dim=143, int=3},]]
},

{ -- Las Venturas PD Upper
    --[[{pos={2337.224, 2458.861, 13.969}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={288.715, 167.547, 1006.172}, rot=0, size=1.5, color={200, 0, 255}, dim=143, int=3},]]
},

{ -- Las Venturas PD helipad
    {id="HelipadLV", pos={2343.515, 2458.786, 13.969}, rot=180, size=1.5, color={30, 125, 255}, dim=0, int=0, res={job={"Police Officer"}}},
    {refid="HelipadLV", pos={2279.796, 2458.487, 37.688}, rot=346, int=0, size=1.5, color={30, 125, 255}, dim=0, res={job={"Police Officer"}}},
},

{ -- Las Venturas Garage
    {id="GarageLVPD", pos={2268.035, 2449.290, 2.531}, rot=180, size=1.5, color={30, 125, 255}, dim=0, int=0, res={job={"Police Officer"}}},
    {refid="GarageLVPD", pos={2283.104, 2434.279, 9.831}, rot=346, int=0, size=1.5, color={30, 125, 255}, dim=0, res={job={"Police Officer"}}},
},


{ -- Dillmore
    {pos={626.967, -571.656, 16.921}, rot=270, size=1.5, color={30, 125, 255}, dim=0, int=0},
    {pos={619.315, -547.237, 71.209}, rot=270, size=1.5, color={30, 125, 255}, dim=122, int=24},
},

{ -- Fort Carson
    --[[{pos={-217.842, 979.183, 18.504}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={322.25, 302.42, 999.15}, rot=370, size=1.5, color={200, 0, 255}, dim=1, int=5},]]
},


{ -- Angel Pine
    {pos={-2161.295, -2384.818, 29.897}, rot=270, size=1.5, color={30, 125, 255}, dim=0, int=0},
    {pos={619.315, -547.237, 71.209}, rot=270, size=1.5, color={30, 125, 255}, dim=123, int=23},
},


{ -- Bus job
    {pos={1751.595, -1898.339, 12.561}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={1750.762, -1889.421, 1151.5}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
},


-- Banks
--------->>

{ -- Los Santos Bank
    {pos= {1571.137, -1336.688, 15.484}, rot=315, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={390.096, 173.993, 1007.383}, rot=90, size=1.5, color={200, 0, 255}, dim=150, int=3},
},
{ -- San Fierro Bank
    {pos={-2056.072, 455.144, 34.172}, rot=315, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={390.096, 173.993, 1007.383}, rot=90, size=1.5, color={200, 0, 255}, dim=143, int=3},
},
{ -- Las Venturas Bank
    {pos={1043.151, 1011.417, 10.000}, rot=315, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={390.096, 173.993, 1007.383}, rot=90, size=1.5, color={200, 0, 255}, dim=151, int=3},
},
{ -- Los Santos Bank Heist Front Door
    {pos={595.448, -1250.161, 17.276}, rot=90, size=1.5, color={125, 125, 125}, dim=0, int=0},
    {pos={26.514, -41.055, 175.033}, rot=90, size=1.5, color={125, 125, 125}, dim=30011, int=1},
},
{ -- Los Santos Bank Heist Back Door
    {pos={599.479, -1283.169, 15.025}, rot=270, size=1.5, color={30, 125, 255}, dim=0, int=0, res={job={"Police Officer"}}},
    {pos={61.909, -21.382, 152.872}, rot=180, size=1.5, color={30, 125, 255}, dim=30011, int=1, res={job={"Police Officer"}}},
},

{ -- Los Santos Star Tower - Parachute Jump
    {pos={1548.573, -1364.202, 325.218}, rot=170, size=1.5, color={125, 125, 125}, dim=0, int=0},
    {pos={1528.457, -1379.761, 12.919}, rot=157, size=1.5, color={125, 125, 125}, dim=0, int=0},
},


-- ASGH Interior (LS)
---------------------->>
{
    {id="ASGH.2", pos={1159.581, -1375.487, 14.385}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0, res={job={"Paramedic"}}},
    {refid="ASGH.2", pos={1161.534, -1329.190, 30.496}, rot=0, int=0, size=1.5, color={0, 255, 255}, dim=0, res={ job={"Paramedic"}}},
},
{
    {id="ASGH.3", pos={1157.094, -1323.827, 14.385}, rot=270, size=1.5, color={0, 255, 255}, dim=0, int=0, res={job={"Paramedic"}}},
    {refid="ASGH.3", pos={1144.409, -1323.943, 12.594}, rot=90, int=0, size=1.5, color={0, 255, 255}, dim=0, res={job={"Paramedic"}}},
},

--[[{
    {id="MedicJFHelipad", pos={2042.369, -1395.702, 47.336}, rot=360, size=1.5, color={0, 255, 255}, dim=0, int=0, res={job={"Paramedic"}}},
    {refid="MedicJFHelipad", pos={753.704, 538.321, 232.300}, rot=90, int=1, size=1.5, color={0, 255, 255}, dim=175, res={job={"Paramedic"}}},
},]]

{
    {id="MedicLVHelipad", pos={1607.525, 1787.097, 29.469}, rot=360, size=1.5, color={0, 255, 255}, dim=0, int=0, res={job={"Paramedic"}}},
    {refid="MedicLVHelipad", pos={753.704, 538.321, 232.300}, rot=90, int=1, size=1.5, color={0, 255, 255}, dim=174, res={job={"Paramedic"}}},
},

-- Airports
------------>>

{ -- LS Airport
    {pos={1714.399, -2541.480, 12.569}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={-1835.590, 61.181, 1054.392}, rot=90, size=1.5, color={200, 0, 255}, dim=144, int=14},
},
{ -- SF Airport
    {pos={-1244.063, 22.073, 13.256}, rot=225, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={-1835.590, 61.181, 1054.392}, rot=90, size=1.5, color={200, 0, 255}, dim=145, int=14},
},
{ -- LV Airport
    {pos={1305.005, 1614.890, 10.020}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={-1835.590, 61.181, 1054.392}, rot=90, size=1.5, color={200, 0, 255}, dim=146, int=14},
},

-- Gyms
-------->>

{   -- LS Gym
   --[[ {pos={2229.63, -1721.63, 12.6529}, rot=497, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={772.11, -5, 999.69}, rot=0, size=1.5, color={200, 0, 255}, dim=147, int=5},]]
},
{   -- SF Gym
    {pos={-2270.46, -155.957, 34.3573}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={774.21, -50.02, 999.69}, rot=0, size=1.5, color={200, 0, 255}, dim=148, int=6},
},
{   -- LV Gym
    --[[{pos={1968.7, 2295.3, 15.4955}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {pos={773.58, -78.2, 999.69}, rot=0, size=1.5, color={200, 0, 255}, dim=149, int=7},]]
},

-- Clothing Stores
------------------->>

{
    {id="CSCHP (2)", pos={-2375.32, 910.293, 44.4578}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CSCHP (2)", pos={207.74, -111.42, 1004.27}, rot=5507.58, int=15, size=1.5, color={200, 0, 255}, dim=152},
},
{
    {id="CSCHP (3)", pos={1657.01, 1733.33, 10.0209}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CSCHP (3)", pos={207.74, -111.42, 1004.27}, rot=90, int=15, size=1.5, color={200, 0, 255}, dim=153},
},
{
    --[[{id="CSCHP (4)", pos={2102.69, 2257.49, 10.0579}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CSCHP (4)", pos={207.74, -111.42, 1004.27}, rot=270, int=15, size=1.5, color={200, 0, 255}, dim=154},]]
},

{
    {id="LACS1 (2)", pos={-2491.98, -29.1065, 24.817}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="LACS1 (2)", pos={203.78, -49.89, 1000.8}, rot=90, int=1, size=1.5, color={200, 0, 255}, dim=156},
},
{
    {id="LACS1 (3)", pos={2779.12, 2453.54, 10.061}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="LACS1 (3)", pos={203.78, -49.89, 1000.8}, rot=125, int=1, size=1.5, color={200, 0, 255}, dim=157},
},

{
    {id="CSSPRT (2)", pos={2825.74, 2407.44, 10.061}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CSSPRT (2)", pos={207.06, -139.81, 1002.52}, rot=125, int=3, size=1.5, color={200, 0, 255}, dim=159},
},

{
    {id="CLOTHGP (2)", pos={-1883.2, 865.473, 34.2601}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CLOTHGP (2)", pos={161.39, -96.69, 1000.81}, rot=129, int=18, size=1.5, color={200, 0, 255}, dim=161},
},
{
    {id="CLOTHGP (3)", pos={2572.07, 1904.83, 10.0231}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CLOTHGP (3)", pos={161.39, -96.69, 1000.81}, rot=180, int=18, size=1.5, color={200, 0, 255}, dim=162},
},
{
    --[[{id="CLOTHGP (4)", pos={2090.58, 2224.2, 10.0579}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CLOTHGP (4)", pos={161.39, -96.69, 1000.81}, rot=180, int=18, size=1.5, color={200, 0, 255}, dim=163},]]
},

{
    {id="CSDESGN (2)", pos={-1694.76, 951.599, 24.2706}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CSDESGN (2)", pos={227.29, -7.43, 1001.26}, rot=92, int=5, size=1.5, color={200, 0, 255}, dim=165},
},
{
    {id="CSDESGN (3)", pos={2802.34, 2430.6, 10.061}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CSDESGN (3)", pos={227.29, -7.43, 1001.26}, rot=125, int=5, size=1.5, color={200, 0, 255}, dim=166},
},


-- Prisons
----------->>

-- {
    -- {id="PrisonEntranceBack", pos={209.942, 1410.895, 9.586}, rot=90, size=1.5, color={100, 100, 100}, dim=0, int=0},
    -- {refid="PrisonEntranceBack", pos={3154.458, 823.129, 1654.256}, rot=90, int=1, size=1.5, color={100, 100, 100}, dim=169},
-- },


-- Albatross -->>
-- {
    -- {id="ElbaInt", pos={-3011.898, 1683.512, 38.268}, rot=175, size=1.5, color={100, 100, 100}, dim=0, int=0},
    -- {refid="ElbaInt", pos={ -3012.333, 1693.0400, 38.268}, rot=0, int=170, size=1.5, color={100, 100, 100}, dim=170},
-- },

-- Prison Los Santos Docks
{
    {id="PrisonAlcatraz", pos={2740.982, -2650.529, 27.094}, rot=180, size=1.5, color={125, 125, 125}, dim=0, int=0 },
    {refid="PrisonAlcatraz", pos={2812.380, -2377.479, 117.269}, rot=274, size=1.5, color={125, 125, 125}, dim=169, int=1 },
},

-- Government Offices
---------------------->>

-- Ministry of Development -->
{   -- Ground
    {pos={-2722.021, 326.546, 4.229}, rot=0, size=1.5, color={30, 145, 255}, dim=0, int=0},
    {pos={-2738.727, 315.322, 40.255}, rot=270, int=0, size=1.5, color={30, 145, 255}, dim=172},
},
{   -- Bridge
    {pos={-2723.689, 286.541, 40.399}, rot=270, size=1.5, color={30, 145, 255}, dim=172, int=0},
    {pos={-2715.114, 314.579, 14.200}, rot=270, int=0, size=1.5, color={30, 145, 255}, dim=0},
},
-- Ministry of Architecture -->>
{   -- Ground
    {pos={-2690.536, 326.803, 4.258}, rot=0, size=1.5, color={0, 0, 255}, dim=0, int=0},
    {pos={-2687.442, 301.570, 43.468}, rot=180, int=0, size=1.5, color={0, 0, 255}, dim=171},
},
{   -- Bridge
    {pos={-2676.823, 318.197, 43.468}, rot=180, size=1.5, color={0, 0, 255}, dim=171, int=0},
    {pos={-2697.477, 314.629, 14.200}, rot=90, int=0, size=1.5, color={0, 0, 255}, dim=0},
},
-- Ministry of Administration -->>
{   -- Ground
    {pos={-2687.922, 424.597, 4.095}, rot=180, size=1.5, color={150, 0, 225}, dim=0, int=0},
    {pos={-2739.988, 312.236, 76.385}, rot=180, int=0, size=1.5, color={150, 0, 225}, dim=174},
},
-- GTI Supreme Court
{   -- Ground
    {pos={-2649.951, 376.113, 5.156}, rot=90, size=1.5, color={205, 127, 50}, dim=0, int=0},
    {pos={246.379, 407.867, 140.086}, rot=0, int=1, size=1.5, color={205, 127, 50}, dim=173},
},

-- Civilian Jobs
----------------->>

{   -- LS Fire Station (Ground)
    {pos={1277.325, -1244.131, 12.936}, rot=180, size=1.5, color={30, 255, 125}, dim=0, int=0},
    {pos={1234.470, -1259.802, 15.787}, rot=0, int=0, size=1.5, color={30, 255, 125}, dim=123},
},
{   -- LS Fire Station (Air)
    {pos={1238.333, -1211.115, 24.699}, rot=180, size=1.5, color={30, 255, 125}, dim=0, int=0},
    {pos={1248.443, -1238.177, 15.786}, rot=270, int=0, size=1.5, color={30, 255, 125}, dim=123},
},

---Roof is to short, the map need be fixed
---{ -- Farmer job
--- {id="Farmer", pos={-1061.378, -1195.619, 128.796}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
--- {refid="Farmer", pos={-1086.639, -1199.651, 163.6}, rot=270, size=1.5, color={200, 0, 255}, dim=183, int=1},
---},

-- Default MTA Interiors
------------------------->>
{
    {id="SPECIAL1", pos={-225.433, 1397.02, 69.0501}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SPECIAL1", pos={-224.733, 1395.82, 172.05}, rot=0, int=0, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="SPECIAL2", pos={2896.57, 57.2165, 0}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SPECIAL2", pos={2980.16, 76.1581, 0}, rot=0, int=0, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SPECIAL3", pos={-1749.35, 869.279, 24.0593}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SPECIAL3", pos={-1753.85, 885.679, 295.059}, rot=0, int=0, size=1.5, color={200, 0, 255}, dim=0},
},

{
    {id="ABATOIR", pos={966.608, 2160.68, 9.82222}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="ABATOIR", pos={965.38, 2159.33, 1010.02}, rot=270, int=1, size=1.5, color={200, 0, 255}, dim=0},
},
--[[{
    {id="ATRIUME", pos={1727.64, -1636.88, 19.2198}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="ATRIUME", pos={1726.19, -1638.01, 19.27}, rot=180, int=18, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="ATRIUMX", pos={1699.36, -1667.16, 19.2198}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="ATRIUMX", pos={1700.74, -1668.48, 19.22}, rot=270, int=18, size=1.5, color={200, 0, 255}, dim=0},
},]]

{
    {id="BAR1 (2)", pos={-2551.79, 193.778, 5.21905}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="BAR1 (2)", pos={493.39, -24.92, 999.69}, rot=105, int=17, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="BAR1 (3)", pos={2507.44, 1242.31, 9.83339}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="BAR1 (3)", pos={493.39, -24.92, 999.69}, rot=-3600.01, int=17, size=1.5, color={200, 0, 255}, dim=2},
},
{
    {id="BAR2", pos={2309.62, -1643.63, 13.8385}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="BAR2", pos={501.98, -67.75, 997.84}, rot=93, int=11, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="BAR2 (2)", pos={-2242.69, -88.2558, 34.3578}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="BAR2 (2)", pos={501.98, -67.75, 997.84}, rot=3691.82, int=11, size=1.5, color={200, 0, 255}, dim=1},
},

--[[ 
{
    {id="BAR2 (3)", pos={2441.15, 2065.15, 9.8472}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="BAR2 (3)", pos={501.98, -67.75, 997.84}, rot=180, int=11, size=1.5, color={200, 0, 255}, dim=2},
}, 
]]


{
    {id="BARBER2 (4)", pos={-2571.18, 246.698, 9.64213}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="BARBER2 (4)", pos={418.65, -84.14, 1000.96}, rot=-138, int=3, size=1.5, color={200, 0, 255}, dim=3},
},
--[[{
    {id="BARBER2 (5)", pos={2080.36, 2122.13, 9.82222}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="BARBER2 (5)", pos={418.65, -84.14, 1000.96}, rot=180, int=3, size=1.5, color={200, 0, 255}, dim=4},
},--]]
{
    {id="BARBER3", pos={2723.76, -2026.72, 12.5753}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="BARBER3", pos={412.02, -54.55, 1000.96}, rot=90, int=12, size=1.5, color={200, 0, 255}, dim=0},
},

{
    {id="CASINO2", pos={1659.42, 2249.69, 10.0664}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="CASINO2", pos={1133.07, -12.77, 999.75}, rot=0, int=12, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="DAMIN", pos={-594.874, 2018.21, 59.6792}, rot=330, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="DAMIN", pos={-959.671, 1955.55, 8.08044}, rot=270, int=17, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="DESHOUS", pos={423.99, 2536.49, 15.19}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="DESHOUS", pos={422.16, 2536.52, 9.01}, rot=270, int=10, size=1.5, color={200, 0, 255}, dim=0},
},

{
    {id="DRIVES", pos={-2029.72, -120.926, 34.1691}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="DRIVES", pos={-2029.72, -119.55, 1034.17}, rot=180, int=3, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="DRIVES2", pos={-2026.92, -101.459, 34.259}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="DRIVES2", pos={-2026.92, -103.48, 1034.27}, rot=0, int=3, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="FDREST1", pos={419.191, -1428.71, 31.8959}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="FDREST1", pos={452.89, -18.18, 1000.18}, rot=129, int=1, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="FDREST1 (2)", pos={-2463.06, 132.287, 34.198}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="FDREST1 (2)", pos={452.89, -18.18, 1000.18}, rot=5359.06, int=1, size=1.5, color={200, 0, 255}, dim=1},
},

{
    {id="GF2", pos={-2574.04, 1152.31, 55.72}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="GF2", pos={266.56, 304.95, 999.14}, rot=270, int=2, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="GF3", pos={-382.67, -1438.83, 26.12}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="GF3", pos={292.89, 309.90, 999.15}, rot=90, int=3, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="GF4", pos={-1800.21, 1200.576, 25.119}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="GF4", pos={300.239, 300.584, 999.15}, rot=0, int=4, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="GF5", pos={-1390.186, 2638.72, 55.98}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="GF5", pos={322.25, 302.42, 999.15}, rot=0, int=5, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="GF6", pos={2037.22, 2721.81, 11.29}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="GF6", pos={343.74, 305.0347, 999.15}, rot=180, int=6, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="JUMP1", pos={2268.07, 1619.59, 93.9124}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="JUMP1", pos={2264.49, 1619.58, 1089.5}, rot=270, int=1, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="JUMP2", pos={2268.14, 1675.89, 93.9124}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="JUMP2", pos={2264.48, 1675.93, 1089.5}, rot=270, int=1, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="LACRAK", pos={2166.2, -1671.47, 14.1977}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="LACRAK", pos={318.57, 1115.21, 1082.98}, rot=220, int=5, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="LAHS1B", pos={-2058.97, 889.859, 60.9137}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="LAHS1B", pos={223.04, 1287.26, 1081.2}, rot=362, int=1, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="LAHS2A", pos={-2139.85, 1189.84, 54.7634}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="LAHS2A", pos={260.98, 1284.55, 1079.3}, rot=179, int=4, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="LAHS2A (2)", pos={-2152.4, 1250.16, 24.9503}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="LAHS2A (2)", pos={260.98, 1284.55, 1079.3}, rot=362, int=4, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="LAHS2A (3)", pos={-1955.25, 1190.6, 44.4531}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="LAHS2A (3)", pos={260.98, 1284.55, 1079.3}, rot=180, int=4, size=1.5, color={200, 0, 255}, dim=2},
},

{
    {id="LASTRIP (2)", pos={2506.74, 2120.39, 9.8472}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="LASTRIP (2)", pos={1204.81, -12.79, 1000.09}, rot=0, int=2, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="MADDOGS", pos={1259.39, -785.332, 91.042}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="MADDOGS", pos={1260.58, -785.31, 1090.96}, rot=90, int=5, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="MDDOGS", pos={1298.34, -797.968, 83.1574}, rot=-8, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="MDDOGS", pos={1299.08, -796.83, 1083.03}, rot=200, int=5, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="MOTEL1", pos={2232.87, -1159.71, 24.9416}, rot=-90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="MOTEL1", pos={2214.34, -1150.51, 1024.8}, rot=90, int=15, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="PAPER", pos={2412.6, 1123.81, 9.8529}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="PAPER", pos={390.87, 173.81, 1007.39}, rot=270, int=3, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="PDOMES", pos={-2661.35, 1424.39, 23.0043}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="PDOMES", pos={-2661.01, 1417.74, 921.31}, rot=15, int=3, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="PDOMES2", pos={-2625.33, 1412.62, 6.13148}, rot=180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="PDOMES2", pos={-2637.45, 1402.24, 905.46}, rot=0, int=3, size=1.5, color={200, 0, 255}, dim=0},
},
 {
     --[[{id="RCPLAY", pos={-2242.01, 128.521, 34.4174}, rot=94, size=1.5, color={200, 0, 255}, dim=0, int=0},
     {refid="RCPLAY", pos={-2241.07, 128.52, 1034.42}, rot=270, int=6, size=1.5, color={200, 0, 255}, dim=0},]]
 },
{
    --[[{id="SEXSHOP", pos={2086.42, 2074.48, 10.2043}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SEXSHOP", pos={-100.33, -24.92, 999.74}, rot=270, int=3, size=1.5, color={200, 0, 255}, dim=168},]]
},
{
    {id="SFHSB1 (2)", pos={-2684.77, 819.657, 49.0326}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSB1 (2)", pos={140.18, 1366.58, 1082.97}, rot=186, int=5, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SFHSB3", pos={-2569.1, 795.796, 48.9819}, rot=-40, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSB3", pos={82.95, 1322.44, 1082.89}, rot=2, int=9, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="SFHSB3 (2)", pos={-2539.92, 767.238, 39.0419}, rot=-40, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSB3 (2)", pos={82.95, 1322.44, 1082.89}, rot=270, int=9, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SFHSM1", pos={-2401.5, 869.344, 43.3889}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSM1", pos={-283.55, 1470.98, 1083.45}, rot=270, int=15, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="SFHSS1", pos={-2084.21, 1160.33, 49.2421}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1", pos={-42.58, 1405.61, 1083.45}, rot=362, int=8, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="SFHSS1 (2)", pos={-1913.32, 1252.89, 18.5367}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (2)", pos={-42.58, 1405.61, 1083.45}, rot=362, int=8, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SFHSS1 (3)", pos={-1820.62, 1116.27, 45.5432}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (3)", pos={-42.58, 1405.61, 1083.45}, rot=180, int=8, size=1.5, color={200, 0, 255}, dim=2},
},
{
    {id="SFHSS1 (4)", pos={-1742.78, 1174.34, 24.1582}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (4)", pos={-42.58, 1405.61, 1083.45}, rot=362, int=8, size=1.5, color={200, 0, 255}, dim=3},
},
{
    {id="SFHSS1 (5)", pos={-2157.2, 889.192, 79.0246}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (5)", pos={-42.58, 1405.61, 1083.45}, rot=274, int=8, size=1.5, color={200, 0, 255}, dim=4},
},
{
    {id="SFHSS1 (6)", pos={-2234.16, 830.667, 53.5143}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (6)", pos={-42.58, 1405.61, 1083.45}, rot=92, int=8, size=1.5, color={200, 0, 255}, dim=5},
},
{
    {id="SFHSS1 (7)", pos={-2159.69, 1048.74, 79.03}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (7)", pos={-42.58, 1405.61, 1083.45}, rot=280, int=8, size=1.5, color={200, 0, 255}, dim=6},
},
{
    {id="SFHSS1 (8)", pos={-2239.22, 962.248, 65.6541}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (8)", pos={-42.58, 1405.61, 1083.45}, rot=89, int=8, size=1.5, color={200, 0, 255}, dim=7},
},
{
    {id="SFHSS1 (9)", pos={-2112.58, 745.657, 68.582}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (9)", pos={-42.58, 1405.61, 1083.45}, rot=180, int=8, size=1.5, color={200, 0, 255}, dim=8},
},
{
    {id="SFHSS1 (10)", pos={-2205.27, 743.061, 49.4742}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (10)", pos={-42.58, 1405.61, 1083.45}, rot=185, int=8, size=1.5, color={200, 0, 255}, dim=9},
},
{
    {id="SFHSS1 (12)", pos={-2591.41, -158.542, 3.36046}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (12)", pos={-42.58, 1405.61, 1083.45}, rot=90, int=8, size=1.5, color={200, 0, 255}, dim=11},
},
{
    {id="SFHSS1 (13)", pos={-2558.79, -79.623, 10.0789}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (13)", pos={-42.58, 1405.61, 1083.45}, rot=0, int=8, size=1.5, color={200, 0, 255}, dim=12},
},
{
    {id="SFHSS1 (14)", pos={-2514.04, -170.797, 24.2706}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (14)", pos={-42.58, 1405.61, 1083.45}, rot=-90, int=8, size=1.5, color={200, 0, 255}, dim=13},
},
{
    {id="SFHSS1 (15)", pos={-2447.62, 820.771, 34.256}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (15)", pos={-42.58, 1405.61, 1083.45}, rot=-182, int=8, size=1.5, color={200, 0, 255}, dim=14},
},
{
    {id="SFHSS1 (16)", pos={-2338.61, 579.323, 27.0123}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (16)", pos={-42.58, 1405.61, 1083.45}, rot=-182, int=8, size=1.5, color={200, 0, 255}, dim=15},
},
{
    {id="SFHSS1 (17)", pos={-2321.97, 819.509, 44.3052}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (17)", pos={-42.58, 1405.61, 1083.45}, rot=-182, int=8, size=1.5, color={200, 0, 255}, dim=16},
},
{
    {id="SFHSS1 (18)", pos={-2401.48, 930.783, 44.4973}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (18)", pos={-42.58, 1405.61, 1083.45}, rot=-94, int=8, size=1.5, color={200, 0, 255}, dim=17},
},
{
    {id="SFHSS1 (19)", pos={-2381.23, 1281.01, 22.1852}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (19)", pos={-42.58, 1405.61, 1083.45}, rot=269, int=8, size=1.5, color={200, 0, 255}, dim=18},
},
{
    {id="SFHSS1 (20)", pos={-2279.5, 1148.84, 61.0751}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (20)", pos={-42.58, 1405.61, 1083.45}, rot=260, int=8, size=1.5, color={200, 0, 255}, dim=19},
},
{
    {id="SFHSS1 (21)", pos={-2280.55, 916.429, 65.6849}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS1 (21)", pos={-42.58, 1405.61, 1083.45}, rot=260, int=8, size=1.5, color={200, 0, 255}, dim=20},
},
{
    {id="SFHSS2 (2)", pos={-2591.41, -95.538, 3.44458}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS2 (2)", pos={-68.69, 1351.97, 1079.28}, rot=90, int=6, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SFHSS2 (3)", pos={-2541.61, -145.321, 14.7826}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS2 (3)", pos={-68.69, 1351.97, 1079.28}, rot=0, int=6, size=1.5, color={200, 0, 255}, dim=2},
},
{
    {id="SFHSS2 (4)", pos={-2449.72, 921.163, 57.2093}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS2 (4)", pos={-68.69, 1351.97, 1079.28}, rot=-182, int=6, size=1.5, color={200, 0, 255}, dim=3},
},
{
    {id="SFHSS2 (5)", pos={-2372.92, 692.687, 34.138}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SFHSS2 (5)", pos={-68.69, 1351.97, 1079.28}, rot=-182, int=6, size=1.5, color={200, 0, 255}, dim=4},
},
{
    {id="STADDIRT", pos={1100.72, 1597.29, 12.54}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="STADDIRT", pos={-1400.0179, -663.382, 1051.232}, rot=85, int=4, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="STADSTUNT", pos={1093.99, 1597.04, 12.54}, rot=7, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="STADSTUNT", pos={-1464.942, 1556.091, 1052.53}, rot=0, int=14, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="STAD8TRACK", pos={2779.80, -1812.735, 11.84}, rot=211, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="STAD8TRACK", pos={-1407.80, -269.016, 1043.65}, rot=343, int=7, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="STADBLOOD", pos={2727.618, -1826.647, 11.8}, rot=168, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="STADBLOOD", pos={-1463.46, 941.49, 1036.64}, rot=306, int=15, size=1.5, color={200, 0, 255}, dim=0},
},
{
    --[[{id="STRIP2", pos={693.632, 1966.4, 4.56038}, rot=-180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="STRIP2", pos={1212.02, -25.86, 1000.09}, rot=198.385, int=3, size=1.5, color={200, 0, 255}, dim=0},]]
},
{
    --[[{id="STRIP2 (2)", pos={2543.15, 1025.16, 9.82133}, rot=-180, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="STRIP2 (2)", pos={1212.02, -25.86, 1000.09}, rot=-3780.01, int=3, size=1.5, color={200, 0, 255}, dim=1},]]
},
{
    {id="SVCUNT (5)", pos={-1533.1, 2656.65, 55.275}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVCUNT (5)", pos={2333.11, -1077.1, 1048.04}, rot=180, int=6, size=1.5, color={200, 0, 255}, dim=4},
},
{
    {id="SVCUNT (6)", pos={-1051.47, 1549.76, 32.496}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVCUNT (6)", pos={2333.11, -1077.1, 1048.04}, rot=300, int=6, size=1.5, color={200, 0, 255}, dim=5},
},

{
    {id="SVCUNT (8)", pos={-1438.72, -1544.58, 100.713}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVCUNT (8)", pos={2333.11, -1077.1, 1048.04}, rot=0, int=6, size=1.5, color={200, 0, 255}, dim=7},
},
{
    {id="SVHOT1", pos={-2425.94, 337.87, 35.997}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVHOT1", pos={2233.8, -1115.36, 1049.91}, rot=-118, int=5, size=1.5, color={200, 0, 255}, dim=0},
},

{
    {id="SVLAMD (4)", pos={2449.17, 689.839, 10.471}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVLAMD (4)", pos={2365.3, -1134.92, 1049.91}, rot=450, int=8, size=1.5, color={200, 0, 255}, dim=4},
},
{
    {id="SVLAMD (5)", pos={1408.05, 1897.08, 10.5873}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVLAMD (5)", pos={2365.3, -1134.92, 1049.91}, rot=450, int=8, size=1.5, color={200, 0, 255}, dim=5},
},
{
    {id="SVLAMD (6)", pos={929.122, 2006.43, 10.4781}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVLAMD (6)", pos={2365.3, -1134.92, 1049.91}, rot=450, int=8, size=1.5, color={200, 0, 255}, dim=6},
},

{
    {id="SVSFBG (2)", pos={-2099.68, 897.485, 75.9661}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVSFBG (2)", pos={2196.79, -1204.35, 1048.05}, rot=4374.68, int=6, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SVSFBG (3)", pos={-2027.73, -40.5488, 37.8263}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVSFBG (3)", pos={2196.79, -1204.35, 1048.05}, rot=4139.7, int=6, size=1.5, color={200, 0, 255}, dim=2},
},
{
    {id="SVSFMD", pos={-2454.44, -135.879, 25.2223}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVSFMD", pos={2270.39, -1210.45, 1046.57}, rot=90, int=10, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="SVSFSM", pos={-2213.54, 720.845, 48.4262}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVSFSM", pos={2308.79, -1212.88, 1048.03}, rot=36, int=6, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="SVSFSM (2)", pos={-2700.32, 820.308, 48.999}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVSFSM (2)", pos={2308.79, -1212.88, 1048.03}, rot=-180, int=6, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SVSFSM (3)", pos={2818.75, 2140.56, 13.7132}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVSFSM (3)", pos={2308.79, -1212.88, 1048.03}, rot=360, int=6, size=1.5, color={200, 0, 255}, dim=2},
},
{
    {id="SVVGHO1", pos={2238.99, 1285.05, 9.82528}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVVGHO1", pos={2217.54, -1076.29, 1049.52}, rot=-3870.01, int=1, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="SVVGHO1 (2)", pos={2226.03, 1837.92, 9.964}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVVGHO1 (2)", pos={2217.54, -1076.29, 1049.52}, rot=90, int=1, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SVVGHO2", pos={1965.11, 1622.54, 11.879}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVVGHO2", pos={2237.59, -1080.87, 1048.07}, rot=270, int=2, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="SVVGHO2 (2)", pos={2374.55, 2167.88, 9.8472}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVVGHO2 (2)", pos={2237.59, -1080.87, 1048.07}, rot=125, int=2, size=1.5, color={200, 0, 255}, dim=1},
},
{
    {id="SVVGMD", pos={1274.28, 2522.47, 9.99299}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="SVVGMD", pos={2317.82, -1026.75, 1049.21}, rot=270, int=9, size=1.5, color={200, 0, 255}, dim=0},
},
{
    {id="TATinterior2", pos={-2491.98, -38.9587, 24.817}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="TATinterior2", pos={-204.44, -9.17, 1001.3}, rot=90, int=17, size=1.5, color={200, 0, 255}, dim=0},
},
--[[{
    {id="TATinterior3", pos={2094.7, 2122.13, 9.82222}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="TATinterior3", pos={-204.44, -44.35, 1001.3}, rot=180, int=3, size=1.5, color={200, 0, 255}, dim=0},
},--]]

{
    {id="TRICAS", pos={2019.49, 1007.11, 9.82133}, rot=90, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="TRICAS", pos={2018.95, 1017.09, 995.88}, rot=-3690.01, int=10, size=1.5, color={200, 0, 255}, dim=0},
},

{
    {id="WUZIBET", pos={-2155.92, 645.38, 52.37}, rot=270, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="WUZIBET", pos={-2158.675, 642.8, 1052.4}, rot=134, int=1, size=1.5, color={200, 0, 255}, dim=0},
},

{
    {id="X7_11B (4)", pos={2884.83, 2453.28, 10.061}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="X7_11B (4)", pos={-30.95, -91.71, 1002.55}, rot=224, int=18, size=1.5, color={200, 0, 255}, dim=3},
},
{
    {id="X7_11S", pos={-181.004, 1034.83, 18.8298}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="X7_11S", pos={-26.69, -57.81, 1002.55}, rot=381.648, int=6, size=1.5, color={200, 0, 255}, dim=0},
},

{
  --[[{id="X7_11S (4)", pos={2247.66, 2396.26, 9.8218}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
  {refid="X7_11S (4)", pos={-26.69, -57.81, 1002.55}, rot=0, int=6, size=1.5, color={200, 0, 255}, dim=3},]]
},

--[[ 
{
  {id="X7_11S (5)", pos={2452.47, 2065.15, 9.8472}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
  {refid="X7_11S (5)", pos={-26.69, -57.81, 1002.55}, rot=180, int=6, size=1.5, color={200, 0, 255}, dim=4},
},
]]

{
    --[[{id="X7_11S (7)", pos={2097.76, 2224.2, 10.0579}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="X7_11S (7)", pos={-26.69, -57.81, 1002.55}, rot=180, int=6, size=1.5, color={200, 0, 255}, dim=6},]]
},
 {
    {id="X7_11S (8)", pos={1937.25, 2307.17, 9.82222}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=0},
    {refid="X7_11S (8)", pos={-26.69, -57.81, 1002.55}, rot=90, int=6, size=1.5, color={200, 0, 255}, dim=7},
},

{
    {id="AMRG", pos={286, -27.7, 1000.40}, rot=0, size=1.5, color={200, 0, 255}, dim=0, int=1},
    {refid="AMRG", pos={286, -31, 1000.40}, rot=0, int=1, size=1.5, color={200, 0, 255}, dim=0},
},

-- Red County, Drug Factory
{
    {id="DrugLab1", pos={-50.540, -233.662, 5.765}, rot=2, size=1.5, color={200, 0, 0}, dim=0, int=0, res={team={"Criminals", "General Population", "Emergency Services"}}},
    {refid="DrugLab1", pos={222.375, 229.529, 1670.069}, rot=89, int=1, size=1.5, color={200, 0, 0}, dim=20000},
},

{
    {id="DrugLab2", pos={-49.907, -269.363, 5.633}, rot=178, size=1.5, color={51, 51, 255}, dim=0, int=0, res={team={"Law Enforcement", "Emergency Services"}}},
    {refid="DrugLab2", pos={220.539, 216.726, 1686.469}, rot=89, int=1, size=1.5, color={51, 51, 255}, dim=20000},
},

--HOSPITALS
-- Big Hospital interiors
-- LV hospital
{
    {pos={1607.523, 1815.748, 9.820}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={690.98492, 498.17297, 228}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=174},
},

--[[Jefferson Hospital
{
    {pos={2034.227, -1402.086, 16.2950}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={690.98492, 498.17297, 228}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=175},
},]]

--San Fierro Hospital
{
    {pos={-2655.807, 639.484, 13.455}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={690.98492, 498.17297, 228}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=176},
},
--Small Hospital Interiors
--Palomino creek hospital
{
    {pos={2269.855, -74.563, 25.772}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={-40.29477, 4.96125, 485.35370}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=177},
},
--Montogomery hospital
{
    {pos={1241.853, 326.537, 18.756}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={-40.29477, 4.96125, 485.35370}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=178},
},
--Angel pine hospital
{
    {pos={-2203.398, -2309.950, 30.375}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={-40.29477, 4.96125, 485.35370}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=179},
},
--Fort Carson hospital
{
    {pos={-319.724, 1048.873, 19.340}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={-40.29477, 4.96125, 485.35370}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=180},
},

--Las paysadas hospital
{
    {pos={-254.955, 2603.058, 61.858}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={-40.29477, 4.96125, 485.35370}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=181},
},

--El quebrados hospital
{
    {pos={-1514.870, 2520.018, 54.980}, rot=0, size=1.5, color={0, 255, 255}, dim=0, int=0},
    {pos={-40.29477, 4.96125, 485.35370}, rot=0, int=1, size=1.5, color={0, 255, 255}, dim=182},
},

-- stunt area
{
    { pos={318.653, 2997.875, 2.694}, rot=0, int=0, size=1.5, color={200, 0, 255}, dim=0, size=1.5}, -- ENTRY
    { pos={487.020, 3138.249, 10.823}, rot=82, int=0, size=1.5, color={200, 0, 255}, dim=0, size=1.5}, -- RETURN
},

-- San Fierro Airport Ladders
----------------->>

{
    { pos={-1154.28271,-476.74121,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1155.32886,-475.97491,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1081.89661,-207.92166,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1082.91101,-208.38393,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1182.62012,60.41198,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1183.40125,59.61171,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1115.79358,335.34351,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1116.51135,336.00534,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1164.62573,370.01111,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1163.89978,369.28177,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1444.46143,90.22887,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1443.72888,89.51561,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1618.73132,-84.00182,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1617.99463,-84.75718,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1736.448,-445.93863,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1735.27393,-445.91351,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1603.39441,-696.64368,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1603.42188,-695.56299,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},

{
    { pos={-1361.07251,-696.64319,0.9}, rot=135, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- ENTRY
    { pos={-1361.07581,-695.4176,14.1}, rot=90, int=0, size=1.2, color={125, 125, 125}, dim=0}, -- RETURN
},


-- Premium Shops
----------------->>

{   -- Los Santos
    {pos={1651.778, -1246.738, 13.813}, rot=90, size=1.5, color={0, 178, 240}, dim=0, int=0},
    {pos={283.740, 145.132, 194.910}, rot=0, int=1, size=1.5, color={0, 178, 240}, dim=124},
},
{   -- San Fierro
    {pos={-1897.012, 487.131, 34.172}, rot=90, size=1.5, color={0, 178, 240}, dim=0, int=0},
    {pos={283.740, 145.132, 194.910}, rot=0, int=1, size=1.5, color={0, 178, 240}, dim=125},
},
{   -- Las Venturas
    {pos={2007.565, 1167.470, 9.820}, rot=270, size=1.5, color={0, 178, 240}, dim=0, int=0},
    {pos={283.740, 145.132, 194.910}, rot=0, int=1, size=1.5, color={0, 178, 240}, dim=126},
},

-- Groups
----------------->>

-- GHoST
{
    {pos={1496.214, 731.663, 9.842}, rot=0, size=1.5, color={40, 80, 5}, dim=0, int=0, res = { wl = 0 } },
    {pos={1929.358, 1986.442, 683.9}, rot=90, size=1.5, color={40, 80, 5}, dim=4500, int=1 --[[,res = { wl = 0 } ]]},
},

-- TriForce
{
    { pos={1063.915, -287.725, 73.001}, rot=322, size=1.5, color={215, 230, 0}, dim=0, int=0, res = { wl = 0 } },
    { pos={1010.531, -410.147, 1012.019}, rot=90, size=1.5, color={215, 230, 0}, dim=4501, int=1--[[,res = { wl = 0 } ]] },
	
},
-- CIA
{
    { pos={1842.745,-1277.808, 5.252}, rot=322, size=1.5, color={0, 55, 129}, dim=0, int=0, res = { wl = 0 } },
    { pos={1924.817, -1340.988, 79.952}, rot=90, size=1.5, color={0, 55, 129}, dim=300, int=1--[[,res = { wl = 0 } ]] },
},
}

-- Export
function getInteriorsTable()
    return interiors
end
