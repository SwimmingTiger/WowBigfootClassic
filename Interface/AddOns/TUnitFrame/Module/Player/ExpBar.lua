--[[
 	Terry@bf
	2010-11-29
	提供开关，移动其他框体来适应经验条

]]

local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end

local M = T:GetModule("Player",true) or T:NewModule("Player")
if not M then return end

local EB = M:NewModule("ExpBar","AceEvent-3.0","AceHook-3.0")
if not EB then return end

local expBar
local expBarFillBar
local exhaustionTick

local secondaryFrames ={
	SHAMAN = {
		frame = "TotemFrame",
		origin = {"TOPLEFT", "PlayerFrame", "BOTTOMLEFT", 99, 38},
		new = {"TOPLEFT","PlayerFrame", "BOTTOMLEFT", 99, 25},
	},
	DEATHKNIGHT = {
		frame = "RuneFrame",
		origin = {"TOP", "PlayerFrame", "BOTTOM", 54, 34},
		new = {"TOPLEFT","PlayerFrame", "BOTTOMLEFT", 99, 25},
	},
	PALADIN = {
		frame = "PaladinPowerBarFrame",
		origin = {"TOPLEFT", "PlayerFrame", "BOTTOMLEFT", 99, 38},
		new = {"TOPLEFT","PlayerFrame", "BOTTOMLEFT", 99, 25},
	},
	WARLOCK = {
		frame = "ShardBarFrame",
		origin = {"TOPLEFT", "PlayerFrame", "BOTTOMLEFT", 102, 35},
		new = {"TOPLEFT","PlayerFrame", "BOTTOMLEFT", 99, 25},
	},
	DRUID = {
		frame = "EclipseBarFrame",
		origin = {"TOPLEFT", "PlayerFrame", "BOTTOMLEFT", 99, 38},
		new = {"TOPLEFT","PlayerFrame", "BOTTOMLEFT", 99, 25},
	}
}

local function __MoveSecondaryFrames()
	-- if there is xperl we do net do anything
	--Terry@bf
	if XPerl_Player then return end
	if InCombatLockdown() then return end

	PetFrame:SetToplevel(false)
	local _,class = UnitClass("player")
	if not class then return end
	if not secondaryFrames[class] then return end
	local frame,parent,points
	points = secondaryFrames[class]
	frame = _G[points.frame]
	if not frame then return end

	parent = points.new and points.new[2]
	if not parent then return end

	parent = _G[parent]
	if not parent then return end
	-- does the move only if the frame is parent's child
	if frame:IsShown() and frame:GetParent() == parent then
		frame:ClearAllPoints()
		frame:SetPoint(points.new[1],
			parent,
			points.new[3],
			points.new[4],
			points.new[5])
	end
	frame:SetScale(1)
	frame:SetAlpha(1)
	frame:SetFrameStrata(parent:GetFrameStrata());
	frame:SetFrameLevel(PetFrame:GetFrameLevel()+2);
	--beside move the frame, need to do special things for druids
end

local function __ResetSecondaryFrames()
	if InCombatLockdown() then return end

	PetFrame:SetToplevel(true)

	local _,class = UnitClass("player")
	local frame,parent,points
	if not class then return end
	if not secondaryFrames[class] then return end
	points = secondaryFrames[class]
	frame = _G[points.frame]
	if not frame then return end

	parent = points.origin and points.origin[2]
	if not parent then return end

	parent = _G[parent]
	if not parent then return end
	-- does the move only if the frame is parent's child
	if frame:IsShown() and frame:GetParent() == parent then
		frame:ClearAllPoints()
		frame:SetPoint(points.origin[1],
			parent,
			points.origin[3],
			points.origin[4],
			points.origin[5])
	end
end

---------------------------
---- update expbar using current exp
---------------------------
local function __ExpBar_SetExp()
	local __currXP = UnitXP("player");
	local __nextXP = UnitXPMax("player");
	expBar:SetMinMaxValues(min(0, __currXP), __nextXP);
	expBar:SetValue(__currXP);
end

