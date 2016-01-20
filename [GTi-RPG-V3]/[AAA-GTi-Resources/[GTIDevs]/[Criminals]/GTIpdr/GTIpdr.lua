-- { Name, Start Time(Time till event starts| 30 default), Max Players Per Team, Interior, Dimension, Alarm Location}
settings = { "LS Police Raid", 10, 25, 3, 5, "259.938, 195.666, 1008.172"}
blip_pos = "1530.703, -1480.737, 8.500"
enter_exit_points = {
    { 238.716, 138.652, 1002.023, "3;5", "leave;law"},
    { 288.793, 167.156, 1006.172, "3;5", "leave;crim"},
    { 1519.286, -1453.627, 13.208, "0;0", "enter;crim"},
    --{ 1530.703, -1480.737, 8.500, "0;0", "enter;law"},
    { 1530.478, -1480.428, 8.500, "0;0", "enter;law"},
    { 238.716, 138.652, 1002.023, "3;5", "leave;medic"},
    { 288.793, 167.156, 1006.172, "3;5", "leave;medic"},
    { 1519.286, -1453.627, 13.208, "0;0", "enter;medic"},
    { 1519.286, -1453.627, 13.208, "0;0", "enter;medic"},
}
    --{ x, y, z, rotZ, "enter/leave;law/crim/medic"},
warps = {
    { 239.075, 147.694, 1002.023, 355, "enter;law"},
    { 245.480, 147.482, 1002.023, 355, "enter;law"},
    { 241.719, 156.767, 1002.030, 355, "enter;law"},
    { 287.839, 169.997, 1006.179, 11.010, "enter;crim"},
    { 286.837, 175.146, 1006.179, 11.010, "enter;crim"},
    { 281.043, 174.480, 1006.172, 11.010, "enter;crim"},
    { 241.719, 156.767, 1002.030, 355, "enter;medic"},
    { 287.839, 169.997, 1006.179, 11.010, "enter;medic"},
    { 1517.769, -1448.308, 12.539, 1.387, "leave;crim"},
    { 1520.964, -1447.817, 12.539, 1.387, "leave;crim"},
    { 1515.384, -1447.428, 12.539, 1.387, "leave;crim"},
    { 1531.841, -1477.277, 8.500, 1.387, "leave;law"},
    { 1534.438, -1476.686, 8.500, 1.387, "leave;law"},
    { 1537.226, -1476.057, 8.500, 1.387, "leave;law"},
    { 1515.384, -1447.428, 12.539, 1.387, "leave;medic"},
    { 1531.841, -1477.277, 8.500, 1.387, "leave;medic"},
}
points = {
    {235.733, 164.799, 1002.030},
    {290.525, 185.451, 1006.179},
    {192.091, 158.526, 1002.030},
    {257.090, 175.409, 1002.030},
}

--[[
cGate = createObject(971, 276, 189.3, 1006.5, 0, 0, 0) --gate crim
lGate = createObject(971, 239.6, 183.3, 1005.4, 0, 0, 0.25) --gate law
eGate = createObject(971, 228.7, 169.8, 1003.1, 0, 0, 0)--gate

setElementInterior( cGate, 3)
setElementInterior( lGate, 3)
setElementInterior( eGate, 3)
setElementDimension( cGate, 5)
setElementDimension( lGate, 5)
setElementDimension( eGate, 5)
--]]

objects = {
    createObject(971, 276, 189.3, 1006.5, 0, 0, 0), --gate crim
    createObject(971, 239.6, 183.3, 1005.4, 0, 0, 0.25), --gate law
    createObject(971, 228.7, 169.8, 1003.1, 0, 0, 0),--gate
    createObject(971, 228.3, 151.1, 1003.1, 0, 0, 90),--gate
    createObject(971, 239.6, 183.3, 997.3, 0, 0, 0.247),
    createObject(971, 228.3, 151.1, 997.1, 0, 0, 90),
    createObject(971, 228.3, 162, 1003.1, 0, 0, 90),
    createObject(971, 228.3, 162, 996.8, 0, 0, 90),
    createObject(971, 228.7, 169.8, 997.1, 0, 0, 0),
    createObject(971, 272.5, 179, 1006.5, 0, 0, 89.747),
    createObject(971, 272.5, 171.9, 1006.5, 0, 0, 89.742),
    createObject(971, 272.5, 171.9, 1013.6, 0, 0, 89.742),
    createObject(971, 272.5, 178.9, 1013.6, 0, 0, 89.742),
    createObject(971, 274.7, 189.3, 1001, 0, 0, 0),
    createObject(971, 294.5, 189.4, 1006.5, 0, 0, 0),
    createObject(971, 294.5, 189.4, 1000.8, 0, 0, 0),
    createObject(1501, 265, 190, 1007.172, 0, 0, 90),
    createObject(1501, 265, 193, 1007.172, 0, 0, 270),
}
for i,object in ipairs(objects) do
    setElementInterior(object, 3)
    setElementDimension(object, 5)
    setElementDoubleSided(object, true)
end
createObject(1501, 1531.2, -1481.6, 8.500, 0, 0, 180)-- law's door
function getEventDetails()
    return settings, enter_exit_points, warps, points, objects, blip_pos
end
-------script
------------------>
local objectToRobID = 1550
local objectToRobLocs ={
    {262.568, 185.089, 1007},
    {219.353, 166.255, 1002},
    {217.848, 184.037, 1002},
    {198.314, 169.101, 1002},
    {190.303, 179.083, 1002},
    {212.024, 186.298, 1002},
    {223.365, 185.463, 1002},
}
Robber = false
point = 0
function setDim(elem)
    setElementInterior(elem, 3)
    setElementDimension(elem, 5)
end
function randomloc()
    return unpack( objectToRobLocs[math.random(#objectToRobLocs)] )
end
addEvent( "onCnREventStart", true)
addEventHandler( "onCnREventStart", root, function(event)
        if event == "LS Police Raid" then
            for i = 1,3 do
                local x,y,z = getElementPosition(objects[i])
                moveObject(objects[i],2000,x,y,z+7)
            end
            setTimer(function()
                local x,y,z = getElementPosition(objects[4])
                moveObject(objects[4],2000,x,y,z+7)
            end, 6000, 1)
            point = 0
            spawnObjectToRob()
            for i,v in ipairs(getElementsByType("player")) do
                if (exports.GTIcnr:isPlayerInCnREvent(v)) then
                    exports.GTIhud:dm("Go capture bags (pink blip) and bring them back to points.", v, getPlayerNametagColor(v))
                end
            end
        end
    end
)
function spawnObjectToRob()
        if isElement(objectToRob) then return end
        if isElement(Blip) then destroyElement(Blip) end
        if isElement(objectToRobColShape) then destroyElement(objectToRobColShape) end
        if point >= 4 then return end
        local objX,objY,objZ = randomloc()
        objectToRob = createObject ( objectToRobID, objX,objY,objZ )
        setDim(objectToRob)
        setElementDoubleSided ( objectToRob, true )
        setElementCollisionsEnabled(objectToRob,false)
        Blip = createBlipAttachedTo(objectToRob,0,2,255,0,255,255,65535)
        setDim(Blip)
        objectToRobColShape = createColTube(objX,objY,objZ,1,2)
        setDim(objectToRobColShape)
        setObjectWaiting(objX,objY,objZ)
        attachElements(objectToRobColShape,objectToRob)
end
function setObjectWaiting(x,y,z)
    if isTimer(animTimer) then
        killTimer(animTimer)
        stopObject(objectToRob)
    end
    if not isElement(objectToRob) then return end
    setElementPosition(objectToRob,x,y,z+1)
    if isElement(Arrow) then destroyElement(Arrow) end
    Robber = false
    moveObject(objectToRob,3000,x,y,z+1,0,0,360)
    animTimer = setTimer(function()
    if not isElement(objectToRob) then killTimer(animTimer) return end
    moveObject(objectToRob,3000,x,y,z+1,0,0,360)
    end,3000,0)
end
addEventHandler( "onColShapeHit", root, function(thePlayer,matchingDimension)
        if matchingDimension and ( source == objectToRobColShape ) and ( getElementType ( thePlayer ) == "player" ) and not Robber then
            if exports.GTIutil:isPlayerInTeam( thePlayer, "Emergency Services") then
                return
            end
            exports.bone_attach:attachElementToBone(objectToRob,thePlayer,2,0.1,-0.2,-0.33,-10,0,180)
            Robber = thePlayer
            local x,y,z = getElementPosition(objectToRob)
            Arrow = createMarker ( x, y, z, "arrow", 0.5, getPlayerNametagColor(thePlayer) )
            setDim(Arrow)
            attachElements(Arrow,thePlayer,0,0,1.5,0,0,0)
            exports.GTIhud:dm("Now that you got the money, bring it back to a point.", thePlayer, getPlayerNametagColor(thePlayer))
            if exports.GTIutil:isPlayerInTeam(thePlayer, "Criminals") then
                for i,v in ipairs(getElementsByType("player")) do
                    if (exports.GTIcnr:isPlayerInCnREvent(v)) and exports.GTIutil:isPlayerInTeam(v, "Law Enforcement") then
                        exports.GTIhud:dm("Criminals have captured the money!", v, getPlayerNametagColor(v))
                    end
                end
            elseif exports.GTIutil:isPlayerInTeam(thePlayer, "Law Enforcement") then
                for i,v in ipairs(getElementsByType("player")) do
                    if (exports.GTIcnr:isPlayerInCnREvent(v)) and exports.GTIutil:isPlayerInTeam(v, "Criminals") then
                        exports.GTIhud:dm("Police have captured the money!", v, getPlayerNametagColor(v))
                    end
                end
            end
        end
end )
addEvent("onCnRPointEnter", true)
addEventHandler("onCnRPointEnter", root, function(hitElement, matchingDimension)
    for k,marker in ipairs(getElementsWithinColShape(source, "marker")) do
        local R, G, B, A = getMarkerColor(marker)
        if ( R == 0 and G == 0 and B == 255 ) or ( R == 255 and G == 0 and B == 0 )  then return end
    end
        if isElement(hitElement) and ( getElementType ( hitElement ) == "player" ) and matchingDimension and hitElement == Robber then
            triggerEvent( "onCnRPointCapture", source, hitElement)
            if isElement(Arrow) then destroyElement(Arrow) end
            if isElement(objectToRob) then destroyElement(objectToRob) end
            if isElement(objectToRobColShape) then destroyElement(objectToRobColShape) end
            point = point + 1
            spawnObjectToRob()
        end
    end
)
function countPlayersLeftInEvent(team)
count = 0
    for i,v in ipairs(getElementsByType("player")) do
        if (exports.GTIcnr:isPlayerInCnREvent(v)) and exports.GTIutil:isPlayerInTeam(v, team) then
            count = count + 1
        end
    end
return count
end
function onRobberWasted()
    if source == Robber then
        exports.bone_attach:detachElementFromBone(objectToRob)
        local x,y,z = getElementPosition(source)
        setObjectWaiting(x,y,z-1)
        if exports.GTIutil:isPlayerInTeam(source,"Criminals") then
            for i,v in ipairs(getElementsByType("player")) do
                if (exports.GTIcnr:isPlayerInCnREvent(v)) then
                    exports.GTIhud:dm("Criminals have lost the money!", v, getPlayerNametagColor(v))
                end
            end
        elseif exports.GTIutil:isPlayerInTeam(source,"Law Enforcement") then
            for i,v in ipairs(getElementsByType("player")) do
                if (exports.GTIcnr:isPlayerInCnREvent(v)) then
                    exports.GTIhud:dm("Police have lost the money!", v, getPlayerNametagColor(v))
                end
            end
        end
    end
end
addEventHandler( "onPlayerWasted", root, onRobberWasted)
addEventHandler( "onPlayerQuit", root, onRobberWasted)

addEvent( "onCnREventStop", true)
addEventHandler( "onCnREventStop", root, function(event)
        if event == "LS Police Raid" then
            if isElement(Arrow) then destroyElement(Arrow) end
            if isElement(objectToRob) then destroyElement(objectToRob) end
            if isElement(objectToRobColShape) then destroyElement(objectToRobColShape) end
            point = 0
            Robber = false
        end
end )
