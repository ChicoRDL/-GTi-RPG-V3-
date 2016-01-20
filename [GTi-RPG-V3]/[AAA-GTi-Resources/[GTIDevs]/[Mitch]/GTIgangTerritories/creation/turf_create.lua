----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 29 Jul 2014
-- Resource: GTIturfing/creation/turf_create.lua
-- Version: 1.0
----------------------------------------->>

local DEF_R, DEF_G, DEF_B = 255, 255, 255	-- Default Turf Color
local DEF_A = 125							-- Default Turf Alpha

local prev_turf	-- Preview Turf
local prev_col	-- Preview Col

-- Turf Create Panel
--------------------->>

function showTurfCreatePanel(turf_modes)
	local ind = 0
	guiComboBoxClear(basicCreate.combobox[1])
	for mode,i in pairs(turf_modes) do
		guiComboBoxAddItem(basicCreate.combobox[1], mode)
		ind = ind + 1
	end
	guiSetSize(basicCreate.combobox[1], 190, 25+(ind*20), false)
	
	for i=1,4 do
		guiSetEnabled(basicCreate.edit[i], false)
	end
	for _,i in ipairs({1, 2, 4}) do
		guiSetEnabled(basicCreate.button[i], false)
	end	
	
	guiSetVisible(basicCreate.window[1], true)
	showCursor(true)
	
	exports.GTIhud:dm("TURF CREATOR: Development mode enabled. Type /showcol to view turf creation in greater detail", 135, 30, 75)
	
	setDevelopmentMode(true)
	bindKey("x", "down", toggleCursor)
	addCommandHandler("turf-sw", updateSWCornerCmd)
	addCommandHandler("turf-ne", updateNECornerCmd)
end
addEvent("GTIturfing.showTurfCreatePanel", true)
addEventHandler("GTIturfing.showTurfCreatePanel", root, showTurfCreatePanel)

addEventHandler("onClientGUIClick", basicCreate.button[3], function(button, state)
	if (button ~= "left") then return end
	
	for i=1,4 do
		guiSetText(basicCreate.edit[i], "")
	end
	
	if (prev_turf) then
		destroyElement(prev_turf)
		prev_turf = nil
	end
	if (prev_col) then
		destroyElement(prev_col)
		prev_col = nil
	end
	
	setDevelopmentMode(false)
	guiSetVisible(basicCreate.window[1], false)
	showCursor(false)

	unbindKey("x", "down", toggleCursor)
	removeCommandHandler("turf-sw", updateSWCornerCmd)
	removeCommandHandler("turf-ne", updateNECornerCmd)
end, false)

-- Select Turf Type
-------------------->>

addEventHandler("onClientGUIComboBoxAccepted", basicCreate.combobox[1], function()
	for i=1,4 do
		guiSetEnabled(basicCreate.edit[i], true)
	end
	for _,i in ipairs({1, 2, 4}) do
		guiSetEnabled(basicCreate.button[i], true)
	end
	
	guiSetVisible(pointsCreate.window[1], false)
	
	local row = guiComboBoxGetSelected(basicCreate.combobox[1])
	local type_ = guiComboBoxGetItemText(source, row)
	if (type_ == "Kill Points (LS)") then
		guiSetVisible(pointsCreate.window[1], true)
	end
end)

-- Turf Type Panel Functions
----------------------------->>

function updateTurfRespawnPos()
	local x,y,z = getElementPosition(localPlayer)
	guiSetText(pointsCreate.edit[1], string.format("%.3f", x))
	guiSetText(pointsCreate.edit[3], string.format("%.3f", y))
	guiSetText(pointsCreate.edit[2], string.format("%.3f", z))
end

addCommandHandler("turf-resp", updateTurfRespawnPos)
addEventHandler("onClientGUIClick", pointsCreate.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return false end
	updateTurfRespawnPos()
end, false)

-- Update Positions
-------------------->>

function updateSWCorner(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local x,y = getElementPosition(localPlayer)
	local x,y = string.format("%.3f", x), string.format("%.3f", y)
	guiSetText(basicCreate.edit[1], x)
	guiSetText(basicCreate.edit[2], y)
	
	updateTurfPreview()
	outputChatBox("TURF CREATION: Southwest (bottom right) corner updated", 135, 30, 75)
end
addEventHandler("onClientGUIClick", basicCreate.button[1], updateSWCorner, false)

function updateSWCornerCmd()
	updateSWCorner("left", "up")
end

function updateNECorner(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local x,y = getElementPosition(localPlayer)
	local x,y = string.format("%.3f", x), string.format("%.3f", y)
	guiSetText(basicCreate.edit[3], x)
	guiSetText(basicCreate.edit[4], y)
	
	updateTurfPreview()
	outputChatBox("TURF CREATION: Northeast (top left) corner updated", 135, 30, 75)
end
addEventHandler("onClientGUIClick", basicCreate.button[2], updateNECorner, false)

function updateNECornerCmd()
	updateNECorner("left", "up")
end

-- Create Turf
--------------->>

addEventHandler("onClientGUIClick", basicCreate.button[4], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	for i=1,4 do
		local text = guiGetText(basicCreate.edit[i])
		if (text == "" or not tonumber(text)) then
			exports.GTIhud:dm("ERROR: Position information missing. Cannot create turf.", 255, 25, 25)
			return
		end
	end
	
	local x = tonumber( guiGetText(basicCreate.edit[1]) )
	local y = tonumber( guiGetText(basicCreate.edit[2]) )
	local width = tonumber( guiGetText(basicCreate.edit[3]) ) - x
	local height = tonumber( guiGetText(basicCreate.edit[4]) ) - y
	
	local row = guiComboBoxGetSelected(basicCreate.combobox[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("ERROR: Turfing mode not selected. Please select a turfing mode.", 255, 25, 25)
		return
	end
	local type_ = guiComboBoxGetItemText(basicCreate.combobox[1], row)
	
	local arg1
	if (type_ == "Kill Points (LS)") then
		for i=1,3 do
			local text = guiGetText(pointsCreate.edit[1])
			if (text == "" or not tonumber(text)) then
				exports.GTIhud:dm("ERROR: Respawn Position Information Missing. Cannot create turf.", 255, 25, 25)
				return
			end
		end
		local x,y,z = guiGetText(pointsCreate.edit[1]), guiGetText(pointsCreate.edit[3]), guiGetText(pointsCreate.edit[2])
		arg1 = {tonumber(x), tonumber(y), tonumber(z)}
	end
	
	triggerServerEvent("GTIturfing.createTurf", resourceRoot, x, y, width, height, type_, arg1)
	
	for i=1,4 do
		guiSetText(basicCreate.edit[i], "")
	end
	
	if (prev_turf) then
		destroyElement(prev_turf)
		prev_turf = nil
	end
	if (prev_col) then
		destroyElement(prev_col)
		prev_col = nil
	end
end, false)

-- Live Preview
---------------->>

function updateTurfPreview()
	for i=1,4 do
		local text = guiGetText(basicCreate.edit[i])
		if (text == "" or not tonumber(text)) then
			return
		end
	end
	
	local swX = tonumber( guiGetText(basicCreate.edit[1]) )
	local swY = tonumber( guiGetText(basicCreate.edit[2]) )
	local neX = tonumber( guiGetText(basicCreate.edit[3]) )
	local neY = tonumber( guiGetText(basicCreate.edit[4]) )
	
	if (prev_turf) then destroyElement(prev_turf) end
	prev_turf = createRadarArea(swX, swY, neX-swX, neY-swY, DEF_R, DEF_G, DEF_B, DEF_A, localPlayer)
		
	if (prev_col) then destroyElement(prev_col) end
	prev_col = createColRectangle(swX, swY, neX-swX, neY-swY)
end

-- Utilities
------------->>

function toggleCursor()
	if (isCursorShowing()) then
		showCursor(false)
	else
		showCursor(true)
	end
end