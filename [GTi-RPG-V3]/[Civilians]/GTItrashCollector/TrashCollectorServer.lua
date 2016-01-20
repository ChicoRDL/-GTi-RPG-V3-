addEvent("GTITrashCollector.marker", true)
addEventHandler("GTITrashCollector.marker", root, function()
local theVeh =  exports.GTIrentals:getPlayerRentalVehicle(client)
if ( isElement(theVeh) ) and ( getElementModel(theVeh) == 408 ) then
local SX,SY,SZ = getElementPosition(theVeh)
triggerClientEvent ( client, "GTITrashCollector.createmarker", resourceRoot, SX, SY, SZ, theVeh )
end
end )
addEvent("GTITrashCollector.pay", true)
addEventHandler("GTITrashCollector.pay", root, function()
	local pay = exports.GTIemployment:getPlayerJobPayment(client, "Trash Collector")
	local hrPay = exports.GTIemployment:getPlayerHourlyPay(client)
	local hrExp = exports.GTIemployment:getHourlyExperience()
	
	local pay = math.ceil( pay*10 )
	local Exp = math.ceil( (pay/hrPay)*hrExp )
	local pay = math.ceil( math.random(pay*0.8, pay*1.2) )
	
	exports.GTIemployment:modifyPlayerJobProgress(client, "Trash Collector", 10)
	exports.GTIemployment:modifyPlayerEmploymentExp(client, Exp, "Trash Collector")
	exports.GTIemployment:givePlayerJobMoney(client, "Trash Collector", pay)
end)

function trashEnter ( thePlayer, seat, jacked )
    if isElement(source) and ( getElementModel ( source ) == 408 ) and (exports.GTIrentals:getPlayerRentalVehicle(thePlayer) == source) and (seat == 0) and (exports.GTIemployment:getPlayerJob(thePlayer,true) == "Trash Collector") then 
       triggerClientEvent ( thePlayer, "GTITrashCollector.onWasteEnter", resourceRoot )
    end
end
addEventHandler ( "onVehicleEnter", getRootElement(), trashEnter )

addEvent("GTITrashCollector.freeze", true)
addEventHandler("GTITrashCollector.freeze", root, function(fre)
    local theveh = exports.GTIrentals:getPlayerRentalVehicle(client) 
    if fre == false then
        setElementFrozen(theveh,false)
    elseif fre == true then 
        setElementFrozen(theveh,true)
    end
end )
addEvent("GTITrashCollector.anim", true)
addEventHandler("GTITrashCollector.anim", root, function(anim)
if anim == 1 then
    exports.GTIanims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, false)
    exports.GTIanims:setJobAnimation(client, "CARRY", "crry_prtial", 50, false, true, false, true)
elseif anim == 2 then 
    exports.GTIanims:setJobAnimation(client, "CARRY", "liftup", 1000, true, false, false, false)
elseif anim == 3 then 
	exports.GTIanims:setJobAnimation(client, "GRENADE", "WEAPON_throwu", 500, true, false, false, false)
end
end )