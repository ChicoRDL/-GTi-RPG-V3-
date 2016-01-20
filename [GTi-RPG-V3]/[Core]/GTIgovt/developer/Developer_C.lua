----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 31 Jul 2014
-- Resource: GTIadmin/dev_panel/resource_catelog.lua
-- Version: 1.0
----------------------------------------->>

local dev_order = {"JTPenn", "LilDolla", "Emile", "Jack", "Sjoerd", "Diego", "Mitch", "Nerox", "NicKeLz", "MagicMayhem", "Ares",
	"MrBrutus", "Derek", "Kanto", "Nathan", "Architects", "GTI Developers", "MTA Community", "Unknown"}
	
-- Toggle Developer Panel
-------------------------->>

addEventHandler("onClientGUITabSwitched", devPanel.tab[1], function()
	triggerServerEvent("GTIadmin.showDeveloperPanel", resourceRoot)
end)

function showDeveloperPanel(resources)
	guiGridListClear(devPanel.gridlist[1])
	for _,author in ipairs(dev_order) do
		local row = guiGridListAddRow(devPanel.gridlist[1])
		guiGridListSetItemText(devPanel.gridlist[1], row, 1, author, true, false)
		guiGridListSetItemColor(devPanel.gridlist[1], row, 1, 30, 145, 255)
		if (resources[author]) then
			local running = 0
			for _,data in ipairs(resources[author]) do
				local row = guiGridListAddRow(devPanel.gridlist[1])
				guiGridListSetItemText(devPanel.gridlist[1], row, 1, data["name"], false, false)
				guiGridListSetItemText(devPanel.gridlist[1], row, 2, data["desc"], false, false)
				guiGridListSetItemText(devPanel.gridlist[1], row, 3, data["state"], false, false)
				if (data["state"] == "running") then
					guiGridListSetItemColor(devPanel.gridlist[1], row, 3, 25, 255, 25)
					running = running + 1
				else
					guiGridListSetItemColor(devPanel.gridlist[1], row, 3, 255, 25, 25)
				end
				if (data["start"] == "true") then data["start"] = "True" else data["start"] = "False" end
				guiGridListSetItemText(devPanel.gridlist[1], row, 4, data["start"], false, false)
				if (data["start"] == "True") then
					guiGridListSetItemColor(devPanel.gridlist[1], row, 4, 25, 255, 25)
				else
					guiGridListSetItemColor(devPanel.gridlist[1], row, 4, 255, 25, 25)
				end
			end
			guiGridListSetItemText(devPanel.gridlist[1], row, 1, author.." ("..running.."/"..#resources[author]..")", true, false)
		end
	end
end
addEvent("GTIadmin.showDeveloperPanel", true)
addEventHandler("GTIadmin.showDeveloperPanel", root, showDeveloperPanel)

-- Start/Stop/Restart/Refresh
------------------------------>>

function modifyResourceState(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if (source == devPanel.button[2]) then
		triggerServerEvent("GTIadmin.modifyResourceState", resourceRoot, "refresh")
		return
	end
	
	local row = guiGridListGetSelectedItem(devPanel.gridlist[1])
	if (not row or row == -1) then
		exports.GTIhud:dm("DEVELOPER: Select a resource that you wish to start, stop, or restart.", 255, 25, 25)
		return
	end
	
	if (source == devPanel.button[1]) then
		local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
		triggerServerEvent("GTIadmin.modifyResourceState", resourceRoot, "start", resource, row)
		return
	end
	
	if (source == devPanel.button[3]) then
		local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
		triggerServerEvent("GTIadmin.modifyResourceState", resourceRoot, "stop", resource, row)
		return
	end
	
	if (source == devPanel.button[4]) then
		local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
		triggerServerEvent("GTIadmin.modifyResourceState", resourceRoot, "restart", resource, row)
		return
	end
	
	if (source == devPanel.button[5]) then
		local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
		triggerServerEvent("GTIadmin.modifyResourceState", resourceRoot, "autostart", resource, row)
		return
	end
end
for i=1,5 do addEventHandler("onClientGUIClick", devPanel.button[i], modifyResourceState, false) end

function updateDevPanel(row, state, update)
	if (state == "start") then
		if (update) then
			guiGridListSetItemText(devPanel.gridlist[1], row, 3, "running", false, false)
			guiGridListSetItemColor(devPanel.gridlist[1], row, 3, 25, 255, 25)
			local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
			outputDebugString("start: Resource '"..resource.."' started")
		else
			local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
			outputDebugString("start: Resource '"..resource.."' is already running or failed to start")
		end
	elseif (state == "stop") then
		if (update) then
			guiGridListSetItemText(devPanel.gridlist[1], row, 3, "loaded", false, false)
			guiGridListSetItemColor(devPanel.gridlist[1], row, 3, 255, 25, 25)
			local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
			outputDebugString("stop: Resource '"..resource.."' stopped")
		else
			local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
			outputDebugString("stop: Resource '"..resource.."' is not running or failed to stop")
		end
	elseif (state == "restart") then
		if (update) then
			guiGridListSetItemText(devPanel.gridlist[1], row, 3, "running", false, false)
			guiGridListSetItemColor(devPanel.gridlist[1], row, 3, 25, 255, 25)
			local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
			outputDebugString("restart: Resource '"..resource.."' restarted")
		else
			local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
			outputDebugString("restart: Resource '"..resource.."' is not running or failed to restart")
		end
	elseif (state == "autostart") then
		if (update == "true") then
			guiGridListSetItemText(devPanel.gridlist[1], row, 4, "True", false, false)
			guiGridListSetItemColor(devPanel.gridlist[1], row, 4, 25, 255, 25)
			local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
			outputDebugString("autostart: Resource '"..resource.."' added to start list")
		else
			guiGridListSetItemText(devPanel.gridlist[1], row, 4, "False", false, false)
			guiGridListSetItemColor(devPanel.gridlist[1], row, 4, 255, 25, 25)
			local resource = guiGridListGetItemText(devPanel.gridlist[1], row, 1)
			outputDebugString("autostart: Resource '"..resource.."' removed from start list")
		end
	end
end
addEvent("GTIadmin.updateDevPanel", true)
addEventHandler("GTIadmin.updateDevPanel", root, updateDevPanel)
