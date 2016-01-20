----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 19 Dec 2013
-- Resource: GTIemployment/panel.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local RADIOBUTTON_FREEZE = 1000     -- Time between updating payment method
local DESC_WIDTH = 33               -- Width of Job Description (Letters)

local pInfo = {}            -- Progress Info (For Progress Bar)
local red, green, blue = 255, 200, 0    -- Panel Color Sheme

-- Display Panel
----------------->>

function togglePanel()
    if (not guiGetVisible(progressGUI.window[1])) then
        triggerServerEvent("GTIemployment.callPanelInfo", localPlayer)
    else
        guiSetVisible(progressGUI.window[1], false)
        showCursor(false)
    end
end
bindKey("F5", "up", togglePanel)

function showPanel(ranks, color, divisions)
    red, green, blue = color[1], color[2], color[3]
        
        -- Current Job
    guiSetText(progressGUI.label[2], ranks["job"])
    guiSetText(progressGUI.label[7], "Level "..ranks["level"])
    guiSetText(progressGUI.label[9], ranks["rank"])
    ranks["prog"] = math.floor(ranks["prog"]) == ranks["prog"] and ranks["prog"] or tonumber(string.format("%.3f", ranks["prog"]))
    guiSetText(progressGUI.label[13], exports.GTIutil:tocomma(ranks["prog"]).." "..ranks["unit"])
    guiSetText(progressGUI.label[12], exports.GTIutil:tocomma(ranks["req"]).." "..ranks["unit"])
    guiSetText(progressGUI.label[52], exports.GTIutil:tocomma(tonumber(string.format("%.3f", (ranks["hours"]/3600)))).." hours")
    guiSetText(progressGUI.label[17], exports.GTIutil:tocomma(ranks["jobexp"]).." Exp. Points")
    guiSetText(progressGUI.label[18], "$"..exports.GTIutil:tocomma(ranks["money"]))
    
        -- Job Description
    local desc = ranks["desc"]
    
    local div_text
    if (divisions) then
        div_text = "\n\n— Job Divisions"
        for i,division in ipairs(divisions) do
            div_text = div_text.."\nLevel "..division[2]..": "..division[1]
        end
    end
    desc = desc..(div_text or "")
        
    desc = desc.."\n\n— Job Ranks:\nLevel 0: "..ranks["ranks"][0].name
    for lvl,tbl in ipairs(ranks["ranks"]) do
        desc = desc.."\nLevel "..lvl..": "..tbl.name
    end
            
        -- Job Description Scroll Length
    local len = math.ceil( #string.gsub(desc, "\n", "")/DESC_WIDTH )
    local pos = 0
    while true do
        local sPos = string.find(desc,"\n",pos)
        if (not sPos) then break end
        pos,len = sPos+1, len+1
    end
    local sx = guiGetSize(progressGUI.label[38], false)
    guiSetSize(progressGUI.label[38], sx, len*15, false)
    guiSetText(progressGUI.label[38], desc)
        
        -- Duty State
    if (not ranks["duty"] or ranks["duty"] == 0) then
        guiSetText(progressGUI.button[1], "Start Shift")
    else
        guiSetText(progressGUI.button[1], "End Shift")
    end
    
    -- All Jobs
    pInfo[1] = ranks["civlvl"]
    pInfo[2] = ranks["civexp"]
    pInfo[3] = (ranks["civexp"]-ranks["lvlxpcur"])/(ranks["lvlxpnxt"]-ranks["lvlxpcur"])
    pInfo[4] = exports.GTIutil:tocomma(ranks["lvlxpnxt"])
    pInfo[5] = exports.GTIutil:tocomma(ranks["civexp"])
    guiGridListClear(progressGUI.gridlist[1])
    for i,job in ipairs(ranks["jobList"]) do
        local row = guiGridListAddRow(progressGUI.gridlist[1])
        guiGridListSetItemText(progressGUI.gridlist[1], row, 1, job, false, false)
        if (job == ranks["job"]) then
            guiGridListSetSelectedItem(progressGUI.gridlist[1], row, 1)
        end
    end
    guiSetText(progressGUI.label[29], "Level "..ranks["level"])
    guiSetText(progressGUI.label[34], ranks["rank"])
    guiSetText(progressGUI.label[36], exports.GTIutil:tocomma(ranks["prog"]).." "..ranks["unit"])
    guiSetText(progressGUI.label[35], exports.GTIutil:tocomma(ranks["req"]).." "..ranks["unit"])
    guiSetText(progressGUI.label[50], "$"..exports.GTIutil:tocomma(ranks["balance"]))
	guiSetText(progressGUI.label[55], exports.GTIutil:tocomma(ranks["expbalance"]).. " Exp. Points")
    guiSetText(progressGUI.memo[1], desc)
        -- Update Color Scheme
    for _,i in ipairs({1, 3, 7, 8, 10, 11, 15, 16, 20, 29, 31, 32, 33, 37, 51}) do
        guiLabelSetColor(progressGUI.label[i], red, green, blue)
    end
        
    guiSetVisible(progressGUI.window[1], true)
    showCursor(true)
end
addEvent("GTIemployment.showPanel", true)
addEventHandler("GTIemployment.showPanel", root, showPanel)

-- Render Functions
-------------------->>

function renderDisplays()
    if (not guiGetVisible(progressGUI.window[1])) then return end
    
    if (guiGetSelectedTab(progressGUI.tabpanel[1]) == progressGUI.tab[1]) then
        local wX,wY = guiGetPosition(progressGUI.window[1], false)
        dxDrawLine(wX+315,wY+58,wX+315,wY+385,tocolor(255,255,255,255),1,true)
    elseif (guiGetSelectedTab(progressGUI.tabpanel[1]) == progressGUI.tab[2]) then
        -- Level
        local wX,wY = guiGetPosition(progressGUI.window[1], false)
        dxDrawText(pInfo[1], wX+96, wY+46, wX+96, wY+46, tocolor(red,green,blue,255), 2, "bankgothic", "left", "top", false, false, true)
        -- Experience
        local exper = exports.GTIutil:tocomma(pInfo[2])
        dxDrawText(exper, wX+280, wY+52, wX+280, wY+52, tocolor(red,green,blue,255), 3.25, "clear", "left", "top", false, false, true)
        dxDrawLine(wX+247,wY+158,wX+247,wY+385,tocolor(255,255,255,255),1,true)
        -- Progress Bar
        local dX,dY,dW,dH = wX+20,wY+115,525,30
        dxDrawRectangle(dX, dY, dW, dH, tocolor(0,0,0,200), true)
        local dX,dY,dW,dH = wX+25,wY+120,515,20
        dxDrawRectangle(dX, dY, dW, dH, tocolor(red*(1/3),green*(1/3),blue*(1/3),200), true)
        dxDrawRectangle(dX, dY, pInfo[3]*dW, dH, tocolor(red,green,blue,255), true)
        
        local dX,dY,dW,dH = wX+283,wY+130,wX+283,wY+130
        local textDisplay = pInfo[5].."/"..pInfo[4]
        dxDrawText(textDisplay, dX+1, dY, dW+1, dH, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
        dxDrawText(textDisplay, dX, dY+1, dW, dH+1, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
        dxDrawText(textDisplay, dX-1, dY, dW-1, dH, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
        dxDrawText(textDisplay, dX, dY-1, dW, dH-1, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
        dxDrawText(textDisplay, dX, dY, dW, dH, tocolor(255,255,255,255), 1, "default", "center", "center", false, false, true)
    end
end
addEventHandler("onClientRender", root, renderDisplays)

-- Toggle Shift and Resign
--------------------------->>

function toggleShiftAndResign(button, state)
    if (button ~= "left" or state ~= "up") then return end
    if (source == progressGUI.button[1]) then
        triggerServerEvent("GTIemployment.togglePlayerShift", resourceRoot)
    elseif (source == progressGUI.button[2]) then
        triggerServerEvent("GTIemployment.resign", resourceRoot)
    end
end
addEventHandler("onClientGUIClick", progressGUI.button[1], toggleShiftAndResign, false)
addEventHandler("onClientGUIClick", progressGUI.button[2], toggleShiftAndResign, false)

function modShiftText(text)
    guiSetText(progressGUI.button[1], text)
    guiSetVisible(progressGUI.window[1], false)
    showCursor(false)
end
addEvent("GTIemployment.modShiftText", true)
addEventHandler("GTIemployment.modShiftText", root, modShiftText)

-- View All Job Information
---------------------------->>

function callAllJobInfo(button)
    if (button ~= "left") then return end
    local row = guiGridListGetSelectedItem(progressGUI.gridlist[1])
    if (not row or row == -1) then return end
    local job_name = guiGridListGetItemText(progressGUI.gridlist[1], row, 1)
    triggerServerEvent("GTIemployment.callAllJobInfo", resourceRoot, job_name)
end
addEventHandler("onClientGUIClick", progressGUI.gridlist[1], callAllJobInfo, false)

function returnAllJobInfo(ranks)
    guiSetText(progressGUI.label[29], "Level "..ranks["level"])
    guiSetText(progressGUI.label[34], ranks["rank"])
    ranks["prog"] = math.floor(ranks["prog"]) == ranks["prog"] and ranks["prog"] or tonumber(string.format("%.3f", ranks["prog"]))
    guiSetText(progressGUI.label[36], exports.GTIutil:tocomma(ranks["prog"]).." "..ranks["unit"])
    guiSetText(progressGUI.label[35], exports.GTIutil:tocomma(ranks["req"]).." "..ranks["unit"])
    
    local desc = ranks["desc"].."\n\n-- Job Ranks:"
    desc = desc.."\nLevel 0: "..ranks["ranks"][0].name
    for lvl,tbl in ipairs(ranks["ranks"]) do
        desc = desc.."\nLevel "..lvl..": "..tbl.name
    end
    guiSetText(progressGUI.memo[1], desc)
end
addEvent("GTIemployment.returnAllJobInfo", true)
addEventHandler("GTIemployment.returnAllJobInfo", root, returnAllJobInfo)

-- Close Panel
--------------->>

function closeProgressPanel()
    guiSetVisible(progressGUI.window[1], false)
    showCursor(false)
end
addEvent("GTIemployment.closeProgressPanel", true)
addEventHandler("GTIemployment.closeProgressPanel", root, closeProgressPanel)

addEvent("onClientPlayerJobQuit", true)
addEventHandler("onClientPlayerQuitJob", root, function(job, shift)
    if (shift) then
        closeProgressPanel()
    end
end)
