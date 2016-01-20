local sW, sH = guiGetScreenSize()
local resX, resY = 1600, 900

function aToR( X, Y, sX, sY)
	local xd = X/resX or X
	local yd = Y/resY or Y
	local xsd = sX/resX or sX
	local ysd = sY/resY or sY
	return xd*sW, yd*sH, xsd*sW, ysd*sH
end

_dxDrawRectangle = dxDrawRectangle
function dxDrawRectangle( x, y, w, h, color, post)
	local x, y, w, h = aToR( x, y, w, h)

	_dxDrawRectangle( x, y, w, h, color, post)
end

_dxDrawText = dxDrawText
function dxDrawText( text, x, y, w, h, color, scale, font, alignX, alignY, clip, wbreak, post, colorcode, sPP, fR, fRCX, fRCY)
	local x, y, w, h = aToR( x, y, w, h)

	_dxDrawText( text, x, y, w, h, color, (sH / resY) * scale, font, alignX, alignY, clip, wbreak, post, colorcode, sPP, fR, fRCX, fRCY)
end

_dxDrawImage = dxDrawImage
function dxDrawImage( x, y, w, h, image, rot, rotcox, rotcoy, color, post)
	local x, y, w, h = aToR( x, y, w, h)

	_dxDrawImage( x, y, w, h, image, rot, rotcox, rotcoy, color, post)
end

_dxDrawImageSection = dxDrawImageSection
function dxDrawImageSection( x, y, w, h, u, v, us, uz, image, rot, rotcox, rotcoy, color, post)
	local x, y, w, h = aToR( x, y, w, h)

	_dxDrawImageSection( x, y, w, h, u, v, us, uz, image, rot, rotcox, rotcoy, color, post)
end
