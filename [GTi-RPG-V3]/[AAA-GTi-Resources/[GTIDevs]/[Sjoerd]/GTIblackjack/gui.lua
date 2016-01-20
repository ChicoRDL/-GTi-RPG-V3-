casinoBj = {
    staticimage = {},
    edit = {},
    button = {},
    window = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
local screenW, screenH = guiGetScreenSize()
        casinoBj.window[1] = guiCreateWindow((screenW - 453) / 2, (screenH - 348) / 2, 453, 348, "GTI Blackjack", false)
        guiWindowSetSizable(casinoBj.window[1], false)
        guiSetVisible(casinoBj.window[1], false)

        casinoBj.label[1] = guiCreateLabel(9, 25, 86, 28, "Bet Minimum: Bet Maximum:", false, casinoBj.window[1])
        guiSetFont(casinoBj.label[1], "default-bold-small")
        guiLabelSetHorizontalAlign(casinoBj.label[1], "left", true)
        casinoBj.label[2] = guiCreateLabel(95, 25, 155, 18, "test", false, casinoBj.window[1])
        guiSetFont(casinoBj.label[2], "default-bold-small")
        casinoBj.label[3] = guiCreateLabel(95, 38, 50, 15, "test", false, casinoBj.window[1])
        guiSetFont(casinoBj.label[3], "default-bold-small")
        casinoBj.edit[1] = guiCreateEdit(274, 42, 159, 25, "", false, casinoBj.window[1])
        guiEditSetMaxLength(casinoBj.edit[1], 5)
        casinoBj.label[4] = guiCreateLabel(275, 23, 148, 15, "Bet amount:", false, casinoBj.window[1])
        guiSetFont(casinoBj.label[4], "clear-normal")
        casinoBj.button[1] = guiCreateButton(275, 77, 69, 29, "Start", false, casinoBj.window[1])
        guiSetProperty(casinoBj.button[1], "NormalTextColour", "FFAAAAAA")
        --[[if (isElement(casinoBj.staticimage[1] = guiCreateStaticImage(22, 251, 45, 64, "", false, casinoBj.window[1])
        if (isElement(casinoBj.staticimage[2] = guiCreateStaticImage(67, 251, 45, 64, "", false, casinoBj.window[1])
        if (isElement(casinoBj.staticimage[3] = guiCreateStaticImage(112, 251, 45, 64, "", false, casinoBj.window[1])
        if (isElement(casinoBj.staticimage[4] = guiCreateStaticImage(157, 251, 45, 64, "", false, casinoBj.window[1])
        if (isElement(casinoBj.staticimage[5] = guiCreateStaticImage(202, 251, 45, 64, "", false, casinoBj.window[1])]]--
        casinoBj.label[5] = guiCreateLabel(21, 232, 101, 15, "Your cards:", false, casinoBj.window[1])
        --[[if (isElement(casinoBj.staticimage[6] = guiCreateStaticImage(21, 168, 45, 64, "", false, casinoBj.window[1])
        if (isElement(casinoBj.staticimage[7] = guiCreateStaticImage(66, 168, 45, 64, "", false, casinoBj.window[1])
        if (isElement(casinoBj.staticimage[8] = guiCreateStaticImage(111, 168, 45, 64, "", false, casinoBj.window[1])
        if (isElement(casinoBj.staticimage[9] = guiCreateStaticImage(157, 168, 45, 64, "", false, casinoBj.window[1])
        if (isElement(casinoBj.staticimage[10] = guiCreateStaticImage(202, 168, 45, 64, "", false, casinoBj.window[1])]]--
        casinoBj.label[6] = guiCreateLabel(22, 150, 118, 18, "House's cards:", false, casinoBj.window[1])
        
        
        casinoBj.button[2] = guiCreateButton(374, 245, 69, 32, "Hit", false, casinoBj.window[1])
        guiSetProperty(casinoBj.button[2], "NormalTextColour", "FFAAAAAA")
        guiSetVisible(casinoBj.button[2], false)
        casinoBj.button[3] = guiCreateButton(374, 283, 69, 32, "Stay", false, casinoBj.window[1])
        guiSetProperty(casinoBj.button[3], "NormalTextColour", "FFAAAAAA")
        guiSetVisible(casinoBj.button[3], false)
        casinoBj.label[7] = guiCreateLabel(9, 63, 62, 15, "Croupier:", false, casinoBj.window[1])
        guiSetFont(casinoBj.label[7], "default-bold-small")
        guiLabelSetHorizontalAlign(casinoBj.label[7], "left", true)
        casinoBj.label[8] = guiCreateLabel(95, 63, 50, 15, "test", false, casinoBj.window[1])
        guiSetFont(casinoBj.label[8], "default-bold-small")
        casinoBj.button[4] = guiCreateButton(364, 77, 69, 29, "Close", false, casinoBj.window[1])
        guiSetProperty(casinoBj.button[4], "NormalTextColour", "FFAAAAAA")
        casinoBj.button[5] = guiCreateButton(295, 245, 69, 32, "1", false, casinoBj.window[1])
        guiSetProperty(casinoBj.button[5], "NormalTextColour", "FFAAAAAA")
        guiSetVisible(casinoBj.button[5], false)
        casinoBj.button[6] = guiCreateButton(295, 283, 69, 32, "11", false, casinoBj.window[1])
        guiSetProperty(casinoBj.button[6], "NormalTextColour", "FFAAAAAA")  
        guiSetVisible(casinoBj.button[6], false)  
        
        addEventHandler("onClientGUIClick", casinoBj.button[1], preStartGame, false)
        addEventHandler("onClientGUIClick", casinoBj.button[2], hit, false)
        addEventHandler("onClientGUIClick", casinoBj.button[3], stay, false)
        addEventHandler("onClientGUIClick", casinoBj.button[4], close, false)
        addEventHandler("onClientGUIClick", casinoBj.button[5], aceLow, false)
        addEventHandler("onClientGUIClick", casinoBj.button[6], aceHigh, false)
    end
)

function openGUI(minBet, maxBet, name)
    if (guiGetVisible(casinoBj.window[1])) then
        guiSetVisible(casinoBj.window[1], false)
        showCursor(false)
    else    
        guiSetVisible(casinoBj.window[1], true)
        showCursor(true)
        guiSetText(casinoBj.label[2], minBet)
        guiSetText(casinoBj.label[3], maxBet)
        guiSetText(casinoBj.label[8], name)
    end    
end

function hideGUIonWaste()
    if (guiGetVisible(casinoBj.window[1])) then
        guiSetVisible(casinoBj.window[1], false)
        showCursor(false)
    end
end    
addEventHandler ( "onClientPlayerWasted", getLocalPlayer(), hideGUIonWaste )
--addCommandHandler("blackjack", openGUI)

function deleteImg()
    if (isElement(casinoBj.staticimage[1])) then
        destroyElement(casinoBj.staticimage[1])
    end    
    if (isElement(casinoBj.staticimage[2])) then
        destroyElement(casinoBj.staticimage[2]) 
    end    
    if (isElement(casinoBj.staticimage[3])) then
        destroyElement(casinoBj.staticimage[3])
    end    
    if (isElement(casinoBj.staticimage[4])) then
        destroyElement(casinoBj.staticimage[4])
    end    
    if (isElement(casinoBj.staticimage[5])) then
        destroyElement(casinoBj.staticimage[5])
    end    
    if (isElement(casinoBj.staticimage[6])) then
        destroyElement(casinoBj.staticimage[6])
    end    
    if (isElement(casinoBj.staticimage[7])) then
        destroyElement(casinoBj.staticimage[7])
    end    
    if (isElement(casinoBj.staticimage[8])) then
        destroyElement(casinoBj.staticimage[8])
    end    
    if (isElement(casinoBj.staticimage[9])) then
        destroyElement(casinoBj.staticimage[9])
    end    
    if (isElement(casinoBj.staticimage[10])) then
        destroyElement(casinoBj.staticimage[10])
    end
end    