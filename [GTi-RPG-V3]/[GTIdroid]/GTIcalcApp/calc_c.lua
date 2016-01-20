------------------------------------------------->>
-- PROJECT:			Grand Theft International
-- RESOURCE: 		GTIcalculatorapp/calc_c.lua
-- DESCRIPTION:		Calculator app for GTIdroid (Clientside)
-- AUTHOR:			Nerox
-- RIGHTS:			All rights reserved to author
------------------------------------------------->>
calculatorGUI = {
    img = {}
}
calcGUI = {
    button = {},
    img = {},
    label = {},
	gridlist = {},
	edit = {},
}
local isBracketsOpen = false
-- Fonts
local boldFont = guiCreateFont("bold.ttf", 17)
local sBoldFont = guiCreateFont("bold.ttf", 10)
local xsBoldFont = guiCreateFont("bold.ttf", 8)
-- Error downloading fonts
if not sBoldFont or not boldFont or not xsBoldFont then
	outputChatBox("There was an error downloading the GTI droid calculator's app font, Please reconnect", 255, 0, 0)
end
local savedM = "0"
-----------------------------------------
function calcCreateButton(x, y, w, h, relative, parent, color, text)
    local button = guiCreateStaticImage(x, y, w, h, "button.png", relative, parent)
	setElementData(button, "GTIcalculatorapp.color", color)
	guiSetProperty(button, "ImageColours", "tl:"..color.." tr:"..color.." bl:"..color.." br:"..color.."")
	local buttonText = guiCreateLabel(25, 15, 18, 18, text, false, button)
	if sBoldFont then
	guiSetFont ( buttonText, sBoldFont )
	end
	addEventHandler("onClientGUIClick", buttonText, function()
	guiSetProperty(button, "ImageColours", "tl:FF576B63 tr:FF576B63 bl:FF576B63 br:FF576B63")
	local buttonHex = getElementData(button, "GTIcalculatorapp.color")
	setTimer(function()
	guiSetProperty(button, "ImageColours", "tl:"..buttonHex.." tr:"..buttonHex.." bl:"..buttonHex.." br:"..buttonHex.."")
	end, 200, 1)
    end, false)
	addEventHandler("onClientGUIClick", button, function()
	local source = source
	guiSetProperty(source, "ImageColours", "tl:FF576B63 tr:FF576B63 bl:FF576B63 br:FF576B63")
	local buttonHex = getElementData(source, "GTIcalculatorapp.color")
	setTimer(function()
	guiSetProperty(source, "ImageColours", "tl:"..buttonHex.." tr:"..buttonHex.." bl:"..buttonHex.." br:"..buttonHex.."")
	end, 200, 1)
    end, false)
	if text == "1" or text == "2" or text == "3" or text == "4" or text == "5" or text == "6" or text == "7" or text == "8" or text == "9" or text == "0" then
	addEventHandler("onClientGUIClick", button, function()
	if guiGetText(calcGUI.label["Result"]) == "0" then
	guiSetText(calcGUI.label["Result"], guiGetText(buttonText))
	else
	guiSetText(calcGUI.label["Result"], guiGetText(calcGUI.label["Result"])..guiGetText(buttonText))
	updateGuiPosition("+", 1)
	end
	end, false)
	addEventHandler("onClientGUIClick", buttonText, function()
	if guiGetText(calcGUI.label["Result"]) == "0" then
	guiSetText(calcGUI.label["Result"], guiGetText(buttonText))
	else
	guiSetText(calcGUI.label["Result"], guiGetText(calcGUI.label["Result"])..guiGetText(buttonText))
	updateGuiPosition("+", 1)
	end
	end, false)
	elseif text == "+" or text == "-" or text == "/" or text == "x" or text == "^" or text == "." then
	addEventHandler("onClientGUIClick", button, function()
	guiSetText(calcGUI.label["Result"], guiGetText(calcGUI.label["Result"])..guiGetText(buttonText))
	updateGuiPosition("+", 1)
	end, false)
	addEventHandler("onClientGUIClick", buttonText, function()
	guiSetText(calcGUI.label["Result"], guiGetText(calcGUI.label["Result"])..guiGetText(buttonText))
	updateGuiPosition("+", 1)
	end, false)
	end
	addEventHandler("onClientMouseEnter", root, function()
	if source == button then
	guiSetProperty(source, "ImageColours", "tl:FF161616 tr:FF161616 bl:FF161616 br:FF161616")
	elseif source == buttonText then
	local theButton = getElementParent(source)
	guiSetProperty(theButton, "ImageColours", "tl:FF161616 tr:FF161616 bl:FF161616 br:FF161616")
	end
	end)
	addEventHandler("onClientMouseLeave", root, function()
	if source == button then
	local buttonHex = getElementData(source, "GTIcalculatorapp.color")
	guiSetProperty(source, "ImageColours", "tl:"..buttonHex.." tr:"..buttonHex.." bl:"..buttonHex.." br:"..buttonHex.."") 
	elseif source == buttonText then
	local theButton = getElementParent(source)
	local buttonHex = getElementData(theButton, "GTIcalculatorapp.color")
	guiSetProperty(theButton, "ImageColours", "tl:"..buttonHex.." tr:"..buttonHex.." bl:"..buttonHex.." br:"..buttonHex.."") 
	end
	end)
	adjustEventHandlers(text, buttonText)
	return button, buttonText
