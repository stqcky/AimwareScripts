local GUI = {}

GUI.Teleport = gui.Button(gui.Reference("Misc", "Movement", "Other"), "Teleport", function() GUI.TeleportFn() end)

local pClientState = ffi.cast("uintptr_t**", mem.FindPattern("engine.dll", "A1 ?? ?? ?? ?? 8B 80 ?? ?? ?? ?? C3") + 1)[0][0]
local m_nSignonState = ffi.cast("int*", pClientState + 0x108)

local bPatched = false
local flPatchedTime = 0
local flLastCheckTime = 0
local bShouldTeleport = false

callbacks.Register("Draw", function() 
    if not bShouldTeleport then return end

    if not bPatched then
        if common.Time() - flLastCheckTime >= 0.1 then
            if m_nSignonState[0] > 5 then
                m_nSignonState[0] = 5
                bPatched = true
                flPatchedTime = common.Time()
            end
        
            client.Command("joingame", true)
            flLastCheckTime = common.Time()
        end
    else
        if common.Time() - flPatchedTime >= 2.2 then
            m_nSignonState[0] = 6
            bShouldTeleport = false
        end
    end
end)

GUI.TeleportFn = function()
    client.Command("disconnect", true)
    panorama.RunScript("CompetitiveMatchAPI.ActionReconnectToOngoingMatch()")
    bShouldTeleport = true
    bPatched = false
end