----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>

function getItems ( )
    medkits = exports.GTImedKits:getPlayerMedKits ( client )
    coke = exports.GTIdrugsv2:getPlayerDrugAmount ( client, "Cocaine" )
	iron = exports.GTImining:getPlayerIron ( client )
	hemp = exports.GTIfarmer:getPlayerHemp ( client )
    triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
end
addEvent ("GTIcraftingSystem.getItems", true )
addEventHandler ("GTIcraftingSystem.getItems", root, getItems )

addEvent ("GTICraftSystem_CraftItems", true )
addEventHandler ("GTICraftSystem_CraftItems", root,
	function ( sort, amount, hempAmount, ironAmount )
		if ( sort == "medickit" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			if ( exports.GTIfarmer:getPlayerHemp ( client ) <= hempAmount -1 ) then return exports.GTIhud:dm("You don't have enough Hemp to craft this!", client, 255, 0, 0) end
			exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
			exports.GTIfarmer:setPlayerHemp ( client, exports.GTIfarmer:getPlayerHemp ( client ) - hempAmount )
			exports.GTImedKits:setPlayerMedKits ( client, exports.GTImedKits:getPlayerMedKits ( client ) + amount )
			exports.GTIhud:dm("Craft System: You made "..amount.." medic-kits", client, 0, 255, 255 )
		elseif ( sort == "parachute" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			local wep = getPedWeapon ( client, 11 )
			if wep == 46 then return exports.GTIhud:dm("You already have a Parachute, you can only have 1 at a time!", client, 255, 0, 0) end
			if ( exports.GTIfarmer:getPlayerHemp ( client ) <= 25 -1 ) then return exports.GTIhud:dm("You don't have enough Hemp to craft this!", client, 255, 0, 0) end
			exports.GTIfarmer:setPlayerHemp ( client, exports.GTIfarmer:getPlayerHemp ( client ) - 25 )
			exports.GTIhud:dm("Craft System: You made a Parachute", client, 0, 255, 255 )
			giveWeapon ( client, 46 )
		elseif ( sort == "knife" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			local wep = getPedWeapon ( client, 1 )
			if wep == 4 then return exports.GTIhud:dm("You already have a Knife, you can only have 1 at a time!", client, 255, 0, 0) end
			if ( exports.GTImining:getPlayerIron ( client ) <= 300 - 1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - 300 )
			exports.GTIhud:dm("Craft System: You made a Knife", client, 0, 255, 255 )
			giveWeapon ( client, 4 )
		elseif ( sort == "golf" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			local wep = getPedWeapon ( client, 1 )
			if wep == 2 then return exports.GTIhud:dm("You already have a Golf Club, you can only have 1 at a time!", client, 255, 0, 0) end
			if ( exports.GTImining:getPlayerIron ( client ) <= 100 - 1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - 100 )
			exports.GTIhud:dm("Craft System: You made a Golf Club", client, 0, 255, 255 )
			giveWeapon ( client, 2 )
		elseif ( sort == "shovel" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			local wep = getPedWeapon ( client, 1 )
			if wep == 6 then return exports.GTIhud:dm("You already have a Shovel, you can only have 1 at a time!", client, 255, 0, 0) end
			if ( exports.GTImining:getPlayerIron ( client ) <= 150 - 1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - 150 )
			exports.GTIhud:dm("Craft System: You made a Shovel", client, 0, 255, 255 )
			giveWeapon ( client, 6 )
		elseif ( sort == "katana" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			local wep = getPedWeapon ( client, 1 )
			if wep == 8 then return exports.GTIhud:dm("You already have a Katana, you can only have 1 at a time!", client, 255, 0, 0) end
			if ( exports.GTImining:getPlayerIron ( client ) <= 500 - 1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - 500 )
			exports.GTIhud:dm("Craft System: You made a Katana", client, 0, 255, 255 )
			giveWeapon ( client, 8 )
		elseif ( sort == "pistol" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 2 )
			local cur_ammo = getPedTotalAmmo( client, 2 )
			if not wep == 22 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 22 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Pistol ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "silenced" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 2 )
			local cur_ammo = getPedTotalAmmo( client, 2 )
			if not wep == 23 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 23 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Silenced 9MM ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "eagle" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 2 )
			local cur_ammo = getPedTotalAmmo( client, 2 )
			if not wep == 24 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 24 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Desert Eagle ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "shotgun" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 3 )
			local cur_ammo = getPedTotalAmmo( client, 3 )
			if not wep == 25 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 25 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Shotgun ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "sawnoff" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 3 )
			local cur_ammo = getPedTotalAmmo( client, 3 )
			if not wep == 26 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 26 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Sawn Off ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "spaz" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 3 )
			local cur_ammo = getPedTotalAmmo( client, 3 )
			if not wep == 27 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 27 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Spaz 12 ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "uzi" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 4 )
			local cur_ammo = getPedTotalAmmo( client, 4 )
			if not wep == 28 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 28 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Uzi ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "mp" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 4 )
			local cur_ammo = getPedTotalAmmo( client, 4 )
			if not wep == 29 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 29 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." MP5 ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "tec" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 4 )
			local cur_ammo = getPedTotalAmmo( client, 4 )
			if not wep == 32 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 32 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." TEC 9 ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "ak" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 5 )
			local cur_ammo = getPedTotalAmmo( client, 5 )
			if not wep == 30 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 30 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." AK-47 ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "m" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 5 )
			local cur_ammo = getPedTotalAmmo( client, 5 )
			if not wep == 31 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 31 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." M4 ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "rifle" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 6 )
			local cur_ammo = getPedTotalAmmo( client, 6 )
			if not wep == 33 or cur_ammo == 0 then return exports.GTIhud:dm("You don't have this weapon in your inventory! Switch weapon at the ammunation", client, 255, 0, 0) end
			if wep == 33 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Rifle ammo", client, 0, 255, 255 )
			end
		elseif ( sort == "sniper" ) then
			triggerClientEvent ( client, "GTIcraftingSystem.getPlayerItems", resourceRoot, medkits, coke, iron, hemp )
			if ( exports.GTImining:getPlayerIron ( client ) <= ironAmount -1 ) then return exports.GTIhud:dm("You don't have enough Iron to craft this!", client, 255, 0, 0) end
			local wep = getPedWeapon ( client, 6 )
			local cur_ammo = getPedTotalAmmo( client, 6 )
			if wep == 34 or cur_ammo == 0 then
				local max_ammo = exports.GTIweapons:getWeaponMaxAmmo(client, wep)
				if ( cur_ammo + amount > max_ammo ) then amount = max_ammo - cur_ammo end
				exports.GTImining:setPlayerIron ( client, exports.GTImining:getPlayerIron ( client ) - ironAmount )
				giveWeapon ( client, wep, amount, false )
				exports.GTIhud:dm("Craft System: You made "..amount.." Sniper ammo", client, 0, 255, 255 )
			end
	end
end
)		