----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 4-10-2015
-- Resource: medkit_c.lua
-- Version: 1.0
----------------------------------------->>

local antiSpam = false
local antiSpamTimer = nil

-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 309, 200
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY
-- sX, sY, wX, wY = 646, 337, 309, 180
GUI_Window_Medkits = guiCreateWindow(sX, sY, wX, wY, "GTI Medic Kits — Buy Medic Kits", false)
guiWindowSetSizable(GUI_Window_Medkits, false)
guiSetAlpha(GUI_Window_Medkits, 0.90)
guiSetVisible(GUI_Window_Medkits, false)
-- Labels (Static)
GUI_Label1 = guiCreateLabel ( 50, 178, 200, 20, "", false, GUI_Window_Medkits )
guiSetFont(GUI_Label1, "default-bold-small")
guiLabelSetColor(GUI_Label1, 0, 178, 240)
guiLabelSetHorizontalAlign(GUI_Label1, "right", false)
GUI_Label3 = guiCreateLabel(14, 32, 139, 15, "COST OF ONE MEDIC KIT: ", false, GUI_Window_Medkits)
guiSetFont(GUI_Label3, "default-bold-small")
guiLabelSetColor(GUI_Label3, 0, 178, 240)
guiLabelSetHorizontalAlign(GUI_Label3, "right", false)
GUI_Label7 = guiCreateLabel(14, 60, 139, 15, "AMOUNT TO PURCHASE:", false, GUI_Window_Medkits)
guiSetFont(GUI_Label7, "default-bold-small")
guiLabelSetColor(GUI_Label7, 0, 178, 240)
guiLabelSetHorizontalAlign(GUI_Label7, "right", false)
GUI_Label8 = guiCreateLabel(14, 87, 139, 15, "TOTAL COST:", false, GUI_Window_Medkits)
guiSetFont(GUI_Label8, "default-bold-small")
guiLabelSetColor(GUI_Label8, 0, 178, 240)
guiLabelSetHorizontalAlign(GUI_Label8, "right", false)
GUI_Label5 = guiCreateLabel(15, 110, 278, 24, "Use the command /medkit in the main chat to use them, med-kits heal 25 HP each", false, GUI_Window_Medkits)
guiSetFont(GUI_Label5, "default-small")
guiLabelSetHorizontalAlign(GUI_Label5, "center", true)
-- Labels (Dynamic)
GUI_Label6 = guiCreateLabel(163, 32, 85, 15, "$750", false, GUI_Window_Medkits)	-- Cost of One
guiSetFont(GUI_Label6, "clear-normal")
guiLabelSetColor(GUI_Label6, 25, 255, 25)
GUI_Label9 = guiCreateLabel(163, 87, 129, 15, "$0", false, GUI_Window_Medkits)	-- Total Cost
guiSetFont(GUI_Label9, "clear-normal")
guiLabelSetColor(GUI_Label9, 25, 255, 25)
-- Edit
medEdit = guiCreateEdit(163, 57, 71, 21, "", false, GUI_Window_Medkits)
guiEditSetMaxLength ( medEdit, 3 )
-- Buttons
GUI_Button_Buy = guiCreateButton(81, 141, 71, 26, "Purchase", false, GUI_Window_Medkits)
closebt = guiCreateButton(157, 141, 71, 26, "Close", false, GUI_Window_Medkits)

function removeLetters ( element )
    local txt = guiGetText ( element )
    local removed = string.gsub ( txt, "[^0-9]", "" )
    if ( removed ~= txt ) then
        guiSetText ( element, removed )
    end
    local txt2 = guiGetText ( element )
    if ( txt2 ~= "" and tonumber ( txt2 ) ) then
        guiSetText ( GUI_Label9, "$"..tonumber ( txt2 ) * 750 )
    end
end
addEventHandler ( "onClientGUIChanged", medEdit, removeLetters, false )

addEvent ("onMedKitLoad", true )
addEventHandler ("onMedKitLoad", root, function ( medKits ) setElementData ( source, "mK", medKits, false ) end )

