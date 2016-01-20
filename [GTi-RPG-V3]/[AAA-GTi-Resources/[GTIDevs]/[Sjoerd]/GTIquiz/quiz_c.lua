    addEventHandler("onClientResourceStart", resourceRoot,
    function()
        quizWindow = guiCreateWindow(209, 188, 527, 192, "Quiz Admin", false)
        guiWindowSetSizable(quizWindow, false)

        questionLbl = guiCreateLabel(8, 25, 163, 19, "Question:", false, quizWindow)
        guiSetFont(questionLbl, "default-bold-small")
        questionEdit = guiCreateEdit(9, 44, 289, 27, "", false, quizWindow)
        answerLbl = guiCreateLabel(8, 71, 163, 19, "Answer:", false, quizWindow)
        guiSetFont(answerLbl, "default-bold-small")
        answerEdit = guiCreateEdit(9, 90, 289, 27, "", false, quizWindow)
        priceLbl = guiCreateLabel(8, 117, 163, 19, "Price:", false, quizWindow)
        guiSetFont(priceLbl, "default-bold-small")
        priceEdit = guiCreateEdit(9, 136, 121, 27, "", false, quizWindow)
        
        timerCheck = guiCreateCheckBox(319, 44, 15, 17, "", false, false, quizWindow)
        timerLbl = guiCreateLabel(338, 44, 151, 21, "Set timer (sec)", false, quizWindow)
        guiSetFont(timerLbl, "default-bold-small")
        timerEdit = guiCreateEdit(426, 43, 81, 28, "", false, quizWindow)
        guiEditSetReadOnly(timerEdit, true)
        
        startBtn = guiCreateButton(323, 103, 72, 27, "Start", false, quizWindow)
        guiSetFont(startBtn, "default-bold-small")
        guiSetProperty(startBtn, "NormalTextColour", "FFAAAAAA")
        stopBtn = guiCreateButton(405, 103, 72, 27, "Stop", false, quizWindow)
        guiSetFont(stopBtn, "default-bold-small")
        guiSetProperty(stopBtn, "NormalTextColour", "FFAAAAAA")
        clearBtn = guiCreateButton(323, 140, 72, 27, "Clear", false, quizWindow)
        guiSetFont(clearBtn, "default-bold-small")
        guiSetProperty(clearBtn, "NormalTextColour", "FFAAAAAA")
        close2Btn = guiCreateButton(405, 140, 72, 27, "Close", false, quizWindow)
        guiSetFont(close2Btn, "default-bold-small")
        guiSetProperty(close2Btn, "NormalTextColour", "FFAAAAAA")
        answerBtn = guiCreateButton(241, 140, 72, 27, "Answers", false, quizWindow)
        guiSetFont(answerBtn, "default-bold-small")
        guiSetProperty(answerBtn, "NormalTextColour", "FFAAAAAA")    
        guiSetVisible(quizWindow, false)
        
        answerWindow = guiCreateWindow(334, 183, 385, 487, "Quiz Answers", false)
        guiWindowSetSizable(answerWindow, false)

        answerGrid = guiCreateGridList(10, 20, 365, 407, false, answerWindow)
        playerColumn = guiGridListAddColumn(answerGrid, "Player:", 0.5)
        answerColumn = guiGridListAddColumn(answerGrid, "Answer:", 0.5)    
        closeBtn = guiCreateButton(130, 442, 123, 35, "Close", false, answerWindow)
        guiSetProperty(closeBtn, "NormalTextColour", "FFAAAAAA")    
        guiSetVisible(answerWindow, false)
    end
)


addEvent("openQuizGUI",true)
function openQuizPanel(thePlayer)  
    if (guiGetVisible(quizWindow)) then  
        guiSetVisible(quizWindow, false)
        showCursor(false)
    else
        guiSetVisible(quizWindow, true)
        showCursor(true)       
    end
end
addEventHandler( "openQuizGUI", root, openQuizPanel )


function buttonHandling()
    if (source == startBtn) then
        local question = guiGetText(questionEdit)
        local answer = guiGetText(answerEdit)  
        local price = guiGetText(priceEdit)
        local timer = guiCheckBoxGetSelected(timerCheck)
        if guiGetText(questionEdit) == "" then return end
        if guiGetText(answerEdit) == "" then return end
        if (timer) then
            time = guiGetText(timerEdit) 
            triggerServerEvent("startQuiz", localPlayer, localPlayer, question, answer, price, timer, time)
        else
            guiGridListClear(answerGrid)
            triggerServerEvent("startQuiz", localPlayer, localPlayer, question, answer, price, timer)
        end
    elseif (source == stopBtn) then
    guiSetText(questionEdit, "")
    guiSetText(answerEdit, "")
    guiSetText(priceEdit, "")
    guiSetText(timerEdit, "")
    guiSetEnabled(stopBtn, false)
        triggerServerEvent("stopQuiz", localPlayer, localPlayer)
    elseif (source == clearBtn) then
        guiSetText(questionEdit, "")
        guiSetText(answerEdit, "")
        guiSetText(priceEdit, "")   
    guiSetText(timerEdit, "") 
    elseif (source == answerBtn) then
        guiSetVisible(answerWindow, true)
        guiSetVisible(quizWindow, false)
    elseif (source == closeBtn) then
        guiSetVisible(answerWindow, false)
        guiSetVisible(quizWindow, true)   
    elseif (source == close2Btn) then
        guiSetVisible(quizWindow, false)
        showCursor(false)
    end
end
addEventHandler("onClientGUIClick", root, buttonHandling)


function addAnswers(player, answer)
    local row = guiGridListAddRow(answerGrid)
    guiGridListSetItemText(answerGrid, row, playerColumn, player, false, false)
    guiGridListSetItemText(answerGrid, row, answerColumn, answer, false, false)
end
addEvent("addAnswer", true)
addEventHandler("addAnswer", root, addAnswers)


function deleteAnswer()
    guiGridListClear(answerGrid)
end
addEvent("deleteAnswers", true)
addEventHandler("deleteAnswers", resourceRoot, deleteAnswer)


addEventHandler( "onClientGUIClick", resourceRoot,
function ()
    if (source == timerCheck) then
        if guiCheckBoxGetSelected(source) then
            guiEditSetReadOnly(timerEdit, false)
        else
            guiEditSetReadOnly(timerEdit, true)
            guiSetText(timerEdit, "")
        end
    end
end
)


addEventHandler( "onClientGUIChanged", root,
    function( theElement)
        if theElement == priceEdit then
            local text = guiGetText( source)
            guiSetText( source, text:gsub("[^0-9]",""))
        elseif theElement == timerEdit then
            local text = guiGetText( source)
            guiSetText( source, text:gsub("[^0-9]",""))
        end
    end
)





