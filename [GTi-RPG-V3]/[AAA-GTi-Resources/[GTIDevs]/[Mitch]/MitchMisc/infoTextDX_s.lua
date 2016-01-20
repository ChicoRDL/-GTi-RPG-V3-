function create3DText ( str, pos, color, parent, settings ) 
    if str and pos and color then
        local text = createElement ( '3DText' )
        local settings = settings or  { }
        setElementData ( text, "text", str )
        setElementData ( text, "position", pos )
        setElementData ( text, "color", color )
        if ( not parent ) then
            parent = nil
        else
            if ( isElement ( parent ) ) then
                parent = parent
            else
                parent = nil
            end
        end
        setElementData ( text, "Settings", settings )
        setElementData ( text, "parentElement", parent )
        setElementData ( text, "sourceResource", sourceResource or getThisResource ( ))
        return text
    end
    return false
end

exports.MitchMisc:create3DText  ( "Police Activity", {1542.659, -1619.674, 12.555+1}, { 15, 100, 255 }, { nil, true } )
exports.MitchMisc:create3DText  ( "Defusing a Bomb", {1547.930, -1619.690, 12.547+1}, { 15, 100, 255 }, { nil, true } )