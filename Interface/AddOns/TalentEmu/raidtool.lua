--[[--
	by ALA @ 163UI
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local wipe = table.wipe;
	local format = string.format;
	local UnitName = UnitName;
	local UnitLevel = UnitLevel;
	local UnitClassBase = UnitClassBase;
	local UnitIsUnit = UnitIsUnit;
	local UnitExists = UnitExists;
	local UnitIsConnected = UnitIsConnected;
	local IsInGroup = IsInGroup;
	local IsInRaid = IsInRaid;
	local CheckInteractDistance = CheckInteractDistance;
	local CanInspect, NotifyInspect = CanInspect, NotifyInspect;
	local GuildRoster = GuildRoster;
	local GetNumGuildMembers = GetNumGuildMembers;
	local GetGuildRosterInfo = GetGuildRosterInfo;
	local GetItemInfoInstant = GetItemInfoInstant;
	local Ambiguate = Ambiguate;
	local GetMouseFocus = GetMouseFocus;
	local CreateFrame = CreateFrame;
	local _G = _G;
	local UIParent = UIParent;
	local GameTooltip = GameTooltip;
	local GameFontHighlight = GameFontHighlight;
	local UISpecialFrames = UISpecialFrames;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS;

-->
	local l10n = CT.l10n;

-->		constant
	local TUISTYLE = {
		RaidToolUIFrameXSize = VT.__support_gem and 680 or 640,
		RaidToolUIFrameYSize = 320,
		RaidToolUIFrameButtonHeight = 24,
		RaidToolUIFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		RaidToolUIFontSize = 14,
		RaidToolUIFontOutline = "NORMAL",
	};
	local TTEXTURESET = {
		UNK = CT.TEXTUREUNK,
		CONTROL_NORMAL_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		CONTROL_PUSHED_COLOR = { 0.5, 0.5, 0.5, 1.0, },
		CONTROL_DISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
		CONTROL_HIGHLIGHT_COLOR = { 0.25, 0.25, 0.5, 0.5, },
		CLASS = CT.TEXTUREPATH .. [[UI-Classes-Circles]],
	};
-->
MT.BuildEnv('RAIDTOOL');
-->		predef
-->		RAIDTOOL
	local IGNORE_SLOT18 = {
		DRUID = 1,
		PALADIN = 1,
		SHAMAN = 1,
	};
	local function SummaryItems(class, EquData)
		if EquData then
			local missItems, items = 0, 0;
			local missEnchants, enchants = 0, 0;
			local missGems, gems = 0, 0;
			for slot = 1, 18 do
				if slot ~= 4 then
					local item = EquData[slot];
					if item then
						items = items + 1;
						local enchantable, enchanted, link, level, loc, estr = MT.GetEnchantInfo(class, slot, item);
						if enchantable then
							if enchanted then
								enchants = enchants + 1;
							else
								missEnchants = missEnchants + 1;
							end
						end
						if VT.__support_gem then
							local A, T, M, R, Y, B = MT.ScanGemInfo(item);
							missGems = missGems + T;
							gems = gems + A;
						end
					else
						if slot == 17 and EquData[16] then
							local _, _, _, loc = GetItemInfoInstant(EquData[16]);
							if loc ~= "INVTYPE_2HWEAPON" then
								missItems = missItems + 1;
							end
						elseif slot == 18 and IGNORE_SLOT18[class] then
						else
							missItems = missItems + 1;
						end
					end
				end
			end
			return missItems, items, missEnchants, enchants, missGems, gems;
		end
	end
	local function RaidNode_OnEnter(Node)
		local data_index = Node:GetDataIndex();
		local RosterList = Node.RosterList;
		if data_index <= #RosterList then
			GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
			local RosterInfo = Node.RosterInfo;
			local name = RosterList[data_index];
			local class = RosterInfo[name][1];
			local cache = VT.TQueryCache[name];
			if class == nil and cache ~= nil then
				class = cache.class;
			end
			if class then
				GameTooltip:SetText("|c" .. RAID_CLASS_COLORS[class].colorStr .. RosterList[data_index] .. "|r");
			else
				GameTooltip:SetText(RosterList[data_index]);
			end
			if cache ~= nil and cache.EquData ~= nil then
				local EquData = cache.EquData;
				for slot = 1, 18 do
					if slot ~= 4 then
						local item = EquData[slot];
						if item then
							local enchantable, enchanted, link, level, loc, estr = MT.GetEnchantInfo(class, slot, item);
							local A, T, M, R, Y, B, gstr = MT.ScanGemInfo(item, true);
							if enchantable then
								if gstr ~= "" then
									GameTooltip:AddDoubleLine(l10n.SLOT[slot] .. " " .. link .. " |cffffffff(" .. level .. ")|r " .. gstr, enchanted and estr or l10n.MISS_ENCHANT);
								else
									GameTooltip:AddDoubleLine(l10n.SLOT[slot] .. " " .. link .. " |cffffffff(" .. level .. ")|r", enchanted and estr or l10n.MISS_ENCHANT);
								end
							else
								if gstr ~= "" then
									GameTooltip:AddLine(l10n.SLOT[slot] .. " " .. link .. " |cffffffff(" .. level .. ")|r " .. gstr);
								else
									GameTooltip:AddLine(l10n.SLOT[slot] .. " " .. link .. " |cffffffff(" .. level .. ")|r");
								end
							end
						else
							if slot == 17 and EquData[16] then
								local _, _, _, _, loc = GetItemInfoInstant(EquData[16]);
								if loc == "INVTYPE_2HWEAPON" then
									GameTooltip:AddLine(l10n.SLOT[slot] .. " -");
								else
									GameTooltip:AddLine(l10n.SLOT[slot] .. " " .. l10n.EMTPY_SLOT);
								end
							elseif slot == 18 and IGNORE_SLOT18[class] then
								GameTooltip:AddLine(l10n.SLOT[slot] .. " -");
							else
								GameTooltip:AddLine(l10n.SLOT[slot] .. " " .. l10n.EMTPY_SLOT);
							end
						end
					end
				end
			end
			GameTooltip:Show();
		end
	end
	local function RaidNode_OnLeave(Node)
		if GameTooltip:IsOwned(Node) then
			GameTooltip:Hide();
		end
	end
	local function RaidNode_OnClick(Node)
	end
	local function CreateRaidNode(Parent, index, buttonHeight)
		local Node = CreateFrame('BUTTON', nil, Parent);
		Node:SetHeight(buttonHeight);
		VT.__uireimp._SetSimpleBackdrop(Node, 0, 1, 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 1.0);
		Node:SetHighlightTexture([[Interface\FriendsFrame\UI-FriendsFrame-HighlightBar]]);
		Node:EnableMouse(true);
		Node:Show();

		local Icon = Node:CreateTexture(nil, "OVERLAY");
		Icon:SetTexture(TTEXTURESET.UNK);
		Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		Icon:SetPoint("LEFT", 4, 0);
		Icon:SetTexture(TTEXTURESET.CLASS);
		Node.Icon = Icon;

		local Title = Node:CreateFontString(nil, "OVERLAY");
		Title:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
		Title:SetJustifyH("LEFT");
		Title:SetWidth(136);
		Title:SetMaxLines(1);
		Node.Title = Title;

		local Specs = {  };
		for TreeIndex = 1, 3 do
			local SpecIcon = Node:CreateTexture(nil, "OVERLAY");
			SpecIcon:SetSize(buttonHeight - 4, buttonHeight - 4);
			local SpecText = Node:CreateFontString(nil, "OVERLAY");
			SpecText:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
			SpecText:SetPoint("LEFT", SpecIcon, "RIGHT", 4, 0);
			SpecText:SetJustifyH("LEFT");
			SpecIcon.Name = SpecText;
			Specs[TreeIndex] = SpecIcon;
		end
		Specs[1]:SetPoint("LEFT", Node, "LEFT", 160, 0);
		Specs[2]:SetPoint("LEFT", Specs[1], "RIGHT", 24, 0);
		Specs[3]:SetPoint("LEFT", Specs[2], "RIGHT", 24, 0);
		Node.Specs = Specs;

		local ItemLevel = Node:CreateFontString(nil, "OVERLAY");
		ItemLevel:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		ItemLevel:SetPoint("RIGHT", Specs[3], "RIGHT", 68, 0);
		Node.ItemLevel = ItemLevel;

		local ItemSummary = Node:CreateFontString(nil, "OVERLAY");
		ItemSummary:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		ItemSummary:SetPoint("LEFT", ItemLevel, "RIGHT", 4, 0);
		Node.ItemSummary = ItemSummary;

		local EnchantSummary = Node:CreateFontString(nil, "OVERLAY");
		EnchantSummary:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		EnchantSummary:SetPoint("LEFT", ItemSummary, "LEFT", 60, 0);
		Node.EnchantSummary = EnchantSummary;

		local GemSummary;
		if VT.__support_gem then
			GemSummary = Node:CreateFontString(nil, "OVERLAY");
			GemSummary:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
			GemSummary:SetPoint("LEFT", EnchantSummary, "LEFT", 60, 0);
			Node.GemSummary = GemSummary;
		end

		local BossModInfo = Node:CreateFontString(nil, "OVERLAY");
		BossModInfo:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
		BossModInfo:SetPoint("LEFT", GemSummary or EnchantSummary, "LEFT", 60, 0);
		BossModInfo:SetWidth(120);
		BossModInfo:SetMaxLines(1);
		Node.BossModInfo = BossModInfo;

		Node:SetScript("OnEnter", RaidNode_OnEnter);
		Node:SetScript("OnLeave", RaidNode_OnLeave);
		Node:SetScript("OnClick", RaidNode_OnClick);

		local Frame = Parent:GetParent():GetParent();
		Node.Frame = Frame;
		Node.RosterList = Frame.RosterList;
		Node.RosterInfo = Frame.RosterInfo;

		return Node;
	end
	local function SetRaidNode(Node, data_index)
		local RosterList = Node.RosterList;
		if data_index <= #RosterList then
			local RosterInfo = Node.RosterInfo;
			local name = RosterList[data_index];
			local cache = VT.TQueryCache[name];
			local info = RosterInfo[name];
			local class = info[1] or (cache ~= nil and cache.class);
			local level = info[2] or (cache ~= nil and cache.level);
			if level ~= nil then
				Node.Title:SetText(format("%2d: ", level) .. name);
			else
				Node.Title:SetText("**: " .. name);
			end
			if class ~= nil then
				local color = RAID_CLASS_COLORS[class];
				Node.Title:SetVertexColor(color.r, color.g, color.b, 1.0);
				local coord = CLASS_ICON_TCOORDS[class];
				if coord ~= nil then
					Node.Icon:SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
				else
					Node.Icon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
				end
			else
				Node.Title:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				Node.Icon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
			end
			if class ~= nil and cache ~= nil then
				local TalData = cache.TalData;
				if TalData ~= nil then
					local stats = MT.CountTreePoints(TalData[TalData.active], class);
					local Specs = Node.Specs;
					local SpecList = DT.ClassSpec[class];
					for TreeIndex = 1, 3 do
						local SpecIcon = Specs[TreeIndex];
						local SpecID = SpecList[TreeIndex];
						SpecIcon:SetTexture(DT.TalentSpecIcon[SpecID] or TTEXTURESET.UNK);
						SpecIcon.Name:SetText(stats[TreeIndex]);
					end
				else
					local Specs = Node.Specs;
					for TreeIndex = 1, 3 do
						local SpecIcon = Specs[TreeIndex];
						SpecIcon:SetTexture(TTEXTURESET.UNK);
						SpecIcon.Name:SetText("*");
					end
				end
				local itemLevel1, itemLevel2, refresh_again = MT.CalcItemLevel(class, cache.EquData);
				if itemLevel1 then
					Node.ItemLevel:SetText(format("%.1f", itemLevel1));
				else
					Node.ItemLevel:SetText(nil);
				end
				if refresh_again then
					MT._TimerStart(Node.Frame.UpdateScrollList, 0.2, 1);
				end
				local missItems, items, missEnchants, enchants, missGems, gems = SummaryItems(class, cache.EquData);
				if missItems then
					if missItems > 0 then
						Node.ItemSummary:SetText(" |cff00ff00" .. items .. "|r / |cffff0000-" .. missItems .. "|r");
					else
						Node.ItemSummary:SetText(" |cff00ff00" .. items .. "|r");
					end
					if missEnchants > 0 then
						Node.EnchantSummary:SetText(" |cff00ff00" .. enchants .. "|r / |cffff0000-" .. missEnchants .. "|r");
					else
						Node.EnchantSummary:SetText(" |cff00ff00" .. enchants .. "|r");
					end
					if VT.__support_gem then
						if missGems > 0 then
							Node.GemSummary:SetText(" |cff00ff00" .. gems .. "|r / |cffff0000-" .. missGems .. "|r");
						else
							Node.GemSummary:SetText(" |cff00ff00" .. gems .. "|r");
						end
					end
				else
					Node.ItemSummary:SetText(nil);
					Node.EnchantSummary:SetText(nil);
					if VT.__support_gem then
						Node.GemSummary:SetText(nil);
					end
				end
			else
				local Specs = Node.Specs;
				for TreeIndex = 1, 3 do
					local SpecIcon = Specs[TreeIndex];
					SpecIcon:SetTexture(TTEXTURESET.UNK);
					SpecIcon.Name:SetText("*");
				end
				Node.ItemLevel:SetText(nil);
				Node.ItemSummary:SetText(nil);
				Node.EnchantSummary:SetText(nil);
				if VT.__support_gem then
					Node.GemSummary:SetText(nil);
				end
			end
			local BossModInfo = VT.ExternalAddOn["D4C"].list[name] or VT.ExternalAddOn["D4BC"].list[name] or VT.ExternalAddOn["BigWigs"].list[name];
			if BossModInfo then
				Node.BossModInfo:SetText(BossModInfo[1]);
			else
				Node.BossModInfo:SetText(nil);
			end
			Node:Show();
			if GetMouseFocus() == Node then
				RaidNode_OnEnter(Node);
			end
		else
			Node:Hide();
		end
	end
	local function OnEvent(Frame, event)
		if event == "GROUP_ROSTER_UPDATE" then
			MT._TimerStart(Frame.UpdateGroupRosterList, 0.2, 1);
		elseif event == "GUILD_ROSTER_UPDATE" then
			MT._TimerStart(Frame.UpdateGuildRosterList, 0.2, 1);
		end
	end
	local TPartyUnit = { 'player', };
	for index = 1, 4 do
		TPartyUnit[index + 1] = 'party' .. index;
	end
	local TRaidUnit = {  };
	for index = 1, 40 do
		TRaidUnit[index] = 'raid' .. index;
	end
	local function UpdateGuildRosterList(Frame, force_update)
		if Frame.guild then
			local RosterList = Frame.RosterList;
			local RosterInfo = Frame.RosterInfo;
			wipe(RosterList);
			local num = 0;
			for index = 1, GetNumGuildMembers() do
				local name, rankName, rankId, level, classLocale, zone, note, officerNote, online, _, class, _, _, _, _, _, GUID = GetGuildRosterInfo(index);
				name = Ambiguate(name, 'none');
				if online then
					num = num + 1;
					RosterList[num] = name;
				end
				RosterInfo[name] = RosterInfo[name] or {  };
				local info = RosterInfo[name];
				info[1] = class;
				info[2] = level;
				info[3] = online;
				info[4] = nil;
				if online then
					MT.SendQueryRequest(name, nil, force_update, false);
				end
			end
		end
	end
	local function UpdateRaidRosterList(Frame, force_update)
		if not Frame.guild then
			local RosterList = Frame.RosterList;
			local RosterInfo = Frame.RosterInfo;
			wipe(RosterList);
			local num = 0;
			do	--	player on top
				local name = UnitName('player');
				local level = UnitLevel('player');
				local class = UnitClassBase('player');
				num = num + 1;
				RosterList[num] = name;
				RosterInfo[name] = RosterInfo[name] or {  };
				local info = RosterInfo[name];
				info[1] = class;
				info[2] = level;
				info[3] = true;
				info[4] = unit;
				MT.SendQueryRequest(name, nil, force_update, false);
			end
			if IsInRaid() then
				for i = 1, 40 do
					local unit = TRaidUnit[i];
					if UnitExists(unit) and not UnitIsUnit(unit, 'player') then
						local name, realm = UnitName(unit);
						if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
							name = name .. "-" .. realm;
						end
						local level = UnitLevel(unit);
						local class = UnitClassBase(unit);
						local online = not not UnitIsConnected(unit);
						num = num + 1;
						RosterList[num] = name;
						RosterInfo[name] = RosterInfo[name] or {  };
						local info = RosterInfo[name];
						info[1] = class;
						info[2] = level;
						info[3] = online;
						info[4] = unit;
						if online then
							MT.SendQueryRequest(name, nil, force_update, false);
						end
					end
				end
			elseif IsInGroup() then
				for i = 1, 5 do
					local unit = TPartyUnit[i];
					if UnitExists(unit) and unit ~= 'player' then
						local name, realm = UnitName(unit);
						if realm ~= nil and realm ~= "" and realm ~= CT.SELFREALM then
							name = name .. "-" .. realm;
						end
						local level = UnitLevel(unit);
						local class = UnitClassBase(unit);
						local online = not not UnitIsConnected(unit);
						num = num + 1;
						RosterList[num] = name;
						RosterInfo[name] = RosterInfo[name] or {  };
						local info = RosterInfo[name];
						info[1] = class;
						info[2] = level;
						info[3] = online;
						info[4] = unit;
						if online then
							MT.SendQueryRequest(name, nil, force_update, false);
						end
					end
				end
			else
			end
		end
	end
	local function CreateRaidToolUI()
		--	Frame
			local Frame = CreateFrame('FRAME', "ALA_RAID_TOOL_UI", UIParent);
			UISpecialFrames[#UISpecialFrames + 1] = "ALA_RAID_TOOL_UI";
			VT.__uireimp._SetSimpleBackdrop(Frame, 0, 1, 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 1.0);
			Frame:SetSize(TUISTYLE.RaidToolUIFrameXSize, TUISTYLE.RaidToolUIFrameYSize);
			Frame:SetFrameStrata("HIGH");
			Frame:SetPoint("CENTER", 0, 0);
			Frame:EnableMouse(true);
			Frame:SetMovable(true);
			Frame:RegisterForDrag("LeftButton");
			Frame:SetScript("OnDragStart", function(self)
				self:StartMoving();
			end);
			Frame:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing();
			end);
			Frame:SetScript("OnShow", function(self)
				if self.guild then
					GuildRoster();
				end
				Frame.Update();
			end);
			Frame:Hide();
			local RosterList = {  };
			local RosterInfo = {  };
			Frame.RosterList = RosterList;
			Frame.RosterInfo = RosterInfo;
			--[[
				RosterList = { group, guild, };
				RosterInfo = { class, level, online, rank }
			]]

			local ScrollList = VT.__scrolllib.CreateScrollFrame(Frame, nil, nil, TUISTYLE.RaidToolUIFrameButtonHeight, CreateRaidNode, SetRaidNode);
			ScrollList:SetPoint("BOTTOMLEFT", 4, 24);
			ScrollList:SetPoint("TOPRIGHT", -4, -24);
			Frame.ScrollList = ScrollList;

			local Close = CreateFrame('BUTTON', nil, Frame);
			Close:SetSize(16, 16);
			Close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
			Close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
			Close:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
			Close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
			Close:GetHighlightTexture():SetVertexColor(TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[1], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[2], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[3], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[4]);
			Close:SetPoint("TOPRIGHT", Frame, "TOPRIGHT", -4, -4);
			Close:SetScript("OnClick", function()
				Frame:Hide();
			end);
			Frame.Close = Close;

			local Refresh = CreateFrame('BUTTON', nil, Frame);
			Refresh:SetSize(16, 16);
			Refresh:SetNormalTexture("interface\\buttons\\ui-refreshbutton");
			Refresh:SetPushedTexture("interface\\buttons\\ui-refreshbutton");
			Refresh:GetPushedTexture():SetVertexColor(TTEXTURESET.CONTROL_PUSHED_COLOR[1], TTEXTURESET.CONTROL_PUSHED_COLOR[2], TTEXTURESET.CONTROL_PUSHED_COLOR[3], TTEXTURESET.CONTROL_PUSHED_COLOR[4]);
			Refresh:SetHighlightTexture("interface\\buttons\\ui-refreshbutton");
			Refresh:GetHighlightTexture():SetVertexColor(TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[1], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[2], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[3], TTEXTURESET.CONTROL_HIGHLIGHT_COLOR[4]);
			Refresh:SetPoint("RIGHT", Close, "LEFT", -4, 0);
			Refresh:SetScript("OnClick", function()
				Frame.Update(true);
			end);
			Frame.Refresh = Refresh;

			--	LAYERS
				local RaidToolLableItemLevel = Frame:CreateFontString(nil, "OVERLAY");
				RaidToolLableItemLevel:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
				RaidToolLableItemLevel:SetPoint("BOTTOMLEFT", ScrollList, "TOPLEFT", 164 + (TUISTYLE.RaidToolUIFrameButtonHeight - 4 + 24) * 3 + 12, 4);
				RaidToolLableItemLevel:SetText(l10n.RaidToolLableItemLevel);
				Frame.LableItemLevel = RaidToolLableItemLevel;
				local RaidToolLableItemSummary = Frame:CreateFontString(nil, "OVERLAY");
				RaidToolLableItemSummary:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
				RaidToolLableItemSummary:SetPoint("LEFT", RaidToolLableItemLevel, "LEFT", 36, 0);
				RaidToolLableItemSummary:SetText(l10n.RaidToolLableItemSummary);
				Frame.LableItemSummary = RaidToolLableItemSummary;
				local RaidToolLableEnchantSummary = Frame:CreateFontString(nil, "OVERLAY");
				RaidToolLableEnchantSummary:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
				RaidToolLableEnchantSummary:SetPoint("LEFT", RaidToolLableItemSummary, "LEFT", 60, 0);
				RaidToolLableEnchantSummary:SetText(l10n.RaidToolLableEnchantSummary);
				Frame.LableEnchantSummary = RaidToolLableEnchantSummary;
				local RaidToolLableGemSummary = nil;
				if VT.__support_gem then
					RaidToolLableGemSummary = Frame:CreateFontString(nil, "OVERLAY");
					RaidToolLableGemSummary:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
					RaidToolLableGemSummary:SetPoint("LEFT", RaidToolLableEnchantSummary, "LEFT", 60, 0);
					RaidToolLableGemSummary:SetText(l10n.RaidToolLableGemSummary);
					Frame.LableGemSummary = RaidToolLableGemSummary;
				end
				local RaidToolLableBossModInfo = Frame:CreateFontString(nil, "OVERLAY");
				RaidToolLableBossModInfo:SetFont(TUISTYLE.RaidToolUIFont, TUISTYLE.RaidToolUIFontSize, TUISTYLE.RaidToolUIFontOutline);
				RaidToolLableBossModInfo:SetPoint("LEFT", RaidToolLableGemSummary or RaidToolLableEnchantSummary, "LEFT", 60, 0);
				RaidToolLableBossModInfo:SetWidth(120);
				RaidToolLableBossModInfo:SetText(l10n.RaidToolLableBossModInfo);
				Frame.LableBossModInfo = RaidToolLableBossModInfo;
			--

			local GuildList = CreateFrame('CHECKBUTTON', nil, Frame, "OptionsBaseCheckButtonTemplate");
			GuildList:SetSize(16, 16);
			GuildList:SetHitRectInsets(0, 0, 0, 0);
			GuildList:ClearAllPoints();
			GuildList:Show();
			GuildList:SetChecked(false);
			GuildList:SetPoint("BOTTOMRIGHT", -4, 2);
			GuildList:SetScript("OnClick", function(self)
				Frame.guild = self:GetChecked();
				if self.guild then
					GuildRoster();
				end
				Frame.Update();
			end);
			Frame.GuildList = GuildList;

			local GuildListLabel = Frame:CreateFontString(nil, "ARTWORK");
			GuildListLabel:SetFont(GameFontHighlight:GetFont(), 12, TUISTYLE.RaidToolUIFontOutline);
			GuildListLabel:SetText(l10n.GuildList);
			GuildList.Name = GuildListLabel;
			GuildListLabel:SetPoint("RIGHT", GuildList, "LEFT", 0, 0);
		--	Script
			MT._RegisterCallback("CALLBACK_DATA_RECV", function()
				if Frame:IsShown() then
					MT._TimerStart(Frame.UpdateScrollList, 0.2, 1);
				end
			end);
			function Frame.Update(force_update)
				if Frame:IsShown() then
					if Frame.guild then
						UpdateGuildRosterList(Frame, force_update);
					else
						UpdateRaidRosterList(Frame, force_update);
					end
					Frame.UpdateScrollList();
				end
			end
			function Frame.UpdateScrollList()
				if Frame:IsShown() then
					ScrollList:SetNumValue(#RosterList);
					ScrollList:Update();
				end
			end
			function Frame.UpdateGroupRosterList(force_update)
				if Frame:IsShown() and not Frame.guild then
					UpdateRaidRosterList(Frame, force_update);
				end
			end
			function Frame.UpdateGuildRosterList(force_update)
				if Frame:IsShown() and Frame.guild then
					UpdateGuildRosterList(Frame, force_update);
				end
			end
			Frame:SetScript("OnEvent", OnEvent);
			Frame:RegisterEvent("GROUP_ROSTER_UPDATE");
			--	Frame:RegisterEvent("RAID_ROSTER_UPDATE");	--	not triggered in classic
			Frame:RegisterEvent("GUILD_ROSTER_UPDATE");
			MT._TimerStart(function()
				for index = 1, #RosterList do
					local name = RosterList[index];
					if VT.TQueryCache[name] == nil and RosterInfo[name][3] then
						MT.SendQueryRequest(name, nil, false, false);
						local unit = RosterInfo[name][4];
						if unit and CheckInteractDistance(unit, 4) and CanInspect(unit) then
							NotifyInspect(unit);
						end
					end
				end
			end, 1.0);
		--
		return Frame;
	end
	function MT.ToggleRaidToolUI()
		local RaidToolUI = VT.RaidToolUI;
		if RaidToolUI:IsShown() then
			RaidToolUI:Hide();
		else
			RaidToolUI:Show();
		end
	end

	MT.RegisterOnInit('RAIDTOOL', function(LoggedIn)
		VT.RaidToolUI = CreateRaidToolUI();
		if IsInGroup() then
			MT._TriggerCallback("GROUP_ROSTER_UPDATE");
		end
	end);
	MT.RegisterOnLogin('RAIDTOOL', function(LoggedIn)
	end);

-->
