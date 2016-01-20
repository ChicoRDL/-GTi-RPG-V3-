MAIN_MENU_NAME = "VEHICLE TUNING"
function loadFonts ()
	FONT = guiCreateFont("FONT.ttf",12,true)
	FONT_SMALL = guiCreateFont("FONT.ttf",10)
	DX_TEXT_SMALL = dxCreateFont("FONT.ttf",10)
	---
	outputDebugString("The Best ModShop is OPEN! Come and check our products!")
	---
	doGarages()
end
addEventHandler("onClientResourceStart",resourceRoot,loadFonts)
---
DW = 260
DH = 30
_DX = 15
_DY = 20
---
local BLIP_DIS = 300
blips = {}
garageElements = {}

GARAGES__ = {
{0,285},
{3,285},
{6,285},
{7,285},
{8,285},
{15,285},
{18,285},
{19,285},
{20,285},
{24,285},
{27,285},
{32,285},
{33,285},
{35,285},
{36,285},
{40,285},
{41,285},
{47,1},
}

function doGarages()
	for m,a in ipairs ( GARAGES__ ) do
		rot = a[2]
		i = a[1]
		setGarageOpen(i, true)
		--local westX, eastX, southY, northY = getGarageBoundingBox(i)
		local posX, posY, posZ = getGaragePosition(i)
		blips[i] = createBlip(posX, posY, posZ,27,1,255,255,255,255,100,BLIP_DIS)
		local size1, size2, size3 = getGarageSize(i)
		--outputConsole("Garage " .. i .. ": bounding box = " .. westX .. " " .. eastX .. " " .. southY .. " " .. northY .. ", position = " .. posX .. " " .. posY .. " " .. posZ .. ", size = " .. size1 .. " " .. size2 .. " " .. size3)
		--outputConsole("Garage " .. i .. ": size = " .. size1 .. " " .. size2 .. " " .. size3)
		size1, size2, size3 = 10, 10, 5 -- getGarageSize() returns numbers that are way too big.. so let's make it 10
		-- fixes for problem garages:
		if (i == 18 or i == 19) then -- wang's fender and wang's spray
			posY = posY - 10
		end
		if (i == 21) then -- wang's fender and wang's spray
			size1 = 22
		end
		if (i == 22) then
			size1 = 20
			size2 = 32
		end
		garageElements[i] = {}
		garageElements[i].col = createColCuboid(posX, posY, posZ, size1, size2, size3)
		addEventHandler("onClientColShapeHit", garageElements[i].col, onGarageHit)
		setElementData(garageElements[i].col,"GarageID",i)
		setElementData(garageElements[i].col,"GarageROT",rot)
	end
end

function onGarageHit(element,match)
	if element and match then
		if getElementType(element) == "vehicle" then
			local controller = getVehicleController(element)
			if controller == localPlayer then
				local _,__,rot = getElementRotation(element)
				if rot then
				--	EX_ROT = rot
					setElementData(element,"ROTo",rot)
				end
				triggerServerEvent("playerTune",localPlayer,localPlayer,getElementData(source,"GarageROT"))
			end
	--		playerTune(element,getElementData(source,"ROT"))
			
		end
	end
end

function executefunction(funcname, ...)
	if tostring(funcname) then
		local arg = { ... }
		if (arg[1]) then
			for key, value in next, arg do arg[key] = tonumber(value) or value end
		end
		loadstring("return "..funcname)()(unpack(arg))
	end
end

function saveMenu()
	if _MENU_ then
		if  _MENU_[1] then
			if _MENU_[1].text then
				EX_MENU = _MENU_[1].text
			end
		end
	end
end

function backMenu()
	if _MENU_ then
		if EX_MENU then
			if _MENU_[1].text ~= EX_MENU then
				setUpMenu(EX_MENU,false,true)
			else
				setUpMenu(MAIN_MENU_NAME,true,true)
			end
		else
			setUpMenu(MAIN_MENU_NAME,true,true)
		end
		restoreUpgrades()
		closeSure()
	end
