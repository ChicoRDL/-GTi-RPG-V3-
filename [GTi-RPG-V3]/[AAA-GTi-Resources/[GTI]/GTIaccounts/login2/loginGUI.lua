----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 30 Nov 2013
-- Resource: GTIaccounts/loginGUI.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Login GUI
------------->>
login = {checkbox = {},edit = {},button = {},window = {},label = {},memo = {}}

-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 391, 192
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 492, 288, 391, 192
login.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Login Panel", false)
guiWindowSetSizable(login.window[1], false)
guiSetAlpha(login.window[1], 0.95)
-- Edits
login.edit[1] = guiCreateEdit(9, 46, 368, 23, "", false, login.window[1])
guiEditSetMaxLength(login.edit[1], 25)
login.edit[2] = guiCreateEdit(9, 93, 368, 23, "", false, login.window[1])
guiEditSetMaxLength(login.edit[2], 25)
guiEditSetMasked(login.edit[2], true)
-- Labels (Static)
login.label[1] = guiCreateLabel(10, 25, 108, 16, "Enter Username:", false, login.window[1])
guiSetFont(login.label[1], "clear-normal")
login.label[2] = guiCreateLabel(10, 72, 108, 16, "Enter Password:", false, login.window[1])
guiSetFont(login.label[2], "clear-normal")
-- Labels (Dynamic)
login.label[3] = guiCreateLabel(8, 137, 376, 15, "Enter a Username and a Password", false, login.window[1])
guiSetFont(login.label[3], "clear-normal")
guiLabelSetHorizontalAlign(login.label[3], "center", false)
guiLabelSetVerticalAlign(login.label[3], "center")
-- Checkbox
login.checkbox[1] = guiCreateCheckBox(274, 115, 108, 23, "Remember Me?", false, false, login.window[1])
-- Buttons
login.button[1] = guiCreateButton(116, 160, 74, 23, "Register", false, login.window[1])
login.button[2] = guiCreateButton(32, 160, 74, 23, "Login", false, login.window[1])
login.button[3] = guiCreateButton(200, 160, 74, 23, "Cancel", false, login.window[1])
login.button[4] = guiCreateButton(284, 160, 74, 23, "Recovery", false, login.window[1])
-- Other
guiSetVisible(login.window[1], false)

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
