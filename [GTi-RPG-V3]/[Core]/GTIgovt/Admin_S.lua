----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 20 Aug 2014
-- Resource: GTIgovt/admin.slua
-- Version: 1.0
----------------------------------------->>

local Admins = {}
local QCAs = {}

	-- Shouts -->>
local displayTimer				-- Text Display Timer
local DISPLAY_TIME	= 10000		-- Text Display Time
local publicPunishments = true
local spectators = {}	-- Spectator Admins by Target

local vehicles = {}			-- Vehicles by Vehicle Owner
local vehicle_owner = {}	-- Vehicle Owners by Vehicle
local des_timers = {}		-- Vehicle Idle Destroy Timers

local VEH_IDLE_TIME = 3		-- Vehicle Unoccupied Time (Mins)

-- Admin Chats
--------------->>

function outputAdminNotice(text, irc)
	--for i,player in ipairs(Admins) do
	--	outputChatBox("* (ADMIN) "..text, player, 255, 0, 125)
	--end
	outputChatBox("* (ADMIN) "..text, root, 255, 0, 125)
	exports.GTIlogs:outputServerLog("* (ADMIN) "..text, "admin")
	exports.GTIirc:ircSay(exports.GTIirc:ircGetChannelFromName(GOVT_CHAN), "13(ADMIN) "..text)
	return true
end

function outputGTIChat(text, player)
	for i,plr in ipairs(Admins) do
		outputChatBox("(GTI) "..getPlayerName(player)..": #FFFFFF"..text, plr, 255, 0, 125, true)
	end
	exports.GTIlogs:outputServerLog("(GTI) "..getPlayerName(player)..": "..text, "admin", player)
	return true
end

function outputQCAChat(text, player)
	for i,plr in ipairs(QCAs) do
		outputChatBox("(QCA) "..getPlayerName(player)..": #FFFFFF"..text, plr, 30, 90, 0, true)
	end
	exports.GTIlogs:outputServerLog("(QCA) "..getPlayerName(player)..": "..text, "admin", player)
	return true
end

-- Admin Players
----------------->>

function isAdmin(player)
	if (not isElement(player)) then return false end
	if (exports.GTIutil:isPlayerInACLGroup(player, "Admin1", "Admin2", "Admin3", "Admin4", "Admin5")) then return true end
	return false
end

function isDeveloper(player)
	if (not isElement(player)) then return false end
	if (exports.GTIutil:isPlayerInACLGroup(player, "Dev1", "Dev2", "Dev3", "Dev4", "Dev5")) then return true end
	return false
end

function isArchitect(player)
	if (not isElement(player)) then return false end
	if (exports.GTIutil:isPlayerInACLGroup(player, "Arch1", "Arch4", "Arch5")) then return true end
	return false
end

function isQCA(player)
	if (not isElement(player)) then return false end
	if (exports.GTIutil:isPlayerInACLGroup(player, "QCA1", "QCA4", "QCA5")) then return true end
	if (isDeveloper(player)) then return true end
	return false
end

-- Admin Functions
------------------->>

