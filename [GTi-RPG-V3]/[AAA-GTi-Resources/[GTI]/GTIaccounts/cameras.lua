cameraPos = { 
	{ 1, 2, 3, 4, 5, 6, 7, 8},
	{ 1, 2, 3, 4, 5, 6, 7, 8},
	{ 1, 2, 3, 4, 5, 6, 7, 8},
	{ 1, 2, 3, 4, 5, 6, 7, 8}
}

local cameraT

function startTransitions()
	changeCamera()
	setTimer ( fadeCamera, 4000, 0, false, 1)
	setTimer ( changeCamera, 6000, 0)
end

function changeCamera ()
	local index = cameraPos[math.random(#cameraPos)]
	local x, y, z, lx, ly, lz, r, f = cameraPos[index][1], cameraPos[index][2], cameraPos[index][3], cameraPos[index][4], cameraPos[index][5], cameraPos[index][6], cameraPos[index][7], cameraPos[index][8]
	setCameraMatrix( x, y, z, lx, ly, lz, r, f)
	fadeCamera(true, 1)
end

function stopTransitions()
	killTimer(cameraT)
	fadeCamera(true)
end

