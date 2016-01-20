----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 20 Aug 2014
-- Resource: GTIgovt/punishments.slua
-- Version: 1.0
----------------------------------------->>

local recent_punish = {}	-- Players who were recently punished
local RECENT_TIME = 15000	-- Length of "Recent" Definition
	-- Mutes -->>
local mutes = {}		-- Mutes by Serial
local mutedPlayers = {}	-- Muted Players

	-- Global Mutes -->>
local globalMutes = {}		-- Mutes by Serial
local globalMutedPlayers = {}	-- Muted Players

local punish_reasons = {
	{"Rule 1 — Random Deathmatching",	2,	5},
	{"Rule 2 — Cheating/Exploiting",	2,	10},
	{"Rule 3 — Non-English",			3,	3},
	{"Rule 4 — Griefing",				2,	3},
	{"Rule 5 — Spam",					3,	3},
	{"Rule 6 — Impersonation",			1,	0},
	{"Rule 7 — Discrimination",			3,	5},
	{"Rule 8 — Flaming",				3,	5},
	{"Testing Punishment",				1,	5},
}

local punish_types = {
	[1] = "Kick Player",
	[2] = "Admin Jail",
	[3] = "Mute Player",
	[4] = "Globally Mute Player",
	[5] = "Ban Player IP",
	[6] = "Ban Player Serial",
	[7] = "Ban Player Account",
	[8] = "Ban Player Completely",
}

-- Punish Log
-------------->>

function addPunishlogEntry(player, admin, reason)
	if (not isElement(player) or type(reason) ~= "string") then return false end
	return addPunishmentToLog(player, admin, reason)
end

-- Kick Player
--------------->>

kickPlayer_ = kickPlayer
function kickPlayer(player, admin, reason)
	if (not isElement(player) or type(reason) ~= "string") then return false end
	local name = getPlayerName(player)
	kickPlayer_(player, admin, reason)
	outputAdminNotice(name.." has been kicked by "..getAdminName(admin).." ("..reason..")")
	exports.GTIlogs:outputAdminLog("KICK: "..name.." has been kicked by "..getAdminName(admin).." ("..reason..")", admin)
	addPunishlogEntry(player, admin, name.." has been kicked by "..getAdminName(admin).." ("..reason..")")
	local text = name.." has been kicked by "..getAdminName(admin).." ("..reason..")"
	--outputChatBox("* (ADMIN) "..text, root, 255, 0, 125)
	return true
end

-- Kill Player
--------------->>

function killPed(player, admin)
	if (not isElement(player) or not exports.GTIutil:isPlayerLoggedIn(player)) then return false end
	killPed(player)
	exports.GTIhud:dm("ADMIN: You have been killed by "..getAdminName(admin), player, 255, 25, 25)
	outputAdminNotice(getPlayerName(player).." has been killed by "..getAdminName(admin))
	exports.GTIlogs:outputAdminLog("KILL: "..getPlayerName(player).." has been killed by "..getAdminName(admin), admin)
	addPunishlogEntry(player, admin, getPlayerName(player).." has been killed by "..getAdminName(admin))
	return true
end

-- Jail Player
--------------->>

function jailPlayer(player, sentence, admin, reason)
	if (not isElement(player) or type(sentence) ~= "number" or type(reason) ~= "string") then return false end
	if (not exports.GTIutil:isPlayerLoggedIn(player)) then return end
	if (recent_punish[player]) then
		exports.GTIhud:dm("ADMIN: This player was recently punished, you must wait "..math.floor(RECENT_TIME/1000).." seconds between punishments.", admin, 255, 25, 25)
		return
	end
	
	exports.GTIprison:jailPlayer(player, sentence, admin, reason)

	local time_text = sentenceToTime(sentence)
	exports.GTIhud:dm("ADMIN: You have been jailed by "..getAdminName(admin).." for "..time_text.." ("..reason..")", player, 255, 25, 25)
	outputAdminNotice(getPlayerName(player).." has been jailed by "..getAdminName(admin).." for "..time_text.." ("..reason..")")
	exports.GTIlogs:outputAdminLog("JAIL: "..getPlayerName(player).." has been jailed by "..getAdminName(admin).." for "..time_text.." ("..reason..")", admin)
	addPunishlogEntry(player, admin, getPlayerName(player).." has been jailed by "..getAdminName(admin).." for "..time_text.." ("..reason..")")
	local text = getPlayerName(player).." has been jailed by "..getAdminName(admin).." for "..time_text.." ("..reason..")"
	--outputChatBox("* (ADMIN) "..text, root, 255, 0, 125)
	recent_punish[player] = getTickCount()
	return true
end

-- Mute Player
--------------->>

