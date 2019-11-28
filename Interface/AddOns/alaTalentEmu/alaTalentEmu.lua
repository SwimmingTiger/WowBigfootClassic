--[[--
	alex/ALA	Please Keep WOW Addon open-source & Reduce barriers for others.
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;

local L = NS.L;
if not L then return;end
local curPhase = 2;
----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
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
	----------------------------------------------------------------------------------------------------GAME
	local _G = _G;
	local print = print;
	local GetTime = GetTime;
	local CreateFrame = CreateFrame;
	local GetCursorPosition = GetCursorPosition;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	local InCombatLockdown = InCombatLockdown;

	local UnitName = UnitName;
	local UnitClass = UnitClass;
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
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------local
	local _ = nil;
	local NAME = "alaTalentEmu";
	local ADDON_PREFIX = "ATEADD";
	local ARTWORK_PATH = "Interface\\Addons\\alaTalentEmu\\ARTWORK\\";
	NS.ARTWORK_PATH = ARTWORK_PATH;
	local LOCALE = GetLocale();
	--------------------------------------------------
	local MAX_NUM_TIER = 7;
	local MAX_NUM_COL = 4;
	local MAX_NUM_ICONS_PER_SPEC = MAX_NUM_TIER * MAX_NUM_COL;
	local NUM_POINTS_NEXT_TIER = 5;
	--------------------------------------------------
	local setting =
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
		mainFrameBorderSize = 8,
		iconBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0, }
		},
		iconBackdropColor = { 0.25, 0.25, 0.25, 0.75, },
		iconBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0, },
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
		spellTabFrameButtonBackdrop = {
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 0, right = 0, top = 0, bottom = 0 }
		};
		spellTabFrameButtonBackdropColor = { 0.25, 0.25, 0.25, 0.75 };
		spellTabFrameButtonBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0 };
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

		mainFrameXSizeMin_Style1 = 250,
		mainFrameYSizeMin_Style1 = 165,
		mainFrameXSizeMin_Style2 = 100,
		mainFrameYSizeMin_Style2 = 180,
		mainFrameHeaderYSize = 20,
		mainFrameFooterYSize = 20,
		mainFrameFooterYSize_Style2 = 40,

		frameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		frameFontSize = 11,
		frameFontOutline = "NORMAL",

		talentIconSize = 32,
		talentIconXGap = 8,
		talentIconYGap = 8,
		talentIconXToBorder = 10,
		talentIconYToTop = 5,
		talentIconYToBottom = 10,
		talentIconFont = NumberFont_Shadow_Med:GetFont(),--="Fonts\ARHei.ttf"
		--"Fonts\\FRIZQT__.TTF",
		talentIconFontSize = 11,
		talentIconFontOutline = "NORMAL",
		talentFrameXToBorder = 8,
		talentFrameYToBorder = 0,
		talentFrameHeaderYSize = 0,
		talentFrameFooterYSize = 0,
		seqWidth = 1,

		talentDepArrowXSize = 15,
		talentDepArrowYSize = 15,
		talentDepBranchWidth = 8,

		spellTabFrameWidth = 160,
		spellTabFrameButtonHeight= 24;
		spellTabFrameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		spellTabFrameFontSize = 11,
		spellTabFrameFontOutline = "NORMAL",

		equipmentFrameXSize = 200;
		equipmentFrameButtonSize = 24;
		equipmentFrameButtonGap = 6;
		equipmentFrameArmorWeaponGap = 16;
		equipmentFrameButtonXToBorder = 8;
		equipmentFrameButtonYToBorder = 16;
		equipmentFrameIconTextGap = 4;

		controlButtonSize = 15,
		editBoxXSize = 240,
		editBoxYSize = 32,
		tabButtonSize = 20,
		tabButtonGap = 2,
		curClassIndicatorSize = 28,

		specTabButtonWidth = 48,
		specTabButtonHeight = 12,
		specTabButtonGap = 12,
		specTabButtonTexCoord = { 0.05, 0.95, 0.40, 0.70, },
		curSpecIndicatorSize = 20,

		color_iconTextDisabled = { 1.0, 1.0, 1.0, 1.0, },
		color_iconTextAvailable = { 0.0, 1.0, 0.0, 1.0, },
		color_iconTextMaxRank = { 1.0, 1.0, 0.0, 1.0, },
		color_iconToolTipCurRank = { 0.0, 1.0, 0.0, 1.0, },
		color_iconToolTipNextRank = { 0.0, 0.5, 1.0, 1.0, },
		color_iconToolTipNextRankDisabled = { 1.0, 0.0, 0.0, 1.0, },
		color_iconToolTipMaxRank = { 1.0, 0.5, 0.0, 1.0, },
		DEFAULT_LEVEL = 60,
		INSPECT_WAIT_TIME = 10,
		TOOLTIP_UPDATE_DELAY = 0.02,

		ORIG_SCALE = 1.35,
	};
	setting.talentFrameXSizeSingle = setting.talentIconSize * MAX_NUM_COL + setting.talentIconXGap * (MAX_NUM_COL - 1) + setting.talentIconXToBorder * 2;
	setting.talentFrameXSizeTriple = setting.talentFrameXSizeSingle * 3;
	setting.talentFrameYSize = setting.talentFrameHeaderYSize + setting.talentIconYToTop + setting.talentIconSize * MAX_NUM_TIER + setting.talentIconYGap * (MAX_NUM_TIER - 1) + setting.talentIconYToBottom+ setting.talentFrameFooterYSize;
	setting.mainFrameXSizeDefault_Style1 = setting.talentFrameXSizeTriple + setting.talentFrameXToBorder * 2;
	setting.mainFrameYSizeDefault_Style1 = setting.talentFrameYSize + setting.talentFrameYToBorder * 2 + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize;
	setting.mainFrameXSizeDefault_Style2 = setting.talentFrameXSizeSingle + setting.talentFrameXToBorder * 2;
	setting.mainFrameYSizeDefault_Style2 = setting.talentFrameYSize + setting.talentFrameYToBorder * 2 + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize_Style2;
	setting.equipmentContainerYSize = setting.equipmentFrameButtonYToBorder + setting.equipmentFrameButtonSize * 10 + setting.equipmentFrameButtonGap * 11 + setting.equipmentFrameArmorWeaponGap + setting.equipmentFrameButtonYToBorder;
	local TEXTURE_SET =
	{
		LIBDBICON = "interface\\buttons\\ui-microbutton-talents-up",
		UNK = "Interface\\Icons\\inv_misc_questionmark",
		SQUARE_HIGHLIGHT = ARTWORK_PATH .. "CheckButtonHilight",
		NORMAL_HIGHLIGHT = ARTWORK_PATH .. "ui-panel-minimizebutton-highlight",
		SEP_HORIZONTAL = ARTWORK_PATH .. "UI-ChatFrame-BorderLeft",
		SEP_HORIZONTAL_COORD = { 0.25, 0.3125, 0.0, 1.0, },
		SEP_VERTICAL = ARTWORK_PATH .. "UI-ChatFrame-BorderTop",
		SEP_VERTICAL_COORD = { 0.0, 1.0, 0.25, 0.3125, },
		CONTROL_PUSHED_COLOR = { 0.5, 0.5, 0.5, 1.0, },
		CONTROL_DISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },

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
	local function _log_(...)
		--print(...);
	end
	local function _error_(...)
		print("\124cffff0000" .. select(1, ...) .. "\124r", select(2, ...));
	end
	local function _noop_()
	end
	local function _GetSpellTexture(id)
		return select(3,GetSpellInfo(id));
	end
	local function GameTooltipSetTalent(icon, spellTable, curRank)
		GameTooltip:SetOwner(icon, "ANCHOR_RIGHT");
		if curRank == 0 then
			GameTooltip:SetSpellByID(spellTable[1]);
		else
			GameTooltip:SetSpellByID(spellTable[curRank]);
		end
		--GameTooltip:Show();
	end
	_G.ALA_GetSpellLink = _G.ALA_GetSpellLink or function(id, name)
		--\124cff71d5ff\124Hspell:355\124h[嘲讽]\124h\124r
		name = name or GetSpellInfo(id);
		if name then
			if alac_hyperLink and alac_hyperLink() then
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
	local config = 
	{
		singleFrame = true,
		style = 1,
		inspectButtonOnUnitFrame = false,
		inspectButtonKey = "ALT",
		savedTalent = {  },		--label, data, decorded, class
		show_equipment = false,
		inspect_pack = false;
	};
	--------------------------------------------------
	local ADDON_MSG_CONTROL_CODE_LEN = 6;
	local ADDON_MSG_QUERY = "_query";
	local ADDON_MSG_REPLY = "_reply";
	local ADDON_MSG_PULL = "_pull_";
	--
	local ADDON_MSG_QUEEQ = "_queeq";
	local ADDON_MSG_REPEQ = "_repeq";
	local ADDON_MSG_REPPK = "_reppk";
	--------------------------------------------------
	local _talentDB = NS._talentDB;
	local _indexToClass = NS._indexToClass;
	local _classToIndex = NS._classToIndex;
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
					specButtons[]	(frame table)
					curTabIndicator	(texture)
					level			(num)
					totalUsedPoints	(num)
					totalAvailablePoints	(num)
					data			(string)
					readOnly		(bool)
					name			(string)

		- 1---- 2--- 3-- 4-------- 5------- 6------ 7----- 8-------- 9------- 10--------- 11---------------- 12
		--tier, col, id, maxPoint, reqTier, reqCol, reqId, Spell[5], texture, icon-index, req-index[] in db, req-by-index in db
	]]
	--[[
		GameTooltipTextLeft1
		GameTooltip:SetTalent(specIndex, id)
		CHARACTER_POINTS_CHANGED or SPELLS_CHANGED -> TalentFrame_Update
		LearnTalent(specIndex, id);
		LearnTalents
		ConfirmTalentWipe();
		CheckTalentMasterDist();
		frameStrata(string) Which layer your frame should be on. Some words of caution: if you set your frameStrata to "BACKGROUND" it will be blocked from receiving mouse events unless you set frameLevel to 1 or more. Same goes for "TOOLTIP" regardless of frameLevel. Possible values are, from highest to lowest:
			TOOLTIP
			FULLSCREEN_DIALOG
			FULLSCREEN
			DIALOG
			HIGH
			MEDIUM
			LOW
			BACKGROUND
	]]
----------------------------------------------------------------------------------------------------

local emu = {
	initialized = false,
	codeTable = {  },
	revCodeTable = {  },
	mainFrames = { num = 0, used = 0, },
	inspectButtonKeyFunc = IsAltKeyDown,
	applyingMainFrame = false,
	playerClass_Lower = strlower(select(2, UnitClass('player'))),
	playerGUID = UnitGUID('player'),
	playerName = UnitName('player'),
	realm = GetRealmName(),
	specializedMainFrameInspect = {  },
	queryCache = {  },	-- [GUID] = { [addon] = { data, time, }, }
};
local extern = { export = {  }, import = {  }, addon = {  }, };

do	-- extern media
	function extern.import.wowhead(url)
		--[[
			https://classic.wowhead.com/talent-calc/embed/warrior/05004-055001-55250110500001051
			https://classic.wowhead.com/talent-calc/warrior/05004-055001-55250110500001051
				"^.*classic%.wowhead%.com/talent%-calc.*/([^/]+)/(%d.+)$"
		]]
		local _, _, class, data = strfind(url, "classic%.wowhead%.com/talent%-calc.*/([^/]+)/([0-9%-]+)");
		if class and data then
			class = strlower(class);
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
						if l1 > strlen(d1) then
							data = d1 .. strrep("0", l1 - strlen(d1));
						else
							data = d1;
						end
						local l2  = #DB[classTalent[2]];
						if l2 > strlen(d2) then
							data = data .. d2 .. strrep("0", l2 - strlen(d2)) .. d3;
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
		--           nfuwow%.com/talents/60/([^/]+)/tal/(%d+)
		local _, _, class, data = strfind(url, "nfuwow%.com/talents/60/([^/]+)/tal/(%d+)");
		if class and data then
			class = strlower(class);
			if _talentDB[class] then
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
	function extern.addon_init()
		--[[
			local CONST_DETAILS_PREFIX = "DTLS";
			local CONST_ASK_TALENTS = "AT";
			local _detalhes = { realversion = 140, };
			local msg = "^S" .. CONST_ASK_TALENTS .. UnitName('player') .. "^S" ..  GetRealmName() .. "^N" ..  _detalhes.realversion .. "^S" ..  UnitGUID ('player')
			_detalhes:SendCommMessage (CONST_DETAILS_PREFIX, msg, "WHISPER", targetName);
			>>>>
			SendAddonMessage(CONST_DETAILS_PREFIX, msg, "WHISPER", targetName);
		]]
		if true then return end
		local CONST_DETAILS_PREFIX = "DTLS";
		local CONST_ASK_TALENTS = "AT";
		local CONST_ANSWER_TALENTS = "AWT";
		local _detalhes = { realversion = 140, };
		extern.addon[CONST_DETAILS_PREFIX] = {
			addon = "Details",
			prefix = CONST_DETAILS_PREFIX,
			msg = "^S" .. CONST_ASK_TALENTS .. emu.playerName .. "^S" .. emu.realm .. "^N" ..  _detalhes.realversion .. "^S" .. emu.playerGUID .. "^^",
			fmt = "^S" .. CONST_ANSWER_TALENTS .. "^S" .. emu.playerName .. "^S" .. emu.realm .. "^N" .. _detalhes.realversion .. "^S" .. emu.playerGUID .. "^N0^S(.+)^N(%d)+";
			decoder = function(code)
				-- "^N"
			end
		};
		--
		for prefix, val in pairs(extern.addon) do
			if not IsAddonMessagePrefixRegistered(prefix) then
				RegisterAddonMessagePrefix(prefix);
			end
		end
	end
end

do	-- win manager
	function emu.winMan_GetWin(winId)
		local mainFrames = emu.mainFrames;
		local mainFrame = nil;
		if winId then
			for i = 1, mainFrames.num do
				if mainFrames[i].id == winId then
					mainFrame = mainFrames[i];
					if not mainFrame:IsShown() then
						mainFrames.used = mainFrames.used + 1;
					end
					break;
				end
			end
		end
		if not mainFrame then
			if mainFrames.num > mainFrames.used then
				mainFrames.used = mainFrames.used + 1;
				mainFrame = mainFrames[mainFrames.used];
			else
				mainFrames.num = mainFrames.num + 1;
				mainFrames[mainFrames.num] = emu.CreateMainFrame();
				mainFrames.used = mainFrames.num;
				mainFrame = mainFrames[mainFrames.used];
			end
		end
		mainFrame:Show();
		return mainFrame;
	end
	function emu.winMan_GetLastWin()
		local mainFrames = emu.mainFrames;
		return mainFrames.used > 0 and mainFrames[mainFrames.used] or nil;
	end
	function emu.winMan_RelWin(winId)
		local mainFrames = emu.mainFrames;
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
				emu.winMan_RelSpecializedName(mainFrame);
				break;
			end
		end
	end
	function emu.winMan_RelAllBut(...)	-- TODO
		if true then
			_error_("ERROR", "Donot use this");
			return;
		end
		local mainFrames = emu.mainFrames;
		local n = select("#", ...);
		if n == 0 then
			for i = 1, mainFrames.used do
				mainFrames[i]:Hide();
			end
			mainFrames.used = 0;
		elseif n == 1 then
			emu.winMan_RelAllButOne(...);
		else
			for i = 1, mainFrames.used do
				mainFrames[i]:Hide();
			end
		end
	end
	function emu.winMan_RelAllButOne(id)
		local mainFrames = emu.mainFrames;
		for i = mainFrames.used, 1, -1 do
			local mainFrame = mainFrames[i];
			if mainFrame.id ~= id then
				mainFrame:Hide();
			end
		end
		if mainFrames.used == 1 then
			emu.winMan_SetWinId(mainFrames[1], 1);
		elseif mainFrames.used > 1 then
			_error_("Emu Warn >> RelAllButOne", "USED NEQ 1, IS", mainFrames.used);
		end
	end
	function emu.winMan_IsAllSameStyle()
		local style = -1;
		local mainFrames = emu.mainFrames;
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
	function emu.winMan_SetWinId(mainFrame, winId)
		if mainFrame.id == winId then
			return;
		end
		local mainFrames = emu.mainFrames;
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
	function emu.hideMainFrame(winId)
		if type(winId) == 'table' then
			winId:Hide();
		elseif type(winId) == 'number' then
			local mainFrames = emu.mainFrames;
			for i = mainFrames.used, 1, -1 do
				local mainFrame = mainFrames[i];
				if mainFrame.id == winId then
					mainFrame:Hide();
					break;
				end
			end
		end
	end
	function emu.winMan_RelSpecializedName(mainFrame)
		if mainFrame then
			if type(mainFrame) == 'number' then
				mainFrame = emu.winMan_GetWin(mainFrame);
				if not mainFrame then
					return;
				end
			end
			for name, v in pairs(emu.specializedMainFrameInspect) do
				if #v == 2 then
					if mainFrame == v[2] then
						emu.specializedMainFrameInspect[name] = nil;
					end
				elseif #v > 2 then
					for i = #v, 2, -1 do
						if mainFrame == v[i] then
							tremove(v, i);
						end
					end
					if #v < 2 then
						emu.specializedMainFrameInspect[name] = nil;
					end
				else
					emu.specializedMainFrameInspect[name] = nil;
				end
			end
		end
	end
	function emu.winMan_SetSpecializedName(mainFrame, name)
		if emu.specializedMainFrameInspect[name] then
			local v = emu.specializedMainFrameInspect[name];
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
				emu.specializedMainFrameInspect[name] = nil;
			end
			return;
		end
		for n, v in pairs(emu.specializedMainFrameInspect) do
			if #v == 2 then
				if mainFrame == v[2] then
					emu.specializedMainFrameInspect[n] = nil;
				end
			elseif #v > 2 then
				for i = #v, 2, -1 do
					if mainFrame == v[i] then
						tremove(v, i);
					end
				end
				if #v < 2 then
					emu.specializedMainFrameInspect[name] = nil;
				end
			else
				emu.specializedMainFrameInspect[name] = nil;
			end
		end
		emu.specializedMainFrameInspect[name] = { GetTime(), mainFrame, };
	end
	function emu.winMan_GetSpecializedMeta(name)
		for n, v in pairs(emu.specializedMainFrameInspect) do
			if n == name then
				return v;
			end
		end
	end
end

do	-- apply talents
	function emu.UpdateApplying(applyingMainFrame)
		local mainFrames = emu.mainFrames;
		if not emu.applyingMainFrame ~= not applyingMainFrame then
			emu.applyingMainFrame = applyingMainFrame;
			if applyingMainFrame then
				for i = 1, mainFrames.num do
					local mainFrame = mainFrames[i];
					mainFrame.objects.applyTalentsButton:Disable();
				end
			else
				for i = 1, mainFrames.num do
					local mainFrame = mainFrames[i];
					mainFrame.objects.applyTalentsButton:Enable();
				end
			end
		end
	end
	function emu.tickerApplyTalents()
		local talentFrames = emu.applyingMainFrame.talentFrames;
		local applyingSpecIndex = emu.applyingSpecIndex;
		local talentSet = talentFrames[applyingSpecIndex].talentSet;
		for id = emu.applyingTalentIndex, #talentSet do
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
		emu.applyTicker:Cancel();
		emu.UpdateApplying(nil);
	end
	function emu.processApplyTalents(mainFrame)
		emu.UpdateApplying(mainFrame);
		emu.applyingSpecIndex = 1;
		emu.applyingTalentIndex = 1;
		emu.applyTicker = C_Timer.NewTicker(0.1, emu.tickerApplyTalents);
	end
end

