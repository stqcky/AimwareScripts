-- NameStealer Plus by stacky

local pNames = {}
local time = globals.CurTime()
local before = ""
local function silent2() if globals.CurTime() >= time + 0.1 then client.SetConVar("name", before) else silent2() end end

local WINDOW = gui.Window( "namestealerplus", "NameStealer Plus", 200, 200, 270, 465 )
WINDOW:SetOpenKey(45)

local NAMESTEALER_GBOX = gui.Groupbox( WINDOW, "Name Stealer", 10, 10, 250, 0 )
local NAMESTEALER_PLAYERS = gui.Combobox( NAMESTEALER_GBOX, "namestealer.players", "Players", "" )
local NAMESTEALER_STEAL = gui.Button( NAMESTEALER_GBOX, "Steal Name", function() client.SetConVar("name", pNames[NAMESTEALER_PLAYERS:GetValue() + 1] .. "­­") end )

local CUSTOMNAME_GBOX = gui.Groupbox( WINDOW, "Custom Name", 10, 170, 250, 0 )
local CUSTOMNAME_NAME = gui.Editbox( CUSTOMNAME_GBOX, "namestealer.name", "Name" )
local CUSTOMNAME_CHANGE = gui.Button( CUSTOMNAME_GBOX, "Change Name", function() client.SetConVar("name", CUSTOMNAME_NAME:GetValue() .. "­­") end )

local SILENT_GBOX = gui.Groupbox( WINDOW, "Silent", 10, 330, 250, 0 )
local SILENT_MAKESILENT = gui.Button( SILENT_GBOX, "Silent Change", function() 
    before = client.GetConVar("name")
    client.SetConVar("name", "\n\xAD\xAD\xAD\xAD") 
    time = globals.CurTime()
    silent2()
end )

callbacks.Register( "Draw", function()
    WINDOW:SetActive(gui.Reference("Menu"):IsActive())
    players = entities.FindByClass("CCSPlayer")
    pNames = {}
    for i = 1, #players do table.insert(pNames, players[i]:GetName()) end
    NAMESTEALER_PLAYERS:SetOptions(unpack(pNames))
end )