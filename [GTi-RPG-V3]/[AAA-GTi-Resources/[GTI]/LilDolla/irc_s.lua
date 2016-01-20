local echo_spam = {}

local exceptions = {
	["Kayla"] = true,
}

function remoteIRCOutput( chan, message, main)
	local chan = exports.GTIirc:ircGetChannelFromName( chan)
	if not main then
		exports.GTIirc:ircSay( chan, message)
	else
		--callRemote("http://mta.gtirpg.net/MTA/multichat.php", function() end, chan, message)
	end
end

function service_say( stype, text)
	if not channel then
		local chan = exports.GTIirc:ircGetChannelFromName( "#Kayla")
		exports.GTIirc:ircSay( chan, "["..string.upper(stype).."]:"..text)
	end
end

function getIRCServer()
	local channel = exports.GTIirc:ircGetChannelFromName( "#echo")
	local server = exports.GTIirc:ircGetChannelServer( channel)
	return server
end

function kaylaKick( user, channel)
	if not exports.GTIirc:ircGetUserNick( user) then return end
	if not reason then
		local user = exports.GTIirc:ircGetUserNick( user)
		exports.GTIirc:ircRaw( getIRCServer(), "KICK "..channel.." "..user)
	end
end

function kaylaJoin( channel, pass)
	if exports.GTIirc:ircGetChannelFromName( channel) then
		if not pass then
			exports.GTIirc.ircJoin( getIRCServer(), channel)
		else
			exports.GTIirc.ircJoin( getIRCServer(), channel, pass)
		end
	end
end



addEvent( "onIRCMessage")
addEventHandler( "onIRCMessage", root,
	function( channel, message)
		if not echo_spam[source] then
			echo_spam[source] = 0
		end

		local user = exports.GTIirc:ircGetUserNick( source)
		local channeln = exports.GTIirc:ircGetChannelName( channel)

		if channeln == "#echo" then
			if exceptions[user] then return end
			local rnum = exports.GTIirc:ircGetUserLevel( source, channel)
			if type(rnum) == "number" and rnum >= 3 then return end
			echo_spam[source] = echo_spam[source] + 1

			if echo_spam[source] >= 5 then
				kaylaKick( source, "#echo")
				echo_spam[source] = 0
			end
		elseif channeln == "#echoservices" then
			if user == "Kayla" then
				echo_spam[source] = echo_spam[source] + 1
				if echo_spam[source] >= 7 then
					remoteIRCOutput( "#echoservices", "Preventing 'RecvQ exceeded'. Restarting Myself.")
					restartResource( getResourceFromName( "GTIirc"))
					--kaylaKick( source, "#echoservices")
					--setTimer( kaylaJoin, 2500, "#echoservices")
				end
			end
		end
	end
)

setTimer(
	function()
		echo_spam = {}
	end, 10000, 0
)

function queryIRCUser( user, message)
	if exports.GTIirc:ircGetUserFromNick( user) then
		local user = exports.GTIirc:ircGetUserFromNick( user)
		exports.GTIirc:ircSay( user, message)
	else
		return false
	end
end

addEvent( "onIRCPrivateMessage")
addEventHandler( "onIRCPrivateMessage", root,
	function( message)
		local user = source
		local user = exports.GTIirc:ircGetUserNick( user)

		service_say( "Query", user..": "..message)
	end
)

--[[
addEvent( "onIRCUserJoin")
addEventHandler( "onIRCUserJoin", root,
	function( channel)
		local channel = exports.GTIirc:ircGetChannelName( channel)

		local user = source
		local user = exports.GTIirc:ircGetUserNick( user)

		service_say( "Join", user.." joined "..channel)
	end
)

addEvent( "onIRCUserPart")
addEventHandler( "onIRCUserPart", root,
	function( channel, reason)
		local channel = exports.GTIirc:ircGetChannelName( channel)

		local user = source
		local user = exports.GTIirc:ircGetUserNick( user)

		if not reason then
			reason = "No Reason"
		end

		service_say( "Part", user.." parted "..channel..". ( "..tostring(reason)..")")
	end
)
--]]
