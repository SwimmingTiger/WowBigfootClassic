local setmetatable = setmetatable
local type = type
local tostring = tostring
local select = select
local pairs = pairs
local tinsert = table.insert
local tsort = table.sort
local str_lower = string.lower
local GetTime = GetTime
local GetPhysicalScreenSize = GetPhysicalScreenSize
local InCombatLockdown = InCombatLockdown
local CreateFrame = CreateFrame
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local IsAddOnLoaded = IsAddOnLoaded
local GetBattlefieldStatus = GetBattlefieldStatus
local IsActiveBattlefieldArena = IsActiveBattlefieldArena
local IsInInstance = IsInInstance
local GetNumArenaOpponents = GetNumArenaOpponents
local RELEASE_TYPES = { alpha = "Alpha", beta = "Beta", release = "Release"}
local PREFIX = "Gladdy v"
local VERSION_REGEX = PREFIX .. "(%d+%.%d+)%-(%a)"
local LibStub = LibStub

---------------------------

-- CORE

---------------------------

local MAJOR, MINOR = "Gladdy", 11
local Gladdy = LibStub:NewLibrary(MAJOR, MINOR)
local L
Gladdy.version_major_num = 2
Gladdy.version_minor_num = 0.22
Gladdy.version_num = Gladdy.version_major_num + Gladdy.version_minor_num
Gladdy.version_releaseType = RELEASE_TYPES.release
Gladdy.version = PREFIX .. string.format("%.2f", Gladdy.version_num) .. "-" .. Gladdy.version_releaseType
Gladdy.VERSION_REGEX = VERSION_REGEX

Gladdy.debug = false

LibStub("AceTimer-3.0"):Embed(Gladdy)
LibStub("AceComm-3.0"):Embed(Gladdy)
Gladdy.modules = {}
setmetatable(Gladdy, {
    __tostring = function()
        return MAJOR
    end
})

function Gladdy:Print(...)
    local text = "|cff0384fcGladdy|r:"
    local val
    for i = 1, select("#", ...) do
        val = select(i, ...)
        if (type(val) == 'boolean') then val = val and "true" or false end
        text = text .. " " .. tostring(val)
    end
    DEFAULT_CHAT_FRAME:AddMessage(text)
end

function Gladdy:Warn(...)
    local text = "|cfff29f05Gladdy|r:"
    local val
    for i = 1, select("#", ...) do
        val = select(i, ...)
        if (type(val) == 'boolean') then val = val and "true" or false end
        text = text .. " " .. tostring(val)
    end
    DEFAULT_CHAT_FRAME:AddMessage(text)
end

function Gladdy:Error(...)
    local text = "|cfffc0303Gladdy|r:"
    local val
    for i = 1, select("#", ...) do
        val = select(i, ...)
        if (type(val) == 'boolean') then val = val and "true" or false end
        text = text .. " " .. tostring(val)
    end
    DEFAULT_CHAT_FRAME:AddMessage(text)
end

function Gladdy:Debug(lvl, ...)
    if Gladdy.debug then
        if lvl == "INFO" then
            Gladdy:Print("[INFO]", ...)
        elseif lvl == "WARN" then
            Gladdy:Warn("[WARN]", ...)
        elseif lvl == "ERROR" then
            Gladdy:Error("[ERROR]", ...)
        end
    end
end

Gladdy.events = CreateFrame("Frame")
Gladdy.events.registered = {}
Gladdy.events:RegisterEvent("PLAYER_LOGIN")
Gladdy.events:RegisterEvent("PLAYER_LOGOUT")
Gladdy.events:RegisterEvent("CVAR_UPDATE")
hooksecurefunc("VideoOptionsFrameOkay_OnClick", function(self, button, down, apply)
    if (self:GetName() == "VideoOptionsFrameApply") then
        Gladdy:PixelPerfectScale(true)
    end
end)
Gladdy.events:SetScript("OnEvent", function(self, event, ...)
    if (event == "PLAYER_LOGIN") then
        Gladdy:OnInitialize()
        Gladdy:OnEnable()
    elseif (event == "CVAR_UPDATE") then
        if (str_lower(select(1, ...)) == "uiscale") then
            Gladdy:PixelPerfectScale(true)
        end
    elseif (event == "PLAYER_LOGOUT") then
        Gladdy:DeleteUnknownOptions(Gladdy.db, Gladdy.defaults.profile)
    else
        local func = self.registered[event]

        if (type(Gladdy[func]) == "function") then
            Gladdy[func](Gladdy, event, ...)
        end
    end
end)

