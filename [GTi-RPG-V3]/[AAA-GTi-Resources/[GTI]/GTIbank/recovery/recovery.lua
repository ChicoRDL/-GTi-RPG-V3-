----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 26 Sep 2014
-- Resource: GTIbank/recovery.lua
-- Version: 1.0
----------------------------------------->>

-- Toggle Recovery Panel
------------------------->>

addEventHandler("onClientGUIClick", bankPINGUI.label[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(bankPINGUI.window[1], false)
	guiSetVisible(recoveryGUI.window[1], true)
end, false)

addEventHandler("onClientMouseEnter", bankPINGUI.label[2], function()
	guiLabelSetColor(source, 25, 255, 25)
end, false)

addEventHandler("onClientMouseLeave", bankPINGUI.label[2], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

addEventHandler("onClientGUIClick", recoveryGUI.button[2], function(button, state)
	if (not guiGetVisible(recoveryGUI.window[1])) then return end
	guiSetVisible(bankPINGUI.window[1], true)
	guiSetVisible(recoveryGUI.window[1], false)
end, false)

-- Attempt Recovery
-------------------->>

addEventHandler("onClientGUIClick", recoveryGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local email = guiGetText(recoveryGUI.edit[1])
	if (email == "") then
		exports.GTIhud:dm("Enter the email associated with the account", 255, 125, 0)
		return
	end
	if (not string.find(email, "@") or not string.find(email, ".")) then
		exports.GTIhud:dm("Error: Invalid Email Entered", 255, 25, 25)
		return
	end
	triggerServerEvent("GTIbank.attemptRecovery", resourceRoot, email)	
end, false)

-- Recover Account
------------------->>

addEvent("GTIbank.recoverPIN", true)
addEventHandler("GTIbank.recoverPIN", root, function()
	guiSetVisible(recoveryGUI.window[1], false)
	guiSetVisible(pinRecoveryGUI.window[1], true)
end)

addEventHandler("onClientGUIClick", pinRecoveryGUI.button[1], function(button, state)
	local code = guiGetText(pinRecoveryGUI.edit[1])
	local pin = guiGetText(pinRecoveryGUI.edit[2])
	local pin2 = guiGetText(pinRecoveryGUI.edit[3])
	if (#code == 0 or #pin == 0 or #pin2 == 0) then
		exports.GTIhud:dm("Some fields were left blank. Make sure all boxes have been filled out.", 255, 125, 25)
		return
	end
	if (pin ~= pin2) then
		exports.GTIhud:dm("Error: The PINs do not match!", 255, 25, 25)
		return
	end
	triggerServerEvent("GTIbank.recoverPIN", resourceRoot, code, pin)
end, false)

addEventHandler("onClientGUIClick", pinRecoveryGUI.button[2], function(button, state)
	guiSetVisible(bankPINGUI.window[1], true)
	guiSetVisible(pinRecoveryGUI.window[1], false)
end, false)

addEvent("GTIbank.endPINRecovery", true)
addEventHandler("GTIbank.endPINRecovery", root, function()
	guiSetVisible(pinRecoveryGUI.window[1], false)
	guiSetVisible(bankPINGUI.window[1], true)
end)