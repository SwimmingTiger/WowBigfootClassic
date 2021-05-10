
-- Prevent tainting global _.
local _
local _G = _G

--常用函數設為區域變數以提昇效能
local print = print
local pairs = pairs
local ipairs = ipairs
local tonumber = tonumber
local tostring = tostring
local type = type
local select = select
local format = format
local CreateFrame = CreateFrame
local UnitBuff = UnitBuff
local UnitDebuff = UnitDebuff
local UnitAura = UnitAura
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitPowerType = UnitPowerType
local UnitAffectingCombat = UnitAffectingCombat
local UnitLevel = UnitLevel
local UnitClass = UnitClass
local UnitID = UnitID
local UnitSpellHaste = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and function() return 0 end or _G.UnitSpellHaste
local UnitName = UnitName
local UnitIsCorpse = UnitIsCorpse
local UnitIsDeadOrGhost = UnitIsDeadOrGhost
local UnitIsEnemy = UnitIsEnemy
local UnitExists = UnitExists
local GetTime = GetTime
local GetActiveSpecGroup = GetActiveSpecGroup
local GetActiveTalentGroup = GetActiveTalentGroup
local GetShapeshiftForm = GetShapeshiftForm
local GetShapeshiftFormID = GetShapeshiftFormID
local GetSpecialization = WOW_PROJECT_ID == WOW_PROJECT_CLASSIC and function() return nil end or _G.GetSpecialization
local GetSpecializationInfo = GetSpecializationInfo
local GetSpellCharges = GetSpellCharges
local GetSpellCooldown = GetSpellCooldown
local GetSpellInfo = GetSpellInfo
local GetSpellLink = GetSpellLink
local GetSpellTexture = GetSpellTexture
local GetNumSubgroupMembers = GetNumSubgroupMembers
local hooksecurefunc = hooksecurefunc
local IsUsableSpell = IsUsableSpell
local UIFrameFadeIn = UIFrameFadeIn
local UIFrameFadeOut = UIFrameFadeOut
local GameTooltip = GameTooltip

--EA_Config2 改為初始預設值
EA_Config2 = {
	--脫離戰鬥後是否保持技能冷卻框架
	SCD_NocombatStillKeep	= true,
	--當冷卻框架之技能達到可施放條件時高亮
	SCD_GlowWhenUsable		= true ,
	--單一技能冷卻完成即移除(true:要移除/false:不移除)
	SCD_RemoveWhenCooldown	= true,
	--剩餘多少秒開始使用小數點一位顯示(使用0則完全不會有小數點)
	UseFloatSec				= 1,
	--是否顯示獵人寵物集中值(已移除)
	--HUNTER_ShowPetFocus		= true,
	--獵人寵物集中值高亮條件值(0表示不高亮)
	HUNTER_GlowPetFocus 	= 50,
	--滑鼠移到圖示顯示技能說明
	ICON_APPEND_SPELL_TIP =true,
	--是否顯示設置圖標
	OPTION_ICON = false,
	--BUFF/DEBUFF 的Value 值大於等於指定數值才會顯示
	ShowAuraValueWhenOver = 1000,
}

EA_Config = {
	SpecPowerCheck = {
		FocusPet,
		ComboPoint,
		Mana,
		Rage,
		Focus,
		Energy,
		Runes,
		RunicPower,
		Runes,
		SoulShards,
		LunarPower,
		HolyPower,
		DarkForce,
		LightForce,
		Insanity,
		BurningEmbers,
		DemonicFury,
		LifeBloom,
		ArcaneCharges,
		Maelstrom,
		Fury,
		Pain,
	},
	DoAlertSound,
	AlertSound,
	AlertSoundValue,
	LockFrame,
	ShareSettings,
	ShowFrame,
	ShowName,
	ShowFlash,
	ShowTimer,
	TimerFontSize,
	StackFontSize,
	SNameFontSize,
	ChangeTimer,
	Version,
	AllowESC,
	AllowAltAlerts,
	Target_MyDebuff,
}

EA_Position = {
	Anchor,
	relativePoint,
	xLoc,
	yLoc,
	xOffset,
	yOffset,
	RedDebuff,
	GreenDebuff,
	Tar_NewLine,
	TarAnchor,
	TarrelativePoint,
	Tar_xOffset,
	Tar_yOffset,
	ScdAnchor,
	Scd_xOffset,
	Scd_yOffset,
	Execution,
	PlayerLv2BOSS,
	SCD_UseCooldown,
};

EA_Pos = { };
EA_SPELLINFO_SELF = { };
EA_SPELLINFO_TARGET = { };
EA_SPELLINFO_SCD = { };
EA_ClassAltSpellName = { };
GC_IndexOfGroupFrame = { };

local EA_LISTSEC_SELF = 0;
local EA_LISTSEC_TARGET = 0;
local EA_SPEC_expirationTime1 = 0;
local EA_SPEC_expirationTime2 = 0;

local EA_CurrentBuffs = { };
local EA_TarCurrentBuffs = { };
local EA_ScdCurrentBuffs = { };
local EA_ShowScrollSpells = { };
local EA_ShowScrollSpell_YPos = 25;

local EA_SpecFrame_Self = false;
local EA_SpecFrame_Target = false;
local EA_SpecFrame_LifeBloom = { UnitID = "", UnitName = "", ExpireTime = 0, Stack = 0 };

local EA_FormType_FirstTimeCheck = true;

EA_COMBO_POINTS = 0;
EA_playerClass  = nil;
EA_SpecID = nil;
EA_RUNE_TYPE=1;

local RUNETYPE_BLOOD = 1;
local RUNETYPE_UNHOLY = 2;
local RUNETYPE_FROST = 3;
local RUNETYPE_DEATH = 4;

local MAX_RUNES = 6;

