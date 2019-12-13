--[[
	itemFrame.lua
		Modifies the item frame to always fit inside the panel
--]]

local ADDON, Addon = ...
local ItemFrame = Addon.ItemFrame

local function round(n)
	return math.floor((math.floor(n*2) + 1)/2)
end

function ItemFrame:LayoutTraits()
	local profile = self:GetProfile()
	self.scale = profile.itemScale or 1

	self.minColumns = 7
	if self.scale < 1 then
		-- 缩放比例太小可能会导致界面太窄，所以列数要适当扩大
		self.minColumns = round(self.minColumns / self.scale)
	end
	self.columns = max(profile.columns or self.minColumns, self.minColumns)

	self.numItems = 0
	for _, items in pairs(self.bagSlots) do
		self.numItems = self.numItems + #items
	end

	local minHeight, borderTopBottom, borderLeftRight = self:GetParent():GetMinHeightAndBorder()

	-- 宽度不能拉的太长
	self.maxColumns = max(self.minColumns, ceil(
		self.numItems / floor(
			(minHeight - borderTopBottom) / self:GetParent():GetButtonScaleSize()
		)
	)) + 10
	self.columns = min(self.columns, self.maxColumns)

	return self.columns, self.scale
end

function ItemFrame:BagBreak()
end