function setPlayerMuted(player, admin, sentence, reason, isGlobal)
	if (not isElement(player)) then return false end
	if (not exports.GTIutil:isPlayerLoggedIn(player)) then return end
	if (recent_punish[player]) then
		exports.GTIhud:dm("ADMIN: This player was recently punished, you can't punish again for another "..math.floor(RECENT_TIME/1000).." seconds.", admin, 255, 25, 25)
		return
	end
	
	if (sentence and sentence > 0) then
		mutes[getPlayerSerial(player)] = getRealTime().timestamp + sentence
		mutedPlayers[player] = true

		if (isGlobal) then
			globalMutes[getPlayerSerial(player)] = getRealTime().timestamp + sentence
			globalMutedPlayers[player] = true
		end

		local time_text = sentenceToTime(sentence)
		exports.GTIhud:dm("ADMIN: You have been "..(isGlobal and "globally " or "").."muted by "..getAdminName(admin).." for "..time_text.."  ("..reason..")", player, 255, 25, 25)
		if ( not admin or getAdminName(admin) == "Console" ) then return end
		outputAdminNotice(getPlayerName(player).." has been "..(isGlobal and "globally " or "").."muted by "..getAdminName(admin).." for "..time_text.."  ("..reason..")")
		exports.GTIlogs:outputAdminLog("MUTE: "..getPlayerName(player).." has been "..(isGlobal and "globally " or "").."muted by "..getAdminName(admin).." for "..time_text.."  ("..reason..")", admin)
		addPunishlogEntry(player, admin, getPlayerName(player).." has been "..(isGlobal and "globally " or "").."muted by "..getAdminName(admin).." for "..time_text.."  ("..reason..")")
		recent_punish[player] = getTickCount()
		--local text = getPlayerName(player).." has been "..(isGlobal and "globally " or "").."muted by "..getAdminName(admin).." for "..time_text.."  ("..reason..")"
		--outputChatBox("* (ADMIN) "..text, root, 255, 0, 125)
	else
		mutes[getPlayerSerial(player)] = nil
		mutedPlayers[player] = nil

		globalMutes[getPlayerSerial(player)] = nil
		globalMutedPlayers[player] = nil

		exports.GTIhud:dm("ADMIN: You have been unmuted by "..getAdminName(admin or "Console"), player, 255, 25, 25)
		if ( not admin or getAdminName(admin) == "Console") then return end
		outputAdminNotice(getPlayerName(player).." has been unmuted by "..(getAdminName(admin) or "Console"))
		exports.GTIlogs:outputAdminLog("MUTE: "..getPlayerName(player).." has been unmuted by ".. ( getAdminName(admin) or "Console"), admin)
		--local text = getPlayerName(player).." has been unmuted by "..getAdminName(admin)
		--outputChatBox("* (ADMIN) "..text, root, 255, 0, 125)
	end
end

function isPlayerMuted(player, isGlobal)
	if (not isElement(player)) then return false end
	if (not isGlobal and mutes[getPlayerSerial(player)]) then return true end
	if (isGlobal and globalMutes[getPlayerSerial(player)]) then return true end
	return false
end

setTimer(function()
	for serial,timestamp in pairs(mutes) do
		if (timestamp <= getRealTime().timestamp) then
			mutes[serial] = nil
			for player in pairs(mutedPlayers) do
				if (getPlayerSerial(player) == serial) then
					setPlayerMuted(player)
				end
			end
		end
	end
end, 15000, 0)

addEventHandler("onPlayerJoin", root, function()
	if (isPlayerMuted(source)) then
		mutedPlayers[source] = true
		exports.GTIhud:dm("ADMIN: You have been muted by Console", source, 255, 25, 25)
		outputAdminNotice(getPlayerName(source).." has been muted by Console")
	end
end)

addEventHandler("onPlayerQuit", root, function()
	mutedPlayers[source] = nil
end)

-- Release Player
------------------>>

function releasePlayer(player, admin)
	if (not isElement(player) or not isElement(admin)) then return false end
	if (not exports.GTIutil:isPlayerLoggedIn(player)) then return end

	exports.GTIprison:releasePlayer2(player)
	exports.GTIhud:dm("ADMIN: You have been released from prison by "..getAdminName(admin), player, 255, 25, 25)
	outputAdminNotice(getPlayerName(player).." has been released from prison by "..getAdminName(admin))
	exports.GTIlogs:outputAdminLog("JAIL: "..getPlayerName(player).." has been released from prison by "..getAdminName(admin), admin)
	return true
end

-- Get Punishments
------------------->>

function getPunishmentReasons()
	return punish_reasons
end

function getPunishmentTypes()
	return punish_types
end

-- Recent Punishments
---------------------->>

setTimer(function()
	for player,tick in pairs(recent_punish) do
		if (isElement(player)) then
			if (tick+RECENT_TIME <= getTickCount()) then
				recent_punish[player] = nil
			end
		else
			recent_punish[player] = nil
		end
	end
end, 1000, 0)

-- Utilities
------------->>

function getAdminName(admin)
	if (isElement(admin)) then
		return getPlayerName(admin)
	else
		if tostring(admin) then
			return admin
		else
			return "Console"
		end
	end
end

function sentenceToTime(sentence)
	if (sentence < 0) then sentence = 0 end

	local days = math.floor(sentence/86400)
	sentence = sentence - (days*86400)
	local hours = math.floor(sentence/3600)
	sentence = sentence - (hours*3600)
	local minutes = math.floor(sentence/60)

	local time_text = ""
	if (days > 0) then
		time_text = time_text..days.." "..(days == 1 and "day " or "days ")
	end if (hours > 0) then
		time_text = time_text..hours.." "..(hours == 1 and "hour " or "hours ")
	end if (minutes > 0) then
		time_text = time_text..minutes.." "..(minutes == 1 and "minute " or "minutes ")
	end
	time_text = string.sub(time_text, 1, -2)
	if (#time_text == 0) then time_text = "0 minutes" end
	return time_text
end
