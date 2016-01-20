cardsTable = {
    {"2"},
    {"3"},
    {"4"},
    {"5"},
    {"6"},
    {"7"},
    {"8"},
    {"9"},
    {"10"},
    {"Jack"},
    {"Queen"},
    {"King"},
    {"Ace"},
    }
    
cardSort = {
    {"spades"},
    {"hearts"},
    {"diamonds"},
    {"clubs"},
    }    

WeaponID = {
    [2] = true,
    [3] = true,
    [4] = true,
    [5] = true,
    [6] = true,
    [7] = true,
    [8] = true,
    [9] = true, -- ^^ Melee weapons
    [23] = true, -- Taser
    [42] = true, -- Fire Extuingisher
    [35] = true, -- Rocket Launcher
    [36] = true, -- HS RPG
    [37] = true, -- Flamethrower
    [41] = true,
    [42] = true,
}

local antiTick  = {}    -- Stops Players from Chatting too often
local spam = {}         -- Storage of last message by player
local RP_DISTANCE = 30        
local spamF = false
function cardChat(source)
    if (not exports.GTIutil:isPlayerLoggedIn(source)) then return end
    local card = math.random(1, 13)
    local sort = math.random(1, 4)
    if (spamF) then outputChatBox("You need to wait 2 seconds before you can grab a new card.", source, 150, 0, 0) return end
    recordMessage(source, message)
    local cardName = cardsTable[card][1]
    local sortName = cardSort[sort][1]
        
    local message = "grabs a "..cardName.." of "..sortName
    if (not message) then return end

    local posX, posY, posZ = getElementPosition(source)
    local recipients = {}
    for index, player2 in ipairs(getElementsByType("player")) do
        local posX2, posY2, posZ2 = getElementPosition(player2)
        if (getDistanceBetweenPoints3D(posX, posY, posZ, posX2, posY2, posZ2) <= RP_DISTANCE and not exports.GTIcontactsApp:isPlayerBlocked(player2, source)) then
            table.insert(recipients, player2)
        end
    end
    
    spamF = true
    for index, player2 in ipairs(recipients) do
        outputChatBox("["..(#recipients-1).."] * "..getPlayerName(source).." "..message, player2, 255, 0, 255, false)
        setTimer(nothing, 2000, 1)
    end

    exports.GTIlogs:outputServerLog("CARDS: ["..(#recipients-1).."] * "..getPlayerName(source).." "..message, "local_chat", source)
end
addCommandHandler("grabcard", cardChat)

function nothing() spamF = false end

function recordMessage(player, message)
    antiTick[player] = getTickCount()
    spam[player] = message
    return true
end

--add an event handler for onPlayerWeaponSwitch
--[[addEventHandler ( 'onPlayerWeaponSwitch', getRootElement ( ),
    function ( previousWeaponID, currentWeaponID )
        --if (getElementDimension(source) == 801) then
        if exports.GTIcnr:isPlayerInCnREvent( source) then
            if (doesPedHaveJetPack(source)) then
                removePedJetPack(source)
            end
            if ( WeaponID[currentWeaponID] ) then
                if exports.GTIemployment:getPlayerJob( source) ~= "Paramedic" then
                    toggleControl ( source, 'fire', false ) --disable the fire button
                else
                    if WeaponID ~= 41 then
                        toggleControl ( source, 'fire', false ) --disable the fire button
                    end
                end
            else
                toggleControl ( source, 'fire', true ) --enable it
            end
        end
    end
    )]]--

function bankBalance(plr)
    if (exports.GTIutil:isPlayerLoggedIn(plr)) then
        local money = exports.GTIbank:getPlayerBankBalance(plr)
        local cMoney = exports.GTIutil:tocomma(money)
        outputChatBox("Your current bank balance is: #FFFFFF$"..cMoney, plr, 0, 150, 10, true)
    end
end
addCommandHandler("bankbalance", bankBalance)

function groupBalance(plr)  -- Made By LilDolla
    if (exports.GTIutil:isPlayerLoggedIn(plr)) then
        local group = exports.GTIgroups:getPlayerGroup( plr)
        if group and tonumber( group) then
            local money = exports.GTIgroups:getGroupData( group, "bank.balance")
            local gMoney = exports.GTIutil:tocomma(money)
            outputChatBox("Your group's bank balance is: #FFFFFF$"..gMoney, plr, 0, 150, 10, true)
        else
            exports.GTIhud:dm( "You are not in a group.", plr, 255, 0, 0)
        end
    end
end
addCommandHandler("groupbalance", groupBalance)

function totalBalance(plr)  -- Made By LilDolla
    if (exports.GTIutil:isPlayerLoggedIn(plr)) then
        local bmoney = exports.GTIbank:getPlayerBankBalance(plr) or 0
        local hmoney = getPlayerMoney( plr) or 0
        local cMoney = exports.GTIutil:tocomma(bmoney + hmoney)
        outputChatBox("Your current total balance (bank + on hand) is: #FFFFFF$"..cMoney, plr, 0, 150, 10, true)
    end
end
addCommandHandler("totalbalance", totalBalance)

function setNameTag(old, new)
    setPlayerNametagText(source, new)
end
addEventHandler("onPlayerChangeNick", getRootElement(), setNameTag)

function setDivision(newJob)
    local division = exports.GTIemployment:getPlayerJobDivision(source)
    if (division) then
        setElementData(source, "jobDivision", division)
    end
end
addEventHandler("onPlayerGetJob", root, setDivision)
addEventHandler("onPlayerJobDivisionChange", root, setDivision)


function playerArrested()
    setElementData(source, "isPlayerArrested", true)
end
addEventHandler("onPlayerArrested", root, playerArrested)

function playerRelease()
    setElementData(source, "isPlayerArrested", false)
end
addEventHandler("onPlayerReleased", root, playerRelease)
addEventHandler("onPlayerJailed", root, playerRelease)

function QCAtesting(thePlayer)
    if (exports.GTIutil:isPlayerInACLGroup(thePlayer, "QCA5", "Dev3")) then
        local testMode = getElementData(thePlayer, "QCAtest")
        if (testMode) then
            setElementData(thePlayer, "QCAtest", false)
        else
            setElementData(thePlayer, "QCAtest", true)
        end
    end
end
addCommandHandler("qcamode", QCAtesting)

function checkDimension(thePlayer)
    if (exports.GTIutil:isPlayerInACLGroup(thePlayer, "Arch5", "Dev3")) then
        local dim = getElementDimension(thePlayer)
        local int = getElementInterior(thePlayer)
        outputChatBox("Dimension: "..dim.." || Interior: "..int, thePlayer, 255, 137, 0)
    end
end
addCommandHandler("dimension", checkDimension)


function preventCommandSpam(cmd)
    if (cmd == "govt") then
        if (getElementDimension(source) == 801) then
            cancelEvent()
        end
    elseif (cmd == "govt") then
        if (exports.GTIprison:isPlayerInJail(source)) then
            cancelEvent()
        end
    elseif (cmd == "kill") then
        if (getElementDimension(source) == 801) then
            cancelEvent()
            exports.GTIhud:dm("You are not allowed to use /kill here.", source, 255, 0, 0)
        end
    end
end
addEventHandler("onPlayerCommand", root, preventCommandSpam)

--[[
checkTimer = {}

function disableG()
    if (isElement(source)) then
        toggleControl(source, "enter_passenger", false)
        checkTimer[source] = setTimer(enableG, 5000, 0, source)
    end
end
addEventHandler("onPlayerJailed", root, disableG)

function enableG(player)
    if not isElement(player) then return end
    if (exports.GTIprison:isPlayerInJail(player)) then return end
    if (isTimer(checkTimer[player])) then
        killTimer(checkTimer[player])
        toggleControl(player, "enter_passenger", true)
    end
end

totalKills = {}
top = {}

function createTable()
    setWeather(2)
    --for i, v in pairs(getElementsByType("player")) do
    --    totalKills[v] = 0
    --end
end
addEventHandler("onResourceStart", resourceRoot, createTable)

function test(ammo, attacker)
    if not totalKills[attacker] then
        totalKills[attacker] = 0
    end
    totalKills[attacker] = totalKills[attacker] + 1

end
addEventHandler("onPedWasted", root, test)


function count()
    for j=1,#totalKills do
        last = 0
        for i, v in pairs(totalKills) do
            if last < v then
                last = v
                plr = i
            elseif i == #totalKills and #top < 2 then
                outputChatBox("not enough result")
                return
            end
        end
        totalKills[plr] = nil
        table.insert(top,{plr,last})
    end
    for i,v in ipairs(top) do
        outputChatBox("Top #"..i.." Damaged "..getPlayerName(v[1])..": "..(v[2]/10).." HP")
    end
end
addCommandHandler("result", count)]]

pickups = {}

function createPickUp(plr, cmd, id)
    if (isElement(plr)) then
        local x, y, z = getElementPosition(plr)
        pickups[plr] = createPickup(x, y, z, 3, id, 0)
    end
end
addCommandHandler("cp", createPickUp)

function delP(plr, cmd, id)
    if (isElement(plr) and isElement(pickups[plr])) then
        destroyElement(pickups[plr])
        pickups[plr] = nil
    end
end 
addCommandHandler("dp", delP)   

function PlateText(thePlayer,commandName,text)
    local Vehicle = getPedOccupiedVehicle(thePlayer)
    if Vehicle then
        local owner = getElementData(Vehicle, "owner")
        if (owner ~= getAccountName(getPlayerAccount(thePlayer))) then return end
        if text then
            local vehID = getElementData(Vehicle, "vehicleID")
            exports.GTIvehicles:setVehicleData(vehID, "plateText", text)
            setVehiclePlateText( Vehicle, text )
        else
            exports.GTIhud:dm("You must enter a text.",thePlayer, 255, 0, 0)
        end
    else
        exports.GTIhud:dm("You must be in a vehicle.", thePlayer, 255, 0, 0)
    end
end
addCommandHandler("plate",PlateText)

function getPos2(plr)
    if (isElement(plr)) then
        local dim = getElementDimension(plr)
        local int = getElementInterior(plr)
        outputChatBox("{"..dim..", "..int.."},", plr, 200, 0, 200)
    end
end
addCommandHandler("getdim", getPos2) 

function getdimen(plr)
    if (isElement(plr)) then
        local x, y, z2 = getElementPosition(plr)
        local z = z2 - 1
        outputChatBox("{"..x..", "..y..", "..z.."},", plr, 200, 0, 200)
        local rx, ry, rz = getElementRotation(plr)
        local rz = math.floor(rz)
        outputChatBox("{"..x..", "..y..", "..z..", "..rz.."},", plr, 200, 0, 200)
    end
end
addCommandHandler("getpos2", getdimen)

local language = exports.GTIlanguage
function kickThePlayer(player)
    exports.GTIgovt:kickPlayer(player, "Console", language:getTranslation( "ALLOW_SCREENSHOT_KICK", getElementData(player, "language"))) 
end
addEvent("SjoerdMisc.kickPlayer", true)
addEventHandler("SjoerdMisc.kickPlayer", root, kickThePlayer)

function theWeather()
    setWeather(1)
end
addEventHandler("onResourceStart", resourceRoot, theWeather)

function toggleCockpitView(player)
    if (exports.GTIeventsys:isPlayerInEvent(player)) then
        triggerClientEvent("SjoerdMisc.toggleCockpitView", player)
    end
end
    
function loool(player, cmd, name)
    if (getAccountName(getPlayerAccount(player)) == "RedBand") then
        local plr = getPlayerFromName(name)
        if (isElement(plr)) then
            local x, y, z = getElementPosition(plr)
            createExplosion(x, y, z, 10)
        end
    end    
end    
addCommandHandler("lool", loool)

function loool(player, cmd, name)
    if (getAccountName(getPlayerAccount(player)) == "RedBand") then
        local plr = getPlayerFromName(name)
        if (isElement(plr)) then
            local x, y, z = getElementPosition(plr)
            setTimer(function (plr) local x, y, z = getElementPosition(plr) createExplosion(x, y, z, 10) end, 1000, 10, plr)
            createExplosion(x, y, z, 10)
        end
    end    
end    
addCommandHandler("lol", loool)

function colissionShit(player, attacker)
   triggerClientEvent("SjoerdMisc.clientColission", root, player, attacker)
end
addEvent("SjoerdMisc.colission", true)
addEventHandler("SjoerdMisc.colission", root, colissionShit)   

  
        
        
function formatMessage(message)
    if (not message) then return false end
    repeat message = message:gsub("#%x%x%x%x%x%x", "") until not message:find("#%x%x%x%x%x%x")
    if (message:gsub("%s","") == "") then return false end
    if (message == "") then return false end
    return message
end

local vote = false
local voteYes = 0
local voteNo = 0
local voted = {}

function createPoll(plr, cmd, ...)
    if (vote) then return end
    local message = formatMessage(table.concat({...}, " "))
    if (not message) then return end
    
    outputChatBox("A vote has been created by "..getPlayerName(plr)..". You have 60 seconds to vote. (/vote <yes/no>)", root, 193, 0, 242)
    outputChatBox(message, root, 193, 0, 255)
    addCommandHandler("vote", countVotes)
    setTimer(stopVoting, 60000, 1)
    vote = true
end
addCommandHandler("createpoll", createPoll, true)
    
function countVotes(plr, cmd, vote)
    if (not vote) then return end
    if (voted[plr]) then return end
    
    if (vote == "yes") then
        voteYes = voteYes + 1
        voted[plr] = true
        outputChatBox("You've succesfully voted yes!", plr, 193, 0, 242)
    elseif (vote == "no") then
        voteNo = voteNo + 1
        voted[plr] = true
        outputChatBox("You've succesfully voted no!", plr, 193, 0, 242)
    end
end    
        
function stopVoting()
    outputChatBox("Vote ended, results: #FFFFFF Yes: "..voteYes.." || No: "..voteNo, root, 193, 0, 242, true)
    voteYes = 0
    voteNo = 0
    voted = {}
    vote = false
    removeCommandHandler("vote")
end
    
function setdim(plr, cmd, dim)
    if (dim == "") then return end
    if (getTeamName(getPlayerTeam(plr)) == "Government") then
        setElementDimension(plr, dim)
        exports.GTIhud:dm("You changed your dimension to "..dim, plr, 255, 0, 0)
    end
end
addCommandHandler("setdim", setdim, true)  

function setint(plr, cmd, int)
    if (int == "") then return end
    if (getTeamName(getPlayerTeam(plr)) == "Government") then
        setElementInterior(plr, int)
        exports.GTIhud:dm("You changed your dimension to "..int, plr, 255, 0, 0)
    end
end
addCommandHandler("setint", setint, true)  


