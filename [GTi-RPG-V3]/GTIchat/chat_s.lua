----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Development Ministry
-- Resource: GTIchat/chat_s.lua
-- Type: Server Side
----------------------------------------->>

local antiTick  = {}    -- Stops Players from Chatting too often
local spam = {}         -- Storage of last message by player

    -- List of Alternate Names to avoid highlights
no_highlight = {
    ["JTPenn"] = "J.T.P.e.n.n",
    ["Jack"] = "J.ack",
    ["EnemyCRO"] = "Enem.y",
    ["Ares"] = "Ar3s",
    ["JayXxX"] = "JayX.Killer",
    ["rock_roll"] = "rocknroll",
    ["Rudixx"] = "Rud.ixx",
    ["dotcom"] = "dotnet",
    ["GHoST|RedBand"] = "GHoST|BandRed",
    ["Massive"] = "Massiv3",
	["IceBoy"] = "FireGirl",
}

    -- List of Team Chats that don't appear on IRC
blockIRC = {
    ["Government"] = true,
}

    -- List of Language Chat Commands
local lang_chats = {"ar", "nl", "tr", "tn", "pt", "es", "ey", "fr"}

local TIME_BTWN_CHATS = 2000    -- How ofter a player can chat (ms)
local RP_DISTANCE = 30          -- Roleplay Chat Distance (meters)
local LOCAL_DISTANCE = 100      -- Local Chat Distance (meters)

-- Can Player Chat?
-------------------->>

function canPlayerChat(player, global_mute, ignore_spam)
    if (not exports.GTIutil:isPlayerLoggedIn(player)) then return false end

    local tick = getTickCount()
    if (not ignore_spam and antiTick[player] and getTickCount() - antiTick[player] < TIME_BTWN_CHATS) then
        outputChatBox("You need to wait "..(TIME_BTWN_CHATS/1000).." second"..((TIME_BTWN_CHATS/1000) == 1 and "" or "s").." between each message", player, 255, 0, 0)
        return false
    end

    if (not global_mute and exports.GTIgovt:isPlayerMuted(player)) then
        outputChatBox("* ERROR: You are muted.", player, 255, 25, 25)
        return false
    end

    if (global_mute and exports.GTIgovt:isPlayerMuted(player, true)) then
        outputChatBox("* ERROR: You are globally muted.", player, 255, 25, 25)
        return false
    end

    return true
end

-- Main Chat
------------->>

function mainChat(message, mType)
    if (mType == 0) then
        cancelEvent()
        if (not canPlayerChat(source)) then return end

        local message = formatMessage(message)
        if (not message) then return end
        recordMessage(source, message)

        local city = exports.GTIchat:getPlayerCity(source)
        if not city then
            outputChatBox("You cannot talk where you are currently located.", source, 255, 0, 0)
            return
        end

        local newMessage = "("..city..") "..getPlayerName(source).. ": #FFFFFF"..message

        if (getResourceFromName("GTIirc") and getResourceState(getResourceFromName("GTIirc")) == "running") then
            exports.GTIirc:outputIRC("07("..city..") "..(no_highlight[getPlayerName(source)] or getPlayerName(source)).."1: "..message)
        end

        exports.GTIlogs:outputServerLog("("..city..") "..getPlayerName(source).. ": "..message, "chat", source)

        local cr, cg, cb = getPlayerNametagColor(source)
        for i, v in ipairs (getElementsByType("player")) do
            if (not exports.GTIcontactsApp:isPlayerBlocked(v, source)) then
                if getElementData(v,"GTIchat.markedMAIN") then
                    outputChatBox(newMessage, v, cr, cg, cb, true)
                end
                outputGridlist(v, v, "Main", newMessage)
            end
        end
    end
end
addEventHandler("onPlayerChat", root, mainChat)

-- Roleplay Chats
------------------>>

addEventHandler("onPlayerChat", root,
    function(msg, type)
        if type == 1 then
            cancelEvent()
            rpChat(source, msg, "me")
        end
    end
)

