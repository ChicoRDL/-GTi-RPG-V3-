-- #######################################
-- ## Name: 	dxMoveable			    ##
-- ## Author:	Stivik					##
-- #######################################

dxMoveable = {
	elements = {}
}
function dxMoveable:createMoveable (w, h, b)
	local self = setmetatable({
		renderTarget = dxCreateRenderTarget(w, h, b),
		posX = 0,
		posY = 0,
		w = w,
		h = h,
		cursorOffX = 0,
		cursorOffY = 0,
		alpha = 100
	}, {
		__index = self
	})
	
	if not dxMoveable.renderFunc then
		dxMoveable.renderFunc = bind(dxMoveable.render, dxMoveable)
		addEventHandler("onClientRender", root, dxMoveable.renderFunc)
	end
	
	table.insert(dxMoveable.elements, 1, self)
	
	return self;
end

function dxMoveable:destroyElement ()
	if isElement(self.renderTarget) then
		dxSetRenderTarget(self.renderTarget, true)
			-- Clear it.
		dxSetRenderTarget()
		
		destroyElement(self.renderTarget)
	end

	if table.find(dxMoveable.elements, self) then 
		table.remove(dxMoveable.elements, table.find(dxMoveable.elements, self))
	end
	
	if table.getn(dxMoveable.elements) == 0 then
		removeEventHandler("onClientRender", root, dxMoveable.renderFunc)
		dxMoveable.renderFunc = nil
	end
end

function dxMoveable:render ()
	if Cursor.active then
		local currElement = nil
		for i, v in ipairs(self.elements or {}) do
			if isCursorOverRectangle(v.posX, v.posY, v.w , v.h) then
				--error("YEAH")
				currElement = v
				break;
			end
		end
		

		currElement = Cursor.currElement or currElement
		
		if currElement then
			if Cursor.currElement == currElement then
				currElement.alpha = 150
				currElement.posX, currElement.posY = Cursor.newX + currElement.cursorOffX, Cursor.newY + currElement.cursorOffY
			else
				if currElement.alpha == 150 then
					currElement.alpha = 100
				end
			end
			
			if not ((currElement.posX >= 0) and (currElement.posX <= (screenW - currElement.w)) and (currElement.posY >= 0) and (currElement.posY <= (screenH - currElement.h))) then
				dxDrawRectangle(currElement.posX - 10, currElement.posY - 10, currElement.w + 20, currElement.h + 20, tocolor(125, 0, 0, currElement.alpha))
			elseif not ((currElement.posX - 10 >= 0) and (currElement.posX + 10 <= (screenW - currElement.w)) and (currElement.posY - 10 >= 0) and (currElement.posY + 10 <= (screenH - currElement.h))) then
				dxDrawRectangle(currElement.posX - 10, currElement.posY - 10, currElement.w + 20, currElement.h + 20, tocolor(254, 138, 0, currElement.alpha))
			else
				dxDrawRectangle(currElement.posX - 10, currElement.posY - 10, currElement.w + 20, currElement.h + 20, tocolor(255, 255, 255, currElement.alpha))
			end
		end
	end
end




-- Work in Progress...
--[[
dxElements = {
	elements = {}
}

function dxElements:createElement (type, title, x, y, w, h, color, postgui, ...)
	local self = setmetatable({}, {__index = self})
	self.type = string.lower(type)
	self.title = tostring(title) or "Unnamed"
	self.color = color or tocolor(255, 255, 255, 255)
	self.postgui = postgui or false
	self.x = tonumber(x) or 0
	self.y = tonumber(y) or 0
	self.w = tonumber(w) or 100
	self.h = tonumber(h) or 100
	
	self.element = dxMoveable:createMoveable(self.w, self.h, true)
	self.element.posX = self.x
	self.element.posY = self.y
	self.element.w = self.w
	self.element.h = self.h
	
	if self.type == "window" then
		self:createWindow(...)
	--elseif (...) then
	end
	
	if not dxElements.renderFunc then
		dxElements.renderFunc = bind(dxElements.render, dxElements)
		addEventHandler("onClientRender", root, dxElements.renderFunc)
	end
	
	return self;
end

function dxElements:destroyElement ()
end

function dxElements:render ()
	for i, v in ipairs(self.elements or {}) do
		if v.type == "window" then
			dxDrawImage(v.element.posX, v.element.posY, v.element.w, v.element.h, v.element.renderTarget)
		--elseif (...) then
		end
	end
end

function dxElements:update ()
	if self.type == "window" then
		dxSetRenderTarget(self.element.renderTarget, true)
			dxSetBlendMode("modulate_add")
			
			for i, v in ipairs(self.toDraw) do
				for i, v in ipairs(v) do
					if v[1] == "rectangle" then
						dxDrawRectangle(unpack(v, 2))
					elseif v[1] == "text" then
						dxDrawText(unpack(v, 2))
					elseif v[1] == "line" then
						dxDrawLine(unpack(v, 2))
					elseif v[1] == "image" then
						dxDrawImage(unpack(v, 2))
					end
				end
			end
				
			dxSetBlendMode("blend")
		dxSetRenderTarget()
	end
end

-- Specific Functions
function dxElements:createWindow (tcolor)
	self.tcolor = tcolor or tocolor(0, 125, 0, 180)

	self.toDraw = {
		
		[ElementID] = {
			{"ElementType", args...},
			{"ElementType", args...},
		}
		
		{
			{"rectangle", 0, 0, self.w, self.h, self.color, self.postgui},
			{"rectangle", 0, 0, self.w, 17, self.tcolor, self.postgui},
			{"text", self.title, 0, 0, self.w, 17, tocolor(255, 255, 255, 255), 1, "default-bold", "center", "center"}
		}
	}

	self.updateFunc = bind(self.update, self)
	addEventHandler("onClientRestore", root, self.updateFunc)
	
	self.updateFunc()
	table.insert(dxElements.elements, self)
end

--local window = dxElements:createElement("window", "Test-Window", 100, 100, 250, 250, tocolor(0, 0, 0, 200), false, tocolor(0, 125, 0, 180))
--]]