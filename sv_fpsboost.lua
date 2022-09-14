util.AddNetworkString( "OpenFpsMenu" )

hook.Add( "PlayerInitialSpawn", "OpenFpsMenuFunction", function ( ply )
     timer.Simple(2, function()
          net.Start( "OpenFpsMenu" ) 
          net.Send( ply )
     end)
end)




