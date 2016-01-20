local market = {}
local DEF_PROJECILES = "16,17,18,39"
local val = false
local markers = {
{1091.739, -1511.446, 14.798},
{1986.970, 2068.618, 9.831},
}

function setItemForSale(item, units, price, stype)
    if (wasWeaponRented(client, getWeaponIDFromName(item))) then
        dm("You cannot sell a weapon you rented.", client, 255, 125, 0)
        return
    end
    
    if (stype == "Ammo" or stype == "Weapon") then
        local slot = getSlotFromWeapon(getWeaponIDFromName(item))
        if (slot == 1) or (slot == 9) or (slot == 11) or (slot == 12) or (slot == 10) then dm("You cannot sell melee weapons.",client,255,0,0) return end
        if isPlayerAlreadySelling(getPlayerName(client),item) then return end
        if stype == "Ammo" and getWeaponIDFromName(item) == 37 then dm("Due to a MTA bug, you annot sell flamethrower ammo.",client,255,0,0) return end
        if stype == "Weapon" and not canPlayerSellWeapon(client,getWeaponIDFromName(item)) then dm("You must sell ammo to be able to sell this weapon.",client,255,0,0) return end
    end
    table.insert(market,{getPlayerName(client), item, tonumber(units), tonumber(price), stype})
    dm("Set "..units.." of "..item.." for sale ($"..price..")", client, 40, 85, 255)
end
addEvent("GTImarket.setForSale", true)
addEventHandler("GTImarket.setForSale", root, setItemForSale)

function getItems()
    local weps = getWeaponsInventory(client)
    local ammo = getPlayerWeapons(client)
    local m = exports.GTImedKits:getPlayerMedKits(client)
    local c = exports.GTIdrugsv2:getPlayerDrugAmount(client, "Cocaine")
    local i = exports.GTImining:getPlayerIron(client)
    local h = exports.GTIfarmer:getPlayerHemp(client)
    
    triggerClientEvent(client, "GTImarket.gotItems", resourceRoot, market, ammo, weps, m, c, i, h)
end
addEvent("GTImarket.getRows", true)
addEventHandler("GTImarket.getRows", root, getItems)

function refresh(plr, bought)
    local weps = getWeaponsInventory(client)
    local ammo = getPlayerWeapons(client)
    triggerClientEvent(client, "GTImarket.gotItems", resourceRoot, market, ammo, weps)
end

