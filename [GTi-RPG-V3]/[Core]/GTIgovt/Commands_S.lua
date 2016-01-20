----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 13 Jun 2014
-- Resource: GTIgovt/commands.slua
-- Version: 1.0
----------------------------------------->>

-- /freecam
------------>>

addCommandHandler("freecam", function(player)
	if (not exports.freecam:isPlayerFreecamEnabled(player)) then
		exports.freecam:setPlayerFreecamEnabled(player)
		setElementFrozen(player, true)
		toggleAllControls(player, false, true, false)
	else
		exports.freecam:setPlayerFreecamDisabled(player)
		setElementFrozen(player, false)
		toggleAllControls(player, true, true, false)
		setCameraTarget(player, player)
	end
end, true)

-- /gti
-------->>

addCommandHandler("gti", function(player, cmd, ...)
	local message = table.concat({...}, " ")
	repeat message = message:gsub("#%x%x%x%x%x%x", "") until not message:find("#%x%x%x%x%x%x")
	if (message:gsub("%s", "") == "") then return end
	outputGTIChat(message, player)
	
	if (not getResourceFromName("GTIirc") or getResourceState(getResourceFromName("GTIirc")) ~= "running") then return end
	exports.GTIirc:ircSay(exports.GTIirc:ircGetChannelFromName(GOVT_CHAN), "04(GTI) "..noHighlight(getPlayerName(player))..": "..message)
end, true)

-- /govt
--------->>

local DEV_SKIN = 70
local STAFF_SKIN = 217
local ARCH_SKIN = 153
local QCA_SKIN = 294

addCommandHandler("govt", function(player, cmd, skin)
	if (exports.GTIutil:isPlayerInTeam(player, "Government") and not skin) then return end
	if ( exports.GTIpoliceWanted:getPlayerWantedLevel(player) > 0  and not exports.GTIutil:isPlayerInACLGroup ( player, "Dev5") ) then 
		exports.GTIhud:dm("You cannot perform this action while wanted", player, 255, 0, 0)
		return 
	end
	local job_name, job_skin, clear_wanted

	while true do
			-- Issue Dev Rank
		if (isDeveloper(player)) then
			job_skin = DEV_SKIN
			clear_wanted = true
			if (exports.GTIutil:isPlayerInACLGroup(player, "Dev1")) then
				job_name = "Trial Developer"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Dev2")) then
				job_name = "Reserve Developer"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Dev3")) then
				job_name = "Developer"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Dev4")) then
				job_name = "Senior Developer"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Dev5")) then
				job_name = "Development Minister"
			end
		break end
			-- Server Director Exception
		if (getAccountName(getPlayerAccount(player)) == "DLmass" or getAccountName(getPlayerAccount(player)) == "Nathan") then
			job_skin = DEV_SKIN
			job_name = "Server Director"
		break end

			-- Issue Admin Rank
		if (isAdmin(player)) then
			job_skin = STAFF_SKIN
			clear_wanted = true
			if (exports.GTIutil:isPlayerInACLGroup(player, "Admin1")) then
				job_name = "Support Mod"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Admin2")) then
				job_name = "Junior Admin"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Admin3")) then
				job_name = "Regular Admin"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Admin4")) then
				job_name = "Senior Admin"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Admin5")) then
				job_name = "Admin Minister"
			end
		break end

			-- Issue QCA Rank
		if (exports.GTIutil:isPlayerInACLGroup(player, "QCA4", "QCA5")) then
			job_skin = QCA_SKIN
			clear_wanted = true
			if (exports.GTIutil:isPlayerInACLGroup(player, "QCA4")) then
				job_name = "QCA Deputy Director"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "QCA5")) then
				job_name = "QCA Director"
			end
		break end

			-- Issue Architect Rank
		if (isArchitect(player)) then
			job_skin = ARCH_SKIN
			clear_wanted = true
			if (exports.GTIutil:isPlayerInACLGroup(player, "Arch4")) then
				job_name = "Architect Secretary"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Arch5")) then
				job_name = "Architecture Minister"
			end
		break end

			-- Issue Event Manager Rank
		if (exports.GTIutil:isPlayerInACLGroup(player, "Event", "Event1")) then
			clear_wanted = true
			if (exports.GTIutil:isPlayerInACLGroup(player, "Event")) then
				job_name = "Event Manager"
			elseif (exports.GTIutil:isPlayerInACLGroup(player, "Event1")) then
				job_name = "Event Minister"
			end
		break end
	break end

	if (not job_name) then return end

	if (exports.GTIprison:isPlayerInJail(player)) then
		exports.GTIhud:dm("You can't use /govt while in jail.", player, 255, 25, 25)
	return end

	exports.GTIemployment:setPlayerJob(player, job_name, "Government", nil, tonumber(skin) or job_skin)
	if (clear_wanted) then
		exports.GTIpoliceWanted:clearPlayerWantedLevel(player)
	end
end)

-- /jetpack
------------>>

addCommandHandler("jetpack", function(player, cmd)
	if (getServerPort() ~= 22003) then return end
		if ( getTeamName(getPlayerTeam(player)) == "Government" or exports.GTIutil:isPlayerInACLGroup (player, "Admin5", "Dev5") ) then 
			if (isPedInVehicle(player) or isPedDead(player)) then return end
			local value = not doesPedHaveJetPack(player)
			if (value) then
				givePedJetPack(player)
			else
				removePedJetPack(player)
			end
		else
			exports.GTIhud:dm("You must be in the Government team to use the jetpack.", player, 255, 0, 0)
		end	
end, true)

