trailer = {}

function spawnTrailer(plr, section)
    local veh = getPedOccupiedVehicle(plr)
    local x, y, z = getElementPosition(veh)
    local rx, ry, rz = getElementRotation(veh)
    if (section == "Stolen") then
        id = 435
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
    elseif (section == "Drugs") then
        id = 591
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
    elseif (section == "Weapons") then
        id = 435
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
    elseif (section == "Money") then
        id = 435
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
    elseif (section == "People") then
        id = 591
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
    elseif (section == "All") then    
        id = 435
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
        exports.GTIpoliceWanted:chargePlayer(plr, 29)
    end    
    
    local theTrailer = createVehicle(id, x, y, z, rx, ry, rz)
    attachTrailerToVehicle(veh, theTrailer)
    setVehicleDamageProof(theTrailer, true)
    if (theTrailer) then
        for i, p in ipairs(getElementsByType("player")) do
            if (exports.GTIutil:isPlayerInTeam(p, "Law Enforcement")) then
                local distance = exports.GTIutil:getDistanceBetweenElements2D(plr, p)
                if (distance <= 500) then
                    sendMessagetoCops(plr)
                end
            end
        end
    end  
    
    if not ( trailer[plr] ) then 
        trailer[plr] = {}
    end
    table.insert( trailer[plr], theTrailer )
end    
addEvent("GTIillegalTruck.spawnTrailer", true)
addEventHandler("GTIillegalTruck.spawnTrailer", root, spawnTrailer)

function sendMessagetoCops(plr)
    if (wasSend == true) then return end
    for i, p in ipairs(getElementsByType("player")) do
        if (exports.GTIutil:isPlayerInTeam(p, "Law Enforcement")) then
            local playerName = getPlayerName(plr)
            exports.GTIhud:dm("[RADIO] A criminal who's transporting illegal goods has been spotted! Name: "..playerName, p, 30, 125, 255)
            wasSend = true
            timer = setTimer(function () wasSend = false end, 5000, 1)
        end
    end
end    


function completeDelivery( vehicle, distance, section )
    if (section == "Stolen") then
        exports.GTIcriminals:givePlayerTaskMoney(client, "Illegal Trucker", 500)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 125, "Illegal Trucker")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Illegal Trucker", 1)
    elseif (section == "Drugs") then
        exports.GTIcriminals:givePlayerTaskMoney(client, "Illegal Trucker", 2500)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 250, "Illegal Trucker")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Illegal Trucker", 1)
    elseif (section == "Weapons") then
        exports.GTIcriminals:givePlayerTaskMoney(client, "Illegal Trucker", 4000)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 425, "Illegal Trucker")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Illegal Trucker", 1)
    elseif (section == "Money") then
        exports.GTIcriminals:givePlayerTaskMoney(client, "Illegal Trucker", 5000)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 475, "Illegal Trucker")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Illegal Trucker", 1)
    elseif (section == "People") then
        exports.GTIcriminals:givePlayerTaskMoney(client, "Illegal Trucker", 8000)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 585, "Illegal Trucker")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Illegal Trucker", 1)
    elseif (section == "All") then
        exports.GTIcriminals:givePlayerTaskMoney(client, "Illegal Trucker", 10000)
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 750, "Illegal Trucker")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Illegal Trucker", 1)
    end
    if ( trailer[client] ) then
        for i, trailer in ipairs ( trailer[client] ) do
        if (isElement(trailer)) then
                destroyElement( trailer )
            end
        end
    end
end
addEvent("GTIillegaltrucker.completeDelivery", true)
addEventHandler("GTIillegaltrucker.completeDelivery", root, completeDelivery)