function buyItem(item, priceunit, amount, seller, stype, oldAm)
    if not isElement(seller) then return end
    if isPedDead(seller) then return end
    local price = priceunit*amount

    if stype == "Weapon" then
        if not canPlayerSellWeapon(seller,getWeaponIDFromName(item)) then 
            removePublicRow(item,getPlayerName(seller))
            --dm("Refreshing...", client, 255, 125, 0)            
            local newAm = oldAm - amount
            if (newAm > 0) then
                refresh(client, newAm)
            else
                refresh(client)
            end    
            return 
        end
        if (doesPlayerOwnGun(client, getWeaponIDFromName(item))) then
            dm("You already own this weapon.", client, 255, 125, 0)
            return
        end
        if pay(client,seller,amount,item,price) then 
            removeWeaponFromInventory(seller,getWeaponIDFromName(item))
            addWeaponToInventory(client,getWeaponIDFromName(item))
            updateRowFromTable(getPlayerName(seller),item,amount)
            local newAm = oldAm - amount
            if (newAm > 0) then
                refresh(client, newAm)
            else
                refresh(client)
            end
            return true
        end
    elseif stype == "Ammo" then
        if getSlotFromWeapon(getWeaponIDFromName(item)) ~= 8 and not (doesPlayerOwnGun(client, getWeaponIDFromName(item))) then
            dm("You don't own this weapon.", client, 255, 125, 0)
            number = 1
            return
        end
        if not (doesPlayerOwnGunAmmo(seller,item,amount)) then
            removePublicRow(item,getPlayerName(seller))
            --dm("Refreshing...", client, 255, 125, 0)
            local newAm = oldAm - amount
            if (newAm > 0) then
                refresh(client, newAm)
            else
                refresh(client)
            end
            return
        end
        local aboveLimit,overage,limit = isAboveAmmoLimit(client, getWeaponIDFromName(item), amount)
        if (aboveLimit) then
            dm("Purchase cannot be processed. You are "..overage.." bullets over the "..limit.." bullet limit.", client, 255, 125, 0)
            return
        end
        if pay(client,seller,amount,item,price) then 
            -- Take Previous Weapon
            local slot = getSlotFromWeapon(getWeaponIDFromName(item))
            local cur_weapon = getPedWeapon(client, slot)
            if (cur_weapon ~= getWeaponIDFromName(item)) then
                local cur_ammo = getPedTotalAmmo(client, slot)
                exports.GTIweapons:updateWeaponInInventory(client, cur_weapon, cur_ammo)
                takeWeapon(client, cur_weapon)
            end
            
            -- Give New Weapon
            local ammo = 0
            if (cur_weapon ~= getWeaponIDFromName(item)) then
                ammo = exports.GTIweapons:getWeaponAmmoFromInventory(client, getWeaponIDFromName(item))
            end
            giveWeapon(client, getWeaponIDFromName(item), amount+ammo, true)
            takeWeapon(seller, getWeaponIDFromName(item), amount)
            updateRowFromTable(getPlayerName(seller),item,amount)
            local newAm = oldAm - amount
            if (newAm > 0) then
                refresh(client, newAm)
            else
                refresh(client)
            end
        end
    elseif stype == "Drugs" then
        if (item == "Medic Kits") then
            removePublicRow(item,getPlayerName(seller))
            triggerClientEvent(client, "GTImarket.refresh", client)
            pay(client,seller,amount,item,price)    
            local oldS = exports.GTImedKits:getPlayerMedKits(seller)
            local newS = exports.GTImedKits:setPlayerMedKits(seller, oldS - amount)
                
            local oldB = exports.GTImedKits:getPlayerMedKits(client)
            local newB = exports.GTImedKits:setPlayerMedKits(client, oldB + amount)
            
            if (newAm > 0) then
                refresh(client, newAm)
            else
                refresh(client)
            end
        elseif (item == "Cocaine") then  
            removePublicRow(item,getPlayerName(seller))
            triggerClientEvent(client, "GTImarket.refresh", client)
            pay(client,seller,amount,item,price)
              
            exports.GTIdrugsv2:takePlayerDrug(seller, "Cocaine", amount)
            exports.GTIdrugsv2:givePlayerDrug(client, "Cocaine", amount)
            
            if (newAm > 0) then
                refresh(client, newAm)
            else
                refresh(client)
            end
        end    
    elseif stype == "Materials" then
        elseif (item == "Iron") then
            removePublicRow(item,getPlayerName(seller))
            triggerClientEvent(client, "GTImarket.refresh", client)
            pay(client,seller,amount,item,price)
            local oldS = exports.GTImining:getPlayerIron(seller)
            local newS = exports.GTImining:setPlayerIron(seller, oldS - amount)
              
            local oldB = exports.GTImining:getPlayerIron(client)
            local newB = exports.GTImining:setPlayerIron(client, oldB + amount)
            
            if (newAm > 0) then
                refresh(client, newAm)
            else
                refresh(client)
            end
        elseif (item == "Hemp") then  
            removePublicRow(item,getPlayerName(seller))
            triggerClientEvent(client, "GTImarket.refresh", client)
            pay(client,seller,amount,item,price)
            local oldS = exports.GTIfarmer:getPlayerHemp(seller)
            local newS = exports.GTIfarmer:setPlayerHemp(seller, oldS - amount)
              
            local oldB = exports.GTIfarmer:getPlayerHemp(client)
            local newB = exports.GTIfarmer:setPlayerHemp(client, oldB + amount)
            
            if (newAm > 0) then
                refresh(client, newAm)
            else
                refresh(client)
            end
        end
        --end
    exports.GTIlogs:outputAccountLog("Bought "..item.."("..stype..") for "..price.."$ from "..getPlayerName(seller),"Market",client)
    exports.GTIlogs:outputAccountLog("Sold "..item.."("..stype..") for "..price.."$ to "..getPlayerName(client),"Market",seller)