end
----------------------------------
function hideCalcApp()
    guiSetVisible(calculatorGUI.img["background"], false)
    exports.GTIdroid:showMainMenu(true)
end
function avoidBugs()
    if guiGetVisible(calculatorGUI.img["background"]) then
	hideCalcApp()
    end
end
addEventHandler("onGTIDroidClickBack", root, avoidBugs)
addEventHandler("onGTIDroidClose", root, hideCalcApp)
addEventHandler("onClientResourceStop", resourceRoot, hideCalcApp)

function showCalcApp()
    guiSetVisible(calculatorGUI.img["background"], true)
	exports.GTIdroid:showMainMenu(false, false)
	exports.GTIdroid:playTick()
end

------ GUI
local advancedOpColumn
local advancedOpRow = {}
local advancedOperations = {"Sin", "Cos", "Tan"}
function renderCalcGUI()
    if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
	GTIPhone = exports.GTIdroid:getGTIDroid()
	if (not GTIPhone) then return end
        calculatorApp = exports.GTIdroid:getGTIDroidAppButton("Calculator")
	addEventHandler("onClientGUIClick", calculatorApp, showCalcApp, false)
	calculatorGUI.img["background"] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
	guiSetVisible(calculatorGUI.img["background"], false)
	calcGUI.img["ResultBackground"] = guiCreateStaticImage(1, 7, 269, 41, "button.png", false, calculatorGUI.img["background"])
    guiSetProperty(calcGUI.img["ResultBackground"], "ImageColours", "tl:FF000000 tr:FF000000 bl:FF000000 br:FF000000")
    --calcGUI.label["Result"] = guiCreateLabel(4, 1, 255, 36, "0", false, calcGUI.img["ResultBackground"])
	calcGUI.label["Result"] = guiCreateLabel(4, 1, 100000, 36, "0", false, calcGUI.img["ResultBackground"])
	if boldFont then
    guiSetFont(calcGUI.label["Result"], boldFont)
	end
	calcGUI.button["Advanced"] = calcCreateButton(72, 122, 58, 51, false, calculatorGUI.img["background"], "FF303030", " ")
	calcGUI.label["Advanced:Operation"] = guiCreateLabel(25, 15, 18, 18, "Cos", false, calcGUI.button["Advanced"])
	-->>
	addEventHandler("onClientMouseEnter", root, function()
	if source == calcGUI.label["Advanced:Operation"] then
	local theButton = getElementParent(source)
	guiSetProperty(theButton, "ImageColours", "tl:FF161616 tr:FF161616 bl:FF161616 br:FF161616")
	end
	end)
	addEventHandler("onClientMouseLeave", root, function()
	if source == calcGUI.label["Advanced:Operation"] then
	local theButton = getElementParent(source)
	local buttonHex = getElementData(theButton, "GTIcalculatorapp.color")
	guiSetProperty(theButton, "ImageColours", "tl:"..buttonHex.." tr:"..buttonHex.." bl:"..buttonHex.." br:"..buttonHex.."") 
	end
	end)
	addEventHandler("onClientGUIClick", calcGUI.label["Advanced:Operation"], function()
	local source = getElementParent(source)
	guiSetProperty(source, "ImageColours", "tl:FF576B63 tr:FF576B63 bl:FF576B63 br:FF576B63")
	local buttonHex = getElementData(source, "GTIcalculatorapp.color")
	setTimer(function()
	guiSetProperty(source, "ImageColours", "tl:"..buttonHex.." tr:"..buttonHex.." bl:"..buttonHex.." br:"..buttonHex.."")
	end, 200, 1)
    end, false)
	--<<
	calcGUI.button["Advanced:Scroll"] = guiCreateStaticImage(50, 2, 10, 10, "scroll_icon.png", false, calcGUI.button["Advanced"])
	calcGUI.gridlist["Advanced:List"] = guiCreateGridList( 72, 130, 80, 80, false, calculatorGUI.img["background"] )
	advancedOpColumn = guiGridListAddColumn( calcGUI.gridlist["Advanced:List"], " ", 1)
	if ( advancedOpColumn ) then
	for k, v in ipairs(advancedOperations) do
	advancedOpRow[v] = guiGridListAddRow ( calcGUI.gridlist["Advanced:List"] )
	guiGridListSetItemText ( calcGUI.gridlist["Advanced:List"], advancedOpRow[v], advancedOpColumn, v, false, false )
	end
	end
	guiSetAlpha(calcGUI.gridlist["Advanced:List"], 0.7)
	guiSetVisible(calcGUI.gridlist["Advanced:List"], false)
	calcGUI.button["Brackets"] = guiCreateLabel(250, 25, 18, 18, "( )", false, calcGUI.img["ResultBackground"])
	if xsBoldFont then
	guiSetFont ( calcGUI.label["Advanced:Operation"], xsBoldFont )
	guiSetFont ( calcGUI.button["Brackets"], xsBoldFont )
	end
	calcGUI.button["Clear"] = calcCreateButton(10, 54, 58, 51, false, calculatorGUI.img["background"], "FF303030", "C")
    calcGUI.button["Devide"] = calcCreateButton(197, 122, 63, 51, false, calculatorGUI.img["background"], "FF303030", "/")
    calcGUI.button["M+"] = calcCreateButton(197, 54, 63, 51, false, calculatorGUI.img["background"], "FF303030", "M+")
    calcGUI.button["Multiple"] = calcCreateButton(197, 179, 63, 51, false, calculatorGUI.img["background"], "FF303030", "x")
    calcGUI.button["Plus"] = calcCreateButton(197, 236, 63, 51, false, calculatorGUI.img["background"], "FF303030", "+")
    calcGUI.button["Minus"] = calcCreateButton(197, 293, 63, 51, false, calculatorGUI.img["background"], "FF303030", "-")
    calcGUI.button["Result"] = calcCreateButton(197, 361, 63, 51, false, calculatorGUI.img["background"], "FFFF2C2C", "=")--FFFF2C2C --FFB41700
    calcGUI.button[10] = calcCreateButton(10, 361, 104, 51, false, calculatorGUI.img["background"], "FF393939", "0")
    calcGUI.button[11] = calcCreateButton(124, 361, 63, 51, false, calculatorGUI.img["background"], "FF393939", ".")
    calcGUI.button[1] = calcCreateButton(10, 293, 58, 51, false, calculatorGUI.img["background"], "FF393939", "1")-- 7 
    calcGUI.button[2] = calcCreateButton(72, 293, 58, 51, false, calculatorGUI.img["background"], "FF393939", "2") -- 8
    calcGUI.button[3] = calcCreateButton(134, 293, 58, 51, false, calculatorGUI.img["background"], "FF393939", "3") --9
    calcGUI.button[6] = calcCreateButton(134, 236, 58, 51, false, calculatorGUI.img["background"], "FF393939", "6")
    calcGUI.button[5] = calcCreateButton(72, 236, 58, 51, false, calculatorGUI.img["background"], "FF393939", "5")
    calcGUI.button[4] = calcCreateButton(10, 236, 58, 51, false, calculatorGUI.img["background"], "FF393939", "4")
    calcGUI.button[7] = calcCreateButton(10, 180, 58, 51, false, calculatorGUI.img["background"], "FF393939", "7") -- 1
    calcGUI.button[9] = calcCreateButton(134, 179, 58, 51, false, calculatorGUI.img["background"], "FF393939", "9") --3
    calcGUI.button[8] = calcCreateButton(72, 180, 58, 51, false, calculatorGUI.img["background"], "FF393939", "8") --2
    calcGUI.button["sqrt"] = calcCreateButton(134, 122, 58, 51, false, calculatorGUI.img["background"], "FF303030", "^")
    calcGUI.button["MC"] = calcCreateButton(72, 54, 58, 51, false, calculatorGUI.img["background"], "FF303030", "MC")
    calcGUI.button["MR"] = calcCreateButton(134, 54, 58, 51, false, calculatorGUI.img["background"], "FF303030", "MR")
    calcGUI.button["Remove"] = calcCreateButton(10, 122, 58, 51, false, calculatorGUI.img["background"], "FFFF2C2C","<<")--FFFB4339
    adjustEventHandlers2()
