------------------------------------------->>
-- GTI-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: GTIevents
-- Type: Client Side
-- Author: ChicoGTI & RedBand
----------------------------------------->>

local roadblocks = {
	{978, "Small roadblock", 180}, 
	{981, "Large roadblock", 0}, 
	{3578, "Yellow fence", 0}, 
	{1228, "Small warning fence", 90}, 
	{1282, "Small warning fence with light", 90}, 
	{1422, "Ugly small fence", 0}, 
	{1424, "Sidewalk block", 0}, 
	{1425, "Detour ->", 0}, 
	{1459, "Warning fence", 0}, 
	{3091, "Vehicles ->", 0},
	{1632, "Ramp 1", 0},
	{1633, "Ramp 2", 0},
	{1634, "Ramp 3", 0},
	{1655, "Ramp 4", 0},
	{8171, "Something", 0},
	{10154, nil, 0},
	{980, nil, 0},
	{3458, nil, 0},
}

local resX, resY = guiGetScreenSize()
local controls = {"aim_weapon", "fire", "previous_weapon", "next_weapon"}
local offsetType = nil
local offsetAmount = 0.030
local totalOffsetAmount = 0

function createRoadblockGUI()
	roadblocksWindow = guiCreateWindow(0, (resY/2)-230, 298, 466, "Spawn events stuff", false)
	guiSetVisible(roadblocksWindow, false)
	guiSetAlpha(roadblocksWindow, 1)
	
	rbTabPanel = guiCreateTabPanel(9, 21, 280, 232, false, roadblocksWindow)

	objectsTab = guiCreateTab("Objects", rbTabPanel)
	
	roadblocksGrid = guiCreateGridList(2, 0, 185, 206, false, objectsTab)
	guiGridListAddColumn(roadblocksGrid, "Name", 0.65)
	guiGridListAddColumn(roadblocksGrid, "ID", 0.2)
	for k, v in ipairs(roadblocks) do
		local row = guiGridListAddRow(roadblocksGrid)
		guiGridListSetItemText(roadblocksGrid, row, 1, v[2] or engineGetModelNameFromID(v[1]) or "Unknown", false, false)
		guiGridListSetItemText(roadblocksGrid, row, 2, v[1], false, false)
	end
	addEventHandler("onClientGUIClick", roadblocksGrid, showRoadblocksPreview, false)
	
	guiLabel = guiCreateLabel(12, 254, 277, 164, "Use the Mouse wheel to rotate the Roadblock.\nHold \"Ctrl\" or \"Ctrl\" and \"Shift\" to change x and y rotations. \nTo cancel placing use Mouse 2.\nTo place the Roadblock use Mouse 1.\nIf you want to delete roadblocks use the right button of the mouse.\nNote that you have to be in staff mode to use this\nTo disable cursor hold \"Alt\"\nTo change Z offset use arrow keys", false, roadblocksWindow)
	guiLabelSetColor(guiLabel, 125, 125, 125)
	guiLabelSetHorizontalAlign(guiLabel, "left", true)
	
	closeButton = guiCreateButton(9, 420, 280, 37, "Close Window", false, roadblocksWindow)
	placeButton = guiCreateButton(187, 28, 89, 36, "Place", false, objectsTab)
	destroyButton = guiCreateButton(187, 87, 89, 36, "Destroy my Roadblocks", false, objectsTab)
	destroyallButton = guiCreateButton(187, 147, 89, 36, "Destroy ALL Roadblocks", false, objectsTab)
	--devButton = guiCreateButton(184, 180, 113, 38, "Dev", false, roadblocksWindow)
	
	idEdit = guiCreateEdit(189, 2, 86, 24, "", false, objectsTab)
	
	vehiclesTab = guiCreateTab("Vehicles", rbTabPanel)

	placeVehicleButton = guiCreateButton(4, 142, 273, 36, "Place", false, vehiclesTab)
	vehicleName = guiCreateEdit(7, 27, 265, 21, "", false, vehiclesTab)
	desc1 = guiCreateLabel(7, 7, 262, 19, "Vehicle Name", false, vehiclesTab)
	guiLabelSetHorizontalAlign(desc1, "center", false)
	desc2 = guiCreateLabel(7, 68, 262, 19, "Vehicle Color", false, vehiclesTab)
	guiLabelSetHorizontalAlign(desc2, "center", false)
	redEdit = guiCreateEdit(14, 94, 69, 22, "R", false, vehiclesTab)
	greenEdit = guiCreateEdit(102, 94, 69, 22, "G", false, vehiclesTab)
	blueEdit = guiCreateEdit(192, 94, 69, 22, "B", false, vehiclesTab)
	-- exports.GTInvremisc:setEditOnlyNumbers(redEdit, true, true, true)
	-- exports.GTInvremisc:setEditOnlyNumbers(greenEdit, true, true, true)
	-- exports.GTInvremisc:setEditOnlyNumbers(blueEdit, true, true, true)
	
	-- addEventHandler("onClientGUIClick", destroyButton, function() exports.GTInvremisc:createYesNoWindow("GTIevents.DestroyMyRBsCallback", nil, "Destroy My Roadblocks", "Are you sure you want to destroy your roadblocks?") end, false)
	-- addEventHandler("onClientGUIClick", destroyallButton, function() exports.GTInvremisc:createYesNoWindow("GTIevents.DestroyALLRBsCallback", nil, "Destroy All Roadblocks", "Are you sure you want to destroy ALL roadblocks?") end, false)
	addEventHandler("onClientGUIClick", closeButton, closeRoadBlockGUI, false)
	addEventHandler("onClientGUIClick", placeButton, placeObject, false)
	addEventHandler("onClientGUIClick", placeVehicleButton, placeVehicle, false)
