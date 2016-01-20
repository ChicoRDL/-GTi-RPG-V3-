----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 26 Jul 2014
-- Resource: GTIaccounts/spawn.lua
-- Version: 1.0
----------------------------------------->>

local radio_buttons = {}	-- Table of Radio Buttons
isSelectingSpawn = nil		-- Is the player selecting a spawn point?

-- First Time Spawn GUI
------------------------>>

spawnGUI = {button = {}, window = {}, scrollpane = {}, label = {}}
-- Window
local sX, sY = guiGetScreenSize()
local wX, wY = 354, 284
local sX, sY = (sX/2)-(wX/2),(sY/2)-(wY/2)
-- sX, sY, wX, wY = 619, 298, 354, 284
spawnGUI.window[1] = guiCreateWindow(sX, sY, wX, wY, "GTI First Time Spawn Panel", false)
guiWindowSetSizable(spawnGUI.window[1], false)
guiSetAlpha(spawnGUI.window[1], 0.90)
guiSetVisible(spawnGUI.window[1], false)
-- Labels
spawnGUI.label[1] = guiCreateLabel(14, 24, 325, 32, "Welcome to Grand Theft International, <Player>\nSelect a location where you would like to spawn.", false, spawnGUI.window[1])
guiSetFont(spawnGUI.label[1], "clear-normal")
guiLabelSetHorizontalAlign(spawnGUI.label[1], "center", false)
-- Button
spawnGUI.button[1] = guiCreateButton(137, 242, 81, 33, "Spawn!", false, spawnGUI.window[1])
guiSetFont(spawnGUI.button[1], "default-bold-small")
guiSetProperty(spawnGUI.button[1], "NormalTextColour", "C8FFFFFF")
-- Scrollpane
spawnGUI.scrollpane[1] = guiCreateScrollPane(9, 75, 336, 162, false, spawnGUI.window[1])

-- Show Spawn Panel
-------------------->>

function firstTimeSpawn(spawn_points)
	isSelectingSpawn = true
	if (not areTransitionsRunning()) then
		startTransitions()
	end
	setElementInterior(localPlayer, 0)
	for i,v in ipairs(spawn_points) do
		local text = getZoneName(v[1], v[2], v[3], false)..", "..getZoneName(v[1], v[2], v[3], true)
		local radio = guiCreateRadioButton(0, 25*(i-1), 336, 15, text, false, spawnGUI.scrollpane[1])
		radio_buttons[radio] = i
	end
	guiSetText(spawnGUI.label[1], "Welcome to Grand Theft International, "..getPlayerName(localPlayer).."\nSelect a location where you would like to spawn.")
	
	guiSetVisible(spawnGUI.window[1], true)
	showCursor(true)
end
addEvent("GTIaccounts.firstTimeSpawn", true)
addEventHandler("GTIaccounts.firstTimeSpawn", root, firstTimeSpawn)

function spawnPlayerAtLocation(button, state)
	if (button ~= "left" or state ~= "up") then return end
	for button,i in pairs(radio_buttons) do
		if (guiRadioButtonGetSelected(button)) then
			triggerServerEvent("GTIaccounts.spawnPlayerAtLocation", resourceRoot, i)
			guiSetVisible(spawnGUI.window[1], false)
			showCursor(false)
			stopTransitions()
			isSelectingSpawn = nil
			return
		end
	end
	exports.GTIhud:dm("Select a spawn location first", 255, 125, 0)
end
addEventHandler("onClientGUIClick", spawnGUI.button[1], spawnPlayerAtLocation, false)
