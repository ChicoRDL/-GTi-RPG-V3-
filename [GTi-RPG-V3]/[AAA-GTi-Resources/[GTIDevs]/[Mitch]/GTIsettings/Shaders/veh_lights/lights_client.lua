local lights = {
	"High Quality",
	"Blue Doom",
	"Blue Estrellas",
	"Blue Flecha",
	"Blue Neon HQ",
	"Blue Oblique",
	"Blue X",
	"Colored",
	"Green FFS",
	"Green Mustang",
	"Green Onda",
	"Green Paradise",
	"Grey Audi I",
	"MEME Derp HQ",
	"MEME Me Gusta HQ",
	"MEME Troll HQ",
	"Orange Cupido",
	"Orange Led",
	"Orange Lines",
	"Pink Dots",
	"Purple I",
	"Purple II",
	"Red Alfa Romeo",
	"Red Alien",
	"Red Angry Mouth",
	"Red Angry Shape",
	"Red Audi I",
	"Red Audi II",
	"Red Audi III",
	"Red BMW I",
	"Red BMW II",
	"Red BMW M5",
	"Red Canibus",
	"Red Chevrolet Malibu",
	"Red Citroen Survolt",
	"Red Cupido",
	"Red Curve",
	"Red Curves HQ",
	"Red Dino",
	"Red Double Oval",
	"Red Double Ring",
	"Red Double Ring Led",
	"Red Double Rounded Restangles HQ",
	"Red Double Stripes",
	"Red Fast Line",
	"Red FFS",
	"Red Infiniti Electric",
	"Red KIA",
	"Red Lamborghini",
	"Red Lexus",
	"Red Lines",
	"Red Metropolis",
	"Red Mustang",
	"Red Passat",
	"Red Peugeot",
	"Red Rhombus",
	"Red Ring",
	"Red Sexy",
	"Red Slanted Stripes",
	"Red Spray",
	"Red Subaru",
	"Red The N",
	"Red The X",
	"Red The Y",
	"Red Triangles",
	"Red Triple Stripes",
	"Red Volkswagen",
	"Violet Lilac",
	"White Slanted Stripes",
	"White Snake",
	"Default"
}
local shaders = {}

local currentLight = "high quality"
local drawLights = true

addEventHandler("onClientResourceStart",resourceRoot,
	function ()
		local setting = exports.GTIsettings:getSetting("vehicle_light")
		if setting == "No" then return end
		if setting == "Yes" then
			currentLight = getCookieOption("lights") or "high quality"
			setElementData(localPlayer,"vehiclelight",currentLight,true)
			if getCookieOption("draw") ~= "false" then
				for i,vehicle in ipairs (getElementsByType("vehicle")) do
					loadVehicleLights(vehicle)
				end
			end
		end
	end
)

addEventHandler("onClientElementStreamIn",root,
	function ()
		if getElementType(source) == "vehicle" then
			loadVehicleLights(source)
		end
	end
)

addEventHandler("onClientVehicleEnter",root,
	function ()
		loadVehicleLights(source)
	end
)		

function loadVehicleLights (vehicle)
	local setting = exports.GTIsettings:getSetting("vehicle_light")
	if setting == "No" then return end
	if setting == "Yes" then
		local controller = getVehicleController(vehicle)
		if not controller then return end
		local image = getElementData(controller,"vehiclelight")
		if not image then return end
		if not shaders[image] then
			local texture = dxCreateTexture("images/"..image..".jpg","dxt3")
			local shader = dxCreateShader("lights.fx")
			dxSetShaderValue(shader,"gTexture",texture)
			shaders[image] = shader
		end
		engineApplyShaderToWorldTexture(shaders[image],"vehiclelights128",vehicle)
		engineApplyShaderToWorldTexture(shaders[image],"vehiclelightson128",vehicle)
	end-- needs messing with alpha
end

addEvent("onClientSettingChange", true)
addEventHandler("onClientSettingChange", localPlayer,
	function (vehicle)
		local setting = exports.GTIsettings:getSetting("vehicle_light")
		if setting == "Yes" then return end
		if setting == "No" then
			local controller = getVehicleController(vehicle)
			if not controller then return end
			local image = getElementData(controller,"vehiclelight")
			if not image then return end
			engineRemoveShaderFromWorldTexture(shaders[image],"vehiclelights128",vehicle)
			engineRemoveShaderFromWorldTexture(shaders[image],"vehiclelightson128",vehicle)
		end
	end
)
