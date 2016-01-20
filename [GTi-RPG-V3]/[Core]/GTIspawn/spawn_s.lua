----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: LilDolla
-- Date: A long time ago
-- Resource: GTIspawn/spawn_s.lua
-- Type: Server Side
----------------------------------------->>

local HOSPITAL_MAX = 2500   -- Max Hospital Cost
local HOSPITAL_MIN = 250    -- Minimum Hospital Cost
local INCOME_PCT = 0.01     -- Percent of Cash that is Hospital Cost

local min_exemptions = {    -- Jobs that always pay minimum
    ["SWAT Division"] = true,
    ["Gangster"] = true,
}

hospitals = {
    --{ x, y, z, rot},
    --LS
    { 1165.552, -1351.513, 15.386, 90, "All Saints"}, --All Saints
    { 2032.7645263672, -1416.2613525391, 16.9921875, 132, "Jefferson"}, --Jefferson
    { 1244.328, 332.483, 19.555, 332, "Montgomery"}, --Montgomery
    { 2269.711, -79.310, 26.557, 180, "Palimino Creek"}, --Palimino Creek
    --{ 854.338, -603.009, 17.421, 0, "Dillimore"}, --Dillimore
    --SF
    { -2198.262, -2307.978, 30.625, 315, "Whetstone"}, --Whetstone
    { -2656.145, 634.109, 14.453, 180, "Santa Flora"}, --Santa Flora
    --LV
    { 1606.321, 1821.576, 10.820, 0, "Las Venturas"}, --LV Airport
    { -1514.930, 2525.289, 55.779, 0, "El Quebrados"}, --El Quebrados
    { -250.253, 2603.548, 62.858, 0, "Las Payasadas"}, --Las Payasadas
    { -322.562, 1058.550, 19.742, 0, "Fort Carson"}, --Fort Carson
    { 101.29, -189.12, 1.2, 180, "Blue Berry"}, -- Blue Berry
}

local jailspawns = {
    --[[
    {207.230, 1472.791, 1703.256, 91,},
    {211.585, 1496.143, 1703.256, 178,},
    {211.843, 1469.289, 1703.256, 95,},
    {192.830, 1457.622, 1703.256, 6,},
    {187.981, 1456.842, 1703.256, 359,},
    {204.155, 1462.571, 1707.300, 91,},
    {183.5, 1481.461, 1703.256, 177,},
    {188.529, 1480.795, 1703.256, 169,},
    {197.413, 1481.058, 1703.256, 179,},
    {183.741, 1478.433, 1707.297, 182,},--]]
    {206.552, 1393.987, 238.256, 360},
    {202.403, 1393.449, 238.256, 360},
    {194.510, 1393.229, 238.256, 360},
    {190.601, 1393.167, 238.256, 360},
    {182.748, 1393.628, 238.256, 360},
    {178.509, 1393.396, 238.256, 360},
    {174.672, 1392.750, 238.256, 360},
}

--[[local groupSpawns = {
	[2] =	{1398.166, 708.09900, 0.130,0	"GHoST"},
	[7] =	{629.8800, -1560.912, 7, 	0, 	"Rude Prawns"}
	[14] = 	{1958.255, -1299.238, 21, 	0, 	"CIA"},
	[82] = 	{1102.955, -307.1740, 74, 	0, 	"TriForce"},
	[618] = {2612.512, 663.23400, 15, 	0, 	"Quality 7"}
}]]
	
local PRISON_INT = 0    -- Prison Interior
local PRISON_DIM = 169   -- Prison Dimension
local suicideTimer = {}

function isPlayerMovementEnabled(player)
    if isControlEnabled(player, "forwards") then
        return true
    else
        return false
    end
end

function setMovementEnabled(player, state)
    if state then
        toggleControl(player, "forwards", true)
        toggleControl(player, "backwards", true)
        toggleControl(player, "left", true)
        toggleControl(player, "right", true)
        setElementFrozen(player, false)
    else
        toggleControl(player, "forwards", false)
        toggleControl(player, "backwards", false)
        toggleControl(player, "left", false)
        toggleControl(player, "right", false)
        setElementFrozen(player, true)
    end
end

function killThePlayer(player, state)
    if state then
        setElementHealth(player, 0)
        setMovementEnabled(player, true)
    else
        setMovementEnabled(player, true)
    end
end

