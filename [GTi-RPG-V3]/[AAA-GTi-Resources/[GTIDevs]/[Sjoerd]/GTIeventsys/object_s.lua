function openGUI(thePlayer)
    triggerClientEvent (thePlayer, "GTIevents.openobjGUI", thePlayer, thePlayer )
end 
addCommandHandler("objects", openGUI,true)

function openGUI3(thePlayer)
    if (getAccountName(getPlayerAccount(thePlayer)) == "RedBand") then
        triggerClientEvent (thePlayer, "GTIevents.openobjGUI", thePlayer, thePlayer )
    end    
end 
addCommandHandler("object", openGUI3)

objects = {}

function spawnObject(id, x, y, z, rx, ry, rz, dim, int)
    local accName = getAccountName ( getPlayerAccount ( client ) )
        if (not id) then return end
        if (id == 1225 and dim == 0) then
            outputChatBox("You can't place an explosive barrel in the main dimension.", client, 255, 0, 0)
            return
        end
        if (id == 978) then
            z = z-1
        end
        outputChatBox(id..", "..x..", "..y..", "..z..", "..rx..", "..ry..", "..rz, client, 255, 0, 0)
        local object = createObject(tonumber(id), x, y, z, rx, ry, rz)
        setElementDoubleSided(object, true)
        setElementFrozen(object, true)
        setElementData(object, "creator", accName, false)
        objects[object] = {object, getAccountName(getPlayerAccount(client))}
        if (dim ~= 0) then
            setElementDimension(object, dim)
        end
        if (int ~= 0) then
            setElementInterior(object, int)
        end
        if (id ~= 1225) then
            triggerClientEvent(client, "nobreak", client, object)
        end
end
addEvent("GTIevents.PlaceObject", true)
addEventHandler("GTIevents.PlaceObject", root, spawnObject)


function destroyObjects()
    for k, obj in pairs(objects) do
        if (obj[2] == getAccountName(getPlayerAccount(client))) then
            if (isElement(obj[1])) then
                destroyElement(obj[1])
                obj = nil
            end
        end
    end
    exports.GTIhud:dm("Your objects have been deleted", client, 0, 255, 0)
end
addEvent("GTIevents.destroyMyObj", true)
addEventHandler("GTIevents.destroyMyObj", root, destroyObjects)


function destroyALLRoadblocks()
    for k, obj in pairs(objects) do
        if (isElement(obj[1])) then
            destroyElement(obj[1])
        end    
    end
    objects = {}
    exports.GTIhud:dm("All objects have been deleted", client, 0, 255, 0)
end
addEvent("GTIevents.destroyAllObj", true)
addEventHandler("GTIevents.destroyAllObj", root, destroyALLRoadblocks)


function destroyRoadblock(object)
    local creator, x, y, z, dim, int, id
    for k, obj in pairs(objects) do
        if (obj[1] == object) then
            x, y, z = getElementPosition(obj[1])
            dim = getElementDimension(obj[1])
            int = getElementInterior(obj[1])
            id = getElementModel(obj[1])
            destroyElement(obj[1])
            creator = obj[2]
            obj[1] = nil
        end
    end
    if (client) then
        exports.GTIhud:dm("Object Deleted", client, 0, 255, 0)
    end
end
addEvent("GTIeventsys.DestroyObjs", true)
addEventHandler("GTIeventsys.DestroyObjs", root, destroyRoadblock)


