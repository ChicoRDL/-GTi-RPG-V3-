----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 05 Jul 2014
-- Resource: GTIdamage/veh_damage.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- General Vehicle Damage
-------------------------->>

addEventHandler("onClientVehicleDamage", root,
	function(attacker, weapon, loss, x, y, z, tire)

		-- Vehicle Damage from Attacker (Player) -->>

		if (isElement(attacker) and getElementType(attacker) == "player" and weapon) then

			-- Turfer Related Damage
			------------------------->>

				-- Make Turfers only able to harm turfers
			local turferA = exports.GTIgangTerritories:canPlayerTurf(attacker)
			if (turferA) then
				for seat,player in pairs(getVehicleOccupants(source)) do
					if (exports.GTIgangTerritories:canPlayerTurf(player)) then return end
				end
				cancelEvent()
			end
		end
	end
)

-- GLOBAL: Vehicle Bullet Resistance
-------------------------------------->>

local light_arms 	= {[22] = true, [28] = true, [32] = true}							-- Pistol, Uzi, Tec-9
local mid_arms 		= {[24] = true, [25] = true, [26] = true, [27] = true, [29] = true}	-- Deagle, Shotguns, MP5
local heavy_arms 	= {[30] = true, [31] = true, [33] = true, [34] = true, [38] = true}	-- Assault Rifles, Rifles, Minigun
local explosives 	= {[35] = true, [36] = true, [16] = true, [39] = true}				-- Explosives

local bulletproof = {
	--[id] = {heavy_resistance, explosive_resistance, type_resistance (0=none, 1=light, 2=mid)},
	[428] = {0.4, 0.2, 0},	-- Securicar
	[528] = {0.4, 0.2, 0},	-- FBI Truck
	[427] = {0.5, 0.25, 1},	-- Enforcer
	[601] = {0.6, 0.4, 2},	-- S.W.A.T.
}

addEventHandler("onClientVehicleDamage", root, 
	function(attacker, weapon, loss, x, y, z, tire)
		if (not bulletproof[getElementModel(source)]) then return end
		if (not isElement(attacker) or getElementType(attacker) ~= "player") then return end
		if (exports.GTIgangTerritories:isSWAT(attacker) or exports.GTIgangTerritories:isGangster(attacker)) then return end
		if (exports.GTIsafezones:isElementWithinSafezone(source)) then return end
		if (wasEventCancelled()) then return end
		
		-- Light, Med Arms Bulletproof
		if (loss > 0 and light_arms[weapon] or mid_arms[weapon]) then
			setElementHealth(source, getElementHealth(source)+loss)
			return
		end
		
		-- Heavy Arms Bullet Resistance
		if (loss > 0 and heavy_arms[weapon]) then
			local loss = loss * bulletproof[getElementModel(source)][1]
			setElementHealth(source, getElementHealth(source)+loss)
			return
		end
		
		-- Explosive Resistance
		if (loss > 0 and explosives[weapon]) then
			local loss = loss * bulletproof[getElementModel(source)][2]
			setElementHealth(source, getElementHealth(source)+loss)
			return
		end
		
		-- Tire Resistance
		local tire_ = bulletproof[getElementModel(source)][3]
		if (tire and tire_ > 0) then
			cancelEvent()
			setVehicleWheelStates(source, 0, 0, 0, 0)
		end
	end
)

-- GLOBAL: Link Bike/Player Damage
----------------------------------->>

