trashN = 0
location = nil
local Trashesloc1 = {
{199.635, -1384.151, 48.288},
{264.545, -1332.778, 52.842},
{284.777, -1320.584, 53.423},
{350.070, -1278.352, 53.538},
{402.468, -1255.487, 51.732},
{415.234, -1249.662, 51.103},
{543.424, -1200.640, 44.006},
{619.909, -1103.393, 46.252},
{659.012, -1063.778, 48.493},
{677.497, -1069.036, 48.712},
}
local Trashesloc2 = {
{2480.138, -1249.071, 28.771},
{2496.499, -1248.516, 33.210},
{2514.310, -1247.950, 34.621},
{2536.332, -1249.731, 38.633},
{2555.955, -1249.126, 44.265},
{2577.977, -1238.393, 47.431},
{2577.170, -1225.518, 51.642},
{2577.210, -1208.793, 57.449},
{2561.283, -1193.017, 61.353},
{2526.050, -1194.894, 56.032},
}
local Trashesloc3 = {
{643.592, -1714.940, 13.869},
{645.801, -1696.937, 14.429},
{648.737, -1657.511, 14.436},
{647.174, -1623.309, 14.627},
{674.267, -1594.801, 13.726},
{686.016, -1596.271, 13.664},
{759.969, -1600.941, 13.008},
{760.309, -1652.133, 4.426},
{762.769, -1696.082, 4.356},
{763.332, -1748.384, 12.215},
}
local Trashesloc4 = {
{1908.960, -2042.664, 13.099},
{1891.471, -2038.851, 13.107},
{1892.379, -2030.646, 13.107},
{1891.180, -2022.357, 13.099},
{1883.950, -2014.897, 13.107},
{1873.925, -2019.302, 13.107},
{1874.098, -2033.219, 13.107},
{1873.440, -2061.300, 13.107},
{1894.631, -2061.908, 13.107},
{1915.491, -2061.279, 13.107},
}
local Trashesloc5 = {
{2261.917, -1477.939, 22.529},
{2247.724, -1476.463, 22.945},
{2229.568, -1475.667, 23.416},
{2205.066, -1464.564, 23.544},
{2204.570, -1449.708, 23.544},
{2204.010, -1433.032, 23.544},
{2203.836, -1408.913, 23.544},
{2169.046, -1393.510, 23.544},
{2138.537, -1409.911, 23.546},
{2138.457, -1439.989, 23.542},
}
local ctrls ={
"sprint",
"jump",
"enter_exit",
"enter_passenger",
"fire", 
"crouch", 
"aim_weapon",
"next_weapon",
"previous_weapon",
}
function randomt()
	local Table = math.random(1,5)
	if Table == 1 then 
		return Trashesloc1
	elseif Table == 2 then
		return Trashesloc2
	elseif Table == 3 then
		return Trashesloc3
	elseif Table == 4 then
		return Trashesloc4
	elseif Table == 5 then
		return Trashesloc5
	end
end

addEvent("GTITrashCollector.onWasteEnter", true)
addEventHandler("GTITrashCollector.onWasteEnter", root, function()
	if (exports.GTIemployment:getPlayerJob(true) == "Trash Collector") and not (isElement(theTrash)) then
		if location == nil then
			newMission()
		end
	end
end )
function Mission()
	if trashN < 10 then
		local x1, y1, z1 = unpack(location[trashN+1])
		takeTrashmarker = createColSphere ( x1, y1, z1, 1.5 ) 
		triggerServerEvent("GTITrashCollector.freeze", resourceRoot, false)
		blip = createBlipAttachedTo(takeTrashmarker, 0, 1.5, 51, 204, 0)
		theTrash = createObject(1264,x1,y1,z1)
		setElementCollisionsEnabled(theTrash,false)
		attachElements(takeTrashmarker,theTrash,0,0,0,0,0,0)
		theArrow = createMarker ( x1, y1, z1, "arrow", 1, 51, 204, 0, 170 )
		attachElements(theArrow,theTrash,0,0,1.3,0,0,0)
	else
		if not isElement(paymarker) and not isTimer(paytimer) then
			triggerServerEvent("GTITrashCollector.freeze", resourceRoot, false)
			exports.GTIhud:dm("Return to the dump to get paid.", 255, 255, 0) 
			paymarker = createMarker (-47.427, -1124.002, 0.078, "cylinder", 4, 255, 255, 0, 170 )
			payblip = createBlipAttachedTo(paymarker,41)
		end
	end
