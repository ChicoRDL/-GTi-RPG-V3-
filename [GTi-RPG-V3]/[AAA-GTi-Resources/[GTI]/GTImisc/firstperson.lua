local enabled = true

addEventHandler( "onClientRender", root,
	function()
		if enabled then
			local x, y, z, lX, lY, lZ = getCameraMatrix()
			camera_angle = (( 360 - math.deg( math.atan2(( x - lX), (y - lY)))) % 360) - 180
			setPedRotation( localPlayer, camera_angle)
		end
	end
)

addCommandHandler( "firstperson",
	function()
		if enabled then
			exports.GTIhud:dm( "You have disabled first person view.", 208, 50, 80)
			enabled = false
		else
			exports.GTIhud:dm( "You have enabled first person view.", 208, 50, 80)
			enabled = true
		end
	end
)
