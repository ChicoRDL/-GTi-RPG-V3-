local vehicles = {
[573] = true,
[455] = true,
[406] = true,
}
addEvent("GTImining.anim",true)
addEventHandler("GTImining.anim",root,function(anim)
    if anim == 1 then
        exports.GTIanims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, false)
        exports.GTIanims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, true)
    elseif anim == 2 then 
        exports.GTIanims:setJobAnimation(client, "CARRY", "liftup", 1000, true, false, false, false)
    elseif anim == 3 then 
        exports.GTIanims:setJobAnimation(client, "GRENADE", "WEAPON_throwu", 500, true, false, false, false)
    elseif anim == 4 then 
        exports.GTIanims:setJobAnimation(client, "GRENADE", "WEAPON_throwu", 500, true, false, false, false)
    elseif anim == 5 then
        exports.GTIanims:setJobAnimation(client, "BOMBER", "BOM_Plant", 2500, false, false, true, false )
    end
end)

function onEnter ( thePlayer, seat, jacked )
    if isElement(source) and (seat == 0) and (exports.GTIemployment:getPlayerJob(thePlayer,true) == "Quarry Miner") and (exports.GTIrentals:getPlayerRentalVehicle(thePlayer) == source) then 
        local model = getElementModel ( source )
        if vehicles[model] then
            triggerClientEvent ( thePlayer, "GTImining.triggerMission", resourceRoot, source, model )
			exports.GTIhud:dm("Go to the green blips and hit the rocks with your pickaxe!", thePlayer, 255, 255, 0)
        end
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), onEnter )

addEvent("GTImining.freeze", true)
addEventHandler("GTImining.freeze", root, function(fre,grams,id)
    local theveh = exports.GTIrentals:getPlayerRentalVehicle(client) 
    if not theveh then return end
    if fre == false then
        setElementFrozen(theveh,false)
    elseif fre == true then 
        setElementFrozen(theveh,true)
    end
    if grams then
        local account = getPlayerAccount(client)
        exports.GTIemployment:SJD(account, "GTImining.grams", grams)
    end
end )

addEvent("GTImining.remaininggrams", true)
addEventHandler("GTImining.remaininggrams", root, function(getv,grams,id)
local account = getPlayerAccount(client)
    if getv == false then
        exports.GTIemployment:SJD(account, "GTImining.grams", grams)
        setElementData(client, "miner.grams", grams)
    elseif getv == true then
        local gram =  exports.GTIemployment:GJD(account, "GTImining.grams")
        if not gram or gram < 1 then return end
        setElementData(client, "miner.grams", gram)
        triggerClientEvent(client,"GTImining.setGrams",resourceRoot,gram)
    end
end)

addEvent("GTImining.getPayOffset", true)
addEventHandler("GTImining.getPayOffset", root, function()
    local payOff = exports.GTIemployment:getPlayerJobPayment(client, "Quarry Miner")
    triggerClientEvent(client,"GTImining.calculate",resourceRoot,payOff)
end)

addEvent("GTImining.Pay", true)
addEventHandler("GTImining.Pay", root, function(payOffset,grams)
    local pay = exports.GTIemployment:getPlayerJobPayment(client, "Quarry Miner")
    local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
    local hrExp = exports.GTIemployment:getHourlyExperience()
    
    local pay = math.ceil( pay*payOffset )
    local Exp = math.ceil( (pay/hrPay)*hrExp )
    

	setPlayerIron ( client, getPlayerIron ( client ) + Exp )
	exports.GTIhud:drawNote("IronAmount", "+ Iron "..Exp, client, 99, 99, 99, 7500)
    exports.GTIemployment:modifyPlayerJobProgress(client, "Quarry Miner", grams)
    exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Quarry Miner")
    exports.GTIemployment:givePlayerJobMoney(client, "Quarry Miner", pay)
end)

function getPlayerIron ( player )
    local acc = getPlayerAccount ( player )
    local iron = tonumber ( exports.GTIaccounts:GAD ( acc, "iron" ) ) or 0
    return iron
end

function setPlayerIron ( player, amount )
    local acc = getPlayerAccount ( player )
    exports.GTIaccounts:SAD ( acc, "iron", tostring ( amount ) )
    triggerClientEvent ( player, "onIronLoad", player, amount )
    return true
end

function loadIron ( irrelevant, account)
    triggerClientEvent ( source, "onIronLoad", source, getPlayerIron ( source ) )
end
addEventHandler ("onPlayerLogin", root, loadIron )