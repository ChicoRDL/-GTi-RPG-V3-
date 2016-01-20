----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 09 Jan 2015
-- Resource: GTIpremium/shop.lua
-- Type: Client Side
----------------------------------------->>

local sec_premium	-- Premium Time Cache
local sec_offset	-- Difference Between Server & Local Time
local token_cost	-- Token Cost Cache
local p_method		-- Pay Method Cache
local player_tokens	-- Player's tokens.
local player_perm	-- Player's perm tokens.

-- Open/Close Shop
------------------->>

addEvent("GTIpremium.openShop", true)
addEventHandler("GTIpremium.openShop", root, function(tokens, perm_tokens, plr_items, premium_items, premium_time, server_time, token_price)
	sec_premium = premium_time
	sec_offset = server_time - getRealTime().timestamp
	token_cost = token_price
	player_tokens = tokens
	player_perm = perm_tokens

	guiSetText(premiumGUI.label[2], exports.GTIutil:tocomma(player_tokens))
	guiSetText(premiumGUI.label[7], exports.GTIutil:tocomma(player_perm))

	guiGridListClear(premiumGUI.gridlist[1])
	for i,v in ipairs(premium_items) do
		local row = guiGridListAddRow(premiumGUI.gridlist[1])
		if (not v[2]) then
			guiGridListSetItemText(premiumGUI.gridlist[1], row, 1, v[1], true, false)
			guiGridListSetItemColor(premiumGUI.gridlist[1], row, 1, 0, 178, 240)
		else
			guiGridListSetItemText(premiumGUI.gridlist[1], row, 1, v[2], false, false)
			if (not v[4]) then
				guiGridListSetItemColor(premiumGUI.gridlist[1], row, 1, 255, 25, 25)
			elseif (plr_items[v[1]] == 1) then
				guiGridListSetItemColor(premiumGUI.gridlist[1], row, 1, 0, 151, 204)
			elseif (plr_items[v[1]] == 2) then
				guiGridListSetItemColor(premiumGUI.gridlist[1], row, 1, 0, 240, 178)
			end
			
			guiGridListSetItemText(premiumGUI.gridlist[1], row, 2, v[3].." Ŧ", false, false)
			if (tokens < v[3] and perm_tokens < v[3]) then
				guiGridListSetItemColor(premiumGUI.gridlist[1], row, 2, 255, 25, 25)
			else
				guiGridListSetItemColor(premiumGUI.gridlist[1], row, 2, 0, 178, 240)
			end
		end
	end
	
	guiSetVisible(premiumGUI.window[1], true)
	showCursor(true)
end)

addEvent("GTIpremium.closePanel", true)
addEventHandler("GTIpremium.closePanel", root, function()
	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		guiSetVisible(window, false)
	end
	sec_premium = nil
	sec_offset = nil
	token_cost = nil
	p_method = nil
	player_tokens = nil
	showCursor(false)	
end)

addEventHandler("onClientGUIClick", premiumGUI.button[3], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerEvent("GTIpremium.closePanel", localPlayer)
end, false)

addEventHandler("onClientPlayerWasted", localPlayer, function()
	triggerEvent("GTIpremium.closePanel", localPlayer)
end)

-- Purchase Item
----------------->>

	-- Show Confirmation Window -->>
