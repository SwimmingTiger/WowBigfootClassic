--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;

local L = NS.L;
if not L then return;end
----------------------------------------------------------------------------------------------------
local math, table, string, pairs, type, select, tonumber, tostring, unpack = math, table, string, pairs, type, select, tonumber, tostring, unpack;
local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
local print = print;
local GetTime = GetTime;
local CreateFrame = CreateFrame;
local GetCursorPosition = GetCursorPosition;
local IsAltKeyDown = IsAltKeyDown;
local IsControlKeyDown = IsControlKeyDown;
local IsShiftKeyDown = IsShiftKeyDown;
local InCombatLockdown = InCombatLockdown;

local GetNumTalents = GetNumTalents;
--local numTalents = GetNumTalents([1 - 5])
local GetTalentInfo = GetTalentInfo;
--local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo([1 - 5], GetNumTalents([1 - 5]));
local LearnTalent = LearnTalent;
local UnitName = UnitName;
local UnitClass = UnitClass;
local UnitLevel = UnitLevel;
local GetRealmName = GetRealmName;
--GetSpellTexture
local GameTooltip = GameTooltip;
--------------------------------------------------
local RegisterAddonMessagePrefix = RegisterAddonMessagePrefix or C_ChatInfo.RegisterAddonMessagePrefix;
local IsAddonMessagePrefixRegistered = IsAddonMessagePrefixRegistered or C_ChatInfo.IsAddonMessagePrefixRegistered;
local GetRegisteredAddonMessagePrefixes = GetRegisteredAddonMessagePrefixes or C_ChatInfo.GetRegisteredAddonMessagePrefixes;
local SendAddonMessage = SendAddonMessage or C_ChatInfo.SendAddonMessage;
local SendAddonMessageLogged = SendAddonMessageLogged or C_ChatInfo.SendAddonMessageLogged;
local MAX_NUM_TALENTS = MAX_NUM_TALENTS or 20;
----------------------------------------------------------------------------------------------------
local NAME = "alaTalentEmu";
local ADDON_PREFIX = "ATEADD";
--local artwork_path = "Interface\\AddOns\\alaRaidTool\\ARTWORK\\";
--NS.artwork_path = artwork_path;
--------------------------------------------------
local MAX_NUM_TIER = 7;
local MAX_NUM_COL = 4;
local MAX_ICON_PER_SPEC = MAX_NUM_TIER * MAX_NUM_COL;
local NUM_POINTS_NEXT_TIER = 5;


local setting =
{
	mainFrameBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 2,
		edgeSize = 2,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	},
	mainFrameBackdropColor = { 0.25, 0.25, 0.25, 1.0 },
	mainFrameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0 },
	mainFrameBorderSize = 8,
	iconBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 2,
		edgeSize = 2,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	},
	iconBackdropColor = { 0.25, 0.25, 0.25, 0.75 },
	iconBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0 },
	tooltipFrameBackdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 2,
		edgeSize = 2,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	},
	tooltipFrameBackdropColor = { 0.25, 0.25, 0.25, 1.0 },
	tooltipFrameBackdropBorderColor = { 0.0, 0.0, 0.0, 1.0 },
	tooltipBackdrop = {
		bgFile = nil,	--"Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = nil,	--"Interface\\Tooltips\\UI-Tooltip-Border",
		tile = false,
		tileSize = 0,
		edgeSize = 0,
		insets = { left = 0, right = 0, top = 0, bottom = 0 }
	},
	mainFrameXSizeDefault_Style1 = 600,
	mainFrameYSizeDefault_Style1 = 400,
	mainFrameXSizeDefault_Style2 = 270,
	mainFrameYSizeDefault_Style2 = 400,
	mainFrameXSizeMin_Style1 = 250,
	mainFrameYSizeMin_Style1 = 165,
	mainFrameXSizeMin_Style2 = 100,
	mainFrameYSizeMin_Style2 = 180,
	mainFrameHeaderYSize = 25,
	mainFrameFooterYSize = 25,

	talentIconXSize = 40,
	talentIconYSize = 40,
	talentIconXGap = 10,
	talentIconYGap = 10,
	talentIconXToBorder = 10,
	talentIconYToBorder = 10,

	talentFrameXToBorder = 4,
	talentFrameYToBorder = 0,
	talentFrameHeaderYSize = 0,
	talentFrameFooterYSize = 30,

	talentDepArrowXSize = 15,
	talentDepArrowYSize = 15,
	talentDepBranchWidth = 8,

	controlButtonSize = 18,
	editBoxXSize = 240,
	editBoxYSize = 32,
	tabButtonSize = 30,
	tabButtonGap = 5,
	curclassIndicatorSize = 20,
	curSpecIndicatorSize = 20,

	color_iconTextDisabled = { 1.0, 1.0, 1.0, 1.0, },
	color_iconTextAvailable = { 0.0, 1.0, 0.0, 1.0, },
	color_iconTextMaxRank = { 1.0, 1.0, 0.0, 1.0, },
	color_iconToolTipCurRank = { 0.0, 1.0, 0.0, 1.0 },
	color_iconToolTipNextRank = { 0.0, 0.5, 1.0, 1.0 },
	color_iconToolTipNextRankDisabled = { 1.0, 0.0, 0.0, 1.0 },
	color_iconToolTipMaxRank = { 1.0, 0.5, 0.0, 1.0 },
	DEFAULT_LEVEL = 60,
	INSPECT_WAIT_TIME = 10;
	TOOLTIP_UPDATE_DELAY = 0.02;
};
setting.talentFrameXSizeSingle = setting.talentIconXSize * MAX_NUM_COL + setting.talentIconXGap * (MAX_NUM_COL - 1) + setting.talentIconXToBorder * 2;
setting.talentFrameXSizeTriple = setting.talentFrameXSizeSingle * 3;
setting.talentFrameYSize = setting.talentFrameHeaderYSize + setting.talentIconYSize * MAX_NUM_TIER + setting.talentIconYGap * (MAX_NUM_TIER - 1) + setting.talentIconYToBorder * 2 + setting.talentFrameFooterYSize;
----------------------------------------------------------------------------------------------------main
local function _log_(...)
	print(...);
end
local function _error_(...)
	print("\124cffff0000" .. select(1, ...) .. "\124r", select(2, ...));
end
local function GetSpellTexture(id)
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
--------------------------------------------------
local config = 
{
	style = 1,
	inspectButtonOnUnitFrame = false;
	inspectButtonKey = "ALT";
};
--------------------------------------------------
local ADDON_MSG_CONTROL_CODE_LEN = 6;
local ADDON_MSG_QUERY = "_query";
local ADDON_MSG_REPLY = "_reply"
local ADDON_MSG_PULL = "_pull_";
--------------------------------------------------
local emu = {
	initialized = false,
	codeTable = {  },
	revCodeTable = {  },
	mainFrames = { num = 0, used = 0, },
	specializedMainFrameInspect = {  },
	inspectButtonKeyFunc = IsAltKeyDown,
	arrowTexCoord = {
		[1] = {  8 / 64, 24 / 64, 40 / 64, 56 / 64, },	--vertical disable
		[2] = {  8 / 64, 24 / 64, 08 / 64, 26 / 64, },	--vertical enable
		[3] = { 40 / 64, 56 / 64, 40 / 64, 56 / 64, },	--horizontal disable
		[4] = { 40 / 64, 56 / 64,  8 / 64, 24 / 64, },	--horizontal enable
	},
	branchTexCoord = {
		[1] = { 44 / 256, 54 / 256, 0.5, 1.0, },	--vertical disable
		[2] = { 44 / 256, 54 / 256, 0.0, 0.5, },	----vertical enable
		[3] = { 66 / 256, 98 / 256, 43 / 64, 53 / 64, },	--horizontal disable
		[4] = { 66 / 256, 98 / 256, 11 / 64, 21 / 64, },	--horizontal enable
	},
	applyingMainFrame = false,
};


function emu.winMan_GetWin(winId)
	local mainFrames = emu.mainFrames;
	local mainFrame = nil;
	if winId then
		for i = 1, mainFrames.num do
			if mainFrames[i].id == winId then
				mainFrame = mainFrames[i];
				break;
			end
		end
	else
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
	return mainFrame;
end
function emu.winMan_RelWin(winId)
	local mainFrames = emu.mainFrames;
	for i = 1, mainFrames.used do
		local mainFrame = mainFrames[i];
		if winId == mainFrame.id then
			mainFrames[i] = mainFrames[mainFrames.used];
			mainFrames[mainFrames.used] = mainFrame;
			mainFrames.used = mainFrames.used - 1;
			mainFrame:Hide();
			break;
		end
	end
end

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
	emu.applyTicker = C_Timer.NewTicker(0.5, emu.tickerApplyTalents);
end


local _DB = NS._DB;
local _indexToClass = NS._indexToClass;
local _classToIndex = NS._classToIndex;
local _classTalent = NS._classTalent;
local _talentTabIcon = NS._talentTabIcon;


function emu.GetPontsReqLevel(numPoints)
	return math.max(10, 9 + numPoints);
end
function emu.GetLevelAvailableLevel(level)
	return math.max(0, level - 9);
end
function emu.GetPlayerTalentData()
	--if true then return "paladin", "2314211111000015112111211000032113211111", 40; end	--debug purpose
	local data = "";
	for specIndex = 1, 3 do
		local numTalents = GetNumTalents(specIndex);
		for id = 1, numTalents do
			local name, iconTexture, tier, column, rank, maxRank, isExceptional, available = GetTalentInfo(specIndex, id);
			data = data .. rank;
		end
	end
	return string.lower(select(2, UnitClass('player'))), data, UnitLevel('player');
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
	for i = 0, 25 do emu.codeTable[i + 1 + 11] = string.char(i + 65); end
	for i = 0, 25 do emu.codeTable[i + 1 + 11 + 26] = string.char(i + 97); end

	for i = 0, 63 do
		emu.revCodeTable[emu.codeTable[i]] = i;
	end
end
function emu.EmuCore_Decoder(code)
	local data = "";
	local revCodeTable = emu.revCodeTable;
	local classIndex = revCodeTable[string.sub(code, 1, 1)];
	if not classIndex then
		_log_("EmuCore_Decoder", 1, code);
		return nil;
	end
	local class = _indexToClass[classIndex];
	if not class then
		_log_("EmuCore_Decoder", 2, classIndex, code);
		return nil;
	end

	local len = string.len(code);
	local pos = 0;
	local raw = 0;
	local magic = 1;
	local nChar = 0;
	for p = 2, len - 2 do
		local c = string.sub(code, p, p);
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
				data = data .. math.fmod(raw, 6);
				raw = math.floor(raw / 6);
				n = n + 1;
			end
			if n < 11 then
				for i = n + 1, 11 do
					data = data .. "0";
				end
			end
		end
	end

	return class, data, revCodeTable[string.sub(code, - 2, - 2)] + bit.lshift(revCodeTable[string.sub(code, - 1, - 1)], 6);
