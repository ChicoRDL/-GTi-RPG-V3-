local timers = {}
local _error = error
local message = exports.GTIhud
local suiciding = {}

--List of the required custom events that we need
addEvent("onPlayerQuitJob",true)
addEvent("onPlayerStartTaze",true)
addEvent("onPlayerMedicHealed",true)
addEvent("onPlayerArrested",true)

function suicide(player,override,reason)
	if not player or not isElement(player) then return end
	if isPedDead(player) then return end

	if override then
		--Should the event handlers be added here?

		if isTimer(timers[player]) then
			killTimer(timers[player])
		else
			return false
		end

		if not reason then
			reason = "The cyanide failed to kill you."
		end

		player:fadeCamera(true,5)
		setPedAnimation(player,false)
		player:setData("suiciding",false,true)
		suiciding[player] = false
		return message:dm(reason,player,255,0,0)
	end

	if (getElementInterior(player) ~= 0) then return exports.GTIhud:dm("You can't commit suicide while inside a building.",player,255,0,0) end
	
	if not isTimer(timers[player]) then
		if isPedInVehicle(player) then return message:dm("You can't commit suicide while in a vehicle.",player,255,0,0) end
		if exports.GTIgangTerritories:canPlayerTurf(player) then return message:dm("You can't commit suicide while turfing.",player,255,0,0) end
	
		exports.GTIanims:setJobAnimation(player,"CRACK","crckdeth1",-1,false,false,false,true)
		timers[player] = Timer(effect,250,0,player)
		time = getTimeBasedOnHealth(player:getHealth())
		player:fadeCamera(false,tonumber(time),0,0,0)
		message:dm("Your life begins to slip away as the cyanide pill takes effect.",player,255,0,0)
		message:dm("Use /kill again to take the antidote.",player,255,255,0)
		player:setData("suiciding",true,true)
		suiciding[player] = true
		return true
	else
		suicide(player,true,"You sipped the antidote. Your body functionality begins to stable.",player,255,255,0)
		player:setData("suiciding",false,true)
		suiciding[player] = nil
		return
	end
end

function exception(player,state,reason)
	if not suiciding[player] then return false end
	suicide(player,state,reason)
end
addEventHandler("onPlayerQuitJob",root,function() exception(source,true) end)
addEventHandler("onPlayerDamage",root,function(attacker) if attacker and isElement(attacker) then exception(source,true) end end)
addEventHandler("onPlayerMedicHealed",root,function() exception(source,true,"A paramedic forced the antidote into your system. Your body functionality begins to stable.") end)
addEventHandler("onPlayerArrested",root,function() exception(source,true,"A law enforcement has forced you to take the antidote. Your body functionality begins to stable.") end)
addEventHandler("onPlayerStartTaze",root,function() exception(source,true,"A law enforcement has forced you to take the antidote. Your body functionality begins to stable.") end)
addEventHandler("onPlayerWasted",root,function() exception(source,true) end)

function effect(player)
	if not player or not isElement(player) then
		if isTimer(timers[player]) then
			return killTimer(timers[player])
		end
	end

	if not player then return false end
	if isElement( player) and (getElementType( player) == "player" or getElementType( player) == "ped") then
		if isPedDead(player) then
			if isTimer( timers[player]) then
				return killTimer(timers[player])
			end
		end
	end

	if not timers[player] then return false end

	local health = player:getHealth()
	if (math.floor(health) <= 1) then
		if isTimer(timers[player]) then killTimer(timers[player]) end
		player:fadeCamera(true,1)
		setPedAnimation(player,false)
		killPed(player)
		suiciding[player] = false
		return
	else
		player:setHealth(health-1)
	end
	return
end

function getTimeBasedOnHealth(health)
	if not health then return 5 end

	return math.floor(health/5)
end

function isPlayerSuiciding(player)
	if player and isElement(player) then
		return getElementData(player,"suiciding") or nil
	end

	--If the return didn't do it's job in the timer check, we'll return false from here.
	return false
end

addEventHandler("onPlayerWasted", root, function()
	removeElementData(source,"suiciding")
end)

function error(player,text)
	return exports.GTIhud:dm(text,player,255,0,0)
end
