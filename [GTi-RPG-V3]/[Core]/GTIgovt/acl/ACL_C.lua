----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Ares
-- Date: 18 July 2015
-- Resource: GTIadmin/acl/acl.lua
-- Version: 1.0
----------------------------------------->>

aclCache = {}
currentACL = ""

addEventHandler("onClientGUITabSwitched", aclGUI.tab[1], function()
    triggerServerEvent("GTIgovtPanel.getACLs", resourceRoot)
    triggerServerEvent("GTIgovtPanel.checkACLPerm", resourceRoot, localPlayer)
    end)

addEvent("GTIgovtPanel.clientGetACLs", true)
addEventHandler("GTIgovtPanel.clientGetACLs", root, function ()
    triggerServerEvent("GTIgovtPanel.getACLs", resourceRoot)
end
)

addEventHandler("onClientGUITabSwitched", root, function(tab)
    if ( tab == aclGUI.admintab[5] ) then
        currentACL = "Admin5"
    elseif ( tab == aclGUI.admintab[4] ) then
        currentACL = "Admin4"
    elseif ( tab == aclGUI.admintab[3] ) then
        currentACL = "Admin3"
    elseif ( tab == aclGUI.admintab[2] ) then
        currentACL = "Admin2"
    elseif ( tab == aclGUI.admintab[1] ) then
        currentACL = "Admin1"
    elseif ( tab == aclGUI.emtab[1] ) then
        currentACL = "Event1"
    elseif ( tab == aclGUI.qcatab[3] ) then
        currentACL = "QCA5"
    elseif ( tab == aclGUI.qcatab[2] ) then
        currentACL = "QCA4"
    elseif ( tab == aclGUI.qcatab[1] ) then
        currentACL = "QCA1"    
	elseif ( tab == aclGUI.archtab[5] ) then
		currentACL = "Arch5"
	elseif ( tab == aclGUI.archtab[4] ) then
		currentACL = "Arch4"
	elseif ( tab == aclGUI.archtab[1] ) then
		currentACL = "Arch1"
    else
        currentACL = ""
    end

end)

