local isEnabled = false

local mouseSensitivity = 0.3
local rotX, rotY = 0,0
local mouseFrameDelay = 0

function toggleCockpitView()
    local force = getElementData(localPlayer, "forceFP")
    if (force) then return end
    if ( not isEnabled ) then
        if ( isPedInVehicle( localPlayer ) ) then
            isEnabled = true
            removeEventHandler ( "onClientPreRender", root, updateCamera )
            addEventHandler ( "onClientPreRender", root, updateCamera )
            addEventHandler ( "onClientCursorMove", root, freecamMouse )
        end
    else --reset view
        isEnabled = false
        setCameraTarget ( localPlayer )
        removeEventHandler ( "onClientPreRender", root, updateCamera )
        removeEventHandler ( "onClientCursorMove", root, freecamMouse )
    end
end
addCommandHandler( "fp", toggleCockpitView )
addEvent("SjoerdMisc.toggleFp", true)
addEventHandler("SjoerdMisc.toggleFp", root, toggleCockpitView)

function vehicleExit()
    if ( source == localPlayer ) then 
        isEnabled = false
        setCameraTarget ( localPlayer )
        removeEventHandler ( "onClientRender", root, updateCamera )
        removeEventHandler ( "onClientCursorMove", root, freecamMouse )
    end
end
addEventHandler ( "onClientPlayerVehicleExit", localPlayer, vehicleExit )
addEventHandler( "onClientPlayerWasted", localPlayer, vehicleExit )

function updateCamera ()
    if ( isEnabled ) then
        if ( isPedInVehicle( localPlayer ) ) then
            local camPosX, camPosY, camPosZ = getPedBonePosition ( localPlayer, 6 )
            
            -- note the vehicle rotation
            local rx,ry,rz = getElementRotation( getPedOccupiedVehicle( localPlayer ) )
            local roll = ry
            if ( rx > 90 and rx < 270 ) then
                roll = ry - 180
            end
            local rotX = rotX - math.rad( rz )
            local rotY = rotY + math.rad( rx )
            
            --Taken from the freecam resource made by eAi
            
            local cameraAngleX = rotX
            local cameraAngleY = rotY

            local freeModeAngleZ = math.sin(cameraAngleY)
            local freeModeAngleY = math.cos(cameraAngleY) * math.cos(cameraAngleX)
            local freeModeAngleX = math.cos(cameraAngleY) * math.sin(cameraAngleX)
            
            local camTargetX = camPosX + freeModeAngleX * 100
            local camTargetY = camPosY + freeModeAngleY * 100
            local camTargetZ = camPosZ + freeModeAngleZ * 100

            local camAngleX = camPosX - camTargetX
            local camAngleY = camPosY - camTargetY
            local camAngleZ = 0 

            local angleLength = math.sqrt( camAngleX*camAngleX+camAngleY*camAngleY+camAngleZ*camAngleZ )

            local camNormalizedAngleX = camAngleX / angleLength
            local camNormalizedAngleY = camAngleY / angleLength
            local camNormalizedAngleZ = 0

            local normalAngleX = 0
            local normalAngleY = 0
            local normalAngleZ = 1

            local normalX = ( camNormalizedAngleY * normalAngleZ - camNormalizedAngleZ * normalAngleY )
            local normalY = ( camNormalizedAngleZ * normalAngleX - camNormalizedAngleX * normalAngleZ )
            local normalZ = ( camNormalizedAngleX * normalAngleY - camNormalizedAngleY * normalAngleX )

            camTargetX = camPosX + freeModeAngleX * 100
            camTargetY = camPosY + freeModeAngleY * 100
            camTargetZ = camPosZ + freeModeAngleZ * 100

            setCameraMatrix ( camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ, roll)
        end
    end
end

function freecamMouse ( cX,cY,aX,aY )
    if ( isCursorShowing() or isMTAWindowActive() ) then
        mouseFrameDelay = 5
        return
    elseif ( mouseFrameDelay > 0 ) then
        mouseFrameDelay = mouseFrameDelay - 1
        return
    end
    
    local width, height = guiGetScreenSize()
    aX = aX - width / 2 
    aY = aY - height / 2
    
    rotX = rotX + aX * mouseSensitivity * 0.01745
    rotY = rotY - aY * mouseSensitivity * 0.01745
    
    local PI = math.pi
    local pRotX, pRotY, pRotZ = getElementRotation( localPlayer )
    pRotZ = math.rad(pRotZ)
    
    if ( rotX > PI ) then
        rotX = rotX - 2 * PI
    elseif ( rotX < -PI ) then
        rotX = rotX + 2 * PI
    end
    
    if ( rotY > PI ) then
        rotY = rotY - 2 * PI
    elseif rotY < -PI then
        rotY = rotY + 2 * PI
    end
    
    if ( rotY < -PI / 2 ) then
       rotY = -PI / 2
    elseif ( rotY > PI / 2 ) then
        rotY = PI / 2
    end
end
