----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

local msg = true
local button = false
local drugsLimit = 0 -- 240 Drugs limit per hour.

local markerTable = {
{221, 210.69999694824, 1670.0999755859 },
{216.599609375, 210.400390625, 1670.0999755859 },
{212.2001953125, 210.2001953125, 1670.0999755859},
{206.400390625, 210.2998046875, 1670.0999755859},
{221, 206.7001953125, 1670.0999755859},
{216.599609375, 206.599609375, 1670.0999755859},
{212.2001953125, 206.5, 1670.0999755859},
{206.2998046875, 206.599609375, 1670.0999755859},
{221, 202.7998046875, 1670.0999755859},
{216.599609375, 202.7998046875, 1670.0999755859},
{212.2001953125, 202.7998046875, 1670.0999755859},
{206.2998046875, 202.900390625, 1670.0999755859},
{221, 198.900390625, 1670.0999755859},
{216.599609375, 199, 1670.0999755859},
{212.2001953125, 199.099609375, 1670.0999755859},
{206.2001953125, 199.2998046875, 1670.0999755859},
{194.400390625, 227.7998046875, 1670.0999755859},
{189.7998046875, 222.2001953125, 1670.0999755859},
{194.2998046875, 221.599609375, 1670.0999755859},
{199.2998046875, 222.2998046875, 1670.0999755859},
{189.7998046875, 217, 1670.0999755859},
{194.2001953125, 215.400390625, 1670.0999755859},
{199.2998046875, 217, 1670.0999755859},
{199.2998046875, 211.7001953125, 1670.0999755859},
{194.099609375, 209.2001953125, 1670.0999755859},
{189.7998046875, 211.7998046875, 1670.0999755859},
{199.2998046875, 206.2998046875, 1670.0999755859},
{194, 203, 1670.0999755859}
}

function createMarkers ( )
    for i, v in ipairs ( markerTable ) do
        local x = v[1]
        local y = v[2]
        local z = v[3]
        drugMarker = createMarker ( x, y, z, "cylinder", 0.7, 255, 255, 255, 30 )
        setElementDimension ( drugMarker, 20000 )
        setElementInterior ( drugMarker, 1 )
        addEventHandler ("onClientMarkerHit", drugMarker, bind_key )
        addEventHandler ("onClientMarkerLeave", drugMarker, unbind_key )
    end
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )

addEvent ("onClientPlayerQuitJob", true )

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

function bind_key ( player )
    if ( player == localPlayer) then
        if (exports.GTIemployment:getPlayerJob ( true ) == "Criminal" or exports.GTIutil:isPlayerInTeam(localPlayer, "General Population")) then
            if (not isPedInVehicle ( localPlayer ) and isPedOnGround ( localPlayer ) ) then
                local x, y, z = getElementPosition(localPlayer)
                if (z >= 1675) then
                    return
                end
                exports.GTIhud:drawNote("GTIdrugFactory_DrawNote", "Press [N] to start making drugs", 200, 0, 0, 999999)
                bindKey ("N", "down", makeDrugs )
            end
        end        
    end    
end

function unbind_key ( player )
    if ( player == localPlayer ) then
        exports.GTIhud:drawNote("GTIdrugFactory_DrawNote", "", 200, 0, 0, 0)
        unbindKey ("N", "down", makeDrugs )
        button = false
    end
end

function makeDrugs ( )
    if ( drugsLimit == 240 ) then exports.GTIhud:dm("You have reached the max limit of making drugs this hour!", 200, 0, 0 ) return end
        exports.GTIhud:dm("You started making drugs!", 200, 0, 0 )
        seconds = 120
        drugsTimer = setTimer ( timerCountDown, 1000, 120 )
        exports.GTIhud:drawProgressBar("GTIdrugFactory_ProgressBar", "Drugs Progress", 200, 0, 0, 120000)
        setElementFrozen ( localPlayer, true )
        showCursor ( true, true )
        exports.GTIhud:drawNote("GTIdrugFactory_DrawNote", "", 200, 0, 0, 0)
        msg = false
        unbindKey ("N", "down", makeDrugs )
        if (exports.GTIutil:isPlayerInTeam(localPlayer, "General Population")) then
            triggerServerEvent("GTIdrugfactory.setWanted", localPlayer, localPlayer)
        end    
