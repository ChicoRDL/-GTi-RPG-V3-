Cocaine = false
Marijuana = false
Ecstasy = false
Oxycodone = false
Adderall = false
Tylenol = false
Meth = false

drugTimer = {}
checkTimer = {}
minTimer = {}

function startDrugEffect(plr, drug)  
    if (drug == "Cocaine") then
        if (Marijuana) then
            outputChatBox("You can't take a hit of Cocaine while taking a hit of Marijuana", 255, 0, 0)
            return
        end
        if (isTimer(drugTimer["Cocaine"])) then
            local a, b, c = getTimerDetails(drugTimer["Cocaine"])
            local time = a + 60000
            killTimer(drugTimer["Cocaine"])
            drugTimer["Cocaine"] = setTimer(stopCocaine, time, 1, plr)
            return
        end
        addEventHandler("onClientPlayerDamage", getLocalPlayer(), theCocaineEffect )
        drugTimer["Cocaine"] = setTimer(stopCocaine, 60000, 1, plr)
        checkTimer["Cocaine"] = setTimer(checkCCRTime, 1000, 0, "Cocaine")  
        minTimer["Cocaine"] = setTimer(nothing, 60000, 0)
        Cocaine = true
        
    elseif (drug == "Marijuana") then
        if (Cocaine) then
            outputChatBox("You can't take a hit of Marijuana while taking a hit of Cocaine", 255, 0, 0)
            return
        end
        if (isTimer(drugTimer["Marijuana"])) then
            local a, b, c = getTimerDetails(drugTimer["Marijuana"])
            local time = a + 60000
            killTimer(drugTimer["Marijuana"])
            drugTimer["Marijuana"] = setTimer(stopMarijuana, time, 1, plr)
            return
        end
        drugTimer["Marijuana"] = setTimer(stopMarijuana, 60000, 1, plr)
        checkTimer["Marijuana"] = setTimer(checkCCRTime, 1000, 0, "Marijuana")  
        minTimer["Marijuana"] = setTimer(nothing, 60000, 0)
        Marijuana = true
        
    elseif (drug == "Ecstasy") then
        if (isTimer(drugTimer["Ecstasy"])) then
            local a, b, c = getTimerDetails(drugTimer["Ecstasy"])
            local time = a + 60000
            killTimer(drugTimer["Ecstasy"])
            drugTimer["Ecstasy"] = setTimer(stopEcstasy, time, 1, plr)
            return
        end
        triggerServerEvent("drugs.Ecstasy", resourceRoot, plr, true)
        drugTimer["Ecstasy"] = setTimer(stopEcstasy, 60000, 1, plr)
        checkTimer["Ecstasy"] = setTimer(checkCCRTime, 1000, 0, "Ecstasy")  
        minTimer["Ecstasy"] = setTimer(nothing, 60000, 0)
        Ecstasy = true
        
    elseif (drug == "Oxycodone") then
        if (isTimer(drugTimer["Oxycodone"])) then
            local a, b, c = getTimerDetails(drugTimer["Oxycodone"])
            local time = a + 60000
            killTimer(drugTimer["Oxycodone"])
            drugTimer["Oxycodone"] = setTimer(stopOxycodone, time, 1, plr)
            return
        end
        triggerServerEvent("drugs.sethealth", resourceRoot, plr, 1000)
        drugTimer["Oxycodone"] = setTimer(stopOxycodone, 60000, 1, plr)
        checkTimer["Oxycodone"] = setTimer(checkCCRTime, 1000, 0, "Oxycodone")  
        minTimer["Oxycodone"] = setTimer(nothing, 60000, 0)
        Oxycodone = true
        
    elseif (drug == "Adderall") then
        if (isTimer(drugTimer["Adderall"])) then
            local a, b, c = getTimerDetails(drugTimer["Adderall"])
            local time = a + 60000
            killTimer(drugTimer["Adderall"])
            drugTimer["Adderall"] = setTimer(stopAdderall, time, 1, plr)
            return
        end
        Adderall = true
        setWeaponProperty("M4", "poor", "accuracy", 0.44999998807907)
        setWeaponProperty("M4", "std", "accuracy", 0.44999998807907)
        setWeaponProperty("M4", "pro", "accuracy", 0.44999998807907)
        drugTimer["Adderall"] = setTimer(stopAdderall, 60000, 1, plr)
        checkTimer["Adderall"] = setTimer(checkCCRTime, 1000, 0, "Adderall")  
        minTimer["Adderall"] = setTimer(nothing, 60000, 0)
        
    elseif (drug == "Laughing Gas") then
    elseif (drug == "Bath Salts") then
    elseif (drug == "Shrooms") then
    elseif (drug == "Tylenol") then
        if (isTimer(drugTimer["Tylenol"])) then
            local a, b, c = getTimerDetails(drugTimer["Tylenol"])
            local time = a + 60000
            killTimer(drugTimer["Tylenol"])
            drugTimer["Tylenol"] = setTimer(stopTylenol, time, 1, plr)
            return
        end    
        Tylenol = true
        enableBlackWhite()
        drugTimer["Tylenol"] = setTimer(stopTylenol, 60000, 1, plr)
        checkTimer["Tylenol"] = setTimer(checkCCRTime, 1000, 0, "Tylenol")  
        minTimer["Tylenol"] = setTimer(nothing, 60000, 0)
        
    elseif (drug == "Meth") then
        if (isTimer(drugTimer["Meth"])) then
            local a, b, c = getTimerDetails(drugTimer["Meth"])
            local time = a + 60000
            killTimer(drugTimer["Meth"])
            drugTimer["Meth"] = setTimer(stopMeth, time, 1, plr)
            return
        end
        drugTimer["Meth"] = setTimer(stopMeth, 60000, 1, plr)
        checkTimer["Meth"] = setTimer(checkCCRTime, 1000, 0, "Meth")  
        minTimer["Meth"] = setTimer(nothing, 60000, 0)
        Meth = true
        switchPedWall(true)
    elseif (drug == "Green Goo") then
    elseif (drug == "Acid") then
    end