function executeAdminFunction(player, admin, fnct, value, ...)
	if (not isElement(player) or not isElement(admin)) then return false end
	if (not exports.GTIutil:isPlayerLoggedIn(player)) then 
		exports.GTIhud:dm("ADMIN: Cannot execute admin function. Player is not logged in.", admin, 255, 25, 25)
	return end
	if (not fnct) then return false end

	local player_text
	local admin_text
	local text_tag

	if (fnct == "slap") then
		setElementHealth(player, getElementHealth(player) - value)
		local x,y,z = getElementVelocity(player)
		setElementVelocity(player, x, y, z + 0.2)

		player_text = "ADMIN: You have been slapped by "..getPlayerName(admin).." ("..value.." HP)"
		admin_text = getPlayerName(player).." has been slapped by "..getPlayerName(admin).." ("..value.." HP)"
		for_admin = "ADMIN: You have slapped "..getPlayerName(admin).." ("..value.." HP)"
		text_tag = "SLAP"

	elseif (fnct == "freeze") then
		if (isPedInVehicle(player)) then
			setElementFrozen(getPedOccupiedVehicle(player), value)
		end
		setElementFrozen(player, value)
		toggleAllControls(player, not value)

		player_text = "ADMIN: You have been "..(value and "frozen" or "unfrozen").." by "..getPlayerName(admin)
		admin_text = getPlayerName(player).." been "..(value and "frozen" or "unfrozen").." by "..getPlayerName(admin)
		for_admin = "ADMIN: You have "..(value and "frozen" or "unfrozen").." "..getPlayerName(player)
		text_tag = "FREEZE"

	elseif (fnct == "reconnect") then
		admin_text = getPlayerName(player).." has been forced to reconnect by "..getAdminName(admin)
		for_admin = "ADMIN: You have forced to reconnect "..getPlayerName(player)
		outputChatBox("* (ADMIN) "..admin_text, root, 255, 0, 125)
		text_tag = "RECONNECT"
		redirectPlayer(player, "", 0)

	elseif (fnct == "rename") then
		local cur_value = getPlayerName(player)
		setPlayerName(player, value)

		player_text = "ADMIN: Your name has been changed to "..value.." by "..getAdminName(admin)
		admin_text = cur_value.."'s name has been changed to "..value.." by "..getAdminName(admin)
		for_admin = "ADMIN: You have changed "..getPlayerName(player).."'s name to "..value
		text_tag = "RENAME"

	elseif (fnct == "shout") then
		local textDisplay = textCreateDisplay()
		textDisplayAddText(textDisplay,
			textCreateTextItem("(ADMIN) "..getAdminName(admin)..":\n"..value, 0.5, 0.5, "medium", 255, 25, 25, 255, 3, "center", "center", 200)
		)
		textDisplayAddObserver(textDisplay, player)

		if (isTimer(displayTimer)) then killTimer(displayTimer) end
		displayTimer = setTimer(textDestroyDisplay, DISPLAY_TIME, 1, textDisplay)

		admin_text = getAdminName(admin).." shouted to "..getPlayerName(player)..": "..value
		for_admin = "ADMIN: You have shouted " ..value.. " to " ..getPlayerName(player)
		text_tag = "SHOUT"

	elseif (fnct == "set_health") then
		setElementHealth(player, value)

		player_text = "ADMIN: Your health has been set to "..value.."% by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." set "..getPlayerName(player).."'s health to "..value.."%"
		for_admin = "ADMIN: You have changed "..getPlayerName(player).."'s health to "..value.. "%"
		text_tag = "HEALTH"

	elseif (fnct == "set_armor") then
		setPedArmor(player, value)

		player_text = "ADMIN: Your armor has been set to "..value.."% by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." set "..getPlayerName(player).."'s armor to "..value.."%"
		for_admin = "ADMIN: You have changed "..getPlayerName(player).."'s armor to "..value.. "%"
		text_tag = "ARMOR"

	elseif (fnct == "set_skin") then
		local cur_value = getElementModel(player)
		setElementModel(player, value)

		player_text = "ADMIN: Your skin ID has been changed from "..cur_value.." to "..value.." by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." changed "..getPlayerName(player).."'s skin ID from "..cur_value.." to "..value
		for_admin = "ADMIN: You have changed "..getPlayerName(player).."'s skin ID from "..cur_value.." to "..value
		text_tag = "SKIN"

	elseif (fnct == "set_money") then
		local cur_value = getPlayerMoney(player)
		setPlayerMoney(player, value)

		player_text = "ADMIN: Your money has been changed from $"..cur_value.." to $"..value.." by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." changed "..getPlayerName(player).."'s money from $"..cur_value.." to $"..value
		for_admin = "ADMIN: You have changed "..getPlayerName(player).."'s money from "..cur_value.." to "..value
		text_tag = "MONEY"

	elseif (fnct == "set_interior") then
		local cur_value = getElementInterior(player)
		setElementInterior(player, value)

		player_text = "ADMIN: Your interior has been changed from "..cur_value.." to "..value.." by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." changed "..getPlayerName(player).."'s interior from "..cur_value.." to "..value
		for_admin = "ADMIN: You have changed "..getPlayerName(player).."'s interior from "..cur_value.." to "..value
		text_tag = "INTERIOR"

	elseif (fnct == "set_dimension") then
		local cur_value = getElementDimension(player)
		setElementDimension(player, value)

		player_text = "ADMIN: Your dimension has been changed from "..cur_value.." to "..value.." by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." changed "..getPlayerName(player).."'s dimension from "..cur_value.." to "..value
		for_admin = "ADMIN: You have changed "..getPlayerName(player).."'s dimension from "..cur_value.." to "..value
		text_tag = "DIMENSION"

	elseif (fnct == "give_jetpack") then
		if (value) then
			givePedJetPack(player)
		else
			removePedJetPack(player)
		end

		player_text = "ADMIN: "..(value and "You have been given a jetpack" or "Your jetpack has been removed").." by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." "..(value and "gave a jetpack to" or "removed the jetpack of").." "..getPlayerName(player)
		for_admin = "ADMIN: You "..(value and "gave a jetpack to "..getPlayerName(player) or "took out "..getPlayerName(player).."'s jetpack")
		text_tag = "JETPACK"

	elseif (fnct == "give_weapon") then
		local args = {...}
		giveWeapon(player, value, args[1])

		player_text = "ADMIN: You have been given a "..getWeaponNameFromID(value).." ("..args[1].." ammo) by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." gave "..getPlayerName(player).." a "..getWeaponNameFromID(value).." ("..args[1].." ammo)"
		for_admin = "ADMIN: You gave a "..getWeaponNameFromID(value).." with "..args[1].." bullets to "..getPlayerName(player)
		text_tag = "WEAPON"

	elseif (fnct == "spawn_vehicle") then
		local model = getVehicleModelFromName(value)
		if (not model) then
			exports.GTIhud:dm("ADMIN: This vehicle model name does not exist. Enter a valid model.", admin, 255, 125, 25)
			return
		end
		local x,y,z = getElementPosition(player)
		local rx,ry,rz = getElementRotation(player)
		local vehicle = createVehicle(model, x, y, z, rx, ry, rz)

		warpPedIntoVehicle(player, vehicle)
		setElementData(vehicle, "fuel", 50)

		vehicles[player] = vehicle
		vehicle_owner[vehicle] = player

		player_text = "ADMIN: You have been given a "..value.." by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." gave "..getPlayerName(player).." a "..value
		for_admin = "ADMIN: You gave a "..getVehicleNameFromModel(model).. " to "..getPlayerName(player)
		text_tag = "VEHICLE"

	elseif (fnct == "repair_vehicle") then
		if (not isPedInVehicle(player)) then
			exports.GTIhud:dm("ADMIN: Cannot execute admin function. Player is not in a vehicle.", player, 255, 25, 25)
			return
		end

		local vehicle = getPedOccupiedVehicle(player)
		exports.GTIvehicles:repairVehicle(vehicle)

		player_text = "ADMIN: Your vehicle has been repaired by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." repaired "..getPlayerName(player).."'s "..getVehicleName(vehicle)
		for_admin = "ADMIN: You have fixed " ..getPlayerName(player).."'s vehicle"
		text_tag = "VEHICLE"

	elseif (fnct == "destroy_vehicle") then
		if (not isPedInVehicle(player)) then
			exports.GTIhud:dm("ADMIN: Cannot execute admin function. Player is not in a vehicle.", player, 255, 25, 25)
			return
		end

		local vehicle = getPedOccupiedVehicle(player)
		local cur_val = getVehicleName(vehicle)
		destroyElement(vehicle)

		player_text = "ADMIN: Your vehicle has been destroyed by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." destroyed "..getPlayerName(player).."'s "..cur_val
		for_admin = "ADMIN: You have destroyed " ..getPlayerName(player).."'s vehicle"
		text_tag = "VEHICLE"

	elseif (fnct == "blow_vehicle") then
		if (not isPedInVehicle(player)) then
			exports.GTIhud:dm("ADMIN: Cannot execute admin function. Player is not in a vehicle.", player, 255, 25, 25)
			return
		end

		local vehicle = getPedOccupiedVehicle(player)
		blowVehicle(vehicle)

		player_text = "ADMIN: Your vehicle has been blown by "..getPlayerName(admin)
		admin_text = getPlayerName(admin).." blew "..getPlayerName(player).."'s "..getVehicleName(vehicle)
		for_admin = "ADMIN: You have blown " ..getPlayerName(player).."'s vehicle"
		text_tag = "VEHICLE"

	end

	if (player_text) then
		outputChatBox(player_text, player, 255, 25, 25)
	end
	--outputAdminNotice(admin_text)
	if (for_admin) then
		outputChatBox(for_admin, admin, 255, 25, 25)
	end
	if ( text_tag and admin_text ) then 
		exports.GTIlogs:outputAdminLog(text_tag..": "..admin_text, admin)
	else
		return false
	end
	return true
