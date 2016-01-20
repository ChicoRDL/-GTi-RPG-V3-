----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: hospitalHP_s.lua
-- Version: 1.0
----------------------------------------->>
local Timer = {}

addEvent ("GTIarmor.armor", true )
addEventHandler ("GTIarmor.armor", root,
	function ( player)
	    local armorth = math.floor( getPedArmor ( client ) )
	    local price = 2500 - ( armorth * 25 )
	    local armorthToBuy = math.floor ( 100 - armorth )

		if ( Timer[getAccountName(getPlayerAccount(client))] ) then
			exports.GTIhud:dm("You can only buy armor every 90 seconds", client, 255, 0, 0)
			return
		end
		
	    if ( armorth >= 100 ) then 
		exports.GTIhud:dm ( "You already have full armor", client, 200, 0, 0 ) 
		return 
	    end
		
	    if ( getPlayerMoney ( client ) <= price-1 ) then 
		exports.GTIhud:dm ( "You don't have enough money to buy this!", client, 200, 0, 0 ) 
		return 
	    end

		
	    setPedArmor ( client, 100 )
		Timer[getAccountName(getPlayerAccount(client))] = true
		local AccountName = getAccountName(getPlayerAccount(client))
		setTimer(function(accname) Timer[accname] = false end, 90000, 1, AccountName)
		
	    exports.GTIbank:TPM ( client, price, "Hospital HP: Bought " .. armorthToBuy .. "Armor" )
	    exports.GTIhud:drawNote ( "Armor", "+ "..armorthToBuy.." Armor", client, 0, 255, 0, 7500 )
	    exports.GTIhud:drawNote ( "money-", "- $"..exports.GTIutil:tocomma(price), client, 200, 0, 0, 7500 )
    end
)