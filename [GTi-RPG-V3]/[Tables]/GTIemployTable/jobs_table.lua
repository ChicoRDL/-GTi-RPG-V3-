----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 03 Dec 2013
-- Resource: GTIemployment/jobs_table.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Job Information
------------------->>

JobInfo = {
--[[
    Example Table:
["Job Name"] = {
    team="Team Name",
    divisions={"Division A", "Division B"},
    skins={{SkinID,"Skin Name"}, {SkinID,"Skin Name"}},
    wanted=maxWantedPoints,
    desc="Place Job Description Here. Make the description good, it's very important.",
},

** Keep Job Names in Alphabetical Order (A-B-C)
--]]
-- Civilian Jobs
----------------->>

["Bus Driver"] = {
    team="Civilian Workforce",
    employer="Transportation Ministry",
    skins={{253,"Driver 1"},{255,"Driver 2"}},
    wanted=20,
    desc="Soon.",
},
["Farmer"] = {
    team="Civilian Workforce",
    employer="Agriculture Ministry",
    divisions={{"Bail Farmer", 0}, {"Weed Farmer", 3}},
    skins={{158,"Old Farmer"},{159,"Hillbilly"},{160,"Bearded Farmer"},{161,"Male Farmer"},{157,"Female Farmer"},{162,"Shirtless Farmer"}},
    wanted=20,
    desc="Farmers farm buy seeds. once they buy seeds, they wait for a period of time before those seeds turn into plants. They then farm them and in return, earn a decent amount amount of money.",
},

--[[
["Fisherman"] = {
    team="Civilian Workforce",
    employer="Fish & Co",
    skins={{35,"Fisherman"}},
    wanted=20,
    desc="Fisherman must go out to sea and catch fish. The better fish caught, the better the pay once selling your net of fish. Certain fish will be heavier and will cause you to have your net fill up quicker.",
}, ]]

["Lumberjack"] = {
    team="Civilian Workforce",
 --   divisions={"Lumberjack"},
    skins={{27,"Winston Stafford"}, {260,"Allard Bradford"}},
    wanted=20,
    desc="Lumberjacks are workers in the logging industry \nwho perform the initial harvesting and transport of trees for ultimate processing into forest products. \nYour object is to use the Bulldozer to cut trees, anywhere in San Andreas \nthen afterwards use the DFT-30 to transport them to the Furniture Factory",
},
["Mail Carrier"] = {
    team="Civilian Workforce",
    employer="S.A. Postal Service",
    skins={{36,"Mailman"}},
    wanted=20,
    desc="Mail Carriers deliver mail and packages to homes and businesses within the city.",
},
["Mechanic"] = {
    team="Civilian Workforce",
    employer="Transportation Ministry",
    skins={{50,"Mechanic"},{268,"Dwaine"},{305,"Jethro"}},
    wanted=20,
    desc="The role of a mechanic is to repair people's vehicles. Mechanics can also tow broken down or abandoned cars and return them to the shop.",
},
["Pilot"] = {
    team="Civilian Workforce",
    employer="Juank Air Lines",
    divisions={{"Small Flight", 0}, {"Medium Flight", 2}, {"Commercial", 3}, --[[{"Helicopter", 0}]]},
    skins={{61,"Pilot"}},
    wanted=20,
    desc="Pilots fly passengers and cargo via airplanes and helicopters between airports and other locations around San Andreas. Small Flight division Can only take the Dodo and Beagle, Medium Flight LV2 Division can only take the Shamal and Nevada, Commercial LV3 can only take the Andromada and AT-400",
},
["Quarry Miner"] = {
    team="Civilian Workforce",
    employer="Distributed Mining Co.",
    skins={{27,"Miner 1"},{260,"Miner 2"}},
    wanted=20,
    desc="You'll need to rent a shovel (pickaxe). Quarry miners have the duty to smash big rocks into small fragements in order to extract elements. These elements can vary between Copper, Silver, Bronze, Iron, and Gold. Based on these elements, the pay will vary depending on what they find. The job may seem easy, but can also carry risks!",
},
--[[["Taxi Driver"] = {
    team="Civilian Workforce",
    employer="San Andreas Taxi Co.",
    skins={{7,"Driver"}},
    wanted=20,
    desc="Taxi Drivers are the ones that keep San Andreas's passengers moving. With the cheap fares and speedy drives to their destinations, passengers will surely enjoy the business that San Andreas Taxi Co. provides.",
},]]--
["Train Driver"] = {
    team="Civilian Workforce",
    employer="Brown Streak Railroad",
    skins={{255,"Limo Driver"}},
    wanted=20,
    desc="Train Drivers transport passengers and fright around San Andreas via rail.",
    },
["Trucker"] = {
    team="Civilian Workforce",
    employer="Xoomer",
    divisions={{"Car Supplier", 0}, {"Bulk Transporter", 0}, {"Petroleum Supplier", 1}, {"Weapon Supplier", 2}, {"Animal Transporter", 3}},
    skins={{133,"Trucker 1"}, {202,"Trucker 2"}, {206,"Trucker 3"}},
    wanted=20,
    desc="Truckers their job is to supply whole SA with goods, such as cars, weapons, petroleum etc.",
},
--[[["Petroleum Engineer"] = {
    team="Civilian Workforce",
    employer="Xoomer",
    skins={{153,"Engineer 1"}, {260,"Engineer 2"}},
    wanted=20,
    desc="Petroleum Engineers extracting the oil from the oil fields which located at Octane Springs, Bone Country.",
},]]--
["Journalist"] = {
    team="Civilian Workforce",
    employer="San Andreas News",
    --divisions={"Journalist"},
    skins={{147,"Sigmund Freud"}, {295,"Mike Toreno"}},
    wanted=20,
    desc="A journalist is a person who works with collecting, writing and distributing news and other current information. \n Your job is to take picture of any terrorist or criminal act then make a report describing of what exactly happened.",
},
["Pizza Delivery"] = {
    team="Civilian Workforce",
    employer="The Well Stacked Pizza",
    --divisions={""},
    skins={{155,"Pizza Boy"}},
    wanted=20,
    desc="Deliver Pizzas from a pizza shop to customers arround cities.",
},
["Trash Collector"] = {
    team="Civilian Workforce",
    employer="RS Haul",
    --divisions={""},
    skins={{16,"Skin 1"}},
    wanted=20,
    desc="Collect the rubbish arround LS, when it's full, return to the dump for payment.",
},
["Mariner"] = {
    team="Civilian Workforce",
    --divisions={""},
    skins={{255,"Limo Driver"}},
    wanted=20,
    desc="Transport people and cargo between ports on the seas.",
},
-- Emergency Services Jobs
--------------------------->>

["Paramedic"] = {
    team="Emergency Services",
    employer="Health Ministry",
    skins={{274,"Medic 1"},{275,"Medic 2"},{276,"Medic 3"}},
    wanted=20,
    desc="Medics travel around San Andreas or within each city, and have the role of healing players who are low on health.",
},

["Firefighter"] = {
    team="Emergency Services",
    employer="Fire Department",
    skins={{277,"LS Firefighter"},{278,"LV Firefighter"},{279,"SF Firefighter"}},
    wanted=0,
    desc="Extinguish local fires and vehicle fires around San Andreas.",
},

-- Law Enforcement Jobs
------------------------>>

["Police Officer"] = {
    team="Law Enforcement",
    employer="Justice Ministry",
    divisions={{"Police Officer", 0}, {"SWAT Division", 0}, {"Highway Patrol", 2}, {"Corrections", 3}, {"Federal Agent", 8}},
    skins={
        {288, "Cop 5",      "Police Officer"},
        {282, "Cop 3",      "Police Officer"},
        {283, "Cop 4",      {"Police Officer", 1}},
        {280, "Cop 1",      {"Police Officer", 3}},
        {281, "Cop 2",      {"Police Officer", 4}},
        {267, "Hernandez",  {"Police Officer", 10}},
        {266, "Pulaski",    {"Police Officer", 11}},
        {265, "Tenpenny",   {"Police Officer", 12}},
        {285, "SWAT", "SWAT Division"},
        {284, "Officer", "Highway Patrol"},
        {71, "Guard", "Corrections"},
        {286, "Agent", "Federal Agent"}
    },
    wanted=0,
    desc="The law enforcement of GTI excels in supplying policing services to the inhabitants of San Andreas.\n\nThough the main duties involve pursuing, patrolling, and fining. The main reason to become a law enforcer should be to help the people around you, protect civilians, provide a listening ear, and as such, maintain order in the streets.",
},
--[[["National Guard"] = {
    team="National Guard",
    employer="Justice Ministry",
    skins={{287, "Army"}, {73, "Flag Bandana"}, {179, "War Vet"}},
    wanted=0,
    desc="NOTE",
}]]
}

