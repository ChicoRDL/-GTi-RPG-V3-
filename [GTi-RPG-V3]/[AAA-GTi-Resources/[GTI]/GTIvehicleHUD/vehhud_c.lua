local sW, sH = guiGetScreenSize()
local rX, rY = 1366, 768 -- This is the resolution the DX was made in (LilDolla's Laptop Resolution) - DO NOT EDIT OR THE DX WILL FUCK UP
local dRX, dRY = 1600, 900
local textRender = 1
local lockTranslation = {
	[true] = "Locked",
	[false] = "Unlocked",
	["true"] = "Locked",
	["false"] = "Unlocked",
}


if sW <= 1024 and sH <= 768 then
	textRender = 0.8
	otherText = 0.75
else
	textRender = 1.35
	otherText = 1.0
end

SAFEZONE_Y = 0
preference = "kph"

function getRPMFromSpeed( theVehicle)
	local x, y, z = getElementPosition( theVehicle)
end

addEventHandler("onClientRender", root,
    function()
		-- Checks and Data
		if not isPedInVehicle(localPlayer) then return end
		local vehicle = getPedOccupiedVehicle( localPlayer)
		if (not isElement(vehicle)) then return end
		if isPlayerMapVisible() then return end
		local vehName = getVehicleName( vehicle)
		local health = getElementHealth ( vehicle)
		local shownHealh = math.floor( health/10)
		local mph = math.floor( exports.GTIutil:getElementSpeed(vehicle, preference))
		local milage = getElementData( vehicle, "mileage") or 0.00
		local milage = tonumber( string.format("%.3f", (milage*0.000621371)))
		local lock = getElementData( vehicle, "locked") or false
		local owner = getElementData( vehicle, "owner") or false
		if not getElementData( vehicle, "fuel") then
		fuel = 100
		else
		fuel = tonumber( getElementData( vehicle, "fuel") )
		end
		-- Math Functions
		local bX, bY, bSX, bSY = aToR( 1077, 694+SAFEZONE_Y, 221, 17) -- BG Math

		local hX, hY, hSX, hSY = aToR( 1080, 697+SAFEZONE_Y, (health/1000)*144, 11) -- Health Math
		local hBX, hBY, hBSX, hBSY = aToR( 1080, 697+SAFEZONE_Y, 144, 11) -- Health BG
		local hTX, hTY, hTSX, hTSY = aToR( 1077, 694+SAFEZONE_Y, 1224, 711) -- Health Text Math

		local fX, fY, fSX, fSY = aToR( 1227, 697, (fuel/100)*68, 11) -- Fuel Math
		local fBX, fBY, fBSX, fBSY = aToR( 1227, 697+SAFEZONE_Y, 68, 11) -- Fuel BG Math
		local fTX, fTY, fTSX, fTSY = aToR( 1227, 694+SAFEZONE_Y, 1298, 711) -- Fuel Text Math

		local sTX, sTY, sTSX, sTSY = aToR( 1182, 655+SAFEZONE_Y, 1298, 692) -- Speed Text Math

		local lTX, lTY, lTSX, lTSY = aToR( 1077, 677+SAFEZONE_Y, 1173, 692) -- Lock Text Math

		local mTX, mTY, mTSX, mTSY = aToR( 1077, 662+SAFEZONE_Y, 1173, 677) -- Milage Text Math
		-- Drawing

        dxDrawRectangle( bX, bY, bSX, bSY, tocolor(0, 0, 0, 200), false) -- Background

        dxDrawRectangle( hX, hY, hSX, hSY, tocolor(202, 153, 225, 200), false) -- Health Meter
		dxDrawRectangle( hBX, hBY, hBSX, hBSY, tocolor(29, 0, 87, 200), false) -- Health Back Meter
        dxDrawText(shownHealh.."% Health", hTX, hTY, hTSX, hTSY, tocolor(255, 255, 255, 255), otherText, "default", "center", "center", false, false, false, false, false)

        dxDrawRectangle( fX, fY, fSX, fSY, tocolor(73, 111, 189, 200), false) -- Fuel Meter
		dxDrawRectangle( fBX, fBY, fBSX, fBSY, tocolor(22, 38, 75, 200), false) -- Fuel Back Meter
        dxDrawText(fuel.."% Fuel", fTX, fTY, fTSX, fTSY, tocolor(255, 255, 255, 255), otherText, "default", "center", "center", false, false, false, false, false)

		dxDrawBorderedText(mph.." "..preference, sTX, sTY, sTSX, sTSY, tocolor(220, 220, 220, 255), textRender, "pricedown", "right", "center", false, false, false, false, true) -- Speed

		--->> other Items
        dxDrawText( vehName.." "..lockTranslation[lock], lTX, lTY, lTSX, lTSY, tocolor(255, 255, 255, 255), otherText, "default", "right", "center", false, false, false, false, false)
		if owner then
			dxDrawText( milage.." miles", mTX, mTY, mTSX, mTSY, tocolor(255, 255, 255, 255), otherText, "default", "right", "center", false, false, false, false, false)
		end

		--->> Technical Items
		-- RPM (Revolutions Per Minute)
		--local rpm = getRPMFromSpeed( Speed)
		--dxDrawText(" RPM", 1451, 833, 1515, 849, tocolor(255, 255, 255, 255), 1.00, "default", "right", "center", false, false, true, false, false)
    end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function ()
		local setting = exports.GTIsettings:getSetting("veh_units")
		if setting == "MPH" then
			preference = "kph"
		elseif setting == "KPH" then
			preference = "mph"
		end

		triggerServerEvent("GTIvehiclehud:onPlayerChangeSpeedUnits",localPlayer,preference)
	end
)

function setSpeedUnit(_preference)
	if (_preference) and (type(_preference) == "string") and (_preference == "mph") or (_preference == "kph") then
		preference = _preference
		--outputDebugString("Speed preference updated.")
	end
end
addEvent("GTIvehiclehud:onSpeedUnitCollected",true)
addEventHandler("GTIvehiclehud:onSpeedUnitCollected",root,setSpeedUnit)

function aToR( X, Y, sX, sY, rtype)
	local rCX, rCY = rX, rY
	if not rtype then
		rCX = rX
		rCY = rY
	else
		rCX = dRX
		rCY = dRY
	end
	local xd = X/rCX or X
	local yd = Y/rCY or Y
	local xsd = sX/rCX or sX
	local ysd = sY/rCY or sY
	return xd*sW, yd*sH, xsd*sW, ysd*sH
end

function dxDrawBorderedText( text, x, y, w, h, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, pixelPos)
	dxDrawText( text, x-2, y, w-2, h, tocolor(0, 0, 0, 255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, pixelPos) -- X Left Bold
	dxDrawText( text, x+2, y, w+2, h, tocolor(0, 0, 0, 255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, pixelPos) -- X Right Bold
	dxDrawText( text, x, y+2, w, h+2, tocolor(0, 0, 0, 255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, pixelPos) -- Y Up Bold
	dxDrawText( text, x, y-2, w, h-2, tocolor(0, 0, 0, 255), size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, pixelPos) -- Y Down Bold
	dxDrawText( text, x, y, w, h, color, size, font, alignX, alignY, clip, wordBreak, postGUI, colorCoded, pixelPos) -- Core Text
end
