----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: drugFactory_s.lua
-- Version: 1.0
----------------------------------------->>

local isPlayerNotAllowedToRob = {}

addEvent ("GTIdrugFactory_cocaine", true )
addEventHandler ("GTIdrugFactory_cocaine", root,
    function ( )
	    exports.GTIdrugs:givePlayerDrug(client, "Cocaine", 10)
	    exports.GTIdrugs:givePlayerDrug(client, "Ecstasy", 10)
	    exports.GTIdrugs:givePlayerDrug(client, "Oxycodone", 10)
	    exports.GTIdrugs:givePlayerDrug(client, "Marijuana", 15)
	    exports.GTIdrugs:givePlayerDrug(client, "Tylenol", 15)
		exports.GTIdrugs:givePlayerDrug(client, "Meth", 10)
		exports.GTIhud:drawNote ("GTIdrugFactory_AmountCocaine1", "+ 10 Cocaine", client, 255, 255, 255, 7500 )
		exports.GTIhud:drawNote ("GTIdrugFactory_AmountCocaine2", "+ 10 Ecstasy", client, 200, 0, 0, 7500 )
		exports.GTIhud:drawNote ("GTIdrugFactory_AmountCocaine3", "+ 10 Oxycodone", client, 237, 252, 23, 7500 )
		exports.GTIhud:drawNote ("GTIdrugFactory_AmountCocaine4", "+ 15 Marijuana", client, 11, 89, 1, 7500 )
		exports.GTIhud:drawNote ("GTIdrugFactory_AmountCocaine5", "+ 15 Tylenol", client, 0, 184, 255, 7500 )
		exports.GTIhud:drawNote ("GTIdrugFactory_AmountCocaine6", "+ 10 Meth", client, 100, 0, 0, 7500 )
		local serial = getPlayerSerial(client)
        isPlayerNotAllowedToRob[serial] = true
        setTimer(function(serial)
        isPlayerNotAllowedToRob[serial] = nil
        end, 3600000, 1, serial)
	end
)


function saveTimetoAcc(ms)
    local account = getPlayerAccount(client)
    if (not isGuestAccount(account)) then
        exports.GTIaccounts:SAD(account, "GTIdrugFactory.timeLeft", ms)
    end    
end
addEvent("GTIdrugFactory.saveWaitTime", true)
addEventHandler("GTIdrugFactory.saveWaitTime", root, saveTimetoAcc)


function getTimeLeft()
	local serial = getPlayerSerial(source)
    local ms = isPlayerNotAllowedToRob[serial]
    if (not ms) or (ms == nil) then return end
    triggerClientEvent(source,"GTIdrugFactory.setTimer", resourceRoot, ms)
end
addEventHandler("onPlayerLogin", root, getTimeLeft)