----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: JT Pennington (JTPenn)
-- Date: 13 Feb 2015
-- Resource: GTIstats/settings.lua
-- Version: 1.0
----------------------------------------->>

local stat_settings = {
	["hide_account"] = true,
	["hide_basic_finance"] = true,
	["hide_finances"] = true,
	["hide_weapons"] = true,
	["hide_crimes"] = true,
	["hide_missions"] = true,
	["hide_misc"] = true,
	["dist_unit"] = true,
}

local dist_units = {"meters", "kilometers", "feet", "miles"}

-- Toggle Panel
---------------->>

addEventHandler("onClientGUIClick", statsGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	guiCheckBoxSetSelected(settingsGUI.checkbox[1], getStatSetting("hide_account") or false)
	guiCheckBoxSetSelected(settingsGUI.checkbox[2], getStatSetting("hide_basic_finance") or false)
	guiCheckBoxSetSelected(settingsGUI.checkbox[3], getStatSetting("hide_finances") or false)
	guiCheckBoxSetSelected(settingsGUI.checkbox[4], getStatSetting("hide_weapons") or false)
	guiCheckBoxSetSelected(settingsGUI.checkbox[5], getStatSetting("hide_crimes") or false)
	guiCheckBoxSetSelected(settingsGUI.checkbox[6], getStatSetting("hide_missions") or false)
	guiCheckBoxSetSelected(settingsGUI.checkbox[7], getStatSetting("hide_misc") or false)
	
	local s_index = {}
	guiComboBoxClear(settingsGUI.combobox[1])
	for i,v in ipairs(dist_units) do
		s_index[v] = guiComboBoxAddItem(settingsGUI.combobox[1], v)
	end
	
	guiComboBoxSetSelected(settingsGUI.combobox[1], s_index[getStatSetting("dist_unit")] or 0)
	
	local sx = guiGetSize(settingsGUI.combobox[1], false)
	guiSetSize(settingsGUI.combobox[1], sx, 27 + 6 + (14*4), false)
	
	guiBringToFront(settingsGUI.window[1])
	guiSetVisible(settingsGUI.window[1], true)
end, false)

addEventHandler("onClientGUIClick", settingsGUI.button[2], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	guiSetVisible(settingsGUI.window[1], false)
end, false)

-- Save Settings
----------------->>

addEventHandler("onClientGUIClick", settingsGUI.button[1], function(button, state)
	if (button ~= "left" or state ~= "up") then return end
	
	setStatSetting("hide_account", 			guiCheckBoxGetSelected(settingsGUI.checkbox[1]))
	setStatSetting("hide_basic_finance", 	guiCheckBoxGetSelected(settingsGUI.checkbox[2]))
	setStatSetting("hide_finances", 		guiCheckBoxGetSelected(settingsGUI.checkbox[3]))
	setStatSetting("hide_weapons", 			guiCheckBoxGetSelected(settingsGUI.checkbox[4]))
	setStatSetting("hide_crimes", 			guiCheckBoxGetSelected(settingsGUI.checkbox[5]))
	setStatSetting("hide_missions", 		guiCheckBoxGetSelected(settingsGUI.checkbox[6]))
	setStatSetting("hide_misc", 			guiCheckBoxGetSelected(settingsGUI.checkbox[7]))
	
	setStatSetting("dist_unit", 			guiComboBoxGetItemText(settingsGUI.combobox[1], guiComboBoxGetSelected(settingsGUI.combobox[1])))
	
	guiSetVisible(settingsGUI.window[1], false)
	
	syncSettingsWithServer()
	exports.GTIhud:dm("Stats settings successfully updated!", 25, 255, 25)
end, false)

-- Sync with Server
-------------------->>

function syncSettingsWithServer()
	local stats = {}
	stats["hide_account"] 		= getStatSetting("hide_account") or false
	stats["hide_basic_finance"]	= getStatSetting("hide_basic_finance") or false
	stats["hide_finances"] 		= getStatSetting("hide_finances") or false
	stats["hide_weapons"] 		= getStatSetting("hide_weapons") or false
	stats["hide_crimes"] 		= getStatSetting("hide_crimes") or false
	stats["hide_missions"] 		= getStatSetting("hide_missions") or false
	stats["hide_misc"] 			= getStatSetting("hide_misc") or false
	stats["dist_unit"] 			= getStatSetting("dist_unit") or "meters"
	triggerServerEvent("GTIstats.syncSettingsWithServer", resourceRoot, stats)
end
addEventHandler("onClientResourceStart", resourceRoot, syncSettingsWithServer)

-- Settings Functions
---------------------->>

function getStatSetting(setting)
	if (not stat_settings[setting]) then return false end
	local xmlNode = xmlLoadFile("settings.xml") or xmlCreateFile("settings.xml", "settings")
	local xmlSetting = xmlFindChild(xmlNode, setting, 0) or xmlCreateChild(xmlNode, setting)
	
	local value = xmlNodeGetValue(xmlSetting) or "false"
	if (value == "true") then return true end
	if (value == "false" or setting ~= "dist_unit") then return false end
	if (setting == "dist_unit") then
		local passed
		for i,v in ipairs(dist_units) do 
			if (v == value) then passed = true break end
		end
		if (not passed) then return "meters" end
	end
	xmlUnloadFile(xmlNode)
	return value
end

function setStatSetting(setting, value)
	if (not stat_settings[setting]) then return false end
	local xmlNode = xmlLoadFile("settings.xml") or xmlCreateFile("settings.xml", "settings")
	local xmlSetting = xmlFindChild(xmlNode, setting, 0) or xmlCreateChild(xmlNode, setting)
	
	xmlNodeSetValue(xmlSetting, tostring(value) or "false")
	xmlSaveFile(xmlNode)
	xmlUnloadFile(xmlNode)
	return true
end
