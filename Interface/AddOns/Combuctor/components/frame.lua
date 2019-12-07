--[[
	frame.lua
		A combuctor frame object
--]]

local ADDON, Addon = ...
local L = LibStub('AceLocale-3.0'):GetLocale(ADDON)
local Frame = Addon.Frame


--[[ Constructor ]]--

function Frame:New(id)
	local f = self:Bind(CreateFrame('Frame', ADDON .. 'Frame' .. id, UIParent, ADDON .. 'FrameTemplate'))
	f.profile = Addon.profile[id]
	f.frameID = id
	f.quality = 0

	f:SetSize(f.profile.width, f.profile.height)
	f:SetScript('OnSizeChanged', self.OnSizeChanged)
	f:SetScript('OnShow', self.OnShow)
	f:SetScript('OnHide', self.OnHide)
	f:FindRules()

	f.ownerSelector = Addon.OwnerSelector:New(f)
	f.ownerSelector:SetPoint('TOPLEFT', -3, 4)

	f.bagToggle = Addon.BagToggle:New(f)
	f.bagToggle:SetPoint('TOPRIGHT', -10, -27)

	if SortBags then
		f.sortButton = Addon.SortButton:New(f)
		f.sortButton:SetPoint('RIGHT', f.bagToggle, 'LEFT', -7, 0)
	else
		f.searchBox:SetPoint('TOPRIGHT', -49, -32)
	end

	f.moneyFrame = Addon.MoneyFrame:New(f)
	f.moneyFrame:SetPoint('BOTTOMRIGHT', -8, 4)

	f.qualityFilter = Addon.QualityFilter:New(f)
	f.qualityFilter:SetPoint('BOTTOMLEFT', 10, 4)

	f.sideFilter = Addon.SideFilter:New(f)
	f.bottomFilter = Addon.BottomFilter:New(f)
	f.bottomFilter:SetPoint('TOPLEFT', f, 'BOTTOMLEFT')

	f.bagFrame = Addon.BagFrame:New(f, 'TOP', 0, -36)
	f.bagFrame:SetPoint('TOPRIGHT', -12, -66)

	f.itemFrame = Addon.ItemFrame:New(f, self.Bags)
	f.itemFrame:SetPoint('TOPLEFT', 12, -66)

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
	self:RegisterFrameSignal('RULES_UPDATED', 'UpdateSize')
	self:Update()
end


--[[ Frame Events ]]--

function Frame:OnSizeChanged()
	-- 老虎会游泳：阻止窗体过小时缩放物品格子
	if self.itemFrame then
		self.itemFrame.parent = self
		self.itemFrame.oldHeight = self.profile.height
	end

	self.profile.width = self:GetWidth()
	self.profile.height = self:GetHeight()
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
	self:UpdateSize()
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

function Frame:UpdateSize()
	local bagsHeight =  self.bagFrame:GetHeight()
	local rulesHeight = self.sideFilter.numButtons * 50 - (self.profile.reversedTabs and 10 or 50)
	local minHeight = max(bagsHeight, rulesHeight) + 100

	self:SetHeight(max(self:GetHeight(), minHeight))
	self:SetMinResize(300, minHeight)
end

function Frame:UpdateItems()
	self.itemFrame:RequestLayout()
end

function Frame:UpdateSearch()
	if Addon.search ~= self.searchBox:GetText() then
		self.searchBox:SetText(Addon.search or '')
	end
end