end

-- Advanced Admin Functions
---------------------------->>

function warpPlayerTo(player, warpTo, admin)
	if (not isElement(player) or not isElement(warpTo)) then return false end
	if (not exports.GTIutil:isPlayerLoggedIn(player)) then 
		exports.GTIhud:dm("ADMIN: Cannot execute admin function. Player is not logged in.", admin, 255, 25, 25)
	return end
	if (player == warpTo) then
		exports.GTIhud:dm("Error: You cannot warp to yourself", player, 255, 25, 25)
		return
	end

	if (isPedInVehicle(player)) then
		removePedFromVehicle(player)
	end

	-- Warp Player Into Vehicle -->>

	if (isPedInVehicle(warpTo)) then
		local vehicle = getPedOccupiedVehicle(warpTo)
		for seat=1,getVehicleMaxPassengers(vehicle) do
			if (not getVehicleOccupant(vehicle, seat)) then
				setElementInterior(player, getElementInterior(warpTo))
				setElementDimension(player, getElementDimension(warpTo))
				warpPedIntoVehicle(player, vehicle, seat)

				if (not admin) then
					outputChatBox("ADMIN: You have warped into "..getPlayerName(warpTo).."'s "..getVehicleName(vehicle), player, 255, 25, 25)
					outputChatBox(getPlayerName(player).." has warped to you.", warpTo, 255, 25, 25)
					exports.GTIlogs:outputAdminLog("WARP: "..getPlayerName(player).." has warped into "..getPlayerName(warpTo).."'s "..getVehicleName(vehicle), player)
				else
					outputChatBox("ADMIN: You have been warped into "..getPlayerName(warpTo).."'s "..getVehicleName(vehicle).." by "..getPlayerName(admin), player, 255, 25, 25)
					outputChatBox(getPlayerName(player).." has warped to you.", warpTo, 255, 25, 25)
					exports.GTIlogs:outputAdminLog("WARP: "..getPlayerName(player).." has been warped into "..getPlayerName(warpTo).."'s "..getVehicleName(vehicle).." by "..getPlayerName(admin), admin)
				end
				return true
			end
		end
	end

	-- Warp Player Near Player -->>

	local x,y,z = getElementPosition(warpTo)
	local _,_,rot = getElementRotation(warpTo)
	local x,y = getPointFromDistanceRotation(x, y, 1, rot)
	setElementPosition(player, x, y, z+1)
	setElementRotation(player, 0, 0, rot)
	setElementInterior(player, getElementInterior(warpTo))
	setElementDimension(player, getElementDimension(warpTo))

	if (not admin) then
		outputChatBox("ADMIN: You have warped to "..getPlayerName(warpTo), player, 255, 25, 25)
		outputChatBox(getPlayerName(player).." has warped to you.", warpTo, 255, 25, 25)
		exports.GTIlogs:outputAdminLog("WARP: "..getPlayerName(player).." has warped to "..getPlayerName(warpTo), player)
	else
		outputChatBox("ADMIN: You have been warped to "..getPlayerName(warpTo).." by "..getPlayerName(admin), player, 255, 25, 25)
		outputChatBox(getPlayerName(player).." has warped to you.", warpTo, 255, 25, 25)
		exports.GTIlogs:outputAdminLog("WARP: "..getPlayerName(player).." has been warped to "..getPlayerName(warpTo).." by "..getPlayerName(admin), admin)
	end
	triggerClientEvent(player, "onClientAdminWarp", player, warpTo)
	return true
