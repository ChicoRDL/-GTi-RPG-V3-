----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 18 Dec 2013
-- Resource: GTIemployment/progressGUI.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

progressGUI = {tab = {}, scrollpane = {}, tabpanel = {}, label = {}, button = {}, window = {}, gridlist = {}, memo = {}, radiobutton = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 564, 405
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 396, 195, 564, 405
progressGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Employment System Panel", false)
guiWindowSetSizable(progressGUI.window[1], false)
guiSetAlpha(progressGUI.window[1], 0.95)
-- Tab Panel
progressGUI.tabpanel[1] = guiCreateTabPanel(9, 24, 546, 372, false, progressGUI.window[1])

-- Current Job Tab
------------------->>

-- Tab
progressGUI.tab[1] = guiCreateTab("Current Job", progressGUI.tabpanel[1])
-- Scrollpane
progressGUI.scrollpane[1] = guiCreateScrollPane(314, 30, 226, 270, false, progressGUI.tab[1])
	-- Labels (Dynamic)
	progressGUI.label[38] = guiCreateLabel(3, 2, 211, 15, "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", false, progressGUI.scrollpane[1])
	guiLabelSetHorizontalAlign(progressGUI.label[38], "left", true)
-- Labels (Static)
progressGUI.label[1] = guiCreateLabel(15, 17, 68, 15, "Current Job:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[1], "default-bold-small")
guiLabelSetColor(progressGUI.label[1], 255, 200, 0)
progressGUI.label[3] = guiCreateLabel(381, 9, 88, 15, "Job Description", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[3], "default-bold-small")
guiLabelSetColor(progressGUI.label[3], 255, 200, 0)
progressGUI.label[5] = guiCreateLabel(314, 291, 226, 15, "____________________________________", false, progressGUI.tab[1])
progressGUI.label[6] = guiCreateLabel(7, 36, 287+6, 15, "_____________________________________________", false, progressGUI.tab[1])
progressGUI.label[8] = guiCreateLabel(10, 81, 80, 15, "Current Rank:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[8], "default-bold-small")
guiLabelSetColor(progressGUI.label[8], 255, 200, 0)
progressGUI.label[10] = guiCreateLabel(10, 128, 108, 15, "Progress to Promo:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[10], "default-bold-small")
guiLabelSetColor(progressGUI.label[10], 255, 200, 0)
progressGUI.label[11] = guiCreateLabel(10, 104, 80, 15, "Job Progress:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[11], "default-bold-small")
guiLabelSetColor(progressGUI.label[11], 255, 200, 0)
progressGUI.label[51] = guiCreateLabel(10, 151, 87, 15, "On-Duty Hours:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[51], "default-bold-small")
guiLabelSetColor(progressGUI.label[51], 255, 200, 0)
progressGUI.label[14] = guiCreateLabel(7, 168, 287+6, 15, "_____________________________________________", false, progressGUI.tab[1])
progressGUI.label[15] = guiCreateLabel(10, 198, 102, 15, "Total Exp. Earned:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[15], "default-bold-small")
guiLabelSetColor(progressGUI.label[15], 255, 200, 0)
progressGUI.label[16] = guiCreateLabel(10, 230, 102, 15, "Total Cash Earned:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[16], "default-bold-small")
guiLabelSetColor(progressGUI.label[16], 255, 200, 0)
progressGUI.label[19] = guiCreateLabel(7, 250, 287+6, 15, "_____________________________________________", false, progressGUI.tab[1])
progressGUI.label[20] = guiCreateLabel(11, 277, 150, 15, "Cash Earned Last Hour:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[20], "default-bold-small")
guiLabelSetColor(progressGUI.label[20], 255, 200, 0)
progressGUI.label[51] = guiCreateLabel(11, 314, 150, 15, "Exp. Earned Last Hour:", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[51], "default-bold-small")
guiLabelSetColor(progressGUI.label[51], 255, 200, 0)

--[[progressGUI.label[22] = guiCreateLabel(13, 301, 282, 30, "Your account balance is automatically transferred to your bank account either every hour, when you resign, or when you go offline", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[22], "default-small")
guiLabelSetHorizontalAlign(progressGUI.label[22], "center", true)]]
-- Labels (Dynamic)
progressGUI.label[2] = guiCreateLabel(92, 17, 203, 15, "<Job Name>", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[2], "clear-normal")
progressGUI.label[7] = guiCreateLabel(244+6, 56, 50, 15, "Level XX", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[7], "default-bold-small")
guiLabelSetColor(progressGUI.label[7], 255, 200, 0)
guiLabelSetHorizontalAlign(progressGUI.label[7], "right", true)
progressGUI.label[9] = guiCreateLabel(99, 81, 191+6, 15, "<Rank Name>", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[9], "clear-normal")
progressGUI.label[12] = guiCreateLabel(126, 128, 164+6, 15, "XXX,XXX Units of Unit", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[12], "clear-normal")
progressGUI.label[13] = guiCreateLabel(99, 104, 191+6, 15, "XXX,XXX Units of Unit", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[13], "clear-normal")
progressGUI.label[17] = guiCreateLabel(120, 198, 172+6, 15, "XXX,XXX Exp. Points", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[17], "clear-normal")
progressGUI.label[52] = guiCreateLabel(110, 151, 164, 15, "XXXX hours", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[52], "clear-normal")
progressGUI.label[18] = guiCreateLabel(120, 231, 172+6, 15, "$XXX,XXX", false, progressGUI.tab[1])
guiSetFont(progressGUI.label[18], "clear-normal")
progressGUI.label[50] = guiCreateLabel(145, 277, 161, 15, "$1,234,567", false, progressGUI.tab[1])
guiLabelSetColor(progressGUI.label[50], 25, 200, 25)
progressGUI.label[55] = guiCreateLabel(145, 314, 172+6, 15, "XXX Exp. Points", false, progressGUI.tab[1])
guiLabelSetColor(progressGUI.label[55], 25, 200, 25)
-- Buttons
progressGUI.button[1] = guiCreateButton(316, 313, 106, 25, "End Shift", false, progressGUI.tab[1])
guiSetProperty(progressGUI.button[1], "NormalTextColour", "FFAAAAAA")
progressGUI.button[2] = guiCreateButton(431, 313, 106, 25, "Resign", false, progressGUI.tab[1])
guiSetProperty(progressGUI.button[2], "NormalTextColour", "FFAAAAAA")

-- All Jobs Tab
---------------->>

-- Tab
progressGUI.tab[2] = guiCreateTab("All Jobs", progressGUI.tabpanel[1])
-- Labels (Static)
progressGUI.label[21] = guiCreateLabel(10, 23-15, 70, 15+30, "Employment Level:", false, progressGUI.tab[2])
guiLabelSetHorizontalAlign(progressGUI.label[21], "center", true)
guiLabelSetVerticalAlign(progressGUI.label[21], "center")
progressGUI.label[23] = guiCreateLabel(198, 23, 64, 15, "Experience:", false, progressGUI.tab[2])
progressGUI.label[25] = guiCreateLabel(7, 46, 534, 15, "_______________________________________________________________________________________", false, progressGUI.tab[2])
progressGUI.label[26] = guiCreateLabel(70-50, 115, 104+100, 15, "Employment Jobs List", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[26], "clear-normal")
progressGUI.label[27] = guiCreateLabel(7, 93, 534, 15, "_______________________________________________________________________________________", false, progressGUI.tab[2])
progressGUI.label[31] = guiCreateLabel(251, 139, 79, 15, "Current Rank:", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[31], "default-bold-small")
guiLabelSetColor(progressGUI.label[31], 255, 200, 0)
progressGUI.label[32] = guiCreateLabel(251, 170, 99, 15, "Current Progress:", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[32], "default-bold-small")
guiLabelSetColor(progressGUI.label[32], 255, 200, 0)
progressGUI.label[33] = guiCreateLabel(251, 201, 114, 15, "Progress for Promo:", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[33], "default-bold-small")
guiLabelSetColor(progressGUI.label[33], 255, 200, 0)
progressGUI.label[37] = guiCreateLabel(348, 231, 89, 15, "Job Description", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[37], "default-bold-small")
guiLabelSetColor(progressGUI.label[37], 255, 200, 0)
-- Labels (Dynamic)
progressGUI.label[29] = guiCreateLabel(488, 115, 50, 15, "Level XX", false, progressGUI.tab[2])
guiSetFont(progressGUI.label[29], "default-bold-small")
guiLabelSetColor(progressGUI.label[29], 255, 200, 0)
progressGUI.label[34] = guiCreateLabel(340, 139, 196, 15, "<Insert Rank Name Here>", false, progressGUI.tab[2])
progressGUI.label[35] = guiCreateLabel(378, 201, 160, 15, "<Insert Prog. 4 Promo Here>", false, progressGUI.tab[2])
progressGUI.label[36] = guiCreateLabel(362, 170, 177, 15, "<Insert Current Progress Here>", false, progressGUI.tab[2])
-- Gridlist
progressGUI.gridlist[1] = guiCreateGridList(7, 135, 220, 205, false, progressGUI.tab[2])
guiGridListAddColumn(progressGUI.gridlist[1], "Employment Jobs List", 0.9)
guiGridListSetSortingEnabled(progressGUI.gridlist[1], false)
-- Memo
progressGUI.memo[1] = guiCreateMemo(251, 250, 289, 90, "", false, progressGUI.tab[2])
guiMemoSetReadOnly(progressGUI.memo[1], true)

-- Other Settings
guiSetVisible(progressGUI.window[1], false)