-- Job Locations
----------------->>

JobLoc = {
--[[
    Example Table:
{job="Job Name", mLoc={x, y, z, int, dim}, mCol={r, g, b}, blipLoc={x, y, int, dim}, blipID=ID},
},

-- Place your job marker in the right section (LS/SF/LV; Civilian/EMS/Law)
-- Keep Job Locations in Alphabetical Order
-- blipLoc Optional (Attached to Marker by Default)
-- blipID Optional (Default: 56)
-- Job Name must equal the same job name above!
--]]

-- Los Santos
-------------->>

-- Civilian Jobs
{job="Bus Driver",      mLoc={1738.559, -1880.444, 1151.047},       mCol={255, 200, 0}, blipLoc={1751.595, -1898.596},  blipID=56},
--{job="Fisherman",     mLoc={120.170, -1915.411, 2.155},           mCol={255, 200, 0}, blipLoc={120.170, -1915.411},   blipID=56},
{job="Mechanic",        mLoc={1036.295, -1025.5, 31.101},           mCol={255, 200, 0}, blipLoc={1036.295, -1025.5},    blipID=56},
{job="Lumberjack",      mLoc={-1969.415, -2427.950, 29.625},        mCol={255, 200, 0}, blipLoc={-1969.415, -2427.950}, blipID=56}, -- Angel Pine
{job="Pilot",           mLoc={-1868.649, 46.169, 1054.184, 14, 144},mCol={255, 200, 0}, blipLoc={1714.399, -2541.480},  blipID=56},
{job="Journalist",      mLoc={648.716, -1357.180, 12.568},          mCol={255, 200, 0}, blipLoc={648.716, -1357.180},   blipID=56},
{job="Pizza Delivery",  mLoc={2123.222, -1813.903, 12.554},         mCol={255, 200, 0}, blipLoc={2123.222, -1813.903},  blipID=56},
--{job="Taxi Driver",       mLoc={2162.410, -2170.121, 12.54687},       mCol={255, 200, 0}, blipLoc={2162.410, -2170.121},  blipID=56},
{job="Trash Collector", mLoc={-61.082, -1109.089, 0.294},           mCol={255, 200, 0}, blipLoc={-61.082, -1109.089},   blipID=56},

