----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Jack Johnson (Jack)
-- Date: 28/03/2015
-- Resource: GTIweapons/binds.lua
-- Version: 1.0
----------------------------------------->>

local cooldown

addEvent("WepBinds:onSettingsReceived",true)

function setupBinds(setting)
	for i=1,9 do
		bindKey(i,"down",switchWeapon,i)
	end
	
	--setElementData(localPlayer,"weapon-bind",setting or false)
end
addEventHandler("onClientResourceStart",resourceRoot,setupBinds)

function onSettingsReceived(setting)
	setElementData(localPlayer,"weapon-bind",setting or false)
end
addEventHandler("WepBinds:onSettingsReceived",root,onSettingsReceived)

function switchWeapon(_,_,slotID)
	if not slotID then return false end --Can't do nothing without a slot id
	if cooldown and isTimer(cooldown) then return false end
	if isPedDoingGangDriveby(localPlayer) then return end
	if not (isWeaponBindEnabled()) then return false end
	if (getPedTotalAmmo(localPlayer, slotID) == 0) then return false end
	
	setPedWeaponSlot(localPlayer,tonumber(slotID))
	cooldown = setTimer(function() cooldown = nil end, 1000, 1)
	return false
end

function isWeaponBindEnabled()
	return getElementData(localPlayer,"weapon-bind") or false
end

function toggleWeaponBind(_,state)
	if (state == "on") then
		triggerServerEvent("WepBinds:setWeaponBindsEnabled",localPlayer,true)
		setElementData(localPlayer,"weapon-bind",true)
		exports.GTIhud:dm("Weapon binds enabled.",0,255,0)
	elseif (state == "off") then
		triggerServerEvent("WepBinds:setWeaponBindsEnabled",localPlayer,false)
		setElementData(localPlayer,"weapon-bind",false)
		exports.GTIhud:dm("Weapon binds disabled.",255,0,0)
	else
		exports.GTIhud:dm("Syntax: /weaponbinds on/off",255,0,0)
		return
	end
end
addCommandHandler("weaponbinds",toggleWeaponBind)
