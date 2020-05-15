-- Quit Game On Death by stacky

callbacks.Register( "FireGameEvent", function(event)
    if event:GetName() ~= "player_death" then return end
    if client.GetPlayerIndexByUserID( event:GetInt( 'userid' ) ) ~= client.GetLocalPlayerIndex() then return end
    debug.debug()
end )
client.AllowListener( "player_death" )