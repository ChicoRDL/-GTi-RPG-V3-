
function takeBet(amount)
    if (exports.GTIutil:isPlayerLoggedIn(client)) then
        local money = getPlayerMoney(client)
        if (amount > money) then return end
        exports.GTIbank:TPM(client, amount, "BET: Blackjack")
        exports.GTIhud:dm("You have given $"..amount.." to the croupier.", client, 45, 25, 123)
        triggerClientEvent("GTIblackjack.startGame", root, client)
    end
end    
addEvent("GTIblackjack.takeBet", true)
addEventHandler("GTIblackjack.takeBet", root, takeBet)

function giveProfit(amount)
    if (exports.GTIutil:isPlayerLoggedIn(client)) then
        exports.GTIbank:GPM(client, amount, "BET: Blackjack won.")
        exports.GTIhud:dm("You have been given $"..amount.." by the croupier.", client, 45, 25, 123)
    end
end   
addEvent("GTIblackjack.giveProfit", true)
addEventHandler("GTIblackjack.giveProfit", root, giveProfit)