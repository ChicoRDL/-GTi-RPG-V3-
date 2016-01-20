 ------------------------------------------------->>
-- PROJECT:         Grand Theft International
-- RESOURCE:        GTIsettingsApp/settingsapp_c.lua
-- DESCRIPTION:     GTI droid settings app
-- AUTHOR:          Nerox
-- RIGHTS:          All rights reserved to author
------------------------------------------------->>

local settingsElements = {{"Allow other players to mark me", "false"}}
local screenW, screenH = guiGetScreenSize()
local sBoldFont = guiCreateFont("bold.ttf", 10)
local xBoldFont = guiCreateFont("bold.ttf", 13)
local xsBoldFont = guiCreateFont("bold.ttf", 8)
local settingsToRemove = {"Water_reflection"}
if not xBoldFont or not sBoldFont or not xsBoldFont then
    outputChatBox("There was an error downloading the GTI droid settings' app font, Please reconnect", 255, 0, 0)
end
local settingsY = 80
local file
local checkBoxTable = {}
local firstTimeLoaded = false
function getSettings(res)
    if res == getThisResource() then
    file = xmlLoadFile ( "@settings.xml" )
    if not file then 
    file = xmlCreateFile("@settings.xml", "Game_settings")
    xmlNodeSetValue(xmlCreateChild(file, "Draw_distance"), getFarClipDistance())
    xmlNodeSetValue(xmlCreateChild(file, "FPS_limit"), getFPSLimit())
    if not file then return exports.GTIhud:dm("GTIdroid: Cannot load settings please reconnect", 255, 0, 0) end
    xmlSaveFile(file)
    end
    loadSettings()
    removeSettingsInTable()
    firstTimeLoaded = true
    setTimer(editSettingsTab, 2000, 1)
    if (getResourceFromName("GTIdetailedRadar") and getResourceState(getResourceFromName("GTIdetailedRadar")) == "running") then
        if getSettingEnabled("Detailed radar") then
            exports.GTIdetailedRadar:enableDetailedRadar(true)
        else
            exports.GTIdetailedRadar:enableDetailedRadar(false)
        end
    end
    elseif res == getResourceFromName("GTIdetailedRadar") then
    if getSettingEnabled("Detailed radar") then
        exports.GTIdetailedRadar:enableDetailedRadar(true)
    else
        exports.GTIdetailedRadar:enableDetailedRadar(false)
    end
    end
end
addEventHandler("onClientResourceStart", root, getSettings)
addEventHandler("onClientResourceStop", resourceRoot, function(res)
    if res == getThisResource() then
    xmlUnloadFile(file)
    end
end)
function removeSettingsInTable()
    if not file then file = xmlLoadFile ( "@settings.xml" ) end
    for k, settingName in ipairs(settingsToRemove) do
    local settingNode = xmlFindChild(file, settingName, 0)
        if settingNode then
        xmlDestroyNode(settingNode)
        end
    end
    xmlSaveFile(file)
end
function getClientSetting(settingName)
    if not file then file = xmlLoadFile ( "@settings.xml" ) end
    local node = xmlFindChild(file, settingName, 0)
    if not node then return false end
    local result = tostring(xmlNodeGetValue(node))
    return triggerServerEvent("GTIsettingsApp.recieveSetting", localPlayer, settingName, result)
end
addEvent("GTIsettingsApp.getClientSetting", true)
addEventHandler("GTIsettingsApp.getClientSetting", root, getClientSetting)
function editSettingsTab()
    if not getResourceFromName("GTIdroid") then return false end
    for k, node in ipairs(xmlNodeGetChildren(file)) do
        for i, checkBox in ipairs(checkBoxTable) do
        if not isElement(checkBox) then return false end
            if string.gsub(guiGetText(checkBox), " ", "_") == xmlNodeGetName ( node ) then
                if getSettingEnabled(xmlNodeGetName ( node )) then
                guiCheckBoxSetSelected(checkBox, true)
                else
                guiCheckBoxSetSelected(checkBox, false)
                end
            end
        end
    end
