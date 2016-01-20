local KILL_DISTANCE = 250
local KILL_STREAK = {}
local KILL_TIMER = {}

addEvent ("onClientPlayerKillMessage",true)
function onClientPlayerKillMessage ( killer,weapon,wr,wg,wb,kr,kg,kb,width,resource )
    if wasEventCancelled() then return end
    outputKillMessage ( source, wr,wg,wb,killer,kr,kg,kb,weapon,width,resource )
end
addEventHandler ("onClientPlayerKillMessage",getRootElement(),onClientPlayerKillMessage)

function outputKillMessage ( source, wr,wg,wb,killer,kr,kg,kb,weapon,width,resource )
	if ( isElement(killer) and killer ~= source ) then
		if ( not KILL_STREAK[killer] ) then
			KILL_STREAK[killer] = 1
			if ( isTimer(KILL_TIMER[killer]) ) then killTimer(KILL_TIMER[killer]) end
			KILL_TIMER[killer] = setTimer(
				function (klr)
					KILL_STREAK[klr] = nil
				end, 5000, 1, killer)
		else
			KILL_STREAK[killer] = KILL_STREAK[killer] + 1
			if ( isTimer(KILL_TIMER[killer]) ) then killTimer(KILL_TIMER[killer]) end
				KILL_TIMER[killer] = setTimer(
					function (klr)
						KILL_STREAK[klr] = nil
					end, 5000, 1, killer)
		end
		
	end
	
    if (exports.GTIutil:getDistanceBetweenElements3D(localPlayer, source) > KILL_DISTANCE) then return false end 
    if (getElementDimension(localPlayer) ~= getElementDimension(source)) then return end

    if not iconWidths[weapon] then 
        if type(weapon) ~= "string" then
            weapon = 999 
        end
    end
    local killerName
    local wastedName
    if not tonumber(wr) then wr = 255 end
    if not tonumber(wg) then wg = 255 end
    if not tonumber(wb) then wb = 255 end
    if not tonumber(kr) then kr = 255 end
    if not tonumber(kg) then kg = 255 end
    if not tonumber(kb) then kb = 255 end
    if ( source ) then
        if isElement ( source ) then
            if getElementType ( source ) == "player" then 
                wastedName = getPlayerName ( source )
            else 
            outputDebugString ( "outputKillMessage - Invalid 'wasted' player specified",0,0,0,100)
            return false end
        elseif type(source) == "string" then
            wastedName = source
        end
    else 
        outputDebugString ( "outputKillMessage - Invalid 'wasted' player specified",0,0,0,100)
    return false end
    if ( killer ) then
        if isElement ( killer ) then
            if getElementType ( killer ) == "player" then
                killerName = getPlayerName ( killer )
            else 
                outputDebugString ( "outputKillMessage - Invalid 'killer' player specified",0,0,0,100)
            return false end
        elseif type(killer) == "string" then
            killerName = killer
        else
            killerName = ""
        end
		
		if ( KILL_STREAK[killer] > 1 ) then
			killerName = killerName .. " #FFFFFF(x"..KILL_STREAK[killer]..")"
		end
		
    else killerName = "" end
	

	
    --create the new text
    if not killerName then
        killerName = ""
    end
    return outputMessage ( {killerName, {"padding",width=3}, {"icon",id=weapon},
        {"padding",width=3},{"color",r=wr,g=wg,b=wb}, wastedName},
        kr,kg,kb )
end