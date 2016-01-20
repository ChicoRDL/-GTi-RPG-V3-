------------------------------------------------->>
-- PROJECT:			Grand Theft International
-- RESOURCE: 		GTIJournalist/journalist_client.lua
-- DESCRIPTION:		Journalist job, take pictures of crimes/suicides > fill an report.
-- AUTHOR:			Nerox
-- RIGHTS:			All rights reserved to author
------------------------------------------------->>
local policeReportY = 328
local deadBodies = {}
local deadBodyDetails = {}
local allDeadBodies = {}
local deadBodiesBlips = {}
local toStreamBodies = {}
local wx, wy = 800, 600
local sx, sy = guiGetScreenSize ()
local isCurrentlyReporting = false
if sx == 800 and sy == 600 then
policeReportY = 340
end
local x, y = (sx /wx), (sy / wy)  
local isPedOnScreen = "No"
local isPedOnScreenColor = tocolor(255, 0, 0, 255)
local breakLoop = false
function showIfPedOnPicture()
    if getPlayerJob() and getPlayerJob() == "Journalist" and isPedDoingTask (localPlayer, "TASK_SIMPLE_USE_GUN" ) and getPedWeapon(localPlayer) == 43 then
		if #allDeadBodies <= 0 then
		    isPedOnScreen = "No"
			return exports.GTIhud:drawStat("GTIJournalist.isDeadBodyOnScreen", "Dead body on screen:", isPedOnScreen, 0, 255, 255, 500)
		end
		for k, ped in ipairs(getElementsByType("ped")) do   
			for i=1, #allDeadBodies do
	            if allDeadBodies[i] == ped then		
	                if isElementOnScreen(ped) then
					    isPedOnScreen = "Yes"
	                    exports.GTIhud:drawStat("GTIJournalist.isDeadBodyOnScreen", "Dead body on screen:", isPedOnScreen, 0, 255, 255, 500)
						return exports.GTIhud:drawStat("GTIJournalist.isDeadBodyOnScreen", "Dead body on screen:", isPedOnScreen, 0, 255, 255, 500)
					else
					    isPedOnScreen = "No"
	                end
	            end
	        end
		end
	    exports.GTIhud:drawStat("GTIJournalist.isDeadBodyOnScreen", "Dead body on screen:", isPedOnScreen, 0, 255, 255, 500)
	end
end
function handleIfPedOnPicture(jobName, newJob)
    if eventName == "onClientPlayerGetJob" then
	    if jobName == "Journalist" then
			addEventHandler("onClientRender", root, showIfPedOnPicture)
			addEventHandler("onClientRender", root, renderj)
	    end
	elseif eventName == "onClientPlayerQuitJob" then
	    if jobName == "Journalist" then
		    onQuitJob()
			removeEventHandler("onClientRender", root, showIfPedOnPicture)
			removeEventHandler("onClientRender", root, renderj)
	    end
	elseif eventName == "onClientResourceStart" and getResourceFromName("GTIemployment") and getResourceState(getResourceFromName("GTIemployment")) == "running" then
	    setTimer (
			function ()
				if getPlayerJob() == "Journalist" then
					addEventHandler("onClientRender", root, showIfPedOnPicture)
					addEventHandler("onClientRender", root, renderj)
				end
			end, 5000, 1)
	end
end
addEventHandler("onClientPlayerGetJob", root, handleIfPedOnPicture)
addEventHandler("onClientResourceStart", resourceRoot, handleIfPedOnPicture)
addEventHandler("onClientPlayerQuitJob", root, handleIfPedOnPicture)