end
function saveSettings()
    if source == gameSettings.staticimage[3] or guiGetText(source) == "Save settings" then
    if not file then file = xmlLoadFile ( "@settings.xml" ) end
    xmlNodeSetValue(xmlFindChild(file, "Draw_distance", 0), (guiScrollBarGetScrollPosition (gameSettings.scrollbar[1]) * 30) + 300)
    local fpslimitnn = guiGetText(gameSettings.edit[1])
    local fpslimitn = tonumber(fpslimitnn)
    if fpslimitn and fpslimitn < 61 and fpslimitn > 35 then
        xmlNodeSetValue(xmlFindChild(file, "FPS_limit", 0), fpslimitn)
        setFPSLimit(fpslimitn)
    end
    for i, checkBox in ipairs(checkBoxTable) do
        for k, node in ipairs(xmlNodeGetChildren(file)) do
            if string.gsub(guiGetText(checkBox), " ", "_") == xmlNodeGetName ( node ) then
                if guiCheckBoxGetSelected(checkBox) then
                xmlNodeSetValue(node, "true")
                else
                xmlNodeSetValue(node, "false")
                end
            end
        end
    end
    xmlSaveFile ( file )
    loadSettings()
    return exports.GTIhud:dm("GTIdroid: settings saved!", 0, 255, 0)
    end
end
function getSettingElement(name)
    for k, checkBox in ipairs(checkBoxTable) do
        if string.lower(guiGetText(checkBox)) == string.lower(name) then
        return checkBox
        end
    end
end
function addSetting(name, value)
    if not file then file = xmlLoadFile ( "@settings.xml" ) end
    if not file then return end
    name = string.gsub(name, " ", "_")
    if xmlFindChild(file, name, 0) then return editSettingsTab() end
    if xmlNodeSetValue(xmlCreateChild(file, name), value) then
    xmlSaveFile ( file )
    return true
    else
    return false
    end
end
function removeSetting(name)
    if not file then file = xmlLoadFile ( "@settings.xml" ) end
    local name = string.gsub(name, " ", "_")
    local node = xmlFindChild(file, name, 0)
    if not node then return false end
    xmlDestroyNode ( node )
    xmlSaveFile(file)
end
addEvent("GTIsettingsApp.removeSetting", true)
addEventHandler("GTIsettingsApp.removeSetting", root, removeSetting)
function getSettingEnabled(sName)
    if not file then file = xmlLoadFile ( "@settings.xml" ) end
    sName = string.gsub(sName, " ", "_")
    local child = xmlFindChild(file, sName, 0)
    if not child then return false end
    local isEnabled = xmlNodeGetValue(child)
    if not isEnabled then exports.GTIhud:dm("GTIdroid: Cannot load settings please reconnect", 255, 0, 0) return false end
    if isEnabled == "true" then
    return true
    else
    return false
    end
