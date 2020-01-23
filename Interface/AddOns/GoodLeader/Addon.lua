---@class ns
local ns = select(2, ...)

ns.UI = {}
ns.L = LibStub('AceLocale-3.0'):GetLocale(...)

local L = ns.L

---@class GoodLeaderUserCache
---@field activeness number
---@field itemWeight number
---@field itemPercent number
---@field code number
---@field msg string
---@field guild string
---@field guildCount number
---@field raids table<number, number>

---@class GoodLeaderAddon
---@field userCache table<string, GoodLeaderUserCache>
local Addon = LibStub('AceAddon-3.0'):NewAddon('GoodLeader', 'AceEvent-3.0', 'LibClass-2.0', 'LibCommSocket-3.0')
ns.Addon = Addon

function Addon:OnInitialize()
    self.userCache = {}

    self:ListenSocket('GOODLEADER')
    self:ConnectServer('S1' .. UnitFactionGroup('player'))
    self:RegisterServer('SERVER_CONNECTED')
    self:RegisterServer('SGL')

    self:RegisterEvent('GROUP_ROSTER_UPDATE')
end

function Addon:OnEnable()
    self.MainPanel = ns.UI.MainPanel:New(UIParent)
    self.db = LibStub('AceDB-3.0'):New('GOODLEADER_DB', { --
        profile = { --
            window = { --
                minimap = {minimapPos = 190},
            },
        },
    })
    self:SetupDataBroker()
end

function Addon:SetupDataBroker()
    local LDB = LibStub('LibDataBroker-1.1')
    local BrokerObject = LDB:NewDataObject('GoodLeader', {
        type = 'data source',
        icon = [[Interface\AddOns\GoodLeader\Media\Logo]],
        OnClick = function()
            return self:Toggle()
        end,
        OnEnter = function(owner)
            local anchor = owner:GetBottom() < GetScreenHeight() / 2 and 'ANCHOR_TOP' or 'ANCHOR_BOTTOM'
            GameTooltip:SetOwner(owner, anchor)
            GameTooltip:SetText(L.ADDON_NAME)
            GameTooltip:Show()
        end,
        OnLeave = GameTooltip_Hide,
    })

    LibStub('LibDBIcon-1.0'):Register('GoodLeader', BrokerObject, self.db.profile.window.minimap)
end

function Addon:OnModuleCreated(module)
    ns[module:GetName()] = module
end

function Addon:OnClassCreated(class, name)
    local uiName = name:match('^UI%.(.+)$')
    if uiName then
        LibStub('AceEvent-3.0'):Embed(class)
        ns.UI[uiName] = class
    else
        ns[name] = class
    end
end

function Addon:SERVER_CONNECTED()
    self:SendServer('SLOGIN', ns.ADDON_VERSION, UnitGUID('player'), ns.GetPlayerItemLevel(), UnitLevel('player'))
    self:SendMessage('GOODLEADER_LOGIN')
end

function Addon:SGL(_, name, code, msg, activeness, itemPercent, raidData)
    local user = self:GetUserCache(name)

    if code ~= 0 then
        user.code = code
        user.msg = msg
    else
        local raids = {}

        for i, v in ipairs(raidData) do
            raids[v[1]] = v[2]
        end

        user.activeness = activeness
        user.itemPercent = itemPercent
        user.raids = raids
    end
    self:GROUP_ROSTER_UPDATE()
    self:SendMessage('GOODLEADER_LEADERINFO_UPDATE')
end

function Addon:LookupLeader()
    local name, guid = ns.GetGroupLeader()
    if not name then
        return
    end
    wipe(self.userCache)
    self:SendServer('SGL', name, guid)
end

function Addon:GetUserCache(name)
    self.userCache[name] = self.userCache[name] or {}
    return self.userCache[name]
end

function Addon:GROUP_ROSTER_UPDATE()
    local name, guid = ns.GetGroupLeader()
    local guild = GetGuildInfo(name)
    local count = 0

    if guild then
        for unit in ns.IterateGroupUnits() do
            if guild == GetGuildInfo(unit) then
                count = count + 1
            end
        end
    end

    local user = self:GetUserCache(name)
    user.guild = guild
    user.guildCount = count
end

function Addon:Toggle()
    if self.MainPanel:IsShown() then
        HideUIPanel(self.MainPanel)
    else
        ShowUIPanel(self.MainPanel)
    end
end
