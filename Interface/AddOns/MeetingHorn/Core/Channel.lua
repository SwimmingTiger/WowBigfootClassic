
---@type ns
local ns = select(2, ...)

---@class MeetingHornChannel
local Channel = ns.Addon:NewModule('Channel', 'AceEvent-3.0')

function Channel:OnEnable()
    self.joiningIndexs = {}
    self.joining = {}
    self.joined = {}
    self.renames = {}

    self:RegisterEvent('CHAT_MSG_CHANNEL_NOTICE_USER')
    self:RegisterEvent('CHAT_MSG_CHANNEL_NOTICE')

    self:RegisterEvent('CHANNEL_UI_UPDATE', 'RestoreAll')
    self:RestoreAll()
end

function Channel:CHAT_MSG_CHANNEL_NOTICE_USER(_, msg, _, _, _, _, _, _, _, realChannelName)
    if msg == 'INVALID_NAME' then
        local channelName, index = self:MatchJoiningChannel(realChannelName)
        if channelName then
            if self.joiningIndexs[channelName] == index then
                self:Join(channelName)
            end
        end
    end
end

function Channel:CHAT_MSG_CHANNEL_NOTICE(_, msg, _, _, _, _, _, _, _, realChannelName)
    if msg == 'YOU_CHANGED' then
        local channelName, index = self:MatchJoiningChannel(realChannelName)
        if channelName then
            self.joiningIndexs[channelName] = nil
            self.joining[channelName] = nil
            self:BindChannel(channelName, realChannelName)
        end
    elseif msg == 'YOU_LEFT' then
        local channelName = self:GetUsChannelName(realChannelName)
        if channelName then
            self:UnbindChannel(channelName)
        end
    end
end

function Channel:MatchJoiningChannel(realChannelName)
    for k, v in pairs(self.joiningIndexs) do
        if k == realChannelName then
            return k, v
        elseif (k .. v) == realChannelName then
            return k, v
        end
    end
end

function Channel:BindChannel(channelName, realChannelName)
    self.joined[channelName] = realChannelName
    self.renames[realChannelName] = channelName
end

function Channel:UnbindChannel(channelName)
    local realChannelName = self.joined[channelName]
    if realChannelName then
        self.joined[channelName] = nil
        self.renames[realChannelName] = nil
    end
end

function Channel:RestoreAll(event)
    for channelName in pairs(ns.GetOurChannels()) do
        self:RestoreChannel(channelName)
    end
    if event then
        self:UnregisterEvent(event)
    end
end

function Channel:RestoreChannel(channelName)
    local id = GetChannelName(channelName)
    if id and id > 0 then
        self:BindChannel(channelName, channelName)
        return true
    end

    local channels = {GetChannelList()}
    for i = 1, #channels, 3 do
        local id = channels[i]
        local name = channels[i + 1]
        local prefix, index = name:match('^(.+)(%d+)$')
        if prefix == channelName then
            self:BindChannel(channelName, name)
            return true
        end
    end
end

function Channel:Join(channelName)
    if self.joined[channelName] then
        return
    end
    if self:RestoreChannel(channelName) then
        return
    end

    if self.joining[channelName] then
        return
    end

    local index = self.joiningIndexs[channelName] or -1
    index = index + 1
    self.joiningIndexs[channelName] = index

    local joinName = channelName
    if index > 0 then
        joinName = joinName .. index
    end

    self.joining[joinName] = true
    JoinTemporaryChannel(joinName)
end

function Channel:Leave(channelName)
    local realChannelName = self.joined[channelName]
    if realChannelName then
        LeaveChannelByName(realChannelName)
        self:UnbindChannel(channelName)
    end
end

function Channel:GetRealChannelName(channelName)
    return self.joined[channelName]
end

function Channel:GetUsChannelName(realChannelName)
    return self.renames[realChannelName]
end

function Channel:GetSendChannelId(channelName)
    channelName = self.joined[channelName]
    if not channelName then
        return
    end
    local id = GetChannelName(channelName)
    if not id or id == 0 then
        return
    end
    return id
end
