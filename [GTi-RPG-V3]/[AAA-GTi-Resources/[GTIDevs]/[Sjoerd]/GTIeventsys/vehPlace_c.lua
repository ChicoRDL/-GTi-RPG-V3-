local resX, resY = guiGetScreenSize()
local mainBinds = {"aim_weapon", "fire", "previous_weapon", "next_weapon"}
local offsetType = nil
local offsetAmount = 0.030
local totalOffsetAmount = 0

function createGUI()
        vehWindow = guiCreateWindow(350, 260, 292, 174, "Vehicle Window", false)
        guiWindowSetSizable(vehWindow, false)

        placeBtn = guiCreateButton(31, 135, 102, 27, "Place", false, vehWindow)
        guiSetProperty(placeBtn, "NormalTextColour", "FFAAAAAA")
        cancelBtn = guiCreateButton(143, 135, 102, 27, "Cancel", false, vehWindow)
        guiSetProperty(cancelBtn, "NormalTextColour", "FFAAAAAA")
        vehLabel = guiCreateLabel(31, 20, 102, 15, "Vehicle:", false, vehWindow)
        nameEdit = guiCreateEdit(31, 35, 229, 27, "", false, vehWindow)
        --rLabel = guiCreateLabel(31, 67, 21, 15, "R:", false, vehWindow)
        --rEdit = guiCreateEdit(30, 85, 60, 27, "", false, vehWindow)
        --gEdit = guiCreateEdit(116, 85, 60, 27, "", false, vehWindow)
        --gLabel = guiCreateLabel(116, 70, 21, 15, "G:", false, vehWindow)
        --bEdit = guiCreateEdit(200, 85, 60, 27, "", false, vehWindow)
        --bLabel = guiCreateLabel(200, 70, 21, 15, "B:", false, vehWindow)    
        guiSetVisible(vehWindow, false)
        
        addEventHandler("onClientGUIClick", placeBtn, placeVehicle, false)
        addEventHandler("onClientGUIClick", cancelBtn, hideGUI, false)
end
addEventHandler("onClientResourceStart", resourceRoot, createGUI)

function openGUI()
    if (exports.GTIutil:isPlayerInTeam(source, "Government")) then
        local state = guiGetVisible(vehWindow)
        if (state == true) then
            guiSetVisible(vehWindow, false)
            showCursor(false)
        elseif ( state == false) then
            guiSetVisible(vehWindow, true)
            showCursor(true)
        end
    end
end
addEvent ("openGUI", true)
addEventHandler ("openGUI", root, openGUI)

function hideGUI()
    guiSetVisible(vehWindow, false)
    showCursor(false)
end

function placeVehicle()
    local name = guiGetText(nameEdit)
    if (not getVehicleModelFromName(name)) then
        outputChatBox("Enter an existing vehicle name!", 255, 0, 0)
        return
    end
    object = createVehicle(tonumber(getVehicleModelFromName(name)), 0, 0, 0, 0, 0, 0)
    setElementCollisionsEnabled(object, false)
    setElementDoubleSided(object, true)
    setElementDimension(object, getElementDimension(localPlayer))
    setElementInterior(object, getElementInterior(localPlayer))
    setElementFrozen(object, true)
    setVehicleColor(object, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255)

    startPlacingCar()
end

function startPlacingCar()
    if (object) then
        guiSetEnabled(placeBtn, false)
    end
    bindKey("mouse_wheel_up", "down", rotateCar)
    bindKey("mouse_wheel_down", "down", rotateCar)
    bindKey("mouse1", "down", placeCar)
    bindKey("mouse2", "down", cancelCar)
    for i, v in pairs(mainBinds) do
        toggleControl(tostring(v), false)
    end
end

function cancelCar()
    destroyElement(object)
    unbindKey("mouse2", "down", cancelCar)
    unbindKey("mouse1", "down", placeCar)
    unbindKey("mouse_wheel_up", "down", rotateCar)
    unbindKey("mouse_wheel_down", "down", rotateCar)
    totalOffsetAmount = 0
    guiSetEnabled(placeBtn, true)
    for i, v in pairs(mainBinds) do
        toggleControl(tostring(v), true)
    end
end

function rotateCar(key)
    local rX, rY, rZ = getElementRotation(object)
    if (key == "mouse_wheel_up") then
        if (isElement( object)) then
            if (not getKeyState("lctrl") and not getKeyState("lshift")) then
                setElementRotation(object, rX, rY, rZ + 5)
            end
            if (getKeyState("lctrl") and not getKeyState("lshift")) then
                setElementRotation(object, rX, rY + 5, rZ)
            end
            if (getKeyState("lctrl") and getKeyState("lshift")) then
                setElementRotation(object, rX + 5, rY, rZ)
            end
        end
    elseif (key == "mouse_wheel_down") then
        if (not getKeyState("lctrl") and not getKeyState("lshift")) then
            setElementRotation(object, rX, rY, rZ - 5)
        end
        if (getKeyState("lctrl") and not getKeyState("lshift")) then
            setElementRotation(object, rX, rY - 5, rZ)
        end
        if (getKeyState("lctrl") and getKeyState("lshift")) then
            setElementRotation(object, rX - 5, rY, rZ)
        end
    end
end

function placeCar()
    if (not object) then return end
    local x, y, z = getElementPosition(object)
    local rx, ry, rz = getElementRotation(object)
    local id = getElementModel(object)
    local dim = getElementDimension(localPlayer)
    local int = getElementInterior(localPlayer)
    if (getElementType(object) == "vehicle" and dim ~= 0) then
        local r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4 = getVehicleColor(object, true)
        triggerServerEvent("GTIevents.spawnCar", localPlayer, id, x, y, z, rx, ry, rz, dim, int, {r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4})
    end
    
    destroyElement(object)  
    unbindKey("mouse2", "down", cancelRoadBlock)
    unbindKey("mouse1", "down", placeRoadblock)
    unbindKey("mouse_wheel_up", "down", rotateRoadBlock)
    unbindKey("mouse_wheel_down", "down", rotateRoadBlock)
    totalOffsetAmount = 0
    guiSetEnabled(placeBtn, true)
    for i, v in pairs(mainBinds) do
        toggleControl(tostring(v), true)
    end 
end

function toggleShit(key, state)
    if (guiGetVisible(vehWindow)) then
        if (state == "down") then
            showCursor(false)
        else
            showCursor(true)
        end
    end
end
bindKey("lalt", "both", toggleShit)

function objectsClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedObj)
    if (guiGetVisible(vehWindow)) then
        if (button == "right") then
            if (state == "up") then
                if (clickedObj and isElement(clickedObj)) then
                if (getElementType(clickedObj) == "vehicle") then
                    for k,v in ipairs(getElementsByType("vehicle"), resourceRoot) do
                            if (v == clickedObj) then
                                triggerServerEvent("destroySingleVehicles", root, localPlayer, true, clickedObj)
                                return
                            end
                        end
                    end
                end
            end
        end
    end
end
addEventHandler("onClientClick", root, objectsClick)

local screenX, screenY = guiGetScreenSize()
function onCursorMove(cursorX, cursorY)
    if (object and isElement(object)) then
        if (isCursorShowing()) then
            local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
            local px, py, pz = getCameraMatrix()
            local dist = getElementDistanceFromCentreOfMassToBaseOfModel(object)
            local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz, true, true, false, true, true, false, false, false)
            if (hit) then
                local px, py, pz = getElementPosition(localPlayer)
                local distance = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
                setElementPosition(object, x, y, (z + dist + totalOffsetAmount))
            end
        end
    end
end
addEventHandler("onClientCursorMove", root, onCursorMove)