end


function takeDrug(plr, drug, amount)
    if (plr == localPlayer) then
    if (drug == "Cocaine") then
        if (Marijuana) then
            outputChatBox("You can't take a hit of Cocaine while taking a hit of Marijuana", 255, 0, 0)
            return
        end
        if (isTimer(drugTimer["Cocaine"])) then
            local a, b, c = getTimerDetails(drugTimer["Cocaine"])
            local time = a + (60000 * amount)
            killTimer(drugTimer["Cocaine"])
            drugTimer["Cocaine"] = setTimer(stopCocaine, time, 1, plr)
            return
        end
        --setGameSpeed(1.14)
        drugTimer["Cocaine"] = setTimer(stopCocaine, 60000 * amount, 1, plr)
        checkTimer["Cocaine"] = setTimer(checkCCRTime, 1000, 0, "Cocaine")
        minTimer["Cocaine"] = setTimer(nothing, 60000, 0)
        Cocaine = true
        
    elseif (drug == "Marijuana") then
        if (Cocaine) then
            outputChatBox("You can't take a hit of Marijuana while taking a hit of Cocaine", 255, 0, 0)
            return
        end
        if (isTimer(drugTimer["Marijuana"])) then
            local a, b, c = getTimerDetails(drugTimer["Marijuana"])
            local time = a + (60000 * amount)
            killTimer(drugTimer["Marijuana"])
            drugTimer["Marijuana"] = setTimer(stopMarijuana, time, 1, plr)
            return
        end
        --setGameSpeed(0.8)
        drugTimer["Marijuana"] = setTimer(stopMarijuana, 60000 * amount, 1, plr)
        checkTimer["Marijuana"] = setTimer(checkCCRTime, 1000, 0, "Marijuana")  
        minTimer["Marijuana"] = setTimer(nothing, 60000, 0)
        Marijuana = true
        
    elseif (drug == "Ecstasy") then
        if (isTimer(drugTimer["Ecstasy"])) then
            local a, b, c = getTimerDetails(drugTimer["Ecstasy"])
            local time = a + (60000 * amount)
            killTimer(drugTimer["Ecstasy"])
            drugTimer["Ecstasy"] = setTimer(stopEcstasy, time, 1, plr)
            return
        end
        triggerServerEvent("drugs.Ecstasy", resourceRoot, localPlayer, true)
        drugTimer["Ecstasy"] = setTimer(stopEcstasy, 60000 * amount, 1, plr)
        checkTimer["Ecstasy"] = setTimer(checkCCRTime, 1000, 0, "Ecstasy")  
        minTimer["Ecstasy"] = setTimer(nothing, 60000, 0)
        Ecstasy = true
        
    elseif (drug == "Oxycodone") then
        if (isTimer(drugTimer["Oxycodone"])) then
            local a, b, c = getTimerDetails(drugTimer["Oxycodone"])
            local time = a + (60000 * amount)
            killTimer(drugTimer["Oxycodone"])
            drugTimer["Oxycodone"] = setTimer(stopOxycodone, time, 1, plr)
            return
        end
        triggerServerEvent("drugs.sethealth", resourceRoot, localPlayer, 1000)
        drugTimer["Oxycodone"] = setTimer(stopOxycodone, 60000 * amount, 1, plr)
        checkTimer["Oxycodone"] = setTimer(checkCCRTime, 1000, 0, "Oxycodone")  
        minTimer["Oxycodone"] = setTimer(nothing, 60000, 0)
        Oxycodone = true
        
    elseif (drug == "Adderall") then
        if (isTimer(drugTimer["Adderall"])) then
            local a, b, c = getTimerDetails(drugTimer["Adderall"])
            local time = a + (60000 * amount)
            killTimer(drugTimer["Adderall"])
            drugTimer["Adderall"] = setTimer(stopAdderall, time, 1, plr)
            return
        end
        Adderall = true
        setWeaponProperty("M4", "poor", "accuracy", 0.44999998807907)
        setWeaponProperty("M4", "std", "accuracy", 0.44999998807907)
        setWeaponProperty("M4", "pro", "accuracy", 0.44999998807907)
        drugTimer["Adderall"] = setTimer(stopAdderall, 60000 * amount, 1, plr)
        checkTimer["Adderall"] = setTimer(checkCCRTime, 1000, 0, "Adderall")  
        minTimer["Adderall"] = setTimer(nothing, 60000, 0)
        
    elseif (drug == "Laughing Gas") then
    elseif (drug == "Bath Salts") then
    elseif (drug == "Shrooms") then
    elseif (drug == "Tylenol") then
        if (isTimer(drugTimer["Tylenol"])) then
            local a, b, c = getTimerDetails(drugTimer["Tylenol"])
            local time = a + (60000 * amount)
            killTimer(drugTimer["Tylenol"])
            drugTimer["Tylenol"] = setTimer(stopTylenol, time, 1, plr)
            return
        end    
        enableBlackWhite()
        drugTimer["Tylenol"] = setTimer(stopTylenol, 60000 * amount, 1, plr)
        checkTimer["Tylenol"] = setTimer(checkCCRTime, 1000, 0, "Tylenol")  
        minTimer["Tylenol"] = setTimer(nothing, 60000, 0)
        Tylenol = true
        
    elseif (drug == "Meth") then
        if (isTimer(drugTimer["Meth"])) then
            local a, b, c = getTimerDetails(drugTimer["Meth"])
            local time = a + (60000 * amount)
            killTimer(drugTimer["Meth"])
            drugTimer["Meth"] = setTimer(stopMeth, time, 1, plr)
            return
        end
        drugTimer["Meth"] = setTimer(stopMeth, 60000 * amount, 1, plr)
        checkTimer["Meth"] = setTimer(checkCCRTime, 1000, 0, "Meth")  
        minTimer["Meth"] = setTimer(nothing, 60000, 0)
        Meth = true
        switchPedWall(true)
    elseif (drug == "Green Goo") then
    elseif (drug == "Acid") then
    end
