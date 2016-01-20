------------------------------------------------->>
-- PROJECT:     Grand Theft International
-- RESOURCE:    GTIcallingApp/callingApp_c.lua.lua
-- TYPE:        Clientside
-- AUTHOR:      Diego Hernandez (diegonese)
-- RIGHTS:      Copyright GTI (C) 2014/2015 
------------------------------------------------->>

GTIcallingApp = {
    staticimage = {},
    edit = {},
    button = {},
    window = {},
    label = {},
    gridlist = {}
}

emergencyNumbers = {
    ["911"] = "Police",
    ["9112"] = "Paramedics",
    ["411"] = "Mechanics",
}

availableCallingNumbers = {
    ["911"] = true,
    ["9112"] = true,
    ["411"] = true,
}

switchboards = {
    {"911_1"},
    {"911_2"},
    {"911_3"},
}    
    

local GTIphone

-- Create GUI
-------------->>
function createTheAppGUI()
    if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
    
 -- Utilities:
    GTIPhone = exports.GTIdroid:getGTIDroid()
    if (not GTIPhone) then return end
    GTIApp = exports.GTIdroid:getGTIDroidAppButton("Phone")
    addEventHandler("onClientGUIClick", GTIApp, showAppGUI, false)
     
-- Emergency window:
    sX, sY = guiGetScreenSize()
    wX, wY = 300, 276
    x, y = (sX/2)-(wX/2), (sY/2)-(wY/2)
    GTIcallingApp.window[1] = guiCreateWindow(x, y, wX, wY, "B > Phone > Emergency Numbers", false)
    guiWindowSetSizable(GTIcallingApp.window[1], false)

    GTIcallingApp.label[1] = guiCreateLabel(20, 30, 256, 30, "List of the Grand Theft International\n Emergency Services Numbers", false, GTIcallingApp.window[1])
    local font_0 = guiCreateFont(":GTIdroid/fonts/Roboto-Bold.ttf")
    guiSetFont(GTIcallingApp.label[1], font_0)
    guiLabelSetHorizontalAlign(GTIcallingApp.label[1], "center", false)
    guiLabelSetVerticalAlign(GTIcallingApp.label[1], "center")
    GTIcallingApp.gridlist[1] = guiCreateGridList(26, 83, 240, 139, false, GTIcallingApp.window[1])
    guiGridListAddColumn(GTIcallingApp.gridlist[1], "Number", 0.5)
    guiGridListAddColumn(GTIcallingApp.gridlist[1], "Service", 0.4)
    for k, value in pairs(emergencyNumbers) do
        rows = guiGridListAddRow(GTIcallingApp.gridlist[1])
        guiGridListSetItemText(GTIcallingApp.gridlist[1], rows, 1, ""..k.."", false, false)
        guiGridListSetItemText(GTIcallingApp.gridlist[1], rows, 2, ""..value.."", false, false)
    --[[guiGridListSetItemText(...)
    guiGridListSetItemText(GTIcallingApp.gridlist[1], 0, 1, "911", false, false)
    guiGridListSetItemText(GTIcallingApp.gridlist[1], 0, 2, "Police", false, false)
    guiGridListSetItemText(GTIcallingApp.gridlist[1], 1, 1, "-", false, false)
    guiGridListSetItemText(GTIcallingApp.gridlist[1], 1, 2, "-", false, false)]]
        end
    GTIcallingApp.button[1] = guiCreateButton(78, 235, 123, 31, "OK", false, GTIcallingApp.window[1])
    guiSetFont(GTIcallingApp.button[1], font_0)

    guiSetVisible(GTIcallingApp.window[1], false)

