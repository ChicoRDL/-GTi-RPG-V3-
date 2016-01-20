----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 30 Dec 2015
-- Resource: GTIdonations/donations.lua
-- Type: Client Side
-- Author: Ares
----------------------------------------->>

local MONTHLY_NEEDED = 30 -- euro
local EURO_SYMBOL = "€"
local MONTH_IN_SECONDS = 2592000
local today, tomonth, toyear = exports.GTIutil:todate(getRealTime().timestamp)
local isNextMonthPaid = ( today >= 27 ) and true

function togglePanel()
    if (not guiGetVisible(donationsGUI.window[1])) then
        triggerServerEvent("GTIdonations.callPanelInfo", localPlayer)
    else
        guiSetVisible(donationsGUI.window[1], false)
        showCursor(false)
    end
end
addCommandHandler("donations", togglePanel)

function showPanel(infoTable)
	if ( type(infoTable) == "table" ) then
		local server_balance = infoTable["server_balance"] or 0
		local logs = infoTable["logs"] or ""
		local donations = infoTable["donors"] or {}
		
		guiSetText(donationsGUI.label[11], EURO_SYMBOL.." "..convertNumber(server_balance))
		guiSetText(donationsGUI.memo[1], logs)
		
		local cache = {}
		for name, data in pairs(donations) do
			cache[data[1]] = {name, data[2]}
		end
		
		--table.sort(cache)
		
		local index = 1
		guiGridListClear(donationsGUI.gridlist[1])
		for total, data in ipairs(cache) do
			local row = guiGridListAddRow(donationsGUI.gridlist[1])
			guiGridListSetItemText(donationsGUI.gridlist[1], row, 1, index, false, false)
			guiGridListSetItemText(donationsGUI.gridlist[1], row, 2, data[1], false, false)
			guiGridListSetItemText(donationsGUI.gridlist[1], row, 3, EURO_SYMBOL.. " "..convertNumber(total), false, false)
			guiGridListSetItemText(donationsGUI.gridlist[1], row, 4, EURO_SYMBOL.. " "..convertNumber(data[2]), false, false)
			index = index + 1
		end
		
		local NEW_NEEDED
		local NEW_MONTHS
		if ( server_balance > MONTHLY_NEEDED )then
			NEW_MONTHS = server_balance/MONTHLY_NEEDED
			NEW_MONTHS = math.ceil(NEW_MONTHS) ~= math.floor(NEW_MONTHS) and NEW_MONTHS - math.floor(NEW_MONTHS) or NEW_MONTHS
			NEW_NEEDED = MONTHLY_NEEDED - (NEW_MONTHS * MONTHLY_NEEDED)
		end
		
		local new_months = server_balance/MONTHLY_NEEDED
		local day, month, year = exports.GTIutil:todate(getRealTime().timestamp + ( ( new_months or 1) * MONTH_IN_SECONDS ) )
		local coveredUntil = new_months > 1 and ( string.format("%s/%s/%s", "27", month, year) .. " (+"..math.floor(new_months).." months)" ) or "27/"..tomonth.."/"..toyear
		guiSetText(donationsGUI.label[13], coveredUntil)
		
		
		local neededForNextMonth =  isNextMonthPaid and server_balance - (math.ceil(new_months) * MONTHLY_NEEDED) or server_balance - ( MONTHLY_NEEDED * 2 )
		guiSetText(donationsGUI.label[12], EURO_SYMBOL.. " ".. ( tonumber(neededForNextMonth) < 0 and convertNumber(tonumber(neededForNextMonth) * -1) or convertNumber(neededForNextMonth) ))
		pInfo = {}
		
		pInfo[1] = server_balance
		--pInfo[2] = server_balance / (NEW_NEEDED or MONTHLY_NEEDED)
		pInfo[2] = NEW_MONTHS or (server_balance/MONTHLY_NEEDED)
		outputChatBox(pInfo[2])
		pInfo[3] = EURO_SYMBOL.." "..convertNumber(MONTHLY_NEEDED)
		pInfo[4] = EURO_SYMBOL.." "..convertNumber(server_balance)
		
		if ( server_balance > MONTHLY_NEEDED ) then
			red, green, blue = 0, 200, 0
		else
			red, green, blue = 200, 0, 0
		end
		
		guiSetVisible(donationsGUI.window[1], true)
		showCursor(true)
	end
end
addEvent("GTIdonations.showPanel", true)
addEventHandler("GTIdonations.showPanel", root, showPanel)
function renderDisplays()
    if (not guiGetVisible(donationsGUI.window[1])) then return end
    
	if (guiGetSelectedTab(donationsGUI.tabpanel[1]) == donationsGUI.tab[1] and pInfo) then
        -- Level
        local wX,wY = guiGetPosition(donationsGUI.window[1], false)
        --dxDrawText(pInfo[1], wX+96, wY+46, wX+96, wY+46, tocolor(red,green,blue,255), 2, "bankgothic", "left", "top", false, false, true)
        -- Experience
        local exper = EURO_SYMBOL.. " ".. convertNumber(pInfo[1])
        dxDrawText(exper, wX+280, wY+52, wX+280, wY+52, tocolor(red,green,blue,255), 3.25, "clear", "left", "top", false, false, true)
		-- dxDrawLine(wX+247,wY+158,wX+247,wY+385,tocolor(255,255,255,255),1,true)
        -- Progress Bar
        local dX,dY,dW,dH = wX+20,wY+115,525,30
        dxDrawRectangle(dX, dY, dW, dH, tocolor(0,0,0,200), true)
        local dX,dY,dW,dH = wX+25,wY+120,515,20
        dxDrawRectangle(dX, dY, dW, dH, tocolor(red*(1/3),green*(1/3),blue*(1/3),200), true)
        dxDrawRectangle(dX, dY, pInfo[2]*dW, dH, tocolor(red,green,blue,255), true)
        
        local dX,dY,dW,dH = wX+283,wY+130,wX+283,wY+130
        local textDisplay = pInfo[4].." / "..pInfo[3]
        dxDrawText(textDisplay, dX+1, dY, dW+1, dH, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
        dxDrawText(textDisplay, dX, dY+1, dW, dH+1, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
        dxDrawText(textDisplay, dX-1, dY, dW-1, dH, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
        dxDrawText(textDisplay, dX, dY-1, dW, dH-1, tocolor(0,0,0,255), 1, "default", "center", "center", false, false, true)
        dxDrawText(textDisplay, dX, dY, dW, dH, tocolor(255,255,255,255), 1, "default", "center", "center", false, false, true)
    end
end
addEventHandler("onClientRender", root, renderDisplays)


function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end
	if ( not tostring(formatted):find("%p") ) then
		formatted = tostring(formatted)..".00"
	elseif ( tostring(formatted):find("%p") ) then
		local _, am = tostring(formatted):gsub("%p", "")
		formatted = tostring(formatted)..(string.rep("0", (2-am)))
	end
	return formatted
end
