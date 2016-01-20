
currentNode = ""

settings = {
    --Example: {"settingName", "Item Name", "Description", "DefaultSetting", "settingType" (combo, edit), {Options (Enabled, disble etc)}, "Category"},
    {"pistol", "Pistol", "Enable/Disable the usage of a Pistol.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"silencedPistol", "Silenced Pistol", "Enable/Disable the usage of a Silenced Pistol.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"deagle", "Desert Eagle", "Enable/Disable the usage of a Desert Eagle.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"pumpShotgun", "Pomp Shotgun", "Enable/Disable the usage of a Pomp Shotgun.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"sawnOff", "Sawn-Off Shotgun", "Enable/Disable the usage of a Sawn-Off Shotgun.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"spas", "Spas-12", "Enable/Disable the usage of a Spas-12.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"uzi", "Uzi", "Enable/Disable the usage of an Uzi.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"tec9", "Tec-9", "Enable/Disable the usage of a Tec-9.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"mp5", "MP5", "Enable/Disable the usage of a MP5.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"ak47", "AK-47", "Enable/Disable the usage of an AK-47.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"m4", "M4", "Enable/Disable the usage of a M4.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"countryRifle", "Country Rifle", "Enable/Disable the usage of a Country Rifle.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"sniper", "Sniper Rifle", "Enable/Disable the usage of a Sniper.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"rpg", "RPG", "Enable/Disable the usage of a RPG.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"minigun", "Minigun", "Enable/Disable the usage of a Minigun.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"grenade", "Grenade", "Enable/Disable the usage of a Grenade.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"tearGas", "Tear Gas", "Enable/Disable the usage of Tear Gas.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"molotov", "Molotov", "Enable/Disable the usage of a Molotov Cocktail.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    {"satchel", "Satchel", "Enable/Disable the usage of Satchels.", "Enabled", "combo", {"Enabled", "Disabled"}, "Weapons"},
    -- Players
    {"crafting", "Crafting", "Enable/Disable the usage of /craft.", "Enabled", "combo", {"Enabled", "Disabled"}, "Players"},
    {"cockpitView", "Force /fp", "Force players to have the First Person View in vehicles.", "Enabled", "combo", {"Enabled", "Disabled"}, "Players"},
    {"nitrous", "Nitrous", "Enable/Disable the usage of Nitrous.", "Enabled", "combo", {"Enabled", "Disabled"}, "Players"},
    -- World
    {"gravity", "Gravity", "Set the world gravity.", "0.008", "edit", {"Enabled", "Disabled"}, "World"},
    {"waterLvl", "Water Level", "Set the height of the water.", "1", "edit", {}, "World"},
    {"moneyKill", "Kill Reward", "Set the reward for killing a player.", "0", "edit", {"Enabled", "Disabled"}, "World"},
    {"localRange", "LocalChat Range", "Set the range of the LocalChat.", "Infinite", "combo", {"Infinite", "Default"}, "World"},
    {"uav", "Use of /uav", "Enable/Disable the usage of /uav.", "Enabled", "combo", {"Enabled", "Disabled"}, "World"},
    {"playerBlips", "Player Blips", "Enable/Disable Player Blips.", "Enabled", "combo", {"Enabled", "Disabled"}, "World"},
    --{"walkStyle", "Crafting", "Enable/Disable the usage of /craft.", "Enabled", "combo", {"Enabled", "Disabled"}, "World"},
}

settingFetch = {
    --{"settingName", "name"}
    {"pistol", "master:pistol"},
    {"silencedPistol", "master:silencedPistol"},
    {"deagle", "master:deagle"},
    {"pumpShotgun", "master:pumpShotgun"},
    {"sawnOff", "master:sawnOff"},
    {"spas", "master:spas"},
    {"uzi", "master:uzi"},
    {"tec9", "master:tec9"},
    {"mp5", "master:mp5"},
    {"ak47", "master:ak47"},
    {"m4", "master:m4"},
    {"countryRifle", "master:countryRifle"},
    {"sniper", "master:sniper"},
    {"rpg", "master:rpg"},
    {"minigun", "master:minigun"},
    {"grenade", "master:grenade"},
    {"tearGas", "master:tearGas"},
    {"molotov", "master:molotov"},
    {"satchel", "master:satchel"},
    {"crafting", "master:crafting"},
    {"trading", "master:trading"},
    {"weaponBinds", "master:weaponBinds"},
    {"cockpitView", "master:cockpitView"},
    {"nitrous", "master:nitrous"},
    {"gravity", "master:gravity"},
    {"waterLvl", "master:waterLvl"},
    {"moneyKill", "master:moneyKill"},
    {"localRange", "master:localRange"},
    {"uav", "master:uav"},
    {"playerBlips", "master:playerBlips"},
}

function master(subf, entity)
    if subf == "pistol" then
        return getSetting(subf)
    elseif subf == "silencedPistol" then
        return getSetting(subf)
    elseif subf == "deagle" then
        return getSetting(subf)
    elseif subf == "pumpShotgun" then
        return getSetting(subf)
    elseif subf == "sawnOff" then
        return getSetting(subf)
    elseif subf == "spas" then
        return getSetting(subf)
    elseif subf == "uzi" then
        return getSetting(subf)
    elseif subf == "tec9" then
        return getSetting(subf)
    elseif subf == "mp5" then
        return getSetting(subf)
    elseif subf == "ak47" then
        return getSetting(subf)
    elseif subf == "m4" then
        return getSetting(subf)
    elseif subf == "countryRifle" then
        return getSetting(subf)
    elseif subf == "sniper" then
        return getSetting(subf)
    elseif subf == "rpg" then
        return getSetting(subf)
    elseif subf == "minigun" then
        return getSetting(subf)
    elseif subf == "grenade" then
        return getSetting(subf)
    elseif subf == "tearGas" then
        return getSetting(subf)
    elseif subf == "molotov" then
        return getSetting(subf)   
    elseif subf == "satchel" then
        return getSetting(subf)
    elseif subf == "crafting" then
        return getSetting(subf)
    elseif subf == "trading" then
        return getSetting(subf)
    elseif subf == "weaponBinds" then
        return getSetting(subf)
    elseif subf == "cockpitView" then
        return getSetting(subf)
    elseif subf == "nitrous" then
        return getSetting(subf)
    elseif subf == "gravity" then
        return getSetting(subf)
    elseif subf == "waterLvl" then
        return getSetting(subf)
    elseif subf == "moneyKill" then
        return getSetting(subf)    
    elseif subf == "localRange" then
        return getSetting(subf)
    elseif subf == "uav" then
        return getSetting(subf)
    elseif subf == "playerBlips" then
        return getSetting(subf)    
    end
end

function startUp()    
        file = xmlLoadFile("emsettings.xml")
        if (file) then
            child = xmlFindChild(file, "options", 0)
            if (not child) then
                if (not child) then
                    xmlNodeSetValue(xmlCreateChild(child, "options"), "")
                end
                xmlSaveFile(file)
                startUp()
                return   
            end    
        else
            local file2 = xmlCreateFile("emsettings.xml", "emsettings")
            xmlNodeSetValue(xmlCreateChild(file2, "options"), "")
            xmlSaveFile(file2)
            startUp()
        return
    end    
    currentNode = xmlNodeGetValue(child)
end
addEventHandler("onResourceStart", resourceRoot, startUp)    



function getSetting(settingName)
    for index, setting in ipairs(settings) do
        if (setting[1] == settingName) then
            local spl = split(currentNode, ":") or {}
            for i, dat in ipairs(spl) do
                local spl2 = split(dat, ";") or {}
                if (spl2[1] == setting[1]) then   
                    return spl2[2]
                end
            end
            return setting[4]
        end
    end
    return false
end

function setSetting(settingName, newVal)
    local newVal = string.gsub(newVal, ":", "")
    local newVal = string.gsub(newVal, ";", "")
    for index, setting in ipairs(settings) do
        if (setting[1] == settingName) then
            local spl = split(currentNode, ":") or {}
            local oldVal = false
            for index2, dat in ipairs(spl) do
                local spl2 = split(dat, ";") or {}
                if (spl2[1] == setting[1]) then
                    oldVal = spl2[2]
                    table.remove(spl, index2)
                end
            end
            table.insert(spl, setting[1]..";"..newVal)
            local newStr = ""
            for index3, dat in pairs(spl) do
                newStr = newStr..":"..dat
            end
            currentNode = newStr
            xmlNodeSetValue(child, newStr)
            xmlSaveFile(file)
            triggerEvent("GTIemsettings.onSettingChange", root, settingName, oldVal, newVal)
            getSettingTable()
            triggerClientEvent("GTIemsettings.refreshGridlist", root)
            return true
        end
    end
    return false
end
addEvent("GTIemsettings.setSetting", true)
addEventHandler("GTIemsettings.setSetting", root, setSetting)

function forceCv(settingName, old, new)
    if (settingName == "cockpitView") then
        if (new == "Enabled") then 
            if (exports.GTIeventsys:isPlayerInEvent(source)) then
                setElementData(source, "forceFP", true)
                exports.SjoerdMisc:toggleCockpitView(source)
            end    
        elseif (new == "Disabled") then  
            setElementData(source, "forceFP", false)
        end
    end    
end
addEventHandler("GTIemsettings.onSettingChange", root, forceCv)

function getSettingTable()
    local settingTable = {}

    for i, stat in ipairs(settingFetch) do
        local name = stat[1]
        local fsjn = stat[2]
        local args = stat[3]
        local acfn = stat[3]

        local fdata = split(fsjn, ":")
        local fn = fdata[1]
        local sfn = fdata[2]
        -- Get Data
        if args then
            if acfn then
                rdata = _G[fn](sfn, thePlayer, args, true)
            else
                rdata = _G[fn](sfn, thePlayer, args)
            end
        else
            rdata = _G[fn](sfn, thePlayer) or false
        end 
        table.insert(settingTable, {name, rdata})
    end
    triggerClientEvent(client, "GTIemsettings.getClientSetting", client, settingTable)
    settingTable = nil
end
addEvent("GTIemsettings.getSetting", true)
addEventHandler("GTIemsettings.getSetting", root, getSettingTable)