end

addEvent("showCarTune",true)
addEventHandler("showCarTune",root,function(car)
	if car then
		PLAYER_VEHICLE = car
		createMainMenu()
		saveUpgrades()
		SHOP_MUSIC = playSound("MUSIC.mp3",true)
		fadeCamera(false,0, 0, 0, 0)
		handlePlayerCam()
		setTimer(fadeCamera,2000,1,true,0.5)
	end
end )

camon = false
function handlePlayerCam()
	if PLAYER_VEHICLE then
		if not camon then
			startCamera( )
			camon = true
		end
	end
end

function onMenuExit()
	stopCamera()
	camon = false
	showChat(true)
	showCursor(false)
	restoreUpgrades()
	stopSound(SHOP_MUSIC)
	triggerServerEvent("onMenuExit",localPlayer)
	CLEARING = 0
	--stopRotatingCamera( )
end
addEvent("exitMenu",true)
addEventHandler("exitMenu",root,onMenuExit)

function getPositionFromElementOffset(element,offX,offY,offZ)
	local m = getElementMatrix ( element )  -- Get the matrix
	local x = offX * m[1][1] + offY * m[2][1] + offZ * m[3][1] + m[4][1]  -- Apply transform
	local y = offX * m[1][2] + offY * m[2][2] + offZ * m[3][2] + m[4][2]
	local z = offX * m[1][3] + offY * m[2][3] + offZ * m[3][3] + m[4][3]
	return x, y, z                               -- Return the transformed point
end

function findRotation(x1,y1,x2,y2)
 
  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;
 
end


function smoothmofo()
	if not _MENU_ then return end
	addedddd = true
	if ratio < 1 then
		ratio = ratio + 0.035; -- increase to move the camera faster
		xx,yy,zz = getCameraMatrix()
		ix1,iy1,iz1 = interpolateBetween( xx,yy,zz, nx1,ny1,nz1, ratio, "Linear" )
		ix2,iy2,iz2 = interpolateBetween( x2,y2,z2, nx2,ny2,nz2, ratio, "Linear" )
		setCameraMatrix( ix1,
		iy1,
		iz1,
		ix2,
		iy2,
		iz2,
		rot or 0  )
	elseif ratio >= 1 then
		removeEventHandler("onClientRender",root,smoothmofo)
		addedddd = false
		--x1,y1,z1,x2,y2,z2,rot = CAM_POSz[CAM_POZ][1],CAM_POSz[CAM_POZ][2],CAM_POSz[CAM_POZ][3],CAM_POSz[CAM_POZ][4],CAM_POSz[CAM_POZ][5],CAM_POSz[CAM_POZ][6],CAM_POSz[CAM_POZ][7]
	end
end

