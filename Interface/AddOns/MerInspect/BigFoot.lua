--==============================================================================
-- BigFoot.lua ver 1.00
-- 日期：2008-2-1
-- 作者：独孤傲雪
-- 描述：为该插件提供StatCompare模式的界面，方便对比。
-- 版权所有：艾泽拉斯国家地理
--==============================================================================
local M = MerInspect;
local __Secure = BLibrary("BSecureHook");
local MerInspect_ColorList = {
	[1] = '|CFFFFD200',		-- attributes
	[2] = '|CFF20FF20',		-- skills
	[3] = '|CFFFFFFFF',		-- melee
	[4] = '|CFF00C0C0',		-- ranged
	[5] = '|CFFFFFF00',		-- spells
	[6] = '|CFFFF60FF',		-- arcane
	[7] = '|CFFFF3600',		-- fire
	[8] = '|CFF00C0FF',		-- frost
	[9] = '|CFFFFA400',		-- holy
	[10] = '|CFF00FF60',	-- nature
	[11] = '|CFFAA12AC',	-- shadow
	[12] = '|CFF20FF20',	-- life
	[13] = '|CFF6060FF',	-- mana
};

M.shownlist = {
	--[[
		effect: 属性
		color: 显示色彩
		cat: 类别
	]]
	-- 基础属性
	{ effect = "Strength",	color = 1, pt_api = "UnitStat", pt_args = {"player", 1}, pt_unit = "player", cat = "Attribute" },
	{ effect = "Agility",	color = 1, pt_api = "UnitStat", pt_args = {"player", 2}, pt_unit = "player", cat = "Attribute" },
	{ effect = "Stamina",	color = 1, pt_api = "UnitStat", pt_args = {"player", 3}, pt_unit = "player", cat = "Attribute" },
	{ effect = "Intellect",	color = 1, pt_api = "UnitStat", pt_args = {"player", 4}, pt_unit = "player", cat = "Attribute" },
	{ effect = "Spirit",	color = 1, pt_api = "UnitStat", pt_args = {"player", 5}, pt_unit = "player", cat = "Attribute" },
	{ effect = "Armor",		color = 1, pt_api = "UnitArmor", pt_args = {"player"}, pt_unit = "player", cat = "Attribute" },
	{ effect = "Resilience",color = 1, cat = "Attribute" },
	{ effect = "ArmorReduce",color = 3, cat = "Attribute", precent = true},
	-- 抗性
	{ effect = "Resistance_Arcane",	color = 6, cat = "Resistance" },
	{ effect = "Resistance_Fire",	color = 7, cat = "Resistance" },
	{ effect = "Resistance_Nature", color = 10, cat = "Resistance" },
	{ effect = "Resistance_Frost",	color = 8, cat = "Resistance" },
	{ effect = "Resistance_Shadow",	color = 11, cat = "Resistance" },

	{ effect = "Resistance_Holy", 	color = 9, cat = "Resistance" },
	{ effect = "Resistance_Coma", 	color = 3, cat = "Resistance" },
	{ effect = "ReduceResistance",	format = "-%d",	color = 1, cat = "Resistance" },--
	-- 近战&远程
	{ effect = "defense",				color = 3, cat = "Attack" },
	{ effect = "Dodge",				color = 3, cat = "Attack", precent = true },
	{ effect = "Parry",				color = 3, cat = "Attack", precent = true },
	{ effect = "Block",				color = 3, cat = "Attack", precent = true },
	{ effect = "HitRating",			color = 3, cat = "Attack", precent = true },
	{ effect = "AttackDamage",		color = 3, cat = "Attack" },
	{ effect = "AttackSpeed",		color = 3, cat = "Attack" },
	{ effect = "AttackPower",		color = 3, cat = "Attack" },
	{ effect = "AttackCrit",		color = 3, cat = "Attack", precent = true },
	{ effect = "HasteMelee",		color = 3, cat = "Attack", precent = true },
	{ effect = "RangedAttackDamage",color = 4, cat = "Attack" },
	{ effect = "RangedAttackSpeed", color = 4, cat = "Attack" },
	{ effect = "RangedAttackPower", color = 4, cat = "Attack" },
	{ effect = "RangedAttackCrit",	color = 4, cat = "Attack", precent = true },
	{ effect = "HasteRanged",		color = 4, cat = "Attack", precent = true },
	-- 法术
	{ effect = "SpellPower", 		color = 5,	cat = "Spell" },
	{ effect = "Healing", 			color = 5,	cat = "Spell" },
	{ effect = "SpellHitRating",	color = 5,	cat = "Spell", precent = true },
	{ effect = "SpellCrit", 		color = 5,	cat = "Spell", precent = true },
	{ effect = "SpellStrike", 		color = 5,	cat = "Spell" },
	{ effect = "HasteSpell", 		color = 5,	cat = "Spell", precent = true },
	{ effect = "Damage_Arcane&SpellDamage",	color = 6,	cat = "Spell" },
	{ effect = "Damage_Fire&SpellDamage",	color = 7,	cat = "Spell" },
	{ effect = "Damage_Frost&SpellDamage",	color = 8,	cat = "Spell" },
	{ effect = "Damage_Holy&SpellDamage",	color = 9,	cat = "Spell" },
	{ effect = "Damage_Nature&SpellDamage",	color = 10,	cat = "Spell" },
	{ effect = "Damage_Shadow&SpellDamage",	color = 11,	cat = "Spell" },
	-- 生命&法力
	{ effect = "HP",				color = 12, cat = "Health" },--
	{ effect = "Mana",				color = 13, cat = "Health" },--
	{ effect = "HealthRestore",	format = "%s HP/5s", color = 12, cat = "Health" },
	{ effect = "ManaRestore",	format = "%s MP/5s", color = 13, cat = "Health" },
};
-- Create Frames
function M:CreateCompareFrame(name)
	local f = CreateFrame("Frame", name, UIParent);
	f:Hide();
	f:SetToplevel(true);
	f:SetMovable(true);
	f:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", tile = false,
		tileSize = 16, edgeSize = 16, insets = { left = 5, right = 5, top = 5, bottom = 5 }
	});
	f.title = f:CreateFontString(name .. "Title", "ARTWORK", "GameTooltipHeaderText");
	f.title:SetPoint("TOPLEFT", name, "TOPLEFT", 10, -10);
	f.text = f:CreateFontString(name .. "Text", "ARTWORK", "GameTooltipText");
	f.text:SetPoint("BOTTOMLEFT", name, "BOTTOMLEFT", 10, 10);
	f.close = CreateFrame("Button", name .. "Close", getglobal(name), "UIPanelCloseButton");
	f.close:SetPoint("TOPRIGHT", name, "TOPRIGHT", -1, -1);
	f:SetScript("OnMouseDown", function(self)
		if (not self.ismoving) then
			self.ismoving = true;
			self:StartMoving();
		end
	end);
	f:SetScript("OnMouseUp", function(self)
		if (self.ismoving) then
			self.ismoving = false;
			self:StopMovingOrSizing();
		end
	end);
	f.close:SetScript("OnClick", function(self)
		self:GetParent():Hide();
	end);
	return f;