end
function newMission()
	if (getElementModel(getPedOccupiedVehicle(localPlayer)) == 408) then
		location = randomt()
		local x1, y1, z1 = unpack(location[trashN+1])
		local loca = getZoneName(x1,y1,z1)
		exports.GTIhud:dm("You've been requested to pick up rubbish in "..loca, 255, 255, 0)
		takeTrashmarker = createColSphere ( x1, y1, z1, 1 ) 
		blip = createBlipAttachedTo(takeTrashmarker, 0, 3.5, 51, 204, 0)
		theTrash = createObject(1264,x1,y1,z1)
		setElementCollisionsEnabled(theTrash,false)
		attachElements(takeTrashmarker,theTrash,0,0,0,0,0,0)
		theArrow = createMarker ( x1, y1, z1, "arrow", 1, 51, 204, 0, 170 )
		attachElements(theArrow,theTrash,0,0,1.3,0,0,0)
	end
end
addEvent("GTITrashCollector.createmarker", true)
addEventHandler("GTITrashCollector.createmarker", root, function(SX,SY,SZ,theVeh)
    if isElement(theTrash) then
        local dist = exports.GTIutil:getDistanceBetweenElements3D(localPlayer,theTrash)
        if ( dist < 40 ) and not (isElement(trashmarker))then
			trashmarker = createMarker (SX, SY, SZ, "cylinder", 1, 51, 204, 0, 170 )
			attachElements(trashmarker,theVeh,0,-5,-1.5,1,0,0)
		end
	end
end )



function takeTheTrash(theElement)
    if ( source == takeTrashmarker ) and ( theElement == localPlayer ) and ( isElement ( theTrash ) ) and not ( isPedInVehicle(localPlayer) ) and not ( doesPedHaveJetPack(localPlayer) ) then
		destroyElement(takeTrashmarker)
		destroyElement(blip)
		destroyElement(theArrow)
		triggerServerEvent("GTITrashCollector.freeze", resourceRoot, true)
		for i,v in ipairs(ctrls) do
			toggleControl(v, false)
		end
		setPedWeaponSlot(localPlayer,0)
		triggerServerEvent("GTITrashCollector.anim", resourceRoot,2)
		timer5 = setTimer(function()
			exports.bone_attach:attachElementToBone(theTrash,localPlayer,12,0.3,0.53,0.2,0,0,0)
			triggerServerEvent("GTITrashCollector.anim", resourceRoot,1)
		end, 700,1)
		triggerServerEvent("GTITrashCollector.marker", resourceRoot)
	end
end
addEventHandler ( "onClientColShapeHit", root, takeTheTrash) 


function throwing(thePlayer)
    if ( source == trashmarker ) and ( thePlayer == localPlayer) and (isElement(theTrash)) and ( exports.bone_attach:isElementAttachedToBone(theTrash) == true ) then
		triggerServerEvent("GTITrashCollector.anim", resourceRoot,3)
		for i,v in ipairs(ctrls) do
			toggleControl(v, true)
		end
		destroyElement(trashmarker)
		timer2 = setTimer(function()
			exports.bone_attach:detachElementFromBone(theTrash)
			local origX, origY, origZ = getElementPosition ( theTrash )
			local newZ = origZ + 3
			moveObject ( theTrash, 750, origX, origY, newZ )
		end,550,1)
		timer1 = setTimer(function()
			playSFX("genrl", 32, 10, false)
			destroyElement(theTrash)
			trashN = trashN + 1
			exports.GTIhud:drawStat("TrashID", "Trash Bags", trashN.."/10", 255, 200, 0)
			Mission()
		end,1000,1)
	end
end
addEventHandler("onClientMarkerHit",getRootElement(),throwing) 