-- Emergency Services
{job="Firefighter",     mLoc={1234.182, -1248.401, 15.789, 0, 123}, mCol={30, 255, 125},    blipLoc={1277.325, -1244.486},  blipID=56},
{job="Firefighter",     mLoc={1774.244, 2083.793, 9.820, 0, 0},     mCol={30, 255, 125},    blipLoc={1774.244, 2083.763},   blipID=56},
{job="Paramedic",       mLoc={1165.444, -1326.340, 14.385},         mCol={30, 255, 125},    blipLoc={1165.482, -1326.039},  blipID=56}, -- All Saints
{job="Paramedic",       mLoc={2037.048, -1393.063, 16.286, 0, 0},   mCol={30, 255, 125},    blipLoc={2033.698, -1404.043},  blipID=56}, -- Jefferson
--{job="Paramedic",         mLoc={690.065, 510.411, 228.15, 1, 175},    mCol={30, 255, 125},    blipLoc={2033.698, -1404.043},  blipID=56}, -- Jefferson
--{job="Paramedic",         mLoc={-36.992, 11.631, 484.347, 1, 177},    mCol={30, 255, 125},    blipLoc={2269.855, -74.563},    blipID=56}, -- Palomino Creek
--{job="Paramedic",         mLoc={-36.992, 11.631, 484.347, 1, 180},    mCol={30, 255, 125},    blipLoc={-319.724, 1048.873},   blipID=56}, -- Fort Carson
--{job="Paramedic",         mLoc={-36.992, 11.631, 484.347, 1, 179},    mCol={30, 255, 125},    blipLoc={-2203.398, -2309.950, 30.375},     blipID=56}, -- Angel Pine

