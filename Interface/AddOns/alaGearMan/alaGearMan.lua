--[[--
	by ALA @ 163UI
	Please Keep WOW Addon open-source & Reduce barriers for others.
	复用代码请在显著位置标注来源【ALA@网易有爱】
	请勿加密、乱码、删除空格tab换行符、设置加载依赖
--]]--
----------------------------------------------------------------------------------------------------
local _G = _G;
local __ala_meta__ = _G.__ala_meta__;
local uireimp = __ala_meta__.uireimp;
local autostyle = __ala_meta__.autostyle;

local ADDON, NS = ...;
local L = NS.L;

do
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("agm assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end

----------------------------------------------------------------------------------------------------upvalue LUA
	local math, table, string, bit = math, table, string, bit;
	local type, tonumber, tostring = type, tonumber, tostring;
	local getfenv, setfenv, pcall, xpcall, assert, error, loadstring = getfenv, setfenv, pcall, xpcall, assert, error, loadstring;
	local abs, ceil, floor, max, min, random, sqrt = abs, ceil, floor, max, min, random, sqrt;
	local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat =
			format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat;
	local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
	local next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack = next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack;
	local tConcat = table.concat;
	local select = select;
	local date, time = date, time;
	local C_Timer = C_Timer;
	----------------------------------------------------------------------------------------------------
	local _ = nil;
	local GameTooltip = GameTooltip;
	local ItemRefTooltip = ItemRefTooltip;
----------------------------------------------------------------------------------------------------
local GUID = UnitGUID('player');
local saved_sets = {  };
local default_sv = {
	sets = {  },
	useBar = true,
	quickSize = 18,
	quickStyle = 'C',	--'T' 'C' 'TC'
	quickPos = { "TOP", 0, - 100, },
	quickPosChar = {  },
	takeoffAll_pos = 'RIGHT',
	takeoffAll_include_neck_finger_and_trinket = false,
	show_outfit_in_tooltip = true,
	multi_lines = false,
	num_per_line = 6,
};
local _PaperDollItemSlotButton_OnEnter = PaperDollItemSlotButton_OnEnter;
local _PaperDollItemSlotButton_OnLeave = PaperDollItemSlotButton_OnLeave;
local SlotInfo = {
	[0] = { INVTYPE_AMMO = 1, },
	[1] = { INVTYPE_HEAD = 1, },
	[2] = { INVTYPE_NECK = 1, },
	[3] = { INVTYPE_SHOULDER = 1, },
	[4] = { INVTYPE_BODY = 1, },
	[5] = { INVTYPE_CHEST = 1, INVTYPE_ROBE = 1, },
	[6] = { INVTYPE_WAIST = 1, },
	[7] = { INVTYPE_LEGS = 1, },
	[8] = { INVTYPE_FEET = 1, },
	[9] = { INVTYPE_WRIST = 1, },
	[10] = { INVTYPE_HAND = 1, },
	[11] = { INVTYPE_FINGER = 1, },
	[12] = { INVTYPE_FINGER = 1, },
	[13] = { INVTYPE_TRINKET = 1, },
	[14] = { INVTYPE_TRINKET = 1, },
	[15] = { INVTYPE_CLOAK = 1, },
	[16] = { INVTYPE_WEAPONMAINHAND = 1, INVTYPE_2HWEAPON = 1, INVTYPE_WEAPON = 1, },
	[17] = { INVTYPE_WEAPON = 1, INVTYPE_WEAPONOFFHAND = 1, INVTYPE_SHIELD = 1, INVTYPE_HOLDABLE = 1, },
	[18] = { INVTYPE_RANGED = 1, INVTYPE_RANGEDRIGHT = 1, INVTYPE_THROWN = 1, INVTYPE_RELIC = 1, },
	[19] = { INVTYPE_TABARD = 1, },
};
local loc2Slot = {  };
for slot, v in next, SlotInfo do
	for loc, _ in next, v do
		loc2Slot[loc] = loc2Slot[loc] or {  };
		tinsert(loc2Slot[loc], slot);
	end
end
local slot2Name = {
	[0] = "CharacterAmmoSlot",
	[1] = "CharacterHeadSlot",
	[2] = "CharacterNeckSlot",
	[3] = "CharacterShoulderSlot",
	[4] = "CharacterShirtSlot",
	[5] = "CharacterChestSlot",
	[6] = "CharacterWaistSlot",
	[7] = "CharacterLegsSlot",
	[8] = "CharacterFeetSlot",
	[9] = "CharacterWristSlot",
	[10] = "CharacterHandsSlot",
	[11] = "CharacterFinger0Slot",
	[12] = "CharacterFinger1Slot",
	[13] = "CharacterTrinket0Slot",
	[14] = "CharacterTrinket1Slot",
	[15] = "CharacterBackSlot",
	[16] = "CharacterMainHandSlot",
	[17] = "CharacterSecondaryHandSlot",
	[18] = "CharacterRangedSlot",
	[19] = "CharacterTabardSlot",
};
local name2Slot = {  };
for slot, name in next, slot2Name do
	name2Slot[name] = slot;
end
local takeoffAll_order = {	-- by price
	16, 17, 18, 1, 5, 7, 3, 6, 8, 10, 9, 2, 11, 12, 13, 14, 15,--[[ 4,]]--[[ 19,]]
};
local NAME = "alaGearMan";
local SECURE_QUICK_NAME_PREFIX = "alaGearMan_SecureQuick";
local MACRO_NAME_PREFIX = "alaGearMan";
local NUM_GEAR_BINDING = 9;
--------------------------------------------------
----------------------------------------------------------------------------------------------------main
local function _log_(...)
	-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
end
local function _error_(...)
	print(date('\124cffff0000%H:%M:%S\124r'), ...);
end
local function _noop_()
end

local PDF_COUNTING_TIME = 0.5;
local PDF_UPDATE_TIME = 0.5;
local num_button_per_line = 6;
local buttonSize = 36;
local texture_unk = 134400;	--"Interface\\Icons\\inv_misc_questionmark";
local texture_open = "interface\\AddOns\\alaGearMan\\ARTWORK\\ui-gearmanager-button";
local texture_takeoff = "Interface\\AddOns\\alaGearMan\\ARTWORK\\ui-gearmanager-leaveitem-opaque";
local texture_ignore = "Interface\\AddOns\\alaGearMan\\ARTWORK\\ui-gearmanager-undo";
local texture_add = "interface\\paperdollinfoframe\\character-plus";
local texture_highlight = "Interface\\Buttons\\ButtonHilight-Square";
local texture_highlight_coord = { 0.05, 0.95, 0.05, 0.95, };
local texture_glow = "Interface\\Buttons\\UI-ActionButton-Border";
local texture_glow_coord = { 0.25, 0.75, 0.25, 0.75, };
local texture_ignore_mask = "Interface\\paperdollinfoframe\\ui-gearmanager-leaveitem-transparent";
local texture_delete = "interface\\raidframe\\readycheck-notready";
local texture_modify = "interface\\scenarios\\scenarioicon-interact";
local texture_up = "interface\\AddOns\\alaGearMan\\ARTWORK\\ui-mainmenu-scrollupbutton-up";
local texture_down = "interface\\AddOns\\alaGearMan\\ARTWORK\\ui-mainmenu-scrolldownbutton-up";
local texture_style_char = "interface\\buttons\\checkbuttonhilight";

local buttonBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 2,
	edgeSize = 2,
	insets = { left = 0, right = 0, top = 0, bottom = 0 }
};
local buttonBackdropColor = { 0.25, 0.25, 0.25, 0.75 };
local buttonBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0 };

local win_SizeX = 240;
local win_SizeY = 360;
local btn_SizeY = 36;
----------------------------------------------------------------------------------------------------main
local _EventHandler = CreateFrame("FRAME");
_EventHandler:SetSize(4, 4);
_EventHandler:EnableMouse(false);

local T_Scheduler = setmetatable({  }, { __mode = 'k', })
function NS.F_ScheduleDelayCall(func, delay)
	local sch = T_Scheduler[func];
	if sch == nil then
		sch = {  };
		sch[1] = function()
			func();
			sch[2] = false;
		end;
	elseif sch[2] then
		return;
	end
	sch[2] = true;
	C_Timer.After(delay or 0.2, sch[1]);
end

--EquipItemByName(id/name/link, slot)
--RepairAllItems

local ui = { pdf_buttons = {  }, pdf_ignore_mask = {  },  };
local func = {  };
local var = {
	pdf_list = {  }, pdf_cur_slot = nil, pdf_cur_anchor = nil, pdf_update_timer = 0,
	pdf_ofs_ignore = nil, pdf_ofs_takeoff = nil,

	gm_cur_set = nil, 	--cur selected set / vary with delete action
	gm_prev_clicked_set = nil, gm_prev_clicked_time = -9999,
	gm_is_editing = nil, gm_editing_set = nil, gm_custom_icon_selected = nil, 
	gm_ignore = {  },
	cache = {  },
	bagItemCache1 = {  }, bagItemCache2 = {  }, itemLoc = ItemLocation:CreateEmpty();

	isBankOpened = false,
};
local global_var = {
	drop_table = {  },
};
local iconTable = {
	texture_unk, 
	-- 136033, 132141, 132136, 132121, 132118, 134296, 136231, 
	-- 132122, 132142, 132091, 132127, 132140, 132242, 132089, 132152, 
	-- 132114, 132120, 132320, 132090, 132155, 132310, 132297, 132294, 
	-- 132302, 132282, 132354, 132219, 132274, 136066, 132273, 132290, 
	-- 136189, 132292, 132307, 132306, 132331, 136012, 132355, 134951, 
	-- 132223, 132338, 136105, 
	132349, 132341, 132275, 132282, 132337, 132155, 132333, 136105, 132316, 136080, 132363, 
	132223, 132110, 135358, 132362, 132369, 136012, 132355, 134951, 135920, 135906, 135959, 135964, 
	135928, 135970, 135968, 135907, 135967, 135943, 135966, 135926, 135995, 136051, 135934, 135972, 
	136048, 136052, 136026, 135813, 135127, 136018, 136015, 136114, 136042, 135861, 132292, 136189, 
	132090, 132307, 132310, 132306, 132219, 132092, 136175, 136168, 136023, 136206, 136183, 135932, 
	135812, 135843, 135846, 136096, 136071, 135848, 136116, 135826, 136153, 135857, 135736, 135852, 
	135991, 135869, 135808, 135903, 135841, 135824, 135988, 136006, 136078, 136041, 136081, 132136, 
	136085, 132114, 136033, 135753, 135987, 136207, 135940, 135953, 136224, 136184, 135894, 136123, 
	136200, 135946, 132204, 132218, 132212, 136076, 132330, 132169, 132208, 132293, 135815, 132157, 
	135130, 132329, 136185, 135817, 136197, 136118, 136139, 135230, 136210, 136186, 136135, 
};

function func.pdf_CreateButton(index)
	local button = CreateFrame("BUTTON", nil, ui.pdf_menu);
	button:SetSize(buttonSize, buttonSize);
	button:EnableMouse(true);
	button:SetNormalTexture(texture_unk);
	button:SetPushedTexture(texture_unk);
	button:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
	button:SetHighlightTexture(texture_highlight);
	button:GetHighlightTexture():SetTexCoord(unpack(texture_highlight_coord));

	if autostyle ~= nil then
		autostyle:AddReskinObject(button, "BUTTON.WITH.TEXTURE");
	end

	local glow = button:CreateTexture(nil, "OVERLAY");
	glow:SetAllPoints();
	glow:SetTexture(texture_glow);
	glow:SetBlendMode("ADD");
	glow:SetTexCoord(unpack(texture_glow_coord));
	-- glow:SetAlpha(0.75);
	glow:Show();
	button.glow = glow;
	button:SetScript("OnEnter", function(self, button)
		local id = self.id;
		GameTooltip:Hide();
		if id > #var.pdf_list then
		else
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltip:SetHyperlink(var.pdf_list[id]);
			GameTooltip:Show();
		end
		ui.pdf_menu.countingTime = nil;
	end);
	button:SetScript("OnLeave", function(self, button)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide();
		end
		ui.pdf_menu.countingTime = PDF_COUNTING_TIME;
	end);
	button:SetScript("OnClick", function(self, button)
		local id = self.id;
		if var.pdf_ofs_ignore and id == #var.pdf_list + var.pdf_ofs_ignore then
			var.gm_ignore[var.pdf_cur_slot] = not var.gm_ignore[var.pdf_cur_slot];
			if var.gm_ignore[var.pdf_cur_slot] then
				ui.pdf_ignore_mask[var.pdf_cur_slot]:Show();
			else
				ui.pdf_ignore_mask[var.pdf_cur_slot]:Hide();
			end
		elseif var.pdf_ofs_takeoff and id == #var.pdf_list + var.pdf_ofs_takeoff then
			if not InCombatLockdown() or var.pdf_cur_slot == 16 or var.pdf_cur_slot == 17 or var.pdf_cur_slot == 18 then
				func.takeoff(var.pdf_cur_slot);
			end
		else
			if not InCombatLockdown() then
				func.equipItem(var.pdf_list[id], var.pdf_cur_slot);
				ui.pdf_menu.countingTime = - 1.0;
			end
		end
	end);
	ui.pdf_buttons[index] = button;
	button.id = index;
	return button;
