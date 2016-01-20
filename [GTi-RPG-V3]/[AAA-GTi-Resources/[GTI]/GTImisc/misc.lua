----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 06 Jun 2014
-- Resource: GTImisc/misc.lua
-- Version: 1.0
----------------------------------------->>

-- Show Cursor
--------------->>

function toggleCursor()
	if (isCursorShowing()) then
		showCursor(false)
	else
		showCursor(true)
	end
end

addEventHandler("onClientResourceStart", resourceRoot, function()
	bindKey("x", "up", toggleCursor)
end)

-- Disable Speed Blur
---------------------->>

addEventHandler("onClientResourceStart", resourceRoot, function()
	setBlurLevel(0)
end)

-- Move Player Head
-------------------->>

local move_head

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		local setting = exports.GTIsettings:getSetting("move_head")
		if ( setting == "Yes" ) then
			move_head = true
		end
	end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
function ()
	local setting = exports.GTIsettings:getSetting("move_head")
	if setting == "Yes" then
		move_head = true
	else
		move_head = false
	end
end)

function movePlayerHead()
	--local setting = exports.GTIsettings:getSetting("move_head")
	--if setting == "No" then return end
	--if setting == "Yes" then
	if ( move_head ) then
		if (getElementHealth(localPlayer) > 1) then
			local w, h = guiGetScreenSize()
			local lookatX, lookatY, lookatZ = getWorldFromScreenPosition(w/2, h/2, 10)
			setPedLookAt(localPlayer, lookatX, lookatY, lookatZ)
		end
	end
end
addEventHandler("onClientRender", root, movePlayerHead)

-- Set Time by a command
-------------------->>
function setTimes (_, hour, minute)
    if ( hour and tonumber(hour) ) then
	local hours = math.ceil(hour)
        if not ( tonumber(hours) <= 23 ) or ( tonumber(hours) < 0 ) then return end
		if ( minute ) then
			local minutes = math.ceil(minute)
			if not ( tonumber(minutes) <= 59 ) or ( tonumber(minutes) < 0 ) then return end
			setTime( hours, minutes )
			exports.GTIhud:dm("#FF0000* Time set to #FFFFFF"..hours.." : "..minutes, 0, 255, 0)
		else
			setTime( hours, 00 )
			exports.GTIhud:dm("#FF0000* Time set to #FFFFFF"..hours..":00", 0, 255, 0)
		end
    end
end
addCommandHandler("settime", setTimes)

-- Set Draw Distance
-------------------->>

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		local setting = exports.GTIsettings:getSetting("draw_distance")
		if ( tonumber(setting) ) then
			setFarClipDistance(setting)
		end
	end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
function ()
	local setting = exports.GTIsettings:getSetting("draw_distance")
	if ( tonumber(setting) ) then
		setFarClipDistance(setting)
	end
end
)

-- Projectiles Exploit
-------------------->>

local projectiles = {}

addEventHandler("onClientProjectileCreation", root,
	function (creator)
		if ( creator ~= localPlayer ) then return end
		projectiles[#projectiles+1] = source
	end
)

local satchel_removal = function () for _, proj in ipairs (projectiles) do setElementPosition(proj, 9999, 9999, 9999) destroyElement(proj) end projectiles = {} end
addEventHandler("onClientPlayerQuitJob", root, satchel_removal)
addEventHandler("onClientPlayerGetJob", root, satchel_removal)
