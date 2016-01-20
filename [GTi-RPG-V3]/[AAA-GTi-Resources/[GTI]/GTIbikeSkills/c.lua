local skill = 0
local maxDistance = 50
local maxSkill = 999
function recieveLvl(lvl)
	skill = lvl
	if skill < maxSkill then
		addEventHandler( "onClientPlayerStuntFinish",localPlayer,stunt)
		addEventHandler( "onClientPlayerStuntStart", localPlayer,stuntstart)
		addEventHandler( "onClientPlayerVehicleEnter", localPlayer,timer)
	else
		skill = 1000
	end
end
addEvent("GTIBikeSkills.setClient",true)
addEventHandler("GTIBikeSkills.setClient",root,recieveLvl)


function stunt(stuntType, stuntTime, distance)
	local x,y,z = getElementPosition(localPlayer)
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then return end
	if getVehicleController(veh) ~= localPlayer then return end
	local height = getHeight(startz,z)
	if antiTick and (getTickCount() - antiTick < 5000) then return end
	if skill >= maxSkill then
		removeEventHandler( "onClientPlayerStuntFinish",localPlayer,stunt)
		removeEventHandler( "onClientPlayerStuntStart", localPlayer,stuntstart)
		removeEventHandler( "onClientPlayerVehicleEnter", localPlayer,timer)
		exports.GTIhud:dm("Your bike skill is now at 1000/1000",255,255,0)
		triggerServerEvent("GTIBikeSkills.setSkills",resourceRoot,tonumber(skill))
		if isTimer(checkTimer) then killTimer(checkTimer) end
	end		
	if veh and startz and height > 0.85 and height < 25 and (getVehicleType(veh) == "Bike" or getVehicleType(veh) == "BMX") then
		if ( lastx and getDistanceBetweenPoints3D(x,y,z,lastx,lasty,lastz) < 75 ) or ( distance > maxDistance ) then return end
		skill = skill + math.ceil(height)
		lastx,lasty,lastz = x,y,z
		msg()
	end
end

function checkSpeed()
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then
		if isTimer(checkTimer) then killTimer(checkTimer) end
	return end
	if getVehicleController(veh) ~= localPlayer then return end
	if antiTick and (getTickCount() - antiTick < 5000) then return end
	if skill >= maxSkill then
		removeEventHandler( "onClientPlayerStuntFinish",localPlayer,stunt)
		removeEventHandler( "onClientPlayerVehicleEnter", localPlayer,timer)
		removeEventHandler( "onClientPlayerStuntStart", localPlayer,stuntstart)
		exports.GTIhud:dm("Your bike skill is now at 1000/1000",255,255,0)
		triggerServerEvent("GTIBikeSkills.setSkills",resourceRoot,tonumber(skill))
		if isTimer(checkTimer) then killTimer(checkTimer) end
	end
	if (getElementModel(veh) == 462 or getElementModel(veh) == 471 or getElementModel(veh) == 448) then 
		local speed = exports.GTIutil:getElementSpeed(veh, "kph")
		if speed > 100 then
			skill = skill + math.ceil(speed/20)
			msg()
		end
	elseif (getVehicleType(veh) == "Bike") then
		local speed = exports.GTIutil:getElementSpeed(veh, "kph")
		if speed > 125 then
			skill = skill + math.ceil(speed/25)
			msg()
		end
	elseif getVehicleType(veh) == "BMX" then
		local speed = exports.GTIutil:getElementSpeed(veh, "kph")
		if speed > 45 then
			skill = skill + math.ceil(speed/8)
			msg()
		end
	end
end
function timer()
	local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then return end
	if getVehicleController(veh) ~= localPlayer then return end
	if (getVehicleType(veh) == "Bike" or getVehicleType(veh) == "BMX") then
		if isTimer(checkTimer) then killTimer(checkTimer) end
		checkTimer = setTimer(checkSpeed,20000,0)
	end
end
function stuntstart()
	local x,y,z = getElementPosition(localPlayer)
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh and (getVehicleType(veh) == "Bike" or getVehicleType(veh) == "BMX") then
		startz = z
	end
end

function msg()
	if antiSpam and getTickCount() - antiSpam < 30000 then return end
	if skill >= maxSkill then
		skill = 1000
	return end
	exports.GTIhud:dm("Your bike skill is now at "..tostring(skill).."/1000",255,255,0)
	triggerServerEvent("GTIBikeSkills.setSkills",resourceRoot,tonumber(skill))
	antiSpam = getTickCount()
end

function getHeight(z1,z2)
	if z1 < z2 then
		return (z2-z1)
	else
		return (z1-z2)
	end
end

addCommandHandler("bikeskills", function()
	exports.GTIhud:dm("Your bike skill is at "..tostring(skill).."/1000",255,255,0)
end)