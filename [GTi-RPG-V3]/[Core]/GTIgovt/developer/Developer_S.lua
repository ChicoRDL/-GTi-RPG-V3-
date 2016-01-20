----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 31 Jul 2014
-- Resource: GTIadmin/dev_panel/resource_catelog.slua
-- Version: 1.0
----------------------------------------->>

local developer_list = {
	["Ares"] = true,
	["Derek"] = true,		
	["Diego"] = true,	
	["Emile"] = true,
	["Jack"] = true,		
	["JTPenn"] = true,		
	["Kanto"] = true,		
	["MagicMayhem"] = true, 
	["Mitch"] = true,		
	["MrBrutus"] = true,	
	["NicKeLz"] = true,	
	["LilDolla"] = true,	
	["Sjoerd"] = true,		
	["Nerox"] = true,
	["Architects"] = true,
}

-- Toggle Dev Panel
-------------------->>

function showDeveloperPanel()
	triggerClientEvent(client, "GTIadmin.showDeveloperPanel", resourceRoot, getResourceInformation())
end
addEvent("GTIadmin.showDeveloperPanel", true)
addEventHandler("GTIadmin.showDeveloperPanel", root, showDeveloperPanel)

-- Get Resource Information
---------------------------->>

function getResourceInformation()
	local resourceInfo = {}
	for i,resource in ipairs(getResources()) do
		local resInfo = {}
		resInfo["name"] = 	getResourceName(resource)
		
		local author = getResourceInfo(resource, "author") or "Unknown"
		if (author == "Architecture Ministry") then author = "Architects" end
		if (not developer_list[author]) then
			if (string.upper(string.sub(resInfo["name"], 1, 3)) == "GTI") then
				author = "GTI Developers"
			elseif (author ~= "Unknown") then
				author = "MTA Community"
			end
		end
		
		resInfo["desc"] = 	getResourceInfo(resource, "name") or ""
		resInfo["state"] = 	getResourceState(resource)
		resInfo["start"] = 	getResourceInfo(resource, "autostart") or "false"
		if (not resourceInfo[author]) then resourceInfo[author] = {} end
		table.insert(resourceInfo[author], resInfo)
	end
	return resourceInfo
end

-- Modify Resource State
------------------------->>

function modifyResourceState(state, resource, row)
	if (state == "refresh") then
		refreshResources()
		showDeveloperPanel()
	elseif (state == "start") then
		local success = startResource(getResourceFromName(resource), true)
		triggerClientEvent("GTIadmin.updateDevPanel", resourceRoot, row, state, success)
	elseif (state == "stop") then
		local success = stopResource(getResourceFromName(resource))
		triggerClientEvent("GTIadmin.updateDevPanel", resourceRoot, row, state, success)
	elseif (state == "restart") then
		local success = restartResource(getResourceFromName(resource))
		triggerClientEvent("GTIadmin.updateDevPanel", resourceRoot, row, state, success)
	elseif (state == "autostart") then
		local autostart = getResourceInfo(getResourceFromName(resource), "autostart") or "false"
		if (autostart == "true") then
			autostart = "false"
		else
			autostart = "true"
		end
		setResourceInfo(getResourceFromName(resource), "autostart", autostart)
		triggerClientEvent("GTIadmin.updateDevPanel", resourceRoot, row, state, autostart)
	end
end
addEvent("GTIadmin.modifyResourceState", true)
addEventHandler("GTIadmin.modifyResourceState", root, modifyResourceState)
	