end
addEvent("GTImarket.buyItem", true)
addEventHandler("GTImarket.buyItem", root, buyItem)

function pay(buyer,seller,amount,item,price)
    local playerMoney = getPlayerMoney(buyer)
    if ( playerMoney >= price ) then
        exports.GTIbank:GPM(seller, price, "Market: Sold "..amount.." of "..item)
        dm(getPlayerName(buyer).." bought "..amount.." unit(s) of your "..item, seller, 0, 125, 90)
            
        exports.GTIbank:TPM(buyer, price, "Market: Bought "..amount.." of "..item)
        dm("You have bought "..amount.." unit(s) of "..item, buyer, 0, 125, 90)
        return true
    else
        dm("You do not have enough money to buy this item", buyer, 255, 125, 0)
        return false
    end
end
function removeRow(itemName)
local name = getPlayerName(client)
    removeRowFromTable(name,itemName)
end
addEvent("GTImarket.removeRow", true)
addEventHandler("GTImarket.removeRow", root, removeRow)

function removePublicRow(itemName, seller)
removeRowFromTable(seller,itemName)
end
addEvent("GTImarket.removePublicRow", true)
addEventHandler("GTImarket.removePublicRow", root, removePublicRow)

function removeRowFromTable(name,item)
    for i, v in pairs(market) do
        if v[1] == name and v[2] == item then
            table.remove(market,i)
            break
        end
    end
end
function updateRowFromTable(name,item,amount)
    for i, v in pairs(market) do
        if v[1] == name and v[2] == item then
            if v[3] <= amount then
                table.remove(market,i)
            else
                market[i][3] = v[3] - amount
            end
            break
        end
    end
end
function removeRowsFromTable(name)
    for i, v in pairs(market) do
        if v[1] == name then
            table.remove(market,i)
        end
    end
end

--[[function createMarkers()
        for i,v in pairs(markers) do
            local x,y,z = v[1], v[2], v[3]
            local marker = createMarker(x, y, z, "cylinder", 1.5, 255, 125, 0, 170 )
            addEventHandler("onMarkerHit",marker,showGui)
            addEventHandler("onMarkerLeave",marker,hideGui)
        end
end
addEventHandler("onResourceStart", resourceRoot, createMarkers)--]]

function bindthekeylogin(res)
    bindKey(source, "F7", "down", showGui)
    
end
addEventHandler("onPlayerLogin", root, bindthekeylogin)

function onResourceStartBind ( )
    for i,v in ipairs ( getElementsByType ("player") ) do
        bindKey ( v, "F7", "down", showGui )
    end
end
addEventHandler ("onResourceStart", resourceRoot, onResourceStartBind )

function onChangeNick(oldNick, newNick)
    for i, v in pairs(market) do
        if v[1] == oldNick then
            market[i][1] = newNick
        end
    end
end
addEventHandler("onPlayerChangeNick", root, onChangeNick)

function onPlayerQuit()
    removeRowsFromTable(getPlayerName(source))
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

function showGui(hit)
    if ( getElementType(hit) == "player" ) then
        local weps = getWeaponsInventory(hit)
        local ammo = getPlayerWeapons(hit)
        local m = exports.GTImedKits:getPlayerMedKits(hit)
        local c = exports.GTIdrugsv2:getPlayerDrugAmount(hit, "Cocaine")
        local i = exports.GTImining:getPlayerIron(hit)
        local h = exports.GTIfarmer:getPlayerHemp(hit)
        triggerClientEvent(hit, "GTImarket.showGui", hit, market, ammo, weps, m, c, i, h)
    end
end

function hideGui(hit)
    if (getElementType(hit) == "player") then
        triggerClientEvent(hit,"GTImarket.hideGui",hit)
    end
end

----->> Utils
------------->>

function dm (t, p, r, g, b)
    if ( t and p and r and g and b ) then
        exports.GTIhud:dm(t, p, r, g, b)
    end
