----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 10 Aug 2014
-- Resource: GTIadmin/admin_slua
-- Version: 1.0
----------------------------------------->>

local mod_info = {}	-- Table of Mod Info by Player

-- Show Admin Panel
-------------------->>

function showAdminPanel()
	if (not hasObjectPermissionTo(client, "general.govtpanel", false)) then return end
	local access_tabs = {}
	if (hasObjectPermissionTo(client, "general.govt_tab_admin", false)) then
		access_tabs[1] = true
		if (isDeveloper(client) and not isAdmin(client) and not exports.GTIutil:isPlayerInTeam(client, "Government") and getServerPort() == 22003) then
			access_tabs[1] = nil
		end
	end
	if (hasObjectPermissionTo(client, "general.govt_tab_resources", false)) then
		access_tabs[2] = true
	end
	if (hasObjectPermissionTo(client, "general.govt_tab_bans", false)) then
		access_tabs[3] = true
	end
	if (hasObjectPermissionTo(client, "general.govt_tab_acl", false)) then
		access_tabs[4] = true
	end
	
	local access_admin = {}
	access_admin[2] = canPlayerPunish(client)
	access_admin[3] = hasObjectPermissionTo(client, "general.admin_warp_to_player", false)
	access_admin[4] = hasObjectPermissionTo(client, "general.admin_warp_player_to", false)
	access_admin[5] = hasObjectPermissionTo(client, "general.admin_spectate", false)
	access_admin[6] = hasObjectPermissionTo(client, "general.admin_slap", false)
	access_admin[7] = hasObjectPermissionTo(client, "general.admin_rename", false)
	access_admin[8] = hasObjectPermissionTo(client, "general.admin_freeze", false)
	access_admin[9] = hasObjectPermissionTo(client, "general.admin_shout", false)
	access_admin[10] = hasObjectPermissionTo(client, "general.admin_reconnect", false)
	access_admin[11] = hasObjectPermissionTo(client, "general.admin_set_health", false)
	access_admin[12] = hasObjectPermissionTo(client, "general.admin_set_armor", false)
	access_admin[13] = hasObjectPermissionTo(client, "general.admin_set_skin", false)
	access_admin[14] = hasObjectPermissionTo(client, "general.admin_set_money", false)
	access_admin[15] = hasObjectPermissionTo(client, "general.admin_set_int", false)
	access_admin[16] = hasObjectPermissionTo(client, "general.admin_set_dim", false)
	access_admin[17] = hasObjectPermissionTo(client, "general.admin_view_ammo", false)
	access_admin[18] = hasObjectPermissionTo(client, "general.admin_view_records", false)
	access_admin[19] = hasObjectPermissionTo(client, "general.admin_give_jetpack", false)
	access_admin[20] = hasObjectPermissionTo(client, "general.admin_give_weapon", false)
	access_admin[21] = hasObjectPermissionTo(client, "general.admin_screenshot", false)
	access_admin[22] = hasObjectPermissionTo(client, "general.admin_veh_spawn", false)
	access_admin[23] = hasObjectPermissionTo(client, "general.admin_veh_repair", false)
	--access_admin[24] = hasObjectPermissionTo(client, "general.admin_veh_freeze", false)
	access_admin[24] = hasObjectPermissionTo(client, "general.admin_veh_destroy", false)
	access_admin[25] = hasObjectPermissionTo(client, "general.admin_veh_blow", false)
	
	local server = getServerName().."  —  "..#getElementsByType("player").."/"..getMaxPlayers()
	
	triggerClientEvent(client, "GTIadmin.showAdminPanel", resourceRoot, server, access_tabs, access_admin)
end
addEvent("GTIadmin.showAdminPanel", true)
addEventHandler("GTIadmin.showAdminPanel", root, showAdminPanel)

addEventHandler("onResourceStart", resourceRoot, function()
	for i,player in ipairs(getElementsByType("player")) do
		if (hasObjectPermissionTo(player, "general.govtpanel", false)) then
			outputChatBox("Press 'p' to open your government panel", player)
		end
	end
end)

addEventHandler("onPlayerLogin", root, function()
	if (hasObjectPermissionTo(source, "general.govtpanel", false)) then
		outputChatBox("Press 'p' to open your government panel", source)
	end
end)

-- Update Player Info
---------------------->>

