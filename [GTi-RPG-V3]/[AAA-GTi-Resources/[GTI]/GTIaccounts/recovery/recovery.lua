----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 28 Aug 2014
-- Resource: GTIaccounts/recovery.lua
-- Version: 2.0
----------------------------------------->>

-- Toggle Recovery Panel
------------------------->>

addEventHandler("onClientGUIClick", login.button[4], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	loginScreen.hide()
	guiSetVisible(recoveryGUI.window[1], true)
end, false)

addEventHandler("onClientGUIClick", recoveryGUI.button[2], function(button, state)
	loginScreen.show()
	guiSetVisible(recoveryGUI.window[1], false)
end, false)

-- Attempt Recovery
-------------------->>

addEventHandler("onClientGUIClick", recoveryGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local username = guiGetText(recoveryGUI.edit[1])
	if (username == "") then
		outputRecoveryNote("Enter a Username", 255, 125, 0)
		return
	end
	
	local email = guiGetText(recoveryGUI.edit[2])
	if (email == "") then
		outputRecoveryNote("Enter the email associated with the account", 255, 125, 0)
		return
	end
	if (not string.find(email, "@") or not string.find(email, ".")) then
		outputRecoveryNote("Error: Invalid Email Entered", 255, 25, 25)
		return
	end
	triggerServerEvent("GTIaccounts.attemptRecovery", resourceRoot, username, email)	
end, false)

function outputRecoveryNote(text, r, g, b)
	guiSetText(recoveryGUI.label[3], text)
	guiLabelSetColor(recoveryGUI.label[3], r, g, b)
end
addEvent("GTIaccounts.outputRecoveryNote", true)
addEventHandler("GTIaccounts.outputRecoveryNote", root, outputRecoveryNote)

-- Recover Account
------------------->>

addEvent("GTIaccounts.recoverAccount", true)
addEventHandler("GTIaccounts.recoverAccount", root, function()
	guiSetVisible(recoveryGUI.window[1], false)
	guiSetVisible(accRecoveryGUI.window[1], true)
end)

function renderRecoveryDisplays(edit)
	-- Recovery Code
	if (edit == accRecoveryGUI.edit[1]) then
		local code = guiGetText(accRecoveryGUI.edit[1])
		if (#code == 0) then
			guiSetText(accRecoveryGUI.label[2], "Enter Recovery Code")
			guiLabelSetColor(accRecoveryGUI.label[2], 255, 255, 255)
		elseif (#code ~= 32) then
			guiSetText(accRecoveryGUI.label[2], "Recovery Code must be 32 characters long")
			guiLabelSetColor(accRecoveryGUI.label[2], 255, 25, 25)
		else
			guiSetText(accRecoveryGUI.label[2], "Recovery Code Entered")
			guiLabelSetColor(accRecoveryGUI.label[2], 25, 255, 25)
		end
	end

	-- Password
	if (edit == accRecoveryGUI.edit[2]) then
		local password = guiGetText(accRecoveryGUI.edit[2])
		if (#password == 0) then
			guiSetText(accRecoveryGUI.label[5], "Enter a Password")
			guiLabelSetColor(accRecoveryGUI.label[5], 255, 255, 255)
		elseif (#password < 8 or #password > 30) then
			guiSetText(accRecoveryGUI.label[5], "Password Must be 8-30 Characters Long")
			guiLabelSetColor(accRecoveryGUI.label[5], 255, 125, 25)
		elseif (string.find(password, "%s")) then
			guiSetText(accRecoveryGUI.label[5], "Your password cannot contain a space!")
			guiLabelSetColor(accRecoveryGUI.label[5], 255, 125, 25)
		else
			local strength = getPasswordStrength(password)
			local r,g,b = 255, 255, 255
			if (strength == "Weak") then r,g,b = 255, 25, 25
			elseif (strength == "Medium") then r,g,b = 255, 125, 25
			elseif (strength == "Strong") then r,g,b = 25, 255, 25
			end
			guiSetText(accRecoveryGUI.label[5], "Password Strength:\n"..strength)
			guiLabelSetColor(accRecoveryGUI.label[5], r, g, b)
		end
	end

	-- Confirm Password
	if (edit == accRecoveryGUI.edit[3]) then
		local password = guiGetText(accRecoveryGUI.edit[3])
		if (#password == 0) then
			guiSetText(accRecoveryGUI.label[6], "Reenter Password")
			guiLabelSetColor(accRecoveryGUI.label[6], 255, 255, 255)
		elseif (password ~= guiGetText(accRecoveryGUI.edit[2])) then
			guiSetText(accRecoveryGUI.label[6], "Passwords do not match!")
			guiLabelSetColor(accRecoveryGUI.label[6], 255, 25, 25)
		else
			guiSetText(accRecoveryGUI.label[6], "Passwords match")
			guiLabelSetColor(accRecoveryGUI.label[6], 25, 255, 25)
		end
	end
end
addEventHandler("onClientGUIChanged", resourceRoot, renderRecoveryDisplays)

addEventHandler("onClientGUIClick", accRecoveryGUI.button[1], function(button, state)
	local code = guiGetText(accRecoveryGUI.edit[1])
	local password = guiGetText(accRecoveryGUI.edit[2])
	local password2 = guiGetText(accRecoveryGUI.edit[3])
	triggerServerEvent("GTIaccounts.recoverAccount", resourceRoot, code, password, password2)
end, false)

addEventHandler("onClientGUIClick", accRecoveryGUI.button[2], function(button, state)
	loginScreen.show()
	guiSetVisible(accRecoveryGUI.window[1], false)
end, false)

addEvent("GTIaccounts.endAccountRecovery", true)
addEventHandler("GTIaccounts.endAccountRecovery", root, function()
	guiSetVisible(accRecoveryGUI.window[1], false)
	loginScreen.show()
end)