-- App GUI:
    GTIcallingApp.staticimage[1] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)

    GTIcallingApp.staticimage[2] = guiCreateStaticImage(10, 6, 27, 24, ":GTIdroid/apps/Phone.png", false, GTIcallingApp.staticimage[1])
    GTIcallingApp.label[2] = guiCreateLabel(47, 10, 46, 15, "PHONE", false, GTIcallingApp.staticimage[1])
    guiSetFont(GTIcallingApp.label[2], font_0)
    GTIcallingApp.label[3] = guiCreateLabel(0, 25, 270, 15, "__________________________________________________________", false, GTIcallingApp.staticimage[1])
    --local font_1 = guiCreateFont(":GUIeditor/fonts/EmblemaOne.ttf")
    --guiSetFont(GTIcallingApp.label[3], font_1)
    guiLabelSetColor(GTIcallingApp.label[3], 0, 105, 178)
    GTIcallingApp.staticimage[3] = guiCreateStaticImage(37, 165, 49, 30, "images/1.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[3], 0.50)
    GTIcallingApp.staticimage[4] = guiCreateStaticImage(104, 163, 53, 32, "images/2.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[4], 0.50)
    GTIcallingApp.staticimage[5] = guiCreateStaticImage(167, 157, 60, 43, "images/3.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[5], 0.50)
    GTIcallingApp.staticimage[6] = guiCreateStaticImage(36, 209, 50, 40, "images/4.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[6], 0.49)
    GTIcallingApp.staticimage[7] = guiCreateStaticImage(101, 205, 56, 42, "images/5.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[7], 0.50)
    GTIcallingApp.staticimage[8] = guiCreateStaticImage(172, 209, 51, 40, "images/6.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[8], 0.50)
    GTIcallingApp.staticimage[9] = guiCreateStaticImage(37, 253, 49, 43, "images/7.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[9], 0.50)
    GTIcallingApp.staticimage[10] = guiCreateStaticImage(104, 253, 53, 43, "images/8.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[10], 0.50)
    GTIcallingApp.staticimage[11] = guiCreateStaticImage(172, 253, 51, 43, "images/9.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[11], 0.50)
    GTIcallingApp.staticimage[12] = guiCreateStaticImage(104, 300, 53, 38, "images/0.png", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.staticimage[12], 0.50)
    GTIcallingApp.staticimage[13] = guiCreateStaticImage(111, 368, 36, 36, "images/CALLING.png", false, GTIcallingApp.staticimage[1])
    guiSetProperty(GTIcallingApp.staticimage[13], "ImageColours", "tl:FFFEFFFE tr:FFFEFFFE bl:FFFEFFFE br:FFFEFFFE")    
    
-- Images data:
    setElementData(GTIcallingApp.staticimage[3], "GTIcallingApp.btnNumber", 1)
    setElementData(GTIcallingApp.staticimage[4], "GTIcallingApp.btnNumber", 2)
    setElementData(GTIcallingApp.staticimage[5], "GTIcallingApp.btnNumber", 3)
    setElementData(GTIcallingApp.staticimage[6], "GTIcallingApp.btnNumber", 4)
    setElementData(GTIcallingApp.staticimage[7], "GTIcallingApp.btnNumber", 5)
    setElementData(GTIcallingApp.staticimage[8], "GTIcallingApp.btnNumber", 6)
    setElementData(GTIcallingApp.staticimage[9], "GTIcallingApp.btnNumber", 7)
    setElementData(GTIcallingApp.staticimage[10], "GTIcallingApp.btnNumber", 8)
    setElementData(GTIcallingApp.staticimage[11], "GTIcallingApp.btnNumber", 9)
    setElementData(GTIcallingApp.staticimage[12], "GTIcallingApp.btnNumber", 0)
    
    GTIcallingApp.label[4] = guiCreateLabel(98, 410, 74, 15, "", false, GTIcallingApp.staticimage[1])
    guiSetFont(GTIcallingApp.label[4], font_0)
    guiLabelSetColor(GTIcallingApp.label[4], 255, 255, 255)
    guiLabelSetHorizontalAlign(GTIcallingApp.label[4], "center", false)
    GTIcallingApp.label[5] = guiCreateLabel(20, 54, 225, 15, "Insert a phone number to call.", false, GTIcallingApp.staticimage[1])
    guiSetFont(GTIcallingApp.label[5], font_0)
    guiLabelSetHorizontalAlign(GTIcallingApp.label[5], "center", false)
    GTIcallingApp.label[6] = guiCreateLabel(5, 142, 270, 15, "__________________________________________________________", false, GTIcallingApp.staticimage[1])
    --guiSetFont(GTIcallingApp.label[6], font_1)
    GTIcallingApp.label[7] = guiCreateLabel(0, 333, 270, 15, "__________________________________________________________", false, GTIcallingApp.staticimage[1])
    --guiSetFont(GTIcallingApp.label[7], font_1)
    GTIcallingApp.edit[1] = guiCreateEdit(27, 109, 186, 29, "", false, GTIcallingApp.staticimage[1])
    guiEditSetReadOnly(GTIcallingApp.edit[1], true)
    guiEditSetMaxLength (GTIcallingApp.edit[1], 10)
    GTIcallingApp.button[2] = guiCreateButton(217, 107, 32, 31, "<<", false, GTIcallingApp.staticimage[1])
    GTIcallingApp.label[8] = guiCreateLabel(60, 82, 137, 15, "Emergency Numbers", false, GTIcallingApp.staticimage[1])
    guiSetAlpha(GTIcallingApp.label[8], 0.28)
    guiSetFont(GTIcallingApp.label[8], font_0)
    guiLabelSetColor(GTIcallingApp.label[8], 30, 125, 255)
    guiLabelSetHorizontalAlign(GTIcallingApp.label[8], "center", false)    

    guiSetVisible(GTIcallingApp.staticimage[1], false)
end

addEventHandler("onClientResourceStart", resourceRoot, createTheAppGUI)
addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, createTheAppGUI)
 
-- Scripts:
------------>>
 function showAppGUI()
    guiSetVisible(GTIcallingApp.staticimage[1], true)
    exports.GTIdroid:showMainMenu(false)
    exports.GTIdroid:playTick()
end
 
function hideAppGUI()
    guiSetVisible(GTIcallingApp.staticimage[1], false)
    exports.GTIdroid:showMainMenu(true)
end
function avoidBugs()
    if guiGetVisible(GTIcallingApp.staticimage[1]) then
    hideAppGUI()
    end
end
addEvent("onGTIDroidClickBack", true)
addEventHandler("onGTIDroidClickBack", root, avoidBugs)
addEvent("onGTIDroidClose", true)
addEventHandler("onGTIDroidClose", root, hideAppGUI)
addEventHandler("onClientResourceStop", resourceRoot, hideAppGUI)

function outputWarningMessages(text, r, g, b)
    guiSetText(GTIcallingApp.label[5], text)
    guiLabelSetColor(GTIcallingApp.label[5], r, g, b)
    setTimer(guiSetText, 5000, 1, GTIcallingApp.label[5], "Insert a phone number to call.")
    setTimer(guiLabelSetColor, 5000, 1, GTIcallingApp.label[5], 255, 255, 255)
end

function doesEditHaveMaxChars()
    if string.len(guiGetText(GTIcallingApp.edit[1])) > 10 then
        return false
    else 
        return true
    end
end

addEventHandler("onClientMouseEnter", root, function ()
    if source == GTIcallingApp.staticimage[3] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[4] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[5] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[6] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[7] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[8] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[9] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[10] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[11] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[12] then
        guiSetAlpha(source, 1)
    elseif source == GTIcallingApp.staticimage[13] then
        if getElementData(localPlayer, "GTIcallingApp.isOnCall") == false then
        guiSetProperty(source, "ImageColours", "tl:FF005902 tr:FF005902 bl:FF005902 br:FF005902")
        guiSetText(GTIcallingApp.label[4], "CALL")
        guiLabelSetColor(GTIcallingApp.label[4], 0, 150, 0)
        else
        guiSetProperty(source, "ImageColours", "tl:FFFF1919 tr:FFFF1919 bl:FFFF1919 br:FFFF1919")    
        guiSetText(GTIcallingApp.label[4], "HANGUP")
        guiLabelSetColor(GTIcallingApp.label[4], 255, 25, 25)
        end
        guiSetSize(source, 40, 40, false)
        exports.GTIdroid:playTick()
    elseif source == GTIcallingApp.label[8] then
        exports.GTIdroid:playTick()
        guiSetAlpha(source, 1)
    end
end)

addEventHandler("onClientMouseLeave", root, function ()
    if source == GTIcallingApp.staticimage[3] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[4] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[5] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[6] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[7] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[8] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[9] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[10] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[11] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[12] then
        guiSetAlpha(source, 0.5)
    elseif source == GTIcallingApp.staticimage[13] then
        guiSetProperty(source, "ImageColours", "tl:FFFEFFFE tr:FFFEFFFE bl:FFFEFFFE br:FFFEFFFE") 
        guiSetText(GTIcallingApp.label[4], "")
        guiLabelSetColor(GTIcallingApp.label[4], 255, 255, 255)
        guiSetSize(source, 36, 36, false)
        
    elseif source == GTIcallingApp.label[8] then
        guiSetAlpha(source, 0.28)
    end
end)

function playDialSound()
    if isElement(sound) then destroyElement(sound) end
    local sound = playSound("dial.mp3", false)  
end
--[[
function playSwitchboardSound()
    if isElement(switchboard) then destroyElement(switchboard) end
        local num = math.random(#switchboards)
        local switchboard = playSound(switchboards[num]".mp3", false)  
        outputDebugString(switchboards[num])
end
addCommandHandler("tesst", playSwitchboardSound)]]

addEventHandler("onClientGUIClick", root, function ()
    if source == GTIcallingApp.label[8] then
        guiSetVisible(GTIcallingApp.window[1], true)
        
    elseif source == GTIcallingApp.button[1] then
        guiSetVisible(GTIcallingApp.window[1], false)
        
    elseif source == GTIcallingApp.staticimage[3] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end
        
    elseif source == GTIcallingApp.staticimage[4] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end 
        
    elseif source == GTIcallingApp.staticimage[5] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end
        
    elseif source == GTIcallingApp.staticimage[6] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end
        
    elseif source == GTIcallingApp.staticimage[7] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end
        
    elseif source == GTIcallingApp.staticimage[8] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end
        
    elseif source == GTIcallingApp.staticimage[9] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end
        
    elseif source == GTIcallingApp.staticimage[10] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end
        
    elseif source == GTIcallingApp.staticimage[11] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end
        
    elseif source == GTIcallingApp.staticimage[12] then
        if doesEditHaveMaxChars() == true then
        local buttonData = getElementData(source, "GTIcallingApp.btnNumber")
        local theEdit = GTIcallingApp.edit[1]
        local editText = guiGetText(theEdit)
        guiSetText(theEdit, ""..editText..""..buttonData.."")
        playDialSound()
        end

    elseif source == GTIcallingApp.button[2] then -- CLEAR
        local theEdit = GTIcallingApp.edit[1]   
        guiSetText(theEdit, "") 
        
    elseif source == GTIcallingApp.staticimage[13] then -- CALLING
        local number = guiGetText(GTIcallingApp.edit[1])
        if number == "" then return end
        if not availableCallingNumbers[number] then outputWarningMessages("Invalid phone number entered", 255, 0, 0) return end
        if getElementData(localPlayer, "GTIcallingApp.isOnCall") == false then
            triggerServerEvent("GTIcallingApp.call911", localPlayer, number)
        else
            triggerServerEvent("GTIcallingApp.hangup", localPlayer)
        end
    end
end)

function playRingingSound()
    if isElement(ringing) then destroyElement(ringing) end
    ringing = playSound("ring.mp3", true)
                setTimer(destroyElement, 2000, 1, ringing)
end
addEvent("GTIcallingApp.playRingSound", true)
addEventHandler("GTIcallingApp.playRingSound", root, playRingingSound)

--[[GUIEditor = {
    staticimage = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.staticimage[1] = guiCreateStaticImage(328, 47, 242, 220, ":GTIcallingApp/images/CALLING.png", false)
        guiSetProperty(GUIEditor.staticimage[1], "ImageColours", "tl:FF005902 tr:FF005902 bl:FF005902 br:FF005902")


        GUIEditor.staticimage[2] = guiCreateStaticImage(639, 170, 242, 220, ":GTIcallingApp/images/CALLING.png", false)
        guiSetProperty(GUIEditor.staticimage[2], "ImageColours", "tl:FFFEFFFE tr:FFFEFFFE bl:FFFEFFFE br:FFFEFFFE")    
    end
)]]



--[[local dxfont = dxCreateFont(":GTIdroid/fonts/Roboto-Bold.ttf")

addEventHandler("onClientRender", root,
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        if vehicle then
        local x, y, width, height = 368, 75, getElementHealth(vehicle) / 1000 * 286, 9
        dxDrawRectangle(363, 70, 296, 19, tocolor(3, 0, 0, 255), true)
        dxDrawRectangle(368, 75, 286, 9, tocolor(69, 0, 0, 255), true)
        dxDrawRectangle(x, y, width, height, tocolor(191, 0, 0, 255), true)
        dxDrawText("Diego's HP", 384, 95, 649, 112, tocolor(255, 255, 255, 255), 1.00, dxfont, "center", "top", false, false, true, false, false)
    end
    end
)


addEventHandler("onClientResourceStart", resourceRoot,
    function()    
    end
)]]

--[[
    -- Why is there a vehicle HUD in a calling app?
addEventHandler("onClientRender", root,
    function()
        local vehicle = getPedOccupiedVehicle(localPlayer)
        
        if vehicle then
        
        displayHealth = getElementHealth(vehicle)/ 10
        hp = math.ceil(getElementHealth(vehicle))
        
        width = getElementHealth(vehicle) / 1000 * 167
        dxDrawRectangle(759, 363, 175, 11, tocolor(2, 1, 1, 251), true)
        dxDrawRectangle(763, 364, 167, 9, tocolor(70, 0, 0, 251), true)
        dxDrawRectangle(763, 364, width, 9, tocolor(150, 0, 0, 251), true)
        
        
        dxDrawText(""..math.ceil(displayHealth).."%", 882, 373, 934, 401, tocolor(195, 194, 194, 203), 0.70, "pricedown", "center", "bottom", false, false, true, false, false)
        dxDrawText("kph", 845, 339, 876, 358, tocolor(213, 212, 212, 254), 0.80, "pricedown", "left", "top", false, false, true, false, false)
        dxDrawText(""..math.ceil(exports.GTIutil:getElementSpeed(vehicle, "kph")).."", 785, 324, 835, 358, tocolor(255, 255, 255, 255), 1.50, "pricedown", "left", "top", false, false, true, false, false)
    end
end)
--]]