end

function spectatePlayer(admin, target)
	if (not isElement(admin)) then return false end
	if (isElement(target) and not exports.GTIutil:isPlayerLoggedIn(target)) then 
		exports.GTIhud:dm("ADMIN: Cannot execute admin function. Player is not logged in.", admin, 255, 25, 25)
	return end
	
	if (isElement(target)) then
		setElementFrozen(admin, true)
		setCameraTarget(admin, target)
		outputChatBox("ADMIN: You are now spectating "..getPlayerName(target)..", press 1 to stop spectating.", admin, 255, 25, 25)
		bindKey(admin, "1", "down", spectatePlayer, admin)
	else
		setCameraTarget(admin, admin)
		setElementFrozen(admin, false)
		outputChatBox("ADMIN: You are no longer spectating.", admin, 255, 25, 25)
		unbindKey(admin, "1", "down", spectatePlayer)
	end
end

addEventHandler("onPlayerQuit", root, function()
	if (spectators[player]) then
		spectatePlayer(spectators[player])
		spectators[player] = nil
	end
end)

addEventHandler("onPlayerQuit", root, 
	function()
		if ( getElementData ( source, "dim" ) ) then
			setElementDimension(source, getElementData(source, "dim") )
		end
	end
)


function updateCameraInterior ( )
	for index, value in ipairs ( getElementsByType ( "player" ) ) do
		if ( getCameraTarget ( value ) == source and value ~= source ) then
			outputChatBox("camera interior updated", value)
			setCameraInterior ( value, getElementInterior ( source ) )
			setElementDimension( value, getElementDimension ( source ) )
		end
	end
