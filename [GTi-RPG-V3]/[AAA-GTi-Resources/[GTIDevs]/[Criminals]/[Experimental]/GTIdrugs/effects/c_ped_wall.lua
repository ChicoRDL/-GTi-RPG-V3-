-- 
-- c_ped_wall.lua
--

-- the efect settings
local colorizePed = {1 ,0.5 ,0 ,1} -- rgba colors 
local specularPower = 2
local effectMaxDistance = 100
-- don't touch
local wallShader = {}
local PWTimerUpdate = 110
local actKey = 'o'

---------------------------------
-- Version check
---------------------------------
function isMTAUpToDate()
    local mtaVer = getVersion().sortable
    outputDebugString("MTA Version: "..tostring(mtaVer))
    if getVersion ().sortable < "1.3.1-9.04939" then 
        return false
    else
        return true
    end
end

function enablePedWall()
    pwEffectEnabled = true
    enablePedWallTimer()
end

function disablePedWall()
    pwEffectEnabled = false
    disablePedWallTimer()
end


function createWallEffectForPlayer(thisPlayer)
    if not wallShader[thisPlayer] then
    wallShader[thisPlayer] = dxCreateShader ( "effects/fx/ped_wall.fx", 1, 0, true, "ped" )
        if not wallShader then return false
        else
        dxSetShaderValue( wallShader[thisPlayer], "sColorizePed",colorizePed )
        dxSetShaderValue( wallShader[thisPlayer], "sSpecularPower",specularPower )
        engineApplyShaderToWorldTexture ( wallShader[thisPlayer], "*" , thisPlayer )
        engineRemoveShaderFromWorldTexture( wallShader[thisPlayer],"muzzle_texture*" , thisPlayer )
        if getElementAlpha(thisPlayer)==255 then setElementAlpha( thisPlayer, 254 ) end
        return true
        end
    end
end

function destroyShaderForPlayer(thisPlayer)
    if wallShader[thisPlayer] then
        engineRemoveShaderFromWorldTexture( wallShader[thisPlayer], "*" , thisPlayer)
        destroyElement(wallShader[thisPlayer])
        wallShader[thisPlayer]=nil
    end
end

function enablePedWallTimer()
    if PWenTimer then 
        return 
    end
    PWenTimer = setTimer(   function()
        if pwEffectEnabled then 
            effectOn = true
        else 
            effectOn = false            
        end
        for index,thisPlayer in ipairs(getElementsByType("player")) do
            if isElementStreamedIn(thisPlayer) and thisPlayer~=localPlayer then
                local hx,hy,hz = getElementPosition(thisPlayer)            
                local cx,cy,cz,clx,cly,clz,crz,cfov = getCameraMatrix()
                local dist = getDistanceBetweenPoints3D(cx,cy,cz,hx,hy,hz)
                local isItClear = isLineOfSightClear (cx,cy,cz, hx,hy, hz, true, false, false, true, false, true, false, thisPlayer )
                if (dist<effectMaxDistance ) and not isItClear and effectOn then 
                    createWallEffectForPlayer(thisPlayer)
                end 
                if (dist>effectMaxDistance ) or  isItClear or not effectOn then 
                    destroyShaderForPlayer(thisPlayer) 
                end
            end
            if not isElementStreamedIn(thisPlayer) then destroyShaderForPlayer(thisPlayer) end
        end
    end
    ,PWTimerUpdate,0 )
end

function disablePedWallTimer()
    if PWenTimer then
        for index,thisPlayer in ipairs(getElementsByType("player")) do
            destroyShaderForPlayer(thisPlayer)
        end
        killTimer( PWenTimer )
        PWenTimer = nil     
    end
end