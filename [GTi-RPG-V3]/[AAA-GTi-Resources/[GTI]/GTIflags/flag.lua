--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz ~
-- Resource: GTIflags/flag.lua ~
-- Description: Scoreboard Country Flags ~
-- Data: #Flags
--<--------------------------------->--


function onStart()
    if (not getResourceFromName("admin") or getResourceState(getResourceFromName("admin")) ~= "running") then return end
    exports.scoreboard:addScoreboardColumn('Country', getRootElement(), 5, 110)
    
    for k,v in ipairs(getElementsByType("player")) do
        local flag = exports.admin:getPlayerCountry(v) or "US"
        local ID   = tostring( flag )
        if flag then
            setElementData(v,"Country",{type="image",src=":admin/client/images/flags/"..flag..".png",width=20, id=ID})
        end         
    end
end
addEventHandler("onResourceStart",resourceRoot,onStart)

function getCountry()
    if (not getResourceFromName("admin") or getResourceState(getResourceFromName("admin")) ~= "running") then return end
        local flag = exports.admin:getPlayerCountry(source) or "US"
        local ID   = tostring( flag )
        if (getPlayerName(source) == "Nickelz") then
            local flag = "SA"
            local ID   = tostring( flag )
        end    
        if flag then
            setElementData(source,"Country",{type="image",src=":admin/client/images/flags/"..flag..".png",width=20, id=ID})
        end
end
addEventHandler("onPlayerJoin", getRootElement(), getCountry)
addEventHandler("onPlayerChat", getRootElement(), getCountry)

addEventHandler("onResourceStart", root, 
    function (res) 
        if ( getResourceName(res) == "scoreboard" ) then 
            onStart() 
        end
    end
)
