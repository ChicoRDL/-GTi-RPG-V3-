function returnVehicleOwner(vehicle)
    if (not isElement(vehicle)) then return end
    local vehicleOwner = exports.GTIvehicles:getVehicleOwner(vehicle)
    if (isElement(vehicleOwner)) then
        vehicleOwner = getPlayerName(vehicleOwner)
    elseif (getElementData(vehicle, "hijack")) then
        vehicleOwner = "Hijacker vehicle"
    else
        vehicleOwner = "Unknown"
    end
    triggerClientEvent(client, "onVehicleOwnerFound", client, vehicle, vehicleOwner)
end
addEvent("onPlayerAimsAtVehicle", true)
addEventHandler("onPlayerAimsAtVehicle", root, returnVehicleOwner)

spam = {}
function displayVehicleLoss(loss)
    local player = getVehicleOccupant(source)
    local owner = exports.GTIvehicles:getVehicleOwner(source)
    if (player == owner) then return end
    if (isTimer(spam[owner])) then return end
    if (isElement(owner) and loss > 0) then
        exports.GTIhud:dm("Your car is being damaged.", owner, 255, 0, 0)
        spam[owner] = setTimer(function() spam[owner] = nil end, 30000, 1)
    end   
end 
addEventHandler("onVehicleDamage", getRootElement(), displayVehicleLoss)