addEventHandler("onClientVehicleDamage", root, 
	function(attacker, weapon, loss, x, y, z, tire)
		if (getVehicleType(source) ~= "Bike" and getVehicleType(source) ~= "BMX") then return end
		if (not isElement(attacker) or getElementType(attacker) ~= "player" or loss <= 0) then return end
		if (wasEventCancelled()) then return end
		if (getPedOccupiedVehicle(attacker) == source) then return end
		if (exports.GTIsafezones:isElementWithinSafezone(source)) then return end
		local loss = loss/10
		for seat,player in pairs(getVehicleOccupants(source)) do
			if (attacker == player) then return end
			local passed = true
			if (not exports.GTIsafezones:isElementWithinSafezone(player)) then passed = false end
			if ((exports.GTIgangTerritories:isGangster(player) or exports.GTIgangTerritories:isSWAT(player)) and 
				(not exports.GTIgangTerritories:isGangster(attacker) and not exports.GTIgangTerritories:isSWAT(attacker))) then passed = false end
				-- Damage Player based on Vehicle Loss
			if (passed) then
				local health = getElementHealth(player)
				if (health-loss <= 0) then
					if not triggered then
						triggerServerEvent("GTIdamage.killPed", resourceRoot, player, attacker, weapon)
						triggered = true
						setTimer ( function ( ) triggered = false end, 1500, 1 )
					end
				else
					setElementHealth(player, health-loss)
				end
			end
		end
	end
)

-- CNR: Drive-by Abuse Workaround
---------------------------------->>

addEventHandler("onClientVehicleDamage", root, 
	function(attacker, weapon, loss)
		if (not attacker or getElementType(attacker) ~= "player") then return end
		if (not exports.GTIpoliceArrest:canPlayerArrest(attacker) and (getElementData(attacker, "wanted") or 0) == 0) then return end
		if (getPedOccupiedVehicle(attacker) == source) then return end
		for seat,player in pairs(getVehicleOccupants(source)) do
			if (attacker == player) then return end
			if (exports.GTIpoliceArrest:canPlayerArrest(attacker) and (getElementData(player, "wanted") or 0) > 0) or 
				(exports.GTIpoliceArrest:canPlayerArrest(player) and (getElementData(attacker, "wanted") or 0) > 0) then
				if (isPedDoingGangDriveby(player)) then
					if (getPedArmor(player) > 0) then
						local ap = getPedArmor(player) - (loss/5)
						local ap = math.floor(ap)
						if (ap < 0) then ap = 0 end
						triggerServerEvent("GTIdamage.takeVehAP", resourceRoot, player, ap)
					else
						local hp = getElementHealth(player) - (loss/5)
						if (hp <= 0) then
							triggerServerEvent("GTIdamage.killPed", resourceRoot, player, attacker, weapon)
						else
							setElementHealth(player, hp)
						end
					end
				end
			end
		end
	end
)

-- TURFING: Damage Inside Vehicles
----------------------------------->>

addEventHandler("onClientVehicleDamage", root, 
	function(attacker, weapon, loss, x, y, z, tire)
		--if (getVehicleType(source) == "Bike" or getVehicleType(source) == "BMX") then return end
		if (not isElement(attacker) or getElementType(attacker) ~= "player" or loss <= 0) then return end
		if (getPedOccupiedVehicle(attacker) == source) then return end
		if (not exports.GTIgangTerritories:isGangster(attacker) and not exports.GTIgangTerritories:isSWAT(attacker)) then return end
		if (wasEventCancelled()) then return end
		if (exports.GTIsafezones:isElementWithinSafezone(source)) then return end
		local loss = loss/10
		for seat,player in pairs(getVehicleOccupants(source)) do
			if (exports.GTIgangTerritories:isGangster(player) or exports.GTIgangTerritories:isSWAT(player)) then
				if (getPedArmor(player) > 0) then
					local ap = getPedArmor(player) - (loss/10)
					local ap = math.floor(ap)
					if (ap < 0) then ap = 0 end
					triggerServerEvent("GTIdamage.takeVehAP", resourceRoot, player, ap)
				else	
					local hp = getElementHealth(player) - loss
					if (hp <= 0) then
						triggerServerEvent("GTIdamage.killPed", resourceRoot, player, attacker, weapon)
					else
						setElementHealth(player, hp)
					end
				end
			end
		end
	end
)

-- DAMAGE: Store Attacker to data
---------------------------------->>

addEventHandler("onClientVehicleDamage",root,
	function(attacker)
		if not attacker then return end
		local lAttacker = getElementData(source,"attacker")
		if lAttacker == attacker then return end
	
		triggerServerEvent("GTIdamage:onPlayerAttackedVehicle",attacker,source)
	end
)