local iconTextures = {
	[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Blood",
	[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Unholy",
	[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Frost",
	[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Death",
}

local runeTextures = {
	[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Blood-Off.tga",
	[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Death-Off.tga",
	[RUNETYPE_FROST] = "Interface\\PlayerFrame\\UI-PlayerFrame-DeathKnight-Frost-Off.tga",
	[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\UI-PlayerFrame-Deathknight-Chromatic-Off.tga",
}

local runeEnergizeTextures = {
	[RUNETYPE_BLOOD] = "Interface\\PlayerFrame\\Deathknight-Energize-Blood",
	[RUNETYPE_UNHOLY] = "Interface\\PlayerFrame\\Deathknight-Energize-Unholy",
	[RUNETYPE_FROST] = "Interface\\PlayerFrame\\Deathknight-Energize-Frost",
	[RUNETYPE_DEATH] = "Interface\\PlayerFrame\\Deathknight-Energize-White",
}

local runeColors = {
	[RUNETYPE_BLOOD] = {1, 0, 0},
	[RUNETYPE_UNHOLY] = {0, 0.5, 0},
	[RUNETYPE_FROST] = {0, 1, 1},
	[RUNETYPE_DEATH] = {0.8, 0.1, 1},
}

local runeTypeText = {
	[RUNETYPE_BLOOD] = "血魄",
	[RUNETYPE_UNHOLY] = "穢邪",
	[RUNETYPE_FROST] = "冰霜",
	[RUNETYPE_DEATH] = "死亡",
}

local RUNE_MAPPING = {
	[1] = 1,
	[2] = 2,
	[3] = 5,
	[4] = 6,
	[5] = 3,
	[6] = 4,
}

local function EAFun_GetSpellItemEnable(EAItems)
	local SpellEnable = false;
	if (EAItems ~= nil) then
		if (EAItems.enable) then SpellEnable = true end;
	end
	return SpellEnable;
end

local function EAFun_CheckSpellConditionMatch(EA_count, EA_unitCaster, EAItems)
	local ifAdd_buffCur, orderWtd = true, 1;
	local SC_Stack, SC_Self = 1, false;
	if (EAItems ~= nil) then
		if (EAItems.stack ~= nil) then SC_Stack = EAItems.stack end;
		if (EAItems.self ~= nil) then SC_Self = EAItems.self end;
		if (EAItems.orderwtd ~= nil) then orderWtd = EAItems.orderwtd end;
	end
	if (SC_Stack ~= nil and SC_Stack > 1) then
		if (EA_count < SC_Stack) then ifAdd_buffCur = false end;
	end
	if (SC_Self == true) then
		if (EA_unitCaster ~= "player") then
			ifAdd_buffCur = false
		end
	end

	return ifAdd_buffCur, orderWtd;
end

-- The first event of this UI(Event sequence : "Onload"->"ADDON_LOADED")
function EventAlert_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED");

	SlashCmdList["EVENTALERTMOD"] = EventAlert_SlashHandler;
	SLASH_EVENTALERTMOD1 = "/eventalertmod";
	SLASH_EVENTALERTMOD2 = "/eam";

	EA_SPELLINFO_SELF = { };
	EA_SPELLINFO_TARGET = { };

	EA_CurrentBuffs = { };
	EA_TarCurrentBuffs = { };
end

function EventAlert_GlowShow(self, event, ...)
	local arg1, arg2 = ...;
	EventAlert_COMBAT_TEXT_SPELL_ACTIVE_ById(arg1);
end

function EventAlert_PLAYER_ENTER_COMBAT(self, event, ...)
	ShowAllScdCurrentBuff()
end

function EventAlert_PLAYER_LEAVE_COMBAT(self, event, ...)
	if EA_Config.SCD_NocombatStillKeep == false then
		HideAllScdCurrentBuff()
	end
end

function EventAlert_PLAYER_ENTERING_WORLD(self, event, ...)
	if event == "PLAYER_ENTERING_WORLD" then
		EventAlert_PlayerSpecPower_Update()
		for p,tblPower in pairs(EA_SpecPower) do
			if (tblPower.func) and (EA_Config.SpecPowerCheck[k]) and (tblPower.has) then
				if (tblPower.powerId) then
					tblPower.func(tblPower.powerId)
				else
					tblPower.func()
				end
			end
		end
	end
	local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...;
	local v = table.foreach(EA_CurrentBuffs, function(i, v) if v==arg9 then return v end end)
	if v then
		local f = _G["EAFrame_"..v];
		f:Hide();
		EA_CurrentBuffs = table.wipe(EA_CurrentBuffs);
	end
	EA_ClassAltSpellName = { };
	local name;
	for i,v in pairs(EA_AltItems[EA_playerClass]) do
		name = GetSpellInfo(i);
		if name then
			EA_ClassAltSpellName[name] = tonumber(i);
		end
	end
end

function EventAlert_TARGET_CHANGED(self, event, ...)
	EventAlert_TarChange_ClearFrame();
	if UnitName("player") ~= UnitName("target") then
		EventAlert_TarBuffs_Update();
		if (EA_Config.SpecPowerCheck.ComboPoint and EA_SpecPower.ComboPoint.has) then
			EventAlert_UpdateComboPoint();
		end;
		EventAlert_CheckExecution();
	end
end

function EventAlert_UNIT_SPELLCAST_SUCCEEDED(self,event,...)
	local unitCaster,_,spellID = ...
	local surName = UnitName(unitCaster)
	EventAlert_ScdBuffs_Update(surName, nil, spellID)
end

function EventAlert_COMBAT_LOG_EVENT_UNFILTERED(self, event, ...)
	local timestp, event, hideCaster, surGUID, surName, surFlags, surRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellID, spellName = ...;

	local f = EA_EventList_COMBAT_LOG_EVENT_UNFILTERED[event]
	if type(f)=="function" then f(...) end

	spellID = tonumber(spellID);
	if (dstName ~= nil) then dstName = strsplit("-", dstName, 2) end;

	if ((spellID ~= nil) and (spellID > 0 and spellID < 1000000)) then
		-- "/ea showc" will also display in this function

		if (event == "UNIT_CAST_SUCCESS") then
			EA_IfPrint(EA_DEBUGFLAG601,event,surName,dstName,spellID,spellName)
		end

		EventAlert_ScdBuffs_Update(surName, spellName, spellID, timestp); -- WOW 4.1 Change with spellID


		local iUnitPower = UnitPower("player", 8);
		if (EA_playerClass == EA_CLASS_DRUID and EA_Config.SpecPowerCheck.LifeBloom and EA_SpecPower.LifeBloom.has and iUnitPower == 0) then
			local EA_PlayerName = UnitName("player");

			if (surName == EA_PlayerName and spellID == 33763 and dstName ~= nil) then
				-- print ("tar="..arg8.." /spid="..arg10);
				local EA_UnitID = "";
				if (dstName == EA_PlayerName) then
					EA_UnitID = "player";
				elseif dstName == EA_SpecFrame_LifeBloom.UnitName then
					EA_UnitID = EA_SpecFrame_LifeBloom.UnitID;
				else
					EA_UnitID = EAFun_GetUnitIDByName(dstName);
				end
					EventAlert_UpdateLifeBloom(EA_UnitID);
			end
		end
		if (EA_playerClass == EA_CLASS_DK) then
			EventAlert_UpdateRunes()
		end
	end
end

function EventAlert_COMBAT_LOG_EVENT_SPELL_AURA_REFRESH(...)
	local timestp, event, hideCaster, surGUID, surName, surFlags, surRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellID, spellName = ...;
	EventAlert_ScdBuffs_Update(surName, spellName, spellID,timestp )
end

function EventAlert_COMBAT_LOG_EVENT_SPELL_SUMMON(...)
		local timestp, event, hideCaster, surGUID, surName, surFlags, surRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellID, spellName = ...;
		EventAlert_Buffs_Update(...)

		--若 /eam showc 啟用，則也顯示招喚圖騰型法術ID
		if (EA_DEBUGFLAG3) then
			sSpellLink = GetSpellLink(spellID);
			if (sSpellLink ~= nil) then
					-- DEFAULT_CHAT_FRAME:AddMessage("\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r="..EA_spellID.." / \124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r="..sSpellLink);
					EAFun_AddSpellToScrollFrame(spellID, "");
					print("SUMMON SPELL ID:",spellID,sSpellLink)
			end
		end
end

function EventAlert_UNIT_PLAYER_TOTEM_UPDATE(self,event,totemIndex)
	EventAlert_Buffs_Update()
end

function EventAlert_UNIT_AURA(self, event, ...)
	local arg1 = ...
	if (arg1 == "player") or (arg1=="pet") then
		EventAlert_Buffs_Update(...);
	else
		EventAlert_TarBuffs_Update(...);
	end

	if (EA_FormType_FirstTimeCheck) then
		EventAlert_PlayerSpecPower_Update();
		EA_FormType_FirstTimeCheck = false;
	end
end

--[[
function EventAlert_COMBAT_TEXT_UPDATE(self, event, ...)
	local arg1, arg2 = ...;
	if (arg1 == "SPELL_ACTIVE") then
		EventAlert_COMBAT_TEXT_SPELL_ACTIVE(arg2);		--触发法术(额外技能提示)
	end
end
]]

function EventAlert_UNIT_COMBO_POINTS(self, event, ...)
	if (EA_Config.SpecPowerCheck.ComboPoint and EA_SpecPower.ComboPoint.has) then
		EventAlert_UpdateComboPoint();
	end
end

function EventAlert_UNIT_HEALTH(self, event, ...)
	local arg1 = ...;
	if arg1 == "target" then
		EventAlert_CheckExecution();
	end
end

function EventAlert_PLAYER_TALENT_UPDATE(self, event, ...)
	EventAlert_PlayerSpecPower_Update();
	RemoveAllScdCurrentBuff();
end

function EventAlert_SPELL_UPDATE_COOLDOWN(self, event, ...)
	for i,spellID in ipairs(EA_ScdCurrentBuffs) do
		EventAlert_OnSCDUpdate(spellID)
	end
end

function EventAlert_UNIT_POWER(self,event,...)
	local arg1, arg2 = ...;
	if arg1 == "player" or arg1 == "pet" then
		for p,tblPower in pairs(EA_SpecPower) do
			if (arg2 == tblPower.powerType) then
				if (tblPower.func) and (EA_Config.SpecPowerCheck[p]) and (tblPower.has) then
					if(tblPower.powerId) then
						tblPower.func(tblPower.powerId)
					else
						tblPower.func()
					end
				end
				break;
			end
		end
	end
end

function EventAlert_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local arg1, arg2 = ...;
		if (arg1 == "EventAlertMod") then
			EventAlert_LoadSpellArray();
			_, EA_playerClass = UnitClass("player");

			EventAlert_VersionCheck();

			for k,v in pairs(EA_Config2) do
				if EA_Config[k] == nil then
					EA_Config[k] = EA_Config2[k]
				end
			end

			if EA_Config.EA_SPELL_ITEM == nil then
				EA_Config.EA_SPELL_ITEM = {}
				-- local s
				-- for i = 1,999999 do
					-- s = select(2,GetItemSpell(i))
					-- if s then
						-- EA_Config.EA_SPELL_ITEM[s] = i
					-- end
				-- end
			end

			EA_Config.AlertSound 			=  568154
			EA_Config.AlertSoundValue 		=  EA_Config.AlertSoundValue 	or 1
			EA_Config.IconSize 				=  EA_Config.IconSize 			or 40
			if EA_Config.DoAlertSound == nil then EA_Config.DoAlertSound = true end;
			if EA_Config.LockFrame == nil then EA_Config.LockFrame = false end;
			if EA_Config.ShareSettings == nil then EA_Config.ShareSettings = true end;
			if EA_Config.ShowFrame == nil then EA_Config.ShowFrame = true end;
			if EA_Config.ShowName == nil then EA_Config.ShowName = true end;
			if EA_Config.ShowFlash == nil then EA_Config.ShowFlash = false end;
			if EA_Config.ShowTimer == nil then EA_Config.ShowTimer = true end;
			if EA_Config.ChangeTimer == nil then EA_Config.ChangeTimer = false end;
			if EA_Config.AllowESC == nil then EA_Config.AllowESC = false end;
			if EA_Config.AllowAltAlerts == nil then EA_Config.AllowAltAlerts = true end;
			if EA_Config.Target_MyDebuff == nil then EA_Config.Target_MyDebuff = true end;

			if (EA_Config.ChangeTimer == true) then								--若計時顯示在框架內
				-- 若使用了小數點倒數
				if (EA_Config.UseFloatSec > 0) then
					EA_Config.TimerFontSize = (EA_Config.IconSize ) * 0.4		--框架內倒數大小比例(有小數點)
				else
					EA_Config.TimerFontSize = (EA_Config.IconSize ) * 0.5		--框架內倒數大小比例(無小數點)
				end
				EA_Config.StackFontSize = (EA_Config.IconSize ) * 0.3			--堆疊計數大小比例
			else
				EA_Config.TimerFontSize = (EA_Config.IconSize ) * 0.65			--框架外倒數大小比例
				EA_Config.StackFontSize = (EA_Config.IconSize ) * 0.45			--堆疊計數大小比例
			end

			EA_Config.SNameFontSize = EA_Config.IconSize * 0.3					--名稱大小比例

			if EA_Position.Anchor == nil then EA_Position.Anchor = "CENTER" end;
			if EA_Position.relativePoint == nil then EA_Position.relativePoint = "CENTER" end;
			if EA_Position.xLoc == nil then EA_Position.xLoc = 150 end;
			if EA_Position.yLoc == nil then EA_Position.yLoc = -140 end;
			if EA_Position.xOffset == nil then EA_Position.xOffset = -50 end;
			if EA_Position.yOffset == nil then EA_Position.yOffset = 0 end;
			if EA_Position.RedDebuff == nil then EA_Position.RedDebuff = 0.5 end;
			if EA_Position.GreenDebuff == nil then EA_Position.GreenDebuff = 0.5 end;
			if EA_Position.Tar_NewLine == nil then EA_Position.Tar_NewLine = true end;
			if EA_Position.TarAnchor == nil then EA_Position.TarAnchor = "BOTTOM" end;
			if EA_Position.TarrelativePoint == nil then EA_Position.TarrelativePoint = "BOTTOM" end;
			if EA_Position.Tar_xOffset == nil then EA_Position.Tar_xOffset = 150 end;
			if EA_Position.Tar_yOffset == nil then EA_Position.Tar_yOffset = 180 end;
			if EA_Position.ScdAnchor == nil then EA_Position.ScdAnchor = "CENTER" end;
			if EA_Position.Scd_xOffset == nil then EA_Position.Scd_xOffset = 80 end;
			if EA_Position.Scd_yOffset == nil then EA_Position.Scd_yOffset = -65 end;
			if EA_Position.Execution == nil then EA_Position.Execution = 0 end;
			if EA_Position.PlayerLv2BOSS == nil then EA_Position.PlayerLv2BOSS = false end;
			if EA_Position.SCD_UseCooldown == nil then EA_Position.SCD_UseCooldown = false end;

			if EA_Pos == nil then EA_Pos = { } end;
			if EA_Pos[EA_CLASS_DK] == nil then EA_Pos[EA_CLASS_DK] = EA_Position end;
			if EA_Pos[EA_CLASS_DRUID] == nil then EA_Pos[EA_CLASS_DRUID] = EA_Position end;
			if EA_Pos[EA_CLASS_HUNTER] == nil then EA_Pos[EA_CLASS_HUNTER] = EA_Position end;
			if EA_Pos[EA_CLASS_MAGE] == nil then EA_Pos[EA_CLASS_MAGE] = EA_Position end;
			if EA_Pos[EA_CLASS_PALADIN] == nil then EA_Pos[EA_CLASS_PALADIN] = EA_Position end;
			if EA_Pos[EA_CLASS_PRIEST] == nil then EA_Pos[EA_CLASS_PRIEST] = EA_Position end;
			if EA_Pos[EA_CLASS_ROGUE] == nil then EA_Pos[EA_CLASS_ROGUE] = EA_Position end;
			if EA_Pos[EA_CLASS_SHAMAN] == nil then EA_Pos[EA_CLASS_SHAMAN] = EA_Position end;
			if EA_Pos[EA_CLASS_WARLOCK] == nil then EA_Pos[EA_CLASS_WARLOCK] = EA_Position end;
			if EA_Pos[EA_CLASS_WARRIOR] == nil then EA_Pos[EA_CLASS_WARRIOR] = EA_Position end;
			if EA_Pos[EA_CLASS_MONK] == nil then EA_Pos[EA_CLASS_MONK] = EA_Position end;
			if EA_Pos[EA_CLASS_DEMONHUNTER] == nil then EA_Pos[EA_CLASS_DEMONHUNTER] = EA_Position end;

			if (EA_Config.ShareSettings ~= true) then
				EA_Position = EA_Pos[EA_playerClass];
				if EA_Position.Tar_NewLine == nil then EA_Position.Tar_NewLine = true end;
				if EA_Position.Execution == nil then EA_Position.Execution = 0 end;
			end

			if EA_Config.SpecPowerCheck == nil then EA_Config.SpecPowerCheck = {} end
			for k,v in pairs(EA_SpecPower) do
				if EA_Config.SpecPowerCheck[k] == nil then EA_Config.SpecPowerCheck[k] = false end
			end

			EventAlert_Options_Init();
			EventAlert_Icon_Options_Frame_Init();
			EventAlert_CreateFrames();

			EAFun_HookTooltips();

			self:UnregisterEvent("ADDON_LOADED");
		end
		return;
	end

	local func = EA_EventList[event]
	if type(func) == "function" then
		if event:match("COMBAT_LOG_EVENT") then
			func(self,event,CombatLogGetCurrentEventInfo())
		else
			func(self,event,...)
		end
	end
end

local function EAFun_CheckSpellConditionOverGrow(EA_count, EAItems)
	local isOverGrow = false;
	local SC_OverGrow = 0;
	if (EAItems ~= nil) then
		if (EAItems.overgrow ~= nil) then SC_OverGrow = EAItems.overgrow end;
	end
	if (EA_count <= 0) then EA_count = 1 end;
	if (SC_OverGrow ~= nil and SC_OverGrow > 0) then
		if (SC_OverGrow <= EA_count) then isOverGrow = true end;
	end
	return isOverGrow;
end

local function EAFun_GetSpellConditionRedSecText(EAItems)
	local SC_RedSecText = -1;
	if (EAItems ~= nil) then
		if (EAItems.redsectext ~= nil) then SC_RedSecText = EAItems.redsectext end;
		if (SC_RedSecText < 1) then SC_RedSecText = -1 end;
	end
	return SC_RedSecText;
end

function EventAlert_Buffs_Update(...)
	local buffsCurrent = {};
	local buffsToDelete = {};
	local SpellEnable, OtherEnable = false, false;
	local ifAdd_buffCur = false;
	local orderWtd = 1;
	-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buffs_Update");
	-- if (EA_DEBUGFLAG1) then
	--  DEFAULT_CHAT_FRAME:AddMessage("----"..EA_XCMD_SELFLIST.."----");
	-- end

	if (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
		CreateFrames_EventsFrame_ClearSpellList(3);
	end

	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3

	for i=1,40 do
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura("player", i, "HELPFUL")

		if (not spellID) then break end
		if isCastByPlayer then unitCaster = "player" end

		if (spellID == 71601) then EA_SPEC_expirationTime1 = expirationTime end;
		if (spellID == 71644) then EA_SPEC_expirationTime2 = expirationTime end;

		if (EA_DEBUGFLAG1) then
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				EAFun_AddSpellToScrollFrame(spellID, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellID..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false;
		SpellEnable = EAFun_GetSpellItemEnable(EA_Items[EA_playerClass][spellID]);
		OtherEnable = EAFun_GetSpellItemEnable(EA_Items[EA_CLASS_OTHER][spellID]);
		if (SpellEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_playerClass][spellID]);
		elseif (OtherEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_CLASS_OTHER][spellID]);
		elseif (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
			-- ifAdd_buffCur = true;
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				-- DEFAULT_CHAT_FRAME:AddMessage("spellID="..spellID.." /unitCaster="..unitCaster);
				if EA_DEBUGFLAG11 or (EA_DEBUGFLAG21 and (not (UnitInRaid(unitCaster) or UnitInParty(unitCaster)))) then
					if EA_Items[EA_CLASS_OTHER][spellID] == nil then EA_Items[EA_CLASS_OTHER][spellID] = {enable=true,} end;
					CreateFrames_CreateSpellFrame(spellID, 1);
					ifAdd_buffCur = true;
				end
			end
		end

		if (ifAdd_buffCur) then
			-- if EA_SPELLINFO_SELF[spellID] == nil then EA_SPELLINFO_SELF[spellID] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
			-- EA_SPELLINFO_SELF[spellID].name = name;
			-- EA_SPELLINFO_SELF[spellID].rank = rank;
			EA_SPELLINFO_SELF[spellID].icon = icon;
			EA_SPELLINFO_SELF[spellID].count = count;
			EA_SPELLINFO_SELF[spellID].duration = duration;
			EA_SPELLINFO_SELF[spellID].expirationTime = expirationTime;
			EA_SPELLINFO_SELF[spellID].unitCaster = unitCaster;
			EA_SPELLINFO_SELF[spellID].isDebuff = false;
			EA_SPELLINFO_SELF[spellID].orderWtd = orderWtd;
			EA_SPELLINFO_SELF[spellID].value = {value1, value2, value3}
			--EA_SPELLINFO_SELF[spellID].value1 = value1;
			--EA_SPELLINFO_SELF[spellID].value2 = value2;
			--EA_SPELLINFO_SELF[spellID].value3 = value3;
			table.insert(buffsCurrent, spellID);
		end
	end

	for i=1,40 do
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura("pet", i, "HELPFUL")

		if (not spellID) then break end
		if isCastByPlayer then unitCaster = "player" end

		-- if (spellID == 71601) then EA_SPEC_expirationTime1 = expirationTime end;
		-- if (spellID == 71644) then EA_SPEC_expirationTime2 = expirationTime end;

		if (EA_DEBUGFLAG1) then
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				EAFun_AddSpellToScrollFrame(spellID, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellID..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false;
		SpellEnable = EAFun_GetSpellItemEnable(EA_Items[EA_playerClass][spellID]);
		OtherEnable = EAFun_GetSpellItemEnable(EA_Items[EA_CLASS_OTHER][spellID]);

		if (SpellEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_playerClass][spellID]);
		elseif (OtherEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_CLASS_OTHER][spellID]);
		elseif (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
			-- ifAdd_buffCur = true;
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				-- DEFAULT_CHAT_FRAME:AddMessage("spellID="..spellID.." /unitCaster="..unitCaster);
				if EA_DEBUGFLAG11 or (EA_DEBUGFLAG21 and (not (UnitInRaid(unitCaster) or UnitInParty(unitCaster)))) then
					if EA_Items[EA_CLASS_OTHER][spellID] == nil then EA_Items[EA_CLASS_OTHER][spellID] = {enable=true,} end;
					CreateFrames_CreateSpellFrame(spellID, 1);
					ifAdd_buffCur = true;
				end
			end
		end

		if (ifAdd_buffCur) then
			-- if EA_SPELLINFO_SELF[spellID] == nil then EA_SPELLINFO_SELF[spellID] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
			-- EA_SPELLINFO_SELF[spellID].name = name;
			-- EA_SPELLINFO_SELF[spellID].rank = rank;
			EA_SPELLINFO_SELF[spellID].icon = icon;
			EA_SPELLINFO_SELF[spellID].count = count;
			EA_SPELLINFO_SELF[spellID].duration = duration;
			EA_SPELLINFO_SELF[spellID].expirationTime = expirationTime;
			EA_SPELLINFO_SELF[spellID].unitCaster = unitCaster;
			EA_SPELLINFO_SELF[spellID].isDebuff = false;
			EA_SPELLINFO_SELF[spellID].orderWtd = orderWtd;
			EA_SPELLINFO_SELF[spellID].value = {value1, value2, value3}
			--EA_SPELLINFO_SELF[spellID].value1 = value1;
			--EA_SPELLINFO_SELF[spellID].value2 = value2;
			--EA_SPELLINFO_SELF[spellID].value3 = value3;
			table.insert(buffsCurrent, spellID);
		end
	end

	for i=41,80 do
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura("player", i-40, "HARMFUL")

		if (not spellID) then break end
		if isCastByPlayer then unitCaster = "player" end

		if (EA_DEBUGFLAG1) then
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				EAFun_AddSpellToScrollFrame(spellID, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellID..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false
		--spellID = tostring(spellID)
		SpellEnable = EAFun_GetSpellItemEnable(EA_Items[EA_playerClass][spellID]);
		OtherEnable = EAFun_GetSpellItemEnable(EA_Items[EA_CLASS_OTHER][spellID]);
		if (SpellEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_playerClass][spellID]);
		elseif (OtherEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_CLASS_OTHER][spellID]);
		elseif (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
			-- ifAdd_buffCur = true;
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				-- DEFAULT_CHAT_FRAME:AddMessage("spellID="..spellID.." /unitCaster="..unitCaster);
				if EA_DEBUGFLAG11 or (EA_DEBUGFLAG21 and (not (UnitInRaid(unitCaster) or UnitInParty(unitCaster)))) then
					if EA_Items[EA_CLASS_OTHER][spellID] == nil then EA_Items[EA_CLASS_OTHER][spellID] = {enable=true,} end;
					CreateFrames_CreateSpellFrame(spellID, 1);
					ifAdd_buffCur = true;
				end
			end
		end

		if (ifAdd_buffCur) then
			-- if EA_SPELLINFO_SELF[spellID] == nil then EA_SPELLINFO_SELF[spellID] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
			EA_SPELLINFO_SELF[spellID].name = name;
			EA_SPELLINFO_SELF[spellID].rank = rank;
			EA_SPELLINFO_SELF[spellID].icon = icon;
			EA_SPELLINFO_SELF[spellID].count = count;
			EA_SPELLINFO_SELF[spellID].duration = duration;
			EA_SPELLINFO_SELF[spellID].expirationTime = expirationTime;
			EA_SPELLINFO_SELF[spellID].unitCaster = unitCaster;
			EA_SPELLINFO_SELF[spellID].isDebuff = true;
			EA_SPELLINFO_SELF[spellID].orderWtd = orderWtd;
			EA_SPELLINFO_SELF[spellID].value = {value1,value2,value3}
			--EA_SPELLINFO_SELF[spellID].value1 = value1;
			--EA_SPELLINFO_SELF[spellID].value2 = value2;
			--EA_SPELLINFO_SELF[spellID].value3 = value3;
			table.insert(buffsCurrent, spellID);
		end
	end

	for i=41,80 do
		local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura("pet", i-40, "HARMFUL")

		if (not spellID) then break end
		if isCastByPlayer then unitCaster = "player" end

		if (EA_DEBUGFLAG1) then
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				EAFun_AddSpellToScrollFrame(spellID, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellID..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false
		SpellEnable = EAFun_GetSpellItemEnable(EA_Items[EA_playerClass][spellID]);
		OtherEnable = EAFun_GetSpellItemEnable(EA_Items[EA_CLASS_OTHER][spellID]);
		if (SpellEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_playerClass][spellID]);
		elseif (OtherEnable) then
			-- ifAdd_buffCur = true;
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_CLASS_OTHER][spellID]);
		elseif (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
			-- ifAdd_buffCur = true;
			if (EA_LISTSEC_SELF == 0 or (0 < duration and duration <= EA_LISTSEC_SELF)) then
				-- DEFAULT_CHAT_FRAME:AddMessage("spellID="..spellID.." /unitCaster="..unitCaster);
				if EA_DEBUGFLAG11 or (EA_DEBUGFLAG21 and (not (UnitInRaid(unitCaster) or UnitInParty(unitCaster)))) then
					if EA_Items[EA_CLASS_OTHER][spellID] == nil then EA_Items[EA_CLASS_OTHER][spellID] = {enable=true,} end;
					CreateFrames_CreateSpellFrame(spellID, 1);
					ifAdd_buffCur = true;
				end
			end
		end

		if (ifAdd_buffCur) then
			-- if EA_SPELLINFO_SELF[spellID] == nil then EA_SPELLINFO_SELF[spellID] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
			EA_SPELLINFO_SELF[spellID].name = name;
			EA_SPELLINFO_SELF[spellID].rank = rank;
			EA_SPELLINFO_SELF[spellID].icon = icon;
			EA_SPELLINFO_SELF[spellID].count = count;
			EA_SPELLINFO_SELF[spellID].duration = duration;
			EA_SPELLINFO_SELF[spellID].expirationTime = expirationTime;
			EA_SPELLINFO_SELF[spellID].unitCaster = unitCaster;
			EA_SPELLINFO_SELF[spellID].isDebuff = true;
			EA_SPELLINFO_SELF[spellID].orderWtd = orderWtd;
			EA_SPELLINFO_SELF[spellID].value = {value1, value2, value3}
			--EA_SPELLINFO_SELF[spellID].value1 = value1;
			--EA_SPELLINFO_SELF[spellID].value2 = value2;
			--EA_SPELLINFO_SELF[spellID].value3 = value3;
			table.insert(buffsCurrent, spellID);
		end
	end

	--針對圖騰類法術進行偵測（如力之符文、屈心魔、邪DK華爾琪）
	local timestp, event, hideCaster, surGUID, surName, surFlags, surRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellID, spellName = ...

	local count = 1
	local unitCaster = "player"

	for t=1,4 do
		local haveTotem,TotemName, TotemStart, TotemDuration, TotemIcon = GetTotemInfo(t)
		ifAdd_buffCur = false
		SpellEnable = EAFun_GetSpellItemEnable(EA_Items[EA_playerClass][spellID]);

		if (SpellEnable) then
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_playerClass][spellID]);
		end

		if (ifAdd_buffCur) then
			if haveTotem then
				if event == "SPELL_SUMMON" then
					EA_SPELLINFO_SELF[spellID].name = spellName
					EA_SPELLINFO_SELF[spellID].icon = TotemIcon;
					EA_SPELLINFO_SELF[spellID].count = count;
					EA_SPELLINFO_SELF[spellID].duration = TotemDuration;
					EA_SPELLINFO_SELF[spellID].expirationTime = TotemStart + TotemDuration;
					EA_SPELLINFO_SELF[spellID].unitCaster = unitCaster;
					EA_SPELLINFO_SELF[spellID].isDebuff = false;
					EA_SPELLINFO_SELF[spellID].orderWtd = orderWtd;
					EA_SPELLINFO_SELF[spellID].totem = t
				end

				table.insert(buffsCurrent, spellID);
			end
		end
	end

	for i,s in pairs(EA_CurrentBuffs) do
		if EA_SPELLINFO_SELF[s] then
			local t = EA_SPELLINFO_SELF[s].totem
			if t and t > 0 then
				local haveTotem,TotemName, TotemStart, TotemDuration, TotemIcon = GetTotemInfo(t)
				if haveTotem and GetTime() < EA_SPELLINFO_SELF[s].expirationTime then
					table.insert(buffsCurrent, s)
				else
					EA_SPELLINFO_SELF[s].totem = nil
					table.insert(buffsToDelete, s)
				end
			end
		end
	end

	-- Check: Buff dropped
	local v = table.foreach(EA_CurrentBuffs,
		function(i, v1)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-check: "..i.." id: "..v1);
			SpellEnable = false;
			SpellEnable = EAFun_GetSpellItemEnable(EA_AltItems[EA_playerClass][v1]);

			if (not SpellEnable) then
				local v3 = table.foreach(buffsCurrent,
					function(k, v2)
						if (v1==v2) then
							return v2
						end
					end
				)

				if(not v3) then
					-- Buff dropped
					table.insert(buffsToDelete, v1)
				end
			end
		end
	)

	-- Drop Buffs
	table.foreach(buffsToDelete,
		function(i, v)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropped: id: "..v);
			EventAlert_Buff_Dropped(v);
		end
	)

	-- Check: Buff applied
	local v1 = table.foreach(buffsCurrent,
		function(i, v1)
			local v2 = table.foreach(EA_CurrentBuffs,
				function(k, v2)
					if (v1==v2) then
						return v2;
					end
				end
			)
			if(not v2) then
				-- Buff applied
				EventAlert_Buff_Applied(v1);
			end
		end
	)

	EventAlert_PositionFrames();

	if (EA_DEBUGFLAG11 or EA_DEBUGFLAG21) then
		CreateFrames_EventsFrame_RefreshSpellList(3);
	end
end

function EventAlert_TarBuffs_Update(...)
	local arg1=...
	local buffsCurrent = {};
	local buffsToDelete = {};
	local SpellEnable = false;
	local ifAdd_buffCur = false;
	local orderWtd = 1;
	local name, rank, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3
	for i=1,40 do
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura("target", i, "HARMFUL")

		if (not spellID) then break end

		if (EA_DEBUGFLAG2) then
			if (EA_LISTSEC_TARGET == 0 or (0 < duration and duration <= EA_LISTSEC_TARGET)) then
				EAFun_AddSpellToScrollFrame(spellID, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellID..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false;
		SpellEnable = EAFun_GetSpellItemEnable(EA_TarItems[EA_playerClass][spellID]);
		OtherEnable = EAFun_GetSpellItemEnable(EA_Items[EA_CLASS_OTHER][spellID]);
		if (SpellEnable) then
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_TarItems[EA_playerClass][spellID]);
		elseif (OtherEnable) then
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_CLASS_OTHER][spellID]);
		end
		if (ifAdd_buffCur) then
			if EA_SPELLINFO_TARGET[spellID] == nil then EA_SPELLINFO_TARGET[spellID] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;

			EA_SPELLINFO_TARGET[spellID].name = name;
			EA_SPELLINFO_TARGET[spellID].rank = rank;
			EA_SPELLINFO_TARGET[spellID].icon = icon;
			EA_SPELLINFO_TARGET[spellID].count = count;
			EA_SPELLINFO_TARGET[spellID].duration = duration;
			EA_SPELLINFO_TARGET[spellID].expirationTime = expirationTime;
			EA_SPELLINFO_TARGET[spellID].unitCaster = unitCaster;
			EA_SPELLINFO_TARGET[spellID].isDebuff = true;
			EA_SPELLINFO_TARGET[spellID].orderWtd = orderWtd;
			EA_SPELLINFO_TARGET[spellID].value = {value1,value2,value3}
			--EA_SPELLINFO_TARGET[spellID].value1 = value1;
			--EA_SPELLINFO_TARGET[spellID].value2 = value2;
			--EA_SPELLINFO_TARGET[spellID].value3 = value3;
			table.insert(buffsCurrent, spellID);
		end
	end

	for i=41,80 do
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, isCastByPlayer, nameplateShowAll, timeMod, value1, value2, value3 = UnitAura("target", i-40, "HELPFUL")

		if (not spellID) then break end

		if (EA_DEBUGFLAG2) then
			if (EA_LISTSEC_TARGET == 0 or (0 < duration and duration <= EA_LISTSEC_TARGET)) then
				EAFun_AddSpellToScrollFrame(spellID, " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
					" /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
				-- DEFAULT_CHAT_FRAME:AddMessage("["..i.."]\124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r:"..name..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r:"..spellID..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P3.."\124r:"..count..
				--  " /\124cffFFFF00"..EA_XCMD_DEBUG_P4.."\124r:"..duration);
			end
		end

		ifAdd_buffCur = false;
		SpellEnable = EAFun_GetSpellItemEnable(EA_TarItems[EA_playerClass][spellID]);
		OtherEnable = EAFun_GetSpellItemEnable(EA_Items[EA_CLASS_OTHER][spellID]);
		if (SpellEnable) then
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_TarItems[EA_playerClass][spellID]);
		elseif (OtherEnable) then
			ifAdd_buffCur, orderWtd = EAFun_CheckSpellConditionMatch(count, unitCaster, EA_Items[EA_CLASS_OTHER][spellID]);
		end
		if (ifAdd_buffCur) then
			if EA_SPELLINFO_TARGET[spellID] == nil then EA_SPELLINFO_TARGET[spellID] = {name, rank, icon, count, duration, expirationTime, unitCaster, isDebuff} end;
			EA_SPELLINFO_TARGET[spellID].name = name;
			EA_SPELLINFO_TARGET[spellID].rank = rank;
			EA_SPELLINFO_TARGET[spellID].icon = icon;
			EA_SPELLINFO_TARGET[spellID].count = count;
			EA_SPELLINFO_TARGET[spellID].duration = duration;
			EA_SPELLINFO_TARGET[spellID].expirationTime = expirationTime;
			EA_SPELLINFO_TARGET[spellID].unitCaster = unitCaster;
			EA_SPELLINFO_TARGET[spellID].isDebuff = false;
			EA_SPELLINFO_TARGET[spellID].orderWtd = orderWtd;
			EA_SPELLINFO_TARGET[spellID].value = {value1,value2,value3}
			--EA_SPELLINFO_TARGET[spellID].value1 = value1;
			--EA_SPELLINFO_TARGET[spellID].value2 = value2;
			--EA_SPELLINFO_TARGET[spellID].value3 = value3;
			table.insert(buffsCurrent, spellID);
		end
	end

	-- Check: Buff dropped
	local v1 = table.foreach(EA_TarCurrentBuffs,
		function(i, v1)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-check: "..i.." id: "..v1);
			local v2 = table.foreach(buffsCurrent,
				function(k, v2)
					-- DEFAULT_CHAT_FRAME:AddMessage("=== buff-check: "..i.." /v2 id: "..v1);
					if (v1==v2) then
						return v2;
					end
				end
			)
			if(not v2) then
				-- Buff dropped
				-- DEFAULT_CHAT_FRAME:AddMessage("=== add to Delete /v1 id: "..v1);
				table.insert(buffsToDelete, v1);
			end
		end
	)

	-- Drop Buffs
	table.foreach(buffsToDelete,
		function(i, v)
			-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropped: id: "..v);
			EventAlert_TarBuff_Dropped(v);
		end
	)

	-- Check: Buff applied
	local v1 = table.foreach(buffsCurrent,
		function(i, v1)
			local v2 = table.foreach(EA_TarCurrentBuffs,
				function(k, v2)
					if (v1==v2) then
					return v2;
					end
				end
			)
			if(not v2) then
				-- Buff applied
				-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buff_Applied("..v1..")");
				EventAlert_TarBuff_Applied(v1);
			end
		end
	)
	EventAlert_TarPositionFrames();
end

function EventAlert_TarChange_ClearFrame()
	local ibuff = #EA_TarCurrentBuffs;
	for i=1,ibuff do
		EventAlert_TarBuff_Dropped(EA_TarCurrentBuffs[1]);
	end
end

function EventAlert_ScdBuffs_Update(EA_Unit, EA_SpellName, EA_spellID,EA_timestp)
	local spellID = tonumber(EA_spellID);
	local sSpellLink = "";
	local SpellEnable = false;

	if ((EA_Unit == UnitName("player") or (EA_Unit == UnitName("pet"))) and (spellID ~= 0)) then
		if (EA_DEBUGFLAG3) then
			sSpellLink = GetSpellLink(EA_spellID);
			if (sSpellLink ~= nil) then
				EAFun_AddSpellToScrollFrame(EA_spellID, "");
			end
		end

		local SpellEnable = EAFun_GetSpellItemEnable(EA_ScdItems[EA_playerClass][spellID]);
		if (SpellEnable) then
			local strspellID = tostring(spellID);
			local eaf = _G["EAScdFrame_"..strspellID];
			insertBuffValue(EA_ScdCurrentBuffs, spellID);
			local EA_start,EA_duration,EA_Enable = GetSpellCooldown(spellID)

			local s, d = EA_SPELLINFO_SCD[spellID].start,EA_SPELLINFO_SCD[spellID].duration
			local t = GetTime()
			if EA_start == 0 then
				if s == nil or s == 0 then
					EA_SPELLINFO_SCD[spellID].start = t
				else
					if d and (d>0) then
						if format("%d",s+d) <= format("%d",t) then
							EA_SPELLINFO_SCD[spellID].start = t
						end
					end
				end
			end

			if eaf ~= nil then
				eaf:Hide();
				if not eaf:IsVisible() then
					local gsiIcon = EA_SPELLINFO_SCD[spellID].icon;
					--for 7.0
					if not eaf.texture then eaf.texture = eaf:CreateTexture() end
					eaf.texture:SetAllPoints(eaf)
					eaf.texture:SetTexture(gsiIcon)
					--eaf:SetBackdrop({bgFile = gsiIcon});

					eaf:SetWidth(EA_Config.IconSize);
					eaf:SetHeight(EA_Config.IconSize);
					eaf:SetAlpha(1);
					eaf:SetScript("OnUpdate", function()
						EventAlert_OnSCDUpdate(spellID);
					end);
				end
				EventAlert_ScdPositionFrames();
			end
		end
	end
end

function EventAlert_Buff_Dropped(spellID)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropping: id: "..spellID);
	local eaf = _G["EAFrame_"..spellID];
	if eaf~= nil then
		FrameGlowShowOrHide(eaf,false)
		eaf:Hide();
		eaf:SetScript("OnUpdate", nil);
	end
	removeBuffValue(EA_CurrentBuffs, spellID);
	-- EventAlert_PositionFrames();		--bf@178.com
end

function EventAlert_Buff_Applied(spellID)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-applying: id: "..spellID);
	table.insert(EA_CurrentBuffs, spellID);
	-- EventAlert_PositionFrames();		--bf@178.com
	EventAlert_DoAlert();
end

function EventAlert_TarBuff_Dropped(spellID)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-dropping: id: "..spellID);
	local eaf = _G["EATarFrame_"..spellID];
	if eaf~= nil then
		FrameGlowShowOrHide(eaf,false)
		eaf:Hide();
		eaf:SetScript("OnUpdate", nil);
	end
	removeBuffValue(EA_TarCurrentBuffs, spellID);
	EventAlert_TarPositionFrames();
end

function EventAlert_TarBuff_Applied(spellID)
	-- DEFAULT_CHAT_FRAME:AddMessage("buff-applying: id: "..spellID);
	table.insert(EA_TarCurrentBuffs, spellID);
	EventAlert_TarPositionFrames();
end

function EventAlert_SPELL_UPDATE_USABLE()
	local SpellEnable = false;
	if (EA_Config.AllowAltAlerts==true) then
		-- DEFAULT_CHAT_FRAME:AddMessage("spell-active: "..spellName);
		-- searching for the spell-id, because we only get the name of the spell
		for s,v in pairs(EA_AltItems[EA_playerClass]) do
			spellID = tonumber(s);
			SpellEnable = v.enable
			local v2 = table.foreach(EA_CurrentBuffs,
				function(i2, v2)
					if v2==spellID then
						return v2
					end
				end)
			flag_usable,flag_nomana = IsUsableSpell(spellID)
			if (SpellEnable and flag_usable) then
				if (not v2) then
					-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buff_Applied("..spellID..")");
					EventAlert_Buff_Applied(spellID);
					EventAlert_PositionFrames();
				end
			else
				if (v2) then
					EventAlert_Buff_Dropped(spellID)
					EventAlert_PositionFrames();
				end
			end
		end
	end
end
--[[
function EventAlert_COMBAT_TEXT_SPELL_ACTIVE(spellName)
	local SpellEnable = false;
	if (EA_Config.AllowAltAlerts==true) then
		-- DEFAULT_CHAT_FRAME:AddMessage("spell-active: "..spellName);
		-- searching for the spell-id, because we only get the name of the spell
		local spellID = table.foreach(EA_ClassAltSpellName,
		function(i, spellID)
			-- DEFAULT_CHAT_FRAME:AddMessage("EA_ClassAltSpellName("..spellID..")");
			if i==spellName then
				return spellID
			end
		end)

		if spellID then
			spellID = tonumber(spellID);
			SpellEnable = EAFun_GetSpellItemEnable(EA_AltItems[EA_playerClass][spellID]);
			if (SpellEnable) then
				local v2 = table.foreach(EA_CurrentBuffs,
				function(i2, v2)
					if v2==spellID then
						return v2
					end
				end)

				if (not v2) then
					-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buff_Applied("..spellID..")");
					EventAlert_Buff_Applied(spellID);
					EventAlert_PositionFrames();
				end
			end
		end
	end
end
]]--
function EventAlert_COMBAT_TEXT_SPELL_ACTIVE_ById(spellID)
	local SpellEnable = false;
	if (EA_Config.AllowAltAlerts==true) then
		if spellID then
			spellID = tonumber(spellID);
			SpellEnable = EAFun_GetSpellItemEnable(EA_AltItems[EA_playerClass][spellID]);
			if (SpellEnable) then
				local v2 = table.foreach(EA_CurrentBuffs,
				function(i2, v2)
					if v2==spellID then
						return v2
					end
				end)

				if (not v2) then
					-- DEFAULT_CHAT_FRAME:AddMessage("EventAlert_Buff_Applied("..spellID..")");
					EventAlert_Buff_Applied(spellID);
					EventAlert_PositionFrames();
				end
			end
		end
	end
end

function EventAlert_OnUpdate(spellID)
	if #EA_CurrentBuffs ~= 0 then
		local timerFontSize = 0;
		local SC_RedSecText, isOverGrow = -1, false;

		local v = tostring(spellID);
		local eaf = _G["EAFrame_"..v];
		spellID = tonumber(v);
		local name = EA_SPELLINFO_SELF[spellID].name;
		local rank = EA_SPELLINFO_SELF[spellID].rank;

		if (EA_Config.AllowAltAlerts == true) then
			for s,v in pairs(EA_AltItems[EA_playerClass]) do
				local SpellEnable = v.enable
				if (s==spellID and SpellEnable) then
					local EA_usable, EA_nomana = IsUsableSpell(s);
					if EA_usable then
						EA_SPELLINFO_SELF[s].count = 0;
						EA_SPELLINFO_SELF[s].expirationTime = 0;
						EA_SPELLINFO_SELF[s].isDebuff = false;
						EventAlert_PositionFrames();
					else
						EventAlert_Buff_Dropped(s);
						EventAlert_PositionFrames();
						return;
					end
				end
			end
		end

		if eaf ~= nil then
			-- eaf:SetCooldown(0, 1);
			if (EA_Config.ShowTimer) then
				local EA_Name = EA_SPELLINFO_SELF[spellID].name;
				local EA_count = EA_SPELLINFO_SELF[spellID].count;
				local EA_expirationTime = EA_SPELLINFO_SELF[spellID].expirationTime;
				local IfIsDebuff = EA_SPELLINFO_SELF[spellID].isDebuff;
				local EA_currentTime = 0;
				local EA_timeLeft = 0;

				-- eaf:SetCooldown(EA_start, EA_duration);
				if (EA_expirationTime ~= nil) then
					EA_currentTime = GetTime();
					EA_timeLeft = 0 + EA_expirationTime - EA_currentTime;
				end

				SC_RedSecText = EAFun_GetSpellConditionRedSecText(EA_Items[EA_playerClass][spellID]);
				if (SC_RedSecText <= -1) then
					SC_RedSecText = EAFun_GetSpellConditionRedSecText(EA_Items[EA_CLASS_OTHER][spellID]);
				end
				EAFun_SetCountdownStackText(eaf, EA_timeLeft, EA_count, SC_RedSecText);

				isOverGrow = EAFun_CheckSpellConditionOverGrow(EA_count, EA_Items[EA_playerClass][spellID]);
				if (not isOverGrow) then
					isOverGrow = EAFun_CheckSpellConditionOverGrow(EA_count, EA_Items[EA_CLASS_OTHER][spellID]);
				end
				FrameGlowShowOrHide(eaf,isOverGrow)
			else
				eaf.spellTimer:SetText("");
				eaf.spellStack:SetText("");
			end
		end
	end
end

function EventAlert_OnTarUpdate(spellID)
	if #EA_TarCurrentBuffs ~= 0 then
		local SC_RedSecText, isOverGrow = -1, false;

		local v = tostring(spellID);
		local eaf = _G["EATarFrame_"..v];
		spellID = tonumber(v);

		if eaf ~= nil then
			-- eaf:SetCooldown(0, 1);
			if (EA_Config.ShowTimer) then
				local EA_Name = EA_SPELLINFO_TARGET[spellID].name;
				local EA_count = EA_SPELLINFO_TARGET[spellID].count;
				local EA_expirationTime = EA_SPELLINFO_TARGET[spellID].expirationTime;
				local IfIsDebuff = EA_SPELLINFO_TARGET[spellID].isDebuff;
				local EA_currentTime = 0;
				local EA_timeLeft = 0;

				if (EA_expirationTime ~= nil) then
					EA_currentTime = GetTime();
					EA_timeLeft = 0 + EA_expirationTime - EA_currentTime;
				end

				SC_RedSecText = EAFun_GetSpellConditionRedSecText(EA_TarItems[EA_playerClass][spellID]);

				EAFun_SetCountdownStackText(eaf, EA_timeLeft, EA_count, SC_RedSecText);

				isOverGrow = EAFun_CheckSpellConditionOverGrow(EA_count, EA_TarItems[EA_playerClass][spellID]);
				FrameGlowShowOrHide(eaf,isOverGrow)
			else
				eaf.spellTimer:SetText("");
				eaf.spellStack:SetText("");
			end
		end
	end
end

function EventAlert_OnSCDUpdate(spellID)
	local iShift = 0;
	local eaf = _G["EAScdFrame_"..spellID];
	local flag_usable,flag_nomana =IsUsableSpell(spellID)
	local EA_ChargeCurrent, EA_ChargeMax, EA_ChargeStart,EA_ChargeDuration = GetSpellCharges(spellID);
	local EA_start, EA_duration, EA_Enable = GetSpellCooldown(spellID);

	local itemID = EA_Config.EA_SPELL_ITEM[spellID]
	if itemID then
		EA_start, EA_duration, EA_Enable = GetItemCooldown(itemID);
	end

	local s = EA_SPELLINFO_SCD[spellID].start
	local d = EA_SPELLINFO_SCD[spellID].duration
	if  d and d > 0 then
		EA_duration = d
		if s and s > 0 then EA_start = s end
	end

	if (eaf ~= nil) then
		local gsiIcon = GetSpellTexture(spellID)
		if not eaf.texture then eaf.texture = eaf:CreateTexture() end
		eaf.texture:SetAllPoints(eaf)
		eaf.texture:SetTexture(gsiIcon)
		eaf:SetWidth(EA_Config.IconSize);
		eaf:SetHeight(EA_Config.IconSize);

		if (EA_Position.SCD_UseCooldown) then
			eaf.useCooldown = true
		else
			eaf.useCooldown = false
		end

		if EA_ChargeCurrent then
			local EA_timeLeft = EA_ChargeStart + EA_ChargeDuration - GetTime();
			if EA_ChargeCurrent > 0 then
				if (EA_ChargeCurrent == EA_ChargeMax) then
					if eaf.useCooldown then
						eaf.cooldown:SetCooldown(0, 0,EA_ChargeCurrent,EA_ChargeMax)
						eaf.cooldown:SetHideCountdownNumbers(true)
						eaf.cooldown:SetDrawSwipe(false)

						if EA_ChargeCurrent == 1 then
							EAFun_SetCountdownStackText(eaf, 0, 0, 0, 1)
						else
							EAFun_SetCountdownStackText(eaf, 0, EA_ChargeCurrent, 0, 1)
						end
					else
						if EA_ChargeCurrent == 1 then
							EAFun_SetCountdownStackText(eaf, 0, 0, 0, 1)
						else
							EAFun_SetCountdownStackText(eaf, 0, EA_ChargeCurrent, 0, 1)
						end
						if EA_Config.SCD_RemoveWhenCooldown == true then RemoveSingleSCDCurrentBuff(spellID)	end
					end
				else
					if eaf.useCooldown then
						eaf.cooldown:SetCooldown(EA_ChargeStart, EA_ChargeDuration,EA_ChargeCurrent,EA_ChargeMax)
						eaf.cooldown:SetHideCountdownNumbers(true)
						eaf.cooldown:SetDrawSwipe(false)
						EAFun_SetCountdownStackText(eaf, 0, EA_ChargeCurrent, 1);
					else
						EAFun_SetCountdownStackText(eaf,  EA_timeLeft,EA_ChargeCurrent,0, 1);
					end
				end

				if EA_Config.SCD_GlowWhenUsable then FrameGlowShowOrHide(eaf,flag_usable) end
			else
				if eaf.useCooldown then
					eaf.cooldown:SetCooldown(EA_ChargeStart, EA_ChargeDuration,EA_ChargeCurrent,EA_ChargeMax)
					eaf.cooldown:SetHideCountdownNumbers(true)
					eaf.cooldown:SetDrawSwipe(true)
					EAFun_SetCountdownStackText(eaf, 0 , EA_ChargeCurrent, -1);
				else
					EAFun_SetCountdownStackText(eaf, EA_timeLeft , EA_ChargeCurrent, -1);
				end

				if EA_Config.SCD_GlowWhenUsable then FrameGlowShowOrHide(eaf, false) end
			end
		else
			if (EA_Enable == 1) then
				local EA_timeLeft = EA_start + EA_duration - GetTime();
				local EA_GCD=1.5/((100+UnitSpellHaste("player"))/100)

				if EA_GCD < 1 then EA_GCD = 1 end

				-- if (EA_start > 0 and EA_duration > EA_GCD )  then
				if (EA_timeLeft > 0 and EA_duration > EA_GCD )  then
					if EA_Config.SCD_GlowWhenUsable then FrameGlowShowOrHide(eaf,false) end

					if eaf.useCooldown then
						eaf.cooldown:SetCooldown(EA_start, EA_duration)
						eaf.cooldown:SetHideCountdownNumbers(true)
						eaf.cooldown:SetDrawSwipe(true)
					else
						if (EA_Config.ShowTimer) then
							EAFun_SetCountdownStackText(eaf, EA_timeLeft ,0, -1);
						end
					end
				else
					eaf.spellTimer:SetText("")
					EA_SPELLINFO_SCD[spellID].start = nil
					if EA_Config.SCD_RemoveWhenCooldown==true then
						RemoveSingleSCDCurrentBuff(spellID)
					else
						if EA_Config.SCD_GlowWhenUsable then FrameGlowShowOrHide(eaf,flag_usable) end
					end
				end
			end
		end

		EventAlert_ScdPositionFrames();
	end
end

function EventAlert_DoAlert()
	if (EA_Config.ShowFlash == true) then
		UIFrameFadeIn(LowHealthFrame, 1, 0, 1);
		UIFrameFadeOut(LowHealthFrame, 2, 1, 0);
	end
	if (EA_Config.DoAlertSound == true) then
		PlaySoundFile(EA_Config.AlertSound);
	end
end

function EventAlert_PositionFrames()
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local prevFrame2 = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;

		EA_CurrentBuffs = EAFun_SortCurrBuffs(1, EA_CurrentBuffs);

		for k,v in ipairs(EA_CurrentBuffs) do
			local eaf = _G["EAFrame_"..v];
			local spellID = tonumber(v);
			local gsiName = EA_SPELLINFO_SELF[spellID].name;
			local gsiValue = EA_SPELLINFO_SELF[spellID].value
			--local gsiValue1 = EA_SPELLINFO_SELF[spellID].value1;
			--local gsiValue2 = EA_SPELLINFO_SELF[spellID].value2;
			--local gsiValue3 = EA_SPELLINFO_SELF[spellID].value3;
			local gsiIcon = EA_SPELLINFO_SELF[spellID].icon;
			local gsiIsDebuff = EA_SPELLINFO_SELF[spellID].isDebuff;

			if eaf ~= nil then
				eaf:ClearAllPoints();
				if EA_Position.Tar_NewLine then
					if gsiIsDebuff then
						if (prevFrame2 == "EA_Main_Frame" or prevFrame2 == eaf) then
							prevFrame2 = "EA_Main_Frame";
							if EA_SpecFrame_Self then
								eaf:SetPoint(EA_Position.Anchor, prevFrame2, EA_Position.Anchor, -2 * xOffset, -2 * yOffset);
							else
								eaf:SetPoint(EA_Position.Anchor, prevFrame2, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
							end
						else
							eaf:SetPoint("CENTER", prevFrame2, "CENTER", -1 * xOffset, -1 * yOffset);
						end
						prevFrame2 = eaf;
					else
						if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
							prevFrame = "EA_Main_Frame";
							eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, 0, 0);
						else
							eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
						end
						prevFrame = eaf;
					end
				else
					if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
						prevFrame = "EA_Main_Frame";
						eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, 0, 0);
					else
						eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
					end
					prevFrame = eaf;
				end;

				eaf:SetWidth(EA_Config.IconSize);
				eaf:SetHeight(EA_Config.IconSize);

				--eaf:SetBackdrop({bgFile = gsiIcon});
				--for 7.0
				if not eaf.texture then eaf.texture = eaf:CreateTexture() end
				eaf.texture:SetAllPoints(eaf)
				eaf.texture:SetTexture(gsiIcon)

				--TEST
				-- FrameAppendSpellTip(eaf,spellID)
				FrameAppendAuraTip(eaf,"player",spellID,gsiIsDebuff)
				FrameAppendAuraTip(eaf,"pet",spellID,gsiIsDebuff)

				if gsiIsDebuff then eaf:SetBackdropColor(1.0, EA_Position.RedDebuff, EA_Position.RedDebuff) end;
				if (EA_Config.ShowName == true) then
					local tmp = gsiName
					if gsiValue and type(gsiValue)=="table" then
						for i,v in ipairs(gsiValue) do
							if v > EA_Config.ShowAuraValueWhenOver then
								if v > 10000 then v = format("%.1f萬",v/10000) end
								tmp = tmp.."\n"..v
							end
						end
					end
					--if gsiValue1 and (gsiValue1 > 0) then  tmp=tmp.."\n"..gsiValue1 end
					--if gsiValue2 and (gsiValue2 > 0) then  tmp=tmp.."\n"..gsiValue2 end
					--if gsiValue3 and (gsiValue3 > 0) then  tmp=tmp.."\n"..gsiValue3 end

					eaf.spellName:SetText(tmp);

					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize, "OUTLINE");
				eaf:SetScript("OnUpdate", function()
					EventAlert_OnUpdate(spellID)
				end);
				eaf:Show();
			end
		end
	end
end

function EventAlert_TarPositionFrames()
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local prevFrame2 = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;

		EA_TarCurrentBuffs = EAFun_SortCurrBuffs(2, EA_TarCurrentBuffs);

		for k,v in ipairs(EA_TarCurrentBuffs) do
			local eaf = _G["EATarFrame_"..v];
			local spellID = tonumber(v);
			local gsiName = EA_SPELLINFO_TARGET[spellID].name;
			local gsiIcon = EA_SPELLINFO_TARGET[spellID].icon;
			local gsiValue = EA_SPELLINFO_TARGET[spellID].value
			--local gsiValue1 = EA_SPELLINFO_TARGET[spellID].value1;
			--local gsiValue2 = EA_SPELLINFO_TARGET[spellID].value2;
			--local gsiValue3 = EA_SPELLINFO_TARGET[spellID].value3;
			local gsiIsDebuff = EA_SPELLINFO_TARGET[spellID].isDebuff;

			if eaf ~= nil then
				eaf:ClearAllPoints();
				if EA_Position.Tar_NewLine then
					if gsiIsDebuff then
						if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
							prevFrame = "EA_Main_Frame";
							eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset, EA_Position.Tar_yOffset);
						else
							eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
						end
						prevFrame = eaf;
					else
						if (prevFrame2 == "EA_Main_Frame" or prevFrame2 == eaf) then
							prevFrame2 = "EA_Main_Frame";
							if EA_SpecFrame_Target then
								eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset - 2 * xOffset, EA_Position.Tar_yOffset - 2 * yOffset);
								-- eaf:SetPoint(EA_Position.TarAnchor, prevFrame2, EA_Position.TarAnchor, -2 * xOffset, -2 * yOffset);
							else
								eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset - xOffset, EA_Position.Tar_yOffset - yOffset);
								-- eaf:SetPoint(EA_Position.TarAnchor, prevFrame2, EA_Position.TarAnchor, -1 * xOffset, -1 * yOffset);
							end
						else
							eaf:SetPoint("CENTER", prevFrame2, "CENTER", -1 * xOffset, -1 * yOffset);
						end
						prevFrame2 = eaf;
					end
				else
					if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
						prevFrame = "EA_Main_Frame";
						eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
					else
						eaf:SetPoint("CENTER", prevFrame, "CENTER", -1 * xOffset, -1 * yOffset);
					end
				end

				eaf:SetWidth(EA_Config.IconSize);
				eaf:SetHeight(EA_Config.IconSize);

				--eaf:SetBackdrop({bgFile = gsiIcon})
				--for 7.0
				if not eaf.texture then eaf.texture = eaf:CreateTexture() end
				eaf.texture:SetAllPoints(eaf)
				eaf.texture:SetTexture(gsiIcon)

				--增加鼠標提示
				-- FrameAppendSpellTip(eaf,spellID)
				FrameAppendAuraTip(eaf,"target",spellID,gsiIsDebuff)

				if gsiIsDebuff then eaf:SetBackdropColor(EA_Position.GreenDebuff, 1.0, EA_Position.GreenDebuff) end;
				if (EA_Config.ShowName == true) then
					local tmp=gsiName
					if gsiValue and type(gsiValue)=="table" then
						for k,v in pairs(gsiValue) do
							if v > EA_Config.ShowAuraValueWhenOver then
								if v > 10000 then v = format("%.1f萬",v/10000) end
								tmp = tmp.."\n"..v
							end
						end
					end
					--if gsiValue1 and (gsiValue1 > 0) then  tmp=tmp.."\n"..gsiValue1 end
					--if gsiValue2 and (gsiValue2 > 0) then  tmp=tmp.."\n"..gsiValue2 end
					--if gsiValue3 and (gsiValue3 > 0) then  tmp=tmp.."\n"..gsiValue3 end

					eaf.spellName:SetText(tmp);

					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize, "OUTLINE");
				eaf:SetScript("OnUpdate", function()
					EventAlert_OnTarUpdate(spellID)
				end);
				eaf:Show();
			end
		end
	end
