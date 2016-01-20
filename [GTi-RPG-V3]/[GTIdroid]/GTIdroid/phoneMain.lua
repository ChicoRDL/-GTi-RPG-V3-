----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 11 Dec 2013
-- Resource: GTIdroid/phoneMain.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

TRANSITION_TIME = 250

-- Show Phone
-------------->>

local renderTimer
function togglePhone()
    if (not exports.GTIaccounts:isPlayerLoggedIn()) then return end
    if (renderTimer and isTimer(renderTimer)) then return end
    if (isElementFrozen(localPlayer)) then return end
    renderTimer = setTimer(function() renderTimer = nil end, TRANSITION_TIME, 1)
    addEventHandler("onClientRender", root, renderPhoneTranistion)
    
    if (isCursorShowing()) then
        showCursor(false)
        playSound("audio/Lock.ogg")
        if not (isSuiciding()) then triggerServerEvent("GTIdroid.stopAnimation", resourceRoot) end
    else
        showCursor(true)
        playSound("audio/Unlock.ogg")
        if not (isSuiciding()) then triggerServerEvent("GTIdroid.startAnimation", resourceRoot) end
    end
end
bindKey("b", "up", togglePhone)

local isShowing
addEvent("onGTIDroidClose", true)
function renderPhoneTranistion()
    if (not isShowing and not exports.GTIaccounts:isPlayerLoggedIn()) then
        removeEventHandler("onClientRender", root, renderPhoneTranistion)
        return
    end
    
    if (not renderTimer) then
        removeEventHandler("onClientRender", root, renderPhoneTranistion)
        local pX,pY = guiGetPosition(GTIPhone, false)
        local sX,sY = guiGetScreenSize()
        if (isShowing) then
            guiSetPosition(GTIPhone, pX, sY+30, false)
            isShowing = false
            triggerEvent("onGTIDroidClose", GTIPhone)
        else
            guiSetPosition(GTIPhone, pX, sY-610, false)
            isShowing = true
        end
        return
    end

    local timeLeft = getTimerDetails(renderTimer)
    local sX,sY = guiGetScreenSize()
    local pX,pY = guiGetPosition(GTIPhone, false)
    if (not isShowing) then
        guiSetPosition(GTIPhone, pX, sY-(((TRANSITION_TIME-timeLeft)/TRANSITION_TIME)*640), false)
    else
        guiSetPosition(GTIPhone, pX, sY-((timeLeft/TRANSITION_TIME)*610)+(((TRANSITION_TIME-timeLeft)/TRANSITION_TIME)*40), false)
    end
end

-- Phone Mod
------------->>

addEventHandler("onClientResourceStart", resourceRoot, function()
    local txd = engineLoadTXD("mods/cellphone.txd")
    engineImportTXD(txd, 330)
    local dff = engineLoadDFF("mods/cellphone.dff")
    engineReplaceModel(dff, 330)
end)

-- Render Clock
---------------->>

local font = "default"
local game_time

addEventHandler("onClientResourceStart", resourceRoot, function()
    font = dxCreateFont("fonts/Roboto.ttf")
    addEventHandler("onClientRender", root, renderClock)
end)

function updateGameTime()
    local hrs,mins = getTime()
    if (hrs < 10) then hrs = "0"..hrs end
    if (mins < 10) then mins = "0"..mins end
    game_time = hrs..":"..mins
end
setTimer(updateGameTime, 1000, 0)


function renderClock()
    if (not getGTIDroid() or not game_time) then return end
    local x,y = guiGetPosition(getGTIDroid(), false)
    local x,y = x+287-2, y+50+1
    dxDrawText(game_time, x,y,x,y, tocolor(190,190,190,255), 1, font, "right", "top", false, false, true)
end

-- App Indications
------------------->>

function increaseAppSize()
    local x,y = guiGetPosition(source, false)
    guiSetPosition(source, x-3, y-3, false)
    local x,y = guiGetSize(source, false)
    guiSetSize(source, x+6, y+6, false)
    playTick()
end

function decreaseAppSize()
    local x,y = guiGetPosition(source, false)
    guiSetPosition(source, x+3, y+3, false)
    local x,y = guiGetSize(source, false)
    guiSetSize(source, x-6, y-6, false)
end

-- Exports and Events
---------------------->>

addEvent("onGTIDroidClickBack", true)
function goBack(button, state)
    if (button ~= "left" or state ~= "up") then return end
    playTick()
    triggerEvent("onGTIDroidClickBack", GTIMenuBar)
end

function getGTIDroid()
    if (not isElement(GTIPhone)) then return false end
    return GTIPhone
end

function getGTIDroidMainMenu()
    if (not isElement(GTIWallpaper)) then return false end
    return GTIWallpaper
end

function getGTIDroidAppButton(appName)
    if (not Apps[appName] or not isElement(Apps[appName])) then return false end
    return Apps[appName]
end

function playNotice()
    return playSound("audio/Tejat.ogg")
end

function playTick()
    return playSound("audio/Effect_Tick.ogg")
end

function showMainMenu(bool, fluid)
    if (not isElement(GTIWallpaper)) then return false end
    if (not bool) then
        guiSetVisible(GTIWallpaper, false)
        if (not fluid) then
            guiSetVisible(GTIMenuBar, true)
            guiSetVisible(GTIStatusBar, true)
            guiSetVisible(GTIMenuBar2, false)
            guiSetVisible(GTIStatusBar2, false)
        else
            guiSetVisible(GTIMenuBar, false)
            guiSetVisible(GTIStatusBar, false)
            guiSetVisible(GTIMenuBar2, true)
            guiSetVisible(GTIStatusBar2, true)
        end
    else
        guiSetVisible(GTIWallpaper, true)
        guiSetVisible(GTIMenuBar, false)
        guiSetVisible(GTIStatusBar, false)
        guiSetVisible(GTIMenuBar2, false)
        guiSetVisible(GTIStatusBar2, false)
    end
    return true
end

function isSuiciding()
    return exports.GTIspawn:isPlayerSuiciding()
end