end
-------------------------------mainFrame or class, data, level
function emu.EmuCore_Encoder(class, data, level)
	level = (level and tonumber(level)) or setting.DEFAULT_LEVEL;
	if type(class) == "string" then
		local codeTable = emu.codeTable;
		if not _classToIndex[class] or not codeTable[_classToIndex[class]] then
			_log_("EmuCore_Encoder", 1, class);
			return nil;
		end
		if type(data) == "string" then
			local DB = _DB[class];
			local classTalent = _classTalent[class];
			local len = string.len(data);
			local p = 0;

			local pos = 0;
			local raw = 0;
			local magic = 1;
			local mem = {  };
			for i = 1, 3 do
				local numTalents = #DB[classTalent[i]];
				for j = 1, numTalents do
					p = p + 1;
					local d = tonumber(string.sub(data, p, p));
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
							table.insert(mem, codeTable[bit.band(raw, 63)]);
							raw = bit.rshift(raw, 6);
							nChar = nChar + 1;
						end
						if nChar < 5 then
							table.insert(mem, ":");
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

		elseif type(data) == "table" and type(data[1]) == "table" and type(data[2]) == "table" and type(data[3]) == "table" then
			local DB = _DB[class];
			local classTalent = _classTalent[class];
			for i = 1, 3 do
				local talentSet = data[i];
				local numTalents = #_DB[classTalent[i]];
				for j = 1, numTalents do
					pos = pos + 1;
					raw = raw + magic * talentSet[j];
					magic = magic * 6;
					if pos >= 11 or (i == 3 and j == numTalents) then
						pos = 0;
						magic = 1;
						local nChar = 0;
						while raw > 0 do
							table.insert(mem, codeTable[bit.band(raw, 63)]);
							raw = bit.rshift(raw, 6);
							nChar = nChar + 1;
						end
						if nChar < 5 then
							table.insert(mem, ":");
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
			_log_("EmuCore_Encoder", 2, class, type(data));
			return nil;
		end
	elseif type(class) == "table" then
		local mainFrame = class;
		local talentFrames = mainFrame.talentFrames;
		local codeTable = emu.codeTable;
		if type(talentFrames) == "table" and 
					type(talentFrames[1]) == "table" and type(talentFrames[1].talentSet) == "table" and
					type(talentFrames[2]) == "table" and type(talentFrames[2].talentSet) == "table" and
					type(talentFrames[3]) == "table" and type(talentFrames[3].talentSet) == "table"
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
							table.insert(mem, codeTable[bit.band(raw, 63)]);
							raw = bit.rshift(raw, 6);
							nChar = nChar + 1;
						end
						if nChar < 5 then
							table.insert(mem, ":");
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
			_log_("EmuCore_Encoder", 3, "table");
			return nil;

		end
	else
		_log_("EmuCore_Encoder", 4, type(class));
		return nil;
	end
end

function emu.EmuSub_GetRemainingPoints(talentFrames, totalAvailablePoints)
	local usedTalents = 0;
	for i = 1, 3 do
		local talentSet = talentFrames[i].talentSet;
		usedTalents = usedTalents + talentSet.total;
	end
	return totalAvailablePoints - usedTalents;
end
function emu.EmuSub_SetReadOnly(mainFrame, readOnly)
	mainFrame.readOnly = readOnly;
	local objects = mainFrame.objects;
	if readOnly then
		objects.readOnlyButton:GetNormalTexture():SetVertexColor(0.5, 0.5, 0.5, 0.75);
		objects.readOnlyText:SetText(L.readOnly);
	else
		objects.readOnlyButton:GetNormalTexture():SetVertexColor(1, 1, 1, 1);
		objects.readOnlyText:SetText(L.notReadOnly);
	end
end
function emu.EmuSub_LightIcon(icon)
	icon:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
	icon:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
end
function emu.EmuSub_UnlightIcon(icon)
	icon:GetNormalTexture():SetVertexColor(0.250, 0.250, 0.250, 1.0);
	icon:GetPushedTexture():SetVertexColor(0.250, 0.250, 0.250, 1.0);
end
function emu.EmuSub_ActivateIcon(icon)
	icon.active = true;
	--icon:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
	--icon:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 1.0);
	icon.split:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
	icon.maxVal:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
	icon.curVal:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
end
function emu.EmuSub_DeactiveIcon(icon)
	icon.active = false;
	--icon:GetNormalTexture():SetVertexColor(1.0, 1.0, 1.0, 0.5);
	--icon:GetPushedTexture():SetVertexColor(1.0, 1.0, 1.0, 0.5);
	icon.split:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
	icon.maxVal:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
	icon.curVal:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
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
			if numPointsLowerTier >= data[1] * NUM_POINTS_NEXT_TIER then
				emu.EmuSub_ActivateIcon(icon);
			end
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
function emu.EmuSub_SetReqArrowTexCoord(arrow, branch, coordFamily, enabled)
	if coordFamily == 11 then
		if enabled then
			arrow:SetTexCoord(emu.arrowTexCoord[4][1], emu.arrowTexCoord[4][2], emu.arrowTexCoord[4][3], emu.arrowTexCoord[4][4]);
			branch:SetTexCoord(emu.branchTexCoord[4][1], emu.branchTexCoord[4][2], emu.branchTexCoord[4][3], emu.branchTexCoord[4][4]);
		else
			arrow:SetTexCoord(emu.arrowTexCoord[3][1], emu.arrowTexCoord[3][2], emu.arrowTexCoord[3][3], emu.arrowTexCoord[3][4]);
			branch:SetTexCoord(emu.branchTexCoord[3][1], emu.branchTexCoord[3][2], emu.branchTexCoord[3][3], emu.branchTexCoord[3][4]);
		end
	elseif coordFamily == 12 then
		if enabled then
			arrow:SetTexCoord(emu.arrowTexCoord[4][2], emu.arrowTexCoord[4][1], emu.arrowTexCoord[4][3], emu.arrowTexCoord[4][4]);
			branch:SetTexCoord(emu.branchTexCoord[4][1], emu.branchTexCoord[4][2], emu.branchTexCoord[4][3], emu.branchTexCoord[4][4]);
		else
			arrow:SetTexCoord(emu.arrowTexCoord[3][2], emu.arrowTexCoord[3][1], emu.arrowTexCoord[3][3], emu.arrowTexCoord[3][4]);
			branch:SetTexCoord(emu.branchTexCoord[3][1], emu.branchTexCoord[3][2], emu.branchTexCoord[3][3], emu.branchTexCoord[3][4]);
		end
	elseif coordFamily == 21 then
		if enabled then
			arrow:SetTexCoord(emu.arrowTexCoord[2][1], emu.arrowTexCoord[2][2], emu.arrowTexCoord[2][3], emu.arrowTexCoord[2][4]);
			branch:SetTexCoord(emu.branchTexCoord[2][1], emu.branchTexCoord[2][2], emu.branchTexCoord[2][3], emu.branchTexCoord[2][4]);
		else
			arrow:SetTexCoord(emu.arrowTexCoord[1][1], emu.arrowTexCoord[1][2], emu.arrowTexCoord[1][3], emu.arrowTexCoord[1][4]);
			branch:SetTexCoord(emu.branchTexCoord[1][1], emu.branchTexCoord[1][2], emu.branchTexCoord[1][3], emu.branchTexCoord[1][4]);
		end
	elseif coordFamily == 22 then
		if enabled then
			arrow:SetTexCoord(emu.arrowTexCoord[2][1], emu.arrowTexCoord[2][2], emu.arrowTexCoord[2][3], emu.arrowTexCoord[2][4]);
			branch:SetTexCoord(emu.branchTexCoord[2][1], emu.branchTexCoord[2][2], emu.branchTexCoord[2][3], emu.branchTexCoord[2][4]);
		else
			arrow:SetTexCoord(emu.arrowTexCoord[1][1], emu.arrowTexCoord[1][2], emu.arrowTexCoord[1][3], emu.arrowTexCoord[1][4]);
			branch:SetTexCoord(emu.branchTexCoord[1][1], emu.branchTexCoord[1][2], emu.branchTexCoord[1][3], emu.branchTexCoord[1][4]);
		end
	end
end
function emu.EmuSub_UpdateLabelText(mainFrame)
	local objects = mainFrame.objects;
	if mainFrame.name then
		objects.label:SetText(mainFrame.name .. L.labelPointsChanged);
		objects.resetToEmu:Hide();
		objects.resetToSetButton:Show();
	end
	-- local numPoints = 0;
	-- for i = 1, 3 do
	-- 	numPoints = numPoints + mainFrame.talentFrames[i].talentSet.total;
	-- end
	objects.curPointsUsed:SetText(mainFrame.totalUsedPoints);
	objects.curPointsReqLevel:SetText(emu.GetPontsReqLevel(mainFrame.totalUsedPoints));
	objects.curPointsRemaining:SetText(emu.GetLevelAvailableLevel(mainFrame.level) - mainFrame.totalUsedPoints);
end
function emu.EmuSub_SetReqArrow(arrow, branch, verticalDist, horizontalDist, enabled, icon, reqIcon)
	local coordFamily = nil;
	if verticalDist == 0 then		--horizontal
		if horizontalDist > 0 then
			arrow:SetPoint("CENTER", icon, "LEFT", - setting.talentDepArrowXSize / 6, 0);
			branch:SetSize(setting.talentIconXSize * (horizontalDist - 1) + setting.talentIconXGap * horizontalDist, setting.talentDepBranchWidth);
			branch:SetPoint("RIGHT", arrow, "CENTER");
			branch:SetPoint("LEFT", reqIcon, "RIGHT");
			coordFamily = 11;
		elseif horizontalDist < 0 then
			horizontalDist = - horizontalDist;
			arrow:SetPoint("CENTER", icon, "RIGHT", setting.talentDepArrowXSize / 6, 0);
			branch:SetSize(setting.talentIconXSize * (horizontalDist - 1) + setting.talentIconXGap * horizontalDist, setting.talentDepBranchWidth);
			branch:SetPoint("LEFT", arrow, "CENTER");
			branch:SetPoint("RIGHT", reqIcon, "LEFT");
			coordFamily = 12;
		end
	elseif horizontalDist == 0 then	--vertical
		if verticalDist > 0 then
			arrow:SetPoint("CENTER", icon, "TOP", 0, setting.talentDepArrowYSize / 6);
			branch:SetSize(setting.talentDepBranchWidth, setting.talentIconYSize * (verticalDist - 1) + setting.talentIconYGap * verticalDist);
			branch:SetPoint("BOTTOM", arrow, "CENTER");
			branch:SetPoint("TOP", reqIcon, "BOTTOM");
			coordFamily = 21;
		elseif verticalDist < 0 then
			verticalDist = - verticalDist;
			arrow:SetPoint("CENTER", icon, "BOTTOM", 0, - setting.talentDepArrowYSize / 6);
			branch:SetSize(setting.talentDepBranchWidth, setting.talentIconYSize * (verticalDist - 1) + setting.talentIconYGap * verticalDist);
			branch:SetPoint("TOP", arrow, "CENTER");
			branch:SetPoint("BOTTOM", reqIcon, "TOP");
			coordFamily = 22;
		end
	end
	arrow:Show();
	branch:Show();
	arrow.coordFamily = coordFamily;
	emu.EmuSub_SetReqArrowTexCoord(arrow, branch, coordFamily, enabled);
