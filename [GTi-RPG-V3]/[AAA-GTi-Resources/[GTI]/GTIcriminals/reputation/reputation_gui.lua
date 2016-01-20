----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 18 Aug 2013
-- Resource: GTIcriminals/reputation_gui.lua
-- Version: 2.0
----------------------------------------->>

crimRepGUI = {gridlist = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 550, 375
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
crimRepGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Criminal Respect System", false)
guiWindowSetSizable(crimRepGUI.window[1], false)
guiSetAlpha(crimRepGUI.window[1], 0.95)
guiSetVisible(crimRepGUI.window[1], false)
-- Labels (Static)
crimRepGUI.label[1] = guiCreateLabel(11, 36, 76, 15, "Criminal Level:", false, crimRepGUI.window[1])
crimRepGUI.label[2] = guiCreateLabel(194, 36, 66, 15, "Respect:", false, crimRepGUI.window[1])
crimRepGUI.label[3] = guiCreateLabel(8, 61, 537, 15, "__________________________________________________________________________________", false, crimRepGUI.window[1])
crimRepGUI.label[4] = guiCreateLabel(8, 106, 537, 15, "__________________________________________________________________________________", false, crimRepGUI.window[1])
crimRepGUI.label[5] = guiCreateLabel(9, 126, 193, 15, "Criminal Task List", false, crimRepGUI.window[1])
guiSetFont(crimRepGUI.label[5], "clear-normal")
guiLabelSetHorizontalAlign(crimRepGUI.label[5], "center", false)
crimRepGUI.label[6] = guiCreateLabel(210, 124, 15, 239, "|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ", false, crimRepGUI.window[1])
guiLabelSetHorizontalAlign(crimRepGUI.label[6], "left", true)
crimRepGUI.label[7] = guiCreateLabel(210, 128, 15, 239, "|  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  ", false, crimRepGUI.window[1])
guiLabelSetHorizontalAlign(crimRepGUI.label[7], "left", true)
crimRepGUI.label[9] = guiCreateLabel(222, 150, 80, 15, "Criminal Task:", false, crimRepGUI.window[1])
guiSetFont(crimRepGUI.label[9], "default-bold-small")
guiLabelSetColor(crimRepGUI.label[9], 175, 25, 25)
crimRepGUI.label[10] = guiCreateLabel(222, 180, 64, 15, "Task Rank:", false, crimRepGUI.window[1])
guiSetFont(crimRepGUI.label[10], "default-bold-small")
guiLabelSetColor(crimRepGUI.label[10], 175, 25, 25)
crimRepGUI.label[11] = guiCreateLabel(222, 210, 84, 15, "Task Progress:", false, crimRepGUI.window[1])
guiSetFont(crimRepGUI.label[11], "default-bold-small")
guiLabelSetColor(crimRepGUI.label[11], 175, 25, 25)
crimRepGUI.label[12] = guiCreateLabel(222, 240, 121, 15, "Promo. Requirement:", false, crimRepGUI.window[1])
guiSetFont(crimRepGUI.label[12], "default-bold-small")
guiLabelSetColor(crimRepGUI.label[12], 175, 25, 25)
crimRepGUI.label[13] = guiCreateLabel(222, 270, 103, 15, "Total Rep. Earned:", false, crimRepGUI.window[1])
guiSetFont(crimRepGUI.label[13], "default-bold-small")
guiLabelSetColor(crimRepGUI.label[13], 175, 25, 25)
crimRepGUI.label[14] = guiCreateLabel(222, 300, 103, 15, "Total Cash Earned:", false, crimRepGUI.window[1])
guiSetFont(crimRepGUI.label[14], "default-bold-small")
guiLabelSetColor(crimRepGUI.label[14], 175, 25, 25)
-- Labels (Dynamic)
crimRepGUI.label[8] = guiCreateLabel(460, 128, 82, 15, "Task Level XX", false, crimRepGUI.window[1])
guiSetFont(crimRepGUI.label[8], "default-bold-small")
guiLabelSetColor(crimRepGUI.label[8], 175, 25, 25)
guiLabelSetHorizontalAlign(crimRepGUI.label[8], "right", false)
crimRepGUI.label[15] = guiCreateLabel(308, 150, 233, 15, "<Criminal Task>", false, crimRepGUI.window[1])
crimRepGUI.label[16] = guiCreateLabel(293, 180, 247, 15, "<Task Rank>", false, crimRepGUI.window[1])
crimRepGUI.label[17] = guiCreateLabel(312, 210, 227, 15, "XXX,XXX Units of Unit", false, crimRepGUI.window[1])
crimRepGUI.label[18] = guiCreateLabel(349, 240, 192, 15, "XXX,XXX Units of Unit", false, crimRepGUI.window[1])
crimRepGUI.label[19] = guiCreateLabel(332, 270, 208, 15, "XXX,XXX Rep. Points", false, crimRepGUI.window[1])
crimRepGUI.label[20] = guiCreateLabel(334, 300, 206, 15, "$XXX,XXX", false, crimRepGUI.window[1])
-- Gridlist
crimRepGUI.gridlist[1] = guiCreateGridList(9, 146, 194, 220, false, crimRepGUI.window[1])
guiGridListAddColumn(crimRepGUI.gridlist[1], "Criminal Task List", 0.9)
guiGridListSetSortingEnabled(crimRepGUI.gridlist[1], false)
