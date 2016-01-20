local drugLabs, drugSearching, tick, labMarker = {}, {}, {}, {}
local drugWait = 10 * 60 * 1000
local drugCost = 2000
local lookTimer = 3000
local drugAmounts = {["Cocaine"]=10, ["Oxycodone"]=10, ["Marijuana"]=15, ["Tylenol"]=10, ["Ecstasy"] = 10, ["Meth"] = 10}
local goesWrong = 1
local failtimer = {}

function createDrugLab(drug)
    if (not isPedOnGround(client)) then return end
    local x, y, z = getElementPosition(client)
    if (z >= 45) then
        exports.GTIhud:dm("You are standing too high to set up a drug lab", client, 255, 0, 0)
        return
    end
    if (not isPedOnGround(client)) then
        exports.GTIhud:dm("Drug labs can only be made on the ground", client, 255, 0, 0)
        return
    end
    if (not exports.GTIutil:isPlayerInTeam(client, "Criminals")) then
        exports.GTIhud:dm("You can only make a drug lab as criminal", client, 255, 0, 0)
        return
    end
    if (exports.GTIemployment:getPlayerJob(client, true) == "Gangster") then
        exports.GTIhud:dm("You can only make a drug lab as criminal", client, 255, 0, 0)
        return
    end
    local theTick = getTickCount()
    local serial = getPlayerSerial(client)
    if (tick[serial] and theTick - tick[serial] < drugWait) then
        local milliseconds = theTick - tick[serial]
        local seconds = math.ceil(milliseconds / 1000)
        local minutes = math.ceil(seconds / 60)
        exports.GTIhud:dm("You need to wait 10 minutes, you've only waited "..math.ceil(minutes) .." minutes ("..math.ceil(seconds).." seconds)", client, 255, 0, 0)
        return
    end
    if (getPlayerMoney(client) <= drugCost) then
        exports.GTIhud:dm("Making a drug lab costs $2,000", 255, 0, 0)
        return
    end
    local marker = createMarker(x, y, z - 1, "cylinder", 5, 0, 100, 255, 0)
    labMarker[marker] = {client, drug}
    drugLabs[client] = {createObject(1457, x, y, z), x, y, z, drug, marker}
    triggerClientEvent("GTIdruglab.makeObjectUnbreakable", root, drugLabs[client][1])
    triggerClientEvent(client, "GTIdruglab.makeDrugs2", client)
    tick[serial] = getTickCount()
    setPlayerNametagShowing(client, false)
    local randomEvent = math.random(0, 10)
    local randomEvent2 = math.random(0, 10)
    if randomEvent == randomEvent2 then
        failtimer[client] = setTimer(failLab, 20000, 1, client)
    end    
    exports.GTIhud:dm("Started to make "..drugAmounts[drug].." hits of "..drug, client, 255, 255, 0)
    exports.GTIbank:TPM(client, drugCost, "drug lab cost")
    addEventHandler("onMarkerHit", marker, givePoliceDrugs)
end
addEvent("GTIdruglab.createDrugLab", true)
addEventHandler("GTIdruglab.createDrugLab", root, createDrugLab)

function failLab(p)
    if (isElement(p) and drugLabs[p]) then
        local x, y, z = getElementPosition(p)
        createExplosion(x, y, z, 2)
        exports.GTIhud:dm("Something went wrong and caused an explosion.", p, 255, 0, 0)
        killDrugLab(p)
    end
end    

function drugMade(drug)
    if (not drug) then return end
    labs = drugLabs[client]
    for index, plr in pairs(getElementsByType("player")) do
        drugSearching[plr] = false
        if (exports.GTIutil:isPlayerInTeam(plr, "Law Enforcement")) then
            local x, y, z = getElementPosition(plr)
            if (getDistanceBetweenPoints2D(labs[2], labs[3], x, y) <= 400 and not drugSearching[plr]) then
                exports.GTIhud:dm("You were too late finding the druglab.", plr, 255, 0, 0)
            end
        end
    end
    local x, y, z = getElementPosition(client)
    if (getDistanceBetweenPoints2D(labs[2], labs[3], x, y) <= 3) then
        exports.GTIhud:dm("Succesfully made "..drugAmounts[drug].." hits of "..drug, client, 0, 255, 0)
        exports.GTIdrugs:givePlayerDrug(client, drug, drugAmounts[drug])
    else
        killPed(client)
    end
    killDrugLab(client)
end
addEvent("GTIdruglab.drugMade", true)
addEventHandler("GTIdruglab.drugMade", root, drugMade)

