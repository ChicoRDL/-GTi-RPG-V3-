local categoryTable = {categories = {"2-Door and Compact Cars", "4 Door and Luxury Cars", "Airplanes", "Bikes", "Boats", "Civil Servant", "Heavy and Utility Trucks", "Helicopters", "Light Trucks and Vans", "Lowriders", "Muscle Cars", "Trains", "RC Vehicles", "Recreational", "Street Racers", "SUVs and Wagons"},
}  
   
function  
    local tbl = dealerLocations[i]
    local carTable = {}
    local vehPrices = exports.GTIvehicles:getVehiclePriceTable()
    for i,category in ipairs(tbl.categories) do
        carTable[category] = vehPrices[category]
    end
    
    for k,v in pairs(carTable) do
        for i,v in ipairs(carTable[k]) do
            local money = getPlayerMoney(player)
            if (money < v.cost) then
                carTable[k][i].afford = false
            else
                carTable[k][i].afford = true
            end
        end
    end 