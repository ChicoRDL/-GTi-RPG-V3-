function table.empty( a )
    if type( a ) ~= "table" then
        return false
    end

    return not next( a )
end

function sendRequest(player)
    if not isElement(player) then return end
    local acc = getPlayerAccount(client)
    local accname = getAccountName(acc)
    local friendacc = getPlayerAccount(player)
    if getAccStatus(friendacc,acc) == "Friend" or getAccStatus(friendacc,acc) == "Blocked" then
        local plrname = getPlayerName(player)
        triggerClientEvent(client, "GTIcontactsApp.cancelRequest", resourceRoot, plrname)
    return end
    local name = getPlayerName(client)
    triggerClientEvent(player, "GTIcontactsApp.recieveRequest", resourceRoot, name, accname)
    exports.GTIhud:dm("Friendship request successfully sent!",client,0,255,0)
end
addEvent ( "GTIcontactsApp.sendRequest", true )
addEventHandler ( "GTIcontactsApp.sendRequest", root, sendRequest )

function acceptRequest(friendaccname)
    local acc = getPlayerAccount(client)
    local friendacc = getAccount(friendaccname)
    local friend = getAccountPlayer(friendacc)
    if getAccStatus(acc,friendacc) == "Friend" then return end
    local accname = getAccountName(acc)
    addFriend(accname,friendaccname)
    local name = getPlayerName(client)
    if isElement(friend) then
        exports.GTIhud:dm(name.." accepted your friendship request!",friend,0,255,0)
    end
end
addEvent ( "GTIcontactsApp.acceptRequest", true )
addEventHandler ( "GTIcontactsApp.acceptRequest", root, acceptRequest )

function friendchat(player,cmd,...)
    if (not exports.GTIutil:isPlayerLoggedIn(player)) then return end
    if (exports.GTIgovt:isPlayerMuted(player, true)) then
        outputChatBox("* ERROR: You are globally muted.", player, 255, 25, 25)
        return
    end
    local message = table.concat({...}, " ")
    repeat message = message:gsub("#%x%x%x%x%x%x", "") until not message:find("#%x%x%x%x%x%x")
    if (message == "") then return end
    local friends = getOnlineFriends(player)
    if table.empty(friends) then return end
    for i,v in pairs(friends) do
        outputChatBox("(FCHAT) "..getPlayerName(player)..": #FFFFFF"..message, v, 255, 158, 125, true)
    end
    outputChatBox("(FCHAT) "..getPlayerName(player)..": #FFFFFF"..message, player, 255, 158, 125, true)
    exports.GTIlogs:outputAccountLog("(FCHAT) "..getPlayerName(player)..": "..message,"FCHAT",player)
    exports.GTIlogs:outputLog("(FCHAT) "..getPlayerName(player)..": "..message, "FCHAT", player)
end
addCommandHandler("fchat",friendchat)

addCommandHandler("fmsg",function(plr)
    outputChatBox("Use /fchat instead.",plr,255,0,0)
end)
addEventHandler("onPlayerChangeNick",root,function(old,new)
    local account = getPlayerAccount(source)
    exports.GTIaccounts:invSet(account, "GTIcontactsApp.nick", new)
end
)
function nickData()
    local account = getPlayerAccount(source)
    local nick = getPlayerName(source)
    exports.GTIaccounts:invSet(account, "GTIcontactsApp.nick", nick)
end
addEventHandler("onPlayerJoin",root,nickData)
addEventHandler("onPlayerQuit",root,nickData)

addEventHandler("onResourceStart",resourceRoot,function()
    for i,v in pairs(getElementsByType("player")) do
        local account = getPlayerAccount(v)
        local nick = getPlayerName(v)
        exports.GTIaccounts:invSet(account, "GTIcontactsApp.nick", nick)
    end
end)
