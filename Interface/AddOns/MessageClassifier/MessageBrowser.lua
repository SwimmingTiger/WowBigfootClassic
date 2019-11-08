local ADDON_NAME = ...
local L = LibStub("AceLocale-3.0"):GetLocale(ADDON_NAME)
local AceGUI = LibStub("AceGUI-3.0")

MessageClassifierBrowser = AceGUI:Create("Frame")
MessageClassifierBrowser.messages = {}
MessageClassifierBrowser.messageTree = {}
MessageClassifierBrowser.messageTreeIndex = {}
MessageClassifierBrowser.messageViewIndex = {}
MessageClassifierBrowser.allMessages = 0
MessageClassifierBrowser.uniqueMessages = 0
MessageClassifierBrowser.duplicateMessages = 0
MessageClassifierBrowser.sortViewQueue = {}
MessageClassifierBrowser.msgViewContent = {}
MessageClassifierBrowser.hideFromChatWindow = {}
MessageClassifierBrowser.baseTime = time() - GetTime()
MessageClassifierBrowser.updateInterval = 1
MessageClassifierBrowser.pauseUpdate = false
MessageClassifierBrowser.searchText = ""

local function deepCompare(t1,t2,ignore_mt)
    local ty1 = type(t1)
    local ty2 = type(t2)
    if ty1 ~= ty2 then return false end
    -- non-table types can be directly compared
    if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
    -- as well as tables which have the metamethod __eq
    local mt = getmetatable(t1)
    if not ignore_mt and mt and mt.__eq then return t1 == t2 end
    for k1,v1 in pairs(t1) do
      local v2 = t2[k1]
      if v2 == nil or not deepcompare(v1,v2) then return false end
    end
    for k2,v2 in pairs(t2) do
      local v1 = t1[k2]
      if v1 == nil or not deepcompare(v1,v2) then return false end
    end
    return true
end

local function tableLen(table)
    local count = 0
    for _ in pairs(table) do count = count + 1 end
    return count
end

local function split(str, d)
	local lst = { }
	local n = string.len(str)
	local start = 1
	while start <= n do
		local i = string.find(str, d, start)
		if i == nil then 
			table.insert(lst, string.sub(str, start, n))
			break 
		end
		table.insert(lst, string.sub(str, start, i-1))
		if i == n then
			table.insert(lst, "")
			break
		end
		start = i + 1
	end
	return lst
end

local function urlEncode(s)
    s = string.gsub(s, "([^%w%.%- ])", function(c) return string.format("%%%02X", string.byte(c)) end)
    s = string.gsub(s, " ", "+")
    return s
end

local function urlDecode(s)
   s = string.gsub(s, '%%(%x%x)', function(h) return string.char(tonumber(h, 16)) end)
   return s
end

local function dirname(str)
	if str:match("/") then
		local name = string.gsub(str, "^(.*)/([^/]*)$", "%1")
		return name
	else
		return ''
	end
end

local function getColoredName(playerName, playerGUID)
	local localizedClass, englishClass, localizedRace, englishRace, sex = GetPlayerInfoByGUID(playerGUID)
	if (englishClass) then
		local classColorTable = RAID_CLASS_COLORS[englishClass];
		if (not classColorTable) then
			return playerName;
		end
		return string.format("|cff%.2x%.2x%.2x%s|r", classColorTable.r*255, classColorTable.g*255, classColorTable.b*255, playerName)
    end
    return playerName
end

local function getColoredCount(count)
    local color
    if count < 5 then
        color = "00cd00"
    elseif count < 10 then
        color = "e68e32"
    else
        color = "ff3030"
    end
	return string.format("|cff%s(%sx)|r ", color, count)
end

