GUIEditor = {
    button = {},
    staticimage = {},
    gridlist = {},
    edit = {},
    label = {},
    window = {},
    memo = {}
}
function renderAppGUI()
	if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
	
    GTIPhone = exports.GTIdroid:getGTIDroid()
    if (not GTIPhone) then return end
    GTIApp = exports.GTIdroid:getGTIDroidAppButton("Notes")
    addEventHandler("onClientGUIClick", GTIApp, showAppGUI, false)
     
    GUIEditor.staticimage[1] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/bkgr_black.png", false, GTIPhone)
    GUIEditor.staticimage[2] = guiCreateStaticImage(0, 0, 270, 30, ":GTIdroid/phone/search_bar.png", false, GUIEditor.staticimage[1])
    guiSetVisible(GUIEditor.staticimage[1], false)
    GUIEditor.gridlist[1] = guiCreateGridList(10, 40, 250, 351, false, GUIEditor.staticimage[1])
    guiGridListAddColumn(GUIEditor.gridlist[1], "Note", 0.9)
    GUIEditor.button[1] = guiCreateButton(9, 394, 79, 30, "Add", false, GUIEditor.staticimage[1])
    font_0 = guiCreateFont(":GTIdroid/fonts/Roboto-Bold.ttf")
    guiSetFont(GUIEditor.button[1], font_0)
    guiSetProperty(GUIEditor.button[1], "NormalTextColour", "FF878200")
    GUIEditor.button[2] = guiCreateButton(95, 394, 79, 30, "Remove", false, GUIEditor.staticimage[1])
    guiSetFont(GUIEditor.button[2], font_0)
    guiSetProperty(GUIEditor.button[2], "NormalTextColour", "FF878200")
    GUIEditor.button[3] = guiCreateButton(181, 394, 79, 30, "View/Edit", false, GUIEditor.staticimage[1])
    guiSetFont(GUIEditor.button[3], font_0)
    guiSetProperty(GUIEditor.button[3], "NormalTextColour", "FF878200") 
    
    GUIEditor.window[1] = guiCreateWindow(343, 134, 265, 394, "B > Notes > Add", false)
    guiWindowSetSizable(GUIEditor.window[1], false)
    guiSetVisible(GUIEditor.window[1], false)
    GUIEditor.memo[1] = guiCreateMemo(10, 61, 245, 296, "", false, GUIEditor.window[1])
    GUIEditor.button[4] = guiCreateButton(9, 367, 115, 17, "Add", false, GUIEditor.window[1])
    guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FFAAAAAA")
    GUIEditor.button[5] = guiCreateButton(140, 367, 115, 17, "Cancel", false, GUIEditor.window[1])
    guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFAAAAAA")
        GUIEditor.edit[1] = guiCreateEdit(66, 23, 189, 28, "", false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(7, 24, 59, 27, "Title:", false, GUIEditor.window[1])
        local font_0 = guiCreateFont(":GTIdroid/fonts/Roboto-Bold.ttf")
        guiSetFont(GUIEditor.label[1], font_0)
        guiLabelSetColor(GUIEditor.label[1], 135, 130, 0)
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")  
 
    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(GUIEditor.window[1], false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    guiSetPosition(GUIEditor.window[1], x, y, false)   
    
    local file   = xmlLoadFile("@Notes.xml") or xmlCreateFile("@Notes.xml","Notes")
    local mChild = xmlNodeGetChildren ( file )
            if mChild then
                for i,v in ipairs ( mChild ) do
                    local xName = xmlNodeGetAttribute(v, "Name")
                    local xNote = xmlNodeGetValue(v)
                    local row   = guiGridListAddRow( GUIEditor.gridlist[1] )
                    guiGridListSetItemText( GUIEditor.gridlist[1], row, 1, xName, false, false)
                    guiGridListSetItemData ( GUIEditor.gridlist[1], row, 1, xNote)
                    end
                end
            xmlSaveFile (file)
            xmlUnloadFile (file)
        
end
addEventHandler("onClientResourceStart", resourceRoot, renderAppGUI)
addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, renderAppGUI)
 
-- Show/Hide
------------->>
function showAppGUI()
    guiSetVisible(GUIEditor.staticimage[1], true)
    exports.GTIdroid:showMainMenu(false)
    exports.GTIdroid:playTick()
end
 
function hideAppGUI()
    guiSetVisible(GUIEditor.staticimage[1], false)
    guiSetVisible(GUIEditor.window[1], false)
    exports.GTIdroid:showMainMenu(true)
end
function avoidBugs() --> "Nerox"
    if guiGetVisible(GUIEditor.staticimage[1]) then
	hideAppGUI()
	end
end
addEvent("onGTIDroidClickBack", true)
addEventHandler("onGTIDroidClickBack", root, avoidBugs)
addEvent("onGTIDroidClose", true)
addEventHandler("onGTIDroidClose", root, hideAppGUI)
addEventHandler("onClientResourceStop", resourceRoot, hideAppGUI)

-- Add/Remove/View/Edit
------------->>

addEventHandler("onClientGUIClick", root,
function()
    if ( source == GUIEditor.button[1] ) then -- Add
        exports.GTIdroid:playTick()
        guiSetVisible( GUIEditor.window[1], true)
        guiSetText( GUIEditor.button[4], "Add" ) 
        guiEditSetReadOnly( GUIEditor.edit[1], false )
        
    elseif ( source == GUIEditor.button[2] ) then -- Remove
        exports.GTIdroid:playTick()
        local file      = xmlLoadFile("@Notes.xml")
        local rRow      = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
        if not (rRow ~= -1) then return end
        local musicName = guiGridListGetItemText( GUIEditor.gridlist[1], rRow, 1 )
        local mChild    = xmlFindChild ( file, "Note", 0 )
        local xName     = xmlNodeGetAttribute(mChild, "Name")
                guiGridListRemoveRow( GUIEditor.gridlist[1], rRow )
                xmlDestroyNode(mChild)
                xmlSaveFile(file)
                xmlUnloadFile(file)
        
    elseif ( source == GUIEditor.button[3] ) then -- View/Edit
        exports.GTIdroid:playTick()
        local selected = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
        if not ( selected ~= -1 ) then return end
        guiEditSetReadOnly( GUIEditor.edit[1], true )
        guiSetText( GUIEditor.button[4], "Save" ) 
        local noteName = guiGridListGetItemText( GUIEditor.gridlist[1], selected, 1 )
        guiSetText( GUIEditor.edit[1], noteName )
                data = guiGridListGetItemData(GUIEditor.gridlist[1], selected, 1)
                guiSetText( GUIEditor.memo[1], data )   
                guiSetVisible( GUIEditor.window[1], true)
        
    elseif ( source == GUIEditor.button[4] ) then -- Save
        exports.GTIdroid:playTick()
        local note   = guiGetText( GUIEditor.memo[1] )
        local title  = guiGetText( GUIEditor.edit[1] )
        if ( note == "" ) then return end
        if ( title == "" ) then return end
            if guiGetText ( GUIEditor.button[4] ) == "Add" then
                local Row = guiGridListAddRow( GUIEditor.gridlist[1] )
                guiGridListSetItemText ( GUIEditor.gridlist[1], Row, 1, title, false, false)
                guiGridListSetItemData ( GUIEditor.gridlist[1], Row, 1, note)
                guiSetText( GUIEditor.memo[1], "" )
                guiSetText( GUIEditor.edit[1], "" )
                guiSetVisible( GUIEditor.window[1], false )
                local file   = xmlLoadFile("@Notes.xml")
                local fChild = xmlCreateChild(file, "Note")
                xmlNodeSetAttribute(fChild, "Name", title)
                xmlNodeSetValue(fChild, note)
                    xmlSaveFile(file)
                    xmlUnloadFile(file)
            else
                local selected = guiGridListGetSelectedItem( GUIEditor.gridlist[1] )
                if not ( selected ~= -1 ) then return end
                local which = guiGridListGetItemText ( GUIEditor.gridlist[1], selected, 1 )
                guiSetText( GUIEditor.window[1], "View/Edit "..which )
                guiGridListSetItemText ( GUIEditor.gridlist[1], selected, 1, title, false, false)
                guiGridListSetItemData ( GUIEditor.gridlist[1], selected, 1, note)
                guiSetText( GUIEditor.memo[1], "" )
                guiSetText( GUIEditor.edit[1], "" )
                guiSetVisible( GUIEditor.window[1], false )
                updateNote (title, note)
            end
        
    elseif ( source == GUIEditor.button[5] ) then -- Cancel
        exports.GTIdroid:playTick()
        guiSetVisible(GUIEditor.window[1], false)
        guiSetText( GUIEditor.memo[1], "" )
        guiSetText( GUIEditor.edit[1], "" )
    end
end
)

function updateNote (title, note)
local file = xmlLoadFile("@Notes.xml")
local index, node = 0, false
local child = xmlNodeGetChildren(file)

    for i,v in ipairs(child) do
        local aName = xmlNodeGetAttribute(v, "Name")
        if ( aName == title ) then
            xmlNodeSetValue(v, note)
            xmlSaveFile(file)
            xmlUnloadFile(file)
        end
    end
end

--[[function saveNote(title, note)
    local rootnode = xmlLoadFile("@Notes.xml")
    local index, node = 0, false
    repeat
        node = xmlFindChild(rootnode, "Note", index)
        if (node) then
            local name = xmlNodeGetAttribute(node, "Name")
            if (name and name == title) then
                xmlNodeSetValue(node, note)
                xmlSaveFile(rootnode)
                xmlUnloadFile(rootnode)
                break
            end
            index = index + 1
        end
    until (node)
    xmlUnloadFile(rootnode)
    end]]