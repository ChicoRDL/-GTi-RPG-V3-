----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 13 Dec 2013
-- Resource: GTIdroid/phoneGUI.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Images
---------->>

addEventHandler("onClientResourceStart", resourceRoot, function()

-- Phone Main
local sX,sY = guiGetScreenSize()
GTIPhone = guiCreateStaticImage(sX-321, sY+25, 305, 602, "phone/Nexus.png", false)
GTIStatusBar = guiCreateStaticImage(17, 50, 270, 18, "phone/status_solid.png", false, GTIPhone)
GTIMenuBar = guiCreateStaticImage(17, 535-39, 270, 39, "phone/menu_solid.png", false, GTIPhone)
GTIStatusBar2 = guiCreateStaticImage(0, 0, 270, 18, "phone/status_fluid.png", false, GTIPhone)
guiSetVisible(GTIStatusBar2, false)
GTIMenuBar2 = guiCreateStaticImage(0, 485-33, 270, 33, "phone/menu_fluid.png", false, GTIPhone)
guiSetVisible(GTIMenuBar2, false)

addEventHandler("onClientGUIClick", GTIMenuBar, goBack, false)
addEventHandler("onClientGUIClick", GTIMenuBar2, goBack, false)

GTIWallpaper = guiCreateStaticImage(17, 50, 270, 485, "wallpapers/Wallpaper.png", false, GTIPhone)
GTIStatusBarProp = guiCreateStaticImage(0, 0, 270, 18, "phone/status_fluid.png", false, GTIWallpaper)
GTIMenuBarProp = guiCreateStaticImage(0, 485-33, 270, 33, "phone/menu_fluid.png", false, GTIWallpaper)
GTISearchBar = guiCreateStaticImage(0, 23, 270, 30, "phone/search_bar.png", false, GTIWallpaper)

-- Main Apps
------------->>

local x1, x2, x3, x4 = 0, 69, 138, 209
local y1, y2, y3, y4, y5 = 48, 128, 203, 280, 400
Apps = {}
labels = {}			-- Labels
labels_sdw = {}		-- Label Shadows

-- Font
local font = guiCreateFont("fonts/Roboto.ttf")

-- Calculator
Apps["Calculator"] = guiCreateStaticImage(x1+12, y1+8, 40, 40, "apps/Calculator.png", false, GTIWallpaper)
labels_sdw[1] = guiCreateLabel(x1-2, y1+51, 67, 15, "Calculator", false, GTIWallpaper)
labels[1] = guiCreateLabel(x1-2, y1+50, 67, 15, "Calculator", false, GTIWallpaper)

-- Camera
Apps["Camera"] = guiCreateStaticImage(x2+12, y1+8, 40, 40, "apps/Camera.png", false, GTIWallpaper)
labels_sdw[2] = guiCreateLabel(x2-2, y1+51, 67, 15, "Camera", false, GTIWallpaper)
labels[2] = guiCreateLabel(x2-2, y1+50, 67, 15, "Camera", false, GTIWallpaper)

-- Clock
Apps["Clock"] = guiCreateStaticImage(x3+12, y1+8, 40, 40, "apps/Clock.png", false, GTIWallpaper)
labels_sdw[3] = guiCreateLabel(x3-2, y1+51, 67, 15, "Clock", false, GTIWallpaper)
labels[3] = guiCreateLabel(x3-2, y1+50, 67, 15, "Clock", false, GTIWallpaper)

-- Gallery
Apps["Gallery"] = guiCreateStaticImage(x4+12, y1+8, 40, 40, "apps/Gallery.png", false, GTIWallpaper)
labels_sdw[4] = guiCreateLabel(x4-2, y1+51, 67, 15, "Gallery", false, GTIWallpaper)
labels[4] = guiCreateLabel(x4-2, y1+50, 67, 15, "Gallery", false, GTIWallpaper)

-- Web Browser
Apps["Webbrowser"] = guiCreateStaticImage(x1+12, y2+8, 40, 40, "apps/Webbrowser.png", false, GTIWallpaper)
labels_sdw[5] = guiCreateLabel(x1-2, y2+51, 67, 15, "Browser", false, GTIWallpaper)
labels[5] = guiCreateLabel(x1-2, y2+50, 67, 15, "Browser", false, GTIWallpaper)

-- Maps
Apps["Maps"] = guiCreateStaticImage(x2+12, y2+8, 40, 40, "apps/Maps.png", false, GTIWallpaper)
labels_sdw[6] = guiCreateLabel(x2-2, y2+51, 67, 15, "Maps", false, GTIWallpaper)
labels[6] = guiCreateLabel(x2-2, y2+50, 67, 15, "Maps", false, GTIWallpaper)

-- Music
Apps["Music"] = guiCreateStaticImage(x3+12, y2+8, 40, 40, "apps/Music.png", false, GTIWallpaper)
labels_sdw[7] = guiCreateLabel(x3-2, y2+51, 67, 15, "Music", false, GTIWallpaper)
labels[7] = guiCreateLabel(x3-2, y2+50, 67, 15, "Music", false, GTIWallpaper)

-- Notes
Apps["Notes"] = guiCreateStaticImage(x4+12, y2+8, 40, 40, "apps/Notes.png", false, GTIWallpaper)
labels_sdw[8] = guiCreateLabel(x4-2, y2+51, 67, 15, "Notes", false, GTIWallpaper)
labels[8] = guiCreateLabel(x4-2, y2+50, 67, 15, "Notes", false, GTIWallpaper)

-- Vehicles
Apps["Vehicles"] = guiCreateStaticImage(x1+12, y3+8, 40, 40, "apps/Vehicles.png", false, GTIWallpaper)
labels_sdw[9] = guiCreateLabel(x1-2, y3+51, 67, 15, "Vehicles", false, GTIWallpaper)
labels[9] = guiCreateLabel(x1-2, y3+50, 67, 15, "Vehicles", false, GTIWallpaper)

-- Wallet
Apps["Wallet"] = guiCreateStaticImage(x2+12, y3+8, 40, 40, "apps/Wallet.png", false, GTIWallpaper)
labels_sdw[10] = guiCreateLabel(x2-2, y3+51, 67, 15, "Wallet", false, GTIWallpaper)
labels[10] = guiCreateLabel(x2-2, y3+50, 67, 15, "Wallet", false, GTIWallpaper)
guiLabelSetColor(labels[10], 255, 25, 25)

-- Translator
Apps["Translator"] = guiCreateStaticImage(x3+12, y3+8, 40, 40, "apps/Translator.jpeg", false, GTIWallpaper)
labels_sdw[11] = guiCreateLabel(x3-2, y3+51, 67, 15, "Translator", false, GTIWallpaper)
labels[11] = guiCreateLabel(x3-2, y3+50, 67, 15, "Translator", false, GTIWallpaper)


for i,label in ipairs(labels_sdw) do
	guiLabelSetHorizontalAlign(label, "center")
	guiSetFont(label, font)
	guiLabelSetColor(label, 0, 0, 0)
	guiSetAlpha(label, 0.5)
end
for i,label in ipairs(labels) do
	guiSetFont(label, font)
	guiLabelSetHorizontalAlign(label, "center")
end

-- Dock Apps
------------->>

-- Phone
Apps["Phone"] = guiCreateStaticImage(x1+12, y5+2, 40, 40, "apps/Phone.png", false, GTIWallpaper)

-- People
Apps["People"] = guiCreateStaticImage(x2+12, y5+2, 40, 40, "apps/People.png", false, GTIWallpaper)

-- Messages
Apps["Messages"] = guiCreateStaticImage(x3+12, y5+2, 40, 40, "apps/Messages.png", false, GTIWallpaper)

-- Settings
Apps["Settings"] = guiCreateStaticImage(x4+12, y5+2, 40, 40, "apps/Settings.png", false, GTIWallpaper)

for k,button in pairs(Apps) do
	addEventHandler("onClientMouseEnter", button, increaseAppSize, false)
	addEventHandler("onClientMouseLeave", button, decreaseAppSize, false)
end

-- Trigger Update All Event
---------------------------->>

addEvent("onGTIPhoneCreate", true)
triggerEvent("onGTIPhoneCreate", root)

end)
