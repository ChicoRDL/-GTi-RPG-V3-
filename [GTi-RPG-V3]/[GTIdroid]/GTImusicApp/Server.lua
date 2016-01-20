--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz ~, LilDolla [Saving]
-- Resource: GTImusicApp/Server.lua ~
-- Description: GTIdroid Music App ~
-- Data: #Music
--<--------------------------------->--

local featureDisabled = true --Set to false when we have a converter. (Jack)

function table.empty(a )
    if type(a ) ~= "table" then
        return false
    end

    return not next(a )
end

function savePlaylist( theTable)
    local account = getPlayerAccount(client)
    exports.GTIaccounts:invSet(account, "GTImusicApp.playlist", theTable)
end
addEvent( "GTImusicApp.sendTableOnline", true)
addEventHandler( "GTImusicApp.sendTableOnline", root, savePlaylist)

function getPlayerPlaylist(player)
    local account = getPlayerAccount(player)
    if exports.GTIaccounts:invGet(account, "GTImusicApp.playlist") then
        local ttable = exports.GTIaccounts:invGet(account, "GTImusicApp.playlist")
        return ttable
    else
        return false
    end
end

function queryPlaylist()
    local playlist = getPlayerPlaylist( client)
    if playlist then
        triggerClientEvent( client, "GTImusicApp.sendPlaylist", client, playlist)
    end
end
addEvent( "GTImusicApp.getPlaylist", true)
addEventHandler( "GTImusicApp.getPlaylist", root, queryPlaylist)

local db = dbConnect( "sqlite", "music.db")
dbExec(db, "CREATE TABLE IF NOT EXISTS `music`(`account` TEXT, `mName` TEXT, PRIMARY KEY (account))")

local musicCache = {}
local dbOnline

addEvent("onDatabaseLoad", true)

addEventHandler("onResourceStart", resourceRoot, function()
    dbQuery(function(qh)
        local result = dbPoll(qh, 0)
        musicCache["Console"] = {}
        for i,row in ipairs(result) do
            musicCache[row.mName] = {}
            for column,value in pairs(row) do
                if (column ~= "account" or column ~= "mName") then
                    musicCache["Console"][column] = true
                    --table.insert( musicCache["Console"], { column, true})
                    if (value == "true") then value = true end
                    if (value == "false") then value = false end
                    musicCache[row.mName][column] = value
                    --table.insert( musicCache[row.mName], { column, value})
                end
            end
        end
        dbOnline = true
        triggerEvent("onDatabaseLoad", resourceRoot, "GTImusicApp")
    end, {}, db, "SELECT * FROM `music`")
end)

function addSong(account, songName, songURL)
    if (not dbOnline) then return false end
    if (not account or not songName) then return false end
    if (isGuestAccount(account) or type(songName) ~= "string") then return false end

    local account = getAccountName(account)
    if (type(musicCache[account]) ~= "table") then
        musicCache[account] = {}
        dbExec(db, "INSERT INTO `music`(mName) VALUES(?)", account)
    end

    if (musicCache["Console"][songName] == nil) then
        dbExec(db, "ALTER TABLE `music` ADD `??` text", songName)
        musicCache["Console"][songName] = true
    end

    musicCache[account][songName] = songURL
    if (songURL ~= nil) then
        dbExec(db, "UPDATE `music` SET `??`=? WHERE mName=?", songName, tostring(songURL), account)
    else
        dbExec(db, "UPDATE `music` SET `??`=NULL WHERE mName=?", songName, account)
    end
    return true
end

function getSong( account, songName)
    if (not dbOnline) then return false end
    if (not account or not songName) then return nil end
    if (isGuestAccount(account) or type(songName) ~= "string") then return nil end

    local account = getAccountName(account)
    if (musicCache[account] == nil) then return nil end
    if (musicCache[account][songName] == nil) then return nil end

    return tonumber(musicCache[account][songName]) or musicCache[account][songName]
end

