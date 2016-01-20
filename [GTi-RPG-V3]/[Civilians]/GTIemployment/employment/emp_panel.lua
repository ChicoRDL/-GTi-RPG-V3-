----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 03 Dec 2013
-- Resource: GTIemployment/emp_panel.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local DESC_COUNT = 68	-- Width of Description Label (Letters)

local orgSkin	-- Original Skin ID (Before Previews)
local jobName	-- Job Name
local selSkin	-- Current Selected Skin
local skinTbl	-- Skin List Table
local level		-- Job Level Cache

local skinCache = {}	-- Table of Skin IDs in Combobox

addEvent("onClientPlayerGetJob", true)
addEvent("onClientPlayerQuitJob", true)
addEvent("onClientPlayerJobDivisionChange", true)
-- GUI Job Data
---------------->>

function sendGUIJobData(job, rank, job_data, rank_data)
		-- Job Name
	jobName = job
	local employer = job_data.employer or "GTI Government"
	guiSetText(employment.window[1], "GTI "..job.." Application — "..employer)
	
		-- Player Name
	guiSetText(employment.label[4], getPlayerName(localPlayer))
		-- Job Name
	guiSetText(employment.label[12], job)
		-- Date
	local day,mon,yr = exports.GTIutil:todate(getRealTime().timestamp)
	local day = string.format("%02d", day)
	local mon = exports.GTIutil:getMonthName(mon)
	guiSetText(employment.label[9], day.." "..mon.." "..yr)
		-- Rank Name
	guiSetText(employment.label[5], rank)
		-- Job Level
	level = rank_data["level"]
		
		-- Job Divisions
	guiComboBoxClear(employment.combobox[1])
	local index = 0
	local div_text
	if (job_data.divisions) then
		div_text = "\n\n— Job Divisions"
		for i,division in ipairs(job_data.divisions) do
			div_text = div_text.."\nLevel "..division[2]..": "..division[1]
			if (rank_data["level"] >= division[2]) then
				guiComboBoxAddItem(employment.combobox[1], division[1])
				index = index + 1	
			end
		end
	else
		guiComboBoxAddItem(employment.combobox[1], job)
		index = 1
	end
	local sx = guiGetSize(employment.combobox[1], false)
	guiSetSize(employment.combobox[1], sx, 27 + 6 + (14*index), false)

		-- Job Uniforms
	orgSkin = getElementModel(localPlayer)
	skinTbl = job_data.skins
	guiComboBoxClear(employment.combobox[2])
	local index = 0
	for i,skin in ipairs(job_data.skins) do
		if (not skin[3]) then
			guiComboBoxAddItem(employment.combobox[2], skin[2].." (ID: "..skin[1]..")")
			skinCache[index] = skin[1]
			index = index + 1
		end
	end
	local sx = guiGetSize(employment.combobox[2], false)
	guiSetSize(employment.combobox[2], sx, 27 + 6 + (14*index), false)
	
		-- Job Description
	local desc = "— "..job.." Job Description\n"
	local desc = desc..job_data.desc
	local desc = desc..(div_text or "")
	local desc = desc.."\n\n— Job Ranks:"
	desc = desc.."\nLevel 0: "..rank_data["ranks"][0].name
	for lvl,tbl in ipairs(rank_data["ranks"]) do
		desc = desc.."\nLevel "..lvl..": "..tbl.name
	end
	
		-- Job Description Scroll Length
	local sx,sy = guiGetSize(employment.label[17], false)
	-- Ignore Lines that are too short
	local excess, pos = 0, 0
	while true do
		local sPos,ePos = string.find(desc, "\n.-\n", pos)
		if (not sPos) then break end
		pos = sPos + 1
		if (ePos - sPos < DESC_COUNT) then
			excess = excess + (ePos - sPos)
		end
	end
	-- Add New Lines to Length
	local lines = math.ceil( ((#string.gsub(desc, "\n", "")-excess) * sx/DESC_COUNT) / DESC_COUNT )
	local pos = 0
	while true do
		local sPos,ePos = string.find(desc,"\n",pos)
		if (not sPos) then break end
		pos,lines = sPos+1, lines+1
	end
	guiSetSize(employment.label[17], sx, 6 + (14*lines), false)
	guiSetText(employment.label[17], desc)
	
		-- Set App Color
	local team = getTeamFromName(job_data.team) or "Civilian Workforce"
	local r,g,b = getTeamColor(team)
	for _,i in ipairs({1, 2, 7, 11, 14, 15}) do
		guiLabelSetColor(employment.label[i], r, g, b)
	end
	
		-- Set GUI Button Text
	if (job ~= getPlayerJob(true)) then
		for i,v in ipairs({true, true, false, false, false}) do
			guiSetVisible(employment.button[i], v)
		end
	else
		for i,v in ipairs({false, false, true, true, true}) do
			guiSetVisible(employment.button[i], v)
		end
	end
		-- Show Panel
	guiSetVisible(employment.window[1], true)
	showCursor(true)
end
addEvent("GTIemployment.sendGUIJobData", true)
addEventHandler("GTIemployment.sendGUIJobData", root, sendGUIJobData)

-- Preview Job Skin
-------------------->>
	
function previewJobSkin()
	local item = guiComboBoxGetSelected(employment.combobox[2])
	selSkin = skinCache[item]
	setElementModel(localPlayer, selSkin)
end
addEventHandler("onClientGUIComboBoxAccepted", employment.combobox[2], previewJobSkin)

function updateSkinList()
	if (not skinTbl[1][3]) then return end
	
	guiComboBoxClear(employment.combobox[2])
	local division = guiComboBoxGetItemText(employment.combobox[1], guiComboBoxGetSelected(employment.combobox[1]))
	local index = 0
	skinCache = {}
	for i,skin in ipairs(skinTbl) do
		if (skin[3] and type(skin[3]) ~= "table") then skin[3] = {skin[3], level} end
		if (skin[3] and skin[3][1] == division and skin[3][2] <= level) then
			guiComboBoxAddItem(employment.combobox[2], skin[2].." (ID: "..skin[1]..")")
			skinCache[index] = skin[1]
			index = index + 1
		end
	end
	local sx = guiGetSize(employment.combobox[2], false)
	guiSetSize(employment.combobox[2], sx, 27 + 6 + (14*index), false)
	selSkin = nil
end
addEventHandler("onClientGUIComboBoxAccepted", employment.combobox[1], updateSkinList)

-- Apply for Job
----------------->>

function setPlayerJob(button, state)
	if (button ~= "left" or state ~= "up") then return end
	if (not selSkin) then
		exports.GTIhud:dm("Select a job skin from the list.", 255, 125, 0)
		return 
	end
	
	local item = guiComboBoxGetSelected(employment.combobox[1])
	if (not item or item == -1) then 
		exports.GTIhud:dm("Select a division from the list.", 255, 125, 0)
		return
	end
	division = guiComboBoxGetItemText(employment.combobox[1], item)
	
	setElementModel(localPlayer, orgSkin)
	local no_event = (source == employment.button[3]) or false
	triggerServerEvent("GTIemployment.setPlayerJob", resourceRoot, jobName, division, selSkin, no_event)
	selSkin, orgSkin, jobName, skinTbl, level = nil, nil, nil, nil, nil
	skinCache = {}
end
addEventHandler("onClientGUIClick", employment.button[1], setPlayerJob, false)
addEventHandler("onClientGUIClick", employment.button[3], setPlayerJob, false)

-- Resign
---------->>

function resign(button, state)
	if (button ~= "left" or state ~= "up") then return end
	triggerServerEvent("GTIemployment.resign", resourceRoot)
end
addEventHandler("onClientGUIClick", employment.button[4], resign, false)

-- Close Panel
--------------->>

function closeJobsPanel(button, state, ignoreSkin)
	if (button ~= "left" or state ~= "up") then return end
	if (ignoreSkin ~= true) then
		setElementModel(localPlayer, orgSkin)
	end
	guiSetVisible(employment.window[1], false)
	showCursor(false)
end
addEventHandler("onClientGUIClick", employment.button[2], closeJobsPanel, false)
addEventHandler("onClientGUIClick", employment.button[5], closeJobsPanel, false)
addEvent("GTIemployment.closeJobsPanel", true)
addEventHandler("GTIemployment.closeJobsPanel", root, closeJobsPanel)

-- Job Exports
--------------->>

function getPlayerJob(isWorking)
	local job = getElementData(localPlayer, "job")
	if (job == "" or not job) then return false end
	
	if (isWorking) then
		local working = getElementData(localPlayer, "isWorking")
		if (working == 1) then
			return job
		else
			return false
		end
	end
	return job
end
