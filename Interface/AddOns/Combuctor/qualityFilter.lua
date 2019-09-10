--[[
	Quality Filter Widget
		used for setting what quality of items to show
--]]

local FilterButton = Combuctor:NewClass('Button')
local SIZE = 20
local _G = getfenv(0)

function FilterButton:Create(parent, quality)
	local button = self:Bind(CreateFrame('Button', nil, parent, 'UIRadioButtonTemplate'))
	button:SetWidth(SIZE)
	button:SetHeight(SIZE)
	button:SetScript('OnClick', self.OnClick)
	button:SetScript('OnEnter', self.OnEnter)
	button:SetScript('OnLeave', self.OnLeave)
	button.quality = quality
	if quality > -1 then
		local bg = button:CreateTexture(nil, 'BACKGROUND')
		bg:SetWidth(SIZE/2)
		bg:SetHeight(SIZE/2)
		bg:SetPoint('CENTER')
		bg:SetColorTexture(GetItemQualityColor(quality))
		button.bg = bg

	end
	-- button:SetHighlightTexture("Interface\Buttons\CancelButton-Square")
	return button
end

function FilterButton:OnClick()
	if self.quality == -1 then
		self:GetParent():GetParent():SetQuality()
	else
		self:GetParent():GetParent():SetQuality(self.quality)

	end
end

function FilterButton:OnEnter()
	GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')

	local quality = self.quality
	if quality and quality> -1 then
		local r,g,b = GetItemQualityColor(quality)
		GameTooltip:SetText(_G[format('ITEM_QUALITY%d_DESC', quality)], r, g, b)
	else
		GameTooltip:SetText(ALL)
	end

	GameTooltip:Show()
end

function FilterButton:OnLeave()
	GameTooltip:Hide()
end

function FilterButton:UpdateHighlight(quality)

	if self.quality == quality then
		if self.bg then
			self.bg:SetAlpha(1)
		end
		self:GetNormalTexture():SetVertexColor(1, 0, 0.3 )
		self:LockHighlight()
	else
		if self.bg then
			self.bg:SetAlpha(0.5)
		end
		self:GetNormalTexture():SetVertexColor(1, 1, 1)
		self:UnlockHighlight()
	end
end


--[[
	QualityFilter, A group of filter buttons
--]]

local QualityFilter = Combuctor:NewClass('Frame')
Combuctor.QualityFilter = QualityFilter

function QualityFilter:New(parent)
	local f = self:Bind(CreateFrame('Frame', nil, parent))

	local prev
	for quality = -1, 5 do
		-- if quality~=6 then --传家宝7 6为神器 神器不常有而传家宝常有。
		local button = FilterButton:Create(f, quality)
		if prev then
			button:SetPoint('LEFT', prev, 'RIGHT', 1, 0)
		else
			button:SetPoint('LEFT')
		end
		prev = button
		-- end
	end

	f:SetWidth(SIZE * 6)
	f:SetHeight(SIZE)
	f:UpdateHighlight()

	return f
end

function QualityFilter:UpdateHighlight()
	local quality = self:GetParent():GetQuality()

	for i = 1, select('#', self:GetChildren()) do
		select(i, self:GetChildren()):UpdateHighlight(quality)
	end
end