function givePoliceDrugs(plr, mdim)
    if (plr and getElementType(plr) == "player" and mdim and not isPedInVehicle(plr)) then
        if (exports.GTIutil:isPlayerInTeam(plr, "Law Enforcement")) then
            if (not labMarker[source]) then return end
            local drugMaker, drug = labMarker[source][1], labMarker[source][2]
            if (drugMaker == plr or not isElement(drugMaker)) then return end
            local d1 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Cocaine")
            local d2 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Cocaine")
            local d3 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Oxycodone")   
            local d4 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Marijuana")
            local d5 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Tylenol")
            local d6 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Ecstasy")
            local d7 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Meth")
            local dx = d1
            if (drug == "Cocaine") then
                dx = d2
            elseif (drug == "Oxycodone") then
                dx = d3
            elseif (drug == "Marijuana") then
                dx = d4
            elseif (drug == "Tylenol") then
                dx = d5
            elseif (drug == "Ecstasy") then
                dx = d6    
            elseif (drug == "Meth") then
                dx = d7
            end
            if (dx >= drugAmounts[drug]) then
                exports.GTIdrugs:givePlayerDrug(drugMaker, drug, - drugAmounts[drug])
                exports.GTIhud:dm(getPlayerName(plr).. " has destroyed your drug lab and stole "..drugAmounts[drug].." hits of "..drug.." from you", drugMaker, 255, 0, 0)
                exports.GTIpoliceWanted:chargePlayer(drugMaker, 32)
            else
                exports.GTIhud:dm(getPlayerName(plr).. " has destroyed your drug lab", drugMaker, 255, 0, 0)
                exports.GTIpoliceWanted:chargePlayer(drugMaker, 32)
            end
            exports.GTIhud:dm("You have destroyed a drug lab and got "..drugAmounts[drug].. " hits of "..drug, plr, 0, 255, 0)
            exports.GTIdrugs:givePlayerDrug(plr, drug, drugAmounts[drug])
            destroyElement(source)
            labMarker[source] = nil
            triggerClientEvent(drugMaker, "GTIdruglab.killMakingBar", drugMaker)
            killDrugLab(drugMaker)
        end
    end
end

function killDrugLab(player)
    if (not player) then
        player = client
    end
    if (isTimer(failtimer[player])) then
        killTimer(failtimer[player])
    end    
    if (drugLabs[player]) then
        if (isElement(drugLabs[player][1])) then
            destroyElement(drugLabs[player][1])
        end
        if (isElement(drugLabs[player][6])) then
            destroyElement(drugLabs[player][6])
        end
        drugLabs[player] = nil
        setPlayerNametagShowing(player, true)
    end
    if (drugSearching[player]) then
        drugSearching[player] = nil
    end
end
addEvent("GTIdruglab.killDrugLab", true)
addEventHandler("GTIdruglab.killDrugLab", root, killDrugLab)

function killDrugMaterialsLeave()
    if (drugLabs[source] or drugSearching[source]) then
        local lab
        if (drugLabs[source]) then
            lab = labMarker[drugLabs[source][6]]
        end
        if (lab) then
            local drugMaker, drug = lab[1], lab[2]
            local d1 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Cocaine")
            local d2 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Cocaine")
            local d3 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Oxycodone")   
            local d4 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Marijuana")
            local d5 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Tylenol")
            local d6 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Ecstasy")
            local d7 = exports.GTIdrugs:getPlayerDrugAmount(drugMaker, "Meth")
            local dx = d1
            if (drug == "Cocaine") then
                dx = d2
            elseif (drug == "Oxycodone") then
                dx = d3
            elseif (drug == "Marijuana") then
                dx = d4
            elseif (drug == "Tylenol") then
                dx = d5
            elseif (drug == "Ecstasy") then
                dx = d6     
            elseif (drug == "Meth") then
                dx = d7    
            end
            if (dx >= drugAmounts[drug]) then
                exports.GTIdrugs:givePlayerDrug(source, drug, - drugAmounts[drug])
            else
                exports.GTIpoliceWanted:chargePlayer(source, 32)
            end
            local x, y, z = getElementPosition(source)
            for index, plr in pairs(getElementsByType("player")) do
                local px, py, pz = getElementPosition(plr)
                if (drugSearching[plr]) then
                    if (getDistanceBetweenPoints2D(x, y, px, py) <= 50) then
                        exports.GTIdrugs:givePlayerDrug(plr, drug, drugAmounts[drug])
                        exports.GTIhud:dm(getPlayerName(source).. " has left the game so "..drugAmounts[drug].." hits of "..drug.." has been given to you", plr, 255, 255, 0)
                        break
                    end
                end
            end
        end
        killDrugLab(source)
    end
end
addEventHandler("onPlayerQuit", root, killDrugMaterialsLeave, true, "high")

function isPlayerMakingDrugs(plr)
    if (drugLabs[plr]) then
        return true
    else
        return false
    end
end

function disableGovt(cmd)
    if (cmd == "govt" and drugLabs[source]) then
        cancelEvent()
        exports.GTIhud:dm("You can't do /govt while crafting drugs.", source, 255, 0, 0)
    elseif (cmd == "sur" and drugLabs[source]) then
        cancelEvent()
        exports.GTIhud:dm("You can't do /sur while crafting drugs.", source, 255, 0, 0)    
    elseif (cmd == "criminal" and drugLabs[source]) then
        cancelEvent()
        exports.GTIhud:dm("You can't do /criminal while crafting drugs.", source, 255, 0, 0) 
    elseif (cmd == "turf" and drugLabs[source]) then
        cancelEvent()
        exports.GTIhud:dm("You can't do /turf while crafting drugs.", source, 255, 0, 0)     
    end
end
addEventHandler("onPlayerCommand", root, disableGovt)   