function Gladdy:RegisterEvent(event, func)
    self.events.registered[event] = func or event
    self.events:RegisterEvent(event)
end
function Gladdy:UnregisterEvent(event)
    self.events.registered[event] = nil
    self.events:UnregisterEvent(event)
end
function Gladdy:UnregisterAllEvents()
    self.events.registered = {}
    self.events:UnregisterAllEvents()
end

---------------------------

-- MODULE FUNCTIONS

---------------------------

local function pairsByPrio(t)
    local a = {}
    for k, v in pairs(t) do
        tinsert(a, { k, v.priority })
    end
    tsort(a, function(x, y)
        return x[2] > y[2]
    end)

    local i = 0
    return function()
        i = i + 1

        if (a[i] ~= nil) then
            return a[i][1], t[a[i][1]]
        else
            return nil
        end
    end
end
function Gladdy:IterModules()
    return pairsByPrio(self.modules)
end

function Gladdy:Call(module, func, ...)
    if (type(module) == "string") then
        module = self.modules[module]
    end

    if (type(module[func]) == "function") then
        module[func](module, ...)
    end
end
function Gladdy:SendMessage(message, ...)
    for _, module in self:IterModules() do
        self:Call(module, module.messages[message], ...)
    end
end

function Gladdy:NewModule(name, priority, defaults)
    local module = CreateFrame("Frame")
    module.name = name
    module.priority = priority or 0
    module.defaults = defaults or {}
    module.messages = {}

    module.RegisterMessages = function(self, ...)
        for _,message in pairs({...}) do
            self.messages[message] = message
        end
    end

    module.RegisterMessage = function(self, message, func)
        self.messages[message] = func or message
    end

    module.UnregisterMessage = function(self, message)
        self.messages[message] = nil
    end

    module.UnregisterMessages = function(self, ...)
        for _,message in pairs({...}) do
            self.messages[message] = nil
        end
    end

    module.UnregisterAllMessages = function(self)
        for msg,_ in pairs(self.messages) do
            self.messages[msg] = nil
        end
    end

    module.GetOptions = function()
        return nil
    end

    for k, v in pairs(module.defaults) do
        self.defaults.profile[k] = v
    end

    self.modules[name] = module

    return module
end

---------------------------

-- INIT

---------------------------

function Gladdy:DeleteUnknownOptions(tbl, refTbl, str)
    if str == nil then
        str = "Gladdy.db"
    end
    for k,v in pairs(tbl) do
        if refTbl[k] == nil then
            Gladdy:Debug("INFO", "SavedVariable deleted:", str .. "." .. k, "not found!")
            tbl[k] = nil
        else
            if type(v) ~= type(refTbl[k]) then
                Gladdy:Debug("INFO", "SavedVariable deleted:", str .. "." .. k, "type error!", "Expected", type(refTbl[k]), "but found", type(v))
                tbl[k] = nil
            elseif type(v) == "table" then
                Gladdy:DeleteUnknownOptions(v, refTbl[k], str .. "." .. k)
            end
        end
    end
end

function Gladdy:PixelPerfectScale(update)
    local physicalWidth, physicalHeight = GetPhysicalScreenSize()
    local perfectUIScale = 768.0/physicalHeight--768/select(2, strsplit("x",({ GetScreenResolutions()})[GetCurrentResolution()]))
    if self.db and self.db.pixelPerfect and self.frame then
        self.frame:SetIgnoreParentScale(true)
        self.frame:SetScale(perfectUIScale)
        --local adaptiveScale = (GetCVar("useUiScale") == "1" and 1.0 + perfectUIScale - GetCVar("UIScale") or perfectUIScale)
        --self.frame:SetScale(adaptiveScale)
        if update then
            self:UpdateFrame()
        end
    elseif self.frame then
        self.frame:SetScale(self.db.frameScale)
        self.frame:SetIgnoreParentScale(false)
    end
end

