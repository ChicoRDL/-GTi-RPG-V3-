----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

local vehicleBlipRoot = createElement("vehicleBlipRoot", "vehicleBlipRoot")

function resourceStart()
	local setting = exports.GTIsettings:getSetting("vehblips")
	if setting == "No" then 
		return 
	end
	if setting == "Yes" then
	for _, vehicle in ipairs(getElementsByType("vehicle"), root, true) do
		if vehicle ~= getPedOccupiedVehicle(localPlayer) then
			local blip = createBlipAttachedTo(vehicle, 0, 1, 150, 150, 150, 255, -10, 350)
			setElementParent(blip, vehicleBlipRoot)
			end
		end
	end
end
addEventHandler("onClientResourceStart", resourceRoot, resourceStart)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
function ( )
	local setting = exports.GTIsettings:getSetting("vehblips")
	if setting == "No" then 
		for _, blip in ipairs(getElementChildren(vehicleBlipRoot)) do
			destroyElement(blip)
		end
		return 
	end
	if setting == "Yes" then
	for _, vehicle in ipairs(getElementsByType("vehicle"), root, true) do
		if vehicle ~= getPedOccupiedVehicle(localPlayer) then
			local blip = createBlipAttachedTo(vehicle, 0, 1, 150, 150, 150, 255, -10, 350)
			setElementParent(blip, vehicleBlipRoot)
			end
		end
	end
end )