function showMedKitGUI ( hitElement, matchDim )
    if ( hitElement == localPlayer and not isPedInVehicle( hitElement ) and isPedOnGround ( hitElement ) and matchDim ) then
        local medKits = getElementData ( hitElement, "mK" ) or 0
        guiSetText ( GUI_Label1, "You currently have "..medKits.." Medic Kits." )
        guiSetVisible ( GUI_Window_Medkits, true )
        showCursor ( true )
    end
end

local kitMarkers = {
createMarker ( 1183.212, -1331.965, 12.583, "cylinder", 1.5, 0, 200, 0, 100 ), -- All saints
createMarker ( 2040.653, -1411.499, 16.164, "cylinder", 1.5, 0, 200, 0, 100 ), -- Jefferson
createMarker ( 2277.617, -74.993, 25.560, "cylinder", 1.5, 0, 200, 0, 100 ), -- Palomino Creek
createMarker ( 1237.718, 335.725, 18.758, "cylinder", 1.5, 0, 200, 0, 100 ), -- ??
createMarker ( 1628.929, 1817.632, 9.820, "cylinder", 1.5, 0, 200, 0, 100 ), -- LV Hospital
createMarker ( -2664.826, 635.333, 13.453, "cylinder", 1.5, 0, 200, 0, 100 ), -- LV Hospital
createMarker ( -2201.335, -2292.506, 29.625, "cylinder", 1.5, 0, 200, 0, 100 ), -- Angel Pine
createMarker ( -1508.991, 2521.333, 54.860, "cylinder", 1, 0, 200, 0, 100 ), -- SF Easter Basin East
createMarker ( -246.955, 2596.291, 61.858, "cylinder", 1.5, 0, 200, 0, 100 ), -- North Army base hospital
createMarker ( -322.919, 1054.843, 18.742, "cylinder", 1.5, 0, 200, 0, 100 ), -- Fort cason Hospital
createMarker ( 113.346, -191.883, 0.488, "cylinder", 1.5, 0, 200, 0, 100 ), -- BlueBerry Hospital
}

function hideMedKitGUI (player)
	if (isElement(player) and player == localPlayer or type(player) == "string") then
   		guiSetVisible ( GUI_Window_Medkits, false )
    	showCursor ( false )
	end
end
addEventHandler ("onClientGUIClick", closebt, hideMedKitGUI, false )

for i, marker in ipairs ( kitMarkers ) do
    addEventHandler ("onClientMarkerHit", marker, showMedKitGUI )
	addEventHandler ("onClientMarkerLeave", marker, hideMedKitGUI )
end

function buyMedKit ( )
    if ( antiSpam ) then
        outputConsole ("Stop buying med kits so fast")
        return
    end
    am = guiGetText ( medEdit )
    if ( tonumber ( am ) and am ~= "" and am ~= "0" ) then
        local money = getPlayerMoney ( )
        local tot = am * 750
        if ( money >= tot ) then
            triggerServerEvent ("playerBoughtMedKit", root, am )
			exports.GTIhud:dm ("You bought "..tonumber( am ).. " Medic kit(s)" , 0, 255, 0 )
			guiSetVisible ( GUI_Window_Medkits, false )
            showCursor ( false )
        else
            exports.GTIhud:dm ("You need $"..tot.." to buy those!", 255, 0, 0 )
        end
    else
        exports.GTIhud:dm ("Enter amount of medkits.", 255, 0, 0 )
    end
end
addEventHandler ("onClientGUIClick", GUI_Button_Buy, buyMedKit, false )

function buyMedKitReturn ( am )
    guiSetText ( GUI_Label1, "You currently have "..am .." Medic Kits." )
    setElementData ( localPlayer, "mK", am, false )
    antiSpam = false
end
addEvent ("playerBoughtMedKitReturn", true )
addEventHandler ("playerBoughtMedKitReturn", root, buyMedKitReturn )

