----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 27 Dec 2015
-- Resource: GTIapartments/editor/editor.lua
-- Type: Client Side
-- Author: Ares
----------------------------------------->>

local objectID = 3578
local g_dragElement
local g_dragPosition = { }
local g_dragSpeed = .75
local rotateSpeed = 5

local g_maxSelectDistance = 115

local g_defaultPos = {1532.806, -1459.256, 63, 0}

local draggingButtons = { ["arrow_l"] = "left", ["arrow_u"] = "forward", ["arrow_r"] = "right", ["arrow_d"] = "backward", ["1"] = "up", ["2"] = "down", ["backspace"] = "reset", ["3"] = "rotate+", ["4"] = "rotate-", ["mouse_wheel_up+"] = "rotate", ["mouse_wheel_down"] = "rotate-", ["enter"] = "save"}


function startEditionMode (fP)
	addEventHandler("onClientKey", root, processDragging)
	addEventHandler("onClientRender", root, objectMoving)
	if (fP and isElement(g_dragElement) ) then
		setElementPosition(g_dragElement, g_defaultPos[1], g_defaultPos[2], g_defaultPos[3])
		setElementInterior(g_dragElement, 0)
		setElementRotation(g_dragElement, 0, 0, 0)
		setElementDimension(g_dragElement, 1111)
		setObjectScale(g_dragElement, 1)
		g_dragOriginalPosition = g_defaultPos
		g_dragPosition.x, g_dragPosition.y, g_dragPosition.z, g_dragPosition.rz = 0, 0, 0, 0
		addEventHandler("onClientClick", root, processCursorClick)
	end
end

function stopEditionMode ()
	removeEventHandler("onClientKey", root, processDragging)
	removeEventHandler("onClientRender", root, objectMoving)
	updateDragElement(nil)
	g_dragPosition = { }
end

function objectMoving()
	if ( g_dragElement ) then
		local x, y, z, rz = unpack(g_dragOriginalPosition)
		if ( not x or not y or not z or not rz ) then return end
		setElementPosition(g_dragElement, x+g_dragPosition.x, y+g_dragPosition.y, z+g_dragPosition.z)
		setElementRotation(g_dragElement, 0, 0, rz+g_dragPosition.rz)
	end
end
		
function processCursorClick (button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement, fromPreview)
	if ( clickedElement and not g_dragElement or g_dragElement ~= clickedElement and clickedElement) then
		if ( not getElementData(clickedElement, "apartmentsobject") ) then return end
		g_dragElement = clickedElement
		local x, y, z = getElementPosition(clickedElement)
		local rz = getElementRotation(clickedElement, "ZXY")
		g_dragOriginalPosition = {x, y, z, rz}
		g_dragPosition.x, g_dragPosition.y, g_dragPosition.z, g_dragPosition.rz = 0, 0, 0, 0
		startEditionMode(fromPreview)
	end
end

function processDragging (button, pressOrRelease)
	if ( g_dragElement and draggingButtons[button] and pressOrRelease) then
	if ( isChatBoxInputActive() ) then return end
		local action = draggingButtons[button]
		local camRotX, camRotY, camRotZ = getCameraRotation()
		camRotZ = camRotZ % 360
		local remainder = math.mod ( camRotZ, 90 )
		camRotZ = camRotZ + roundRotation ( remainder )
		--camRotZ = math.rad(camRotZ)
		local distanceX = g_dragSpeed * math.cos(camRotZ)
		local distanceY = g_dragSpeed * math.sin(camRotZ)
			if ( action == "right" ) then
				g_dragPosition.x = g_dragPosition.x + distanceX
				g_dragPosition.y = g_dragPosition.y - distanceY
			elseif ( action == "left" ) then
				g_dragPosition.x = g_dragPosition.x - distanceX
				g_dragPosition.y = g_dragPosition.y + distanceY
			elseif ( action == "forward" ) then
				g_dragPosition.x = g_dragPosition.x + distanceY
				g_dragPosition.y = g_dragPosition.y + distanceX
			elseif ( action == "backward" ) then
				g_dragPosition.x = g_dragPosition.x - distanceY
				g_dragPosition.y = g_dragPosition.y - distanceX
			elseif ( action == "up" ) then
				g_dragPosition.z = g_dragPosition.z + g_dragSpeed 
			elseif ( action == "down" ) then
				g_dragPosition.z = g_dragPosition.z - g_dragSpeed
			elseif ( action == "rotate+"  ) then
				g_dragPosition.rz = g_dragPosition.rz + 1 * rotateSpeed
			elseif ( action == "rotate-" ) then
				g_dragPosition.rz = g_dragPosition.rz - 1 * rotateSpeed
			elseif ( action == "save" ) then
				stopEditionMode ()
			elseif ( action == "reset" ) then
				g_dragPosition.x, g_dragPosition.y, g_dragPosition.z = 0, 0, 0
			end
	end
end

function processCursorLineOfSight()
	local camX, camY, camZ = getCameraMatrix()
	local cursorX, cursorY, endX, endY, endZ = getCursorPosition()

	local surfaceFound, targetX, targetY, targetZ, targetElement,
            nx, ny, nz, material, lighting, piece,
            buildingId, bx, by, bz, brx, bry, brz, buildingLOD
        = processLineOfSight(camX, camY, camZ, endX, endY, endZ, true, true, true, true, true, true, false, true, localPlayer, true)

	if not surfaceFound then
	    targetX, targetY, targetZ = endX, endY, endZ
	end
	
	return targetX, targetY, targetZ, targetElement
end

function processCameraLineOfSight()
	local camX, camY, camZ, endX, endY, endZ = getCameraLine()
	
	local surfaceFound, targetX, targetY, targetZ, targetElement,
            nx, ny, nz, material, lighting, piece,
            buildingId, bx, by, bz, brx, bry, brz, buildingLOD
		= processLineOfSight(camX, camY, camZ, endX, endY, endZ, true, true, true, true, true, true, false, true, localPlayer, true)

	if not surfaceFound then
	    targetX, targetY, targetZ = endX, endY, endZ
	end
	
	return targetX, targetY, targetZ, targetElement
end

function getCameraLine()
	 camX, camY, camZ, endX, endY, endZ = getCameraMatrix()
	 
	local distance = getDistanceBetweenPoints3D ( camX, camY, camZ, endX, endY, endZ )
	targetX = camX + ((endX - camX)/distance) * g_maxSelectDistance
	targetY = camY + ((endY - camY)/distance) * g_maxSelectDistance
	targetZ = camZ + ((endZ - camZ)/distance) * g_maxSelectDistance	
	
	return camX, camY, camZ, endX, endY, endZ
end

function getCameraRotation ()
	local px, py, pz, lx, ly, lz = getCameraMatrix()
	local rotz = 6.2831853071796 - math.atan2 ( ( lx - px ), ( ly - py ) ) % 6.2831853071796
 	local rotx = math.atan2 ( lz - pz, getDistanceBetweenPoints2D ( lx, ly, px, py ) )
	--Convert to degrees
	rotx = math.deg(rotx)
	rotz = -math.deg(rotz)
	
 	return rotx, 180, rotz
end

function roundRotation ( rot )
	if rot < 45 then
		return -rot
	else return (90 - rot) end
end

function getDragElement ()
	return g_dragElement
end

function updateDragElement (elem)
	g_dragElement = elem
	return true
end

function buyItems ()
	guiSetVisible(ApartmentsUI.window[1], true)
	showCursor(true)
	fillInGridListWithItems(ApartmentsUI.gridlist[1])
end

addCommandHandler("buyitems",
	function ()
		buyItems()
	end
)
