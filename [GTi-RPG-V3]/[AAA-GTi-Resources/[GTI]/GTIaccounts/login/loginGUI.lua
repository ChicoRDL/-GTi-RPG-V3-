----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 30 Nov 2013
-- Resource: GTIaccounts/loginGUI.lua
-- Version: 2.0
----------------------------------------->>

loginScreen = {}
--local language = exports.GTIlanguage

-- Login Screen GUI
-------------------->>

local sX,sY = guiGetScreenSize()
local bX,bY = 608, 516 
local bX,bY = (sX/2)-(bX/2),(sY/2)-(bY/2)
login = {image = {}, button = {}, checkbox = {}, scrollpane = {}, label = {}, edit = {}}
-- Labels
login.label[3] = guiCreateLabel(bX+420, bY+165, 85, 15, "Remember Me?", false)
guiLabelSetColor(login.label[3], 0, 0, 0)
login.label[5] = guiCreateLabel(bX+86, bY+167, 304, 15, "", false)
guiLabelSetColor(login.label[5], 0, 0, 0)
guiSetFont(login.label[5], "clear-normal")
login.label[4] = guiCreateLabel(bX+85, bY+166, 304, 15, "", false)
guiSetFont(login.label[4], "clear-normal")
-- Scrollpane
login.scrollpane[1] = guiCreateScrollPane(bX+1, bY+248, 608, 230, false)
	-- Labels
	login.label[2] = guiCreateLabel(4, 5, 583, 5000, "Getting server updates log...", false, login.scrollpane[1])
	guiLabelSetColor(login.label[2], 0, 0, 0)
	guiLabelSetHorizontalAlign(login.label[2], "left", true)
	login.label[1] = guiCreateLabel(3, 4, 583, 5000, "Getting server updates log...", false, login.scrollpane[1])
	guiLabelSetHorizontalAlign(login.label[1], "left", true)
-- Checkbox
login.checkbox[1] = guiCreateCheckBox(bX+400, bY+164, 106, 15, "Remember Me?", false, false)
-- Edit Boxes
login.edit[1] = guiCreateEdit(bX+142, bY+137, 150, 25, "", false)
guiEditSetMaxLength(login.edit[1], 25)
login.edit[2] = guiCreateEdit(bX+357, bY+137, 150, 25, "", false)
guiEditSetMaxLength(login.edit[2], 25)
guiEditSetMasked(login.edit[2], true)
-- Buttons
login.button[1] = guiCreateButton(bX+134, bY+187, 75, 22, "PLAY!", false)
guiSetFont(login.button[1], "default-bold-small")
login.button[2] = guiCreateButton(bX+218, bY+187, 75, 22, "Register", false)
login.button[3] = guiCreateButton(bX+301, bY+187, 75, 22, "Leave", false)
login.button[4] = guiCreateButton(bX+386, bY+187, 75, 22, "Recover", false)
-- Static Images
login.image[1] = guiCreateStaticImage(bX+106, bY+0, 372, 126, "images/gti_logo.png", false)
login.image[2] = guiCreateStaticImage(bX+85, bY+137, 63, 25, "images/user.png", false)
login.image[3] = guiCreateStaticImage(bX+300, bY+137, 63, 25, "images/pass.png", false)
login.image[4] = guiCreateStaticImage(bX+187, bY+468, 235, 45, "images/recent_updates.png", false)

-- Toggle Login Screen
----------------------->>

function loginScreen.show()
	for v in pairs(login) do
		for _,gui in pairs(login[v]) do
			guiSetVisible(gui, true)
		end
	end
	addEventHandler("onClientRender", root, renderUpdates)
end

function loginScreen.hide()
	for v in pairs(login) do
		for _,gui in pairs(login[v]) do
			guiSetVisible(gui, false)
		end
	end
	removeEventHandler("onClientRender", root, renderUpdates)
end

-- Image Bug Fixes
------------------->>

function imageBugFixes()
	guiBringToFront(login.image[2])
	guiBringToFront(login.image[3])
end
addEventHandler("onClientGUIFocus", login.edit[1], imageBugFixes)
addEventHandler("onClientGUIFocus", login.edit[2], imageBugFixes)

-- Render Updates
------------------>>

function renderUpdates()
	dxDrawRectangle(bX-1, bY+246, 613, 235, tocolor(0, 0, 0, 100))
end

-- Other -->>
addEventHandler("onClientResourceStart", resourceRoot, loginScreen.hide)

-- Register GUI
---------------->>

register = {button = {},window = {},edit = {},label = {}}

-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 518, 338
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 427, 209, 518, 338
register.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Account Registration", false)
guiWindowSetSizable(register.window[1], false)
guiSetAlpha(register.window[1], 0.95)
-- Labels (Static)
register.label[1] = guiCreateLabel(13, 22, 125, 16, "Account Username:", false, register.window[1])
guiSetFont(register.label[1], "clear-normal")
register.label[3] = guiCreateLabel(13, 68, 166, 16, "E-mail Address (Optional):", false, register.window[1])
guiSetFont(register.label[3], "clear-normal")
register.label[5] = guiCreateLabel(13, 133, 117, 16, "Enter a Password:", false, register.window[1])
guiSetFont(register.label[5], "clear-normal")
register.label[6] = guiCreateLabel(11, 110, 502, 15, "________________________________________________________________________________________", false, register.window[1])
register.label[7] = guiCreateLabel(13, 178, 117, 16, "Repeat Password:", false, register.window[1])
guiSetFont(register.label[7], "clear-normal")
register.label[10] = guiCreateLabel(11, 219, 502, 15, "________________________________________________________________________________________", false, register.window[1])
register.label[11] = guiCreateLabel(10, 236, 502, 62, "Your Account Username is the username that you will login with. It cannot be changed. Your e-mail address will be used to recover your password in the event that you forget it. It is completely optional, but password recovery will be a lot more difficult without it. Your password can be changed in the future.", false, register.window[1])
guiLabelSetHorizontalAlign(register.label[11], "center", true)
guiLabelSetVerticalAlign(register.label[11], "center")
-- Labels (Dynamic)
register.label[2] = guiCreateLabel(383, 27, 130, 44, "Enter a Username", false, register.window[1])
guiLabelSetColor(register.label[2], 255, 255, 255)
guiLabelSetHorizontalAlign(register.label[2], "center", true)
guiLabelSetVerticalAlign(register.label[2], "center")
register.label[4] = guiCreateLabel(383, 83, 130, 33, "E-mail Not Provided", false, register.window[1])
guiLabelSetColor(register.label[4], 255, 255, 25)
guiLabelSetHorizontalAlign(register.label[4], "center", true)
guiLabelSetVerticalAlign(register.label[4], "center")
register.label[8] = guiCreateLabel(383, 146, 130, 33, "Enter a Password", false, register.window[1])
guiLabelSetColor(register.label[8], 255, 255, 255)
guiLabelSetHorizontalAlign(register.label[8], "center", true)
guiLabelSetVerticalAlign(register.label[8], "center")
register.label[9] = guiCreateLabel(383, 191, 130, 33, "Reenter Password", false, register.window[1])
guiLabelSetColor(register.label[9], 255, 255, 255)
guiLabelSetHorizontalAlign(register.label[9], "center", true)
guiLabelSetVerticalAlign(register.label[9], "center")
-- Edits
register.edit[1] = guiCreateEdit(11, 41, 368, 23, "", false, register.window[1]) -- Username
guiEditSetMaxLength(register.edit[1], 32)
register.edit[2] = guiCreateEdit(11, 87, 368, 23, "", false, register.window[1]) -- E-mail Address
guiEditSetMaxLength(register.edit[2], 64)
register.edit[3] = guiCreateEdit(11, 151, 368, 23, "", false, register.window[1]) -- Password
guiEditSetMasked(register.edit[3], true)
guiEditSetMaxLength(register.edit[3], 32)
register.edit[4] = guiCreateEdit(11, 196, 368, 23, "", false, register.window[1]) -- Confirm Password
guiEditSetMasked(register.edit[4], true)
guiEditSetMaxLength(register.edit[4], 32)
-- Buttons
register.button[1] = guiCreateButton(171, 301, 85, 28, "Register", false, register.window[1])
guiSetFont(register.button[1], "default-bold-small")
guiSetEnabled(register.button[1], false)
register.button[2] = guiCreateButton(263, 301, 85, 28, "Close", false, register.window[1])
-- Other
guiSetVisible(register.window[1], false)
