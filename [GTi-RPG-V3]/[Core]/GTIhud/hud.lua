----------------------------------------->>
-- GTI: Grand Theft International
-- Date: 08 Dec 2013
-- Resource: GTIhud/hud.lua
-- Type: Client Side
-- Author: JT Pennington (JTPenn)
----------------------------------------->>

local sX,sY = guiGetScreenSize()
hudEnabled = nil	-- Is the Hud Enabled?

local SAFEZONE_X = sX*0.05
local SAFEZONE_Y = sY*0.05
local SERVER_NAME = "Grand Theft International (GTI) | gtirpg.net | "..#getElementsByType("player").."/"..getElementData(root, "max_players").." Players"

local disabledHUD = {"health", "armour", "breath", "clock", "money", "weapon", "ammo", "vehicle_name", "area_name", "wanted"} 
	-- Replaced HUD Components

local game_time	= ""	-- Game Date and Time
local date_ = ""		-- Client Date and Time
local uptime = getRealTime().timestamp
	-- Client Uptime

local healthTimer = setTimer(function() end, 1000, 0)
	-- Timer that makes health flash

-- Toggle HUD
-------------->>
addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function (setting, oldVal, newVal)
		local setting = exports.GTIsettings:getSetting("hud")
		if (not hudEnabled) and (setting == "GTI Hud")  then
			for i,hud in ipairs(disabledHUD) do
				showPlayerHudComponent(hud, false)
			end
			hudEnabled = true
		elseif ( hudEnabled ) and ( setting == "GTA Hud" ) then
				for i,hud in ipairs(disabledHUD) do
					showPlayerHudComponent(hud, true)
				end
			hudEnabled = nil
		else -- if not, set it as default (GTI's hud)
			for i,hud in ipairs(disabledHUD) do
				showPlayerHudComponent(hud, false)
			end
			hudEnabled = true
		end
	end
)

addEventHandler("onClientResourceStart", resourceRoot, function()
	for i,hud in ipairs(disabledHUD) do
		showPlayerHudComponent(hud, false)
	end
	hudEnabled = true
end)

-- HUD Exports
--------------->>

local enabledHud = {"radar", "radio", "crosshair"}
function showHud()
	if (isCustomHudEnabled()) then
		showPlayerHudComponent("all", false)
		for i,hud in ipairs(enabledHud) do
			showPlayerHudComponent(hud, true)
		end
	else
		showPlayerHudComponent("all", true)
	end
end
addEvent("GTIhud.showHud", true)
addEventHandler("GTIhud.showHud", root, showHud)

function isCustomHudEnabled()
	return hudEnabled or false
end

-- Health
---------->>

function renderHealth()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	
	local health = getElementHealth(localPlayer)
	local maxHealth = getPedStat(localPlayer, 24)
	local maxHealth = (((maxHealth-569)/(1000-569))*100)+100
	local healthStat = health/maxHealth
	
	local r1,g1,b1, r2,g2,b2, a
	if (healthStat > 0.25) then
		r1,g1,b1 = 180,25,29
		r2,g2,b2 = 90,12,14
		a = 200
	else
		r1,g1,b1 = 180,25,29
		r2,g2,b2 = 90,12,14
		
		local aT = getTimerDetails(healthTimer)
		if (aT > 500) then
			a = (aT-500)/500*200
		else
			a = (500-aT)/500*200
		end
	end
	
	local dX,dY,dW,dH = sX-150,0,150,15
	local dX,dY,dW,dH = sX-150-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-147,3,144,9
	local dX,dY,dW,dH = sX-147-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(r2,g2,b2,200) )
	dxDrawRectangle( dX+dW-(healthStat*dW),dY,healthStat*dW,dH, tocolor(r1,g1,b1,a) )
end
addEventHandler("onClientRender", root, renderHealth)

-- Armor
--------->>

function renderArmor()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	
	local armor = getPedArmor(localPlayer)
	local oxygen = getPedOxygenLevel(localPlayer)
	if (oxygen < 1000) then return end
	local armorStat = armor/100
	
	local r1,g1,b1, r2,g2,b2
	r1,g1,b1 = 225,225,225
	r2,g2,b2 = 112,112,112
	
	local dX,dY,dW,dH = sX-222,0,72,15
	local dX,dY,dW,dH = sX-222-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-219,3,69,9
	local dX,dY,dW,dH = sX-219-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(r2,g2,b2,200) )
	dxDrawRectangle( dX+dW-(armorStat*dW),dY,armorStat*dW,dH, tocolor(r1,g1,b1,200) )
