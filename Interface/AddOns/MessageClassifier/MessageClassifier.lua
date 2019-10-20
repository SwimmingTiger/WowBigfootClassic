local L = BLocal("ModConfig")

if GetLocale()=='zhCN' then
	L["ENABLE_TIPS"] = "公共频道/世界频道消息去重：已启用，可在小地图大脚按键包中关闭"
	L["DISABLE_TIPS"] = "公共频道/世界频道消息去重：已停用"

elseif GetLocale()=='zhTW' then
	L["ENABLE_TIPS"] = "公共頻道/世界頻道消息去重：已啓用，可在小地圖大腳按鍵包中關閉"
	L["DISABLE_TIPS"] = "公共頻道/世界頻道消息去重：已停用"

else
	L["ENABLE_TIPS"] ="Public channel/World channel message deduplication: Enabled"
	L["DISABLE_TIPS"] ="Public channel/World channel message deduplication: Disabled"
end


MessageClassifierConfig = {}

local messageGUIDIndexs = {}
local messageFrameGUIDs = {}

MessageClassifier = {}
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

function MessageClassifier.chatFilter(frame, event, msg, authorWithServer, unknown1, channelTitle, author, unknown2, unknown3, unknown4, channelName, unknown5, index, playerGUID, ...)
    local guid = playerGUID..'-'..StringHash(msg)
    if messageFrameGUIDs[frame] == nil then
        messageFrameGUIDs[frame] = {}
    end

    -- per message
    -- TODO: finish it
    --[[if messageGUIDIndexs[guid] ~= index then
        MessageClassifier.addMessage(frame, event, msg, authorWithServer, unknown1, channelTitle, author, unknown2, unknown3, unknown4, channelName, unknown5, index, guid, ...)
        messageGUIDIndexs[guid] = index
    end]]

    -- per message per frame
    if messageFrameGUIDs[frame][guid] then
        return true
    end
    
    messageFrameGUIDs[frame][guid] = true
    return false
end

function MessageClassifier.addMessage(frame, event, msg, authorWithServer, unknown1, channelTitle, author, unknown2, unknown3, unknown4, channelName, unknown5, index, guid, ...)
    local realmPrefix = '-'..GetRealmName()
    if authorWithServer:sub(-realmPrefix:len(), -1) == realmPrefix then
        -- Same as the player's realm, remove the suffix
        authorWithServer = authorWithServer:sub(1, -realmPrefix:len() - 1)
    end
    --print(guid, index, authorWithServer, msg, frame, event)
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
