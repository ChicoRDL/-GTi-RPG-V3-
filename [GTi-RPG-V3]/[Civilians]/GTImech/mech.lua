----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 03 Jun 2013
-- Resource: GTImech/mech.lua
-- Version: 1.0
----------------------------------------->>

local DIAG_VISIBLE = 10			-- Visible Distance of Diagnosis

local veh_info = {}				-- Table of Vehicle Diagnosis Info
local veh_diag_text = ""		-- dxText
local veh_diag_text_nocol = ""	-- dxText No Color Codes
local mech_name = ""			-- Name of Mechanic that wants to repair your car
local repair_cost = ""			-- Repair Cost (for notice)
local mechanic					-- Mechanic that wants to fix your car
local accept					-- "Accept Repair" GUI Button
local deny						-- "Deny Repair" GUI Button
local rep_vehicle				-- The Vehicle that needs to be repaired
local enable_fire				-- Should fire be renabled?
local clicked
-- Diagnose Problems
--------------------->>

function diagnoseVehicle(button, state, sx, sy, wx, wy, wz, vehicle)
	if (button ~= "left" or state ~= "up") then return end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Mechanic") then return end
	if (not isElement(vehicle) or getElementType(vehicle) ~= "vehicle") then return end
	if (isPedInVehicle(localPlayer)) then return end
	if (clicked) then exports.GTIhud:dm("* You must wait a while before sending another request.", 255, 25, 25) return end
	
	local px, py, pz = getCameraMatrix()
	local tx, ty, tz = getElementPosition(vehicle)
	local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
	if (dist > DIAG_VISIBLE) then
		exports.GTIhud:dm("* You must be closer to the vehicle to preform a diagnostic on it.", 255, 25, 25)
		return
	end
	
	clicked = true
	setTimer(function() clicked = false end, 5000, 1)
	veh_info = {}
	triggerServerEvent("GTImech.sendDiagnosis", vehicle)
end
addEventHandler("onClientClick", root, diagnoseVehicle)

function processDiagnosis(info)
	veh_info = info
	veh_info["vehicle"] = source
	veh_info["engine"] = string.format("%.1f", veh_info["engine"])
	veh_info["body"] = string.format("%.1f", veh_info["body"])

	veh_diag_text = "Vehicle: "..veh_info["name"].."\nOwner: "..veh_info["owner"]
		.."\n_______________________\n\nEngine Damage: "..veh_info["engine"].."% (#19FF19$"
		..exports.GTIutil:tocomma(veh_info["engine_repair"]).."#FFFFFF)\nBody Damage: "..veh_info["body"].."% (#19FF19$"
		..exports.GTIutil:tocomma(veh_info["body_repair"]).."#FFFFFF)\nFuel: "..veh_info["fuel"].."% (#19FF19$0#FFFFFF)"
		.."\n_______________________\n\nRepair Cost: #19FF19$"..exports.GTIutil:tocomma(veh_info["total"])
	veh_diag_text_nocol = string.gsub(veh_diag_text, "#%x%x%x%x%x%x", "")

	addEventHandler("onClientRender", root, renderDiagnosis)
end
addEvent("GTImech.processDiagnosis", true)
addEventHandler("GTImech.processDiagnosis", root, processDiagnosis)

function renderDiagnosis()
	local vehicle = veh_info["vehicle"]
	if (not isElement(vehicle) or isPedInVehicle(localPlayer)) then
		veh_diag_text = ""
		veh_diag_text_nocol = ""
		removeEventHandler("onClientRender", root, renderDiagnosis)
		return
	end

	local px, py, pz = getCameraMatrix()
	local tx, ty, tz = getElementPosition(vehicle)
	tz = tz + getElementDistanceFromCentreOfMassToBaseOfModel(vehicle)
	local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
	if (dist > DIAG_VISIBLE) then
		veh_diag_text = ""
		veh_diag_text_nocol = ""
		removeEventHandler("onClientRender", root, renderDiagnosis)
		return
	end

	if (isLineOfSightClear(px, py, pz, tx, ty, tz, true, false, false, true, true, false, false, localPlayer)) then
		local x,y = getScreenFromWorldPosition(tx, ty, tz)
		if (x) then
			dxDrawText(veh_diag_text_nocol, x+1, y+1, x+1, y+1, tocolor(0, 0, 0, 255), 1.00, "default-bold", "center", "bottom", false, false, false, true, true)
			dxDrawText(veh_diag_text, x, y, x, y, tocolor(255, 255, 255, 255), 1.00, "default-bold", "center", "bottom", false, false, false, true, true)
		end
	end
