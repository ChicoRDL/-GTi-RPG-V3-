----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: atmRob_s.lua
-- Version: 1.2
----------------------------------------->>

local LOWER_BOUND = 0.75	-- Lowest Pay Deviation
local UPPER_BOUND = 1.25	-- Highest Pay Deviation

local ROB_PAY = 3667		-- Money Earned for ATM Robbery

local isPlayerNotAllowedToRob = {}
local bags = {}
addEvent ("GTIatmRob_payOutTNT", true )
addEventHandler ("GTIatmRob_payOutTNT", root,
    function ( )
        tntPay = math.random(ROB_PAY*LOWER_BOUND, ROB_PAY*UPPER_BOUND)
        exports.GTIcriminals:givePlayerTaskMoney(client, "ATM Robbery", tntPay)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 915, "ATM Robbery")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "ATM Robbery", 1)
        if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
        local serial = getPlayerSerial(client)
        isPlayerNotAllowedToRob[serial] = true
        setTimer(function(serial)
        isPlayerNotAllowedToRob[serial] = nil
        end, 180000, 1, serial)
    end
)

addEvent ("GTIatmRob_stopMissionS", true )
addEventHandler ("GTIatmRob_stopMissionS", root, function()
if isElement ( bags[client] ) then destroyElement ( bags[client] ) end
end )
addEvent ("GTIatmRob.WantedLevel", true )
addEventHandler ("GTIatmRob.WantedLevel", root,
    function ()
        exports.GTIpoliceWanted:chargePlayer ( client, 24 )
    end
)

function onArrestCancelTheRob()
    triggerClientEvent ( source, "GTIatmRob_onArrest", source )
end
addEventHandler ("onPlayerArrested", root, onArrestCancelTheRob)

addEvent ("GTIatmRob_moneyBag", true )
addEventHandler ("GTIatmRob_moneyBag", root, 
    function ( )
        bags[client] = createObject ( 1550, 2168.279, 1099.348, 0, -90, 0, 0, true )
        setElementDoubleSided ( bags[client], true )
        --exports.bone_attach:attachElementToBone(bags[client],client,8,0,-0.2,0.1,0,180,180)
        exports.bone_attach:attachElementToBone(bags[client],client,2,0,-0.25,-0.2,20,0,0)--spine bone seems to be bugged
    end
)

addEvent ("GTIatmRob_anim", true )
addEventHandler ("GTIatmRob_anim", root, 
    function ( )
        exports.GTIanims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
    end
)

addEventHandler( "onPlayerCommand", root,
    function ( cmd )
        if cmd == "kill" then
            triggerClientEvent (source,"GTIatmRob_onClientKillCmd", source )
        end
    end
)

--[[addEvent ("GTIatmRob_destroy", true )
addEventHandler ("GTIatmRob_destroy", root,
    function ( player )
        if (exports.bone_attach:isElementAttachedToBone(moneyBag)) then
            destroyElement ( moneyBag )
        end
    end
)--]]


function saveTimetoAcc(ms)
    local account = getPlayerAccount(client)
    if (not isGuestAccount(account)) then
        exports.GTIaccounts:SAD(account, "GTIatmRob.timeLeft", ms)
    end    
end
addEvent("GTIatmRob.saveWaitTime", true)
addEventHandler("GTIatmRob.saveWaitTime", root, saveTimetoAcc)


function getTimeLeft()
	local serial = getPlayerSerial(source)
    local ms = isPlayerNotAllowedToRob[serial]
    if (not ms) or (ms == nil) then return end
    triggerClientEvent(source,"GTIatmRob.setTimer", resourceRoot, ms)
end
addEventHandler("onPlayerLogin", root, getTimeLeft)

function onPlayerQuit()
	if (bags[source] and isElement(bags[source])) then
		destroyElement(bags[source])
		bags[source] = nil
	end
end
addEventHandler("onPlayerQuit",root,onPlayerQuit)