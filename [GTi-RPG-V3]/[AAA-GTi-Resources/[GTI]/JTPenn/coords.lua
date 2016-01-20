------------------------------------->>
-- CIT: Community of Integrity and Transparency
-- Date: 16 Sept 2012
-- Resource: CITcoords/coords.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
-- All Rights Reserved By Developers
------------------------------------->>

-- Coordinates GUI
------------------->>

-- Window
local sX,sY = guiGetScreenSize()
local wX,wY = 356,319
local sX,sY,wX,wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
windowCoordsSaver = guiCreateWindow(sX,sY,wX,wY,"CIT Coordinates Saver",false)
-- sX,sY,wX,wY = 500,248,356,319
guiWindowSetMovable(windowCoordsSaver,false)
guiWindowSetSizable(windowCoordsSaver,false)
-- Memo
memoCoords = guiCreateMemo(9,26,337,229,"",false,windowCoordsSaver)
-- Label
labelOffset = guiCreateLabel(179,265,38,18,"Offset:",false,windowCoordsSaver)
-- Editbox
editOffset = guiCreateEdit(221,261,53,25,"-1",false,windowCoordsSaver)
-- Checkbox
checkIncludeRot = guiCreateCheckBox(10,291,118,17,"Include Rotation?",false,false,windowCoordsSaver)
-- Buttons
btnGetCoords = guiCreateButton(10,260,77,27,"Get Coords.",false,windowCoordsSaver)
btnClear = guiCreateButton(95,260,77,27,"Clear Log",false,windowCoordsSaver)
btnGetOffset = guiCreateButton(280,260,65,29,"Get Offset",false,windowCoordsSaver)
btnClose = guiCreateButton(325,292,19,18,"X",false,windowCoordsSaver)
-- Other
guiSetVisible(windowCoordsSaver,false)

-- Show/Hide GUI
----------------->>

function showGUI( command )
	if guiGetVisible(windowCoordsSaver) then
		guiSetVisible(windowCoordsSaver,false)
		showCursor(false)
	else
		guiSetVisible(windowCoordsSaver,true)
		showCursor(true)
	end
end
addCommandHandler( "coords", showGUI )

function hideGUI( button, state )
	if button == "left" and state == "up" then
		guiSetVisible(windowCoordsSaver,false)
		showCursor(false)
	end
end
addEventHandler( "onClientGUIClick", btnClose, hideGUI, false )

-- Get Coordinates
------------------->>

function getCoords( button, state )
	if button == "left" and state == "up" or button == "getcoords" then
		local offset = guiGetText( editOffset )
		if not tonumber( offset ) then
			offset = -1
			guiSetText( editOffset, "-1" )
		end		
		offset = tonumber( offset )
		local x,y,z = getElementPosition( localPlayer )
		if isPedInVehicle( localPlayer ) then
			local vehicle = getPedOccupiedVehicle( localPlayer )
			x,y,z = getElementPosition( vehicle )
		end
		local z = z+offset
		local coords = guiGetText( memoCoords )
		if guiCheckBoxGetSelected( checkIncludeRot ) then
			local rx, ry, rot = getElementRotation( localPlayer )
			guiSetText( memoCoords, coords.."{"..string.format("%.3f",x)..", "..string.format("%.3f",y)..", "..string.format("%.3f",z)..", "..string.format("%.3f",rot).."},\n" )
			outputChatBox( "Coordinates: {"..string.format("%.3f",x)..", "..string.format("%.3f",y)..", "..string.format("%.3f",z)..", "..string.format("%.3f",rot).."},", 255, 255, 0 )
		else
			guiSetText( memoCoords, coords.."{"..string.format("%.3f",x)..", "..string.format("%.3f",y)..", "..string.format("%.3f",z).."},\n" )
			outputChatBox( "Coordinates: {"..string.format("%.3f",x)..", "..string.format("%.3f",y)..", "..string.format("%.3f",z).."},", 255, 255, 0 )
		end
	end
end
addEventHandler( "onClientGUIClick", btnGetCoords, getCoords, false )
addCommandHandler( "getcoords", getCoords )

-- Get Offset
-------------->>

function getOffset( button, state )
	if button == "left" and state == "up" then
		if not isPedInVehicle( localPlayer ) then
			guiSetText( editOffset, -1 )
		else
			local vehicle = getPedOccupiedVehicle( localPlayer )
			local offset = getElementDistanceFromCentreOfMassToBaseOfModel( vehicle )
			guiSetText( editOffset, string.format("%.3f",-offset) )
		end
	end
end
addEventHandler( "onClientGUIClick", btnGetOffset, getOffset, false )

-- Clear Coords
---------------->>

function clearCoords( button, state )
	if button == "left" and state == "up" then
		guiSetText( memoCoords, "" )
	end
end
addEventHandler( "onClientGUIClick", btnClear, clearCoords, false )