end

-- Notify of Repair
-------------------->>

function notifyRepair(button, state, sx, sy, wx, wy, wz, vehicle)
	if (button ~= "right" or state ~= "up") then return end
	if (exports.GTIemployment:getPlayerJob(true) ~= "Mechanic") then return end
	if (not isElement(vehicle) or getElementType(vehicle) ~= "vehicle") then return end
	if (isPedInVehicle(localPlayer)) then
		outputChatBox("* You must be on foot to repair a vehicle.", 255, 25, 25)
		return
	end
	local px, py, pz = getElementPosition(localPlayer)
	local tx, ty, tz = getElementPosition(vehicle)
	local dist = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
	if (dist > 8) then
		exports.GTIhud:dm("* You must be closer to the vehicle in order to repair it.", 255, 25, 25)
		return
	end

	triggerServerEvent("GTImech.notifyRepair", vehicle)
end
addEventHandler("onClientClick", root, notifyRepair)

function sendNotice(mech, cost)
	mech_name = getPlayerName(mech)
	mechanic = mech
	rep_vehicle = source
	repair_cost = cost

	if (isElement(accept)) then
		removeEventHandler("onClientGUIClick", accept, acceptRepair)
		destroyElement(accept)
		accept = nil
	end
	if (isElement(deny)) then
		removeEventHandler("onClientGUIClick", deny, denyRepair)
		destroyElement(deny)
		deny = nil
	end

	local sx,sy = guiGetScreenSize()
	accept = guiCreateButton((sx/2)-110, sy/2, 105, 28, "Accept Repair", false)
	addEventHandler("onClientGUIClick", accept, acceptRepair)
	deny = guiCreateButton((sx/2)+5, sy/2, 105, 28, "Deny Repair", false)
	addEventHandler("onClientGUIClick", deny, denyRepair)
	addEventHandler("onClientRender", root, renderNotice)

	showCursor(true, false)
	if (isControlEnabled("fire")) then
		toggleControl("fire", false)
		enable_fire = true
	end
end
addEvent("GTImech.sendNotice", true)
addEventHandler("GTImech.sendNotice", root, sendNotice)

function renderNotice()
	local sx,sy = guiGetScreenSize()
	dxDrawText(mech_name.." wants to repair your vehicle\nRepair Cost: $"..repair_cost, (sx/2)+1, (sy/2)+1-10, (sx/2)+1, (sy/2)+1-10, tocolor(0, 0, 0, 255), 1.00, "default", "center", "bottom", false, false, true, true, true)
	dxDrawText(mech_name.." wants to repair your vehicle\nRepair Cost: #19FF19$"..repair_cost, (sx/2), (sy/2)-10, (sx/2), (sy/2)-10, tocolor(255, 255, 255, 255), 1.00, "default", "center", "bottom", false, false, true, true, true)
end

function removeNotice()
	removeEventHandler("onClientRender", root, renderNotice)
	removeEventHandler("onClientGUIClick", accept, acceptRepair)
	destroyElement(accept)
	accept = nil
	removeEventHandler("onClientGUIClick", deny, denyRepair)
	destroyElement(deny)
	deny = nil

	mechanic = nil
	rep_vehicle = nil
	showCursor(false)
	
	if (enable_fire) then
		toggleControl("fire", true)
		enable_fire = nil
	end
end

-- Accept/Deny Repair
---------------------->>

function acceptRepair(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetEnabled(source, false)
	if (not isElement(mechanic)) then
		exports.GTIhud:dm("The mechanic who wants to repair your vehicle cannot be found.", 255, 125, 0)
	elseif (not isElement(rep_vehicle)) then
		exports.GTIhud:dm("The vehicle that you wish to repair cannot be found.", 255, 125, 0)
	else
		triggerServerEvent("GTImech.acceptRepair", rep_vehicle, mechanic)
	end
	removeNotice()
end

function denyRepair(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetEnabled(source, false)
	if (not isElement(mechanic)) then
		exports.GTIhud:dm("The mechanic who wants to repair your vehicle cannot be found.", 255, 125, 25)
	else
		triggerEvent("GTImech.noiftyDenialOfRepair", mechanic, localPlayer)
	end
	removeNotice()
end

function noiftyDenialOfRepair(player)
	if (source ~= localPlayer) then return end
	exports.GTIhelp:dm(getPlayeName(player).." declined the vehicle repair.", 255, 200, 0)
end
addEvent("GTImech.noiftyDenialOfRepair")
addEventHandler("GTImech.noiftyDenialOfRepair", root, noiftyDenialOfRepair)
