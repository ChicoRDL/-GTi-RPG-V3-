carShops = {
    {558.632, -1266.887, 16.242},
    {1006.039, -1318.138, 12.391},
    {2120.844, -1136.143, 24.241},
    {2206.549, -2233.821, 12.547},
    {-1981.899, 257.992, 34.172},
    {-1644.334, 1219.043, 6.039},
    {2212.542, 1411.268, 9.820},
    {1636.362, 2193.331, 9.820},
}
    
packUpPoints = {
    {-529.701, -501.754, 23.907},
    {-557.527, -500.945, 23.974},
    }
    
bulkLocs = {
    {-1021.735, -622.302, 31.008},
    {-1733.250, 193.066, 2.555}, -- SF Easter Basin
    {-2105.281, 208.650, 34.258}, -- SF Doherty I
    {-2123.952, -105.596, 34.320}, -- SF Doherty II
    {-2634.172, -45.882, 3.336}, -- SF Ocean Flats
    {-2639.552, 1356.447, 6.141}, -- SF Battery Point
    {-1644.400, 1291.664, 6.039}, -- SF Esplanade North
    {-1440.547, 467.295, 6.188}, -- SF Aircraft Carrier
    {1027.024, 2075.218, 9.820}, -- LV 
    }    
    
Fuelstations = {
    { 1944.8, -1777.9, 12.4, 0},
    { 1937.6, -1769.4, 12.4, 0},
    { 1008.5, -939, 41.1, 0},
    { -2239.1001, -2563.6001, 30.9, 0},
    { -1609.6, -2718.3999, 47.5, 0},
    { -82.711, -1153.030, 0.750, 0},
    { -2023.7, 157, 27.8, 0},
    { -1679.4, 422.2, 6.1, 0},
    { -2415.8, 980.8, 44.3, 0},
    { -1466, 1864.1, 31.5, 0},
    { -1328.2, 2677.3999, 48.9, 0, "D"},
    { 2143.5, 2757, 9.8, 0},
    { 2634.7, 1096.7, 9.7, 0},
    { 2112.3, 930, 9.8, 0},
    { 1380.5, 457.2, 19, 0},
    { 658.4, -570.5, 15.3, 0},
    { 604.6, 1704.4, 6, 0},
    {2522.075, -1506.621, 22.828, 0},
    { 1596.040, 2190.416, 9.820, 0},
    -- Airports
    { -1461.735, -546.657, 13.148, "A"}, -- SF
    { 1993.473, -2635.281, 12.547, "A"}, -- LS
    { 1431.925, 1659.895, 9.820, "A"}, -- LV
}    

ammunation = {
    {1361.679, -1292.438, 12.346}, -- LS Market
    {2348.055, -1991.766, 12.383}, -- LS Docks
    {236.206, -199.016, 0.434}, -- Blueberry
    {2340.972, 60.069, 25.336}, -- Palomino Creek
    {2173.297, 913.067, 9.820}, -- LV 
    {2529.831, 2084.614, 9.672}, -- Old Strip LV
    {794.930, 1862.137, 3.555}, -- Bone County
    {-306.783, 800.929, 14.013}, -- Bone County II
    {-2628.474, 215.263, 3.404}, -- SF
    {-2099.692, -2483.033, 29.625}, -- Angel Pine
}
allowedCars = {
    [443] = true, -- Packer   
    [455] = true, -- Flatbed  
    [514] = true, -- Tanker
    [428] = true, -- Securicar
    }
    
    
local truckerArea = createColTube(-539.837, -522.885, 24.5, 80, 20)    

hasOrder = false
totalDeliveries = 0
totalLitres = 0
lastLoc = 0
trailer = false

function setGhostOn(hitElement)
    if (source == truckerArea) then
        if(getElementType(hitElement) == "vehicle") then
            local player = getVehicleOccupant(hitElement)
            EnableGhost(player)
        end    
    end    
end
addEventHandler("onClientColShapeHit", root, setGhostOn) 

function setGhostOff(hitElement)
    if (source == truckerArea) then
        if(getElementType(hitElement) == "vehicle") then
            local player = getVehicleOccupant(hitElement)
            DisableGhost(player)
        end    
    end    