do	-- objects func
	function emu.EmuSub_LightIcon(icon)
		icon:GetNormalTexture():SetVertexColor(TEXTURE_SET.ICON_LIGHT_COLOR[1], TEXTURE_SET.ICON_LIGHT_COLOR[2], TEXTURE_SET.ICON_LIGHT_COLOR[3], TEXTURE_SET.ICON_LIGHT_COLOR[4]);
		icon:GetPushedTexture():SetVertexColor(TEXTURE_SET.ICON_LIGHT_COLOR[1], TEXTURE_SET.ICON_LIGHT_COLOR[2], TEXTURE_SET.ICON_LIGHT_COLOR[3], TEXTURE_SET.ICON_LIGHT_COLOR[4]);
	end
	function emu.EmuSub_UnlightIcon(icon)
		icon:GetNormalTexture():SetVertexColor(TEXTURE_SET.ICON_UNLIGHT_COLOR[1], TEXTURE_SET.ICON_UNLIGHT_COLOR[2], TEXTURE_SET.ICON_UNLIGHT_COLOR[3], TEXTURE_SET.ICON_UNLIGHT_COLOR[4]);
		icon:GetPushedTexture():SetVertexColor(TEXTURE_SET.ICON_UNLIGHT_COLOR[1], TEXTURE_SET.ICON_UNLIGHT_COLOR[2], TEXTURE_SET.ICON_UNLIGHT_COLOR[3], TEXTURE_SET.ICON_UNLIGHT_COLOR[4]);
	end
	function emu.EmuSub_SetIconTextColor_Available(icon)
		icon.split:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
		icon.maxVal:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
		icon.curVal:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
	end
	function emu.EmuSub_SetIconTextColor_Unavailable(icon)
		icon.split:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
		icon.maxVal:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
		icon.curVal:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
	end
	function emu.EmuSub_SetIconTextColor_MaxRank(icon)
		icon.split:SetTextColor(setting.color_iconTextMaxRank[1], setting.color_iconTextMaxRank[2], setting.color_iconTextMaxRank[3], setting.color_iconTextMaxRank[4]);
		icon.maxVal:SetTextColor(setting.color_iconTextMaxRank[1], setting.color_iconTextMaxRank[2], setting.color_iconTextMaxRank[3], setting.color_iconTextMaxRank[4]);
		icon.curVal:SetTextColor(setting.color_iconTextMaxRank[1], setting.color_iconTextMaxRank[2], setting.color_iconTextMaxRank[3], setting.color_iconTextMaxRank[4]);
	end
	function emu.EmuSub_ActivateIcon(icon)	--icon light when points inc from 0, not after activation
		icon.active = true;
		emu.EmuSub_SetIconTextColor_Available(icon);
	end
	function emu.EmuSub_DeactiveIcon(icon)	--icon unlight certainly when deactived
		icon.active = false;
		emu.EmuSub_SetIconTextColor_Unavailable(icon);
		emu.EmuSub_UnlightIcon(icon);
	end
	function emu.EmuSub_ActivateIcon_RecheckReq(icon)
		local dbIndex = icon.dbIndex;
		if dbIndex then
			local talentFrame = icon:GetParent();
			local db = talentFrame.db;
			local data = db[dbIndex];
			if (not data[11]) or (data[11] and talentFrame.talentSet[data[11]] == db[data[11]][4]) then
				emu.EmuSub_ActivateIcon(icon);
			end
		end
	end
	function emu.EmuSub_ActivateIcon_RecheckPoint(icon)
		local dbIndex = icon.dbIndex;
		if dbIndex > 0 then
			local talentFrame = icon:GetParent();
			local db = talentFrame.db;
			local talentSet = talentFrame.talentSet;
			local data = db[dbIndex];
			if data[1] == 0 then
				emu.EmuSub_ActivateIcon(icon);
			end
			local numPointsLowerTier = 0;
			for i = data[1] - 1, 0, - 1 do
				numPointsLowerTier = numPointsLowerTier + talentSet.totalPerTier[i];
			end
			if numPointsLowerTier >= data[1] * NUM_POINTS_NEXT_TIER then
				emu.EmuSub_ActivateIcon(icon);
			end
		end
	end
	function emu.EmuSub_ActivateTier(icons, tier)
		for i = tier * MAX_NUM_COL + 1, (tier + 1) * MAX_NUM_COL do
			emu.EmuSub_ActivateIcon_RecheckReq(icons[i]);
		end
	end
	function emu.EmuSub_DeactiveTier(icons, tier)
		for i = tier * MAX_NUM_COL + 1, (tier + 1) * MAX_NUM_COL do
			emu.EmuSub_DeactiveIcon(icons[i]);
		end
	end
	function emu.EmuSub_NoRemainingPoints(mainFrame)
		local talentFrames = mainFrame.talentFrames;
		for specIndex = 1, 3 do
			local talentFrame = talentFrames[specIndex];
			local db = talentFrame.db;
			local talentSet = talentFrame.talentSet;
			local icons = talentFrame.talentIcons;
			for i = 1, #db do
				if db[i][4] ~= talentSet[i] then
					emu.EmuSub_SetIconTextColor_Unavailable(icons[emu.EmuSub_GetIconIndex(db[i])]);
				end
			end
		end
	end
	function emu.EmuSub_HasRemainingPoints(mainFrame)
		local talentFrames = mainFrame.talentFrames;
		for specIndex = 1, 3 do
			local talentFrame = talentFrames[specIndex];
			local db = talentFrame.db;
			local talentSet = talentFrame.talentSet;
			local icons = talentFrame.talentIcons;
			for i = 1, #db do
				if db[i][4] == talentSet[i] then
					-- emu.EmuSub_SetIconTextColor_MaxRank(icons[emu.EmuSub_GetIconIndex(db[i])]);
				elseif talentSet[i] > 0 or db[i][1] == 0 then
					emu.EmuSub_SetIconTextColor_Available(icons[emu.EmuSub_GetIconIndex(db[i])]);
				else
					local data = db[i];
					local numPointsLowerTier = 0;
					for j = data[1] - 1, 0, - 1 do
						numPointsLowerTier = numPointsLowerTier + talentSet.totalPerTier[j];
					end
					if numPointsLowerTier >= data[1] * NUM_POINTS_NEXT_TIER then
						emu.EmuSub_ActivateIcon_RecheckReq(icons[emu.EmuSub_GetIconIndex(db[i])]);
					end
				end
			end
		end
	end
	function emu.EmuSub_SetReqArrowTexCoord(arrow, branch, branch2, coordFamily, enabled)
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
	function emu.EmuSub_UpdateLabelText(mainFrame)
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
		objects.curPointsReqLevel:SetText(emu.GetPiontsReqLevel(mainFrame.totalUsedPoints));
		objects.curPointsRemaining:SetText(emu.GetLevelAvailablePoints(mainFrame.level) - mainFrame.totalUsedPoints);
	end
	function emu.EmuSub_SetReqArrow(arrow, branch, branch2, verticalDist, horizontalDist, enabled, icon, reqIcon)
		local coordFamily = nil;
		if verticalDist == 0 then		--horizontal
			if horizontalDist > 0 then
				arrow:SetPoint("CENTER", icon, "LEFT", - setting.talentDepArrowXSize / 6, 0);
				branch:SetSize(setting.talentIconSize * (horizontalDist - 1) + setting.talentIconXGap * horizontalDist, setting.talentDepBranchWidth);
				branch:SetPoint("LEFT", reqIcon, "RIGHT");
				branch:SetPoint("RIGHT", arrow, "CENTER");
				coordFamily = 11;
			elseif horizontalDist < 0 then
				horizontalDist = - horizontalDist;
				arrow:SetPoint("CENTER", icon, "RIGHT", setting.talentDepArrowXSize / 6, 0);
				branch:SetSize(setting.talentIconSize * (horizontalDist - 1) + setting.talentIconXGap * horizontalDist, setting.talentDepBranchWidth);
				branch:SetPoint("RIGHT", reqIcon, "LEFT");
				branch:SetPoint("LEFT", arrow, "CENTER");
				coordFamily = 12;
			end
			branch2:Hide();
		elseif horizontalDist == 0 then	--vertical
			if verticalDist > 0 then
				arrow:SetPoint("CENTER", icon, "TOP", 0, setting.talentDepArrowYSize / 6);
				branch:SetSize(setting.talentDepBranchWidth, setting.talentIconSize * (verticalDist - 1) + setting.talentIconYGap * verticalDist);
				branch:SetPoint("TOP", reqIcon, "BOTTOM");
				branch:SetPoint("BOTTOM", arrow, "CENTER");
				coordFamily = 21;
			elseif verticalDist < 0 then
				verticalDist = - verticalDist;
				arrow:SetPoint("CENTER", icon, "BOTTOM", 0, - setting.talentDepArrowYSize / 6);
				branch:SetSize(setting.talentDepBranchWidth, setting.talentIconSize * (verticalDist - 1) + setting.talentIconYGap * verticalDist);
				branch:SetPoint("BOTTOM", reqIcon, "TOP");
				branch:SetPoint("TOP", arrow, "CENTER");
				coordFamily = 22;
			end
			branch2:Hide();
		else	--TODO 
			if verticalDist > 0 then
				arrow:SetPoint("CENTER", icon, "TOP", 0, setting.talentDepArrowYSize / 6);
				branch:SetSize(setting.talentDepBranchWidth, setting.talentIconSize * (verticalDist - 1) + setting.talentIconYGap * verticalDist + setting.talentIconSize * 0.5);
				--branch:SetPoint("TOP", reqIcon, "CENTER");
				branch:SetPoint("BOTTOM", arrow, "CENTER");
				coordFamily = 31;
			elseif verticalDist < 0 then
				verticalDist = - verticalDist;
				arrow:SetPoint("CENTER", icon, "BOTTOM", 0, - setting.talentDepArrowYSize / 6);
				branch:SetSize(setting.talentDepBranchWidth, setting.talentIconSize * (verticalDist - 1) + setting.talentIconYGap * verticalDist + setting.talentIconSize * 0.5);
				--branch:SetPoint("BOTTOM", reqIcon, "CENTER");
				branch:SetPoint("TOP", arrow, "CENTER");
				coordFamily = 32;
			end
			branch2:SetSize(setting.talentIconSize * (horizontalDist - 1) + setting.talentIconXGap * horizontalDist + setting.talentIconSize * 0.5, setting.talentDepBranchWidth);
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
		emu.EmuSub_SetReqArrowTexCoord(arrow, branch, branch2, coordFamily, enabled);
	end
	function emu.CreateReqArrow(talentFrame)
		local arrow = talentFrame:CreateTexture(nil, "OVERLAY");
		arrow:SetTexture(TEXTURE_SET.ARROW);
		arrow:SetSize(setting.talentDepArrowXSize, setting.talentDepArrowYSize);

		local branch = talentFrame:CreateTexture(nil, "ARTWORK");
		branch:SetTexture(TEXTURE_SET.BRANCH);

		local branch2 = talentFrame:CreateTexture(nil, "ARTWORK");
		branch2:SetTexture(TEXTURE_SET.BRANCH);
		branch2:Hide();

		arrow.branch = branch;
		arrow.branch2 = branch2;

		return arrow;
	end
	function emu.EmuSub_GetReqArrow(talentFrame)
		local reqArrows = talentFrame.reqArrows;
		reqArrows.used = reqArrows.used + 1;
		if reqArrows.used > #reqArrows then
			reqArrows[reqArrows.used] = emu.CreateReqArrow(talentFrame);
		end
		return reqArrows[reqArrows.used];
	end
end