local CHANNEL_NAME_REPLACE = {
    [L["CHAN_FULLNAME_GUILD"]] = L["CHAN_SHORTNAME_GUILD"],
    [L["CHAN_FULLNAME_RAID"]] = L["CHAN_SHORTNAME_RAID"],
    [L["CHAN_FULLNAME_PARTY"]] = L["CHAN_SHORTNAME_PARTY"],
    [L["CHAN_FULLNAME_YELL"]] = L["CHAN_SHORTNAME_YELL"],
    [L["CHAN_FULLNAME_BATTLEGROUND"]] = L["CHAN_SHORTNAME_BATTLEGROUND"],
    [L["CHAN_FULLNAME_GENERAL"]] = L["CHAN_SHORTNAME_GENERAL"],
    [L["CHAN_FULLNAME_TRADE"]] = L["CHAN_SHORTNAME_TRADE"],
    [L["CHAN_FULLNAME_WORLDDEFENSE"]] = L["CHAN_SHORTNAME_WORLDDEFENSE"],
    [L["CHAN_FULLNAME_LOCALDEFENSE"]] = L["CHAN_SHORTNAME_LOCALDEFENSE"],
    [L["CHAN_FULLNAME_LFGCHANNEL"]] = L["CHAN_SHORTNAME_LFGCHANNEL"],
    [L["CHAN_FULLNAME_BIGFOOTCHANNEL"]] = L["CHAN_SHORTNAME_BIGFOOT"],
    [L["CHAN_FULLNAME_WHISPERTO"]] = L["CHAN_SHORTNAME_WHISPERTO"],
    [L["CHAN_FULLNAME_WHISPERFROM"]] = L["CHAN_SHORTNAME_WHISPERFROM"]
}

local function shortChannelName(channel)
    if CHANNEL_NAME_REPLACE[channel] then
        return CHANNEL_NAME_REPLACE[channel]
    end
    for k,v in pairs(CHANNEL_NAME_REPLACE) do
        channel = channel:gsub(k, v)
    end
    return channel
end

local function formatMsg(msg)
    local text = string.format("|cffffa900%s|r |Hchannel:channel:%d|h[%s]|h [|Hplayer:%s:-1|h%s|h] %s", date("%H:%M:%S", msg.updateTime), msg.channelID, shortChannelName(msg.channel), msg.authorFullName, msg.author, msg.content)
    if msg.count > 1 then
        text = getColoredCount(msg.count)..text
    end
    return text
end

local function formatMsgAsTitle(msg, path)
    local text = msg.content
    if not path:find(msg.author) then
        text = string.format("|cffffc0c0[|r%s|cffffc0c0]|r %s", msg.author, text)
    end
    if msg.count > 1 then
        text = getColoredCount(msg.count)..text
    end
    return text
end

local function msgComp(a, b)
    return a.order > b.order
end

local lastSortTime = GetTime()
local function sortAndRefreshViews()
    local now = GetTime()
    if now - lastSortTime < MessageClassifierBrowser.updateInterval then return end
    lastSortTime = now

    -- Prevent stuttering when the user clicks on a node of the tree
    if MessageClassifierBrowser.pauseUpdate then
        MessageClassifierBrowser.pauseUpdate = false
    end

    if tableLen(MessageClassifierBrowser.sortViewQueue) > 0 then
        for _,v in pairs(MessageClassifierBrowser.sortViewQueue) do
            table.sort(v, msgComp)
            if v == MessageClassifierBrowser.msgViewContent.children then
                MessageClassifierBrowser:updateMsgView()
            end
        end
        MessageClassifierBrowser.sortViewQueue = {}
        MessageClassifierBrowser.msgTreeView:RefreshTree()
    end
    MessageClassifierBrowser:updateStatusBar()
end
local updateFrame = CreateFrame("Frame")
updateFrame:SetScript("OnUpdate", sortAndRefreshViews)

function MessageClassifierBrowser:sortMessageView(view)
    if view and view.parent then
        view.parent.order = view.order
        if view.parent.children then
            self.sortViewQueue[view.parent.children] = view.parent.children
            self:sortMessageView(view.parent)
        end
    end
end

function MessageClassifierBrowser:addMessage(content, authorFullName, author, channelID, channelName, authorGUID, guid, guidInt)
    self.allMessages = self.allMessages + 1
    if not self.messages[guid] then
        local realmPrefix = '-'..GetRealmName()
        -- Same as the player's realm, remove the suffix.
        -- We need this on Wow retail.
        if author:sub(-realmPrefix:len(), -1) == realmPrefix then
            author = author:sub(1, -realmPrefix:len() - 1)
        end
        -- Same as the player's realm, remove the suffix.
        if authorFullName:sub(-realmPrefix:len(), -1) == realmPrefix then
            authorFullName = authorFullName:sub(1, -realmPrefix:len() - 1)
        end

        local updateTime = GetTime() + self.baseTime
        self.messages[guid] = {
            guid = guid,
            authorGUID = authorGUID,
            author = getColoredName(author, authorGUID),
            authorFullName = authorFullName,
            content = content,
            channel = channelName,
            channelID = channelID,
            updateTime = updateTime,
            count = 1,
        }
        self.messages[guid].order = updateTime * 4294967296 + guidInt
        self.uniqueMessages = self.uniqueMessages + 1
        self:updateMessageTree(guid)
    else
        self.messages[guid].updateTime = GetTime() + self.baseTime
        self.messages[guid].count = self.messages[guid].count + 1
        self.duplicateMessages = self.duplicateMessages + 1

        if self.messageViewIndex[guid] then
            for _, v in pairs(self.messageViewIndex[guid]) do
                if self.msgViewContent == v.parent then
                    self:sortMessageView(v)
                end
                v.text = formatMsgAsTitle(v.msg, v.path)
            end
        end
    end
