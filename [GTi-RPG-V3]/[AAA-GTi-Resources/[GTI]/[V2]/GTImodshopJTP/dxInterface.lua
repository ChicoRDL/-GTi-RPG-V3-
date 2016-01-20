----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 05 Mar 2015
-- Resource: GTImodshop/dxInterface.lua
-- Version: 1.0
----------------------------------------->>

local sX,sY = guiGetScreenSize()
local sX,sY = sX*0.05, sY*0.05		-- DX Window Base

local dx = {}	-- Table of DX Data
local gui = {}	-- Table of GUI Buttons

dxFont = "default"
addEventHandler("onClientResourceStart", resourceRoot, function()
	dxFont = dxCreateFont("images/LondonSixty.ttf", 10)
end)

-- Create Window
----------------->>

function dxCreateWindow(id, image, title)
	dx = {}
	dx.id = id
	dx.titleImage = {0, 0, 300, 64, image}
	dx.titleBar = {0, 64, 300, 28, title, 0}
	return true
end

function dxDestroyWindow()
	dx = {}
	for i,v in ipairs(gui) do
		destroyElement(v)
	end
	gui = {}
	return true
end

function dxGetWindowID()
	return dx.id
end

-- Create Button
----------------->>

function dxCreateButton(titleA, titleB)
	if (not dx.button) then dx.button = {} end
	table.insert(dx.button, {titleA, titleB, false})
	return true
end

-- Button Functions
-------------------->>

addEventHandler("onClientMouseEnter", resourceRoot, function()
	local index = getElementData(source, "index")
	if (not index) then return end
	dx.button[index][3] = true
	dx.titleBar[6] = index
end)

addEventHandler("onClientMouseLeave", resourceRoot, function()
	local index = getElementData(source, "index")
	if (not index) then return end
	dx.button[index][3] = false
	dx.titleBar[6] = 0
end)

-- Draw DX Window
------------------>>

addEventHandler("onClientRender", root, function()
	for k,v in pairs(dx) do
		if (k == "titleImage") then
			dxDrawImage(sX+v[1], sY+v[2], v[3], v[4], v[5], 0, 0, 0, tocolor(255,255,255,225))
		elseif (k == "titleBar") then
			dxDrawRectangle(sX+v[1], sY+v[2], v[3], v[4], tocolor(0,0,0,225))
			dxDrawText(string.upper(v[5]), sX+v[1]+5, sY+v[2]+(v[4]/2), sX+v[1]+5, sY+v[2]+(v[4]/2), tocolor(255,255,255,255), 1, dxFont, "left", "center")
			dxDrawText(v[6].." / "..#dx.button, sX+v[1]+300-5, sY+v[2]+(v[4]/2), sX+v[1]+300-5, sY+v[2]+(v[4]/2), tocolor(255,255,255,255), 1, dxFont, "right", "center")
		elseif (k == "button") then
			for i,v in ipairs(dx[k]) do
				local x,y,width,height = sX+0,sY+92,300,28
				i = i - 1
				local r1,g1,b1,r2,g2,b2 = 0,0,0,255,255,255
				if (v[3]) then
					r1,g1,b1,r2,g2,b2 = 255,255,255,0,0,0
				end
				dxDrawRectangle(x, y+(i*28), width, height, tocolor(r1,g1,b1,200))
				dxDrawText(v[1], x+5, y+14+(i*28), x+5, y+14+(i*28), tocolor(r2,g2,b2,255), 1, dxFont, "left", "center")
				dxDrawText(v[2], x+width-5, y+14+(i*28), x+width-5, y+14+(i*28), tocolor(r2,g2,b2,255), 1, dxFont, "right", "center")
				if (not gui[i+1] or not isElement(gui[i+1])) then
					gui[i+1] = guiCreateButton(x, y+(i*28), width, height, "", false)
					guiSetAlpha(gui[i+1], 0)
					setElementData(gui[i+1], "index", i+1, false)
					setElementData(gui[i+1], "name", v[1], false)
				end
			end
		end
	end
end)