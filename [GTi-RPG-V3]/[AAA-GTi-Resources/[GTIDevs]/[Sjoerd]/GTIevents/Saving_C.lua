------------------------------------------->>
-- GTI-RPG: Grand Theft International RPG
-- Date: 420/69
-- Resource: GTIevents
-- Type: Client Side
-- Author: ChicoGTI & RedBand
----------------------------------------->>

saveStuf = {}
cCount = 4
tempETable = nil

function makeSaveGUI()
	saveStuf[1] = guiCreateWindow((resX/2) - 255, (resY/2) - 155, 509, 313, "Load/Save an event", false)
	guiWindowSetSizable(saveStuf[1], false)
	guiSetAlpha(saveStuf[1], 1.00)

	saveStuf[2] = guiCreateLabel(336, 21, 15, 248, "|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n|\n", false, saveStuf[1])
	saveStuf[3] = guiCreateLabel(358, 24, 129, 18, "Save an event", false, saveStuf[1])
	saveStuf[4] = guiCreateLabel(365, 49, 116, 16, "Name", false, saveStuf[1])
	saveStuf[6] = guiCreateLabel(119, 238, 208, 32, "WARNING: Loading an event will destroy all the stuff currently created", false, saveStuf[1])
	saveStuf[7] = guiCreateLabel(357, 209, 135, 37, "Your current position will be used as reference when somebody warps to the location", false, saveStuf[1])
	
	saveStuf[8] = guiCreateEdit(355, 63, 137, 22, "", false, saveStuf[1])
	saveStuf[19] = guiCreateEdit(9, 25, 320, 20, "Search", false, saveStuf[1])
	
	saveStuf[9] = guiCreateCheckBox(362, 104, 134, 16, "Include vehicles", true, false, saveStuf[1])
	saveStuf[10] = guiCreateCheckBox(362, 121, 134, 16, "Include objects", true, false, saveStuf[1])
	saveStuf[11] = guiCreateCheckBox(362, 138, 134, 16, "Include checkpoints", true, false, saveStuf[1])
	saveStuf[12] = guiCreateCheckBox(362, 155, 134, 16, "Include pickups", true, false, saveStuf[1])
	saveStuf[20] = guiCreateCheckBox(355, 190, 140, 16, "Only include my items", false, false, saveStuf[1])
	
	saveStuf[13] = guiCreateButton(350, 255, 146, 39, "Save", false, saveStuf[1])
	saveStuf[14] = guiCreateButton(12, 238, 49, 33, "Load", false, saveStuf[1])
	saveStuf[15] = guiCreateButton(183, 274, 158, 33, "Close Window", false, saveStuf[1])
	saveStuf[16] = guiCreateButton(64, 238, 49, 33, "Warp", false, saveStuf[1])
	saveStuf[17] = guiCreateButton(12, 270, 101, 33, "Delete", false, saveStuf[1])
	
	saveStuf[18] = guiCreateGridList(9, 50, 320, 182, false, saveStuf[1])
	guiGridListSetSelectionMode(saveStuf[18], 0)
	guiGridListSetSortingEnabled(saveStuf[18], false)
	guiGridListAddColumn(saveStuf[18], "Creator", 0.35)
	guiGridListAddColumn(saveStuf[18], "Name", 0.7)
	guiGridListAddColumn(saveStuf[18], "Location", 1)
	
	guiLabelSetHorizontalAlign(saveStuf[3], "center", false)
	guiLabelSetHorizontalAlign(saveStuf[4], "center", false)
	guiLabelSetHorizontalAlign(saveStuf[6], "left", true)
	guiLabelSetHorizontalAlign(saveStuf[7], "left", true)
	guiSetFont(saveStuf[7], "default-small")
	guiLabelSetColor(saveStuf[6], 255, 0, 0)
	
	addEventHandler("onClientGUIClick", saveStuf[9], onCheckBoxClick, false)
	addEventHandler("onClientGUIClick", saveStuf[10], onCheckBoxClick, false)
	addEventHandler("onClientGUIClick", saveStuf[11], onCheckBoxClick, false)
	addEventHandler("onClientGUIClick", saveStuf[12], onCheckBoxClick, false)
	addEventHandler("onClientGUIClick", saveStuf[15], closeSaveWindow, false)
	addEventHandler("onClientGUIClick", saveStuf[13], saveEvent, false)
	addEventHandler("onClientGUIClick", saveStuf[14], loadEvent, false)
	addEventHandler("onClientGUIClick", saveStuf[17], preDelete, false)
	addEventHandler("onClientGUIClick", saveStuf[16], warpTo, false)
	addEventHandler("onClientGUIChanged", saveStuf[19], onSearchEditChanged, false)
	addEventHandler("onClientGUIClick", saveStuf[19], onSearchEditClick, false)
end

function onCheckBoxClick()
	if (cCount == 1 and not guiCheckBoxGetSelected(source)) then
		guiCheckBoxSetSelected(source, true)
	end
	countCheckBox()
end

function countCheckBox()
	local count = 0
	if (guiCheckBoxGetSelected(saveStuf[9])) then
		count = count + 1
	end
	if (guiCheckBoxGetSelected(saveStuf[10])) then
		count = count + 1
	end
	if (guiCheckBoxGetSelected(saveStuf[11])) then
		count = count + 1
	end
	if (guiCheckBoxGetSelected(saveStuf[12])) then
		count = count + 1
	end
	cCount = count
end

function closeSaveWindow()
	guiSetVisible(saveStuf[1], false)
end

function openSaveWindow()
	if (not saveStuf[1]) then
		makeSaveGUI()
	end
	guiSetVisible(saveStuf[1], true)
	guiBringToFront(saveStuf[1])
end

function warpTo()
	local name = guiGridListGetItemText(saveStuf[18], guiGridListGetSelectedItem(saveStuf[18]), 2)
	if (name ~= "") then
		triggerServerEvent("GTIevents.Warp", root, name)
	end
end

function receiveEvents(eTable)
	if (eTable) then
		openSaveWindow()
		guiGridListClear(saveStuf[18])
		tempETable = eTable
		for k,v in ipairs(eTable) do
			if (type(v) == "table") then
				local row = guiGridListAddRow(saveStuf[18])
				guiGridListSetItemText(saveStuf[18], row, 1, v.creator, false, false)
				guiGridListSetItemText(saveStuf[18], row, 2, v.name, false, false)
				guiGridListSetItemText(saveStuf[18], row, 3, v.zone, false, false)
			end
		end
	end
end
addEvent("GTIevents.SendEvents", true)
addEventHandler("GTIevents.SendEvents", root, receiveEvents)

function saveEvent()
	local name = guiGetText(saveStuf[8])
	if (name ~= "") then
		triggerServerEvent("GTIevents.SaveEvent", root, name, {guiCheckBoxGetSelected(saveStuf[9]), guiCheckBoxGetSelected(saveStuf[10]), guiCheckBoxGetSelected(saveStuf[11]), guiCheckBoxGetSelected(saveStuf[12])}, guiCheckBoxGetSelected(saveStuf[20]))
	end
end

function loadEvent()
	local name = guiGridListGetItemText(saveStuf[18], guiGridListGetSelectedItem(saveStuf[18]), 2)
	if (name ~= "") then
		triggerServerEvent("GTIevents.LoadEvent", root, name)
		guiSetVisible(saveStuf[1], false)
		guiSetVisible(EMwindow, false)
		handleCursorVisibility()
	end	
end

function preDelete()
	local name = guiGridListGetItemText(saveStuf[18], guiGridListGetSelectedItem(saveStuf[18]), 2)
	if (name ~= "") then
		exports.GTInvremisc:createYesNoWindow("GTIevents.delevcb", nil, "Delete '"..name.."' Event", "Are you sure you want to delete this event?")
	end
end

function deleteEvent()
	local name = guiGridListGetItemText(saveStuf[18], guiGridListGetSelectedItem(saveStuf[18]), 2)
	if (name ~= "") then
		triggerServerEvent("GTIevents.DeleteEvent", root, name)
	end	
end
addEvent("GTIevents.delevcb")
addEventHandler("GTIevents.delevcb", root, deleteEvent)

function onSearchEditClick()
	if (guiGetText(source) == "Search") then
		guiSetText(source, "")
	end
end

function onSearchEditChanged()
	if (tempETable) then
		guiGridListClear(saveStuf[18])
		local text = guiGetText(saveStuf[19])
		for k,v in ipairs(tempETable) do
			if (text == "") then
				local row = guiGridListAddRow(saveStuf[18])
				guiGridListSetItemText(saveStuf[18], row, 1, v.creator, false, false)
				guiGridListSetItemText(saveStuf[18], row, 2, v.name, false, false)
				guiGridListSetItemText(saveStuf[18], row, 3, v.zone, false, false)
			else
				if (string.find(string.upper(v.creator), string.upper(text))) or (string.find(string.upper(v.name), string.upper(text))) then
					local row = guiGridListAddRow(saveStuf[18])
					guiGridListSetItemText(saveStuf[18], row, 1, v.creator, false, false)
					guiGridListSetItemText(saveStuf[18], row, 2, v.name, false, false)
					guiGridListSetItemText(saveStuf[18], row, 3, v.zone, false, false)
				end
			end
		end
	end
end

