--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz ~
-- Resource: GTImarket/Client.lua ~
-- Description: <Desc> ~
-- Data: #Market
--<--------------------------------->--

local sale = {}


addEventHandler ( "onClientGUIClick", root,
    function (_, state )
        if ( source == gTable.button[1] ) then -- 'Buy'
            local row, col = guiGridListGetSelectedItem(gTable.grid['public'])
                if not( row ~= -1 or col ~= 0 ) then dm("Select the item you wish to buy first", 255, 125, 0) return end
                    local seller = guiGridListGetItemText(gTable.grid['public'], row, 5)
                    local oldAm = guiGridListGetItemText(gTable.grid['public'], row, 3)
                        if not ( getPlayerName(localPlayer) == seller ) then
                            local units = guiGridListGetItemText(gTable.grid['public'], row, 3)
                            local amount = guiGetText(gTable.edit['atb'])
                                if ( amount ~= "" and amount > units ) then dm("You cannot buy this amount", 255, 125, 0) return end
                                local item = guiGridListGetItemText(gTable.grid['public'], row, 1)
                                local price = guiGridListGetItemData(gTable.grid['public'], row, 2)
                                    if ( not tonumber(amount) ) then dm("You must fill the fields first", 255, 125,0) return end
                                    if tonumber(amount) <= 0 then return end
                                    local stype = guiGridListGetItemText(gTable.grid['public'], row, 4)
                                    triggerServerEvent("GTImarket.buyItem", resourceRoot, item, tonumber(price), tonumber(amount), getPlayerFromName(seller), stype, oldAm)                                        guiSetText(gTable.edit['atb'],"")
                                    buyButton = "Purchase"
                                    guiSetText(gTable.button[1],buyButton)
                        else
                            dm("You cannot buy your own items", 255, 125, 0)
                        end
        elseif ( source == gTable.button[2] ) then -- 'Put for Sale'
            local row = guiGridListGetSelectedItem(gTable.grid['tosell'])
                if not ( row ~= -1 ) then dm("Select the item you wish to put on sale first", 255, 125, 0) return end
                    local item = guiGridListGetItemText(gTable.grid['tosell'], row, 1)
                    local stype = guiGridListGetItemText(gTable.grid['tosell'], row, 2)
                    local amount = guiGridListGetItemText(gTable.grid['tosell'], row, 3)
                    local price = guiGetText(gTable.edit['price'])
                    local ats = guiGetText(gTable.edit['ats'])    
                        if ( price == "" or amount == "" ) then return dm("Fill the fields first", 255, 125, 0) end
                        if ( tonumber(price)  <= 0 or tonumber(amount) <= 0 ) then return end
                        if ( tonumber(ats) <= tonumber(amount) ) then
                            setItemForSale(item, ats, price, stype)
                            guiSetText(gTable.edit['price'],"")
                            guiSetText(gTable.edit['ats'],"")
                        else
                            dm("You don't have this amount of ".. item .." in your inventory", 255, 125, 0)
                        end
                    putButton = "Sell"
                    guiSetText(gTable.button[2],putButton)
        elseif ( source == gTable.button[4] ) then -- 'Remove Selected'
            local rRow = guiGridListGetSelectedItem( gTable.grid['onsale'] )
                if (rRow == -1) then return dm("Select the item you wish to remove first", 255, 125, 0) end     
                    local itemName = guiGridListGetItemText(gTable.grid['onsale'], rRow, 1)
                    local stype = guiGridListGetItemText(gTable.grid['onsale'], rRow, 4)
                    triggerServerEvent("GTImarket.removeRow", localPlayer, itemName, stype)
                    refreshLists()      
        elseif ( source == gTable.button[3] ) then -- 'X'
            showGuis(false)
            status = false
        elseif ( source == gTable.button[5] ) then -- 'Refresh'
            if isTimer(timer) then return end
                timer = setTimer(function() end,5000,1)
                refreshLists()
        end
    end
)

function refreshLists()
    triggerServerEvent("GTImarket.getRows", localPlayer)
end


--[[
m = medkits
c = cocaine
i = iron
h = hemp
]]--
function gotItems(market,ammo,weps,m,c,i,h)
    guiGridListClear(gTable.grid['onsale'])
    guiGridListClear(gTable.grid['tosell'])
    guiGridListClear(gTable.grid['public'])
    for i, v in pairs(market) do
        if isElement(getPlayerFromName(v[1])) then
            if ( v[1] == getPlayerName(localPlayer) ) then
                addToGridlist(v[1], v[2], v[3], v[4],v[5], true)
            else
                addToGridlist(v[1], v[2], v[3], v[4],v[5], false)
        end
    end
    end
        local row = guiGridListAddRow(gTable.grid['tosell'])
        guiGridListSetItemText(gTable.grid['tosell'], row, 1, "Medic Kits", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 2, "Drugs", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 3, m, false, false)
    
        local row = guiGridListAddRow(gTable.grid['tosell'])
        guiGridListSetItemText(gTable.grid['tosell'], row, 1, "Cocaine", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 2, "Drugs", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 3, c, false, false)
        
        local row = guiGridListAddRow(gTable.grid['tosell'])
        guiGridListSetItemText(gTable.grid['tosell'], row, 1, "Iron", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 2, "Materials", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 3, i, false, false)
        
        local row = guiGridListAddRow(gTable.grid['tosell'])
        guiGridListSetItemText(gTable.grid['tosell'], row, 1, "Hemp", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 2, "Materials", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 3, h, false, false)
        
        
    for i,v in pairs(weps) do
        local row = guiGridListAddRow(gTable.grid['tosell'])
        guiGridListSetItemText(gTable.grid['tosell'], row, 1, getWeaponNameFromID(v), false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 2, "Weapon", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 3, "1", false, false)
    end
    for i,v in pairs(ammo) do
        local row = guiGridListAddRow(gTable.grid['tosell'])
        guiGridListSetItemText(gTable.grid['tosell'], row, 1, getWeaponNameFromID(v[1]), false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 2, "Ammo", false, false)
        guiGridListSetItemText(gTable.grid['tosell'], row, 3, v[2], false, false)
    end
