--[[--
	by ALA @ 163UI
	DATA FROM WEB SOURCE CODE OF WOWHEAD
	数据来源于wowhead网页源代码
	Please Keep WOW Addon open-source & Reduce barriers for others.
	复用代码请在显著位置标注来源【ALA@网易有爱】
	请勿加密、乱码、删除空格tab换行符、设置加载依赖
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
__ala_meta__.emu = NS;

local _G = _G;
do
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("ate assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end
local __rt = __ala_meta__.__rt;

local L = NS.L;
if not L then return; end
local curPhase = 5;
----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
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
	----------------------------------------------------------------------------------------------------GAME
	local print = print;
	local GetTime = GetTime;
	local CreateFrame = CreateFrame;
	local GetCursorPosition = GetCursorPosition;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;

	local UnitName = UnitName;
	local UnitLevel = UnitLevel;
	local GetRealmName = GetRealmName;
	local GetNumTalents = GetNumTalents;	--local numTalents = GetNumTalents([1 - 5])
	local GetTalentInfo = GetTalentInfo;	--local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo([1 - 5], GetNumTalents([1 - 5]));
	local LearnTalent = LearnTalent;
	local GetSpellInfo = GetSpellInfo;
	local GameTooltip = GameTooltip;
	--------------------------------------------------
	local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
	local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
	local MAX_NUM_TALENTS = MAX_NUM_TALENTS or 20;
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
	local CLASS_ICON_TCOORDS = CLASS_ICON_TCOORDS;
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------local
	local function _log_(...)
		-- print(date('\124cff00ff00%H:%M:%S\124r'), ...);
	end
	local function _error_(...)
		print(date('\124cffff0000%H:%M:%S\124r'), ...);
	end
	local function _noop_()
	end
	_G.ALA_GetSpellLink = _G.ALA_GetSpellLink or function(id, name)
		--\124cff71d5ff\124Hspell:id\124h[name]\124h\124r
		name = name or GetSpellInfo(id);
		if name then
			if __ala_meta__.chat and __ala_meta__.chat.alac_hyperLink and __ala_meta__.chat.alac_hyperLink() then
				return "\124cff71d5ff\124Hspell:" .. id .. "\124h[" .. name .. "]\124h\124r";
			else
				return name;
			end
		else
			return nil;
		end
	end
	local _GetSpellLink = _G.ALA_GetSpellLink;
	--------------------------------------------------
	local _ = nil;
	local ARTWORK_PATH = "Interface\\Addons\\alaTalentEmu\\ARTWORK\\";
	NS.ARTWORK_PATH = ARTWORK_PATH;
	local LOCALE = GetLocale();
	--------------------------------------------------
	local MAX_NUM_TIER = 7;
	local MAX_NUM_COL = 4;
	local MAX_NUM_ICONS_PER_SPEC = MAX_NUM_TIER * MAX_NUM_COL;
	local NUM_POINTS_NEXT_TIER = 5;
	local DATA_VALIDITY = 30;
	--------------------------------------------------
	local ui_style =
	{
		mainFrameBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0, }
		},
		mainFrameBackdropColor = { 0.25, 0.25, 0.25, 1.0, },
		mainFrameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
		mainFrameBackdrop_blz = {
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "interface/dialogframe/ui-dialogbox-border",
			tile = true,
			tileSize = 16,
			edgeSize = 24,
			insets = { left = 4, right = 4, top = 4, bottom = 4, }
		},
		mainFrameBackdropColor_blz = { 0.0, 0.0, 0.0, 1.0, },
		mainFrameBackdropBorderColor_blz = { 1.0, 1.0, 1.0, 1.0, },
		mainFrameBorderSize = 8,
		-- iconBackdrop = {
		-- 	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		-- 	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		-- 	tile = true,
		-- 	tileSize = 2,
		-- 	edgeSize = 2,
		-- 	insets = { left = 0, right = 0, top = 0, bottom = 0, }
		-- },
		-- iconBackdropColor = { 0.25, 0.25, 0.25, 0.75, },
		-- iconBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
		tooltipFrameBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 2, right = 2, top = 2, bottom = 2, }
		},
		tooltipFrameBackdropColor = { 0.15, 0.15, 0.15, 1.0, },
		tooltipFrameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
		tooltipBackdrop = {
			bgFile = nil,	--"Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = nil,	--"Interface\\Tooltips\\UI-Tooltip-Border",
			tile = false,
			tileSize = 0,
			edgeSize = 0,
			insets = { left = 0, right = 0, top = 0, bottom = 0, }
		},
		spellTabFrameBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0, }
		},
		spellTabFrameBackdropColor = { 0.25, 0.25, 0.25, 0.75, },
		spellTabFrameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
		spellTabFrameBackdrop_blz = {
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "interface/dialogframe/ui-dialogbox-border",
			tile = true,
			tileSize = 16,
			edgeSize = 24,
			insets = { left = 4, right = 4, top = 4, bottom = 4, }
		},
		spellTabFrameBackdropColor_blz = { 0.0, 0.0, 0.0, 0.5, },
		spellTabFrameBackdropBorderColor_blz = { 1.0, 1.0, 1.0, 1.0, },
		spellTabFrameButtonBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		};
		spellTabFrameButtonBackdropColor = { 0.25, 0.25, 0.25, 0.75, };
		spellTabFrameButtonBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, };
		equipmentFrameBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0, }
		},
		equipmentFrameBackdropColor = { 0.25, 0.25, 0.25, 1.0, },
		equipmentFrameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
		equipmentFrameBackdrop_blz = {
			bgFile = "Interface/Tooltips/UI-Tooltip-Background",
			edgeFile = "interface/dialogframe/ui-dialogbox-border",
			tile = true,
			tileSize = 16,
			edgeSize = 24,
			insets = { left = 4, right = 4, top = 4, bottom = 4, }
		},
		equipmentFrameBackdropColor_blz = { 0.25, 0.25, 0.25, 1.0, },
		equipmentFrameBackdropBorderColor_blz = { 1.0, 1.0, 1.0, 1.0, },

		mainFrameXSizeMin_Style1 = 250,
		mainFrameYSizeMin_Style1 = 165,
		mainFrameXSizeMin_Style2 = 100,
		mainFrameYSizeMin_Style2 = 180,
		mainFrameHeaderYSize = 20,
		mainFrameFooterYSize = 24,

		frameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		frameFontSize = 16,
		frameFontSizeMid = 14,
		frameFontSizeSmall = 12,
		frameFontOutline = "NORMAL",

		talentIconSize = 42,
		talentIconXGap = 12,
		talentIconYGap = 12,
		talentIconXToBorder = 14,
		talentIconYToTop = 12,
		talentIconYToBottom = 10,
		talentIconFont = NumberFont_Shadow_Med:GetFont(),--="Fonts\ARHei.ttf"
		--"Fonts\\FRIZQT__.TTF",
		talentIconFontSize = 16,
		talentIconFontOutline = "NORMAL",
		talentFrameXToBorder = 4,
		talentFrameYToBorder = 0,
		talentFrameHeaderYSize = 0,
		talentFrameFooterYSize = 20,
		seqWidth = 1,

		talentDepArrowXSize = 20,
		talentDepArrowYSize = 20,
		talentDepBranchXSize = 8,

		spellTabFrameXSize = 200,
		spellTabFrameButtonHeight= 24;
		spellTabFrameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		spellTabFrameFontSize = 14,
		spellTabFrameFontOutline = "NORMAL",
		spellTabFrameXToBorder = 4,
		spellTabFrameYToTop = 32,
		spellTabFrameYToBottom = 32,

		equipmentFrameXSize = 280;
		equipmentFrameButtonSize = 32;
		equipmentFrameButtonGap = 6;
		equipmentFrameArmorWeaponGap = 16;
		equipmentFrameButtonXToBorder = 8;
		equipmentFrameButtonYToBorder = 16;
		equipmentFrameIconTextGap = 4;

		raidToolUIFrameXSize = 640,
		raidToolUIFrameYSize = 320,
		raidToolUIFrameButtonHeight = 24,

		controlButtonSize = 20,
		editBoxXSize = 240,
		editBoxYSize = 32,
		tabButtonSize = 28,
		tabButtonGap = 2,
		curClassIndicatorSize = 36,

		specTabButtonXSize = 68,
		specTabButtonYSize = 18,
		specTabButtonGap = 10,
		specTabButtonTexCoord = { 0.05, 0.95, 0.40, 0.70, },
		curSpecIndicatorSize = 28,

		color_iconTextDisabled = { 1.0, 1.0, 1.0, 1.0, },
		color_iconTextAvailable = { 0.0, 1.0, 0.0, 1.0, },
		color_iconTextMaxRank = { 1.0, 1.0, 0.0, 1.0, },
		color_iconToolTipCurRank = { 0.0, 1.0, 0.0, 1.0, },
		color_iconToolTipNextRank = { 0.0, 0.5, 1.0, 1.0, },
		color_iconToolTipNextRankDisabled = { 1.0, 0.0, 0.0, 1.0, },
		color_iconToolTipMaxRank = { 1.0, 0.5, 0.0, 1.0, },

	};
	ui_style.talentFrameXSizeSingle = ui_style.talentIconSize * MAX_NUM_COL + ui_style.talentIconXGap * (MAX_NUM_COL - 1) + ui_style.talentIconXToBorder * 2;
	ui_style.talentFrameXSizeTriple = ui_style.talentFrameXSizeSingle * 3;
	ui_style.talentFrameYSize = ui_style.talentFrameHeaderYSize + ui_style.talentIconYToTop + ui_style.talentIconSize * MAX_NUM_TIER + ui_style.talentIconYGap * (MAX_NUM_TIER - 1) + ui_style.talentIconYToBottom+ ui_style.talentFrameFooterYSize;
	ui_style.mainFrameXSizeDefault_Style1 = ui_style.talentFrameXSizeTriple + ui_style.talentFrameXToBorder * 2;
	ui_style.mainFrameYSizeDefault_Style1 = ui_style.talentFrameYSize + ui_style.talentFrameYToBorder * 2 + ui_style.mainFrameHeaderYSize + ui_style.mainFrameFooterYSize;
	ui_style.mainFrameXSizeDefault_Style2 = ui_style.talentFrameXSizeSingle + ui_style.talentFrameXToBorder * 2;
	ui_style.mainFrameYSizeDefault_Style2 = ui_style.talentFrameYSize + ui_style.talentFrameYToBorder * 2 + ui_style.mainFrameHeaderYSize + ui_style.mainFrameFooterYSize;
	ui_style.equipmentContainerYSize = ui_style.equipmentFrameButtonYToBorder + ui_style.equipmentFrameButtonSize * 10 + ui_style.equipmentFrameButtonGap * 11 + ui_style.equipmentFrameArmorWeaponGap + ui_style.equipmentFrameButtonYToBorder;
	if LOCALE == 'zhCN' or LOCALE == 'zhTW' then
		ui_style.frameFontSizeSmall = ui_style.frameFontSizeMid;
	end
	local TEXTURE_SET =
	{
		LIBDBICON = ARTWORK_PATH .. "ICON",		--	"interface\\buttons\\ui-microbutton-talents-up",
		UNK = "Interface\\Icons\\inv_misc_questionmark",
		SQUARE_HIGHLIGHT = ARTWORK_PATH .. "CheckButtonHilight",
		NORMAL_HIGHLIGHT = ARTWORK_PATH .. "ui-panel-minimizebutton-highlight",
		SEP_HORIZONTAL = ARTWORK_PATH .. "UI-ChatFrame-BorderLeft",
		SEP_HORIZONTAL_COORD = { 0.25, 0.3125, 0.0, 1.0, },
		SEP_VERTICAL = ARTWORK_PATH .. "UI-ChatFrame-BorderTop",
		SEP_VERTICAL_COORD = { 0.0, 1.0, 0.25, 0.3125, },
		CONTROL_PUSHED_COLOR = { 0.5, 0.5, 0.5, 1.0, },
		CONTROL_DISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
		CONTROL_HIGHLIGHT_COLOR = { 0.25, 0.25, 0.75, 1.0, },

		ARROW = ARTWORK_PATH .. "ui-talentarrows",
		ARROW_COORD = {
			[1] = {  8 / 64, 24 / 64, 40 / 64, 56 / 64, },	--vertical disable
			[2] = {  8 / 64, 24 / 64, 08 / 64, 26 / 64, },	--vertical enable
			[3] = { 40 / 64, 56 / 64, 40 / 64, 56 / 64, },	--horizontal disable
			[4] = { 40 / 64, 56 / 64,  8 / 64, 24 / 64, },	--horizontal enable
		},
		BRANCH = ARTWORK_PATH .. "ui-talentbranches",
		BRANCH_COORD = {
			[1] = { 44 / 256, 54 / 256, 0.5, 1.0, },	--vertical disable
			[2] = { 44 / 256, 54 / 256, 0.0, 0.5, },	----vertical enable
			[3] = { 66 / 256, 98 / 256, 43 / 64, 53 / 64, },	--horizontal disable
			[4] = { 66 / 256, 98 / 256, 11 / 64, 21 / 64, },	--horizontal enable
		},
		ICON_BG = "interface\\gmchatframe\\ui-gmstatusframe-pulse",
		ICON_BG_COORD = { 16 / 256, 240 / 256, 20 / 128, 108 / 128, },
		ICON_LIGHT_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		ICON_UNLIGHT_COLOR = { 0.250, 0.250, 0.250, 1.0, },
		ICON_HIGHLIGHT_COORD = { 0.08, 0.92, 0.08, 0.92, },
		ICON_HIGHLIGHT_COLOR = { 0.0, 1.0, 1.0, },
		ICON_NECESSARY = ARTWORK_PATH .. "readycheck-ready",
		ICON_FORBIDDEN = ARTWORK_PATH .. "readycheck-notready",

		TALENT_RESET_BG = ARTWORK_PATH .. "arcane_circular_frame",
		TALENT_RESET_BG_COORD = { 12 / 128, 118 / 128, 12 / 128, 118 / 128, },
		TALENT_RESET_BG_COLOR = { 0.25, 0.25, 0.25, },
		TALENT_RESET_HIGHLIGHT = ARTWORK_PATH .. "arcane_circular_flash",
		TALENT_RESET_HIGHLIGHT_COORD = { 12 / 128, 118 / 128, 12 / 128, 118 / 128, },

		LOCK = ARTWORK_PATH .. "minimap_shield_elite",
		LOCK_LOCKED_COLOR = { 0.75, 0.75, 0.75, 1.0, },
		LOCK_UNLOCKED_COLOR = { 1.0, 1.0, 1.0, 1.0 },
		CLOSE = ARTWORK_PATH .. "indicator-red",
		CLOSE_COORD = { 4 / 32, 28 / 32, 3 / 32, 28 / 32, },
		RESET = ARTWORK_PATH .. "characterundelete",
		RESET_COORD = { 7 / 32, 25 / 32, 7 / 32, 25 / 32, },
		SPEC_NORMAL_COLOR = { 1.0, 1.0, 1.0, 0.5 },
		SPEC_PUSHED_COLOR = { 1.0, 1.0, 1.0, 0.25 },
		SPEC_INDICATOR_COORD = { 0.10, 0.90, 0.08, 0.92, },
		SPEC_INDICATOR_COLOR = { 0.0, 1.0, 1.0, },

		INSPECT = ARTWORK_PATH .. "pvp-banner-emblem-45",
		INSPECT_COLOR = { 0.0, 1.0, 0.0, 1.0, },
		SPELLTAB = ARTWORK_PATH .. "ui-microbutton-ej-up",
		SPELLTAB_COORD = { 3 / 32, 29 / 32, 31 / 64, 57 / 64 },
		APPLY = ARTWORK_PATH .. "readycheck-ready",
		IMPORT = ARTWORK_PATH .. "vehicle-alliancemageportal",
		IMPORT_COORD = { 5 / 32, 27 / 32, 5 / 32, 27 / 32, },
		EXPORT = ARTWORK_PATH .. "vehicle-hordemageportal",
		EXPORT_COORD = { 6 / 32, 28 / 32, 5 / 32, 27 / 32, },
		SAVE = ARTWORK_PATH .. "save",
		SEND = ARTWORK_PATH .. "ui-chaticon-share",
		EDIT_OK = "Interface\\Buttons\\ui-checkbox-check",

		CLASS = ARTWORK_PATH .. "UI-Classes-Circles",
		CLASS_HIGHLIGHT = ARTWORK_PATH .. "ui-calendar-button-glow",
		CLASS_HIGHLIGHT_COORD = { 6 / 64, 57 / 64, 6 / 64, 57 / 64, },
		CLASS_HIGHLIGHT_COLOR = { 0.0, 1.0, 0.0, 1.0, },
		CLASS_INDICATOR = ARTWORK_PATH .. "eventnotificationglow",
		CLASS_INDICATOR_COORD = { 4 / 64, 60 / 64, 5 / 64, 61 / 64, },
		CLASS_INDICATOR_COLOR = { 0.0, 1.0, 0.0, 1.0, },

		INSPECT_BUTTON = ARTWORK_PATH .. "pvp-banner-emblem-45",
		INSPECT_BUTTON_COLOR = { 0.0, 1.0, 0.0, 1.0, },

		EQUIPMENT_TEXTURE = "Interface\\Buttons\\spell-reset";
		EQUIPMENT_TEXTURE_COORD = { 6 / 64, 58 / 64, 6 / 64, 58 / 64, };
		EQUIPMENT_GLOW = "Interface\\Buttons\\UI-ActionButton-Border";
		EQUIPMENT_GLOW_COORD = { 0.25, 0.75, 0.25, 0.75, };
		EQUIPMENT_HIGHLIGHT = "Interface\\Buttons\\actionbarflyoutbutton-flyoutmidleft";
		EQUIPMENT_HIGHLIGHT_COORD = { 8 / 32, 24 / 32, 8 / 64, 24 / 64, };
		EQUIPMENT_EMPTY = {
			[0] = "Interface\\Paperdoll\\ui-paperdoll-slot-ammo",
			[1] = "Interface\\Paperdoll\\ui-paperdoll-slot-head",
			[2] = "Interface\\Paperdoll\\ui-paperdoll-slot-neck",
			[3] = "Interface\\Paperdoll\\ui-paperdoll-slot-shoulder",
			[4] = "Interface\\Paperdoll\\ui-paperdoll-slot-shirt",
			[5] = "Interface\\Paperdoll\\ui-paperdoll-slot-chest",
			[6] = "Interface\\Paperdoll\\ui-paperdoll-slot-waist",
			[7] = "Interface\\Paperdoll\\ui-paperdoll-slot-legs",
			[8] = "Interface\\Paperdoll\\ui-paperdoll-slot-feet",
			[9] = "Interface\\Paperdoll\\ui-paperdoll-slot-wrists",
			[10] = "Interface\\Paperdoll\\ui-paperdoll-slot-hands",
			[11] = "Interface\\Paperdoll\\ui-paperdoll-slot-finger",
			[12] = "Interface\\Paperdoll\\ui-paperdoll-slot-rfinger",
			[13] = "Interface\\Paperdoll\\ui-paperdoll-slot-trinket",
			[14] = "Interface\\Paperdoll\\ui-paperdoll-slot-trinket",
			[15] = "Interface\\Paperdoll\\ui-backpack-emptyslot",
			[16] = "Interface\\Paperdoll\\ui-paperdoll-slot-mainhand",
			[17] = "Interface\\Paperdoll\\ui-paperdoll-slot-secondaryhand",
			[18] = "Interface\\Paperdoll\\ui-paperdoll-slot-ranged",
			[19] = "Interface\\Paperdoll\\ui-paperdoll-slot-tabard",
		};
	};
	--------------------------------------------------
	local _talentDB = NS._talentDB;
	local _indexToClass = __rt.classList;
	local _classToIndex = __rt.classHash;
	local _classTalent = NS._classTalent;
	local _talentTabIcon = NS._talentTabIcon;
	local _BG0 = NS._BG0;
	local _BG1 = NS._BG1;
	local _preset_talent = NS._preset_talent;
	local _PRESET = {  };
	--------------------------------------------------
	local _spellDB = NS._spellDB_P;
	local _spellLevelHash = {  };
	--------------------------------------------------
	--[[
		mainFrame
					initialized		(bool)
					style			(num(identify))
					curTab			(num)
					DB				(table)
					class			(string)
					talentFrames[]	(frame table)
													id				(identify)
													talentIcons		(frame)
																					id				(identify)
																					maxVal			(fontString)
																					minVal			(fontString)
																					split			(fontString)
																					active			(bool)
																					dbIndex			(num)
													hSep			(texture)
													vSep			(texture)
													talentSet		(table)
																					total
																					totalPerTier	(num table)
																					curCheckedTier	num
																					curAvailableTopTier		num
													reqArrows		(table)
																					coordFamily		(num(identify))
													reqByArrowSet	(table-table)
													db				(table)
					specButtonsBar					curTabIndicator	(texture)
					specButtons[]	(frame table)
					level			(num)
					totalUsedPoints	(num)
					totalAvailablePoints	(num)
					data			(string)
					readOnly		(bool)
					name			(string)

		- 1---- 2--- 3-- 4-------- 5------- 6------ 7----- 8-------- 9------- 10--------- 11---------------- 12
		--tier, col, id, maxPoint, reqTier, reqCol, reqId, Spell[5], texture, icon-index, req-index[] in db, req-by-index in db
	]]
----------------------------------------------------------------------------------------------------

Mixin(NS, {
	initialized = false,
	mainFrames = { num = 0, used = 0, },
	inspectButtonKeyFunc = IsAltKeyDown,
	applyingMainFrame = false,
	playerFactionGroup = UnitFactionGroup('player'),
	playerClassUpper = UnitClassBase('player'),
	playerClassLower = strlower(UnitClassBase('player')),
	playerGUID = UnitGUID('player'),
	playerName = UnitName('player'),
	realm = GetRealmName(),
	playerFullName = UnitName('player') .. "-" .. GetRealmName(),
	POPUP_ON_RECV = {  },
	PREV_QUERY_SENT_TIME = {  },
	specializedMainFrameInspect = {  },
	queryCache = {  },	-- [GUID] = { [addon] = { data, time, }, }
	recv_msg = {  },
	custom_event_meta = {  },
	callback = {  },
	chatfilter = {  },
	DEFAULT_LEVEL = 60,
	INSPECT_WAIT_TIME = 10,
	TOOLTIP_UPDATE_DELAY = 0.02,
});
NS.playerFullName_Len = #(NS.playerFullName);

local SET, VAR = nil, nil;

local _EventHandler = CreateFrame("FRAME");
do	--	EventHandler
	local function OnEvent(self, event, ...)
		return NS[event](...);
	end
	function _EventHandler:FireEvent(event, ...)
		local func = NS[event];
		if func then
			return func(...);
		end
	end
	function _EventHandler:RegEvent(event)
		NS[event] = NS[event] or _noop_;
		self:RegisterEvent(event);
		self:SetScript("OnEvent", OnEvent);
	end
	function _EventHandler:UnregEvent(event)
		self:UnregisterEvent(event);
	end
	function _EventHandler:RegCustomEvent(event)
		local meta = NS.custom_event_meta[event];
		if meta == nil then
			meta = {  };
			NS.custom_event_meta[event] = meta;
		end
		if NS[event] == nil then
			NS[event] = function(...)
				for index = 1, #meta do
					-- pcall(meta[index], ...);
					meta[index](...);
				end
			end
		end
	end
	function _EventHandler:AddCustomEventHandler(event, handler)
		self:RegCustomEvent(event);
		local meta = NS.custom_event_meta[event];
		for index = 1, #meta do
			if meta[index] == handler then
				return;
			end
		end
		tinsert(meta, handler);
	end
	function _EventHandler:SubCustomEventHandler(event, handler)
		local meta = NS.custom_event_meta[event];
		for index = #meta, 1, -1 do
			if meta[index] == handler then
				tremove(meta, index);
			end
		end
	end
end
do	--	run_on_next_tick	--	execute two ticks later
	local min_ticker_duration = 0.1;
	if false then	--	a universal method, unnecessary here
		local DELAY = 5;
		local delay_run_funcs = {  };
		for index = 1, DELAY do
			delay_run_funcs[index] = {  };
		end
		local timer = 0.0;
		local function delay_run_handler(self, elasped)
			timer = timer + elasped;
			if timer >= min_ticker_duration * DELAY then
				timer = 0.0;
				local funcs = delay_run_funcs[1];
				while true do
					local func = tremove(funcs, 1);
					if func then
						func();
					else
						break;
					end
				end
				for index = 2, DELAY do
					if #delay_run_funcs[index] > 0 then
						tinsert(delay_run_funcs, tremove(delay_run_funcs));
						return;
					end
				end
				_EventHandler:SetScript("OnUpdate", nil);
			end
		end
		function _EventHandler:delay_run(func, delay)
			delay = delay and max(min(delay, DELAY), 1) or 1;
			local dIndex = DELAY - delay + 1;
			for index = 1, DELAY do
				if index ~= dIndex then
					local funcs = delay_run_funcs[index];
					for i = 1, #funcs do
						if func == funcs[i] then
							tremove(funcs, i);
							break;
						end
					end
				end
			end
			local funcs = delay_run_funcs[dIndex];
			for index = 1, #funcs do
				if func == funcs[index] then
					return;
				end
			end
			tinsert(funcs, func);
			_EventHandler:SetScript("OnUpdate", delay_run_handler);
		end
		function _EventHandler:frame_delay_update(frame, delay)
			_EventHandler:delay_run(frame.update_func, delay);
		end
	end
	--
	local run_on_next_tick_func_1 = {  };
	local run_on_next_tick_func_2 = {  };
	local timer = 0.0;
	local function run_on_next_tick_handler(self, elasped)
		timer = timer + elasped;
		if timer >= min_ticker_duration * 2 then
			timer = 0.0;
			while true do
				local func = tremove(run_on_next_tick_func_1, 1);
				if func then
					func();
				else
					break;
				end
			end
			if #run_on_next_tick_func_1 + #run_on_next_tick_func_2 == 0 then
				_EventHandler:SetScript("OnUpdate", nil);
			else
				run_on_next_tick_func_1, run_on_next_tick_func_2 = run_on_next_tick_func_2, run_on_next_tick_func_1;
			end
		end
	end
	function _EventHandler:run_on_next_tick(func)
		for index = 1, #run_on_next_tick_func_1 do
			if func == run_on_next_tick_func_1[index] then
				tremove(run_on_next_tick_func_1, index);
				break;
			end
		end
		for index = 1, #run_on_next_tick_func_2 do
			if func == run_on_next_tick_func_2[index] then
				return;
			end
		end
		tinsert(run_on_next_tick_func_2, func);
		_EventHandler:SetScript("OnUpdate", run_on_next_tick_handler);
	end
	function _EventHandler:frame_update_on_next_tick(frame)
		_EventHandler:run_on_next_tick(frame.update_func);
	end
end

local function Info_OnEnter(self, motion)
	if self.information then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		GameTooltip:SetText(self.information, 1.0, 1.0, 1.0);
	end
end
local function Info_OnLeave(self, motion)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end

