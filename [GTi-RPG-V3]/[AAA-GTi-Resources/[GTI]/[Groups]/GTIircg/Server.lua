--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz and Emile ~
-- Resource: GTIircg/Server.lua ~
-- Description: <Desc> ~
-- Data: #IRCgroups
--<--------------------------------->--
antiTick  = {}
data = {}

function onPlayerChat (player, _, ...)
    local tick = getTickCount()
    if (antiTick[player] and tick - antiTick[player] < 2000) then return end
    antiTick[player] = getTickCount()
    local msg = table.concat({...}," ")
    if ( exports.GTIgroups:isPlayerInGroup(player) ) then
        local playerGroup = exports.GTIgroups:getPlayerGroup(player, false)
        if ( msg and msg ~= "" ) then
            local ch = getChannelFromGroupID(playerGroup)
            if ch then
                local channel = exports.GTIirc:ircGetChannelFromName(ch)
                if channel then
                    exports.GTIirc:ircSay(channel, "07(GROUP) "..formatNick(getPlayerName(player)).."1: "..msg)
                end
            end
        end
    end
end
addCommandHandler("gc", onPlayerChat)

function onChat (chat,...)
    if (chat == "Group") then
        local player = client
        local tick = getTickCount()
        if (antiTick[player] and tick - antiTick[player] < 2000) then return end
        antiTick[player] = getTickCount()
        local msg = table.concat({...}," ")
        if ( exports.GTIgroups:isPlayerInGroup(player) ) then
            local playerGroup = exports.GTIgroups:getPlayerGroup(player, false)
            if ( msg and msg ~= "" ) then
                local ch = getChannelFromGroupID(playerGroup)
                if ch then
                    local channel = exports.GTIirc:ircGetChannelFromName(ch)
                    if channel then
                        exports.GTIirc:ircSay(channel, "07(GROUP) "..formatNick(getPlayerName(player)).."1: "..msg)
                    end
                end
            end
        end
    end
end
addEvent("GTIchat.onChat", true)
addEventHandler("GTIchat.onChat", root, onChat)

function group_chat(server,channel,user,command,...)
    local tick = getTickCount()
    if (antiTick[user] and tick - antiTick[user] < 2000) then return end
    antiTick[user] = getTickCount()
    local msg = table.concat({...}," ")
    if not msg or msg == "" then exports.GTIirc:ircNotice(user,"syntax is !gc <message>") return end
    local ch = exports.GTIirc:ircGetChannelName(channel)
    local gID = getGroupIDFromChannel(ch)
    if gID then
        local r, g, b = exports.GTIgroups:getGroupColor(gID)
        local hColor = exports.GTIutil:RGBToHex(r, g, b)
        local userName = exports.GTIirc:ircGetUserNick(user)
        exports.GTIgroups:outputGroupChat("#FF8000[IRC] "..hColor.."(GROUP) "..userName..": #FFFFFF"..msg, gID)
        exports.GTIirc:ircSay(channel, "07[IRC] (GROUP) "..formatNick(userName).."1: "..msg)
        chatpanel(gID,"[IRC] (GROUP) "..userName..": "..msg)
    end
end

function group_xp(server,channel,user,command)
    local tick = getTickCount()
    if (antiTick[user] and tick - antiTick[user] < 10000) then return end
    antiTick[user] = getTickCount()
    local ch = exports.GTIirc:ircGetChannelName(channel)
    local gID = getGroupIDFromChannel(ch)
    if gID then
        local xp = exports.GTIgroups:getGroupExperience( gID)
        local f_xp = exports.GTIutil:tocomma( xp)

        if xp and f_xp then
            exports.GTIirc:ircSay( channel, "07[IRC] (GROUP) ".."Your group currently has "..f_xp.." Experience Points.")
        end
    end
end

function formatNick(nick)
    local middle = math.ceil(#nick/2)
    local part1 = string.sub(nick,0,middle)
    local part2 = string.sub(nick,middle+2)
    return part1.."*"..part2.."q"
end

function getOnlineMembers(gID)
    local members = exports.GTIgroups:getGroupMembers(gID)
    data[gID] = ""
    count = 0
    for i,v in ipairs(members) do
        local acc = getAccount(v)
        local plr = getAccountPlayer(acc)
        if plr then
            count = count + 1
            if #data[gID] == 0 then
                data[gID] = getPlayerName(plr)
            else
                data[gID] = data[gID]..", "..getPlayerName(plr)
            end
        end
    end
    return count,data[gID]
end

function group_online(server,channel,user,command)
    local tick = getTickCount()
    if (antiTick[user] and tick - antiTick[user] < 10000) then return end
    antiTick[user] = getTickCount()
    local ch = exports.GTIirc:ircGetChannelName(channel)
    local gID = getGroupIDFromChannel(ch)
    if gID then
        local count,plrs = getOnlineMembers(gID)
        exports.GTIirc:ircSay(channel, "07Total members online1: "..count)
        if count > 0 then
            exports.GTIirc:ircNotice(user,"Members online: "..plrs)
        end
    end
end

function chatpanel(gID,msg)
    local members = exports.GTIgroups:getGroupMembers(gID)
    for i,account in ipairs(members) do
        local acc = getAccount(account)
        local v = getAccountPlayer(acc)
        if isElement(v) then
            triggerClientEvent(v, "GTIchat.addChatRow", v, "Group", msg)
        end
    end
end

function outputGroupChannel(id,text1,text2)
    local ch = getChannelFromGroupID(id)
    if ch then
          local channel = exports.GTIirc:ircGetChannelFromName(ch)
          if channel then
              exports.GTIirc:ircSay(channel, "07 "..text1.."1: "..text2)
        end
    end
end

addEventHandler("onResourceStart",root,
    function(res)
        if ( res == getThisResource() or res == getResourceFromName("GTIirc") ) then
            if (not getResourceFromName("GTIirc") or getResourceState(getResourceFromName("GTIirc")) ~= "running") then return end
                    exports.GTIirc:addIRCCommandHandler("!gc",'group_chat',1,false)
                    exports.GTIirc:addIRCCommandHandler("!members",'group_online',1,false)
                exports.GTIirc:addIRCCommandHandler("!xp",'group_xp',1,false)
                    for i,v in pairs(eTable) do
                        exports.GTIirc:ircRaw( exports.LilDolla:getIRCServer(), "JOIN "..i)
                    end
            end
    end
)

function leaveChannels ()
    for i,v in pairs(eTable) do
        exports.GTIirc:ircRaw( exports.LilDolla:getIRCServer(), "PART "..i)
    end
end
addEventHandler("onResourceStop", resourceRoot, leaveChannels)
