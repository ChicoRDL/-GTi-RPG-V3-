----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 30 Nov 2013
-- Resource: GTIaccounts/login.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

guiSetInputMode("no_binds_when_editing")

local logo				-- GUI Logo Image
local encryptedPass		-- Password from Client (Encrypted)
local isEncrypted		-- Is Password Encrypted? (For login)
local isLoggedIn=true	-- Is Player Logged In?

-- Login Panel
--------------->>

function startShowingLoginPanel()
	if (isTransferBoxActive()) then	
		setTimer(startShowingLoginPanel, 1000, 1)
	return end
	triggerServerEvent("GTIaccounts.showLoginPanelServer", resourceRoot)
end
addEventHandler("onClientResourceStart", resourceRoot, startShowingLoginPanel)

function showLoginPanel()
	isLoggedIn = false
	local sX,sY = guiGetScreenSize()
	local gX,gY = 231,76
	logo = guiCreateStaticImage(sX-gX-5, 5, gX, gY, "images/logo.png", false)
	startTransitions()
	
	local username, password = getLoginInfo()
	if (username and password) then
		guiSetText(login.edit[1], username)
		guiSetText(login.edit[2], password)
		guiCheckBoxSetSelected(login.checkbox[1], true)
	end
	
	encryptedPass = password

	guiSetVisible(login.window[1], true)
	showCursor(true)
end
addEvent("GTIaccounts.showLoginPanel", true)
addEventHandler("GTIaccounts.showLoginPanel", root, showLoginPanel)

-- Is Logged In?
----------------->>

function isPlayerLoggedIn()
	return isLoggedIn
end

-- Login Player
---------------->>

function loginPlayer(button, state)
	if (button ~= "left" or state ~= "up") then return end

	local username = guiGetText(login.edit[1])
	local password = guiGetText(login.edit[2])
	if (username == "" or password == "") then
		outputLoginMessage("Notice: Please enter a username and password", 255, 125, 0)
		return
	end

	local rememberMe = guiCheckBoxGetSelected(login.checkbox[1])
	if (encryptedPass == password) then
		isEncrypted = true
	else
		isEncrypted = false
	end
	
	guiSetEnabled(login.button[2], false)
	triggerServerEvent("GTIaccounts.loginPlayer", resourceRoot, username, password, rememberMe, isEncrypted)
end
addEventHandler("onClientGUIClick", login.button[2], loginPlayer, false)

addEventHandler("onClientGUIAccepted", resourceRoot, function(edit)
	if (edit == login.edit[1] or edit == login.edit[2]) then
		loginPlayer("left", "up")
	end
end)

function outputLoginMessage(message, r, g, b)
	guiSetEnabled(login.button[2], true)
	guiSetText(login.label[3], message)
	guiLabelSetColor(login.label[3], r, g, b)
end
addEvent("GTIaccounts.outputLoginMessage", true)
addEventHandler("GTIaccounts.outputLoginMessage", root, outputLoginMessage)

function confirmLogin(username, password)
	guiSetVisible(login.window[1], false)
	
	if (password) then
		storeLoginInfo(username, password)
	else
		deleteLoginInfo()
	end
	destroyElement(logo)
	logo = nil
	if (not isSelectingSpawn) then
		showCursor(false)
		stopTransitions()
		setCameraTarget(localPlayer)
	end
	isLoggedIn = true
end
addEvent("GTIaccounts.confirmLogin", true)
addEventHandler("GTIaccounts.confirmLogin", root, confirmLogin)

-- Register Panel
------------------>>

function showRegisterPanel(button, state)
	if (button ~= "left" or state ~= "up") then return end

	guiSetVisible(login.window[1], false)
	guiSetVisible(register.window[1], true)
end
addEventHandler("onClientGUIClick", login.button[1], showRegisterPanel, false)

