----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: atmRob_c.lua
-- Version: 1.2
----------------------------------------->>

isTime = false
isRobbery = false
blip = false

local atmLocations = {
    -- Los Santos ATMs
{1950.604, -2175.402, 13.554},
{2073.125, -1824.931, 13.547},
{2420.793, -1506.270, 24.000},
{662.304, -578.914, 16.336},
{241.559, -172.050, 1.578},
{1290.454, 272.796, 19.555},
{2333.089, 82.974, 26.485},
    -- Verona Mall ATMs
{1094.147, -1479.752, 15.781},
{1090.959, -1479.153, 15.781},
{1096.171, -1464.723, 15.796},
{1098.614, -1465.597, 15.800},
    -- San Fierro ATMs
{-2143.656, -2456.981, 30.625},
{-2695.184, 260.950, 4.633},
{-1717.812, 1353.578, 7.180},
{-2629.029, 1404.716, 7.094},
    -- Las Venturas ATMs
{-2474.989, 2308.099, 4.984},
{-1504.846, 2616.396, 55.836},
{-213.552, 1089.708, 19.742},
{1146.218, 2074.359, 11.063},
{2173.647, 2795.568, 10.820},
{2238.543, 1295.027, 10.820}
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

function createMarkers ( )
    for i, atmTableData in ipairs ( atmLocations ) do
        local x = atmTableData[1]
        local y = atmTableData[2]
        local z = atmTableData[3]
        atmRobMarker = createColSphere ( x, y, z, 1 )
        addEventHandler ("onClientColShapeHit", atmRobMarker, drawMissionNote )
		addEventHandler ("onClientColShapeLeave", atmRobMarker, unbindZKey )
    end
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )

function drawMissionNote ( player )
    if ( player == localPlayer and not isPedInVehicle ( localPlayer ) and isPedOnGround ( localPlayer ) ) then
        --local job = exports.GTIemployment:getPlayerJob ( true )
        if ( exports.AresMisc:isAbleToCrime ( player ) ) then
            if ( isTime == true ) then exports.GTIhud:drawNote("ATMRobberyNote+5", "You are not allowed to rob this ATM for 3 minutes!", 200, 0, 0, 7500) return end
            exports.GTIhud:drawNote ("ATMRobberyNote", "Press [N] To start ATM Robbery", 255, 0, 0, 7500 )
            bindKey("N", "down", tntBomb )
        end
    end    
end  

function unbindZKey ( player )
    if ( player == localPlayer ) then
        unbindKey ("N", "down", tntBomb )
        exports.GTIhud:drawNote ("ATMRobberyNote", "", 255, 0, 0 )
        exports.GTIhud:drawNote ("ATMRobberyNote+5", "", 255, 0, 0 )
    end    
end
addEvent ("GTIatmRob_onClientKillCmd", true )
addEventHandler ("GTIatmRob_onClientKillCmd", root, unbindZKey )

function unbindKeyZ ( )
    if ( source == localPlayer ) then
        unbindKey ("N", "down", tntBomb )
        exports.GTIhud:drawNote ("ATMRobberyNote", "", 255, 0, 0 )
        exports.GTIhud:drawNote ("ATMRobberyNote+5", "", 255, 0, 0 )
    end
end
addEventHandler ("onClientPlayerWasted", root, unbindKeyZ )
addEventHandler ("onClientPlayerQuitJob", root, 
function ( jobName ) 
	if not jobName or exports.GTIemployment:getPlayerJob(true) == "Criminal" then 
		return true
	else
		return unbindZKey ( )
	end
end
)
addEventHandler ("onClientPlayerGetJob", root, unbindKeyZ )