end

function isItemWeapon(item)
    return getWeaponNameFromID(item) ~= "Fist"
end

function refreshLists(val)
triggerClientEvent(val, "GTImarket.refresh", val)
end


function doesPlayerOwnGunAmmo(player,gun,unit)
    for i, v in ipairs(market) do
        if isElement(player) and v[1] == getPlayerName(player) and v[2] == gun then
            local wep = getWeaponIDFromName(gun)
            if ( v[3] >= unit ) and getPedTotalAmmo(player,getSlotFromWeapon(wep)) >= unit then
                return true
            else
                return false
            end
        end
    end
end
function wasWeaponRented(player, weapon)
    if (not isElement(player) or not weapon or type(weapon) ~= "number") then return false end
    local rentals = exports.GTIrentals:getRentedWeapons(player)
    for i,weap in ipairs(rentals) do
        if (weap == weapon) then return true end
    end
    return false
end

function doesPlayerOwnGun(player, weapon)
    if (not isElement(player) or not weapon or type(weapon) ~= "number") then return false end
    local rentals = getWeaponsInventory(player)
    for i,weap in ipairs(rentals) do
        if (weap == weapon) then return true end
    end
    return false
end

function addWeaponToInventory(player, weapon)
    if (not isElement(player)) then return false end
    local account = getPlayerAccount(player)
    local plr_inv = exports.GTIaccounts:invGet(account, "ammu.inventory") or DEF_PROJECILES
    plr_inv = split(plr_inv, ",")
    
    for i,v in ipairs(plr_inv) do
        plr_inv[i] = tonumber(v)
        if (weapon == plr_inv[i]) then return false end
    end
    table.insert(plr_inv, weapon)
    table.sort(plr_inv)
    
    plr_inv = table.concat(plr_inv, ",")
    exports.GTIaccounts:invSet(account, "ammu.inventory", plr_inv)
    return true
end
function removeWeaponFromInventory(player, weapon)
    if (not isElement(player)) then return false end
    local account = getPlayerAccount(player)
    local plr_inv = exports.GTIaccounts:invGet(account, "ammu.inventory") or DEF_PROJECILES
    plr_inv = split(plr_inv, ",")
    
    for i,v in ipairs(plr_inv) do
        if (weapon == tonumber(v)) then 
            table.remove(plr_inv,i)
        end
    end
    table.sort(plr_inv)
    
    plr_inv = table.concat(plr_inv, ",")
    exports.GTIaccounts:invSet(account, "ammu.inventory", plr_inv)
    return true
end
function isPlayerAlreadySelling(name,item)
    for i, v in pairs(market) do
        if v[1] == name and v[2] == item then
            return true
        end
    end
    return false
end
function getWeaponsInventory(player)
    if (not isElement(player)) then return false end
    local account = getPlayerAccount(player)
    local plr_inv1 = exports.GTIaccounts:invGet(account, "ammu.inventory") or DEF_PROJECILES
    plr_inv = split(plr_inv1, ",")
    
    inventory = {}
    for i,v in ipairs(plr_inv) do
        local slot = getSlotFromWeapon(tonumber(v))
        if slot ~= 8 and slot ~= 12 then
            table.insert(inventory,tonumber(v))
        end
    end
    return inventory
end
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

function getPlayerWeapons(plr)
    local weapons = {}
    for i=0,11 do
        local weapon = getPedWeapon(plr, i)
        local ammo = getPedTotalAmmo(plr, i)
        if (weapon ~= 0 and ammo > 0) then
            table.insert(weapons, {weapon, ammo})
        end
    end
    return weapons
end
function canPlayerSellWeapon(plr,wep)
    local invAmmo = exports.GTIweapons:getWeaponAmmoFromInventory(client, wep) or 0
    for i=0,11 do
        local weapon = getPedWeapon(plr, i)
        local ammo = getPedTotalAmmo(plr, i)
        if (weapon == wep and ammo > 0) or invAmmo > 0 then
            return false
        end
    end
    return true
end