-- List of resources to refresh
restartList = { }

--[[ Load list from HDD and apply GUI ]]--
function loadList( )
    --[[ Load dynamic list of resources to refresh ]]--
    local settings_store = getAccount("ChicoGTI")
    restartList = exports.GTIaccounts:GAD(settings_store, "resources_to_refresh")

    --[[ Predefined static list of resources to refresh ]]--
    restartList = {

        ["GTIspeaker"]=true,       

        }

    --[[ Check all resources that use this GUI ]]--
    for k, v in pairs(restartList) do
        if getResourceFromName(k) then
            restartResource(getResourceFromName(k))
            outputServerLog("GTIgui: refreshed: '"..k.."'")
        end
    end
end
addEventHandler("onResourceStart", resourceRoot, loadList)

--[[ Save refresh array in HDD ]]--
function saveList( )
    local settings_store = getAccount("ChicoGTI")
    exports.GTIaccounts:SAD(settings_store, "resources_to_refresh", restartList)
end
addEventHandler("onResourceStop", resourceRoot, saveList)

--[[ Add missing resource to dynamic refresh list ]]--
function addToRefreshList(res)
    restartList[res]=true
end
addEvent("GTIgui.addToRefreshList", true)
addEventHandler("GTIgui.addToRefreshList", resourceRoot, addToRefreshList)