end
addEventHandler("onClientResourceStart", resourceRoot, createRoadblockGUI)

function destroyMyRBs()
	triggerServerEvent("GTIevents.RB.DestroyRoadblocks", localPlayer)
end
addEvent("GTIevents.DestroyMyRBsCallback")
addEventHandler("GTIevents.DestroyMyRBsCallback", root, destroyMyRBs)

function destroyAllRBs()
	triggerServerEvent("GTIevents.RB.DestroyALLRoadblocks", localPlayer)
end
addEvent("GTIevents.DestroyALLRBsCallback")
addEventHandler("GTIevents.DestroyALLRBsCallback", root, destroyAllRBs)

function closeRoadBlockGUI()
	guiSetVisible(roadblocksWindow, false)
	handleCursorVisibility()
	if (isElement(object)) then destroyElement(object) end
end

function roadblockGUI()
	triggerServerEvent("GTIevents.RB.CheckAdminLevel", localPlayer)
end
addCommandHandler("rb", roadblockGUI)

function showW()
	guiSetVisible(roadblocksWindow, not guiGetVisible(roadblocksWindow))
	showCursor(guiGetVisible(roadblocksWindow))
end
addEvent("showRB", true)
addEventHandler("showRB", localPlayer, showW)

function showRoadblocksPreview()
	local roadblock = guiGridListGetItemText(roadblocksGrid, guiGridListGetSelectedItem(roadblocksGrid), 2)
	guiSetText(idEdit, roadblock)
end

function placeObject()
	local id = guiGetText(idEdit)
	if (not tonumber(id)) or (id == "") then 
		outputChatBox("Invalid model ID", 255, 0, 0)
		return
	end
	object = createObject(tonumber(id), 0, 0, 0, 0, 0, 0)
	setElementCollisionsEnabled(object, false)
	setElementDoubleSided(object, true)
	setElementDimension(object, getElementDimension(localPlayer))
	setElementInterior(object, getElementInterior(localPlayer))
	startPlacing()
end

function placeVehicle()
	local name = guiGetText(vehicleName)
	if (not getVehicleModelFromName(name)) then
		outputChatBox("Invalid vehicle", 255, 0, 0)
		return
	end
	object = createVehicle(tonumber(getVehicleModelFromName(name)), 0, 0, 0, 0, 0, 0)
	setElementCollisionsEnabled(object, false)
	setElementDoubleSided(object, true)
	setElementDimension(object, getElementDimension(localPlayer))
	setElementInterior(object, getElementInterior(localPlayer))
	setElementFrozen(object, true)
	local r, g, b = tonumber(guiGetText(redEdit)), tonumber(guiGetText(greenEdit)), tonumber(guiGetText(blueEdit))
	if (r and g and b and r < 256 and g < 256 and b < 256) then
		setVehicleColor(object, r, g, b, r, g, b, r, g, b, r, g, b)
	else
		setVehicleColor(object, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255)
	end
	startPlacing()
end

function startPlacing()
	if (object) then
		guiSetEnabled(placeButton, false)
		guiSetEnabled(placeVehicleButton, false)
	end
	bindKey("mouse_wheel_up", "down", rotateRoadBlock)
	bindKey("mouse_wheel_down", "down", rotateRoadBlock)
	bindKey("mouse1", "down", placeRoadblock)
	bindKey("mouse2", "down", cancelRoadBlock)
	for i, v in pairs(controls) do
		toggleControl(tostring(v), false)
	end
