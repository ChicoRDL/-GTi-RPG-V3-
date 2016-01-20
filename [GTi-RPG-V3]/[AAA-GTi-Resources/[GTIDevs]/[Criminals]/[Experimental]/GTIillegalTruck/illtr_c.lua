
        illTruckWin = guiCreateWindow(720, 297, 291, 354, "Illegal Trucking", false)
        guiWindowSetSizable(illTruckWin, false)
        exports.SjoerdMisc:centerWindow(illTruckWin)
        stolenBtn = guiCreateButton(196, 40, 75, 36, "Start", false, illTruckWin)
        guiSetProperty(stolenBtn, "NormalTextColour", "FFAAAAAA")
        
        drugsBtn = guiCreateButton(196, 86, 75, 36, "Start", false, illTruckWin)
        guiSetProperty(drugsBtn, "NormalTextColour", "FFAAAAAA")
        
        weaponBtn = guiCreateButton(196, 132, 75, 36, "Start", false, illTruckWin)
        guiSetProperty(weaponBtn, "NormalTextColour", "FFAAAAAA")
        
        moneyBtn = guiCreateButton(196, 178, 75, 36, "Start", false, illTruckWin)
        guiSetProperty(moneyBtn, "NormalTextColour", "FFAAAAAA")
        
        peopleBtn = guiCreateButton(196, 224, 75, 36, "Start", false, illTruckWin)
        guiSetProperty(peopleBtn, "NormalTextColour", "FFAAAAAA")
        
        allBtn = guiCreateButton(196, 270, 75, 36, "Start", false, illTruckWin)
        guiSetProperty(allBtn, "NormalTextColour", "FFAAAAAA")
        
        stolenLbl1 = guiCreateLabel(13, 41, 124, 15, "Traffic stolen goods", false, illTruckWin)
        guiSetFont(stolenLbl1, "default-bold-small")
        stolenLbl2 = guiCreateLabel(13, 56, 173, 16, "5 stars and a payment of $500", false, illTruckWin)
        guiSetFont(stolenLbl2, "default-small")
        drugsLbl1 = guiCreateLabel(13, 81, 124, 15, "Traffic drugs", false, illTruckWin)
        guiSetFont(drugsLbl1, "default-bold-small")
        drugsLbl2 = guiCreateLabel(13, 96, 173, 16, "10 stars and a payment of $2500", false, illTruckWin)
        guiSetFont(drugsLbl2, "default-small")
        weaponsLbl1 = guiCreateLabel(13, 132, 173, 15, "Traffic illegal guns/ammo", false, illTruckWin)
        guiSetFont(weaponsLbl1, "default-bold-small")
        moneyLbl1 = guiCreateLabel(13, 177, 124, 15, "Traffic fake money", false, illTruckWin)
        guiSetFont(moneyLbl1, "default-bold-small")
        peopleLbl1 = guiCreateLabel(13, 224, 124, 15, "Traffic people", false, illTruckWin)
        guiSetFont(peopleLbl1, "default-bold-small")
        allLbl1 = guiCreateLabel(13, 270, 124, 15, "Traffic everything", false, illTruckWin)
        guiSetFont(allLbl1, "default-bold-small")
        weaponsLbl2 = guiCreateLabel(13, 147, 173, 16, "10 stars and a payment of $4000", false, illTruckWin)
        guiSetFont(weaponsLbl2, "default-small")
        moneyLbl2 = guiCreateLabel(13, 192, 173, 16, "15 stars and a payment of $5000", false, illTruckWin)
        guiSetFont(moneyLbl2, "default-small")
        peopleLbl2 = guiCreateLabel(13, 239, 173, 16, "20 star and a payment of $8000", false, illTruckWin)
        guiSetFont(peopleLbl2, "default-small")
        allLbl2 = guiCreateLabel(13, 285, 173, 16, "25 stars and a payment of $10000", false, illTruckWin)
        guiSetFont(allLbl2, "default-small")
        closeBtn = guiCreateButton(98, 306, 75, 36, "Close", false, illTruckWin)
        guiSetProperty(closeBtn, "NormalTextColour", "FFAAAAAA")
        stopBtn = guiCreateButton(13, 306, 75, 36, "Stop Mission", false, illTruckWin)
        guiSetProperty(stopBtn, "NormalTextColour", "FFAAAAAA")    
        guiSetVisible(illTruckWin, false)
        guiSetProperty(stopBtn, "Disabled", "True")
        
        
allowedCars = {
    [403] = true, -- Linerunner   
    [515] = true, -- Roadtrain  
    [514] = true, -- Tanker
    }
    
LSlocs = {
    {2791.125, -2418.171, 12.633}, -- LS Docks I
    {2787.183, -2455.988, 12.634}, -- LS Docks II
    {2788.480, -2494.192, 12.649}, -- LS Docks III
    {2461.625, -2616.928, 12.662}, -- LS Ocean Docks
    {2497.674, -2628.050, 12.651},
    }
    
SFlocs = {
    {-2131.530, -2257.674, 29.632}, -- Angel Pine I
    {-2382.305, -2176.909, 32.289}, -- Angel Pine II
    {-1580.846, 112.790, 2.549},
    {-1569.805, 102.265, 2.555},
    {-1734.257, 146.764, 2.555},
    {-1464.611, 467.422, 6.188},
    {-1852.821, 1398.024, 6.184},
    {-2640.911, 1356.609, 6.147},
    {-2445.108, 740.641, 34.016},
    }

LVlocs = {
    {-381.789, 2191.494, 41.414},
    {367.878, 2465.973, 15.484}, -- LV Verdeant Meadows Airport
    {792.172, 1888.161, 3.896},
    {985.390, 2133.599, 9.820},
    {1520.918, 2235.326, 9.820},
    {1615.081, 2332.571, 9.820},
    }    
    
hasOrder = false
distance = 0
lastLoc = 0
    


function sendOrder (player, seat)
    if (exports.AresMisc:isAbleToCrime(player) and seat == 0) then
        if (allowedCars[getElementModel(source)] and hasOrder == false and player == localPlayer) then
            exports.GTIhud:drawNote("crimMissionTruck", "You have received an order, press N to accept.", 255, 0, 0, 10000)
            bindKey("N", "down", openGUI)
        end    
    end    
end
addEventHandler("onClientVehicleEnter", root, sendOrder)

function unbindGUI(player, seat)
    if (exports.AresMisc:isAbleToCrime(player) and seat == 0) then
        if (allowedCars[getElementModel(source)] and hasOrder == false and player == localPlayer) then
            unbindKey("N", "down", openGUI)
	    guiSetVisible(illTruckWin, false)
        end    
    end    
end
addEventHandler("onClientVehicleExit", root, unbindGUI)

function openGUI()
    local veh = getPedOccupiedVehicle(localPlayer)
	if not veh then return end
    local driver = getVehicleController(veh)
    if (isPedInVehicle(localPlayer) and driver == localPlayer) then
    	guiSetVisible(illTruckWin, not guiGetVisible ( illTruckWin ))
        showCursor( not isCursorShowing() )
    end    
end    

function buttonHandling()
    if (source == stolenBtn) then 
        startMission(localPlayer, "Stolen")
    elseif (source == drugsBtn) then
        startMission(localPlayer, "Drugs")
    elseif (source == weaponBtn) then
        startMission(localPlayer, "Weapons")
    elseif (source == moneyBtn) then
        startMission(localPlayer, "Money")
    elseif (source == peopleBtn) then
        startMission(localPlayer, "People")
    elseif (source == allBtn) then  
        startMission(localPlayer, "All")  
    elseif (source == closeBtn) then
        guiSetVisible(illTruckWin, false)
        showCursor(false)
    elseif (source == stopBtn) and hasOrder == true then
        setTimer(enableButtons, 120000, 1)
        exports.GTIhud:dm("You cancelled your mission, you have to wait 2 minutes before being able to select a new mission.", 255, 0, 0)
        if (isElement(delMarker)) then
            destroyElement(delMarker)
        end
        if (isElement(delBlip)) then    
            destroyElement(delBlip)  
        end
        hasOrder = false  
	guiSetEnabled(stopBtn, false)
        guiSetVisible(illTruckWin, false)
        showCursor(false)
        triggerServerEvent("GTIillegaltrucker.destroyTrailer", localPlayer)
    end    
end
addEventHandler("onClientGUIClick", root, buttonHandling)

function stopMission()
    setTimer(enableButtons, 120000, 1)
    exports.GTIhud:dm("You cancelled your mission, you have to wait 2 minutes before being able to select a new mission.", 255, 0, 0)
    if (isElement(delMarker)) then
        destroyElement(delMarker)
    end
    if (isElement(delBlip)) then    
        destroyElement(delBlip)  
    end
    if guiGetVisible(illTruckWin) then
        guiSetVisible(illTruckWin, false)
        showCursor(false)
    end
    hasOrder = false
end
addEvent("GTIillegaltruck.stopMission", true)    
addEventHandler("GTIillegaltruck.stopMission", root, stopMission)    
function closeGUI()
    if guiGetVisible(illTruckWin) then
        guiSetVisible(illTruckWin, false)
        showCursor(false)
    end
end
addEvent("GTIillegaltruck.closeGUI", true)    
addEventHandler("GTIillegaltruck.closeGUI", root, closeGUI)    
function stopMissionOnResign(job)
    if ( exports.AresMisc:isAbleToCrime(source) ) then 
    if (isElement(delMarker)) then
        destroyElement(delMarker)
        triggerServerEvent("GTIillegaltrucker.destroyTrailer", localPlayer)
    end
    if (isElement(delBlip)) then    
        destroyElement(delBlip)  
    end
    hasOrder = false
    if guiGetVisible(illTruckWin) then
        guiSetVisible(illTruckWin, false)
        showCursor(false)
end
end
end
addEventHandler ("onClientPlayerQuitJob", localPlayer, stopMissionOnResign)
function disableButtons()
    guiSetProperty(stolenBtn, "Disabled", "True")
    guiSetProperty(drugsBtn, "Disabled", "True")
    guiSetProperty(weaponBtn, "Disabled", "True")
    guiSetProperty(moneyBtn, "Disabled", "True")
    guiSetProperty(peopleBtn, "Disabled", "True")
    guiSetProperty(allBtn, "Disabled", "True")
    guiSetProperty(stopBtn, "Disabled", "False")
end    

function enableButtons()
    guiSetProperty(stolenBtn, "Disabled", "False")
    guiSetProperty(drugsBtn, "Disabled", "False")
    guiSetProperty(weaponBtn, "Disabled", "False")
    guiSetProperty(moneyBtn, "Disabled", "False")
    guiSetProperty(peopleBtn, "Disabled", "False")
    guiSetProperty(allBtn, "Disabled", "False")
    guiSetProperty(stopBtn, "Disabled", "True")
    exports.GTIhud:dm("You are now able to do a trucker mission again.", 255, 0, 0)
end
function startMission(player, section)
    if (player == localPlayer) then
        if (hasOrder == true) then return end
        if isElement(delBlip) or isElement(delMarker) then return end
        if (exports.AresMisc:isAbleToCrime(player) and isPedInVehicle(player)) then
            if (section == "Stolen") then

                local city = exports.GTIchat:getPlayerCity(player)
                if (city == "LS") then
                    local random = math.random(1, 2)

                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "SF") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]   
                        createDelMarker(player, delX, delY, delZ, loc, section)                  
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "LV") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                end
            elseif (section == "Drugs") then

                local city = exports.GTIchat:getPlayerCity(player)
                if (city == "LS") then
                    local random = math.random(1, 2)

                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "SF") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]   
                        createDelMarker(player, delX, delY, delZ, loc, section)                  
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "LV") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                end
            elseif (section == "Weapons") then

                local city = exports.GTIchat:getPlayerCity(player)
                if (city == "LS") then
                    local random = math.random(1, 2)

                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "SF") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]           
                        createDelMarker(player, delX, delY, delZ, loc, section)          
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "LV") then
                    outputDebugString(random.."LV")
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                end
            elseif (section == "Money") then

                local city = exports.GTIchat:getPlayerCity(player)
                if (city == "LS") then
                    local random = math.random(1, 2)

                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "SF") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)                       
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "LV") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                end
            elseif (section == "People") then 

                local city = exports.GTIchat:getPlayerCity(player)
                if (city == "LS") then
                    local random = math.random(1, 2)

                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "SF") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)                    
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "LV") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                end
            elseif (section == "All") then

                local city = exports.GTIchat:getPlayerCity(player)
                if (city == "LS") then
                    local random = math.random(1, 2)

                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "SF") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)                      
                    elseif (random == 2) then
                        local loc = math.random(#LVlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LVlocs[loc][1], LVlocs[loc][2], LVlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                elseif (city == "LV") then
                    local random = math.random(1, 2)
                    if (random == 1) then
                        local loc = math.random(#SFlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = SFlocs[loc][1], SFlocs[loc][2], SFlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    elseif (random == 2) then
                        local loc = math.random(#LSlocs)
                        if (loc == lastLoc) then
                            startMission(player, section)
                        end
                        local delX, delY, delZ = LSlocs[loc][1], LSlocs[loc][2], LSlocs[loc][3]
                        createDelMarker(player, delX, delY, delZ, loc, section)
                    end
                end
            end    
        end
    end
end    

function createDelMarker(player, delX, delY, delZ, loc, section)
    if (player == localPlayer) then
        if isElement(delBlip) or isElement(delMarker) then return end
        setElementData(player, "GTIillegalTruck.Section", section)
        delMarker = createMarker(delX, delY, delZ, "cylinder", 3, 255, 200, 0, 150)
        delBlip = createBlip(delX, delY, delZ, 51)
        zone = getZoneName(delX, delY, delZ, false)
        exports.GTIhud:dm("Deliver your goods at "..zone, 0, 200, 0)
        x, y, z = getElementPosition(player)
        distance = getDistanceBetweenPoints2D(delX, delY, x, y)
        hasOrder = true
        disableButtons()
        setElementData(player, "GTItrucker.HasOrder", true)
        lastLoc = loc
        addEventHandler("onClientMarkerHit", delMarker, completeMission)    
        triggerServerEvent("GTIillegalTruck.spawnTrailer", player, player, section)
    end
end

function completeMission(player)
    local veh = getPedOccupiedVehicle(player)
    if (not allowedCars[getElementModel(veh)]) then
        exports.GTIhud:dm("You have to be in a truck in order to deliver your goods. ", 255, 0, 0)
        return
    end    
    if (player == localPlayer) then
        if isElement(delMarker) then destroyElement(delMarker) end
            if isElement(delBlip) then destroyElement(delBlip) end
        hasOrder = false
		guiSetProperty(stopBtn, "Disabled", "True")
        setElementData(player, "GTItrucker.HasOrder", false)
        setTimer(enableButtons, 300000, 1)
        triggerServerEvent("GTIillegaltrucker.setCooldown", player, player)
        
        toggleControl("accelerate", false)
        toggleControl("brake_reverse", false)
        toggleControl("handbrake", false)
        setControlState("handbrake", true)
        fadeCamera(false)
        
        local section = getElementData(player, "GTIillegalTruck.Section")
        local veh = getPedOccupiedVehicle(player)
        triggerServerEvent("GTIillegaltrucker.completeDelivery", player, veh, distance, section)
        
        
        setTimer(function () 
        toggleControl("accelerate", true)
        toggleControl("brake_reverse", true)
        toggleControl("handbrake", true)
        setControlState("handbrake", false)
        fadeCamera(true) end, 2000, 1)
    end
end    

function addTimeronJoin(time)
    disableButtons()
    setTimer(enableButtons, time, 1)
end    
addEvent("GTIillegaltrucker.disableBtns", true)
addEventHandler("GTIillegaltrucker.disableBtns", root, addTimeronJoin)
