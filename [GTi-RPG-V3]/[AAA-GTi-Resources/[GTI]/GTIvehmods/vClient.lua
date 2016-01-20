--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz ~
-- Resource: GTImods/vClient.lua ~
-- Description: Vehicle Modifications ~
-- Data: #Vehmods
--<--------------------------------->--

addEventHandler("onClientResourceStart", resourceRoot,
    function()
        panel = guiCreateWindow(229, 146, 763, 542, "Grand Theft International -|- Modifications Panel", false)
        guiSetAlpha(panel, 0.95)           
		guiWindowSetSizable(panel, false)
        guiSetVisible(panel, false)

---- Information Label - Big Text

        Information = guiCreateLabel(81, 30, 595, 76, "Using these mods can cause changes in your game, depending on the type of computer you have.\nWe are not responsible for your actions in using these mods.\nIf you use too many mods can cause problems with the limitations of GTA SA (being an old game).\nYou can start see your map starting disappear.\nWhen you're downloading these mods, you should always wait for both files finished it(.dff and .txd).", false, panel)
        guiSetFont(Information, "default-bold-small")
        guiLabelSetColor(Information, 225, 100, 0)    

		TAB = guiCreateTabPanel(10, 76, 743, 456, false, panel)
        VehiclesTAB = guiCreateTab("Vehicles", TAB)
        gl = guiCreateGridList(11, 13, 722, 359, false, VehiclesTAB)
        guiGridListSetSortingEnabled(gl, false)
        guiGridListAddColumn(gl, "ID", 0.12)
        guiGridListAddColumn(gl, "Vehicle Name", 0.21)
        guiGridListAddColumn(gl, "Replace With", 0.21)
        guiGridListAddColumn(gl, "Size", 0.12)
        guiGridListAddColumn(gl, "Download", 0.13)
        guiGridListAddColumn(gl, "Enabled", 0.13)
        VehicleI = guiCreateStaticImage(11, 377, 55, 49, "IMG/Vehicles.png", false, VehiclesTAB)
        VehicleII = guiCreateStaticImage(678, 376, 55, 49, "IMG/Vehicles.png", false, VehiclesTAB)
		
        download = guiCreateButton(75, 396, 111, 25, "Download", false, VehiclesTAB)
        guiSetFont(download, "default-bold-small")
        guiSetProperty(download, "NormalTextColour", "F8A5A5A5")
		
        del = guiCreateButton(557, 396, 111, 25, "Delete", false, VehiclesTAB)
        guiSetFont(del, "default-bold-small")
        guiSetProperty(del, "NormalTextColour", "F8A5A5A5")
		
        enable = guiCreateButton(316, 396, 111, 25, "Enable/Disable", false, VehiclesTAB)
        guiSetFont(enable, "default-bold-small")
        guiSetProperty(enable, "NormalTextColour", "F8A5A5A5")
        close = guiCreateButton(679, 23, 74, 24, "[ Close ]", false, panel)
        guiSetFont(close, "default-bold-small")
        guiSetProperty(close, "NormalTextColour", "F8A5A5A5") 
		
	searchEd = guiCreateEdit(644, 76, 104, 23, "", false, panel)
        guiEditSetMaxLength(searchEd, 20)
        searchLab = guiCreateLabel(644, 56, 103, 20, "Vehicle Name:", false, panel)
        guiSetFont(searchLab, "default-bold-small")
        guiLabelSetColor(searchLab, 253, 220, 1)
        guiLabelSetHorizontalAlign(searchLab, "center", false)
        guiLabelSetVerticalAlign(searchLab, "center")    
       CW(panel) 
    end
)
local eTable = {}
local dTable = {}
local enabledIDs = {}

function vehModsCmd()
local status = not guiGetVisible(panel)
guiSetVisible(panel, status)
showCursor(status)
refreshList()
end
addEvent ("GTIuserpanel_vehmods", true )
addEventHandler ("GTIuserpanel_vehmods", root, vehModsCmd )
addCommandHandler("vehmods", vehModsCmd )

addEventHandler('onClientGUIClick', root,
function()
    if ( source == close ) then
        guiSetVisible(panel, false)
        showCursor(guiGetVisible(panel))
        guiBringToFront(searchEd)
    elseif ( source == Information ) then
	guiBringToFront(searchEd)
    elseif ( source == download ) then
        local row, col = guiGridListGetSelectedItem(gl)
	guiBringToFront(searchEd)
        if ( row ~= -1 and col ~= 0 ) then
            local name = guiGridListGetItemData(gl, row, 3)
            downloadMod(name)
            refreshList()
        end
            
    elseif ( source == enable ) then
        local row, col = guiGridListGetSelectedItem ( gl )
	guiBringToFront(searchEd)
        if ( not isPedInVehicle(localPlayer) ) then
            local row, col = guiGridListGetSelectedItem ( gl )
            if ( row ~= -1 and col ~= 0 ) then
                local vehName = guiGridListGetItemData(gl, row, 3)
                local enab = guiGridListGetItemText( gl, row, 6 )
                if ( enab == 'Yes' ) then
                    setModEnabled(vehName, false)
                    savexml()
                else
                    setModEnabled(vehName, true)
                    savexml()
                end
            end
        else
            dm("Leave your vehicle first!", 255, 0, 0 )
        end
    
    elseif ( source == del ) then
        local row, col = guiGridListGetSelectedItem ( gl )
        local iDownload = guiGridListGetItemText(gl, row, 5)
        local iEnable = guiGridListGetItemText(gl, row, 6)
        local veh = guiGridListGetItemData(gl, row, 3)
	guiBringToFront(searchEd)
        if ( iDownload == "Yes" ) then
            if ( iEnable == "Yes" ) then  
                dm("Disable this mod first", 255, 0, 0) 
            return end
            guiSetEnabled(source, false)
            guiSetEnabled(enable, false)
            guiSetEnabled(del, true)
            guiGridListSetItemText(gl, row, 3, "No", false, false)
            deleteMod(veh)
            refreshList()
            savexml()
        end
        
    elseif ( source == gl ) then
        local row, col = guiGridListGetSelectedItem(source)
	guiBringToFront(searchEd)
        if ( row ~= -1 and col ~= 0 ) then
            local vehName = guiGridListGetItemData(gl, row, 3)
	    local _, _, dff, txd = getModData(vehName)

            if ( fileExists("mods/"..dff) and fileExists("mods/"..txd) ) then
                guiSetEnabled( enable, true )
                guiSetEnabled(del, true )
                guiSetEnabled(download, false )
            else
                guiSetEnabled(download, true )
                guiSetEnabled(enable, false)
                guiSetEnabled(del, false )
            end
            
        else
            guiSetEnabled(enable, false )
            guiSetEnabled(download, false )
            guiSetEnabled(del, false )
        end
    end
end
)

function deleteMod(name)
	local _, _, dff, txd = getModData(name)
        if ( fileExists("mods/"..txd) ) then
            fileDelete("mods/"..txd)
            dm('TXD file has been deleted successfully!', 0, 255, 0)
            refreshList()
        end 
        
        if ( fileExists("mods/"..dff) ) then
            fileDelete("mods/"..dff)
            dm('DFF file has been deleted successfully!', 0, 255, 0)
            refreshList()
        end
end

function setModEnabled(name, state)
	local _, _, dff, txd, id, _, weirdbool = getModData(name)
        local row, col = guiGridListGetSelectedItem( gl )
            if ( fileExists("mods/"..dff) ) then
                if ( fileExists("mods/"..txd) ) then
                    if ( state == false ) then
                        engineRestoreModel( id )
                        eTable[name] = false
                        enabledIDs[id] = false
                        guiGridListSetItemText( gl, row, 6, "No", false, false )
                    else
                        if ( weirdbool ) then
                            if ( enabledIDs[id] ) then
                            dm("Another mod already enabled at the same vehicle.", 255, 0, 0 )
                            return end
                            local txd1 = engineLoadTXD ( "mods/"..txd )
                            if ( not txd1 ) then
                                dm("Failed to load the mod", 255, 0, 0 )
                            end
                            if ( not engineImportTXD ( txd1, id ) ) then
                                dm("Failed to load the mod", 255, 0, 0 )
                            end
                        end
                        local dff = engineLoadDFF ( "mods/"..dff, id )
                        if ( not dff ) then
                            dm("Failed to load the mod", 255, 0, 0)
                        end
                        if ( not engineReplaceModel ( dff , id ) ) then
                            dm("Failed to replace the mod", 255, 0, 0)
                        end
                        eTable[name] = true
                        enabledIDs[id] = true
                        guiGridListSetItemText(gl, row, 6, "Yes", false, false)
                    end
                end
            end
end

function downloadMod(name)
     	local _, _, dff, txd = getModData(name)
	downloadFile('mods/'..dff)
	downloadFile('mods/'..txd)
	refreshList()
	dTable[name] = true
	dm('Please wait while downloading your mod!', 0, 255, 0)
end

function onDownloadFinish (file, success)
    if ( source == resourceRoot ) then
        if ( success ) then
            refreshList()
            dm("Your mod has been successfully downloaded ("..tostring(file)..")", 0, 255, 0)
        end
    end
end
addEventHandler ( "onClientFileDownloadComplete", getRootElement(), onDownloadFinish )


function refreshList()
	guiGridListClear(gl)
	for categories, data in pairs(vTable) do
		local categoryRow = guiGridListAddRow (gl)
		guiGridListSetItemText(gl, categoryRow, 1, categories, true, false)
		guiGridListSetItemColor(gl, categoryRow, 1, 30, 125, 255)
		for _, dataData in pairs (data) do
			modName, modVehicle, modDFF, modTXD, modModel, modSize = dataData[1], dataData[2], dataData[3], dataData[4], dataData[5], dataData[6]

			if ( fileExists('mods/'..modDFF) and fileExists('mods/'..modTXD) ) then
			    downloaded = 'Yes'
			else
			    downloaded = 'No'
			end
		
			if ( eTable[modName] ) then
			    ena = 'Yes'
			else
			    ena = 'No'
			end
	
			row = guiGridListAddRow(gl)

			guiGridListSetItemText( gl, row, 1, modModel, false, false)
			guiGridListSetItemText( gl, row, 2, modVehicle, false, false)
			guiGridListSetItemText( gl, row, 3, modName, false, false)
			guiGridListSetItemText( gl, row, 4, modSize, false, false)
			guiGridListSetItemText( gl, row, 5, downloaded, false, false)
			guiGridListSetItemText( gl, row, 6, ena, false, false)
			guiGridListSetItemData( gl, row, 2, modVehicle)
			guiGridListSetItemData( gl, row, 3, modName)

			guiSetEnabled(enable, false)
			guiSetEnabled(del, false)
			guiSetEnabled(download, false)
			guiSetEnabled(close, true)
		end
	end
end

function searching ( )
	if source == searchEd then
		if guiGetText(source) == "" then
			return refreshList()
		end
			guiGridListClear(gl)
		for categories, data in pairs(vTable) do
			local categoryRow = guiGridListAddRow (gl)
			guiGridListSetItemText(gl, categoryRow, 1, categories, true, false)
			guiGridListSetItemColor(gl, categoryRow, 1, 30, 125, 255)
			for _, dataData in pairs (data) do
				modName, modVehicle, modDFF, modTXD, modModel, modSize = dataData[1], dataData[2], dataData[3], dataData[4], dataData[5], dataData[6]
				if string.find(modVehicle:lower ( ) , guiGetText(source):lower ( ) ) then 
					if ( fileExists('mods/'..modDFF) and fileExists('mods/'..modTXD) ) then
					    downloaded = 'Yes'
					else
					    downloaded = 'No'
					end
		
					if ( eTable[modName] ) then
					    ena = 'Yes'
					else
					    ena = 'No'
					end
	
					row = guiGridListAddRow(gl)

					guiGridListSetItemText( gl, row, 1, modModel, false, false)
					guiGridListSetItemText( gl, row, 2, modVehicle, false, false)
					guiGridListSetItemText( gl, row, 3, modName, false, false)
					guiGridListSetItemText( gl, row, 4, modSize, false, false)
					guiGridListSetItemText( gl, row, 5, downloaded, false, false)
					guiGridListSetItemText( gl, row, 6, ena, false, false)
					guiGridListSetItemData( gl, row, 2, modVehicle)
					guiGridListSetItemData( gl, row, 3, modName)

					guiSetEnabled(enable, false)
					guiSetEnabled(del, false)
					guiSetEnabled(download, false)
					guiSetEnabled(close, true)
				end
			end
				if ( not string.find( guiGridListGetItemText(gl, categoryRow, 1) : lower ( ), guiGetText(source):lower ( ) ) ) then
					guiGridListRemoveRow ( gl, categoryRow )
				end
		end
	end
end
addEventHandler("onClientGUIChanged", resourceRoot, searching)

function savexml()
    local file = xmlCreateFile ('@saving.xml', 'data')
	for categories, data in pairs(vTable) do
		for _, dataData in pairs (data) do
			modName, modVehicle, modDFF, modTXD, modModel, modSize = dataData[1], dataData[2], dataData[3], dataData[4], dataData[5], dataData[6]
       			local child = xmlCreateChild( file, 'mod' )
        		xmlNodeSetAttribute( child, 'name', modName )
     			xmlNodeSetAttribute( child, 'enabled', tostring( isset( eTable[modName] ) ) )
		end
	end
    xmlSaveFile( file )
    xmlUnloadFile( file )
end


addEventHandler("onClientResourceStart", resourceRoot, function ( )
    setTimer ( function ( )
        refreshList ( )
        local file = xmlLoadFile ( '@saving.xml', 'data' )
        if file then
        for i, v in ipairs ( xmlNodeGetChildren( file ) ) do
                local name = tostring( xmlNodeGetAttribute( v, 'name' ) )
                local enabled = toboolean( xmlNodeGetAttribute( v, 'enabled' ) )
                if ( getModData(name) and tostring( enabled ):lower ( ) ~= "false" ) then
                    setModEnabled(name, true)
                    eTable[name] = true
	  	    local _, _, _, _, id = getModData(name)
                    enabledIDs[id] = true
                end
            end
        end
    end, 500, 1 )
end )

--->>

function dm (t, r, g, b)
    if ( t and r and g and b ) then
        exports.GTIhud:dm(t, r, g, b)
    end
end

function getModData ( modName )
	for categories, data in pairs (vTable) do
		for _, dataData in pairs (data) do
			if ( dataData[1] == modName ) then
				return dataData[1], dataData[2], dataData[3], dataData[4], dataData[5], dataData[6], dataData[7]
			end
		end
	end
end

function toboolean ( input )
    local input = string.lower ( tostring ( input ) )
    if ( input == 'true' ) then
        return true
    elseif ( input == 'false' ) then
        return false
    else return nil end
end

function isset ( value )
    if ( value ) then
        return true
    end
    return false
end

function CW(center_window)
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(center_window, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetPosition(center_window, x, y, false)
end
