----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

local sX, sY = guiGetScreenSize()
local wX, wY = 580, 300
local sX, sY, wX, wY = ( sX / 2 ) - ( wX / 2 ),( sY / 2 ) - ( wY / 2 ), wX, wY
-- Window
GUI_Window_Crafting = guiCreateWindow ( sX, sY, wX, wY, "GTI Crafting System", false )
guiSetVisible ( GUI_Window_Crafting, false )
-- Gridlist
GUI_Gridlist_Inventory = guiCreateGridList ( 10, 45, 160, 240, false, GUI_Window_Crafting )
GUI_Gridlist_Craftrecipes = guiCreateGridList ( 410, 45, 160, 240, false, GUI_Window_Crafting )
guiGridListAddColumn ( GUI_Gridlist_Inventory, "Item", 0.5 )
guiGridListAddColumn ( GUI_Gridlist_Inventory, "Amount", 0.3 )
guiGridListAddColumn ( GUI_Gridlist_Craftrecipes, "Item", 0.8 )
guiGridListSetSortingEnabled ( GUI_Gridlist_Inventory, false )
guiGridListSetSortingEnabled ( GUI_Gridlist_Craftrecipes, false )
-- Buttons
GUI_Button_Craft = guiCreateButton ( 180, 175, 220, 20, "Craft", false, GUI_Window_Crafting )
GUI_Button_Close = guiCreateButton ( 180, 200, 220, 20, "Close", false, GUI_Window_Crafting )
-- Labels
GUI_Label1 = guiCreateLabel ( -10, 25, 200, 20, "Inventory", false, GUI_Window_Crafting )
guiSetFont ( GUI_Label1, "default-bold-small" )
guiLabelSetColor ( GUI_Label1, 0, 178, 240 )
guiLabelSetHorizontalAlign ( GUI_Label1, "center", false )
GUI_Label2 = guiCreateLabel ( 390, 25, 200, 20, "Crafting Recipes", false, GUI_Window_Crafting )
guiSetFont ( GUI_Label2, "default-bold-small" )
guiLabelSetColor ( GUI_Label2, 0, 178, 240 )
guiLabelSetHorizontalAlign ( GUI_Label2, "center", false )
GUI_Label3 = guiCreateLabel ( 90, 25, 400, 20, "Click one of the crafting recipes for their info", false, GUI_Window_Crafting )
guiSetFont ( GUI_Label3, "default-bold-small" )
guiLabelSetColor ( GUI_Label3, 0, 178, 240 )
guiLabelSetHorizontalAlign ( GUI_Label3, "center", false )
GUI_Label4 = guiCreateLabel ( 260, 510, 300, 20, "Enter amount of units you want to make", false, GUI_Window_Crafting )
guiSetFont ( GUI_Label4, "default-bold-small" )
guiLabelSetColor ( GUI_Label4, 0, 178, 240 )
guiLabelSetHorizontalAlign ( GUI_Label4, "center", false )
-- Edit box
GUI_Edit_Box = guiCreateEdit ( 180, 150, 220, 21, "", false, GUI_Window_Crafting )
guiEditSetMaxLength ( GUI_Edit_Box, 3 )

function removeLetters ( element )
    local txt = guiGetText ( element )
    local removed = string.gsub ( txt, "[^0-9]", "" )
    if ( removed ~= txt ) then
        guiSetText ( element, removed )
    end
end
addEventHandler ( "onClientGUIChanged", GUI_Edit_Box, removeLetters, false )

function getPlayerItems ( medkits, coke, iron, hemp )
	-- Player Inventory
    local row = guiGridListAddRow ( GUI_Gridlist_Inventory )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 1, "Drugs", true, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Inventory )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 1, "Medic Kits", false, false )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 2, medkits, false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Inventory )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 1, "Cocaine", false, false )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 2, coke, false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Inventory )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 1, "Material", true, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Inventory )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 1, "Iron", false, false )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 2, iron, false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Inventory )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 1, "Hemp", false, false )
	guiGridListSetItemText ( GUI_Gridlist_Inventory, row, 2, hemp, false, false )
	-- Craft Recipes
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Drugs", true, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Medic Kits", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Cocaine", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Misc", true, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Parachute", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Melee", true, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Shovel", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Golf Club", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Knife", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Katana", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Ammo", true, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Pistol", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Silenced 9MM", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Desert Eagle", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Shotgun", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Sawn Off", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Spaz 12", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Uzi", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "MP5", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "TEC 9", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "AK-47", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "M4", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Rifle", false, false )
	local row = guiGridListAddRow ( GUI_Gridlist_Craftrecipes )
	guiGridListSetItemText ( GUI_Gridlist_Craftrecipes, row, 1, "Sniper", false, false )
