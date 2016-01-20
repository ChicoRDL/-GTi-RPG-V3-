MARKERS__ = {}


addEventHandler("onMarkerHit",root,function(element,match)
	m = false
	for k,v in ipairs ( MARKERS__ ) do
		if source == v then
			m = true
		end
	end
	if m == false then return end
	-----------------
	if element and match then
		if getElementType(element) == "player" then
			playerTune(element,getElementData(source,"ROT"))
		end
	end
end )

function getElementSpeed(element,unit)
	if (unit == nil) then unit = 0 end
	if (isElement(element)) then
		local x,y,z = getElementVelocity(element)
		if (unit=="mph" or unit==1 or unit =='1') then
			return (x^2 + y^2 + z^2) ^ 0.5 * 100
		else
			return (x^2 + y^2 + z^2) ^ 0.5 * 1.8 * 100
		end
	else
		outputDebugString("Not an element. Can't get speed")
		return false
	end
end

function setElementSpeed(element, unit, speed) -- only work if element is moving!
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

DIMS__ = 90
pPOS = {}
function playerTune(player,rot)
	if player then
		rot = 285
		--[[
		local wanted = getPlayerWantedLevel(player)
		if tonumber(wanted) > 3 then
			showText('#ff0000You must have less than 3 stars !',player)
			return
		end
		--]]
		------------------------
		local car = getPedOccupiedVehicle(player)
		if getPedOccupiedVehicleSeat(player) == 0 then
			if player then
				local pDIM = getElementDimension(car)
				setElementDimension(car,DIMS__)
				setElementDimension(player,DIMS__)
				local x,y,z = getElementPosition(car)
				local rx,ry,rz = getElementRotation(car)
				pPOS[player] = {x,y,z,rx,ry,rz,pDIM}
				setElementPosition(car,2387.1442871094,1053.4392089844,10.5)
				setElementRotation(car,0,360,359.2)
				setElementSpeed(car, "kph", tonumber(0))
				setTimer(setElementFrozen,300,1,car,true)
		--		setElementFrozen(car,true)
				setElementFrozen(player,true)
				setVehicleLocked(car,true)
				--
				local occupants = getVehicleOccupants(car)
				if occupants and #occupants > 1 then
					for k,v in ipairs ( occupants ) do
						setElementFrozen(v,true)
					end
				end
				--
				setVehicleDamageProof(car,true)
				ghostON(car)
				if rot then
					local _,__,rr = getElementRotation(car)
					setElementData(car,"ROTo",rr)
			--		setElementRotation(car,_,__,rot)
				end
				DIMS__ = DIMS__  + 1
				-------------------------------------
				triggerClientEvent(player,"showCarTune",player,car)
				-------------------------------------
				MODDING_CARS[car] = true
			end
		end
	end
end
addEvent("playerTune",true)
addEventHandler("playerTune",root,playerTune)

MODDING_CARS = {}
addEventHandler("onVehicleExplode",root,function()
	if MODDING_CARS[source] then
		cancelEvent()
	end
end )
_TIMERS = {}
addEvent("onMenuExit",true)
addEventHandler("onMenuExit",root,function()
	setCameraTarget(source)
	local car = getPedOccupiedVehicle(source)
	if car then
		setElementFrozen(car,false)
		setElementFrozen(source,false)
		setVehicleLocked(car,false)
		--
		--[[
		local _,__,rr = getElementRotation(car)
		local rot = getElementData(car,"ROTo")
		if rot then
			setElementRotation(car,_,__,rot)
		end
		
		--]]
		--
		setElementDimension(car,pPOS[source][7])
		setElementDimension(source,pPOS[source][7])
		setElementPosition(car,pPOS[source][1],pPOS[source][2],pPOS[source][3])
		setElementRotation(car,pPOS[source][4],pPOS[source][5],pPOS[source][6])
		--
		if not _TIMERS[source] then _TIMERS[source] = {} end
		if _TIMERS[source].damage then if isTimer(_TIMERS[source].damage) then killTimer(_TIMERS[source].damage) end end
		if _TIMERS[source].ghost then if isTimer(_TIMERS[source].ghost) then killTimer(_TIMERS[source].ghost) end end
		_TIMERS[source].damage = setTimer(setVehicleDamageProof,15 * 1000,1,car,false)
		_TIMERS[source].ghost = setTimer(ghostOFF,15 * 1000,1,car)
		--
		local occupants = getVehicleOccupants(car)
		if occupants and #occupants > 1 then
			for k,v in ipairs ( occupants ) do
				setElementFrozen(v,false)
			end
		end
	end
end )