end
addEventHandler("onClientResourceStart", resourceRoot, renderCalcGUI)
addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, renderCalcGUI)
----------------------------------------------------------
function adjustEventHandlers(text, button)
    if text == "<<" then
    addEventHandler("onClientGUIClick", button, removeLastDigit, false)
	elseif text == "MC" or text == "MR" or text == "M+" then
	addEventHandler("onClientGUIClick", button, saveM)
	elseif text == "C" then
	addEventHandler("onClientGUIClick", button, clearResultLabel, false)
	elseif text == "=" then
	addEventHandler("onClientGUIClick", button, outputResult, false)
	end
end
function removeLastDigit()
    local text = guiGetText(calcGUI.label["Result"])
	local lastLetter = string.sub(text, string.len(text), string.len(text)+string.len(text)-1)
	if lastLetter == "(" then
	isBracketsOpen = false
	elseif lastLetter == ")" then
	isBracketsOpen = true
	end
	last3Letters = string.sub(text, string.len(text)-2, (string.len(text)-string.len(text)-1))
	if last3Letters == "Cos" or last3Letters == "Sin" or last3Letters == "Tan" then
	guiSetText(calcGUI.label["Result"], string.sub(text, 1, string.len(text)-3))
	updateGuiPosition("-", 3)
	return	
	end
    guiSetText(calcGUI.label["Result"], string.sub(text, 1, string.len(text)-1))
	updateGuiPosition("-", 1)
	if guiGetText(calcGUI.label["Result"]) == "" then
	guiSetText(calcGUI.label["Result"], "0")
	updateGuiPosition("+", 1)
