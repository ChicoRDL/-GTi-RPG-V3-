---------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: storeRob_c.lua
-- Version: 1.0
----------------------------------------->>

addEvent("onClientInteriorExit",true)

colShapeDerFix = createColCuboid ( 251.714, -81.700, 0.578, 12, 19, 10 )

local theRobbery = false
local robCashRegister = false
local robberyStarted = false
local unbindNKey = false
local cancelRobb = false
local intLeave = false

local peds = {
{createPed ( 59, -2235.597, 128.584, 1035.414, 0), 0, 6 },
{createPed ( 59, 497.644, -77.471, 998.765, 0 ), 1, 11 },
{createPed ( 59, -23.286, -57.334, 1003.547, 0 ), 1, 6 },
{createPed ( 59, -28.066, -91.640, 1003.547, 0 ), 1, 18 },
{createPed ( 59, -28.066, -91.640, 1003.547, 0 ), 0, 18 },
{createPed ( 59, -23.409, -57.324, 1003.547, 0 ), 4, 6 },
{createPed ( 59, -27.963, -91.640, 1003.547, 0 ), 2, 18 },
{createPed ( 59, -23.409, -57.324, 1003.547, 0 ), 3, 6 },
{createPed ( 59, -23.409, -57.324, 1003.547, 0 ), 7, 6 },
{createPed ( 59, -1560.088, -2731.392, 48.748, 325 ), 0, 0 },
{createPed ( 59, 1834.721, -1837.593, 13.595, 265 ), 0, 0 },
{createPed ( 59, 1316.687, -896.606, 39.578, 360 ), 0, 0 },
{createPed ( 59, 250.219, -54.828, 1.578, 180 ), 0, 0 },
}

local cashRegister = {
{createObject ( 1514, -2235.574, 129.407, 1035.700, 0, 0, 180 ), 0, 6, 180 },
{createObject ( 1514, 497.646, -76.722, 999.005, 0, 0, 180 ), 1, 11, 180},
{createObject ( 1514, -23.386, -56.597, 1003.706, 0, 0, 180 ), 1, 6, 0 },
{createObject ( 1514, -28.338, -90.706, 1003.706, 0, 0, 180 ), 1, 18, 0 },
{createObject ( 1514, -28.338, -90.706, 1003.706, 0, 0, 180 ), 0, 18, 0 },
{createObject ( 1514, -23.395, -56.484, 1003.706, 0, 0, 180 ), 4, 6, 0 },
{createObject ( 1514, -28.338, -90.706, 1003.706, 0, 0, 180 ), 2, 18, 0 },
{createObject ( 1514, -23.395, -56.484, 1003.706, 0, 0, 180 ), 3, 6, 0 },
{createObject ( 1514, -23.395, -56.484, 1003.706, 0, 0, 180 ), 7, 6, 0 },
{createObject ( 1514, -1559.773, -2730.774, 48.895, 0, 0, 140 ), 0, 0, 0 },
{createObject ( 1514, 1836.306, -1837.925, 13.741, 0, 0, 90 ), 0, 0, 0 },
{createObject ( 1514, 1316.697, -895.876, 39.624, 0, 0, 180 ), 0, 0, 0 },
{createObject ( 1514, 251.762, -55.555, 1.679, 0, 0, 0 ), 0, 0, 0 },
}

local markers = {
{-1561.990, -2733.559, 47.743},
{1832.750, -1842.396, 12.578},
{1313.498, -898.805, 38.578},
{244.183, -49.155, 0.578},
{254.637, -64.013, 0.578},
}


function secsToMin(seconds)
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

-- Marker and ped functions
function createMarkers ( )
    for i, v in ipairs ( markers ) do
        local x = v[1]
        local y = v[2]
        local z = v[3]
        safeMarker = createMarker ( x, y, z, "cylinder", 3, 0, 0, 0, 0 )
        addEventHandler ("onClientMarkerHit", safeMarker, robberyCancelOnMarkerHit )
        addEventHandler ("onClientMarkerLeave", safeMarker, robberyCancelOnMarkerHit )
    end   
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )

function breakCashRegister ( player )
    if ( player == localPlayer and robCashRegister == false and robberyStarted == true ) then
        triggerServerEvent ("GTIstoreRob_payOutForCashRegister", localPlayer )
        robCashRegister = true
        timer = setTimer ( timeForCashRegister, 360000, 1 )
    else
        cancelEvent()
    end
end

function cancelTheKill ( player )
    cancelEvent ()
end

for k,v in ipairs(peds) do 
    addEventHandler ( "onClientPedDamage", v[1], cancelTheKill )
    setElementFrozen ( v[1], true )
    setElementInterior ( v[1], v[3] )
    setElementDimension ( v[1], v[2] )
end

for k,v in ipairs(cashRegister) do 
    addEventHandler ("onClientObjectBreak", v[1], breakCashRegister )
    setElementInterior ( v[1], v[3] )
    setElementDimension ( v[1], v[2] )
    setElementDoubleSided ( v[1], true )
end

function isItAPedToRob( ped )
for k,v in ipairs(peds) do 
if v[1] == ped then return true end
end
end

