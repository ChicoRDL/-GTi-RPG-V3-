----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

-- getSetting will return a string (the setting value) OR the default value OR false if setting not in settingInfo table
-- setSetting will return true or false. setSetting(settingName, settingValue)
-- triggerEvent("onClientSettingChange", localPlayer, setting, oldVal, newVal) when player or script changes a setting

-- name, friendly name, description, default, "drop" (drop down) or "edit" (edit box) or "none" (dont show in GUI), {dropdown options}
settingInfo = {
	{"repairmodblips", "Show Repair + Mod Shop Blips", "Enable or disable Pay n Spray blips",  "Yes", "drop", {"Yes", "No"}},
	{"foodblips", "Show Food Shop Blips", "Enable or disable Food Store blips",  "Yes", "drop", {"Yes", "No"}},
	{"ammublips", "Show Ammunation Store Blips", "Enable or disable Ammunation blips",  "Yes", "drop", {"Yes", "No"}},
	{"atmblips", "Show ATM Blips", "Enable or disable ATM blips",  "No", "drop", {"Yes", "No"}},
	{"storeblips", "Show Store Blips", "Enable or disable Store blips",  "Yes", "drop", {"Yes", "No"}},
	{"vehblips", "Show Vehicle Blips", "Enable or disable Vehicle blips",  "No", "drop", {"Yes", "No"}},
	{"useful_msg", "Show Useful Messages in Chatbox", "Enable or disable the green useful messages in the chatbox",  "Yes", "drop", {"Yes", "No"}},
	{"groupnames", "Show Group Base Names (F11)", "Enable or disable Group Base Names on F11",  "Yes", "drop", {"Yes", "No"}},
	{"groupmembers", "Show Group Member Names (F11)", "Enable or disable Group Member Names on F11",  "Yes", "drop", {"Yes", "No"}},
	{"member_size", "Change Size Member Names (F11)", "Change the size of the member names in F11",  "0.75", "drop", {"0.50", "0.75", "1.00", "1.50"}},
	{"veh_units", "Change Vehicle Units", "Change the vehicle units from MPH to KPH or vice versa", "KPH", "drop", {"KPH", "MPH"}},
	{"hud", "Change Player HUD", "Change the HUD to GTA Hud or the GTI Hud or vice versa", "GTI Hud", "drop", {"GTI Hud", "GTA Hud"}},
	{"gunmods", "Enable Server Gun Mods", "Enable or Disable server modded Weapons",  "No", "drop", {"Yes", "No"}},
	{"wheelmods", "Enable Server Wheel Mods", "Enable or Disable server modded Wheels",  "No", "drop", {"Yes", "No"}},
	{"blipmods", "Enable Server HD Blip Mods", "Enable or Disable server modded Blips",  "No", "drop", {"Yes", "No"}},
	{"cleancars", "Remove Dirt Shader", "This setting will apply a shader to vehicles which will remove the dirt from them.", "No", "drop", {"Yes", "No"}},
	{"markers", "Change the Texture of Markers", "Enable or Disable the server texture for Markers.",  "No", "drop", {"Yes", "No"}},
	{"detailed_radar", "Enable detailed radar", "Enable or Disable detailed radar", "No", "drop", {"Yes", "No"}},
	{"detailed", "Enable Detailed Textures", "Enable or Disable detailed textures", "No", "drop", {"Yes", "No"}},
	{"car_reflect", "Enable Car Reflection Shader", "Enable or Disable car reflections", "No", "drop", {"Yes", "No"}},
	{"dynamic_sky", "Enable Dynamic Sky Shader", "Enable or Disable dynamic sky shader", "No", "drop", {"Yes", "No"}},
	{"water_shine", "Enable Water Shine Shader", "Enable or Disable water shine shader", "No", "drop", {"Yes", "No"}},
	{"move_head", "Enable Moving Head", "Enable or Disable moving player head", "Yes", "drop", {"Yes", "No"}},
	{"draw_distance", "Set game draw distance", "Set game draw distance (using high values may cause FPS drop)", "350", "drop", {"300", "450", "700", "1000", "1500", "2000", "2500", "3000", "4000", "5000", "6000", "7000", "8000", "9000", "10000", "15000", "20000", "25000", "30000", "35000", "40000", "45000", "50000"}},
} 

