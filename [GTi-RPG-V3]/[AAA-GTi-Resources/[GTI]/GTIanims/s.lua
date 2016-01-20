--<--------------------------------->--
-- Grand Theft International (GTI) ~
-- Author: NicKeLz ~
-- Resource: GTIanims/s.lua ~
-- Description: Ped Animation ~
-- Data: #Animations
--<--------------------------------->--
Timer = {}

local stopAnim = {}

addEvent("GTIanims.onSetAnim", true)
addEventHandler("GTIanims.onSetAnim", root, function ( state, group, anim )
    local jAnims = getElementData(client, "GTIanims.setAnim")
    if ( jAnims == true ) then return end
	if exports.GTIpoliceArrest:isPlayerInPoliceCustody(client, false, true, true, true, false) then
        return
    end
    if ( state == true and not isTimer(stopAnim[client])) then
        setPedAnimation ( client, group, anim, -1, true, false, false, true )
		stopAnim[client] = setTimer(print, 2500, 1)
    elseif ( state == false and not isTimer(stopAnim[client]) ) then
        setPedAnimation (client)
		stopAnim[client] = setTimer(print, 2500, 1)
    end
end
)


function setAnimCmd (p,group,anim)
    local jAnims = getElementData(p, "GTIanims.setAnim")
    if ( jAnims == true ) then return end
-->>
if exports.GTIpoliceArrest:isPlayerInPoliceCustody(p, false, true, true, true, false) then
        return
    end
	if isPedInVehicle(p) then return end
-->>
	if ( not isTimer(stopAnim[p]) ) then
		setPedAnimation ( p, group, anim, -1, true, false, false, true)
		stopAnim[p] = setTimer(print, 2500, 1)
	end
end


function boundAnimations (cmd)
    if ( cmd == "kiss" ) then
        setAnimCmd(source, "BD_FIRE", "Grlfrd_Kiss_03")
        
    elseif ( cmd == "plantbomb" ) then
        setAnimCmd(source, "BOMBER", "BOM_Plant")
    
    elseif ( cmd == "crckdeth" ) then
        setAnimCmd(source, "CRACK", "crckdeth2")
    
    elseif ( cmd == "dance1" ) then
        setAnimCmd(source, "DANCING", "bd_clap")
    
    elseif ( cmd == "dance2" ) then
        setAnimCmd(source, "DANCING", "dance_loop")
    
    elseif ( cmd == "dance3" ) then
        setAnimCmd(source, "DANCING", "DAN_Down_A")
    
    elseif ( cmd == "dance4" ) then
        setAnimCmd(source, "DANCING", "DAN_Left_A")
    
    elseif ( cmd == "dance5" ) then
        setAnimCmd(source, "DANCING", "DAN_Loop_A")
    
    elseif ( cmd == "dance6" ) then
        setAnimCmd(source, "DANCING", "DAN_Right_A")
    
    elseif ( cmd == "dance7" ) then
        setAnimCmd(source, "DANCING", "DAN_Up_A")
    
    elseif ( cmd == "dance8" ) then
        setAnimCmd(source, "DANCING", "dnce_M_a")
    
    elseif ( cmd == "dance9" ) then
        setAnimCmd(source, "DANCING", "dnce_M_b")
    
    elseif ( cmd == "dance10" ) then
        setAnimCmd(source, "DANCING", "dnce_M_c")
    
    elseif ( cmd == "dance11" ) then
        setAnimCmd(source, "DANCING", "dnce_M_d")
    
    elseif ( cmd == "drugdealer1" ) then
        setAnimCmd(source, "DEALER", "DEALER_IDLE")
    
    elseif ( cmd == "drugdealer2" ) then
        setAnimCmd(source, "DEALER", "DEALER_IDLE_01")
    
    elseif ( cmd == "tired" ) then
        setAnimCmd(source, "FAT", "IDLE_tired")
    
    elseif ( cmd == "facepalm" ) then
        setAnimCmd(source, "MISC", "plyr_shkhead")
    
    elseif ( cmd == "wave" ) then
        setAnimCmd(source, "ON_LOOKERS", "wave_loop")
    
    elseif ( cmd == "taichi" ) then
        setAnimCmd(source, "PARK", "Tai_Chi_Loop")
    
    elseif ( cmd == "piss" ) then
        setAnimCmd(source, "PAULNMAC", "Piss_loop")
    
    elseif ( cmd == "wank" ) then
        setAnimCmd(source, "PAULNMAC", "wank_loop")
    
    elseif ( cmd == "cower" ) then
        setAnimCmd(source, "ped", "cower")
    
    elseif ( cmd == "pointgun" ) then
        setAnimCmd(source, "ped", "gang_gunstand")
    
    elseif ( cmd == "sit" ) then
        setAnimCmd(source, "ped", "SEAT_idle")
    
    elseif ( cmd == "smoke" ) then
        setAnimCmd(source, "SMOKING", "M_smklean_loop")
    
    elseif ( cmd == "injured" ) then
        setAnimCmd(source, "SWEET", "Sweet_injuredloop")
		
    elseif ( cmd == "rap3" ) then
        setAnimCmd(source, "RAPPING", "RAP_C_Loop")

		elseif ( cmd == "rap2" ) then
        setAnimCmd(source, "RAPPING", "RAP_B_Loop")		

    elseif ( cmd == "rap1" ) then
        setAnimCmd(source, "RAPPING", "RAP_A_Loop") 		
	end
end
addEventHandler("onPlayerCommand", root, boundAnimations)

function setJobAnimation (ped, block, anim, time, loop, update, inter, freeze)
        if ( ped and block ) then
			if ( anim == "phone_out" or anim == "phone_in" ) and ( getElementData(ped, "GTIanims.setAnim") == false ) then
				setPedAnimation(ped, block, anim, time, loop, update, inter, freeze)
			return end --GTIDroid bug fix 
			if isTimer(Timer[ped]) then killTimer(Timer[ped]) end
            setElementData(ped, "GTIanims.setAnim", true)
            setPedAnimation(ped, block, anim, time, loop, update, inter, freeze)
			if not (loop or freeze) and not ( anim == "crry_prtial" ) then
				Timer[ped] = setTimer(function(ped)
				if not isElement(ped) then return end
				setElementData(ped, "GTIanims.setAnim", false)
				end,time,1,ped)
			elseif loop or freeze or ( anim == "crry_prtial" ) then
				Timer[ped] = setTimer(function(ped)
				if not isElement(ped) then return end
				setElementData(ped, "GTIanims.setAnim", false)
				end,120000,1,ped) --as we dont know the time then...2mins
			end
            -- outputDebugString("Data set")

    else
		if isTimer(Timer[ped]) then killTimer(Timer[ped]) end
        setPedAnimation(ped, false)
        setElementData(ped, "GTIanims.setAnim", false)
        -- outputDebugString("Data removed")
        end
    end