end
addEvent ("GTIcraftingSystem.getPlayerItems", true )
addEventHandler ("GTIcraftingSystem.getPlayerItems", root, getPlayerItems )

function setItemText ( )
    CraftRecipe = guiGridListGetItemText ( GUI_Gridlist_Craftrecipes, guiGridListGetSelectedItem ( GUI_Gridlist_Craftrecipes ) )
	local amount = guiGetText ( GUI_Edit_Box )
	if ( tonumber ( amount ) and amount ~= "" and amount ~= "0" ) then
		local hempAmount = tostring ( amount * 45 )
		local ironAmount = tostring ( amount * 30 )
		if CraftRecipe == "Medic Kits" then
			guiSetText ( GUI_Label3, ""..amount.. " Medic kit(s) needs "..hempAmount.." Hemp and "..ironAmount.." Iron" )
		elseif CraftRecipe == "Cocaine" then
			guiSetText ( GUI_Label3, "Cocaine can not be crafted yet!" )
		elseif CraftRecipe == "Parachute" then
			local hempAmount = tostring ( amount * 25 )
			guiSetText ( GUI_Label3, ""..amount.. " Parachute(s) needs "..hempAmount.." Hemp"  )
		elseif CraftRecipe == "Golf Club" then
			local ironAmount = tostring ( amount * 100 )
			guiSetText ( GUI_Label3, ""..amount.. " Golf Club(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Shovel" then
			local ironAmount = tostring ( amount * 150 )
			guiSetText ( GUI_Label3, ""..amount.. " Shovel(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Knife" then
			local ironAmount = tostring ( amount * 300 )
			guiSetText ( GUI_Label3, ""..amount.. " Knife(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Katana" then
			local ironAmount = tostring ( amount * 500 )
			guiSetText ( GUI_Label3, ""..amount.. " Katana(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Pistol" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " Pistol bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Silenced 9MM" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " Silenced 9MM bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Desert Eagle" then
			local ironAmount = tostring ( amount * 10 )
			guiSetText ( GUI_Label3, ""..amount.. " Desert Eagle bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Shotgun" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " Shotgun bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Sawn Off" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " Sawn Off bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Spaz 12" then
			local ironAmount = tostring ( amount * 10 )
			guiSetText ( GUI_Label3, ""..amount.. " Spaz 12 bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Uzi" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " Uzi bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "MP5" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " MP5 bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "TEC 9" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " TEC 9 bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "AK-47" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " AK-47 bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "M4" then
			local ironAmount = tostring ( amount * 5 )
			guiSetText ( GUI_Label3, ""..amount.. " M4 bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Rifle" then
			local ironAmount = tostring ( amount * 20 )
			guiSetText ( GUI_Label3, ""..amount.. " Rifle bullet(s) needs "..ironAmount.." Iron"  )
		elseif CraftRecipe == "Sniper" then
			local ironAmount = tostring ( amount * 25 )
			guiSetText ( GUI_Label3, ""..amount.. " Sniper bullet(s) needs "..ironAmount.." Iron"  )
		end
	end
end
addEventHandler ("onClientGUIChanged", root, setItemText )

function craftItems ( )
    if source == GUI_Button_Craft then
		amount = guiGetText ( GUI_Edit_Box )
		if ( tonumber ( amount ) and amount ~= "" and amount ~= "0" ) then
			if CraftRecipe == "Medic Kits" then
				local hempAmount = amount * 45
				local ironAmount = amount * 30
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "medickit", amount, hempAmount, ironAmount )
			elseif CraftRecipe == "Parachute" then
				if ( tonumber ( amount ) and amount ~= "" and amount >= "2" ) then exports.GTIhud:dm("Craft System: You cannot craft more then 1 Parachute!", 0, 255, 255 ) return end
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "parachute" )
			elseif CraftRecipe == "Knife" then
				if ( tonumber ( amount ) and amount ~= "" and amount >= "2" ) then exports.GTIhud:dm("Craft System: You cannot craft more then 1 Knife!", 0, 255, 255 ) return end
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "knife" )
			elseif CraftRecipe == "Golf Club" then
				if ( tonumber ( amount ) and amount ~= "" and amount >= "2" ) then exports.GTIhud:dm("Craft System: You cannot craft more then 1 Golf Club!", 0, 255, 255 ) return end
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "golf" )
			elseif CraftRecipe == "Shovel" then
				if ( tonumber ( amount ) and amount ~= "" and amount >= "2" ) then exports.GTIhud:dm("Craft System: You cannot craft more then 1 Shovel!", 0, 255, 255 ) return end
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "shovel" )
			elseif CraftRecipe == "Katana" then
				if ( tonumber ( amount ) and amount ~= "" and amount >= "2" ) then exports.GTIhud:dm("Craft System: You cannot craft more then 1 Katana!", 0, 255, 255 ) return end
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "katana" )
			elseif CraftRecipe == "Pistol" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "pistol", amount, 0, ironAmount )
			elseif CraftRecipe == "Silenced 9MM" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "silenced", amount, 0, ironAmount )
			elseif CraftRecipe == "Desert Eagle" then
				local ironAmount = amount * 10
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "eagle", amount, 0, ironAmount )
			elseif CraftRecipe == "Shotgun" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "shotgun", amount, 0, ironAmount )
			elseif CraftRecipe == "Sawn Off" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "sawnoff", amount, 0, ironAmount )
			elseif CraftRecipe == "Spaz 12" then
				local ironAmount = amount * 10
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "spaz", amount, 0, ironAmount )
			elseif CraftRecipe == "Uzi" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "uzi", amount, 0, ironAmount )
			elseif CraftRecipe == "MP5" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "mp", amount, 0, ironAmount )
			elseif CraftRecipe == "TEC 9" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "tec", amount, 0, ironAmount )
			elseif CraftRecipe == "AK-47" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "ak", amount, 0, ironAmount )
			elseif CraftRecipe == "M4" then
				local ironAmount = amount * 5
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "m", amount, 0, ironAmount )
			elseif CraftRecipe == "Rifle" then
				local ironAmount = amount * 20
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "rifle", amount, 0, ironAmount )
			elseif CraftRecipe == "Sniper" then
				local ironAmount = amount * 25
				guiGridListClear ( GUI_Gridlist_Inventory )
				guiGridListClear ( GUI_Gridlist_Craftrecipes )
				triggerServerEvent ("GTICraftSystem_CraftItems", localPlayer, "sniper", amount, 0, ironAmount )
			end
		end
	end
end
addEventHandler ("onClientGUIClick", root, craftItems )

function openCraftGUI ( )
    if guiGetVisible ( GUI_Window_Crafting ) then guiSetVisible ( GUI_Window_Crafting, false ) showCursor ( false, false ) return end
	guiSetVisible ( GUI_Window_Crafting, true )
	showCursor ( true, true )
	guiGridListClear ( GUI_Gridlist_Inventory )
	guiGridListClear ( GUI_Gridlist_Craftrecipes )
	triggerServerEvent ("GTIcraftingSystem.getItems", localPlayer )
end
addEvent ("GTIcraftSystem_OpenGUI", true )
addEventHandler ("GTIcraftSystem_OpenGUI", root, openCraftGUI )

function guiButtons ( )
	if source == GUI_Button_Close then
		guiSetVisible ( GUI_Window_Crafting, false )
		showCursor ( false, false )
		guiGridListClear ( GUI_Gridlist_Inventory )
		guiGridListClear ( GUI_Gridlist_Craftrecipes )
	end
end
addEventHandler ("onClientGUIClick", root, guiButtons )