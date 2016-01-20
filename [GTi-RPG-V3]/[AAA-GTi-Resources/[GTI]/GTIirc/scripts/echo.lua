---------------------------------------------------------------------
-- Project: irc
-- Author: MCvarial
-- Contact: mcvarial@gmail.com
-- Version: 1.0.3
-- Date: 31.10.2010
---------------------------------------------------------------------

------------------------------------
-- Echo
------------------------------------
local messages = {}
local debugspam = {}
local exempt = {
	["GTIcnr"] = true,
	["GTIccr"] = true,
	["GTIpdr"] = true,
}

addEventHandler("onResourceStart",root,
	function (resource)
		if get("*irc-onResourceStart") ~= "true" then return end
		if getResourceInfo(resource,"type") ~= "map" then
			if exempt[getResourceName(resource)] then return end
			outputIRC("07* Resource '"..getResourceName(resource).."' started!")
		end
		if resource == getThisResource() then
			for i,player in ipairs (getElementsByType("player")) do
				messages[player] = 0
			end
		end
	end
)

function sendClientDebug(message, level, file, line)
	local player = getPlayerName(client)
	local account = getPlayerAccount(client)
	if (not isGuestAccount(account)) then
		account = "("..getAccountName(account)..") "
	else
		account = ""
	end
	debugMessage = player.." "..account

	local dType
	local dColor
	if level == 0 then
		dType = "CUSTOM: "
		dColor = "02"
	elseif level == 1 then
		dType = "ERROR: "
		dColor = "04"
	elseif level == 2 then
		dType = "WARNING: "
		dColor = "07"
	else
		dType = "INFO: "
		dColor = "03"
	end

	local debugMessage = dColor..debugMessage..dType
	if (level ~= 3) then
		if (not file) then file = "Unknown" end
		debugMessage = debugMessage..file
		if (not line) then line = "??" end
		debugMessage = debugMessage..":"..line
	end

	local debugMessage = debugMessage.." "..message

	--local devChan = ircGetChannelFromName( "#Dev")
	local services = ircGetChannelFromName( "#echoservices")
	--ircSay( devChan, "[Client]: "..debugMessage)
	ircSay( services, "[Client]: "..debugMessage)
end
addEvent("GTIirc.sendClientDebug", true)
addEventHandler("GTIirc.sendClientDebug", root, sendClientDebug)

local lastDebug = ""
addEventHandler( "onDebugMessage", root,
	function( message, level, file, line)
		if level == 0 then
			dType = "CUSTOM: "
			dColor = "02"
		elseif level == 1 then
			dType = "ERROR: "
			dColor = "04"
		elseif level == 2 then
			dType = "WARNING: "
			dColor = "07"
		else
			dType = "INFO: "
			dColor = "03"
		end
		debugMessage = dColor..dType
		--debugMessage = dType

		if (level ~= 3) then
			if (not file) then file = "Unknown" end
			debugMessage = debugMessage..file
			if (not line) then line = "??" end
			debugMessage = debugMessage..":"..line
		end
		local debugMessage = debugMessage.." "..message
        --local devChan = ircGetChannelFromName( "#Dev")
		if debugspam[debugMessage] == true then return end
		local services = ircGetChannelFromName( "#echoservices")
		if string.match( lastDebug, debugMessage) then
		else
			debugspam[debugMessage] = true
			setTimer(function(debugMessage)	debugspam[debugMessage] = nil end,7000,1,debugMessage)
 			lastDebug = tostring( debugMessage)
			--ircSay( devChan, "[Server]: "..debugMessage)
			ircSay( services, "[Server]: "..debugMessage)
		end
	end
)

addEventHandler("onResourceStop",root,
	function (resource)
		if get("*irc-onResourceStop") ~= "true" then return end
		if not resource then return end --Since we don't have resource, we'll stop here since it'll stop further down anyways.
		if getResourceInfo(resource,"type") ~= "map" then
			if exempt[getResourceName(resource)] then return end
			outputIRC("07* Resource '"..(getResourceName(resource) or "?").."' stopped!")
		end
	end
)
