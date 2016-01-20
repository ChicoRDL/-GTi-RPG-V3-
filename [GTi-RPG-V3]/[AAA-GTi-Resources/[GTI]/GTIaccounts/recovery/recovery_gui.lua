----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 28 Aug 2014
-- Resource: GTIaccounts/recovery_gui.lua
-- Version: 2.0
----------------------------------------->>

-- Recovery GUI
---------------->>

recoveryGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 391, 174
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
recoveryGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Account Recovery", false)
guiWindowSetSizable(recoveryGUI.window[1], false)
guiSetAlpha(recoveryGUI.window[1], 0.90)
guiSetVisible(recoveryGUI.window[1], false)
-- Labels (Static)
recoveryGUI.label[1] = guiCreateLabel(9, 25, 141, 15, "Enter Username:", false, recoveryGUI.window[1])
guiSetFont(recoveryGUI.label[1], "clear-normal")
recoveryGUI.label[2] = guiCreateLabel(9, 72, 141, 15, "Enter Email Address:", false, recoveryGUI.window[1])
guiSetFont(recoveryGUI.label[2], "clear-normal")
-- Labels (Dynamic)
recoveryGUI.label[3] = guiCreateLabel(9, 119, 372, 15, "Enter your Username and your Email Address", false, recoveryGUI.window[1])
guiSetFont(recoveryGUI.label[3], "clear-normal")
guiLabelSetHorizontalAlign(recoveryGUI.label[3], "center", false)
-- Edits
recoveryGUI.edit[1] = guiCreateEdit(9, 44, 373, 23, "", false, recoveryGUI.window[1])	-- Username
recoveryGUI.edit[2] = guiCreateEdit(9, 91, 373, 23, "", false, recoveryGUI.window[1])	-- Email Address
-- Buttons
recoveryGUI.button[1] = guiCreateButton(118, 141, 74, 23, "Recover", false, recoveryGUI.window[1])
recoveryGUI.button[2] = guiCreateButton(204, 141, 74, 23, "Cancel", false, recoveryGUI.window[1])


-- Account Recovery
-------------------->>

accRecoveryGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 518, 294
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
accRecoveryGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Account Recovery", false)
guiWindowSetSizable(accRecoveryGUI.window[1], false)
guiSetAlpha(accRecoveryGUI.window[1], 0.90)
guiSetVisible(accRecoveryGUI.window[1], false)
-- Labels (Static)
accRecoveryGUI.label[1] = guiCreateLabel(11, 34, 184, 15, "Recovery Code:", false, accRecoveryGUI.window[1])
accRecoveryGUI.label[3] = guiCreateLabel(11, 86, 184, 15, "New Password:", false, accRecoveryGUI.window[1])
accRecoveryGUI.label[4] = guiCreateLabel(11, 139, 184, 15, "Confirm Password:", false, accRecoveryGUI.window[1])
accRecoveryGUI.label[7] = guiCreateLabel(9, 201, 496, 47, "The recovery code was sent to the email address that you used when registering your account. If you are unable to recover your account using the automated process, contact the Recovery Office on the GTI Forums @ gtirpg.net", false, accRecoveryGUI.window[1])
guiLabelSetHorizontalAlign(accRecoveryGUI.label[7], "center", true)
-- Labels (Dynamic)
accRecoveryGUI.label[2] = guiCreateLabel(371, 46, 130, 33, "Enter the Recovery Code", false, accRecoveryGUI.window[1])
guiSetFont(accRecoveryGUI.label[2], "clear-normal")
guiLabelSetHorizontalAlign(accRecoveryGUI.label[2], "center", true)
guiLabelSetVerticalAlign(accRecoveryGUI.label[2], "center")
accRecoveryGUI.label[5] = guiCreateLabel(371, 99, 130, 33, "Enter a Password", false, accRecoveryGUI.window[1])
guiSetFont(accRecoveryGUI.label[5], "clear-normal")
guiLabelSetHorizontalAlign(accRecoveryGUI.label[5], "center", true)
guiLabelSetVerticalAlign(accRecoveryGUI.label[5], "center")
accRecoveryGUI.label[6] = guiCreateLabel(371, 152, 130, 33, "Reenter Password", false, accRecoveryGUI.window[1])
guiSetFont(accRecoveryGUI.label[6], "clear-normal")
guiLabelSetHorizontalAlign(accRecoveryGUI.label[6], "center", true)
guiLabelSetVerticalAlign(accRecoveryGUI.label[6], "center")
-- Editboxes
accRecoveryGUI.edit[1] = guiCreateEdit(10, 53, 350, 23, "", false, accRecoveryGUI.window[1])	-- Recovery Code
guiEditSetMaxLength(accRecoveryGUI.edit[1], 32)
accRecoveryGUI.edit[2] = guiCreateEdit(10, 105, 350, 23, "", false, accRecoveryGUI.window[1])	-- New Password
guiEditSetMaxLength(accRecoveryGUI.edit[2], 32)
guiEditSetMasked(accRecoveryGUI.edit[2], true)
accRecoveryGUI.edit[3] = guiCreateEdit(10, 158, 350, 23, "", false, accRecoveryGUI.window[1])	-- Confirm Password
guiEditSetMaxLength(accRecoveryGUI.edit[3], 32)
guiEditSetMasked(accRecoveryGUI.edit[3], true)
-- Buttons
accRecoveryGUI.button[1] = guiCreateButton(150, 254, 101, 30, "Recover", false, accRecoveryGUI.window[1])
guiSetFont(accRecoveryGUI.button[1], "default-bold-small")
guiSetProperty(accRecoveryGUI.button[1], "NormalTextColour", "FFFF1919")
accRecoveryGUI.button[2] = guiCreateButton(263, 254, 101, 30, "Close", false, accRecoveryGUI.window[1])