function tntBomb ( )
	if getElementData(localPlayer,"isPlayerRobbing") == true then outputChatBox("You're already robbing.",255,0,0) return end
    if ( isRobbery == true ) then return end
    triggerServerEvent ("GTIatmRob_anim", localPlayer )
    x, y, z = getElementPosition ( localPlayer )
    object = createObject ( 1654, x, y, z-0.9, -90, 0, 0, true )
	x, y, z = getElementPosition ( object )
	leaveArea = createColCuboid ( x-50, y-50, z-50, 100, 100, 100 )
    setTimer ( timeLeftBombMsg, 2500, 1 )
    isTime = true
    isRobbery = true
	setElementData(localPlayer,"isPlayerRobbing",true)
	seconds = 120
	timer1 = setTimer ( cDown, 1000, 120 )
	leaveAreaRadar = createRadarArea ( x-50, y-50, 100, 100, 200, 0, 0, 150 )
	addEventHandler ("onClientColShapeLeave", leaveArea, endMission1 )
end

function timeLeftBombMsg ( )
    exports.GTIhud:dm("TNT bomb planted, defend the bomb for 2 minutes!", 200, 0, 0)
end

function cDown ( )
	    seconds = seconds - 1
		local mins,secds = secsToMin(seconds)
            if mins == "00" and secds == "00" then --time is up
			killTimer(timer1)
			explosionTNT()
            exports.GTIhud:drawStat("atmRobTimer", "", "", 200, 0, 0)
        else
            exports.GTIhud:drawStat("atmRobTimer", "Time left", mins..":"..secds, 200, 0, 0)
        end
	end
    
function explosionTNT ( )
    x, y, z = getElementPosition ( object )
    createExplosion ( x, y, z, 12 )
    exports.GTIhud:dm("Bomb exploded, grab the money!", 200, 0, 0)
    triggerServerEvent ("GTIatmRob.WantedLevel", localPlayer )
	dropBag()
	destroyElement ( leaveArea )
	destroyElement ( leaveAreaRadar )
	exports.GTIhud:drawStat("atmRobTimer", "", "", 200, 0, 0)
end

function dropBag ( )
        x, y, z = getElementPosition ( object )
        moneyBag = createObject ( 1550, x, y, z+0.2, -90, 0, 0, true )
        setElementDoubleSided ( moneyBag, true )
        moneyMarker = createColTube(x,y,z,1,2)
        attachElements ( moneyMarker, moneyBag )
        addEventHandler ("onClientColShapeHit", moneyMarker, moneyBags1 )
        destroyElement ( object )
end

function moneyBags1 ( player )
    if ( player == localPlayer ) and not isPedInVehicle(localPlayer) then
        triggerServerEvent ("GTIatmRob_moneyBag", localPlayer )
        x, y, z = getElementPosition ( moneyMarker )
        colshape = createColCuboid ( x-200, y-200, z-50, 400, 400, 100 )
        exports.GTIhud:dm("You got the money, now run away from the ATM!", 200, 0, 0)
        destroyElement ( moneyMarker )
        destroyElement ( moneyBag )
		leaveAreaRadar2 = createRadarArea ( x-200, y-200, 400, 450, 0, 200, 0, 150 )
        addEventHandler ("onClientColShapeLeave", colshape, payOutTNT )
    end
end

function payOutTNT ( player )
    if ( player == localPlayer ) and not isTimer(payTimer) then
	payTimer = setTimer(function() --it takes 500ms to change int
	if (getElementInterior(localPlayer) ~= 0) or (getElementDimension(localPlayer) ~= 0) then return end
	    triggerServerEvent ("GTIatmRob_payOutTNT", localPlayer )
	    destroyElement ( colshape )
		destroyElement ( leaveAreaRadar2 )
		isRobbery = false
		setElementData(localPlayer,"isPlayerRobbing",false)
		isTime = true
		if isTimer(waitTimer) then killTimer(waitTimer) end
        waitTimer = setTimer ( isTimeBeingFalse, 180000, 1 )
        unbindKey ("N", "down", tntBomb )
	end,500,1)
    end
end

function isTimeBeingFalse ( )
	if not isTime then return end
    isTime = false
    if ( exports.AresMisc:isAbleToCrime ( localPlayer ) ) then
		exports.GTIhud:dm("ATM Robbery - 3 Minutes passed!", 200, 0, 0)
	end
end

