----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 11 Aug 2014
-- Resource: GTIhijack/hijack.lua
-- Version: 1.0
----------------------------------------->>

local PLR_DMG_OFFSET = 20

-- Hijack Player Damage
------------------------>>

addEventHandler("onClientVehicleDamage", resourceRoot, function(attacker, weapon, loss)
	if (not isElement(attacker) or getElementType(attacker) ~= "player") then return end
	if (not getElementData(source, "hijack")) then return end
	cancelEvent()
	local player = getVehicleOccupant(source)
	if (isElement(player)) then
		local health = getElementHealth(player) - (loss/PLR_DMG_OFFSET)
		if (health < 0) then
			triggerServerEvent("GTIhijack.killPed", resourceRoot, player, attacker, weapon)
		else
			setElementHealth(player, health)
		end
	end
end)
