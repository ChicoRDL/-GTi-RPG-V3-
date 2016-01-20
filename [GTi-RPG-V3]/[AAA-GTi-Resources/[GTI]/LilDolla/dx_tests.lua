--[[local screen

local white = tocolor(255,255,255,255)
function dxDrawImage3D( x, y, z, w, h, m, c, r,...)
        local lx, ly, lz = x+w, y+h, (z+tonumber(r or 0)) or z
	return dxDrawMaterialLine3D(x,y,z, lx, ly, lz, m, h, c or white, ...)
end

screen = dxCreateScreenSource ( 277, 349)

addEventHandler( "onClientRender", root,
	function()
		dxUpdateScreenSource( screen)

		local x, y, z = getElementPosition( localPlayer)

		dxDrawImage3D( 1649.868, 1834.490, 10.789, 2, 2, screen, 0, x, y, z)
	end
)
--]]
