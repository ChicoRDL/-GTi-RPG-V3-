----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

function setStuntsAmount ( money )
	exports.GTIbank:GPM ( client, money, "Stunts payment")
	exports.GTIhud:drawNote("GTIstunts_payOutNotee", "+ $"..money, client, 0, 255, 0, 7500)
	--local groupID = exports.GTIgroups:getPlayerGroup(client)
	setPlayerStunts ( client, getPlayerStunts ( client ) + 1 ) 
	exports.GTIstats:modifyStatData ( getPlayerAccount ( client ), "stunt_jumps_completed", 1 )
	--if not groupID then return end
	--exports.GTIhud:drawNote("GTIstunts_payOutNote", "+ XPG "..money, client, 0, 255, 0, 7500)
	--exports.GTIgroups:modifyGroupExperience(groupID, money)
end
addEvent ("GTIstunts_addStuntCompleted", true )
addEventHandler ("GTIstunts_addStuntCompleted", root, setStuntsAmount )

addEvent ("GTIstunts_resetHealth", true )
addEventHandler ("GTIstunts_resetHealth", root,
	function ( )
		veh = getPedOccupiedVehicle ( client )
		if not veh then return end
		setElementHealth ( veh, 1000 )
	end
)

function getPlayerStunts ( player )
    local acc = getPlayerAccount ( player )
    local stunts = tonumber ( exports.GTIaccounts:GAD ( acc, "stunts" ) ) or 1
    return stunts
end

function setPlayerStunts ( player, amount )
    local acc = getPlayerAccount ( player )
    exports.GTIaccounts:SAD ( acc, "stunts", tostring ( amount ) )
    triggerClientEvent ( player, "GTIstunts_LoadStunts", player, amount )
    return true
end

function loadStats ( irrelevant, account )
    triggerClientEvent ( source, "GTIstunts_LoadStunts", source, getPlayerStunts ( source ) )
end
addEventHandler ("onPlayerLogin", root, loadStats )