end
function emu.CreateReqArrow(talentFrame)
	local arrow = talentFrame:CreateTexture(nil, "OVERLAY");
	arrow:SetTexture("Interface\\TalentFrame\\ui-talentarrows");
	arrow:SetSize(setting.talentDepArrowXSize, setting.talentDepArrowYSize);
	--arrow:SetTexCoord(0.0, 0.484375, 0.0, 0.10);
	--arrow:SetPoint("TOPLEFT", - 4, 17);

	local branch = talentFrame:CreateTexture(nil, "ARTWORK");
	branch:SetTexture("Interface\\TalentFrame\\ui-talentbranches");
	--branch:SetSize(15, 15);
	--branch:SetTexCoord(0.0, 0.484375, 0.0, 0.10);
	--branch:SetPoint("TOPLEFT", - 4, 17);

	arrow.branch = branch;

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
function emu.EmuSub_SetToEmu(mainFrame)
	mainFrame.name = nil;
	mainFrame.data = nil;
	mainFrame.level = setting.DEFAULT_LEVEL;
	mainFrame.totalAvailablePoints = emu.GetLevelAvailableLevel(setting.DEFAULT_LEVEL);
	local objects = mainFrame.objects;
	objects.label:SetText(L.Emu);
	objects.resetToSetButton:Hide();
	local classButtons = mainFrame.classButtons;
	for index = 1, #_indexToClass do
		classButtons[index]:Show();
	end
	emu.EmuSub_SetReadOnly(mainFrame, false);
end

function emu.EmuCore_TooltipSetTalent(tooltipFrame, icon, spellTable, curRank, maxRank)
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
		--tooltip1:Show();
		--tooltip1:AddDoubleLine("id", spellTable[1], 0.0, 1.0, 0.0, 0.0, 1.0, 0.0);
		--tooltip1:Show();
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
				tooltip1:Show();
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
		--tooltip1:Show();
		--tooltip1:AddDoubleLine("id", spellTable[maxRank], 0.0, 1.0, 0.0, 0.0, 1.0, 0.0);
		--tooltip1:Show();
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
				tooltip1:Show();
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
		--tooltip1:Show();
		--tooltip1:AddDoubleLine("id", spellTable[curRank], 0.0, 1.0, 0.0, 0.0, 1.0, 0.0);
		--tooltip1:Show();
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
		--tooltip2:Show();
		--tooltip2:AddDoubleLine("id", spellTable[curRank + 1], 0.0, 1.0, 0.0, 0.0, 1.0, 0.0);
		--tooltip2:Show();
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
				tooltip1:Show();
				tooltip2:Show();
				self:SetWidth(math.max(tooltip1:GetWidth(), tooltip2:GetWidth()) + 2);
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
function emu.Emu_ChangeTab_Style2(mainFrame, tab)
	if mainFrame.style ~= 2 then
		return;
	end
	if tab <= 0 or tab > 3 then
		return;
	end
	local talentFrames = mainFrame.talentFrames;
	local curTabButton = mainFrame.specButtons[tab];
	if mainFrame.curTab ~= tab then
		talentFrames[mainFrame.curTab]:Hide();
		talentFrames[tab]:Show();
		mainFrame.curTab = tab;
		local curTabIndicator = mainFrame.objects.curTabIndicator;
		curTabIndicator:SetParent(curTabButton);
		curTabIndicator:ClearAllPoints();
		curTabIndicator:SetPoint("LEFT", curTabButton, "RIGHT", 0, 0);
	end
end
function emu.EmuCore_Reset(mainFrame)
	local talentFrames = mainFrame.talentFrames;
	for specIndex = 1, 3 do
		local talentFrame = talentFrames[specIndex];

		local talentIcons = talentFrame.talentIcons;
		for i = 1, MAX_ICON_PER_SPEC do
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
		talentSet.curTopTier = 0;
		talentSet.curCheckedTier = 0;

		for i = 1, MAX_ICON_PER_SPEC do
			table.wipe(talentFrame.reqByArrowSet[i]);
		end

		local reqArrows = talentFrame.reqArrows;
		for i = 1, reqArrows.used do
			reqArrows[i]:Hide();
			reqArrows[i].branch:Hide();
			reqArrows[i]:ClearAllPoints();
			reqArrows[i].branch:ClearAllPoints();
		end
		reqArrows.used = 0;

		talentFrame.curTabPoints:SetText("0");
	end


	mainFrame.class = nil;
	mainFrame.level = setting.DEFAULT_LEVEL;
	mainFrame.totalUsedPoints = 0;
	mainFrame.totalAvailablePoints = emu.GetLevelAvailableLevel(setting.DEFAULT_LEVEL);
	mainFrame.data = nil;
	mainFrame.readOnly = false;
	mainFrame.name = nil;
	emu.Emu_ChangeTab_Style2(mainFrame, 1);

	emu.EmuSub_UpdateLabelText(mainFrame);

	mainFrame.initialized = false;
end
function emu.EmuCore_SetClass(mainFrame, class)
	do	--check class value
		if not class then
			_log_("EmuCore_SetClass", - 1, 1, - 1);
			return false;
		end
		if type(class) == "number" then
			if class <= #_indexToClass then
				class = _indexToClass[class];
			else
				_log_("EmuCore_SetClass", class, 2, class);
				return false;
			end
		elseif type(class) == "table" then
			class = class.class;
			if type(class) == "number" then
				if class <= #_indexToClass then
					class = _indexToClass[class];
				else
					_log_("EmuCore_SetClass", class, 3, class);
					return false;
				end
			elseif type(class) ~= "string" then
				_log_("EmuCore_SetClass", type(class), 4);
				return false;
			end
		elseif type(class) == "string" then
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

	class = string.lower(class);
	local talentRef = _classTalent[class];
	if not talentRef then
		_log_("EmuCore_SetClass", class, 7, class);
		return false;
	end
	local DB = _DB[class];
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
		if tabTexture then
			specButtons[specIndex]:SetNormalTexture(tabTexture);
			specButtons[specIndex]:SetPushedTexture(tabTexture);
		else
			specButtons[specIndex]:SetNormalTexture("Interface\\Icons\\inv_misc_questionmark");
			specButtons[specIndex]:SetPushedTexture("Interface\\Icons\\inv_misc_questionmark");
		end
		if db then
			for dbIndex = 1, #db do
				local data = db[dbIndex];
				local icon = talentIcons[data[10]];
				icon.dbIndex = dbIndex;
				icon:Show();
				local texture = GetSpellTexture(data[8][1]);
				if texture then
					icon:SetNormalTexture(texture);
					--icon:SetDisabledTexture(texture);
					icon:SetPushedTexture(texture);
				elseif data[9] then
					icon:SetNormalTexture(data[9]);
					--icon:SetDisabledTexture(data[9]);
					icon:SetPushedTexture(data[9]);
				else
					icon:SetNormalTexture("Interface\\Icons\\inv_misc_questionmark");
					--icon:SetDisabledTexture("Interface\\Icons\\inv_misc_questionmark");
					icon:SetPushedTexture("Interface\\Icons\\inv_misc_questionmark");
				end
				icon.maxVal:SetText(data[4]);
				icon.curVal:SetText("0");

				if data[11] then
					local arrow = emu.EmuSub_GetReqArrow(talentFrame);
					emu.EmuSub_SetReqArrow(arrow, arrow.branch, data[1] - data[5], data[2] - data[6], false, icon, talentIcons[db[data[11]][10]]);
					table.insert(talentFrame.reqByArrowSet[data[11]], arrow);
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

	mainFrame.class = class;
	mainFrame.DB = DB;
	mainFrame.initialized = true;
	mainFrame:Show();
	if string.lower(select(2, UnitClass('player'))) == class then
		mainFrame.objects.applyTalentsButton:Show();
	else
		mainFrame.objects.applyTalentsButton:Hide();
	end

	return true;
