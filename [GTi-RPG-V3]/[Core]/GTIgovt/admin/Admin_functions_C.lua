----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 10 Aug 2014
-- Resource: GTIadmin/admin_functions.lua
-- Version: 1.0
----------------------------------------->>

local def_punishment = {}	-- Cache of Default Punishments
local admin_func 			-- Admin Function to be Executed
local is_number				-- Accept only Number Values
local weap_gridlist = {}	-- Cache of Weapons via Gridlist

-->>

local weapon_list = {
	{"Melee", 				{1, 2, 3, 4, 5, 6, 7, 8, 9}},
	{"Handguns", 			{22, 23, 24}},
	{"Shotguns",			{25, 26, 27}},
	{"Sub-Machine Guns", 	{28, 29, 32}},
	{"Assault Rifles",		{30, 31}},
	{"Rifles",				{33, 34}},
	{"Heavy Weapons",		{35, 36, 37, 38}},
	{"Projectiles",			{16, 17, 18, 39}},
	{"Special 1",			{41, 42, 43}},
	{"Gifts/Other",			{10, 11, 12, 14, 15}},
	{"Special 2",			{44, 45, 46}},
}

-- Admin Panel Functions
------------------------->>

addEventHandler("onClientGUIClick", adminGUI.tab[1], function(button, state)
	if (button ~= "left") then return end

	local player = getSelectedPlayer()
	if (getElementType(source) == "gui-button" and not isElement(player)) then
		exports.GTIhud:dm("ADMIN: Selected player was not found. Cannot perform admin action.", 255, 25, 25)
		return
	end

	-- Issue Punishment
	if (source == adminGUI.button[2]) then
		guiBringToFront(adminPunishGUI.window[1])
		guiSetVisible(adminPunishGUI.window[1], true)
		triggerServerEvent("GTIadmin.getDefaultPunishments", resourceRoot)
	return end

	-- Warp Me to Player
	if (source == adminGUI.button[3]) then
		closeAdminPanel()
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "warp_to_player")
	return end

	-- Warp Player To...
	if (source == adminGUI.button[4]) then
		guiSetText(adminWarp.edit[1], "Search...")
		updateWarpPlayerToList()
		guiBringToFront(adminWarp.window[1])
		guiSetVisible(adminWarp.window[1], true)
	return end

	-- Spectate
	if (source == adminGUI.button[5]) then
		if (player == localPlayer) then
			exports.GTIhud:dm("Error: You cannot spectate yourself!", 255, 25, 25)
			return
		end
		closeAdminPanel()
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "spectate")
	return end

	-- Slap
	if (source == adminGUI.button[6]) then
		executeFunction("Slap Player — HP Amount", "slap", true)
	return end

	-- Rename
	if (source == adminGUI.button[7]) then
		executeFunction("Rename Player", "rename")
	return end

	-- Freeze
	if (source == adminGUI.button[8]) then
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "freeze")
	return end

	-- Shout
	if (source == adminGUI.button[9]) then
		executeFunction("Shout Message to Player", "shout")
	return end

	-- Reconnect
	if (source == adminGUI.button[10]) then
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "reconnect")
	return end

	-- Set Health
	if (source == adminGUI.button[11]) then
		executeFunction("Set Player Health to...", "set_health", true)
	return end

	-- Set Armor
	if (source == adminGUI.button[12]) then
		executeFunction("Set Player Armor to...", "set_armor", true)
	return end

	-- Set Skin
	if (source == adminGUI.button[13]) then
		executeFunction("Set Player Skin ID to...", "set_skin", true)
	return end

	-- Set Money
	if (source == adminGUI.button[14]) then
		executeFunction("Set Player Money to...", "set_money", true)
	return end

	-- Set Interior
	if (source == adminGUI.button[15]) then
		executeFunction("Set Player Interior to...", "set_interior", true)
	return end

	-- Set Dimension
	if (source == adminGUI.button[16]) then
		executeFunction("Set Player Dimension to...", "set_dimension", true)
	return end

	-- View Ammo
	if (source == adminGUI.button[17]) then
		triggerServerEvent("GTIgovt.viewPlayerWeapons", resourceRoot, player)
	return end

	-- View Records
	if (source == adminGUI.button[18]) then
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "view_records")
	return end

	-- Give Jetpack
	if (source == adminGUI.button[19]) then
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "give_jetpack")
	return end

	-- Give Weapon
	if (source == adminGUI.button[20]) then
		guiBringToFront(giveWeaponGUI.window[1])
		guiSetVisible(giveWeaponGUI.window[1], true)
	return end

	if (source == adminGUI.button[21]) then
		triggerServerEvent("GTIreport.takePlayerScreenshot", resourceRoot, player)
	return end
	-- Spawn Vehicle
	if (source == adminGUI.button[22]) then
		executeFunction("Spawn Vehicle (Enter name)", "spawn_vehicle")
	return end

	-- Repair Vehicle
	if (source == adminGUI.button[23]) then
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "repair_vehicle")
	return end

	-- Destroy Vehicle
	if (source == adminGUI.button[24]) then
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "destroy_vehicle")
	return end

	-- Blow Vehicle
	if (source == adminGUI.button[25]) then
		triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "blow_vehicle")
	return end
