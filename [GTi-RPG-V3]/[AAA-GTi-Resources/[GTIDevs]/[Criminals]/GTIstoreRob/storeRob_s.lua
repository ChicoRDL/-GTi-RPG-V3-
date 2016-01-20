----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: storeRob_s.lua
-- Version: 1.0
----------------------------------------->>

local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25

addEvent ("GTIstoreRob_setPedAnim", true )
addEventHandler ("GTIstoreRob_setPedAnim", root, 
    function ( )
        exports.GTIanims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
    end
)

addEvent ("GTIstoreRob_payoutForSafe", true )
addEventHandler ("GTIstoreRob_payoutForSafe", root,
    function ( )
	    pay = math.random(3925*LOWER_BOUND, 3925*UPPER_BOUND)
        exports.GTIcriminals:givePlayerTaskMoney(client, "Store Robbery", pay)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 1175, "Store Robbery")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Store Robbery", 1)
	end
)

addEvent ("GTIstoreRob_payOutForCashRegister", true )
addEventHandler ("GTIstoreRob_payOutForCashRegister", root,
    function ( player )
	    moneyfor = math.random ( 300, 600 )
		exports.GTIcriminals:givePlayerTaskMoney(client, "Store Robbery", moneyfor)
	end
)

addEvent ("GTIstoreRob_WantedLevel", true )
addEventHandler ("GTIstoreRob_WantedLevel", root,
    function ( )
	    exports.GTIpoliceWanted:chargePlayer ( client, 24 )
	end
)

function onArrestCancelTheRob()
    triggerClientEvent ( source, "GTIstoreRob_CancelOnArrest", source )
end
addEventHandler ("onPlayerArrested", root, onArrestCancelTheRob)
