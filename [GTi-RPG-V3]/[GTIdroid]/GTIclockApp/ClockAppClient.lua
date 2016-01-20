GUIEditor = {
    staticimage = {},
    edit = {},
    button = {},
    window = {},
    label = {}
}
function renderAppGUI()
		if (not getResourceFromName("GTIdroid") or getResourceState(getResourceFromName("GTIdroid")) ~= "running") then return end
		GTIPhone = exports.GTIdroid:getGTIDroid()
		if (not GTIPhone) then return end
		ClockApp = exports.GTIdroid:getGTIDroidAppButton("Clock")
		addEventHandler("onClientGUIClick", ClockApp, showClockGUI, false)
		GUIEditor.window[2] = guiCreateStaticImage(17, 67, 270, 429, ":GTIdroid/wallpapers/Wallpaper.png", false, GTIPhone)
        GUIEditor.staticimage[1] = guiCreateStaticImage(30, 56, 220, 107, "clck.png", false, GUIEditor.window[2])
        GUIEditor.label[1] = guiCreateLabel(25, 22, 183, 97, "", false, GUIEditor.staticimage[1])
		ROBO = guiCreateFont( "robo.ttf", 34 )
		guiSetFont ( GUIEditor.label[1], ROBO )
		guiSetAlpha(GUIEditor.staticimage[1],0.9)
        GUIEditor.label[2] = guiCreateLabel(119, 80, 123, 26, "", false, GUIEditor.staticimage[1])
		guiSetFont ( GUIEditor.label[2], "default-small" )
        GUIEditor.edit[1] = guiCreateEdit(74, 273, 41, 21, "0", false, GUIEditor.window[2])
        GUIEditor.staticimage[3] = guiCreateStaticImage(0, 0, 270, 30, ":GTIdroid/phone/search_bar.png", false, GUIEditor.window[2])
        GUIEditor.label[9] = guiCreateLabel(10, 25, 150, 26, "", false, GUIEditor.window[2])
		guiLabelSetColor(GUIEditor.label[9], 255, 0, 0)
		guiEditSetMaxLength(GUIEditor.edit[1],2)
        GUIEditor.edit[2] = guiCreateEdit(120, 273, 41, 21, "0", false, GUIEditor.window[2])
		guiEditSetMaxLength(GUIEditor.edit[2],2)
        GUIEditor.edit[3] = guiCreateEdit(167, 273, 41, 21, "0", false, GUIEditor.window[2])
		guiEditSetMaxLength(GUIEditor.edit[3],2)
        GUIEditor.button[1] = guiCreateButton(68, 318, 140, 29, "Start", false, GUIEditor.window[2])
        GUIEditor.button[2] = guiCreateButton(177, 358, 83, 29, "Count up", false, GUIEditor.window[2])
        GUIEditor.button[6] = guiCreateButton(0, 398, 270, 29, "Alarm", false, GUIEditor.window[2])
        GUIEditor.button[3] = guiCreateButton(12, 358, 83, 29, "Reset", false, GUIEditor.window[2])
        GUIEditor.label[3] = guiCreateLabel(10, 278, 60, 30, "HH/MM/SS", false, GUIEditor.window[2])
        GUIEditor.label[4] = guiCreateLabel(19, 80, 183, 77, "", false, GUIEditor.staticimage[1])
		guiSetFont ( GUIEditor.label[4], "default-small" )
		GUIEditor.label[5] = guiCreateLabel(28, 188, 263, 50, "00:00:00", false, GUIEditor.window[2])
		guiSetFont ( GUIEditor.label[5], ROBO )
		guiLabelSetColor(GUIEditor.label[5], 0, 0, 0)
		--Alarm window
		local sWidth, sHeight = guiGetScreenSize()
		local Width,Height = 200,117
		local X = (sWidth/2) - (Width/2)
		local Y = (sHeight/2) - (Height/2)
        GUIEditor.window[1] =  guiCreateWindow(X,Y,Width,Height, "Add an alarm", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        GUIEditor.edit[6] = guiCreateEdit(15, 56, 259, 21, "Message to display", false, GUIEditor.window[1])
        GUIEditor.button[4] = guiCreateButton(47, 86, 52, 17, "Add", false, GUIEditor.window[1])
        GUIEditor.button[5] = guiCreateButton(111, 86, 52, 17, "Exit", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FFFF0000")
        GUIEditor.edit[4] = guiCreateEdit(74, 36, 37, 21, "0", false, GUIEditor.window[1])
		guiEditSetMaxLength(GUIEditor.edit[4],2)
        GUIEditor.edit[5] = guiCreateEdit(117, 36, 37, 21, "0", false, GUIEditor.window[1])
		guiEditSetMaxLength(GUIEditor.edit[5],2)
        GUIEditor.label[7] = guiCreateLabel(112, 36, 12, 20, ":", false, GUIEditor.window[1])
        GUIEditor.label[8] = guiCreateLabel(25, 36, 49, 23, "HH/MM", false, GUIEditor.window[1])    
		guiSetVisible(GUIEditor.window[1], false)
		guiSetVisible(GUIEditor.window[2], false)
end
addEventHandler("onClientResourceStart", resourceRoot, renderAppGUI)
addEvent("onGTIPhoneCreate", true)
addEventHandler("onGTIPhoneCreate", root, renderAppGUI)
function showClockGUI()
    guiSetVisible(GUIEditor.window[2], true)
    exports.GTIdroid:showMainMenu(false)
    exports.GTIdroid:playTick()
	addEventHandler ( "onClientRender", root, gametime)
	addEventHandler ( "onClientRender", root, realtime)
end
 
function hideAppGUI()
	if guiGetVisible(GUIEditor.window[2]) then
		guiSetVisible(GUIEditor.window[2], false)
		guiSetVisible(GUIEditor.window[1], false)
		removeEventHandler( "onClientRender", root, gametime)
		removeEventHandler( "onClientRender", root, realtime)
		exports.GTIdroid:showMainMenu(true)
	end
end
addEventHandler("onGTIDroidClickBack", root, hideAppGUI)
addEventHandler("onGTIDroidClose", root, hideAppGUI)
addEventHandler("onClientResourceStop", resourceRoot, hideAppGUI)
addEventHandler("onClientResourceStart", resourceRoot, hideAppGUI)


function alarmbtn()
	if ( source == GUIEditor.button[6] ) then
		exports.GTIdroid:playTick()
		guiSetVisible(GUIEditor.window[1], true)
	elseif ( source == GUIEditor.button[5] ) then
		guiSetVisible(GUIEditor.window[1], false)
	elseif ( source == GUIEditor.button[4] ) then
		if isTimer(checkAlarmTimer) then killTimer(checkAlarmTimer) end
		local Ahour = guiGetText ( GUIEditor.edit[4] )
		local msg = guiGetText ( GUIEditor.edit[6] )
		local Amins = guiGetText ( GUIEditor.edit[5] )
		local currentAMinute = tonumber( Amins )
		local currentAHour = tonumber(Ahour)
	   if currentAHour >= 0 and currentAMinute >= 0 then
			AlarmH = currentAHour
			AlarmM = currentAMinute
			Alarmmsg = msg
			guiSetText ( GUIEditor.label[9], "*Alarm set to: "..AlarmH..":"..AlarmM )
			exports.GTIhud:dm("*Alarm set to: "..AlarmH..":"..AlarmM, 255, 0, 0)
			checkAlarmTimer = setTimer(checkAlarm,10000,0)
		end
		guiSetVisible(GUIEditor.window[1], false)
	end 
end
addEventHandler ( "onClientGUIClick", root, alarmbtn )
function checkAlarm()
        local time = getRealTime()
        local ALhours = time.hour
        local ALminutes = time.minute
		if ( AlarmH == ALhours ) and ( AlarmM == ALminutes ) then
	    exports.GTIhud:dm("Alarm: "..Alarmmsg, 255, 0, 0)
		alarmsnd = playSFX("script", 7, 1, true)
		setTimer(stopSound,5000,1,alarmsnd)
		guiSetText ( GUIEditor.label[9], "")
		killTimer(checkAlarmTimer)
end
end
function realtime()
	if isElement(GUIEditor.label[1]) then
        local time = getRealTime()
        local hours = time.hour
        local minutes = time.minute
        local monthdays = time.monthday
        local months = time.month + 1
        local years = time.year + 1900
		local monthN = exports.GTIutil:getMonthName(months, 3)
        if minutes < 10 then 
			minutes = tostring( "0"..minutes )
        else
			minutes = tostring( minutes )
        end
        if hours < 10 then 
			hours = tostring( "0"..hours )
        else
			hours = tostring( hours )
        end
		guiSetText ( GUIEditor.label[1], hours.."  "..minutes )
        guiSetText ( GUIEditor.label[4], monthdays.." "..monthN..". "..years )
	end
end



function gametime()
  local hour, minutes = getTime()
        if minutes < 10 then 
            minutes = tostring( "0"..minutes )
        else
			minutes = tostring( minutes )
		end
        guiSetText ( GUIEditor.label[2], "Game Time: "..hour..":"..minutes )
end

local csec = 0
local cmin = 0
local chr = 0
local vcount1 = "00"
local vcount2 = "00"
local vcount3 = "00"

function countUp()
        csec = csec + 1
        if csec < 10 then
            vcount3 = tostring( "0"..csec)
            guiSetText(GUIEditor.label[5], vcount1..":"..vcount2..":"..vcount3)
        else
            vcount3 = tostring( csec)
            guiSetText(GUIEditor.label[5], vcount1..":"..vcount2..":"..vcount3)
        end
        if csec > 59 then
                csec = 0
                vcount3 = "00"
                guiSetText(GUIEditor.label[5], vcount1..":"..vcount2..":"..vcount3)
                cmin = cmin + 1
                if cmin < 10 then
                        vcount2 = tostring( "0"..cmin)
                        guiSetText(GUIEditor.label[5], vcount1..":"..vcount2..":"..vcount3)
                else
                        vcount2 = tostring( cmin)
                        guiSetText(GUIEditor.label[5], vcount1..":"..vcount2..":"..vcount3)
                end
        if cmin > 59 then
                cmin = 0
                vcount2 = "00"
                guiSetText(GUIEditor.label[5], vcount1..":"..vcount2..":"..vcount3)
                chr = chr + 1
                if chr < 10 then
                        vcount1 = tostring( "0"..chr)
                        guiSetText(GUIEditor.label[5], vcount1..":"..vcount2..":"..vcount3)
                else
                        vcount1 = tostring( chr )
                        guiSetText(GUIEditor.label[5], vcount1..":"..vcount2..":"..vcount3)
                end
                                end
end
end

function togglecountUp()
	if ( source == GUIEditor.button[2] ) then
		exports.GTIdroid:playTick()
		if isTimer(timercountds) then killTimer(timercountds) end
		if not isTimer(countuptimer) then
			countuptimer = setTimer( countUp, 1000, 0)
		else
			killTimer(countuptimer)
		end
	end 
end
addEventHandler ( "onClientGUIClick", root, togglecountUp )

function reset()
	if ( source == GUIEditor.button[3] ) then
		exports.GTIdroid:playTick()
		if isTimer(timercountds) then killTimer(timercountds) end
		if isTimer(countuptimer) then killTimer(countuptimer) end
		guiSetText(GUIEditor.label[5], "00:00:00")
		cmin = 0
		chr = 0
		csec = 0
		currentCount = 0
		currentHour = 0
		currentMinute = 0
	end 
end
addEventHandler ( "onClientGUIClick", root, reset )




function countdown()
    if ( source == GUIEditor.button[1] ) then
		exports.GTIdroid:playTick()
		if isTimer(timercountds) then killTimer(timercountds) end
		if isTimer(countuptimer) then killTimer(countuptimer) end
	    local hour = guiGetText ( GUIEditor.edit[1] )
	    local mins = guiGetText ( GUIEditor.edit[2] ) 
	    local sec =  guiGetText ( GUIEditor.edit[3] ) 
	    currentCount = tonumber(sec)
	    currentMinute = tonumber(mins)
	    currentHour = tonumber(hour)
	    if currentCount < 0 then
			currentCount = 0
		end
	    if currentMinute < 0 then
			currentMinute = 0
		end
	    if currentHour < 0 then
			currentHour = 0
		end
		viewCount1 = tostring( currentHour )    
		viewCount2 = tostring( currentMinute)
		viewCount3 = tostring( currentCount)
		guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
		timercountds = setTimer(countds, 1000, 0)
        if currentCount < 10 then
            viewCount3 = tostring( "0"..currentCount)
            guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
        else
            viewCount3 = tostring( currentCount)
            guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
        end
		if currentMinute < 10 then
			viewCount2 = tostring( "0"..currentMinute)
			guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
		else
			viewCount2 = tostring( currentMinute)
			guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
		end
		if currentHour < 10 then                                
			viewCount1 = tostring( "0"..currentHour)
			guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
		else
			viewCount1 = tostring( currentHour )
			guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
		end
	end
end
addEventHandler ( "onClientGUIClick", root, countdown )

function countds()
	if currentCount > 0 then
		currentCount = currentCount - 1
	end
    if currentCount == 0 and currentMinute > 0 then
		currentCount = 59
		currentMinute = currentMinute - 1
	end
    if currentMinute == 0 and currentHour > 0 then
		currentMinute = 59
		currentHour = currentHour - 1
	end
	if currentCount == 0 and currentMinute == 0 and currentHour == 0 then
		exports.GTIhud:dm("Time's up!", 255, 0, 0)
		alarm = playSFX("script", 7, 1, true)
		setTimer(stopSound,5000,1,alarm)
		killTimer(timercountds)
	end
        if currentCount < 10 then
            viewCount3 = tostring( "0"..currentCount)
            guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
        else
            viewCount3 = tostring( currentCount)
            guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
        end
    if currentMinute < 10 then
		viewCount2 = tostring( "0"..currentMinute)
		guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
    else
		viewCount2 = tostring( currentMinute)
		guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
    end
    if currentHour < 10 then                                
		viewCount1 = tostring( "0"..currentHour)
		guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
    else
		viewCount1 = tostring( currentHour )
		guiSetText(GUIEditor.label[5], viewCount1..":"..viewCount2..":"..viewCount3)
    end
end