end

M.SC = M:CreateCompareFrame("MerInspectSlefFrame");
M.TC = M:CreateCompareFrame("MerInspectTargetFrame");

function M:GetTooltipText(unit, talent)
	if (not UnitExists(unit) or not UnitIsPlayer(unit)) then
		return;
	end

	local relstr, lastcat, key, value, base;
	local level = UnitLevel(unit);
	local class = strupper(select(2, UnitClass(unit)));
	local race = strupper(select(2, UnitRace(unit)));
	local prefix = (level == 70) and "" or "+";

	self:DoQueueScan(unit);
	-- 在可观察天赋时需要累计上天赋加成
	if (talent) then
--		self:ScanUnitTalent(unit, class, race, level, (unit ~= "player"));
		self:AddPercentEffect();
	end
	self:StatLogic(level, class, race);
	local relstr = "";
	for k, v in ipairs(self.shownlist) do
		local point = 0;
		local base = 0;

		if (self.effect[v.effect] and ((v.pt_api and v.pt_unit == unit) or self.effect[v.effect] ~= 0)) then
			if (not lastcat or lastcat ~= v.cat) then
				lastcat = v.cat;
				if (relstr == "") then
					relstr = relstr .. "\n" .. GREEN_FONT_COLOR_CODE .. self.loc[v.cat] .. "|r";
				else
					relstr = relstr .. "\n\n" .. GREEN_FONT_COLOR_CODE .. self.loc[v.cat] .. "|r";
				end
			end

			if (self.effect[v.effect] ~= 0) then
				value = v.precent and format("%0.2f%%", self:GetEffect(v.effect)) or self:GetEffect(v.effect);
				value = v.format and format(v.format, value) or value;
			else
				value = 0;
			end

			if (v.pt_api and (v.pt_unit == unit or v.pt_unit == nil)) then
				point = getglobal(v.pt_api)(unpack(v.pt_args));
			end

			if (point ~= 0 and point ~= nil) then
				if (value == nil) then
					base = point;
				else
					base = point - value;
				end
			else
				base = 0;
			end

			if (base == 0) then
				if (value ~= 0 and value ~= nil) then
					relstr = relstr .. "\n" .. MerInspect_ColorList[v.color] .. self.loc[v.effect] .. "|r" .. prefix .. value;
				end
			else
				if (value ~= 0 and value ~= nil) then
					relstr = relstr .. "\n" .. MerInspect_ColorList[v.color] .. self.loc[v.effect] .. "|r" .. base .. " (" .. "|cFF00FF00" .. prefix .. value .. "|r)";
				else
					relstr = relstr .. "\n" .. MerInspect_ColorList[v.color] .. self.loc[v.effect] .. "|r" .. base;
				end
			end
		else
			key, value, base = self:JoinEffect(strsplit("&", v.effect));
			if (key and self.effect[key] and value and value ~= 0 and value ~= base) then
				relstr = relstr .. "\n" .. MerInspect_ColorList[v.color] .. self.loc[key] .. "|r" .. prefix .. value;
			end
		end

		if (v.effect == "Mana" and UnitPowerType(unit) == 0) then
			relstr = relstr .. "\n" .. MerInspect_ColorList[v.color] .. self.loc[v.effect] .. "|r" ..  UnitPowerMax(unit) or "????";
		end
	end

	local i = 1;
	for k, v in pairs(self.set) do
		if (i == 1 and v) then
			relstr = relstr .. "\n\n" .. GREEN_FONT_COLOR_CODE .. self.loc.set .. "|r";
		end
		relstr = relstr .. "\n" .. v .. k;
		i = i + 1
	end
	return relstr;