function detectAim( target )
    --local job = exports.GTIemployment:getPlayerJob(true)
    if ( exports.AresMisc:isAbleToCrime ( source ) ) and ( target ) and ( getElementType( target ) == "ped" ) and (source == localPlayer) and getControlState("aim_weapon") and isItAPedToRob(target) then
        if ( robberyStarted == true ) then
            if not isDX then
                exports.GTIhud:dm("You already robbed. Please wait a while.", 200, 0, 0 )
                isDX = true
                setTimer(function() isDX = false end, 10000, 1)
                return
            end
        end
        if (not robberyStarted) then
            setPedAnimation( target, "SHOP", "SHP_Rob_GiveCash", 3000, false, false, false, false)
            triggerServerEvent ("GTIstoreRob_WantedLevel", localPlayer )
            exports.GTIhud:dm("You started a robbery, stay inside for 3 minutes!", 200, 0, 0)
            isDX = true
            setTimer(function() isDX = false end, 10000, 1)
            robberyStarted = true
            setElementData(localPlayer, "isPlayerRobbing", true)
            cancelRobb = true
            intLeave = true
            seconds = 180
            countDown = setTimer ( cDown, 1000, 180 )
            end
        end
    end
addEventHandler ( "onClientPlayerTarget", localPlayer, detectAim )

function timeForCashRegister ( )
    robCashRegister = false
end

function cDown ( )
    seconds = seconds - 1
    local mins,secds = secsToMin(seconds)
    if mins == "00" and secds == "00" then --time is up
        killTimer( countDown )
        payoutForSafe()
        setElementData(localPlayer, "isPlayerRobbing", false)
        exports.GTIhud:drawStat("storeRobTimer", "", "", 200, 0, 0)
    else
        exports.GTIhud:drawStat("storeRobTimer", "Time left", mins..":"..secds, 200, 0, 0)
    end
end

function payoutForSafe ( )
    if ( robberyStarted == false) then return end
    triggerServerEvent ("GTIstoreRob_payoutForSafe", localPlayer )
    setTimer ( isRobberyFalseAgain, 180000, 1 )
    intLeave = false
    robberyStarted = false
end

-- Cancel the robbery functions

--[[function createMarkers ( )
    for i, a in ipairs ( cancelMarkers ) do
        local x = a[1]
        local y = a[2]
        local z = a[3]
        cancelMarker = createMarker ( x, y, z, "cylinder", 4, 0, 0, 0, 0 )
        addEventHandler ("onClientMarkerHit", cancelMarker, robberyCancelOnMarkerHit )
    end
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )--]]

local recieved = {}

function cancelRobbery ( jobName )
    if ( source == localPlayer ) then
    if ( intLeave == false ) then return end
    if ( robberyStarted == false) then return end
        unbindKey ( "N", "down", startCrack )
        exports.GTIhud:drawStat("storeRobTimer", "", "", 200, 0, 0)
        exports.GTIhud:drawNote ("StoreRobCrackSafeNote", "", 255, 0, 0, 0 )
        if (not recieved[localPlayer]) then
            exports.GTIhud:dm("You failed the robbery!", 200, 0, 0)
            recieved[localPlayer] = true
        end  
        robberyStarted = false  
        robCashRegister = true
        theRobbery = false
        unbindNKey = true
        setElementData(localPlayer, "isPlayerRobbing", false)
        if isTimer ( countDown ) then killTimer ( countDown ) end
        if isTimer ( timer ) then killTimer ( timer ) end
        setTimer ( isRobberyFalseAgain, 180000, 1 )
    end
end

addEventHandler ("onClientPlayerQuitJob", root, 
function ( jobName ) 
    if not jobName or exports.GTIemployment:getPlayerJob(true) == "Criminal" then 
        return true
    else
        return cancelRobbery ( )
    end
end
)

addEventHandler ("onClientPlayerGetJob", root, 
function ( jobName ) 
    if jobName == "Criminal" then 
        return true
    else
        return cancelRobbery ( )
    end
end

)
addEventHandler ("onClientPlayerWasted", localPlayer, 
    function ( )
        robberyCancelOnMarkerHit(localPlayer)
    end

)

addEvent ("GTIstoreRob_CancelOnArrest", true )
addEventHandler ("GTIstoreRob_CancelOnArrest", root, cancelRobbery )

function robberyCancelOnMarkerHit ( player )
    if ( player == localPlayer ) then
    if ( intLeave == false ) then return end
        unbindKey ( "N", "down", startCrack )
        exports.GTIhud:drawNote ("StoreRobCrackSafeNote", "", 255, 0, 0, 0 )
    if ( cancelRobb == false ) then return end
    if ( robberyStarted == false) then return end
        exports.GTIhud:drawStat("storeRobTimer", "", "", 200, 0, 0)
        if (not recieved[localPlayer]) then
            exports.GTIhud:dm("You failed the robbery!", 200, 0, 0)
            recieved[localPlayer] = true
        end
        robCashRegister = true
        setElementData(localPlayer, "isPlayerRobbing", false)
        robberyStarted = false
        theRobbery = false
        unbindNKey = true
        cancelRobb = false
        if isTimer ( countDown ) then killTimer ( countDown ) end
        if isTimer ( timer ) then killTimer ( timer ) end
        setTimer ( isRobberyFalseAgain, 180000, 1 )
    end
end
addEventHandler ("onClientColShapeHit", colShapeDerFix, robberyCancelOnMarkerHit )
addEventHandler ("onClientColShapeLeave", colShapeDerFix, robberyCancelOnMarkerHit )
addEventHandler ("onClientInteriorExit", root, robberyCancelOnMarkerHit )

function isRobberyFalseAgain ( )
    robberyStarted = false
    robCashRegister = false
    theRobbery = false
    unbindNKey = false
    cancelRobb = false
    intLeave = false
    if isTimer ( timer ) then killTimer ( timer ) end
    if (exports.AresMisc:isAbleToCrime ( localPlayer ) ) then
        exports.GTIhud:dm("Store Robbery - 3 Minutes Passed!", 200, 0, 0)
    end
end
