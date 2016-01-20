----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: storeRob_s.lua
-- Version: 1.0
----------------------------------------->>

local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25

local bags = {}

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
		name = getPlayerName ( client )
        exports.GTIcriminals:givePlayerTaskMoney(client, "Store Robbery", pay)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 1175, "Store Robbery")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Store Robbery", 1)
        if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
    end
)

addEvent ("GTIstoreRob_moneyBag", true )
addEventHandler ("GTIstoreRob_moneyBag", root, 
    function ( )
        bags[client] = createObject ( 1550, 2168.279, 1099.348, 0, -90, 0, 0, true )
        setElementDoubleSided ( bags[client], true )
        exports.bone_attach:attachElementToBone(bags[client],client,2,0,-0.25,-0.2,20,0,0)
    end
)

addEvent ("GTIstoreRob_payOutForCashRegister", true )
addEventHandler ("GTIstoreRob_payOutForCashRegister", root,
    function ( player )
        moneyfor = math.random ( 300, 600 )
        exports.GTIcriminals:givePlayerTaskMoney(client, "Store Robbery", moneyfor)
    end
)

local isPlayerNotAllowedToRob = {}

addEvent ("GTIstoreRob_WantedLevel", true )
addEventHandler ("GTIstoreRob_WantedLevel", root,
    function ( )
       exports.GTIpoliceWanted:chargePlayer ( client, 24 )
        local serial = getPlayerSerial(client)
        isPlayerNotAllowedToRob[serial] = true
        setTimer(function(serial)
        isPlayerNotAllowedToRob[serial] = false
        end, 360000, 1, serial)
    end
)

function onArrestCancelTheRob()
    triggerClientEvent ( source, "GTIstoreRob_CancelOnArrest", source )
end
addEventHandler ("onPlayerArrested", root, onArrestCancelTheRob)
addEventHandler ("onPlayerJailed", root, onArrestCancelTheRob)

addEvent ("GTIstoreRob_stopMission", true )
addEventHandler ("GTIstoreRob_stopMission", root,
    function()
        if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
    end
)

function onPlayerQuit ( )
    if ( bags[source] and isElement ( bags[source] ) ) then
        destroyElement (bags[source] )
        bags [source] = nil
    end
end
addEventHandler ("onPlayerQuit",root,onPlayerQuit )
