--
-- c_switch.lua
--

--------------------------------
-- Switch effect on or off
--------------------------------
function switchSkyAlt( sbaOn )
	if sbaOn then
		startShaderResource()
	else
		stopShaderResource()
	end
end

addEvent( "switchSkyAlt", true )
addEventHandler( "switchSkyAlt", resourceRoot, switchSkyAlt )

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
function ()
	local setting = exports.GTIsettings:getSetting("dynamic_sky")
		if setting == "Yes" then
			switchSkyAlt(true)
		else
			switchSkyAlt(false)
		end
end
)

addEventHandler("onClientResourceStart", resourceRoot,
	function()
		local setting = exports.GTIsettings:getSetting("dynamic_sky")
			if setting == "Yes" then
				switchSkyAlt(true)
			end
	end
)

addEventHandler( "onClientResourceStop", getResourceRootElement( getThisResource()),stopShaderResource)