do	-- internal sub
	function emu.GetPiontsReqLevel(numPoints)
		return max(10, 9 + numPoints);
	end
	function emu.GetLevelAvailablePoints(level)
		return max(0, level - 9);
	end
	function emu.GetPlayerTalentData(usePlayerLevel)
		local data = "";
		for specIndex = 1, 3 do
			local numTalents = GetNumTalents(specIndex);
			for id = 1, numTalents do
				local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(specIndex, id);
				data = data .. rank;
			end
		end
		if usePlayerLevel then
			return emu.playerClass_Lower, data, UnitLevel('player');
		else
			return emu.playerClass_Lower, data, 60;
		end
	end
	function emu.EmuSub_GenerateTitle(data, class)
		if type(data) == 'table' then	--mainFrame
			local talentFrames = data.talentFrames;
			local class = data.class;
			local talentRef = _classTalent[class];
			local classColorTable = RAID_CLASS_COLORS[strupper(class)];
			--local title = L.DATA[class] .. "-";
			local title = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. L.DATA[class] .. "\124r-";
			for specIndex = 1, 3 do
				local talentSet = talentFrames[specIndex].talentSet;
				title = title .. L.DATA[talentRef[specIndex]] .. format("%2d", talentSet.total);
			end
			return title;
		elseif type(data) == 'string' and type(class) == 'string' and _talentDB[class] then
			local DB = _talentDB[class];
			local talentRef = _classTalent[class];
			local pos = 1;
			local len =strlen(data);
			local classColorTable = RAID_CLASS_COLORS[strupper(class)];
			--local title = L.DATA[class] .. "-";
			local title = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. L.DATA[class] .. "\124r-";
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
				title = title .. L.DATA[talentRef[specIndex]] .. format("%2d", total);
			end
			return title;
		end
	end

	function emu.EmuCore_InitCodeTable()
		-- 6^11 < 64^5 < 2^32
		-- 6^11 =   362,797,056
		-- 6^12 = 2,176,782,336
		-- 64^5 = 1,073,741,824‬
		-- 2^32 = 4,294,967,296
		for i = 0, 9 do emu.codeTable[i] = tostring(i); end
		emu.codeTable[10] = "-";
		emu.codeTable[11] = "=";
		for i = 0, 25 do emu.codeTable[i + 1 + 11] = strchar(i + 65); end
		for i = 0, 25 do emu.codeTable[i + 1 + 11 + 26] = strchar(i + 97); end

		for i = 0, 63 do
			emu.revCodeTable[emu.codeTable[i]] = i;
		end
	end
	function emu.EmuCore_Decoder(code, useCodeLevel)
		for media, func in pairs(extern.import) do
			local class, data, level = func(code);
			if class then
				return class, data, level;
			end
		end
		local data = "";
		local revCodeTable = emu.revCodeTable;
		local classIndex = revCodeTable[strsub(code, 1, 1)];
		if not classIndex then
			_log_("EmuCore_Decoder", 1, code);
			return nil;
		end
		local class = _indexToClass[classIndex];
		if not class then
			_log_("EmuCore_Decoder", 2, classIndex, code);
			return nil;
		end

		local len = strlen(code);
		if len < 3 then
			_log_("EmuCore_Decoder", 3, classIndex, code);
		end
		local pos = 0;
		local raw = 0;
		local magic = 1;
		local nChar = 0;
		for p = 2, len - 2 do
			local c = strsub(code, p, p);
			pos = pos + 1;
			if c == ":" then
				--
			elseif revCodeTable[c] then
				raw = raw + revCodeTable[c] * magic;
				magic = bit.lshift(magic, 6);
				nChar = nChar + 1;
			else
				_log_("EmuCore_Decoder", 3, c, code);
			end
			if c == ":" or nChar == 5 or p == len - 2 then
				pos = 0;
				magic = 1;
				nChar = 0;
				local n = 0;
				while raw > 0 do
					data = data .. fmod(raw, 6);
					raw = floor(raw / 6);
					n = n + 1;
				end
				if n < 11 then
					for i = n + 1, 11 do
						data = data .. "0";
					end
				end
			end
		end

		if useCodeLevel then
			return class, data, revCodeTable[strsub(code, - 2, - 2)] + bit.lshift(revCodeTable[strsub(code, - 1, - 1)], 6);
		else
			return class, data, 60;
		end
	end
	----------------mainFrame or class, data, level
	function emu.EmuCore_Encoder(class, data, level)
		level = (level and tonumber(level)) or setting.DEFAULT_LEVEL;
		if type(class) == 'number' then
			class = _indexToClass[class];
		end
		if type(class) == 'string' then
			local codeTable = emu.codeTable;
			if not _classToIndex[class] or not codeTable[_classToIndex[class]] then
				_log_("EmuCore_Encoder", 1, class);
				return nil;
			end
			if type(data) == 'string' then
				local DB = _talentDB[class];
				local classTalent = _classTalent[class];
				local len = strlen(data);
				local p = 0;

				local pos = 0;
				local raw = 0;
				local magic = 1;
				local mem = {  };
				for specIndex = 1, 3 do
					local numTalents = #DB[classTalent[specIndex]];
					for j = 1, numTalents do
						p = p + 1;
						local d = tonumber(strsub(data, p, p));
						if not d then
							_log_("EmuCore_Encoder", 3, class, data, p);
							return nil;
						end
						pos = pos + 1;
						raw = raw + magic * d;
						magic = magic * 6;
						if pos >= 11 or p == len then
							pos = 0;
							magic = 1;
							local nChar = 0;
							while raw > 0 do
								tinsert(mem, codeTable[bit.band(raw, 63)]);
								raw = bit.rshift(raw, 6);
								nChar = nChar + 1;
							end
							if nChar < 5 then
								tinsert(mem, ":");
							end
							if p == len then
								break;
							end
						end
					end
				end

				for i = #mem, 1, - 1 do
					if mem[i] == ":" then
						mem[i] = nil;
					else
						break;
					end
				end
				local code = codeTable[_classToIndex[class]];
				for i = 1, #mem do
					code = code .. mem[i];
				end
				if level < 64 then
					code = code .. codeTable[level] .. "0";
				else
					code = code .. codeTable[math.band(level, 63)] .. codeTable[bit.rshift(level, 6)];
				end

				return code;

			elseif type(data) == 'table' and type(data[1]) == 'table' and type(data[2]) == 'table' and type(data[3]) == 'table' then
				local DB = _talentDB[class];
				local classTalent = _classTalent[class];
				for specIndex = 1, 3 do
					local talentSet = data[specIndex];
					local numTalents = #_talentDB[classTalent[specIndex]];
					for j = 1, numTalents do
						pos = pos + 1;
						raw = raw + magic * talentSet[j];
						magic = magic * 6;
						if pos >= 11 or (specIndex == 3 and j == numTalents) then
							pos = 0;
							magic = 1;
							local nChar = 0;
							while raw > 0 do
								tinsert(mem, codeTable[bit.band(raw, 63)]);
								raw = bit.rshift(raw, 6);
								nChar = nChar + 1;
							end
							if nChar < 5 then
								tinsert(mem, ":");
							end
							if specIndex == 3 and j == numTalents then
								break;
							end
						end
					end
				end

				for i = #mem, 1, - 1 do
					if mem[i] == ":" then
						mem[i] = nil;
					else
						break;
					end
				end
				local code = codeTable[_classToIndex[class]];
				for i = 1, #mem do
					code = code .. mem[i];
				end
				if level < 64 then
					code = code .. codeTable[level] .. "0";
				else
					code = code .. codeTable[math.band(level, 63)] .. codeTable[bit.rshift(level, 6)];
				end

				return code;

			else
				_log_("EmuCore_Encoder", 2, class, type(data));
				return nil;
			end
		elseif type(class) == 'table' then
			local mainFrame = class;
			local talentFrames = mainFrame.talentFrames;
			local codeTable = emu.codeTable;
			if type(talentFrames) == 'table' and 
						type(talentFrames[1]) == 'table' and type(talentFrames[1].talentSet) == 'table' and
						type(talentFrames[2]) == 'table' and type(talentFrames[2].talentSet) == 'table' and
						type(talentFrames[3]) == 'table' and type(talentFrames[3].talentSet) == 'table'
				then
				--
				class = mainFrame.class;
				level = mainFrame.level;
				--
				local pos = 0;
				local raw = 0;
				local magic = 1;
				local mem = {  };
				for i = 1, 3 do
					local talentSet = talentFrames[i].talentSet;
					local numTalents = #talentFrames[i].db;
					for j = 1, numTalents do
						pos = pos + 1;
						raw = raw + magic * talentSet[j];
						magic = magic * 6;
						if pos >= 11 or (i == 3 and j == numTalents) then
							pos = 0;
							magic = 1;
							local nChar = 0;
							while raw > 0 do
								tinsert(mem, codeTable[bit.band(raw, 63)]);
								raw = bit.rshift(raw, 6);
								nChar = nChar + 1;
							end
							if nChar < 5 then
								tinsert(mem, ":");
							end
							if i == 3 and j == numTalents then
								break;
							end
						end
					end
				end

				for i = #mem, 1, - 1 do
					if mem[i] == ":" then
						mem[i] = nil;
					else
						break;
					end
				end
				local code = codeTable[_classToIndex[class]];
				for i = 1, #mem do
					code = code .. mem[i];
				end
				if level < 64 then
					code = code .. codeTable[level] .. "0";
				else
					code = code .. codeTable[math.band(level, 63)] .. codeTable[bit.rshift(level, 6)];
				end

				return code;

			else
				_log_("EmuCore_Encoder", 3, 'table');
				return nil;

			end
		else
			_log_("EmuCore_Encoder", 4, type(class));
			return nil;
		end
	end

	function emu.EmuSub_GetIconIndex(data)
		return data[1] * MAX_NUM_COL + data[2] + 1;
	end

	function emu.EmuCore_SetName(mainFrame, name)	-- NAME CHANGED HERE ONLY
		mainFrame.name = name;
		if name then
			local objects = mainFrame.objects;
			objects.label:SetText(name);
			objects.resetToEmu:Show();
			objects.resetToSetButton:Hide();
			local classButtons = mainFrame.classButtons;
			for index = 1, #_indexToClass do
				classButtons[index]:Hide();
			end
			objects.curClassIndicator:Hide();
			--emu.EmuCore_SetReadOnly(mainFrame, true);
			local talentFrames = mainFrame.talentFrames;
			for specIndex = 1, 3 do
				wipe(talentFrames[specIndex].talentChanged);
			end
			emu.winMan_SetSpecializedName(mainFrame, name);
		else
			local objects = mainFrame.objects;
			objects.label:SetText(L.Emu);
			objects.resetToEmu:Hide();
			objects.resetToSetButton:Hide();
			local classButtons = mainFrame.classButtons;
			for index = 1, #_indexToClass do
				classButtons[index]:Show();
			end
			objects.curClassIndicator:Show();
			objects.curClassIndicator:ClearAllPoints();
			objects.curClassIndicator:SetPoint("CENTER", classButtons[_classToIndex[mainFrame.class]]);
			emu.winMan_RelSpecializedName(mainFrame);
			mainFrame.equipmentFrame:Hide();
		end
		mainFrame.objects.equipmentButton:Hide();
	end
	function emu.EmuCore_SetLevel(mainFrame, level)		-- LEVEL CHANGED HERE ONLY
		if level == nil then
			mainFrame.level = setting.DEFAULT_LEVEL;
			mainFrame.totalUsedPoints = 0;
			mainFrame.totalAvailablePoints = emu.GetLevelAvailablePoints(setting.DEFAULT_LEVEL);
		else
			if type(level) == 'string' then
				level = tonumber(level);
			end
			if level then
				mainFrame.level = level;
				mainFrame.totalAvailablePoints = emu.GetLevelAvailablePoints(level);
			end
		end
	end
	function emu.EmuCore_SetClass(mainFrame, class)		-- CLASS CHANGED HERE ONLY
		if class == nil then
			mainFrame.class = nil;
			mainFrame.DB = nil;
			mainFrame.initialized = false;
		else
			do	--check class value
				-- if class == nil then
				-- 	_log_("EmuCore_SetClass", - 1, 1, - 1);
				-- 	return false;
				-- end
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

			class = strlower(class);
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
				if db then
					for dbIndex = 1, #db do
						local data = db[dbIndex];
						local icon = talentIcons[data[10]];
						icon.dbIndex = dbIndex;
						icon:Show();
						local texture = _GetSpellTexture(data[8][1]);
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
							local arrow = emu.EmuSub_GetReqArrow(talentFrame);
							emu.EmuSub_SetReqArrow(arrow, arrow.branch, arrow.branch2, data[1] - data[5], data[2] - data[6], false, icon, talentIcons[db[data[11]][10]]);
							tinsert(talentFrame.reqByArrowSet[data[11]], arrow);
						end

						if data[1] == 0 then
							if not data[5] then
								emu.EmuSub_ActivateIcon(icon);
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

			if emu.playerClass_Lower == class then
				mainFrame.objects.applyTalentsButton:Show();
			else
				mainFrame.objects.applyTalentsButton:Hide();
			end

			emu.EmuSub_SpellTabUpdate(mainFrame.spellTabFrame, class, emu.GetPiontsReqLevel(mainFrame.totalUsedPoints));
		end

		return true;
	end
	function emu.EmuCore_SetData(mainFrame, data)		-- DATA CHANGED HERE ONLY	-- TODO REQUIRE TREE.
		if data == nil then
			mainFrame.data = nil;
		else
			do	--check point value
				if not mainFrame.initialized then
					_log_("EmuCore_SetData", 1, - 1);
					return false;
				end
				-- if not data then
				-- 	_log_("EmuCore_SetData", 2, - 1);
				-- 	return false;
				-- end
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
						local ret = emu.EmuCore_ChangePoint(icons[db[j][10]], d);
						if ret < 0 then
							tinsert(retry, { i, j, d, });
							_log_("EmuCore_SetData", 5, "tab", i, "tier", db[j][1], "col", db[j][2], "maxPoints", db[j][4], "set", d, data, pos);
						elseif ret > 0 then
							_log_("EmuCore_SetData", 6, "tab", i, "tier", db[j][1], "col", db[j][2], "maxPoints", db[j][4], "set", d, data, pos);
						end
					end
				end
			end
			for i, v in pairs(retry) do
				local ret = emu.EmuCore_ChangePoint(talentFrames[v[1]].talentIcons[talentFrames[v[1]].db[v[2]][10]], tonumber(v[3]));
				if ret < 0 then
					_log_("EmuCore_SetData", 7, "tab", retry[i][1], "mainFrames", retry[i][2], "set", retry[i][3]);
				elseif ret > 0 then
					_log_("EmuCore_SetData", 8, "tab", retry[i][1], "mainFrames", retry[i][2], "set", retry[i][3]);
				end
			end
		end

		return true;
	end
	function emu.EmuCore_SetReadOnly(mainFrame, readOnly)	-- READONLY CHANGED HERE ONLY
		if mainFrame.readOnly == readOnly then
			return;
		end
		mainFrame.readOnly = readOnly;
		local objects = mainFrame.objects;
		if readOnly then
			objects.readOnlyButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.LOCK_LOCKED_COLOR[1], TEXTURE_SET.LOCK_LOCKED_COLOR[2], TEXTURE_SET.LOCK_LOCKED_COLOR[3], TEXTURE_SET.LOCK_LOCKED_COLOR[4]);
			--objects.readOnlyText:SetText(L.readOnly);
			emu.EmuSub_NoRemainingPoints(mainFrame);
		else
			objects.readOnlyButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.LOCK_UNLOCKED_COLOR[1], TEXTURE_SET.LOCK_UNLOCKED_COLOR[2], TEXTURE_SET.LOCK_UNLOCKED_COLOR[3], TEXTURE_SET.LOCK_UNLOCKED_COLOR[4]);
			--objects.readOnlyText:SetText(L.notReadOnly);
			if mainFrame.totalAvailablePoints > mainFrame.totalUsedPoints then
				emu.EmuSub_HasRemainingPoints(mainFrame);
			end
		end
	end
	function emu.EmuCore_ChangePoint(self, numPoints)	-- POINTS CHANGED HERE ONLY
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
		elseif numPoints > 0 then
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

		if (numPoints > 0 and talentSet[dbIndex] == data[4]) or (numPoints < 0 and talentSet[dbIndex] == 0) then	-- inc top rank OR dec rank 0
			return 2;
		end
		local tier = data[1];
		if numPoints < 0 then
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
			emu.EmuSub_SetIconTextColor_MaxRank(self);
			emu.EmuSub_LightIcon(self);
			if data[12] then
				for i = 1, #data[12] do
					emu.EmuSub_ActivateIcon_RecheckPoint(talentFrame.talentIcons[db[data[12][i]][10]]);
				end
				local arrow = talentFrame.reqByArrowSet[dbIndex];
				for i = 1, #arrow do
					emu.EmuSub_SetReqArrowTexCoord(arrow[i], arrow[i].branch, arrow[i].branch2, arrow[i].coordFamily, true);
				end
			end
		elseif talentSet[dbIndex] + numPoints <= 0 then
			if talentSet[dbIndex] + numPoints < 0 then
				ret = 5;
			end
			numPoints = - talentSet[dbIndex];
			talentSet[dbIndex] = 0;
			emu.EmuSub_UnlightIcon(self);
			emu.EmuSub_SetIconTextColor_Available(self);
		else
			talentSet[dbIndex] = talentSet[dbIndex] + numPoints;
			emu.EmuSub_SetIconTextColor_Available(self);
			if numPoints > 0 then
				emu.EmuSub_LightIcon(self);
			end
		end
		self.curVal:SetText(talentSet[dbIndex]);

		if numPoints < 0 and data[12] then	--deactive talents that require this after dec
			for i = 1, #data[12] do
				emu.EmuSub_DeactiveIcon(talentFrame.talentIcons[db[data[12][i]][10]]);
			end
			local arrow = talentFrame.reqByArrowSet[dbIndex];
			for i = 1, #arrow do
				emu.EmuSub_SetReqArrowTexCoord(arrow[i], arrow[i].branch, arrow[i].branch2, arrow[i].coordFamily, false);
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
			emu.EmuSub_ActivateTier(talentFrame.talentIcons, curAvailableTopTier);
			talentSet.curAvailableTopTier = curAvailableTopTier;
		elseif curAvailableTopTier < talentSet.curAvailableTopTier then
			emu.EmuSub_DeactiveTier(talentFrame.talentIcons, talentSet.curAvailableTopTier);
			talentSet.curAvailableTopTier = curAvailableTopTier;
		end

		if numPoints < 0 then
			if mainFrame.totalAvailablePoints == mainFrame.totalUsedPoints then
				emu.EmuSub_HasRemainingPoints(mainFrame);
			end
			mainFrame.totalUsedPoints = mainFrame.totalUsedPoints + numPoints;
		else
			mainFrame.totalUsedPoints = mainFrame.totalUsedPoints + numPoints;
			if mainFrame.totalAvailablePoints == mainFrame.totalUsedPoints then
				emu.EmuSub_NoRemainingPoints(mainFrame);
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

		emu.EmuSub_SpellTabUpdate(mainFrame.spellTabFrame, mainFrame.class, emu.GetPiontsReqLevel(mainFrame.totalUsedPoints));

		local editBox = mainFrame.objects.editBox;
		if editBox.type == "save" and not editBox.charChanged then
			editBox:SetText(emu.EmuSub_GenerateTitle(mainFrame));
		end

		emu.EmuSub_UpdateLabelText(mainFrame);
		if GetMouseFocus() == self then
			emu.EmuSub_TooltipSetTalent(mainFrame.tooltipFrame, self, data[8], talentSet[dbIndex], data[4])
		end

		return ret;
	end
	function emu.EmuCore_Reset(mainFrame)
		local talentFrames = mainFrame.talentFrames;
		for specIndex = 1, 3 do
			local talentFrame = talentFrames[specIndex];

			local talentIcons = talentFrame.talentIcons;
			for i = 1, MAX_NUM_ICONS_PER_SPEC do
				talentIcons[i]:Hide();
				talentIcons[i].dbIndex = nil;
				emu.EmuSub_DeactiveIcon(talentIcons[i]);
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

		emu.EmuCore_SetClass(mainFrame, nil);
		emu.EmuCore_SetLevel(mainFrame, nil);
		emu.EmuCore_SetData(mainFrame, nil);
		emu.EmuCore_SetReadOnly(mainFrame, false);
		emu.EmuCore_SetName(mainFrame, nil);
		emu.Emu_ChangeTab_Style2(mainFrame, 1);

		emu.EmuSub_UpdateLabelText(mainFrame);

		mainFrame.initialized = false;
	end

	function emu.EmuSub_ResetTalentReqTree(talentFrame, dbIndex)
		local talentSet = talentFrame.talentSet;
		local db = talentFrame.db;
		if talentSet[dbIndex] > 0 then
			if db[dbIndex][12] then
				for _, dbIndex2 in pairs(db[dbIndex][12]) do
					emu.EmuSub_ResetTalentReqTree(talentFrame, dbIndex2);
				end
			end
			emu.EmuCore_ChangePoint(talentFrame.talentIcons[db[dbIndex][10]], - talentSet[dbIndex]);
		end
	end
	function emu.EmuSub_ResetTalentSingleTab(talentFrame)
		local db = talentFrame.db;
		for i = #db, 1, -1 do
			emu.EmuSub_ResetTalentReqTree(talentFrame, i);
		end
	end

	function emu.EmuSub_TooltipSetTalent(tooltipFrame, icon, spellTable, curRank, maxRank)
		local fontString1h = tooltipFrame.fontString1h;
		local tooltip1 = tooltipFrame.tooltip1;

		local fontString1f1 = tooltipFrame.fontString1f1;
		local fontString1f2 = tooltipFrame.fontString1f2;

		local fontString2h = tooltipFrame.fontString2h;
		local tooltip2 = tooltipFrame.tooltip2;

		local fontString2f1 = tooltipFrame.fontString2f1;
		local fontString2f2 = tooltipFrame.fontString2f2;

		tooltipFrame:ClearAllPoints();
		tooltipFrame:SetPoint("BOTTOMRIGHT", icon, "TOPLEFT", -4, 4);
		tooltipFrame:Show();
		tooltipFrame:SetAlpha(0.0);
		if curRank == 0 then
			fontString1h:Show();
			--tooltip1:Show();
			fontString1f1:Show();
			fontString1f2:Show();
			fontString2h:Hide();
			tooltip2:Hide();
			fontString2f1:Hide();
			fontString2f2:Hide();

			fontString1h:SetText(L.nextRank);
			if icon.active then
				fontString1h:SetTextColor(setting.color_iconToolTipNextRank[1], setting.color_iconToolTipNextRank[2], setting.color_iconToolTipNextRank[3], setting.color_iconToolTipNextRank[4]);
			else
				fontString1h:SetTextColor(setting.color_iconToolTipNextRankDisabled[1], setting.color_iconToolTipNextRankDisabled[2], setting.color_iconToolTipNextRankDisabled[3], setting.color_iconToolTipNextRankDisabled[4]);
			end

			tooltip1:SetBackdrop(setting.tooltipBackdrop);
			tooltip1:SetOwner(tooltipFrame, "ANCHOR_NONE");
			tooltip1:SetPoint("TOPLEFT", fontString1h, "BOTTOMLEFT", 0, 6);
			tooltip1:SetSpellByID(spellTable[1]);
			fontString1f2:SetText(tostring(spellTable[1]));
			tooltip1:SetAlpha(0.0);

			tooltipFrame.delay = setting.TOOLTIP_UPDATE_DELAY;
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
					self:SetHeight(self.fontString1h:GetHeight() + tooltip1:GetHeight() + self.fontString1f2:GetHeight());
					self:SetAlpha(1.0);
					tooltip1:SetAlpha(1.0);
				else
					self:Hide();
				end
			end);
		elseif curRank == maxRank then
			fontString1h:Show();
			--tooltip1:Show();
			fontString1f1:Show();
			fontString1f2:Show();
			fontString2h:Hide();
			tooltip2:Hide();
			fontString2f1:Hide();
			fontString2f2:Hide();

			fontString1h:SetText(L.maxRank);
			fontString1h:SetTextColor(setting.color_iconToolTipMaxRank[1], setting.color_iconToolTipMaxRank[2], setting.color_iconToolTipMaxRank[3], setting.color_iconToolTipMaxRank[4]);

			tooltip1:SetBackdrop(setting.tooltipBackdrop);
			tooltip1:SetOwner(tooltipFrame, "ANCHOR_NONE");
			tooltip1:SetPoint("TOPLEFT", fontString1h, "BOTTOMLEFT", 0, 6);
			tooltip1:SetSpellByID(spellTable[maxRank]);
			fontString1f2:SetText(tostring(spellTable[maxRank]));
			tooltip1:SetAlpha(0.0);

			tooltipFrame.delay = setting.TOOLTIP_UPDATE_DELAY;
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
					self:SetHeight(self.fontString1h:GetHeight() + tooltip1:GetHeight() + self.fontString1f2:GetHeight());
					self:SetAlpha(1.0);
					tooltip1:SetAlpha(1.0);
				else
					self:Hide();
				end
			end);
		else
			fontString1h:Show();
			--tooltip1:Show();
			fontString1f1:Show();
			fontString1f2:Show();
			fontString2h:Show();
			--tooltip2:Show();
			fontString2f1:Show();
			fontString2f2:Show();

			fontString1h:SetText(L.curRank);
			fontString1h:SetTextColor(setting.color_iconToolTipCurRank[1], setting.color_iconToolTipCurRank[2], setting.color_iconToolTipCurRank[3], setting.color_iconToolTipCurRank[4]);

			tooltip1:SetBackdrop(setting.tooltipBackdrop);
			tooltip1:SetOwner(tooltipFrame, "ANCHOR_NONE");
			tooltip1:SetPoint("TOPLEFT", fontString1h, "BOTTOMLEFT", 0, 6);
			tooltip1:SetSpellByID(spellTable[curRank]);
			fontString1f2:SetText(tostring(spellTable[curRank]));
			tooltip1:SetAlpha(0.0);

			fontString2h:SetText(L.nextRank);
			if icon.active then
				fontString2h:SetTextColor(setting.color_iconToolTipNextRank[1], setting.color_iconToolTipNextRank[2], setting.color_iconToolTipNextRank[3], setting.color_iconToolTipNextRank[4]);
			else
				fontString2h:SetTextColor(setting.color_iconToolTipNextRankDisabled[1], setting.color_iconToolTipNextRankDisabled[2], setting.color_iconToolTipNextRankDisabled[3], setting.color_iconToolTipNextRankDisabled[4]);
			end

			tooltip2:SetBackdrop(setting.tooltipBackdrop);
			tooltip2:SetOwner(tooltipFrame, "ANCHOR_NONE");
			tooltip2:SetPoint("TOPLEFT", fontString2h, "BOTTOMLEFT", 0, 6);
			tooltip2:SetSpellByID(spellTable[curRank + 1]);
			fontString2f2:SetText(tostring(spellTable[curRank + 1]));
			tooltip2:SetAlpha(0.0);

			tooltipFrame.delay = setting.TOOLTIP_UPDATE_DELAY;
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
					self:SetHeight(self.fontString1h:GetHeight() + tooltip1:GetHeight() + self.fontString1f1:GetHeight() + self.fontString2h:GetHeight() + tooltip2:GetHeight() + self.fontString2f1:GetHeight() - 8);
					self:SetAlpha(1.0);
					tooltip1:SetAlpha(1.0);
					tooltip2:SetAlpha(1.0);
				else
					self:Hide();
				end
			end);
		end
	end

	function emu.EmuSub_SpellTabUpdate(spellTabFrame, class, level)
		local list = spellTabFrame.list;
		wipe(list);
		list.class = class;
		local showAll = spellTabFrame.showAllSpell:GetChecked();
		local search = spellTabFrame.searchEdit:GetText();
		if search == "" then search = nil; end
		local talentFrames = spellTabFrame:GetParent().talentFrames;
		local S = _spellDB[class];
			for _, s in pairs(S) do
				if not s.talent or talentFrames[s.requireSpecIndex].talentSet[s.requireIndex] > 0 then
					for i = 1, #s do
						local v = s[i];
						if not search or strfind(GetSpellInfo(v[2]), search) then
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

	function emu.EmuSub_NotifyEquipmentInfo(name)
		if not config.show_equipment then return; end
		local meta = emu.winMan_GetSpecializedMeta(name);
		for i = 2, #meta do
			meta[i].objects.equipmentButton:Show();
		end
	end
	function emu.EmuSub_GetEquipmentInfo(meta)
		meta = meta or {  };
		wipe(meta);
		local _;
		for slot = 0, 19 do
			local link = GetInventoryItemLink('player', slot);
			if link then
				_, _, link = strfind(link, "\124H(item:[%-0-9:]+)\124h");
			end
			link = link or "item:-1";
			meta[slot] = link;
		end
		return meta;
	end

	function emu.CHAT_MSG_ADDON(self, event, prefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID)
		if prefix == ADDON_PREFIX then
			local control_code = strsub(text, 1, ADDON_MSG_CONTROL_CODE_LEN);
			if control_code == ADDON_MSG_QUERY then
				local class, data, level = emu.GetPlayerTalentData();
				if class then
					local code = emu.EmuCore_Encoder(class, data, level);
					SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY .. code, "WHISPER", sender);
					SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPPK .. emu.get_pack(), "WHISPER", sender);
				end
			elseif control_code == ADDON_MSG_QUEEQ then
				local meta = emu.EmuSub_GetEquipmentInfo();
				local msg = "";
				local n = 0;
				for slot = 0, 19 do
					msg = msg .. "#" .. slot .. "#" .. meta[slot];
					n = n + 1;
					if n >= 4 then
						n = 0;
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPEQ .. msg, "WHISPER", sender);
						msg = "";
					end
				end
			elseif control_code == ADDON_MSG_REPLY then
				local code = strsub(text, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
				if code and code ~= "" then
					local class, data, level = emu.EmuCore_Decoder(code);
					if class and data and level then
						local n, r =strsplit("-", sender);
						if n and r == emu.realm then
							sender = n;
						end
						local readOnly = false;
						if n == emu.playerName then
							readOnly = false;
						else
							readOnly = true;
						end
						local specializedMainFrame = emu.specializedMainFrameInspect[sender];
						if specializedMainFrame then
							if specializedMainFrame[2]:IsShown() and specializedMainFrame[1] - GetTime() <= setting.INSPECT_WAIT_TIME then
								emu.Emu_Set(specializedMainFrame[2], class, data, level, readOnly, sender);
							else
								emu.Emu_Create(nil, class, data, level, readOnly, sender);
							end
						else
							emu.Emu_Create(nil, class, data, level, readOnly, sender);
						end
					end
				end
			elseif control_code == ADDON_MSG_REPEQ then
				local code = strsub(text, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
				-- queryCache
				-- emu.specializedMainFrameInspect
				if code and code ~= "" then
					local n, r =strsplit("-", sender);
					if n and r == emu.realm then
						sender = n;
					end
					-- #0#item:-1#1#item:123:::::#2#item:444:::::#3#item:-1
					-- #(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)#(%d)#(item:[%-0-9:]+)
					local start = 1;
					local _ = nil;
					local slot = nil;
					local item = nil;
					emu.queryCache[sender] = emu.queryCache[sender] or {  };
					-- wipe(emu.queryCache[sender]);
					while true do
						_, start, slot, item = strfind(code, "#(%d+)#(item:[%-0-9:]+)", start);
						if slot and item then
							slot = tonumber(slot);
							if slot and slot >= 0 and slot <= 19 then
								local _, _, id = strfind(item, "item:([%-0-9]+)");
								id = tonumber(id);
								if id and id > 0 then
									-- local _, link = GetItemInfo(id);
									-- if link then
									-- 	link = gsub(link, "item[%-0-9:]+", item);
									-- 	emu.queryCache[sender][slot] = link;
									-- else
									-- 	_error_("emu", item, id, link);
									-- end
									GetItemInfo(id);
									emu.queryCache[sender][slot] = item;
								else
									emu.queryCache[sender][slot] = nil;
								end
								emu.EmuSub_NotifyEquipmentInfo(sender);
							end
						else
							break;
						end
						if not start then
							break;
						end
					end
				end
			elseif control_code == ADDON_MSG_REPPK then
				if config.inspect_pack then
					emu.display_pack(strsub(text, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1));
				end
			elseif control_code == ADDON_MSG_PULL then
			end
		elseif extern.addon[prefix] then
			-- local msg = _detalhes:Serialize (CONST_ANSWER_TALENTS, UnitName("player"), GetRealmName(), _detalhes.realversion, UnitGUID ("player"), 0, compressedTalents, Details.playerClassicSpec.specs)
			-- local msg = CONST_ANSWER_TALENTS .. UnitName("player") .. GetRealmName() .. _detalhes.realversion .. UnitGUID ("player") .. 0 .. compressedTalents .. Details.playerClassicSpec.specs
			-- (CONST_DETAILS_PREFIX, msg, "WHISPER", targetPlayer)
		end
	end
	function emu._EventVehicle_OnEvent(self, event, ...)
		emu.CHAT_MSG_ADDON(self, event, ...);
	end
end

do	-- external func
	function emu.Emu_Add(self, numPoints)
		emu.EmuCore_ChangePoint(self, numPoints);
	end
	function emu.Emu_Sub(self, numPoints)
		emu.EmuCore_ChangePoint(self, - numPoints);
	end
	function emu.Emu_Set(mainFrame, class, data, level, readOnly, name)
		emu.EmuCore_Reset(mainFrame);
		if not emu.EmuCore_SetClass(mainFrame, class) then
			mainFrame:Hide();
			return false;
		end
		if data then
			emu.EmuCore_SetData(mainFrame, data);
		end
		emu.EmuCore_SetLevel(mainFrame, level);
		emu.EmuCore_SetReadOnly(mainFrame, readOnly);

		emu.EmuCore_SetName(mainFrame, name);

		return true;
	end
	function emu.Emu_ResetTalent(mainFrame)
		local talentFrames = mainFrame.talentFrames;
		for specIndex = 1, 3 do
			local talentFrame = talentFrames[specIndex];
			emu.EmuSub_ResetTalentSingleTab(talentFrame);
			-- local talentIcons = talentFrame.talentIcons;
			-- local db = talentFrame.db;
			-- for i = 1, #db do
			-- 	local data = db[i];
			-- 	local icon = talentIcons[data[10]];
			-- 	if data[1] ~= 0 or data[5] then
			-- 		emu.EmuSub_DeactiveIcon(icon);
			-- 	else
			-- 		emu.EmuSub_ActivateIcon(icon);
			-- 		emu.EmuSub_UnlightIcon(icon);
			-- 	end
			-- 	icon.curVal:SetText("0");
			-- end

			-- local talentSet = talentFrame.talentSet;
			-- for i = 1, MAX_NUM_TALENTS do
			-- 	talentSet[i] = 0;
			-- end
			-- for i = 0, MAX_NUM_TIER do
			-- 	talentSet.totalPerTier[i] = 0;
			-- end
			-- talentSet.total = 0;
			-- talentSet.curAvailableTopTier = 0;
			-- talentSet.curCheckedTier = 0;

			-- talentFrame.curTabPoints:SetText(0);
		end

		-- mainFrame.totalUsedPoints = 0;

		-- emu.EmuSub_UpdateLabelText(mainFrame);
	end
	function emu.Emu_ResetTalentSingleTab(mainFrame, specIndex)
		local talentFrame = mainFrame.talentFrames[specIndex];
		emu.EmuSub_ResetTalentSingleTab(talentFrame);
		-- local talentIcons = talentFrame.talentIcons;
		-- local db = talentFrame.db;
		-- for i = 1, #db do
		-- 	local data = db[i];
		-- 	local icon = talentIcons[data[10]];
		-- 	if data[1] ~= 0 or data[5] then
		-- 		emu.EmuSub_DeactiveIcon(icon);
		-- 	else
		-- 		emu.EmuSub_ActivateIcon(icon);
		-- 		emu.EmuSub_UnlightIcon(icon);
		-- 	end
		-- 	icon.curVal:SetText("0");
		-- end

		-- local talentSet = talentFrame.talentSet;
		-- for i = 1, MAX_NUM_TALENTS do
		-- 	talentSet[i] = 0;
		-- end
		-- for i = 0, MAX_NUM_TIER do
		-- 	talentSet.totalPerTier[i] = 0;
		-- end
		-- talentSet.total = 0;
		-- talentSet.curAvailableTopTier = 0;
		-- talentSet.curCheckedTier = 0;

		-- talentFrame.curTabPoints:SetText(0);

		-- mainFrame.totalUsedPoints = 0;
		-- for index = 1, 3 do
		-- 	mainFrame.totalUsedPoints = mainFrame.totalUsedPoints + mainFrame.talentFrames[index].talentSet.total;
		-- end

		-- emu.EmuSub_UpdateLabelText(mainFrame);
	end
	function emu.Emu_ResetToEmu(mainFrame)
		emu.EmuCore_SetName(mainFrame, nil);
		emu.EmuCore_SetData(mainFrame, nil);
		emu.EmuCore_SetLevel(mainFrame, setting.DEFAULT_LEVEL);
		emu.EmuCore_SetReadOnly(mainFrame, false);
	end
	function emu.Emu_ResetToSet(mainFrame)
		local class = mainFrame.class;
		local data = mainFrame.data;
		local level = mainFrame.level;
		local readOnly = mainFrame.readOnly;
		local name = mainFrame.name;
		local tab = mainFrame.curTab;
		emu.EmuCore_Reset(mainFrame);
		emu.Emu_Set(mainFrame, class, data, level, readOnly, name);
		emu.Emu_ChangeTab_Style2(mainFrame, tab);
	end
	function emu.Emu_Query(name)
		if name then
			SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY, "WHISPER", name);
			SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUEEQ, "WHISPER", name);
			for _, val in pairs(extern.addon) do
				SendAddonMessage(val.prefix, val.msg, "WHISPER", name);
			end
		end
	end
	function emu.Emu_ApplyTalents(mainFrame)
		if InCombatLockdown() then
			_error_("In COMBAT");
			return;
		end
		if emu.playerClass_Lower == strlower(mainFrame.class) then
			if TalentFrame_Update then
				TalentFrame_Update();
			end
			if emu.GetPiontsReqLevel(mainFrame.totalUsedPoints) > UnitLevel('player') then
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
				emu.processApplyTalents(mainFrame);
			else
				_error_("CANNOT APPLY : TALENTS IN CONFLICT.");
			end
		end
	end

	function emu.Emu_DestroyMainFrameById(winId)
		return emu.winMan_RelWin(winId);
	end
	function emu.Emu_DestroyMainFrame(mainFrame)
		return emu.winMan_RelWin(mainFrame.id);
	end
	function emu.Emu_Create(mainFrame, class, data, level, readOnly, name, style, ...)
		if config.singleFrame then
			mainFrame = mainFrame or emu.winMan_GetWin(1);
		else
			mainFrame = mainFrame or emu.winMan_GetWin();
		end
		emu.mainFrameSetStyle(mainFrame, style or config.style);
		mainFrame:Show();
		if config.singleFrame then
			if class and class ~= "" then
				if not emu.Emu_Set(mainFrame, class, data, tonumber(level) or 60, readOnly, name) then
					mainFrame:Hide();
					return nil;
				end
			end
			if not mainFrame.initialized then
				class = emu.playerClass_Lower;
				if not emu.Emu_Set(mainFrame, class, nil, 60, nil, nil) then
					mainFrame:Hide();
					return nil;
				end
			end
		else
			if not class or class == "" then
				class = emu.playerClass_Lower;
			end
			if not emu.Emu_Set(mainFrame, class, data, tonumber(level) or 60, readOnly, name) then
				mainFrame:Hide();
				return nil;
			end
		end
		return mainFrame.id;
	end
	function emu.Emu_Import(mainFrame, code)
		if type(mainFrame) == 'string' then
			code = mainFrame;
			mainFrame = nil;
		end
		local class, data, level = emu.EmuCore_Decoder(code);
		if class and data and level then
			mainFrame = mainFrame or emu.winMan_GetWin();
			if not emu.Emu_Set(mainFrame, class, data, level) then
				mainFrame:Hide();
				return false;
			end
			return true;
		end
		return false;
	end
	function emu.Emu_Export(_1, _2, _3)
		if not _1 then
			return nil;
		elseif type(_1) == 'number' then
			if type(_2) == 'string' then
				return emu.EmuCore_Encoder(_1, _2, _3);
			else
				_1 = emu.winMan_GetWin(_1);
				if not _1 then
					return nil;
				end
				return emu.EmuCore_Encoder(_1, _2, _3);
			end
		else
			return emu.EmuCore_Encoder(_1, _2, _3);
		end
	end

	function emu.Emu_ChangeTab_Style2(mainFrame, tab)
		if mainFrame.style ~= 2 then
			return;
		end
		if tab <= 0 or tab > 3 then
			return;
		end
		local talentFrames = mainFrame.talentFrames;
		local specButtons = mainFrame.specButtons;
		if mainFrame.curTab ~= tab then
			talentFrames[mainFrame.curTab]:Hide();
			talentFrames[tab]:Show();
			mainFrame.curTab = tab;
			local curTabIndicator = mainFrame.objects.curTabIndicator;
			curTabIndicator:ClearAllPoints();
			curTabIndicator:SetPoint("CENTER", specButtons[tab]);
			-- curTabIndicator:SetScale(1.5);
			for i = 1, 3 do
				if i == tab then
					specButtons[i]:SetSize(setting.specTabButtonWidth * 1.28, setting.specTabButtonHeight * 1.28);
				else
					specButtons[i]:SetSize(setting.specTabButtonWidth * 0.86, setting.specTabButtonHeight * 0.86);
				end
			end
		end
	end
	function emu.mainFrameSetStyle(mainFrame, style)
		local talentFrames = mainFrame.talentFrames;
		if mainFrame.style ~= style then
			mainFrame.style = style;
			if style == 1 then
				talentFrames[1]:Show();
				talentFrames[2]:Show();
				talentFrames[3]:Show();
				talentFrames[2]:ClearAllPoints();
				talentFrames[2]:SetPoint("CENTER", mainFrame, "CENTER", 0, (setting.mainFrameFooterYSize - setting.mainFrameHeaderYSize) * 0.5);
				talentFrames[1]:ClearAllPoints();
				talentFrames[1]:SetPoint("TOPRIGHT", talentFrames[2], "TOPLEFT");
				talentFrames[1]:SetPoint("BOTTOMRIGHT", talentFrames[2], "BOTTOMLEFT");
				talentFrames[3]:ClearAllPoints();
				talentFrames[3]:SetPoint("TOPLEFT", talentFrames[2], "TOPRIGHT");
				talentFrames[3]:SetPoint("BOTTOMLEFT", talentFrames[2], "BOTTOMRIGHT");
				local specButtons = mainFrame.specButtons;
				for i = 1, 3 do
					specButtons[i]:Hide();
				end
				mainFrame.objects.curTabIndicator:Hide();
				mainFrame:SetMinResize(setting.mainFrameXSizeMin_Style1, setting.mainFrameYSizeMin_Style1);

				local scale = (mainFrame:GetHeight() - setting.talentFrameYToBorder * 2) / (setting.talentFrameYSize + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize);
				mainFrame.talentFrameScale = scale;
				mainFrame:SetWidth(scale * setting.talentFrameXSizeTriple + setting.talentFrameXToBorder * 2);
			elseif style == 2 then
				talentFrames[1]:Hide();
				talentFrames[2]:Hide();
				talentFrames[3]:Hide();
				talentFrames[mainFrame.curTab]:Show();
				talentFrames[2]:ClearAllPoints();
				talentFrames[2]:SetPoint("CENTER", mainFrame, "CENTER", 0, (setting.mainFrameFooterYSize_Style2 - setting.mainFrameHeaderYSize) * 0.5);
				talentFrames[1]:ClearAllPoints();
				talentFrames[1]:SetPoint("TOPLEFT", talentFrames[2], "TOPLEFT");
				talentFrames[1]:SetPoint("BOTTOMRIGHT", talentFrames[2], "BOTTOMRIGHT");
				talentFrames[3]:ClearAllPoints();
				talentFrames[3]:SetPoint("TOPLEFT", talentFrames[2], "TOPLEFT");
				talentFrames[3]:SetPoint("BOTTOMRIGHT", talentFrames[2], "BOTTOMRIGHT");
				local specButtons = mainFrame.specButtons;
				for i = 1, 3 do
					specButtons[i]:Show();
				end
				local curTabIndicator = mainFrame.objects.curTabIndicator;
				curTabIndicator:Show();
				curTabIndicator:ClearAllPoints();
				curTabIndicator:SetPoint("CENTER", specButtons[mainFrame.curTab]);
				mainFrame:SetMinResize(setting.mainFrameXSizeMin_Style2, setting.mainFrameYSizeMin_Style2);

				local scale = (mainFrame:GetHeight() - setting.talentFrameYToBorder * 2) / (setting.talentFrameYSize + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize_Style2);
				mainFrame.talentFrameScale = scale;
				mainFrame:SetWidth(scale * setting.talentFrameXSizeSingle + setting.talentFrameXToBorder * 2);
			else
				return;
			end
		end
	end
