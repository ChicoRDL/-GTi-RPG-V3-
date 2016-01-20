function buyUpgrade(item,upid)
	if item then
		if not upid then
		local upid = getUpgradeID(item)
		end
		if upid then
			table.insert(PLAYER_VEHICLE_UPGRADES,upid)
			triggerServerEvent("upgradeVehicle",getLocalPlayer(),upid)
		end
	end
end 

function removeUpgrade(item,upid)
	if item then
		if not upid then
		local upid = getUpgradeID(item)
		end
		if upid then
			removeUpgradeFromSaved(upid)
			triggerServerEvent("unupgradeVehicle",getLocalPlayer(),upid)
		end
	end
end

function buyVehicleFix(item)
	triggerServerEvent("buyVehicleFix",getLocalPlayer(),upid)
end

function buyPaintjob(item,upid)
	if item and upid then
		PLAYER_VEHICLE_PJ = upid
		triggerServerEvent("paintjobVehicle",getLocalPlayer(),upid)
	end
end

function buyVehicleColor()
	TO_FRONT = true
	openColorPicker()
end

function closedColorPicker()
	local r1, g1, b1, r2, g2, b2 = getVehicleColor(editingVehicle, true)
	local r, g, b = getVehicleHeadLightColor(editingVehicle)
	local ColorsTable = {r1, g1, b1, r2, g2, b2,r, g, b}
	triggerServerEvent("setTheColor",localPlayer,ColorsTable)
	editingVehicle = nil
	TO_FRONT = nil
end

addEvent("GhostOn",true)
addEventHandler("GhostOn",root,function(t,v)
	if t and v then
		for k,a in ipairs ( t ) do
			setElementCollidableWith(v,a,false)
		end
	end
end )

addEvent("GhostOff",true)
addEventHandler("GhostOff",root,function(t,v)
	if t and v then
		for k,a in ipairs ( t ) do
			setElementCollidableWith(v,a,true)
		end
	end
end )

function fix(what)
	return string.gsub(what, '#%x%x%x%x%x%x', '')
end

addEventHandler("onClientRender", root,
    function()
	   	if MSG_SHOW then
	   		local screenW,screenH=guiGetScreenSize()
  			local windowW,windowH=1002,153
  			local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	        dxDrawText(fix(MSG_TXT), x, 122, 1002, 153, tocolor(150, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, false, false)
	        dxDrawText(fix(MSG_TXT), x, 120, 1002, 151, tocolor(150, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, false, false)
	        dxDrawText(fix(MSG_TXT), x, 122, 1000, 153, tocolor(150, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, false, false)
	        dxDrawText(fix(MSG_TXT), x, 120, 1000, 151, tocolor(150, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, false, false)
	        dxDrawText(MSG_TXT, x, 121, 1001, 152, tocolor(155, 0, 0, 255), 1.00, "default", "center", "center", false, false, true, true, false)
  		end 
    end
)
MSG_TIME = 5
MSG_TIMER = nil
function showText(msg)
	MSG_SHOW = true
	MSG_TXT = msg
	playSoundFrontEnd(5)
	if MSG_TIMER then
		if isTimer(MSG_TIMER) then
			killTimer(MSG_TIMER)
		end
	end
	MSG_TIMER = setTimer ( function () MSG_SHOW = false
	MSG_TXT = nil end , MSG_TIME * 1000 , 1 )
end

addEvent("msg_txt",true)
addEventHandler("msg_txt",root,function(msg)
	if msg then
		showText(msg)
	end
end )

function checkMoney(amount)
	if amount then
		local money = getPlayerMoney(localPlayer, "Money") or 0
		if money then
			if tonumber(money) >= tonumber(amount) then
				triggerServerEvent("takeMoney",localPlayer,tonumber(amount))
				--takePlayerMoney(localPlayer,"Money",tonumber(amount))
				return true
			else
				
				showText("#FF0000You don't have enough money !")
				return false
			end
		end
	end
end

function changePlatenumber()
	
end