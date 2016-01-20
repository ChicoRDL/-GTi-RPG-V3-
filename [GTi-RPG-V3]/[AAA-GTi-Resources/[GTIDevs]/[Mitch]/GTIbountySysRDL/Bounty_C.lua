--author="ChicoRDL"

addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local screenW,screenH = guiGetScreenSize()
		local x,y = (screenW-632)/2,(screenH-446)/2
	
        MainWindow = guiCreateWindow(x, y, 632, 446, "GTI-RPG Bounty Panel", false)
        guiWindowSetSizable(MainWindow, false)
		guiSetVisible(MainWindow, false)

        daTab = guiCreateTabPanel(14, 121, 341, 258, false, MainWindow)
        daTab1 = guiCreateTab("Hits Bounty", daTab)

        Opt1 = guiCreateRadioButton(12, 46, 146, 21, "Bounty for $100", false, daTab1)
        guiSetProperty(Opt1, "NormalTextColour", "FF50EC12")
		-- exports.GTIgui:setDefaultFont(Opt1, 9)
        Opt2 = guiCreateRadioButton(12, 82, 146, 21, "Bounty for $50.000", false, daTab1)
        guiSetProperty(Opt2, "NormalTextColour", "FF95EF07")
		-- exports.GTIgui:setDefaultFont(Opt2, 9)		
        Opt3 = guiCreateRadioButton(12, 120, 146, 21, "Bounty for $75.000", false, daTab1)
        guiSetProperty(Opt3, "NormalTextColour", "FFECC903")
		-- exports.GTIgui:setDefaultFont(Opt3, 9)
        Opt4 = guiCreateRadioButton(12, 156, 146, 21, "Bounty for $100.000", false, daTab1)
        guiSetProperty(Opt4, "NormalTextColour", "FFF19402")
		-- exports.GTIgui:setDefaultFont(Opt4, 9)
        Opt5 = guiCreateRadioButton(185, 46, 146, 21, "Bounty for $150.000", false, daTab1)
        guiSetProperty(Opt5, "NormalTextColour", "FFF06C02")
		-- exports.GTIgui:setDefaultFont(Opt5, 9)
        Opt6 = guiCreateRadioButton(185, 82, 146, 21, "Bounty for $200.000", false, daTab1)
        guiSetProperty(Opt6, "NormalTextColour", "FFF14A08")
		-- exports.GTIgui:setDefaultFont(Opt6, 9)
        Opt7 = guiCreateRadioButton(185, 120, 146, 21, "Bounty for $350.000", false, daTab1)
        guiSetProperty(Opt7, "NormalTextColour", "FFF32004")
		-- exports.GTIgui:setDefaultFont(Opt7, 9)
        Opt8 = guiCreateRadioButton(185, 156, 146, 21, "Bounty for $500.000", false, daTab1)
        guiSetProperty(Opt8, "NormalTextColour", "FFF80000")
		-- exports.GTIgui:setDefaultFont(Opt8, 9)
        InfoLabel = guiCreateLabel(14, 9, 313, 47, "Hello and welcome to Hit Center, you can select your hit price over here.", false, daTab1)
        guiLabelSetColor(InfoLabel, 200, 225, 125)
        guiLabelSetHorizontalAlign(InfoLabel, "center", true)
		-- exports.GTIgui:setDefaultFont(InfoLabel, 8)
        hitBtn = guiCreateButton(0, 187, 341, 47, "Bounty!", false, daTab1)
        guiSetProperty(hitBtn, "NormalTextColour", "FFFFEA00")
		-- exports.GTIgui:setDefaultFont(hitBtn, 10)
        
		daTab2 = guiCreateTab("Current Hits", daTab)
        daGrid = guiCreateGridList(9, 12, 322, 211, false, daTab2)
       	guiGridListSetSortingEnabled(daGrid, false)
		column1 = guiGridListAddColumn(daGrid, "The Hit", 0.5)
        column2 = guiGridListAddColumn(daGrid, "The Bounty 'prize'", 0.4)

        LogoI = guiCreateStaticImage(385, 141, 218, 262, "img.png", false, MainWindow)
		
        closeBtn = guiCreateButton(14, 383, 341, 47, "Close", false, MainWindow)
        guiSetProperty(closeBtn, "NormalTextColour", "FFF10000")
		-- exports.GTIgui:setDefaultFont(closeBtn, 10)
        LabelRights = guiCreateLabel(420, 419, 200, 21, "GTI © 2015", false, MainWindow)
		-- exports.GTIgui:setDefaultFont(LabelRights, 10)
        guiLabelSetColor(LabelRights, 125, 0, 0)
        LogoII = guiCreateStaticImage(107, 31, 418, 85, "logo.png", false, MainWindow)    
		for i,thePla in ipairs (getElementsByType("player")) do
			if (getElementData(thePla, "isOnHit")) then
				setElementData(thePla, "isOnHit", false)
			end
		end
    end
)


addEvent("toggleDaPanel", true)
function togglePanel()
	if (guiGetVisible(MainWindow) == true) then
		guiSetVisible(MainWindow, false)
		showCursor(false, false)
		guiGridListClear(daGrid)
	elseif (guiGetVisible(MainWindow) == false) then
		guiSetVisible(MainWindow, true)
		showCursor(true)
		for _,pla in ipairs (getElementsByType("player")) do
			if (getElementData(pla, "isOnHit")) then
				daRow = guiGridListAddRow(daGrid)
				guiGridListSetItemText(daGrid, daRow, column1, getPlayerName(pla), false, false)
				guiGridListSetItemText(daGrid, daRow, column2, "$"..getElementData(pla, "isOnHit"), false, false)
			end
		end
	end
end
addEventHandler("toggleDaPanel", getRootElement(), togglePanel)

addEvent("addLeRow", true)
function addDaRow()
	if (source) and (getElementType(source) == "player") then
		daRow = guiGridListAddRow(daGrid)
		guiGridListSetItemText(daGrid, daRow, column1, getPlayerName(source), false, false)
		guiGridListSetItemText(daGrid, daRow, column2, "$"..getElementData(source, "isOnHit"), false, false)
	end
end
addEventHandler("addLeRow", root, addDaRow)

function onGuiClick(button)
	if (button == "left") then
		if (source == closeBtn) then
			togglePanel()
		elseif (source == hitBtn) then
			for k, v in ipairs({Opt1,Opt2,Opt3,Opt4,Opt5,Opt6,Opt7,Opt8}) do
				if (guiRadioButtonGetSelected(v) == true) then
					triggerServerEvent("createMaHit", getLocalPlayer(), guiGetText(v))
				end
			end
		end
	end
end		
addEventHandler("onClientGUIClick", guiRoot, onGuiClick)