end

local function Config_SetSingleFrame(singleFrame, curFrame)
	config.singleFrame = singleFrame;
	if singleFrame then
		local last = curFrame or emu.winMan_GetLastWin();
		emu.winMan_RelAllButOne(last and last.id or nil);
	end
end
local function Config_SetStyle(style, alsoSetShownWin)
	config.style = style;
	if alsoSetShownWin then
		for i = 1, emu.mainFrames.used do
			emu.mainFrameSetStyle(emu.mainFrames[i], style);
		end
	end
end

local function Info_OnEnter(self, motion)
	if self.information then
		-- GameTooltip:ClearAllPoints();
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		GameTooltip:SetText(self.information, 1.0, 1.0, 1.0);
	end
end
local function Info_OnLeave(self, motion)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end

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
		end
	end
	function emu.Emu_ToggleEquipmentFrame(mainFrame)
		local equipmentFrame = mainFrame.equipmentFrame;
		if equipmentFrame:IsShown() then
			equipmentFrame:Hide();
		else
			equipmentFrame:Show();
		end
	end
	function emu.Emu_SetEquipment(icon, slot, item)
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
	function emu.Emu_SetEquipments(equipmentContainer, meta)
		local slots = equipmentContainer.slots;
		for slot = 0, 19 do
			emu.Emu_SetEquipment(slots[slot], slot, meta[slot])
		end
	end
	function emu.CreateEquipmentFrame(mainFrame)
		local equipmentFrame = CreateFrame("Frame", nil, mainFrame);
		equipmentFrame:SetWidth(setting.equipmentFrameXSize);
		equipmentFrame:SetHeight(mainFrame:GetHeight());
		equipmentFrame:SetPoint("RIGHT", mainFrame, "LEFT", 0, 0);
		equipmentFrame:Hide();
		equipmentFrame:SetBackdrop(setting.equipmentFrameBackdrop);
		equipmentFrame:SetBackdropColor(unpack(setting.equipmentFrameBackdropColor));
		equipmentFrame:SetBackdropBorderColor(unpack(setting.equipmentFrameBackdropBorderColor));
		local equipmentContainer = CreateFrame("Frame", nil, equipmentFrame);
		equipmentContainer:SetPoint("CENTER");
		equipmentContainer:SetSize(setting.equipmentFrameXSize, setting.equipmentContainerYSize);
		equipmentContainer:Show();
		local slots = {  };
		for slot = 0, 19 do
			local icon = CreateFrame("Button", nil, equipmentContainer);
			icon:SetSize(setting.equipmentFrameButtonSize, setting.equipmentFrameButtonSize);
			icon:Show();
	
			icon:EnableMouse(true);
			icon:SetScript("OnEnter", slot_OnEnter);
			icon:SetScript("OnLeave", slot_OnLeave);
			icon:SetScript("OnClick", slot_OnClick);
	
			icon:SetNormalTexture(TEXTURE_SET.UNK);
			-- icon:SetPushedTexture(TEXTURE_SET.UNK);
			icon:SetHighlightTexture(TEXTURE_SET.EQUIPMENT_HIGHLIGHT);
			icon:GetHighlightTexture():SetTexCoord(TEXTURE_SET.EQUIPMENT_HIGHLIGHT_COORD[1], TEXTURE_SET.EQUIPMENT_HIGHLIGHT_COORD[2], TEXTURE_SET.EQUIPMENT_HIGHLIGHT_COORD[3], TEXTURE_SET.EQUIPMENT_HIGHLIGHT_COORD[4]);
			-- icon:SetHighlightTexture(TEXTURE_SET.SQUARE_HIGHLIGHT);
			-- icon:GetHighlightTexture():SetTexCoord(TEXTURE_SET.ICON_HIGHLIGHT_COORD[1], TEXTURE_SET.ICON_HIGHLIGHT_COORD[2], TEXTURE_SET.ICON_HIGHLIGHT_COORD[3], TEXTURE_SET.ICON_HIGHLIGHT_COORD[4]);
			-- icon:GetHighlightTexture():SetVertexColor(TEXTURE_SET.ICON_HIGHLIGHT_COLOR[1], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[2], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[3], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[4]);
	
			local glow = icon:CreateTexture(nil, "OVERLAY");
			glow:SetAllPoints(true);
			glow:SetTexture(TEXTURE_SET.EQUIPMENT_GLOW);
			glow:SetBlendMode("ADD");
			glow:SetTexCoord(unpack(TEXTURE_SET.EQUIPMENT_GLOW_COORD));
			-- glow:SetAlpha(0.75);
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
		for i, index in pairs(L) do
			local slot = slots[index];
			slot:SetPoint("TOPLEFT", setting.equipmentFrameButtonXToBorder, - setting.equipmentFrameButtonYToBorder - (setting.equipmentFrameButtonSize + setting.equipmentFrameButtonGap) * (i - 1));
			slot.name:SetPoint("TOPLEFT", slot, "TOPRIGHT", setting.equipmentFrameIconTextGap, 0);
		end
		for i, index in pairs(R) do
			local slot = slots[index];
			slot:SetPoint("TOPRIGHT", - setting.equipmentFrameButtonXToBorder, - setting.equipmentFrameButtonYToBorder - (setting.equipmentFrameButtonSize + setting.equipmentFrameButtonGap) * (i - 1));
			slot.name:SetPoint("BOTTOMRIGHT", slot, "BOTTOMLEFT", - setting.equipmentFrameIconTextGap, 0);
		end
		for i, index in pairs(B) do
			local slot = slots[index];
			slot:SetPoint("BOTTOM", 
				(fmod(i - 1 , 2) - 0.5) * (setting.equipmentFrameButtonSize + setting.equipmentFrameButtonGap), 
				(2 - floor((i - 1) / 2)) * (setting.equipmentFrameButtonSize + setting.equipmentFrameButtonGap) - setting.equipmentFrameButtonGap);
			if fmod(i - 1 , 2) == 0 then
				slot.name:SetPoint("RIGHT", slot, "LEFT", - setting.equipmentFrameIconTextGap, 0);
			else
				slot.name:SetPoint("LEFT", slot, "RIGHT", setting.equipmentFrameIconTextGap, 0);
			end
		end
		equipmentFrame.equipmentContainer = equipmentContainer;
		equipmentContainer.slots = slots;
		equipmentFrame:SetScript("OnShow", function(self)
			emu.Emu_SetEquipments(equipmentContainer, emu.queryCache[mainFrame.name]);
		end);
		return equipmentFrame, equipmentContainer;
	end
