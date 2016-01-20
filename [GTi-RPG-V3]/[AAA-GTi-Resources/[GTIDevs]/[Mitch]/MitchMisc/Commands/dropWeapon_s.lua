local disallowedWeps = {
    [1] = true, -- Brass Knuckles
        [2] = true, -- Golf club
        [3] = true, -- Nightstick
        [4] = true, -- Knife
        [5] = true, -- Baseball Bat
        [6] = true, -- Shovel
        [7] = true, -- Pool Cue
        [8] = true, -- Katana
        [9] = true,  -- Chainsaw
        [41] = true, -- Spraycan
        [42] = true, -- Fire Extinghuisher
        [10] = true, -- Long Purple Dildo
        [11] = true, -- Short tan Dildo
        [12] = true, -- Vibrator
        [14] = true, -- Flowers
        [15] = true, -- Cane
        [40] = true, -- Satchel Detonator
		[46] = true, -- Parachute
        [45] = true, -- night
        [44] = true, -- ^^
        [37] = true, -- Flamethrower for some reason it multiplies.
}
 
dropp = {}
 
function drop ( player, cmd, amount )
    if ( isElement(dropp[player])) then exports.GTIhud:dm("Pickup your dropped weapon first before dropping more!", player, 200, 0, 0 ) return end
    if isPedInVehicle ( player ) then exports.GTIhud:dm("You can't use this command while being in a vehicle!", player, 200, 0, 0 ) return end
        if isCursorShowing(player) then return end
        if not getElementDimension ( player ) == 0 then exports.GTIhud:dm("You can't use this command while being in an interior!", player, 200, 0, 0 ) return end
        --if pickupFalse == true then exports.GTIhud:dm("Pickup the dropped weapon before dropping another weapon!", player, 200, 0, 0 ) return end
        if not isPedOnGround ( player ) then exports.GTIhud:dm("You can't use this command while flying", player, 200, 0, 0 ) return end
    local x,y,z = getElementPosition ( player )
    local weapon = getPedWeapon ( player )
    local ammo = getPedTotalAmmo ( player )
    local amount = tonumber ( amount )
        if ( type ( amount ) == "number") and ( amount >= 1 ) then
        if ammo >= amount then
                if ( getPedWeapon ( player, getSlotFromWeapon ( weapon ) ) == 0 ) then exports.GTIhud:dm("Scroll to a weapon you would like to drop!", player, 200, 0, 0 ) return end
                if ( disallowedWeps [getPedWeapon(player)] ) or wasWeaponRented(player,getPedWeapon(player)) then exports.GTIhud:dm("You can't drop this weapon!", player, 200, 0, 0 ) return end
            takeWeapon ( player, weapon, amount )
            dropp[player] = createPickup ( x, y+3, z, 2, weapon, 5000, amount )
                        setElementID ( dropp[player], "WeaponPickUp" )
                        setElementData(dropp[player], "markerOwner", player)
                        setElementData(dropp[player], "amount", amount)
                        --Now to set the interior + dimension (YOU FORGOT, MITCH!) - Jack
                        setElementInterior(dropp[player],getElementInterior(player))
                        setElementDimension(dropp[player],getElementDimension(player))
                    exports.GTIhud:dm("You dropped your weapon, Ammo: "..amount, player, 0, 200, 0 )
        else
                exports.GTIhud:dm("You don't have enough ammo!", player, 200, 0, 0 )
        end
    end
end
addCommandHandler ("dropwep", drop )
 
addEventHandler ("onPickupHit", root,
        function ( player )
                if getElementID ( source ) == "WeaponPickUp" and getElementType(player) == "player" then
                        local amount = getElementData(source, "amount")
                        local owner = getElementData(source, "markerOwner")
            local weapon = getPickupWeapon ( source )
                        local aboveLimit,overage,limit = isAboveAmmoLimit(player, weapon, amount)
                        if (aboveLimit) then
                                exports.GTIhud:dm("You are "..overage.." bullets over the "..limit.." bullet limit.", player, 255, 125, 0)
                                cancelEvent()
                                return
                        end
                        if not (doesPlayerOwnGun(player, weapon)) then
                                exports.GTIhud:dm("You don't own this weapon.", player, 255, 125, 0)
                                cancelEvent()
                                return
                        end
                        if isElement(owner) then
                                exports.GTIhud:dm("You picked ammo "..amount.." from "..getPlayerName(owner), player, 0, 200, 0 )
                        end
                        setTimer ( destroyElement, 50, 1, source )
                        if isElement ( dropp[player] ) then
                        dropp[player] = nil
                end
        end
end
)
 
function isAboveAmmoLimit(player, weap, amount)
        local slot = getSlotFromWeapon(weap)
        local weapon, ammo = getPedWeapon(player, slot), 0
        if (weapon == weap) then
                ammo = getPedTotalAmmo(player, slot)
        else
                ammo = exports.GTIweapons:getWeaponAmmoFromInventory(player, weap)
        end
       
        local limit = exports.GTIweapons:getWeaponMaxAmmo(player, weap)
        if ((ammo + amount) > limit) then
                return true, ammo + amount - limit, limit
        else
                return false
        end
end
local DEF_PROJECILES = "16,17,18,39"
function getWeaponsInventory(player)
        if (not isElement(player)) then return false end
        local account = getPlayerAccount(player)
        local plr_inv1 = exports.GTIaccounts:invGet(account, "ammu.inventory") or DEF_PROJECILES
        plr_inv = split(plr_inv1, ",")
       
        inventory = {}
        for i,v in ipairs(plr_inv) do
                local slot = getSlotFromWeapon(tonumber(v))
                if slot ~= 12 then
                        table.insert(inventory,tonumber(v))
                end
        end
        return inventory
end
function doesPlayerOwnGun(player, weapon)
        if (not isElement(player) or not weapon or type(weapon) ~= "number") then return false end
        local inv = getWeaponsInventory(player)
        for i,weap in ipairs(inv) do
                if (weap == weapon) then return true end
        end
        return false
end
function wasWeaponRented(player, weapon)
        if (not isElement(player) or not weapon or type(weapon) ~= "number") then return false end
        local rentals = exports.GTIrentals:getRentedWeapons(player)
        for i,weap in ipairs(rentals) do
                if (weap == weapon) then return true end
        end
        return false
end