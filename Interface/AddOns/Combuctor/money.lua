--[[
	moneyFrame.lua
		A money frame object
--]]

local MoneyFrame = Combuctor:NewClass('Frame')
Combuctor.MoneyFrame = MoneyFrame

local L = LibStub('AceLocale-3.0'):GetLocale('Combuctor')

function MoneyFrame:New(parent)
	local f = self:Bind(CreateFrame('Frame', parent:GetName() .. 'MoneyFrame', parent, 'SmallMoneyFrameTemplate'))
	f:SetScript('OnShow', self.Update)
	f:Update()

	local click = CreateFrame('Button', f:GetName() .. 'Click', f)
	click:SetFrameLevel(f:GetFrameLevel() + 3)
	click:SetAllPoints(f)

	click:SetScript('OnClick', self.OnClick)
	click:SetScript('OnEnter', self.OnEnter)
	click:SetScript('OnLeave', self.OnLeave)

	return f
end

function MoneyFrame:Update()
	local player = self:GetParent():GetPlayer()
	if player == UnitName('player') or not BagnonDB then
		MoneyFrame_Update(self:GetName(), GetMoney())
	else
		MoneyFrame_Update(self:GetName(), BagnonDB:GetMoney(player))
	end
end

--frame events
function MoneyFrame:OnClick()
	local parent = self:GetParent()
	local name = parent:GetName()

	if MouseIsOver(_G[name .. 'GoldButton']) then
		OpenCoinPickupFrame(COPPER_PER_GOLD, MoneyTypeInfo[parent.moneyType].UpdateFunc(self), parent)
		parent.hasPickup = 1
	elseif MouseIsOver(_G[name .. 'SilverButton']) then
		OpenCoinPickupFrame(COPPER_PER_SILVER, MoneyTypeInfo[parent.moneyType].UpdateFunc(self), parent)
		parent.hasPickup = 1
	elseif MouseIsOver(_G[name .. 'CopperButton']) then
		OpenCoinPickupFrame(1, MoneyTypeInfo[parent.moneyType].UpdateFunc(self), parent)
		parent.hasPickup = 1
	end
end

function MoneyFrame:OnEnter()
	if BagnonDB then
		GameTooltip:SetOwner(self, 'ANCHOR_TOPRIGHT')
		GameTooltip:SetText(format(L.TotalOnRealm, GetRealmName()))

		local money = 0
		for player in BagnonDB:GetPlayers() do
			money = money + BagnonDB:GetMoney(player)
		end

		SetTooltipMoney(GameTooltip, money)
		GameTooltip:Show()
	end
end

function MoneyFrame:OnLeave()
	GameTooltip:Hide()
end