end

do	-- spellTabFrame
	local function spellTabButton_OnEnter(self)
		local index = self:GetDataIndex();
		-- GameTooltip:ClearAllPoints();
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		local data = self.list[index];
		GameTooltip:SetSpellByID(data[2]);
		GameTooltip:Show();
		if data[5] and data[1] > 0 then
			GameTooltip:AddDoubleLine(L.spellTabGTTSpellLevel .. data[5], L.spellTabGTTReqLevel .. data[1], 1.0, 0.75, 0.5, 1.0, 0.75, 0.5);
		elseif data[5] then
			GameTooltip:AddLine(L.spellTabGTTSpellLevel .. data[5], 1.0, 0.75, 0.5);
		elseif data[1] > 0 then
			GameTooltip:AddLine(L.spellTabGTTReqLevel .. data[1], 1.0, 0.75, 0.5);
		end
		if emu.playerClass_Lower == self.list.class then
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
	end
	local function spellTabButton_OnDragStart(self)
		self:StopMovingOrSizing();
		local index = self:GetDataIndex();
		local data = self.list[index];
		if not data[6] and FindSpellBookSlotBySpellID(data[2]) then
			PickupSpell(data[2]);
		end
	end
	function emu.Emu_ToggleSpellTab(mainFrame)
		local spellTabFrame = mainFrame.spellTabFrame;
		local side_anchor = mainFrame.side_anchor;
		if spellTabFrame:IsShown() then
			spellTabFrame:Hide();
			side_anchor:ClearAllPoints();
			side_anchor:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 2, 0);
			side_anchor:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMRIGHT", 2, 0);
		else
			spellTabFrame:Show();
			emu.EmuSub_SpellTabUpdate(spellTabFrame, mainFrame.class, emu.GetPiontsReqLevel(mainFrame.totalUsedPoints));
			side_anchor:ClearAllPoints();
			side_anchor:SetPoint("TOPLEFT", spellTabFrame, "TOPRIGHT", 2, 0);
			side_anchor:SetPoint("BOTTOMLEFT", spellTabFrame, "BOTTOMRIGHT", 2, 0);
		end
	end
	local function funcToCreateButton(parent, index, buttonHeight)
		local button = CreateFrame("Button", nil, parent);
		button:SetHeight(setting.spellTabFrameButtonHeight);
		button:SetBackdrop(setting.spellTabFrameButtonBackdrop);
		button:SetBackdropColor(unpack(setting.spellTabFrameButtonBackdropColor));
		button:SetBackdropBorderColor(unpack(setting.spellTabFrameButtonBackdropBorderColor));
		button:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
		button:EnableMouse(true);
		button:Show();
	
		local icon = button:CreateTexture(nil, "OVERLAY");
		icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
		icon:SetSize(setting.spellTabFrameButtonHeight - 4, setting.spellTabFrameButtonHeight - 4);
		icon:SetPoint("LEFT", 4, 0);
		button.icon = icon;
	
		local title = button:CreateFontString(nil, "OVERLAY");
		title:SetFont(setting.spellTabFrameFont, setting.spellTabFrameFontSize, setting.spellTabFrameFontOutline);
		title:SetPoint("LEFT", icon, "RIGHT", 4, 0);
		button.title = title;
	
		local glow = button:CreateTexture(nil, "OVERLAY");
		glow:SetTexture("Interface\\Buttons\\UI-ActionButton-Border");
		glow:SetTexCoord(0.25, 0.75, 0.25, 0.75);
		glow:SetAllPoints(true);
		glow:SetBlendMode("ADD");
		glow:Hide();
		button.glow = glow;

		button:SetScript("OnEnter", spellTabButton_OnEnter);
		button:SetScript("OnLeave", spellTabButton_OnLeave);
		button:SetScript("OnClick", spellTabButton_OnClick);
		button:RegisterForDrag("LeftButton");
		button:SetScript("OnDragStart", spellTabButton_OnDragStart);

		button.list = parent:GetParent():GetParent().list;

		return button;
	end
	local function functToSetButton(button, data_index)
		local list = button.list;
		local n = #list;
		if data_index <= #list then
			local name, _, texture = GetSpellInfo(list[data_index][2]);
			button.icon:SetTexture(texture);
			button.title:SetText(name);
			button:Show();
		else
			button:Hide();
		end
	end
	function emu.CreateSpellTabFrame(mainFrame)
		local spellTabFrame = CreateFrame("Frame", mainFrame:GetName() .. "SpellTab", mainFrame);
		-- spellTabFrame:SetPoint("TOPRIGHT", mainFrame, "TOPLEFT", 0, 0);
		spellTabFrame:SetPoint("LEFT", mainFrame, "RIGHT", 0, 0);
		-- spellTabFrame:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMLEFT", 0, 0);
		spellTabFrame:SetWidth(setting.spellTabFrameWidth);
		spellTabFrame:SetBackdrop(setting.spellTabFrameBackdrop);
		spellTabFrame:SetBackdropColor(unpack(setting.spellTabFrameBackdropColor));
		spellTabFrame:SetBackdropBorderColor(unpack(setting.spellTabFrameBackdropBorderColor));
		spellTabFrame:Hide();
		--	scroll = ALASCR(parent, width, height, buttonHeight, funcToCreateButton(parent, index, buttonHeight), functToSetButton(button, data_index))
		local scroll = ALASCR(spellTabFrame, spellTabFrame:GetWidth() - 20, spellTabFrame:GetHeight() - 20, setting.spellTabFrameButtonHeight, funcToCreateButton, functToSetButton);
		scroll:SetPoint("BOTTOMLEFT", 4, 24);
		scroll:SetPoint("TOPRIGHT", - 4, - 24);
		spellTabFrame.scroll = scroll;
		spellTabFrame:SetScript("OnSizeChanged", function()
			-- scroll:SetSize(spellTabFrame:GetWidth() - 20, spellTabFrame:GetHeight() - 20);
		end);
		spellTabFrame.list = {  };

		local searchEdit = CreateFrame("EditBox", nil, spellTabFrame);
		searchEdit:SetSize(setting.spellTabFrameWidth - 16 - 36, 16);
		searchEdit:SetFont(GameFontHighlight:GetFont(), 10, "OUTLINE");
		searchEdit:SetAutoFocus(false);
		searchEdit:SetJustifyH("LEFT");
		searchEdit:Show();
		searchEdit:EnableMouse(true);
		searchEdit:SetPoint("TOPLEFT", spellTabFrame, 8, - 4);
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
		local searchCancel = CreateFrame("Button", nil, searchEdit);
		searchCancel:SetSize(16, 16);
		searchCancel:SetPoint("RIGHT", searchEdit);
		searchCancel:SetScript("OnClick", function(self) searchEdit:SetText(""); searchEdit:ClearFocus(); end);
		searchCancel:Hide();
		searchCancel:SetNormalTexture("interface\\petbattles\\deadpeticon")
		local searchEditOK = CreateFrame("Button", nil, spellTabFrame);
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
			emu.EmuSub_SpellTabUpdate(spellTabFrame, mainFrame.class, emu.GetPiontsReqLevel(mainFrame.totalUsedPoints));
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
		spellTabFrame.searchEdit = searchEdit;
		spellTabFrame.searchEditOK = searchEditOK;


		local showAllSpell = CreateFrame("CheckButton", nil, spellTabFrame, "OptionsBaseCheckButtonTemplate");
		showAllSpell:SetSize(16, 16);
		showAllSpell:SetHitRectInsets(0, 0, 0, 0);
		showAllSpell:ClearAllPoints();
		showAllSpell:Show();
		showAllSpell:SetChecked(false);
		showAllSpell:SetPoint("BOTTOMRIGHT", - 4, 2);	
		showAllSpell:SetScript("OnClick", function(self)
			emu.EmuSub_SpellTabUpdate(spellTabFrame, mainFrame.class, emu.GetPiontsReqLevel(mainFrame.totalUsedPoints));
		end);
		spellTabFrame.showAllSpell = showAllSpell;
	
		local showAllSpellFontString = spellTabFrame:CreateFontString(nil, "ARTWORK");
		showAllSpellFontString:SetFont(GameFontHighlight:GetFont(), 10, "OUTLINE");
		showAllSpellFontString:SetText(L.showAllSpell);
		showAllSpell.fontString = showAllSpellFontString;
		showAllSpellFontString:SetPoint("RIGHT", showAllSpell, "LEFT", 0, 0);

		local close = CreateFrame("Button", nil, spellTabFrame);
		close:SetSize(32, 16);
		close:SetPoint("BOTTOMLEFT", 4, 4);
		close:SetScript("OnClick", function(self) emu.Emu_ToggleSpellTab(spellTabFrame:GetParent()); end);
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
	
		return spellTabFrame;
	end
end

do	-- tooltipFrame
	function emu.Emu_SetTooltip(icon)
		local talentFrame = icon:GetParent();
		local dbIndex = icon.dbIndex;
		local data = talentFrame.db[dbIndex];
		emu.EmuSub_TooltipSetTalent(talentFrame:GetParent().tooltipFrame, icon, data[8], talentFrame.talentSet[dbIndex], data[4]);
	end
	function emu.Emu_TooltipHide(icon)
		local tooltipFrame = icon:GetParent():GetParent().tooltipFrame;
		tooltipFrame:Hide();
		tooltipFrame.tooltip1:Hide();
		tooltipFrame.tooltip2:Hide();
	end
	function emu.CreateTooltipFrame(mainFrame)
		local tooltipFrame = CreateFrame("Frame", mainFrame:GetName() .. "TooltipFrame", mainFrame);
		tooltipFrame:SetSize(1, 1);
		tooltipFrame:SetFrameStrata("FULLSCREEN");
		tooltipFrame:SetClampedToScreen(true);
		tooltipFrame:EnableMouse(false);
		tooltipFrame:SetBackdrop(setting.tooltipFrameBackdrop);
		tooltipFrame:SetBackdropColor(setting.tooltipFrameBackdropColor[1], setting.tooltipFrameBackdropColor[2], setting.tooltipFrameBackdropColor[3], setting.tooltipFrameBackdropColor[4]);
		tooltipFrame:Hide();
		tooltipFrame:Show();

		local fontString1h = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
		fontString1h:SetPoint("TOPLEFT", 6, -6);
		local tooltip1 = CreateFrame("GameTooltip", tooltipFrame:GetName() .. "Tooltip1", UIParent, "GameTooltipTemplate");
		tooltip1:SetPoint("TOPLEFT", fontString1h, "BOTTOMLEFT", 0, 6);

		local fontString1f1 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
		fontString1f1:SetPoint("TOPLEFT", tooltip1, "BOTTOMLEFT", 12, 6);
		local fontString1f2 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
		fontString1f2:SetPoint("TOPRIGHT", tooltip1, "BOTTOMRIGHT", - 12, 6);

		local fontString2h = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
		fontString2h:SetPoint("TOPLEFT", fontString1f1, "BOTTOMLEFT", -12, -4);
		local tooltip2 = CreateFrame("GameTooltip", tooltipFrame:GetName() .. "Tooltip2", UIParent, "GameTooltipTemplate");
		tooltip2:SetPoint("TOPLEFT", fontString2h, "BOTTOMLEFT", 0, 6);

		local fontString2f1 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
		fontString2f1:SetPoint("TOPLEFT", tooltip2, "BOTTOMLEFT", 12, 6);
		local fontString2f2 = tooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
		fontString2f2:SetPoint("TOPRIGHT", tooltip2, "BOTTOMRIGHT", - 12, 6);

		fontString1h:SetText("")
		fontString2h:SetText("")

		fontString1f1:SetTextColor(0.25, 0.5, 1.0, 1.0);
		fontString1f2:SetTextColor(0.25, 0.5, 1.0, 1.0);
		fontString2f1:SetTextColor(0.25, 0.5, 1.0, 1.0);
		fontString2f2:SetTextColor(0.25, 0.5, 1.0, 1.0);

		fontString1f1:SetText("id");
		fontString2f1:SetText("id");
		fontString1f2:SetText("");
		fontString2f2:SetText("");

		tooltipFrame.fontString1h = fontString1h;
		tooltipFrame.tooltip1 = tooltip1;

		tooltipFrame.fontString1f1 = fontString1f1;
		tooltipFrame.fontString1f2 = fontString1f2;

		tooltipFrame.fontString2h = fontString2h;
		tooltipFrame.tooltip2 = tooltip2;

		tooltipFrame.fontString2f1 = fontString2f1;
		tooltipFrame.fontString2f2 = fontString2f2;

		mainFrame.tooltipFrame = tooltipFrame;
		return tooltipFrame;
	end
end