function Gladdy:OnInitialize()
    self.dbi = LibStub("AceDB-3.0"):New("GladdyXZ", self.defaults)
    self.dbi.RegisterCallback(self, "OnProfileChanged", "OnProfileChanged")
    self.dbi.RegisterCallback(self, "OnProfileCopied", "OnProfileChanged")
    self.dbi.RegisterCallback(self, "OnProfileReset", "OnProfileReset")
    self.db = self.dbi.profile

    self.LSM = LibStub("LibSharedMedia-3.0")
    self.LSM:Register("statusbar", "Gloss", "Interface\\AddOns\\Gladdy\\Images\\Gloss")
    self.LSM:Register("statusbar", "Smooth", "Interface\\AddOns\\Gladdy\\Images\\Smooth")
    self.LSM:Register("statusbar", "Minimalist", "Interface\\AddOns\\Gladdy\\Images\\Minimalist")
    self.LSM:Register("statusbar", "LiteStep", "Interface\\AddOns\\Gladdy\\Images\\LiteStep.tga")
    self.LSM:Register("statusbar", "Flat", "Interface\\AddOns\\Gladdy\\Images\\UI-StatusBar")
    self.LSM:Register("border", "Gladdy Tooltip round", "Interface\\AddOns\\Gladdy\\Images\\UI-Tooltip-Border_round_selfmade")
    self.LSM:Register("border", "Gladdy Tooltip squared", "Interface\\AddOns\\Gladdy\\Images\\UI-Tooltip-Border_square_selfmade")
    self.LSM:Register("font", "DorisPP", "Interface\\AddOns\\Gladdy\\Images\\DorisPP.TTF")
    self.LSM:Register("border", "Square Full White", "Interface\\AddOns\\Gladdy\\Images\\Square_FullWhite.tga")

    L = self.L

    self.testData = {
        ["arena1"] = { name = "Swift", raceLoc = L["NightElf"], classLoc = L["Druid"], class = "DRUID", health = 67, healthMax = 100, power = 76, powerMax = 100, powerType = 1, testSpec = L["Restoration"], race = "NightElf" },
        ["arena2"] = { name = "Vilden", raceLoc = L["Undead"], classLoc = L["Mage"], class = "MAGE", health = 99, healthMax = 100, power = 7833, powerMax = 10460, powerType = 0, testSpec = L["Frost"], race = "Scourge" },
        ["arena3"] = { name = "Krymu", raceLoc = L["Human"], classLoc = L["Rogue"], class = "ROGUE", health = 10, healthMax = 100, power = 45, powerMax = 110, powerType = 3, testSpec = L["Subtlety"], race = "Human" },
        ["arena4"] = { name = "Talmon", raceLoc = L["Human"], classLoc = L["Warlock"], class = "WARLOCK", health = 40, healthMax = 100, power = 9855, powerMax = 9855, powerType = 0, testSpec = L["Demonology"], race = "Human" },
        ["arena5"] = { name = "Hydra", raceLoc = L["Undead"], classLoc = L["Priest"], class = "PRIEST", health = 70, healthMax = 100, power = 2515, powerMax = 10240, powerType = 0, testSpec = L["Discipline"], race = "Human" },
    }

    self.cooldownSpellIds = {}
    self.spellTextures = {}
    self.specBuffs = self:GetSpecBuffs()
    self.specSpells = self:GetSpecSpells()
    self.buttons = {}
    self.guids = {}
    self.curBracket = nil
    self.curUnit = 1

    self:SetupOptions()

    for _, module in self:IterModules() do
        self:Call(module, "Initialize") -- B.E > A.E :D
    end
    if Gladdy.db.hideBlizzard == "always" then
        Gladdy:BlizzArenaSetAlpha(0)
    end
    if not self.db.newLayout then
        self:ToggleFrame(3)
        self:HideFrame()
    end
end

function Gladdy:OnProfileReset()
    self.db = self.dbi.profile
    Gladdy:Debug("INFO", "OnProfileReset")
    self:HideFrame()
    self:ToggleFrame(3)
    Gladdy.options.args.lock.name = Gladdy.db.locked and L["Unlock frame"] or L["Lock frame"]
    Gladdy.options.args.showMover.name = Gladdy.db.showMover and L["Hide Mover"] or L["Show Mover"]
    LibStub("AceConfigRegistry-3.0"):NotifyChange("Gladdy")
end

function Gladdy:OnProfileChanged()
    self.db = self.dbi.profile
    self:HideFrame()
    self:ToggleFrame(3)
    Gladdy.options.args.lock.name = Gladdy.db.locked and L["Unlock frame"] or L["Lock frame"]
    Gladdy.options.args.showMover.name = Gladdy.db.showMover and L["Hide Mover"] or L["Show Mover"]
    LibStub("AceConfigRegistry-3.0"):NotifyChange("Gladdy")
