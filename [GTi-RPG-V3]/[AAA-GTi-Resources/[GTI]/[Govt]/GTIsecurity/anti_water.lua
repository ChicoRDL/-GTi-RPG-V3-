setTimer(
	function()
		if ( isPedInWater(localPlayer) ) then
			x, y, z = getElementPosition(localPlayer)
			waterLevel = getWaterLevel(x, y, z) or 0
			setElementData(localPlayer, "water_level", waterLevel)
		end
	end, 1000, 0
)

