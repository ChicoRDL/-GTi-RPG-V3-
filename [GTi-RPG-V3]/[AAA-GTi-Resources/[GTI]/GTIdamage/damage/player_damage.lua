----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 20 Jan 2014
-- Resource: GTIdamage/playerDamage.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

-- Stealth Kills
----------------->>

addEventHandler("onClientPlayerStealthKill", localPlayer, function(target)
	cancelEvent()
end)

-- Exploit Blocking
-------------------->>
--[[
function blockExploit(attacker, attackerWeapon, bodypart, loss)
	local attackerType = false
	local aDim = false
	if ((isElement(attacker))) then
		attackerType = getElementType(attacker)
		aDim = getElementDimension(attacker)
	end

	-- Wall Exploit (In question)
	if ((attacker and attackerWeapon and ((attackerWeapon >= 22 and attackerWeapon <= 34) or attackerWeapon == 38) and attackerType == "player")) then
		local px, py, pz = getPedBonePosition(attacker, 8)
		local tx, ty, tz = getPedBonePosition(source, 8)

		--test
		local laX,laY,laZ = getPedBonePosition(source, 23)
		local raX,raY,raZ = getPedBonePosition(source, 33)

		if ((not isLineOfSightClear(px, py, pz, tx, ty, tz, true, false, false, true, false, false, false, attacker)) and (not isLineOfSightClear(px, py, pz, laX, laY, laZ, true, false, false, true, false, false, false, attacker)) and (not isLineOfSightClear(px, py, pz, raX, raY, raZ, true, false, false, true, false, false, false, attacker))) then
			if ((attacker == localPlayer)) then
				return
			elseif ((source == localPlayer)) then
				cancelEvent(true)
				return
			end
		end
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, blockExploit)
]]
-- GLOBAL: General Dmg Mods
---------------------------->>

addEventHandler("onClientPlayerDamage", root, 
	function(attacker, weapon, bodypart, loss)
		if ((attacker == source)) then return end
		--[[
		outputDebugString("attacker-type: "..(getElementType(attacker) or "false").."; attacker: "..
			(getPlayerName(attacker) or getVehicleName(attacker) or "false").."; weapon: "..(getWeaponNameFromID(weapon) or weapon or "false").."; bodypart: "..
				bodypart.."; loss: "..loss)
		--]]
			-- Damage for localPlayer -->>
		if ((source == localPlayer)) then

			-- Government Related Damage
			----------------------------->>

				-- Make Gov't Members Invincible
			if ((exports.GTIutil:isPlayerInTeam(source, "Government"))) then
				cancelEvent()
				return
			end

			-- Police Related Damage
			------------------------->>

				-- Make Arrested Players Invincible
			if ((getElementData(source, "arrested") and not getElementData(source, "surrendered"))) then
				cancelEvent()
				return
			end

			if ((getElementData(source, "surrendered") and attacker)) then
				cancelEvent()
				return
			end

				-- Make Tased Players Invincible
			if ((getElementData(source, "tased"))) then
				cancelEvent()
				return
			end

		end

			-- Damage Involving Player Attackers -->>
		if (attacker and isElement(attacker)) then
			if (getElementType(attacker) == "vehicle") then
				attacker = getVehicleOccupant(attacker)
			end
			if (not attacker or getElementType(attacker) ~= "player") then return end
			
			-- Group Friendly Fire
			----------------------->>

			local groupA = getElementData(attacker, "groupID")
			local groupB = getElementData(source, "groupID")
			local f_fire = getElementData(root, "group_friendlyFire")
			if ((groupA == groupB and f_fire[groupA] and attacker ~= source) and getElementDimension(source) ~= 802) then
				cancelEvent()
			return end

			-- Police Related Damage
			------------------------->>

			local teamName = getTeamName(getPlayerTeam(attacker))
			if ((teamName == "Law Enforcement" and not exports.GTIgangTerritories:canPlayerTurf(attacker))) then

				-- Stop Player Damage from Cop if (Player is Unwanted
				local wanted = getElementData(source, "wanted") or 0
				if ((wanted == 0)) then
					cancelEvent()
					return
				end
			end

			if ( getElementData(attacker, "job") == "Police Officer" and getElementData(attacker, "isWorking") ~= 1 ) then
				cancelEvent()
				return
			end
			
			-- Turfer Related Damage
			------------------------->>

				-- Make Turfers only able to harm turfers
			local turferA = exports.GTIgangTerritories:isGangster(attacker) or exports.GTIgangTerritories:isSWAT(attacker)
			local turferB = exports.GTIgangTerritories:isGangster(source) or exports.GTIgangTerritories:isSWAT(source)
			if (((turferA and not turferB) or (not turferA and turferB))) then
				cancelEvent()
				return
			end

			-- Miscellaneous Damage
			------------------------>>

			-- Disable Katana 1-Hit Kill
			if ((weapon == 8 and loss > 50)) then
				cancelEvent()
				return
			end

		end

			-- Damage Involving Vehicle Attackers -->>
		if ((attacker and isElement(attacker) and getElementType(attacker) == "vehicle")) then

			-- Police Driver
			----------------->>

			local attacker = getVehicleOccupant(attacker)
			if ((attacker and exports.GTIutil:isPlayerInTeam(attacker, "Law Enforcement"))) then
				if ((exports.GTIgangTerritories:isSWAT(attacker))) then return end

				local wanted = getElementData(source, "wanted") or 0
				if ((wanted == 0)) then
					cancelEvent()
					return
				end
			end

		end
	end
)
