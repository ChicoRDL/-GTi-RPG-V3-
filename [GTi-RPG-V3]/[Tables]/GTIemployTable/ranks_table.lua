----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 19 Dec 2013
-- Resource: GTIemployTable/ranks_table.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Job Ranks
------------->>

Ranks = {
--[[
    Example Table:
["Job Name"] = {
    [0] = {name="Rank Level 0",     promoTime=0},
    [1] = {name="Rank Level 1",     promoTime=1.25},
    [2] = {name="Rank Level 2",     promoTime=2.5},
    [3] = {name="Rank Level 3",     promoTime=5},
    [4] = {name="Rank Level 4",     promoTime=11},
    [5] = {name="Rank Level 5",     promoTime=22},
    [6] = {name="Rank Level 6",     promoTime=44},
},

** Keep Job Names in Alphabetical Order (A-B-C)
** promoTime = Time it takes to reach that level (in hours)
** promoTime is NOT progress, that's in the SECOND table below
--]]

-- Civilian Jobs
----------------->>

["Bus Driver"] = {
    [0] = {name="Trainee",                  promoTime=0},
    [1] = {name="Bus Driver",               promoTime=0.75},
    [2] = {name="Bus Driver I",             promoTime=3},
    [3] = {name="Bus Driver II",            promoTime=7},
    [4] = {name="Bus Driver III",           promoTime=13},
    [5] = {name="Bus Driver IV",            promoTime=20},
    [6] = {name="Bus Driver V",             promoTime=30},
    [7] = {name="Bus Driver VI",            promoTime=43},
    [8] = {name="Bus Driver VII",           promoTime=60},
    [9] = {name="Bus Driver IX",            promoTime=85},
    [10] = {name="Professional Driver",     promoTime=150},
},

["Farmer"] = {
    [0] = {name="Basic Farmer",         promoTime=0},
    [1] = {name="New Farmer",           promoTime=0.75},
    [2] = {name="Migrant Farmer",       promoTime=3},
    [3] = {name="Seasonal Farmer",      promoTime=7},
    [4] = {name="Yearly Farmer",        promoTime=13},
    [5] = {name="Botanical Maid",       promoTime=20},
    [6] = {name="Experienced Farmer",   promoTime=30},
    [7] = {name="Amish Son",            promoTime=43},
    [8] = {name="Amish Father",         promoTime=60},
    [9] = {name="Agricultural Madman",  promoTime=85},
    [10] = {name="Amish God",           promoTime=150},
},

--[[
["Fisherman"] = {
    [0] = {name="Trainee",              promoTime=0},
    [1] = {name="Freelance Fisher",     promoTime=0.75},
    [2] = {name="Assistant Fisherman",  promoTime=3},
    [3] = {name="Junior Fisherman",     promoTime=7},
    [4] = {name="Migrant Fisherman",    promoTime=13},
    [5] = {name="Annual Fisherman",     promoTime=20},
    [6] = {name="Specialist Fisherman", promoTime=30},
    [7] = {name="Expert Fisherman",     promoTime=43},
    [8] = {name="Master Fisherman",     promoTime=60},
    [9] = {name="Son of the Seas",      promoTime=85},
    [10] = {name="God of the Seas",     promoTime=150},
},]]

["Journalist"] = {
    [0] = {name="Journalist",  promoTime=0},
    [1] = {name="News reporter",  promoTime=3},
    [2] = {name="Columnist",  promoTime=7},
    [3] = {name="Presenter",  promoTime=11},
    [4] = {name="Photographer",  promoTime=16},
    [5] = {name="Superintendent reporter",  promoTime=21},
},

["Lumberjack"] = {
    [0] = {name="Lumberjack",           promoTime=0},
    [1] = {name="Fast Chopper",         promoTime=5},
    [2] = {name="Slicer",               promoTime=10},
    [3] = {name="Expert Lumberjack",    promoTime=18},
    [4] = {name="Master Lumberjack",    promoTime=30},
},

["Mail Carrier"] = {
    [0] = {name="Training",                 promoTime=0},
    [1] = {name="Pack Mule",                promoTime=0.75},
    [2] = {name="Courier",                  promoTime=3},
    [3] = {name="Mail Carrier",             promoTime=7},
    [4] = {name="Postal Worker",            promoTime=13},
    [5] = {name="Senior Postal Worker",     promoTime=20},
    [6] = {name="Mail Specialist",          promoTime=30},
    [7] = {name="Logistics Manager",        promoTime=43},
    [8] = {name="Chief Logistics Manager",  promoTime=60},
    [9] = {name="Master of Logistics",      promoTime=85},
},

["Mariner"] = {
    [0] = {name="Trainee",                  promoTime=0},
    [1] = {name="Novice Sailor",            promoTime=0.75},
    [2] = {name="Experienced Sailor",       promoTime=3},
    [3] = {name="Assistant Specialist",     promoTime=7},
    [4] = {name="Captain",                  promoTime=13},
    [5] = {name="Transport Tycoon",         promoTime=20},
    [6] = {name="God of the Sea",           promoTime=30},
},

["Mechanic"] = {
    [0] = {name="Tinkerer",                 promoTime=0},
    [1] = {name="Student Mechanic",         promoTime=0.75},
    [2] = {name="Unlicensed Mechanic",      promoTime=3},
    [3] = {name="Certified Mechanic",       promoTime=7},
    [4] = {name="Auto Technician",          promoTime=13},
    [5] = {name="Auto Specialist",          promoTime=20},
    [6] = {name="Senior Auto Specialist",   promoTime=30},
    [7] = {name="Expert Mechanic",          promoTime=43},
    [8] = {name="Executive Mechanic",       promoTime=60},
    [9] = {name="Chief Executive",          promoTime=85},
    [10] = {name="Master Technician",       promoTime=150},
},

["Pilot"] = {
    [0] = {name="Trainee",              promoTime=0},
    [1] = {name="Aviator",              promoTime=0.75},
    [2] = {name="Advanced Aviator",     promoTime=3},
    [3] = {name="Flight Officer",       promoTime=7},
    [4] = {name="First Officer",        promoTime=13},
    [5] = {name="Captain",              promoTime=20},
    [6] = {name="Senior Captain",       promoTime=30},
    [7] = {name="Commercial Captain",   promoTime=43},
    [8] = {name="Commander",            promoTime=60},
    [9] = {name="Senior Commander",     promoTime=85},
    [10] = {name="Veteran",             promoTime=150},
},

--[[["Taxi Driver"] = {
    [0] = {name="Trainee",                  promoTime=0},
    [1] = {name="Student Driver",           promoTime=0.75},
    [2] = {name="Unlicensed Driver",        promoTime=3},
    [3] = {name="Certified Driver",         promoTime=7},
    [4] = {name="Trained Driver",           promoTime=13},
    [5] = {name="Specialist Taxist",        promoTime=20},
    [6] = {name="Senior Specialist Taxist", promoTime=30},
    [7] = {name="Expert Driver",            promoTime=43},
    [8] = {name="Executive Taxist",         promoTime=60},
    [9] = {name="Chief Executive",          promoTime=85},
    [10] = {name="Master Taxist",           promoTime=150},
},]]--

["Train Driver"] = {
    [0] = {name="Student",                   promoTime=0},
    [1] = {name="Assistant Conductor",       promoTime=0.75},
    [2] = {name="Conductor",                 promoTime=3},
    [3] = {name="Locomotive Engineer",       promoTime=7},
    [4] = {name="Sr. Locomotive Engineer",   promoTime=13},
    [5] = {name="Master Train Driver",       promoTime=20},
},

["Trucker"] = {
    [0] = {name="Trucker Trainee",           promoTime=0},
    [1] = {name="Novice Driver",         promoTime=0.80},
    [2] = {name="Experienced Driver",        promoTime=2.50},
},

--[[["Petroleum Engineer"] = {
    [0] = {name="Trainee",                  promoTime=0},
    [1] = {name="Trial Xoomer",             promoTime=10},
    [2] = {name="Junior Xoomer",            promoTime=30},
    [3] = {name="Senior Xoomer",            promoTime=50},
    [4] = {name="Experienced Xoomer",       promoTime=170},
    [5] = {name="Chief of Xoomer",          promoTime=250},
    [6] = {name="Engineer",                 promoTime=350},
},]]--

["Pizza Delivery"] = {
    [0] = {name="Trainee",                   promoTime=0},
    [1] = {name="Junior Pizza Boy",          promoTime=0.75},
    [2] = {name="Trained Pizza Boy",         promoTime=3},
    [3] = {name="Experienced Pizza Boy",     promoTime=7},
    [4] = {name="Senior Pizza Boy",          promoTime=13},
    [5] = {name="Professional Pizza Boy",    promoTime=20},
    [6] = {name="Expert Pizza Boy",          promoTime=30},
    [7] = {name="Executive Pizza Boy",       promoTime=43},
    [8] = {name="Addicted Pizza Boy",        promoTime=60},
    [9] = {name="Chief Pizza Boy",           promoTime=85},
    [10] = {name="God of Pizzas",            promoTime=150},
},

["Trash Collector"] = {
    [0] = {name="Trainee",              promoTime=0},
    [1] = {name="Junior Binman",        promoTime=0.75},
    [2] = {name="Senior Binman",        promoTime=3},
    [3] = {name="Assistant Specialist", promoTime=7},
    [4] = {name="Specialist Binman",    promoTime=13},
    [5] = {name="Professional Binman",  promoTime=20},
    [6] = {name="Expert Binman",        promoTime=30},
    [7] = {name="Chief Binman",         promoTime=43},
    [8] = {name="Executive Binman",     promoTime=60},
    [9] = {name="Trash Master",         promoTime=85},
    [10] = {name="God of Trash",        promoTime=150},
},

["Quarry Miner"] = {
    [0] = {name="Trainee",               promoTime=0},
    [1] = {name="Junior Miner",          promoTime=0.75},
    [2] = {name="Trained Miner",         promoTime=3},
    [3] = {name="Experienced Miner",     promoTime=7},
    [4] = {name="Senior Miner",          promoTime=13},
    [5] = {name="Professional Miner",    promoTime=20},
    [6] = {name="Expert Miner",          promoTime=30},
    [7] = {name="Executive Miner",       promoTime=43},
    [8] = {name="Addicted Miner",        promoTime=60},
    [9] = {name="Chief Miner",           promoTime=85},
    [10] = {name="God of the rock",      promoTime=150},
},

-- Emergency Services Jobs
--------------------------->>

["Paramedic"] = {
    [0] = {name="Trainee",              promoTime=0},
    [1] = {name="Nurse",                promoTime=0.75},
    [2] = {name="Pharmacist",           promoTime=3},
    [3] = {name="Junior Medic",         promoTime=7},
    [4] = {name="Senior Medic",         promoTime=13},
    [5] = {name="Pediatrician",         promoTime=20},
    [6] = {name="Doctor",               promoTime=30},
    [7] = {name="Beginner Surgeon",     promoTime=43},
    [8] = {name="Advanced Surgeon",     promoTime=60},
    [9] = {name="Healing Demigod",      promoTime=85},
    [10] = {name="Walking Jesus",       promoTime=150},
},

["Firefighter"] = {
        [0] = {name="Trainee",                      promoTime=0},
        [1] = {name="Volunteer Firefighter",        promoTime=0.75},
        [2] = {name="Junior Firefighter",           promoTime=3},
        [3] = {name="Experienced Firefighter",      promoTime=7},
        [4] = {name="Senior Firefighter",           promoTime=13},
        [5] = {name="Expert Firefighter",           promoTime=20},
        [6] = {name="Executive Firefighter",        promoTime=30},
        [7] = {name="Professional Firefighter",     promoTime=43},
        [8] = {name="Assistant Chief Firefighter",  promoTime=60},
        [9] = {name="Chief Firefighter",            promoTime=85},
        [10] = {name="God of the fire",             promoTime=150},
},

-- Law Enforcement Jobs
------------------------>>

["Police Officer"] = {
    [0] = {name="Cadet",            promoTime=0,    hours=0},
    [1] = {name="Officer",          promoTime=30,   hours=4},
    [2] = {name="Deputy",           promoTime=70,   hours=10},
    [3] = {name="Inspector",        promoTime=160,  hours=24},
    [4] = {name="Corporal",         promoTime=285,  hours=42},
    [5] = {name="Detective",        promoTime=455,  hours=68},
    [6] = {name="Sergeant",         promoTime=670,  hours=100},
    [7] = {name="Lieutenant",       promoTime=940,  hours=140},
    [8] = {name="Capitan",          promoTime=1275, hours=190},
    [9] = {name="Major",            promoTime=1700, hours=255},
    [10] = {name="Colonel",         promoTime=2250, hours=338},
    [11] = {name="Commander",       promoTime=3000, hours=450},
    [12] = {name="Superintendent",  promoTime=5000, hours=750},
},

--[[["National Guard"] = {
    [0] = {name="Probationary Officer",     promoTime=0},
    [1] = {name="Officer",                  promoTime=17},
    [2] = {name="Corporal",                 promoTime=70},
    [3] = {name="Sergeant",                 promoTime=160},
    [4] = {name="Master Sergeant",          promoTime=285},
    [5] = {name="Sergeant Major",           promoTime=455},
    [6] = {name="Lieutenant",               promoTime=670},
    [7] = {name="Captain",                  promoTime=940},
    [8] = {name="Major",                    promoTime=1275},
    [9] = {name="Colonel",                  promoTime=1700},
    [10] = {name="Commander",               promoTime=2250},
}]]
}

