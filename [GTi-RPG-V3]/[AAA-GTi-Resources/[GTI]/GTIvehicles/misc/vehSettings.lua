----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 03 Jan 2014
-- Resource: GTIvehicles/vehSettings.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Mileage Info
---------------->>

local lastX, lastY
function updateMileage()
	if (not isPedInVehicle(localPlayer)) then return end
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (getVehicleController(vehicle) ~= localPlayer) then return end
	if (not lastX) then
		lastX, lastY = getElementPosition(vehicle)
		return
	end
	local x,y = getElementPosition(vehicle)
	local distance = getDistanceBetweenPoints2D(lastX,lastY, x,y)
	local mileage = getElementData(vehicle, "mileage") or 0
	setElementData(vehicle, "mileage", math.floor(mileage+distance))
	lastX, lastY = x,y
end

local mileTimer
function setTimerOnEnter(player, seat)
	if (player ~= localPlayer or seat ~= 0) then return end
	if (isTimer(mileTimer)) then killTimer(mileTimer) mileTimer = nil end
	mileTimer = setTimer(updateMileage, 5000, 0)
end
addEventHandler("onClientVehicleEnter", root, setTimerOnEnter)

local mileTimer
function killTimerOnExit(player, seat)
	if (player ~= localPlayer or seat ~= 0) then return end
	if (isTimer(mileTimer)) then killTimer(mileTimer) mileTimer = nil end
end
addEventHandler("onClientVehicleExit", root, killTimerOnExit)