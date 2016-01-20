addEvent( "onChangeClothesCJ", true )
addEventHandler( "onChangeClothesCJ", root,
function ( CJClothesTable, CJClothesString )
    if ( CJClothesTable ) then
        for int, index in pairs( CJClothesTable ) do
            local texture, model = getClothesByTypeIndex ( int, index )
            if ( texture ) then
                addPedClothes ( source, texture, model, int )
		if (int == 0) then	
			exports.GTIaccounts:SAD(getPlayerAccount(source), "cjclothesShirtType", int)
			exports.GTIaccounts:SAD(getPlayerAccount(source), "cjclothesShirtIndex", index)
		end	
            end
        end
        --outputDebugString(CJClothesString)
        exports.GTIaccounts:SAD(getPlayerAccount(source), "cjclothes", CJClothesString)
    end
end
)

addEvent( "onPlayerBougtSkin", true )
addEventHandler( "onPlayerBougtSkin", root,
function ( thePrice ) 
    if ( thePrice ) then
        exports.GTIbank:TPM( source, tonumber(thePrice), "CJ Clothes" )
    end
end
)

function setClothesOnLogin(_, acc)
    local skin = exports.GTIaccounts:GAD(acc, "skin")
    if (skin == 0) then
        local CJCLOTTable = fromJSON( tostring( exports.GTIaccounts:GAD(acc, "cjclothes" ) ) )
        if CJCLOTTable then
            for theType, index in pairs( CJCLOTTable ) do
                local texture, model = getClothesByTypeIndex ( theType, index )
		if ( texture and model ) then
              	  addPedClothes ( source, texture, model, theType )
		end
            end
        end
	local shirt = exports.GTIaccounts:GAD(acc, "cjclothesShirtType")
	if (shirt and shirt == 0) then	
		local shirtIndex = exports.GTIaccounts:GAD(acc, "cjclothesShirtIndex")
		local text, mod = getClothesByTypeIndex ( shirt, shirtIndex )
		if ( text and mod) then
			addPedClothes ( source, text, mod, shirt )
		end
	end	
    end
end
addEventHandler("onPlayerLogin", root, setClothesOnLogin)
