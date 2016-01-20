GTIbreporter = {
	checkbox = {},
	label = {},
	edit = {},
	button = {},
	window = {},
	gridlist = {},
	memo = {}
}
 
pties = {
	{"Low"},
	{"Medium"},
	{"High"}
}
screenW, screenH = guiGetScreenSize()
GTIbreporter.window[1] = guiCreateWindow((screenW - 306) / 2, (screenH - 605) / 2, 306, 605, "GTI - Bug Report System", false)
guiWindowSetSizable(GTIbreporter.window[1], false)
guiSetVisible(GTIbreporter.window[1], false)
 
GTIbreporter.label[1] = guiCreateLabel(10, 35, 132, 15, "Bug Name: ", false, GTIbreporter.window[1])
GTIbreporter.label[2] = guiCreateLabel(10, 200, 132, 15, "Steps to Reproduce: ", false, GTIbreporter.window[1])
GTIbreporter.label[3] = guiCreateLabel(10, 387, 132, 15, "Priority: ", false, GTIbreporter.window[1])
GTIbreporter.edit[1] = guiCreateEdit(71, 31, 142, 24, "", false, GTIbreporter.window[1])
GTIbreporter.gridlist[1] = guiCreateGridList(58, 387, 174, 95, false, GTIbreporter.window[1])
guiGridListAddColumn(GTIbreporter.gridlist[1], "", 0.9)
guiGridListSetSortingEnabled(GTIbreporter.gridlist[1], false)

GTIbreporter.checkbox[1] = guiCreateCheckBox(10, 492, 174, 15, "Location [if (Applicable]", false, false, GTIbreporter.window[1])
GTIbreporter.checkbox[2] = guiCreateCheckBox(10, 510, 174, 15, "Exploitable", false, false, GTIbreporter.window[1])
GTIbreporter.button[1] = guiCreateButton(187, 557, 109, 38, "Submit Bug", false, GTIbreporter.window[1])
guiSetProperty(GTIbreporter.button[1], "NormalTextColour", "FFAAAAAA")
GTIbreporter.button[2] = guiCreateButton(68, 562, 109, 28, "Cancel", false, GTIbreporter.window[1])
guiSetProperty(GTIbreporter.button[2], "NormalTextColour", "FFAAAAAA")
GTIbreporter.label[4] = guiCreateLabel(10, 60, 132, 15, "Short Description: ", false, GTIbreporter.window[1])
GTIbreporter.memo[2] = guiCreateMemo(10, 75, 286, 56, "", false, GTIbreporter.window[1])
GTIbreporter.label[5] = guiCreateLabel(10, 131, 132, 15, "Description: ", false, GTIbreporter.window[1])
GTIbreporter.memo[3] = guiCreateMemo(10, 146, 286, 56, "", false, GTIbreporter.window[1])
GTIbreporter.label[6] = guiCreateLabel(13, 297, 132, 15, "Additional Information: ", false, GTIbreporter.window[1])
GTIbreporter.checkbox[3] = guiCreateCheckBox(10, 528, 174, 16, "Take screenshot", false, false, GTIbreporter.window[1])
 
-- setting stuff

GTIbreporter.memo[1] = guiCreateMemo(10, 215, 286, 82, "", false, GTIbreporter.window[1])
GTIbreporter.memo[4] = guiCreateMemo(10, 314, 286, 58, "", false, GTIbreporter.window[1])
-- Functions
 
addEventHandler("onClientResourceStart", resourceRoot,
	function()
		-- Add Priorities To Gridlist
		for i, priority in ipairs (pties) do
			local row = guiGridListAddRow(GTIbreporter.gridlist[1])
			guiGridListSetItemText(GTIbreporter.gridlist[1], row, 1, priority[1], false, false)
		end
	end
)
 
addEventHandler("onClientGUIClick", root,
	function()
		if (source == GTIbreporter.button[1]) then
			--bug name
			local bug_name = trim(guiGetText(GTIbreporter.edit[1]))
			if (bug_name == "") then
				exports.GTIhud:dm("You must add a name of the bug discovered.", 255, 0, 0)
				return
			end
			
			if (#bug_name < 5) then
				exports.GTIhud:dm("You must enter more than 5 characters for the bug name.", 255, 0, 0)
				return
			end
			
			--short description
			local short_description = trim(guiGetText(GTIbreporter.memo[2]))
			if (short_description == "") then
				exports.GTIhud:dm("You must add a short description of the bug you discovered.", 255, 0, 0)
				return
			end
			
			if (#short_description < 10) then
				exports.GTIhud:dm("You must enter more than 10 characters for the short description.", 255, 0, 0)
				return
			end
			
			-- description
			local description = trim(guiGetText(GTIbreporter.memo[3]))
			if (description == "") then
				exports.GTIhud:dm("You must enter a description of the bug you discovered.", 255, 0, 0)
				return
			end
			
			if (#description < 10) then
				exports.GTIhud:dm("You must enter more than 10 characters for the bug's description", 255, 0, 0)
				return
			end
			
			
			local reproduce = trim(guiGetText(GTIbreporter.memo[1]))
			if (reproduce == "") then
				exports.GTIhud:dm("You must enter steps to reproduce of the bug you discovered.", 255, 0, 0)
				return
			end
			
			--additional
			local additional = trim(guiGetText(GTIbreporter.memo[4]))
			
			local row, col = guiGridListGetSelectedItem(GTIbreporter.gridlist[1])
			local priority = guiGridListGetItemText(GTIbreporter.gridlist[1], row, col)
	
			if (priority == "") then
				exports.GTIhud:dm("You must set a priority of the bug you discovered.", 255, 0, 0)
				return
			end
 
			local loc = guiCheckBoxGetSelected(GTIbreporter.checkbox[1])
			local ex = guiCheckBoxGetSelected(GTIbreporter.checkbox[2])
			local ss = guiCheckBoxGetSelected(GTIbreporter.checkbox[3])
			dataToServer = {}
			dataToServer["bug_name"] = bug_name
			dataToServer["short_description"] = short_description
			dataToServer["description"] = description
			dataToServer["reproduce"] = reproduce
			dataToServer["additional"] = additional
			dataToServer["priority"] = priority
			dataToServer["loc"] = loc
			dataToServer["exploitable"] = ex
			dataToServer["screenshot"] = ss
			if (ss) then
				dataToServer["screendimentions"] = {}
				dataToServer["screendimentions"]["screenw"] = screenW
				dataToServer["screendimentions"]["screenh"] = screenH
			end
			triggerServerEvent("GTIbreporter.submit", localPlayer, dataToServer)
			guiSetVisible(GTIbreporter.window[1], false)
			showCursor(false)
 
		elseif (source == GTIbreporter.button[2]) then
			if (guiGetVisible(GTIbreporter.window[1])) then
				guiSetVisible(GTIbreporter.window[1], false)
				showCursor(false)
			end
		end
	end
)
 
addCommandHandler("bugreport",
	function()
			if (guiGetVisible(GTIbreporter.window[1])) then
				guiSetVisible(GTIbreporter.window[1], false)
				showCursor(false)
			else
				guiSetVisible(GTIbreporter.window[1], true)
				showCursor(true)
			end
	end
)

function trim(data)
	return (data:gsub("^%s*(.-)%s*$", "%1"))
end