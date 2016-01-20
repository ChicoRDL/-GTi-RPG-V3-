_dxCreateTexture = dxCreateTexture
_engineApplyShaderToWorldTexture = engineApplyShaderToWorldTexture
dxCreateTexture = function (...) --[[outputConsole( table.concat({...}, ",") )]] return _dxCreateTexture('hud/marker.png') end
engineApplyShaderToWorldTexture = function (...) table_ = {...} table_[1] = '' outputConsole( table.concat(table_, ",") ) return _engineApplyShaderToWorldTexture(...) end

addCommandHandler("shader", function ()

		local x, y, z = getElementPosition(localPlayer)
		local v = createMarker( x, y, z, "cylinder", 2, 30, 125, 255, 50)
		
				
		local shaderElement = dxCreateShader ("shaders/replace.fx", 3, 0, false, "all")
		local textureElement = _dxCreateTexture ("hud/marker.png")

		if ( dxSetShaderValue ( shaderElement, "gTexture", textureElement ) ) then 
			outputDebugString("1")
		end
		if ( _engineApplyShaderToWorldTexture ( shaderElement, "cj_w_grad"))  then
			outputDebugString("2")
		end
	end
)