function removeJetpackOnJobQuit ()
	if ( doesPedHaveJetPack(source) ) then
		removePedJetPack(source)
	end
end
addEventHandler("onPlayerQuitJob", root, removeJetpackOnJobQuit)

-- /map-restart
-------------->>

addCommandHandler("map-restart", function(player, cmd, res_name)
	if (not res_name) then
		outputChatBox("map-restart: Syntax: /map-restart GTImapName", player)
		return
	end

	if (not string.find(string.lower(res_name), "map")) then
		outputChatBox("map-restart: Map '"..res_name.."' is not a map.", player)
		return
	end

	local resource = getResourceFromName(res_name)
	if (not resource) then
		outputChatBox("map-restart: Map '"..res_name.."' not found.", player)
		return
	end

	if (getResourceState(resource) == "loaded") then
		outputChatBox("map-restart: Map '"..res_name.."' is not running.", player)
		return
	end

	local start = restartResource(resource)
	if (start) then
		outputChatBox("map-restart: Map '"..res_name.."' restarted.", player)
	else
		outputChatBox("map-restart: Map '"..res_name.."' failed to restart.", player)
	end
end, true)

-- /map-start
-------------->>

addCommandHandler("map-start", function(player, cmd, res_name)
	if (not res_name) then
		outputChatBox("map-start: Syntax: /map-start GTImapName", player)
		return
	end

	if (not string.find(string.lower(res_name), "map")) then
		outputChatBox("map-start: Map '"..res_name.."' is not a map.", player)
		return
	end

	local resource = getResourceFromName(res_name)
	if (not resource) then
		outputChatBox("map-start: Map '"..res_name.."' not found.", player)
		return
	end

	if (getResourceState(resource) == "running") then
		outputChatBox("map-start: Map '"..res_name.."' is already running.", player)
		return
	end

	local start = startResource(resource)
	if (start) then
		outputChatBox("map-start: Map '"..res_name.."' started.", player)
	else
		outputChatBox("map-start: Map '"..res_name.."' failed to start.", player)
	end
end, true)

-- /map-stop
-------------->>

addCommandHandler("map-stop", function(player, cmd, res_name)
	if (not res_name) then
		outputChatBox("map-stop: Syntax: /map-stop GTImapName", player)
		return
	end

	if (not string.find(string.lower(res_name), "map")) then
		outputChatBox("map-stop: Map '"..res_name.."' is not a map.", player)
		return
	end

	local resource = getResourceFromName(res_name)
	if (not resource) then
		outputChatBox("map-stop: Map '"..res_name.."' not found.", player)
		return
	end

	if (getResourceState(resource) == "loaded") then
		outputChatBox("map-stop: Map '"..res_name.."' is not running.", player)
		return
	end

	local start = stopResource(resource)
	if (start) then
		outputChatBox("map-stop: Map '"..res_name.."' stopped.", player)
	else
		outputChatBox("map-stop: Map '"..res_name.."' failed to stop.", player)
	end
end, true)

-- /map-stats
-------------->>

addCommandHandler("map-stats", function(player, cmd, res_name)
	if (not res_name) then
		outputChatBox("map-stats: Syntax: /map-stats GTImapName", player)
		return
	end

	local resource = getResourceFromName(res_name)
	if (not resource) then
		outputChatBox("map-stats: Map '"..res_name.."' not found.", player)
		return
	end

	if (getResourceState(resource) == "loaded") then
		outputChatBox("map-stats: Map '"..res_name.."' is not running.", player)
		return
	end

	local objects = #getElementsByType("object", getResourceRootElement(resource))
	triggerClientEvent(player, "GTIgovt.mapStatsCmd", getResourceRootElement(resource), res_name, objects)

	local peds = #getElementsByType("ped", getResourceRootElement(resource))
	if (peds > 0) then
		outputChatBox("* "..res_name.." contains "..peds.." peds.", player)
	end

	local pickups = #getElementsByType("pickup", getResourceRootElement(resource))
	if (pickups > 0) then
		outputChatBox("* "..res_name.." contains "..pickups.." pickups.", player)
	end

	local markers = #getElementsByType("marker", getResourceRootElement(resource))
	if (markers > 0) then
		outputChatBox("* "..res_name.." contains "..markers.." markers.", player)
	end

	local colshapes = #getElementsByType("colshape", getResourceRootElement(resource))
	if (colshapes > 0) then
		outputChatBox("* "..res_name.." contains "..colshapes.." colshapes.", player)
	end
end, true)

-- /qca
-------->>

addCommandHandler("qca", function(player, cmd, ...)
	if (not isAdmin(player)) then return end
	local message = table.concat({...}, " ")
	repeat message = message:gsub("#%x%x%x%x%x%x", "") until not message:find("#%x%x%x%x%x%x")
	if (message:gsub("%s", "") == "") then return end
	outputQCAChat(message, player)
end, true)

-- /resign
----------->>

addCommandHandler("resign", function(player, cmd)
	if (not exports.GTIutil:isPlayerInTeam(player, "Government")) then return end
	exports.GTIemployment:resign(player)
end)

-- /switchserver
----------------->>

-- local MAIN_PORT = 22003
-- local DEV_PORT = 22020

-- addCommandHandler("switchserver", function(player)
	-- if (getServerPort() == MAIN_PORT) then
		-- redirectPlayer(player, "", DEV_PORT)
	-- else
		-- redirectPlayer(player, "", MAIN_PORT)
	-- end
-- end, true)