function pay(thePlayer)
    if ( source == paymarker ) and ( thePlayer == localPlayer) and isPedInVehicle(localPlayer) and trashN == 10 and not isTimer(paytimer) then
		local theVehicle = getPedOccupiedVehicle(thePlayer)
		if getElementModel( theVehicle ) == 408 then
			destroyElement(payblip)
			destroyElement(paymarker)
			toggleControl("enter_exit",false)
			exports.GTIhud:drawProgressBar("TrashPro", "Unloading...", 255, 200, 0, 10000)
			setElementFrozen(theVehicle,true)
			unloadsound = playSFX("genrl", 76, 0, true)
			paytimer = setTimer(function()
				toggleControl("enter_exit",true)
				stopSound(unloadsound)
				triggerServerEvent("GTITrashCollector.pay", resourceRoot)
				playSFX("genrl", 77, 2, false)
				setElementFrozen(theVehicle,false)
				trashN = 0
				exports.GTIhud:drawStat("TrashID", "Trash Bags", trashN.."/10", 255, 200, 0)
				newMission()
			end,10000,1)
		end
    end
end
addEventHandler("onClientMarkerHit",getRootElement(),pay) 

function onTakeJob( job )
    if ( job == "Trash Collector" ) then 
		exports.GTIhud:drawStat("TrashID", "Trash Bags", trashN.."/10", 255, 200, 0)
    end
end
addEventHandler ("onClientPlayerGetJob", localPlayer, onTakeJob)

function delelem()
	if (exports.GTIemployment:getPlayerJob(true) == "Trash Collector") then
		trashN = 0
		location = nil
		if isElement(trashmarker) then destroyElement(trashmarker) end
		if isElement(takeTrashmarker) then destroyElement(takeTrashmarker) end
		if isTimer(timer1) then killTimer(timer1) end
		if isTimer(timer2) then killTimer(timer2) end
		if isTimer(timer3) then killTimer(timer3) end
		if isTimer(timer4) then killTimer(timer4) end
		if isTimer(paytimer) then killTimer(paytimer) end
		if isTimer(timer5) then killTimer(timer5) end
		if isElement(theArrow) then destroyElement(theArrow) end    
		if isElement(unloadsound) then stopSound(unloadsound) end
		if isElement(theTrash) then destroyElement(theTrash) end
		if isElement(blip) then destroyElement(blip) end
		if isElement(payblip) then destroyElement(payblip) end
		if isElement(paymarker) then destroyElement(paymarker) end
		toggleAllControls(true)
		setPedAnimation(localPlayer,false)
		exports.GTIhud:drawStat("TrashID", "Trash Bags", trashN.."/10", 255, 200, 0)
	end
end
addEvent( "onClientRentalVehicleHide",true)
addEventHandler ("onClientPlayerWasted", localPlayer, delelem)
addEventHandler ("onClientRentalVehicleHide", root, delelem)
function onJobQuit(job)
    if ( job == "Trash Collector" ) then 
		trashN = 0
		location = nil
		if isElement(trashmarker) then destroyElement(trashmarker) end
		if isElement(takeTrashmarker) then destroyElement(takeTrashmarker) end
		if isTimer(timer1) then killTimer(timer1) end
		if isTimer(timer2) then killTimer(timer2) end
		if isTimer(timer3) then killTimer(timer3) end
		if isTimer(timer4) then killTimer(timer4) end
		if isTimer(timer5) then killTimer(timer5) end
		if isTimer(paytimer) then killTimer(paytimer) end
		if isElement(theArrow) then destroyElement(theArrow) end    
		if isElement(unloadsound) then stopSound(unloadsound) end
		if isElement(theTrash) then destroyElement(theTrash) end
		if isElement(blip) then destroyElement(blip) end
		if isElement(payblip) then destroyElement(payblip) end
		if isElement(paymarker) then destroyElement(paymarker) end
		setPedAnimation(localPlayer,false)
		toggleAllControls(true)
		exports.GTIhud:drawStat("TrashID", "", "", 255, 200, 0)
	end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, onJobQuit)