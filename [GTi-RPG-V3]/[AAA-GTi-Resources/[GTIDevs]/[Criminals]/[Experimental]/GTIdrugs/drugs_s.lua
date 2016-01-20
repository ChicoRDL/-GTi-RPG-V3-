valid_drugs = {
    { "Cocaine"},
    { "Ecstasy"},
    { "Oxycodone"},
    { "Marijuana"},
    { "Tylenol"},
    { "Meth"},
}

function getAllDrugs( thePlayer, theAccount)
    --triggerClientEvent( thePlayer, "GTIdrugs.refreshClient", thePlayer)
    for i, v in ipairs (valid_drugs) do
        local drugData = GDD( theAccount, v[1])
        if drugData then
            triggerClientEvent( thePlayer, "GTIdrugs.getDrugs", thePlayer, v[1], drugData)
        else
            SDD( theAccount, v[1], 0)
        end
    end
end

function queryLogIn( state)
    local account = getPlayerAccount( source)
    local accountName = getAccountName( account)
    if not isGuestAccount( account) then
        triggerClientEvent( source, "GTIdrugs.viewGUI", source)
        if not state then
            getAllDrugs( source, account)
        end
    end
end
addEvent( "GTIdrugs.QueryAccount", true)
addEventHandler( "GTIdrugs.QueryAccount", root, queryLogIn)

function executeDrugEvent( theEvent, theDrug, theData)
    --triggerClientEvent( source, "GTIdrugs.refreshClient", source)
    --
    if not theEvent then return end
    if theEvent == "consumeDrug" then
        takePlayerDrug( source, theDrug, tonumber(theData))
    end
end
addEvent( "GTIdrugs.executeDrugEvent", true)
addEventHandler( "GTIdrugs.executeDrugEvent", root, executeDrugEvent)

function givePlayerDrug( player, drug, amount)
    if isElement( player) then
        if tonumber(amount) then
            local account = getPlayerAccount(player)
            local amount = math.floor(amount)
            if not isGuestAccount(account) then
                local currentAmount = GDD( account, drug) or 0
                if currentAmount == 0 then
                    SDD( account, drug, amount)
                else
                    SDD( account, drug, currentAmount+amount)
                end
                getAllDrugs( player, account)
            end
        end
    end
end

function takePlayerDrug( player, drug, amount)
    if isElement( player) then
        if tonumber(amount) then
            local account = getPlayerAccount(player)
            local amount = math.floor(amount)
            if not isGuestAccount(account) then
                local currentAmount = GDD( account, drug) or 0
                if currentAmount ~= 0 then
                    SDD( account, drug, currentAmount-amount)
                end
                getAllDrugs( player, account)
            end
        end
    end
end
addEvent("GTIdrugs.takePlayerDrug", true)
addEventHandler("GTIdrugs.takePlayerDrug", root, takePlayerDrug)

function getPlayerDrugAmount(player, drug)
    if isElement( player) then
        local account = getPlayerAccount(player)
        if not isGuestAccount(account) then
            local currentAmount = GDD( account, drug) or 0
            return currentAmount
        end
    end
end


function getServerTime(plr)
    local hour, minutes = getTime()
    triggerClientEvent("GTIdrugs.setTime", root, plr, hour, minutes)
end
addEvent("GTIdrugs.getServerTime", true)
addEventHandler("GTIdrugs.getServerTime", root, getServerTime)
