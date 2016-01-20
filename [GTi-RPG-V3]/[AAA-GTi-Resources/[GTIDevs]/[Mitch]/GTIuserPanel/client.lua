----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

local sx, sy = guiGetScreenSize ( )
local px, py = 1920, 1080 -- Do not change or you fuck up.
local x, y   = ( sx / px ), ( sy /py )
local render = false
local panel = false
local enabled = false
local enabled2 = false
local enabled3 = false
local enabled4 = false
local weps = false
local wheelsPack = false
local DX = false
local burgerBlips = false
local pizzaBlips = false
local playerName = getPlayerName ( localPlayer )
local r1, g1, b1 = 0, 0, 0
local r2, g2, b2 = 64, 64, 64
local r3, g3, b3 = 255, 128, 0

local sX, sY = guiGetScreenSize()
local wX, wY = 500, 500
local sX, sY, wX, wY = (sX/2)-(wX/2),(sY/2)-(wY/2),wX,wY

-- DX buttons
UserPanel = guiCreateLabel ( x*150, y*1000, x*200, y*1080, "                                      ", false )
guiSetVisible ( UserPanel, false )
Stats = guiCreateLabel ( x*900, y*1000, x*200, y*1080, "                            ", false )
guiSetVisible ( Stats, false )
CraftSystem = guiCreateLabel ( x*1250, y*1000, x*200, y*1080, "                           ", false )
guiSetVisible ( CraftSystem, false )
Achievements = guiCreateLabel ( x*520, y*1000, x*200, y*1080, "                                          ", false )
guiSetVisible ( Achievements, false )
Settings = guiCreateLabel ( x*1540, y*1000, x*200, y*1080, "                                           ", false )
guiSetVisible ( Settings, false )
-- User Panel GUI
GUI_Window_Userpanel = guiCreateWindow ( sX, sY, wX, wY, ""..playerName.." Users panel", false )
guiWindowSetSizable ( GUI_Window_Userpanel, false )
guiSetAlpha ( GUI_Window_Userpanel, 0.90 )
guiSetVisible ( GUI_Window_Userpanel, false )
-- Buttons
GUI_Button_Markstunts = guiCreateButton ( 20, 30, 220, 20, "Mark Stunts", false, GUI_Window_Userpanel )
GUI_Button_Markatms = guiCreateButton ( 260, 30, 220, 20, "Mark ATMs", false, GUI_Window_Userpanel )
GUI_Button_Markstores = guiCreateButton ( 20, 60, 220, 20, "Mark Stores", false, GUI_Window_Userpanel )
GUI_Button_Updates = guiCreateButton ( 260, 60, 220, 20, "Updates", false, GUI_Window_Userpanel )
GUI_Button_Vehmods = guiCreateButton ( 20, 90, 220, 20, "Vehicle Mods", false, GUI_Window_Userpanel )
GUI_Button_Medkit = guiCreateButton ( 260, 90, 220, 20, "Take Medic Kit", false, GUI_Window_Userpanel )
GUI_Button_Animations = guiCreateButton ( 20, 120, 220, 20, "Animations", false, GUI_Window_Userpanel )
GUI_Button_Carradio = guiCreateButton ( 260, 120, 220, 20, "Car Radio", false, GUI_Window_Userpanel )
GUI_Button_Laser = guiCreateButton ( 20, 150, 220, 20, "Laser", false, GUI_Window_Userpanel )
GUI_Button_Tutorial = guiCreateButton ( 260, 150, 220, 20, "Tutorial Panel", false, GUI_Window_Userpanel )
-- Settings Panel GUI
GUI_Window_Settings = guiCreateWindow ( sX, sY, wX, wY, ""..playerName.." Settings Panel", false )
guiWindowSetSizable ( GUI_Window_Settings, false )
guiSetAlpha ( GUI_Window_Settings, 0.90 )
guiSetVisible ( GUI_Window_Settings, false )
-- Buttons
GUI_Button_ChangeColor1 = guiCreateButton ( 20, 30, 150, 20, "Change Color 1", false, GUI_Window_Settings )
GUI_Button_ChangeColor2 = guiCreateButton ( 20, 60, 150, 20, "Change Color 2", false, GUI_Window_Settings )
GUI_Button_ChangeColor3 = guiCreateButton ( 20, 90, 150, 20, "Change Color Text", false, GUI_Window_Settings )
GUI_Button_LaserColor = guiCreateButton ( 20, 120, 150, 20, "Change Color Laser", false, GUI_Window_Settings )
-- Labels 
GUI_Label1 = guiCreateLabel ( 190, 35, 200, 20, "Change color 1 of the userpanel", false, GUI_Window_Settings )
guiSetFont ( GUI_Label1, "default-bold-small")
guiLabelSetColor ( GUI_Label1, r1, g1, b1 )
GUI_Label2 = guiCreateLabel ( 190, 65, 200, 20, "Change color 2 of the userpanel", false, GUI_Window_Settings )
guiSetFont ( GUI_Label2, "default-bold-small" )
guiLabelSetColor ( GUI_Label2, r2, g2, b2 )
GUI_Label3 = guiCreateLabel ( 190, 95, 200, 20, "Change color of the userpanel text", false, GUI_Window_Settings )
guiSetFont ( GUI_Label3, "default-bold-small" )
guiLabelSetColor ( GUI_Label3, r3, g3, b3 )
GUI_Label4 = guiCreateLabel ( 190, 125, 200, 20, "Change color of the weapon laser", false, GUI_Window_Settings )
guiSetFont ( GUI_Label4, "default-bold-small" )
-- Misc
guiSetProperty ( GUI_Button_Markstunts,"NormalTextColour", "FFFC0000" )
guiSetProperty ( GUI_Button_Markatms,"NormalTextColour", "FFFC0000" )
guiSetProperty ( GUI_Button_Markstores,"NormalTextColour", "FFFC0000" )
guiSetProperty ( GUI_Button_Laser,"NormalTextColour", "FFFC0000" )

if sx <= 1024 and sy <= 768 then
    textRender = 0.45
    smallText = 0.55
	smallerText = 0.35
else
    textRender = 0.65
    smallText = 0.85
	smallerText = 0.45
end

function setLaserBtnColor ( getLaser )
	if getLaser == 1 then
		guiSetProperty ( GUI_Button_Laser,"NormalTextColour", "FF00FD00" )
	elseif getLaser == 0 then
		guiSetProperty ( GUI_Button_Laser,"NormalTextColour", "FFFC0000" )
	end
end
addEvent ("GTIuserpanel_setLaserBtnColor", true )
addEventHandler ("GTIuserpanel_setLaserBtnColor", root, setLaserBtnColor )

function showDX ( )
	if render == false and not isPlayerMapVisible ( ) then
		addEventHandler ("onClientRender", root, drawText )
		showChat ( false )
		showCursor ( true )
		guiSetVisible ( UserPanel, true )
		guiSetVisible ( Stats, true )
		guiSetVisible ( CraftSystem, true )
		guiSetVisible ( Achievements, true )
		guiSetVisible ( Settings, true )
		setPlayerHudComponentVisible ( "radar", false )
		render = true
	elseif render == true then
		removeEventHandler ("onClientRender", root, drawText )
		setPlayerHudComponentVisible ( "radar", true )
		showChat ( true )
		showCursor ( false )
		guiSetVisible ( UserPanel, false )
		guiSetVisible ( GUI_Window_Userpanel, false )
		guiSetVisible ( GUI_Window_Settings, false )
		guiSetVisible ( Stats, false )
		guiSetVisible ( CraftSystem, false )
		guiSetVisible ( Achievements, false )
		guiSetVisible ( Settings, false )
		render = false
		if DX == true then
			removeEventHandler ("onClientRender", root, DXnotification )
			DX = false
		end
	end
end
addCommandHandler ("userpanel", showDX )
addEvent ("GTIuserPanel_OpenGUI", true )
addEventHandler ("GTIuserPanel_OpenGUI", root, showDX )

local FPScount = 0
local ping = 0
local fps = 0
function updatePingAndFPS()
	ping = getPlayerPing(localPlayer)
	fps = FPScount
	FPScount = 0
end
setTimer(updatePingAndFPS, 1000, 0)

function drawText ( )
	if isPlayerMapVisible () then return end
	local r1,g1,b1 = guiLabelGetColor ( GUI_Label1 )
	local r2,g2,b2 = guiLabelGetColor ( GUI_Label2 )
	local r3,g3,b3 = guiLabelGetColor ( GUI_Label3 )
    dxDrawRectangle ( x*0, y*1000, x*1920, y*80, tocolor ( r1, g1, b1) ) -- Layout 
	dxDrawRectangle ( x*0, y*1000, x*1920, y*10, tocolor ( r2, g2, b2) )
	dxDrawRectangle ( x*0, y*0, x*1920, y*80, tocolor ( r1, g1, b1) ) -- Layout 
	dxDrawRectangle ( x*0, y*80, x*1920, y*10, tocolor ( r2, g2, b2) )
	--dxDrawRectangle ( x*0, y*1070, x*1920, y*10, tocolor ( 64, 64, 64) )
	--dxDrawRectangle ( x*0, y*1000, x*120, y*80, tocolor ( 64, 64, 64) )
	--dxDrawRectangle ( x*1800, y*1000, x*120, y*80, tocolor ( 64, 64, 64) )
	--dxDrawRectangle ( x*420, y*1000, x*50, y*80, tocolor ( 64, 64, 64) )
	--dxDrawRectangle ( x*790, y*1000, x*50, y*80, tocolor ( 64, 64, 64) )
	--dxDrawRectangle ( x*1100, y*1000, x*50, y*80, tocolor ( 64, 64, 64) )
	--dxDrawRectangle ( x*1510, y*1000, x*50, y*80, tocolor ( 64, 64, 64) )
	exports.MitchMisc:dxDrawBorderedText ( "User Panel", x*550, y*1000, x*0, y*1080, tocolor ( r3, g3, b3 ), smallText, "bankgothic", "center", "center", false, false, true, false, false ) -- UserPanel Button
	exports.MitchMisc:dxDrawBorderedText ( "Achievements", x*1250, y*1000, x*0, y*1080, tocolor ( r3, g3, b3 ), smallText, "bankgothic", "center", "center", false, false, true, false, false ) -- Achievements Button
	exports.MitchMisc:dxDrawBorderedText ( "Stats", x*1950, y*1000, x*0, y*1080, tocolor ( r3, g3, b3 ), smallText, "bankgothic", "center", "center", false, false, true, false, false ) -- Stats Button
	exports.MitchMisc:dxDrawBorderedText ( "Crafting System", x*2650, y*1000, x*0, y*1080, tocolor ( r3, g3, b3 ), smallText, "bankgothic", "center", "center", false, false, true, false, false ) -- Craft panel button
	exports.MitchMisc:dxDrawBorderedText ( "Settings", x*3350, y*1000, x*0, y*1080, tocolor ( r3, g3, b3 ), smallText, "bankgothic", "center", "center", false, false, true, false, false ) -- settings button
	exports.MitchMisc:dxDrawBorderedText ( "GTI | gtirpg.net | "..#getElementsByType("player").."/"..getElementData(root, "max_players").." Players", x*0, y*50, x*0, y*0, tocolor ( r3, g3, b3 ), textRender, "bankgothic", "left", "center", false, false, true, false, false )
	FPScount = FPScount + 1
	if ( not ping or not fps ) then return end
	exports.MitchMisc:dxDrawBorderedText ("Ping: "..ping.." | FPS: "..fps, x*0, y*100, x*0, y*0, tocolor ( r3, g3, b3 ), textRender, "bankgothic", "left", "center", false, false, true, false, false )
	--dxDrawImage ( x*150, y*1020, x*35, y*35, "user.png" )-- userPanel icon
	--dxDrawImage ( x*475, y*1020, x*35, y*35, "achievements.png" )-- Achievements icon
	--dxDrawImage ( x*875, y*1020, x*35, y*35, "stats.png" )-- Stats icon
	--dxDrawImage ( x*1150, y*1020, x*35, y*35, "crafting.png" )-- Crafting icon
	--dxDrawImage ( x*1550, y*1020, x*35, y*35, "settings.png" )-- settings icon
end

function DXnotification ( )
	if isPlayerMapVisible () then return end
	local r1,g1,b1 = guiLabelGetColor ( GUI_Label1 )
	local r2,g2,b2 = guiLabelGetColor ( GUI_Label2 )
	local r3,g3,b3 = guiLabelGetColor ( GUI_Label3 )
	dxDrawRectangle ( x*1620, y*100, x*300, y*50, tocolor ( r1, g1, b1 ) ) -- Layout
	dxDrawRectangle ( x*1620, y*90, x*300, y*10, tocolor ( r2, g2, b2 ) )
	dxDrawRectangle ( x*1620, y*150, x*300, y*10, tocolor ( r2, g2, b2 ) )
	dxDrawRectangle ( x*1610, y*90, x*10, y*70, tocolor ( r2, g2, b2 ) )
	exports.MitchMisc:dxDrawBorderedText ( "Not Completed yet!", x*2470, y*250, x*1080, y*0, tocolor ( r3, g3, b3 ), smallerText, "bankgothic", "center", "center", false, false, true, false, false )
end

local color = 0

addEvent ("onColorPickerOK", true )
addEventHandler("onColorPickerOK", root, 
	function ( element, hex, r1, g1, b1 )
		if color == 1 then
			guiLabelSetColor ( GUI_Label1, r1, g1, b1 )
			triggerServerEvent ("GTIuserpanel_saveColor1", localPlayer, r1, g1, b1 )
		end
	end
)

addEvent ("onColorPickerOK", true )
addEventHandler("onColorPickerOK", root, 
	function ( element, hex, r2, g2, b2 )
		if color == 2 then
			guiLabelSetColor ( GUI_Label2, r2, g2, b2 )
			triggerServerEvent ("GTIuserpanel_saveColor2", localPlayer, r2, g2, b2 )
		end
	end
)

addEvent ("onColorPickerOK", true )
addEventHandler("onColorPickerOK", root, 
	function ( element, hex, r3, g3, b3 )
		if color == 3 then
			guiLabelSetColor ( GUI_Label3, r3, g3, b3 )
			triggerServerEvent ("GTIuserpanel_saveColor3", localPlayer, r3, g3, b3 )
		end
	end
)

function setColor1onLogin ( color1R, color1G, color1B, color2R, color2G, color2B, color3R, color3G, color3B )
	guiLabelSetColor ( GUI_Label1, color1R, color1G, color1B )
	guiLabelSetColor ( GUI_Label2, color2R, color2G, color2B )
	guiLabelSetColor ( GUI_Label3, color3R, color3G, color3B )
end
addEvent ("GTIuserpanel_setColor1", true )
addEventHandler ("GTIuserpanel_setColor1", root, setColor1onLogin )

--guiSetProperty ( GUI_Button_Markstunts, "NormalTextColour", "FF00FD00" )
--guiSetProperty ( GUI_Button_Markstunts,"NormalTextColour", "FFFC0000" )

function clicks ( sort )
	if source == UserPanel and panel == false then
		guiSetVisible ( GUI_Window_Userpanel, true )
		panel = true
	elseif source == UserPanel and panel == true then
		guiSetVisible ( GUI_Window_Userpanel, false )
		panel = false
	elseif source == GUI_Button_Markstunts and enabled == false then
		triggerEvent ("GTIuserpanel_markStunts", localPlayer )
		enabled = true
		guiSetProperty ( GUI_Button_Markstunts, "NormalTextColour", "FF00FD00" )
	elseif source == GUI_Button_Markstunts and enabled == true then
		triggerEvent ("GTIuserpanel_markStunts", localPlayer )
		guiSetProperty ( GUI_Button_Markstunts,"NormalTextColour", "FFFC0000" )
		enabled = false
	elseif source == GUI_Button_Markatms and enabled2 == false then
		guiSetProperty ( GUI_Button_Markatms, "NormalTextColour", "FF00FD00" )
		enabled2 = true
		triggerEvent ("GTIuserpanel_markATMS", localPlayer )
	elseif source == GUI_Button_Markatms and enabled2 == true then
		guiSetProperty ( GUI_Button_Markatms, "NormalTextColour", "FFFC0000" )
		enabled2 = false
		triggerEvent ("GTIuserpanel_markATMS", localPlayer )
	elseif source == GUI_Button_Markstores and enabled3 == false then
		triggerEvent ("GTIuserpanel_markStores", localPlayer )
		enabled3 = true
		guiSetProperty ( GUI_Button_Markstores, "NormalTextColour", "FF00FD00" )
	elseif source == GUI_Button_Markstores and enabled3 == true then
		triggerEvent ("GTIuserpanel_markStores", localPlayer )
		enabled3 = false
		guiSetProperty ( GUI_Button_Markstores, "NormalTextColour", "FFFC0000" )
	elseif source == GUI_Button_Updates then
		triggerServerEvent ("GTIuserPanel_updates", localPlayer )
		guiSetVisible ( GUI_Window_Userpanel, false )
		panel = false
	elseif source == GUI_Button_Vehmods then
		triggerEvent ("GTIuserpanel_vehmods", localPlayer )
		guiSetVisible ( GUI_Window_Userpanel, false )
		panel = false
	elseif source == Stats then
		triggerServerEvent("GTIstats.showStatsPanel", localPlayer )
	elseif source == CraftSystem then
		triggerEvent ("GTIcraftSystem_OpenGUI", localPlayer )
	elseif source == GUI_Button_Medkit then
		triggerEvent ("GTIuserpanel_takeMedkit", localPlayer )
	elseif source == Achievements and DX == false then
		DX = true
		addEventHandler ("onClientRender", root, DXnotification )
		setTimer ( removeNotification, 7500, 1 )
	elseif source == Settings and panel == false then
		guiSetVisible ( GUI_Window_Settings, true )
		panel = true
	elseif source == Settings and panel == true then
		guiSetVisible ( GUI_Window_Settings, false )
		panel = false
	elseif source == GUI_Button_Animations then
		triggerEvent ("GTIuserpanel_animations", localPlayer )
		guiSetVisible ( GUI_Window_Userpanel, false )
		panel = false
	elseif source == GUI_Button_ChangeColor1 then
		openPicker("color1")
		color = 1
	elseif source == GUI_Button_ChangeColor2 then
		openPicker("color2")
		color = 2
	elseif source == GUI_Button_ChangeColor3 then
		openPicker("color3")
		color = 3
	elseif source == GUI_Button_Carradio then
		triggerEvent ("GTIuserpanel_openCarradio", localPlayer )
		guiSetVisible ( GUI_Window_Userpanel, false )
		panel = false
	elseif source == GUI_Button_Laser and enabled4 == false then
		triggerEvent ("GTIuserPanel_laser", localPlayer )
		enabled4 = true
		guiSetProperty ( GUI_Button_Laser,"NormalTextColour", "FF00FD00" )
	elseif source == GUI_Button_Laser and enabled4 == true then
		triggerEvent ("GTIuserPanel_laser", localPlayer )
		enabled4 = false
		guiSetProperty ( GUI_Button_Laser,"NormalTextColour", "FFFC0000" )
	elseif source == GUI_Button_LaserColor then
		triggerEvent ("GTIuserPanel_laserColor", localPlayer )
	elseif source == GUI_Button_Close then
		guiSetVisible ( GUI_Window_BlipDistance, false )
	elseif source == GUI_Button_BlipDistance then
		guiSetVisible ( GUI_Window_BlipDistance, true )
		guiBringToFront ( GUI_Window_BlipDistance )
	elseif source == GUI_Button_Save then
		bd = guiGetText ( GUI_Edit1 )
		triggerServerEvent ("GTIuserPanel_changeBlipDistance", localPlayer, bd )
	elseif source == GUI_Button_Tutorial then
		triggerEvent ("GTIuserpanel_tutorial", localPlayer )
    end
end
addEventHandler ("onClientGUIClick", root, clicks )

function removeNotification ( )
	removeEventHandler ("onClientRender", root, DXnotification )
	DX = false
end
