----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 24 Sept 2014
-- Resource: GTIbank/atm.lua
-- Version: 1.0
----------------------------------------->>

-- ATM Login
------------->>

addEvent("GTIbank.atmLogin", true)
addEventHandler("GTIbank.atmLogin", root, function()
	guiSetText(atmLoginGUI.edit[1], "")
	guiSetText(atmLoginGUI.label[1], "Enter your bank account PIN")
	guiLabelSetColor(atmLoginGUI.label[1], 25, 255, 25)
	guiSetVisible(atmLoginGUI.window[1], true)
	showCursor(true)
end)

addEventHandler("onClientGUIClick", atmLoginGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(atmLoginGUI.window[1], false)
	showCursor(false)
end, false)


function attemptATMLogin(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local pin = guiGetText(atmLoginGUI.edit[1])
	if (#pin == 0) then return end
	triggerServerEvent("GTIbank.atmLogin", resourceRoot, pin)
end
addEventHandler("onClientGUIClick", atmLoginGUI.button[1], attemptATMLogin, false)

addEventHandler("onClientGUIAccepted", atmLoginGUI.edit[1], function()
	attemptATMLogin("left", "up")
end)

-- ATM Main Menu
----------------->>

addEvent("GTIbank.displayATMMenu", true)
addEventHandler("GTIbank.displayATMMenu", root, function(account, balance)
	if (not account) then
		guiSetText(atmLoginGUI.label[1], "Invalid PIN Provided.")
		guiLabelSetColor(atmLoginGUI.label[1], 255, 25, 25)
		return
	end

	guiSetText(atmGUI.label[2], account)
	guiSetText(atmGUI.label[1], "$"..exports.GTIutil:tocomma(balance))
	guiSetText(atmGUI.edit[1], "")
	
	guiSetVisible(atmGUI.window[1], true)
	guiSetVisible(atmLoginGUI.window[1], false)
end)

addEventHandler("onClientGUIClick", atmGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerServerEvent("GTIbank.stopAnimation", resourceRoot)
	guiSetVisible(atmGUI.window[1], false)
	showCursor(false)
end, false)

-- Make Withdrawal
------------------->>

addEventHandler("onClientGUIClick", atmGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local amount = guiGetText(atmGUI.edit[1])
	if (#amount == 0 or not tonumber(amount)) then
		exports.GTIhud:dm("Please enter a valid amount to withdraw.", 255, 125, 25)
		return
	end
	
	amount = math.floor(math.abs(tonumber(amount)))
	triggerServerEvent("GTIbank.makeATMWithdrawal", resourceRoot, amount)
end, false)