end)

-- Issue Punishment
-------------------->>

addEvent("GTIadmin.getDefaultPunishments", true)
addEventHandler("GTIadmin.getDefaultPunishments", root, function(punish, ptype)
	guiComboBoxClear(adminPunishGUI.combobox[1])
	for i,v in ipairs(punish) do
		guiComboBoxAddItem(adminPunishGUI.combobox[1], v[1])
		def_punishment[i] = {v[2], v[3]}
	end
	guiComboBoxSetSelected(adminPunishGUI.combobox[1], 0)
	local x,y = guiGetSize(adminPunishGUI.combobox[1], false)
	guiSetSize(adminPunishGUI.combobox[1], x, 25 + (#punish*15), false)

	guiComboBoxClear(adminPunishGUI.combobox[2])
	for i,v in ipairs(ptype) do
		guiComboBoxAddItem(adminPunishGUI.combobox[2], v)
	end
	guiComboBoxSetSelected(adminPunishGUI.combobox[2], 0)
	local x,y = guiGetSize(adminPunishGUI.combobox[2], false)
	guiSetSize(adminPunishGUI.combobox[2], x, 25 + (#ptype*18), false)
	updateDefaultPunishment()
end)

function updateDefaultPunishment()
	local int = guiComboBoxGetSelected(adminPunishGUI.combobox[1])
	guiComboBoxSetSelected(adminPunishGUI.combobox[2], def_punishment[int+1][1] - 1)
	guiSetText(adminPunishGUI.checkbox[1], "Use Default Duration ("..def_punishment[int+1][2].." minutes)")
	guiCheckBoxSetSelected(adminPunishGUI.checkbox[1], false)
end
addEventHandler("onClientGUIComboBoxAccepted", adminPunishGUI.combobox[1], updateDefaultPunishment)

addEventHandler("onClientGUIClick", adminPunishGUI.window[1], function(button)
	if (button ~= "left") then return end

		-- Issue Punishment
	if (source == adminPunishGUI.button[1]) then
		local reasonInd = guiComboBoxGetSelected(adminPunishGUI.combobox[1])
		local reason = guiComboBoxGetItemText(adminPunishGUI.combobox[1], reasonInd)
		if (guiGetText(adminPunishGUI.edit[1]) ~= "") then
			reason = guiGetText(adminPunishGUI.edit[1])
		end

		local action = guiComboBoxGetSelected(adminPunishGUI.combobox[2]) + 1

		local duration
		if (guiCheckBoxGetSelected(adminPunishGUI.checkbox[1])) then
			duration = def_punishment[reasonInd+1][2] * 60
		else
			local mins = guiGetText(adminPunishGUI.edit[2])
			local hours = guiGetText(adminPunishGUI.edit[3])
			local days = guiGetText(adminPunishGUI.edit[4])
			if (mins == "" and hours == "" and days == "") then
				exports.GTIhud:dm("ADMIN: Custom time not specified. Please enter a custom punishment time.", 255, 25, 25)
				return
			end

			if (mins == "") then mins = 0 end
			if (hours == "") then hours = 0 end
			if (days == "") then days = 0 end

			if (not tonumber(mins) and not tonumber(hours) and not tonumber(days) ) then
				exports.GTIhud:dm("ADMIN: Invalid custom time entered. Please enter a valid custom punishment time.", 255, 25, 25)
				return
			end

			duration = mins*60 + hours*3600 + days*86400
		end

		triggerServerEvent("GTIgovtPanel.issuePunishment", resourceRoot, getSelectedPlayer(), action, duration, reason)

		guiSetVisible(adminPunishGUI.window[1], false)
		for i,edit in ipairs(adminPunishGUI.edit) do
			guiSetText(edit, "")
		end
	return end

		-- Remove Punishment
	if (source == adminPunishGUI.button[2]) then
		local action = guiComboBoxGetSelected(adminPunishGUI.combobox[2]) + 1

		triggerServerEvent("GTIgovtPanel.removePunishment", resourceRoot, getSelectedPlayer(), action)

		guiSetVisible(adminPunishGUI.window[1], false)
		for i,edit in ipairs(adminPunishGUI.edit) do
			guiSetText(edit, "")
		end
	return end

		-- Close Panel
	if (source == adminPunishGUI.button[3]) then
		guiSetVisible(adminPunishGUI.window[1], false)
		for i,edit in ipairs(adminPunishGUI.edit) do
			guiSetText(edit, "")
		end
	return end
end)

-- Warp Player To...
--------------------->>

function updateWarpPlayerToList()
	guiGridListClear(adminWarp.gridlist[1])
	for i,team in ipairs(getElementsByType("team")) do
		if (#getPlayersInTeam(team) > 0) then
			local row = guiGridListAddRow(adminWarp.gridlist[1])
			guiGridListSetItemText(adminWarp.gridlist[1], row, 1, getTeamName(team), true, false)
			local r,g,b = getTeamColor(team)
			guiGridListSetItemColor(adminWarp.gridlist[1], row, 1, r, g, b)
			for i,player in ipairs(getPlayersInTeam(team)) do
				local row = guiGridListAddRow(adminWarp.gridlist[1])
				guiGridListSetItemText(adminWarp.gridlist[1], row, 1, getPlayerName(player), false, false)
				local r,g,b = getPlayerNametagColor(player)
				guiGridListSetItemColor(adminWarp.gridlist[1], row, 1, r, g, b)
			end
		end
	end
end

-- Search Function -->>
addEventHandler("onClientGUIChanged", adminWarp.edit[1], function()
	local plr_name = guiGetText(adminWarp.edit[1])

	local teams = {}
	for i,team in ipairs(getElementsByType("team")) do
		for i,player in ipairs(getPlayersInTeam(team)) do
			if (string.find(string.lower(getPlayerName(player)), string.lower(plr_name))) then
				if (not teams[team]) then teams[team] = {} end
				table.insert(teams[team], player)
			end
		end
	end

	guiGridListClear(adminWarp.gridlist[1])
	for i,team in ipairs(getElementsByType("team")) do
		if (teams[team]) then
			local row = guiGridListAddRow(adminWarp.gridlist[1])
			guiGridListSetItemText(adminWarp.gridlist[1], row, 1, getTeamName(team), true, false)
			local r,g,b = getTeamColor(team)
			guiGridListSetItemColor(adminWarp.gridlist[1], row, 1, r, g, b)
			for i,player in ipairs(teams[team]) do
				local row = guiGridListAddRow(adminWarp.gridlist[1])
				guiGridListSetItemText(adminWarp.gridlist[1], row, 1, getPlayerName(player), false, false)
				local r,g,b = getPlayerNametagColor(player)
				guiGridListSetItemColor(adminWarp.gridlist[1], row, 1, r, g, b)
			end
		end
	end
end)

addEventHandler("onClientGUIClick", adminWarp.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end

	local player = getSelectedPlayer()
	if (not isElement(player)) then
		exports.GTIhud:dm("ADMIN: Selected player was not found. Cannot perform admin action.", 255, 25, 25)
		return
	end

	closeAdminPanel()
	triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "warp_player_to", localPlayer)
end, false)

addEventHandler("onClientGUIClick", adminWarp.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end

	local player = getSelectedPlayer()
	if (not isElement(player)) then
		exports.GTIhud:dm("ADMIN: Selected player was not found. Cannot perform admin action.", 255, 25, 25)
		return
	end

	local row = guiGridListGetSelectedItem(adminWarp.gridlist[1])
	local plr_name = guiGridListGetItemText(adminWarp.gridlist[1], row, 1)
	local warpTo = getPlayerFromName(plr_name)
	if (not isElement(warpTo)) then
		exports.GTIhud:dm("ADMIN: "..plr_name.." was not found. Cannot perform admin action.", 255, 25, 25)
		return
	end

	closeAdminPanel()
	triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "warp_player_to", warpTo)
end, false)

addEventHandler("onClientGUIClick", adminWarp.label[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(adminWarp.window[1], false)
end, false)

addEventHandler("onClientMouseEnter", adminWarp.label[1], function()
	guiLabelSetColor(source, 0, 190, 255)
end, false)

addEventHandler("onClientMouseLeave", adminWarp.label[1], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

-- Execute Function
-------------------->>

function executeFunction(windowText, fuct, isnum)
	guiSetText(adminExe.label[1], windowText)
	guiBringToFront(adminExe.window[1])
	guiSetVisible(adminExe.window[1], true)
	admin_func = fuct
	is_number = isnum
	return true
end

function executeFunctionGUI(button, state)
	if (button ~= "left" or state ~= "up") then return end

	local value = guiGetText(adminExe.edit[1])
	if (#value == 0) then
		exports.GTIhud:dm("Enter a value in the box provided", 255, 125, 0)
		return
	end

	local player = getSelectedPlayer()
	if (not isElement(player)) then
		exports.GTIhud:dm("ADMIN: Selected player was not found. Cannot perform admin action.", 255, 25, 25)
		return
	end

	if (is_number and not tonumber(value)) then
		exports.GTIhud:dm("You must enter a number value to execute this function", 255, 125, 0)
		return
	end

	triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, admin_func, tonumber(value) or value)
	guiSetText(adminExe.edit[1], "")
	guiSetVisible(adminExe.window[1], false)
	admin_func = nil
	is_number = nil
end
addEventHandler("onClientGUIClick", adminExe.button[1], executeFunctionGUI, false)

addEventHandler("onClientGUIAccepted", adminExe.edit[1], function()
	executeFunctionGUI("left", "up")
end, false)

addEventHandler("onClientGUIClick", adminExe.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetText(adminExe.edit[1], "")
	guiSetVisible(adminExe.window[1], false)
	admin_func = nil
	is_number = nil
end, false)

-- View Weapons
---------------->>

addEvent("GTIgovt.viewPlayerWeapons", true)
addEventHandler("GTIgovt.viewPlayerWeapons", root, function(player, weapons)
	guiSetText(viewWeapons.label[1], getPlayerName(player).."'s Weapons")
	guiGridListClear(viewWeapons.gridlist[1])
	for i,v in ipairs(weapons) do
		local row = guiGridListAddRow(viewWeapons.gridlist[1])
		guiGridListSetItemText(viewWeapons.gridlist[1], row, 1, v[1], false, false)
		guiGridListSetItemText(viewWeapons.gridlist[1], row, 2, v[2], false, false)
	end

	guiBringToFront(viewWeapons.window[1])
	guiSetVisible(viewWeapons.window[1], true)
end)

addEventHandler("onClientGUIClick", viewWeapons.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(viewWeapons.window[1], false)
end, false)

-- Give Weapon
--------------->>

function giveAdminWeapon(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local player = getSelectedPlayer()
	if (not isElement(player)) then
		exports.GTIhud:dm("ADMIN: Selected player was not found. Cannot perform admin action.", 255, 25, 25)
		return
	end
	local row = guiGridListGetSelectedItem(giveWeaponGUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select a weapon off the list", 255, 125, 25)
		return
	end
	local ammo = tonumber(guiGetText(giveWeaponGUI.edit[1]))
	if (not ammo) then
		exports.GTIhud:dm("Enter a valid ammo amount in the field below the weapons list.", 255, 125, 25)
		return
	end

	triggerServerEvent("GTIgovtPanel.executeAdminFunction", resourceRoot, player, "give_weapon", weap_gridlist[row], ammo)
end
addEventHandler("onClientGUIClick", giveWeaponGUI.button[1], giveAdminWeapon, false)
addEventHandler("onClientGUIDoubleClick", giveWeaponGUI.gridlist[1], giveAdminWeapon, false)

	-- Render Weapons List
addEventHandler("onClientResourceStart", resourceRoot, function()
	for i,v in ipairs(weapon_list) do
		local row = guiGridListAddRow(giveWeaponGUI.gridlist[1])
		guiGridListSetItemText(giveWeaponGUI.gridlist[1], row, 1, v[1], true, false)
		guiGridListSetItemColor(giveWeaponGUI.gridlist[1], row, 1, 0, 190, 255)
		for i,v in ipairs(v[2]) do
			local row = guiGridListAddRow(giveWeaponGUI.gridlist[1])
			guiGridListSetItemText(giveWeaponGUI.gridlist[1], row, 1, getWeaponNameFromID(v), false, false)
			weap_gridlist[row] = v
		end
	end
end)

addEventHandler("onClientGUIClick", giveWeaponGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(giveWeaponGUI.window[1], false)
end, false)
