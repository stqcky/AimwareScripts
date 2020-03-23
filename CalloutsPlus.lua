-- Callouts Plus by stacky

local pEntities = {}
local WINDOW = gui.Window("calloutsplus", "Callouts Plus", 200, 200, 270, 200)
local GBOX = gui.Groupbox( WINDOW, "Callout", 10, 10, 250, 0 )
local PLAYERS = gui.Combobox( GBOX, "players", "Players", "" )
local CALLOUT = gui.Button( GBOX, "Callout", function() client.ChatTeamSay(pEntities[PLAYERS:GetValue() + 1]:GetName() .. " is at " .. pEntities[PLAYERS:GetValue() + 1]:GetPropString("m_szLastPlaceName")) end )

callbacks.Register( "Draw", function()
    WINDOW:SetActive(gui.Reference("Menu"):IsActive())
    names = {}
    pEntities = {}
    players = entities.FindByClass("CCSPlayer")
    for i = 1, #players do 
        if players[i]:IsAlive() and entities.GetLocalPlayer():GetTeamNumber() ~= players[i]:GetTeamNumber() then 
            table.insert(pEntities, players[i]) 
            table.insert(names, players[i]:GetName()) 
        end 
    end
    PLAYERS:SetOptions(unpack(names))
end )