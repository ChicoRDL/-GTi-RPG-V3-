local dis = {}

local truckerArea = createColTube(-539.837, -522.885, 24.5, 80, 20)

local paymentTable = {
 { level = 0, basicPay = 0.36 },
 { level = 1, basicPay = 0.39 },
 { level = 2, basicPay = 0.42 },
 { level = 3, basicPay = 0.45 },
 { level = 4, basicPay = 0.48 }, 
 { level = 5, basicPay = 0.51 },
 }
 
 --[[function setGhostOn(hitElement)
    if (source == truckerArea) then
        if(getElementType(hitElement) == "vehicle") then
            local player = getVehicleOccupant(hitElement)
            triggerClientEvent("GTItrucker.setGhostOff", player, player)
        end    
    end    
end
addEventHandler("onColShapeHit", root, setGhostOn) 

function setGhostOff(hitElement)
    if (source == truckerArea) then
        if(getElementType(hitElement) == "vehicle") then
            local player = getVehicleOccupant(hitElement)
            triggerClientEvent("GTItrucker.setGhostOff", player, player)
        end    
    end    
end
addEventHandler("onColShapeLeave", root, setGhostOff)]]--
 
function completeDelivery( vehicle, distance )
   --[[local payOffset = exports.GTIemployment:getPlayerJobPayment(client, "Trucker")
    local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
    local hrExp = exports.GTIemployment:getHourlyExperience()
    
    local progress = distance / 1609.34
    local progress = tonumber(string.format("%.3f", progress ))
    local pay = math.ceil( distance*payOffset )
    local Exp = math.ceil( (pay/hrPay)*hrExp  )
    
    exports.GTIemployment:modifyPlayerJobProgress(client, "Trucker", progress)
    exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Trucker")
    exports.GTIemployment:givePlayerJobMoney(client, "Trucker", pay)
    --]]
    local job = exports.GTIemployment:getPlayerJob(client, true)
    local level = exports.GTIemployment:getPlayerJobLevel(client, job)
    local payment = getTruckerPay(level)
    local basicPay = tonumber(payment)
    local deliveryPayment = math.floor(basicPay * distance)
    exports.GTIemployment:modifyPlayerJobProgress(client, job, 1)
    exports.GTIemployment:modifyPlayerEmploymentExp(client, 150, job)
    exports.GTIemployment:givePlayerJobMoney(client, job, deliveryPayment)
    exports.GTIhud:dm("You successfully delivered your goods, here's your payment: $"..deliveryPayment, client, 0, 255, 0, true)
    fadeCamera(client, false, 1)
    setTimer(fadeCamera, 3000, 1, client, true, 1)
    
    dis[client] = (dis[client] or 0) + distance
    outputConsole("* Total Distance: "..dis[client].." meters ("..string.format("%.3f", (dis[client]/1609.34)).." miles)", client)
end
addEvent("GTItrucker.completeDelivery", true)
addEventHandler("GTItrucker.completeDelivery", root, completeDelivery)

function getTruckerPay(level)
    if (not level) then return false end
    for ind, ent in ipairs(paymentTable) do
        if (ent.level == level) then
            return ent.basicPay
        end
    end
end

risk = {}
randomEvent = false
Bx = 0
By = 0
Bz = 0
function randomEvent( player, vehicle, x, y, z )
    if (randomEvent) then return end
    --local value = math.random( 2 )
    --if (value == 1) then
        outputDebugString("working")
        outputChatBox("You are transporting some goods which are in interest of some Criminal Organizations.", player, 255, 0, 0)
        outputChatBox("Do you wish to be escorted by the Police? Use /escort. (You have to wait for the Police)", player, 255, 0, 0)
        addCommandHandler("escort", requestEscort)
        
        if not risk[player] then risk[player] = {} end
        table.insert( risk[player], vehicle )
        
        randomEvent = true
        Bx = x
        By = y
        Bz = z
        --end
end
addEvent("GTItrucker.ableToRob", true)
addEventHandler("GTItrucker.ableToRob", root, randomEvent)

function requestEscort (p)
    removeEventHandler("escort")
    local veh = getPedOccupiedVehicle(p)
    local playerName = getPlayerName(p)
    setElementFrozen(veh, true)
    for i, v in pairs(getElementsByType("player")) do
        if (exports.GTIemployment:getPlayerJob(v, true) == "Police Officer") then
            local r, g, b = getPlayerNametagColor (v)
            outputChatBox("(RADIO) "..playerName..": #FFFFFFis requesting an escort! To escort use /escort.", v, r, g, b, true)
            addCommandHandler("escort", participateInEscort)
        end
    end
end    

function participateInEscort(p)
    if (started == true) then return end
    if (exports.GTIemployment:getPlayerJob(p, true) == "Police Officer") then
        for i, v in pairs(getElementsByType("player")) do
            if (risk[v]) then
                local x, y, z = getElementPosition(v)
                local marker = createMarker(x-5, y, z, "cylinder", 3, 255, 200, 0, 150)
                setElementVisibleTo(marker, root, false)
                setElementVisibleTo(marker, p, true)
                addEventHandler("onMarkerHit", root, startEscort)
            end
        end
    end
