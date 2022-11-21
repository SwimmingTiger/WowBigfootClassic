--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

-->		upvalue
	local hooksecurefunc = hooksecurefunc;
	local UnitGUID, UnitName, UnitLevel, UnitClassBase = UnitGUID, UnitName, UnitLevel, UnitClassBase;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local UIParent = UIParent;

-->
	local l10n = CT.l10n;

-->		constant
-->
MT.BuildEnv('INSPECT');
-->		predef
-->		INSPECT
	local _InspectInfo = {  };
	local UnitList = { 'target', 'focus', };
	for i = 1, 4 do UnitList[#UnitList + 1] = 'party' .. i; end
	for i = 1, 40 do UnitList[#UnitList + 1] = 'raid' .. i; end
	local function OnEvent(Driver, event, GUID)
		local info = _InspectInfo[GUID];
		if info == nil then
			for i = 1, #UnitList do
				local unit = UnitList[i];
				if GUID == UnitGUID(unit) then
					local name, realm = UnitName(unit);
					if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
						name = name .. "-" .. realm;
					end
					info = { unit, name, UnitClassBase(unit), UnitLevel(unit), };
					break;
				end
			end
		end
		if info ~= nil then
			local unit = info[1];
			if UnitGUID(unit) == GUID then
				local name = info[2];
				local class = info[3];
				local level = info[4];
				local code, numGroup, activeGroup, data1, data2 = VT.__emulib.EncodeInspectTalentDataV2(class, level);
				if code ~= nil then
					local cache = VT.TQueryCache[name];
					if cache == nil then
						cache = { TalData = {  }, EquData = {  }, GlyData = {  }, PakData = {  }, };
						VT.TQueryCache[name] = cache;
					end
					cache.class = class;
					cache.level = level;
					local TalData = cache.TalData;
					TalData[1] = data1;
					TalData[2] = data2;
					TalData.num = numGroup;
					TalData.active = activeGroup;
					TalData.code = code;
					TalData.Tick = MT.GetUnifiedTime();
					VT.__emulib.GetEquipmentData(cache.EquData, unit);
					MT._TriggerCallback("CALLBACK_DATA_RECV", name);
					MT._TriggerCallback("CALLBACK_TALENT_DATA_RECV", name, false);
					MT._TriggerCallback("CALLBACK_INVENTORY_DATA_RECV", name, false);
				end
			end
		end
	end
	MT.RegisterOnInit('INSPECT', function(LoggedIn)
		local Driver = CreateFrame('FRAME', nil, UIParent);
		Driver:RegisterEvent("INSPECT_READY");
		Driver:SetScript("OnEvent", OnEvent);
		hooksecurefunc("NotifyInspect", function(unit)
			local GUID = UnitGUID(unit);
			if GUID ~= nil then
				local name, realm = UnitName(unit);
				if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
					name = name .. "-" .. realm;
				end
				_InspectInfo[GUID] = { unit, name, UnitClassBase(unit), UnitLevel(unit), };
			end
		end);
	end);
	MT.RegisterOnLogin('INSPECT', function(LoggedIn)
	end);

-->
