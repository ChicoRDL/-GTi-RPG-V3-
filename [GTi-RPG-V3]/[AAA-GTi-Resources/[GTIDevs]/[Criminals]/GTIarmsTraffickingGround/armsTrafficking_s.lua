----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: armsTrafficking_s.lua
-- Version: 1.0
----------------------------------------->>

local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25

addEvent ("GTIarmsTrafficking_wantedLevel", true )
addEventHandler ("GTIarmsTrafficking_wantedLevel", root,
    function ( )
	    exports.GTIpoliceWanted:chargePlayer(client, 29)
	end
)

addEvent ("GTIarmsTrafficking_payOut", true )
addEventHandler ("GTIarmsTrafficking_payOut", root,
    function ( )
	    local money = math.random(3650*LOWER_BOUND, 3650*UPPER_BOUND)
	    exports.GTIcriminals:givePlayerTaskMoney(client, "Arms Trafficking", money)
	    exports.GTIcriminals:modifyPlayerCriminalRep(client, 750, "Arms Trafficking")
	    exports.GTIcriminals:modifyPlayerTaskProgress(client, "Arms Trafficking", 1)
	end
)


addEventHandler( "onPlayerCommand", root,
    function( cmd )
        if cmd == "hide" then
            --local job = exports.GTIemployment:getPlayerJob(source, true)
            if (exports.AresMisc:isAbleToCrime ( source )) then
                triggerClientEvent(source, "GTIarmsTrafficking.onVehicleHide", source)
            end
        end
    end    
)
