------------------------------------------------->>
-- PROJECT:			Grand Theft International
-- RESOURCE: 		GTIJournalist/journalist_server.lua
-- DESCRIPTION:		Journalist job, take pictures of crimes/suicides > fill an report.
-- AUTHOR:			Nerox
-- RIGHTS:			All rights reserved to author
------------------------------------------------->>
local deathReasons = {
	[19] = "Rocket",
	[49] = "Rammed",
	[50] = "Ranover",
	[51] = "Explosion",
	[52] = "Driveby",
	[53] = "Drowned",
	[54] = "Fall",
	[55] = "Unknown",
	[56] = "Melee",
	[57] = "Weapon",
	[59] = "Tank Grenade",
	[63] = "Blown"
}
local murderID = 0
local bodiesToCreate = {}
isPositionInWaterV = false
function isPositionInWater(send, x, y, z, player, isInWater)
    if send then
        triggerClientEvent (player, "GTIjournalist.isPositionInWaterC", player, x, y, z )
	else
        isPositionInWaterV = isInWater
	end
end
addEvent("GTIjournalist.isPositionInWater", true)
addEventHandler("GTIjournalist.isPositionInWater", root, isPositionInWater)
function makeNewDeadBody(totalAmmo, killer, killerWeapon, bodyPart, stealth)
    if getElementInterior(source) ~= 0 or getElementDimension(source) ~= 0 then
	    return false
	end
	if isElementInWater(source) then
	    return false
	end
    if exports.GTIemployment:getPlayerJob(source, false) == "Journalist" then
	    return false
	end
	if isElement(killer) and getElementType(killer) == "player" then
	    if (exports.GTIgangTerritories:isSWAT(killer) or exports.GTIgangTerritories:isSWAT(source)) or (exports.GTIgangTerritories:isGangster(killer) or exports.GTIgangTerritories:isGangster(source)) or exports.GTIemployment:getPlayerJob(killer, false) == "Journalist" then 
		    return false
		end
	end
	local x, y, z = getElementPosition(source)
	isPositionInWater(true, x, y, z, source)
	local source = source
	setTimer(function(totalAmmo, killer, killerWeapon, bodyPart, stealth)
	    if isPositionInWaterV then
		    return false
		end
		local rotation = getPlayerRotation(source)
		murderID = murderID + 1
		if not killerWeapon then
	    	killerWeapon = "None"
		end
		for id, journalist in ipairs(getElementsByType("player")) do
			if exports.GTIemployment:getPlayerJob(journalist, true) == "Journalist" then 
		        if deathReasons[killerWeapon] == "Ranover" and source ~= killer then
	 	           if isElement(killer) then
				        if getElementType(killer) == "vehicle" and getVehicleController(killer) then
					        killer = getVehicleController(killer)
						    triggerClientEvent(journalist, "GTIjournalist.createNewDeadBody", source, murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), getPlayerName(killer), false, bodyPart)----<<<<<----
					        warnJournalist(journalist, "(RADIO) Dispatch: A crime occurred at "..getZoneName (x, y, z, false).." ("..getZoneName (x, y, z, true).."). Please respond to the location and collect info.")
						elseif getElementType(killer) == "player" then
		        	        triggerClientEvent(journalist, "GTIjournalist.createNewDeadBody", source, murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), getPlayerName(killer), false, bodyPart)----<<<<<----
				 	        warnJournalist(journalist, "(RADIO) Dispatch: A crime occurred at "..getZoneName (x, y, z, false).." ("..getZoneName (x, y, z, true).."). Please respond to the location and collect info.")
						elseif getElementType(killer) == "vehicle" and not getVehicleController(killer) then
							triggerClientEvent(journalist, "GTIjournalist.createNewDeadBody", source, murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), false, false, bodyPart)
	        	           	warnJournalist(journalist, "(RADIO) Dispatch: A crime occurred at "..getZoneName (x, y, z, false).." ("..getZoneName (x, y, z, true).."). Please respond to the location and collect info.")
						end      
			    	else
				    	if source ~= killer then
			            	killer = false
					    	triggerClientEvent(journalist, "GTIjournalist.createNewDeadBody", source, murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), killer, false, bodyPart)
	                    	warnJournalist(journalist, "(RADIO) Dispatch: A crime occurred at "..getZoneName (x, y, z, false).." ("..getZoneName (x, y, z, true).."). Please respond to the location and collect info.")
				    	end
					end
		    	else
					if killer and killer ~= source then
						triggerClientEvent(journalist, "GTIjournalist.createNewDeadBody", source, murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), getPlayerName(killer), killerWeapon, bodyPart)----<<<<<----
			        	warnJournalist(journalist, "(RADIO) Dispatch: A crime occurred at "..getZoneName (x, y, z, false).." ("..getZoneName (x, y, z, true).."). Please respond to the location and collect info.")
					else
				    	triggerClientEvent(journalist, "GTIjournalist.createNewDeadBody", source, murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), getPlayerName(source), killerWeapon, bodyPart)
						warnJournalist(journalist, "(RADIO) Dispatch: A suicide occurred at "..getZoneName (x, y, z, false).." ("..getZoneName (x, y, z, true).."). Please respond to the location and collect info.")
					end
		    	end
			end
		end
		if deathReasons[killerWeapon] == "Ranover" then
	    	if isElement(killer) then
		    	table.insert(bodiesToCreate, {murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), getPlayerName(killer), false, bodyPart})   
	    	else
		    	table.insert(bodiesToCreate, {murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), false, false, bodyPart}) 
			end
		elseif isElement(killer) then
	    	table.insert(bodiesToCreate, {murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), getPlayerName(killer), killerWeapon, bodyPart})
		else
	    	table.insert(bodiesToCreate, {murderID, getElementModel(source), {x, y, z}, rotation, getPlayerName(source), getPlayerName(source), false, bodyPart})
		end
		setTimer(destroyPed, 600000, 1, murderID)
	end, 1000, 1, totalAmmo, killer, killerWeapon, bodyPart, stealth)