addEvent("GTIgovtPanel.composeAclList", true)
addEventHandler("GTIgovtPanel.composeAclList", root, function (table)
    aclCache = table

    QCA5, QCA4, QCA1 = aclCache [ 'QCA5' ], aclCache [ 'QCA4' ], aclCache [ 'QCA1' ]
    Dev5, Dev4, Dev3, Dev2, Dev1 = aclCache [ 'Dev5' ], aclCache [ 'Dev4' ], aclCache [ 'Dev3' ], aclCache [ 'Dev2' ], aclCache [ 'Dev1' ]
    Admin5, Admin4, Admin3, Admin2, Admin1 = aclCache [ 'Admin5' ], aclCache [ 'Admin4' ], aclCache [ 'Admin3' ], aclCache [ 'Admin2' ], aclCache [ 'Admin1' ]
    Arch5, Arch4, Arch1 = aclCache [ 'Arch5' ], aclCache [ 'Arch4' ], aclCache [ 'Arch1' ]
    Event = aclCache [ 'Event1' ]

    guiGridListClear( aclGUI.gridlist['Admin5'] )
    for index, objects in ipairs ( Admin5 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Admin5'] )
        guiGridListSetItemText( aclGUI.gridlist['Admin5'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Admin5'], row, 1, 255, 0, 0)
    end

    guiGridListClear( aclGUI.gridlist['Admin4'] )
    for index, objects in ipairs ( Admin4 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Admin4'] )
        guiGridListSetItemText( aclGUI.gridlist['Admin4'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Admin4'], row, 1, 255, 0, 0)
    end

    guiGridListClear( aclGUI.gridlist['Admin3'] )
    for index, objects in ipairs ( Admin3 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Admin3'] )
        guiGridListSetItemText( aclGUI.gridlist['Admin3'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Admin3'], row, 1, 255, 0, 0)
    end

    guiGridListClear( aclGUI.gridlist['Admin2'] )
    for index, objects in ipairs ( Admin2 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Admin2'] )
        guiGridListSetItemText( aclGUI.gridlist['Admin2'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Admin2'], row, 1, 255, 0, 0)
    end

    guiGridListClear( aclGUI.gridlist['Admin1'] )
    for index, objects in ipairs ( Admin1 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Admin1'] )
        guiGridListSetItemText( aclGUI.gridlist['Admin1'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Admin1'], row, 1, 255, 0, 0)
    end

    guiGridListClear( aclGUI.gridlist['Event'] )
    for index, objects in ipairs ( Event ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Event'] )
        guiGridListSetItemText( aclGUI.gridlist['Event'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Event'], row, 1, 255, 0, 0)
    end
    
    guiGridListClear( aclGUI.gridlist['QCA5'] )
    for index, objects in ipairs ( QCA5 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['QCA5'] )
        guiGridListSetItemText( aclGUI.gridlist['QCA5'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['QCA5'], row, 1, 255, 0, 0)
    end
    
    guiGridListClear( aclGUI.gridlist['QCA4'] )
    for index, objects in ipairs ( QCA4 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['QCA4'] )
        guiGridListSetItemText( aclGUI.gridlist['QCA4'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['QCA4'], row, 1, 255, 0, 0)
    end
    
    guiGridListClear( aclGUI.gridlist['QCA1'] )
    for index, objects in ipairs ( QCA1 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['QCA1'] )
        guiGridListSetItemText( aclGUI.gridlist['QCA1'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['QCA1'], row, 1, 255, 0, 0)
    end

    guiGridListClear( aclGUI.gridlist['Arch5'] )
    for index, objects in ipairs ( Arch5 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Arch5'] )
        guiGridListSetItemText( aclGUI.gridlist['Arch5'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Arch5'], row, 1, 255, 0, 0)
    end
    
    guiGridListClear( aclGUI.gridlist['Arch4'] )
    for index, objects in ipairs ( Arch4 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Arch4'] )
        guiGridListSetItemText( aclGUI.gridlist['Arch4'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Arch4'], row, 1, 255, 0, 0)
    end
    
    guiGridListClear( aclGUI.gridlist['Arch1'] )
    for index, objects in ipairs ( Arch1 ) do
        row = guiGridListAddRow ( aclGUI.gridlist['Arch1'] )
        guiGridListSetItemText( aclGUI.gridlist['Arch1'], row, 1, objects:gsub("user.", ""), false, false)
        guiGridListSetItemColor( aclGUI.gridlist['Arch1'], row, 1, 255, 0, 0)
    end
end)

addEventHandler("onClientGUIClick", root, function ( )
    if ( source == aclGUI.gridlist['Event'] or source == aclGUI.gridlist['Admin1'] or source == aclGUI.gridlist['Admin2'] or source == aclGUI.gridlist['Admin3'] or source == aclGUI.gridlist['Admin4'] or source == aclGUI.gridlist['Admin5'] or source == aclGUI.gridlist['QCA1'] or source == aclGUI.gridlist['QCA4'] or source == aclGUI.gridlist['QCA5'] or source == aclGUI.gridlist['Arch5'] or source == aclGUI.gridlist['Arch4'] or source == aclGUI.gridlist['Arch1']) then
        local row, col = guiGridListGetSelectedItem(source)
            if ( guiGridListGetItemText(source, row, col ) ~= "" ) then
                triggerServerEvent("GTIgovtPanel.getObjectInfo", resourceRoot, guiGridListGetItemText(source, row, col) )
            end
    elseif ( source == aclGUI.button[1] ) then
        guiSetVisible(aclExeAdd.window[1], true)
        guiBringToFront(aclExeAdd.window[1])
    elseif ( source == aclGUI.button[2] ) then
        guiSetVisible(aclExeRemove.window[1], true)
        guiBringToFront(aclExeRemove.window[1])
    elseif ( source == aclExeAdd.button[1] ) then
        addToACL ( guiGetText ( aclExeAdd.edit[1] ) )
    elseif ( source == aclExeAdd.button[2] ) then
        guiSetVisible( aclExeAdd.window[1], false)
    elseif ( source == aclExeRemove.button[1] ) then
        removeFromACL ( guiGetText ( aclExeRemove.edit[1] ) )
    elseif ( source == aclExeRemove.button[2] ) then
        guiSetVisible( aclExeRemove.window[1], false)
    end
end)

addEventHandler("onClientGUIAccepted", aclExeAdd.edit[1], function ( )
    addToACL ( guiGetText(source) )
end)

addEventHandler("onClientGUIAccepted", aclExeRemove.edit[1], function ( )
    removeFromACL ( guiGetText(source) )

end)

function addToACL ( account )
    if (account ~= "" and currentACL ~= "" ) then
        if ( currentACL == "Admin5") then
            exports.GTIhud:dm("Due to security measures you cannot add a player in this ACL.", 255, 0, 0)
        else
            triggerServerEvent( "GTIgovtPanel.addToACL", resourceRoot, currentACL, account)
            guiSetVisible( aclExeAdd.window[1], false)
        end
    else
        exports.GTIhud:dm("You must fill in the input.", 255, 0, 0)
    end
end

function removeFromACL ( account )
    if ( account ~= "" and currentACL ~= "" ) then
        if (currentACL == "Admin5" ) then
            exports.GTIhud:dm("Due to security measures you cannot remove players from this ACL.", 255, 0, 0)
        else
            triggerServerEvent( "GTIgovtPanel.removeFromACL", resourceRoot, currentACL, account )
            guiSetVisible( aclExeRemove.window[1], false)
        end
    else
        exports.GTIhud:dm("You must fill in the input.", 255, 0, 0)
    end
end
    
addEvent("GTIgovtPanel.composeObjectInfo", true)
addEventHandler("GTIgovtPanel.composeObjectInfo", root, function (table)
    local last_login, last_name = table[1], table[2]
    local day,mon,year = exports.GTIutil:todate(last_login)
    local mon = exports.GTIutil:getMonthName(mon)
    guiSetText(aclGUI.label[2], day.." "..mon.." "..year )
    guiSetText(aclGUI.label[4], last_name )
end)

local wasitchangedalready = false
addEvent("GTIgovtPanel.tabsDisable", true)
addEventHandler("GTIgovtPanel.tabsDisable", root, function (plr, acl)
    if (plr == localPlayer) then
		if ( not wasitchangedalready ) then
			for _, ACLs in pairs({aclGUI.admintab, aclGUI.emtab, aclGUI.qcatab, aclGUI.archtab}) do
				for index, object in pairs(ACLs) do
					guiSetVisible(object, false)
				end
			end
			for _, ACLs in pairs({aclGUI.admintab, aclGUI.emtab, aclGUI.qcatab, aclGUI.archtab}) do
				for index, object in pairs(ACLs) do
					if ( guiGetVisible(object) ) then
						guiSetSelectedTab(aclGUI.tabpanel[1], object)
						break
					end
				end
			end
			wasitchangedalready = true
		end
        if (acl == "QCA") then
			for index, object in pairs(aclGUI.qcatab) do
				guiSetVisible(object, true)
			end
        elseif (acl == "Arch") then
           	for index, object in pairs(aclGUI.archtab) do
				guiSetVisible(object, true)
			end
        elseif (acl == "Admin") then
			for index, object in pairs(aclGUI.admintab) do
				guiSetVisible(object, true)
			end
			guiSetVisible(aclGUI.emtab[1], true)
		end
    end
end)    
