-- b1g lua by stacky

local KEYBOX = gui.Keybox(gui.Reference("Settings", "Advanced", "Manage advanced settings"), "menukey", "Open Menu Key", 45)
callbacks.Register( "Draw", function() gui.Reference("Menu"):SetOpenKey(KEYBOX:GetValue()) end )