end
function func.pdf_CreateMenu(direction)
	local hasInv = GetInventoryItemID('player', var.pdf_cur_slot) ~= nil;
	local nButtons = (hasInv and 1 or 0) + ((var.gm_is_editing or var.gm_cur_set) and 1 or 0) + #var.pdf_list
	if nButtons > #ui.pdf_buttons then
		for i = #ui.pdf_buttons + 1, nButtons do
			func.pdf_CreateButton(i);
		end
	elseif nButtons < #ui.pdf_buttons then
		for i = nButtons + 1, #ui.pdf_buttons do
			ui.pdf_buttons[i]:Hide();
		end
	end
	for i = 1, #var.pdf_list do
		local button = ui.pdf_buttons[i];
		local name, _, quality, _, _, _, _, _, _, t = GetItemInfo(var.pdf_list[i]);
		button:SetNormalTexture(t);
		button:SetPushedTexture(t);
		button.glow:SetVertexColor(GetItemQualityColor(quality));
		button.glow:Show();
		button:Show();
	end
	if hasInv then
		var.pdf_ofs_takeoff = 1;
		local i = #var.pdf_list + var.pdf_ofs_takeoff;
		local button = ui.pdf_buttons[i];
		button:SetNormalTexture(texture_takeoff);
		button:SetPushedTexture(texture_takeoff);
		-- button.glow:SetVertexColor(1.0, 0.0, 0.0);
		button.glow:Hide();
		button:Show();
	else
		var.pdf_ofs_takeoff = nil;
	end
	if var.gm_is_editing or var.gm_cur_set then
		var.pdf_ofs_ignore = (hasInv and 1 or 0) + 1;
		local i = #var.pdf_list + var.pdf_ofs_ignore;
		local button = ui.pdf_buttons[i];
		button:SetNormalTexture(texture_ignore);
		button:SetPushedTexture(texture_ignore);
		-- button.glow:SetVertexColor(1.0, 0.0, 0.0);
		button.glow:Hide();
		button:Show();
	else
		var.pdf_ofs_ignore = nil;
	end
	local pos = 2;
	local lines = 1;
	for i = 2, nButtons do
		local button = ui.pdf_buttons[i];
		if pos > num_button_per_line then
			button:SetPoint("TOP", ui.pdf_buttons[i - num_button_per_line], "BOTTOM", 0, -2);
			pos = 1;
			lines = lines + 1;
		else
			button:SetPoint("LEFT", ui.pdf_buttons[i - 1], "RIGHT", 2, 0);
			pos = pos + 1;
		end
	end
	if lines == 1 then
		ui.pdf_menu:SetSize(buttonSize * (pos - 1) + 2 * (pos - 2), buttonSize);
	else
		ui.pdf_menu:SetSize(buttonSize * num_button_per_line + 2 * (num_button_per_line - 2), buttonSize * lines + 2 * (lines - 1));
	end
	ui.pdf_menu:ClearAllPoints();
	if direction == 1 then	  --down
		if ui.pdf_menu:GetWidth() > var.pdf_cur_anchor:GetBottom() then
			ui.pdf_menu:SetPoint("BOTTOM", var.pdf_cur_anchor, "TOP", 0, 2);
		else
			ui.pdf_menu:SetPoint("TOP", var.pdf_cur_anchor, "BOTTOM", 0, -2);
		end
	elseif direction == 2 then  --slots in left
		if ui.pdf_menu:GetWidth() > var.pdf_cur_anchor:GetLeft() then
			ui.pdf_menu:SetPoint("LEFT", var.pdf_cur_anchor, "RIGHT", 2, 0);
		else
			ui.pdf_menu:SetPoint("RIGHT", var.pdf_cur_anchor, "LEFT", -2, 0);
		end
	elseif direction == 3 then  --slot in right
		if ui.pdf_menu:GetWidth() > GetScreenWidth() - var.pdf_cur_anchor:GetRight() then
			ui.pdf_menu:SetPoint("RIGHT", var.pdf_cur_anchor, "LEFT", -2, 0);
		else
			ui.pdf_menu:SetPoint("LEFT", var.pdf_cur_anchor, "RIGHT", 2, 0);
		end
	end
end

function func.pdf_EventHandler_OnUpdate(self, elasped)
	if var.pdf_update_timer <= 0.0 then
		if IsAltKeyDown() then
			local slot = var.pdf_cur_slot;
			if slot then
				_PaperDollItemSlotButton_OnLeave(var.pdf_cur_anchor);
				wipe(var.pdf_list);
				local slotHash = SlotInfo[slot];
				for i = var.isBankOpened and -1 or 0, var.isBankOpened and 11 or 4 do
					for j = 1, GetContainerNumSlots(i) do
						local link = GetContainerItemLink(i, j);
						if link and IsEquippableItem(link) then
							local loc = select(9, GetItemInfo(link));
							if slotHash[loc] then
								tinsert(var.pdf_list, link);
							end
						end
					end
				end
				if slot == 0 or slot == 16 or slot == 17 or slot == 18 then
					func.pdf_CreateMenu(1);
				elseif slot == 1 or slot == 2 or slot == 3 or slot == 4 or slot == 5 or slot == 9 or slot == 15 or slot == 19 then
					func.pdf_CreateMenu(2);
				else
					func.pdf_CreateMenu(3);
				end
				ui.pdf_menu.countingTime = nil;
				ui.pdf_menu:Show();
			end
		else
			ui.pdf_menu:Hide();
			--_PaperDollItemSlotButton_OnEnter(var.pdf_cur_anchor);
		end
		var.pdf_update_timer = PDF_UPDATE_TIME;
	else
		if IsAltKeyDown() then
			if not ui.pdf_menu:IsShown() then
				var.pdf_update_timer = 0.0;
				func.pdf_EventHandler_OnUpdate(nil, 0.0);
			else
				var.pdf_update_timer = var.pdf_update_timer - elasped;
			end
		else
			ui.pdf_menu:Hide();
		end
	end
end

function func.pdf_init()
	for i, n in next, slot2Name do
		local sf = _G[n];
		local ignore_mask = sf:CreateTexture(nil, "OVERLAY");
		ignore_mask:SetAllPoints();
		ignore_mask:SetTexture(texture_ignore_mask);
		ignore_mask:Hide();
		ui.pdf_ignore_mask[i] = ignore_mask;
	end
	ui.pdf_menu = CreateFrame("FRAME", nil, PaperDollFrame);
	ui.pdf_menu:SetFrameStrata("FULLSCREEN_DIALOG");
	ui.pdf_menu:SetScript("OnEnter", function(self)
		self.countingTime = nil;
	end);
	ui.pdf_menu:SetScript("OnLeave", function(self)
		self.countingTime = PDF_COUNTING_TIME;
	end);
	ui.pdf_menu:SetScript("OnUpdate", function(self, elasped)
		if self.countingTime then
			self.countingTime = self.countingTime - elasped;
			if self.countingTime <= 0.0 then
				self:Hide();
				self.countingTime = nil;
				wipe(var.pdf_list);
			end
		end
	end);
	ui.pdf_menu:SetScript("OnHide", function(self)
		if var.pdf_cur_anchor then
			_PaperDollItemSlotButton_OnEnter(var.pdf_cur_anchor);
		end
	end);

	func.pdf_CreateButton(1);
	ui.pdf_buttons[1]:SetPoint("TOPLEFT");

	local handler = CreateFrame("FRAME");
	_G.PaperDollItemSlotButton_OnEnter = function(self)
		var.pdf_cur_anchor = self;
		local slot = name2Slot[self:GetName()];
		if slot then
			var.pdf_cur_slot = slot;
			var.pdf_update_timer = 0.0;
			handler:SetScript("OnUpdate", func.pdf_EventHandler_OnUpdate);
			ui.pdf_menu.countingTime = nil;
			ui.pdf_menu:Show();
		end
		if not IsAltKeyDown() then
			return _PaperDollItemSlotButton_OnEnter(self);
		end
	end
	_G.PaperDollItemSlotButton_OnLeave = function(self)
		var.pdf_cur_anchor = nil;
		handler:SetScript("OnUpdate", nil);
		ui.pdf_menu.countingTime = PDF_COUNTING_TIME;
		return _PaperDollItemSlotButton_OnLeave(self);
	end
end
function func.pdf_hide_mask()
	for slot, mask in next, ui.pdf_ignore_mask do
		mask:Hide();
		var.gm_ignore[slot] = false;
	end
end
function func.pdf_show_mask(set)
	for slot, mask in next, ui.pdf_ignore_mask do
		if set[slot] == -1 then
			ui.pdf_ignore_mask[slot]:Show();
			var.gm_ignore[slot] = true;
		else
			ui.pdf_ignore_mask[slot]:Hide();
			var.gm_ignore[slot] = false;
		end
	end
end

function func.OnEnter_Info_Outfit(self, index)
	local T, isCur = func.check(index);
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	if T then
		GameTooltip:AddLine(T.name, 1.0, 1.0, 1.0);
		if isCur then
			GameTooltip:AddLine(L["CURRENT_OUTFIT"], 0.0, 1.0, 0.0);
		else
			local set = saved_sets[index];
			local missed = false;
			for slot = 1, 19 do
				local link = T[slot];
				if type(link) == 'string' then
					missed = true;
					GameTooltip:AddDoubleLine(L.slot[slot] .. L["TOOLTIP_MISSING"], link, 1.0, 0.0, 0.0);
				end
			end
			if not missed then
				-- 
			end
			for slot = 1, 19 do
				if T[slot] == 0 then
					local link = set[slot];
					GameTooltip:AddDoubleLine(L.slot[slot] .. L["IN_BAG"], link, 1.0, 1.0, 0.0);
				end
			end
			for slot = 1, 19 do
				if T[slot] == 1 then
					local link = set[slot];
					GameTooltip:AddDoubleLine(L.slot[slot] .. L["SHOULD_TAKE_OFF"], link, 1.0, 1.0, 0.0);
				end
			end
		end
	else
	end
	GameTooltip:Show();
end
function func.OnEnter_Info(self)
	if self.info then
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
		for _, msg in next, self.info do
			GameTooltip:AddLine(msg);
		end
		GameTooltip:Show();
	end
end
function func.OnLeave_Info(self)
	if GameTooltip:GetOwner() == self then
		GameTooltip:Hide();
	end
end
function func.Sound_Equip()
	PlaySound(841);
end
function func.Sound_Save()
	PlaySound(841);
end
function func.Sound_Show()
	PlaySound(841);
end
function func.Sound_Hide()
	PlaySound(851);
end
function func.Sound_Order()
	PlaySound(842);
end

StaticPopupDialogs["alaGearMan_DelSet"] = {
	text = L["Delete this outfit?"],
	button1 = L["OK"],
	button2 = L["Cancel"],
	OnShow = function(self) end,
	OnAccept = function(self)
		func.delete_onclick();
		-- self.which = nil;
	end,
	OnHide = function(self)
		self.which = nil;
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 1,
};

