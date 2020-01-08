
---@type ns
local ns = select(2, ...)
local L = ns.L

---@class MeetingHornUICreator: Frame
---@field Activity Button
---@field Mode Button
---@field CreateButton CountdownButton
---@field CloseButton Button
---@field Comment Frame
---@field ActivityLabel FontString
---@field ModeLabel FontString
---@field CommentLabel FontString
---@field TitleLabel FontString
local Creator = ns.Addon:NewClass('UI.Creator', 'Frame')

function Creator:Constructor()
    ns.GUI:GetClass('Dropdown'):Bind(self.Activity)
    ns.GUI:GetClass('Dropdown'):Bind(self.Mode)
    ns.GUI:GetClass('EditBox'):Bind(self.Comment, true)
    ns.UI.CountdownButton:Bind(self.CreateButton)

    local function UpdateControls()
        return self:UpdateControls()
    end

    self.ActivityLabel:SetText(L['Activity'])
    self.ModeLabel:SetText(L['Activity Mode'])
    self.CommentLabel:SetText(L['Activity Comment'])
    self.TitleLabel:SetText(L['Manage Activity'])

    self.Comment:SetMaxBytes(128)

    self.Activity:SetMenuTable(ns.ACTIVITY_MENU)
    self.Activity:SetDefaultText(L['Choice Activity...'])
    self.Activity:SetCallback('OnSelectChanged', UpdateControls)
    self.Activity:SetMaxItem(20)

    self.Mode:SetMenuTable(ns.MODE_MENU)
    self.Mode:SetDefaultText(L['Choice Mode...'])
    self.Mode:SetCallback('OnSelectChanged', UpdateControls)
    self.Mode:SetMaxItem(20)

    self.CreateButton:SetText(L['Create Activity'])
    self.CreateButton:SetScript('OnClick', function()
        return self:OnCreateClick()
    end)

    self.CloseButton:SetText(L['Close Activity'])
    self.CloseButton:SetScript('OnClick', function()
        return self:OnCloseClick()
    end)

    self:RegisterMessage('MEETINGHORN_CURRENT_CREATED', 'Update')
    self:RegisterMessage('MEETINGHORN_CURRENT_CLOSED')
    self:RegisterEvent('GROUP_ROSTER_UPDATE', 'Update')
    self:RegisterMessage('MEETINGHORN_CITY_CHANGED', 'Update')
    self:SetScript('OnShow', self.Update)
end

function Creator:OnShow()
    RequestRaidInfo()
    self:Update()
end

function Creator:OnCreateClick()
    self.Comment:ClearFocus()

    local hasActivity = ns.LFG:GetCurrentActivity()
    local activityId = self.Activity:GetValue()
    local modeId = self.Mode:GetValue()
    local comment = self.Comment:GetText():gsub('%s+', ' ')
    local instanceName = ns.GetActivityData(activityId).instanceName
    if instanceName then
        local raidId = ns.GetRaidId(instanceName)
        if raidId ~= -1 then
            if not StaticPopupDialogs['MEETINGHORN_INSTANCE_EXISTS'] then
                StaticPopupDialogs['MEETINGHORN_INSTANCE_EXISTS'] =
                    {
                        text = L['|cff00ffff%s|r instance already exists, continue to create?'],
                        button1 = YES,
                        button2 = NO,
                        OnAccept = function(_, data)
                            self.CreateButton:SetCountdown(10)
                            ns.LFG:CreateActivity(ns.Activity:New(data.activityId, data.modeId, data.comment))
                            ns.Message(hasActivity and L['Update activity success.'] or L['Create acitivty success.'])
                        end,
                        hideOnEscape = 1,
                        timeout = 0,
                        exclusive = 1,
                        whileDead = 1,
                    }
            end
            StaticPopup_Show('MEETINGHORN_INSTANCE_EXISTS', instanceName, nil,
                             {activityId = activityId, modeId = modeId, comment = comment})
            return
        end
    end

    self.CreateButton:SetCountdown(10)
    ns.LFG:CreateActivity(ns.Activity:New(activityId, modeId, comment), true)
    ns.Message(hasActivity and L['Update activity success.'] or L['Create acitivty success.'])
end

function Creator:OnCloseClick()
    ns.LFG:CloseActivity()
    ns.Message(L['Activity closed.'])
end

function Creator:MEETINGHORN_CURRENT_CLOSED()
    self.Activity:SetValue(nil)
    self.Mode:SetValue(nil)
    self.Comment:SetText('')
    self:Update()
end

function Creator:Update()
    local activity = ns.LFG:GetCurrentActivity()
    if activity then
        self.CloseButton:Enable()
        self.CreateButton:Enable()
        self.CreateButton:SetText(L['Update Activity'])
        self.Activity:SetValue(activity:GetActivityId())
        self.Mode:SetValue(activity:GetModeId())
        self.Comment:SetText(activity:GetComment())
    else
        self.CloseButton:Disable()
        self.CreateButton:SetText(L['Create Activity'])
        self:UpdateControls()
    end
end

function Creator:UpdateControls()
    local activityId = self.Activity:GetValue()
    local activityData = ns.GetActivityData(activityId)
    self.CreateButton:SetEnabled(ns.IsGroupLeader() and activityId and self.Mode:GetValue() and
                                     (not activityData.category.inCity or ns.LFG:IsInCity()))
end
