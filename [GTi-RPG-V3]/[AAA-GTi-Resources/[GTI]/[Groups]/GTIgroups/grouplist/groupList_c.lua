----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: LilDolla
-- Date: 02 Feb 2015
-- Resource: GTIgroups/groupList_c.lua
-- Type: Client Side
----------------------------------------->>

addEvent("GTIgroups.getGroupInfo", true)
addEventHandler("GTIgroups.getGroupInfo", resourceRoot, function(groups, mem_high)
	guiGridListClear(groupPanel.gridlist[10])
	for i=mem_high,1,-1 do
		for i,g in ipairs(groups[i] or {}) do
			local row = guiGridListAddRow(groupPanel.gridlist[10])
			guiGridListSetItemText(groupPanel.gridlist[10], row, gnameC, 	g[1], false, false)
			guiGridListSetItemText(groupPanel.gridlist[10], row, membersC, 	g[2], false, false)
			guiGridListSetItemText(groupPanel.gridlist[10], row, expC, 		g[3], false, false)
			guiGridListSetItemText(groupPanel.gridlist[10], row, dateC,		g[4], false, false)
		end
	end
end)

addEventHandler("onClientGUITabSwitched", groupPanel.tab[6], function()
    if (guiGridListGetRowCount(groupPanel.gridlist[10]) ~= 0) then return end
    triggerServerEvent("GTIgroups.getGroupInfo", resourceRoot)
end)
