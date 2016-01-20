categories = {
"Jobs",
"CnR Events",
"Misc",
"House"
}
--{"Category","city", "Name", x, y, z},

locations = {
{"Jobs","Las Venturas", "Police Department",2289.325, 2423.339, 9.820},
{"Jobs","Las Venturas", "Pilot",1315.448, 1609.874, 9.820},
{"Jobs","Las Venturas", "Mail Carrier",1047.483, 2141.618, 9.820},
{"Jobs","Las Venturas", "Train Driver",1435.157, 2671.665, 9.672},
{"Jobs","Las Venturas", "Mechanic",2150.453, 1421.520, 9.820},
{"Jobs","Las Venturas", "Medic",1621.164, 1829.330, 9.820},
{"CnR Events","Las Venturas","Caligula's Casino Robbery",2194.650, 1678.431, 11.367},
 
{"Jobs","San Fierro", "Police Department",-1611.489, 719.663, 12.048},
{"Jobs","San Fierro", "Pilot",-1233.540, 18.750, 13.148},
{"Jobs","San Fierro", "Mail Carrier",-1848.445, 109.718, 14.117},
{"Jobs","San Fierro", "Mechanic",-2031.095, 178.254, 27.841},
{"Jobs","San Fierro", "Pizza Delivery",-1725.540, 1353.340, 6.188},
{"Jobs","San Fierro", "Train Driver",-1985.738, 126.089, 26.688},
{"Jobs","San Fierro", "Medic",-2642.360, 605.351, 13.453},
{"Jobs","San Fierro", "Firefighter",-2020.486, 75.083, 27.025},
{"Jobs","San Fierro","Trucker",-506.854, -497.248, 24.523},
{"Jobs","San Fierro","Farmer",-1051.156, -1217.859, 127.805},
{"Jobs","San Fierro", "Mariner",-1554.570, 1273.050, 6.177},
{"CnR Events","San Fierro", "Bank Heist",-2244.690, 2326.192, 3.969},

 
{"Jobs","Los Santos", "Pilot",1706.666, -2537.244, 12.569},
{"Jobs","Los Santos", "Police Department",1536.592, -1667.830, 12.383},
{"Jobs","Los Santos", "Mail Carrier",2292.147, -2387.014, 12.547},
{"Jobs","Los Santos", "Train Driver",1697.958, -1937.302, 12.556},
{"Jobs","Los Santos", "Mechanic",1042.982, -1032.808, 30.998},
{"Jobs","Los Santos", "Jeferson Medic",2002.325, -1444.662, 12.562},
{"Jobs","Los Santos", "All Saints Medic",1190.946, -1313.546, 12.398},
{"Jobs","Los Santos", "Journalist",641.520, -1354.017, 12.383},
{"Jobs","Los Santos", "Trash collector",-72.824, -1118.351, 0.078},
{"Jobs","Los Santos", "Bus Driver",1777.945, -1894.429, 12.388},
{"Jobs","Los Santos", "Pizza Delivery",2096.287, -1800.187, 12.383},
{"Jobs","Los Santos","Coastguard",2739.357, -2559.360, 12.756},
{"Jobs","Los Santos","Mariner",2618.533, -2447.860, 12.629},
{"Jobs","Los Santos","Fisherman",121.870, -1913.087, 2.125},
{"CnR Events","Los Santos","LSPR",1520.714, -1448.799, 12.539},
 
{"Jobs","Angel Pine","Lumberjack",-1966.806, -2441.754, 29.625},
{"Jobs","Hunter Quarry","Quarry Miner",322.693, 853.780, 19.406},
}

misc = {
"ATMs",
"Blackjack Casino",
}

function getCats()
for i,v in ipairs(categories) do
setCat(v)
end
end

function getLocs(cat)
	if cat == "Misc" then
		for i,v in ipairs(misc) do
			setLoc("",v)
		end
		return
	elseif cat == "House" then
		triggerServerEvent("GTIMapsApp.getHouses",resourceRoot)
		return
	end
	for i,v in ipairs(locations) do
		if v[1] == cat then
			setLoc(v[2],v[3])
		end
	end
end

function getPos(locName,city,mark)
	if locName == "ATMs" and mark then
		return triggerServerEvent("GTImapsApp.markATMs", localPlayer, localPlayer)
	elseif type(city) == "table" then
		return city[1],city[2],city[3]
	elseif locName == "Blackjack Casino" then
		return 2019.49, 1007.11, 9.82133
	end
	for i,v in ipairs(locations) do
		if v[2] == city and v[3] == locName then
			return v[4], v[5], v[6]
		end
	end
end

function isitacategory(cat)
	for i,v in ipairs(categories) do
		if v == cat then
			return true
		end
	end
end
