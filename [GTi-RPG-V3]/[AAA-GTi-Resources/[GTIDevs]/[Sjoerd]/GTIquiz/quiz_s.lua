local running = false
local quizAnswer = ""
local quizPrice = 0


function speakercommand(thePlayer)
    if ( exports.GTIutil:isPlayerInACLGroup(thePlayer, "Event1", "Admin2", "Admin3", "Admin4", "Admin5", "Dev5", "Dev1" ) ) then
        triggerClientEvent ( thePlayer, "openQuizGUI", thePlayer )
    end
end
addCommandHandler ("quizadm", speakercommand)




function startQuiz(player, question, answer, price, timer, time)
    if (running == true) then
        outputChatBox("There is already a quiz going on.", player, 255, 0, 0)
    return end
    running = true
    quizAnswer = answer
    quizPrice = tonumber(price) or tonumber(0)
    local quizMaster = getPlayerName(player)


    outputChatBox("(QUIZ) "..quizMaster..": #FFFFFF"..question, root, 255, 0, 0, true)
    outputChatBox("Use /answ <answer> to give the right answer.", root, 255, 0, 0)
    triggerClientEvent("deleteAnswers", root)
    if (timer) then
        ttime = time * 1000
        quizTimer = setTimer(timesUp, ttime, 1)
    end
end
addEvent("startQuiz", true)
addEventHandler("startQuiz", root, startQuiz)


function timesUp()
    if (running == false) then return end
    outputChatBox("(QUIZ)#FFFFFF Time's up, the right answer was: "..quizAnswer, root, 220, 0, 0, true)
    running = false
end

function stopQuiz(player)
    if (running == false) then return end
    local playerName = getPlayerName(player)
    outputChatBox(playerName.." has stopped the quiz.", root, 150, 0, 0)
    running = false
end
addEvent("stopQuiz", true)
addEventHandler("stopQuiz", root, stopQuiz)


function answerQuiz(player, cmd, a, b, c, d, e, f, g, h, i)
    if (running == false) then return end
    if (not a) then return end

    if (i) then
        answer = a.." "..b.." "..c.." "..d.." "..e.." "..f.." "..g.." "..h.." "..i
    elseif (h) then
        answer = a.." "..b.." "..c.." "..d.." "..e.." "..f.." "..g.." "..h
    elseif (g) then
        answer = a.." "..b.." "..c.." "..d.." "..e.." "..f.." "..g
    elseif (f) then
        answer = a.." "..b.." "..c.." "..d.." "..e.." "..f
    elseif (e) then
        answer = a.." "..b.." "..c.." "..d.." "..e
    elseif (d) then
        answer = a.." "..b.." "..c.." "..d
    elseif (c) then
        answer = a.." "..b.." "..c
    elseif (b) then
        answer = a.." "..b
    elseif (a) then
        answer = a
    end

    local playerName = getPlayerName(player)
    triggerClientEvent("addAnswer", root, playerName, answer)
    outputChatBox("You answered: "..answer, player, 195, 168, 0)

    if (string.lower(quizAnswer) == string.lower(answer)) then
        local playerName = getPlayerName(player)
        outputChatBox(playerName.." has answered the question and won $"..quizPrice, root, 255, 0, 0)
        outputChatBox("The right answer was: #FFFFFF"..answer, root, 200, 0, 0, true)
        running = false
        if (isTimer(quizTimer)) then
            killTimer(quizTimer)
        end    
        if (quizPrice == 0) then return end
        if (quizPrice > 0 and quizPrice < 10001) then
            exports.GTIbank:GPM(player, quizPrice, "Won the quiz.")
        end

    end
end
addCommandHandler("answ", answerQuiz)
