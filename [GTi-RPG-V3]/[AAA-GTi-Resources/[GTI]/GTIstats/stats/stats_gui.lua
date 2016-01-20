----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 03 Feb 2015
-- Resource: GTIstats/stats_gui.lua
-- Version: 1.0
----------------------------------------->>

statsGUI = {tab = {}, staticimage = {}, edit = {}, window = {}, tabpanel = {}, button = {}, label = {}, scrollpane = {}, gridlist = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 625, 525
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 490, 197, 625, 525
statsGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Global Stats System", false)
guiWindowSetSizable(statsGUI.window[1], false)
guiSetAlpha(statsGUI.window[1], 0.90)
guiSetVisible(statsGUI.window[1], false)
-- Gridlist
statsGUI.gridlist[1] = guiCreateGridList(9, 55, 150, 461, false, statsGUI.window[1])
guiGridListAddColumn(statsGUI.gridlist[1], "Player List", 0.85)
guiGridListSetSortingEnabled(statsGUI.gridlist[1], false)
-- Editbox
statsGUI.edit[1] = guiCreateEdit(9, 27, 120, 23, "Search...", false, statsGUI.window[1])
-- Static Image
statsGUI.staticimage[1] = guiCreateStaticImage(133, 26, 25, 25, "images/search.png", false, statsGUI.window[1])
-- Buttons
statsGUI.button[1] = guiCreateButton(527, 496, 88, 20, "Close", false, statsGUI.window[1])
statsGUI.button[2] = guiCreateButton(433, 496, 88, 20, "Settings", false, statsGUI.window[1])
statsGUI.button[3] = guiCreateButton(340, 496, 88, 20, "Refresh", false, statsGUI.window[1])
-- Tab Panel
statsGUI.tabpanel[1] = guiCreateTabPanel(166, 26, 450, 465, false, statsGUI.window[1])
-- Tabs
statsGUI.tab[1] = guiCreateTab("General", statsGUI.tabpanel[1])
statsGUI.tab[2] = guiCreateTab("Finance", statsGUI.tabpanel[1])
statsGUI.tab[3] = guiCreateTab("Weapons", statsGUI.tabpanel[1])
statsGUI.tab[4] = guiCreateTab("Crimes", statsGUI.tabpanel[1])
statsGUI.tab[5] = guiCreateTab("Missions", statsGUI.tabpanel[1])
statsGUI.tab[6] = guiCreateTab("Misc", statsGUI.tabpanel[1])
-- Scrollpanes
statsGUI.scrollpane[1] = guiCreateScrollPane(10, 5, 435, 426, false, statsGUI.tab[1])
statsGUI.scrollpane[2] = guiCreateScrollPane(10, 5, 435, 426, false, statsGUI.tab[2])
statsGUI.scrollpane[3] = guiCreateScrollPane(10, 5, 435, 426, false, statsGUI.tab[3])
statsGUI.scrollpane[4] = guiCreateScrollPane(10, 5, 435, 426, false, statsGUI.tab[4])
statsGUI.scrollpane[5] = guiCreateScrollPane(10, 5, 435, 426, false, statsGUI.tab[5])
statsGUI.scrollpane[6] = guiCreateScrollPane(10, 5, 435, 426, false, statsGUI.tab[6])

-- Settings GUI
---------------->>

settingsGUI = {checkbox = {}, label = {}, button = {}, window = {}, combobox = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 281, 291
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 662, 287, 281, 291
settingsGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Global Stats — Settings", false)
guiWindowSetSizable(settingsGUI.window[1], false)
guiSetAlpha(settingsGUI.window[1], 0.90)
guiSetVisible(settingsGUI.window[1], false)
-- Checkboxes
settingsGUI.checkbox[1] = guiCreateCheckBox(15, 30, 250, 15, "Hide Account Name from Others", false, false, settingsGUI.window[1])
settingsGUI.checkbox[2] = guiCreateCheckBox(15, 55, 250, 15, "Hide Basic Finance Stats from Others", false, false, settingsGUI.window[1])
settingsGUI.checkbox[3] = guiCreateCheckBox(15, 80, 250, 15, "Hide \"Finances\" Tab from Others", false, false, settingsGUI.window[1])
settingsGUI.checkbox[4] = guiCreateCheckBox(15, 105, 250, 15, "Hide \"Weapons\" Tab from Others", false, false, settingsGUI.window[1])
settingsGUI.checkbox[5] = guiCreateCheckBox(15, 130, 250, 15, "Hide \"Crimes\" Tab from Others", false, false, settingsGUI.window[1])
settingsGUI.checkbox[6] = guiCreateCheckBox(15, 155, 250, 15, "Hide \"Missions\" Tab from Others", false, false, settingsGUI.window[1])
settingsGUI.checkbox[7] = guiCreateCheckBox(15, 180, 250, 15, "Hide \"Misc\" Tab from Others", false, false, settingsGUI.window[1])
-- Labels
settingsGUI.label[1] = guiCreateLabel(6, 192, 270, 15, "_______________________________________", false, settingsGUI.window[1])
settingsGUI.label[2] = guiCreateLabel(39, 218, 88, 15, "Distance Unit:", false, settingsGUI.window[1])
guiSetFont(settingsGUI.label[2], "clear-normal")
settingsGUI.label[3] = guiCreateLabel(6, 233, 270, 15, "_______________________________________", false, settingsGUI.window[1])
-- Combobox
settingsGUI.combobox[1] = guiCreateComboBox(135, 214, 103, 25, "", false, settingsGUI.window[1])
-- Buttons
settingsGUI.button[1] = guiCreateButton(42, 256, 93, 21, "Save Settings", false, settingsGUI.window[1])
settingsGUI.button[2] = guiCreateButton(143, 256, 93, 21, "Cancel", false, settingsGUI.window[1])