local selectedSetting = ""
local nodeValue = ""

function handleStartup()
	settings = xmlLoadFile("@settings.xml")
	if (settings) then
		node = xmlFindChild(settings, "data", 0)
		if (not node) then
			if (not node) then
				xmlNodeSetValue(xmlCreateChild(node, "data"), "")
			end
			xmlSaveFile(settings)
			handleStartup()
			return
		end
	else
		local settingsXML = xmlCreateFile("@settings.xml", "settings")
		xmlNodeSetValue(xmlCreateChild(settingsXML, "data"), "")
		xmlSaveFile(settingsXML)
		handleStartup()
		return
	end
	nodeValue = xmlNodeGetValue(node)
	
	local resX, resY = guiGetScreenSize()
	window = guiCreateWindow((resX/2)-241, (resY/2)-237, 482, 474, "GTI Settings Panel", false)
	guiWindowSetSizable(window, false)
	guiSetVisible(window, false)
	guiSetAlpha(window, 0.95)

	desc = guiCreateLabel(12, 248, 197, 211, "", false, window)
	guiSetFont(desc, "clear-normal")
	guiLabelSetHorizontalAlign(desc, "left", true)
	close = guiCreateButton(15, 377, 455, 20, "Close", false, window)
	default = guiCreateButton(15, 407, 455, 20, "Reset Settings", false, window)
	apply = guiCreateButton(15, 437, 455, 20, "Save", false, window)
	combo = guiCreateComboBox(218, 249, 251, 121, "", false, window)
	valueLabel = guiCreateLabel(228, 387, 51, 17, "Value:", false, window)
	guiSetFont(valueLabel, "clear-normal")
	edit = guiCreateEdit(282, 382, 187, 30, "", false, window)
	guiEditSetMaxLength(edit, 30)
	guiSetVisible(combo, false)
	guiSetVisible(edit, false)
	guiSetVisible(valueLabel, false)
	
	addEventHandler("onClientGUIClick", close, closeGUI, false)
	addEventHandler("onClientGUIClick", apply, applySetting, false)
	addEventHandler("onClientGUIClick", default, defaultSetting, false)
	
	-- Tell scripts we're ready to roll
	local spl = split(nodeValue, ":") or {}
	for i, dat in ipairs(spl) do
		local spl2 = split(dat, ";") or {}
		triggerEvent("onClientSettingChange", localPlayer, spl2[1], nil, spl2[2])
	end
end
addEventHandler("onClientResourceStart", resourceRoot, handleStartup)

function applySetting()
	if (guiGetVisible(combo)) then
		setSetting(selectedSetting, guiComboBoxGetItemText(combo, guiComboBoxGetSelected(combo)))
	else
		setSetting(selectedSetting, guiGetText(edit))
	end
end

function defaultSetting()
	for index, setting in ipairs(settingInfo) do
		if (setting[1] == selectedSetting) then
			local actualSetting = getSetting(setting[1])
			if (setting[5] == "drop") then
				guiSetVisible(combo, true)
				guiSetVisible(edit, false)
				guiSetVisible(valueLabel, false)
				guiComboBoxClear(combo)
				for index2, comboItem in pairs(setting[6]) do
					local id = guiComboBoxAddItem(combo, comboItem)
					if (setting[4] == comboItem) then
						guiComboBoxSetSelected(combo, id)
					end
				end
			else
				guiSetVisible(combo, false)
				guiSetVisible(edit, true)
				guiSetVisible(valueLabel, true)
				guiSetText(edit, setting[4])
			end
			setSetting(selectedSetting, setting[4])
			return
		end
	end
end

