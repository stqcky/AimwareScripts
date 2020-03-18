-- Door Spam by stacky

local KEYBOX = gui.Keybox(gui.Reference("Misc", "General", "Extra"), "misc.doorspam", "Door Spam Key", 0)
local switch = false

callbacks.Register( "CreateMove", function(cmd)
    if KEYBOX:GetValue() ~= 0 then
        if input.IsButtonDown(KEYBOX:GetValue()) then
            if switch then client.Command("+use", true)
            else client.Command("-use", true) end
            switch = not switch
        else
            if not switch then client.Command("-use", true) end
        end
    end
end )
