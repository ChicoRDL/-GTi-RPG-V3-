----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 20 Jun 2014
-- Resource: GTIgroupPanel/create/gui.lua
-- Version: 1.0
----------------------------------------->>

groupCreate = {edit = {}, button = {}, window = {}, label = {}, gridlist = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 524, 310
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 541, 283, 524, 310
groupCreate.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Group Creation Panel", false)
guiWindowSetSizable(groupCreate.window[1], false)
guiSetAlpha(groupCreate.window[1], 0.90)
guiSetVisible(groupCreate.window[1], false)
-- Labels
groupCreate.label[1] = guiCreateLabel(23, 35, 478, 31, "You are not currently in a group! If you have received a group invite, it will appear on the left. To create your own group, look at the information on the right.", false, groupCreate.window[1])
guiLabelSetHorizontalAlign(groupCreate.label[1], "center", true)
groupCreate.label[2] = guiCreateLabel(254, 73, 15, 207, "|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ", false, groupCreate.window[1])
guiLabelSetHorizontalAlign(groupCreate.label[2], "left", true)
groupCreate.label[3] = guiCreateLabel(254, 76, 15, 204, "|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ", false, groupCreate.window[1])
guiLabelSetHorizontalAlign(groupCreate.label[3], "left", true)
groupCreate.label[4] = guiCreateLabel(55, 80, 153, 15, "Pending Group Invites", false, groupCreate.window[1])
guiSetFont(groupCreate.label[4], "default-bold-small")
guiLabelSetColor(groupCreate.label[4], 255, 50, 50)
guiLabelSetHorizontalAlign(groupCreate.label[4], "center", false)
groupCreate.label[5] = guiCreateLabel(309, 80, 153, 15, "Create My Own Group", false, groupCreate.window[1])
guiSetFont(groupCreate.label[5], "default-bold-small")
guiLabelSetColor(groupCreate.label[5], 255, 50, 50)
guiLabelSetHorizontalAlign(groupCreate.label[5], "center", false)
groupCreate.label[6] = guiCreateLabel(284, 112, 208, 33, "Enter your group name below to create it", false, groupCreate.window[1])
guiLabelSetHorizontalAlign(groupCreate.label[6], "center", true)
groupCreate.label[7] = guiCreateLabel(465, 264, 28, 15, "Close", false, groupCreate.window[1])
-- Editbox
groupCreate.edit[1] = guiCreateEdit(282, 157, 212, 28, "", false, groupCreate.window[1])
guiEditSetMaxLength(groupCreate.edit[1], 32)
-- Gridlist
groupCreate.gridlist[1] = guiCreateGridList(31, 112, 207, 125, false, groupCreate.window[1])
guiGridListAddColumn(groupCreate.gridlist[1], "Group Name", 0.9)
-- Buttons
groupCreate.button[1] = guiCreateButton(282, 209, 213, 30, "Create Group", false, groupCreate.window[1])
guiSetFont(groupCreate.button[1], "default-bold-small")
guiSetProperty(groupCreate.button[1], "NormalTextColour", "FFFF3232")
groupCreate.button[2] = guiCreateButton(32, 250, 60, 28, "Accept", false, groupCreate.window[1])
guiSetProperty(groupCreate.button[2], "NormalTextColour", "FFAAAAAA")
groupCreate.button[3] = guiCreateButton(105, 250, 60, 28, "Deny", false, groupCreate.window[1])
guiSetProperty(groupCreate.button[3], "NormalTextColour", "FFAAAAAA")
groupCreate.button[4] = guiCreateButton(179, 250, 60, 28, "Deny All", false, groupCreate.window[1])
guiSetProperty(groupCreate.button[4], "NormalTextColour", "FFAAAAAA")
