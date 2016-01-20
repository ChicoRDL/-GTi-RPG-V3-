----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn) - Modified By LilDolla
-- Date: 01 Dec 2013
-- Resource: GTIdrugs/database.lua
-- Version: 2.6
----------------------------------------->>

-- Database Functions
---------------------->>

local ipairs = ipairs
local type = type
local tonumber = tonumber

local db = dbConnect("sqlite", "drugs.db" )
--local db = dbConnect("sqlite", "drugs.db")
--dbExec(db, "CREATE TABLE IF NOT EXISTS `drugdata`(`id` INT NOT NULL AUTO_INCREMENT, `name` TEXT, PRIMARY KEY(id))")
--dbExec(db, "CREATE TABLE IF NOT EXISTS `drugdata`(`id` INT, `name` TEXT, PRIMARY KEY(id))")

local database_online   -- Is Database Online?
local drugData = {} -- Account Data Cache

addEvent("onDatabaseLoad", true)    -- Triggers when the database is ready

-- Cache Database
------------------>>

addEventHandler("onResourceStart", resourceRoot, function()
    dbQuery(cacheDatabase, {}, db, "SELECT * FROM `drugdata`")
end)

function cacheDatabase(qh)
    local result = dbPoll(qh, 0)
    drugData["Console"] = {}
    for i,row in ipairs(result) do
        drugData[row.name] = {}
        for column,value in pairs(row) do
            if (column ~= "name" or column ~= "id") then
                if (not drugData["Console"][column]) then
                    drugData["Console"][column] = true
                end
                if (value == "true") then value = true end
                if (value == "false") then value = false end
                drugData[row.name][column] = value
            end
        end
    end
    database_online = true
    triggerEvent("onDatabaseLoad", resourceRoot, "drugdata")
end

-- Cache By Account
-------------------->>
--[[
function callDatabase(player)
    if (not isElement(player) or getElementType(player) ~= "player") then return false end
    local account = getPlayerAccount(player)
    if (isGuestAccount(account)) then return false end
    local account = getAccountName(account)
    dbQuery(cacheDatabase, {player}, db, "SELECT * FROM `drugdata` WHERE `name`=?", account)
end

function cacheDatabaseByPlayer(qh, player)
    local result = dbPoll(qh, 0)
    local row = result[1]
    drugData[row.name] = {}
    for column,value in pairs(row) do
        if (column ~= "name" or column ~= "id") then
            if (not drugData["Console"][column]) then
                drugData["Console"][column] = true
            end
            if (value == "true") then value = true end
            if (value == "false") then value = false end
            drugData[row.name][column] = value
        end
    end
    triggerEvent("onDatabaseLoad", player, "drugdata")
end
--]]
-- Drug Exports
------------------->>

function SDD(account, key, value)
    if (not database_online) then return false end
    if (not account or not key) then return false end
    if (isGuestAccount(account) or type(key) ~= "string") then return false end

    local account = getAccountName(account)

    if (not drugData[account]) then
        drugData[account] = {}
        dbExec(db, "INSERT INTO `drugdata`(name) VALUES(?)", account)
    end

    if (drugData["Console"] and drugData["Console"][key] == nil) then
        dbExec(db, "ALTER TABLE `drugdata` ADD `??` text", key)
        drugData["Console"][key] = true
    end

    drugData[account][key] = value
    if (value ~= nil) then
        dbExec(db, "UPDATE `drugdata` SET `??`=? WHERE name=?", key, tostring(value), account)
    else
        dbExec(db, "UPDATE `drugdata` SET `??`=NULL WHERE name=?", key, account)
    end
    return true
end

function GDD(account, key)
    if (not database_online) then return nil end
    if (not account or not key) then return nil end
    if (isGuestAccount(account) or type(key) ~= "string") then return nil end

    local account = getAccountName(account)
    if (drugData[account] == nil) then return nil end
    if (drugData[account][key] == nil) then return nil end

    return tonumber(drugData[account][key]) or drugData[account][key]
end
