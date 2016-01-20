----------------------------------------->>
-- GTI: Grand Theft International Network
-- Date: 15 Dec 2013
-- Resource: GTIutil/util.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Find Player
--------------->>

function findPlayer(player)
    if (player and type(player) == "string") then
        local playerElement = getPlayerFromName(player)
        if (playerElement) then return playerElement end
        local playersCounted = 0
        local player = string.lower(player)
        local spl = split(player, string.byte("["))
        if (spl) then
            player = table.concat(spl, ";")
        end
        for k, v in pairs(getElementsByType("player")) do
            local name = string.lower(getPlayerName(v))
            local spl = split(name, string.byte("["))
            if (spl) then
                name = table.concat(spl, ";")
            end
            if (string.find(name, player)) then
                playerElement = v
                playersCounted = playersCounted + 1
            end
        end
        if (playerElement and playersCounted == 1) then
            return playerElement
        end
        return false
    else
        return false
    end
end

-- Find Rotation
----------------->>

function findRotation(x1,y1,x2,y2)
	local t = -math.deg(math.atan2(x2-x1,y2-y1))
	if t < 0 then t = t + 360 end
	return t
end

-- Generate Password
--------------------->>

local alphabet = {
	"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z",
	"a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", -- Index: 52
	"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", -- Index: 62
	"~", "`", "!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "=", "+", "[", "{", "]", "}", "\\", "|", ":", ";", "'", "\"",
	",", "<", ".", ">", "/", "?", -- Index: 94
}

function generatePassword(length, numbers, symbols)
	if (type(length) ~= "number") then return false end
	
	local password = {}
	for i=1,length do
		-- Pick a character
		local range = math.random(52)
		if (numbers and not symbols) then range = math.random(62) end
		if (numbers and symbols) then range = math.random(94) end
		if (not numbers and symbols) then 
			local letter_or_symbol = math.random()
			if (letter_or_symbol < (52 / (52+34))) then
				range = math.random(52)
			else
				range = math.random(63,94)
			end
		end
		
		table.insert(password, alphabet[range])
	end
	password = table.concat(password, "")
	return password
end	

-- Get Distance Between Elements
--------------------------------->>

function getDistanceBetweenElements2D(element1, element2)
	if (not isElement(element1) or not isElement(element2)) then return false end
	local x1,y1,z1 = getElementPosition(element1)
	local x2,y2,z2 = getElementPosition(element2)
	return getDistanceBetweenPoints2D(x1, y1, x2, y2)
end

function getDistanceBetweenElements3D(element1, element2)
	if (not isElement(element1) or not isElement(element2)) then return false end
	local x1,y1,z1 = getElementPosition(element1)
	local x2,y2,z2 = getElementPosition(element2)
	return getDistanceBetweenPoints3D(x1, y1, z1, x2, y2, z2)
end

-- Get Element Speed
--------------------->>

function getElementSpeed(element, unit)
	if (not isElement(element)) then return false end
	if (not unit) then unit = "mph" end
	local x,y,z = getElementVelocity(element)
	if (unit == "mph") then
		return (x^2 + y^2 + z^2) ^ 0.5 * 111.847
	else
		return (x^2 + y^2 + z^2) ^ 0.5 * 180
	end
end

-- Month Number to Text
------------------------>>

local monthTable = {"January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"}
function getMonthName(month, digits)
	if (not monthTable[month]) then return end
	local month = monthTable[month]
	if (digits) then
		month = string.sub(month, 1, digits)
	end
	return month
end

-- Get Ped Weapons
------------------->>

function getPedWeapons(ped)
	local playerWeapons = {}
	if ped and isElement(ped) and getElementType(ped) == "ped" or getElementType(ped) == "player" then
		for i=0,12 do
			local wep = getPedWeapon(ped,i)
			if wep and wep ~= 0 then
				table.insert(playerWeapons,wep)
			end
		end
	else
		return false
	end
	return playerWeapons
