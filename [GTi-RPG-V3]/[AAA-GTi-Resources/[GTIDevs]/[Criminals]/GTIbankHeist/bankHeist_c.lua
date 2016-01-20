----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: bankHeist_c.lua
-- Version: 1.2
----------------------------------------->>

createObject ( 1569, -2244.296, 2324.078, 3.969, 0, 0, 90 )

-- Bank Heist Ped Aim detection

addEvent ("onClientInteriorExit", true )
local isTime = false
local robberyStarted = false
local removeDoors = false

-- X, Y, Z, R, Dim, Int
local peds = {
{createPed ( 228, 48.204, -34.114, 176.033, 60), 30011, 1},
}

function convertSecsToTime(seconds)
		local hours = 0
		local minutes = 0
		local secs = 0
		local theseconds = seconds
		if theseconds >= 60*60 then
			hours = math.floor(theseconds / (60*60))
			theseconds = theseconds - ((60*60)*hours)
		end
		if theseconds >= 60 then
			minutes = math.floor(theseconds / (60))
			theseconds = theseconds - ((60)*minutes)
		end
		if theseconds >= 1 then
			secs = theseconds
		end
		if minutes < 10 then
		minutes = "0"..minutes
		end
		if secs < 10 then
		secs = "0"..secs
		end
	return minutes,secs
end

function isItAPedToRob( ped )
for k,v in ipairs(peds) do 
if v[1] == ped then return true end
end
end
function detectAim( target )
    --local job = exports.GTIemployment:getPlayerJob(true)
    if (exports.AresMisc:isAbleToCrime ( source )) and ( target ) and ( getElementType( target ) == "ped" ) and (source == localPlayer) and getControlState("aim_weapon") and isItAPedToRob(target) then
        if ( isTime == true ) then
            if not isDX then
                exports.GTIhud:dm("You already robbed. Please wait a while.", 200, 0, 0 )
                isDX = true
                setTimer(function() isDX = false end, 10000, 1)
            end
        return end
        setPedAnimation( target, "PED", "handsup", 3000, false, false, false, true)
		triggerServerEvent ("GTIBankheist_WantedLevel", localPlayer )
		triggerEvent ("GTIBankHeist_CreateDoorMarkers", localPlayer, localPlayer )
		triggerEvent ("GTIbankHeist_CreateDoors", localPlayer, localPlayer )
		exports.GTIhud:dm("You started a Bank Heist, unlock the safe and security door!", 200, 0, 0 )
        isDX = true
		robberyStarted = true
		removeDoors = true
		isTime = true
        setTimer(function() isDX = false end, 10000, 1)
    end
end
addEventHandler ( "onClientPlayerTarget", root, detectAim )

function cancelTheKill ( player )
    cancelEvent ()
end
for k,v in ipairs(peds) do 
    addEventHandler ( "onClientPedDamage", v[1], cancelTheKill )
	setElementFrozen ( v[1], true )
    setElementInterior ( v[1], v[3] )
    setElementDimension ( v[1], v[2] )
end


-- ATM Bank Heist Robbery

-- X, Y, Z, XR, YR, ZR, Dim, Int

--[[

local ATM = {
{createObject (2942, 40.356, -45.261, 175.633, 0, 0, -90), 30011, 1},
{createObject (2942, 40.356, -46.151, 175.633, 0, 0, -90), 30011, 1},
{createObject (2942, 37.557, -49.730, 175.633, 0, 0, 180), 30011, 1},
{createObject (2942, 36.644, -49.730, 175.633, 0, 0, 180), 30011, 1},
{createObject (2942, 35.749, -49.730, 175.633, 0, 0, 180), 30011, 1},
{createObject (2942, 32.857, -45.399, 175.633, 0, 0, 90), 30011, 1 },
{createObject (2942, 32.857, -46.240, 175.633, 0, 0, 90), 30011, 1},
}

local ATMrob = 0

function payForATM ( player )
    if ( player == localPlayer and robberyStarted == true ) then
	if ATMrob == 3 then return end
	    triggerServerEvent ("GTIBankHeist_PayOutATM", localPlayer )
		ATMrob = ATMrob + 1
	end
end

function respawnObjects ( )
    for i, v in ipairs ( ATM ) do
    setTimer (respawnObject, 7500, 1, ( v[1] ) )
end
end


for k,v in ipairs ( ATM ) do 
	--addEventHandler ("onClientObjectBreak", v[1], payForATM )
	--addEventHandler ("onClientObjectBreak", v[1], respawnObjects )
	setElementInterior ( v[1], v[3] )
	setElementDimension ( v[1], v[2] )
	setElementDoubleSided ( v[1], true )
end
]]

-- Crack doors Bank Heist

-- X, Y, Z, XR, YR, ZR, Dim, Int

local markers = {
{54.750, -23.492, 175.033, 30011, 1},
}

addEvent ("GTIBankHeist_CreateDoorMarkers", true )
addEventHandler ("GTIBankHeist_CreateDoorMarkers", root,
    function ( player )
	    if ( player == localPlayer ) then
		    for k, v in ipairs ( markers ) do
			    local X = v[1]
				local Y = v[2]
				local Z = v[3]
				local dim = v[4]
				local int = v[5]
			    crackMarker = createMarker ( X, Y, Z, "cylinder", 1, 200, 0, 0, 130 )
				setElementInterior ( crackMarker, int )
                setElementDimension ( crackMarker, dim )
				sound = playSound3D ( "alarm.mp3", X, Y, Z, true )
				setSoundMaxDistance( sound, 100 )
				setElementDimension ( sound, dim )
				setElementInterior ( sound, int )
				addEventHandler ("onClientMarkerHit", crackMarker, timerOnMarkerHit )
			end
		end
	end
)

function timerOnMarkerHit ( player )
    if ( player == localPlayer ) then
	    destroyElement ( crackMarker )
        timer1 = setTimer ( openDoor, 90000, 1 )
		exports.GTIhud:dm("You setup a drill on the door, wait till it breaks open", 200, 0, 0 )
		drill = playSound3D ( "drill.mp3", 55.166, -22.311, 175.033, true )
		setElementDimension ( drill, 30011 )
		setElementInterior ( drill, 1 )
		exports.GTIhud:drawProgressBar("GTIBankHeist_ProgressBar", "Progress Drill", 200, 0, 0, 90000)
		stopSound ( sound )
		triggerServerEvent ("GTIBankHeist_anim", localPlayer )
	end
end

addEvent ("GTIbankHeist_CreateDoors", true )
addEventHandler ("GTIbankHeist_CreateDoors", root,
    function ( )
        --local job = exports.GTIemployment:getPlayerJob(true)
        if (exports.AresMisc:isAbleToCrime ( localPlayer )) then
		    Doors = {
            {createObject (2930, 55.591, -21.141, 177.233, 0, 0, 0), 30011, 1},
            }
            for k,v in ipairs ( Doors ) do
                setElementInterior ( v[1], v[3] )
                setElementDimension ( v[1], v[2] )
	            setElementDoubleSided ( v[1], true )
	            setObjectScale ( v[1], 1.4 )
		    end
        end
    end
)

function openDoor ( player )
	for k,v in ipairs ( Doors ) do
		triggerEvent ("GTIbankHeist_CreateSafeDoors", localPlayer, localPlayer )
		triggerEvent ("GTIBankHeist_CreateSafeDoorMarkers", localPlayer, localPlayer )
		if isTimer ( timer1 ) then killTimer ( timer1 ) end
		exports.GTIhud:dm("The door is open, move on!", 200, 0, 0 )
		stopSound ( drill )
		destroyElement ( v[1] )
    end
end

-- Bank Heist Safe door

local safeMarkers = {
{86.355, -18.663, 152.872, 30011, 1},
}

addEvent ("GTIBankHeist_CreateSafeDoorMarkers", true )
addEventHandler ("GTIBankHeist_CreateSafeDoorMarkers", root,
    function ( player )
	    if ( player == localPlayer ) then
		    for k, v in ipairs ( safeMarkers ) do
			    local X = v[1]
				local Y = v[2]
				local Z = v[3]
				local dim = v[4]
				local int = v[5]
			    SafeMarker = createMarker ( X, Y, Z, "cylinder", 1, 200, 0, 0, 130 )
				setElementInterior ( SafeMarker, int )
                setElementDimension ( SafeMarker, dim )
				addEventHandler ("onClientMarkerHit", SafeMarker, timerOnMarkerrHit )
			end
		end
	end
)

addEvent ("GTIbankHeist_CreateSafeDoors", true )
addEventHandler ("GTIbankHeist_CreateSafeDoors", root,
    function ( )
        --local job = exports.GTIemployment:getPlayerJob(true)
        if (exports.AresMisc:isAbleToCrime ( localPlayer )) then
		    safeDoorM = {
            {createObject (2634, 86.888, -17.363, 153.879, 0, 0, 0), 30011, 1},
            }
            for k,v in ipairs ( safeDoorM ) do
                setElementInterior ( v[1], v[3] )
                setElementDimension ( v[1], v[2] )
	            setElementDoubleSided ( v[1], true )
	            setObjectScale ( v[1], 1.4 )
		    end
        end
    end
)

function timerOnMarkerrHit ( player )
    if ( player == localPlayer ) then
	    destroyElement ( SafeMarker )
        timer3 = setTimer ( openSafeDoor, 90000, 1 )
		exports.GTIhud:drawProgressBar("GTIBankHeist_ProgressBar", "Progress Drill", 200, 0, 0, 90000) 
		exports.GTIhud:dm("You setup a drill on the door, wait till it breaks open", 200, 0, 0 )
		drill = playSound3D ( "drill.mp3", 87.183, -18.171, 152.872, true )
		setElementDimension ( drill, 30011 )
		setElementInterior ( drill, 1 )
		triggerServerEvent ("GTIBankHeist_anim", localPlayer )
	end
end

function openSafeDoor ( player )
	for k,v in ipairs ( safeDoorM ) do
		triggerEvent ("GTIbankHeist_crackSafeMarkers", localPlayer, localPlayer )
		--triggerEvent ("GTIBankHeist_CreateSafeDoorMarkers", localPlayer, localPlayer )
		if isTimer ( timer3 ) then killTimer ( timer3 ) end
		exports.GTIhud:dm("The door is open, move on!", 200, 0, 0 )
		stopSound ( drill )
		destroyElement ( v[1] )
    end
end

-- Crack safes
local safeCrack = {
{68.368, -11.040, 148.708, 30011, 1},
{68.067, -6.126, 148.708, 30011, 1},
{68.442, -2.418, 148.708, 30011, 1},
{68.261, 2.954, 148.708, 30011, 1},
}

local safe = false

addEvent ("GTIbankHeist_crackSafeMarkers", true )
addEventHandler ("GTIbankHeist_crackSafeMarkers", root,
    function ( player )
	    if ( player == localPlayer ) then
		    local loc = math.random ( #safeCrack )
			cMarker = createMarker ( safeCrack[loc][1], safeCrack[loc][2], safeCrack[loc][3], "cylinder", 1, 200, 0, 0, 130 )
			addEventHandler ("onClientMarkerHit", cMarker, timerCrack )
			setElementDimension ( cMarker, safeCrack[loc][4] )
			setElementInterior ( cMarker, safeCrack[loc][5] )
		end
	end
)

function timerCrack ( player )
    if ( player == localPlayer and safe == false ) then
	    seconds = 120
        timer4 = setTimer ( timerCountDow, 1000, 120 )
		exports.GTIhud:dm("You setup a drill on the safe, wait till it breaks open", 200, 0, 0 )
		local X, Y, Z = getElementPosition ( cMarker )
		drill = playSound3D ( "drill.mp3", X, Y, Z, true )
		setElementDimension ( drill, 30011 )
		setElementInterior ( drill, 1 )
		triggerServerEvent ("GTIBankHeist_anim", localPlayer )
		safe = true
	end
end

function moneyBag ( player )
	local x, y, z = getElementPosition ( cMarker )
	bag = createObject ( 1550, x, y, z+0.4, -90, 0, 0, true )
	setElementDoubleSided ( bag, true )
	setElementDimension ( bag, getElementDimension ( localPlayer ) )
	setElementInterior ( bag, getElementInterior ( localPlayer ) )
    colshape = createColSphere ( x, y, z+0.8, 1 )
	setElementDimension ( colshape, getElementDimension ( localPlayer ) )
	setElementInterior ( colshape, getElementInterior ( localPlayer ) )
	addEventHandler ("onClientColShapeHit", colshape, attachBag )
	exports.GTIhud:dm("Get the money bag and get away!", 200, 0, 0 )
	destroyElement ( cMarker )
end

local bagMoney = false

function attachBag ( player )
    if ( player == localPlayer ) then
	    triggerServerEvent ("GTIBankHeist_moneyBag", localPlayer )
	    destroyElement ( bag )
		destroyElement ( colshape )
		bagMoney = true
	end
end

function payOut ( player )
    if ( player == localPlayer and robberyStarted == true and bagMoney == true ) then
	    triggerServerEvent ("GTIBankHeist_PayOutMoneyBag", localPlayer )
	    waitTimer = setTimer ( timer, 600000, 1 )
		robberyStarted = false
		safe = false
		bagMoney = false
		removeDoors = false
		ATMrob = 0
	end
end
addEventHandler ("onClientInteriorExit", root, payOut )

function timerCountDow()
    seconds = seconds - 1
    local mins,secds = convertSecsToTime(seconds)
    if mins == "00" and secds == "00" then --time is up
        killTimer(timer4)
		stopSound ( drill )
        moneyBag()
        exports.GTIhud:drawStat("BankHeistTimer", "", "", 200, 0, 0)
    else
         exports.GTIhud:drawStat("BankHeistTimer", "Time left", mins..":"..secds, 200, 0, 0)
    end
end
    

-- Timer for next robbery
function timer ( )
    isTime = false
	exports.GTIhud:dm("Bank Heist - 10 Minutes passed", 200, 0, 0 )
end

addEvent ("onClientPlayerQuitJob", true )

-- cancel robbery
function cancelRobbery ( player )
    if ( player == localPlayer and robberyStarted == true ) then
	    	exports.GTIhud:drawStat("BankHeistTimer", "", "", 0, 0, 0, 0)
		exports.GTIhud:drawProgressBar("GTIBankHeist_ProgressBar", "", 0, 0, 0, 0)
		if isTimer ( timer1 ) then killTimer ( timer1 ) end
		if isTimer ( timer2 ) then killTimer ( timer2 ) end
		if isTimer ( timer3 ) then killTimer ( timer3 ) end
		if isTimer ( timer4 ) then killTimer ( timer4 ) end
		if isElement ( crackMarker ) then destroyElement ( crackMarker ) end
		if isElement ( SafeMarker ) then destroyElement ( SafeMarker ) end
		if isElement ( markerSafe ) then destroyElement ( markerSafe ) end
		if isElement ( cMarker ) then destroyElement ( cMarker ) end
		if isElement ( bag ) then destroyElement ( bag ) end
		if isElement ( colshape ) then destroyElement ( colshape ) end
		triggerServerEvent ("GTIBankHeist_stopMission", localPlayer )
		if isElement ( sound ) then stopSound ( sound ) end
		if isElement ( drill ) then stopSound ( drill ) end
		for k,v in ipairs ( Doors ) do
		    if isElement ( v[1] ) then destroyElement ( v[1] ) end
		    exports.GTIhud:dm("You failed the robbery!", 200, 0, 0 )
		    robberyStarted = false
		    safe = false
		    bagMoney = false
			ATMrob = 0
		    waitTimer = setTimer ( timer, 600000, 1 )
		end
	end
end
addEventHandler ("onClientInteriorExit", root, cancelRobbery )

function cancel_Robbery ( )
    if ( source == localPlayer and robberyStarted == true ) then
	    	exports.GTIhud:drawStat("BankHeistTimer", "", "", 0, 0, 0)
 		exports.GTIhud:drawProgressBar("GTIBankHeist_ProgressBar", "", 0, 0, 0, 0)
		if isTimer ( timer1 ) then killTimer ( timer1 ) end
		if isTimer ( timer2 ) then killTimer ( timer2 ) end
		if isTimer ( timer3 ) then killTimer ( timer3 ) end
		if isTimer ( timer4 ) then killTimer ( timer4 ) end
		if isElement ( crackMarker ) then destroyElement ( crackMarker ) end
		if isElement ( SafeMarker ) then destroyElement ( SafeMarker ) end
		if isElement ( markerSafe ) then destroyElement ( markerSafe ) end
		if isElement ( cMarker ) then destroyElement ( cMarker ) end
		if isElement ( bag ) then destroyElement ( bag ) end
		if isElement ( colshape ) then destroyElement ( colshape ) end
		if isElement ( sound ) then stopSound ( sound ) end
		if isElement ( drill ) then stopSound ( drill ) end
		for k,v in ipairs ( Doors ) do
		    if isElement ( v[1] ) then destroyElement ( v[1] ) end
		    exports.GTIhud:dm("You failed the robbery!", 200, 0, 0 )
		    robberyStarted = false
		    safe = false
		    bagMoney = false
			ATMrob = 0
		    waitTimer = setTimer ( timer, 600000, 1 )
		end
	end
end
addEvent ("GTIBankHeist_onArrest", true )
addEventHandler ("GTIBankHeist_onArrest", root, cancel_Robbery )
addEventHandler ("onClientPlayerWasted", root, cancel_Robbery )

addEventHandler ("onClientPlayerQuitJob", root, 
function ( jobName ) 
	if not jobName or exports.GTIemployment:getPlayerJob(true) == "Criminal" then 
		return true
	else
		return cancel_Robbery ( )
	end
end
)

addEventHandler ("onClientPlayerGetJob", root, 
function ( jobName ) 
	if jobName == "Criminal" then 
		return true
	else
		return cancel_Robbery ( )
	end
end
)

function remove_Door ( player )
    if ( player == localPlayer and removeDoors == true ) then
	if not safeDoorM or #safeDoorM == 0 then removeDoors = false return end
	    for k,v in ipairs ( safeDoorM ) do
		    if isElement ( v[1] ) then destroyElement ( v[1] ) end
			removeDoors = false
		end
	end
end
addEventHandler ("onClientInteriorExit", root, remove_Door )

function removeDoor ()
    if ( source == localPlayer and removeDoors == true ) then
	if not safeDoorM or #safeDoorM == 0 then removeDoors = false return end
	    for k,v in ipairs ( safeDoorM ) do
		    if isElement ( v[1] ) then destroyElement ( v[1] ) end
			removeDoors = false
		end
	end
end
addEventHandler ("onClientPlayerWasted", root, removeDoor )
addEventHandler ("onClientPlayerQuitJob", root, 
function ( jobName ) 
	if not jobName or exports.GTIemployment:getPlayerJob(true) == "Criminal" then 
		return true
	else
		return removeDoor ( )
	end
end
)

-- Save wait timers
function onQuitGame( reason )
    if (isTimer(waitTimer)) then
        ms, a, b = getTimerDetails(waitTimer)
        triggerServerEvent("GTIBankHeist.saveWaitTime", localPlayer, ms)
    else
        triggerServerEvent("GTIBankHeist.saveWaitTime", localPlayer, 0)
    end    
end
addEventHandler( "onClientResourceStop", resourceRoot, onQuitGame )

function setTimerO(ms)
        if (not isTimer(waitTimer)) then
			isTime = true
            waitTimer = setTimer(isTimeBeingFalse, ms, 1)
        end
end
addEvent("GTIBankHeist.setTimer", true)
addEventHandler("GTIBankHeist.setTimer", root, setTimerO)
