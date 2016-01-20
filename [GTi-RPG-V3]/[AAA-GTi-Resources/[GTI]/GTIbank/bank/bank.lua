----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 23 Sept 2014
-- Resource: GTIbank/bank.lua
-- Version: 1.0
----------------------------------------->>

local bank_logos = {
	["San Fierro Bank"] 		= "sf_bank.png",
	["L.S. Financial & Co."] 	= "ls_bank.png",
	["Bank of Venturas"] 		= "lv_bank.png",
}

local bankAcounts = {}	-- Cache of Bank Accounts

addEvent("onClientPlayerGiveMoney", true)
addEvent("onClientPlayerTakeMoney", true)

addEventHandler("onClientPedDamage", resourceRoot, cancelEvent)

-- Bank Login
-------------->>

addEvent("GTIbank.bankAccountLogin", true)
addEventHandler("GTIbank.bankAccountLogin", root, function()
	guiSetText(bankLoginGUI.edit[1], "")
	guiSetText(bankLoginGUI.label[1], "Enter your GTI account password to access your finances.")
	guiLabelSetColor(bankLoginGUI.label[1], 25, 255, 25)
	guiSetVisible(bankLoginGUI.window[1], true)
	showCursor(true)
end)

addEventHandler("onClientGUIClick", bankLoginGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(bankLoginGUI.window[1], false)
	showCursor(false)
end, false)

function attemptBankLogin(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local password = guiGetText(bankLoginGUI.edit[1])
	if (#password == 0) then return end
	triggerServerEvent("GTIbank.bankAccountLogin", resourceRoot, password)
end
addEventHandler("onClientGUIClick", bankLoginGUI.button[1], attemptBankLogin, false)

addEventHandler("onClientGUIAccepted", bankLoginGUI.edit[1], function()
	attemptBankLogin("left", "up")
end)

-- PIN Security
---------------->>

addEvent("GTIbank.bankAccountLogin2", true)
addEventHandler("GTIbank.bankAccountLogin2", root, function()
	guiSetText(bankPINGUI.edit[1], "")
	guiSetVisible(bankPINGUI.window[1], true)
	guiSetVisible(bankLoginGUI.window[1], false)
end)

addEventHandler("onClientGUIClick", bankPINGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(bankPINGUI.window[1], false)
	showCursor(false)
end, false)

function attemptBankLogin2(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local pin = guiGetText(bankPINGUI.edit[1])
	if (#pin == 0) then return end
	triggerServerEvent("GTIbank.bankAccountLogin", resourceRoot, pin, true)
end
addEventHandler("onClientGUIClick", bankPINGUI.button[1], attemptBankLogin2, false)

addEventHandler("onClientGUIAccepted", bankPINGUI.edit[1], function()
	attemptBankLogin2("left", "up")
end)

-- Bank Account Home
--------------------->>

addEvent("GTIbank.displayBankAccount", true)
addEventHandler("GTIbank.displayBankAccount", root, function(banks, dim)
	if (not banks) then
		guiSetText(bankLoginGUI.label[1], "Invalid Password Provided. Check your password.")
		guiLabelSetColor(bankLoginGUI.label[1], 255, 25, 25)
		return
	end
	
	if (bankGUI.scrollpane[1]) then destroyElement(bankGUI.scrollpane[1]) end
	bankGUI.scrollpane[1] = guiCreateScrollPane(14, 162-28, 403, 174, false, bankGUI.window[1])
	
	local offset = 45
	bankGUI.account = {}
	for i,v in ipairs(banks) do
		
		i = i - 1
		bankGUI.account[i+1] = {}
		
		bankGUI.account[i+1][1] = guiCreateLabel(6, 6+(i*offset), 277, 15, v[1], false, bankGUI.scrollpane[1])
		bankGUI.account[i+1][2] = guiCreateLabel(6, 25+(i*offset), 276, 15, "Acc#: "..v[2].." - Last Transaction: "..(v[3] or "Unknown"), false, bankGUI.scrollpane[1])
		guiSetFont(bankGUI.account[i+1][2], "default-small")
		bankGUI.account[i+1][3] = guiCreateLabel(287, 15+(i*offset), 95, 15, "$"..exports.GTIutil:tocomma(v[4]), false, bankGUI.scrollpane[1])
		guiSetFont(bankGUI.account[i+1][3], "default-bold-small")
		guiLabelSetColor(bankGUI.account[i+1][3], 25, 255, 25)
		guiLabelSetHorizontalAlign(bankGUI.account[i+1][3], "right", false)
		bankGUI.account[i+1][4] = guiCreateLabel(5, 6+(i*offset), 377, 40, "________________________________________________________________", false, bankGUI.scrollpane[1])
		guiLabelSetVerticalAlign(bankGUI.account[i+1][4], "bottom")
	end
	
	if (not guiGetVisible(bankGUI.window[1])) then
		exports.GTIhud:dm("Bank Account login successful. Welcome, "..getPlayerName(localPlayer), 25, 255, 25)
	end
	
		-- Set Bank Name
	local bank_name = dim[getElementDimension(localPlayer)]
	guiSetText(bankGUI.window[1], bank_name.." — My Accounts")
		-- Set Bank Logo
	destroyElement(bankGUI.staticimage[1])
	bankGUI.staticimage[1] = guiCreateStaticImage(9, 25, 408, 77, "files/"..bank_logos[bank_name], false, bankGUI.window[1])
		-- Show Accounts
	guiSetVisible(bankLoginGUI.window[1], false)
	guiSetVisible(bankGUI.window[1], true)
	
		-- Hide Everything Else
	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		if (window ~= bankGUI.window[1]) then
			guiSetVisible(window, false)
		end
	end
	--guiSetEnabled(transactionGUI.button[1], true)
	--guiSetEnabled(transferGUI.button[1], true)
end)

addEventHandler("onClientGUIClick", bankGUI.label[8], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		guiSetVisible(window, false)
	end
	triggerServerEvent("GTIbank.stopAnimation", resourceRoot)
	showCursor(false)
end, false)

addEventHandler("onClientPlayerWasted", localPlayer, function()
	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		guiSetVisible(window, false)
	end
	showCursor(false)
end)

addEventHandler("onClientMouseEnter", bankGUI.label[8], function()
	guiLabelSetColor(source, 25, 255, 25)
end, false)

addEventHandler("onClientMouseLeave", bankGUI.label[8], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

-- Make Transaction
-------------------->>

addEventHandler("onClientGUIClick", bankGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	guiRadioButtonSetSelected(transactionGUI.radiobutton[1], true)
	
	guiComboBoxClear(transactionGUI.combobox[1])
	for i,v in ipairs(bankGUI.account) do
		local acc_name = guiGetText(v[1])
		acc_name = string.match(acc_name, "%a* Account")
		guiComboBoxAddItem(transactionGUI.combobox[1], acc_name)
	end
	
	guiComboBoxSetSelected(transactionGUI.combobox[1], 0)
	guiSetSize(transactionGUI.combobox[1], 190, 25 + (#bankGUI.account * 20), false)		
	
	guiSetText(transactionGUI.edit[1], "")
	guiSetText(transactionGUI.label[6], guiGetText(bankGUI.account[1][3]))
	
	guiBringToFront(transactionGUI.window[1])
	guiSetVisible(transactionGUI.window[1], true)
end, false)

addEventHandler("onClientGUIClick", transactionGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local deposit = guiRadioButtonGetSelected(transactionGUI.radiobutton[1])
	
	local item = guiComboBoxGetSelected(transactionGUI.combobox[1])
	local account = guiComboBoxGetItemText(transactionGUI.combobox[1], item)
	
	local amount = guiGetText(transactionGUI.edit[1])
	if (#amount == 0 or not tonumber(amount)) then
		exports.GTIhud:dm("Please enter a valid amount to deposit or withdraw.", 255, 125, 25)
		return
	end
	
	--guiSetEnabled(transactionGUI.button[1], false)
	
	amount = math.floor(math.abs(tonumber(amount)))
	triggerServerEvent("GTIbank.makeTransaction", resourceRoot, deposit, account, amount)
end, false)

addEventHandler("onClientGUIComboBoxAccepted", transactionGUI.combobox[1], function()
	local item = guiComboBoxGetSelected(source)
	guiSetText(transactionGUI.edit[1], "")
	guiSetText(transactionGUI.label[6], guiGetText(bankGUI.account[item+1][3]))
end, false)

addEventHandler("onClientGUIClick", transactionGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(transactionGUI.window[1], false)
end, false)

-- Make Transfer
----------------->>

addEventHandler("onClientGUIClick", bankGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	guiComboBoxClear(transferGUI.combobox[1])
	for i,v in ipairs(bankGUI.account) do
		local acc_name = guiGetText(v[1])
		acc_name = string.match(acc_name, "%a* Account")
		guiComboBoxAddItem(transferGUI.combobox[1], acc_name)
	end
	guiComboBoxSetSelected(transferGUI.combobox[1], 0)
	guiSetSize(transferGUI.combobox[1], 190, 25 + (#bankGUI.account * 20), false)		
	
	guiSetText(transferGUI.label[3], guiGetText(bankGUI.account[1][3]))
	
	guiRadioButtonSetSelected(transferGUI.radiobutton[1], true)
	if (#bankGUI.account == 1) then
		guiSetEnabled(transferGUI.radiobutton[1], false)
		guiSetEnabled(transferGUI.radiobutton[2], false)
	else
		guiSetEnabled(transferGUI.radiobutton[1], true)
		guiSetEnabled(transferGUI.radiobutton[2], true)
	end
	
	destroyElement(transferGUI.transfer[1])
	transferGUI.transfer[1] = guiCreateEdit(19, 134, 198, 23, "Enter Account Name...", false, transferGUI.window[1])
	
	guiSetText(transferGUI.edit[1], "")
	
	guiBringToFront(transferGUI.window[1])
	guiSetVisible(transferGUI.window[1], true)
end, false)

addEventHandler("onClientGUIClick", transferGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local item = guiComboBoxGetSelected(transferGUI.combobox[1])
	local from_account = guiComboBoxGetItemText(transferGUI.combobox[1], item)
	
	local new_account = guiRadioButtonGetSelected(transferGUI.radiobutton[1])
	
	local to_account
	if (new_account) then
		to_account = guiGetText(transferGUI.transfer[1])
	else
		local item = guiComboBoxGetSelected(transferGUI.transfer[1])
		to_account = guiComboBoxGetItemText(transferGUI.transfer[1], item)
	end	
	
	local amount = guiGetText(transferGUI.edit[1])
	if (#amount == 0 or not tonumber(amount)) then
		exports.GTIhud:dm("Please enter a valid amount to deposit or withdraw.", 255, 125, 25)
		return
	end
	
	--guiSetEnabled(transferGUI.button[1], false)
	
	amount = math.floor(math.abs(tonumber(amount)))
	triggerServerEvent("GTIbank.makeTransfer", resourceRoot, from_account, new_account, to_account, amount)
end, false)

addEventHandler("onClientGUIClick", transferGUI.window[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	if (source == transferGUI.radiobutton[1]) then
		if (getElementType(transferGUI.transfer[1]) == "gui-edit") then return end
		destroyElement(transferGUI.transfer[1])
		transferGUI.transfer[1] = guiCreateEdit(19, 134, 198, 23, "Enter Account Name...", false, transferGUI.window[1])
	elseif (source == transferGUI.radiobutton[2]) then
		if (getElementType(transferGUI.transfer[1]) == "gui-combobox") then return end
		destroyElement(transferGUI.transfer[1])
		transferGUI.transfer[1] = guiCreateComboBox(19, 134, 198, 23, "Enter Account Name...", false, transferGUI.window[1])
		for i,v in ipairs(bankGUI.account) do
			local acc_name = guiGetText(v[1])
			acc_name = string.match(acc_name, "%a* Account")
			guiComboBoxAddItem(transferGUI.transfer[1], acc_name)
		end
		guiComboBoxSetSelected(transferGUI.transfer[1], 0)
		guiSetSize(transferGUI.transfer[1], 190, 25 + (#bankGUI.account * 20), false)	
	end
end)

addEventHandler("onClientGUIComboBoxAccepted", transferGUI.combobox[1], function()
	local item = guiComboBoxGetSelected(source)
	guiSetText(transferGUI.label[3], guiGetText(bankGUI.account[item+1][3]))
end, false)

addEventHandler("onClientGUIClick", transferGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(transferGUI.window[1], false)
end, false)

-- Transaction Log
------------------->>

addEventHandler("onClientGUIClick", bankGUI.button[3], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerServerEvent("GTIbank.transactionLog", resourceRoot)
end, false)

addEvent("GTIbank.transactionLog", true)
addEventHandler("GTIbank.transactionLog", root, function(category, logs)
	local i
	if (category == "cash") then
		i = 1
	elseif (category == "bank") then
		i = 2
	elseif (category == "groupbank") then
		i = 3
		if (transLogGUI.tab[3]) then guiDeleteTab(transLogGUI.tab[3], transLogGUI.tabpanel[1]) transLogGUI.tab[3] = nil end
		transLogGUI.tab[3] = guiCreateTab("Group Account", transLogGUI.tabpanel[1])
		transLogGUI.gridlist[3] = guiCreateGridList(10, 8, 588, 423, false, transLogGUI.tab[3])
		guiGridListAddColumn(transLogGUI.gridlist[3], "Date", 0.15)
		guiGridListAddColumn(transLogGUI.gridlist[3], "Description", 0.50)
		guiGridListAddColumn(transLogGUI.gridlist[3], "Amount", 0.15)
		guiGridListAddColumn(transLogGUI.gridlist[3], "New Balance", 0.15)
		guiGridListSetSortingEnabled(transLogGUI.gridlist[3], false)
	end
	
	guiGridListClear(transLogGUI.gridlist[i])
	for j=1,#logs do
		v = logs[j]
		local row = guiGridListAddRow(transLogGUI.gridlist[i])
			
		local day,mo,yr = exports.GTIutil:todate(v.timestamp)
		local day,mo = string.format("%02d", day), string.format("%02d", mo)
		guiGridListSetItemText(transLogGUI.gridlist[i], row, 1, yr.."-"..mo.."-"..day, false, false)
		--[[
		local hr,min,sec = exports.GTIutil:totime(v.timestamp)
		local hr,min,sec = string.format("%02d", hr), string.format("%02d", min), string.format("%02d", sec)
		guiGridListSetItemText(transLogGUI.gridlist[i], row, 2, hr..":"..min..":"..sec, false, false)
		--]]
		guiGridListSetItemText(transLogGUI.gridlist[i], row, 2, v.text, false, false)
		
		guiGridListSetItemText(transLogGUI.gridlist[i], row, 3, (v.cash >= 0 and "$"..exports.GTIutil:tocomma(v.cash) or "-$"..exports.GTIutil:tocomma(math.abs(v.cash))), false, false)
		if (v.cash >= 0) then
			guiGridListSetItemColor(transLogGUI.gridlist[i], row, 3, 25, 255, 25)
		else
			guiGridListSetItemColor(transLogGUI.gridlist[i], row, 3, 255, 25, 25)
		end
		
		guiGridListSetItemText(transLogGUI.gridlist[i], row, 4, "$"..exports.GTIutil:tocomma(v.balance), false, false)
	end
	guiBringToFront(transLogGUI.window[1])
	guiSetVisible(transLogGUI.window[1], true)
end)

addEventHandler("onClientGUIClick", transLogGUI.label[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(transLogGUI.window[1], false)
end, false)

addEventHandler("onClientMouseEnter", transLogGUI.label[1], function()
	guiLabelSetColor(source, 25, 255, 25)
end, false)

addEventHandler("onClientMouseLeave", transLogGUI.label[1], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)
