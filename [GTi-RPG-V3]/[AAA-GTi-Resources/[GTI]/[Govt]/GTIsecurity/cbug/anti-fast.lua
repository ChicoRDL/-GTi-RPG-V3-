weponblocker = {}

blocketime = { 
	[24]=570, 
}

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
	function()
		toggleControl("fire", true)
	end
)

addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),
	function()
		toggleControl("fire", true)
	end
)

addEventHandler("onClientPlayerWeaponFire",localPlayer, 
	function(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
		if(blocketime[weapon]) then
			weponblocker[weapon] = getTickCount()
			toggleControl("fire", false)
		end
	end
)

addEventHandler("onClientPlayerWeaponSwitch",localPlayer,
	function(prevSlot, newSlot)--                                
		local wpn = getPedWeapon(localPlayer, newSlot)
		if(weponblocker[wpn]) then
			if((getTickCount() - weponblocker[wpn]) < blocketime[wpn]) then
				toggleControl("fire", false)
			else
				if(not isControlEnabled("fire")) then toggleControl("fire", true) end
				weponblocker[wpn] = nil
			end
		else
			if(not isControlEnabled("fire")) then toggleControl("fire", true) end
		end		
	end
)


addEventHandler("onClientRender",getRootElement(),
	function()
		local wpn = getPedWeapon(localPlayer)
		if(weponblocker[wpn]) then
			if((getTickCount() - weponblocker[wpn]) > blocketime[wpn]) then
				if(not isControlEnabled("fire")) then toggleControl("fire", true) end
				weponblocker[wpn] = nil
			--else
				--dxDrawRectangle(0,700,100, 100, tocolor(155,0,0))
				--dxDrawRectangle(0,700,((getTickCount() - weponblocker[wpn])/blocketime[wpn])*100, 100, tocolor(255,0,0))
			end
		end
	end
)