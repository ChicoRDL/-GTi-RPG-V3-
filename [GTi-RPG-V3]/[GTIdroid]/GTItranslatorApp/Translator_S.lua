----------------------------------------->>
-- Grand Theft International (GTi)
-- Author: Ares
-- Date: 10 Jul 2015
----------------------------------------->>

addEvent("GTItranslatorApp.translate", true)
addEventHandler("GTItranslatorApp.translate", resourceRoot, 
	function ( table )
		local message = table[1]
		local language = table[2]
		local translationType = table[3]
		
		fetchRemote ( "http://api.mymemory.translated.net/get?q=" .. exports.GTIutil:urlEncode( message ) .. "&langpair=" .. language .. "&mt=" .. translationType .. "&ip=" .. getPlayerIP( client ), callBack, "", false, client )
	end
)


function callBack ( data, error, player )
	if ( error == 0 ) then
		local data = fromJSON ( data )
		triggerClientEvent(player, "GTItranslatorApp.receiveTranslation", resourceRoot, data.responseData.translatedText )
	else
		triggerClientEvent(player, "GTItranslatorApp.receiveTranslation", resourceRoot, "failed translation error #"..error )
	end
end

