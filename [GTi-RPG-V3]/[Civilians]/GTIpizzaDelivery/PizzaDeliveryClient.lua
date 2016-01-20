payammount = 0
Pizzas = 0
local PizzaslocLS = {
    {2017.884, -1703.210, 13.234},
    {2066.313, -1703.482, 13.148},
    {2435.226, -1289.308, 24.348},
    {2472.886, -1238.500, 31.569},
    {2229.693, -1241.135, 24.656},
    {2091.919, -1166.550, 25.586},
    {2022.906, -1120.776, 25.421},
    {1102.617, -1093.715, 27.469},
    {1051.067, -1058.106, 33.797},
    {760.052, -1507.672, 12.547},
    {692.937, -1602.388, 14.047},
    {653.538, -1714.064, 13.765},
    {768.630, -1745.792, 12.077},
    {986.286, -1704.217, 13.930},
    {1913.478, -1912.729, 14.257},
    {1873.601, -2070.053, 14.497},
    {1894.248, -2133.565, 14.466},
    {280.855, -1767.981, 3.535},
    {228.356, -1404.611, 50.609},
    {298.170, -1337.451, 52.442},
}
local PizzaslocSF = {
{-2563.3, 1148.7, 54.7},
{-2506.3999, 1141.7, 54.7},
{-2396.7, 1132.6, 54.7},
{-2451.3, 1141.5, 54.7},
{-2351.8999, 1318, 15.1},
{-2477.2, 1281.5, 22.7},
{-2433.6001, 1338.2, 7.5},
{-2789.2, -181.10001, 8.9},
{-2791.8, -134.3, 9},
{-2791.8, -24.4, 9},
{-2791.2, 126.9, 6.1},
{-2791.8, 218.60001, 6.8},
{-2883.8999, 743.5, 28.1},
{-2864.6001, 681.59998, 22.2},
{-2880.8999, 790.20001, 34.1},
{-2845.1001, 928.40002, 42.9},
{-2900.3999, 1081, 31.1},
{-2285, 849.59998, 64.1},
{-2174.3, 903.70001, 79},
{-2223.8, 744, 48.4},
{-2686.8999, -187.89999, 6.2},
{-2689.3999, -141.10001, 6.2},
{-2688.8, -89.4, 3.2},
{-2662.1001, 877, 78.7},
{-2721.8, 923.90002, 66.6},
{-2710.7, 968.09998, 53.4},
{-2641.1001, 935.70001, 70.9},
{-2321.7, 797.09998, 44.1},
{-2280.8999, 1023, 82.8},
{-2168.3, 1107.5, 79},
{-2112.5, 796.70001, 68.6},
{-2058.8999, 890.79999, 60.8},
{-2621.8999, 782.59998, 43.9},
{-2686.2, 722.79999, 31.1},
{-2687.7, 803.70001, 48.9},
}
local PizzasMarkersLS = {
{2126.151, -1806.752, 12.554},
{2126.241, -1812.731, 12.554},
{2126.352, -1808.232, 12.554},
}
local PizzasMarkersSF = {
{374.174, -114.018, 1000.492},
{376.185, -114.142, 1000.492},
{378.079, -114.234, 1000.492},
}
local ctrls ={
"sprint",
"jump",
"enter_exit",
"enter_passenger",
"fire", 
"crouch", 
"aim_weapon",
"next_weapon",
"previous_weapon",
}
local pizzas = {}
function randomh()
	if exports.GTIchat:getPlayerCity(localPlayer) == "LS" then
		return unpack( PizzaslocLS [math.random (#PizzaslocLS)] )
	elseif exports.GTIchat:getPlayerCity(localPlayer) == "SF" then
		return unpack( PizzaslocSF [math.random (#PizzaslocSF)] )
	end
end

function randomMarkers()
	if exports.GTIchat:getPlayerCity(localPlayer) == "LS" then
		return unpack( PizzasMarkersLS [math.random (#PizzasMarkersLS)] )
	elseif exports.GTIchat:getPlayerCity(localPlayer) == "SF" then
		return unpack( PizzasMarkersSF [math.random (#PizzasMarkersSF)] )
	end
end

function onIntchange()
	if (exports.GTIemployment:getPlayerJob(true) == "Pizza Delivery") then
		local new = getElementInterior(localPlayer)
		if isElement(Pizzabox) then setElementInterior(Pizzabox,new) end
		local newD = getElementDimension(localPlayer)
		if isElement(Pizzabox) then setElementDimension(Pizzabox,newD) end
		for i,v in pairs(pizzas) do
			if isElement(v) then
				setElementInterior(v,new)
				setElementDimension(v,newD) 
			end
		end
	end
end
addEvent("onClientPlayerChangeInterior",true)
addEventHandler("onClientPlayerChangeInterior", root, onIntchange)

addEvent("GTIPizzaDelivery.onPizzaBoyEnter", true)
addEventHandler("GTIPizzaDelivery.onPizzaBoyEnter", root, function()
    if (exports.GTIemployment:getPlayerJob(true) == "Pizza Delivery") then 
    exports.GTIhud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
        if not isElement(Pizzabox) and not isElement(blip) and not isElement(refblip) then
            if ( Pizzas == 0 ) then
				if ( exports.GTIchat:getPlayerCity(localPlayer) == "SF" ) then 
					local rdmX,rdmY,rdmZ = randomMarkers()
					refmarker = createMarker(rdmX, rdmY, rdmZ, "cylinder", 0.8, 255, 25, 0, 170 )
					refblip = createBlip(-1721.899, 1354.198, 6.179,41)
					setElementInterior(refmarker,5)
					setElementDimension(refmarker,134)
				else 
					local rdmX,rdmY,rdmZ = randomMarkers()
					refmarker = createMarker (rdmX, rdmY, rdmZ, "cylinder", 0.8, 255, 25, 0, 170 )
					refblip = createBlipAttachedTo(refmarker, 41)
                end
                exports.GTIhud:dm("You're out of Pizzas! Go bake new Pizzas to continue.", 255, 0, 0)
				reload = false
            else
                mission()
            end
        end
    end
end )
addEvent("GTIPizzaDelivery.marker", true)
addEventHandler("GTIPizzaDelivery.marker", root, function(theVeh)
    local mx,my,mz = getElementPosition(theVeh)
    refillmarker = createMarker(mx, my, mz, "cylinder", 0.8, 255, 25, 0, 170 )
    attachElements(refillmarker,theVeh,0,-1.3,-0.5,1,0,0)
end )

function findRotation(x1,y1,x2,y2)
    local X = math.abs( x2 - x1 )
    local Y = math.abs( y2 - y1 )
    Rotm = math.deg( math.atan2( Y , X ) )
    if ( x2 >= x1 ) and ( y2 > y1 ) then    -- north-east
        Rotm = 90 - Rotm
    elseif ( x2 <= x1 ) and ( y2 > y1 ) then    -- north-west
        Rotm = 270 + Rotm
    elseif ( x2 >= x1 ) and ( y2 <= y1 ) then   -- south-east
        Rotm = 90 + Rotm
    elseif ( x2 < x1 ) and ( y2 <= y1 ) then    -- south-west
        Rotm = 270 - Rotm
    end
    return (630-Rotm)
end

function mission()
    local x1, y1, z1 = randomh()
	if x1 == lastPosx and y1 == lastPosy then
		mission()
	return end
	lastPosx,lastPosy,lastPosz = x1,y1,z1
    marker = createMarker ( x1, y1, z1, "cylinder", 0.9, 255, 255, 50, 170 )
    blip = createBlipAttachedTo(marker, 41)
    loca = getZoneName(x1,y1,z1)
    local RPName = exports.GTIutil:getGenericName()
    exports.GTIhud:dm(RPName.." has ordered a Pizza in "..loca, 255, 255, 0)
    local d1x, d1y, d1z = getElementPosition ( marker )
    local d2x, d2y, d2z = getElementPosition ( localPlayer )
    local distance = getDistanceBetweenPoints3D(d1x,d1y,d1z,d2x,d2y,d2z)
	--Arrow = createObject(1318,d2x, d2y, d2z)
	--setElementCollisionsEnabled(Arrow,false)
	--attachElements ( Arrow, localPlayer )
	outputDebugString ("attached arrow")
	--addEventHandler("onClientPreRender", getRootElement(), ArrowRender)
    payammount = distance
end

function ArrowRender()
	if localPlayer then
		if not isElement(localPlayer) then cancelRender() return end
		lx,ly,lz = getElementPosition(localPlayer)
	end
	if getPedOccupiedVehicle(localPlayer) then
		tx,ty,tz = getElementPosition(getPedOccupiedVehicle(localPlayer))
		local roty,rotz = findRotation(tx,ty,tz,lx,ly,lz)
		setElementPosition(Arrow, tx, ty, tz+1.5)
		setElementRotation(Arrow, 0, roty, rotz)
	end
		--if getDistanceBetweenPoints3D(tx,ty,tz,lx,ly,lz) < 25 then 
		--cancelRender()
	--end
end

function cancelRender()
	removeEventHandler("onClientPreRender", getRootElement(), ArrowRender)
	if isElement(Arrow) then destroyElement(Arrow) end
	lx,ly,lz = nil
end

function Pizzaexit(thePlayer)
    if ( getElementModel ( source ) == 448 ) and ( thePlayer == localPlayer )and (exports.GTIemployment:getPlayerJob(true) == "Pizza Delivery") then
        if ( Pizzas > 0 ) then
			local p1x, p1y, p1z = getElementPosition ( marker )
			local p2x, p2y, p2z = getElementPosition ( localPlayer )
			local dist = getDistanceBetweenPoints3D(p1x,p1y,p1z,p2x,p2y,p2z)
			if ( dist < 40 ) then
				triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,true)
				setPedFrozen(localPlayer,true)
				toggleAllControls(false,true,false)
				setTimer( function()
					setPedFrozen(localPlayer,false)
					toggleAllControls(true)
					toggleControl("crouch", false)
					triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,1,2)
					pizza = true
					setPedWeaponSlot(localPlayer,0)
                end, 950, 1 )
        end
        end
end
end
addEventHandler ( "onClientVehicleExit", root, Pizzaexit )


function refill(theElement)
    if ( source == refillmarker ) and ( theElement == localPlayer) and reload then
		destroyElement(refillmarker)
		exports.GTIhud:drawProgressBar("PizzaPro", "Please Wait...", 255, 200, 0, 7500)
		toggleAllControls(false,true,false) 
		pTimer1 = setTimer(refillDone, 7500, 1)
		refTimer1 = setTimer(function()
			local i = table.maxn(pizzas)
			if isElement(pizzas[i]) then
				destroyElement(pizzas[i])
				table.remove(pizzas,i)
			end
		end,1450,5)
	end
end
addEventHandler ( "onClientMarkerHit", root, refill)
function refillDone()
    Pizzas = 5
    setPedAnimation(localPlayer, "VENDING", "VEND_Use", 7, true, false, false, false)
    toggleAllControls(true)
    exports.GTIhud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
    exports.GTIhud:dm("Your Pizzas has been unpacked in your Pizza Boy!", 255, 0, 0)
	for i,v in ipairs(ctrls) do
		toggleControl(v, true)
	end
    triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,false)
	reload = false
end
function getPizzas()
            triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,1)
            local x,y,z = getElementPosition(localPlayer)
			att = 0.39
			for i = 1,5 do 
				local Pizzaboxtemp = createObject(1582, x, y, z)
				setObjectScale(Pizzaboxtemp,0.75)
				local int = getElementInterior(localPlayer)
				local dim = getElementDimension(localPlayer)
				if dim == 134 then
					setElementInterior(Pizzaboxtemp,int)
					setElementDimension(Pizzaboxtemp,dim) 
				end
				attachElements(Pizzaboxtemp,localPlayer,0,0.45,att,1,0,0)
				att = att + 0.06
				setElementCollisionsEnabled(Pizzaboxtemp,false)
				table.insert(pizzas,Pizzaboxtemp)
			end
            exports.GTIhud:dm("Now that your Pizzas are baked, go put them in your Pizza Boy.", 255, 204, 0)
			reload = true
            stopSound(bakingsound)
            triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,true)
            triggerServerEvent("GTIPizzaDelivery.getTheVeh", resourceRoot)
end
function destroyPizzas()
	for i,v in pairs(pizzas) do
		if isElement(v) then destroyElement(v) end
		table.remove(pizzas,i)
	end
end
function startprogress(thePlayer)
    if ( source == refmarker ) and ( thePlayer == localPlayer) and not ( isPedInVehicle ( thePlayer ) ) then
		for i,v in ipairs(ctrls) do
			toggleControl(v, false)
		end
		triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,2)
		setPedWeaponSlot(localPlayer,0)
		destroyElement(refmarker)
		destroyElement(refblip)
		bakingsound = playSFX("genrl", 45, 0, true)
		exports.GTIhud:drawProgressBar("PizzaPro", "Please Wait...", 255, 200, 0, 10000)
		pTimer = setTimer(getPizzas, 9900, 1)
    end
end
addEventHandler("onClientMarkerHit",getRootElement(),startprogress)
function pay(thePlayer)
    if ( thePlayer == localPlayer ) and ( source == marker ) and not ( isPedInVehicle ( thePlayer ) ) then
        if (pizza == true) then
			toggleAllControls(false,true,false) 
			destroyElement(marker)
			destroyElement(blip)
			playSound("walking.mp3", false)
			setTimer(function()
				playSFX("spc_fa", 17, math.random(5,11), false)
				Pizzas = Pizzas - 1
				pizza = false
				exports.GTIhud:drawStat("PizzaID", "Pizzas", Pizzas.."/5", 255, 200, 0)
				toggleAllControls(true,true,false) 
                triggerServerEvent("GTIPizzaDelivery.freeze", resourceRoot,false)
                triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,3,0)
                triggerServerEvent("GTIPizzaDelivery.getpaid", resourceRoot, payammount)
            end, 7500,1 )
        end
    end 
end
addEventHandler ( "onClientMarkerHit", root, pay)

function delelem(thePlayer)
	if (exports.GTIemployment:getPlayerJob(true) == "Pizza Delivery") then
		payammount = 0
		Pizzas = 0
		pizza = false
		if isElement(marker) then destroyElement(marker) end
		if getPedAnimation(localPlayer) then triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,0,0) end
		destroyPizzas()
		if isElement(refmarker) then destroyElement(refmarker) end
		if isElement(refillmarker) then destroyElement(refillmarker) end
		if isElement(refblip) then destroyElement(refblip) end
		if isElement(Pizzabox) then destroyElement(Pizzabox) end
		if isElement(blip) then destroyElement(blip) end
		exports.GTIhud:drawStat("PizzaID", "", "", 255, 200, 0)
		if isTimer(pTimer1) then killTimer(pTimer1) end
		if isTimer(pTimer) then killTimer(pTimer) end
		if isTimer(refTimer1) then killTimer(refTimer1) end
		toggleAllControls(true)
	end
end
addEvent("onClientRentalVehicleHide", true)
addEventHandler ("onClientRentalVehicleHide", root, delelem)
addEventHandler ("onClientPlayerWasted", localPlayer, delelem)
function onJobQuit(job)
    if ( job == "Pizza Delivery" ) then 
		Pizzas = 0
		payammount = 0
		if isElement(marker) then destroyElement(marker) end
		if isElement(blip) then destroyElement(blip) end
		if isTimer(pTimer) then killTimer(pTimer) end
		destroyPizzas()
		toggleAllControls(true)
		if getPedAnimation(localPlayer) then triggerServerEvent("GTIPizzaDelivery.anim", resourceRoot,0,0) end
		if isTimer(pTimer1) then killTimer(pTimer1) end
		if isTimer(refTimer1) then killTimer(refTimer1) end
		if isElement(Pizzabox) then destroyElement(Pizzabox) end
		if isElement(refillmarker) then destroyElement(refillmarker) end
		if isElement(refmarker) then destroyElement(refmarker) end
		if isElement(refblip) then destroyElement(refblip) end
		exports.GTIhud:drawStat("PizzaID", "", "", 255, 200, 0)
	end
end
addEventHandler ("onClientPlayerQuitJob", root, onJobQuit)
addEventHandler ("onClientPlayerGetJob", root, onJobQuit)

addEventHandler("onClientPlayerQuit", localPlayer,
	function ()
		destroyPizzas()
	end
)