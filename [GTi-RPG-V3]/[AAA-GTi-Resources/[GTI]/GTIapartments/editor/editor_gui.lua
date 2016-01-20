----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 27 Dec 2015
-- Resource: GTIapartments/editor/editor_gui.lua
-- Type: Client Side
-- Author: Ares
----------------------------------------->>

ApartmentsUI = {
    gridlist = {},
    window = {},
    button = {},
    label = {},
    combobox = {}
}


ApartmentsUI.window[1] = guiCreateWindow(53, 182, 432, 400, "GTI Apartments Editor", false)
guiWindowSetSizable(ApartmentsUI.window[1], false)
guiSetVisible(ApartmentsUI.window[1], false)

ApartmentsUI.gridlist[1] = guiCreateGridList(19, 78, 182, 303, false, ApartmentsUI.window[1])
guiGridListAddColumn(ApartmentsUI.gridlist[1], "Item", 0.9)

ApartmentsUI.label[7] = guiCreateLabel(36, 28, 351, 50, "Double-click the item you wish to purchase and you'll have a preview of it, use arrows to rotate it.", false, ApartmentsUI.window[1])
guiLabelSetHorizontalAlign(ApartmentsUI.label[7], "center", true)    

ApartmentsUI.button[1] = guiCreateButton(217, 353, 161, 28, "Buy", false, ApartmentsUI.window[1])
guiSetFont(ApartmentsUI.button[1], "default-bold-small")
guiSetProperty(ApartmentsUI.button[1], "NormalTextColour", "FF000BF3")

ApartmentsUI.button[2] = guiCreateButton(396, 352, 22, 29, "X", false, ApartmentsUI.window[1])
guiSetFont(ApartmentsUI.button[2], "default-bold-small")
guiSetProperty(ApartmentsUI.button[2], "NormalTextColour", "FFFF0000")

-- Item properties:

ApartmentsUI.label[3] = guiCreateLabel(221, 99, 91, 15, "Price", false, ApartmentsUI.window[1])
guiSetFont(ApartmentsUI.label[3], "default-bold-small")
guiLabelSetColor(ApartmentsUI.label[3], 255, 37, 37)

ApartmentsUI.label[5] = guiCreateLabel(221, 124, 91, 15, "Model", false, ApartmentsUI.window[1])
guiSetFont(ApartmentsUI.label[5], "default-bold-small")
guiLabelSetColor(ApartmentsUI.label[5], 255, 37, 37)

ApartmentsUI.label[1] = guiCreateLabel(221, 149, 91, 15, "Textures", false, ApartmentsUI.window[1])
guiSetFont(ApartmentsUI.label[1], "default-bold-small")
guiLabelSetColor(ApartmentsUI.label[1], 255, 37, 37)

-- Item properties modificable

ApartmentsUI.label[2] = guiCreateLabel(320, 99, 86, 15, "$1,000", false, ApartmentsUI.window[1])
guiSetFont(ApartmentsUI.label[2], "default-bold-small")
guiLabelSetColor(ApartmentsUI.label[2], 255, 37, 37)

ApartmentsUI.label[6] = guiCreateLabel(320, 124, 86, 15, "690", false, ApartmentsUI.window[1])
guiSetFont(ApartmentsUI.label[6], "default-bold-small")
guiLabelSetColor(ApartmentsUI.label[6], 255, 37, 37)

-- Shaders
ApartmentsUI.label[4] = guiCreateLabel(320, 149, 86, 15, "0", false, ApartmentsUI.window[1])
guiSetFont(ApartmentsUI.label[4], "default-bold-small")
guiLabelSetColor(ApartmentsUI.label[4], 255, 37, 37)

ApartmentsUI.combobox[1] = guiCreateComboBox(320, 149, 100, 100, "Shader", false, ApartmentsUI.window[1])


