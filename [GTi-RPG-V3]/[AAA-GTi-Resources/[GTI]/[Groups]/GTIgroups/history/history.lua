----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: JT Pennington (JTPenn)
-- Date: 21 Oct 2014
-- Resource: GTIgroups/history/history.lua
-- Version: 1.0
----------------------------------------->>

local history_cache = {}	-- Group Log History Cache

-- Get Group History
--------------------->>

addEventHandler("onClientGUITabSwitched", groupPanel.tab[4], function()
	if (guiGridListGetRowCount(groupPanel.gridlist[2]) ~= 0) then return end
	triggerServerEvent("GTIgroups.getGroupHistory", resourceRoot)
end)

addEvent("GTIgroups.setGroupHistory", true)
addEventHandler("GTIgroups.setGroupHistory", root, function(category, result, timestamp)
	guiGridListClear(groupPanel.gridlist[2])
	for j=1,#result do
		local v = result[j]
		local row = guiGridListAddRow(groupPanel.gridlist[2])
			
		local day,mo,yr = exports.GTIutil:todate(v.timestamp)
		local day,mo = string.format("%02d", day), string.format("%02d", mo)
		guiGridListSetItemText(groupPanel.gridlist[2], row, 1, yr.."-"..mo.."-"..day, false, false)
		
		local hr,min,sec = exports.GTIutil:totime(v.timestamp)
		local hr,min,sec = string.format("%02d", hr), string.format("%02d", min), string.format("%02d", sec)
		guiGridListSetItemText(groupPanel.gridlist[2], row, 2, hr..":"..min..":"..sec, false, false)
		
		guiGridListSetItemText(groupPanel.gridlist[2], row, 3, v.text, false, false)
		
		table.insert(history_cache, v)
	end
end)
