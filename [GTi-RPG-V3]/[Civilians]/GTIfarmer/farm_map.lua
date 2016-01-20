----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Ministry of Architecture
-- Date: 18 Dec 2014
-- Original Map File: GTI-Farms-LilDolla.map
----------------------------------------->>

if (getElementData(root, "mapSecurity") ~= "G32MdAZtHJ9Ajmm9GkuvtFQh") then return end

local INTERIOR = 0
local DIMENSION = 0

local mapObjects = {
}

-- Set Interior/Dimension
-------------------------->>

for i,object in ipairs(mapObjects) do
	setElementInterior(object, INTERIOR)
	setElementDimension(object, DIMENSION)
end

-- Remove World Objects
------------------------>>

removeWorldModel(3374, 5.2016, -1174.9701, -1169.1846, 130.1822)
removeWorldModel(3374, 5.2016, -1182.2372, -1169.1248, 129.5267)
removeWorldModel(3374, 5.2016, -1189.5568, -1169.5627, 129.5791)
removeWorldModel(3374, 5.2016, -1196.8651, -1169.9685, 129.4892)
removeWorldModel(3374, 5.2016, -1204.1321, -1169.9074, 130.0264)
removeWorldModel(1454, 3.3349, -1164.7813, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1161.2578, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1157.7344, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1154.2031, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1150.6797, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1147.1563, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1143.6328, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1140.1094, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1136.5859, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1133.0625, -1156.7969, 129.0156)
removeWorldModel(1454, 3.3349, -1129.5391, -1156.7969, 129.0156)
removeWorldModel(708, 25.6361, -1084.1641, -1217.5547, 128.4453)
removeWorldModel(691, 15.7245, -1073.8047, -1234.7578, 128.0781)
removeWorldModel(3276, 8.2899, -1088.2966, -1236.2693, 129.1665)
removeWorldModel(3276, 8.2899, -1088.2966, -1247.821, 129.4392)
removeWorldModel(3276, 8.2899, -1080.464, -1255.3279, 129.3685)
removeWorldModel(3276, 8.2899, -1073.906, -1255.3513, 129.1646)
removeWorldModel(3276, 8.2899, -1064.8279, -1261.2031, 129.4744)
removeWorldModel(3276, 8.2899, -1064.8513, -1276.7199, 129.384)
removeWorldModel(3276, 8.2899, -1109.2786, -1255.4813, 128.8344)
removeWorldModel(3276, 8.2899, -1088.2966, -1217.3707, 129.2968)
removeWorldModel(3276, 8.2899, -1088.2966, -1205.1318, 129.627)
removeWorldModel(3276, 8.2899, -1088.2966, -1191.589, 129.4096)
removeWorldModel(3276, 8.2899, -1088.2966, -1183.8452, 129.5861)
removeWorldModel(3276, 8.2899, -1088.5282, -1172.6075, 129.5303)
removeWorldModel(3276, 8.2899, -1088.5282, -1154.6663, 129.4986)