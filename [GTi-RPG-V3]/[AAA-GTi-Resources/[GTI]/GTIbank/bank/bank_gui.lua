----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 23 Sept 2014
-- Resource: GTIbank/bank_gui.lua
-- Version: 1.0
----------------------------------------->>

-- Main Banking GUI
-------------------->>

bankGUI = {scrollpane = {}, label = {}, button = {}, window = {}, staticimage = {}, gridlist = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 426, 402-28
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 595, 200, 426, 402
bankGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "L.S. Financial & Co. — My Accounts", false)
guiWindowSetSizable(bankGUI.window[1], false)
guiSetAlpha(bankGUI.window[1], 0.90)
guiSetVisible(bankGUI.window[1], false)
-- Static Image
bankGUI.staticimage[1] = guiCreateStaticImage(9, 25, 408, 77, "files/ls_bank.png", false, bankGUI.window[1])
-- Labels (Static)
bankGUI.label[1] = guiCreateLabel(12, 138-28, 190, 15, "My Bank Accounts", false, bankGUI.window[1])
guiSetFont(bankGUI.label[1], "default-bold-small")
guiLabelSetColor(bankGUI.label[1], 25, 255, 25)
bankGUI.label[7] = guiCreateLabel(294, 138-28, 105, 15, "Account Balance", false, bankGUI.window[1])
guiSetFont(bankGUI.label[7], "default-bold-small")
guiLabelSetColor(bankGUI.label[7], 25, 255, 25)
guiLabelSetHorizontalAlign(bankGUI.label[7], "center", false)
-- Labels (Dynamic)
	--bankGUI.label[6] = guiCreateLabel(12, 114, 401, 15, "Select an account below to manage it", false, bankGUI.window[1])
	--guiLabelSetHorizontalAlign(bankGUI.label[6], "center", false)
bankGUI.label[8] = guiCreateLabel(111, 374-28, 205, 15, "[Click to Log Out]", false, bankGUI.window[1])
guiLabelSetHorizontalAlign(bankGUI.label[8], "center", false)
-- Gridlist
bankGUI.gridlist[1] = guiCreateGridList(9, 157-28, 408, 184, false, bankGUI.window[1])
-- Buttons
bankGUI.button[1] = guiCreateButton(9, 347-28, 101, 22, "Transactions", false, bankGUI.window[1])
bankGUI.button[2] = guiCreateButton(114, 347-28, 101, 22, "Transfer", false, bankGUI.window[1])
bankGUI.button[3] = guiCreateButton(218, 347-28, 101, 22, "Account Log", false, bankGUI.window[1])
bankGUI.button[4] = guiCreateButton(322, 347-28, 95, 22, "Options", false, bankGUI.window[1])

-- Account Login
----------------->>

bankLoginGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 364, 117
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 618, 375, 364, 117
bankLoginGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank Login", false)
guiWindowSetSizable(bankLoginGUI.window[1], false)
guiSetAlpha(bankLoginGUI.window[1], 0.90)
guiSetVisible(bankLoginGUI.window[1], false)
-- Labels
bankLoginGUI.label[1] = guiCreateLabel(8, 26, 346, 15, "Enter your GTI account password to access your finances.", false, bankLoginGUI.window[1])
guiLabelSetColor(bankLoginGUI.label[1], 25, 255, 25)
guiLabelSetHorizontalAlign(bankLoginGUI.label[1], "center", false)
bankLoginGUI.label[2] = guiCreateLabel(12, 55, 56, 15, "Password:", false, bankLoginGUI.window[1])
-- Editbox
bankLoginGUI.edit[1] = guiCreateEdit(73, 52, 280, 22, "", false, bankLoginGUI.window[1])
guiEditSetMasked(bankLoginGUI.edit[1], true)
guiEditSetMaxLength(bankLoginGUI.edit[1], 32)
-- Button
bankLoginGUI.button[1] = guiCreateButton(97, 82, 81, 24, "Login", false, bankLoginGUI.window[1])
bankLoginGUI.button[2] = guiCreateButton(189, 82, 81, 24, "Cancel", false, bankLoginGUI.window[1])

-- Security Check
------------------>>

bankPINGUI = {button = {}, window = {}, edit = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 214, 131
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 687, 363, 214, 131
bankPINGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank — Security Check", false)
guiWindowSetSizable(bankPINGUI.window[1], false)
guiSetAlpha(bankPINGUI.window[1], 0.90)
guiSetVisible(bankPINGUI.window[1], false)
-- Label (Static)
bankPINGUI.label[1] = guiCreateLabel(27, 29, 160, 15, "Enter your bank account PIN", false, bankPINGUI.window[1])
guiLabelSetColor(bankPINGUI.label[1], 25, 255, 25)
-- Label (Dynamic)
bankPINGUI.label[2] = guiCreateLabel(35, 77, 145, 15, "Forgot your PIN?", false, bankPINGUI.window[1])
guiSetFont(bankPINGUI.label[2], "default-bold-small")
guiLabelSetHorizontalAlign(bankPINGUI.label[2], "center", false)
-- Edit
bankPINGUI.edit[1] = guiCreateEdit(59, 52, 97, 22, "", false, bankPINGUI.window[1])
guiEditSetMasked(bankPINGUI.edit[1], true)
guiEditSetMaxLength(bankPINGUI.edit[1], 10)
-- Buttons
bankPINGUI.button[1] = guiCreateButton(29, 96, 72, 20, "Continue", false, bankPINGUI.window[1])
bankPINGUI.button[2] = guiCreateButton(112, 96, 72, 20, "Cancel", false, bankPINGUI.window[1])

-- Make Transaction
-------------------->>

transactionGUI = {label = {}, edit = {}, button = {}, window = {}, radiobutton = {}, combobox = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 238, 242
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 690, 323, 238, 242
transactionGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank — Make Transaction", false)
guiWindowSetSizable(transactionGUI.window[1], false)
guiSetAlpha(transactionGUI.window[1], 0.90)
guiSetVisible(transactionGUI.window[1], false)
-- Labels (Static)
transactionGUI.label[1] = guiCreateLabel(21, 42, 102, 15, "Transaction Type:", false, transactionGUI.window[1])
guiSetFont(transactionGUI.label[1], "default-bold-small")
guiLabelSetColor(transactionGUI.label[1], 25, 255, 25)
transactionGUI.label[2] = guiCreateLabel(7, 68, 225, 15, "_____________________________________", false, transactionGUI.window[1])
transactionGUI.label[3] = guiCreateLabel(21, 91, 102, 15, "Selected Account:", false, transactionGUI.window[1])
guiSetFont(transactionGUI.label[3], "default-bold-small")
guiLabelSetColor(transactionGUI.label[3], 25, 255, 25)
transactionGUI.label[4] = guiCreateLabel(7, 133, 225, 15, "_____________________________________", false, transactionGUI.window[1])
transactionGUI.label[5] = guiCreateLabel(13, 158, 100, 15, "Account Balance:", false, transactionGUI.window[1])
transactionGUI.label[7] = guiCreateLabel(19, 182, 50, 15, "Amount:", false, transactionGUI.window[1])
guiSetFont(transactionGUI.label[7], "default-bold-small")
guiLabelSetColor(transactionGUI.label[7], 25, 255, 25)
-- Labels (Dynamic)
transactionGUI.label[6] = guiCreateLabel(122, 158, 100, 15, "$1,000,000,000", false, transactionGUI.window[1])
guiSetFont(transactionGUI.label[6], "default-bold-small")
guiLabelSetColor(transactionGUI.label[6], 25, 255, 25)
guiLabelSetHorizontalAlign(transactionGUI.label[6], "right", false)
-- Radio Buttons
transactionGUI.radiobutton[1] = guiCreateRadioButton(131, 32, 90, 15, "Deposit", false, transactionGUI.window[1])
guiRadioButtonSetSelected(transactionGUI.radiobutton[1], true)
transactionGUI.radiobutton[2] = guiCreateRadioButton(131, 54, 89, 15, "Withdrawal", false, transactionGUI.window[1])
-- Combobox
transactionGUI.combobox[1] = guiCreateComboBox(20, 111, 190, 23, "", false, transactionGUI.window[1])
-- Editbox
transactionGUI.edit[1] = guiCreateEdit(76, 180, 138, 19, "", false, transactionGUI.window[1])
-- Buttons
transactionGUI.button[1] = guiCreateButton(23, 207, 95, 21, "Accept", false, transactionGUI.window[1])
transactionGUI.button[2] = guiCreateButton(123, 207, 95, 21, "Cancel", false, transactionGUI.window[1])

-- Make Transfer
----------------->>

transferGUI = {radiobutton = {}, button = {}, window = {}, label = {}, combobox = {}, edit = {}, transfer = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 238, 294
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 683, 273, 238, 253
transferGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank — Make Transfer", false)
guiWindowSetSizable(transferGUI.window[1], false)
guiSetAlpha(transferGUI.window[1], 0.90)
guiSetVisible(transferGUI.window[1], false)
-- Labels (Static)
transferGUI.label[1] = guiCreateLabel(35, 27, 163, 15, "Transfer from this Account...", false, transferGUI.window[1])
guiSetFont(transferGUI.label[1], "default-bold-small")
guiLabelSetColor(transferGUI.label[1], 25, 255, 25)
guiLabelSetHorizontalAlign(transferGUI.label[1], "center", false)
transferGUI.label[2] = guiCreateLabel(21, 79, 94, 15, "Account Balance:", false, transferGUI.window[1])
transferGUI.label[4] = guiCreateLabel(8, 91, 219, 15, "________________________________________", false, transferGUI.window[1])
transferGUI.label[5] = guiCreateLabel(35, 113, 163, 15, "...to this Account", false, transferGUI.window[1])
guiSetFont(transferGUI.label[5], "default-bold-small")
guiLabelSetColor(transferGUI.label[5], 25, 255, 25)
guiLabelSetHorizontalAlign(transferGUI.label[5], "center", false)
transferGUI.label[6] = guiCreateLabel(8, 91, 219, 15, "________________________________________", false, transferGUI.window[1])
transferGUI.label[7] = guiCreateLabel(20, 230, 48, 15, "Amount:", false, transferGUI.window[1])
guiSetFont(transferGUI.label[7], "default-bold-small")
guiLabelSetColor(transferGUI.label[7], 25, 255, 25)
transferGUI.label[8] = guiCreateLabel(8, 201, 219, 15, "________________________________________", false, transferGUI.window[1])
-- Labels (Dynamic)
transferGUI.label[3] = guiCreateLabel(118, 79, 99, 15, "$1,000,000,000", false, transferGUI.window[1])
-- Comboboxes
transferGUI.combobox[1] = guiCreateComboBox(19, 48, 198, 23, "", false, transferGUI.window[1])
guiSetFont(transferGUI.label[3], "default-bold-small")
guiLabelSetColor(transferGUI.label[3], 25, 255, 25)
guiLabelSetHorizontalAlign(transferGUI.label[3], "right", false)
transferGUI.transfer[1] = guiCreateComboBox(19, 134, 198, 23, "", false, transferGUI.window[1])
-- Radiobuttons
transferGUI.radiobutton[1] = guiCreateRadioButton(20, 166, 198, 15, "Transfer to Another Account", false, transferGUI.window[1])
guiRadioButtonSetSelected(transferGUI.radiobutton[1], true)
transferGUI.radiobutton[2] = guiCreateRadioButton(20, 189, 198, 15, "Transfer Between My Accounts", false, transferGUI.window[1])
-- Editboxes
transferGUI.edit[1] = guiCreateEdit(73, 227, 147, 20, "", false, transferGUI.window[1])
-- Buttons
transferGUI.button[1] = guiCreateButton(26, 255, 89, 21, "Transfer", false, transferGUI.window[1])
transferGUI.button[2] = guiCreateButton(123, 255, 89, 21, "Cancel", false, transferGUI.window[1])

-- Transaction Log
------------------->>

transLogGUI = {tab = {}, tabpanel = {}, label = {}, gridlist = {}, window = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 625, 525
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 481, 175, 625, 525
transLogGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Bank — Transaction Log", false)
guiWindowSetSizable(transLogGUI.window[1], false)
guiSetAlpha(transLogGUI.window[1], 0.90)
guiSetVisible(transLogGUI.window[1], false)
-- Label
transLogGUI.label[1] = guiCreateLabel(249, 497, 130, 15, "[Close Transaction Log]", false, transLogGUI.window[1])
-- Tab Panel
transLogGUI.tabpanel[1] = guiCreateTabPanel(9, 24, 607, 468, false, transLogGUI.window[1])
	-- Tab (Cash)
	transLogGUI.tab[1] = guiCreateTab("Cash", transLogGUI.tabpanel[1])
	-- Gridlist
	transLogGUI.gridlist[1] = guiCreateGridList(10, 8, 588, 423, false, transLogGUI.tab[1])
	guiGridListAddColumn(transLogGUI.gridlist[1], "Date", 0.15)
	guiGridListAddColumn(transLogGUI.gridlist[1], "Description", 0.50)
	guiGridListAddColumn(transLogGUI.gridlist[1], "Amount", 0.15)
	guiGridListAddColumn(transLogGUI.gridlist[1], "New Balance", 0.15)
	guiGridListSetSortingEnabled(transLogGUI.gridlist[1], false)
	
	transLogGUI.tab[2] = guiCreateTab("Main Account", transLogGUI.tabpanel[1])
	transLogGUI.gridlist[2] = guiCreateGridList(10, 8, 588, 423, false, transLogGUI.tab[2])
	guiGridListAddColumn(transLogGUI.gridlist[2], "Date", 0.15)
	guiGridListAddColumn(transLogGUI.gridlist[2], "Description", 0.50)
	guiGridListAddColumn(transLogGUI.gridlist[2], "Amount", 0.15)
	guiGridListAddColumn(transLogGUI.gridlist[2], "New Balance", 0.15)
	guiGridListSetSortingEnabled(transLogGUI.gridlist[1], false)