function endMission ( jobName )
    if ( source == localPlayer ) and isRobbery then
	outputChatBox("asdasd")
	    exports.GTIhud:drawStat("atmRobTimer", "", "", 200, 0, 0)
        if ( isElement ( object ) ) then
            destroyElement ( object )
        end
        if ( isElement ( moneyBag ) ) then
            destroyElement ( moneyBag )
        end
        if ( isElement ( moneyMarker ) ) then
            destroyElement ( moneyMarker )
        end
        if ( isElement ( colshape ) ) then
            destroyElement ( colshape )
		end
		if ( isElement ( leaveArea ) ) then
		    destroyElement ( leaveArea )   
        end
		if ( isElement ( leaveAreaRadar ) ) then
		    destroyElement ( leaveAreaRadar ) 
		end
		if ( isElement ( leaveAreaRadar2 ) ) then
		    destroyElement ( leaveAreaRadar2 )
		end
		triggerServerEvent("GTIatmRob_stopMissionS", localPlayer) 
        if isTimer ( tntTimer ) then killTimer ( tntTimer ) end
		if isTimer ( timer1 ) then killTimer ( timer1 ) end
        isRobbery = false
		setElementData(localPlayer,"isPlayerRobbing",false)
		if isTime then
			if isTimer(waitTimer) then killTimer(waitTimer) end
			waitTimer = setTimer ( isTimeBeingFalse, 180000, 1 )
		end
    end
end
addEvent ("GTIatmRob_onArrest", true )
addEventHandler ("GTIatmRob_onArrest", root, endMission )
addEventHandler ("onClientPlayerWasted", localPlayer, endMission )

addEventHandler ("onClientPlayerQuitJob", root, 
function ( jobName ) 
	if not jobName or exports.GTIemployment:getPlayerJob(true) == "Criminal" then 
		return true
	else
		return endMission ( )
	end
end
)
addEventHandler ("onClientPlayerGetJob", root, 
function ( jobName ) 
	if jobName == "Criminal" then 
		return true
	else
		return endMission ( )
	end
end
)

function endMission1 ( player )
    if ( player == localPlayer ) and isRobbery then
	    exports.GTIhud:drawStat("atmRobTimer", "", "", 200, 0, 0)
        if ( isElement ( object ) ) then
            destroyElement ( object )
        end
        if ( isElement ( moneyBag ) ) then
            destroyElement ( moneyBag )
        end
        if ( isElement ( moneyMarker ) ) then
            destroyElement ( moneyMarker )
        end
        if ( isElement ( colshape ) ) then
            destroyElement ( colshape )
		end
		if ( isElement ( leaveArea ) ) then
		    destroyElement ( leaveArea )  
        end
		if ( isElement ( leaveAreaRadar ) ) then
		    destroyElement ( leaveAreaRadar ) 
		end
		if ( isElement ( leaveAreaRadar2 ) ) then
		    destroyElement ( leaveAreaRadar2 )
		end
		triggerServerEvent("GTIatmRob_stopMissionS", localPlayer)  
        if isTimer ( tntTimer ) then killTimer ( tntTimer ) end
		if isTimer ( timer1 ) then killTimer ( timer1 ) end
        isRobbery = false
		setElementData(localPlayer,"isPlayerRobbing",false)
		if isTimer(waitTimer) then killTimer(waitTimer) end
        waitTimer = setTimer ( isTimeBeingFalse, 180000, 1 )
		exports.GTIhud:dm("You went to far away from the ATM!", 200, 0, 0)
    end
end

function onQuitGame( reason )
    if (isTimer(waitTimer)) then
        ms, a, b = getTimerDetails(waitTimer)
        triggerServerEvent("GTIatmRob.saveWaitTime", localPlayer, ms)
    else
        triggerServerEvent("GTIatmRob.saveWaitTime", localPlayer, 0)
    end    
end
addEventHandler( "onClientResourceStop", resourceRoot, onQuitGame )

function setTimerO(ms)
        if (not isTimer(waitTimer)) then 
			isTime = true
            waitTimer = setTimer(isTimeBeingFalse, ms, 1)
        end
end
addEvent("GTIatmRob.setTimer", true)
addEventHandler("GTIatmRob.setTimer", root, setTimerO)
