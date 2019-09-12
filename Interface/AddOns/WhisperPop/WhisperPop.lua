------------------------------------------------------------
-- WhisperPop.lua
--
-- Abin
-- 2010-9-28
------------------------------------------------------------

WhisperPop = {}
WhisperPop.version = GetAddOnMetadata("WhisperPop", "Version") or "3.0"
WhisperPop.IGNORED_MESSAGES = { "<DBM>", "<BWS>", "<BigWigs>", "<BIGWIGS>", "<集合石插件>","<大脚团队提示>", "LVBM" } -- Add your ignore tags
WhisperPop.db = { sound = 1, time = 1, help = 1, keep = 1 }
WhisperPop.newNames = {}

function WhisperPop:IsIgnoredMessage(text)
	local pattern
	for _, pattern in ipairs(self.IGNORED_MESSAGES) do
		if strfind(text, pattern) then
			return pattern
		end
	end
end

function WhisperPop:CreateCommonFrame(name, parent, titleText)
	local frame = CreateFrame("Button", name, parent)
	frame:Hide()
	frame:SetWidth(165)
	frame:SetHeight(262)
	frame:SetClampedToScreen(true)
	frame:SetBackdrop({ bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background", tile = true, tileSize = 16, edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 } })

	local title = frame:CreateFontString(name.."Title", "ARTWORK", "GameFontNormal")
	title:SetPoint("TOP", 0, -7)
	title:SetText(titleText)
	frame.title = title

	local button = CreateFrame("Button", name.."CloseButton", frame, "UIPanelCloseButton")
	frame.topClose = button
	button:SetPoint("TOPRIGHT", -2, -2)
	button:SetWidth(24)
	button:SetHeight(24)

	return frame
end

function WhisperPop:CreatePlayerButton(button, name, parent)
	if not button then
		button = CreateFrame("Frame", name, parent)
		button:SetWidth(100)
		button:SetHeight(20)
	end

	button.classIcon = button:CreateTexture(button:GetName().."ClassIcon", "ARTWORK")
	button.classIcon:SetWidth(16)
	button.classIcon:SetHeight(16)
	button.classIcon:SetPoint("LEFT", 4, 0)

	button.nameText = button:CreateFontString(button:GetName().."NameText", "ARTWORK", "GameFontHighlightSmallLeft")
	button.nameText:SetPoint("LEFT", button.classIcon, "RIGHT", 2, 0)

	button.SetPlayer = function(self, class, name)
		self.nameText:SetText(name)
		local coords = CLASS_ICON_TCOORDS[class]
		if coords then
			self.classIcon:SetTexture("Interface\\WorldStateFrame\\Icons-Classes")
			self.classIcon:SetTexCoord(coords[1], coords[2], coords[3], coords[4])
			self.classIcon:Show()
		elseif class == "GM" then
			self.classIcon:SetTexture("Interface\\AddOns\\WhisperPop\\Texture\\GM")
			self.classIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			self.classIcon:Show()
		elseif class == "BN" then
			self.classIcon:SetTexture("Interface\\AddOns\\WhisperPop\\Texture\\BN")
			self.classIcon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
			self.classIcon:Show()
		else
			self.classIcon:Hide()
		end
	end

	return button
end

function WhisperPop:OnNewMessage(name, text, inform, guid)
	if not inform and self.db.sound then
		PlaySoundFile("Interface\\AddOns\\WhisperPop\\Notify.mp3") -- Got new message!
	end
end

function WhisperPop:GetNumNewNames()
	return getn(self.newNames)
end

function WhisperPop:GetNewName(id)
	return self.newNames[id or 1]
end

function WhisperPop:OnListUpdate()
	wipe(self.newNames)
	for i = 1, self.list:GetDataCount() do
		local data = self.list:GetData(i)
		if data.state == "new" then
			tinsert(self.newNames, data.name)
		end
	end

	-- self.tipFrame:SetTip(self.newNames[1])
end

function WhisperPop:ToggleFrame()
	if WhisperPop.mainFrame:IsShown() then
		WhisperPop.mainFrame:Hide()
	else
		WhisperPop.mainFrame:Show()
	end
end