-->		<method
	local extern = { export = {  }, import = {  }, addon = {  }, addon_list = {  }, };
	NS.extern = extern;
	do	-- extern media
		function extern.import.wowhead(url)
			--[[
				https://classic.wowhead.com/talent-calc/embed/warrior/05004-055001-55250110500001051
				https://classic.wowhead.com/talent-calc/warrior/05004-055001-55250110500001051
					"^.*classic%.wowhead%.com/talent%-calc.*/([^/]+)/(%d.+)$"
			]]
			local _, _, class, data = strfind(url, "classic%.wowhead%.com/talent%-calc.*/([^/]+)/([0-9%-]+)");
			if class and data then
				class = strupper(class);
				local DB = _talentDB[class];
				local classTalent = _classTalent[class];
				if DB and classTalent then
					--(%d*)[%-]*(%d*)[%-]*(%d*)
					local _, _, d1, d2, d3 = strfind(data, "(%d*)[%-]?(%d*)[%-]?(%d*)");
					if d1 and d2 and d3 then
						if d1 == "" and d2 == "" and d3 == "" then
							return class, "", 60;
						elseif d2 == "" and d3 == "" then
							return d1;
						else
							local l1 = #DB[classTalent[1]];
							if l1 > #d1 then
								data = d1 .. strrep("0", l1 - #d1);
							else
								data = d1;
							end
							local l2  = #DB[classTalent[2]];
							if l2 > #d2 then
								data = data .. d2 .. strrep("0", l2 - #d2) .. d3;
							else
								data = data .. d2 .. d3;
							end
							return class, data, 60;
						end
					end
				end
			end
			return nil;
		end
		function extern.import.nfu(url)
			--http://www.nfuwow.com/talents/60/warrior/tal/1331511131241111111100000000000000040000000000000000
			--		   nfuwow%.com/talents/60/([^/]+)/tal/(%d+)
			local _, _, class, data = strfind(url, "nfuwow%.com/talents/60/([^/]+)/tal/(%d+)");
			if class and data then
				class = strupper(class);
				if _talentDB[class] then
					return class, data, 60;
				end
			end
			return nil;
		end
		function extern.import.yxrank(url)
			--https://www.yxrank.com/classic/talent/warrior?count=333015011130012011111010010000000000000000000000000000000000000000000000000000000000
			local _, _, class, temp = strfind(url, "yxrank%.com/classic/talent/([a-zA-Z]+)%?count=(%d+)");
			if class and temp then
				class = strupper(class);
				local DB = _talentDB[class];
				local classTalent = _classTalent[class];
				if DB then
					local data = "";
					for i = 1, 3 do
						local db = DB[classTalent[i]];
						for j, val in ipairs(db) do
							local pos = (i - 1) * 28 + val[1] * 4 + val[2] + 1;
							local v = strsub(temp, pos, pos);
							if v == "" then
								break;
							end
							v = tonumber(v);
							if v > val[4] then
								return nil;
							end
							data = data .. v;
						end
					end
					return class, data, 60;
				end
			end
			return nil;
		end
		function extern.export.wowhead(mainFrame)
			local talentFrames = mainFrame.talentFrames;
			local DB = _talentDB[mainFrame.class];
			local classTalent = _classTalent[mainFrame.class];
			local data = "";
			for i = 3, 1, -1 do
				local talentSet = talentFrames[i].talentSet;
				local topPos = 0;
				for i = #DB[classTalent[i]], 1, -1 do
					if talentSet[i] > 0 then
						topPos = i;
						break;
					end
				end
				if topPos > 0 then
					for i = topPos, 1, -1 do
						data = talentSet[i] .. data;
					end
				end
				if i > 1 and data ~= "" then
					data = "-" .. data;
				end
			end
			local LOC = "";
			if LOCALE == "zhCN" or LOCALE == "zhTW" then
				LOC = "cn.";
			elseif LOCALE == "deDE" then
				LOC = "de.";
			elseif LOCALE == "esES" then
				LOC = "es.";
			elseif LOCALE == "frFR" then
				LOC = "fr.";
			elseif LOCALE == "itIT" then
				LOC = "it.";
			elseif LOCALE == "ptBR" then
				LOC = "pt.";
			elseif LOCALE == "ruRU" then
				LOC = "ru.";
			elseif LOCALE == "koKR" then
				LOC = "ko.";
			end
			return LOC .. "classic.wowhead.com/talent-calc/" .. strlower(mainFrame.class) .. "/" .. data;
		end
		function extern.export.nfu(mainFrame)
			local talentFrames = mainFrame.talentFrames;
			local DB = _talentDB[mainFrame.class];
			local classTalent = _classTalent[mainFrame.class];
			local data = "";
			for i = 1, 3 do
				local talentSet = talentFrames[i].talentSet;
				for i = 1, #DB[classTalent[i]] do
					data = data .. talentSet[i];
				end
			end
			return "www.nfuwow.com/talents/60/" .. strlower(mainFrame.class) .. "/tal/" .. data;
		end
		function extern.export.yxrank(mainFrame)
			local talentFrames = mainFrame.talentFrames;
			local DB = _talentDB[mainFrame.class];
			local classTalent = _classTalent[mainFrame.class];
			local ofs = 0;
			local temp = {  };
			for i = 1, 3 do
				local talentSet = talentFrames[i].talentSet;
				for j, val in ipairs(DB[classTalent[i]]) do
					temp[ofs + val[1] * 4 + val[2] + 1] = talentSet[j];
				end
				for j = 1, 28 do
					temp[ofs + j] = temp[ofs + j] or 0;
				end
				ofs = ofs + 28;
			end
			return "www.yxrank.com/classic/talent/" .. mainFrame.class .. "?count=" .. tConcat(temp);
		end
		extern.addon["D4C"] = {
			addon = "DBM",
			list = {  },
			handler = function(meta, sender, msg)
				local temp = { strsplit("\t", msg) };
				if temp[1] == "V" or temp[1] == "GV" then
					-- tremove(temp, 1);
					temp[1] = tostring(temp[4]);
					meta.list[Ambiguate(sender, 'none')] = temp;
					-- print(sender, "dbm ver", temp[4], unpack(temp));
					-- print(sender, "dbm ver", temp[3]);	--	temp[3]
					return true;
				end
			end,
		};
		extern.addon["BigWigs"] = {
			addon = "BigWigs",
			list = {  },
			handler = function(meta, sender, msg)
				local temp = { strsplit("^", msg) };
				if temp[1] == "V" then
					-- tremove(temp, 1);
					temp[1] = temp[2] .. "-" .. temp[3];
					meta.list[Ambiguate(sender, 'none')] = temp;
					-- print(sender, "bw ver", temp[1] .. "-" .. temp[2], unpack(temp));	--	temp[1] .. "-" .. temp[2]
					return true;
				end
			end,
		};
		function extern.addon_init()
			if false then
				--[[
					local CONST_DETAILS_PREFIX = "DTLS";
					local CONST_ASK_TALENTS = "AT";
					local _detalhes = { realversion = 140, };
					local msg = "^S" .. CONST_ASK_TALENTS .. UnitName('player') .. "^S" ..  GetRealmName() .. "^N" ..  _detalhes.realversion .. "^S" ..  UnitGUID ('player')
					_detalhes:SendCommMessage (CONST_DETAILS_PREFIX, msg, "WHISPER", targetName);
					>>>>
					SendAddonMessage(CONST_DETAILS_PREFIX, msg, "WHISPER", targetName);
				]]
				local CONST_DETAILS_PREFIX = "DTLS";
				local CONST_ASK_TALENTS = "AT";
				local CONST_ANSWER_TALENTS = "AWT";
				local _detalhes = { realversion = 140, };
				extern.addon[CONST_DETAILS_PREFIX] = {
					addon = "Details",
					msg = "^S" .. CONST_ASK_TALENTS .. NS.playerName .. "^S" .. NS.realm .. "^N" ..  _detalhes.realversion .. "^S" .. NS.playerGUID .. "^^",
					fmt = "^S" .. CONST_ANSWER_TALENTS .. "^S" .. NS.playerName .. "^S" .. NS.realm .. "^N" .. _detalhes.realversion .. "^S" .. NS.playerGUID .. "^N0^S(.+)^N(%d)+";
					handler = function(meta, code)
						-- "^N"
					end
				};
			end
			--
			for prefix, val in next, extern.addon do
				extern.addon_list[val.addon] = prefix;
				if not IsAddonMessagePrefixRegistered(prefix) then
					RegisterAddonMessagePrefix(prefix);
				end
			end
		end
	end

	do	-- apply talents
		function NS.UpdateApplying(applyingMainFrame)
			local mainFrames = NS.mainFrames;
			if not NS.applyingMainFrame ~= not applyingMainFrame then
				NS.applyingMainFrame = applyingMainFrame;
				if applyingMainFrame then
					for i = 1, mainFrames.num do
						local mainFrame = mainFrames[i];
						mainFrame.applyTalentsButton:Disable();
					end
				else
					for i = 1, mainFrames.num do
						local mainFrame = mainFrames[i];
						mainFrame.applyTalentsButton:Enable();
					end
				end
			end
		end
		function NS.tickerApplyTalents()
			local talentFrames = NS.applyingMainFrame.talentFrames;
			local applyingSpecIndex = NS.applyingSpecIndex;
			local talentSet = talentFrames[applyingSpecIndex].talentSet;
			for id = NS.applyingTalentIndex, #talentSet do
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(applyingSpecIndex, id);
				for k = rank + 1, talentSet[id] do
					LearnTalent(applyingSpecIndex, id);
					return;
				end
			end
			for specIndex = applyingSpecIndex, 3 do
				local talentSet = talentFrames[specIndex].talentSet;
				for id = 1, #talentSet do
					local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(specIndex, id);
					for k = rank + 1, talentSet[id] do
						LearnTalent(specIndex, id);
						return;
					end
				end
			end
			NS.applyTicker:Cancel();
			NS.UpdateApplying(nil);
		end
		function NS.processApplyTalents(mainFrame)
			NS.UpdateApplying(mainFrame);
			NS.applyingSpecIndex = 1;
			NS.applyingTalentIndex = 1;
			NS.applyTicker = C_Timer.NewTicker(0.1, NS.tickerApplyTalents);
		end
	end

	do	-- internal sub
		function NS.GetPiontsReqLevel(numPoints)
			return max(10, 9 + numPoints);
		end
		function NS.GetLevelAvailablePoints(level)
			return max(0, level - 9);
		end
		function NS.EmuCore_StatPoints(data, class)
			local DB = _talentDB[class];
			local talentRef = _classTalent[class];
			local pos = 1;
			local len = #data;
			local stat = { 0, 0, 0, };
			for specIndex = 1, 3 do
				local total = 0;
				for j = 1, #DB[talentRef[specIndex]] do
					if pos > len then
						break;
					end
					local sub = strsub(data, pos, pos);
					total = total + tonumber(sub);
					pos = pos + 1;
				end
				stat[specIndex] = total;
			end
			return stat[1], stat[2], stat[3];
		end
		function NS.EmuSub_GenerateTitle(class, stats, uncolored)
			local talentRef = _classTalent[class];
			local title = nil;
			if uncolored then
				title = L.DATA[class];
				for specIndex = 1, 3 do
					title = title .. " " .. L.DATA[talentRef[specIndex]] .. format("%2d", stats[specIndex]);
				end
			else
				local classColorTable = RAID_CLASS_COLORS[class];
				title = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. L.DATA[class] .. "\124r-";
				local emp = max(stats[1], stats[2], stats[3]);
				if emp == stats[1] and emp == stats[2] and emp == stats[3] then
					emp = emp + 1023;
				end
				for specIndex = 1, 3 do
					if emp == stats[specIndex] then
						title = title .. " \124cff7fbfff" .. L.DATA[talentRef[specIndex]] .. format("%2d\124r", stats[specIndex]);
					else
						title = title .. " " .. L.DATA[talentRef[specIndex]] .. format("%2d", stats[specIndex]);
					end
				end
			end
			return title
		end
		function NS.EmuSub_GenerateTitleFromRawData(data, class, uncolored)
			if type(data) == 'table' then	--mainFrame
				local talentFrames = data.talentFrames;
				local stats = {  };
				for specIndex = 1, 3 do
					stats[specIndex] = talentFrames[specIndex].talentSet.total;
				end
				return NS.EmuSub_GenerateTitle(data.class, stats, uncolored);
			elseif type(data) == 'string' and type(class) == 'string' and _talentDB[class] then
				local stats = { NS.EmuCore_StatPoints(data, class) };
				return NS.EmuSub_GenerateTitle(class, stats, uncolored);
			end
		end
		function NS.EmuSub_GenerateLink(GUID, title, class, code)
			local color = RAID_CLASS_COLORS[class];
			return format("\124cff%.2x%.2x%.2x", color.r * 255, color.g * 255, color.b * 255) .. "\124Hemu:" .. code .. "#" .. GUID .. "\124h[" .. title .. "]\124h\124r";
		end

		-- arg			code, useCodeLevel
		-- return		class, data, level
		function NS.EmuCore_Decoder(code, useCodeLevel)
			for media, func in next, extern.import do
				local class, data, level = func(code);
				if class then
					return class, data, level;
				end
			end
			return __rt.DecodeTalentData(code, not useCodeLevel and NS.DEFAULT_LEVEL)
		end
		-- arg			[mainFrame] or [class, data, level]
		-- return		code
		function NS.EmuCore_Encoder(class, data, level)
			if type(class) == 'table' then
				local mainFrame = class;
				local talentFrames = mainFrame.talentFrames;
				if type(talentFrames) == 'table' and
							type(talentFrames[1]) == 'table' and type(talentFrames[1].talentSet) == 'table' and
							type(talentFrames[2]) == 'table' and type(talentFrames[2].talentSet) == 'table' and
							type(talentFrames[3]) == 'table' and type(talentFrames[3].talentSet) == 'table'
					then
					--
					return __rt.EncodeTalentData(_classToIndex[mainFrame.class], mainFrame.level,
								talentFrames[1].talentSet, talentFrames[2].talentSet, talentFrames[3].talentSet,
								#talentFrames[1].db, #talentFrames[2].db, #talentFrames[3].db
							);
					--
				else
					_log_("EmuCore_Encoder", 1, 'table');
					return nil;
				end
			else
				local classIndex = nil;
				if type(class) == 'number' then
					classIndex = class;
					class = _indexToClass[class];
				elseif type(class) == 'string' then
					classIndex = _classToIndex[class];
				else
					_log_("EmuCore_Encoder", 2, type(data));
					return nil;
				end
				if type(data) == 'string' then
					local DB = _talentDB[class];
					__rt.EncodeTalentData(classIndex, (level and tonumber(level)) or NS.DEFAULT_LEVEL,
								data,
								#DB[classTalent[1]], #DB[classTalent[2]], #DB[classTalent[3]]);
				elseif type(data) == 'table' and type(data[1]) == 'table' and type(data[2]) == 'table' and type(data[3]) == 'table' then
					local DB = _talentDB[class];
					__rt.EncodeTalentData(classIndex, (level and tonumber(level)) or NS.DEFAULT_LEVEL,
								data[1], data[2], data[3],
								#DB[classTalent[1]], #DB[classTalent[2]], #DB[classTalent[3]]);
				else
					_log_("EmuCore_Encoder", 3, type(data));
					return nil;
				end
			end
		end

		function NS.EmuSub_GetIconIndex(data)
			return data[1] * MAX_NUM_COL + data[2] + 1;
		end

		function NS.EmuCore_SetName(mainFrame, name)			-- NAME CHANGED HERE ONLY	-- and NS.EmuSub_UpdateLabelText
			mainFrame.name = name;
			if name then
				local objects = mainFrame.objects;
				objects.label:SetText(name);
				local info = __rt.DecodeAddonPackData(SET.inspect_pack and NS.queryCache[name] and NS.queryCache[name].pack);
				if info then
					objects.pack_label:SetText(info);
					objects.pack_label:Show();
				else
					objects.pack_label:Hide();
				end
				objects.resetToEmu:Show();
				objects.resetToSetButton:Hide();
				local classButtons = mainFrame.classButtons;
				for index = 1, #_indexToClass do
					classButtons[index]:Hide();
				end
				objects.curClassIndicator:Hide();
				local talentFrames = mainFrame.talentFrames;
				for specIndex = 1, 3 do
					wipe(talentFrames[specIndex].talentChanged);
				end
				NS.winMan_SetSpecializedName(mainFrame, name);
			else
				local objects = mainFrame.objects;
				objects.label:SetText(L.Emu);
				objects.pack_label:Hide();
				objects.resetToEmu:Hide();
				objects.resetToSetButton:Hide();
				local classButtons = mainFrame.classButtons;
				for index = 1, #_indexToClass do
					classButtons[index]:Show();
				end
				objects.curClassIndicator:Show();
				objects.curClassIndicator:ClearAllPoints();
				objects.curClassIndicator:SetPoint("CENTER", classButtons[_classToIndex[mainFrame.class]]);
				NS.winMan_RelSpecializedName(mainFrame);
				mainFrame.equipmentFrameContainer:Hide();
			end
			mainFrame.objects.equipmentButton:Hide();
		end
		function NS.EmuCore_SetLevel(mainFrame, level)			-- LEVEL CHANGED HERE ONLY
			if level == nil then
				mainFrame.level = NS.DEFAULT_LEVEL;
				mainFrame.totalUsedPoints = 0;
				mainFrame.totalAvailablePoints = NS.GetLevelAvailablePoints(NS.DEFAULT_LEVEL);
			else
				if type(level) == 'string' then
					level = tonumber(level);
				end
				if level then
					mainFrame.level = level;
					mainFrame.totalAvailablePoints = NS.GetLevelAvailablePoints(level);
				end
			end
		end
		function NS.EmuCore_SetClass(mainFrame, class)			-- CLASS CHANGED HERE ONLY
			if class == nil then
				mainFrame.class = nil;
				mainFrame.DB = nil;
				mainFrame.initialized = false;
			else
				do	--check class value
					if type(class) == 'number' then
						if class <= #_indexToClass then
							class = _indexToClass[class];
						else
							_log_("EmuCore_SetClass", class, 2, class);
							return false;
						end
					elseif type(class) == 'table' then
						class = class.class;
						if type(class) == 'number' then
							if class <= #_indexToClass then
								class = _indexToClass[class];
							else
								_log_("EmuCore_SetClass", class, 3, class);
								return false;
							end
						elseif type(class) ~= 'string' then
							_log_("EmuCore_SetClass", type(class), 4);
							return false;
						end
					elseif type(class) == 'string' then
						local tonum = tonumber(class);
						if tonum then
							if tonum <= #_indexToClass then
								class = _indexToClass[tonum];
							else
								_log_("EmuCore_SetClass", class, 6, class);
								return false;
							end
						end
					else
						_log_("EmuCore_SetClass", type(class), 5);
						return false;
					end
				end

				class = strupper(class);
				local talentRef = _classTalent[class];
				if not talentRef then
					_log_("EmuCore_SetClass", class, 7, class);
					return false;
				end
				local DB = _talentDB[class];
				if not DB then
					_log_("EmuCore_SetClass", class, 8, class);
					return false;
				end
				local talentFrames = mainFrame.talentFrames;
				local specButtons = mainFrame.specButtons;
				for specIndex = 1, 3 do
					local talentFrame = talentFrames[specIndex];
					local talentIcons = talentFrame.talentIcons;
					local specId = talentRef[specIndex];
					local db = DB[specId];
					talentFrame.specId = specId;

					local tabTexture = _talentTabIcon[specId];
					local specButton = specButtons[specIndex];
					if tabTexture then
						specButton:SetNormalTexture(tabTexture);
						specButton:SetPushedTexture(tabTexture);
						specButton.information = L.DATA[specId];
						specButton.title:SetText(L.DATA[specId]);
					else
						specButton:SetNormalTexture(TEXTURE_SET.UNK);
						specButton:SetPushedTexture(TEXTURE_SET.UNK);
					end
					talentFrame.BG:SetTexture(_BG1[specId]);
					talentFrame.specLabel:SetText(L.DATA[specId]);
					if db then
						for dbIndex = 1, #db do
							local data = db[dbIndex];
							local icon = talentIcons[data[10]];
							icon.dbIndex = dbIndex;
							icon:Show();
							local texture = select(3,GetSpellInfo(data[8][1]));
							if texture then
								icon:SetNormalTexture(texture);
								icon:SetPushedTexture(texture);
							elseif data[9] then
								icon:SetNormalTexture(data[9]);
								icon:SetPushedTexture(data[9]);
							else
								icon:SetNormalTexture(TEXTURE_SET.UNK);
								icon:SetPushedTexture(TEXTURE_SET.UNK);
							end
							icon.maxVal:SetText(data[4]);
							icon.curVal:SetText("0");

							if data[11] then
								local arrow = NS.EmuSub_GetReqArrow(talentFrame);
								NS.EmuSub_SetReqArrow(arrow, arrow.branch, arrow.branch2, data[1] - data[5], data[2] - data[6], false, icon, talentIcons[db[data[11]][10]]);
								tinsert(talentFrame.reqByArrowSet[data[11]], arrow);
							end

							if data[1] == 0 then
								if not data[5] then
									NS.EmuSub_ActivateIcon(icon);
								end
							end
						end
						talentFrame.db = db;
					else
						_log_(class, 9, specIndex, specId);
					end
				end

				mainFrame.BG:SetTexture(_BG0[class][random(1, #_BG0[class])]);

				mainFrame.class = class;
				mainFrame.DB = DB;
				mainFrame.initialized = true;

				if NS.playerClassUpper == class then
					mainFrame.applyTalentsButton:Show();
				else
					mainFrame.applyTalentsButton:Hide();
				end

				NS.EmuSub_SpellTabUpdate(mainFrame.spellTabFrame, class, NS.GetPiontsReqLevel(mainFrame.totalUsedPoints));
			end

			return true;
		end
		function NS.EmuCore_SetData(mainFrame, data)			-- DATA CHANGED HERE ONLY	-- TODO REQUIRE TREE.
			if data == nil then
				mainFrame.data = nil;
			else
				do	--check point value
					if not mainFrame.initialized then
						_log_("EmuCore_SetData", 1, - 1);
						return false;
					end
					if type(data) ~= 'string' or data == "" then
						_log_("EmuCore_SetData", 3, type(data));
						return false;
					end
					if not tonumber(data) then
						_log_("EmuCore_SetData", 4, data);
						return false;
					end
				end

				mainFrame.data = data;
				local talentFrames = mainFrame.talentFrames;
				local pos = 1;
				local retry = {  };
				for i = 1, 3 do
					local talentFrame = talentFrames[i];
					local icons = talentFrame.talentIcons;
					local db = talentFrame.db;
					for j = 1, #db do
						local d = strsub(data, pos, pos);
						if d == "" then
							return false;
						end
						pos = pos + 1;
						d = tonumber(d);
						if d ~= 0 then
							local ret = NS.EmuCore_ChangePoint(icons[db[j][10]], d);
							if ret < 0 then
								tinsert(retry, { i, j, d, });
								_log_("EmuCore_SetData", 5, "tab", i, "tier", db[j][1], "col", db[j][2], "maxPoints", db[j][4], "set", d, data, pos);
							elseif ret > 0 then
								_log_("EmuCore_SetData", 6, "tab", i, "tier", db[j][1], "col", db[j][2], "maxPoints", db[j][4], "set", d, data, pos);
							end
						end
					end
				end
				for i, v in next, retry do
					local ret = NS.EmuCore_ChangePoint(talentFrames[v[1]].talentIcons[talentFrames[v[1]].db[v[2]][10]], tonumber(v[3]));
					if ret < 0 then
						_log_("EmuCore_SetData", 7, "tab", retry[i][1], "mainFrames", retry[i][2], "set", retry[i][3]);
					elseif ret > 0 then
						_log_("EmuCore_SetData", 8, "tab", retry[i][1], "mainFrames", retry[i][2], "set", retry[i][3]);
					end
				end
			end

			return true;
		end
		function NS.EmuCore_SetReadOnly(mainFrame, readOnly)	-- READONLY CHANGED HERE ONLY	-- DISABLED, ALWAYS FALSE
			readOnly = false;
			if mainFrame.readOnly == readOnly then
				return;
			end
			mainFrame.readOnly = readOnly;
			local objects = mainFrame.objects;
			if readOnly then
				objects.readOnlyButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.LOCK_LOCKED_COLOR[1], TEXTURE_SET.LOCK_LOCKED_COLOR[2], TEXTURE_SET.LOCK_LOCKED_COLOR[3], TEXTURE_SET.LOCK_LOCKED_COLOR[4]);
				NS.EmuSub_NoRemainingPoints(mainFrame);
			else
				objects.readOnlyButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.LOCK_UNLOCKED_COLOR[1], TEXTURE_SET.LOCK_UNLOCKED_COLOR[2], TEXTURE_SET.LOCK_UNLOCKED_COLOR[3], TEXTURE_SET.LOCK_UNLOCKED_COLOR[4]);
				if mainFrame.totalAvailablePoints > mainFrame.totalUsedPoints then
					NS.EmuSub_HasRemainingPoints(mainFrame);
				end
			end
		end
		function NS.EmuCore_SetFreeEdit(mainFrame, free_edit)	-- FREE_EDIT CHANGED HERE ONLY
			free_edit = not not free_edit;
			if mainFrame.free_edit == free_edit then
				return;
			end
			mainFrame.free_edit = free_edit;
			--	all icons processed in 'SetClass'
			--	all icons but tie 1 processed in 'ChangePoint'
			local talentFrames = mainFrame.talentFrames;
			if free_edit then
				for specIndex = 1, 3 do
					local talentFrame = talentFrames[specIndex];
					local talentIcons = talentFrame.talentIcons;
					local talentSet = talentFrame.talentSet;
					local db = talentFrame.db;
					for dbIndex = 1, #db do
						if talentSet[dbIndex] == 0 then
							local data = db[dbIndex];
							NS.EmuSub_SetIconTextColor_Unavailable(talentIcons[data[10]]);
						end
					end
				end
			else
				for specIndex = 1, 3 do
					local talentFrame = talentFrames[specIndex];
					local talentIcons = talentFrame.talentIcons;
					local db = talentFrame.db;
					for dbIndex = 1, #db do
						local data = db[dbIndex];
						if data[1] == 0 then
							if not data[5] then
								NS.EmuSub_SetIconTextColor_Available(talentIcons[data[10]]);
							end
						else
							break;
						end
					end
				end
				NS.EmuCore_ResetTalentAll(mainFrame);
			end
			local talentFrames = mainFrame.talentFrames;
		end
		function NS.EmuCore_ChangePoint(self, numPoints)		-- POINTS CHANGED HERE ONLY
			if not self.active then
				return - 1;
			end
			local talentFrame = self:GetParent();
			local mainFrame = talentFrame:GetParent();
			if mainFrame.readOnly then
				return - 1;
			end
			if numPoints == 0 then
				return 1;
			elseif numPoints > 0 then	--	caps to available points
				local remainingPoints = mainFrame.totalAvailablePoints - mainFrame.totalUsedPoints;
				if remainingPoints <= 0 then
					return 2;
				elseif remainingPoints < numPoints then
					numPoints = remainingPoints;
				end
			end

			local dbIndex = self.dbIndex;
			local db = talentFrame.db;
			local data = db[dbIndex];
			local talentSet = talentFrame.talentSet;

			if (numPoints > 0 and talentSet[dbIndex] == data[4]) or (numPoints < 0 and talentSet[dbIndex] == 0) then	-- inc max_rank OR dec min_rank
				return 2;
			end

			if self.free_edit then
				local ret = 0;

				if talentSet[dbIndex] + numPoints >= data[4] then
					if talentSet[dbIndex] + numPoints > data[4] then
						ret = 4;
					end
					numPoints = data[4] - talentSet[dbIndex];
					talentSet[dbIndex] = data[4];
					NS.EmuSub_SetIconTextColor_MaxRank(self);
					NS.EmuSub_LightIcon(self);
				elseif talentSet[dbIndex] + numPoints <= 0 then
					if talentSet[dbIndex] + numPoints < 0 then
						ret = 5;
					end
					numPoints = - talentSet[dbIndex];
					talentSet[dbIndex] = 0;
					NS.EmuSub_UnlightIcon(self);
					NS.EmuSub_SetIconTextColor_Unavailable(self);
				else
					talentSet[dbIndex] = talentSet[dbIndex] + numPoints;
					NS.EmuSub_SetIconTextColor_Available(self);
					if numPoints > 0 then
						NS.EmuSub_LightIcon(self);
						NS.EmuSub_SetIconTextColor_Available(self);
					end
				end
				self.curVal:SetText(talentSet[dbIndex]);

				return ret;
			else
				local tier = data[1];
				if numPoints < 0 then	--	whethe it can be decreased
					if data[12] then	-- dec talent required
						for i = 1, #data[12] do
							if talentSet[data[12][i]] > 0 then
								return 3;
							end
						end
					end
					if talentSet.curCheckedTier > 0 then	-- dec non-curAvailableTopTier
						for i = talentSet.curCheckedTier, tier + 1, - 1 do
							local numPointsLowerTier = 0;
							for j = i - 1, 0, - 1 do
								numPointsLowerTier = numPointsLowerTier + talentSet.totalPerTier[j];
							end
							numPoints = max(numPoints, i * NUM_POINTS_NEXT_TIER - numPointsLowerTier);
							if numPoints == 0 then
								return 3;
							end
						end
					end
				end

				local ret = 0;

				if talentSet[dbIndex] + numPoints >= data[4] then
					if talentSet[dbIndex] + numPoints > data[4] then
						ret = 4;
					end
					numPoints = data[4] - talentSet[dbIndex];
					talentSet[dbIndex] = data[4];
					NS.EmuSub_SetIconTextColor_MaxRank(self);
					NS.EmuSub_LightIcon(self);
					if data[12] then
						for i = 1, #data[12] do
							NS.EmuSub_ActivateIcon_RecheckPoint(talentFrame.talentIcons[db[data[12][i]][10]]);
						end
						local arrow = talentFrame.reqByArrowSet[dbIndex];
						for i = 1, #arrow do
							NS.EmuSub_SetReqArrowTexCoord(arrow[i], arrow[i].branch, arrow[i].branch2, arrow[i].coordFamily, true);
						end
					end
				elseif talentSet[dbIndex] + numPoints <= 0 then
					if talentSet[dbIndex] + numPoints < 0 then
						ret = 5;
					end
					numPoints = - talentSet[dbIndex];
					talentSet[dbIndex] = 0;
					NS.EmuSub_UnlightIcon(self);
					NS.EmuSub_SetIconTextColor_Available(self);
				else
					talentSet[dbIndex] = talentSet[dbIndex] + numPoints;
					NS.EmuSub_SetIconTextColor_Available(self);
					if numPoints > 0 then
						NS.EmuSub_LightIcon(self);
					end
				end
				self.curVal:SetText(talentSet[dbIndex]);

				if numPoints < 0 and data[12] then	--deactive talents that require this after dec
					for i = 1, #data[12] do
						NS.EmuSub_DeactiveIcon(talentFrame.talentIcons[db[data[12][i]][10]]);
					end
					local arrow = talentFrame.reqByArrowSet[dbIndex];
					for i = 1, #arrow do
						NS.EmuSub_SetReqArrowTexCoord(arrow[i], arrow[i].branch, arrow[i].branch2, arrow[i].coordFamily, false);
					end
				end

				-- totalPerTier			index begin from 0
				-- curAvailableTopTier	begin from 0
				-- curCheckedTier		begin from 0
				talentSet.total = talentSet.total + numPoints;
				talentFrame.curTabPoints:SetText(talentSet.total);
				talentSet.totalPerTier[data[1]] = talentSet.totalPerTier[data[1]] + numPoints;

				local curAvailableTopTier = min(floor(talentSet.total / NUM_POINTS_NEXT_TIER), MAX_NUM_TIER - 1);	--begin from 0
				if curAvailableTopTier > talentSet.curAvailableTopTier then
					NS.EmuSub_ActivateTier(talentFrame.talentIcons, curAvailableTopTier);
					talentSet.curAvailableTopTier = curAvailableTopTier;
				elseif curAvailableTopTier < talentSet.curAvailableTopTier then
					NS.EmuSub_DeactiveTier(talentFrame.talentIcons, talentSet.curAvailableTopTier);
					talentSet.curAvailableTopTier = curAvailableTopTier;
				end

				if numPoints < 0 then
					if mainFrame.totalAvailablePoints == mainFrame.totalUsedPoints then
						NS.EmuSub_HasRemainingPoints(mainFrame);
					end
					mainFrame.totalUsedPoints = mainFrame.totalUsedPoints + numPoints;
				else
					mainFrame.totalUsedPoints = mainFrame.totalUsedPoints + numPoints;
					if mainFrame.totalAvailablePoints == mainFrame.totalUsedPoints then
						NS.EmuSub_NoRemainingPoints(mainFrame);
					end
				end

				for i = curAvailableTopTier, 0, -1 do
					if talentSet.totalPerTier[i] > 0 then
						talentSet.curCheckedTier = i;
						break;
					end
				end
				-- if talentSet.totalPerTier[talentSet.curAvailableTopTier] == 0 then
				-- 	talentSet.curCheckedTier = talentSet.curAvailableTopTier - 1;
				-- else
				-- 	talentSet.curCheckedTier = talentSet.curAvailableTopTier;
				-- end

				if mainFrame.name then
					local talentChanged = talentFrame.talentChanged;
					if talentChanged[dbIndex] then
						talentChanged[dbIndex] = talentChanged[dbIndex] + numPoints;
						if talentChanged[dbIndex] == 0 then
							talentChanged[dbIndex] = nil;
						end
					else
						talentChanged[dbIndex] = numPoints;
					end
				end

				NS.EmuSub_SpellTabUpdate(mainFrame.spellTabFrame, mainFrame.class, NS.GetPiontsReqLevel(mainFrame.totalUsedPoints));

				local editBox = mainFrame.editBox;
				if editBox.type == "save" and not editBox.charChanged then
					editBox:SetText(NS.EmuSub_GenerateTitleFromRawData(mainFrame));
				end

				NS.EmuSub_UpdateLabelText(mainFrame);
				if GetMouseFocus() == self then
					NS.EmuSub_TooltipSetTalent(NS.tooltipFrame, self, talentFrame.specId, data[1] * 5, talentFrame.talentSet.total, data[8], talentSet[dbIndex], data[4])
				end

				return ret;
			end
		end
		function NS.EmuCore_Reset(mainFrame)
			local talentFrames = mainFrame.talentFrames;
			for specIndex = 1, 3 do
				local talentFrame = talentFrames[specIndex];

				local talentIcons = talentFrame.talentIcons;
				for i = 1, MAX_NUM_ICONS_PER_SPEC do
					talentIcons[i]:Hide();
					talentIcons[i].dbIndex = nil;
					NS.EmuSub_DeactiveIcon(talentIcons[i]);
				end

				local talentSet = talentFrame.talentSet;
				for i = 1, MAX_NUM_TALENTS do
					talentSet[i] = 0;
				end
				for i = 0, MAX_NUM_TIER do
					talentSet.totalPerTier[i] = 0;
				end
				talentSet.total = 0;
				talentSet.curAvailableTopTier = 0;
				talentSet.curCheckedTier = 0;

				for i = 1, MAX_NUM_ICONS_PER_SPEC do
					wipe(talentFrame.reqByArrowSet[i]);
				end

				local reqArrows = talentFrame.reqArrows;
				for i = 1, #reqArrows do
					reqArrows[i]:Hide();
					reqArrows[i].branch:Hide();
					reqArrows[i]:ClearAllPoints();
					reqArrows[i].branch:ClearAllPoints();
				end
				reqArrows.used = 0;

				talentFrame.curTabPoints:SetText("0");
			end

			NS.EmuCore_SetClass(mainFrame, nil);
			NS.EmuCore_SetLevel(mainFrame, nil);
			NS.EmuCore_SetData(mainFrame, nil);
			NS.EmuCore_SetReadOnly(mainFrame, false);
			NS.EmuCore_SetFreeEdit(mainFrame, false);
			NS.EmuCore_SetName(mainFrame, nil);

			NS.EmuSub_UpdateLabelText(mainFrame);

			mainFrame.initialized = false;
		end

		function NS.EmuSub_SetPack(name)
			if SET.inspect_pack then
				local function func(mainFrame)
					if mainFrame.name == name then
						NS.EmuCore_SetName(mainFrame, name);
					end
				end
				NS.winMan_Iterator(func);
			end
		end

		function NS.EmuCore_ResetTalentReqTree(talentFrame, dbIndex)
			local talentSet = talentFrame.talentSet;
			local db = talentFrame.db;
			if talentSet[dbIndex] > 0 then
				local req = db[dbIndex][12];
				if req then
					for index = 1, #req do
						NS.EmuCore_ResetTalentReqTree(talentFrame, req[index]);
					end
				end
				NS.EmuCore_ChangePoint(talentFrame.talentIcons[db[dbIndex][10]], - talentSet[dbIndex]);
			end
		end
		function NS.EmuCore_ResetTalentSingleTab(talentFrame)
			local db = talentFrame.db;
			for i = #db, 1, -1 do
				NS.EmuCore_ResetTalentReqTree(talentFrame, i);
			end
		end
		function NS.EmuCore_ResetTalentAll(mainFrame)
			local talentFrames = mainFrame.talentFrames;
			for specIndex = 1, 3 do
				local talentFrame = talentFrames[specIndex];
				NS.EmuCore_ResetTalentSingleTab(talentFrame);
			end
		end

		function NS.EmuSub_TooltipSetTalent(tooltipFrame, icon, specId, reqPts, pts, spellTable, curRank, maxRank)
			local fontString1h1 = tooltipFrame.fontString1h1;
			local fontString1h2 = tooltipFrame.fontString1h2;
			local tooltip1 = tooltipFrame.tooltip1;

			local fontString1f1 = tooltipFrame.fontString1f1;
			local fontString1f2 = tooltipFrame.fontString1f2;

			local fontString2h1 = tooltipFrame.fontString2h1;
			local tooltip2 = tooltipFrame.tooltip2;

			local fontString2f1 = tooltipFrame.fontString2f1;
			local fontString2f2 = tooltipFrame.fontString2f2;

			tooltipFrame.owner = icon:GetParent():GetParent();
			tooltipFrame:ClearAllPoints();
			tooltipFrame:SetPoint("BOTTOMRIGHT", icon, "TOPLEFT", -4, 4);
			tooltipFrame:Show();
			tooltipFrame:SetAlpha(0.0);
			if curRank == 0 then
				fontString1h1:Show();
				--tooltip1:Show();
				fontString1f1:Show();
				fontString1f2:Show();
				fontString2h1:Hide();
				tooltip2:Hide();
				fontString2f1:Hide();
				fontString2f2:Hide();

				fontString1h1:SetText(L.nextRank);
				if icon.active then
					fontString1h1:SetTextColor(ui_style.color_iconToolTipNextRank[1], ui_style.color_iconToolTipNextRank[2], ui_style.color_iconToolTipNextRank[3], ui_style.color_iconToolTipNextRank[4]);
					fontString1h2:Hide();
				else
					fontString1h1:SetTextColor(ui_style.color_iconToolTipNextRankDisabled[1], ui_style.color_iconToolTipNextRankDisabled[2], ui_style.color_iconToolTipNextRankDisabled[3], ui_style.color_iconToolTipNextRankDisabled[4]);
					if reqPts > pts then
						fontString1h2:SetTextColor(ui_style.color_iconToolTipNextRankDisabled[1], ui_style.color_iconToolTipNextRankDisabled[2], ui_style.color_iconToolTipNextRankDisabled[3], ui_style.color_iconToolTipNextRankDisabled[4]);
						fontString1h2:Show();
						fontString1h2:SetText(format(L.reqPoints, pts, reqPts, L.DATA[specId]));
					end
				end

				tooltip1:SetBackdrop(ui_style.tooltipBackdrop);
				tooltip1:SetOwner(tooltipFrame, "ANCHOR_NONE");
				tooltip1:SetPoint("TOPLEFT", fontString1h1, "BOTTOMLEFT", 0, 6);
				tooltip1:SetSpellByID(spellTable[1]);
				fontString1f2:SetText(tostring(spellTable[1]));
				tooltip1:SetAlpha(0.0);

				tooltipFrame.delay = NS.TOOLTIP_UPDATE_DELAY;
				tooltipFrame:SetScript("OnUpdate", function(self, elasped)
					self.delay = self.delay - elasped;
					if self.delay > 0 then
						return;
					end
					self:SetScript("OnUpdate", nil);
					local tooltip1 = self.tooltip1;
					if tooltip1:IsShown() then
						--tooltip1:Show();
						self:SetWidth(tooltip1:GetWidth() + 4);
						self:SetHeight(self.fontString1h1:GetHeight() + tooltip1:GetHeight() + self.fontString1f2:GetHeight());
						self:SetAlpha(1.0);
						tooltip1:SetAlpha(1.0);
					else
						self:Hide();
					end
				end);
			elseif curRank == maxRank then
				fontString1h1:Show();
				--tooltip1:Show();
				fontString1f1:Show();
				fontString1f2:Show();
				fontString2h1:Hide();
				tooltip2:Hide();
				fontString2f1:Hide();
				fontString2f2:Hide();

				fontString1h1:SetText(L.maxRank);
				fontString1h1:SetTextColor(ui_style.color_iconToolTipMaxRank[1], ui_style.color_iconToolTipMaxRank[2], ui_style.color_iconToolTipMaxRank[3], ui_style.color_iconToolTipMaxRank[4]);
				fontString1h2:Hide();

				tooltip1:SetBackdrop(ui_style.tooltipBackdrop);
				tooltip1:SetOwner(tooltipFrame, "ANCHOR_NONE");
				tooltip1:SetPoint("TOPLEFT", fontString1h1, "BOTTOMLEFT", 0, 6);
				tooltip1:SetSpellByID(spellTable[maxRank]);
				fontString1f2:SetText(tostring(spellTable[maxRank]));
				tooltip1:SetAlpha(0.0);

				tooltipFrame.delay = NS.TOOLTIP_UPDATE_DELAY;
				tooltipFrame:SetScript("OnUpdate", function(self, elasped)
					self.delay = self.delay - elasped;
					if self.delay > 0 then
						return;
					end
					self:SetScript("OnUpdate", nil);
					local tooltip1 = self.tooltip1;
					if tooltip1:IsShown() then
						--tooltip1:Show();
						self:SetWidth(tooltip1:GetWidth() + 4);
						self:SetHeight(self.fontString1h1:GetHeight() + tooltip1:GetHeight() + self.fontString1f2:GetHeight());
						self:SetAlpha(1.0);
						tooltip1:SetAlpha(1.0);
					else
						self:Hide();
					end
				end);
			else
				fontString1h1:Show();
				--tooltip1:Show();
				fontString1f1:Show();
				fontString1f2:Show();
				fontString2h1:Show();
				--tooltip2:Show();
				fontString2f1:Show();
				fontString2f2:Show();

				fontString1h1:SetText(L.curRank);
				fontString1h1:SetTextColor(ui_style.color_iconToolTipCurRank[1], ui_style.color_iconToolTipCurRank[2], ui_style.color_iconToolTipCurRank[3], ui_style.color_iconToolTipCurRank[4]);

				tooltip1:SetBackdrop(ui_style.tooltipBackdrop);
				tooltip1:SetOwner(tooltipFrame, "ANCHOR_NONE");
				tooltip1:SetPoint("TOPLEFT", fontString1h1, "BOTTOMLEFT", 0, 6);
				tooltip1:SetSpellByID(spellTable[curRank]);
				fontString1f2:SetText(tostring(spellTable[curRank]));
				tooltip1:SetAlpha(0.0);

				fontString2h1:SetText(L.nextRank);
				if icon.active then
					fontString2h1:SetTextColor(ui_style.color_iconToolTipNextRank[1], ui_style.color_iconToolTipNextRank[2], ui_style.color_iconToolTipNextRank[3], ui_style.color_iconToolTipNextRank[4]);
					fontString1h2:Hide();
				else
					fontString2h1:SetTextColor(ui_style.color_iconToolTipNextRankDisabled[1], ui_style.color_iconToolTipNextRankDisabled[2], ui_style.color_iconToolTipNextRankDisabled[3], ui_style.color_iconToolTipNextRankDisabled[4]);
				end

				tooltip2:SetBackdrop(ui_style.tooltipBackdrop);
				tooltip2:SetOwner(tooltipFrame, "ANCHOR_NONE");
				tooltip2:SetPoint("TOPLEFT", fontString2h1, "BOTTOMLEFT", 0, 6);
				tooltip2:SetSpellByID(spellTable[curRank + 1]);
				fontString2f2:SetText(tostring(spellTable[curRank + 1]));
				tooltip2:SetAlpha(0.0);

				tooltipFrame.delay = NS.TOOLTIP_UPDATE_DELAY;
				tooltipFrame:SetScript("OnUpdate", function(self, elasped)
					self.delay = self.delay - elasped;
					if self.delay > 0 then
						return;
					end
					self:SetScript("OnUpdate", nil);
					local tooltip1 = self.tooltip1;
					local tooltip2 = self.tooltip2;
					if tooltip1:IsShown() or tooltip2:IsShown() then
						--tooltip1:Show();
						--tooltip2:Show();
						self:SetWidth(max(tooltip1:GetWidth(), tooltip2:GetWidth()) + 2);
						self:SetHeight(self.fontString1h1:GetHeight() + tooltip1:GetHeight() + self.fontString1f1:GetHeight() + self.fontString2h1:GetHeight() + tooltip2:GetHeight() + self.fontString2f1:GetHeight() - 8);
						self:SetAlpha(1.0);
						tooltip1:SetAlpha(1.0);
						tooltip2:SetAlpha(1.0);
					else
						self:Hide();
					end
				end);
			end
		end

		function NS.EmuSub_SpellTabUpdate(spellTabFrame, class, level)
			local list = spellTabFrame.list;
			wipe(list);
			list.class = class;
			local showAll = spellTabFrame.showAllSpell:GetChecked();
			local search = spellTabFrame.searchEdit:GetText();
			if search == "" then search = nil; end
			local talentFrames = spellTabFrame.mainFrame.talentFrames;
			local S = _spellDB[class];
			for _, s in next, S do
				if not s.talent or talentFrames[s.requireSpecIndex].talentSet[s.requireIndex] > 0 then
					for i = 1, #s do
						local v = s[i];
						if not search or strfind(GetSpellInfo(v[2]), search) or strfind(tostring(v[2]), search) then
							if v[1] <= level then
								if showAll then
									tinsert(list, v);
								elseif i == #s then
									tinsert(list, v);
								end
							else
								if not showAll then
									if i > 1 then
										tinsert(list, s[i - 1]);
									end
								end
								break;
							end
						end
					end
				end
			end
			spellTabFrame.scroll:SetNumValue(#list);
			spellTabFrame.scroll:Update();
		end

		function NS.EmuSub_TalentDataRecv(name)
			local cache = NS.queryCache[name];
			if cache ~= nil then
				local readOnly = false;
				if name ~= NS.playerName then
					readOnly = true;
				end
				if NS.POPUP_ON_RECV[name] then
					local specializedMainFrame = NS.specializedMainFrameInspect[name];
					if specializedMainFrame then
						if specializedMainFrame[2]:IsShown() and specializedMainFrame[1] - GetTime() <= NS.INSPECT_WAIT_TIME then
							NS.Emu_Set(specializedMainFrame[2], cache.class, cache.data, 60, readOnly, name);
						else
							NS.Emu_Create(nil, cache.class, cache.data, 60, false, readOnly, name);
						end
					else
						NS.Emu_Create(nil, cache.class, cache.data, 60, false, readOnly, name);
					end
				end
				NS.POPUP_ON_RECV[name] = nil;
			end
		end
		function NS.EmuSub_InventoryDataRecv(name)
			if not SET.show_equipment then return; end
			local meta = NS.winMan_GetSpecializedMeta(name);
			if meta then
				for i = 2, #meta do
					meta[i].objects.equipmentButton:Show();
				end
			end
		end
	end

	do	-- communication func
		local ADDON_PREFIX = __rt.__emu_meta.ADDON_PREFIX;
		local ADDON_MSG_CONTROL_CODE_LEN = __ala_meta__.ADDON_MSG_CONTROL_CODE_LEN;
		local ADDON_MSG_QUERY_TALENTS = __rt.__emu_meta.ADDON_MSG_QUERY_TALENTS;
		local ADDON_MSG_REPLY_TALENTS = __rt.__emu_meta.ADDON_MSG_REPLY_TALENTS;
		local ADDON_MSG_PUSH = __rt.__emu_meta.ADDON_MSG_PUSH;
		local ADDON_MSG_PUSH_RECV = __rt.__emu_meta.ADDON_MSG_PUSH_RECV;
		local ADDON_MSG_PULL = __rt.__emu_meta.ADDON_MSG_PULL;
		--
		local ADDON_MSG_QUERY_EQUIPMENTS = __rt.__emu_meta.ADDON_MSG_QUERY_EQUIPMENTS;
		local ADDON_MSG_REPLY_EQUIPMENTS = __rt.__emu_meta.ADDON_MSG_REPLY_EQUIPMENTS;
		local ADDON_MSG_REPLY_ADDON_PACK = __rt.__emu_meta.ADDON_MSG_REPLY_ADDON_PACK;
		----------------
		local ADDON_MSG_QUERY_TALENTS_ = __rt.__emu_meta.ADDON_MSG_QUERY_TALENTS_;
		local ADDON_MSG_REPLY_TALENTS_ = __rt.__emu_meta.ADDON_MSG_REPLY_TALENTS_;
		--	old version compatibility
		local ADDON_MSG_QUERY_EQUIPMENTS_ = __rt.__emu_meta.ADDON_MSG_QUERY_EQUIPMENTS_;
		local ADDON_MSG_REPLY_EQUIPMENTS_ = __rt.__emu_meta.ADDON_MSG_REPLY_EQUIPMENTS_;
		local ADDON_MSG_REPLY_ADDON_PACK_ = __rt.__emu_meta.ADDON_MSG_REPLY_ADDON_PACK_;
		--------------------------------------------------
		function NS.push_recv_msg(code, sender, GUID, title, colored_title)
			for i = 1, #NS.recv_msg do
				local meta = NS.recv_msg[i];
				if meta[1] == code and (meta[2] == sender or strfind(meta[2], "\124cff%x%x%x%x%x%x" .. sender .. "\124r")) then
					return;
				end
			end
			local meta = nil;
			if #NS.recv_msg >= SET.max_recv_msg then
				meta = tremove(NS.recv_msg, 1);
			else
				meta = {  };
			end
			meta[1] = code;
			local class = select(2, GetPlayerInfoByGUID(GUID));
			if class then
				local classColorTable = RAID_CLASS_COLORS[strupper(class)];
				meta[2] = format("\124cff%.2x%.2x%.2x%s\124r", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255, sender);
			else
				meta[2] = sender;
			end
			meta[3] = title;
			meta[4] = colored_title;
			tinsert(NS.recv_msg, meta);
		end
		local _SetHyperlink = ItemRefTooltip.SetHyperlink;
		ItemRefTooltip.SetHyperlink = function(frame, ref, ...)
			local _, _, code, GUID = strfind(ref, "^emu:(.+)#(.+)");
			if code then
				local class, data, level = NS.EmuCore_Decoder(code);
				if class and data and level then
					local _, senderClass, _, _, _, n, r = GetPlayerInfoByGUID(GUID);
					local sender = (r == nil or r == "") and n or (n .. "-" .. r);
					if senderClass then
						local classColorTable = RAID_CLASS_COLORS[strupper(senderClass)];
						sender = format("\124cff%.2x%.2x%.2x%s\124r", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255, sender);
					end
					NS.Emu_Create(nil, class, data, level, false, false, L.message .. sender);
				end
				return true;
			else
				return _SetHyperlink(frame, ref, ...)
			end
		end
		local bak_ERR_CHAT_PLAYER_NOT_FOUND_S = nil;
		local pattern_ERR_CHAT_PLAYER_NOT_FOUND_S = nil;
		function NS.chatfilter.CHAT_MSG_SYSTEM(self, event, msg, ...)
			--	ERR_CHAT_PLAYER_NOT_FOUND_S
			if bak_ERR_CHAT_PLAYER_NOT_FOUND_S ~= ERR_CHAT_PLAYER_NOT_FOUND_S then
				bak_ERR_CHAT_PLAYER_NOT_FOUND_S = ERR_CHAT_PLAYER_NOT_FOUND_S;
				pattern_ERR_CHAT_PLAYER_NOT_FOUND_S = gsub(bak_ERR_CHAT_PLAYER_NOT_FOUND_S, "%%s", "(.+)");
			end
			local _, _, name = strfind(msg, pattern_ERR_CHAT_PLAYER_NOT_FOUND_S);
			if name ~= nil then
				name = Ambiguate(name, 'none');
				local t = NS.PREV_QUERY_SENT_TIME[name];
				if t ~= nil and time() - t <= 2 then
					return true, msg, ...;
				end
			end
			return false, msg, ...;
		end
		function NS.EmuCore_InitAddonMessage()
			if RegisterAddonMessagePrefix(ADDON_PREFIX) then
				_EventHandler:RegEvent("CHAT_MSG_ADDON");
				_EventHandler:RegEvent("CHAT_MSG_ADDON_LOGGED");
				_EventHandler:AddCustomEventHandler("USER_EVENT_TALENT_DATA_RECV", NS.EmuSub_TalentDataRecv);
				_EventHandler:AddCustomEventHandler("USER_EVENT_INVENTORY_DATA_RECV", NS.EmuSub_InventoryDataRecv);
				ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", NS.chatfilter.CHAT_MSG_SYSTEM)
			else
				_log_("Init", "RegisterAddonMessagePrefix", ADDON_PREFIX);
			end
		end
		local chat_frame = {  };
		for i = 1, 10 do
			chat_frame[i] = _G["ChatFrame" .. i];
		end
		local function MSG(channel, sender, msg, zoneChannelID, GUID)
			for i = 1, 10 do
				if chat_frame[i] then
					ChatFrame_MessageEventHandler(chat_frame[i], "CHAT_MSG_" .. channel, msg, sender, "", "", sender, "", zoneChannelID, 0, "", nil, 0, GUID, nil, false, false, false);
				end
			end
		end
		----------------
		function NS.EmuSub_SendMessage(channel, target, _1, _2, _3)
			local code = NS.EmuCore_Encoder(_1, _2, _3);
			if code then
				local GUID = NS.playerGUID;
				SendAddonMessage(ADDON_PREFIX, ADDON_MSG_PUSH .. code .. "#" .. GUID, channel, target);
			end
		end
		function NS.CHAT_MSG_ADDON(prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
			local name = Ambiguate(sender, 'none');
			if prefix == ADDON_PREFIX then
				local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
				--[[if control_code == ADDON_MSG_QUERY_TALENTS then			--	moved to ala/core.lua
					if channel == "INSTANCE_CHAT" then
						local target = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
						if target ~= NS.playerFullName then
							return;
						end
					end
					local code = __rt.GetEncodedPlayerTalentData(NS.DEFAULT_LEVEL);
					if code then
						if channel == "INSTANCE_CHAT" then
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY_ADDON_PACK .. __rt.GetAddonPackData(), "INSTANCE_CHAT");
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY_TALENTS .. code .. "#" .. sender, "INSTANCE_CHAT");
						else--if channel == "WHISPER" then
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY_ADDON_PACK .. __rt.GetAddonPackData(), "WHISPER", sender);
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY_TALENTS .. code, "WHISPER", sender);
						end
					end
				elseif control_code == ADDON_MSG_QUERY_EQUIPMENTS then
					if channel == "INSTANCE_CHAT" then
						local target = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
						if target ~= NS.playerFullName then
							return;
						end
					end
					local data = __rt.EncodeEquipmentData();
					for _, msg in next, data do
						if channel == "INSTANCE_CHAT" then
							SendAddonMessage(prefix, ADDON_MSG_REPLY_EQUIPMENTS .. msg .. "#" .. sender .. "-" .. NS.realm, "INSTANCE_CHAT");
						else--if channel == "WHISPER" then
							SendAddonMessage(prefix, ADDON_MSG_REPLY_EQUIPMENTS .. msg, "WHISPER", sender);
						end
					end
				else]]if control_code == ADDON_MSG_REPLY_TALENTS or control_code == ADDON_MSG_REPLY_TALENTS_ then
					local code = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
					if code and code ~= "" then
						local _1, _2 = strsplit("#", code);
						if not _2 or _2 == NS.playerName or _2 == NS.playerFullName or strsub(_2, 1, NS.playerFullName_Len) == NS.playerFullName then	-- OLDVERSION
							code = _1;
						else
							return;
						end
						local class, data, level = NS.EmuCore_Decoder(code);
						if class and data and level then
							local cache = NS.queryCache[name];
							if cache == nil then
								cache = {  };
								NS.queryCache[name] = cache;
							end
							cache.time_tal = time();
							cache.talent = _1;
							cache.class = class;
							cache.data = data;
							cache.level = level;
							_EventHandler:FireEvent("USER_EVENT_DATA_RECV", name);
							_EventHandler:FireEvent("USER_EVENT_TALENT_DATA_RECV", name);
						end
					end
				elseif control_code == ADDON_MSG_REPLY_EQUIPMENTS or control_code == ADDON_MSG_REPLY_EQUIPMENTS_ then 
					local code = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
					-- queryCache
					-- NS.specializedMainFrameInspect
					if code and code ~= "" then
						local _1, _2 = strsplit("#", code);
						if not _2 or _2 == NS.playerName or _2 == NS.playerFullName or strsub(_2, 1, NS.playerFullName_Len) == NS.playerFullName then	-- OLDVERSION
							code = _1;
						else
							return;
						end
						-- #0#item:-1#1#item:123:::::#2#item:444:::::#3#item:-1
						-- #(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)
						local cache = NS.queryCache[name];
						if cache == nil then
							cache = {  };
							NS.queryCache[name] = cache;
						end
						if __rt.DecodeEquipmentData(cache, code) then
							_EventHandler:FireEvent("USER_EVENT_DATA_RECV", name);
							_EventHandler:FireEvent("USER_EVENT_INVENTORY_DATA_RECV", name);
						end
					end
				elseif control_code == ADDON_MSG_REPLY_ADDON_PACK or control_code == ADDON_MSG_REPLY_ADDON_PACK_ then
					local cache = NS.queryCache[name];
					if cache == nil then
						cache = {  };
						NS.queryCache[name] = cache;
					end
					cache.time_pak = time();
					local code = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
					local _1, _2 = strsplit("#", code);	-- OLD VERSION
					if _2 then
						code = _1;
					end
					cache.pack = code;
					NS.EmuSub_SetPack(name);
					if SET.inspect_pack then
						-- NS.display_pack(code);
					end
					_EventHandler:FireEvent("USER_EVENT_DATA_RECV", name);
				elseif control_code == ADDON_MSG_PUSH or control_code == ADDON_MSG_PUSH_RECV then
					local body = strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
					local code, GUID = strsplit("#", body);
					if code and GUID then
						local class, data, level = NS.EmuCore_Decoder(code);
						if class and data then
							local title = NS.EmuSub_GenerateTitleFromRawData(data, class, true);
							if title then
								if control_code == ADDON_MSG_PUSH then
									MSG(channel, name, NS.EmuSub_GenerateLink(GUID, title, class, code), zoneChannelID, GUID);
									NS.push_recv_msg(code, name, GUID, title, NS.EmuSub_GenerateTitleFromRawData(data, class));
									if channel == "WHISPER" then
										SendAddonMessage(ADDON_PREFIX, ADDON_MSG_PUSH_RECV .. code .. "#" .. NS.playerGUID, "WHISPER", sender);
									end
									GetPlayerInfoByGUID(GUID);
								elseif control_code == ADDON_MSG_PUSH_RECV then
									MSG("WHISPER_INFORM", name, NS.EmuSub_GenerateLink(NS.playerGUID, title, class, code), zoneChannelID, GUID);
								end
							end
						end
					end
				elseif control_code == ADDON_MSG_PULL then
				end
			else
				local meta = extern.addon[prefix];
				if meta then
					if meta.handler(meta, name, msg) then
						_EventHandler:FireEvent("USER_EVENT_DATA_RECV", name);
					end
				end
				-- local msg = _detalhes:Serialize (CONST_ANSWER_TALENTS, NS.playerName, NS.realm, _detalhes.realversion, UnitGUID ("player"), 0, compressedTalents, Details.playerClassUppericSpec.specs)
				-- local msg = CONST_ANSWER_TALENTS .. NS.playerName .. NS.realm .. _detalhes.realversion .. UnitGUID ("player") .. 0 .. compressedTalents .. Details.playerClassUppericSpec.specs
				-- (CONST_DETAILS_PREFIX, msg, "WHISPER", targetPlayer)
			end
		end
		NS.CHAT_MSG_ADDON_LOGGED = NS.CHAT_MSG_ADDON;
		function NS.Emu_Query(name, realm, mute, force_update)
			if name then
				local n, r = strsplit("-", name);
				if r ~= nil and r ~= "" then
					name = n;
					realm = r;
				elseif realm == nil or realm == "" then
					realm = NS.realm;
				end
				local target = name .. "-" .. realm;
				if realm ~= NS.realm then
					name = name .. "-" .. realm;
				end
				NS.POPUP_ON_RECV[name] = not mute;
				local t = time();
				local counter_expired = NS.PREV_QUERY_SENT_TIME[name] == nil or (t - NS.PREV_QUERY_SENT_TIME[name] > 1);
				local update_tal = force_update or (counter_expired and (NS.queryCache[name] == nil or NS.queryCache[name].time_tal == nil or (t - (NS.queryCache[name].time_tal or (-DATA_VALIDITY))) > DATA_VALIDITY));
				local update_inv = force_update or (counter_expired and (NS.queryCache[name] == nil or NS.queryCache[name].time_inv == nil or (t - (NS.queryCache[name].time_inv or (-DATA_VALIDITY))) > DATA_VALIDITY));
				if update_tal or update_inv then
					NS.PREV_QUERY_SENT_TIME[name] = t;
					if UnitInBattleground('player') and realm ~= NS.realm then
						if update_tal then
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_TALENTS .. "#" .. target, "INSTANCE_CHAT");
						end
						if update_inv then
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_EQUIPMENTS .. "#" .. target, "INSTANCE_CHAT");
						end
					else
						if update_tal then
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_TALENTS, "WHISPER", target);
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_TALENTS_, "WHISPER", target);
						end
						if update_inv then
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_EQUIPMENTS, "WHISPER", target);
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY_EQUIPMENTS_, "WHISPER", target);
						end
					end
					for _, val in next, extern.addon do
						if UnitInBattleground('player') and realm ~= NS.realm then
						else
							if val.msg then
								SendAddonMessage(val.prefix, val.msg, "WHISPER", target);
							end
						end
					end
					if not update_tal then
						_EventHandler:FireEvent("USER_EVENT_TALENT_DATA_RECV", name);
					end
				else
					_EventHandler:FireEvent("USER_EVENT_DATA_RECV", name);
					_EventHandler:FireEvent("USER_EVENT_TALENT_DATA_RECV", name);
					_EventHandler:FireEvent("USER_EVENT_INVENTORY_DATA_RECV", name);
				end
			end
			return name;
		end
	end

	do	-- external func
		function NS.Emu_Add(self, numPoints)
			NS.EmuCore_ChangePoint(self, numPoints);
		end
		function NS.Emu_Sub(self, numPoints)
			NS.EmuCore_ChangePoint(self, - numPoints);
		end
		function NS.Emu_Set(mainFrame, class, data, level, readOnly, name, free_edit)
			NS.EmuCore_Reset(mainFrame);
			if not NS.EmuCore_SetClass(mainFrame, class) then
				mainFrame:Hide();
				return false;
			end
			if data then
				NS.EmuCore_SetData(mainFrame, data);
			end
			NS.EmuCore_SetLevel(mainFrame, level);
			NS.EmuCore_SetReadOnly(mainFrame, readOnly);
			NS.EmuCore_SetFreeEdit(mainFrame, free_edit);
			NS.EmuCore_SetName(mainFrame, name);

			return true;
		end
		function NS.EmuCore_ResetTalentAllSingleTab(mainFrame, specIndex)
			local talentFrame = mainFrame.talentFrames[specIndex];
			NS.EmuCore_ResetTalentSingleTab(talentFrame);
		end
		function NS.Emu_ResetToEmu(mainFrame)
			NS.EmuCore_SetName(mainFrame, nil);
			NS.EmuCore_SetData(mainFrame, nil);
			NS.EmuCore_SetLevel(mainFrame, NS.DEFAULT_LEVEL);
			NS.EmuCore_SetReadOnly(mainFrame, false);
		end
		function NS.Emu_ResetToSet(mainFrame)
			local class = mainFrame.class;
			local data = mainFrame.data;
			local level = mainFrame.level;
			local readOnly = mainFrame.readOnly;
			local name = mainFrame.name;
			local tab = mainFrame.curTab;
			NS.EmuCore_Reset(mainFrame);
			NS.Emu_Set(mainFrame, class, data, level, readOnly, name);
			NS.EmuSub_InventoryDataRecv(name);
		end
		function NS.Emu_ApplyTalents(mainFrame)
			if NS.playerClassUpper == mainFrame.class then
				if TalentFrame_Update then
					TalentFrame_Update();
				end
				if NS.GetPiontsReqLevel(mainFrame.totalUsedPoints) > UnitLevel('player') then
					_error_("CANNOT APPLY : NEED MORE TALENT POINTS.")
					return;
				end
				local talentFrames = mainFrame.talentFrames;
				local canApply = true;
				for specIndex = 1, 3 do
					local talentSet = talentFrames[specIndex].talentSet;
					local db = talentFrames[specIndex].db;
					for id = 1, #db do
						local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(specIndex, id);
						if rank > talentSet[id] then
							canApply = false;
							break;
						end
						local data = db[id];
						if tier ~= data[1] + 1 or column ~= data[2] + 1 or maxRank ~= data[4] then
							canApply = false;
							break;
						end
					end
					if not canApply then
						break;
					end
				end
				if canApply then
					NS.processApplyTalents(mainFrame);
				else
					_error_("CANNOT APPLY : TALENTS IN CONFLICT.");
				end
			end
		end

		function NS.Emu_DestroyMainFrameById(winId)
			return NS.winMan_RelWin(winId);
		end
		function NS.Emu_DestroyMainFrame(mainFrame)
			return NS.winMan_RelWin(mainFrame.id);
		end
		function NS.Emu_Create(mainFrame, class, data, level, free_edit, readOnly, name, style, ...)
			if SET.singleFrame then
				mainFrame = mainFrame or NS.winMan_GetWin(1);
			else
				mainFrame = mainFrame or NS.winMan_GetWin();
			end
			NS.mainFrameSetStyle(mainFrame, style or SET.style);
			mainFrame:Show();
			if SET.singleFrame then
				if class and class ~= "" then
					if not NS.Emu_Set(mainFrame, class, data, tonumber(level) or 60, readOnly, name, free_edit) then
						mainFrame:Hide();
						return nil;
					end
				end
				if not mainFrame.initialized then
					class = NS.playerClassUpper;
					if not NS.Emu_Set(mainFrame, class, nil, 60, nil, nil) then
						mainFrame:Hide();
						return nil;
					end
				end
			else
				if not class or class == "" then
					class = NS.playerClassUpper;
				end
				if not NS.Emu_Set(mainFrame, class, data, tonumber(level) or 60, readOnly, name, free_edit) then
					mainFrame:Hide();
					return nil;
				end
			end
			return mainFrame.id;
		end
		function NS.Emu_Import(mainFrame, code)
			if type(mainFrame) == 'string' then
				code = mainFrame;
				mainFrame = nil;
			end
			local class, data, level = NS.EmuCore_Decoder(code);
			if class and data and level then
				mainFrame = mainFrame or NS.winMan_GetWin();
				if not NS.Emu_Set(mainFrame, class, data, level) then
					mainFrame:Hide();
					return false;
				end
				return true;
			end
			return false;
		end
		function NS.Emu_Export(_1, _2, _3)
			if not _1 then
				return nil;
			elseif type(_1) == 'number' then
				if type(_2) == 'string' then
					return NS.EmuCore_Encoder(_1, _2, _3);
				else
					_1 = NS.winMan_GetWin(_1);
					if not _1 then
						return nil;
					end
					return NS.EmuCore_Encoder(_1, _2, _3);
				end
			else
				return NS.EmuCore_Encoder(_1, _2, _3);
			end
		end

		function NS.Emu_ChangeTab_Style2(mainFrame, tab, force_update)
			if mainFrame.style ~= 2 then
				return;
			end
			if tab <= 0 or tab > 3 then
				mainFrame.specButtonsBar.curTabIndicator:Hide();
				return;
			end
			local talentFrames = mainFrame.talentFrames;
			local specButtons = mainFrame.specButtons;
			if mainFrame.curTab ~= tab or force_update then
				talentFrames[mainFrame.curTab]:Hide();
				talentFrames[tab]:Show();
				mainFrame.curTab = tab;
				local curTabIndicator = mainFrame.specButtonsBar.curTabIndicator;
				curTabIndicator:Show();
				curTabIndicator:ClearAllPoints();
				curTabIndicator:SetPoint("CENTER", specButtons[tab]);
				-- curTabIndicator:SetScale(1.5);
				-- for i = 1, 3 do
				-- 	if i == tab then
				-- 		specButtons[i]:SetSize(ui_style.specTabButtonXSize * 1.28, ui_style.specTabButtonYSize * 1.28);
				-- 	else
				-- 		specButtons[i]:SetSize(ui_style.specTabButtonXSize * 0.86, ui_style.specTabButtonYSize * 0.86);
				-- 	end
				-- end
			end
		end
		function NS.mainFrameSetStyle(mainFrame, style)
			local talentFrames = mainFrame.talentFrames;
			if mainFrame.style ~= style then
				mainFrame.style = style;
				if style == 1 then
					talentFrames[1]:Show();
					talentFrames[2]:Show();
					talentFrames[3]:Show();
					talentFrames[2]:ClearAllPoints();
					talentFrames[2]:SetPoint("CENTER", mainFrame, "CENTER", 0, (ui_style.mainFrameFooterYSize - ui_style.mainFrameHeaderYSize) * 0.5);
					talentFrames[1]:ClearAllPoints();
					talentFrames[1]:SetPoint("TOPRIGHT", talentFrames[2], "TOPLEFT");
					talentFrames[1]:SetPoint("BOTTOMRIGHT", talentFrames[2], "BOTTOMLEFT");
					talentFrames[3]:ClearAllPoints();
					talentFrames[3]:SetPoint("TOPLEFT", talentFrames[2], "TOPRIGHT");
					talentFrames[3]:SetPoint("BOTTOMLEFT", talentFrames[2], "BOTTOMRIGHT");
					talentFrames[1].specLabel:Show();
					talentFrames[2].specLabel:Show();
					talentFrames[3].specLabel:Show();
					mainFrame.specButtonsBar:Hide();
					mainFrame:SetMinResize(ui_style.mainFrameXSizeMin_Style1, ui_style.mainFrameYSizeMin_Style1);

					local scale = (mainFrame:GetHeight() - ui_style.talentFrameYToBorder * 2) / (ui_style.talentFrameYSize + ui_style.mainFrameHeaderYSize + ui_style.mainFrameFooterYSize);
					mainFrame.talentFrameScale = scale;
					mainFrame:SetWidth(scale * ui_style.talentFrameXSizeTriple + ui_style.talentFrameXToBorder * 2);
				elseif style == 2 then
					talentFrames[1]:Hide();
					talentFrames[2]:Hide();
					talentFrames[3]:Hide();
					talentFrames[mainFrame.curTab]:Show();
					talentFrames[2]:ClearAllPoints();
					talentFrames[2]:SetPoint("CENTER", mainFrame, "CENTER", 0, (ui_style.mainFrameFooterYSize - ui_style.mainFrameHeaderYSize) * 0.5);
					talentFrames[1]:ClearAllPoints();
					talentFrames[1]:SetPoint("TOPLEFT", talentFrames[2], "TOPLEFT");
					talentFrames[1]:SetPoint("BOTTOMRIGHT", talentFrames[2], "BOTTOMRIGHT");
					talentFrames[3]:ClearAllPoints();
					talentFrames[3]:SetPoint("TOPLEFT", talentFrames[2], "TOPLEFT");
					talentFrames[3]:SetPoint("BOTTOMRIGHT", talentFrames[2], "BOTTOMRIGHT");
					talentFrames[1].specLabel:Hide();
					talentFrames[2].specLabel:Hide();
					talentFrames[3].specLabel:Hide();
					mainFrame.specButtonsBar:Show();
					NS.Emu_ChangeTab_Style2(mainFrame, mainFrame.curTab, true);
					mainFrame:SetMinResize(ui_style.mainFrameXSizeMin_Style2, ui_style.mainFrameYSizeMin_Style2);

					local scale = (mainFrame:GetHeight() - ui_style.talentFrameYToBorder * 2) / (ui_style.talentFrameYSize + ui_style.mainFrameHeaderYSize + ui_style.mainFrameFooterYSize);
					mainFrame.talentFrameScale = scale;
					mainFrame:SetWidth(scale * ui_style.talentFrameXSizeSingle + ui_style.talentFrameXToBorder * 2);
				else
					return;
				end
			end
		end

		function NS.Emu_Menu(parent, mainFrame)
			if ALADROP then
				local drop_menu_table = { handler = _noop_, elements = {  }, };
				if SET.resizable_border then
					tinsert(drop_menu_table.elements, {
							handler = function(button)
								SET.resizable_border = false;
							end,
							para = {  },
							text = L.resizable_border_FALSE,
						}
					);
				else
					tinsert(drop_menu_table.elements, {
							handler = function(button)
								SET.resizable_border = true;
							end,
							para = {  },
							text = L.resizable_border_TRUE,
						}
					);
				end
				if SET.win_style ~= 'blz' then
					tinsert(drop_menu_table.elements, {
							handler = function(button, win_style)
								SET.win_style = win_style;
								NS.winMan_SetStyle(win_style);
							end,
							para = { 'blz', },
							text = L.SetWinStyle_BLZ,
						}
					);
				elseif SET.win_style ~= 'ala' then
					tinsert(drop_menu_table.elements, {
							handler = function(button, win_style)
								SET.win_style = win_style;
								NS.winMan_SetStyle(win_style);
							end,
							para = { 'ala', },
							text = L.SetWinStyle_ALA,
						}
					);
				end
				if SET.singleFrame then
					tinsert(drop_menu_table.elements, {
							handler = function(button, singleFrame, curFrame)
								SET.singleFrame = singleFrame;
							end,
							para = { false, mainFrame, },
							text = L.SetSingleFrame_False,
						}
					);
				else
					tinsert(drop_menu_table.elements, {
							handler = function(button, singleFrame, curFrame)
								SET.singleFrame = singleFrame;
								local last = curFrame or NS.winMan_GetLastWin();
								NS.winMan_RelAllButOne(last and last.id or nil);
							end,
							para = { true, mainFrame, },
							text = L.SetSingleFrame_True,
						}
					);
				end
				if mainFrame then
					if not SET.singleFrame then
						if mainFrame.style == 1 then
							tinsert(drop_menu_table.elements, {
									handler = function(button, frame, style)
										NS.mainFrameSetStyle(frame, style);
									end,
									para = { mainFrame, 2, },
									text = L.SetStyleAllTo2_ThisWin,
								}
							);
						elseif mainFrame.style == 2 then
							tinsert(drop_menu_table.elements, {
									handler = function(button, frame, style)
										NS.mainFrameSetStyle(frame, style);
									end,
									para = { mainFrame, 1, },
									text = L.SetStyleAllTo1_ThisWin,
								}
							);
						end
					end
				end
				local allStyle = NS.winMan_IsAllSameStyle();
				if SET.style == 1 then
					tinsert(drop_menu_table.elements, {
							handler = function(button, style, alsoSetShownWin)
								SET.style = style;
								if alsoSetShownWin then
									for i = 1, NS.mainFrames.used do
										NS.mainFrameSetStyle(NS.mainFrames[i], style);
									end
								end
							end,
							para = { 2, true, },
							text = L.SetStyleAllTo2_LaterWin,
						}
					);
				elseif SET.style == 2 then
					tinsert(drop_menu_table.elements, {
							handler = function(button, style, alsoSetShownWin)
								SET.style = style;
								if alsoSetShownWin then
									for i = 1, NS.mainFrames.used do
										NS.mainFrameSetStyle(NS.mainFrames[i], style);
									end
								end
							end,
							para = { 1, true, },
							text = L.SetStyleAllTo1_LaterWin,
						}
					);
				end
				if SET.credible then
					if SET.talents_in_tip then
						tinsert(drop_menu_table.elements, {
								handler = function(button)
									SET.talents_in_tip = false;
								end,
								para = {  },
								text = L.TalentsInTip_FALSE,
							}
						);
						if SET.talents_in_tip_icon then
							tinsert(drop_menu_table.elements, {
									handler = function(button)
										SET.talents_in_tip_icon = false;
									end,
									para = {  },
									text = L.TalentsInTipIcon_FALSE,
								}
							);
						else
							tinsert(drop_menu_table.elements, {
									handler = function(button)
										SET.talents_in_tip_icon = true;
									end,
									para = {  },
									text = L.TalentsInTipIcon_TRUE,
								}
							);
						end
					else
						tinsert(drop_menu_table.elements, {
								handler = function(button)
									SET.talents_in_tip = true;
								end,
								para = {  },
								text = L.TalentsInTip_TRUE,
							}
						);
					end
				end
				if SET.inspectButtonOnUnitFrame then
					tinsert(drop_menu_table.elements, {
							handler = function()
								SET.inspectButtonOnUnitFrame = false;
							end,
							para = {  },
							text = L.inspectButtonOnUnitFrame_Disable,
						}
					);
					if SET.inspectButtonKey ~= "ALT" then
						tinsert(drop_menu_table.elements, {
								handler = function()
									SET.inspectButtonKey = "ALT";
									NS.inspectButtonKeyFunc = IsAltKeyDown;
								end,
								para = { "ALT", },
								text = L.insepctALTKEY,
							}
						);
					end
					if SET.inspectButtonKey ~= "CTRL" then
						tinsert(drop_menu_table.elements, {
								handler = function()
									SET.inspectButtonKey = "CTRL";
									NS.inspectButtonKeyFunc = IsControlKeyDown;
								end,
								para = { "CTRL", },
								text = L.insepctCTRLKEY,
							}
						);
					end
					if SET.inspectButtonKey ~= "SHIFT" then
						tinsert(drop_menu_table.elements, {
								handler = function()
									SET.inspectButtonKey = "SHIFT";
									NS.inspectButtonKeyFunc = IsShiftKeyDown;
								end,
								para =  { "SHIFT", },
								text = L.insepctSHIFTKEY,
							}
						);
					end
				else
					tinsert(drop_menu_table.elements, {
							handler = function()
								SET.inspectButtonOnUnitFrame = true;
							end,
							para = {  },
							text = L.inspectButtonOnUnitFrame_Enable,
						}
					);
				end
				ALADROP(parent, "BOTTOMLEFT", drop_menu_table);
			end
		end
	end

	do	-- objects func
		function NS.EmuSub_LightIcon(icon)
			icon:GetNormalTexture():SetVertexColor(TEXTURE_SET.ICON_LIGHT_COLOR[1], TEXTURE_SET.ICON_LIGHT_COLOR[2], TEXTURE_SET.ICON_LIGHT_COLOR[3], TEXTURE_SET.ICON_LIGHT_COLOR[4]);
			icon:GetPushedTexture():SetVertexColor(TEXTURE_SET.ICON_LIGHT_COLOR[1], TEXTURE_SET.ICON_LIGHT_COLOR[2], TEXTURE_SET.ICON_LIGHT_COLOR[3], TEXTURE_SET.ICON_LIGHT_COLOR[4]);
		end
		function NS.EmuSub_UnlightIcon(icon)
			icon:GetNormalTexture():SetVertexColor(TEXTURE_SET.ICON_UNLIGHT_COLOR[1], TEXTURE_SET.ICON_UNLIGHT_COLOR[2], TEXTURE_SET.ICON_UNLIGHT_COLOR[3], TEXTURE_SET.ICON_UNLIGHT_COLOR[4]);
			icon:GetPushedTexture():SetVertexColor(TEXTURE_SET.ICON_UNLIGHT_COLOR[1], TEXTURE_SET.ICON_UNLIGHT_COLOR[2], TEXTURE_SET.ICON_UNLIGHT_COLOR[3], TEXTURE_SET.ICON_UNLIGHT_COLOR[4]);
		end
		function NS.EmuSub_SetIconTextColor_Available(icon)
			icon.split:SetTextColor(ui_style.color_iconTextAvailable[1], ui_style.color_iconTextAvailable[2], ui_style.color_iconTextAvailable[3], ui_style.color_iconTextAvailable[4]);
			icon.maxVal:SetTextColor(ui_style.color_iconTextAvailable[1], ui_style.color_iconTextAvailable[2], ui_style.color_iconTextAvailable[3], ui_style.color_iconTextAvailable[4]);
			icon.curVal:SetTextColor(ui_style.color_iconTextAvailable[1], ui_style.color_iconTextAvailable[2], ui_style.color_iconTextAvailable[3], ui_style.color_iconTextAvailable[4]);
		end
		function NS.EmuSub_SetIconTextColor_Unavailable(icon)
			icon.split:SetTextColor(ui_style.color_iconTextDisabled[1], ui_style.color_iconTextDisabled[2], ui_style.color_iconTextDisabled[3], ui_style.color_iconTextDisabled[4]);
			icon.maxVal:SetTextColor(ui_style.color_iconTextDisabled[1], ui_style.color_iconTextDisabled[2], ui_style.color_iconTextDisabled[3], ui_style.color_iconTextDisabled[4]);
			icon.curVal:SetTextColor(ui_style.color_iconTextDisabled[1], ui_style.color_iconTextDisabled[2], ui_style.color_iconTextDisabled[3], ui_style.color_iconTextDisabled[4]);
		end
		function NS.EmuSub_SetIconTextColor_MaxRank(icon)
			icon.split:SetTextColor(ui_style.color_iconTextMaxRank[1], ui_style.color_iconTextMaxRank[2], ui_style.color_iconTextMaxRank[3], ui_style.color_iconTextMaxRank[4]);
			icon.maxVal:SetTextColor(ui_style.color_iconTextMaxRank[1], ui_style.color_iconTextMaxRank[2], ui_style.color_iconTextMaxRank[3], ui_style.color_iconTextMaxRank[4]);
			icon.curVal:SetTextColor(ui_style.color_iconTextMaxRank[1], ui_style.color_iconTextMaxRank[2], ui_style.color_iconTextMaxRank[3], ui_style.color_iconTextMaxRank[4]);
		end
		function NS.EmuSub_ActivateIcon(icon)	--icon light when points inc from 0, not after activation
			icon.active = true;
			NS.EmuSub_SetIconTextColor_Available(icon);
		end
		function NS.EmuSub_DeactiveIcon(icon)	--icon unlight certainly when deactived
			icon.active = false;
			NS.EmuSub_SetIconTextColor_Unavailable(icon);
			NS.EmuSub_UnlightIcon(icon);
		end
		function NS.EmuSub_NecessaryIcon(icon)
			icon.overlay:Show();
			icon.overlay:SetTexture(TEXTURE_SET.ICON_NECESSARY);
		end
		function NS.EmuSub_ForbiddenIcon(icon)
			icon.overlay:Show();
			icon.overlay:SetTexture(TEXTURE_SET.ICON_FORBIDDEN);
		end
		function NS.EmuSub_ActivateIcon_RecheckReq(icon)
			local dbIndex = icon.dbIndex;
			if dbIndex then
				local talentFrame = icon:GetParent();
				local db = talentFrame.db;
				local data = db[dbIndex];
				if (not data[11]) or (data[11] and talentFrame.talentSet[data[11]] == db[data[11]][4]) then
					NS.EmuSub_ActivateIcon(icon);
				end
			end
		end
		function NS.EmuSub_ActivateIcon_RecheckPoint(icon)
			local dbIndex = icon.dbIndex;
			if dbIndex > 0 then
				local talentFrame = icon:GetParent();
				local db = talentFrame.db;
				local talentSet = talentFrame.talentSet;
				local data = db[dbIndex];
				if data[1] == 0 then
					NS.EmuSub_ActivateIcon(icon);
				end
				local numPointsLowerTier = 0;
				for i = data[1] - 1, 0, - 1 do
					numPointsLowerTier = numPointsLowerTier + talentSet.totalPerTier[i];
				end
				if numPointsLowerTier >= data[1] * NUM_POINTS_NEXT_TIER then
					NS.EmuSub_ActivateIcon(icon);
				end
			end
		end
		function NS.EmuSub_ActivateTier(icons, tier)
			for i = tier * MAX_NUM_COL + 1, (tier + 1) * MAX_NUM_COL do
				NS.EmuSub_ActivateIcon_RecheckReq(icons[i]);
			end
		end
		function NS.EmuSub_DeactiveTier(icons, tier)
			for i = tier * MAX_NUM_COL + 1, (tier + 1) * MAX_NUM_COL do
				NS.EmuSub_DeactiveIcon(icons[i]);
			end
		end
		function NS.EmuSub_NoRemainingPoints(mainFrame)
			local talentFrames = mainFrame.talentFrames;
			for specIndex = 1, 3 do
				local talentFrame = talentFrames[specIndex];
				local db = talentFrame.db;
				local talentSet = talentFrame.talentSet;
				local icons = talentFrame.talentIcons;
				for i = 1, #db do
					if db[i][4] ~= talentSet[i] then
						NS.EmuSub_SetIconTextColor_Unavailable(icons[NS.EmuSub_GetIconIndex(db[i])]);
					end
				end
			end
		end
		function NS.EmuSub_HasRemainingPoints(mainFrame)
			local talentFrames = mainFrame.talentFrames;
			for specIndex = 1, 3 do
				local talentFrame = talentFrames[specIndex];
				local db = talentFrame.db;
				local talentSet = talentFrame.talentSet;
				local icons = talentFrame.talentIcons;
				for i = 1, #db do
					if db[i][4] == talentSet[i] then
						-- NS.EmuSub_SetIconTextColor_MaxRank(icons[NS.EmuSub_GetIconIndex(db[i])]);
					elseif talentSet[i] > 0 or db[i][1] == 0 then
						NS.EmuSub_SetIconTextColor_Available(icons[NS.EmuSub_GetIconIndex(db[i])]);
					else
						local data = db[i];
						local numPointsLowerTier = 0;
						for j = data[1] - 1, 0, - 1 do
							numPointsLowerTier = numPointsLowerTier + talentSet.totalPerTier[j];
						end
						if numPointsLowerTier >= data[1] * NUM_POINTS_NEXT_TIER then
							NS.EmuSub_ActivateIcon_RecheckReq(icons[NS.EmuSub_GetIconIndex(db[i])]);
						end
					end
				end
			end
		end
		function NS.EmuSub_SetReqArrowTexCoord(arrow, branch, branch2, coordFamily, enabled)
			if coordFamily == 11 then
				if enabled then
					arrow:SetTexCoord(TEXTURE_SET.ARROW_COORD[4][1], TEXTURE_SET.ARROW_COORD[4][2], TEXTURE_SET.ARROW_COORD[4][3], TEXTURE_SET.ARROW_COORD[4][4]);
					branch:SetTexCoord(TEXTURE_SET.BRANCH_COORD[4][1], TEXTURE_SET.BRANCH_COORD[4][2], TEXTURE_SET.BRANCH_COORD[4][3], TEXTURE_SET.BRANCH_COORD[4][4]);
				else
					arrow:SetTexCoord(TEXTURE_SET.ARROW_COORD[3][1], TEXTURE_SET.ARROW_COORD[3][2], TEXTURE_SET.ARROW_COORD[3][3], TEXTURE_SET.ARROW_COORD[3][4]);
					branch:SetTexCoord(TEXTURE_SET.BRANCH_COORD[3][1], TEXTURE_SET.BRANCH_COORD[3][2], TEXTURE_SET.BRANCH_COORD[3][3], TEXTURE_SET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 12 then
				if enabled then
					arrow:SetTexCoord(TEXTURE_SET.ARROW_COORD[4][2], TEXTURE_SET.ARROW_COORD[4][1], TEXTURE_SET.ARROW_COORD[4][3], TEXTURE_SET.ARROW_COORD[4][4]);
					branch:SetTexCoord(TEXTURE_SET.BRANCH_COORD[4][1], TEXTURE_SET.BRANCH_COORD[4][2], TEXTURE_SET.BRANCH_COORD[4][3], TEXTURE_SET.BRANCH_COORD[4][4]);
				else
					arrow:SetTexCoord(TEXTURE_SET.ARROW_COORD[3][2], TEXTURE_SET.ARROW_COORD[3][1], TEXTURE_SET.ARROW_COORD[3][3], TEXTURE_SET.ARROW_COORD[3][4]);
					branch:SetTexCoord(TEXTURE_SET.BRANCH_COORD[3][1], TEXTURE_SET.BRANCH_COORD[3][2], TEXTURE_SET.BRANCH_COORD[3][3], TEXTURE_SET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 21 or coordFamily == 31 then
				if enabled then
					arrow:SetTexCoord(TEXTURE_SET.ARROW_COORD[2][1], TEXTURE_SET.ARROW_COORD[2][2], TEXTURE_SET.ARROW_COORD[2][3], TEXTURE_SET.ARROW_COORD[2][4]);
					branch:SetTexCoord(TEXTURE_SET.BRANCH_COORD[2][1], TEXTURE_SET.BRANCH_COORD[2][2], TEXTURE_SET.BRANCH_COORD[2][3], TEXTURE_SET.BRANCH_COORD[2][4]);
				else
					arrow:SetTexCoord(TEXTURE_SET.ARROW_COORD[1][1], TEXTURE_SET.ARROW_COORD[1][2], TEXTURE_SET.ARROW_COORD[1][3], TEXTURE_SET.ARROW_COORD[1][4]);
					branch:SetTexCoord(TEXTURE_SET.BRANCH_COORD[1][1], TEXTURE_SET.BRANCH_COORD[1][2], TEXTURE_SET.BRANCH_COORD[1][3], TEXTURE_SET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 22 or coordFamily == 32 then
				if enabled then
					arrow:SetTexCoord(TEXTURE_SET.ARROW_COORD[2][1], TEXTURE_SET.ARROW_COORD[2][2], TEXTURE_SET.ARROW_COORD[2][3], TEXTURE_SET.ARROW_COORD[2][4]);
					branch:SetTexCoord(TEXTURE_SET.BRANCH_COORD[2][1], TEXTURE_SET.BRANCH_COORD[2][2], TEXTURE_SET.BRANCH_COORD[2][3], TEXTURE_SET.BRANCH_COORD[2][4]);
				else
					arrow:SetTexCoord(TEXTURE_SET.ARROW_COORD[1][1], TEXTURE_SET.ARROW_COORD[1][2], TEXTURE_SET.ARROW_COORD[1][3], TEXTURE_SET.ARROW_COORD[1][4]);
					branch:SetTexCoord(TEXTURE_SET.BRANCH_COORD[1][1], TEXTURE_SET.BRANCH_COORD[1][2], TEXTURE_SET.BRANCH_COORD[1][3], TEXTURE_SET.BRANCH_COORD[1][4]);
				end
			end
			if coordFamily == 31 or coordFamily == 32 then
				if enabled then
					branch2:SetTexCoord(TEXTURE_SET.BRANCH_COORD[4][1], TEXTURE_SET.BRANCH_COORD[4][2], TEXTURE_SET.BRANCH_COORD[4][3], TEXTURE_SET.BRANCH_COORD[4][4]);
				else
					branch2:SetTexCoord(TEXTURE_SET.BRANCH_COORD[3][1], TEXTURE_SET.BRANCH_COORD[3][2], TEXTURE_SET.BRANCH_COORD[3][3], TEXTURE_SET.BRANCH_COORD[3][4]);
				end
			end
		end
		function NS.EmuSub_UpdateLabelText(mainFrame)
			local objects = mainFrame.objects;
			if mainFrame.name then
				--objects.resetToEmu:Hide();
				local should_show = false;
				for specIndex = 1, 3 do
					local talentFrame = mainFrame.talentFrames[specIndex];
					local talentChanged = talentFrame.talentChanged;
					local db = talentFrame.db;
					for i = 1, #db do
						if talentChanged[i] then
							should_show = true;
							break;
						end
					end
				end
				if should_show then
					objects.resetToSetButton:Show();
					objects.label:SetText(mainFrame.name .. L.labelPointsChanged);
				else
					objects.resetToSetButton:Hide();
					objects.label:SetText(mainFrame.name);
				end
			end
			objects.curPointsUsed:SetText(mainFrame.totalUsedPoints);
			objects.curPointsReqLevel:SetText(NS.GetPiontsReqLevel(mainFrame.totalUsedPoints));
			objects.curPointsRemaining:SetText(NS.GetLevelAvailablePoints(mainFrame.level) - mainFrame.totalUsedPoints);
		end
		function NS.EmuSub_SetReqArrow(arrow, branch, branch2, verticalDist, horizontalDist, enabled, icon, reqIcon)
			local coordFamily = nil;
			if verticalDist == 0 then		--horizontal
				if horizontalDist > 0 then
					arrow:SetPoint("CENTER", icon, "LEFT", - ui_style.talentDepArrowXSize / 6, 0);
					branch:SetSize(ui_style.talentIconSize * (horizontalDist - 1) + ui_style.talentIconXGap * horizontalDist, ui_style.talentDepBranchXSize);
					branch:SetPoint("LEFT", reqIcon, "RIGHT");
					branch:SetPoint("RIGHT", arrow, "CENTER");
					coordFamily = 11;
				elseif horizontalDist < 0 then
					horizontalDist = - horizontalDist;
					arrow:SetPoint("CENTER", icon, "RIGHT", ui_style.talentDepArrowXSize / 6, 0);
					branch:SetSize(ui_style.talentIconSize * (horizontalDist - 1) + ui_style.talentIconXGap * horizontalDist, ui_style.talentDepBranchXSize);
					branch:SetPoint("RIGHT", reqIcon, "LEFT");
					branch:SetPoint("LEFT", arrow, "CENTER");
					coordFamily = 12;
				end
				branch2:Hide();
			elseif horizontalDist == 0 then	--vertical
				if verticalDist > 0 then
					arrow:SetPoint("CENTER", icon, "TOP", 0, ui_style.talentDepArrowYSize / 6);
					branch:SetSize(ui_style.talentDepBranchXSize, ui_style.talentIconSize * (verticalDist - 1) + ui_style.talentIconYGap * verticalDist);
					branch:SetPoint("TOP", reqIcon, "BOTTOM");
					branch:SetPoint("BOTTOM", arrow, "CENTER");
					coordFamily = 21;
				elseif verticalDist < 0 then
					verticalDist = - verticalDist;
					arrow:SetPoint("CENTER", icon, "BOTTOM", 0, - ui_style.talentDepArrowYSize / 6);
					branch:SetSize(ui_style.talentDepBranchXSize, ui_style.talentIconSize * (verticalDist - 1) + ui_style.talentIconYGap * verticalDist);
					branch:SetPoint("BOTTOM", reqIcon, "TOP");
					branch:SetPoint("TOP", arrow, "CENTER");
					coordFamily = 22;
				end
				branch2:Hide();
			else	--TODO
				if verticalDist > 0 then
					arrow:SetPoint("CENTER", icon, "TOP", 0, ui_style.talentDepArrowYSize / 6);
					branch:SetSize(ui_style.talentDepBranchXSize, ui_style.talentIconSize * (verticalDist - 1) + ui_style.talentIconYGap * verticalDist + ui_style.talentIconSize * 0.5);
					--branch:SetPoint("TOP", reqIcon, "CENTER");
					branch:SetPoint("BOTTOM", arrow, "CENTER");
					coordFamily = 31;
				elseif verticalDist < 0 then
					verticalDist = - verticalDist;
					arrow:SetPoint("CENTER", icon, "BOTTOM", 0, - ui_style.talentDepArrowYSize / 6);
					branch:SetSize(ui_style.talentDepBranchXSize, ui_style.talentIconSize * (verticalDist - 1) + ui_style.talentIconYGap * verticalDist + ui_style.talentIconSize * 0.5);
					--branch:SetPoint("BOTTOM", reqIcon, "CENTER");
					branch:SetPoint("TOP", arrow, "CENTER");
					coordFamily = 32;
				end
				branch2:SetSize(ui_style.talentIconSize * (horizontalDist - 1) + ui_style.talentIconXGap * horizontalDist + ui_style.talentIconSize * 0.5, ui_style.talentDepBranchXSize);
				if horizontalDist > 0 then
					branch2:SetPoint("LEFT", reqIcon, "RIGHT");
					branch2:SetPoint("RIGHT", branch, "RIGHT");
				else
					branch2:SetPoint("RIGHT", reqIcon, "LEFT");
					branch2:SetPoint("LEFT", branch, "LEFT");
				end
				branch2:Show();
			end
			arrow:Show();
			branch:Show();
			arrow.coordFamily = coordFamily;
			NS.EmuSub_SetReqArrowTexCoord(arrow, branch, branch2, coordFamily, enabled);
		end
		function NS.CreateReqArrow(talentFrame)
			local arrow = talentFrame:CreateTexture(nil, "OVERLAY");
			arrow:SetTexture(TEXTURE_SET.ARROW);
			arrow:SetSize(ui_style.talentDepArrowXSize, ui_style.talentDepArrowYSize);

			local branch = talentFrame:CreateTexture(nil, "ARTWORK");
			branch:SetTexture(TEXTURE_SET.BRANCH);

			local branch2 = talentFrame:CreateTexture(nil, "ARTWORK");
			branch2:SetTexture(TEXTURE_SET.BRANCH);
			branch2:Hide();

			arrow.branch = branch;
			arrow.branch2 = branch2;

			return arrow;
		end
		function NS.EmuSub_GetReqArrow(talentFrame)
			local reqArrows = talentFrame.reqArrows;
			reqArrows.used = reqArrows.used + 1;
			if reqArrows.used > #reqArrows then
				reqArrows[reqArrows.used] = NS.CreateReqArrow(talentFrame);
			end
			return reqArrows[reqArrows.used];
		end
	end
-->		method>

-->		<UI
	do	-- equipmentFrame
		local function slot_OnEnter(self)
			if self.link then
				GameTooltip:SetOwner(self, "ANCHOR_LEFT");
				GameTooltip:SetHyperlink(self.link);
			end
		end
		local function slot_OnLeave(self, motion)
			if GameTooltip:IsOwned(self) then
				GameTooltip:Hide();
			end
		end
		local function slot_OnClick(self)
			if IsShiftKeyDown() then
				if self.link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(self.link);
				end
			elseif IsControlKeyDown() then
				if self.link then
					DressUpItemLink(self.link);
				end
			end
		end
		function NS.Emu_ToggleEquipmentFrame(mainFrame)
			local equipmentFrameContainer = mainFrame.equipmentFrameContainer;
			if equipmentFrameContainer:IsShown() then
				equipmentFrameContainer:Hide();
			else
				equipmentFrameContainer:Show();
			end
		end
		function NS.Emu_SetEquipment(icon, slot, item)
			if item then
				local name, link, quality, _, _, _, _, _, _, texture = GetItemInfo(item);
				if link then
					link = gsub(link, "item[%-0-9:]+", item);
					icon:SetNormalTexture(texture);
					local r, g, b, code = GetItemQualityColor(quality);
					icon.glow:SetVertexColor(r, g, b);
					icon.glow:Show();
					icon.name:SetVertexColor(r, g, b);
					icon.name:SetText(name);
					icon.link = link;
				else
					icon:SetNormalTexture(TEXTURE_SET.EQUIPMENT_EMPTY[icon.slot]);
					icon.glow:Hide();
					icon.name:SetText("");
					icon.link = nil;
				end
			else
				icon:SetNormalTexture(TEXTURE_SET.EQUIPMENT_EMPTY[icon.slot]);
				icon.glow:Hide();
				icon.name:SetText("");
				icon.link = nil;
			end
		end
		function NS.Emu_SetEquipments(equipmentContainer, meta)
			local slots = equipmentContainer.slots;
			for slot = 0, 19 do
				NS.Emu_SetEquipment(slots[slot], slot, meta[slot])
			end
		end
		function NS.CreateEquipmentFrame(mainFrame)
			local wrap = CreateFrame("FRAME", nil, mainFrame);
			wrap:SetPoint("TOPRIGHT", mainFrame, "TOPLEFT", 0, 0);
			wrap:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMLEFT", 0, 0);
			wrap:SetWidth(ui_style.equipmentFrameXSize);
			if SET.win_style == 'ala' then
				wrap:SetBackdrop(ui_style.equipmentFrameBackdrop);
				wrap:SetBackdropColor(unpack(ui_style.equipmentFrameBackdropColor));
				wrap:SetBackdropBorderColor(unpack(ui_style.equipmentFrameBackdropBorderColor));
			elseif SET.win_style == 'blz' then
				wrap:SetBackdrop(ui_style.equipmentFrameBackdrop_blz);
				wrap:SetBackdropColor(unpack(ui_style.equipmentFrameBackdropColor_blz));
				wrap:SetBackdropBorderColor(unpack(ui_style.equipmentFrameBackdropBorderColor_blz));
			end
			wrap:Hide();
			local frame = CreateFrame("FRAME", nil, wrap);
			frame:SetWidth(ui_style.equipmentFrameXSize);
			frame:SetPoint("CENTER", wrap);
			frame:Show();
			local equipmentContainer = CreateFrame("FRAME", nil, frame);
			equipmentContainer:SetPoint("CENTER");
			equipmentContainer:SetSize(ui_style.equipmentFrameXSize, ui_style.equipmentContainerYSize);
			equipmentContainer:Show();
			local slots = {  };
			for slot = 0, 19 do
				local icon = CreateFrame("BUTTON", nil, equipmentContainer);
				icon:SetSize(ui_style.equipmentFrameButtonSize, ui_style.equipmentFrameButtonSize);
				icon:Show();

				icon:EnableMouse(true);
				icon:SetScript("OnEnter", slot_OnEnter);
				icon:SetScript("OnLeave", slot_OnLeave);
				icon:SetScript("OnClick", slot_OnClick);

				icon:SetNormalTexture(TEXTURE_SET.UNK);
				icon:SetHighlightTexture(TEXTURE_SET.EQUIPMENT_HIGHLIGHT);
				icon:GetHighlightTexture():SetTexCoord(TEXTURE_SET.EQUIPMENT_HIGHLIGHT_COORD[1], TEXTURE_SET.EQUIPMENT_HIGHLIGHT_COORD[2], TEXTURE_SET.EQUIPMENT_HIGHLIGHT_COORD[3], TEXTURE_SET.EQUIPMENT_HIGHLIGHT_COORD[4]);

				local glow = icon:CreateTexture(nil, "OVERLAY");
				glow:SetAllPoints();
				glow:SetTexture(TEXTURE_SET.EQUIPMENT_GLOW);
				glow:SetBlendMode("ADD");
				glow:SetTexCoord(unpack(TEXTURE_SET.EQUIPMENT_GLOW_COORD));
				glow:Show();
				icon.glow = glow;

				local name = icon:CreateFontString(nil, "OVERLAY");
				name:SetFont(GameFontNormal:GetFont(), 12);
				icon.name = name;

				icon.slot = slot;
				slots[slot] = icon;
			end
			local L = {  1,  2,  3, 15,  5, 19,  4,  9, };
			local R = { 10,  6,  7,  8, 11, 12, 13, 14, };
			local B = { 16, 17, 18,  0, };
			for i, index in next, L do
				local slot = slots[index];
				slot:SetPoint("TOPLEFT", ui_style.equipmentFrameButtonXToBorder, - ui_style.equipmentFrameButtonYToBorder - (ui_style.equipmentFrameButtonSize + ui_style.equipmentFrameButtonGap) * (i - 1));
				slot.name:SetPoint("TOPLEFT", slot, "TOPRIGHT", ui_style.equipmentFrameIconTextGap, 0);
			end
			for i, index in next, R do
				local slot = slots[index];
				slot:SetPoint("TOPRIGHT", - ui_style.equipmentFrameButtonXToBorder, - ui_style.equipmentFrameButtonYToBorder - (ui_style.equipmentFrameButtonSize + ui_style.equipmentFrameButtonGap) * (i - 1));
				slot.name:SetPoint("BOTTOMRIGHT", slot, "BOTTOMLEFT", - ui_style.equipmentFrameIconTextGap, 0);
			end
			for i, index in next, B do
				local slot = slots[index];
				slot:SetPoint("BOTTOM",
					((i - 1) % 2 - 0.5) * (ui_style.equipmentFrameButtonSize + ui_style.equipmentFrameButtonGap),
					(2 - floor((i - 1) / 2)) * (ui_style.equipmentFrameButtonSize + ui_style.equipmentFrameButtonGap) - ui_style.equipmentFrameButtonGap);
				if (i - 1) % 2 == 0 then
					slot.name:SetPoint("RIGHT", slot, "LEFT", - ui_style.equipmentFrameIconTextGap, 0);
				else
					slot.name:SetPoint("LEFT", slot, "RIGHT", ui_style.equipmentFrameIconTextGap, 0);
				end
			end
			frame.equipmentContainer = equipmentContainer;
			equipmentContainer.slots = slots;
			frame:SetScript("OnShow", function(self)
				NS.Emu_SetEquipments(equipmentContainer, NS.queryCache[mainFrame.name]);
			end);
			frame.mainFrame = mainFrame;
			wrap.mainFrame = mainFrame;
			return frame, equipmentContainer, wrap;
		end
	end

	do	-- spellTabFrame
		local function spellTabButton_OnEnter(self)
			local index = self:GetDataIndex();
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			local data = self.list[index];
			GameTooltip:SetSpellByID(data[2]);
			GameTooltip:Show();
			C_Timer.After(0.1, function()
				if select(2, GameTooltip:GetSpell()) ~= data[2] then
					return;
				end
				if data[5] and data[1] > 0 then
					GameTooltip:AddDoubleLine(L.spellTabGTTSpellLevel .. data[5], L.spellTabGTTReqLevel .. data[1], 1.0, 0.75, 0.5, 1.0, 0.75, 0.5);
				elseif data[5] then
					GameTooltip:AddLine(L.spellTabGTTSpellLevel .. data[5], 1.0, 0.75, 0.5);
				elseif data[1] > 0 then
					GameTooltip:AddLine(L.spellTabGTTReqLevel .. data[1], 1.0, 0.75, 0.5);
				end
				if NS.playerClassUpper == self.list.class then
					if not data[6] then
						if FindSpellBookSlotBySpellID(data[2]) then
							GameTooltip:AddLine(L.spellAvailable);
						else
							GameTooltip:AddLine(L.spellNotAvailable);
						end
					end
				end
				if data.race then
					GameTooltip:AddLine(L.RACE .. ": " .. L[data.race], 1.0, 0.5, 0.25);
				end
				GameTooltip:Show();
			end);
		end
		local function spellTabButton_OnLeave(self)
			if GameTooltip:IsOwned(self) then
				GameTooltip:Hide();
			end
		end
		local function spellTabButton_OnClick(self)
			if IsShiftKeyDown() then
				local index = self:GetDataIndex();
				local data = self.list[index];
				local link = _GetSpellLink(data[2]);
				if link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(link);
				end
			end
			self.searchEdit:ClearFocus();
		end
		local function spellTabButton_OnDragStart(self)
			self:StopMovingOrSizing();
			local index = self:GetDataIndex();
			local data = self.list[index];
			if not data[6] and FindSpellBookSlotBySpellID(data[2]) then
				PickupSpell(data[2]);
			end
		end
		function NS.Emu_ToggleSpellTab(mainFrame)
			local spellTabFrame, spellTabFrameContainer = mainFrame.spellTabFrame, mainFrame.spellTabFrameContainer;
			local side_anchor_up = mainFrame.side_anchor_up;
			local side_anchor_down = mainFrame.side_anchor_down;
			if spellTabFrameContainer:IsShown() then
				spellTabFrameContainer:Hide();
				side_anchor_up:ClearAllPoints();
				side_anchor_up:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 2, 0);
				side_anchor_up:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMRIGHT", 2, 0);
				side_anchor_down:ClearAllPoints();
				side_anchor_down:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 2, 0);
				side_anchor_down:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMRIGHT", 2, 0);
			else
				spellTabFrameContainer:Show();
				NS.EmuSub_SpellTabUpdate(spellTabFrame, mainFrame.class, NS.GetPiontsReqLevel(mainFrame.totalUsedPoints));
				side_anchor_up:ClearAllPoints();
				side_anchor_up:SetPoint("TOPLEFT", spellTabFrameContainer, "TOPRIGHT", 2, 0);
				side_anchor_up:SetPoint("BOTTOMLEFT", spellTabFrameContainer, "BOTTOMRIGHT", 2, 0);
				side_anchor_down:ClearAllPoints();
				side_anchor_down:SetPoint("TOPLEFT", spellTabFrameContainer, "TOPRIGHT", 2, 0);
				side_anchor_down:SetPoint("BOTTOMLEFT", spellTabFrameContainer, "BOTTOMRIGHT", 2, 0);
			end
		end
		local function funcToCreateButton(parent, index, buttonHeight)
			local button = CreateFrame("BUTTON", nil, parent);
			button:SetHeight(buttonHeight);
			button:SetBackdrop(ui_style.spellTabFrameButtonBackdrop);
			button:SetBackdropColor(unpack(ui_style.spellTabFrameButtonBackdropColor));
			button:SetBackdropBorderColor(unpack(ui_style.spellTabFrameButtonBackdropBorderColor));
			button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
			button:EnableMouse(true);
			button:Show();

			local icon = button:CreateTexture(nil, "OVERLAY");
			icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
			icon:SetSize(buttonHeight - 4, buttonHeight - 4);
			icon:SetPoint("LEFT", 4, 0);
			button.icon = icon;

			local title = button:CreateFontString(nil, "OVERLAY");
			title:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
			title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
			button.title = title;

			button:SetScript("OnEnter", spellTabButton_OnEnter);
			button:SetScript("OnLeave", spellTabButton_OnLeave);
			button:SetScript("OnClick", spellTabButton_OnClick);
			button:RegisterForDrag("LeftButton");
			button:SetScript("OnDragStart", spellTabButton_OnDragStart);

			button.list = parent:GetParent():GetParent().list;
			button.searchEdit = parent:GetParent():GetParent().searchEdit;

			return button;
		end
		local function functToSetButton(button, data_index)		local list = button.list;
			if data_index <= #list then
				local name, _, texture = GetSpellInfo(list[data_index][2]);
				button.icon:SetTexture(texture);
				button.title:SetText(name);
				button:Show();
				if GetMouseFocus() == button then
					spellTabButton_OnEnter(button);
				end
			else
				button:Hide();
			end
		end
		function NS.CreateSpellTabFrame(mainFrame)
			local wrap = CreateFrame("FRAME", nil, mainFrame);
			wrap:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 0, 0);
			wrap:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMRIGHT", 0, 0);
			wrap:SetWidth(ui_style.spellTabFrameXSize);
			if SET.win_style == 'ala' then
				wrap:SetBackdrop(ui_style.spellTabFrameBackdrop);
				wrap:SetBackdropColor(unpack(ui_style.spellTabFrameBackdropColor));
				wrap:SetBackdropBorderColor(unpack(ui_style.spellTabFrameBackdropBorderColor));
			elseif SET.win_style == 'blz' then
				wrap:SetBackdrop(ui_style.spellTabFrameBackdrop_blz);
				wrap:SetBackdropColor(unpack(ui_style.spellTabFrameBackdropColor_blz));
				wrap:SetBackdropBorderColor(unpack(ui_style.spellTabFrameBackdropBorderColor_blz));
			end
			wrap:Hide();
			local frame = CreateFrame("FRAME", nil, wrap);	-- mainFrame:GetName() .. "SpellTab"
			frame:SetPoint("CENTER", wrap);
			frame:SetWidth(ui_style.spellTabFrameXSize);
			frame:Show();
			frame.list = {  };
			local scroll = ALASCR(frame, nil, nil, ui_style.spellTabFrameButtonHeight, funcToCreateButton, functToSetButton);
			scroll:SetPoint("BOTTOMLEFT", ui_style.spellTabFrameXToBorder, ui_style.spellTabFrameYToTop);
			scroll:SetPoint("TOPRIGHT", - ui_style.spellTabFrameXToBorder, - ui_style.spellTabFrameYToBottom);
			frame.scroll = scroll;

			local searchEdit = CreateFrame("EDITBOX", nil, frame);
			searchEdit:SetSize(ui_style.spellTabFrameXSize - 2 * ui_style.spellTabFrameXToBorder - 36, 16);
			searchEdit:SetFont(GameFontHighlight:GetFont(), 10, "OUTLINE");
			searchEdit:SetAutoFocus(false);
			searchEdit:SetJustifyH("LEFT");
			searchEdit:Show();
			searchEdit:EnableMouse(true);
			searchEdit:SetPoint("TOPLEFT", frame, ui_style.spellTabFrameXToBorder, - 6);
			local searchEditTexture = searchEdit:CreateTexture(nil, "ARTWORK");
			searchEditTexture:SetPoint("TOPLEFT");
			searchEditTexture:SetPoint("BOTTOMRIGHT");
			searchEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
			searchEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
			searchEditTexture:SetAlpha(0.75);
			searchEditTexture:SetBlendMode("ADD");
			searchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
			local searchEditNote = searchEdit:CreateFontString(nil, "OVERLAY");
			searchEditNote:SetFont(GameFontNormal:GetFont(), 12);
			searchEditNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
			searchEditNote:SetPoint("LEFT", 4, 0);
			searchEditNote:SetText(L.Search);
			searchEditNote:Show();
			local searchCancel = CreateFrame("BUTTON", nil, searchEdit);
			searchCancel:SetSize(16, 16);
			searchCancel:SetPoint("RIGHT", searchEdit);
			searchCancel:SetScript("OnClick", function(self) searchEdit:SetText(""); searchEdit:ClearFocus(); end);
			searchCancel:Hide();
			searchCancel:SetNormalTexture("interface\\petbattles\\deadpeticon")
			local searchEditOK = CreateFrame("BUTTON", nil, frame);
			searchEditOK:SetSize(32, 16);
			searchEditOK:SetPoint("LEFT", searchEdit, "RIGHT", 4, 0);
			searchEditOK:SetScript("OnClick", function(self) searchEdit:ClearFocus(); end);
			searchEditOK:Disable();
			local searchEditOKTexture = searchEditOK:CreateTexture(nil, "ARTWORK");
			searchEditOKTexture:SetPoint("TOPLEFT");
			searchEditOKTexture:SetPoint("BOTTOMRIGHT");
			searchEditOKTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
			searchEditOKTexture:SetAlpha(0.75);
			searchEditOKTexture:SetBlendMode("ADD");
			local searchEditOKText = searchEditOK:CreateFontString(nil, "OVERLAY");
			searchEditOKText:SetFont(GameFontHighlight:GetFont(), 12);
			searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5);
			searchEditOKText:SetPoint("CENTER");
			searchEditOKText:SetText(L["OK"]);
			searchEditOK:SetFontString(searchEditOKText);
			searchEditOK:SetPushedTextOffset(1, - 1);
			searchEditOK:SetScript("OnEnable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 1.0); end);
			searchEditOK:SetScript("OnDisable", function(self) searchEditOKText:SetTextColor(1.0, 1.0, 1.0, 0.5); end);
			searchEdit:SetScript("OnEnterPressed", function(self) self:ClearFocus(); end);
			searchEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus(); end);
			searchEdit:SetScript("OnTextChanged", function(self, isUserInput)
				NS.EmuSub_SpellTabUpdate(frame, mainFrame.class, NS.GetPiontsReqLevel(mainFrame.totalUsedPoints));
				if not searchEdit:HasFocus() and searchEdit:GetText() == "" then
					searchEditNote:Show();
				end
				if searchEdit:GetText() == "" then
					searchCancel:Hide();
				else
					searchCancel:Show();
				end
			end);
			searchEdit:SetScript("OnEditFocusGained", function(self)
				searchEditNote:Hide();
				searchEditOK:Enable();
			end);
			searchEdit:SetScript("OnEditFocusLost", function(self)
				if searchEdit:GetText() == "" then searchEditNote:Show(); end
				searchEditOK:Disable();
			end);
			searchEdit:ClearFocus();
			frame.searchEdit = searchEdit;
			frame.searchEditOK = searchEditOK;

			local showAllSpell = CreateFrame("CHECKBUTTON", nil, frame, "OptionsBaseCheckButtonTemplate");
			showAllSpell:SetSize(16, 16);
			showAllSpell:SetHitRectInsets(0, 0, 0, 0);
			showAllSpell:ClearAllPoints();
			showAllSpell:Show();
			showAllSpell:SetChecked(false);
			showAllSpell:SetPoint("BOTTOMRIGHT", - ui_style.spellTabFrameXToBorder, 6);
			showAllSpell:SetScript("OnClick", function(self)
				NS.EmuSub_SpellTabUpdate(frame, mainFrame.class, NS.GetPiontsReqLevel(mainFrame.totalUsedPoints));
			end);
			frame.showAllSpell = showAllSpell;

			local showAllSpellFontString = frame:CreateFontString(nil, "ARTWORK");
			showAllSpellFontString:SetFont(GameFontHighlight:GetFont(), 10, ui_style.frameFontOutline);
			showAllSpellFontString:SetText(L.showAllSpell);
			showAllSpell.fontString = showAllSpellFontString;
			showAllSpellFontString:SetPoint("RIGHT", showAllSpell, "LEFT", 0, 0);

			local close = CreateFrame("BUTTON", nil, frame);
			close:SetSize(32, 16);
			close:SetPoint("BOTTOMLEFT", 4, 6);
			close:SetScript("OnClick", function(self) NS.Emu_ToggleSpellTab(mainFrame); end);
			local closeTexture = close:CreateTexture(nil, "ARTWORK");
			closeTexture:SetPoint("TOPLEFT");
			closeTexture:SetPoint("BOTTOMRIGHT");
			closeTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
			closeTexture:SetAlpha(0.75);
			closeTexture:SetBlendMode("ADD");
			local closeText = close:CreateFontString(nil, "OVERLAY");
			closeText:SetFont(GameFontHighlight:GetFont(), 12);
			closeText:SetTextColor(1.0, 1.0, 1.0, 0.5);
			closeText:SetPoint("CENTER");
			closeText:SetText(L["Hide"]);
			close:SetFontString(closeText);
			close:SetPushedTextOffset(1, - 1);

			frame.mainFrame = mainFrame;
			wrap.mainFrame = mainFrame;
			return frame, wrap;
		end
	end

	do	-- tooltipFrame
		function NS.Emu_SetTooltip(icon)
			local talentFrame = icon:GetParent();
			local dbIndex = icon.dbIndex;
			local data = talentFrame.db[dbIndex];
			NS.EmuSub_TooltipSetTalent(NS.tooltipFrame, icon, talentFrame.specId, data[1] * 5, talentFrame.talentSet.total, data[8], talentFrame.talentSet[dbIndex], data[4]);
		end
		function NS.Emu_TooltipHide(icon)
			local tooltipFrame = NS.tooltipFrame;
			tooltipFrame:Hide();
			tooltipFrame.tooltip1:Hide();
			tooltipFrame.tooltip2:Hide();
		end
		function NS.CreateTooltipFrame()
			local tooltipFrame = CreateFrame("FRAME", nil, UIParent);
			tooltipFrame:SetSize(1, 1);
			tooltipFrame:SetFrameStrata("FULLSCREEN");
			tooltipFrame:SetClampedToScreen(true);
			tooltipFrame:EnableMouse(false);
			tooltipFrame:SetBackdrop(ui_style.tooltipFrameBackdrop);
			tooltipFrame:SetBackdropColor(ui_style.tooltipFrameBackdropColor[1], ui_style.tooltipFrameBackdropColor[2], ui_style.tooltipFrameBackdropColor[3], ui_style.tooltipFrameBackdropColor[4]);
			tooltipFrame:Hide();
			tooltipFrame:Show();

			local fontString1h1 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			fontString1h1:SetPoint("TOPLEFT", 6, -6);
			local fontString1h2 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			fontString1h2:SetPoint("TOPRIGHT", -6, -6);
			local tooltip1 = CreateFrame("GAMETOOLTIP", "emu_tooltip1" .. (time() + 1) .. random(1000000, 10000000), UIParent, "GameTooltipTemplate");
			tooltip1:SetPoint("TOPLEFT", fontString1h1, "BOTTOMLEFT", 0, 6);

			local fontString1f1 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			fontString1f1:SetPoint("TOPLEFT", tooltip1, "BOTTOMLEFT", 12, 6);
			local fontString1f2 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			fontString1f2:SetPoint("TOPRIGHT", tooltip1, "BOTTOMRIGHT", - 12, 6);

			local fontString2h1 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			fontString2h1:SetPoint("TOPLEFT", fontString1f1, "BOTTOMLEFT", -12, -4);
			local tooltip2 = CreateFrame("GAMETOOLTIP", "emu_tooltip2" .. (time() + 100) .. random(1000000, 10000000), UIParent, "GameTooltipTemplate");
			tooltip2:SetPoint("TOPLEFT", fontString2h1, "BOTTOMLEFT", 0, 6);

			local fontString2f1 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			fontString2f1:SetPoint("TOPLEFT", tooltip2, "BOTTOMLEFT", 12, 6);
			local fontString2f2 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			fontString2f2:SetPoint("TOPRIGHT", tooltip2, "BOTTOMRIGHT", - 12, 6);

			fontString1h1:SetText("")
			fontString1h2:SetText("")
			fontString2h1:SetText("")

			fontString1f1:SetTextColor(0.25, 0.5, 1.0, 1.0);
			fontString1f2:SetTextColor(0.25, 0.5, 1.0, 1.0);
			fontString2f1:SetTextColor(0.25, 0.5, 1.0, 1.0);
			fontString2f2:SetTextColor(0.25, 0.5, 1.0, 1.0);

			fontString1f1:SetText("id");
			fontString2f1:SetText("id");
			fontString1f2:SetText("");
			fontString2f2:SetText("");

			tooltipFrame.fontString1h1 = fontString1h1;
			tooltipFrame.fontString1h2 = fontString1h2;
			tooltipFrame.tooltip1 = tooltip1;

			tooltipFrame.fontString1f1 = fontString1f1;
			tooltipFrame.fontString1f2 = fontString1f2;

			tooltipFrame.fontString2h1 = fontString2h1;
			tooltipFrame.tooltip2 = tooltip2;

			tooltipFrame.fontString2f1 = fontString2f1;
			tooltipFrame.fontString2f2 = fontString2f2;

			return tooltipFrame;
		end
	end

	do	-- talentFrame
		local function talentIcon_OnEnter(self)
			NS.Emu_SetTooltip(self);
		end
		local function talentIcon_OnLeave(self)
			NS.Emu_TooltipHide(self);
		end
		local function talentIcon_OnClick(self, button)
			if IsShiftKeyDown() then
				local talentFrame = self:GetParent();
				local mainFrame = talentFrame:GetParent();
				local db = talentFrame.db;
				local talentSet = talentFrame.talentSet;
				local dbIndex = self.dbIndex;
				local link = _GetSpellLink(db[dbIndex][8][talentSet[dbIndex] == 0 and 1 or talentSet[dbIndex]]);
				if link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(link);
				end
			else
				if not self.active then
					return;
				end
				if button == "LeftButton" then
					NS.Emu_Add(self, 1);
				elseif button == "RightButton" then
					NS.Emu_Sub(self, 1);
				end
			end
		end
		function NS.CreateTalentIcon(talentFrame, id)
			local icon = CreateFrame("BUTTON", nil, talentFrame);	-- talentFrame:GetName() .. "TalentIcon" .. id
			icon:SetSize(ui_style.talentIconSize, ui_style.talentIconSize);

			icon:Hide();
			icon:EnableMouse(true);
			icon:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			icon:SetScript("OnClick", talentIcon_OnClick);
			icon:SetScript("OnEnter", talentIcon_OnEnter);
			icon:SetScript("OnLeave", talentIcon_OnLeave);

			--icon:SetBackdrop(ui_style.iconBackdrop);
			--icon:SetBackdropColor(ui_style.iconBackdropColor[1], ui_style.iconBackdropColor[2], ui_style.iconBackdropColor[3], ui_style.iconBackdropColor[4]);
			--icon:SetBackdropBorderColor(ui_style.iconBackdropBorderColor[1], ui_style.iconBackdropBorderColor[2], ui_style.iconBackdropBorderColor[3], ui_style.iconBackdropBorderColor[4]);
			icon:SetNormalTexture(TEXTURE_SET.UNK);
			icon:SetPushedTexture(TEXTURE_SET.UNK);
			icon:SetHighlightTexture(TEXTURE_SET.SQUARE_HIGHLIGHT);
			icon:GetHighlightTexture():SetTexCoord(TEXTURE_SET.ICON_HIGHLIGHT_COORD[1], TEXTURE_SET.ICON_HIGHLIGHT_COORD[2], TEXTURE_SET.ICON_HIGHLIGHT_COORD[3], TEXTURE_SET.ICON_HIGHLIGHT_COORD[4]);
			icon:GetHighlightTexture():SetVertexColor(TEXTURE_SET.ICON_HIGHLIGHT_COLOR[1], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[2], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[3], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[4]);

			local split = icon:CreateFontString(nil, "ARTWORK", nil);
			split:SetFont(ui_style.talentIconFont, ui_style.talentIconFontSize, ui_style.talentIconFontOutline)
			split:SetText("/");
			split:SetPoint("CENTER", icon, "BOTTOMRIGHT", 0, 0);
			icon.split = split;
			local maxVal = icon:CreateFontString(nil, "ARTWORK", nil);
			maxVal:SetFont(ui_style.talentIconFont, ui_style.talentIconFontSize, ui_style.talentIconFontOutline)
			maxVal:SetText("1");
			maxVal:SetPoint("LEFT", split, "RIGHT", 0, 0);
			icon.maxVal = maxVal;
			local curVal = icon:CreateFontString(nil, "ARTWORK", nil);
			curVal:SetFont(ui_style.talentIconFont, ui_style.talentIconFontSize, ui_style.talentIconFontOutline)
			curVal:SetText("");
			curVal:SetPoint("RIGHT", split, "LEFT", 0, 0);
			icon.curVal = curVal;

			local overlay = icon:CreateTexture(nil, "OVERLAY");
			overlay:SetAllPoints();
			overlay:SetBlendMode("ADD");
			icon.overlay = overlay;

			icon.id = id;
			icon.active = true;

			return icon;
		end
		function NS.CreateTalentIcons(talentFrame)
			local talentIcons = {  };
			local posX = 0;
			local posY = 0;
			for id = 1, MAX_NUM_ICONS_PER_SPEC do
				local icon = NS.CreateTalentIcon(talentFrame, id);
				icon:SetPoint("TOP", talentFrame, "TOP", (ui_style.talentIconSize + ui_style.talentIconXGap) * (posX - MAX_NUM_COL * 0.5 + 0.5), - ui_style.talentFrameHeaderYSize - ui_style.talentIconYToTop - (ui_style.talentIconSize + ui_style.talentIconYGap) * posY);
				icon:Hide();
				talentIcons[id] = icon;

				posX = posX + 1;
				if posX > 3 then
					posX = 0;
					posY = posY + 1;
				end
			end

			return talentIcons;
		end

		function NS.talentFrameUpdateSize(mainFrame, talentFrames, width, height)
			local style = mainFrame.style;
			if style == 1 then
				local scale = min((width - ui_style.talentFrameXToBorder * 2) / ui_style.talentFrameXSizeTriple, (height - ui_style.talentFrameYToBorder * 2) / (ui_style.talentFrameYSize + ui_style.mainFrameHeaderYSize + ui_style.mainFrameFooterYSize));
				talentFrames[1]:SetScale(scale);
				talentFrames[2]:SetScale(scale);
				talentFrames[3]:SetScale(scale);
				mainFrame.talentFrameScale = scale;
			elseif style == 2 then
				local scale = min((width - ui_style.talentFrameXToBorder * 2) / ui_style.talentFrameXSizeSingle, (height - ui_style.talentFrameYToBorder * 2) / (ui_style.talentFrameYSize + ui_style.mainFrameHeaderYSize + ui_style.mainFrameFooterYSize));
				talentFrames[1]:SetScale(scale);
				talentFrames[2]:SetScale(scale);
				talentFrames[3]:SetScale(scale);
				mainFrame.talentFrameScale = scale;
			end
		end

		local function resetButton_OnClick(self)
			local talentFrame = self:GetParent();
			local mainFrame = talentFrame:GetParent();
			local specIndex = talentFrame.id;
			NS.EmuCore_ResetTalentAllSingleTab(mainFrame, specIndex);
			NS.EmuCore_SetReadOnly(mainFrame, false);
		end
		function NS.CreateTalentFrames(mainFrame)
			local talentFrames = {  };

			for specIndex = 1, 3 do
				local talentFrame = CreateFrame("FRAME", nil, mainFrame);	-- mainFrame:GetName() .. "TalentFrame" .. specIndex
				talentFrame:SetSize(ui_style.talentFrameXSizeSingle, ui_style.talentFrameYSize);

				talentFrame:Show();
				talentFrame:EnableMouse(true);
				talentFrame:SetMovable(true);
				talentFrame:RegisterForDrag("LeftButton");
				talentFrame:SetScript("OnShow", talentFrame_OnShow);
				talentFrame:SetScript("OnHide", talentFrame_OnHide);
				talentFrame:SetScript("OnDragStart", function(self, button)
						if not mainFrame.isMoving and not mainFrame.isResizing and mainFrame:IsMovable() then
							mainFrame:StartMoving();
						end
					end
				);
				talentFrame:SetScript("OnDragStop", function(self, button)
						mainFrame:StopMovingOrSizing();
					end
				);

				local hSep = {  };
				hSep[1] = talentFrame:CreateTexture(nil, "ARTWORK");
				hSep[1]:SetHeight(ui_style.seqWidth);
				hSep[1]:SetPoint("LEFT", talentFrame, "TOPLEFT", 0, 0);
				hSep[1]:SetPoint("RIGHT", talentFrame, "TOPRIGHT", 0, 0);
				hSep[1]:SetTexture(TEXTURE_SET.SEP_HORIZONTAL);
				hSep[1]:SetTexCoord(TEXTURE_SET.SEP_HORIZONTAL_COORD[1], TEXTURE_SET.SEP_HORIZONTAL_COORD[2], TEXTURE_SET.SEP_HORIZONTAL_COORD[3], TEXTURE_SET.SEP_HORIZONTAL_COORD[4]);
				hSep[2] = talentFrame:CreateTexture(nil, "ARTWORK");
				hSep[2]:SetHeight(ui_style.seqWidth);
				hSep[2]:SetPoint("LEFT", talentFrame, "BOTTOMLEFT", 0, 0);
				hSep[2]:SetPoint("RIGHT", talentFrame, "BOTTOMRIGHT", 0, 0);
				hSep[2]:SetTexture(TEXTURE_SET.SEP_HORIZONTAL);
				hSep[2]:SetTexCoord(TEXTURE_SET.SEP_HORIZONTAL_COORD[1], TEXTURE_SET.SEP_HORIZONTAL_COORD[2], TEXTURE_SET.SEP_HORIZONTAL_COORD[3], TEXTURE_SET.SEP_HORIZONTAL_COORD[4]);
				hSep[3] = talentFrame:CreateTexture(nil, "ARTWORK");
				hSep[3]:SetHeight(ui_style.seqWidth);
				hSep[3]:SetPoint("LEFT", talentFrame, "BOTTOMLEFT", 0, ui_style.talentFrameFooterYSize);
				hSep[3]:SetPoint("RIGHT", talentFrame, "BOTTOMRIGHT", 0, ui_style.talentFrameFooterYSize);
				hSep[3]:SetTexture(TEXTURE_SET.SEP_HORIZONTAL);
				hSep[3]:SetTexCoord(TEXTURE_SET.SEP_HORIZONTAL_COORD[1], TEXTURE_SET.SEP_HORIZONTAL_COORD[2], TEXTURE_SET.SEP_HORIZONTAL_COORD[3], TEXTURE_SET.SEP_HORIZONTAL_COORD[4]);
				talentFrame.hSep = hSep;

				local vSep = {  };
				vSep[1] = talentFrame:CreateTexture(nil, "ARTWORK");
				vSep[1]:SetWidth(ui_style.seqWidth);
				vSep[1]:SetPoint("TOP", talentFrame, "TOPLEFT", 0, 0);
				vSep[1]:SetPoint("BOTTOM", talentFrame, "BOTTOMLEFT", 0, 0);
				vSep[1]:SetTexture(TEXTURE_SET.SEP_VERTICAL);
				vSep[1]:SetTexCoord(TEXTURE_SET.SEP_VERTICAL_COORD[1], TEXTURE_SET.SEP_VERTICAL_COORD[2], TEXTURE_SET.SEP_VERTICAL_COORD[3], TEXTURE_SET.SEP_VERTICAL_COORD[4]);
				vSep[2] = talentFrame:CreateTexture(nil, "ARTWORK");
				vSep[2]:SetWidth(ui_style.seqWidth);
				vSep[2]:SetPoint("TOP", talentFrame, "TOPRIGHT", 0, 0);
				vSep[2]:SetPoint("BOTTOM", talentFrame, "BOTTOMRIGHT", 0, 0);
				vSep[2]:SetTexture(TEXTURE_SET.SEP_VERTICAL);
				vSep[2]:SetTexCoord(TEXTURE_SET.SEP_VERTICAL_COORD[1], TEXTURE_SET.SEP_VERTICAL_COORD[2], TEXTURE_SET.SEP_VERTICAL_COORD[3], TEXTURE_SET.SEP_VERTICAL_COORD[4]);
				talentFrame.vSep = vSep;

				local BG = talentFrame:CreateTexture(nil, "BORDER");
				BG:SetAllPoints();
				BG:SetAlpha(0.6);
				local ratio = ui_style.talentFrameXSizeSingle / ui_style.talentFrameYSize;
				if ratio > 1.0 then
					BG:SetTexCoord(0.0, 1.0, (1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5);
				elseif ratio < 1.0 then
					BG:SetTexCoord((1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5, 0.0, 1.0);
				end
				talentFrame.BG = BG;

				talentFrame.talentIcons = NS.CreateTalentIcons(talentFrame);

				local resetButtonBg = talentFrame:CreateTexture(nil, "ARTWORK");
				resetButtonBg:SetSize(ui_style.talentIconSize, ui_style.talentIconSize);
				resetButtonBg:SetPoint("CENTER", talentFrame.talentIcons[MAX_NUM_ICONS_PER_SPEC]);
				resetButtonBg:SetTexture(TEXTURE_SET.TALENT_RESET_BG);
				resetButtonBg:SetTexCoord(TEXTURE_SET.TALENT_RESET_BG_COORD[1], TEXTURE_SET.TALENT_RESET_BG_COORD[2], TEXTURE_SET.TALENT_RESET_BG_COORD[3], TEXTURE_SET.TALENT_RESET_BG_COORD[4]);
				resetButtonBg:SetVertexColor(TEXTURE_SET.TALENT_RESET_BG_COLOR[1], TEXTURE_SET.TALENT_RESET_BG_COLOR[2], TEXTURE_SET.TALENT_RESET_BG_COLOR[3], TEXTURE_SET.TALENT_RESET_BG_COLOR[4]);
				talentFrame.resetButtonBg = resetButtonBg;

				local resetButton = CreateFrame("BUTTON", nil, talentFrame);
				resetButton:SetSize(ui_style.controlButtonSize, ui_style.controlButtonSize);
				resetButton:SetPoint("CENTER", resetButtonBg);
				resetButton:SetHighlightTexture(TEXTURE_SET.TALENT_RESET_HIGHLIGHT);
				resetButton:GetHighlightTexture():ClearAllPoints();
				resetButton:GetHighlightTexture():SetPoint("CENTER");
				resetButton:GetHighlightTexture():SetSize(ui_style.talentIconSize, ui_style.talentIconSize);
				resetButton:GetHighlightTexture():SetTexCoord(TEXTURE_SET.TALENT_RESET_HIGHLIGHT_COORD[1], TEXTURE_SET.TALENT_RESET_HIGHLIGHT_COORD[2], TEXTURE_SET.TALENT_RESET_HIGHLIGHT_COORD[3], TEXTURE_SET.TALENT_RESET_HIGHLIGHT_COORD[4]);
				resetButton:SetScript("OnClick", resetButton_OnClick);
				resetButton:SetScript("OnEnter", Info_OnEnter);
				resetButton:SetScript("OnLeave", Info_OnLeave);
				resetButton.information = L.resetButton;
				talentFrame.resetButton = resetButton;

				local curTabPoints = talentFrame:CreateFontString(nil, "ARTWORK");
				curTabPoints:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				curTabPoints:SetPoint("CENTER", resetButton);
				curTabPoints:SetTextColor(0.0, 1.0, 0.0, 1.0);
				curTabPoints:SetText("0");
				talentFrame.curTabPoints = curTabPoints;

				local specLabel = talentFrame:CreateFontString(nil, "ARTWORK");
				specLabel:SetFont(ui_style.frameFont, ui_style.frameFontSizeMid, ui_style.frameFontOutline);
				specLabel:SetPoint("CENTER", talentFrame, "BOTTOM", 0, ui_style.talentFrameFooterYSize * 0.5);
				specLabel:SetTextColor(0.9, 0.9, 0.9, 1.0);
				talentFrame.specLabel = specLabel;

				talentFrame.id = specIndex;
				talentFrame.talentSet = { totalPerTier = {  }, total = 0, curAvailableTopTier = 0, curCheckedTier = 0, };
				for i = 1, MAX_NUM_TALENTS do
					talentFrame.talentSet[i] = 0;
				end
				for i = 0, MAX_NUM_TIER do
					talentFrame.talentSet.totalPerTier[i] = 0;
				end
				talentFrame.talentChanged = {  };
				talentFrame.reqArrows = { used = 0, };
				talentFrame.reqByArrowSet = {  };
				for i = 1, MAX_NUM_ICONS_PER_SPEC do
					talentFrame.reqByArrowSet[i] = {  };
				end

				talentFrames[specIndex] = talentFrame;
			end

			return talentFrames;
		end
	end

	do	-- mainFrame sub objects
		local function equipmentButton_OnClick(self)
			NS.Emu_ToggleEquipmentFrame(self:GetParent());
		end
		local function specButton_OnClick(self)
			NS.Emu_ChangeTab_Style2(self:GetParent():GetParent(), self.id);
		end
		local function classButton_OnClick(self, button)
			if button == "LeftButton" then
				local mainFrame = self.mainFrame;
				if mainFrame.class ~= self.class then
					NS.EmuCore_Reset(mainFrame);
					NS.EmuCore_SetClass(mainFrame, self.class);
					local objects = mainFrame.objects;
					objects.curClassIndicator:Show();
					objects.curClassIndicator:ClearAllPoints();
					objects.curClassIndicator:SetPoint("CENTER", mainFrame.classButtons[_classToIndex[mainFrame.class]]);
				end
			elseif button == "RightButton" then
				local preset = _PRESET[self.class];
				if preset and #preset > 0 then
					local menu = {
						handler = function(button, code)
							NS.Emu_Set(self.mainFrame, self.class, code, 60, false);
						end;
						elements = {  },
					};
					for i = 1, #preset do
						tinsert(menu.elements, {
							para = { preset[i].code, },
							text = preset[i].title,
						})
					end
					ALADROP(self, "TOPRIGHT", menu);
				end
			end
		end
		local function resetToEmu_OnClick(self)
			NS.Emu_ResetToEmu(self:GetParent());
			self:Hide();
		end
		local function resetToSetButton_OnClick(self)
			local mainFrame = self:GetParent();
			NS.Emu_ResetToSet(mainFrame);
			self:Hide();
		end
		local function resetAllButton_OnClick(self)
			NS.EmuCore_ResetTalentAll(self:GetParent());
			NS.EmuCore_SetReadOnly(self:GetParent(), false);
		end
		--	side
		local function spellTabButton_OnClick(self)
			NS.Emu_ToggleSpellTab(self.mainFrame);
		end
		local function inspectTargetButton_OnClick(self)
			if UnitExists('target') and UnitIsPlayer('target') and UnitIsConnected('target') and UnitFactionGroup('target') == NS.playerFactionGroup then
				local name, realm = UnitName('target');
				if name then
					if realm ~= nil and realm ~= "" and realm ~= NS.realm then
						NS.specializedMainFrameInspect[name .. "-" .. realm] = { GetTime(), self.mainFrame, };
					else
						NS.specializedMainFrameInspect[name] = { GetTime(), self.mainFrame, };
					end
					NS.Emu_Query(name, realm);
				end
			end
		end
		StaticPopupDialogs["alaTalentEmu_apply"] = {
			text = L.applyTalentsButton_Notify,
			button1 = L.OK,
			button2 = L.Cancel,
			-- OnShow = function(self) end,
			OnAccept = function(self)
			end,
			OnHide = function(self)
				self.which = nil;
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 1,
		};
		local function applyTalentsButton_OnClick(self)
			if UnitLevel('player') >= 10 then
				StaticPopupDialogs["alaTalentEmu_apply"].OnAccept = function()
					NS.Emu_ApplyTalents(self.mainFrame);
				end;
				StaticPopup_Show("alaTalentEmu_apply");
			end
		end
		local function importButton_OnClick(self)
			local editBox = self.mainFrame.editBox;
			if editBox:IsShown() and editBox.parent == self then
				editBox:Hide();
			else
				editBox:ClearAllPoints();
				editBox:SetPoint("LEFT", self, "RIGHT", ui_style.editBoxYSize + 4, 0);
				editBox:SetText("");
				editBox:Show();
				editBox:SetFocus();
				editBox.OKButton:ClearAllPoints();
				editBox.OKButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
				-- editBox.OKButton:Show();
				editBox.parent = self;
				editBox.type = "import";
			end
		end
		local function exportButton_OnClick(self, button)
			local mainFrame = self.mainFrame;
			local editBox = mainFrame.editBox;
			if editBox:IsShown() and editBox.parent == self then
				editBox:Hide();
			else
				editBox:ClearAllPoints();
				editBox:SetPoint("LEFT", self, "RIGHT", 4, 0);
				editBox.OKButton:ClearAllPoints();
				editBox.OKButton:SetPoint("LEFT", editBox, "RIGHT", 0, 0);
				editBox.parent = self;
				if button == "LeftButton" then
					editBox:SetText(NS.EmuCore_Encoder(mainFrame));
					editBox:Show();
					editBox:SetFocus();
					editBox:HighlightText();
					editBox.type = "export";
				elseif button == "RightButton" then
					local menu = {
						handler = function(button, code)
							editBox:SetText(code);
							editBox:Show();
							editBox:SetFocus();
							editBox:HighlightText();
							editBox.type = 'export';
						end;
						elements = {  },
					};
					for key, func in next, NS.extern.export do
						local arg = func(mainFrame);
						if arg then
							tinsert(menu.elements, {
								para = { arg, },
								text = key,
							});
						end
					end
					ALADROP(self, "TOPRIGHT", menu);
				end
			end
		end
		local function saveButton_OnClick(self, button)
			if button == "LeftButton" then
				local mainFrame = self.mainFrame;
				local editBox = mainFrame.editBox;
				if editBox:IsShown() and editBox.parent == self then
					editBox:Hide();
				else
					editBox:ClearAllPoints();
					editBox:SetPoint("LEFT", self, "RIGHT", ui_style.editBoxYSize + 4, 0);
					editBox:SetText(NS.EmuSub_GenerateTitleFromRawData(mainFrame));
					editBox:Show();
					editBox.OKButton:ClearAllPoints();
					editBox.OKButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
					editBox.parent = self;
					editBox.type = "save";
				end
			elseif button == "RightButton" then
				if next(VAR.savedTalent) == nil then
					return;
				end
				local mainFrame = self.mainFrame;
				local drop_menu_table = {
					handler = function(button, title, code)
						if IsShiftKeyDown() then
							VAR.savedTalent[title] = nil;
						else
							NS.Emu_Import(mainFrame, code);
						end
					end,
					elements = {  },
				};
				for title, code in next, VAR.savedTalent do
					tinsert(drop_menu_table.elements, {
							para = { title, code, },
							text = title,
						}
					);
				end
				ALADROP(self, "TOPRIGHT", drop_menu_table);
			end
		end
		local channel_list = {
			"PARTY",
			"GUILD",
			"RAID",
			"BATTLEGROUND",
			"WHISPER",
		};
		local function sendButton_OnClick(self, button)
			local mainFrame = self.mainFrame;
			if button == "LeftButton" then
				local sendTalent_OnLeftClickData = {
					handler = function(button, channel, mainFrame)
						if channel == "WHISPER" then
							local editBox = mainFrame.editBox;
							if editBox:IsShown() and editBox.parent == self then
								editBox:Hide();
							else
								editBox:ClearAllPoints();
								editBox:SetPoint("LEFT", self, "RIGHT", ui_style.editBoxYSize + 4, 0);
								editBox:SetText("");
								editBox:Show();
								editBox.OKButton:ClearAllPoints();
								editBox.OKButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
								editBox.parent = self;
								editBox.type = "send";
							end
						else
							NS.EmuSub_SendMessage(channel, nil, mainFrame);
						end
					end,
					elements = {  },
				};
				for index, channel in next, channel_list do
					sendTalent_OnLeftClickData.elements[index] = {
						para = { channel, mainFrame, },
						text = channel,
					};
				end
				ALADROP(self, "TOPRIGHT", sendTalent_OnLeftClickData);
			elseif button == "RightButton" then
				local sendTalent_OnRightClickData = {
					handler = function(button, mainFrame, code, sender, title)
						local class, data, level = NS.EmuCore_Decoder(code);
						if class and data and level then
							NS.Emu_Create(mainFrame, class, data, level, false, false, L.message .. sender);
						end
					end,
					elements = {  };
				};
				local elements = sendTalent_OnRightClickData.elements;
				for i = 1, #NS.recv_msg do
					sendTalent_OnRightClickData.elements[i] = {
						para = { mainFrame, NS.recv_msg[i][1], NS.recv_msg[i][2], NS.recv_msg[i][3] },
						text = NS.recv_msg[i][2] .. ": " .. NS.recv_msg[i][3],
					};
				end
				ALADROP(self, "TOPRIGHT", sendTalent_OnRightClickData);
			end
		end
		local function editBox_OnEnterPressed(self)
			if not self.type then
				return;
			end
			if self.type == "import" then
				if self:GetText() and self:GetText() ~= "" then
					local class, data, level = NS.EmuCore_Decoder(self:GetText());
					if class and data and level then
						NS.Emu_Set(self:GetParent(), class, data, level);
					end
				end
			elseif self.type == "save" then
				local title = self:GetText();
				if not title or title == "" then
					title = #VAR.savedTalent + 1;
				end
				VAR.savedTalent[title] = NS.EmuCore_Encoder(self:GetParent());
			elseif self.type == "send" then
				local target = self:GetText();
				if target and target ~= "" then
					NS.EmuSub_SendMessage("WHISPER", target, self:GetParent());
				end
			end
			self.type = nil;
			self:ClearFocus();
			self:Hide();
		end
		--

		local function readOnlyButton_OnClick(self, button)
			-- if button == "LeftButton" then
			-- 	local mainFrame = self:GetParent();
			-- 	NS.EmuCore_SetReadOnly(mainFrame, not mainFrame.readOnly);
			-- elseif button == "RightButton" then
				NS.Emu_Menu(self, self:GetParent());
			-- end
		end

		function NS.CreateMainFrameSubObject(mainFrame)
			local objects = {  };
			mainFrame.objects = objects;

			--<header>
			do
				local readOnlyButton = CreateFrame("BUTTON", nil, mainFrame);
				readOnlyButton:SetSize(ui_style.controlButtonSize, ui_style.controlButtonSize);
				readOnlyButton:SetNormalTexture(TEXTURE_SET.LOCK);
				readOnlyButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.LOCK_UNLOCKED_COLOR[1], TEXTURE_SET.LOCK_UNLOCKED_COLOR[2], TEXTURE_SET.LOCK_UNLOCKED_COLOR[3], TEXTURE_SET.LOCK_UNLOCKED_COLOR[4]);
				readOnlyButton:SetPushedTexture(TEXTURE_SET.LOCK);
				readOnlyButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				readOnlyButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				readOnlyButton:SetPoint("TOPLEFT", mainFrame, (ui_style.mainFrameHeaderYSize - ui_style.controlButtonSize) * 0.5, - (ui_style.mainFrameHeaderYSize - ui_style.controlButtonSize) * 0.5);
				readOnlyButton:Show();
				readOnlyButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
				readOnlyButton:SetScript("OnClick", readOnlyButton_OnClick);
				readOnlyButton:SetScript("OnEnter", Info_OnEnter);
				readOnlyButton:SetScript("OnLeave", Info_OnLeave);
				readOnlyButton.information = L.readOnlyButton;
				objects.readOnlyButton = readOnlyButton;

				local closeButton = CreateFrame("BUTTON", nil, mainFrame);
				closeButton:SetSize(ui_style.controlButtonSize, ui_style.controlButtonSize);
				closeButton:SetNormalTexture(TEXTURE_SET.CLOSE);
				closeButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.CLOSE_COORD[1], TEXTURE_SET.CLOSE_COORD[2], TEXTURE_SET.CLOSE_COORD[3], TEXTURE_SET.CLOSE_COORD[4]);
				closeButton:SetPushedTexture(TEXTURE_SET.CLOSE);
				closeButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.CLOSE_COORD[1], TEXTURE_SET.CLOSE_COORD[2], TEXTURE_SET.CLOSE_COORD[3], TEXTURE_SET.CLOSE_COORD[4]);
				closeButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				closeButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				closeButton:SetPoint("TOPRIGHT", - (ui_style.mainFrameHeaderYSize - ui_style.controlButtonSize) * 0.5, - (ui_style.mainFrameHeaderYSize - ui_style.controlButtonSize) * 0.5);
				closeButton:Show();
				closeButton:SetScript("OnClick", function(self, button)
						mainFrame:Hide();
					end
				);
				closeButton:SetScript("OnEnter", Info_OnEnter);
				closeButton:SetScript("OnLeave", Info_OnLeave);
				closeButton.information = L.closeButton;
				objects.closeButton = closeButton;

				local label = mainFrame:CreateFontString(nil, "ARTWORK");
				label:SetFont(ui_style.frameFont, ui_style.frameFontSizeMid, ui_style.frameFontOutline);
				label:SetText(L.Emu);
				label:SetPoint("CENTER", mainFrame, "TOP", 0, - ui_style.mainFrameHeaderYSize * 0.5);
				objects.label = label;

				local pack_label = mainFrame:CreateFontString(nil, "ARTWORK");
				pack_label:SetFont(ui_style.frameFont, ui_style.frameFontSize, ui_style.frameFontOutline);
				pack_label:SetText("");
				pack_label:SetPoint("BOTTOM", label, "TOP", 0, 4);
				pack_label:Hide();
				objects.pack_label = pack_label;

				local resetToEmu = CreateFrame("BUTTON", nil, mainFrame);
				resetToEmu:SetSize(ui_style.controlButtonSize, ui_style.controlButtonSize);
				resetToEmu:SetNormalTexture(TEXTURE_SET.CLOSE);
				resetToEmu:GetNormalTexture():SetTexCoord(TEXTURE_SET.CLOSE_COORD[1], TEXTURE_SET.CLOSE_COORD[2], TEXTURE_SET.CLOSE_COORD[3], TEXTURE_SET.CLOSE_COORD[4]);
				resetToEmu:SetPushedTexture(TEXTURE_SET.CLOSE);
				resetToEmu:GetPushedTexture():SetTexCoord(TEXTURE_SET.CLOSE_COORD[1], TEXTURE_SET.CLOSE_COORD[2], TEXTURE_SET.CLOSE_COORD[3], TEXTURE_SET.CLOSE_COORD[4]);
				resetToEmu:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				resetToEmu:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				resetToEmu:SetPoint("RIGHT", label, "LEFT", 0, 0);
				resetToEmu:SetScript("OnClick", resetToEmu_OnClick);
				resetToEmu:SetScript("OnEnter", Info_OnEnter);
				resetToEmu:SetScript("OnLeave", Info_OnLeave);
				resetToEmu.information = L.resetToEmu;
				objects.resetToEmu = resetToEmu;

				local resetToSetButton = CreateFrame("BUTTON", nil, mainFrame);
				resetToSetButton:SetSize(ui_style.controlButtonSize, ui_style.controlButtonSize);
				resetToSetButton:SetNormalTexture(TEXTURE_SET.RESET);
				resetToSetButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.RESET_COORD[1], TEXTURE_SET.RESET_COORD[2], TEXTURE_SET.RESET_COORD[3], TEXTURE_SET.RESET_COORD[4]);
				resetToSetButton:SetPushedTexture(TEXTURE_SET.RESET);
				resetToSetButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.RESET_COORD[1], TEXTURE_SET.RESET_COORD[2], TEXTURE_SET.RESET_COORD[3], TEXTURE_SET.RESET_COORD[4]);
				resetToSetButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				resetToSetButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				resetToSetButton:SetPoint("LEFT", label, "RIGHT", 0, 0);
				resetToSetButton:SetScript("OnClick", resetToSetButton_OnClick);
				resetToSetButton:SetScript("OnEnter", Info_OnEnter);
				resetToSetButton:SetScript("OnLeave", Info_OnLeave);
				resetToSetButton.information = L.resetToSetButton;
				objects.resetToSetButton = resetToSetButton;
			end
			--</header>

			--<footer>
			do
				do	-- control
					local resetAllButton = CreateFrame("BUTTON", nil, mainFrame);
					resetAllButton:SetSize(ui_style.controlButtonSize, ui_style.controlButtonSize);
					resetAllButton:SetNormalTexture(TEXTURE_SET.RESET);
					resetAllButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.RESET_COORD[1], TEXTURE_SET.RESET_COORD[2], TEXTURE_SET.RESET_COORD[3], TEXTURE_SET.RESET_COORD[4]);
					resetAllButton:SetPushedTexture(TEXTURE_SET.RESET);
					resetAllButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.RESET_COORD[1], TEXTURE_SET.RESET_COORD[2], TEXTURE_SET.RESET_COORD[3], TEXTURE_SET.RESET_COORD[4]);
					resetAllButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					resetAllButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					resetAllButton:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", - 8, (ui_style.mainFrameFooterYSize - ui_style.controlButtonSize) * 0.5);
					resetAllButton:Show();
					resetAllButton:SetScript("OnClick", resetAllButton_OnClick);
					resetAllButton:SetScript("OnEnter", Info_OnEnter);
					resetAllButton:SetScript("OnLeave", Info_OnLeave);
					resetAllButton.information = L.resetAllButton;
					objects.resetAllButton = resetAllButton;

					local curPointsRemainingLabel = mainFrame:CreateFontString(nil, "ARTWORK");
					curPointsRemainingLabel:SetFont(ui_style.frameFont, ui_style.frameFontSizeSmall, ui_style.frameFontOutline);
					curPointsRemainingLabel:SetText(L.curPointsRemaining);
					curPointsRemainingLabel:SetPoint("CENTER", mainFrame, "BOTTOM", - 15, ui_style.mainFrameFooterYSize * 0.5);
					local curPointsRemaining = mainFrame:CreateFontString(nil, "ARTWORK");
					curPointsRemaining:SetFont(ui_style.frameFont, ui_style.frameFontSizeMid, ui_style.frameFontOutline);
					curPointsRemaining:SetText("51");
					curPointsRemaining:SetPoint("LEFT", curPointsRemainingLabel, "RIGHT", 2, 0);
					curPointsRemainingLabel:SetTextColor(0.5, 1.0, 1.0, 1.0);
					curPointsRemaining:SetTextColor(0.5, 1.0, 1.0, 1.0);

					local curPointsUsed = mainFrame:CreateFontString(nil, "ARTWORK");
					curPointsUsed:SetFont(ui_style.frameFont, ui_style.frameFontSizeMid, ui_style.frameFontOutline);
					curPointsUsed:SetText("0");
					curPointsUsed:SetPoint("RIGHT", curPointsRemainingLabel, "LEFT", - 8, 0);
					local curPointsUsedLabel = mainFrame:CreateFontString(nil, "ARTWORK");
					curPointsUsedLabel:SetFont(ui_style.frameFont, ui_style.frameFontSizeMid, ui_style.frameFontOutline);
					curPointsUsedLabel:SetText(L.curPointsUsed);
					curPointsUsedLabel:SetPoint("RIGHT", curPointsUsed, "LEFT", -2, 0);
					curPointsUsedLabel:SetTextColor(0.5, 1.0, 0.5, 1.0);
					curPointsUsed:SetTextColor(0.5, 1.0, 0.5, 1.0);

					local curPointsReqLevelLabel = mainFrame:CreateFontString(nil, "ARTWORK");
					curPointsReqLevelLabel:SetFont(ui_style.frameFont, ui_style.frameFontSizeMid, ui_style.frameFontOutline);
					curPointsReqLevelLabel:SetText(L.curPointsReqLevel);
					curPointsReqLevelLabel:SetPoint("LEFT", curPointsRemaining, "RIGHT", 8, 0);
					local curPointsReqLevel = mainFrame:CreateFontString(nil, "ARTWORK");
					curPointsReqLevel:SetFont(ui_style.frameFont, ui_style.frameFontSizeMid, ui_style.frameFontOutline);
					curPointsReqLevel:SetText("10");
					curPointsReqLevel:SetPoint("LEFT", curPointsReqLevelLabel, "RIGHT", 2, 0);
					curPointsReqLevelLabel:SetTextColor(1.0, 1.0, 0.5, 1.0);
					curPointsReqLevel:SetTextColor(1.0, 1.0, 0.5, 1.0);

					objects.curPointsRemainingLabel = curPointsRemainingLabel;
					objects.curPointsRemaining = curPointsRemaining;
					objects.curPointsUsedLabel = curPointsUsedLabel;
					objects.curPointsUsed = curPointsUsed;
					objects.curPointsReqLevelLabel = curPointsReqLevelLabel;
					objects.curPointsReqLevel = curPointsReqLevel;
				end

				do	-- spec
					local specButtonsBar = CreateFrame("FRAME", nil, mainFrame);
					specButtonsBar:SetPoint("CENTER", mainFrame, "BOTTOM", 0, ui_style.mainFrameFooterYSize + ui_style.talentFrameFooterYSize * 0.5);
					specButtonsBar:SetSize(ui_style.specTabButtonXSize * 3 + ui_style.specTabButtonGap * 2, ui_style.specTabButtonYSize);
					mainFrame.specButtonsBar = specButtonsBar;
					local specButtons = {  };
					for specIndex = 1, 3 do
						local specButton = CreateFrame("BUTTON", nil, specButtonsBar);
						specButton:SetSize(ui_style.specTabButtonXSize, ui_style.specTabButtonYSize);
						specButton:SetNormalTexture(TEXTURE_SET.UNK);
						specButton:GetNormalTexture():SetTexCoord(ui_style.specTabButtonTexCoord[1], ui_style.specTabButtonTexCoord[2], ui_style.specTabButtonTexCoord[3], ui_style.specTabButtonTexCoord[4]);
						specButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.SPEC_NORMAL_COLOR[1], TEXTURE_SET.SPEC_NORMAL_COLOR[2], TEXTURE_SET.SPEC_NORMAL_COLOR[3], TEXTURE_SET.SPEC_NORMAL_COLOR[4]);
						specButton:SetPushedTexture(TEXTURE_SET.UNK);
						specButton:GetPushedTexture():SetTexCoord(ui_style.specTabButtonTexCoord[1], ui_style.specTabButtonTexCoord[2], ui_style.specTabButtonTexCoord[3], ui_style.specTabButtonTexCoord[4]);
						specButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.SPEC_PUSHED_COLOR[1], TEXTURE_SET.SPEC_PUSHED_COLOR[2], TEXTURE_SET.SPEC_PUSHED_COLOR[3], TEXTURE_SET.SPEC_PUSHED_COLOR[4]);
						specButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
						specButton:GetHighlightTexture():SetTexCoord(ui_style.specTabButtonTexCoord[1], ui_style.specTabButtonTexCoord[2], ui_style.specTabButtonTexCoord[3], ui_style.specTabButtonTexCoord[4]);
						specButton:Show();
						specButton:SetScript("OnClick", specButton_OnClick);
						specButton:SetScript("OnEnter", Info_OnEnter);
						specButton:SetScript("OnLeave", Info_OnLeave);
						specButton.id = specIndex;
						specButton.information = nil;
						local title = specButton:CreateFontString(nil, "OVERLAY");
						title:SetFont(ui_style.frameFont, ui_style.frameFontSizeSmall, "OUTLINE");
						title:SetTextColor(0.9, 0.9, 0.9, 1.0);
						title:SetPoint("CENTER");
						title:SetWidth(ui_style.specTabButtonXSize);
						title:SetMaxLines(1);
						specButton.title = title;
						specButtons[specIndex] = specButton;
					end
					specButtons[2]:SetPoint("CENTER", specButtonsBar, "CENTER", 0, 0);
					specButtons[1]:SetPoint("RIGHT", specButtons[2], "LEFT", - ui_style.specTabButtonGap, 0);
					specButtons[3]:SetPoint("LEFT", specButtons[2], "RIGHT", ui_style.specTabButtonGap, 0);
					mainFrame.specButtons = specButtons;

					local curTabIndicator = specButtonsBar:CreateTexture(nil, "OVERLAY");
					curTabIndicator:SetSize(ui_style.specTabButtonXSize + 4, ui_style.specTabButtonYSize + 4);
					curTabIndicator:SetBlendMode("ADD");
					curTabIndicator:SetTexture(TEXTURE_SET.SQUARE_HIGHLIGHT);
					curTabIndicator:SetTexCoord(TEXTURE_SET.SPEC_INDICATOR_COORD[1], TEXTURE_SET.SPEC_INDICATOR_COORD[2], TEXTURE_SET.SPEC_INDICATOR_COORD[3], TEXTURE_SET.SPEC_INDICATOR_COORD[4]);
					curTabIndicator:SetVertexColor(TEXTURE_SET.SPEC_INDICATOR_COLOR[1], TEXTURE_SET.SPEC_INDICATOR_COLOR[2], TEXTURE_SET.SPEC_INDICATOR_COLOR[3], TEXTURE_SET.SPEC_INDICATOR_COLOR[4]);
					curTabIndicator:Hide();
					specButtonsBar.curTabIndicator = curTabIndicator;
				end
			end
			--</footer>

			--<side>
			do
				local side_anchor_up = CreateFrame("FRAME", nil, mainFrame);
				side_anchor_up:SetWidth(1);
				mainFrame.side_anchor_up = side_anchor_up;
				side_anchor_up:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 2, 0);
				side_anchor_up:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMRIGHT", 2, 0);
				do	-- class
					local classButtons = {  };--_indexToClass
					for index = 1, #_indexToClass do
						local class = strupper(_indexToClass[index]);
						local classButton = CreateFrame("BUTTON", nil, side_anchor_up);
						classButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
						classButton:SetNormalTexture(TEXTURE_SET.CLASS);
						classButton:SetPushedTexture(TEXTURE_SET.CLASS);
						classButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
						local coord = CLASS_ICON_TCOORDS[class];
						if coord then
							classButton:GetNormalTexture():SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
							classButton:GetPushedTexture():SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 0 / 256, coord[4] - 2 / 256);
						else
							classButton:GetNormalTexture():SetTexCoord(0.75, 1.00, 0.75, 1.00);
							classButton:GetPushedTexture():SetTexCoord(0.75, 1.00, 0.75, 1.00);
						end
						classButton:SetHighlightTexture(TEXTURE_SET.CLASS_HIGHLIGHT);
						classButton:GetHighlightTexture():SetTexCoord(TEXTURE_SET.CLASS_HIGHLIGHT_COORD[1], TEXTURE_SET.CLASS_HIGHLIGHT_COORD[2], TEXTURE_SET.CLASS_HIGHLIGHT_COORD[3], TEXTURE_SET.CLASS_HIGHLIGHT_COORD[4]);
						classButton:GetHighlightTexture():SetVertexColor(TEXTURE_SET.CLASS_HIGHLIGHT_COLOR[1], TEXTURE_SET.CLASS_HIGHLIGHT_COLOR[2], TEXTURE_SET.CLASS_HIGHLIGHT_COLOR[3], TEXTURE_SET.CLASS_HIGHLIGHT_COLOR[4]);
						classButton:SetPoint("TOPLEFT", side_anchor_up, "TOPLEFT", 0, - (ui_style.tabButtonSize + ui_style.tabButtonGap) * (index - 1));
						classButton:Show();
						classButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
						classButton:SetScript("OnClick", classButton_OnClick);
						classButton:SetScript("OnEnter", Info_OnEnter);
						classButton:SetScript("OnLeave", Info_OnLeave);
						classButton.id = index;
						classButton.class = class;
						classButton.mainFrame = mainFrame;
						local classColorTable = RAID_CLASS_COLORS[class];
						classButton.information = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. L.DATA[class] .. "\124r" .. L.classTabButton;
						classButtons[index] = classButton;
					end
					mainFrame.classButtons = classButtons;

					local curClassIndicator = mainFrame:CreateTexture(nil, "OVERLAY");
					curClassIndicator:SetSize(ui_style.curClassIndicatorSize, ui_style.curClassIndicatorSize);
					curClassIndicator:SetBlendMode("ADD");
					curClassIndicator:SetTexture(TEXTURE_SET.CLASS_INDICATOR);
					curClassIndicator:SetTexCoord(TEXTURE_SET.CLASS_INDICATOR_COORD[1], TEXTURE_SET.CLASS_INDICATOR_COORD[2], TEXTURE_SET.CLASS_INDICATOR_COORD[3], TEXTURE_SET.CLASS_INDICATOR_COORD[4]);
					curClassIndicator:SetVertexColor(TEXTURE_SET.CLASS_INDICATOR_COLOR[1], TEXTURE_SET.CLASS_INDICATOR_COLOR[2], TEXTURE_SET.CLASS_INDICATOR_COLOR[3], TEXTURE_SET.CLASS_INDICATOR_COLOR[4]);
					curClassIndicator:Show();
					mainFrame.objects.curClassIndicator = curClassIndicator;
				end

				local side_anchor_down = CreateFrame("FRAME", nil, mainFrame);
				side_anchor_down:SetWidth(1);
				mainFrame.side_anchor_down = side_anchor_down;
				side_anchor_down:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 2, 0);
				side_anchor_down:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMRIGHT", 2, 0);
				do	-- control
					-- local inspectTargetButton = CreateFrame("BUTTON", nil, side_anchor_down);
					-- inspectTargetButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
					-- inspectTargetButton:SetNormalTexture(TEXTURE_SET.INSPECT);
					-- inspectTargetButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.INSPECT_COLOR[1], TEXTURE_SET.INSPECT_COLOR[2], TEXTURE_SET.INSPECT_COLOR[3], TEXTURE_SET.INSPECT_COLOR[4]);
					-- inspectTargetButton:SetPushedTexture(TEXTURE_SET.INSPECT);
					-- inspectTargetButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					-- inspectTargetButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					-- inspectTargetButton:SetPoint("BOTTOMLEFT", side_anchor_up, "BOTTOMRIGHT", 4, 0);
					-- inspectTargetButton:Show();
					-- inspectTargetButton:SetScript("OnClick", inspectTargetButton_OnClick);
					-- inspectTargetButton:SetScript("OnEnter", Info_OnEnter);
					-- inspectTargetButton:SetScript("OnLeave", Info_OnLeave);
					-- inspectTargetButton.information = L.inspectTargetButton;
					-- mainFrame.inspectTargetButton = inspectTargetButton;

					local spellTabButton = CreateFrame("BUTTON", nil, side_anchor_down);
					spellTabButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
					spellTabButton:SetNormalTexture(TEXTURE_SET.SPELLTAB);
					spellTabButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.SPELLTAB_COORD[1], TEXTURE_SET.SPELLTAB_COORD[2], TEXTURE_SET.SPELLTAB_COORD[3], TEXTURE_SET.SPELLTAB_COORD[4]);
					spellTabButton:SetPushedTexture(TEXTURE_SET.SPELLTAB);
					spellTabButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.SPELLTAB_COORD[1], TEXTURE_SET.SPELLTAB_COORD[2], TEXTURE_SET.SPELLTAB_COORD[3], TEXTURE_SET.SPELLTAB_COORD[4]);
					spellTabButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					spellTabButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					spellTabButton:SetPoint("BOTTOMLEFT", side_anchor_down, "BOTTOMLEFT", 0, 0);
					spellTabButton:Show();
					spellTabButton:SetScript("OnClick", spellTabButton_OnClick);
					spellTabButton:SetScript("OnEnter", Info_OnEnter);
					spellTabButton:SetScript("OnLeave", Info_OnLeave);
					spellTabButton.information = L.spellTabButton;
					spellTabButton.mainFrame = mainFrame;
					mainFrame.spellTabButton = spellTabButton;

					local applyTalentsButton = CreateFrame("BUTTON", nil, side_anchor_down);
					applyTalentsButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
					applyTalentsButton:SetNormalTexture(TEXTURE_SET.APPLY);
					applyTalentsButton:SetPushedTexture(TEXTURE_SET.APPLY);
					applyTalentsButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					applyTalentsButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					applyTalentsButton:SetDisabledTexture(TEXTURE_SET.APPLY);
					applyTalentsButton:GetDisabledTexture():SetVertexColor(TEXTURE_SET.CONTROL_DISABLED_COLOR[1], TEXTURE_SET.CONTROL_DISABLED_COLOR[2], TEXTURE_SET.CONTROL_DISABLED_COLOR[3], TEXTURE_SET.CONTROL_DISABLED_COLOR[4]);
					applyTalentsButton:SetPoint("BOTTOM", spellTabButton, "TOP", 0, ui_style.tabButtonGap);
					applyTalentsButton:Show();
					applyTalentsButton:SetScript("OnClick", applyTalentsButton_OnClick);
					applyTalentsButton:SetScript("OnEnter", Info_OnEnter);
					applyTalentsButton:SetScript("OnLeave", Info_OnLeave);
					applyTalentsButton.information = L.applyTalentsButton;
					applyTalentsButton.mainFrame = mainFrame;
					mainFrame.applyTalentsButton = applyTalentsButton;

					local editBox = CreateFrame("EDITBOX", nil, mainFrame);
					editBox:SetSize(ui_style.editBoxXSize, ui_style.editBoxYSize);
					editBox:SetFontObject(GameFontHighlightSmall);
					editBox:SetAutoFocus(false);
					editBox:SetJustifyH("LEFT");
					editBox:Hide();
					editBox:EnableMouse(true);
					editBox:SetScript("OnEnterPressed", editBox_OnEnterPressed);
					editBox:SetScript("OnEscapePressed", function(self) self:SetText(""); self:ClearFocus(); self:Hide(); end);
					editBox:SetScript("OnShow", function(self) self.type = nil; self.charChanged = nil; end);
					editBox:SetScript("OnHide", function(self) self.type = nil; self.charChanged = nil; end);
					editBox:SetScript("OnChar", function(self) self.charChanged = true; end);
					local texture = editBox:CreateTexture(nil, "ARTWORK");
					texture:SetPoint("TOPLEFT");
					texture:SetPoint("BOTTOMRIGHT");
					texture:SetTexture("Interface\\Buttons\\buttonhilight-square");
					texture:SetTexCoord(0.25, 0.75, 0.25, 0.75);
					texture:SetAlpha(0.36);
					texture:SetVertexColor(1.0, 1.0, 1.0);
					editBox.texture = texture;
					mainFrame.editBox = editBox;
					local editBoxOKButton = CreateFrame("BUTTON", nil, editBox);
					editBoxOKButton:SetSize(ui_style.editBoxYSize, ui_style.editBoxYSize);
					editBoxOKButton:SetNormalTexture(TEXTURE_SET.EDIT_OK);
					editBoxOKButton:SetPushedTexture(TEXTURE_SET.EDIT_OK);
					editBoxOKButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					editBoxOKButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					editBoxOKButton:SetPoint("LEFT", editBox, "RIGHT", 0, 4);
					editBoxOKButton:Show();
					editBoxOKButton:SetScript("OnClick", function(self) editBox_OnEnterPressed(editBox); end);
					editBoxOKButton:SetScript("OnEnter", Info_OnEnter);
					editBoxOKButton:SetScript("OnLeave", Info_OnLeave);
					editBoxOKButton.information = L.editBoxOKButton;
					editBox.OKButton = editBoxOKButton;

					local importButton = CreateFrame("BUTTON", nil, side_anchor_down);
					importButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
					importButton:SetNormalTexture(TEXTURE_SET.IMPORT);
					importButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.IMPORT_COORD[1], TEXTURE_SET.IMPORT_COORD[2], TEXTURE_SET.IMPORT_COORD[3], TEXTURE_SET.IMPORT_COORD[4]);
					importButton:SetPushedTexture(TEXTURE_SET.IMPORT);
					importButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.IMPORT_COORD[1], TEXTURE_SET.IMPORT_COORD[2], TEXTURE_SET.IMPORT_COORD[3], TEXTURE_SET.IMPORT_COORD[4]);
					importButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					importButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					importButton:SetPoint("BOTTOM", applyTalentsButton, "TOP", 0, ui_style.tabButtonGap);
					importButton:Show();
					importButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					importButton:SetScript("OnClick", importButton_OnClick);
					importButton:SetScript("OnEnter", Info_OnEnter);
					importButton:SetScript("OnLeave", Info_OnLeave);
					importButton.information = L.importButton;
					importButton.mainFrame = mainFrame;
					mainFrame.importButton = importButton;

					local exportButton = CreateFrame("BUTTON", nil, side_anchor_down);
					exportButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
					exportButton:SetNormalTexture(TEXTURE_SET.EXPORT);
					exportButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.EXPORT_COORD[1], TEXTURE_SET.EXPORT_COORD[2], TEXTURE_SET.EXPORT_COORD[3], TEXTURE_SET.EXPORT_COORD[4]);
					exportButton:SetPushedTexture(TEXTURE_SET.EXPORT);
					exportButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.EXPORT_COORD[1], TEXTURE_SET.EXPORT_COORD[2], TEXTURE_SET.EXPORT_COORD[3], TEXTURE_SET.EXPORT_COORD[4]);
					exportButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					exportButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					exportButton:SetPoint("BOTTOM", importButton, "TOP", 0, ui_style.tabButtonGap);
					exportButton:Show();
					exportButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					exportButton:SetScript("OnClick", exportButton_OnClick);
					exportButton:SetScript("OnEnter", Info_OnEnter);
					exportButton:SetScript("OnLeave", Info_OnLeave);
					exportButton.information = L.exportButton;
					exportButton.mainFrame = mainFrame;
					mainFrame.exportButton = exportButton;

					local saveButton = CreateFrame("BUTTON", nil, side_anchor_down);
					saveButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
					saveButton:SetNormalTexture(TEXTURE_SET.SAVE);
					saveButton:SetPushedTexture(TEXTURE_SET.SAVE);
					saveButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					saveButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					saveButton:SetPoint("BOTTOM", exportButton, "TOP", 0, ui_style.tabButtonGap);
					saveButton:Show();
					saveButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					saveButton:SetScript("OnClick", saveButton_OnClick);
					saveButton:SetScript("OnEnter", Info_OnEnter);
					saveButton:SetScript("OnLeave", Info_OnLeave);
					saveButton.information = L.saveButton;
					saveButton.mainFrame = mainFrame;
					mainFrame.saveButton = saveButton;

					local sendButton = CreateFrame("BUTTON", nil, side_anchor_down);
					sendButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
					sendButton:SetNormalTexture(TEXTURE_SET.SEND);
					sendButton:SetPushedTexture(TEXTURE_SET.SEND);
					sendButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					sendButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					sendButton:SetPoint("BOTTOM", saveButton, "TOP", 0, ui_style.tabButtonGap);
					sendButton:Show();
					sendButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					sendButton:SetScript("OnClick", sendButton_OnClick);
					sendButton:SetScript("OnEnter", Info_OnEnter);
					sendButton:SetScript("OnLeave", Info_OnLeave);
					sendButton.information = L.sendButton;
					sendButton.mainFrame = mainFrame;
					mainFrame.sendButton = sendButton;
				end

				do	-- left
					local equipmentButton = CreateFrame("BUTTON", nil, mainFrame);
					equipmentButton:SetSize(ui_style.tabButtonSize, ui_style.tabButtonSize);
					equipmentButton:SetNormalTexture(TEXTURE_SET.EQUIPMENT_TEXTURE);
					equipmentButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.EQUIPMENT_TEXTURE_COORD[1], TEXTURE_SET.EQUIPMENT_TEXTURE_COORD[2], TEXTURE_SET.EQUIPMENT_TEXTURE_COORD[3], TEXTURE_SET.EQUIPMENT_TEXTURE_COORD[4]);
					equipmentButton:SetPushedTexture(TEXTURE_SET.EQUIPMENT_TEXTURE);
					equipmentButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.EQUIPMENT_TEXTURE_COORD[1], TEXTURE_SET.EQUIPMENT_TEXTURE_COORD[2], TEXTURE_SET.EQUIPMENT_TEXTURE_COORD[3], TEXTURE_SET.EQUIPMENT_TEXTURE_COORD[4]);
					equipmentButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					equipmentButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
					equipmentButton:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMLEFT", - 2, 0);
					equipmentButton:Hide();
					equipmentButton:SetScript("OnClick", equipmentButton_OnClick);
					equipmentButton:SetScript("OnEnter", Info_OnEnter);
					equipmentButton:SetScript("OnLeave", Info_OnLeave);
					equipmentButton.information = L.equipmentButton;
					mainFrame.objects.equipmentButton = equipmentButton;
				end
			end
			--</side>

		end
	end

	do	-- mainFrame
		local function OnSizeChanged(self, width, height)
			width = self:GetWidth();
			height = self:GetHeight();
			-- BG 0,512;0,360
			local ratio = height / width;
			if ratio > 360 / 512 then
				self.BG:SetTexCoord(0.5 - 180 / 512 / ratio, 0.5 + 180 / 512 / ratio, 0.0, 360 / 512);
			elseif ratio < 360 / 512 then
				self.BG:SetTexCoord(0.0, 1.0, 180 / 512 - ratio / 2, 180 / 512 + ratio / 2);
			else
				self.BG:SetTexCoord(0.0, 1.0, 0.0, 360 / 512);
			end
			NS.talentFrameUpdateSize(self, self.talentFrames, width, height);
			for _, obj in next, self.objects do
				obj:SetScale(self.talentFrameScale);
			end
			self.specButtonsBar:SetScale(self.talentFrameScale);
			self.side_anchor_up:SetScale(self.talentFrameScale);
			self.side_anchor_down:SetScale(self.talentFrameScale);
			self.spellTabFrameContainer:SetWidth(ui_style.spellTabFrameXSize * self.talentFrameScale);
			self.equipmentFrameContainer:SetWidth(ui_style.equipmentFrameXSize * self.talentFrameScale);
			self.spellTabFrame:SetScale(self.talentFrameScale);
			self.spellTabFrame:SetHeight(self:GetHeight() / self.talentFrameScale);
			self.equipmentFrame:SetScale(self.talentFrameScale);
			self.equipmentFrame:SetHeight(self:GetHeight() / self.talentFrameScale);
		end

		local temp_id = 0;
		function NS.CreateMainFrame()
			temp_id = temp_id + 1;
			local mainFrame = CreateFrame("FRAME", nil, UIParent);
			mainFrame.id = temp_id;

			mainFrame:SetPoint("CENTER");
			mainFrame:SetMinResize(ui_style.mainFrameXSizeMin_Style1, ui_style.mainFrameYSizeMin_Style1);
			mainFrame:SetFrameStrata("HIGH");
			if SET.win_style == 'ala' then
				mainFrame:SetBackdrop(ui_style.mainFrameBackdrop);
				mainFrame:SetBackdropColor(ui_style.mainFrameBackdropColor[1], ui_style.mainFrameBackdropColor[2], ui_style.mainFrameBackdropColor[3], ui_style.mainFrameBackdropColor[4]);
				mainFrame:SetBackdropBorderColor(ui_style.mainFrameBackdropBorderColor[1], ui_style.mainFrameBackdropBorderColor[2], ui_style.mainFrameBackdropBorderColor[3], ui_style.mainFrameBackdropBorderColor[4]);
			elseif SET.win_style == 'blz' then
				mainFrame:SetBackdrop(ui_style.mainFrameBackdrop_blz);
				mainFrame:SetBackdropColor(ui_style.mainFrameBackdropColor_blz[1], ui_style.mainFrameBackdropColor_blz[2], ui_style.mainFrameBackdropColor_blz[3], ui_style.mainFrameBackdropColor_blz[4]);
				mainFrame:SetBackdropBorderColor(ui_style.mainFrameBackdropBorderColor_blz[1], ui_style.mainFrameBackdropBorderColor_blz[2], ui_style.mainFrameBackdropBorderColor_blz[3], ui_style.mainFrameBackdropBorderColor_blz[4]);
			end

			if SET.style == 1 then
				mainFrame:SetSize(ui_style.mainFrameXSizeDefault_Style1, ui_style.mainFrameYSizeDefault_Style1);
			elseif SET.style == 2 then
				mainFrame:SetSize(ui_style.mainFrameXSizeDefault_Style2, ui_style.mainFrameYSizeDefault_Style2);
			end

			local BG = mainFrame:CreateTexture(nil, "BORDER");
			BG:SetAlpha(0.6);
			if SET.win_style == 'ala' then
				BG:SetPoint("BOTTOMLEFT");
				BG:SetPoint("TOPRIGHT");
			elseif SET.win_style == 'blz' then
				BG:SetPoint("BOTTOMLEFT", 4, 4);
				BG:SetPoint("TOPRIGHT", - 4, - 4);
			end
			mainFrame.BG = BG;

			mainFrame.talentFrames = NS.CreateTalentFrames(mainFrame);
			mainFrame.spellTabFrame, mainFrame.spellTabFrameContainer = NS.CreateSpellTabFrame(mainFrame);
			mainFrame.equipmentFrame, mainFrame.equipmentContainer, mainFrame.equipmentFrameContainer = NS.CreateEquipmentFrame(mainFrame);

			NS.CreateMainFrameSubObject(mainFrame);

			mainFrame:EnableMouse(true);
			mainFrame:SetMovable(true);
			mainFrame:SetResizable(true);

			mainFrame:Hide();

			mainFrame:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" then
					if SET.resizable_border then
						if not self.isMoving and not self.isResizing and self:IsMovable() then
							local x, y = GetCursorPosition();
							local s = self:GetEffectiveScale();
							x = x / s;
							y = y / s;
							local bottom = self:GetBottom();
							local top = self:GetTop();
							local left = self:GetLeft();
							local right = self:GetRight();

							if x < left + ui_style.mainFrameBorderSize then
								if y < bottom + ui_style.mainFrameBorderSize then
									self:StartSizing("BOTTOMLEFT");
								elseif y > top - ui_style.mainFrameBorderSize then
									self:StartSizing("TOPLEFT");
								else
									self:StartSizing("LEFT");
								end
								self.isResizing = true;
							elseif x > right - ui_style.mainFrameBorderSize then
								if y < bottom + ui_style.mainFrameBorderSize then
									self:StartSizing("BOTTOMRIGHT");
								elseif y > top - ui_style.mainFrameBorderSize then
									self:StartSizing("TOPRIGHT");
								else
									self:StartSizing("RIGHT");
								end
								self.isResizing = true;
							elseif y < bottom + ui_style.mainFrameBorderSize then
								self:StartSizing("BOTTOM");
								self.isResizing = true;
							elseif y > top - ui_style.mainFrameBorderSize then
								self:StartSizing("TOP");
								self.isResizing = true;
							else
								self:StartMoving();
								self.isMoving = true;
							end
						end
					else
						self:StartMoving();
						self.isMoving = true;
					end
				end
			end);
			mainFrame:SetScript("OnMouseUp", function(self, button)
				if button == "LeftButton" then
					if self.isMoving then
						self:StopMovingOrSizing()
						self.isMoving = false
					elseif self.isResizing then
						self:StopMovingOrSizing()
						self.isResizing = false
					end
				end
			end);
			mainFrame:SetScript("OnSizeChanged", OnSizeChanged);
			mainFrame:SetScript("OnShow", function(self)
					OnSizeChanged(self, self:GetWidth(), self:GetHeight());
				end
			);
			mainFrame:SetScript("OnHide", function(self)
					NS.Emu_DestroyMainFrame(self);
					if self.isMoving then
						self:StopMovingOrSizing();
						self.isMoving = false;
					end
					if self.isResizing then
						self:StopMovingOrSizing();
						self.isResizing = false;
					end
					if NS.tooltipFrame.owner == self then
						NS.tooltipFrame:Hide();
					end
				end
			);

			mainFrame.curTab = 1;
			NS.EmuCore_SetName(mainFrame, nil);
			NS.EmuCore_SetLevel(mainFrame, nil);
			NS.EmuCore_SetClass(mainFrame, NS.playerClassUpper);
			NS.EmuCore_SetData(mainFrame, nil);
			NS.EmuCore_SetReadOnly(mainFrame, false);
			mainFrame.initialized = false;

			NS.mainFrameSetStyle(mainFrame, SET.style);

			return mainFrame;
		end

		function NS.winMan_GetWin(winId)
			local mainFrames = NS.mainFrames;
			local mainFrame = nil;
			if winId then
				if winId >= temp_id then
					for i = 1, mainFrames.num do
						if mainFrames[i].id == winId then
							mainFrame = mainFrames[i];
							if not mainFrame:IsShown() then
								mainFrames.used = mainFrames.used + 1;
							end
							break;
						end
					end
				else
				end
			end
			if not mainFrame then
				if mainFrames.num > mainFrames.used then
					mainFrames.used = mainFrames.used + 1;
					mainFrame = mainFrames[mainFrames.used];
				else
					mainFrames.num = mainFrames.num + 1;
					mainFrames[mainFrames.num] = NS.CreateMainFrame();
					mainFrames.used = mainFrames.num;
					mainFrame = mainFrames[mainFrames.used];
				end
			end
			mainFrame:Show();
			return mainFrame;
		end
		function NS.winMan_GetLastWin()
			local mainFrames = NS.mainFrames;
			return mainFrames.used > 0 and mainFrames[mainFrames.used] or nil;
		end
		function NS.winMan_RelWin(winId)
			local mainFrames = NS.mainFrames;
			if mainFrames.used <= 0 then
				return;
			end
			for i = mainFrames.used, 1, -1 do
				local mainFrame = mainFrames[i];
				if winId == mainFrame.id then
					if i ~= mainFrames.used then
						tremove(mainFrames, i);
						tinsert(mainFrames, mainFrames.used, mainFrame);
					end
					mainFrames.used = mainFrames.used - 1;
					if mainFrame:IsShown() then
						mainFrame:Hide();
					end
					NS.winMan_RelSpecializedName(mainFrame);
					NS.EmuCore_Reset(mainFrame);
					break;
				end
			end
		end
		function NS.winMan_RelAllBut(...)	-- TODO
			if true then
				_error_("ERROR", "Donot use this");
				return;
			end
			local mainFrames = NS.mainFrames;
			local n = select("#", ...);
			if n == 0 then
				for i = 1, mainFrames.used do
					mainFrames[i]:Hide();
				end
				mainFrames.used = 0;
			elseif n == 1 then
				NS.winMan_RelAllButOne(...);
			else
				for i = 1, mainFrames.used do
					mainFrames[i]:Hide();
				end
			end
		end
		function NS.winMan_RelAllButOne(id)
			local mainFrames = NS.mainFrames;
			for i = mainFrames.used, 1, -1 do
				local mainFrame = mainFrames[i];
				if mainFrame.id ~= id then
					mainFrame:Hide();
				end
			end
			if mainFrames.used == 1 then
				NS.winMan_SetWinId(mainFrames[1], 1);
			elseif mainFrames.used > 1 then
				_error_("Emu Warn >> RelAllButOne", "USED NEQ 1, IS", mainFrames.used);
			end
		end
		function NS.winMan_IsAllSameStyle()
			local style = -1;
			local mainFrames = NS.mainFrames;
			for i = 1, mainFrames.used do
				local mainFrame = mainFrames[i];
				if mainFrame.style ~= style then
					if style == -1 then
						style = mainFrame.style;
					else
						style = nil;
						break;
					end
				end
			end
			return style;
		end
		function NS.winMan_SetWinId(mainFrame, winId)
			if mainFrame.id == winId then
				return;
			end
			local mainFrames = NS.mainFrames;
			local index = nil;
			for i = 1, mainFrames.num do
				local mainFrame = mainFrames[i];
				if mainFrame.id == winId then
					index = i;
					break;
				end
			end
			if index then
				local rawId = mainFrame.id;
				mainFrame.id = winId;
				mainFrames[index].id = rawId;
			end
		end
		function NS.hideMainFrame(winId)
			if type(winId) == 'table' then
				winId:Hide();
			elseif type(winId) == 'number' then
				local mainFrames = NS.mainFrames;
				for i = mainFrames.used, 1, -1 do
					local mainFrame = mainFrames[i];
					if mainFrame.id == winId then
						mainFrame:Hide();
						break;
					end
				end
			end
		end
		function NS.winMan_RelSpecializedName(mainFrame)
			if mainFrame then
				if type(mainFrame) == 'number' then
					mainFrame = NS.winMan_GetWin(mainFrame);
					if not mainFrame then
						return;
					end
				end
				for name, v in next, NS.specializedMainFrameInspect do
					if #v == 2 then
						if mainFrame == v[2] then
							NS.specializedMainFrameInspect[name] = nil;
						end
					elseif #v > 2 then
						for i = #v, 2, -1 do
							if mainFrame == v[i] then
								tremove(v, i);
							end
						end
						if #v < 2 then
							NS.specializedMainFrameInspect[name] = nil;
						end
					else
						NS.specializedMainFrameInspect[name] = nil;
					end
				end
			end
		end
		function NS.winMan_SetSpecializedName(mainFrame, name)
			if NS.specializedMainFrameInspect[name] then
				local v = NS.specializedMainFrameInspect[name];
				if #v >= 2 then
					local found = false;
					for i = 2, #v do
						if mainFrame == v[i] then
							found = true;
						end
					end
					if not found then
						tinsert(v, mainFrame);
					end
				else
					NS.specializedMainFrameInspect[name] = nil;
				end
				return;
			end
			for n, v in next, NS.specializedMainFrameInspect do
				if #v == 2 then
					if mainFrame == v[2] then
						NS.specializedMainFrameInspect[n] = nil;
					end
				elseif #v > 2 then
					for i = #v, 2, -1 do
						if mainFrame == v[i] then
							tremove(v, i);
						end
					end
					if #v < 2 then
						NS.specializedMainFrameInspect[name] = nil;
					end
				else
					NS.specializedMainFrameInspect[name] = nil;
				end
			end
			NS.specializedMainFrameInspect[name] = { GetTime(), mainFrame, };
		end
		function NS.winMan_GetSpecializedMeta(name)
			return NS.specializedMainFrameInspect[name];
		end
		function NS.winMan_SetStyle(win_style)
			if win_style == 'ala' then
				for i = 1, NS.mainFrames.num do
					local mainFrame = NS.mainFrames[i];
					mainFrame:SetBackdrop(ui_style.mainFrameBackdrop);
					mainFrame:SetBackdropColor(ui_style.mainFrameBackdropColor[1], ui_style.mainFrameBackdropColor[2], ui_style.mainFrameBackdropColor[3], ui_style.mainFrameBackdropColor[4]);
					mainFrame:SetBackdropBorderColor(ui_style.mainFrameBackdropBorderColor[1], ui_style.mainFrameBackdropBorderColor[2], ui_style.mainFrameBackdropBorderColor[3], ui_style.mainFrameBackdropBorderColor[4]);
					mainFrame.BG:ClearAllPoints();
					mainFrame.BG:SetPoint("BOTTOMLEFT");
					mainFrame.BG:SetPoint("TOPRIGHT");
					mainFrame.equipmentFrameContainer:SetBackdrop(ui_style.equipmentFrameBackdrop);
					mainFrame.equipmentFrameContainer:SetBackdropColor(unpack(ui_style.equipmentFrameBackdropColor));
					mainFrame.equipmentFrameContainer:SetBackdropBorderColor(unpack(ui_style.equipmentFrameBackdropBorderColor));
					mainFrame.spellTabFrameContainer:SetBackdrop(ui_style.spellTabFrameBackdrop);
					mainFrame.spellTabFrameContainer:SetBackdropColor(unpack(ui_style.spellTabFrameBackdropColor));
					mainFrame.spellTabFrameContainer:SetBackdropBorderColor(unpack(ui_style.spellTabFrameBackdropBorderColor));
				end
			elseif win_style == 'blz' then
				for i = 1, NS.mainFrames.num do
					local mainFrame = NS.mainFrames[i];
					mainFrame:SetBackdrop(ui_style.mainFrameBackdrop_blz);
					mainFrame:SetBackdropColor(ui_style.mainFrameBackdropColor_blz[1], ui_style.mainFrameBackdropColor_blz[2], ui_style.mainFrameBackdropColor_blz[3], ui_style.mainFrameBackdropColor_blz[4]);
					mainFrame:SetBackdropBorderColor(ui_style.mainFrameBackdropBorderColor_blz[1], ui_style.mainFrameBackdropBorderColor_blz[2], ui_style.mainFrameBackdropBorderColor_blz[3], ui_style.mainFrameBackdropBorderColor_blz[4]);
					mainFrame.BG:ClearAllPoints();
					mainFrame.BG:SetPoint("BOTTOMLEFT", 4, 4);
					mainFrame.BG:SetPoint("TOPRIGHT", - 4, - 4);
					mainFrame.equipmentFrameContainer:SetBackdrop(ui_style.equipmentFrameBackdrop_blz);
					mainFrame.equipmentFrameContainer:SetBackdropColor(unpack(ui_style.equipmentFrameBackdropColor_blz));
					mainFrame.equipmentFrameContainer:SetBackdropBorderColor(unpack(ui_style.equipmentFrameBackdropBorderColor_blz));
					mainFrame.spellTabFrameContainer:SetBackdrop(ui_style.spellTabFrameBackdrop_blz);
					mainFrame.spellTabFrameContainer:SetBackdropColor(unpack(ui_style.spellTabFrameBackdropColor_blz));
					mainFrame.spellTabFrameContainer:SetBackdropBorderColor(unpack(ui_style.spellTabFrameBackdropBorderColor_blz));
				end
			end
		end
		function NS.winMan_Iterator(func)
			local mainFrames = NS.mainFrames;
			for i = mainFrames.used, 1, -1 do
				func(mainFrames[i]);
			end
		end
	end
