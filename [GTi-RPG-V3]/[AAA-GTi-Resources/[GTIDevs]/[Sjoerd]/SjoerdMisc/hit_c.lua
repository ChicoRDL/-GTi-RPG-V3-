local screenX, screenY
local drawTimer
local isDrawing
local sound

--[[ function drawHitMarker()
    dxDrawImage(screenX-16, screenY-16, 32, 32, "hitmarker.png")

end]]

function fireFunc(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
    if hitElement then
            if getElementType(hitElement)=="player" or getElementType(hitElement)=="ped" or getElementType(hitElement)=="vehicle" then
        screenX, screenY = getScreenFromWorldPosition(hitX, hitY, hitZ)
        if not screenX then return end
        if isDrawing then return end


        local sound = playSound("hitmarker-sound.wav")
        setSoundVolume( sound , 1)


        addEventHandler("onClientRender", root, drawHitMarker)
        if drawTimer and isTimer(drawTimer) then
            killTimer(drawTimer)
        end


        --[[drawTimer = setTimer(function()
            isDrawing = false
            removeEventHandler("onClientRender", root, drawHitMarker)
        end, 500, 1)
		isDrawing = true
    end]]--
    end
end--func
addEventHandler("onClientPlayerWeaponFire", localPlayer, fireFunc)



