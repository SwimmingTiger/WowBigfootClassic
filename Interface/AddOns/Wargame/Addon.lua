---@type ns
local ADDON_NAME, ns = ...

local L = LibStub('AceLocale-3.0'):GetLocale('NeteaseWargame', true)

---@type Addon
local Addon = LibStub('AceAddon-3.0'):NewAddon('NeteaseWargame', 'LibClass-2.0')
ns.Addon = Addon

ns.L = L
ns.UI = {}
ns.GUI = LibStub('tdGUI-1.0')
ns.ADDON_VERSION = GetAddOnMetadata(ADDON_NAME, 'Version')

--[===[@debug@
_G.nw = Addon
--@end-debug@]===]

function Addon:OnInitialize()
    self.db = LibStub('AceDB-3.0'):New('NETEASE_WARGAME_DB', { --
        profile = { --
            window = { --
                minimap = {minimapPos = 210.68},
            },
        },
    })

    self:SetupCharacterDB()

    self.MainPanel = ns.UI.MainPanel:Bind(NeteaseWargameMainPanel)
    self:SetupDataBroker()
end

function Addon:OnEnable()
    local origItemRefTooltipSetHyperlink = ItemRefTooltip.SetHyperlink
    function ItemRefTooltip.SetHyperlink(frame, link, ...)
        local gameId = link:match('wargame:(%d+)')
        if gameId then
            self:OpenMainPanel()
        else
            origItemRefTooltipSetHyperlink(frame, link, ...)
        end
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

function Addon:SetupCharacterDB()
    local db = _G.NETEASE_WARGAME_DB_CHARACTER
    db = db or {}
    _G.NETEASE_WARGAME_DB_CHARACTER = db

    db.recents = db.recents or {}

    self.C = db
end

function Addon:Toggle()
    if self.MainPanel:IsShown() then
        self:CloseMainPanel()
    else
        self:OpenMainPanel()
    end
end

function Addon:OpenMainPanel()
    if ns.Wargame.isSupport then
        ShowUIPanel(self.MainPanel)
        ns.Wargame:RefreshGuild()
    else
        ns.CopyBox(format(
                       L['您的战争游戏插件已过期，最新版本为%s，请复制以下网址前往更新或者直接更新您的整合插件'],
                       ns.Wargame.version), 'https://esports.blizzard.cn/wow/rank')
    end
end

function Addon:CloseMainPanel()
    return HideUIPanel(self.MainPanel)
end

function Addon:ShowLoading(text, spinner)
    local Loading = self.MainPanel.Loading
    if text then
        Loading:SetText(text, spinner)
        Loading:Show()
    else
        Loading:Hide()
    end
end

function Addon:SetupDataBroker()
    local LDB = LibStub('LibDataBroker-1.1')
    local BrokerObject = LDB:NewDataObject('NeteaseWargame', {
        type = 'data source',
        icon = [[Interface\AddOns\Wargame\Media\Logo]],
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

    LibStub('LibDBIcon-1.0'):Register('NeteaseWargame', BrokerObject, self.db.profile.window.minimap)
end

function Addon:OpenBlocker(data)
    self.MainPanel.BlockDialog:Open(data)
    self.MainPanel.BlockDialog.EditBox:Disable()
end