end
end
function saveM()
    if source == calcGUI.button["M+"] or guiGetText(source) == "M+" then
    savedM = guiGetText(calcGUI.label["Result"])
	elseif source == calcGUI.button["MR"] or guiGetText(source) == "MR" then
	guiSetText(calcGUI.label["Result"], savedM)
	elseif source == calcGUI.button["MC"] or guiGetText(source) == "MC" then
	savedM = "0"
	end
end
function clearResultLabel()
    guiSetText(calcGUI.label["Result"], 0)
	updateGuiPosition("-", 0)
	isBracketsOpen = false
end
function outputResult()
	if isBracketsOpen then
		closeOpenBrackets()
	end
    local number = guiGetText(calcGUI.label["Result"])
	number = string.gsub(number, "x", "*")
	local numberToCalc = number
	local result
	-- for Cosenus
	if string.find(number, "Cos", 1) then
		for word in numberToCalc:gmatch("Cos-%((.-)%)") do
    		--numberToCalc = numberToCalc:match("Cos-%((.-)%)")
			result = calculate(word)
			if result then
				result = math.cos(math.rad(result))
				number = string.gsub(number, "Cos-%((.-)%)", "("..result..")")
			else
                showError(number, "Invalid input")
			end
		end
    end
	-- for Sinus
	if string.find(number, "Sin", 1) then
		for word in numberToCalc:gmatch("Sin-%((.-)%)") do
			--numberToCalc = numberToCalc:match("Sin-%((.-)%)")
			result = calculate(word)
			if result then
				result = math.sin(math.rad(result))
				number = string.gsub(number, "Sin-%((.-)%)", "("..result..")")
			else
                showError(number, "Invalid input")
			end
		end
	end
	-- for Tan
	if string.find(number, "Tan", 1) then
		for word in numberToCalc:gmatch("Tan-%((.-)%)") do
			--numberToCalc = numberToCalc:match("Tan-%((.-)%)")
			result = calculate(word)
			if result then
				result = math.tan(math.rad(result))
				number = string.gsub(number, "Tan-%((.-)%)", "("..result..")")
			else
				showError(number, "Invalid input")
			end
		end
	end
	result = calculate(number)
	if result == "1.#INF" or result == "-1.#IND" then
	    return showError(number, "You can't divide by 0")
	end
	if not result then
	    showError(number, "Invalid input")
	else
		guiSetText(calcGUI.label["Result"], result)
	end
end
function showError(default, errorMsg)
	guiSetText(calcGUI.label["Result"], errorMsg)
	setTimer(guiSetText, 1500, 1,calcGUI.label["Result"], default)
end
function showAdvancedOpList()
    if guiGetVisible(calcGUI.gridlist["Advanced:List"]) then
	guiSetVisible(calcGUI.gridlist["Advanced:List"], false)
	else
	guiSetVisible(calcGUI.gridlist["Advanced:List"], true)
	guiBringToFront(calcGUI.gridlist["Advanced:List"])
	end
end
function hideAdvancedOpList()
    if source ~= calcGUI.gridlist["Advanced:List"] then
	guiSetVisible(calcGUI.gridlist["Advanced:List"], false)
	end