addEvent("upgradeVehicle",true)
addEventHandler("upgradeVehicle",root,function(id)
	if id then
		local pVehicle = getPedOccupiedVehicle ( source )
		if pVehicle then
			setElementFrozen(pVehicle,false)
			addVehicleUpgrade(pVehicle,tonumber(id))
			setElementFrozen(pVehicle,true)
			showText("#FFFF00Upgrade has been added",source)
			fixVehicle(pVehicle)
		end
	end
end )

addEvent("unupgradeVehicle",true)
addEventHandler("unupgradeVehicle",root,function(id)
	if id then
		local pVehicle = getPedOccupiedVehicle ( source )
		if pVehicle then
			setElementFrozen(pVehicle,false)
			removeVehicleUpgrade(pVehicle,tonumber(id))
			setElementFrozen(pVehicle,true)
			showText("#FF0000Upgrade has been removed",source)
		end
	end
end )

GHOST_VEHs = {}
function ghostON(veh)
	if veh then
		table.insert(GHOST_VEHs,veh)
		triggerClientEvent("GhostOn",root,getElementsByType('vehicle'),veh)
	end
end

function ghostOFF(veh)
	if veh then
		triggerClientEvent("GhostOff",root,getElementsByType('vehicle'),veh)
		for k,v in ipairs (GHOST_VEHs ) do
			if v == veh then
				table.remove(GHOST_VEHs,k)
			end
		end
	end
end

addEvent("paintjobVehicle",true)
addEventHandler("paintjobVehicle",root,function(id)
	if id then
		local pVehicle = getPedOccupiedVehicle ( source )
		if pVehicle then
			setElementFrozen(pVehicle,false)
			setVehiclePaintjob(pVehicle,tonumber(id))
			fixVehicle(pVehicle)
			setElementFrozen(pVehicle,true)
			---
			showText("#ffff00Paintjob has been added",source)
			---
		end
	end
end )

function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

addEventHandler("onVehicleStartExit",root,function()
	into = false
	for k,v in ipairs ( GHOST_VEHs ) do
		if source == v then
			into = true
		end
	end
	if into then
		cancelEvent()
	end
end )
addEvent("setTheColor",true)
addEventHandler("setTheColor",root,function(c)
	if c then
		local r1, g1, b1, r2, g2, b2 = c[1],c[2],c[3],c[4],c[5],c[6]
		local r, g, b = c[7],c[8],c[9]
		local pVehicle = getPedOccupiedVehicle ( source )
		if pVehicle then
			setVehicleColor(pVehicle, r1, g1, b1, r2, g2, b2)
			setVehicleHeadLightColor(pVehicle, r, g, b)
			local hex = RGBToHex(r,g,b) or "#FFFF00"
			fixVehicle(pVehicle)
			showText(hex.."Color has been applied",source)
		end
	end
end )


addEvent("buyVehicleFix",true)
addEventHandler("buyVehicleFix",root,function()
	local pVehicle = getPedOccupiedVehicle ( source )
	if pVehicle then
		fixVehicle(pVehicle)
	end
end )

function showText(text,p)
	triggerClientEvent(p,"msg_txt",p,text)
end


addEvent("takeMoney",true)
addEventHandler("takeMoney",root,function(amount)
	if amount then
		exports.GTIbank:TPM ( source, tonumber(amount), "Tuning Shop" )
	end
end )