function disableClouds()
    if (exports.GTIaccounts:isPlayerLoggedIn()) then
        setCloudsEnabled(false)
    end
end
addCommandHandler("disableclouds", disableClouds)


function disableClouds()
    if (exports.GTIaccounts:isPlayerLoggedIn()) then
        setHeatHaze ( 0 )
    end
end
addCommandHandler("disablehh", disableClouds)


function cancelDamage(attacker, wep, part, loss)
    if (getElementDimension(source) == 801 or getElementDimension(source) == 5) then
        if (exports.GTIUtil:isPlayerInTeam(source, "Criminals") and exports.GTIUtil:isPlayerInTeam(attacker, "Criminals")) then
            cancelEvent(true)
        elseif (exports.GTIUtil:isPlayerInTeam(source, "Emergency Services") and exports.GTIUtil:isPlayerInTeam(attacker, "Criminals")) then
            cancelEvent(true)
        elseif (exports.GTIUtil:isPlayerInTeam(source, "Emergency Services") and exports.GTIUtil:isPlayerInTeam(attacker, "Law Enforcement")) then
            cancelEvent(true)
        elseif (exports.GTIUtil:isPlayerInTeam(attacker, "Emergency Services") and exports.GTIUtil:isPlayerInTeam(source, "Criminals")) then
            cancelEvent(true)
        elseif (exports.GTIUtil:isPlayerInTeam(attacker, "Emergency Services") and exports.GTIUtil:isPlayerInTeam(source, "Law Enforcement")) then
            cancelEvent(true)
        elseif (exports.GTIUtil:isPlayerInTeam(attacker, "Law Enforcement") and exports.GTIUtil:isPlayerInTeam(source, "Law Enforcement")) then
            cancelEvent(true)
        end
    else
        if (isElement(attacker)) then
            if (getElementType(attacker) == "player") then
                local job = getElementData(source, "job")
                local job2 = getElementData(attacker, "job")  
                if (job == "SWAT Division" and job2 == "SWAT Division") then
                    cancelEvent()
                end 
            elseif (getElementType(attacker) == "vehicle") then
                triggerServerEvent("SjoerdMisc.colission", root, localPlayer, attacker)
                cancelEvent() 
            end   
        end    
    end
end
addEventHandler("onClientPlayerDamage", root, cancelDamage)

function colissionShit(player, attacker)
    if (isElement(player) and isElement(attacker)) then
        setElementCollidableWith(player, attacker, false)
        setTimer(function (p, v) if (isElement(p) and isElement(v)) then setElementCollidableWith(p, v, true) end end, 5000, 1, player, attacker)
    end    
end
addEvent("SjoerdMisc.clientColission", true)
addEventHandler("SjoerdMisc.clientColission", root, colissionShit)

addCommandHandler( "devmode",
function ()
    if (getPlayerName(localPlayer) == "GHoST|RedBand") then
        setDevelopmentMode ( true )
    end
end
)

function centerWindow(element)
    --Check if our element exists before we bother doing anything
    if (element) and (isElement(element)) then
        --Check if it's a GUI element
        if not (string.find(getElementType(element),"gui")) then
            return
        end

        local x,y = guiGetSize(element,false)
        local rX,rY = guiGetScreenSize()
        local X,Y = (rX/2) - (x/2),(rY/2) - (y/2)
        guiSetPosition(element,X,Y,false)
        return true
    end
    return true
end


function showSong(suc,length,streamN)
    local tag = getSoundMetaTags(source)
    for i, v in ipairs(tag) do
        exports.GTIhud:dm("Now playing: "..(tag.title), 120, 120, 120)
        outputDebugString(i.." "..v)
    end
end
addEventHandler("onClientSoundChangedMeta", root, showSong)

--[[
local resX, resY = guiGetScreenSize()
function renderTesting()
    for k, v in pairs( getElementsByType( "player", root, true ) ) do
        if (getElementData(v, "SjoerdMisc.isPlayerMinimized") and isElementOnScreen( v ) ) then
            local x, y, z = getElementPosition( v )
            local a, b, c = getElementPosition( localPlayer )
            local dist = getDistanceBetweenPoints3D( x, y , z, a, b, c )
            if ( dist < 30 and getElementHealth(v) > 0.01 ) then
                local x, y, z = getPedBonePosition( localPlayer, 4 )
                local tX, tY = getScreenFromWorldPosition( x, y, z+0.4, 0, false )
                if ( tX and tY and isLineOfSightClear( a, b, c, x, y, z, true, false, false, true, true, false, false, v ) ) then
                    local width = dxGetTextWidth( "[QCA Testing]", 0.6, "bankgothic" )
                    --dxDrawText( "[QCA Testing]", tX-( width/2), tY, resX, resY, tocolor( 255, 137, 0, 255 ), 0.5, "bankgothic")
                    dxDrawImage(tX-( width/4.5), tY-45, 65, 65, "afk_.png")
                end
            end
        end
    end
end
addEventHandler ( "onClientRender", root, renderTesting )

function handleMinimize()
    setElementData(localPlayer, "SjoerdMisc.isPlayerMinimized", true)
end
addEventHandler( "onClientMinimize", root, handleMinimize )

function handleRestore( didClearRenderTargets )
    setElementData(localPlayer, "SjoerdMisc.isPlayerMinimized", false)
end
addEventHandler("onClientRestore",root,handleRestore)

function onResourceStart()
    setElementData(localPlayer, "SjoerdMisc.isPlayerMinimized", false)
end
addEventHandler("onClientResourceStart", resourceRoot, onResourceStart)
--]]

function preventQuitJob()
    if (getElementDimension(source) == 801) then
        exports.GTIhud:dm("You can't quit/resign from your job while in a CnR event.", 255, 0, 0)
        cancelEvent()
    end
end
addEventHandler("onClientPlayerQuitJob", root, preventQuitJob)


function forceUpload() 
    --if (source == localPlayer) then
        local screen = dxGetStatus ( ).AllowScreenUpload
        if (not screen) then  
            triggerServerEvent("SjoerdMisc.kickPlayer", localPlayer, localPlayer)
        end
        --end
end
addEventHandler("onClientPlayerJoin", root, forceUpload)   