function func.gm_CreateButton(parent, index, buttonHeight)
	-- print("CREATE", index)
	local button = CreateFrame("BUTTON", nil, parent);
	button:SetHeight(buttonHeight);
	uireimp._SetBackdrop(button, buttonBackdrop);
	uireimp._SetBackdropColor(button, buttonBackdropColor[1], buttonBackdropColor[2], buttonBackdropColor[3], buttonBackdropColor[4]);
	uireimp._SetBackdropBorderColor(button, buttonBackdropBorderColor[1], buttonBackdropBorderColor[2], buttonBackdropBorderColor[3], buttonBackdropBorderColor[4]);
	button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
	button:EnableMouse(true);
	button:RegisterForDrag("LeftButton");
	button:Show();

	if autostyle ~= nil then
		autostyle:AddReskinObject(button, "BUTTON.WITH.TEXTURE");
	end

	local icon = button:CreateTexture(nil, "OVERLAY");
	icon:SetTexture(texture_unk);
	icon:SetSize(buttonHeight - 4, buttonHeight - 4);
	icon:SetPoint("LEFT", 4, 0);
	button.icon = icon;

	if autostyle ~= nil then
		autostyle:AddReskinObject(icon, "TEXTURE");
	end

	local title = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
	title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
	button.title = title;

	local glow_current = button:CreateTexture(nil, "OVERLAY");
	glow_current:SetTexture(texture_glow);
	glow_current:SetTexCoord(unpack(texture_glow_coord));
	glow_current:SetVertexColor(1.0, 0.5, 0.0, 1.0);
	glow_current:SetAllPoints();
	glow_current:SetBlendMode("ADD");
	glow_current:Hide();
	button.glow_current = glow_current;

	local glow_selected = button:CreateTexture(nil, "OVERLAY");
	glow_selected:SetTexture(texture_glow);
	glow_selected:SetTexCoord(unpack(texture_glow_coord));
	glow_selected:SetAllPoints();
	glow_selected:SetBlendMode("ADD");
	glow_selected:Hide();
	button.glow_selected = glow_selected;

	local delete = CreateFrame("BUTTON", nil, button);
	delete:SetSize(buttonHeight * 0.4, buttonHeight * 0.4);
	delete:SetNormalTexture(texture_delete);
	delete:SetPushedTexture(texture_delete);
	delete:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
	delete:SetPoint("TOPRIGHT", -4, -2);
	delete:Show();
	delete:SetScript("OnEnter", func.OnEnter_Info);
	delete:SetScript("OnLeave", func.OnLeave_Info);
	delete:SetScript("OnClick", function(self)
		local index = button:GetDataIndex();
		if var.gm_is_editing and var.gm_editing_set == index then
			ui.custom:Hide();
		end
		var.gm_editing_set = index;
		StaticPopup_Show("alaGearMan_DelSet");
	end);
	-- delete.info = {  };
	button.delete = delete;
	-- func.StyleObject('button', delete);

	local modify = CreateFrame("BUTTON", nil, button);
	modify:SetSize(buttonHeight * 0.4, buttonHeight * 0.4);
	modify:SetNormalTexture(texture_modify);
	modify:SetPushedTexture(texture_modify);
	modify:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
	modify:SetPoint("BOTTOMRIGHT", -4, 2);
	modify:Show();
	modify:SetScript("OnEnter", func.OnEnter_Info);
	modify:SetScript("OnLeave", func.OnLeave_Info);
	modify:SetScript("OnClick", function(self)
		ui.custom:CustomShow(button:GetDataIndex());
	end);
	-- modify.info = {  };
	button.modify = modify;
	-- func.StyleObject('button', modify);

	local up = CreateFrame("BUTTON", nil, button);
	up:SetSize(buttonHeight * 0.4, buttonHeight * 0.4);
	up:SetNormalTexture(texture_up);
	up:SetPushedTexture(texture_up);
	up:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
	up:SetDisabledTexture(texture_up);
	up:GetDisabledTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
	up:SetPoint("TOPRIGHT", -6 - buttonHeight * 0.4, -2);
	up:Show();
	up:SetScript("OnEnter", func.OnEnter_Info);
	up:SetScript("OnLeave", func.OnLeave_Info);
	up:SetScript("OnClick", function(self)
		func.up(button:GetDataIndex());
	end);
	-- up.info = {  };
	button.up = up;
	-- func.StyleObject('button', up);

	local down = CreateFrame("BUTTON", nil, button);
	down:SetSize(buttonHeight * 0.4, buttonHeight * 0.4);
	down:SetNormalTexture(texture_down);
	down:SetPushedTexture(texture_down);
	down:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
	down:SetDisabledTexture(texture_down);
	down:GetDisabledTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
	down:SetPoint("BOTTOMRIGHT", -6 - buttonHeight * 0.4, 2);
	down:Show();
	down:SetScript("OnEnter", func.OnEnter_Info);
	down:SetScript("OnLeave", func.OnLeave_Info);
	down:SetScript("OnClick", function(self)
		func.down(button:GetDataIndex());
	end);
	-- down.info = {  };
	button.down = down;
	-- func.StyleObject('button', down);

	local helmet = CreateFrame("CHECKBUTTON", nil, button, "OptionsBaseCheckButtonTemplate");
	helmet:SetSize(buttonHeight * 0.4, buttonHeight * 0.4);
	helmet:SetHitRectInsets(0, 0, 0, 0);
	helmet:SetPoint("TOPRIGHT", -8 - buttonHeight * 0.8, -2);
	helmet:Show();
	local helmetStr = helmet:CreateFontString(nil, "ARTWORK");
	helmetStr:SetFont(GameFontHighlightSmall:GetFont(), 13, "OUTLINE");
	helmetStr:SetText(L.slot[1]);
	helmet.fontString = helmetStr;
	helmetStr:SetPoint("RIGHT", helmet, "LEFT", 0, 0);
	helmet:SetScript("OnClick", function(self)
		func.helmet(button:GetDataIndex(), self:GetChecked());
	end);
	button.helmet = helmet;
	func.StyleObject('check', helmet);

	local cloak = CreateFrame("CHECKBUTTON", nil, button, "OptionsBaseCheckButtonTemplate");
	cloak:SetSize(buttonHeight * 0.4, buttonHeight * 0.4);
	cloak:SetHitRectInsets(0, 0, 0, 0);
	cloak:SetPoint("BOTTOMRIGHT", -8 - buttonHeight * 0.8, 2);
	cloak:Show();
	local cloakStr = cloak:CreateFontString(nil, "ARTWORK");
	cloakStr:SetFont(GameFontHighlightSmall:GetFont(), 13, "OUTLINE");
	cloakStr:SetText(L.slot[15]);
	cloak.fontString = cloakStr;
	cloakStr:SetPoint("RIGHT", cloak, "LEFT", 0, 0);
	cloak:SetScript("OnClick", function(self)
		func.cloak(button:GetDataIndex(), self:GetChecked());
	end);
	button.cloak = cloak;
	func.StyleObject('check', cloak);

	function button:SetIconTexture(tex)
		icon:SetTexture(tex);
	end
	function button:SetTitleText(text)
		title:SetText(text);
	end
	function button:Current()
		self.current = true;
		self.glow_current:Show();
	end
	function button:NonCurrent()
		self.current = false;
		self.glow_current:Hide();
	end
	function button:Select()
		self.selected = true;
		self.glow_selected:Show();
	end
	function button:Deselect()
		self.selected = nil;
		self.glow_selected:Hide();
	end
	function button:IsSelected()
		return self.selected;
	end
	button:SetScript("OnClick", function(self)
		local dataIndex = self:GetDataIndex();
		if dataIndex > #saved_sets then
			if var.gm_cur_set then
				ui.scroll:CallButtonFuncByDataIndex(var.gm_cur_set, "Deselect");
			end
			var.gm_cur_set = nil;
			var.gm_prev_clicked_set = nil;
			func.pdf_hide_mask();
			func.new_onclick();
		elseif dataIndex == var.gm_prev_clicked_set and GetTime() - var.gm_prev_clicked_time <= 0.5 then
			var.gm_cur_set = dataIndex;
			self:Select();
			var.gm_prev_clicked_set = nil;
			func.equip();
			func.pdf_show_mask(saved_sets[dataIndex] or {  });
		elseif dataIndex == var.gm_cur_set then
			var.gm_prev_clicked_set = var.gm_cur_set;
			var.gm_prev_clicked_time = GetTime();
			var.gm_cur_set = nil;
			self:Deselect();
			func.pdf_hide_mask();
		else
			if var.gm_cur_set then
				ui.scroll:CallButtonFuncByDataIndex(var.gm_cur_set, "Deselect");
			end
			var.gm_cur_set = dataIndex;
			self:Select();
			var.gm_prev_clicked_set = dataIndex;
			var.gm_prev_clicked_time = GetTime();
			func.pdf_show_mask(saved_sets[var.gm_cur_set] or {  });
		end
	end);
	button:SetScript("OnEnter", function(self)
		local index = button:GetDataIndex();
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
		if index > 0 and index <= #saved_sets then
			func.OnEnter_Info_Outfit(self, index);
		else
			GameTooltip:AddLine(L["Add a new outfit"], 1.0, 1.0, 1.0);
		end
		GameTooltip:Show();
	end);
	button:SetScript("OnLeave", func.OnLeave_Info);
	button:SetScript("OnDragStart", function(self)
		if alaGearManSV.UseMacro then
			local index = button:GetDataIndex();
			local macro_name = MACRO_NAME_PREFIX .. index;
			if GetMacroInfo(macro_name) then
				PickupMacro(macro_name);
			end
		end
	end);

	button.id = index;

	return button;
end
function func.gm_SetButton(button, index)
	local sets = saved_sets;
	if index <= #sets then
		button:SetIconTexture(iconTable[sets[index].icon or 1]);
		button:SetTitleText(sets[index].name or "UNK_NAME");
		button:Show();
		local T, isCur = func.check(index);
		if isCur then
			button:Current();
		else
			button:NonCurrent();
		end
		if button:IsSelected() and button:GetDataIndex() ~= var.gm_cur_set then
			button:Deselect();
		elseif not button:IsSelected() and button:GetDataIndex() == var.gm_cur_set then
			button:Select();
		end
		button.delete:Show();
		button.modify:Show();
		button.up:Show();
		button.down:Show();
		button.helmet:Show();
		button.cloak:Show();
		if index == 1 then
			button.up:Disable();
		else
			button.up:Enable();
		end
		if index == #saved_sets then
			button.down:Disable();
		else
			button.down:Enable();
		end
		local cur = saved_sets[index];
		if cur.helmet then
			button.helmet:SetChecked(true);
		else
			button.helmet:SetChecked(false);
		end
		if cur.cloak then
			button.cloak:SetChecked(true);
		else
			button.cloak:SetChecked(false);
		end
		if GetMouseFocus() == button then
			button:GetScript("OnEnter")(button);
		end
	elseif index == #sets + 1 then
		button:SetIconTexture(texture_add);
		button:SetTitleText(L["Add a new outfit"]);
		button:Show();
		button:NonCurrent();
		if button:IsSelected() and button:GetDataIndex() ~= var.gm_cur_set then
			button:Deselect();
		elseif not button:IsSelected() and button:GetDataIndex() == var.gm_cur_set then
			button:Select();
		end
		button.delete:Hide();
		button.modify:Hide();
		button.up:Hide();
		button.down:Hide();
		button.helmet:Hide();
		button.cloak:Hide();
	else
		button:Hide();
	end
end

function func.get_pos(frame)
	local pos = { frame:GetPoint() };
	for index, val in next, pos do
		if type(val) == 'table' then
			pos[index] = val:GetName();
		elseif type(val) ~= 'number' and type(val) ~= 'string' then
			pos[index] = nil;
		end
	end
	return pos;
end

