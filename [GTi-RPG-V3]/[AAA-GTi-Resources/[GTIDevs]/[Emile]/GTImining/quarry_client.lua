local vehicles = {--max grams,throw?,atty,attz
[573] =  {12000,true,-4.4,-1.5},--dune
[455] = {7000,false,-5,-1.5},
[406] = {17000,true,-6,-2},--dumper
}
local rocks = {} --Small rocks that are spawned after hitting the bigger rock
local miningRocks = {} --Big rocks
local bigRockID = 897
local collisionFixID = 2935
local centerX,centerY = 576.457, 873.753--center of the mine
local smallRockID = {905,2936,3930}
local miningAreas = { --"Big" mining rock locations
    { 485.5996, 794.2998, -20.5, 0, 0, 93.99},
    { 503.5996, 780.2998, -21.3, 0, 0, 299.991},
    { 540.5, 770.7998, -21.3, 0, 0, 249.987},
    { 572.2002, 758.7998, -16.8, 0, 0, 179.982},
    { 608.5996, 743.2998, -15, 0, 0, 239.982},
    { 631.5996, 737.7002, -11.3, 0, 0, 259.986},
    { 578.5996, 787.7998, -28.1, 0, 0, 219.982},
    { 608, 775.5, -30.4, 0, 0, 259.986},
    { 651.2002, 767.5, -29.9, 0, 0, 273.986},
    { 701.2998, 785.7998, -29.9, 0, 0, 303.986},
    { 726, 826.7998, -31.4, 0, 0, 333.981},
    { 699.7998, 766.5, -20.1, 0, 0, 263.986},
    { 732.9004, 786.7002, -17.4, 0, 0, 333.986},
    { 749.0996, 822.5, -17.6, 0, 0, 11.981},
    { 749.2002, 848.2002, -17.9, 0, 0, 281.976},
    { 729.7998, 924.2002, -18.4, 0, 0, 1.976},
    { 714.2998, 947.9004, -18.4, 0, 0, 31.976},
    { 769.4004, 844, -8, 0, 0, 301.976},
    { 765.2002, 817.9004, -6.8, 0, 0, 311.976},
    { 784.7998, 793, 1, 0, 0, 281.976},
    { 775.0996, 769.4004, 1, 0, 0, 341.976},
    { 786.7998, 876.5996, 0.7, 0, 0, 301.976},
    { 781.7998, 903, 0.7, 0, 0, 291.976},
    { 768, 936.2998, 5.9, 0, 0, 321.971},
    { 758.0996, 960.0996, 5.9, 0, 0, 309.975},
    { 728.9004, 991.9004, 5.9, 0, 0, 335.971},
    { 705.7002, 1005.5, 5.9, 0, 0, 345.966},
    { 678.7002, 1011.0996, 5.4, 0, 0, 27.964},
    { 638.4004, 1009.9004, 5.4, 0, 0, 37.964},
    { 596.2998, 1004.5, 5.4, 0, 0, 95.964},
    { 620.7002, 985.7998, -7.3, 37.996, 0, 105.964},
    { 655.4004, 990, -10.1, 37.991, 0, 95.953},
    { 709, 980.2998, -11.6, 37.991, 0, 65.953},
    { 727.5996, 960.9004, -6.9, 37.991, 0, 25.953},
    { 748.7, 933.6, -5.4, 339.996, 0, 215.958},
    { 633.6, 973.4, -18.3, 27.225, 311.193, 295.555},
    { 590.2002, 972.9004, -18.3, 35.343, 24.78, 80.995},
    { 546.5, 969.5, -18.3, 35.338, 24.78, 80.99},
    { 510.9004, 977, -25.5, 34.217, 330.529, 133.575},
    { 518, 1001.4004, -8.5, 34.217, 330.524, 103.57},
    { 549.5996, 1004, -5.3, 34.217, 330.524, 113.57},
    { 596, 987.4004, -7.6, 25.313, 307.266, 135.276},
    { 566.5, 953, -31.4, 27.219, 311.188, 125.554},
    { 596.9, 955, -32.4, 27.219, 311.188, 105.554},
    { 635, 959.9004, -32.4, 27.219, 311.188, 145.554},
    { 676.1, 953, -33.7, 29.435, 76.82, 313.427},
    { 707.2998, 913, -33.1, 322.259, 274.66, 335.539},
    { 675.6, 932.2, -42.3, 49.38, 130.864, 151.927},
    { 685.7, 925.9, -42.3, 52.222, 114.872, 173.676},
    { 508.2998, 824.2998, -24, 0, 0, 189.991},
    { 497.7002, 838.9004, -27, 0, 0, 239.986},
    { 462.2998, 869, -27, 0, 0, 219.986},
    { 459.2998, 891.0996, -27, 0, 0, 39.986},
    { 484.9004, 856.9004, -28.3, 0, 0, 189.986},
    { 480.9004, 901.5, -28.3, 0, 0, 149.986},
    { 494.4004, 923.2002, -29, 0, 0, 87.984},
    { 506, 942.2002, -28.5, 0, 0, 127.979},
    { 515.7002, 958.5, -23.8, 0, 0, 177.979},
    { 699.3, 935.2, -33.1, 322.256, 74.658, 335.533},
}
local ctrls ={
"sprint",
"jump",
"enter_exit",
"enter_passenger",
"fire", 
"crouch", 
"aim_weapon",
"next_weapon",
"previous_weapon",
}
grams = 0
--Load new mining rocks
function loadMiningAreas()
    --First, remove any mining rocks that are currently in the system
    unloadMiningAreas()
    cleanupElementRocks()
    
    --Now we proceed to making new mining rocks
    
    tablei = {}
    for k = 1,12 do
        local i = math.random(#miningAreas)
        if not tablei[i] then
            tablei[i] = true
            local x,y,z,rx,ry,rz = miningAreas[i][1],miningAreas[i][2],miningAreas[i][3],miningAreas[i][4],miningAreas[i][5],miningAreas[i][6]
            createMiningRock(x,y,z,rx,ry,rz)
        end
    end
end
--Delete rocks that are currently spawned
function unloadMiningAreas()
    for k,v in pairs(miningRocks) do
        if isElement(v[1]) then destroyElement(v[1]) end
        if isElement(v[2]) then destroyElement(v[2]) end
        if isElement(v[4]) then destroyElement(v[4]) end
    end
end
--Delete element rocks that are currently spawned
function cleanupElementRocks()
    for k,v in pairs(rocks) do
        if isElement(v[1]) then
            destroyElement(v[1])
            destroyElement(v[2])
        end
    end
end

--Create mining rocks
function createMiningRock(x,y,z,rx,ry,rz)
    if (x) and (y) and (z) then
        local rock = createObject(bigRockID,x,y,z,rx,ry,rz)
        local collisionFixer = createObject(collisionFixID,x,y,z)
        local attx,atty = getCenter(x,y)
        attachElements(collisionFixer,rock,attx,atty,1)
        setElementAlpha(collisionFixer,0)
        setElementCollidableWith(collisionFixer,localPlayer,false)
        local blip = createBlipAttachedTo(rock,0,1.2,55,255,0,255,0,1000)
        miningRocks[rock] = {rock,blip,0,collisionFixer}
        addEventHandler("onClientObjectDamage",rock,mine)
        addEventHandler("onClientObjectDamage",collisionFixer,mine)
    end
end

function getCenter(X,Y)
    if X < centerX then
        XOFF = 3
    else
        XOFF = -3
    end
    if Y < centerY then
        YOFF = 3
    else
        YOFF = -3
    end
    return XOFF,YOFF
end
function getRemainingRocks()
    numb = 0
    for i,v in pairs(miningRocks) do
        numb = numb + 1
    end
    return numb
end
--Small elemental rocks that are spawned when the player hits the mining rocks
function createRocks(x,y,z) --Mining rocks (which some have iron in)
    if (x) and (y) and (z) then
        cleanupElementRocks()
        --X,y,z is the central of the rocks being placed, now to create random amount of rocks
        local total = math.random(5,25)
        hasRock = true
        for i = 1,total do
            local _x,_y,_z = getPos(x,y,z)
            if _x then
            local scale,attZ = returnFloat()
            local ind = math.random(1,3)
            local rock = createObject(smallRockID[ind],x,y,z)
            setObjectScale(rock,scale)
            local col = createColSphere(x,y,z,1.5)
            attachElements(col,rock)
            setElementCollisionsEnabled(rock,false)
            addEventHandler("onClientColShapeHit",col,pickUp)
            rocks[col] = {col,rock,scale,attZ}
            moveObject(rock,500,_x,_y,_z,0,0,0)
            end
        end
    setTimer(function() hasRock = false end,500,1)--prevent bugs
    playSound("misc/rockfalls.ogg")
    end
end
function returnFloat()
    local state = math.random(1,7)
    if (state == 1) then
        return 0.4,0.35
    elseif (state == 2) then
        return 0.5,0.3
    elseif (state == 3) then
        return 0.6,0.25
    elseif (state == 4) then
        return 0.7,0.15
    elseif (state == 5) then
        return 0.8,0.07
    elseif (state == 6) then
        return 0.9,0.05
    elseif (state == 7) then
        return 1,0
    end
end

function getPos(x,y,z)
    for i = 1,5 do
    local state = math.random(1,4)
    if (state == 1) then
        _x,_y = x+math.random(1,6.5),y+math.random(1,6.5)
    elseif (state == 2) then
        _x,_y = x-math.random(1,6.5),y+math.random(1,6.5)
    elseif (state == 3) then
        _x,_y = x+math.random(1,6.5),y-math.random(1,6.5)
    elseif (state == 4) then
        _x,_y = x-math.random(1,6.5),y-math.random(1,6.5)
    end
    local rz = getGroundPosition(_x,_y,z)
    if rz and z-0.4 > rz and (z-rz < 1.3) and not isLineOfSightClear(_x,_y,rz,_x,_y,rz-1) and not isLineOfSightClear(_x,_y,rz,_x,_y,rz-3) then
        return _x,_y,rz+0.5
    end
    end
end

function mine(loss,attacker)
    if ( getPedWeapon(localPlayer) and getPedWeapon(localPlayer) ~= 6 ) or not isElement(source) then return end
    local theRoc = getElementAttachedTo(source) or source
    if isElement(miningRocks[theRoc][1]) and attacker == localPlayer then
        miningRocks[theRoc][3] = miningRocks[theRoc][3] + loss
        local tx,ty,tz = getElementPosition(localPlayer)
        if miningRocks[theRoc][3] > 1000 then
            if isTimer(bombtimer) or isTimer(rocktimer) then return end
            if grams > vehicles[theVehid][1] then
                exports.GTIhud:dm("Your vehicle is full. Go craft your rocks.", 255, 0, 0) 
            return end
            local numm = math.random(1,7)
            if numm == 3 then
                exports.GTIhud:dm("This rock is too hard to mine so you've planted a bomb.", 255, 0, 0) 
                triggerServerEvent("GTImining.anim", resourceRoot,5)
                local x, y, z = getElementPosition ( localPlayer )
                bomb = createObject ( 1654, x, y, z-0.9, -90, 0, 0, true )
                bombtimer = setTimer(function(theRoc,tz)
                    local mx,my,mz = getElementPosition(miningRocks[theRoc][2])
                    createExplosion(mx,my,mz,2,true,0.8,false)
                    createRocks(mx,my,tz)
                    destroyElement(bomb)
                    destroyElement(miningRocks[theRoc][2])
                    destroyElement(miningRocks[theRoc][1])
                    destroyElement(miningRocks[theRoc][4])
                    miningRocks[theRoc] = nil
                local num = getRemainingRocks()
                if (num <= 0) then
                    hasMission = false
                end
                end,7000,1,theRoc,z)
                return
            end
            createExplosion(tx,ty,tz-15,8,false,1.3,false)
            local mx,my,mz = getElementPosition(miningRocks[theRoc][2])
            createRocks(mx,my,tz)
            rocktimer = setTimer(function(theRoc)
            destroyElement(miningRocks[theRoc][2])
            destroyElement(miningRocks[theRoc][1])
            destroyElement(miningRocks[theRoc][4])
            miningRocks[theRoc] = nil
            local num = getRemainingRocks()
            if (num <= 0) then
                hasMission = false
            end
            end,100,1,theRoc)
        end
    end
end

function pickUp(hitElement,dim)
    if dim and hitElement == localPlayer and rocks[source] and not hasRock and not isPedInVehicle(localPlayer) then
        if not isElement(theVeh) then exports.GTIhud:dm("Spawn a new vehicle.", 255, 0, 0) return end
        local vx,vy,vz = getElementPosition(theVeh)
        local mx,my,mz = getElementPosition(localPlayer)
        if ( getDistanceBetweenPoints3D(vx,vy,vz,mx,my,mz) > 25 ) then exports.GTIhud:dm("Your vehicle is too far.", 255, 0, 0) return end 
        hasRock = true
        toggleAllControls(false)
        setPedWeaponSlot(localPlayer,0)
        lastCol = source
        triggerServerEvent("GTImining.anim", resourceRoot,2)
        timer5 = setTimer(function(col)
            toggleAllControls(true)
            for i,v in ipairs(ctrls) do
                toggleControl(v,false)
            end
            exports.bone_attach:attachElementToBone(rocks[col][2],localPlayer,12,0.3,0.53-rocks[col][4],0.2,0,0,0)
            triggerServerEvent("GTImining.anim", resourceRoot,1)
        end,700,1,source)
        createVehMarker()
    triggerServerEvent("GTImining.freeze", resourceRoot, true)
    end
end

function createVehMarker()
    if isElement(marker) then return end
    if theVeh then
        local x,y,z = getElementPosition(theVeh)
        marker = createMarker(x,y,z,"cylinder",1,255,255,0)
        local ay = vehicles[theVehid][3]
        local az =  vehicles[theVehid][4]
        attachElements(marker,theVeh,0,ay,az,1,0,0)
        addEventHandler("onClientMarkerHit",marker,throwing) 
    end
end
function throwing(thePlayer)
    if (thePlayer == localPlayer) and (isElement(rocks[lastCol][2])) and ( exports.bone_attach:isElementAttachedToBone(rocks[lastCol][2]) == true ) then
    triggerServerEvent("GTImining.anim", resourceRoot,4)
    for i,v in ipairs(ctrls) do
        toggleControl(v,true)
    end
    setPedFrozen(localPlayer,true)
    destroyElement(rocks[lastCol][1])
    destroyElement(source)
    timer2 = setTimer(function()
    exports.bone_attach:detachElementFromBone(rocks[lastCol][2])
    if vehicles[theVehid][2] then
        local origX, origY, origZ = getElementPosition ( rocks[lastCol][2] )
        local newZ = origZ + 3
        moveObject ( rocks[lastCol][2], 500, origX, origY, newZ )
    else
        local vehx,vehy,vehz = getElementPosition(theVeh)
        local origX, origY, origZ = getElementPosition ( rocks[lastCol][2] )
        moveObject ( rocks[lastCol][2], 300, vehx, vehy, origZ+2 )
    end
    end,550,1)
    timer1 = setTimer(function()
    hasRock = false
    if vehicles[theVehid][2] then
        local sound = playSound("misc/throw.mp3", false)
        setSoundVolume(sound, rocks[lastCol][3])
    end
    destroyElement(rocks[lastCol][2])
    local gramN = math.random(100,400)*rocks[lastCol][3]
    grams = grams + math.ceil(gramN)
    setElementData(localPlayer, "miner.grams", grams)
    triggerServerEvent("GTImining.freeze", resourceRoot, false, grams,theVehid)
    exports.GTIhud:drawStat("MinerID", "rocks", grams.." Grams", 255, 200, 0)
    rocks[lastCol] = nil
    lastCol = nil
    setPedFrozen(localPlayer,false)
    end,1000,1)
    end
    end
--Job detector
function onPlayerJobSwitch()
    local jobName = exports.GTIemployment:getPlayerJob(true)
    if (jobName == "Quarry Miner") then
        if not hasMission then return end
        if grams > 0 then
            triggerServerEvent("GTImining.remaininggrams",resourceRoot,false,grams,theVehid)
        end
        unloadMiningAreas()
        cleanupElementRocks()
        if isElement(marker) then destroyElement(marker) end
        if isElement(bomb) then destroyElement(bomb) end
        if isTimer(bombtimer) then killTimer(bombtimer) end
        if isElement(craftMarker1) then destroyElement(craftMarker1) end
        if isElement(craftMarker2) then destroyElement(craftMarker2) end
        if isElement(craftblip) then destroyElement(craftblip) end
        if isTimer(rocktimer) then killTimer(rocktimer) end
        hasRock = false
        hasMission = false
        hideTradingGUI()
        toggleAllControls(true)
        exports.GTIhud:drawStat("MinerID", "", "", 255, 200, 0)
    end
end
addEvent("onClientRentalVehicleHide",true)
addEventHandler ("onClientRentalVehicleHide", root, onPlayerJobSwitch)
addEventHandler ("onClientPlayerWasted", localPlayer, onPlayerJobSwitch)
addEventHandler ("onClientResourceStop", resourceRoot, onPlayerJobSwitch)

function onPlayerJobQuit(jobName)
    if (jobName == "Quarry Miner") then
        engineRestoreModel(337)
        if isElement(pickaxetxd) then destroyElement(pickaxetxd) end
        if not hasMission then return end
        unloadMiningAreas()
        cleanupElementRocks()
        if isElement(marker) then destroyElement(marker) end
        if isElement(craftMarker1) then destroyElement(craftMarker1) end
        if isElement(craftMarker2) then destroyElement(craftMarker2) end
        if isElement(craftblip) then destroyElement(craftblip) end
        if isElement(bomb) then destroyElement(bomb) end
        if isTimer(bombtimer) then killTimer(bombtimer) end
        if isTimer(rocktimer) then killTimer(rocktimer) end
        hasMission = false
        hasRock = false
        hideTradingGUI()
        toggleAllControls(true)
        exports.GTIhud:drawStat("MinerID", "", "", 255, 200, 0)
    end
end
addEvent("onClientPlayerQuitJob",true)
addEventHandler("onClientPlayerQuitJob",localPlayer,onPlayerJobQuit)

function onTakeJob( job )
if ( job == "Quarry Miner" ) then 
    pickaxetxd = engineLoadTXD("misc/pickaxe.txd")
    engineImportTXD(pickaxetxd, 337)
    local pickaxedff = engineLoadDFF("misc/pickaxe.dff",1)
    engineReplaceModel(pickaxedff,337)
end
end
addEventHandler ("onClientPlayerGetJob", root, onTakeJob)
addEvent("GTImining.setGrams",true)
addEventHandler("GTImining.setGrams",root,function(gram)
    grams = getElementData(localPlayer, "miner.grams") or 0
    exports.GTIhud:drawStat("MinerID", "rocks", grams.." Grams", 255, 200, 0)
end)


addEvent("GTImining.triggerMission",true)
addEventHandler("GTImining.triggerMission",root,function(veh,id)
    if not ( veh == theVeh ) then 
        theVehid = id
        theVeh = veh 
    end
    if hasMission and (getRemainingRocks() > 0) then return end
    hasMission = true
    theVeh = veh
    addEventHandler("onClientVehicleExplode", theVeh, onPlayerJobSwitch)
    loadMiningAreas()
    exports.GTIhud:drawStat("MinerID", "rocks", grams.." Grams", 255, 200, 0)
    triggerServerEvent("GTImining.remaininggrams",resourceRoot,true,veh,id)
    if isElement(craftMarker1) then return end
    craftMarker1 = createMarker(330.786, 902.191, 23.224, "cylinder",4,255,255,0)
    addEventHandler("onClientMarkerHit",craftMarker1,showGUI) 
    craftblip = createBlipAttachedTo(craftMarker1,41)
    craftMarker2 = createMarker(377.438, 887.997, 19.397, "cylinder",4,255,255,0)
    addEventHandler("onClientMarkerHit",craftMarker2,showGUI)
end)

function getGrams()
    return grams
end
function noGram()
    grams = 0
    setElementData(localPlayer, "miner.grams", 0)
    local vehid = getElementModel(getPedOccupiedVehicle(localPlayer))
    triggerServerEvent("GTImining.remaininggrams",resourceRoot,false,0,vehid)
    exports.GTIhud:drawStat("MinerID", "rocks", grams.." Grams", 255, 200, 0)
end 
function showGUI(theElement)
    if getPedOccupiedVehicle(localPlayer) and (theElement == getVehicleController(getPedOccupiedVehicle(localPlayer))) and (grams > 0) then
        if getPedOccupiedVehicle(localPlayer) ~= theVeh then return end
        triggerServerEvent("GTImining.freeze", resourceRoot, true)
        toggleAllControls(false,true,false)
        showTradingGUI()
        if isElement(craftblip) then destroyElement(craftblip) end
    end
end