local screenW, screenH = guiGetScreenSize()

GTIpunishlog = {
    gridlist = {},
    window = {},
    button = {},
    label = {}
}

GTIpunishlog.window[1] = guiCreateWindow((screenW - 777) / 2, (screenH - 533) / 2, 777, 533, "GTI - Punishment Log", false)
guiWindowSetSizable(GTIpunishlog.window[1], false)
guiSetVisible(GTIpunishlog.window[1], false)
guiSetAlpha(GTIpunishlog.window[1], 0.90)

GTIpunishlog.label[1] = guiCreateLabel(10, 29, 55, 15, "Account: ", false, GTIpunishlog.window[1])
guiSetFont(GTIpunishlog.label[1], "default-bold-small")

GTIpunishlog.label[2] = guiCreateLabel(75, 29, 171, 15, "N/A", false, GTIpunishlog.window[1])
guiLabelSetColor(GTIpunishlog.label[2], 40, 178, 224)

GTIpunishlog.gridlist[1] = guiCreateGridList(10, 54, 757, 408, false, GTIpunishlog.window[1])
guiGridListAddColumn(GTIpunishlog.gridlist[1], "Account Punishments", 1.0)
guiGridListSetSortingEnabled(GTIpunishlog.gridlist[1], false)

GTIpunishlog.label[3] = guiCreateLabel(10, 508, 421, 15, "Each log line will be automatically deleted 30 days after the date it is added.", false, GTIpunishlog.window[1])
guiLabelSetColor(GTIpunishlog.label[3], 40, 178, 224)

GTIpunishlog.button[1] = guiCreateButton(669, 493, 98, 30, "Close", false, GTIpunishlog.window[1])
guiSetProperty(GTIpunishlog.button[1], "NormalTextColour", "FFAAAAAA")

GTIpunishlog.button[2] = guiCreateButton(561, 493, 98, 30, "Delete Row", false, GTIpunishlog.window[1])
guiSetProperty(GTIpunishlog.button[2], "NormalTextColour", "FFAAAAAA")
guiSetEnabled(GTIpunishlog.button[2], false)

GTIpunishlog.label[4] = guiCreateLabel(10, 493, 421, 15, "Your punishment log is private and is unviewable by other players.", false, GTIpunishlog.window[1])
guiSetFont(GTIpunishlog.label[4], "default-bold-small")
guiLabelSetColor(GTIpunishlog.label[4], 40, 178, 224)

function viewPunishlog(state)
	if state then
		if not guiGetVisible(GTIpunishlog.window[1]) then
			guiBringToFront(GTIpunishlog.window[1])
			guiSetVisible(GTIpunishlog.window[1], true)
		end
	else
		if guiGetVisible(GTIpunishlog.window[1]) then
			guiSetVisible(GTIpunishlog.window[1], false)
		end
	end
end

function process(admin, logtable, account)
	viewPunishlog(true)
	gatherLogs(admin, logtable, account)
end
addEvent("GTIpunishlog.gatherLogs", true)
addEventHandler("GTIpunishlog.gatherLogs", root, process)

addEventHandler("onClientGUIClick", root,
	function()
		if source == GTIpunishlog.button[1] then
			viewPunishlog(false)
		elseif source == GTIpunishlog.button[2] then
			local sRow, sCol = guiGridListGetSelectedItem(GTIpunishlog.gridlist[1])
			local logEntry = guiGridListGetItemText(GTIpunishlog.gridlist[1], sRow, sCol)
			local logData = guiGridListGetItemData(GTIpunishlog.gridlist[1], sRow, sCol)

			if logEntry and logData then
				local logData = split(logData, ";")

				local logTableID = logData[1]
				local logAccount = logData[2]
				local logID = logData[3]

				triggerServerEvent("GTIpunishlog.deleteLogEntry", localPlayer, logTableID, logID, logAccount)
			end
		end
	end
)

function gatherLogs(admin, logtable, account)
	if admin then
		guiSetEnabled(GTIpunishlog.button[2], true)
		--[[
		guiLabelSetColor(GTIpunishlog.label[2], 224, 41, 87)
		guiLabelSetColor(GTIpunishlog.label[3], 224, 41, 87)
		guiLabelSetColor(GTIpunishlog.label[4], 224, 41, 87)
		--]]
		guiSetText(GTIpunishlog.label[3], "Each log line will be automatically deleted 30 days after the date it is added.")
		guiSetText(GTIpunishlog.label[4], "You are not allowed to share any logs from "..account.."'s punishlog.")
	else
		guiSetEnabled(GTIpunishlog.button[2], false)
		--[[
		guiLabelSetColor(GTIpunishlog.label[2], 224, 41, 87)
		guiLabelSetColor(GTIpunishlog.label[3], 224, 41, 87)
		guiLabelSetColor(GTIpunishlog.label[4], 224, 41, 87)
		--]]
		guiSetText(GTIpunishlog.label[3], "Each log line will be automatically deleted 30 days after the date it is added.")
		guiSetText(GTIpunishlog.label[4], "Your punishment log is private and is unviewable by other players.")
	end

	guiSetText(GTIpunishlog.label[2], account)

	if logtable and type(logtable) == "table" then
		guiGridListClear(GTIpunishlog.gridlist[1])
		for i, line in ipairs (logtable) do
			local id = line[1]
			local account = line[2]
			local serial = line[3]
			local admin = line[4]
			local reason = line[5]

			local logTime = line[6]
			local expiry = line[7]

			local sD, sM, sY = exports.GTIutil:todate(logTime)
			local sH, sMi, sS = exports.GTIutil:totime(logTime)

			local eD, eM, eY = exports.GTIutil:todate(expiry)
			local eH, eMi, eS = exports.GTIutil:totime(expiry)

			local realTime = getRealTime().timestamp
			local rD, rM, rM = exports.GTIutil:todate(realTime)

			local dRem = sD-eD
			--local dRem = rD-eD
			local dRem = string.gsub(dRem, " ", "")

			--local line_format = "["..sH..":"..sMi..":"..sS.." "..sD.."/"..sM.."/"..sY.."] [Expires: "..eD.."/"..eM.."/"..eY.." | "..dRem.." days]: "..reason
			local line_format = "["..sH..":"..sMi..":"..sS.." "..sD.."/"..sM.."/"..sY.."]: "..reason
			local pR, pB, pG = 0, 0, 0
			if admin then
				--pR, pB, pG = 224, 41, 87
				pR, pB, pG = 40, 178, 224
			else
				pR, pB, pG = 40, 178, 224
			end

			local row = guiGridListAddRow(GTIpunishlog.gridlist[1])
			guiGridListSetItemText(GTIpunishlog.gridlist[1], row, 1, line_format, false, false)
			guiGridListSetItemData(GTIpunishlog.gridlist[1], row, 1, i..";"..account..";"..id)
			guiGridListSetItemColor(GTIpunishlog.gridlist[1], row, 1, pR, pB, pG) -- Blue
		end
	end
end
