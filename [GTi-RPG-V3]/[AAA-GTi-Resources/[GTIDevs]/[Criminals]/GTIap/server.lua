
    local cGate1 = createObject(980, 1688.5123, -2481.2607, 15.328079, 0, 0, 45) -- Criminals
    local cGate2 = createObject(980, 1693.0453, -2471.4832, 15.328079, 0, 0, 265)
    local cGate3 = createObject(980, 1691.6238, -2460.4395, 15.328079, 0, 0, 110)
    
    local pGate1 = createObject(980, 1936.3000, -2483.7, 15.3, 0, 0, 180.2) -- Police
    local pGate2 = createObject(980, 1927.7, -2478.800, 15.3, 0, 0, 120)
    local pGate3 = createObject(980, 1927.7, -2468.8, 15.3, 0, 0, 60)
    
    local zoneA = createColCircle(1795.815, -2540.759, 15)
    local zoneB = createColCircle(1801.174, -2424.516, 15)
    local bomb = nil
    local marker = nil
    local plantedBomb = nil
    local bombTimer = nil
    local bombPlanted = false
    local plantedBy = nil
    local bombExploded = false
    
function createGates()
    setElementDimension(cGate1, 801)     
    setElementDimension(cGate2, 801)  
    setElementDimension(cGate3, 801)  
    setElementDimension(pGate1, 801)  
    setElementDimension(pGate2, 801)  
    setElementDimension(pGate3, 801)   
    setElementDimension(zoneA, 801)
end
addEventHandler("onResourceStart", resourceRoot, createGates)    

function startEvent()
    moveObject(cGate1, 2000, 1688.5123, -2481.2607, 0)
    moveObject(cGate2, 2000, 1693.0453, -2471.4832, 0)
    moveObject(cGate3, 2000, 1691.6238, -2460.4395, 0)
    moveObject(pGate1, 2000, 1936.3000, -2483.7, 0)
    moveObject(pGate2, 2000, 1927.7, -2478.800, 0)
    moveObject(pGate3, 2000, 1927.7, -2468.8, 0)
    bomb = createObject(1654, 1712.6042, -2451.4922, 12.871796)
    marker = createMarker(1712.6042, -2451.4922, 12.371796, "cylinder", 1.5)
    setElementDimension(marker, 801)
    setElementDimension(bomb, 801)
    addEventHandler("onMarkerHit", marker, pickupBomb)
end
addEventHandler("onCnREventStart", root, startEvent)
addCommandHandler("testEvent", startEvent)

function pickupBomb(hitElement)
    if (isElement(hitElement) and getElementType(hitElement) == "player") then
        if (isElement(bomb)) then
            destroyElement(bomb)
            destroyElement(marker)
            exports.GTIhud:dm("You are now carrying the bomb, plant it somwhere to win.", hitElement, 255, 0, 0)
            setElementData(hitElement, "hasBomb", true)
            for i, v in ipairs(getElementsByType("player")) do
                --if (exports.GTIcnr:isPlayerInCnREvent(v)) then
                if (getElementDimension(v) == 801) then
                    if (exports.GTIemployment:getPlayerJob(v, true) == "Criminal") then
                        exports.GTIhud:dm(getPlayerName(hitElement).." is now carrying the bomb, assist him in planting it.", v, 255, 0, 0)
                    end
                end
            end    
        end
    end
end    

function zoneEnter(hitElement)  
    if (isElement(hitElement) and getElementType(hitElement) == "player") then
        local hasBomb = getElementData(hitElement, "hasBomb")
        if (hasBomb) then
            exports.GTIhud:drawNote("GTIap.plantBomb", "Press [N] to plant the bomb here.", hitElement, 255, 0, 0, 5000)
            bindKey(hitElement, "N", "down", plantBomb)
            elseif (bombPlanted and exports.GTIemployment:getPlayerJob(hitElement) == "Police Officer" and isElementWithinColShape(plantedBomb, source)) then
            bindKey(hitElement, 'N', 'down', bombUnplanting)            
            exports.GTIhud:drawNote('CnR_Defuse', "Press [N] to defuse the bomb.", hitElement, 30, 125, 255, 5000)    
        end
    end    
end
addEventHandler ( "onColShapeHit", resourceRoot, zoneEnter )

function zoneLeave(hitElement)
    if (isElement(hitElement) and getElementType(hitElement) == "player") then
    local hasBomb = getElementData(hitElement, "hasBomb")
        if (hasBomb) then
            exports.GTIhud:drawNote("GTIap.plantBomb", "", hitElement, 255, 0, 0, 5000)
            unbindKey(hitElement, "N", "down", plantBomb)
        elseif (bombPlanted and exports.GTIemployment:getPlayerJob(hitElement) == "Police Officer") then
            unbindKey(hitElement, 'N', 'down', bombUnplanting)            
            exports.GTIhud:drawNote('CnR_Defuse', "", hitElement, 30, 125, 255, 5000)    
        end
    end    
end
addEventHandler ( "onColShapeLeave", resourceRoot, zoneLeave )

function plantBomb(player)
    if (isElement(player) and getElementType(player) == "player") then
        local hasBomb = getElementData(player, "hasBomb")
        if (hasBomb) then
            exports.GTIanims:setJobAnimation(player, "BOMBER", "BOM_Plant", 10000, false, false, true, false )      
            toggleAllControls(player, false)       
            setTimer(toggleAllControls, 10000, 1, player, true)     
            exports.GTIhud:drawProgressBar("CnRbombPlant", "Bomb plant progress", player, 255, 0, 0, 10000 )
            
            local x, y, z = getElementPosition(player)     
            plantedBomb = createObject( 1654, x+0.3, y, z-0.9, -90, 0, 0)
            plantedBy = player
            setElementDimension(plantedBomb, 801)
            setElementData(player, "hasBomb", false)
            bombPlanted = true
            bombTimer = setTimer(explodeBomb, 20000, 1, plantedBomb)
        end
    end
end    

function explodeBomb(bomb)
    if (isElement(bomb)) then
        local x, y, z = getElementPosition(bomb)
        createExplosion(x, y, z, 0)
        destroyElement(bomb)
        bombExploded = true
        for i, v in ipairs(getElementsByType("player")) do
            local job = exports.GTIemployment:getPlayerJob(v)
            if (exports.GTIcnr:isPlayerInCnREvent(v) and job == "Police Officer") then
                exports.GTIhud:dm("The bomb has exploded, criminals won.", v, 255, 0, 0)
            elseif (exports.GTIcnr:isPlayerInCnREvent(v) and job == "Criminal") then
                exports.GTIhud:dm("You succesfully defended the bomb, you recieved a bonus of $5000.", v, 255, 0, 0)
                exports.GTIbank:GPM(v, 5000, "CnR bonus")
                exports.GTIcriminals:modifyPlayerCriminalRep(player, 915, "CnR Robbery")        
                exports.GTIcriminals:modifyPlayerTaskProgress(player, "CnR Robbery", 1)
            end
        end
    end
end  

function bombUnplanting ( cop, _, _, colshape )  
    local ms = getTimerDetails(bombTimer)      
    if ( ms < 10000 ) then             
        unbindKey(cop, 'N', 'down', bombUnplanting)          
        exports.GTIhud:dm("It is too late! Get away from the bomb!", cop, 255, 0, 0)        
    return end      
    unbindKey(cop, 'N', 'down', bombUnplanting)      
    exports.GTIanims:setJobAnimation(cop, "BOMBER", "BOM_Plant", 10000, true, false, true, false )       
    exports.GTIhud:drawProgressBar( 'CnRbombUnplant', 'Bomb Defusing Progress', cop, 30, 125, 255, 10000 )
     
    toggleAllControls(cop, false)       
    setTimer( function ( )                    
        if ( not isPedDead(cop) ) then                                          
            exports.GTIhud:dm("You've succesfully defused the bomb.", cop, 255, 0, 0)                                      
            exports.GTIemployment:modifyPlayerEmploymentExp(cop, 667, "Police Officer")                     
            exports.GTIemployment:givePlayerJobMoney(cop, "Police Officer", 2500)                           
            toggleAllControls(cop, true)   
            
            if (isElement(plantedBomb)) then
                destroyElement(plantedBomb)
                bomb = false
            end
            
            for i, v in ipairs(getElementsByType("player")) do
                local job = exports.GTIemployment:getPlayerJob(v)
                if (exports.GTIcnr:isPlayerInCnREvent(v) and job == "Police Officer") then
                    exports.GTIhud:dm("The bomb has been defused, Law Enforcement won!", v, 255, 0, 0)
                elseif (exports.GTIcnr:isPlayerInCnREvent(v) and job == "Criminal") then
                    exports.GTIhud:dm("The bomb has been defused, you lost.", v, 255, 0, 0)
                end
            end            
        end             
    end, 7500, 1)
end  
            
            
            
local received_col = nil
local plrs = {}
local inUse = {
    plr = {}
}
           
addEventHandler( "onCnRPointEnter", root,
    function( hitElement, matchingDimension)
        if isElement( hitElement) and matchingDimension then
            if not inUse[source] then
                inUse[source] = hitElement
                bombTaker = hitElement
                inUse.plr[hitElement] = source
                received_col = source
                outputChatBox("test", hitElement)
            end
        end
    end
)
            
function isBombExploded()
    if (bombExploded) then 
        return true
    else 
        return false
    end
end
            
function getStartPoint()
    return 2193.652, 1677.128, 12.367
end    