end

function EventAlert_ScdPositionFrames()
	--If Player is Combating, don't show Spell Cooldown Frame.
	if EA_Config.SCD_NocombatStillKeep == false then
		if UnitAffectingCombat("player") == false then
			HideAllScdCurrentBuff()
			return
		end
	end

	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;

		for s,v in pairs(EA_ScdItems[EA_playerClass]) do
			for k,v2 in pairs(v) do
				if k == "orderwtd" then
					EA_SPELLINFO_SCD[s] = EA_SPELLINFO_SCD[s] or {}	--若不存在EA_SPELLINFO_SCD[s]則建立空的表格，避免存取錯誤
					EA_SPELLINFO_SCD[s][k] = v2;
				end
			end
		end

		EA_ScdCurrentBuffs = EAFun_SortCurrBuffs(3, EA_ScdCurrentBuffs)

		for k,v in ipairs(EA_ScdCurrentBuffs) do
			local eaf = _G["EAScdFrame_"..v];
			local spellID = tonumber(v);
			local gsiName = EA_SPELLINFO_SCD[spellID].name;

			if eaf ~= nil then
				eaf:ClearAllPoints();
				if (prevFrame == "EA_Main_Frame" or prevFrame == eaf) then
					prevFrame = "EA_Main_Frame";
					eaf:SetPoint("CENTER", UIParent, EA_Position.ScdAnchor, EA_Position.Scd_xOffset, EA_Position.Scd_yOffset);
				else
					eaf:SetPoint("CENTER", prevFrame, "CENTER", xOffset, yOffset);
				end

				if (EA_Config.ShowName == true) then
					eaf.spellName:SetText(gsiName);
					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize, "OUTLINE");

				--增加鼠標提示
				FrameAppendSpellTip(eaf,spellID)

				prevFrame = eaf;
				eaf:Show();
			end
		end
	end
