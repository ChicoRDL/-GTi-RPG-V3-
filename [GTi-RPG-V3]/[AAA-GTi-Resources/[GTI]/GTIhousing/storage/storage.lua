----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 25 Dec 2014
-- Resource: GTIhousing/storage.lua
-- Version: 1.0
----------------------------------------->>

local plrInvCache	-- Cache of Player Inventory
local houseInvCache	-- Cache of House Inventory

-- Render Inventory
-------------------->>

addEvent("GTIhousing.getHouseStorage", true)
addEventHandler("GTIhousing.getHouseStorage", root, function(plrInv, houseInv)
	-- Player Inventory
	guiGridListClear(housingGUI.gridlist[1])
	for i,v in ipairs(plrInv) do
		local row = guiGridListAddRow(housingGUI.gridlist[1])
		guiGridListSetItemText(housingGUI.gridlist[1], row, 1, getWeaponNameFromID(v[1]), false, false)
		guiGridListSetItemText(housingGUI.gridlist[1], row, 2, v[2], false, false)
	end
	plrInvCache = plrInv
	
	-- House Inventory
	guiGridListClear(housingGUI.gridlist[2])
	for i,v in ipairs(houseInv) do
		local row = guiGridListAddRow(housingGUI.gridlist[2])
		guiGridListSetItemText(housingGUI.gridlist[2], row, 1, getWeaponNameFromID(v[1]), false, false)
		guiGridListSetItemText(housingGUI.gridlist[2], row, 2, v[2], false, false)
	end
	houseInvCache = houseInv
end)

-- Transfer Between
-------------------->>

addEventHandler("onClientGUIClick", housingGUI.button[5], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(housingGUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item off of your personal inventory to transfer to your house storage", 255, 125, 0)
		return
	end
	
	local toTransfer = plrInvCache[row+1][1]
	local amount = tonumber(guiGetText(housingGUI.edit[1])) or 0
	
	--Make sure we don't have no decimals or negative numbers in this
	amount = math.floor(amount)
	if (amount <= 0) then
		exports.GTIhud:dm("The amount must be 1 or higher.",255,125,0)
		return
	end
	
	triggerServerEvent("GTIhousing.transferToHouse", resourceRoot, getHouseID(), toTransfer, amount)
	
	guiSetEnabled(housingGUI.button[5], false)
	setTimer(guiSetEnabled, 3000, 1, housingGUI.button[5], true)
end, false)

addEventHandler("onClientGUIClick", housingGUI.button[4], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(housingGUI.gridlist[2])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item off of your house storage to transfer to your personal inventory", 255, 125, 0)
		return
	end
	
	local toTransfer = houseInvCache[row+1][1]
	local amount = tonumber(guiGetText(housingGUI.edit[1])) or 0
	
	if (amount <= 0) then
		exports.GTIhud:dm("The amount must be 1 or higher.",255,125,0)
		return
	end
	
	triggerServerEvent("GTIhousing.transferToPlayer", resourceRoot, getHouseID(), toTransfer, amount)
	
	guiSetEnabled(housingGUI.button[5], false)
	setTimer(guiSetEnabled, 3000, 1, housingGUI.button[5], true)
end, false)
