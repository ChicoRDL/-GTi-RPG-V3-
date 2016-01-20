----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 29 Nov 2014
-- Resource: GTIprison/prison.lua
-- Type: Server Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local pMatrix = {
	{3150.290, 822.649, 1662.497, 3148.356, 824.391, 1661.466},
	{3116.496, 822.649, 1662.497, 3118.766, 824.391, 1661.466},
}

local tTimer 	-- Transition Timer
local text 		-- Render Text

local TRANS = 5000	-- Time for Render

-- Show Busted Notice
---------------------->>

addEvent("GTIprison.showBusted", true)
addEventHandler("GTIprison.showBusted", root, function(text_)
	text = text_
	addEventHandler("onClientRender", root, renderBusted)
	addEventHandler("onClientRender", root, renderCameraMovement)
	showPlayerHudComponent("radar", false)
	showChat(false)
	playSound("files/celldoorclose.mp3")
	
	setTimer(fadeCamera, TRANS-1000, 1, false)
	tTimer = setTimer(function()
		removeEventHandler("onClientRender", root, renderBusted)
		removeEventHandler("onClientRender", root, renderCameraMovement)
		showPlayerHudComponent("radar", true)
		setCameraTarget(localPlayer)
		fadeCamera(true)
		showChat(true)
	end, TRANS, 1)
end)

-- Render Busted Notice
------------------------>>

function renderBusted()
	local x,y = guiGetScreenSize()
	dxDrawRectangle(0, 0, x, y*0.12, tocolor(0,0,0,255))
	dxDrawRectangle(0, y*0.88, x, y, tocolor(0,0,0,255))
	
	local x,y = x/2, y/2
	dxDrawText("Busted", x+2, y+2, x+2, y+2, tocolor(0,0,0), 4, "diploma", "center", "center")
	dxDrawText("Busted", x-2, y+2, x-2, y+2, tocolor(0,0,0), 4, "diploma", "center", "center")
	dxDrawText("Busted", x+2, y-2, x+2, y-2, tocolor(0,0,0), 4, "diploma", "center", "center")
	dxDrawText("Busted", x-2, y-2, x-2, y-2, tocolor(0,0,0), 4, "diploma", "center", "center")
	dxDrawText("Busted", x, y, x, y, tocolor(255,255,255), 4, "diploma", "center", "center")
	
	local x,y = guiGetScreenSize()
	local x,y = x/2, y*0.94
	dxDrawText((text or ""), x, y, x, y, tocolor(255,255,255), 1.5, "default", "center", "center")
end

-- Render Camera Movement
-------------------------->>

function renderCameraMovement()
	if (not isTimer(tTimer)) then return end
	local rTime = getTimerDetails(tTimer)
	local x1, y1, z1, lx1, ly1, lz1 = pMatrix[1][1], pMatrix[1][2], pMatrix[1][3], pMatrix[1][4], pMatrix[1][5], pMatrix[1][6]
	local x2, y2, z2, lx2, ly2, lz2 = pMatrix[2][1], pMatrix[2][2], pMatrix[2][3], pMatrix[2][4], pMatrix[2][5], pMatrix[2][6]
	setCameraMatrix((((TRANS-rTime)/TRANS)*(x2-x1))+x1, (((TRANS-rTime)/TRANS)*(y2-y1))+y1, (((TRANS-rTime)/TRANS)*(z2-z1))+z1, (((TRANS-rTime)/TRANS)*(lx2-lx1))+lx1, (((TRANS-rTime)/TRANS)*(ly2-ly1))+ly1, (((TRANS-rTime)/TRANS)*(lz2-lz1))+lz1)
end
