----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 09 Mar 2015
-- Resource: GTIpoliceVehicles/inventory.lua
-- Version: 1.0
----------------------------------------->>

local inventory = {}	-- Cache of Inventory Table

-- Show Vehicle Inventory
--------------------------->>

addEvent("GTIpoliceVehicles.showVehicleInventory", true)
addEventHandler("GTIpoliceVehicles.showVehicleInventory", root, function(vehTable)
	inventory = vehTable
	guiGridListClear(inventoryGUI.gridlist[1])
	for i,v in ipairs(vehTable) do
		local row = guiGridListAddRow(inventoryGUI.gridlist[1])
		if (v.id == "health") then
			guiGridListSetItemText(inventoryGUI.gridlist[1], row, 1, "First Aid Kit", false, false)
			guiGridListSetItemText(inventoryGUI.gridlist[1], row, 2, v.amt.." HP", false, false)
		elseif (v.id == "armor") then
			guiGridListSetItemText(inventoryGUI.gridlist[1], row, 1, "Armor", false, false)
			guiGridListSetItemText(inventoryGUI.gridlist[1], row, 2, v.amt.." AP", false, false)
		else
			guiGridListSetItemText(inventoryGUI.gridlist[1], row, 1, getWeaponNameFromID(v.id), false, false)
			guiGridListSetItemText(inventoryGUI.gridlist[1], row, 2, v.amt, false, false)
		end
	end
	guiSetVisible(inventoryGUI.window[1], true)
	showCursor(true)
end)

-- Close Inventory
------------------->>

addEvent("GTIpoliceVehicles.close", true)
addEventHandler("GTIpoliceVehicles.close", root, function()
	guiSetVisible(inventoryGUI.window[1], false)
	showCursor(false)
end)

addEventHandler("onClientGUIClick", inventoryGUI.label[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerEvent("GTIpoliceVehicles.close", localPlayer)
end, false)

addEventHandler("onClientPlayerVehicleExit", localPlayer, function()
	triggerEvent("GTIpoliceVehicles.close", localPlayer)
end)

addEventHandler("onClientPlayerWasted", localPlayer, function()
	triggerEvent("GTIpoliceVehicles.close", localPlayer)
end)
addEventHandler("onClientRentalVehicleHide", root, function ()
	triggerEvent("GTIpoliceVehicles.close", localPlayer)
end)
addEventHandler("onClientPlayerQuitJob", localPlayer, function ()
	triggerEvent("GTIpoliceVehicles.close", localPlayer)
end)
addEventHandler("onClientMouseEnter", inventoryGUI.label[2], function()
	guiLabelSetColor(source, 255, 25, 25)
end, false)

addEventHandler("onClientMouseLeave", inventoryGUI.label[2], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

-- Take Out Weapon
------------------->>

addEventHandler("onClientGUIClick", inventoryGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local row = guiGridListGetSelectedItem(inventoryGUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item of the list.", 255, 125, 0)
		return
	end
	triggerServerEvent("GTIpoliceVehicles.takeOutWeapon", resourceRoot, row+1)
end, false)
