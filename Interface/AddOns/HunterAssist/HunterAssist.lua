--===================================================
-- HunterAssist - ver 1.0
-- 作者: 独孤傲雪
-- 日期: 2007 - 2008
-- 描述: 提供一系列猎人的辅助功能
-- 版权所有: 艾泽拉斯国家地理
--===================================================
local _
HunterAssist = BLibrary("BEvent");
HunterAssist.H = BLibrary("BHook");
local __H = HunterAssist;

local HunterAssist_Enabled = false;

local debugFlag= false
local printOrg = print
local function print(...)
	if debugFlag then
		printOrg(...)
	end
end

---------------------
-- 自动射击进度条
---------------------
function HunterAssistCasteBar_OnLoad(self)
	RegisterForSaveFrame(self);

	self:SetMinMaxValues(0, 1);
	self:SetValue(1);
end

local function __HunterAssistCasteBar_FlashBar()
	if not HunterAssistCasteBar:IsVisible() then
		HunterAssistCasteBar:Hide();
	end
	if HunterAssistCasteBar:IsShown() then
		local __min, __max = HunterAssistCasteBar:GetMinMaxValues();
		HunterAssistCasteBar:SetValue(__max);
		HunterAssistCasteBar:SetStatusBarColor(0.0, 1.0, 0.0);
		HunterAssistCasteBarSpark:Hide();
		HunterAssistCasteBarFlash:SetAlpha(0.0);
		HunterAssistCasteBarFlash:Show();
		HunterAssistCasteBar.__casting = nil;
		HunterAssistCasteBar.__flash = 1;
		HunterAssistCasteBar.__fadeOut = 1;
	end
end

local function __HunterAssistCasteBar_Cast(__spell)
	if (__spell and __spell == 75) then
		local __min, __max = GetTime();
		local spellName = GetSpellInfo(__spell)
		__max = __min + UnitRangedDamage("player");
		HunterAssistCasteBar:SetStatusBarColor(1.0, 0.7, 0.0);
		HunterAssistCasteBar:SetMinMaxValues(__min, __max);
		HunterAssistCasteBar:SetValue(__min);
		HunterAssistCasteBar:SetAlpha(1.0);
		HunterAssistCasteBar.__casting = 1;
		HunterAssistCasteBar.__fadeOut = nil;
		HunterAssistCasteBarTextLeft:SetText(spellName);
		HunterAssistCasteBarSpark:Show();
		if not HunterAssistCasteBar:IsShown() then
			HunterAssistCasteBar:Show();
		end
	end
end

function __H:STOP_AUTOREPEAT_SPELL()
	__HunterAssistCasteBar_FlashBar();
end

function __H:PLAYER_LOGIN()
	self:STOP_AUTOREPEAT_SPELL();
end

function __H:PLAYER_ENTERING_WORLD()
	self:STOP_AUTOREPEAT_SPELL();
end

function HunterAssistCasteBar_OnUpdate(self)
	if (not HunterAssist_Enabled) then
		return;
	end

	local __min, __max = HunterAssistCasteBar:GetMinMaxValues();
	if self.__casting then
		local __status = GetTime();
		if __status > __max then
			__status = __max;
		end
		HunterAssistCasteBarTextRight:SetText(format("%0.1f",__max-__status));
		HunterAssistCasteBar:SetValue(__status);
		HunterAssistCasteBarFlash:Hide();
		local __sparkPosition = ((__status - __min) / (__max - __min)) * 195;
		if __sparkPosition < 0 then
			__sparkPosition = 0;
		end
		HunterAssistCasteBarSpark:SetPoint("CENTER", HunterAssistCasteBar, "LEFT", __sparkPosition, 0);
	elseif self.__flash then
		local alpha = HunterAssistCasteBarFlash:GetAlpha() + CASTING_BAR_FLASH_STEP;
		if alpha < 1 then
			HunterAssistCasteBarFlash:SetAlpha(alpha);
		else
			HunterAssistCasteBarFlash:SetAlpha(1.0);
			self.__flash = nil;
		end
	elseif self.__fadeOut then
		local alpha = self:GetAlpha() - CASTING_BAR_ALPHA_STEP;
		if alpha > 0 then
			self:SetAlpha(alpha);
		else
			self.__fadeOut = nil;
			self:Hide();
		end
	end
