----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 22 Jun 2014
-- Resource: GTIgroupPanel/Admin/Ranks/ranks_gui.lua
-- Version: 1.0
----------------------------------------->>

ranks_gui = {scrollpane = {}, label = {}, button = {}, window = {}, gridlist = {}, checkbox = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 538, 354
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 503, 249, 538, 354
ranks_gui.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Rank Management System", false)
guiWindowSetSizable(ranks_gui.window[1], false)
guiSetAlpha(ranks_gui.window[1], 1.0)
guiSetVisible(ranks_gui.window[1], false)
-- Labels
ranks_gui.label[1] = guiCreateLabel(9, 27, 172, 15, "Group Rank List", false, ranks_gui.window[1])
guiSetFont(ranks_gui.label[1], "default-bold-small")
guiLabelSetColor(ranks_gui.label[1], 255, 100, 100)
guiLabelSetHorizontalAlign(ranks_gui.label[1], "center", false)
ranks_gui.label[2] = guiCreateLabel(288, 27, 142, 15, "Group Permissions List", false, ranks_gui.window[1])
guiSetFont(ranks_gui.label[2], "default-bold-small")
guiLabelSetColor(ranks_gui.label[2], 255, 100, 100)
guiLabelSetHorizontalAlign(ranks_gui.label[2], "center", false)
ranks_gui.label[3] = guiCreateLabel(193, 48, 335, 32, "Permissions are what this rank has access to. To toggle the permission, simply check/uncheck the box.", false, ranks_gui.window[1])
guiLabelSetHorizontalAlign(ranks_gui.label[3], "center", true)
ranks_gui.label[4] = guiCreateLabel(489, 28, 38, 15, "[Close]", false, ranks_gui.window[1])
-- Gridlist
ranks_gui.gridlist[1] = guiCreateGridList(9, 76, 175, 211, false, ranks_gui.window[1])
guiGridListAddColumn(ranks_gui.gridlist[1], "Group Rank List", 0.9)
guiGridListSetSortingEnabled(ranks_gui.gridlist[1], false)
-- Buttons
ranks_gui.button[1] = guiCreateButton(9, 292, 85, 22, "Move Up", false, ranks_gui.window[1])
ranks_gui.button[2] = guiCreateButton(99, 292, 85, 22, "Move Down", false, ranks_gui.window[1])
ranks_gui.button[7] = guiCreateButton(9, 48, 175, 22, "Update Rank Order", false, ranks_gui.window[1])
ranks_gui.button[3] = guiCreateButton(9, 320, 55, 22, "Add", false, ranks_gui.window[1])
ranks_gui.button[4] = guiCreateButton(129, 320, 55, 22, "Remove", false, ranks_gui.window[1])
ranks_gui.button[5] = guiCreateButton(69, 320, 55, 22, "Rename", false, ranks_gui.window[1])
ranks_gui.button[6] = guiCreateButton(284, 313, 158, 30, "Apply Permissions", false, ranks_gui.window[1])
guiSetFont(ranks_gui.button[6], "default-bold-small")
-- Scrollpane
ranks_gui.scrollpane[1] = guiCreateScrollPane(192, 87, 337, 220, false, ranks_gui.window[1])

-- Add Rank GUI
---------------->>

addRankGUI = {edit = {}, button = {}, window = {}, label = {}, combobox = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 347, 129
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 628, 335, 347, 129
addRankGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Add Group Rank...", false)
guiWindowSetSizable(addRankGUI.window[1], false)
guiSetAlpha(addRankGUI.window[1], 1.00)
guiSetVisible(addRankGUI.window[1], false)
-- Labels
addRankGUI.label[1] = guiCreateLabel(9, 74, 223, 15, "Rank Name", false, addRankGUI.window[1])
guiLabelSetHorizontalAlign(addRankGUI.label[1], "center", false)
addRankGUI.label[2] = guiCreateLabel(9, 26, 224, 15, "Inherit Permissions From...", false, addRankGUI.window[1])
guiLabelSetHorizontalAlign(addRankGUI.label[2], "center", false)
addRankGUI.label[3] = guiCreateLabel(239, 20, 15, 99, "|  |  |  |  |  |  |", false, addRankGUI.window[1])
guiLabelSetHorizontalAlign(addRankGUI.label[3], "left", true)
addRankGUI.label[4] = guiCreateLabel(239, 23, 15, 99, "|  |  |  |  |  |  |", false, addRankGUI.window[1])
guiLabelSetHorizontalAlign(addRankGUI.label[4], "left", true)
-- Edit
addRankGUI.edit[1] = guiCreateEdit(9, 94, 225, 23, "", false, addRankGUI.window[1])
guiEditSetMaxLength(addRankGUI.edit[1], 32)
-- Combobox
addRankGUI.combobox[1] = guiCreateComboBox(45, 44, 154, 23, "", false, addRankGUI.window[1])
-- Buttons
addRankGUI.button[1] = guiCreateButton(250, 35, 85, 28, "Create", false, addRankGUI.window[1])
guiSetFont(addRankGUI.button[1], "default-bold-small")
guiSetProperty(addRankGUI.button[1], "NormalTextColour", "FFAAAAAA")
addRankGUI.button[2] = guiCreateButton(250, 78, 85, 28, "Close", false, addRankGUI.window[1])
guiSetProperty(addRankGUI.button[2], "NormalTextColour", "FFAAAAAA")

-- Rename Rank GUI
-------------------->>

renameRankGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 245, 113
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 625, 320, 245, 113
renameRankGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Rename Group Rank", false)
guiWindowSetSizable(renameRankGUI.window[1], false)
guiSetAlpha(renameRankGUI.window[1], 1.00)
guiSetVisible(renameRankGUI.window[1], false)
-- Label
renameRankGUI.label[1] = guiCreateLabel(-18, 28, 277, 15, "Change '<name>' rank name to:", false, renameRankGUI.window[1])
guiLabelSetHorizontalAlign(renameRankGUI.label[1], "center", false)
-- Editbox
renameRankGUI.edit[1] = guiCreateEdit(16, 48, 216, 21, "", false, renameRankGUI.window[1])
guiEditSetMaxLength(renameRankGUI.edit[1], 32)
-- Button
renameRankGUI.button[1] = guiCreateButton(53, 77, 63, 26, "Change", false, renameRankGUI.window[1])
guiSetProperty(renameRankGUI.button[1], "NormalTextColour", "FFAAAAAA")
renameRankGUI.button[2] = guiCreateButton(125, 77, 63, 26, "Cancel", false, renameRankGUI.window[1])
guiSetProperty(renameRankGUI.button[2], "NormalTextColour", "FFAAAAAA")

-- Remove Rank GUI
------------------->>

removeRankGUI = {button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 285, 138
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 660, 366, 285, 138
removeRankGUI.window[1] = guiCreateWindow(660, 366, 285, 138, "Group Rank Deletion", false)
guiWindowSetSizable(removeRankGUI.window[1], false)
guiSetAlpha(removeRankGUI.window[1], 1.00)
guiSetVisible(removeRankGUI.window[1], false)
-- Labels
removeRankGUI.label[1] = guiCreateLabel(26, 24, 225, 30, "Are you sure you want to delete the \n'<rank>' rank?", false, removeRankGUI.window[1])
guiSetFont(removeRankGUI.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(removeRankGUI.label[1], "center", false)
removeRankGUI.label[2] = guiCreateLabel(10, 58, 257, 31, "All members with this rank will be given the\n'<rank>' rank.", false, removeRankGUI.window[1])
guiLabelSetHorizontalAlign(removeRankGUI.label[2], "center", false)
-- Buttons
removeRankGUI.button[1] = guiCreateButton(68, 96, 67, 29, "Delete", false, removeRankGUI.window[1])
guiSetProperty(removeRankGUI.button[1], "NormalTextColour", "FFAAAAAA")
removeRankGUI.button[2] = guiCreateButton(141, 96, 67, 29, "Cancel", false, removeRankGUI.window[1])
guiSetProperty(removeRankGUI.button[2], "NormalTextColour", "FFAAAAAA")

