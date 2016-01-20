----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 26 Sept 2014
-- Resource: GTIbank/security.lua
-- Version: 1.0
----------------------------------------->>

-- View Advanced Options
------------------------->>

addEventHandler("onClientGUIClick", bankGUI.button[4], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiBringToFront(securityGUI.window[1])
	guiSetVisible(securityGUI.window[1], true)
	triggerServerEvent("GTIbank.updateAdvancedOptions", resourceRoot)
end, false)

addEvent("GTIbank.updateAdvancedOptions", true)
addEventHandler("GTIbank.updateAdvancedOptions", root, function(pin)
	if (pin) then
		guiCheckBoxSetSelected(securityGUI.checkbox[1], true)
		guiSetText(securityGUI.edit[1], pin)
	else
		guiCheckBoxSetSelected(securityGUI.checkbox[1], false)
		guiSetText(securityGUI.edit[1], "")
	end
end)

addEventHandler("onClientGUIClick", securityGUI.label[5], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(securityGUI.window[1], false)
end, false)

addEvent("GTIbank.closeAdvancedOptions", true)
addEventHandler("GTIbank.closeAdvancedOptions", root, function()
	guiSetVisible(securityGUI.window[1], false)
end)

addEventHandler("onClientMouseEnter", securityGUI.label[5], function()
	guiLabelSetColor(source, 25, 255, 25)
end, false)

addEventHandler("onClientMouseLeave", securityGUI.label[5], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

-- Update Security Preference
------------------------------>>

addEventHandler("onClientGUIClick", securityGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local secure = guiCheckBoxGetSelected(securityGUI.checkbox[1])
	local pin = guiGetText(securityGUI.edit[1])
	if (secure and #pin == 0) then
		exports.GTIhud:dm("Error: You selected the \"Secure Account\" option. Enter a PIN number to secure your account", 255, 125, 25)
		return
	end
	if (not secure and #pin > 0) then
		exports.GTIhud:dm("Error: You entered a PIN in the box. You must select the \"Secure Account\" option to secure your account", 255, 125, 25)
		return
	end
	triggerServerEvent("GTIbank.updateAccountSecurity", resourceRoot, secure, pin)
	guiSetVisible(securityGUI.window[1], false)
end, false)
