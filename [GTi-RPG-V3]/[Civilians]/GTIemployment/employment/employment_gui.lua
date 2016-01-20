----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 12 May 2014
-- Resource: GTIemployment/employment_gui.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

employment = {scrollpane = {}, label = {}, button = {}, window = {}, gridlist = {}, combobox = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 451, 373
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 579, 251, 451, 373
employment.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Employment Application — <Job Name>", false)
guiWindowSetSizable(employment.window[1], false)
guiSetAlpha(employment.window[1], 0.90)
guiSetVisible(employment.window[1], false)
-- Labels (Static)
employment.label[1] = guiCreateLabel(13, 30, 44, 15, "Name:", false, employment.window[1])
guiSetFont(employment.label[1], "default-bold-small")
guiLabelSetHorizontalAlign(employment.label[1], "right", false)
employment.label[2] = guiCreateLabel(221, 55, 58, 15, "Rank:", false, employment.window[1])
guiSetFont(employment.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(employment.label[2], "right", false)
employment.label[3] = guiCreateLabel(62, 35, 150, 15, "_____________________________________", false, employment.window[1])
guiSetFont(employment.label[3], "clear-normal")
employment.label[6] = guiCreateLabel(284, 60, 150, 15, "_____________________________________", false, employment.window[1])
guiSetFont(employment.label[6], "clear-normal")
employment.label[7] = guiCreateLabel(221, 30, 58, 15, "Date:", false, employment.window[1])
guiSetFont(employment.label[7], "default-bold-small")
guiLabelSetHorizontalAlign(employment.label[7], "right", false)
employment.label[8] = guiCreateLabel(284, 35, 150, 15, "_____________________________________", false, employment.window[1])
guiSetFont(employment.label[8], "clear-normal")
employment.label[10] = guiCreateLabel(9, 77, 433, 15, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", false, employment.window[1])
employment.label[11] = guiCreateLabel(13, 55, 44, 15, "Job:", false, employment.window[1])
guiSetFont(employment.label[11], "default-bold-small")
guiLabelSetHorizontalAlign(employment.label[11], "right", false)
employment.label[13] = guiCreateLabel(62, 60, 150, 15, "_____________________________________", false, employment.window[1])
guiSetFont(employment.label[13], "clear-normal")
employment.label[14] = guiCreateLabel(10, 102, 48, 15, "Division:", false, employment.window[1])
guiSetFont(employment.label[14], "default-bold-small")
guiLabelSetHorizontalAlign(employment.label[14], "right", false)
employment.label[15] = guiCreateLabel(231, 102, 48, 15, "Uniform:", false, employment.window[1])
guiSetFont(employment.label[15], "default-bold-small")
guiLabelSetHorizontalAlign(employment.label[15], "right", false)
employment.label[16] = guiCreateLabel(9, 123, 433, 15, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", false, employment.window[1])
-- Labels (Dynamic)
employment.label[4] = guiCreateLabel(62, 30, 150, 15, "[ABC]Player>123", false, employment.window[1])
guiSetFont(employment.label[4], "clear-normal")
employment.label[5] = guiCreateLabel(284, 55, 150, 15, "<Rank Name>", false, employment.window[1])
guiSetFont(employment.label[5], "clear-normal")
employment.label[9] = guiCreateLabel(284, 30, 150, 15, "01 January 2015", false, employment.window[1])
guiSetFont(employment.label[9], "clear-normal")
employment.label[12] = guiCreateLabel(62, 55, 150, 15, "<Job Name>", false, employment.window[1])
guiSetFont(employment.label[12], "clear-normal")
-- Comboboxes
employment.combobox[1] = guiCreateComboBox(62, 99, 150, 25, "Select Division...", false, employment.window[1])
employment.combobox[2] = guiCreateComboBox(285, 99, 150, 25, "Select Uniform...", false, employment.window[1])
-- Gridlist
employment.gridlist[1] = guiCreateGridList(9, 142, 433, 191, false, employment.window[1])
-- Scrollpane
employment.scrollpane[1] = guiCreateScrollPane(6, 6, 420, 177, false, employment.gridlist[1])
	-- Labels
	employment.label[17] = guiCreateLabel(0, 0, 394, 15, "The quick brown fox jumps over the lazy dog. The quick brown fox jum", false, employment.scrollpane[1])
	guiLabelSetHorizontalAlign(employment.label[17], "left", true)
-- Buttons
employment.button[1] = guiCreateButton(84, 337, 140, 25, "Submit Application", false, employment.window[1])
guiSetFont(employment.button[1], "default-bold-small")
employment.button[2] = guiCreateButton(230, 337, 140, 25, "Delete Application", false, employment.window[1])
employment.button[3] = guiCreateButton(84, 337, 140, 25, "Set Division/Uniform", false, employment.window[1])
guiSetFont(employment.button[3], "default-bold-small")
employment.button[4] = guiCreateButton(230, 337, 67, 25, "Resign", false, employment.window[1])
employment.button[5] = guiCreateButton(301, 337, 67, 25, "Close", false, employment.window[1])