end
addEvent("GTImarket.gotItems", true)
addEventHandler("GTImarket.gotItems", root, gotItems)
function addToGridlist(seller, item, units, price, stype, val)
    local row = guiGridListAddRow(gTable.grid['public'])
    guiGridListSetItemText(gTable.grid['public'], row, 1, item, false, false)
    guiGridListSetItemText(gTable.grid['public'], row, 2, "$"..exports.GTIutil:tocomma(price), false, false)
    guiGridListSetItemText(gTable.grid['public'], row, 3, units, false, false)
    guiGridListSetItemText(gTable.grid['public'], row, 5, seller, false, false) 
    guiGridListSetItemText(gTable.grid['public'], row, 4, stype, false, false) 
    guiGridListSetItemData(gTable.grid['public'], row, 2, price)

    if ( val == true ) then
    local row1 = guiGridListAddRow(gTable.grid['onsale'])
    guiGridListSetItemText(gTable.grid['onsale'], row1, 1, item, false, false)
        guiGridListSetItemText(gTable.grid['onsale'], row1, 2, "$"..exports.GTIutil:tocomma(price), false, false)
    guiGridListSetItemText(gTable.grid['onsale'], row1, 3, units, false, false)
    guiGridListSetItemText(gTable.grid['onsale'], row1, 4, stype, false, false)
    end
end

addEventHandler("onClientGUIChanged", root,
function(element)
    if ( element == gTable.edit['ats'] or element == gTable.edit['price']) then
    local amount = tonumber(guiGetText(gTable.edit['ats']))
    local price = tonumber(guiGetText(gTable.edit['price']))
    if ( not price ) then guiSetText(gTable.edit['price'],"") end
    if ( not amount ) then guiSetText(gTable.edit['ats'],"") end
    
    if (amount and price) then
        local math = exports.GTIutil:tocomma(amount * price)
        putButton = "Sell ($"..math..")"
    else
        putButton = "Sell"
    end
        guiSetText(gTable.button[2],putButton)
    
    elseif ( element == gTable.edit['atb'] ) then
    local amount = tonumber(guiGetText(gTable.edit['atb']))
    if ( not amount ) then guiSetText(gTable.edit['atb'],"") return end
    local row = guiGridListGetSelectedItem(gTable.grid['public'])
    local price = guiGridListGetItemData(gTable.grid['public'], row, 2)
    
    if ( amount and price) then
        local math = exports.GTIutil:tocomma(amount * price)
        buyButton = "Purchase ($"..math..")"
    else
        buyButton = "Purchase"
    end
        guiSetText(gTable.button[1],buyButton)
    end
end
)

addEvent("GTImarket.refresh", true)
addEventHandler("GTImarket.refresh", root, refreshLists)

function show(market,ammo,weps, meds, coke, iron, hemp)
    if ( status ) then
        showGuis(false)
        status = false
        return
    end

    showGuis(true)
    buyButton = "Purchase"
    guiSetText(gTable.button[1],buyButton)
    putButton = "Sell"
    guiSetText(gTable.button[2],putButton)
    gotItems(market,ammo,weps,meds,coke,iron,hemp)
    status = true   
end
addEvent("GTImarket.showGui", true)
addEventHandler("GTImarket.showGui", root, show)

function hide()
    showGuis(false)
    status = false
end
addEvent("GTImarket.hideGui",true)
addEventHandler("GTImarket.hideGui",root,hide)

----->> Utils
------------->>

function setItemForSale(item, units, price, stype)
    if ( item and units and price ) then
    triggerServerEvent("GTImarket.setForSale", localPlayer, item, units, price, stype)
    refreshLists()
    end
end

function showGuis(bool)
    if bool == true then
        guiSetVisible(gTable.window[1],true)
        showCursor(true)
    else
        guiSetVisible(gTable.window[1],false)
        showCursor(false)
    end
end
addEventHandler("onClientPlayerWasted",localPlayer,function() showGuis(false) end)
addEventHandler("onClientMarkerLeave",resourceRoot,function(hit)
    if hit == localPlayer then
        showGuis(false)
    end
end)

function isItemWeapon(item)
    return getWeaponNameFromID(item) ~= "Fist"
end

function dm (t, r, g, b)
    if ( t and r and g and b ) then
    exports.GTIhud:dm(t, r, g, b)
    end
end