end
function loadSettings()
    if not file then file = xmlLoadFile ( "@settings.xml" ) end
    setFarClipDistance(tonumber(xmlNodeGetValue(xmlFindChild ( file, "Draw_distance", 0 ))))
    if getSettingEnabled("Water_shine") then
    triggerEvent( "switchWaterShine", root, true )
    else
    triggerEvent( "switchWaterShine", root, false )
    end
    if getSettingEnabled("Bloom_effect") then
    triggerEvent( "switchBloom", root, true )
    else
    triggerEvent( "switchBloom", root, false )
    end
    if getSettingEnabled("Car_reflection") then
    triggerEvent( "switchCarPaintReflect", root, true )
    else
    triggerEvent( "switchCarPaintReflect", root, false )
    end 
    if getSettingEnabled("Cartoon_effect") then
    triggerEvent( "switchCartoon", root, true )
    else
    triggerEvent( "switchCartoon", root, false )
    end 
    if getSettingEnabled("Enable_Clouds") then
    setCloudsEnabled ( true )
    else
    setCloudsEnabled ( false )
    end 
    if getSettingEnabled("Dynamic sky") then
    triggerEvent( "switchSkyAlt", root, true )
    else
    triggerEvent( "switchSkyAlt", root, false )
    end     
    if (getResourceFromName("GTIdetailedRadar") and getResourceState(getResourceFromName("GTIdetailedRadar")) == "running") then
        if getSettingEnabled("Detailed radar") then
            exports.GTIdetailedRadar:enableDetailedRadar(true)
        else
            exports.GTIdetailedRadar:enableDetailedRadar(false)
        end
    end
    if getSettingEnabled("Detail shader") then
    triggerEvent( "onClientSwitchDetail", root, true )
    else
    triggerEvent( "onClientSwitchDetail", root, false )
    end
    local farClipDistance = tonumber(xmlNodeGetValue(xmlFindChild(file, "Draw_distance", 0)))
    guiScrollBarSetScrollPosition (gameSettings.scrollbar[1], (farClipDistance-300)/30)
    local FPSnode = xmlFindChild(file, "FPS_limit", 0)
    local fpsLimit = tonumber(xmlNodeGetValue(FPSnode))
    setFPSLimit(fpsLimit)
    guiSetText(gameSettings.edit[1], getFPSLimit())
end
function settingsCreateButton(x, y, w, h, relative, parent, color, text, xOffset)
    local tx = (w - 150)/2
    local button = guiCreateStaticImage(x, y, w, h, "button.png", relative, parent)
    setElementData(button, "GTIsettingsApp.color", color)
    guiSetProperty(button, "ImageColours", "tl:"..color.." tr:"..color.." bl:"..color.." br:"..color.."")
    local buttonText = guiCreateLabel(tx+xOffset, 8, 150, 150, text, false, button)
    if sBoldFont then
    guiSetFont ( buttonText, sBoldFont )
    end
    addEventHandler("onClientGUIClick", button, function()
    if source == button then
    guiSetProperty(source, "ImageColours", "tl:FFCCCC00 tr:FFCCCC00 bl:FFCCCC00 br:FFCCCC00")
    local oldColor = getElementData(source, "GTIsettingsApp.color")
    setTimer(guiSetProperty, 200, 1, source, "ImageColours", "tl:"..oldColor.." tr:"..oldColor.." bl:"..oldColor.." br:"..oldColor.."")
    elseif source == buttonText then
    local theButton = getElementParent(source)
    guiSetProperty(theButton, "ImageColours", "tl:FFCCCC00 tr:FFCCCC00 bl:FFCCCC00 br:FFCCCC00")
    local oldColor = getElementData(theButton, "GTIsettingsApp.color")
    setTimer(guiSetProperty, 200, 1, theButton, "ImageColours", "tl:"..oldColor.." tr:"..oldColor.." bl:"..oldColor.." br:"..oldColor.."")
    end
    end)
    addEventHandler("onClientMouseEnter", button, function()
    if source == button then
    guiSetProperty(source, "ImageColours", "tl:FF70704D tr:FF70704D bl:FF70704D br:FF70704D")
    elseif source == buttonText then
    local theButton = getElementParent(source)
    guiSetProperty(theButton, "ImageColours", "tl:FF70704D tr:FF70704D bl:FF70704D br:FF70704D")
    end
    end)
    addEventHandler("onClientMouseLeave", button, function()
    if source == button then
    local oldColor = getElementData(source, "GTIsettingsApp.color")
    guiSetProperty(source, "ImageColours", "tl:"..oldColor.." tr:"..oldColor.." bl:"..oldColor.." br:"..oldColor.."")
    elseif source == buttonText then
    local theButton = getElementParent(source)
    local oldColor = getElementData(theButton, "GTIsettingsApp.color")
    guiSetProperty(theButton, "ImageColours", "tl:"..oldColor.." tr:"..oldColor.." bl:"..oldColor.." br:"..oldColor.."")
    end
    end)
    adjustEventHandlers2(buttonText, text)
    return button, buttonText
