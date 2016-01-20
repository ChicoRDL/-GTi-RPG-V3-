----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

local pickups = {
 
-- Hospitals
[createPickup ( 2022.725, -1419.219, 16.992, 3, 1239, 50, 1 )] = {"JeffHos", 100, 10000, "This is Jefferson Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( 1162.200, -1320.839, 15.386, 3, 1239, 50, 1 )] = {"AllSaintsHos", 100, 10000, "This is All Saints Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( -2203.827, -2291.320, 30.625, 3, 1239, 50, 1 )] = {"AngelPineHos", 100, 10000, "This is Angel Pine Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( -2643.200, 635.853, 14.453, 3, 1239, 50, 1 )] = {"SantaFloraHos", 100, 10000, "This is Santa Flora Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( -1523.300, 2520.893, 55.882, 3, 1239, 50, 1 )] = {"TierraRobadaHos", 100, 10000, "This is Tierra Robada Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( -246.015, 2609.594, 62.858, 3, 1239, 50, 1 )] = {"BoneCountyHos", 100, 10000, "This is Bone County Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( -312.115, 1054.324, 19.742, 3, 1239, 50, 1 )] = {"FortCarsonHos", 100, 10000, "This is Fort Carson Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( 1621.600, 1817.658, 10.820, 3, 1239, 50, 1 )] = {"LasVenturasHos", 100, 10000, "This is Las Venturas Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( 2277.656, -78.849, 26.560, 3, 1239, 50, 1 )] = {"PalaminoCreekHos", 100, 10000, "This is Palomino Creek Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},
[createPickup ( 110.011, -192.583, 1.522, 3, 1239, 50, 1 )] = {"BlueBerryHos", 100, 10000, "This is Blue Berry Hospital. You will respawn here each time you die. You can get a rental vehicle from here. The Bobcat, Faggio and Greenwood are rental vehicles you can use with any occupation"},

-- Banks
[createPickup ( 1046.927, 1008.689, 11.000, 3, 1239, 50, 1 )] = {"LVBank", 100, 10000, "This is Las Venturas Bank, you can deposit, withdraw and send money here. You can also setup a pin to acces ATMs around San Andreas. You will also be able to find transactions logs here!"},
[createPickup ( 1589.140, -1318.316, 17.528, 3, 1239, 50, 1 )] = {"LSBank", 100, 10000, "This is Los Santos Bank, you can deposit, withdraw and send money here. You can also setup a pin to acces ATMs around San Andreas. You will also be able to find transactions logs here!"},
[createPickup ( -2043.721, 467.058, 35.172, 3, 1239, 50, 1 )] = {"SFBank", 100, 10000, "This is San Fierro Bank, you can deposit, withdraw and send money here. You can also setup a pin to acces ATMs around San Andreas. You will also be able to find transactions logs here!"},

-- Token Shops
[createPickup ( 2008.792, 1172.061, 10.820, 3, 1239, 50, 1 )] = {"LVToken", 100, 10000, "This is Las Venturas Token shop, here you can buy premium features. In order to buy a premium feature you need tokens. For more information about the token shop visit gtirpg.net/donate"},
[createPickup ( 1645.089, -1242.352, 14.813, 3, 1239, 50, 1 )] = {"LSToken", 100, 10000, "This is Los Santos Token shop, here you can buy premium features. In order to buy a premium feature you need tokens. For more information about the token shop visit gtirpg.net/donate"},
[createPickup ( -1915.716, 487.490, 35.172, 3, 1239, 50, 1 )] = {"SFToken", 100, 10000, "This is San Fierro Token shop, here you can buy premium features. In order to buy a premium feature you need tokens. For more information about the token shop visit gtirpg.net/donate"},

-- Pay n Spray's
[createPickup ( 1999.803, -2526.450, 13.547, 3, 1239, 50, 1 )] = {"PaynSpray1", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 2072.782, -1834.483, 13.547, 3, 1239, 50, 1 )] = {"PaynSpray2", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 1021.087, -1030.564, 32.042, 3, 1239, 50, 1 )] = {"PaynSpray3", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 491.622, -1733.917, 11.268, 3, 1239, 50, 1 )] = {"PaynSpray4", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( -1665.553, -365.780, 14.148, 3, 1239, 50, 1 )] = {"PaynSpray5", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( -2106.535, -2252.589, 30.625, 3, 1239, 50, 1 )] = {"PaynSpray6", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( -1899.421, 275.826, 41.039, 3, 1239, 50, 1 )] = {"PaynSpray7", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( -2419.924, 1029.332, 50.391, 3, 1239, 50, 1 )] = {"PaynSpray8", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( -1781.751, 1208.177, 25.125, 3, 1239, 50, 1 )] = {"PaynSpray9", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( -2400.916, 2350.076, 4.992, 3, 1239, 50, 1 )] = {"PaynSpray10", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( -1425.454, 2592.513, 55.797, 3, 1239, 50, 1 )] = {"PaynSpray11", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( -94.753, 1110.025, 19.742, 3, 1239, 50, 1 )] = {"PaynSpray12", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 394.983, 2531.029, 16.544, 3, 1239, 50, 1 )] = {"PaynSpray13", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 1323.436, 1478.688, 10.820, 3, 1239, 50, 1 )] = {"PaynSpray14", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 2388.027, 1480.557, 10.813, 3, 1239, 50, 1 )] = {"PaynSpray15", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 1629.202, 575.825, 1.758, 3, 1239, 50, 1 )] = {"PaynSpray16", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 2406.471, 100.278, 26.472, 3, 1239, 50, 1 )] = {"PaynSpray17", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 716.686, -464.221, 16.023, 3, 1239, 50, 1 )] = {"PaynSpray18", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},
[createPickup ( 275.199, 19.748, 2.429, 3, 1239, 50, 1 )] = {"PaynSpray19", 100, 10000, "This is a Pay n Spray, here you can repair your vehicle, the cost of the repair depends on the value ($) and damage of your vehicle"},

