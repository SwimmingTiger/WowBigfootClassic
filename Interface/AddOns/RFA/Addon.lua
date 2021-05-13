-- Addon.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 2/1/2021, 3:09:35 PM
--
local lineId2Guid = {}

local function GetInfo(rawName, playerLocation)
    if not playerLocation or not playerLocation:IsValid() then
        return
    end

    local name, class, race
    if playerLocation:IsUnit() then
        name = UnitName(unit)
        class = UnitClass(unit)
        race = UnitRace(unit)
    else
        local guid
        if playerLocation:IsGUID() then
            guid = playerLocation:GetGUID()
        elseif playerLocation:IsChatLineID() then
            local lineId = tonumber(playerLocation:GetChatLineID())
            guid = lineId and lineId2Guid[lineId]
        end

        if guid then
            local _
            class, _, race, _, _, name = GetPlayerInfoByGUID(guid)
        end
    end
    return rawName or name, class, race
end

local function SetText(editBox, text)
    editBox:SetText(text)
    editBox._rfaText = text
end

local function UpdateEditBox(editBox, name, playerLocation)
    local name, class, race = GetInfo(name, playerLocation)
    if not name then
        SetText(editBox, '')
    elseif class and race then
        SetText(editBox, format('被举报人：%s-%s-%s\n内容描述：', name, race, class))
    else
        SetText(editBox, format('被举报人：%s\n内容描述：', name))
    end
end

local function OnTextChanged(editBox)
    if not editBox._rfaText or not editBox._rfaButton then
        return
    end

    local text = editBox:GetText()
    editBox._rfaButton:SetEnabled(text ~= '' and text ~= editBox._rfaText)
end

ReportCheatingDialog.CommentFrame.EditBox:HookScript('OnTextChanged', OnTextChanged)
ReportCheatingDialog.CommentFrame.EditBox._rfaButton = ReportCheatingDialog.reportButton

PlayerReportFrame.CommentBox:HookScript('OnTextChanged', OnTextChanged)
PlayerReportFrame.CommentBox._rfaButton = PlayerReportFrame.ReportButton

hooksecurefunc(PlayerReportFrame, 'InitiateReport', function(frame, type, name, playerLocation)
    UpdateEditBox(frame.CommentBox, name, playerLocation)
end)

hooksecurefunc('HelpFrame_ShowReportCheatingDialog', function(playerLocation)
    UpdateEditBox(ReportCheatingDialog.CommentFrame.EditBox, nil, playerLocation)
    ReportCheatingDialog.CommentFrame.EditBox.InformationText:Hide()
end)

local f = CreateFrame('Frame')
f:SetScript('OnEvent', function(self, event, _, _, _, _, _, _, _, _, _, _, lineId, guid)
    lineId2Guid[lineId] = guid
end)
f:RegisterEvent('CHAT_MSG_AFK')
f:RegisterEvent('CHAT_MSG_CHANNEL')
f:RegisterEvent('CHAT_MSG_DND')
f:RegisterEvent('CHAT_MSG_EMOTE')
f:RegisterEvent('CHAT_MSG_GUILD')
f:RegisterEvent('CHAT_MSG_INSTANCE_CHAT')
f:RegisterEvent('CHAT_MSG_INSTANCE_CHAT_LEADER')
f:RegisterEvent('CHAT_MSG_OFFICER')
f:RegisterEvent('CHAT_MSG_PARTY')
f:RegisterEvent('CHAT_MSG_PARTY_LEADER')
f:RegisterEvent('CHAT_MSG_RAID')
f:RegisterEvent('CHAT_MSG_RAID_LEADER')
f:RegisterEvent('CHAT_MSG_RAID_WARNING')
f:RegisterEvent('CHAT_MSG_SAY')
f:RegisterEvent('CHAT_MSG_WHISPER')
f:RegisterEvent('CHAT_MSG_YELL')

-- PTR 没有举报页面
if not HelpFrame.report then
    return
end

local URL = 'https://www.battlenet.com.cn/support/zh/help/contact/1210/ticket'

local EditBox = CreateFrame('EditBox', nil, HelpFrame.report)
EditBox:SetPoint('BOTTOM', 0, 50)
EditBox:SetSize(430, 32)
EditBox:SetFontObject('ChatFontNormal')
EditBox:SetAutoFocus(false)
EditBox:SetText(URL)
EditBox:SetScript('OnEscapePressed', EditBox.ClearFocus)
EditBox:SetScript('OnEditFocusGained', function(EditBox)
    EditBox:SetCursorPosition(0)
    EditBox:HighlightText()
end)
EditBox:SetScript('OnEditFocusLost', function(EditBox)
    EditBox:SetCursorPosition(0)
    EditBox:HighlightText(0, 0)
end)
EditBox:SetScript('OnTextChanged', function(EditBox)
    EditBox:SetText(URL)
    EditBox:SetCursorPosition(0)
    EditBox:HighlightText()
end)
EditBox:SetScript('OnShow', EditBox:GetScript('OnEditFocusLost'))

local Left = EditBox:CreateTexture(nil, 'BACKGROUND')
Left:SetPoint('LEFT', -10, 0)
Left:SetSize(32, 32)
Left:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Left2]])

local Right = EditBox:CreateTexture(nil, 'BACKGROUND')
Right:SetPoint('RIGHT', 10, 0)
Right:SetSize(32, 32)
Right:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Right2]])

local Mid = EditBox:CreateTexture(nil, 'BACKGROUND')
Mid:SetPoint('TOPLEFT', Left, 'TOPRIGHT')
Mid:SetPoint('BOTTOMRIGHT', Right, 'BOTTOMLEFT')
Mid:SetTexture([[Interface\ChatFrame\UI-ChatInputBorder-Mid2]])

local Icon = EditBox:CreateTexture(nil, 'ARTWORK')
Icon:SetSize(56, 56)
Icon:SetPoint('BOTTOMLEFT', EditBox, 'TOPLEFT', -10, 4)
Icon:SetTexture([[Interface\HelpFrame\helpicon-openticket]])

local Title = EditBox:CreateFontString(nil, 'ARTWORK', 'GameFontNormalLarge')
Title:SetPoint('TOPLEFT', Icon, 'TOPRIGHT', 5, -10)
Title:SetText('填写表单')

local SubTitle = EditBox:CreateFontString(nil, 'ARTWORK', 'GameFontHighlight')
SubTitle:SetPoint('TOPLEFT', Title, 'BOTTOMLEFT', 0, -3)
SubTitle:SetText([[复制下面网址到浏览器里，填写举报表单]])