end

-- The command parser
function EventAlert_SlashHandler(msg)
	local F_EA = "\124cffFFFF00EventAlertMod\124r";
	local F_ON = "\124cffFF0000".."[ON]".."\124r";
	local F_OFF = "\124cff00FFFF".."[OFF]".."\124r";
	local RtnMsg = "";
	local MoreHelp = false;

	msg = string.lower(msg);
	local cmdtype, para1 = strsplit(" ", msg)
	local listSec = 0;
	if para1 ~= nil then
		listSec = tonumber(para1);
	end

	if (cmdtype == "options" or cmdtype == "opt") then
		if not EA_Options_Frame:IsVisible() then
			-- ShowUIPanel(EA_Options_Frame);
			EA_Options_Frame:Show();
		else
			-- HideUIPanel(EA_Options_Frame);
			EA_Options_Frame:Hide();
		end

	-- elseif (cmdtype == "version" or cmdtype == "ver") then
	--  DEFAULT_CHAT_FRAME:AddMessage(F_EA..EA_XCMD_VER..EA_Config.Version);

	elseif (cmdtype == "show") then
		EA_DEBUGFLAG11 = false;
		EA_DEBUGFLAG21 = false;
		EA_LISTSEC_SELF = 0;
		if (EA_DEBUGFLAG1) then
			EA_DEBUGFLAG1 = false;
			RtnMsg = F_EA..EA_XCMD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG1 = true;
			EA_LISTSEC_SELF = listSec;
			RtnMsg = F_EA..EA_XCMD_SELFLIST..F_ON;
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end;
			EAFun_ClearSpellScrollFrame();
			EA_Version_Frame:Show();
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showtarget" or cmdtype == "showt") then
		EA_DEBUGFLAG11 = false;
		EA_DEBUGFLAG21 = false;
		EA_LISTSEC_TARGET = 0;
		if (EA_DEBUGFLAG2) then
			EA_DEBUGFLAG2 = false;
			RtnMsg = F_EA..EA_XCMD_TARGETLIST..F_OFF;
		else
			EA_DEBUGFLAG2 = true;
			EA_LISTSEC_TARGET = listSec;
			RtnMsg = F_EA..EA_XCMD_TARGETLIST..F_ON;
			if EA_LISTSEC_TARGET > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_TARGET.." secs)" end;
			EAFun_ClearSpellScrollFrame();
			EA_Version_Frame:Show();
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showcast" or cmdtype == "showc") then
		EA_DEBUGFLAG11 = false;
		EA_DEBUGFLAG21 = false;
		if (EA_DEBUGFLAG3) then
			EA_DEBUGFLAG3 = false;
			RtnMsg = F_EA..EA_XCMD_CASTSPELL..F_OFF;
		else
			EA_DEBUGFLAG3 = true;
			RtnMsg = F_EA..EA_XCMD_CASTSPELL..F_ON;
			EAFun_ClearSpellScrollFrame();
			EA_Version_Frame:Show();
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showautoadd" or cmdtype == "showa") then
		EA_DEBUGFLAG1 = false;
		EA_DEBUGFLAG2 = false;
		EA_DEBUGFLAG3 = false;
		EA_DEBUGFLAG21 = false;
		EA_LISTSEC_SELF = 60;
		if (EA_DEBUGFLAG11) then
			EA_DEBUGFLAG11 = false;
			RtnMsg = F_EA..EA_XCMD_AUTOADD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG11 = true;
			RtnMsg = F_EA..EA_XCMD_AUTOADD_SELFLIST..F_ON;
			if listSec > 0 then EA_LISTSEC_SELF = listSec end;
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end;
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "showenvadd" or cmdtype == "showe") then
		EA_DEBUGFLAG1 = false;
		EA_DEBUGFLAG2 = false;
		EA_DEBUGFLAG3 = false;
		EA_DEBUGFLAG11 = false;
		EA_LISTSEC_SELF = 60;
		if (EA_DEBUGFLAG21) then
			EA_DEBUGFLAG21 = false;
			RtnMsg = F_EA..EA_XCMD_ENVADD_SELFLIST..F_OFF;
		else
			EA_DEBUGFLAG21 = true;
			RtnMsg = F_EA..EA_XCMD_ENVADD_SELFLIST..F_ON;
			if listSec > 0 then EA_LISTSEC_SELF = listSec end;
			if EA_LISTSEC_SELF > 0 then RtnMsg = RtnMsg.." ("..EA_LISTSEC_SELF.." secs)" end;
		end
		DEFAULT_CHAT_FRAME:AddMessage(RtnMsg);

	elseif (cmdtype == "lookup") or (cmdtype == "l")then
		EventAlert_Lookup(para1, false);

	elseif (cmdtype == "lookupfull") or (cmdtype == "lf") then
		EventAlert_Lookup(para1, true);

	elseif (cmdtype == "list") then
		EA_Version_Frame_HeaderText:SetText(EA_XCMD_DEBUG_P0);
		EA_Version_ScrollFrame_EditBox:Hide();
		EA_Version_Frame:Show();

    elseif (cmdtype == "minimap") then
		if EA_Config.OPTION_ICON == false  then
			EA_Config.OPTION_ICON = true
			EA_MinimapOption:Show()
		else
			EA_Config.OPTION_ICON = false
			EA_MinimapOption:Hide()
		end

	elseif (cmdtype == "scdremovewhencooldown") then
		if EA_Config.SCD_RemoveWhenCooldown == true then

			EA_Config.SCD_RemoveWhenCooldown = false
			print("EA_Config.SCD_RemoveWhenCooldown = false")

		else
			EA_Config.SCD_RemoveWhenCooldown = true
			print("EA_Config.SCD_RemoveWhenCooldown = true")
		end
	elseif (cmdtype == "scdnocombatstillkeep") then
		if EA_Config.SCD_NocombatStillKeep == true then
			EA_Config.SCD_NocombatStillKeep = false
			print("EA_Config.SCD_NocombatStillKeep = false")
		else
			EA_Config.SCD_NocombatStillKeep = true
			print("EA_Config.SCD_NocombatStillKeep = true")
		end
	elseif (cmdtype == "showeaconfig") then
		print("EA_Config:")
		for k,v in pairs(EA_Config) do
			if type(v)=="table" then
				print(k.."={")
				for k2,v2 in pairs(v) do print("   ",k2," = ",v2) end
				print("}")
			else
				print(k," = ",v)
			end
		end
	elseif (cmdtype == "showeaposition") then
		print("EA_Position:")
		for k,v in pairs(EA_Position) do
			if type(v)=="table" then
				print(k.."={")
				for k2,v2 in pairs(v) do print("   ",k2," = ",v2) end
				print("}")
			else
				print(k," = ",v)
			end
		end
	elseif (cmdtype == "print") then
		-- table.foreach(EA_ClassAltSpellName,
		-- function(i, v)
		--  if v == nil then v = "nil" end;
		--  DEFAULT_CHAT_FRAME:AddMessage("["..i.."]EA_ClassAltSpellName["..i.."]="..EA_ClassAltSpellName[i].." v="..v);
		-- end
		-- )
		-- EAFun_CreateVersionFrame_ScrollEditBox();
		-- EA_Version_Frame_HeaderText:SetText("Test");
		-- EA_Version_Frame:Show();
		-- print ("go print");
		-- for  i, v in pairsByKeys(EA_Items) do
		--  print (i);
		--  --if v.enable then
		--  --  print ("enable T");
		--  --else
		--  --  print ("enable F");
		--  --end
		-- end

	-- elseif (cmdtype == "play") then
	--  EventAlert_ExecutionFrame:SetAlpha(1);
	--  EventAlert_ExecutionFrame:Show();
	--  iEAEXF_FrameCount = 0;
	--  iEAEXF_Prefraction = 0;
	--  EAEXF_AnimateOut(EventAlert_ExecutionFrame);

	else
		if cmdtype == "help" then MoreHelp = true end;
		DEFAULT_CHAT_FRAME:AddMessage(F_EA..EA_XCMD_VER..EA_Config.Version);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.TITLE);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.OPT);
		DEFAULT_CHAT_FRAME:AddMessage(EA_XCMD_CMDHELP.HELP);

		for i, v in ipairs(EA_XCMD_CMDHELP["SHOW"]) do
			if i == 1 then
				if EA_DEBUGFLAG1 then v = v..EA_XCMD_SELFLIST..F_ON else v = v..EA_XCMD_SELFLIST..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWT"]) do
			if i == 1 then
				if EA_DEBUGFLAG2 then v = v..EA_XCMD_TARGETLIST..F_ON else v = v..EA_XCMD_TARGETLIST..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWC"]) do
			if i == 1 then
				if EA_DEBUGFLAG3 then v = v..EA_XCMD_CASTSPELL..F_ON else v = v..EA_XCMD_CASTSPELL..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWA"]) do
			if i == 1 then
				if EA_DEBUGFLAG11 then v = v..EA_XCMD_AUTOADD_SELFLIST..F_ON else v = v..EA_XCMD_AUTOADD_SELFLIST..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["SHOWE"]) do
			if i == 1 then
				if EA_DEBUGFLAG21 then v = v..EA_XCMD_ENVADD_SELFLIST..F_ON else v = v..EA_XCMD_ENVADD_SELFLIST..F_OFF end;
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["LIST"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["LOOKUP"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["LOOKUPFULL"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
	end
end

-- The URLs of update
function EventAlert_ShowVerURL(SiteIndex)
	local VerUrl = "";
	VerUrl = EA_XOPT_VERURL1;
	if SiteIndex ~= 1 then
		VerUrl = "http://forum.gamer.com.tw/Co.php?bsn=05219&sn=5125122&subbsn=0";
	end

	DEFAULT_CHAT_FRAME:AddMessage(VerUrl);
end

function EAFun_CreateVersionFrame_ScrollEditBox()
	local framewidth = EA_Version_Frame:GetWidth()-45;
	local frameheight = EA_Version_Frame:GetHeight()-70;
	local panel3 = _G["EA_Version_ScrollFrame"];
	if panel3 == nil then
		panel3 = CreateFrame("ScrollFrame", "EA_Version_ScrollFrame", EA_Version_Frame, "UIPanelScrollFrameTemplate");
	end
	local scc = _G["EA_Version_ScrollFrame_List"];
	if scc == nil then
		scc = CreateFrame("Frame", "EA_Version_ScrollFrame_List", panel3);
		panel3:SetScrollChild(scc);
		panel3:SetPoint("TOPLEFT", EA_Version_Frame, "TOPLEFT", 15, -30);
		scc:SetPoint("TOPLEFT", panel3, "TOPLEFT", 0, 0);
		panel3:SetWidth(framewidth);
		panel3:SetHeight(frameheight);
		scc:SetWidth(framewidth);
		scc:SetHeight(frameheight);
		panel3:SetBackdrop({bgFile="Interface\\DialogFrame\\UI-DialogBox-Background", edgeFile="", tile = false, tileSize = 0, edgeSize = 0, insets = { left = 0, right = 0, top = 0, bottom = 0 }});
		panel3:SetScript("OnVerticalScroll", function()  end);
		panel3:EnableMouse(true);
		panel3:SetVerticalScroll(0);
		panel3:SetHorizontalScroll(0);
	end
	local etb1 = _G["EA_Version_ScrollFrame_EditBox"];
	if etb1 == nil then
		etb1 = CreateFrame("EditBox", "EA_Version_ScrollFrame_EditBox", scc);
		etb1:SetPoint("TOPLEFT",0,0);
		etb1:SetFontObject(ChatFontNormal);
		etb1:SetWidth(framewidth);
		etb1:SetHeight(frameheight);
		etb1:SetMultiLine();
		etb1:SetMaxLetters(0);
		etb1:SetAutoFocus(false);
	end
end

local function EAFun_ExtendExecution_4505(EAItems)
	for index1, value1 in pairsByKeys(EAItems) do
		if EAItems[index1] ~= nil then EAItems[index1].Execution = 0 end;
	end
	return EAItems;
end

local function EAFun_ChangeSavedVariblesFormat_4505(EAItems, EASelf)
	if EAItems == nil then EAItems = { } end;
	for index1, value1 in pairsByKeys(EAItems) do
		for index2, value2 in pairsByKeys(EAItems[index1]) do
			if (EASelf) then
				EAItems[index1][index2] = {enable=value2, self=true,};
			else
				EAItems[index1][index2] = {enable=value2,};
			end
		end
	end
	return EAItems;
end

function EventAlert_VersionCheck()
	local EA_TocVersion = GetAddOnMetadata("EventAlertMod", "Version");
	-- local F_EA = "\124cffFFFF00EventAlertMod\124r";

	EAFun_CreateVersionFrame_ScrollEditBox();
	EA_Version_Frame_Okay:SetText(EA_XOPT_OKAY);

	if ( EA_Config.Version ~= nil and EA_Config.Version < EA_TocVersion) then
		EA_Items = { };
		EA_AltItems = { };
		EA_TarItems = { };
		EA_ScdItems = { };
		EA_GrpItems = { };
		EA_Pos = EAFun_ExtendExecution_4505(EA_Pos);
		EA_Items = EAFun_ChangeSavedVariblesFormat_4505(EA_Items, false);
		EA_AltItems = EAFun_ChangeSavedVariblesFormat_4505(EA_AltItems, false);
		EA_TarItems = EAFun_ChangeSavedVariblesFormat_4505(EA_TarItems, true);
		EA_ScdItems = EAFun_ChangeSavedVariblesFormat_4505(EA_ScdItems, false);
		-- if (EA_XLOAD_NEWVERSION_LOAD ~= "") then
			-- EA_Version_ScrollFrame_EditBox:SetText(F_EA..EA_XCMD_VER..EA_Config.Version.."\n\n\n"..EA_XLOAD_NEWVERSION_LOAD);
			-- EA_Version_Frame:Show();
		-- end
		EventAlert_LoadClassSpellArray(9);
		EA_Config.Version = EA_TocVersion;
		BigFoot_Print("|cff00c0c0<EventAlertMod>|r 为保证插件正常稳定使用，EventAlertMod插件配置已重置。")
	elseif (EA_Config.Version == nil) then
		EA_Items = { };
		EA_AltItems = { };
		EA_TarItems = { };
		EA_ScdItems = { };
		EA_GrpItems = { };
		EA_Config.Version = EA_TocVersion;
		-- if (EA_XLOAD_FIRST_LOAD ~= "") then
		-- 	EA_Version_ScrollFrame_EditBox:SetText(F_EA..EA_XCMD_VER..EA_Config.Version.."\n\n\n"..EA_XLOAD_FIRST_LOAD..EA_XLOAD_NEWVERSION_LOAD)
		-- 	EA_Version_Frame:Show();
		-- end
		EventAlert_LoadClassSpellArray(9);
	elseif (EAFun_GetCountOfTable(EA_Items[EA_playerClass]) <= 0) or (EAFun_GetCountOfTable(EA_ScdItems[EA_playerClass]) <= 0) then
		EventAlert_LoadClassSpellArray(9);
	end

	if EA_Items[EA_playerClass] == nil then EA_Items[EA_playerClass] = {} end;
	if EA_AltItems[EA_playerClass] == nil then EA_AltItems[EA_playerClass] = {} end;
	if EA_Items[EA_CLASS_OTHER] == nil then EA_Items[EA_CLASS_OTHER] = {} end;
	if EA_TarItems[EA_playerClass] == nil then EA_TarItems[EA_playerClass] = {} end;
	if EA_ScdItems[EA_playerClass] == nil then EA_ScdItems[EA_playerClass] = {} end;
	if EA_GrpItems[EA_playerClass] == nil then EA_GrpItems[EA_playerClass] = {} end;
	-- EventAlert_LoadClassSpellArray(6);
	-- After confirm the version, set the VersionText in the EA_Options_Frame.
	EA_Options_Frame_VersionText:SetText("Ver:\124cffFFFFFF"..EA_Config.Version.."\124r");
end

function insertBuffValue(tab, value)
	local isExist = false;
	for pos, name in ipairs(tab) do
		if (name == value) then
			isExist = true;
		end
	end
	if not isExist then table.insert(tab, value) end;
end

function removeBuffValue(tab, value)
	for pos, name in ipairs(tab) do
		if (name == value) then
			table.remove(tab, pos)
		end
	end
end

function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0 -- iterator variable
	local iter = function () -- iterator function
		i = i + 1
		if a[i] == nil then
			return nil
		else
			return a[i], t[a[i]]
		end
	end
	return iter
end

function EAFun_GetFormattedTime(timeLeft)
	local formattedTime = "";
	if timeLeft <= 60 then
		if (timeLeft <= EA_Config.UseFloatSec and timeLeft~=floor(timeLeft)) then
			formattedTime = tostring(format("%.1f",timeLeft));
		else
			formattedTime = tostring(format("%d",timeLeft));
		end
	elseif timeLeft <= 3600 then
		formattedTime = format("%d:%02d", floor(timeLeft/60), timeLeft % 60);
	else
		formattedTime = format("%2d:%2d:%02d", floor(timeLeft/3600),floor((timeLeft % 3600)/60), timeLeft % 3600);
	end
	return formattedTime;
end

function MyPrint(info)
	DEFAULT_CHAT_FRAME:AddMessage(info);
end

function EAFun_SetCountdownStackText(eaf, EA_timeLeft, EA_count, SC_RedSecText)
	eaf.spellTimer:ClearAllPoints();
	if ((SC_RedSecText == nil) or (SC_RedSecText <= 0)) then SC_RedSecText = -1 end;
	if (EA_timeLeft > 0) then
		if (EA_Config.ChangeTimer == true) then
			eaf.spellTimer:SetPoint("CENTER", eaf, "CENTER", 0, 0);
		else
			--eaf.spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize);
			eaf.spellTimer:SetPoint("BOTTOM", eaf, "TOP" ,0, 0);
		end
		if (EA_timeLeft < SC_RedSecText + 1) then
			if (not eaf.redsectext) then
				--eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", 1*(EA_Config.TimerFontSize+5), "OUTLINE");
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", (EA_Config.TimerFontSize+5), "OUTLINE");
				eaf.spellTimer:SetTextColor(1, 0, 0);
				eaf.redsectext = true;
				eaf.whitesectext = false;
			end
		else
			if (not eaf.whitesectext) then
				--eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", 1*EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF",EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellTimer:SetTextColor(1, 1, 1);
				eaf.spellTimer:SetShadowColor(0, 0, 0);			--設定計數文字陰影為黑色
				eaf.spellTimer:SetShadowOffset(2, -2);			--設定計數文字陰影偏移量(右移2下移2)
				eaf.redsectext = false;
				eaf.whitesectext = true;
			end
		end
		eaf.spellTimer:SetText(EAFun_GetFormattedTime(EA_timeLeft));
	else
		eaf.spellTimer:SetText("");
	end

	eaf.spellStack:ClearAllPoints();
	--if (EA_count > 0) then
	--計數值大於1才顯示
	if (EA_count > 1) then
		eaf.spellStack:SetPoint("BOTTOMRIGHT", eaf, "BOTTOMRIGHT", -eaf:GetWidth() * 0.0 , eaf:GetHeight() * 0.03)
		eaf.spellStack:SetTextColor(1, 1, 0);			--設定堆疊文字顏色為白色
		eaf.spellStack:SetShadowColor(0, 0, 0);			--設定堆疊文字陰影為黑色
		eaf.spellStack:SetShadowOffset(2, -2);			--設定堆疊文字陰影偏移量(右移2下移2)
		--eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize*1.05, "OUTLINE");
		eaf.spellStack:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.StackFontSize*1.25, "OUTLINE");
		eaf.spellStack:SetFormattedText("%d", EA_count);
	else
		eaf.spellStack:SetFormattedText("");
	end