end

-- Get AFK Time
---------------->>

local lastPos = {}		-- Storage of Last Position
local lastRot = {}		-- Storage of Last Rotation
local AFK_Time = {}		-- Storage of AFK Intervals
local MOVE_DIST = 5		-- Meters Moved to Not be AFK

function getPercentOfTimeAFK(player, mins)
	if (not isElement(player) or type(mins) ~= "number") then return false end
	if (not AFK_Time[player]) then AFK_Time[player] = {} end
	local j = mins
	if (#AFK_Time[player] < mins) then j = #AFK_Time[player] end
	local count = 0
	for i=#AFK_Time[player],#AFK_Time[player]-j+1,-1 do
		if (AFK_Time[player][i] == true) then
			count = count + 1
		end
	end
	return (count/j)
end

setTimer(function()
	for i,player in ipairs(getElementsByType("player")) do
		if lastPos[player] then
			local x1,y1,z1 = getElementPosition(player)
			local x2,y2,z2 = unpack(lastPos[player])
			-- Meets Movement Requirement
			if (getDistanceBetweenPoints3D(x1,y1,z1,  x2,y2,z2) > MOVE_DIST) then
				lastPos[player] = {x1,y1,z1}
				local _,_,rot1 = getElementRotation(player)
				local rot2 = lastRot[player]
				-- Meets Changing Direction Requirement
				if (math.floor(rot1) ~= math.floor(rot2)) then
					lastRot[player] = rot1
					-- Player is Not AFK
					table.insert(AFK_Time[player], false)
				else
					table.insert(AFK_Time[player], true)
				end
			else
				table.insert(AFK_Time[player], true)
			end
		end
	end
end, 60000, 0)

addCommandHandler("afktime", function(player, _, mins)
	if (not mins) then mins = #AFK_Time[player] end
	mins = tonumber(mins)
	if (not mins) then
		outputChatBox("> Syntax Error. <minutes> must be a number", player, 255, 25, 25)
		return
	end
	local percent = getPercentOfTimeAFK(player, mins)*100
	outputChatBox("> AFK Time: You have spent "..string.format("%.1f", percent).."% of the past "..mins.." minutes AFK.", player, 255, 200, 0)
end)

addEventHandler("onResourceStart", resourceRoot, function()
	for i,player in ipairs(getElementsByType("player")) do
		lastPos[player] = {0,0,0}
		lastRot[player] = 0
		AFK_Time[player] = {}
	end
end)

addEventHandler("onPlayerJoin", root, function()
	lastPos[source] = {0,0,0}
	lastRot[source] = 0
	AFK_Time[source] = {}
end)

addEventHandler("onPlayerQuit", root, function()
	lastPos[source] = nil
	lastRot[source] = nil
	AFK_Time[source] = nil
end)

-- Is In ACL
------------->>

function isPlayerInACLGroup(player, ...)
	if (not player or not ...) then return false end
	if (not isElement(player) or getElementType(player) ~= "player") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	
	local acl = {...}
	if (#acl == 1) then	
		return isObjectInACLGroup("user."..getAccountName(account), aclGetGroup(acl[1])) or false
	else
		for i,acl in ipairs(acl) do
			if (isObjectInACLGroup("user."..getAccountName(account), aclGetGroup(acl))) then
				return true
			end
		end
		return false
	end
end	

-- Team
-------->>

function isPlayerInTeam(player, teamName)
	if (not isElement(player) or getElementType(player) ~= "player") then return false end
	local team = getPlayerTeam(player)
	if (not team) then return false end
	local team = getTeamName(team)
	if (team ~= teamName) then return false end
	return true
end

-- Logged In
------------->>

function isPlayerLoggedIn(player)
	if (not isElement(player) or getElementType(player) ~= "player") then return false end
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return false end
	return true
end

-- Get Players In Dimension
---------------------------->>

function getPlayersInDimension(dim)
	local dim = tonumber(dim)
	local dimTable = {}
	for i, players in pairs (getElementsByType("player")) do
		local dimension = getElementDimension(players)
		if dimension == dim then
			table.insert(dimTable, players)
			return dimTable
		else
			return false
		end
		local dimTable = {}
	end
end

-- RGB to Hex
-------------->>

function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

-- tocomma
----------->>

function tocomma(number)
	while true do
		number, k = string.gsub(number, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return number
end

-- To Date
----------->>

function todate(timestamp)
	local year = math.floor(timestamp/31557600)+1970
	local isLeapYear = false
	if ((year % 4 == 0 and year % 100 ~= 0) or (year % 400 == 0)) then
		isLeapYear = true
	end

	local daysLeft = math.floor((timestamp-((year-1970)*31557600))/86400)+1
	local month = 1
	if (daysLeft <= 31) then
		month = 1
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 31
	if ((daysLeft <= 28) or (isLeapYear and daysLeft <= 29)) then
		month = 2
		return daysLeft, month, year
	end
	if (not isLeapYear) then
		daysLeft = daysLeft - 28 else daysLeft = daysLeft - 29 end
	if (daysLeft <= 31) then
		month = 3
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 31
	if (daysLeft <= 30) then
		month = 4
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 30
	if (daysLeft <= 31) then
		month = 5
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 31
	if (daysLeft <= 30) then
		month = 6
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 30
	if (daysLeft <= 31) then
		month = 7
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 31
	if (daysLeft <= 31) then
		month = 8
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 31
	if (daysLeft <= 30) then
		month = 9
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 30
	if (daysLeft <= 31) then
		month = 10
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 31
	if (daysLeft <= 30) then
		month = 11
		return daysLeft, month, year
	end
	daysLeft = daysLeft - 30
	month = 12
	if (daysLeft > 31) then daysLeft = 31 end
	return daysLeft, month, year
end

-- To Time
----------->>

function totime(timestamp)
	local timestamp = timestamp - (math.floor(timestamp/86400) * 86400)
	local hours = math.floor(timestamp/3600)
	timestamp = timestamp - (math.floor(timestamp/3600) * 3600)
	local mins = math.floor(timestamp/60)
	local secs = timestamp - (math.floor(timestamp/60) * 60)
	return hours, mins, secs
end

--Set player ghost! (server-side)
function setPlayerGhost(player,state)
	if (not player or not (isElement(player)) or not (getElementType(player) == "player")) then return false end
	if (type(state) ~= "boolean") then return false end
	
	triggerClientEvent(player,"GTIutil:setPlayerGhost",player,player,state)
	return true --return true, since we don't know the return state clientside.
end

-- onPlayerChangeInterior handler
addEvent("GTIutil:onPlayerChangeInterior",true)
addEventHandler("GTIutil:onPlayerChangeInterior",root,
function(previousInt,newInt)
	triggerEvent("onPlayerChangeInterior",client,previousInt,newInt)
end)

function getPlayerTask(player)
	if not player or not isElement(player) or not getElementType(player) == "player" then return false end
	
	return getElementData(player,"pedTasks") or false
end

function urlEncode(str)
	if (str) then
		str = string.gsub (str, "\n", "\r\n")
		str = string.gsub (str, "([^%w ])",
			function (c) return string.format ("%%%02X", string.byte(c)) end)
		str = string.gsub (str, " ", "+")
	end
	return str
end

function getPedMaxHealth(ped)
    assert(isElement(ped) and (getElementType(ped) == "ped" or getElementType(ped) == "player"), "Bad argument @ 'getPedMaxHealth' [Expected ped/player at argument 1, got " .. tostring(ped) .. "]")
    local stat = getPedStat(ped, 24)
    local maxhealth = 100 + (stat - 569) / 4.31
    return math.max(1, maxhealth)
end