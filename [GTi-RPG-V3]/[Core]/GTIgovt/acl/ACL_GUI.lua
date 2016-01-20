----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Ares
-- Date: 18 July 2015
-- Resource: GTIadmin/acl/acl_gui.lua
-- Version: 1.0
----------------------------------------->>

aclGUI = {tab = {}, label = {}, button = {}, gridlist = {}, tabpanel = {}, admintab = {}, emtab = {}, qcatab = {}, archtab = {} }
-- ACL Tab

aclGUI.tab[1] = guiCreateTab("ACL", adminGUI.tabpanel[1])

aclGUI.tabpanel[1] = guiCreateTabPanel(9, 8, 589, 374, false, aclGUI.tab[1])
-- Admin
    aclGUI.admintab[5] = guiCreateTab("Admin5", aclGUI.tabpanel[1])
    aclGUI.admintab[4] = guiCreateTab("Admin4", aclGUI.tabpanel[1])
    aclGUI.admintab[3] = guiCreateTab("Admin3", aclGUI.tabpanel[1])
    aclGUI.admintab[2] = guiCreateTab("Admin2", aclGUI.tabpanel[1])
    aclGUI.admintab[1] = guiCreateTab("Admin1", aclGUI.tabpanel[1])
-- EM
    aclGUI.emtab[1] = guiCreateTab("Event1", aclGUI.tabpanel[1])
-- QCA
    aclGUI.qcatab[1] = guiCreateTab("QCA1", aclGUI.tabpanel[1])
    aclGUI.qcatab[2] = guiCreateTab("QCA4", aclGUI.tabpanel[1])
    aclGUI.qcatab[3] = guiCreateTab("QCA5", aclGUI.tabpanel[1])
    
-- Arch 
    aclGUI.archtab[1] = guiCreateTab("Arch1", aclGUI.tabpanel[1])
    aclGUI.archtab[2] = guiCreateTab("Arch4", aclGUI.tabpanel[1])
    aclGUI.archtab[3] = guiCreateTab("Arch5", aclGUI.tabpanel[1])    

-- Gridlist
    aclGUI.gridlist['Arch5'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.archtab[3])
    aclGUI.gridlist['Arch4'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.archtab[2])
    aclGUI.gridlist['Arch1'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.archtab[1])
    
    aclGUI.gridlist['QCA5'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.qcatab[3])
    aclGUI.gridlist['QCA4'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.qcatab[2])
    aclGUI.gridlist['QCA1'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.qcatab[1])

    aclGUI.gridlist['Admin5'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.admintab[5])
    aclGUI.gridlist['Admin4'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.admintab[4])
    aclGUI.gridlist['Admin3'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.admintab[3])
    aclGUI.gridlist['Admin2'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.admintab[2])
    aclGUI.gridlist['Admin1'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.admintab[1])

    aclGUI.gridlist['Event'] = guiCreateGridList(5, 5, 575, 325, false, aclGUI.emtab[1])
    
    guiGridListAddColumn(aclGUI.gridlist['Arch5'], "Account", 0.95)
    guiGridListAddColumn(aclGUI.gridlist['Arch4'], "Account", 0.95)
    guiGridListAddColumn(aclGUI.gridlist['Arch1'], "Account", 0.95)
    
    guiGridListAddColumn(aclGUI.gridlist['QCA5'], "Account", 0.95)
    guiGridListAddColumn(aclGUI.gridlist['QCA4'], "Account", 0.95)
    guiGridListAddColumn(aclGUI.gridlist['QCA1'], "Account", 0.95)

    guiGridListAddColumn(aclGUI.gridlist['Admin5'], "Account", 0.95)
    guiGridListAddColumn(aclGUI.gridlist['Admin4'], "Account", 0.95)
    guiGridListAddColumn(aclGUI.gridlist['Admin3'], "Account", 0.95)
    guiGridListAddColumn(aclGUI.gridlist['Admin2'], "Account", 0.95)
    guiGridListAddColumn(aclGUI.gridlist['Admin1'], "Account", 0.95)

    guiGridListAddColumn(aclGUI.gridlist['Event'], "Account", 0.95)
    
    guiGridListSetSortingEnabled(aclGUI.gridlist['Arch5'], false)
    guiGridListSetSortingEnabled(aclGUI.gridlist['Arch4'], false)
    guiGridListSetSortingEnabled(aclGUI.gridlist['Arch1'], false)
    
    guiGridListSetSortingEnabled(aclGUI.gridlist['QCA5'], false)
    guiGridListSetSortingEnabled(aclGUI.gridlist['QCA4'], false)
    guiGridListSetSortingEnabled(aclGUI.gridlist['QCA1'], false)
    
    guiGridListSetSortingEnabled(aclGUI.gridlist['Admin5'], false)
    guiGridListSetSortingEnabled(aclGUI.gridlist['Admin4'], false)
    guiGridListSetSortingEnabled(aclGUI.gridlist['Admin3'], false)
    guiGridListSetSortingEnabled(aclGUI.gridlist['Admin2'], false)
    guiGridListSetSortingEnabled(aclGUI.gridlist['Admin1'], false)

    guiGridListSetSortingEnabled(aclGUI.gridlist['Event'], false)