end

local function showFrame(frame, unit, target, title, text, xoff, yoff)
	frame.title:SetText(title);
	frame.text:SetText(text);

	height = frame.text:GetHeight();
	width = frame.text:GetWidth();
	if(width < frame.title:GetWidth()) then
		width = frame.title:GetWidth();
	end

	frame:SetHeight(height+30);
	frame:SetWidth(width+30);
	frame:ClearAllPoints();
	frame:SetPoint("TOPLEFT", target, "TOPRIGHT", xoff, yoff);
	frame:Show();
end

function M:OnShowInspectFrame(talent)
	if(self.Config.MerInspectEnable and InspectFrame.unit and UnitExists(InspectFrame.unit) and UnitIsPlayer(InspectFrame.unit)) then
		title = UnitName("player");
		text = self:GetTooltipText("player", talent);
		if (title and text) then
			-- showFrame(self.SC, "player", self.TC, title, text, 0, 0);
		end

		local title = UnitName(InspectFrame.unit);
		local text = self:GetTooltipText(InspectFrame.unit, talent);
		if (title and text) then
			-- showFrame(self.TC, InspectFrame.unit, InspectFrame, title, text, -30, -12);
		end

		M:DisplayInvenrotyInfo(InspectFrame.unit or "target");
	end
end

function M:OnShowPaperFrame(talent)
	if (self.Config.MerInspectEnable) then
		local title = UnitName("player");
		local text = self:GetTooltipText("player", talent);
		if (title and text) then
			-- showFrame(self.SC, "player", PaperDollFrame, title, text, -30, -12);
		end
	end