end

function timerCountDown ( )
    seconds = seconds - 1
    local mins,secds = convertSecsToTime(seconds)
    if mins == "00" and secds == "00" then --time is up
        killTimer ( drugsTimer )
        giveDrugs()
        exports.GTIhud:drawStat("GTIdrugFactoryTimer", "", "", 200, 0, 0)
    else
        exports.GTIhud:drawStat("GTIdrugFactoryTimer", "", "", 200, 0, 0)
    end
end

function giveDrugs ( )
    triggerServerEvent ("GTIdrugFactory_cocaine", localPlayer )
    setElementFrozen ( localPlayer, false )
    showCursor ( false, false )
    drugsLimit = drugsLimit + 60
    outputDebugString ("Drugs Limit "..drugsLimit )
    msg = true
    -- if ( drugsLimit == 240) then
    --watTimer = setTimer ( antiCheatDrugs, 3600000, 0 )
end

function stopMakingDrugs ( player )
    if ( source == localPlayer and msg == false ) then
        exports.GTIhud:drawStat("GTIdrugFactoryTimer", "", "", 200, 0, 0)
        exports.GTIhud:drawNote("GTIdrugFactory_DrawNote", "", 200, 0, 0, 0)
        exports.GTIhud:drawProgressBar("GTIdrugFactory_ProgressBar", "", 200, 0, 0, 0)
        exports.GTIhud:dm("You failed making the drugs!", 200, 0, 0 )
        unbindKey ("N", "down", makeDrugs )
        setElementFrozen ( localPlayer, false )
        showCursor ( false, false )
        msg = true
        if isTimer ( drugsTimer ) then killTimer ( drugsTimer )
            if isTimer ( drugsPayOut ) then killTimer ( drugsPayOut )
            end
        end
    end
end
addEventHandler ("onClientPlayerQuitJob", root, stopMakingDrugs )
addEventHandler ("onClientPlayerWasted", root, stopMakingDrugs )
addEventHandler ("onClientPlayerArrested", localPlayer, stopMakingDrugs)

function stopMakingDrugsCmd ( )
    if ( msg == true ) then return end
    exports.GTIhud:drawStat("GTIdrugFactoryTimer", "", "", 200, 0, 0)
    exports.GTIhud:drawNote("GTIdrugFactory_DrawNote", "", 200, 0, 0, 0)
    exports.GTIhud:drawProgressBar("GTIdrugFactory_ProgressBar", "", 200, 0, 0, 0)
    exports.GTIhud:dm("You failed making the drugs!", 200, 0, 0 )
    unbindKey ("N", "down", makeDrugs )
    setElementFrozen ( localPlayer, false )
    showCursor ( false, false )
    msg = true
    if isTimer ( drugsTimer ) then killTimer ( drugsTimer )
        if isTimer ( drugsPayOut ) then killTimer ( drugsPayOut )
        end
    end
end
addCommandHandler ("stopcraft", stopMakingDrugsCmd )  

function antiCheatDrugs ( player )
    drugsLimit = 0
end
watTimer = setTimer ( antiCheatDrugs, 3600000, 0 )


function onQuitGame( reason )
    if (isTimer(waitTimer)) then
        ms, a, b = getTimerDetails(waitTimer)
        triggerServerEvent("GTIdrugFactory.saveWaitTime", localPlayer, ms)
    else
        triggerServerEvent("GTIdrugFactory.saveWaitTime", localPlayer, 0)
    end    
end
addEventHandler( "onClientResourceStop", resourceRoot, onQuitGame )

function setTimerO(ms)
        if (not isTimer(waitTimer)) then
            drugsLimit = 240
            waitTimer = setTimer(antiCheatDrugs, ms, 1)
        end
end
addEvent("GTIdrugFactory.setTimer", true)
addEventHandler("GTIdrugFactory.setTimer", root, setTimerO)