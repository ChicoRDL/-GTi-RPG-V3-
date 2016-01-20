----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 12 Mar 2015
-- Resource: GTIvehChallenges/bmx_challenge.lua
-- Version: 1.0
----------------------------------------->>

local hit_markers = {
	{1907.730, -1389.594, 10.359},
	{1880.825, -1428.217, 10.366},
	{1870.707, -1450.850, 15.681},
	{1918.794, -1426.454, 15.806},
	{1950.500, -1425.507, 10.359},
	{1950.724, -1411.424, 17.459},
	{1928.502, -1396.620, 17.459},
	{1906.945, -1410.609, 13.570},
	{1900.485, -1399.939, 17.459},
	{1870.133, -1404.193, 13.535},
	{1878.103, -1385.335, 14.296},
	{1878.103, -1385.335, 17.459},
	{1908.495, -1360.479, 13.527},
	{1911.928, -1368.105, 17.459},
	{1938.987, -1385.005, 21.688},
	{1882.774, -1407.162, 17.459},
	{1954.427, -1377.456, 25.282},
	{1954.316, -1366.888, 25.482},
	{1886.557, -1362.965, 19.141},
}

local BMX_arena = createColCuboid(1861, -1451, 8, 116, 101, 20)

local bicycle = {[509] = true, [481] = true, [510] = true}

local startMatrix = {1961.836, -1364.486, 29.188, 1959.433, -1366.964, 28.166}

local colMarkers = {}	-- Table of Markers by Col
local colBlips = {}		-- Table of Blips by Col

local bmxMission	-- Is Mission in Progress?
local bmxTime		-- Time Remaining in Mission
local bmxTimer		-- Timer that Decrements bmxTime
local bmxStartTime	-- BMX Challenge Start Time

-- Enable BMX Challenge
------------------------>>

addEventHandler("onClientColShapeHit", BMX_arena, function(player, dim)
	if (player ~= localPlayer or not dim) then return end
	setBMXChallengeAvailable(player)
end)

addEventHandler("onClientVehicleEnter", root, function(player, seat)
	if (player ~= localPlayer or seat ~= 0) then return end
	setBMXChallengeAvailable(player)
end)

function setBMXChallengeAvailable(player)
	if (bmxMission) then return end
	if (not isPedInVehicle(player)) then return end
	local vehicle = getPedOccupiedVehicle(player)
	if (not bicycle[getElementModel(vehicle)]) then return end
	if (not isElementWithinColShape(player, BMX_arena)) then return end
	
	exports.GTIhud:drawNote("BMXChallenge", "Press [N] to begin the BMX Challenge", 0, 150, 200, 7500)
	bindKey("n", "up", startBMXChallenge)
end

addEventHandler("onClientColShapeLeave", BMX_arena, function(player, dim)
	if (player ~= localPlayer  or not dim) then return end
	setBMXChallengeUnavailable(player)
end)

addEventHandler("onClientVehicleExit", root, function(player, seat)
	if (player ~= localPlayer or seat ~= 0) then return end
	if (not bicycle[getElementModel(source)]) then return end
	setBMXChallengeUnavailable(player)
end)

function setBMXChallengeUnavailable(player)
	exports.GTIhud:drawNote("BMXChallenge", nil)
	unbindKey("n", "up", startBMXChallenge)
end

-- Start BMX Challenge
----------------------->>

function startBMXChallenge()
	if (bmxMission) then return end
	if (not isPedInVehicle(localPlayer)) then return end
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (not bicycle[getElementModel(vehicle)]) then return end
		-- Generate Markers
	for i,v in ipairs(hit_markers) do
		local marker = createMarker(v[1], v[2], v[3], "ring", 1, 255, 0, 0, 125)
		local col = createColSphere(v[1], v[2], v[3], 2)
		local blip = createBlip(v[1], v[2], v[3], 0, 3, 255, 25, 25)
		setElementData(col, "owner", localPlayer, false)
		colMarkers[col] = marker
		colBlips[col] = blip
	end
	
	setCameraMatrix(startMatrix[1], startMatrix[2], startMatrix[3], startMatrix[4], startMatrix[5], startMatrix[6])
	unbindKey("n", "up", startBMXChallenge)
	toggleAllControls(false)
	bmxMission = true
	
	exports.GTIhud:drawNote("BMXChallenge", nil)
	exports.GTIhud:dm("Collect all of the checkpoints before time runs out.", 0, 150, 200)
	exports.GTIhud:drawMissionText("BMXChallenge", "BMX Challenge", 0, 150, 200)
	
	bmxStartTime = getTickCount()
	
	setTimer(function()
		setCameraTarget(localPlayer)
		toggleAllControls(true)
		bmxTime = 10
		
		bmxTimer = setTimer(function()
			bmxTime = bmxTime - 1
			if (bmxTime == -1) then
				stopBMXChallenge()
				exports.GTIhud:drawMissionEvent(false)
				exports.GTIhud:dm("MISSION FAILED: You failed to collect all the markers in time.", 255, 25, 25)
				return
			end
			if (bmxTime <= 10) then
				playSoundFrontEnd(44)
			end
		end, 1000, 0)
		
		addEventHandler("onClientRender", root, renderTime)
	end, 5000, 1)
end

-- BMX Challenge Functions
--------------------------->>

addEventHandler("onClientColShapeHit", resourceRoot, function(player, dim)
	if (player ~= localPlayer or not dim) then return end
	if (getElementData(source, "owner") ~= localPlayer) then return end
	
	if (not isPedInVehicle(localPlayer)) then return end
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (not bicycle[getElementModel(vehicle)]) then return end
		
	destroyElement(source)
	destroyElement(colMarkers[source])
	colMarkers[source] = nil
	destroyElement(colBlips[source])
	colBlips[source] = nil
	
	-- If There are More Markers
	if (#getElementsByType("colshape", resourceRoot) > 1) then
		bmxTime = bmxTime + 10
		exports.GTIhud:drawNote("BMXTime+"..math.random(1000), "+ 10 seconds", 255, 255, 255, 7500)
	else
	-- Otherwise End the Mission	
		triggerServerEvent("GTIvehChallenges.bmxChallengeComplete", resourceRoot, getTickCount() - bmxStartTime)
		stopBMXChallenge()
	end
end)

function renderTime()
	if (not bmxTime or not bmxMission) then
		removeEventHandler("onClientRender", root, renderTime)
		return
	end
	local mins = string.format("%02d", bmxTime/60)
	local sec = string.format("%02d", bmxTime%60)
	exports.GTIhud:drawStat("BMXTime", "Time Left", mins..":"..sec, 255, 255, 255, 1000)
end

-- Cancel BMX Challenge
------------------------>>

function stopBMXChallenge()
	for i,colshape in ipairs(getElementsByType("colshape", resourceRoot)) do
		if (colshape ~= BMX_arena) then
			destroyElement(colshape)
			destroyElement(colMarkers[colshape])
			colMarkers[colshape] = nil
			destroyElement(colBlips[colshape])
			colBlips[colshape] = nil
		end
	end
	if (isTimer(bmxTimer)) then
		killTimer(bmxTimer)
		bmxTimer = nil
	end
	bmxMission = nil
	bmxTime	= nil
	bmxStartTime = nil
	
	exports.GTIhud:drawStat("BMXTime", nil, nil)
end
