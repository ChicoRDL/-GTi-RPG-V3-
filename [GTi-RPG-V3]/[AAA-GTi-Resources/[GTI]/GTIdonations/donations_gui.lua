donationsGUI = {
    tab = {},
    tabpanel = {},
    label = {},
    gridlist = {},
    window = {},
    memo = {}
}

donationsGUI.window[1] = guiCreateWindow(399, 195, 564, 405, "GTI Server Finances and Heroes", false)
guiWindowSetSizable(donationsGUI.window[1], false)
guiSetAlpha(donationsGUI.window[1], 0.95)

donationsGUI.tabpanel[1] = guiCreateTabPanel(9, 24, 545, 371, false, donationsGUI.window[1])

donationsGUI.tab[1] = guiCreateTab("Finances", donationsGUI.tabpanel[1])

donationsGUI.label[3] = guiCreateLabel(7, 46, 511, 15, "_______________________________________________________________________________________", false, donationsGUI.tab[1])
donationsGUI.label[5] = guiCreateLabel(7, 93, 511, 15, "_______________________________________________________________________________________", false, donationsGUI.tab[1])
donationsGUI.label[6] = guiCreateLabel(6, 139, 94, 15, "Server's funds:", false, donationsGUI.tab[1])
guiSetFont(donationsGUI.label[6], "default-bold-small")
guiLabelSetColor(donationsGUI.label[6], 12, 200, 0)
donationsGUI.label[7] = guiCreateLabel(6, 170, 99, 15, "Covered until:", false, donationsGUI.tab[1])
guiSetFont(donationsGUI.label[7], "default-bold-small")
guiLabelSetColor(donationsGUI.label[7], 12, 200, 0)
donationsGUI.label[8] = guiCreateLabel(6, 201, 176, 15, "Needed to cover next month:", false, donationsGUI.tab[1])
guiSetFont(donationsGUI.label[8], "default-bold-small")
guiLabelSetColor(donationsGUI.label[8], 12, 200, 0)
donationsGUI.label[10] = guiCreateLabel(435, 114, 100, 104, "Each month we must pay for the servers that hosts our network, IRC, TeamSpeak, and the MTA Servers.", false, donationsGUI.tab[1])
guiSetFont(donationsGUI.label[10], "default-bold-small")
guiLabelSetColor(donationsGUI.label[10], 0, 54, 254)
guiLabelSetHorizontalAlign(donationsGUI.label[10], "left", true)
donationsGUI.label[11] = guiCreateLabel(110, 139, 196, 15, "<Insert Server's Funds Here>", false, donationsGUI.tab[1])
donationsGUI.label[12] = guiCreateLabel(182, 201, 191, 15, "<Insert Needed for Next Month>", false, donationsGUI.tab[1])
donationsGUI.label[13] = guiCreateLabel(110, 170, 192, 15, "<Insert Covered Until Date Here>", false, donationsGUI.tab[1])
donationsGUI.label[14] = guiCreateLabel(8, 321, 527, 15, "www.gtirpg.net/donate", false, donationsGUI.tab[1])
guiLabelSetColor(donationsGUI.label[14], 195, 195, 0)
guiLabelSetHorizontalAlign(donationsGUI.label[14], "center", true)

donationsGUI.memo[1] = guiCreateMemo(8, 228, 527, 87, "tt", false, donationsGUI.tab[1])
guiMemoSetReadOnly(donationsGUI.memo[1], true)

donationsGUI.tab[2] = guiCreateTab("Heroes", donationsGUI.tabpanel[1])

donationsGUI.gridlist[1] = guiCreateGridList(6, 6, 529, 331, false, donationsGUI.tab[2])
guiGridListAddColumn(donationsGUI.gridlist[1], "#", 0.15)
guiGridListAddColumn(donationsGUI.gridlist[1], "Name", 0.4)
guiGridListAddColumn(donationsGUI.gridlist[1], "Total", 0.2)
guiGridListAddColumn(donationsGUI.gridlist[1], "Last Donation", 0.2)
guiGridListAddRow(donationsGUI.gridlist[1])
guiGridListSetItemText(donationsGUI.gridlist[1], 0, 1, "1", false, false)
guiGridListSetItemText(donationsGUI.gridlist[1], 0, 2, "Ares", false, false)
guiGridListSetItemText(donationsGUI.gridlist[1], 0, 3, "$5", false, false)
guiGridListSetItemText(donationsGUI.gridlist[1], 0, 4, "$5", false, false)    

guiSetVisible(donationsGUI.window[1], false)