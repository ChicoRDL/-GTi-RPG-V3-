local colLS = createColRectangle (-800.81671, -2990.10657, 5100, 3330)
local colLV = createColRectangle (-810, 350, 5000, 3000)
local colSF = createColRectangle (-4000, -3000, 3190, 6000)

lastCity = "LS"

function getPlayerCity(player)
	if (isElementWithinColShape(player, colLS)) then
		result = "LS"
		lastCity = "LS"
	elseif (isElementWithinColShape(player, colLV)) then
		result = "LV"
		lastCity = "LV"
	elseif (isElementWithinColShape(player, colSF)) then
		result = "SF"
		lastCity = "SF"
	else
		result = lastCity
	end
	return result
end

function formatNumber(n)
	if (not n) then return "Error catching data" end
    local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
    return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function getElementSpeed(element, unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
		end
	else
		return false
	end
end

function setElementSpeed(element, unit, speed)
	if (unit == nil) then unit = 0 end
	if (speed == nil) then speed = 0 end
	speed = tonumber(speed)
	local acSpeed = getElementSpeed(element, unit)
	if (acSpeed~=false) then -- if true - element is valid, no need to check again
		local diff = speed/acSpeed
		local x,y,z = getElementVelocity(element)
		setElementVelocity(element,x*diff,y*diff,z*diff)
		return true
	end

	return false
end

letters = { "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z" }
numbers = { "0","1","2","3","4","5","6","7","8","9" }

function generateLetter ( upper )
    if upper then return letters[ math.random ( #letters ) ]:upper ( ) end
    return letters[ math.random ( #letters ) ]
end

function generateNumber ( ) return numbers[ math.random ( 1, #numbers ) ] end

function generateString ( length )
    if not length or type ( length ) ~= "number" or math.ceil ( number ) < 2 then return false end
    local result = ""
    for i = 1, math.ceil ( length ) do
        if math.random ( 2 ) == 1 then upper = true else upper = false end

        if math.random ( 2 ) == 1 then result = result .. generateLetter ( upper )
        else result = result .. generateNumber ( ) end
    end
    return tostring ( result )
end

function centerElement(center_window)
    local screenW,screenH=guiGetScreenSize()
    local windowW,windowH=guiGetSize(center_window,false)
    local x,y = (screenW-windowW)/2,(screenH-windowH)/2
    guiSetPosition(center_window,x,y,false)
end

function isVehicleOnRoof(vehicle)
	local rx,ry=getElementRotation(vehicle)
	if (rx>90 and rx<270) or (ry>90 and ry<270) then
			return true
	end
	return false
end

_getRealTime = getRealTime
function getRealTime(bFormat)
	local time = _getRealTime()
	time.month = time.month + 1
	time.year = time.year + 1900
	if (bFormat) then
		if #tostring(time.hour) == 1 then time.hour = "0"..time.hour end
		if #tostring(time.minute) == 1 then time.minute = "0"..time.minute end
		if #tostring(time.second) == 1 then time.second = "0"..time.second end
		if #tostring(time.monthday) == 1 then time.monthday = "0"..time.monthday end
		if #tostring(time.month) == 1 then time.month = "0"..time.month end
	end
	return time
end

function findPlayer( player )
    if ( player and type( player ) == "string" ) then
        local playerElement = getPlayerFromName( player )
        if ( playerElement ) then return playerElement end
        local playersCounted = 0
        local player = string.lower(player)
        local spl = split( player, string.byte( "[" ) )
        if ( spl ) then
            player = table.concat( spl, ";" )
        end
        for k, v in pairs( getElementsByType( "player" ) ) do
            local name = string.lower( getPlayerName( v ) )
            local spl = split( name, string.byte( "[" ) )
            if ( spl ) then
                name = table.concat( spl, ";" )
            end
            if ( string.find( name, player ) ) then
                playerElement = v
                playersCounted = playersCounted + 1
            end
        end
        if ( playerElement and playersCounted == 1 ) then
            return playerElement
        end
        return false
    else
        return false
    end
end
