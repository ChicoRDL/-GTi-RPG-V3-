----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: 24-7shops_s.lua
-- Version: 1.0
----------------------------------------->>

addEvent ("GTI24/7_ShopgiveWeaponToPlayer", true )
addEventHandler ("GTI24/7_ShopgiveWeaponToPlayer", getRootElement ( ),
function(id, cost, name, ammo)
    if ( getPlayerMoney ( client ) >= tonumber ( cost ) ) then
		exports.GTIbank:TPM(client, tonumber ( cost ), "24/7 Shop "..name)
		exports.GTIhud:dm("You Bought a " ..name.. " for $"..cost, client, 0, 200, 0)
        giveWeapon ( client, tonumber ( id ), 1 )
    else
        exports.GTIhud:dm("You don't have enough money", client, 200, 0, 0)
    end
end
)