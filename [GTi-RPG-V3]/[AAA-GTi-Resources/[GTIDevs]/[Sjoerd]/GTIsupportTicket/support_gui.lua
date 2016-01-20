local categories = {
    "General Question",
    "Vehicle Related",
    "Job Related",
}

supTicket = {
    gridlist = {},
    window = {},
    button = {}
}


ticketInfo = {
    button = {},
    window = {},
    memo = {}
}



GUIEditor = {
    button = {},
    window = {},
    combobox = {},
    memo = {}
}


    local screenW, screenH = guiGetScreenSize()
    supTicket.window[1] = guiCreateWindow((screenW - 377) / 2, (screenH - 298) / 2, 377, 298, "Support Tickets", false)
    guiWindowSetSizable(supTicket.window[1], false)
    guiSetVisible(supTicket.window[1], false)

    supTicket.gridlist[1] = guiCreateGridList(9, 25, 358, 216, false, supTicket.window[1])
    column1 = guiGridListAddColumn(supTicket.gridlist[1], "Player", 0.5)
    column2 = guiGridListAddColumn(supTicket.gridlist[1], "Category", 0.5)
    guiGridListSetSortingEnabled(supTicket.gridlist[1], false)
    supTicket.button[1] = guiCreateButton(9, 246, 96, 30, "Open", false, supTicket.window[1])
    guiSetProperty(supTicket.button[1], "NormalTextColour", "FFAAAAAA")
    supTicket.button[2] = guiCreateButton(140, 258, 96, 30, "Close", false, supTicket.window[1])
    guiSetProperty(supTicket.button[2], "NormalTextColour", "FFAAAAAA")
    supTicket.button[3] = guiCreateButton(271, 246, 96, 30, "Remove", false, supTicket.window[1])
    guiSetProperty(supTicket.button[3], "NormalTextColour", "FFAAAAAA")    

    
    local screenW, screenH = guiGetScreenSize()
    ticketInfo.window[1] = guiCreateWindow((screenW - 383) / 2, (screenH - 199) / 2, 383, 199, "Ticket Information", false)
    guiWindowSetSizable(ticketInfo.window[1], false)
    guiSetVisible(ticketInfo.window[1], false)
    
    ticketInfo.memo[1] = guiCreateMemo(10, 23, 363, 127, "", false, ticketInfo.window[1])
    guiMemoSetReadOnly(ticketInfo.memo[1], true)
    --ticketInfo.button[1] = guiCreateButton(9, 160, 80, 27, "Warp", false, ticketInfo.window[1])
    --guiSetProperty(ticketInfo.button[1], "NormalTextColour", "FFAAAAAA")
    ticketInfo.button[2] = guiCreateButton(293, 160, 80, 27, "Close", false, ticketInfo.window[1])
    guiSetProperty(ticketInfo.button[2], "NormalTextColour", "FFAAAAAA")
    ticketInfo.button[3] = guiCreateButton(99, 160, 80, 27, "Contact", false, ticketInfo.window[1])
    guiSetProperty(ticketInfo.button[3], "NormalTextColour", "FFAAAAAA")
    ticketInfo.button[4] = guiCreateButton(203, 160, 80, 27, "Resolved", false, ticketInfo.window[1])
    guiSetProperty(ticketInfo.button[4], "NormalTextColour", "FFAAAAAA")  
  
    
    
    local sWidth, sHeight = guiGetScreenSize()
    local Width,Height = 340,350
    local X = (sWidth/2) - (Width/2)
    local Y = (sHeight/2) - (Height/2)
    GUIEditor.window[1] = guiCreateWindow(X,Y,Width,Height,"Send Ticket",false)
    guiWindowSetSizable(GUIEditor.window[1], false)
    guiSetInputMode("no_binds_when_editing")

    GUIEditor.memo[1] = guiCreateMemo(0, 103, 323, 194, "", false, GUIEditor.window[1])
    GUIEditor.combobox[1] = guiCreateComboBox(0, 28, 323, 141, "", false, GUIEditor.window[1])
    closebutton = guiCreateButton(0, 305, 104, 23, "Close", false, GUIEditor.window[1])
    guiSetProperty(closebutton,"NormalTextColour", "FFFC0000")  
    sendbtn = guiCreateButton(230, 305, 104, 23, "Send", false, GUIEditor.window[1])    
    label = guiCreateLabel(135, 77, 179, 14, "Reason:", false, GUIEditor.window[1])
    guiSetFont(label, "default-bold-small")
    guiLabelSetColor(label, 219, 253, 254)
    guiSetProperty(sendbtn,"NormalTextColour", "FF00FD00")
    guiSetVisible( GUIEditor.window[1], false)
    for i,v in ipairs(categories) do
        guiComboBoxAddItem(GUIEditor.combobox[1],v)
    end 
    
