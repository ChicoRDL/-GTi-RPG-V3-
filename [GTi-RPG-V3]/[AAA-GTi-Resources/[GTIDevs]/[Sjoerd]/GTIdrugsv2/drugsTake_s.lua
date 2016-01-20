
function setHealth(plr, amount)
    setPedStat(plr, 24, amount)
end
addEvent("drugs.sethealth", true)
addEventHandler("drugs.sethealth", root, setHealth)

function sethealthBack(plr, amount)
    setPedStat(plr, 24, amount)
    local health = getElementHealth(plr)
    if (health > 99) then
        setElementHealth(plr, 100)
    end    
end
addEvent("drugs.sethealthBack", true)
addEventHandler("drugs.sethealthBack", root, sethealthBack)

ecstasy = {}

function Ecstasy(plr, enabled)
    if enabled then
        addEventHandler("onPlayerDamage",plr,lessDamage)
        ecstasy[plr] = true
    else
        removeEventHandler("onPlayerDamage",plr,lessDamage)
        ecstasy[plr] = nil
    end
end
addEvent("drugs.Ecstasy", true)
addEventHandler("drugs.Ecstasy", root, Ecstasy)

function lessDamage( attacker, weapon, bodypart, loss )
    if loss and ecstasy[source] then
        cancelEvent()
        local health = getElementHealth(source)+(loss*0.25)
        setElementHealth(source,health)
    end
end

function takeDrug(plr, cmd, drug, amount)
    local amount = tonumber(amount)
    if (type(amount) == "number") and (amount >= 1) then
        if (isElement(plr)) then
            local drugAmount = tonumber(getPlayerDrugAmount(plr, drug))
            if (drugAmount >= amount) then
                triggerClientEvent("drugs.takeDrug", plr, plr, drug, amount)
                takePlayerDrug(plr, drug, amount)
            else
                exports.GTIhud:dm("You don't have enough hits left.", plr, 255, 0, 0)
            end    
        end
    end    
end
