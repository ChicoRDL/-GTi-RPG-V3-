-- Author: JT Pennington (JTPenn) & Emile

GUI = { edit = {}, button = {}, label = {}, gridlist = {}}
local sX, sY = guiGetScreenSize()
local wX, wY = 390, 215
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
Window = guiCreateWindow(sX, sY, wX, wY, "Vehicle storage", false)
guiSetVisible(Window,false)
guiWindowSetSizable(Window,false)
-- Labels
guiSetInputMode("no_binds_when_editing")
GUI.label[1] = guiCreateLabel(22, 5, 117, 15, "My Inventory", false, Window)
GUI.label[3] = guiCreateLabel(175, 40, 37, 15, "Close", false, Window)
guiSetFont(GUI.label[1], "default-bold-small")
guiLabelSetColor(GUI.label[1], 30, 160, 115)
guiLabelSetHorizontalAlign(GUI.label[1], "center", false)
GUI.label[2] = guiCreateLabel(12, 192, 362, 15, "Select an item and use the arrow buttons to transfer items to/from your Vehicle storage", false, Window)
guiSetFont(GUI.label[2], "default-small")
guiLabelSetHorizontalAlign(GUI.label[2], "center", false)
-- Gridlists
GUI.gridlist[1] = guiCreateGridList(9, 24, 153, 165, false, Window)
guiGridListAddColumn(GUI.gridlist[1], "Item", 0.6)
guiGridListAddColumn(GUI.gridlist[1], "Qty", 0.28)
guiGridListSetSortingEnabled(GUI.gridlist[1], false)
GUI.gridlist[2] = guiCreateGridList(223, 24, 153, 165, false, Window)
guiGridListAddColumn(GUI.gridlist[2], "Item", 0.6)
guiGridListAddColumn(GUI.gridlist[2], "Qty", 0.28)
guiGridListSetSortingEnabled(GUI.gridlist[2], false)
-- Buttons
GUI.button[4] = guiCreateButton(167, 66, 51, 20, "<<<", false, Window)
GUI.button[5] = guiCreateButton(167, 111, 51, 20, ">>>", false, Window)
-- Edit
GUI.edit[1] = guiCreateEdit(167, 89, 50, 18, "", false, Window)
local plrInvCache	-- Cache of Player Inventory
local carInvCache	-- Cache of car Inventory
local antispam = getTickCount()

-- Handle click
-------------------->>
function hideGUI()
	guiSetVisible(Window,false)
	showCursor(false)
	if isElement(car) then
		triggerServerEvent("GTICarStorage.closeDoor", resourceRoot, car)
	end
	car = nil
end

function getVehicle(button, state, sx, sy, wx, wy, wz, vehicle)
	if (button ~= "left" or state ~= "up") then return end
	if getTickCount() - antispam < 2000 then return end
	if guiGetVisible(Window) then return end
	if (not isElement(vehicle) or getElementType(vehicle) ~= "vehicle" or getVehicleType(vehicle) ~= "Automobile") then return end
	if (isPedInVehicle(localPlayer) or isPedDead(localPlayer)) then return end

	antispam = getTickCount()
	local px, py, pz = getElementPosition(localPlayer)
	local tx, ty, tz = getElementPosition(vehicle)
	local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
	if (dist > 10) then
		exports.GTIhud:dm("* You must be closer to the vehicle.", 255, 25, 25)
		return
	end

	triggerServerEvent("GTICarStorage.getCarStorage", resourceRoot, vehicle)
	car = vehicle
end
addEventHandler("onClientClick", root, getVehicle)
-- Render Inventory
-------------------->>

addEvent("GTICarStorage.getCarStorage", true)
addEventHandler("GTICarStorage.getCarStorage", root, function(plrInv, carInv)
	-- Player Inventory
	guiGridListClear(GUI.gridlist[1])
	for i,v in ipairs(plrInv) do
		local row = guiGridListAddRow(GUI.gridlist[1])
		guiGridListSetItemText(GUI.gridlist[1], row, 1, getWeaponNameFromID(v[1]), false, false)
		guiGridListSetItemText(GUI.gridlist[1], row, 2, v[2], false, false)
	end
	plrInvCache = plrInv
	
	-- car Inventory
	guiGridListClear(GUI.gridlist[2])
	for i,v in ipairs(carInv) do
		local row = guiGridListAddRow(GUI.gridlist[2])
		guiGridListSetItemText(GUI.gridlist[2], row, 1, getWeaponNameFromID(v[1]), false, false)
		guiGridListSetItemText(GUI.gridlist[2], row, 2, v[2], false, false)
	end
	guiSetVisible(Window,true)
	showCursor(true)
	carInvCache = carInv
end)

-- Transfer Between
-------------------->>

addEventHandler("onClientGUIClick", GUI.button[5], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if not isElement(car) then hideGUI() return end
	local x,y,z = getElementPosition(localPlayer)
	local x2,y2,z2 = getElementPosition(car)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 10 then hideGUI() return end
	
	local row = guiGridListGetSelectedItem(GUI.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item off of your personal inventory to transfer to your car storage", 255, 125, 0)
		return
	end
	
	local toTransfer = plrInvCache[row+1][1]
	local amount = tonumber(guiGetText(GUI.edit[1])) or 0
	
	if (math.floor(amount) <= 0) then
		exports.GTIhud:dm("The amount must be 1 or higher.",255,125,0)
		return
	end
	
	triggerServerEvent("GTICarStorage.transferTocar", resourceRoot, car, toTransfer, amount)
end, false)

addEventHandler("onClientGUIClick", GUI.button[4], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if not isElement(car) then hideGUI() return end
	local x,y,z = getElementPosition(localPlayer)
	local x2,y2,z2 = getElementPosition(car)
	if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 10 then hideGUI() return end
	
	local row = guiGridListGetSelectedItem(GUI.gridlist[2])
	if (not row or row == -1) then
		exports.GTIhud:dm("Select an item off of your car storage to transfer to your personal inventory", 255, 125, 0)
		return
	end
	
	local toTransfer = carInvCache[row+1][1]
	local amount = tonumber(guiGetText(GUI.edit[1])) or 0
	
	if (math.floor(amount) <= 0) then
		exports.GTIhud:dm("The amount must be 1 or higher.",255,125,0)
		return
	end
	
	triggerServerEvent("GTICarStorage.transferToPlayer", resourceRoot, car, toTransfer, amount)
end, false)

--hide gui
addEventHandler("onClientElementDestroy",root,function()
	if ( source == car ) then
		hideGUI()
	end
end)

function hide()
	if guiGetVisible(Window) then
		hideGUI()
	end
end
addEventHandler("onClientPlayerWasted",localPlayer,hide)

addEventHandler("onClientGUIClick", GUI.label[3], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	hideGUI()
end, false)

addEventHandler("onClientMouseEnter", GUI.label[3], function()
	guiLabelSetColor(source, 255, 0, 0)
end, false)

addEventHandler("onClientMouseLeave", GUI.label[3], function()
	guiLabelSetColor(source, 255, 255, 255)
end, false)

addEventHandler("onClientGUIChanged", GUI.edit[1], function()
	if not tonumber(guiGetText(GUI.edit[1])) then
		 guiSetText(GUI.edit[1],"")
	end
end, false)