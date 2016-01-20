local Shader = dxCreateShader("Shaders/Textures/texture.fx")
	
	
function cleanCars()
	local setting = exports.GTIsettings:getSetting("cleancars")
	if setting == "Yes" then
		for _, vehicle in ipairs(getElementsByType("vehicle")) do
			engineApplyShaderToWorldTexture(Shader, "vehiclegrunge256", vehicle)
			engineApplyShaderToWorldTexture(Shader, "?emap*", vehicle)
		end
	end
end
--[[ :) 
		if setting == "No" then
			engineRemoveShaderFromWorldTexture ( Shader, "vehiclegrunge256" )
			engineRemoveShaderFromWorldTexture ( Shader, "?emap*" )
			end
		end
	end
end]]
addEventHandler ("onClientResourceStart", resourceRoot, cleanCars )

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
function ()
	local setting = exports.GTIsettings:getSetting("cleancars")
	if setting == "Yes" then
		for _, vehicle in ipairs(getElementsByType("vehicle")) do
			engineApplyShaderToWorldTexture(Shader, "vehiclegrunge256", vehicle)
			engineApplyShaderToWorldTexture(Shader, "?emap*", vehicle)
		if setting == "No" then
			engineRemoveShaderFromWorldTexture ( Shader, "vehiclegrunge256" )
			engineRemoveShaderFromWorldTexture ( Shader, "?emap*" )
			end
		end
	end
end)