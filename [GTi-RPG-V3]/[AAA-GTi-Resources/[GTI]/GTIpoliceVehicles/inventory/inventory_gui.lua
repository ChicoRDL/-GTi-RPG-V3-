----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 09 Mar 2015
-- Resource: GTIpoliceVehicles/inventory_gui.lua
-- Version: 1.0
----------------------------------------->>

inventoryGUI = {gridlist = {}, window = {}, button = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 315, 243
local x, y = (sX-wX) / 2 , (sY-wY) / 2

inventoryGUI.window[1] = guiCreateWindow(x, y, wX, wY, "GTI Rentals — Vehicle Inventory", false)
guiWindowSetSizable(inventoryGUI.window[1], false)
guiSetAlpha(inventoryGUI.window[1], 0.90)
guiSetVisible(inventoryGUI.window[1], false)
-- Labels
inventoryGUI.label[1] = guiCreateLabel(18, 25, 280, 28, "Don't worry about losing weapons, you'll be given your old weapons when you resign from your job.", false, inventoryGUI.window[1])
guiSetFont(inventoryGUI.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(inventoryGUI.label[1], "center", true)
inventoryGUI.label[2] = guiCreateLabel(279, 220, 28, 15, "Close", false, inventoryGUI.window[1])
-- Gridlist
inventoryGUI.gridlist[1] = guiCreateGridList(34, 66, 241, 126, false, inventoryGUI.window[1])
guiGridListAddColumn(inventoryGUI.gridlist[1], "Item", 0.45)
guiGridListAddColumn(inventoryGUI.gridlist[1], "Amount", 0.45)
guiGridListSetSortingEnabled(inventoryGUI.gridlist[1], false)
-- Button
inventoryGUI.button[1] = guiCreateButton(95, 202, 120, 27, "Take Item", false, inventoryGUI.window[1])