end
function createSetting(sType, sText, sValue)
    if string.lower(sType) == "checkbox" then
    settingsY = settingsY + 28
    local checkBox = guiCreateCheckBox( 5, settingsY, 195, 20, sText, false, false, gameSettings.scrollpane[1])
    addSetting(sText, sValue)
    guiSetPosition(gameSettings.staticimage[3], 69, settingsY+35, false)
    table.insert(checkBoxTable, checkBox)
    return checkBox
    end
end
settingsAppGUI = {
    staticimage = {}
}
accountSettings = {
    label = {},
    staticimage = {}
}

accountPassword = {
    staticimage = {},
    edit = {},
    label = {}
} 
accountEmail = {
    staticimage = {},
    edit = {},
    label = {}
}
gameSettings = {
    staticimage = {},
    scrollpane = {},
    scrollbar = {},
    checkBox = {},
    edit = {},
    label = {}
}
function showSettingsApp()
    guiSetVisible(settingsAppGUI.staticimage[1], true)
    guiSetVisible(accountEmail.staticimage[1], false)
    guiSetVisible(gameSettings.staticimage[1], false)
    guiSetVisible(accountSettings.staticimage[1], false)
    guiSetVisible(accountPassword.staticimage[1], false)
    exports.GTIdroid:showMainMenu(false)
    exports.GTIdroid:playTick()
end
function goBack()
    if guiGetVisible(settingsAppGUI.staticimage[1]) then
    hideSettingsApp()
    elseif guiGetVisible(accountSettings.staticimage[1]) then
    exports.GTIdroid:showMainMenu(false)
    guiSetVisible(accountSettings.staticimage[1], false)
    guiSetVisible(settingsAppGUI.staticimage[1], true)
    elseif guiGetVisible(accountPassword.staticimage[1]) then
    exports.GTIdroid:showMainMenu(false)
    guiSetVisible(accountSettings.staticimage[1], true)
    guiSetVisible(accountPassword.staticimage[1], false)
    elseif guiGetVisible(accountEmail.staticimage[1]) then
    exports.GTIdroid:showMainMenu(false)
    guiSetVisible(accountEmail.staticimage[1], false)
    guiSetVisible(accountSettings.staticimage[1], true)
    elseif guiGetVisible(gameSettings.staticimage[1]) then
    exports.GTIdroid:showMainMenu(false)
    guiSetVisible(gameSettings.staticimage[1], false)
    guiSetVisible(settingsAppGUI.staticimage[1], true)
    end
end
addEventHandler("onGTIDroidClickBack", root, goBack)
function hideSettingsApp()
    guiSetVisible(gameSettings.staticimage[1], false)
    guiSetVisible(accountEmail.staticimage[1], false)
    guiSetVisible(accountSettings.staticimage[1], false)
    guiSetVisible(accountPassword.staticimage[1], false)
    guiSetVisible(settingsAppGUI.staticimage[1], false)
    exports.GTIdroid:showMainMenu(true)
