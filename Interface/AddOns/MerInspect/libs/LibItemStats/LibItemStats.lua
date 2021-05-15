
---------------------------------
-- 經典版物品屬性统计 Author: M
---------------------------------

local MAJOR, MINOR = "LibItemStats.1000", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

--语言
local patterns = LibItemStatsPatterns or {
    ignore    = {},
    multiple  = {},
    recursive = {},
    general   = {},
    extra     = {},
    percent   = {},
    special   = {},
    buff      = {},
    talent    = {},
}
local L = LibItemStatsLocale or {}

--Toolip
local tooltip = CreateFrame("GameTooltip", "ClassicLibItemStatsTooltip1", UIParent, "GameTooltipTemplate")
local unittip = CreateFrame("GameTooltip", "ClassicLibItemStatsTooltip2", UIParent, "GameTooltipTemplate")

local strfind  = string.find
local strmatch = string.match
local strupper = string.upper
local tinsert  = table.insert
local strsplit = strsplit

--静态值属性
local function SetStaticValue(stats, value, ...)
    if (not stats.static) then stats.static = {} end
    for i = 1, select("#", ...) do
        if (not stats.static[select(i,...)]) then
            stats.static[select(i,...)] = { value = 0, final = nil }
        end
        stats.static[select(i,...)].value = stats.static[select(i,...)].value + (tonumber(value) or 0)
	end
end

--静态值并设置为完整值
local function SetStaticValueAndFinal(stats, value, key)
    SetStaticValue(stats, value, key)
    stats.static[key].final = true
end

--百分比属性
local function SetPercentValue(stats, value, baseon, key)
    if (not stats.percent) then stats.percent = {} end
    tinsert(stats.percent, {key = key, baseon = baseon, value = value})
end

--套装
local function SetSuitValue(stats, value, colorStr)
    if (not stats.suit) then stats.suit = {} end
    local found = false
    for _, v in ipairs(stats.suit) do
        if (v.value == value) then
            found = true
        end
    end
    if (not found) then
        tinsert(stats.suit, { value = value, colorStr = colorStr })
    end
end

--计算最终属性值
local function CalculateStatLogic(unit, stats)
    --step1 处理百分比属性
    if (stats.percent) then
        stats.percentValues = {}
        for _, v in ipairs(stats.percent) do
            if (not stats.percentValues[v.key]) then
                stats.percentValues[v.key] = 0
            end
            stats.percentValues[v.key] = stats.percentValues[v.key] + (stats.static[v.baseon] and stats.static[v.baseon].value or 0) * v.value / 100
        end
        --百分比加成累加到 static
        for k, v in pairs(stats.percentValues) do
            SetStaticValue(stats, floor(v), k)
        end
    end
    --step2 换算%

    return stats
end

--装备属性: 逐条根据文字解析
local function GetStats(text, r, g, b, stats, link)
    local v, v1, v2, txt, txt1, txt2
    --套装
    if strfind(text, "%(%d/%d%)") or strfind(text, "（%d/%d）") then
        return SetSuitValue(stats, text, select(3, strfind(link or "","(|c%x+)|Hitem:.-|h|r")) or "|cffffffff")
    end
    --灰色属性不统计
    if r < 0.6 and g < 0.6 and b < 0.6 then return end
    --不用统计的先排除
    for _, p in ipairs(patterns.ignore) do
		if strfind(text, p) then return end
	end
    --多属性
    for _, p in ipairs(patterns.multiple) do
		if strfind(text, p.pattern) then
            v1, v2, txt = strmatch(text, p.pattern)
            SetStaticValue(stats, v1, strsplit("|",p.key1))
            SetStaticValue(stats, v2, strsplit("|",p.key2))
            if (txt and txt ~= "") then
                GetStats("X" .. txt, r, g, b, stats, link)
            end
            return
        end
	end
    --递归的
    for _, p in ipairs(patterns.recursive) do
		if strfind(text, p) then
            txt1, txt2 = strmatch(text, p)
            GetStats(txt1, r, g, b, stats, link)
            GetStats(txt2, r, g, b, stats, link)
            return
        end
	end
    --常规属性 +xx
    if strfind(text, "%+(%d+)") then		
		v = strmatch(text, "%+(%d+)")
		for _, p in ipairs(patterns.general) do
			if strfind(text, p.pattern) then
				SetStaticValue(stats, v, strsplit("|",p.key))
				break
			end
		end
		return
	end
    --描述属性
    for _, p in ipairs(patterns.extra) do
		if strfind(text, p.pattern) then
            v = strmatch(text, p.pattern)
            SetStaticValue(stats, v, strsplit("|",p.key))
            return
        end
	end
    --百分比属性
    for _, p in ipairs(patterns.percent) do
		if strfind(text, p.pattern) then
			v = strmatch(text, p.pattern)
            SetPercentValue(stats, v, p.baseon, p.key)
			return
		end
	end
    --特殊值属性
    for _, p in ipairs(patterns.special) do
		if strfind(text, p.pattern) then
            SetStaticValue(stats, p.value, strsplit("|",p.key))
            if (not p.continue) then break end
        end
        return
	end
end

