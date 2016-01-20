function createBlips ( )
	triggerClientEvent ( source, "GTIblips_BurgerBlips", source )
	triggerClientEvent ( source, "GTIblips_RepairBlips", source )
	triggerClientEvent ( source, "GTIblips_StoreBlips", source )
	triggerClientEvent ( source, "GTIblips_AmmuBlips", source )
	triggerClientEvent ( source, "GTIblips_ATMBlips", source )
end
addEventHandler ("onPlayerLogin", root, createBlips )
