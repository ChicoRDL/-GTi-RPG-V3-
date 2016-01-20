
GUIEditor = {
    button = {},
    window = {},
    label = {},
    edit = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(672, 332, 267, 299, "Safe Cracker", false)
        guiWindowSetSizable(GUIEditor.window[1], false)

        button1 = guiCreateButton(52, 102, 52, 42, "1", false, GUIEditor.window[1])
        guiSetFont(button1, "sa-header")
        guiSetProperty(button1, "NormalTextColour", "FFAAAAAA")
        button0 = guiCreateButton(108, 243, 52, 42, "0", false, GUIEditor.window[1])
        guiSetFont(button0, "sa-header")
        guiSetProperty(button0, "NormalTextColour", "FFAAAAAA")
        button9 = guiCreateButton(165, 195, 52, 42, "9", false, GUIEditor.window[1])
        guiSetFont(button9, "sa-header")
        guiSetProperty(button9, "NormalTextColour", "FFAAAAAA")
        button8 = guiCreateButton(108, 195, 52, 42, "8", false, GUIEditor.window[1])
        guiSetFont(button8, "sa-header")
        guiSetProperty(button8, "NormalTextColour", "FFAAAAAA")
        button7 = guiCreateButton(52, 195, 52, 42, "7", false, GUIEditor.window[1])
        guiSetFont(button7, "sa-header")
        guiSetProperty(button7, "NormalTextColour", "FFAAAAAA")
        button6 = guiCreateButton(165, 148, 52, 42, "6", false, GUIEditor.window[1])
        guiSetFont(button6, "sa-header")
        guiSetProperty(button6, "NormalTextColour", "FFAAAAAA")
        button5 = guiCreateButton(108, 148, 52, 42, "5", false, GUIEditor.window[1])
        guiSetFont(button5, "sa-header")
        guiSetProperty(button5, "NormalTextColour", "FFAAAAAA")
        button4 = guiCreateButton(52, 148, 52, 42, "4", false, GUIEditor.window[1])
        guiSetFont(button4, "sa-header")
        guiSetProperty(button4, "NormalTextColour", "FFAAAAAA")
        button3 = guiCreateButton(165, 102, 52, 42, "3", false, GUIEditor.window[1])
        guiSetFont(button3, "sa-header")
        guiSetProperty(button3, "NormalTextColour", "FFAAAAAA")
        button2 = guiCreateButton(108, 102, 52, 42, "2", false, GUIEditor.window[1])
        guiSetFont(button2, "sa-header")
        guiSetProperty(button2, "NormalTextColour", "FFAAAAAA")
        editPinCode = guiCreateEdit(51, 61, 166, 31, "", false, GUIEditor.window[1])
        guiEditSetReadOnly(editPinCode, true)
        buttonReset = guiCreateButton(52, 243, 52, 42, "Reset", false, GUIEditor.window[1])
        guiSetFont(buttonReset, "default-bold-small")
        guiSetProperty(buttonReset, "NormalTextColour", "FFAAAAAA")
        buttonEnter = guiCreateButton(165, 243, 52, 42, "Enter", false, GUIEditor.window[1])
        guiSetFont(buttonEnter, "default-bold-small")
        guiSetProperty(buttonEnter, "NormalTextColour", "FFAAAAAA")
        GUIEditor.label[1] = guiCreateLabel(51, 23, 166, 28, "Enter a number between 0 and 9999", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[1], "default-bold-small")
        guiLabelSetColor(GUIEditor.label[1], 226, 42, 28)
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
        GUIEditor.label[2] = guiCreateLabel(244, 19, 13, 14, "X", false, GUIEditor.window[1])
        guiSetFont(GUIEditor.label[2], "default-bold-small")
        guiSetVisible(GUIEditor.window[1], false)

        addEventHandler("onClientGUIClick", buttonEnter, check, false)
    end
)

addEventHandler( "onClientMouseEnter", root,
    function()
        if (source == GUIEditor.label[2]) then
           guiLabelSetColor( source, 255, 255, 0)
        end
    end
)

addEventHandler( "onClientMouseLeave", root,
    function()
        if (source == GUIEditor.label[2]) then
            guiLabelSetColor( source, 255, 255, 255)
        end
    end
)

luckyNumber = 0
cracking = false
cracked = false
function openCracker(player)
    if (player == localPlayer) then
        guiSetVisible(GUIEditor.window[1], true)
        showCursor(true)
        guiEditSetMaxLength ( editPinCode, 4 )

        local number = math.random(1, 9999)
        luckyNumber = number
		if getDevelopmentMode() then
			outputDebugString ( "CCR: Lucky number: "..number)
		end
        guiSetText(GUIEditor.label[1], "Enter a number between 0 and 9999")
        guiLabelSetColor(GUIEditor.label[1], 226, 42, 28)
        guiSetText(editPinCode, "")
        cracking = true
        cracked = false
    end
