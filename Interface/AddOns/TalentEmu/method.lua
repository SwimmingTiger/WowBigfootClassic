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
	local pcall = pcall;
	local type = type;
	local next = next;
	local select = select;
	local strupper, strsub, format = string.upper, string.sub, string.format;
	local max = math.max;
	local tonumber = tonumber;
	local UnitLevel = UnitLevel;
	local GetSpellInfo = GetSpellInfo;
	local GetTalentTabInfo, GetNumTalents, GetTalentInfo, LearnTalent = GetTalentTabInfo, GetNumTalents, GetTalentInfo, LearnTalent;
	local _G = _G;
	local GameTooltip = GameTooltip;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	-- Frame;

-->
	local L = CT.L;

-->		constant
-->
MT.BuildEnv('METHOD');
-->		predef
-->		METHOD
	--
	if DT.BUILD == "CLASSIC" then
		local __ala_meta__ = _G.__ala_meta__;
		_G.ALA_GetSpellLink = _G.ALA_GetSpellLink or function(id, name)
			--|cff71d5ff|Hspell:id|h[name]|h|r
			name = name or GetSpellInfo(id);
			if name then
				if __ala_meta__.chat and __ala_meta__.chat.alac_hyperLink and __ala_meta__.chat.alac_hyperLink() then
					return "|cff71d5ff|Hspell:" .. id .. "|h[" .. name .. "]|h|r";
				else
					return name;
				end
			else
				return nil;
			end
		end
	elseif DT.BUILD == "BCC" then
		_G.ALA_GetSpellLink = _G.ALA_GetSpellLink or function(id, name)
			--|cff71d5ff|Hspell:id|h[name]|h|r
			name = name or GetSpellInfo(id);
			if name then
				return "|cff71d5ff|Hspell:" .. id .. "|h[" .. name .. "]|h|r";
			else
				return nil;
			end
		end
	end
	MT.GetSpellLink = _G.ALA_GetSpellLink;

	function MT.GeneralOnEnter(self, motion)
		if self.information then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			GameTooltip:SetText(self.information, 1.0, 1.0, 1.0);
		end
	end
	function MT.GeneralOnLeave(self, motion)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide();
		end
	end
	function MT.GetPointsReqLevel(numPoints)
		return max(10, 9 + numPoints);
	end
	function MT.GetLevelAvailablePoints(level)
		return max(0, level - 9);
	end
	function MT.CountTreePoints(data, class)
		local ClassTDB = DT.TalentDB[class];
		local SpecList = DT.ClassSpec[class];
		local pos = 1;
		local len = #data;
		local stats = { 0, 0, 0, };
		for TreeIndex = 1, 3 do
			local total = 0;
			for j = 1, #ClassTDB[SpecList[TreeIndex]] do
				if pos > len then
					break;
				end
				local val = strsub(data, pos, pos);
				total = total + tonumber(val);
				pos = pos + 1;
			end
			stats[TreeIndex] = total;
		end
		return stats[1], stats[2], stats[3];
	end
	function MT.GenerateTitle(class, stats, uncolored)
		local SpecList = DT.ClassSpec[class];
		if uncolored then
			local title = L.DATA[class];
			for TreeIndex = 1, 3 do
				title = title .. " " .. L.DATA[SpecList[TreeIndex]] .. format("%2d", stats[TreeIndex]);
			end
			return title;
		else
			local title = "|c" .. RAID_CLASS_COLORS[class].colorStr .. L.DATA[class] .. "|r-";
			local temp = max(stats[1], stats[2], stats[3]);
			if temp == stats[1] and temp == stats[2] and temp == stats[3] then
				temp = temp + 1023;
			end
			for TreeIndex = 1, 3 do
				if temp == stats[TreeIndex] then
					title = title .. " |cff7fbfff" .. L.DATA[SpecList[TreeIndex]] .. format("%2d|r", stats[TreeIndex]);
				else
					title = title .. " " .. L.DATA[SpecList[TreeIndex]] .. format("%2d", stats[TreeIndex]);
				end
			end
			return title;
		end
	end
	function MT.GenerateTitleFromRawData(data, class, uncolored)
		if type(data) == 'table' then
			local TreeFrames = data.TreeFrames;
			return MT.GenerateTitle(data.class, { TreeFrames[1].TalentSet.Total, TreeFrames[2].TalentSet.Total, TreeFrames[3].TalentSet.Total, }, uncolored);
		elseif type(data) == 'string' and type(class) == 'string' and DT.TalentDB[class] then
			return MT.GenerateTitle(class, { MT.CountTreePoints(data, class) }, uncolored);
		end
	end
	function MT.GenerateLink(title, class, code)
		return "|Hemu:" .. code .. "|h|c" .. RAID_CLASS_COLORS[class].colorStr .. "[" .. title .. "]|r|h";
	end
	function MT.GetTreeNodeIndex(def)
		return def[1] * DT.MAX_NUM_COL + def[2] + 1;
	end

	--	arg			code, useCodeLevel
	--	return		class, data, level
	function MT.Decode(code, useCodeLevel)
		for media, codec in next, VT.ExternalCodec do
			local class, data, level = codec.import(code);
			if class ~= nil then
				return class, data, level;
			end
		end
		return VT.__emulib.DecodeTalentData(code, not useCodeLevel and DT.MAX_LEVEL)
	end
	--	arg			[Frame] or [class, data, level]
	--	return		code
	function MT.Encode(class, data, level)
		local TypeClass = type(class);
		if TypeClass == 'table' then
			local Frame = class;
			local TreeFrames = Frame.TreeFrames;
			if type(TreeFrames) == 'table' and
						type(TreeFrames[1]) == 'table' and type(TreeFrames[1].TalentSet) == 'table' and
						type(TreeFrames[2]) == 'table' and type(TreeFrames[2].TalentSet) == 'table' and
						type(TreeFrames[3]) == 'table' and type(TreeFrames[3].TalentSet) == 'table'
				then
				--
				return VT.__emulib.EncodeFrameData(CT.ClassToIndex[Frame.class], Frame.level,
							TreeFrames[1].TalentSet, TreeFrames[2].TalentSet, TreeFrames[3].TalentSet,
							#TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB, #TreeFrames[3].TreeTDB
						);
				--
			else
				MT.Log("MT.Encoder", 1, 'table');
				return nil;
			end
		else
			local classIndex = nil;
			if TypeClass == 'number' then
				classIndex = class;
				class = CT.IndexToClass[class];
				if classIndex == nil then
					MT.Log("MT.Encoder", 2, "class", class);
					return nil;
				end
			elseif TypeClass == 'string' then
				classIndex = CT.ClassToIndex[class];
				if classIndex == nil then
					MT.Log("MT.Encoder", 2, "class", class);
					return nil;
				end
			else
				MT.Log("MT.Encoder", 2, "class type", TypeClass);
				return nil;
			end
			local TypeData = type(data);
			if TypeData == 'string' then
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				return VT.__emulib.EncodeFrameData(classIndex, (level and tonumber(level)) or DT.MAX_LEVEL,
							data,
							#ClassTDB[SpecList[1]], #ClassTDB[SpecList[2]], #ClassTDB[SpecList[3]]);
			elseif TypeData == 'table' and type(data[1]) == 'table' and type(data[2]) == 'table' and type(data[3]) == 'table' then
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				return VT.__emulib.EncodeFrameData(classIndex, (level and tonumber(level)) or DT.MAX_LEVEL,
							data[1], data[2], data[3],
							#ClassTDB[SpecList[1]], #ClassTDB[SpecList[2]], #ClassTDB[SpecList[3]]);
			else
				MT.Log("MT.Encoder", 3, "data type", TypeData);
				return nil;
			end
		end
	end

	local function IteratorFunc(Frame, name)
		if Frame.name == name then
			MT.UI.FrameSetName(Frame, name);
		end
	end
	function MT.SetPack(name)
		if VT.SET.inspect_pack then
			MT.UI.IteratorFrames(IteratorFunc, name);
		end
	end

	function MT.ImportCode(Frame, code)
		if type(Frame) == 'string' then
			code = Frame;
			Frame = nil;
		end
		local class, data, level = MT.Decode(code);
		if class and data and level then
			Frame = Frame or MT.UI.GetFrame();
			if not MT.UI.FrameSetInfo(Frame, class, data, level) then
				Frame:Hide();
				return false;
			end
			return true;
		end
		return false;
	end
	function MT.ExportCode(_1, _2, _3)
		if not _1 then
			return nil;
		elseif type(_1) == 'number' then
			if type(_2) == 'string' then
				return MT.Encode(_1, _2, _3);
			else
				_1 = MT.UI.GetFrame(_1);
				if not _1 then
					return nil;
				end
				return MT.Encode(_1, _2, _3);
			end
		else
			return MT.Encode(_1, _2, _3);
		end
	end

	function MT.QueryTalentSpellID(class, TreeIndex, TalentSeq, level)
		if class ~= nil and TreeIndex ~= nil and TalentSeq ~= nil then
			class = strupper(class);
			local ClassTDB = DT.TalentDB[class];
			if ClassTDB ~= nil then
				local SpecID = DT.ClassSpec[class][TreeIndex];
				if ClassTDB[SpecID] ~= nil then
					local def = ClassTDB[SpecID][TalentSeq];
					if def ~= nil then
						if level == nil or level <= 0 or level > 5 then
							level = 1;
						end
						return def[8][level];
					end
				end
			end
		end
		return nil;
	end
	function MT.QueryTalentInfoBySpellID(SpellID, class, TreeIndex)
		if SpellID == nil then
			return nil;
		end
		SpellID = tonumber(SpellID);
		if SpellID == nil then
			return nil;
		end
		if class ~= nil then
			class = strupper(class);
			local ClassTDB = DT.TalentDB[class];
			local SpecList = DT.ClassSpec[class];
			if ClassTDB ~= nil and SpecList ~= nil then
				if TreeIndex ~= nil then
					local SpecID = SpecList[TreeIndex];
					local TreeTDB = ClassTDB[SpecID];
					if TreeTDB ~= nil then
						for i = 1, #TreeTDB do
							local def = TreeTDB[i];
							local S = def[8];
							for j = 1, 5 do
								if S[j] ~= nil then
									if S[j] == SpellID then
										return class, TreeIndex, SpecID, i, def[1], def[2], j;
									end
								else
									break;
								end
							end
						end
					end
				else
					for TreeIndex = 1, 3 do
						local SpecID = SpecList[TreeIndex];
						local TreeTDB = ClassTDB[SpecID];
						if TreeTDB ~= nil then
							for i = 1, #TreeTDB do
								local def = TreeTDB[i];
								local S = def[8];
								for j = 1, 5 do
									if S[j] ~= nil then
										if S[j] == SpellID then
											return class, TreeIndex, SpecID, i, def[1], def[2], j;
										end
									else
										break;
									end
								end
							end
						end
					end
				end
			end
		else
			for C, ClassTDB in next, DT.TalentDB do
				if C ~= class then
					local SpecList = DT.ClassSpec[C];
					for TreeIndex = 1, 3 do
						local SpecID = SpecList[TreeIndex];
						local TreeTDB = ClassTDB[SpecID];
						for i = 1, #TreeTDB do
							local def = TreeTDB[i];
							local S = def[8];
							for j = 1, 5 do
								if S[j] ~= nil then
									if S[j] == SpellID then
										return C, TreeIndex, SpecID, i, def[1], def[2], j;
									end
								else
									break;
								end
							end
						end
					end
				end
			end
		end
		return nil;
	end

	function MT.CreateEmulator(Frame, class, data, level, readOnly, name, rule, style)
		if VT.SET.singleFrame then
			Frame = Frame or MT.UI.GetFrame(1);
		else
			Frame = Frame or MT.UI.GetFrame();
		end
		MT.UI.FrameSetStyle(Frame, style or VT.SET.style);
		Frame:Show();
		if class == nil or class == "" then
			class = CT.SELFCLASSUPPER;
		end
		if not MT.UI.FrameSetInfo(Frame, class, data, tonumber(level) or DT.MAX_LEVEL, readOnly, name, rule) then
			Frame:Hide();
			return nil;
		end
		return Frame.id;
	end

	function MT.UpdateApplyingTalentsStatus(Frame)
		local Frames = VT.Frames;
		if not VT.ApplyingTalents.Frame ~= not Frame then
			VT.ApplyingTalents.Frame = Frame;
			if Frame ~= nil then
				for i = 1, Frames.num do
					local Frame = Frames[i];
					Frame.ApplyTalentsButton:Disable();
				end
			else
				for i = 1, Frames.num do
					local Frame = Frames[i];
					Frame.ApplyTalentsButton:Enable();
				end
			end
		end
	end
	local function TryLearn(TreeIndex, TalentSeq, TalentSet, TreeTDB)
		local VM = VT.ApplyingTalents.VMap[TreeIndex];
		local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, VM[TalentSeq]);
		if TalentSet[TalentSeq] > rank then
			local dep = TreeTDB[TalentSeq][11];
			if dep ~= nil then
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, VM[dep]);
				if TalentSet[dep] > rank then
					LearnTalent(TreeIndex, VM[dep]);
					return true;
				end
			end
			if TalentSet[TalentSeq] > rank then
				LearnTalent(TreeIndex, VM[TalentSeq]);
				return true;
			end
		end
		return false;
	end
	local function ApplyTalentsTicker()
		local ApplyingTalents = VT.ApplyingTalents;
		local Frame = ApplyingTalents.Frame;
		local TreeFrames = Frame.TreeFrames;
		for TreeIndex = ApplyingTalents.TreeIndex, 3 do
			ApplyingTalents.TreeIndex = TreeIndex;
			local TreeFrame = TreeFrames[TreeIndex];
			local TalentSet = TreeFrame.TalentSet;
			local TreeTDB = TreeFrame.TreeTDB;
			for TalentSeq = ApplyingTalents.TalentSeq, #TreeTDB do
				ApplyingTalents.TalentSeq = TalentSeq;
				if TryLearn(TreeIndex, TalentSeq, TalentSet, TreeTDB) then
					local num = (select(3, GetTalentTabInfo(1)) or 0) + (select(3, GetTalentTabInfo(2)) or 0) + (select(3, GetTalentTabInfo(3)) or 0);
					Frame.ApplyTalentsProgress:SetText(num .. "/" .. ApplyingTalents.Total);
					return;
				end
			end
			ApplyingTalents.TalentSeq = 1;
		end
		--
		MT._TimerHalt(ApplyTalentsTicker);
		MT.Error(L.ApplyTalentsFinished);
		Frame.ApplyTalentsProgress:SetText(nil);
		MT.UpdateApplyingTalentsStatus(nil);
	end
	function MT.ApplyTalents(Frame)
		if CT.SELFCLASSUPPER == Frame.class then
			local TalentFrame_Update = _G.TalentFrame_Update;
			if TalentFrame_Update ~= nil then
				pcall(TalentFrame_Update);
			end
			if MT.GetPointsReqLevel(Frame.TotalUsedPoints) > UnitLevel('player') then
				return MT.Error(L["CANNOT APPLY : NEED MORE TALENT POINTS."]);
			end
			local Map = VT.__emulib.GenerateTalentMap(CT.SELFCLASSUPPER, false);
			if Map == nil then
				return MT.Error(L["CANNOT APPLY : UNABLE TO GENERATE TALENT MAP."]);
			end
			local VMap = Map.VMap;
			local TreeFrames = Frame.TreeFrames;
			local confilicted = false;
			local total = 0;
			for TreeIndex = 1, 3 do
				local VM = VMap[TreeIndex];
				local TreeFrame = TreeFrames[TreeIndex];
				local TalentSet = TreeFrame.TalentSet;
				local TreeTDB = TreeFrame.TreeTDB;
				local num = #TreeTDB;
				if num ~= GetNumTalents(TreeIndex, false) then
					return MT.Error(L["TalentDB Error : DB SIZE IS NOT EQUAL TO TalentFrame SIZE."], CT.SELFCLASSUPPER, TreeIndex, num, GetNumTalents(TreeIndex, false));
				end
				for TalentSeq = 1, num do
					local TalentIndex = VM[TalentSeq];
					if TalentIndex == nil then
						return MT.Error(L["CANNOT APPLY : TALENT MAP ERROR."]);
					end
					local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(TreeIndex, TalentIndex);
					if rank > TalentSet[TalentSeq] then
						confilicted = true;
						break;
					end
					local def = TreeTDB[TalentSeq];
					if tier ~= def[1] + 1 or column ~= def[2] + 1 or maxRank ~= def[4] then
						confilicted = true;
						break;
					end
					total = total + TalentSet[TalentSeq];
				end
				if confilicted then
					break;
				end
			end
			if confilicted then
				return MT.Error(L["CANNOT APPLY : TALENTS IN CONFLICT."]);
			else
				MT.UpdateApplyingTalentsStatus(Frame);
				VT.ApplyingTalents.VMap = VMap;
				VT.ApplyingTalents.TreeIndex = 1;
				VT.ApplyingTalents.TalentSeq = 1;
				VT.ApplyingTalents.Total = total;
				MT._TimerStart(ApplyTalentsTicker, 0.1);
			end
		end
	end

	local MenuElements = {
		{
			v = "autoShowEquipmentFrame",
			[true] = {
				handler = function(Button)
					VT.SET.autoShowEquipmentFrame = false;
				end,
				param = nil,
				text = L.AutoShowEquipmentFrame_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.autoShowEquipmentFrame = true;
				end,
				param = nil,
				text = L.AutoShowEquipmentFrame_TRUE,
			},
		},
		{
			v = "minimap",
			[true] = {
				handler = function(Button)
					VT.SET.minimap = false;
					MT.CALLBACK["minimap"](false);
				end,
				param = nil,
				text = L.Minimap_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.minimap = true;
					MT.CALLBACK["minimap"](true);
				end,
				param = nil,
				text = L.Minimap_TRUE,
			},
		},
		{
			v = "resizable_border",
			[true] = {
				handler = function(Button)
					VT.SET.resizable_border = false;
				end,
				param = nil,
				text = L.ResizableBorder_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.resizable_border = true;
				end,
				param = nil,
				text = L.ResizableBorder_TRUE,
			},
		},
		{
			v = "singleFrame",
			[true] = {
				handler = function(Button, Frame)
					VT.SET.singleFrame = false;
				end,
				param = nil,
				text = L.SetSingleFrame_False,
			},
			[false] = {
				handler = function(Button, Frame)
					VT.SET.singleFrame = true;
					local last = Frame or MT.UI.GetLastFrame();
					MT.UI.ReleaseAllFramesButOne(last and last.id or nil);
				end,
				param = nil,
				text = L.SetSingleFrame_True,
			},
			["*"] = {
				{
					handler = function(Button, Frame)
						MT.UI.FrameSetStyle(Frame, 1);
					end,
					param = nil,
					text = L.SetStyleAllTo1_ThisWin,
				},
				{
					handler = function(Button, Frame)
						MT.UI.FrameSetStyle(Frame, 2);
					end,
					param = nil,
					text = L.SetStyleAllTo2_ThisWin,
				},
			},
		},
		{
			v = "style",
			[1] = {
				handler = function(Button)
					VT.SET.style = 2;
					for i = 1, VT.Frames.used do
						MT.UI.FrameSetStyle(VT.Frames[i], 2);
					end
				end,
				param = nil,
				text = L.SetStyleAllTo2_LaterWin,
			},
			[2] = {
				handler = function(Button)
					VT.SET.style = 1;
					for i = 1, VT.Frames.used do
						MT.UI.FrameSetStyle(VT.Frames[i], 1);
					end
				end,
				param = nil,
				text = L.SetStyleAllTo1_LaterWin,
			},
		},
		{
			v = "talents_in_tip",
			[true] = {
				handler = function(Button)
					VT.SET.talents_in_tip = false;
				end,
				param = nil,
				text = L.TalentsInTip_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.talents_in_tip = true;
				end,
				param = nil,
				text = L.TalentsInTip_TRUE,
			},
		},
		{
			v = "talents_in_tip_icon",
			[true] = {
				handler = function(Button)
					VT.SET.talents_in_tip_icon = false;
				end,
				param = nil,
				text = L.TalentsInTipIcon_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.talents_in_tip_icon = true;
				end,
				param = nil,
				text = L.TalentsInTipIcon_TRUE,
			},
		},
		{
			v = "inspectButtonOnUnitFrame",
			[true] = {
				handler = function(Button)
					VT.SET.inspectButtonOnUnitFrame = false;
				end,
				param = nil,
				text = L.InspectButtonOnUnitFrame_FALSE,
			},
			[false] = {
				handler = function(Button)
					VT.SET.inspectButtonOnUnitFrame = true;
				end,
				param = nil,
				text = L.InspectButtonOnUnitFrame_TRUE,
			},
		},
		{
			v = "inspectButtonKey",
			ALT = {
				handler = function(Button)
					VT.SET.inspectButtonKey = "ALT";
					MT.InspectButtonKeyFunc = IsAltKeyDown;
				end,
				param = nil,
				text = L.InsepctKey_ALT,
			},
			CTRL = {
				handler = function(Button)
					VT.SET.inspectButtonKey = "CTRL";
					MT.InspectButtonKeyFunc = IsControlKeyDown;
				end,
				param = nil,
				text = L.InsepctKey_CTRLK,
			},
			SHIFT = {
				handler = function(Button)
					VT.SET.inspectButtonKey = "SHIFT";
					MT.InspectButtonKeyFunc = IsShiftKeyDown;
				end,
				param =  nil,
				text = L.InsepctKey_SHIFT,
			},
		},
	};
	local MenuDefinition = {
		num = 0,
	};
	function MT.ShowMenu(Parent, Frame)
		local SET = VT.SET;
		local pos = 0;
		for index = 1, #MenuElements do
			local Def = MenuElements[index];
			local v = SET[Def.v];
			if Def[v] ~= nil then
				pos = pos + 1;
				MenuDefinition[pos] = Def[v];
				local dim = Def["*"];
				if dim ~= nil then
					for i = 1, #dim do
						pos = pos + 1;
						MenuDefinition[pos] = dim[i];
					end
				end
			end
		end
		MenuDefinition.num = pos;
		VT.__menulib.ShowMenu(Parent, "BOTTOMLEFT", MenuDefinition, Frame);
	end

	function MT.CALLBACK.OnTalentDataRecv(name, iscomm)
		local cache = VT.TQueryCache[name];
		if cache ~= nil then
			if VT.QuerySent[name] then
				local readOnly = false;
				if name ~= CT.SELFNAME then
					readOnly = true;
				end
				local Frames = MT.UI.FrameGetNameBinding(name);
				if Frames ~= nil and Frames[1] - MT.GetUnifiedTime() <= CT.INSPECT_WAIT_TIME then
					local AnyShown = false;
					for i = 2, #Frames do
						if Frames[i]:IsShown() then
							MT.UI.FrameSetInfo(Frames[i], cache.class, cache.data, DT.MAX_LEVEL, readOnly, name);
							AnyShown = true;
						end
					end
					if not AnyShown then
						MT.CreateEmulator(nil, cache.class, cache.data, DT.MAX_LEVEL, readOnly, name, false);
					end
				else
					MT.CreateEmulator(nil, cache.class, cache.data, DT.MAX_LEVEL, readOnly, name, false);
				end
			end
			VT.QuerySent[name] = nil;
		end
	end
	function MT.CALLBACK.OnInventoryDataRecv(name, iscomm)
		if not VT.SET.show_equipment then return; end
		local Frames = MT.UI.FrameGetNameBinding(name);
		if Frames ~= nil then
			for i = 2, #Frames do
				Frames[i].objects.EquipmentFrameButton:Show();
				if iscomm and VT.SET.autoShowEquipmentFrame then
					Frames[i].EquipmentFrameContainer:Show();
					MT.UI.EquipmentFrameUpdate(Frames[i].EquipmentContainer, VT.TQueryCache[name]);
				end
			end
		end
	end

-->
