----------------------------------------->>
-- Grand Theft International (GTI)
-- Author: Mitch
-- Version: 1.0
----------------------------------------->>
local huds = {
    "radar_airYard",
    "radar_ammugun",
    "radar_barbers",
    "radar_BIGSMOKE",
	"radar_boatyard",
    "radar_MADDOG",
    "radar_bulldozer",
    "radar_burgerShot",
    "radar_cash",
	"radar_spray",
   -- "radar_CATALINAPINK",
    "radar_centre",
    "radar_CESARVIAPANDO",
    "radar_chicken",
    "radar_CJ",
    "radar_CRASH1",
    "radar_dateDisco",
    "radar_dateDrink",
    "radar_dateFood",
    "radar_diner",
    "radar_emmetGun",
    --"radar_enemyAttack",
    "radar_fire",
    "radar_Flag",
    --"radar_gangB",
    "radar_gangG",
    "radar_gangN",
    --"radar_gangP",
    --"radar_gangY",
    "radar_girlfriend",
    "radar_gym",
    "radar_hostpital",
    "radar_impound",
    "radar_light",
    "radar_LocoSyndicate",
    "radar_mafiaCasino",
    "radar_MCSTRAP",
    "radar_modGarage",
    "radar_north",
    "radar_OGLOC",
    "radar_pizza",
    "radar_police",
    "radar_propertyG",
    "radar_propertyR",
    "radar_qmark",
    "radar_race",
    --"radar_runway",
    "radar_RYDER",
    "radar_saveGame",
    "radar_school",
    "radar_spray",
    --"radar_SWEET",
    "radar_tattoo",
    "radar_THETRUTH",
   -- "radar_TORENO",
    "radar_TorenoRanch",
    "radar_triads",
    --"radar_triadsCasino",
    "radar_truck",
    "radar_tshirt",
    "radar_waypoint",
    --"radar_WOOZIE",
   -- "radar_ZERO",
}

function replaceHuds()
	local setting = exports.GTIsettings:getSetting("blipmods")
	if setting == "No" then return end
	if setting == "Yes" then
		for key,hud in ipairs(huds) do
			texShader = dxCreateShader ( "shader.fx" )
			createdHud = dxCreateTexture("radar_blips/"..hud..".png")
			dxSetShaderValue(texShader,"gTexture",createdHud)
			engineApplyShaderToWorldTexture(texShader,tostring(hud))
		end
    end
end
addEventHandler("onClientResourceStart", resourceRoot, replaceHuds)

addEvent ("onClientSettingChange", true )
addEventHandler ("onClientSettingChange", root,
function()
	local setting = exports.GTIsettings:getSetting("blipmods")
	if setting == "Yes" then
		for key,hud in ipairs(huds) do
			texShader = dxCreateShader ( "shader.fx" )
			createdHud = dxCreateTexture("radar_blips/"..hud..".png")
			dxSetShaderValue(texShader,"gTexture",createdHud)
			engineApplyShaderToWorldTexture(texShader,tostring(hud))
	if setting == "No" then
		engineRemoveShaderFromWorldTexture (texShader, tostring(hud))
		end
		end
    end
end
)