local antiSpam

function getVehicleOwner(target)
    if (isTimer(antiSpam)) then return end
    if (not (isElement(target) and getElementType(target) == "vehicle" and getKeyState ("mouse2"))) then return end
    triggerServerEvent("onPlayerAimsAtVehicle", localPlayer, target)
    antiSpam = setTimer(function() end, 2000, 1)
end
addEventHandler("onClientPlayerTarget", localPlayer, getVehicleOwner)

function getVehicleOwner2()
    if (isTimer(antiSpam)) then return end
    local target = getPedTarget(localPlayer)
    if (not (isElement(target) and getElementType(target) == "vehicle")) then return end
    triggerServerEvent("onPlayerAimsAtVehicle", localPlayer, target)
    antiSpam = setTimer(function() end, 2000, 1)
end
bindKey("mouse2", "down", getVehicleOwner2)

function showVehicleOwner(vehicle, owner)
    if (not (isElement(vehicle) and getPedTarget(localPlayer) == vehicle and getKeyState ("mouse2"))) then return end
    outputChatBox("Vehicle Owner: #FFFFFF"..owner, 125, 125, 0, true) 
end
addEvent("onVehicleOwnerFound", true)
addEventHandler("onVehicleOwnerFound", localPlayer, showVehicleOwner)