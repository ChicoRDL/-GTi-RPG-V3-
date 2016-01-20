----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 25 Dec 2014
-- Resource: GTIhousing/manage_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Manage Buttons
------------------>>

local manage_tab = {
	{"Lock House",		"This house is unlocked. Lock?"},
	{"Transfer House",	"Transfer this house to someone else for free as a gift."},
}

for i,v in ipairs(manage_tab) do
	-- Buttons
	housingGUI.button[i+5] = guiCreateButton(3, 8+(35*(i-1)), 115, 20, v[1], false, housingGUI.scrollpane[1])
	-- Labels
	housingGUI.label[i+19] = guiCreateLabel(125, 0+(35*(i-1)), 222, 30, v[2], false, housingGUI.scrollpane[1])
	guiLabelSetHorizontalAlign(housingGUI.label[i+19], "left", true)
	guiLabelSetVerticalAlign(housingGUI.label[i+19], "center")
end

-- Transfer House
------------------>>

transferGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 227, 212
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 685, 353, 227, 212
transferGUI.window[1] = guiCreateWindow(685, 353, 227, 212, "GTI House Transfer", false)
guiWindowSetSizable(transferGUI.window[1], false)
guiSetAlpha(transferGUI.window[1], 1.00)
guiSetVisible(transferGUI.window[1], false)
-- Labels
transferGUI.label[1] = guiCreateLabel(12, 29, 202, 24, "You are about to give this house to another person for free. Make sure you want to do this!", false, transferGUI.window[1])
guiSetFont(transferGUI.label[1], "default-small")
guiLabelSetHorizontalAlign(transferGUI.label[1], "center", true)
transferGUI.label[2] = guiCreateLabel(22, 65, 180, 15, "Transfer to this Account Name:", false, transferGUI.window[1])
guiSetFont(transferGUI.label[2], "default-bold-small")
guiLabelSetColor(transferGUI.label[2], 15, 142, 242)
guiLabelSetHorizontalAlign(transferGUI.label[2], "center", false)
transferGUI.label[3] = guiCreateLabel(42, 112, 137, 15, "Your Account Password:", false, transferGUI.window[1])
guiSetFont(transferGUI.label[3], "default-bold-small")
guiLabelSetColor(transferGUI.label[3], 15, 142, 242)
guiLabelSetHorizontalAlign(transferGUI.label[3], "center", false)
-- Edits
transferGUI.edit[1] = guiCreateEdit(22, 82, 181, 21, "", false, transferGUI.window[1])	-- Transfer Acc Name
transferGUI.edit[2] = guiCreateEdit(21, 131, 181, 21, "", false, transferGUI.window[1])	-- Acc Password
guiEditSetMasked(transferGUI.edit[2], true)
-- Buttons
transferGUI.button[1] = guiCreateButton(31, 162, 76, 23, "Transfer (1)", false, transferGUI.window[1])
transferGUI.button[2] = guiCreateButton(114, 162, 76, 23, "Cancel", false, transferGUI.window[1])

-- Storage Warning
------------------->>

storwarn2GUI = {button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 322, 129
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 642, 333, 322, 129
storwarn2GUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "HOUSE STORAGE LOSS WARNING", false)
guiWindowSetSizable(storwarn2GUI.window[1], false)
guiSetAlpha(storwarn2GUI.window[1], 1)
guiSetVisible(storwarn2GUI.window[1], false)
-- Label
storwarn2GUI.label[1] = guiCreateLabel(14, 31, 291, 46, "You will lose everything in your housing storage if you continue! Are you sure you want to transfer your house with items in your house storage?", false, storwarn2GUI.window[1])
guiLabelSetHorizontalAlign(storwarn2GUI.label[1], "center", true)
-- Buttons
storwarn2GUI.button[1] = guiCreateButton(90, 87, 62, 25, "Yes", false, storwarn2GUI.window[1])
storwarn2GUI.button[2] = guiCreateButton(165, 87, 62, 25, "No", false, storwarn2GUI.window[1])
