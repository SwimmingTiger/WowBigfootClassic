--==============================================================================
-- BigFoot.lua ver 1.00
-- 日期：2008-2-1
-- 作者：独孤傲雪
-- 描述：为该插件提供StatCompare模式的界面，方便对比。
-- 版权所有：艾泽拉斯国家地理
--==============================================================================

-- InspectFrame_LoadUI();

MerInspect = BLibrary("BEvent");
local M = MerInspect;
local __Secure = BLibrary("BSecureHook");

local Repair_Cost = "Repair Cost"
if GetLocale() == "zhCN" then
	Repair_Cost = "维修费用"
elseif GetLocale() == "zhTW" then
	Repair_Cost = "維修費用"
end

-----------------------
-- 以下显示装备栏耐久度以及高亮物品边框
M.InventorySlots = {
	"HeadSlot|d",
	"NeckSlot|n",
	"ShoulderSlot|d",
	"ShirtSlot|n",
	"ChestSlot|d",
	"WaistSlot|d",
	"LegsSlot|d",
	"FeetSlot|d",
	"WristSlot|d",
	"HandsSlot|d",
	"Finger0Slot|n",
	"Finger1Slot|n",
	"Trinket0Slot|n",
	"Trinket1Slot|n",
	"BackSlot|n",
	"MainHandSlot|d",
	"SecondaryHandSlot|d",
	"RangedSlot|d",
	"TabardSlot|n",
};

local ITEM_COLOR = {
	[0] = { r = 0.8, g = 0.8, b = 0.8, a = 0.8},
	[1] = { r = 0.5, g = 0.5, b = 0.5, a = 0.8},
	[2] = { r = 0, g = 1.0, b = 0, a = 0.8},
	[3] = { r = 0, g = 0.0, b = 1.0, a = 0.8},
	[4] = { r = 0.5, g = 0, b = 1.0, a = 0.8},
	[5] = { r = 1.0, g = 0.5, b = 0, a = 0.8},
	[6] = { r = 1.0, g = 0, b = 0, a = 0.8},
	[7] = { r = 1, g = 1, b = 0, a = 0.6 },
	[9] = { r = 1, g = 1, b = 0, a = 0.6 },
};

function M:DisplayInvenrotyInfo()
	self.tooltip2 = self.tooltip2 or CreateFrame("GameTooltip", "MerDurabilityTooltip", UIParent, "GameTooltipTemplate");
	local button, count, c, m, p, hasItem, itemLink, repairCos, totalCos, quality, suffix, scan;
	for i, v in ipairs(self.InventorySlots) do
		suffix, scan = strsplit("|", v);
		button = getglobal("Character" .. suffix)
		count = button.Count;
		count:Hide()
		button.durability = ""
		button.border:Hide();
		self.tooltip2:SetOwner(UIParent, "ANCHOR_NONE");
		self.tooltip2:ClearLines();
		hasItem, _, repairCos = self.tooltip2:SetInventoryItem("player", button:GetID());
		itemLink = select(2, self.tooltip2:GetItem());
		if (hasItem and  itemLink) then
			if scan == "d" then
				-- 汇总修理费用
				totalCos = (totalCos or 0) + repairCos;
				c, m = GetInventoryItemDurability(button:GetID());
				if (c and m and m > 0) then
					p = c / m;
					count:SetFormattedText("%d%%", floor(p * 100));
					button.durability=format("%d%%", floor(p * 100));
					if (p > 0.5) then
						count:SetTextColor(0.133, 0.78, 0.133);
					elseif (p > 0.25) then
						count:SetTextColor(1, 0.7 ,0.2);
					else
						count:SetTextColor(1, 0, 0);
					end
					count:Show()
				end
			end
			-- 高亮边框
			quality = select(3, GetItemInfo(itemLink));
			if (type(quality) == "number" and quality > 1) then
				button.border:SetVertexColor(ITEM_COLOR[quality].r, ITEM_COLOR[quality].g, ITEM_COLOR[quality].b);
				button.border:Show();
			end
		end
	end
	if totalCos == 0 then
		MerRepairMoneyFrame:Hide()
	else
		MoneyFrame_Update("MerRepairMoneyFrame", totalCos or 0);
		MerRepairMoneyFrame:Show()
	end
