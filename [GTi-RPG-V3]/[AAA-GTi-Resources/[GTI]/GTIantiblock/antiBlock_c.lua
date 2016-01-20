----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: antiBlock_c.lua
-- Version: 1.0
----------------------------------------->>

local colshapesI = {}

local locations = {
{1364.559, -1262.983, 13.047},
{1365.191, -1316.641, 13.039},
{1335.629, -1304.558, 13.047},
{1335.419, -1259.687, 13.047},
{1315.248, -1288.231, 13.047},
{1325.683, -1272.976, 13.047},
}

local locations1 = {
{2420.947, -1966.021, 13.547},
{2407.278, -1956.674, 13.547},
{2406.173, -1985.583, 13.547},
{2419.682, -1993.352, 13.547},
{2373.212, -1979.500, 13.547},
}

local locations2 = {
{592.818, -1242.709, 17.989},
{544.907, -1269.001, 17.248},
{545.151, -1231.761, 17.029},
{529.626, -1241.498, 16.589},
{544.745, -1259.080, 16.769},
{569.119, -1220.842, 17.613},
}

local locations3 = {
{2094.403, -1797.878, 13.383},
{2095.271, -1795.750, 13.389},
{2093.760, -1803.415, 13.550},
{2092.984, -1806.594, 13.549},
{2092.040, -1809.629, 13.548},
{2091.183, -1812.384, 13.390},
}

local locations4 = {
{1541.002, -1662.984, 14.552},
{1522.081, -1661.989, 14.539},
{1521.977, -1678.821, 14.547},
{1537.285, -1688.068, 14.547},
{1535.934, -1674.646, 14.383},
}

-- col, table
local colshapes = {
{createColCuboid ( 1365.597, -1281.451, 12.547, 3.0, 3.0, 3.0), locations},
{createColCuboid ( 2389.226, -1981.928, 12.547, 3.0, 3.0, 3.0), locations1},
{createColCuboid ( 553.029, -1274.697, 16.248, 3.0, 3.0, 3.0), locations2},
{createColCuboid ( 2103.795, -1807.351, 12.555, 3.0, 3.0, 3.0), locations3},
{createColCuboid ( 1550.179, -1677.625, 15.195, 6.0, 4.0, 5.0), locations4},
}

function antiBlockSys ( theElem )
	if (getElementType(theElem) == "vehicle") then
		local player = getVehicleController(theElem)
		if player and ( player == localPlayer ) then
			for k,v in ipairs(colshapes) do
				if v[1] == source then 
					local Table = v[2]
					local veh = getPedOccupiedVehicle ( player )
					local markerTableData = Table[math.random ( #Table )]
					local x = markerTableData[1]
					local y = markerTableData[2]
					local z = markerTableData[3]
					setPedCanBeKnockedOffBike ( localPlayer, false )
					setElementPosition ( veh, x, y, z )
					toggleControl ( "enter_exit", false )
					setTimer ( unfreezeVeh, 3000, 1 )
					break
				end
			end
		elseif not player then
			for k,v in ipairs(colshapes) do
				if v[1] == source then 
					local Table = v[2]
					local markerTableData = Table[math.random ( #Table )]
					local x = markerTableData[1]
					local y = markerTableData[2]
					local z = markerTableData[3]
					setElementPosition ( theElem, x, y, z )
				end
			end
		end
	end
end
function unfreezeVeh()   
    setTimer ( setAlphaBackToNormal, 3000, 1 )    
end

function setAlphaBackToNormal()
    toggleControl ( "enter_exit", true )
    setPedCanBeKnockedOffBike ( localPlayer, true )
end

for k,v in ipairs(colshapes) do
	addEventHandler ("onClientColShapeHit", v[1], antiBlockSys )
end