end
addEventHandler("onGTIDroidClose", root, hideSettingsApp)
addEventHandler("onClientResourceStop", resourceRoot, hideSettingsApp)
function renderSettingsGUI()
    GTIPhone = exports.GTIdroid:getGTIDroid()
    if (not GTIPhone) then return end
    settingsY = 80
    settingsApp = exports.GTIdroid:getGTIDroidAppButton("Settings")
    addEventHandler("onClientGUIClick", settingsApp, showSettingsApp, false)
    ---- Main menu
    settingsAppGUI.staticimage[1] = guiCreateStaticImage(17, 67, 270, 429, "bkgr_black.png", false, GTIPhone)
    guiSetVisible(settingsAppGUI.staticimage[1], false)
    settingsAppGUI.staticimage[2] = guiCreateStaticImage(92, 6, 80, 80, "Settings.png", false, settingsAppGUI.staticimage[1])
    settingsAppGUI.staticimage["Game_settings"] = settingsCreateButton(9, 132, 251, 31, false, settingsAppGUI.staticimage[1], "FFA9A9A9", "Game settings", 33)
    settingsAppGUI.staticimage["Account_settings"] = settingsCreateButton(9, 91, 251, 31, false, settingsAppGUI.staticimage[1], "FFA9A9A9", "Account settings", 26)
    settingsAppGUI.staticimage["Binds_settings"] = settingsCreateButton(9, 173, 251, 31, false, settingsAppGUI.staticimage[1], "FFA9A9A9", "Binds settings", 33)
    ---- Account settings
    accountSettings.staticimage[1] = guiCreateStaticImage(17, 67, 270, 429, "bkgr_black.png", false, GTIPhone)
    accountSettings.staticimage[2] = guiCreateStaticImage(92, 30, 80, 80, "Settings.png", false, accountSettings.staticimage[1])
    accountSettings.label[1] = guiCreateLabel(68, 10, 140, 20, "Account Settings", false, accountSettings.staticimage[1])
    if xBoldFont then
    guiSetFont(accountSettings.label[1], xBoldFont)
    end
    accountSettings.staticimage["Change_pass"] = settingsCreateButton(12, 120, 251, 31, false, accountSettings.staticimage[1], "FFA9A9A9", "Change Password", 20)
    accountSettings.staticimage["Change_email"] = settingsCreateButton(12, 169, 251, 31, false, accountSettings.staticimage[1], "FFA9A9A9", "Change Email", 33)
    ---- Change Password
    accountPassword.staticimage[1] = guiCreateStaticImage(17, 67, 270, 429, "bkgr_black.png", false, GTIPhone)

    accountPassword.staticimage[2] = guiCreateStaticImage(92, 30, 80, 80, "Settings.png", false, accountPassword.staticimage[1])
    accountPassword.label[1] = guiCreateLabel(70, 10, 169, 23, "Change Password", false, accountPassword.staticimage[1])
    if xBoldFont then
    guiSetFont(accountPassword.label[1], xBoldFont)
    end
    accountPassword.label[2] = guiCreateLabel(7, 120, 234, 20, "Current password:", false, accountPassword.staticimage[1])
    guiSetFont(accountPassword.label[2], "default-bold-small")
    accountPassword.edit[1] = guiCreateEdit(7, 141, 234, 28, "", false, accountPassword.staticimage[1])
    guiEditSetMasked(accountPassword.edit[1], true)
    guiEditSetMaxLength(accountPassword.edit[1], 25)
    accountPassword.label[3] = guiCreateLabel(7, 179, 234, 20, "New password:", false, accountPassword.staticimage[1])
    guiSetFont(accountPassword.label[3], "default-bold-small")
    accountPassword.edit[2] = guiCreateEdit(7, 199, 234, 28, "", false, accountPassword.staticimage[1])
    guiEditSetMasked(accountPassword.edit[2], true)
    accountPassword.label[4] = guiCreateLabel(7, 237, 234, 20, "Confirm new password:", false, accountPassword.staticimage[1])
    guiSetFont(accountPassword.label[4], "default-bold-small")
    accountPassword.edit[3] = guiCreateEdit(7, 257, 234, 28, "", false, accountPassword.staticimage[1])
    guiEditSetMasked(accountPassword.edit[3], true)
    accountPassword.staticimage[3] = settingsCreateButton(69, 295, 108, 28, false, accountPassword.staticimage[1], "FFA9A9A9", "Change password", 23) --99
    guiSetProperty(accountPassword.staticimage[3], "ImageColours", "tl:FFA9A9A9 tr:FFA9A9A9 bl:FFA9A9A9 br:FFA9A9A9")  
    ---- Change Email
    accountEmail.staticimage[1] = guiCreateStaticImage(17, 67, 270, 429, "bkgr_black.png", false, GTIPhone)
    
    accountEmail.label[1] = guiCreateLabel(70, 10, 169, 23, "Change Email", false, accountEmail.staticimage[1])
    if xBoldFont then
    guiSetFont(accountEmail.label[1], xBoldFont)
    end
    accountEmail.staticimage[2] = guiCreateStaticImage(92, 30, 80, 80, "Settings.png", false, accountEmail.staticimage[1])
    accountEmail.label[2] = guiCreateLabel(7, 120, 234, 20, "Current email:", false, accountEmail.staticimage[1])
    guiSetFont(accountEmail.label[2], "default-bold-small")
    accountEmail.edit[1] = guiCreateEdit(7, 141, 234, 28, "", false, accountEmail.staticimage[1])
    accountEmail.label[3] = guiCreateLabel(7, 179, 234, 20, "New email:", false, accountEmail.staticimage[1])
    guiSetFont(accountEmail.label[3], "default-bold-small")
    accountEmail.edit[2] = guiCreateEdit(7, 199, 234, 28, "", false, accountEmail.staticimage[1])
    accountEmail.label[4] = guiCreateLabel(7, 237, 234, 20, "Confirm new email:", false, accountEmail.staticimage[1])
    guiSetFont(accountEmail.label[4], "default-bold-small")
    accountEmail.edit[3] = guiCreateEdit(7, 257, 234, 28, "", false, accountEmail.staticimage[1])
    accountEmail.staticimage[3] = settingsCreateButton(69, 295, 99, 28, false, accountEmail.staticimage[1], "FFA9A9A9", "Change email", 33)
    ---- Game settings
    gameSettings.staticimage[1] = guiCreateStaticImage(17, 67, 270, 429, "bkgr_black.png", false, GTIPhone)
    gameSettings.staticimage[2] = guiCreateStaticImage(92, 30, 80, 80, "Settings.png", false, gameSettings.staticimage[1])
    gameSettings.label[4] = guiCreateLabel(91, 12, 81, 18, "Game settings", false, gameSettings.staticimage[1])
    guiSetFont(gameSettings.label[4], "default-bold-small") 

    gameSettings.scrollpane[1] = guiCreateScrollPane(10, 120, 245, 305, false, gameSettings.staticimage[1])
    gameSettings.scrollbar[1] = guiCreateScrollBar(5, 30, 226, 15, true, false, gameSettings.scrollpane[1])
    guiScrollBarSetScrollPosition (gameSettings.scrollbar[1], (tonumber(getFarClipDistance())-300)/30)
    gameSettings.label[1] = guiCreateLabel(5, 2, 230, 18, "Draw Distance", false, gameSettings.scrollpane[1])
    guiSetFont(gameSettings.label[1], "default-bold-small")
    gameSettings.label[2] = guiCreateLabel(193, 15, 30, 30, "3300", false, gameSettings.scrollpane[1])
    guiSetFont(gameSettings.label[2], "default-bold-small")
    
    gameSettings.edit[1] = guiCreateEdit(65, 75, 75, 28, "", false, gameSettings.scrollpane[1])
    gameSettings.label[7] = guiCreateLabel(5, 80, 230, 18, "FPS limit", false, gameSettings.scrollpane[1])
    guiSetFont(gameSettings.label[7], "default-bold-small")
    
    gameSettings.label[6] = guiCreateLabel(125, 45, 105, 30, "Reset draw distance", false, gameSettings.scrollpane[1])
    if xsBoldFont then
    guiSetFont(gameSettings.label[6], xsBoldFont)
    end
    if firstTimeLoaded then
    loadSettings()
    end
    gameSettings.label[5] = guiCreateLabel(111.5, 15, 30, 30, getFarClipDistance(), false, gameSettings.scrollpane[1])
    guiSetFont(gameSettings.label[5], "default-bold-small")
    gameSettings.label[3] = guiCreateLabel(10, 15, 30, 30, "300", false, gameSettings.scrollpane[1])
    guiSetFont(gameSettings.label[3], "default-bold-small")
    gameSettings.staticimage[3] = settingsCreateButton(69, settingsY+35, 99, 28, false, gameSettings.scrollpane[1], "FFA9A9A9", "Save settings", 33)
    for i=1, #settingsElements do
    gameSettings.checkBox[#gameSettings.checkBox+1] = createSetting("CheckBox", settingsElements[i][1], settingsElements[i][2])
    end
    gameSettings.checkBox[1] = createSetting("CheckBox", "Water shine", "false")
    gameSettings.checkBox[2] = createSetting("CheckBox", "Dynamic sky", "false")
    gameSettings.checkBox[3] = createSetting("CheckBox", "Bloom effect", "false")
    gameSettings.checkBox[4] = createSetting("CheckBox", "Cartoon effect", "false")
    gameSettings.checkBox[5] = createSetting("CheckBox", "Car reflection", "false")
    gameSettings.checkBox[6] = createSetting("CheckBox", "Enable Clouds", "true")
    gameSettings.checkBox[7] = createSetting("CheckBox", "Detail shader", "false")
    gameSettings.checkBox[8] = createSetting("CheckBox", "Detailed radar", "false")
    gameSettings.checkBox[9] = createSetting("CheckBox", "Pilot HUD", "true")
    gameSettings.checkBox[10] = createSetting("CheckBox", "Weapon Sound Mods", "false")

    --- Hide everything
    guiSetVisible(settingsAppGUI.staticimage[1], false)
    guiSetVisible(accountEmail.staticimage[1], false)
    guiSetVisible(accountSettings.staticimage[1], false)
    guiSetVisible(accountPassword.staticimage[1], false)
    guiSetVisible(gameSettings.staticimage[1], false)
    ---
    adjustEventHandlers()
end 
addEventHandler("onClientResourceStart", resourceRoot, renderSettingsGUI)
addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, renderSettingsGUI)
function adjustEventHandlers()
    addEventHandler("onClientGUIClick", settingsAppGUI.staticimage["Account_settings"], openWindows)
    addEventHandler("onClientGUIClick", accountSettings.staticimage["Change_pass"], openWindows)
    addEventHandler("onClientGUIClick", accountPassword.staticimage[3], sendPlayerPassInfo)
    addEventHandler("onClientGUIClick", accountEmail.staticimage[3], sendPlayerEmailInfo)
    addEventHandler("onClientGUIClick", accountSettings.staticimage["Change_email"], openWindows)
    addEventHandler("onClientGUIClick", gameSettings.staticimage[3], saveSettings)
    addEventHandler("onClientMouseEnter", gameSettings.label[6], hoverLabel)
    addEventHandler("onClientMouseLeave", gameSettings.label[6], hoverLabel)
    addEventHandler("onClientGUIClick", gameSettings.label[6], resetDrawDistance)
    updateClipLabel()