end

function cancelRoadBlock()
	destroyElement(object)
	unbindKey("mouse2", "down", cancelRoadBlock)
	unbindKey("mouse1", "down", placeRoadblock)
	unbindKey("mouse_wheel_up", "down", rotateRoadBlock)
	unbindKey("mouse_wheel_down", "down", rotateRoadBlock)
	totalOffsetAmount = 0
	guiSetEnabled(placeButton, true)
	guiSetEnabled(placeVehicleButton, true)
	for i, v in pairs(controls) do
		toggleControl(tostring(v), true)
	end
end

function rotateRoadBlock(key)
	local rX, rY, rZ = getElementRotation(object)
	if (key == "mouse_wheel_up") then
		if (isElement( object)) then
			if (not getKeyState("lctrl") and not getKeyState("lshift")) then
				setElementRotation(object, rX, rY, rZ + 5)
			end
			if (getKeyState("lctrl") and not getKeyState("lshift")) then
				setElementRotation(object, rX, rY + 5, rZ)
			end
			if (getKeyState("lctrl") and getKeyState("lshift")) then
				setElementRotation(object, rX + 5, rY, rZ)
			end
		end
	elseif (key == "mouse_wheel_down") then
		if (not getKeyState("lctrl") and not getKeyState("lshift")) then
			setElementRotation(object, rX, rY, rZ - 5)
		end
		if (getKeyState("lctrl") and not getKeyState("lshift")) then
			setElementRotation(object, rX, rY - 5, rZ)
		end
		if (getKeyState("lctrl") and getKeyState("lshift")) then
			setElementRotation(object, rX - 5, rY, rZ)
		end
	end
end

function placeRoadblock()
	if (not object) then return end
	local x, y, z = getElementPosition(object)
	local rx, ry, rz = getElementRotation(object)
	local id = getElementModel(object)
	local dim = getElementDimension(localPlayer)
	local int = getElementInterior(localPlayer)
	if (getElementType(object) == "object") then
		triggerServerEvent("GTIevents.RB.AddRoadblock", localPlayer, id, x, y, z, rx, ry, rz, dim, int)
	elseif (getElementType(object) == "vehicle") then
		local r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4 = getVehicleColor(object, true)
		triggerServerEvent("GTIevents.RB.SpawnVeh", localPlayer, id, x, y, z, rx, ry, rz, dim, int, {r1, g1, b1, r2, g2, b2, r3, g3, b3, r4, g4, b4})
	end
	destroyElement(object)	
    unbindKey("mouse2", "down", cancelRoadBlock)
    unbindKey("mouse1", "down", placeRoadblock)
    unbindKey("mouse_wheel_up", "down", rotateRoadBlock)
    unbindKey("mouse_wheel_down", "down", rotateRoadBlock)
	totalOffsetAmount = 0
	guiSetEnabled(placeButton, true)
	guiSetEnabled(placeVehicleButton, true)
    for i, v in pairs(controls) do
		toggleControl(tostring(v), true)
    end	
end

function noBreak(object)
	setObjectBreakable(object, false)
end
addEvent("nobreak", true)
addEventHandler("nobreak", root, noBreak)

function toggleCursor(key, state)
	if (guiGetVisible(roadblocksWindow)) then
		if (state == "down") then
			showCursor(false)
		else
			showCursor(true)
		end
	end
end
bindKey("lalt", "both", toggleCursor)

function toggleCursor()
	if (guiGetVisible(roadblocksWindow)) then
		if (state == "down") then
			showCursor(false)
		else
			showCursor(true)
		end
	end
end
bindKey("z", "down", toggleCursor)

function elementClicked(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedWorld)
	if (guiGetVisible(roadblocksWindow)) then
		if (button == "right") then
			if (state == "up") then
				if (clickedWorld and isElement(clickedWorld)) then
					if (getElementType(clickedWorld) == "object") then
						for k,v in ipairs(getElementsByType("object"), resourceRoot) do
							if (v == clickedWorld) then
								triggerServerEvent("GTIevents.RB.DestroyRoadblock", root, clickedWorld)
								return
							end
						end
					elseif (getElementType(clickedWorld) == "vehicle") then
						for k,v in ipairs(getElementsByType("vehicle"), resourceRoot) do
							if (v == clickedWorld) then
								triggerServerEvent("GTIevents.RB.DestroyVeh", root, clickedWorld)
								return
							end
						end
					end
				end
			end
		end
	end
