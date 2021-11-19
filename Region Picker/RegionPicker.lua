local GUI = {}

GUI.Reference      = gui.Reference("Misc", "General", "Extra")
GUI.Enable         = gui.Checkbox(GUI.Reference, "regionpicker.enable", "Region Picker Enable", false)
GUI.RegionPickerUS = gui.Multibox(GUI.Reference, "Region Picker US")
GUI.RegionPickerEU = gui.Multibox(GUI.Reference, "Region Picker EU")
GUI.RegionPickerAS = gui.Multibox(GUI.Reference, "Region Picker Asia")
GUI.RegionPickerOT = gui.Multibox(GUI.Reference, "Region Picker Other")

local function DATACENTER(name, id_string, id, multibox) return {name = name, id_string = id_string, id = id, checkbox = gui.Checkbox(multibox, "regionpicker." .. id_string, name, false)} end

local Datacenters = {
    DATACENTER( "Moses Lake (US Central)"       ,  "eat" ,  6644084   ,  GUI.RegionPickerUS ),
    DATACENTER( "Chicago (US Central)"          ,  "ord" ,  7303780   ,  GUI.RegionPickerUS ),
    DATACENTER( "Atlanta (US East)"             ,  "atl" ,  6386796   ,  GUI.RegionPickerUS ),
    DATACENTER( "Sterling (US East)"            ,  "iad" ,  6906212   ,  GUI.RegionPickerUS ),
    DATACENTER( "Dallas (US South)"             ,  "dfw" ,  6579831   ,  GUI.RegionPickerUS ),
    DATACENTER( "Los Angeles (US West)"         ,  "lax" ,  7102840   ,  GUI.RegionPickerUS ),
    DATACENTER( "Seattle (US North-West)"       ,  "sea" ,  7562593   ,  GUI.RegionPickerUS ),
        
    DATACENTER( "Warsaw (EU Central)"           ,  "waw" ,  7823735   ,  GUI.RegionPickerEU ),
    DATACENTER( "Vienna (EU Central)"           ,  "vie" ,  7760229   ,  GUI.RegionPickerEU ),
    DATACENTER( "London (EU North)"             ,  "lhr" ,  7104626   ,  GUI.RegionPickerEU ),
    DATACENTER( "Stockholm (Kista) (EU North)"  ,  "sto" ,  7566447   ,  GUI.RegionPickerEU ),
    DATACENTER( "Stockholm (Bromma) (EU North)" ,  "sto2",  846427247 ,  GUI.RegionPickerEU ),
    DATACENTER( "Madrid (EU South)"             ,  "mad" ,  7168356   ,  GUI.RegionPickerEU ),
    DATACENTER( "Amsterdam (EU West)"           ,  "ams" ,  6385011   ,  GUI.RegionPickerEU ),
    DATACENTER( "Frankfurt (EU West)"           ,  "fra" ,  6713953   ,  GUI.RegionPickerEU ),
    DATACENTER( "Paris (EU West)"               ,  "par" ,  7364978   ,  GUI.RegionPickerEU ),
    
    DATACENTER( "Dongcheng Qu (Asia Central)"   ,  "pwu" ,  7370613   ,  GUI.RegionPickerAS ),
    DATACENTER( "Cangzhou (Asia North-East)"    ,  "pwj" ,  7370602   ,  GUI.RegionPickerAS ),
    DATACENTER( "Xianghe Xian (Asia North-East)",  "tsn" ,  7631726   ,  GUI.RegionPickerAS ),
    DATACENTER( "Tianjin 1 (Asia North-East)"   ,  "tsnm",  1836348270,  GUI.RegionPickerAS ),
    DATACENTER( "Tianjin 2 (Asia North-East)"   ,  "tsnu",  1970565998,  GUI.RegionPickerAS ),
    DATACENTER( "Beijing (Asia North-East)"     ,  "tsnt",  1953788782,  GUI.RegionPickerAS ),
    DATACENTER( "Qingcheng (Asia East)"         ,  "can" ,  6513006   ,  GUI.RegionPickerAS ),
    DATACENTER( "Guangzhou 1 (Asia East)"       ,  "canm",  1835229550,  GUI.RegionPickerAS ),
    DATACENTER( "Guangzhou 2 (Asia East)"       ,  "cant",  1952670062,  GUI.RegionPickerAS ),
    DATACENTER( "Guangzhou 3 (Asia East)"       ,  "canu",  1969447278,  GUI.RegionPickerAS ),
    DATACENTER( "Guangzhou 4 (Asia East)"       ,  "pwg" ,  7370599   ,  GUI.RegionPickerAS ),
    DATACENTER( "Hong Kong (Asia East)"         ,  "hkg" ,  6843239   ,  GUI.RegionPickerAS ),
    DATACENTER( "Dongyang (Asia East)"          ,  "pwz" ,  7370618   ,  GUI.RegionPickerAS ),
    DATACENTER( "Seoul (Asia East)"             ,  "seo" ,  7562607   ,  GUI.RegionPickerAS ),
    DATACENTER( "Shanghai (Asia East)"          ,  "sha" ,  7563361   ,  GUI.RegionPickerAS ),
    DATACENTER( "Shanghai (Mobile) (Asia East)" ,  "sham",  1836279905,  GUI.RegionPickerAS ),
    DATACENTER( "Shanghai (Telecom) (Asia East)",  "shat",  1953720417,  GUI.RegionPickerAS ),
    DATACENTER( "Shanghai Backbone (Asia East)" ,  "shb" ,  7563362   ,  GUI.RegionPickerAS ),
    DATACENTER( "Shanghai (Unicom) (Asia East)" ,  "shau",  1970497633,  GUI.RegionPickerAS ),
    DATACENTER( "Tokyo (North) (Asia East)"     ,  "tyo" ,  7633263   ,  GUI.RegionPickerAS ),
    DATACENTER( "Tokyo (South) (Asia East)"     ,  "tyo1",  829716847 ,  GUI.RegionPickerAS ),
    DATACENTER( "Hongshan Qu (Asia South-East)" ,  "pww" ,  7370615   ,  GUI.RegionPickerAS ),
    DATACENTER( "Singapore (Asia South-East)"   ,  "sgp" ,  7563120   ,  GUI.RegionPickerAS ),
    
    DATACENTER( "Sao Paulo (SA East)"           ,  "gru" ,  6779509   ,  GUI.RegionPickerOT ),
    DATACENTER( "Buenos Aires (SA South)"       ,  "eze" ,  6650469   ,  GUI.RegionPickerOT ),
    DATACENTER( "Santiago (SA South-West)"      ,  "scl" ,  7562092   ,  GUI.RegionPickerOT ),
    DATACENTER( "Lima (SA West)"                ,  "lim" ,  7104877   ,  GUI.RegionPickerOT ),
    DATACENTER( "Chennai (India South-East)"    ,  "maa" ,  7168353   ,  GUI.RegionPickerOT ),
    DATACENTER( "Bombay (India West)"           ,  "bom" ,  6451053   ,  GUI.RegionPickerOT ),
    DATACENTER( "Dubai (Middle-East)"           ,  "dxb" ,  6584418   ,  GUI.RegionPickerOT ),
    DATACENTER( "Johannesburg (Africa South)"   ,  "jnb" ,  6975074   ,  GUI.RegionPickerOT ),
    DATACENTER( "Sydney (Australia South-East)" ,  "syd" ,  7567716   ,  GUI.RegionPickerOT ) 
}