end

function MessageClassifierBrowser:updateMessageTree(guid)
    if not self.messages[guid] then return end
    
    local msg = self.messages[guid]
    msg.class = {}
    self:updateMessageClass(msg, MessageClassifierConfig.classificationRules)
    self:updateMessageClass(msg, MessageClassifierDefaultRules)
    self:addMessageToTree(msg, msg.class, self.messageTree)
    self.msgTreeView:SetTree(self.messageTree)
end

function MessageClassifierBrowser:addMessageToTree(msg, classPath, messageTree)
    for k in pairs(classPath) do
        local parts = split(k, '/')
        local path = nil
        local parentNode = messageTree
        local parent = parentNode
        for _, v in pairs(parts) do
            path = path and path..'/'..v or v
            if not self.messageTreeIndex[path] then
                local index = #parent + 1
                parent[index] = {
                    text = v,
                    value = v,
                    children = {},
                    parent = parentNode,
                    order = msg.order,
                }
                self.messageTreeIndex[path] = parent[index]
            end
            parentNode = self.messageTreeIndex[path]
            parent = parentNode.children
        end
    end
    
    for k in pairs(classPath) do
        if self.messageTreeIndex[k].children then
            local parentNode = self.messageTreeIndex[k]
            local parent = parentNode.children
            local index = #(parent) + 1
            parent[index] = {
                path = k,
                text = formatMsgAsTitle(msg, k),
                value = msg.guid,
                parent = parentNode,
                msg = msg,
                order = msg.order,
            }
            if not self.messageViewIndex[msg.guid] then
                self.messageViewIndex[msg.guid] = {}
            end
            self.messageViewIndex[msg.guid][#self.messageViewIndex[msg.guid] + 1] = parent[index]
            self:sortMessageView(parent[index])
        end
    end
end

function MessageClassifierBrowser:updateMessageClass(msg, ruleSet)
    for _, rule in pairs(ruleSet) do
        if self:ruleMatch(msg, rule) then
            local class = rule.class

            if class:find('{author}') ~= nil then
                class = class:gsub('{author}', msg.author)
            end

            if class:find('{channel}') then
                class = class:gsub('{channel}', msg.channel)
            end

            msg.class[class] = true
        end
    end
end

function MessageClassifierBrowser:ruleMatch(msg, rule)
    if rule.enabled ~= nil and not rule.enabled then
        return false
    end

    if rule.id and MessageClassifierConfig.enabledDefaultRules[rule.id] ~= nil and not MessageClassifierConfig.enabledDefaultRules[rule.id] then
        return false
    end

    local logicOr = rule.logic ~= "and"
    local match = false
    if #rule.conditions == 0 then
        match = true
    else
        for _, expression in ipairs(rule.conditions) do
            local operator = expression.operator
            local field = msg[expression.field or ""] or ""
            local value = expression.value or ""

            if not expression.caseSensitive then
                field = field:lower()
                if operator ~= "match" and operator ~= "not match" then
                    value = value:lower()
                end
            end

            if operator == "equal" then
                match = field == value
            elseif operator == "not equal" then
                match = field ~= value
            elseif operator == "contain" then
                match = field:find(value) ~= nil
            elseif operator == "not contain" then
                match = field:find(value) == nil
            elseif operator == "match" then
                match = field:match(value) ~= nil
            elseif operator == "not match" then
                match = field:match(value) == nil
            end

            if logicOr then
                if match then
                    break
                end
            else
                if not match then
                    break
                end
            end
        end
    end

    if match and (rule.id ~= nil
                    and MessageClassifierConfig.defRulHideFromChatWindow[rule.id] == true
                    or rule.hideFromChatWindow == true) then
        self.hideFromChatWindow[msg.guid] = true
    end

    return match
end

function MessageClassifierBrowser:updateAllMessages()
    self.pauseUpdate = true
    self.messageTree = {}
    self.messageTreeIndex = {}
    self.messageViewIndex = {}
    self.sortViewQueue = {}
    self.msgViewContent = {}
    self.hideFromChatWindow = {}
    
    for guid in pairs(self.messages) do
        self:updateMessageTree(guid)
    end
end

function MessageClassifierBrowser:updateStatusBar()
    MessageClassifierBrowser:SetStatusText(L["BROWSER_STATUS_BAR"]:format(
        self.allMessages, self.uniqueMessages,
        self.duplicateMessages,
        (self.allMessages > 0) and (self.duplicateMessages / self.allMessages * 100) or 0
    ))
end

function MessageClassifierBrowser:updateMsgView()
    local function getAllMessages(tree, result, uniqueMap)
        for i=1, #tree do
            local item = tree[i]
            if item.msg and not uniqueMap[item.msg.guid] then
                result[#result + 1] = item
                uniqueMap[item.msg.guid] = true
            end
            if item.children then
                getAllMessages(item.children, result, uniqueMap)
            end
        end
    end
    local allMessages = {}
    local uniqueMap = {}
    getAllMessages(self.msgViewContent.children, allMessages, uniqueMap)
    table.sort(allMessages, msgComp)

    self.msgView:Clear()
    self.msgView.msgSize = #allMessages
    self.msgView:SetMaxLines(self.msgView.msgSize)
    for i=1, self.msgView.msgSize do
        local msg = allMessages[i].msg
        local content = formatMsg(msg)
        if self.searchText == "" or content:lower():find(self.searchText:lower()) ~= nil then
            self.msgView:AddMessage(content, 0xff / 255, 0xc0 / 255, 0xc0 / 255)
        end
    end
    self.msgScroll:updateScroll()
end

function MessageClassifierBrowser:CreateView()
    self:SetTitle(L["BROWSER_TITLE"])
    self:updateStatusBar()
    self:SetLayout("Flow")

    self.searchEdit = AceGUI:Create("EditBox")
    self.searchEdit:SetRelativeWidth(0.8)
    self.searchEdit:SetCallback("OnEnterPressed", function(self, event, text)
        MessageClassifierBrowser.searchText = text
        MessageClassifierBrowser:updateMsgView()
    end)
    self:AddChild(self.searchEdit)

    self.settingButton = AceGUI:Create("Button")
    self.settingButton:SetText(L["BROWSER_SETTING"])
    self.settingButton:SetHeight(20)
    self.settingButton:SetRelativeWidth(0.15)
    self.settingButton:SetCallback("OnClick", function(self)
        InterfaceOptionsFrame_OpenToCategory(MessageClassifierConfigFrame.blizOptions)
    end)
    self:AddChild(self.settingButton)

    self.msgTreeView = AceGUI:Create("TreeGroup")
    self.msgTreeView:SetFullWidth(true)
    self.msgTreeView:SetFullHeight(true)
    self.msgTreeView:SetTree(self.messageTree)
    self.msgTreeView.parent = self
    self.msgTreeView:SetCallback("OnGroupSelected", function(self, event, group)
        local parent = self.parent
        -- Prevent stuttering when the user clicks on a node of the tree
        parent.pauseUpdate = true

        local path = group:gsub(string.char(1), '/')
        while path ~= '' and not parent.messageTreeIndex[path] do
            path = dirname(path)
        end
        if parent.messageTreeIndex[path] then
            parent.msgViewContent = parent.messageTreeIndex[path]
        end
        parent:updateMsgView()
    end)
    self.msgTreeView:SetLayout("Fill")
    self:AddChild(self.msgTreeView)

    self.msgView = CreateFrame("ScrollingMessageFrame", "$parentMessages", self.msgTreeView.content)
    self.msgView:SetInsertMode(SCROLLING_MESSAGE_FRAME_INSERT_MODE_TOP)
    self.msgView:SetFading(false)
    self.msgView:SetIndentedWordWrap(true)
    self.msgView:SetFontObject(ChatFontNormal)
    self.msgView:EnableMouse(true)
    self.msgView:EnableMouseWheel(true)
    self.msgView:SetHyperlinksEnabled(true)
    self.msgView:SetTextCopyable(true)
    self.msgView:SetPoint("TOPLEFT", 0, 0)
    self.msgView:SetPoint("BOTTOMRIGHT", -20, 0)
    self.msgView:SetJustifyH("LEFT")
    
    function self.msgView:OnMouseWheel(value)
        -- Scroll one line at a time
        local offset = self:GetScrollOffset() - value
        self.msgScroll:OnVerticalScroll(offset)
    end
    self.msgView:SetScript("OnMouseWheel", self.msgView.OnMouseWheel)

    self.msgView.showItemTooltip = false
    function self.msgView:showHyperlink(link)
        local t = link:match("^(.-):")
        if t == "item" or t == "enchant" or t == "spell" or t == "quest" then
            GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
            GameTooltip:SetHyperlink(link)
            GameTooltip:Show()
            self.showItemTooltip = true
        end
    end
    function self.msgView:hideHyperlink(link)
        if self.showItemTooltip then
            GameTooltip:ClearLines()
            GameTooltip:Hide()
            self.showItemTooltip = false
        end
    end
    self.msgView:SetScript("OnHyperlinkClick", ChatFrame_OnHyperlinkShow)
    self.msgView:SetScript("OnHyperlinkEnter", self.msgView.showHyperlink)
    self.msgView:SetScript("OnHyperlinkLeave", self.msgView.hideHyperlink)

    self.msgScroll = CreateFrame("ScrollFrame", "$parentScroll", self.msgTreeView.content, "FauxScrollFrameTemplate")
    self.msgScroll:SetPoint("TOPLEFT", 0, 0)
    self.msgScroll:SetPoint("BOTTOMRIGHT", -20, 0)

    self.msgView.msgSize = 0
    self.msgView:SetMaxLines(self.msgView.msgSize)

    self.msgScroll.msgView = self.msgView
    self.msgView.msgScroll = self.msgScroll
    function self.msgScroll:updateScroll()
        local lines = self.msgView.msgSize
        if lines == 0 then
            lines = 1
        end
        local offset = FauxScrollFrame_GetOffset(self)
        self.msgView:SetScrollOffset(offset)
        FauxScrollFrame_Update(self, lines, 1, 1)
    end
    function self.msgScroll:OnVerticalScroll(offset)
        FauxScrollFrame_OnVerticalScroll(self, offset, 1, self.updateScroll)
    end
    self.msgScroll:SetScript("OnVerticalScroll", self.msgScroll.OnVerticalScroll)
    self:Hide()

    SLASH_MSGCF1 = "/msgcf"
    SlashCmdList["MSGCF"] = function(...)
        if MessageClassifierBrowser:IsShown() then
            MessageClassifierBrowser:Hide()
        else
            MessageClassifierBrowser:Show()
        end
    end
end

MessageClassifierBrowser:CreateView()

--minimap icon
MessageClassifierBrowser.icon = CreateFrame("Button", "MessageClassifierBrowserIcon", Minimap)
function MessageClassifierBrowser.icon:CreateView()
    self:SetClampedToScreen(true)
    self:SetMovable(true)
    self:EnableMouse(true)
    self:RegisterForDrag("LeftButton")
    self:RegisterForClicks("LeftButtonUp")
    self:SetScript("OnDragStart", function(self)
        if IsShiftKeyDown() then
            self:StartMoving()
        end
    end)
    self:SetScript("OnDragStop", function(self)
        self:StopMovingOrSizing()
    end)
    self:SetScript("OnClick", function()
        if MessageClassifierBrowser:IsShown() then
            MessageClassifierBrowser:Hide()
        else
            MessageClassifierBrowser:Show()
        end
    end)

    self:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
        GameTooltip:SetText(L["CONFIG_PAGE_TITLE"])
        GameTooltip:AddDoubleLine(L["Left-Click"], L["BROWSER_TITLE"], 1, 1, 1, 1, 1, 1)
        GameTooltip:AddDoubleLine(L["Shift-Click"], L["MOVE_BUTTON"], 1, 1, 1, 1, 1, 1)
        GameTooltip:Show()
    end)
    
    self:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)
    
    self:SetFrameStrata('LOW')
    self:SetWidth(31)
    self:SetHeight(31)
    self:SetFrameLevel(9)
    self:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
    self:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)
    
    self.overlay = self:CreateTexture(nil, 'OVERLAY')
    self.overlay:SetWidth(53)
    self.overlay:SetHeight(53)
    self.overlay:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder')
    self.overlay:SetPoint('TOPLEFT', 0,0)
    
    self.icon = self:CreateTexture(nil, 'BACKGROUND')
    self.icon:SetWidth(15)
    self.icon:SetHeight(15)
    self.icon:SetTexture("Interface\\Addons\\"..ADDON_NAME.."\\img\\logo")
    self.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
    self.icon:SetPoint('CENTER',1,1)
    
end
MessageClassifierBrowser.icon:CreateView()