end
--addEvent("GTIjournalist.testJob", true)
--addEventHandler("GTIjournalist.testJob", root, makeNewDeadBody)
addEventHandler ( "onPlayerWasted", getRootElement(), makeNewDeadBody )
function warnJournalist(journalist, warnText)
    exports.GTIhud:dm(warnText, journalist, 255, 0, 0)
end
function destroyPed(id)
    for k, journalist in ipairs(getElementsByType("player")) do
	    if exports.GTIemployment:getPlayerJob(journalist, true) == "Journalist" then 
		    triggerClientEvent(journalist, "GTIjournalist.removePed", journalist, id)
		end
	end
	for k, tables in pairs (bodiesToCreate) do
	    if tables[1] == id then
	        table.remove(bodiesToCreate, k)
		end
	end
end
addEvent("GTIjournalist.destroyPed", true)
addEventHandler("GTIjournalist.destroyPed", root, destroyPed)
function createRecentBodies(jobName)
    if jobName == "Journalist" then
        for i=1, #bodiesToCreate do
	        triggerClientEvent(source, "GTIjournalist.createNewDeadBody", source, bodiesToCreate[i][1], bodiesToCreate[i][2], bodiesToCreate[i][3], bodiesToCreate[i][4], bodiesToCreate[i][5], bodiesToCreate[i][6], bodiesToCreate[i][7], bodiesToCreate[i][8])
        end
	end
end
addEventHandler("onPlayerGetJob", root, createRecentBodies)
function rewardOnFinishReport(extrabonus)
    local payOffset = exports.GTIemployment:getPlayerJobPayment(client, "Journalist")
	local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
	local hrExp = exports.GTIemployment:getHourlyExperience()
	local pay = math.ceil(400*payOffset)
    local Exp = math.ceil((pay/hrPay)*hrExp)
	if extrabonus then
		exports.GTIemployment:givePlayerJobMoney(client, "Journalist", pay+100)
		exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp+100, "Journalist")
	else
		exports.GTIemployment:givePlayerJobMoney(client, "Journalist", pay)
		exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Journalist")
	end
	exports.GTIemployment:modifyPlayerJobProgress(client, "Journalist", 1)
end
addEvent("GTIjournalist.rewardOnFinishReport", true)
addEventHandler("GTIjournalist.rewardOnFinishReport", root, rewardOnFinishReport)
