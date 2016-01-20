addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local sWidth, sHeight = guiGetScreenSize()
		local Width,Height = 660,250
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
        Window = guiCreateWindow(X, Y, Width, Height, "GTI Minerals Market", false)
        guiWindowSetSizable(Window, false)
        guiSetAlpha(Window, 0.98)
        guiSetProperty(Window, "CaptionColour", "FF627B94")

        local font_0 = guiCreateFont(":GTImining/misc/PetitFormalScript.ttf")
        SellButton = guiCreateButton(287, 208, 95, 33, "Sell", false, Window)
        guiSetFont(SellButton, font_0)
        guiSetProperty(SellButton, "NormalTextColour", "FF5F8BA1")
        calcButton = guiCreateButton(187, 208, 95, 33, "Estimate", false, Window)
        guiSetFont(calcButton, font_0)
        guiSetProperty(calcButton, "NormalTextColour", "FF5F8BA1")
        ImageCopper = guiCreateStaticImage(16, 44, 58, 65, ":GTImining/misc/element.png", false, Window)
        AmountCopper = guiCreateLabel(16, 116, 47, 16, "?? $", false, Window)
        guiSetFont(AmountCopper, "default-bold-small")
        guiLabelSetColor(AmountCopper, 126, 123, 78)
        GramCopper = guiCreateLabel(17, 132, 47, 15, "?? G", false, Window)
        guiSetFont(GramCopper, "default-bold-small")
        guiLabelSetColor(GramCopper, 126, 123, 78)
        guiLabelSetHorizontalAlign(GramCopper, "left", true)
        AmountSilver = guiCreateLabel(157, 116, 47, 16, "?? $", false, Window)
        guiSetFont(AmountSilver, "default-bold-small")
        guiLabelSetColor(AmountSilver, 126, 123, 78)
        GramSilver = guiCreateLabel(157, 132, 47, 15, "?? G", false, Window)
        guiSetFont(GramSilver, "default-bold-small")
        guiLabelSetColor(GramSilver, 126, 123, 78)
        ImageSilver = guiCreateStaticImage(156, 44, 58, 65, ":GTImining/misc/element2.png", false, Window)
        AmountMagnesium = guiCreateLabel(289, 116, 47, 16, "?? $", false, Window)
        guiSetFont(AmountMagnesium, "default-bold-small")
        guiLabelSetColor(AmountMagnesium, 126, 123, 78)
        GramIron = guiCreateLabel(421, 132, 47, 15, "?? G", false, Window)
        guiSetFont(GramIron, "default-bold-small")
        guiLabelSetColor(GramIron, 126, 123, 78)
        ImageMagnesium = guiCreateStaticImage(288, 45, 58, 65, ":GTImining/misc/element3.png", false, Window)
        AmountIron = guiCreateLabel(421, 116, 47, 16, "?? $", false, Window)
        guiSetFont(AmountIron, "default-bold-small")
        guiLabelSetColor(AmountIron, 126, 123, 78)
        GramMagnesium = guiCreateLabel(289, 132, 47, 15, "?? G", false, Window)
        guiSetFont(GramMagnesium, "default-bold-small")
        guiLabelSetColor(GramMagnesium, 126, 123, 78)
        ImageIron = guiCreateStaticImage(421, 45, 58, 65, ":GTImining/misc/element4.png", false, Window)
        AmountGold = guiCreateLabel(546, 116, 47, 16, "?? $", false, Window)
        guiSetFont(AmountGold, "default-bold-small")
        guiLabelSetColor(AmountGold, 126, 123, 78)
        GramGold = guiCreateLabel(546, 132, 47, 15, "?? G", false, Window)
        guiSetFont(GramGold, "default-bold-small")
        guiLabelSetColor(GramGold, 126, 123, 78)
        ImageGold = guiCreateStaticImage(546, 45, 57, 65, ":GTImining/misc/element5.png", false, Window)
        Total = guiCreateLabel(173, 186, 324, 17, "Grand Total: ??", false, Window)
        local font_1 = guiCreateFont(":GTImining/misc/EmblemaOne.ttf")
        guiSetFont(Total, font_1)
        guiLabelSetColor(Total, 126, 196, 3)
        TotalGrams = guiCreateLabel(373, 186, 324, 17, "Total grams of rocks:", false, Window)
        guiSetFont(TotalGrams, font_1)
        guiLabelSetColor(TotalGrams, 126, 196, 3)
        close = guiCreateButton(599, 217, 51, 23, "Close", false, Window)
        guiSetFont(close, "default-bold-small")
        guiSetProperty(close, "NormalTextColour", "FF8B8B8B")
        CopperTitle = guiCreateLabel(18, 28, 56, 15, "Copper", false, Window)
        local font_2 = guiCreateFont(":GTImining/misc/robo.ttf")
        guiSetFont(CopperTitle, font_2)
        guiLabelSetColor(CopperTitle, 242, 132, 3)
        SilverTitle = guiCreateLabel(157, 28, 53, 15, "Silver", false, Window)
        guiSetFont(SilverTitle, font_2)
        guiLabelSetColor(SilverTitle, 98, 123, 148)
        MagnesiumTitle = guiCreateLabel(288, 28, 144, 15, "Magnesium", false, Window)
        guiSetFont(MagnesiumTitle, font_2)
        guiLabelSetColor(MagnesiumTitle, 242, 132, 3)
        IronTitle = guiCreateLabel(433, 28, 35, 15, "Iron", false, Window)
        guiSetFont(IronTitle, font_2)
        guiLabelSetColor(IronTitle, 93, 93, 93)
        GoldTitle = guiCreateLabel(552, 30, 45, 15, "Gold", false, Window)
        guiSetFont(GoldTitle, font_2)
        guiLabelSetColor(GoldTitle, 240, 210, 4)    
		guiSetVisible(Window, false)
    end
)

