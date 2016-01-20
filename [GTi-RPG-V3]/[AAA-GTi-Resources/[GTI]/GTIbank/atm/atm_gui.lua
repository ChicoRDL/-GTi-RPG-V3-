----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 24 Sept 2014
-- Resource: GTIbank/atm_gui.lua
-- Version: 1.0
----------------------------------------->>

-- ATM Main Menu
----------------->>

atmGUI = {staticimage = {}, edit = {}, button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 239, 248
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 684, 300, 239, 248
atmGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank ATM", false)
guiWindowSetSizable(atmGUI.window[1], false)
guiSetAlpha(atmGUI.window[1], 0.90)
guiSetVisible(atmGUI.window[1], false)
-- Static Image
atmGUI.staticimage[1] = guiCreateStaticImage(25, 26, 188, 86, "files/ATM.png", false, atmGUI.window[1])
-- Labels (Dynamic)
atmGUI.label[1] = guiCreateLabel(122, 143, 97, 15, "$1,000,000,000", false, atmGUI.window[1])
guiSetFont(atmGUI.label[1], "default-bold-small")
guiLabelSetColor(atmGUI.label[1], 25, 255, 25)
guiLabelSetHorizontalAlign(atmGUI.label[1], "right", false)
atmGUI.label[2] = guiCreateLabel(14, 123, 208, 15, "Account's Main Account", false, atmGUI.window[1])
guiLabelSetColor(atmGUI.label[2], 25, 255, 25)
guiLabelSetHorizontalAlign(atmGUI.label[2], "center", false)
-- Labels (Static)
atmGUI.label[3] = guiCreateLabel(23, 143, 94, 15, "Account Balance:", false, atmGUI.window[1])
atmGUI.label[4] = guiCreateLabel(7, 155, 225, 15, "_____________________________________", false, atmGUI.window[1])
atmGUI.label[5] = guiCreateLabel(15, 180, 48, 15, "Amount:", false, atmGUI.window[1])
guiSetFont(atmGUI.label[5], "default-bold-small")
-- Edit
atmGUI.edit[1] = guiCreateEdit(68, 179, 159, 20, "", false, atmGUI.window[1])
-- Buttons
atmGUI.button[1] = guiCreateButton(31, 207, 83, 23, "Withdraw", false, atmGUI.window[1])
atmGUI.button[2] = guiCreateButton(125, 207, 83, 23, "Log Out", false, atmGUI.window[1])

-- ATM Security Check
---------------------->>

atmLoginGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 251, 121
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 673, 330, 251, 121
atmLoginGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank ATM Security", false)
guiWindowSetSizable(atmLoginGUI.window[1], false)
guiSetAlpha(atmLoginGUI.window[1], 0.90)
guiSetVisible(atmLoginGUI.window[1], false)
-- Label
atmLoginGUI.label[1] = guiCreateLabel(15, 28, 222, 15, "Enter your bank account PIN", false, atmLoginGUI.window[1])
guiLabelSetColor(atmLoginGUI.label[1], 25, 255, 25)
guiLabelSetHorizontalAlign(atmLoginGUI.label[1], "center", false)
-- Edit
atmLoginGUI.edit[1] = guiCreateEdit(82, 50, 82, 23, "", false, atmLoginGUI.window[1])
guiEditSetMasked(atmLoginGUI.edit[1], true)
guiEditSetMaxLength(atmLoginGUI.edit[1], 10)
-- Buttons
atmLoginGUI.button[1] = guiCreateButton(47, 82, 72, 23, "Proceed", false, atmLoginGUI.window[1])
atmLoginGUI.button[2] = guiCreateButton(127, 82, 72, 23, "Cancel", false, atmLoginGUI.window[1])