end
addEvent("GTIccr.openCracker", true)
addEventHandler("GTIccr.openCracker", root, openCracker)

function jailCracker( plr)
	if guiGetVisible( GUIEditor.window[1]) == true then
        guiSetText(editPinCode, "")
        guiSetVisible(GUIEditor.window[1], false)
		showCursor( false)
	end
end
addEvent("GTIccr.closeSafeGUI", true)
addEventHandler("GTIccr.closeSafeGUI", root, jailCracker)

--[[
function openGUI()
    guiSetVisible(GUIEditor.window[1], true)
    local number = math.random(1, 9999)
    luckyNumber = number
    markerNumber = marker
    guiEditSetMaxLength ( editPinCode, 4 )
    showCursor(true)
    guiSetText(GUIEditor.label[1], "Enter a number between 0 and 9999")
    guiLabelSetColor(GUIEditor.label[1], 226, 42, 28)
    cracking = true
    cracked = false
end
addCommandHandler("openCCR", openGUI)
--]]

function buttonHandling()
    local input = guiGetText(editPinCode)
    if (source == button1) then
        guiSetText(editPinCode, input.."1")
    elseif (source == button2) then
        guiSetText(editPinCode, input.."2")
    elseif (source == button3) then
        guiSetText(editPinCode, input.."3")
    elseif (source == button4) then
        guiSetText(editPinCode, input.."4")
    elseif (source == button5) then
        guiSetText(editPinCode, input.."5")
    elseif (source == button6) then
        guiSetText(editPinCode, input.."6")
    elseif (source == button7) then
        guiSetText(editPinCode, input.."7")
    elseif (source == button8) then
        guiSetText(editPinCode, input.."8")
    elseif (source == button9) then
        guiSetText(editPinCode, input.."9")
    elseif (source == button0) then
        guiSetText(editPinCode, input.."0")
    elseif (source == buttonReset) then
        guiSetText(editPinCode, "")
    elseif (source == GUIEditor.label[2]) then
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
        luckyNumber = 0
        cracking = false
        --[[
        if (cracked == false) then
            triggerServerEvent("GTIccr.enableCracker", root, markerNumber)
        end
        --]]
        markerNumber = 0
    end
end
addEventHandler("onClientGUIClick", root, buttonHandling)

function numPadHandling(button, press)
    if (cracking == false) then return end
    local input = guiGetText(editPinCode)
    if (press) then
        if (button == "num_1") then
            guiSetText(editPinCode, input.."1")
        elseif (button == "num_2") then
            guiSetText(editPinCode, input.."2")
        elseif (button == "num_3") then
            guiSetText(editPinCode, input.."3")
        elseif (button == "num_4") then
            guiSetText(editPinCode, input.."4")
        elseif (button == "num_5") then
            guiSetText(editPinCode, input.."5")
        elseif (button == "num_6") then
            guiSetText(editPinCode, input.."6")
        elseif (button == "num_7") then
            guiSetText(editPinCode, input.."7")
        elseif (button == "num_8") then
            guiSetText(editPinCode, input.."8")
        elseif (button == "num_9") then
            guiSetText(editPinCode, input.."9")
        elseif (button == "num_0") then
            guiSetText(editPinCode, input.."0")
        elseif (button == "backspace") then
            guiSetText(editPinCode, "")
        elseif (button == "num_enter") then
            check()
        end
    end
end
addEventHandler("onClientKey", root, numPadHandling)

--[[addEventHandler("onClientGUIChanged", root, function(element)
    if source == editPinCode then
        local text = guiGetText(source)
        local number = tonumber(text)
        if number > 9999 then
            cancelEvent()
        end
    end
    end)]]--

function check()
    local text = guiGetText(editPinCode)
    local input = tonumber(text)
    local number = tonumber(luckyNumber)
    if (input and input < number) then
        guiSetText(GUIEditor.label[1], "Wrong! Choose a higher number.")
        guiSetText(editPinCode, "")
    elseif (input and input > number) then
        guiSetText(GUIEditor.label[1], "Wrong! Choose a lower number.")
        guiSetText(editPinCode, "")
    elseif (input == number) then
        guiSetText(GUIEditor.label[1], "You have cracked the safe!")
        guiLabelSetColor(GUIEditor.label[1], 55, 216, 38)
        guiSetText(editPinCode, "")
        guiSetVisible(GUIEditor.window[1], false)
		showCursor( false)
        cracking = false
        cracked = true
        triggerServerEvent("GTIccr.safeCracked", root, localPlayer)
    end
end
