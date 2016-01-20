----------------------------------------->>
-- GTI: Grand Theft International
-- Author: JT Pennington (JTPenn)
-- Date: 12 Mar 2015
-- Resource: GTIplayerStats/stamina.lua
-- Version: 1.0
----------------------------------------->>

local STAMINA_CYC = 50      -- Stamina Increased by Running
local STAMINA_SWIM = 50     -- Stamina Increased by Swimming
local STAMINA_SPRNT = 10    -- Stamina Increased by Sprinting
local STAMINA_RUN = 5       -- Stamina Increased by Running/Jogging

local STAM_TIME_CYC = 300   -- Seconds to Update Stamina from Cycling
local STAM_TIME_SWIM = 180  -- Seconds to Update Stamina from Swimming
local STAM_TIME_SPRNT = 300 -- Seconds to Update Stamina from Sprinting
local STAM_TIME_RUN = 300   -- Seconds to Update Stamina from Running/Jogging

local STAT_UPDATE = 2.5*60000   -- Interval to update stats

local SPEED_CYC = 20        -- Speed required for Stamina Increase from Cycling

local TIRED_TIME = 7500     -- Time Spent Tired from Sprinting

local stamina_amt = 0   -- Current Stamina (to be increased by)

local stamTimer     -- Stamina Increase Timer
local lastSprint    -- Last Time Sprinted (ms)

local bicycle = {[509] = true, [481] = true, [510] = true}

-- Increase Stamina
-------------------->>

function increaseStamina(amount)
    if (not tonumber(amount)) then return end
    local cur_stamina = stamina_amt
    local stat = getPedStat(localPlayer, 22)
    if (stat >= 1000) then if isTimer ( staminaTimer ) then killTimer ( staminaTimer) end return end
    
    stamina_amt = stamina_amt + amount
    if ((stat+cur_stamina) % 50 > (stat+stamina_amt) % 50) then
        exports.GTIhud:drawNote("playerStats.stamina", "+ Stamina ("..string.format("%.1f", ((stat + stamina_amt)/10)).."%)", 255, 215, 0, 7500)
    end
    if ((stat+cur_stamina) % 1000 > (stat+stamina_amt) % 1000) then
        exports.GTIhud:dm("Stamina Upgraded. Maximum reached.", 255, 215, 0)
        killTimer(staminaTimer)
    elseif ((stat+cur_stamina) % 200 > (stat+stamina_amt) % 200) then
        exports.GTIhud:dm("Stamina Upgraded. You can now sprint, swim, and cycle for longer.", 255, 215, 0)
    end
end

setTimer(function()
    triggerServerEvent("GTIplayerStats.modifyPlayerStat", resourceRoot, 22, stamina_amt)
    stamina_amt = 0
end, STAT_UPDATE, 0)

-- Record Stamina
------------------>>


staminaTimer = setTimer(function()
        -- Cycling Stamina
    local vehicle = getPedOccupiedVehicle(localPlayer)
    if (isPedInVehicle(localPlayer) and bicycle[getElementModel(vehicle)] and getVehicleOccupant(vehicle) == localPlayer) then
        if (exports.GTIutil:getElementSpeed(vehicle) >= SPEED_CYC) then
            increaseStamina(STAMINA_CYC/STAM_TIME_CYC * 5)
            return
        end
    end
        -- Swimming Stamina
    if (isElementInWater(localPlayer) and not isPedInVehicle(localPlayer) and isPlayerSprinting()) then
        increaseStamina(STAMINA_SWIM/STAM_TIME_SWIM * 5)
        return
    end
        -- Sprinting Stamina
    if (not isElementInWater(localPlayer) and not isPedInVehicle(localPlayer) and isPedOnGround(localPlayer) and isPlayerSprinting()) then
        if (exports.GTIutil:getElementSpeed(localPlayer) > 0) then
            increaseStamina(STAMINA_SPRNT/STAM_TIME_SPRNT * 5)
            return
        end
    end
        -- Running/Jogging Stamina
    if (not isElementInWater(localPlayer) and not isPedInVehicle(localPlayer) and isPedOnGround(localPlayer) and not getControlState("walk")) then
        if (exports.GTIutil:getElementSpeed(localPlayer) > 0) then
            increaseStamina(STAMINA_RUN/STAM_TIME_RUN * 5)
            return
        end
    end
end, 5000, 0)
    
-- Record Sprinting
-------------------->>

addEventHandler("onClientRender", root, function()
    if (getControlState("sprint") and not getControlState("walk")) then
        lastSprint = getTickCount()
    end
end)

function isPlayerSprinting()
    if (isPedInVehicle(localPlayer) or not lastSprint) then return false end
    return getTickCount() - lastSprint < 500
end

-- Make Players Tired
---------------------->>

function getMaxSprintTime()
    local stamina = getPedStat(localPlayer, 22)
    if (stamina >= 1000) then return math.huge end
    return stamina/1000 * 60
end

local sprintTime = 0    -- Time Player is Sprinting
local notSprintTime = 0 -- Time Player is not Sprinting
local isTired           -- Is Player Tired?

setTimer(function()
        -- Do Nothing if the Player is Tired
    if (getElementData(localPlayer, "superman:flying")) then return end
    if (isTired) then return end
    
        --Don't record springing for specific events
    if (isPedDead(localPlayer)) then return end
    if (getPlayerOccupiedVehicle(localPlayer)) then return end
    if (doesPedHaveJetPack(localPlayer)) then return end
        -- Record Player Sprinting
    if (isPlayerSprinting()) then
        sprintTime = sprintTime + 1
        -- Else Record Taking a Break (if already recording sprinting too)
    elseif (sprintTime ~= 0) then
        notSprintTime = notSprintTime + 1
        if (notSprintTime > 7) then
            sprintTime = 0
            notSprintTime = 0
        end
    end
        -- When you sprint too much, set as tired
    if (sprintTime >= getMaxSprintTime()) then
        toggleControl("sprint", false)
        isTired = true
        sprintTime = 0
        notSprintTime = 0
        setTimer(function()
            toggleControl("sprint", true)
            isTired = nil
        end, TIRED_TIME, 1)
        
    end
end, 1000, 0)
