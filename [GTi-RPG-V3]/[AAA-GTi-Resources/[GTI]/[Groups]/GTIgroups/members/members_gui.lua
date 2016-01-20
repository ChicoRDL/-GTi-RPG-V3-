----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 22 Jun 2014
-- Resource: GTIgroupPanel/Members/member_fctn_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Remove GUI
-------------->>

remove_gui = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 330, 165
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 629, 335, 330, 165
remove_gui.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Groups System — Remove Player", false)
guiWindowSetSizable(remove_gui.window[1], false)
guiSetVisible(remove_gui.window[1], false)
guiSetAlpha(remove_gui.window[1], 0.95)
-- Labels (Static)
remove_gui.label[1] = guiCreateLabel(11, 30, 306, 15, "Player to be removed:", false, remove_gui.window[1])
guiSetFont(remove_gui.label[1], "default-bold-small")
guiLabelSetColor(remove_gui.label[1], 255, 100, 100)
guiLabelSetHorizontalAlign(remove_gui.label[1], "center", false)
remove_gui.label[3] = guiCreateLabel(11, 73, 306, 15, "Reason (Logged):", false, remove_gui.window[1])
guiSetFont(remove_gui.label[3], "default-bold-small")
guiLabelSetColor(remove_gui.label[3], 255, 100, 100)
guiLabelSetHorizontalAlign(remove_gui.label[3], "center", false)
-- Labels (Dynamic)
remove_gui.label[2] = guiCreateLabel(11, 48, 306, 15, "[ABC]Player>123", false, remove_gui.window[1])
guiLabelSetHorizontalAlign(remove_gui.label[2], "center", false)
-- Edit Field
remove_gui.edit[1] = guiCreateEdit(19, 92, 294, 23, "", false, remove_gui.window[1])
guiEditSetMaxLength(remove_gui.edit[1], 50)
-- Buttons
remove_gui.button[1] = guiCreateButton(87, 124, 79, 26, "Remove (2)", false, remove_gui.window[1])
guiSetProperty(remove_gui.button[1], "NormalTextColour", "FFAAAAAA")
remove_gui.button[2] = guiCreateButton(178, 124, 79, 26, "Cancel", false, remove_gui.window[1])
guiSetProperty(remove_gui.button[2], "NormalTextColour", "FFAAAAAA")

-- Invite GUI
-------------->>

invite_gui = {edit = {}, button = {}, window = {}, label = {}, gridlist = {}, staticimage = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 300, 391
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 646, 256, 300, 391
invite_gui.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Group System — Invite Panel", false)
guiWindowSetSizable(invite_gui.window[1], false)
guiSetVisible(invite_gui.window[1], false)
guiSetAlpha(invite_gui.window[1], 0.95)
-- Label
invite_gui.label[1] = guiCreateLabel(21, 37, 249, 43, "Below is a list of all groupless players. You can only invite players to your group if they are within 25 meters of you.", false, invite_gui.window[1])
guiSetFont(invite_gui.label[1], "default-bold-small")
guiLabelSetColor(invite_gui.label[1], 255, 100, 100)
guiLabelSetHorizontalAlign(invite_gui.label[1], "center", true)
-- Editbox
invite_gui.edit[1] = guiCreateEdit(23, 99, 213, 26, "Search...", false, invite_gui.window[1])
guiSetFont(invite_gui.edit[1], "clear-normal")
guiEditSetMaxLength(invite_gui.edit[1], 20)
-- Gridlist
invite_gui.gridlist[1] = guiCreateGridList(24, 137, 248, 194, false, invite_gui.window[1])
guiGridListAddColumn(invite_gui.gridlist[1], "Player List", 0.9)
-- Static Images
invite_gui.staticimage[1] = guiCreateStaticImage(245, 99, 25, 25, "files/search.png", false, invite_gui.window[1])
-- Buttons
invite_gui.button[1] = guiCreateButton(53, 341, 93, 23, "Invite", false, invite_gui.window[1])
guiSetFont(invite_gui.button[1], "default-bold-small")
guiSetProperty(invite_gui.button[1], "NormalTextColour", "FFFF6464")
invite_gui.button[2] = guiCreateButton(157, 341, 93, 23, "Close", false, invite_gui.window[1])
guiSetProperty(invite_gui.button[2], "NormalTextColour", "FFAAAAAA")

-- Leave GUI
------------->>

leaveGUI = {button = {}, window = {}, label = {}}
local sX, sY = guiGetScreenSize()
local wX, wY = 316, 115
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 646, 348, 316, 115
leaveGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Leave Group", false)
guiWindowSetSizable(leaveGUI.window[1], false)
guiSetAlpha(leaveGUI.window[1], 0.90)
guiSetVisible(leaveGUI.window[1], false)
-- Label
leaveGUI.label[1] = guiCreateLabel(11, 27, 288, 31, "Are you sure you want to leave\n<group>?", false, leaveGUI.window[1])
guiLabelSetHorizontalAlign(leaveGUI.label[1], "center", false)
-- Buttons
leaveGUI.button[1] = guiCreateButton(76, 70, 76, 30, "Yes", false, leaveGUI.window[1])
guiSetProperty(leaveGUI.button[1], "NormalTextColour", "FFAAAAAA")
leaveGUI.button[2] = guiCreateButton(161, 70, 76, 30, "No", false, leaveGUI.window[1])
guiSetFont(leaveGUI.button[2], "default-bold-small")
guiSetProperty(leaveGUI.button[2], "NormalTextColour", "FFAAAAAA")

-- Change Rank
--------------->>

changeRankGUI = {gridlist = {}, window = {}, button = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 210, 316
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 699, 287, 210, 316
changeRankGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Change Group Rank", false)
guiWindowSetSizable(changeRankGUI.window[1], false)
guiSetAlpha(changeRankGUI.window[1], 1.00)
guiSetVisible(changeRankGUI.window[1], false)
-- Labels
changeRankGUI.label[1] = guiCreateLabel(14, 26, 150, 15, "Selected Account:", false, changeRankGUI.window[1])
changeRankGUI.label[2] = guiCreateLabel(13, 45, 182, 15, "[ABC]Player>123", false, changeRankGUI.window[1])
guiSetFont(changeRankGUI.label[2], "clear-normal")
guiLabelSetHorizontalAlign(changeRankGUI.label[2], "center", false)
changeRankGUI.label[3] = guiCreateLabel(14, 65, 89, 15, "Current Rank:", false, changeRankGUI.window[1])
changeRankGUI.label[4] = guiCreateLabel(13, 85, 182, 15, "<Rank Name>", false, changeRankGUI.window[1])
guiSetFont(changeRankGUI.label[4], "clear-normal")
guiLabelSetHorizontalAlign(changeRankGUI.label[4], "center", false)
-- Gridlist
changeRankGUI.gridlist[1] = guiCreateGridList(9, 105, 192, 168, false, changeRankGUI.window[1])
guiGridListAddColumn(changeRankGUI.gridlist[1], "Rank List", 0.9)
-- Button
changeRankGUI.button[1] = guiCreateButton(9, 280, 93, 27, "Update Rank", false, changeRankGUI.window[1])
guiSetFont(changeRankGUI.button[1], "default-bold-small")
guiSetProperty(changeRankGUI.button[1], "NormalTextColour", "FFAAAAAA")
changeRankGUI.button[2] = guiCreateButton(112, 280, 89, 27, "Cancel", false, changeRankGUI.window[1])
guiSetProperty(changeRankGUI.button[2], "NormalTextColour", "FFAAAAAA")
