concommand.Add("flathud_shadow", function(ply, cmd, args)
    if not ply:IsValid() or ply ~= LocalPlayer() then return end
    if #args == 0 or (args[1] ~= "false" and args[1] ~= "true") then 
        MsgC(Color(255,125,125),"[Incredible SBOX] ", color_white, "Utilisation de la commande : ", Color(211,211,211), "flathud_shadow true", color_white, " OU ", Color(211,211,211), "false\n")
        return
    end

    FlatUI.HUDShadows = tobool(args[1])
    MsgC(Color(255,125,125),"[Incredible SBOX] ", color_white, "Les ombres de texte ont bien étés "..(tobool(args[1]) and "activées" or "désactivées").." !\n")
end)