----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 07 Nov 2014
-- Resource: GTIhousing/creation.lua
-- Version: 1.0
----------------------------------------->>

-- Show House Creation
----------------------->>

addEvent("GTIhousing.createHouse", true)
addEventHandler("GTIhousing.createHouse", root, function()
	guiSetText(creation.edit[2], "")
	if (not guiGetVisible(creation.window[1])) then
		guiSetVisible(creation.window[1], true)
		showCursor(true)
		bindKey("x", "down", toggleCursor)
	else
		guiSetVisible(creation.window[1], false)
		showCursor(false)
		unbindKey("x", "down", toggleCursor)
	end
end)

-- Get Garage Coords
--------------------->>

function getGarageCoords()
	local x,y,z = getElementPosition(localPlayer)
	local _,_,rot = getElementRotation(localPlayer)
	local x,y,z,rot = string.format("%.3f",x), string.format("%.3f",y), string.format("%.3f",z), string.format("%.3f",rot)
	guiSetText(creation.edit[2], x..", "..y..", "..z..", "..rot)
end

addEventHandler("onClientGUIClick", creation.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	getGarageCoords()
end, false)

addCommandHandler("house-gar", function()
	getGarageCoords()
end)

-- Create House
---------------->>

addEventHandler("onClientGUIClick", creation.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	local address = guiGetText(creation.edit[1])
	if (#address == 0) then
		outputChatBox("* Housing: Enter a valid address.", 50, 255, 125)
		return
	end
	local coords = guiGetText(creation.edit[2])
	if (#coords == 0 or #split(string.gsub(coords, " ", ""), ",") ~= 4) then
		outputChatBox("* Housing: Get the coordinates for this house's garage.", 50, 255, 125)
		return
	end
	local cost = guiGetText(creation.edit[3])
	if (#cost == 0 or not tonumber(cost)) then
		outputChatBox("* Housing: Enter a valid cost.", 50, 255, 125)
		return
	end
	local int_id = guiGetText(creation.edit[4])
	if (#int_id == 0 or not tonumber(int_id)) then
		outputChatBox("* Housing: Enter a valid interior ID.", 50, 255, 125)
		return
	end
	
	local x,y,z = getElementPosition(localPlayer)
	local int,dim = getElementInterior(localPlayer), getElementDimension(localPlayer)
	local location = {tonumber(string.format("%.3f",x)), tonumber(string.format("%.3f",y)), tonumber(string.format("%.3f",z)), int, dim}
	local garage = split(string.gsub(coords, " ", ""), ",")
	local garage = {tonumber(garage[1]), tonumber(garage[2]), tonumber(garage[3]), tonumber(garage[4])}
	
	--guiSetText(creation.edit[2], "")
	triggerServerEvent("GTIhousing.createHouse", resourceRoot, address, location, garage, tonumber(int_id), tonumber(cost))
end, false)

-- Utilities
------------->>

function toggleCursor()
	if (isCursorShowing()) then
		showCursor(false)
	else
		showCursor(true)
	end
end