end   

function startEscort(hitElement)
    if (getElementType(hitElement) == "vehicle") then
        local player = getVehicleOccupant(hitElement)
        delMarker = createMarker(Bx, By, Bz, "cylinder", 3, 255, 200, 0, 150)   
        delBlip = createBlip(Bx, By, Bz, 51)
        setElementVisibleTo(delMarker, root, false)
        setElementVisibleTo(delMarker, player, true)
        setElementVisibleTo(delBlip, root, false)
        setElementVisibleTo(delBlip, player, true)
        addEventHandler("onClientMarkerHit", delMarker, finishEscort)
    end    
    for a, b in pairs(getElementsByType("player")) do
        if ( eventVehicles[b] ) then
            for i, veh in ipairs ( eventVehicles[b] ) do
                if (veh) then
                    setElementFrozen(veh, false)
                end
            end       
        end
    end
end


addEventHandler ( "onVehicleEnter", root,
    function ( thePlayer, seat, jacked)
    if not isElement(source) then return end
    local x,y,z = getElementPosition ( thePlayer )
    local job = getElementData( thePlayer, "job")
    local theVehicle = getElementModel( source)
    local division = exports.GTIemployment:getPlayerJobDivision(thePlayer)
    if ( job == "Trucker" and seat == 0) then
        if (division == "Car Supplier" and theVehicle == 455) then
            removePedFromVehicle(thePlayer)
            exports.GTIrentals:destroyRental(thePlayer)
            exports.GTIhud:dm("To deliver cars you need a Packer!", thePlayer, 255, 0, 0)
        elseif (division == "Bulk Transporter" and theVehicle == 443) then
            removePedFromVehicle(thePlayer)
            exports.GTIrentals:destroyRental(thePlayer)
            exports.GTIhud:dm("To transport bulk you need a Flatbed!", thePlayer, 255, 0, 0)
        elseif (division == "Petroleum Supplier" and theVehicle == 514) then
            local order = getElementData(thePlayer, "GTItrucker.HasOrder")
            if (isElement(trailer[thePlayer]) and order == false) then
                destroyElement(trailer[thePlayer])
            end
            setElementData(thePlayer, "jobDivision", division)
        end    
    end
end
)

trailer = {}


function spawnTrailer(plr, section)
    if (trailer[plr]) then return end
    local veh = getPedOccupiedVehicle(plr)
    local x, y, z = getElementPosition(veh)
    local rx, ry, rz = getElementRotation(veh)
    if (section == "petrol") then
    id = 584
    elseif (section == "Drugs") then
        id = 591
    elseif (section == "Weapons") then
        id = 435
    elseif (section == "Money") then
        id = 435
    elseif (section == "People") then
        id = 591
    elseif (section == "All") then    
        id = 435
    end    
    
    local theTrailer = createVehicle(id, -520.433, -499.849, 25.05, rx, ry, rz)
    attachTrailerToVehicle(veh, theTrailer)
    
    if not ( trailer[plr] ) then 
        trailer[plr] = {}
    end
    table.insert( trailer[plr], theTrailer )
end    
addEvent("GTItrucker.spawnTrailer", true)
addEventHandler("GTItrucker.spawnTrailer", root, spawnTrailer)


function jobDivisionChange(new, old)
    setElementData(source, "jobDivision", new)
    local job = exports.GTIemployment:getPlayerJob(source, true)
    if (job == "Trucker") then
        triggerClientEvent("GTItrucker.StopTruckDelivery", source, source)
    end    
end
addEventHandler("onPlayerJobDivisionChange", root, jobDivisionChange)

function preventCommandSpam(cmd)
    if (not trailer[source]) then return end
    if (cmd == "hide") then
        local speed = exports.GTIutil:getElementSpeed(getPedOccupiedVehicle(source), "kph")
            if (speed > 0) then return end
            for i, trailer in ipairs ( trailer[source] ) do
                    if (isElement(trailer)) then
                        destroyElement( trailer )
                        triggerClientEvent("GTItrucker.StopTruckDelivery", source, source) 
                end    
            end
        trailer[source] = false
    end
end
addEventHandler("onPlayerCommand", root, preventCommandSpam)


function destroyVeh()
    if getElementType(source) == "vehicle" then
        local owner = exports.GTIvehicles:getVehicleOwner(source)
        local job = exports.GTIemployment:getPlayerJob(owner)
        if (owner) then
            if (job == "Trucker") then
                triggerClientEvent("GTItrucker.StopTruckDelivery", owner)
            end
        end
    end           
end
addEventHandler("onElementDestroy", root, destroyVeh)

function onTrailerAttach(veh)
    local plr = getVehicleOccupant(veh)
    local job = exports.GTIemployment:getPlayerJob(plr)
    if (job == "Trucker") then
        triggerClientEvent("GTItrucker.startPetrol", plr)   
    end        
end
addEventHandler("onTrailerAttach", root, onTrailerAttach)
