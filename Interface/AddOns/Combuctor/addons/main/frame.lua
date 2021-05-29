--[[
	frame.lua
		A combuctor frame object
--]]

local ADDON, Addon = ...
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
local Frame = Addon.Frame


--[[ Constructor ]]--

function Frame:New(id)
	local f = self:Super(Frame):New(UIParent)
	f.profile = Addon.profile[id]
	f.frameID = id
	f.quality = 0

	f:SetSize(f.profile.width, f.profile.height)
	f:SetScript('OnSizeChanged', self.OnSizeChanged)
	f:SetScript('OnShow', self.OnShow)
	f:SetScript('OnHide', self.OnHide)
	f:FindRules()

	f.ownerSelector = Addon.OwnerSelector:New(f)
	f.ownerSelector:SetPoint('TOPLEFT', -4, 5)

	f.bagToggle = Addon.BagToggle:New(f)
	f.bagToggle:SetPoint('TOPRIGHT', -10, -27)

	f.sortButton = Addon.SortButton:New(f)
	f.sortButton:SetPoint('RIGHT', f.bagToggle, 'LEFT', -7, 0)

	f.moneyFrame = Addon.MoneyFrame:New(f)
	f.moneyFrame:SetPoint('BOTTOMRIGHT', -8, 4)

	f.qualityFilter = Addon.QualityFilter:New(f)
	f.qualityFilter:SetPoint('BOTTOMLEFT', 10, 4)

	f.sideFilter = Addon.SideFilter:New(f)
	f.bottomFilter = Addon.BottomFilter:New(f)
	f.bottomFilter:SetPoint('TOPLEFT', f, 'BOTTOMLEFT')

	f.bagGroup = Addon.BagGroup:New(f, 'TOP', 0, -36)
	f.bagGroup:SetPoint('TOPRIGHT', -12, -66)

	f.itemGroup = Addon.ItemGroup:New(f, self.Bags)
	f.itemGroup:SetPoint('TOPLEFT', 12, -66)

	-- 老虎会游泳：在左侧添加一个按钮
	f.searchBox:SetPoint('TOPLEFT', 146, -32)
	f.extraButton = CreateFrame("Button", "$parentExtraButton", f, "UIPanelButtonTemplate")
	f.extraButton:ClearAllPoints()
	f.extraButton:SetPoint("TOPLEFT", 58, -29)
	f.extraButton:SetSize(80, 25)
	f.extraButton:SetText(L[id.."ExtraButton"])
	f.extraButton.text = f.extraButton:GetFontString()
	f.extraButton.text:SetFont(STANDARD_TEXT_FONT, L['ExtraButtonFontSize'])
	if id == "inventory" then
		f.extraButton:SetScript("OnClick", function()
			f.bagToggle:OnClick("RightButton")
		end)
	elseif id == "bank" then
		f.extraButton:SetScript("OnClick", function()
			if TDPack2Command and TDPack2Command.commands and TDPack2Command.commands.SAVE then
				PlaySound(SOUNDKIT.UI_BAG_SORTING_01)
				TDPack2Command.commands.SAVE()
			end
		end)
	end
	f.extraButton:Show()

	tinsert(UISpecialFrames, f:GetName())
	return f
end

function Frame:RegisterSignals()
	self:RegisterSignal('UPDATE_ALL', 'Update')
	self:RegisterSignal('RULES_LOADED', 'FindRules')
	self:RegisterSignal('SEARCH_CHANGED', 'UpdateSearch')
	self:RegisterFrameSignal('PLAYER_CHANGED', 'UpdateTitle')
	self:RegisterFrameSignal('BAG_FRAME_TOGGLED', 'UpdateItems')
	-- 老虎会游泳：物品栏更新后再改变背包大小
	--self:RegisterFrameSignal('RULES_UPDATED', 'UpdateSize')
	self:RegisterFrameSignal('ITEM_FRAME_RESIZED', 'UpdateSize')
	self:Update()
end


