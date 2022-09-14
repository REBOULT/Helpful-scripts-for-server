-- made by darsu <3

local enabled = CreateConVar("altlook", 1, FCVAR_REPLICATED)
local limV = CreateConVar("altlook_limit_vertical", 65, FCVAR_REPLICATED)
local limH = CreateConVar("altlook_limit_horizontal", 140, FCVAR_REPLICATED)
local smooth = CreateConVar("altlook_smoothness_mult", 1, FCVAR_REPLICATED)
local blockads = CreateConVar("altlook_block_ads", 1, FCVAR_REPLICATED)
local blockshoot = CreateConVar("altlook_block_fire", 1, FCVAR_REPLICATED)

if SERVER then return end

local view = {}
local LookX, LookY = 0, 0
local InitialAng, CoolAng = Angle(), Angle()

local function isinsights(ply) -- arccw, arc9, tfa works
    local weapon = ply:GetActiveWeapon()

    return blockads:GetBool() and (ply:KeyDown(IN_ATTACK2) or (weapon.GetInSights and weapon:GetInSights()) or (weapon.ArcCW and weapon:GetState() == ArcCW.STATE_SIGHTS) or (weapon.GetIronSights and weapon:GetIronSights()))
end

hook.Add("CalcView", "AltlookView", function(ply, pos, ang, fov, znear, zfar)
    if !enabled:GetBool() then return end

    local smoothness = math.Clamp(smooth:GetFloat(), 0.1, 2)

    CoolAng = LerpAngle(0.15 * smoothness, CoolAng, Angle(LookY, -LookX, 0))

    if not ply:KeyDown(IN_WALK) and CoolAng.p < 0.05 or isinsights(ply) and CoolAng.p < 0.05 or not system.HasFocus() or ply:ShouldDrawLocalPlayer() then InitialAng, LookX, LookY = ang, 0, 0 CoolAng = Angle() return end

    view.origin = pos
    view.angles = ang + CoolAng
    view.fov = fov

    return view
end)

local VMCalcCalled

hook.Add("CalcViewModelView", "AltlookVM", function(wep, vm, oPos, oAng, pos, ang, ...)
    if !enabled:GetBool() then return end

	if VMCalcCalled then return end
	VMCalcCalled = true
	local tPos, tAng = hook.Run("CalcViewModelView", wep, vm, oPos, oAng, pos, ang, ...)
	VMCalcCalled = nil
	pos = tPos or pos
	ang = tAng+CoolAng/2.5 or ang

	return pos, ang
end)

hook.Add("InputMouseApply", "AltlookMouse", function(cmd, x, y, ang)
    if !enabled:GetBool() then return end

    local lp = LocalPlayer()
    if not lp:KeyDown(IN_WALK) or isinsights(lp) or lp:ShouldDrawLocalPlayer() then LookX, LookY = 0, 0 return end
    
    InitialAng.z = 0 -- roll fix
    cmd:SetViewAngles(InitialAng)

    LookX = math.Clamp(LookX + x * 0.02, -limH:GetInt(), limH:GetInt())
    LookY = math.Clamp(LookY + y * 0.02, -limV:GetInt(), limV:GetInt())
    
    return true
end)

hook.Add("StartCommand", "AltlookBlockShoot", function(ply, cmd)
    if !ply:IsPlayer() or !ply:Alive() then return end
    if !blockshoot:GetBool() then return end
    
    if not ply:KeyDown(IN_WALK) or isinsights(ply) or ply:ShouldDrawLocalPlayer() then return end
    cmd:RemoveKey(IN_ATTACK)
end)