addEventHandler("onClientGUIClick", premiumGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local row = guiGridListGetSelectedItem(premiumGUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item that you wish to purchase.", 255, 125, 0)
		return
	end
	
	local r,g,b = guiGridListGetItemColor(premiumGUI.gridlist[1], row, 1)
	if (r == 255 and g == 25 and b == 25) then
		exports.GTIhud:dm("This item is not yet available, you cannot purchase it yet.", 255, 125, 0)
		return
	end
	
	local r,g,b = guiGridListGetItemColor(premiumGUI.gridlist[1], row, 1)
	if ((r == 0 and g == 151 and b == 204) or (r == 0 and g == 240 and b == 178)) then
		exports.GTIhud:dm("You have already purchased this item. You cannot renew it until it has expired.", 255, 125, 0)
		return
	end
	
	local desc = guiGridListGetItemText(premiumGUI.gridlist[1], row, 1)
	local cost = guiGridListGetItemText(premiumGUI.gridlist[1], row, 2) 
	
	local tokens = player_tokens
	local p_tokens = player_perm
	local my_cost = string.gsub(cost, "%D", "")
	local my_cost = tonumber( my_cost )
	
	outputDebugString("[DEBUG] - Tokens: "..tostring(tokens)..", My cost: "..tostring(my_cost)..", Cost: "..tostring(cost))
	
	if (tokens < my_cost) then
		if (p_tokens < my_cost) then
			exports.GTIhud:dm("You cannot afford to purchase this item. You need "..my_cost-tokens.." more Ŧokens.", 255, 125, 0)
			return
		end
	end
	
	guiSetText(confirmGUI.label[2], desc)
	guiSetText(confirmGUI.label[4], cost)
	local day,month,year = exports.GTIutil:todate(getRealTime().timestamp + sec_offset + sec_premium)
	day = string.format("%02d", day)
	month = exports.GTIutil:getMonthName(month)
	guiSetText(confirmGUI.label[6], day.." "..month.." "..year)
	
	playSoundFrontEnd(5)
	
	guiBringToFront(confirmGUI.window[1])
	guiSetVisible(confirmGUI.window[1], true)
end, false)

	-- Purchase Item -->>
addEventHandler("onClientGUIClick", confirmGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local p_tokens = player_tokens
	if (p_tokens > 0) then
		selectPaymentMethod()
		return
	end
	
	local row = guiGridListGetSelectedItem(premiumGUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item that you wish to purchase.", 255, 125, 0)
		return
	end
	local desc = guiGridListGetItemText(premiumGUI.gridlist[1], row, 1)
	triggerServerEvent("GTIpremium.purchaseItem", resourceRoot, desc, true)
end, false)

	-- Cancel -->>
addEventHandler("onClientGUIClick", confirmGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(confirmGUI.window[1], false)
end, false)

-- Select Payment Method
------------------------->>

function selectPaymentMethod()
	local tokens = player_tokens
	guiSetText(paymentGUI.radiobutton[1], "Use Ŧokens ("..exports.GTIutil:tocomma(tokens).." Remaining)")
	local p_tokens = player_perm
	guiSetText(paymentGUI.radiobutton[2], "Use Perm. Ŧokens ("..exports.GTIutil:tocomma(p_tokens).." Remaining)")
	guiBringToFront(paymentGUI.window[1])
	guiSetVisible(paymentGUI.window[1], true)
end

	-- Continue -->>
addEventHandler("onClientGUIClick", paymentGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local use_tokens = guiRadioButtonGetSelected(paymentGUI.radiobutton[1]) or false
	
	local row = guiGridListGetSelectedItem(premiumGUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item that you wish to purchase.", 255, 125, 0)
		return
	end
	local desc = guiGridListGetItemText(premiumGUI.gridlist[1], row, 1)
	triggerServerEvent("GTIpremium.purchaseItem", resourceRoot, desc, use_tokens)
end, false)

	-- Close -->>
addEventHandler("onClientGUIClick", paymentGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(paymentGUI.window[1], false)
end, false)

-- Conflict Warning
-------------------->>
	
	-- Show Conflict Warning
addEvent("GTIpremium.conflictWarning", true)
addEventHandler("GTIpremium.conflictWarning", root, function(desc, pay_method)
	p_method = pay_method
	guiSetText(conflictGUI.label[3], desc)
	guiBringToFront(conflictGUI.window[1])
	guiSetVisible(conflictGUI.window[1], true)
end)

	-- Purchase Item -->>
addEventHandler("onClientGUIClick", conflictGUI.button[1], function(button, state)
	local row = guiGridListGetSelectedItem(premiumGUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item that you wish to purchase.", 255, 125, 0)
		return
	end
	local desc = guiGridListGetItemText(premiumGUI.gridlist[1], row, 1)
	triggerServerEvent("GTIpremium.purchaseItem", resourceRoot, desc, p_method, true)
end, false)

	-- Cancel -->>
addEventHandler("onClientGUIClick", conflictGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(conflictGUI.window[1], false)
end, false)

-- Purchase Tokens
------------------->>

	-- Show Purchase Window -->>
addEventHandler("onClientGUIClick", premiumGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetText(buyTokenGUI.label[2], "$"..exports.GTIutil:tocomma(token_cost))
	guiSetText(buyTokenGUI.edit[1], "")
	guiSetText(buyTokenGUI.label[5], "$0")
	
	guiBringToFront(buyTokenGUI.window[1])
	guiSetVisible(buyTokenGUI.window[1], true)
end, false)

	-- Update Cost Estimate -->>
addEventHandler("onClientGUIChanged", buyTokenGUI.edit[1], function()
	local text = guiGetText(buyTokenGUI.edit[1])
	local sub_text = string.gsub(text, "%D", "")
	if (text ~= sub_text) then
		guiSetText(buyTokenGUI.edit[1], sub_text)
		return
	end
	local cost = tonumber(text) or 0
	guiSetText(buyTokenGUI.label[5], "$"..exports.GTIutil:tocomma(cost*token_cost))
end)

	-- Purchase Tokens -->>
addEventHandler("onClientGUIClick", buyTokenGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local amount = tonumber(guiGetText(buyTokenGUI.edit[1]))
	if (not amount or amount <= 0) then
		exports.GTIhud:dm("Enter a valid number of tokens that you wish to purchase.", 255, 125, 0)
		return
	end
	
	triggerServerEvent("GTIpremium.purchaseTokens", resourceRoot, amount)
end, false)

	-- Cancel -->>
addEventHandler("onClientGUIClick", buyTokenGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(buyTokenGUI.window[1], false)
end, false)

-- Custom Blips
---------------->>

local blips = {}
local blip_coords = {}

addEvent("GTIpremium.createBlips", true)
addEventHandler("GTIpremium.createBlips", root, function(x, y)
	local blip = exports.GTIblips:createCustomBlip(x, y, 16, 16, "images/blip.png", 500)
	table.insert(blips, blip)
	table.insert(blip_coords, {x, y})
end)

addEventHandler("onClientResourceStart", resourceRoot, function()
	triggerServerEvent("GTIpremium.createBlips", resourceRoot)
end)

addEventHandler("onClientResourceStop", resourceRoot, function()
	for i,blip in ipairs(blips) do
		exports.GTIblips:destroyCustomBlip(blip)
	end
end)

addEventHandler("onClientResourceStart", root, function(resource)
	if (getResourceName(resource) ~= "GTIblips") then return end
	blips = {}
	for i,v in ipairs(blip_coords) do
		local x,y = unpack(v)
		local blip = exports.GTIblips:createCustomBlip(x, y, 16, 16, "images/blip.png", 500)
		table.insert(blips, blip)
	end
end)
	