end
addEventHandler("onPlayerChangeInterior", root, updateCameraInterior)

-- Admin Vehicles
------------------>>

	-- Start Idle Respawn Timer -->>
addEventHandler("onVehicleExit", resourceRoot, function(player, seat, jacker)
	des_timers[source] = setTimer(function(source)
		if (not isElement(source)) then return end
		destroyElement(source)
	end, 60000*VEH_IDLE_TIME, 1, source)
end)

	-- Stop Idle Respawn Timer -->>
addEventHandler("onVehicleEnter", resourceRoot, function(player, seat, jacked)
	if (isTimer(des_timers[source])) then
		killTimer(des_timers[source])
		des_timers[source] = nil
	end
end)

	-- Vehicle Security -->>
--[[addEventHandler("onVehicleStartEnter", resourceRoot, function(player, seat, jacked)
	if (seat == 0 and vehicle_owner[source] ~= player) then
		cancelEvent()
		outputChatBox("This admin spawned vehicle is restricted to the player it was spawned for.", player, 255, 25, 25)
	end
end)--]]

	-- Destroy 10 seconds after blown
addEventHandler("onVehicleExplode", resourceRoot, function()
	des_timers[source] = setTimer(function(source)
		if (not isElement(source)) then return end
		destroyElement(source)
	end, 10000, 1, source)
end)

	-- Clear Memory on Destroy -->>
addEventHandler("onElementDestroy", resourceRoot, function()
	if (getElementType(source) ~= "vehicle") then return end

	if (isTimer(des_timers[source])) then
		killTimer(des_timers[source])
		des_timers[source] = nil
	end

	vehicles[vehicle_owner[source]] = nil
	vehicle_owner[source] = nil
end)

	-- Destroy Vehicle on Quit -->>
addEventHandler("onPlayerQuit", root, function()
	if (not vehicles[source]) then return end
	local vehicle = vehicles[source]
	destroyElement(vehicle)
end)

-- Utilities
------------->>

function getPointFromDistanceRotation(x, y, dist, angle)
    local a = math.rad(90 - angle)
    local dx = math.cos(a) * dist
    local dy = math.sin(a) * dist
    return x+dx, y+dy;
end

function getAdmins()
	return Admins
end

-- Update Admin Cache
---------------------->>

addEventHandler("onResourceStart", resourceRoot, function()
	for i,player in ipairs(getElementsByType("player")) do
		if (hasObjectPermissionTo(player, "command.qca", false)) then
			table.insert(QCAs, player)
		end
		if (hasObjectPermissionTo(player, "command.gti", false)) then
			table.insert(Admins, player)
		end
	end
end)

addEventHandler("onPlayerLogin", root, function()
	if (hasObjectPermissionTo(source, "command.gti", false)) then
		table.insert(Admins, source)
	end
	if (hasObjectPermissionTo(source, "command.qca", false)) then
		table.insert(QCAs, source)
	end
end)

addEventHandler("onPlayerQuit", root, function()
	for i,player in ipairs(Admins) do
		if (player == source) then
			table.remove(Admins, i)
			break
		end
	end
	for i,player in ipairs(QCAs) do
		if (player == source) then
			table.remove(QCAs, i)
			break
		end
	end
end)
