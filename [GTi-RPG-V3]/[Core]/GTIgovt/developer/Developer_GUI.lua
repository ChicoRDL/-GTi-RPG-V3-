----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 31 Jul 2014
-- Resource: GTIadmin/developer_gui.lua
-- Version: 1.0
----------------------------------------->>

devPanel = {tab = {}, tabpanel = {}, label = {}, button = {}, gridlist = {}, combobox = {}}
-- Tab Panel
devPanel.tab[1] = guiCreateTab("Resources", adminGUI.tabpanel[1])
-- Gridlist
devPanel.gridlist[1] = guiCreateGridList(9, 9, 590, 359, false, devPanel.tab[1])
guiGridListAddColumn(devPanel.gridlist[1], "Resource Name", 0.25)
guiGridListAddColumn(devPanel.gridlist[1], "Name", 0.50)
guiGridListAddColumn(devPanel.gridlist[1], "State", 0.1)
guiGridListAddColumn(devPanel.gridlist[1], "Autostart", 0.1)
guiGridListSetSortingEnabled(devPanel.gridlist[1], false)
-- Buttons
devPanel.button[1] = guiCreateButton(9, 373, 142, 20, "Start", false, devPanel.tab[1])
guiSetProperty(devPanel.button[1], "NormalTextColour", "FFAAAAAA")
devPanel.button[2] = guiCreateButton(456, 373, 142, 20, "Refresh", false, devPanel.tab[1])
guiSetProperty(devPanel.button[2], "NormalTextColour", "FFAAAAAA")
devPanel.button[3] = guiCreateButton(308, 373, 142, 20, "Stop", false, devPanel.tab[1])
guiSetProperty(devPanel.button[3], "NormalTextColour", "FFAAAAAA")
devPanel.button[4] = guiCreateButton(160, 373, 142, 20, "Restart", false, devPanel.tab[1])
guiSetProperty(devPanel.button[4], "NormalTextColour", "FFAAAAAA")
devPanel.button[5] = guiCreateButton(456, 402, 142, 20, "Toggle Auto-start", false, devPanel.tab[1])
guiSetProperty(devPanel.button[5], "NormalTextColour", "FFAAAAAA")
-- Labels
devPanel.label[1] = guiCreateLabel(9, 427, 589, 30, "This is an organized record of all resources that are currently on the server, as well as their states.\nBe sure to always fully fill out the <info/> section of your meta.xml", false, devPanel.tab[1])
guiLabelSetHorizontalAlign(devPanel.label[1], "center", false)
