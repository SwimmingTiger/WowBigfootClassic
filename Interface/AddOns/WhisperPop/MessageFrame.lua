------------------------------------------------------------
-- MessageFrame.lua
--
-- Abin
-- 2010-9-28
------------------------------------------------------------

local FRAME_WIDTH = 320
local INDENT_LEFT = 8
local INDENT_RIGHT = 28
local LIST_WIDTH = FRAME_WIDTH - INDENT_LEFT - INDENT_RIGHT
local MESSAGE_MIN_HEIGHT = 48
local MESSAGE_MAX_HEIGHT = 400
local MESSAGE_ADD_HEIGHT = 35
local COUNTING_TIME = 0.3

-- Message frame
local frame = WhisperPop:CreateCommonFrame("WhisperPopMessageFrame", WhisperPop.mainFrame)
WhisperPop.messageFrame = frame
frame:SetWidth(FRAME_WIDTH)

local label = WhisperPop:CreatePlayerButton(nil, frame:GetName().."Label", frame)
label:SetPoint("TOPLEFT", INDENT_LEFT, -5)
label:SetPoint("TOPRIGHT", -INDENT_RIGHT, -5)

-- The ScrollingMessageFrame that displays message text lines
local list = CreateFrame("ScrollingMessageFrame", "WhisperPopScrollingMessageFrame", frame, "ChatFrameTemplate")
list:SetPoint("TOPLEFT", label, "BOTTOMLEFT")
list:SetWidth(LIST_WIDTH)
list:Show()
list:SetFading(false)
list:SetMaxLines(1000)
list:SetJustifyH("LEFT")
list:SetIndentedWordWrap(false)
list:SetFrameStrata("DIALOG")
list:SetScript("OnLoad", nil)
list:SetScript("OnEvent", nil)
list:SetScript("OnUpdate", nil)
list:UnregisterAllEvents()

-- A hidden FontString to determine height of every message text
local totalHeight = 0
local testFont = list:CreateFontString(nil, "ARTWORK", "ChatFontNormal")
testFont:SetPoint("TOPLEFT", list, "BOTTOMLEFT")
testFont:SetWidth(LIST_WIDTH)
testFont:SetJustifyH("LEFT")
testFont:SetNonSpaceWrap(true)
testFont:Hide()
testFont:SetText("ABC")
local SINGLE_HEIGHT = testFont:GetHeight()

frame:EnableMouseWheel(true)
frame:SetScript("OnMouseWheel", function(self, delta)
	if delta == 1 then
		if IsShiftKeyDown() then
			list:ScrollToTop()
		else
			list:ScrollUp()
		end
	elseif delta == -1 then
		if IsShiftKeyDown() then
			list:ScrollToBottom()
		else
			list:ScrollDown()
		end
	end
end)

function frame:IsReading()
	if self:IsShown() then
		return self.name
	end
end

function frame:UpdateHeight()
	if totalHeight < SINGLE_HEIGHT then
		totalHeight = SINGLE_HEIGHT
	end

	if totalHeight > MESSAGE_MAX_HEIGHT then
		totalHeight = MESSAGE_MAX_HEIGHT
	end

	self:SetHeight(max(totalHeight, MESSAGE_MIN_HEIGHT) + MESSAGE_ADD_HEIGHT + 2)
	list:SetHeight(totalHeight + 2)
end

function frame:AddMessage(timeStamp, text, inform, bnFriend)
	if inform and WhisperPop.db.receiveonly then
		return
	end

	local useTime = WhisperPop.db.time
	local r, g, b
	if inform then
		r, g, b = 0.5, 0.5, 0.5
	elseif bnFriend then
		r, g, b = 0, 1, 0.96
	else
		r, g, b = 1, 0.5, 1
	end

	local term, tag
	for tag in gmatch(text, "%b{}") do
		term = strlower(gsub(tag, "[{}]", ""))
		if ICON_TAG_LIST[term] and ICON_LIST[ICON_TAG_LIST[term]] then
			text = gsub(text, tag, ICON_LIST[ICON_TAG_LIST[term]] .. "0|t")
		end
	end

	text = useTime and timeStamp.." "..text or text
	list:AddMessage(text, r, g, b, inform and 1 or 0)

	if totalHeight < MESSAGE_MAX_HEIGHT then
		testFont:SetText(text)
		totalHeight = totalHeight + testFont:GetHeight()
	end
end

function frame:SetData(class, name, messages, bnFriend)
	if self:IsReading() == name then
		return
	end

	self.name = name
	label:SetPlayer(class, name)
	list:Clear()
	totalHeight = 0

	local data
	for _, data in ipairs(messages) do
		self:AddMessage(data.time, data.text, data.inform, bnFriend)
	end

	self:Show()
	self:UpdateHeight()
	list:ScrollToBottom()
end

frame:SetScript("OnUpdate", function(self)
	if self.hideTime and GetTime() > self.hideTime then
		self.hideTime = nil
		self:Hide()
	end
end)

function frame:StartCounting()
	self.hideTime = GetTime() + COUNTING_TIME
end

function frame:StopCounting()
	self.hideTime = nil
end

local function StartCounting()
	frame:StartCounting()
end

local function StopCounting()
	frame:StopCounting()
end

frame:SetScript("OnEnter", StopCounting)
frame:SetScript("OnLeave", StartCounting)

label:SetScript("OnEnter", StopCounting)
label:SetScript("OnLeave", StartCounting)

frame.topClose:SetScript("OnEnter", StopCounting)
frame.topClose:SetScript("OnLeave", StartCounting)

list:SetScript("OnHyperlinkEnter", StopCounting)
list:SetScript("OnHyperlinkLeave", StartCounting)

local function CreateScrollButton(name, parentFuncName)
	local button = CreateFrame("Button", list:GetName().."Button"..name, list)
	button:SetWidth(24)
	button:SetHeight(24)
	button:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-Scroll"..name.."-Up")
	button:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-Scroll"..name.."-Down")
	button:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-Scroll"..name.."-Disabled")
	button:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight", "ADD")
	button.parentFuncName = parentFuncName
	button:SetScript("OnClick", function(self) list[self.parentFuncName](list) end)
	button:SetScript("OnEnter", StopCounting)
	button:SetScript("OnLeave", StartCounting)
	return button
end

-- Scroll buttons
local endButton = CreateScrollButton("End", "ScrollToBottom")
endButton:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -3, 3)

local flash = endButton:CreateTexture(endButton:GetName().."Flash", "OVERLAY")
flash:SetTexture("Interface\\ChatFrame\\UI-ChatIcon-BlinkHilight")
flash:SetAllPoints(endButton)
flash:Hide()

endButton:SetScript("OnUpdate", function(self, elapsed)
	if list:AtBottom() then
		flash:Hide()
		return
	end

	self.elapsed = (self.elapsed or 0) + elapsed
	if self.elapsed > 0.5 then
		self.elapsed = 0
		if flash:IsShown() then
			flash:Hide()
		else
			flash:Show()
		end
	end
end)

local downButton = CreateScrollButton("Down", "ScrollDown")
downButton:SetPoint("BOTTOM", endButton, "TOP", 0, -6)

local upButton = CreateScrollButton("Up", "ScrollUp")
upButton:SetPoint("BOTTOM", downButton, "TOP", 0, -6)