end
addEventHandler("onClientRender", root, renderArmor)

-- Oxygen
---------->>

function renderOxygenLevel()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	
	local oxygen = getPedOxygenLevel(localPlayer)
	if (oxygen >= 1000) then return end
	local oxygenStat = oxygen/1000
	
	local r1,g1,b1, r2,g2,b2
	r1,g1,b1 = 172,203,241
	r2,g2,b2 = 86,101,120
	
	local dX,dY,dW,dH = sX-222,0,72,15
	local dX,dY,dW,dH = sX-222-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(0,0,0,200) )
	local dX,dY,dW,dH = sX-219,3,69,9
	local dX,dY,dW,dH = sX-219-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawRectangle( dX,dY,dW,dH, tocolor(r2,g2,b2,200) )
	dxDrawRectangle( dX+dW-(oxygenStat*dW),dY,oxygenStat*dW,dH, tocolor(r1,g1,b1,200) )
end
addEventHandler("onClientRender", root, renderOxygenLevel)

-- Ping/FPS Meter
------------------>>

local FPScount = 0
local ping = 0
local fps = 0
function updatePingAndFPS()
	ping = getPlayerPing(localPlayer)
	fps = FPScount
	FPScount = 0
end
setTimer(updatePingAndFPS, 1000, 0)

function renderFPSandPing()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	FPScount = FPScount + 1
	
	if (not ping or not fps) then return end
	local dX,dY,dW,dH = sX-5,20,sX-5,20
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText("Ping: "..ping.." | FPS: "..fps, dX+1,dY,dW+1,dH, tocolor(0,0,0,100), 1, "clear", "right", "top")
	dxDrawText("Ping: "..ping.." | FPS: "..fps, dX,dY+1,dW,dH+1, tocolor(0,0,0,100), 1, "clear", "right", "top")
	dxDrawText("Ping: "..ping.." | FPS: "..fps, dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "right", "top")
end
addEventHandler("onClientRender", root, renderFPSandPing)

-- Game Time
------------->>

function updateGameTime()
	local hrs,mins = getTime()
	local ampm = "am"
	if (hrs >= 12) then ampm = "pm" end
	if (hrs == 0) then hrs = 12 end
	if (hrs > 12) then hrs = hrs - 12 end
	if (hrs < 10) then hrs = "0"..hrs end
	if (mins < 10) then mins = "0"..mins end
	
	game_time = hrs..":"..mins.." "..ampm
end
setTimer(updateGameTime, 1000, 0)

