----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 4 Oct 2015
-- Resource: muscle_c.lua
-- Version: 1.0
----------------------------------------->>

local trainingActive = false

local sWidth, sHeight = guiGetScreenSize ( )
local Width, Height = 250, 260
local X = (sWidth/2) - (Width/2)
local Y = (sHeight/2) - (Height/2)
muscleWindow = guiCreateWindow ( X, Y, Width, Height, "GTI CJ Muscle", false )
guiSetVisible ( muscleWindow, false )
trainBtn = guiCreateButton ( 10, 190, 230, 20, "Train", false, muscleWindow )
closeBtn = guiCreateButton ( 10, 220, 230, 20, "Close", false, muscleWindow )
label1 = guiCreateLabel ( 58, 40, 140, 21, "TRAIN YOUR CJ MUSCLE", false, muscleWindow )
guiSetFont ( label1, "default-bold-small" )
guiLabelSetColor ( label1, 255, 150, 0)
label2 = guiCreateLabel ( -15, 160, 278, 30, "Chose a number between 1-999", false, muscleWindow )
guiSetFont ( label2, "default-small" )
guiLabelSetHorizontalAlign ( label2, "center", true )
muscleEdit = guiCreateEdit ( 90, 110, 71, 21, "", false, muscleWindow )
guiEditSetMaxLength ( muscleEdit, 3 )

function removeLetters ( element )
    local txt = guiGetText ( element )
    local removed = string.gsub ( txt, "[^0-9]", "" )
    if ( removed ~= txt ) then
        guiSetText ( element, removed )
    end
end
addEventHandler ( "onClientGUIChanged", muscleEdit, removeLetters, false )

-- Marker X, Y, Z, Dim, Int
local markerTable = {
{651.828, -1863.858, 4.461, 0, 0},
{771.793, 7.627, 999.710, 147, 5},
{768.394, -37.132, 999.686, 148, 6},
{767.785, -76.920, 999.656, 149, 7},
}

function createMarkers ( )
    for i, v in ipairs ( markerTable ) do
	    local x = v[1]
		local y = v[2]
		local z = v[3]
		muscleMarker = createMarker ( x, y, z, "cylinder", 1.5, 255, 140, 0, 150 )
		setElementDimension ( muscleMarker, v[4] )
		setElementInterior ( muscleMarker, v[5] )
		addEventHandler ("onClientMarkerHit", muscleMarker, showGui )
		addEventHandler ("onClientMarkerLeave", muscleMarker, hide )
	end
end
addEventHandler ("onClientResourceStart", resourceRoot, createMarkers )

function showGui ( player, matchingDimension )
    if ( player == localPlayer ) and matchingDimension and not isPedInVehicle ( localPlayer ) and isPedOnGround ( localPlayer ) then
	if getElementModel ( localPlayer ) ~= 0 then exports.GTIhud:dm ("You need CJ skin, skin ID 0 in order to use this!", 255, 0, 0 ) return end
	    guiSetVisible ( muscleWindow, true )
		showCursor ( true, true )
	end
end

function hideGUI ( )
	guiSetVisible ( muscleWindow, false )
    showCursor ( false, false )
end
addEventHandler ("onClientGUIClick", closeBtn, hideGUI, false )

function trainCJ ( )
    text = guiGetText ( muscleEdit )
    if ( tonumber ( text ) and text ~= "" and text ~= "0" ) then
	    exports.GTIhud:drawProgressBar("GTImusclesProgress", "Progress", 255, 150, 0, 60000)
		triggerServerEvent ("GTImuscleAnim", localPlayer )
		triggerServerEvent ("GTImuscleObject", localPlayer )
		trainingActive = true
		setTimer ( addStats, 60000, 1 )
		setElementFrozen ( localPlayer, true )
	    exports.GTIhud:dm ("Training your CJ to "..tonumber( text ).. " body stat(s)" , 0, 255, 0 )
		guiSetVisible ( muscleWindow, false )
        showCursor ( false, false )
		toggleControl ("chatbox", false )
    else
        exports.GTIhud:dm ("Enter amount of CJ muscle stats ( 1-999 ).", 255, 0, 0 )
	end
end
addEventHandler ("onClientGUIClick", trainBtn, trainCJ, false )

function addStats ( )
    triggerServerEvent ("GTImuscleStats", localPlayer, text )
	setElementFrozen ( localPlayer, false )
	toggleControl ("chatbox", true )
	trainingActive = false
end

addEvent ("onClientPlayerQuitJob", true )

function cancelTraining ( )
    if getElementData ( localPlayer, "suiciding" ) and trainingActive == true then
		setElementFrozen ( localPlayer, false )
		triggerServerEvent ("GTImuscle_CancelTraining", localPlayer )
		exports.GTIhud:drawProgressBar("GTImusclesProgress", "", 255, 150, 0)
		exports.GTIhud:dm ("The training failed because you died.", 255, 0, 0 )
		trainingActive = false
	end
end
addEventHandler ("onClientPlayerWasted", localPlayer, cancelTraining )

function cancelOnQuitJob ( )
    if source == localPlayer and trainingActive == true then
	    setElementFrozen ( localPlayer, false )
		triggerServerEvent ("GTImuscle_CancelTraining", localPlayer )
		exports.GTIhud:drawProgressBar("GTImusclesProgress", "", 255, 150, 0)
		exports.GTIhud:dm ("The training failed because you quit job.", 255, 0, 0 )
		trainingActive = false
	end
end
addEventHandler ("onClientPlayerQuitJob", root, cancelOnQuitJob )

function hide ( player )
    if ( player == localPlayer ) then
	    guiSetVisible ( muscleWindow, false )
		showCursor ( false, false )
	end
end
addEventHandler ("onClientPlayerWasted", root, hide )
		