local sx, sy = guiGetScreenSize()
local GUI_Window_Basemarker = guiCreateWindow((sx/2)-161, (sy/2)-175, 322, 355, "Base Information Marker",false)
guiSetVisible(GUI_Window_Basemarker, false)
guiWindowSetSizable(GUI_Window_Basemarker, false)
local GUI_Textfield_Basemarker = guiCreateMemo(16,31,287,268,"",false,GUI_Window_Basemarker)
local GUI_Button_Save = guiCreateButton(19,310,88,31,"Save",false,GUI_Window_Basemarker)
local GUI_Button_Delete = guiCreateButton(119,310,88,31,"Delete",false,GUI_Window_Basemarker)
local GUI_Button_Close = guiCreateButton(219,310,88,31,"Close",false,GUI_Window_Basemarker)

function closeGUI() 
	guiSetVisible(GUI_Window_Basemarker, false)
	showCursor(false)
	currentBaseMarker = nil
end
addEventHandler("onClientGUIClick", GUI_Button_Close, closeGUI, false)

function showBaseMarkerGUI(text, isFounder, isBaseManager, marker, groupName)
	guiMemoSetReadOnly(GUI_Textfield_Basemarker, not isFounder and not isBaseManager)
	guiSetEnabled(GUI_Button_Save, isFounder or isBaseManager)
	guiSetEnabled(GUI_Button_Delete, isBaseManager)
	guiSetVisible(GUI_Button_Save, isFounder or isBaseManager)
	guiSetVisible(GUI_Button_Delete, isBaseManager)
	
	guiSetVisible(GUI_Window_Basemarker, true)
	showCursor(true)
	guiSetText(GUI_Textfield_Basemarker, text or "")
	guiSetText(GUI_Window_Basemarker, groupName .. " - Base Information Marker")
	currentBaseMarker = marker
end
addEvent("onBaseMarkerHit", true)
addEventHandler("onBaseMarkerHit", getRootElement(), showBaseMarkerGUI)

function deleteBaseMarker()
	if (not isElement(currentBaseMarker)) then return end
	triggerServerEvent("onBaseMarkerDelete", currentBaseMarker)
	guiSetVisible(GUI_Window_Basemarker, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", GUI_Button_Delete, deleteBaseMarker, false)

function saveBaseMarker()
	if (not isElement(currentBaseMarker)) then return end
	triggerServerEvent("onBaseMarkerSave", currentBaseMarker, guiGetText(GUI_Textfield_Basemarker))
	guiSetVisible(GUI_Window_Basemarker, false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", GUI_Button_Save, saveBaseMarker, false)