end
function hoverLabel()
    if eventName == "onClientMouseEnter" and source == gameSettings.label[6] then
    guiLabelSetColor ( gameSettings.label[6], 230, 150, 35 )
    elseif eventName == "onClientMouseLeave" and source == gameSettings.label[6] then
    guiLabelSetColor ( gameSettings.label[6], 255, 255, 255 )
    end
end
function resetDrawDistance()
    if source == gameSettings.label[6] then
    resetFarClipDistance()
    setTimer(function()
    guiScrollBarSetScrollPosition (gameSettings.scrollbar[1], (getFarClipDistance()-300)/30)
    xmlNodeSetValue(xmlFindChild(file, "Draw_distance", 0), (guiScrollBarGetScrollPosition (gameSettings.scrollbar[1]) * 30) + 300)
    xmlSaveFile(file)
    outputSettingsError("Draw distance has been reset.", 0, 255, 0)
    end, 500, 1)
    end
end
function updateClipLabel()
setTimer(function()
    if not getResourceFromName("GTIdroid") then return false end
    if not isElement(gameSettings.label[5]) then return end
    guiSetText(gameSettings.label[5], tostring((guiScrollBarGetScrollPosition (gameSettings.scrollbar[1]) * 30) + 300))
end, 50, 0)
end
function adjustEventHandlers2(button, text)
    if text == "Account settings" or text == "Change Password" or text == "Change Email" or text == "Game settings" then
    addEventHandler("onClientGUIClick", button, openWindows)
    end