-->		UI>

do	-- raid_tool
	local enchant_hash = {	--	[enchant] = spell	--	13503, 13693, 20031
		INVTYPE_HEAD = {
			[1483] = 15340,
			[1503] = 15389,
			[1504] = 15391,
			[1505] = 15394,
			[1506] = 15397,
			[1507] = 15400,
			[1508] = 15402,
			[1509] = 15404,
			[1510] = 15406,
			[2543] = 22840,
			[2544] = 22844,
			[2545] = 22846,
			[2583] = 24149,
			[2584] = 24160,
			[2585] = 24161,
			[2586] = 24162,
			[2587] = 24163,
			[2588] = 24164,
			[2589] = 24165,
			[2590] = 24167,
			[2591] = 24168,
			[2681] = 28161,
			[2682] = 28163,
			[2683] = 28165,
			[1523] = 15427,		--	unknow
			[1524] = 15429,		--	unknow
			[1525] = 15439,		--	unknow
			[1526] = 15441,		--	unknow
			[1527] = 15444,		--	unknow
			[1528] = 15446,		--	unknow
			[1529] = 15449,		--	unknow
			[1530] = 15458,		--	unknow
			[1532] = 15463,		--	unknow
			[1543] = 15490,		--	unknow
		},
		INVTYPE_SHOULDER = {
			[2483] = 22593,
			[2484] = 22594,
			[2485] = 22598,
			[2486] = 22597,
			[2487] = 22596,
			[2488] = 22599,
			--
			[2605] = 24421,
			[2606] = 24422,
			[2604] = 24420,
			--
			[2721] = 29467,
			[2715] = 29475,
			[2717] = 29483,
			[2716] = 29480,
			--
			[3755] = 24161,		--	unk
			[3754] = 24162,		--	unk
		},
		INVTYPE_CHEST = {		--	chest
			[850] = 13640,
			[928] = 13941,
			[913] = 13917,
			[1891] = 20025,
			[1503] = 20026,
			[1892] = 20026,
			[1893] = 20028,
			[41] = 7420,
			[44] = 7426,
			[242] = 7748,
			[246] = 7776,
			[254] = 7857,
			[843] = 13607,
			[908] = 13858,
			[24] = 7443,
			[847] = 13626,
			[63] = 13538,
			[866] = 13700,
			[857] = 13663,
			[15] = 2831,
			[16] = 2832,
			[17] = 2833,
			[18] = 10344,
			[1843] = 19057,
			[2503] = 22725,
		},
		INVTYPE_LEGS = {
			[15] = 2831,
			[16] = 2832,
			[17] = 2833,
			[18] = 10344,
			[1843] = 19057,
			[2503] = 22725,
			[1483] = 15340,
			[1503] = 15389,
			[1504] = 15391,
			[1505] = 15394,
			[1506] = 15397,
			[1507] = 15400,
			[1508] = 15402,
			[1509] = 15404,
			[1510] = 15406,
			[2543] = 22840,
			[2544] = 22844,
			[2545] = 22846,
			[2583] = 24149,
			[2584] = 24160,
			[2585] = 24161,
			[2586] = 24162,
			[2587] = 24163,
			[2588] = 24164,
			[2589] = 24165,
			[2590] = 24167,
			[2591] = 24168,
			[2681] = 28161,
			[2682] = 28163,
			[2683] = 28165,
			[1523] = 15427,		--	unknow
			[1524] = 15429,		--	unknow
			[1525] = 15439,		--	unknow
			[1526] = 15441,		--	unknow
			[1527] = 15444,		--	unknow
			[1528] = 15446,		--	unknow
			[1529] = 15449,		--	unknow
			[1530] = 15458,		--	unknow
			[1532] = 15463,		--	unknow
			[1543] = 15490,		--	unknow
		},
		INVTYPE_FEET = {		--	boot
			[255] = 13687,
			[849] = 13637,
			[91] = 13935,
			[93] = 20023,
			[64] = 13687,
			[66] = 7863,
			[99] = 20024,
			[103] = 13836,
			[105] = 20020,
			[76] = 13637,
			[84] = 13687,
			[904] = 13935,
			[851] = 20024,
			[852] = 13836,
			[74] = 7867,
			[71] = 7863,
			[73] = 13644,
			[929] = 20020,
			[911] = 13890,
			[247] = 7867,
			[724] = 13644,
			[1887] = 20023,
			[464] = 9783,
			[15] = 2831,
			[16] = 2832,
			[17] = 2833,
			[18] = 10344,
			[1843] = 19057,
			[2503] = 22725,
			-->
			[4726] = 13687,
		},
		INVTYPE_WRIST = {		--	wrist
			[1884] = 20009,
			[355] = 20009,
			[1903] = 20009,
			[1886] = 20011,
			[356] = 20011,
			[2698] = 20011,
			[107] = 13661,
			[856] = 13661,
			[95] = 13822,
			[905] = 13822,
			[101] = 13846,
			[907] = 13846,
			[74] = 7779,
			[247] = 7779,
			[4725] = 7779,
			[73] = 13501,
			[724] = 13501,
			[4730] = 13501,
			[103] = 13648,
			[852] = 13648,
			[4737] = 13648,
			-- [112] = 13931,
			[923] = 13931,
			-- [925] = 13931,
			-- [924] = 13646,
			[925] = 13646,
			[111] = 13646,
			[105] = 13945,
			[929] = 13945,
			[4743] = 13945,
			[81] = 13622,
			[723] = 13622,
			[4729] = 13622,
			[97] = 20008,
			[1883] = 20008,
			[66] = 7457,
			[71] = 7457,
			[4721] = 7457,
			[82] = 7766,
			[243] = 7766,
			[70] = 13536,
			[823] = 13536,
			[357] = 20010,
			[1885] = 20010,
			[99] = 13642,
			[851] = 13642,
			[4735] = 13642,
			[68] = 7782,
			[248] = 7782,
			[64] = 7859,
			[84] = 7859,
			[255] = 7859,
			[4727] = 7859,
			[109] = 13939,
			[927] = 13939,
			[110] = 7428,
			[924] = 7428,
			[2371] = 23801,
			[2372] = 23801,
			[2373] = 23801,
			[2565] = 23801,
			[41] = 7418,
			[4720] = 7418,
			[2566] = 23802,		--	24heal		>>	13sp	--	current
			[2608] = 23802,		--	24heal		>>	13sp
			[2319] = 23802,		--	24heal		>>	15sp
			[2609] = 23802,		--	24heal		>>	15sp
			[2650] = 23802,		--	24heal		>>	15sp
		},
		INVTYPE_HAND = {	--	gloves
			[2615] = 25074,
			[2617] = 25079,
			[865] = 13698,
			[91] = 13815,
			[93] = 20012,
			[883] = 25080,
			[930] = 13947,
			[2168] = 25078,
			[931] = 13948,
			[107] = 13887,
			[109] = 20013,
			[846] = 13620,
			[856] = 13887,
			[2244] = 25074,
			[2618] = 25080,
			[904] = 13815,
			[2616] = 25078,
			[927] = 20013,
			[2564] = 25080,
			[906] = 13841,
			[2320] = 25079,
			[845] = 13617,
			[1887] = 20012,
			[2543] = 13948,
			[2614] = 25073,
			[909] = 13868,
			[2130] = 25073,
			[2613] = 25072,
			[844] = 13612,
			[15] = 2831,
			[16] = 2832,
			[17] = 2833,
			[18] = 10344,
			[1843] = 19057,
			[2503] = 22725,
			-->
			[4740] = 13815,
			[4742] = 20013,
			[2603] = 13620,
			[4739] = 13887,
		},
		INVTYPE_CLOAK = {	--	cloak
			[1888] = 20014,
			[1341] = 13657,
			[1349] = 25081,
			[2619] = 25081,
			[247] = 13419,
			[848] = 13635,
			[1436] = 13522,
			[1889] = 20015,
			[2620] = 25082,
			[2463] = 13657,
			[744] = 13421,
			[65] = 7454,
			[2621] = 25084,
			[2078] = 25086,
			[884] = 13746,
			[2488] = 20014,
			[2622] = 25086,
			[1339] = 7861,
			[910] = 25083,
			[849] = 13882,
			[855] = 7861,
			[2545] = 25086,
			[1395] = 25082,
			[804] = 13522,
			[903] = 13794,
			[2483] = 7861,
			[2683] = 13522,
			[256] = 7861,
			[257] = 7771,
			[121] = 13421,
			[74] = 13419,
			[76] = 13882,
			[783] = 7771,
			-->
			[4724] = 13419,
			[4734] = 13882,
		},
		INVTYPE_WEAPON = {	--	weapon
			---->		1h		<----
			[883] = 23800,
			[2564] = 23800,
			[2618] = 23800,
			[684] = 23799,
			[2563] = 23799,
			[1900] = 20034,
			[78] = 13693,
			[1125] = 23804,
			[2568] = 23804,
			[67] = 7788,
			[250] = 7788,
			[188] = 7786,
			[864] = 13943,
			[117] = 13943,
			[805] = 13943,
			[1149] = 23803,
			[2567] = 23803,
			[190] = 13653,
			[231] = 21931,
			[2235] = 21931,
			[2443] = 21931,
			[1894] = 20029,
			[2331] = 22750,
			[2505] = 22750,
			[2332] = 22749,
			[2504] = 22749,
			[803] = 13898,
			[1898] = 20032,
			[854] = 13655,
			[912] = 13915,
			[1899] = 20033,
			--	conflicted with 2h
			[77] = 13503,
			[241] = 13503,
			[118] = 20031,
			[1897] = 20031,
			[943] = 13693,
			[34] = 7218,
			[36] = 6296,
			[37] = 7220,
			-->
			[853] = 13653,
			[4745] = 13693,
			[249] = 7786,
		},
		INVTYPE_2HWEAPON = {
			---->		2h		<----
			[2646] = 27837,
			[1102] = 27837,
			[120] = 13937,
			[963] = 13937,
			[1895] = 20030,
			[1896] = 20030,
			[354] = 20036,
			[1901] = 20036,
			[1904] = 20036,
			[81] = 7793,
			[723] = 7793,
			[78] = 13529,
			--	conflicted with 1h
			[77] = 7745,
			[241] = 7745,
			[118] = 13695,
			[1897] = 13695,
			[943] = 13529,
			--	confilicted with shield
			[64] = 13380,
			[84] = 13380,
			[255] = 13380,
			[355] = 20035,
			[1884] = 20035,
			[1903] = 20035,
			--	>>
			[4723] = 7745,
		},
		INVTYPE_SHIELD = {	--	oh	--	SHIELD
			[926] = 13933,
			[1296] = 13933,
			[99] = 13659,
			[851] = 13659,
			[66] = 13378,
			[71] = 13378,
			[101] = 13905,
			[907] = 13905,
			[103] = 13817,
			[852] = 13817,
			[105] = 20017,
			[929] = 20017,
			[848] = 13464,
			[73] = 13631,
			[724] = 13631,
			[863] = 13689,
			--	conflicted with weapon
			[64] = 13485,
			[84] = 13485,
			[255] = 13485,
			[355] = 20016,
			[1884] = 20016,
			[1903] = 20016,
			[43] = 7216,
			[463] = 9781,
			[1704] = 16623,
			-->
			[4741] = 13905,
			[4738] = 13817,
			[4744] = 20017,
			[1890] = 20016,
			[4733] = 13464,
			[4736] = 13659,
			[4731] = 13631,
			[4722] = 13378,
			[4728] = 13485,
		},
		INVTYPE_RANGED = {
			class = "HUNTER",
			[30] = 3974,
			[32] = 3975,
			[33] = 3976,
			[663] = 12459,
			[664] = 12460,
			[2523] = 22779,
		},
	};
		for eid, sid in pairs(enchant_hash.INVTYPE_WEAPON) do
			if enchant_hash.INVTYPE_2HWEAPON[eid] == nil then
				enchant_hash.INVTYPE_2HWEAPON[eid] = sid;
			end
		end
		enchant_hash.INVTYPE_ROBE = enchant_hash.INVTYPE_CHEST;
		enchant_hash.INVTYPE_WEAPONMAINHAND = enchant_hash.INVTYPE_WEAPON;
		enchant_hash.INVTYPE_WEAPONOFFHAND = enchant_hash.INVTYPE_WEAPON;
		enchant_hash.INVTYPE_RANGEDRIGHT = enchant_hash.INVTYPE_RANGED;
	local IGNORE_SLOT18 = {
		DRUID = 1,
		PALADIN = 1,
		SHAMAN = 1,
	};
	--
	local function calcItemLevel(class, cache)
		local slots = { 1, 2, 3, 5, 6, 7, 8,9, 10, 11, 12, 13, 14, 15, };
		if class ~= "DRUID" and class ~= "PALADIN" and class ~= "SHAMAN" then
			tinsert(slots, 18);
		end
		tinsert(slots, 16);
		tinsert(slots, 17);		--	make it the last in table
		--	16MainHand, 17OffHand, 18Ranged
		local refresh_again = false;
		local total = 0;
		local num1, num2 = 0, 0;
		for index = 1, #slots do
			local slot = slots[index];
			local item = cache[slot];
			if item ~= nil and item ~= "" then
				local _, _, _, level, _, _, _, _, loc = GetItemInfo(item);
				if level then
					total = total + level;
					num2 = num2 + 1;
				else
					refresh_again = true;
				end
				if slots == 16 and loc == "INVTYPE_2HWEAPON" then
					break;
				end
			end
			num1 = num1 + 1;
		end
		if num1 == 0 or num2 == 0 then
			return;
		end
		return total / num1, total / num2, refresh_again;
	end
	local function get_enchant_info(class, slot, item)
		local _, link, _, level, _, _, _, _, loc = GetItemInfo(item);
		local hash = enchant_hash[loc];
		if hash and (hash.class == class or hash.class == nil) then
			local _, _, id, enchantId = strfind(item, "item:(%d+):(%d+):")
			enchantId = tonumber(enchantId);
			if enchantId then
				local enchant = hash[enchantId];
				if enchant then
					return true, true, link or ("item:" .. id), GetSpellInfo(enchant) or ("spell: " .. enchant);
				else
					return true, true, link or ("item:" .. id), "enchant: " .. enchantId;
				end
			else
				return true, false, link or item;
			end
		else
			return false, false, link or item;
		end
	end
	local function summary_items(class, cache)
		if cache then
			local missItems, missEnchants, items, enchants = 0, 0, 0, 0;
			for slot = 1, 18 do
				if slot ~= 4 then
					local item = cache[slot];
					if item then
						items = items + 1;
						local enchantable, enchanted, link, str = get_enchant_info(class, slot, item);
						if enchantable then
							if enchanted then
								enchants = enchants + 1;
							else
								missEnchants = missEnchants + 1;
							end
						end
					else
						if slot == 17 and cache[16] then
							local _, _, _, _, _, _, _, _, loc = GetItemInfo(cache[16]);
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
			return missItems, missEnchants, items, enchants;
		end
	end
	local function listButton_OnEnter(self)
		local data_index = self:GetDataIndex();
		local meta = self.meta;
		local rosterList = meta[2];
		if data_index <= #rosterList then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			local name = rosterList[data_index];
			local queryCache = meta[1];
			local rosterInfo = meta[3];
			local class = rosterInfo[name][1];
			local cache = queryCache[name];
			if class == nil and cache then
				class = cache.class;
			end
			if class then
				local color = RAID_CLASS_COLORS[class];
				GameTooltip:SetText(format("\124cff%.2x%.2x%.2x", color.r * 255, color.g * 255, color.b * 255) .. rosterList[data_index] .. "\124r");
			else
				GameTooltip:SetText(rosterList[data_index]);
			end
			if cache then
				for slot = 1, 18 do
					if slot ~= 4 then
						local item = cache[slot];
						if item then
							local enchantable, enchanted, link, str = get_enchant_info(class, slot, item);
							if enchantable then
								if enchanted then
									GameTooltip:AddDoubleLine(L.SLOT[slot] .. link, str);
								else
									GameTooltip:AddDoubleLine(L.SLOT[slot] .. link, L.MISS_ENCHANT);
								end
							else
								GameTooltip:AddLine(L.SLOT[slot] .. link);
							end
						else
							if slot == 17 and cache[16] then
								local _, _, _, _, _, _, _, _, loc = GetItemInfo(cache[16]);
								if loc == "INVTYPE_2HWEAPON" then
									GameTooltip:AddLine(L.SLOT[slot] .. "-");
								else
									GameTooltip:AddLine(L.SLOT[slot] .. L.EMTPY_SLOT);
								end
							elseif slot == 18 and IGNORE_SLOT18[class] then
								GameTooltip:AddLine(L.SLOT[slot] .. "-");
							else
								GameTooltip:AddLine(L.SLOT[slot] .. L.EMTPY_SLOT);
							end
						end
					end
				end
			end
			GameTooltip:Show();
		end
	end
	local function listButton_OnLeave(self)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide();
		end
	end
	local function listButton_OnClick(self)
	end
	local function funcToCreateButton(parent, index, buttonHeight)
		local button = CreateFrame("BUTTON", nil, parent);
		button:SetHeight(buttonHeight);
		button:SetBackdrop(ui_style.spellTabFrameButtonBackdrop);
		button:SetBackdropColor(unpack(ui_style.spellTabFrameButtonBackdropColor));
		button:SetBackdropBorderColor(unpack(ui_style.spellTabFrameButtonBackdropBorderColor));
		button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
		button:EnableMouse(true);
		button:Show();

		local icon = button:CreateTexture(nil, "OVERLAY");
		icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
		icon:SetSize(buttonHeight - 4, buttonHeight - 4);
		icon:SetPoint("LEFT", 4, 0);
		icon:SetTexture(TEXTURE_SET.CLASS);
		button.icon = icon;

		local title = button:CreateFontString(nil, "OVERLAY");
		title:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
		title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
		title:SetJustifyH("LEFT");
		title:SetWidth(136);
		title:SetMaxLines(1);
		button.title = title;

		local specs = {  };
		for specIndex = 1, 3 do
			local spec = button:CreateTexture(nil, "OVERLAY");
			spec:SetSize(buttonHeight - 4, buttonHeight - 4);
			local specLabel = button:CreateFontString(nil, "OVERLAY");
			specLabel:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
			specLabel:SetPoint("LEFT", spec, "RIGHT", 4, 0);
			specLabel:SetJustifyH("LEFT");
			spec.label = specLabel;
			specs[specIndex] = spec;
		end
		specs[1]:SetPoint("LEFT", button, "LEFT", 160, 0);
		specs[2]:SetPoint("LEFT", specs[1], "RIGHT", 24, 0);
		specs[3]:SetPoint("LEFT", specs[2], "RIGHT", 24, 0);
		button.specs = specs;

		local itemLevel = button:CreateFontString(nil, "OVERLAY");
		itemLevel:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
		itemLevel:SetPoint("LEFT", specs[3], "RIGHT", 36, 0);
		button.itemLevel = itemLevel;

		local missItem = button:CreateFontString(nil, "OVERLAY");
		missItem:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
		missItem:SetPoint("LEFT", itemLevel, "LEFT", 36, 0);
		button.missItem = missItem;

		local missEnchant = button:CreateFontString(nil, "OVERLAY");
		missEnchant:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
		missEnchant:SetPoint("LEFT", missItem, "LEFT", 60, 0);
		button.missEnchant = missEnchant;

		local dbm = button:CreateFontString(nil, "OVERLAY");
		dbm:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
		dbm:SetPoint("LEFT", missEnchant, "LEFT", 60, 0);
		dbm:SetWidth(120);
		dbm:SetMaxLines(1);
		button.dbm = dbm;

		button:SetScript("OnEnter", listButton_OnEnter);
		button:SetScript("OnLeave", listButton_OnLeave);
		button:SetScript("OnClick", listButton_OnClick);

		local frame = parent:GetParent():GetParent();
		button.frame = frame;
		button.meta = frame.meta;

		return button;
	end
	local function functToSetButton(button, data_index)
		local meta = button.meta;
		local rosterList = meta[2];
		if data_index <= #rosterList then
			local queryCache = meta[1];
			local rosterInfo = meta[3];
			local name = rosterList[data_index];
			local cache = queryCache[name];
			local info = rosterInfo[name];
			local class = info[1] or (cache and cache.class);
			local level = info[2] or (cache and cache.level);
			if level then
				button.title:SetText(format("%2d: ", level) .. name);
			else
				button.title:SetText("**: " .. name);
			end
			if class then
				local color = RAID_CLASS_COLORS[class];
				button.title:SetVertexColor(color.r, color.g, color.b, 1.0);
				local coord = CLASS_ICON_TCOORDS[class];
				if coord then
					button.icon:SetTexCoord(coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256);
				else
					button.icon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
				end
			else
				button.title:SetVertexColor(1.0, 1.0, 1.0, 1.0);
				button.icon:SetTexCoord(0.75, 1.00, 0.75, 1.00);
			end
			if class and cache then
				if cache.data then
					local stats = { NS.EmuCore_StatPoints(cache.data, class) };
					local specs = button.specs;
					local talentRef = _classTalent[class];
					for specIndex = 1, 3 do
						local spec = specs[specIndex];
						local specId = talentRef[specIndex];
						spec:SetTexture(_talentTabIcon[specId] or TEXTURE_SET.UNK);
						spec.label:SetText(stats[specIndex]);
					end
				else
					local specs = button.specs;
					for specIndex = 1, 3 do
						local spec = specs[specIndex];
						spec:SetTexture(TEXTURE_SET.UNK);
						spec.label:SetText("*");
					end
				end
				local itemLevel1, itemLevel2, refresh_again = calcItemLevel(class, cache);
				if itemLevel1 then
					button.itemLevel:SetText(format("%.1f", itemLevel1));
				else
					button.itemLevel:SetText(nil);
				end
				if refresh_again then
					_EventHandler:run_on_next_tick(frame.update_scroll);
				end
				local missItems, missEnchants, items, enchants = summary_items(class, cache);
				if missItems then
					if missItems > 0 then
						button.missItem:SetText(" \124cff00ff00" .. items .. "\124r / \124cffff0000-" .. missItems .. "\124r");
					else
						button.missItem:SetText(" \124cff00ff00" .. items .. "\124r");
					end
					if missEnchants > 0 then
						button.missEnchant:SetText(" \124cff00ff00" .. enchants .. "\124r / \124cffff0000-" .. missEnchants .. "\124r");
					else
						button.missEnchant:SetText(" \124cff00ff00" .. enchants .. "\124r");
					end
				else
					button.missItem:SetText(nil);
					button.missEnchant:SetText(nil);
				end
			else
				local specs = button.specs;
				for specIndex = 1, 3 do
					local spec = specs[specIndex];
					spec:SetTexture(TEXTURE_SET.UNK);
					spec.label:SetText("*");
				end
				button.itemLevel:SetText(nil);
				button.missItem:SetText(nil);
				button.missEnchant:SetText(nil);
			end
			local dbm = NS.extern.addon["D4C"].list[name] or NS.extern.addon["BigWigs"].list[name];
			if dbm then
				button.dbm:SetText(dbm[1]);
			else
				button.dbm:SetText(nil);
			end
			button:Show();
			if GetMouseFocus() == button then
				listButton_OnEnter(button);
			end
		else
			button:Hide();
		end
	end
	function NS.CreateRaidToolUI()
		--	frame
			local frame = CreateFrame("FRAME", "ALA_RAID_TOOL_UI", UIParent);
			tinsert(UISpecialFrames, "ALA_RAID_TOOL_UI");
			frame:SetBackdrop(ui_style.mainFrameBackdrop);
			frame:SetBackdropColor(ui_style.mainFrameBackdropColor);
			frame:SetBackdropBorderColor(ui_style.mainFrameBackdropBorderColor);
			frame:SetSize(ui_style.raidToolUIFrameXSize, ui_style.raidToolUIFrameYSize);
			frame:SetFrameStrata("HIGH");
			frame:SetPoint("CENTER", 0, 0);
			frame:EnableMouse(true);
			frame:SetMovable(true);
			frame:RegisterForDrag("LeftButton");
			frame:SetScript("OnDragStart", function(self)
				self:StartMoving();
			end);
			frame:SetScript("OnDragStop", function(self)
				self:StopMovingOrSizing();
			end);
			frame:SetScript("OnShow", function(self)
				if self.guild then
					GuildRoster();
				end
				frame.update_func();
			end);
			frame:Hide();
			local rosterList = {  };
			local rosterInfo = {  };
			frame.meta = { NS.queryCache, rosterList, rosterInfo, };
			--[[
				{ queryCache, list, info }
				queryCache[name] = { [time], [talent], [class], [data], [level], [slot(%d)], };
				list = { group, guild, };
				info = { class, level, online, rank }
			]]

			local scroll = ALASCR(frame, nil, nil, ui_style.raidToolUIFrameButtonHeight, funcToCreateButton, functToSetButton);
			scroll:SetPoint("BOTTOMLEFT", 4, 24);
			scroll:SetPoint("TOPRIGHT", - 4, - 24);
			frame.scroll = scroll;

			local close = CreateFrame("BUTTON", nil, frame);
			close:SetSize(16, 16);
			close:SetNormalTexture("interface\\buttons\\ui-stopbutton");
			close:SetPushedTexture("interface\\buttons\\ui-stopbutton");
			close:GetPushedTexture():SetVertexColor(unpack(TEXTURE_SET.CONTROL_PUSHED_COLOR));
			close:SetHighlightTexture("interface\\buttons\\ui-stopbutton");
			close:GetHighlightTexture():SetVertexColor(unpack(TEXTURE_SET.CONTROL_HIGHLIGHT_COLOR));
			close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -4, -4);
			close:SetScript("OnClick", function()
				frame:Hide();
			end);
			frame.close = close;

			local refresh = CreateFrame("BUTTON", nil, frame);
			refresh:SetSize(16, 16);
			refresh:SetNormalTexture("interface\\buttons\\ui-refreshbutton");
			refresh:SetPushedTexture("interface\\buttons\\ui-refreshbutton");
			refresh:GetPushedTexture():SetVertexColor(unpack(TEXTURE_SET.CONTROL_PUSHED_COLOR));
			refresh:SetHighlightTexture("interface\\buttons\\ui-refreshbutton");
			refresh:GetHighlightTexture():SetVertexColor(unpack(TEXTURE_SET.CONTROL_HIGHLIGHT_COLOR));
			refresh:SetPoint("RIGHT", close, "LEFT", -4, 0);
			refresh:SetScript("OnClick", function()
				frame.update_func(true);
			end);
			frame.refresh = refresh;

			--	LAYERS
				local label_itemLevel = frame:CreateFontString(nil, "OVERLAY");
				label_itemLevel:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
				label_itemLevel:SetPoint("BOTTOMLEFT", scroll, "TOPLEFT", 160 + (ui_style.raidToolUIFrameButtonHeight - 4 + 24) * 3 + 12, 4);
				label_itemLevel:SetText(L.label_itemLevel);
				local label_missItem = frame:CreateFontString(nil, "OVERLAY");
				label_missItem:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
				label_missItem:SetPoint("LEFT", label_itemLevel, "LEFT", 36, 0);
				label_missItem:SetText(L.label_missItem);
				local label_missEnchant = frame:CreateFontString(nil, "OVERLAY");
				label_missEnchant:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
				label_missEnchant:SetPoint("LEFT", label_missItem, "LEFT", 60, 0);
				label_missEnchant:SetText(L.label_missEnchant);
				local label_DBM = frame:CreateFontString(nil, "OVERLAY");
				label_DBM:SetFont(ui_style.spellTabFrameFont, ui_style.spellTabFrameFontSize, ui_style.spellTabFrameFontOutline);
				label_DBM:SetPoint("LEFT", label_missEnchant, "LEFT", 60, 0);
				label_DBM:SetWidth(120);
				label_DBM:SetText(L.label_DBM);
				frame.labels = { label_itemLevel = label_itemLevel, label_missItem = label_missItem, label_missEnchant = label_missEnchant, };
			--

			local guildList = CreateFrame("CHECKBUTTON", nil, frame, "OptionsBaseCheckButtonTemplate");
			guildList:SetSize(16, 16);
			guildList:SetHitRectInsets(0, 0, 0, 0);
			guildList:ClearAllPoints();
			guildList:Show();
			guildList:SetChecked(false);
			guildList:SetPoint("BOTTOMRIGHT", - 4, 2);
			guildList:SetScript("OnClick", function(self)
				frame.guild = self:GetChecked();
				if self.guild then
					GuildRoster();
				end
				frame.update_func();
			end);
			frame.guildList = guildList;

			local guildListFontString = frame:CreateFontString(nil, "ARTWORK");
			guildListFontString:SetFont(GameFontHighlight:GetFont(), 12, ui_style.frameFontOutline);
			guildListFontString:SetText(L.guildList);
			guildList.fontString = guildListFontString;
			guildListFontString:SetPoint("RIGHT", guildList, "LEFT", 0, 0);
		--
		_EventHandler:AddCustomEventHandler("USER_EVENT_DATA_RECV", function()
			if frame:IsShown() then
				_EventHandler:run_on_next_tick(frame.update_scroll);
			end
		end);
		function frame.update_func(force_update)
			frame.update_list(force_update);
			frame.update_scroll();
		end
		function frame.update_scroll()
			scroll:SetNumValue(#rosterList);
			scroll:Update();
		end
		function frame.update_guild_roster_list(force_update)
			if frame.guild then
				wipe(rosterList);
				local total, online, onlineAndMobile = GetNumGuildMembers();
				for index = 1, total do
					local name, rankName, rankId, level, classLocale, zone, note, officerNote, online, _, class, _, _, _, _, _, GUID = GetGuildRosterInfo(index);
					name = Ambiguate(name, 'none');
					if online then
						tinsert(rosterList, name);
					end
					local info = rosterInfo[name];
					if info == nil then
						info = {  };
						rosterInfo[name] = info;
					end
					info[1] = class;
					info[2] = level;
					info[3] = online;
					info[4] = rankId;
					if online then
						NS.Emu_Query(name, nil, true, force_update);
					end
				end
			end
		end
		function frame.update_raid_roster_list(force_update)
			if not frame.guild then
				wipe(rosterList);
				local num = GetNumGroupMembers();
				for index = 1, num do
					local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isMasterLoot, combatRole = GetRaidRosterInfo(index);
					--	rank:	2-GroupLeader, 1-Assist, 0-None
					--	role:	MAINTANK, MAINASSIST
					name = Ambiguate(name, 'none');
					if level <= 0 then
						if UnitInBattleground('player') or IsInRaid() then
							local unit = 'party' .. index;
							if UnitExists(unit) then
								local _name, _realm = UnitName(unit);
								if _realm ~= nil and _realm ~= "" then
									_name = Ambiguate(_name .. "-" .. _realm);
								end
								if _name == name then
									level = UnitLevel(unit);
								end
							end
							if level <= 0 then
								for i = 1, 40 do
									local unit = 'raid' .. i;
									if UnitExists(unit) then
										local _name, _realm = UnitName(unit);
										if _realm ~= nil and _realm ~= "" then
											_name = Ambiguate(_name .. "-" .. _realm);
										end
										if _name == name then
											level = UnitLevel(unit);
											break;
										end
									end
								end
							end
						elseif IsInGroup() then
							local unit = 'party' .. index;
							if UnitExists(unit) then
								local _name, _realm = UnitName(unit);
								if _realm ~= nil and _realm ~= "" then
									_name = Ambiguate(_name .. "-" .. _realm);
								end
								if _name == name then
									level = UnitLevel(unit);
								end
							end
							if level <= 0 then
								for i = 1, 4 do
									local unit = 'party' .. i;
									if UnitExists(unit) then
										local _name, _realm = UnitName(unit);
										if _realm ~= nil and _realm ~= "" then
											_name = Ambiguate(_name .. "-" .. _realm);
										end
										if _name == name then
											level = UnitLevel(unit);
											break;
										end
									end
								end
							end
						end
					end
					tinsert(rosterList, name);
					local info = rosterInfo[name];
					if info == nil then
						info = {  };
						rosterInfo[name] = info;
					end
					info[1] = fileName;
					info[2] = level;
					info[3] = online;
					info[4] = rank;
					if online then
						NS.Emu_Query(name, nil, true, force_update);
					end
				end
			end
		end
		function frame.update_list(force_update)
			if frame:IsShown() then
				if frame.guild then
					frame.update_guild_roster_list(force_update);
				else
					frame.update_raid_roster_list(force_update);
				end
			end
		end
		function NS.GROUP_ROSTER_UPDATE()
			_EventHandler:run_on_next_tick(frame.update_list);
		end
		-- function NS.RAID_ROSTER_UPDATE()
		-- end
		function NS.GUILD_ROSTER_UPDATE()
			_EventHandler:run_on_next_tick(frame.update_list);
		end
		_EventHandler:RegEvent("GROUP_ROSTER_UPDATE");
		-- _EventHandler:RegEvent("RAID_ROSTER_UPDATE");	--	not triggered in classic
		_EventHandler:RegEvent("GUILD_ROSTER_UPDATE");
		C_Timer.NewTicker(1.0, function()
			for index = 1, #rosterList do
				local name = rosterList[index];
				if NS.queryCache[name] == nil and rosterInfo[name].online then
					NS.Emu_Query(name, nil, true);
				end
			end
		end);

		return frame;
	end
	function NS.ToggleRaidToolUI()
		local raidToolUI = NS.raidToolUI;
		if raidToolUI:IsShown() then
			raidToolUI:Hide();
		else
			raidToolUI:Show();
		end
	end
end

do	--	tooltip unit talents
	local prev_name = {  };
	local function tip_add_line(tip, _name)
		local cache = NS.queryCache[_name];
		if cache then
			local data = cache.data;
			local class = cache.class;
			if data and class then
				local line = "";
				local stats = { NS.EmuCore_StatPoints(data, class) };
				local talentRef = _classTalent[class];
				local cap = -1;
				if stats[1] ~= stats[2] or stats[1] ~= stats[3] then
					cap = max(stats[1], stats[2], stats[3]);
				end
				for specIndex = 1, 3 do
					local specId = talentRef[specIndex];
					if cap == stats[specIndex] then
						if SET.talents_in_tip_icon then
							line = line .. "\124T" .. (_talentTabIcon[specId] or TEXTURE_SET.UNK) .. format(":16\124t \124cffff7f1f%2d\124r  ", stats[specIndex]);
						else
							line = line .. "\124cffff7f1f" .. L.DATA[specId] .. ":" .. stats[specIndex] .. "\124r  ";
						end
					else
						if SET.talents_in_tip_icon then
							line = line .. "\124T" .. (_talentTabIcon[specId] or TEXTURE_SET.UNK) .. format(":16\124t \124cffffffff%2d\124r  ", stats[specIndex]);
						else
							line = line .. "\124cffbfbfff" .. L.DATA[specId] .. ":" .. stats[specIndex] .. "\124r  ";
						end
					end
				end
				tip:AddLine(line);
				if SET.supreme and cache.pack then
					local info = __rt.DecodeAddonPackData(cache.pack, true);
					if info then
						tip:AddLine("\124cffffffffPack\124r: " .. info, 0.75, 1.0, 0.25);
					end
				end
				tip:Show();
			end
		end
	end
	local function set_tip(tip, _name)
		if tip:IsShown() and prev_name[tip] == nil then
			local _, unit = tip:GetUnit();
			if unit then
				local name, realm = UnitName(unit);
				if realm ~= nil and realm ~= "" then
					name = Ambiguate(name .. "-" .. realm, 'none');
				end
				if name == _name then
					tip_add_line(tip, _name);
					prev_name[tip] = _name;
					return true;
				end
			end
		end
	end
	function NS.tooltip_TalentDataRecv(name)
		set_tip(GameTooltip, name);
		set_tip(ItemRefTooltip, name);
	end
	function NS.tooltip_SetUnit(tip)
		if SET.talents_in_tip then
			prev_name[tip] = nil;
			local _, unit = tip:GetUnit();
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitFactionGroup(unit) == NS.playerFactionGroup then
				local name, realm = UnitName(unit);
				NS.Emu_Query(name, realm, true);
			end
		end
	end
	function NS.hook_tooltip()
		-- hooksecurefunc(GameTooltip, "SetUnit", NS.tooltip_SetUnit);
		-- hooksecurefunc(ItemRefTooltip, "SetUnit", NS.tooltip_SetUnit);
		GameTooltip:HookScript("OnTooltipSetUnit", NS.tooltip_SetUnit);
		ItemRefTooltip:HookScript("OnTooltipSetUnit", NS.tooltip_SetUnit);
		_EventHandler:AddCustomEventHandler("USER_EVENT_TALENT_DATA_RECV", NS.tooltip_TalentDataRecv);
	end
end

do	-- initialize
	function NS.DB_PreLoad(_talentDB)	--	unnecessary
		for _, DB in next, _talentDB do
			for _, db in next, DB do
				for dataIndex, data in next, db do
					for i = 1, #data[8] do
						C_Spell.RequestLoadSpellData(data[8][i]);
					end
				end
			end
		end
		--
		for class, S in next, _spellDB do
			for _, v in next, S do
				for i = 1, #v do
					C_Spell.RequestLoadSpellData(v[i][2]);
				end
			end
		end
	end
	function NS.DB_PreProc(_talentDB)
		-- 1---- 2--- 3-- 4-------- 5------- 6------ 7----- 8-------- 9------- 10--------- 11---------------- 12
		--tier, col, id, maxPoint, reqTier, reqCol, reqId, Spell[5], texture, icon-index, req-index[] in db, { req-by-index } in db
		for _, DB in next, _talentDB do
			for _, db in next, DB do
				for dataIndex, data in next, db do
					data[10] = data[1] * MAX_NUM_COL + data[2] + 1;
					if data[5] and data[6] then
						for pIndex, p in next, db do
							if p[1] == data[5] and p[2] == data[6] then
								data[11] = pIndex;
								if p[12] then
									tinsert(p[12], dataIndex);
								else
									p[12] = { dataIndex, };
								end
								break;
							end
						end
						if not data[11] then
							_log_("DB_PreProc", 1, "req of ", data[1], data[2], data[5], data[6], "missing");
						end
					end
				end
			end
		end
		--
		for class, C in next, _preset_talent do
			_PRESET[class] = {  };
			for role, R in next, C do
				for scene, S in next, R do
					for _, url in next, S do
						local _, code = NS.EmuCore_Decoder(url);
						if code then
							local title = NS.EmuSub_GenerateTitleFromRawData(code, class) or "";
							tinsert(_PRESET[class], {
								title = title .. " - " .. L.DATA[role] .. " - " .. L.DATA[scene];
								code = code;
							});
						end
					end
				end
			end
		end
		--
		for class, S in next, _spellDB do
			for _, v in next, S do
				if v.race then
					for i = 1, #v do
						v[i].race = v.race;
					end
				end
				for i = #v, 1, -1 do
					if v[i][4] and v[i][4] > curPhase then
						tremove(v, i);
					end
				end
				for i = 1, #v do
					if v[i][1] > 0 then
						_spellLevelHash[v[i][2]] = v[i][1];
					end
					if #v > 1 then
						v[i][5] = i;
					end
					if v.passive then
						v[i][6] = true;
					end
				end
				if v.talent then
					local rid = v.require or v[1][2];
					local DB = _talentDB[class];
					local talentRef = _classTalent[class];
					for specIndex = 1, 3 do
						local spec = talentRef[specIndex];
						local db = DB[spec];
						if v.requireIndex then
							break;
						end
						for index, data in next, db do
							if data[8][1] == rid then
								v.requireSpecIndex = specIndex;
								v.requireIndex = index;
								break;
							end
						end
					end
				end
			end
		end
	end

	local function DBIcon_OnClick(self, button)
		if button == "LeftButton" then
			NS.Emu_Create();
		elseif button == "RightButton" then
			if SET.supreme then
				NS.ToggleRaidToolUI();
			else
				NS.Emu_Menu(self);
			end
		end
	end

	local function init()
		NS.DB_PreProc(_talentDB);

		NS.EmuCore_InitAddonMessage();
		NS.tooltipFrame = NS.CreateTooltipFrame();

		NS.extern.addon_init();

		if SET.inspectButtonKey == "CTRL" then
			NS.inspectButtonKeyFunc = IsControlKeyDown;
		elseif SET.inspectButtonKey == "SHIFT" then
			NS.inspectButtonKeyFunc = IsShiftKeyDown;
		elseif SET.inspectButtonKey == "ALT" then
			NS.inspectButtonKeyFunc = IsAltKeyDown;
		else
			NS.inspectButtonKeyFunc = IsAltKeyDown;
		end

		NS.initialized = true;

		if SET.supreme then
			NS.raidToolUI = NS.CreateRaidToolUI();
		end

		if IsInGroup() then
			_EventHandler:FireEvent("GROUP_ROSTER_UPDATE");
		end

		NS.hook_tooltip();

		if LibStub then
			--	DBICON
				local LDI = LibStub("LibDBIcon-1.0", true);
				if LDI then
					LDI:Register("alaTalentEmu",
					{
						icon = TEXTURE_SET.LIBDBICON,
						OnClick = DBIcon_OnClick,
						text = L.DBIcon_Text,
						OnTooltipShow = function(tt)
								tt:AddLine("TalentEmu");
								tt:AddLine(" ");
								tt:AddLine(L.DBIcon_Text);
								tt:Show();
							end
					},
					{
						minimapPos = SET.minimapPos,
					}
					);
					local mb = LDI:GetMinimapButton("alaTalentEmu");
					mb:RegisterEvent("PLAYER_LOGOUT");
					mb:HookScript("OnEvent", function(self)
						SET.minimapPos = self.minimapPos or self.db.minimapPos;
					end);
					mb:HookScript("OnDragStop", function(self)
						SET.minimapPos = self.minimapPos or self.db.minimapPos;
					end);
					if SET.minimap then
						LDI:Show("alaTalentEmu");
					else
						LDI:Hide("alaTalentEmu");
					end
					NS.callback["minimap"] = function(on)
						if on then
							LDI:Show("alaTalentEmu");
						else
							LDI:Hide("alaTalentEmu");
						end
					end
				end
			--	LDB
				local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
				if LDB then
					local obj = LDB:NewDataObject("alaTalentEmu", {
						type = "launcher",
						icon = TEXTURE_SET.LIBDBICON,
						OnClick = DBIcon_OnClick,
						OnTooltipShow = function(tt)
							tt:AddLine("TalentEmu");
							tt:AddLine(" ");
							tt:AddLine(L.DBIcon_Text);
							-- for _, text in next, L.TooltipLines do
							-- 	tt:AddLine(text);
							-- end
							tt:Show();
						end,
					});
				end
		end

		if __ala_meta__.initpublic then __ala_meta__.initpublic(); end

		C_Timer.After(8.0, function() NS.DB_PreLoad(_talentDB); end);
	end

	local default_set =
	{
		resizable_border = false,
		singleFrame = true,
		win_style = 'ala',
		style = 1,
		talents_in_tip = false,
		talents_in_tip_icon = true,
		inspectButtonOnUnitFrame = false,
		inspectButtonKey = "ALT",
		show_equipment = true,
		inspect_pack = false,
		max_recv_msg = 16,
		minimap = false,
		minimapPos = 185,
	};
	local function modify_saved_var()
		if alaTalentEmuSV then
			if alaTalentEmuSV._version == nil then
				alaTalentEmuSV._version = 0.0;
			end
			if alaTalentEmuSV._version < 200512.0 then
				alaTalentEmuSV.show_equipment = true;
				alaTalentEmuSV._version = 200512.0;
			end
			if alaTalentEmuSV._version < 200614.0 then
				local set = alaTalentEmuSV;
				_G.alaTalentEmuSV = { set = set, var = {  }, };
				alaTalentEmuSV._version = 200614.0;
				set._version = nil;
			end
			if alaTalentEmuSV._version < 200615.0 then
				alaTalentEmuSV.var.savedTalent = alaTalentEmuSV.set.savedTalent;
				alaTalentEmuSV.set.savedTalent = nil;
				alaTalentEmuSV._version = 200615.0;
			end
		else
			_G.alaTalentEmuSV = { set = {  }, var = { savedTalent = {  }, }, };
		end
		alaTalentEmuSV._version = 200615.0;
		SET = setmetatable(alaTalentEmuSV.set, { __index = default_set, });
		VAR = alaTalentEmuSV.var;
	end

	__ala_meta__.supreme = Mixin(__ala_meta__.supreme or {  }, {
		['\97\108\101\120\35\53\49\54\55\50\50'] = 1,
		['\229\141\149\233\133\146\231\170\157\35\53\49\54\51\55'] = 1,
	});
	function NS.PLAYER_ENTERING_WORLD()
		if not NS.initialized then
			modify_saved_var();
			local _, tag = BNGetInfo();
			SET.supreme = not not __ala_meta__.supreme[tag];
			SET.credible = not not select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33'));
			if SET.supreme then
				NS.emu_set_config("inspect_pack", true);
				_G.EMU_EX_QUERY_GUILD = NS.EX_QUERY_GUILD;
				_G.EMU_EX_QUERY_GROUP = NS.EX_QUERY_GROUP;
			end
			default_set.talents_in_tip = SET.credible;
			if not SET.credible then
				SET.talents_in_tip = false;
			end
			C_Timer.After(0.1, init);
		end
	end
	_EventHandler:RegEvent("PLAYER_ENTERING_WORLD");
end

do	-- SLASH and _G
	_G.SLASH_ALATALENTEMU1 = "/alaTalentEmu";
	_G.SLASH_ALATALENTEMU2 = "/alate";
	_G.SLASH_ALATALENTEMU3 = "/ate";
	_G.SLASH_ALATALENTEMU4 = "/emu";
	local acceptedCommandSeq = { "\ ", "\,", "\;", "\:", "\-", "\+", "\_", "\=", "\/", "\\", "\"", "\'", "\|", "\，", "\。", "\；", "\：", "\、", "\’", "\“", };
	SlashCmdList["ALATALENTEMU"] = function(msg)
		for _, seq in next, acceptedCommandSeq do
			if strfind(msg, seq) then
				NS.Emu_Create(nil, strsplit(seq, msg));
				return;
			end
		end
		NS.Emu_Create(nil, msg);
	end

	local ALATEMU = {  };
	_G.ALATEMU = ALATEMU;
	ALATEMU.ExportCode = function(...)
		return NS.Emu_Export(...)
	end
	ALATEMU.ImportCode = function(code)
		return NS.Emu_Import(code);
	end
	ALATEMU.Create = function(class, data, level, readOnly, name, style, ...)
		return NS.Emu_Create(nil, class, data, level, false, readOnly, name, style, ...);
	end
	ALATEMU.Destroy = function(winId)
		NS.hideMainFrame(winId);
	end
	ALATEMU.Query = function(unit)
		unit = unit or 'target';
		if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitFactionGroup(unit) == NS.playerFactionGroup then
			local name, realm = UnitName(unit);
			if name then
				NS.Emu_Query(name, realm);
			else
				name, realm = strsplit("-", unit);
				NS.Emu_Query(name, realm);
			end
		end
	end
	ALATEMU.SetStyle = function(style)
		SET.style = style;
	end
	ALATEMU.QueryRawInfoFromDB = function(spellId, class, specIndex)	--	should be rewritten, if use
		spellId = tonumber(spellId);
		if not spellId then
			return nil;
		end
		class = class and strupper(class) or nil;
		if class then
			local talentRef = _classTalent[class];
			local DB = _talentDB[class];
			if DB then
				if specIndex then
					local specId = talentRef[specIndex];
					local db = DB[specId];
					if db then
						for i = 1, #db do
							local data = db[i];
							for j = 1, 5 do
								if data[8][j] then
									if data[8][j] == spellId then
										return class, specIndex, specId, i, data[1], data[2], j;
									end
								else
									break;
								end
							end
						end
					end
				else
					for specIndex = 1, 3 do
						local specId = talentRef[specIndex];
						local db = DB[specId];
						for i = 1, #db do
							local data = db[i];
							for j = 1, 5 do
								if data[8][j] then
									if data[8][j] == spellId then
										return class, specIndex, specId, i, data[1], data[2], j;
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
		for c, DB in next, _talentDB do
			if c ~= class then
				local talentRef = _classTalent[c];
				for specIndex = 1, 3 do
					local specId = talentRef[specIndex];
					local db = DB[specId];
					for i = 1, #db do
						local data = db[i];
						for j = 1, 5 do
							if data[8][j] then
								if data[8][j] == spellId then
									return c, specIndex, specId, i, data[1], data[2], j;
								end
							else
								break;
							end
						end
					end
				end
			end
		end
		return nil;
	end
	ALATEMU.QueryInfoFromDB = function(spellId, class, specIndex)
		local class, specIndex, specId, id, row, col, rank = ALATEMU.QueryRawInfoFromDB(spellId, class, specIndex);
		if class then
			return class, L.DATA[class], specIndex, L.DATA[specId], id, row, col, rank;
		end
		return nil;
	end
	ALATEMU.QueryIdFromDB = function(class, specIndex, id, level)
		if class and specIndex and id then
			class = class and strupper(class) or nil;
			if class then
				local DB = _talentDB[class];
				if DB then
					if specIndex then
						local index = _classTalent[class][specIndex];
						if DB[index] then
							local data = DB[index][id];
							if data then
								if not level or level <= 0 or level > 5 then
									level = 1;
								end
								return data[8][level];
							end
						end
					end
				end
			end
		end
		return nil;
	end
end

-->		<misc
	function NS.emu_set_config(key, value)
		SET[key] = value;
		local func = NS.callback[key];
		if func then
			func(value);
		end
	end
	function NS.emu_get_config(key)
		return SET[key];
	end
	----------------------------------------------------------------------------------------------------Popup Menu
	do	-- popup
		local text = nil;
		if LOCALE == "zhCN" then
			text = "查询天赋";
		elseif LOCALE == "zhTW" then
			text = "查詢天賦";
		else
			text = "Inspect talent";
		end

		local function inspect_talent(which, frame)
			NS.Emu_Query(frame.name, frame.server, nil, true);
		end

		alaPopup.add_meta("EMU_INSPECT", { text, inspect_talent, });
		alaPopup.add_list("SELF", "EMU_INSPECT");
		alaPopup.add_list("FRIEND", "EMU_INSPECT");
		--alaPopup.add_list("FRIEND_OFFLINE", "EMU_INSPECT");
		alaPopup.add_list("PLAYER", "EMU_INSPECT");
		alaPopup.add_list("PARTY", "EMU_INSPECT");
		alaPopup.add_list("RAID", "EMU_INSPECT");
		alaPopup.add_list("RAID_PLAYER", "EMU_INSPECT");
		alaPopup.add_list("CHAT_ROSTER", "EMU_INSPECT");
		alaPopup.add_list("GUILD", "EMU_INSPECT");
		alaPopup.add_list("_BRFF_SELF", "EMU_INSPECT");
		alaPopup.add_list("_BRFF_PARTY", "EMU_INSPECT");
		alaPopup.add_list("_BRFF_RAID_PLAYER", "EMU_INSPECT");
		-- alaPopup.add_list("*", "EMU_INSPECT");


		if false then
			if LOCALE == "zhCN" then
				UnitPopupButtons["EMU_INSPECT"] = { text = "查询天赋", };
				-- UnitPopupButtons["BN_EMU_INSPECT"] = { text = "查询天赋", nested = 1, };
			elseif LOCALE == "zhTW" then
				UnitPopupButtons["EMU_INSPECT"] = { text = "查詢天賦", };
				-- UnitPopupButtons["BN_EMU_INSPECT"] = { text = "查詢天賦", nested = 1, };
			else
				UnitPopupButtons["EMU_INSPECT"] = { text = "Inspect talent", };
				-- UnitPopupButtons["BN_EMU_INSPECT"] = { text = "Inspect talent", nested = 1, };
			end
			-- UnitPopupMenus["BN_EMU_INSPECT"] = {  },

			-- tinsert(UnitPopupMenus["SELF"], 1, "EMU_INSPECT");
			-- tinsert(UnitPopupMenus["FRIEND"], 1, "EMU_INSPECT");
			-- --tinsert(UnitPopupMenus["FRIEND_OFFLINE"], 1, "EMU_INSPECT");
			-- tinsert(UnitPopupMenus["PLAYER"], 1, "EMU_INSPECT");
			-- tinsert(UnitPopupMenus["PARTY"], 1, "EMU_INSPECT");
			-- tinsert(UnitPopupMenus["RAID_PLAYER"], 1, "EMU_INSPECT");
			-- tinsert(UnitPopupMenus["CHAT_ROSTER"], 1, "EMU_INSPECT");
			-- tinsert(UnitPopupMenus["GUILD"], 1, "EMU_INSPECT");

			-- tinsert(UnitPopupMenus["BN_FRIEND"], 1, "BN_EMU_INSPECT");

			hooksecurefunc("UnitPopup_OnClick", function(self)
				local name = UIDROPDOWNMENU_INIT_MENU.name;
				local server = UIDROPDOWNMENU_INIT_MENU.server;
				if (self.value == "EMU_INSPECT") then
					NS.Emu_Query(name, server);
				-- elseif self.value == "BN_EMU_INSPECT" and self.arg1 then
				--	NS.Emu_Query(self.arg1.name, self.arg1.server);
				end
			end);

			local LC = {  };
			for k, v in next, LOCALIZED_CLASS_NAMES_FEMALE do
				LC[v] = k;
			end
			for k, v in next, LOCALIZED_CLASS_NAMES_MALE do
				LC[v] = k;
			end

			hooksecurefunc("UnitPopup_ShowMenu",
				function(dropdownMenu, which, unit, name, userData)
					if which == "BN_FRIEND" and UIDROPDOWNMENU_MENU_VALUE == "BN_EMU_INSPECT" and UIDROPDOWNMENU_MENU_LEVEL == 2 then
						local index = BNGetFriendIndex(UIDROPDOWNMENU_INIT_MENU.bnetIDAccount);
						local i = 1;
						local pFaction = UnitFactionGroup('player');
						local pRealmID = GetRealmID();
						while true do
							local gameOnline, charName, client, realm, realmID, faction, race, class = BNGetFriendGameAccountInfo(index, i);
							if client == BNET_CLIENT_WOW and realmID == pRealmID and faction == pFaction then
								local color = RAID_CLASS_COLORS[LC[class]];
								local info = UIDropDownMenu_CreateInfo();
								info.text = format("\124cff%.2x%.2x%.2x", color.r * 255, color.g * 255, color.b * 255) .. charName .. "\124r";
								info.arg1 = { name = charName, };
								info.value = UIDROPDOWNMENU_MENU_VALUE;
								info.func = UnitPopup_OnClick;
								info.notCheckable = true;
								UIDropDownMenu_AddButton(info, 2);
							end
							if gameOnline == nil then
								break;
							end
							i = i + 1;
						end
					end
				end
			);
		end
	end
	----------------------------------------------------------------------------------------------------Button on UnitFrame
	do	-- button_on_unitFrame
		local function unitFrameButton_OnEvent(self, event)
			if SET.inspectButtonOnUnitFrame then
				if (NS.inspectButtonKeyFunc and NS.inspectButtonKeyFunc()) and self.unitFrame:IsShown() and UnitIsPlayer(self.unitFrame.unit) then
					--self:Show();
					--self:SetPoint("TOP", self.unitFrame, "TOP");
					self:EnableMouse(true);
					self:SetAlpha(1.0);
				else
					--self:Hide();
					self:EnableMouse(false);
					self:SetAlpha(0.0);
				end
			end
		end
		local temp_unkFrame_id = 1;
		local function hookUnitFrame(unitFrame)
			local unitFrameName = unitFrame:GetName();
			if not unitFrameName or unitFrameName == "" then
				unitFrameName = "UNK" .. temp_unkFrame_id;
			end
			local unitFrameButton = CreateFrame("BUTTON", nil, UIParent);
			unitFrameButton:SetSize(60, 60);
			unitFrameButton:Show();
			unitFrameButton:SetAlpha(0.0);
			unitFrameButton:EnableMouse(false);
			unitFrameButton:SetNormalTexture(TEXTURE_SET.INSPECT_BUTTON);
			unitFrameButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.INSPECT_BUTTON_COLOR[1], TEXTURE_SET.INSPECT_BUTTON_COLOR[2], TEXTURE_SET.INSPECT_BUTTON_COLOR[3], TEXTURE_SET.INSPECT_BUTTON_COLOR[4]);
			unitFrameButton:SetPushedTexture(TEXTURE_SET.INSPECT_BUTTON);
			unitFrameButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.INSPECT_BUTTON_COLOR[1], TEXTURE_SET.INSPECT_BUTTON_COLOR[2], TEXTURE_SET.INSPECT_BUTTON_COLOR[3], TEXTURE_SET.INSPECT_BUTTON_COLOR[4]);
			-- unitFrameButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
			-- unitFrameButton:GetHighlightTexture():SetTexCoord(0.125, 0.875, 0.125, 0.875);
			-- unitFrameButton:LockHighlight();
			-- unitFrameButton:SetBackdrop({
			-- 	bgFile = "Interface\\raidframe\\shield-fill",	--"Interface\\TargetingFrame\\UI-TargetingFrame-LevelBackground",	--"Interface\\Tooltips\\UI-Tooltip-Background",
			-- 	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			-- 	tile = true,
			-- 	tileSize = 2,
			-- 	edgeSize = 2,
			-- 	insets = { left = 2, right = 2, top = 2, bottom = 2 }
			-- });
			-- unitFrameButton:SetBackdropColor(0.0, 1.0, 0.25, 1.0);
			-- unitFrameButton:SetBackdropBorderColor(0.0, 1.0, 0.25, 1.0);
			local portrait = _G[unitFrameName .. "Portrait"];
			if portrait then
				unitFrameButton:SetPoint("CENTER", portrait, "CENTER");
			else
				unitFrameButton:SetPoint("TOP", unitFrame, "TOP");
			end
			-- local unitFrameButtonFontString = unitFrameButton:CreateFontString(unitFrameButton:GetName() .. "FontString", "ARTWORK");
			-- local font, size, outline = PlayerFrame.healthbar.TextString:GetFont();
			-- unitFrameButtonFontString:SetFont(font, 32, "OUTLINE");
			-- unitFrameButtonFontString:SetPoint("CENTER");
			-- unitFrameButtonFontString:SetTextColor(0.0, 1.0, 0.0, 1.0);
			-- unitFrameButtonFontString:SetText("TE");
			-- unitFrameButtonFontString:Show();
			unitFrameButton:RegisterEvent("MODIFIER_STATE_CHANGED");
			unitFrameButton:SetScript("OnEvent", unitFrameButton_OnEvent);
			unitFrameButton:SetScript("OnUpdate", function(self, elasped)
			end);
			unitFrameButton:SetScript("OnClick", function(self) ALATEMU.Query(self.unitFrame.unit); end);
			unitFrameButton.unitFrame = unitFrame;
		end

		C_Timer.After(1.0, function() hookUnitFrame(TargetFrame); end);
	end
	----------------------------------------------------------------------------------------------------
	do	--
		local Orig_TalentFrameTalent_OnClick = nil;
		local function _TalentFrameTalent_OnClick(self, mouseButton)
			if IsShiftKeyDown() then
				local specIndex, id = PanelTemplates_GetSelectedTab(TalentFrame), self:GetID();
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(specIndex, id);
				local sId = ALATEMU.QueryIdFromDB(NS.playerClassUpper, specIndex, id, rank);
				local link = _GetSpellLink(sId, name);
				if link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(link);
					return;
				end
			end
			return Orig_TalentFrameTalent_OnClick(self, mouseButton);
		end
		local TalentFrameTalents = {  };
		local function onEvent(self, event, addon)
			if addon == "Blizzard_TalentUI" then
				Orig_TalentFrameTalent_OnClick = TalentFrameTalent_OnClick;
				for i = 1, 999 do
					local b = _G["TalentFrameTalent" .. i];
					if b then
						b:SetScript("OnClick", _TalentFrameTalent_OnClick);
						TalentFrameTalents[i] = b;
					else
						break;
					end
				end

				if TalentFrame then
					local button = CreateFrame("BUTTON", nil, TalentFrame, "UIPanelButtonTemplate");
					button:SetSize(80, 20);
					button:SetPoint("RIGHT", TalentFrameCloseButton, "LEFT", -2, 0);
					button:SetText(L.TalentFrameCallButtonFontString);
					button:SetScript("OnClick", function() NS.Emu_Create(); end);
					button:SetScript("OnEnter", Info_OnEnter);
					button:SetScript("OnLeave", Info_OnLeave);
					button.information = L.TalentFrameCallButton;
					TalentFrame.__alaTalentEmuCall = button;
				end

				if self then
					self:UnregisterAllEvents();
					self:SetScript("OnEvent", nil);
				end
			end
		end

		if IsAddOnLoaded("Blizzard_TalentUI") then
			onEvent(nil, nil, "Blizzard_TalentUI");
		else
			local f = CreateFrame("FRAME");
			f:RegisterEvent("ADDON_LOADED");
			f:SetScript("OnEvent", onEvent);
			f = nil;
		end

		--GameTooltip:SetHyperlink("itemString" or "itemLink")
		--GameTooltip:SetSpellBookItem(spellBookId, bookType)
		--GameTooltip:SetSpellByID(spellId)
	end
	----------------------------------------------------------------------------------------------------Tooltip
	do	-- tooltip spell
		local function func_HookGTT(self, spellId)
			local eClass, class, specIndex, spec, id, row, col, rank = ALATEMU.QueryInfoFromDB(spellId);
			if eClass then
				local classColorTable = RAID_CLASS_COLORS[strupper(eClass)];
				self:AddDoubleLine(L.DATA.talent, class .. "-" .. spec .. " R" .. (row + 1) .. "-C" .. (col + 1) .. "-L" .. rank, 1.0, 1.0, 1.0, classColorTable.r, classColorTable.g, classColorTable.b);
				self:Show();
			end
		end
		local function func_SetHyperlink(self, link)
			local _, _, spellId = strfind(link, "spell:(%d+)");
			spellId = tonumber(spellId);
			if spellId then
				func_HookGTT(self, spellId);
			end
		end
		local function func_SetSpellBookItem(self, spellBookId, bookType)
			local _, _, spellId = GetSpellBookItemName(spellBookId, bookType);
			spellId = tonumber(spellId);
			if spellId then
				func_HookGTT(self, spellId);
			end
		end
		local function func_SetSpellByID(self, spellId)
			spellId = tonumber(spellId);
			if spellId then
				func_HookGTT(self, spellId);
			end
		end
		local function func_SetAction(self, slot)
			local actionType, id, subType = GetActionInfo(slot);
			if actionType == "spell" then
				func_HookGTT(self, id);
			elseif actionType == "macro" then
				local spellId = GetMacroSpell(id);
				if spellId then
					func_HookGTT(self, spellId);
				end
			end
		end

		local function Tooltip_Set()
			hooksecurefunc(GameTooltip, "SetHyperlink", func_SetHyperlink);
			hooksecurefunc(GameTooltip, "SetSpellBookItem", func_SetSpellBookItem);
			hooksecurefunc(GameTooltip, "SetSpellByID", func_SetSpellByID);
			hooksecurefunc(GameTooltip, "SetAction", func_SetAction);

			hooksecurefunc(ItemRefTooltip, "SetHyperlink", func_SetHyperlink);
			hooksecurefunc(ItemRefTooltip, "SetSpellBookItem", func_SetSpellBookItem);
			hooksecurefunc(ItemRefTooltip, "SetSpellByID", func_SetSpellByID);
			hooksecurefunc(ItemRefTooltip, "SetAction", func_SetAction);
		end

		C_Timer.After(1.0, Tooltip_Set);

	end
