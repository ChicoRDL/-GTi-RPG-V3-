local sWidth, sHeight = guiGetScreenSize()
addEventHandler("onClientResourceStart", resourceRoot,
    function()
		local Width,Height = 633,573
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
        window = guiCreateWindow(X, Y, Width, Height, "", false)
        guiWindowSetSizable(window, false)

        gridlist = guiCreateGridList(7, 20, 617, 495, false, window)
		guiGridListSetSortingEnabled(gridlist,false)
        column1 = guiGridListAddColumn(gridlist, "Reporter", 0.18)
        column2 = guiGridListAddColumn(gridlist, "Reporter's job", 0.18)
        column3 = guiGridListAddColumn(gridlist, "Last Attacker", 0.18)
        column4 = guiGridListAddColumn(gridlist, "Attacker's job", 0.18)
        column5 = guiGridListAddColumn(gridlist, "Rule broken", 0.18)    
		invalidbtn = guiCreateButton(0, 525, 168, 23, "Invalid", false, window)
		validbtn = guiCreateButton(229, 525, 168, 23, "Punished", false, window)
		guiSetProperty(validbtn,"NormalTextColour", "FF00FD00")
		guiSetProperty(invalidbtn,"NormalTextColour", "FFFC0000")  
		closebtn = guiCreateButton(458, 525, 168, 23, "Close", false, window)   
		guiSetVisible(window,false)
    end
)

function getReports(info)
    if guiGetVisible(window) then
		guiSetVisible(window, false)
		showCursor( false)
	else
		guiGridListClear(gridlist)
		guiSetVisible(window, true)
		showCursor(true)
		for i,v in ipairs(info) do
			local row = guiGridListAddRow ( gridlist )
			guiGridListSetItemText ( gridlist, row, column1, v[1], false, false )   	
			guiGridListSetItemText ( gridlist, row, column2, v[2], false, false )  
			if v[1] ~= v[3] then
				guiGridListSetItemText ( gridlist, row, column3, v[3], false, false )   	
				guiGridListSetItemText ( gridlist, row, column4, v[4], false, false )   	
			else
				guiGridListSetItemText ( gridlist, row, column3, "N/A", false, false )   	
				guiGridListSetItemText ( gridlist, row, column4, "N/A", false, false )   	
			end
			guiGridListSetItemText ( gridlist, row, column5, v[7], false, false )   	
			guiGridListSetItemData ( gridlist, row, column1, {v[5],v[6],v[1]} )
		end
	end
end
addEvent( "GTIreport.getReports", true)
addEventHandler( "GTIreport.getReports", root, getReports)
addEventHandler( "onClientGUIClick", root,
    function()
		if source == closebtn then
            if guiGetVisible(window) then
                guiSetVisible(window, false)
                showCursor( false)
            end
		elseif source == invalidbtn then
            local row, col = guiGridListGetSelectedItem ( gridlist)
            if row and col then
                local playerName = guiGridListGetItemText( gridlist, row, column1)
                if playerName ~= "" then
					local data = guiGridListGetItemData(gridlist,row,column1)
                    triggerServerEvent("GTIreport.delete", resourceRoot, data[1], data[3], false)
					guiGridListRemoveRow(gridlist,row)
                end
            end
		elseif source == validbtn then
            local row, col = guiGridListGetSelectedItem ( gridlist)
            if row and col then
                local playerName = guiGridListGetItemText( gridlist, row, column1)
                if playerName ~= "" then
					local data = guiGridListGetItemData(gridlist,row,column1)
                    triggerServerEvent("GTIreport.delete", resourceRoot, data[1], data[3], true)
					guiGridListRemoveRow(gridlist,row)
                end
            end
        end
    end
)
addEventHandler( "onClientGUIDoubleClick", root,
    function()
        if source == gridlist then
            local row, col = guiGridListGetSelectedItem ( source)
            if row and col then
                local playerName = guiGridListGetItemText( source, row, column1)
                if playerName ~= "" then
					local data = guiGridListGetItemData(source,row,column1)
                    triggerServerEvent("GTIreport.getss", resourceRoot, data[1])
					msg = data[2]
                end
            end
        end
    end
)

function recievess(ss,rep)
    if isElement(image) then
		destroyElement(image)
    end
    image = dxCreateTexture( ss )
	addEventHandler("onClientRender",root,renderss)
	bindKey("space","down",stopRender)
    guiSetVisible(window, false)
	reportmsg = msg or ""
	report = rep
end
addEvent( "GTIreport.recievess", true)
addEventHandler( "GTIreport.recievess", root, recievess)

function stopRender()
	unbindKey("space","down",stopRender)
	removeEventHandler("onClientRender",root,renderss)
	if report then
		guiSetVisible(window, true)
	end
	report = nil
	msg = false
end

local iWidth,iHeight = sWidth,sHeight
local X = (sWidth/2) - (iWidth/2)
local Y = (sHeight/2) - (iHeight/2)
function renderss()
	dxDrawImage( X, Y, iWidth, iHeight, image )
	dxDrawText(reportmsg.."\n\nPress 'space' to hide", sWidth/2, sHeight-105)
end
