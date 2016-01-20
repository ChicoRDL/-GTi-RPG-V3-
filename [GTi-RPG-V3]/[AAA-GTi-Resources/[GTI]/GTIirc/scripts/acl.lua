---------------------------------------------------------------------
-- Project: irc
-- Author: MCvarial
-- Contact: mcvarial@gmail.com
-- Version: 1.0.3
-- Date: 31.10.2010
---------------------------------------------------------------------

commands = {}

------------------------------------
-- Acl
------------------------------------
function func_addIRCCommandHandler (cmd,fn,level,echoChannelOnly,desc)
	if not level then level = 0 end
	if not echoChannelOnly then echoChannelOnly = false end
	if not desc then desc = "No Description" end
	if commands[string.lower(cmd)] and commands[string.lower(cmd)].fn then return false end
	if commands[string.lower(cmd)] then
		commands[string.lower(cmd)].fn = fn
	else
		commands[string.lower(cmd)] = {fn=fn,level=level,echoChannelOnly=echoChannelOnly,sourceResource=sourceResource,desc=desc}
	end
	return true
end
registerFunction("addIRCCommandHandler","func_addIRCCommandHandler","string","function/string","(number)","(boolean)")

function func_ircGetCommands ()
	local cmds = {}
	for cmd,_ in pairs (commands) do
		table.insert(cmds,cmd)
	end
	return cmds
end
registerFunction("ircGetCommands","func_ircGetCommands")

function func_ircGetCommandLevel (cmd)
	if commands[cmd] then
		return tonumber(commands[cmd].level)
	end
	return false
end
registerFunction("ircGetCommandLevel","func_ircGetCommandLevel","string")

function func_ircGetCommandDescription (cmd)
	if commands[cmd] then
		return tonumber(commands[cmd].desc)
	end
	return false
end
registerFunction("ircGetCommandDescription","func_ircGetCommandDescription","string")

function func_ircIsCommandEchoChannelOnly (cmd)
	if commands[cmd] then
		return commands[cmd].echoChannelOnly
	end
	return false
end
registerFunction("ircIsCommandEchoChannelOnly","func_ircIsCommandEchoChannelOnly","string")

addEvent("onIRCMessage")
addEventHandler("onIRCMessage",root,
	function (channel,message)
		if not isElement(channel) or ircGetUserNick(source) == ircGetServerNick(getElementParent(channel)) or not message or not gettok(message, 1, 32) then return end
		local cmd = string.lower(gettok(message,1,32))
		local args = split(message,32)
		if commands[cmd] then
			if commands[cmd].level <= (tonumber(ircGetUserLevel(source,channel)) or 0) then
				if commands[cmd].echoChannelOnly and not ircIsEchoChannel(channel) then return end
				if type(commands[cmd].fn) == "function" then
					--outputDebugString(type(commands[cmd].fn))
					commands[cmd].fn(ircGetChannelServer(channel),channel,source,unpack(args))
				else
					call(commands[cmd].sourceResource,commands[cmd].fn,ircGetChannelServer(channel),channel,source,unpack(args))
				end
			end
		elseif get("*irc-sendallmessages") == "true" and ircIsEchoChannel(channel) and string.sub(message,1,1) ~= "!" then
			outputChatBox("* "..ircGetUserNick(source).." on irc: "..message,root,255,168,0)
			outputIRC("07* "..ircGetUserNick(source).." on irc: "..message)
		end
	end
)