end
function emu.EmuCore_ChangePoint(self, numPoints)
	if not self.active then
		return - 1;
	end
	local talentFrame = self:GetParent();
	if talentFrame:GetParent().readOnly then
		return - 1;
	end
	if numPoints == 0 then
		return 1;
	elseif numPoints > 0 then
		local mainFrame = talentFrame:GetParent();
		local remainingPoints = emu.EmuSub_GetRemainingPoints(mainFrame.talentFrames, mainFrame.totalAvailablePoints);
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

	if (numPoints > 0 and talentSet[dbIndex] == data[4]) or (numPoints < 0 and talentSet[dbIndex] == 0) then
		return 2;
	end
	local tier = data[1];
	if numPoints < 0 then
		if data[12] then
			for i = 1, #data[12] do
				if talentSet[data[12][i]] > 0 then
					return 3;
				end
			end
		end
		if talentSet.curCheckedTier > 0 then
			for i = talentSet.curCheckedTier, tier + 1, - 1 do
				local numPointsLowerTier = 0;
				for i = i - 1, 0, - 1 do
					numPointsLowerTier = numPointsLowerTier + talentSet.totalPerTier[i];
				end
				numPoints = math.max(numPoints, i * NUM_POINTS_NEXT_TIER - numPointsLowerTier);
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
		self.split:SetTextColor(setting.color_iconTextMaxRank[1], setting.color_iconTextMaxRank[2], setting.color_iconTextMaxRank[3], setting.color_iconTextMaxRank[4]);
		self.maxVal:SetTextColor(setting.color_iconTextMaxRank[1], setting.color_iconTextMaxRank[2], setting.color_iconTextMaxRank[3], setting.color_iconTextMaxRank[4]);
		self.curVal:SetTextColor(setting.color_iconTextMaxRank[1], setting.color_iconTextMaxRank[2], setting.color_iconTextMaxRank[3], setting.color_iconTextMaxRank[4]);
		self.curVal:SetText(talentSet[dbIndex]);
		emu.EmuSub_LightIcon(self);
		if data[12] then
			for i = 1, #data[12] do
				emu.EmuSub_ActivateIcon_RecheckPoint(talentFrame.talentIcons[db[data[12][i]][10]]);
			end
			local arrow = talentFrame.reqByArrowSet[dbIndex];
			for i = 1, #arrow do
				emu.EmuSub_SetReqArrowTexCoord(arrow[i], arrow[i].branch, arrow[i].coordFamily, true);
			end
		end
	elseif talentSet[dbIndex] + numPoints <= 0 then
		if talentSet[dbIndex] + numPoints < 0 then
			ret = 5;
		end
		numPoints = - talentSet[dbIndex];
		talentSet[dbIndex] = 0;
		-- self.split:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
		-- self.maxVal:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
		-- self.curVal:SetTextColor(setting.color_iconTextDisabled[1], setting.color_iconTextDisabled[2], setting.color_iconTextDisabled[3], setting.color_iconTextDisabled[4]);
		self.curVal:SetText(talentSet[dbIndex]);
		emu.EmuSub_UnlightIcon(self);
	else
		talentSet[dbIndex] = talentSet[dbIndex] + numPoints;
		self.split:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
		self.maxVal:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
		self.curVal:SetTextColor(setting.color_iconTextAvailable[1], setting.color_iconTextAvailable[2], setting.color_iconTextAvailable[3], setting.color_iconTextAvailable[4]);
		self.curVal:SetText(talentSet[dbIndex]);
		if talentSet[dbIndex] > 0 then
			emu.EmuSub_LightIcon(self);
		else
			emu.EmuSub_UnlightIcon(self);
		end
	end
	if numPoints < 0 and data[12] then
		for i = 1, #data[12] do
			emu.EmuSub_DeactiveIcon(talentFrame.talentIcons[db[data[12][i]][10]]);
		end
		local arrow = talentFrame.reqByArrowSet[dbIndex];
		for i = 1, #arrow do
			emu.EmuSub_SetReqArrowTexCoord(arrow[i], arrow[i].branch, arrow[i].coordFamily, false);
		end
	end

	talentSet.total = talentSet.total + numPoints;
	talentFrame.curTabPoints:SetText(talentSet.total);
	talentSet.totalPerTier[data[1]] = talentSet.totalPerTier[data[1]] + numPoints;
	if talentSet.totalPerTier[talentSet.curTopTier] == 0 then
		talentSet.curCheckedTier = talentSet.curTopTier - 1;
	else
		talentSet.curCheckedTier = talentSet.curTopTier;
	end

	local curTopTier = math.min(math.floor(talentSet.total / NUM_POINTS_NEXT_TIER), MAX_NUM_TIER - 1);
	if curTopTier > talentSet.curTopTier then
		talentSet.curTopTier = curTopTier;
		emu.EmuSub_ActivateTier(talentFrame.talentIcons, curTopTier);
	elseif curTopTier < talentSet.curTopTier then
		emu.EmuSub_DeactiveTier(talentFrame.talentIcons, talentSet.curTopTier);
		talentSet.curTopTier = curTopTier;
	end

	local mainFrame = talentFrame:GetParent();
	mainFrame.totalUsedPoints = mainFrame.totalUsedPoints + numPoints;

	emu.EmuSub_UpdateLabelText(mainFrame);
	if GetMouseFocus() == self then
		emu.EmuCore_TooltipSetTalent(mainFrame.tooltipFrame, self, data[8], talentSet[dbIndex], data[4])
	end

	return ret;
end
function emu.EmuCore_SetData(mainFrame, data)
	do	--check point value
		if not mainFrame.initialized then
			_log_("EmuCore_SetData", 1, - 1);
			return false;
		end
		if not data then
			_log_("EmuCore_SetData", 2, - 1);
			return false;
		end
		if type(data) ~= "string" or data == "" then
			_log_("EmuCore_SetData", 3, type(data));
			return false;
		end
		if not tonumber(data) then
			_log_("EmuCore_SetData", 4, data);
			return false;
		end
	end

	local talentFrames = mainFrame.talentFrames;
	local pos = 1;
	local retry = {};
	for i = 1, 3 do
		local talentFrame = talentFrames[i];
		local icons = talentFrame.talentIcons;
		local db = talentFrame.db;
		for j = 1, #db do
			local d = string.sub(data, pos, pos);
			if d == "" then
				return false;
			end
			pos = pos + 1;
			d = tonumber(d);
			if d ~= 0 then
				local ret = emu.EmuCore_ChangePoint(icons[db[j][10]], d);
				if ret < 0 then
					table.insert(retry, { i, j, d, });
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

	return true;
end
function emu.EmuCore_SetLevel(mainFrame, level)
	if type(level) == "string" then
		level = tonumber(level);
	end
	if level then
		mainFrame.level = level;
		mainFrame.totalAvailablePoints = emu.GetLevelAvailableLevel(level);
	end
end

function emu.Emu_Add(self, numPoints)
	emu.EmuCore_ChangePoint(self, numPoints);
end
function emu.Emu_Sub(self, numPoints)
	emu.EmuCore_ChangePoint(self, - numPoints);
end
function emu.Emu_Set(mainFrame, class, data, level, readOnly, name)
	emu.EmuCore_SetLevel(mainFrame, level);
	emu.EmuCore_Reset(mainFrame);
	if not emu.EmuCore_SetClass(mainFrame, class) then
		mainFrame:Hide();
		return false;
	end
	if data then
		emu.EmuCore_SetData(mainFrame, data);
		mainFrame.data = data;
	end
	emu.EmuCore_SetLevel(mainFrame, level);
	emu.EmuSub_SetReadOnly(mainFrame, readOnly);

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
		objects.curclassIndicator:Hide();
		emu.EmuSub_SetReadOnly(mainFrame, true);
	else
		local objects = mainFrame.objects;
		objects.label:SetText(L.Emu);
		objects.resetToEmu:Hide();
		objects.resetToSetButton:Hide();
		local classButtons = mainFrame.classButtons;
		for index = 1, #_indexToClass do
			classButtons[index]:Show();
		end
		objects.curclassIndicator:Show();
		objects.curclassIndicator:ClearAllPoints();
		objects.curclassIndicator:SetPoint("RIGHT", classButtons[_classToIndex[mainFrame.class]], "LEFT", 0, 0);
	end

	return true;
end
function emu.Emu_ResetTalent(mainFrame)
	local talentFrames = mainFrame.talentFrames;
	for specIndex = 1, 3 do
		local talentFrame = talentFrames[specIndex];
		local talentIcons = talentFrame.talentIcons;
		local db = talentFrame.db;
		for i = 1, #db do
			local data = db[i];
			local icon = talentIcons[data[10]];
			if data[1] ~= 0 or data[5] then
				emu.EmuSub_DeactiveIcon(icon);
			else
				emu.EmuSub_ActivateIcon(icon);
				emu.EmuSub_UnlightIcon(icon);
			end
			talentIcons[i].curVal:SetText("0");
		end

		local talentSet = talentFrame.talentSet;
		for i = 1, MAX_NUM_TALENTS do
			talentSet[i] = 0;
		end
		for i = 0, MAX_NUM_TIER do
			talentSet.totalPerTier[i] = 0;
		end
		talentSet.total = 0;
		talentSet.curTopTier = 0;
		talentSet.curCheckedTier = 0;

		talentFrame.curTabPoints:SetText(0);
	end

	emu.EmuSub_UpdateLabelText(mainFrame);
end
function emu.Emu_ResetTalentSingleTab(mainFrame, specIndex)
	local talentFrame = mainFrame.talentFrames[specIndex];
	local talentIcons = talentFrame.talentIcons;
	local db = talentFrame.db;
	for i = 1, #db do
		local data = db[i];
		local icon = talentIcons[data[10]];
		if data[1] ~= 0 or data[5] then
			emu.EmuSub_DeactiveIcon(icon);
		else
			emu.EmuSub_ActivateIcon(icon);
			emu.EmuSub_UnlightIcon(icon);
		end
		talentIcons[i].curVal:SetText("0");
	end

	local talentSet = talentFrame.talentSet;
	for i = 1, MAX_NUM_TALENTS do
		talentSet[i] = 0;
	end
	for i = 0, MAX_NUM_TIER do
		talentSet.totalPerTier[i] = 0;
	end
	talentSet.total = 0;
	talentSet.curTopTier = 0;
	talentSet.curCheckedTier = 0;

	talentFrame.curTabPoints:SetText(0);
	emu.EmuSub_UpdateLabelText(mainFrame);
end
function emu.Emu_ResetToSet(mainFrame)
	local class = mainFrame.class;
	local data = mainFrame.data;
	local level = mainFrame.level;
	local readOnly = mainFrame.readOnly;
	local name = mainFrame.name;
	emu.EmuCore_Reset(mainFrame);
	emu.Emu_Set(mainFrame, class, data, level, readOnly, name)
end
function emu.Emu_SetTooltip(icon)
	local talentFrame = icon:GetParent();
	local dbIndex = icon.dbIndex;
	local data = talentFrame.db[dbIndex];
	emu.EmuCore_TooltipSetTalent(talentFrame:GetParent().tooltipFrame, icon, data[8], talentFrame.talentSet[dbIndex], data[4]);
end
function emu.Emu_TooltipHide(icon)
	local tooltipFrame = icon:GetParent():GetParent().tooltipFrame;
	tooltipFrame:Hide();
	tooltipFrame.tooltip1:Hide();
	tooltipFrame.tooltip2:Hide();
end
function emu.Emu_Query(name)
	if name then
		SendAddonMessage(ADDON_PREFIX, ADDON_MSG_QUERY, "WHISPER", name);
	end
end
function emu.Emu_ApplyTalents(mainFrame)
	if InCombatLockdown() then
		_error_("In COMBAT");
		return;
	end
	if string.lower(select(2, UnitClass('player'))) == string.lower(mainFrame.class) then
		TalentFrame_Update();
		if emu.GetPontsReqLevel(mainFrame.totalUsedPoints) > UnitLevel('player') then
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
					--print(id, rank, talentSet[id])
					break;
				end
				local data = db[id];
				if tier ~= data[1] + 1 or column ~= data[2] + 1 or maxRank ~= data[4] then
					canApply = false;
					--print(tier, column, maxRank, data[1], data[2], data[4])
					break;
				end
				--LearnTalent()
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

function emu.Emu_DestroyMainFrame(mainFrame)
	return emu.winMan_RelWin(mainFrame.id);
