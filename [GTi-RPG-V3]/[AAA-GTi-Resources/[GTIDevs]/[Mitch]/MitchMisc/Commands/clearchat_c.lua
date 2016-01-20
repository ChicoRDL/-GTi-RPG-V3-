
function clearChat ( )
    exports.GTIhud:dm ( "Chat is cleaned up!", 200, 100, 0 )
    for i=1,40 do 
        outputChatBox(" ")
	end
end
addCommandHandler ("clearchat", clearChat )