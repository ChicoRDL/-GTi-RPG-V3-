
function reloadWeapon()
		-- Prevent Useless Reload
	local ammo = getPedAmmoInClip(localPlayer)
	local weapon = getPedWeapon(localPlayer)
	local clip = getWeaponProperty(weapon, "std", "maximum_clip_ammo")
	if (ammo == clip) then return end
		-- Check if Player is not on ground
	local task = getPedSimplestTask(localPlayer)
	if ((task == "TASK_SIMPLE_JUMP" or task == "TASK_SIMPLE_IN_AIR" or task == "TASK_SIMPLE_LAND" or task == "TASK_SIMPLE_CLIMB")
		and not doesPedHaveJetPack(localPlayer)) then toggleControl("jump", true) return end
		-- Stop Render Spam
	for i,v in ipairs(getEventHandlers("onClientRender", root)) do
		if (v == enableJump) then return end
	end
		-- Disable Jump By Default
	toggleControl("jump", false)		
	addEventHandler("onClientRender", root, enableJump)
		-- Reload the weapon
	triggerServerEvent("onPlayerReload", localPlayer)
end
bindKey("r", "down", reloadWeapon)
addCommandHandler("reload", reloadWeapon)

-- Disable jumping for at least 4 frames after pressing reload to prevent instant reload
local frames = 0
function enableJump()
	if (frames >= 3) then
		toggleControl("jump", true)
		removeEventHandler("onClientRender", root, enableJump)
		frames = 0
	else
		frames = frames + 1
	end
end