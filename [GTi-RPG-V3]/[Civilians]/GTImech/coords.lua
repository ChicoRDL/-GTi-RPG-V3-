    
towCars = {    
    {1715.880, -1732.236, 12.383},
    {1821.078, -1769.907, 12.383},
    {1919.501, -1933.659, 12.383},
    {2021.475, -1931.063, 12.360},
    {2126.115, -1894.071, 12.382},
    {2216.925, -1817.456, 12.195},
    {2185.811, -1700.462, 12.495},
    {2319.208, -1659.608, 12.968},
    {2487.001, -1669.066, 12.336},
    {2342.245, -1483.461, 22.828},
    {2288.323, -1382.684, 23.108},
    {2271.513, -1152.353, 25.761},
    {2511.177, -1149.917, 38.918},
    {2511.213, -1265.352, 33.849},
    {2511.213, -1265.352, 33.849},
    {2069.117, -1220.527, 22.822},
    {2069.124, -1361.134, 22.817},
    {1877.809, -1340.142, 12.383},
    {1825.980, -1261.954, 12.469},
    {1715.968, -1301.205, 12.391},
    {1601.042, -1368.580, 14.180},
    {1536.832, -1440.145, 12.383},
    {1454.730, -1374.440, 12.383},
    {1444.700, -1592.542, 12.383},
    {1394.092, -1731.980, 12.383},
    {1309.525, -1716.712, 12.383},
    {1202.447, -1851.246, 12.390},
    {1034.114, -1803.318, 12.667},
    {915.728, -1672.673, 12.391},
    {890.839, -1571.965, 12.391},
    {782.743, -1586.265, 12.390},
    {783.903, -1526.070, 12.383},
    {752.722, -1680.710, 2.931},
    {667.406, -1738.307, 12.489},
    {634.803, -1634.252, 14.553},
    {579.573, -1586.955, 15.008},
    {532.683, -1628.894, 15.812},
    {537.944, -1418.689, 14.953},
    }
    
hasOrder = false
totalDeliveries = 0
totalLitres = 0
lastLoc = 0
trailer = false    
distance = 0
    



function createTowVehicle()
    if (hasOrder) then return end
    if (exports.GTIemployment:getPlayerJob(true) == "Mechanic" and isPedInVehicle(localPlayer) and getElementModel(getPedOccupiedVehicle(localPlayer)) == 525) then
        loc = math.random(#towCars)
        if (loc == lastLoc) then
            startMission(localPlayer)
            return
        end
        delX, delY, delZ = towCars[loc][1], towCars[loc][2], towCars[loc][3]
        theVehicle = createVehicle(415, delX, delY, delZ + 1)
        theMarker = createMarker(delX, delY, delZ, "cylinder", 5, 255, 200, 0, 150)
        delBlip = createBlip(delX, delY, delZ, 41)
        zone = getZoneName(delX, delY, delZ, false)
        exports.GTIhud:dm("There's a car that needs to be towed at "..zone, 0, 200, 0)
        x, y, z = getElementPosition(localPlayer)
        distance = getDistanceBetweenPoints2D(delX, delY, x, y)
        hasOrder = true
        setElementData(localPlayer, "GTItrucker.HasOrder", true)
        lastLoc = loc
        addEventHandler("onClientMarkerHit", theMarker, deliverCar)
    end
end
addCommandHandler("towmission", createTowVehicle) 

function deliverCar(hitElement)
    if (isElement(theVehicle) and isPedInVehicle(hitElement) and getElementModel(getPedOccupiedVehicle(hitElement)) == 525) then
        if (hitElement == localPlayer) then
            if (isElement(theMarker)) then
                destroyElement(theMarker)
            end
            if (isElement(delBlip)) then
                destroyElement(delBlip)
            end
            local plr = getVehicleOccupant(getPedOccupiedVehicle(localPlayer))
            if (isElement(plr)) then
                delMarker = createMarker(2196.235, -1977.568, 12.55, "cylinder", 3, 255, 200, 0, 150)
                delBlip = createBlip(2196.235, -1977.568, 12.55, 41)
                exports.GTIhud:dm("Tow the car to the blip on your map to complete your mission.", 0, 200, 0)
                addEventHandler("onClientMarkerHit", delMarker, completeMission)
            end
        end    
    end
end

function completeMission(hitElement)    
    if (isElement(hitElement) and isPedInVehicle(hitElement) and getElementModel(getPedOccupiedVehicle(hitElement)) == 525) then
        if (hitElement == localPlayer) then
            local veh = getPedOccupiedVehicle(localPlayer)
            local dis = exports.GTIutil:getDistanceBetweenElements2D(veh, theVehicle)
            if (dis > 100) then return end
            if (isElement(theVehicle)) then
                detachTrailerFromVehicle(getPedOccupiedVehicle(localPlayer), theVehicle)
                destroyElement(theVehicle)
            end
            
            if (isElement(delMarker)) then
                destroyElement(delMarker)
            end
            if (isElement(delBlip)) then
                destroyElement(delBlip)
            end
            
            local plr = getVehicleOccupant(getPedOccupiedVehicle(localPlayer))
            exports.GTIhud:dm("You succesfully towed the car and cleaned the streets of Los Santos.", 0, 200, 0)
            local payment = distance
            triggerServerEvent("GTImechanic.completeMission", localPlayer, localPlayer, payment)
            
            hasOrder = false
        end    
    end
end    



function onQuitJob(job, bool)
    if (job == "Mechanic" and hasOrder) then
        if (source == localPlayer) then
            if (isElement(theVehicle)) then
                destroyElement(theVehicle)
            end
                
            if (isElement(delMarker)) then
                destroyElement(delMarker)
            end
            if (isElement(delBlip)) then
                destroyElement(delBlip)
            end
            if (isElement(theMarker)) then
                destroyElement(theMarker)
            end
            hasOrder = false
        end    
    end
end
addEventHandler("onClientPlayerQuitJob", root, onQuitJob)    









