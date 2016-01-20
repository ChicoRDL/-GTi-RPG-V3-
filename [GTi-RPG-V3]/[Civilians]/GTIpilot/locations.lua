----------------------------------------->>
-- GTI: Grand Theft International Network
-- Date: 14 Feb 2014
-- Resource: GTIpilot/locations.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Pilot Gates
--------------->>

PilotGates = {
{ -- Los Santos International
	{1713.809, -2628.724, 12.579},
	{1796.543, -2628.581, 12.570},
	{1845.737, -2629.242, 12.602},
	{1895.929, -2628.921, 12.576},
	{2066.640, -2614.174, 12.590},
	{2102.626, -2474.109, 12.583},
	{1811.038, -2451.122, 12.574},
	{1610.515, -2463.664, 12.578},	},
{ -- Easter Bay Airport
	{-1348.475, -231.233, 13.167},
	{-1237.185, -277.410, 13.197},
	{-1299.778, -370.939, 13.179},
	{-1328.414, -491.423, 13.180},
	{-1471.883, -552.233, 13.191},
	{-1453.094, -621.689, 13.167},
	{-1340.966, -615.092, 13.198},
	{-1204.150, -499.125, 13.185},
	{-1210.835, -140.888, 13.193},
	{-1258.284, -95.531, 13.203},	},
{ -- Las Venturas Airport
	{1530.843, 1684.318, 9.869},
	{1494.994, 1835.784, 9.832},
	{1358.471, 1715.930, 9.875},
	{1355.578, 1525.178, 9.863},
	{1313.439, 1342.910, 9.872},
	{1411.471, 1241.569, 9.852},
	{1582.971, 1301.608, 9.893},
	{1557.621, 1453.427, 9.868},
	{1641.708, 1550.029, 9.826},	},
{ -- Verdant Meadows Aircraft Graveyard
	{365.988, 2537.419, 15.698},
	{339.635, 2472.670, 15.526},
	{411.181, 2489.543, 15.524},
	{247.016, 2464.236, 15.526},
	{137.331, 2461.578, 15.501},
	{75.892, 2531.261, 15.433},
	{1.403, 2483.116, 15.528},
	{200.594, 2522.423, 15.783},	},
}

-- SFC Extreme Type
-------------------->>

PilotExtreme = {
	{2901.111, -913.052, 9.947, 	"on the highway in East Beach, LS"},
	{1745.638, -2717.096, 12.439, 	"at the beach just south of LS Airport"},
	{836.848, -1947.657, 11.767, 	"on the pier in Verona Beach, LS"},
	{33.790, -25.144, 1.473, 		"at the Blueberry Acres farm in Blueberry"},
	{1909.842, -505.913, 17.049, 	"on a small strip near Palomino Creek"},
	{-264.098, -1374.288, 9.291, 	"on a farm in Flint County"},
	{-2311.975, -1634.977, 482.523,	"on top of Mt. Chiliad"},
	{-2899.089, 9.771, 3.441, 		"at the beach in western San Fierro"},
	{893.130, 892.292, 12.277, 		"at the Hunter Quarry"},
}

-- SFC Responses
----------------->>

randomResponses = {
	"Hey, can you fly me off to [airport] please. I appreciate it.",
	"Wassup, take me to [airport] and be quick about it.",
	"Hello there, do you mind flying me to [airport]? Thanks.",
	"Aye, how you doin'. Fly me off to [airport].",
	"Hi, can you please fly me to [airport]. Much obliged.",
	"Hey there! I need to go to [airport], take me there?",
	"Hello, can you please fly us to [airport]. I have a meeting to attend.",
	"Oh thank goodness you've arrived! I need to go to [airport]. Can you take me there?",
	"Hello, can I get a ride to [airport] please?",
	"How are you doing? If possible, can you take me to [airport]?",
	"Hey, can I get a ride to [airport]?",
	"[airport] please.",
	"Yo, lemme get a ride to [airport].",
	"Hi, can you fly me to [airport]? I'm going to visit my family for a while.",
	"Excuse me, can you please fly me to [airport]? I'm going on vacation, taking a while off of work.",
}

mistakeResponses = {
	"Oops! I actually needed to go to [airport]. Take me there instead.",
	"Aw, I made a mistake. Can you take me to [airport] instead?",
	"Oh wow, sorry. I needed to go to [airport], not here.",
	"Excuse me, it appears I misspoke. I need to go to [airport].",
	"Silly me, I need to go to [airport]. You don't mind do you? Thanks.",
}

-- MFC Extreme
--------------->>

PilotMFCExtreme = {
	{1536.860, -2542.563, 12.547},
	{-1268.126, -150.776, 13.148},
	{1388.669, 1814.129, 9.820},
	{-43.245, 2504.806, 15.484},
}

-- Commercial Gates
-------------------->>

commGates = {
{ -- Los Santos International
	{1724.479, -2432.283, 12.591},
	{1639.283, -2432.283, 12.590},
	{1555.803, -2432.283, 12.583},
	--{1425.823, -2432.283, 12.621},
	{2114.811, -2442.283, 12.585},
},
{ -- Easter Bay Airport
	{-1324.558, -457.366, 13.183},
	{-1281.707, -366.647, 13.200},
	{-1318.866, -250.380, 13.198},
	{-1360.344, -206.922, 13.182},
	{-1478.775, -168.243, 13.200},
},
{ -- Las Venturas Airport
	{1635.953, 1551.793, 9.827},
	{1548.117, 1501.619, 9.894},
	{1571.254, 1559.442, 9.872},
	{1552.727, 1418.156, 9.885},
	{1571.119, 1345.847, 9.897},
},
}
