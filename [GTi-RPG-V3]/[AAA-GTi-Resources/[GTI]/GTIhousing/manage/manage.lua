----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 24 Dec 2014
-- Resource: GTIhousing/manage.lua
-- Version: 1.0
----------------------------------------->>

-- Toggle Manage Function
-------------------------->>

addEventHandler("onClientGUIClick", housingGUI.scrollpane[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	if (source == housingGUI.button[6]) then
		triggerServerEvent("GTIhousing.toggleLockState", resourceRoot, getHouseID())
		guiSetEnabled(housingGUI.button[6], false)
		setTimer(guiSetEnabled, 1000, 1, housingGUI.button[6], true)
	return end
	
	if (source == housingGUI.button[7]) then
		guiSetText(transferGUI.button[1], "Transfer (1)")
		guiBringToFront(transferGUI.window[1])
		guiSetVisible(transferGUI.window[1], true)
	return end
end)

-- Update Lock State
--------------------->>

addEvent("GTIhousing.updateLockState", true)
addEventHandler("GTIhousing.updateLockState", root, function(locked)
	if (locked) then
		guiSetText(housingGUI.button[6], "Unlock House")
		guiSetText(housingGUI.label[20], "This house is locked. Unlock?")
	else
		guiSetText(housingGUI.button[6], "Lock House")
		guiSetText(housingGUI.label[20], "This house is unlocked. Lock?")
	end
end)

-- Transfer House
------------------>>

addEventHandler("onClientGUIClick", transferGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(transferGUI.window[1], false)
end, false)

function openTransferHousePanel(button, state, cont)
	if (button ~= "left" or state ~= "up") then return end
	
	local account = guiGetText(transferGUI.edit[1])
	local password = guiGetText(transferGUI.edit[2])
	if (#account == 0) then
		exports.GTIhud:dm("Enter the account name of the person you want to transfer this house to.", client, 255, 125, 0)
		return
	end
	if (#password == 0) then
		exports.GTIhud:dm("Enter your account password.", client, 255, 125, 0)
		return
	end
	
	if (guiGetText(transferGUI.button[1]) == "Transfer (1)") then
		guiSetText(transferGUI.button[1], "Transfer")
	else
		-- Show Storage Warning
		if (guiGridListGetRowCount(housingGUI.gridlist[2]) > 0 and cont ~= true) then
			showStorageWarning2()
			return
		end
	
		triggerServerEvent("GTIhousing.transferHouse", resourceRoot, getHouseID(), account, password)
	end
end
addEventHandler("onClientGUIClick", transferGUI.button[1], openTransferHousePanel, false)

-- Storage Warning
------------------->>

function showStorageWarning2()
	guiBringToFront(storwarn2GUI.window[1])
	guiSetVisible(storwarn2GUI.window[1], true)
end

addEventHandler("onClientGUIClick", storwarn2GUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	openTransferHousePanel("left", "up", true)
end, false)

addEventHandler("onClientGUIClick", storwarn2GUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(storwarn2GUI.window[1], false)
end, false)
