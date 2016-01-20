----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 28 Jan 2015
-- Resource: GTIgovt/irc.slua
-- Version: 1.0
----------------------------------------->>

GOVT_CHAN = "#Gov't"
local TIME_BTWN_CMDS = 5000

local cmd_spam = {}
local commandList = {"!govt"}

--exports.GTIirc:ircGetUserLevel( exports.GTIirc:ircGetUserFromNick( "<person>"), exports.GTIirc:ircGetChannelFromName( "#Gov't"))

-- Join/Quit Chan
------------------>>

addEventHandler("onResourceStart", root, function(resource)
	if (getResourceName(resource) ~= "GTIirc" and resource ~= getThisResource()) then return end
	if (not getResourceFromName("GTIirc") or getResourceState(getResourceFromName("GTIirc")) ~= "running") then return end
	exports.GTIirc:addIRCCommandHandler("!govt", "getOnlineGovt", 1, true)
	-- Admin2
	exports.GTIirc:addIRCCommandHandler("!pendingreports", "ircGetPendingReports", 3, true)
	-- Issue punishment:
	exports.GTIirc:addIRCCommandHandler("!jailplayer", "ircJailPlayer", 3, true)
	exports.GTIirc:addIRCCommandHandler("!jailrelease", "ircReleasePlayer", 3, true)
	
	exports.GTIirc:addIRCCommandHandler("!muteplayer", "ircMutePlayer", 3, true)
	exports.GTIirc:addIRCCommandHandler("!unmuteplayer", "ircMutePlayer", 3, true)

	exports.GTIirc:ircRaw(exports.LilDolla:getIRCServer(), "JOIN "..GOVT_CHAN)
end)

addEventHandler("onResourceStop", root, function(resource)
	if (getResourceName(resource) ~= "GTIirc" and resource ~= getThisResource()) then return end
	if (not getResourceFromName("GTIirc") or getResourceState(getResourceFromName("GTIirc")) ~= "running") then return end
	exports.GTIirc:ircRaw(exports.LilDolla:getIRCServer(), "PART "..GOVT_CHAN)
end)

-- Get Online Members
---------------------->>

function getOnlineGovt(_, channel, user)
	if (cmd_spam[user]) then
		exports.GTIirc:ircNotice(user, "You can only use this command once every "..(TIME_BTWN_CMDS/1000).." seconds")
		return
	end
	cmd_spam[user] = true
	setTimer(function(user) cmd_spam[user] = nil end, TIME_BTWN_CMDS, 1, user)

	local govt = {}
	local total = 0
	for i,player in ipairs(getElementsByType("player")) do
		-- Admins
		if (exports.GTIutil:isPlayerInACLGroup(player, "Admin1", "Admin2", "Admin3", "Admin4", "Admin5")) then
			table.insert(govt, getPlayerName(player))
			total = total + 1
		-- Developers
		elseif (exports.GTIutil:isPlayerInACLGroup(player, "Dev1", "Dev2", "Dev3", "Dev4", "Dev5")) then
			table.insert(govt, getPlayerName(player))
			total = total + 1
		-- Architects
		elseif (exports.GTIutil:isPlayerInACLGroup(player, "Arch1", "Arch4", "Arch5")) then
			table.insert(govt, getPlayerName(player))
			total = total + 1
		-- QCAs
		elseif (exports.GTIutil:isPlayerInACLGroup(player, "QCA1", "QCA4", "QCA5")) then
			table.insert(govt, getPlayerName(player))
			total = total + 1
		end
	end
	govt = table.concat(govt, ", ")
	
	exports.GTIirc:ircNotice(user, "There are "..total.." government members online. "..govt)
	return true
end

function ircJailPlayer(_, _, user, _, arg1, arg2, ...)
	if (cmd_spam[user]) then
		exports.GTIirc:ircNotice(user, "You can only use this command once every "..(TIME_BTWN_CMDS/1000).." seconds")
		return
	end
	cmd_spam[user] = true
	setTimer(function(user) cmd_spam[user] = nil end, TIME_BTWN_CMDS, 1, user)

	if (not arg1 or not arg2 or not ...) then
		exports.GTIirc:ircNotice(user, "Syntax: !jailplayer < player, sentence (min), reason > ")
		return
	end

	local theWholeReason = {...}
        local theWholeReason = table.concat(theWholeReason, " ")

	local player = exports.GTIutil:findPlayer(arg1)
	local adminName = exports.GTIirc:ircGetUserNick(user)
	if ( not player ) then
		exports.GTIirc:ircNotice(user, " '" .. arg1 .. "' no such player")
		return
	end
	
	if ( not tonumber(arg2) ) then
		exports.GTIirc:ircNotice(user, " '" .. arg2 .. "' is not a valid amount")
		return
	end
	
	exports.GTIgovt:jailPlayer(player, tonumber(arg2*60), adminName, theWholeReason)
	--local time_text = sentenceToTime(tonumber(arg2*60))
	--outputAdminNotice ( getPlayerName(player).." has been jailed by "..adminName.." for "..time_text.." ("..theWholeReason..")" )
