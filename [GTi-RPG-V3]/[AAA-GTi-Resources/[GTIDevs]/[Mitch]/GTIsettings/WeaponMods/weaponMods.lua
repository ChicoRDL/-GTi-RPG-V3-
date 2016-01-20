local weapons = {
	{fileName="ak47", model=355},
	{fileName="colt", model=346},
	{fileName="m4", model=356},
	{fileName="magnum", model=348},
	{fileName="mp5", model=353},
	{fileName="shotgun", model=349},
	{fileName="sniper", model=358},
	{fileName="uzi", model=352},
	{fileName="spaz", model=351},
	{fileName="off", model=350},
	{fileName="tec9", model=372},
	{fileName="rifle", model=357},
	{fileName="rpg", model=359},
}

addEvent ("GTISettings_setWeaponMods", true )
addEventHandler ("GTISettings_setWeaponMods", root,
	function ( )
		local setting = exports.GTIsettings:getSetting("gunmods")
		if setting == "Yes" then
			for index, weapon in pairs( weapons ) do
				tex = engineLoadTXD ( "models/"..weapon.fileName.. ".txd", weapon.model )
				engineImportTXD ( tex, weapon.model )
				mod = engineLoadDFF ( "models/"..weapon.fileName.. ".dff", weapon.model )
				engineReplaceModel ( mod, weapon.model )
			end
		elseif setting == "No" then
			engineRestoreModel ( 355 )
			engineRestoreModel ( 356 )
			engineRestoreModel ( 353 )
			engineRestoreModel ( 358 )
			engineRestoreModel ( 352 )
			engineRestoreModel ( 351 )
			engineRestoreModel ( 349 )
			engineRestoreModel ( 348 )
			engineRestoreModel ( 346 )
			engineRestoreModel ( 350 )
			engineRestoreModel ( 372 )
		end
	end
)

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function ( )
		local setting = exports.GTIsettings:getSetting("gunmods")
		if setting == "Yes" then
			for index, weapon in pairs( weapons ) do
				tex = engineLoadTXD ( "models/"..weapon.fileName.. ".txd", weapon.model )
				engineImportTXD ( tex, weapon.model )
				mod = engineLoadDFF ( "models/"..weapon.fileName.. ".dff", weapon.model )
				engineReplaceModel ( mod, weapon.model )
			end
		elseif setting == "No" then
			engineRestoreModel ( 355 )
			engineRestoreModel ( 356 )
			engineRestoreModel ( 353 )
			engineRestoreModel ( 358 )
			engineRestoreModel ( 352 )
			engineRestoreModel ( 351 )
			engineRestoreModel ( 349 )
			engineRestoreModel ( 348 )
			engineRestoreModel ( 346 )
			engineRestoreModel ( 350 )
			engineRestoreModel ( 372 )
		end
	end
)