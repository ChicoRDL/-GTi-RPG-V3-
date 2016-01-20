--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz and Emile ~
-- Resource: GTIircg/joinquit.lua ~
-- Description: <Desc> ~
-- Data: #IRCgroups
--<--------------------------------->--

addEventHandler("onPlayerLogin", root,
function()
    if ( exports.GTIgroups:isPlayerInGroup(source) ) then
        local playerGroup = exports.GTIgroups:getPlayerGroup(source, false)
			local ch = getChannelFromGroupID(playerGroup)
			if ( ch ) then
				local channel = exports.GTIirc:ircGetChannelFromName(ch)
				if channel then
					exports.GTIirc:ircSay(channel, "9* "..formatNick(getPlayerName(source)).." is now online [Logged in]")
				end
			end
	end
end)

addEventHandler("onPlayerQuit", root,
function(reason)
    if ( exports.GTIgroups:isPlayerInGroup(source) ) then
        local playerGroup = exports.GTIgroups:getPlayerGroup(source, false)
			local ch = getChannelFromGroupID(playerGroup)
			if ( ch ) then
				local channel = exports.GTIirc:ircGetChannelFromName(ch)
				if channel then
					exports.GTIirc:ircSay(channel, "9* "..formatNick(getPlayerName(source)).." is now offline ["..reason.."]")
				end
			end

	end
end)

addEventHandler( "onIRCUserJoin", root,
	function( chan)
		if not chan then return end
		local irc_user = exports.GTIirc:ircGetUserNick( source)
		if irc_user == "Kayla" then return end
		local name = exports.GTIirc:ircGetChannelName( chan)

		for channame, groupid in pairs ( eTable) do
			--local channel = exports.GTIirc:ircGetChannelFromName( channame)
			--if channame == name then
			if channame and name then
				if string.match( string.lower(channame), string.lower(name)) then
					local r, g, b = exports.GTIgroups:getGroupColor(groupid)
					local hColor = exports.GTIutil:RGBToHex(r, g, b)
					exports.GTIgroups:outputGroupChat("#FF8000[IRC] "..hColor.."(GROUP) "..irc_user.." joined your group channel.", groupid)
				end
			end
		end
	end
)

addEventHandler( "onIRCUserPart", root,
	function( chan, reason)
		local irc_user = exports.GTIirc:ircGetUserNick( source)
		if irc_user == "Kayla" then return end
		local name = exports.GTIirc:ircGetChannelName( chan)

		for channame, groupid in pairs ( eTable) do
			--local channel = exports.GTIirc:ircGetChannelFromName( channame)
			if channame and name then
				if string.match( string.lower(channame), string.lower(name)) then
					local r, g, b = exports.GTIgroups:getGroupColor(groupid)
					local hColor = exports.GTIutil:RGBToHex(r, g, b)
					if reason then
						exports.GTIgroups:outputGroupChat("#FF8000[IRC] "..hColor.."(GROUP) "..irc_user.." parted your group channel (#FF8000"..reason..hColor..").", groupid)
					else
						exports.GTIgroups:outputGroupChat("#FF8000[IRC] "..hColor.."(GROUP) "..irc_user.." parted your group channel.", groupid)
					end
				end
			end
		end
	end
)

addEventHandler("onPlayerChangeNick", root, function(oldNick, newNick)
	if (string.find(oldNick, "#%x%x%x%x%x%x") or string.find(newNick, "#%x%x%x%x%x%x") or string.find(oldNick, "|AFK") or string.find(newNick, "|AFK")) then return end
    if ( exports.GTIgroups:isPlayerInGroup(source) ) then
        local playerGroup = exports.GTIgroups:getPlayerGroup(source, false)
			local ch = getChannelFromGroupID(playerGroup)
			if ( ch ) then
				local channel = exports.GTIirc:ircGetChannelFromName(ch)
				if channel then
					exports.GTIirc:ircSay(channel, "9* "..oldNick.." is now known as "..newNick)
				end
			end

	end
end)
