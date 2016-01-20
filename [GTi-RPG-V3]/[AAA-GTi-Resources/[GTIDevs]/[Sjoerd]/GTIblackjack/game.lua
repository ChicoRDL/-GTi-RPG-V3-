
cardsTable = {
    { id = 1, src = "cards/1.png", amount = "Ace" },
    { id = 2, src = "cards/2.png", amount = "Ace" },
    { id = 3, src = "cards/3.png", amount = "Ace" },
    { id = 4, src = "cards/4.png", amount = "Ace" },
    { id = 5, src = "cards/5.png", amount = 10 },
    { id = 6, src = "cards/6.png", amount = 10},
    { id = 7, src = "cards/7.png", amount = 10 },
    { id = 8, src = "cards/8.png", amount = 10 },
    { id = 9, src = "cards/9.png", amount = 10 },
    { id = 10, src = "cards/10.png", amount = 10 },
    { id = 11, src = "cards/11.png", amount = 10 },
    { id = 12, src = "cards/12.png", amount = 10 },
    { id = 13, src = "cards/13.png", amount = 10 },
    { id = 14, src = "cards/14.png", amount = 10 },
    { id = 15, src = "cards/15.png", amount = 10 },
    { id = 16, src = "cards/16.png", amount = 10 },
    { id = 17, src = "cards/17.png", amount = 10 },
    { id = 18, src = "cards/18.png", amount = 10 },
    { id = 19, src = "cards/19.png", amount = 10 },
    { id = 20, src = "cards/20.png", amount = 10 },
    { id = 21, src = "cards/21.png", amount = 9 },
    { id = 22, src = "cards/22.png", amount = 9 },
    { id = 23, src = "cards/23.png", amount = 9 },
    { id = 24, src = "cards/24.png", amount = 9 },
    { id = 25, src = "cards/25.png", amount = 8 },
    { id = 26, src = "cards/26.png", amount = 8 },
    { id = 27, src = "cards/27.png", amount = 8 },
    { id = 28, src = "cards/28.png", amount = 8 },
    { id = 29, src = "cards/29.png", amount = 7 },
    { id = 30, src = "cards/30.png", amount = 7 },
    { id = 31, src = "cards/31.png", amount = 7 },
    { id = 32, src = "cards/32.png", amount = 7 },
    { id = 33, src = "cards/33.png", amount = 6 },
    { id = 34, src = "cards/34.png", amount = 6 },
    { id = 35, src = "cards/35.png", amount = 6 },
    { id = 36, src = "cards/36.png", amount = 6 },
    { id = 37, src = "cards/37.png", amount = 5 },
    { id = 38, src = "cards/38.png", amount = 5 },
    { id = 39, src = "cards/39.png", amount = 5 },
    { id = 40, src = "cards/40.png", amount = 5 },
    { id = 41, src = "cards/41.png", amount = 4 },
    { id = 42, src = "cards/42.png", amount = 4 },
    { id = 43, src = "cards/43.png", amount = 4 },
    { id = 44, src = "cards/44.png", amount = 4 },
    { id = 45, src = "cards/45.png", amount = 3 },
    { id = 46, src = "cards/46.png", amount = 3 },
    { id = 47, src = "cards/47.png", amount = 3 },
    { id = 48, src = "cards/48.png", amount = 3 },
    { id = 49, src = "cards/49.png", amount = 2 },
    { id = 50, src = "cards/50.png", amount = 2 },
    { id = 51, src = "cards/51.png", amount = 2 },
    { id = 52, src = "cards/52.png", amount = 2 }, 
    }

local betAm = 0    
local totalCards = 0
local totalAmount = 0 
local houseAmount = 0
local houseBlackjack = false
local blackjack = false

function preStartGame()
    local bet = guiGetText(casinoBj.edit[1])
    local minB = guiGetText(casinoBj.label[2])
    local maxB = guiGetText(casinoBj.label[3])
    if (bet) then
        local bet = tonumber(bet)
        local minB = tonumber(minB)
        local maxB = tonumber(maxB)
        if (bet < minB or bet > maxB) then return end 
        triggerServerEvent("GTIblackjack.takeBet", localPlayer, bet)
        betAm = bet
        guiEditSetReadOnly(casinoBj.edit[1], true)
        guiSetProperty( casinoBj.button[1], "Disabled", "True" )
    end
end    
  
function startTheGame(betPlayer)
    if (betPlayer ~= localPlayer) then return end
    finished = false
    local bet = guiGetText(casinoBj.edit[1])
    local minB = guiGetText(casinoBj.label[2])
    local maxB = guiGetText(casinoBj.label[3])
    if (bet) then
        local bet = tonumber(bet)
        betAm = bet
        local minB = tonumber(minB)
        local maxB = tonumber(maxB)
        if (bet < minB or bet > maxB) then return end 
        
        local card1 = math.random(1, 52)
        local card2 = math.random(1, 52)
        
        local src1 = getImagePath(card1)
        local src2 = getImagePath(card2)
        
        local amount1 = getCardAmount(card1)
        local amount2 = getCardAmount(card2)
        
        casinoBj.staticimage[1] = guiCreateStaticImage(22, 251, 45, 64, src1, false, casinoBj.window[1])
        casinoBj.staticimage[2] = guiCreateStaticImage(67, 251, 45, 64, src2, false, casinoBj.window[1])
        totalCards = 2
        if (amount1 == 10 and amount2 == "Ace") then
            outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFBlackjack!", 255, 0, 0, true)
            blackjack = true  
            setTimer(finishGame, 3000, 1)  
            totalAmount = 21
        elseif (amount2 == 10 and amount1 == "Ace") then
            outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFBlackjack!", 255, 0, 0, true)  
            blackjack = true 
            setTimer(finishGame, 3000, 1)  
            totalAmount = 21 
            return
        elseif (amount1 == "Ace" and amount2 == "Ace") then
            totalAmount = 12
            guiSetVisible(casinoBj.button[2], true)
            guiSetVisible(casinoBj.button[3], true)   
        elseif (amount1 == "Ace" or amount2 == "Ace") then
            guiSetVisible(casinoBj.button[5], true)
            guiSetVisible(casinoBj.button[6], true)
            if (amount1 == "Ace") then
                totalAmount = amount2
            elseif (amount2 == "Ace") then
                totalAmount = amount1
            end    
        else    
            totalAmount = amount1 + amount2
            guiSetVisible(casinoBj.button[2], true)
            guiSetVisible(casinoBj.button[3], true)   
        end    
        outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFYou got $"..totalAmount.."!", 255, 0, 0, true) 
    end    
end 
addEvent("GTIblackjack.startGame", true)
addEventHandler("GTIblackjack.startGame", root, startTheGame)

function hit()
    local card = math.random(1, 52)
    local src = getImagePath(card)
    local amount = getCardAmount(card)
    guiSetProperty( casinoBj.button[2], "Disabled", "True" )
    guiSetProperty( casinoBj.button[3], "Disabled", "True" )
    setTimer(enableButtons, 2000, 1)
    
    totalCards = totalCards + 1
    
    
    if (totalCards == 3) then
        casinoBj.staticimage[3] = guiCreateStaticImage(112, 251, 45, 64, src, false, casinoBj.window[1])
        if (amount == "Ace") then
            guiSetVisible(casinoBj.button[5], true)
            guiSetVisible(casinoBj.button[6], true)
            guiSetProperty( casinoBj.button[2], "Disabled", "True" )
            guiSetProperty( casinoBj.button[3], "Disabled", "True" )
        else
            totalAmount = totalAmount + amount
            outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFYou got $"..totalAmount.."!", 255, 0, 0, true) 
            if (totalAmount > 21) then
                outputChatBox("Busted!", 255, 0, 0)
                guiSetVisible(casinoBj.button[2], false)
                guiSetVisible(casinoBj.button[3], false)
                setTimer(finishGame, 3000, 1, true) 
            elseif (totalAmount == 21) then
                blackjack = true  
                setTimer(finishGame, 3000, 1)      
            end 
        end    
    elseif (totalCards == 4) then
        casinoBj.staticimage[4] = guiCreateStaticImage(157, 251, 45, 64, src, false, casinoBj.window[1])
        if (amount == "Ace") then
            guiSetVisible(casinoBj.button[5], true)
            guiSetVisible(casinoBj.button[6], true)
            guiSetProperty( casinoBj.button[2], "Disabled", "True" )
            guiSetProperty( casinoBj.button[3], "Disabled", "True" )
        else
            totalAmount = totalAmount + amount
            outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFYou got $"..totalAmount.."!", 255, 0, 0, true) 
            if (totalAmount > 21) then
                outputChatBox("Busted!", 255, 0, 0)
                guiSetVisible(casinoBj.button[2], false)
                guiSetVisible(casinoBj.button[3], false)
                setTimer(finishGame, 3000, 1, true) 
            elseif (totalAmount == 21) then
                blackjack = true  
                setTimer(finishGame, 3000, 1)      
            end 
        end  
    elseif (totalCards == 5) then
        casinoBj.staticimage[5] = guiCreateStaticImage(202, 251, 45, 64, src, false, casinoBj.window[1])
        guiSetVisible(casinoBj.button[2], false)
        guiSetVisible(casinoBj.button[3], false) 
        if (amount == "Ace") then
            guiSetVisible(casinoBj.button[5], true)
            guiSetVisible(casinoBj.button[6], true)
            guiSetProperty( casinoBj.button[2], "Disabled", "True" )
            guiSetProperty( casinoBj.button[3], "Disabled", "True" )
        else
            totalAmount = totalAmount + amount
            outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFYou got $"..totalAmount.."!", 255, 0, 0, true) 
            if (totalAmount > 21) then
                outputChatBox("Busted!", 255, 0, 0)
                guiSetVisible(casinoBj.button[2], false)
                guiSetVisible(casinoBj.button[3], false)
                setTimer(finishGame, 3000, 1, true) 
            elseif (totalAmount == 21) then
                blackjack = true  
                setTimer(finishGame, 3000, 1) 
            else 
                stay()    
            end 
        end    
    end    
end


function stay()
    guiSetVisible(casinoBj.button[2], false)
    guiSetVisible(casinoBj.button[3], false)  
            
    local card1 = math.random(1, 52)
    local card2 = math.random(1, 52)
        
    local src1 = getImagePath(card1)
    local src2 = getImagePath(card2)
        
    local amount1 = getCardAmount(card1)
    local amount2 = getCardAmount(card2)
    casinoBj.staticimage[6] = guiCreateStaticImage(21, 168, 45, 64, src1, false, casinoBj.window[1])
    casinoBj.staticimage[7] = guiCreateStaticImage(66, 168, 45, 64, src2, false, casinoBj.window[1])
    
    if (amount1 == 10 and amount2 == "Ace") then
            outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFBlackjack!", 255, 0, 0, true)
            houseBlackjack = true  
            setTimer(finishGame, 3000, 1)
        return  
    elseif (amount2 == 10 and amount1 == "Ace") then
            outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFBlackjack!", 255, 0, 0, true)  
            houseBlackjack = true 
            setTimer(finishGame, 3000, 1) 
        return
    end        
    
    if (amount1 == "Ace" and amount2 == "Ace") then
        amount1 = 1
        amount2 = 12
    elseif (amount1 == "Ace") then
        if (amount2 <= 10) then
            amount1 = 11
        else
            amount1 = 1        
        end
    elseif (amount2 == "Ace") then  
        if (amount1 <= 10) then
            amount2 = 11
        else
            amount2 = 1    
        end  
    end
    
    
    houseAmount = amount1 + amount2
    

    
    if (houseAmount <= 16) then
        local card = math.random(1, 52)
        local src = getImagePath(card)
        local amount = getCardAmount(card)
        casinoBj.staticimage[8] = guiCreateStaticImage(111, 168, 45, 64, src, false, casinoBj.window[1])
        
        if (amount == "Ace") then
            if (houseAmount <= 10) then
                amount = 11
            else
                amount = 1    
            end
        end
        houseAmount = houseAmount + amount
        if (houseAmount > 21) then
            outputChatBox("House busted!", 255, 0, 0)
            setTimer(finishGame, 3000, 1, false, true) 
            return
        elseif (houseAmount > 16) then
            setTimer(finishGame, 3000, 1)
            return    
        end
    else
        setTimer(finishGame, 3000, 1)    
    end 
 
    if (houseAmount <= 16) then
        local card = math.random(1, 52)
        local src = getImagePath(card)
        local amount = getCardAmount(card)
        casinoBj.staticimage[9] = guiCreateStaticImage(157, 168, 45, 64, src, false, casinoBj.window[1])
        
        if (amount == "Ace") then
            if (houseAmount <= 10) then
                amount = 11
            else
                amount = 1    
            end
        end
        houseAmount = houseAmount + amount
        if (houseAmount > 21) then
            outputChatBox("House busted!", 255, 0, 0)
            setTimer(finishGame, 3000, 1, false, true) 
            return
        elseif (houseAmount > 16) then
            setTimer(finishGame, 3000, 1)
            return    
        end
    else
        setTimer(finishGame, 3000, 1)     
    end  
 
    if (houseAmount <= 16) then
        local card = math.random(1, 52)
        local src = getImagePath(card)
        local amount = getCardAmount(card)
        casinoBj.staticimage[10] = guiCreateStaticImage(202, 168, 45, 64, src, false, casinoBj.window[1])
        
        if (amount == "Ace") then
            if (houseAmount <= 10) then
                amount = 11
            else
                amount = 1    
            end
        end
        houseAmount = houseAmount + amount
        if (houseAmount > 21) then
            outputChatBox("House busted!", 255, 0, 0)
            setTimer(finishGame, 3000, 1, false, true) 
            return
        elseif (houseAmount > 16) then
            setTimer(finishGame, 3000, 1)
            return    
        end
    else
        setTimer(finishGame, 3000, 1)    
    end     
end
    
function getImagePath(id)
    if (not id) then return false end
    for ind, ent in ipairs(cardsTable) do
        if (ent.id == id) then
            return ent.src
        end
    end
end    

function getCardAmount(id)
    if (not id) then return false end
    for ind, ent in ipairs(cardsTable) do
        if (ent.id == id) then
            return ent.amount
        end
    end
end 

function aceLow()
    totalAmount = totalAmount + 1
    
    if (totalCards == 5) then
        stay()
    elseif (totalCards == 2) then
        guiSetVisible(casinoBj.button[2], true)
        guiSetVisible(casinoBj.button[3], true)       
    elseif (totalAmount == 21) then
        blackJack = true
        finishGame()
    elseif (totalAmount <= 21) then
        guiSetProperty( casinoBj.button[2], "Disabled", "False" )
        guiSetProperty( casinoBj.button[3], "Disabled", "False" )   
    end 
    guiSetVisible(casinoBj.button[5], false)
    guiSetVisible(casinoBj.button[6], false)  
    outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFYou got $"..totalAmount.."!", 255, 0, 0, true) 
end

function aceHigh()
    totalAmount = totalAmount + 11
    
    if (totalCards == 5) then
        stay()
    elseif (totalCards == 2) then
        guiSetVisible(casinoBj.button[2], true)
        guiSetVisible(casinoBj.button[3], true)       
    elseif (totalAmount == 21) then
        blackJack = true
        finishGame()
    elseif (totalAmount <= 21) then
        guiSetProperty( casinoBj.button[2], "Disabled", "False" )
        guiSetProperty( casinoBj.button[3], "Disabled", "False" )   
    end
    guiSetVisible(casinoBj.button[5], false)
    guiSetVisible(casinoBj.button[6], false)
    outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFYou got $"..totalAmount.."!", 255, 0, 0, true) 
end

local finished = false
function finishGame(busted, houseBusted)
    if (finished) then return end
    finished = true
    if (busted) then
        outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFHouse won, you busted!", 255, 0, 0, true) 
    elseif (houseBusted) then
        local betAm = betAm * 2 
        outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFHouse busted, you won $"..betAm.."!", 255, 0, 0, true)  
        triggerServerEvent("GTIblackjack.giveProfit", localPlayer, betAm)   
    elseif (totalAmount < houseAmount) then
        outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFHouse won, you lost your money.", 255, 0, 0, true)   
    elseif (houseAmount < totalAmount) then
        local betAm = betAm * 2
        outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFYou won $"..betAm.."!", 255, 0, 0, true)  
        triggerServerEvent("GTIblackjack.giveProfit", localPlayer, betAm)
    elseif (houseAmount == totalAmount) then
        outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFDraw, you will get your bet back.!", 255, 0, 0, true)  
        triggerServerEvent("GTIblackjack.giveProfit", localPlayer, betAm)    
    elseif (blackjack) then
        local betAm = betAm * 2 
        outputChatBox(guiGetText(casinoBj.label[8])..": #FFFFFFYou won $"..betAm.."!", 255, 0, 0, true)
        triggerServerEvent("GTIblackjack.giveProfit", localPlayer, betAm)     
    end 
    betAm = 0    
    totalCards = 0
    totalAmount = 0 
    houseAmount = 0
    houseBlackjack = false
    blackjack = false
    guiSetProperty( casinoBj.button[1], "Disabled", "False" )
    guiEditSetReadOnly(casinoBj.edit[1], false) 
    setTimer(disableFinish, 500, 1)
    deleteImg()  
end

function close()
    betAm = 0    
    totalCards = 0
    totalAmount = 0
    houseAmount = 0
    houseBlackjack = false 
    blackjack = false
    guiSetProperty( casinoBj.button[1], "Disabled", "False" )
    guiEditSetReadOnly(casinoBj.edit[1], false) 
    setTimer(disableFinish, 500, 1)
    deleteImg()
    openGUI()
end    

function disableFinish()
    finished = false
end    

function enableButtons()
    guiSetProperty( casinoBj.button[2], "Disabled", "False" )
    guiSetProperty( casinoBj.button[3], "Disabled", "False" )
end   
    