end
end
addEvent("drugs.takeDrug", true)
addEventHandler("drugs.takeDrug", root, takeDrug)

function stopDrug(cmd, drug)
    if (drug == "Oxycodone" and Oxycodone == true) then
        stopOxycodone(plr)
    elseif ( drug == "Adderall" and Adderall == true) then
        stopAdderall(plr)
    elseif ( drug == "Tylenol" and Tylenol == true) then
        stopTylenol(plr)    
    elseif ( drug == "Cocaine" and Cocaine == true) then
        stopCocaine(plr)
    elseif ( drug == "Marijuana" and Marijuana == true) then
        stopMarijuana(plr)
    elseif ( drug == "Ecstasy" and Ecstasy == true) then
        stopEcstasy(plr)    
    elseif ( drug == "Meth" and Meth == true) then
        stopMeth()    
    end
end   
addCommandHandler("sdrug", stopDrug)
 

function disableDxMsg()
    exports.GTIhud:drawStat("drugsTimerMeth", "", "", 173, 173, 173)
    exports.GTIhud:drawStat("drugsTimerOxycodone", "", "", 173, 173, 173)
    exports.GTIhud:drawStat("drugsTimerAdderall", "", "", 173, 173, 173)
    exports.GTIhud:drawStat("drugsTimerTylenol", "", "", 173, 173, 173)
    exports.GTIhud:drawStat("drugsTimerCocaine", "", "", 173, 173, 173)
    exports.GTIhud:drawStat("drugsTimerMarijuana", "", "", 173, 173, 173)
    exports.GTIhud:drawStat("drugsTimerEcstasy", "", "", 173, 173, 173)
    if (Adderall) then
        stopAdderall()
    end
    if (Meth) then
        stopMeth()
    end
    if (Oxycodone) then
        stopOxycodone()
    end
    if (Tylenol) then
        stopTylenol()
    end
    if (Cocaine) then
        stopCocaine()
    end
    if (Marijuana) then
        stopMarijuana()
    end
    if (Ecstasy) then
        stopEcstasy()
    end    
