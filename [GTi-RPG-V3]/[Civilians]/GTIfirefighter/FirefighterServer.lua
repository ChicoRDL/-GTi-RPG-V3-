local theFire = {}
local theVehFire = {}
firesound = 1
soundexp = 0
function flameToExtinguish(theFlame)
    for i, theFla in ipairs( theFire ) do 
        if theFlame == theFla[1] then
            destroyElement(theFla[1])
            destroyElement(theFla[2])
            destroyElement(theFla[3])
            table.remove(theFire,i)
            isTheFireExtinguished()
            firesound = firesound - soundexp
            triggerClientEvent ( getRootElement(), "GTIfirefighter.firesound", resourceRoot, firesound)
        end
    end
    for i, theVehFla in ipairs( theVehFire ) do 
        if theFlame == theVehFla[1] then
            local x,y,z = getElementPosition(theVehFla[1])
            triggerClientEvent ( getRootElement(), "GTIfirefighter.doneVeh", resourceRoot, x, y, z)
            destroyElement(theVehFla[1])
            destroyElement(theVehFla[2])
            destroyElement(theVehFla[3])
            table.remove(theVehFire,i)
        end
    end
end
addEvent("GTIfirefighter.flameToExtinguish",true)
addEventHandler("GTIfirefighter.flameToExtinguish",root,flameToExtinguish)

function createFlame(x,y,z)
    local theFlame = createPed(137,x,y,z)
    setElementAlpha(theFlame,0)
    local theFlameObject = createObject(2023,x,y,z)
    setElementCollisionsEnabled(theFlameObject, false)
    attachElements(theFlameObject,theFlame,0,0,0)
    setElementCollisionsEnabled(theFlame, false)
    setPedFrozen(theFlame,true)
    local colShape = createColSphere(x,y,z+1,2)
    addEventHandler("onColShapeHit",colShape,setPlayerFire)
    local num = table.maxn(theFire)
    theFire[num+1] = {theFlame,theFlameObject,colShape}
    triggerClientEvent ( getRootElement(), "GTIfirefighter.noVoice", resourceRoot, theFlame, theFlameObject )
end

addEvent("GTIfirefighter.createVehFlame", true)
addEventHandler("GTIfirefighter.createVehFlame", root, function(x,y,z,veh)
    if (#theVehFire < 8) and not isTimer(vehfiretimer) then
        vehfiretimer = setTimer(createTheVehFire,1000,1,x,y,z,veh)
    end
end )

function createTheVehFire(x,y,z,veh)
    local theFlame = createPed(138,x,y,z)
    setElementAlpha(theFlame,0)
    local theFlameObject = createObject(2023,x,y,z)
    setElementCollisionsEnabled(theFlameObject, false)
    attachElements(theFlameObject,theFlame,0,0,0)
    setElementCollisionsEnabled(theFlame, false)
    setPedFrozen(theFlame,true)
    local colShape = createColSphere(x,y,z+1,2)
    addEventHandler("onColShapeHit",colShape,setPlayerFire)
    local num = table.maxn(theVehFire)
    theVehFire[num+1] = {theFlame,theFlameObject,colShape}
    triggerClientEvent ( getRootElement(), "GTIfirefighter.destroyedVehMission", resourceRoot, x, y, z, veh )
    triggerClientEvent ( getRootElement(), "GTIfirefighter.noVoice", resourceRoot, theFlame, theFlameObject )
end

function setPlayerFire(thePlayer, matchingDimension)
    if not matchingDimension then return end
    if not thePlayer or not isElement(thePlayer) then return end
    if getElementType(thePlayer) == "player" and not (exports.GTIemployment:getPlayerJob(thePlayer,true) == "Firefighter") then
        setPedOnFire(thePlayer,true)
    end
end

function isTheFireExtinguished()
if (#theFire <= 0) then
       triggerClientEvent ( getRootElement(), "GTIfirefighter.doneDX", resourceRoot)
        setTimer(startMission,math.random(20000,75000),1)
        firesound = 1
        FX = false
    end
end

function startMission()
    local x,y,z = createANewMission()
    FX,FY,FZ = x,y,z
    triggerClientEvent ( getRootElement(), "GTIfirefighter.blip", resourceRoot, FX, FY, FZ, firesound )
    soundexp = 1/ #theFire
end
setTimer(startMission,4000,1)

addEvent("GTIfirefighter.whereIsTheFire", true)
addEventHandler("GTIfirefighter.whereIsTheFire", root, function()
    local ammo = getPedTotalAmmo(client,9)
    if (not ammo) or (ammo < 5) then
        giveWeapon(client, 42, 5)
    end
     for _, theVehFireM in ipairs( theVehFire ) do
         if isElement(theVehFireM[1]) then
            triggerClientEvent ( client, "GTIfirefighter.noVoice", resourceRoot, theVehFireM[1], theVehFireM[2] )
            local VX,VY,VZ = getElementPosition(theVehFireM[1])
            triggerClientEvent ( client, "GTIfirefighter.whereVehMission", resourceRoot, VX,VY,VZ )
        end 
    end
    if FX then 
        triggerClientEvent ( client, "GTIfirefighter.blip", resourceRoot, FX, FY, FZ, firesound )
        for _, theFireM in ipairs( theFire ) do
            if isElement(theFireM[1]) then
                triggerClientEvent ( client, "GTIfirefighter.noVoice", resourceRoot, theFireM[1], theFireM[2] )
            end
        end
    end
end )

addEvent("GTIfirefighter.pay", true)
addEventHandler("GTIfirefighter.pay", root, function(extin)
    local pay = exports.GTIemployment:getPlayerJobPayment(client, "Firefighter")
    local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
    local hrExp = exports.GTIemployment:getHourlyExperience()
     
    local pay = math.ceil( pay*extin )
    local Exp = math.ceil( (pay/hrPay)*hrExp )
    local pay = math.ceil( math.random( pay*1.5, pay*2 ) )
    -- 0.8, 1.2
    exports.GTIemployment:modifyPlayerJobProgress(client, "Firefighter", extin)
    exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Firefighter")
    exports.GTIemployment:givePlayerJobMoney(client, "Firefighter", pay)
end)

function removeTheWep(job, resignJob)
    if ( job == "Firefighter" ) and ( resignJob == true ) then 
        takeWeapon(source,42)
    end
end
addEventHandler ("onPlayerQuitJob", root, removeTheWep)

addEvent("GTIfirefighter.vehpay", true)
addEventHandler("GTIfirefighter.vehpay", root, function()
local pay = exports.GTIemployment:getPlayerJobPayment(client, "Firefighter")
local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
local hrExp = exports.GTIemployment:getHourlyExperience()
 
local pay = math.ceil( pay )
local Exp = math.ceil( (pay/hrPay)*hrExp*1.5 )
local pay = math.ceil( math.random( pay*2.2, pay*3.7 ) ) 
 
exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Firefighter")
exports.GTIemployment:modifyPlayerJobProgress(client, "Firefighter", 1)
exports.GTIemployment:givePlayerJobMoney(client, "Firefighter", pay)
end )