end

function Gladdy:OnEnable()
    self:RegisterEvent("UPDATE_BATTLEFIELD_STATUS")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("PLAYER_REGEN_ENABLED")

    if (IsAddOnLoaded("Clique")) then
        for i = 1, 5 do
            self:CreateButton(i)
        end

        ClickCastFrames = ClickCastFrames or {}
        ClickCastFrames[self.buttons.arena1.secure] = true
        ClickCastFrames[self.buttons.arena2.secure] = true
        ClickCastFrames[self.buttons.arena3.secure] = true
        ClickCastFrames[self.buttons.arena4.secure] = true
        ClickCastFrames[self.buttons.arena5.secure] = true
    end

    if (not self.db.locked and self.db.x == 0 and self.db.y == 0) then
        -- self:Print(L["Welcome to Gladdy!"])
        -- self:Print(L["First run has been detected, displaying test frame."])
        -- self:Print(L["Valid slash commands are:"])
        -- self:Print(L["/gladdy ui"])
        -- self:Print(L["/gladdy test2-5"])
        -- self:Print(L["/gladdy hide"])
        -- self:Print(L["/gladdy reset"])
        -- self:Print(L["If this is not your first run please lock or move the frame to prevent this from happening."])

        self:HideFrame()
        self:ToggleFrame(3)
        -- self.showConfig = true -- bf@178.com
		
		-- bf@178.com
		if Gladdy_applyProfile then
			Gladdy_applyProfile(Gladdy:GetClassicProfile())
		end
    end
end

function Gladdy:GetIconStyles()
    return
    {
        ["Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp"] = L["Gladdy Tooltip round"],
        ["Interface\\AddOns\\Gladdy\\Images\\Border_squared_blp"] = L["Gladdy Tooltip squared"],
        ["Interface\\AddOns\\Gladdy\\Images\\Border_Gloss"] = L["Gloss (black border)"],
    }
end

---------------------------

-- TEST

---------------------------

function Gladdy:Test()
    self.frame.testing = true
    if self.curBracket then
        for i = 1, self.curBracket do
            local unit = "arena" .. i
            if (not self.buttons[unit]) then
                self:CreateButton(i)
            end
            local button = self.buttons[unit]

            for k, v in pairs(self.testData[unit]) do
                button[k] = v
            end

            for _, module in self:IterModules() do
                self:Call(module, "Test", unit)
            end

            button:SetAlpha(1)
        end
        for _, module in self:IterModules() do
            self:Call(module, "TestOnce")
        end
    end
end

---------------------------

-- EVENT HANDLING

---------------------------

function Gladdy:PLAYER_ENTERING_WORLD()
    if self.showConfig then
        LibStub("AceConfigDialog-3.0"):Open("Gladdy", nil, LibStub("AceConfigDialog-3.0"):SelectGroup("Gladdy", "XiconProfiles"))
        self.showConfig = nil
    end
    if (self.frame and self.frame:IsVisible()) then
        self:Reset()
        self:HideFrame()
    end
end

function Gladdy:UPDATE_BATTLEFIELD_STATUS(_, index)
    local status, mapName, instanceID, levelRangeMin, levelRangeMax, teamSize, isRankedArena, suspendedQueue, bool, queueType = GetBattlefieldStatus(index)
    local instanceType = select(2, IsInInstance())
    Gladdy:Debug("INFO", "UPDATE_BATTLEFIELD_STATUS", instanceType, status, teamSize)
    if ((instanceType == "arena" or GetNumArenaOpponents() > 0) and status == "active" and teamSize > 0) then
        self.curBracket = teamSize
        self:JoinedArena()
    end
end

function Gladdy:PLAYER_REGEN_ENABLED()
    if self.showFrame then
        self:UpdateFrame()
        if self.startTest then
            self:Test()
            self.startTest = nil
        end
        self.frame:Show()
        self:SendMessage("JOINED_ARENA")
        self.showFrame = nil
    end
    if self.hideFrame then
        self:Reset()
        self.frame:Hide()
        self.hideFrame = nil
    end
end

---------------------------

-- RESET FUNCTIONS (ARENA LEAVE)

---------------------------

