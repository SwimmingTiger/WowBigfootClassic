--[[--
	alex/ALA	Please Keep WOW Addon open-source & Reduce barriers for others.
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, ns = ...;
----------------------------------------------------------------------------------------------------upvalue LUA
local math, table, string, bit = math, table, string, bit;
local type = type;
local assert, collectgarbage, date, difftime, error, getfenv, getmetatable, loadstring, next, newproxy, pcall, select, setfenv, setmetatable, time, type, unpack, xpcall, rawequal, rawget, rawset =
		assert, collectgarbage, date, difftime, error, getfenv, getmetatable, loadstring, next, newproxy, pcall, select, setfenv, setmetatable, time, type, unpack, xpcall, rawequal, rawget, rawset;
local abs, acos, asin, atan, atan2, ceil, cos, deg, exp, floor, fmod, frexp,ldexp, log, log10, max, min, mod, rad, random, sin, sqrt, tan, fastrandom =
		abs, acos, asin, atan, atan2, ceil, cos, deg, exp, floor, fmod or math.fmod, frexp,ldexp, log, log10, max, min, mod, rad, random, sin, sqrt, tan, fastrandom;
local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, tonumber, tostring =
		format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, tonumber, tostring;
local strcmputf8i, strlenutf8, strtrim, strsplit, strjoin, strconcat, tostringall =  strcmputf8i, strlenutf8, strtrim, strsplit, strjoin, strconcat, tostringall;
local ipairs, pairs, sort, tContains, tinsert, tremove, wipe = ipairs, pairs, sort, tContains, tinsert, tremove, wipe;
local gcinfo, foreach, foreachi, getn = gcinfo, foreach, foreachi, getn;	-- Deprecated
----------------------------------------------------------------------------------------------------
local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
local GameTooltip = GameTooltip;
local ItemRefTooltip = ItemRefTooltip;
----------------------------------------------------------------------------------------------------
local GUID = UnitGUID('player');
local saved_sets = {  };
local L = setmetatable({  }, { __newindex = function(t, k, v) rawset(t, k, (v == true) and k or v); end});
local LOCALE = GetLocale();
if LOCALE == 'zhCN' or LOCALE == 'zhTW' then
	L["INVENTORY_IS_FULL"] = "背包已满！";
	L["IN_COMBAT"] = "战斗状态中无法换装！";
	L["Add a new outfit"] = "添加一个套装";
	L["Delete this outfit?"] = "删除此套装？";
	L["OK"] = "确定";
	L["Cancel"] = "取消";
	L["Save"] = "保存";
	L["Equip"] = "装备";
	L["Style"] = "风格";
	L["Style_TC"] = "文字+图标风格";
	L["Style_T"] = "图标风格";
	L["Style_C"] = "文字风格";
	L["Take_Off_All"] = "一键脱光";
	L["Take_Off_All_ButtonText"] = "脱";
	L["Take-off-all On Right"] = "一键脱光按钮在\124cffff0000右边\124r";
	L["Take-off-all On Left"] = "一键脱光按钮在\124cffff0000左边\124r";
	L["takeoffAll_include_neck_finger_and_trinket"] = "一键脱光\124cffff0000包括\124r戒指饰品披风和耐久度为0的装备";
	L["takeoffAll_include_neck_finger_and_trinket_false"] = "一键脱光\124cffff0000不包括\124r戒指饰品披风和耐久度为0的装备";
	L["show_outfit_in_tooltip"] = "在物品提示中\124cffff0000显示\124r保存的套装信息";
	L["show_outfit_in_tooltip_false"] = "在物品提示中\124cffff0000不显示\124r保存的套装信息";
	L["reset_pos"] = "重置快速切换栏的位置";
	L["CTRL-DRAG-TO-MOVE"] = "\124cffff40ff按住ctrl拖动来移动位置\124r";
	L["WAITING_FOR_REGEN_ENABLED"] = "战斗结束时更新";
	L["IN_OUTFIT"] = "装备配置方案：";
	L["TOOLTIP_MISSING"] = " 缺失";
	L["IN_BAG"] = "在背包中"
	L["CURRENT_OUTFIT"] = "当前装备中";

	L.slot = {
		[0] = "子弹",
		[1] = "头部",
		[2] = "颈部",
		[3] = "肩部",
		[4] = "衬衣",
		[5] = "胸甲",
		[6] = "腰带",
		[7] = "腿部",
		[8] = "靴子",
		[9] = "护腕",
		[10] = "手套",
		[11] = "戒指1",
		[12] = "戒指2",
		[13] = "饰品1",
		[14] = "饰品2",
		[15] = "披风",
		[16] = "主手",
		[17] = "副手",
		[18] = "远程",
		[19] = "战袍",
	};

	BINDING_HEADER_ALAGEARMAN_QUICK = "<\124cff00ff00alaGearMan\124r>一键换装";
	BINDING_NAME_ALAGEARMAN_QUICK_1 = "套装1";
	BINDING_NAME_ALAGEARMAN_QUICK_2 = "套装2";
	BINDING_NAME_ALAGEARMAN_QUICK_3 = "套装3";
	BINDING_NAME_ALAGEARMAN_QUICK_4 = "套装4";
	BINDING_NAME_ALAGEARMAN_QUICK_5 = "套装5";
	BINDING_NAME_ALAGEARMAN_QUICK_6 = "套装6";
	BINDING_NAME_ALAGEARMAN_QUICK_7 = "套装7";
	BINDING_NAME_ALAGEARMAN_QUICK_8 = "套装8";
	BINDING_NAME_ALAGEARMAN_QUICK_9 = "套装9";
	BINDING_NAME_ALAGEARMAN_QUICK_X = "一键脱光";
elseif LOCALE == "ruRU" then
	L["INVENTORY_IS_FULL"] = "Инвентарь полон";
	L["IN_COMBAT"] = "Не может измениться в бою!";
	L["Add a new outfit"] = "Добавить костюм";
	L["Delete this outfit?"] = "Удалить этот костюм?";
	L["OK"] = "Хорошо";
	L["Cancel"] = "Отмена";
	L["Save"] = "Сохранить";
	L["Equip"] = "Экипировка";
	L["Style"] = "Стиль";
	L["Style_TC"] = "Стиль текста и значков";
	L["Style_T"] = "Стиль иконок";
	L["Style_C"] = "Стиль текста";
	L["Take_Off_All"] = "Снять все снаряжение";
	L["Take_Off_All_ButtonText"] = "С";
	L["Take-off-all On Right"] = "button of  \"Снять все снаряжение\" layed on the \124cffff0000right\124r";
	L["Take-off-all On Left"] = "button of  \"Снять все снаряжение\" layed on the \124cffff0000left\124r";
	L["takeoffAll_include_neck_finger_and_trinket"] = "Снять все снаряжение включает в себя кольцо, акссесуар, плащ и снаряжение с продолжительностью 0%";
	L["takeoffAll_include_neck_finger_and_trinket_false"] = "Снять все снаряжение \124cffff0000DONOT\124r включает в себя кольцо, акссесуар, плащ и снаряжение с продолжительностью 0%";
	L["show_outfit_in_tooltip"] = "\124cffff0000Show\124r outfit info in tooltip";
	L["show_outfit_in_tooltip_false"] = "\124cffff0000DONOT Show\124r outfit info in tooltip";
	L["reset_pos"] = "Reset position of quick bar";
	L["CTRL-DRAG-TO-MOVE"] = "\124cffff40ffHolding ctrl and left-drag to move\124r";
	L["WAITING_FOR_REGEN_ENABLED"] = "Update after combat";
	L["IN_OUTFIT"] = "Equipements Sets: ";
	L["TOOLTIP_MISSING"] = " missing";
	L["IN_BAG"] = "in bag"
	L["CURRENT_OUTFIT"] = "Current Equiped";

	L.slot = {
		[0] = "Ammo",
		[1] = "Head",
		[2] = "Neck",
		[3] = "Shoulder",
		[4] = "Skirt",
		[5] = "Chest",
		[6] = "Waist",
		[7] = "Leg",
		[8] = "Feet",
		[9] = "Wrist",
		[10] = "Glove",
		[11] = "Finger1",
		[12] = "Finger2",
		[13] = "Trinet1",
		[14] = "Trinet2",
		[15] = "Cloak",
		[16] = "Weapon MH",
		[17] = "OffHand",
		[18] = "Ranged",
		[19] = "Tabard",
	};

	BINDING_HEADER_ALAGEARMAN_QUICK = "<\124cff00ff00alaGearMan\124r>";
	BINDING_NAME_ALAGEARMAN_QUICK_1 = "The 1st outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_2 = "The 2nd outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_3 = "The 3rd outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_4 = "The 4th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_5 = "The 4th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_6 = "The 6th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_7 = "The 7th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_8 = "The 8th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_9 = "The 9th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_X = "Снять все снаряжение";
else
	L["INVENTORY_IS_FULL"] = "Inventory is full";
	L["IN_COMBAT"] = "In Combat";
	L["Add a new outfit"] = true;
	L["Delete this outfit?"] = true;
	L["OK"] = true;
	L["Cancel"] = true;
	L["Save"] = true;
	L["Equip"] = true;
	L["Style"] = true;
	L["Style_TC"] = "Text & Texture";
	L["Style_T"] = "Text Only";
	L["Style_C"] = "Texture Only";
	L["Take_Off_All"] = "Stripping";
	L["Take_Off_All_ButtonText"] = "S";
	L["Take-off-all On Right"] = "Stripping button On \124cffff0000Right\124r";
	L["Take-off-all On Left"] = "Stripping button On \124cffff0000Left\124r";
	L["takeoffAll_include_neck_finger_and_trinket"] = "Stripping \124cffff0000DONOT INCLUDES\124r finger, trinket, cloak and duration 0% gear";
	L["takeoffAll_include_neck_finger_and_trinket_false"] = "Stripping \124cffff0000DONOT INCLUDES\124r finger, trinket, cloak and duration 0% gear";
	L["show_outfit_in_tooltip"] = "\124cffff0000Show\124r outfit info in tooltip";
	L["show_outfit_in_tooltip_false"] = "\124cffff0000DONOT Show\124r outfit info in tooltip";
	L["reset_pos"] = "Reset position of quick bar";
	L["CTRL-DRAG-TO-MOVE"] = "\124cffff40ffHolding ctrl and left-drag to move\124r";
	L["WAITING_FOR_REGEN_ENABLED"] = "Update after combat";
	L["IN_OUTFIT"] = "Equipements Sets: ";
	L["TOOLTIP_MISSING"] = " missing";
	L["IN_BAG"] = "in bag"
	L["CURRENT_OUTFIT"] = "Current Equiped";

	L.slot = {
		[0] = "Ammo",
		[1] = "Head",
		[2] = "Neck",
		[3] = "Shoulder",
		[4] = "Skirt",
		[5] = "Chest",
		[6] = "Waist",
		[7] = "Leg",
		[8] = "Feet",
		[9] = "Wrist",
		[10] = "Glove",
		[11] = "Finger1",
		[12] = "Finger2",
		[13] = "Trinet1",
		[14] = "Trinet2",
		[15] = "Cloak",
		[16] = "Weapon MH",
		[17] = "OffHand",
		[18] = "Ranged",
		[19] = "Tabard",
	};

	BINDING_HEADER_ALAGEARMAN_QUICK = "<\124cff00ff00alaGearMan\124r>";
	BINDING_NAME_ALAGEARMAN_QUICK_1 = "The 1st outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_2 = "The 2nd outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_3 = "The 3rd outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_4 = "The 4th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_5 = "The 4th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_6 = "The 6th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_7 = "The 7th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_8 = "The 8th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_9 = "The 9th outfit";
	BINDING_NAME_ALAGEARMAN_QUICK_X = "Stripping";
end
local default = {
	QUICK_SIZE = 18,
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
for slot, v in pairs(SlotInfo) do
	for loc, _ in pairs(v) do
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
for slot, name in pairs(slot2Name) do
	name2Slot[name] = slot;
end
local takeoffAll_order = {	-- by price
	16, 17, 18, 1, 5, 7, 3, 6, 8, 10, 9, 2, 11, 12, 13, 14, 15,--[[ 4,]]--[[ 19,]]
};
local NAME = "alaGearMan";
local SECURE_QUICK_NAME_PREFIX = "alaGearMan_SecureQuick";
local MACRO_NAME_PREFIX = "alaGearMan";
local VERSION = 191020.0;
local NUM_GEAR_BINDING = 9;
--------------------------------------------------
----------------------------------------------------------------------------------------------------main
local function _log_(...)
	--print(...);
end
local function _error_(key, msg, ...)
	print("\124cffff0000" .. key .. "\124r", msg and "\124cffff0000" .. msg .. "\124r" or "", ...);
end
local function _noop_()
end

local PDF_COUNTING_TIME = 0.5;
local PDF_UPDATE_TIME = 0.5;
local num_button_per_line = 6;
local buttonSize = 36;
local texture_unk = 134400;	--"Interface\\Icons\\inv_misc_questionmark";
local texture_takeoff = "Interface\\paperdollinfoframe\\ui-gearmanager-leaveitem-opaque";
local texture_ignore = "Interface\\paperdollinfoframe\\ui-gearmanager-undo";
local texture_add = "interface\\paperdollinfoframe\\character-plus";
local texture_highlight = "Interface\\Buttons\\ButtonHilight-Square";
local texture_highlight_coord = { 0.05, 0.95, 0.05, 0.95, };
local texture_glow = "Interface\\Buttons\\UI-ActionButton-Border";
local texture_glow_coord = { 0.25, 0.75, 0.25, 0.75, };
local texture_ignore_mask = "Interface\\paperdollinfoframe\\ui-gearmanager-leaveitem-transparent";
local texture_delete = "interface\\raidframe\\readycheck-notready";
local texture_modify = "interface\\scenarios\\scenarioicon-interact";
local texture_up = "interface\\mainmenubar\\ui-mainmenu-scrollupbutton-up";
local texture_down = "interface\\mainmenubar\\ui-mainmenu-scrolldownbutton-up";
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

local win_SizeX = 200;
local win_SizeY = 360;
local btn_SizeY = 36;
----------------------------------------------------------------------------------------------------main
local _EventVehicle = CreateFrame("Frame");
_EventVehicle:SetSize(4, 4);
_EventVehicle:EnableMouse(false);

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
	local button = CreateFrame("Button", nil, ui.pdf_menu);
	button:EnableMouse(true);
	button:SetSize(buttonSize, buttonSize);
	button:SetNormalTexture(texture_unk);
	button:SetPushedTexture(texture_unk);
	button:GetPushedTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
	button:SetHighlightTexture(texture_highlight);
	button:GetHighlightTexture():SetTexCoord(unpack(texture_highlight_coord));
	local glow = button:CreateTexture(nil, "OVERLAY");
	glow:SetAllPoints(true);
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
		if pdf_ofs_ignore and id == #var.pdf_list + pdf_ofs_ignore then
			var.gm_ignore[var.pdf_cur_slot] = not var.gm_ignore[var.pdf_cur_slot];
			if var.gm_ignore[var.pdf_cur_slot] then
				ui.pdf_ignore_mask[var.pdf_cur_slot]:Show();
			else
				ui.pdf_ignore_mask[var.pdf_cur_slot]:Hide();
			end
		elseif pdf_ofs_takeoff and id == #var.pdf_list + pdf_ofs_takeoff then
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
		local _, _, quality, _, _, _, _, _, _, t = GetItemInfo(var.pdf_list[i]);
		ui.pdf_buttons[i]:SetNormalTexture(t);
		ui.pdf_buttons[i]:SetPushedTexture(t);
		ui.pdf_buttons[i].glow:SetVertexColor(GetItemQualityColor(quality));
		ui.pdf_buttons[i].glow:Show();
		ui.pdf_buttons[i]:Show();
	end
	if hasInv then
		pdf_ofs_takeoff = 1;
		local i = #var.pdf_list + pdf_ofs_takeoff;
		ui.pdf_buttons[i]:SetNormalTexture(texture_takeoff);
		ui.pdf_buttons[i]:SetPushedTexture(texture_takeoff);
		-- ui.pdf_buttons[i].glow:SetVertexColor(1.0, 0.0, 0.0);
		ui.pdf_buttons[i].glow:Hide();
		ui.pdf_buttons[i]:Show();
	else
		pdf_ofs_takeoff = nil;
	end
	if var.gm_is_editing or var.gm_cur_set then
		pdf_ofs_ignore = (hasInv and 1 or 0) + 1;
		local i = #var.pdf_list + pdf_ofs_ignore;
		ui.pdf_buttons[i]:SetNormalTexture(texture_ignore);
		ui.pdf_buttons[i]:SetPushedTexture(texture_ignore);
		-- ui.pdf_buttons[i].glow:SetVertexColor(1.0, 0.0, 0.0);
		ui.pdf_buttons[i].glow:Hide();
		ui.pdf_buttons[i]:Show();
	else
		pdf_ofs_ignore = nil;
	end
	local pos = 2;
	local lines = 1;
	for i = 2, nButtons do
		if pos > num_button_per_line then
			ui.pdf_buttons[i]:SetPoint("TOP", ui.pdf_buttons[i - num_button_per_line], "BOTTOM", 0, -2);
			pos = 1;
			lines = lines + 1;
		else
			ui.pdf_buttons[i]:SetPoint("LEFT", ui.pdf_buttons[i - 1], "RIGHT", 2, 0);
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
	ui.pdf_menu:Show();
	ui.pdf_menu.countingTime = nil;
end

function func.pdf_EventVehicle_OnUpdate(self, elasped)
	if var.pdf_cur_anchor and ((not var.pdf_cur_slot) or (var.pdf_cur_slot and var.pdf_update_timer > PDF_UPDATE_TIME)) then
		if IsAltKeyDown() then
			local slot = name2Slot[var.pdf_cur_anchor:GetName()];
			if slot then
				--_PaperDollItemSlotButton_OnLeave(var.pdf_cur_anchor);
				wipe(var.pdf_list);
				for i = var.isBankOpened and -1 or 0, var.isBankOpened and 11 or 4 do
					for j = 1, GetContainerNumSlots(i) do
						local link = GetContainerItemLink(i, j);
						if link and IsEquippableItem(link) then
							local loc = select(9, GetItemInfo(link));
							if SlotInfo[slot][loc] then
								tinsert(var.pdf_list, link);
							end
						end
					end
				end
				var.pdf_cur_slot = slot;
				if slot == 0 or slot == 16 or slot == 17 or slot == 18 then
					func.pdf_CreateMenu(1);
				elseif slot == 1 or slot == 2 or slot == 3 or slot == 4 or slot == 5 or slot == 9 or slot == 15 or slot == 9 then
					func.pdf_CreateMenu(2);
				else
					func.pdf_CreateMenu(3);
				end
			end
		else
			var.pdf_cur_slot = nil;
			ui.pdf_menu:Hide();
			--_PaperDollItemSlotButton_OnEnter(var.pdf_cur_anchor);
		end
		var.pdf_update_timer = 0.0;
	else
		if IsAltKeyDown() then
			var.pdf_update_timer = var.pdf_update_timer + elasped;
		else
			var.pdf_cur_slot = nil;
			var.pdf_update_timer = 0.0;
			ui.pdf_menu:Hide();
		end
	end
end

function func.pdf_init()
	for i, n in pairs(slot2Name) do
		local sf = _G[n];
		local ignore_mask = sf:CreateTexture(nil, "OVERLAY");
		ignore_mask:SetAllPoints(true);
		ignore_mask:SetTexture(texture_ignore_mask);
		ignore_mask:Hide();
		ui.pdf_ignore_mask[i] = ignore_mask;
	end
	ui.pdf_menu = CreateFrame("Frame", nil, PaperDollFrame);
	ui.pdf_menu:SetFrameStrata("FULLSCREEN_DIALOG");
	ui.pdf_menu:SetScript("OnUpdate", function(self, elasped)
		if ui.pdf_menu.countingTime then
			self.countingTime = self.countingTime - elasped;
			if self.countingTime < 0 then
				self:Hide();
				self.countingTime = nil;
				var.pdf_cur_slot = nil;
				var.pdf_cur_anchor = nil;
				wipe(var.pdf_list);
			end
		end
	end);
	ui.pdf_menu:SetScript("OnEnter", function(self)
		self.countingTime = nil;
	end);
	ui.pdf_menu:SetScript("OnLeave", function(self) self.countingTime = PDF_COUNTING_TIME; end);

	func.pdf_CreateButton(1);
	ui.pdf_buttons[1]:SetPoint("TOPLEFT");

	_G.PaperDollItemSlotButton_OnEnter = function(self)
		_EventVehicle:SetScript("OnUpdate", func.pdf_EventVehicle_OnUpdate);
		if ui.pdf_menu:IsShown() then
			if var.pdf_cur_anchor == self then
				ui.pdf_menu.countingTime = nil;
			else
				var.pdf_cur_slot = nil;
				ui.pdf_menu:Hide();
			end
		end
		var.pdf_cur_anchor = self;
		--if not IsAltKeyDown() then
			return _PaperDollItemSlotButton_OnEnter(self);
		--end
	end
	_G.PaperDollItemSlotButton_OnLeave = function(self)
		var.pdf_cur_anchor = nil;
		_EventVehicle:SetScript("OnUpdate", nil);
		ui.pdf_menu.countingTime = PDF_COUNTING_TIME;
		return _PaperDollItemSlotButton_OnLeave(self);
	end
end
function func.pdf_hide_mask()
	for slot, mask in pairs(ui.pdf_ignore_mask) do
		mask:Hide();
		var.gm_ignore[slot] = false;
	end
end
function func.pdf_show_mask(set)
	for slot, mask in pairs(ui.pdf_ignore_mask) do
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
	if alaGearManSV.takeoffAll_pos == 'LEFT' then
		index = index - 1;
	end
	local T, isCur = func.check(index);
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT");
	if T then
		GameTooltip:AddLine(T.name, 1.0, 1.0, 1.0);
		if isCur then
			GameTooltip:AddLine(L["CURRENT_OUTFIT"], 0.0, 1.0, 0.0);
		else
			local set = saved_sets[index];
			local missed = false;
			for slot = 0, 19 do
				local link = T[slot];
				if type(link) == 'string' then
					missed = true;
					GameTooltip:AddDoubleLine(L.slot[slot] .. L["TOOLTIP_MISSING"], link, 1.0, 0.0, 0.0);
				end
			end
			if not missed then
				-- 
			end
			for slot = 0, 19 do
				if T[slot] == 0 then
					local link = set[slot];
					GameTooltip:AddDoubleLine(L.slot[slot] .. L["IN_BAG"], link, 1.0, 1.0, 0.0);
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
		for _, msg in pairs(self.info) do
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
		self.which = nil;
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
	local button = CreateFrame("Button", nil, parent);
	button:SetHeight(buttonHeight);
	button:SetBackdrop(buttonBackdrop);
	button:SetBackdropColor(buttonBackdropColor[1], buttonBackdropColor[2], buttonBackdropColor[3], buttonBackdropColor[4]);
	button:SetBackdropBorderColor(buttonBackdropBorderColor[1], buttonBackdropBorderColor[2], buttonBackdropBorderColor[3], buttonBackdropBorderColor[4]);
	button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
	button:EnableMouse(true);
	button:RegisterForDrag("LeftButton");
	button:Show();

	local icon = button:CreateTexture(nil, "OVERLAY");
	icon:SetTexture(texture_unk);
	icon:SetSize(buttonHeight - 4, buttonHeight - 4);
	icon:SetPoint("LEFT", 4, 0);
	button.icon = icon;

	local title = button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
	title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
	button.title = title;

	local glow = button:CreateTexture(nil, "OVERLAY");
	glow:SetTexture(texture_glow);
	glow:SetTexCoord(unpack(texture_glow_coord));
	glow:SetAllPoints(true);
	glow:SetBlendMode("ADD");
	glow:Hide();
	button.glow = glow;

	local delete = CreateFrame("Button", nil, button);
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

	local modify = CreateFrame("Button", nil, button);
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

	local up = CreateFrame("Button", nil, button);
	up:SetSize(buttonHeight * 0.4, buttonHeight * 0.4);
	up:SetNormalTexture(texture_up);
	up:GetNormalTexture():SetTexCoord(6 / 32, 25 / 32, 7 / 32, 24 / 32);
	up:SetPushedTexture(texture_up);
	up:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
	up:GetPushedTexture():SetTexCoord(6 / 32, 25 / 32, 7 / 32, 24 / 32);
	up:SetDisabledTexture(texture_up);
	up:GetDisabledTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
	up:GetDisabledTexture():SetTexCoord(6 / 32, 25 / 32, 7 / 32, 24 / 32);
	up:SetPoint("TOPRIGHT", -6 - buttonHeight * 0.4, -2);
	up:Show();
	up:SetScript("OnEnter", func.OnEnter_Info);
	up:SetScript("OnLeave", func.OnLeave_Info);
	up:SetScript("OnClick", function(self)
		func.up(button:GetDataIndex());
	end);
	-- up.info = {  };
	button.up = up;

	local down = CreateFrame("Button", nil, button);
	down:SetSize(buttonHeight * 0.4, buttonHeight * 0.4);
	down:SetNormalTexture(texture_down);
	down:GetNormalTexture():SetTexCoord(6 / 32, 25 / 32, 7 / 32, 24 / 32);
	down:SetPushedTexture(texture_down);
	down:GetPushedTexture():SetTexCoord(6 / 32, 25 / 32, 7 / 32, 24 / 32);
	down:GetPushedTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
	down:SetDisabledTexture(texture_down);
	down:GetDisabledTexture():SetTexCoord(6 / 32, 25 / 32, 7 / 32, 24 / 32);
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

	function button:SetIconTexture(tex)
		icon:SetTexture(tex);
	end
	function button:SetTitleText(text)
		title:SetText(text);
	end
	function button:Select()
		self.selected = true;
		self.glow:Show();
	end
	function button:Deselect()
		self.selected = nil;
		self.glow:Hide();
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
		local index = button:GetDataIndex();
		local macro_name = MACRO_NAME_PREFIX .. index;
		if GetMacroInfo(macro_name) then
			PickupMacro(macro_name);
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
		if button:IsSelected() and button:GetDataIndex() ~= var.gm_cur_set then
			button:Deselect();
		elseif not button:IsSelected() and button:GetDataIndex() == var.gm_cur_set then
			button:Select();
		end
		button.delete:Show();
		button.modify:Show();
		button.up:Show();
		button.down:Show();
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
	elseif index == #sets + 1 then
		button:SetIconTexture(texture_add);
		button:SetTitleText(L["Add a new outfit"]);
		button:Show();
		if button:IsSelected() and button:GetDataIndex() ~= var.gm_cur_set then
			button:Deselect();
		elseif not button:IsSelected() and button:GetDataIndex() == var.gm_cur_set then
			button:Select();
		end
		button.delete:Hide();
		button.modify:Hide();
		button.up:Hide();
		button.down:Hide();
	else
		button:Hide();
	end
end

function func.initUI()
	ui.open = CreateFrame("Button", nil, PaperDollFrame);
	ui.open:SetSize(32, 32);
	ui.open:SetPoint("TOPRIGHT", -40, -40);
	ui.open:SetNormalTexture("interface\\paperdollinfoframe\\ui-gearmanager-button");
	ui.open:SetPushedTexture("interface\\paperdollinfoframe\\ui-gearmanager-button-pushed");
	ui.open:EnableMouse(true);
	ui.open:SetScript("OnClick", func.open_onclick);

	do	--win
		ui.gearWin = CreateFrame("Frame", nil, PaperDollFrame);
		ui.gearWin:SetFrameStrata("FULLSCREEN");
		ui.gearWin:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "interface/dialogframe/ui-dialogbox-border",
			tile = true,
			tileSize = 16,
			edgeSize = 20,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		});
		ui.gearWin:SetBackdropColor(0.0, 0.0, 0.0, 0.9)
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

		ui.scroll = ALASCR(ui.gearWin, win_SizeX - 20, win_SizeY - 64, btn_SizeY, func.gm_CreateButton, func.gm_SetButton);
		ui.scroll:SetPoint("BOTTOMLEFT", 10, 10);

		ui.save = CreateFrame("Button", nil, ui.gearWin, "UIPanelButtonTemplate");
		ui.save:SetPoint("TOPLEFT", win_SizeX / 9, -16);
		ui.save:SetText(L["Save"]);
		ui.save:SetSize(win_SizeX / 3, 24);
		ui.save:SetScript("OnClick", function(self) func.save(); end);

		ui.equip = CreateFrame("Button", nil, ui.gearWin, "UIPanelButtonTemplate");
		ui.equip:SetPoint("TOPLEFT", win_SizeX * 5 / 9, -16);
		ui.equip:SetText(L["Equip"]);
		ui.equip:SetSize(win_SizeX / 3, 24);
		ui.equip:SetScript("OnClick", function(self) func.equip(); end);

		ui.setting = CreateFrame("Button", nil, ui.gearWin);
		ui.setting:SetSize(24, 24);
		ui.setting:SetNormalTexture(texture_modify);
		ui.setting:SetPoint("TOPRIGHT");
		ui.setting:SetScript("OnClick", func.setting);
	end

	if false then	--quick panel
		ui.quick = CreateFrame("frame");
		ui.quick:SetPoint(unpack(alaGearManSV.quickPos));
		ui.quick:EnableMouse(true);
		ui.quick:SetMovable(true);
		ui.quick:RegisterForDrag("LeftButton");
		ui.quick:SetScript("OnDragStart", function(self)
			if IsControlKeyDown() then
				self:StartMoving();
			end
		end);
		ui.quick:SetScript("OnDragStop", function(self)
			self:StopMovingOrSizing();
			self:SavePos();
		end);
		ui.quick:Show();
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
		function ui.quick:SavePos()
			alaGearManSV.quickPos = { self:GetPoint() };
			for k, v in pairs(alaGearManSV.quickPos) do
				if type(v) == 'table' then
					alaGearManSV.quickPos[k] = v:GetName();
				end
			end
		end
		local quickButtons = { n = 0, };
		-- local info = { L["Take_Off_All"], L["CTRL-DRAG-TO-MOVE"], };
		function ui.quick:Create(index)
			if quickButtons[index] then
				quickButtons[index].id = index;
				return quickButtons[index];
			end
			local button = CreateFrame("Button", "alaGearMan_Quick" .. index, ui.quick);
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
					ui.quick:StartMoving();
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
				self.title:SetScale(self:GetWidth() / default.QUICK_SIZE);
			end);
			local title = button:CreateFontString(nil, "OVERLAY");
			title:SetPoint("CENTER");
			title:SetFont(GameFontNormal:GetFont(), alaGearManSV.quickSize * 0.75, "OUTLINE");
			title:SetVertexColor(1.0, 0.75, 0.0, 1.0);
			button.title = title;
			local icon = button:CreateTexture(nil, "ARTWORK");
			icon:SetAllPoints(true);
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
			ClearOverrideBindings(_EventVehicle);
			for i = 1, N do
				local button = secureButtons[i];
				local setIndex = i;
				if alaGearManSV.takeoffAll_pos == 'LEFT' then
					setIndex = i - 1;
				end
				if i == TOA then
					local key1, key2 = GetBindingKey("ALAGEARMAN_QUICK_X");
					if key1 then
						SetOverrideBindingClick(_EventVehicle, false, key1, button:GetName());
					end
					if key2 then
						SetOverrideBindingClick(_EventVehicle, false, key2, button:GetName());
					end
				else
					if setIndex <= NUM_GEAR_BINDING then
						local key1, key2 = GetBindingKey("ALAGEARMAN_QUICK_" .. setIndex);
						if key1 then
							SetOverrideBindingClick(_EventVehicle, false, key1, button:GetName());
						end
						if key2 then
							SetOverrideBindingClick(_EventVehicle, false, key2, button:GetName());
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
					button:SetTitleAndIcon(L["Take_Off_All_ButtonText"], iconTable[37]);
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
		ui.secure = CreateFrame("frame", nil, UIParent);
		ui.secure:SetPoint(unpack(alaGearManSV.quickPos));
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
		end);
		function ui.secure:SavePos()
			alaGearManSV.quickPos = { self:GetPoint() };
			for k, v in pairs(alaGearManSV.quickPos) do
				if type(v) == 'table' then
					alaGearManSV.quickPos[k] = v:GetName();
				end
			end
		end
		local secureButtons = { n = 0, };
		-- local info = { L["Take_Off_All"], L["CTRL-DRAG-TO-MOVE"], };
		function ui.secure:Create(index)
			if secureButtons[index] then
				secureButtons[index].id = index;
				return secureButtons[index];
			end
			local button = CreateFrame("CheckButton", SECURE_QUICK_NAME_PREFIX .. index, ui.secure, "SecureActionButtonTemplate");
			button:SetAttribute('type', 'macro');
			-- button:SetAttribute('macrotext', '');
			-- SecureHandler_OnLoad(button);
			-- UnregisterStateDriver(button, "page");
			button:SetAttribute('showgrid', 0);
			-- button:SetAttribute("action", ACTION_START + index);
			button:SetSize(alaGearManSV.quickSize, alaGearManSV.quickSize);
			button:Show();
			button:EnableMouse(true);
			-- button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			button:SetClampedToScreen(true);
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
				self.title:SetScale(self:GetWidth() / default.QUICK_SIZE);
			end);
			local title = button:CreateFontString(nil, "OVERLAY");
			title:SetPoint("CENTER");
			title:SetFont(GameFontNormal:GetFont(), default.QUICK_SIZE * 0.75, "OUTLINE");
			title:SetVertexColor(1.0, 0.75, 0.0, 1.0);
			button:SetFontString(title);
			button:SetPushedTextOffset(1, - 1);
			button.title = title;
			local icon = button:CreateTexture(nil, "ARTWORK");
			icon:SetAllPoints(true);
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
			secureButtons[index] = button;
			if index == 1 then
				button:SetPoint("TOPLEFT", 2, -2);
			else
				button:SetPoint("LEFT", secureButtons[index - 1], "RIGHT", 2, 0);
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
			ClearOverrideBindings(_EventVehicle);
			for i = 1, N do
				local button = secureButtons[i];
				local setIndex = i;
				if alaGearManSV.takeoffAll_pos == 'LEFT' then
					setIndex = i - 1;
				end
				if i == TOA then
					local key1, key2 = GetBindingKey("ALAGEARMAN_QUICK_X");
					if key1 then
						SetOverrideBindingClick(_EventVehicle, false, key1, button:GetName());
					end
					if key2 then
						SetOverrideBindingClick(_EventVehicle, false, key2, button:GetName());
					end
				else
					if setIndex <= NUM_GEAR_BINDING then
						local key1, key2 = GetBindingKey("ALAGEARMAN_QUICK_" .. setIndex);
						if key1 then
							SetOverrideBindingClick(_EventVehicle, false, key1, button:GetName());
						end
						if key2 then
							SetOverrideBindingClick(_EventVehicle, false, key2, button:GetName());
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
			local TOA = (alaGearManSV.takeoffAll_pos == 'LEFT') and 1 or N;
			for i = 1, #saved_sets do
				local macro_name = MACRO_NAME_PREFIX .. i;
				if GetMacroInfo(macro_name) then
					EditMacro(macro_name, macro_name, iconTable[saved_sets[i].icon or 1], "/click " .. SECURE_QUICK_NAME_PREFIX .. i);
				else
					CreateMacro(macro_name, iconTable[saved_sets[i].icon or 1], "/click " .. SECURE_QUICK_NAME_PREFIX .. i);
				end
			end
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
					button:SetTitleAndIcon(L["Take_Off_All_ButtonText"], iconTable[37]);
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
		end
		ui.secureButtons = secureButtons;
		ui.secure:Create(1);	--for take_off_all button
		ui.secure:Update();
		-- ui.secure:Hide();
	end

	do	--customize
		ui.custom = CreateFrame("Frame", nil, ui.gearWin);
		ui.custom:SetFrameStrata("FULLSCREEN");
		ui.custom:SetBackdrop({
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "interface/dialogframe/ui-dialogbox-border",
			tile = true,
			tileSize = 16,
			edgeSize = 20,
			insets = { left = 4, right = 4, top = 4, bottom = 4 }
		});
		ui.custom:SetBackdropColor(0.0, 0.0, 0.0, 0.9)
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

		ui.customEdit = CreateFrame("EditBox", nil, ui.custom);
		ui.customEdit:SetSize(220, 24);
		ui.customEdit:SetFontObject(GameFontHighlightSmall);
		ui.customEdit:SetAutoFocus(false);
		ui.customEdit:SetJustifyH("LEFT");
		ui.customEdit:Show();
		ui.customEdit:EnableMouse(true);
		-- ui.customEdit:SetBackdrop({
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

		ui.customOK = CreateFrame("Button", nil, ui.custom, "UIPanelButtonTemplate");
		ui.customOK:SetPoint("TOPRIGHT", -12, -12);
		ui.customOK:SetText(L["OK"]);
		ui.customOK:SetSize(70, 24);
		ui.customOK:SetScript("OnClick", func.customOK);

		ui.customCancel = CreateFrame("Button", nil, ui.custom, "UIPanelButtonTemplate");
		ui.customCancel:SetPoint("BOTTOMRIGHT", -12, 12);
		ui.customCancel:SetText(L["Cancel"]);
		ui.customCancel:SetSize(70, 24);
		ui.customCancel:SetScript("OnClick", func.customCancel);

		local customIconButtons = {  };
		local row = 0;
		local col = 0;
		for i = 1, #iconTable do
			local button = CreateFrame("Button", nil, ui.custom);
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

			local glow = button:CreateTexture(nil, "OVERLAY");
			glow:SetTexture(texture_glow);
			glow:SetTexCoord(unpack(texture_glow_coord));
			glow:SetVertexColor(1.0, 0.0, 0.0);
			--glow:SetAllPoints(true);
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
	tinsert(elements, {
		handler = function()
			alaGearManSV.quickPos = { "TOP", 0, 0, };
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
	end
end
function func.save(set)
	set = set or var.gm_cur_set;
	if set then
		saved_sets[set] = saved_sets[set] or {  };
		local set = saved_sets[set];
		for slot = 0, 19 do
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
	if InCombatLockdown() then
		_error_(L["IN_COMBAT"]);
		return;
	end
	set = set or var.gm_cur_set;
	if set and saved_sets[set] then
		local set = saved_sets[set];
		local disordered = false;
		for slot = 0, 19 do
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
		func.Sound_Equip();
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
		func.Sound_Order()
	end
end
function func.down(index)
	local cur = saved_sets[index];
	if cur and index < #saved_sets then
		saved_sets[index] = saved_sets[index + 1];
		saved_sets[index + 1] = cur;
		ui.scroll:Update();
		ui.secure:Update();
		func.Sound_Order()
	end
end
function func.check(index)
	if index > 0 and index <= #saved_sets then
		local set = saved_sets[index];
		local T = CreateFromMixins(set);
		local all_empty_or_fit = true;
		for slot = 0, 19 do
			local id = GetInventoryItemID('player', slot);
			if id and T[slot] and type(T[slot]) == 'string' and id == tonumber(select(3, strfind(T[slot], "item:(%d+)"))) then
				T[slot] = nil;
			elseif (slot == 11 or slot == 13 or slot == 16) and id and T[slot + 1] and type(T[slot + 1]) == 'string' and id == tonumber(select(3, strfind(T[slot + 1], "item:(%d+)"))) then
				T[slot + 1] = nil;
			elseif (slot == 12 or slot == 14 or slot == 17) and id and T[slot - 1] and type(T[slot - 1]) == 'string' and id == tonumber(select(3, strfind(T[slot - 1], "item:(%d+)"))) then
				T[slot - 1] = nil;
			elseif T[slot] and type(T[slot]) == 'string' then
				all_empty_or_fit = false;
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
						for _, slot in pairs(slots) do
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
	if key == 'quickStyle' then
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
	end
end
function func.handle_low_version_variables()
	if not alaGearManSV._version then
		for _, set in pairs(alaGearManSV.sets[GUID]) do
			for slot, inv in pairs(set) do
			end
		end
	elseif tonumber(alaGearManSV._version) < VERSION then
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
			for _, slot in pairs(slots) do
				for index, set in pairs(saved_sets) do
					if type(set[slot]) == 'string' and ((set[slot] == link) or (ID and ID == select(3, strfind(set[slot], "item:(%d+)")))) then
						self:AddLine("\124cffffcf00" .. L["IN_OUTFIT"] .. "\124r\124cffffffff" .. set.name);
					end
				end
			end
		end
	end
end
function func.init_variables()
	alaGearManSV = alaGearManSV or {  };
	alaGearManSV.sets = alaGearManSV.sets or {  };
	alaGearManSV.sets[GUID] = alaGearManSV.sets[GUID] or {  };
	alaGearManSV.quickSize = alaGearManSV.quickSize or default.QUICK_SIZE;
	alaGearManSV.quickStyle = alaGearManSV.quickStyle or 'C';	--'T' 'C' 'TC'
	alaGearManSV.quickPos = alaGearManSV.quickPos or { "TOP", 0, - 100, };
	alaGearManSV.takeoffAll_pos = alaGearManSV.takeoffAll_pos or 'RIGHT';
	alaGearManSV.takeoffAll_include_neck_finger_and_trinket = alaGearManSV.takeoffAll_include_neck_finger_and_trinket or false;
	alaGearManSV.show_outfit_in_tooltip = alaGearManSV.show_outfit_in_tooltip or true;

	func.handle_low_version_variables();
end
function func.init_hook_tooltip()
	GameTooltip:HookScript("OnTooltipSetItem", func.hook_tooltip);
	ItemRefTooltip:HookScript("OnTooltipSetItem", func.hook_tooltip);
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
function func.ADDON_LOADED(arg1, ...)
	if arg1 == "alaGearMan" then
		_EventVehicle:UnregisterEvent("ADDON_LOADED");
		C_Timer.After(0.1, function()
			func.init_variables();
			saved_sets = alaGearManSV.sets[GUID];
			func.pdf_init();
			func.initUI();
			func.init_hook_tooltip();
			func.Reg("UPDATE_BINDINGS");
			func.Reg("BANKFRAME_OPENED");
			func.Reg("BANKFRAME_CLOSED");
		end);
	end
end

function func.Reg(event)
	if not func[event] then
		func[event] = _noop_;
	end
	_EventVehicle:RegisterEvent(event);
end
function func.OnEvent(self, event, ...)
	func[event](...);
end
function func.FireEvent(event, ...)
	func.OnEvent(_EventVehicle, event, ...);
end
_EventVehicle:SetScript("OnEvent", func.OnEvent);

func.Reg("ADDON_LOADED");

-- 老虎会游泳：启用/禁用快捷栏
function func.toggle_quick_panel(show)
	if show == nil then
		show = not ui.secure:IsShown()
	end
	if show then
		ui.secure:Show();
	else
		ui.secure:Hide();
	end
end
-- 老虎会游泳：打开套装配置
function func.show_gear_win()
	ui.gearWin:Show();
end

_G.AGM_FUNC = func;
_G.AGM_GVAR = global_var;

