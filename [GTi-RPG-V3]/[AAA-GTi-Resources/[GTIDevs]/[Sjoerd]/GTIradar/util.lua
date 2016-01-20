-- #######################################
-- ## Name: 	Cursor				    ##
-- ## Author:	Stivik					##
-- #######################################

function table.find(tab, value)
	for k, v in pairs(tab) do
		if v == value then
			return k
		end
	end
	return nil
end

function isCursorOverRectangle (x, y, w, h)
	local cX, cY = getCursorPosition()
	if isCursorShowing() then
		return ((cX*screenW > x) and (cX*screenW < x + w)) and ( (cY*screenH > y) and (cY*screenH < y + h));
	else
		return false;
	end
end