end
function emu.Emu_Create(class, data, level, readOnly, name, style, ...)
	local mainFrame = emu.winMan_GetWin()
	emu.mainFrameSetStyle(mainFrame, style or config.style);
	if not class or class == "" then
		class = select(2, UnitClass('player'));
	end
	if emu.Emu_Set(mainFrame, class, data, tonumber(level) or 60, readOnly, name) then
		return mainFrame.id;
	end
	emu.winMan_RelWin(mainFrame.id);
	return nil;
end
function emu.Emu_Destroy(winId)
	return emu.winMan_RelWin(winId);
end
function emu.Emu_Import(code)
	local class, data, level = emu.EmuCore_Decoder(code);
	if class and data and level then
		local mainFrame = emu.winMan_GetWin();
		if not emu.Emu_Set(mainFrame, class, data, level) then
			emu.winMan_RelWin(mainFrame.id);
			return false;
		end
		return true;
	end
	return false;
end
function emu.Emu_Export(winId)
	local mainFrame = emu.winMan_GetWin(winId);
	if mainFrame then
		return emu.EmuCore_Encoder(mainFrame);
	else
		return nil;
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
			curTabIndicator:SetParent(specButtons[mainFrame.curTab]);
			curTabIndicator:ClearAllPoints();
			curTabIndicator:SetPoint("LEFT", specButtons[mainFrame.curTab], "RIGHT", 0, 0);
			mainFrame:SetMinResize(setting.mainFrameXSizeMin_Style2, setting.mainFrameYSizeMin_Style2);

			local scale = (mainFrame:GetHeight() - setting.talentFrameYToBorder * 2) / (setting.talentFrameYSize + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize);
			mainFrame.talentFrameScale = scale;
			mainFrame:SetWidth(scale * setting.talentFrameXSizeSingle + setting.talentFrameXToBorder * 2);
		else
			return;
		end
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
		GameTooltip:ClearAllPoints();
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		GameTooltip:SetText(self.information, 1.0, 1.0, 1.0);
	end
end
local function Info_OnLeave(self, motion)
	if GameTooltip:IsOwned(self) then
		GameTooltip:Hide();
	end
end


function emu.CreateTooltipFrame(mainFrame)
	local tooltipFrame = CreateFrame("Frame", mainFrame:GetName() .. "TooltipFrame", mainFrame);
	tooltipFrame:SetSize(1, 1);
	--tooltipFrame:SetPoint("CENTER");
	tooltipFrame:SetFrameStrata("FULLSCREEN_DIALOG");
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

	fontString1f1:SetTextColor(0.0, 1.0, 1.0, 1.0);
	fontString1f2:SetTextColor(0.0, 1.0, 1.0, 1.0);
	fontString2f1:SetTextColor(0.0, 1.0, 1.0, 1.0);
	fontString2f2:SetTextColor(0.0, 1.0, 1.0, 1.0);

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

local function resetButton_OnClick(self)
	local talentFrame = self:GetParent();
	local mainFrame = talentFrame:GetParent();
	local specIndex = talentFrame.id;
	emu.Emu_ResetTalentSingleTab(mainFrame, specIndex);
	emu.EmuSub_SetReadOnly(mainFrame, false);
end
local function talentIcon_OnEnter(self)
	emu.Emu_SetTooltip(self);
end
local function talentIcon_OnLeave(self)
	emu.Emu_TooltipHide(self);
end
local function talentIcon_OnClick(self, button)
	if not self.active then
		return;
	end
	if button == "LeftButton" then
		emu.Emu_Add(self, 1);
	elseif button == "RightButton" then
		emu.Emu_Sub(self, 1);
	end
end
function emu.talentFrameUpdateSize(mainFrame, talentFrames)
	local style = mainFrame.style;
	if style == 1 then
		local scale = math.min((mainFrame:GetWidth() - setting.talentFrameXToBorder * 2) / setting.talentFrameXSizeTriple, (mainFrame:GetHeight() - setting.talentFrameYToBorder * 2) / (setting.talentFrameYSize + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize));
		talentFrames[1]:SetScale(scale);
		talentFrames[2]:SetScale(scale);
		talentFrames[3]:SetScale(scale);
		mainFrame.talentFrameScale = scale;
	elseif style == 2 then
		local scale = math.min((mainFrame:GetWidth() - setting.talentFrameXToBorder * 2) / setting.talentFrameXSizeSingle, (mainFrame:GetHeight() - setting.talentFrameYToBorder * 2) / (setting.talentFrameYSize + setting.mainFrameHeaderYSize + setting.mainFrameFooterYSize));
		talentFrames[1]:SetScale(scale);
		talentFrames[2]:SetScale(scale);
		talentFrames[3]:SetScale(scale);
		mainFrame.talentFrameScale = scale;
	end
end

function emu.CreateTalentIcon(talentFrame, id)
	local icon = CreateFrame("Button", talentFrame:GetName() .. "TalentIcon" .. id, talentFrame);
	icon:SetSize(setting.talentIconXSize, setting.talentIconYSize);

	icon:Hide();
	icon:EnableMouse(true);
	icon:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	icon:SetScript("OnClick", talentIcon_OnClick);
	icon:SetScript("OnEnter", talentIcon_OnEnter);
	icon:SetScript("OnLeave", talentIcon_OnLeave);

	--icon:SetBackdrop(setting.iconBackdrop);
	--icon:SetBackdropColor(setting.iconBackdropColor[1], setting.iconBackdropColor[2], setting.iconBackdropColor[3], setting.iconBackdropColor[4]);
	--icon:SetBackdropBorderColor(setting.iconBackdropBorderColor[1], setting.iconBackdropBorderColor[2], setting.iconBackdropBorderColor[3], setting.iconBackdropBorderColor[4]);
	icon:SetNormalTexture("Interface\\Icons\\inv_misc_questionmark");
	icon:SetPushedTexture("Interface\\Icons\\inv_misc_questionmark");
	--icon:SetDisabledTexture("Interface\\Buttons\\UI-StopButton");
	--icon:GetDisabledTexture():SetVertexColor(0.5, 0.5, 0.5, 1.0);
	--icon:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
	icon:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
	icon:GetHighlightTexture():SetTexCoord(0.08, 0.92, 0.08, 0.92);

	local split = icon:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	split:SetText("/");
	split:SetPoint("CENTER", icon, "BOTTOMRIGHT", 0, 0);

	local maxVal = icon:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	maxVal:SetText("1");
	maxVal:SetPoint("LEFT", split, "RIGHT", 0, 0);

	local curVal = icon:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
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
	for id = 1, MAX_ICON_PER_SPEC do
		local icon = emu.CreateTalentIcon(talentFrame, id);
		--icon:SetPoint("TOPLEFT", talentFrame, "TOPLEFT", ofsX + setting.talentIconXToBorder + (setting.talentIconXSize + setting.talentIconXGap) * posX, - setting.talentIconYToBorder - (setting.talentIconYSize + setting.talentIconYGap) * posY);
		icon:SetPoint("TOP", talentFrame, "TOP", (setting.talentIconXSize + setting.talentIconXGap) * (posX - MAX_NUM_COL * 0.5 + 0.5), - setting.talentFrameHeaderYSize - setting.talentIconYToBorder - (setting.talentIconYSize + setting.talentIconYGap) * posY);
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
function emu.CreateTalentFrames(mainFrame)
	local talentFrames = {};

	for specIndex = 1, 3 do
		local talentFrame = CreateFrame("Frame", mainFrame:GetName() .. "TalentFrame" .. specIndex, mainFrame);
		--talentFrame:SetPoint("CENTER", 0, (setting.mainFrameHeaderYSize - setting.mainFrameFooterYSize) * 0.5);
		--talentFrame:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", 0, 20);
		talentFrame:SetSize(setting.talentFrameXSizeSingle, setting.talentFrameYSize);
		--talentFrame:SetBackdrop(setting.mainFrameBackdrop);
		--talentFrame:SetBackdropColor(setting.mainFrameBackdropColor[1], setting.mainFrameBackdropColor[2], setting.mainFrameBackdropColor[3], setting.mainFrameBackdropColor[4]);

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
		hSep[1]:SetHeight(2);
		hSep[1]:SetPoint("LEFT", talentFrame, "TOPLEFT", 0, 0);
		hSep[1]:SetPoint("RIGHT", talentFrame, "TOPRIGHT", 0, 0);
		hSep[1]:SetTexture("Interface\\Chatframe\\UI-ChatFrame-BorderLeft");
		hSep[1]:SetTexCoord(0.125, 0.375, 0.0, 1.0);
		hSep[2] = talentFrame:CreateTexture(nil, "ARTWORK");
		hSep[2]:SetHeight(2);
		hSep[2]:SetPoint("LEFT", talentFrame, "BOTTOMLEFT", 0, 0);
		hSep[2]:SetPoint("RIGHT", talentFrame, "BOTTOMRIGHT", 0, 0);
		hSep[2]:SetTexture("Interface\\Chatframe\\UI-ChatFrame-BorderLeft");
		hSep[2]:SetTexCoord(0.125, 0.375, 0.0, 1.0);
		hSep[3] = talentFrame:CreateTexture(nil, "ARTWORK");
		hSep[3]:SetHeight(2);
		hSep[3]:SetPoint("LEFT", talentFrame, "BOTTOMLEFT", 0, setting.talentFrameFooterYSize);
		hSep[3]:SetPoint("RIGHT", talentFrame, "BOTTOMRIGHT", 0, setting.talentFrameFooterYSize);
		hSep[3]:SetTexture("Interface\\Chatframe\\UI-ChatFrame-BorderLeft");
		hSep[3]:SetTexCoord(0.125, 0.375, 0.0, 1.0);

		talentFrame.hSep = hSep;

		local vSep = {  };
		vSep[1] = talentFrame:CreateTexture(nil, "ARTWORK");
		vSep[1]:SetWidth(2);
		vSep[1]:SetPoint("TOP", talentFrame, "TOPLEFT", 0, 0);
		vSep[1]:SetPoint("BOTTOM", talentFrame, "BOTTOMLEFT", 0, 0);
		vSep[1]:SetTexture("Interface\\ChatFrame\\UI-ChatFrame-BorderTop");
		vSep[1]:SetTexCoord(0.0, 1.0, 0.125, 0.375);
		vSep[2] = talentFrame:CreateTexture(nil, "ARTWORK");
		vSep[2]:SetWidth(2);
		vSep[2]:SetPoint("TOP", talentFrame, "TOPRIGHT", 0, 0);
		vSep[2]:SetPoint("BOTTOM", talentFrame, "BOTTOMRIGHT", 0, 0);
		vSep[2]:SetTexture("Interface\\ChatFrame\\UI-ChatFrame-BorderTop");
		vSep[2]:SetTexCoord(0.0, 1.0, 0.125, 0.375);

		talentFrame.vSep = vSep;

		talentFrame.talentIcons = emu.CreateTalentIcons(talentFrame);

		local curTabPointsLabel = talentFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
		curTabPointsLabel:SetText(L.curTabPointsLabel);
		curTabPointsLabel:SetPoint("RIGHT", talentFrame, "BOTTOM", 0, setting.talentFrameFooterYSize / 2);
		local curTabPoints = talentFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
		curTabPoints:SetText("0");
		curTabPoints:SetPoint("LEFT", curTabPointsLabel, "RIGHT", 4, 0);

		curTabPointsLabel:SetTextColor(0.0, 1.0, 0.0, 1.0);
		curTabPoints:SetTextColor(0.0, 1.0, 0.0, 1.0);

		local resetButton = CreateFrame("Button", nil, talentFrame);
		resetButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
		resetButton:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton");
		resetButton:SetPushedTexture("Interface\\Buttons\\UI-RefreshButton");
		resetButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
		resetButton:SetPoint("LEFT", curTabPointsLabel, "RIGHT", 24, 0);
		resetButton:SetScript("OnClick", resetButton_OnClick);
		resetButton:SetScript("OnEnter", Info_OnEnter);
		resetButton:SetScript("OnLeave", Info_OnLeave);
		resetButton.information = L.resetButton;
		talentFrame.resetButton = resetButton;

		talentFrame.id = specIndex;

		talentFrame.curTabPoints = curTabPoints;

		talentFrame.talentSet = { totalPerTier = {  }, total = 0, curTopTier = 0, curCheckedTier = 0, };
		for i = 1, MAX_NUM_TALENTS do
			talentFrame.talentSet[i] = 0;
		end
		for i = 0, MAX_NUM_TIER do
			talentFrame.talentSet.totalPerTier[i] = 0;
		end
		talentFrame.reqArrows = { used = 0, };
		talentFrame.reqByArrowSet = {  };
		for i = 1, MAX_ICON_PER_SPEC do
			talentFrame.reqByArrowSet[i] = {  };
		end

		talentFrames[specIndex] = talentFrame;
	end

	talentFrames[2]:SetPoint("CENTER", mainFrame, "CENTER", 0, (setting.mainFrameFooterYSize - setting.mainFrameHeaderYSize) * 0.5);
	talentFrames[1]:SetPoint("TOPRIGHT", talentFrames[2], "TOPLEFT");
	talentFrames[1]:SetPoint("BOTTOMRIGHT", talentFrames[2], "BOTTOMLEFT");
	talentFrames[3]:SetPoint("TOPLEFT", talentFrames[2], "TOPRIGHT");
	talentFrames[3]:SetPoint("BOTTOMLEFT", talentFrames[2], "BOTTOMRIGHT");

	return talentFrames;
