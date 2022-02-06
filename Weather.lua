--#region Helpers/Helper.lua
ffi.cdef[[
    typedef void* (*GetInterfaceFn)();
    typedef struct {
        GetInterfaceFn Interface;
        char* InterfaceName;
        void* NextInterface;
    } CInterface;

    void* GetProcAddress(void*, const char*);
    void* GetModuleHandleA(const char*);
]]

local function CreateInterface(module, interfaceName)
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

local function cast(class, object)
    if type(object) ~= "table" then
        return setmetatable({object}, {__index = class})
    else
        return setmetatable(object, {__index = class})
    end
end

local function CallVFunction(base, index, typestring)
    assert(index >= 0)
    return ffi.cast(ffi.typeof(typestring), ffi.cast("void***", base)[0][index])
end
--#endregion Helpers/Helper.lua

--#region Helpers/VMTHookManager.lua
local VMTHookManager = {
    m_Hooks = {}
}

local VMTHook = {}

function VMTHookManager:HookVMT(pBase)
    assert(pBase and pBase ~= ffi.NULL)
    local hook = setmetatable({
        m_pBase = ffi.cast("void***", pBase),
        m_origMethods = {}
    }, 
    {__index = VMTHook})

    self.m_Hooks[#self.m_Hooks + 1] = hook

    return hook
end

function VMTHook:UnhookMethod(index)
    assert(self.m_origMethods[index])
    self:ReplaceMethodPtr(index, self.m_origMethods[index])
end

function VMTHook:ReplaceMethodPtr(index, pFunc)
    assert(self.m_pBase and self.m_pBase ~= ffi.NULL)
    assert(index >= 0)
    assert(pFunc and pFunc ~= ffi.NULL)

    local oldProtection = ffi.new("int[1]", 0)
    ffi.C.VirtualProtect(self.m_pBase[0] + index, 4, 0x40, oldProtection)
    self.m_pBase[0][index] = ffi.cast("void*", pFunc)
    ffi.C.VirtualProtect(self.m_pBase[0] + index, 4, oldProtection[0], oldProtection)
end

function VMTHook:HookMethod(index, type, callback)
    local pfnOrigMethod = ffi.cast(ffi.typeof(type), self.m_pBase[0][index])
    self.m_origMethods[index] = pfnOrigMethod

    self:ReplaceMethodPtr(index, ffi.cast(ffi.typeof(type), function(...)
        callback(...)
        pfnOrigMethod(...)
    end))
end

function VMTHookManager:OnUnload()
    for _, hook in pairs(VMTHookManager.m_Hooks) do
        for idx, _ in pairs(hook.m_origMethods) do
            hook:UnhookMethod(idx)
        end
    end
end

--#endregion Helpers/VMTHookManager.lua

--#region SDK/Interfaces/IBaseClientDLL.lua
ffi.cdef[[
    typedef void* (*CreateClientClassFn)(int entnum, int serialNum);
    typedef void* (*CreateEventFn)();
    
    typedef struct {
        CreateClientClassFn      m_pCreateFn;
        CreateEventFn            m_pCreateEventFn;
        char*                    m_pNetworkName;
        void*                    m_pRecvTable;
        void*                    m_pNext;
        int                      m_ClassID;
    } ClientClass;
]]

local IBaseClientDLL = {}

function IBaseClientDLL:GetAllClasses()
    local this = self[1]
    return CallVFunction(this, 8, "ClientClass*(__thiscall*)(void*)")(this)
end

function IBaseClientDLL:GetClass(name)
    local class = self:GetAllClasses()

    while class ~= ffi.NULL do
        if ffi.string(class.m_pNetworkName) == name then
            return class
        end

        class = ffi.cast("ClientClass*", class.m_pNext)
    end
end
--#endregion SDK/Interfaces/IBaseClientDLL.lua

--#region SDK/Interfaces/IClientEntityList.lua
local IClientEntityList = {}

function IClientEntityList:GetClientEntity(idx)
    local this = self[1]
    return CallVFunction(this, 3, "void*(__thiscall*)(void*, int)")(this, idx)
end
--#endregion SDK/Interfaces/IClientEntityList.lua

--#region SDK/Interfaces/ConVar.lua
local ConVar = {}

function ConVar:SetString(value)
    local this = self[1]
    return CallVFunction(this, 14, "void(__thiscall*)(void*, const char*)")(this, value)
end

function ConVar:SetFloat(value)
    local this = self[1]
    return CallVFunction(this, 15, "void(__thiscall*)(void*, float)")(this, value)
end

function ConVar:SetInt(value)
    local this = self[1]
    return CallVFunction(this, 16, "void(__thiscall*)(void*, int)")(this, value)
end

function ConVar:SetValue(value)
    if type(value) == "string" then
        self:SetString(value)
    elseif type(value) == "number" then
        if value % 1 == 0 then
            self:SetInt(value)
        else
            self:SetFloat(value)
        end
    elseif type(value) == "boolean" then
        self:SetInt(value)
    end
end
--#endregion SDK/Interfaces/ConVar.lua

--#region SDK/Interfaces/ICvar.lua
local ICVar = {}

function ICVar:FindVar(var_name)
    local this = self[1]
    return cast(ConVar, CallVFunction(this, 16, "void*(__thiscall*)(void*, const char*)")(this, var_name))
end
--#endregion SDK/Interfaces/ICvar.lua

--#region ihatelinkingfilesmanually
local g_Client = cast(IBaseClientDLL, CreateInterface("client.dll", "VClient"))
--#endregion ihatelinkingfilesmanually

--#region SDK/NetvarManager.lua
ffi.cdef[[
    typedef void(*RecvVarProxyFn)(const void *pData, void *pStruct, void *pOut);
    typedef void(*ArrayLengthRecvProxyFn)(void *pStruct, int objectID, int currentArrayLength);
    typedef void(*DataTableRecvVarProxyFn)(const void* *pProp, void **pOut, void *pData, int objectID);

    typedef struct {
        char*                   m_pVarName;
        int                     m_RecvType;
        int                     m_Flags;
        int                     m_StringBufferSize;
        int                     m_bInsideArray;
        const void*             m_pExtraData;
        void*                   m_pArrayProp;
        ArrayLengthRecvProxyFn  m_ArrayLengthProxy;
        RecvVarProxyFn          m_ProxyFn;
        DataTableRecvVarProxyFn m_DataTableProxyFn;
        void*                   m_pDataTable;
        int                     m_Offset;
        int                     m_ElementStride;
        int                     m_nElements;
        const char*             m_pParentArrayPropName;
    } RecvProp;

    typedef struct {
        void* m_pProps;
        int   m_nProps;
        void* m_pDecoder;
        char* m_pNetTableName;
        bool  m_bInitialized;
        bool  m_bInMainList;
    } RecvTable;
]]

local CNetvarTable = {}

function CNetvarTable:New()
    return {
        name = "",
        prop = ffi.new("void*"),
        offset = 0,
        child_props = {},
        child_tables = {}
    }
end

local database = {}

local DPT_DataTable = 6

local NetvarManager = {}

function NetvarManager:Initialize()
    local class = g_Client:GetAllClasses()

    while class.m_pNext ~= ffi.NULL do
        if class.m_pRecvTable ~= ffi.NULL then
            database[#database + 1] = self:LoadTable(class.m_pRecvTable)
        end

        class = ffi.cast("ClientClass*", class.m_pNext)
    end
end

function NetvarManager:LoadTable(recvTable)
    recvTable = ffi.cast("RecvTable*", recvTable)

    local table = CNetvarTable:New()

    table.offset = 0
    table.name = ffi.string(recvTable.m_pNetTableName)

    for i = 0, recvTable.m_nProps - 1 do
        local prop = ffi.cast("RecvProp*", recvTable.m_pProps)[i]

        if prop == ffi.NULL or tonumber(ffi.string(prop.m_pVarName):sub(1, 1)) then
            goto continue
        end

        if ffi.string(prop.m_pVarName) == "baseclass" then
            goto continue
        end

        if prop.m_RecvType == DPT_DataTable and prop.m_pDataTable ~= ffi.NULL then
            table.child_tables[#table.child_tables + 1] = self:LoadTable(prop.m_pDataTable)
            table.child_tables[#table.child_tables].offset = prop.m_Offset
            table.child_tables[#table.child_tables].prop = prop
        else
            table.child_props[#table.child_props + 1] = prop
        end

        ::continue::
    end

    return table
end

function NetvarManager:_GetOffset(table, propName, yo)
    for _, prop in pairs(table.child_props) do
        if ffi.string(prop.m_pVarName) == propName then
            return table.offset + prop.m_Offset
        end
    end

    for _, child in pairs(table.child_tables) do
        local prop_offset = self:_GetOffset(child, propName)
        if prop_offset ~= 0 then
            return table.offset + prop_offset
        end
    end

    for _, child in pairs(table.child_tables) do
        if ffi.string(child.prop.m_pVarName) == propName then
            return table.offset + child.offset
        end
    end

    return 0
end

function NetvarManager:GetOffset(tableName, propName)
    for _, table in pairs(database) do
        if table.name == tableName then
            local result = self:_GetOffset(table, propName)

            if result ~= 0 then
                return result
            end
        end
    end

    return 0
end

NetvarManager:Initialize()
--#endregion SDK/NetvarManager.lua

--#region SDK/Interfaces/CClient_Precipitation.lua
local CClient_Precipitation = {
    m_nPrecipType = NetvarManager:GetOffset("DT_Precipitation", "m_nPrecipType"),
    m_vecMins = NetvarManager:GetOffset("DT_BaseEntity", "m_vecMins"),
    m_vecMaxs = NetvarManager:GetOffset("DT_BaseEntity", "m_vecMaxs"),
}

function CClient_Precipitation:GetPrecipitationType()
    local this = self[1]
    return ffi.cast("int*", ffi.cast("uintptr_t", this) + self.m_nPrecipType)
end

function CClient_Precipitation:GetMins()
    local this = self[1]
    return ffi.cast("Vector3*", ffi.cast("uintptr_t", this) + self.m_vecMins)
end

function CClient_Precipitation:GetMaxs()
    local this = self[1]
    return ffi.cast("Vector3*", ffi.cast("uintptr_t", this) + self.m_vecMaxs)
end

function CClient_Precipitation:Release()
    local this = self[1]
    CallVFunction(this, 0, "void(__thiscall*)(void*)")(this)
end
--#endregion SDK/Interfaces/CClient_Precipitation.lua

--#region SDK/Interfaces/IClientNetworkable.lua
local IClientNetworkable = {}

function IClientNetworkable:OnPreDataChanged(updateType)
    local this = self[1]
    return CallVFunction(this, 4, "void(__thiscall*)(void*, int)")(this, updateType)
end

function IClientNetworkable:OnDataChanged(updateType)
    local this = self[1]
    return CallVFunction(this, 5, "void(__thiscall*)(void*, int)")(this, updateType)
end

function IClientNetworkable:PreDataUpdate(updateType)
    local this = self[1]
    return CallVFunction(this, 6, "void(__thiscall*)(void*, int)")(this, updateType)
end

function IClientNetworkable:PostDataUpdate(updateType)
    local this = self[1]
    return CallVFunction(this, 7, "void(__thiscall*)(void*, int)")(this, updateType)
end
--#endregion SDK/Interfaces/IClientNetworkable.lua

--#region SDK/SDK.lua
-- include "Helpers/Helper"

-- include "SDK/Interfaces/IBaseClientDLL"
-- include "SDK/Interfaces/IClientEntityList"
-- include "SDK/Interfaces/ICVar"

-- g_Client = cast(IBaseClientDLL, CreateInterface("client.dll", "VClient"))
local g_EntityList = cast(IClientEntityList, CreateInterface("client.dll", "VClientEntityList"))
local g_CVar = cast(ICVar, CreateInterface("vstdlib.dll", "VEngineCvar"))

-- include "SDK/NetvarManager"

-- include "SDK/Interfaces/CClient_Precipitation"
-- include "SDK/Interfaces/IClientNetworkable"
-- include "SDK/Interfaces/ConVar"

ffi.cdef[[
    typedef struct { float x, y, z; } Vector3;

    bool VirtualProtect(void*, intptr_t, unsigned long, unsigned long*);
    void* LoadLibraryA(const char*);
    void* GetProcAddress(void*, const char*);
    void* memcpy(void*, const void*, size_t);
]]

local MAX_EDICT_BITS = 11
local MAX_EDICTS = bit.lshift(1, MAX_EDICT_BITS)

local DataUpdateType = {
    DATA_UPDATE_CREATED = 0,
    DATA_UPDATE_DATATABLE_CHANGED = 1
}
--#endregion SDK/SDK.lua

--#region GUIState.lua
local GUIState = {
    m_prevState = {},
    m_flLastUpdateTime = 0,
    m_flUpdateInterval = 0.25,
    m_Callbacks = {},
    m_GUI = {}
}

function GUIState:GetHash(obj)
    local value = {obj:GetValue()}

    if #value == 1 then
        return value[1]
    else
        return value[1] + value[2] + value[3] + value[4]
    end
end

function GUIState:Initialize()
    for _, obj in pairs(self.m_GUI) do
        self.m_prevState[obj] = self:GetHash(obj)
    end
end

function GUIState:CreateCallback(obj, callback)
    self.m_Callbacks[obj] = function() callback(obj:GetValue()) end
    return obj
end

function GUIState:CheckState()
    for _, obj in pairs(self.m_GUI) do
        if self:GetHash(obj) ~= self.m_prevState[obj] then
            if self.m_Callbacks[obj] then
                self.m_Callbacks[obj]()
            end

            self.m_prevState[obj] = self:GetHash(obj)
        end
    end
end

function GUIState:OnDraw()
    if common.Time() - self.m_flLastUpdateTime >= self.m_flUpdateInterval then
        self:CheckState()
        self.m_nPrevUpdateTick = common.Time()
    end
end

function GUIState:SetGUI(gui)
    self.m_GUI = gui
end
--#endregion GUIState.lua

--#region GUI.lua
-- local GUIState = include "GUIState"

local SetupGUI = function(props)
    local GUI = {}

    local function updatePrecipitationAttributeSelection(attribute)
        local attributes = {
            GUI.PrecipitationAlpha,
            GUI.PrecipitationLength,
            GUI.PrecipitationWidth,
            GUI.PrecipitationSpeed,
            GUI.PrecipitationWindSpeed
        }
    
        for i, v in pairs(attributes) do
            if i == attribute + 1 then
                v:SetInvisible(false)
                v:SetPosY(130)
            else
                v:SetInvisible(true)
            end
        end
    end

    local function updateFogAttributeSelection(attribute)
        local attributes = {
            GUI.FogDensity,
            GUI.FogStart,
            GUI.FogEnd
        }
    
        for i, v in pairs(attributes) do
            if i == attribute + 1 then
                v:SetInvisible(false)
                v:SetPosY(75)
            else
                v:SetInvisible(true)
            end
        end
    end

    GUI.Reference = gui.Reference("Visuals", "World")
    GUI.WeatherGroupbox = gui.Groupbox(GUI.Reference, "Weather", 327, 287, 297, 0)

    GUI.PrecipitationActive = GUIState:CreateCallback(
        gui.Checkbox(GUI.WeatherGroupbox, "weather.precip.active", "Enable Weather", false),
        props.PrecipitationActiveCallback
    )
    
    GUI.PrecipitationType = GUIState:CreateCallback(
        gui.Combobox(GUI.WeatherGroupbox, "weather.precip.type", "Weather Type", "Rain", "Snow"),
        props.PrecipitationTypeCallback
    )

    GUI.PrecipitationAttributeCombo = GUIState:CreateCallback(
        gui.Combobox(GUI.WeatherGroupbox, "weather.attribute", "Attribute", "Alpha", "Length", "Width", "Speed", "Wind Speed"),
        updatePrecipitationAttributeSelection
    )

    GUI.PrecipitationAlpha = GUIState:CreateCallback(
        gui.Slider(GUI.WeatherGroupbox, "weather.precip.alpha", "", 0.4, 0, 1, 0.01),
        props.PrecipitationAlphaCallback
    )

    GUI.PrecipitationLength = GUIState:CreateCallback(
        gui.Slider(GUI.WeatherGroupbox, "weather.precip.length", "", 0.1, 0, 10, 0.01),
        props.PrecipitationLengthCallback
    )
    
    GUI.PrecipitationWidth = GUIState:CreateCallback(
        gui.Slider(GUI.WeatherGroupbox, "weather.precip.width", "", 0.5, 0, 1, 0.01),
        props.PrecipitationLengthCallback
    )

    GUI.PrecipitationSpeed = GUIState:CreateCallback(
        gui.Slider(GUI.WeatherGroupbox, "weather.precip.speed", "", 600, 0, 1000, 1),
        props.PrecipitationSpeedCallback
    )

    GUI.PrecipitationWindSpeed = GUIState:CreateCallback(
        gui.Slider(GUI.WeatherGroupbox, "weather.precip.windspeed", "", 0, 0, 10, 0.01),
        props.PrecipitationWindSpeedCallback
    )

    
    GUI.FogGroupbox = gui.Groupbox(GUI.Reference, "Fog", 327, 527, 297, 0)

    GUI.FogActive = GUIState:CreateCallback(
        gui.Checkbox(GUI.FogGroupbox, "weather.fog.active", "Enable Fog", false),
        props.FogActiveCallback
    )

    GUI.FogColor = GUIState:CreateCallback(
        gui.ColorPicker(GUI.FogActive, "fog.color", "", 179, 210, 255, 255),
        props.FogColorCallback
    )

    GUI.FogAttributeCombo = GUIState:CreateCallback(
        gui.Combobox(GUI.FogGroupbox, "weather.fog.attribute", "Attribute", "Density", "Start", "End" ),
        updateFogAttributeSelection
    )

    GUI.FogDensity = GUIState:CreateCallback(
        gui.Slider(GUI.FogGroupbox, "weather.fog.density", "", 0.6, 0, 1, 0.01),
        props.FogDensityCallback
    )

    GUI.FogStart = GUIState:CreateCallback(
        gui.Slider(GUI.FogGroupbox, "weather.fog.start", "", 0, 0, 3000, 1),
        props.FogStartCallback
    )

    GUI.FogEnd = GUIState:CreateCallback(
        gui.Slider(GUI.FogGroupbox, "weather.fog.end", "", 1400, 0, 3000, 1),
        props.FogEndCallback
    )


    GUI.TonemapScale = GUIState:CreateCallback(
        gui.Slider(gui.Reference("Visuals", "World", "Materials"), "weather.tonemap.scale", "Tonemap Scale", 1, 0, 1, 0.01),
        props.TonemapScaleCallback
    )

    updatePrecipitationAttributeSelection(0)
    updateFogAttributeSelection(0)

    GUIState:SetGUI(GUI)
    GUIState:Initialize()
end
--#endregion GUI.lua

--#region Features/FogController.lua
local FogController = {
    m_bActive = false,
    m_Color = {179, 210, 255}
}

function FogController:SetActive(active)
    self.m_bActive = active

    if self.m_bActive then
        print(g_CVar)
        g_CVar:FindVar("fog_enable"):SetValue(1)
        g_CVar:FindVar("fog_enableskybox"):SetValue(1)
        g_CVar:FindVar("fog_override"):SetValue(1)

        g_CVar:FindVar("fog_color"):SetValue(tostring(self.m_Color[1]) .. " " .. tostring(self.m_Color[2]) .. " " .. tostring(self.m_Color[3]))
        g_CVar:FindVar("fog_colorskybox"):SetValue(tostring(self.m_Color[1]) .. " " .. tostring(self.m_Color[2]) .. " " .. tostring(self.m_Color[3]))

        g_CVar:FindVar("fog_maxdensity"):SetValue(0.627)
        g_CVar:FindVar("fog_maxdensityskybox"):SetValue(0.627)

        g_CVar:FindVar("fog_start"):SetValue(0)
        g_CVar:FindVar("fog_startskybox"):SetValue(0)
        
        g_CVar:FindVar("fog_end"):SetValue(1397)
        g_CVar:FindVar("fog_endskybox"):SetValue(1397)
    else
        g_CVar:FindVar("fog_override"):SetValue(0)
    end
end

function FogController:SetColor(r, g, b)
    self.m_Color = {r, g, b}

    g_CVar:FindVar("fog_color"):SetValue(tostring(self.m_Color[1]) .. " " .. tostring(self.m_Color[2]) .. " " .. tostring(self.m_Color[3]))
    g_CVar:FindVar("fog_colorskybox"):SetValue(tostring(self.m_Color[1]) .. " " .. tostring(self.m_Color[2]) .. " " .. tostring(self.m_Color[3]))
end

function FogController:SetAttribute(attribute, value)
    g_CVar:FindVar(attribute):SetValue(value)
end

function FogController:OnUnload()
    g_CVar:FindVar("fog_override"):SetValue(0)
end

-- return FogController
--#endregion Features/FogController.lua

--#region Features/PrecipitationController.lua
local PrecipitationController = {
    m_nPrecipType = 0,
    m_pClass = g_Client:GetClass("CPrecipitation"),
    m_bActive = false
}

function PrecipitationController:Create()
    local rainEntity = cast(CClient_Precipitation, g_EntityList:GetClientEntity(MAX_EDICTS - 1))

    if rainEntity[1] == ffi.NULL and self.m_bActive then
        local rainNetworkable = cast(IClientNetworkable, self.m_pClass.m_pCreateFn(MAX_EDICTS - 1, 0))

        if rainNetworkable[1] ~= ffi.NULL then
            rainEntity = cast(CClient_Precipitation, g_EntityList:GetClientEntity(MAX_EDICTS - 1))

            rainNetworkable:PreDataUpdate(DataUpdateType.DATA_UPDATE_CREATED)
            rainNetworkable:OnPreDataChanged(DataUpdateType.DATA_UPDATE_CREATED)
    
            rainEntity:GetPrecipitationType()[0] = self.m_nPrecipType
            rainEntity:GetMins()[0] = ffi.new("Vector3", {-32767 , -32767 , -32767})
            rainEntity:GetMaxs()[0] = ffi.new("Vector3", { 32767 ,  32767 ,  32767})
    
            rainNetworkable:OnDataChanged(DataUpdateType.DATA_UPDATE_CREATED)
            rainNetworkable:PostDataUpdate(DataUpdateType.DATA_UPDATE_CREATED)
        end
    end
end

function PrecipitationController:OnLevelChange()
    if self.m_bActive then
        self:Remove()
        self:Create()
    end
end

function PrecipitationController:OnUnload()
    self:Remove()
end

function PrecipitationController:SetType(nType)
    self.m_nPrecipType = nType
    self:Remove()
    self:Create()
end

function PrecipitationController:SetActive(bActive)
    self.m_bActive = bActive
    
    if self.m_bActive then
        self:Create()
    else
        self:Remove()
    end
end

function PrecipitationController:SetAttribute(attribute, value)
    g_CVar:FindVar(attribute):SetValue(value)
end

function PrecipitationController:Remove()
    local rainEntity = cast(CClient_Precipitation, g_EntityList:GetClientEntity(MAX_EDICTS - 1))

    if rainEntity[1] ~= ffi.NULL then
        rainEntity:Release()
    end
end
--#endregion Features/PrecipitationController.lua

--#region main
--local _={};function include(n)if _[n]then return _[n]end;local r=load(file.Read(".weather/"..n..".lua"), n, "t", _G)();_[n]=r;return r;end

--include "SDK/SDK"

-- local PrecipitationController = include "Features/PrecipitationController"
-- local FogController = include "Features/FogController"

-- local GUIState = include "GUIState"
-- local GUI = include "GUI"

callbacks.Register("Draw", function()
    GUIState:OnDraw()
end)

callbacks.Register("FireGameEvent", function(event)
    if event:GetName() == "player_connect_full" then
        PrecipitationController:OnLevelChange()
    end
end)
client.AllowListener("player_connect_full")

callbacks.Register("Unload", function()
    PrecipitationController:OnUnload()
    FogController:OnUnload()
    g_CVar:FindVar("mat_force_tonemap_scale"):SetValue(1)
end)

SetupGUI({
    PrecipitationActiveCallback = function(active)
        PrecipitationController:SetActive(active)
    end,
    PrecipitationTypeCallback = function(type)
        PrecipitationController:SetType(type)
    end,
    PrecipitationAlphaCallback = function(alpha)
        PrecipitationController:SetAttribute("r_rainalpha", alpha)
    end,
    PrecipitationLengthCallback = function(length)
        PrecipitationController:SetAttribute("r_rainlength", length)
    end,
    PrecipitationSpeedCallback = function(speed)
        PrecipitationController:SetAttribute("r_rainspeed", speed)
    end,
    PrecipitationWindSpeedCallback = function(windSpeed)
        PrecipitationController:SetAttribute("cl_windspeed", windSpeed)
    end,
    PrecipitationWidthCallback = function(width)
        PrecipitationController:SetAttribute("r_rainwidth", width)
    end,

    FogActiveCallback = function(active)
        FogController:SetActive(active)
    end,
    FogColorCallback = function(r, g, b)
        FogController:SetColor(r, g, b)
    end,
    FogDensityCallback = function(density)
        FogController:SetAttribute("fog_maxdensity", density)
        FogController:SetAttribute("fog_maxdensityskybox", density)
    end,
    FogStartCallback = function(start)
        FogController:SetAttribute("fog_start", start)
        FogController:SetAttribute("fog_startskybox", start)
    end,
    FogEndCallback = function(_end)
        FogController:SetAttribute("fog_end", _end)
        FogController:SetAttribute("fog_endskybox", _end)
    end,

    TonemapScaleCallback = function(scale)
        g_CVar:FindVar("mat_force_tonemap_scale"):SetValue(scale)
    end
})
--#endregion main