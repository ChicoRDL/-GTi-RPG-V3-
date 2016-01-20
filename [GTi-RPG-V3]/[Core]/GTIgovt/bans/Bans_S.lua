----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 18 Sept 2014
-- Resource: GTIadmin/bans.slua
-- Version: 1.0
----------------------------------------->>

-- Compose Ban List
-------------------->>

addEvent("GTIgovtPanel.getBans", true)
addEventHandler("GTIgovtPanel.getBans", root, function()
	local bans = getBans()
	triggerClientEvent(client, "GTIgovtPanel.composeBanList", resourceRoot, bans)
end)

addEvent("GTIgovtPanel.removeBan", true)
addEventHandler("GTIgovtPanel.removeBan", root, function(ip, serial, account)
	exports.GTIgovt:removeBan(ip, serial, account, true)
	if ( account ) then
		exports.GTIlogs:outputAdminLog("BAN: Account ban removed on account "..account.." by "..getPlayerName(client), client)
		outputChatBox("BAN: You have removed a ban in the account "..account.." .", client)
	end
	if ( serial ) then
		exports.GTIlogs:outputAdminLog("BAN: Serial ban removed on serial "..serial.." by "..getPlayerName(client), client)
		outputChatBox("BAN: You have removed a ban on serial "..serial.." .", client)
	end
	if ( ip ) then
		exports.GTIlogs:outputAdminLog("BAN: IP ban removed on IP "..ip.." by "..getPlayerName(client), client)
		outputChatBox("BAN: You have removed a ban on IP "..ip.." .", client)
	end
	local bans = getBans()
	triggerClientEvent(client, "GTIgovtPanel.composeBanList", resourceRoot, bans)
end)