end

function HunterAssistBar_Toggle(__switch)
	if (__switch) then
		__H:RegisterEvent("STOP_AUTOREPEAT_SPELL");
		__H:RegisterEvent("PLAYER_REGEN_DISABLED");
		__H:RegisterEvent("PLAYER_REGEN_ENABLED");
		__H:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
		__H:RegisterEvent("PLAYER_LOGIN");
		__H:RegisterEvent("PLAYER_ENTERING_WORLD");
		HunterAssist_Enabled = true;
	else
		__H:UnregisterEvent("STOP_AUTOREPEAT_SPELL");
		__H:UnregisterEvent("PLAYER_LOGIN");
		__H:UnregisterEvent("PLAYER_ENTERING_WORLD");
		__HunterAssistCasteBar_FlashBar();

		HunterAssist_Enabled = false;
	end
end

function HunterAssistCasteBar_AjustPosition()
	if HunterAssistCasteBarMove:IsVisible() then
		HunterAssistCasteBarMove:Hide()
		HunterAssistCasteBar:Hide()
	else
		HunterAssistCasteBarMove:Show()
		HunterAssistCasteBar:Show()
		HunterAssistCasteBar:SetAlpha(1)
		HideUIPanel(ModManagementFrame);
	end
end

-------------------
-- 自动取消猎豹守护 thanks to zHunterMod
-------------------
local groupmate = bit.bor(
	COMBATLOG_OBJECT_AFFILIATION_MINE,
	COMBATLOG_OBJECT_AFFILIATION_PARTY,
	COMBATLOG_OBJECT_REACTION_FRIENDLY,
	COMBATLOG_OBJECT_CONTROL_PLAYER,
	COMBATLOG_OBJECT_CONTROL_NPC,
	COMBATLOG_OBJECT_TYPE_PLAYER,
	COMBATLOG_OBJECT_TYPE_PET,
	COMBATLOG_OBJECT_TYPE_GUARDIAN,
	COMBATLOG_OBJECT_TYPE_OBJECT);

local function UnitIsA(unitFlags, flagType)
	if (bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_AFFILIATION_MASK) > 0 and
	bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_REACTION_MASK) > 0 and
	bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_CONTROL_MASK) > 0 and
	bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_TYPE_MASK) > 0)
	or bit.band(bit.band(unitFlags, flagType), COMBATLOG_OBJECT_SPECIAL_MASK) > 0 then
		return true
	end
	return false
end

function __H:AntiDaze(guid)
	local buffID = self:IsBuffActive(HUNTERASSIST_ASPECT_ASPECT_PACK);
	if (guid == UnitGUID("player")) then
		buffID = self:IsBuffActive(HUNTERASSIST_ASPECT_CHEETAH);
	end
	if (buffID and type(buffID) == "number" and buffID >= 0) then
		CancelUnitBuff("player", buffID);
	end
end

function HunterAssistDaze_Toggle(__switch)
	if (__switch) then
		__H:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	else
		__H:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end
end

function __H:COMBAT_LOG_EVENT_UNFILTERED(...)
	local timestamp, subevent, _, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags,_,spellName, spellSchool, auraType = CombatLogGetCurrentEventInfo()
	if subevent == "SPELL_AURA_APPLIED" or subevent == "SPELL_AURA_APPLIED_DOSE" then
		if (UnitIsA(destFlags, groupmate)) then
			if (auraType == "DEBUFF" and spellName == HUNTERASSIST_ASPECT_DAZED) then
				self:AntiDaze(destGUID);
			end
		end
	end
end

function __H:SPELL_AURA_APPLIED_DOSE( ...)
	self:SPELL_AURA_APPLIED( ...);
end