--[[ Frame Events ]]--

function Frame:OnSizeChanged()
	-- 老虎会游泳：防止背包边框与物品格子之间产生空隙
	--self.profile.width = self:GetWidth()
	--self.profile.height = self:GetHeight()

	if self.posX == nil or self.posY == nil then
		return
	end

	local buttonSize = self:GetButtonScaleSize()

	if abs(self.posX) > abs(self.posY) then
		if abs(self.posX) >= buttonSize then
			self.profile.columns = self.profile.columns + (self.posX > 0 and 1 or -1)
			self.posX = 0
		end
	elseif abs(self.posY) > abs(self.posX) then
		if abs(self.posY) >= buttonSize then
			self.profile.columns = self.profile.columns + (self.posY > 0 and 1 or -1)
			self.posY = 0
		end
	end

	self:UpdateItems()
end

function Frame:OnSearchTextChanged(text)
	if text ~= Addon.search then
		Addon.search = text
		Addon:SendSignal('SEARCH_CHANGED', text)
	end
end


--[[ Update ]]--

function Frame:Update()
	self:UpdateTitle()
	self:UpdateAppearance()
	self:UpdateSideFilter()
	-- 老虎会游泳：此处不触发，物品栏更新后再改变背包大小
	--self:UpdateSize()
end

function Frame:UpdateTitle()
	self.titleText:SetFormattedText(self.Title, self:GetOwner())
	self.titleText:SetWidth(self.titleText:GetTextWidth())
end

function Frame:UpdateSideFilter()
	self.sideFilter:ClearAllPoints()

	if self.profile.reversedTabs then
 		self.sideFilter:SetPoint('TOPRIGHT', self, 'TOPLEFT', -24, -40)
	else
 		self.sideFilter:SetPoint('TOPLEFT', self, 'TOPRIGHT')
	end
end

-- 老虎会游泳：新增函数
function Frame:GetButtonScaleSize()
	return self.itemGroup:GetButtonSize() * (self.itemGroup.scale or self.profile.itemScale or 1)
end

-- 老虎会游泳：新增函数
function Frame:GetMinHeightAndBorder()
	local borderTopBottom = 96
	local borderLeftRight = self.profile.showBags and 59 or 23

	local bagsHeight =  self.bagGroup:GetHeight()
	local rulesHeight = self.sideFilter.numButtons * 50 - (self.profile.reversedTabs and 10 or 50)
	local minHeight = max(bagsHeight, rulesHeight) + borderTopBottom

	return minHeight, borderTopBottom, borderLeftRight
end

-- 老虎会游泳：在物品栏更新后改变背包大小
function Frame:UpdateSize()
	local minHeight, borderTopBottom, borderLeftRight = self:GetMinHeightAndBorder()

	local buttonSize = self:GetButtonScaleSize()
	local minWidth = buttonSize * self.itemGroup.minColumns + borderLeftRight
	self:SetMinResize(minWidth, minHeight)

	self.posX = self.posX or 0
	self.posY = self.posY or 0

	self.posX = self.posX + (self:GetWidth() - self.profile.width)
	self.posY = self.posY + (self.profile.height - self:GetHeight())

	-- 防止事件重复触发
	local OnSizeChanged = self.OnSizeChanged
	self.OnSizeChanged = function(self)
		self.OnSizeChanged = OnSizeChanged
	end

	minHeight = max(minHeight, self.itemGroup.numItems / self.itemGroup.columns * buttonSize + borderTopBottom)
	self:SetSize(max(minWidth, self.itemGroup:GetWidth() + borderLeftRight), max(minHeight, self.itemGroup:GetHeight() + borderTopBottom))
	self.profile.width = self:GetWidth()
	self.profile.height = self:GetHeight()
end

function Frame:UpdateItems()
	self.itemGroup:RequestLayout()
end

function Frame:UpdateSearch()
	if Addon.search ~= self.searchBox:GetText() then
		self.searchBox:SetText(Addon.search or '')
	end
end
