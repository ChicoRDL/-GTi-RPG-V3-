----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 01 Feb 2015
-- Resource: GTImisc/afk.lua
-- Version: 1.0
----------------------------------------->>

local s_timer	-- Timer for Movement Detection

addEvent("GTImisc.autoAFKRecordMovement", true)
addEventHandler("GTImisc.autoAFKRecordMovement", root, function(totTime)
	s_timer = setTimer(autoAFKDetectMovement, 50, totTime/50)
end)

function autoAFKDetectMovement()
	-- Analog Controls
	for i,ctrl in ipairs({"forwards", "backwards", "left", "right"}) do
		local a_state = getPedAnalogControlState(localPlayer, ctrl)
		if (a_state > 0) then
			triggerServerEvent("GTImisc.onAFKMovementDetected", resourceRoot)
			if (isTimer(s_timer)) then
				killTimer(s_timer)
				s_timer = nil
			end
		end
	end
	
	-- Key Controls
	for i,ctrl in ipairs({"forwards", "backwards", "left", "right", "jump", "crouch", "fire"}) do
		local c_state = getPedControlState(localPlayer, ctrl)
		if (c_state) then
			triggerServerEvent("GTImisc.onAFKMovementDetected", resourceRoot)
			if (isTimer(s_timer)) then
				killTimer(s_timer)
				s_timer = nil
			end
		end
	end
end
