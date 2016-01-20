--[[-------------------------------------------------
Notes:

> This code is using a relative image filepath. This will only work as long as the location it is from always exists, and the resource it is part of is running.
    To ensure it does not break, it is highly encouraged to move images into your local resource and reference them there.
--]]-- 
--				 ^^^              ^^^^^^^^^^^^^^^
--READ THIS MITCH||| Flower Power |||||||||||||||


GUIEditor = {
    button = {},
    window = {},
    staticimage = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
local screenW, screenH = guiGetScreenSize()
        GUIEditor.window[1] = guiCreateWindow((screenW - 591) / 2, (screenH - 398) / 2, 591, 398, "GTI - Basic tutorial panel", false)
        guiWindowSetMovable(GUIEditor.window[1], false)
        guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetVisible (GUIEditor.window[1], false )

        GUIEditor.label[1] = guiCreateLabel(0, 14, 591, 41, "Civilian", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[1], "sa-header")
        guiLabelSetColor(GUIEditor.label[1], 249, 158, 0)
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.label[2] = guiCreateLabel(0, 50, 591, 62, "To get a job you must go to the yellow icon    of your radar, there are many jobs like: \nMedic, Pilot, Pizzaman...\nDepending the job you'll need to do different things to get money, \nmost recommended activity if you are new in MTA.", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[2], "center", false)

        GUIEditor.staticimage[1] = guiCreateStaticImage(302, 0, 16, 16, "radar_light.png", false, GUIEditor.label[2])

        GUIEditor.label[3] = guiCreateLabel(0, 102, 591, 41, "Criminal", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[3], "sa-header")
        guiLabelSetColor(GUIEditor.label[3], 255, 0, 0)
        guiLabelSetHorizontalAlign(GUIEditor.label[3], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[3], "center")
        GUIEditor.label[4] = guiCreateLabel(0, 140, 591, 67, "First of all to do criminal activities you should get a weapon at ammunation (    blip in radar)\nAs criminal you can do activities such as: robbing ammunation, stores, ATM, Cars...\nTo rob stores/ammunation. you need to aim the weapon to the store ped\nAll this activities are illegal and will make you get wanted.     Cops will try to catch you!", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[4], "center", false)

        GUIEditor.staticimage[2] = guiCreateStaticImage(368, 45, 16, 16, "wanted.png", false, GUIEditor.label[4])
        GUIEditor.staticimage[3] = guiCreateStaticImage(461, 0, 16, 16, "radar_ammugun.png", false, GUIEditor.label[4])

        GUIEditor.label[5] = guiCreateLabel(0, 198, 591, 47, "Police Officer", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[5], "sa-header")
        guiLabelSetColor(GUIEditor.label[5], 0, 108, 254)
        guiLabelSetHorizontalAlign(GUIEditor.label[5], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[5], "center")
        GUIEditor.label[6] = guiCreateLabel(0, 244, 591, 62, "You must go to the nearest police department (    Blip in radar) to get this job (LSPD)\nTo catch criminals you should get weapons and a stick, there are 2 ways to arrest a Criminal;\nYou can kill him with weapons or arrest him with the stick.\nThis is recommended for more advanced players because criminals are very Rude!", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[6], "center", false)

        GUIEditor.staticimage[4] = guiCreateStaticImage(320, 0, 16, 16, "radar_police.png", false, GUIEditor.label[6])

        GUIEditor.button[1] = guiCreateButton(534, 22, 47, 28, "Close", false, GUIEditor.window[1])
		guiSetEnabled (GUIEditor.button[1], false )
        guiSetFont(GUIEditor.button[1], "default-bold-small")
        guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")
        GUIEditor.label[7] = guiCreateLabel(0, 301, 591, 15, "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~BASIC BINDS~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[7], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[7], 157, 46, 228)
        guiLabelSetHorizontalAlign(GUIEditor.label[7], "center", false)
        GUIEditor.label[8] = guiCreateLabel(10, 316, 190, 15, "F9=Rules and Further Information", false, GUIEditor.window[1])
        GUIEditor.label[9] = guiCreateLabel(210, 316, 108, 15, "F10=Control Panel", false, GUIEditor.window[1])
        GUIEditor.label[10] = guiCreateLabel(328, 316, 57, 15, "B=Phone", false, GUIEditor.window[1])
        GUIEditor.label[11] = guiCreateLabel(395, 316, 79, 15, "U=Local Chat", false, GUIEditor.window[1])
        GUIEditor.label[12] = guiCreateLabel(484, 316, 79, 15, "T=Main Chat", false, GUIEditor.window[1])
        GUIEditor.label[13] = guiCreateLabel(10, 341, 190, 15, "F1=Chats", false, GUIEditor.window[1])
        GUIEditor.label[14] = guiCreateLabel(10, 366, 190, 15, "F7=Market", false, GUIEditor.window[1])
        GUIEditor.label[15] = guiCreateLabel(210, 341, 108, 15, "F2=Groups", false, GUIEditor.window[1])
        GUIEditor.label[16] = guiCreateLabel(328, 341, 57, 15, "F3=Drugs", false, GUIEditor.window[1])
        GUIEditor.label[17] = guiCreateLabel(395, 341, 79, 15, "F4=My Stats", false, GUIEditor.window[1])
        GUIEditor.label[18] = guiCreateLabel(484, 341, 79, 15, "F5=Job Panel", false, GUIEditor.window[1])
		GUIEditor.label[18] = guiCreateLabel(210, 366, 190, 15, "X=Cursor", false, GUIEditor.window[1])
    end
)

----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

function showThePanelOnFirstTimeLogin ( )
	guiSetVisible (GUIEditor.window[1], true )
	showCursor ( true )
	seconds = 60
    timer1 = setTimer ( timerCountDown, 1000, 60 )
end
addEvent ("GTIinfoPanel_showTutorial", true )
addEventHandler ("GTIinfoPanel_showTutorial", root, showThePanelOnFirstTimeLogin )

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

function timerCountDown()
    seconds = seconds - 1
    local mins,secds = convertSecsToTime(seconds)
    if mins == "00" and secds == "00" then --time is up
        killTimer(timer1)
		guiSetText ( GUIEditor.button[1], "Close" )
		guiSetEnabled (GUIEditor.button[1], true )
		guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFFF0000")
    else
		guiSetText ( GUIEditor.button[1], "X "..mins..":"..secds )
    end
end

function buttonHandler ( )
	if source == GUIEditor.button[1] then
		guiSetVisible (GUIEditor.window[1], false )
		showCursor ( false )
	end
end
addEventHandler ("onClientGUIClick", root, buttonHandler )

local v = false

function cmd ( )
	if v == false then
		guiSetVisible (GUIEditor.window[1], true )
		guiSetEnabled (GUIEditor.button[1], true )
		showCursor ( true )
		v = true
	elseif v == true then
		guiSetVisible (GUIEditor.window[1], false )
		showCursor ( false )
		v = false
	end
end
addEvent ("GTIuserpanel_tutorial", true )
addEventHandler ("GTIuserpanel_tutorial", root, cmd )
addCommandHandler ("tutorial", cmd )