--[[JR = {
    edit = {},
    button = {},
    window = {},
    label = {},
    memo = {}
}
        JR.window[1] = guiCreateWindow(0.75, 0.33, 0.22, 0.45, "Journalist report", true)
        guiWindowSetSizable(JR.window[1], false)
        guiSetVisible(JR.window[1], false)
		
        JR.edit[1] = guiCreateEdit(0.07, 0.14, 0.88, 0.06, "", true, JR.window[1])
        JR.label[1] = guiCreateLabel(0.07, 0.08, 0.88, 0.05, "Killer/Suicider name:", true, JR.window[1])
        JR.label[2] = guiCreateLabel(0.07, 0.20, 0.88, 0.06, "Reason:", true, JR.window[1])
        JR.edit[2] = guiCreateEdit(0.07, 0.25, 0.88, 0.06, "", true, JR.window[1])
        JR.label[3] = guiCreateLabel(0.07, 0.31, 0.84, 0.07, "Injured bodypart:", true, JR.window[1])
        JR.edit[3] = guiCreateEdit(0.06, 0.38, 0.89, 0.07, "", true, JR.window[1])
        JR.label[4] = guiCreateLabel(0.07, 0.47, 0.82, 0.05, "Weapon used:", true, JR.window[1])
        JR.edit[4] = guiCreateEdit(0.06, 0.53, 0.89, 0.07, "", true, JR.window[1])
        JR.memo[1] = guiCreateMemo(0.06, 0.63, 0.61, 0.33, "", true, JR.window[1])
        guiMemoSetReadOnly(JR.memo[1], true)
        JR.label[7] = guiCreateButton(0.70, 0.67, 0.22, 0.24, "Submit", true, JR.window[1])
        guiSetProperty(JR.label[7], "NormalTextColour", "FFAAAAAA")--]]
function showJournalistReport(state)
    if state then
	    for k, guiElement in ipairs(JR.label) do
		    guiSetVisible(guiElement, true)
		end
	    for k, guiElement in ipairs(JR.memo) do
		    guiSetVisible(guiElement, true)
		end
		for k, guiElement in ipairs(JR.edit) do
		    guiSetVisible(guiElement, true)
		end
		addEventHandler("onClientRender", root, drawJournalistReport)
		isReportShown = true
	else
	    for k, guiElement in ipairs(JR.label) do
		    guiSetVisible(guiElement, false)
		end
	    for k, guiElement in ipairs(JR.memo) do
		    guiSetVisible(guiElement, false)
		end
		for k, guiElement in ipairs(JR.edit) do
		    guiSetVisible(guiElement, false)
		end
		removeEventHandler("onClientRender", root, drawJournalistReport)
		isReportShown = false
	end
end
function isPlayerCurrentlyReporting()
    if isCurrentlyReporting then
	    return true
	else
	    return false
	end
