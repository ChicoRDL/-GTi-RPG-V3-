----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 27 Dec 2015
-- Resource: GTIapartments/items/items.lua
-- Type: Client Side
-- Author: Ares
----------------------------------------->>

local Items = {
	[1557] = { "Door 1", 50, {[1] = {'miragedoor1_256', '/shaders/textures/penistexture.png', 'Penis test'}} },
}

function fillInGridListWithItems (grid)
	guiGridListClear(grid)
	for model, data in pairs (Items) do
		local name, price, shader = unpack(data)
		local row = guiGridListAddRow(grid)
		guiGridListSetItemText(grid, row, 1, name, false, false)
		guiGridListSetItemData(grid, row, 1, {model, unpack(data)})
		guiSetVisible(ApartmentsUI.combobox[1], false)
	end
end

addEventHandler("onClientGUIClick", resourceRoot,
	function ()
		if ( source == ApartmentsUI.gridlist[1] ) then
			local row, col = guiGridListGetSelectedItem(source)
			if ( row == -1 or col == -1 ) then return end
			local data = guiGridListGetItemData(source, row, col)
			local model, _, price, textures = unpack(data)
			guiSetText(ApartmentsUI.label[2], "$"..exports.GTIutil:tocomma(price))
			guiSetText(ApartmentsUI.label[6], model)
				if ( #textures ) == 0 then
					guiSetText(ApartmentsUI.label[4], 0)
				else
					guiSetVisible(ApartmentsUI.label[4], false)
					guiSetVisible(ApartmentsUI.combobox[1], true)
					guiComboBoxClear(ApartmentsUI.combobox[1])
					guiComboBoxAddItem(ApartmentsUI.combobox[1], "Original")
					for _, data in ipairs(textures) do
						guiComboBoxAddItem(ApartmentsUI.combobox[1], data[3])
					end
				end
			createPreview(model)
		elseif ( source == ApartmentsUI.button[2] ) then -- Close
			guiSetVisible(ApartmentsUI.window[1], false)
			showCursor(false)
			setCameraTarget(localPlayer)
			setCameraInterior(0)
			setElementFrozen(localPlayer, false)
		elseif ( source == ApartmentsUI.button[1] ) then -- Buy
			guiSetVisible(ApartmentsUI.window[1], false)
			showCursor(false)
			setCameraTarget(localPlayer)
			setCameraInterior(0)
			setElementFrozen(localPlayer, false)

			
			local previewObject = getPreviewObject()
			updateDragElement(previewObject)
			
			startEditionMode(true)
			processCursorClick(nil, nil, nil, nil, nil, nil, nil, previewObject, true)
			updatePreviewObject(nil)
		end
	end
)

addEventHandler("onClientGUIComboBoxAccepted", resourceRoot,
	function (combo)
		if ( combo == ApartmentsUI.combobox[1] ) then
			local ID = guiComboBoxGetSelected(ApartmentsUI.combobox[1])
			if ( ID == -1 ) then return end
			local commercial_name = guiComboBoxGetItemText(ApartmentsUI.combobox[1], ID)
			if ( ID == 0 ) then return set_preview_shader({}, getPreviewObject()) end
			for model, data in pairs(Items) do
				if ( data[3][ID] ) then
					shader_data = data[3][ID]
				end
			end
				return set_preview_shader(shader_data, getPreviewObject()) or exports.GTIhud:dm("Apartments: An error has occurred", 255, 0, 0)
		end
	end
)