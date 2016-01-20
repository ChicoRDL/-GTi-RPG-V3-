----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 11 Jun 2014
-- Resource: GTIgroupPanel/panel_gui.lua
-- Version: 1.5
----------------------------------------->>

-- Group Panel GUI
------------------->>

groupPanel = {tab = {}, tabpanel = {}, label = {}, gridlist = {}, window = {}, button = {}, memo = {}, scrollpane = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 685, 452
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 458, 220, 685, 452
groupPanel.window[1] = guiCreateWindow(sX, sY, wX, wY, "Unnamed Group — GTI Group Panel", false)
guiWindowSetSizable(groupPanel.window[1], false)
guiSetAlpha(groupPanel.window[1], 0.8)
guiSetVisible(groupPanel.window[1], false)
-- Tab Panel
groupPanel.tabpanel[1] = guiCreateTabPanel(9, 24, 667, 418, false, groupPanel.window[1])

-- Home Tab -->>

groupPanel.tab[1] = guiCreateTab("Home", groupPanel.tabpanel[1])
-- Labels (Static)
groupPanel.label[1] = guiCreateLabel(13, 10, 76, 15, "Group Name:", false, groupPanel.tab[1])
guiSetFont(groupPanel.label[1], "default-bold-small")
guiLabelSetColor(groupPanel.label[1], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[1], "right", false)
groupPanel.label[2] = guiCreateLabel(343, 10, 82, 15, "Creation Date:", false, groupPanel.tab[1])
guiSetFont(groupPanel.label[2], "default-bold-small")
guiLabelSetColor(groupPanel.label[2], 255, 100, 100)
groupPanel.label[5] = guiCreateLabel(5, 56, 653, 15, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", false, groupPanel.tab[1])
guiSetFont(groupPanel.label[5], "default-small")
-- Labels (Dynamic)
groupPanel.label[3] = guiCreateLabel(96, 10, 233, 15, "", false, groupPanel.tab[1])     -- Group Name
groupPanel.label[4] = guiCreateLabel(434, 10, 216, 15, "", false, groupPanel.tab[1])    -- Creation Date
groupPanel.label[6] = guiCreateLabel(6, 35, 652, 15, "", false, groupPanel.tab[1])      -- News Feed
guiSetFont(groupPanel.label[6], "clear-normal")
guiLabelSetColor(groupPanel.label[6], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[6], "center", false)
-- Memo
groupPanel.memo[1] = guiCreateMemo(7, 75, 652, 310, "There doesn't appear to be any text here! The group leader should edit this text and put something here. All settings can be found in the admin tab.", false, groupPanel.tab[1])
guiMemoSetReadOnly(groupPanel.memo[1], true)
--guiSetFont(groupPanel.memo[1], "clear-normal")
--guiSetProperty(groupPanel.memo[1], "Font", "clear-normal")

-- Members Tab -->>

groupPanel.tab[2] = guiCreateTab("Members", groupPanel.tabpanel[1])
-- Labels (Static)
groupPanel.label[7] = guiCreateLabel(13, 11, 90, 15, "Total Members:", false, groupPanel.tab[2])
guiSetFont(groupPanel.label[7], "default-bold-small")
guiLabelSetColor(groupPanel.label[7], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[7], "right", false)
groupPanel.label[9] = guiCreateLabel(17, 36, 87, 15, "Group Rank:", false, groupPanel.tab[2])
guiSetFont(groupPanel.label[9], "default-bold-small")
guiLabelSetColor(groupPanel.label[9], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[9], "right", false)
groupPanel.label[11] = guiCreateLabel(326, 11, 84, 15, "Member Since:", false, groupPanel.tab[2])
guiSetFont(groupPanel.label[11], "default-bold-small")
guiLabelSetColor(groupPanel.label[11], 255, 100, 100)
groupPanel.label[13] = guiCreateLabel(7, 54, 653, 15, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", false, groupPanel.tab[2])
guiSetFont(groupPanel.label[13], "default-small")
-- Labels (Dynamic)
groupPanel.label[8] = guiCreateLabel(109, 11, 60, 15, "...", false, groupPanel.tab[2])  -- Total Members
guiSetFont(groupPanel.label[8], "clear-normal")
groupPanel.label[10] = guiCreateLabel(109, 36, 184, 15, "...", false, groupPanel.tab[2])    -- Group Rank
guiSetFont(groupPanel.label[10], "clear-normal")
groupPanel.label[12] = guiCreateLabel(418, 10, 217, 15, "...", false, groupPanel.tab[2])    -- Member Since
guiSetFont(groupPanel.label[12], "clear-normal")
-- Buttons
groupPanel.button[1] = guiCreateButton(7, 365, 125, 20, "Invite Member...", false, groupPanel.tab[2])
guiSetProperty(groupPanel.button[1], "NormalTextColour", "FFAAAAAA")
groupPanel.button[2] = guiCreateButton(535, 365, 125, 20, "Leave Group", false, groupPanel.tab[2])
guiSetProperty(groupPanel.button[2], "NormalTextColour", "FFAAAAAA")
groupPanel.button[3] = guiCreateButton(403, 365, 125, 20, "View Stats", false, groupPanel.tab[2])
guiSetProperty(groupPanel.button[3], "NormalTextColour", "FFAAAAAA")
groupPanel.button[4] = guiCreateButton(271, 365, 125, 20, "Change Rank", false, groupPanel.tab[2])
guiSetProperty(groupPanel.button[4], "NormalTextColour", "FFAAAAAA")
groupPanel.button[5] = guiCreateButton(139, 365, 125, 20, "Remove Member", false, groupPanel.tab[2])
guiSetProperty(groupPanel.button[5], "NormalTextColour", "FFAAAAAA")
-- Gridlist
groupPanel.gridlist[1] = guiCreateGridList(8, 70, 651, 289, false, groupPanel.tab[2])
guiGridListSetSortingEnabled(groupPanel.gridlist[1], false)
guiGridListAddColumn(groupPanel.gridlist[1], "Member Name", 0.3)
guiGridListAddColumn(groupPanel.gridlist[1], "Account Name", 0.3)
guiGridListAddColumn(groupPanel.gridlist[1], "Rank", 0.2)
guiGridListAddColumn(groupPanel.gridlist[1], "Last Active", 0.13)
guiGridListAddColumn(groupPanel.gridlist[1], "", 0.03)

-- Stats Tab -->>

groupPanel.tab[3] = guiCreateTab("Stats", groupPanel.tabpanel[1])
-- Labels (Static)
groupPanel.label[14] = guiCreateLabel(6, 49, 653, 15, "_____________________________________________________________________________________________________", false, groupPanel.tab[3])
groupPanel.label[15] = guiCreateLabel(6, 100, 653, 15, "_____________________________________________________________________________________________________", false, groupPanel.tab[3])
groupPanel.label[16] = guiCreateLabel(9, 21, 98, 15, "Group Level:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[16], "clear-normal")
guiLabelSetHorizontalAlign(groupPanel.label[16], "right", false)
groupPanel.label[17] = guiCreateLabel(235, 21, 75, 15, "Experience:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[17], "clear-normal")
groupPanel.label[18] = guiCreateLabel(7, 130, 153, 15, "Founded:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[18], "default-bold-small")
guiLabelSetColor(groupPanel.label[18], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[18], "right", false)
groupPanel.label[20] = guiCreateLabel(7, 165, 153, 15, "Total Collective Playtime:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[20], "default-bold-small")
guiLabelSetColor(groupPanel.label[20], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[20], "right", false)
groupPanel.label[22] = guiCreateLabel(7, 200, 153, 15, "Group Kills:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[22], "default-bold-small")
guiLabelSetColor(groupPanel.label[22], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[22], "right", false)
groupPanel.label[24] = guiCreateLabel(7, 235, 153, 15, "Total Turfs Taken:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[24], "default-bold-small")
guiLabelSetColor(groupPanel.label[24], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[24], "right", false)
groupPanel.label[26] = guiCreateLabel(7, 270, 153, 15, "Total Arrests:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[26], "default-bold-small")
guiLabelSetColor(groupPanel.label[26], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[26], "right", false)
groupPanel.label[28] = guiCreateLabel(342, 130, 153, 15, "Number of Members:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[28], "default-bold-small")
guiLabelSetColor(groupPanel.label[28], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[28], "right", false)
groupPanel.label[30] = guiCreateLabel(342, 165, 153, 15, "Bank Account Balance:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[30], "default-bold-small")
guiLabelSetColor(groupPanel.label[30], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[30], "right", false)
groupPanel.label[32] = guiCreateLabel(342, 200, 153, 15, "Group Deaths:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[32], "default-bold-small")
guiLabelSetColor(groupPanel.label[32], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[32], "right", false)
groupPanel.label[34] = guiCreateLabel(332, 110, 15, 277-25, "|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ", false, groupPanel.tab[3])
guiLabelSetHorizontalAlign(groupPanel.label[34], "left", true)
groupPanel.label[35] = guiCreateLabel(332, 116, 15, 271-25, "|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ", false, groupPanel.tab[3])
guiLabelSetHorizontalAlign(groupPanel.label[35], "left", true)
groupPanel.label[36] = guiCreateLabel(342, 235, 153, 15, "Total Turfs Defended:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[36], "default-bold-small")
guiLabelSetColor(groupPanel.label[36], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[36], "right", false)
groupPanel.label[38] = guiCreateLabel(342, 270, 153, 15, "Total Arrest Points:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[38], "default-bold-small")
guiLabelSetColor(groupPanel.label[38], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[38], "right", false)
groupPanel.label[40] = guiCreateLabel(7, 305, 153, 15, "Lifetime Income:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[40], "default-bold-small")
guiLabelSetColor(groupPanel.label[40], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[40], "right", false)
groupPanel.label[42] = guiCreateLabel(342, 305, 153, 15, "Lifetime Expenses:", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[42], "default-bold-small")
guiLabelSetColor(groupPanel.label[42], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[42], "right", false)
-- Labels (Dynamic)
groupPanel.label[19] = guiCreateLabel(169, 130, 154, 15, "...", false, groupPanel.tab[3])   -- Founded
guiSetFont(groupPanel.label[19], "clear-normal")
groupPanel.label[21] = guiCreateLabel(169, 165, 154, 15, "0 hours", false, groupPanel.tab[3])   -- Total Collective Playtime
guiSetFont(groupPanel.label[21], "clear-normal")
groupPanel.label[23] = guiCreateLabel(169, 200, 154, 15, "0", false, groupPanel.tab[3]) -- Group Kills
guiSetFont(groupPanel.label[23], "clear-normal")
groupPanel.label[25] = guiCreateLabel(169, 235, 154, 15, "0", false, groupPanel.tab[3]) -- Total Turfs Taken
guiSetFont(groupPanel.label[25], "clear-normal")
groupPanel.label[27] = guiCreateLabel(169, 270, 154, 15, "0", false, groupPanel.tab[3]) -- Total Arrests
guiSetFont(groupPanel.label[27], "clear-normal")
groupPanel.label[29] = guiCreateLabel(504, 130, 154, 15, "0", false, groupPanel.tab[3]) -- Number of Members
guiSetFont(groupPanel.label[29], "clear-normal")
groupPanel.label[31] = guiCreateLabel(504, 165, 154, 15, "$0", false, groupPanel.tab[3])    -- Bank Account Balance
guiSetFont(groupPanel.label[31], "clear-normal")
groupPanel.label[33] = guiCreateLabel(504, 200, 154, 15, "0", false, groupPanel.tab[3]) -- Group Deaths
guiSetFont(groupPanel.label[33], "clear-normal")
groupPanel.label[37] = guiCreateLabel(504, 235, 154, 15, "0", false, groupPanel.tab[3]) -- Total Turfs Defended
guiSetFont(groupPanel.label[37], "clear-normal")
groupPanel.label[39] = guiCreateLabel(504, 270, 154, 15, "0", false, groupPanel.tab[3]) -- Total Arrest Points
guiSetFont(groupPanel.label[39], "clear-normal")
groupPanel.label[41] = guiCreateLabel(169, 305, 154, 15, "$0", false, groupPanel.tab[3])    -- Lifetime Income
guiSetFont(groupPanel.label[41], "clear-normal")
groupPanel.label[43] = guiCreateLabel(504, 305, 154, 15, "$0", false, groupPanel.tab[3])    -- Lifetime Expenses
guiSetFont(groupPanel.label[43], "clear-normal")

groupPanel.label[100] = guiCreateLabel(10, 365, 647, 15, "The earliest that your group can level up is <date>", false, groupPanel.tab[3])
guiSetFont(groupPanel.label[100], "default-bold-small")
guiLabelSetColor(groupPanel.label[100], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[100], "center", false)

-- History Tab -->>

groupPanel.tab[4] = guiCreateTab("History", groupPanel.tabpanel[1])
-- Gridlist
groupPanel.gridlist[2] = guiCreateGridList(7, 6, 653, 379, false, groupPanel.tab[4])
guiGridListSetSortingEnabled(groupPanel.gridlist[2], false)
guiGridListAddColumn(groupPanel.gridlist[2], "Date", 0.15)
guiGridListAddColumn(groupPanel.gridlist[2], "Time", 0.12)
guiGridListAddColumn(groupPanel.gridlist[2], "Log Text", 0.7)

-- Admin Tab -->>

groupPanel.tab[5] = guiCreateTab("Admin", groupPanel.tabpanel[1])
-- Labels (Non-Pane)
groupPanel.label[52] = guiCreateLabel(223, 10, 228, 15, "GTI Group Admin Panel", false, groupPanel.tab[5])
guiSetFont(groupPanel.label[52], "default-bold-small")
guiLabelSetColor(groupPanel.label[52], 255, 100, 100)
guiLabelSetHorizontalAlign(groupPanel.label[52], "center", false)
-- Scrollpane
groupPanel.scrollpane[1] = guiCreateScrollPane(8, 30, 651, 353, false, groupPanel.tab[5])

local admin_tab = {
    {"Group Chat",          "Administrate the group chat by muting members or only allowing those of a certain rank to speak."},
    {"Group Information",   "Modify the group information that appears on the Home tab."},
    {"Group Reminders",     "Modify the messages that appear on the News bar above the Group Info box."},
    {"Manage Ranks",        "Manage player ranks and their permissions."},
    {"View Applications",   "View and manage all submitted group applications. Applications can be accepted and denied from this panel."},
    {"Manage Applications", "Set up or modify your group application format. Players can use this to apply to your group."},
    {"Change Group Name",   "Change the name of your group to something else."},
    {"Group Tags",          "L5+ Only. Manage automatic group name tagging. Includes both group and rank-based tagging, as well as name tag protection."},
    {"Group Color",         "Change your group color. Group color will modify the color of the group panel and group chat."},
    {"Friendly Fire",       "Toggle Group Friendly fire (The ability to kill your own group members)."},
    {"Properties & Assets", "View and manage group-owned properties and assets."},
    {"Diplomacy",           "Manage relations with other groups."},
    {"Group Blips",         "Toggle Group Blips."},
    {"Delete Group",        "Group Leader Only. Kick all members and delete your group."},
    --{"Job Restrictions",    "Restrict some jobs to your group. Group members won't be able to take that job."},
}

for i,v in ipairs(admin_tab) do
    -- Buttons
    groupPanel.button[i+5] = guiCreateButton(3, 3+(35*(i-1)), 150, 25, v[1], false, groupPanel.scrollpane[1])
    guiSetProperty(groupPanel.button[i+5], "NormalTextColour", "FFAAAAAA")
    -- Labels
    groupPanel.label[i+52] = guiCreateLabel(163, 0+(35*(i-1)), 465, 30, v[2], false, groupPanel.scrollpane[1])
    guiLabelSetHorizontalAlign(groupPanel.label[i+52], "left", true)
    guiLabelSetVerticalAlign(groupPanel.label[i+52], "center")
end

-- Group List Tab -->>
groupPanel.tab[6] = guiCreateTab("Group List", groupPanel.tabpanel[1])
-- Gridlist
groupPanel.gridlist[10] = guiCreateGridList(8, 11, 649, 365, false, groupPanel.tab[6])
guiGridListSetSortingEnabled(groupPanel.gridlist[10], false)
gnameC = guiGridListAddColumn(groupPanel.gridlist[10], "Group Name", 0.3)
membersC = guiGridListAddColumn(groupPanel.gridlist[10], "Total Members", 0.3)
expC = guiGridListAddColumn(groupPanel.gridlist[10], "Group Experience", 0.2)
dateC = guiGridListAddColumn(groupPanel.gridlist[10], "Creation Date", 0.13)
