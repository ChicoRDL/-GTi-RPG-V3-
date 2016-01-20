sx, sy = guiGetScreenSize ( )
rSX, rSY = sx / 1280, sx / 1024

addEventHandler ( 'onClientPreRender', root, function ( )
		for ind, v in ipairs ( getElementsByType ( '3DText' ) ) do
			local continueRender = true
			local text = getElementData ( v, 'text' )
			local pos = getElementData ( v, 'position' )
			local color = getElementData ( v, 'color' )
			local parent = getElementData ( v, 'parentElement' )
			
			if ( parent ) then
				if ( isElement ( parent ) ) then
					if ( isPedInVehicle ( localPlayer ) and getElementType ( parent ) == 'vehicle' and getPedOccupiedVehicle ( localPlayer ) == parent ) then return end
					local offset = pos
					local px, py, pz = getElementPosition ( parent )
					pos = { px+offset[1], py+offset[2], pz+offset[3] }
					if ( parent == localPlayer ) then
						continueRender = false
					end
				else
					destroyElement ( v )
				end
			end
				
			
			if continueRender and text and pos and color then
				local x, y, z = unpack ( pos )
				local z = z + 1.15
				local settings = getElementData ( v, 'Settings' ) or { }
				local maxDist = settings[1] or 17
				
				if ( settings[2] ) then
					showBoarder = true
				else
					showBoarder = false
				end
				
				local px, py, pz = getElementPosition ( localPlayer )
				local _3DDist = getDistanceBetweenPoints3D ( x, y, z, px, py, pz )
				if ( _3DDist <= maxDist and isLineOfSightClear ( x, y, z, px, py, pz, true, false, false, true, false, false ) ) then
					local x, y = getScreenFromWorldPosition ( x, y, z )
					local r, g, b = unpack ( color )
					if x then
						local textSize = rSY*2
						local textSize = textSize * ( ( maxDist - _3DDist ) / maxDist )
						--local textSize = 2
						local textWidth = dxGetTextWidth(text,textSize,'default')
						local height = dxGetFontHeight ( textSize, 'default' )
						local x = x-(textWidth/2)
						if x and y and r and g and b then
							if ( showBoarder ) then 
								dxDrawRectangle ( x-6, y+1, textWidth+12, height+2, tocolor ( 0, 0, 0, 120 ) )
								dxDrawText ( tostring ( text ), x, y, 0, 0, tocolor ( r, g, b, 255 ), textSize )
							else
								dxDrawBoarderedText ( tostring ( text ), x, y, 0, 0, tocolor ( r, g, b, 255 ), textSize )
							end
						end
					end
				end
			end
		end
	end
)

function dxDrawBoarderedText ( text, x, y, endX, endY, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	local text = tostring ( text )
	local x = tonumber(x) or 0
	local y = tonumber(y) or 0
	local endX = tonumber(endX) or x
	local endY = tonumber(endY) or y
	local color = color or tocolor ( 255, 255, 255, 255 )
	local size = tonumber(size) or 1
	local font = font or "default"
	local alignX = alignX or "left"
	local alignY = alignY or "top"
	local clip = clip or false
	local wordBreak = wordBreak or false
	local postGUI = postGUI or false
	local colorCode = colorCode or false
	local subPixelPos = subPixelPos or false
	local fRot = tonumber(fRot) or 0
	local fRotCX = tonumber(fRotCX) or 0
	local fRotCY = tonumber(fRotCy) or 0
	local offSet = tonumber(offSet) or 1
	local t_g = text:gsub ( "#%x%x%x%x%x%x", "" )
	dxDrawText ( t_g, x-offSet, y-offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x-offSet, y, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x, y-offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x+offSet, y+offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x+offSet, y, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	dxDrawText ( t_g, x, y+offSet, endX, endY, tocolor(0,0,0,255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
	return dxDrawText ( text, x, y, endX, endY, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCode, subPixelPos, fRot, fRotCX, fRotCY, offSet )
end


function create3DText ( str, pos, color, parent, settings ) 
	if str and pos and color then
		local text = createElement ( '3DText' )
		local settings = settings or  { }
		setElementData ( text, "text", str )
		setElementData ( text, "position", pos )
		setElementData ( text, "color", color )
		if ( not parent ) then
			parent = nil
		else
			if ( isElement ( parent ) ) then
				parent = parent
			else
				parent = nil
			end
		end
		setElementData ( text, "Settings", settings )
		setElementData ( text, "parentElement", parent )
		return text
	end
	return false
end

create3DText ( 'Welcome to Las Venturas (LV) The City of Gangsters, Use /turf and take part to take over LV!', {1605.432, 1835.584, 11.229}, { 140, 0, 255 }, { nil, true } )