end


local function specButton_OnClick(self)
	emu.Emu_ChangeTab_Style2(self:GetParent(), self.id);
end
local function classButton_OnClick(self)
	local mainFrame = self:GetParent();
	if mainFrame.class ~= self.class then
		emu.EmuCore_Reset(mainFrame);
		emu.EmuCore_SetClass(mainFrame, self.class);
		local objects = mainFrame.objects;
		objects.curclassIndicator:Show();
		objects.curclassIndicator:ClearAllPoints();
		objects.curclassIndicator:SetPoint("RIGHT", mainFrame.classButtons[_classToIndex[mainFrame.class]], "LEFT", 0, 0);
	end
end
local function resetToEmu_OnClick(self)
	emu.EmuSub_SetToEmu(self:GetParent());
	self:Hide();
end
local function resetToSetButton_OnClick(self)
	local mainFrame = self:GetParent();
	emu.Emu_ResetToSet(mainFrame);
	self:Hide();
	--if mainFrame.name then
		--emu.EmuSub_SetReadOnly(mainFrame, true);
		--self:Hide();
		--mainFrame.objects.resetToEmu:Show();
	--end
end
local function resetAllButton_OnClick(self)
	emu.Emu_ResetTalent(self:GetParent());
	emu.EmuSub_SetReadOnly(self:GetParent(), false);
end
local function inspectTargetButton_OnClick(self)
	if UnitExists('target') then
		local name = UnitName('target');
		if name then
			emu.specializedMainFrameInspect[name] = {GetTime(), self:GetParent()};
			emu.Emu_Query(name);
		end
	end
end
local function applyTalentsButton_OnClick(self)
	emu.Emu_ApplyTalents(self:GetParent());
end
local function importButton_OnClick(self)
	local editBox = self:GetParent().objects.editBox;
	if editBox:IsShown() and editBox.parent == self then
		editBox:Hide();
	else
		editBox:SetText("");
		editBox:ClearAllPoints();
		editBox:SetPoint("LEFT", self, "RIGHT", setting.editBoxYSize + 4, 0);
		editBox:Show();
		editBox.OKButton:Show();
		editBox.parent = self;
	end
end
local function exportButton_OnClick(self)
	local editBox = self:GetParent().objects.editBox;
	if editBox:IsShown() and editBox.parent == self then
		editBox:Hide();
	else
		editBox:ClearAllPoints();
		editBox:SetPoint("LEFT", self, "RIGHT", 4, 0);
		editBox:Show();
		editBox:SetText(emu.EmuCore_Encoder(self:GetParent()));
		editBox.OKButton:Hide();
		editBox.parent = self;
	end
end
local function editBox_OnEnterPressed(self)
	if self:GetText() and self:GetText() ~= "" then
		local class, data, level = emu.EmuCore_Decoder(self:GetText());
		if class and data and level then
			emu.Emu_Set(self:GetParent(), class, data, level);
		end
	end
	self:ClearFocus();
	self:Hide();
end

local function readOnlyButton_OnClick(self, button)
	if button == "LeftButton" then
		local mainFrame = self:GetParent();
		emu.EmuSub_SetReadOnly(mainFrame, not mainFrame.readOnly);
	elseif button == "RightButton" then
		if ALADROP then
			local readOnlyButton_OnClickData =
			{
				handler = Config_SetStyle,
				elements =
				{
					{
						handler = emu.mainFrameSetStyle,
						para =
						{
							self:GetParent(), 1,
						},
						text = L.SetStyleAllTo1_ThisWin,
					},
					{
						handler = emu.mainFrameSetStyle,
						para =
						{
							self:GetParent(), 2,
						},
						text = L.SetStyleAllTo2_ThisWin,
					},
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
				};
			}
			ALADROP(self, "BOTTOMLEFT", readOnlyButton_OnClickData);
		end
	end
end

