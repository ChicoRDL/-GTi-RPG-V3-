local nfs = false
local hybrid = false

function needForSpeedAct()
    if (not isPedInVehicle(localPlayer)) then return end
    if (nfs) then return end
    local veh = getPedOccupiedVehicle(localPlayer)
	if exports.GTIrentals:isVehicleRental(veh) then return end
    
    nfs = true
    addVehicleUpgrade(veh, 1010) -- Install the nitrous
    setVehicleNitroActivated(veh, true)
end

function needForSpeedDis()
    if (not isPedInVehicle(localPlayer)) then return end
    if (not nfs) then return end
    local veh = getPedOccupiedVehicle(localPlayer)
	if exports.GTIrentals:isVehicleRental(veh) then return end
    
    nfs = false
    removeVehicleUpgrade(veh, 1010) -- Install the nitrous
    setVehicleNitroActivated(veh, true)
end
    
function hybridNitro()
    if (not isPedInVehicle(localPlayer)) then return end
    local veh = getPedOccupiedVehicle(localPlayer)
	if exports.GTIrentals:isVehicleRental(veh) then return end
    if (hybrid) then
        hybrid = false
        setVehicleNitroActivated(veh, false)     
        removeVehicleUpgrade(veh, 1010)
    elseif (not hybrid) then
        hybrid = true    
        setVehicleNitroActivated(veh, true)     
        addVehicleUpgrade(veh, 1010)
    end
end    
    
    
    
function bindTheKey(veh, seat)
    if (seat == 0) then 
        if (source ~= localPlayer) then return end 
        if (not isElement(source)) then return end
        if (getElementType(source) ~= "player") then return end
        
        local nosType = getElementData(veh, "nosType") 
        if (not nosType) then return end
        if (nosType == "nfs") then
            bindKey("mouse1", "down", needForSpeedAct)
            bindKey("mouse1", "up", needForSpeedDis)
            bindKey("lctrl", "down", needForSpeedAct)
            bindKey("lctrl", "up", needForSpeedDis)
        elseif (nosType == "hybrid") then
            bindKey("mouse1", "down", hybridNitro) 
			bindKey("lctrl", "down", hybridNitro)
        elseif (nosType == "default") then
            local hasNOS = getVehicleUpgradeOnSlot(veh, 8)
            if (not hasNOS) then
                addVehicleUpgrade(veh, 1010)
            end    
        end    
    end    
end
addEventHandler("onClientPlayerVehicleEnter", root, bindTheKey)    

function unbindTheKey(veh, seat)
    if (seat == 0) then 
        if (source ~= localPlayer) then return end
        if (not isElement(source)) then return end
        if (getElementType(source) ~= "player") then return end
        
        local nosType = getElementData(veh, "nosType") 
        if (not nosType) then return end
        if (nosType == "nfs") then
            unbindKey("mouse1", "down", needForSpeedAct)
            unbindKey("mouse1", "up", needForSpeedDis)
			unbindKey("lctrl", "down", needForSpeedAct)
            unbindKey("lctrl", "up", needForSpeedDis)
        elseif (nosType == "hybrid") then
            unbindKey("mouse1", "down", hybridNitro) 
			unbindKey("lctrl", "down", hybridNitro)
        elseif (nosType == "default") then
            local hasNOS = getVehicleUpgradeOnSlot(veh, 8)
            if (not hasNOS) then
                removeVehicleUpgrade(veh, 1010)
            end    
        end    
    end    
end
addEventHandler("onClientPlayerVehicleExit", root, unbindTheKey)    

local priceTable = {
 { nType = "nfs", price = 20000 },
 { nType = "hybrid", price = 15000 },
 { nType = "default", price = 10000 },
 }
    
 function getNitrousCost(type)
    if (not type) then return false end
    for ind, ent in ipairs(priceTable) do
        if (ent.nType == type) then
            return ent.price
        end
    end
end    
    
  

function purchaseNitrous(cmd, nitro, nType) 
    if (not isElement(localPlayer)) then return end
    if (not isPedInVehicle(localPlayer)) then exports.GTIhud:dm("Nitro: You must be in a vehicle in order to use this feature", 255, 0, 0 ) return end
    if (not nitro) then exports.GTIhud:dm("Syntax: /vehupgrade nitro default/hybrid/nfs", 255, 0, 0) return end
	if (nitro ~= "nitro") then exports.GTIhud:dm("Syntax: /vehupgrade nitro default/hybrid/nfs", 255, 0, 0) return end
    if (not getNitrousCost(nType)) then exports.GTIhud:dm("Syntax: /vehupgrade nitro default/hybrid/nfs", 255, 0, 0) return end
    
    local veh = getPedOccupiedVehicle(localPlayer)
	if (getVehicleController(veh) ~= localPlayer) then exports.GTIhud:dm("Nitro: You can't use this feature as passenger", 255, 0, 0) return end

    local owner = getElementData(veh, "owner")
    local acc = getElementData(localPlayer, "accountName") or "N/A"  
    if (owner ~= acc) then exports.GTIhud:dm("Nitro: You don't own this vehicle", 255, 0, 0) return end
    
    
    local cost = getNitrousCost(nType)
    local cash = getPlayerMoney(localPlayer)
    
    if (cost > cash) then exports.GTIhud:dm("Nitro: You can't afford this feature", 255, 0, 0 ) return end
    
    triggerServerEvent("GTInitro.confirmPurchase", localPlayer, nType, cost, veh)
end
addCommandHandler("vehupgrade", purchaseNitrous)    

function bindAfterPurchase(veh, player, nType, oldN)
    if (not isElement(player)) then return end
    if (player ~= localPlayer) then return end
    if (getElementType(player) ~= "player") then return end
    
    if (oldN == "nfs") then
        unbindKey("mouse1", "down", needForSpeedAct)
        unbindKey("mouse1", "up", needForSpeedDis)
		unbindKey("lctrl", "down", needForSpeedAct)
        unbindKey("lctrl", "up", needForSpeedDis)
    elseif (oldN == "hybrid") then
        unbindKey("mouse1", "down", hybridNitro)
		unbindKey("lctrl", "down", hybridNitro)
    end    
        
    local nosType = getElementData(veh, "nosType")
    if (nosType == "nfs") then
        bindKey("mouse1", "down", needForSpeedAct)
        bindKey("mouse1", "up", needForSpeedDis)
		bindKey("lctrl", "down", needForSpeedAct)
        bindKey("lctrl", "up", needForSpeedDis)
    elseif (nosType == "hybrid") then
        bindKey("mouse1", "down", hybridNitro) 
		bindKey("lctrl", "down", hybridNitro)
    elseif (nosType == "default") then
        local hasNOS = getVehicleUpgradeOnSlot(veh, 8)
        if (not hasNOS) then
            addVehicleUpgrade(veh, 1010)
        end    
    end     
end
addEvent("GTInitro.setTheBinds", true)
addEventHandler("GTInitro.setTheBinds", root, bindAfterPurchase)

