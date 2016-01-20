function enabledSnow(player)
	if exports.GTIutil:isPlayerLoggedIn(player) then
		local data = exports.GTIaccounts:GAD(getPlayerAccount(player), "GTIsnow.enabled") or false
		exports.GTIaccounts:SAD(getPlayerAccount(player), "GTIsnow.enabled", not data)
			if exports.GTIaccounts:GAD(getPlayerAccount(player), "GTIsnow.enabled") then
				triggerClientEvent(player,"GTIsnow.addSnow",resourceRoot,true)
			else
				triggerClientEvent(player,"GTIsnow.addSnow",resourceRoot,true)
			end
	end
end
addCommandHandler("snow",enabledSnow)


function onPlayerLoginPutTheSnow()
	if exports.GTIaccounts:GAD(getPlayerAccount(source),"GTIsnow.enabled") then
		triggerClientEvent(source,"GTIsnow.addSnow",resourceRoot)
	end
end
addEventHandler("onPlayerLogin",root,onPlayerLoginPutTheSnow)
