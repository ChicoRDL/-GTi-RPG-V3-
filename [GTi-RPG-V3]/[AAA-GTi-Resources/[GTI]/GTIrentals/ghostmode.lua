----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 07 Mar 2015
-- Resource: GTIrentals/ghostmode.lua
-- Version: 1.0
----------------------------------------->>

-- Ghostmode for Players
------------------------->>

addEventHandler("onClientElementStreamIn", resourceRoot, function()
	if getElementType(source) == "object" then return false end
	if (not getElementData(source, "rental")) then return end
	setElementCollidableWith(source, localPlayer, false)
end)

-- Ghostmode for Vehicles
-------------------------->>

addEventHandler("onClientElementStreamIn", resourceRoot, function()
	if getElementType(source) == "object" then return false end
	if (not getElementData(source, "rental")) then return end
	for i,vehicle in ipairs(getElementsByType("vehicle", root, true)) do	
		setElementCollidableWith(source, vehicle, false)
	end
end)

addEventHandler("onClientElementStreamIn", root, function()
	if getElementType(source) == "object" then return false end
	for i,vehicle in ipairs(getElementsByType("vehicle", resourceRoot, true)) do
		if (getElementData(vehicle, "rental")) then
			setElementCollidableWith(source, vehicle, false)
		end
	end
end)

-- Toggle Ghostmode
-------------------->>

addEvent("GTIrentals.removeGhostmode", true)
addEventHandler("GTIrentals.removeGhostmode", root, function()
	for i,vehicle in ipairs(getElementsByType("vehicle")) do
		if (not getElementData(vehicle, "rental")) then
			setElementCollidableWith(source, vehicle, true)
		end
	end
	setElementCollidableWith(source, localPlayer, true)
end)

-- Render Alpha
---------------->>

addEvent("GTIrentals.destroyRental", true)
addEventHandler("GTIrentals.destroyRental", root, function()
	local car = source
	local render = function()
		if (not isElement(car)) then return end
		if (not isTimer(timer)) then return end
		local timeLeft = getTimerDetails(timer)
		setElementAlpha(car, timeLeft/500*255)
	end
	addEventHandler("onClientRender", root, render)
	timer = setTimer(function() 
		removeEventHandler("onClientRender", root, render)
		timer = nil
	end, 500, 1)
end)
