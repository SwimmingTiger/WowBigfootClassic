--[[
	itemGroup.lua
		Modifies the item frame to always fit inside the panel
--]]

local ADDON, Addon = ...
local ItemGroup = Addon.ItemGroup

-- 老虎会游泳：新增函数
local function round(n)
	return math.floor((math.floor(n*2) + 1)/2)
end

-- 老虎会游泳：重新实现，防止背包边框与物品格子之间产生空隙
function ItemGroup:LayoutTraits()
	local profile = self:GetProfile()
	self.scale = profile.itemScale or 1

	self.minColumns = 7
	if self.scale < 1 then
		-- 缩放比例太小可能会导致界面太窄，所以列数要适当扩大
		self.minColumns = round(self.minColumns / self.scale)
	end
	self.columns = max(profile.columns or self.minColumns, self.minColumns)

	self.numItems = 0
	for _, items in pairs(self.buttons) do
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
