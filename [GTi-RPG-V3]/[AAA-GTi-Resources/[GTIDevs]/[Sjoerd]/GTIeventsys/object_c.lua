local commonObj = { 
    {981, "Large roadblock", 0}, 
    {3578, "Yellow fence", 0}, 
    {1228, "Warning fence", 90}, 
    {1282, "Warning fence with light", 90}, 
    {1422, "Small fence", 0}, 
    {1425, "Detour ->", 0}, 
    {1459, "Barrier", 0}, 
    {3091, "Vehicles ->", 0},
    {1632, "Ramp 1", 0},
    {1633, "Ramp 2", 0},
    {1634, "Ramp 3", 0},
    {1655, "Ramp 4", 0},
    {8171, "Runway", 0},
    {10154, "Garage Door", 0},
    {980, "Airport Gate", 0},
    {3458, "Car Covering", 0},
}

local mainBinds = {"aim_weapon", "fire", "previous_weapon", "next_weapon"}
local offsetType = nil
local offsetAmount = 0.030
local totalOffsetAmount = 0


addEventHandler("onClientResourceStart", resourceRoot,
    function()
        objWin = guiCreateWindow(339, 273, 456, 254, "Object", false)
        guiWindowSetSizable(objWin, false)

        objectLabel = guiCreateLabel(26, 22, 147, 19, "Object ID:", false, objWin)
        idEdit = guiCreateEdit(26, 40, 147, 25, "", false, objWin)
        placeBtn = guiCreateButton(26, 75, 57, 25, "Place", false, objWin)
        guiSetProperty(placeBtn, "NormalTextColour", "FFAAAAAA")
        rmBtn = guiCreateButton(26, 110, 79, 39, "Remove your objects", false, objWin)
        guiSetProperty(rmBtn, "NormalTextColour", "FFAAAAAA")
        rmaBtn = guiCreateButton(26, 155, 79, 39, "Remove all objects", false, objWin)
        guiSetProperty(rmaBtn, "NormalTextColour", "FFAAAAAA")
        commonLabel = guiCreateLabel(201, 22, 147, 19, "Commonly used objects:", false, objWin)
        closeBtn = guiCreateButton(115, 110, 61, 39, "Close", false, objWin)
        guiSetProperty(closeBtn, "NormalTextColour", "FFAAAAAA")
        objectGrid = guiCreateGridList(200, 41, 246, 203, false, objWin)
	guiGridListSetSortingEnabled(objectGrid, false)
        guiSetVisible(objWin, false)   
        
        guiGridListAddColumn(objectGrid, "Name", 0.65)
        guiGridListAddColumn(objectGrid, "ID", 0.2)
        for k, v in ipairs(commonObj) do
            local row = guiGridListAddRow(objectGrid)
            guiGridListSetItemText(objectGrid, row, 1, v[2] or engineGetModelNameFromID(v[1]) or "Unknown", false, false)
            guiGridListSetItemText(objectGrid, row, 2, v[1], false, false)
        end
        
        addEventHandler("onClientGUIClick", objectGrid, setObjectID, false)
        addEventHandler("onClientGUIClick", rmBtn, removeMyObj, false)
        addEventHandler("onClientGUIClick", rmaBtn, removeAllObj, false)
        addEventHandler("onClientGUIClick", placeBtn, placetheObject, false)
        addEventHandler("onClientGUIClick", closeBtn, closeGUI, false)
        
    end
)


function closeGUI()
    guiSetVisible(objWin, false)
    showCursor(false)
end


function openGUI(thePlayer)
if (thePlayer == localPlayer) then

    local state = guiGetVisible(objWin)
    if (state == true) then
        guiSetVisible(objWin, false)
        showCursor(false)
    elseif ( state == false) then
        guiSetVisible(objWin, true)
        showCursor(true)
    end
    end
end
addEvent ("GTIevents.openobjGUI", true)
addEventHandler ("GTIevents.openobjGUI", root, openGUI)


function removeMyObj()
    triggerServerEvent("GTIevents.destroyMyObj", localPlayer)
end
addEvent("GTIevents.removemine")
addEventHandler("GTIevents.removemine", root, removeMyObj)


function removeAllObj()
    triggerServerEvent("GTIevents.destroyAllObj", localPlayer)
end
addEvent("GTIevents.removeAllObj")
addEventHandler("GTIevents.removeAllObj", root, removeAllObj)


function placetheObject()
    local id = guiGetText(idEdit)
    if (not tonumber(id)) or (id == "") then 
        outputChatBox("Invalid input!", 255, 0, 0)
        return
    end
    object = createObject(tonumber(id), 0, 0, 0, 0, 0, 0)
    setElementCollisionsEnabled(object, false)
    setElementDoubleSided(object, true)
    setElementDimension(object, getElementDimension(localPlayer))
    setElementInterior(object, getElementInterior(localPlayer))
    startPlacing()
end


function startPlacing()
    if (object) then
        guiSetEnabled(placeBtn, false)
    end
    bindKey("mouse_wheel_up", "down", rotateObject)
    bindKey("mouse_wheel_down", "down", rotateObject)
    bindKey("mouse1", "down", placeObject)
    bindKey("mouse2", "down", cancelObject)
    for i, v in pairs(mainBinds) do
        toggleControl(tostring(v), false)
    end
end


function cancelObject()
    destroyElement(object)
    unbindKey("mouse2", "down", cancelObject)
    unbindKey("mouse1", "down", placeObject)
    unbindKey("mouse_wheel_up", "down", rotateObject)
    unbindKey("mouse_wheel_down", "down", rotateObject)
    totalOffsetAmount = 0
    guiSetEnabled(placeBtn, true)
    for i, v in pairs(mainBinds) do
        toggleControl(tostring(v), true)
    end
end


function rotateObject(key)
    local x, y, z = getElementPosition(object)
    local rX, rY, rZ = getElementRotation(object)
    if (key == "mouse_wheel_up") then
        if (isElement(object)) then
            if (not getKeyState("lctrl") and not getKeyState("lshift") and not getKeyState("ralt")) then
                setElementRotation(object, rX, rY, rZ + 5)
            end
            if (getKeyState("lctrl") and not getKeyState("lshift") and not getKeyState("ralt")) then
                setElementRotation(object, rX, rY + 5, rZ)
            end
            if (getKeyState("lctrl") and getKeyState("lshift") and not getKeyState("ralt")) then
                setElementRotation(object, rX + 5, rY, rZ)
            end
            if (getKeyState("ralt") and not getKeyState("lctrl") and not getKeyState("lshift")) then
                setElementPosition(object, x, y, z + 0.1)
            end 
        end
    elseif (key == "mouse_wheel_down") then
        if (not getKeyState("lctrl") and not getKeyState("lshift") and not getKeyState("ralt")) then
            setElementRotation(object, rX, rY, rZ - 5)
        end
        if (getKeyState("lctrl") and not getKeyState("lshift") and not getKeyState("ralt")) then
            setElementRotation(object, rX, rY - 5, rZ)
        end
        if (getKeyState("lctrl") and getKeyState("lshift") and not getKeyState("ralt")) then
            setElementRotation(object, rX - 5, rY, rZ)
        end
        if (getKeyState("ralt") and not getKeyState("lctrl") and not getKeyState("lshift")) then
            setElementPosition(object, x, y, z - 0.1)
        end    
    end
end


function placeObject()
    if (not object) then return end
    local x, y, z = getElementPosition(object)
    local rx, ry, rz = getElementRotation(object)
    local id = getElementModel(object)
    local dim = getElementDimension(localPlayer)
    local int = getElementInterior(localPlayer)
    if (getElementType(object) == "object") then
        triggerServerEvent("GTIevents.PlaceObject", localPlayer, id, x, y, z, rx, ry, rz, dim, int)
    end
    destroyElement(object)  
    unbindKey("mouse2", "down", cancelObject)
    unbindKey("mouse1", "down", placeObject)
    unbindKey("mouse_wheel_up", "down", rotateObject)
    unbindKey("mouse_wheel_down", "down", rotateObject)
    totalOffsetAmount = 0
    guiSetEnabled(placeBtn, true)
    for i, v in pairs(mainBinds) do
        toggleControl(tostring(v), true)
    end 
end


function noBreak(object)
    setObjectBreakable(object, false)
end
addEvent("nobreak", true)
addEventHandler("nobreak", root, noBreak)


function toggleCursor(key, state)
    if (guiGetVisible(objWin)) then
        if (state == "down") then
            showCursor(false)
        else
            showCursor(true)
        end
    end
end
bindKey("lalt", "both", toggleCursor)


function setObjectID()
    local object = guiGridListGetItemText(objectGrid, guiGridListGetSelectedItem(objectGrid), 2)
    guiSetText(idEdit, object)
end


function objectsClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedObj)
    if (guiGetVisible(objWin)) then
        if (button == "right") then
            if (state == "up") then
                if (clickedObj and isElement(clickedObj)) then
                    if (getElementType(clickedObj) == "object") then
                        for k,v in ipairs(getElementsByType("object"), resourceRoot) do
                            if (v == clickedObj) then
                                triggerServerEvent("GTIeventsys.DestroyObjs", root, clickedObj)
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

