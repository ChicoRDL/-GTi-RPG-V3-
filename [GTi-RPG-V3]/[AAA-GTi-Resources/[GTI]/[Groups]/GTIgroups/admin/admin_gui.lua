----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 05 Jul 2014
-- Resource: GTIgroupPanel/Admin/Admin_Fctns/admin_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Update Group Info
--------------------->>

groupInfoGUI = {button = {}, window = {}, label = {}, memo = {}}
local sX, sY = guiGetScreenSize()
local wX, wY = 670, 403
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 468, 255, 670, 403
groupInfoGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Group Information Editor", false)
guiWindowSetSizable(groupInfoGUI.window[1], false)
guiSetAlpha(groupInfoGUI.window[1], 0.90)
guiSetVisible(groupInfoGUI.window[1], false)
-- Memo
groupInfoGUI.memo[1] = guiCreateMemo(9, 55, 652, 310, "", false, groupInfoGUI.window[1])
--guiSetFont(groupInfoGUI.memo[1], "clear-normal")
--guiSetProperty(groupInfoGUI.memo[1], "Font", "clear-normal")
-- Label
groupInfoGUI.label[1] = guiCreateLabel(8, 29, 652, 15, "Edit the information in the box below to update your group information. What you see is what you get.", false, groupInfoGUI.window[1])
guiSetFont(groupInfoGUI.label[1], "clear-normal")
guiLabelSetHorizontalAlign(groupInfoGUI.label[1], "center", false)
-- Button
groupInfoGUI.button[1] = guiCreateButton(197, 371, 137, 23, "Update", false, groupInfoGUI.window[1])
guiSetProperty(groupInfoGUI.button[1], "NormalTextColour", "FFAAAAAA")
groupInfoGUI.button[2] = guiCreateButton(341, 371, 137, 23, "Cancel", false, groupInfoGUI.window[1])
guiSetProperty(groupInfoGUI.button[2], "NormalTextColour", "FFAAAAAA")

-- Group Reminders
------------------->>

groupNewsGUI = {checkbox = {}, edit = {}, button = {}, window = {}, label = {}}
local sX, sY = guiGetScreenSize()
local wX, wY = 346, 164
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 590, 303, 346, 164
groupNewsGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Group Reminders", false)
guiWindowSetSizable(groupNewsGUI.window[1], false)
guiSetAlpha(groupNewsGUI.window[1], 0.90)
guiSetVisible(groupNewsGUI.window[1], false)
-- Labels (Static)
groupNewsGUI.label[1] = guiCreateLabel(14, 28, 315, 24, "Group Reminders are news items that appear on the Home Tab. Check \"Notify on Login\" to have the message appear when the player joins", false, groupNewsGUI.window[1])
guiSetFont(groupNewsGUI.label[1], "default-small")
guiLabelSetHorizontalAlign(groupNewsGUI.label[1], "center", true)
-- Labels (Dynamic)
groupNewsGUI.label[2] = guiCreateLabel(57, 136, 38, 17, "[Close]", false, groupNewsGUI.window[1])
groupNewsGUI.label[3] = guiCreateLabel(12, 136, 37, 17, "[Save]", false, groupNewsGUI.window[1])
-- Reminder A
groupNewsGUI.edit[1] = guiCreateEdit(14, 61, 256, 22, "", false, groupNewsGUI.window[1])
guiEditSetMaxLength(groupNewsGUI.edit[1], 128)
groupNewsGUI.checkbox[1] = guiCreateCheckBox(166, 85, 104, 15, "Notify on Login", false, false, groupNewsGUI.window[1])
groupNewsGUI.button[1] = guiCreateButton(277, 63, 57, 18, "Remove", false, groupNewsGUI.window[1])
-- Reminder B
groupNewsGUI.edit[2] = guiCreateEdit(14, 105, 256, 22, "", false, groupNewsGUI.window[1])
guiEditSetMaxLength(groupNewsGUI.edit[2], 128)
groupNewsGUI.button[2] = guiCreateButton(277, 108, 57, 18, "Add", false, groupNewsGUI.window[1])
guiSetProperty(groupNewsGUI.button[2], "NormalTextColour", "FFAAAAAA")
groupNewsGUI.checkbox[2] = guiCreateCheckBox(166, 131, 104, 15, "Notify on Login", false, false, groupNewsGUI.window[1])

-- Change Group Name GUI
------------------------->>

chgGrpNm_gui = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 322, 162
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 636, 321, 322, 162
chgGrpNm_gui.window[1] = guiCreateWindow(sX, sY, wX, wY, "Change Group Name", false)
guiWindowSetSizable(chgGrpNm_gui.window[1], false)
guiSetAlpha(chgGrpNm_gui.window[1], 0.90)
guiSetVisible(chgGrpNm_gui.window[1], false)
-- Labels (Static)
chgGrpNm_gui.label[1] = guiCreateLabel(88, 28, 144, 15, "Group Name:", false, chgGrpNm_gui.window[1])
guiSetFont(chgGrpNm_gui.label[1], "default-bold-small")
guiLabelSetColor(chgGrpNm_gui.label[1], 255, 100, 100)
guiLabelSetHorizontalAlign(chgGrpNm_gui.label[1], "center", false)
chgGrpNm_gui.label[3] = guiCreateLabel(88, 72, 144, 15, "New Group Name:", false, chgGrpNm_gui.window[1])
guiSetFont(chgGrpNm_gui.label[3], "default-bold-small")
guiLabelSetColor(chgGrpNm_gui.label[3], 255, 100, 100)
-- Labels (Dynamic)
chgGrpNm_gui.label[2] = guiCreateLabel(8, 46, 306, 15, "Insert Group Name Here", false, chgGrpNm_gui.window[1])
guiSetFont(chgGrpNm_gui.label[2], "clear-normal")
guiLabelSetHorizontalAlign(chgGrpNm_gui.label[2], "center", false)
guiLabelSetHorizontalAlign(chgGrpNm_gui.label[3], "center", false)
-- Edits
chgGrpNm_gui.edit[1] = guiCreateEdit(13, 93, 300, 25, "", false, chgGrpNm_gui.window[1])
guiEditSetMaxLength(chgGrpNm_gui.edit[1], 32)
-- Buttons
chgGrpNm_gui.button[1] = guiCreateButton(69, 126, 83, 23, "Change (1)", false, chgGrpNm_gui.window[1])
guiSetProperty(chgGrpNm_gui.button[1], "NormalTextColour", "FFAAAAAA")
chgGrpNm_gui.button[2] = guiCreateButton(168, 126, 83, 23, "Cancel", false, chgGrpNm_gui.window[1])
guiSetProperty(chgGrpNm_gui.button[2], "NormalTextColour", "FFAAAAAA")

-- Friendly Fire
----------------->>

friendlyFireGUI = {checkbox = {}, window = {}, button = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 342, 158
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 632, 335, 342, 158
friendlyFireGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Group Friendly Fire", false)
guiWindowSetSizable(friendlyFireGUI.window[1], false)
guiSetAlpha(friendlyFireGUI.window[1], 0.90)
guiSetVisible(friendlyFireGUI.window[1], false)
-- Labels
friendlyFireGUI.label[1] = guiCreateLabel(13, 27, 315, 47, "Disabling friendly fire will disallow your group members from killing each other regardless of their job/occupation. Use with caution.", false, friendlyFireGUI.window[1])
guiLabelSetHorizontalAlign(friendlyFireGUI.label[1], "center", true)
friendlyFireGUI.label[2] = guiCreateLabel(9, 71, 324, 15, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", false, friendlyFireGUI.window[1])
friendlyFireGUI.label[3] = guiCreateLabel(9, 106, 324, 15, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", false, friendlyFireGUI.window[1])
-- Checkboxes
friendlyFireGUI.checkbox[1] = guiCreateCheckBox(83, 89, 171, 15, "Disable Group Friendly Fire", false, false, friendlyFireGUI.window[1])
guiSetFont(friendlyFireGUI.checkbox[1], "default-bold-small")
-- Buttons
friendlyFireGUI.button[1] = guiCreateButton(91, 126, 78, 22, "Update", false, friendlyFireGUI.window[1])
friendlyFireGUI.button[2] = guiCreateButton(175, 126, 78, 22, "Close", false, friendlyFireGUI.window[1])

-- Group Blips
----------------->>

groupBlipsGUI = {checkbox = {}, edit = {}, button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 341, 162
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 634, 308, 341, 162
groupBlipsGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Group Blips", false)
guiWindowSetSizable(groupBlipsGUI.window[1], false)
guiSetAlpha(groupBlipsGUI.window[1], 1.00)
guiSetVisible(groupBlipsGUI.window[1], false)
-- Labels
groupBlipsGUI.label[1] = guiCreateLabel(14, 30, 310, 34, "Enabling group blips will allow you to mark all group members on radar.", false, groupBlipsGUI.window[1])
guiLabelSetHorizontalAlign(groupBlipsGUI.label[1], "center", true)
groupBlipsGUI.label[2] = guiCreateLabel(65, 74, 40, 15, "Blip ID:", false, groupBlipsGUI.window[1])
guiSetFont(groupBlipsGUI.label[2], "default-bold-small")
groupBlipsGUI.label[3] = guiCreateLabel(90, 96, 177, 15, "(Valid Blip ID Values: 5-63 — Default: 20)", false, groupBlipsGUI.window[1])
guiSetFont(groupBlipsGUI.label[3], "default-small")
-- Edits
groupBlipsGUI.edit[1] = guiCreateEdit(111, 69, 38, 23, "20", false, groupBlipsGUI.window[1])
-- Checkboxes
groupBlipsGUI.checkbox[1] = guiCreateCheckBox(169, 74, 121, 15, "Enable Group Blips", false, false, groupBlipsGUI.window[1])
-- Buttons
groupBlipsGUI.button[1] = guiCreateButton(101, 118, 64, 24, "Update", false, groupBlipsGUI.window[1])
groupBlipsGUI.button[2] = guiCreateButton(174, 118, 64, 24, "Cancel", false, groupBlipsGUI.window[1])

-- Delete Group
---------------->>

deleteGroupGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 382, 177
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 611, 333, 382, 177
deleteGroupGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Group Deletion", false)
guiWindowSetSizable(deleteGroupGUI.window[1], false)
guiSetAlpha(deleteGroupGUI.window[1], 0.90)
guiSetVisible(deleteGroupGUI.window[1], false)
-- Labels
deleteGroupGUI.label[1] = guiCreateLabel(12, 29, 357, 15, "Are you SURE you want to delete your group?", false, deleteGroupGUI.window[1])
guiLabelSetHorizontalAlign(deleteGroupGUI.label[1], "center", false)
deleteGroupGUI.label[2] = guiCreateLabel(12, 48, 357, 15, "GROUP DELETION CAN NOT BE UNDONE!", false, deleteGroupGUI.window[1])
guiSetFont(deleteGroupGUI.label[2], "default-bold-small")
guiLabelSetColor(deleteGroupGUI.label[2], 255, 25, 25)
guiLabelSetHorizontalAlign(deleteGroupGUI.label[2], "center", false)
deleteGroupGUI.label[3] = guiCreateLabel(12, 72, 357, 15, "Enter your account password:", false, deleteGroupGUI.window[1])
guiLabelSetHorizontalAlign(deleteGroupGUI.label[3], "center", false)
-- Editbox
deleteGroupGUI.edit[1] = guiCreateEdit(34, 91, 318, 24, "", false, deleteGroupGUI.window[1])
guiEditSetMasked(deleteGroupGUI.edit[1], true)
guiEditSetMaxLength(deleteGroupGUI.edit[1], 32)
-- Buttons
deleteGroupGUI.button[1] = guiCreateButton(140, 122, 100, 24, "Cancel", false, deleteGroupGUI.window[1])
guiSetFont(deleteGroupGUI.button[1], "default-bold-small")
guiSetProperty(deleteGroupGUI.button[1], "NormalTextColour", "FFAAAAAA")
deleteGroupGUI.button[2] = guiCreateButton(140, 150, 101, 15, "Delete (5)", false, deleteGroupGUI.window[1])
guiSetProperty(deleteGroupGUI.button[2], "NormalTextColour", "FFAAAAAA")

-- Group Job Restriction
------------------------->>

jobRestrictGUI = { gridlist = {}, window = {}, button = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 393, 360
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY

jobRestrictGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Group Job Restrictions", false)
guiWindowSetSizable(jobRestrictGUI.window[1], false)
guiSetVisible(jobRestrictGUI.window[1], false)

jobRestrictGUI.gridlist[1] = guiCreateGridList(9, 31, 374, 277, false, jobRestrictGUI.window[1])
guiGridListAddColumn(jobRestrictGUI.gridlist[1], "Jobname", 0.5)
guiGridListAddColumn(jobRestrictGUI.gridlist[1], "Enabled/Disabled", 0.5)
jobRestrictGUI.button[1] = guiCreateButton(135, 318, 100, 27, "Close", false, jobRestrictGUI.window[1])
guiSetProperty(jobRestrictGUI.button[1], "NormalTextColour", "FFAAAAAA")    
   