do	-- talentFrame
	local function talentIcon_OnEnter(self)
		emu.Emu_SetTooltip(self);
	end
	local function talentIcon_OnLeave(self)
		emu.Emu_TooltipHide(self);
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
				emu.Emu_Add(self, 1);
			elseif button == "RightButton" then
				emu.Emu_Sub(self, 1);
			end
		end
	end
	function emu.CreateTalentIcon(talentFrame, id)
		local icon = CreateFrame("Button", talentFrame:GetName() .. "TalentIcon" .. id, talentFrame);
		icon:SetSize(setting.talentIconSize, setting.talentIconSize);

		icon:Hide();
		icon:EnableMouse(true);
		icon:RegisterForClicks("LeftButtonUp", "RightButtonUp");
		icon:SetScript("OnClick", talentIcon_OnClick);
		icon:SetScript("OnEnter", talentIcon_OnEnter);
		icon:SetScript("OnLeave", talentIcon_OnLeave);

		-- local bg = icon:CreateTexture(nil, "BACKGROUND");
		-- bg:SetPoint("CENTER");
		-- bg:SetSize(setting.talentIconSize + 4, setting.talentIconSize + 4);
		-- bg:SetTexture(TEXTURE_SET.ICON_BG);
		-- bg:SetTexCoord(TEXTURE_SET.ICON_BG_COORD[1], TEXTURE_SET.ICON_BG_COORD[2], TEXTURE_SET.ICON_BG_COORD[3], TEXTURE_SET.ICON_BG_COORD[4]);

		--icon:SetBackdrop(setting.iconBackdrop);
		--icon:SetBackdropColor(setting.iconBackdropColor[1], setting.iconBackdropColor[2], setting.iconBackdropColor[3], setting.iconBackdropColor[4]);
		--icon:SetBackdropBorderColor(setting.iconBackdropBorderColor[1], setting.iconBackdropBorderColor[2], setting.iconBackdropBorderColor[3], setting.iconBackdropBorderColor[4]);
		icon:SetNormalTexture(TEXTURE_SET.UNK);
		icon:SetPushedTexture(TEXTURE_SET.UNK);
		icon:SetHighlightTexture(TEXTURE_SET.SQUARE_HIGHLIGHT);
		icon:GetHighlightTexture():SetTexCoord(TEXTURE_SET.ICON_HIGHLIGHT_COORD[1], TEXTURE_SET.ICON_HIGHLIGHT_COORD[2], TEXTURE_SET.ICON_HIGHLIGHT_COORD[3], TEXTURE_SET.ICON_HIGHLIGHT_COORD[4]);
		icon:GetHighlightTexture():SetVertexColor(TEXTURE_SET.ICON_HIGHLIGHT_COLOR[1], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[2], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[3], TEXTURE_SET.ICON_HIGHLIGHT_COLOR[4]);

		local split = icon:CreateFontString(nil, "ARTWORK", nil);
		split:SetFont(setting.talentIconFont, setting.talentIconFontSize, setting.talentIconFontOutline)
		split:SetText("/");
		split:SetPoint("CENTER", icon, "BOTTOMRIGHT", 0, 0);

		local maxVal = icon:CreateFontString(nil, "ARTWORK", nil);
		maxVal:SetFont(setting.talentIconFont, setting.talentIconFontSize, setting.talentIconFontOutline)
		maxVal:SetText("1");
		maxVal:SetPoint("LEFT", split, "RIGHT", 0, 0);

		local curVal = icon:CreateFontString(nil, "ARTWORK", nil);
		curVal:SetFont(setting.talentIconFont, setting.talentIconFontSize, setting.talentIconFontOutline)
		curVal:SetText("");
		curVal:SetPoint("RIGHT", split, "LEFT", 0, 0);

		icon.split = split;
		icon.maxVal = maxVal;
		icon.curVal = curVal;

		icon.id = id;
		icon.active = true;

		return icon;
	end
	function emu.CreateTalentIcons(talentFrame)
		local talentIcons = {  };
		local posX = 0;
		local posY = 0;
		for id = 1, MAX_NUM_ICONS_PER_SPEC do
			local icon = emu.CreateTalentIcon(talentFrame, id);
			icon:SetPoint("TOP", talentFrame, "TOP", (setting.talentIconSize + setting.talentIconXGap) * (posX - MAX_NUM_COL * 0.5 + 0.5), - setting.talentFrameHeaderYSize - setting.talentIconYToTop - (setting.talentIconSize + setting.talentIconYGap) * posY);
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

	function emu.talentFrameUpdateSize(mainFrame, talentFrames, width, height)
		local style = mainFrame.style;
		if style == 1 then
			local scale = min((width - setting.talentFrameXToBorder * 2) / setting.talentFrameXSizeTriple, (height - setting.talentFrameYToBorder * 2) / (setting.talentFrameYSize + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize));
			talentFrames[1]:SetScale(scale);
			talentFrames[2]:SetScale(scale);
			talentFrames[3]:SetScale(scale);
			mainFrame.talentFrameScale = scale;
		elseif style == 2 then
			local scale = min((width - setting.talentFrameXToBorder * 2) / setting.talentFrameXSizeSingle, (height - setting.talentFrameYToBorder * 2) / (setting.talentFrameYSize + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize_Style2));
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
		emu.Emu_ResetTalentSingleTab(mainFrame, specIndex);
		emu.EmuCore_SetReadOnly(mainFrame, false);
	end
	function emu.CreateTalentFrames(mainFrame)
		local talentFrames = {  };

		for specIndex = 1, 3 do
			local talentFrame = CreateFrame("Frame", mainFrame:GetName() .. "TalentFrame" .. specIndex, mainFrame);
			talentFrame:SetSize(setting.talentFrameXSizeSingle, setting.talentFrameYSize);

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
			hSep[1]:SetHeight(setting.seqWidth);
			hSep[1]:SetPoint("LEFT", talentFrame, "TOPLEFT", 0, 0);
			hSep[1]:SetPoint("RIGHT", talentFrame, "TOPRIGHT", 0, 0);
			hSep[1]:SetTexture(TEXTURE_SET.SEP_HORIZONTAL);
			hSep[1]:SetTexCoord(TEXTURE_SET.SEP_HORIZONTAL_COORD[1], TEXTURE_SET.SEP_HORIZONTAL_COORD[2], TEXTURE_SET.SEP_HORIZONTAL_COORD[3], TEXTURE_SET.SEP_HORIZONTAL_COORD[4]);
			hSep[2] = talentFrame:CreateTexture(nil, "ARTWORK");
			hSep[2]:SetHeight(setting.seqWidth);
			hSep[2]:SetPoint("LEFT", talentFrame, "BOTTOMLEFT", 0, 0);
			hSep[2]:SetPoint("RIGHT", talentFrame, "BOTTOMRIGHT", 0, 0);
			hSep[2]:SetTexture(TEXTURE_SET.SEP_HORIZONTAL);
			hSep[2]:SetTexCoord(TEXTURE_SET.SEP_HORIZONTAL_COORD[1], TEXTURE_SET.SEP_HORIZONTAL_COORD[2], TEXTURE_SET.SEP_HORIZONTAL_COORD[3], TEXTURE_SET.SEP_HORIZONTAL_COORD[4]);
			hSep[3] = talentFrame:CreateTexture(nil, "ARTWORK");
			hSep[3]:SetHeight(setting.seqWidth);
			hSep[3]:SetPoint("LEFT", talentFrame, "BOTTOMLEFT", 0, setting.talentFrameFooterYSize);
			hSep[3]:SetPoint("RIGHT", talentFrame, "BOTTOMRIGHT", 0, setting.talentFrameFooterYSize);
			hSep[3]:SetTexture(TEXTURE_SET.SEP_HORIZONTAL);
			hSep[3]:SetTexCoord(TEXTURE_SET.SEP_HORIZONTAL_COORD[1], TEXTURE_SET.SEP_HORIZONTAL_COORD[2], TEXTURE_SET.SEP_HORIZONTAL_COORD[3], TEXTURE_SET.SEP_HORIZONTAL_COORD[4]);

			talentFrame.hSep = hSep;

			local vSep = {  };
			vSep[1] = talentFrame:CreateTexture(nil, "ARTWORK");
			vSep[1]:SetWidth(setting.seqWidth);
			vSep[1]:SetPoint("TOP", talentFrame, "TOPLEFT", 0, 0);
			vSep[1]:SetPoint("BOTTOM", talentFrame, "BOTTOMLEFT", 0, 0);
			vSep[1]:SetTexture(TEXTURE_SET.SEP_VERTICAL);
			vSep[1]:SetTexCoord(TEXTURE_SET.SEP_VERTICAL_COORD[1], TEXTURE_SET.SEP_VERTICAL_COORD[2], TEXTURE_SET.SEP_VERTICAL_COORD[3], TEXTURE_SET.SEP_VERTICAL_COORD[4]);
			vSep[2] = talentFrame:CreateTexture(nil, "ARTWORK");
			vSep[2]:SetWidth(setting.seqWidth);
			vSep[2]:SetPoint("TOP", talentFrame, "TOPRIGHT", 0, 0);
			vSep[2]:SetPoint("BOTTOM", talentFrame, "BOTTOMRIGHT", 0, 0);
			vSep[2]:SetTexture(TEXTURE_SET.SEP_VERTICAL);
			vSep[2]:SetTexCoord(TEXTURE_SET.SEP_VERTICAL_COORD[1], TEXTURE_SET.SEP_VERTICAL_COORD[2], TEXTURE_SET.SEP_VERTICAL_COORD[3], TEXTURE_SET.SEP_VERTICAL_COORD[4]);

			talentFrame.vSep = vSep;

			local BG = talentFrame:CreateTexture(nil, "BORDER");
			BG:SetAllPoints(true);
			BG:SetAlpha(0.6);
			local ratio = setting.talentFrameXSizeSingle / setting.talentFrameYSize;
			if ratio > 1.0 then
				BG:SetTexCoord(0.0, 1.0, (1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5);
			elseif ratio < 1.0 then
				BG:SetTexCoord((1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5, 0.0, 1.0);
			end

			talentFrame.BG = BG;

			talentFrame.talentIcons = emu.CreateTalentIcons(talentFrame);

			local resetButtonBg = talentFrame:CreateTexture(nil, "ARTWORK");
			resetButtonBg:SetSize(setting.talentIconSize, setting.talentIconSize);
			resetButtonBg:SetPoint("CENTER", talentFrame.talentIcons[MAX_NUM_ICONS_PER_SPEC]);
			resetButtonBg:SetTexture(TEXTURE_SET.TALENT_RESET_BG);
			resetButtonBg:SetTexCoord(TEXTURE_SET.TALENT_RESET_BG_COORD[1], TEXTURE_SET.TALENT_RESET_BG_COORD[2], TEXTURE_SET.TALENT_RESET_BG_COORD[3], TEXTURE_SET.TALENT_RESET_BG_COORD[4]);
			resetButtonBg:SetVertexColor(TEXTURE_SET.TALENT_RESET_BG_COLOR[1], TEXTURE_SET.TALENT_RESET_BG_COLOR[2], TEXTURE_SET.TALENT_RESET_BG_COLOR[3], TEXTURE_SET.TALENT_RESET_BG_COLOR[4]);
			talentFrame.resetButtonBg = resetButtonBg;

			local resetButton = CreateFrame("Button", nil, talentFrame);
			resetButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
			resetButton:SetPoint("CENTER", resetButtonBg);
			resetButton:SetHighlightTexture(TEXTURE_SET.TALENT_RESET_HIGHLIGHT);
			resetButton:GetHighlightTexture():ClearAllPoints();
			resetButton:GetHighlightTexture():SetPoint("CENTER");
			resetButton:GetHighlightTexture():SetSize(setting.talentIconSize, setting.talentIconSize);
			resetButton:GetHighlightTexture():SetTexCoord(TEXTURE_SET.TALENT_RESET_HIGHLIGHT_COORD[1], TEXTURE_SET.TALENT_RESET_HIGHLIGHT_COORD[2], TEXTURE_SET.TALENT_RESET_HIGHLIGHT_COORD[3], TEXTURE_SET.TALENT_RESET_HIGHLIGHT_COORD[4]);
			resetButton:SetScript("OnClick", resetButton_OnClick);
			resetButton:SetScript("OnEnter", Info_OnEnter);
			resetButton:SetScript("OnLeave", Info_OnLeave);
			resetButton.information = L.resetButton;

			talentFrame.resetButton = resetButton;
			
			local curTabPoints = talentFrame:CreateFontString(nil, "ARTWORK");
			curTabPoints:SetPoint("CENTER", resetButton);
			curTabPoints:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			curTabPoints:SetTextColor(0.0, 1.0, 0.0, 1.0);
			curTabPoints:SetText("0");
			
			talentFrame.curTabPoints = curTabPoints;


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
		emu.Emu_ToggleEquipmentFrame(self:GetParent());
	end
	local function specButton_OnClick(self)
		emu.Emu_ChangeTab_Style2(self:GetParent():GetParent(), self.id);
	end
	local function classButton_OnClick(self, button)
		if button == "LeftButton" then
			local mainFrame = self:GetParent();
			if mainFrame.class ~= self.class then
				emu.EmuCore_Reset(mainFrame);
				emu.EmuCore_SetClass(mainFrame, self.class);
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
						emu.Emu_Set(self:GetParent(), self.class, code, 60, false);
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
		emu.Emu_ResetToEmu(self:GetParent());
		self:Hide();
	end
	local function resetToSetButton_OnClick(self)
		local mainFrame = self:GetParent();
		emu.Emu_ResetToSet(mainFrame);
		self:Hide();
	end
	local function resetAllButton_OnClick(self)
		emu.Emu_ResetTalent(self:GetParent());
		emu.EmuCore_SetReadOnly(self:GetParent(), false);
	end
	local function spellTabButton_OnClick(self)
		emu.Emu_ToggleSpellTab(self:GetParent());
	end
	local function inspectTargetButton_OnClick(self)
		if UnitExists('target') then
			local name = UnitName('target');
			if name then
				emu.specializedMainFrameInspect[name] = { GetTime(), self:GetParent(), };
				emu.Emu_Query(name);
			end
		end
	end
	StaticPopupDialogs["alaTalentEmu_apply"] = {
		text = L.applyTalentsButton_Notify,
		button1 = L.OK,
		button2 = L.Cancel,
		OnShow = function(self) end,
		OnAccept = function(self) end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 1,
	};
	local function applyTalentsButton_OnClick(self)
		if UnitLevel('player') >= 10 then
			StaticPopupDialogs["alaTalentEmu_apply"].OnAccept = function() emu.Emu_ApplyTalents(self:GetParent()); end;
			StaticPopup_Show("alaTalentEmu_apply");
		end
	end
	local function importButton_OnClick(self)
		local editBox = self:GetParent().objects.editBox;
		if editBox:IsShown() and editBox.parent == self then
			editBox:Hide();
		else
			editBox:ClearAllPoints();
			editBox:SetPoint("LEFT", self, "RIGHT", setting.editBoxYSize + 4, 0);
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
		local editBox = self:GetParent().objects.editBox;
		if editBox:IsShown() and editBox.parent == self then
			editBox:Hide();
		else
			editBox:ClearAllPoints();
			editBox:SetPoint("LEFT", self, "RIGHT", 4, 0);
			editBox.OKButton:ClearAllPoints();
			editBox.OKButton:SetPoint("LEFT", editBox, "RIGHT", 0, 0);
			-- editBox.OKButton:Hide();
			editBox.parent = self;
			if button == "LeftButton" then
				editBox:SetText(emu.EmuCore_Encoder(self:GetParent()));
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
				for key, func in pairs(extern.export) do
					tinsert(menu.elements, {
						para = { func(self:GetParent()), },
						text = key,
					});
				end
				ALADROP(self, "TOPRIGHT", menu);
			end
		end
	end
	local function saveButton_OnClick(self, button)
		if button == "LeftButton" then
			local mainFrame = self:GetParent();
			local editBox = mainFrame.objects.editBox;
			if editBox:IsShown() and editBox.parent == self then
				editBox:Hide();
			else
				editBox:ClearAllPoints();
				editBox:SetPoint("LEFT", self, "RIGHT", setting.editBoxYSize + 4, 0);
				editBox:SetText(emu.EmuSub_GenerateTitle(mainFrame));
				editBox:Show();
				editBox.OKButton:ClearAllPoints();
				editBox.OKButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
				-- editBox.OKButton:Hide();
				editBox.parent = self;
				editBox.type = "save";
			end
		elseif button == "RightButton" then
			local isEmpty = true;
			for _ in pairs(config.savedTalent) do
				isEmpty = false;
				break;
			end
			if isEmpty then
				return;
			end
			local mainFrame = self:GetParent();
			local savedTalent_OnClickData = {
				handler = function(button, title, code)
					if IsShiftKeyDown() then
						config.savedTalent[title] = nil;
					else
						emu.Emu_Import(mainFrame, code);
					end
				end,
				elements = {  }, };
			for title, code in pairs(config.savedTalent) do
				tinsert(savedTalent_OnClickData.elements, {
						para = { title, code, },
						text = title,
					}
				);
			end
			ALADROP(self, "TOPRIGHT", savedTalent_OnClickData);
		end
	end
	local function editBox_OnEnterPressed(self)
		if not self.type then
			return;
		end
		if self.type == "import" then
			if self:GetText() and self:GetText() ~= "" then
				local class, data, level = emu.EmuCore_Decoder(self:GetText());
				if class and data and level then
					emu.Emu_Set(self:GetParent(), class, data, level);
				end
			end
		elseif self.type == "save" then
			local title = self:GetText();
			if not title or title == "" then
				title = #config.savedTalent + 1;
			end
			config.savedTalent[title] = emu.EmuCore_Encoder(self:GetParent());
		end
		self:ClearFocus();
		self:Hide();
	end

	local function readOnlyButton_OnClick(self, button)
		if button == "LeftButton" then
			local mainFrame = self:GetParent();
			emu.EmuCore_SetReadOnly(mainFrame, not mainFrame.readOnly);
		elseif button == "RightButton" then
			local mainFrame = self:GetParent();
			local readOnlyButton_OnClickData = { handler = _noop_, elements = {  }, };
			if config.singleFrame then
				tinsert(readOnlyButton_OnClickData.elements, {
						handler = function(button, ...) Config_SetSingleFrame(...); end,
						para = { false, mainFrame, },
						text = L.SetSingleFrame_False,
					}
				);
			else
				tinsert(readOnlyButton_OnClickData.elements, {
						handler = function(button, ...) Config_SetSingleFrame(...); end,
						para = { true, mainFrame, },
						text = L.SetSingleFrame_True,
					}
				);
			end
			if not config.singleFrame then
				if mainFrame.style == 1 then
					tinsert(readOnlyButton_OnClickData.elements, {
							handler = function(button, ...) emu.mainFrameSetStyle(...); end,
							para = { self:GetParent(), 2, },
							text = L.SetStyleAllTo2_ThisWin,
						}
					);
				elseif mainFrame.style == 2 then
					tinsert(readOnlyButton_OnClickData.elements, {
							handler = function(button, ...) emu.mainFrameSetStyle(...); end,
							para = { self:GetParent(), 1, },
							text = L.SetStyleAllTo1_ThisWin,
						}
					);
				end
			end
			local allStyle = emu.winMan_IsAllSameStyle();
			if config.style == 1 then
				tinsert(readOnlyButton_OnClickData.elements, {
						handler = function(button, ...) Config_SetStyle(...); end,
						para = { 2, true, },
						text = L.SetStyleAllTo2_LaterWin,
					}
				);
			elseif config.style == 2 then
				tinsert(readOnlyButton_OnClickData.elements, {
						handler = function(button, ...) Config_SetStyle(...); end,
						para = { 1, true, },
						text = L.SetStyleAllTo1_LaterWin,
					}
				);
			end
			if config.inspectButtonOnUnitFrame then
				tinsert(readOnlyButton_OnClickData.elements, {
						handler = function() config.inspectButtonOnUnitFrame = false; end,
						para = {  },
						text = L.inspectButtonOnUnitFrame_Disable,
					}
				);
				if config.inspectButtonKey ~= "ALT" then
					tinsert(readOnlyButton_OnClickData.elements, {
							handler = function() config.inspectButtonKey = "ALT"; emu.inspectButtonKeyFunc = IsAltKeyDown; end,
							para = { "ALT", },
							text = L.insepctALTKEY,
						}
					);
				end
				if config.inspectButtonKey ~= "CTRL" then
					tinsert(readOnlyButton_OnClickData.elements, {
							handler = function() config.inspectButtonKey = "CTRL"; emu.inspectButtonKeyFunc = IsControlKeyDown; end,
							para = { "CTRL", },
							text = L.insepctCTRLKEY,
						}
					);
				end
				if config.inspectButtonKey ~= "SHIFT" then
					tinsert(readOnlyButton_OnClickData.elements, {
							handler = function() config.inspectButtonKey = "SHIFT"; emu.inspectButtonKeyFunc = IsShiftKeyDown; end,
							para =  { "SHIFT", },
							text = L.insepctSHIFTKEY,
						}
					);
				end
			else
				tinsert(readOnlyButton_OnClickData.elements, {
						handler = function() config.inspectButtonOnUnitFrame = true; end,
						para = {  },
						text = L.inspectButtonOnUnitFrame_Enable,
					}
				);
			end
			ALADROP(self, "BOTTOMLEFT", readOnlyButton_OnClickData);
		end
	end

	function emu.CreateMainFrameSubObject(mainFrame)
		local objects = {  };
		mainFrame.objects = objects;

		--<header>
		do
			local readOnlyButton = CreateFrame("Button", nil, mainFrame);
			readOnlyButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
			readOnlyButton:SetNormalTexture(TEXTURE_SET.LOCK);
			readOnlyButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.LOCK_UNLOCKED_COLOR[1], TEXTURE_SET.LOCK_UNLOCKED_COLOR[2], TEXTURE_SET.LOCK_UNLOCKED_COLOR[3], TEXTURE_SET.LOCK_UNLOCKED_COLOR[4]);
			readOnlyButton:SetPushedTexture(TEXTURE_SET.LOCK);
			readOnlyButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
			readOnlyButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
			readOnlyButton:SetPoint("TOPLEFT", mainFrame, (setting.mainFrameHeaderYSize - setting.controlButtonSize) * 0.5, - (setting.mainFrameHeaderYSize - setting.controlButtonSize) * 0.5);
			readOnlyButton:Show();
			readOnlyButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			readOnlyButton:SetScript("OnClick", readOnlyButton_OnClick);
			readOnlyButton:SetScript("OnEnter", Info_OnEnter);
			readOnlyButton:SetScript("OnLeave", Info_OnLeave);
			readOnlyButton.information = L.readOnlyButton;
			objects.readOnlyButton = readOnlyButton;

			-- local readOnlyText = mainFrame:CreateFontString(nil, "ARTWORK");
			-- readOnlyText:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			-- readOnlyText:SetText("");
			-- readOnlyText:SetPoint("LEFT", readOnlyButton, "RIGHT", 0, 0);
			-- objects.readOnlyText = readOnlyText;

			local closeButton = CreateFrame("Button", nil, mainFrame);
			closeButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
			closeButton:SetNormalTexture(TEXTURE_SET.CLOSE);
			closeButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.CLOSE_COORD[1], TEXTURE_SET.CLOSE_COORD[2], TEXTURE_SET.CLOSE_COORD[3], TEXTURE_SET.CLOSE_COORD[4]);
			closeButton:SetPushedTexture(TEXTURE_SET.CLOSE);
			closeButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.CLOSE_COORD[1], TEXTURE_SET.CLOSE_COORD[2], TEXTURE_SET.CLOSE_COORD[3], TEXTURE_SET.CLOSE_COORD[4]);
			closeButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
			closeButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
			closeButton:SetPoint("TOPRIGHT", - (setting.mainFrameHeaderYSize - setting.controlButtonSize) * 0.5, - (setting.mainFrameHeaderYSize - setting.controlButtonSize) * 0.5);
			closeButton:Show();
			closeButton:SetScript("OnClick", function(self, button)
					self:GetParent():Hide();
				end
			);
			closeButton:SetScript("OnEnter", Info_OnEnter);
			closeButton:SetScript("OnLeave", Info_OnLeave);
			closeButton.information = L.closeButton;
			objects.closeButton = closeButton;

			local label = mainFrame:CreateFontString(nil, "ARTWORK");
			label:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			label:SetText(L.curPointsRemaining);
			label:SetPoint("CENTER", mainFrame, "TOP", 0, - setting.mainFrameHeaderYSize * 0.5);
			objects.label = label;

			local resetToEmu = CreateFrame("Button", nil, mainFrame);
			resetToEmu:SetSize(setting.controlButtonSize, setting.controlButtonSize);
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

			local resetToSetButton = CreateFrame("Button", nil, mainFrame);
			resetToSetButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
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
			local resetAllButton = CreateFrame("Button", nil, mainFrame);
			resetAllButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
			resetAllButton:SetNormalTexture(TEXTURE_SET.RESET);
			resetAllButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.RESET_COORD[1], TEXTURE_SET.RESET_COORD[2], TEXTURE_SET.RESET_COORD[3], TEXTURE_SET.RESET_COORD[4]);
			resetAllButton:SetPushedTexture(TEXTURE_SET.RESET);
			resetAllButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.RESET_COORD[1], TEXTURE_SET.RESET_COORD[2], TEXTURE_SET.RESET_COORD[3], TEXTURE_SET.RESET_COORD[4]);
			resetAllButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
			resetAllButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
			resetAllButton:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", - 8, (setting.mainFrameFooterYSize - setting.controlButtonSize) * 0.5);
			resetAllButton:Show();
			resetAllButton:SetScript("OnClick", resetAllButton_OnClick);
			resetAllButton:SetScript("OnEnter", Info_OnEnter);
			resetAllButton:SetScript("OnLeave", Info_OnLeave);
			resetAllButton.information = L.resetAllButton;
			objects.resetAllButton = resetAllButton;

			local curPointsRemainingLabel = mainFrame:CreateFontString(nil, "ARTWORK");
			curPointsRemainingLabel:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			curPointsRemainingLabel:SetText(L.curPointsRemaining);
			curPointsRemainingLabel:SetPoint("CENTER", mainFrame, "BOTTOM", - 20, setting.mainFrameFooterYSize * 0.5);

			local curPointsRemaining = mainFrame:CreateFontString(nil, "ARTWORK");
			curPointsRemaining:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			curPointsRemaining:SetText("51");
			curPointsRemaining:SetPoint("LEFT", curPointsRemainingLabel, "RIGHT", 2, 0);

			curPointsRemainingLabel:SetTextColor(0.0, 1.0, 1.0, 1.0);
			curPointsRemaining:SetTextColor(0.0, 1.0, 1.0, 1.0);

			local curPointsUsedLabel = mainFrame:CreateFontString(nil, "ARTWORK");
			curPointsUsedLabel:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			curPointsUsedLabel:SetText(L.curPointsUsed);
			curPointsUsedLabel:SetPoint("RIGHT", curPointsRemainingLabel, "LEFT", - 24, 0);

			local curPointsUsed = mainFrame:CreateFontString(nil, "ARTWORK");
			curPointsUsed:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			curPointsUsed:SetText("0");
			curPointsUsed:SetPoint("LEFT", curPointsUsedLabel, "RIGHT", 2, 0);

			curPointsUsedLabel:SetTextColor(0.0, 1.0, 0.0, 1.0);
			curPointsUsed:SetTextColor(0.0, 1.0, 0.0, 1.0);

			local curPointsReqLevelLabel = mainFrame:CreateFontString(nil, "ARTWORK");
			curPointsReqLevelLabel:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			curPointsReqLevelLabel:SetText(L.curPointsReqLevel);
			curPointsReqLevelLabel:SetPoint("LEFT", curPointsRemainingLabel, "RIGHT", 20, 0);

			local curPointsReqLevel = mainFrame:CreateFontString(nil, "ARTWORK");
			curPointsReqLevel:SetFont(setting.frameFont, setting.frameFontSize, setting.frameFontOutline);
			curPointsReqLevel:SetText("10");
			curPointsReqLevel:SetPoint("LEFT", curPointsReqLevelLabel, "RIGHT", 2, 0);

			curPointsReqLevelLabel:SetTextColor(1.0, 1.0, 0.0, 1.0);
			curPointsReqLevel:SetTextColor(1.0, 1.0, 0.0, 1.0);

			objects.curPointsRemainingLabel = curPointsRemainingLabel;
			objects.curPointsRemaining = curPointsRemaining;
			objects.curPointsUsedLabel = curPointsUsedLabel;
			objects.curPointsUsed = curPointsUsed;
			objects.curPointsReqLevelLabel = curPointsReqLevelLabel;
			objects.curPointsReqLevel = curPointsReqLevel;

			local specButtonsBar = CreateFrame("Frame", nil, mainFrame);
			specButtonsBar:SetPoint("CENTER", mainFrame, "BOTTOM", 0, (setting.mainFrameFooterYSize + setting.mainFrameFooterYSize_Style2) * 0.5);
			specButtonsBar:SetSize(setting.specTabButtonWidth * 3 + setting.specTabButtonGap * 2, setting.specTabButtonHeight);
			mainFrame.specButtonsBar = specButtonsBar;
			local specButtons = {  };
			for specIndex = 1, 3 do
				local specButton = CreateFrame("Button", nil, specButtonsBar);
				specButton:SetSize(setting.specTabButtonWidth, setting.specTabButtonHeight);
				specButton:SetNormalTexture(TEXTURE_SET.UNK);
				specButton:GetNormalTexture():SetTexCoord(setting.specTabButtonTexCoord[1], setting.specTabButtonTexCoord[2], setting.specTabButtonTexCoord[3], setting.specTabButtonTexCoord[4]);
				specButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.SPEC_NORMAL_COLOR[1], TEXTURE_SET.SPEC_NORMAL_COLOR[2], TEXTURE_SET.SPEC_NORMAL_COLOR[3], TEXTURE_SET.SPEC_NORMAL_COLOR[4]);
				specButton:SetPushedTexture(TEXTURE_SET.UNK);
				specButton:GetPushedTexture():SetTexCoord(setting.specTabButtonTexCoord[1], setting.specTabButtonTexCoord[2], setting.specTabButtonTexCoord[3], setting.specTabButtonTexCoord[4]);
				specButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.SPEC_PUSHED_COLOR[1], TEXTURE_SET.SPEC_PUSHED_COLOR[2], TEXTURE_SET.SPEC_PUSHED_COLOR[3], TEXTURE_SET.SPEC_PUSHED_COLOR[4]);
				specButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				specButton:GetHighlightTexture():SetTexCoord(setting.specTabButtonTexCoord[1], setting.specTabButtonTexCoord[2], setting.specTabButtonTexCoord[3], setting.specTabButtonTexCoord[4]);
				specButton:Hide();
				specButton:SetScript("OnClick", specButton_OnClick);
				specButton:SetScript("OnEnter", Info_OnEnter);
				specButton:SetScript("OnLeave", Info_OnLeave);
				specButton.id = specIndex;
				specButton.information = nil;
				local title = specButton:CreateFontString(nil, "OVERLAY");
				title:SetFont(setting.frameFont, setting.frameFontSize, "OUTLINE");
				title:SetTextColor(0.25, 1.0, 0.0, 1.0);
				title:SetPoint("CENTER");
				specButton.title = title;
				specButtons[specIndex] = specButton;
			end
			-- specButtons[2]:SetPoint("CENTER", mainFrame, "BOTTOM", 0, (setting.mainFrameFooterYSize + setting.mainFrameFooterYSize_Style2) * 0.5);
			-- specButtons[1]:SetPoint("RIGHT", specButtons[2], "LEFT", - setting.specTabButtonGap, 0);
			-- specButtons[3]:SetPoint("LEFT", specButtons[2], "RIGHT", setting.specTabButtonGap, 0);
			specButtons[1]:SetPoint("LEFT", specButtonsBar, "LEFT", 0, 0);
			specButtons[2]:SetPoint("LEFT", specButtons[1], "RIGHT", setting.specTabButtonGap, 0);
			specButtons[3]:SetPoint("LEFT", specButtons[2], "RIGHT", setting.specTabButtonGap, 0);
			mainFrame.specButtons = specButtons;

			local curTabIndicator = mainFrame:CreateTexture(nil, "OVERLAY");
			curTabIndicator:SetSize(setting.specTabButtonWidth * 1.28 + 4, setting.specTabButtonHeight * 1.28 + 4);
			curTabIndicator:SetBlendMode("ADD");
			curTabIndicator:SetTexture(TEXTURE_SET.SQUARE_HIGHLIGHT);
			curTabIndicator:SetTexCoord(TEXTURE_SET.SPEC_INDICATOR_COORD[1], TEXTURE_SET.SPEC_INDICATOR_COORD[2], TEXTURE_SET.SPEC_INDICATOR_COORD[3], TEXTURE_SET.SPEC_INDICATOR_COORD[4]);
			curTabIndicator:SetVertexColor(TEXTURE_SET.SPEC_INDICATOR_COLOR[1], TEXTURE_SET.SPEC_INDICATOR_COLOR[2], TEXTURE_SET.SPEC_INDICATOR_COLOR[3], TEXTURE_SET.SPEC_INDICATOR_COLOR[4]);
			curTabIndicator:Hide();
			mainFrame.objects.curTabIndicator = curTabIndicator;
		end
		--</footer>

		--<side>
		do
			local side_anchor = CreateFrame("Frame", nil, mainFrame);
			side_anchor:SetWidth(1);
			mainFrame.side_anchor = side_anchor;
			side_anchor:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 2, 0);
			side_anchor:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMRIGHT", 2, 0);
			do	-- class
				local classButtons = {  };--_indexToClass
				for index = 1, #_indexToClass do
					local class = _indexToClass[index];
					local classButton = CreateFrame("Button", nil, mainFrame);
					classButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
					classButton:SetNormalTexture(TEXTURE_SET.CLASS);
					classButton:SetPushedTexture(TEXTURE_SET.CLASS);
					classButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
					local coord = CLASS_ICON_TCOORDS[strupper(class)];
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
					--classButton:GetHighlightTexture():ClearAllPoints();
					--classButton:GetHighlightTexture():SetSize(setting.tabButtonSize + 2, setting.tabButtonSize + 2);
					--classButton:GetHighlightTexture():SetPoint("CENTER");
					classButton:SetPoint("TOPLEFT", side_anchor, "TOPLEFT", 0, - (setting.tabButtonSize + setting.tabButtonGap) * (index - 1) - setting.mainFrameHeaderYSize);	--
					classButton:Show();
					classButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					classButton:SetScript("OnClick", classButton_OnClick);
					classButton:SetScript("OnEnter", Info_OnEnter);
					classButton:SetScript("OnLeave", Info_OnLeave);
					classButton.id = index;
					classButton.class = class;
					local classColorTable = RAID_CLASS_COLORS[strupper(class)];
					classButton.information = format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. L.DATA[class] .. "\124r" .. L.classTabButton;
					classButtons[index] = classButton;
				end
				mainFrame.classButtons = classButtons;

				local curClassIndicator = mainFrame:CreateTexture(nil, "OVERLAY");
				curClassIndicator:SetSize(setting.curClassIndicatorSize, setting.curClassIndicatorSize);
				curClassIndicator:SetBlendMode("ADD");
				curClassIndicator:SetTexture(TEXTURE_SET.CLASS_INDICATOR);
				curClassIndicator:SetTexCoord(TEXTURE_SET.CLASS_INDICATOR_COORD[1], TEXTURE_SET.CLASS_INDICATOR_COORD[2], TEXTURE_SET.CLASS_INDICATOR_COORD[3], TEXTURE_SET.CLASS_INDICATOR_COORD[4]);
				curClassIndicator:SetVertexColor(TEXTURE_SET.CLASS_INDICATOR_COLOR[1], TEXTURE_SET.CLASS_INDICATOR_COLOR[2], TEXTURE_SET.CLASS_INDICATOR_COLOR[3], TEXTURE_SET.CLASS_INDICATOR_COLOR[4]);
				curClassIndicator:Show();
				mainFrame.objects.curClassIndicator = curClassIndicator;
			end

			do	-- control
				-- local inspectTargetButton = CreateFrame("Button", nil, mainFrame);
				-- inspectTargetButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
				-- inspectTargetButton:SetNormalTexture(TEXTURE_SET.INSPECT);
				-- inspectTargetButton:GetNormalTexture():SetVertexColor(TEXTURE_SET.INSPECT_COLOR[1], TEXTURE_SET.INSPECT_COLOR[2], TEXTURE_SET.INSPECT_COLOR[3], TEXTURE_SET.INSPECT_COLOR[4]);
				-- inspectTargetButton:SetPushedTexture(TEXTURE_SET.INSPECT);
				-- inspectTargetButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				-- inspectTargetButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				-- inspectTargetButton:SetPoint("BOTTOMLEFT", side_anchor, "BOTTOMRIGHT", 4, 0);
				-- inspectTargetButton:Show();
				-- inspectTargetButton:SetScript("OnClick", inspectTargetButton_OnClick);
				-- inspectTargetButton:SetScript("OnEnter", Info_OnEnter);
				-- inspectTargetButton:SetScript("OnLeave", Info_OnLeave);
				-- inspectTargetButton.information = L.inspectTargetButton;
				-- mainFrame.objects.inspectTargetButton = inspectTargetButton;

				local spellTabButton = CreateFrame("Button", nil, mainFrame);
				spellTabButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
				spellTabButton:SetNormalTexture(TEXTURE_SET.SPELLTAB);
				spellTabButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.SPELLTAB_COORD[1], TEXTURE_SET.SPELLTAB_COORD[2], TEXTURE_SET.SPELLTAB_COORD[3], TEXTURE_SET.SPELLTAB_COORD[4]);
				spellTabButton:SetPushedTexture(TEXTURE_SET.SPELLTAB);
				spellTabButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.SPELLTAB_COORD[1], TEXTURE_SET.SPELLTAB_COORD[2], TEXTURE_SET.SPELLTAB_COORD[3], TEXTURE_SET.SPELLTAB_COORD[4]);
				spellTabButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				spellTabButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				spellTabButton:SetPoint("BOTTOMLEFT", side_anchor, "BOTTOMLEFT", 0, 0);
				spellTabButton:Show();
				spellTabButton:SetScript("OnClick", spellTabButton_OnClick);
				spellTabButton:SetScript("OnEnter", Info_OnEnter);
				spellTabButton:SetScript("OnLeave", Info_OnLeave);
				spellTabButton.information = L.spellTabButton;
				mainFrame.objects.spellTabButton = spellTabButton;

				local applyTalentsButton = CreateFrame("Button", nil, mainFrame);
				applyTalentsButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
				applyTalentsButton:SetNormalTexture(TEXTURE_SET.APPLY);
				applyTalentsButton:SetPushedTexture(TEXTURE_SET.APPLY);
				applyTalentsButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				applyTalentsButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				applyTalentsButton:SetDisabledTexture(TEXTURE_SET.APPLY);
				applyTalentsButton:GetDisabledTexture():SetVertexColor(TEXTURE_SET.CONTROL_DISABLED_COLOR[1], TEXTURE_SET.CONTROL_DISABLED_COLOR[2], TEXTURE_SET.CONTROL_DISABLED_COLOR[3], TEXTURE_SET.CONTROL_DISABLED_COLOR[4]);
				-- applyTalentsButton:SetPoint("BOTTOMLEFT", side_anchor, "BOTTOMRIGHT", 0, 0);
				-- applyTalentsButton:SetPoint("BOTTOM", inspectTargetButton, "TOP", 0, setting.tabButtonGap);
				applyTalentsButton:SetPoint("BOTTOM", spellTabButton, "TOP", 0, setting.tabButtonGap);
				applyTalentsButton:Show();
				applyTalentsButton:SetScript("OnClick", applyTalentsButton_OnClick);
				applyTalentsButton:SetScript("OnEnter", Info_OnEnter);
				applyTalentsButton:SetScript("OnLeave", Info_OnLeave);
				applyTalentsButton.information = L.applyTalentsButton;
				mainFrame.objects.applyTalentsButton = applyTalentsButton;

				local importButton = CreateFrame("Button", nil, mainFrame);
				importButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
				importButton:SetNormalTexture(TEXTURE_SET.IMPORT);
				importButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.IMPORT_COORD[1], TEXTURE_SET.IMPORT_COORD[2], TEXTURE_SET.IMPORT_COORD[3], TEXTURE_SET.IMPORT_COORD[4]);
				importButton:SetPushedTexture(TEXTURE_SET.IMPORT);
				importButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.IMPORT_COORD[1], TEXTURE_SET.IMPORT_COORD[2], TEXTURE_SET.IMPORT_COORD[3], TEXTURE_SET.IMPORT_COORD[4]);
				importButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				importButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				importButton:SetPoint("BOTTOM", applyTalentsButton, "TOP", 0, setting.tabButtonGap);
				importButton:Show();
				importButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
				importButton:SetScript("OnClick", importButton_OnClick);
				importButton:SetScript("OnEnter", Info_OnEnter);
				importButton:SetScript("OnLeave", Info_OnLeave);
				importButton.information = L.importButton;
				mainFrame.objects.importButton = importButton;

				local exportButton = CreateFrame("Button", nil, mainFrame);
				exportButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
				exportButton:SetNormalTexture(TEXTURE_SET.EXPORT);
				exportButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.EXPORT_COORD[1], TEXTURE_SET.EXPORT_COORD[2], TEXTURE_SET.EXPORT_COORD[3], TEXTURE_SET.EXPORT_COORD[4]);
				exportButton:SetPushedTexture(TEXTURE_SET.EXPORT);
				exportButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.EXPORT_COORD[1], TEXTURE_SET.EXPORT_COORD[2], TEXTURE_SET.EXPORT_COORD[3], TEXTURE_SET.EXPORT_COORD[4]);
				exportButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				exportButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				exportButton:SetPoint("BOTTOM", importButton, "TOP", 0, setting.tabButtonGap);
				exportButton:Show();
				exportButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
				exportButton:SetScript("OnClick", exportButton_OnClick);
				exportButton:SetScript("OnEnter", Info_OnEnter);
				exportButton:SetScript("OnLeave", Info_OnLeave);
				exportButton.information = L.exportButton;
				mainFrame.objects.exportButton = exportButton;

				local saveButton = CreateFrame("Button", nil, mainFrame);
				saveButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
				saveButton:SetNormalTexture(TEXTURE_SET.SAVE);
				--saveButton:GetNormalTexture():SetTexCoord(TEXTURE_SET.EXPORT_COORD[1], TEXTURE_SET.EXPORT_COORD[2], TEXTURE_SET.EXPORT_COORD[3], TEXTURE_SET.EXPORT_COORD[4]);
				saveButton:SetPushedTexture(TEXTURE_SET.SAVE);
				--saveButton:GetPushedTexture():SetTexCoord(TEXTURE_SET.EXPORT_COORD[1], TEXTURE_SET.EXPORT_COORD[2], TEXTURE_SET.EXPORT_COORD[3], TEXTURE_SET.EXPORT_COORD[4]);
				saveButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				saveButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				saveButton:SetPoint("BOTTOM", exportButton, "TOP", 0, setting.tabButtonGap);
				saveButton:Show();
				saveButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
				saveButton:SetScript("OnClick", saveButton_OnClick);
				saveButton:SetScript("OnEnter", Info_OnEnter);
				saveButton:SetScript("OnLeave", Info_OnLeave);
				saveButton.information = L.saveButton;
				mainFrame.objects.saveButton = saveButton;

				local editBox = CreateFrame("EditBox", nil, mainFrame);
				editBox:SetSize(setting.editBoxXSize, setting.editBoxYSize);
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
				mainFrame.objects.editBox = editBox;

				local editBoxOKButton = CreateFrame("Button", nil, editBox);
				editBoxOKButton:SetSize(setting.editBoxYSize, setting.editBoxYSize);
				editBoxOKButton:SetNormalTexture(TEXTURE_SET.EDIT_OK);
				editBoxOKButton:SetPushedTexture(TEXTURE_SET.EDIT_OK);
				editBoxOKButton:GetPushedTexture():SetVertexColor(TEXTURE_SET.CONTROL_PUSHED_COLOR[1], TEXTURE_SET.CONTROL_PUSHED_COLOR[2], TEXTURE_SET.CONTROL_PUSHED_COLOR[3], TEXTURE_SET.CONTROL_PUSHED_COLOR[4]);
				editBoxOKButton:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				editBoxOKButton:SetPoint("LEFT", editBox, "RIGHT", 0, 4);
				editBoxOKButton:Show();
				editBoxOKButton:SetScript("OnClick", function(self) editBox_OnEnterPressed(self:GetParent()); end);
				editBoxOKButton:SetScript("OnEnter", Info_OnEnter);
				editBoxOKButton:SetScript("OnLeave", Info_OnLeave);
				editBoxOKButton.information = L.editBoxOKButton;
				editBox.OKButton = editBoxOKButton;
			end

			do	-- left
				local equipmentButton = CreateFrame("Button", nil, mainFrame);
				equipmentButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
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
		emu.talentFrameUpdateSize(self, self.talentFrames, width, height);
		for _, obj in pairs(self.objects) do
			obj:SetScale(self.talentFrameScale);
		end
		-- for _, obj in pairs(self.specButtons) do
		-- 	obj:SetScale(self.talentFrameScale);
		-- end
		self.specButtonsBar:SetScale(self.talentFrameScale);
		for _, obj in pairs(self.classButtons) do
			obj:SetScale(self.talentFrameScale);
		end
		self.side_anchor:SetWidth(setting.tabButtonSize * self.talentFrameScale);
		self.spellTabFrame:SetScale(self.talentFrameScale);
		self.spellTabFrame:SetHeight(self:GetHeight() / self.talentFrameScale);
		self.equipmentFrame:SetScale(self.talentFrameScale);
		self.equipmentFrame:SetHeight(self:GetHeight() / self.talentFrameScale);
	end

	local temp_id = 0;
	function emu.CreateMainFrame()
		temp_id = temp_id + 1;
		local mainFrame = CreateFrame("Frame", NAME .. "MainFrame" .. temp_id, UIParent);
		mainFrame.id = temp_id;

		mainFrame:SetPoint("CENTER");
		mainFrame:SetMinResize(setting.mainFrameXSizeMin_Style1, setting.mainFrameYSizeMin_Style1);
		mainFrame:SetFrameStrata("HIGH");
		mainFrame:SetBackdrop(setting.mainFrameBackdrop);
		mainFrame:SetBackdropColor(setting.mainFrameBackdropColor[1], setting.mainFrameBackdropColor[2], setting.mainFrameBackdropColor[3], setting.mainFrameBackdropColor[4]);
		mainFrame:SetBackdropBorderColor(setting.mainFrameBackdropBorderColor[1], setting.mainFrameBackdropBorderColor[2], setting.mainFrameBackdropBorderColor[3], setting.mainFrameBackdropBorderColor[4]);

		if config.style == 1 then
			mainFrame:SetSize(setting.mainFrameXSizeDefault_Style1 * setting.ORIG_SCALE, setting.mainFrameYSizeDefault_Style1 * setting.ORIG_SCALE);
		elseif config.style == 2 then
			mainFrame:SetSize(setting.mainFrameXSizeDefault_Style2 * setting.ORIG_SCALE, setting.mainFrameYSizeDefault_Style2 * setting.ORIG_SCALE);
		end

		local BG = mainFrame:CreateTexture(nil, "BORDER");
		BG:SetAllPoints(true);
		BG:SetAlpha(0.6);
		mainFrame.BG = BG;

		mainFrame.talentFrames = emu.CreateTalentFrames(mainFrame);
		mainFrame.tooltipFrame = emu.CreateTooltipFrame(mainFrame);
		mainFrame.spellTabFrame = emu.CreateSpellTabFrame(mainFrame);
		mainFrame.equipmentFrame, mainFrame.equipmentContainer = emu.CreateEquipmentFrame(mainFrame);

		emu.CreateMainFrameSubObject(mainFrame);

		mainFrame:EnableMouse(true);
		mainFrame:SetMovable(true);
		mainFrame:SetResizable(true);

		mainFrame:Hide();

		mainFrame:SetScript("OnMouseDown", function(self, button)
				if button == "LeftButton" and not self.isMoving and not self.isResizing and self:IsMovable() then
					local x, y = GetCursorPosition();
					local s = self:GetEffectiveScale();
					x = x / s;
					y = y / s;
					local bottom = self:GetBottom();
					local top = self:GetTop();
					local left = self:GetLeft();
					local right = self:GetRight();

					if x < left + setting.mainFrameBorderSize then
						if y < bottom + setting.mainFrameBorderSize then
							self:StartSizing("BOTTOMLEFT");
						elseif y > top - setting.mainFrameBorderSize then
							self:StartSizing("TOPLEFT");
						else
							self:StartSizing("LEFT");
						end
						self.isResizing = true;
					elseif x > right - setting.mainFrameBorderSize then
						if y < bottom + setting.mainFrameBorderSize then
							self:StartSizing("BOTTOMRIGHT");
						elseif y > top - setting.mainFrameBorderSize then
							self:StartSizing("TOPRIGHT");
						else
							self:StartSizing("RIGHT");
						end
						self.isResizing = true;
					elseif y < bottom + setting.mainFrameBorderSize then
						self:StartSizing("BOTTOM");
						self.isResizing = true;
					elseif y > top - setting.mainFrameBorderSize then
						self:StartSizing("TOP");
						self.isResizing = true;
					else
						self:StartMoving();
						self.isMoving = true;
					end
				end
			end
		);
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
		end
		);
		mainFrame:SetScript("OnSizeChanged", OnSizeChanged);
		mainFrame:SetScript("OnShow", function(self)
				OnSizeChanged(self, self:GetWidth(), self:GetHeight());
			end
		);
		mainFrame:SetScript("OnHide", function(self)
				emu.Emu_DestroyMainFrame(self);
				if self.isMoving then
					self:StopMovingOrSizing();
					self.isMoving = false;
				end
				if self.isResizing then
					self:StopMovingOrSizing();
					self.isResizing = false;
				end
			end
		);

		mainFrame.curTab = 1;
		emu.EmuCore_SetName(mainFrame, nil);
		emu.EmuCore_SetLevel(mainFrame, nil);
		emu.EmuCore_SetClass(mainFrame, emu.playerClass_Lower);
		emu.EmuCore_SetData(mainFrame, nil);
		emu.EmuCore_SetReadOnly(mainFrame, false);
		mainFrame.initialized = false;

		emu.mainFrameSetStyle(mainFrame, config.style);

		emu.dev(mainFrame);

		return mainFrame;
	end
