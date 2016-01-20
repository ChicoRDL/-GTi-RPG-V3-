----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: bankHeist_s.lua
-- Version: 1.0
----------------------------------------->>

local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25

local bags = {}
local isPlayerNotAllowedToRob = {}

addEvent ("GTIBankHeist_PayOutATM", true )
addEventHandler ("GTIBankHeist_PayOutATM", root,
    function ( )
	    pay = math.random(1125*LOWER_BOUND, 1125*UPPER_BOUND)
		exports.GTIcriminals:givePlayerTaskMoney(client, "Bank Heist", pay)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 215, "Bank Heist")
	end
)

addEvent ("GTIBankHeist_PayOutMoneyBag", true )
addEventHandler ("GTIBankHeist_PayOutMoneyBag", root,
    function ( )
	    pay = math.random(5125*LOWER_BOUND, 5125*UPPER_BOUND)
	    exports.GTIcriminals:givePlayerTaskMoney(client, "Bank Heist", pay)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 1175, "Bank Heist")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Bank Heist", 1)
		local serial = getPlayerSerial(client)
        isPlayerNotAllowedToRob[serial] = true
        setTimer(function(serial)
        isPlayerNotAllowedToRob[serial] = nil
        end, 600000, 1, serial)
		if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
	end
)

addEvent ("GTIBankheist_WantedLevel", true )
addEventHandler ("GTIBankheist_WantedLevel", root,
    function ( )
	    exports.GTIpoliceWanted:chargePlayer(client, 23)
	end
)

addEvent ("GTIBankHeist_anim", true )
addEventHandler ("GTIBankHeist_anim", root, 
    function ( )
        exports.GTIanims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
    end
)

addEvent ("GTIBankHeist_moneyBag", true )
addEventHandler ("GTIBankHeist_moneyBag", root, 
    function ( )
        bags[client] = createObject ( 1550, 2168.279, 1099.348, 0, -90, 0, 0, true )
        setElementDoubleSided ( bags[client], true )
		setElementDimension ( bags[client], getElementDimension ( client ) )
		setElementInterior ( bags[client], getElementInterior ( client ) )
        exports.bone_attach:attachElementToBone(bags[client],client,2,0,-0.25,-0.2,20,0,0)
    end
)

addEvent ("GTIBankHeist_stopMission", true )
addEventHandler ("GTIBankHeist_stopMission", root, function()
if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
end )

function onArrestCancelTheRob()
    triggerClientEvent ( source, "GTIBankHeist_onArrest", source )
	if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
end
addEventHandler ("onPlayerArrested", root, onArrestCancelTheRob)

function saveTimetoAcc(ms)
    local account = getPlayerAccount(client)
    if (not isGuestAccount(account)) then
        exports.GTIaccounts:SAD(account, "GTIatmRob.timeLeft", ms)
    end    
end
addEvent("GTIBankHeist.saveWaitTime", true)
addEventHandler("GTIBankHeist.saveWaitTime", root, saveTimetoAcc)


function getTimeLeft()
	local serial = getPlayerSerial(source)
    local ms = isPlayerNotAllowedToRob[serial]
    if (not ms) or (ms == nil) then return end
    triggerClientEvent(source,"GTIBankHeist.setTimer", resourceRoot, ms)
end
addEventHandler("onPlayerLogin", root, getTimeLeft)

createBlip(603.144, -1257.392, 63.188, 16, 2, 255, 255, 255, 255, 0, 300, root)
