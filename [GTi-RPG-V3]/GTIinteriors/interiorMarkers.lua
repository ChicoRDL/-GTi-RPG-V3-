----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 01 Jan 2014
-- Resource: GTIinteriors/interiorMarkers.slua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

addEvent("onClientInteriorEnter", true)
addEvent("onClientInteriorExit", true)

local SPEED = 350 		-- How fast the marker animates
local AMPLITUDE = 0.5	-- How high the marker goes

-- Animate Markers
------------------->>

local timer = setTimer(function() end, 1000, 0)
function animateMarkers()
	for i,marker in ipairs(getElementsByType("marker", resourceRoot, true)) do
		local orgZ = getElementData(marker, "originalZ")
		local tick = getTickCount()/SPEED
		local z = math.sin(tick) * AMPLITUDE
		local x,y = getElementPosition(marker)
		setElementPosition(marker, x, y, orgZ+z)
	end
end
addEventHandler("onClientRender", root, animateMarkers)