function emu.CreateMainFrameSubObject(mainFrame)
	local objects = {};
	mainFrame.objects = objects;

	local readOnlyButton = CreateFrame("Button", nil, mainFrame);
	readOnlyButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
	readOnlyButton:SetNormalTexture("Interface\\petbattles\\petbattle-lockicon");
	readOnlyButton:SetPushedTexture("Interface\\petbattles\\petbattle-lockicon");
	readOnlyButton:GetNormalTexture():SetVertexColor(0.5, 0.5, 0.5, 0.75)
	readOnlyButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	readOnlyButton:SetPoint("TOPLEFT", mainFrame, 2, (setting.controlButtonSize - setting.mainFrameHeaderYSize) * 0.5);
	readOnlyButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	readOnlyButton:SetScript("OnClick", readOnlyButton_OnClick);
	readOnlyButton:SetScript("OnEnter", Info_OnEnter);
	readOnlyButton:SetScript("OnLeave", Info_OnLeave);
	readOnlyButton.information = L.readOnlyButton;
	objects.readOnlyButton = readOnlyButton;

	local readOnlyText = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	readOnlyText:SetText("");
	readOnlyText:SetPoint("LEFT", readOnlyButton, "RIGHT", 0, 0);
	objects.readOnlyText = readOnlyText;

	local closeButton = CreateFrame("Button", nil, mainFrame);
	closeButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
	closeButton:SetNormalTexture("Interface\\Buttons\\UI-StopButton");
	closeButton:SetPushedTexture("Interface\\Buttons\\UI-StopButton");
	closeButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	closeButton:SetPoint("TOPRIGHT", - 2, (setting.controlButtonSize - setting.mainFrameHeaderYSize) * 0.5);
	closeButton:SetScript("OnClick", function(self, button)
			emu.winMan_RelWin(self:GetParent().id);
		end
	);
	closeButton:SetScript("OnEnter", Info_OnEnter);
	closeButton:SetScript("OnLeave", Info_OnLeave);
	closeButton.information = L.closeButton;
	objects.closeButton = closeButton;

	local label = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	label:SetText(L.curPointsRemaining);
	label:SetPoint("CENTER", mainFrame, "TOP", 0, - setting.mainFrameHeaderYSize * 0.5);
	objects.label = label;

	local resetToSetButton = CreateFrame("Button", nil, mainFrame);
	resetToSetButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
	resetToSetButton:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton");
	resetToSetButton:SetPushedTexture("Interface\\Buttons\\UI-RefreshButton");
	resetToSetButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	resetToSetButton:SetPoint("LEFT", label, "RIGHT", 0, 0);
	resetToSetButton:SetScript("OnClick", resetToSetButton_OnClick);
	resetToSetButton:SetScript("OnEnter", Info_OnEnter);
	resetToSetButton:SetScript("OnLeave", Info_OnLeave);
	resetToSetButton.information = L.resetToSetButton;
	objects.resetToSetButton = resetToSetButton;

	local resetToEmu = CreateFrame("Button", nil, mainFrame);
	resetToEmu:SetSize(setting.controlButtonSize, setting.controlButtonSize);
	resetToEmu:SetNormalTexture("Interface\\Buttons\\UI-StopButton");
	resetToEmu:SetPushedTexture("Interface\\Buttons\\UI-StopButton");
	resetToEmu:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	resetToEmu:SetPoint("LEFT", label, "RIGHT", 0, 0);
	resetToEmu:SetScript("OnClick", resetToEmu_OnClick);
	resetToEmu:SetScript("OnEnter", Info_OnEnter);
	resetToEmu:SetScript("OnLeave", Info_OnLeave);
	resetToEmu.information = L.resetToEmu;
	objects.resetToEmu = resetToEmu;

	local resetAllButton = CreateFrame("Button", nil, mainFrame);
	resetAllButton:SetSize(setting.controlButtonSize, setting.controlButtonSize);
	resetAllButton:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton");
	resetAllButton:SetPushedTexture("Interface\\Buttons\\UI-RefreshButton");
	resetAllButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	resetAllButton:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMRIGHT", - 8, (setting.mainFrameFooterYSize - setting.controlButtonSize) * 0.5);
	resetAllButton:SetScript("OnClick", resetAllButton_OnClick);
	resetAllButton:SetScript("OnEnter", Info_OnEnter);
	resetAllButton:SetScript("OnLeave", Info_OnLeave);
	resetAllButton.information = L.resetAllButton;
	objects.resetAllButton = resetAllButton;

	local inspectTargetButton = CreateFrame("Button", nil, mainFrame);
	inspectTargetButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
	inspectTargetButton:SetNormalTexture("Interface\\Icons\\inv_trinket_naxxramas02");
	inspectTargetButton:SetPushedTexture("Interface\\Icons\\inv_trinket_naxxramas02");
	inspectTargetButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	inspectTargetButton:SetPoint("BOTTOMRIGHT", mainFrame, "BOTTOMLEFT", -4, 0);
	inspectTargetButton:Show();
	inspectTargetButton:SetScript("OnClick", inspectTargetButton_OnClick);
	inspectTargetButton:SetScript("OnEnter", Info_OnEnter);
	inspectTargetButton:SetScript("OnLeave", Info_OnLeave);
	inspectTargetButton.information = L.inspectTargetButton;
	mainFrame.objects.inspectTargetButton = inspectTargetButton;

	local applyTalentsButton = CreateFrame("Button", nil, mainFrame);
	applyTalentsButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
	applyTalentsButton:SetNormalTexture("Interface\\Buttons\\ui-checkbox-check");
	applyTalentsButton:SetPushedTexture("Interface\\Buttons\\ui-checkbox-check");
	applyTalentsButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	applyTalentsButton:SetDisabledTexture("Interface\\Buttons\\ui-checkbox-check");
	applyTalentsButton:GetDisabledTexture():SetVertexColor(0.25, 0.25, 0.25, 1.0);
	applyTalentsButton:SetPoint("BOTTOMLEFT", mainFrame, "BOTTOMRIGHT", 4, 0);
	applyTalentsButton:Show();
	applyTalentsButton:SetScript("OnClick", applyTalentsButton_OnClick);
	applyTalentsButton:SetScript("OnEnter", Info_OnEnter);
	applyTalentsButton:SetScript("OnLeave", Info_OnLeave);
	applyTalentsButton.information = L.applyTalentsButton;
	mainFrame.objects.applyTalentsButton = applyTalentsButton;

	local importButton = CreateFrame("Button", nil, mainFrame);
	importButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
	importButton:SetNormalTexture("interface\\tooltips\\reforgegreenarrow");
	importButton:SetPushedTexture("interface\\tooltips\\reforgegreenarrow");
	importButton:GetNormalTexture():SetTexCoord(1.0, 0.0, 0.0, 1.0);
	importButton:GetPushedTexture():SetTexCoord(1.0, 0.0, 0.0, 1.0);
	importButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	importButton:SetPoint("BOTTOM", applyTalentsButton, "TOP", 0, 10);
	importButton:Show();
	importButton:SetScript("OnClick", importButton_OnClick);
	importButton:SetScript("OnEnter", Info_OnEnter);
	importButton:SetScript("OnLeave", Info_OnLeave);
	importButton.information = L.importButton;
	mainFrame.objects.importButton = importButton;

	local exportButton = CreateFrame("Button", nil, mainFrame);
	exportButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
	exportButton:SetNormalTexture("interface\\tooltips\\reforgegreenarrow");
	exportButton:SetPushedTexture("interface\\tooltips\\reforgegreenarrow");
	exportButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	exportButton:SetPoint("BOTTOM", importButton, "TOP", 0, 10);
	exportButton:Show();
	exportButton:SetScript("OnClick", exportButton_OnClick);
	exportButton:SetScript("OnEnter", Info_OnEnter);
	exportButton:SetScript("OnLeave", Info_OnLeave);
	exportButton.information = L.exportButton;
	mainFrame.objects.exportButton = exportButton;

	local editBox = CreateFrame("EditBox", nil, mainFrame);
	editBox:SetSize(setting.editBoxXSize, setting.editBoxYSize);
	editBox:SetFontObject(GameFontHighlightSmall);
	editBox:SetAutoFocus(false);
	editBox:SetJustifyH("LEFT");
	editBox:Show();
	editBox:EnableMouse(true);
	editBox:SetScript("OnEnterPressed", editBox_OnEnterPressed);
	editBox:SetScript("OnEscapePressed", function(self) self:SetText(""); self:ClearFocus(); self:Hide(); end);
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
	editBoxOKButton:SetNormalTexture("Interface\\Buttons\\ui-checkbox-check");
	editBoxOKButton:SetPushedTexture("Interface\\Buttons\\ui-checkbox-check");
	editBoxOKButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	editBoxOKButton:SetPoint("RIGHT", editBox, "LEFT", 0, -4);
	editBoxOKButton:Show();
	editBoxOKButton:SetScript("OnClick", function(self) editBox_OnEnterPressed(self:GetParent()); end);
	editBoxOKButton:SetScript("OnEnter", Info_OnEnter);
	editBoxOKButton:SetScript("OnLeave", Info_OnLeave);
	editBoxOKButton.information = L.editBoxOKButton;
	editBox.OKButton = editBoxOKButton;

	local curPointsRemainingLabel = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	curPointsRemainingLabel:SetText(L.curPointsRemaining);
	curPointsRemainingLabel:SetPoint("BOTTOM", mainFrame, "BOTTOM", - 20, 6);

	local curPointsRemaining = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	curPointsRemaining:SetText("51");
	curPointsRemaining:SetPoint("LEFT", curPointsRemainingLabel, "RIGHT", 2, 0);

	curPointsRemainingLabel:SetTextColor(0.0, 1.0, 1.0, 1.0);
	curPointsRemaining:SetTextColor(0.0, 1.0, 1.0, 1.0);

	local curPointsUsedLabel = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	curPointsUsedLabel:SetText(L.curPointsUsed);
	curPointsUsedLabel:SetPoint("RIGHT", curPointsRemainingLabel, "LEFT", - 24, 0);

	local curPointsUsed = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	curPointsUsed:SetText("0");
	curPointsUsed:SetPoint("LEFT", curPointsUsedLabel, "RIGHT", 2, 0);

	curPointsUsedLabel:SetTextColor(0.0, 1.0, 0.0, 1.0);
	curPointsUsed:SetTextColor(0.0, 1.0, 0.0, 1.0);

	local curPointsReqLevelLabel = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	curPointsReqLevelLabel:SetText(L.curPointsReqLevel);
	curPointsReqLevelLabel:SetPoint("LEFT", curPointsRemainingLabel, "RIGHT", 20, 0);

	local curPointsReqLevel = mainFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
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

	local classButtons = {};--_indexToClass
	for index = 1, #_indexToClass do
		local class = _indexToClass[index];
		local classButton = CreateFrame("Button", nil, mainFrame);
		classButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
		classButton:SetNormalTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
		classButton:SetPushedTexture("Interface\\TargetingFrame\\UI-Classes-Circles");
		local coord = CLASS_ICON_TCOORDS[string.upper(class)];
		if coord then
			classButton:GetNormalTexture():SetTexCoord(coord[1] + 2 / 256, coord[2] - 2 / 256, coord[3] + 2 / 256, coord[4] - 2 / 256);
			classButton:GetPushedTexture():SetTexCoord(coord[1] + 2 / 256, coord[2] - 2 / 256, coord[3] + 2 / 256, coord[4] - 2 / 256);
		else
			classButton:GetNormalTexture():SetTexCoord(0.75, 1.00, 0.75, 1.00);
			classButton:GetPushedTexture():SetTexCoord(0.75, 1.00, 0.75, 1.00);
		end
		classButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
		classButton:SetPoint("TOPRIGHT", mainFrame, "TOPLEFT", -4, - (setting.tabButtonSize + setting.tabButtonGap) * (index - 1));
		classButton:Show();
		classButton:SetScript("OnClick", classButton_OnClick);
		classButton:SetScript("OnEnter", Info_OnEnter);
		classButton:SetScript("OnLeave", Info_OnLeave);
		classButton.id = index;
		classButton.class = class;
		local classColorTable = RAID_CLASS_COLORS[string.upper(class)];
		classButton.information = string.format("\124cff%.2x%.2x%.2x", classColorTable.r * 255, classColorTable.g * 255, classColorTable.b * 255) .. L.classButton[class] .. "\124r";
		classButtons[index] = classButton;
	end
	mainFrame.classButtons = classButtons;

	local curclassIndicator = mainFrame:CreateTexture(nil, "OVERLAY");
	curclassIndicator:SetSize(setting.curclassIndicatorSize, setting.curclassIndicatorSize);
	curclassIndicator:SetTexture("interface\\tooltips\\reforgegreenarrow");
	curclassIndicator:Hide();
	mainFrame.objects.curclassIndicator = curclassIndicator;

	local specButtons = {};
	for specIndex = 1, 3 do
		local specButton = CreateFrame("Button", nil, mainFrame);
		specButton:SetSize(setting.tabButtonSize, setting.tabButtonSize);
		specButton:SetNormalTexture("Interface\\Buttons\\UI-RefreshButton");
		specButton:SetPushedTexture("Interface\\Buttons\\UI-RefreshButton");
		specButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
		specButton:SetPoint("TOPLEFT", mainFrame, "TOPRIGHT", 4, - (setting.tabButtonSize + setting.tabButtonGap) * (specIndex - 1));
		specButton:Hide();
		specButton:SetScript("OnClick", specButton_OnClick);
		specButton:SetScript("OnEnter", Info_OnEnter);
		specButton:SetScript("OnLeave", Info_OnLeave);
		specButton.id = specIndex;
		specButton.information = L.specButton;
		specButtons[specIndex] = specButton;
	end
	mainFrame.specButtons = specButtons;

	local curTabIndicator = mainFrame:CreateTexture(nil, "OVERLAY");
	curTabIndicator:SetSize(setting.curSpecIndicatorSize, setting.curSpecIndicatorSize);
	curTabIndicator:SetTexture("interface\\tooltips\\reforgegreenarrow");
	curTabIndicator:SetTexCoord(1.0, 0.0, 0.0, 1.0);
	curTabIndicator:Hide();
	mainFrame.objects.curTabIndicator = curTabIndicator;
end

local function OnSizeChanged(self, width, height)
	emu.talentFrameUpdateSize(self, self.talentFrames);
	for _, obj in pairs(self.objects) do
		obj:SetScale(self.talentFrameScale);
	end
	for _, obj in pairs(self.specButtons) do
		obj:SetScale(self.talentFrameScale);
	end
	for _, obj in pairs(self.classButtons) do
		obj:SetScale(self.talentFrameScale);
	end
