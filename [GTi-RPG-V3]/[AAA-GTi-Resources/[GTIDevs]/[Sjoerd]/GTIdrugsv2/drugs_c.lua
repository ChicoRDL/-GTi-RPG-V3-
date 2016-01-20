
drugs = {
    gridlist = {},
    scrollpane = {},
    window = {},
    wimg = {},
    label = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
    local screenW, screenH = guiGetScreenSize()
    windowImage = guiCreateStaticImage(90, (screenH - 315) / 2, 289, 315, "images/window.png", false)
    guiSetVisible(windowImage, false)

    drugGridlist = guiCreateGridList(22, 19, 244, 111, false, windowImage)
    guiGridListAddColumn(drugGridlist, "Name", 0.7)
    guiGridListAddColumn(drugGridlist, "Qty", 0.15)
    guiSetAlpha(drugGridlist, 0.75)
    guiGridListSetSortingEnabled(drugGridlist, false)
    --drugs.wimg[2] = guiCreateStaticImage(224, 140, 42, 42, "images/LSD.png", false, windowImage)
    drugScrollpane = guiCreateScrollPane(22, 140, 192, 118, false, windowImage)

    drugLabelName = guiCreateLabel(4, 3, 184, 111, "Name: \n\nInformation: \n\nObtainable Via:", false, drugScrollpane)
    guiLabelSetHorizontalAlign(drugLabelName, "left", true)

    drugLabelTake = guiCreateLabel(214, 192, 52, 16, "Take Drug", false, windowImage)
    guiSetFont(drugLabelTake, "default-small")
    guiLabelSetHorizontalAlign(drugLabelTake, "center", false)
    guiLabelSetVerticalAlign(drugLabelTake, "center")

    drugLabelDrop = guiCreateLabel(214, 214, 52, 16, "Drop Drug", false, windowImage)
    guiSetFont(drugLabelDrop, "default-small")
    guiLabelSetHorizontalAlign(drugLabelDrop, "center", false)
    guiLabelSetVerticalAlign(drugLabelDrop, "center")

    drugLabelSell = guiCreateLabel(214, 236, 52, 16, "Sell Drug", false, windowImage)
    guiSetFont(drugLabelSell, "default-small")
    guiLabelSetHorizontalAlign(drugLabelSell, "center", false)
    guiLabelSetVerticalAlign(drugLabelSell, "center")

    drugLabelClose = guiCreateLabel(22, 280, 52, 16, "Close", false, windowImage)
    guiSetFont(drugLabelClose, "default-small")
    guiLabelSetHorizontalAlign(drugLabelClose, "center", false)
    guiLabelSetVerticalAlign(drugLabelClose, "center")
end
)
--[[
addEventHandler( "onClientResourceStart", resourceRoot,
    function()
        for i,v in ipairs ( drugs) do
            if v.name ~= "" then
                local dRow = guiGridListAddRow(drugGridlist)
                guiGridListSetItemText(drugGridlist, dRow, 1, v.name, false, false)
                guiGridListSetItemData(drugGridlist, dRow, 1, v.data[2]..";"..v.data[3]..";"..v.data[4])
            end
        end
    end
)
--]]


bindKey('f3','down',
function()
    triggerServerEvent( "drugs.QueryAccount", localPlayer, guiGetVisible(windowImage))
    guiGridListClear( drugGridlist)
end
)

function placeDrugs( drugName, drugData)
    --guiGridListClear( drugGridlist)
    --[[
    if type( drugTable) == "table" then
        for i, data in ipairs (drugTable) do
            local acid = data[1] or 0
            local adderal = data[2] or 0
            local coke = data[3] or 0
            local ecstasy = data[4] or 0
            local lsd = data[5] or 0
            local cm = data[6] or 0
            local pcp = data[7] or 0
            local weed = data[8] or 0
        end
    end
    --]]
    local dRow = guiGridListAddRow(drugGridlist)
    for i, v in ipairs (drugs) do
        if string.match( v.name, drugName) then
            guiGridListSetItemText(drugGridlist, dRow, 1, drugName, false, false)
            guiGridListSetItemText(drugGridlist, dRow, 2, drugData, false, false)
            guiGridListSetItemData(drugGridlist, dRow, 1, v.data[2]..";"..v.data[3]..";"..v.data[4]..";"..drugData)
        end
    end
end
addEvent( "drugs.getDrugs", true)
addEventHandler( "drugs.getDrugs", localPlayer, placeDrugs)

function refreshClient()
    guiGridListClear(drugGridlist)
end
addEvent( "drugs.refreshClient", true)
addEventHandler( "drugs.refreshClient", localPlayer, refreshClient)

function showGUI()
    if guiGetVisible( windowImage) then
        guiSetVisible(windowImage, false)
        showCursor( false)
    else
        guiSetVisible(windowImage, true)
        showCursor( true)
        --triggerServerEvent( "loadDrugs", localPlayer)
    end
end
addEvent( "drugs.viewGUI", true)
addEventHandler( "drugs.viewGUI", localPlayer, showGUI)

addEventHandler( "onClientMouseEnter", root,
    function()
        if source == drugLabelTake then
            guiLabelSetColor( source, 184, 0, 0)
        elseif source == drugLabelDrop then
            guiLabelSetColor( source, 0, 184, 184)
        elseif source == drugLabelSell then
            guiLabelSetColor( source, 0, 184, 0)
        elseif source == drugLabelClose then
            guiLabelSetColor( source, 112, 112, 112)
        end
    end
)

addEventHandler( "onClientMouseLeave", root,
    function()
        if source == drugLabelTake then
            guiLabelSetColor( source, 255, 255, 255)
        elseif source == drugLabelDrop then
            guiLabelSetColor( source, 255, 255, 255)
        elseif source == drugLabelSell then
            guiLabelSetColor( source, 255, 255, 255)
        elseif source == drugLabelClose then
            guiLabelSetColor( source, 255, 255, 255)
        end
    end
)

addEventHandler( "onClientGUIClick", root,
    function()
        if source == drugGridlist then
            local Drow, Dcol = guiGridListGetSelectedItem(drugGridlist)
            local gName = guiGridListGetItemText(drugGridlist, Drow, Dcol)
            local gIMG = guiGridListGetItemData(drugGridlist, Drow, Dcol)
            local sX, sY = guiGetSize( drugLabelName, false)
            if Drow then
                if gName and gIMG then
                    local data = split(gIMG, string.byte( ";"))
                    local image, desc, ogb = data[1], data[2], data[3]
                    --
                    if sY ~= 151 then
                        guiSetSize( drugLabelName, sX, 151, false)
                    end
                    guiSetText( drugLabelName, "Name: "..gName.."\n\nInformation: "..desc.."\n\nObtainable Via: \n  "..ogb)
                    --
                    if drugImage then
                        if guiGetVisible( drugImage) == false then
                            guiSetVisible( drugImage, true)
                        end
                        guiStaticImageLoadImage(drugImage, "images/"..image..".png")
                    else
                        drugImage = guiCreateStaticImage(224, 140, 42, 42, "images/"..image..".png", false, windowImage)
                    end
                else
                    if drugImage then
                        if guiGetVisible( drugImage) == true then
                            guiSetVisible( drugImage, false)
                        end
                    end
                    guiSetText( drugLabelName, "Name: \n\nInformation: \n\nObtainable Via:")
                    guiSetSize( drugLabelName, sX, 111, false)
                end
            end
        elseif source == drugLabelTake then
            local Drow, Dcol = guiGridListGetSelectedItem(drugGridlist)
            local gName = guiGridListGetItemText(drugGridlist, Drow, Dcol)
            local gIMG = guiGridListGetItemData(drugGridlist, Drow, Dcol)
            if Drow then
                if gName and gIMG then
                    local data = split(gIMG, string.byte( ";"))
                    local _, _, _, amount = data[1], data[2], data[3], data[4]
                    local amount = tonumber(amount)
                    if amount ~= 0 and amount > 0 then
                        guiGridListClear( drugGridlist)
                        outputChatBox( "You have consume "..gName..".", 255, 255, 25)
                        triggerServerEvent( "drugs.executeDrugEvent", localPlayer, "consumeDrug", gName, 1)
                        startDrugEffect(localPlayer, gName)
                    else
                        outputChatBox( "You do not have any "..gName.." left to consume.", 255, 25, 25)
                    end
                end
            end
        elseif source == drugLabelClose then
            guiSetVisible(windowImage, false)
            showCursor( false)
        end
    end
)
