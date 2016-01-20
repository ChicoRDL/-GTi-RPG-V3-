----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 29 Jul 2014
-- Resource: GTIturfing/creation/creation_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Basic Turf Creation Panel
----------------------------->>

basicCreate = {edit = {}, button = {}, window = {}, label = {}, combobox = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 295, 357
local sX, sY, wX, wY = 10,(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 11, 239, 295, 357
basicCreate.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Turf Creation Panel", false)
guiWindowSetSizable(basicCreate.window[1], false)
guiSetAlpha(basicCreate.window[1], 0.90)
guiSetVisible(basicCreate.window[1], false)
-- Labels
basicCreate.label[1] = guiCreateLabel(8, 25, 280, 29, "ONLY DEVELOPERS AND ARCHITECTS SHOULD SEE THIS PANEL", false, basicCreate.window[1])
guiSetFont(basicCreate.label[1], "default-bold-small")
guiLabelSetColor(basicCreate.label[1], 255, 25, 25)
guiLabelSetHorizontalAlign(basicCreate.label[1], "center", true)
basicCreate.label[2] = guiCreateLabel(3, 49, 287, 15, "___________________________________________________", false, basicCreate.window[1])
basicCreate.label[3] = guiCreateLabel(14, 78, 72, 15, "Turf Mode:", false, basicCreate.window[1])
guiSetFont(basicCreate.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(basicCreate.label[3], "right", false)
basicCreate.label[4] = guiCreateLabel(3, 94, 287, 15, "___________________________________________________", false, basicCreate.window[1])
basicCreate.label[5] = guiCreateLabel(13, 119, 267, 15, "Coordinates - SW Corner (Bottom Right)", false, basicCreate.window[1])
guiSetFont(basicCreate.label[5], "clear-normal")
guiLabelSetHorizontalAlign(basicCreate.label[5], "center", false)
basicCreate.label[6] = guiCreateLabel(20, 142, 15, 15, "X:", false, basicCreate.window[1])
guiSetFont(basicCreate.label[6], "clear-normal")
basicCreate.label[7] = guiCreateLabel(167, 142, 15, 15, "Y:", false, basicCreate.window[1])
guiSetFont(basicCreate.label[7], "clear-normal")
basicCreate.label[8] = guiCreateLabel(13, 219, 267, 15, "Coordinates - NE Corner (Top Left)", false, basicCreate.window[1])
guiSetFont(basicCreate.label[8], "clear-normal")
guiLabelSetHorizontalAlign(basicCreate.label[8], "center", false)
basicCreate.label[9] = guiCreateLabel(20, 242, 15, 15, "X:", false, basicCreate.window[1])
guiSetFont(basicCreate.label[9], "clear-normal")
basicCreate.label[10] = guiCreateLabel(167, 242, 15, 15, "Y:", false, basicCreate.window[1])
guiSetFont(basicCreate.label[10], "clear-normal")
basicCreate.label[11] = guiCreateLabel(3, 191, 287, 15, "___________________________________________________", false, basicCreate.window[1])
basicCreate.label[12] = guiCreateLabel(3, 305, 287, 15, "___________________________________________________", false, basicCreate.window[1])
basicCreate.label[13] = guiCreateLabel(3, 295, 287, 15, "* TIP: Press X to toggle your cursor", false, basicCreate.window[1])
guiSetFont(basicCreate.label[13], "default-small")
guiLabelSetHorizontalAlign(basicCreate.label[13], "center", false)
-- Combobox
basicCreate.combobox[1] = guiCreateComboBox(91, 74, 190, 23, "", false, basicCreate.window[1])
-- Editboxes
basicCreate.edit[1] = guiCreateEdit(40, 140, 89, 20, "", false, basicCreate.window[1])
basicCreate.edit[2] = guiCreateEdit(186, 140, 89, 20, "", false, basicCreate.window[1])
basicCreate.edit[3] = guiCreateEdit(40, 240, 89, 20, "", false, basicCreate.window[1])
basicCreate.edit[4] = guiCreateEdit(186, 240, 89, 20, "", false, basicCreate.window[1])
-- Buttons
basicCreate.button[1] = guiCreateButton(62, 167, 170, 23, "Get SW Position", false, basicCreate.window[1])
guiSetProperty(basicCreate.button[1], "NormalTextColour", "FFAAAAAA")
basicCreate.button[2] = guiCreateButton(62, 267, 170, 23, "Get NE Position", false, basicCreate.window[1])
guiSetProperty(basicCreate.button[2], "NormalTextColour", "FFAAAAAA")
basicCreate.button[3] = guiCreateButton(14, 325, 122, 28, "Cancel", false, basicCreate.window[1])
guiSetProperty(basicCreate.button[3], "NormalTextColour", "FFAAAAAA")
basicCreate.button[4] = guiCreateButton(161, 325, 122, 28, "Create Turf!", false, basicCreate.window[1])
guiSetFont(basicCreate.button[4], "default-bold-small")
guiSetProperty(basicCreate.button[4], "NormalTextColour", "FFAAAAAA")

-- Turf Mode A: Points System
------------------------------>>

pointsCreate = {button = {}, window = {}, label = {}, edit = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 132, 166
local sX, sY, wX, wY = sX-wX-10,(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 1460, 370, 132, 166
pointsCreate.window[1] = guiCreateWindow(1460, 370, 132, 166, "Turf Respawn Point", false)
guiWindowSetSizable(pointsCreate.window[1], false)
guiSetVisible(pointsCreate.window[1], false)
-- Editboxes
pointsCreate.edit[1] = guiCreateEdit(37, 25, 81, 27, "", false, pointsCreate.window[1])
pointsCreate.edit[2] = guiCreateEdit(37, 96, 81, 27, "", false, pointsCreate.window[1])
pointsCreate.edit[3] = guiCreateEdit(37, 60, 81, 27, "", false, pointsCreate.window[1])
-- Labels
pointsCreate.label[1] = guiCreateLabel(14, 32, 15, 15, "X:", false, pointsCreate.window[1])
guiSetFont(pointsCreate.label[1], "clear-normal")
pointsCreate.label[2] = guiCreateLabel(14, 103, 15, 15, "Z:", false, pointsCreate.window[1])
guiSetFont(pointsCreate.label[2], "clear-normal")
pointsCreate.label[3] = guiCreateLabel(14, 65, 15, 15, "Y:", false, pointsCreate.window[1])
guiSetFont(pointsCreate.label[3], "clear-normal")
-- Button
pointsCreate.button[1] = guiCreateButton(9, 130, 114, 25, "Get Position", false, pointsCreate.window[1])
guiSetProperty(pointsCreate.button[1], "NormalTextColour", "FFAAAAAA")
