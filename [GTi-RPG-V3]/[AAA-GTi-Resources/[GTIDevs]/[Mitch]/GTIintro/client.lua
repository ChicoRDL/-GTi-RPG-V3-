local sx, sy = guiGetScreenSize ( )
local px, py = 1920, 1080
local x, y   = ( sx / px ), ( sy /py )
local text1
local text2

if sx <= 1024 and sy <= 768 then
    smallText = 0.50
else
    smallText = 1.00
end

function first_intro ( )
	--if player == source then
		text1 = true
		setCameraMatrix ( 1240.386, -2037.082, 86.142, 1239.409, -2037.081, 85.930 )
		addEventHandler ("onClientRender", root, drawText )
		setTimer ( police_intro, 10000, 1 )
		setTimer ( removeDrawText, 9500, 1 )
		setTime ( 00, 00 )
		toggleAllControls ( false, false, false )
		showPlayerHudComponent ( "radar", false )
		setElementFrozen ( localPlayer, true )
		showChat ( false )
end
addCommandHandler ("mitch-test", first_intro )
--addEventHandler ("onClientPlayerSpawn", root, intro )

function police_intro ( )
	text1 = false
	text2 = true
	setCameraMatrix ( 1454.263, -1718.646, 99.449, 1523.984, -1680.773, 38.583 )
	addEventHandler ("onClientRender", root, drawText )
	setTimer ( resetPlayerFunctions, 10000, 1 )
	setTimer ( removeDrawText, 10000, 1 )
end

function drawText ( )
	if text1 == true then
		dxDrawText ( "Welcome to GTI RPG! This intro will show you around GTI and show you some of our features!", x*100, y*250, x*1920, y*500, tocolor ( 0, 200, 35 ), smallText, "bankgothic", "center", "center", false, false, true, false, false )
		dxDrawText ( "Features shown in this intro:", x*50, y*350, x*900, y*500, tocolor ( 0, 200, 35 ), smallText, "bankgothic", "center", "center", false, false, true, false, false )
		dxDrawText ( "- Police Department & Police Officer", x*50, y*450, x*1025, y*500, tocolor ( 0, 166, 255 ), smallText, "bankgothic", "center", "center", false, false, true, false, false )
		dxDrawText ( "- Rental System", x*50, y*550, x*685, y*500, tocolor ( 178, 23, 255 ), smallText, "bankgothic", "center", "center", false, false, true, false, false )
		dxDrawText ( "- Civilian Jobs", x*50, y*650, x*655, y*500, tocolor ( 235, 209, 19 ), smallText, "bankgothic", "center", "center", false, false, true, false, false )
	elseif text2 == true then
		dxDrawText ( "GTI has multiple jobs, this right here is the Police Department in Los Santos (LS)", x*100, y*250, x*1920, y*500, tocolor ( 0, 166, 255 ), smallText, "bankgothic", "center", "center", false, false, true, false, false )
	end
end

function removeDrawText ( )
	removeEventHandler ( "onClientRender", root, drawText )
end

function resetPlayerFunctions ( )
	toggleAllControls ( true, true, true )
	showPlayerHudComponent ( "radar", true )
	showChat ( true )
	setCameraTarget ( localPlayer )
	setElementFrozen ( localPlayer, false )
end