ffi.cdef[[
    typedef void* (*GetInterfaceFn)();
    typedef struct {
        GetInterfaceFn Interface;
        char* InterfaceName;
        void* NextInterface;
    } CInterface;

    void* LoadLibraryA(const char*);
    void* GetProcAddress(void*, const char*);
    void* GetModuleHandleA(const char*);
    bool VirtualProtect(void*, intptr_t, unsigned long, unsigned long*);

    typedef __int32 HSteamUser;
    typedef __int32 HSteamPipe;

    typedef __int32 EGCResults;
]]

mem.CreateInterface = function(module, interfaceName)
    local pCreateInterface = ffi.cast("int", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA(module), "CreateInterface"))
    local interface = ffi.cast("CInterface***", pCreateInterface + ffi.cast("int*", pCreateInterface + 5)[0] + 15)[0][0]

    while interface ~= ffi.NULL do
        if string.sub(ffi.string(interface.InterfaceName), 0, -4) == interfaceName then
            return interface.Interface()
        end

        interface = ffi.cast("CInterface*", interface.NextInterface)
    end

    return 0
end

local VMTHookManager = {}

function VMTHookManager:New(base)
    assert(base and base ~= ffi.NULL)
    return setmetatable({base = ffi.cast("void***", base), orig = {}}, {__index = self})
end

function VMTHookManager:HookMethod(index, func)
    self.orig[index] = self:_ReplaceMethodPtr(index, func)
end

function VMTHookManager:GetOriginal(index, typestring)
    return ffi.cast(ffi.typeof(typestring), self.orig[index])
end

function VMTHookManager:UnhookMethod(index)
    assert(self.orig[index])
    self:_ReplaceMethodPtr(index, self:GetOriginal(index, "void*"))
end

function VMTHookManager:_ReplaceMethodPtr(index, func)
    assert(self.base and self.base ~= ffi.NULL)
    assert(index >= 0)
    assert(func and func ~= ffi.NULL)

    local prevFunc = self.base[0][index]

    local oldProtection = ffi.new("int[1]", 0)
    ffi.C.VirtualProtect(self.base[0] + index, 4, 0x40, oldProtection)
    self.base[0][index] = ffi.cast("void*", func)
    ffi.C.VirtualProtect(self.base[0] + index, 4, oldProtection[0], oldProtection)

    return prevFunc
