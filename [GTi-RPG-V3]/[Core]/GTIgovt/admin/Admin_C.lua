----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 10 Aug 2014
-- Resource: GTIadmin/admin.lua
-- Version: 1.0
----------------------------------------->>

local sel_player	-- Selected Player

-- Open Admin Panel
-------------------->>

function openAdminPanel()
	if (not guiGetVisible(adminGUI.window[1])) then
		triggerServerEvent("GTIadmin.showAdminPanel", resourceRoot)
	else
		closeAdminPanel()
	end
end
bindKey("p", "down", openAdminPanel)

function closeAdminPanel()
	for i,window in ipairs(getElementsByType("gui-window", resourceRoot)) do
		guiSetVisible(window, false)
	end
	showCursor(false)
	sel_player = nil
end
addEvent("GTIgovtPanel.closeAdminPanel", true)
addEventHandler("GTIgovtPanel.closeAdminPanel", root, closeAdminPanel)

function showAdminPanel(server, tabs, admin)
	guiSetText(adminGUI.window[1], server)
	guiSetEnabled(adminGUI.tab[1], true)
	guiSetSelectedTab(adminGUI.tabpanel[1], adminGUI.tab[1])
	guiSetEnabled(devPanel.tab[1], true)
	
	if (not tabs[1]) then
		guiSetVisible(adminGUI.tab[1], false)
		guiSetSelectedTab(adminGUI.tabpanel[1], devPanel.tab[1])
	else		
		guiSetVisible(adminGUI.tab[1], true)
	end
	if (not tabs[2]) then
		guiSetVisible(devPanel.tab[1], false)
	else
		guiSetVisible(devPanel.tab[1], true)
	end
	if (not tabs[3]) then
		guiSetVisible(bansGUI.tab[1], false)
	else
		guiSetVisible(bansGUI.tab[1], true)
	end
	if (not tabs[4]) then
		guiSetVisible(aclGUI.tab[1], false)
	else
		guiSetVisible(aclGUI.tab[1], true)
	end
	
	for i,label in pairs(adminGUI.label2) do
		guiSetText(label, "N/A")
	end
	
	guiSetText(adminGUI.edit[1], "Search...")
		
	guiGridListClear(adminGUI.gridlist[1])
	for i,team in ipairs(getElementsByType("team")) do
		if (#getPlayersInTeam(team) > 0) then
			local row = guiGridListAddRow(adminGUI.gridlist[1])
			guiGridListSetItemText(adminGUI.gridlist[1], row, 1, getTeamName(team), true, false)
			local r,g,b = getTeamColor(team)
			guiGridListSetItemColor(adminGUI.gridlist[1], row, 1, r, g, b)
			for i,player in ipairs(getPlayersInTeam(team)) do
				local row = guiGridListAddRow(adminGUI.gridlist[1])
				guiGridListSetItemText(adminGUI.gridlist[1], row, 1, getPlayerName(player), false, false)
				local r,g,b = getPlayerNametagColor(player)
				guiGridListSetItemColor(adminGUI.gridlist[1], row, 1, r, g, b)
			end
		end
	end
	
	for i,bool in pairs(admin) do
		guiSetVisible(adminGUI.button[i], bool)
	end
	
	guiSetVisible(adminGUI.window[1], true)
	showCursor(true)
end
addEvent("GTIadmin.showAdminPanel", true)
addEventHandler("GTIadmin.showAdminPanel", root, showAdminPanel)

-- Update Player Info
---------------------->>

addEventHandler("onClientGUIClick", adminGUI.gridlist[1], function(button, state)
	if (button ~= "left") then return end
	local row = guiGridListGetSelectedItem(adminGUI.gridlist[1])
	if (not row or row == -1) then return end
	
	local plr_name = guiGridListGetItemText(adminGUI.gridlist[1], row, 1)
	local player = getPlayerFromName(plr_name)
	if (not isElement(player)) then
		exports.GTIhud:dm("ADMIN: "..plr_name.." was not found.", 255, 25, 25)
		return
	end
	
	sel_player = player
	
	triggerServerEvent("GTIadmin.updatePlayerInfo", resourceRoot, player)
end, false)

addEvent("GTIadmin.updatePlayerInfo", true)
addEventHandler("GTIadmin.updatePlayerInfo", root, function(plr_info)
		-- Player Name
	guiSetText(adminGUI.label2[5], plr_info["name"])
		-- IP Address
	guiSetText(adminGUI.label2[9], plr_info["ip"])
		-- Serial
	guiSetText(adminGUI.label2[3], plr_info["serial"])
		-- Account Name
	guiSetText(adminGUI.label2[7], plr_info["account"])
		-- Country Flag
	if (type(plr_info["country"]) == "string") then
		if (adminGUI.staticimage[1]) then destroyElement(adminGUI.staticimage[1]) end
		adminGUI.staticimage[1] = guiCreateStaticImage(288, 74, 16, 10, "images/flags/"..string.lower(plr_info["country"])..".png", false, adminGUI.tab[1])
		guiSetText(adminGUI.label2[10], plr_info["country"])
	end
		-- MTA Version
	guiSetText(adminGUI.label2[12], plr_info["version"])
		-- ACL Groups
	guiSetText(adminGUI.label2[14], plr_info["acl_groups"])
		-- AC Detected
	guiSetText(adminGUI.label2[16], plr_info["ac_detected"])
		-- gta3.img Mods
	guiSetText(adminGUI.label2[18], plr_info["img_mods"])
		-- Health
	guiSetText(adminGUI.label2[22], plr_info["health"])
		-- Armor
	guiSetText(adminGUI.label2[24], plr_info["armor"])
		-- Ping
	guiSetText(adminGUI.label2[26], plr_info["ping"])
		-- Team
	guiSetText(adminGUI.label2[28], plr_info["team"])
		-- Skin ID
	guiSetText(adminGUI.label2[30], plr_info["skin"])
		-- Weapon
	guiSetText(adminGUI.label2[32], plr_info["weapon"])
		-- Cash
	guiSetText(adminGUI.label2[34], plr_info["cash"])
		-- Bank
	guiSetText(adminGUI.label2[36], plr_info["bank"])
		-- Location
	guiSetText(adminGUI.label2[38], plr_info["location"])
		-- Coords
	guiSetText(adminGUI.label2[40], plr_info["coords"])
		-- Job
	guiSetText(adminGUI.label2[42], plr_info["job"])
		-- Division
	guiSetText(adminGUI.label2[44], plr_info["division"])
		-- Group Name
	guiSetText(adminGUI.label2[46], plr_info["group"])
		-- Wanted Level
	guiSetText(adminGUI.label2[48], plr_info["wanted"])
		-- Vehicle
	guiSetText(adminGUI.label2[52], plr_info["vehicle"])
	guiSetText(adminGUI.label2[54], plr_info["veh_health"])
end)

-- Search Function
------------------->>

addEventHandler("onClientGUIChanged", adminGUI.edit[1], function()
	local plr_name = guiGetText(adminGUI.edit[1])
	
	local teams = {}
	for i,team in ipairs(getElementsByType("team")) do
		for i,player in ipairs(getPlayersInTeam(team)) do
			if (string.find(string.lower(getPlayerName(player)), string.lower(plr_name))) then
				if (not teams[team]) then teams[team] = {} end
				table.insert(teams[team], player)
			end
		end
	end
	
	guiGridListClear(adminGUI.gridlist[1])
	for i,team in ipairs(getElementsByType("team")) do				
		if (teams[team]) then
			local row = guiGridListAddRow(adminGUI.gridlist[1])
			guiGridListSetItemText(adminGUI.gridlist[1], row, 1, getTeamName(team), true, false)
			local r,g,b = getTeamColor(team)
			guiGridListSetItemColor(adminGUI.gridlist[1], row, 1, r, g, b)
			for i,player in ipairs(teams[team]) do
				local row = guiGridListAddRow(adminGUI.gridlist[1])
				guiGridListSetItemText(adminGUI.gridlist[1], row, 1, getPlayerName(player), false, false)
				local r,g,b = getPlayerNametagColor(player)
				guiGridListSetItemColor(adminGUI.gridlist[1], row, 1, r, g, b)
			end
		end
	end
end)

addEventHandler("onClientGUIFocus", adminGUI.edit[1], function()
	if (guiGetText(adminGUI.edit[1]) == "Search...") then
		guiSetText(adminGUI.edit[1], "")
	end
end)

-- Utilities
------------->>

function getSelectedPlayer()
	if (not isElement(sel_player)) then return false end
	return sel_player
end

-- Commands
------------>>

-- /map-stats
-------------->>

function mapStatsCmd(res_name, objects)
	local objects = #getElementsByType("object", source) + objects
	outputChatBox("* "..res_name.." contains "..objects.." objects.")
end
addEvent("GTIgovt.mapStatsCmd", true)
addEventHandler("GTIgovt.mapStatsCmd", root, mapStatsCmd)
