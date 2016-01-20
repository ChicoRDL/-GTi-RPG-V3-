local crouch
local timer
local weapons = {
	[ 24 ] = 570
}

function clientResourceStart( )
	crouch = isControlEnabled( "crouch" )
end
addEventHandler( "onClientResourceStart", resourceRoot, clientResourceStart )

function clientResourceStop( )
	toggleCrouch( crouch )
end
addEventHandler( "onClientResourceStop", resourceRoot, clientResourceStop )

function clientPlayerWasted( )
	toggleCrouch( crouch )
end
addEventHandler( "onClientPlayerWasted", localPlayer, clientPlayerWasted )

function clientPlayerWeaponFire( weapon )
	toggleCrouch( false )
	timer = setTimer( toggleCrouch, weapons[ weapon ] or 80, 1, crouch )
end
addEventHandler( "onClientPlayerWeaponFire", localPlayer, clientPlayerWeaponFire )

function toggleCrouch( switch )
	if ( isTimer( timer ) ) then
		killTimer( timer )
	end
	timer = nil
	toggleControl( "crouch", switch )
end