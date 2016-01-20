--------------------------------------------------------------------------------------------------
-- Script name:		Turn signals (server)
-- Developer:		MrBrutus
-- Project type: 	Open source (code.albonius.com)
-- Last edit:		2014-07-22
--------------------------------------------------------------------------------------------------

-- Global data and pointers
toggler				= { }
dtype				= { }
syncTimer 			= { }
currHeadLightColor 	= {{ }}

function isVehicleBlinking( vehicle)
	if currHeadLightColor[vehicle] then
		return true
	else
		return false
	end
end

-- Toggling lights
function toggleLights( veh )
	if isElement( veh ) then
		setVehicleOverrideLights( veh, 2 )
		if toggler[veh] == 1 then
			setVehicleLightState( veh, 0, 1 )
			setVehicleLightState( veh, 1, 1 )
			setVehicleLightState( veh, 2, 1 )
			setVehicleLightState( veh, 3, 1 )
			if veh and isElement(veh) and (getElementType(veh) == "vehicle") and getVehicleTowedByVehicle( veh ) then
				local veh2 = getVehicleTowedByVehicle( veh )
				setVehicleLightState( veh2, 0, 1 )
				setVehicleLightState( veh2, 1, 1 )
				setVehicleLightState( veh2, 2, 1 )
				setVehicleLightState( veh2, 3, 1 )
			end
			toggler[veh] = 0
		else
			if dtype[veh] == "lleft" then
				setVehicleLightState( veh, 0, 0 )
				setVehicleLightState( veh, 1, 1 )
				setVehicleLightState( veh, 2, 1 )
				setVehicleLightState( veh, 3, 0 )
				if veh and isElement(veh) and (getElementType(veh) == "vehicle") and getVehicleTowedByVehicle( veh ) then
					local veh2 = getVehicleTowedByVehicle( veh )
					setVehicleLightState( veh2, 0, 0 )
					setVehicleLightState( veh2, 1, 1 )
					setVehicleLightState( veh2, 2, 1 )
					setVehicleLightState( veh2, 3, 0 )
				end
			elseif dtype[veh] == "lright" then
				setVehicleLightState( veh, 0, 1 )
				setVehicleLightState( veh, 1, 0 )
				setVehicleLightState( veh, 2, 0 )
				setVehicleLightState( veh, 3, 1 )
				if (getElementType(veh) == "vehicle") and getVehicleTowedByVehicle( veh ) then
					local veh2 = getVehicleTowedByVehicle( veh )
					setVehicleLightState( veh2, 0, 1 )
					setVehicleLightState( veh2, 1, 0 )
					setVehicleLightState( veh2, 2, 0 )
					setVehicleLightState( veh2, 3, 1 )
				end
			elseif (getElementType(veh) == "vehicle") and dtype[veh] == "warn" then
				setVehicleLightState( veh, 0, 0 )
				setVehicleLightState( veh, 1, 0 )
				setVehicleLightState( veh, 2, 0 )
				setVehicleLightState( veh, 3, 0 )
				if veh and isElement(veh) and (getElementType(veh) == "vehicle") and getVehicleTowedByVehicle( veh ) then
					local veh2 = getVehicleTowedByVehicle( veh )
					setVehicleLightState( veh2, 0, 0 )
					setVehicleLightState( veh2, 1, 0 )
					setVehicleLightState( veh2, 2, 0 )
					setVehicleLightState( veh2, 3, 0 )
				end
			end
			toggler[veh] = 1
		end
	end
end

-- Left
function lightHandler( player, cmd )
	if player and isElement( player ) and getPedOccupiedVehicle( player ) then
		local veh = getPedOccupiedVehicle( player )
		if ( not isTimer( syncTimer[veh] ) or cmd ~= dtype[veh] ) and getVehicleOccupants(veh)[0] == player then
			-- Save the current head light color
			setVehicleLightState( veh, 0, 1 )
			setVehicleLightState( veh, 1, 1 )
			setVehicleLightState( veh, 2, 1 )
			setVehicleLightState( veh, 3, 1 )
			if veh and isElement(veh) and (getElementType(veh) == "vehicle") and getVehicleTowedByVehicle( veh ) then
				local veh2 = getVehicleTowedByVehicle( veh )
				setVehicleLightState( veh2, 0, 1 )
				setVehicleLightState( veh2, 1, 1 )
				setVehicleLightState( veh2, 2, 1 )
				setVehicleLightState( veh2, 3, 1 )
			end
			if not currHeadLightColor[veh] then
				currHeadLightColor[veh] = { }
				currHeadLightColor[veh][1],currHeadLightColor[veh][2],currHeadLightColor[veh][3] = getVehicleHeadLightColor( veh )
			end

			-- Set the new headlight color to yellow
			setVehicleHeadLightColor( veh, 255, 200, 0 )

			-- Start the syn timer
			if isTimer( syncTimer[veh] ) then
				killTimer( syncTimer[veh] )
				setVehicleHeadLightColor(veh, currHeadLightColor[veh][1],currHeadLightColor[veh][2],currHeadLightColor[veh][3])
			end
			syncTimer[veh] = setTimer( toggleLights, 380, 0, veh )
			toggler[veh] = 1
			dtype[veh] = cmd
			toggleLights( veh )
		else
			if isTimer( syncTimer[veh] ) then
				killTimer( syncTimer[veh] )
				local vehID = getElementData( veh, "vehicleID")
				if vehID then
					local vehID = tonumber( vehID)
					local colorTable = exports.GTIvehicles:getVehicleData( vehID, "light_color") or "255,255,255"
					local cData = split( colorTable, ",")
					--setVehicleHeadLightColor( veh, currHeadLightColor[veh][1],currHeadLightColor[veh][2],currHeadLightColor[veh][3] )
					setVehicleHeadLightColor( veh, cData[1], cData[2], cData[3])
					currHeadLightColor[veh] = nil
				else
					setVehicleHeadLightColor( veh, 255, 255, 255)
				end
			end
			setVehicleLightState( veh, 0, 0 )
			setVehicleLightState( veh, 1, 0 )
			setVehicleLightState( veh, 2, 0 )
			setVehicleLightState( veh, 3, 0 )
			setVehicleOverrideLights( veh, 2 )
			if veh and isElement(veh) and (getElementType(veh) == "vehicle") and getVehicleTowedByVehicle( veh ) then
				local veh2 = getVehicleTowedByVehicle( veh )
				setVehicleLightState( veh2, 0, 0 )
				setVehicleLightState( veh2, 1, 0 )
				setVehicleLightState( veh2, 2, 0 )
				setVehicleLightState( veh2, 3, 0 )
				setVehicleOverrideLights( veh2, 2 )
			end
		end
	end
end
addCommandHandler( "lleft", lightHandler )
addCommandHandler( "lright", lightHandler )
addCommandHandler( "warn", lightHandler )

--------------------------------------------------------------------------------------------------
-- Tested by:		AC RPG 2.0
-- Written in:		Web Developer Studio 2013 / A.corp Notepad II (store.albonius.com)
-- Copyright: (C) 	MrBrutus @ Acorp 2014
--------------------------------------------------------------------------------------------------