function modifyCam( )
		CAM_POZ = CAM_POZ or 'HOOD'
		if not oCAM_POZ then
			oCAM_POZ = CAM_POZ
		end
		if not x1 then 	x1,y1,z1,x2,y2,z2,rot = CAM_POSz[CAM_POZ][1],CAM_POSz[CAM_POZ][2],CAM_POSz[CAM_POZ][3],CAM_POSz[CAM_POZ][4],CAM_POSz[CAM_POZ][5],CAM_POSz[CAM_POZ][6],CAM_POSz[CAM_POZ][7] end
		
		if ratio and ratio >= 1 then
			x1,y1,z1,x2,y2,z2,rot = CAM_POSz[oCAM_POZ][1],CAM_POSz[oCAM_POZ][2],CAM_POSz[oCAM_POZ][3],CAM_POSz[oCAM_POZ][4],CAM_POSz[oCAM_POZ][5],CAM_POSz[oCAM_POZ][6],CAM_POSz[oCAM_POZ][7]
			nx1,ny1,nz1 = CAM_POSz[CAM_POZ][1],CAM_POSz[CAM_POZ][2],CAM_POSz[CAM_POZ][3]
			nx2,ny2,nz2,rot = CAM_POSz[CAM_POZ][4],CAM_POSz[CAM_POZ][5],CAM_POSz[CAM_POZ][6],CAM_POSz[CAM_POZ][7]
			ratio = 0.0
		else
			x1,y1,z1 = getCameraMatrix()
			nx1,ny1,nz1 = CAM_POSz[CAM_POZ][1],CAM_POSz[CAM_POZ][2],CAM_POSz[CAM_POZ][3]
			nx2,ny2,nz2,rot = CAM_POSz[CAM_POZ][4],CAM_POSz[CAM_POZ][5],CAM_POSz[CAM_POZ][6],CAM_POSz[CAM_POZ][7]
			ratio = 0.0
		end
	--	x1,y1,z1,x2,y2,z2,rot = CAM_POSz[CAM_POZ][1],CAM_POSz[CAM_POZ][2],CAM_POSz[CAM_POZ][3],CAM_POSz[CAM_POZ][4],CAM_POSz[CAM_POZ][5],CAM_POSz[CAM_POZ][6],CAM_POSz[CAM_POZ][7]
	--	setCameraMatrix( x1,y1,z1,x2,y2,z2,rot or 0  )
		if not addedddd then
			addEventHandler("onClientRender",root,smoothmofo)
		end 
end

function getRotation(x, y, dist, angle)
  local a = math.rad(90 - angle)
  local dx = math.cos(a) * dist
  local dy = math.sin(a) * dist
  return x+dx, y+dy
end
function startCamera( )
	modifyCam()
end
 
function stopCamera( )
	fadeCamera(false,0, 0, 0, 0)
	setCameraTarget(localPlayer)
	setTimer(fadeCamera,2000,1,true,0.5)
	setTimer(setCameraTarget,2001,1,localPlayer)
end
 
function killMenu()
	if _MENU_ then
		closeSure()
		for i,v in ipairs(getElementsByType("gui-button")) do
			if getElementData(v,"DX_NUM") then
				destroyElement(v)
			end
		end
		for i,v in ipairs(getElementsByType("gui-label")) do
			if getElementData(v,"DX_NUM") then
				destroyElement(v)
			end
		end
		--
		_MENU_ = {}
		_TEXTS_ = {}
		_BUTTONS_ = {}
		_PTEXTS_ = {}
	end
end


function createMenu(Name,extended,back)
	if Name then
		CAM_POZ = Name
		if not back then
			saveMenu()	
		end
		--
		killMenu()
		--
		showChat(false)
		showCursor(true)
		--
		_MENU_ = {}
		_TEXTS_ = {}
		_BUTTONS_ = {}
		_PTEXTS_ = {}
		----------
		if not FONT then loadFonts() end
		_MENU_[1] = {
			x=_DX,
			y=_DY,
			width=DW,
			height=DH,
			color=tocolor(0, 0, 0, 200),
			text = Name,
			font = FONT
		} 
		--
		if Name ~= MAIN_MENU_NAME then
			daText = "Back"
		else
			daText = "Exit"
		end
		_MENU_[2] = {
			x=_DX,
			y=DH + _DY,
			width=DW,
			height=DH,
			color=tocolor(0, 0, 0, 200),
			text = daText,
			font = FONT
		} 
	end
end