---------------------------
---- update expbar using current faction
---------------------------
local function __ExpBar_SetFaction()
	local __name, __reaction, __min, __max, __value = GetWatchedFactionInfo();
	if (__name) then
		local __color = FACTION_BAR_COLORS[__reaction];
		exhaustionTick:Hide();
		expBar:SetMinMaxValues(0, __max - __min);
		expBar:SetValue(__value - __min);
		expBar:SetStatusBarColor(__color.r, __color.g, __color.b);
	end
end


--------------------------
---load expbar and setup variables
--------------------------
function TUF_ExpBar_OnLoad(self)
	TextStatusBar_Initialize(self)
	self.textLockable = 1
	self:SetFrameLevel(self:GetParent():GetFrameLevel()+1)
end

--------------------------------------
---update expbar text while exp or faction updates
--------------------------------------
local function __ExpBar_OnXpUpdate()
	expBar:Show();
	if (UnitLevel("player") == MAX_PLAYER_LEVEL) then
		__ExpBar_SetFaction()
	else
		__ExpBar_SetExp()
	end
end


----------------------------------------
---update exhaustiontick and exhaustion bar and rest related states
----------------------------------------
local function __ExhaustionTick_OnXpUpdate()
	local __playerCurrXP = UnitXP("player");
	local __playerMaxXP = UnitXPMax("player");

	local __exhaustionThreshold = GetXPExhaustion();
	local __exhaustionStateID, __exhaustionStateName, __exhaustionStateMultiplier = GetRestState();
	if (__exhaustionStateID >= 3) then
		exhaustionTick:SetPoint("CENTER",expBar, "RIGHT");
	end

	if (not __exhaustionThreshold) then
		exhaustionTick:Hide();
		expBarFillBar:Hide();
	else
		local __exhaustionTickSet = max(((__playerCurrXP + __exhaustionThreshold) / __playerMaxXP) * expBar:GetWidth(), 0);
		exhaustionTick:Show();
		exhaustionTick:ClearAllPoints();
		expBarFillBar:Show();
		if (__exhaustionTickSet > expBar:GetWidth()) then
			exhaustionTick:Hide();
			expBarFillBar:Hide();
		else
			exhaustionTick:Show();
			exhaustionTick:SetPoint("CENTER", expBar, "LEFT", __exhaustionTickSet, 0);
			expBarFillBar:Show();
			expBarFillBar:SetPoint("TOPRIGHT",expBar, "TOPLEFT", __exhaustionTickSet, 0);
		end
	end
end

-----------------------------------
-- update colors when exhaustion state changes
-----------------------------------
local function __ExhaustionTick_OnExhaustionUpdate()
	local stateID = GetRestState();
	if (stateID == 1) then
		expBar:SetStatusBarColor(0.0, 0.39, 0.88, 1.0);
		expBarFillBar:SetVertexColor(0.0, 0.39, 0.88, 0.15);
		exhaustionTick.highlight:SetVertexColor(0.0, 0.39, 0.88);
	elseif (stateID == 2) then
		expBar:SetStatusBarColor(1.0, 1.0, 0.7, 1.0);
		expBarFillBar:SetVertexColor(0.97, 0.58, 0.434, 0.15);
		exhaustionTick.highlight:SetVertexColor(0.97, 0.58, 0.434);
	end
end

------------------------------
--- show tooltip and show text
------------------------------
local function __ExpBar_OnEnter(self)
	TextStatusBar_UpdateTextString(self);
	ShowTextStatusBarText(self);
	exhaustionTick.timer = 1;
	GameTooltip_AddNewbieTip(self, XPBAR_LABEL, 1.0, 1.0, 1.0, NEWBIE_TOOLTIP_XPBAR, 1);
	GameTooltip.canAddRestStateLine = 1;

	local __playerMinXP, __playerMaxXP = self:GetMinMaxValues();
	local __playerCurrXP = self:GetValue();
	local __text = __playerCurrXP .. "/" .. __playerMaxXP;
	self.text:SetText(__text);
	self.text:Show();
end

------------------------------
--- hide text and hide tooltip
------------------------------
local function __ExpBar_OnLeave(self)
	HideTextStatusBarText(self);
	GameTooltip:Hide();
	exhaustionTick.timer = nil;
	self.text:Hide();
