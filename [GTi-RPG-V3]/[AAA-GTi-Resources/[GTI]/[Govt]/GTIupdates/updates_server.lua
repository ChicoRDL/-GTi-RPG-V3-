addCommandHandler("updates",
function(player)
	if (player) and (isElement(player)) then
		if isGuestAccount(getPlayerAccount(player)) then return end
		
		triggerClientEvent(player,"GTIupdates:showUpdatesPanel",player)
	end
end)