end
function openWindows()
    if source == settingsAppGUI.staticimage["Account_settings"] or guiGetText(source) == "Account settings" then
    exports.GTIdroid:showMainMenu(false)
    guiSetVisible(settingsAppGUI.staticimage[1], false)
    guiSetVisible(accountSettings.staticimage[1], true)
    elseif source == accountSettings.staticimage["Change_pass"] or guiGetText(source) == "Change Password" then
    exports.GTIdroid:showMainMenu(false)
    guiSetVisible(accountSettings.staticimage[1], false)
    guiSetVisible(accountPassword.staticimage[1], true)
    elseif source == accountSettings.staticimage["Change_email"] or guiGetText(source) == "Change Email" then
    exports.GTIdroid:showMainMenu(false)
    guiSetVisible(accountEmail.staticimage[1], true)
    guiSetVisible(accountSettings.staticimage[1], false)
    elseif source == settingsAppGUI.staticimage["Game_settings"] or guiGetText(source) == "Game settings" then
    exports.GTIdroid:showMainMenu(false)
    guiSetVisible(settingsAppGUI.staticimage[1], false)
    guiSetVisible(gameSettings.staticimage[1], true)
    end
end
function outputSettingsError(text, r, g, b)
    exports.GTIhud:dm("GTIdroid: "..text.."", r or 255, g or 0, b or 0)