function Gladdy:Reset()
    if type(self.guids) == "table" then
        for k,_ in pairs(self.guids) do
            self.guids[k] = nil
        end
    end
    self.guids = {}
    self.curBracket = nil
    self.curUnit = 1

    for _, module in self:IterModules() do
        self:Call(module, "Reset")
    end

    for unit in pairs(self.buttons) do
        self:ResetUnit(unit)
    end
    if Gladdy.db.hideBlizzard == "never" or Gladdy.db.hideBlizzard == "arena" then
        Gladdy:BlizzArenaSetAlpha(1)
    end
end

function Gladdy:ResetUnit(unit)
    local button = self.buttons[unit]
    if (not button) then
        return
    end

    button:SetAlpha(0)
    self:ResetButton(unit)

    for _, module in self:IterModules() do
        self:Call(module, "ResetUnit", unit)
    end
end

function Gladdy:ResetButton(unit)
    local button = self.buttons[unit]
    if (not button) then
        return
    end
    for k1, v1 in pairs(self.BUTTON_DEFAULTS) do
        if (type(v1) == "string") then
            button[k1] = nil
        elseif (type(v1) == "number") then
            button[k1] = 0
        elseif (type(v1) == "table") then
            button[k1] = {}
        elseif (type(v1) == "boolean") then
            button[k1] = false
        end
    end
end

---------------------------

-- ARENA JOINED

---------------------------

function Gladdy:JoinedArena()
    if not self.curBracket then
        self.curBracket = 2
    end

    for i = 1, self.curBracket do
        if (not self.buttons["arena" .. i]) then
            self:CreateButton(i)
        end
    end

    if InCombatLockdown() then
        Gladdy:Print("Gladdy frames show as soon as you leave combat")
        self.showFrame = true
    else
        self:UpdateFrame()
        self.frame:Show()
        self:SendMessage("JOINED_ARENA")
    end
    for i=1, self.curBracket do
        self.buttons["arena" .. i]:SetAlpha(1)
    end
    if Gladdy.db.hideBlizzard == "arena" or Gladdy.db.hideBlizzard == "always" then
        Gladdy:BlizzArenaSetAlpha(0)
    end
end

---------------------------

-- BLIZZARD FRAMES

---------------------------

function Gladdy:BlizzArenaSetAlpha(alpha)
    if IsAddOnLoaded("Blizzard_ArenaUI") then
        if (ArenaEnemyFrames) then
            ArenaEnemyFrames:SetAlpha(alpha)
        end
        if ArenaEnemyFrame1 then
            ArenaEnemyFrame1:SetAlpha(alpha)
        end
        if ArenaEnemyFrame1PetFrame then
            ArenaEnemyFrame1PetFrame:SetAlpha(alpha)
        end
        if ArenaEnemyFrame2 then
            ArenaEnemyFrame2:SetAlpha(alpha)
        end
        if ArenaEnemyFrame2PetFrame then
            ArenaEnemyFrame2PetFrame:SetAlpha(alpha)
        end
        if ArenaEnemyFrame3 then
            ArenaEnemyFrame3:SetAlpha(alpha)
        end
        if ArenaEnemyFrame3PetFrame then
            ArenaEnemyFrame3PetFrame:SetAlpha(alpha)
        end
        if ArenaEnemyFrame4 then
            ArenaEnemyFrame4:SetAlpha(alpha)
        end
        if ArenaEnemyFrame4PetFrame then
            ArenaEnemyFrame4PetFrame:SetAlpha(alpha)
        end
        if ArenaEnemyFrame5 then
            ArenaEnemyFrame5:SetAlpha(alpha)
        end
        if ArenaEnemyFrame5PetFrame then
            ArenaEnemyFrame5PetFrame:SetAlpha(alpha)
        end
    end
end

---------------------------

-- FONT/STATUSBAR/BORDER

---------------------------

local defaults = {["statusbar"] = "Smooth", ["border"] = "Gladdy Tooltip round", ["font"] = "DorisPP"}

local lastWarning = {}
function Gladdy:SMFetch(lsmType, key)
    local smMediaType = self.LSM:Fetch(lsmType, Gladdy.db[key])
    if (smMediaType == nil and Gladdy.db[key] ~= "None") then
        if not lastWarning[key] or GetTime() - lastWarning[key] > 120 then
            lastWarning[key] = GetTime()
            Gladdy:Warn("Could not find", "\"" .. lsmType .. "\" \"", Gladdy.db[key], " \" for", "\"" .. key .. "\"", "- setting it to", "\"" .. defaults[lsmType] .. "\"")
        end
        return self.LSM:Fetch(lsmType, defaults[lsmType])
    end
    return smMediaType
end