local drugMake = {nil}
local amount = 0.25
local resX, resY = guiGetScreenSize()

function makeDrugsGUI()
    pickDrug = guiCreateWindow((resX/2)-112, (resY/2)-110, 225, 220, "Pick a drug to make", false)
    guiSetAlpha(pickDrug, 0.97)
    guiWindowSetSizable(pickDrug, false)
    guiSetVisible(pickDrug, false)
    coc_rad3 = guiCreateRadioButton(12,27,147,24, "Cocaine", false, pickDrug)
    oxy_rad3 = guiCreateRadioButton(12,54,194,21, "Oxycodone", false, pickDrug)
    mar_rad3 = guiCreateRadioButton(12,80,194,21, "Marijuana", false, pickDrug)
    tyl_rad3 = guiCreateRadioButton(12,107,198,21, "Tylenol", false, pickDrug)
    ecs_rad3 = guiCreateRadioButton(12,134,198,21, "Ecstasy", false, pickDrug)
    met_rad3 = guiCreateRadioButton(12,163,198,21, "Meth", false, pickDrug)
    makeBut = guiCreateButton(14,188,79,30, "Craft!", false, pickDrug)
    cancelBut = guiCreateButton(134,188,79,30, "Cancel", false, pickDrug)


    
    addEventHandler("onClientGUIClick", makeBut, makeADrugNow, false)
    addEventHandler("onClientGUIClick", cancelBut, function() showCursor(false) guiSetVisible(pickDrug, false) end, false)

    for i, e in pairs({lsd_rad3, spe_rad3, god_rad3, ste_rad3, her_rad3, mes_rad3}) do
        guiSetFont(e, "clear-normal")
    end
end
addEventHandler("onClientResourceStart", resourceRoot, makeDrugsGUI)

function drawStaticBar()
    dxDrawRectangle((resX/2)-270, (resY/2)-22, 540.0, 44.0, tocolor(0,0,0,150), false)
    dxDrawRectangle((resX/2)-265, (resY/2)-16, 530.0, 33.0, tocolor(0,0,0,250), false)
end

function drawLoadingBar()
    if (loadingBar >= 520) then
        killTimer(makeTimer)
        removeEventHandler("onClientRender", root, drawStaticBar)
        removeEventHandler("onClientRender", root, drawLoadingBar)
        removeEventHandler("onClientPlayerWasted", localPlayer, killMakingBar)
        triggerServerEvent("GTIdruglab.drugMade", root, drugMake[1])
        drugMake[1] = nil
        toggleAllControls(true, true, false)
        setElementFrozen(localPlayer, false)
        playSoundFrontEnd(4)
    else
        dxDrawRectangle((resX/2)-261, (resY/2)-12, loadingBar, 25.0, tocolor(200,200,50,255), false)
    end
    --local font = dxCreateFont("font.ttf", 20)
    --dxDrawText(" Crafting... "..(math.floor(loadingBar/5.2)).."%", (resX/2)-145, (resY/2)-15, (resY/2)-1, (resX/2)-5, tocolor(0,0,255,255),1.0,font,"left","top",false,false,false)
end

function showMakeDrug()
    guiSetVisible(pickDrug, true)
    showCursor(true)
end
addCommandHandler("druglab", showMakeDrug)

function makeADrugNow()
    if (guiRadioButtonGetSelected(coc_rad3)) then
        drugMake[1] = "Cocaine"
    elseif (guiRadioButtonGetSelected(oxy_rad3)) then
        drugMake[1] = "Oxycodone"
    elseif (guiRadioButtonGetSelected(mar_rad3)) then
        drugMake[1] = "Marijuana"
    elseif (guiRadioButtonGetSelected(tyl_rad3)) then
        drugMake[1] = "Tylenol"
    elseif (guiRadioButtonGetSelected(ecs_rad3)) then
        drugMake[1] = "Ecstasy"    
    elseif (guiRadioButtonGetSelected(met_rad3)) then
        drugMake[1] = "Meth"       
    else
        exports.GTIhud:dm("You have to select a drug.", 255, 255, 0)
        return
    end
    guiSetVisible(pickDrug, false)
    showCursor(false)
    triggerServerEvent("GTIdruglab.createDrugLab", root, drugMake[1])
end

function makeDrugs2()
    loadingBar = 0
    toggleAllControls(false, true, false)
    setElementFrozen(localPlayer, true)
    addEventHandler("onClientRender", root, drawStaticBar)
    addEventHandler("onClientRender", root, drawLoadingBar)
    addEventHandler("onClientPlayerWasted", localPlayer, killMakingBar)
    makeTimer = setTimer(function() loadingBar = loadingBar + amount end, 50, 0)
end
addEvent("GTIdruglab.makeDrugs2", true)
addEventHandler("GTIdruglab.makeDrugs2", root, makeDrugs2)

function killMakingBar()
    loadingBar = 0
    if (isTimer(makeTimer)) then
        killTimer(makeTimer)
    end
    setElementFrozen(localPlayer, false)
    toggleAllControls(true)
    drugMake[1] = nil
    removeEventHandler("onClientRender", root, drawStaticBar)
    removeEventHandler("onClientRender", root, drawLoadingBar)
    removeEventHandler("onClientPlayerWasted", localPlayer, killMakingBar)
    triggerServerEvent("GTIdruglab.killDrugLab", root)
end
addEvent("GTIdruglab.killMakingBar", true)
addEventHandler("GTIdruglab.killMakingBar", root, killMakingBar)

function makeObjectUnbreakable(object)
    setObjectBreakable(object, false)
end
addEvent("GTIdruglab.makeObjectUnbreakable", true)
addEventHandler("GTIdruglab.makeObjectUnbreakable", root, makeObjectUnbreakable)

function isLocalPlayerMakingDrugs()
    if (drugMake[1]) then
        return true
    else
        return false
    end
end