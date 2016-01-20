----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 03 Feb 2015
-- Resource: GTIstats/stats.lua
-- Version: 1.0
----------------------------------------->>

local sel_player			-- Selected Player
local sel_cutoff			-- Selection Prevention

local SELECT_TIME = 5000	-- Time Between Selections
local TO_KM = 1000			-- Meters to KM
local TO_FEET = 0.3048		-- Meters to Feet
local TO_MILES = 1609.34	-- Meters to Miles

-- Toggle Stats Panel
---------------------->>

addCommandHandler("stats", function()
	if (guiGetVisible(statsGUI.window[1])) then
		guiSetVisible(statsGUI.window[1], false)
		showCursor(false)
	else
		triggerServerEvent("GTIstats.showStatsPanel", resourceRoot)
	end
end)

addEventHandler("onClientGUIClick", statsGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(statsGUI.window[1], false)
	showCursor(false)
end, false)

-- Render Stats Panel
---------------------->>

addEvent("GTIstats.showStatsPanel", true)
addEventHandler("GTIstats.showStatsPanel", root, function(stats_table)
	guiSetText(statsGUI.edit[1], "Search...")
		
	guiGridListClear(statsGUI.gridlist[1])
	for i,team in ipairs(getElementsByType("team")) do
		if (#getPlayersInTeam(team) > 0) then
			local row = guiGridListAddRow(statsGUI.gridlist[1])
			guiGridListSetItemText(statsGUI.gridlist[1], row, 1, getTeamName(team), true, false)
			local r,g,b = getTeamColor(team)
			guiGridListSetItemColor(statsGUI.gridlist[1], row, 1, r, g, b)
			for i,player in ipairs(getPlayersInTeam(team)) do
				local row = guiGridListAddRow(statsGUI.gridlist[1])
				guiGridListSetItemText(statsGUI.gridlist[1], row, 1, getPlayerName(player), false, false)
				local r,g,b = getPlayerNametagColor(player)
				guiGridListSetItemColor(statsGUI.gridlist[1], row, 1, r, g, b)
			end
		end
	end
	
	local r,g,b = getTeamColor(getPlayerTeam(localPlayer))
	local stats = {}
	stats[1] = stats_table.general
	stats[2] = stats_table.finance
	stats[3] = stats_table.weapons
	stats[4] = stats_table.crimes
	stats[5] = stats_table.mission
	stats[6] = stats_table.misc
	
	-- General Tab
	for i1,v in ipairs(stats) do
		
		if (isElement(statsGUI.scrollpane[i1])) then
			destroyElement(statsGUI.scrollpane[i1])
			statsGUI.scrollpane[i1] = guiCreateScrollPane(10, 5, 435, 426, false, statsGUI.tab[i1])
		end
		
		for i,v in ipairs(v) do
			i = i - 1
			-- Section Header
			if (not v[2]) then
				local label = guiCreateLabel(5, 5+(i*25), 414, 15, "◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄ "..v[1].." ►►►►►►►►►►►►►►►►►►►►►►►►►►►►►►", false, statsGUI.scrollpane[i1])
				guiSetFont(label, "clear-normal")
				guiLabelSetHorizontalAlign(label, "center")
			-- Statistic
			else
				local stat_name = guiCreateLabel(5, 5+(i*25), 200, 15, v[1]..":", false, statsGUI.scrollpane[i1])
				guiSetFont(stat_name, "default-bold-small")
				guiLabelSetColor(stat_name, r, g, b)
				local stat_value = guiCreateLabel(dxGetTextWidth(v[1]..":", 1, "default-bold-small")+15, 5+(i*25), 200, 15, "N/A", false, statsGUI.scrollpane[i1])
			end
		end
		
	end
	
	guiSetVisible(statsGUI.window[1], true)
	showCursor(true)
end)

-- Update Stat Info
-------------------->>

function updateStatInfo(button, state)
	if (button ~= "left") then return end
	local row = guiGridListGetSelectedItem(statsGUI.gridlist[1])
	if (not row or row == -1) then return end
	
	local plr_name = guiGridListGetItemText(statsGUI.gridlist[1], row, 1)
	local player = getPlayerFromName(plr_name)
	if (not isElement(player)) then
		exports.GTIhud:dm(plr_name.." was not found.", 255, 25, 25)
		return
	end
	
	if (sel_cutoff) then 
		exports.GTIhud:dm("You can only select a player every "..(SELECT_TIME/1000).." seconds.", 255, 25, 25)
	return end
	
	sel_player = player
	
	triggerServerEvent("GTIstats.updateStatInfo", resourceRoot, player)
	
	sel_cutoff = true
	setTimer(function() sel_cutoff = nil end, SELECT_TIME, 1)
end
addEventHandler("onClientGUIClick", statsGUI.gridlist[1], updateStatInfo, false)
addEventHandler("onClientGUIClick", statsGUI.button[3], updateStatInfo, false)

addEvent("GTIstats.updateStatInfo", true)
addEventHandler("GTIstats.updateStatInfo", root, function(player, stat_settings, stats1, stats2, stats3, stats4, stats5, stats6)
	local r,g,b = getTeamColor(getPlayerTeam(player))
	local stats = {}
	stats[1] = stats1
	stats[2] = stats2
	stats[3] = stats3
	stats[4] = stats4
	stats[5] = stats5
	stats[6] = stats6
	
		-- Employ Settings for Players
	if (player ~= localPlayer and not exports.GTIutil:isPlayerInTeam(localPlayer, "Government")) then
		if (stat_settings["hide_account"]) then stats[1][3][2] = "Hidden" end
		if (stat_settings["hide_basic_finance"]) then
			for i=2,6 do
				stats[2][i][2] = "Hidden"
			end
		end
		if (stat_settings["hide_finances"]) then stats[2] = "disabled" end
		if (stat_settings["hide_weapons"]) then stats[3] = "disabled" end
		if (stat_settings["hide_crimes"]) then stats[4] = "disabled" end
		if (stat_settings["hide_missions"]) then stats[5] = "disabled" end
		if (stat_settings["hide_misc"]) then stats[6] = "disabled" end
	end
	
		-- Convert to Preferred Unit
	local unit = getStatSetting("dist_unit")
	if (unit ~= "meters" and type(stats[6]) == "table") then
		for i,v in ipairs(stats[6]) do
			if (v[2] and string.find(v[2], "meters")) then
				local value = string.gsub(v[2], "%D", "")
				if (unit == "kilometers") then
					value = tonumber( string.format("%.1f", value/TO_KM ) )
				elseif (unit == "feet") then
					value = math.floor( value/TO_FEET )
				elseif (unit == "miles") then
					value = tonumber( string.format("%.1f", value/TO_MILES ) )
				end
				stats[6][i][2] = exports.GTIutil:tocomma(value).." "..unit
			end
		end
	end
	
	-- General Tab
	for i1,v in ipairs(stats) do
		
		if (isElement(statsGUI.scrollpane[i1])) then
			destroyElement(statsGUI.scrollpane[i1])
			statsGUI.scrollpane[i1] = guiCreateScrollPane(10, 5, 435, 426, false, statsGUI.tab[i1])
		end
		
		if (v == "disabled") then
			guiSetEnabled(statsGUI.tab[i1], false)
		else
			guiSetEnabled(statsGUI.tab[i1], true)
			for i,v in ipairs(v) do
				i = i - 1
				-- Section Header
				if (not v[2]) then
					local label = guiCreateLabel(5, 5+(i*25), 414, 15, "◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄◄ "..v[1].." ►►►►►►►►►►►►►►►►►►►►►►►►►►►►►►", false, statsGUI.scrollpane[i1])
					guiSetFont(label, "clear-normal")
					guiLabelSetHorizontalAlign(label, "center")
				-- Statistic
				else
					local stat_name = guiCreateLabel(5, 5+(i*25), 200, 15, v[1]..":", false, statsGUI.scrollpane[i1])
					guiSetFont(stat_name, "default-bold-small")
					guiLabelSetColor(stat_name, r, g, b)
					local stat_value = guiCreateLabel(dxGetTextWidth(v[1]..":", 1, "default-bold-small")+15, 5+(i*25), 200, 15, v[2], false, statsGUI.scrollpane[i1])
					if (v[1] == "Equipped Weapons") then
						local sx,sy = guiGetSize(stat_value, false)
						guiSetSize(stat_value, sx+94, sy, false)
					end
				end
			end
		end		
	end
	
	-- Kick to General for Disabled Tabs
	local tab = guiGetSelectedTab(statsGUI.tabpanel[1])
	if (guiGetEnabled(tab) == false) then
		guiSetSelectedTab(statsGUI.tabpanel[1], statsGUI.tab[1])
	end
end)

-- Search Function
------------------->>

addEventHandler("onClientGUIChanged", statsGUI.edit[1], function()
	local plr_name = guiGetText(statsGUI.edit[1])
	
	local teams = {}
	for i,team in ipairs(getElementsByType("team")) do
		for i,player in ipairs(getPlayersInTeam(team)) do
			if (string.find(string.lower(getPlayerName(player)), string.lower(plr_name))) then
				if (not teams[team]) then teams[team] = {} end
				table.insert(teams[team], player)
			end
		end
	end
	
	guiGridListClear(statsGUI.gridlist[1])
	for i,team in ipairs(getElementsByType("team")) do				
		if (teams[team]) then
			local row = guiGridListAddRow(statsGUI.gridlist[1])
			guiGridListSetItemText(statsGUI.gridlist[1], row, 1, getTeamName(team), true, false)
			local r,g,b = getTeamColor(team)
			guiGridListSetItemColor(statsGUI.gridlist[1], row, 1, r, g, b)
			for i,player in ipairs(teams[team]) do
				local row = guiGridListAddRow(statsGUI.gridlist[1])
				guiGridListSetItemText(statsGUI.gridlist[1], row, 1, getPlayerName(player), false, false)
				local r,g,b = getPlayerNametagColor(player)
				guiGridListSetItemColor(statsGUI.gridlist[1], row, 1, r, g, b)
			end
		end
	end
end)

addEventHandler("onClientGUIFocus", statsGUI.edit[1], function()
	if (guiGetText(statsGUI.edit[1]) == "Search...") then
		guiSetText(statsGUI.edit[1], "")
	end
end, false)

-- Utilities
------------->>

function getSelectedPlayer()
	if (not isElement(sel_player)) then return false end
	return sel_player
end