-->		misc>

do	-- dev
	function NS.display_pack(meta)
		local info = __rt.DecodeAddonPackData(meta);
		if info then
			print("Packed: ", info);
		else
			print("Packed: \124cffff0000none\124r")
		end
	end
	--
	do	--	QUERY GUILD OR GROUP
		local function display(result)
			print("------------");
			local total = 0;
			for i = 1, #knownPacks do
				if result[i] > 0 then
					print(knownPacks[i], result[i]);
					total = total + result[i];
				end
			end
			if result[0] > 0 then
				print("OTHER", result[0]);
				total = total + result[0];
			end
			print("TOTAL", total);
		end
		local function do_check(cache, result, timer, call)
			if #cache > 0 then
				if time() - timer < 4 then
					for _, name in ipairs(cache) do
						if not NS.queryCache[name] then
							C_Timer.After(1.0, call);
							print("Querying", timer + 4 - time());
							return;
						end
					end
				end
				for i = 0, #knownPacks do
					result[i] = 0;
				end
				for _, name in ipairs(cache) do
					local meta = NS.queryCache[name];
					if meta then
						local pack = tonumber(meta.pack);
						if pack then
							local index = #knownPacks - 1;
							local magic = 2 ^ index;
							while magic >= 1 do
								if pack >= magic then
									result[index + 1] = result[index + 1] + 1;
									pack = pack - magic;
								end
								magic = magic / 2;
								index = index - 1;
							end
						else
							result[0] = result[0] + 1;
						end
					end
				end
				display(result);
			end
		end
		do
			local cache = {  };
			local result = {  };
			local timer = 0;
			local function check()
				do_check(cache, result, timer, check);
			end
			function NS.EX_QUERY_GUILD()
				local num_total, num_online, num_online_and_mobile = GetNumGuildMembers();
				if num_online > 0 then
					wipe(cache);
					for i = 1, num_total do
						local name, _, _, _, _, _, _, _, online = GetGuildRosterInfo(i);
						if online then
							tinsert(cache, NS.Emu_Query(name, nil, true));
						end
					end
					timer = time();
					C_Timer.After(1.0, check);
					print("Querying", 4);
				end
			end
		end
		--------
		do
			local cache = {  };
			local result = {  };
			local timer = 0;
			local function check()
				do_check(cache, result, timer, check);
			end
			function NS.EX_QUERY_GROUP()
				if GetNumGroupMembers(LE_PARTY_CATEGORY_HOME) > 0 or GetNumGroupMembers(LE_PARTY_CATEGORY_INSTANCE) > 0 then
					wipe(cache);
					for i = 1, MAX_RAID_MEMBERS do
						local name, _, _, _, _, _, _, online = GetRaidRosterInfo(i);
						if name and online then
							tinsert(cache, NS.Emu_Query(name, nil, true));
						end
					end
					timer = time();
					C_Timer.After(1.0, check);
					print("Querying", 4);
				end
			end
		end
		--
	end
	--
	function NS.CONFIRM_TALENT_WIPE(...)
		-- print("CONFIRM_TALENT_WIPE", ...);
	end
	function NS.CHARACTER_POINTS_CHANGED(...)
		print("CHARACTER_POINTS_CHANGED", ...);
	end
	_EventHandler:RegEvent("CONFIRM_TALENT_WIPE");
	--	Fires when the user selects the "Yes, I do." confirmation prompt after speaking to a class trainer and choosing to unlearn their talents.
	--	Payload	number:cost	number:respecType
	--	inexistent	_EventHandler:RegEvent("PLAYER_TALENT_UPDATE");
	--	inexistent	_EventHandler:RegEvent("PLAYER_LEARN_TALENT_FAILED");
	--	inexistent	_EventHandler:RegEvent("TALENTS_INVOLUNTARILY_RESET");
	--	inexistent	_EventHandler:RegEvent("PLAYER_SPECIALIZATION_CHANGED");
	_EventHandler:RegEvent("CHARACTER_POINTS_CHANGED");
	--	Fired when the player's available talent points change.
	--	Payload	number:change	-1 indicates one used (learning a talent)	1 indicates one gained (leveling)
	--	SPELLS_CHANGED
	--	Fires when spells in the spellbook change in any way. Can be trivial (e.g.: icon changes only), or substantial (e.g.: learning or unlearning spells/skills).
	--	Payload	none
end

if select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33')) then
	_G._163_ALAEMU_SETCONFIG = NS.emu_set_config;
	_G._163_ALAEMU_GETCONFIG = NS.emu_get_config;
end

-- NS.emu_set_config("show_equipment", true);		-- experimental, default disabled
