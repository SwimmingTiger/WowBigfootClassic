---@type ns
local ns = select(2, ...)
local L = ns.L

---@class MeetingHornUIApplicant: Frame
---@field private ApplicantList ListView
local Applicant = ns.Addon:NewClass('UI.Applicant', 'Frame')

function Applicant:Constructor()
    self.Header1:SetText(CHARACTER)
    self.Header2:SetText(CLASS)
    self.Header3:SetText(RACE)
    self.Header4:SetText(LEVEL)
    self.Header5:SetText(L['Operation'])
    self.Header1:Disable()
    self.Header2:Disable()
    self.Header3:Disable()
    self.Header4:Disable()
    self.Header5:Disable()

    ns.UI.ListView:Bind(self.ApplicantList)

    self.ApplicantList:SetItemTemplate('MeetingHornApplicantTemplate')
    ---@param item MeetingHornApplicant
    self.ApplicantList:SetCallback('OnItemFormatting', function(_, button, item)
        local state = item:GetState()
        local color
        if state == ns.APPLICANT_STATUS.Declined then
            state = LFG_LIST_APP_DECLINED
            color = RED_FONT_COLOR
        elseif state == ns.APPLICANT_STATUS.Invited then
            state = LFG_LIST_APP_INVITED
            color = GRAY_FONT_COLOR
        elseif state == ns.APPLICANT_STATUS.Joined then
            state = LFG_LIST_APP_INVITE_ACCEPTED
            color = GREEN_FONT_COLOR
        else
            state = nil
        end

        button.Name:SetText(item:GetName())
        button.Class:SetText(item:GetClass())
        button.Race:SetText(item:GetRace())
        button.Name:SetTextColor(GetClassColor(item:GetClassFileName()))
        button.Class:SetTextColor(GetClassColor(item:GetClassFileName()))

        local level = item:GetLevel()
        if level then
            local color = GetQuestDifficultyColor(item:GetLevel())
            button.Level:SetText(item:GetLevel())
            button.Level:SetTextColor(color.r, color.g, color.b)
        else
            button.Level:SetText('-')
            button.Level:SetTextColor(1, 1, 1)
        end

        button.Close:SetShown(not state)
        button.Invite:SetShown(not state)
        button.State:SetShown(state)
        button.State:SetText(state)
        if color then
            button.State:SetTextColor(color:GetRGB())
        end
    end)
    self.ApplicantList:SetCallback('OnItemInviteClick', function(_, _, item)
        ns.LFG:InviteApplicant(item)
    end)
    self.ApplicantList:SetCallback('OnItemCloseClick', function(_, _, item)
        ns.LFG:RemoveApplicant(item)
    end)
    self.ApplicantList:SetCallback('OnItemRightClick', function(_, button, item)
        self:OpenApplicantMenu(item, button)
    end)

    self:RegisterMessage('MEETINGHORN_APPLICANT_UPDATE', 'Update')
    self:RegisterEvent('GROUP_ROSTER_UPDATE', 'Update')
    self:SetScript('OnShow', self.OnShow)
end

function Applicant:OnShow()
    self:Update()
    ns.Addon.DataBroker:StopFlash()
end

function Applicant:Update()
    self.ApplicantList:SetItemList(ns.LFG:GetApplicants())
    self.ApplicantList:Refresh()
end

function Applicant:OpenApplicantMenu(applicant, button)
    ns.GUI:ToggleMenu(button, self:CreateApplicantMenu(applicant), 'cursor')
end

function Applicant:CreateApplicantMenu(applicant)
    return {
        { --
            text = format('|c%s%s|r', select(4, GetClassColor(applicant:GetClassFileName())), applicant:GetName()),
            isTitle = true,
        }, {
            text = WHISPER,
            func = function()
                ChatFrame_SendTell(applicant:GetName())
            end,
        }, {text = CANCEL},
    }
end
