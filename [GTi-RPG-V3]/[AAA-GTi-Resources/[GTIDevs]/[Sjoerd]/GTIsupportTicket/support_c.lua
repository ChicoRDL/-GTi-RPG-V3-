

local reports = {}
local reportMsg = {}
local reportPlr = {}
local thePlayer = ""

function getTickets(info, id)
    if guiGetVisible(supTicket.window[1]) then
        guiSetVisible(supTicket.window[1], false)
        showCursor( false)
    else
        guiGridListClear(supTicket.gridlist[1])
        guiSetVisible(supTicket.window[1], true)
        showCursor(true)
        for i,v in ipairs(info) do
            local row = guiGridListAddRow ( supTicket.gridlist[1] )
            guiGridListSetItemText ( supTicket.gridlist[1], row, column1, v[1], false, false )       
            guiGridListSetItemText ( supTicket.gridlist[1], row, column2, v[3], false, false )  
            guiGridListSetItemData ( supTicket.gridlist[1], row, column1, {v[2],v[3],v[1]} )
            reportMsg[v[1]] = v[2]
            reportPlr[v[1]] = v[4]
        end
    end
end
addEvent( "GTIsupTicket.getTickets", true)
addEventHandler( "GTIsupTicket.getTickets", root, getTickets)

function report()
    if (guiGetVisible(GUIEditor.window[1])) then
        guiSetVisible(GUIEditor.window[1], false)
        showCursor(false)
    else
        guiSetVisible(GUIEditor.window[1], true)
        showCursor(true)
    end
end
addCommandHandler("helpme", report)



function buttonHandle()
    if (source == sendbtn) then
        if (reports[localPlayer]) then 
            exports.GTIhud:dm("You already have a pending ticket, use /dt to delete it.", 255, 0, 0)
            return
        end
        if (guiGetText(GUIEditor.memo[1]) == "") then
            exports.GTIhud:dm("You have to explain your problem", 255, 0, 0)
            return
        end
        local item = guiComboBoxGetSelected(GUIEditor.combobox[1])
        if not item or item == nil then
            outputChatBox("You have to select a categorie.",255,0,0)
            return
        end
        local rule = guiComboBoxGetItemText(GUIEditor.combobox[1], item)
        if not rule or rule == "" then
            outputChatBox("You have to select a categorie.",255,0,0)
            return
        end
        local msg = guiGetText(GUIEditor.memo[1])
        triggerServerEvent("GTIsupTicket.sendTicket",resourceRoot,msg,rule)
        guiSetVisible( GUIEditor.window[1], false)
        guiSetText(GUIEditor.memo[1], "")
        showCursor(false)
        exports.GTIhud:dm("Support ticket successfully sent!", 0, 255, 0)
        reports[localPlayer] = true
        
    elseif (source == closebutton) then
        guiSetVisible(GUIEditor.window[1], false)
        showCursor( false)
        
    elseif (source == supTicket.button[1]) then
        local row, col = guiGridListGetSelectedItem ( supTicket.gridlist[1])
        if row and col then
            local playerName = guiGridListGetItemText( supTicket.gridlist[1], row, column1)
            if playerName ~= "" then
                local data = guiGridListGetItemData(supTicket.gridlist[1],row,column1)
                guiSetVisible(ticketInfo.window[1], true)
                guiSetText(ticketInfo.memo[1], reportMsg[playerName])
                guiSetVisible(supTicket.window[1], false)
                triggerServerEvent("GTIsupTicket.notifyPlayer", root, localPlayer, reportPlr[playerName])
                thePlayer = reportPlr[playerName]
            end
        end
        
    elseif (source == supTicket.button[2]) then
        guiSetVisible(ticketInfo.window[1], false)
        guiSetVisible(supTicket.window[1], false) 
        showCursor(false)
        
    elseif (source == supTicket.button[3]) then
        local row, col = guiGridListGetSelectedItem ( supTicket.gridlist[1])
        if row and col then
            local playerName = guiGridListGetItemText( supTicket.gridlist[1], row, column1)
            if playerName ~= "" then
                local data = guiGridListGetItemData(supTicket.gridlist[1],row,column1)
                triggerServerEvent("GTIsupTicket.delete", resourceRoot, localPlayer, playerName, false)
                guiGridListRemoveRow(supTicket.gridlist[1],row)
            end
        end  
        
    --[[elseif (source == ticketInfo.button[1]) then
        if (not thePlayer) then return end
        triggerServerEvent("GTIsupTicket.warp", root, localPlayer, thePlayer) 
        ]]
    elseif (source == ticketInfo.button[3]) then
        if (not thePlayer) then return end
        triggerServerEvent("GTIsupTicket.notifyPlayer", root, localPlayer, thePlayer, true, false)  
        
    elseif (source == ticketInfo.button[2]) then
        guiSetVisible(ticketInfo.window[1], false)
        guiSetVisible(supTicket.window[1], true)
        triggerServerEvent("GTIsupTicket.notifyPlayer", root, localPlayer, thePlayer, false, true)  
        thePlayer = ""
        
    elseif (source == ticketInfo.button[4]) then    
        local row, col = guiGridListGetSelectedItem ( supTicket.gridlist[1])
        if row and col then
            local playerName = guiGridListGetItemText( supTicket.gridlist[1], row, column1)
            if playerName ~= "" then
                local data = guiGridListGetItemData(supTicket.gridlist[1],row,column1)
                triggerServerEvent("GTIsupTicket.delete", resourceRoot, localPlayer, playerName, true)
                guiGridListRemoveRow(supTicket.gridlist[1],row)
                guiSetVisible(ticketInfo.window[1], false)
                guiSetVisible(supTicket.window[1], true)
                thePlayer = ""
            end
        end 
    end    
end 
addEventHandler("onClientGUIClick", root, buttonHandle)



addEventHandler( "onClientGUIDoubleClick", root,
    function()
        if source == supTicket.gridlist[1] then
            local row, col = guiGridListGetSelectedItem ( source)
            if row and col then
                local playerName = guiGridListGetItemText( source, row, column1)
                if playerName ~= "" then
                    local data = guiGridListGetItemData(source,row,column1)
                    triggerServerEvent("GTIsupTicket.checkReport", localPlayer, reportPlr[playerName], playerName)
                    thePlayer = reportPlr[playerName]
                end
            end
        end
    end
)

function openTicket(you, opened, playerName)
    if (you == localPlayer) then 
        if (opened) then
            outputChatBox("Report is already being handled.", 255, 0, 0)
        else
            guiSetVisible(ticketInfo.window[1], true)
            guiSetText(ticketInfo.memo[1], reportMsg[playerName])
            guiSetVisible(supTicket.window[1], false)
            triggerServerEvent("GTIsupTicket.notifyPlayer", root, localPlayer, reportPlr[playerName])    
        end
    end       
end
addEvent("GTIsupTicket.openTicket", true)
addEventHandler("GTIsupTicket.openTicket", root, openTicket)    


function reset(plr)
    if (plr == localPlayer) then
        reports[plr] = nil
    end
end
addEvent("GTIsupTicket.reset", true)
addEventHandler("GTIsupTicket.reset", root, reset)
