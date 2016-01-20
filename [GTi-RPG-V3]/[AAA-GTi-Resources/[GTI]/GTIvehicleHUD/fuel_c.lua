local sW, sH = guiGetScreenSize()
local rX, rY = 1600, 900

if sW <= 1024 and sH <= 768 then
	textRender = 0.50
	otherText = 1.00
else
	textRender = 1.00
	otherText = 1.50
end

local lastFuel = 0
local filledFuel = 0
local lastXDX = 0
local total = 0

local gasPrice = 3

local dxEnabled = false

function aToR( X, Y, sX, sY)
    local sW, sH = guiGetScreenSize()
    local xd = X/rX or X
    local yd = Y/rY or Y
    local xsd = sX/rX or sX
    local ysd = sY/rY or sY
    return xd*sW, yd*sH, xsd*sW, ysd*sH
end

function setDXEnabled( state)
	dxEnabled = state
end

function getDXEnabled()
	return dxEnabled
end

local text = "Hold Space To Fill Tank"

function checkHolding()
	if getKeyState( "space") then
		if lastFuel+filledFuel ~= 100 then
			text = "Filling"
			filledFuel = filledFuel+1
			if total == 0 then
				total = gasPrice
			else
				total = gasPrice+total
			end
		else
			text = "Fuel Tank Full"
		end
	else
		if lastFuel+filledFuel ~= 100 then
			text = "Hold Space To Fill Tank"
		else
			text = "Fuel Tank Full"
		end
	end
end
setTimer( checkHolding, 150, 0)

addEventHandler("onClientRender", root,
    function()
		--->> Rendering Each Gas Status
		for i, colshape in ipairs ( getElementsByType( "colshape", resourceRoot)) do
			local status = getElementData( colshape, "stationStatus")
			local mX, mY, mZ = getCameraMatrix()
			local x, y, z = getElementPosition( colshape)
			local x = x + 0.55
			local z = z + 2
			local dist = getDistanceBetweenPoints3D(mX, mY, mZ, x, y, z)
			local tick = getTickCount()/350
			local hover = math.sin(tick) * 10
			if (dist < 13) then
				if status then
					r, g, b = 81, 142, 60
					tStatus = "Pump not in Use"
				else
					r, g, b = 144, 60, 81
					tStatus = "Pump in use"
				end
				if isLineOfSightClear( mX, mY, mZ, x, y, z, true, true, false, true, true, false, false) then
					local x, y = getScreenFromWorldPosition(x, y, z)
					if x then
						local width = dxGetTextWidth( tStatus, 1.50, "sans")
						dxDrawRectangle( x-(width/1.8), y-18+hover, width+16, 34, tocolor( 0, 0, 0, 200), false) -- Box
						dxDrawRectangle( x-(width/1.8), y-18+hover, width+16, 2, tocolor( r, g, b, 200), false) -- Line
						dxDrawText( tStatus, x+1, y+1+(hover*2), x+1, y+1, tocolor( 255, 255, 255, 255), 1.50, "sans", "center", "center", false, false, false, false, false)
					end
				end
			end
			--[[
			dxDrawRectangle(963, 326, 166, 32, tocolor(0, 0, 0, 200), false)
			dxDrawRectangle(963, 320, 166, 6, tocolor( r, g, b, 200), false)
			dxDrawText( tStatus, 963, 326, 1129, 358, tocolor(255, 255, 255, 255), 1.50, "sans", "center", "center", false, false, false, false, false)
			--]]
		end
		--->> Rendering On Use Fuel Window
		if not dxEnabled then return end
		--->> Math
		local bX, bY, bSX, bSY = aToR( 10, 312, 215, 143)

		local barX3, barY3, barSX3, barSY3 = aToR( 29, 358, 179, 13) --Dark Green Back
		local barX4, barY4, barSX4, barSY4 = aToR( 29, 358, (lastFuel/100)*179, 13) --Green Front
		local lastXDX = barSX4

		local tX1, tY1, tSX1, tSY1 = aToR( 19, 318, 218, 335)
		local tX2, tY2, tSX2, tSY2 = aToR( 24, 425, 212, 453)
		local tX3, tY3, tSX3, tSY3 = aToR( 19, 340, 218, 357)
		local tX4, tY4, tSX4, tSY4 = aToR( 19, 381, 218, 398)
		local tX5, tY5, tSX5, tSY5 = aToR( 29, 398, 208, 415)
		local wX, wY, wSX, wSY = aToR( ((lastFuel/100)*179)+29, 358, (filledFuel/100)*179, 13)

        dxDrawRectangle(bX, bY, bSX, bSY, tocolor(0, 0, 0, 200), false)
        dxDrawText( text, tX1, tY1, tSX1, tSY1, tocolor(255, 255, 255, 255), textRender, "default", "center", "center", false, false, false, false, false)
        dxDrawText("Total: $"..total, tX2, tY2, tSX2, tSY2, tocolor(255, 255, 255, 255), otherText, "default-bold", "center", "center", false, false, false, false, false)
        dxDrawText("Last Tank Level: "..lastFuel.."%".." | Current: "..(lastFuel+filledFuel).."%", tX3, tY3, tSX3, tSY3, tocolor(255, 255, 255, 255), 1.00, "default", "center", "center", false, false, false, false, false)
        dxDrawRectangle( barX3, barY3, barSX3, barSY3, tocolor(22, 38, 25, 200), false)
        dxDrawText("Fuel Filled: "..filledFuel.."%", tX4, tY4, tSX4, tSY4, tocolor(255, 255, 255, 255), textRender, "default", "center", "center", false, false, false, false, false)
        dxDrawRectangle(barX4, barY4, barSX4, barSY4, tocolor(84, 146, 96, 200), false)
		dxDrawRectangle( wX, wY, wSX, wSY, tocolor(255, 255, 255, 250), false) -- White Shit Test
        dxDrawText((100-(lastFuel+filledFuel)).."% till Full Tank", tX5, tY5, tSX5, tSY5, tocolor(255, 255, 255, 255), textRender, "default", "center", "center", false, false, false, false, false)
    end
)

function enteredFuelStation( vehicle)
	if not getDXEnabled() then
		setDXEnabled( true)
	end
	local fuel = getElementData( vehicle, "fuel")
	lastFuel = fuel
	if filledFuel ~= 0 then
		filledFuel = 0
		total = 0
	end
end
addEvent( "GTIfuel.onFuelStationEnter", true)
addEventHandler( "GTIfuel.onFuelStationEnter", root, enteredFuelStation)

function leftFuelStation()
	if getDXEnabled() then
		setDXEnabled( false)
	end
	if total ~= 0 then
		triggerServerEvent( "GTIfuel.payFuelFee", source, lastFuel, filledFuel, total)
	end
	lastFuel = 0
	filledFuel = 0
	total = 0
end
addEvent( "GTIfuel.onFuelStationLeave", true)
addEventHandler( "GTIfuel.onFuelStationLeave", root, leftFuelStation)