end
addEvent("GTIsettingsApp.outputError", true)
addEventHandler("GTIsettingsApp.outputError", root, outputSettingsError)
----------- CHANGING PASSWORD -------------
function sendPlayerPassInfo() -- send the entered info for the server and check them if there isn't faults then change the password
    if source == accountPassword.staticimage[3] or guiGetText(source) == "Change password" then 
    local currentPass = guiGetText(accountPassword.edit[1])
    local newPass = guiGetText(accountPassword.edit[2])
    local confirmPass = guiGetText(accountPassword.edit[3])
    if newPass ~= confirmPass then return outputSettingsError("The new password doesn't match the confirmation one") end
    if currentPass == "" then return outputSettingsError("Please fill in the fields") end
    if newPass == "" then return outputSettingsError("Please fill in the fields") end
    if string.len(newPass) < 8 then return outputSettingsError("Password must be 8-30 characters long") end
    triggerServerEvent("GTIsettingsApp.changePassword", localPlayer, currentPass, newPass)
    end
end
----------- CHANGING EMAIL -------------
function sendPlayerEmailInfo() -- send the entered info for the server and check them if there isn't faults then change the password
    if source == accountEmail.staticimage[3] or guiGetText(source) == "Change email" then 
    local currentEmail = guiGetText(accountEmail.edit[1])
    local newEmail = guiGetText(accountEmail.edit[2])
    local confirmEmail = guiGetText(accountEmail.edit[3])
    if newEmail == "" then return outputSettingsError("Please fill in the fields") end
    if newEmail ~= confirmEmail then return outputSettingsError("The new email doesn't match the confirmation one") end
    if not newEmail:match(".-%@.+%%-.") then return outputSettingsError("Please enter a valid new email.") end
    triggerServerEvent("GTIsettingsApp.changeEmail", localPlayer, currentEmail, newEmail)
    end
end