end
addEventHandler("onClientColShapeLeave", root, setGhostOff)
    
function startMission (player, seat)
    --[[if (isElementWithinColShape(source, truckerArea)) then
        for index,vehicle in ipairs(getElementsByType("vehicle")) do 
        setElementCollidableWith(vehicle, source, true)
        end  
        end    ]]--
    local job = exports.GTIemployment:getPlayerJob(true)
    if (job == "Trucker" and seat == 0) then
        if (allowedCars[getElementModel(source)] and hasOrder == false and player == localPlayer) then
            local division = getElementData(player, "division")
            if (division == "Car Supplier" and getElementModel(source) == 443) then
                loc = math.random(#carShops)
                if (loc == lastLoc) then
                    startMission(player, seat)
                    return
                end
                delX, delY, delZ = carShops[loc][1], carShops[loc][2], carShops[loc][3]
                delMarker = createMarker(delX, delY, delZ, "cylinder", 3, 255, 200, 0, 150)
                delBlip = createBlip(delX, delY, delZ, 51)
                zone = getZoneName(delX, delY, delZ, false)
                exports.GTIhud:dm("Deliver your goods at "..zone, 0, 200, 0)
                x, y, z = getElementPosition(player)
                distance = getDistanceBetweenPoints2D(delX, delY, x, y)
                hasOrder = true
                setElementData(player, "GTItrucker.HasOrder", true)
                lastLoc = loc
                addEventHandler("onClientMarkerHit", delMarker, completeMission)  
            elseif (division == "Bulk Transporter" and getElementModel(source) == 455) then
                exports.GTIhud:drawStat("deliveryCount", "", "", 77, 77, 255)
                loc = math.random(#packUpPoints)  
                delX, delY, delZ = packUpPoints[loc][1], packUpPoints[loc][2], packUpPoints[loc][3] 
                loadMarker = createMarker(delX, delY, delZ, "cylinder", 3, 255, 200, 0, 150)   
                loadBlip = createBlip(delX, delY, delZ, 51)
                addEventHandler("onClientMarkerHit", loadMarker, loadUp)  
                hasOrder = true
                setElementData(player, "GTItrucker.HasOrder", true)
                --elseif (division == "Petroleum Supplier" and trailer == false) then
                --trailer = createVehicle(584, -520.433, -499.849, 25.05) 
                --trailer = true   
            elseif (division == "Petroleum Supplier" and getElementModel(source) == 514) then
                triggerServerEvent("GTItrucker.spawnTrailer", player, player, "petrol")
            elseif (division == "Weapon Supplier" and getElementModel(source) == 428) then
                loc = math.random(#ammunation)
                if (loc == lastLoc) then
                    startMission(player, seat)
                    return
                end
                delX, delY, delZ = ammunation[loc][1], ammunation[loc][2], ammunation[loc][3]
                delMarker = createMarker(delX, delY, delZ, "cylinder", 3, 255, 200, 0, 150)
                delBlip = createBlip(delX, delY, delZ, 51)
                zone = getZoneName(delX, delY, delZ, false)
                exports.GTIhud:dm("Deliver your weapons at "..zone, 0, 200, 0)
                x, y, z = getElementPosition(player)
                distance = getDistanceBetweenPoints2D(delX, delY, x, y)
                hasOrder = true
                setElementData(player, "GTItrucker.HasOrder", true)
                lastLoc = loc
                addEventHandler("onClientMarkerHit", delMarker, completeMission)  
                --triggerServerEvent("GTItrucker.ableToRob", localPlayer, localPlayer, source, delX, delY, delZ)    
            end
        end    
    end    
end
addEventHandler("onClientVehicleEnter", root, startMission)

function loadUp (player)
    if (player == localPlayer) then
        local veh = getPedOccupiedVehicle(player)
        local job = exports.GTIemployment:getPlayerJob(player, true)
        if (job == "Trucker" and getVehicleController(veh)) then
            if (hasOrder == true) then
                local speed = exports.GTIutil:getElementSpeed(veh, "kph")
                if (speed < 35) then
                    local health = getElementHealth(veh)
                    if (health > 500) then
                        exports.GTIhud:drawProgressBar("packUpBar", "Pack up progress:", 255, 0, 0, 7500)
                        setElementFrozen(veh, true)
                        removeEventHandler("onClientMarkerHit", loadMarker, loadUp)
                        destroyElement(loadMarker)
                        destroyElement(loadBlip)
                        loadTimer = setTimer( setDeliveryPoint, 7500, 1, player, veh )
                    else
                        exports.GTIhud:dm("Your vehicle is too damaged to use, repair it first!", 255, 0, 0)
                    end
                else
                    exports.GTIhud:dm("Your speed is too high, slow down to 35 kph to deliver.", 255, 0, 0)
                end
            end
        end
    end
end

function setDeliveryPoint(player, veh)
    local job = exports.GTIemployment:getPlayerJob(player, true)
    if (job == "Trucker") then
        if (allowedCars[getElementModel(veh)] and hasOrder == true and player == localPlayer) then
        setElementFrozen(veh, false)
        local division = getElementData(player, "division")
            if (division == "Bulk Transporter") then
                loc = math.random(#bulkLocs)
                if (loc == lastLoc) then
                    startMission(player, seat)
                    return
                end
                delX, delY, delZ = bulkLocs[loc][1], bulkLocs[loc][2], bulkLocs[loc][3]     
            end
            exports.GTIhud:drawStat("deliveryCount", "Total Deliveries", totalDeliveries.."/5", 30, 125, 255)
            delMarker = createMarker(delX, delY, delZ, "cylinder", 3, 255, 200, 0, 150)
            delBlip = createBlip(delX, delY, delZ, 51)
            zone = getZoneName(delX, delY, delZ, false)
            exports.GTIhud:dm("Deliver your goods at "..zone, 0, 200, 0)
            x, y, z = getElementPosition(player)
            distance = getDistanceBetweenPoints2D(delX, delY, x, y)       
            setTimer(function (veh) if (isElementFrozen(veh)) then setElementFrozen(veh, false) end end, 10000, 1) 
            lastLoc = loc
            addEventHandler("onClientMarkerHit", delMarker, completeMission)  
        end
    end
end
    
bezig = false
function startNextMission (player, veh)
    toggleControl("accelerate", true)
    toggleControl("brake_reverse", true)
    toggleControl("handbrake", true)
    toggleControl("enter_exit", true)
    local job = exports.GTIemployment:getPlayerJob(player, true)
    if (bezig == true) then return end
    bezig = true
    setTimer(function()  bezig = false end, 2000, 1)
    if (job == "Trucker") then
        if (getVehicleController(veh) == player) then
            if (allowedCars[getElementModel(veh)] and hasOrder == false and player == localPlayer) then
                local division = getElementData(player, "division")
            if (division == "Car Supplier") then
                loc = math.random(#carShops)
                outputDebugString(loc)
                if (loc == lastLoc) then
                    startNextMission(player, veh)
                    return
                end
                delX, delY, delZ = carShops[loc][1], carShops[loc][2], carShops[loc][3]
            elseif (division == "Bulk Transporter") then
                loc = math.random(#bulkLocs)
                if (loc == lastLoc) then
                    startNextMission(player, veh)
                    return
                end
                exports.GTIhud:drawStat("deliveryCount", "Total Deliveries", totalDeliveries.."/5", 30, 125, 255)
                delX, delY, delZ = bulkLocs[loc][1], bulkLocs[loc][2], bulkLocs[loc][3]   
            elseif (division == "Weapon Supplier") then   
                loc = math.random(#ammunation)
                if (loc == lastLoc) then
                    startNextMission(player, veh)
                    return
                end
                delX, delY, delZ = ammunation[loc][1], ammunation[loc][2], ammunation[loc][3]                   
            end
            setControlState("brake_reverse", false)
            setControlState("handbrake", false)
            delMarker = createMarker(delX, delY, delZ, "cylinder", 3, 255, 200, 0, 150)
            delBlip = createBlip(delX, delY, delZ, 51)
            zone = getZoneName(delX, delY, delZ, false)
            exports.GTIhud:dm("Deliver your goods at "..zone, 0, 200, 0)
            x, y, z = getElementPosition(player)
            distance = getDistanceBetweenPoints2D(delX, delY, x, y)
            hasOrder = true
            setElementData(player, "GTItrucker.HasOrder", true)
            lastLoc = loc
            addEventHandler("onClientMarkerHit", delMarker, completeMission)
            end
        end
    end    
end

function stopTruckerDelivery()
    exports.GTIhud:drawStat("deliveryCount", "", "", 30, 125, 255)
    if isElement( delMarker ) and isElement( delBlip ) and source == localPlayer then
        removeEventHandler( "onClientMarkerHit", delMarker, completeMission )
        destroyElement( delMarker )
        destroyElement( delBlip )
        hasOrder = false
        outputDebugString("284")
        setElementData(source, "GTItrucker.HasOrder", false)
    elseif isElement(loadMarker) and isElement(loadBlip) and source == localPlayer then
        removeEventHandler( "onClientMarkerHit", loadMarker, completeMission )
        destroyElement( loadMarker )
        destroyElement( loadBlip )
        hasOrder = false  
        outputDebugString("291")
        setElementData(source, "GTItrucker.HasOrder", false)  
    end
end
addEventHandler( "onClientPlayerGetJob", root, stopTruckerDelivery )
addEventHandler( "onClientPlayerQuitJob", root, stopTruckerDelivery )
addEventHandler("onClientPlayerWasted", root, stopTruckerDelivery )


function stopTruckerDeliveryOnDivisionChange(plr)
    if (plr == localPlayer) then
        exports.GTIhud:drawStat("deliveryCount", "", "", 30, 125, 255)
        if isElement( delMarker ) and isElement( delBlip ) and source == localPlayer then
            removeEventHandler( "onClientMarkerHit", delMarker, completeMission )
            destroyElement( delMarker )
            destroyElement( delBlip )
            hasOrder = false
            outputDebugString("307")
            setElementData(source, "GTItrucker.HasOrder", false)  
        elseif isElement(loadMarker) and isElement(loadBlip) and source == localPlayer then
            removeEventHandler( "onClientMarkerHit", loadMarker, completeMission )
            destroyElement( loadMarker )
            destroyElement( loadBlip )
            hasOrder = false  
            outputDebugString("314")
            setElementData(source, "GTItrucker.HasOrder", false)  
        else    
            hasOrder = false  
            outputDebugString("318")
            exports.GTIhud:drawProgressBar("packUpBar", "", 255, 0, 0, 0)
            exports.GTIhud:drawProgressBar("fuelLoading", "", 0, 255, 255, 0)
            if (isTimer(loadTimer)) then
                killTimer(loadTimer)
            end      
        end
    end    
end
addEvent("GTItrucker.StopTruckDelivery", true)
addEventHandler("GTItrucker.StopTruckDelivery", root, stopTruckerDeliveryOnDivisionChange)

created = false

function startPetrolSup()
    local job = exports.GTIemployment:getPlayerJob(source, true)
    if (job == "Trucker" and source == localPlayer) then 
        local division = getElementData(source, "division")
        if (division == "Petroleum Supplier") then
            if (created == true) then return end
            created = true
            fillMarker = createMarker(635.120, 1225.640, 10.711, "cylinder", 3, 255, 200, 0, 150) 
            fillBlip = createBlip(635.120, 1225.640, 10.711, 51)
            addEventHandler("onClientMarkerHit", fillMarker, startFuelDeliver)     
        end
    end    
end
addEvent("GTItrucker.startPetrol", true)
addEventHandler("GTItrucker.startPetrol", root, startPetrolSup)

function startFuelDeliver (player)
    if (player == localPlayer) then
        local veh = getPedOccupiedVehicle(player)
        local job = exports.GTIemployment:getPlayerJob(player, true)
        if (job == "Trucker" and getVehicleController(veh)) then
            if (hasOrder == false) then
                local speed = exports.GTIutil:getElementSpeed(veh, "kph")
                local model = getElementModel(veh)
                if (speed < 35) then
                    local division = getElementData(player, "division")
                    if (division == "Petroleum Supplier" and model == 514) then
                        toggleControl("accelerate", false)
                        toggleControl("brake_reverse", false)
                        toggleControl("handbrake", false)
                        toggleControl("enter_exit", false)
                        setControlState("handbrake", true)
                        destroyElement(fillMarker)
                        destroyElement(fillBlip)
                        created = false
                        exports.GTIhud:drawProgressBar("fuelLoading", "Filling petrol tank.", 0, 255, 255, 15000)
                        totalLitres = 3000
                        setTimer(myMumIsAwesome, 15000, 1, player)
                    end
                end
            end
        end
    end
end    
        
function myMumIsAwesome(player)
    if (player == localPlayer) then
        loc = math.random(#Fuelstations)
        if (loc == lastLoc) then
            startMission(player, veh)
            return
        end
        delX, delY, delZ = Fuelstations[loc][1], Fuelstations[loc][2], Fuelstations[loc][3]
    end
    toggleControl("accelerate", true)
    toggleControl("brake_reverse", true)
    toggleControl("handbrake", true)
    toggleControl("enter_exit", true)
    setControlState("brake_reverse", false)
    setControlState("handbrake", false)
    delMarker = createMarker(delX, delY, delZ, "cylinder", 3, 255, 200, 0, 150)
    delBlip = createBlip(delX, delY, delZ, 51)
    zone = getZoneName(delX, delY, delZ, false)
    exports.GTIhud:dm("Refill the fuel station at "..zone, 0, 200, 0)
    x, y, z = getElementPosition(player)
    distance = getDistanceBetweenPoints2D(delX, delY, x, y)
    hasOrder = true
    setElementData(player, "GTItrucker.HasOrder", true)
    lastLoc = loc
    addEventHandler("onClientMarkerHit", delMarker, completeMission)
end


function completeMission (player)
    if (player == localPlayer) then
        local veh = getPedOccupiedVehicle(player)
        local job = exports.GTIemployment:getPlayerJob(player, true)
        if (job == "Trucker" and getVehicleController(veh)) then
            if (hasOrder == true) then
                local speed = exports.GTIutil:getElementSpeed(veh, "kph")
                local model = getElementModel(veh)
                if (speed < 35) then
                    local division = getElementData(player, "division")
                    if (division == "Car Supplier" and model == 443) then
                        local health = getElementHealth(veh)
                        if (health > 500) then
                            outputDebugString(distance)
                            toggleControl("accelerate", false)
                            toggleControl("brake_reverse", false)
                            toggleControl("handbrake", false)
                            toggleControl("enter_exit", false)
                            setControlState("handbrake", true)
                            removeEventHandler("onClientMarkerHit", delMarker, completeMission)
                            destroyElement(delMarker)
                            destroyElement(delBlip)
                            hasOrder = false
                            outputDebugString("427")
                            setElementData(player, "GTItrucker.HasOrder", false)
                            triggerServerEvent("GTItrucker.completeDelivery", player, veh, distance)
                            setTimer( startNextMission, 4000, 1, player, veh )
                        else
                            exports.GTIhud:dm("Your goods are too damaged to be delivered. To deliver, repair your vehicle first", 255, 0, 0)
                        end
                    elseif (division == "Bulk Transporter" and model == 455) then  
                        totalDeliveries = totalDeliveries + 1
                        toggleControl("accelerate", false)
                        toggleControl("brake_reverse", false)
                        toggleControl("handbrake", false)
                        toggleControl("enter_exit", false)
                        setControlState("handbrake", true)
                        removeEventHandler("onClientMarkerHit", delMarker, completeMission)
                        destroyElement(delMarker)
                        destroyElement(delBlip)
                        hasOrder = false
                        outputDebugString("446")
                        setElementData(player, "GTItrucker.HasOrder", false)
                        triggerServerEvent("GTItrucker.completeDelivery", player, veh, distance)
                        if (totalDeliveries == 5) then
                            toggleControl("accelerate", true)
                            toggleControl("brake_reverse", true)
                            toggleControl("handbrake", true)
                            toggleControl("enter_exit", true)
                            setControlState("handbrake", false)
                            totalDeliveries = 0
                            loc = math.random(#packUpPoints)  
                            delX, delY, delZ = packUpPoints[loc][1], packUpPoints[loc][2], packUpPoints[loc][3] 
                            loadMarker = createMarker(delX, delY, delZ, "cylinder", 3, 255, 200, 0, 150)   
                            loadBlip = createBlip(delX, delY, delZ, 51)
                            addEventHandler("onClientMarkerHit", loadMarker, loadUp)  
                            hasOrder = true
                        else    
                            setTimer( startNextMission, 4000, 1, player, veh )
                        end  
                    elseif (division == "Petroleum Supplier" and model == 514) then  
                        if (totalLitres < 1000) then
                            litres = totalLitres
                        else    
                            litres = math.random(250, 1000)
                        end    
                        totalLitres = totalLitres - litres
                        exports.GTIhud:dm("You're now refilling this station with "..litres.." Litres.", 255, 255, 0)
                        toggleControl("accelerate", false)
                        toggleControl("brake_reverse", false)
                        toggleControl("handbrake", false)
                        toggleControl("enter_exit", false)
                        setControlState("handbrake", true)
                        removeEventHandler("onClientMarkerHit", delMarker, completeMission)
                        destroyElement(delMarker)
                        destroyElement(delBlip)
                        hasOrder = false
                        outputDebugString("482")
                        setElementData(player, "GTItrucker.HasOrder", false)
                        triggerServerEvent("GTItrucker.completeDelivery", player, veh, distance)
                        exports.GTIhud:drawProgressBar("UnloadBar", "Refilling Station", 255, 137, 0, 10000)
                        if (totalLitres == 0) then
                            toggleControl("accelerate", true)
                            toggleControl("brake_reverse", true)
                            toggleControl("handbrake", true)
                            toggleControl("enter_exit", true)
                            setControlState("handbrake", false)
                            fillMarker = createMarker(635.120, 1225.640, 10.711, "cylinder", 3, 255, 200, 0, 150) 
                            fillBlip = createBlip(635.120, 1225.640, 10.711, 51)
                            addEventHandler("onClientMarkerHit", fillMarker, startFuelDeliver)
                            exports.GTIhud:dm("Your tank is out of fuel, you have to refill it in order to continue", 255, 0, 0)
                            created = true
                        else        
                            setTimer(myMumIsAwesome, 10000, 1, player) 
                        end
                    elseif (division == "Weapon Supplier" and model == 428) then             
                        local health = getElementHealth(veh)
                        if (health > 500) then
                            outputDebugString(distance)
                            toggleControl("accelerate", false)
                            toggleControl("brake_reverse", false)
                            toggleControl("handbrake", false)
                            toggleControl("enter_exit", false)
                            setControlState("handbrake", true)
                            removeEventHandler("onClientMarkerHit", delMarker, completeMission)
                            destroyElement(delMarker)
                            destroyElement(delBlip)
                            hasOrder = false
                            outputDebugString("512")
                            setElementData(player, "GTItrucker.HasOrder", false)
                            triggerServerEvent("GTItrucker.completeDelivery", player, veh, distance)
                            setTimer( startNextMission, 4000, 1, player, veh )
                        else
                            exports.GTIhud:dm("Your goods are too damaged to be delivered. To deliver, repair your vehicle first", 255, 0, 0)
                        end    
                    end    
                else
                    exports.GTIhud:dm("Your speed is too high, slow down to 20 kph to deliver.", 255, 0, 0)
                end
            end
        end
    end
end


function EnableGhost(player)
    if (player == localPlayer) then
        local v = getPedOccupiedVehicle(localPlayer)
        for index,vehicle in ipairs(getElementsByType("vehicle")) do 
            setElementCollidableWith(vehicle, v, false)
        end    
    end
end  
addEvent("GTItrucker.setGhostOn", true)
addEventHandler("GTItrucker.setGhostOn", root, EnableGhost)  

--[[function DisableGhost(player)
    if (player == localPlayer) then
        local v = getPedOccupiedVehicle(localPlayer)
        for index,vehicle in ipairs(getElementsByType("vehicle")) do 
            setElementCollidableWith(vehicle, v, true)
        end    
    end
end 
addEvent("GTItrucker.setGhostOff", true)
addEventHandler("GTItrucker.setGhostOff", root, EnableGhost)]]--

function DisableGhost(player)
    for i, vehicle in ipairs( getElementsByType( "vehicle")) do
        if getVehicleController( vehicle) and getVehicleController( vehicle) == player then
            setElementCollidableWith( vehicle, getPedOccupiedVehicle( getVehicleController( vehicle)), true)
        end
    end
end  
