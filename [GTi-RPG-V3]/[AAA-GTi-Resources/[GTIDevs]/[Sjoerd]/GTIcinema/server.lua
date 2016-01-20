function loadUrl(url)
    if (url == "") then return end
        triggerClientEvent("PRcinema.startVideoClient", root, url)
end
addEvent("PRcinema.startVideo", true)
addEventHandler("PRcinema.startVideo", root, loadUrl)

function fullScreen(url)
    if (url == "") then return end
        triggerClientEvent("PRcinema.fullScreenClient", root, url)
end
addEvent("PRcinema.fullScreen", true)
addEventHandler("PRcinema.fullScreen", root, fullScreen)    

function openCmd(plr)
    if (getAccountName(getPlayerAccount(plr)) == "RedBand") then
        triggerClientEvent(plr, "PRcinema.openGUI", plr)
    end
end
addCommandHandler("cinema", openCmd)    