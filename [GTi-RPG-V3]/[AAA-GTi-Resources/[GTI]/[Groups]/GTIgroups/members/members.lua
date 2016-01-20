----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 01 Apr 2014
-- Resource: GTIgroupPanel/panel_members.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local ranks = {}	-- Rank Table {rankID, rankName}

-- Member Tab Info
------------------->>

function getMembersTabInfo()
	if (guiGridListGetRowCount(groupPanel.gridlist[1]) > 0) then return end
		-- Clear Default Data
	guiSetText(groupPanel.label[8], "...")
	guiSetText(groupPanel.label[10], "...")
	guiSetText(groupPanel.label[12], "...")
		-- Disable All Admin Buttons
	for i=1,5 do
		guiSetEnabled(groupPanel.button[i], false)
	end
	
	triggerServerEvent("GTIgroupPanel.getMembersTabInfo", resourceRoot)
end
addEventHandler("onClientGUITabSwitched", groupPanel.tab[2], getMembersTabInfo)

function setMemberTabInfo(member_count, member_max, last_active, my_rank, member_data, perm_data, col)
	local r, g, b = col[1], col[2], col[3]
		-- Set Label Data
	guiSetText(groupPanel.label[8], member_count.." / "..member_max)
	guiSetText(groupPanel.label[10], my_rank)
	local day,mon,year = exports.GTIutil:todate(last_active)
	local mon = exports.GTIutil:getMonthName(mon)
	guiSetText(groupPanel.label[12], day.." "..mon.." "..year)
		-- Render Gridlist
	guiGridListClear(groupPanel.gridlist[1])
	for i,v1 in ipairs(member_data) do
		if (#v1[2] > 0) then
			local row = guiGridListAddRow(groupPanel.gridlist[1])
			guiGridListSetItemText(groupPanel.gridlist[1], row, 1, v1[1], true, false)
			guiGridListSetItemColor(groupPanel.gridlist[1], row, 1, r, g, b)
			for i,v in ipairs(v1[2]) do
				local row = guiGridListAddRow(groupPanel.gridlist[1])
				guiGridListSetItemText(groupPanel.gridlist[1], row, 5, (v["country"] or "N/A"), false, false)
				guiGridListSetItemText(groupPanel.gridlist[1], row, 1, v["name"], false, false)
				guiGridListSetItemText(groupPanel.gridlist[1], row, 2, v["account_name"], false, false)
				guiGridListSetItemText(groupPanel.gridlist[1], row, 3, v["rank"], false, false)
				local day,mon,year = exports.GTIutil:todate(v["last_active"])
				local day = string.format("%02d", day)
				local mon = exports.GTIutil:getMonthName(mon, 3)
				guiGridListSetItemText(groupPanel.gridlist[1], row, 4, day.." "..mon.." "..year, false, false)
				if (v["online"]) then
					for col=1,5 do
						guiGridListSetItemColor(groupPanel.gridlist[1], row, col, 25, 255, 25)
					end
				end
			end
		end
	end
		-- Modify Buttons based on Permissions
	if (perm_data["add_member"]) then
		guiSetEnabled(groupPanel.button[1], true)
	else
		guiSetEnabled(groupPanel.button[1], false)
	end
	if (perm_data["del_member"]) then
		guiSetEnabled(groupPanel.button[5], true)
	else
		guiSetEnabled(groupPanel.button[5], false)
	end
	if (perm_data["change_member_rank"]) then
		guiSetEnabled(groupPanel.button[4], true)
	else
		guiSetEnabled(groupPanel.button[4], false)
	end
	
	if (perm_data["leave_group"]) then
		guiSetEnabled(groupPanel.button[2], true)
	else
		guiSetEnabled(groupPanel.button[2], false)
	end
	
		-- Group Color
	local r, g, b = col[1], col[2], col[3]
	guiLabelSetColor(groupPanel.label[7], r, g, b)
	guiLabelSetColor(groupPanel.label[9], r, g, b)
	guiLabelSetColor(groupPanel.label[11], r, g, b)
end
addEvent("GTIgroupPanel.setMemberTabInfo", true)
addEventHandler("GTIgroupPanel.setMemberTabInfo", root, setMemberTabInfo)

-- Toggle GUI
-------------->>

function toggleInviteGUI(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if (source == groupPanel.button[1]) then
		guiGridListClear(invite_gui.gridlist[1])
		for _,player in ipairs(getElementsByType("player")) do
			if (not getElementData(player, "group")) then
				local plr = getPlayerName(player)
				local row = guiGridListAddRow(invite_gui.gridlist[1])
				guiGridListSetItemText(invite_gui.gridlist[1], row, 1, plr, false, false)
				if (exports.GTIutil:getDistanceBetweenElements2D(localPlayer, player) < 25) then
					guiGridListSetItemColor(invite_gui.gridlist[1], row, 1, 25, 255, 25)
				end
			end
		end
		-- Set Group Panel Color
		local r,g,b = guiLabelGetColor(groupPanel.label[1])
		guiLabelSetColor(invite_gui.label[1], r, g, b)
		local hex = exports.GTIutil:RGBToHex(r, g, b)
		hex = string.gsub(hex, "#", "")
		guiSetProperty(invite_gui.button[1], "NormalTextColour", "FF"..hex)
		
		guiBringToFront(invite_gui.window[1])
		guiSetVisible(invite_gui.window[1], true)
	else
		guiSetVisible(invite_gui.window[1], false)
	end
end
addEventHandler("onClientGUIClick", groupPanel.button[1], toggleInviteGUI, false)
addEventHandler("onClientGUIClick", invite_gui.button[2], toggleInviteGUI, false)

-- Search Function
------------------->>

function searchInviteGUI()
	local text = guiGetText(source)
	guiGridListClear(invite_gui.gridlist[1])
	for _,player in ipairs(getElementsByType("player")) do
		if (not getElementData(player, "group")) then
			local plr = getPlayerName(player)
			if ((text == "Search..." or text == "") or (string.find(string.lower(plr), string.lower(text)))) then 
				local row = guiGridListAddRow(invite_gui.gridlist[1])
				guiGridListSetItemText(invite_gui.gridlist[1], row, 1, plr, false, false)
				if (exports.GTIutil:getDistanceBetweenElements2D(localPlayer, player) < 25) then
					guiGridListSetItemColor(invite_gui.gridlist[1], row, 1, 25, 255, 25)
				end
			end
		end
	end
end
addEventHandler("onClientGUIChanged", invite_gui.edit[1], searchInviteGUI, false)

-- Invite Player
----------------->>

function invitePlayerToGroup(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local row = guiGridListGetSelectedItem(invite_gui.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select a player that you wish to invite", 255, 125, 0)
		return
	end
	local player = guiGridListGetItemText(invite_gui.gridlist[1], row, 1)
	if (not getPlayerFromName(player)) then
		exports.GTIhud:dm("A player by the name of '"..player.."' was not found.", 255, 125, 0)
		return
	end
	if (exports.GTIutil:getDistanceBetweenElements2D(localPlayer, getPlayerFromName(player)) > 25) then
		exports.GTIhud:dm("This player is too far away. You must meet with the player to invite them to your group.", 255, 125, 0)
		return
	end
	triggerServerEvent("GTIgroupPanel.sendInviteNotice", resourceRoot, player)
end
addEventHandler("onClientGUIClick", invite_gui.button[1], invitePlayerToGroup, false)

-- Manage Group Invites
------------------------>>

function returnGroupInvites(invites)
	guiGridListClear(groupCreate.gridlist[1])
	for i,group in ipairs(invites) do
		local row = guiGridListAddRow(groupCreate.gridlist[1])
		guiGridListSetItemText(groupCreate.gridlist[1], row, 1, group, false, false)
	end
end
addEvent("GTIgroupPanel.returnGroupInvites", true)
addEventHandler("GTIgroupPanel.returnGroupInvites", root, returnGroupInvites)

function manageGroupInvites(button, state)
	if (button ~= "left" or state ~= "up") then return end
		-- Deny All Invites
	if (source == groupCreate.button[4]) then
		guiGridListClear(groupCreate.gridlist[1])
		triggerServerEvent("GTIgroupPanel.manageGroupInvites", resourceRoot, nil, false)
		return
	end
	local row = guiGridListGetSelectedItem(groupCreate.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select a group off the list first", 255, 125, 0)
		return
	end
	
	local group = guiGridListGetItemText(groupCreate.gridlist[1], row, 1)
	if (source == groupCreate.button[2]) then
		-- Accept Selected Invite
		triggerServerEvent("GTIgroupPanel.manageGroupInvites", resourceRoot, group, true)
	elseif (source == groupCreate.button[3]) then
		-- Deny Selected Invite
		triggerServerEvent("GTIgroupPanel.manageGroupInvites", resourceRoot, group, false)
	end
end
addEventHandler("onClientGUIClick", groupCreate.button[2], manageGroupInvites, false)
addEventHandler("onClientGUIClick", groupCreate.button[3], manageGroupInvites, false)
addEventHandler("onClientGUIClick", groupCreate.button[4], manageGroupInvites, false)

-- Leave Group
--------------->>

-- Open Leave Group GUI -->>
addEventHandler("onClientGUIClick", groupPanel.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local r,g,b = guiLabelGetColor(groupPanel.label[1])
	local hex = exports.GTIutil:RGBToHex(r, g, b)
	hex = string.gsub(hex, "#", "")
	guiSetProperty(leaveGUI.button[2], "NormalTextColour", "FF"..hex)
	
	guiSetText(leaveGUI.label[1], "Are you sure you want to leave\n"..getElementData(localPlayer, "group").."?")
	guiBringToFront(leaveGUI.window[1])
	guiSetVisible(leaveGUI.window[1], true)
end, false)

-- Close Leave Group Panel -->>
addEventHandler("onClientGUIClick", leaveGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(leaveGUI.window[1], false)
end, false)

-- Leave Group -->>
addEventHandler("onClientGUIClick", leaveGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(leaveGUI.window[1], false)
	triggerServerEvent("GTIgroupPanel.leaveGroup", resourceRoot)
end, false)

-- Toggle Panel
---------------->>

function toggleRemovePlayerGUI(button, state)
	if (button ~= "left" and state ~= "up") then return end
	if (source == groupPanel.button[5] and not guiGetVisible(remove_gui.window[1])) then
		local row = guiGridListGetSelectedItem(groupPanel.gridlist[1])
		if (not row or row == -1) then
			exports.GTIhud:dm("Select the player you wish to remove first.", 255, 125, 0)
			return
		end
		
		local player = guiGridListGetItemText(groupPanel.gridlist[1], row, 1)
		local account = guiGridListGetItemText(groupPanel.gridlist[1], row, 2)
		
		guiSetText(remove_gui.label[2], player.." ("..account..")")
		
		-- Color
		local r,g,b = guiLabelGetColor(groupPanel.label[1])
		guiLabelSetColor(remove_gui.label[1], r, g, b)
		guiLabelSetColor(remove_gui.label[3], r, g, b)

		guiBringToFront(remove_gui.window[1])
		guiSetVisible(remove_gui.window[1], true)
	elseif (source == groupPanel.button[5]) then
		guiBringToFront(remove_gui.window[1])
	elseif (source == remove_gui.button[2]) then
		guiSetVisible(remove_gui.window[1], false)
		guiSetText(remove_gui.button[1], "Remove (2)")
	end
end
addEventHandler("onClientGUIClick", groupPanel.button[5], toggleRemovePlayerGUI, false)
addEventHandler("onClientGUIClick", remove_gui.button[2], toggleRemovePlayerGUI, false)

-- Remove Player
----------------->>

function removePlayer(button, state)
	if (button ~= "left" and state ~= "up") then return end
	local reason = guiGetText(remove_gui.edit[1])
	if (reason == "") then
		exports.GTIhud:dm("You must enter a reason before removing a player from your group.", 255, 125, 0)
		return
	end
	local row = guiGridListGetSelectedItem(groupPanel.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select the player you wish to remove first.", 255, 125, 0)
		return
	end
	local player = guiGridListGetItemText(groupPanel.gridlist[1], row, 1)
	if (player == getPlayerName(localPlayer)) then
		exports.GTIhud:dm("You can't remove yourself! To leave the group, click the 'Leave Group' button.", 255, 125, 0)
		return
	end
	
	if (guiGetText(remove_gui.button[1]) == "Remove (2)") then
		guiSetText(remove_gui.button[1], "Remove (1)")
	elseif (guiGetText(remove_gui.button[1]) == "Remove (1)") then
		guiSetText(remove_gui.button[1], "Remove")
	elseif (guiGetText(remove_gui.button[1]) == "Remove") then
		local player = guiGridListGetItemText(groupPanel.gridlist[1], row, 1)
		local account = guiGridListGetItemText(groupPanel.gridlist[1], row, 2)
		triggerServerEvent("GTIgroupPanel.removePlayer", resourceRoot, player, account, reason)
		guiSetEnabled(remove_gui.button[1], false)
	end
end
addEventHandler("onClientGUIClick", remove_gui.button[1], removePlayer, false)

function confirmPlayerRemoved(onlygui)
	if (onlygui) then
		guiSetText(remove_gui.button[1], "Remove (2)")
		guiSetEnabled(remove_gui.button[1], true)
		guiSetVisible(remove_gui.window[1], false)
		return
	end
	guiSetVisible(remove_gui.window[1], false)
	guiSetText(remove_gui.button[1], "Remove (2)")
	guiSetEnabled(remove_gui.button[1], true)
		-- Refresh Panel
	guiGridListClear(groupPanel.gridlist[1])
	getMembersTabInfo()
end
addEvent("GTIgroupPanel.confirmPlayerRemoved", true)
addEventHandler("GTIgroupPanel.confirmPlayerRemoved", root, confirmPlayerRemoved)

-- Change Group Rank
--------------------->>

-- Show Change Group Rank GUI -->>
addEventHandler("onClientGUIClick", groupPanel.button[4], function(button, state)
	if (button ~= "left" and state ~= "up") then return end
	local row = guiGridListGetSelectedItem(groupPanel.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select the player you wish to change the rank of first.", 255, 125, 0)
		return
	end
	local account = guiGridListGetItemText(groupPanel.gridlist[1], row, 2)
	triggerServerEvent("GTIgroupPanel.showChangeRankGUI", resourceRoot, account)
end, false)

addEvent("GTIgroupPanel.showChangeRankGUI", true)
addEventHandler("GTIgroupPanel.showChangeRankGUI", root, function(rankTbl, rankName, account)
	ranks = rankTbl
	guiSetText(changeRankGUI.label[4], account)
	guiSetText(changeRankGUI.label[2], rankName)
	
	local r,g,b = guiLabelGetColor(groupPanel.label[1])
	guiLabelSetColor(changeRankGUI.label[2], r, g, b)
	guiLabelSetColor(changeRankGUI.label[4], r, g, b)
	
	local hex = exports.GTIutil:RGBToHex(r, g, b)
	hex = string.gsub(hex, "#", "")
	guiSetProperty(changeRankGUI.button[1], "NormalTextColour", "FF"..hex)
	
	guiGridListClear(changeRankGUI.gridlist[1])
	for i,rank in ipairs(rankTbl) do
		local row = guiGridListAddRow(changeRankGUI.gridlist[1])
		guiGridListSetItemText(changeRankGUI.gridlist[1], row, 1, rank[2], false, false)
	end
	guiBringToFront(changeRankGUI.window[1])
	guiSetVisible(changeRankGUI.window[1], true)
end)

-- Close Change Rank Panel -->>
addEventHandler("onClientGUIClick", changeRankGUI.button[2], function(button, state)
	if (button ~= "left" and state ~= "up") then return end
	guiSetVisible(changeRankGUI.window[1], false)
end, false)

-- Change Member Rank -->>
addEventHandler("onClientGUIClick", changeRankGUI.button[1], function(button, state)
	if (button ~= "left" and state ~= "up") then return end
	local acc_name = guiGetText(changeRankGUI.label[2])
	local oldRank = guiGetText(changeRankGUI.label[4])
	
	local row = guiGridListGetSelectedItem(changeRankGUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select a rank that you want to set this person's rank to.", 255, 125, 0)
		return
	end
	
	local newRank = guiGridListGetItemText(changeRankGUI.gridlist[1], row, 1)
	triggerServerEvent("GTIgroupPanel.changeMemberRank", resourceRoot, acc_name, oldRank, newRank)
	guiSetVisible(changeRankGUI.window[1], false)
end, false)


local w,h = guiGetScreenSize()
function drawMembersNames()
	if isPlayerMapVisible() then	
		local setting = exports.GTIsettings:getSetting("groupmembers")
		if setting == "No" then return end
		if setting == "Yes" then
			local sx,sy,ex,ey = getPlayerMapBoundingBox()
			local mw,mh = ex-sx,sy-ey
			local cx,cy = (sx+ex)/2,(sy+ey)/2
			local ppuX,ppuY = mw/6000,mh/6000
			local fontHeight = dxGetFontHeight(1,"default-bold")
			local yOffset = fontHeight/2
			local blips = getElementsByType("blip")
		
			for k,v in ipairs(blips) do
				local attached=getElementAttachedTo(v)
				if ( isElement(attached) ) and ( getElementData(localPlayer,"group") ) and ( getElementInterior(attached) == getElementInterior(localPlayer) ) and ( getElementDimension(attached) == getElementInterior(attached) ) and ( getElementData(attached, "group") == getElementData(localPlayer, "group") ) and ( localPlayer ~= attached ) and ( getElementType(attached)=="player") then
					local px,py = getElementPosition(attached)
					local x = math.floor(cx+px*ppuX+8)
					local y = math.floor(cy+py*ppuY-yOffset)
					local pname = getPlayerName(attached)
					local nameLength = dxGetTextWidth(pname, 1,"default-bold")
					local r,g,b = getPlayerNametagColor(attached)
					local _,_,_,a = getBlipColor(v)
				
					if a>10 then
					local settingSize = exports.GTIsettings:getSetting("member_size")
					if settingSize == "0.50" then
						exports.MitchMisc:dxDrawBorderedText(pname,x,y,x+nameLength,y+fontHeight,tocolor(r,g,b,255), 0.50, "default-bold", "left", "top", false, false, false)
					elseif settingSize == "0.75" then
						exports.MitchMisc:dxDrawBorderedText(pname,x,y,x+nameLength,y+fontHeight,tocolor(r,g,b,255), 0.75, "default-bold", "left", "top", false, false, false)
					elseif settingSize == "1.00" then
						exports.MitchMisc:dxDrawBorderedText(pname,x,y,x+nameLength,y+fontHeight,tocolor(r,g,b,255), 1.00, "default-bold", "left", "top", false, false, false)
					elseif settingSize == "1.50" then
						exports.MitchMisc:dxDrawBorderedText(pname,x,y,x+nameLength,y+fontHeight,tocolor(r,g,b,255), 1.50, "default-bold", "left", "top", false, false, false)
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientRender",root,drawMembersNames)
