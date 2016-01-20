local detections = 0

function hideBugCheck()
    if (getElementHealth(localPlayer) < 0.05) then return end
    if (isPedInVehicle(localPlayer)) then return end
    if (getPedAnimation(localPlayer)) then return end
    local task = getPedSimplestTask(localPlayer)
    if (task == "TASK_SIMPLE_CAR_GET_IN") then return end
    if (task == "TASK_SIMPLE_CAR_OPEN_DOOR_FROM_OUTSIDE") then return end
    if (task == "TASK_SIMPLE_IN_AIR") then return end
    if (task == "TASK_SIMPLE_FALL") then return end
    if (task == "TASK_SIMPLE_NAMED_ANIM") then return end
    local x, y, z = getElementPosition(localPlayer)
    if (not processLineOfSight(x, y, z - 1, x, y, z + 1)) then
        detections = detections + 1
        if (detections == 5) then
            local model = getElementModel(localPlayer)
            model = model + 1
            if (model > 312) then
                model = 1
            end
            setElementModel(localPlayer, model)
            
            exports.GTIhud:dm("You are bugged, changing your skin...", 255, 255, 0)
            outputChatBox(getPedSimplestTask(localPlayer))
            detections = 0
        end
    else
        detections = 0
    end
end
setTimer(hideBugCheck, 3000, 0)