end

function ircReleasePlayer(_, _, user, _, player )
	if (cmd_spam[user]) then
		exports.GTIirc:ircNotice(user, "You can only use this command once every "..(TIME_BTWN_CMDS/1000).." seconds")
		return
	end
	cmd_spam[user] = true
	setTimer(function(user) cmd_spam[user] = nil end, TIME_BTWN_CMDS, 1, user)
	
	if (not player) then
		exports.GTIirc:ircNotice(user, "Syntax: !jailrelease < player > ")
		return
	end
	
	local player = exports.GTIutil:findPlayer(player) or player

	local adminName = exports.GTIirc:ircGetUserNick(user)

	if ( not isElement(player) ) then
		exports.GTIirc:ircNotice(user, " '" .. player .. "' no such player")
		return
	end
	
	if ( not exports.GTIprison:isPlayerInJail(player) ) then
		exports.GTIirc:ircNotice(user, " '" .. getPlayerName(player) .. "' is not jailed")
		return
	end
	
	exports.GTIprison:releasePlayer2(player)
	outputAdminNotice(getPlayerName(player).." has been released from prison by "..adminName)
end


function ircGetPendingReports(_, _, user )
	if (cmd_spam[user]) then
		exports.GTIirc:ircNotice(user, "You can only use this command once every "..(TIME_BTWN_CMDS/1000).." seconds")
		return
	end
	cmd_spam[user] = true
	setTimer(function(user) cmd_spam[user] = nil end, TIME_BTWN_CMDS, 1, user)
	local are_or_is = exports.GTIreport:getReports() > 1 and "are" or "is"
	local are_or_is = exports.GTIreport:getReports() == 0 and "are" or are_or_is
	local number_or_no = exports.GTIreport:getReports() >= 1 and exports.GTIreport:getReports() or "no"
	exports.GTIirc:ircNotice(user, "There " .. are_or_is .. " " .. number_or_no .. " pending reports.")
end

function ircMutePlayer(_, _, user, command, player, sentence, ... )
	if ( command == "!muteplayer" ) then
		local theWholeReason = {...}
		local reason = table.concat(theWholeReason, " ")
		if ( player and tonumber(sentence) and reason and exports.GTIutil:findPlayer(player) ) then
			setPlayerMuted( exports.GTIutil:findPlayer(player), exports.GTIirc:ircGetUserNick(user), tonumber(sentence)*60, reason, false)
		else
			exports.GTIirc:ircNotice(user, "Syntax: !muteplayer <player, sentence, reason >")
		end
	elseif ( command == "!unmuteplayer" ) then
		if ( player and exports.GTIutil:findPlayer(player) ) then
			setPlayerMuted( exports.GTIutil:findPlayer(player), exports.GTIirc:ircGetUserNick(user))
		else
			exports.GTIirc:ircNotice(user, "Syntax: !unmuteplayer <player, sentence, reason >")
		end
	end
end

-- Output Gov't Chat
--------------------->>

addEvent("onIRCMessage", true)
addEventHandler("onIRCMessage", root, function(channel, message)
	if (channel ~= exports.GTIirc:ircGetChannelFromName(GOVT_CHAN)) then return end
	if (exports.GTIirc:ircGetUserNick(source) == "Kayla") then return end
	
	-- Cancel if Command
	if (string.sub(message, 1, 1) == "!") then return end

	for i,plr in ipairs(getAdmins()) do
		outputChatBox("(#Gov't) "..exports.GTIirc:ircGetUserNick(source)..": #FFFFFF"..message, plr, 255, 0, 125, true)
	end
	exports.GTIlogs:outputServerLog("(GTI) "..exports.GTIirc:ircGetUserNick(source)..": "..message, "admin")
end)

-- Anti-highlight
------------------>>

function noHighlight(nick)
    local middle = math.ceil(#nick/2)
    local part1 = string.sub(nick,0,middle)
    local part2 = string.sub(nick,middle+2)
    return part1.."*"..part2
end
