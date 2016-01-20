local colLS = createColRectangle (-800.81671, -2990.10657, 5100, 3330)
local colLV = createColRectangle (-810, 350, 5000, 3000)
local colSF = createColRectangle (-4000, -3000, 3190, 6000)
local lastaccker = {}
local lastZone = {}
function getPlayerCity(player)
	if (isElementWithinColShape(player, colLS)) then
		result = "LS"
		lastZone[player] = "LS"
	elseif (isElementWithinColShape(player, colLV)) then
		result = "LV"
		lastZone[player] = "LV"
	elseif (isElementWithinColShape(player, colSF)) then
		result = "SF"
		lastZone[player] = "SF"
	else
		result = lastZone[player]
	end
	return result
end


function onDamage(attacker)
	if (not isElement(attacker) or getElementType(attacker) ~= "player") then return end
	lastaccker[attacker] = getPlayerName(source)
end
addEventHandler("onPlayerDamage", root, onDamage)

function getLastAttacker(player)
	return lastaccker[player] or false
end

function getPositionInfrontOfElement(element, meters)
	if (not element or not isElement(element)) then return false end
	if (not meters) then meters = 3 end
	local posX, posY, posZ = getElementPosition(element)
	local _, _, rotation = getElementRotation(element)
	posX = posX - math.sin(math.rad(rotation)) * meters
	posY = posY + math.cos(math.rad(rotation)) * meters
	return posX, posY, posZ
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
