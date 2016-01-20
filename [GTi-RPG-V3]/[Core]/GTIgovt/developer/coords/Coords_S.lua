----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 07 Jan 2014
-- Resource: GTIdevTools/coords.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

function showCoordsGUI(player)
	local account = getPlayerAccount(player)
	if (isGuestAccount(account)) then return end
	local account = getAccountName(account)
	if (not hasObjectPermissionTo(player, "command.debugscript")) then return end
	triggerClientEvent(player, "GTIdevTools.showCoordsGUI", player)
end
addCommandHandler("coords", showCoordsGUI)