end

do	-- init
	function emu.DB_PreProc(_talentDB)
		-- 1---- 2--- 3-- 4-------- 5------- 6------ 7----- 8-------- 9------- 10--------- 11---------------- 12
		--tier, col, id, maxPoint, reqTier, reqCol, reqId, Spell[5], texture, icon-index, req-index[] in db, { req-by-index } in db
		for _, DB in pairs(_talentDB) do
			for _, db in pairs(DB) do
				for dataIndex, data in pairs(db) do
					data[10] = data[1] * 4 + data[2] + 1;
					if data[5] and data[6] then
						for pIndex, p in pairs(db) do
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
		for class, C in pairs(_preset_talent) do
			_PRESET[class] = {  };
			for role, R in pairs(C) do
				for scene, S in pairs(R) do
					for _, url in pairs(S) do
						local _, code = emu.EmuCore_Decoder(url);
						if code then
							local title = emu.EmuSub_GenerateTitle(code, class) or "";
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
		for class, S in pairs(_spellDB) do
			for _, v in pairs(S) do
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
						for index, data in pairs(db) do
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

	--[[local function DBIcon_OnClick(self, button)
		if button == "LeftButton" then
			emu.Emu_Create();
		elseif button == "RightButton" then
			if ALADROP then
				local DBIcon_OnClickData =
				{
					handler = Config_SetStyle,
					elements =
					{
						{
							para =
							{
								1, true,
							},
							text = L.SetStyleAllTo1_AlsoSetShownWin,
						},
						{
							para =
							{
								1, false,
							},
							text = L.SetStyleAllTo1_LaterWin,
						},
						{
							para =
							{
								2, true,
							},
							text = L.SetStyleAllTo2_AlsoSetShownWin,
						},
						{
							para =
							{
								2, false,
							},
							text = L.SetStyleAllTo2_LaterWin,
						},
						{
							handler = function() config.inspectButtonOnUnitFrame = true; end,
							para =
							{
								nil,
							},
							text = L.inspectButtonOnUnitFrame_Enable,
						},
						{
							handler = function() config.inspectButtonOnUnitFrame = false; end,
							para =
							{
								nil,
							},
							text = L.inspectButtonOnUnitFrame_Disable,
						},
						{
							handler = function() config.inspectButtonKey = "ALT"; emu.inspectButtonKeyFunc = IsAltKeyDown; end,
							para = 
							{
								"ALT",
							},
							text = L.insepctALTKEY,
						},
						{
							handler = function() config.inspectButtonKey = "CTRL"; emu.inspectButtonKeyFunc = IsControlKeyDown; end,
							para = 
							{
								"CTRL",
							},
							text = L.insepctCTRLKEY,
						},
						{
							handler = function() config.inspectButtonKey = "SHIFT"; emu.inspectButtonKeyFunc = IsShiftKeyDown; end,
							para = 
							{
								"SHIFT",
							},
							text = L.insepctSHIFTKEY,
						},
					},
				};
				ALADROP(self, "BOTTOMLEFT", DBIcon_OnClickData);
			end
		end
	end]]

	function emu.Init()
		if not emu.initialized then
			if alaTalentEmuSV then
				for k, v in pairs(config) do
					if alaTalentEmuSV[k] == nil then
						alaTalentEmuSV[k] = v;
					end
				end
				for k, v in pairs(alaTalentEmuSV) do
					if config[k] == nil then
						alaTalentEmuSV[k] = nil;
					end
				end
				config = alaTalentEmuSV;
			else
				alaTalentEmuSV = config;
			end
			emu.DB_PreProc(_talentDB);
			emu.EmuCore_InitCodeTable();

			--[[if LibStub then
				local icon = LibStub("LibDBIcon-1.0", true);
				if icon then
					icon:Register("alaTalentEmu",
					{
						icon = TEXTURE_SET.LIBDBICON,
						OnClick = DBIcon_OnClick,
						text = L.DBIcon_Text,
						OnTooltipShow = function(tt)
								tt:AddLine("alaTalentEmulator");
								tt:AddLine(" ");
								tt:AddLine(L.DBIcon_Text);
							end
					},
					{
						minimapPos = 0,
					}
					);
				end
			end]]

			if not RegisterAddonMessagePrefix(ADDON_PREFIX) then
				_log_("Init", "RegisterAddonMessagePrefix", ADDON_PREFIX);
			end
			local _EventVehicle = CreateFrame("Frame", NAME .. "EventVehicle", UIParent);
			NS._EventVehicle = _EventVehicle;
			_EventVehicle:RegisterEvent("CHAT_MSG_ADDON");
			_EventVehicle:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
			_EventVehicle:SetScript("OnEvent", emu._EventVehicle_OnEvent);

			extern.addon_init();

			if config.inspectButtonKey == "CTRL" then
				emu.inspectButtonKeyFunc = IsControlKeyDown;
			elseif config.inspectButtonKey == "SHIFT" then
				emu.inspectButtonKeyFunc = IsShiftKeyDown;
			elseif config.inspectButtonKey == "ALT" then
				emu.inspectButtonKeyFunc = IsAltKeyDown;
			else
				emu.inspectButtonKeyFunc = IsAltKeyDown;
			end

			emu.initialized = true;

		end
	end
	C_Timer.After(1.0, emu.Init);
