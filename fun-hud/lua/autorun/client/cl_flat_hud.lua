print([[
	
╔════╗╔╗╔═╗─╔╦════╦══╦═╗─╔╦╗──╔╗
║╔╗╔╗╠╝║║║╚╗║║╔╗╔╗╠╣╠╣║╚╗║║╚╗╔╝║
╚╝║║╚╩╗║║╔╗╚╝╠╝║║╚╝║║║╔╗╚╝╠╗╚╝╔╝
──║║──║║║║╚╗║║─║║──║║║║╚╗║║╚╗╔╝
──║║─╔╝╚╣║─║║║─║║─╔╣╠╣║─║║║─║║
──╚╝─╚══╩╝─╚═╝─╚╝─╚══╩╝─╚═╝─╚╝
╔══╗╔═══╦═══╦═══╗
║╔╗║║╔═╗║╔═╗║╔══╝
║╚╝╚╣║─║║╚══╣╚══╗
║╔═╗║╚═╝╠══╗║╔══╝
║╚═╝║╔═╗║╚═╝║╚══╗
╚═══╩╝─╚╩═══╩═══╝

Incredible SandBox - Делаем игры лучше.
]])

local Lerp = Lerp
local surface = surface
local draw = draw
local hook = hook
local IsValid = IsValid
local math = math
local Color = Color
local timer = timer
local CurTime = CurTime

local scaleX = ScrW() / 1920
local scaleY = ScrH() / 1080

surface.CreateFont( "flathud_bebas_50",
{
	font = "Bebas Neue Regular",
	size = scaleY * 50,
	weight = 250,
	antialias = true,
	strikeout = true,
	additive = true,
})


local matHealth = FlatUI.Materials.Health or Material("flat_hud/health.png", "smooth")
local matArmor = FlatUI.Materials.Armor or Material("flat_hud/armor.png", "smooth")
local matAmmo = FlatUI.Materials.Ammo or Material("flat_hud/ammo.png", "smooth")
local matEuroSymbol = Material("flat_hud/euro.png", "smooth")


local currentHealth = 0
local currentArmor = 0




local baseElementPos = 20

local _FlatUI = FlatUI



hook.Add( "HUDPaint", "FlatHUD::Draw", function()
	

	if LocalPlayer():Health() ~= currentHealth then
		currentHealth = Lerp( 0.025, currentHealth, LocalPlayer():Health() )
	end
	if LocalPlayer():Armor() ~= currentArmor then
		currentArmor = Lerp( 0.025, currentArmor, LocalPlayer():Armor() )
	end


	surface.SetDrawColor(255,255,255)
	

	surface.SetMaterial(matHealth)
	surface.DrawTexturedRect(scaleX * baseElementPos, scaleY * 980, scaleX * 110, scaleY * 101)

	surface.SetMaterial(matArmor)
	surface.DrawTexturedRect(scaleX * (baseElementPos + 95), scaleY * 970, scaleX * 105, scaleY * 120)

	BSHADOWS.BeginShadow()

		draw.DrawText(math.Clamp(math.Round(currentHealth), 0, 100 ), "flathud_bebas_50", scaleX * (baseElementPos + 68), scaleY * 1032, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.DrawText(math.Round(currentArmor), "flathud_bebas_50", scaleX * (baseElementPos + 163), scaleY * 1032, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	BSHADOWS.EndShadow(4, 3, 2, 255, 0, 0, true)

	surface.SetMaterial(matEuroSymbol)

	BSHADOWS.BeginShadow()
	draw.DrawText(LocalPlayer():Name(), "flathud_bebas_50", scaleX * (baseElementPos + 260), scaleY * 1015, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	BSHADOWS.EndShadow(3, 3, 2, 255, 0, 0, true)

	draw.DrawText(math.Clamp(math.Round(currentHealth), 0, 100000 ), "flathud_bebas_50", scaleX * (baseElementPos + 68), scaleY * 1032, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.DrawText(math.Round(currentArmor), "flathud_bebas_50", scaleX * (baseElementPos + 163), scaleY * 1032, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	if IsValid( LocalPlayer():GetActiveWeapon() ) and !_FlatUI.WeaponBlackList[LocalPlayer():GetActiveWeapon():GetClass()] then 
		entWeapon = LocalPlayer():GetActiveWeapon()
		intTotalAmmo = LocalPlayer():GetAmmoCount( entWeapon:GetPrimaryAmmoType() ) or LocalPlayer():GetAmmoCount( entWeapon:GetSecondaryAmmoType() ) or LocalPlayer():GetAmmoCount( entWeapon:Ammo1() )
		intAmmoClip = entWeapon:Clip1()

		if intAmmoClip >= 0  then 
			surface.SetMaterial(matAmmo)
			surface.DrawTexturedRect(scaleX * 325, scaleY * 970, scaleX * 110, scaleY * 110)

			surface.SetFont("flathud_bebas_50")
			BSHADOWS.BeginShadow()
				draw.DrawText(intAmmoClip.. " / ".. intTotalAmmo, "flathud_bebas_50", scaleX * (baseElementPos + 260), scaleY * 1015, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			BSHADOWS.EndShadow(4, 3, 2, 255, 0, 0, true)
			draw.DrawText(intAmmoClip.. " / ".. intTotalAmmo, "flathud_bebas_50", scaleX * (baseElementPos + 260), scaleY * 1015, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			
		end
	end

	


local colorCorrection = {
    [ "$pp_colour_addr" ] = 0,
	[ "$pp_colour_addg" ] = 0,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 	1,
	[ "$pp_colour_mulr" ] = 0,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

hook.Add( "RenderScreenspaceEffects", "FlatHUD::RenderScreenspaceEffects", function()
    if !_FlatUI.HealthEffects then return end

	local intHp, intMaxHp = LocalPlayer():Health(), 100
	local intHpColorModify = math.Clamp( intHp /intMaxHp *2 - 1, 0, 1 )
	local intHpMotionBlur = math.Clamp( intHp /intMaxHp /1, .05, 1 )
	colorCorrection[ "$pp_colour_colour" ] = intHpColorModify

	DrawColorModify( colorCorrection )
	DrawMotionBlur( intHpMotionBlur, 1, 0.001 )
end)

local hideHUDElements = {
	["CHudSecondaryAmmo"] = true,
	["CHudAmmo"] = true,
	["CHudHealth"] = true,
	["CHudBattery"] = true,
}
hook.Add("HUDShouldDraw", "FlatHUD::HideDefaultDarkRPHud", function(name)
	if hideHUDElements[name] then
		return false
	end
end)
end)

