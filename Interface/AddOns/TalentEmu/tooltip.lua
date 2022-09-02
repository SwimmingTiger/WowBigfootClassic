﻿--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local hooksecurefunc = hooksecurefunc;
	local type = type;
	local strmatch, format = string.match, string.format;
	local max = math.max;
	local tonumber = tonumber;
	local UnitName = UnitName;
	local UnitIsPlayer, UnitFactionGroup, UnitIsConnected = UnitIsPlayer, UnitFactionGroup, UnitIsConnected;
	local GetSpellBookItemName = GetSpellBookItemName;
	local GetActionInfo = GetActionInfo;
	local GetMacroSpell = GetMacroSpell;
	local Ambiguate = Ambiguate;
	local _G = _G;
	local GameTooltip = GameTooltip;
	local ItemRefTooltip = ItemRefTooltip;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;

-->
	local L = CT.L;

-->		constant
-->
MT.BuildEnv('TOOLTIP');
-->		predef
-->		TOOLTIP
	--
	local PrevTipUnitName = {  };
	local function TipAddLine(Tip, _name)
		local cache = VT.TQueryCache[_name];
		if cache ~= nil then
			local data = cache.data;
			local class = cache.class;
			if data and class then
				local line = "";
				local stats = { MT.CountTreePoints(data, class) };
				local SpecList = DT.ClassSpec[class];
				local cap = -1;
				if stats[1] ~= stats[2] or stats[1] ~= stats[3] then
					cap = max(stats[1], stats[2], stats[3]);
				end
				for TreeIndex = 1, 3 do
					local SpecID = SpecList[TreeIndex];
					if cap == stats[TreeIndex] then
						if VT.SET.talents_in_tip_icon then
							line = line .. "|T" .. (DT.TalentSpecIcon[SpecID] or CT.TEXTUREUNK) .. format(":16|t |cffff7f1f%2d|r  ", stats[TreeIndex]);
						else
							line = line .. "|cffff7f1f" .. L.DATA[SpecID] .. ":" .. stats[TreeIndex] .. "|r  ";
						end
					else
						if VT.SET.talents_in_tip_icon then
							line = line .. "|T" .. (DT.TalentSpecIcon[SpecID] or CT.TEXTUREUNK) .. format(":16|t |cffffffff%2d|r  ", stats[TreeIndex]);
						else
							line = line .. "|cffbfbfff" .. L.DATA[SpecID] .. ":" .. stats[TreeIndex] .. "|r  ";
						end
					end
				end
				Tip:AddLine(line);
				if VT.SET.supreme and cache.pack ~= nil then
					local info = VT.__emulib.DecodeAddonPackData(cache.pack, true);
					if info ~= nil then
						Tip:AddLine("|cffffffffPack|r: " .. info, 0.75, 1.0, 0.25);
					end
				end
				Tip:Show();
			end
		end
	end
	local function TipAddInfo(Tip, _name)
		if PrevTipUnitName[Tip] == nil then
			local _, unit = Tip:GetUnit();
			if unit ~= nil then
				local name, realm = UnitName(unit);
				if realm ~= nil and realm ~= "" then
					name = Ambiguate(name .. "-" .. realm, 'none');
				end
				if name == _name then
					TipAddLine(Tip, _name);
					PrevTipUnitName[Tip] = _name;
					return true;
				end
			end
		end
	end
	local function OnTalentDataRecv(name)
		TipAddInfo(GameTooltip, name);
		TipAddInfo(ItemRefTooltip, name);
	end
	local function OnTooltipSetUnit(Tip)
		if VT.SET.talents_in_tip then
			PrevTipUnitName[Tip] = nil;
			local _, unit = Tip:GetUnit();
			if unit ~= nil and UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitFactionGroup(unit) == CT.SELFFACTION then
				local name, realm = UnitName(unit);
				MT.SendQueryRequest(name, realm, true, nil, nil, false);
			end
		end
	end

	local function TipAddSpellInfo(self, SpellID)
		local class, TreeIndex, SpecID, TalentSeq, row, col, rank = MT.QueryTalentInfoBySpellID(SpellID);
		if class ~= nil then
			local color = RAID_CLASS_COLORS[class];
			self:AddDoubleLine(L.DATA.talent, L.DATA[class] .. "-" .. L.DATA[SpecID] .. " R" .. (row + 1) .. "-C" .. (col + 1) .. "-L" .. rank, 1.0, 1.0, 1.0, color.r, color.g, color.b);
			self:Show();
		end
	end
	local function HookSetHyperlink(self, link)
		local SpellID = strmatch(link, "spell:(%d+)");
		SpellID = tonumber(SpellID);
		if SpellID ~= nil then
			TipAddSpellInfo(self, SpellID);
		end
	end
	local function HookSetSpellBookItem(self, spellBookId, bookType)
		local _, _, SpellID = GetSpellBookItemName(spellBookId, bookType);
		SpellID = tonumber(SpellID);
		if SpellID ~= nil then
			TipAddSpellInfo(self, SpellID);
		end
	end
	local function HookSetSpellByID(self, SpellID)
		SpellID = tonumber(SpellID);
		if SpellID ~= nil then
			TipAddSpellInfo(self, SpellID);
		end
	end
	local function HookSetAction(self, slot)
		local actionType, id, subType = GetActionInfo(slot);
		if actionType == "spell" then
			TipAddSpellInfo(self, id);
		elseif actionType == "macro" then
			local SpellID = GetMacroSpell(id);
			if SpellID ~= nil then
				TipAddSpellInfo(self, SpellID);
			end
		end
	end

	MT.RegisterOnInit('TOOLTIP', function(LoggedIn)
		--	hooksecurefunc(GameTooltip, "SetUnit", OnTooltipSetUnit);
		--	hooksecurefunc(ItemRefTooltip, "SetUnit", OnTooltipSetUnit);
		GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit);
		ItemRefTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit);
		MT._RegisterCallback("CALLBACK_TALENT_DATA_RECV", OnTalentDataRecv);
		--
		hooksecurefunc(GameTooltip, "SetHyperlink", HookSetHyperlink);
		hooksecurefunc(GameTooltip, "SetSpellBookItem", HookSetSpellBookItem);
		hooksecurefunc(GameTooltip, "SetSpellByID", HookSetSpellByID);
		hooksecurefunc(GameTooltip, "SetAction", HookSetAction);

		hooksecurefunc(ItemRefTooltip, "SetHyperlink", HookSetHyperlink);
		hooksecurefunc(ItemRefTooltip, "SetSpellBookItem", HookSetSpellBookItem);
		hooksecurefunc(ItemRefTooltip, "SetSpellByID", HookSetSpellByID);
		hooksecurefunc(ItemRefTooltip, "SetAction", HookSetAction);
	end);
	MT.RegisterOnLogin('TOOLTIP', function(LoggedIn)
	end);

-->