end

function M:DisplayInspectPaperDollFrame(button)
	if not button then return end
	local unit = InspectFrame.unit;
	local itemLink, quality;
	button.border:Hide();
	itemLink = GetInventoryItemLink(unit, button:GetID());
	if (button.hasItem and itemLink) then
		-- 高亮边框
		quality = select(3, GetItemInfo(itemLink));
		if (type(quality) == "number" and quality > 1) then
			button.border:SetVertexColor(ITEM_COLOR[quality].r, ITEM_COLOR[quality].g, ITEM_COLOR[quality].b);
			button.border:Show();
		end
	end
end

local function CreateBorder(name, v)
	local button = getglobal(name .. v);
	button.border = button:CreateTexture(button:GetName() .. "Border", "OVERLAY");
	button.border:SetAllPoints(button:GetNormalTexture());
	button.border:SetTexture("Interface\\AddOns\\MerInspect\\Border");
	local count = button.Count;
	count:ClearAllPoints();
	count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, 3);
end

local function createRepairCostFrame()
	if MerRepairMoneyFrame then return end
	local s;
	for k, v in pairs(M.InventorySlots) do
		s = strsplit("|", v);
		CreateBorder("Character", s);
	end
	M.moneyFrame = CreateFrame("Frame", "MerRepairMoneyFrame", PaperDollFrame, "SmallMoneyFrameTemplate");
	M.moneyFrame:SetPoint("BOTTOMLEFT", CharacterAttributesFrame, "TOPLEFT", 4, 24);

	M.moneyFrame.title = M.moneyFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	M.moneyFrame.title:SetPoint("BOTTOMLEFT", M.moneyFrame, "TOPLEFT", -2, 2);
	M.moneyFrame.title:SetText(Repair_Cost);

	M.moneyFrame:SetScript("OnShow", function(self)
		MoneyFrame_SetType(self,"STATIC");
	end);
end

M:Init{
	name = "MerInspect",
	func = function()
		if not InspectTalentFrameSpentPoints then
			InspectTalentFrameSpentPoints = CreateFrame("Frame")
		end
		M.tooltip2 = CreateFrame("GameTooltip", "MerDurabilityTooltip", UIParent, "GameTooltipTemplate");
		__Secure:HookScript(PaperDollFrame,"OnShow", function()
			createRepairCostFrame()
			M:DisplayInvenrotyInfo();
		end);
		hooksecurefunc("SetItemButtonCount",function(button,...)	-- 防止耐久度的提示会被游戏本身update掉
			if not button then return end
			if button and button.durability then
				getglobal(button:GetName().."Count"):SetText(button.durability)
				getglobal(button:GetName().."Count"):Show()
			end
		end);
		hooksecurefunc("PaperDollItemSlotButton_OnEvent",function(self, event, ...)
			if ( event == "PLAYER_EQUIPMENT_CHANGED") then
				local arg1 = ...;
				if ( self:GetID() == arg1 ) then
					M:DisplayInvenrotyInfo()
				end
			end
		end);
		local inspectFrame_Load
		hooksecurefunc("InspectUnit",function(unit)
			if inspectFrame_Load then return end
			local s;
			for k, v in pairs(M.InventorySlots) do
				s = strsplit("|", v);
				CreateBorder("Inspect", s);
			end
			hooksecurefunc("InspectPaperDollItemSlotButton_Update",function(button)
				M:DisplayInspectPaperDollFrame(button);
			end);
			inspectFrame_Load = true
		end);
		local LibEvent = LibStub:GetLibrary("LibEvent.7000")
		__Secure:HookScript(GearManagerDialog,"OnShow", function()
			if PaperDollFrame.inspectFrame then
				PaperDollFrame.inspectFrame:Hide();
			end
			LibEvent:trigger("TogglePlayerStatsFrame", PaperDollFrame, false)
		end);
		__Secure:HookScript(GearManagerDialog,"OnHide", function()
			if PaperDollFrame.inspectFrame then
				PaperDollFrame.inspectFrame:Show();
			end
			LibEvent:trigger("TogglePlayerStatsFrame", PaperDollFrame, true)
		end);
	end
};
