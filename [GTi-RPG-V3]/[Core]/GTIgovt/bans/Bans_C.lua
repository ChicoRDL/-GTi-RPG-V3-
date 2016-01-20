----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 18 Sept 2014
-- Resource: GTIadmin/bans.lua
-- Version: 1.0
----------------------------------------->>

-- Compose Ban List
-------------------->>

addEventHandler("onClientGUITabSwitched", bansGUI.tab[1], function()
	triggerServerEvent("GTIgovtPanel.getBans", resourceRoot)
	
	guiSetText(bansGUI.label[2], "")
	guiSetText(bansGUI.label[4], "")
	guiSetText(bansGUI.label[6], "Select a ban from the list")
end)

addEvent("GTIgovtPanel.composeBanList", true)
addEventHandler("GTIgovtPanel.composeBanList", root, function(bans)
	guiGridListClear(bansGUI.gridlist[1])
	for id in pairs(bans) do
		local row = guiGridListAddRow(bansGUI.gridlist[1])
		guiGridListSetItemText(bansGUI.gridlist[1], row, 1, bans[id]["nick"] or "N/A", false, false)
		guiGridListSetItemText(bansGUI.gridlist[1], row, 2, bans[id]["account"] or "N/A", false, false)
		guiGridListSetItemText(bansGUI.gridlist[1], row, 3, bans[id]["ip"] or "N/A", false, false)
		guiGridListSetItemText(bansGUI.gridlist[1], row, 4, bans[id]["serial"] or "N/A", false, false)
		guiGridListSetItemText(bansGUI.gridlist[1], row, 5, bans[id]["admin"] or "N/A", false, false)
			ban_time = tonumber(bans[id]["ban_time"])
			local d,mo,y = exports.GTIutil:todate(ban_time)
			local h,m,s = exports.GTIutil:totime(ban_time)
			ban_time = y.."-"..string.format("%02d",mo).."-"..string.format("%02d",d).." @ "..string.format("%02d",h)..":"..string.format("%02d",m)..":"..string.format("%02d",s).." GMT"
			unban_time = tonumber(bans[id]["unban_time"])
				if ( not unban_time ) then 			outputChatBox(id) end
			local d,mo,y = exports.GTIutil:todate(unban_time)
			local h,m,s = exports.GTIutil:totime(unban_time)
			unban_time = y.."-"..string.format("%02d",mo).."-"..string.format("%02d",d).." @ "..string.format("%02d",h)..":"..string.format("%02d",m)..":"..string.format("%02d",s).." GMT"
		guiGridListSetItemText(bansGUI.gridlist[1], row, 6, ban_time or "N/A", false, false)
		guiGridListSetItemText(bansGUI.gridlist[1], row, 7, unban_time or "N/A", false, false)
		guiGridListSetItemText(bansGUI.gridlist[1], row, 8, bans[id]["reason"] or "N/A", false, false)
	end
end)

-- Update Ban Info
------------------->>

addEventHandler("onClientGUIClick", bansGUI.gridlist[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(bansGUI.gridlist[1])
	if (not row or row == -1) then return end
	
	local reason = guiGridListGetItemText(bansGUI.gridlist[1], row, 8)
	local ban_time = guiGridListGetItemText(bansGUI.gridlist[1], row, 6)
	local unban_time = guiGridListGetItemText(bansGUI.gridlist[1], row, 7)
	
	if (tonumber(ban_time)) then
		ban_time = tonumber(ban_time)
		local d,mo,y = exports.GTIutil:todate(ban_time)
		local h,m,s = exports.GTIutil:totime(ban_time)
		ban_time = y.."-"..string.format("%02d",mo).."-"..string.format("%02d",d).." @ "..string.format("%02d",h)..":"..string.format("%02d",m)..":"..string.format("%02d",s).." GMT"
	end
	if (tonumber(unban_time)) then
		unban_time = tonumber(unban_time)
		local d,mo,y = exports.GTIutil:todate(unban_time)
		local h,m,s = exports.GTIutil:totime(unban_time)
		unban_time = y.."-"..string.format("%02d",mo).."-"..string.format("%02d",d).." @ "..string.format("%02d",h)..":"..string.format("%02d",m)..":"..string.format("%02d",s).." GMT"
	end
	
	guiSetText(bansGUI.label[2], ban_time)
	guiSetText(bansGUI.label[4], unban_time)
	guiSetText(bansGUI.label[6], reason)
	
end, false)

addEventHandler("onClientGUIClick", bansGUI.button[1], function (button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(bansGUI.gridlist[1])
	if (not row or row == -1) then return end
	ip, serial, account = guiGridListGetItemText(bansGUI.gridlist[1], row, 3), guiGridListGetItemText(bansGUI.gridlist[1], row, 4), guiGridListGetItemText(bansGUI.gridlist[1], row, 2)
	if (ip) == "N/A" then ip = false end
	if (serial) == "N/A" then ip = false end
	if (account) == "N/A" then ip = false end
	triggerServerEvent("GTIgovtPanel.removeBan", resourceRoot, ip, serial, account)
end, false)
