GTIdrugs = {
    gridlist = {},
    scrollpane = {},
    window = {},
    wimg = {},
    label = {}
}
local screenW, screenH = guiGetScreenSize()
GTIdrugs.window[1] = guiCreateStaticImage(90, (screenH - 315) / 2, 289, 315, "images/window.png", false)
guiSetVisible(GTIdrugs.window[1], false)

GTIdrugs.gridlist[1] = guiCreateGridList(22, 19, 244, 111, false, GTIdrugs.window[1])
guiGridListAddColumn(GTIdrugs.gridlist[1], "Name", 0.7)
guiGridListAddColumn(GTIdrugs.gridlist[1], "Qty", 0.15)
guiSetAlpha(GTIdrugs.gridlist[1], 0.75)
guiGridListSetSortingEnabled(GTIdrugs.gridlist[1], false)
--GTIdrugs.wimg[2] = guiCreateStaticImage(224, 140, 42, 42, "images/LSD.png", false, GTIdrugs.window[1])
GTIdrugs.scrollpane[1] = guiCreateScrollPane(22, 140, 192, 118, false, GTIdrugs.window[1])

GTIdrugs.label[1] = guiCreateLabel(4, 3, 184, 111, "Name: \n\nInformation: \n\nObtainable Via:", false, GTIdrugs.scrollpane[1])
guiLabelSetHorizontalAlign(GTIdrugs.label[1], "left", true)

GTIdrugs.label[2] = guiCreateLabel(214, 192, 52, 16, "Take Drug", false, GTIdrugs.window[1])
guiSetFont(GTIdrugs.label[2], "default-small")
guiLabelSetHorizontalAlign(GTIdrugs.label[2], "center", false)
guiLabelSetVerticalAlign(GTIdrugs.label[2], "center")

GTIdrugs.label[3] = guiCreateLabel(214, 214, 52, 16, "Drop Drug", false, GTIdrugs.window[1])
guiSetFont(GTIdrugs.label[3], "default-small")
guiLabelSetHorizontalAlign(GTIdrugs.label[3], "center", false)
guiLabelSetVerticalAlign(GTIdrugs.label[3], "center")

GTIdrugs.label[4] = guiCreateLabel(214, 236, 52, 16, "Sell Drug", false, GTIdrugs.window[1])
guiSetFont(GTIdrugs.label[4], "default-small")
guiLabelSetHorizontalAlign(GTIdrugs.label[4], "center", false)
guiLabelSetVerticalAlign(GTIdrugs.label[4], "center")

GTIdrugs.label[5] = guiCreateLabel(22, 280, 52, 16, "Close", false, GTIdrugs.window[1])
guiSetFont(GTIdrugs.label[5], "default-small")
guiLabelSetHorizontalAlign(GTIdrugs.label[5], "center", false)
guiLabelSetVerticalAlign(GTIdrugs.label[5], "center")

--[[
addEventHandler( "onClientResourceStart", resourceRoot,
    function()
        for i,v in ipairs ( drugs) do
            if v.name ~= "" then
                local dRow = guiGridListAddRow(GTIdrugs.gridlist[1])
                guiGridListSetItemText(GTIdrugs.gridlist[1], dRow, 1, v.name, false, false)
                guiGridListSetItemData(GTIdrugs.gridlist[1], dRow, 1, v.data[2]..";"..v.data[3]..";"..v.data[4])
            end
        end
    end
)
--]]

bindKey('f3','down',
function()
    triggerServerEvent( "GTIdrugs.QueryAccount", localPlayer, guiGetVisible(GTIdrugs.window[1]))
    guiGridListClear( GTIdrugs.gridlist[1])
end
)

function placeDrugs( drugName, drugData)
    --guiGridListClear( GTIdrugs.gridlist[1])
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
    local dRow = guiGridListAddRow(GTIdrugs.gridlist[1])
    for i, v in ipairs (drugs) do
        if string.match( v.name, drugName) then
            guiGridListSetItemText(GTIdrugs.gridlist[1], dRow, 1, drugName, false, false)
            guiGridListSetItemText(GTIdrugs.gridlist[1], dRow, 2, drugData, false, false)
            guiGridListSetItemData(GTIdrugs.gridlist[1], dRow, 1, v.data[2]..";"..v.data[3]..";"..v.data[4]..";"..drugData)
        end
    end
end
addEvent( "GTIdrugs.getDrugs", true)
addEventHandler( "GTIdrugs.getDrugs", localPlayer, placeDrugs)

function refreshClient()
    guiGridListClear(GTIdrugs.gridlist[1])
end
addEvent( "GTIdrugs.refreshClient", true)
addEventHandler( "GTIdrugs.refreshClient", localPlayer, refreshClient)

