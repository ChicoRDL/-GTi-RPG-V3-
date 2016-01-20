----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 20 Dec 2014
-- Resource: GTIweapons/restrictions.lua
-- Version: 1.0
----------------------------------------->>

local weapon_bans = {
	--{N, E, S, W},
	{-765, 3000, -2900, 45},	-- Los Santos
	{1665, -1210, -1115, -3000},	-- San Fierro
	--[[{3000, 3000, 500, 865},		-- Las Venturas--]]
}

local inColShape	-- is in No-DM zone?
local cols = {}

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i,v in ipairs(weapon_bans) do
		local n,e,s,w = unpack(v)
		local col = createColRectangle(w, s, e-w, n-s)
		table.insert(cols, col)
	end
end)

-- Restrict Grenades/Heavy Weapons
----------------------------------->>

addEventHandler("onClientColShapeHit", resourceRoot, function(player, dim)
	if (player ~= localPlayer or not dim) then return end
	inColShape = true
	local slot = getPedWeaponSlot(player)
	if (slot ~= 7 and slot ~= 8 and slot ~= 12) then return end
	setPedWeaponSlot(player, 0)
end)

addEventHandler("onClientColShapeLeave", resourceRoot, function(player, dim)
	if (player ~= localPlayer or not dim) then return end
	inColShape = nil
end)

function controlWeaponSwitch(player, last_slot, slot)
	if (slot ~= 7 and slot ~= 8) then return end
	local j,k,l
	if (last_slot < slot) then
		if (last_slot == 0 and (slot == 7 or slot == 8)) then
			j,k,l = 6,1,-1
		else
			j,k,l = 9,11,1
		end
	else
		j,k,l = 6,1,-1
	end
	
	if (slot == 7 or slot == 8) then
		for i=j,k,l do
			local weapon = getPedWeapon(player, i)
			local ammo = getPedTotalAmmo(player, i)
			if (weapon ~= 0 and ammo > 0) then
				setPedWeaponSlot(player, i)
				return
			end
		end
	end

	setPedWeaponSlot(player, 0)
	return
end

-- Control Weapon Switch, Interiors
------------------------------------>>

addEventHandler("onClientPlayerWeaponSwitch", localPlayer, function(last_slot, slot)
	if (slot ~= 7 and slot ~= 8) then return end
	
	for i,col in ipairs(cols) do
		if (isElementWithinColShape(source, col)) then
			inColShape = true
		end
	end
	
	if (getElementInterior(source) == 0 and not inColShape) then return end
	controlWeaponSwitch(source, last_slot, slot)
end)

function controlWeaponSwitchOnIntEnter(player)
	if (getElementInterior(player) == 0) then return end
	local slot = getPedWeaponSlot(player)
	if (slot ~= 7 and slot ~= 8) then return end
	setPedWeaponSlot(player, 0)
end
addEvent("onClientInteriorEnter", true)
addEventHandler("onClientInteriorEnter", root, controlWeaponSwitchOnIntEnter)
addEvent("onClientInteriorExit", true)
addEventHandler("onClientInteriorExit", root, controlWeaponSwitchOnIntEnter)
