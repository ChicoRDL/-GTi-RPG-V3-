----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 29 Dec 2014
-- Resource: GTIhousing/vehicles.lua
-- Version: 1.0
----------------------------------------->>

local vehicles = {}	-- Vehicle ID by List Location

-- Get Vehicles
---------------->>

addEvent("GTIhousing.getPlayerVehicles", true)
addEventHandler("GTIhousing.getPlayerVehicles", root, function(vehTable)
	vehicles = {}
	guiSetText(housingGUI.label[22], "Select a Vehicle Below")
	guiSetText(housingGUI.label[24], "")
	guiGridListClear(housingGUI.gridlist[3])
	for k,v in pairs(vehTable) do
		local row = guiGridListAddRow(housingGUI.gridlist[3])
		local vehName = getVehicleNameFromModel(v[1])
		local vehName = k..".) "..vehName
		guiGridListSetItemText(housingGUI.gridlist[3], row, 1, vehName, false, false)
		
		local vehHealth = math.floor(v[2]/10).."%"
		guiGridListSetItemText(housingGUI.gridlist[3], row, 2, vehHealth, false, false)
		
		local r = 255 - ((math.floor(v[2]/10) - 30) * 3.64)
		local g = (math.floor(v[2]/10) - 30) * 3.64
		if (r > 255) then r = 255 end	if (r < 0) then r = 0 end
		if (g > 255) then g = 255 end	if (g < 0) then g = 0 end
		guiGridListSetItemColor(housingGUI.gridlist[3], row, 2, r, g, 0)

		--[[if (v[3]) then	-- Paint Active Cars Blue
			guiGridListSetItemColor(housingGUI.gridlist[3], row, 1, 15, 142, 242)
		end--]]
		vehicles[row] = k
	end
end)

-- Update Vehicle Info
----------------------->>

addEventHandler("onClientGUIClick", housingGUI.gridlist[3], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local row = guiGridListGetSelectedItem(source)
	if (not row or row == -1) then return end
	triggerServerEvent("GTIhousing.updateVehicleInfo", resourceRoot, vehicles[row])
end, false)

addEvent("GTIhousing.updateVehicleInfo", true)
addEventHandler("GTIhousing.updateVehicleInfo", root, function(vehInfo)
	guiSetText(housingGUI.label[22], vehInfo["name"])
	guiSetText(housingGUI.label[24], vehInfo["zone"])
end)

-- Spawn Vehicle
----------------->>

addEventHandler("onClientGUIClick", housingGUI.button[50], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local row = guiGridListGetSelectedItem(housingGUI.gridlist[3])
	if (not row or row == -1) then 
		exports.GTIhud:dm("Select a vehicle that you want to spawn", 255, 125, 0)
	return end
	
	guiSetEnabled(housingGUI.button[50], false)
	setTimer(guiSetEnabled, 500, 1, housingGUI.button[50], true)
	
	triggerServerEvent("GTIhousing.spawnVehicle", resourceRoot, vehicles[row], getHouseID())
end, false)