end
-----------------------
-- 以下显示装备栏耐久度以及高亮物品边框
M.InventorySlots = {
	"HeadSlot|d",
	"NeckSlot|n",
	"ShoulderSlot|d",
	"BackSlot|n",
	"ChestSlot|d",
	"ShirtSlot|n",
	"TabardSlot|n",
	"WristSlot|d",
	"HandsSlot|d",
	"WaistSlot|d",
	"LegsSlot|d",
	"FeetSlot|d",
	"Finger0Slot|n",
	"Finger1Slot|n",
	"Trinket0Slot|n",
	"Trinket1Slot|n",
	"MainHandSlot|d",
	"SecondaryHandSlot|d",
	"RangedSlot|d",
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

function M:DisplayInvenrotyInfo(unit)
	if (not self.Config.MerInspectEnable) then return end

	local unit = unit or "player";
	local button, count, c, m, p, hasItem, itemLink, repairCos, totalCos, quality, suffix, scan;
	for i, v in ipairs(self.InventorySlots) do
		suffix, scan = strsplit("|", v);
		button = (unit == "player") and getglobal("Character" .. suffix) or getglobal("Inspect" .. suffix);
		count = getglobal(button:GetName() .. "Count");
		self.tooltip2:SetOwner(UIParent, "ANCHOR_NONE");
		self.tooltip2:ClearLines();
		hasItem, _, repairCos = self.tooltip2:SetInventoryItem(unit, button:GetID());
		itemLink = select(2, self.tooltip2:GetItem());
		if (hasItem and  itemLink) then
			if (self.Config.DisplayDurability and unit == "player" and scan == "d") then
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
				else
					button.durability=""
					count:Hide()
				end
			else
				button.durability=""
				count:Hide()

			end
			-- 高亮边框
			if (self.Config.DisplayItemQulity) then
				quality = select(3, GetItemInfo(itemLink));
				if (type(quality) == "number" and quality > 1) then
					button.border:SetVertexColor(ITEM_COLOR[quality].r, ITEM_COLOR[quality].g, ITEM_COLOR[quality].b);
					button.border:Show();
				else
					button.border:Hide();
				end
			end
		else
			button.durability=""
			count:Hide()
			button.border:Hide();
		end
	end
	if totalCos == 0 then
		MerRepairMoneyFrame:Hide()
	else
		MoneyFrame_Update("MerRepairMoneyFrame", totalCos or 0);
		MerRepairMoneyFrame:Show()
	end
end

function M:DisplayInspectPaperDollFrame()
	if (not self.Config.MerInspectEnable) then return end

	local button, count, c, m, p, hasItem, itemLink, repairCos, totalCos, quality, suffix, scan;
	for i, v in ipairs(self.InventorySlots) do
		suffix, scan = strsplit("|", v);
		button = getglobal("Inspect" .. suffix);
		count = getglobal(button:GetName() .. "Count");
		self.tooltip2:SetOwner(UIParent, "ANCHOR_NONE");
		self.tooltip2:ClearLines();
		hasItem, _, repairCos = self.tooltip2:SetInventoryItem(InspectFrame.unit, button:GetID());
		itemLink = select(2, self.tooltip2:GetItem());
		if (hasItem and itemLink) then
			-- 高亮边框
			if (self.Config.DisplayItemQulity) then
				quality = select(3, GetItemInfo(itemLink));
				if (type(quality) == "number" and quality > 1) then
					button.border:SetVertexColor(ITEM_COLOR[quality].r, ITEM_COLOR[quality].g, ITEM_COLOR[quality].b);
					button.border:Show();
				else
					button.border:Hide();
				end
			end
		else
			button.durability=""
			count:Hide()
			button.border:Hide();
		end
	end
end

local function CreateBorder(name, v)
	local button = getglobal(name .. v);
	button.border = button:CreateTexture(button:GetName() .. "Border", "OVERLAY");
	button.border:SetAllPoints(button:GetNormalTexture());
	button.border:SetTexture("Interface\\AddOns\\MerInspect\\Border");
	count = getglobal(button:GetName() .. "Count");
	--count:SetFontObject("NumberFontNormal");
	count:ClearAllPoints();
	count:SetPoint("BOTTOMRIGHT", button, "BOTTOMRIGHT", 2, 3);
	button.border:Hide();
end

M:Init{
	name = "MerInspect",
	func = function()
		M.tooltip2 = CreateFrame("GameTooltip", "MerDurabilityTooltip", UIParent, "GameTooltipTemplate");
		local s;
		for k, v in pairs(M.InventorySlots) do
			s = strsplit("|", v);
			CreateBorder("Character", s);
			CreateBorder("Inspect", s);
		end
		M.moneyFrame = CreateFrame("Frame", "MerRepairMoneyFrame", PaperDollFrame, "SmallMoneyFrameTemplate");
		M.moneyFrame:SetPoint("BOTTOMLEFT", CharacterAttributesFrame, "TOPLEFT", 4, 11);

		M.moneyFrame:SetScript("OnShow", function(self)
			MoneyFrame_SetType(self,"STATIC");
		end);
		M.moneyFrame.title = M.moneyFrame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
		M.moneyFrame.title:SetPoint("BOTTOMLEFT", M.moneyFrame, "TOPLEFT", -2, 2);
		M.moneyFrame.title:SetText(M.loc["Repair Cost"]);
		__Secure:HookScript(PaperDollFrame,"OnShow", function()
			M:OnShowPaperFrame(true);
			M:DisplayInvenrotyInfo();
		end);
		__Secure:HookScript(InspectPaperDollFrame,"OnShow", function()
			M:DisplayInspectPaperDollFrame();
		end);
		hooksecurefunc("SetItemButtonCount",function(button,...)
			if not button then return end
			if button and button.durability then
				getglobal(button:GetName().."Count"):SetText(button.durability)
				getglobal(button:GetName().."Count"):Show()
			end
		end);
		__Secure:HookScript(PaperDollFrame,"OnHide", function() M.SC:Hide() end);
		__Secure:HookScript(InspectFrame,"OnHide", function() M.SC:Hide() M.TC:Hide() end);
		hooksecurefunc("ClearInspectPlayer", function () M.SC:Hide() M.TC:Hide() end);
	end
};