end

do	-- SLASH and _G
	SLASH_ALATALENTEMU1 = "/alaTalentEmu";
	SLASH_ALATALENTEMU2 = "/alate";
	SLASH_ALATALENTEMU3 = "/ate";
	SLASH_ALATALENTEMU4 = "/emu";
	local acceptedCommandSeq = { "\ ", "\,", "\;", "\:", "\-", "\+", "\_", "\=", "\/", "\\", "\"", "\'", "\|", "\，", "\。", "\；", "\：", "\、", "\’", "\“", };
	SlashCmdList["ALATALENTEMU"] = function(msg)
		for _, seq in pairs(acceptedCommandSeq) do
			if strfind(msg, seq) then
				emu.Emu_Create(nil, strsplit(seq, msg));
				return;
			end
		end
		emu.Emu_Create(nil, msg);
	end
	--_G["EMUNS"] = NS;

	ATEMU = {  };
	_G["ATEmu"] = ATEMU;
	_G["atemu"] = ATEMU;
	_G["TEMU"] = ATEMU;
	_G["TEmu"] = ATEMU;
	_G["Emu"] = ATEMU;
	_G["EMU"] = ATEMU;
	ATEMU.ExportCode = function(...)
		return emu.Emu_Export(...)
	end
	ATEMU.ImportCode = function(code)
		return emu.Emu_Import(code);
	end
	ATEMU.Create = function(class, data, level, readOnly, name, style, ...)
		return emu.Emu_Create(nil, class, data, level, readOnly, name, style, ...);
	end
	ATEMU.Destroy = function(winId)
		emu.hideMainFrame(winId);
	end
	ATEMU.Query = function(unit)
		if unit then
			if UnitName(unit) then
				unit = UnitName(unit);
			end
		else
			unit = UnitName('target');
		end
		emu.Emu_Query(unit);
	end
	ATEMU.SetStyle = function(style)
		config.style = style;
	end
	ATEMU.QueryRawInfoFromDB = function(spellId, class, specIndex)
		spellId = tonumber(spellId);
		if not spellId then
			return nil;
		end
		class = class and strlower(class) or nil;
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
		for c, DB in pairs(_talentDB) do
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
	ATEMU.QueryInfoFromDB = function(spellId, class, specIndex)
		local class, specIndex, specId, id, row, col, rank = ATEMU.QueryRawInfoFromDB(spellId, class, specIndex);
		if class then
			return class, L.DATA[class], specIndex, L.DATA[specId], id, row, col, rank;
		end
		return nil;
	end
	ATEMU.QueryIdFromDB = function(class, specIndex, id, level)
		if class and specIndex and id then
			class = class and strlower(class) or nil;
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
	--/run print(ATEMU.Create("paladin", "2314211111000015112111211000032113211111"))
	--/run print(ATEMU.ExportCode(1))
	--4Mv8i:8HsJ4gm7R4veBw0
	--/run ATEMU.ImportCode("4Mv8i:8HsJ4gm7R4veBw0");
	--/run print(ATEMU.ExportCode(2))
	--4Mv8i:sdWw7gm7R4JMw0
	--4jt-2:8QfgA0iJ5:2w0
	--/run ATEMU.ImportCode("4Mv8i:sdWw7gm7R4JMw0");
end
----------------------------------------------------------------------------------------------------Popup Menu
do	-- popup
	if LOCALE == "zhCN" then
		UnitPopupButtons["EMU_INSPECT"] = { text = "查询天赋", };
		UnitPopupButtons["BN_EMU_INSPECT"] = { text = "查询天赋", nested = 1, };
	elseif LOCALE == "zhTW" then
		UnitPopupButtons["EMU_INSPECT"] = { text = "查詢天賦", };
		UnitPopupButtons["BN_EMU_INSPECT"] = { text = "查詢天賦", nested = 1, };
	else
		UnitPopupButtons["EMU_INSPECT"] = { text = "Inspect talent", };
		UnitPopupButtons["BN_EMU_INSPECT"] = { text = "Inspect talent", nested = 1, };
	end
	UnitPopupMenus["BN_EMU_INSPECT"] = {  },

	tinsert(UnitPopupMenus["SELF"], 1, "EMU_INSPECT");
	tinsert(UnitPopupMenus["FRIEND"], 1, "EMU_INSPECT");
	--tinsert(UnitPopupMenus["FRIEND_OFFLINE"], 1, "EMU_INSPECT");
	tinsert(UnitPopupMenus["PLAYER"], 1, "EMU_INSPECT");
	tinsert(UnitPopupMenus["PARTY"], 1, "EMU_INSPECT");
	tinsert(UnitPopupMenus["RAID_PLAYER"], 1, "EMU_INSPECT");
	tinsert(UnitPopupMenus["CHAT_ROSTER"], 1, "EMU_INSPECT");
	tinsert(UnitPopupMenus["GUILD"], 1, "EMU_INSPECT");

	-- tinsert(UnitPopupMenus["BN_FRIEND"], 1, "BN_EMU_INSPECT");

	hooksecurefunc("UnitPopup_OnClick", function(self)
		local name = UIDROPDOWNMENU_INIT_MENU.name;
		if (self.value == "EMU_INSPECT") then
			emu.Emu_Query(name);
		-- elseif self.value == "BN_EMU_INSPECT" and self.arg1 then
		--     emu.Emu_Query(self.arg1.name);
		end
	end);

	if false then
		local LC = {  };
		for k, v in pairs(LOCALIZED_CLASS_NAMES_FEMALE) do
			LC[v] = k;
		end
		for k, v in pairs(LOCALIZED_CLASS_NAMES_MALE) do
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
	local temp_unkFrame_id = 1;
	local function hookUnitFrame(unitFrame)
		local unitFrameName = unitFrame:GetName();
		if not unitFrameName or unitFrameName == "" then
			unitFrameName = "UNK" .. temp_unkFrame_id;
		end
		local unitFrameButton = CreateFrame("Button", NAME .. unitFrameName .. "Button", UIParent);
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
		unitFrameButton:SetScript("OnUpdate", function(self, elasped)
			if config.inspectButtonOnUnitFrame then
				if (emu.inspectButtonKeyFunc and emu.inspectButtonKeyFunc()) and self.unitFrame:IsShown() and UnitIsPlayer(self.unitFrame.unit) then
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
		end);
		unitFrameButton:SetScript("OnClick", function(self) ATEMU.Query(self.unitFrame.unit); end);
		unitFrameButton.unitFrame = unitFrame;
	end

	C_Timer.After(1.0, function() hookUnitFrame(TargetFrame); end);
end
----------------------------------------------------------------------------------------------------Tooltip
do	-- tooltip
	local Orig_TalentFrameTalent_OnClick = nil;
	local function _TalentFrameTalent_OnClick(self, mouseButton)
		--ATEMU.QueryIdFromDB
		--print(self, mouseButton)
		if IsShiftKeyDown() then
			local specIndex, id = PanelTemplates_GetSelectedTab(TalentFrame), self:GetID();
			local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(specIndex, id);
			local sId = ATEMU.QueryIdFromDB(emu.playerClass_Lower, specIndex, id, rank);
			--print(emu.playerClass_Lower, specIndex, id, rank,sId, name)
			local link = _GetSpellLink(sId, name);
			--print(link)
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
		--print(event, addon);
		if addon == "Blizzard_TalentUI" then
			--print(TalentFrameTalent_OnClick)
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
				local button = CreateFrame("Button", nil, TalentFrame);
				button:SetSize(80, 20);
				button:SetNormalTexture("Interface\\Buttons\\ui-panel-button-up");
				button:SetPushedTexture("Interface\\Buttons\\ui-panel-button-up");
				button:GetNormalTexture():SetTexCoord(1 / 128, 79 / 128, 1 / 32, 22 / 32);
				button:GetPushedTexture():SetTexCoord(1 / 128, 79 / 128, 1 / 32, 22 / 32);
				button:SetHighlightTexture(TEXTURE_SET.NORMAL_HIGHLIGHT);
				button:SetPoint("RIGHT", TalentFrameCloseButton, "LEFT", -2, 0);
				button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
				button:SetScript("OnClick", function() emu.Emu_Create(); end);
				button:SetScript("OnEnter", Info_OnEnter);
				button:SetScript("OnLeave", Info_OnLeave);
				button.information = L.TalentFrameCallButton;
				local fontString = button:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
				fontString:SetText(L.TalentFrameCallButtonFontString);
				fontString:SetPoint("CENTER");
				button.fontString = fontString;
			end

			self:UnregisterAllEvents();
			self:SetScript("OnEvent", nil);
		end
	end

	local f = CreateFrame("Frame");
	f:RegisterEvent("ADDON_LOADED");
	f:SetScript("OnEvent", onEvent);

	--GameTooltip:SetHyperlink("itemString" or "itemLink")
	--GameTooltip:SetSpellBookItem(spellBookId, bookType)
	--GameTooltip:SetSpellByID(spellId)

	local function func_HookGTT(self, spellId)
		--print(spellId)
		local eClass, class, specIndex, spec, id, row, col, rank = ATEMU.QueryInfoFromDB(spellId);
		if eClass then
			local classColorTable = RAID_CLASS_COLORS[strupper(eClass)];
			self:AddDoubleLine(L.DATA.talent, class .. "-" .. spec .. " R" .. (row + 1) .. "-C" .. (col + 1) .. "-L" .. rank, 1.0, 1.0, 1.0, classColorTable.r, classColorTable.g, classColorTable.b);
			self:Show();
		end
	end
	local function func_SetHyperlink(self, link)
		--print(gsub(link, "\124", "--"));
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
		--print(actionType, id, subType)
		if actionType == "spell" then
			func_HookGTT(self, id);
		elseif actionType == "macro" then
			local spellId = GetMacroSpell(id);
			--print(id, spellId)
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

do	-- dev
	function emu.dev(mainFrame)
		-- local frame = CreateFrame("frame");
		-- frame:SetWidth(10);
		-- frame:SetPoint("TOPRIGHT", mainFrame, "TOPLEFT");
		-- frame:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMLEFT");
		-- frame:SetScript("OnSizeChanged", function(self, width, height)
		-- 	print(frame:GetSize());
		-- 	print(width, height);
		-- end);
	end
	if false then
		emu.dev = emu.dev or _noop_;
		_G.emufenv = emu;
		function emufenv.dump_specializedMainFrameInspect()
			for name, v in pairs(emu.specializedMainFrameInspect) do
				local str = v[1];
				for i = 2, #v do
					str = str .. " " .. v[i].id;
				end
				print(name, str);
			end
		end
	end
	local knownPacks = {
		"BigFoot", "ElvUI", "Tukui", "!!!163UI!!!", "Duowan", "rLib", "NDui", "ShestakUI", "!!!EaseAddonController", "_ShiGuang",
	};
	local has_pack = {  };
	local magic = 1;
	local packs = 0;
	for index, pack in pairs(knownPacks) do
		if select(5, GetAddOnInfo(pack)) ~= "MISSING" then
			packs = packs + magic;
		end
		magic = magic * 2;
	end
	function emu.get_pack()
		return packs;
	end
	function emu.display_pack(meta)
		if meta and meta ~= "" then
			meta = tonumber(meta);
			if meta then
				local msg = "";
				local index = 20;
				local magic = 2 ^ index;
				while magic >= 1 do
					if meta >= magic then
						msg = msg .. " " .. (knownPacks[index + 1] or "");
						meta = meta - magic;
					end
					magic = magic / 2;
					index = index - 1;
				end
				print("Packed: ", msg);
			end
		end
	end
	function _G.emu_set_config(key, value)
		--[[
			singleFrame = true,
			style = 1,
			inspectButtonOnUnitFrame = false,
			inspectButtonKey = "ALT",
			savedTalent = {  },		--label, data, decorded, class
			show_equipment = false,
			inspect_pack = false;
			emu_set_config("inspect_pack", true);
		--]]
		config[key] = value;
	end
	if select(2, BNGetInfo()) == 'alex#516722' then
		emu_set_config("inspect_pack", true);
	end
end

-- emu_set_config("show_equipment", true);		-- experimental, default disabled
