seedsPlanted = {}
spawnedPlants = {}
pickedUp = 0
plantsCount = 0
scale = 0.05
totalPickedUp = 0

plantTimers = {}
noPlantCheck = {}

function farmerPlant()
if not exports.GTIemployment:getPlayerJob(true) == "Farmer" then return end
if not isPedInVehicle(localPlayer) then return end
    local curPl = seedsPlanted[localPlayer] or 0
    if currentSeeds <= 0 then
        if isTimer( plantTimer) then
            killTimer(plantTimer)
        end
        currentSeeds = 0
        return
    end
    if curPl >= 50 then
        if isTimer( plantTimer) then
            killTimer(plantTimer)
        end
        curPL = 50
        return
    end
    if not isPlayerInVehicle( localPlayer) then
        return
    end
    if not isElement(farmTrailer[localPlayer]) then
        return
    end
    if not isVehicleOnGround(farmTrailer[localPlayer]) then
        return
    end
    if not isElementWithinColShape( localPlayer, farmerZone1) then
        return
    end

    local x, y, z = getElementPosition(farmTrailer[localPlayer])

    if noPlantCheck[math.floor( x)..";"..math.floor( y)] then
        return
    end

    noPlantCheck[math.floor( x)..";"..math.floor( y)] = true
    local x = math.floor(x)
    local randomN = math.random(1,2)
    if randomN == 1 then
        farmYPick = math.floor( y)
    else
        farmYPick = math.ceil( y)
    end
    local yy = farmYPick
    -- Begin Check
    local thePlant = createObject( 1305, x, yy, z-1.75, 0, 0, 0, true) --Regular
    setElementCollisionsEnabled( thePlant, false)
    local plantCol = createColSphere(x, y, z, 3)
    local theBlip = createBlipAttachedTo( thePlant, 0, 1, 150, 150, 150, 255, 0, 100)
    attachElements(plantCol, thePlant)
    spawnedPlants[plantCol] = {}
    spawnedPlants[plantCol].object = thePlant
    spawnedPlants[plantCol].blip = theBlip
    spawnedPlants[plantCol].X = x
    spawnedPlants[plantCol].Y = yy
    spawnedPlants[plantCol].Z = z
    spawnedPlants[plantCol].growing = false
    plantsCount = plantsCount + 1
    seedsPlanted[localPlayer] = curPl+1
    addEventHandler( "onClientColShapeHit", plantCol, plowEntry)
end

local planting = false
local planted = 0

function onJobQuit( job )
    if ( job == "Farmer" ) then
        planting = false
        planted = 0
    end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, onJobQuit)

function setupSeed( plant, blip, col)
    local x, y, z = getElementPosition( plant)
    setElementModel( plant, tonumber( plantobject))
    setElementPosition( plant, x, y, z+1.25)
    setObjectScale( plant, 0.02)
    plantTimers["1"..tostring( plant)] = setTimer(plantisGrowing, 1500, 10, plant, 0.3)
    plantTimers["2"..tostring( plant)] = setTimer( plantsReady, 30000, 1, blip, plant, col)
    spawnedPlants[col].growing = true
    removeEventHandler( "onClientColShapeHit", col, plowEntry)
    planting = false
    takeSeeds(1)
    local curPl = seedsPlanted[localPlayer] or 0
    planted = planted + 1
    plantSeeds(planted)
end

function plowEntry( hitElement, matchingDimension)
    if hitElement == localPlayer then
        if matchingDimension then
            if isPlayerInVehicle( localPlayer) then
                return
            end
            if not isElementWithinColShape( localPlayer, farmerZone1) then
                return
            end
	    if currentSeeds <= 0 then
		exports.GTIhud:dm("You're out of seeds.", 255, 0, 0)
		return
	    end
            if not spawnedPlants[source].growing then
                if not planting then
                    exports.GTIanims:setJobAnimation(localPlayer, "BOMBER", "BOM_Plant", 2500, false, false, false, false)
                    toggleAllControls(false)
                    setTimer(function() toggleAllControls(true) end, 2500, 1)
                    local plant = spawnedPlants[source].object
                    local pBlip = spawnedPlants[source].blip
                    setTimer( setupSeed, 2000, 1, plant, pBlip, source)
                    planting = true
                end
            end
        end
    end