end
function selectAdvancedOp()
    local selectedItem = guiGridListGetItemText(calcGUI.gridlist["Advanced:List"], guiGridListGetSelectedItem ( calcGUI.gridlist["Advanced:List"], advancedOpColumn))
    guiSetText(calcGUI.label["Advanced:Operation"], selectedItem)
	guiSetVisible(calcGUI.gridlist["Advanced:List"], false)
end
function outputAdvancedOp()
    local text = guiGetText(calcGUI.label["Result"])
	local lastLetter = string.sub(text, string.len(text), string.len(text)+string.len(text)-1)
    if isBracketsOpen then
    closeOpenBrackets()
	end
	if lastLetter == "+" or lastLetter == "-" or lastLetter == "/" or lastLetter == "x" or lastLetter == "^" then
	guiSetText(calcGUI.label["Result"], guiGetText(calcGUI.label["Result"]) .. guiGetText(calcGUI.label["Advanced:Operation"]))
	updateGuiPosition("+", 3)
	else
	guiSetText(calcGUI.label["Result"], guiGetText(calcGUI.label["Result"]) .. "x" .. guiGetText(calcGUI.label["Advanced:Operation"]))
	updateGuiPosition("+", 4)
	end
	closeOpenBrackets()
end
function closeOpenBrackets()
    local text = guiGetText(calcGUI.label["Result"])
	local lastLetter = string.sub(text, string.len(text), string.len(text)+string.len(text)-1)
    if isBracketsOpen then
	guiSetText(calcGUI.label["Result"], guiGetText(calcGUI.label["Result"]) .. ")")
	isBracketsOpen = false
	else
	guiSetText(calcGUI.label["Result"], guiGetText(calcGUI.label["Result"]) .. "(")
	isBracketsOpen = true
	end
	updateGuiPosition("+", 1)
end
function updateGuiPosition(updown, number)
   local x, y = guiGetPosition ( calcGUI.label["Result"], false )
   local newx = 0
   local length
   if string.len(guiGetText(calcGUI.label["Result"])) >= 19 then
   length = string.len(guiGetText(calcGUI.label["Result"]))-18
   newx = 4
   for i=1, length do
   newx = newx - 12
   guiSetPosition(calcGUI.label["Result"], newx, y, false)
   end
   else
   guiSetPosition(calcGUI.label["Result"], 4, 1, false)
   end
end
function adjustEventHandlers2()
    addEventHandler("onClientGUIClick", calcGUI.button["Remove"], removeLastDigit, false)
	addEventHandler("onClientGUIClick", calcGUI.button["M+"], saveM)
	addEventHandler("onClientGUIClick", calcGUI.button["MR"], saveM)
	addEventHandler("onClientGUIClick", calcGUI.button["MC"], saveM)
	addEventHandler("onClientGUIClick", calcGUI.button["Clear"], clearResultLabel, false)
	addEventHandler("onClientGUIClick", calcGUI.button["Result"], outputResult, false)
	addEventHandler("onClientGUIClick", calcGUI.button["Advanced:Scroll"], showAdvancedOpList, false)
	addEventHandler("onClientGUIClick", calculatorGUI.img["background"], hideAdvancedOpList, false)
	addEventHandler("onClientGUIClick", calcGUI.gridlist["Advanced:List"], selectAdvancedOp, false)
	addEventHandler("onClientGUIClick", calcGUI.button["Brackets"], closeOpenBrackets, false)
	addEventHandler("onClientGUIClick", calcGUI.button["Advanced"], outputAdvancedOp, false)
	addEventHandler("onClientGUIClick", calcGUI.label["Advanced:Operation"], outputAdvancedOp, false)
end
function calculate(text)
    text = text..'€'
    local number = ''
    for i,sinal,result in text:gmatch("(%(*%d+%.*%d*%)*)%s*([+-/%*^%%])") do
    number = number ..i..sinal
    end
    if text:match(".+%s*(%([-]*%d+%)*)€") then
    number = number..text:match(".+%s*(%([-]*%d+%)*)€")
    elseif text:match('.+%s*(%(*[-]%d+%.*%d*%)*)€') then
    if number:sub(number:len(),number:len()) ~= '-' then
    number = number..text:match('%l*(%(*[-]%d+%.*%d*%)*)€')
    else
    number = number..text:match('%l*(%(*%d+%.*%d*%)*)€')
    end
    elseif text:match("%l*(%(*[-]*%d+%.*%d*%)*)€") then
    number = number..text:match('%l*(%(*[-]*%d+%)*)€')
    end
    if number == "" then
    return false
    end
    local f,result = loadstring("return "..number)
    if not f and result then
    return false
    end
    local f,result = pcall(f)
    if not f and result then    return false
    end
    return tostring(result)
end
