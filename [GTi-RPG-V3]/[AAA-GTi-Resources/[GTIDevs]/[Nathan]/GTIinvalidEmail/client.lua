GUIEditor = {
	button = {},
	window = {},
	edit = {},
	label = {}
}

function initClient()
	initGui()
	showCursor(true)
end
addEvent("initClient", true)
addEventHandler("initClient", localPlayer, initClient)

function initGui()
	local screenW, screenH = guiGetScreenSize()
	GUIEditor.window[1] = guiCreateWindow((screenW - 379) / 2, (screenH - 171) / 2, 379, 171, "Set an email", false)
	guiWindowSetSizable(GUIEditor.window[1], false)

	GUIEditor.label[1] = guiCreateLabel(12, 29, 357, 61, "For some reason we do not have an email stored which is associated with your account.\nPlease input your email address below.", false, GUIEditor.window[1])
	guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", true)
	GUIEditor.edit[1] = guiCreateEdit(52, 94, 276, 33, "myemail@example.com ", false, GUIEditor.window[1])
	GUIEditor.button[1] = guiCreateButton(126, 135, 127, 26, "Set email", false, GUIEditor.window[1])
	guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FFAAAAAA")
	guiSetEnabled(GUIEditor.button[1], false)

	-- events
	addEventHandler("onClientGUIClick", GUIEditor.button[1], btnClick)
	addEventHandler("onClientGUIClick", GUIEditor.edit[1], removeExample)
	addEventHandler("onClientGUIChanged", GUIEditor.edit[1], isValidEmail)
end


function disablebutton()
    if (guiGetEnabled(GUIEditor.button[1]) == true) then
        guiSetEnabled(GUIEditor.button[1], false)
    else
        guiSetEnabled(GUIEditor.button[1], true)
    end
end
addCommandHandler("disb", disablebutton)

function isValidEmail()
	local inputEmail = guiGetText(GUIEditor.edit[1])
	local valid = false

	if (inputEmail ~= nil and inputEmail ~= "" and inputEmail ~= "myemail@example.com ") then
		if (inputEmail:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")) then
			valid = true
		end
	end
	if (inputEmail:find(" ")) then
		guiSetText(GUIEditor.edit[1], inputEmail:gsub(" ", ""))
	end
	if (valid) then
		guiSetEnabled(GUIEditor.button[1], true)
	else
		guiSetEnabled(GUIEditor.button[1], false)
	end
end

function removeExample ()
	if (guiGetText(source) == "myemail@example.com ") then
		guiSetText(source, "")
		removeEventHandler("onClientGUIClick", source, removeExample)
	end
end

function btnClick()
	if (guiGetEnabled(GUIEditor.button[1])) then
		triggerServerEvent("setEmail", resourceRoot, getLocalPlayer(), guiGetText(GUIEditor.edit[1]))
		guiSetVisible(GUIEditor.window[1], false)
		--guiSetInputEnabled(false)
		showCursor(false)
	end
end
