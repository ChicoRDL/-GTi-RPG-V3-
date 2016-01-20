----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 21 Aug 2014
-- Resource: GTIadmin/bans.slua
-- Version: 1.0
----------------------------------------->>

-- Database Functions
---------------------->>

local ipairs = ipairs
local type = type
local tonumber = tonumber

local db = dbConnect("mysql", "dbname=gti;host=127.0.0.1", "GTI", "")
dbExec(db, "CREATE TABLE IF NOT EXISTS `bans`(`id` INT NOT NULL AUTO_INCREMENT, `nick` TEXT, `account` TEXT, `ip` TEXT, `serial` TEXT, `admin` TEXT, `ban_time` TEXT, `unban_time` TEXT, `reason` TEXT, PRIMARY KEY(id))")

local database_online		-- Is Database Online?
local bans = {}				-- `bans` Database Cache

local account_bans = {}		-- Bans by Account
local ip_bans = {}			-- Bans by IP
local serial_bans = {}		-- Bans by Serial

local maxBanID = 0	-- Highest Ban ID

addEvent("onDatabaseLoad", true)	-- Triggers when the database is ready

-- Cache Database
------------------>>

addEventHandler("onResourceStart", resourceRoot, function()
	dbQuery(function(qh)
		local result = dbPoll(qh, 0)
		for i,row in ipairs(result) do
			bans[row.id] = {}
			for column,value in pairs(row) do
				if (column == "account") then
					account_bans[value] = row.id
				elseif (column == "ip") then
					ip_bans[value] = row.id
				elseif (column == "serial") then
					serial_bans[value] = row.id
				end
				
				if (value == "true") then value = true end
				if (value == "false") then value = false end
				bans[row.id][column] = value
				
				if (row.id > maxBanID) then maxBanID = row.id end
			end
		end
		database_online = true
		triggerEvent("onDatabaseLoad", resourceRoot, "bans")
	end, db, "SELECT * FROM `bans`")
end)

-- Add Ban/Remove Ban
---------------------->>

function addBan(ip, serial, account, admin, duration, reason, player)
	if (not database_online) then return false end
	if (not ip and not serial and not account) then return false end
	if (ip_bans[ip] or serial_bans[serial] or account_bans[account]) then return false end
	
	local id = getBanMaxID()
	dbExec(db, "INSERT INTO `bans`(id) VALUES(?)", id)
	bans[id] = {}
	
	if (ip) then
		dbExec(db, "UPDATE `bans` SET `ip`=? WHERE `id`=?", ip, id)
		ip_bans[ip] = id
		bans[id]["ip"] = ip
	end
	
	if (serial) then
		dbExec(db, "UPDATE `bans` SET `serial`=? WHERE `id`=?", serial, id)
		serial_bans[serial] = id
		bans[id]["serial"] = serial
	end
	
	if (account) then
		dbExec(db, "UPDATE `bans` SET `account`=? WHERE `id`=?", account, id)
		account_bans[account] = id
		bans[id]["account"] = account
	end
	
	if (isElement(player)) then
		dbExec(db, "UPDATE `bans` SET `nick`=? WHERE `id`=?", getPlayerName(player), id)
		bans[id]["nick"] = getPlayerName(player)
	end
	
	if (isElement(admin)) then
		admin = getPlayerName(admin)
	else
		admin = "Console"
	end
	ban_time = getRealTime().timestamp
	duration = ban_time + duration
	
	dbExec(db, "UPDATE `bans` SET `admin`=?, `ban_time`=?, `unban_time`=?, `reason`=? WHERE `id`=?", admin, ban_time, duration, reason, id)
	bans[id]["admin"] = admin
	bans[id]["ban_time"] = ban_time
	bans[id]["unban_time"] = duration
	bans[id]["reason"] = reason
	
	if (id > maxBanID) then maxBanID = id end
	return true
end

