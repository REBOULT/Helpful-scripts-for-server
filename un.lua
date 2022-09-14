if ( SERVER ) then
util.AddNetworkString("gmansightings_drawdoor")
if !navmesh.IsLoaded then PrintMessage(HUD_PRINTTALK,"G-man Sightings: Map has no Navigation Mesh! Find a Navigation Mesh on the Workshop for this map or generate one using nav_generate") return end

function timer_StartRandom(name,min,max,func)

    timer.Create(name,math.random(min,max),1,function()
      timer_StartRandom(name,min,max,func)
      func()
    end)
  
  end
  

function WatchPlayer()

    local players = player.GetAll()

    local ply = players[math.random(#players)]

    local navareas = navmesh.Find( ply:GetPos(), 20000, 100, 1000 )
    local area = navareas[math.random(#navareas)]
    local point = area:GetRandomPoint()

local gman = ents.Create("npc_sightgman")
gman:SetPos(point)
local ang = (ply:GetPos()-gman:GetPos()):Angle()
ang.p = 0
ang.r = 0
gman:SetAngles(ang)
gman:Spawn()


end


hook.Add("PlayerInitialSpawn","gmansighting_greet",function(ply)
    if math.random(1,30) == 1 then
        local gman = ents.Create("npc_sightgman")
        gman:SetPos(ply:GetPos()+ply:GetForward()*300)
        local ang = (ply:GetPos()-gman:GetPos()):Angle()
        ang.p = 0
        ang.r = 0
        gman.IsSpawnGreeting = true
        gman:SetAngles(ang)
        gman:Spawn()
    end
end)

timer_StartRandom("gmansighting_rndshowup",60,600,function()
    WatchPlayer()
end)

elseif ( CLIENT ) then
    
    net.Receive("gmansightings_drawdoor",function()
        local gman = net.ReadEntity()
        if !IsValid(gman) then return end
        local index = gman:EntIndex()
        local json = net.ReadString()
        local data = util.JSONToTable(json)
        local pos = data.pos
        local ang = data.forward:Angle()--(pos-gman:GetPos()):Angle()
        pos = pos + ang:Forward()*-50
        local clipang = (gman:GetPos()-pos):Angle()
        local norm = clipang:Forward()
        local raise = 0
        ang.p = 0
        ang.r = 0
        sound.Play("doors/default_move.wav", pos, 60,100, 1)
        gman:SetRenderClipPlaneEnabled( true )
        gman:SetRenderClipPlane( norm, norm:Dot( pos ) )
        hook.Add("PostDrawOpaqueRenderables","gman_sighting_drawdoor"..index,function()
            if IsValid(gman) then
                if raise < 90 then 
                raise = raise + 0.5
                end
            else
                if raise > 0 then 
                    raise = raise - 0.5
                end
                if raise <= 0 then
                    hook.Remove("PostDrawOpaqueRenderables","gman_sighting_drawdoor"..index)
                    sound.Play("doors/default_stop.wav", pos, 60,100, 1)
                    return
                end
            end
            render.SetColorMaterial()
            render.DrawBox( pos, ang, Vector(-0.1,-20,0), Vector(0.1,20,raise), Color(0,0,0)  )

        end)

    end)


end