----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Ares
-- Date: 7 Jul 2015
----------------------------------------->>

addEvent("GTIshaders.applyShader", true)

function applyShader ( element, table, _type)

	for index, value in pairs ( table ) do
		if ( index == 1 ) then
			model = value
		elseif ( index == 2 ) then
			textureName = value
		elseif ( index == 3 ) then
			texturePath = value
		end
	end

	local shaderElement = dxCreateShader ( "shader/shader.fx", 0, 0, false, _type == "skin" and "ped" or "vehicle" );
	local textureElement = dxCreateTexture ( _type.."/textures/"..texturePath );


	if ( shaderElement and textureElement ) then
		dxSetShaderValue ( shaderElement, "Tex0", textureElement );
		engineApplyShaderToWorldTexture ( shaderElement, textureName, element );
	end

end
addEventHandler("GTIshaders.applyShader", root, applyShader)