function renderGameTime()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
		
	local dX,dY,dW,dH = sX-222,20,sX-222+75,20
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText(game_time, dX+1,dY,dW+1,dH, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText(game_time, dX,dY+1,dW,dH+1, tocolor(0,0,0,100), 1, "clear", "center")
	dxDrawText(game_time, dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "center")
end
addEventHandler("onClientRender", root, renderGameTime)

-- Wanted Level
---------------->>

local wantedOff = 0
function renderWantedLevel()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	local wanted = getPlayerWantedLevel()
	if (wanted == 0) then wantedOff = 0 return end
	wantedOff = 35
	
	local DIST_BTWN_STARS = 216/6
	local dX,dY,dW,dH = sX-33,37,30,29
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	
	active = "wanted/wanted_active2.png"
	
	local total_stars = 0
	local active_stars = 0
	for i=1,wanted do
		dxDrawImage(dX-(total_stars*DIST_BTWN_STARS), dY, dW, dH, active)
		total_stars = total_stars + 1
		active_stars = active_stars + 1
	end
	for i=1,6-active_stars do
		dxDrawImage(dX-(total_stars*DIST_BTWN_STARS), dY, dW, dH, "wanted/wanted_inactive.png")
		total_stars = total_stars + 1
	end
end
addEventHandler("onClientRender", root, renderWantedLevel)

-- Money
--------->>

local moneyY = 0
function renderMoney()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	
	local cash = getPlayerMoney()
	cash = "$"..exports.GTIutil:tocomma(cash)
	
	local r1,g1,b1
	if (getPlayerMoney() >= 0) then
		r1,g1,b1 = 54,104,44
	else
		cash = string.gsub(cash, "%D", "")
		cash = "-$"..exports.GTIutil:tocomma(cash)
		r1,g1,b1 = 180,25,29
	end
		
	local dX,dY,dW,dH = sX-6,35+moneyY+wantedOff,sX-6,30
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText(cash, dX+2,dY,dW+2,dH, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText(cash, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText(cash, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText(cash, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.35, "pricedown", "right")
	dxDrawText(cash, dX,dY,dW,dH, tocolor(r1,g1,b1,255), 1.35, "pricedown", "right")
end
addEventHandler("onClientRender", root, renderMoney)

-- Show +/- Money
------------------>>

local cashAmt = 0
local r,g,b = 0,0,0
local pmTimer
local pm = ""
function showPlusMoney(amount)
    if (isTimer(pmTimer) and pm == "-") then
           cashAmt = cashAmt + amount
           if (cashAmt < 0) then
            cashAmt = cashAmt - cashAmt - cashAmt
                pm = "-"
                mr,mg,mb = 180,80,90
           elseif (cashAmt > 0) then
                pm = "+"
                mr,mg,mb = 110,150,125
           end
    else
        cashAmt = cashAmt + amount
        pm = "+" 
        mr,mg,mb = 110,150,125
    end   
    if (isTimer(pmTimer)) then killTimer(pmTimer) pmTimer = nil end
    pmTimer = setTimer(function() cashAmt = 0 pmTimer = nil end, 5000, 1)
end
addEvent("onClientPlayerGiveMoney", true)
addEventHandler("onClientPlayerGiveMoney", localPlayer, showPlusMoney)

function showMinusMoney(amount)
    if (isTimer(pmTimer) and pm == "+") then
           cashAmt = cashAmt - amount
           if (cashAmt < 0) then
                cashAmt = cashAmt - cashAmt - cashAmt
                pm = "-"
                mr,mg,mb = 180,80,90
           elseif (cashAmt > 0) then
                pm = "+"
                mr,mg,mb = 110,150,125
           end
    else
        cashAmt = cashAmt + amount
        pm = "-" 
        mr,mg,mb = 180,80,90   
    end         
           
           
    if (isTimer(pmTimer)) then killTimer(pmTimer) pmTimer = nil end
    pmTimer = setTimer(function() cashAmt = 0 pmTimer = nil end, 5000, 1)
end
addEvent("onClientPlayerTakeMoney", true)
addEventHandler("onClientPlayerTakeMoney", localPlayer, showMinusMoney)

local monA = 0
function renderPlusMinusMoney()
    if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
    
    if (cashAmt == 0 or not pmTimer) then return end
    local cash = exports.GTIutil:tocomma(cashAmt)
    
    local timeLeft = getTimerDetails(pmTimer)
    if (timeLeft > 4750) then
        monA = ((5000-timeLeft)/250) * 255
    elseif (timeLeft < 250) then
        monA = (timeLeft/250) * 255
    end
    
    local dX,dY,dW,dH = sX-6,70+moneyY+wantedOff,sX-6,30
    local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
    dxDrawText(pm.."$"..cash, dX+2,dY,dW+2,dH, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
    dxDrawText(pm.."$"..cash, dX,dY+2,dW,dH+2, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
    dxDrawText(pm.."$"..cash, dX-2,dY,dW-2,dH, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
    dxDrawText(pm.."$"..cash, dX,dY-2,dW,dH-2, tocolor(0,0,0,monA), 1.25, "pricedown", "right")
    dxDrawText(pm.."$"..cash, dX,dY,dW,dH, tocolor(mr,mg,mb,monA), 1.25, "pricedown", "right")
end
addEventHandler("onClientRender", root, renderPlusMinusMoney)

-- Weapons
----------->>

function renderWeapons()
	if (not isPlayerHudComponentVisible("radar") or isPlayerMapVisible() or not hudEnabled) then return end
	
	local weapon = getPedWeapon(localPlayer)
	local clip = getPedAmmoInClip(localPlayer)
	local ammo = getPedTotalAmmo(localPlayer)
	if (weapon == 0 or weapon == 1 or ammo == 0) then moneyY = 0 return end
	moneyY = 35
		
	local len = #tostring(clip)
	if string.find(tostring(clip), 1) then len = len - 0.5 end
	local xoff = (len*17) + 10
	
	local len2 = #tostring(ammo-clip)
	if string.find(tostring(ammo-clip), 1) then len2 = len2 - 0.5 end
	local weapLen = ((len+len2)*17) + 20
	
	if (weapon >= 15 and weapon ~= 40 and weapon <= 44 or weapon >= 46) then
			-- Ammo in Clip
		local dX,dY,dW,dH = sX-6,35+wantedOff,sX-6,30
		local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
		dxDrawText(clip, dX+2,dY,dW+2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(clip, dX,dY,dW,dH, tocolor(110,110,110,255), 1.25, "pricedown", "right")
			-- Total Ammo
		local dX,dY,dW,dH = sX-6-xoff,35+wantedOff,sX-6-xoff,30
		local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
		dxDrawText(ammo-clip, dX+2-xoff,dY,dW+2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY+2,dW,dH+2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX-2,dY,dW-2,dH, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY-2,dW,dH-2, tocolor(0,0,0,255), 1.25, "pricedown", "right")
		dxDrawText(ammo-clip, dX,dY,dW,dH, tocolor(220,220,220,255), 1.25, "pricedown", "right")
	else
		xoff = 0
		weapLen = 0
	end
	--[[
	local weapName = getWeaponNameFromID(weapon)
	local dX,dY,dW,dH = sX-6,110,sX-6,125
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW-SAFEZONE_X, dH+SAFEZONE_Y
	dxDrawText(weapName, dX+1,dY,dW+1,dH, tocolor(0,0,0,100), 1, "clear", "right")
	dxDrawText(weapName, dX,dY+1,dW,dH+1, tocolor(0,0,0,100), 1, "clear", "right")
	dxDrawText(weapName, dX,dY,dW,dH, tocolor(255,255,255,255), 1, "clear", "right")
	--]]
	if (weapon == 0 or weapon == 1) then return end
	local img = "weaps/"..weapon..".png"
	local dX,dY,dW,dH = sX-133-weapLen,35+wantedOff,128,40
	local dX,dY,dW,dH = dX-SAFEZONE_X, dY+SAFEZONE_Y, dW, dH
	dxDrawImage(dX, dY, dW, dH, img)	
end
addEventHandler("onClientRender", root, renderWeapons)

-- GTI Version
--------------->>

function renderGTIVersion()
	local dX,dY,dW,dH = sX-87,sY,sX-87,sY
	dxDrawText(SERVER_NAME.." |", dX,dY,dW,dH, tocolor(255,255,255,100), 1, "default", "right", "bottom")
end
addEventHandler("onClientRender", root, renderGTIVersion)

setTimer(function()
	SERVER_NAME = "Grand Theft International (GTI) | gtirpg.net | "..#getElementsByType("player").."/"..getElementData(root, "max_players").." Players"
end, 15000, 0)

-- Your Date and Time
---------------------->>

function updateDateAndTime()
	local t = getRealTime()
	local day = t.monthday
	if (day < 10) then day = "0"..day end
	local hr = t.hour
	if (hr < 10) then hr = "0"..hr end
	local mins = t.minute
	if (mins < 10) then mins = "0"..mins end
	local sec = t.second
	if (sec < 10) then sec = "0"..sec end
	
	local uptime_ = t.timestamp - uptime
	local hrs_, mins_, secs_ = exports.GTIutil:totime(uptime_)
	if (hrs_ < 10) then hrs_ = "0"..hrs_ end
	if (mins_ < 10) then mins_ = "0"..mins_ end
	if (secs_ < 10) then secs_ = "0"..secs_ end
	date_ = day.." "..exports.GTIutil:getMonthName(t.month+1).." "..(t.year+1900).." — "..hr..":"..mins..":"..sec.." (Online: "..hrs_..":"..mins_..":"..secs_..")"
end
setTimer(updateDateAndTime, 1000, 0)

function renderDateAndTime()
	local dX,dY,dW,dH = sX-5,sY-15,sX-5,sY-15
	dxDrawText(date_, dX,dY,dW,dH, tocolor(255,255,255,100), 1, "default", "right", "bottom")
end
addEventHandler("onClientRender", root, renderDateAndTime)
