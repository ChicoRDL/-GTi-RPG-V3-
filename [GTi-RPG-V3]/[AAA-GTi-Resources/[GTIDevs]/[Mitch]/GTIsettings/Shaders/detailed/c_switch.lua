--
-- c_switch.lua
--
--------------------------------
-- Switch effect on or off
--------------------------------
function handleOnClientSwitchDetail( bOn )
	if bOn then
		enableDetail()
	else
		disableDetail()
	end
end


addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
function ()
	local setting = exports.GTIsettings:getSetting("detailed")
		if setting == "Yes" then
			handleOnClientSwitchDetail(true)
		else
			handleOnClientSwitchDetail(false)
		end
end
)

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		local setting = exports.GTIsettings:getSetting("detailed")
			if setting == "Yes" then
				handleOnClientSwitchDetail(true)
			end
	end
)

addEventHandler( "onClientResourceStop", getResourceRootElement( getThisResource()),stopShaderResource)
