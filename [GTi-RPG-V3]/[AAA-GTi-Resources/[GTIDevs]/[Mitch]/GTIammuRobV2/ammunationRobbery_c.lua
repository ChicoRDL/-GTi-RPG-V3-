----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: ammunationRobbery_c.lua
-- Version: 1.0
----------------------------------------->>

addEvent("onClientInteriorExit",true)
addEvent("onClientPlayerQuitJob",true)

isRobbery = false
isTime = false
--{ped, int, dim}
local peds = {
{createPed ( 179, 1370.286, -1292.434, 13.549, -90), 0, 0},
{createPed ( 179, 1370.297, -1286.706, 18.002, -90), 0, 0},
{createPed ( 179, 2402.549, -1986.312, 13.546, 90), 0, 0},
{createPed ( 179, 2324.559, 57.402, 20.866, 90), 0, 0},
{createPed ( 179, 237.804, -167.235, -3.744, 180), 0, 0},
{createPed ( 179, 2170.868, 931.855, 10.096, 90), 0, 0},
{createPed ( 179, 292.371, -104.248, 1001.523, 180), 6, 105, "Fort Carson"},
{createPed ( 179, -2093.384, -2470.107, 30.625, 50), 0, 0},
{createPed ( 179, 296.683, -40.587, 1001.516), 1, 101, "San Fierro"},
{createPed ( 179, 311.072, -168.051, 999.594), 6, 104, "El Quebrados"},
{createPed ( 179, 293.858, -84.463, 1001.516, 90), 4, 108, "Old Venturas"},
{createPed ( 179, -318.559, 829.981, 14.245, 90), 0, 0},
{createPed ( 179, 293.802, -84.093, 1001.516, 90), 4, 107, "Las Venturas"},
{createPed ( 179, 2550.509, 2071.741, 10.107, 0), 0, 0},
}
local gtiAmmuMarker = createMarker ( 1365.513, -1279.828, 12.547, "cylinder", 3, 0, 0, 0, 0 )
local gtiAmmuMarker1 = createMarker ( 2390.424, -1982.866, 12.547, "cylinder", 1.5, 0, 0, 0, 0 )
local gtiAmmuMarker2 = createMarker ( 2332.246, 61.581, 25.516, "cylinder", 2, 0, 0, 0, 0 )
local gtiAmmuMarker3 = createMarker ( -2099.377, -2458.972, 29.625, "cylinder", 2, 0, 0, 0, 0 )
local gtiAmmuMarker4 = createMarker ( 250.344, -175.391, -3.430, "cylinder", 3, 0, 0, 0, 0 )
local gtiAmmuMarker5 = createMarker ( 2162.252, 924.917, 10.100, "cylinder", 4, 0, 0, 0, 0 )
local gtiAmmuMarker6 = createMarker ( 2541.878, 2063.939, 10.102, "cylinder", 3, 0, 0, 0, 0 )

function cancelTheKill ( player )
    cancelEvent ()
end
for k,v in ipairs(peds) do 
    addEventHandler ( "onClientPedDamage", v[1], cancelTheKill )
    setElementFrozen ( v[1], true )
    setElementInterior ( v[1], v[2] )
    setElementDimension ( v[1], v[3] )
end

function isItAPedToRob( ped )
for k,v in ipairs(peds) do 
if v[1] == ped then return true end
end
end
function detectAim( target )
    --local job = exports.GTIemployment:getPlayerJob(true)
    if ( exports.AresMisc:isAbleToCrime( localPlayer ) ) and ( target ) and ( getElementType( target ) == "ped" ) and (source == localPlayer) and getControlState("aim_weapon") and isItAPedToRob(target) then
	if getElementData(localPlayer,"isPlayerRobbing") == true then outputChatBox("You're already robbing.",255,0,0) return end
        if ( isTime == true ) then
            if not isDX then
                exports.GTIhud:dm("You already robbed. Please wait a while.", 200, 0, 0 )
                isDX = true
                setTimer(function() isDX = false end, 10000, 1)
            end
        return end
        triggerServerEvent ("GTIammunationRob.isPlayerAllowedToRob", localPlayer )
        setPedAnimation( target, "SHOP", "SHP_Rob_GiveCash", 3000, false, false, false, false)
        isDX = true
        setTimer(function() isDX = false end, 10000, 1)
    end
end
addEventHandler ( "onClientPlayerTarget", root, detectAim )

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

function startRobbery ()
    if (isRobbery == true) then return end
	if getElementData(localPlayer,"isPlayerRobbing") == true then return end
        triggerServerEvent ("GTIammunationRob.WantedLevel", localPlayer )
        isTime = true
        isRobbery = true
        setElementData ( localPlayer, "GTIammurob.isPlayerRobbing", true )
		setElementData(localPlayer, "isPlayerRobbing", true)
        setTimer ( isTimere, 360000, 1 )
        seconds = 180
        timer1 = setTimer ( timerCountDown, 1000, 180 )
    end
addEvent ("GTIammunationRob_startRobbery", true )
addEventHandler ("GTIammunationRob_startRobbery", root, startRobbery )

function payOut ( )
    triggerServerEvent ("GTIammunationRob_payOut", localPlayer )
    isRobbery = false
    setElementData(localPlayer, "isPlayerRobbing", false)
    setElementData(localPlayer, "GTIammurob.isPlayerRobbing", false)
end


function timerCountDown()
        seconds = seconds - 1
        local mins,secds = convertSecsToTime(seconds)
        if mins == "00" and secds == "00" then --time is up
            killTimer(timer1)
            payOut()
            exports.GTIhud:drawStat("ammuRobTimer", "", "", 200, 0, 0)
        else
            exports.GTIhud:drawStat("ammuRobTimer", "Time left", mins..":"..secds, 200, 0, 0)
        end
    end

function stopMissionOnInteriorExit ( player )
    if ( player == localPlayer ) then
        if ( isRobbery == false ) then return end
        exports.GTIhud:drawStat("ammuRobTimer", "", "", 200, 0, 0)
        exports.GTIhud:dm  ("You failed the robbery!", 200, 0, 0 )
        if isTimer ( Timer ) then killTimer ( Timer ) end
        if isTimer ( timer1 ) then killTimer ( timer1 ) end
        isRobbery = false
        setElementData(localPlayer, "GTIammurob.isPlayerRobbing", false)
		setElementData(localPlayer, "isPlayerRobbing", false)
    end
end
addEventHandler ("onClientInteriorExit", root, stopMissionOnInteriorExit )
addEventHandler ("onClientMarkerHit", gtiAmmuMarker, stopMissionOnInteriorExit )
addEventHandler ("onClientMarkerHit", gtiAmmuMarker1, stopMissionOnInteriorExit )
addEventHandler ("onClientMarkerHit", gtiAmmuMarker2, stopMissionOnInteriorExit )
addEventHandler ("onClientMarkerHit", gtiAmmuMarker3, stopMissionOnInteriorExit )
addEventHandler ("onClientMarkerHit", gtiAmmuMarker4, stopMissionOnInteriorExit )
addEventHandler ("onClientMarkerHit", gtiAmmuMarker5, stopMissionOnInteriorExit )
addEventHandler ("onClientMarkerHit", gtiAmmuMarker6, stopMissionOnInteriorExit )

function stopRob ( jobName )
    if ( source == localPlayer ) then
        if ( isRobbery == false ) then return end
        exports.GTIhud:drawStat("ammuRobTimer", "", "", 200, 0, 0)
        exports.GTIhud:dm  ("You failed the robbery!", 200, 0, 0 )
        if isTimer ( Timer ) then killTimer ( Timer ) end
        if isTimer ( timer1 ) then killTimer ( timer1 ) end
        isRobbery = false
        setElementData(localPlayer, "GTIammurob.isPlayerRobbing", false)
		setElementData(localPlayer, "isPlayerRobbing", false)
        setTimer ( isTimere, 180000, 1 )
    end
end
addEvent ("GTIammunationRob_cancelRob", true )
addEventHandler ("GTIammunationRob_cancelRob", root, stopRob )

addEventHandler ("onClientPlayerQuitJob", root, 
function ( jobName ) 
	if not jobName or exports.GTIemployment:getPlayerJob(true) == "Criminal" then 
		return true
	else
		return stopRob ( )
	end
end
)
addEventHandler ("onClientPlayerWasted", root, stopRob )

addEventHandler ("onClientPlayerGetJob", root, 
function ( jobName ) 
	if jobName == "Criminal" then 
		return true
	else
		return stopRob ( )
	end
end
)

function isPlayerRobbing(player)
    local isRobbing = getElementData(player, "GTIammurob.isPlayerRobbing")
    if (isRobbing == true) then
        return true
	else
        return false
    end    
end

function isTimere ( )
    isTime = false
    local job = exports.GTIemployment:getPlayerJob(true)
    if (job == "Criminal") then
		exports.GTIhud:dm  ("Ammunation Robbery - 3 Minutes passed", 200, 0, 0 )
	end
end
