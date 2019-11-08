local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)

local messageGUIDIndexs = {}
local messageFrameGUIDs = {}

MessageClassifier = CreateFrame("Frame")
MessageClassifier.enabled = false

local function StringHash(text)
    local counter = 1;
    local len = string.len(text); 
    for i = 1, len, 3 do 
      counter = mod(counter*8161, 4294967279) +  -- 2^32 - 17: Prime!  (counter*8161 is at most a 48-bit number, which easily fits in the 52-bit mantissa of a double precision float)
          (string.byte(text,i)*16776193) +
          ((string.byte(text,i+1) or (len-i+256))*8372226) +
          ((string.byte(text,i+2) or (len-i+256))*3932164);
    end; 
    return mod(counter, 4294967291); -- 2^32 - 5: Prime (and different from the prime in the loop)
end

function MessageClassifier.chatFilter(frame, event, msg, authorFullName, unknown1, channelTitle, author, unknown2, unknown3, channelID, channelName, unknown5, index, playerGUID, ...)
    local guid = playerGUID..'-'..msg:len()..'-'..StringHash(msg)
    if messageFrameGUIDs[frame] == nil then
        messageFrameGUIDs[frame] = {}
    end

    -- per message
    if messageGUIDIndexs[guid] ~= index then
        local guidInt = StringHash(guid)
        MessageClassifierBrowser:addMessage(msg, authorFullName, author, channelID, channelName, playerGUID, guid, guidInt)
        messageGUIDIndexs[guid] = index
    end

    -- Pass the message sent by the player self.
    if playerGUID == UnitGUID("player") then
        return false
    end

    -- per message per frame
    local msgTime = true
    if MessageClassifierConfig.minDupInterval ~= 0 then
        local t = GetTime()
        msgTime = t - (t % MessageClassifierConfig.minDupInterval)
    end
    if messageFrameGUIDs[frame][guid] == msgTime then
        return true
    end
    if MessageClassifierBrowser.hideFromChatWindow[guid] then
        return true
    end
    
    messageFrameGUIDs[frame][guid] = msgTime
    return false
end

function MessageClassifier.Enable()
    if not MessageClassifier.enabled then
        ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", MessageClassifier.chatFilter)
        --ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", MessageClassifier.chatFilter)
        --ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", MessageClassifier.chatFilter)
        --ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", MessageClassifier.chatFilter)
        print(L["ENABLE_TIPS"])
        MessageClassifier.enabled = true
    end
end

function MessageClassifier.Disable()
    if MessageClassifier.enabled then
        ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", MessageClassifier.chatFilter)
        --ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", MessageClassifier.chatFilter)
        --ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", MessageClassifier.chatFilter)
        --ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", MessageClassifier.chatFilter)
        print(L["DISABLE_TIPS"])
        MessageClassifier.enabled = false
    end
end

function MessageClassifier.Toggle(enabled)
    MessageClassifierConfig.enabled = enabled
    if enabled == false then
        MessageClassifier.Disable()
    else
        MessageClassifier.Enable()
    end
end

function MessageClassifier.Reset()
    messageGUIDIndexs = {}
    messageFrameGUIDs = {}
    print(L["RESET_TIPS"])
end

function MessageClassifier:OnEvent(event, key, state)
    SLASH_MSGDD1 = "/msgdd"
    SlashCmdList["MSGDD"] = function(...)
        MessageClassifier.Toggle(not MessageClassifier.enabled)
    end

    if BLocal and BLocal("ModConfig") and BLocal("ModConfig")['MessageClassifier-tooltip'] ~= 'MessageClassifier-tooltip' then
        L["ENABLE_TIPS"] = L["ENABLE_TIPS_WITH_BIGFOOT"]
    end

    MessageClassifier.Toggle(MessageClassifierConfig.enabled)
    
	MessageClassifier:UnregisterEvent("PLAYER_ENTERING_WORLD")
end

MessageClassifier:RegisterEvent("PLAYER_ENTERING_WORLD")
MessageClassifier:SetScript("OnEvent", MessageClassifier.OnEvent)