function addItem(name,itemprice,main,func,upid)
	if _MENU_ then
		if #_MENU_ > 2 then
			if itemprice then
				if tonumber(itemprice) then
					itemprice = tonumber(itemprice) * 3.5
				end
			end
			if main then
				daText = "Exit"
			else
				daText = "Back"
			end
			last = _MENU_[#_MENU_]
			if last then
				local x,y = last.x,last.y
				iY = y + DH
				table.insert( _MENU_, {
					x=15,
					y=iY,
					width=DW,
					height=DH,
					color=tocolor(0, 0, 0, 130),
					text = name,
					font = FONT_SMALL,
					func = func,
					price = itemprice,
					upid = upid,
				} )
				---
				if _TEXTS_[2] then
					if isElement( _TEXTS_[2]) then
						destroyElement(_TEXTS_[2])
					end
				end
				if _BUTTONS_[2] then
					if isElement(_BUTTONS_[2]) then
						destroyElement(_BUTTONS_[2])
					end
				end
				_TEXTS_[2] = nil
				_BUTTONS_[2] = nil
				-----
				if _MENU_[1].text == MAIN_MENU_NAME then
					daText = 'Exit'
				end
				-----
					_MENU_[2] = {
					x=_DX,
					y=DH + iY,
					width=DW,
					height=DH,
					color=tocolor(0, 0, 0, 200),
					text = daText,
					font = FONT
				} 
			end
		else
			lastY = DH + _DY,
				table.insert(_MENU_,{
					x=15,
					y=DH + _DY,
					width=DW,
					height=DH,
					color=tocolor(0, 0, 0, 130),
					text = name,
					font = FONT_SMALL,
					func = func,
					price = itemprice,
					upid = upid,
				} )
			--
			if _TEXTS_[2] then
				if isElement( _TEXTS_[2]) then
					destroyElement(_TEXTS_[2])
				end
			end
			if _BUTTONS_[2] then
				if isElement(_BUTTONS_[2]) then
					destroyElement(_BUTTONS_[2])
				end
			end
			_TEXTS_[2] = nil
			_BUTTONS_[2] = nil
			_MENU_[2] = {
			x=_DX,
			y=DH + lastY,
			width=DW,
			height=DH,
			color=tocolor(0, 0, 0, 200),
			text = daText,
			font = FONT
		} 
		end
	end
end

function createText(num,x,y,w,h,text,font)
	if num and x and y and w and h and text then
		if num > 2 then
			plus = 20
		else
			plus = 10
		end
		_TEXTS_[num] = guiCreateLabel(x + plus,y + 5,w,h,string.upper(text),false)
		setElementData(_TEXTS_[num],"DX_NUM",num)
		if font then
			guiSetFont(_TEXTS_[num],font)
		end
	end
end

function createButton(num,x,y,w,h,text,func,price,upid)
	if num and x and y and w and h and text then
		if num == 1 then return end
		if _BUTTONS_[num] then return end
		_BUTTONS_[num] = guiCreateButton(x,y,w,h,string.upper(text),false)
		guiSetAlpha(_BUTTONS_[num],0)
		setElementData(_BUTTONS_[num],"DX_NUM",num)
		if func then
			setElementData(_BUTTONS_[num],"DX_FUNC",func)
		end
		if upid then
			setElementData(_BUTTONS_[num],"DX_UPID",upid)
		end
		if price then
			setElementData(_BUTTONS_[num],"DX_PRICE",price)
		end
		setElementData(_BUTTONS_[num],"DX_WData",toJSON({x,y,w,h}))
		---
		guiBringToFront(_BUTTONS_[num])
	end
end

function getPricePosX(text,xx,x,y)
	if text and xx and x and y then
		local a = xx+x
		local b = dxGetTextWidth(text,1,DX_TEXT_SMALL)
		local c = a - b - 10
		return c,y,b
	end
end


function createPriceText(num,x,y,w,h,text,font)
	if num and x and y and w and h and text then
		_PTEXTS_[num] = guiCreateLabel(x,y + 5,w,h,text,false)
		guiMoveToBack(_PTEXTS_[num])
		setElementData(_PTEXTS_[num],"DX_NUM",num)
		if font then
			guiSetFont(_PTEXTS_[num],font)
		end
	end
end


function createMainMenu()
	setUpMenu(MAIN_MENU_NAME,true,false)
end

addEventHandler("onClientRender", root,
    function()
    	if not _MENU_ then return end
    	for k,v in ipairs ( _MENU_ ) do
    		color = nil
    		if not _TEXTS_[k] then
    			createText(k,v.x, v.y, v.width, v.height,v.text,v.font)
    		end
    		if not _BUTTONS_[k] and k ~= 1 then
    			createButton(k,v.x, v.y, v.width, v.height,v.text,v.func,v.price,v.upid)
    		else
    			if _BUTTONS_[k] then
    				if isElement(_BUTTONS_[k]) and not TO_FRONT then
    					guiBringToFront(_BUTTONS_[k])
    				end
    			end
    		end
    		if v.price and not _PTEXTS_[k] then
    			local pText = "$ "..v.price
    			local px,py,w = getPricePosX(pText, v.x ,v.width ,v.y)
    			createPriceText(k,px, py,w, v.height,pText,v.font)
    		end
    		if _BUTTONS_[k] then
    			SELECTED_BUTTON = getElementData(_BUTTONS_[k],"DX_SEL")
    		end
    		dxDrawRectangle(v.x, v.y, v.width, v.height,color or v.color, false)
    		if _BUTTONS_[k] then
    			if getElementData(_BUTTONS_[k],"DX_SEL") == true then
    				dxDrawRectangle(v.x, v.y, v.width, v.height,tocolor(255,255,255,130), false)
    			end
    		end
    		
    	end
    end
)


local x,y = guiGetScreenSize()
local xx,yy = x / 2 - x / 2 / 4 , y / 2 - y / 2 / 2
sureYes = guiCreateButton(xx,  yy + 172 , 170, 31, "", false)
sureNo = guiCreateButton( xx + 170,  yy + 172 , 170, 31, "", false)
guiBringToFront(sureYes)
guiBringToFront(sureNo)
guiSetAlpha(sureYes,0)
guiSetAlpha(sureNo,0)

SURE_SHOW = false
function showSure(text,trigges,item,upid)
	if text and trigges then
		if SURE_SHOW then closeSure() end
		SURE_TEXT = text
		SURE_SHOW = true
		SURE_TRIGGER = {trigges,item,upid}
		guiBringToFront(sureYes)
		guiBringToFront(sureYes)
	end
end

function closeSure()
	SURE_TEXT = nil
	SURE_SHOW = nil
	SURE_TRIGGER = nil
end

addEventHandler("onClientRender", root,
    function()
   	if SURE_SHOW then
    	local x,y = guiGetScreenSize()
    	local xx,yy = x / 2 - x / 2 / 4 , y / 2 - y / 2 / 2

        dxDrawRectangle(xx, yy, 340, 31, tocolor(0, 0, 0, 200), true)
        dxDrawRectangle(xx, yy + 31, 340, 141, tocolor(0, 0, 0, 130), true)
        dxDrawRectangle(xx, yy + 172, 340, 31, tocolor(0, 0, 0, 200), true)
        if SURE_YES_ENTER then
        	dxDrawRectangle(xx, yy + 172, 170, 31, tocolor(255, 255, 255, 130), true)
        end
        if SURE_NO_ENTER then
        	dxDrawRectangle(xx + 170, yy + 172, 170, 31, tocolor(255, 255, 255, 200), true)
        end
        dxDrawLine(xx + 170, yy + 173 , xx + 170, yy + 173 + 27, tocolor(0, 0, 0, 200), 1, true)
        
        dxDrawText("No", xx + 248, yy + 180 , 498, 443, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("No", xx + 248, yy + 180 , 498, 441, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("No", xx + 248, yy + 180 , 496, 443, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("No", xx + 248, yy + 180 , 496, 441, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("No", xx + 248, yy + 180 , 497, 442, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
       
        dxDrawText("Yes", xx + 80, yy + 180, 342, 448, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("Yes", xx + 80, yy + 180, 342, 446, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("Yes", xx + 80, yy + 180, 340, 448, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("Yes", xx + 80, yy + 180, 340, 446, tocolor(0, 0, 0, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        dxDrawText("Yes", xx + 80, yy + 180, 341, 447, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
        
        dxDrawText(SURE_TEXT, xx + 10, yy + 145, 340, 141, tocolor(0, 0, 0, 255), 1.00, "default", "left", "center", false, false, true, false, false)
        dxDrawText(SURE_TEXT, xx + 10, yy + 145, 340, 141, tocolor(0, 0, 0, 255), 1.00, "default", "left", "center", false, false, true, false, false)
        dxDrawText(SURE_TEXT, xx + 10, yy + 145, 340, 141, tocolor(0, 0, 0, 255), 1.00, "default", "left", "center", false, false, true, false, false)
        dxDrawText(SURE_TEXT, xx + 10, yy + 145, 340, 141, tocolor(0, 0, 0, 255), 1.00, "default", "left", "center", false, false, true, false, false)
        dxDrawText(SURE_TEXT,xx + 10, yy + 145, 340, 141, tocolor(155, 0, 0, 255), 1.00, "default", "left", "center", false, false, true, false, false)

        
        dxDrawText("Are you sure ?", xx + 10, yy + 9, 537, 269, tocolor(0, 155, 0, 255), 0.6, "bankgothic", "left", "top", false, false, true, false, false)

   	end
    end
    
)


addEventHandler("onClientMouseEnter",root,function()
	if getElementType(source) == "gui-button" and tonumber(getElementData(source,"DX_NUM")) then
		setElementData(source,"DX_SEL",true)
		--
		if _MENU_ then
			if _MENU_[1] then
				local menu = _MENU_[1].text
				local text = guiGetText(source)
				if CAM_POSz[text] then
					CAM_POZ = guiGetText(source)
				--	modifyCam()
				else
					CAM_POZ = menu
				--	modifyCam()
				end
			end
		end
		--
		local upid = getElementData(source,"DX_UPID")
		if upid then
			exampleUpgrade(upid)
		end
		--
		playSoundFrontEnd(3)
	elseif source == sureYes then
		SURE_YES_ENTER = true
	elseif source == sureNo then
		SURE_NO_ENTER = true
	end
end )

addEventHandler("onClientMouseLeave",root,function()
	if getElementType(source) == "gui-button" and tonumber(getElementData(source,"DX_NUM")) then
		setElementData(source,"DX_SEL",nil)
		restoreUpgrades()
--	SELECTED_BUTTON = nil
	elseif source == sureYes then
		SURE_YES_ENTER = nil
	elseif source == sureNo then
		SURE_NO_ENTER = nil
	end
end )

addEventHandler("onClientGUIClick",root,function()
	if getElementType(source) == "gui-button" and tonumber(getElementData(source,"DX_NUM")) then
		onDXClick(source)
		if _MENU_ then
			if _MENU_[1] then
				local menu = _MENU_[1].text
				CAM_POZ = menu
			end
		end
	elseif source == sureYes then
		if SURE_TRIGGER then
			executefunction(SURE_TRIGGER[1],SURE_TRIGGER[2],SURE_TRIGGER[3])
		end
		closeSure()
	elseif source == sureNo then
		closeSure()
	end
end )

function onDXClick(gui)
	if gui then
		playSoundFrontEnd(1)
		local text,num,price,func,upid = guiGetText(gui),getElementData(gui,"DX_NUM"),getElementData(gui,"DX_PRICE"),getElementData(gui,"DX_FUNC"),getElementData(gui,"DX_UPID")
		if price then
			onItemBuy(text,price,upid)
		else
			
			if num > 2 then
				if ___MENUS[text] then
					setUpMenu(text,false,false)
					
				else
					setUpMenu(text,false,false)
					executefunction(func,text)
					
				end
				modifyCam()
			else
				if num == 2 then
					if string.lower(text) == "back" then
						backMenu()
						modifyCam()
					else
						killMenu()
						onMenuExit()
					end
				end
			end
			
		end
	end
end

function getTheColor(item)
	rr,gg,bb = false,false,false
	for k,v in ipairs ( ___MENUS['VEHICLE COLOR'] ) do
		local name,price,r,g,b = v[1],v[2],v[3],v[4],v[5]
		if name == item then
			rr,gg,bb = r,g,b
		end
	end
	return rr,gg,bb
end

function onItemBuy(item,price,upid)
	if item and price then
		if item == "NONE" then return end
		local menu = _MENU_[1].text
		upg = false
		for k,v in ipairs ( ___MENUS['VEHICLE UPGRADES'] ) do
			if string.lower(menu) == string.lower(v[1]) then
				upg = true
			end
		end
		if menu ~= 'VEHICLE UPGRADES' then
			if upg == true then
				if upid > 3 then
					local ex = doesUpgradeExist(upid)
					if not ex then
						if checkMoney(price) then
							showSure("Do you want to buy "..item.." By "..price.."$ ?","buyUpgrade",item,upid)
						end
					else
						showSure("You already have "..item.." do you want to remove it ?","removeUpgrade",item,upid)
					end
				else
					if checkMoney(price) then
						showSure("Do you want to buy "..item.." By "..price.."$ ?","buyPaintjob",item,upid)
					end
				end
			end
		end
		if menu == 'VEHICLE UPGRADES' then
			if string.lower(item) == string.lower('Hydraulics') then
				local ex = doesUpgradeExist(1087)
				if not ex then
					if checkMoney(price) then
						showSure("Do you want to buy "..item.." By "..price.."$ ?","buyUpgrade",item,1087)
					end
				else
					showSure("You already have "..item.." do you want to remove it ?","removeUpgrade",item,1087)
				end
			elseif string.lower(item) == string.lower('PLATE NUMBER') then
				showSure("Do you want to change your "..item.." By "..price.."$ ?","changePlatenumber",item)
			end
		end
		------
		if menu == MAIN_MENU_NAME then
			if item == 'VEHICLE FIX' then
				if checkMoney(price) then
				showSure("Do you want to buy "..item.." By "..price.."$ ?","buyVehicleFix",item,upid)
				end
			elseif item == 'VEHICLE COLOR' then
				if checkMoney(price) then
					showSure("Do you want to change color of your vehicle By "..price.."$ ?","buyVehicleColor",item,upid)
				end
			end
		end
	end
end

function setUpMenu(MENU,main,back)
	createMenu(MENU,not main,back)
	if  ___MENUS[MENU] then
		for k,v in ipairs( ___MENUS[MENU] ) do
			local name,price,func = v[1],v[2],v[3]
			if MENU == "VEHICLE UPGRADES" and price == false then
				if tostring(name) then
					if isUpgradeAvailabe(name) then
						addItem(name,price,main,func)
					end
				end
			else
				addItem(name,price,main,func)
			end
		end
	end
end

function isUpgradeAvailabe(daname)
		av = false
		if type(daname) == "string" then
			if daname == 'Paintjob' then
				return CheckPaintjobs()
			else
				local upgrades = getVehicleCompatibleUpgrades ( PLAYER_VEHICLE )
				if upgrades then
					if #upgrades ~= 0 then
						for upgradeKey, upgradeValue in ipairs ( upgrades ) do
							if upgradeValue then
								if tonumber(upgradeValue) then
									local slotname = getVehicleUpgradeSlotName ( tonumber(upgradeValue) )
									if slotname then
										if string.lower(slotname) == string.lower(daname) then
											av = true
										end
									end
								end
							end
						end
					end
					
				end
			end
			upgrades = nil
		end
		return av
end

function getAvaiableUpgrade(name)
	if name then
		local t = {}
		local upgrades = getVehicleCompatibleUpgrades ( PLAYER_VEHICLE )
		for upgradeKey, upgradeValue in ipairs ( upgrades ) do
			local slotname = getVehicleUpgradeSlotName ( tonumber(upgradeValue) )
			if slotname then
				if string.lower(slotname) == string.lower(name) then
					table.insert(t,upgradeValue)
				end
			end
		end
		return t
	end
end

function isUpgrade(what)
	if what then
		local id = getUpgradeID(what)
		if id then
			return true
		else
			return false
		end
	end
end

function getUpgradeName(id)
	name = false
	for k,v in ipairs ( VehicleUpgrades ) do
		local i,n,p = v.itemid,v.name,v.price
		if i and n then
			if tonumber(i) == tonumber(id) then
				name = n
				price = p
			end
		end
	end
	return name,price,id
end

function getUpgradeID(name)
	id = false
	if name then
		for k,v in ipairs ( VehicleUpgrades ) do
			local i,n,p = v.itemid,v.name,v.price
			if i and n then
				if string.lower(n) == string.lower(name) then
					id = i
				end
			end
		end
	end
	return id
end
function CheckPaintjobs()
	d = false
	if PLAYER_VEHICLE then
		local jobcar = createVehicle(getElementModel(PLAYER_VEHICLE),0,0,0)
		local job =  getVehiclePaintjob(PLAYER_VEHICLE)
			for k=0,2 do
				local  add = setVehiclePaintjob(jobcar,k)
				if add == true then
					d = true
				end
			end
		destroyElement(jobcar)
	end
	return d
end

function exampleUpgrade(id)
	if id then
		if id > 3 then
			addVehicleUpgrade(PLAYER_VEHICLE,tonumber(id))
			if tonumber(id) >= 1008 and tonumber(id) <= 1010 then
				setPedControlState(localPlayer,"fire", false )
				setPedControlState(localPlayer,"fire", true )
				setPedControlState(localPlayer,"fire",true)
			end
		else
			setVehiclePaintjob(PLAYER_VEHICLE,tonumber(id))
		end
	end
end

function LoadPaintjobs()
	if PLAYER_VEHICLE then
		addItem("Paintjob 1",2000,false,false,0)
		addItem("Paintjob 2",2000,false,false,1)
		addItem("Paintjob 3",2000,false,false,2)
		addItem("Default Paintjob",0,false,false,3)
	end
end

function LoadUpgrade(name)
	if PLAYER_VEHICLE and name then
		local available = getAvaiableUpgrade(name)
		if available and type(available) == "table" then
			if #available > 0 then
				for k,v in ipairs ( available ) do
					local upName,price = getUpgradeName(v)
					addItem(upName,tonumber(price),false,false,v)
				end
			else
				addItem("None",0,false,false)
			end
		end
	end
end

function removeUpgradeFromSaved(id)
	if id and PLAYER_VEHICLE_UPGRADES then
		local firstslot = getVehicleUpgradeSlotName(id)
		for k,v in ipairs ( PLAYER_VEHICLE_UPGRADES ) do
			if id == v then
				table.remove(PLAYER_VEHICLE_UPGRADES,k)
			end
		end
	end
end

function restoreUpgrades()
	if PLAYER_VEHICLE_UPGRADES and PLAYER_VEHICLE then 
		for k,v in ipairs ( getVehicleUpgrades(PLAYER_VEHICLE) ) do
			removeVehicleUpgrade(PLAYER_VEHICLE,v)
		end
		for k,v in ipairs ( PLAYER_VEHICLE_UPGRADES ) do
			addVehicleUpgrade(PLAYER_VEHICLE,v)
		end
		setVehiclePaintjob(PLAYER_VEHICLE,PLAYER_VEHICLE_PJ)
	end
end

function doesUpgradeExist(id)
	ex = false
	if not PLAYER_VEHICLE_UPGRADES then saveUpgrades() end
	for k,v in ipairs ( PLAYER_VEHICLE_UPGRADES  ) do
		if v == id then ex = true end
	end
	return ex
end

function saveUpgrades()
	PLAYER_VEHICLE_UPGRADES = nil
	PLAYER_VEHICLE_PJ = nil
	if PLAYER_VEHICLE then
		PLAYER_VEHICLE_UPGRADES = getVehicleUpgrades(PLAYER_VEHICLE)
		PLAYER_VEHICLE_PJ = getVehiclePaintjob(PLAYER_VEHICLE)
	end
end