end

-- Speciall Frame: UpdateComboPoint, for watching the combopoint of player
function EventAlert_UpdateComboPoint()
	EA_COMBO_POINTS = UnitPower("player",EA_SPELL_POWER_COMBO_POINT)
	local iComboPoint = EA_COMBO_POINTS
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;
		local eaf = _G["EAFrameSpec_1000000"];

		if (eaf ~= nil) then
			if (iComboPoint > 0) then
				EA_SpecFrame_Target = true;
				eaf:ClearAllPoints();
				eaf:SetPoint(EA_Position.TarAnchor, UIParent, EA_Position.TarAnchor, EA_Position.Tar_xOffset - xOffset * 1.5, EA_Position.Tar_yOffset - yOffset);

				if (EA_Config.ShowName) then
					eaf.spellName:SetText(EA_XSPECINFO_COMBOPOINT);
					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end

				EAFun_SetCountdownStackText(eaf, iComboPoint, 0, -1);
				eaf:Show();

				-- for 7.0 依據盜賊天賦決定連擊點高亮值
				local ComboPointMax = UnitPowerMax("player",EA_SPELL_POWER_COMBO_POINT)
				local GlowComboPoint = 5
				if ComboPointMax == 6 then		--7.0盜賊天賦:精明戰略
					GlowComboPoint = 6
				else
					GlowComboPoint = 5			--7.0非精明戰略下, 最大值不是5就是8, 一律以5做為高亮值
				end
				FrameGlowShowOrHide(eaf,(iComboPoint >= GlowComboPoint))
			else
				FrameGlowShowOrHide(eaf, false)
				EA_SpecFrame_Target = false;
				eaf:Hide();
			end
			EventAlert_TarPositionFrames();
		end
	end
end

function EventAlert_UpdateFocus()
	local iUnitPower = UnitPower("player", EA_SPELL_POWER_FOCUS);
	local iPetPower = UnitPower("pet", EA_SPELL_POWER_FOCUS);
	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;
		local eaf1 = _G["EAFrameSpec_1000020"];
		local eaf2 = _G["EAFrameSpec_1000021"];

		EA_SpecFrame_Self = true;

		if (eaf1 ~= nil) and (EA_Config.SpecPowerCheck.Focus) and (iUnitPower > 0)then
			eaf1:ClearAllPoints();
			eaf1:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset)
			if (EA_Config.ShowName == true) then
				eaf1.spellName:SetText(EA_XSPECINFO_FOCUS);
				SfontName, SfontSize = eaf1.spellName:GetFont();
				eaf1.spellName:SetFont(SfontName, EA_Config.SNameFontSize)
			else
				eaf1.spellName:SetText("")
			end
			eaf1.spellTimer:ClearAllPoints();
			if (EA_Config.ChangeTimer == true) then
				eaf1.spellTimer:SetPoint("CENTER", 0, 0);
			else
				eaf1.spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize*1.1);
			end
			eaf1.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
			eaf1.spellTimer:SetText(iUnitPower);

			eaf1:SetScript("OnUpdate",EventAlert_UndateFocus)
		else
			FrameGlowShowOrHide(eaf1, false)
			EA_SpecFrame_Self = false;
			eaf1:SetScript("OnUpdate",nil)
			eaf1:Hide()
		end

		if (eaf2 ~= nil) and (EA_Config.SpecPowerCheck.FocusPet) and (iPetPower > 0) then
			eaf2:ClearAllPoints();
			eaf2:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -2 * xOffset, -2 * yOffset);
			if (EA_Config.ShowName == true) then
				eaf2.spellName:SetText(EA_XSPECINFO_FOCUS_PET);
				SfontName, SfontSize = eaf2.spellName:GetFont();
				eaf2.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
			else
				eaf2.spellName:SetText("");
			end

			eaf2.spellTimer:ClearAllPoints();
			if (EA_Config.ChangeTimer == true) then
				eaf2.spellTimer:SetPoint("CENTER", 0, 0);
			else
				eaf2.spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize*1.1);
			end
			eaf2.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
			eaf2.spellTimer:SetText(iPetPower);
			eaf2:Show()
			--寵物集中大於設定值高亮
			if EA_Config.HUNTER_GlowPetFocus > 0 then
				FrameGlowShowOrHide(eaf2, (iPetPower >= EA_Config.HUNTER_GlowPetFocus))
			end

			eaf2:SetScript("OnUpdate",EventAlert_UndateFocus)
		else
			EA_SpecFrame_Self = false
			FrameGlowShowOrHide(eaf2, false)
			eaf2:SetScript("OnUpdate",nil)
			eaf2:Hide()
		end

		EventAlert_PositionFrames();
	end
end

-- Speciall Frame: Update Runes
function EventAlert_UpdateRunes()
	--若不是DK則不執行此符文刷新
	if (EA_playerClass ~= EA_CLASS_DK) then return end
	if not(EA_Config.SpecPowerCheck.Runes) then return end
	if not(EA_SpecPower.Runes.has) then return end

	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;
		local eaf={}
		EA_SpecFrame_Self = true

		for i=1,MAX_RUNES do
			eaf[i]=_G["EAFrameSpec_"..EA_SpecPower.Runes.frameindex[i]]
			if not(eaf[i]) then
				CreateFrames_SpecialFrames_Show(EA_SpecPower.Runes.frameindex[i])
				eaf[i]=_G["EAFrameSpec_"..EA_SpecPower.Runes.frameindex[i]]
			end
			if eaf[i] then
				eaf[i]:SetWidth(EA_Config.IconSize*0.8)
				eaf[i]:SetHeight(EA_Config.IconSize*0.8)
				if (eaf[i]:IsShown()==false) then
					eaf[i]:Show()
				end
			end
			slot=i
			iRuneType = EA_RUNE_TYPE
			if (iRuneType >= 1) and (iRuneType <4 ) then
				eaf[i]:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, EA_Config.IconSize+(i-2) * xOffset*0.6, EA_Config.IconSize+(i-2) * yOffset*0.6)

				--if not(eaf[i]:GetBackdrop()) then
					eaf[i]:SetBackdrop({bgFile=iconTextures[iRuneType]});
				--end

				if (EA_Config.ShowName==true) then
					--eaf[i].spellName:SetText(runeTypeText[iRuneType]);
					--SfontName, SfontSize = eaf[i].spellName:GetFont();
					--eaf[i].spellName:SetFont(SfontName, EA_Config.SNameFontSize*0.8);
				else
					eaf[i].spellName:SetText("")
				end

				eaf[i].spellTimer:ClearAllPoints();
				if (EA_Config.ChangeTimer == true) then
					eaf[i].spellTimer:SetPoint("CENTER", 0, 0);
				else
					eaf[i].spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize*0.5);
				end

				local EA_start, EA_duration, runeReady = GetRuneCooldown(i)
				local EA_timeLeft

				if not(EA_start) then return end

				if (runeReady) then
					EA_timeLeft = 0
				else
					EA_timeLeft = EA_start + EA_duration - GetTime()
				end

				if (EA_timeLeft > EA_duration) then EA_timeLeft = EA_duration end

				if (EA_timeLeft > 0) then
					EAFun_SetCountdownStackText(eaf[i],EA_timeLeft,0,-1)
				else
					EAFun_SetCountdownStackText(eaf[i],0,0,-1)
				end

				if not(eaf[i]:HasScript("OnUpdate")) then
					eaf[i]:SetScript("OnUpdate",EventAlert_UpdateRunes)
				end

				if (eaf[i]:IsShown()==false) then
					eaf[i]:Show()
				end
				EventAlert_PositionFrames();
			end

			--若脫戰則隱藏符文框架
			if UnitAffectingCombat("player") == false then
				eaf[i]:Hide()
			else
				eaf[i]:Show()
			end
		end
	end
