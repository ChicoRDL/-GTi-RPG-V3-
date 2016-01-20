function setAccountElemData(old, new)
    local acc_name = getAccountName(getPlayerAccount(source))
    setElementData(source, "accountName", acc_name)  
end
addEventHandler("onPlayerLogin", root, setAccountElemData)


function confirmedPurchase(nType, cost, veh)
    if (isElement(client)) then
        exports.GTIbank:TPM(client, cost, "NOS: bought "..nType)
        exports.GTIhud:dm("You've succesfully upgraded your cars nitrous. (Cost: $"..cost..")", client, 225, 225, 0)
        local oldN = getElementData(veh, "nosType")
        if (not oldN) then
            local oldN = "N/A"
        end    
        setElementData(veh, "nosType", nType)
        
        local vehID = getElementData(veh, "vehicleID")
        exports.GTIvehicles:setVehicleData(vehID, "nosType", nType)
        
        triggerClientEvent("GTInitro.setTheBinds", client, veh, client, nType, oldN)
    end    
end
addEvent("GTInitro.confirmPurchase", true)
addEventHandler("GTInitro.confirmPurchase", root, confirmedPurchase)