function rpChat(source, message, mType, ignore_spam)
    if (not canPlayerChat(source, true, ignore_spam)) then return end

    local message = formatMessage(message)
    if (not message) then return end
    recordMessage(source, message)

    local posX, posY, posZ = getElementPosition(source)
    local recipients = {}
    for index, player2 in ipairs(getElementsByType("player")) do
        local posX2, posY2, posZ2 = getElementPosition(player2)
        if (getDistanceBetweenPoints3D(posX, posY, posZ, posX2, posY2, posZ2) <= RP_DISTANCE and not exports.GTIcontactsApp:isPlayerBlocked(player2, source)) then
            table.insert(recipients, player2)
        end
    end

    for index, player2 in ipairs(recipients) do
        if mType == "me" then
            outputChatBox("["..(#recipients-1).."] * "..getPlayerName(source).." "..message, player2, 255, 0, 255, false)
        elseif mType == "do" then
            outputChatBox("["..(#recipients-1).."] * "..message.." ("..getPlayerName(source)..")", player2, 175, 215, 255, false)
        end
    end

    if mType == "me" then
        exports.GTIlogs:outputServerLog("ME: ["..(#recipients-1).."] * "..getPlayerName(source).." "..message, "local_chat", source)
    elseif mType == "do" then
        exports.GTIlogs:outputServerLog("DO: ["..(#recipients-1).."] * "..message.." ("..getPlayerName(source)..")", "local_chat", source)
    end
end

addCommandHandler("do", function(player, cmd, ...)
    rpChat(player, table.concat({...}, " "), "do")
end)

-- Team Chat
------------->>

function teamChat(message, mType)
    if (mType == 2) then
        cancelEvent()
        if (not canPlayerChat(source)) then return end

        local message = formatMessage(message)
        if (not message) then return end
        recordMessage(source, message)

        if (getPlayerTeam(source)) then
            local sourceTeam = getPlayerTeam(source)
            for index,player in ipairs(getElementsByType("player")) do
                local playerTeam = getPlayerTeam(player)
                if (playerTeam and playerTeam == sourceTeam) then
                    local r, g, b = getTeamColor(sourceTeam)
                    local teamName = getTeamName(sourceTeam)
                    local newMessage = "(TEAM) "..getPlayerName(source)..": #FFFFFF"..message
                    if (not exports.GTIcontactsApp:isPlayerBlocked(player, source)) then
                        if getElementData(player,"GTIchat.markedTEAM") then
                            outputChatBox(newMessage, player,  r or 255, g or 255, b or 255, true)
                        end
                        outputGridlist(player, player, "Team", newMessage)
                    end
                elseif (getTeamName(getPlayerTeam(player)) == "Government") then
                    local r, g, b = getTeamColor(sourceTeam)
                    local teamName = getTeamName(sourceTeam)
                    local newMessage = "(TEAM) "..getPlayerName(source)..": #FFFFFF"..message
                    outputGridlist(player, player, "Team", "("..teamName..") "..newMessage)
                end    
            end
            local teamName = getTeamName(sourceTeam)
           --[[ if (getResourceFromName("GTIirc") and getResourceState(getResourceFromName("GTIirc")) == "running") then
                if not blockIRC[teamName] then
                    exports.GTIirc:outputIRC("07 ("..teamName..") "..getPlayerName(source)..": "..message)
                end
            end]]--- http://gtirpg.net/showthread.php?tid=6113
            exports.GTIlogs:outputServerLog("TEAM: ("..teamName..") "..getPlayerName(source)..": "..message, "chat", source)
        end
    end
end
addEventHandler("onPlayerChat", root, teamChat)

-- Local Chat
-------------->>

function localChat(player, _, ...)
    if (not canPlayerChat(player, true)) then return end

    local message = formatMessage(table.concat({...}, " "))
    if (not message) then return end
    recordMessage(player, message)

    local posX, posY, posZ = getElementPosition(player)
    local dim = getElementDimension(player)
    local recipients = {}
    for index, player2 in ipairs(getElementsByType("player")) do
        local posX2, posY2, posZ2 = getElementPosition(player2)
        local dim2 = getElementDimension(player2)
        if (getDistanceBetweenPoints3D(posX, posY, posZ, posX2, posY2, posZ2) <= LOCAL_DISTANCE and not exports.GTIcontactsApp:isPlayerBlocked(player2, player)) then
            if dim == dim2 then
                table.insert(recipients, player2)
            end
        end
    end

        -- Redirect to RP Chats -->>
    if string.find(message, "/me", 1, true) and type(string.find(message, "./me")) ~= "number" then
        local message1 = string.gsub(message, "/me ", "")
        if message1 ~= "" then
            rpChat(player, message1, "me", true)
            return
        end
    elseif string.find(message, "/do", 1, true) and type(string.find(message, "./do")) ~= "number" then
        local message1 = string.gsub(message, "/do ", "")
        if message1 ~= "" then
            rpChat(player, message1, "do", true)
            return
        end
    end

    for index, player2 in pairs(recipients) do
        local r, g, b = getPlayerNametagColor(player)
        local name = getPlayerName(player2)
        if getElementData(player2,"GTIchat.markedLOCAL") then
            outputChatBox("(Local)["..(#recipients-1).."] "..getPlayerName(player)..": #FFFFFF"..message, player2, r or 255, g or 255, b or 255, true)
        end
        local newMessage = "(Local)["..(#recipients-1).."] "..getPlayerName(player)..": "..message
        outputGridlist(player2, player2, "Local", newMessage)
    end
    triggerEvent("onPlayerLocalChat", player, message, recipients)
        -- Output Server Log
    exports.GTIlogs:outputServerLog("(Local)["..(#recipients-1).."] "..getPlayerName(player)..": "..message, "local_chat", player)
end
addCommandHandler("local", localChat)

function bindLocalChat()
    bindKey(source, "u", "down", "chatbox", "local")
end
addEventHandler("onPlayerJoin", root, bindLocalChat)

function bindLocalChatForAll()
    for index, player in pairs(getElementsByType("player")) do
        bindKey(player, "u", "down", "chatbox", "local")
    end
end
addEventHandler("onResourceStart", resourceRoot, bindLocalChatForAll)

function addBubble(message, recipients, show)
    if show then
        if show ~= false then
            for index, player in pairs(recipients) do
                if (not exports.GTIcontactsApp:isPlayerBlocked(player, source)) then
                    triggerClientEvent(player, "GTIsocial.addBubble", source, message)
                end
            end
        end
    else
        for index, player in pairs(recipients) do
            if (not exports.GTIcontactsApp:isPlayerBlocked(player, source)) then
                triggerClientEvent(player, "GTIsocial.addBubble", source, message)
            end
        end
    end
end
addEvent("onPlayerLocalChat")
addEventHandler("onPlayerLocalChat", root, addBubble)

-- Personal Message
-------------------->>

function pmCommand(player)
    outputChatBox("This command has been disabled. Use GTIdroid instead.", player, 0, 107, 143)
end
addCommandHandler("pm", pmCommand)

-- Note Chat
------------->>

function noteChat(player, command, ...)
    if (not canPlayerChat(player)) then return end

    local message = formatMessage(table.concat({...}, " "))
    if (not message) then return end
    recordMessage(player, message)

    local noteNick = getPlayerName(player)
    outputChatBox("> (NOTE) "..noteNick..": #FFFFFF"..message, root, 255, 0, 0, true)
    exports.GTIlogs:outputServerLog("NOTE: "..noteNick..": "..message, "chat", player)
    if (getResourceFromName("GTIirc") and getResourceState(getResourceFromName("GTIirc")) == "running") then
        exports.GTIirc:outputIRC("* (4NOTE) "..(no_highlight[noteNick] or noteNick)..": "..message)
    end
end
addCommandHandler("note", noteChat, true)

-- Event Chat
-------------->>

function eventChat(player, command, ...)
    if (not canPlayerChat(player)) then return end

    local message = formatMessage(table.concat({...}, " "))
    if (not message) then return end
    recordMessage(player, message)

    eventNick = getPlayerName(player)

    outputChatBox("> (EVENT) "..eventNick..": #FFFFFF"..message, root, 0, 110, 145, true)
    exports.GTIlogs:outputServerLog("EVENT: "..eventNick..": "..message, "chat", player)
    if (getResourceFromName("GTIirc") and getResourceState(getResourceFromName("GTIirc")) == "running") then
        exports.GTIirc:outputIRC("* (2EVENT) "..(no_highlight[eventNick] or eventNick)..": "..message)
    end
end
addCommandHandler("eventnote", eventChat, true)

-- Car Chat
------------>>

function carChat(player, cmd, ...)
    if (not isPedInVehicle(player)) then return end
    if (not canPlayerChat(player, true)) then return end

    local message = formatMessage(table.concat({...}, " "))
    if (not message) then return end
    recordMessage(player, message)

    local vehicle = getPedOccupiedVehicle(player)
    for i,plr in pairs(getVehicleOccupants(vehicle)) do
        outputChatBox("> (CAR) "..getPlayerName(player)..": #FFFFFF"..message, plr, 255, 25, 125, true)
    end
    exports.GTIlogs:outputServerLog("CAR CHAT: "..getPlayerName(player)..": "..message, "local_chat", player)
end
addCommandHandler("cc", carChat)

-- Adverts Chat
------------------>>

function advertChat(player, cmdName, ...)
    if (not canPlayerChat(player)) then return end

    local message = formatMessage(table.concat({...}, " "))
    if (not message) then return end
    recordMessage(player, message)

    plrName = getPlayerName(player)
    for i,v in ipairs(getElementsByType("player")) do
        local acc = getPlayerAccount(v)
        local theNewMessage = "(Adverts) "..plrName..": "..message
        if (not exports.GTIcontactsApp:isPlayerBlocked(v, player)) then
            if getElementData(v,"GTIchat.markedADVERTS") then
                outputChatBox("#FF7800(Adverts) "..plrName..": #FFFFFF"..message, v, 255, 255, 255, true)
            end
            outputGridlist(v, v, "Adverts", theNewMessage)
        end
    end
    exports.GTIlogs:outputServerLog("(Adverts) "..plrName..": "..message, "adverts_chat", player)
end
addCommandHandler("advert", advertChat)

-- Language Chats
------------------>>

function languageChat(player, cmdName, ...)
    if (not canPlayerChat(player)) then return end

    local message = formatMessage(table.concat({...}, " "))
    if (not message) then return end
    recordMessage(player, message)

    cmdName = string.upper(cmdName)

    if ( not getElementData(player, "GTIchat.marked"..cmdName:upper()) ) then
    triggerClientEvent(player, "GTIchat.setChatEnabled", player, cmdName, true)
    end

    plrName = getPlayerName(player)
    for i,v in ipairs(getElementsByType("player")) do
        local acc = getPlayerAccount(v)
        local theNewMessage = "("..cmdName..") "..plrName..": "..message
        if (not exports.GTIcontactsApp:isPlayerBlocked(v, player)) then
            if getElementData(v,"GTIchat.marked"..string.upper(cmdName)) then
                outputChatBox("#E0FFFF("..cmdName..") "..plrName..": #FFFFFF"..message, v, 255, 255, 255, true)
            end
            outputGridlist(v, v, string.upper(cmdName), theNewMessage)
        end
    end
    exports.GTIlogs:outputServerLog("("..cmdName..") "..plrName..": "..message, "lang_chat", player)
end

    -- Bind Commands on Start
for _,cmd in ipairs(lang_chats) do
    addCommandHandler(cmd, languageChat)
end

-- Support Chat
---------------->>

function supportChat(player, cmd, ...)
    if (not canPlayerChat(player)) then return end

    local message = formatMessage(table.concat({...}, " "))
    if (not message) then return end
    recordMessage(player, message)

    local playerName = getPlayerName(player)
    local newMessage = "(Support) "..getPlayerName(player)..": #FFFFFF"..message
    for i,v in pairs(getElementsByType("player")) do
        if (not exports.GTIcontactsApp:isPlayerBlocked(v, player)) then
            local account = getPlayerAccount(v)
            if getElementData(v,"GTIchat.markedSUPPORT") then
                outputChatBox(newMessage, v, 200, 0, 0, true)
            end

            if exports.GTIutil:isPlayerInACLGroup(player, "Dev1", "Dev2", "Dev3", "Dev4", "Dev5", "Admin1", "Admin2", "Admin3", "Admin4", "Admin5", "QCA1", "QCA4", "QCA5") then
                outputGridlist(v, v, "Support", newMessage, true)
            else
                outputGridlist(v, v, "Support", newMessage)
            end
        end
    end

    if (getResourceFromName("GTIirc") and getResourceState(getResourceFromName("GTIirc")) == "running") then
        exports.GTIirc:outputIRC("07(Support) "..(no_highlight[playerName] or playerName).."1: "..message)
    end

    exports.GTIlogs:outputServerLog("(Support) "..playerName..": "..message, "support_chat", player)
end
addCommandHandler("support", supportChat)

-- Miscellaneous
----------------->>

function onChat (chat, msg)
    if not (chat == "Joinquit") then
        if (chat == "Main") then
            mainChat(msg, 0)
        elseif (chat == "Team") then
            teamChat(msg, 2)
        elseif (chat == "Support") then
            supportChat(client, "", msg)
        elseif (chat == "Local") then
            localChat(client, "", msg)
        elseif (chat == "Group") then
            if (exports.GTIgroups:isPlayerInGroup(client)) and getElementData(client,"GTIchat.markedGROUP") then
            local gID = exports.GTIgroups:getPlayerGroup(client)
                exports.GTIgroups:outputGroupChat("(GROUP) "..getPlayerName(client)..": #FFFFFF"..msg, gID)
                for i, v in pairs(getElementsByType("player")) do
                    local id2 = exports.GTIgroups:getPlayerGroup(v)
                    if (id2 == gID) then
                        triggerClientEvent(v, "GTIchat.addChatRow", v, chat, "(GROUP) "..getPlayerName(client)..": "..msg)
                    end
                end    
            end
    elseif ( chat == "Adverts") then
        advertChat(client, "", msg)
        else
            languageChat(client, chat, msg)
        end
    end
end
addEvent("GTIchat.onChat", true)
addEventHandler("GTIchat.onChat", root, onChat)

-- Format Message
------------------>>

function formatMessage(message)
    if (not message) then return false end
    repeat message = message:gsub("#%x%x%x%x%x%x", "") until not message:find("#%x%x%x%x%x%x")
    if (message:gsub("%s","") == "") then return false end
    if (message == "") then return false end
    return message
end

function recordMessage(player, message)
    antiTick[player] = getTickCount()
    spam[player] = message
    return true
end

-- Utilities
------------->>

function outputGridlist(player1, player2, chatName, message, govt)
    if ( isElement( player1 ) and isElement ( player2 ) and type ( chatName ) == "string" and type( message ) == "string" ) then
            triggerClientEvent(player1, "GTIchat.addChatRow", player2, chatName, message, govt and "yes" or false)
    end
end

-- Disable /showchat when not logged in
---------------------------------------->>

function disableShowChat(command)
    if (command ~= "showchat") then return end
    if (exports.GTIutil:isPlayerLoggedIn(source)) then return end
    cancelEvent()
end
addEventHandler("onPlayerCommand", root, disableShowChat)