end
addEventHandler("onClientClick", root, elementClicked)

local screenX, screenY = guiGetScreenSize()
function onCursorMove(cursorX, cursorY)
	if (object and isElement(object)) then
		if (isCursorShowing()) then
			local screenx, screeny, worldx, worldy, worldz = getCursorPosition()
			local px, py, pz = getCameraMatrix()
			local dist = getElementDistanceFromCentreOfMassToBaseOfModel(object)
			local hit, x, y, z, elementHit = processLineOfSight(px, py, pz, worldx, worldy, worldz, true, true, false, true, true, false, false, false)
			if (hit) then
				local px, py, pz = getElementPosition(localPlayer)
				local distance = getDistanceBetweenPoints3D(px, py, pz, x, y, z)
				setElementPosition(object, x, y, (z + dist + totalOffsetAmount))
			end
		end
	end
end
addEventHandler("onClientCursorMove", root, onCursorMove)

function toggleOffsets(key, state)
	if (state == "up") then
		offsetType = nil
		return
	end
	if (key == "arrow_u") then
		offsetType = "up"
	elseif (key == "arrow_d") then
		offsetType = "down"
	end
end
bindKey("arrow_u", "both", toggleOffsets)
bindKey("arrow_d", "both", toggleOffsets)

function clientPreRender()
	if (offsetType and object and isElement(object)) then
		local addition = 0
		if (getKeyState("lalt")) then
			addition = offsetAmount*100
		end
		local x, y, z = getElementPosition(object)
		if (offsetType == "up") then
			setElementPosition(object, x, y, z + offsetAmount + addition)
			totalOffsetAmount = totalOffsetAmount + offsetAmount + addition
		elseif (offsetType == "down") then
			setElementPosition(object, x, y, z - offsetAmount - addition)
			totalOffsetAmount = totalOffsetAmount - offsetAmount - addition
		end
	end
end
addEventHandler("onClientPreRender", root, clientPreRender)



function onClientRender()
	if (roadblocksWindow and guiGetVisible(roadblocksWindow) and not isElement(object) and isCursorShowing()) then
		local gx, gy
		local camX, camY, camZ = getCameraMatrix()
		local cursorX, cursorY, endX, endY, endZ = getCursorPosition()
		local surfaceFound, targetX, targetY, targetZ, targetElement, nx, ny, nz, material, lighting, piece, buildingId, bx, by, bz, brx, bry, brz, buildingLOD = processLineOfSight(camX, camY, camZ, endX, endY, endZ, true, true, true, true, true, true, true, true, localPlayer, true)
		if not surfaceFound then
			targetX, targetY, targetZ = endX, endY, endZ
		end
		gx, gy = getScreenFromWorldPosition(targetX, targetY, targetZ, 0, false)
		if (gx and gy) then
			if (targetElement) then
				dxDrawText("OBJ ID: "..getElementModel(targetElement) or "Unknown", gx, gy - 20)
			else
				if (buildingId) then
					dxDrawText("OBJ ID: "..buildingId, gx, gy - 20)
				end
			end
		end
	end
end
addEventHandler("onClientRender", root, onClientRender)

function getObjectsString()
	if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then
		local str = ""
		local count = 1
		for k,v in ipairs(getElementsByType("object", resourceRoot)) do
			local x, y, z = getElementPosition(v)
			local rx, ry, rz = getElementRotation(v)
			local model = getElementModel(v)
			str = str.."\n".."["..count.."] = {"..x..", "..y..", "..z..", "..rx..", "..ry..", "..rz..", "..model.."},"
			count = count + 1
		end
		setClipboard(str)
		outputChatBox("Copied to clipboard")
	end
end
addCommandHandler("gos", getObjectsString)

function getVehiclesString()
	if (getTeamName(getPlayerTeam(localPlayer)) == "Staff") then
		local str = ""
		local count = 1
		for k,v in ipairs(getElementsByType("vehicle", resourceRoot)) do
			local x, y, z = getElementPosition(v)
			local rx, ry, rz = getElementRotation(v)
			local model = getElementModel(v)
			str = str.."\n".."["..count.."] = {"..x..", "..y..", "..z..", "..rx..", "..ry..", "..rz..", "..model.."},"
			count = count + 1
		end
		setClipboard(str)
		outputChatBox("Copied to clipboard")
	end
end
addCommandHandler("gvs", getVehiclesString)