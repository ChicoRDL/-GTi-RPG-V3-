----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 18 Sept 2014
-- Resource: GTIadmin/bans_gui.lua
-- Version: 1.0
----------------------------------------->>

bansGUI = {tab = {}, label = {}, button = {}, gridlist = {}}
-- Bans Tab
bansGUI.tab[1] = guiCreateTab("Bans", adminGUI.tabpanel[1])
-- Gridlist
bansGUI.gridlist[1] = guiCreateGridList(9, 8, 589, 374, false, bansGUI.tab[1])
guiGridListAddColumn(bansGUI.gridlist[1], "Player Name", 0.18)
guiGridListAddColumn(bansGUI.gridlist[1], "Account", 0.18)
guiGridListAddColumn(bansGUI.gridlist[1], "IP Address", 0.18)
guiGridListAddColumn(bansGUI.gridlist[1], "MTA Serial", 0.40)
guiGridListAddColumn(bansGUI.gridlist[1], "Ban Admin", 0.18)
guiGridListAddColumn(bansGUI.gridlist[1], "Ban Time", 0.18)
guiGridListAddColumn(bansGUI.gridlist[1], "Unban Time", 0.18)
guiGridListAddColumn(bansGUI.gridlist[1], "Ban Reason", 0.40)
guiGridListSetSortingEnabled(bansGUI.gridlist[1], false)
-- Labels (Static)
bansGUI.label[1] = guiCreateLabel(12, 415, 63, 15, "Banned on:", false, bansGUI.tab[1])
guiSetFont(bansGUI.label[1], "default-bold-small")
guiLabelSetColor(bansGUI.label[1], 0, 190, 255)
bansGUI.label[3] = guiCreateLabel(299, 415, 69, 15, "Ban Expires:", false, bansGUI.tab[1])
guiSetFont(bansGUI.label[3], "default-bold-small")
guiLabelSetColor(bansGUI.label[3], 0, 190, 255)
bansGUI.label[5] = guiCreateLabel(12, 391, 70, 15, "Ban Reason:", false, bansGUI.tab[1])
guiSetFont(bansGUI.label[5], "default-bold-small")
guiLabelSetColor(bansGUI.label[5], 0, 190, 255)
-- Labels (Dynamic)
bansGUI.label[2] = guiCreateLabel(79, 415, 192, 15, "1970-01-01 @ 00:00:00 GMT", false, bansGUI.tab[1])
bansGUI.label[4] = guiCreateLabel(376, 415, 192, 15, "1970-01-01 @ 00:00:00 GMT", false, bansGUI.tab[1])
bansGUI.label[6] = guiCreateLabel(88, 391, 505, 15, "Ungrateful piece of garbage", false, bansGUI.tab[1])
-- Buttons
bansGUI.button[1] = guiCreateButton(133, 438, 165, 21, "Unban Selected Player", false, bansGUI.tab[1])
bansGUI.button[2] = guiCreateButton(312, 438, 165, 21, "Add Manual Ban...", false, bansGUI.tab[1])
