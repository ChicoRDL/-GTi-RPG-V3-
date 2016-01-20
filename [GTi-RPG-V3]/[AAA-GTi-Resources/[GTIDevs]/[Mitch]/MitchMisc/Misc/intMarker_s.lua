--[[outsideMarker = createMarker (-49.809, -269.364, 7.833, "arrow", 2, 200, 0, 0, 150 )
markerInside = createMarker ( 222.798, 229.659, 1672.069, "arrow", 1.5, 200, 0, 0, 150 )
drugFactoryBlip = createBlip ( -50.117, -273.774, 4.632, 24, 2, 255, 0, 0, 255, 0, 500, getRootElement() )
copEnter = createMarker ( -50.520, -233.661, 7.765, "arrow", 2, 0, 0, 200, 150 )
copEnterInt = createMarker ( 220.716, 216.735, 1688.469, "arrow", 1.5, 0, 0, 200, 150 )
setElementDimension ( markerInside, 20000 )
setElementInterior ( markerInside, 1 )
setElementDimension ( copEnterInt, 20000 )
setElementInterior ( copEnterInt, 1 )

function teleportToInt ( player )
    if ( isElement(player) and getElementType(player) == "player" ) and not isPedInVehicle ( player ) then
	if not ( exports.GTIemployment:getPlayerJob(player, true) == "Criminal" ) then exports.GTIhud:dm("This is a criminal entrance, enter from the back entrance!", player, 200, 0, 0) return end
	    setElementDimension ( player, 20000 )
		setElementInterior ( player, 1 )
		setElementPosition ( player, 219.959, 229.519, 1671.069 )
		setElementRotation ( player, 0, 0, 90, "default", true )
	end
end
addEventHandler ("onMarkerHit", outsideMarker, teleportToInt )

function teleportToIntt ( player )
    if ( isElement(player) and getElementType(player) == "player" ) and not isPedInVehicle ( player ) then
	    setElementDimension ( player, 0 )
		setElementInterior ( player, 0 )
		setElementPosition ( player, -50.117, -273.774, 5.632 )
		setElementRotation ( player, 0, 0, 180, "default", true )
	end
end
addEventHandler ("onMarkerHit", markerInside, teleportToIntt )

function copsSpawn ( player )
    if ( isElement(player) and getElementType(player) == "player" ) and not isPedInVehicle ( player ) then
	    setElementDimension ( player, 20000 )
		setElementInterior ( player, 1 )
		setElementPosition ( player, 219.357, 216.686, 1687.469 )
	end
end
addEventHandler ("onMarkerHit", copEnter, copsSpawn )

function copsSpawn1 ( player )
    if ( isElement(player) and getElementType(player) == "player" ) and not isPedInVehicle ( player ) then
	    setElementDimension ( player, 0 )
		setElementInterior ( player, 0 )
		setElementPosition ( player, -50.538, -231.540, 6.765 )
	end
end
addEventHandler ("onMarkerHit", copEnterInt, copsSpawn1 )]]

function printAmountOfAccounts ( thePlayer )
    local accountTable = getAccounts () -- return the table over accounts
    if #accountTable == 0 then -- if the table is empty
        outputChatBox( "There are no accounts. :(", thePlayer )
    else -- table isn't empty
        outputChatBox( "There are " .. #accountTable .. " accounts in this server!", thePlayer )
    end
end
addCommandHandler( "accountcount", printAmountOfAccounts )