function playerSuicide(source)
    local x, y, z = getElementPosition(source)
    local dim = getElementDimension(source)
    local nearbyPeople = {}
    for index, people in pairs(getElementsByType("player")) do
        local posX, posY, posZ = getElementPosition(people)
        local pdim = getElementDimension(people)
        local job = exports.GTIemployment:getPlayerJob(people)
        if (getDistanceBetweenPoints3D(x, y, z, posX, posY, posZ)) <= 275 then
            if dim == pdim then
                table.insert(nearbyPeople, people)
            end
        end
    end

    if exports.GTIprison:isPlayerInJail(source) then
        exports.GTIhud:dm("You can't commit suicide while being in jail.", source, 255, 25, 25)
        return
    end
    --[[if not isPedOnGround(source) then
        exports.GTIhud:dm("You can't commit suicide if your not on the ground. Your arms are flinging everywhere!",source,255,25,25)
        return
    end]]
    if (exports.GTIpoliceArrest:isPlayerInPoliceCustody(source)) then
        exports.GTIhud:dm("You can't commit suicide while in police custody.", source, 255, 25, 25)
        return
    end

    if exports.freecam:isPlayerFreecamEnabled( source) then
        exports.GTIhud:dm("You can't commit suicide while using freecam.", source, 255, 25, 25)
        return
    end

    if getResourceFromName("GTIcnr") and (getResourceState(getResourceFromName("GTIcnr")) == "running") and (exports.GTIcnr:isPlayerInCnREvent(player)) then return end

    if isPlayerMovementEnabled(source) then
        if exports.GTIpoliceWanted:isPlayerWanted(source) then
            for index, thePeople in pairs(nearbyPeople) do
                local job = exports.GTIemployment:getPlayerJob(thePeople)
                if job == "Police Officer" then
                    if not isPedDead( thePeople) then
                        exports.GTIhud:dm("You can't kill yourself because there is law enforcement nearby.", source, 255, 25, 25)
                        return
                    end
                end
            end
        end
        return suicide(source)
    else
        return suicide(source)
    end
end
addCommandHandler("kill", playerSuicide)


function findNearestHostpital(thePlayer)
    local nearest = nil
    local min = 999999
    if exports.GTIgangTerritories:isGangster(thePlayer) or exports.GTIgangTerritories:isSWAT(thePlayer) then
        return 1606.321, 1821.576, 10.820, 0, "Las Venturas"
    end
	--[[if ( exports.GTIgroups:getPlayerGroup(player) and groupSpawns[exports.GTIgroups:getPlayerGroup(player)] ) then
		return groupSpawns[exports.GTIgroups:getPlayerGroup(player)]
	end]]
    for key,val in pairs(hospitals) do
        if (getElementInterior(thePlayer) ~= 0) then
            local x,y,z = exports.GTIinteriors:getPlayerLastPosition(thePlayer)
            if (x) then
                xx,yy,zz = x,y,z
            else
                xx,yy,zz=getElementPosition(thePlayer)
            end
        else
            xx,yy,zz=getElementPosition(thePlayer)
        end

        local x1=val[1]
        local y1=val[2]
        local z1=val[3]
        local pR=val[4]
        local hN=val[5]
        local dist = getDistanceBetweenPoints2D(xx,yy,x1,y1)
        if dist<min then
            nearest = val
            min = dist
        end
    end
    return nearest[1],nearest[2],nearest[3],nearest[4],nearest[5],nearest[6],nearest[7],nearest[8]
end

function postSpawn(player, hospitalName)
    if isElement(player) then
        local name  = getPlayerName(player)
        if name then
            --exports.GTIhud:dqm("hospitalSpawn", "You were revived at the "..hospitalName.." Hospital", player, 255, 232, 133, 2500)
            --exports.GTIhud:dm("You were revived at the "..hospitalName.." Hospital", player, 255, 232, 133)
            --exports.GTIsocial:logSocialMessage(name, "You were revived at the "..hospitalName.." Hospital", "brief", 4, "Briefing", "Player Movement", "player")
            setCameraTarget(player)
        end
    end
end