-------------------
-- 自动切换追踪 - 根据当前目标的类型改变追踪技能
-------------------
local enable_tracking = true;
local tracking = {};
local orig_tracking_id = nil;
local track_talent;
local creature = {
	[HUNTERASSIST_BEAST] = "Beast";
	[HUNTERASSIST_HUMANOID] = "Humanoid";
	[HUNTERASSIST_UNDEAD] = "Undead";
	[HUNTERASSIST_GIANT] = "Giant";
	[HUNTERASSIST_ELEMENTAL] = "Elemental";
	[HUNTERASSIST_DEMON] = "Demon";
	[HUNTERASSIST_DRAGONKIN] = "Dragonkin";
};
local ignor_tracking_buff = {
	["player"] = {5384, 13481},
	["target"] = {13481}
};

function __H:UpdateTrackTalent()
	track_talent=true
	--Terry09-10-14: we want auto-tracking to work regardless talent
--[[	local name, iconTexture, tier, column, rank, maxRank, isExceptional, meetsPrereq  = GetTalentInfo(3, 1);
	if (rank and rank >= 1) then
		track_talent = true;
	else
		track_talent = false;
	end]]
end

function __H:UpdateTrackingID()
	-- for id = 1, GetNumTrackingTypes() do
		-- local name, texture, active, category = GetTrackingInfo(id);
		-- if ( name == GetSpellInfo(1494) ) then
			-- tracking["Beast"] = id;
		-- elseif ( name == GetSpellInfo(19883) )then
			-- tracking["Humanoid"] = id;
		-- elseif ( name == GetSpellInfo(19884) ) then
			-- tracking["Undead"] = id;
		-- elseif ( name == GetSpellInfo(19882) ) then
			-- tracking["Giant"] = id;
		-- elseif ( name == GetSpellInfo(19880) ) then
			-- tracking["Elemental"] = id;
		-- elseif ( name == GetSpellInfo(19878) ) then
			-- tracking["Demon"] = id;
		-- elseif ( name == GetSpellInfo(19879) ) then
			-- tracking["Dragonkin"] = id;
		-- end
	-- end
end

function __H:GetCurTrackingID()
	-- local textureID = GetTrackingTexture();
	-- if textureID then
		-- return textureID;
	-- end
	return false;
end

function __H:CanTracking()
	local spellName = GetSpellInfo(19883);
	local start, duration, enabled = GetSpellCooldown(spellName);
	if (duration == 0) then
		return true;
	else
		return false;
	end
end

local function delayTracking(trackingID)
	if (trackingID > 0 and __H:GetCurTrackingID() ~= tracingID and InCombatLockdown() and not __H:UnitHasIgnoreBuff() ) then
		SetTracking(trackingID);
	end
end

function __H:CastTracking()
	if (not track_talent) then return end

	local creatureType = UnitCreatureType("target");
	local trackingID = 0;
	if (creatureType and creature[creatureType]) then
		if (UnitCanAttack("player", "target") and not UnitIsDeadOrGhost("target")) then
			trackingID = tracking[creature[creatureType]] or 0;
		end
	end

	if (trackingID > 0 and self:GetCurTrackingID() ~= trackingID) then
		if (not self:UnitHasIgnoreBuff() and self:CanTracking()) then
			SetTracking(trackingID);
		else
			BigFoot_DelayCall(delayTracking, 1.5, trackingID);	-- GCD
		end
	end
end

function __H:OnSkillChange()
	-- self:UpdateTrackingID();
end

function __H:OnTalentChange()
	self:UpdateTrackTalent();
end

function __H:PLAYER_REGEN_DISABLED()
	if HunterAssistCasteBarMove:IsVisible() then
		HunterAssistCasteBarMove:Hide();
	end

	orig_tracking_id = self:GetCurTrackingID();
	if enable_tracking then
		self:CastTracking();
	end

end

