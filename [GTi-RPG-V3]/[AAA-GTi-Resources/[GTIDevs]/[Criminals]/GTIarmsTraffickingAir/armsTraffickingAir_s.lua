----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Date: 11 Feb 2015
-- Resource: armsTraffickingAir_s.lua
-- Version: 1.0
----------------------------------------->>

addEventHandler( "onPlayerCommand", root,
    function( cmd )
        if cmd == "hide" then
            --local job = exports.GTIemployment:getPlayerJob(source, true)
            if (exports.AresMisc:isAbleToCrime ( source )) then
                triggerClientEvent(source,"GTIarmsTrafficking_onPlaneHide", source)
            end
        end
    end    
)

local LOWER_BOUND = 0.75
local UPPER_BOUND = 1.25
local SHOTGUN_AMMO = 35		-- Median Shotgun Ammo Earned
local SMG_AMMO = 125		-- Median SMG Ammo Earned

addEvent ("GTIarmsTrafficking_payOutForPlane", true )
addEventHandler ("GTIarmsTrafficking_payOutForPlane", root,
    function ( )
	    local money = math.random(4175*LOWER_BOUND, 4175*UPPER_BOUND)
	    exports.GTIcriminals:givePlayerTaskMoney(client, "Arms Trafficking", money)
	    exports.GTIcriminals:modifyPlayerCriminalRep(client, 1075, "Arms Trafficking")
	    exports.GTIcriminals:modifyPlayerTaskProgress(client, "Arms Trafficking", 1)
		-- Shotguns -->>
        --[[local wep = getPedWeapon(client, 3)
        local cur_ammo = getPedTotalAmmo(client, 3)
            -- Pick Weapon
        if (wep ~= 27 and wep ~= 26 or cur_ammo == 0) then
            wep = 25
        end
            -- Impose Ammo Limit
        local ammo = math.random(SHOTGUN_AMMO*LOWER_BOUND, SHOTGUN_AMMO*UPPER_BOUND)
        local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(wep)
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
        local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(wep)
        if (cur_ammo + ammo > max_ammo) then ammo = max_ammo - cur_ammo end
        if (ammo < 0) then ammo = 0 end
        
        giveWeapon(client, wep, ammo, false)
        exports.GTIhud:drawNote("MP5", "+ "..ammo.." "..getWeaponNameFromID(wep).." Ammo", client, 0, 255, 0, 7500)--]]
	end
)