function getAllPlayerSongs( player)
    local acc = getPlayerAccount( player)
    local acc = getAccountName( acc)
    local qh = dbQuery( db, "SELECT * FROM `music`", acc)
    local result = dbPoll( qh, 0)
    for i, row in pairs (result) do
        local loggedName = row.account
        if string.match( loggedName, getAccountName(acc)) then
            outputChatBox( "Found music stuffs", player)
        end
    end
end

addEvent ( "GTImusicApp.addMusic", true )
function addMusic ( name, url )
    local account = getPlayerAccount( client)
    if not getSong( account, name) then
        addSong( account, name, url)
        triggerClientEvent( client, "GTImusicApp.addingConfirmed", client, name, url, true)
    else
        triggerClientEvent( client, "GTImusicApp.addingConfirmed", client, "", "", false)
        outputChatBox( "This song is already in your list.", client, 255, 0, 0)
    end
    getAllPlayerSongs( client)

    local account = getPlayerAccount( client )
    if dbExec( db, "SELECT * FROM `music` WHERE `account`=?", account) then
        dbExec( db, "INSERT INTO `music` VALUES(?,?,?)", account, name, url)
    end
end
addEventHandler ( "GTImusicApp.addMusic", root, addMusic )

function addSongToAccount( player, name, url) -- LilDolla's Export [No touch plis]
	--local account = getAccountName( acc)
	local account = getPlayerAccount( player)
	if player then
		if not getSong( account, name) then
			addSong( account, name, url)
			triggerClientEvent( player, "GTImusicApp.addingConfirmed", player, name, url, true)
			local playlist = getPlayerPlaylist( player)
			triggerClientEvent( player, "GTImusicApp.sendPlaylist", player, playlist)
		end
	end
end

local cooldown = {}
function convert( player, _, url)

	if featureDisabled then return exports.GTIhud:dm("This feature has been disabled because the converter is down.",player,255,0,0) end

    if (url) then
        --See if a cooldown is in progress
        if (cooldown[player]) and (isTimer(cooldown[player])) then
            local seconds, _, _ = getTimerDetails(cooldown[player])
            exports.GTIhud:dm("You must wait "..math.floor(seconds/1000).." seconds before you can convert another video.",player,255,0,0)
            return false
        end

        --Parse the url for a youtube link.
        local start = url:find("v=")
        if start then
            local _end = start and (url:sub(start):find("&") or url:len())
            if start and _end then
                local url = url:sub(start+2,_end)
                outputDebugString(tostring(url))
                fetchRemote("http://s1.pilovali.nl:8089/api.php?id=http://youtube.com/watch?v="..url, urlCallBack, "", false, player)
                exports.GTIhud:dm("Please wait while we convert your youtube video...", player, 0, 129, 129)
                cooldown[player] = setTimer(function() end, 60000, 1) --Just add a dummy timer.
                return true
            end
        else
            return exports.GIThud:dm("This is not a valid youtube link. Please copy and paste the URL directly from the browser.",player,255,0,0)
        end
    else
        exports.GTIhud:dm("To convert a youtube video, please insert the youtube url (/convert http://www.youtube.com/watch?v=KMU0tzLwhbE)",player,255,0,0)
        return false
    end
end
addCommandHandler("convert", convert)

function urlCallBack( responseData, errno, playerToReceive )
    if errno == 0 or errno ~= nil then
        exports.GTIhud:dm( responseData, playerToReceive, 0, 129, 129 )
    else
        exports.GTIhud:dm("A unknown issue has occured while converting the video. Please contact a developer. (#"..tostring(errno)..")",playerToReceive,255,0,0)
    end
end








--veh stuffs
addEvent( "GTImusicApp.sendmusic", true)
addEventHandler( "GTImusicApp.sendmusic", root, function(thePlayer,urli,names)
triggerClientEvent(thePlayer,"GTImusicApp.recievesong",resourceRoot,urli,names)
end)