function __H:UnitHasIgnoreBuff()
	local spellName, debuffName;
	local i = 1;
	if (ignor_tracking_buff.player) then
		local buffName = UnitAura("player", i,"HELPFUL");
		while (buffName) do
			for k, v in pairs(ignor_tracking_buff.player) do
				spellName = GetSpellInfo(v);
				if (buffName == spellName) then
					return true;
				end
			end
			i = i +1;
			buffName = UnitAura("player", i,"HELPFUL");
		end
	end
	if (ignor_tracking_buff.target) then
		i = 1;
		debuffName = UnitAura("target", i, "HARMFUL|PLAYER");
		while (debuffName) do
			for k, v in ipairs(ignor_tracking_buff.target) do
				spellName = GetSpellInfo(v);
				if (debuffName == spellName) then
					return true;
				end
			end
			i = i +1;
			debuffName = UnitAura("target", i, "HARMFUL|PLAYER");
		end
	end
	return false;
end

local function HunterAssist_ReTracking()
	if (enable_tracking and track_talent and orig_tracking_id and orig_tracking_id ~= __H:GetCurTrackingID() and not InCombatLockdown()) then
		if (__H:UnitHasIgnoreBuff() or not __H:CanTracking()) then
			BigFoot_DelayCall(HunterAssist_ReTracking, 0.5);
		else
			SetTracking(orig_tracking_id);
		end
		orig_tracking_id = nil;
	end
end

function __H:PLAYER_REGEN_ENABLED()
	__HunterAssistCasteBar_FlashBar();
	HunterAssist_ReTracking();
end

function HunterAssistTracking_Toogle(switch)
	-- __H:UpdateTrackingID();
	__H:UpdateTrackTalent();
	if (switch) then
		enable_tracking = true;
		-- __H:RegisterEvent("CHAT_MSG_SKILL", "OnSkillChange");
		__H:RegisterEvent("CHARACTER_POINTS_CHANGED",  "OnTalentChange");
		__H:RegisterEvent("PLAYER_REGEN_DISABLED");
		__H:RegisterEvent("PLAYER_REGEN_ENABLED");
	else
		enable_tracking = false;
		__H:UnregisterEvent("CHAT_MSG_SKILL");
		__H:UnregisterEvent("CHARACTER_POINTS_CHANGED");
	end
end

-- function HunterAssist_Toggle(__switch)
	-- HunterAssistBar_Toggle(__switch);
	-- HunterAssistDaze_Toggle(__switch);
	-- HunterAssistTracking_Toogle(__switch);
-- end
-------------------
-- AspectBar - 守护动作条
-------------------

local aspectSpellName = {
	"灵猴守护",		-- 灵猴守护
	"雄鹰守护",		-- 雄鹰守护
	"龙鹰守护",		-- 龙鹰守护(灵猴+雄鹰)
	"猎豹守护",		-- 猎豹守护
	"豹群守护",		-- 豹群守护
	"野兽守护",		-- 野兽守护
	"野性守护",		-- 野性守护
	"蝰蛇守护",		-- 蝰蛇守护
};
local aspectInfo = {};
local aspectNum = 0;
local aspectButtons= {};

--check whether the player knows spell, passed by name
function __H:IsSpellLearned(spellName)
	if not spellName then return end
	print("check spell learned")
	local i = 1;
	local spell = GetSpellInfo(i, BOOKTYPE_SPELL);
	while spell do
		if (spellName == spell) then
			return i
		end
		i = i + 1
		spell = GetSpellInfo(i, BOOKTYPE_SPELL);
	end
end

function __H:UpdateAspectInfo()
	print("update aspect info")
	local name, rank, icon, bookID
	local num = 0;
	for _, val in ipairs(aspectSpellName) do
		name, rank, icon = GetSpellInfo(val);
		bookID = self:IsSpellLearned(name)
		if (name and bookID) then
			num = num + 1;
			aspectInfo[num] = aspectInfo[num] or {};
			aspectInfo[num]["spellName"] = name;
			aspectInfo[num]["spellIcon"] = icon;
			aspectInfo[num]["spellRank"] = rank;
			aspectInfo[num]["bookID"] = bookID;
		end
	end
	aspectNum = num;
end