end

function beginPlanting(theElement)
    if ( theElement == farmTrailer[localPlayer]) then
        plantTimer = setTimer( farmerPlant, 250, 0)
    end
end

function plantisGrowing(thePlant, scalePlus)
    if isTimer( plantTimers["1"..tostring( thePlant)]) then
        local rem, exe, totEx = getTimerDetails( plantTimers["1"..tostring( thePlant)])
        --[[
        if (exe == 21) then
            setObjectScale(thePlant, 0.1)
        elseif (exe == 20) then
            setObjectScale(thePlant, 0.15)
        elseif (exe == 19) then
            setObjectScale(thePlant, 0.2)
        elseif (exe == 18) then
            setObjectScale(thePlant, 0.25)
        elseif (exe == 17) then
            setObjectScale(thePlant, 0.3)
        elseif (exe == 16) then
            setObjectScale(thePlant, 0.35)
        elseif (exe == 15) then
            setObjectScale(thePlant, 0.4)
        elseif (exe == 14) then
            setObjectScale(thePlant, 0.45)
        elseif (exe == 13) then
            setObjectScale(thePlant, 0.5)
        elseif (exe == 12) then
            setObjectScale(thePlant, 0.55)
        elseif (exe == 11) then
            setObjectScale(thePlant, 0.6)
        elseif (exe == 10) then
            setObjectScale(thePlant, 0.65)
        elseif (exe == 9) then
            setObjectScale(thePlant, 0.7)
        elseif (exe == 8) then
            setObjectScale(thePlant, 0.75)
        elseif (exe == 7) then
            setObjectScale(thePlant, 0.8)
        elseif (exe == 6) then
            setObjectScale(thePlant, 0.85)
        elseif (exe == 5) then
            setObjectScale(thePlant, 0.9)
        elseif (exe == 4) then
            setObjectScale(thePlant, 0.95)
        elseif (exe == 3) then
            setObjectScale(thePlant, 1)
        elseif (exe == 2) then
            setObjectScale(thePlant, 1)
        elseif (exe == 1) then
            setObjectScale(thePlant, 1)
        elseif (exe == 0) then
            setObjectScale(thePlant, 1)
        end
        --]]
        if (exe == 11) then
            setObjectScale(thePlant, 0.1)
        elseif (exe == 10) then
            setObjectScale(thePlant, 0.15)
        elseif (exe == 9) then
            setObjectScale(thePlant, 0.2)
        elseif (exe == 8) then
            setObjectScale(thePlant, 0.25)
        elseif (exe == 7) then
            setObjectScale(thePlant, 0.3)
        elseif (exe == 6) then
            setObjectScale(thePlant, 0.35)
        elseif (exe == 5) then
            setObjectScale(thePlant, 0.4)
        elseif (exe == 4) then
            setObjectScale(thePlant, 0.45)
        elseif (exe == 3) then
            setObjectScale(thePlant, 0.5)
        elseif (exe == 2) then
            setObjectScale(thePlant, 0.55)
        elseif (exe == 1) then
            setObjectScale(thePlant, 0.6)
        elseif (exe == 0) then
            setObjectScale(thePlant, 0.65)
        end
    else
        if isElement( thePlant) then
            destroyElement( thePlant)
        end
        killTimer( plantTimers["1"..tostring( thePlant)])
        killTimer( plantTimers["2"..tostring( thePlant)])
    end
end

function stopPlanting(theElement)
    if ( theElement == farmTrailer[localPlayer] ) then
        if isTimer( plantTimer) then
            killTimer(plantTimer)
        end
        if isTimer( t1) then
            killTimer( t1)
        end
        if isTimer( t2) then
            killTimer( t2)
        end
    end
end

function plantSeeds(amount)
    currentPlanted = math.floor(amount)
    if currentPlanted <= 0 then currentPlanted = 0 end
    if currentPlanted >= 50 then currentPlanted = 50 end
    thePlanted = tostring(currentPlanted)
end
addEvent("plantSeeds",true)
addEventHandler("plantSeeds", root, plantSeeds)