function useMedKit ( )
	if getElementDimension ( localPlayer ) == 60000 then
	    exports.GTIhud:dm ("You cannot use this command while being /afk", 255, 0, 0 )
		    return false
		end
    if getPedAnimation ( localPlayer ) then
	    exports.GTIhud:dm ("You cannot use this command while doing an animation", 255, 0, 0 )
		    return false
		end
    if exports.GTIsafezones:isElementWithinSafezone ( localPlayer ) then
	    exports.GTIhud:dm ("You cannot use this command while being in a safezone", 255, 0, 0 )
		    return false
		end
    if getElementDimension ( localPlayer ) == 802 then
	    exports.GTIhud:dm ("You cannot use this command while being in an event", 255, 0, 0 )
		    return false
		end
    if isPedInVehicle ( localPlayer ) then
	    exports.GTIhud:dm ("You cannot use this command when being in a vehicle", 255, 0, 0 )
		    return false
		end
    if getElementData ( localPlayer, "suiciding" ) then 
	    exports.GTIhud:dm ("You cannot use this command when doing /kill", 255, 0, 0 )
	        return false 
	    end
    if getElementHealth ( localPlayer ) <= 0 then 
	       return false 
	    end
    if ( getElementHealth ( localPlayer ) >= 100 ) then
		local kitsLeft = getElementData ( localPlayer, "mK" ) or 0
        exports.GTIhud:dm ("You already have max health. "..kitsLeft.." Medic Kits Left", 255, 0, 0 )
            return false
        end
    if ( isElementInWater ( localPlayer ) ) then
        exports.GTIhud:dm ("You cannot use med kit when in water", 255, 0, 0 )
            return false
        end
    local medKits = getElementData ( localPlayer, "mK" )
        if ( medKits > 0 ) then
            if ( isTimer ( antiSpamTimer ) ) then
                exports.GTIhud:dm ("You can only use med kit once every 5 seconds", 255, 0, 0 )
                return false
            end
            setElementData(localPlayer, "mK", medKits - 1, false)
            if (not useOnOther) then
                exports.GTIhud:drawNote ("gtimedkitsnote", ( medKits - 1 ).." medic kit(s) remaining.", 0, 255, 0, 7500 )
				--triggerServerEvent ("GTImedKit_Anim", localPlayer )
            end
            healMedKit(medKits)
            useOnOther = false
        else
            exports.GTIhud:dm ("You're out of medic kits! Get new ones at the hospital.", 255, 0, 0 )
	end
end
addCommandHandler ("medkit", useMedKit )
addEvent ("GTIuserpanel_takeMedkit", true )
addEventHandler ("GTIuserpanel_takeMedkit", root, useMedKit )


function healMedKit ( medKits )
    local health = getElementHealth ( localPlayer )
    if ( health < 0.01 ) then
        return
    end
    healed = 0
    isHealingActive = true
    if (useOnOther) then
        triggerServerEvent ("playerUsedMedKit", usr or root, true )
    else
        triggerServerEvent ("playerUsedMedKit", usr or root, false )
    end
    useOnOther = false
    usr = false
    toggleAllControls ( false, true, false)
    medUseEndTimer = setTimer ( medUseEnd, 2000, 1 )
    antiSpamTimer = setTimer ( function ( ) antiSpamTimer = nil end, 5000 + getPlayerPing ( localPlayer ), 1 )
end

function setMedKitsDisabled ( bool )
    areMedKitsEnabled = not bool
end

addEventHandler("onClientPlayerWasted", localPlayer,
	function ()
		if ( isTimer(medUseEndTimer) ) then
			killTimer(medUseEndtimer)
		elseif ( isTimer(antiSpamTimer) ) then
			killTimer(antiSpamTimer)
		end
	end
)

function medUseEnd ( )
    isHealingActive = false
    setElementHealth ( localPlayer, getElementHealth ( localPlayer ) + 25 )
        exports.GTIhud:drawNote("healingNoteGTImedKits", "You now have "..math.floor ( getElementHealth ( localPlayer ) ).. " HP", 0, 255, 0, 7500 )
    healed = false
    toggleAllControls ( true, true, false )
end

function usingMedKit ( )
    return isHealingActive
end