end

--while player xp update, need to update expbar and exhaustion bar
function EB:PLAYER_XP_UPDATE(...)
	__ExpBar_OnXpUpdate()
	TextStatusBar_OnEvent(expBar,"PLAYER_XP_UPDATE", ...)
	__ExhaustionTick_OnXpUpdate()
end

function EB:UPDATE_EXHAUSTION(...)
	__ExpBar_OnXpUpdate()
	TextStatusBar_OnEvent(expBar,"UPDATE_EXHAUSTION", select(3,...))
	__ExhaustionTick_OnXpUpdate()
	__ExhaustionTick_OnExhaustionUpdate()
end

--while player level up, need to update expbar and exhaustion bar
function EB:PLAYER_LEVEL_UP(...)
	__ExpBar_OnXpUpdate()
	TextStatusBar_OnEvent(expBar,"PLAYER_LEVEL_UP", select(3,...))
	__ExhaustionTick_OnXpUpdate()
end

--while player join or leave resting, need to update expbar and text
function EB:PLAYER_UPDATE_RESTING(...)
	__ExpBar_OnXpUpdate()
	TextStatusBar_OnEvent(expBar,"PLAYER_UPDATE_RESTING",select(3,...))
end

--while player's reputation updates ,need to update expbar(it is used for reputation)
function EB:UPDATE_FACTION(...)
	__ExpBar_OnXpUpdate()
	TextStatusBar_OnEvent(expBar,"UPDATE_FACTION", select(3,...))
end

--set up loading scripts on init
function EB:OnInitialize()

	expBar = _G["TUF_ExpBar"]
	expBarFillBar = _G[expBar:GetName().."ExhaustionLevelFillBar"]
	exhaustionTick = _G["TUF_ExhaustionTick"]
	expBar.text = _G[expBar:GetName().."ArtFrameText"]
	exhaustionTick.normal = _G[exhaustionTick:GetName().."Normal"]
	exhaustionTick.highlight = _G[exhaustionTick:GetName().."Highlight"]

	T:Debug("Player ExpBar Module initialized")
	if PlayerFrame_ToPlayerArt then
		hooksecurefunc("PlayerFrame_ToPlayerArt",function()
			if self:IsEnabled() then
				__MoveSecondaryFrames()
			else
				__ResetSecondaryFrames()
			end
		end)
	end
end

--on enable, hook scripts and events, ideally using ace we can safely hook and unhook all elements so it's a complete switch.
function EB:OnEnable()
	T:Debug("Player ExpBar Module enabling")
	self:RegisterEvent("PLAYER_XP_UPDATE");
	self:RegisterEvent("UPDATE_EXHAUSTION");
	self:RegisterEvent("PLAYER_LEVEL_UP");
	self:RegisterEvent("PLAYER_UPDATE_RESTING");
	self:RegisterEvent("UPDATE_FACTION");
	T:Debug("Events Registered")

	---call this here to refresh status
	__ExpBar_OnXpUpdate()
	T:Debug("Player ExpBar Updated")

	__ExhaustionTick_OnXpUpdate()
	T:Debug("Player Exhaustion Updated")

	__ExhaustionTick_OnExhaustionUpdate()
	T:Debug("Player OnExhaustion Updated")



	self:HookScript(expBar,
		"OnEnter",
		__ExpBar_OnEnter);
	self:HookScript(expBar,
		"OnLeave",
		__ExpBar_OnLeave);
	T:Debug("expBar Scripts Registered")

	self:HookScript(exhaustionTick,
		"OnEnter",
		ExhaustionToolTipText);
	self:HookScript(exhaustionTick,
		"OnLeave",
		function()
			GameTooltip:Hide();
		end);

	__MoveSecondaryFrames()
	T:Debug("exhaustionTick Scripts Registered")
	T:Debug("Player ExpBar Module enabled")
end

---on disable, hide expbar and unregister all events, should be able to leave without a trace
function EB:OnDisable()
	expBar:Hide()
	self:UnregisterAllEvents()
	self:UnhookAll()
	__ResetSecondaryFrames()
	T:Debug("Player ExpBar Module Disabled")
end