end

-- Speciall Frame: UpdateSinglePower(holy power, runic power, soul shards), for watching the power of player
function EventAlert_UpdateSinglePower(iPowerType)
	local iUnitPower = UnitPower("player", iPowerType);
	local iPowerName = "";
	local iFrameIndex = 1000000 + iPowerType * 10;
	if EA_playerClass == EA_CLASS_DK then EventAlert_UpdateRunes() end
	if (iPowerType == EA_SPELL_POWER_RUNIC_POWER) then iPowerName = EA_XSPECINFO_RUNICPOWER end;
	if (iPowerType == EA_SPELL_POWER_SOUL_SHARDS) then iPowerName = EA_XSPECINFO_SOULSHARDS end;
	if (iPowerType == EA_SPELL_POWER_HOLY_POWER) then iPowerName = EA_XSPECINFO_HOLYPOWER end;
	if (iPowerType == EA_SPELL_POWER_INSANITY) then iPowerName = EA_XSPECINFO_INSANITY end;
	if (iPowerType == EA_SPELL_POWER_RAGE) then iPowerName = EA_XSPECINFO_RAGE end;
	if (iPowerType == EA_SPELL_POWER_FOCUS) then iPowerName = EA_XSPECINFO_FOCUS end;
	if (iPowerType == EA_SPELL_POWER_PET_FOCUS) then iPowerName = EA_XSPECINFO_PET_FOCUS end;
	if (iPowerType == EA_SPELL_POWER_ENERGY) then iPowerName = EA_XSPECINFO_ENERGY end;
	if (iPowerType == EA_SPELL_POWER_LIGHT_FORCE) then iPowerName = EA_XSPECINFO_LIGHTFORCE end;
	if (iPowerType == EA_SPELL_POWER_BURNING_EMBERS) then iPowerName = EA_XSPECINFO_BURNINGEMBERS end;
	if (iPowerType == EA_SPELL_POWER_DEMONIC_FURY) then iPowerName = EA_XSPECINFO_DEMONICFURY end;
	if (iPowerType == EA_SPELL_POWER_LUNAR_POWER) then iPowerName = EA_XSPECINFO_LUNARPOWER end;
	if (iPowerType == EA_SPELL_POWER_ARCANE_CHARGES) then iPowerName = EA_XSPECINFO_ARCANECHARGES end;
	if (iPowerType == EA_SPELL_POWER_MAELSTROM) then iPowerName = EA_XSPECINFO_MAELSTROM end;
	if (iPowerType == EA_SPELL_POWER_FURY) then iPowerName = EA_XSPECINFO_FURY end;
	if (iPowerType == EA_SPELL_POWER_PAIN) then iPowerName = EA_XSPECINFO_PAIN end;

	if (EA_Config.ShowFrame == true) then
		EA_Main_Frame:ClearAllPoints();
		EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
		local prevFrame = "EA_Main_Frame";
		local xOffset = 100 + EA_Position.xOffset;
		local yOffset = 0 + EA_Position.yOffset;
		local SfontName, SfontSize = "", 0;
		local eaf = _G["EAFrameSpec_"..iFrameIndex];

		if (eaf ~= nil) then
			if (iUnitPower > 0) then
				EA_SpecFrame_Self = true;
				eaf:ClearAllPoints()
				if (iPowerType==EA_SPELL_POWER_ENERGY) then
					if (EA_playerClass == EA_CLASS_ROGUE) then
						eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset)
					else
						eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -2 * xOffset, -2 * yOffset)
					end
				else
					eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset)
					if (EA_SpecPower.Energy.has and EA_Config.SpecPowerCheck.Energy) then
						iFrameIndex2 = 1000000 + EA_SPELL_POWER_ENERGY * 10
						eaf2 = _G["EAFrameSpec_"..iFrameIndex2]
						eaf2:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -2 * xOffset, -2 * yOffset)
					end
				end

				if (iPowerType == EA_SPELL_POWER_LUNAR_POWER) then
					eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -3 * xOffset, -3 * yOffset)
				end

				if (EA_Config.ShowName == true) then
					eaf.spellName:SetText(iPowerName);
					SfontName, SfontSize = eaf.spellName:GetFont();
					eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
				else
					eaf.spellName:SetText("");
				end

				eaf.spellTimer:ClearAllPoints();
				if (EA_Config.ChangeTimer == true) then
					eaf.spellTimer:SetPoint("CENTER", 0, 0);
				else
					eaf.spellTimer:SetPoint("TOP", 0, EA_Config.TimerFontSize*1.1);
				end
				eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
				eaf.spellTimer:SetText(iUnitPower);
				eaf:Show();

				-- 怒氣達到上限高亮
				if (iPowerType == EA_SPELL_POWER_RAGE) then
					--若為戰士
					if (EA_playerClass == EA_CLASS_WARRIOR) then
						--若專精為狂怒表示有暴怒技能
						if (GetSpecialization() == 2) then
							--若天賦點了大屠殺表示暴怒消耗由85降為70
							local talentID, name, texture, selected, available, spellid, tier, column = GetTalentInfo(5, 3, 1)
							if selected then
								FrameGlowShowOrHide(eaf, (iUnitPower >= 70 ))
							else
								FrameGlowShowOrHide(eaf, (iUnitPower >= 85 ))
							end
						end
						--若為武器專精
						if (GetSpecialization() == 1) then
							FrameGlowShowOrHide(eaf, (iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_RAGE)))
						end
						--若為防護專精
						if (GetSpecialization() == 3) then
							FrameGlowShowOrHide(eaf, (iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_RAGE)))
						end
					else
						FrameGlowShowOrHide(eaf, (iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_RAGE)))
					end
				end

				-- 聖騎聖能達到上限高亮
				if (iPowerType == EA_SPELL_POWER_HOLY_POWER) then
					FrameGlowShowOrHide(eaf, (iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_HOLY_POWER)))
				end

				-- 暗牧瘋狂值達到上限高亮
				if (iPowerType == EA_SPELL_POWER_INSANITY) then
					--若點了殘遺虛無，則狂亂值滿65就高亮
					local talentID, name, texture, selected, available, spellid, tier, column = GetTalentInfo(7, 1, 1)
					if selected then
						FrameGlowShowOrHide(eaf,(iUnitPower >= 65 ))
					else
						FrameGlowShowOrHide(eaf,(iUnitPower >= UnitPowerMax("player",EA_SPELL_POWER_INSANITY)))
					end
				end

				--武僧真氣滿4即高亮
				if (iPowerType == EA_SPELL_POWER_LIGHT_FORCE) then
					FrameGlowShowOrHide(eaf,(iUnitPower >= 4))
				end

				--死騎符能達到上限高亮
				if (iPowerType == EA_SPELL_POWER_RUNIC_POWER) then
					FrameGlowShowOrHide(eaf,(iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_RUNIC_POWER)))
				end

				--術士靈魂碎片達到上限高亮
				if (iPowerType == EA_SPELL_POWER_SOUL_SHARDS) then
					FrameGlowShowOrHide(eaf,(iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_SOUL_SHARDS)))
				end

				--秘法充能達到上限高亮
				if (iPowerType == EA_SPELL_POWER_ARCANE_CHARGES) then
					FrameGlowShowOrHide(eaf,(iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_ARCANE_CHARGES)))
				end

				--星能達到星湧術需求就高亮
				if (iPowerType == EA_SPELL_POWER_LUNAR_POWER) then
					FrameGlowShowOrHide(eaf,(iUnitPower >= 40))
					--FrameGlowShowOrHide(eaf,(iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_LUNAR_POWER)))
				end

				--增強薩、元素薩元能達到上限高亮
				if (iPowerType == EA_SPELL_POWER_MAELSTROM) then
					FrameGlowShowOrHide(eaf,(iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_MAELSTROM)))
				end

				--惡魔獵人魔怒達到上限高亮
				if (iPowerType == EA_SPELL_POWER_FURY) then
					FrameGlowShowOrHide(eaf,(iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_FURY)))
				end

				--惡魔獵人魔痛達到上限高亮
				if (iPowerType == EA_SPELL_POWER_FURY) then
					FrameGlowShowOrHide(eaf,(iUnitPower >=UnitPowerMax("player",EA_SPELL_POWER_PAIN)))
				end
			else
				FrameGlowShowOrHide(eaf, false)
				EA_SpecFrame_Self = false;
				eaf:Hide();
			end
			EventAlert_PositionFrames();
		end
	end
end

-- Speciall Frame: UpdateLifeBloom & OnLifeBloomUpdate, for watching the currently(max-stack) lifebloom of player
function EventAlert_OnLifeBloomUpdate()
	local iFrameIndex = 33763;
	local eaf = _G["EAFrameSpec_"..iFrameIndex];
	if (eaf ~= nil) then
		local EA_timeLeft = 0;
		if (EA_SpecFrame_LifeBloom.ExpireTime ~= nil) then
			EA_timeLeft = EA_SpecFrame_LifeBloom.ExpireTime - GetTime();
		end

		if (EA_timeLeft > 0) then
			if (EA_Config.ShowTimer) then
				EAFun_SetCountdownStackText(eaf, EA_timeLeft, EA_SpecFrame_LifeBloom.Stack, -1);
				if EA_timeLeft < 4 then
				 	eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize+5, "OUTLINE");
					eaf.spellTimer:SetTextColor(1, 0, 0);
				else
				 	eaf.spellTimer:SetFont("Fonts\\FRIZQT__.TTF", EA_Config.TimerFontSize, "OUTLINE");
					eaf.spellTimer:SetTextColor(1, 1, 1);
				end
			end
		else
			EA_SpecFrame_LifeBloom.UnitID = "";
			EA_SpecFrame_LifeBloom.UnitName = "";
			EA_SpecFrame_LifeBloom.ExpireTime = 0;
			EA_SpecFrame_LifeBloom.Stack = 0;
			EA_SpecFrame_Self = false;
			eaf:SetScript("OnUpdate", nil);
			if eaf:IsVisible() then eaf:Hide() end;
			EventAlert_PositionFrames();
		end
	end
end

function EventAlert_UpdateLifeBloom(EA_Unit)
	local iFrameIndex = 33763;
	local fNewToShow = false;
	local eaf = _G["EAFrameSpec_"..iFrameIndex];
	if (eaf ~= nil) then
		if (EA_Unit ~= "") then
			if (EA_Config.ShowFrame == true) then
				EA_Main_Frame:ClearAllPoints();
				EA_Main_Frame:SetPoint(EA_Position.Anchor, UIParent, EA_Position.relativePoint, EA_Position.xLoc, EA_Position.yLoc);
				local prevFrame = "EA_Main_Frame";
				local xOffset = 100 + EA_Position.xOffset;
				local yOffset = 0 + EA_Position.yOffset;
				local SfontName, SfontSize = "", 0;

				for i=1,40 do
					local _, _, count, _, _, expirationTime, unitCaster, _, _, spellID = UnitBuff(EA_Unit, i)
					if (not spellID) then
						break;
					end
					if (spellID == iFrameIndex and unitCaster == "player") then
						local iShiftFormID = GetShapeshiftFormID();
						fNewToShow = false;
						if (iShiftFormID == nil) then
							fNewToShow = true;	-- Non-Lift of tree, single lifebloom
						elseif (iShiftFormID == 2) then -- Life of tree form, multi lifebloom
							if (count > EA_SpecFrame_LifeBloom.Stack) then
								fNewToShow = true;
							elseif (count == EA_SpecFrame_LifeBloom.Stack and expirationTime >= EA_SpecFrame_LifeBloom.ExpireTime) then
								fNewToShow = true;
							end
						end
						if (fNewToShow) then
							EA_SpecFrame_LifeBloom.UnitID = EA_Unit;
							EA_SpecFrame_LifeBloom.UnitName = UnitName(EA_Unit);
							EA_SpecFrame_LifeBloom.ExpireTime = expirationTime;
							EA_SpecFrame_LifeBloom.Stack = count;
						end
						break;
					end
				end

				if (fNewToShow) then
					EA_SpecFrame_Self = true;
					eaf:ClearAllPoints();
					eaf:SetPoint(EA_Position.Anchor, prevFrame, EA_Position.Anchor, -1 * xOffset, -1 * yOffset);
					eaf:SetWidth(EA_Config.IconSize);
					eaf:SetHeight(EA_Config.IconSize);

					if (EA_Config.ShowName == true) then
						eaf.spellName:SetText(EA_SpecFrame_LifeBloom.UnitName);
						SfontName, SfontSize = eaf.spellName:GetFont();
						eaf.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
					else
						eaf.spellName:SetText("");
					end
					eaf:SetScript("OnUpdate", EventAlert_OnLifeBloomUpdate);
					eaf:Show();
				end
				EventAlert_PositionFrames();
			end
		else
			-- print ("fNewToShow = false 1");
			EA_SpecFrame_LifeBloom.UnitID = "";
			EA_SpecFrame_LifeBloom.UnitName = "";
			EA_SpecFrame_LifeBloom.ExpireTime = 0;
			EA_SpecFrame_LifeBloom.Stack = 0;
			EA_SpecFrame_Self = false;
			eaf:SetScript("OnUpdate", nil);
			if eaf:IsVisible() then eaf:Hide() end;
			EventAlert_PositionFrames();
		end
	end
end

-- Speciall Frame: CheckExecution, for checking the health percent of the current target
function EventAlert_CheckExecution()
--[[	bf@178.com 斩杀提示周期动画屏蔽
	EA_Position.Execution = tonumber(EA_Position.Execution)
	if (EA_Position.Execution > 0) then
		local iDead = UnitIsDeadOrGhost("target");
		local iEnemy = UnitIsEnemy("player", "target");
		local iLevel = 3;

		--if EA_Position.PlayerLv2BOSS == true then iLevel = 2 end;

		if ((iDead == false) and (iEnemy == true)) then
			local iLvPlayer, iLvTarget = UnitLevel("player"), UnitLevel("target");
			if ((EA_Position.PlayerLv2BOSS and iLvTarget == -1) or (iLvPlayer >= iLvTarget)) then
				local iHppTarget = (UnitHealth("target") * 100) / UnitHealthMax("target");

				if (iHppTarget <= EA_Position.Execution) then

					if (not iEAEXF_AlreadyAlert) then

						local eaf=_G["EventAlert_ExecutionFrame"]

						eaf:SetAlpha(0.8);
						eaf:Show();
						iEAEXF_FrameCount = 0;
						iEAEXF_Prefraction = 0;
						EAEXF_AnimateOut(eaf);
						iEAEXF_AlreadyAlert = true;
					end
				else
					iEAEXF_AlreadyAlert = false;
				end
			end
		else
			iEAEXF_AlreadyAlert = false;
		end
	end
	]]
end

function EventAlert_Lookup(para1, fullmatch)
	local sFMatch = "";
	local sName = "";
	local iCount = 0;
	local sSpellLink = "";
	local fGoPrint = false;

	if (para1 == nil) then
		for i, v in ipairs(EA_XCMD_CMDHELP["LOOKUP"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		for i, v in ipairs(EA_XCMD_CMDHELP["LOOKUPFULL"]) do
			if i == 1 then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			elseif MoreHelp then
				DEFAULT_CHAT_FRAME:AddMessage(v);
			end
		end
		return;
	end;

	if fullmatch then sFMatch = " / "..EA_XLOOKUP_START2 end;
	DEFAULT_CHAT_FRAME:AddMessage(EA_XLOOKUP_START1..": [\124cffFFFF00"..para1.."\124r]"..sFMatch);
	EAFun_ClearSpellScrollFrame();

	for i=1,1000000 do
		sName = GetSpellInfo(i);
		fGoPrint = false;
		if (sName ~= nil) then
			if (fullmatch) then
				if (sName == para1) then fGoPrint = true end;
			else
				if (strfind(sName, para1)) then fGoPrint = true end;
			end
			if (fGoPrint) then
				sSpellLink = GetSpellLink(i);
				if (sSpellLink ~= nil) then
					iCount = iCount + 1;
					-- DEFAULT_CHAT_FRAME:AddMessage("["..tostring(iCount).."]\124cffFFFF00"..EA_XCMD_DEBUG_P2.."\124r="..tostring(i).." / \124cffFFFF00"..EA_XCMD_DEBUG_P1.."\124r="..sSpellLink);
					EAFun_AddSpellToScrollFrame(i, "");
				end
			end
		end
	end
	EA_Version_Frame:Show();
	DEFAULT_CHAT_FRAME:AddMessage(EA_XLOOKUP_RESULT1..": \124cffFFFF00"..tostring(iCount).."\124r"..EA_XLOOKUP_RESULT2);
end

function EAFun_AddSpellToScrollFrame(spellID, OtherMessage)
	spellID = tonumber(spellID);
	if OtherMessage == nil then OtherMessage = "" end;
	if EA_ShowScrollSpells[spellID] == nil then
		EA_ShowScrollSpells[spellID] = true;
		local EA_name, EA_rank, EA_icon = GetSpellInfo(spellID);
		if EA_name == nil then EA_name = "" end;
		if EA_rank == nil then EA_rank = "" end;

		local f1 = _G["EA_Version_ScrollFrame_Icon_"..spellID];
		if f1 == nil then
			EA_ShowScrollSpell_YPos = EA_ShowScrollSpell_YPos - 25;
			local ShowScrollIcon = CreateFrame("Frame", "EA_Version_ScrollFrame_Icon_"..spellID, EA_Version_ScrollFrame_List);
			--for 7.0
			ShowScrollIcon.texture = ShowScrollIcon:CreateTexture()
			ShowScrollIcon.texture:SetAllPoints(ShowScrollIcon)
			ShowScrollIcon.texture:SetTexture(EA_icon)

			ShowScrollIcon:SetWidth(25);
			ShowScrollIcon:SetHeight(25);
			ShowScrollIcon:SetPoint("TOPLEFT", 0, EA_ShowScrollSpell_YPos);
			-- ShowScrollIcon:SetBackdrop({bgFile = EA_icon});
		else
			if (not f1:IsShown()) then
				EA_ShowScrollSpell_YPos = EA_ShowScrollSpell_YPos - 25;
				f1:SetPoint("TOPLEFT", 0, EA_ShowScrollSpell_YPos);
				f1:Show();
			end
		end

		local framewidth = EA_Version_Frame:GetWidth()+50;
		local f2 = _G["EA_Version_ScrollFrame_EditBox_"..spellID];
		if f2 == nil then
			local ShowScrollEditBox = CreateFrame("EditBox", "EA_Version_ScrollFrame_EditBox_"..spellID, EA_Version_ScrollFrame_List);
			ShowScrollEditBox:SetPoint("TOPLEFT", 30, EA_ShowScrollSpell_YPos);
			ShowScrollEditBox:SetFontObject(ChatFontNormal);
			ShowScrollEditBox:SetWidth(framewidth);
			ShowScrollEditBox:SetHeight(25);
			ShowScrollEditBox:SetMaxLetters(0);
			ShowScrollEditBox:SetAutoFocus(false);
			if (EA_rank == "") then
				-- ShowScrollEditBox:SetText(EA_name.." ["..spellID.."]1".." ["..spellID.."]2".." ["..spellID.."]3".." ["..spellID.."]4".." ["..spellID.."]5".." ["..spellID.."]6".." ["..spellID.."]7".." ["..spellID.."]8".." ["..spellID.."]9"..OtherMessage);
				ShowScrollEditBox:SetText(EA_name.." ["..spellID.."]"..OtherMessage);
			else
				ShowScrollEditBox:SetText(EA_name.."("..EA_rank..") ["..spellID.."]"..OtherMessage);
			end
			local function ShowScrollEditBoxGameToolTip()
				ShowScrollEditBox:SetTextColor(0, 1, 1);
				GameTooltip:SetOwner(ShowScrollEditBox, "ANCHOR_TOPLEFT");
				GameTooltip:SetSpellByID(spellID);
			end
			local function HideScrollEditBoxGameToolTip()
				ShowScrollEditBox:SetTextColor(1, 1, 1);
				ShowScrollEditBox:HighlightText(0,0);
				ShowScrollEditBox:ClearFocus();
				GameTooltip:Hide();
			end
			ShowScrollEditBox:SetScript("OnEnter", ShowScrollEditBoxGameToolTip);
			ShowScrollEditBox:SetScript("OnLeave", HideScrollEditBoxGameToolTip);
		else
			if (not f2:IsShown()) then
				f2:SetPoint("TOPLEFT", 30, EA_ShowScrollSpell_YPos);
				f2:Show();
			end
		end
	end
end

function EAFun_ClearSpellScrollFrame()
	EA_Version_Frame_HeaderText:SetText(EA_XCMD_DEBUG_P0);
	-- EA_Version_ScrollFrame_EditBox:SetText("");
	EA_Version_ScrollFrame_EditBox:Hide();
	table.foreach(EA_ShowScrollSpells,
	function(i, v)
		-- MyPrint ("Clear:["..i.."]");
		local f1 = _G["EA_Version_ScrollFrame_Icon_"..i];
		if f1 ~= nil then
			f1:Hide();
			f1 = nil;
		end
		local f2 = _G["EA_Version_ScrollFrame_EditBox_"..i];
		if f2 ~= nil then
			f2:Hide();
			f2 = nil;
		end
	end)
	EA_ShowScrollSpells = { };
	EA_ShowScrollSpell_YPos = 25;
end

function EAFun_GetCountOfTable(EAItems)
	local iCount = 0;
	if (EAItems ~= nil) then
		for i, v in pairsByKeys(EAItems) do
			iCount = iCount + 1;
		end
	end
	return iCount;
end

local UnitType = {"mouseover","target","focus"}
function EAFun_GetUnitIDByName(EA_UnitName)
	local fNotFound, iIndex = true, 1;
	local sUnitID, sUnitName = "", "";

	if UnitInRaid("player") then
		iIndex = 1;
		while (fNotFound and iIndex <= 40) do
			sUnitID = "raid"..iIndex;
			sUnitName = UnitName(sUnitID);
			if EA_UnitName == sUnitName then fNotFound = false end;
			iIndex = iIndex + 1;
		end
	-- 5.1修改：將GetNumPartyMembers()換成GetNumSubgroupMembers()
	elseif GetNumSubgroupMembers() > 0 then
		iIndex = 1;
		while (fNotFound and iIndex <= 4) do
			sUnitID = "party"..iIndex;
			sUnitName = UnitName(sUnitID);
			if EA_UnitName == sUnitName then fNotFound = false end;
			iIndex = iIndex + 1;
		end
	end

	if (fNotFound) then
		for i=1,#UnitType do
			if UnitName(UnitType[i])==EA_UnitName then
				return UnitType[i];
			end
		end
		return "";
	else
		return sUnitID;
	end
end

function EAFun_HookTooltips()
	hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
		local id = select(10,UnitBuff(...))
		if id then
			self:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			self:Show()
		end
	end)

	hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
		local id = select(10,UnitDebuff(...))
		if id then
			self:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			self:Show()
		end
	end)

	hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
		local id = select(10,UnitAura(...))
		if id then
			self:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			self:Show()
		end
	end)

	hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
		if string.find(link,"^spell:") then
			local id = string.sub(link,7)
			ItemRefTooltip:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			ItemRefTooltip:Show()
		end
	end)

	GameTooltip:HookScript("OnTooltipSetSpell", function(self)
		local id = select(2,self:GetSpell())
		if id then
			self:AddDoubleLine(EX_XCLSALERT_SPELL,id)
			self:Show()
		end
	end)
