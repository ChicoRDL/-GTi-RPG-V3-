farmTrailer = {}

function getFarmTrailer(theTrailer)
    farmTrailer[localPlayer] = theTrailer
end
addEvent("getFarmTrailer",true)
addEventHandler("getFarmTrailer", root, getFarmTrailer)

handled = false

function onFCarEnter( theVehicle)
    if getElementData(localPlayer,"job") == "Farmer" then
		if isElement( theVehicle) and getVehicleType(theVehicle) == "Automobile" then
			local vehModel = getElementModel( theVehicle)
			if vehModel == 531 then
				local x, y, z = getElementPosition( localPlayer)
				for i, theFZone in pairs (farmerZones) do
					if not handled then
						addEventHandler( "onClientColShapeHit", theFZone, beginPlanting)
						addEventHandler( "onClientColShapeLeave", theFZone, stopPlanting)
						handled = true
					end
				end
			--[[
			elseif vehModel == 572 then
				addEventHandler ( "onClientColShapeHit", farmerZone1, beginFertilizing, false)
				addEventHandler("onClientColShapeLeave", farmerZone1, stopFertilizing, false)
			--]]
			end
		end
    end
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, onFCarEnter)

function onFCarExit( theVehicle)
	if getElementData(localPlayer,"job") == "Farmer" then
		if isElement( theVehicle) and getVehicleType(theVehicle) == "Automobile" then
			local vehModel = getElementModel( theVehicle)
			if vehModel == 531 then
				for i, theFZone in pairs (farmerZones) do
					if handled then
						removeEventHandler( "onClientColShapeHit", theFZone, beginPlanting)
						removeEventHandler( "onClientColShapeLeave", theFZone, stopPlanting)
						handled = false
					end

					if (isTimer(plantTimer)) then
						killTimer(plantTimer)
					end
				end
			end
		end
	end
end
addEventHandler("onClientPlayerVehicleExit", localPlayer, onFCarExit)

function onFCarDestroy(vehicle)
	if (getElementData(localPlayer,"job") == "Farmer") then
		if (getElementType(vehicle) == "vehicle") and (getVehicleType(vehicle) == "Automobile") and (getElementModel(vehicle) == 531) then
			for k,v in pairs(farmerZones) do
				if (handled) then
					removeEventHandler("onClientColShapeHit",theFZone,beginPlanting)
					removeEventHandler("onClientColShapeLeave",theFZone,stopPlanting)
					handled=false

					if (isTimer(plantTimer)) then
						killTimer(plantTimer)
					end
				end
			end
		end
	end
end
addEventHandler("onClientElementDestroyed",root,onFCarDestroy)

function noCollide()
    local myVehicle = getPedOccupiedVehicle(localPlayer)
    local vehicles = getElementsByType("vehicle")
    for k,v in ipairs(vehicles) do
        if getElementData(localPlayer, "job") == "Farmer" then
			if myVehicle then
				setElementCollidableWith(myVehicle, v, false)
				--[[
				if (getElementModel(myVehicle) == 532) then
					setElementCollidableWith(myVehicle, v, false)
				elseif (getElementModel(myVehicle) == 531) then
					setElementCollidableWith(myVehicle, v, false)
				elseif (getElementModel(myVehicle) == 572) then
					setElementCollidableWith(myVehicle, v, false)
				end
				--]]
			end
        end
    end
	for i, player in ipairs ( getElementsByType( "player")) do
		if getElementData(localPlayer, "job") == "Farmer" then
			setElementCollidableWith( localPlayer, player, false)
			if myVehicle then
				setElementCollidableWith( player, myVehicle, false)
				setElementCollidableWith( myVehicle, player, false)
			end
		else
			setElementCollidableWith( localPlayer, player, true)
		end
	end
end
setTimer( noCollide, 2000, 0)

function noTrailerCollide(trailer, tractor)
    local vehicles2 = getElementsByType("vehicle")
    for i,veh in ipairs(vehicles2) do
		if veh then
			if trailer then
				setElementCollidableWith(veh, trailer, false)
			end
		end
    end
end
addEvent("noTrailerCollide",true)
addEventHandler("noTrailerCollide", root, noTrailerCollide)
