--[[
	Tab Filters
		Used to filter within categories
--]]

local BottomTab = Combuctor:NewClass('Button')
local CombuctorSets = Combuctor:GetModule('Sets')
local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')

function BottomTab:New(parent, id)
		local tab = self:Bind(CreateFrame('Button', parent:GetName() .. 'Tab' .. id, parent, 'CombuctorFrameTabButtonTemplate'))
		tab:SetScript('OnClick', self.OnClick)
		tab:SetID(id)
		return tab
end

function BottomTab:OnClick()
	local frame = self:GetParent():GetParent()

	if frame.selectedTab ~= self:GetID() then
		PlaySound(SOUNDKIT.IG_CHARACTER_INFO_TAB)
	end

	frame.selTab = self:GetID()
	if frame:GetName() == 'CombuctorFrame2' then
		if self:GetID() == 3 then
			BankFrame.activeTabIndex = 2
			_G[frame:GetName() .. 'BagToggle']:Hide()
			for i,bag in pairs(_G[frame:GetName()].bagButtons) do
				_G[frame:GetName()].bagButtons[i] = nil
				bag:Release()
			end
			_G[frame:GetName()]:OnItemFrameSizeChanged()

			_G[frame:GetName()].sets.showBags = false;
			-- if not IsReagentBankUnlocked() then
				-- StaticPopup_Show('WANT_TO_BUY_REAGENTBANK_TAB')
				-- StaticPopupDialogs["WANT_TO_BUY_REAGENTBANK_TAB"].frame = frame
			-- end
		else
			if self:GetID() == 2 then
				BankFrame.activeTabIndex = 1
			else
				BankFrame.activeTabIndex = nil
			end
			_G[frame:GetName() .. 'BagToggle']:Show()
			_G[frame:GetName()]:UpdateBagFrame()
		end
	end

	frame:SetSubCategory(self.set.name)
end

StaticPopupDialogs["WANT_TO_BUY_REAGENTBANK_TAB"] = {
	text = CONFIRM_BUY_REAGNETBANK_TAB,
	button1 = YES,
	button2 = NO,
	OnAccept = function(self)
		BuyReagentBank();
	end,
	OnShow = function(self)
		MoneyFrame_Update(self.moneyFrame, GetReagentBankCost());
	end,
	OnHide = function(self)
		BigFoot_DelayCall(function()
			if IsReagentBankUnlocked and IsReagentBankUnlocked() then
				StaticPopupDialogs["WANT_TO_BUY_REAGENTBANK_TAB"].frame:SetSubCategory(L.Bank)
				StaticPopupDialogs["WANT_TO_BUY_REAGENTBANK_TAB"].frame:SetSubCategory(REAGENT_BANK)
				_G[StaticPopupDialogs["WANT_TO_BUY_REAGENTBANK_TAB"].frame:GetName() .. 'BagToggle']:Hide()
				for i,bag in pairs(_G[StaticPopupDialogs["WANT_TO_BUY_REAGENTBANK_TAB"].frame:GetName()].bagButtons) do
					_G[StaticPopupDialogs["WANT_TO_BUY_REAGENTBANK_TAB"].frame:GetName()].bagButtons[i] = nil
					bag:Release()
				end
				_G[StaticPopupDialogs["WANT_TO_BUY_REAGENTBANK_TAB"].frame:GetName()]:OnItemFrameSizeChanged()
			end
		end,
		1)
	end,
	hasMoneyFrame = 1,
	timeout = 0,
	hideOnEscape = 1
};

function BottomTab:Set(set)
	self.set = set
	if set.icon then
		self:SetFormattedText('|T%s:%d|t %s', set.icon, 16, set.name)
	else
		self:SetText(set.name)
	end

	PanelTemplates_TabResize(self, 0)
	self:GetHighlightTexture():SetWidth(self:GetTextWidth() + 30)
end

function BottomTab:UpdateHighlight(setName)
	if self.set.name == setName then
		PanelTemplates_SetTab(self:GetParent(), self:GetID())
	end
end


--[[
	BottomTab Object
--]]


--[[
	Side Filter Object
--]]

local BottomFilter = Combuctor:NewClass('Frame')
Combuctor.BottomFilter = BottomFilter

function BottomFilter:New(parent)
	local f = self:Bind(CreateFrame('Frame', parent:GetName() .. 'BottomFilter', parent))

	--metatable magic for button creation on demand
	f.buttons = setmetatable({}, {__index = function(t, k)
		local tab = BottomTab:New(f, k)
		if k > 1 then
			tab:SetPoint('LEFT', f.buttons[k-1], 'RIGHT', -16, 0)
		else
			tab:SetPoint('CENTER', parent, 'BOTTOMLEFT', 60, 46)
		end

		t[k] = tab
		return tab
	end})

	return f
end

function BottomFilter:UpdateFilters()
	local numFilters = 0
	local isFirstSideFilter =false;
	local parent = self:GetParent()

	for _,set in CombuctorSets:GetChildSets(parent:GetCategory()) do
		if not parent.isBank and set.parent == L.All then
			isFirstSideFilter = true;
		end
		
		if parent:HasSubSet(set.name, set.parent) then
			numFilters = numFilters + 1
			self.buttons[numFilters]:Set(set)
		end
	end

	--show only used tabs
	if numFilters > 1 and not isFirstSideFilter then
		for i = 1, numFilters do
			self.buttons[i]:Show()
		end

		-- for i = 1, numFilters do
			-- if self.buttons[i]:GetName() == 'CombuctorFrame1BottomFilterTab1' then
				-- self.buttons[i]:Hide()
			-- end
			-- if self.buttons[i]:GetName() == 'CombuctorFrame1BottomFilterTab2' then
				-- self.buttons[i]:Hide()
			-- end
			-- if self.buttons[i]:GetName() == 'CombuctorFrame1BottomFilterTab3' then
				-- self.buttons[i]:Hide()
			-- end
		-- end

		for i = numFilters + 1, #self.buttons do
			self.buttons[i]:Hide()
		end

		PanelTemplates_SetNumTabs(self, numFilters)
		self:UpdateHighlight()
		self:Show()
	--at most one filter active, hide all tabs
	else
		PanelTemplates_SetNumTabs(self, 0)
		self:Hide()
	end
	self:GetParent():UpdateClampInsets()
end

function BottomFilter:UpdateHighlight()
	local category = self:GetParent():GetSubCategory()

	for _,button in pairs(self.buttons) do
		if button:IsShown() then
			button:UpdateHighlight(category)
		end
	end
end