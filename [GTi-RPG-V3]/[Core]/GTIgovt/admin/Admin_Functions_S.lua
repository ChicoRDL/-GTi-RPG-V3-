----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 10 Aug 2014
-- Resource: GTIadmin/admin_functions.slua
-- Version: 1.0
----------------------------------------->>

-- Issue Punishment
-------------------->>

addEvent("GTIadmin.getDefaultPunishments", true)
addEventHandler("GTIadmin.getDefaultPunishments", root, function()
	local punish = getPunishmentReasons()
	local punishT = getPunishmentTypes()
	triggerClientEvent(client, "GTIadmin.getDefaultPunishments", resourceRoot, punish, punishT)
end)

addEvent("GTIgovtPanel.issuePunishment", true)
addEventHandler("GTIgovtPanel.issuePunishment", root, function(player, action, duration, reason)
	-- Kick Player -->>
	if (action == 1) then
		kickPlayer(player, client, reason)
	-- Admin Jail Player -->>
	elseif (action == 2) then
		jailPlayer(player, duration, client, reason)
	-- Mute Player -->>
	elseif (action == 3) then
		setPlayerMuted(player, client, duration, reason)
	-- Globally Mute Player -->>
	elseif (action == 4) then
		setPlayerMuted(player, client, duration, reason, true)
	-- Ban Player IP -->>
	elseif (action == 5) then
		banPlayer(player, getPlayerIP(player), nil, nil, client, duration, reason)
	-- Ban Player Serial -->>
	elseif (action == 6) then
		banPlayer(player, nil, getPlayerSerial(player), nil, client, duration, reason)
	-- Ban Player Account -->>
	elseif (action == 7) then
		banPlayer(player, nil, nil, getAccountName(getPlayerAccount(player)), client, duration, reason)
	-- Ban Player Everything -->>
	elseif (action == 8) then
		banPlayer(player, getPlayerIP(player), getPlayerSerial(player), getAccountName(getPlayerAccount(player)), client, duration, reason)
	end
end)

addEvent("GTIgovtPanel.removePunishment", true)
addEventHandler("GTIgovtPanel.removePunishment", root, function(player, action)
		-- Unjail Player
	if (action == 2) then
		releasePlayer(player, client)
		-- Unmute Player -->>
	elseif (action == 3) then
		setPlayerMuted(player, client, 0)
	else
		exports.GTIhud:dm("ADMIN: This type of punishment cannot be removed.", client, 255, 25, 25)
	end
end)

-- Execute Admin Function
-------------------------->>

addEvent("GTIgovtPanel.executeAdminFunction", true)
addEventHandler("GTIgovtPanel.executeAdminFunction", root, function(player, fnct, ...)
	if (not isElement(player)) then return end

	if (fnct == "warp_to_player") then
		fadeCamera(client, false)
		setTimer(function(client, player)
			warpPlayerTo(client, player)
			fadeCamera(client, true)
		end, 1100, 1, client, player)

	elseif (fnct == "warp_player_to") then
		local args = {...}
		fadeCamera(player, false)
		setTimer(function(client, player)
			warpPlayerTo(player, args[1], client)
			fadeCamera(player, true)
		end, 1100, 1, client, player)

	elseif (fnct == "spectate") then
		spectatePlayer(client, player)

	elseif (fnct == "slap" or fnct == "rename" or fnct == "shout" or fnct == "set_health" or fnct == "set_armor"
		or fnct == "set_skin" or fnct == "set_money" or fnct == "set_interior" or fnct == "set_dimension") then
		local args = {...}
		executeAdminFunction(player, client, fnct, args[1])

	elseif (fnct == "freeze") then
		local state = not isElementFrozen(player)
		executeAdminFunction(player, client, fnct, state)

	elseif (fnct == "reconnect" or fnct == "repair_vehicle" or fnct == "destroy_vehicle" or fnct == "blow_vehicle") then
		executeAdminFunction(player, client, fnct)

	elseif (fnct == "give_jetpack") then
		local state = not doesPedHaveJetPack(player)
		executeAdminFunction(player, client, fnct, state)

	elseif (fnct == "view_records") then
		viewPlayerPunishLog(client, getAccountName(getPlayerAccount(player)), true)

	elseif (fnct == "give_weapon") then
		local args = {...}
		executeAdminFunction(player, client, fnct, args[1], args[2])

	elseif (fnct == "spawn_vehicle") then
		local args = {...}
		executeAdminFunction(player, client, fnct, args[1])
	end
end)
