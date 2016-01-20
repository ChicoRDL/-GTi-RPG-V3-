----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 06 Oct 2014
-- Resource: GTIdroid/animations.slua
-- Version: 1.0
----------------------------------------->>

local animTimer = {}
local phone = {}

-- Create GTIdroid
------------------->>

addEvent("GTIdroid.startAnimation", true)
addEventHandler("GTIdroid.startAnimation", root, function()
	if (exports.GTIpoliceArrest:isPlayerInPoliceCustody(client, true, true, true, true, false)) then return end
	if (exports.GTIspawn:isPlayerSuiciding(client)) then error("GTIdroid: startAnimation was called during suicide. Cancelling...") end
	if (getElementData(client, "GTIanims.setAnim") == true ) then return end
    setPedWeaponSlot(client, 0)
	phone[client] = createObject(330, 0, 0, 0, 0, 0, 0)
	exports.bone_attach:attachElementToBone(phone[client], client, 12, 0, -0.01, -0.02, -15, 270, -15)
	setElementDimension(phone[client], getElementDimension(client))
	setElementInterior(phone[client], getElementInterior(client))

	exports.GTIanims:setJobAnimation(client, "ped", "phone_in", 50, false, false, false, true)
	animTimer[client] = setTimer(function(player)
		if ( isElement(player) ) then
			setPedAnimationProgress(player, "phone_in", 0.8)
		end
	end, 600, 0, client)
end)

-- Remove GTIdroid
------------------->>

addEvent("GTIdroid.stopAnimation", true)
addEventHandler("GTIdroid.stopAnimation", root, function()
	if (exports.GTIpoliceArrest:isPlayerInPoliceCustody(client, true, true, true, true, false)) then return end
	if (exports.GTIspawn:isPlayerSuiciding(client)) then error("GTIdroid: stopAnimation was called during suicide. Cancelling...") end
	
	removePhone(client)
	exports.GTIanims:setJobAnimation(client, "ped", "phone_out", 50, false, false, false, false)
end)

addEventHandler("onPlayerQuit", root, function()
	removePhone(source)
end)

addEventHandler("onPlayerWasted", root, function()
	removePhone(source)
end)

addEvent("onPlayerArrested", true)
addEventHandler("onPlayerArrested", root, function()
	removePhone(source)
end)

function removePhone(player)
	if (phone[player]) then
		destroyElement(phone[player])
		phone[player] = nil
	end
	if (animTimer[player]) then
		killTimer(animTimer[player])
		animTimer[player] = nil
	end
	
	if (exports.GTIspawn:isPlayerSuiciding()) then
		error("removePhone called setPedAnimation during suicide.")
		return
	end
	
	setPedAnimation(player)
end
