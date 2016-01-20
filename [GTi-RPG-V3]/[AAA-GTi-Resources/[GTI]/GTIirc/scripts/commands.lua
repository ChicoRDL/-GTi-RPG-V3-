﻿---------------------------------------------------------------------
-- Project: irc
-- Author: MCvarial
-- Contact: mcvarial@gmail.com
-- Version: 1.0.3
-- Date: 31.10.2010
---------------------------------------------------------------------

------------------------------------
-- Commands
------------------------------------
addCommandHandler("servers",
	function (source)
		if source ~= getElementsByType("console")[1] then return end
		local servers = ircGetServers()
		for i,server in ipairs (servers) do
			servers[i] = ircGetServerName(server)
		end
		outputServerLog("IRC: servers: "..table.concat(servers,", "))
	end
)

addCommandHandler("channels",
	function (source)
		if source ~= getElementsByType("console")[1] then return end
		local channels = ircGetChannels()
		for i,channel in ipairs (channels) do
			channels[i] = ircGetChannelName(channel)
		end
		outputServerLog("IRC: channels: "..table.concat(channels,", "))
	end
)

addCommandHandler("users",
	function (source)
		if source ~= getElementsByType("console")[1] then return end
		local users = ircGetUsers()
		for i,user in ipairs (users) do
			users[i] = ircGetUserNick(user)
		end
		outputServerLog("IRC: users: "..table.concat(users,", "))
	end
)

addCommandHandler("ircsay",
	function (source,cmd,...)
		if source ~= getElementsByType("console")[1] then return end
		local msg = {...}
		if msg then
			outputIRC(table.concat(msg," "))
		else
			outputServerLog("IRC: syntax is /ircsay <message>")
		end
	end
)

addCommandHandler("ircre",
	function(source,cmd,...)
		local msg = {...}
		if msg then
			local user = ppms[source]
			if user then
				outputChatBox( "You replied "..ircGetUserNick( user).."'s IRC pm.", source, 255, 255, 0)
				ircNotice( user, "IG Message From '"..getPlayerName(source).."': "..table.concat(msg, " "))
				--ppms[source] = nil
			else
				outputChatBox( "You don't have an irc pm to reply to.",source,255,0,0)
			end
		else
			outputChatBox( "You must specify a message to send.",source,255,0,0)
		end
	end
)

addCommandHandler("level",
	function (source,cmd,username,channelname)
		if source ~= getElementsByType("console")[1] then return end
		if username and channelname then
			local user = ircGetUserFromNick(username)
			local channel = ircGetChannelFromName(channelname)
			if user then
				outputServerLog("IRC: level "..username..": "..ircGetUserLevel(user,channel))
			else
				outputServerLog("IRC: user not found!")
			end
		else
			outputServerLog("IRC: syntax: /level <name> <channel>")
		end
	end
)
