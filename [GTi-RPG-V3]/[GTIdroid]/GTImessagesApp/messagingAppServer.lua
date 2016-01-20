addEvent("GTIMessagingApp.sendmsg", true) 
addEventHandler("GTIMessagingApp.sendmsg", root, function(message,target) 
	if not isElement(target) then return end
	
	if (exports.GTIgovt:isPlayerMuted(client, true)) then
		outputChatBox("* ERROR: You are globally muted.", client, 255, 25, 25)
		return
	end
		
	if not (exports.GTIutil:isPlayerLoggedIn(target)) then
		outputChatBox("* ERROR: This player is not logged in.", client, 255, 25, 25)
		return
	end
	local name = getPlayerName(target)
	local pName = getPlayerName(client)
    if (exports.GTIcontactsApp:isPlayerBlocked(client, target)) then
        outputChatBox("> Error: Failed to send message. You have "..name.." blocked.", client, 255, 0, 0)
        return
    end
    if (exports.GTIcontactsApp:isPlayerBlocked(target, client)) then
        outputChatBox("> Error: Failed to send message. "..name.." has you blocked.", client, 255, 0, 0)
        return
    end
    exports.GTIlogs:outputLog("> SMS: "..pName.." to "..name..": "..message, "sms")
    exports.GTIlogs:outputAccountLog("PM From "..pName..": "..message, "sms", target)
    exports.GTIlogs:outputAccountLog("PM To "..name..": "..message, "sms", client)
	
	triggerClientEvent(target,"GTIMessagingApp.recievemsg",resourceRoot,message,client)
end )