function renderRegisterDisplays(edit)
	-- Username
	if (edit == register.edit[1]) then
		local username = guiGetText(register.edit[1])
		if (#username == 0) then
			guiSetText(register.label[2], "Enter a Username")
			guiLabelSetColor(register.label[2], 255, 255, 255)
		elseif (#username < 4 or #username > 32) then
			guiSetText(register.label[2], "Username Must be 4-32 Characters Long")
			guiLabelSetColor(register.label[2], 255, 125, 25)
		elseif (string.gsub(username, "%W", "") ~= username) then
			guiSetText(register.label[2], "Username can only contain letters & numbers")
			guiLabelSetColor(register.label[2], 255, 125, 25)
		else
			guiSetText(register.label[2], "Checking Validity...")
			guiLabelSetColor(register.label[2], 255, 255, 25)
		end
	end

	-- E-mail Address
	if (edit == register.edit[2]) then
		local email = guiGetText(register.edit[2])
		if (#email == 0) then
			guiSetText(register.label[4], "E-mail Not Provided")
			guiLabelSetColor(register.label[4], 255, 255, 25)
		elseif (not string.find(email, "@") or not string.find(email, "%.")) then
			guiSetText(register.label[4], "This e-mail address is invalid!")
			guiLabelSetColor(register.label[4], 255, 25, 25)
		else
			guiSetText(register.label[4], "E-mail Looks Valid")
			guiLabelSetColor(register.label[4], 25, 255, 25)
		end
	end

	-- Password
	if (edit == register.edit[3]) then
		local password = guiGetText(register.edit[3])
		if (#password == 0) then
			guiSetText(register.label[8], "Enter a Password")
			guiLabelSetColor(register.label[8], 255, 255, 255)
		elseif (#password < 8 or #password > 30) then
			guiSetText(register.label[8], "Password Must be 8-30 Characters Long")
			guiLabelSetColor(register.label[8], 255, 125, 25)
		elseif (string.find(password, "%s")) then
			guiSetText(register.label[8], "Your password cannot contain a space!")
			guiLabelSetColor(register.label[8], 255, 125, 25)
		else
			local strength = getPasswordStrength(password)
			local r,g,b = 255, 255, 255
			if (strength == "Weak") then r,g,b = 255, 25, 25
			elseif (strength == "Medium") then r,g,b = 255, 125, 25
			elseif (strength == "Strong") then r,g,b = 25, 255, 25
			end
			guiSetText(register.label[8], "Password Strength:\n"..strength)
			guiLabelSetColor(register.label[8], r, g, b)
		end
	end

	-- Confirm Password
	if (edit == register.edit[4]) then
		local password = guiGetText(register.edit[4])
		if (#password == 0) then
			guiSetText(register.label[9], "Reenter Password")
			guiLabelSetColor(register.label[9], 255, 255, 255)
		elseif (password ~= guiGetText(register.edit[3])) then
			guiSetText(register.label[9], "Passwords do not match!")
			guiLabelSetColor(register.label[9], 255, 25, 25)
		else
			guiSetText(register.label[9], "Passwords match")
			guiLabelSetColor(register.label[9], 25, 255, 25)
		end
	end

	-- Register Button Toggle
	local uR, uG, uB = guiLabelGetColor(register.label[2])
	local eR, eG, eB = guiLabelGetColor(register.label[4])
	local pR, pG, pB = guiLabelGetColor(register.label[8])
	local cR, cG, cB = guiLabelGetColor(register.label[9])
	if ((uR == 25 and uG == 255 and uB == 25) and (pB ~= 26 and pB ~= 255) and
		((eR == 25 and eG == 255 and eB == 25) or (eR == 255 and eG == 255 and eB == 25)) and
		(cR == 25 and cG == 255 and cB == 25)) then
		guiSetEnabled(register.button[1], true)
	else
		guiSetEnabled(register.button[1], false)
	end
end
addEventHandler("onClientGUIChanged", resourceRoot, renderRegisterDisplays)

function checkUsernameValidity()
	local username = guiGetText(register.edit[1])
	if ((#username == 0) or (#username < 4 or #username > 32) or (string.gsub(username, "%W", "") ~= username)) then return end

	triggerServerEvent("GTIaccounts.checkUsernameValidity", resourceRoot, username)
end
addEventHandler("onClientGUIBlur", register.edit[1], checkUsernameValidity, false)

function returnUsernameValidity(result, r, g, b)
	guiSetText(register.label[2], result)
	guiLabelSetColor(register.label[2], r, g, b)
end
addEvent("GTIaccounts.returnUsernameValidity", true)
addEventHandler("GTIaccounts.returnUsernameValidity", root, returnUsernameValidity)

function registerPlayer(button, state)
	if (button ~= "left" or state ~= "up") then return end

	-- Username
	local username = guiGetText(register.edit[1])
	if ((#username == 0) or (#username < 4 or #username > 32) or (string.gsub(username, "%W", "") ~= username)) then
		exports.GTIhud:dm("Error: Your username is invalid. Go back and correct it.", 255, 25, 25)
		return
	end

	-- E-mail Address
	local email = guiGetText(register.edit[2])
	if (email ~= "" and (not string.find(email, "@") or not string.find(email, "."))) then
		exports.GTIhud:dm("Error: Your e-mail address is invalid. Go back and correct it.", 255, 25, 25)
		return
	end

	-- Password
	local password = guiGetText(register.edit[3])
	if ((#password == 0) or (#password < 8 or #password > 30)) then
		exports.GTIhud:dm("Error: Your password is invalid. Go back and correct it.", 255, 25, 25)
		return
	end

	-- Confirm Password
	local password = guiGetText(register.edit[4])
	if (password ~= guiGetText(register.edit[3])) then
		exports.GTIhud:dm("Error: Your passwords do not match. Go back and correct it.", 255, 25, 25)
		return
	end

	triggerServerEvent("GTIaccounts.registerPlayer", resourceRoot, username, email, password)
end
addEventHandler("onClientGUIClick", register.button[1], registerPlayer, false)

addEventHandler("onClientGUIAccepted", resourceRoot, function(edit)
	if (edit == register.edit[1] or edit == register.edit[2] or edit == register.edit[3] or edit == register.edit[4]) then
		if (not guiGetEnabled(register.button[1])) then return false end
		registerPlayer("left", "up")
	end
end)

function cancelRegistration(button, state)
	if (button ~= "left" or state ~= "up") then return end

	guiSetVisible(login.window[1], true)
	guiSetVisible(register.window[1], false)
end
addEventHandler("onClientGUIClick", register.button[2], cancelRegistration, false)

function comfirmRegistration()
	guiSetText(login.edit[1], "")
	guiSetText(login.edit[2], "")
	guiCheckBoxSetSelected(login.checkbox[1], false)

	guiSetVisible(login.window[1], true)
	guiSetVisible(register.window[1], false)

	outputLoginMessage("Account Successfully Created! Please Login.", 25, 255, 25)
end
addEvent("GITaccounts.comfirmRegistration", true)
addEventHandler("GITaccounts.comfirmRegistration", root, comfirmRegistration)

-- Cancel
---------->>

function leaveServer(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerServerEvent("GTIaccounts.leaveServer", resourceRoot)
end
addEventHandler("onClientGUIClick", login.button[3], leaveServer, false)