-- Law Enforcement
--{job="Police Officer",    mLoc={246.531, 118.537, 1002.219, 10, 141}, mCol={30, 125, 255},blipLoc={1554.950, -1674.990},  blipID=56},
{job="Police Officer",  mLoc={1561.679, -1678.490, 15.191, 0, 0}, mCol={30, 125, 255},blipLoc={1561.679, -1678.490},    blipID=30},
{job="Police Officer",  mLoc={630.533, -547.240, 71.209, 24, 122},    mCol={30, 125, 255},blipLoc={626.967, -571.656},        blipID=56},
{job="Police Officer",  mLoc={630.533, -547.240, 71.209, 23, 123},    mCol={30, 125, 255},blipLoc={-2163.314, -2386.976},        blipID=56},

-- San Fierro
-------------->>

-- Civilian Jobs
{job="Farmer",          mLoc={-1060.479, -1203.0179, 128.218},          mCol={255, 200, 0}, blipLoc={-1060.479, -1203.0179},    blipID=56},
{job="Mariner",         mLoc={-1552.306, 1277.042, 6.186},              mCol={255, 200, 0}, blipLoc={-1552.306, 1277.042},      blipID=56},
{job="Mechanic",        mLoc={-2042.137, 153.762, 27.841},              mCol={255, 200, 0}, blipLoc={-2042.137, 153.762},       blipID=56},
{job="Pilot",           mLoc={-1868.649, 46.169, 1054.184, 14, 145},    mCol={255, 200, 0}, blipLoc={-1243.052, 20.612},        blipID=56},
{job="Trucker",      mLoc={-516.243, -505.664, 24.523},              mCol={255, 200, 0}, blipLoc={-516.243, -505.664},       blipID=56},
-- Emergency Services
{job="Paramedic",       mLoc={690.065, 510.411, 228.15, 1, 176},        mCol={0, 255, 255}, blipLoc={-2656.064, 636.801},       blipID=56},
{job="Firefighter",     mLoc={-2024.564, 67.056, 27.442},               mCol={0, 255, 255}, blipLoc={-2024.564, 67.056},        blipID=56},
-- Law Enforcement
{job="Police Officer",  mLoc={246.631, 118.490, 1002.219, 10, 142},     mCol={30, 125, 255},blipLoc={-1605.480, 712.919},       blipID=30},

-- Las Venturas
---------------->>

-- Civilian Jobs
{job="Mail Carrier",    mLoc={1053.600, 2148.289, 9.820},           mCol={255, 200, 0},     blipLoc={1053.600, 2148.289},   blipID=56},
{job="Mechanic",        mLoc={2160.206, 1414.799, 10.100},          mCol={255, 200, 0},     blipLoc={2160.206, 1414.799},   blipID=56},
--{job="Petroleum Engineer",        mLoc={582.749, 1225.661, 10.7},             mCol={255, 200, 0}, blipLoc={582.749, 1225.661},        blipID=56},
{job="Pilot",           mLoc={-1868.649, 46.169, 1054.184, 14, 146},mCol={255, 200, 0},     blipLoc={1305.005, 1614.890},   blipID=56},
{job="Quarry Miner",    mLoc={321.49648, 852.3453, 19.406},         mCol={255, 205, 0},     blipLoc={321.49648, 852.3453},  blipID=56}, --- Miner Place
{job="Train Driver",  mLoc={1430.055, 2654.311, 10.393},          mCol={255, 200, 0}, },
-- Emergency Jobs
{job="Paramedic",           mLoc={690.065, 510.411, 228.15, 1, 174},    mCol={0, 255, 255},     blipLoc={1607.375, 1818.071},   blipID=56},
-- Law Enforcement
--{job="National Guard",        mLoc={94.962, 1913.117, 17.048},    mCol={30, 125, 255},    blipLoc={94.962, 1913.117},     blipID=30},
{job="Police Officer",      mLoc={2348.481, 2472.553, 13.979, 0, 0},  mCol={30, 125, 255},    blipLoc={2348.481, 2472.553},   blipID=30},
{job="Police Officer",      mLoc={325.244, 304.982, 998.148, 5, 0},     mCol={30, 125, 255},    blipLoc={-1389.957, 2638.386},  blipID=56},
{job="Police Officer",      mLoc={-222.092, 982.326, 18.675, 0, 0},     mCol={30, 125, 255},    blipLoc={-217.842, 979.183},    blipID=56},

}

function getJobsTable(type)
    if (type == "locations") then
        return JobLoc
    else
        return JobInfo
    end
end
