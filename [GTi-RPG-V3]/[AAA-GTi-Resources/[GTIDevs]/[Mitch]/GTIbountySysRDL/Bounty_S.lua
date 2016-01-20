function toggleGUI(lePlayer)
	if (lePlayer) then
		if (getPlayerTeam(lePlayer)) then -- Check if he is logged IN.
			triggerClientEvent(lePlayer, "toggleDaPanel", lePlayer)
		end
	end
end
addCommandHandler("hitme", toggleGUI)

addEvent("createMaHit", true)
function hitOpt(Opt)
	if (Opt) and (source) then
		if (Opt == "Bounty for $100") then
			createDaHit(source, 100)
		elseif (Opt == "Bounty for $50.000") then
			createDaHit(source, 50000)
		elseif (Opt == "Bounty for $75.000") then
			createDaHit(source, 75000)
		elseif (Opt == "Bounty for $100.000") then
			createDaHit(source, 100000)
		elseif (Opt == "Bounty for $150.000") then
			createDaHit(source, 150000)
		elseif (Opt == "Bounty for $200.000") then
			createDaHit(source, 200000)
		elseif (Opt == "Bounty for $350.000") then
			createDaHit(source, 350000)
		elseif (Opt == "Bounty for $500.000") then
			createDaHit(source, 500000)
		end
	end
end
addEventHandler("createMaHit", getRootElement(), hitOpt)

function createDaHit(Player, Bounty)
	local daMoney = getPlayerMoney(Player)
	if (Player) and (Bounty) then
		if (daMoney >= Bounty) then
			if (getElementData(Player, "isOnHit") == false) then
				setElementData(Player, "isOnHit", tostring(Bounty))
				daBlip = createBlipAttachedTo(Player, 44)
				setBlipOrdering(daBlip, 600)
				exports.GTIbank:TPM ( Player, Bounty, "Bounty system" )
				setElementHealth(Player, 100)
				setPedArmor(Player, 100)
				setPlayerNametagColor (Player, 255, 150, 0 )
				outputChatBox("* "..getPlayerName(Player).." #FFFFFFhas placed a Hit on himself, #FF0000kill him #FFFFFFto get #00FF00$"..Bounty..".", getRootElement(), 255, 255, 0, true)
				addEventHandler("onPlayerQuit", Player,
					function()
						destroyElement(daBlip)
					end
				)
				triggerClientEvent(Player, "addLeRow", Player)
				---addEventHandler("onPlayerWasted", Player, payTheHitKiller)
			else
				exports.GTIhud:dm("* You cant put a hit on your self right now.", Player, 255, 255, 0)
			end
		else
			exports.GTIhud:dm("* You don't have enough money to start a Hit on your self.", Player, 50, 255, 0)
		end
	end
end

addEvent ("onPlayerQuitJob", true )

function cancelQuitJob ( )
    if getElementData(source, "isOnHit") then
	    exports.GTIhud:dm("You cannot quit your job while having a bounty!", source, 255, 255, 0)
	    cancelEvent ()
	end
end
addEventHandler ("onPlayerQuitJob", root, cancelQuitJob )

function payTheHitKiller(_, killer)
	local daBounty = getElementData(source, "isOnHit")
	exports.GTIteams:assignTeam(source, "General Population")
	if (killer ~= source) then
		if (daBounty) then -- confirm that there is a hit.
		    outputDebugString ("test#1")
			exports.GTIbank:GPM ( killer, tonumber(daBounty), "Bounty system" )
			setElementData(source, "isOnHit", false)
			outputChatBox("* #FFF000"..getPlayerName(killer).." #FFFFFFkilled #FFF000"..getPlayerName(source).."#FFFFFF and won #00FF00$"..daBounty.."!", getRootElement(), 255, 0, 0, true)
		end
	end
end

for k,v in ipairs (getElementsByType("player")) do
	if (getElementData(v, "isOnHit")) then
		addEventHandler("onPlayerWasted", v, payTheHitKiller)
	end
end
--// remove the Blip if the player doesn't have a hit
setTimer(
	function()
		for i, player in ipairs (getElementsByType("player")) do
			if player and isElement(player) and (getElementData(player, "isOnHit") == false) then
				for k,v in ipairs (getAttachedElements(player)) do
					if v and isElement(v) and (getElementType(v) == "blip") and (v == daBlip) then
						destroyElement(v)
					end
				end
			end
		end
	end
, 50, 0)