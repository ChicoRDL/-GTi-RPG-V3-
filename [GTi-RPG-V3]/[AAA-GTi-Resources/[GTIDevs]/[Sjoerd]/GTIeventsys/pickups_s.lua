pickups = {
    ["hp"] = {},
    ["armor"] = {},
    ["vfix"] = {},
    ["vnitro"] = {},
    ["vid"] = {},
}

IDToName = {
    [1240] = "hp",
    [1242] = "armor",
    [954] = "vfix",
    [1313] = "vnitro",
    [1314] = "vid",
}

IDToCName = {
    [1240] = "HP",
    [1242] = "Armor",
    [954] = "Veh Fix",
    [1313] = "Nitro",
    [1314] = "ID Change",
}

nameToID = {
    ["hp"] = 1240,
    ["armor"] = 1242,
    ["vfix"] = 954,
    ["vnitro"] = 1313,
    ["vid"] = 1314,
}

pmarkerSize = {
    ["hp"] = 1.5,
    ["armor"] = 1.5,
    ["vfix"] = 4.5,
    ["vnitro"] = 4.5,
    ["vid"] = 4.5,
}

pickupDestroyers = {}

function command_cp(player, _, pType, ...)
    if (pickupDestroyers[getPlayerAccount(player)]) then
        outputChatBox("You can't create pickups while you're destroying them", player, 255, 0, 0)
        return
    end
    if (pType) then
    if (getElementDimension(player) == 802) then
            local id = table.concat({...}, " ")
            createEventPickup(player, pType, id)
        else
            outputChatBox("You can only use this in event dimension", player, 255, 0, 0)
        end
    end
end 
addCommandHandler("cp", command_cp, true)

function pickupDestroy(player, cmd, id)
    if (pickupDestroyers[getPlayerAccount(player)]) then
        pickupDestroyers[getPlayerAccount(player)] = nil
        outputChatBox("Pickup destroy disabled", player)
    else
        pickupDestroyers[getPlayerAccount(player)] = true
        outputChatBox("All the pickups you hit will be destroyed", player)
    end
end
addCommandHandler("dp", pickupDestroy, true)

function createEventPickup(player, pType, amount, pos, creator)
    local id = nameToID[pType]
    if (id) then
        local x, y, z, int, dim
        if (player) then
            x, y, z = getElementPosition(player)
            int = getElementInterior(player)
            dim = getElementDimension(player)
            if (id == 954) then z = z + 0.40 end
            if (id == 1313) or (id == 1314) then z = z + 0.80 end
        else
            x, y, z, dim, int = pos[1], pos[2], pos[3], pos[4], pos[5]
        end
        local index = #pickups[pType] + 1
        pickups[pType][index] = {}
        if (pType == "hp") or (pType == "armor")  then
            pickups[pType][index][3] = tonumber(amount) or 200
        end
        if (pType == "vid") then
            if (amount) then
                if (type(amount) == "string" and getVehicleModelFromName(amount)) then
                    pickups[pType][index][3] = getVehicleModelFromName(amount)
                elseif (tonumber(amount) and getVehicleNameFromModel(amount)) then
                    pickups[pType][index][3] = tonumber(amount)
                else
                    if (player) then
                        outputChatBox("Invalid vehicle name", player)
                    end
                    return false
                end
            else
                return false
            end
        end
        pickups[pType][index][1] = createPickup(x, y, z, 3, id, 0)
        setElementInterior(pickups[pType][index][1], int)
        setElementDimension(pickups[pType][index][1], dim)
        setElementData(pickups[pType][index][1], "val", amount, false)
        local acc = getPlayerAccount(player or creator)
        if (acc) then
            local accName = getAccountName(acc)
            setElementData(pickups[pType][index][1], "creator", accName, false)
        end
        pickups[pType][index][2] = createMarker(x, y, z, "cylinder", pmarkerSize[pType], 0, 0, 0, 0)
        setElementInterior(pickups[pType][index][2], int)
        setElementDimension(pickups[pType][index][2], dim)
        addEventHandler("onMarkerHit", pickups[pType][index][2], onMarkerHit)
    else
        if (player) then
            outputChatBox("Invalid pickup type", player)
        end
        return
    end
end

function onMarkerHit(hitElement, mDim)
    if (hitElement and getElementType(hitElement) == "player" and mDim and getElementInterior(hitElement) == getElementInterior(source)) then
        if (hitElement and pickupDestroyers[getPlayerAccount(hitElement)]) then
            deletePickup(source)
            outputChatBox("Pickup deleted", hitElement)
            return
        end
        local t = getTableFromMarker(source)
        if (not isElement(t[1])) then return end
        local pType = IDToName[getElementModel(t[1])]
        local veh = getPedOccupiedVehicle(hitElement)
        if (veh and getVehicleOccupant(veh) == hitElement) then else veh = nil end
        if (not heightCheck(t[1], hitElement)) then return end
        if (pType == "hp") then
            setElementHealth(hitElement, 100)
            exports.GTIhud:dm("You have been given 100 health", hitElement, 0, 255, 255)
        elseif (pType == "armor") then
            setPedArmor(hitElement, t[3])
            exports.GTIhud:dm("Your armor has been set to 100", hitElement, 0, 255, 255)
        elseif (pType == "vfix") then
            if (not veh) then return end
            fixVehicle(veh)
            exports.GTIhud:dm("Your vehicle has been fixed", hitElement, 0, 255, 255)
        elseif (pType == "vnitro") then
            if (not veh) then return end
            addVehicleUpgrade(veh, 1010)
            exports.GTIhud:dm("Your vehicle has been given nitro", hitElement, 0, 255, 255)
        elseif (pType == "vid") then
            if (not veh) then return end
            if (getElementModel(veh) ~= t[3]) then
                setElementModel(veh, t[3])
                exports.GTIhud:dm("Your vehicle has been changed to "..getVehicleNameFromModel(t[3]), hitElement, 0, 255, 255)
            end
        end
    end
end

function deletePickup(pickup)
    local t, mainTableIndex, subTableIndex = getTableFromMarker(pickup)
    if (t) then
        if (isElement(t[1])) then destroyElement(t[1]) end
        if (isElement(t[2])) then destroyElement(t[2]) end
        pickups[mainTableIndex][subTableIndex] = nil
    end
end

function destroyAllPickups()
    for k,v in pairs(pickups) do
        for i,val in pairs(v) do
            deletePickup(val[1])
        end
    end
end
addCommandHandler("dpall", destroyAllPickups, true)

function getTableFromMarker(marker)
    for k,v in pairs(pickups) do
        for i,val in pairs(v) do
            if (val[2] == marker) or (val[1] == marker) then
                return val, k, i
            end
        end
    end
end

function heightCheck(pickup, p)
    local vx, vy, vz = getElementPosition(p)
    local px, py, pz = getElementPosition(pickup)
    local range = math.floor(vz) - math.floor(pz)
    if (range > -2.5 and range < 2.5) then
        return true
    end
    return false
end

function getTableCount(t)
    local count = 0
    for k, v in pairs(t) do
        count = count + 1
    end
    return count
end