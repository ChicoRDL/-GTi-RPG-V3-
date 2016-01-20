----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 26 Sept 2014
-- Resource: GTIbank/security_gui.lua
-- Version: 1.0
----------------------------------------->>

securityGUI = {checkbox = {}, edit = {}, button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 400, 138
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 600, 327, 400, 138
securityGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank — Advanced Options", false)
guiWindowSetSizable(securityGUI.window[1], false)
guiSetAlpha(securityGUI.window[1], 0.90)
guiSetVisible(securityGUI.window[1], false)
-- Labels (Static)
securityGUI.label[1] = guiCreateLabel(18, 30, 129, 15, "Bank Account Security", false, securityGUI.window[1])
guiSetFont(securityGUI.label[1], "default-bold-small")
guiLabelSetColor(securityGUI.label[1], 25, 255, 25)
securityGUI.label[2] = guiCreateLabel(17, 50, 356, 30, "Protect your money with another layer of security. Having a PIN allows you to access your money on the go.", false, securityGUI.window[1])
guiLabelSetHorizontalAlign(securityGUI.label[2], "left", true)
securityGUI.label[3] = guiCreateLabel(23, 89, 47, 15, "My PIN:", false, securityGUI.window[1])
guiSetFont(securityGUI.label[3], "clear-normal")
guiLabelSetColor(securityGUI.label[3], 25, 255, 25)
securityGUI.label[4] = guiCreateLabel(89, 112, 225, 15, "Select \"Secure Account\" to enable the PIN protection", false, securityGUI.window[1])
guiSetFont(securityGUI.label[4], "default-small")
guiLabelSetHorizontalAlign(securityGUI.label[4], "right", false)
-- Labels (Dynamic)
securityGUI.label[5] = guiCreateLabel(353, 25, 38, 16, "[Close]", false, securityGUI.window[1])
-- Edits
securityGUI.edit[1] = guiCreateEdit(76, 86, 98, 21, "", false, securityGUI.window[1])
guiEditSetMasked(securityGUI.edit[1], true)
guiEditSetMaxLength(securityGUI.edit[1], 10)
-- Checkbox
securityGUI.checkbox[1] = guiCreateCheckBox(273, 90, 108, 15, "Secure Account", false, false, securityGUI.window[1])
-- Button
securityGUI.button[1] = guiCreateButton(179, 87, 64, 19, "Update", false, securityGUI.window[1])
