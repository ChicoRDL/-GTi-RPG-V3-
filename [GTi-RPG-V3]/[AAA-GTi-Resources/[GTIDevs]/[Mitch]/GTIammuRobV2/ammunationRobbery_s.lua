----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: ammunationRobbery_s.lua
-- Version: 1.0
----------------------------------------->>

addEvent("onPlayerArrested",true)
addEvent("onInteriorExit",true)

local isPlayerNotAllowedToRob = {}
local LOWER_BOUND = 0.75	-- Lowest Deviation of Ammo Earned
local UPPER_BOUND = 1.25	-- Highest Deviation of Ammo Earned

local PISTOL_AMMO = 148		-- Median Pistol Ammo Earned
local SHOTGUN_AMMO = 83		-- Median Shotgun Ammo Earned
local SMG_AMMO = 566		-- Median SMG Ammo Earned
local AR_AMMO = 417			-- Median Assault Rifle Ammo Earned

addEvent("GTIammunationRob_payOut", true)
addEventHandler("GTIammunationRob_payOut", root, 
    function()
        exports.GTIcriminals:modifyPlayerCriminalRep(client, 1000, "Ammu-Nation Robbery")
        exports.GTIcriminals:modifyPlayerTaskProgress(client, "Ammu-Nation Robbery", 1)
        
		-- Pistol -->>
        local wep = getPedWeapon(client, 2)
        local cur_ammo = getPedTotalAmmo(client, 2)
            -- Pick Weapon
        if (wep ~= 24 or cur_ammo == 0) then
            wep = 22
        end
            -- Impose Ammo Limit
        local ammo = math.random(PISTOL_AMMO*LOWER_BOUND, PISTOL_AMMO*UPPER_BOUND)
        local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
        if (cur_ammo + ammo > max_ammo) then ammo = max_ammo - cur_ammo end
        if (ammo < 0) then ammo = 0 end
        
        giveWeapon(client, wep, ammo, false)
        exports.GTIhud:drawNote("Pistol", "+ "..ammo.." "..getWeaponNameFromID(wep).." Ammo", client, 0, 255, 0, 7500)
        
		-- Shotguns -->>
        local wep = getPedWeapon(client, 3)
        local cur_ammo = getPedTotalAmmo(client, 3)
            -- Pick Weapon
        if (wep ~= 27 and wep ~= 26 or cur_ammo == 0) then
            wep = 25
        end
            -- Impose Ammo Limit
        local ammo = math.random(SHOTGUN_AMMO*LOWER_BOUND, SHOTGUN_AMMO*UPPER_BOUND)
        local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
        if (cur_ammo + ammo > max_ammo) then ammo = max_ammo - cur_ammo end
        if (ammo < 0) then ammo = 0 end
        
        giveWeapon(client, wep, ammo, false)
        exports.GTIhud:drawNote("SPAZ12", "+ "..ammo.." "..getWeaponNameFromID(wep).." Ammo", client, 0, 255, 0, 7500)
        
        -- Sub-Machine Guns -->>
        local wep = getPedWeapon(client, 4)
        local cur_ammo = getPedTotalAmmo(client, 4)
            -- Pick Weapon
        if (wep ~= 29 and wep ~= 32 or cur_ammo == 0) then
            wep = 28
        end
            -- Impose Ammo Limit
        local ammo = math.random(SMG_AMMO*LOWER_BOUND, SMG_AMMO*UPPER_BOUND)
        local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
        if (cur_ammo + ammo > max_ammo) then ammo = max_ammo - cur_ammo end
        if (ammo < 0) then ammo = 0 end
        
        giveWeapon(client, wep, ammo, false)
        exports.GTIhud:drawNote("MP5", "+ "..ammo.." "..getWeaponNameFromID(wep).." Ammo", client, 0, 255, 0, 7500)
		
        -- Assault Rifles -->>
        local wep = getPedWeapon(client, 5)
        local cur_ammo = getPedTotalAmmo(client, 5)
            -- Pick Weapon
        if (wep ~= 31 or cur_ammo == 0) then
            wep = 30
        end
            -- Impose Ammo Limit
        local ammo = math.random(AR_AMMO*LOWER_BOUND, AR_AMMO*UPPER_BOUND)
        local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
        if (cur_ammo + ammo > max_ammo) then ammo = max_ammo - cur_ammo end
        if (ammo < 0) then ammo = 0 end
        
        giveWeapon(client, wep, ammo, false)
        exports.GTIhud:drawNote("M4", "+ "..ammo.." "..getWeaponNameFromID(wep).." Ammo", client, 0, 255, 0, 7500)
    end
)

addEvent("GTIammunationRob.WantedLevel", true)
addEventHandler("GTIammunationRob.WantedLevel", root, 
    function()
        exports.GTIpoliceWanted:chargePlayer(client, 24)
        local serial = getPlayerSerial(client)
        isPlayerNotAllowedToRob[serial] = true
        setTimer(function(serial)
        isPlayerNotAllowedToRob[serial] = false
        end, 360000, 1, serial)
    end
)

addEvent("GTIammunationRob.isPlayerAllowedToRob", true)
addEventHandler("GTIammunationRob.isPlayerAllowedToRob", root, function(loc)
    local serial = getPlayerSerial(client)
    if not isPlayerNotAllowedToRob[serial] then
        triggerClientEvent(client, "GTIammunationRob_startRobbery", client, startRobbery)
        exports.GTIhud:dm("You started a robbery, stay inside for 3 minutes to steal the items!", client, 200, 0, 0)
        --[[for i, v in pairs(getElementsByType("player")) do
            if (exports.GTIemployment:getPlayerJob(v, true) == "Police Officer") then
                local r, g, b       = getPlayerNametagColor (v)
                local x, y, z = getElementPosition(client)
                outputChatBox("#1985ff(RADIO) #FFFFFF"..getPlayerName(client).." is attempting to rob an ammunation at "..getZoneName(x, y, z), v, r, g, b, true)
            end
        end]]
    end
end)

function onArrestCancelTheRob()
    triggerClientEvent(source, "GTIammunationRob_cancelRob", source)
end
addEventHandler("onPlayerArrested", root, onArrestCancelTheRob)