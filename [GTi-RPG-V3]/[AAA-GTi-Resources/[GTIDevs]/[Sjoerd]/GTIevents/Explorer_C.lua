------------------------------------------->>
-- GTI-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: GTIevents
-- Type: Client Side
-- Author: ChicoGTI & RedBand
----------------------------------------->>

tempElementsTable = nil

function createExplorerGUI()
	resX, resY = guiGetScreenSize()
	expWindow = guiCreateWindow((resX/2) - 300, (resY/2) - 182, 601, 384, "Element Explorer", false)
	guiWindowSetSizable(expWindow, false)
	guiSetAlpha(expWindow, 1.00)

	tabPanel = guiCreateTabPanel(10, 49, 582, 325, false, expWindow)

	tab1 = guiCreateTab("Vehicles", tabPanel)

	gridList1 = guiCreateGridList(2, 1, 578, 296, false, tab1)
	guiGridListSetSortingEnabled(gridList1, false)
	guiGridListAddColumn(gridList1, "Name", 0.2)
	guiGridListAddColumn(gridList1, "Creator", 0.2)
	guiGridListAddColumn(gridList1, "Pos X", 0.1)
	guiGridListAddColumn(gridList1, "Pos Y", 0.1)
	guiGridListAddColumn(gridList1, "Pos Z", 0.1)
	guiGridListAddColumn(gridList1, "Dim", 0.1)
	guiGridListAddColumn(gridList1, "Int", 0.1)

	tab2 = guiCreateTab("Objects", tabPanel)

	gridList2 = guiCreateGridList(2, 1, 578, 296, false, tab2)
	guiGridListSetSortingEnabled(gridList2, false)
	guiGridListAddColumn(gridList2, "ID", 0.2)
	guiGridListAddColumn(gridList2, "Creator", 0.2)
	guiGridListAddColumn(gridList2, "Pos X", 0.1)
	guiGridListAddColumn(gridList2, "Pos Y", 0.1)
	guiGridListAddColumn(gridList2, "Pos Z", 0.1)
	guiGridListAddColumn(gridList2, "Dim", 0.1)
	guiGridListAddColumn(gridList2, "Int", 0.1)

	tab3 = guiCreateTab("Pickups", tabPanel)

	gridList3 = guiCreateGridList(2, 1, 578, 296, false, tab3)
	guiGridListSetSortingEnabled(gridList3, false)
	guiGridListAddColumn(gridList3, "Type", 0.17)
	guiGridListAddColumn(gridList3, "Value", 0.17)
	guiGridListAddColumn(gridList3, "Creator", 0.17)
	guiGridListAddColumn(gridList3, "Pos X", 0.1)
	guiGridListAddColumn(gridList3, "Pos Y", 0.1)
	guiGridListAddColumn(gridList3, "Pos Z", 0.1)
	guiGridListAddColumn(gridList3, "Dim", 0.1)
	guiGridListAddColumn(gridList3, "Int", 0.1)


	descLabelElements = guiCreateLabel(12, 23, 281, 22, "There are 0 vehicles, 0 objects, 0 pickups", false, expWindow)
	guiLabelSetHorizontalAlign(descLabelElements, "center")
	guiLabelSetVerticalAlign(descLabelElements, "center")
	closeExplorerWindow = guiCreateButton(450, 22, 139, 24, "Close Window", false, expWindow)
	deleteElement = guiCreateButton(302, 22, 139, 24, "Delete Selected", false, expWindow)
	
	addEventHandler("onClientGUIClick", closeExplorerWindow, hideExplorerWindow, false)
	addEventHandler("onClientGUIClick", deleteElement, deleteElementFunc, false)
	-- addEventHandler("onClientGUIClick", searchEditExplorer, onSearchElementClick, false)
	-- addEventHandler("onClientGUIChanged", searchEditExplorer, searchElements, false)
end

function showExplorerWindow()
	if (not expWindow) then createExplorerGUI() end
	guiSetVisible(expWindow, true)
	showCursor(true)
	guiBringToFront(expWindow)
end

function hideExplorerWindow()
	guiSetVisible(expWindow, false)
	handleCursorVisibility()
end

function loadElements()
	guiGridListClear(gridList1)
	guiGridListClear(gridList2)
	guiGridListClear(gridList3)
	for k, v in ipairs(tempElementsTable["Vehicles"]) do
		if (isElement(v[1])) then
			local x, y, z = getElementPosition(v[1])
			local dim = getElementDimension(v[1])
			local int = getElementInterior(v[1])
			local row = guiGridListAddRow(gridList1)
			guiGridListSetItemText(gridList1, row, 1, getVehicleName(v[1]), false, false)
			guiGridListSetItemText(gridList1, row, 2, v[2], false, false)
			guiGridListSetItemText(gridList1, row, 3, math.floor(x), false, false)
			guiGridListSetItemText(gridList1, row, 4, math.floor(y), false, false)
			guiGridListSetItemText(gridList1, row, 5, math.floor(z), false, false)
			guiGridListSetItemText(gridList1, row, 6, dim, false, false)
			guiGridListSetItemText(gridList1, row, 7, int, false, false)
			guiGridListSetItemData(gridList1, row, 1, v[1])
		end
	end
	for k, v in ipairs(tempElementsTable["Objects"]) do
		if (isElement(v[1])) then
			local x, y, z = getElementPosition(v[1])
			local dim = getElementDimension(v[1])
			local int = getElementInterior(v[1])
			local row = guiGridListAddRow(gridList2)
			guiGridListSetItemText(gridList2, row, 1, getElementModel(v[1]), false, false)
			guiGridListSetItemText(gridList2, row, 2, v[2], false, false)
			guiGridListSetItemText(gridList2, row, 3, math.floor(x), false, false)
			guiGridListSetItemText(gridList2, row, 4, math.floor(y), false, false)
			guiGridListSetItemText(gridList2, row, 5, math.floor(z), false, false)
			guiGridListSetItemText(gridList2, row, 6, dim, false, false)
			guiGridListSetItemText(gridList2, row, 7, int, false, false)
			guiGridListSetItemData(gridList2, row, 1, v[1])
		end
	end
	for k, v in ipairs(tempElementsTable["Pickups"]) do
		if (isElement(v[1])) then
			local x, y, z = getElementPosition(v[1])
			local dim = getElementDimension(v[1])
			local int = getElementInterior(v[1])
			if (v[4]) then
				if (tonumber(v[4]) and getVehicleNameFromModel(tonumber(v[4]))) then
					v[4] = getVehicleNameFromModel(tonumber(v[4]))
				end
			end
			local row = guiGridListAddRow(gridList3)
			guiGridListSetItemText(gridList3, row, 1, v[2], false, false)
			guiGridListSetItemText(gridList3, row, 2, v[4] or "", false, false)
			guiGridListSetItemText(gridList3, row, 3, v[3], false, false)
			guiGridListSetItemText(gridList3, row, 4, math.floor(x), false, false)
			guiGridListSetItemText(gridList3, row, 5, math.floor(y), false, false)
			guiGridListSetItemText(gridList3, row, 6, math.floor(z), false, false)
			guiGridListSetItemText(gridList3, row, 7, dim, false, false)
			guiGridListSetItemText(gridList3, row, 8, int, false, false)
			guiGridListSetItemData(gridList3, row, 1, v[1])
		end
	end
	guiSetText(descLabelElements, "There are "..#tempElementsTable["Vehicles"].." vehicles, "..#tempElementsTable["Objects"].." objects and "..#tempElementsTable["Pickups"].." pickups")
end

function onReceiveElements(elements)
	showExplorerWindow()
	if (elements) then
		tempElementsTable = elements
		loadElements()
	else
		outputChatBox("table is nil")
	end
end
addEvent("GTIevents.SendElements", true)
addEventHandler("GTIevents.SendElements", root, onReceiveElements)

function deleteElementFunc()
	local tab = guiGetSelectedTab(tabPanel)
	local gridList
	if (tab == tab1) then
		gridList = gridList1
	elseif (tab == tab2) then
		gridList = gridList2
	elseif (tab == tab3) then
		gridList = gridList3
	end
	local element = guiGridListGetItemData(gridList, guiGridListGetSelectedItem(gridList), 1)
	if (element) then
		triggerServerEvent("GTIevents.DeleteElement", root, element)
	end
end

function searchElements()

end

function onSearchElementClick()
	if (guiGetText(source) == "Search") then
		guiSetText(source, "")
	end
end
