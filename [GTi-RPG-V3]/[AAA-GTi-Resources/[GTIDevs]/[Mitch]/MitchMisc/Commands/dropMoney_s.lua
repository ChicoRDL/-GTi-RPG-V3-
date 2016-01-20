
spike = {}
 
function drop ( player, cmd, amount )
    if ( isElement(spike [ player ])) then exports.GTIhud:dm("Pickup your dropped money first before dropping more!", player, 200, 0, 0 ) return end
    if isPedInVehicle ( player ) then exports.GTIhud:dm("You can't use this command while being in a vehicle!", player, 200, 0, 0 ) return end
        if not getElementDimension ( player ) == 0 then exports.GTIhud:dm("You can't use this command while being in an interior!", player, 200, 0, 0 ) return end
        if not isPedOnGround ( player ) then exports.GTIhud:dm("You can't use this command while flying", player, 200, 0, 0 ) return end
    local x,y,z = getElementPosition ( player )
    local money = getPlayerMoney ( player )
    local amount = tonumber ( amount )
        if ( type ( amount ) == "number") and ( amount >= 1 ) then
        if ( type ( amount ) == "number") and ( amount >= 10001 ) then exports.GTIhud:dm("You can't drop more than $10,000", player, 200, 0, 0 ) return end
        if money >= amount then
                    exports.GTIbank:TPM(player, amount, "Dropped cash")
            spike[player] = createPickup ( x, y+3, z, 3, 1550, 5000, amount ) --Why is it called spike? lol. Cuz Swag
                        setElementID (spike[player] , "MoneyPickUp" )
                        setElementData(spike[player], "markerOwner", player)
                        setElementData(spike[player], "amount", amount)
                        --Now to set the interior + dimension (YOU FORGOT, MITCH!) - Jack
                        setElementInterior(spike[player],getElementInterior(player))
                        setElementDimension(spike[player],getElementDimension(player))
                    exports.GTIhud:dm("You dropped your money, Amount: "..amount, player, 0, 200, 0 )
        else
                exports.GTIhud:dm("You dont't have enough money!", player, 200, 0, 0 )
        end
    end
end
addCommandHandler ("dropmoney", drop )
 
addEventHandler ("onPickupHit", root,
function ( player )
    if getElementID ( source ) == "MoneyPickUp" then
            local amount = getElementData(source, "amount")
                local owner = getElementData(source, "markerOwner")
                if isElement(owner) then
                        exports.GTIhud:dm("You picked $"..amount.." from "..getPlayerName(owner), player, 0, 200, 0 )
                end
            exports.GTIbank:GPM(player, amount, "Dropped cash")
        setTimer ( destroyElement, 50, 1, source )
                if isElement ( spike [ player ] ) then
                        spike[player] = nil
                end
        end
end
)