end

local function cast(type, object)
    return setmetatable({object}, {__index = type})
end

local function CallVFunction(base, index, typestring)
    return ffi.cast(ffi.typeof(typestring), ffi.cast("void***", base)[0][index])
end


local EGCResults = {
    k_EGCResultOK = 0,
	k_EGCResultNoMessage = 1,
	k_EGCResultBufferTooSmall = 2,
	k_EGCResultNotLoggedOn = 3,
	k_EGCResultInvalidMessage = 4
}

local ECsgoGCMsg = {
    k_EMsgGCCStrike15_v2_MatchmakingClient2ServerPing = 9103
}

local ISteamClient = {}

function ISteamClient:GetISteamGenericInterface(hSteamUser, hSteamPipe, pchVersion)
    local this = self[1]
    return CallVFunction(this, 12, "void*(__thiscall*)(void*, HSteamUser, HSteamPipe, const char*)")(this, hSteamUser, hSteamPipe, pchVersion)
end

local RegionPicker = {
    GameCoordinatorHook = nil,
    Hooks = {
        oSendMessage = nil,
        hkSendMessage = nil
    },
    Library = nil,
    ModifyDatacenterPingData = nil
}

function RegionPicker:GetAllowedDatacenters()
    local allowed = {}

    for _, datacenter in pairs(Datacenters) do
        if datacenter.checkbox:GetValue() then
            allowed[#allowed + 1] = datacenter.id
        end
    end

    local pAllowedDatacenters = ffi.new("uint32_t[?]", #allowed + 1)
   
    for i = 0, #allowed - 1 do
        pAllowedDatacenters[i] = ffi.cast("uint32_t", allowed[i + 1])
    end

    pAllowedDatacenters[#allowed] = 0

    return pAllowedDatacenters
end

function RegionPicker:LoadLibrary()
    self.Library = ffi.C.LoadLibraryA("RegionPicker.dll")
    self.ModifyDatacenterPingData = ffi.cast("void*(__cdecl*)(const void* pubData, uint32_t cubData, uint32_t* allowedDatacenters)", ffi.C.GetProcAddress(self.Library, "ModifyDatacenterPingData"))
end

function RegionPicker:HookGameCoordinator()
    local SteamClient = cast(ISteamClient, ffi.cast("void*(__cdecl*)()", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("steam_api.dll"), "SteamClient"))())
    local hSteamUser = ffi.cast("HSteamUser(__cdecl*)()", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("steam_api.dll"), "SteamAPI_GetHSteamUser"))()
    local hSteamPipe = ffi.cast("HSteamPipe(__cdecl*)()", ffi.C.GetProcAddress(ffi.C.GetModuleHandleA("steam_api.dll"), "SteamAPI_GetHSteamPipe"))()
    local GameCoordinator = SteamClient:GetISteamGenericInterface(hSteamUser, hSteamPipe, "SteamGameCoordinator001")
    
    self.GameCoordinatorHook = VMTHookManager:New(GameCoordinator)
end

function RegionPicker:HookSendMessage()
    self.Hooks.hkSendMessage = function(this, edx, unMsgType, pubData, cubData)
        if bit.band(unMsgType, 0x7FFFFFFF) == ECsgoGCMsg.k_EMsgGCCStrike15_v2_MatchmakingClient2ServerPing and GUI.Enable:GetValue() then
            local allowedDatacenters = self:GetAllowedDatacenters()
            local buffer = self.ModifyDatacenterPingData(pubData, cubData, allowedDatacenters)

            if buffer ~= ffi.NULL then
                return self.Hooks.oSendmessage(this, unMsgType, buffer, cubData)
            end
        end
        
        return self.Hooks.oSendmessage(this, unMsgType, pubData, cubData)
    end

    self.GameCoordinatorHook:HookMethod(0, ffi.cast("EGCResults(__fastcall*)(void*, void*, uint32_t, void*, uint32_t)", self.Hooks.hkSendMessage))
    self.Hooks.oSendmessage = self.GameCoordinatorHook:GetOriginal(0, "EGCResults(__thiscall*)(void*, uint32_t, void*, uint32_t)")
end

function RegionPicker:Initialize()
    self:LoadLibrary()

    self:HookGameCoordinator()
    self:HookSendMessage()
end

function RegionPicker:OnUnload()
    self.GameCoordinatorHook:UnhookMethod(0)
end


local function main()
    RegionPicker:Initialize()

    callbacks.Register("Unload", function() 
        RegionPicker:OnUnload()
    end)
end

main()