
local pedsTable = {
    {171, 1961.962890625, 1015.6611328125, 992.46875, 269, "100", "1500", "Dimitri"},
    {172, 1960.7412109375, 1015.671875, 992.46875, 89, "1000", "10000", "Lucy"},
    
    {172, 1961.962890625, 1020.140625, 992.46875, 269, "300", "3000", "Cynthia"},
    {171, 1960.7412109375, 1020.140625, 992.46875, 89, "500", "5000", "Jack"},
    }
    
local createdPeds = {}

function createPeds()
    for i, v in ipairs(pedsTable) do
        local ped = createPed(v[1], v[2], v[3], v[4])
        setElementRotation(ped, 0, 0, v[5])
        setElementInterior(ped, 10)
        setElementDimension(ped, 0)
        setElementFrozen(ped, true)
        createdPeds[ped] = true
        setElementData(ped, "minB", v[6])
        setElementData(ped, "maxB", v[7])
        setElementData(ped, "name", v[8])
        addEventHandler ( "onClientPedDamage", ped, cancelTheKill )       
    end
end   
addEventHandler("onClientResourceStart", resourceRoot, createPeds) 


function testClick(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
    if (guiGetVisible(casinoBj.window[1])) then return end
    if (getElementInterior(localPlayer) == 10) then
        if (isElement(clickedElement)) then
            if (getElementType(clickedElement) == "ped") then
                local distance = exports.GTIutil:getDistanceBetweenElements2D(clickedElement, localPlayer)
                if (distance > 3) then return end
                if (createdPeds[clickedElement] and state == "up") then
                    local minB = getElementData(clickedElement, "minB")
                    local maxB = getElementData(clickedElement, "maxB")
                    local name = getElementData(clickedElement, "name")
                    openGUI(minB, maxB, name)
                end
            end
        end    
    end    
end
addEventHandler("onClientClick", root, testClick)    


local resX, resY = guiGetScreenSize()
function renderBets()
    if (getElementInterior(localPlayer) == 10) then
        for k, v in pairs(createdPeds) do
            if ( isElementOnScreen( k ) ) then
                local x, y, z = getElementPosition( k )
                local a, b, c = getElementPosition( localPlayer )
                local dist = getDistanceBetweenPoints3D( x, y , z, a, b, c )
                local minB = getElementData(k, "minB")
                local maxB = getElementData(k, "maxB")
                if ( dist < 30 and getElementHealth(k) > 0.01 ) then
                    local x, y, z = getPedBonePosition( k, 4 )
                    local tX, tY = getScreenFromWorldPosition( x, y, z+0.4, 0, false )
                    if ( tX and tY and isLineOfSightClear( a, b, c, x, y, z, true, false, false, true, true, false, false, k ) ) then
                        --local muted = getElementData( v, "m" )
                        local width = dxGetTextWidth( "$"..minB.." - $"..maxB, 0.6, "bankgothic" )
                        --if ( muted ) then
                            dxDrawText( "$"..minB.." - $"..maxB, tX-( width/2), tY, resX, resY, tocolor( 255, 0, 0, 255 ), 0.5, "bankgothic")
                        --end
                    end
                end
            end
        end
    end    
end
addEventHandler ( "onClientRender", root, renderBets )

function cancelTheKill ( player )
    cancelEvent ()
end

function cancelDamage ( attacker )
    if (isElement(attacker) and isElement(source)) then
        local int1 = getElementInterior(attacker)
        local int2 = getElementInterior(source)
        if (int1 == 10 and int2 == 10) then
            cancelEvent ()
        end   
    end 
end
addEventHandler ( "onClientPlayerDamage", root, cancelDamage ) 

addEventHandler("onClientResourceStart", root, 
	function (res) 
		if ( getResourceName(res) == "GTIblips" ) then
			exports.GTIblips:createCustomBlip(2023.628, 1007.727, 16, 16, "blackjack.png", 500)
		end
	end
)
