---@class UI
---@field MainPanel MeetingHornUIMainPanel
---@field Browser MeetingHornUIBrowser
---@field Creator MeetingHornUICreator
---@field ActivityItem MeetingHornUIActivityItem
---@field Applicant MeetingHornUIApplicant
---@field ApplicantItem MeetingHornUIApplicantItem
---@field Encounter MeetingHornUIEncounter
---@field Challenge MeetingHornUIChallenge
---@class ns
---@field UI UI
---@field Addon MeetingHorn
---@field Proto MeetingHornProto
---@field LFG MeetingHornLFG
---@field L MeetingHornLocale
---@field Activity MeetingHornActivity
---@field Applicant MeetingHornApplicant
---@field Timer MeetingHornTimer
---@field Channel MeetingHornChannel
---@field ChallengeGroup MeetingHornChallengeGroup
---@field Challenge MeetingHornChallenge
local ns = select(2, ...)

local L = LibStub('AceLocale-3.0'):GetLocale('MeetingHorn', true)

---@class MeetingHorn
---@field private MainPanel MeetingHornUIMainPanel
local Addon = LibStub('AceAddon-3.0'):NewAddon('MeetingHorn', 'LibClass-2.0', 'AceEvent-3.0')
ns.Addon = Addon

ns.L = L
ns.UI = {}
ns.GUI = LibStub('tdGUI-1.0')
ns.Stats = LibStub('LibNeteaseStats-1.0'):New(...)

local L = ns.L
_G.BINDING_NAME_MEETINGHORN_TOGGLE = L['Toggle MeetingHorn']
_G.BINDING_HEADER_MEETINGHORN = L.ADDON_NAME

local function chatFilter(_, _, msg)
    if msg:find(ns.ADDON_TAG) or msg:find('@@$') then
        return true
    end
end

ChatFrame_AddMessageEventFilter('CHAT_MSG_CHANNEL', chatFilter)

function Addon:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('MEETINGHORN_DB', { --
        profile = { --
            cache = { --
                current = {},
                cooldown = {start = 0, duration = 0},
            },
            window = { --
                databroker = {point = 'TOP', x = 0, y = -20},
                minimap = {minimapPos = 192.68},
            },
            options = { --
                databroker = true,
                chatfilter = true,
                activityfilter = true,
            },
            goodleader = {cache = {}},
        },
        global = { --
            activity = { --
                filters = {},
            },
        },
    })

    _G.MEETINGHORN_DB_CHARACTER_MEMBERS = _G.MEETINGHORN_DB_CHARACTER_MEMBERS or {}

    self.MainPanel = ns.UI.MainPanel:Bind(CreateFrame('Button', nil, UIParent, 'MeetingHornMainPanelTemplate'))
    self.DataBroker = ns.UI.DataBroker:Bind(MeetingHornDataBroker)

    self:RegisterMessage('MEETINGHORN_OPTION_CHANGED_CHATFILTER')
    --[[@classic@
    self:RegisterMessage('MEETINGHORN_WORLDBUFF_STATUS_CHANGED')
    self:RegisterEvent('ZONE_CHANGED_NEW_AREA', 'ZoneChanged')
    self:RegisterEvent('PLAYER_ENTERING_WORLD', 'ZoneChanged')
    self:RegisterEvent('GROUP_JOINED', 'ZoneChanged')
    self:RegisterEvent('UNIT_PHASE', 'ZoneChanged')
    --@end-classic@]]

    self:SetupHyperlink()
end

function Addon:OnEnable()
    local keys = {'databroker', 'chatfilter', 'activityfilter'}
    for _, key in ipairs(keys) do
        self:SendMessage('MEETINGHORN_OPTION_CHANGED_' .. key:upper(), self.db.profile.options[key])
    end
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

function Addon:SetupHyperlink()
    local origItemRefTooltipSetHyperlink = ItemRefTooltip.SetHyperlink
    function ItemRefTooltip.SetHyperlink(frame, link, ...)
        local data = link:match('meetinghornencounter:([%d:]+)')
        if data then
            local instanceId, bossId, tab = strsplit(':', data)
            self:OpenEncounter(tonumber(instanceId), tonumber(bossId), tonumber(tab))
        else
            origItemRefTooltipSetHyperlink(frame, link, ...)
        end
    end
end

function Addon:MEETINGHORN_OPTION_CHANGED_CHATFILTER(_, value)
    if value then
        ChatFrame_AddMessageEventFilter('CHAT_MSG_CHANNEL', chatFilter)
    else
        ChatFrame_RemoveMessageEventFilter('CHAT_MSG_CHANNEL', chatFilter)
    end
end

function Addon:Toggle()
    if self.MainPanel:IsShown() then
        HideUIPanel(self.MainPanel)
    else
        ShowUIPanel(self.MainPanel)
    end

    if ns.LFG:GetCurrentActivity() then
        self.MainPanel:SetTab(self.MainPanel.Manage)
    end
end

function Addon:OpenEncounter(...)
    if not self.MainPanel:IsShown() then
        ShowUIPanel(self.MainPanel)
    end

    self.MainPanel:SetTab(self.MainPanel.Encounter)
    self.MainPanel.Encounter:Open(...)
end

--[[@classic@
function Addon:MEETINGHORN_WORLDBUFF_STATUS_CHANGED(_, enable)
    ns.WorldBuff:SetStatus(enable)
end

function Addon:ZoneChanged(ev)
    ns.WorldBuff:CheckEnable()
end
--@end-classic@]]
