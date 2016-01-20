----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 4-10-2015
-- Resource: medkit_s.lua
-- Version: 1.0
----------------------------------------->>

function buyMedKit ( am )
    local cost = tonumber ( am ) * 750
    if ( getPlayerMoney ( client ) < cost ) then return end
    exports.GTIbank:TPM ( client, cost, "Bought Medic kits" )
    local cur = getPlayerMedKits ( client )
    setPlayerMedKits ( client, cur + tonumber( am ) )
    triggerClientEvent ( client, "playerBoughtMedKitReturn", client, cur + tonumber ( am ) )
end
addEvent ("playerBoughtMedKit", true )
addEventHandler ("playerBoughtMedKit", root, buyMedKit )

function getPlayerMedKits ( player )
    local acc = getPlayerAccount ( player )
    local medKits = tonumber ( exports.GTIaccounts:GAD ( acc, "medKits" ) ) or 0
    return medKits
end

function setPlayerMedKits ( player, amount )
    local acc = getPlayerAccount ( player )
    exports.GTIaccounts:SAD ( acc, "medKits", tostring ( amount ) )
    triggerClientEvent ( player, "onMedKitLoad", player, amount )
    return true
end

function loadMedKits ( irrelevant, account)
    triggerClientEvent ( source, "onMedKitLoad", source, getPlayerMedKits ( source ) )
end
addEventHandler ("onPlayerLogin", root, loadMedKits )

function useMedKit( bool )
    if ( bool ) then return end
	if exports.GTIdamage:isPlayerInCombat ( client ) then return exports.GTIhud:dm("You can't take a medic kit while in combat", client, 255, 0, 0 ) end
	if isPedDead ( client ) then return end
    local cur = getPlayerMedKits( client )
	exports.GTIstats:modifyStatData ( getPlayerAccount ( client ), "med_kits_used", 1 )
    setPlayerMedKits ( client, cur - 1 )
end
addEvent("playerUsedMedKit", true)
addEventHandler("playerUsedMedKit", root, useMedKit)

addEvent ("GTImedKit_Anim", true )
addEventHandler ("GTImedKit_Anim", root,
    function ( )
	    exports.GTIanims:setJobAnimation ( client, "VENDING", "VEND_Drink_P", 2000, false, false, false, false )
	end
)