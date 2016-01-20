--
-- c_switch.lua
--

--------------------------------------------------------------
-- Switch effect on or off
--------------------------------
function switchCarPaintReflect( cprOn )
	if cprOn then
		startCarPaintReflect()
	else
		stopCarPaintReflect()
	end
end

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
function ()
	local setting = exports.GTIsettings:getSetting("car_reflect")
		if setting == "Yes" then
			switchCarPaintReflect(true)
		else
			switchCarPaintReflect(false)
		end
end
)

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		local setting = exports.GTIsettings:getSetting("car_reflect")
			if setting == "Yes" then
				switchCarPaintReflect(true)
			end
	end
)
