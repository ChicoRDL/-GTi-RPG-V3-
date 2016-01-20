function onPlayerWeaponSwitch(_,current)
	if current == 26 then
	toggleControl(source,"sprint",false)
	else
	toggleControl(source,"sprint",true)
	end
end
addEventHandler("onPlayerWeaponSwitch",root,onPlayerWeaponSwitch)