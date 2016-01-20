﻿---------------------------------------------------------------------
-- Project: irc
-- Author: MCvarial
-- Contact: mcvarial@gmail.com
-- Version: 1.0.3
-- Date: 31.10.2010
---------------------------------------------------------------------

------------------------------------
-- Utility
------------------------------------

function getNickFromRaw (raw)
	return string.sub(gettok(raw,1,33),2)
end

function getMessageFromRaw (raw)
	local t = split(string.sub(raw,2,-2),58)
	table.remove(t,1)
	return table.concat(t,":")
end

local chars = {"+","%","@","&","~"}
function getNickAndLevel (nick)
	for i,char in ipairs (chars) do
		if string.sub(nick,1,1) == char then
			nick = string.sub(nick,2)
			return nick,i
		end
	end
	return nick,0
end

function toletters (string)
	local t = {}
	for i=1,string.len(string) do
		table.insert(t,string.sub(string,1,1))
		string = string.sub(string,2)
	end
	return t
end

function getPlayerFromPartialName (name)
	local matches = {}
	for i,player in ipairs (getElementsByType("player")) do
		if getPlayerName(player) == name then
			return player
		end
		if string.find(string.lower(getPlayerName(player)),string.lower(name),0,true) then
			table.insert(matches,player)
		end
	end
	if #matches == 1 then
		return matches[1]
	end
	return false
end

function getTeamFromPartialName (name)
	local matches = {}
	for i,team in ipairs (getElementsByType("team")) do
		if getTeamName(team) == name then
			return team
		end
		if string.find(string.lower(getTeamName(team)),string.lower(name),0,true) then
			table.insert(matches,team)
		end
	end
	if #matches == 1 then
		return matches[1]
	end
	return false
end

function getResourceFromPartialName (name)
	local matches = {}
	for i,resource in ipairs (getResources()) do
		if getResourceName(resource) == name then
			return resource
		end
		if string.find(string.lower(getResourceName(resource)),string.lower(name),0,true) then
			table.insert(matches,resource)
		end
	end
	if #matches == 1 then
		return matches[1]
	end
	return false
end

function getTimeStamp ()
	local time = getRealTime()
	return "["..(time.year + 1900).."-"..(time.month+1).."-"..time.monthday.." "..time.hour..":"..time.minute..":"..time.second.."]"
end

function msToTimeStr(ms)
	if not ms then
		return ''
	end
	local centiseconds = tostring(math.floor(math.fmod(ms, 1000)/10))
	if #centiseconds == 1 then
		centiseconds = '0' .. centiseconds
	end
	local s = math.floor(ms / 1000)
	local seconds = tostring(math.fmod(s, 60))
	if #seconds == 1 then
		seconds = '0' .. seconds
	end
	local minutes = tostring(math.floor(s / 60))
	return minutes .. ':' .. seconds .. ':' .. centiseconds
end

function getTimeString (timeMs)
	local weeks = math.floor(timeMs/604800000)
	timeMs = timeMs - weeks * 604800000
	
	local days = math.floor(timeMs/86400000)
	timeMs = timeMs - days * 86400000
	
	local hours = math.floor(timeMs/3600000)
	timeMs = timeMs - hours * 3600000
	
	local minutes = math.floor(timeMs/60000)
	timeMs = timeMs - minutes * 60000
	
	local seconds = math.floor(timeMs/1000)
	
	return string.format("%dwks %ddays %dhrs %dmins %dsecs ",weeks,days,hours,minutes,seconds)
end

function getNumberFromVersion (version)
	local p1,p2,p3 = unpack(split(version,46))
	return tonumber((100*tonumber(p1))+(10*tonumber(p2))+(tonumber(p3)))
end

function getSocketErrorString (i)
	local error
	if type(i) == "number" then
		local file = fileOpen("scripts/socketerrors.lua")
		if file then
			local content = fileRead(file,fileGetSize(file))
			if content then
				loadstring(content)()
				if socketErrors[i] then
					error = socketErrors[i]
				end
			end
			fileClose(file)
		end
	end
	socketErrors = nil
	return error or "Unknown error"
end