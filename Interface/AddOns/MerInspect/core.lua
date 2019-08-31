
InspectFrame_LoadUI();

MerInspect = BLibrary("BEvent");
local M = MerInspect;
M.Local = GetLocale();
M.author = "Mermaid";
M.version = "2.2.0";
M._DEBUG = false;
M.Config = {
	["MerInspectEnable"] = true,	
	["DisplayDurability"] = true,	-- 显示装备栏耐久度及维修费用
	["DisplayItemQulity"] = true,
};

M.PercentList = {};
M.QueueScan = {};
M.QueueShow = {};

M.effectPercent = {};
M.effect = {};
M.set = {};

function M:DoQueueScan(unit)
	for k in pairs(self.set) do
		self.set[k] = nil;
	end
	for k in pairs(self.effect) do
		self.effect[k] = nil;
	end
	for k in pairs(self.effectPercent) do
		self.effectPercent[k] = nil;
	end
	local level = UnitLevel(unit) or 70;
	local class = strupper(select(2, UnitClass(unit)));
	local race = strupper(select(2, UnitRace(unit)));
	for _, v in ipairs({"Strength","Agility","Stamina","Intellect","Spirit",
		"Resistance_Nature","Resistance_Fire","Resistance_Arcane","Resistance_Shadow","Resistance_Frost"}) do
		self.effect[v] = (self.effect[v] or 0) + self:GetBaseEffect(v, class, race, level);
	end
	for _, v in ipairs(self.QueueScan) do
		if self[v] then
			self[v](self, unit, class, race, level);
		end
	end
end

function M:DoQueue(unit)
	if (not UnitExists(unit)) or (not UnitIsPlayer(unit)) then
		return;
	end
	
	local level = UnitLevel(unit);
	local class = strupper(select(2, UnitClass(unit)));
	local race = strupper(select(2, UnitRace(unit)));
	for _, v in ipairs(self.QueueShow) do
		if self[v] then
			self[v](self, unit, class, race, level);
		end
	end
end
--[[
	PercentEffect effect依赖与别的属性, 与其依赖属性是线性关系. 
	例如: 牧师的精神与法术伤害的关系
]]
function M:GetPercentEffect(anchor, ...)
	local effect, value, type;
	for i = 1, select("#", ...) do
		effect, value, type = strsplit("#",select(i, ...) or "");
		if (type and type == "sub") then
			self.effectPercent[effect] = (self.effectPercent[effect] or 0) - floor((self.effect[anchor] or 0) * (tonumber(value) or 0));
		else
			self.effectPercent[effect] = (self.effectPercent[effect] or 0) + floor((self.effect[anchor] or 0) * (tonumber(value) or 0));
		end
	end
end
--------------------
-- 7/2/2008 加入类型, 缺省为加. 以适应类似"惡魔知識"这样的带有负面效果的天赋.
-- 累加类型type为nil
-- 减类型type为true, 用sub标示
function M:SetPercentEffect(anchor, effect, value, type)
	if (not effect or not value) then return; end

	if self.PercentList[anchor] then
		if strfind(self.PercentList[anchor], (type and effect.."#(%d%.?%d*)#sub") or effect.."#(%d%.?%d*)") then
			oldV = strmatch(self.PercentList[anchor], effect.."#(%d%.?%d*)");
			newV = oldV+ value;
			self.PercentList[anchor] = gsub(self.PercentList[anchor], effect.."#"..oldV, effect.."#"..newV)
		else
			self.PercentList[anchor] = self.PercentList[anchor] .. "|" .. effect .. "#" .. value .. (type and "#sub" or "");
		end
	else
		self.PercentList[anchor] = effect .. "#" .. value .. (type and "#sub" or "");
	end
end

function M:AddPercentEffect()
	for k, v in pairs(self.PercentList) do
		self:GetPercentEffect(k, strsplit("|",v));
		self.PercentList[k] = nil;
	end
	for k, v in pairs(self.effectPercent) do
		self.effect[k] = (self.effect[k] or 0) + v;
	end
end
  
function M:GetBaseEffect(effect, class, race, level)
	if not class or not race or level ~= 70 then return 0 end
	return self.base[class.."_"..race] and self.base[class.."_"..race][effect] or 0;
end

function M:StatLogic(l,c,r)
	local value;
	for effect, func in pairs(self.logic) do
		value = self:GetEffect(effect);
		func(value, self, l, c, r);
	end	
end

function M:JoinEffect(...)
	local effect = 0
	for i = 1, select("#", ...) do
		effect = effect + self:GetEffect(select(i, ...));
	end
	return select(1, ...), effect, self:GetEffect(select(2, ...));
end

function M:GetEffect(effect)
	return self.effect[effect] or 0;
end

function M:DEBUG(...)
	if (self._DEBUG) then
		for i = 1, select("#",...) do
			ChatFrame1:AddMessage(select(i,...));
		end
	end
end