function removeBan(ip, serial, account, disablelogging)
	if (not database_online) then return false end
	if (not ip_bans[ip] and not serial_bans[serial] and not account_bans[account]) then return false end

	if ( not disablelogging ) then
		if (ip) then
			exports.GTIlogs:outputAdminLog("BAN: IP Address ban removed on IP address "..ip)
		end
		if (serial) then
			exports.GTIlogs:outputAdminLog("BAN: Serial ban removed on serial "..serial)
		end
		if (account) then
			exports.GTIlogs:outputAdminLog("BAN: Account ban removed on account "..account)
		end
	end
	
	local id = ip_bans[ip] or serial_bans[serial] or account_bans[account]
	
	if (ip_bans[ip]) then 			ip_bans[ip] = nil 			end
	if (serial_bans[serial]) then 	serial_bans[serial] = nil 	end
	if (account_bans[account]) then account_bans[account] = nil end
	
	bans[id] = nil
	dbExec(db, "DELETE FROM `bans` WHERE `id`=?", id)
	
	if (maxBanID == id) then maxBanID = maxBanID - 1 end
	return true
end

-- Add/Remove Player Ban
------------------------->>

function banPlayer(player, ip, serial, account, admin, duration, reason)
	if (not isElement(player) or not exports.GTIutil:isPlayerLoggedIn(player)) then return false end

	addBan(ip, serial, account, admin, duration, reason, player)
	
	local name = getPlayerName(player)
	local admin_name = getPlayerName(admin)
	redirectPlayer(player, "", 0)
	local time_text = sentenceToTime(duration)	
	outputAdminNotice(name.." has been banned by "..admin_name.." for "..time_text.." ("..reason..")")
	exports.GTIlogs:outputAdminLog("BAN: "..name.." has been banned by "..admin_name.." for "..time_text.." ("..reason..")", admin)
	addPunishlogEntry(player, admin, name.." has been banned by "..admin_name.." for "..time_text.." ("..reason..")")
	return true
end

-- Is Player Banned?
--------------------->>

function isPlayerBanned(value)
	if (ip_bans[value] or serial_bans[value] or account_bans[value]) then return true end
	if (not isElement(value)) then return false end
	
	if (ip_bans[getPlayerIP(value)] or serial_bans[getPlayerSerial(value)]) then return true end
	
	local account = getPlayerAccount(value)
	if (isGuestAccount(account)) then return false end
	
	if (account_bans[getAccountName(account)]) then return true end
	
	return false
end

-- Get Ban...
-------------->>

function getBans()
	return bans
end

function getBanID(value)
	return ip_bans[value] or serial_bans[value] or account_bans[value] or false
end

function getBanAccount(id)
	if (not bans[id]) then return false end
	return bans[id]["account"] or false
end

function getBanAdmin(id)
	if (not bans[id]) then return false end
	return bans[id]["admin"] or "Console"
end

function getBanIP(id)
	if (not bans[id]) then return false end
	return bans[id]["ip"] or false
end

function getBanNick(id)
	if (not bans[id]) then return false end
	return bans[id]["nick"] or false
end

function getBanReason(id)
	if (not bans[id]) then return false end
	return bans[id]["reason"] or "No Reason"
end

function getBanSerial(id)
	if (not bans[id]) then return false end
	return bans[id]["serial"] or false
end

function getBanTime(id)
	if (not bans[id]) then return false end
	return tonumber(bans[id]["ban_time"]) or false
end

function getUnbanTime(id)
	if (not bans[id]) then return false end
	return tonumber(bans[id]["unban_time"]) or 0
end

-- Set Ban...
-------------->>

function setBanReason(id, reason)
	if (not bans[id]) then return false end
	bans[id]["reason"] = reason
	dbExec(db, "UPDATE `bans` SET `reason`=? WHERE `id`=?", reason, id)
	return true
end

function setUnbanTime(id, duration)
	if (not bans[id]) then return false end
	local ban_time = getBanTime(id)
	bans[id]["unban_time"] = ban_time + duration
	dbExec(db, "UPDATE `bans` SET `unban_time`=? WHERE `id`=?", ban_time + duration, id)
	return true
end

-- Auto-Unban Players
---------------------->>

setTimer(function()
	for id in pairs(bans) do
		if (getRealTime().timestamp > getUnbanTime(id) and getUnbanTime(id) ~= 0) then
			removeBan(getBanIP(id), getBanSerial(id), getBanAccount(id))
		end
	end
end, 60000, 0)

-- Utilities
------------->>
	
function getBanMaxID()
	return maxBanID + 1
end
