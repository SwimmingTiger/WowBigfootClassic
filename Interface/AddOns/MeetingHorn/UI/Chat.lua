---@type ns
local ns = select(2, ...)
local L = ns.L

local Chat = ns.Addon:NewClass('UI.Chat', 'Frame')

function Chat:Constructor()
    self.ChatFrame:SetFading(false)
    self.ChatFrame:SetMaxLines(2048)
    self.ChatFrame:SetFontObject(ChatFontNormal)
    self.ChatFrame:SetIndentedWordWrap(true)
    self.ChatFrame:SetJustifyH('LEFT')
    self.ChatFrame:SetHyperlinksEnabled(true)
    self.ChatFrame:SetID(1)

    self.TitleLabel:SetText(L['Chat Record'])

    local AddMessage = self.ChatFrame.AddMessage
    self.ChatFrame.AddMessage = function(self, msg, ...)
        AddMessage(self, msg:gsub(':WHISPER:', ':UNKNOWN:'), ...)

        local numMessages = self:GetNumMessages()
        self.scrollBar:SetMinMaxValues(1, numMessages)
        self.scrollBar:SetValue(numMessages - self:GetScrollOffset())
    end

    self.ChatFrame:SetScript('OnHyperlinkClick', function(_, ...)
        self:OnHyperlinkClick(...)
    end)

    -- self.EditBox:Show()

    self:RegisterMessage('MEETINGHORN_CURRENT_CREATED')
    self:RegisterMessage('MEETINGHORN_CURRENT_CLOSED')
end

function Chat:MEETINGHORN_CURRENT_CREATED()
    self:RegisterEvent('CHAT_MSG_WHISPER', 'OnEvent')
    self:RegisterEvent('CHAT_MSG_WHISPER_INFORM', 'OnEvent')
end

function Chat:MEETINGHORN_CURRENT_CLOSED()
    self.ChatFrame:Clear()
    self:UnregisterAllEvents()
end

function Chat:OnEvent(...)
    ChatFrame_MessageEventHandler(self.ChatFrame, ...)
end

function Chat:OnHyperlinkClick(link, text, button)
    print(link, text, button)
    SetItemRef(link, text, button, self.ChatFrame)
end
