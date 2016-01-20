----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 16 Nov 2014
-- Resource: GTIhousing/housing_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Buy House
------------->>

confirmGUI = {button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 340, 129
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 634, 366, 340, 129
confirmGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Housing — Confirmation", false)
guiWindowSetSizable(confirmGUI.window[1], false)
guiSetAlpha(confirmGUI.window[1], 1)
guiSetVisible(confirmGUI.window[1], false)
-- Label
confirmGUI.label[1] = guiCreateLabel(13, 29, 316, 50, "Are you sure you want to buy <address> for <cost>?\n(Money will be taken from your bank account)", false, confirmGUI.window[1])
guiSetFont(confirmGUI.label[1], "clear-normal")
guiLabelSetHorizontalAlign(confirmGUI.label[1], "center", true)
-- Buttons
confirmGUI.button[1] = guiCreateButton(93, 86, 67, 29, "Yes", false, confirmGUI.window[1])
confirmGUI.button[2] = guiCreateButton(177, 86, 67, 29, "No", false, confirmGUI.window[1])

-- Sell House
-------------->>

sellHouseGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 370, 135
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 612, 393, 370, 135
sellHouseGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Housing — Sell House", false)
guiWindowSetSizable(sellHouseGUI.window[1], false)
guiSetAlpha(sellHouseGUI.window[1], 1)
guiSetVisible(sellHouseGUI.window[1], false)
-- Labels (Static)
sellHouseGUI.label[1] = guiCreateLabel(11, 29, 344, 15, "You are about to sell <address>", false, sellHouseGUI.window[1])
guiSetFont(sellHouseGUI.label[1], "default-bold-small")
guiLabelSetColor(sellHouseGUI.label[1], 14, 152, 242)
guiLabelSetHorizontalAlign(sellHouseGUI.label[1], "center", false)
sellHouseGUI.label[2] = guiCreateLabel(16, 48, 139, 15, "Enter your asking price:", false, sellHouseGUI.window[1])
guiLabelSetHorizontalAlign(sellHouseGUI.label[2], "center", false)
sellHouseGUI.label[4] = guiCreateLabel(173, 62, 23, 15, "OR", false, sellHouseGUI.window[1])
guiSetFont(sellHouseGUI.label[4], "default-bold-small")
guiLabelSetColor(sellHouseGUI.label[4], 14, 152, 242)
guiLabelSetHorizontalAlign(sellHouseGUI.label[4], "center", false)
-- Labels (Dynamic)
sellHouseGUI.label[3] = guiCreateLabel(210, 46, 144, 45, "Sell it to the SA Housing Administration for $99,999,999", false, sellHouseGUI.window[1])
guiLabelSetHorizontalAlign(sellHouseGUI.label[3], "center", true)
guiLabelSetVerticalAlign(sellHouseGUI.label[3], "center")
-- Edit
sellHouseGUI.edit[1] = guiCreateEdit(15, 67, 142, 23, "", false, sellHouseGUI.window[1])
-- Buttons
sellHouseGUI.button[1] = guiCreateButton(16, 96, 141, 18, "Sell to Public", false, sellHouseGUI.window[1])
sellHouseGUI.button[2] = guiCreateButton(213, 96, 141, 18, "Sell to SA Housing", false, sellHouseGUI.window[1])
sellHouseGUI.button[3] = guiCreateButton(164, 96, 43, 18, "Cancel", false, sellHouseGUI.window[1])

-- Storage Warning
------------------->>

storwarnGUI = {button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 322, 129
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 642, 333, 322, 129
storwarnGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "HOUSE STORAGE LOSS WARNING", false)
guiWindowSetSizable(storwarnGUI.window[1], false)
guiSetAlpha(storwarnGUI.window[1], 1)
guiSetVisible(storwarnGUI.window[1], false)
-- Label
storwarnGUI.label[1] = guiCreateLabel(14, 31, 291, 46, "You will lose everything in your housing storage if you continue! Are you sure you want to sell your house with items in your house storage?", false, storwarnGUI.window[1])
guiLabelSetHorizontalAlign(storwarnGUI.label[1], "center", true)
-- Buttons
storwarnGUI.button[1] = guiCreateButton(90, 87, 62, 25, "Yes", false, storwarnGUI.window[1])
storwarnGUI.button[2] = guiCreateButton(165, 87, 62, 25, "No", false, storwarnGUI.window[1])
