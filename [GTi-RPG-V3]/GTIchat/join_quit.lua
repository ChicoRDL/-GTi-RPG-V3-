----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 03 Jun 2014
-- Resource: GTIchat/join_quit.slua
-- Version: 1.0
----------------------------------------->>

function removeHex()
    local name_ = getPlayerName(source)
    local name = string.gsub(name_, "#%x%x%x%x%x%x", "")
    if (name ~= name_) then
        setPlayerName(source, name)
        outputChatBox("* Hex Color in names are not allowed.", source, 255, 25, 25)
    end
end
addEventHandler("onPlayerJoin", root, removeHex)

function removeHexOnChange(_, newnick)
    local name = string.gsub(newnick, "#%x%x%x%x%x%x", "")
    if (name ~= newnick) then
        cancelEvent()
        setPlayerName(source, name)
        outputChatBox("* Hex Color in names are not allowed.", source, 255, 25, 25)
    end
end
addEventHandler("onPlayerChangeNick", root, removeHexOnChange)

-- Announce Join
----------------->>

addEventHandler("onPlayerLogin", root, function()
    outputConsole("* "..getPlayerName(source).." is now online [Logged in]")
    exports.killmessages:outputMessage( "* "..getPlayerName(source).." is now online [Logged in]", root, 255, 100, 100)
    exports.GTIirc:outputIRC("* "..(no_highlight[getPlayerName(source)] or getPlayerName(source)).." is now online [Logged In]")
    outputGridlist(root, root, "Join/Quit", "* "..getPlayerName(source).." is now online [Logged in]")
end)

addEventHandler("onPlayerQuit", root, function(reason)
    outputConsole("* "..getPlayerName(source).." is now offline ["..reason.."]")
    exports.killmessages:outputMessage( "* "..getPlayerName(source).." is now offline ["..reason.."]", root, 255, 100, 100)
    exports.GTIirc:outputIRC("* "..(no_highlight[getPlayerName(source)] or getPlayerName(source)).." is now offline ["..reason.."]")
    outputGridlist(root, root, "Join/Quit", "* "..getPlayerName(source).." is now offline ["..reason.."]")
end)

addEventHandler("onPlayerChangeNick", root, function(oldNick, newNick)
    if (string.find(oldNick, "#%x%x%x%x%x%x") or string.find(newNick, "#%x%x%x%x%x%x")) then return end

    if (exports.GTIgovt:isPlayerMuted(source)) then
        outputChatBox("You cannot change your name while muted.", source, 255, 125, 25)
        cancelEvent()
        return
    end
    outputConsole("* "..oldNick.." is now known as "..newNick)
    exports.killmessages:outputMessage( "* "..oldNick.." is now known as "..newNick, root, 255, 100, 100)
    exports.GTIirc:outputIRC("* "..oldNick.." is now known as "..newNick)
    outputGridlist(root, root, "Join/Quit", "* "..oldNick.." is now known as "..newNick)
end)