end
local screenW, screenH = guiGetScreenSize()
function drawJournalistReport()
        dxDrawLine((screenW * 0.7160) - 1, (screenH * 0.2744) - 1, (screenW * 0.7160) - 1, screenH * 0.7900, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.9368, (screenH * 0.2744) - 1, (screenW * 0.7160) - 1, (screenH * 0.2744) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine((screenW * 0.7160) - 1, screenH * 0.7900, screenW * 0.9368, screenH * 0.7900, tocolor(0, 0, 0, 255), 1, false)
        dxDrawLine(screenW * 0.9368, screenH * 0.7900, screenW * 0.9368, (screenH * 0.2744) - 1, tocolor(0, 0, 0, 255), 1, false)
        dxDrawRectangle(screenW * 0.7160, screenH * 0.2744, screenW * 0.2208, screenH * 0.5156, tocolor(0, 0, 0, 186), false)
        dxDrawRectangle(screenW * 0.7160, screenH * 0.2744, screenW * 0.2222, screenH * 0.0211, tocolor(38, 234, 6, 170), false)
        dxDrawText("Journalist report", screenW * 0.7903, screenH * 0.2744, screenW * 0.8590, screenH * 0.2956, tocolor(255, 255, 255, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
end
JR = {
    label = {},
    edit = {},
    memo = {}
}
        JR.label[1] = guiCreateLabel(0.79, 0.33, 0.15, 0.02, "Killer/Suicider name", true)
        guiSetFont(JR.label[1], "default-bold-small")
        JR.label[2] = guiCreateLabel(0.81, 0.39, 0.13, 0.02, "Reason", true)
        guiSetFont(JR.label[2], "default-bold-small")
        JR.label[3] = guiCreateLabel(0.80, 0.45, 0.14, 0.02, "Injured bodypart", true)
        guiSetFont(JR.label[3], "default-bold-small")
        JR.label[4] = guiCreateLabel(0.81, 0.52, 0.13, 0.02, "Weapon used", true)
        guiSetFont(JR.label[4], "default-bold-small")
        JR.label[5] = guiCreateLabel(0.72, 0.57, 0.22, 0.03, "    __________________________________________", true)
        guiSetFont(JR.label[5], "default-bold-small")
        JR.label[6] = guiCreateLabel(0.81, 0.74, 0.13, 0.02, "[Submit report]", true)
        guiSetFont(JR.label[6], "default-bold-small")
		JR.label[7] = guiCreateLabel(0.72, 0.80, 0.20, 0.05, "*When you submit your report with right information you get bonus money/exp", true)
		guiSetProperty(JR.label[7], "HorzScrollbar", "True")
        guiSetFont(JR.label[7], "default-bold-small")
		guiLabelSetColor ( JR.label[7], 255, 0, 0 )
        JR.memo[1] = guiCreateMemo(0.72, 0.61, 0.21, 0.11, "", true)
        JR.edit[1] = guiCreateEdit(0.72, 0.35, 0.21, 0.03, "", true)
        JR.edit[2] = guiCreateEdit(0.72, 0.41, 0.21, 0.03, "", true)
        JR.edit[3] = guiCreateEdit(0.72, 0.48, 0.21, 0.03, "", true)
        JR.edit[4] = guiCreateEdit(0.72, 0.54, 0.21, 0.03, "", true)    
		showJournalistReport(false)

addEventHandler("onClientMouseEnter", JR.label[6], function()
    guiLabelSetColor ( JR.label[6], 230, 170, 30 )
end, false)
addEventHandler("onClientMouseLeave", JR.label[6], function()
    guiLabelSetColor ( JR.label[6], 255, 255, 255 )
end, false)	
		
local JRwindUtils = {
    isSuicide = false,
	ranOver = false,
	suiciderName = "",
	submit = false
}
local isReportShown = false

function isJournalistReportShown()
    if isReportShown then
	    return true
	else
	    return false
	end
end
function showJournalistReportPanel()
    if isJournalistReportShown() then return false end
	showJournalistReport(true)
	showCursor(true)
	guiSetInputMode ("no_binds_when_editing")
	addEventHandler("onClientGUIChanged", JR.edit[1], updateReportMemo)
	addEventHandler("onClientGUIChanged", JR.edit[2], updateReportMemo)
	addEventHandler("onClientGUIChanged", JR.edit[3], updateReportMemo)
	addEventHandler("onClientGUIChanged", JR.edit[4], updateReportMemo)
	addEventHandler("onClientGUIClick", JR.label[6], onClickSubmitReport)
end
function updateReportMemo()
    if guiGetText(JR.edit[1]) ~= "" and guiGetText(JR.edit[2]) ~= "" and guiGetText(JR.edit[3]) ~= "" and guiGetText(JR.edit[4]) ~= "" then
	    if not JRwindUtils.isSuicide and not JRwindUtils.ranOver then
	    guiSetText(JR.memo[1], "Today, there was a crime occurred in San Andreas.. The police departement says that they are searching for the criminal, and that they know him, The killer's name is \""..guiGetText(JR.edit[1]).."\",The victim is called \""..JRwindUtils.suiciderName.."\", The killer killed his victim using his "..guiGetText(JR.edit[4])..", he did hit the victim on his "..guiGetText(JR.edit[3])..", The reason is "..guiGetText(JR.edit[2])..". Victim's body can be found at Los Santos All Saints Hospital, Thanks for reading\n\nReport written by "..getPlayerName(localPlayer).." ")
	    elseif JRwindUtils.isSuicide then
	    guiSetText(JR.memo[1], "Today, there was a suicide occurred in San Andreas.. The police departement says that they found his body early in the morning. The suicider is called \""..JRwindUtils.suiciderName.."\", The victim's injured bodypart is "..guiGetText(JR.edit[3])..", The reason of suicide is "..guiGetText(JR.edit[2])..". Victim's body can be found at Los Santos All Saints Hospital, Thanks for reading\n\nReport written by "..getPlayerName(localPlayer).." ")
	    elseif JRwindUtils.ranOver then
		guiSetText(JR.memo[1], "Today, there was a crime occurred in San Andreas.. The police departement says that the victim was killed by a vehicle. The driver is \""..guiGetText(JR.edit[1]).."\", The victim's injured bodypart is "..guiGetText(JR.edit[3])..", The reason of the crime is "..guiGetText(JR.edit[2])..". Victim's body can be found at Los Santos All Saints Hospital, Thanks for reading\n\nReport written by "..getPlayerName(localPlayer).." ")
	    end
	JRwindUtils.submit = true
	else
	guiSetText(JR.memo[1], "")
	JRwindUtils.submit = false
    end
end
local policeReportUtils = {
    Killer = "",
	Reason = "Unknown",
	BodyPart = "",
	Weapon = "",
	Text = ""
}	
function onClickSubmitReport()
    if source == JR.label[6] then
        if JRwindUtils.submit then
	    exports.GTIhud:dm("Thanks for submitting your report it will be released in tommorow's newspaper", 0, 255, 0)
	    local extraBonus = false
	        if string.lower(policeReportUtils.Killer) == string.lower(guiGetText(JR.edit[1])) and string.lower(policeReportUtils.BodyPart) == string.lower(guiGetText(JR.edit[3])) and string.lower(policeReportUtils.Weapon) == string.lower(guiGetText(JR.edit[4])) and string.lower(guiGetText(JR.edit[2])) == string.lower("Unknown") then
	        extraBonus = true
	        else
	        extraBonus = false
	        end
	    hideJournalistReportPanel()
	    triggerServerEvent("GTIjournalist.rewardOnFinishReport", localPlayer, extraBonus)
		isCurrentlyReporting = false
	    else
	    exports.GTIhud:dm("You cannot submit a report without having text in it!", 255, 0, 0)
	    end
    end
end
function hideJournalistReportPanel()
    JRwindUtils.submit = false
    showJournalistReport(false)
	showCursor(false)
	removeEventHandler("onClientRender", root, residentCard)
	removeEventHandler("onClientRender", root, policeReport)
	removeEventHandler("onClientGUIChanged", JR.edit[1], updateReportMemo)
	removeEventHandler("onClientGUIChanged", JR.edit[2], updateReportMemo)
	removeEventHandler("onClientGUIChanged", JR.edit[3], updateReportMemo)
	removeEventHandler("onClientGUIChanged", JR.edit[4], updateReportMemo)
	removeEventHandler("onClientGUIClick", JR.label[6], onClickSubmitReport)
	guiSetText(JR.edit[1], "")
	guiSetText(JR.edit[2], "")
	guiSetText(JR.edit[3], "")
	guiSetText(JR.edit[4], "")
	guiSetText(JR.memo[1], "")
	guiSetInputMode ("allow_binds")
end

local residentCardUtils = {
    name = "",
	DayOfBirth = "",
	YearOfBirth = ""
}
function residentCard()
        dxDrawRectangle(3 * x, 217 * y, 255 * x, 131 * y, tocolor(0, 0, 0, 255), false)
        dxDrawRectangle(4 * x, 217 * y, 253 * x, 132 * y, tocolor(205, 205, 205, 255), false)
        dxDrawRectangle(3 * x, 216 * y, 127 * x, 14 * y, tocolor(0, 0, 0, 255), false)
        dxDrawRectangle(4 * x, 217 * y, 125 * x, 12 * y, tocolor(255, 255, 255, 255), false)
        dxDrawText("Grand theft international", 6 * x, 217 * y, 125 * x, 233 * y, tocolor(0, 0, 0, 255), 0.90, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawRectangle(128 * x, 216 * y, 130 * x, 16 * y, tocolor(0, 0, 0, 255), false)
        dxDrawRectangle(129 * x, 217 * y, 128 * x, 14 * y, tocolor(255, 255, 255, 255), false)
        dxDrawText("Permanent Resident", 130 * x, 217 * y, 258 * x, 231 * y, tocolor(0, 0, 0, 255), 1, "default", "left", "top", false, false, false, false, false)
        dxDrawText("Name:\n"..residentCardUtils.name.."", 72 * x, 239 * y, 235 * x, 271 * y, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("Country of birth: \nLos santos", 72 * x, 300 * y, 235 * x, 328 * y, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawText("Date of birth:\n"..residentCardUtils.DayOfBirth.." JAN "..residentCardUtils.YearOfBirth.."", 72 * x, 271 * y, 235 * x, 300 * y, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawImage(6 * x, 236 * y, 59 * x, 64 * y, "guest.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
        dxDrawText("Card expires:           3/23/2018", 72 * x, 329 * y, 235 * x, 348 * y, tocolor(0, 0, 0, 255), 1.00, "default-bold", "left", "top", false, false, false, false, false)
        dxDrawImage(11 * x, 303 * y, 46 * x, 28 * y, "logo.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
end
function showResidentCard(name, day, year, isSuicide, ranOver)
    residentCardUtils.name = name
	residentCardUtils.DayOfBirth = day
	residentCardUtils.YearOfBirth = year
	JRwindUtils.isSuicide = isSuicide
	JRwindUtils.ranOver = ranOver
	JRwindUtils.suiciderName = residentCardUtils.name
	addEventHandler("onClientRender", root, residentCard)
	showJournalistReportPanel()
end
function policeReport()
	    dxDrawImage(261 * x, 138 * y, 290 * x, policeReportY * y, "SAPDPR.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
		dxDrawText(""..policeReportUtils.Text.."", 268 * x, 222 * y, 545 * x, 329 * y, tocolor(0, 0, 0, 255), 1, "default", "left", "top", false, true, true, false, false)
        dxDrawLine(326 * x, 350 * y, 450 * x, 350 * y, tocolor(0, 0, 0, 255), 1, false)
        dxDrawText("Killer/Suicider: "..policeReportUtils.Killer.." \nReason: Unknown\nVictim's injured bodypart: "..policeReportUtils.BodyPart.."\nWeapon of crime: "..policeReportUtils.Weapon.."", 271 * x, 360 * y, 545 * x, 329 * y, tocolor(0, 0, 0, 255), 0.65, "bankgothic", "left", "top", false, true, true, false, false)
end
function showPoliceRecord(vname, killer, bodypart, weapon, ranOver, isSuicide)
    policeReportUtils.Killer = killer or "Undefined"
	policeReportUtils.BodyPart = bodypart or "Right leg"
	policeReportUtils.Weapon = weapon or "None"
	if ranOver then
	    if not killer then
	        policeReportUtils.Killer = "Undefined"
	        policeReportUtils.Text = "The victim has been murdered by a vehicle, Unfortunately we couldn't recognize the driver. The crime occurred this morning, "..math.random(1, 12).."/"..math.random(1, 30).."/2015\nThe investigations are still ongoing."
	    else
	        policeReportUtils.Text = "The victim has been murdered by a vehicle, The crime occurred this morning, "..math.random(1, 12).."/"..math.random(1, 30).."/2015, Due to our efforts we have recognized the driver. his name is "..policeReportUtils.Killer..""
	    end
		return addEventHandler("onClientRender", root, policeReport)
	end
	if isSuicide then
	    policeReportUtils.Weapon = "None"
		policeReportUtils.Text = "The person who suicided is named: \""..vname.."\"\nIt happened early this morning, "..math.random(1, 12).."/"..math.random(1, 30).."/2015..\nWe currently have no information about the reason of the suicide \nHopefully, we've sent some officers to the scene to supervise.\n"
	else
	    policeReportUtils.Text = "The victim has been murdered by a person, called \""..policeReportUtils.Killer.."\"\nThe crime occurred this morning, "..math.random(1, 12).."/"..math.random(1, 30).."/2015.\nWe currently have no information about the reason of the crime.\nHopefully, we've sent some officers to the scene to supervise.\nWe can promise that the killer will be on our cells in 24 hours"
	end
	addEventHandler("onClientRender", root, policeReport)
end
addEventHandler ( "onClientPedDamage", getRootElement(), function()
    if getElementData(source, "GTIjournalist.deadBodyID") then
	cancelEvent()
	end
end)
local allPeds = {}
local allDistances = {}
local pedE
function getNearestPed(player)
    allDistances = {}
	if #allPeds <= 0 then return false end
        for i=1, #allPeds do
	    table.insert(allDistances, allPeds[i][2])
	    end
	local nearestDistance = math.min(unpack(allDistances))
	    for i=1, #allPeds do
	        if allPeds[i][2] == nearestDistance then
	        pedE = allPeds[i][1]
	        end
	    allPeds[i] = nil
	    end
	return pedE 
end
local lastVictim
function onTakePictureOfVictim(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement, startX, startY, startZ)
    if source ~= localPlayer then
	    return false
	end
    if getPlayerJob() == "Journalist" then --- <<
	    if weapon == 43 then
		if isPlayerCurrentlyReporting() then return false end
	    local x, y, z = getElementPosition(localPlayer)
	        for k, ped in ipairs(getElementsByType("ped")) do
			    for i=1, #allDeadBodies do
	                if allDeadBodies[i] == ped then
	                    --if getElementHealth(ped) < 0.1 then
	                        if isElementOnScreen(ped) then
	                            local px, py, pz = getElementPosition(ped)
	                            if getDistanceBetweenPoints3D(x, y, z, px, py, pz) <= 15 then
	                                local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz)
	                                table.insert(allPeds, {ped, distance})
							    end
						    end
                        --end                 
	                end
			    end
			end
	    local target = getNearestPed(localPlayer)
		if not target then return false end
		local source = source
		local vName, kName, weapon, bodypart, isSuicide, ranOver = unpack(deadBodies[getElementData(target, "GTIjournalist.deadBodyID")])
		if vName == lastVictim then
		    exports.GTIhud:dm("Journalist: You cannot take picture of the same victim 2 times in a row.", 255, 0, 0)
		    return false
		end
		lastVictim = vName
		isCurrentlyReporting = true
	    setTimer(function()
		local id = getElementData(target, "GTIjournalist.deadBodyID")
	    triggerServerEvent("GTIjournalist.destroyPed", source, id)
		isPedOnScreen = "No"
		end, 500, 1)
		setTimer(function()
		    setPedAnimation(source,"BOMBER", "BOM_Plant", -1, false, false, false, false)
	    end, 2000, 1)
		setTimer(function()
			exports.GTIhud:dm("Journalist: You have found the victim's ID card.", 0, 255, 0)
			showResidentCard(vName, math.random(1, 29), math.random(1950, 1992), isSuicide, ranOver) ---name, day, year, isSuicide
		end, 3000, 1)
		setTimer(function()
		    exports.GTIhud:dm("The Federal Bureau of Investigation sent you information about the crime.", 0, 255, 0)
			showPoliceRecord(vName, kName, bodypart, weapon, ranOver, isSuicide)
		end, 5000, 1)
        end
    end		
end
addEventHandler("onClientPlayerWeaponFire", root, onTakePictureOfVictim)
setTimer(function()
    for id, ped in ipairs(getElementsByType("ped")) do
	    if getElementData(ped, "GTIjournalist.deadBodyID") then
	        for k, vehicle in ipairs(getElementsByType("vehicle")) do
	            if isElementCollidableWith(ped, vehicle) then
	            setElementCollidableWith(ped, vehicle, false)
	            end
	        end
			 for k, player in ipairs(getElementsByType("player")) do
	            if isElementCollidableWith(ped, player) then
	            setElementCollidableWith(ped, player, false)
	            end
	        end
			for k, peds in ipairs(getElementsByType("ped")) do
	            if isElementCollidableWith(ped, peds) then
	            setElementCollidableWith(ped, peds, false)
	            end
	        end
	    end
	end
end, 1000, 0)
function createNewDeadBody(id, model, position, rot, killedName, killerName, killerWeapon, bodyPart) 
    local x, y, oZ = unpack(position)
	local z = (getGroundPosition(x, y, oZ+2) + 1)
    local deadBody = createPed(model, x, y, z+1, rot, false)
	setElementCollidableWith(deadBody, localPlayer, false)
	deadBodyDetails[deadBody] = {model, x, y, oZ, rot}
	--setElementStreamable(deadBody, false)
	--setElementHealth(deadBody, 0)
	setTimer(setPedAnimation, 1000, 1, deadBody, "ped", "KO_shot_front", -1, false, false, false, true)
	table.insert(allDeadBodies, deadBody)
	setElementData(deadBody, "GTIjournalist.deadBodyID", id)
	local blip = createBlipAttachedTo (deadBody, 23)
	setElementData(blip, "GTIjournalist.bodyBlipID", id)
	if killedName == killerName then
        deadBodies[id] = {killedName, killerName, "None", "Neck", true, false}
	else
	    if not killerWeapon then
	        deadBodies[id] = {killedName, killerName, "None", getBodyPartName(bodyPart) or "Neck", false, true}
        else
          	deadBodies[id] = {killedName, killerName, getWeaponNameFromID (killerWeapon), getBodyPartName(bodyPart), false, false}	
		end
	end
end
addEvent("GTIjournalist.createNewDeadBody", true)
addEventHandler("GTIjournalist.createNewDeadBody", root, createNewDeadBody)
function removePed(id)
	for k, ped in pairs(allDeadBodies) do
	    if isElement(ped) then
	        if getElementData(ped, "GTIjournalist.deadBodyID") == id then
			    destroyElement(ped)
		        table.remove(allDeadBodies, k)
		        deadBodies[id] = nil
				deadBodyDetails[ped] = nil
		    end
		end
	end
	for ids, blip in ipairs(getElementsByType("blip")) do
	     if getElementData(blip, "GTIjournalist.bodyBlipID") == id then
			destroyElement(blip)
		end
	end
end
addEvent("GTIjournalist.removePed", true)
addEventHandler("GTIjournalist.removePed", root, removePed)
function onQuitJob(jobName)
    for k, ped in pairs(allDeadBodies) do
	    if isElement(ped) then
	        destroyElement(ped)
		    table.remove(allDeadBodies, k)
		end
	end
	for k, ped in pairs(toStreamBodies) do
	    if isElement(ped) then
	        destroyElement(ped)
		    table.remove(toStreamBodies, k)
		end
	end
	for k, ped in ipairs(getElementsByType("ped")) do
	    if getElementData(ped, "GTIjournalist.deadBodyID") then
		    deadBodies[getElementData(ped, "GTIjournalist.deadBodyID")] = nil
		    destroyElement(ped)
		end
	end
	for k, blip in ipairs(getElementsByType("blip")) do
	    if getElementData(blip, "GTIjournalist.bodyBlipID") then
		    destroyElement(blip)
		end
	end
end
addEventHandler( "onClientElementStreamIn", getRootElement( ),
    function ()
        if getElementType( source ) == "ped" then
            if getElementData(source, "GTIjournalist.deadBodyID") then
			    for k, ped in pairs(toStreamBodies) do
				    if ped == source then
			            correctPedPosition(source)
				        setPedAnimation(source, "ped", "KO_shot_front", -1, false, false, false, true)
						table.remove(toStreamBodies, k)
					end
				end
			end
        end
    end
)
local antiSpam = {position={}, animation={}}
function renderjor()
    if not getPlayerJob() == "Journalist" then return false end
	for i=1, #allDeadBodies do
	    if not isElement(allDeadBodies[i]) then return false end
	    if isElementStreamedIn(allDeadBodies[i]) then
		    if not isPedInPosition(allDeadBodies[i]) then
			    if not antiSpam.position[allDeadBodies[i]] then
			        correctPedPosition(allDeadBodies[i])
				    antiSpam.position[allDeadBodies[i]] = true
				end
			end
		    local blockName, animName = getPedAnimation(allDeadBodies[i])
			if animName ~= "KO_shot_front" then
			    if not antiSpam.animation[allDeadBodies[i]] then
			        antiSpam.animation[allDeadBodies[i]] = true
			        setPedAnimation(allDeadBodies[i], "ped", "KO_shot_front", -1, false, false, false, true)
				end
			end
		end
	end
end

addEventHandler( "onClientElementStreamOut", getRootElement( ),
    function ()
        if getElementType( source ) == "ped" then
            if getElementData(source, "GTIjournalist.deadBodyID") then
			    antiSpam.position[source] = false
				antiSpam.animation[source] = false
                table.insert(toStreamBodies, source)
				correctPedPosition(source)
			end
        end
    end
)
function isPedInPosition(ped)
    local currentX, currentY, currentZ = getElementPosition(ped)
	local correctX, correctY, correctZ = deadBodyDetails[ped][2], deadBodyDetails[ped][3], (getGroundPosition(deadBodyDetails[ped][2], deadBodyDetails[ped][3], (deadBodyDetails[ped][4]+2))+2)
	if ( math.ceil(currentX) ~= math.ceil(correctX) ) or ( math.ceil(currentY) ~= math.ceil(correctY) ) or ( math.ceil(currentZ) ~= math.ceil(correctZ) ) then
        return false
	else
	    return true
	end
end
local cCurrentX, cCurrentY, cCurrentZ
local cCorrectX, cCorrectY, cCorrectZ
function correctPedPosition(ped)
    if isElement(ped) then
		cCurrentX, cCurrentY, cCurrentZ = getElementPosition(ped)
		cCorrectX, cCorrectY, cCorrectZ = deadBodyDetails[ped][2], deadBodyDetails[ped][3], (getGroundPosition(deadBodyDetails[ped][2], deadBodyDetails[ped][3], (deadBodyDetails[ped][4]+2))+2)
		if ( math.ceil(cCurrentX) ~= math.ceil(cCorrectX) ) or ( math.ceil(cCurrentY) ~= math.ceil(cCorrectY) ) or ( math.ceil(cCurrentZ) ~= math.ceil(cCorrectZ) ) then
			setElementPosition(ped, deadBodyDetails[ped][2], deadBodyDetails[ped][3], getGroundPosition(deadBodyDetails[ped][2], deadBodyDetails[ped][3], deadBodyDetails[ped][4]+2)+2)
		    --setElementHealth(ped, 0)
			setPedAnimation(ped, "ped", "KO_shot_front", -1, false, false, false, true)
		end
	end
end
function isPositionInWaterC(x, y, z)
    isInWater, _, _, _ = testLineAgainstWater ( x, y, z, x, y, getGroundPosition(x, y, z+5)-3 )
	if isInWater then
	    triggerServerEvent("GTIjournalist.isPositionInWater", source, false, x, y, z, source, true)
	else
	    triggerServerEvent("GTIjournalist.isPositionInWater", source, false, x, y, z, source, false)
	end
end
addEvent("GTIjournalist.isPositionInWaterC", true)
addEventHandler("GTIjournalist.isPositionInWaterC", root, isPositionInWaterC)

addEventHandler("onClientResourceStart", root,
    function (res)
        if ( getResourceName(res) == "GTIemployment" or source == resourceRoot ) then    
            function getPlayerJob()
                return exports.GTIemployment:getPlayerJob(true)
            end
        end
    end
)
