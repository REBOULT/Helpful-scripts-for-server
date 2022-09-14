--[[--------------------------------------------------
                Flat HUD - by JAWS™
--------------------------------------------------]]--

if FlatUI.DownloadContent and FlatUI.DlContentByWorkshop then
    resource.AddWorkshop("1949567526")
elseif FlatUI.DownloadContent then
    resource.AddSingleFile("materials/flat_hud/health.png")
    resource.AddSingleFile("materials/flat_hud/armor.png")
    resource.AddSingleFile("materials/flat_hud/euro.png")
    resource.AddSingleFile("materials/flat_hud/ammo.png")
    resource.AddSingleFile("resource/fonts/bebas_neue.otf")
end