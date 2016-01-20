----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: houserob_s.lua
-- Version: 1.0
----------------------------------------->>

local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25

addEvent ("onInteriorExit", true )

function houseLeave ( plr )
    --local job = exports.GTIemployment:getPlayerJob(plr, true)
    if ( exports.AresMisc:isAbleToCrime ( plr ) ) then
		for i,veh in ipairs ( getElementsByType ("vehicle") ) do
			local owner = exports.GTIvehicles:getVehicleOwner ( veh )
			if ( owner == plr ) and ( getElementModel(veh) == 482 ) then
				triggerClientEvent (owner, "GTIhouseRob.boxvilleMarker", resourceRoot, veh )
				setVehicleDoorOpenRatio ( veh, 4, 1, 2500 )
				setVehicleDoorOpenRatio ( veh, 5, 1, 2500 )
				setElementFrozen(veh,true)
			end
		end     
	end
end
addEventHandler ("onInteriorExit", root, houseLeave )

function payPlayer ( plr )
    local money = math.random(4050*LOWER_BOUND, 4050*UPPER_BOUND)
	exports.GTIcriminals:givePlayerTaskMoney(client, "House Robbery", money)
	exports.GTIcriminals:modifyPlayerCriminalRep(client, 1000, "House Robbery")
	exports.GTIcriminals:modifyPlayerTaskProgress(client, "House Robbery", 1)
end
addEvent ("GTIhouseRob.payThePlayer", true )
addEventHandler ("GTIhouseRob.payThePlayer", root, payPlayer )

addEvent ("GTIhouseRob.WantedLevel", true )
addEventHandler ("GTIhouseRob.WantedLevel", root,
    function ( )
        exports.GTIpoliceWanted:chargePlayer ( client, 25 )
    end
)

addEvent ("GTIhouseRob_Anim", true )
addEventHandler ("GTIhouseRob_Anim", root,
    function ( )
	    exports.GTIanims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, false)
		exports.GTIanims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, true )
	end
)

addEventHandler( "onPlayerCommand", root,
    function( cmd )
        if cmd == "hide" then
            --local job = exports.GTIemployment:getPlayerJob(source, true)
            if ( exports.AresMisc:isAbleToCrime ( source ) ) then
                triggerClientEvent(source, "GTIhouseRob.cancelRob", resourceRoot)
            end
        end
    end    
)

function onArrestCancelTheRob()
    triggerClientEvent(source, "GTIhouseRob.cancelRob", resourceRoot)
end
addEventHandler("onPlayerArrested", root, onArrestCancelTheRob)

addEvent ("GTIhouseRob.unfreeze", true )
addEventHandler ("GTIhouseRob.unfreeze", root,
    function()
    for i,veh in ipairs ( getElementsByType ("vehicle") ) do
        local owner = exports.GTIvehicles:getVehicleOwner ( veh )
        if ( owner == client ) and ( getElementModel(veh) == 482 ) then
			setElementFrozen(veh,false)
			setVehicleDoorOpenRatio ( veh, 4, 0, 2500 )
			setVehicleDoorOpenRatio ( veh, 5, 0, 2500 )
        end
    end     
end
)