end

local temp_id = 0;
function emu.CreateMainFrame()
	local mainFrame = CreateFrame("Frame", NAME .. "MainFrame" .. temp_id, UIParent);
	temp_id = temp_id + 1;
	mainFrame.id = temp_id;

	mainFrame:SetPoint("CENTER");
	mainFrame:SetSize(setting.mainFrameXSizeDefault_Style1, setting.mainFrameYSizeDefault_Style1);
	mainFrame:SetMinResize(setting.mainFrameXSizeMin_Style1, setting.mainFrameYSizeMin_Style1);
	--mainFrame:SetMaxResize(1280, 720);
	mainFrame:SetBackdrop(setting.mainFrameBackdrop);
	mainFrame:SetBackdropColor(setting.mainFrameBackdropColor[1], setting.mainFrameBackdropColor[2], setting.mainFrameBackdropColor[3], setting.mainFrameBackdropColor[4]);
	mainFrame:SetBackdropBorderColor(setting.mainFrameBackdropBorderColor[1], setting.mainFrameBackdropBorderColor[2], setting.mainFrameBackdropBorderColor[3], setting.mainFrameBackdropBorderColor[4]);

	mainFrame.talentFrames = emu.CreateTalentFrames(mainFrame);
	mainFrame.tooltipFrame = emu.CreateTooltipFrame(mainFrame);

	emu.CreateMainFrameSubObject(mainFrame);

	mainFrame:EnableMouse(true);
	mainFrame:SetMovable(true);
	mainFrame:SetResizable(true);

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
				--recordPos();
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

	mainFrame:Hide();

	mainFrame.style = 1;
	emu.mainFrameSetStyle(mainFrame, config.style);
	if config.style == 1 then
		mainFrame:SetSize(setting.mainFrameXSizeDefault_Style1, setting.mainFrameYSizeDefault_Style1);
	elseif config.style == 2 then
		mainFrame:SetSize(setting.mainFrameXSizeDefault_Style2, setting.mainFrameYSizeDefault_Style2);
	end

	mainFrame.curTab = 1;
	mainFrame.class = UnitClass('player');
	mainFrame.level = 60;
	mainFrame.totalUsedPoints = 0;
	mainFrame.totalAvailablePoints = 0;
	mainFrame.data = nil;
	mainFrame.readOnly = false;
	mainFrame.name = nil;

	return mainFrame;
end



function emu.DB_PreProc(_DB)
	for _, DB in pairs(_DB) do
		for _, db in pairs(DB) do
			for dataIndex, data in pairs(db) do
				data[10] = data[1] * 4 + data[2] + 1;
				if data[5] and data[6] then
					for pIndex, p in pairs(db) do
						if p[1] == data[5] and p[2] == data[6] then
							data[11] = pIndex;
							if p[12] then
								table.insert(p[12], dataIndex);
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
end

local function DBIcon_OnClick(self, button)
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
end

function emu.CHAT_MSG_ADDON(self, event, prefix, text, channel, sender, target, zoneChannelID, localID, name, instanceID)
	if prefix == ADDON_PREFIX then
		local control_code = string.sub(text, 1, ADDON_MSG_CONTROL_CODE_LEN);
		if control_code == ADDON_MSG_QUERY then
			local class, data, level = emu.GetPlayerTalentData();
			if class then
				local code = emu.EmuCore_Encoder(class, data, level);
				SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY .. code, "WHISPER", sender);
			end
		elseif control_code == ADDON_MSG_REPLY then
			local code = string.sub(text, ADDON_MSG_CONTROL_CODE_LEN + 1, - 1);
			if code then
				local class, data, level = emu.EmuCore_Decoder(code);
				if class and data and level then
					local n, r =string.split("-", sender);
					if n and r == GetRealmName() then
						sender = n;
					end
					local specializedMainFrame = emu.specializedMainFrameInspect[sender];
					if specializedMainFrame then
						if specializedMainFrame[2]:IsShown() and specializedMainFrame[1] - GetTime() <= setting.INSPECT_WAIT_TIME then
							emu.Emu_Set(specializedMainFrame[2], class, data, level, true, sender);
						else
							emu.Emu_Create(class, data, level, true, sender);
						end
						emu.specializedMainFrameInspect[sender] = nil;
					else
						emu.Emu_Create(class, data, level, true, sender);
					end
				end
			end
		elseif control_code == ADDON_MSG_PULL then
		end
	end
end
local function _EventVehicle_OnEvent(self, event, ...)
	emu.CHAT_MSG_ADDON(self, event, ...);
end

function emu.Init()
	if not emu.initialized then
		if alaTalentEmuSV then
			config = alaTalentEmuSV;
		else
			alaTalentEmuSV = config;
		end
		emu.DB_PreProc(_DB);
		emu.EmuCore_InitCodeTable();

		if LibStub then
			local icon = LibStub("LibDBIcon-1.0", true);
			if icon then
				icon:Register("alaTalentEmu",
				{
					icon = "interface\\buttons\\ui-microbutton-talents-up",
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
		end

		if not RegisterAddonMessagePrefix(ADDON_PREFIX) then
			_log_("Init", "RegisterAddonMessagePrefix", ADDON_PREFIX);
		end
		local _EventVehicle = CreateFrame("Frame", NAME .. "EventVehicle", UIParent);
		NS._EventVehicle = _EventVehicle;
		_EventVehicle:RegisterEvent("CHAT_MSG_ADDON");
		_EventVehicle:RegisterEvent("CHAT_MSG_ADDON_LOGGED");
		_EventVehicle:SetScript("OnEvent", _EventVehicle_OnEvent);

		if config.inspectButtonKey == "CTRL" then
			emu.inspectButtonKeyFunc = IsControlKeyDown;
		elseif config.inspectButtonKey == "SHIFT" then
			emu.inspectButtonKeyFunc = IsShiftKeyDown;
		elseif config.inspectButtonKey == "ALT" then
			emu.inspectButtonKeyFunc = IsAltKeyDown;
		else
			emu.inspectButtonKeyFunc = IsAltKeyDown;
		end
		
		if not IsAddOnLoaded("Blizzard_TalentUI") then
			if LoadAddOn("Blizzard_TalentUI") then
				if TalentFrame then
					local button = CreateFrame("Button", nil, TalentFrame);
					button:SetSize(80, 20);
					button:SetNormalTexture("Interface\\Buttons\\ui-panel-button-up");
					button:SetPushedTexture("Interface\\Buttons\\ui-panel-button-up");
					button:GetNormalTexture():SetTexCoord(1 / 128, 79 / 128, 1 / 32, 22 / 32);
					button:GetPushedTexture():SetTexCoord(1 / 128, 79 / 128, 1 / 32, 22 / 32);
					button:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
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
			end
		end

		emu.initialized = true;
	end
end
C_Timer.After(1.0, emu.Init);



SLASH_ALATALENTEMU1 = "/alaTalentEmu";
SLASH_ALATALENTEMU2 = "/alate";
SLASH_ALATALENTEMU3 = "/ate";
SLASH_ALATALENTEMU4 = "/emu";
local acceptedCommandSeq =
{
	"\ ",
	"\,",
	--"\.",
	"\;",
	"\:",
	"\-",
	"\+",
	"\_",
	"\=",
	"\/",
	"\\",
	"\"",
	"\'",
	"\|",

	"\，",
	"\。",
	"\;",
	"\：",
	"\、",
	"\’",
	"\“",
};
SlashCmdList["ALATALENTEMU"] = function(msg)
	for _, seq in pairs(acceptedCommandSeq) do
		if string.find(msg, seq) then
			emu.Emu_Create(string.split(seq, msg));
			return;
		end
	end
	emu.Emu_Create(msg);
end
--_G["EMUNS"] = NS;

ATEMU = {};
_G["ATEmu"] = ATEMU;
_G["TEMU"] = ATEMU;
_G["TEmu"] = ATEMU;
_G["Emu"] = ATEMU;
_G["EMU"] = ATEMU;
ATEMU.ExportCode = function(winId, ...)
	local mainFrame = nil;
	if winId then
		if type(winId) == "number" then
			mainFrame = emu.winMan_GetWin(winId);
		elseif type(winId) == "table" and winId.id then
			mainFrame = winId;
		end
	end
	print(winId, mainFrame, mainFrame and mainFrame:IsShown())
	if mainFrame and mainFrame:IsShown() then
		return emu.EmuCore_Encoder(mainFrame);
	else
		return emu.EmuCore_Encoder(winId, ...);
	end
end
ATEMU.ImportCode = function(code)
	return emu.Emu_Import(code);
end
ATEMU.Create = function(class, data, level, readOnly, name, style, ...)
	return emu.Emu_Create(class, data, level, readOnly, name, style, ...);
end
ATEMU.Destroy = function(winId)
	if type(winId) == "table" then
		emu.Emu_DestroyMainFrame(winId);
	elseif type(winId) == "number" then
		emu.Emu_Destroy(winId);
	end
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
--/run print(ATEMU.Create("paladin", "2314211111000015112111211000032113211111"))
--/run print(ATEMU.ExportCode(1))
--4Mv8i:8HsJ4gm7R4veBw0
--/run ATEMU.ImportCode("4Mv8i:8HsJ4gm7R4veBw0");
--/run print(ATEMU.ExportCode(2))
--4Mv8i:sdWw7gm7R4JMw0
--/run ATEMU.ImportCode("4Mv8i:sdWw7gm7R4JMw0");
--ATEMU.Query("Destinyless")

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
	unitFrameButton:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	unitFrameButton:GetHighlightTexture():SetTexCoord(0.125, 0.875, 0.125, 0.875);
	unitFrameButton:LockHighlight();
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
	local unitFrameButtonFontString = unitFrameButton:CreateFontString(unitFrameButton:GetName() .. "FontString", "ARTWORK");
	local font, size, outline = PlayerFrame.healthbar.TextString:GetFont();
	unitFrameButtonFontString:SetFont(font, 32, "OUTLINE");
	unitFrameButtonFontString:SetPoint("CENTER");
	unitFrameButtonFontString:SetTextColor(0.0, 1.0, 0.0, 1.0);
	unitFrameButtonFontString:SetText("TE");
	unitFrameButtonFontString:Show();
	unitFrameButton:SetScript("OnUpdate", function(self, elasped)
		if config.inspectButtonOnUnitFrame then
			if (emu.inspectButtonKeyFunc and emu.inspectButtonKeyFunc()) and self.unitFrame:IsShown() then
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