--BUFF属性: 逐条解析
local function GetBuffStats(text, stats)
    local v, txt1, txt2
    for _, p in ipairs(patterns.buff.convert or {}) do
		text = gsub(text, p.from, p.to)
	end
	if strfind(text, ",") then
        for txt1 in string.gmatch(text, "[^,]+") do
            GetBuffStats(txt1 or "", stats)
        end
		return
	end
	for _, p in ipairs(patterns.buff) do
		if strfind(text, p.pattern) then
			v = strmatch(text, p.pattern)
			if (v and tonumber(v) > 0) then
				for key in string.gmatch(p.key, "[^|]+") do
					if p.percent then
                        SetPercentValue(stats, v, p.baseon or key, key)
					else
						SetStaticValue(stats, v, key)
					end
				end
			end
		end
	end	
end

--读取UNIT的Buff加成
function lib:GetUnitBuffStats(unit, stats)
    if (type(stats) ~= "table") then stats = {} end
    local text
	local i = 1
	while UnitBuff(unit, i) do
		tooltip:SetOwner(UIParent, "ANCHOR_NONE")
		tooltip:ClearLines()
		tooltip:SetUnitBuff(unit, i)
		for j = 2, tooltip:NumLines() do			
			text = _G[tooltip:GetName() .."TextLeft" .. j]:GetText()
			GetBuffStats(text, stats)
		end	
		i = i + 1;
	end
end

--读取天赋加成 @todo
function lib:GetUnitTalentStats(unit, stats, class, race, level)
    
end

--读取种族及初始属性加成
function lib:GetUnitRaceStats(unit, stats, class, race, level)
    --抗性
    SetStaticValueAndFinal(stats, 0, "ResistanceArcane")
    SetStaticValueAndFinal(stats, 0, "ResistanceFire")
    SetStaticValueAndFinal(stats, 0, "ResistanceNature")
    SetStaticValueAndFinal(stats, 0, "ResistanceFrost")
    SetStaticValueAndFinal(stats, 0, "ResistanceShadow")
    SetStaticValueAndFinal(stats, 0, "ResistanceHoly")
    if (race == "Gnome") then
        SetStaticValueAndFinal(stats, 10, "ResistanceArcane")
    elseif (race == "NightElf" or race == "Tauren") then
        SetStaticValueAndFinal(stats, 10, "ResistanceNature")
    elseif (race == "Dwarf") then    
        SetStaticValueAndFinal(stats, 10, "ResistanceFrost")
    elseif (race == "Scourge" or race == "Draenei") then
        SetStaticValueAndFinal(stats, 10, "ResistanceShadow")
    elseif (race == "BloodElf") then
        SetStaticValueAndFinal(stats, 5, "ResistanceArcane")
        SetStaticValueAndFinal(stats, 5, "ResistanceFire")
        SetStaticValueAndFinal(stats, 5, "ResistanceNature")
        SetStaticValueAndFinal(stats, 5, "ResistanceFrost")
        SetStaticValueAndFinal(stats, 5, "ResistanceShadow")
    end
    --HPMP @todo
    
    --原始属性 @todo
    
end

--读取UNIT的全身装备属性
function lib:GetUnitItemStats(unit, stats)
    if (type(stats) ~= "table") then stats = {} end
    local text, r, g, b, n, f, link
    for i = 1, 18 do
        if (i ~= 4) then
            unittip:SetOwner(UIParent, "ANCHOR_NONE")
            unittip:SetInventoryItem(unit, i)
            link = GetInventoryItemLink(unit,i) or select(2, unittip:GetItem())
            n, f = unittip:NumLines(), unittip:GetName()
            for j = 2, n do
                text = _G[f.."TextLeft" .. j]:GetText() or ""
                r, g, b = _G[f.."TextLeft" .. j]:GetTextColor()
                GetStats(text, r, g, b, stats, link)
            end
        end
    end
    return stats
end

--获取UNIT全部属性
function lib:GetUnitStats(unit, stats)
    if (type(stats) ~= "table") then stats = {} end
    local level = UnitLevel(unit)
    local _, race = UnitRace(unit)
    local _, class = UnitClass(unit) 
    stats.unit = unit
    self:GetUnitItemStats(unit, stats)
    self:GetUnitBuffStats(unit, stats)
    self:GetUnitTalentStats(unit, stats, class, race, level)
    self:GetUnitRaceStats(unit, stats, class, race, level)
    return CalculateStatLogic(unit, stats)
end

--读取指定LINK的物品属性
function lib:GetItemStats(link, stats)
    if (type(stats) ~= "table") then stats = {} end
    tooltip:SetOwner(UIParent, "ANCHOR_NONE")
    tooltip:ClearLines()
    tooltip:SetHyperlink(link)
    local text, r, g, b
    local n, f = tooltip:NumLines(), tooltip:GetName()
    for i = 2, n do
        text = _G[f.."TextLeft" .. i]:GetText() or ""
        r, g, b = _G[f.."TextLeft" .. i]:GetTextColor()
        GetStats(text, r, g, b, stats, link)
    end
    return stats
end

--获取属性对应的语种文字
lib.GetStatsName = function(key)
    return L[key] or _G[strupper(key)] or key
end

--获取属性值
lib.GetStatsValue = function(key, stats, default)
    if (stats and stats.static and stats.static[key]) then
        return stats.static[key].final and stats.static[key].value or "+" .. stats.static[key].value
    elseif (stats and stats[key]) then
        return stats[key].final and stats[key].value or "+" .. stats[key].value
    end
    return default or "-"
end

--是否支持当前语种的属性解析
lib.IsSupported = function(self)
    return LibItemStatsPatterns
end