addEvent("GTIadmin.updatePlayerInfo", true)
addEventHandler("GTIadmin.updatePlayerInfo", root, function(player)
	if (not isElement(player)) then 
		exports.GTIhud:dm("ADMIN: Player not found.", client, 255, 25, 25)
		return 
	end
	
	local plr_info = {}
	
	-- Player Name
	plr_info["name"] = getPlayerName(player)
	
	-- IP Address
	plr_info["ip"] = getPlayerIP(player)
	
	-- Serial
	plr_info["serial"] = getPlayerSerial(player)
	if (not hasObjectPermissionTo(client, "general.admin_view_serial", false)) then
		plr_info["serial"] = "Hidden"
	end
	
	-- Account Name
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then
		plr_info["account"] = "Not logged in"
	else
		plr_info["account"] = getAccountName(account)
	end
	
	-- Country Flag
	plr_info["country"] = exports.GTIutil:getIpCountry(plr_info["ip"])
	if (not hasObjectPermissionTo(client, "general.admin_view_ip", false)) then
		plr_info["ip"] = "Hidden"
	end
	
	-- MTA Version
	plr_info["version"] = getPlayerVersion(player)
	
	-- ACL Groups
	local acl_groups = {}
	for i,acl in ipairs(aclGroupList()) do
		if (isObjectInACLGroup("user."..plr_info["account"], acl)) then
			table.insert(acl_groups, aclGroupGetName(acl))
		end
	end
	plr_info["acl_groups"] = table.concat(acl_groups, ", ")
	
	-- AC Detected
	plr_info["ac_detected"] = getPlayerACInfo(player).DetectedAC
	
	-- gta3.img Mods
	local modInfo = getPlayerModInfo(player)
	local count = 0
	if (modInfo) then
		for file in pairs(modInfo) do
			count = count + #modInfo[file]
		end
	end
	plr_info["img_mods"] = count
	
	-- Health
	plr_info["health"] = getElementHealth(player).."%"
	
	-- Armor
	plr_info["armor"] = getPedArmor(player).."%"
	
	-- Ping
	plr_info["ping"] = getPlayerPing(player)
	
	-- Team
	plr_info["team"] = getTeamName(getPlayerTeam(player)) or "N/A"
	
	-- Skin ID
	plr_info["skin"] = getElementModel(player)
	
	-- Weapon
	local weapon = getPedWeapon(player)
	local w_name = getWeaponNameFromID(weapon)
	local ammo = getPedTotalAmmo(player, getSlotFromWeapon(weapon))
	plr_info["weapon"] = w_name.." (ID: "..weapon.." - Ammo: "..ammo..")"
	
	-- Cash
	plr_info["cash"] = "$"..exports.GTIutil:tocomma(getPlayerMoney(player))
	
	-- Bank
	plr_info["bank"] = "$"..exports.GTIutil:tocomma( exports.GTIbank:getPlayerBankBalance(player) or 0 )
	
	-- Location
	local x,y,z = getElementPosition(player)
	plr_info["location"] = getZoneName(x, y, z)..", "..getZoneName(x, y, z, true)
	
	-- Coords
	local _,_,rot = getElementRotation(player)
	local int = getElementInterior(player)
	local dim = getElementDimension(player)
	local x, y, z, rot = string.format("%.3f", x), string.format("%.3f", y), string.format("%.3f", z), math.floor(rot)
	plr_info["coords"] = x..", "..y..", "..z..", "..rot..", "..int..", "..dim
	
	-- Job
	plr_info["job"] = exports.GTIemployment:getPlayerJob(player) or "Unemployed"
	
	-- Division
	plr_info["division"] = exports.GTIemployment:getPlayerJobDivision(player) or "None"
	
	-- Group Name
	plr_info["group"] = exports.GTIgroups:getPlayerGroup(player, true) or ""
	
	-- Wanted Level
	plr_info["wanted"] = exports.GTIpoliceWanted:getPlayerWantedLevel(player) or 0
	
	-- Vehicle
	plr_info["vehicle"] = "On Foot"
	plr_info["veh_health"] = "N/A"
	if (isPedInVehicle(player)) then
		local vehicle = getPedOccupiedVehicle(player)
		local v_name = getVehicleName(vehicle)
		local v_model = getElementModel(vehicle)
		local v_health = getElementHealth(vehicle)
		plr_info["vehicle"] = v_name.." (ID: "..v_model..")"
		plr_info["veh_health"] = (v_health/10).."%"
	end
	
	triggerClientEvent(client, "GTIadmin.updatePlayerInfo", resourceRoot, plr_info)
end)

-- Player Mod Info
------------------->>

addEventHandler("onResourceStart", resourceRoot, function()
	for i,player in ipairs(getElementsByType("player")) do
		resendPlayerModInfo(player)
	end
end)

addEventHandler("onPlayerModInfo", root, function(filename, itemList)
	if (not mod_info[source]) then mod_info[source] = {} end
	mod_info[source][filename] = itemList
end)

function getPlayerModInfo(player)
	return mod_info[player] or false
end

addEventHandler("onPlayerQuit", root, function()
	mod_info[source] = nil
end)

-- Permission Checks
--------------------->>

function canPlayerPunish(player)
	if (not isElement(player)) then return false end
	return hasObjectPermissionTo(player, "general.admin_kick", false)
		or hasObjectPermissionTo(player, "general.admin_admin_jail", false)
		or hasObjectPermissionTo(player, "general.admin_mute", false)
		or hasObjectPermissionTo(player, "general.admin_ban_ip", false)
		or hasObjectPermissionTo(player, "general.admin_ban_serial", false)
		or hasObjectPermissionTo(player, "general.admin_ban_account", false)
		or false
end

-- View Ammo
------------->>

addEvent("GTIgovt.viewPlayerWeapons", true)
addEventHandler("GTIgovt.viewPlayerWeapons", root, function(player)
	local weapons = {}
	for i=0,12 do
		local weap = getPedWeapon(player, i)
		local ammo = getPedTotalAmmo(player, i)
		if (weap and weap ~= 0 and ammo > 0) then
			table.insert(weapons, {getWeaponNameFromID(weap), ammo})
		end
	end
	triggerClientEvent(client, "GTIgovt.viewPlayerWeapons", resourceRoot, player, weapons)
end)
