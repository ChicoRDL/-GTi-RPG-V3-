----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 07 Jan 2014
-- Resource: GTIdevTools/coords.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

coords = {checkbox = {}, edit = {}, button = {}, window = {}, label = {}, memo = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 320, 380
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 520, 213, 320, 380
coords.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI Coordinates Panel", false)
guiWindowSetSizable(coords.window[1], false)
guiSetAlpha(coords.window[1], 0.95)
-- Labels
coords.label[1] = guiCreateLabel(96, 351, 49, 15, "Z-Offset:", false, coords.window[1])
coords.label[2] = guiCreateLabel(8, 305, 303, 15, "Right Click to Close", false, coords.window[1])
guiSetFont(coords.label[2], "default-small")
guiLabelSetHorizontalAlign(coords.label[2], "center", false)
-- Memo
coords.memo[1] = guiCreateMemo(9, 23, 302, 279, "", false, coords.window[1])
guiMemoSetReadOnly(coords.memo[1], true)
-- Edit
coords.edit[1] = guiCreateEdit(148, 348, 77, 22, "-1", false, coords.window[1])
-- Buttons
coords.button[1] = guiCreateButton(9, 319, 81, 23, "Get Pos", false, coords.window[1])
guiSetProperty(coords.button[1], "NormalTextColour", "FFAAAAAA")
coords.button[2] = guiCreateButton(9, 348, 81, 23, "Copy", false, coords.window[1])
guiSetProperty(coords.button[2], "NormalTextColour", "FFAAAAAA")
coords.button[3] = guiCreateButton(229, 319, 81, 23, "Clear Log", false, coords.window[1])
guiSetProperty(coords.button[3], "NormalTextColour", "FFAAAAAA")
--coords.button[4] = guiCreateButton(229, 348, 81, 23, "Get Offset", false, coords.window[1])
--guiSetProperty(coords.button[4], "NormalTextColour", "FFAAAAAA")
-- Checkbox
coords.checkbox[1] = guiCreateCheckBox(97, 322, 123, 15, "Include Rotation?", false, false, coords.window[1])
-- Visible
guiSetVisible(coords.window[1], false)

-- Toggle Panel
---------------->>

function showCoordsGUI()
	if (not guiGetVisible(coords.window[1])) then
		guiSetVisible(coords.window[1], true)
		showCursor(true)
	else
		hideCoordsGUI("right", "up")
	end
end
addEvent("GTIdevTools.showCoordsGUI", true)
addEventHandler("GTIdevTools.showCoordsGUI", root, showCoordsGUI)

function hideCoordsGUI(button, state)
	if (button ~= "right" or state ~= "up") then return end
	guiSetVisible(coords.window[1], false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", coords.window[1], hideCoordsGUI)

function getCoordinates(button, state)
	if (button == "left" and state == "up" or button == "getpos") then
		local offset = guiGetText(coords.edit[1])
		if (not tonumber(offset)) then
			outputChatBox("Please enter a valid number as an offset. The default is -1", 255, 255, 0)
			return
		end
		offset = tonumber(offset)
		
		local x,y,z
		if (exports.freecam:isFreecamEnabled()) then
			x,y,z = getElementPosition(getCamera())
		else
			x,y,z = getElementPosition(localPlayer)
			z = z+offset
		end
		x,y,z = string.format("%.3f", x), string.format("%.3f", y), string.format("%.3f", z)
		
		local rot = ""
		if (guiCheckBoxGetSelected(coords.checkbox[1])) then
			local _,_,rotNum = getElementRotation(localPlayer)
			rot = ", "..string.format("%.3f", rotNum)
		end
		
		local lastCoords = guiGetText(coords.memo[1])
		guiSetText(coords.memo[1], lastCoords.."\n{"..x..", "..y..", "..z..""..rot.."},")
		outputChatBox("Coordinates: {"..x..", "..y..", "..z..""..rot.."},", 255, 255, 0)
		setClipboard ("{"..x..", "..y..", "..z..""..rot.."},")
	end
end
addEventHandler("onClientGUIClick", coords.button[1], getCoordinates, false)
addCommandHandler("getpos", getCoordinates)

addCommandHandler("getpos-cam", function()
	local matrix = {getCameraMatrix()}
	for i=1,6 do
		matrix[i] = string.format("%.3f", matrix[i])
	end
	matrix[7], matrix[8] = nil, nil
	
	local lastCoords = guiGetText(coords.memo[1])
	guiSetText(coords.memo[1], lastCoords.."\n{"..table.concat(matrix, ", ").."},")
	outputChatBox("Coordinates: {"..table.concat(matrix, ", ").."},", 255, 255, 0)
end)

-- Update Offset
----------------->>

function updateOffsetOnEnter()
	local offset = getElementDistanceFromCentreOfMassToBaseOfModel(source)
	guiSetText(coords.edit[1], "-"..string.format("%.3f", offset))
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, updateOffsetOnEnter)

function updateOffsetOnExit()
	guiSetText(coords.edit[1], "-1")
end
addEventHandler("onClientPlayerVehicleEnter", localPlayer, updateOffsetOnExit)

-- Clear Memo
-------------->>

function clearCoordinates(button, state)
	if (button == "left" and state ~= "up") then return end
	local coordsList = guiGetText(coords.memo[1])
	setClipboard(coordsList)
	guiSetText(coords.memo[1], "")
	outputChatBox("Coordinates List Cleared! A backup has been stored on your clipboard.", 255, 255, 0)
end
addEventHandler("onClientGUIClick", coords.button[3], clearCoordinates, false)

-- Copy to Clipboard
--------------------->>

function copyToClipboard(button, state)
	if (button == "left" and state ~= "up") then return end
	local coordsList = guiGetText(coords.memo[1])
	setClipboard(coordsList)
	outputChatBox("Coordinates Copied to Clipboard", 255, 255, 0)
end
addEventHandler("onClientGUIClick", coords.button[2], copyToClipboard, false)