function showGUI()
    if guiGetVisible( GTIdrugs.window[1]) then
        guiSetVisible(GTIdrugs.window[1], false)
        showCursor( false)
    else
        guiSetVisible(GTIdrugs.window[1], true)
        showCursor( true)
        --triggerServerEvent( "loadDrugs", localPlayer)
    end
end
addEvent( "GTIdrugs.viewGUI", true)
addEventHandler( "GTIdrugs.viewGUI", localPlayer, showGUI)

addEventHandler( "onClientMouseEnter", root,
    function()
        if source == GTIdrugs.label[2] then
            guiLabelSetColor( source, 184, 0, 0)
        elseif source == GTIdrugs.label[3] then
            guiLabelSetColor( source, 0, 184, 184)
        elseif source == GTIdrugs.label[4] then
            guiLabelSetColor( source, 0, 184, 0)
        elseif source == GTIdrugs.label[5] then
            guiLabelSetColor( source, 112, 112, 112)
        end
    end
)

addEventHandler( "onClientMouseLeave", root,
    function()
        if source == GTIdrugs.label[2] then
            guiLabelSetColor( source, 255, 255, 255)
        elseif source == GTIdrugs.label[3] then
            guiLabelSetColor( source, 255, 255, 255)
        elseif source == GTIdrugs.label[4] then
            guiLabelSetColor( source, 255, 255, 255)
        elseif source == GTIdrugs.label[5] then
            guiLabelSetColor( source, 255, 255, 255)
        end
    end
)

addEventHandler( "onClientGUIClick", root,
    function()
        if source == GTIdrugs.gridlist[1] then
            local Drow, Dcol = guiGridListGetSelectedItem(GTIdrugs.gridlist[1])
            local gName = guiGridListGetItemText(GTIdrugs.gridlist[1], Drow, Dcol)
            local gIMG = guiGridListGetItemData(GTIdrugs.gridlist[1], Drow, Dcol)
            local sX, sY = guiGetSize( GTIdrugs.label[1], false)
            if Drow then
                if gName and gIMG then
                    local data = split(gIMG, string.byte( ";"))
                    local image, desc, ogb = data[1], data[2], data[3]
                    --
                    if sY ~= 151 then
                        guiSetSize( GTIdrugs.label[1], sX, 151, false)
                    end
                    guiSetText( GTIdrugs.label[1], "Name: "..gName.."\n\nInformation: "..desc.."\n\nObtainable Via: \n  "..ogb)
                    --
                    if GTIdrugs.wimg[1] then
                        if guiGetVisible( GTIdrugs.wimg[1]) == false then
                            guiSetVisible( GTIdrugs.wimg[1], true)
                        end
                        guiStaticImageLoadImage(GTIdrugs.wimg[1], "images/"..image..".png")
                    else
                        GTIdrugs.wimg[1] = guiCreateStaticImage(224, 140, 42, 42, "images/"..image..".png", false, GTIdrugs.window[1])
                    end
                else
                    if GTIdrugs.wimg[1] then
                        if guiGetVisible( GTIdrugs.wimg[1]) == true then
                            guiSetVisible( GTIdrugs.wimg[1], false)
                        end
                    end
                    guiSetText( GTIdrugs.label[1], "Name: \n\nInformation: \n\nObtainable Via:")
                    guiSetSize( GTIdrugs.label[1], sX, 111, false)
                end
            end
        elseif source == GTIdrugs.label[2] then
            local Drow, Dcol = guiGridListGetSelectedItem(GTIdrugs.gridlist[1])
            local gName = guiGridListGetItemText(GTIdrugs.gridlist[1], Drow, Dcol)
            local gIMG = guiGridListGetItemData(GTIdrugs.gridlist[1], Drow, Dcol)
            if Drow then
                if gName and gIMG then
                    local data = split(gIMG, string.byte( ";"))
                    local _, _, _, amount = data[1], data[2], data[3], data[4]
                    local amount = tonumber(amount)
                    if amount ~= 0 and amount > 0 then
                        guiGridListClear( GTIdrugs.gridlist[1])
                        exports.GTIhud:dm( "You have consume "..gName..".", 255, 255, 25)
                        triggerServerEvent( "GTIdrugs.executeDrugEvent", localPlayer, "consumeDrug", gName, 1)
                        startDrugEffect(localPlayer, gName)
                    else
                        exports.GTIhud:dm( "You do not have any "..gName.." left to consume.", 255, 25, 25)
                    end
                end
            end
        elseif source == GTIdrugs.label[5] then
            guiSetVisible(GTIdrugs.window[1], false)
            showCursor( false)
        end
    end
)
