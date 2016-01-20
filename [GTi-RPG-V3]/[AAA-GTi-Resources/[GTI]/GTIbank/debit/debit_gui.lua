----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 26 Sep 2014
-- Resource: GTIbank/debit_gui.lua
-- Version: 1.0
----------------------------------------->>

debitGUI = {staticimage = {}, radiobutton = {}, button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 336, 143
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 633, 342, 336, 143
debitGUI.window[1] = guiCreateWindow(723, 285, 224, 257, "GTI Bank — Payment Method", false)
guiWindowSetSizable(debitGUI.window[1], false)
guiSetAlpha(debitGUI.window[1], 0.90)
guiSetVisible(debitGUI.window[1], false)
-- Labels (Static)
debitGUI.label[1] = guiCreateLabel(26, 29, 77, 15, "Amount Due:", false, debitGUI.window[1])
debitGUI.label[3] = guiCreateLabel(9, 40, 201, 15, "_______________________________________", false, debitGUI.window[1])
debitGUI.label[4] = guiCreateLabel(47, 60, 127, 15, "Select Payment Type", false, debitGUI.window[1])
guiSetFont(debitGUI.label[4], "default-bold-small")
guiLabelSetColor(debitGUI.label[4], 25, 255, 25)
guiLabelSetHorizontalAlign(debitGUI.label[4], "center", false)
debitGUI.label[5] = guiCreateLabel(9, 155, 201, 15, "_______________________________________", false, debitGUI.window[1])
debitGUI.label[6] = guiCreateLabel(21, 177, 77, 15, "Cash:", false, debitGUI.window[1])
guiLabelSetHorizontalAlign(debitGUI.label[6], "right", false)
debitGUI.label[7] = guiCreateLabel(104, 177, 99, 15, "$1,000,000,000", false, debitGUI.window[1])	-- Cash
guiSetFont(debitGUI.label[7], "default-bold-small")
guiLabelSetColor(debitGUI.label[7], 25, 255, 25)
guiLabelSetHorizontalAlign(debitGUI.label[7], "right", false)
debitGUI.label[8] = guiCreateLabel(21, 198, 77, 15, "Bank Balance:", false, debitGUI.window[1])
guiLabelSetHorizontalAlign(debitGUI.label[8], "right", false)
-- Labels (Dynamic)
debitGUI.label[2] = guiCreateLabel(110, 29, 90, 15, "$1,000,000,000", false, debitGUI.window[1])	-- Amount Due
guiSetFont(debitGUI.label[2], "default-bold-small")
guiLabelSetColor(debitGUI.label[2], 255, 25, 25)
guiLabelSetHorizontalAlign(debitGUI.label[2], "right", false)
debitGUI.label[9] = guiCreateLabel(104, 198, 99, 15, "$1,000,000,000", false, debitGUI.window[1])	-- Bank Balance
guiSetFont(debitGUI.label[9], "default-bold-small")
guiLabelSetColor(debitGUI.label[9], 25, 255, 25)
guiLabelSetHorizontalAlign(debitGUI.label[9], "right", false)
-- Static Images
debitGUI.staticimage[1] = guiCreateStaticImage(18, 79, 84, 55, "files/cash.png", false, debitGUI.window[1])
debitGUI.staticimage[2] = guiCreateStaticImage(121, 79, 84, 55, "files/debit.png", false, debitGUI.window[1])
-- Radio Buttons
debitGUI.radiobutton[1] = guiCreateRadioButton(24, 144, 74, 15, "Use Cash", false, debitGUI.window[1])
guiRadioButtonSetSelected(debitGUI.radiobutton[1], true)
debitGUI.radiobutton[2] = guiCreateRadioButton(115, 144, 100, 15, "Use Bank Card", false, debitGUI.window[1])
-- Buttons
debitGUI.button[1] = guiCreateButton(35, 220, 75, 22, "Pay", false, debitGUI.window[1])
debitGUI.button[2] = guiCreateButton(117, 220, 75, 22, "Cancel", false, debitGUI.window[1])
