

local everybodyLovesCox = {{{{{ {}, {}, {} }}}}}
local cruise = false
local timer = false
local speed = 0
function togCruise()
    if (cruise) then
        local veh = getPedOccupiedVehicle(localPlayer)
        if (not veh or not isElement(veh)) then return false end
        if (not getVehicleEngineState(veh)) then
            killTimer(timer)
            cruise = false
            speed = 0
            setControlState("accelerate", false)
            return false
        end
        local v1,v2,v3 = getElementVelocity(veh)
        local currspeed = (v1^2 + v2^2 + v3^2)^(0.5)
        if (currspeed < speed) then
            setControlState("accelerate", true)
        else
            setControlState("accelerate", false)
        end
    end
end

function cruiseNow()
    local veh = getPedOccupiedVehicle(localPlayer)
    if (not veh or not isElement(veh)) then return false end
    if (getVehicleOccupant(veh, 0) ~= localPlayer or not getVehicleOccupant(veh, 0)) then
        return false
    end
    if (not getVehicleEngineState(veh)) then
        return false
    end
	if (getVehicleType(veh) == "Train" ) then
		return exports.GTIhud:dm("You can't use cruise control in trains", 255, 0, 0)
	end
    if (not cruise) then
        cruise = true
        local speedx,speedy,speedz = getElementVelocity(veh)
        speed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
        timer = setTimer(togCruise, 50, 0)
        
        local speed2 = exports.GTIutil:getElementSpeed(veh, "kph")
        local speed2 = math.floor(speed2)
        exports.GTIhud:dm("You have enabled cruise control. (Speed: "..speed2.." km/h)", 0, 255, 0)
        bindKey("s", "up", disableCruise)
    else
        exports.GTIhud:dm("You have disabled cruise control.", 0, 255, 0)
        cruise = false
        if (isTimer(timer)) then
            killTimer(timer)
        end   
        speed = 0
        setControlState("accelerate", false)
        unbindKey("s", "up", disableCruise)
    end
end
bindKey("c", "up", cruiseNow)

function disableCruise()
    exports.GTIhud:dm("You have disabled cruise control.", 0, 255, 0)
    cruise = false
    if (isTimer(timer)) then
            killTimer(timer)
        end 
    speed = 0
    setControlState("accelerate", false)
    unbindKey("s", "up", disableCruise)
end
    

function exitVeh(player)
    if (cruise and player == localPlayer) then
        cruise = false
        if (isTimer(timer)) then
            killTimer(timer)
        end 
        speed = 0
        setControlState("accelerate", false)
        unbindKey("s", "up", disableCruise)
    end
end
addEventHandler("onClientVehicleExit", root, exitVeh)

function diedVeh()
    if (cruise) then
        cruise = false
        if (isTimer(timer)) then
            killTimer(timer)
        end 
        speed = 0
        setControlState("accelerate", false)
        unbindKey("s", "up", disableCruise)
    end
end
addEventHandler("onClientPlayerWasted", localPlayer, diedVeh)

function speed2(cmd, speed3)
    speed = tonumber(speed3)
    exports.GTIhud:dm("Max speed is now: " .. speed, 0, 255, 0)
end
addCommandHandler("speed", speed2)