local elementsTable = {--Name of the element,how much per gram of rock, how much $$ per unit
["Gold"] = {0.01,8.2},
["Silver"] = {0.04,3.3},
["Copper"] = {0.08,2.3},
["Iron"] = {0.55,0.3},
["Magnesium"] = {0.3,0.55},
}
function showTradingGUI()
	guiSetVisible(Window, true)
	showCursor(true)
	local gram = getGrams()
	guiSetText(TotalGrams,"Total grams of rocks: "..gram.." G")
end
function hideTradingGUI()
	if guiGetVisible(Window) then
		guiSetVisible(Window, false)
		showCursor(false)
		triggerServerEvent("GTImining.freeze", resourceRoot, false)
		toggleAllControls(true)
		calculated = false
		PayTotal = false
		guiSetText(GramIron,"?? G")
		guiSetText(AmountIron, "?? $")
		guiSetText(GramCopper,"?? G")
		guiSetText(AmountCopper, "?? $")
		guiSetText(GramSilver,"?? G")
		guiSetText(AmountSilver, "?? $")
		guiSetText(GramMagnesium,"?? G")
		guiSetText(AmountMagnesium, "?? $")
		guiSetText(GramGold,"?? G")
		guiSetText(AmountGold, "?? $")
		guiSetText(Total, "Grand Total: ??")
		if isTimer(calcTimer) then
			killTimer(calcTimer)
			exports.GTIhud:drawProgressBar("MiningPro", "", 255, 200, 0, 0)
		end
		if isTimer(payTimer) then
			killTimer(payTimer)
			exports.GTIhud:drawProgressBar("MiningPro", "", 255, 200, 0, 0)
		end
	end
end

addEvent ("onIronLoad", true )
addEventHandler ("onIronLoad", root, function ( ironP ) setElementData ( source, "iron", ironP, false ) end )

function handleBtns()
	if ( source == close ) then
		hideTradingGUI()
	elseif ( source == calcButton ) then
		if calculated then return end
		calcTimer = setTimer(triggerServerEvent,6500,1,"GTImining.getPayOffset", resourceRoot)
		exports.GTIhud:drawProgressBar("MiningPro", "Estimating...", 255, 200, 0, 6700)
		calculated = true
	elseif ( source == SellButton) then
		if not calculated or not PayTotal or isTimer(payTimer) then exports.GTIhud:dm("You must estimate how much elements you have before.", 255, 0, 0) return end
		local gram = getGrams()
		local ironPP = setElementData ( localPlayer, "iron", gram, false )
		local secs = gram*4
		payTimer = setTimer(function(gram)
		triggerServerEvent("GTImining.Pay", resourceRoot, PayTotal, gram)
		hideTradingGUI()
		noGram()
		PayTotal = false
		end,secs,1,gram)
		exports.GTIhud:drawProgressBar("MiningPro", "Crafting...", 255, 200, 0, secs)
	end
end
addEventHandler("onClientGUIClick",root,handleBtns)

addEvent("GTImining.calculate", true)
addEventHandler("GTImining.calculate", root, function(poffset)
	PayTotal = 0
	local grams = getGrams()
	--
	local unitc,unitcpay = elementsTable["Copper"][1],elementsTable["Copper"][2]
	gramC = math.ceil(grams*unitc)
	PayTotal = math.ceil(gramC*unitcpay)+PayTotal
	Copper = math.ceil((gramC*unitcpay)*poffset)
	guiSetText(GramCopper,gramC.." G")
	guiSetText(AmountCopper, Copper.."$")
	--
	local uniti,unitipay = elementsTable["Iron"][1],elementsTable["Iron"][2]
	gramI = math.ceil(grams*uniti)
	PayTotal = math.ceil(gramI*unitipay)+PayTotal
	Iron = math.ceil((gramI*unitipay)*poffset)
	guiSetText(GramIron,gramI.." G")
	guiSetText(AmountIron, Iron.."$")
	ironP = getElementData ( localPlayer, "iron" )
	--
	local units,unitspay = elementsTable["Silver"][1],elementsTable["Silver"][2]
	gramS = math.ceil(grams*units)
	PayTotal = math.ceil(gramS*unitspay)+PayTotal
	Silver = math.ceil((gramS*unitspay)*poffset)
	guiSetText(GramSilver,gramS.." G")
	guiSetText(AmountSilver, Silver.."$")
	--
	local unitb,unitbpay = elementsTable["Magnesium"][1],elementsTable["Magnesium"][2]
	gramB = math.ceil(grams*unitb)
	PayTotal = math.ceil(gramB*unitbpay)+PayTotal
	Magnesium = math.ceil((gramB*unitbpay)*poffset)
	guiSetText(GramMagnesium,gramB.." G")
	guiSetText(AmountMagnesium, Magnesium.."$")
	--
	local unitg,unitgpay = elementsTable["Gold"][1],elementsTable["Gold"][2]
	gramG = math.ceil(grams*unitg)
	PayTotal = math.ceil(gramG*unitgpay)+PayTotal
	Gold = math.ceil((gramG*unitgpay)*poffset)
	guiSetText(GramGold,gramG.." G")
	guiSetText(AmountGold, Gold.."$")
	--
	GrandTotal = Copper+Iron+Silver+Magnesium+Gold
	GrandTotalGrams = gramB+gramC+gramG+gramS+gramI
	guiSetText(Total, "Grand Total: "..GrandTotal.."$")
end)