function toggleOffsets(key, state)
    if (state == "up") then
        offsetType = nil
        return
    end
    if (key == "arrow_u") then
        offsetType = "up"
    elseif (key == "arrow_d") then
        offsetType = "down"
    end
end
bindKey("arrow_u", "both", toggleOffsets)
bindKey("arrow_d", "both", toggleOffsets)


function clientPreRender()
    if (offsetType and object and isElement(object)) then
        local addition = 0
        if (getKeyState("lalt")) then
            addition = offsetAmount*100
        end
        local x, y, z = getElementPosition(object)
        if (offsetType == "up") then
            setElementPosition(object, x, y, z + offsetAmount + addition)
            totalOffsetAmount = totalOffsetAmount + offsetAmount + addition
        elseif (offsetType == "down") then
            setElementPosition(object, x, y, z - offsetAmount - addition)
            totalOffsetAmount = totalOffsetAmount - offsetAmount - addition
        end
    end
end
addEventHandler("onClientPreRender", root, clientPreRender)



function onClientRender()
    if (objWin and guiGetVisible(objWin) and not isElement(object) and isCursorShowing()) then
        local gx, gy
        local camX, camY, camZ = getCameraMatrix()
        local cursorX, cursorY, endX, endY, endZ = getCursorPosition()
        local surfaceFound, targetX, targetY, targetZ, targetElement, nx, ny, nz, material, lighting, piece, buildingId, bx, by, bz, brx, bry, brz, buildingLOD = processLineOfSight(camX, camY, camZ, endX, endY, endZ, true, true, true, true, true, true, true, true, localPlayer, true)
        if not surfaceFound then
            targetX, targetY, targetZ = endX, endY, endZ
        end
        gx, gy = getScreenFromWorldPosition(targetX, targetY, targetZ, 0, false)
        if (gx and gy) then
            if (targetElement) then
                    dxDrawText("OBJ ID: "..getElementModel(targetElement) or "Unknown", gx, gy - 20, 0, 0, tocolor(8, 0, 116, 255))
            else
                if (buildingId) then
                    dxDrawText("OBJ ID: "..buildingId, gx, gy - 20, 0, 0, tocolor(8, 0, 116, 255)) 
                end
            end
        end
    end
end
addEventHandler("onClientRender", root, onClientRender)