--[[
addEvent("onKillerInteriorChange", true)
addEventHandler("onKillerInteriorChange", root,
function (killer )
    killCamIntChange = setTimer(
        function()
            if not isElement(killer) then
                if isTimer(killCamIntChange) then
                    killTimer(killCamIntChange)
                end
            end
            if not isElement(source) then
                if isTimer(killCamIntChange) then
                    killTimer(killCamIntChange)
                end
            end
            if isElement(killer) and isElement(source) then
                local killerInt = getElementInterior(killer)
                local victimInt = getElementInterior(source)
                local killerDim = getElementDimension(killer)
                local victimDim = getElementDimension(source)
                if victimInt ~= killerInt then
                    if isPedDead(source) then
                        setElementInterior(source, killerInt)
                        setElementDimension(source, killerDim)
                    else
                        if isTimer(killCamIntChange) then
                            killTimer(killCamIntChange)
                        end
                    end
                end
            else
                if isTimer(killCamIntChange) then
                    killTimer(killCamIntChange)
                end
            end
        end, 1000, 0
    )
end
)

function updateInterior(killer)
    local int = getCameraInterior(killer)
    setCameraInterior(killer, int)
    outputChatBox("test", killer)
end
--]]


function onPlayerDeath(totalAmmo, killer, killerWeapon, bodypart)
    if (isElement(totalAmmo)) then source = totalAmmo end
    local xx,yy,zz,rot, hName = findNearestHostpital(source)
    local instant_respawn = exports.GTIpremium:isPremium(source, "inst_respawn")
    if (not instant_respawn and isElement(killer) and killer ~= source) then
        setTimer(fadeCamera, 2000, 1, source, false, 1, 0, 0, 0)
        setTimer(fadeCamera, 3000, 1, source, true, 2)
        setTimer(setCameraTarget, 3000, 1, source, killer)
        spawnTime = 15000
        fadeTime1 = 14000
        fadeTime2 = 15000
    elseif (instant_respawn) then
        spawnTime = 3000
        fadeTime1 = 2000
        fadeTime2 = 3000
    else
        spawnTime = 5000
        fadeTime1 = 4000
        fadeTime2 = 5000
    end
    setTimer(spawnPlayer, spawnTime, 1, source, xx, yy, zz, rot)
    setTimer(postSpawn, spawnTime, 1, source, hName)
    setTimer(function(player) if not isElement(player) then return end fadeCamera(player,false,1,0,0,0) end, fadeTime1, 1, source)
    setTimer(function(player) if not isElement(player) then return end fadeCamera(player,true,2) end, fadeTime2, 1, source)
end
addEventHandler("onPlayerWasted", root, onPlayerDeath)

function onStart()
    for k,v in ipairs(getElementsByType("player")) do
        if isPedDead(v) then    
            onPlayerDeath(v)
        end
    end
end
addEventHandler("onResourceStart",resourceRoot,onStart)

_spawnPlayer = spawnPlayer

function spawnPlayer(player,x,y,z,rot)
    if isElement(player) then
        if (exports.GTIprison:isPlayerInJail(player)) then
            local loc = math.random(#jailspawns)
            local pos = jailspawns[loc]
            _spawnPlayer(player, pos[1], pos[2], pos[3], pos[4], getElementModel(player), PRISON_INT, PRISON_DIM, getPlayerTeam(player))

            if (exports.GTIpremium:isPremium(player, "25_armor_spawn")) then
                setPedArmor(player, 25)
            elseif (exports.GTIpremium:isPremium(player, "50_armor_spawn")) then
                setPedArmor(player, 50)
            elseif (exports.GTIpremium:isPremium(player, "100_armor_spawn")) then
                setPedArmor(player, 100)
            end
        else
            _spawnPlayer(player,x,y,z,rot,getElementModel(player),0,0,getPlayerTeam(player))

            -- Exempt Turfers
            if (exports.GTIgangTerritories:canPlayerTurf(player, true)) then return end
            
            if (exports.GTIpremium:isPremium(player, "25_armor_spawn")) then
                setPedArmor(player, 25)
            elseif (exports.GTIpremium:isPremium(player, "50_armor_spawn")) then
                setPedArmor(player, 50)
            elseif (exports.GTIpremium:isPremium(player, "100_armor_spawn")) then
                setPedArmor(player, 100)
            end

            -- Exempt Kill Arrests
            if ((exports.GTIaccounts:GAD(getPlayerAccount(player), "jail_time") or 0) > 0) then return end
            
            -- Charge Player
            local cost = getPlayerMoney(player) * INCOME_PCT
            if (cost > HOSPITAL_MAX) then cost = HOSPITAL_MAX
            elseif (cost < HOSPITAL_MIN) then cost = HOSPITAL_MIN 
            end

            if (getPlayerMoney(player) < cost) then
                setElementHealth(player, 50)
                exports.GTIhud:dm("You do not have enough money to afford your medical bill! Only 50% of your health was restored.", player, 255, 125, 0)
            else
                exports.GTIbank:TPM(player, cost, "Hospital Bill")
            end
        end
    end
end
