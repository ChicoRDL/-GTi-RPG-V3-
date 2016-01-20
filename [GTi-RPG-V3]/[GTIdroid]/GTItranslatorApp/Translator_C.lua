----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Ares
-- Date: 10 Jul 2015
----------------------------------------->>

local Translator = { window = {}, button = {}, label = {}, memo = {}, combobox = {}, radiobutton = {} }
local Languages = { ["English"] = "EN", ["Spanish"] = "ES", ["Arabic"] = "AR", ["Portuguese"] = "PT", ["Italian"] = "IT", ["French"] = "FR" }

function createTranslatorUI ( )
	if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
		GTIPhone = exports.GTIdroid:getGTIDroid()
		if (not GTIPhone) then return end
		GTIApp = exports.GTIdroid:getGTIDroidAppButton("Translator")
		addEventHandler("onClientGUIClick", GTIApp, showTranslatorUI, false)

		Translator.window[1] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
		guiSetVisible(Translator.window[1], false)

		Translator.button[1] = guiCreateStaticImage(0, 392, 300, 36, ":GTIdroid/wallpapers/bkgr_white.png", false, Translator.window[1])
		guiSetAlpha(Translator.button[1], 0.46)

		Translator.label[1] = guiCreateLabel(0, 0, 265, 35, "Translate", false, Translator.button[1])
		guiSetFont(Translator.label[1], "default-bold-small")
		guiLabelSetColor(Translator.label[1], 0, 0, 0)
		guiLabelSetHorizontalAlign(Translator.label[1], "center", false)
		guiLabelSetVerticalAlign(Translator.label[1], "center")

		Translator.memo[1] = guiCreateMemo(10, 148, 251, 230, "", false, Translator.window[1])
		Translator.combobox[1] = guiCreateComboBox(20, 83, 111, 125, "", false, Translator.window[1])
			for languages in pairs ( Languages ) do
				guiComboBoxAddItem ( Translator.combobox[1], languages )
			end
		Translator.combobox[2] = guiCreateComboBox(146, 83, 111, 125, "", false, Translator.window[1])
			for languages in pairs ( Languages ) do
				guiComboBoxAddItem ( Translator.combobox[2], languages )
			end
		Translator.radiobutton[1] = guiCreateRadioButton(19, 114, 125, 24, "Machine translation", false, Translator.window[1])
		Translator.radiobutton[2] = guiCreateRadioButton(146, 114, 117, 24, "Human translation", false, Translator.window[1])
		guiRadioButtonSetSelected(Translator.radiobutton[1], true)
		Translator.label[2] = guiCreateLabel(33, 62, 80, 16, "From", false, Translator.window[1])
		Translator.label[3] = guiCreateLabel(163, 61, 80, 16, "To", false, Translator.window[1])    
end

addEventHandler("onClientResourceStart", resourceRoot, createTranslatorUI)
addEventHandler("onGTIPhoneCreate", root, createTranslatorUI)

function showTranslatorUI()
	guiSetVisible(Translator.window[1], true)
	exports.GTIdroid:showMainMenu(false, false)
	exports.GTIdroid:playTick()
end

function hideTranslatorUI()
	guiSetVisible(Translator.window[1],false)
	exports.GTIdroid:showMainMenu(true)
end
addEventHandler("onGTIDroidClose", root, hideTranslatorUI)
addEventHandler("onGTIDroidClickBack", root, hideTranslatorUI)
addEventHandler("onClientResourceStop", resourceRoot, hideTranslatorUI)

function onButtonMouseEnter ( )
	if ( source == Translator.button[1] or source == Translator.label[1] ) then
		guiSetProperty(Translator.button[1], "ImageColours", "tl:FF70704D tr:FF70704D bl:FF70704D br:FF70704D")
	end
end
addEventHandler("onClientMouseEnter", root, onButtonMouseEnter)

function onButtonMouseLeave ( )
	if ( source == Translator.button[1] or source == Translator.label[1] ) then
		guiSetProperty(Translator.button[1], "ImageColours", "tl:FFFFFFFF tr:FFFFFFFF bl:FFFFFFFF br:FFFFFFFF")
	end
end
addEventHandler("onClientMouseLeave", root, onButtonMouseLeave)

function onTranslateClick ( )
	if ( source == Translator.button[1] or source == Translator.label[1] ) then
		if ( guiGetText ( Translator.label[1] ) == "Translating..." ) then return end
	
		text = guiGetText ( Translator.memo[1] )
		from = guiComboBoxGetItemText ( Translator.combobox[1], guiComboBoxGetSelected ( Translator.combobox[1] ) )
		to = guiComboBoxGetItemText ( Translator.combobox[2], guiComboBoxGetSelected ( Translator.combobox[2] ) )
		
		if ( guiRadioButtonGetSelected ( Translator.radiobutton[1] ) ) then
			translationType = 1
		else
			translationType = 0
		end
		
		if ( text == "" or from == "" or to == "" ) then return end
		if ( from == to ) then guiSetText ( Translator.label[1], text) end

		guiSetText ( Translator.label[1], "Translating..." )
		language = Languages[from].."|"..Languages[to]

		triggerServerEvent("GTItranslatorApp.translate", resourceRoot, {text, language, translationType} )
		failedTranslation = setTimer ( guiSetText, 15000, 1, Translator.button[1], "Translate" )
	end
end
addEventHandler("onClientGUIClick", root, onTranslateClick)

addEvent("GTItranslatorApp.receiveTranslation", true)
addEventHandler("GTItranslatorApp.receiveTranslation", resourceRoot, 
	function ( response )	
		if ( isTimer ( failedTranslation ) ) then killTimer ( failedTranslation ) end
		guiSetText ( Translator.memo[1], response or "" )
		guiSetText ( Translator.label[1], "Translate" )
		exports.GTIdroid:playTick()
	end
)

