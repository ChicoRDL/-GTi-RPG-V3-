function initCarLocks ()
	local players = getElementsByType ( "player" )
	for k,p in ipairs(players) do
		removeElementData ( p, "isPlayerOwnedVehicle" )
		bindKey ( p, "l", "down", ToggleLocked )
	end
	
	local vehicles = getElementsByType ( "vehicle" )
	for k,v in ipairs(vehicles) do
		removeElementData ( v, "isVehicleOwner" )
		removeElementData ( v, "isVehicleLocked" )
		setVehicleLocked ( v, false )
	end
	
end
addEventHandler ( "onResourceStart", resourceRoot, initCarLocks )
addEventHandler ( "onResourceStop", resourceRoot, initCarLocks )

function onPlayerEnterVehicle ( player, seat, jacked )
	if ( seat == 0 ) then
		oldVehicle = getElementData ( player, "isPlayerOwnedVehicle" )
		if ( (isVehicleLocked(source) == true) and (isVehicleOwner(source) ~= player) ) then
			removePedFromVehicle( player )
			exports.GTIhud:dm("This vehicle is locked.",source,150,0,0)
			return false
		end
		
		--Check the vehicle to see if he's the actual owner of the vehicle before setting it.
		if (getElementData(source,"owner") == tostring(getPlayerName(player))) then
			SetVehicleOwner ( source, player )
		end
	end
end
addEventHandler ( "onVehicleEnter", getRootElement(), onPlayerEnterVehicle )

function SetVehicleOwner ( theVehicle, thePlayer )
	local oldVehicle = getElementData ( thePlayer, "isPlayerOwnedVehicle" )
	--First, check if a vehicle actually exists before we proceed. (Debug spam)
	
	if not (theVehicle) or (isElement(theVehicle)) then
		return
	end
	
	if (getElementType(oldVehicle) ~= "vehicle") then return end
	
	if ( oldVehicle ~= false ) then
		removeElementData ( oldVehicle, "isVehicleOwner" )
		removeElementData ( oldVehicle, "isVehicleLocked" )
		setVehicleLocked ( oldVehicle, false ) 
	end
	setElementData ( theVehicle, "isVehicleOwner", thePlayer )
	setElementData ( theVehicle, "isVehicleLocked", false )
	setElementData ( thePlayer, "isPlayerOwnedVehicle", theVehicle )
end
function onPlayerQuit ( )
	local ownedVehicle = getElementData ( source, "isPlayerOwnedVehicle" )
	if (ownedVehicle ~= false) then
		RemoveVehicleOwner ( ownedVehicle )
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), onPlayerQuit )

function onPlayerWasted ( )
	local ownedVehicle = getElementData ( source, "isPlayerOwnedVehicle" )
	if (ownedVehicle ~= false) then
		RemoveVehicleOwner ( ownedVehicle )
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), onPlayerWasted )

function RemoveVehicleOwner ( theVehicle )
	local theOwner = getElementData ( theVehicle, "isVehicleOwner" )
	if ( theOwner ~= false ) then
		removeElementData ( theOwner, "isPlayerOwnedVehicle" )
		removeElementData ( theVehicle, "isVehicleOwner" )
		removeElementData ( theVehicle, "isVehicleLocked" )
	end
	setVehicleLocked ( theVehicle, false )

end

function isVehicleOwner ( theVehicle )
	return getElementData( theVehicle, "isVehicleOwner" )
end

function isVehicleLocked ( theVehicle )
	return getElementData( theVehicle, "isVehicleLocked" )
end

function ToggleLocked ( source )
	local theVehicle
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "isPlayerOwnedVehicle" )
	end

	if ( theVehicle ) then
		local vehiclename = getVehicleName ( theVehicle )
		if ( getElementData ( theVehicle, "isVehicleLocked") == true ) then
			doUnlockVehicle ( source )
		else 
			doLockVehicle ( source )
		end
	end
end	

function doLockVehicle ( source )
	local theVehicle
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "isPlayerOwnedVehicle" )
	end
	if ( theVehicle ) then
		local vehiclename = getVehicleName ( theVehicle )
		if ( getElementData ( theVehicle, "isVehicleLocked") == true ) then
			exports.GTIhud:dm("Your " .. vehiclename .. " is already locked.",source,240,221,14)
		else 
			setElementData ( theVehicle, "isVehicleLocked", true)
			setVehicleLocked ( theVehicle, true ) 
			exports.GTIhud:dm("Your " .. vehiclename .. " has been locked.",source,150,0,0)
		end
	end
end
addCommandHandler ( "lock", doLockVehicle )

function doUnlockVehicle ( source )
	local theVehicle
	if ( getElementType(source) == "vehicle" ) then
		theVehicle = source
	end
	if ( getElementType(source) == "player" ) then
		theVehicle = getElementData ( source, "isPlayerOwnedVehicle" )
	end
	if ( theVehicle ) then
	local vehiclename = getVehicleName ( theVehicle )
		if ( getElementData ( theVehicle, "isVehicleLocked") == false ) then
			exports.GTIhud:dm("Your " .. vehiclename .. " is already unlocked.",source,240,221,14)
		else
			setElementData ( theVehicle, "isVehicleLocked", false)
			setVehicleLocked ( theVehicle, false )
            exports.GTIhud:dm("Your " .. vehiclename .. " has been unlocked.",source,44,218,36)
		end
	end
end
addCommandHandler ( "unlock", doUnlockVehicle )