function __H:CreateAspectBar()
	print("create aspect bar")
	if (#aspectButtons > 0) then
		return;
	end

	local button;
	for i=1, NUM_STANCE_SLOTS, 1 do
		button = CreateFrame("CheckButton", "HuterAssistAspectButton" .. i, StanceBarFrame, "SecureActionButtonTemplate, ActionButtonTemplate");
		button:SetHeight(30);
		button:SetWidth(30);
		button:RegisterForClicks("AnyUp");
		button:SetPoint("CENTER", _G["StanceButton" .. i], "CENTER", 0, 0);
		button:SetNormalTexture(nil);
		button:SetAttribute("type", "spell");
		local ssb = _G["StanceButton" .. i];
		_G["StanceButton" .. i] = button;			-- 隐藏ShapshiftButton
		button:SetFrameLevel(ssb:GetFrameLevel() + 2);
		button:SetScript("OnEnter", function(this)
			if ( GetCVar("UberTooltips") == "1" ) then
				GameTooltip_SetDefaultAnchor(GameTooltip, this);
			else
				GameTooltip:SetOwner(this, "ANCHOR_RIGHT");
			end
			local bookID = aspectInfo[i]["bookID"];
			if bookID then
				GameTooltip:SetSpellBookItem( bookID, BOOKTYPE_SPELL);
				GameTooltip:Show();
			end
		end);
		button:SetScript("OnLeave", function()
			GameTooltip:Hide();
		end);

		button.cooldown = _G[button:GetName().."Cooldown"]
		button.icon = _G[button:GetName().."Icon"]

		tinsert(aspectButtons,button)

		button:Hide();
		ssb:Hide();
	end
	hooksecurefunc("UIParent_ManageFramePositions", function()
		BigFoot_DelayCall(function()
			PetActionBar_UpdatePositionValues();
			PetActionBarFrame.slideTimer=nil;
			PetActionBarFrame:ClearAllPoints();
			PetActionBarFrame:SetPoint("TOPLEFT", PetActionBarFrame:GetParent(), "BOTTOMLEFT", PETACTIONBAR_XPOS, PETACTIONBAR_YPOS);
		end,
		0.5
		)
	end);

	StanceBarFrame:SetScript("OnShow",function()
		BFSecureCall("UIParent_ManageFramePositions")
	end)
	StanceBarFrame:SetScript("OnHide",function()
		BFSecureCall("UIParent_ManageFramePositions")
	end)

	StanceBarFrame:Show()
end

local function HunterAssist_GetNumShapeshiftForms(origfunc)
	print("get shapeshift num")
	local num = aspectNum or 0;
	num = (num > 0 and num) or origfunc();
	return num;
end

function __H:GetInfoFromID(buttonID)
	print("get info from id")
	if (aspectInfo[buttonID]) then
		return aspectInfo[buttonID].spellIcon, aspectInfo[buttonID].spellName;
	else
		return nil, nil;
	end
end

function __H:IsBuffActive(name)
	print("check if buff is active")

	local i = 1;
	local buffName = UnitBuff("player", i);
	while buffName do
		if (buffName == name) then
			return i;
		end
		i = i + 1;
		buffName = UnitBuff("player", i);
	end
end

local function HunterAssist_GetShapeshiftFormInfo(buttonId)
	print("get shapeshift form info")

	local texture, name, isActive, isCastable;
	texture, name = __H:GetInfoFromID(buttonId);
	if name then
		isActive = __H:IsBuffActive(name);
		isCastable = true;
	end
	return texture, name, isActive, isCastable;
end

local function HunterAssist_GetShapeshiftForm(origfunc, var)
	print("check if getshapshiftform ")

	local texture, name, isActive, isCastable;
	for i=1, NUM_STANCE_SLOTS, 1 do
		texture, name, isActive, isCastable = HunterAssist_GetShapeshiftFormInfo(i);
		if isActive then
			return i;
		end
	end
end

function HunterAssist_GetShapeshiftFormCooldown(buttonId)
	print("get shapshift form cooldown")
	local texture, name = __H:GetInfoFromID(buttonId);
	return GetSpellCooldown(name);
end

function __H:AspectButtonUpdateActive()
	print("get aspect button active")
	local numForms = GetNumShapeshiftForms();
	local isActive
	for i=1, numForms do
		button = aspectButtons[i];
		_,_, isActive,_ = HunterAssist_GetShapeshiftFormInfo(i);
		if isActive then
			button:SetChecked(true);
		else
			button:SetChecked(false);
		end
	end
end

function __H:AspectButtonUpdate()
	print("aspect button update")
	local numForms = GetNumShapeshiftForms();
	local texture, name, isActive, isCastable;
	local button, icon, cooldown, ssb;
	local start, duration, enable;
	StanceBar_Update();
	for i = 1, NUM_STANCE_SLOTS do
		button = aspectButtons[i];
		icon = button.icon;
		if ( i <= numForms ) then
			texture, name, isActive, isCastable = HunterAssist_GetShapeshiftFormInfo(i);
			icon:SetTexture(texture);

			if isCastable then
				icon:SetVertexColor(1.0, 1.0, 1.0);
			else
				icon:SetVertexColor(0.4, 0.4, 0.4);
			end

			button:SetAttribute("spell", name);
			button:SetNormalTexture(nil);
			button:Show();
		else
			button:Hide();
		end
	end
end

function __H:UpdateAspectCooldown()
	print("aspect cooldown update")

	local numForms = GetNumShapeshiftForms();
	local start, duration, enable, cooldown;
	for i=1, numForms do
		cooldown = aspectButtons[i] and aspectButtons[i].cooldown;
		start, duration, enable = HunterAssist_GetShapeshiftFormCooldown(i);
		if (cooldown and start and duration) then
			CooldownFrame_SetTimer(cooldown, start, duration, enable);
		end
	end
end

function __H:UNIT_AURA(unit)
	print("unit aura update")
	if (unit == "player") then
		self:AspectButtonUpdateActive();
	end
end

function __H:LEARNED_SPELL_IN_TAB()
	print("learn spell in tab")

	self:UpdateAspectInfo();
	self:AspectButtonUpdate();
end

function __H:ACTIONBAR_UPDATE_USABLE()
--	print("action bar update usable")

--	self:AspectButtonUpdate();
end

function __H:ACTIONBAR_UPDATE_COOLDOWN()
--	print("update action cooldown")

--	self:UpdateAspectCooldown();
end

function __H:UPDATE_BINDINGS()
	print("update bindings")

	local numForms = GetNumShapeshiftForms();
	ClearOverrideBindings(StanceBarFrame);
	for i = 1, numForms do
		local button = getglobal("HuterAssistAspectButton"..i);
		local key1, key2 = GetBindingKey("StanceButton"..i);
		if (key1) then
			SetOverrideBindingClick(StanceBarFrame, true, key1, "HuterAssistAspectButton"..i);
		end
		if (key2) then
			SetOverrideBindingClick(StanceBarFrame, true, key2, "HuterAssistAspectButton"..i);
		end
	end
end

local function HunterAssistAspect_Hook(switch)
	print("aspect hook")

	if (switch) then
		__H.H:Hook("GetNumShapeshiftForms", HunterAssist_GetNumShapeshiftForms);
		__H.H:Hook("GetShapeshiftForm", HunterAssist_GetShapeshiftForm);
	else
		__H.H:Unhook("GetNumShapeshiftForms");
		__H.H:Unhook("GetShapeshiftForm");
	end
end

local function HunterAssistAspect_Event(switch)
	print("aspect register event")
	if (switch) then
		__H:RegisterEvent("UNIT_AURA");
		__H:RegisterEvent("LEARNED_SPELL_IN_TAB");
		__H:RegisterEvent("ACTIONBAR_UPDATE_USABLE");
		__H:RegisterEvent("UPDATE_BINDINGS");
		__H:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");


	else
		__H:UnregisterEvent("UNIT_AURA");
		__H:UnregisterEvent("LEARNED_SPELL_IN_TAB");
		__H:UnregisterEvent("ACTIONBAR_UPDATE_USABLE");
		__H:UnregisterEvent("UPDATE_BINDINGS");
		__H:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
	end
end

function HunterAssistAspect_Toggle(switch)
	print("toggle ha aspect")
	__H:CreateAspectBar();
	__H:UpdateAspectInfo();
	HunterAssistAspect_Hook(switch);

	HunterAssistAspect_Event(switch);
	__H:AspectButtonUpdate();
end

-------------------
-- 误导提示
-------------------
local misDirect = 34477;
local misDirectPlayer;
local enablemisDirect = false;
function __H:Yell(msg)
	SendChatMessage(msg, "yell");
end

function __H:UNIT_SPELLCAST_SENT(unit, target, castGUID, spellID)
	-- if (unit == "player" and spellID == misDirect ) then
		-- misDirectPlayer = target;
	-- end
end

function __H:UNIT_SPELLCAST_SUCCEEDED(unit, castGUID, spellID)
	if (HunterAssist_Enabled and unit == "player") then
		__HunterAssistCasteBar_Cast(spellID);
	end
	if enablemisDirect then
		if (unit == "player" and spell == misDirect and IsInInstance()) then
			self:Yell(string.gsub(MISDIRECT_PATTERN, "$player", misDirectPlayer));
		end
	end
end

function HunterAssistMisdirect_Toggle(switch)
	if (switch) then
		__H:RegisterEvent("UNIT_SPELLCAST_SENT");
		enablemisDirect = true;
	else
		__H:UnregisterEvent("UNIT_SPELLCAST_SENT");
		enablemisDirect = false;
	end
end
-- ERR_FEIGN_DEATH_RESISTED
-------------------
-- 距离提示
-------------------
distanceSpell = {
	[1] = 2974,		-- 摔绊(5码)
	[2] = 19503,	-- 驱散射击(15码)
	[3] = 2764,		-- 投掷(30码)
	[4] = 75,		-- 自动射击(35码 - 41码)
};
local DISTANCE_MAX_RANGE = 0;
spellDistance = {};

function __H:UpdateDistanceSpell()
	for k, v in ipairs(distanceSpell) do
		local name, _, _, _, _, maxRange = GetSpellInfo(v);
		spellDistance[v] = {maxRange, name};
	end
end

function __H:GetDistanceText()
	if (not HunterAssistDistanceFrame) then
		__H:CreateDistanceFrame();
	end

	local texVal, minDis, maxDis = nil, 0, 100;
	local out = false;
	if (UnitExists("target")) then
		if (UnitCanAttack("player", "target")) then
			-- 摔绊 5 码
			if (spellDistance[2974][2] and IsSpellInRange(spellDistance[2974][2],"target") == 1) then	-- book id
				maxDis = 5;
				minDis = 0;
			-- 决斗 9.9 码
			elseif (CheckInteractDistance("target", 3) == 1) then				-- duel 9.9 yards
				maxDis = 9.9;
				minDis = 5;
			-- 交易 11.11 码
			elseif (CheckInteractDistance("target", 2) == 1) then		-- trade 11.11 yards
				maxDis = 11.11;
				minDis = 9.9;
			-- 驱散射击 15 码
			elseif (spellDistance[19503][2] and IsSpellInRange(spellDistance[19503][2], "target") == 1) then	-- book id
				maxDis = spellDistance[19503][1];
				minDis = 11.11;
			-- 投掷 30 码
			elseif (spellDistance[2764][2] and IsSpellInRange(spellDistance[2764][2], "target") == 1) then	-- book id
				maxDis = spellDistance[2764][1];
				if (spellDistance[19503][2]) then
					minDis = spellDistance[19503][1];
				elseif (CheckInteractDistance("target", 2) ~= 1) then
					minDis = 11.11;
				end
			-- 自动射击 35 码
			elseif (spellDistance[75][2] and IsSpellInRange(spellDistance[75][2], "target") == 1) then	-- book id
				maxDis = spellDistance[75][1];
				minDis = spellDistance[2764][1];
			else
				texVal = HUNTERASSIST_OOR;
			end

			if (not texVal) then
				texVal = string.format("%sm - %sm", tostring(minDis), tostring(maxDis));
			end
			HunterAssistDistanceFrame:SetAlpha(1.0);
		else
			texVal = HUNTERASSIST_FRIEND;
			HunterAssistDistanceFrame:SetAlpha(0.5);
		end
	else
		texVal = HUNTERASSIST_NO_TARGET;
		HunterAssistDistanceFrame:SetAlpha(0.5);
	end

	return texVal, minDis, maxDis;
end

function __H:CreateDistanceFrame()
	if (HunterAssistDistanceFrame) then return; end

	local frame = CreateFrame("Button", "HunterAssistDistanceFrame", UIParent);
	frame:SetWidth(125); frame:SetHeight(20);
	frame:SetMovable(true);
	frame:SetPoint("TOP", "UIParent", "BOTTOM", 0,  237);
	frame:SetClampedToScreen(true);
	frame.bar = frame:CreateTexture("HunterAssistDistanceFrameBarTexture", "BACKGROUND");
	frame.bar:SetWidth(119); frame.bar:SetHeight(14);
	frame.bar:SetPoint("CENTER", frame, "CENTER", 0, 0);
	frame.bar:SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
	frame.bar:SetVertexColor(1, 0.85, 0);
	frame.bar.border = frame:CreateTexture("HunterAssistDistanceFrameBarBorder", "ARTWORK");
	frame.bar.border:SetTexture("Interface\\Tooltips\\UI-StatusBar-Border");
	frame.bar.border:SetAllPoints(frame);
	frame.bar.tex = frame:CreateFontString("HunterAssistDistanceFrameBarText", "OVERLAY", "GameFontHighlight");
	frame:SetWidth(125); frame:SetHeight(20);
	frame.bar.tex:SetPoint("CENTER", frame, "CENTER", 0 , 1);
	frame.bar.tex:SetJustifyH("CENTER");
	frame.bar.tex:SetJustifyV("CENTER");

	frame:SetScript("OnMouseDown", function(self, button)
		if (IsShiftKeyDown() and button == "LeftButton") then
			self:StartMoving();
			self.ismoving = true;
		end
	end);
	frame:SetScript("OnMouseUp", function(self, button)
		if (self.ismoving) then
			self:StopMovingOrSizing();
			self.ismoving = false;
		end
	end);
	frame:SetScript("OnEnter", function(self)
		GameTooltip_SetDefaultAnchor(GameTooltip, self);
		GameTooltip:SetText(HUNTERASSIST_NAME);
		GameTooltip:AddLine(HUNTERASSIST_RANGE_TOOLTIP);
		GameTooltip:Show();
	end);
	frame:SetScript("OnLeave", function(self)
		GameTooltip:Hide();
	end);
	RegisterForSaveFrame(frame);
	self.dFrame = frame;
end

function __H:SetDistanceBarText(tex, dis)
	local r, g, b = 0, 0, 0;
	if(dis >= 46) then
		b=1;
	elseif(dis >= 35) then
		g=1;
	elseif(dis >= 25) then
		r=1;
		g=1;
	elseif(dis >= 5) then
		r=1;
		g=0.5;
	else
		r=1;
	end
	__H.dFrame.bar.tex:SetText(tostring(tex));
	__H.dFrame.bar:SetVertexColor(r, g, b);
end

function __H:PLAYER_TARGET_CHANGED()
	self:UpdateDistanceSpell();
end

function HunterAssistDistance_Toggle(switch)
	__H:CreateDistanceFrame();
	if (switch) then
		__H:RegisterEvent("PLAYER_TARGET_CHANGED");
		HunterAssistDistanceFrame:SetScript("OnUpdate", function(self)
			local tex, minDis, maxDis = __H:GetDistanceText();
			__H:SetDistanceBarText(tex, maxDis);
		end);
		HunterAssistDistanceFrame:Show();
	else
		__H:UnregisterEvent("PLAYER_TARGET_CHANGED");
		HunterAssistDistanceFrame:SetScript("OnUpdate", function() end);
		HunterAssistDistanceFrame:Hide();
	end
end