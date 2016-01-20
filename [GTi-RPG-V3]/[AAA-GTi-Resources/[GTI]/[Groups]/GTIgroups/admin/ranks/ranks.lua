----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 22 Jun 2014
-- Resource: GTIgroupPanel/Admin/Ranks/ranks.lua
-- Version: 1.0
----------------------------------------->>

local ranks = {}		-- Ranks Cache
local rank_perms = {}	-- Permissions by Rank ID
local leader_rank		-- Rank ID of Leader
local default_rank		-- Rank ID of Default Rank

-- Toggle Panel
---------------->>

function toggleRankMgmtPanel(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if (source == groupPanel.button[9]) then
		triggerServerEvent("GTIgroupPanel.getRankMgmtInfo", resourceRoot)
	elseif (source == ranks_gui.label[4]) then
		guiSetVisible(ranks_gui.window[1], false)
	end
end
addEventHandler("onClientGUIClick", groupPanel.button[9], toggleRankMgmtPanel, false)
addEventHandler("onClientGUIClick", ranks_gui.label[4], toggleRankMgmtPanel, false)

addEventHandler("onClientMouseEnter", ranks_gui.label[4], function()
	local r,g,b = guiLabelGetColor(groupPanel.label[1])
	guiLabelSetColor(source, r, g, b)
end, false)

addEventHandler("onClientMouseLeave", ranks_gui.label[4], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

-- Set Rank Mgmt Info
---------------------->>

function setRankMgmtInfo(rankTbl, rankperms, perms, isLeader, isDefault)
	ranks = rankTbl
	rank_perms = rankperms
	leader_rank = isLeader
	default_rank = isDefault
	wasOrderChanged = nil
	
	guiGridListClear(ranks_gui.gridlist[1])
	for i,rank in ipairs(rankTbl) do
		local row = guiGridListAddRow(ranks_gui.gridlist[1])
		guiGridListSetItemText(ranks_gui.gridlist[1], row, 1, rank[2], false, false)
		if (isLeader == rank[1] or isDefault == rank[1]) then
			guiGridListSetItemColor(ranks_gui.gridlist[1], row, 1, 255, 25, 25)
		end
	end
	
	for i=1,#ranks_gui.checkbox do
		destroyElement(ranks_gui.checkbox[i])
	end
	ranks_gui.checkbox = {}
	
	if (ranks_gui.label[5]) then destroyElement(ranks_gui.label[5]) end
	ranks_gui.label[5] = guiCreateLabel(0, 0, 337, 15, "Select a rank to customize it's permissions", false, ranks_gui.scrollpane[1])
	guiLabelSetHorizontalAlign(ranks_gui.label[5], "center", true)
	guiSetFont(ranks_gui.label[5], "default-bold-small")
	guiLabelSetColor(ranks_gui.label[5], 255, 100, 100)
	
	for i,perm in ipairs(perms) do
		ranks_gui.checkbox[i] = guiCreateCheckBox(0, (i*25)-5, 337, 20, perm, false, false, ranks_gui.scrollpane[1])
		guiSetEnabled(ranks_gui.checkbox[i], false)
	end
	
	local r,g,b = guiLabelGetColor(groupPanel.label[1])
	guiLabelSetColor(ranks_gui.label[1], r, g, b)
	guiLabelSetColor(ranks_gui.label[2], r, g, b)
	guiLabelSetColor(ranks_gui.label[5], r, g, b)
	local hex = exports.GTIutil:RGBToHex(r, g, b)
	hex = string.gsub(hex, "#", "")
	guiSetProperty(ranks_gui.button[6], "NormalTextColour", "FF"..hex)
	guiSetProperty(ranks_gui.button[7], "NormalTextColour", "FF"..hex)
	
	guiSetEnabled(ranks_gui.button[7], false)
	
	guiBringToFront(ranks_gui.window[1])
	guiSetVisible(ranks_gui.window[1], true)
end
addEvent("GTIgroupPanel.setRankMgmtInfo", true)
addEventHandler("GTIgroupPanel.setRankMgmtInfo", root, setRankMgmtInfo)

-- View Rank Permissions
------------------------->>

function selectRankOffList(button, state)
	if (button ~= "left" and state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(ranks_gui.gridlist[1])
	if (not row or row == -1) then return end
	
	local rankID = ranks[row+1][1]
	local perms = rank_perms[rankID]
	
		-- Enable all perm checkboxes
	for i,box in ipairs(ranks_gui.checkbox) do
		guiSetEnabled(box, true)
		guiCheckBoxSetSelected(box, false)
	end
		-- Select based on permissions
	for _,i in pairs(perms) do
		if (ranks_gui.checkbox[i]) then
			guiCheckBoxSetSelected(ranks_gui.checkbox[i], true)
		end
	end
		-- Enable all buttons
	for i=1,6 do
		guiSetEnabled(ranks_gui.button[i], true)
	end
		-- Disable Move Up/Down Buttons
	if (row == 1) then
		guiSetEnabled(ranks_gui.button[1], false)
	end
	if (row == guiGridListGetRowCount(ranks_gui.gridlist[1])-2) then
		guiSetEnabled(ranks_gui.button[2], false)
	end
	
		-- Make exceptions for group leader/default ranks
	if (rankID == leader_rank) then
		guiSetText(ranks_gui.label[5], "The group leader rank has all permissions enabled.")
		for i,box in ipairs(ranks_gui.checkbox) do
			guiSetEnabled(box, false)
		end
		for _,i in ipairs({1, 2, 4, 6}) do
			guiSetEnabled(ranks_gui.button[i], false)
		end		
	elseif (rankID == default_rank) then
		guiSetText(ranks_gui.label[5], "The group default rank has no permissions enabled.")
		for i,box in ipairs(ranks_gui.checkbox) do
			guiSetEnabled(box, false)
		end
		for _,i in ipairs({1, 2, 4, 6}) do
			guiSetEnabled(ranks_gui.button[i], false)
		end
	else
		guiSetText(ranks_gui.label[5], "Editing permissions of '"..ranks[row+1][2].."'")
	end
end
addEventHandler("onClientGUIClick", ranks_gui.gridlist[1], selectRankOffList, false)

-- Add Group Rank
------------------>>

-- Show Add Group Rank Panel -->>
addEventHandler("onClientGUIClick", ranks_gui.button[3], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	guiComboBoxClear(addRankGUI.combobox[1])
	for i,rank in ipairs(ranks) do
		guiComboBoxAddItem(addRankGUI.combobox[1], rank[2])
	end
	guiComboBoxSetSelected(addRankGUI.combobox[1], #ranks-1)
	local x,y = guiGetSize(addRankGUI.combobox[1], false)
	guiSetSize(addRankGUI.combobox[1], x, 25+(#ranks*20), false)
	
	local r,g,b = guiLabelGetColor(groupPanel.label[1])
	local hex = exports.GTIutil:RGBToHex(r, g, b)
	hex = string.gsub(hex, "#", "")
	guiSetProperty(addRankGUI.button[1], "NormalTextColour", "FF"..hex)
	
	guiLabelSetColor(addRankGUI.label[1], r, g, b)
	guiLabelSetColor(addRankGUI.label[2], r, g, b)
		
	guiBringToFront(addRankGUI.window[1])
	guiSetVisible(addRankGUI.window[1], true)
end, false)

function closeAddGroupRankPanel(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(addRankGUI.window[1], false)
end
addEventHandler("onClientGUIClick", addRankGUI.button[2], closeAddGroupRankPanel, false)
addEvent("GTIgroupPanel.closeAddGroupRankPanel", true)
addEventHandler("GTIgroupPanel.closeAddGroupRankPanel", root, closeAddGroupRankPanel)

-- Add Group Rank -->>
addEventHandler("onClientGUIClick", addRankGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local rank = guiGetText(addRankGUI.edit[1])
	if (rank == "") then
		exports.GTIhud:dm("Enter a rank name.", 255, 100, 100)
		return
	end
	local perms = guiComboBoxGetItemText( addRankGUI.combobox[1], guiComboBoxGetSelected(addRankGUI.combobox[1]) )
	
	for i,rankID in ipairs(ranks) do
		if (rankID[2] == perms) then
			perms = rankID[1]
			break
		end
	end
	triggerServerEvent("GTIgroupPanel.addGroupRank", resourceRoot, rank, perms)
end, false)

-- Rename Group Rank
--------------------->>

-- Show Rename Group Rank Panel -->>
addEventHandler("onClientGUIClick", ranks_gui.button[5], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(ranks_gui.gridlist[1])
	if (not row or row == -1) then 
		exports.GTIhud:dm("Select a rank first.", 255, 100, 100)
	return end
	
	guiSetText(renameRankGUI.label[1], "Change '"..guiGridListGetItemText(ranks_gui.gridlist[1], row, 1).."' rank name to:")
	
	local r,g,b = guiLabelGetColor(groupPanel.label[1])
	guiLabelSetColor(renameRankGUI.label[1], r, g, b)
	
	guiBringToFront(renameRankGUI.window[1])
	guiSetVisible(renameRankGUI.window[1], true)
end, false)

-- Hide Rename Rank Panel -->>
addEventHandler("onClientGUIClick", renameRankGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(renameRankGUI.window[1], false)
end, false)

-- Change Rank Name -->>
addEventHandler("onClientGUIClick", renameRankGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local rankName = guiGetText(renameRankGUI.edit[1])
	if (rankName == "") then
		exports.GTIhud:dm("Enter a rank name.", 255, 100, 100)
		return
	end
	
	local row = guiGridListGetSelectedItem(ranks_gui.gridlist[1])
	if (not row or row == -1) then return end
	local rankID = ranks[row+1][1]
	
	triggerServerEvent("GTIgroupPanel.setGroupRankName", resourceRoot, rankID, rankName)
	guiSetVisible(renameRankGUI.window[1], false)
end, false)

-- Remove Group Rank
--------------------->>

-- Show Remove Rank Panel -->>
addEventHandler("onClientGUIClick", ranks_gui.button[4], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(ranks_gui.gridlist[1])
	if (not row or row == -1) then 
		exports.GTIhud:dm("Select a rank first.", 255, 100, 100)
	return end
	
	local rankName = guiGridListGetItemText(ranks_gui.gridlist[1], row, 1)
	guiSetText(removeRankGUI.label[1], "Are you sure you want to delete the \n'"..rankName.."' rank?")
	local def_rank = guiGridListGetItemText(ranks_gui.gridlist[1], guiGridListGetRowCount(ranks_gui.gridlist[1])-1, 1)
	guiSetText(removeRankGUI.label[2], "All members with this rank will be given the\n'"..def_rank.."' rank.")
	
	local r,g,b = guiLabelGetColor(groupPanel.label[1])
	guiLabelSetColor(removeRankGUI.label[1], r, g, b)
	
	guiBringToFront(removeRankGUI.window[1])
	guiSetVisible(removeRankGUI.window[1], true)
end, false)

-- Hide Remove Rank Panel -->>
addEventHandler("onClientGUIClick", removeRankGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(removeRankGUI.window[1], false)
end, false)

-- Remove Rank -->>
addEventHandler("onClientGUIClick", removeRankGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local row = guiGridListGetSelectedItem(ranks_gui.gridlist[1])
	if (not row or row == -1) then return end
	local rankID = ranks[row+1][1]
	
	triggerServerEvent("GTIgroupPanel.removeGroupRank", resourceRoot, rankID)
	guiSetVisible(removeRankGUI.window[1], false)
end, false)

-- Update Rank Permissions
--------------------------->>

addEventHandler("onClientGUIClick", ranks_gui.button[6], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local row = guiGridListGetSelectedItem(ranks_gui.gridlist[1])
	if (not row or row == -1) then 
		exports.GTIhud:dm("Select a rank first.", 255, 100, 100)
	return end
	local rankID = ranks[row+1][1]

	local permissions = {}
	for i,box in ipairs(ranks_gui.checkbox) do
		if (guiCheckBoxGetSelected(box)) then
			table.insert(permissions, i)
		end
	end
	triggerServerEvent("GTIgroupPanel.updateRankPermissions", resourceRoot, rankID, permissions)
end, false)

-- Update Rank Order
--------------------->>

function updateRankOrder(button, state)
	if (button ~= "left" or state ~= "up") then return end
		-- Move Up or Down
	if (source == ranks_gui.button[1] or source == ranks_gui.button[2]) then
		local row = guiGridListGetSelectedItem(ranks_gui.gridlist[1])
		if (not row or row == -1) then 
			exports.GTIhud:dm("Select a rank first.", 255, 125, 0)
		return end
		if (row == 0 or row == guiGridListGetRowCount(ranks_gui.gridlist[1])-1) then
			exports.GTIhud:dm("ERROR: This rank cannot be shifted up or down", 255, 25, 25)
			return
		end
	
		local rankTbl = ranks[row+1]
		table.remove(ranks, row+1)
		if (source == ranks_gui.button[1]) then
			table.insert(ranks, row, rankTbl)
		else
			table.insert(ranks, row+2, rankTbl)
		end
		
		guiGridListClear(ranks_gui.gridlist[1])
		for i,rank in ipairs(ranks) do
			local row = guiGridListAddRow(ranks_gui.gridlist[1])
			guiGridListSetItemText(ranks_gui.gridlist[1], row, 1, rank[2], false, false)
			if (leader_rank == rank[1] or default_rank == rank[1]) then
				guiGridListSetItemColor(ranks_gui.gridlist[1], row, 1, 255, 25, 25)
			end
		end
		guiSetEnabled(ranks_gui.button[7], true)
	elseif (source == ranks_gui.button[7]) then
		local rankIDs = {}
		for i,rank in ipairs(ranks) do
			table.insert(rankIDs, rank[1])
		end
		triggerServerEvent("GTIgroupPanel.updateRankOrder", resourceRoot, rankIDs)
	end
end
addEventHandler("onClientGUIClick", ranks_gui.button[1], updateRankOrder, false)
addEventHandler("onClientGUIClick", ranks_gui.button[2], updateRankOrder, false)
addEventHandler("onClientGUIClick", ranks_gui.button[7], updateRankOrder, false)
