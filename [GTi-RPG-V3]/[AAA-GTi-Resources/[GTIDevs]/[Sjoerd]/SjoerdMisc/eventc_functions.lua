local sn_a = "" -- Selected Action Name
local s_a = "" -- Selected Action
local cole = true -- Collisions Enabled
local selPart = false

local selEnt = false
sEntBlip = false

function getGridListRowIndexFromText(gridlist, text, column, useData)
	for i=0, guiGridListGetRowCount(gridlist) do
		if (useData) then
			if (string.find(guiGridListGetItemData(gridlist, i, column), text)) then
				return i
			end
		else
			if (guiGridListGetItemText(gridlist, i, column) == text) then
				return i
			end
		end
	end
end

function toggleCollisions( state)
	for i, veh in ipairs(getElementsByType("vehicle")) do
		setElementCollidableWith( veh, eventVeh, state)
	end
	if state then
		outputEM( "Collisions enabled.")
	else
		outputEM( "Collisions disabled.", true)
	end
end

partlist = {}

addEvent( "GTIevents.processEntityFunction", true)
addEventHandler( "GTIevents.processEntityFunction", root,
	function( action, data, player)
		if action == "toggleCollisions" then
			if cole then
				cole = false
				toggleCollisions( false)
			else
				cole = true
				toggleCollisions( true)
			end
		elseif action == "updateParticipantList" then
			if data == "join" then
				if not partlist[player] then
					local row = guiGridListAddRow( GTIevents.gridlist[4])
					guiGridListSetItemText( GTIevents.gridlist[4], row, 1, getPlayerName( player), false, false)
					guiGridListSetItemData( GTIevents.gridlist[4], row, 1, player)
					partlist[player] = row
				end
			elseif data == "leave" then
				if partlist[player] then
					local index = partlist[player]
					guiGridListRemoveRow( GTIevents.gridlist[4], index)
					partlist[player] = nil
					--local index = getGridListRowIndexFromText( GTIevents.gridlist[4], getPlayerName(player), 1, false)
				end
			end
		end
	end
)

-- Misc Functions
function getSelectedParticipant()
	if selPart then
		return selPart
	else
		return false
	end
end

-- GUI Handling

addEventHandler( "onClientGUIClick", root,
	function()
		-- Create Event
		if source == GTIevents.button[2] then
			local title = guiGetText( GTIevents.edit[1])
			local max_slots = guiGetText( GTIevents.edit[2])
			local int = guiGetText( GTIevents.edit[5])
			local dim = guiGetText( GTIevents.edit[6])

			local isFrozenOnWarp = guiCheckBoxGetSelected( GTIevents.checkbox[1])
			local isTeamLocked = guiCheckBoxGetSelected( GTIevents.checkbox[2])
			local isReenterable = guiCheckBoxGetSelected( GTIevents.checkbox[3])
			local lockedTeam = ""
			if isTeamLocked then
				lockedTeam = guiGetText( GTIevents.edit[4])
			else
				lockedTeam = false
			end
			if #title == 0 then
				outputEM( "No title stated.", true)
				return
			end
			if #int == 0 then
				outputEM( "No Interior stated.", true)
				return
			end
			if #dim == 0 then
				outputEM( "No Dimension stated.", true)
				return
			end
			if #max_slots == 0 then
				outputEM( "No Slot Count Stated.", true)
				return
			end
			triggerServerEvent( "GTIevents.createEvent", localPlayer, max_slots, title, int, dim, isFrozenOnWarp, isReenterable, lockedTeam)
		elseif source == GTIevents.button[3] then
			triggerServerEvent( "GTIevents.stopEvent", localPlayer)
		-- Freeze On Warp Toggle
		elseif source == GTIevents.checkbox[1] then
			local isChecked = guiCheckBoxGetSelected( source)
			if isChecked then
				outputEM( "Freeze On Warp enabled.")
			else
				outputEM( "Freeze On Warp disabled.", true)
			end
		-- Team-Lock Toggle
		elseif source == GTIevents.checkbox[2] then
			local isChecked = guiCheckBoxGetSelected( source)
			if isChecked then
				guiEditSetReadOnly(GTIevents.edit[4], false)
				outputEM( "Team-Lock enabled.")
			else
				guiEditSetReadOnly(GTIevents.edit[4], true)
				outputEM( "Team-Lock disabled.", true)
			end
		-- Re-entry Toggle
		elseif source == GTIevents.checkbox[3] then
			local isChecked = guiCheckBoxGetSelected( source)
			if isChecked then
				outputEM( "Re-entry enabled.")
			else
				outputEM( "Re-entry disabled.", true)
			end
		-- Message Sending Toggle
		elseif source == GTIevents.button[1] then
			local text = guiGetText( GTIevents.edit[3])

			local part = guiRadioButtonGetSelected( GTIevents.radiobutton[1])
			local ev = guiRadioButtonGetSelected( GTIevents.radiobutton[2])
			if text and text ~= "" then
				if part then
					triggerServerEvent( "GTIevents.handleClientAction", localPlayer, "announceMessage", "part", text..";false")
					outputEM( "Message sent to all participants.")
				elseif ev then
					triggerServerEvent( "GTIevents.handleClientAction", localPlayer, "announceMessage", "root", text..";false")
					outputEM( "Message sent to server.")
				end
			else
				outputEM( "No message to submit.", true)
			end
		-- Entity Selection
		elseif source == GTIevents.gridlist[1] then
			guiSetEnabled( GTIevents.button[5], true)
			local selectedEntity = guiGridListGetItemText( source, guiGridListGetSelectedItem( source), 1)
			local entity = guiGridListGetItemData( source, guiGridListGetSelectedItem( source), 1)
			local gui_text = ""
			if selectedEntity ~= "" and isElement( entity) then
				if getElementType( entity) == "v_spawner" then
					gui_text = "Destroy Selected Spawner"
				elseif getElementType( entity) == "e_blip" then
					gui_text = "Destroy Selected Blip"
				elseif getElementType( entity) == "object" then
					gui_text = "Destroy Selected Object"
				elseif getElementType( entity) == "pickup" then
					gui_text = "Destroy Selected Pickup"
				end
				guiSetText( GTIevents.button[5], gui_text)

				local x, y, z = getElementPosition( entity)

				selEnt = entity
				if getElementType( entity) ~= "e_blip" then
					if not isElement( sEntBlip) then
						if getElementData( entity, "posX") then
							sEntBlip = createBlip( getElementData( entity, "posX"), getElementData( entity, "posY"), getElementData( entity, "posZ"), 0, 2, 25, 255, 25, 255, 0)
						else
							sEntBlip = createBlip( x, y, z, 0, 2, 25, 255, 25, 255, 0)
						end
					else
						destroyElement( sEntBlip)
						sEntBlip = false
						if getElementData( entity, "posX") then
							sEntBlip = createBlip( getElementData( entity, "posX"), getElementData( entity, "posY"), getElementData( entity, "posZ"), 0, 2, 25, 255, 25, 255, 0)
						else
							sEntBlip = createBlip( x, y, z, 0, 2, 25, 255, 25, 255, 0)
						end
					end
				end
			else
				if isElement( sEntBlip) then
					destroyElement( sEntBlip)
					sEntBlip = false
					selEnt = false
				end
				guiSetText( GTIevents.button[5], "No Entity Selected")
			end
		-- Global Participant Actions
		elseif source == GTIevents.gridlist[2] then
			local selectedEntity = guiGridListGetItemText( source, guiGridListGetSelectedItem( source), 1)
			local entityData = guiGridListGetItemData( source, guiGridListGetSelectedItem( source), 1)
			if selectedEntity ~= "" and entityData ~= "" then
				--outputEM( "Function: "..selectedEntity.." | MiniFunction: "..entityData)
				guiSetText( GTIevents.button[8], selectedEntity)
				sn_a = selectedEntity
				s_a = entityData
			else
				guiSetText( GTIevents.button[8], "No Action Selected")
			end
		-- Blip Selection
		elseif source == GTIevents.gridlist[3] then
			local selectedBlip = guiGridListGetItemData( source, guiGridListGetSelectedItem(source), 1)
			if selectedBlip then
				guiStaticImageLoadImage ( GTIevents.image[1], selectedBlip)
			end
		-- Participant Selection
		elseif source == GTIevents.gridlist[4] then
			local selectedParticipant = guiGridListGetItemText( source, guiGridListGetSelectedItem( source), 1)
			if selectedParticipant ~= "" then
				local selectedParticipant = guiGridListGetItemData( source, guiGridListGetSelectedItem( source), 1)
				if getElementType( selectedParticipant) == "player" then
					selPart = selectedParticipant
				else
					--outputEM( "No participant selected", true)
					selPart = false
				end
			else
				--outputEM( "No participant selected", true)
				selPart = false
			end
		-- Event Action Selection
		elseif source == GTIevents.gridlist[5] then
			local selectedAction = guiGridListGetItemText( source, guiGridListGetSelectedItem(source), 1)
			if selectedAction ~= "" then
				local sActionData = guiGridListGetItemData( source, guiGridListGetSelectedItem(source), 1)
				guiSetText( GTIevents.button[9], selectedAction)
				s_a = sActionData
				sn_a = selectedAction
			else
				guiSetText( GTIevents.button[9], "No Action Selected")
				s_a = ""
				sn_a = ""
			end
		elseif source == GTIevents.gridlist[6] then
			local selectedObject = guiGridListGetItemText( source, guiGridListGetSelectedItem(source), 1)
			if selectedObject ~= "" then
				if selectedObject ~= "..." then
					local objectID = guiGridListGetItemData( source, guiGridListGetSelectedItem(source), 1)
					if objectID and type( objectID) == "number" then
						selEnt = objectID..":o"
						guiSetText( GTIevents.button[10], "Place Object")
					else
						guiSetText( GTIevents.button[10], "[Viewing Hierarchy]")
						load_oh( objectID)
					end
				else
					main_gmenu()
				end
			else
				guiSetText( GTIevents.button[10], "No Object Selected")
			end
		-- Event Wide Action
		elseif source == GTIevents.button[8] then
			if s_a and s_a ~= "" then
				triggerServerEvent( "GTIevents.handleEventAction", localPlayer, s_a)
			end
		-- Blip Creation
		elseif source == GTIevents.button[7] then
			local selectedBlip = guiGridListGetItemText( GTIevents.gridlist[3], guiGridListGetSelectedItem(GTIevents.gridlist[3]), 1)
			if selectedBlip then
				--local selectedBlip = string.gsub( selectedBlip, "images/blips/", "")
				--local selectedBlip = tonumber( selectedBlip)
				triggerServerEvent( "GTIevents.handleEventAction", localPlayer, "create_blip", selectedBlip)
			end
		-- Vehicle Spawner Creation
		elseif source == GTIevents.button[4] then
			local index = guiComboBoxGetSelected( GTIevents.combobox[1])
			local selectedVehicle = guiComboBoxGetItemText( GTIevents.combobox[1], index)
			if selectedVehicle and getVehicleModelFromName( selectedVehicle) then
				triggerServerEvent("GTIevents.handleEventAction", localPlayer, "create_veh_spawner", selectedVehicle)
			end
		-- Object Deletion
		elseif source == GTIevents.button[5] then
			if isElement( selEnt) then
				if isElement( sEntBlip) then
					destroyElement( sEntBlip)
					sEntBlip = false
				end
				triggerServerEvent( "GTIevents.deleteObject", localPlayer, selEnt)
				updateElementList()
			end
		-- Object Placement
		elseif source == GTIevents.button[10] then
			--local selectedObject = guiGridListGetItemText( GTIevents.gridlist[6], guiGridListGetSelectedItem(GTIevents.gridlist[6]), 1)
			if not selEnt then
				return
			end
			if string.find( selEnt, ":") then
				local selEnt = split( selEnt, ":")
				local id = selEnt[1]

				startMovement( id)
			end
		-- Participant Action
		elseif source == GTIevents.button[9] then
			if s_a ~= "" then
				local player = getSelectedParticipant()
				if player then
					if string.find( s_a, ";") then
						local data = split( s_a, ";")
						local fct = data[1]
						local fpae = data[2]
						--s_a = data[2]
						if fct == "exec" then
							executeFunction( sn_a, fpae, true)
						end
						--outputEM( s_a)
						--selPart = false
					else
						triggerServerEvent( "GTIevents.handleClientAction", localPlayer, s_a, player)
						--selPart = false
					end
				else
					outputEM( "No participant selected.", true)
				end
			else
				outputEM( "No action selected.", true)
			end
		end
	end
)

-- Object Gridlist Functions

function load_oh( name)
	guiGridListClear( GTIevents.gridlist[6])
	local row = guiGridListAddRow( GTIevents.gridlist[6])
	guiGridListSetItemText( GTIevents.gridlist[6], row, 1, "...", false, false)
	for i, object in ipairs ( objects[name]) do
		local row = guiGridListAddRow( GTIevents.gridlist[6])
		local oid = object[1]
		local oname = object[2]
		guiGridListSetItemText( GTIevents.gridlist[6], row, 1, "["..oid.."] "..oname, false, false)
		guiGridListSetItemData( GTIevents.gridlist[6], row, 1, oid)
	end
end

function main_gmenu()
	guiGridListClear( GTIevents.gridlist[6])
	for name, category in pairs ( objects) do
		local row = guiGridListAddRow( GTIevents.gridlist[6])
		if #objects[name] > 1 then
			guiGridListSetItemText( GTIevents.gridlist[6], row, 1, name.."["..(#objects[name]).." Objects]", false, false)
			guiGridListSetItemData( GTIevents.gridlist[6], row, 1, name)
		else
			guiGridListSetItemText( GTIevents.gridlist[6], row, 1, name.."["..(#objects[name]).." Object]", false, false)
			guiGridListSetItemData( GTIevents.gridlist[6], row, 1, name)
		end
	end
end
