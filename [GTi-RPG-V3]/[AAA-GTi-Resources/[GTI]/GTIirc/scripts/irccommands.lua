---------------------------------------------------------------------
-- Project: irc
-- Author: MCvarial
-- Contact: mcvarial@gmail.com
-- Version: 1.0.3
-- Date: 31.10.2010
---------------------------------------------------------------------

------------------------------------
-- IRC Commands
------------------------------------
no_highlight = {
	["JTPenn"] = "J.T.P.e.n.n.",
	["Jack"] = "J.ack",
	["EnemyCRO"] = "Enem.y",
	["DLmass"] = "DLass",
	["ChicoRDL"] = "RDLChico",
	["Ares"] = "Are.s",
}

addEvent("onIRCResourceStart")
addEventHandler("onIRCResourceStart",root,
	function ()
		function say ( server, channel, user, command, ...)
			local message = table.concat({...}," ")
			if message == "" then ircNotice(user,"syntax is !s <message>") return end
			outputChatBox("* (IRC) "..ircGetUserNick(user)..": #FFFFFF"..message,root,255,168,0,true)
			outputIRC("07* (IRC) "..(no_highlight[ircGetUserNick(user)] or ircGetUserNick(user))..": "..message)
		end
		addIRCCommandHandler("!say",say)
		addIRCCommandHandler("!s",say)
		
		ppms = {}
		addIRCCommandHandler("!pm",
			function (server,channel,user,command,name,...)
				local message = table.concat({...}," ")
				if not name then ircNotice(user,"syntax is !pm <name> <message>") return end
				if message == "" then ircNotice(user,"syntax is !pm <name> <message>") return end
				local player = getPlayerFromPartialName(name)
				if player then
					outputChatBox("* PM from "..ircGetUserNick(user).." on irc: "..message,player,255,168,0)
					ircNotice(user,"Your pm has been sent to "..getPlayerName(player))
					ppms[player] = user
				else
					ircNotice(user,"'"..name.."' no such player")
				end
			end
		)

		function support(server,channel,user,command,...)
			--if not name then ircNotice(user,"syntax is !support/!sup <question/answer>") return end
			local message = table.concat( {...}, " ")
			if tostring(message) and message ~= "" then
				local n_message = "[IRC] #CC0000(Support) #FFFFFF"..ircGetUserNick(user)..": #FFFFFF"..message
				local irc_m = "[Support] 02"..ircGetUserNick(user)..": 01"..message
				exports.GTIirc:outputIRC( irc_m)
				for i, v in ipairs ( getElementsByType( "player")) do
					exports.GTIchat:outputGridlist( v, v, "Support", n_message)
					if getElementData(v,"GTIchat.markedSUPPORT") then
						outputChatBox( n_message, v, 255, 255, 0, true)
					end
				end
			else
				ircNotice(user,"Please type in a question or answer to post on support.")
			end
		end
		addIRCCommandHandler("!support", support)
		addIRCCommandHandler("!sup", support)

		addIRCCommandHandler("!uptime",
			function (server,channel,user,command,...)
				ircNotice(user,"Hi "..ircGetUserNick(user)..", my uptime is: "..getTimeString(getTickCount()))
			end
		)

		addIRCCommandHandler("!players",
			function (server,channel,user)
				if getPlayerCount() == 0 then
					ircNotice(user,"There are no players ingame")
				else
					local players = getElementsByType("player")
					for i,player in ipairs (players) do
						if exports.GTIgovt:isAdmin(player) or exports.GTIgovt:isQCA(player) then
							players[i] = "7"..getPlayerName(player).."1"
						else
							players[i] = getPlayerName(player)
						end
					end
					ircNotice(user,"There are "..getPlayerCount().." players ingame: "..table.concat(players," "))
				end
			end
		)

		addIRCCommandHandler("!pcount",
			function (server,channel,user)
				if getPlayerCount() == 0 then
					ircNotice(user,"There are no players ingame")
				else
					ircNotice(user,"There is currently "..getPlayerCount().." players ingame.")
				end
			end
		)

		addIRCCommandHandler("!run",
			function (server,channel,user,command,...)
				local str = table.concat({...}," ")
				if str == "" then ircNotice(user,"syntax is !run <string>") return end
				runString(str,root,ircGetUserNick(user))
			end
		)

		addIRCCommandHandler("!crun",
			function (server,channel,user,command,...)
				local t = {...}
				local str = table.concat(t," ")
				if str == "" then ircNotice(user,"syntax is !crun (<name>) <string>") return end
				local player = getPlayerFromPartialName(tostring(t[1]))
				if player then
					table.remove(t,1)
					str = table.concat(t," ")
					triggerClientEvent(player,"doCrun",resourceRoot,str,true)
				else
					if #getElementsByType("player") == 0 then
						ircNotice(user,"No player ingame!")
						return
					end
					for i,player in ipairs (getElementsByType("player")) do
						if i == 1 then
							triggerClientEvent(player,"doCrun",resourceRoot,str,true)
						else
							triggerClientEvent(player,"doCrun",resourceRoot,str,false)
						end
					end
				end
			end
		)
		
		addIRCCommandHandler("!start",
			function (server,channel,user,command,resName)
				if not resName then ircNotice(user,"syntax is !start <resourcename>") return end
				local resource = getResourceFromPartialName(resName)
				if resource then
					if not startResource(resource) then
						ircNotice(user,"Failed to start '"..getResourceName(resource).."'")
					end
				else
					ircNotice(user,"Resource '"..resName.."' not found!")
				end
			end
		)

		addIRCCommandHandler( "!status",
			function( server, channel, user, command, resName)
				if not resName then ircNotice( user, "syntax is !status <resourcename>") return end
				local resource = getResourceFromPartialName(resName)
				if resource then
					local status = getResourceState(resource)
					ircNotice( user, "Resource '"..resName.."' is currently: "..tostring( status))
				else
					ircNotice( user, "Resource '"..resName.."' not found!")
				end
			end
		)

		addIRCCommandHandler("!restart",
			function (server,channel,user,command,resName)
				if not resName then ircNotice(user,"syntax is !restart <resourcename>") return end
				local resource = getResourceFromPartialName(resName)
				if resource then
					if not restartResource(resource) then
						ircNotice(user,"Failed to restart '"..getResourceName(resource).."'")
					end
				else
					ircNotice(user,"Resource '"..resName.."' not found!")
				end
			end
		)

		addIRCCommandHandler("!stop",
			function (server,channel,user,command,resName)
				if not resName then ircNotice(user,"syntax is !stop <resourcename>") return end
				local resource = getResourceFromPartialName(resName)
				if resource then
					if not stopResource(resource) then
						ircNotice(user,"Failed to stop '"..getResourceName(resource).."'")
					end
				else
					ircNotice(user,"Resource '"..resName.."' not found!")
				end
			end
		)

		addIRCCommandHandler("!note",
			function (server,channel,user,command, ...)
				local noteNick = ircGetUserNick(user)
				local text = table.concat( {...}, " ")
				ircNotice( user, "You made a note saying: '"..text.."'")
				outputChatBox( "#FF0000(NOTE) "..noteNick..": #FFFFFF"..text, root, 255, 255, 255, true)
				outputIRC( "* (NOTE) "..noteNick..": "..text)
			end
		)

		function outputCommands (server,channel,user,command)
			local cmds = {}
			for i,cmd in ipairs (ircGetCommands()) do
				if ircIsCommandEchoChannelOnly(cmd) then
					if ircIsEchoChannel(channel) then
						if (tonumber(ircGetCommandLevel(cmd) or 6)) <= (tonumber(ircGetUserLevel(user,channel)) or 0) then
							table.insert(cmds,cmd)
						end
					end
				else
					if ircGetCommandLevel(cmd) <= ircGetUserLevel(user,channel) then
						table.insert(cmds,cmd)
					end
				end
			end
			ircNotice(user,ircGetUserNick(user)..", you can use these commands: "..table.concat(cmds,", "))
		end
		addIRCCommandHandler("!cmds",outputCommands)

		addIRCCommandHandler("!refresh",
			function (server,channel,user,command,name)
				if refreshResources then
					if refreshResources(false) then
						ircSay(channel,"Refreshing new resources...")
					end
				else
					ircSay(channel,"!refresh only available from 1.1 onwards")
				end
			end
		)
	end
)