-- Buttons
aclGUI.button[1] = guiCreateButton(133, 438, 165, 21, "Add account", false, aclGUI.tab[1])
aclGUI.button[2] = guiCreateButton(312, 438, 165, 21, "Remove account", false, aclGUI.tab[1])

-- Labels (Static)
aclGUI.label[1] = guiCreateLabel(12, 405, 63, 15, "Last active:", false, aclGUI.tab[1])
guiSetFont(aclGUI.label[1], "default-bold-small")
guiLabelSetColor(aclGUI.label[1], 0, 190, 255)
aclGUI.label[3] = guiCreateLabel(299, 405, 69, 15, "Last name:", false, aclGUI.tab[1])
guiSetFont(aclGUI.label[3], "default-bold-small")
guiLabelSetColor(aclGUI.label[3], 0, 190, 255)
-- Labels (Dynamic)
aclGUI.label[2] = guiCreateLabel(79, 405, 192, 15, "", false, aclGUI.tab[1])
aclGUI.label[4] = guiCreateLabel(376, 405, 192, 15, "", false, aclGUI.tab[1])

aclExeAdd = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 318, 123
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 648, 351, 318, 123
aclExeAdd.window[1] = guiCreateWindow(sX, sY, wX, wY, "Execute Admin Function", false)
guiWindowSetSizable(aclExeAdd.window[1], false)
guiSetAlpha(aclExeAdd.window[1], 1.00)
guiSetVisible(aclExeAdd.window[1], false)
-- Label
aclExeAdd.label[1] = guiCreateLabel(9, 28, 300, 15, "Enter player's account to add in the ACL.", false, aclExeAdd.window[1])
guiSetFont(aclExeAdd.label[1], "clear-normal")
guiLabelSetHorizontalAlign(aclExeAdd.label[1], "center", false)
-- Editbox
aclExeAdd.edit[1] = guiCreateEdit(9, 50, 300, 24, "", false, aclExeAdd.window[1])
-- Buttons
aclExeAdd.button[1] = guiCreateButton(81, 81, 71, 26, "Execute", false, aclExeAdd.window[1])
aclExeAdd.button[2] = guiCreateButton(163, 81, 71, 26, "Cancel", false, aclExeAdd.window[1])

aclExeRemove = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 318, 123
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 648, 351, 318, 123
aclExeRemove.window[1] = guiCreateWindow(sX, sY, wX, wY, "Execute Admin Function", false)
guiWindowSetSizable(aclExeRemove.window[1], false)
guiSetAlpha(aclExeRemove.window[1], 1.00)
guiSetVisible(aclExeRemove.window[1], false)
-- Label
aclExeRemove.label[1] = guiCreateLabel(9, 28, 300, 15, "Enter player's account to remove from the ACL.", false, aclExeRemove.window[1])
guiSetFont(aclExeRemove.label[1], "clear-normal")
guiLabelSetHorizontalAlign(aclExeRemove.label[1], "center", false)
-- Editbox
aclExeRemove.edit[1] = guiCreateEdit(9, 50, 300, 24, "", false, aclExeRemove.window[1])
-- Buttons
aclExeRemove.button[1] = guiCreateButton(81, 81, 71, 26, "Execute", false, aclExeRemove.window[1])
aclExeRemove.button[2] = guiCreateButton(163, 81, 71, 26, "Cancel", false, aclExeRemove.window[1])


