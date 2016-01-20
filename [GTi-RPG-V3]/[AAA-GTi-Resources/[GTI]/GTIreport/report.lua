local rules = {
"Deathmatching",
"Trolling",
"Griefing",
}
local sWidth, sHeight = guiGetScreenSize()
GUIEditor = {
    button = {},
    window = {},
    combobox = {},
    edit = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local Width,Height = 340,350
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
        GUIEditor.window[1] = guiCreateWindow(X,Y,Width,Height,"Report",false)
        guiWindowSetSizable(GUIEditor.window[1], false)
		guiSetInputMode("no_binds_when_editing")

        GUIEditor.edit[1] = guiCreateEdit (0, 103, 323, 80, "", false, GUIEditor.window[1])
		guiEditSetMaxLength ( GUIEditor.edit[1], 50 )
        GUIEditor.combobox[1] = guiCreateComboBox(0, 28, 323, 141, "", false, GUIEditor.window[1])
        closebutton = guiCreateButton(0, 305, 104, 23, "Close", false, GUIEditor.window[1])
		guiSetProperty(closebutton,"NormalTextColour", "FFFC0000")  
        sendbtn = guiCreateButton(230, 305, 104, 23, "Send", false, GUIEditor.window[1])    
		label = guiCreateLabel(135, 77, 179, 14, "Reason:", false, GUIEditor.window[1])
		guiSetFont(label, "default-bold-small")
        guiLabelSetColor(label, 219, 253, 254)
		guiSetProperty(sendbtn,"NormalTextColour", "FF00FD00")
		guiSetVisible( GUIEditor.window[1], false)
		for i,v in ipairs(rules) do
			guiComboBoxAddItem(GUIEditor.combobox[1],v)
		end
    end
)

function gui()
    local window = guiGetVisible( GUIEditor.window[1])
    if not window then
		if antiTick and getTickCount() - antiTick < 20000 then outputChatBox("You can only use /report every 20 seconds",255,0,0) return end
		antiTick = getTickCount()
		guiSetText( GUIEditor.edit[1],"")
		triggerServerEvent("GTIreport.takeInformation",resourceRoot)
		exports.GTIhud:dm("Screenshot taken! Now uploading...",0,255,0)
    end
end
addCommandHandler("report",gui)

addEventHandler( "onClientGUIClick", root,
    function()
		if source == closebutton then
			guiSetVisible(GUIEditor.window[1], false)
			showCursor( false)
			triggerServerEvent("GTIreport.cancel",resourceRoot)
		elseif source == sendbtn then
			local item = guiComboBoxGetSelected(GUIEditor.combobox[1])
			if not item or item == nil then
				outputChatBox("You must select a rule.",255,0,0)
				return
			end
			local rule = guiComboBoxGetItemText(GUIEditor.combobox[1], item)
			if not rule or rule == "" then
				outputChatBox("You must select a rule.",255,0,0)
				return
			end
			local msg = guiGetText(GUIEditor.edit[1])
			triggerServerEvent("GTIreport.sendReport",resourceRoot,msg,rule)
			guiSetVisible( GUIEditor.window[1], false)
			showCursor(false)
			exports.GTIhud:dm("Report successfully sent!",0,255,0)
        end
    end
)

function enablebtn(send,close)
	if send then
        guiSetVisible( GUIEditor.window[1], true)
        showCursor(true)
		exports.GTIhud:dm("Screenshot successfully uploaded!",0,255,0)
	end
end
addEvent( "GTIreport.enablebtn", true)
addEventHandler( "GTIreport.enablebtn", root, enablebtn)
