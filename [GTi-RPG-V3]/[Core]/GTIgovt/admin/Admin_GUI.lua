----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 10 Aug 2014
-- Resource: GTIadmin/gui/admin_gui.lua
-- Version: 1.0
----------------------------------------->>

adminGUI = {tab = {}, tabpanel = {}, edit = {}, staticimage = {}, button = {}, window = {}, label = {}, label2 = {}, gridlist = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 625, 525
local sX, sY, wX, wY = (sX/3)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 491, 194, 625, 525
adminGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Grand Theft International (GTi) -|- gtirpg.net   —  64/512", false)
guiWindowSetSizable(adminGUI.window[1], false)
guiSetAlpha(adminGUI.window[1], 0.90)
guiSetVisible(adminGUI.window[1], false)
-- Tab Panel
adminGUI.tabpanel[1] = guiCreateTabPanel(9, 23, 607, 493, false, adminGUI.window[1])

adminGUI.tab[1] = guiCreateTab("Admin", adminGUI.tabpanel[1])
-- Gridlist
adminGUI.gridlist[1] = guiCreateGridList(10, 40, 150, 418, false, adminGUI.tab[1])
guiGridListAddColumn(adminGUI.gridlist[1], "Player List", 0.85)
guiGridListSetSortingEnabled(adminGUI.gridlist[1], false)
-- Editbox
adminGUI.edit[1] = guiCreateEdit(10, 9, 123, 24, "Search...", false, adminGUI.tab[1])
-- Static Image
adminGUI.staticimage[2] = guiCreateStaticImage(135, 9, 25, 25, "images/search.png", false, adminGUI.tab[1])
-- Labels (Static)
adminGUI.label[1] = guiCreateLabel(165, 10, 110, 15, "Player Information", false, adminGUI.tab[1])
guiSetFont(adminGUI.label[1], "default-bold-small")
guiLabelSetColor(adminGUI.label[1], 0, 190, 255)
adminGUI.label[2] = guiCreateLabel(166, 91, 32, 15, "Serial:", false, adminGUI.tab[1])
adminGUI.label[4] = guiCreateLabel(166, 31, 37, 15, "Player:", false, adminGUI.tab[1])
adminGUI.label[6] = guiCreateLabel(166, 51, 51, 15, "Account:", false, adminGUI.tab[1])
adminGUI.label[8] = guiCreateLabel(166, 71, 16, 15, "IP:", false, adminGUI.tab[1])
adminGUI.label[11] = guiCreateLabel(166, 111, 43, 15, "Version:", false, adminGUI.tab[1])
adminGUI.label[13] = guiCreateLabel(166, 131, 67, 15, "ACL Groups:", false, adminGUI.tab[1])
adminGUI.label[15] = guiCreateLabel(166, 151, 74, 15, "AC Detected:", false, adminGUI.tab[1])
adminGUI.label[17] = guiCreateLabel(166, 171, 85, 15, "gta3.img mods:", false, adminGUI.tab[1])
adminGUI.label[19] = guiCreateLabel(164, 182, 279, 15, "________________________________________________________________________", false, adminGUI.tab[1])
guiSetFont(adminGUI.label[19], "default-bold-small")
guiLabelSetColor(adminGUI.label[19], 0, 190, 255)
adminGUI.label[20] = guiCreateLabel(165, 201, 110, 15, "Game Information", false, adminGUI.tab[1])
guiSetFont(adminGUI.label[20], "default-bold-small")
guiLabelSetColor(adminGUI.label[20], 0, 190, 255)
adminGUI.label[21] = guiCreateLabel(167, 220, 39, 15, "Health:", false, adminGUI.tab[1])
adminGUI.label[23] = guiCreateLabel(279, 220, 39, 15, "Armor:", false, adminGUI.tab[1])
adminGUI.label[25] = guiCreateLabel(382, 220, 28, 15, "Ping:", false, adminGUI.tab[1])
adminGUI.label[27] = guiCreateLabel(167, 240, 36, 15, "Team:", false, adminGUI.tab[1])
adminGUI.label[29] = guiCreateLabel(368, 240, 42, 15, "Skin ID:", false, adminGUI.tab[1])
adminGUI.label[31] = guiCreateLabel(167, 260, 50, 15, "Weapon:", false, adminGUI.tab[1])
adminGUI.label[33] = guiCreateLabel(167, 280, 30, 15, "Cash:", false, adminGUI.tab[1])
adminGUI.label[35] = guiCreateLabel(302, 280, 30, 15, "Bank:", false, adminGUI.tab[1])
adminGUI.label[37] = guiCreateLabel(167, 300, 50, 15, "Location:", false, adminGUI.tab[1])
adminGUI.label[39] = guiCreateLabel(167, 320, 42, 15, "Coords:", false, adminGUI.tab[1])
adminGUI.label[41] = guiCreateLabel(167, 340, 23, 15, "Job:", false, adminGUI.tab[1])
adminGUI.label[43] = guiCreateLabel(303, 340, 43, 15, "Division:", false, adminGUI.tab[1])
adminGUI.label[45] = guiCreateLabel(167, 360, 39, 15, "Group:", false, adminGUI.tab[1])
adminGUI.label[47] = guiCreateLabel(377, 31, 23, 15, "WL:", false, adminGUI.tab[1])
adminGUI.label[49] = guiCreateLabel(164, 370, 280, 15, "________________________________________________", false, adminGUI.tab[1])
guiSetFont(adminGUI.label[49], "default-bold-small")
guiLabelSetColor(adminGUI.label[49], 0, 190, 255)
adminGUI.label[50] = guiCreateLabel(165, 389, 110, 15, "Vehicle Information", false, adminGUI.tab[1])
guiSetFont(adminGUI.label[50], "default-bold-small")
guiLabelSetColor(adminGUI.label[50], 0, 190, 255)
adminGUI.label[51] = guiCreateLabel(167, 410, 44, 15, "Vehicle:", false, adminGUI.tab[1])
adminGUI.label[53] = guiCreateLabel(167, 430, 81, 15, "Vehicle Health:", false, adminGUI.tab[1])
-- Labels (Dynamic)
adminGUI.label2[3] = guiCreateLabel(202, 91, 231, 15, "ABCDEFABCDEFABCDEFABCDEFABCDEFAB", false, adminGUI.tab[1])
adminGUI.label2[5] = guiCreateLabel(207, 31, 141, 15, "[ABC]Player>123", false, adminGUI.tab[1])
adminGUI.label2[7] = guiCreateLabel(222, 51, 126, 15, "AccountName", false, adminGUI.tab[1])
adminGUI.label2[9] = guiCreateLabel(186, 71, 97, 15, "255.255.255.255", false, adminGUI.tab[1])
adminGUI.label2[10] = guiCreateLabel(309, 70, 20, 15, "XY", false, adminGUI.tab[1])
adminGUI.label2[12] = guiCreateLabel(214, 111, 91, 15, "1.4.0-1.01234.0", false, adminGUI.tab[1])
adminGUI.label2[14] = guiCreateLabel(239, 131, 194, 15, "GroupA, GroupB, GroupC, GroupD", false, adminGUI.tab[1])
adminGUI.label2[16] = guiCreateLabel(244, 151, 189, 15, "12, 14, 15, 16, 20, 22, 28", false, adminGUI.tab[1])
adminGUI.label2[18] = guiCreateLabel(257, 171, 29, 15, "2048", false, adminGUI.tab[1])
adminGUI.label2[22] = guiCreateLabel(211, 220, 39, 15, "100%", false, adminGUI.tab[1])
adminGUI.label2[24] = guiCreateLabel(321, 220, 39, 15, "100%", false, adminGUI.tab[1])
adminGUI.label2[26] = guiCreateLabel(415, 220, 29, 15, "2048", false, adminGUI.tab[1])
adminGUI.label2[28] = guiCreateLabel(208, 240, 152, 15, "General Population", false, adminGUI.tab[1])
adminGUI.label2[30] = guiCreateLabel(415, 240, 29, 15, "128", false, adminGUI.tab[1])
adminGUI.label2[32] = guiCreateLabel(224, 260, 220, 15, "Fist (ID: 0 - Ammo: 0)", false, adminGUI.tab[1])
adminGUI.label2[34] = guiCreateLabel(200, 280, 95, 15, "$536,870,912", false, adminGUI.tab[1])
adminGUI.label2[36] = guiCreateLabel(337, 280, 106, 15, "$2,147,483,648", false, adminGUI.tab[1])
adminGUI.label2[38] = guiCreateLabel(222, 300, 222, 15, "Unknown, Unknown", false, adminGUI.tab[1])
adminGUI.label2[40] = guiCreateLabel(214, 320, 230, 15, "65536.128, 65536.128, 65536.128, 180.000", false, adminGUI.tab[1])
adminGUI.label2[42] = guiCreateLabel(196, 340, 101, 15, "Staff Minister", false, adminGUI.tab[1])
adminGUI.label2[44] = guiCreateLabel(351, 340, 93, 15, "None", false, adminGUI.tab[1])
adminGUI.label2[46] = guiCreateLabel(211, 360, 233, 15, "Group Name", false, adminGUI.tab[1])
adminGUI.label2[48] = guiCreateLabel(404, 31, 37, 15, "8192", false, adminGUI.tab[1])
adminGUI.label2[52] = guiCreateLabel(216, 410, 227, 15, "An-dro-MADA (ID: 128)", false, adminGUI.tab[1])
adminGUI.label2[54] = guiCreateLabel(254, 430, 46, 15, "100.0%", false, adminGUI.tab[1])
for i,label in pairs(adminGUI.label2) do
	guiLabelSetColor(label, 0, 190, 255)
end
-- Buttons
adminGUI.button[2] = guiCreateButton(450, 30, 150, 20, "Issue Punishment", false, adminGUI.tab[1])
adminGUI.button[3] = guiCreateButton(450, 55, 150, 20, "Warp me to Player", false, adminGUI.tab[1])
adminGUI.button[4] = guiCreateButton(450, 80, 150, 20, "Warp Player to...", false, adminGUI.tab[1])
adminGUI.button[5] = guiCreateButton(450, 105, 72, 20, "Spectate", false, adminGUI.tab[1])
adminGUI.button[6] = guiCreateButton(527, 105, 72, 20, "Slap", false, adminGUI.tab[1])
adminGUI.button[7] = guiCreateButton(450, 130, 72, 20, "Rename", false, adminGUI.tab[1])
adminGUI.button[8] = guiCreateButton(527, 130, 72, 20, "Freeze", false, adminGUI.tab[1])
adminGUI.button[9] = guiCreateButton(450, 155, 72, 20, "Shout", false, adminGUI.tab[1])
adminGUI.button[10] = guiCreateButton(527, 155, 72, 20, "Reconnect", false, adminGUI.tab[1])
adminGUI.button[11] = guiCreateButton(450, 200, 72, 20, "Set Health", false, adminGUI.tab[1])
adminGUI.button[12] = guiCreateButton(527, 200, 72, 20, "Set Armor", false, adminGUI.tab[1])
adminGUI.button[13] = guiCreateButton(450, 225, 72, 20, "Set Skin", false, adminGUI.tab[1])
adminGUI.button[14] = guiCreateButton(527, 225, 72, 20, "Set Money", false, adminGUI.tab[1])
adminGUI.button[15] = guiCreateButton(450, 250, 72, 20, "Set Int.", false, adminGUI.tab[1])
adminGUI.button[16] = guiCreateButton(527, 250, 72, 20, "Set Dim.", false, adminGUI.tab[1])
adminGUI.button[17] = guiCreateButton(450, 275, 72, 20, "View Ammo", false, adminGUI.tab[1])
adminGUI.button[18] = guiCreateButton(527, 275, 72, 20, "Records", false, adminGUI.tab[1])
adminGUI.button[19] = guiCreateButton(450, 300, 150, 20, "Give Jetpack", false, adminGUI.tab[1])
adminGUI.button[20] = guiCreateButton(450, 325, 150, 20, "Give Weapon", false, adminGUI.tab[1])
adminGUI.button[21] = guiCreateButton(450, 350, 150, 20, "Screenshot", false, adminGUI.tab[1])
adminGUI.button[22] = guiCreateButton(450, 390, 150, 20, "Spawn Vehicle", false, adminGUI.tab[1])
adminGUI.button[23] = guiCreateButton(450, 415, 150, 20, "Repair Vehicle", false, adminGUI.tab[1])
adminGUI.button[24] = guiCreateButton(450, 440, 72, 20, "Destroy", false, adminGUI.tab[1])
adminGUI.button[25] = guiCreateButton(527, 440, 72, 20, "Blow", false, adminGUI.tab[1])
for i=2,#adminGUI.button do
	guiSetFont(adminGUI.button[i], "default-bold-small")
	guiSetProperty(adminGUI.button[i], "NormalTextColour", "FFAAAAAA")
end
guiSetProperty(adminGUI.button[2], "NormalTextColour", "FF00BEFF")

-- Punishment Window
--------------------->>

adminPunishGUI = {checkbox = {}, edit = {}, button = {}, window = {}, label = {}, combobox = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 325, 350
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 641, 224, 325, 350
adminPunishGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Issue Punishment", false)
guiWindowSetSizable(adminPunishGUI.window[1], false)
guiSetAlpha(adminPunishGUI.window[1], 1)
guiSetVisible(adminPunishGUI.window[1], false)
-- Labels
adminPunishGUI.label[1] = guiCreateLabel(11, 25, 132, 15, "Punishment Reason:", false, adminPunishGUI.window[1])
adminPunishGUI.label[2] = guiCreateLabel(11, 73, 146, 15, "Or enter a custom reason:", false, adminPunishGUI.window[1])
adminPunishGUI.label[3] = guiCreateLabel(8, 112, 311, 15, "___________________________________________________", false, adminPunishGUI.window[1])
adminPunishGUI.label[4] = guiCreateLabel(14, 151, 59, 15, "Minutes:", false, adminPunishGUI.window[1])
guiLabelSetHorizontalAlign(adminPunishGUI.label[4], "right", false)
adminPunishGUI.label[5] = guiCreateLabel(14, 193, 59, 15, "Hours:", false, adminPunishGUI.window[1])
guiLabelSetHorizontalAlign(adminPunishGUI.label[5], "right", false)
adminPunishGUI.label[6] = guiCreateLabel(14, 235, 59, 15, "Days:", false, adminPunishGUI.window[1])
guiLabelSetHorizontalAlign(adminPunishGUI.label[6], "right", false)
adminPunishGUI.label[7] = guiCreateLabel(165, 140, 147, 15, "Punishment Type", false, adminPunishGUI.window[1])
guiSetFont(adminPunishGUI.label[7], "default-bold-small")
guiLabelSetHorizontalAlign(adminPunishGUI.label[7], "center", false)
for i,label in pairs(adminPunishGUI.label) do
	guiLabelSetColor(label, 0, 190, 255)
end
-- Comboboxes
adminPunishGUI.combobox[1] = guiCreateComboBox(10, 44, 306, 23, "", false, adminPunishGUI.window[1])	-- Punishment Reason
adminPunishGUI.combobox[2] = guiCreateComboBox(162, 158, 151, 23, "", false, adminPunishGUI.window[1])	-- Punishment Type
-- Editboxes
adminPunishGUI.edit[1] = guiCreateEdit(10, 91, 306, 25, "", false, adminPunishGUI.window[1])	-- Custom Reason
adminPunishGUI.edit[2] = guiCreateEdit(80, 144, 73, 29, "", false, adminPunishGUI.window[1])	-- Minutes
adminPunishGUI.edit[3] = guiCreateEdit(80, 184, 73, 29, "", false, adminPunishGUI.window[1])	-- Hours
adminPunishGUI.edit[4] = guiCreateEdit(80, 228, 73, 29, "", false, adminPunishGUI.window[1])	-- Days
-- Checkbox
adminPunishGUI.checkbox[1] = guiCreateCheckBox(12, 272, 304, 15, "Use Default Duration (2 minutes)", false, false, adminPunishGUI.window[1])
-- Buttons
adminPunishGUI.button[1] = guiCreateButton(13, 302, 88, 36, "Punish", false, adminPunishGUI.window[1])
guiSetFont(adminPunishGUI.button[1], "default-bold-small")
guiSetProperty(adminPunishGUI.button[1], "NormalTextColour", "FF00BEFF")
adminPunishGUI.button[2] = guiCreateButton(120, 302, 88, 36, "Remove\nPunishment", false, adminPunishGUI.window[1])
adminPunishGUI.button[3] = guiCreateButton(227, 302, 88, 36, "Cancel", false, adminPunishGUI.window[1])

-- Warp Player To..
-------------------->>

adminWarp = {edit = {}, button = {}, window = {}, label = {}, gridlist = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 245, 350
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 675, 253, 245, 350
adminWarp.window[1] = guiCreateWindow(675, 253, 245, 350, "Warp Player To...", false)
guiWindowSetSizable(adminWarp.window[1], false)
guiSetAlpha(adminWarp.window[1], 1.00)
guiSetVisible(adminWarp.window[1], false)
-- Editbox
adminWarp.edit[1] = guiCreateEdit(9, 24, 200, 25, "", false, adminWarp.window[1])
-- Buttons
adminWarp.button[1] = guiCreateButton(9, 289, 227, 23, "Warp Player to Me", false, adminWarp.window[1])
adminWarp.button[2] = guiCreateButton(9, 317, 227, 23, "Warp Player to Selected Player", false, adminWarp.window[1])
-- Label
adminWarp.label[1] = guiCreateLabel(216, 28, 18, 15, "[X]", false, adminWarp.window[1])
guiSetFont(adminWarp.label[1], "clear-normal")
-- Gridlist
adminWarp.gridlist[1] = guiCreateGridList(9, 55, 227, 229, false, adminWarp.window[1])
guiGridListAddColumn(adminWarp.gridlist[1], "Player Selection List", 0.9)
guiGridListSetSortingEnabled(adminWarp.gridlist[1], false)

-- Execute Admin Function
-------------------------->>

adminExe = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 318, 123
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 648, 351, 318, 123
adminExe.window[1] = guiCreateWindow(sX, sY, wX, wY, "Execute Admin Function", false)
guiWindowSetSizable(adminExe.window[1], false)
guiSetAlpha(adminExe.window[1], 1.00)
guiSetVisible(adminExe.window[1], false)
-- Label
adminExe.label[1] = guiCreateLabel(9, 28, 300, 15, "Enter the amount of HP", false, adminExe.window[1])
guiSetFont(adminExe.label[1], "clear-normal")
guiLabelSetHorizontalAlign(adminExe.label[1], "center", false)
-- Editbox
adminExe.edit[1] = guiCreateEdit(9, 50, 300, 24, "", false, adminExe.window[1])
-- Buttons
adminExe.button[1] = guiCreateButton(81, 81, 71, 26, "Execute", false, adminExe.window[1])
adminExe.button[2] = guiCreateButton(163, 81, 71, 26, "Cancel", false, adminExe.window[1])

-- View Weapons
---------------->>

viewWeapons = {gridlist = {}, window = {}, button = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 232, 292
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 687, 297, 232, 292
viewWeapons.window[1] = guiCreateWindow(sX, sY, wX, wY, "Weapons List", false)
guiWindowSetSizable(viewWeapons.window[1], false)
guiSetAlpha(viewWeapons.window[1], 1.00)
guiSetVisible(viewWeapons.window[1], false)
-- Labels
viewWeapons.label[1] = guiCreateLabel(9, 24, 212, 15, "[ABC]Player>123's Weapons", false, viewWeapons.window[1])
guiLabelSetHorizontalAlign(viewWeapons.label[1], "center", false)
-- Gridlist
viewWeapons.gridlist[1] = guiCreateGridList(9, 44, 214, 212, false, viewWeapons.window[1])
guiGridListAddColumn(viewWeapons.gridlist[1], "Weapon Name", 0.65)
guiGridListAddColumn(viewWeapons.gridlist[1], "Ammo", 0.20)
guiGridListSetSortingEnabled(viewWeapons.gridlist[1], false)
-- Button
viewWeapons.button[1] = guiCreateButton(73, 261, 90, 23, "Close", false, viewWeapons.window[1])
guiSetProperty(viewWeapons.button[1], "NormalTextColour", "FFAAAAAA")

-- Give Weapon
--------------->>

giveWeaponGUI = {gridlist = {}, window = {}, button = {}, edit = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 236, 336
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 678, 278, 236, 336
giveWeaponGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Give Weapon", false)
guiWindowSetSizable(giveWeaponGUI.window[1], false)
guiSetAlpha(giveWeaponGUI.window[1], 1.00)
guiSetVisible(giveWeaponGUI.window[1], false)
-- Gridlist
giveWeaponGUI.gridlist[1] = guiCreateGridList(9, 23, 218, 278, false, giveWeaponGUI.window[1])
guiGridListAddColumn(giveWeaponGUI.gridlist[1], "Weapons List", 0.85)
guiGridListSetSortingEnabled(giveWeaponGUI.gridlist[1], false)
-- Editbox
giveWeaponGUI.edit[1] = guiCreateEdit(9, 305, 58, 22, "90", false, giveWeaponGUI.window[1])
-- Button
giveWeaponGUI.button[1] = guiCreateButton(73, 305, 74, 22, "Give", false, giveWeaponGUI.window[1])
guiSetProperty(giveWeaponGUI.button[1], "NormalTextColour", "FFAAAAAA")
giveWeaponGUI.button[2] = guiCreateButton(153, 305, 74, 22, "Close", false, giveWeaponGUI.window[1])
guiSetProperty(giveWeaponGUI.button[2], "NormalTextColour", "FFAAAAAA")