-- Job And Progress Auto-Balance
--------------------------------->>

RankBase = {
--[[
    Example Table:
["Job Name"] =  {hProg=35,  uName="Missions Complete",  basePay=1,  floorProg=true},
},

** Keep Job Names in Alphabetical Order (A-B-C)
** This part of the script automatically creates balanced job progress and payment so you don't have to do the math yourself

** hProg = Progress an average player working this job is expected to make per hour
** uName = Name of the task being done, usually a past tense verb (Looks like example: 999 Fish Caught; uName = "Fish Caught")
** basePay = The pay a person earned per unit of something at Level 0
** floorProg = Optional. Should the progress be an integer? (Only if the way it goes about adding progress has decimals in it)
--]]

        -- Civilian Jobs
    ["Bus Driver"] =        {hProg=172,     uName="Bus Stops",              basePay=173},   --basePay=115},
    ["Farmer"] =            {hProg=1175,    uName="Bails Harvested",        basePay=76.74}, --basePay=51.16},
    --["Fisherman"] =       {hProg=70,      uName="Fish Caught",            basePay=428},   --basePay=285},
    ["Journalist"] =        {hProg=25,      uName="Reports submitted",      basePay=1.5},   --basePay=1},
    ["Quarry Miner"] =      {hProg=34135,   uName="Grams",                  basePay=1.05},  --basePay=0.7},
    ["Lumberjack"] =        {hProg=80,      uName="Trees Cut",              basePay=248},   --basePay=165},
    ["Mail Carrier"] =      {hProg=35,      uName="Packages Delivered",     basePay=0.8235},--basePay=0.5490},
    ["Mariner"] =           {hProg=62.47,   uName="Miles Piloted",          basePay=0.2985},--basePay=0.1990},
    ["Mechanic"] =          {hProg=1175,    uName="Vehicle HP Repaired",    basePay=1.5},   --basePay=1},
    --["Petroleum Engineer"] = {hProg=1175, uName="Liter",                  basePay=1},
    ["Pilot"] =             {hProg=74,      uName="Flight Miles",           basePay=0.2502},--basePay=0.1668},
    ["Pizza Delivery"] =    {hProg=46,      uName="Pizzas Delivered",       basePay=0.7182},--basePay=0.4788},
    --["Taxi Driver"] =         {hProg=62,      uName="Miles Driven",           basePay=0.75},  --basePay=0.5},
    ["Train Driver"] =        {hProg=50,      uName="Stations",               basePay=600},   --basePay=400},
    ["Trash Collector"] =   {hProg=83,      uName="Trash Collected",        basePay=360},   --basePay=241},
    ["Trucker"] =             {hProg=50,      uName="Deliveries",             basePay=0.747}, --basePay=0.498},
        -- Emergency Services Jobs
    ["Paramedic"] =         {hProg=1175,    uName="HP Healed",              basePay=1.5},   --basePay=1},
    ["Firefighter"] =       {hProg=492,     uName="Fires Extinguished",     basePay=60},    --basePay=40},
        -- Law Enforcement Jobs
    ["Police Officer"] =    {hProg=1,       uName="Arrests",                basePay=1.5},   --basePay=1},
    --["National Guard"] =  {hProg=1,       uName="Arrests",                basePay=1},
}

for job,_ in pairs(Ranks) do
    for lvl,tbl in pairs(Ranks[job]) do
        -- Insert Progress
        Ranks[job][lvl].progress = (RankBase[job].hProg)*tbl.promoTime
        Ranks[job][lvl].progress = math.floor(Ranks[job][lvl].progress)
    end
end

function getRanks()
    return Ranks
end

function getRankBase()
    return RankBase
end
