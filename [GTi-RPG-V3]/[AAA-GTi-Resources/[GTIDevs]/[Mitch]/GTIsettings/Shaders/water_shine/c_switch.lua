--
-- c_switch.lua
--

--------------------------------
-- Switch effect on or off
--------------------------------
function switchWaterShine( wsOn )
	if wsOn then
		startWaterShine()
	else
		stopWaterShine()
	end
end

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
function ()
	local setting = exports.GTIsettings:getSetting("water_shine")
		if setting == "Yes" then
			switchWaterShine(true)
		else
			switchWaterShine(false)
		end
end
)

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		local setting = exports.GTIsettings:getSetting("water_shine")
			if setting == "Yes" then
				switchWaterShine(true)
			end
	end
)
