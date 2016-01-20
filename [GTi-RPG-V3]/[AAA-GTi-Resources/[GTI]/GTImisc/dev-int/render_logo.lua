local texture
addEventHandler("onClientResourceStart", root, function()
	texture = dxCreateTexture("dev-int/logo.png")
	addEventHandler("onClientPreRender", root, render)
end)

function render()
	if (not texture) then return end
	if (getElementDimension(localPlayer) ~= 172) then return end
    dxDrawImage3D(-2732.418, 315.540, 40.355, 0, 6, texture, tocolor(255,255,255,255), 0, -2732.418, 315.540, 41.255)
end

local white = tocolor(255,255,255,255)
function dxDrawImage3D(x,y,z,w,h,m,c,r,...)
        local lx, ly, lz = x+w, y+h, (z+tonumber(r or 0)) or z
	return dxDrawMaterialLine3D(x,y,z, lx, ly, lz, m, h, c or white, ...)
end