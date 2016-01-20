addEvent ("onClientInteriorEnter", true )
addEvent ("onClientInteriorExit", true )

ghostMode = false

function event ( )
    cancelEvent ( )
end

function setPlayerSpawnProtectionOn ( player )
    if ( player == localPlayer and ghostMode == false ) then
	    triggerServerEvent ("MitchMiscGhostOn", localPlayer )
		setTimer ( setPlayerSpawnProtectionOff, 3000, 1 )
		addEventHandler ("onClientPlayerDamage", localPlayer, event 
		toggleControl  ( "fire", false )
		ghostMode = true
	end
end
addEventHandler ("onClientInteriorEnter", root, setPlayerSpawnProtectionOn )
addEventHandler ("onClientInteriorExit", root, setPlayerSpawnProtectionOn )

function setPlayerSpawnProtectionOff ( )
    triggerServerEvent ("MitchMiscGhostOff", localPlayer )
	removeEventHandler ("onClientPlayerDamage", localPlayer, event )
	toggleControl  ( "fire", true )
	ghostMode = false
end