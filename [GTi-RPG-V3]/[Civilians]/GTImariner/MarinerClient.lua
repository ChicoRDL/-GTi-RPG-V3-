payammount = 0
cargo = 0
dist = 0
currentCount = 0
currentMinute = 0
local loc = {
	{-1560.554, 1258.984, -1.550},
	{-2217.853, 2406.905, -1.550},
	{-2961.849, 498.412, -1.550},
	{-1179.088, 71.844, -1.550},
	{101.857, -1963.201, -1.550},
	{731.173, -1496.394, -1.550},
	{2740.818, -2588.419, -1.550},
	{2501.534, -2274.249, -1.550},
	{2304.158, -2424.027, -1.550},
	{2705.271, -2305.197, -1.550},
	{2277.587, 533.399, -1.550},
	{2384.829, 531.557, -1.550},
	{1609.103, 586.370, -1.550},
	{-791.712, 1817.325, -1.550},
	{-630.211, 1804.980, -1.550},
	{-424.017, 1152.525, -1.550},
}

function randoml ()
    return unpack( loc [math.random (#loc)] )
end

function spawnBoat ( )
	if exports.GTIemployment:getPlayerJob(true) == "Mariner" then
		triggerServerEvent ("GTImariner_SpawnBoatOnJob",  localPlayer )
		mission()
	end
end
addEvent ("onClientPlayerGetJob", true )
addEventHandler ("onClientPlayerGetJob", root, spawnBoat )

function mission()
	if not isElement(marker) and not isElement(Nmarker) and (exports.GTIemployment:getPlayerJob(true) == "Mariner") then
		local x1, y1, z1 = randoml ()
		marker = createMarker ( x1, y1, z1, "cylinder", 6, 255, 255, 50, 170 )
		blip = createBlipAttachedTo(marker, 41)
		local loca = getZoneName(x1,y1,z1)
		local d1x, d1y, d1z = getElementPosition ( marker )
		local d2x, d2y, d2z = getElementPosition ( localPlayer )
		local distance = getDistanceBetweenPoints3D(d1x,d1y,d1z,d2x,d2y,d2z)
		payammount = payammount + distance
		dist = distance/1000
		local theBoat = getPedOccupiedVehicle(localPlayer)
		setElementFrozen(theBoat,false)
		toggleControl("enter_exit", true)
		if  ( getElementModel ( theBoat ) == 452 ) then
			local rand = math.random(1,3)
			if rand == 1 or rand == 2 then 
				exports.GTIhud:dm("The packages need to be delivered in "..loca, 255, 255, 0)
			end
			if rand == 3 then
				currentMinute = math.ceil(dist*1.5)
				if currentMinute == 0 then
					currentMinute = 1 
				end
				exports.GTIhud:dm("The packages need to be delivered in "..loca..". You have "..currentMinute.." minutes to get there. BE FAST!", 255, 255, 0)
				missTimer = setTimer(missionTimer,1000,0)
			end
		elseif  ( getElementModel ( theBoat ) == 446 ) then
			local rand = math.random(1,3)
			if rand == 1 or rand == 2 then 
				exports.GTIhud:dm("The passengers have requested to go in "..loca, 255, 255, 0)
			end
			if rand == 3 and cargo > 1 then
				currentMinute = math.ceil(dist)
				if currentMinute == 0 then
					currentMinute = 1 
				end
				exports.GTIhud:dm("The passengers have requested to go in "..loca..". They have a meeting in "..currentMinute.." minutes. BE FAST!", 255, 255, 0)
				missTimer = setTimer(missionTimer,1000,0)
			end
		end
			-- Add Distance for Progress
		dist = payammount 
	end
end

function getMission()
	if not isElement(marker) and not isElement(Nmarker) and (exports.GTIemployment:getPlayerJob(true) == "Mariner") then
		local x1, y1, z1 = randoml ()
		Nmarker = createMarker ( x1, y1, z1, "cylinder", 6, 255, 255, 50, 170 )
		Nblip = createBlipAttachedTo(Nmarker, 41)
		local loca = getZoneName(x1,y1,z1)
		local theBoat = getPedOccupiedVehicle(localPlayer)
			-- Count from where they start the mission so player's aren't cheated out of money they should earn
		local d2x, d2y, d2z = getElementPosition( localPlayer )
		payammount = getDistanceBetweenPoints3D(x1, y1, z1, d2x, d2y, d2z)
		
		if ( getElementModel ( theBoat ) == 452 ) then
			exports.GTIhud:dm("Some packages need to be transported, go pick them up in "..loca, 255, 255, 0)
			setElementFrozen(theBoat,false)
			toggleControl("enter_exit", true)
			exports.GTIhud:drawStat("MarinerID", "cargo", cargo.." KG", 255, 200, 0)	
		elseif ( getElementModel ( theBoat ) == 446 ) then
			exports.GTIhud:dm("Some people need a ride, go pick them up in "..loca, 255, 255, 0)
			setElementFrozen(theBoat,false)
			toggleControl("enter_exit", true)
			exports.GTIhud:drawStat("MarinerID", "Passengers", cargo, 255, 200, 0)
		end
	end
end 
addEvent("GTIMariner.getMission", true)
addEventHandler("GTIMariner.getMission", root, getMission)

function load(thePlayer)
	local theBoat = getPedOccupiedVehicle(thePlayer)
    if ( source == Nmarker ) and ( thePlayer == localPlayer) and ( exports.GTIutil:getElementSpeed(theBoat, "mph") < 40 ) then
		if ( getElementModel ( theBoat ) == 452 ) then
			local x,y,z = getElementPosition(theBoat)
			setElementFrozen(theBoat,true)
			toggleControl("enter_exit", false)
			destroyElement(Nmarker)
			destroyElement(Nblip)
			exports.GTIhud:drawProgressBar("MarinerPro", "NOW LOADING...", 255, 200, 0, 9000)
			loadTimer1 = setTimer(mission, 9000, 1)
			num = math.random(16,25)
			loadTimer2 = setTimer(function()
				cargo = cargo + 1
				exports.GTIhud:drawStat("MarinerID", "cargo", cargo.." KG", 255, 200, 0)
			end,9000/num,num)
			loadTimer3 = setTimer(function()
				box = createObject(1421,x,y,z)
				setElementCollisionsEnabled(box,false)
				attachElements(box,theBoat,0,2,1.2)
			end, 4500, 1)
		elseif ( getElementModel ( theBoat ) == 446 ) then
			local x,y,z = getElementPosition(theBoat)
			local rx,ry,rz = getElementRotation(theBoat)
			setElementFrozen(theBoat,true)
			toggleControl("enter_exit", false)
			destroyElement(Nmarker)
			destroyElement(Nblip)
			exports.GTIhud:drawProgressBar("MarinerPro", "NOW BOARDING...", 255, 50, 50, 9000)
			loadTimer1 = setTimer(mission, 9000, 1)
			peds = math.random(1,3)
			loadTimer7 = setTimer(setRot, 200, 0)
			if peds == 1 then 
				loadTimer3 = setTimer(function()
				ped1 = createPed(math.random(168,189),x,y,z,rx+260)
				setElementCollisionsEnabled(ped1,false)
				setPedAnimation( ped1, "CAR", "sit_relaxed")
				attachElements(ped1,theBoat,0,-1.14,1)
				cargo = 1
				end, 9000, 1)
			end
			if peds == 2 then 
				loadTimer3 = setTimer(function()
					ped1 = createPed(math.random(190,207),x,y,z)
					setElementCollisionsEnabled(ped1,false)
					setPedAnimation( ped1, "CAR", "sit_relaxed")
					attachElements(ped1,theBoat,0,-1.14,1,rx+260)
					cargo = 2
				end, 4500, 1)
				loadTimer5 = setTimer(function()
					ped2 = createPed(math.random(9,29),x,y,z)
					setElementCollisionsEnabled(ped2,false)
					setPedAnimation( ped2, "CAR", "sit_relaxed")
					attachElements(ped2,theBoat,0.8,-1.14,1,rx,0)
				end, 9000, 1)
			end
			if peds == 3 then 
				loadTimer3 = setTimer(function()
					ped1 = createPed(math.random(30,41),x,y,z,rx+260)
					setElementCollisionsEnabled(ped1,false)
					setPedAnimation( ped1, "CAR", "sit_relaxed")
					attachElements(ped1,theBoat,0,-1.14,1)
					cargo = 3
				end, 3000, 1)
				loadTimer5 = setTimer(function()
					ped2 = createPed(math.random(43,52),x,y,z,rx+260)
					setElementCollisionsEnabled(ped2,false)
					setPedAnimation( ped2, "CAR", "sit_relaxed")
					attachElements(ped2,theBoat,0.8,-1.14,1)
				end, 6000, 1) 
				loadTimer6 = setTimer(function()
					ped3 = createPed(math.random(87,99),x,y,z,rx+260)
					setElementCollisionsEnabled(ped3,false)
					setPedAnimation( ped3, "CAR", "sit_relaxed")
					attachElements(ped3,theBoat,-0.8,-1.14,1)
				end, 9000, 1)
			end
			loadTimer2 = setTimer(function()
				exports.GTIhud:drawStat("MarinerID", "Passengers", cargo, 255, 200, 0)
			end,9000,1)
		end
	end
end
addEventHandler("onClientMarkerHit",root,load)

function setRot()
	local theBoat = getPedOccupiedVehicle(localPlayer)
	local rx,ry,rz = getElementRotation(theBoat)
	if isElement(ped1) then 
		setElementRotation(ped1,rx,ry,rz) 
	end
	if isElement(ped2) then 
		setElementRotation(ped2,rx,ry,rz) 
	end
	if isElement(ped3) then 	
		setElementRotation(ped3,rx,ry,rz) 
	end
end

function unload(thePlayer)
	local theBoat = getPedOccupiedVehicle(thePlayer)
    if ( source == marker ) and ( thePlayer == localPlayer) and ( exports.GTIutil:getElementSpeed(theBoat, "mph") < 40 ) then
		setElementFrozen(theBoat,true)
		toggleControl("enter_exit", false)
		destroyElement(marker)
		destroyElement(blip)
		if isTimer(missTimer) then killTimer(missTimer) end
		currentCount = 0
		currentMinute = 0
		unloadTimer1 = setTimer(getMission, 11000, 1)
		if  ( getElementModel ( theBoat ) == 452 ) then
			exports.GTIhud:drawProgressBar("MarinerPro", "UNLOADING...", 255, 200, 0, 9000)
			unloadTimer2 = setTimer(function()
				cargo = cargo - 1
				exports.GTIhud:drawStat("MarinerID", "cargo", cargo.." KG", 255, 200, 0)
				if cargo < 1 then killTimer(unloadTimer2) end
			end,9000/num,num)
			unloadTimer3 = setTimer(destroyElement, 4500, 1, box)
			payTimer = setTimer(pay,9000,1)
		end
		if  ( getElementModel ( theBoat ) == 446 ) then
			if isTimer(loadTimer7) then killTimer(loadTimer7) end
			exports.GTIhud:drawStat("MarinerID", "Passengers", cargo, 255, 200, 0)
			exports.GTIhud:drawProgressBar("MarinerPro", "DEBARKING...", 255, 50, 50, 9000)
			unloadTimer2 = setTimer(function()
				cargo = 0
				exports.GTIhud:drawStat("MarinerID", "Passengers", cargo, 255, 200, 0)
				if cargo < 1 then killTimer(unloadTimer2) end
			end,9000,1)
			if isElement(ped3) then
				unloadTimer3 = setTimer(destroyElement, 3000, 1, ped3)
			end
			if isElement(ped2) then
				unloadTimer4 = setTimer(destroyElement, 6000, 1, ped2)
			end
			if isElement(ped1) then
				unloadTimer5 = setTimer(destroyElement, 9000, 1, ped1)
			end
			payTimer = setTimer(pay,9000,1)
		end
	end
end
addEventHandler("onClientMarkerHit",root,unload)

function pay()
	triggerServerEvent("GTIMariner.getpaid", resourceRoot, payammount, dist)
end

viewCount2 = "0"
viewCount3 = "0"
function missionTimer()
	if currentCount > 0 then
		currentCount = currentCount - 1
	end
    if currentCount == 0 and currentMinute > 0 then
		currentCount = 59
		currentMinute = currentMinute - 1
	end
	if currentCount == 0 and currentMinute == 0 then
		exports.GTIhud:dm("Time's up! Your pay will be cut by 50%.", 255, 0, 0)
		payammount = payammount/2
		exports.GTIhud:drawStat("MarinerID", "cargo", cargo.."KG", 255, 200, 0)
		killTimer(missTimer)
	end
        if currentCount < 10 then
            viewCount3 = tostring( "0"..currentCount)
            exports.GTIhud:drawStat("MarinerID","Time left:",viewCount2..":"..viewCount3, 255, 0, 0)
        else
            viewCount3 = tostring( currentCount)
			exports.GTIhud:drawStat("MarinerID","Time left:",viewCount2..":"..viewCount3, 255, 0, 0)
        end
    if currentMinute < 10 then
		viewCount2 = tostring( "0"..currentMinute)
		exports.GTIhud:drawStat("MarinerID","Time left:",viewCount2..":"..viewCount3, 255, 0, 0)
    else
		viewCount2 = tostring( currentMinute)
		exports.GTIhud:drawStat("MarinerID","Time left:",viewCount2..":"..viewCount3, 255, 0, 0)
    end
end

function onJobQuit(job)
    if ( job == "Mariner" ) then 
		if isElement(marker) then destroyElement(marker) end
		if isElement(blip) then destroyElement(blip) end
		if isElement(Nmarker) then destroyElement(Nmarker) end
		if isElement(Nblip) then destroyElement(Nblip) end
		if isElement(box) then destroyElement(box) end
		if isTimer(unloadTimer1) then killTimer(unloadTimer1) end
		if isTimer(unloadTimer2) then killTimer(unloadTimer2) end
		if isTimer(unloadTimer3) then killTimer(unloadTimer3) end
		if isTimer(loadTimer1) then killTimer(loadTimer1) end
		toggleControl("enter_exit", true)
		if isTimer(loadTimer2) then killTimer(loadTimer2) end
		if isTimer(loadTimer3) then killTimer(loadTimer3) end
		if isTimer(missTimer) then killTimer(missTimer) end
		if isTimer(payTimer) then killTimer(payTimer) end
		if isTimer(loadTimer4) then killTimer(loadTimer4) end
		if isTimer(loadTimer5) then killTimer(loadTimer5) end
		if isTimer(loadTimer6) then killTimer(loadTimer6) end
		if isTimer(loadTimer7) then killTimer(loadTimer7) end
		if isTimer(unloadTimer4) then killTimer(unloadTimer4) end
		if isTimer(unloadTimer5) then killTimer(unloadTimer5) end
		if isElement(ped1) then destroyElement(ped1) end
		if isElement(ped2) then destroyElement(ped2) end
		if isElement(ped3) then destroyElement(ped3) end
		exports.GTIhud:drawStat("MarinerID", "", "", 255, 200, 0)
		exports.GTIhud:drawProgressBar("MarinerPro", "", 255, 50, 50, 0)
		payammount = 0
		cargo = 0
		dist = 0
		currentCount = 0
		currentMinute = 0
	end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, onJobQuit)

function delelem(thePlayer)
	if (exports.GTIemployment:getPlayerJob(true) == "Mariner") then
		if isElement(marker) then destroyElement(marker) end
		if isElement(blip) then destroyElement(blip) end
		if isElement(Nmarker) then destroyElement(Nmarker) end
		if isElement(Nblip) then destroyElement(Nblip) end
		if isElement(box) then destroyElement(box) end
		if isTimer(unloadTimer1) then killTimer(unloadTimer1) end
		if isTimer(unloadTimer2) then killTimer(unloadTimer2) end
		if isTimer(unloadTimer3) then killTimer(unloadTimer3) end
		if isTimer(loadTimer1) then killTimer(loadTimer1) end
		toggleControl("enter_exit", true)
		if isTimer(loadTimer2) then killTimer(loadTimer2) end
		if isTimer(loadTimer3) then killTimer(loadTimer3) end
		if isTimer(missTimer) then killTimer(missTimer) end
		if isTimer(payTimer) then killTimer(payTimer) end
		if isTimer(loadTimer4) then killTimer(loadTimer4) end
		if isTimer(loadTimer5) then killTimer(loadTimer5) end
		if isTimer(loadTimer6) then killTimer(loadTimer6) end
		if isTimer(loadTimer7) then killTimer(loadTimer7) end
		if isTimer(unloadTimer4) then killTimer(unloadTimer4) end
		if isTimer(unloadTimer5) then killTimer(unloadTimer5) end
		if isElement(ped1) then destroyElement(ped1) end
		if isElement(ped2) then destroyElement(ped2) end
		if isElement(ped3) then destroyElement(ped3) end
		exports.GTIhud:drawStat("MarinerID", "", "", 255, 200, 0)
		exports.GTIhud:drawProgressBar("MarinerPro", "", 255, 50, 50, 0)
		payammount = 0
		cargo = 0
		dist = 0
		currentCount = 0
		currentMinute = 0
	end
end
addEvent("onClientRentalVehicleHide", true)
addEventHandler ("onClientRentalVehicleHide", root, delelem)
addEventHandler ("onClientPlayerWasted", localPlayer, delelem)

addEventHandler ( "onClientPedDamage", resourceRoot, function ( )
	cancelEvent()
end )
