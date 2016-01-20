----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: hospitalHP_s.lua
-- Version: 1.0
----------------------------------------->>
local Timer = {}

addEvent ("GTIhospitalHP.heal", true )
addEventHandler ("GTIhospitalHP.heal", root,
	function ( player)
	    local health = math.floor( getElementHealth ( client ) )
	    local price = 2000 - ( health * 20 )
	    local healthToBuy = math.floor ( 100 - health )

		if ( Timer[getAccountName(getPlayerAccount(client))] ) then
			exports.GTIhud:dm("You can only buy health every 90 seconds", client, 255, 0, 0)
			return
		end
		
	    if ( health >= 100 ) then 
		exports.GTIhud:dm ( "You already have full health", client, 200, 0, 0 ) 
		return 
	    end

	    if ( exports.GTIpoliceWanted:getPlayerWantedLevel ( client ) >= 20 ) then 
		exports.GTIhud:dm ( "You need less than 20WP in order to use this!", client, 200, 0, 0 ) 
		return 
	    end

	    if ( getPlayerMoney ( client ) <= price ) then 
		exports.GTIhud:dm ( "You don't have enough money to buy this!", client, 200, 0, 0 ) 
		return 
	    end
		
		Timer[getAccountName(getPlayerAccount(client))] = true
		local AccountName = getAccountName(getPlayerAccount(client))
		setTimer(function(accname) Timer[accname] = false end, 90000, 1, AccountName)
		
	    setElementHealth ( client, 100 )
	    exports.GTIbank:TPM ( client, price, "Hospital HP: Bought " .. healthToBuy .. "HP" )
	    exports.GTIhud:drawNote ( "HP", "+ "..healthToBuy.." HP", client, 0, 255, 0, 7500 )
	    exports.GTIhud:drawNote ( "money-", "- $"..exports.GTIutil:tocomma(price), client, 200, 0, 0, 7500 )
    end
)

addEventHandler( "onPlayerCommand", root,
    function ( cmd )
        if cmd == "kill" then
	        triggerClientEvent (source, "GTIhospitalHP_cancel", source, source )
	    end
    end
)