function preventCommandSpam(cmd)
    if (cmd == "hide") then
        if exports.GTIutil:isPlayerInTeam(source, "Criminals") then
        triggerClientEvent(source, "GTIillegaltruck.closeGUI", source) 
        local speed = exports.GTIutil:getElementSpeed(getPedOccupiedVehicle(source), "kph")
        if speed and (speed > 0) then return end
        if ( trailer[source] ) then
        triggerClientEvent(source, "GTIillegaltruck.stopMission", source) 
            for i, trailer in ipairs ( trailer[source] ) do
                if (isElement(trailer)) then
                    destroyElement( trailer )
                end
            end
             trailer[source] = false
        end
    end
    end
end
addEventHandler("onPlayerCommand", root, preventCommandSpam)


function destroyTrailer()
    if ( trailer[client] ) then
        for i, trailer in ipairs ( trailer[client] ) do
            if (isElement(trailer)) then
                destroyElement( trailer )
            end
        end
    end
end
addEvent("GTIillegaltrucker.destroyTrailer", true)    
addEventHandler("GTIillegaltrucker.destroyTrailer", root, destroyTrailer)   

    allowedCars = {
    [403] = true, -- Linerunner   
    [515] = true, -- Roadtrain  
    [514] = true, -- Tanker
    }
    
function reattachTrailer(theTruck)
    if (allowedCars[getElementModel(theTruck)]) then
	source = source
        setTimer ( attachTrailerToVehicle, 50, 1, theTruck, source) -- Reattach the truck and trailer
    end    
end
 
addEventHandler("onTrailerDetach", getRootElement(), reattachTrailer)

cooldown = {}
cooldownTimer = {}

function setCoolDownTimer(player)
    if (isElement(player)) then
        local acc2 = getPlayerAccount(player)
        local acc = getAccountName(acc2)
        cooldown[acc] = true
        cooldownTimer[acc] = setTimer(removeCooldown, 300000, 1, player, acc)
    end
end
addEvent("GTIillegaltrucker.setCooldown", true)
addEventHandler("GTIillegaltrucker.setCooldown", root, setCoolDownTimer)

function removeCooldown(player, acc)
    if (isElement(player) and cooldown[acc]) then
        cooldownTimer[acc] = nil
    end
end

cooldownonJoin = {}
cooldownQuitTimer = {}

function saveTimeonQuit()
    local acc2 = getPlayerAccount(source)
    local acc = getAccountName(acc2)
    if (isElement(source) and cooldown[acc]) then
        if (isTimer(cooldownTimer[acc])) then
            a, b, c = getTimerDetails(cooldownTimer[acc])
            killTimer(cooldownTimer[acc])
            cooldownonJoin[acc] = a
            cooldownQuitTimer[acc] = setTimer(removeCooldown2, a, 1, source, acc)
        end
    end
end  
addEventHandler("onPlayerQuit", root, saveTimeonQuit)

function removeCooldown2(player, acc) 
    if (isElement(player) and cooldown[acc]) then
        cooldownTimer[acc] = nil
        cooldownonJoin[acc] = nil
        cooldown[acc] = nil
    end
end           

function addCooldownonLogin()
    local acc2 = getPlayerAccount(source)
    local acc = getAccountName(acc2)
    if (isElement(source) and cooldown[acc]) then
    
        outputChatBox("test1", root, 255, 0, 0)
        
        if (isTimer(cooldownQuitTimer[acc])) then
            killTimer(cooldownQuitTimer[acc])
            
            outputChatBox("test2", root, 255, 0, 0)
            
        end
        for i, v in pairs(cooldownTimer) do
            if (i == acc) then
                setTimer(removeCooldown, v, 1, source, acc)
                outputChatBox("test3", root, 255, 0, 0)
                triggerClientEvent("GTIillegaltrucker.disableBtns", source, v)
            end
        end
    end
end    

function addOwner(player)
    if (isElement(source) and getElementType(source) == "vehicle") then
        local owner = exports.GTIvehicles:getVehicleOwner(source)    
        setElementData(source, "GTIillegal.owner", owner)    
    end
end
addEventHandler("onVehicleEnter", root, addOwner)    
        
            