end
addEventHandler("onClientResourceStop", resourceRoot, disableDxMsg)
    
function stopMeth()
    if (Meth == false) then return end
    switchPedWall(false)
    Meth = false
    if (isTimer(checkTimer["Meth"])) then
        killTimer(checkTimer["Meth"])
        killTimer(minTimer["Meth"])
    end 
    if (isTimer(drugTimer["Meth"])) then
        killTimer(drugTimer["Meth"])
    end 
end    
  
function stopOxycodone(plr)
    triggerServerEvent("drugs.sethealthBack", resourceRoot, plr, 569) 
    Oxycodone = false
    if (isTimer(checkTimer["Oxycodone"])) then
        killTimer(checkTimer["Oxycodone"])
        killTimer(minTimer["Oxycodone"])
    end
    if (isTimer(drugTimer["Oxycodone"])) then
        killTimer(drugTimer["Oxycodone"])
    end    
end

function stopAdderall(plr)
    setWeaponProperty("M4", "poor", "accuracy", 0.40000000596046)
    setWeaponProperty("M4", "std", "accuracy", 0.40000000596046)
    setWeaponProperty("M4", "pro", "accuracy", 0.40000000596046)
    Adderall = false
    if (isTimer(checkTimer["Adderall"])) then
        killTimer(checkTimer["Adderall"])
        killTimer(minTimer["Adderall"])
    end 
    if (isTimer(drugTimer["Adderall"])) then
        killTimer(drugTimer["Adderall"])
    end 
end

function stopTylenol(plr)
    if (Tylenol == false) then return end
    enableBlackWhite()
    Tylenol = false
    if (isTimer(checkTimer["Tylenol"])) then
        killTimer(checkTimer["Tylenol"])
        killTimer(minTimer["Tylenol"])
    end 
    if (isTimer(drugTimer["Tylenol"])) then
        killTimer(drugTimer["Tylenol"])
    end 