end

-- For OrderWtd, to sort the order of the buffs/debuffs.
function EAFun_SortCurrBuffs(TypeIndex, EACurrBuffs)
	local TempArray = {};
	local SortArray = {};
	local OrderWtd = 1;
	for Loopi=1, #EACurrBuffs do
		if (TypeIndex == 1) then
			OrderWtd = EA_SPELLINFO_SELF[EACurrBuffs[Loopi]].orderWtd;
		elseif (TypeIndex == 2) then
			OrderWtd = EA_SPELLINFO_TARGET[EACurrBuffs[Loopi]].orderWtd;
		elseif (TypeIndex == 3) then
			OrderWtd = EA_SPELLINFO_SCD[EACurrBuffs[Loopi]].orderwtd;
		end
		if (OrderWtd == nil) then OrderWtd = 1 end;

		if TempArray[OrderWtd] == nil then TempArray[OrderWtd] = {} end;
		table.insert(TempArray[OrderWtd], EACurrBuffs[Loopi]);
	end

	for Loopi=20,1,-1 do
		if TempArray[Loopi] ~= nil then
			for Loopj=1,#TempArray[Loopi] do
				if TempArray[Loopi][Loopj] ~= nil then
					table.insert(SortArray, TempArray[Loopi][Loopj]);
				end
			end
		end
	end

	return SortArray;
end

-- GroupEvent: FireEventCheckHide, Check if to hide this GroupEvent
function EAFun_FireEventCheckHide(self)
	if self.GC.GroupResult then
		self:SetWidth(0);
		self:SetHeight(0);
		self.GC.GroupIconID = 0;
		self.GC.GroupResult = false;
		self.spellName:SetText("");
		self:Hide();
	end
end

-- GroupEvent: FireEventSubCheckResult. The Subcheck changes, so check back to upper level to conclude the final result.
function EAFun_FireEventSubCheckResult(self, iSpells, iChecks)
	local fGroupResult, fSpellResult, fCheckResult = false, true, true;
	local sGroupSpellName, iGroupIconID, sGroupIconPath = "", 0, "";
	local SfontName, SfontSize = "", 0;

	-- SubCheck
	for iIndex,aValue in ipairs(self.GC.Spells[iSpells].Checks[iChecks].SubChecks) do
		if aValue.SubCheckAndOp then
			-- first subcheck must be "AND" operation
			fCheckResult = fCheckResult and aValue.SubCheckResult;
		else
			fCheckResult = fCheckResult or aValue.SubCheckResult;
		end
	end
	self.GC.Spells[iSpells].Checks[iChecks].CheckResult = fCheckResult;

	-- Check
	for iIndex,aValue in ipairs(self.GC.Spells[iSpells].Checks) do
		if aValue.CheckAndOp then
			-- first check must be "AND" operation, too.
			fSpellResult = fSpellResult and aValue.CheckResult;
		else
			fSpellResult = fSpellResult or aValue.CheckResult;
		end
	end
	self.GC.Spells[iSpells].SpellResult = fSpellResult;

	-- Spell
	for iIndex,aValue in ipairs(self.GC.Spells) do
		if aValue.SpellResult then
			fGroupResult = true;
			sGroupSpellName = aValue.SpellName;
			iGroupIconID = aValue.SpellIconID;
			sGroupIconPath = aValue.SpellIconPath;
			break;
		end
	end

	-- Group
	if (fGroupResult) then
		if ((not self.GC.GroupResult) or (self.GC.GroupResult and (self.GC.GroupIconID ~= iGroupIconID)))then
			self.GC.GroupIconID = iGroupIconID;

			--self:SetBackdrop({bgFile = sGroupIconPath});
			--for 7.0
			if not(self.texture) then
				self.texture = self:CreateTexture()
				self.texture:SetAllPoints(self)
			end
			self.texture:SetTexture(sGroupIconPath);

			if (self.GC.IconAlpha ~= nil) then self:SetAlpha(self.GC.IconAlpha) end;
			self:SetPoint(self.GC.IconPoint, UIParent, self.GC.IconRelatePoint, self.GC.LocX, self.GC.LocY);	-- 0, -100
			self:SetWidth(self.GC.IconSize);
			self:SetHeight(self.GC.IconSize);
			self.GC.GroupResult = true;
			if (EA_Config.ShowName == true) then
				self.spellName:SetText(sGroupSpellName);
				SfontName, SfontSize = self.spellName:GetFont();
				self.spellName:SetFont(SfontName, EA_Config.SNameFontSize);
			else
				self.spellName:SetText("");
			end
			self:Show();
		end
	else
		EAFun_FireEventCheckHide(self);
	end
end

-- GroupEvent: GroupFrameUnitDie. If target/focus Unit is died, then notice all UNIT_HEALTH event with this target/focus Unit.
function EventAlert_GroupFrameUnitDie_OnEvent(self, event, ...)
	local iSpells, iChecks, iSubChecks = 0, 0, 0;
	local iGroupIndex = self.GC.GroupIndex;
	local SubCheck = {};
	local sUnitType = ...;
	-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
	if (GC_IndexOfGroupFrame[event] ~= nil) then
		if (GC_IndexOfGroupFrame[event][iGroupIndex] ~= nil) then
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType) then -- "player"
					self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = false;
					EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
				end
			end
		end
	end
	-- end
end

-- GroupEvent: CurrValueCompCfgValue. The 5 ways of comparison.
function EAFun_CurrValueCompCfgValue(CompType, CurrValue, CfgValue)
	local fResult = falase;
	if (CompType == 1) then		-- Curr < Cfg
		if (CurrValue < CfgValue) then fResult = true end;
	elseif (CompType == 2) then	-- Curr <= Cfg
		if (CurrValue <= CfgValue) then fResult = true end;
	elseif (CompType == 3) then	-- Curr = Cfg
		if (CurrValue == CfgValue) then fResult = true end;
	elseif (CompType == 4) then	-- Curr >= Cfg
		if (CurrValue >= CfgValue) then fResult = true end;
	elseif (CompType == 5) then	-- Curr > Cfg
		if (CurrValue > CfgValue) then fResult = true end;
	elseif (CompType == 6) then	-- Curr <> Cfg
		if (CurrValue ~= CfgValue) then fResult = true end;
	elseif (CompType == 7) then	-- Cfg = any
		fResult = true
	end
	return fResult;
end

-- GroupEvent: GroupFrameCheck. The core checking routine for GroupEvent Conditions.
function EventAlert_GroupFrameCheck_OnEvent(self, event, ...)
	local iSpells, iChecks, iSubChecks = 0, 0, 0;
	local iGroupIndex = self.GC.GroupIndex;
	local SubCheck = {};
	local iActiveTalentGroup = 0;
	local fAllUnitMonitor = false;
	local fShowResult = true;

	-- If this GroupCheck is Enabled / Disabled
	if (self.GC.enable ~= nil) then
		if (not self.GC.enable) then
			fShowResult = false;
		end
	end
	-- If the Active-Talent should be checked
	if (fShowResult) then
		if (self.GC.ActiveTalentGroup ~= nil) then
			iActiveTalentGroup = GetSpecialization()
			if (iActiveTalentGroup ~= self.GC.ActiveTalentGroup) then
				fShowResult = false;
			end
		end
	end
	-- If the Hide-On-Leave-of-Combat should be checked
	if (fShowResult) then
		if (self.GC.HideOnLeaveCombat ~= nil) then
			if (self.GC.HideOnLeaveCombat) then
				if (not UnitAffectingCombat("player")) then
					fShowResult = false;
				end
			end
		end
	end
	-- If the Hide-On-Lost-Target should be checked
	if (fShowResult) then
		if (self.GC.HideOnLostTarget ~= nil) then
			if (self.GC.HideOnLostTarget) then
				if (not UnitExists("target")) then
					fShowResult = false;
				end
			end
		end
	end
	local sTempUnitType = "target";
	if ((not UnitExists(sTempUnitType)) or UnitIsCorpse(sTempUnitType) or UnitIsDeadOrGhost(sTempUnitType)) then
		EventAlert_GroupFrameUnitDie_OnEvent(self, "UNIT_HEALTH", sTempUnitType);
	end
	sTempUnitType = "focus";
	if ((not UnitExists(sTempUnitType)) or UnitIsCorpse(sTempUnitType) or UnitIsDeadOrGhost(sTempUnitType)) then
		EventAlert_GroupFrameUnitDie_OnEvent(self, "UNIT_HEALTH", sTempUnitType);
	end

	if (not fShowResult) then
		EAFun_FireEventCheckHide(self);
	else
		if (event == "ACTIVE_TALENT_GROUP_CHANGED") then
			-- If the Active-Talent should be checked
			iActiveTalentGroup = GetSpecialization()
			if (iActiveTalentGroup ~= self.GC.ActiveTalentGroup) then
				fShowResult = false;
				EAFun_FireEventCheckHide(self);
			end
		elseif (event == "PLAYER_REGEN_ENABLED") then
			-- If the Hide-On-Leave-of-Combat should be checked
			if (self.GC.HideOnLeaveCombat ~= nil) then
				if (self.GC.HideOnLeaveCombat) then
					if (UnitAffectingCombat("player")) then
						fShowResult = false;
						EAFun_FireEventCheckHide(self);
					end
				end
			end
		elseif (event == "PLAYER_TARGET_CHANGED") then
			-- If the Hide-On-Lost-Target should be checked
			if (self.GC.HideOnLostTarget ~= nil) then
				if (self.GC.HideOnLostTarget) then
					if (not UnitExists("target")) then
						fShowResult = false;
						EAFun_FireEventCheckHide(self);
					end
				end
			end
		elseif (event == "UNIT_POWER_UPDATE") then
			local sUnitType, sPowerType = ...;

			-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
			-- GC_IndexOfGroupFrame["UNIT_POWER"] = {[1]={Spells=1,Checks=1,SubChecks=1,},};
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType or SubCheck.UnitType == "all") then -- "player"
					if (sPowerType == SubCheck.PowerType) then
						fShowResult = true;
						if (fShowResult) then
							if (SubCheck.CheckCD ~= nil) then
								local iStart, iDuration, iEnable = GetSpellCooldown(SubCheck.CheckCD);
								if (iStart <= 0) or (iStart >= 0 and iDuration <= 1.5) then
									if IsUsableSpell(SubCheck.CheckCD) then
										fShowResult = true
									end
								else
									fShowResult = false;
								end
							end
						end
						if (fShowResult) then
							local iCurrPowerValue, iCheckPowerValue = 0;
							if SubCheck.PowerLessThanValue ~= nil then
								iCurrPowerValue = UnitPower(sUnitType, SubCheck.PowerTypeNum);
								iCheckPowerValue = SubCheck.PowerLessThanValue;
							elseif SubCheck.PowerLessThanPercent ~= nil then
								iCurrPowerValue = (UnitPower(sUnitType, SubCheck.PowerTypeNum) * 100) / UnitPowerMax(sUnitType, SubCheck.PowerTypeNum);
								iCheckPowerValue = SubCheck.PowerLessThanPercent;
							end
							fShowResult = EAFun_CurrValueCompCfgValue(SubCheck.PowerCompType, iCurrPowerValue, iCheckPowerValue);
						end
						self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = fShowResult;
						EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
					end
				end
			end
		elseif (event == "UNIT_HEALTH") then
			local sUnitType = ...;

			-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType or SubCheck.UnitType == "all") then -- "player"
					fShowResult = true;
					if (fShowResult) then
						if (SubCheck.CheckCD ~= nil) then
							local iStart, iDuration, iEnable = GetSpellCooldown(SubCheck.CheckCD);
							if (iStart <= 0) or (iStart >= 0 and iDuration <= 1.5) then
								fShowResult = true;
							else
								fShowResult = false;
							end
						end
					end
					if (fShowResult) then
						local iCurrHealthValue, iCheckHealthValue = 0;
						if SubCheck.HealthLessThanValue ~= nil then
							iCurrHealthValue = UnitHealth(sUnitType);
							iCheckHealthValue = SubCheck.HealthLessThanValue;
						elseif SubCheck.HealthLessThanPercent ~= nil then
							iCurrHealthValue = (UnitHealth(sUnitType) * 100) / UnitHealthMax(sUnitType);
							iCheckHealthValue = SubCheck.HealthLessThanPercent;
						end
						fShowResult = EAFun_CurrValueCompCfgValue(SubCheck.HealthCompType, iCurrHealthValue, iCheckHealthValue);
					end
					self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = fShowResult;
					EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
				end
			end

		elseif (event == "UNIT_AURA") then
			local sUnitType = ...;
			local sAuraFilter = "";

			-- SPEC EVENT FIRED, To check all INDEXD-EVENTCFG about this frame(by GroupIndex).
			for iIndex, aValue in ipairs(GC_IndexOfGroupFrame[event][iGroupIndex]) do
				iSpells = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Spells;
				iChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].Checks;
				iSubChecks = GC_IndexOfGroupFrame[event][iGroupIndex][iIndex].SubChecks;
				SubCheck = self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks];
				if (sUnitType == SubCheck.UnitType or SubCheck.UnitType == "all") then -- "player"
					fShowResult = true;
					if (fShowResult) then
						if (SubCheck.CheckCD ~= nil) then
							local iStart, iDuration, iEnable = GetSpellCooldown(SubCheck.CheckCD);
							if (iStart <= 0) or (iStart >= 0 and iDuration <= 1.5) then
								fShowResult = true;
							else
								fShowResult = false;
							end
						end
					end
					if (fShowResult) then
						sAuraFilter = "";
						if (SubCheck.CastByPlayer ~= nil) then
							if (SubCheck.CastByPlayer) then
								sAuraFilter = "PLAYER";
							end
						end
						if (SubCheck.CheckAuraExist ~= nil) then
							fShowResult = false;
							local sSpellName, sSpellRank = GetSpellInfo(SubCheck.CheckAuraExist);
							if not sSpellName then return end
							local sCurrSpellName, _, iStack, _, _, iExpireTime = UnitBuff(sUnitType, sSpellName, sSpellRank, sAuraFilter);
							if sCurrSpellName ~= nil then
								fShowResult = true;
							else
								sCurrSpellName, _, iStack, _, _, iExpireTime = UnitDebuff(sUnitType, sSpellName, sSpellRank, sAuraFilter);
								if sCurrSpellName ~= nil then
									fShowResult = true;
								end
							end
							-- ToDo: If Exists, Then Check seconds, stacks
							-- Modify: Show When Stack "OR" Remain Time match config value
							if (fShowResult) then
								if (SubCheck.StackCompType ~= nil) then
									fShowResult1 = EAFun_CurrValueCompCfgValue(SubCheck.StackCompType, iStack, SubCheck.StackLessThanValue);
								end
								if (SubCheck.TimeCompType ~= nil) then
									local iLeftTime = iExpireTime - GetTime();
									fShowResult2 = EAFun_CurrValueCompCfgValue(SubCheck.TimeCompType, iLeftTime, SubCheck.TimeLessThanValue);
								end
								fShowResult = fShowResult1 and fShowResult2
							end
						end
						if (SubCheck.CheckAuraNotExist ~= nil) then
							fShowResult = false;
							local sSpellName, sSpellRank = GetSpellInfo(SubCheck.CheckAuraNotExist);
							if not sSpellName then return end
							local sCurrSpellName = UnitBuff(sUnitType, sSpellName, sSpellRank, sAuraFilter);
							if sCurrSpellName == nil then
								sCurrSpellName = UnitDebuff(sUnitType, sSpellName, sSpellRank, sAuraFilter);
								if sCurrSpellName == nil then
									fShowResult = true;
								end
							end
						end
					end
					self.GC.Spells[iSpells].Checks[iChecks].SubChecks[iSubChecks].SubCheckResult = fShowResult;
					EAFun_FireEventSubCheckResult(self, iSpells, iChecks);
				end
			end
		end
	end
