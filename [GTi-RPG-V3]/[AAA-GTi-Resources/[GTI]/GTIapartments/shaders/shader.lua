----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 27 Dec 2015
-- Resource: GTIapartments/shaders/shader.lua
-- Type: Client Side
-- Author: Ares
----------------------------------------->>
local PREVIEW_SHADER = {}
local SHADER_PATH = "/shaders/shader.fx"
local Ints = { [1] = {'size', {'mp_shop_floor2', 'greyground256', 'cl_of_wltep'}} }

function set_preview_shader (table, object)
	if ( not isElement(object) or type(table) ~= "table" ) then return end
	
	if ( #table == 0 ) then
		if ( isElement(shaderElement) and isElement(textureElement) ) then
			destroyElement(shaderElement)
			destroyElement(textureElement)
		end
	else
		local textureName, filepath = unpack(table)
		
		shaderElement = dxCreateShader(SHADER_PATH, 0, 0, false, "object")
		
		textureElement = dxCreateTexture(filepath)
		
		if ( shaderElement and textureElement ) then 
			dxSetShaderValue(shaderElement, "Tex0", textureElement)
			engineApplyShaderToWorldTexture(shaderElement, textureName, object)
		else
			exports.GTIhud:dm("Apartments: An error occured while shading objects", 255, 0, 0)
		end
	end
end