function func.initUI()
	ui.open = CreateFrame("BUTTON", nil, PaperDollFrame);
	ui.open:SetSize(32, 32);
	ui.open:SetPoint("TOPRIGHT", -40, -40);
	ui.open:SetNormalTexture(texture_open);
	ui.open:SetPushedTexture(texture_open);
	ui.open:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
	ui.open:EnableMouse(true);
	ui.open:SetScript("OnClick", func.open_onclick);

	do	--win
		ui.gearWin = CreateFrame("FRAME", nil, PaperDollFrame);
		ui.gearWin:SetFrameStrata("FULLSCREEN");
		uireimp._SetBackdrop(ui.gearWin, {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "interface\\dialogframe\\ui-dialogbox-border",
			tile = true,
			tileSize = 16,
			edgeSize = 20,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		});
		uireimp._SetBackdropColor(ui.gearWin, 0.0, 0.0, 0.0, 0.9);
		ui.gearWin:SetWidth(win_SizeX);
		-- ui.gearWin:SetPoint("TOPLEFT", PaperDollFrame, "TOPRIGHT");
		-- ui.gearWin:SetPoint("BOTTOMLEFT", PaperDollFrame, "BOTTOMRIGHT");
		-- ui.gearWin:SetSize(240, 128);
		ui.gearWin:SetHeight(win_SizeY);
		ui.gearWin:SetPoint("TOPLEFT", ui.open, "TOPLEFT", 45, 0);
		ui.gearWin:SetScript("OnShow", function()
			ui.scroll:SetNumValue(#saved_sets + 1);
			-- if var.gm_cur_set and saved_sets[var.gm_cur_set] then
			-- 	func.pdf_show_mask(saved_sets[var.gm_cur_set]);
			-- end
			func.Sound_Show();
		end);
		ui.gearWin:SetScript("OnHide", function(self)
			func.pdf_hide_mask();
			var.gm_cur_set = nil;
			func.Sound_Hide();
		end);
		ui.gearWin:Hide();

		if autostyle ~= nil then
			autostyle:AddReskinObject(ui.gearWin);
		end

		ui.scroll = ALASCR(ui.gearWin, win_SizeX - 20, win_SizeY - 64, btn_SizeY, func.gm_CreateButton, func.gm_SetButton);
		ui.scroll:SetPoint("BOTTOMLEFT", 10, 10);

		ui.save = CreateFrame("BUTTON", nil, ui.gearWin, "UIPanelButtonTemplate");
		ui.save:SetPoint("TOPLEFT", win_SizeX / 9, -16);
		ui.save:SetText(L["Save"]);
		ui.save:SetSize(win_SizeX / 3, 24);
		ui.save:SetScript("OnClick", function(self) func.save(); end);

		if autostyle ~= nil then
			autostyle:AddReskinObject(ui.save);
		end

		ui.equip = CreateFrame("BUTTON", nil, ui.gearWin, "UIPanelButtonTemplate");
		ui.equip:SetPoint("TOPLEFT", win_SizeX * 5 / 9, -16);
		ui.equip:SetText(L["Equip"]);
		ui.equip:SetSize(win_SizeX / 3, 24);
		ui.equip:SetScript("OnClick", function(self) func.equip(); end);

		if autostyle ~= nil then
			autostyle:AddReskinObject(ui.equip);
		end

		ui.setting = CreateFrame("BUTTON", nil, ui.gearWin);
		ui.setting:SetSize(24, 24);
		ui.setting:SetNormalTexture(texture_modify);
		ui.setting:SetPushedTexture(texture_modify);
		ui.setting:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
		ui.setting:SetPoint("TOPRIGHT");
		ui.setting:SetScript("OnClick", func.setting);
	end

	if false then	--quick panel
		ui.quick = CreateFrame("FRAME");
		ui.quick:SetPoint(unpack(alaGearManSV.quickPosChar[GUID] or alaGearManSV.quickPos));
		ui.quick:EnableMouse(true);
		ui.quick:SetMovable(true);
		ui.quick:RegisterForDrag("LeftButton");
		ui.quick:Show();
		ui.quick:SetClampedToScreen(true);
		ui.quick:RegisterEvent("PLAYER_REGEN_ENABLED");
		ui.quick:SetScript("OnEvent", function(self, event)
			if self.UpdateOnNextSecureEnv then
				self.UpdateOnNextSecureEnv = false;
				self:Update();
			end
			if self.UpdateKeyBindingOnNextSecureEnv then
				self.UpdateKeyBindingOnNextSecureEnv = false;
				self:UpdateKeyBinding();
			end
		end);
		local pos_on_char = false;
		function ui.quick:SavePos()
			if pos_on_char then
				alaGearManSV.quickPos = func.get_pos(self);
				alaGearManSV.quickPosChar[GUID] = nil;
			else
				alaGearManSV.quickPosChar[GUID] = func.get_pos(self);
			end
		end
		local quickButtons = { n = 0, };
		-- local info = { L["Take_Off_All"], L["CTRL-DRAG-TO-MOVE"], };
		function ui.quick:Create(index)
			if quickButtons[index] then
				quickButtons[index].id = index;
				return quickButtons[index];
			end
			local button = CreateFrame("BUTTON", "alaGearMan_Quick" .. index, ui.quick);
			button:SetSize(alaGearManSV.quickSize, alaGearManSV.quickSize);
			button:Show();
			button:EnableMouse(true);
			button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			button:RegisterForDrag("LeftButton");
			button:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
				if index > 0 and index <= #saved_sets then
					func.OnEnter_Info_Outfit(self, index);
				else
					GameTooltip:AddLine(L["Take_Off_All"], 1.0, 1.0, 1.0);
				end
				GameTooltip:AddLine(L["CTRL-DRAG-TO-MOVE"], 1.0, 1.0, 1.0);
				GameTooltip:Show();
			end);
			button:SetScript("OnLeave", func.OnLeave_Info);
			button:SetScript("OnDragStart", function(self)
				if IsControlKeyDown() then
					pos_on_char = false;
					ui.secure:StartMoving();
				elseif IsShiftKeyDown() then
					pos_on_char = true;
					ui.secure:StartMoving();
				end
			end);
			button:SetScript("OnDragStop", function(self)
				ui.quick:StopMovingOrSizing();
				ui.quick:SavePos();
			end);
			button:SetScript("OnClick", function(self, button)
				local index = (alaGearManSV.takeoffAll_pos == 'LEFT') and (self.id - 1) or self.id;
				if index > 0 and index <= #saved_sets then
					func.equip(index);
				else
					func.takeoffAll();
				end
			end);
			button:SetScript("OnMouseWheel", function(self, delta)
				if IsControlKeyDown() and not InCombatLockdown() then
					alaGearManSV.quickSize = alaGearManSV.quickSize + delta * 2;
					ui.quick:Update();
				end
			end);
			button:SetScript("OnSizeChanged", function(self)
				self.title:SetScale(self:GetWidth() / alaGearManSV.quickSize);
			end);
			local title = button:CreateFontString(nil, "OVERLAY");
			title:SetPoint("CENTER");
			title:SetFont(GameFontNormal:GetFont(), alaGearManSV.quickSize * 0.75, "OUTLINE");
			title:SetVertexColor(1.0, 0.75, 0.0, 1.0);
			button.title = title;
			local icon = button:CreateTexture(nil, "ARTWORK");
			icon:SetAllPoints();
			button.icon = icon;
			function button:SetTitleText(text)
				title:SetText(text);
			end
			function button:SetIconTexture(tex)
				icon:SetTexture(tex);
			end
			function button:ShowTitle(bool)
				if bool then
					title:Show();
				else
					title:Hide();
				end
			end
			function button:ShowIcon(bool)
				if bool then
					icon:Show();
				else
					icon:Hide();
				end
			end
			function button:SetTitleAndIcon(text, texture)
				if alaGearManSV.quickStyle == 'TC' then
					title:SetText(text);
					title:SetTextColor(1.0, 1.0, 1.0);
					icon:SetTexture(texture);
					-- icon:Show();
					title:Show();
				elseif alaGearManSV.quickStyle == 'T' then
					-- title:SetTextColor(1.0, 1.0, 1.0);
					icon:SetTexture(texture);
					-- icon:Show();
					title:Hide();
				elseif alaGearManSV.quickStyle == 'C' then
					title:SetTextColor(1.0, 0.75, 0.0);
					title:SetText(text);
					icon:SetTexture(texture_style_char);
					-- icon:Show();
					title:Show();
				end
			end
			-- button.info = Mixin({  }, info);
			button.id = index;
			quickButtons[index] = button;
			if index == 1 then
				button:SetPoint("TOPLEFT", 2, -2);
			else
				button:SetPoint("LEFT", quickButtons[index - 1], "RIGHT", 2, 0);
			end
			return button;
		end
		function ui.quick:UpdateKeyBinding()
			if InCombatLockdown() then
				self.UpdateKeyBindingOnNextSecureEnv = true;
				print(L["WAITING_FOR_REGEN_ENABLED"]);
				return;
			end
			local N = #saved_sets + 1
			local TOA = (alaGearManSV.takeoffAll_pos == 'LEFT') and 1 or N;
			ClearOverrideBindings(_EventHandler);
			for i = 1, N do
				local button = secureButtons[i];
				local setIndex = i;
				if alaGearManSV.takeoffAll_pos == 'LEFT' then
					setIndex = i - 1;
				end
				if i == TOA then
					local key1, key2 = GetBindingKey("ALAGEARMAN_QUICK_X");
					if key1 then
						SetOverrideBindingClick(_EventHandler, false, key1, button:GetName());
					end
					if key2 then
						SetOverrideBindingClick(_EventHandler, false, key2, button:GetName());
					end
				else
					if setIndex <= NUM_GEAR_BINDING then
						local key1, key2 = GetBindingKey("ALAGEARMAN_QUICK_" .. setIndex);
						if key1 then
							SetOverrideBindingClick(_EventHandler, false, key1, button:GetName());
						end
						if key2 then
							SetOverrideBindingClick(_EventHandler, false, key2, button:GetName());
						end
					end
				end
			end
		end
		function ui.quick:Update()
			local N = #saved_sets + 1
			if quickButtons.n > N then
				for i = max(N + 1, 1), quickButtons.n do
					quickButtons[i]:Hide();
				end
			elseif quickButtons.n < N then
				if #quickButtons < N then
					for i = #quickButtons + 1, N do
						self:Create(i);
					end
				end
				for i = quickButtons.n + 1, N do
					quickButtons[i]:Show();
				end
			end
			quickButtons.n = N;
			local TOA = (alaGearManSV.takeoffAll_pos == 'LEFT') and 1 or N;
			for i = 1, N do
				local button = quickButtons[i];
				button:SetSize(alaGearManSV.quickSize, alaGearManSV.quickSize);
				local setIndex = i;
				if alaGearManSV.takeoffAll_pos == 'LEFT' then
					setIndex = i - 1;
				end
				if i == TOA then
					-- button.info[1] = info[1];
					button:SetTitleAndIcon(L["Take_Off_All_ButtonText"], iconTable[106]);
				else
					-- button.info[1] = saved_sets[setIndex].name;
					button:SetTitleAndIcon(setIndex, iconTable[saved_sets[setIndex].icon or 1]);
				end
			end
			ui.quick:SetSize(N * alaGearManSV.quickSize + (N + 1) * 2, alaGearManSV.quickSize + 2 * 2);
		end
		ui.quickButtons = quickButtons;
		ui.quick:Create(1);	--for take_off_all button
		ui.quick:Update();
		ui.quick:Hide();
	end

	do	--secure quick panel & macro
		ui.secure = CreateFrame("FRAME", nil, UIParent);
		ui.secure:SetPoint(unpack(alaGearManSV.quickPosChar[GUID] or alaGearManSV.quickPos));
		ui.secure:EnableMouse(true);
		ui.secure:SetMovable(true);
		ui.secure:RegisterForDrag("LeftButton");
		ui.secure:Show();
		ui.secure:SetClampedToScreen(true);
		ui.secure:RegisterEvent("PLAYER_REGEN_ENABLED");
		ui.secure:SetScript("OnEvent", function(self, event)
			if self.UpdateOnNextSecureEnv then
				self.UpdateOnNextSecureEnv = false;
				self:Update();
			end
			if self.UpdateKeyBindingOnNextSecureEnv then
				self.UpdateKeyBindingOnNextSecureEnv = false;
				self:UpdateKeyBinding();
			end
			if self.ReArrangeOnNextSecureEnv then
				self.ReArrangeOnNextSecureEnv = false;
				self:ReArrange();
			end
		end);
		local pos_on_char = false;
		function ui.secure:SavePos()
			if pos_on_char then
				alaGearManSV.quickPosChar[GUID] = func.get_pos(self);
			else
				alaGearManSV.quickPos = func.get_pos(self);
				alaGearManSV.quickPosChar[GUID] = nil;
			end
		end
		local secureButtons = { n = 0, };
		-- local info = { L["Take_Off_All"], L["CTRL-DRAG-TO-MOVE"], };
		function ui.secure:Create(index)
			local button = secureButtons[index];
			if button == nil then
				button = CreateFrame("CHECKBUTTON", SECURE_QUICK_NAME_PREFIX .. index, ui.secure, "SecureActionButtonTemplate");
				button:SetAttribute('type', 'macro');
				-- button:SetAttribute('macrotext', '');
				-- SecureHandler_OnLoad(button);
				-- UnregisterStateDriver(button, "page");
				button:SetAttribute('showgrid', 0);
				-- button:SetAttribute("action", ACTION_START + index);
				button:SetSize(alaGearManSV.quickSize, alaGearManSV.quickSize);
				button:EnableMouse(true);
				-- button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
				button:SetClampedToScreen(true);
				button:RegisterForDrag("LeftButton");
				button:Show();
				local glow_hover = button:CreateTexture(nil, "OVERLAY");
				glow_hover:SetTexture(texture_glow);
				glow_hover:SetTexCoord(unpack(texture_glow_coord));
				glow_hover:SetVertexColor(1.0, 1.0, 1.0, 0.5);
				glow_hover:SetAllPoints();
				glow_hover:SetBlendMode("ADD");
				glow_hover:Hide();
				button.glow_hover = glow_hover;
				button:SetScript("OnEnter", function(self)
					GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
					local index = self.id;
					if alaGearManSV.takeoffAll_pos == 'LEFT' then
						index = index - 1;
					end
					if index > 0 and index <= #saved_sets then
						func.OnEnter_Info_Outfit(self, index);
					else
						GameTooltip:AddLine(L["Take_Off_All"], 1.0, 1.0, 1.0);
					end
					GameTooltip:AddLine(L["CTRL-DRAG-TO-MOVE"], 1.0, 1.0, 1.0);
					GameTooltip:Show();
					glow_hover:Show();
				end);
				button:SetScript("OnLeave", function(self)
					func.OnLeave_Info(self);
					glow_hover:Hide();
				end);
				button:SetScript("OnDragStart", function(self)
					if IsControlKeyDown() then
						pos_on_char = false;
						ui.secure:StartMoving();
					elseif IsShiftKeyDown() then
						pos_on_char = true;
						ui.secure:StartMoving();
					end
				end);
				button:SetScript("OnDragStop", function(self)
					ui.secure:StopMovingOrSizing();
					ui.secure:SavePos();
				end);
				button:SetScript("OnMouseWheel", function(self, delta)
					if IsControlKeyDown() and not InCombatLockdown() then
						alaGearManSV.quickSize = alaGearManSV.quickSize + delta * 2;
						ui.secure:Update();
					end
				end);
				button:SetScript("OnSizeChanged", function(self)
					self.title:SetScale(self:GetWidth() / alaGearManSV.quickSize);
				end);

				if autostyle ~= nil then
					autostyle:AddReskinObject(button, "BUTTON.WITH.TEXTURE");
				end
			
				local title = button:CreateFontString(nil, "OVERLAY");
				title:SetPoint("CENTER");
				title:SetFont(GameFontNormal:GetFont(), alaGearManSV.quickSize * 0.75, "OUTLINE");
				title:SetVertexColor(1.0, 0.75, 0.0, 1.0);
				button:SetFontString(title);
				button:SetPushedTextOffset(1, - 1);
				button.title = title;
				local icon = button:CreateTexture(nil, "ARTWORK");
				icon:SetAllPoints();
				button.icon = icon;

				if autostyle ~= nil then
					autostyle:AddReskinObject(icon, "TEXTURE");
				end

				local glow_current = button:CreateTexture(nil, "OVERLAY");
				glow_current:SetTexture(texture_glow);
				glow_current:SetTexCoord(unpack(texture_glow_coord));
				glow_current:SetVertexColor(1.0, 0.5, 0.0, 1.0);
				glow_current:SetAllPoints();
				glow_current:SetBlendMode("ADD");
				glow_current:Hide();
				button.glow_current = glow_current;
				function button:SetTitleText(text)
					title:SetText(text);
				end
				function button:SetIconTexture(tex)
					icon:SetTexture(tex);
				end
				function button:ShowTitle(bool)
					if bool then
						title:Show();
					else
						title:Hide();
					end
				end
				function button:ShowIcon(bool)
					if bool then
						icon:Show();
					else
						icon:Hide();
					end
				end
				function button:SetTitleAndIcon(text, texture)
					if alaGearManSV.quickStyle == 'TC' then
						title:SetText(text);
						title:SetTextColor(1.0, 1.0, 1.0);
						icon:SetTexture(texture);
						icon:SetVertexColor(1.0, 1.0, 1.0, 0.66);
						-- icon:Show();
						title:Show();
					elseif alaGearManSV.quickStyle == 'T' then
						-- title:SetTextColor(1.0, 1.0, 1.0);
						icon:SetTexture(texture);
						icon:SetVertexColor(1.0, 1.0, 1.0, 0.75);
						-- icon:Show();
						title:Hide();
					elseif alaGearManSV.quickStyle == 'C' then
						title:SetTextColor(1.0, 0.75, 0.0);
						title:SetText(text);
						icon:SetTexture(texture_style_char);
						icon:SetVertexColor(1.0, 1.0, 1.0, 0.25);
						-- icon:Show();
						title:Show();
					end
				end
				function button:Current()
					self.glow_current:Show();
				end
				function button:NonCurrent()
					self.glow_current:Hide();
				end
				-- button.info = Mixin({  }, info);
				secureButtons[index] = button;
			else
			end
			button.id = index;
			button:ClearAllPoints();
			if index == 1 then
				button:SetPoint("TOPLEFT", 2, -2);
			else
				if alaGearManSV.multi_lines then
					if (index - 1) % alaGearManSV.num_per_line == 0 then
						button:SetPoint("TOP", secureButtons[index - alaGearManSV.num_per_line], "BOTTOM", 0, -2);
					else
						button:SetPoint("LEFT", secureButtons[index - 1], "RIGHT", 2, 0);
					end
				else
					button:SetPoint("LEFT", secureButtons[index - 1], "RIGHT", 2, 0);
				end
			end
			return button;
		end
		function ui.secure:UpdateKeyBinding()
			if InCombatLockdown() then
				self.UpdateKeyBindingOnNextSecureEnv = true;
				print(L["WAITING_FOR_REGEN_ENABLED"]);
				return;
			end
			local N = #saved_sets + 1
			local TOA = (alaGearManSV.takeoffAll_pos == 'LEFT') and 1 or N;
			ClearOverrideBindings(_EventHandler);
			for i = 1, N do
				local button = secureButtons[i];
				local setIndex = i;
				if alaGearManSV.takeoffAll_pos == 'LEFT' then
					setIndex = i - 1;
				end
				if i == TOA then
					local key1, key2 = GetBindingKey("ALAGEARMAN_QUICK_X");
					if key1 then
						SetOverrideBindingClick(_EventHandler, false, key1, button:GetName());
					end
					if key2 then
						SetOverrideBindingClick(_EventHandler, false, key2, button:GetName());
					end
				else
					if setIndex <= NUM_GEAR_BINDING then
						local key1, key2 = GetBindingKey("ALAGEARMAN_QUICK_" .. setIndex);
						if key1 then
							SetOverrideBindingClick(_EventHandler, false, key1, button:GetName());
						end
						if key2 then
							SetOverrideBindingClick(_EventHandler, false, key2, button:GetName());
						end
					end
				end
			end
		end
		function ui.secure:Update()
			if InCombatLockdown() then
				self.UpdateOnNextSecureEnv = true;
				print(L["WAITING_FOR_REGEN_ENABLED"]);
				return;
			end
			local N = #saved_sets + 1
			if secureButtons.n > N then
				for i = max(N + 1, 1), secureButtons.n do
					secureButtons[i]:Hide();
				end
			elseif secureButtons.n < N then
				if #secureButtons < N then
					for i = #secureButtons + 1, N do
						self:Create(i);
					end
				end
				for i = secureButtons.n + 1, N do
					secureButtons[i]:Show();
				end
			end
			secureButtons.n = N;
			if alaGearManSV.UseMacro then
				local ofs = (alaGearManSV.takeoffAll_pos == 'LEFT') and 1 or 0;
				if GetMacroInfo(MACRO_NAME_PREFIX .. 0) then
					EditMacro(MACRO_NAME_PREFIX .. 0, MACRO_NAME_PREFIX .. 0, iconTable[106], "/run AGM_FUNC.takeoffAll()");
				else
					if GetMacroInfo(120) == nil then
						CreateMacro(MACRO_NAME_PREFIX .. 0, iconTable[106], "/run AGM_FUNC.takeoffAll()");
					else
						print(L["UP_TO_120_MACROS"]);
					end
				end
				for i = 1, #saved_sets do
					local macro_name = MACRO_NAME_PREFIX .. i;
					if GetMacroInfo(macro_name) then
						EditMacro(macro_name, macro_name, iconTable[saved_sets[i].icon or 1], "/click " .. SECURE_QUICK_NAME_PREFIX .. (i + ofs));
					else
						if GetMacroInfo(120) == nil then
							CreateMacro(macro_name, iconTable[saved_sets[i].icon or 1], "/click " .. SECURE_QUICK_NAME_PREFIX .. (i + ofs));
						else
							print(L["UP_TO_120_MACROS"]);
						end
					end
				end
			end
			local TOA = (alaGearManSV.takeoffAll_pos == 'LEFT') and 1 or N;
			for i = 1, N do
				local button = secureButtons[i];
				button:SetSize(alaGearManSV.quickSize, alaGearManSV.quickSize);
				local setIndex = i;
				if alaGearManSV.takeoffAll_pos == 'LEFT' then
					setIndex = i - 1;
				end
				if i == TOA then
					button:SetAttribute('macrotext', "/run AGM_FUNC.takeoffAll()");
					-- button.info[1] = info[1];
					button:SetTitleAndIcon(L["Take_Off_All_ButtonText"], iconTable[106]);
				else
					local macroText = "/run AGM_FUNC.equip(" .. setIndex .. ");\n";
					local set = saved_sets[setIndex];
					for slot = 16, 18 do
						if set[slot] then
							local _, _, name = strfind(set[slot], "\124h%[(.+)%]\124h");
							if name then
								macroText = macroText .. "/equipslot [combat]" .. slot .. " " .. name .. "\n";
							end
						-- else
							-- macroText = macroText .. "/equipslot " .. slot .. " empty\n";
						end
					end
					button:SetAttribute('macrotext', macroText);
					--print(macroText)
					-- button.info[1] = saved_sets[setIndex].name;
					button:SetTitleAndIcon(setIndex, iconTable[saved_sets[setIndex].icon or 1]);
				end
			end
			ui.secure:SetSize(N * alaGearManSV.quickSize + (N + 1) * 2, alaGearManSV.quickSize + 2 * 2);
			self:UpdateKeyBinding();
			func.refreshAppearance();
		end
		function ui.secure:ReArrange()
			if InCombatLockdown() then
				self.ReArrangeOnNextSecureEnv = true;
				print(L["WAITING_FOR_REGEN_ENABLED"]);
				return;
			end
			print('ReArrange', #secureButtons)
			for index = 1, #secureButtons do
				local button = secureButtons[index];
				button:ClearAllPoints();
				if index == 1 then
					button:SetPoint("TOPLEFT", 2, -2);
				else
					if alaGearManSV.multi_lines then
						if (index - 1) % alaGearManSV.num_per_line == 0 then
							button:SetPoint("TOP", secureButtons[index - alaGearManSV.num_per_line], "BOTTOM", 0, -2);
						else
							button:SetPoint("LEFT", secureButtons[index - 1], "RIGHT", 2, 0);
						end
					else
						button:SetPoint("LEFT", secureButtons[index - 1], "RIGHT", 2, 0);
					end
				end
			end
		end
		ui.secureButtons = secureButtons;
		-- ui.secure:Create(1);	--for take_off_all button
		ui.secure:Update();
		-- ui.secure:Hide();
		if not alaGearManSV.useBar then
			ui.secure:Hide();
		end
	end

	do	--customize
		ui.custom = CreateFrame("FRAME", nil, ui.gearWin);
		ui.custom:SetFrameStrata("FULLSCREEN");
		uireimp._SetBackdrop(ui.custom, {
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "interface/dialogframe/ui-dialogbox-border",
			tile = true,
			tileSize = 16,
			edgeSize = 20,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		});
		uireimp._SetBackdropColor(ui.custom, 0.0, 0.0, 0.0, 0.9);
		ui.custom:SetSize(470, 460);
		ui.custom:SetPoint("TOPLEFT", ui.gearWin, "TOPRIGHT", 15, 0);
		ui.custom:Hide();
		ui.custom:SetScript("OnShow", function(self)
			if var.gm_editing_set and saved_sets[var.gm_editing_set] then
				var.gm_custom_icon_selected = saved_sets[var.gm_editing_set].icon or 1;
				ui.customIconButtons[var.gm_custom_icon_selected]:Select();
				ui.customEdit:SetText(saved_sets[var.gm_editing_set].name);
			else
				var.gm_custom_icon_selected = 1;
				ui.customIconButtons[var.gm_custom_icon_selected]:Select();
				ui.customEdit:SetText("");
			end
			if not ui.customEdit:GetText() or ui.customEdit:GetText() == "" then
				ui.customOK:Disable();
			end
			ui.customEdit:SetFocus();
			func.Sound_Show();
		end);
		ui.custom:SetScript("OnHide", function(self)
			ui.customIconButtons[var.gm_custom_icon_selected]:Deselect();
			var.gm_is_editing = nil;
			var.gm_editing_set = nil;
			var.gm_custom_icon_selected = nil;
			func.Sound_Hide();
		end);
		function ui.custom:CustomShow(set)
			if var.gm_editing_set == set then
				if self:IsShown() then
					self:Hide();
				else
					var.gm_is_editing = true;
					self:Show();
				end
			else
				var.gm_is_editing = true;
				var.gm_editing_set = set;
				if self:IsShown() then
					self:GetScript("OnShow")();
				else
					self:Show();
				end
			end
		end

		if autostyle ~= nil then
			autostyle:AddReskinObject(ui.custom);
		end

		ui.customEdit = CreateFrame("EDITBOX", nil, ui.custom);
		ui.customEdit:SetSize(220, 24);
		ui.customEdit:SetFontObject(GameFontHighlightSmall);
		ui.customEdit:SetAutoFocus(false);
		ui.customEdit:SetJustifyH("LEFT");
		ui.customEdit:Show();
		ui.customEdit:EnableMouse(true);
		-- uireimp._SetBackdrop(, ui.customEdit{
		-- 	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
		-- 	--edgeFile = "interface/dialogframe/ui-dialogbox-border",
		-- 	tile = true,
		-- 	tileSize = 4,
		-- 	edgeSize = 0,
		-- 	insets = { left = 0, right = 0, top = 0, bottom = 0 }
		-- });
		ui.customEdit:SetPoint("TOPLEFT", ui.custom, 12, -12);
		ui.customEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
		ui.customEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
		--ui.customEdit:SetScript("OnShow", function(self) end);
		--ui.customEdit:SetScript("OnHide", function(self) end);
		ui.customEdit:SetScript("OnTextChanged", function(self, isUserInput)
			if not self:GetText() or self:GetText() == "" then
				ui.customOK:Disable();
			else
				ui.customOK:Enable();
			end
		end);
		ui.customEditTexture = ui.customEdit:CreateTexture(nil, "ARTWORK");
		ui.customEditTexture:SetPoint("TOPLEFT");
		ui.customEditTexture:SetPoint("BOTTOMRIGHT");
		ui.customEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
		ui.customEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
		ui.customEditTexture:SetAlpha(0.75);
		ui.customEditTexture:SetBlendMode("ADD");
		ui.customEditTexture:SetVertexColor(0.25, 0.25, 0.25);

		if autostyle ~= nil then
			autostyle:AddReskinObject(ui.customEdit);
		end

		ui.customOK = CreateFrame("BUTTON", nil, ui.custom, "UIPanelButtonTemplate");
		ui.customOK:SetPoint("TOPRIGHT", -12, -12);
		ui.customOK:SetText(L["OK"]);
		ui.customOK:SetSize(70, 24);
		ui.customOK:SetScript("OnClick", func.customOK);

		if autostyle ~= nil then
			autostyle:AddReskinObject(ui.customOK);
		end

		ui.customCancel = CreateFrame("BUTTON", nil, ui.custom, "UIPanelButtonTemplate");
		ui.customCancel:SetPoint("BOTTOMRIGHT", -12, 12);
		ui.customCancel:SetText(L["Cancel"]);
		ui.customCancel:SetSize(70, 24);
		ui.customCancel:SetScript("OnClick", func.customCancel);

		if autostyle ~= nil then
			autostyle:AddReskinObject(ui.customCancel);
		end

		local customIconButtons = {  };
		local row = 0;
		local col = 0;
		for i = 1, #iconTable do
			local button = CreateFrame("BUTTON", nil, ui.custom);
			button:SetSize(32, 32);
			button:SetNormalTexture(iconTable[i]);
			button:SetHighlightTexture(texture_highlight);
			button:GetHighlightTexture():SetTexCoord(unpack(texture_highlight_coord));
			-- button:GetHighlightTexture():SetVertexColor(1.0, 0.0, 0.0, 1.0);
			button:SetPoint("TOPLEFT", 15 + col * 37, - 48 - 4 - row * 37);
			button:Show();
			button:SetScript("OnClick", function(self)
				if var.gm_custom_icon_selected ~= self.id then
					if var.gm_custom_icon_selected then
						customIconButtons[var.gm_custom_icon_selected]:Deselect();
					end
					self:Select();
					var.gm_custom_icon_selected = self.id;
				end
			end);

			if autostyle ~= nil then
				autostyle:AddReskinObject(button, "BUTTON.WITH.TEXTURE");
			end
	
			local glow = button:CreateTexture(nil, "OVERLAY");
			glow:SetTexture(texture_glow);
			glow:SetTexCoord(unpack(texture_glow_coord));
			glow:SetVertexColor(1.0, 0.0, 0.0);
			--glow:SetAllPoints();
			glow:SetPoint("BOTTOMLEFT", - 2, - 2);
			glow:SetPoint("TOPRIGHT", 2, 2);
			glow:SetBlendMode("ADD");
			glow:Hide();
			button.glow = glow;

			function button:Select()
				glow:Show();
			end
			function button:Deselect()
				glow:Hide();
			end

			button.id = i;
			customIconButtons[i] = button;
			col = col + 1;
			if col >= 12 then
				col = 0;
				row = row + 1;
			end
		end
		ui.customIconButtons = customIconButtons;
	end
end
function func.refreshAppearance()
	ui.scroll:Update();
	local secureButtons = ui.secureButtons;
	local N = #saved_sets;
	if N < (#secureButtons + 1) then
	end
	local TOA = (alaGearManSV.takeoffAll_pos == 'LEFT') and 1 or (N + 1);
	local ofs = (alaGearManSV.takeoffAll_pos == 'LEFT') and 1 or 0;
	if secureButtons[TOA] then
		secureButtons[TOA]:NonCurrent();
	end
	for i = 1, N do
		local T, isCur = func.check(i);
		local button = secureButtons[i + ofs];
		if isCur then
			if button then
				button:Current();
			end
		else
			if button then
				button:NonCurrent();
			end
		end
	end
end

function func.open_onclick(self, button)
	if ui.gearWin:IsShown() then
		ui.gearWin:Hide();
	else
		ui.gearWin:Show();
	end
end
function func.new_onclick()
	ui.custom:CustomShow();
end
function func.delete_onclick()
	func.delete(var.gm_editing_set or var.gm_cur_set);
end
function func.setting(self, button)
	local elements = { };
	if alaGearManSV.UseMacro then
		tinsert(elements, {
			para = { 'UseMacro', false, },
			text = L["UseMacro_false"],
		});
	else
		tinsert(elements, {
			para = { 'UseMacro', true, },
			text = L["UseMacro"],
		});
	end
	if alaGearManSV.useBar then
		tinsert(elements, {
			para = { 'useBar', false, },
			text = L["useBar_false"],
		});
	else
		tinsert(elements, {
			para = { 'useBar', true, },
			text = L["useBar"],
		});
	end
	if alaGearManSV.quickStyle ~= 'TC' then
		tinsert(elements, {
			para = { 'quickStyle', 'TC', },
			text = L["Style_TC"],
		});
	end
	if alaGearManSV.quickStyle ~= 'T' then
		tinsert(elements, {
			para = { 'quickStyle', 'T', },
			text = L["Style_T"],
		});
	end
	if alaGearManSV.quickStyle ~= 'C' then
		tinsert(elements, {
			para = { 'quickStyle', 'C', },
			text = L["Style_C"],
		});
	end
	if alaGearManSV.takeoffAll_pos ~= 'LEFT' then
		tinsert(elements, {
			para = { 'takeoffAll_pos', 'LEFT', },
			text = L["Take-off-all On Left"],
		});
	end
	if alaGearManSV.takeoffAll_pos ~= 'RIGHT' then
		tinsert(elements, {
			para = { 'takeoffAll_pos', 'RIGHT', },
			text = L["Take-off-all On Right"],
		});
	end
	if alaGearManSV.takeoffAll_include_neck_finger_and_trinket then
		tinsert(elements, {
			para = { 'takeoffAll_include_neck_finger_and_trinket', false, },
			text = L["takeoffAll_include_neck_finger_and_trinket_false"],
		});
	else
		tinsert(elements, {
			para = { 'takeoffAll_include_neck_finger_and_trinket', true, },
			text = L["takeoffAll_include_neck_finger_and_trinket"],
		});
	end
	if alaGearManSV.show_outfit_in_tooltip then
		tinsert(elements, {
			para = { 'show_outfit_in_tooltip', false, },
			text = L["show_outfit_in_tooltip_false"],
		});
	else
		tinsert(elements, {
			para = { 'show_outfit_in_tooltip', true, },
			text = L["show_outfit_in_tooltip"],
		});
	end
	if alaGearManSV.multi_lines then
		tinsert(elements, {
			para = { 'multi_lines', false, },
			text = L["multi_lines_false"],
		});
	else
		tinsert(elements, {
			para = { 'multi_lines', true, },
			text = L["multi_lines"],
		});
	end
	tinsert(elements, {
		handler = function()
			alaGearManSV.quickPos = { "TOP", 0, 0, };
			alaGearManSV.quickPosChar[GUID] = nil;
			ui.secure:ClearAllPoints();
			ui.secure:SetPoint(unpack(alaGearManSV.quickPos));
		end,
		para ={  },
		text = L["reset_pos"],
	})
	ALADROP(self, "BOTTOMRIGHT", {
		handler = func.drop_handler,
		elements = elements,
	});
end
function func.delete(set)
	if saved_sets[set] then
		if var.gm_cur_set == set then
			ui.scroll:CallButtonFuncByDataIndex(var.gm_cur_set, "Deselect");
			var.gm_cur_set = nil;
		end
		tremove(saved_sets, set);
		if var.gm_cur_set and var.gm_cur_set > set then
			var.gm_cur_set = var.gm_cur_set - 1;
		end
		ui.scroll:SetNumValue(#saved_sets + 1);
		-- ui.quick:Update();
		ui.secure:Update();
		NS.F_ScheduleDelayCall(func.refreshAppearance);
	end
end
function func.save(set)
	set = set or var.gm_cur_set;
	if set then
		saved_sets[set] = saved_sets[set] or {  };
		local set = saved_sets[set];
		for slot = 1, 19 do
			if var.gm_ignore[slot] then
				set[slot] = -1;
			else
				local link = GetInventoryItemLink('player', slot);
				set[slot] = link;
			end
		end
		ui.secure:Update();
		func.Sound_Save();
	end
end
function func.takeoff(slot, not_take_off_dur0)
	if not GetInventoryItemLink('player', slot) then
		return;
	end
	if not_take_off_dur0 and GetInventoryItemDurability(slot) and GetInventoryItemDurability(slot) <= 0 then
		return;
	end
	for i = 0, 4 do
		for j = 1, GetContainerNumSlots(i) do
			local cache_index = i * 100 + j;
			if not var.cache[cache_index] then
				local link = GetContainerItemLink(i, j);
				if not link then
					PickupInventoryItem(slot);
					-- PickupContainerItem(i, j);
					if i == 0 then
						PutItemInBackpack();
					else
						PutItemInBag(i + 19);
					end
					var.cache[cache_index] = true;
					C_Timer.After(1.0, function() var.cache[cache_index] = nil; end);
					return;
				end
			end
		end
	end
	if not var.cache.INVENTORY_IS_FULL then
		var.cache.INVENTORY_IS_FULL = true;
		_error_(L["INVENTORY_IS_FULL"]);
		C_Timer.After(1.0, function() var.cache.INVENTORY_IS_FULL = nil; end);
	end
end
function func.takeoffAll()
	if UnitIsDeadOrGhost('player') and not UnitIsFeignDeath('player') then
		_error_(L["BE_DEAD"]);
		return;
	end
	if InCombatLockdown() then
		_error_(L["IN_COMBAT"]);
		for i = 16, 18 do
			func.takeoff(i, not alaGearManSV.takeoffAll_include_neck_finger_and_trinket);
		end
		return;
	end
	for i = 1, alaGearManSV.takeoffAll_include_neck_finger_and_trinket and #takeoffAll_order or 11 do
		func.takeoff(takeoffAll_order[i], not alaGearManSV.takeoffAll_include_neck_finger_and_trinket);
	end
end
function func.equipItem2(item1, item2, slot1, slot2)
	wipe(var.bagItemCache1);
	local ID1 = item1 and tonumber(select(3, strfind(item1, "item:(%d+)")));
	local ID2 = item2 and tonumber(select(3, strfind(item2, "item:(%d+)")));
	local bindType1 = ID1 and select(14,GetItemInfo(ID1));
	local bindType2 = ID2 and select(14,GetItemInfo(ID2));
	local not_checkBound1 = not (bindType1 == 2 or bindType1 == 3);
	local not_checkBound2 = not (bindType2 == 2 or bindType2 == 3);
	local link1 = GetInventoryItemLink('player', slot1);
	local link2 = GetInventoryItemLink('player', slot2);
	local id1 = GetInventoryItemID('player', slot1);
	local id2 = GetInventoryItemID('player', slot2);
	local equipped1 = (not item1) or (link1 == item1);
	local equipped2 = (not item2) or (link2 == item2);
	ClearCursor();
	if not equipped2 or not equipped1 then
		if link1 == item2 and link1 ~= item1 then
			PickupInventoryItem(slot1);
			EquipCursorItem(slot2);
			equipped2 = true;
			link1, link2 = link2, link1;
			equipped1 = (not item1) or (link1 == item1);
		end
		if not equipped1 and link2 == item1 and link2 ~= item2 then
			PickupInventoryItem(slot2);
			EquipCursorItem(slot1);
			equipped1 = true;
			link1, link2 = link2, link1;
			equipped2 = (not item2) or (link2 == item2);
		end
	end
	if equipped1 and equipped2 then
		return;
	end
	for i = var.isBankOpened and -1 or 0, var.isBankOpened and 11 or 4 do
		for j = 1, GetContainerNumSlots(i) do
			if equipped1 and equipped2 then
				return;
			end
			local link = GetContainerItemLink(i, j);
			if not equipped1 and (link and link == item1) then
				var.itemLoc:SetBagAndSlot(i, j);
				if not_checkBound1 or C_Item.IsBound(var.itemLoc) then
					-- tinsert(var.bagItemCache1, true);
					PickupContainerItem(i, j);
					EquipCursorItem(slot1);
					equipped1 = true;
					-- return;
				else
					tinsert(var.bagItemCache1, i);
					tinsert(var.bagItemCache1, j);
					-- tinsert(var.bagItemCache1, false);
				end
			elseif not equipped2 and (link and link == item2) then
				var.itemLoc:SetBagAndSlot(i, j);
				if not_checkBound2 or C_Item.IsBound(var.itemLoc) then
					-- tinsert(var.bagItemCache1, true);
					PickupContainerItem(i, j);
					EquipCursorItem(slot2);
					equipped2 = true;
					-- return;
				else
					tinsert(var.bagItemCache2, i);
					tinsert(var.bagItemCache2, j);
					-- tinsert(var.bagItemCache1, false);
				end
			end
		end
	end
	-- EquipItemByName(item, slot);
	if not equipped2 or not equipped1 then
		if id1 == ID2 and id1 ~= ID1 then
			PickupInventoryItem(slot1);
			EquipCursorItem(slot2);
			equipped2 = true;
			id1, id2 = id2, id1;
			equipped1 = (not ID1) or (id1 == ID1);
		end
		if not equipped1 and id2 == ID1 and id2 ~= ID2 then
			PickupInventoryItem(slot2);
			EquipCursorItem(slot1);
			equipped1 = true;
			id1, id2 = id2, id1;
			equipped2 = (not ID2) or (id2 == ID2);
		end
	end
	if equipped1 and equipped2 then
		return;
	end
	for i = var.isBankOpened and -1 or 0, var.isBankOpened and 11 or 4 do
		for j = 1, GetContainerNumSlots(i) do
			if equipped1 and equipped2 then
				return;
			end
			local id = GetContainerItemID(i, j);
			if not equipped1 and (id and id == ID1) then
				var.itemLoc:SetBagAndSlot(i, j);
				if not_checkBound1 or C_Item.IsBound(var.itemLoc) then
					-- tinsert(var.bagItemCache1, true);
					PickupContainerItem(i, j);
					EquipCursorItem(slot1);
					equipped1 = true;
					-- return;
				else
					tinsert(var.bagItemCache1, i);
					tinsert(var.bagItemCache1, j);
					-- tinsert(var.bagItemCache1, false);
				end
			elseif not equipped2 and (id and id == ID2) then
				var.itemLoc:SetBagAndSlot(i, j);
				if not_checkBound2 or C_Item.IsBound(var.itemLoc) then
					-- tinsert(var.bagItemCache1, true);
					PickupContainerItem(i, j);
					EquipCursorItem(slot2);
					equipped2 = true;
					-- return;
				else
					tinsert(var.bagItemCache2, i);
					tinsert(var.bagItemCache2, j);
					-- tinsert(var.bagItemCache1, false);
				end
			end
		end
	end
	if not equipped1 and #var.bagItemCache1 > 0 then
		PickupContainerItem(var.bagItemCache1[1], var.bagItemCache1[2]);
		EquipCursorItem(slot1);
	end
	if not equipped2 and #var.bagItemCache2 > 0 then
		PickupContainerItem(var.bagItemCache2[1], var.bagItemCache2[2]);
		EquipCursorItem(slot2);
	end
end
function func.equipItem(item, slot)
	if item == nil then
		return;
	end
	if GetInventoryItemLink('player', slot) == item then
		return;
	end
	wipe(var.bagItemCache1);
	local ID = tonumber(select(3, strfind(item, "item:(%d+)")));
	local bindType = select(14,GetItemInfo(ID));
	local not_checkBound = not (bindType == 2 or bindType == 3);
	for i = var.isBankOpened and -1 or 0, var.isBankOpened and 11 or 4 do
		for j = 1, GetContainerNumSlots(i) do
			local link = GetContainerItemLink(i, j);
			if link and link == item then
				var.itemLoc:SetBagAndSlot(i, j);
				if not_checkBound or C_Item.IsBound(var.itemLoc) then
					-- tinsert(var.bagItemCache1, true);
					PickupContainerItem(i, j);
					EquipCursorItem(slot);
					return;
				else
					tinsert(var.bagItemCache1, i);
					tinsert(var.bagItemCache1, j);
					-- tinsert(var.bagItemCache1, false);
				end
			end
		end
	end
	for i = var.isBankOpened and -1 or 0, var.isBankOpened and 11 or 4 do
		for j = 1, GetContainerNumSlots(i) do
			local id = GetContainerItemID(i, j);
			if id and id == ID then
				var.itemLoc:SetBagAndSlot(i, j);
				if not_checkBound or C_Item.IsBound(var.itemLoc) then
					-- tinsert(var.bagItemCache1, true);
					PickupContainerItem(i, j);
					EquipCursorItem(slot);
					return;
				else
					tinsert(var.bagItemCache1, i);
					tinsert(var.bagItemCache1, j);
					-- tinsert(var.bagItemCache1, false);
				end
			end
		end
	end
	ClearCursor();
	-- if slot == 11 or slot == 13 or slot == 16 then
	-- 	local id = GetInventoryItemID('player', slot + 1);
	-- 	if id == ID then
	-- 		PickupInventoryItem(slot + 1);
	-- 		EquipCursorItem(slot);
	-- 		return;
	-- 	end
	-- elseif slot == 12 or slot == 14 or slot == 17 then
	-- 	local id = GetInventoryItemID('player', slot - 1);
	-- 	if id == ID then
	-- 		PickupInventoryItem(slot - 1);
	-- 		EquipCursorItem(slot);
	-- 		return;
	-- 	end
	-- end
	EquipItemByName(item, slot);
	if #var.bagItemCache1 > 0 then
		PickupContainerItem(var.bagItemCache1[1], var.bagItemCache1[2]);
		EquipCursorItem(slot);
	end
end
function func.equip(set)
	if UnitIsDeadOrGhost('player') and not UnitIsFeignDeath('player') then
		_error_(L["BE_DEAD"]);
		return;
	end
	if InCombatLockdown() then
		_error_(L["IN_COMBAT"]);
		return;
	end
	set = set or var.gm_cur_set;
	if set and saved_sets[set] then
		local set = saved_sets[set];
		local disordered = false;
		for slot = 1, 19 do
			if set[slot] ~= -1 then
				if set[slot] == nil then
					func.takeoff(slot);
				else
					-- if GetInventoryItemLink('player', slot) ~= set[slot] then
						if slot == 11 or slot == 13 or slot == 16 then
							if set[slot + 1] and set[slot + 1] ~= -1 then
								func.equipItem2(set[slot], set[slot + 1], slot, slot + 1);
							else
							-- if GetInventoryItemLink('player', slot) == set[slot + 1] and set[slot] ~= set[slot + 1] then
							-- 	func.equipItem(set[slot + 1], slot + 1);
							-- 	disordered = true;
							-- else
								func.equipItem(set[slot], slot);
							end
						elseif slot == 12 or slot == 14 or slot == 17 then
							-- if disordered then
							-- 	func.equipItem(set[slot - 1], slot - 1);
							-- 	disordered = false;
							-- else
								func.equipItem(set[slot], slot);
							-- end
						else
							func.equipItem(set[slot], slot);
						end
					-- end
				end
			end
		end
		ShowHelm(set.helmet);
		ShowCloak(set.cloak);
		func.Sound_Equip();
		NS.F_ScheduleDelayCall(func.refreshAppearance);
	end
end
function func.customOK()
	local title = ui.customEdit:GetText();
	if title and title ~= "" then
		local index;
		if var.gm_editing_set and saved_sets[var.gm_editing_set] then
			index = var.gm_editing_set;
			saved_sets[var.gm_editing_set].name = title;
			saved_sets[var.gm_editing_set].icon = var.gm_custom_icon_selected;
		else
			index = #saved_sets + 1;
			saved_sets[index] = { name = title, icon = var.gm_custom_icon_selected, };
		end
		ui.scroll:SetNumValue(#saved_sets + 1);
		ui.scroll:Update();
		func.save(index);
		-- ui.quick:Update();
		-- ui.secure:Update();	--func.save will always update securequick
		-- NS.F_ScheduleDelayCall(func.refreshAppearance);
	end
	func.pdf_hide_mask();
	ui.custom:Hide();
end
function func.customCancel()
	func.pdf_hide_mask();
	ui.custom:Hide();
end
function func.up(index)
	local cur = saved_sets[index];
	if cur and index > 1 then
		saved_sets[index] = saved_sets[index - 1];
		saved_sets[index - 1] = cur;
		ui.scroll:Update();
		ui.secure:Update();
		func.Sound_Order();
	end
end
function func.down(index)
	local cur = saved_sets[index];
	if cur and index < #saved_sets then
		saved_sets[index] = saved_sets[index + 1];
		saved_sets[index + 1] = cur;
		ui.scroll:Update();
		ui.secure:Update();
		func.Sound_Order();
	end
end
function func.helmet(index, show)
	local cur = saved_sets[index];
	if cur then
		cur.helmet = show;
		func.Sound_Order();
		-- if select(2, func.check(index)) then
		-- 	ShowHelm(show);
		-- end
	end
end
function func.cloak(index, show)
	local cur = saved_sets[index];
	if cur then
		cur.cloak = show;
		func.Sound_Order();
 	end
end
function func.check(index)
	if index > 0 and index <= #saved_sets then
		local set = saved_sets[index];
		local T = CreateFromMixins(set);
		for slot = 1, 19 do
			if T[slot] == nil then
				T[slot] = 1;
			end
		end
		for slot = 1, 19 do
			local id = GetInventoryItemID('player', slot);
			if id then
				if (slot == 16) and T[16] and type(T[16]) == 'string' and id == tonumber(select(3, strfind(T[16], "item:(%d+)"))) and select(9, GetItemInfo(id)) == "INVTYPE_2HWEAPON" then
					T[16] = nil;
					T[17] = nil;
				elseif T[slot] and type(T[slot]) == 'string' and id == tonumber(select(3, strfind(T[slot], "item:(%d+)"))) then
					T[slot] = nil;
				elseif (slot == 11 or slot == 13 or slot == 16) and T[slot + 1] and type(T[slot + 1]) == 'string' and id == tonumber(select(3, strfind(T[slot + 1], "item:(%d+)"))) then
					T[slot + 1] = nil;
				elseif (slot == 12 or slot == 14 or slot == 17) and T[slot - 1] and type(T[slot - 1]) == 'string' and id == tonumber(select(3, strfind(T[slot - 1], "item:(%d+)"))) then
					T[slot - 1] = nil;
				end
			elseif T[slot] == 1 then
				T[slot] = nil;
			end
		end
		local all_empty_or_fit = true;
		for slot = 1, 19 do
			if T[slot] and (type(T[slot]) == 'string' or T[slot] == 1) then
				all_empty_or_fit = false;
				break;
			end
		end
		if all_empty_or_fit then
			return T, true;
		end
		for i = var.isBankOpened and -1 or 0, var.isBankOpened and 11 or 4 do
			for j = 1, GetContainerNumSlots(i) do
				local id = GetContainerItemID(i, j);
				if id then
					local loc = select(9, GetItemInfo(id));
					local slots = loc2Slot[loc];
					if slots then
						for _, slot in next, slots do
							if type(T[slot]) == 'string' and id == tonumber(select(3, strfind(T[slot], "item:(%d+)"))) then
								T[slot] = 0;
							end
						end
					end
				end
			end
		end
		return T, false;
	end
end

function func.update_drop_table()
end
function func.drop_handler(button, key, value)
	if key == 'UseMacro' then
		if type(value) == 'boolean' then
			alaGearManSV.UseMacro = value;
			if value then
				ui.secure:Update();
			else
				for i = 1, 120 do
					if GetMacroInfo(MACRO_NAME_PREFIX .. i) then
						DeleteMacro(MACRO_NAME_PREFIX .. i);
					end
				end
			end
		end
	elseif key == 'useBar' then
		if type(value) == 'boolean' then
			alaGearManSV.useBar = value;
			if value then
				ui.secure:Show();
			else
				ui.secure:Hide();
			end
		end
	elseif key == 'quickStyle' then
		if value == 'TC' or value == 'T' or value == 'C' then
			alaGearManSV.quickStyle = value;
			-- ui.quick:Update();
			ui.secure:Update();
		end
	elseif key == 'takeoffAll_pos' then
		if value == 'LEFT' or value == 'RIGHT' then
			alaGearManSV.takeoffAll_pos = value;
			-- ui.quick:Update();
			ui.secure:Update();
		end
	elseif key == 'takeoffAll_include_neck_finger_and_trinket' then
		if type(value) == 'boolean' then
			alaGearManSV.takeoffAll_include_neck_finger_and_trinket = value;
		end
	elseif key == 'show_outfit_in_tooltip' then
		if type(value) == 'boolean' then
			alaGearManSV.show_outfit_in_tooltip = value;
		end
	elseif key == 'multi_lines' then
		if type(value) == 'boolean' then
			alaGearManSV.multi_lines = value;
			ui.secure:ReArrange();
		end
	end
end
function func.hook_tooltip(self)
	if not alaGearManSV.show_outfit_in_tooltip then
		return;
	end
	local name, link = self:GetItem();
	if link and IsEquippableItem(link) then
		local loc = select(9, GetItemInfo(link));
		local slots = loc2Slot[loc];
		if slots then
			local ID = select(3, strfind(link, "item:(%d+)"));
			for _, slot in next, slots do
				for index, set in next, saved_sets do
					if type(set[slot]) == 'string' and ((set[slot] == link) or (ID and ID == select(3, strfind(set[slot], "item:(%d+)")))) then
						self:AddLine("\124cffffcf00" .. L["IN_OUTFIT"] .. "\124r\124cffffffff" .. set.name);
					end
				end
			end
		end
	end
end
function func.init_variables()
	if _G.alaGearManSV then
		if alaGearManSV._version == nil then
			alaGearManSV.quickPosChar = {  };
			alaGearManSV._version = 0.0;
		end
		if alaGearManSV._version < 200422.0 then
			alaGearManSV._version = 200422.0;
		end
		if alaGearManSV._version < 200507.0 then
			alaGearManSV.useBar = true;
			alaGearManSV._version = 200507.0;
		end
		if alaGearManSV._version < 200610.0 then
			for index, val in next, alaGearManSV.quickPos do
				if type(val) ~= 'number' and type(val) ~= 'string' then
					alaGearManSV.quickPos[index] = nil;
				end
			end
			for GUID, pos in next, alaGearManSV.quickPosChar do
				for index, val in next, pos do
					if type(val) ~= 'number' and type(val) ~= 'string' then
						pos[index] = nil;
					end
				end
			end
			alaGearManSV._version = 200610.0;
		end
		if alaGearManSV._version < 220902.0 then
			alaGearManSV.UseMacro = false;
			alaGearManSV._version = 220902.0;
			for i = 1, 120 do
				if GetMacroInfo(MACRO_NAME_PREFIX .. i) then
					DeleteMacro(MACRO_NAME_PREFIX .. i);
				end
			end
			print("|cffff0000alaGearMan|r: ", L["UseBLZEquipmentManager"])
		end
		for key, val in next, default_sv do
			if alaGearManSV[key] == nil then
				alaGearManSV[key] = val;
			end
		end
	else
		_G.alaGearManSV = default_sv;
	end
	alaGearManSV._version = 220902.0;
end
function func.init_hook_tooltip()
	GameTooltip:HookScript("OnTooltipSetItem", func.hook_tooltip);
	ItemRefTooltip:HookScript("OnTooltipSetItem", func.hook_tooltip);
end

function func.PLAYER_EQUIPMENT_CHANGED()
	NS.F_ScheduleDelayCall(func.refreshAppearance);
end
function func.UPDATE_BINDINGS(...)
	-- print("UPDATE_BINDINGS", ...)
	-- GetBindingKey("ALAGEARMAN_QUICK_1");
	ui.secure:UpdateKeyBinding();
end
function func.BANKFRAME_OPENED(...)
	var.isBankOpened = true;
end
function func.BANKFRAME_CLOSED(...)
	var.isBankOpened = false;
end
function func.init()
	saved_sets = alaGearManSV.sets[GUID];
	if saved_sets == nil then
		saved_sets = {  };
		alaGearManSV.sets[GUID] = saved_sets;
	end
	func.pdf_init();
	func.initUI();
	func.init_hook_tooltip();
	_EventHandler:RegEvent("UPDATE_BINDINGS");
	_EventHandler:RegEvent("BANKFRAME_OPENED");
	_EventHandler:RegEvent("BANKFRAME_CLOSED");
	_EventHandler:RegEvent("PLAYER_EQUIPMENT_CHANGED");
	func.RegAddonListener();
end
function func.PLAYER_REGEN_ENABLED()
	_EventHandler:UnregisterEvent("PLAYER_REGEN_ENABLED");
end
function func.PLAYER_ENTERING_WORLD()
	_EventHandler:UnregisterEvent("PLAYER_ENTERING_WORLD");
	if not NS.initializeddb then
		func.ADDON_LOADED(ADDON);
	end
	if InCombatLockdown() then
		_EventHandler:RegEvent("PLAYER_REGEN_ENABLED");
	else
		C_Timer.After(0.1, func.init);
	end
	if not alaGearManSV.UseMacro then
		for i = 1, 120 do
			if GetMacroInfo(MACRO_NAME_PREFIX .. i) then
				DeleteMacro(MACRO_NAME_PREFIX .. i);
			end
		end
	end
	if __ala_meta__.initpublic then __ala_meta__.initpublic(); end
end
function func.ADDON_LOADED(addon)
	if addon == ADDON then
		_EventHandler:UnregisterEvent("ADDON_LOADED");
		if not NS.initializeddb then
			NS.initializeddb = true;
			func.init_variables();
		end
	end
end

function _EventHandler:RegEvent(event)
	if not func[event] then
		func[event] = _noop_;
	end
	_EventHandler:RegisterEvent(event);
end
function _EventHandler:FireEvent(event, ...)
	if func[event] then
		func[event](...);
	end
end
_EventHandler:SetScript("OnEvent", function(self, event, ...)
	func[event](...);
end);


do	--	SLASH
	_G.SLASH_ALAGEARMAN1 = "/alaGearMan";
	_G.SLASH_ALAGEARMAN1 = "/alaGM";
	_G.SLASH_ALAGEARMAN1 = "/agm";
	SlashCmdList["ALAGEARMAN"] = function(msg)
		local num = tonumber(msg);
		if num then
			alaGearManSV.multi_lines = true;
			alaGearManSV.num_per_line = num;
			ui.secure.ReArrange();
		end
	end
end

do	--	extern style
	local F = CreateFrame('FRAME');
	local handler_table = {  };
	local style = {  };
	function handler_table.ElvUI()
		if ElvUI and ElvUI[1] then
			local S = ElvUI[1]:GetModule('Skins');
			if S then
				-- S:HandleButton(ui.open);
				S:HandleFrame(ui.gearWin);
				S:HandleButton(ui.save);
				S:HandleButton(ui.equip);
				S:HandleFrame(ui.custom);
				S:HandleButton(ui.customOK);
				S:HandleButton(ui.customCancel);
				-- S:HandleCheckBox(gui.ExactQueryCheckButton);
				-- S:HandleDropDownBox(AuctionFrameAuctions_Time);
				style.frame = function(f) return S:HandleFrame(f); end;
				style.button = function(f) return S:HandleButton(f); end;
				style.check = function(f) return S:HandleCheckBox(f); end;
				style.drop = function(f) return S:HandleDropDownBox(f); end;
				local index = 1;
				while true do
					if not ui.scroll:HandleButtonByRawIndex(index, F.StyleScroll) then
						break;
					end
					index = index + 1;
				end
			end
		end
	end
	function func.StyleScroll(button)
		if button then
			-- func.StyleObject('button', button.delete);
			-- func.StyleObject('button', button.modify);
			-- func.StyleObject('button', button.up);
			-- func.StyleObject('button', button.down);
			func.StyleObject('check', button.helmet);
			func.StyleObject('check', button.cloak);
			return true;
		else
			return false;
		end
	end
	function func.StyleObject(t, f)
		local handler = style[t];
		if handler then
			return handler(f);
		end
	end
	function F.ADDON_LOADED(addon)
		local handler = handler_table[addon];
		if handler then
			handler();
		end
	end
	function func.RegAddonListener()
		F:RegisterEvent("ADDON_LOADED");
		F:SetScript("OnEvent", function(self, event, ...)
			local f = self[event];
			if f ~= nil then
				return f(...);
			end
		end);
		for addon, handler in next, handler_table do
			if IsAddOnLoaded(addon) then
				handler();
			end
		end
	end
end

_EventHandler:RegEvent("PLAYER_ENTERING_WORLD");
_EventHandler:RegEvent("ADDON_LOADED");

_G.AGM_FUNC = func;

__ala_meta__.gear = { func = func, ui = ui, };
