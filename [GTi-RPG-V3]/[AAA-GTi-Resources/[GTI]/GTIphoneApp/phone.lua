----------------------------------------->>
-- GTI: Grand Theft International, II
-- Author: JT Pennington (JTPenn)
-- Date: 14 Mar 2015
-- Resource: GTIphoneApp/phone_gui.lua
-- Version: 1.0
----------------------------------------->>

addEvent("onGTIDroidClickBack", true)
addEvent("onGTIDroidClose", true)

local fontNumber = "default"
local fontLetter = "default"
local fontPNumber = "default"

local phone_number = ""	-- Phone Number to be Rendered

local buttonText = {
	["1"] = "",		["2"] = "ABC",	["3"] = "DEF",	["4"] = "GHI",	["5"] = "JKL",
	["6"] = "MNO",	["7"] = "PQRS",	["8"] = "TUV",	["9"] = "WXYZ", ["0"] = "+",
}

-- Create Phone GUI
-------------------->>

function phoneAppCreate(resource)
	resource = getResourceName(resource)
	if (resource ~= "GTIphoneAppJTP" and resource ~= "GTIdroid") then return end

	phoneGUI = {button = {}, window = {}, label = {}}
	
	if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
	GTIdroid = exports.GTIdroid:getGTIDroid()
	if (not GTIdroid) then return end
	GTIPhoneApp = exports.GTIdroid:getGTIDroidAppButton("Phone")
	addEventHandler("onClientGUIClick", GTIPhoneApp, showPanel, false)
	
	-- Custom Fonts
	fontNumber = dxCreateFont(":GTIdroid/fonts/Roboto.ttf", 28)
	fontPNumber = dxCreateFont(":GTIdroid/fonts/Roboto.ttf", 18)
	fontLetter = dxCreateFont(":GTIdroid/fonts/Roboto.ttf", 9)
	
	-- Static Image
	phoneGUI.window[1] = guiCreateStaticImage(17, 67, 270, 429, "images/phone_bkgd.png", false, GTIdroid)
	guiSetVisible(phoneGUI.window[1], false)
	-- Buttons
	phoneGUI.button[1] = guiCreateButton(0, 369, 270, 60, "PHONE CALL", false, phoneGUI.window[1])	phoneGUI.button[2] = guiCreateButton(0, 300, 90, 62, "*", false, phoneGUI.window[1])
	addEventHandler("onClientGUIClick", phoneGUI.button[2], typePhoneNumber, false)		phoneGUI.button[3] = guiCreateButton(90, 300, 90, 62, "0", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[3], typePhoneNumber, false)	
	phoneGUI.button[4] = guiCreateButton(180, 300, 90, 62, "#", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[4], typePhoneNumber, false)	
	phoneGUI.button[5] = guiCreateButton(0, 238, 90, 62, "7", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[5], typePhoneNumber, false)	
	phoneGUI.button[6] = guiCreateButton(90, 238, 90, 62, "8", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[6], typePhoneNumber, false)	
	phoneGUI.button[7] = guiCreateButton(180, 238, 90, 62, "9", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[7], typePhoneNumber, false)	
	phoneGUI.button[8] = guiCreateButton(0, 176, 90, 62, "4", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[8], typePhoneNumber, false)	
	phoneGUI.button[9] = guiCreateButton(90, 176, 90, 62, "5", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[9], typePhoneNumber, false)	
	phoneGUI.button[10] = guiCreateButton(180, 176, 90, 62, "6", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[10], typePhoneNumber, false)	
	phoneGUI.button[11] = guiCreateButton(0, 114, 90, 62, "1", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[11], typePhoneNumber, false)	
	phoneGUI.button[12] = guiCreateButton(90, 114, 90, 62, "2", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[12], typePhoneNumber, false)	
	phoneGUI.button[13] = guiCreateButton(180, 114, 90, 62, "3", false, phoneGUI.window[1])	addEventHandler("onClientGUIClick", phoneGUI.button[13], typePhoneNumber, false)	
	phoneGUI.button[14] = guiCreateButton(0, 0, 135, 35, "PHONE TAB", false, phoneGUI.window[1])	phoneGUI.button[15] = guiCreateButton(135, 0, 135, 35, "CONTACTS TAB", false, phoneGUI.window[1])	phoneGUI.button[16] = guiCreateButton(225, 35, 45, 79, "BACK", false, phoneGUI.window[1])
	addEventHandler("onClientGUIClick", phoneGUI.button[16], clearPhoneNumber, false)		-- Labels
	--[[phoneGUI.label[1] = guiCreateLabel(0, 35, 224, 78, "(555) 555-5555", false, phoneGUI.window[1])
	guiLabelSetHorizontalAlign(phoneGUI.label[1], "center", false)
	guiLabelSetVerticalAlign(phoneGUI.label[1], "center")--]]
	
	for _,i in ipairs({5, 6, 7, 8, 9, 10, 11, 12, 13, 3, 2, 4, 16, 1}) do
		guiSetAlpha(phoneGUI.button[i], 0)
	end
end
addEventHandler("onClientResourceStart", root, phoneAppCreate)

-- Render Button Text
---------------------->>

addEventHandler("onClientRender", root, function()
	GTIdroid = exports.GTIdroid:getGTIDroid()
	if (not GTIdroid) then return end
	if (not guiGetVisible(phoneGUI.window[1])) then return end
	local x,y = guiGetPosition(GTIdroid, false)
	
	-- Phone Number
	local display = phone_number
	if (tonumber(display)) then
		if (#phone_number > 4 and #phone_number <= 10) then
			display = string.sub(phone_number, 1, 3).."-"..string.sub(phone_number, 4)
		end
		if (#phone_number > 7 and #phone_number <= 10) then
			display = "("..string.sub(phone_number, 1, 3)..") "..string.sub(phone_number, 4, 6).."-"..string.sub(phone_number, 7)
		end
	end
	dxDrawText(display, x+17, y+67+35, x+17+224, y+67+35+78, tocolor(255,255,255,255), 1, fontPNumber, "center", "center", true, true, true)
	
	-- Back Button
	local cx,cy = getCursorPosition()
	local gx,gy = guiGetScreenSize()
	local cx,cy = cx*gx, cy*gy
	if (cx >= x+17+225 and cx <= x+17+225+45 and cy >= y+67+35 and cy <= y+67+35+79) then
		dxDrawRectangle(x+17+225+2, y+67+35, 45-4, 79, tocolor(35,120,150,125), true)
	end
	dxDrawImage(x+17+225, y+67+35, 45, 79, "images/back_icon.png", 0, 0, 0, -1, true)
	
	-- First Divider Line
	dxDrawRectangle(x+17, y+67+112, 270, 2, tocolor(0,0,0,255), true)
	
	-- Button Text
	for _,i in ipairs({5, 6, 7, 8, 9, 10, 11, 12, 13, 3}) do
		local secondary = buttonText[guiGetText(phoneGUI.button[i])]
		local x2,y2 = guiGetPosition(phoneGUI.button[i], false)
		local x,y = x+17+x2, y+67+y2
		
		local cx,cy = getCursorPosition()
		local gx,gy = guiGetScreenSize()
		local cx,cy = cx*gx, cy*gy
		if (cx >= x and cx <= x+90 and cy >= y and cy <= y+62) then
			dxDrawRectangle(x+3, y, 90-6, 62, tocolor(35,120,150,125), true)
		end
		
		dxDrawText(guiGetText(phoneGUI.button[i]), x+39, y+65-10, x+39, y+65-10, tocolor(57,202,255,255), 1, fontNumber, "right", "bottom", false, false, true)
		dxDrawText(secondary, x+42, y+49-10, x+42, y+49-10, tocolor(161,161,161,255), 1, fontLetter, "left", "bottom", false, false, true)
		dxDrawRectangle(x+43, y+51-10, 35, 2, tocolor(57,202,255,255), true)
	end
	
	for _,i in ipairs({2, 4}) do
		local x2,y2 = guiGetPosition(phoneGUI.button[i], false)
		local x,y = x+17+x2, y+67+y2
		
		local cx,cy = getCursorPosition()
		local gx,gy = guiGetScreenSize()
		local cx,cy = cx*gx, cy*gy
		if (cx >= x and cx <= x+90 and cy >= y and cy <= y+62) then
			dxDrawRectangle(x+3, y, 90-6, 62, tocolor(35,120,150,125), true)
		end
		
		dxDrawText(guiGetText(phoneGUI.button[i]), x+45, y+31, x+45, y+31, tocolor(161,161,161,255), 1, fontNumber, "center", "center", false, false, true)
	end
	
	-- Second Divider Line
	dxDrawRectangle(x+17, y+67+367, 270, 2, tocolor(0,0,0,255), true)
	
	-- Phone Call Button
	local cx,cy = getCursorPosition()
	local gx,gy = guiGetScreenSize()
	local cx,cy = cx*gx, cy*gy
	if (cx >= x+17 and cx <= x+17+270 and cy >= y+67+369 and cy <= y+67+369+60) then
		dxDrawRectangle(x+17+4, y+67+369, 270-8, 60, tocolor(0,255,0,125), true)
	end
	dxDrawImage(x+17, y+67+369, 270, 60, "images/phone_icon.png", 0, 0, 0, -1, true)
end)

-- Enter Phone Number
---------------------->>

function typePhoneNumber(button, state)
	if (button ~= "left" or state ~= "up") then return end
	local text = guiGetText(source)
	phone_number = phone_number..text
end

-- Clear Phone Number
---------------------->>

function clearPhoneNumber(button, state)
	if (button ~= "left" or state ~= "up") then return end
	phone_number = ""
end

-- Toggle Panel
---------------->>

function showPanel(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(phoneGUI.window[1], true)
	exports.GTIdroid:showMainMenu(false)
	exports.GTIdroid:playTick()
end

function hidePanel()
	guiSetVisible(phoneGUI.window[1], false)
	exports.GTIdroid:showMainMenu(true)
end
addEventHandler("onGTIDroidClickBack", root, hidePanel)
addEventHandler("onGTIDroidClose", root, hidePanel)
addEventHandler("onClientResourceStop", resourceRoot, hidePanel)
