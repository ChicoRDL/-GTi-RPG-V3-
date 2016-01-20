----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 26 Sep 2014
-- Resource: GTIbank/recovery_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Recovery GUI
---------------->>

recoveryGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 336, 143
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 633, 342, 336, 143
recoveryGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank — PIN Recovery", false)
guiWindowSetSizable(recoveryGUI.window[1], false)
guiSetAlpha(recoveryGUI.window[1], 0.90)
guiSetVisible(recoveryGUI.window[1], false)
-- Labels
recoveryGUI.label[1] = guiCreateLabel(15, 31, 301, 33, "Lost your PIN? Enter your e-mail address below and your PIN reset instructions will be sent to you.", false, recoveryGUI.window[1])
guiLabelSetHorizontalAlign(recoveryGUI.label[1], "center", true)
recoveryGUI.label[2] = guiCreateLabel(17, 75, 83, 15, "E-mail Address:", false, recoveryGUI.window[1])
guiLabelSetColor(recoveryGUI.label[2], 25, 255, 25)
-- Edit
recoveryGUI.edit[1] = guiCreateEdit(106, 72, 209, 22, "", false, recoveryGUI.window[1])
-- Buttons
recoveryGUI.button[1] = guiCreateButton(58, 104, 104, 22, "Recover", false, recoveryGUI.window[1])
recoveryGUI.button[2] = guiCreateButton(174, 104, 104, 22, "Cancel", false, recoveryGUI.window[1])

-- PIN Recovery
---------------->>

pinRecoveryGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 371, 178
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 611, 320, 371, 178
pinRecoveryGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank — PIN Recovery", false)
guiWindowSetSizable(pinRecoveryGUI.window[1], false)
guiSetAlpha(pinRecoveryGUI.window[1], 0.90)
guiSetVisible(pinRecoveryGUI.window[1], false)
-- Label
pinRecoveryGUI.label[1] = guiCreateLabel(16, 29, 338, 37, "The recovery code was sent to the email address that you used when registering your account. If you are unable to recover your account using the automated process, contact the Recovery Office on the GTI Forums @ gtirpg.net", false, pinRecoveryGUI.window[1])
guiSetFont(pinRecoveryGUI.label[1], "default-small")
guiLabelSetHorizontalAlign(pinRecoveryGUI.label[1], "center", true)
pinRecoveryGUI.label[2] = guiCreateLabel(23, 79, 100, 15, "Recovery Code:", false, pinRecoveryGUI.window[1])
guiSetFont(pinRecoveryGUI.label[2], "clear-normal")
guiLabelSetColor(pinRecoveryGUI.label[2], 25, 255, 25)
pinRecoveryGUI.label[3] = guiCreateLabel(8, 111, 62, 15, "New PIN:", false, pinRecoveryGUI.window[1])
guiSetFont(pinRecoveryGUI.label[3], "clear-normal")
guiLabelSetColor(pinRecoveryGUI.label[3], 25, 255, 25)
guiLabelSetHorizontalAlign(pinRecoveryGUI.label[3], "center", false)
pinRecoveryGUI.label[4] = guiCreateLabel(174, 110, 88, 15, "Reenter PIN:", false, pinRecoveryGUI.window[1])
guiSetFont(pinRecoveryGUI.label[4], "clear-normal")
guiLabelSetColor(pinRecoveryGUI.label[4], 25, 255, 25)
guiLabelSetHorizontalAlign(pinRecoveryGUI.label[4], "center", false)
-- Edits
pinRecoveryGUI.edit[1] = guiCreateEdit(128, 76, 211, 23, "", false, pinRecoveryGUI.window[1])	-- Recovery Code
pinRecoveryGUI.edit[2] = guiCreateEdit(73, 107, 95, 22, "", false, pinRecoveryGUI.window[1])	-- Enter PIN
guiEditSetMasked(pinRecoveryGUI.edit[2], true)
guiEditSetMaxLength(pinRecoveryGUI.edit[2], 10)
pinRecoveryGUI.edit[3] = guiCreateEdit(261, 107, 95, 22, "", false, pinRecoveryGUI.window[1])	-- Reenter PIN
guiEditSetMasked(pinRecoveryGUI.edit[3], true)
guiEditSetMaxLength(pinRecoveryGUI.edit[3], 10)
-- Buttons
pinRecoveryGUI.button[1] = guiCreateButton(93, 137, 91, 25, "Change PIN", false, pinRecoveryGUI.window[1])
guiSetFont(pinRecoveryGUI.button[1], "default-bold-small")
guiSetProperty(pinRecoveryGUI.button[1], "NormalTextColour", "FF19FF19")
pinRecoveryGUI.button[2] = guiCreateButton(194, 137, 91, 25, "Cancel", false, pinRecoveryGUI.window[1])