function updateGUIGrid()
	local row, col = nil, nil
	local scroll = nil
	if (isElement(grid)) then
		row, col = guiGridListGetSelectedItem(grid)
		scroll = guiGridListGetVerticalScrollPosition(grid)
		destroyElement(grid)
	end

	grid = guiCreateGridList(11, 25, 461, 218, false, window)
	guiGridListAddColumn(grid, "Setting", 0.6)
	guiGridListAddColumn(grid, "Value", 0.3)
	
	for index, setting in ipairs(settingInfo) do
		if (setting[5] == "drop" or setting[5] == "edit") then
			local row = guiGridListAddRow(grid)
			guiGridListSetItemText(grid, row, 1, setting[2], false, false)
			if (getSetting(setting[1])) then
				guiGridListSetItemText(grid, row, 2, getSetting(setting[1]), false, false)
			end
		end
	end
	
	if (row and col) then
		guiGridListSetSelectedItem(grid, row, col)
	end
	if (scroll) then
		setTimer(guiGridListSetVerticalScrollPositionDelayed, 500, 1, grid, scroll)
	end
	addEventHandler("onClientGUIClick", grid, selectSetting, false)
end

function guiGridListSetVerticalScrollPositionDelayed(grid, scroll)
	if (isElement(grid)) then
		guiGridListSetVerticalScrollPosition(grid, scroll)
	end
end

function selectSetting()
	local settingFrName = guiGridListGetItemText(grid, guiGridListGetSelectedItem(grid), 1)
	if (not settingFrName) then return end
	for index, setting in ipairs(settingInfo) do
		if (setting[2] == settingFrName) then
			selectedSetting = setting[1]
			local actualSetting = getSetting(setting[1])
			guiSetText(desc, setting[3])
			if (setting[5] == "drop") then
				guiSetVisible(combo, true)
				guiSetVisible(edit, false)
				guiSetVisible(valueLabel, false)
				guiComboBoxClear(combo)
				for index2, comboItem in pairs(setting[6]) do
					local id = guiComboBoxAddItem(combo, comboItem)
					if (actualSetting == comboItem) then
						guiComboBoxSetSelected(combo, id)
					end
				end
			elseif (setting[5] == "edit") then
				guiSetVisible(combo, false)
				guiSetVisible(edit, true)
				guiSetVisible(valueLabel, true)
				guiSetText(edit, actualSetting)
			end
			return
		end
	end
end

function closeGUI()
	guiSetVisible(window, false)
	showCursor(false)
end

function openGUI()
	if ( not guiGetVisible(window) ) then updateGUIGrid() end
	guiSetVisible(window, not guiGetVisible(window))
	showCursor(true, not isCursorShowing())
end
addCommandHandler("settings", openGUI)

function getSetting(settingName)
	for index, setting in ipairs(settingInfo) do
		if (setting[1] == settingName) then
			local spl = split(nodeValue, ":") or {}
			for i, dat in ipairs(spl) do
				local spl2 = split(dat, ";") or {}
				if (spl2[1] == setting[1]) then
					return spl2[2]
				end
			end
			return setting[4]
		end
	end
	return false
end

function setSetting(settingName, newVal)
	local newVal = string.gsub(newVal, ":", "")
	local newVal = string.gsub(newVal, ";", "")
	for index, setting in ipairs(settingInfo) do
		if (setting[1] == settingName) then
			-- Get the old stuff
			local spl = split(nodeValue, ":") or {}
			local oldVal = false
			for index2, dat in ipairs(spl) do
				local spl2 = split(dat, ";") or {}
				if (spl2[1] == setting[1]) then
					oldVal = spl2[2]
					table.remove(spl, index2)
				end
			end
			table.insert(spl, setting[1]..";"..newVal)
			-- Add the new stuff
			local newStr = ""
			for index3, dat in pairs(spl) do
				newStr = newStr..":"..dat
			end
			nodeValue = newStr
			xmlNodeSetValue(node, newStr)
			xmlSaveFile(settings)
			updateGUIGrid()
			triggerEvent("onClientSettingChange", localPlayer, settingName, oldVal, newVal)
			return true
		end
	end
	return false
end

addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		local settingsApp = exports.GTIdroid:getGTIDroidAppButton("Settings")
		addEventHandler("onClientGUIClick", settingsApp, openGUI, false)
	end
)

function getSettingsTable()
    return settingInfo
end
