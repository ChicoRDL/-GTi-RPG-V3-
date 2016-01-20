----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 09 Jan 2015
-- Resource: GTIpremium/shop_gui.lua
-- Type: Client Side
----------------------------------------->>

premiumGUI = {staticimage = {}, label = {}, gridlist = {}, window = {}, button = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 384, 460
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 591, 271, 384, 460
premiumGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Premium Shop", false)
guiWindowSetSizable(premiumGUI.window[1], false)
guiSetAlpha(premiumGUI.window[1], 0.85)
guiSetVisible(premiumGUI.window[1], false)
-- Static Image
premiumGUI.staticimage[1] = guiCreateStaticImage(13, 31, 64, 64, "images/Token.png", false, premiumGUI.window[1])
-- Labels (Static)
premiumGUI.label[1] = guiCreateLabel(87, 46-19, 69, 15, "MY ŦOKENS:", false, premiumGUI.window[1])
guiSetFont(premiumGUI.label[1], "default-bold-small")
guiLabelSetColor(premiumGUI.label[1], 0, 178, 240)
guiLabelSetHorizontalAlign(premiumGUI.label[1], "center", false)
premiumGUI.label[3] = guiCreateLabel(164, 28, 205, 68, "Visit http://gtirpg.net/premium to find out information on how to purchase Ŧokens.", false, premiumGUI.window[1])
guiSetFont(premiumGUI.label[3], "default-bold-small")
guiLabelSetHorizontalAlign(premiumGUI.label[3], "center", true)
guiLabelSetVerticalAlign(premiumGUI.label[3], "center")
premiumGUI.label[4] = guiCreateLabel(15, 104, 347, 15, "Select an item off the list that you wish to purchase", false, premiumGUI.window[1])
guiSetFont(premiumGUI.label[4], "default-small")
guiLabelSetHorizontalAlign(premiumGUI.label[4], "center", false)
premiumGUI.label[5] = guiCreateLabel(10, 416, 362, 37, "Note: Each item on the list expires after 30 days.\nAccess does not mean that you get the item for free, it simply means that you are able to access/buy the item", false, premiumGUI.window[1])
guiSetFont(premiumGUI.label[5], "default-small")
guiLabelSetHorizontalAlign(premiumGUI.label[5], "center", true)
premiumGUI.label[6] = guiCreateLabel(87, 46+19, 69, 15, "PERMANENT:", false, premiumGUI.window[1])
guiSetFont(premiumGUI.label[6], "default-bold-small")
guiLabelSetColor(premiumGUI.label[6], 0, 240, 178)
guiLabelSetHorizontalAlign(premiumGUI.label[6], "center", false)
-- Labels (Dynamic)
premiumGUI.label[2] = guiCreateLabel(87, 63-19, 68, 15, "9999", false, premiumGUI.window[1])    -- My Tokens
guiSetFont(premiumGUI.label[2], "clear-normal")
guiLabelSetHorizontalAlign(premiumGUI.label[2], "center", false)
premiumGUI.label[7] = guiCreateLabel(87, 63+19, 68, 15, "9999", false, premiumGUI.window[1])    -- Permanent
guiSetFont(premiumGUI.label[7], "clear-normal")
guiLabelSetHorizontalAlign(premiumGUI.label[7], "center", false)
-- Gridlist
premiumGUI.gridlist[1] = guiCreateGridList(9, 121, 366, 256, false, premiumGUI.window[1])
guiGridListSetSortingEnabled(premiumGUI.gridlist[1], false)
guiGridListAddColumn(premiumGUI.gridlist[1], "Description", 0.80)
guiGridListAddColumn(premiumGUI.gridlist[1], "Cost", 0.10)
-- Buttons
premiumGUI.button[1] = guiCreateButton(24, 384, 104, 25, "Purchase Item", false, premiumGUI.window[1])
premiumGUI.button[2] = guiCreateButton(142, 384, 104, 25, "Get Ŧokens", false, premiumGUI.window[1])
guiSetProperty(premiumGUI.button[2], "Disabled", "True" )
premiumGUI.button[3] = guiCreateButton(260, 384, 104, 25, "Exit Shop", false, premiumGUI.window[1])

-- Confirm Purchase
-------------------->>

confirmGUI = {button = {}, window = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 322, 166
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 636, 315, 322, 166
confirmGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Premium — Confirm Purchase", false)
guiWindowSetSizable(confirmGUI.window[1], false)
guiSetAlpha(confirmGUI.window[1], 0.90)
guiSetVisible(confirmGUI.window[1], false)
-- Labels (Static)
confirmGUI.label[1] = guiCreateLabel(19, 35, 91, 15, "SELECTED ITEM:", false, confirmGUI.window[1])
guiSetFont(confirmGUI.label[1], "default-bold-small")
guiLabelSetColor(confirmGUI.label[1], 0, 178, 240)
confirmGUI.label[3] = guiCreateLabel(19, 76, 34, 15, "COST:", false, confirmGUI.window[1])
guiSetFont(confirmGUI.label[3], "default-bold-small")
guiLabelSetColor(confirmGUI.label[3], 0, 178, 240)
confirmGUI.label[5] = guiCreateLabel(112, 76, 51, 15, "EXPIRES:", false, confirmGUI.window[1])
guiSetFont(confirmGUI.label[5], "default-bold-small")
guiLabelSetColor(confirmGUI.label[5], 0, 178, 240)
confirmGUI.label[7] = guiCreateLabel(16, 99, 289, 15, "Are you sure you want to purchase this item?", false, confirmGUI.window[1])
guiSetFont(confirmGUI.label[7], "default-small")
guiLabelSetHorizontalAlign(confirmGUI.label[7], "center", false)
-- Labels (Dynamic)
confirmGUI.label[2] = guiCreateLabel(19, 54, 281, 15, "Access to buy exclusive weapon shaders & colors", false, confirmGUI.window[1])
confirmGUI.label[4] = guiCreateLabel(59, 76, 28, 15, "99 Ŧ", false, confirmGUI.window[1])
confirmGUI.label[6] = guiCreateLabel(168, 76, 131, 15, "01 January 1970", false, confirmGUI.window[1])
-- Buttons
confirmGUI.button[1] = guiCreateButton(73, 122, 85, 23, "Purchase", false, confirmGUI.window[1])
confirmGUI.button[2] = guiCreateButton(168, 122, 85, 23, "Cancel", false, confirmGUI.window[1])

-- Buy Ŧokens
-------------->>

buyTokenGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 309, 180
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 646, 337, 309, 180
buyTokenGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Premium — Buy Ŧokens", false)
guiWindowSetSizable(buyTokenGUI.window[1], false)
guiSetAlpha(buyTokenGUI.window[1], 0.90)
guiSetVisible(buyTokenGUI.window[1], false)
-- Labels (Static)
buyTokenGUI.label[1] = guiCreateLabel(14, 32, 139, 15, "COST OF ONE ŦOKEN: ", false, buyTokenGUI.window[1])
guiSetFont(buyTokenGUI.label[1], "default-bold-small")
guiLabelSetColor(buyTokenGUI.label[1], 0, 178, 240)
guiLabelSetHorizontalAlign(buyTokenGUI.label[1], "right", false)
buyTokenGUI.label[3] = guiCreateLabel(14, 60, 139, 15, "AMOUNT TO PURCHASE:", false, buyTokenGUI.window[1])
guiSetFont(buyTokenGUI.label[3], "default-bold-small")
guiLabelSetColor(buyTokenGUI.label[3], 0, 178, 240)
guiLabelSetHorizontalAlign(buyTokenGUI.label[3], "right", false)
buyTokenGUI.label[4] = guiCreateLabel(14, 87, 139, 15, "TOTAL COST:", false, buyTokenGUI.window[1])
guiSetFont(buyTokenGUI.label[4], "default-bold-small")
guiLabelSetColor(buyTokenGUI.label[4], 0, 178, 240)
guiLabelSetHorizontalAlign(buyTokenGUI.label[4], "right", false)
buyTokenGUI.label[6] = guiCreateLabel(15, 110, 278, 24, "Can't afford the cost? Learn how to pay for tokens at http://gtirpg.net/premium", false, buyTokenGUI.window[1])
guiSetFont(buyTokenGUI.label[6], "default-small")
guiLabelSetHorizontalAlign(buyTokenGUI.label[6], "center", true)
-- Labels (Dynamic)
buyTokenGUI.label[2] = guiCreateLabel(163, 32, 85, 15, "$50,000", false, buyTokenGUI.window[1]) -- Cost of One
guiSetFont(buyTokenGUI.label[2], "clear-normal")
guiLabelSetColor(buyTokenGUI.label[2], 25, 255, 25)
buyTokenGUI.label[5] = guiCreateLabel(163, 87, 129, 15, "$50,000", false, buyTokenGUI.window[1])    -- Total Cost
guiSetFont(buyTokenGUI.label[5], "clear-normal")
guiLabelSetColor(buyTokenGUI.label[5], 25, 255, 25)
-- Edit
buyTokenGUI.edit[1] = guiCreateEdit(163, 57, 71, 21, "", false, buyTokenGUI.window[1])
-- Buttons
buyTokenGUI.button[1] = guiCreateButton(81, 141, 71, 26, "Purchase", false, buyTokenGUI.window[1])
buyTokenGUI.button[2] = guiCreateButton(157, 141, 71, 26, "Close", false, buyTokenGUI.window[1])

-- Conflict Warning
-------------------->>

conflictGUI = {gridlist = {}, window = {}, button = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 340, 183
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 627, 335, 340, 183
conflictGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Premium — Conflict Warning", false)
guiWindowSetSizable(conflictGUI.window[1], false)
guiSetAlpha(conflictGUI.window[1], 0.90)
guiSetVisible(conflictGUI.window[1], false)
-- Gridlist
conflictGUI.gridlist[1] = guiCreateGridList(12, 65, 319, 32, false, conflictGUI.window[1])
-- Labels (Static)
conflictGUI.label[1] = guiCreateLabel(17, 31, 306, 31, "WARNING: Purchasing this premium feature will cause you to lose the following one:", false, conflictGUI.window[1])
guiLabelSetHorizontalAlign(conflictGUI.label[1], "center", true)
conflictGUI.label[2] = guiCreateLabel(24, 99, 297, 31, "You will not be refunded for this loss. Are you sure you want to continue?", false, conflictGUI.window[1])
guiLabelSetHorizontalAlign(conflictGUI.label[2], "center", true)
-- Labels (Dynamic)
conflictGUI.label[3] = guiCreateLabel(10, 71, 324, 15, "Access to buy exclusive weapon shaders & colors", false, conflictGUI.window[1])
guiSetFont(conflictGUI.label[3], "clear-normal")
guiLabelSetColor(conflictGUI.label[3], 0, 178, 240)
guiLabelSetHorizontalAlign(conflictGUI.label[3], "center", false)
-- Buttons
conflictGUI.button[1] = guiCreateButton(97, 137, 69, 24, "Yes", false, conflictGUI.window[1])
conflictGUI.button[2] = guiCreateButton(177, 137, 69, 24, "No", false, conflictGUI.window[1])

-- Payment Method
------------------>>

paymentGUI = {button = {}, window = {}, radiobutton = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 257, 115
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 685, 351, 257, 115
paymentGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "Payment Method", false)
guiWindowSetSizable(paymentGUI.window[1], false)
guiSetAlpha(paymentGUI.window[1], 0.90)
guiSetVisible(paymentGUI.window[1], false)
-- Radio Button
paymentGUI.radiobutton[1] = guiCreateRadioButton(14, 31, 222, 15, "Use Ŧokens (9999 Remaining)", false, paymentGUI.window[1])
guiSetProperty(paymentGUI.radiobutton[1], "NormalTextColour", "FF00B2F0")
guiRadioButtonSetSelected(paymentGUI.radiobutton[1], true)
paymentGUI.radiobutton[2] = guiCreateRadioButton(14, 52, 222, 15, "Use Perm. Ŧokens (9999 Remaining)", false, paymentGUI.window[1])
guiSetProperty(paymentGUI.radiobutton[2], "NormalTextColour", "FF00F0AF")
-- Buttons
paymentGUI.button[1] = guiCreateButton(49, 76, 77, 25, "Continue", false, paymentGUI.window[1])
paymentGUI.button[2] = guiCreateButton(130, 76, 77, 25, "Cancel", false, paymentGUI.window[1])