function plantsReady(plantBlip, farmPlant, farmMarker)
    setBlipColor(plantBlip, 0, 255, 0, 255)
    plants2Harvest(currentHarvest+1)
    addEventHandler("onClientColShapeHit", farmMarker, harvestFix)
    if currentHarvest == currentPlanted then
        triggerServerEvent("plantedSeeds", localPlayer, localPlayer, true)
        if not dxEnabled then
            addEventHandler ( "onClientPreRender", root, drawPlantsToHarvest, false )
            dxEnabled = true
        end
    else
        triggerServerEvent("plantedSeeds", localPlayer, localPlayer, false)
    end
end


local droppedHay = {}
function harvestFix(hitElement)
    if getElementType(hitElement) == "vehicle" then
        if getElementModel(hitElement) == 532 then
            local player = getVehicleOccupant(hitElement,0)
            if player == localPlayer then
                local data = spawnedPlants[source]
                if ( type ( data ) == "table" ) then
                    destroyElement ( source )
                    destroyElement ( data.blip )
                    destroyElement ( data.object )
                    local x = data.X
                    local y = data.Y
                    local z = data.Z
                    local theHay = createObject(2901, x, y, z, 0, 0, 0, true)
                    local hayCol = createColSphere(x, y, z, 1)
                    local curPl = seedsPlanted[localPlayer] or 0
                    droppedHay[hayCol] = {}
                    droppedHay[hayCol].hay = theHay
                    addEventHandler("onClientColShapeHit", hayCol, onBalePickup)
					local hemp = setElementData ( localPlayer, "hemp", data, false )
                    spawnedPlants[localPlayer] = nil
                    plants2Harvest(currentHarvest-1)
                    plantSeeds(curPl-1)
                    seedsPlanted[localPlayer] = curPl-1
                    planted = planted - 1
                end
            end
        end
    end
end

addEvent ("onHempLoad", true )
addEventHandler ("onHempLoad", root, function ( hemp ) setElementData ( source, "hemp", hemp, false ) end )

function onBalePickup(hitPlayer, matchingDimension)
    if hitPlayer == localPlayer then
        if exports.GTIemployment:getPlayerJob(true) == "Farmer" then
            if not isPedInVehicle(localPlayer) then
                local data = droppedHay[source]
                if ( type ( data ) == "table" ) then
                    destroyElement(source)
                    destroyElement(data.hay)
                    playSoundFrontEnd(32)
                    pickedUp =  pickedUp + 1
                    totalPickedUp = totalPickedUp + 1
                    if (pickedUp == 10) then
						
                        triggerServerEvent("setsJobCash", localPlayer, pickedUp)
						local hemp = getElementData ( localPlayer, "hemp" )
                        pickedUp = 0
                        if (totalPickedUp == plantsCount) then
                            totalPickedUp = 0
                            plantsCount = 0
                        end
                    elseif (totalPickedUp == plantsCount) then
                        local morePickUp = 10 - pickedUp
                        totalPickedUp = 0
                        plantsCount = 0
                        exports.GTIhud:dm("You need to pickup "..morePickUp.." to get your next payment", 255, 0, 0)
                    end
                end
            end
        end
    end
end


function stopPlanting2(jobName, resignJob)
    if (jobName == "Farmer") then
        seedsPlanted[localPlayer] = nil
        for i, colshape in pairs (spawnedPlants) do
            if spawnedPlants[i] then
                local data = spawnedPlants[i]
                if ( type ( data ) == "table" ) then
                    destroyElement( i)
                    destroyElement( data.blip)
                    destroyElement( data.object)
                    if isTimer( plantTimers["1"..tostring( data.object)]) then
                        killTimer( plantTimers["1"..tostring( data.object)])
                    end
                    if isTimer( plantTimers["2"..tostring( data.object)]) then
                        killTimer( plantTimers["2"..tostring( data.object)])
                    end
		    if isTimer ( plantTimer ) then
			killTimer ( plantTimer )
		    end
                end
            end
        end
        if noPlantCheck then
            noPlantCheck = nil
            noPlantCheck = {}
        end
    end
end
addEventHandler("onClientPlayerQuitJob", localPlayer, stopPlanting2)
