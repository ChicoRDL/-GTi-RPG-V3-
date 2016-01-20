------------------------------------------------->>
-- PROJECT:         Grand Theft International
-- RESOURCE:        GTIsettingsApp/settingsapp_s.lua
-- DESCRIPTION:     GTI droid settings app
-- AUTHOR:          Nerox
-- RIGHTS:          All rights reserved to author
------------------------------------------------->>
function changePassword(currentPass, newPass)
    local playerAccount = getPlayerAccount(client)
    local isPass = getAccount(getAccountName(playerAccount), currentPass)
    if not isPass then return triggerClientEvent(client, "GTIsettingsApp.outputError", client, "Invalid password.") end
    if isPass then
    if setAccountPassword ( playerAccount, newPass ) then
    triggerClientEvent(client, "GTIsettingsApp.outputError", client, "Password changed successfully.", 0, 255, 0)
    else
    triggerClientEvent(client, "GTIsettingsApp.outputError", client, "Unknown error.")
    end
    end
end
addEvent("GTIsettingsApp.changePassword", true)
addEventHandler("GTIsettingsApp.changePassword", root, changePassword)

function changeEmail(currentEmail, newEmail)
    local playerAccount = getPlayerAccount(client)
    local curEmail = exports.GTIaccounts:GAD(playerAccount, "email")
    if curEmail and currentEmail ~= curEmail then return triggerClientEvent(client, "GTIsettingsApp.outputError", client, "Invalid email.") end
    if newEmail == curEmail then return end
    if not curEmail or currentEmail == curEmail then
    if exports.GTIaccounts:SAD(playerAccount, "email", newEmail) then
    triggerClientEvent(client, "GTIsettingsApp.outputError", client, "Email changed successfully.", 0, 255, 0)
    else
    triggerClientEvent(client, "GTIsettingsApp.outputError", client, "Unknown error.")
    end
    end
end
addEvent("GTIsettingsApp.changeEmail", true)
addEventHandler("GTIsettingsApp.changeEmail", root, changeEmail)
----
function removeSetting(sname)
    sname = string.gsub(sname, " ", "_")
    triggerClientEvent(root, "GTIsettingsApp.removeSetting", root, sname)
end
function prepareSetting(player, settingName)
    settingName = string.gsub(settingName, " ", "_")
    if player then
        triggerClientEvent(player, "GTIsettingsApp.getClientSetting", player, settingName)
    end
end
local playersSettings = {}
function recieveSetting(settingName, value)
    settingName = string.gsub(settingName, " ", "_")
    playersSettings[client] = value
end
addEvent("GTIsettingsApp.recieveSetting", true)
addEventHandler("GTIsettingsApp.recieveSetting", root, recieveSetting)

function getSettingEnabled(player, settingName)
    settingName = string.gsub(settingName, " ", "_")
    if playersSettings[player] == "true" then
    return true
    else
    return false
    end
end