end

--[[
	Death Knight
	250 - Blood 血魄
	251 - Frost 冰霜
	252 - Unholy 穢邪
	Druid
	102 - Balance 平衡
	103 - Feral Combat 野性戰鬥
	104 - Guardian 守護者
	105 - Restoration 恢復
	Hunter
	253 - Beast Mastery 獸王
	254 - Marksmanship 射擊
	255 - Survival 生存
	Mage
	62 - Arcane 秘法
	63 - Fire 火焰
	64 - Frost 冰霜
	Monk
	268 - BrewMaster 釀酒(坦)
	269 - WindWalker 風行(近戰DD)
	270 - MistWeaver 織霧(治療)
	Paladin
	65 - Holy ???t 神聖
	66 - Protection 防護
	70 - Retribution 懲戒
	Priest
	256 Discipline 戒律
	257 Holy  神聖
	258 Shadow  暗影
	Rogue
	259 - Assassination 刺殺
	260 - Combat 戰鬥
	261 - Subtlety 敏銳
	Shaman
	262 - Elemental 元素
	263 - Enhancement 增強
	264 - Restoration 恢復
	Warlock
	265 - Affliction 痛苦
	266 - Demonology 惡魔
	267 - Destruction 毀滅
	Warrior
	71 - Arms 武器
	72 - Furry 狂暴
	73 - Protection 防護
--]]
function EventAlert_PlayerSpecPower_Update()
	for p,tblPower in pairs(EA_SpecPower) do
		if (tblPower) then
			tblPower.has = false
		end
	end

	local id = 0;
	local icon = "NONE";

	--取得當前職業專精索引(1~3或4)
	-- local CurrentSpecCode = GetSpecialization()
	--若無職業專精索引表示尚未啟用任一專精
	--若有，則將此索引傳入GetSpecializationInfo()來取得全職業專精唯一代碼
	-- if CurrentSpecCode then id,_,_,icon,_,_ = GetSpecializationInfo(CurrentSpecCode) end

	--取得玩家當前形態的特殊資源
	-- local powerType, powerTypeString = UnitPowerType("player")	--bf@178.com

	--取得玩家姿態或形態
	local shapeindex = GetShapeshiftForm();
	local shapeID = GetShapeshiftFormID();

	--若玩家為戰士表示有怒氣
	if (EA_playerClass == EA_CLASS_WARRIOR) then EA_SpecPower.Rage.has = true 	end
	--若玩家為德魯伊表示有怒氣
	if (EA_playerClass == EA_CLASS_DRUID) 	then EA_SpecPower.Rage.has = true	end

	--若玩家為獵人表示有集中值
	if (EA_playerClass == EA_CLASS_HUNTER) then	EA_SpecPower.Focus.has = true	end

	--若玩家為盜賊表示有能量
	if (EA_playerClass == EA_CLASS_ROGUE) then 	EA_SpecPower.Energy.has = true end
	--若玩家為德魯伊表示有能量
	if (EA_playerClass == EA_CLASS_DRUID) then	EA_SpecPower.Energy.has = true	end
	--若玩家為風行武僧表示有能量
	if (EA_playerClass == EA_CLASS_MONK) then
		--釀酒或風行擁有能量條
		if (id == 268) or (id==269) then
			EA_SpecPower.Energy.has = true
		else
			EA_SpecPower.Energy.has = false
		end
		--7.0只有風僧有真氣
		if (id == 269) then EA_SpecPower.LightForce.has = true end
	end

	--若玩家為死騎，則表示有符文及符能
	if (EA_playerClass == EA_CLASS_DK) then
		EA_SpecPower.RunicPower.has = true;
		EA_SpecPower.Runes.has = true
		if (id == 250 ) then EA_RUNE_TYPE = RUNETYPE_BLOOD end
		if (id == 251 ) then EA_RUNE_TYPE = RUNETYPE_FROST end
		if (id == 252 ) then EA_RUNE_TYPE = RUNETYPE_UNHOLY end
	end

	--7.0開始三系術士資源均統一為靈魂碎片
	if (id == 265) then EA_SpecPower.SoulShards.has = true	end
	if (id == 266) then EA_SpecPower.SoulShards.has = true 	end
	if (id == 267) then EA_SpecPower.SoulShards.has = true 	end

	--若玩家為德魯伊且專精是平衡，則表示有星能
	if (id == 102) then EA_SpecPower.LunarPower.has = true end
	--若玩家為聖騎，則表示有聖能
	if (EA_playerClass == EA_CLASS_PALADIN) then EA_SpecPower.HolyPower.has = true 	end
	--若玩家為盜賊表示擁有連擊點數
	if (EA_playerClass == EA_CLASS_ROGUE) then 	EA_SpecPower.ComboPoint.has = true end
	--若玩家為德魯伊表示擁有連擊點數
	if (EA_playerClass == EA_CLASS_DRUID) then	EA_SpecPower.ComboPoint.has = true end
	--若玩家為恢復德魯伊表示有生命之花
	if (id == 105) then EA_SpecPower.LifeBloom.has = true end
	--若玩家為暗影牧師表示有暗影能量
	if (id == 258) then	EA_SpecPower.Insanity.has = true end
	--若玩家為秘法表示有秘法充能
	if (id == 62) then	EA_SpecPower.ArcaneCharges.has = true end
	--若玩家為增強薩或元素薩表示有元能(漩渦值)
	if (id == 262) then	EA_SpecPower.Maelstrom.has = true end
	if (id == 263) then	EA_SpecPower.Maelstrom.has = true end
	--若玩家為惡魔獵人表示有魔怒,魔痛
	if (EA_playerClass == EA_CLASS_DEMONHUNTER) then
		if (id == 577) then	EA_SpecPower.Fury.has = true end
		if (id == 581) then	EA_SpecPower.Pain.has = true end
	end

	EventAlert_SpecialFrame_Update();
end

function EventAlert_SpecialFrame_Update()
	for k,tblPower in pairs(EA_SpecPower) do
		if (type(tblPower)=="table") then
			if(tblPower.frameindex) then
				for k2,f in pairs(tblPower.frameindex) do
					if ( f and (EA_Config.SpecPowerCheck[k]) and (tblPower.has) ) then
						CreateFrames_SpecialFrames_Show(f)
					else
						CreateFrames_SpecialFrames_Hide(f)
					end
				end
			end
		end
	end
	EventAlert_PositionFrames();
end

--取得法術ID在指定單位身上的BUFF索引
function GetBuffIndexOfSpellID(unit,SID)
	local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, _, nameplateShowAll, timeMod, value1, value2, value3
	for i=1,40 do
			name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, _, nameplateShowAll, timeMod, value1, value2, value3 = UnitBuff(unit,i)
			if (SID == spellID)	then
				return(i)
			end
	end
	return(nil)
end

--取得法術ID在指定單位身上的DEBUFF索引
function GetDebuffIndexOfSpellID(unit,SID)
	local name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, _, nameplateShowAll, timeMod, value1, value2, value3
	for i=1,40 do
		name, icon, count, debuffType, duration, expirationTime, unitCaster, isStealable, nameplateShowPersonal, spellID, canApplyAura, isBossDebuff, _, nameplateShowAll, timeMod, value1, value2, value3 = UnitDebuff(unit,i)
		if (SID == spellID)	then
			return(i)
		end
	end
	return(nil)
end

--在指定框架增加一個隨鼠標顯示的當前光環內容說明
function FrameAppendAuraTip(eaf,unit,SID,gsiIsDebuff)
	if not (EA_Config.ICON_APPEND_SPELL_TIP) then return end
	local index
	if not(gsiIsDebuff) then
		index=GetBuffIndexOfSpellID(unit,SID)
	else
		index=GetDebuffIndexOfSpellID(unit,SID)
	end

	if (index) then
		eaf:EnableMouse()
		eaf:SetScript("OnEnter",function()
			GameTooltip:SetOwner(eaf,"ANCHOR_RIGHT")
			if not(gsiIsDebuff) then
				GameTooltip:SetUnitBuff(unit,index)
			else
				GameTooltip:SetUnitDebuff(unit,index)
			end
		end)
		eaf:SetScript("OnLeave",function()
			GameTooltip:Hide()
		end)
	end
end

--在指定框架增加一個隨鼠標顯示的技能說明
function FrameAppendSpellTip(eaf,spellID)
	if not (EA_Config.ICON_APPEND_SPELL_TIP) then return end
	eaf:EnableMouse()
	eaf:SetScript("OnEnter",function()
		GameTooltip:SetOwner(eaf,"ANCHOR_RIGHT")
		GameTooltip:SetSpellByID(spellID)
	end)
	eaf:SetScript("OnLeave",function()
		GameTooltip:Hide()
	end)
end

function RemoveAllScdCurrentBuff()
	local SpellName
	for k,v in ipairs(EA_ScdCurrentBuffs) do
		SpellName = GetSpellInfo(v)
		if not SpellName then
			local eaf = _G["EAScdFrame_"..v];
			local spellID = tonumber(v);
			eaf:Hide();
			removeBuffValue(EA_ScdCurrentBuffs,v);
			eaf:SetScript("OnUpdate", nil);
			removeBuffValue(EA_ScdCurrentBuffs, spellID);
		end
	end
end

function RemoveSingleSCDCurrentBuff(spellID)
	local eaf = _G["EAScdFrame_"..spellID];
	local spellID = tonumber(spellID);
	eaf:Hide();
	removeBuffValue(EA_ScdCurrentBuffs,spellID);
	eaf:SetScript("OnUpdate", nil);
end

function ShowAllScdCurrentBuff()
	for k,v in ipairs(EA_ScdCurrentBuffs) do
		_G["EAScdFrame_"..v]:Show();
	end
end

function HideAllScdCurrentBuff()
	for k,v in ipairs(EA_ScdCurrentBuffs) do
		_G["EAScdFrame_"..v]:Hide();
	end
end

function FrameShowOrHide(f,boolShow)
	if boolShow then
		f:Show()
	else
		f:Hide()
	end
end

function FrameGlowShowOrHide(eaf,boolShow)
	if boolShow then
		if not(eaf.overgrow) then
			if LibStub("LibButtonGlow-1.0") then
				LibStub("LibButtonGlow-1.0").ShowOverlayGlow(eaf)
			else
				ActionButton_ShowOverlayGlow(eaf)	--bf@178.com
			end
			eaf.overgrow = true
		end
	else
		if (eaf.overgrow) then
			if LibStub("LibButtonGlow-1.0") then
				LibStub("LibButtonGlow-1.0").HideOverlayGlow(eaf)
			else
				ActionButton_HideOverlayGlow(eaf)	--bf@178.com
			end
			eaf.overgrow = false
		end
	end
end

function EA_IfPrint(flag,...)
	if (flag) then
		print(...)
	end
end

local iEAEXF_AlreadyAlert = false;
local iEAEXF_FrameCount = 0;
local iEAEXF_Prefraction = 0;
local iEAEXF_totalTime = 1;
local iEAEXF_MaxCount = 19;

local function EAEXF_AnimAlpha(self, fraction)
	if iEAEXF_Prefraction == 0 then iEAEXF_Prefraction = fraction end;
	local iAlpha = self:GetAlpha();
	if iEAEXF_Prefraction >= fraction + iEAEXF_totalTime/iEAEXF_MaxCount then
		iEAEXF_FrameCount = iEAEXF_FrameCount + 1;
		if iEAEXF_FrameCount >= iEAEXF_MaxCount then iEAEXF_FrameCount = iEAEXF_MaxCount end;
		self:SetBackdrop({bgFile = "Interface\\AddOns\\EventAlertMod\\Images\\Seed"..iEAEXF_FrameCount});
		iAlpha = iAlpha - (1/iEAEXF_MaxCount)
		iEAEXF_Prefraction = fraction;
	end
	if iAlpha < 0 then iAlpha = 0 end
	return iAlpha;
end

local EAEXFrameAnimTable = {
	totalTime = iEAEXF_totalTime,
	updateFunc = "SetAlpha",
	getPosFunc = EAEXF_AnimAlpha,
}

function EAEXF_AnimFinished(self)
	self:Hide();
end

function EAEXF_AnimateOut(self)
	SetUpAnimation(self, EAEXFrameAnimTable, EAEXF_AnimFinished, true);
end

local function EASCDFrame_AnimSize(self, fraction)
	local iAlpha = self:GetAlpha();
	local iSize = self:GetWidth();
	self:SetSize(iSize+1, iSize+1);
	return iAlpha-0.02;
end

local EASCDFrameAnimTable = {
	totalTime = 0.5,
	updateFunc = "SetAlpha",
	getPosFunc = EASCDFrame_AnimSize,
}

function EASCDFrame_AnimateOut(self)
	SetUpAnimation(self, EASCDFrameAnimTable, EASCDFrame_AnimFinished, true)
end

function EASCDFrame_AnimFinished(self)
	self:Hide()
end

EA_EventList = {
		["PLAYER_ENTERING_WORLD"]		=EventAlert_PLAYER_ENTERING_WORLD,
		["PLAYER_DEAD"]					=EventAlert_PLAYER_ENTERING_WORLD,

		["PLAYER_ENTER_COMBAT"]			=EventAlert_PLAYER_ENTER_COMBAT,
		["PLAYER_REGEN_DISABLED"]		=EventAlert_PLAYER_ENTER_COMBAT,

		["PLAYER_LEAVE_COMBAT"]			=EventAlert_PLAYER_LEAVE_COMBAT,
		["PLAYER_REGEN_ENABLED"]		=EventAlert_PLAYER_LEAVE_COMBAT,

		["PLAYER_TALENT_UPDATE"]		=EventAlert_PLAYER_TALENT_UPDATE,
		["ACTIVE_TALENT_GROUP_CHANGED"] =EventAlert_PLAYER_TALENT_UPDATE,
		["UPDATE_SHAPESHIFT_FORM"]		=EventAlert_PLAYER_TALENT_UPDATE,

		["PLAYER_TARGET_CHANGED"]		=EventAlert_TARGET_CHANGED,

		["COMBAT_LOG_EVENT_UNFILTERED"]	=EventAlert_COMBAT_LOG_EVENT_UNFILTERED,

		["SPELL_UPDATE_COOLDOWN"]		=EventAlert_SPELL_UPDATE_COOLDOWN,
		["SPELL_UPDATE_CHARGES"]		=EventAlert_SPELL_UPDATE_COOLDOWN,

		["SPELL_UPDATE_USABLE"]			=EventAlert_SPELL_UPDATE_USABLE,

		["UNIT_AURA"]					=EventAlert_UNIT_AURA,

		["UNIT_POWER_UPDATE"]			=EventAlert_UNIT_POWER,
		["UNIT_POWER_FREQUENT"]			=EventAlert_UNIT_POWER,

		["RUNE_POWER_UPDATE"]			=EventAlert_UpdateRunes,

		["SPELL_ACTIVATION_OVERLAY_GLOW_SHOW"] = EventAlert_GlowShow,		--bf@178.com

		["UNIT_SPELLCAST_SUCCEEDED"]	= EventAlert_UNIT_SPELLCAST_SUCCEEDED,

		["PLAYER_TOTEM_UPDATE"]			= EventAlert_UNIT_PLAYER_TOTEM_UPDATE,
};

EA_EventList_COMBAT_LOG_EVENT_UNFILTERED = {
		["SPELL_AURA_REFRESH"]		= EventAlert_COMBAT_LOG_EVENT_SPELL_AURA_REFRESH,
		["SPELL_SUMMON"]			= EventAlert_COMBAT_LOG_EVENT_SPELL_SUMMON,
}

EA_SpecPower = {
	ComboPoint	= {
		powerId,
		powerType = "COMBO_POINTS",
		func=EventAlert_UpdateComboPoint,
		has,
		frameindex = {1000000},
	},
	Mana 		= {
		powerId,
		powerType = "",
		func,
		has,
		frameindex={},
	},
	Rage 		= {
		powerId=EA_SPELL_POWER_RAGE,
		powerType = "RAGE",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000010},
	},
	Focus 		= {
		powerId=EA_SPELL_POWER_FOCUS,
		powerType = "FOCUS",
		func=EventAlert_UpdateFocus,
		has,
		frameindex = {1000020,1000021},
	},
	Energy	 	= {
		powerId=EA_SPELL_POWER_ENERGY,
		powerType = "ENERGY",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000030},
	},
	Runes 		= {
		powerId=EA_SPELL_POWER_RUNES,
		powerType = "RUNES",
		func=EventAlert_UpdateRunes,
		has,
		frameindex={1000051,1000052,1000053,1000054,1000055,1000056},
	},
	RunicPower	= {
		powerId=EA_SPELL_POWER_RUNIC_POWER,
		powerType = "RUNIC_POWER",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000060},
	},
	SoulShards	= {
		powerId=EA_SPELL_POWER_SOUL_SHARDS,
		powerType = "SOUL_SHARDS",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000070},
	},
	LunarPower	= {
		powerId=EA_SPELL_POWER_LUNAR_POWER,
		powerType = "LUNAR_POWER",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000080},
	},
	HolyPower	= {
		powerId=EA_SPELL_POWER_HOLY_POWER,
		powerType = "HOLY_POWER",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000090},
	},
	DarkForce	= {
		powerId,
		powerType = "",
		func,
		has,
		frameindex={},
	},
	Maelstrom	= {
		powerId=EA_SPELL_POWER_MAELSTROM,
		powerType = "MAELSTROM",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000110},
	},
	LightForce	= {
		powerId=EA_SPELL_POWER_LIGHT_FORCE,
		powerType = "CHI",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000120},
	},
	Insanity	= {
		powerId=EA_SPELL_POWER_INSANITY,
		powerType = "INSANITY",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000130},
	},
	BurningEmbers = {
		powerId=EA_SPELL_POWER_BURNING_EMBERS,
		powerType = "BURNING_EMBERS",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000140},
	},
	DemonicFury	= {
		powerId=EA_SPELL_POWER_DEMONIC_FURY,
		powerType = "DEMONIC_FURY",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000150},
	},
	ArcaneCharges= {
		powerId=EA_SPELL_POWER_ARCANE_CHARGES,
		powerType = "ARCANE_CHARGES",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000160},
	},
	Fury		= {
		powerId = EA_SPELL_POWER_FURY,
		powerType = "FURY",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000170},
	},
	Pain		= {
		powerId=EA_SPELL_POWER_PAIN,
		powerType = "PAIN",
		func=EventAlert_UpdateSinglePower,
		has,
		frameindex = {1000180},
	},
	LifeBloom	= {
		powerId,
		powerType = "",
		func=EventAlert_UpdateLifeBloom,
		has,
		frameindex = {33763},
	},
}

function EventAlert_Toggle(toggle)
	if toggle then
		for k, v in pairs(EA_EventList) do
			EA_Main_Frame:RegisterEvent(k)
		end
		EA_Main_Frame:Show();
	else
		for k, v in pairs(EA_EventList) do
			EA_Main_Frame:UnregisterEvent(k)
		end
		EA_Main_Frame:Hide();
	end
end
