----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn), LilDolla
-- Date: 21 Aug 2014
-- Resource: GTIgovt/records.slua
-- Version: 1.0
----------------------------------------->>

-- Database Functions
---------------------->>

local ipairs = ipairs
local type = type
local tonumber = tonumber

local db = dbConnect("mysql", "dbname=gti_logs;host=127.0.0.1", "GTILogs", "")
dbExec(db, "CREATE TABLE IF NOT EXISTS `log_punish`(`id` INT NOT NULL AUTO_INCREMENT, `account` TEXT, `serial` TEXT, `admin` TEXT, `reason` TEXT, `logged` TEXT, `expires` TEXT, PRIMARY KEY(id))")

local database_online		-- Is Database Online?
local punishments = {}		-- `log_punish` Database Cache

local maxLogID = 1				-- Max Log Database ID
local DEFAULT_EXPIRE = 720		-- 30 Day Expire (720 Hours)

local LAST_LOG = ""

addEvent("onDatabaseLoad", true)	-- Triggers when the database is ready

-- Cache Database
------------------>>

function updateDatabase()
	for account,data in pairs(punishments) do
		punishments[account] = {}
	end
	dbQuery(function(qh)
		local result = dbPoll(qh, 0)
		for i,row in ipairs(result) do
			if not punishments[row.account] then
				punishments[row.account] = {}
			else
			end
			for column,value in pairs(row) do
				if (value == "true") then value = true end
				if (value == "false") then value = false end
				if LAST_LOG ~= row.id then
					table.insert(punishments[row.account], { row.id, row.account, row.serial, row.admin, row.reason, row.logged, row.expires})
					LAST_LOG = row.id
				end
				if (row.id > maxLogID) then
					maxLogID = row.id
				end
			end
		end
	end, db, "SELECT * FROM `log_punish`")
end

addEventHandler("onResourceStart", resourceRoot, function()
	updateDatabase()
	setTimer(updateDatabase, 3600000, 0)
	database_online = true
	triggerEvent("onDatabaseLoad", resourceRoot, "log_punish")
end)


-- Punish Database
------------------->>

function addPunishlog(account, serial, admin, reason)
	if (not database_online) then return false end
	if (not serial and not account) then return false end

	if not punishments[account] then
		punishments[account] = {}
	end

	if (isElement(admin)) then
		admin = getPlayerName(admin)
	else
		admin = "Console"
	end
	local logNum = maxLogID + 1
	local logTime = getRealTime().timestamp
	local expireTime = logTime + ( ( DEFAULT_EXPIRE * 60 ) * 60 )

	dbExec(db, "INSERT INTO `log_punish`(account, serial, admin, reason, logged, expires) VALUES(?, ?, ?, ?, ?, ?)", account, serial, admin, reason, logTime, expireTime)
	table.insert(punishments[account], {logNum, account, serial, admin, reason, logTime, expireTime})
	maxLogID = maxLogID + 1
	return true
end

function removePunishlog(account, id, tid)
	if (not database_online) then return false end
	if punishments[account] then
		table.remove(punishments[account], tid)
		dbExec(db, "DELETE FROM `log_punish` WHERE `id`=? AND `account`=?", id, account)
		if (maxLogID == id) then
			maxLogID = maxLogID - 1
		end
	end
	return true
end

-- Add/Remove Log
------------------>>

function addPunishmentToLog(player, admin, reason)
	if (not isElement(player) or not exports.GTIutil:isPlayerLoggedIn(player)) then return false end

	local acc = getPlayerAccount(player)
	local account = getAccountName(acc)
	local serial = getPlayerSerial(player)

	addPunishlog(account, serial, admin, reason)
	return true
end

function deleteLogEntry(table_id, log_id, account)
	local acc = getPlayerAccount(source)
	local acc = getAccountName(acc)
	if log_id and account then
		if exports.GTIgovt:isAdmin(source) then
			removePunishlog(account, log_id, table_id)
			outputChatBox("Deleted a punish log entry on account '"..account.."'.", source, 40, 178, 224)
			if not string.match(acc, account) then
				if getAccountPlayer(getAccount(account)) then
					exports.GTIlogs:outputAdminLog("PUNISH LOG: "..getPlayerName(source).." deleted one of "..getPlayerName(getAccountPlayer(getAccount(account))).."'s rows.", source)
				else
					exports.GTIlogs:outputAdminLog("PUNISH LOG: "..getPlayerName(source).." deleted one of "..account.."'s rows.", source)
				end
			else
				exports.GTIlogs:outputAdminLog("PUNISH LOG: "..getPlayerName(source).." deleted one of their own rows.", source)
			end

			local ptable = punishments[account]

			if ptable then
				triggerClientEvent(source, "GTIpunishlog.gatherLogs", source, true, ptable, account)
			end
		end
	end
end
addEvent("GTIpunishlog.deleteLogEntry", true)
addEventHandler("GTIpunishlog.deleteLogEntry", root, deleteLogEntry)

-- View Records
---------------->>

function viewPlayerPunishLog(player, account, withdeletion)
	if isElement(player) then
		if getAccount(account) then
			local ptable = punishments[account] or {}
			if ptable then
				triggerClientEvent(player, "GTIpunishlog.gatherLogs", player, withdeletion or false, ptable, account)
			end
		end
	end
end

function viewPunishLog(player, _, account)
	if ( exports.GTIutil:isPlayerInACLGroup(player, "Dev5", "Admin2", "Admin3", "Admin4", "Admin5") ) then
		if ( account ) then
			if ( getAccount(account) ) then
				if ( punishments[account] ) then
					viewPlayerPunishLog(player, account, true)
				else
					exports.GTIhud:dm("ERROR: The specified account hasn't logged punishments", player, 255, 0, 0)
				end
			else
				exports.GTIhud:dm("ERROR: The specified account doesn't exist", player, 255, 0, 0)
			end
		else
			exports.GTIhud:dm("ERROR: Syntax: /viewpunishlog <account>", player, 255, 0, 0)
		return end
	else
		exports.GTIhud:dm("ERROR: This command is restricted to Admins", player, 255, 0, 0)
	end
end
addCommandHandler("viewpunishlog", viewPunishLog)

-- Auto-Remove Punishments
--------------------------->>

setTimer(function()
	for account, data in pairs(punishments) do
		for i, logs in pairs (data) do
			--local startTime = logs[6]
			local endTime = logs[7]

			if (tonumber(getRealTime().timestamp) > tonumber(endTime)) then
				removePunishlog(account, logs[1], i)
				--exports.GTIirc:ircSay(exports.GTIirc:ircGetChannelFromName("#Gov't"), "Logs: Row deleted on account "..account)
			end
		end
	end
end, 30000, 0)
