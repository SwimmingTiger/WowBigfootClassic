
---@type ns
local ns = select(2, ...)

local L = ns.L

local DataBroker = ns.Addon:NewClass('UI.DataBroker', 'Button')

local ICON1 = [[|TInterface\AddOns\MeetingHorn\Media\DataBroker:16:16:0:0:64:32:0:32:0:32|t]]
local ICON2 = [[|TInterface\AddOns\MeetingHorn\Media\DataBroker:16:16:0:0:64:32:32:64:0:32|t]]
local TEXT_FORMAT = format('%s %%d   %s %%d', ICON1, ICON2)

function DataBroker:Constructor()
    local LDB = LibStub('LibDataBroker-1.1')
    local BrokerObject = LDB:NewDataObject('MeetingHorn', {
        type = 'data source',
        icon = [[1]],
        OnClick = function()
            return ns.Addon:Toggle()
        end,
        OnEnter = function(owner)
            local anchor = owner:GetBottom() < GetScreenHeight() / 2 and 'ANCHOR_TOP' or 'ANCHOR_BOTTOM'
            GameTooltip:SetOwner(owner, anchor)
            GameTooltip:SetText(L.ADDON_NAME)
            if ns.LFG:GetCurrentActivity() then
                GameTooltip:AddDoubleLine(ICON1 .. L['Applicant Count'], ns.LFG:GetApplicantCount(), 1, 1, 1, 1, 1, 1)
            else
                GameTooltip:AddDoubleLine(ICON1 .. L['Application Count'], ns.LFG:GetApplicationCount(), 1, 1, 1, 1, 1,
                                          1)
            end
            GameTooltip:AddDoubleLine(ICON2 .. L['Activity Count'], ns.LFG:GetActivityCount(), 1, 1, 1, 1, 1, 1)
            GameTooltip:Show()
        end,
        OnLeave = GameTooltip_Hide,
    })

    LibStub('LibWindow-1.1'):Embed(self)
    LibStub('LibDBIcon-1.0'):Register('MeetingHorn', BrokerObject, ns.Addon.db.profile.window.minimap)

    self:RegisterConfig(ns.Addon.db.profile.window.databroker)
    self:MakeDraggable()
    self:RestorePosition()

    LDB.RegisterCallback(self, 'LibDataBroker_AttributeChanged_MeetingHorn', 'OnDataBrokerChanged')

    BrokerObject.text = L.ADDON_NAME
    BrokerObject.icon = [[Interface\AddOns\MeetingHorn\Media\Logo]]

    self.BrokerObject = BrokerObject

    if BrokerObject.OnEnter then
        self:SetScript('OnEnter', BrokerObject.OnEnter)
        self:SetScript('OnLeave', BrokerObject.OnLeave)
    end

    if BrokerObject.OnClick then
        self:SetScript('OnClick', BrokerObject.OnClick)
        self:RegisterForClicks('anyUp')
    end

    self:RegisterMessage('MEETINGHORN_APPLICANT_UPDATE', 'Update')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_UPDATE', 'Update')
    self:RegisterMessage('MEETINGHORN_ACTIVITY_REMOVED', 'Update')
    self:RegisterMessage('MEETINGHORN_NEW_APPLICANT')
    self:RegisterMessage('MEETINGHORN_OPTION_CHANGED_DATABROKER')
end

function DataBroker:MEETINGHORN_OPTION_CHANGED_DATABROKER(_, shown)
    self:SetShown(shown)
end

function DataBroker:MEETINGHORN_NEW_APPLICANT()
    if not ns.Addon.MainPanel or not ns.Addon.MainPanel.Manage:IsVisible() then
        self:StartFlash()
    end
end

function DataBroker:OnDataBrokerChanged(_, name, key, value, object)
    if key == 'text' then
        self.Text:SetText(value)
    elseif key == 'flash' then
        self.Flash:SetShown(value)
    elseif key == 'icon' then
        -- self.Icon:SetTexture(value)
    end
end

function DataBroker:Update()
    local firstCount = ns.LFG:GetCurrentActivity() and ns.LFG:GetApplicantCount() or ns.LFG:GetApplicationCount()
    local secondCount = ns.LFG:GetActivityCount()

    if firstCount == 0 and secondCount == 0 then
        self.BrokerObject.text = L.ADDON_NAME
    else
        self.BrokerObject.text = format(TEXT_FORMAT, firstCount, secondCount)
    end
end

function DataBroker:StartFlash()
    self.BrokerObject.flash = true
end

function DataBroker:StopFlash()
    self.BrokerObject.flash = false
end
