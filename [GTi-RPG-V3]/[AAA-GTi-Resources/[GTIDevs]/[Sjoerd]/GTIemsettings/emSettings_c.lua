settings = {
    --Example: {"settingName", "Item Name", "Description", "DefaultSetting", "settingType" (combo, edit), {Options (Enabled, disble etc)}, "Category"},
    {"pistol", "Pistol", "Enable/Disable the usage of a Pistol.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"silencedPistol", "Silenced Pistol", "Enable/Disable the usage of a Silenced Pistol.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"deagle", "Desert Eagle", "Enable/Disable the usage of a Desert Eagle.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"pumpShotgun", "Pomp Shotgun", "Enable/Disable the usage of a Pomp Shotgun.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"sawnOff", "Sawn-Off Shotgun", "Enable/Disable the usage of a Sawn-Off Shotgun.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"spas", "Spas-12", "Enable/Disable the usage of a Spas-12.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"uzi", "Uzi", "Enable/Disable the usage of an Uzi.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"tec9", "Tec-9", "Enable/Disable the usage of a Tec-9.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"mp5", "MP5", "Enable/Disable the usage of a MP5.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"ak47", "AK-47", "Enable/Disable the usage of an AK-47.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"m4", "M4", "Enable/Disable the usage of a M4.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"countryRifle", "Country Rifle", "Enable/Disable the usage of a Country Rifle.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"sniper", "Sniper Rifle", "Enable/Disable the usage of a Sniper.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"rpg", "RPG", "Enable/Disable the usage of a RPG.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"minigun", "Minigun", "Enable/Disable the usage of a Minigun.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"grenade", "Grenade", "Enable/Disable the usage of a Grenade.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"tearGas", "Tear Gas", "Enable/Disable the usage of Tear Gas.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"molotov", "Molotov", "Enable/Disable the usage of a Molotov Cocktail.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"satchel", "Satchel", "Enable/Disable the usage of Satchels.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    -- Players
    {"crafting", "Crafting", "Enable/Disable the usage of /craft.", "Enabled", "combo", {"Enabled", "Disabled"}, "Players"},
    {"trading", "Trading (F7)", "Enable/Disable the usage of the Trading Panel.", "Enabled", "combo", {"Enabled", "Disabled"}, "Players"},
    {"weaponBinds", "Weapon Binds", "Enable/Disable the usage of the Weapon Binds.", "Enabled", "combo", {"Enabled", "Disabled"}, "Players"},
    {"cockpitView", "Force /cv", "Force players to have the Cockpit View in vehicles.", "Enabled", "combo", {"Enabled", "Disabled"}, "Players"},
    {"nitrous", "Nitrous", "Enable/Disable the usage of Nitrous.", "Enabled", "combo", {"Enabled", "Disabled"}, "Players"},
    -- World
    {"gravity", "Gravity", "Set the world gravity.", "0.008", "edit", {"Enabled", "Disabled"}, "World"},
    {"waterLvl", "Water Level", "Set the height of the water.", "1", "edit", {}, "World"},
    {"moneyKill", "Kill Reward", "Set the reward for killing a player.", "0", "edit", {"Enabled", "Disabled"}, "World"},
    {"localRange", "LocalChat Range", "Set the range of the LocalChat.", "Infinite", "combo", {"Infinite", "Default"}, "World"},
    {"uav", "Use of /uav", "Enable/Disable the usage of /uav.", "Enabled", "combo", {"Enabled", "Disabled"}, "World"},
    {"playerBlips", "Player Blips", "Enable/Disable Player Blips.", "Enabled", "combo", {"Enabled", "Disabled"}, "World"},
    --{"walkStyle", "Crafting", "Enable/Disable the usage of /craft.", "Enabled", "combo", {"Enabled", "Disabled"}, "World"},
}
    
ems = {
    gridlist = {},
    window = {},
    button = {},
    label = {},
    combobox = {},
    edit = {}
}
nodeValue = ""

function startUp()
        local screenW, screenH = guiGetScreenSize()
        ems.window[1] = guiCreateWindow((screenW - 590) / 2, (screenH - 467) / 2, 590, 467, "GTI Event Settings", false)
        guiWindowSetSizable(ems.window[1], false)

        
        
        ems.button[1] = guiCreateButton(24, 377, 173, 34, "Enable All Weapons", false, ems.window[1])
        guiSetProperty(ems.button[1], "NormalTextColour", "FFAAAAAA")
        ems.button[2] = guiCreateButton(24, 423, 173, 34, "Disable All Weapons", false, ems.window[1])
        guiSetProperty(ems.button[2], "NormalTextColour", "FFAAAAAA")
        ems.button[3] = guiCreateButton(247, 423, 101, 34, "Apply", false, ems.window[1])
        guiSetProperty(ems.button[3], "NormalTextColour", "FFAAAAAA")
        ems.button[4] = guiCreateButton(358, 423, 101, 34, "Default", false, ems.window[1])
        guiSetProperty(ems.button[4], "NormalTextColour", "FFAAAAAA")
        ems.button[5] = guiCreateButton(469, 423, 101, 34, "Close", false, ems.window[1])
        guiSetProperty(ems.button[5], "NormalTextColour", "FFAAAAAA")  
        ems.button[6] = guiCreateButton(24, 331, 173, 34, "Set Default (all)", false, ems.window[1])
        guiSetProperty(ems.button[6], "NormalTextColour", "FFAAAAAA")  
        
        ems.label[1] = guiCreateLabel(13, 282, 307, 34, "", false, ems.window[1])
        ems.combobox[1] = guiCreateComboBox(340, 312, 224, 146, "", false, ems.window[1])
        ems.edit[1] = guiCreateEdit(340, 312, 224, 24, "", false, ems.window[1])
        ems.label[2] = guiCreateLabel(338, 283, 226, 19, "", false, ems.window[1])  
        
        guiSetVisible(ems.combobox[1], false)
        guiSetVisible(ems.edit[1], false)
        guiSetVisible(ems.window[1], false)
        
        setTimer(function () triggerServerEvent("GTIemsettings.getSetting", root) end, 500, 1)
        
        addEventHandler("onClientGUIClick", ems.button[6], setAllToDefault, false)
        addEventHandler("onClientGUIClick", ems.button[1], setAllToDefault, false)
        addEventHandler("onClientGUIClick", ems.button[2], setAllToDefault, false)
        addEventHandler("onClientGUIClick", ems.button[5], closeGUI, false)
        addEventHandler("onClientGUIClick", ems.button[4], setToDefault, false)
        addEventHandler("onClientGUIClick", ems.button[3], applySetting, false)
    end  
addEventHandler("onClientResourceStart", resourceRoot, startUp)

firstUse = true
playerCat = false
worldCat = false
currentSetting = ""

function setToDefault()
    for index, setting in ipairs(settings) do
        if (setting[1] == currentSetting) then
            local actualSetting = getSetting(setting[1])
            if (setting[5] == "combo") then
                guiSetVisible(ems.combobox[1], true)
                guiSetVisible(ems.edit[1], false)
                guiComboBoxClear(ems.combobox[1])
                for index2, comboItem in pairs(setting[6]) do
                    local id = guiComboBoxAddItem(ems.combobox[1], comboItem)
                    if (setting[4] == comboItem) then
                        guiComboBoxSetSelected(ems.combobox[1], id)
                    end
                end
            else
                guiSetVisible(ems.combobox[1], false)
                guiSetVisible(ems.edit[1], true)
                guiSetText(ems.edit[1], setting[4])
            end
            triggerServerEvent("GTIemsettings.setSetting", localPlayer, currentSetting, setting[4])
        end
    end
end

function setAllToDefault()
    for index, setting in ipairs(settings) do
        local button = guiGetText(source)
        if (button == "Enable All Weapons") then
            if (setting[7] == "Weapons") then
                triggerServerEvent("GTIemsettings.setSetting", localPlayer, setting[1], setting[4])    
            end
        elseif (button == "Disable All Weapons") then 
            if (setting[7] == "Weapons") then
                triggerServerEvent("GTIemsettings.setSetting", localPlayer, setting[1], "Disabled")    
            end   
        elseif (button == "Set Default (all)") then    
            triggerServerEvent("GTIemsettings.setSetting", localPlayer, setting[1], setting[4])
        end    
    end
end    

function closeGUI()
    guiSetVisible(ems.window[1], false)
    showCursor(false)
end

function openGUI()
    addSettingsToGrid()   
    guiSetVisible(ems.window[1], true)
    showCursor(true)
end
addCommandHandler("emsettings", openGUI)


function addSettingsToGrid(outputSetting)
    local oldRow, oldCol = nil, nil
    playerCat = false
    worldCat = false
    if (isElement(ems.gridlist[1])) then
        oldRow, oldCol = guiGridListGetSelectedItem(ems.gridlist[1])
        destroyElement(ems.gridlist[1])
    end
    
    ems.gridlist[1] = guiCreateGridList(11, 29, 569, 249, false, ems.window[1])
    guiGridListAddColumn(ems.gridlist[1], "Setting", 0.5)
    guiGridListAddColumn(ems.gridlist[1], "Value", 0.5)
    
    local row = guiGridListAddRow(ems.gridlist[1])
    guiGridListSetItemText(ems.gridlist[1], row, 1, "Weapons", true, false)
    
    for i, o in ipairs(settings) do
        if (o[5] == "combo" or o[5] == "edit") then
            if (o[7] == "Weapons") then
                local row = guiGridListAddRow(ems.gridlist[1])
                guiGridListSetItemText(ems.gridlist[1], row, 1, o[2], false, false)
                for index, v in ipairs(retrievedData) do
                    if (v[1] == o[1]) then 
                        guiGridListSetItemText(ems.gridlist[1], row, 2, v[2], false, false)
                    end
                end    
                
            elseif (o[7] == "Players") then
                if (not playerCat) then
                    local row = guiGridListAddRow(ems.gridlist[1])
                    guiGridListSetItemText(ems.gridlist[1], row, 1, "Players", true, false)
                    playerCat = true
                end
                local row = guiGridListAddRow(ems.gridlist[1])
                guiGridListSetItemText(ems.gridlist[1], row, 1, o[2], false, false)
                for index, v in ipairs(retrievedData) do
                    if (v[1] == o[1]) then
                        guiGridListSetItemText(ems.gridlist[1], row, 2, v[2], false, false)
                    end
                end    
                
            elseif (o[7] == "World") then
                if (not worldCat) then
                    local row = guiGridListAddRow(ems.gridlist[1])
                    guiGridListSetItemText(ems.gridlist[1], row, 1, "World", true, false)
                    worldCat = true
                end  
                local row = guiGridListAddRow(ems.gridlist[1])
                guiGridListSetItemText(ems.gridlist[1], row, 1, o[2], false, false)     
                for index, v in ipairs(retrievedData) do
                    if (v[1] == o[1]) then
                        guiGridListSetItemText(ems.gridlist[1], row, 2, v[2], false, false)
                    end
                end    
            end    
        end
        
    end
    if (oldRow and oldCol) then
        guiGridListSetSelectedItem(ems.gridlist[1], oldRow, oldCol)
    end
    addEventHandler("onClientGUIClick", ems.gridlist[1], getSelectedSetting, false) 
end    
addEvent("GTIemsettings.refreshGridlist", true)
addEventHandler("GTIemsettings.refreshGridlist", root, addSettingsToGrid)


function setSettingsToDefault()
    for i, o in ipairs(settings) do
        if (o[1] == currentSetting) then
        end
    end
end
            

   
function getSelectedSetting()
    local settingFrName = guiGridListGetItemText(ems.gridlist[1], guiGridListGetSelectedItem(ems.gridlist[1]), 1)
    if (not settingFrName) then return end
    for index, o in ipairs(settings) do
    if (o[2] == settingFrName) then
            currentSetting = o[1]
            getSetting(o[1])
            guiSetText(ems.label[1], o[3])
            if (o[5] == "combo") then
                guiSetVisible(ems.combobox[1], true)
                guiSetVisible(ems.edit[1], false)
                guiSetText(ems.label[2], "Choose a setting below:")
                guiComboBoxClear(ems.combobox[1])
                for index2, comboItem in pairs(o[6]) do
                    local id = guiComboBoxAddItem(ems.combobox[1], comboItem)
                    for i, v in ipairs(retrievedData) do
                        if (v[1] == o[1]) then
                            if (v[2] == comboItem) then
                                guiComboBoxSetSelected(ems.combobox[1], id)
                            end    
                        end
                    end 
                end
            elseif (o[5] == "edit") then
                guiSetVisible(ems.combobox[1], false)
                guiSetVisible(ems.edit[1], true)
                guiSetText(ems.label[2], "Enter a value below:")
                for i2, v2 in ipairs(retrievedData) do
                    if (v2[1] == o[1]) then
                        guiSetText(ems.edit[1], v2[2])
                    end
                end 
            end
            return
        end
    end
end


function getSetting(settingName)
    for index, setting in ipairs(settings) do
        if (setting[1] == settingName) then
            triggerServerEvent("GTIemsettings.getSetting", localPlayer, settingName, settings)
            return true
        end
    end
    return false
end

retrievedData = {}

function returnSetting(setting)
    retrievedData = nil
    retrievedData = setting
end
addEvent("GTIemsettings.getClientSetting", true)
addEventHandler("GTIemsettings.getClientSetting", root, returnSetting)

    
function applySetting()
    if (guiGetVisible(ems.combobox[1])) then
        triggerServerEvent("GTIemsettings.setSetting", localPlayer, currentSetting, guiComboBoxGetItemText(ems.combobox[1], guiComboBoxGetSelected(ems.combobox[1])), settings)
    else
        triggerServerEvent("GTIemsettings.setSetting", localPlayer, currentSetting, guiGetText(ems.edit[1]), settings)
    end
end


-----------------------------------------------------------
--                      Effects                          --        
-----------------------------------------------------------

--[[function worldSetting (settingName, setting)
    if (getElementDimension(localPlayer) ==  336 and team ~= "Staff") then
        if (settingName == "gravity") then
            setGravity(tonumber(setting))
            return
        elseif (settingName == "waterLvl") then   
            setWaterLevel(tonumber(setting))
            return
        end
    end
end]]--    
       

       