end    

function stopCocaine(plr)
    Cocaine = false
    removeEventHandler("onClientPlayerDamage", getLocalPlayer(), theCocaineEffect )
    exports.GTIhud:drawStat("drugsTimerCocaine", "", "", 173, 173, 173)
    if (isTimer(checkTimer["Cocaine"])) then
        killTimer(checkTimer["Cocaine"])
        killTimer(minTimer["Cocaine"])
    end 
    if (isTimer(drugTimer["Cocaine"])) then
        killTimer(drugTimer["Cocaine"])
    end 
end

function stopMarijuana(plr)
    Marijuana = false
    --setGameSpeed(1)
    if (isTimer(checkTimer["Marijuana"])) then
        killTimer(checkTimer["Marijuana"])
        killTimer(minTimer["Marijuana"])
    end 
    if (isTimer(drugTimer["Marijuana"])) then
        killTimer(drugTimer["Marijuana"])
    end 
end


function stopEcstasy(plr)
    triggerServerEvent("drugs.Ecstasy", resourceRoot, plr, false) 
    Ecstasy = false
    if (isTimer(checkTimer["Ecstasy"])) then
        killTimer(checkTimer["Ecstasy"])
        killTimer(minTimer["Ecstasy"])
    end    
    if (isTimer(drugTimer["Ecstasy"])) then
        killTimer(drugTimer["Ecstasy"])
    end 
end

function setTimePlr(plr, hour, minute)
    --setGameSpeed(1)
    setTime(hour, minute)
end
addEvent("drugs.setTime", true)
addEventHandler("drugs.setTime", root, setTimePlr)

local attackTable = {}
function theCocaineEffect(attacker, w, b, health)
    if (isElement(localPlayer)) then
        if (getPedArmor ( localPlayer )) then
            local armor = getPedArmor ( localPlayer )
            local minus = health * 0.8
            local newHealth = (armor + health) - minus
        else    
            local orHealth = getElementHealth(localPlayer)
            local minus = health * 0.8
            local newHealth = (orHealth + health) - minus
            setElementHealth(localPlayer, newHealth)
            cancelEvent()
    --[[if (not attackTable[localPlayer]) then
            attackTable[localPlayer] = 1
        else    
            if (attackTable[localPlayer] == 2) then
                local orHealth = getElementHealth(localPlayer)
                local minus = health * 0.8 
                local newHealth = orHealth - minus
                attackTable[localPlayer] = nil
                setElementHealth(localPlayer, newHealth)
                cancelEvent()
            else      
                attackTable[localPlayer] = attackTable[localPlayer] + 1
            end
            end]]--
        end    
    end
end    
   



function setGameSpeedOnVehicle(player)
    if (Cocaine == true and isElement(player)) then
    --setGameSpeed(1)
    end 
end
addEventHandler("onClientVehicleEnter", root, setGameSpeedOnVehicle)

function setGameSpeedOnVehicleLeave(player)
    if (Cocaine == true and isElement(player)) then
    --setGameSpeed(1.14)
    end
end
addEventHandler("onClientVehicleExit", root, setGameSpeedOnVehicleLeave)    



                                                                    --==========================--
                                                                    --      TIMER SHIT          --
                                                                    --==========================--
                                                                    
function checkCCRTime(drug)
    for i,player in ipairs( getElementsByType( "player")) do
        if (isElement(player)) then
            if isTimer( drugTimer[drug]) then
                local milliSecs, _, _ = getTimerDetails( drugTimer[drug])
                local secs, a, b = getTimerDetails(minTimer[drug])
                local min = math.ceil(milliSecs/(60*1000))
                --local sec = math.ceil(milliSecs/1000)
                local sec = math.ceil(secs/1000)
                if (sec < 10) then sec = "0"..sec end
                exports.GTIhud:drawStat("drugsTimer"..drug, drug..":", (min-1)..":"..sec, 173, 173, 173)
                
            end
        end
    end
end                   
                                               
       
function nothing()
end                                                             
                                
                                                                    