-- Vehicle shops
[createPickup ( 1017.222, -1311.289, 13.547, 3, 1239, 50, 1 )] = {"VehicleShop1", 100, 10000, "This is a Bike shop, here you can buy bikes for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
[createPickup ( 2228.628, -2208.048, 13.547, 3, 1239, 50, 1 )] = {"VehicleShop2", 100, 10000, "This is a Industrial car shop, here you can buy cars for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
[createPickup ( 2133.357, -1122.626, 25.412, 3, 1239, 50, 1 )] = {"VehicleShop3", 100, 10000, "This is a Car shop, here you can buy cars for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
[createPickup ( -1967.394, 291.781, 35.172, 3, 1239, 50, 1 )] = {"VehicleShop4", 100, 10000, "This is a Car shop, here you can buy cars for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
[createPickup ( 275.199, 19.748, 2.429, 3, 1239, 50, 1 )] = {"VehicleShop5", 100, 10000, "This is a Bike, Heli and Car shop, here you can buy bikes, cars and choppers for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
[createPickup ( 2155.782, 1426.054, 10.862, 3, 1239, 50, 1 )] = {"VehicleShop6", 100, 10000, "This is a Car shop, here you can buy cars for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
[createPickup ( 1578.854, 1194.595, 10.813, 3, 1239, 50, 1 )] = {"VehicleShop7", 100, 10000, "This is an Aircraft shop, here you can buy choppers and planes for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
[createPickup ( 1866.315, -2215.725, 13.547, 3, 1239, 50, 1 )] = {"VehicleShop8", 100, 10000, "This is an Aircraft shop, here you can buy choppers and planes for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
[createPickup ( -1417.611, -527.833, 14.148, 3, 1239, 50, 1 )] = {"VehicleShop9", 100, 10000, "This is an Aircraft shop, here you can buy choppers and planes for money. Enter the Dollar icon and press Z to open the gui, to close the gui right click on it"},
}

showingSpecialInfoBox = nil
charsPerLine = 20
x, y = guiGetScreenSize()
rectPosX = x / 2.5
rectPosY = x / 40
rectSizeX = x / 5
rectSizeY = x / 92

function outputInfoBox(id, amount, timeDisplayed, ...)
	amount = amount or 100
	dTime = tonumber(timeDisplayed) or 10000
	text = table.concat({...}, "")
	id = tostring(id)
	counterInfo = xmlLoadFile("counter.xml")
	if (not counterInfo) then
		counterInfo = xmlCreateFile("counter.xml", "IDcounters")
	end
	idExists = xmlFindChild(counterInfo, id, 0)
	if (idExists) then
		count = xmlNodeGetValue(idExists)
		if (count) then
			if (tonumber(count) < amount) then
				newCount = tonumber(count) + 1
				xmlNodeSetValue(idExists, tostring(newCount))
			elseif (tonumber(count) >= amount) then
				return
			end
		end
	elseif (not idExists) then
		addACount = xmlCreateChild(counterInfo, ""..id.."")
		xmlNodeSetValue(addACount, "1")
	end
	xmlSaveFile(counterInfo)
	xmlUnloadFile(counterInfo)
	removeEventHandler("onClientRender", root, drawText)
	addEventHandler("onClientRender", root, drawText)
	setTimer(deleteInfoBox, dTime, 1)
	showingSpecialInfoBox = true
end

function drawText()
	local lines = math.ceil(#text)/charsPerLine
	dxDrawRectangle(rectPosX, rectPosY - (lines/2), rectSizeX, rectSizeY * lines, tocolor(0, 0, 0, 173), false) 
	dxDrawText(tostring(text), rectPosX, rectPosY - (lines/2), rectPosX + rectSizeX, rectPosY + rectSizeY, tocolor(255, 255, 255, 255), x / 1000, "default-bold", "center", "top", false, true, true)
end

function deleteInfoBox()
	showingSpecialInfoBox = false
	removeEventHandler("onClientRender", root, drawText)
end

function outputPickup(hitElement, mDim)
	if (hitElement == localPlayer and mDim) then
		local info = pickups[source]
		playSoundFrontEnd(32)
		outputInfoBox(info[1], info[2], info[3], info[4])
	end
end

for pickup, info in pairs(pickups) do
	addEventHandler("onClientPickupHit", pickup, outputPickup)
end
