
-- 通用单元框架(GUF)
-- 通过GUF，可以显示：
--   生命值
--   法力值
--   头像
--   施法条
--   名字
--   增益魔法
--   持续伤害魔法

if (GetLocale() == "zhCN") then
	BUNTIFRAME_GAMETOOLTIP_HEADER = "大脚头像";
	BUNTIFRAME_GAMETOOLTIP_DESC = "◇左键点击选中目标。\n◇右键点击弹出菜单。\n◇Shift+左键可以移动头像。";

	BUNITFRAME_MENU_THEME_TEXT = "风格";
	BUNITFRAME_MENU_CLASSICAL_TEXT = "横排";
	BUNITFRAME_MENU_VERTICAL_TEXT = "竖排";
	BUNITFRAME_MENU_OPERATION_TEXT = "操作";
	BUNITFRAME_MENU_RESET_POSITION_TEXT= "恢复原始位置";
elseif (GetLocale() == "zhTW") then
	BUNTIFRAME_GAMETOOLTIP_HEADER = "大腳頭像";
	BUNTIFRAME_GAMETOOLTIP_DESC = "◇左鍵點擊選中目標。\n◇右鍵點擊彈出菜單。\n◇Shift+左鍵可以移動頭像。";

	BUNITFRAME_MENU_THEME_TEXT = "風格";
	BUNITFRAME_MENU_CLASSICAL_TEXT = "橫排";
	BUNITFRAME_MENU_VERTICAL_TEXT = "豎排";
	BUNITFRAME_MENU_OPERATION_TEXT = "操作";
	BUNITFRAME_MENU_RESET_POSITION_TEXT= "恢復原始位置";
else
	BUNTIFRAME_GAMETOOLTIP_HEADER = "BUnitFrame";
	BUNTIFRAME_GAMETOOLTIP_DESC = "Left click to target unit.\nRight click to show menu.\nShift+Click to move frame.";

	BUNITFRAME_MENU_THEME_TEXT = "Theme";
	BUNITFRAME_MENU_CLASSICAL_TEXT = "Classical";
	BUNITFRAME_MENU_VERTICAL_TEXT = "Vertical";
	BUNITFRAME_MENU_OPERATION_TEXT = "Operation";
	BUNITFRAME_MENU_RESET_POSITION_TEXT= "Reset position";
end

local BUnitFrame_Version = 2.8;
local __BUNITFRAME_ENABLED;
local __BUNITFRAME_UPDATE_INTERVAL = 0.1;
local TargetofTargetFrame;
local BUEventor = BLibrary("BEvent");

local __shine_themes = {
	[1] = {
		texture = "Interface\\Cooldown\\star4";
		duration = 0.2,
		alphaStart = 0.5,
		alphaEnd = 1.0,
		scaleStart = 1,
		scaleEnd = 3,
	},
	[2] = {
		texture = "Interface\\Cooldown\\star4";
		duration = 1,
		alphaStart = 1.0,
		alphaEnd = 0.3,
		scaleStart = 3,
		scaleEnd = 0,
	}
};

local __BUnitFrame_ManaBarColor = {
	[0] = { r = 0.00, g = 0.00, b = 1.00, prefix = MANA },
	[1] = { r = 1.00, g = 0.00, b = 0.00, prefix = RAGE },
	[2] = { r = 1.00, g = 0.50, b = 0.25, prefix = FOCUS },
	[3] = { r = 1.00, g = 1.00, b = 0.00, prefix = ENERGY },
	[4] = { r = 0.00, g = 1.00, b = 1.00, prefix = HAPPINESS },
	[5] = { r = 0.50, g = 0.50, b = 0.50, prefix = RUNES },
	[6] = { r = 0.00, g = 0.82, b = 1.00, prefix = RUNIC_POWER }
};

local function __HideSysTotFrame()
	if TargetofTargetFrame then
		BFSecureCall(TargetofTargetFrame.SetAlpha,TargetofTargetFrame,0)
		BFSecureCall(TargetofTargetFrame.SetScale,TargetofTargetFrame,0.01)
	end
end

local function __RecoverSysTotFrame()
	if TargetofTargetFrame then
		BFSecureCall(TargetofTargetFrame.SetAlpha,TargetofTargetFrame,1)
		BFSecureCall(TargetofTargetFrame.SetScale,TargetofTargetFrame,1)
	end
end

BUEventor:Init{
	name = "TUnitFrame",
	func = function()
		if (not BUnitFrame_Config or BUnitFrame_Config["version"] ~= BUnitFrame_Version) then
			BUnitFrame_Config = {
				["version"] = BUnitFrame_Version,
				["focus"] = {
					["enabled"] = true,
					["theme"] = "vertical",
				},
				["tt"] = {
					["enabled"] = false,
					["theme"] = "classical",
				},
				["ttt"] = {
					["enabled"] = false,
					["theme"] = "classical",
				},
				["sysFocus_t"] = {
					["enabled"] = false,
					["theme"] = "classical",
				},
				["sysFocus_tt"] = {
					["enabled"] = false,
					["theme"] = "classical",
				},
				["casting_flash"] = true,
				["casting_icon"] = true,
			}
		end
	end
};

local __RegisterUnitWatch = RegisterUnitWatch
local __UnregisterUnitWatch = UnregisterUnitWatch

local function RegisterUnitWatch(...)
	BFSecureCall(__RegisterUnitWatch,...)
end

local function UnregisterUnitWatch(...)
	BFSecureCall(__UnregisterUnitWatch,...)
end

local function __BUnitFrame_SetTheme(__frame, __theme)
	if (not __theme) then
		__theme = "classical";
	end

	if (__theme == "classical") then
		__frame:SetWidth(93);
		__frame:SetHeight(45);

		__frame.background:SetWidth(46);
		__frame.background:SetHeight(15);
		__frame.background:ClearAllPoints();
		__frame.background:SetPoint("BOTTOMLEFT", __frame, "BOTTOMLEFT", 42, 13);

		__frame.portrait.width = 35;
		__frame.portrait.height = 35;

		__frame.portrait:SetWidth(__frame.portrait.width);
		__frame.portrait:SetHeight(__frame.portrait.height);
		__frame.portrait:ClearAllPoints();
		__frame.portrait:SetPoint("CENTER", __frame, "TOPLEFT", 22.5, -22.5);

		__frame.portraitBackground:SetWidth(36);
		__frame.portraitBackground:SetHeight(36);
		__frame.portraitBackground:SetTexCoord(0.046875, 0.3203125, 0.078125, 0.625);
		__frame.portraitBackground:ClearAllPoints();
		__frame.portraitBackground:SetPoint("CENTER", __frame, "TOPLEFT", 22.5, -22.5);

		__frame.spellTexture:SetWidth(30);
		__frame.spellTexture:SetHeight(30);
		__frame.spellTexture:ClearAllPoints();
		__frame.spellTexture:SetPoint("CENTER", __frame, "TOPLEFT", 22.5, -22.5);

		__frame.shine:ClearAllPoints();
		__frame.shine:SetPoint("CENTER", __frame.portrait, "CENTER", 0, 0);

		__frame.artwork:SetAllPoints();
		__frame.artwork:SetTexture("Interface\\AddOns\\TUnitFrame\\ClassicUnitFrame");
		__frame.artwork:SetTexCoord(0.015625, 0.7265625, 0, 0.703125);

		__frame.raidIcon:SetWidth(15);
		__frame.raidIcon:SetHeight(15);
		__frame.raidIcon:ClearAllPoints();
		__frame.raidIcon:SetPoint("CENTER", __frame, "TOPLEFT", 22, -5);

		__frame.name:ClearAllPoints();
		__frame.name:SetJustifyH("LEFT");
		__frame.name:SetPoint("BOTTOMLEFT", __frame, "BOTTOMLEFT", 45, 1);
		__frame.name:Show();

		__frame.deadText:ClearAllPoints();
		__frame.deadText:SetPoint("CENTER", __frame, "CENTER", 15, 1);
		__frame.deadText:Show();

		__frame.healthBar:SetWidth(46);
		__frame.healthBar:SetHeight(7);
		__frame.healthBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
		__frame.healthBar:SetOrientation("HORIZONTAL");
		__frame.healthBar:ClearAllPoints();
		__frame.healthBar:SetPoint("TOPRIGHT", __frame, "TOPRIGHT", -2, -15);

		__frame.manaBar:SetWidth(46);
		__frame.manaBar:SetHeight(7);
		__frame.manaBar:SetStatusBarTexture("Interface\\TargetingFrame\\UI-StatusBar");
		__frame.manaBar:SetOrientation("HORIZONTAL");
		__frame.manaBar:ClearAllPoints();
		__frame.manaBar:SetPoint("TOPRIGHT", __frame, "TOPRIGHT", -2, -23);

		__frame.debuff[1]:ClearAllPoints();
		__frame.debuff[1]:SetPoint("LEFT", __frame, "RIGHT", 4, 0);
		__frame.debuff[2]:ClearAllPoints();
		__frame.debuff[2]:SetPoint("LEFT", __frame.debuff[1], "RIGHT", 0, 0);
		__frame.debuff[3]:ClearAllPoints();
		__frame.debuff[3]:SetPoint("LEFT", __frame.debuff[2], "RIGHT", 0, 0);
		__frame.debuff[4]:ClearAllPoints();
		__frame.debuff[4]:SetPoint("LEFT", __frame.debuff[3], "RIGHT", 0, 0);
	elseif (__theme == "vertical") then
		__frame:SetWidth(45);
		__frame:SetHeight(93);

		__frame.background:SetWidth(12);
		__frame.background:SetHeight(55);
		__frame.background:ClearAllPoints();
		__frame.background:SetPoint("BOTTOMRIGHT", __frame, "BOTTOMRIGHT", -15, 32);

		__frame.portrait.width = 30;
		__frame.portrait.height = 30;

		__frame.portrait:SetWidth(__frame.portrait.width);
		__frame.portrait:SetHeight(__frame.portrait.height);
		__frame.portrait:ClearAllPoints();
		__frame.portrait:SetPoint("CENTER", __frame, "BOTTOMRIGHT", -18, 18);

		__frame.portraitBackground:SetWidth(32);
		__frame.portraitBackground:SetHeight(32);
		__frame.portraitBackground:SetTexCoord(0.046875, 0.3203125, 0.078125, 0.625);
		__frame.portraitBackground:ClearAllPoints();
		__frame.portraitBackground:SetPoint("CENTER", __frame, "BOTTOMRIGHT", -18, 18);

		__frame.spellTexture:SetWidth(22);
		__frame.spellTexture:SetHeight(22);
		__frame.spellTexture:ClearAllPoints();
		__frame.spellTexture:SetPoint("CENTER", __frame, "BOTTOMRIGHT", -18, 18);

		__frame.shine:ClearAllPoints();
		__frame.shine:SetPoint("CENTER", __frame.portrait, "CENTER", 0, 0);

		__frame.artwork:SetAllPoints();
		__frame.artwork:SetTexture("Interface\\AddOns\\TUnitFrame\\VerticalUnitFrame");
		__frame.artwork:SetTexCoord(0.09375, 1, 0.0625, 1);

		__frame.raidIcon:SetWidth(12);
		__frame.raidIcon:SetHeight(12);
		__frame.raidIcon:ClearAllPoints();
		__frame.raidIcon:SetPoint("CENTER", __frame, "BOTTOMRIGHT", -18, 5);

		__frame.name:Hide();
		__frame.deadText:Hide();

		__frame.healthBar:SetWidth(7);
		__frame.healthBar:SetHeight(50);
		__frame.healthBar:SetStatusBarTexture("Interface\\AddOns\\TUnitFrame\\VerticalStatusBar");
		__frame.healthBar:SetOrientation("VERTICAL");
		__frame.healthBar:ClearAllPoints();
		__frame.healthBar:SetPoint("TOPLEFT", __frame, "TOPLEFT", 15, -6);

		__frame.manaBar:SetWidth(4);
		__frame.manaBar:SetHeight(50);
		__frame.manaBar:SetStatusBarTexture("Interface\\AddOns\\TUnitFrame\\VerticalStatusBar");
		__frame.manaBar:SetOrientation("VERTICAL");
		__frame.manaBar:ClearAllPoints();
		__frame.manaBar:SetPoint("TOPLEFT", __frame, "TOPLEFT", 25, -6);

		__frame.debuff[1]:ClearAllPoints();
		__frame.debuff[1]:SetPoint("TOP", __frame, "BOTTOM", 0, -2);
		__frame.debuff[2]:ClearAllPoints();
		__frame.debuff[2]:SetPoint("TOP", __frame.debuff[1], "BOTTOM", 0, 0);
		__frame.debuff[3]:ClearAllPoints();
		__frame.debuff[3]:SetPoint("TOP", __frame.debuff[2], "BOTTOM", 0, 0);
		__frame.debuff[4]:ClearAllPoints();
		__frame.debuff[4]:SetPoint("TOP", __frame.debuff[3], "BOTTOM", 0, 0);
	end

	__frame.theme = __theme;
end

local function __BUnitFrame_Update(__frame, __part)
	if (not __frame.unit) then
		return;
	end

	if (__frame.portrait) then
		-- Update portrait
		SetPortraitTexture(__frame.portrait, __frame.unit);
	end

	if (not __part) then
		__part = {};
		__part["all"] = true;
	end

	if (type(__part) == "string") then
		local tmp = __part;
		__part = {};
		__part[tmp] = true;
	end

	if (__part["flag"] or __part["all"]) then
		local index = GetRaidTargetIndex(__frame.unit);
		if ( index ) then
			SetRaidTargetIconTexture(__frame.raidIcon, index);
			__frame.raidIcon:Show();
		else
			__frame.raidIcon:Hide();
		end
	end

	if (__part["name"] or __part["all"]) then
		-- Update name
		local __name = UnitName(__frame.unit);
		if (__name) then
			__frame.name:SetText(__name);
		else
			__frame.name:SetText("");
		end
	end

	if (__part["health"] or __part["all"]) then
		-- Update health
		local __health = UnitHealth(__frame.unit);
		local __maxHealth = UnitHealthMax(__frame.unit);
		__frame.healthBar:SetMinMaxValues(0, __maxHealth);
		__frame.healthBar:SetValue(__health);

		if (__heath == 0) then
			__frame.deadText:Show();
		else
			__frame.deadText:Hide();
		end
	end

	if (not __frame.casting) then
		if (__part["power"] or __part["all"]) then
			-- Update mana
			local __maxMana = UnitPowerMax(__frame.unit);
			local __mana = UnitPower(__frame.unit);
			__frame.manaBar:SetMinMaxValues(0, __maxMana);
			__frame.manaBar:SetValue(__mana);
		end

		if (__part["powertype"] or __part["all"]) then
			-- Update power type
			local __powerType, __powerToken = UnitPowerType(__frame.unit);
			local __info;
			if not __powerToken then
				__info = __BUnitFrame_ManaBarColor[__powerType];
			else
				__info = PowerBarColor[__powerToken];
			end
			if __info then
				__frame.manaBar:SetStatusBarColor(__info.r, __info.g, __info.b);
			end
		end
	end
end

local function __BUnitFrame_Create(name, parent, unit, __theme)
	if (not parent) then
		parent = UIParent;
	end

	local __frame = CreateFrame("Button", name, parent, "BUnitFrameTemplate");
	if (__frame) then
		__frame.unit = unit;

		__frame:SetAttribute("unit", unit);
		__frame:SetAttribute("target", unit);
		__frame:SetAttribute("*type1", "target");

		__frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);

		__BUnitFrame_Update(__frame);
		RegisterUnitWatch(__frame, false);
		__frame.watched = true;

		__BUnitFrame_SetTheme(__frame, __theme);

		return __frame;
	end
end

local function __BUnitFrame_SetPosition(__frame)
	BFSecureCall(__frame.ClearAllPoints,__frame)
	BFSecureCall(__frame.SetPoint,__frame,__frame.position[1], __frame.position[2], __frame.position[3], __frame.position[4], __frame.position[5]);
end

function BUEventor:CVAR_UPDATE(...)
	-- if sys conf changed to show target, show targetframe
	local var,value = ...
	if var =="SHOW_TARGET_OF_TARGET_TEXT" then
		if value =="1" then
			__RecoverSysTotFrame()
		end
	end
end

function BUnitFrame_UpdateOptions()
	--[[		--取消对系统CVar的处理
	if __BUNITFRAME_ENABLED then
		--修改系统变量 关闭显示目标的目标
		if (SHOW_TARGET_OF_TARGET == "1") then
			SetCVar("showTargetOfTarget", "0");
			__HideSysTotFrame()
		end
	end
	]]

	if (__BUNITFRAME_ENABLED and BUnitFrame_Config["tt"]["enabled"]) then
		if (not BUFTargetTargetFrame) then
			local __theme = BUnitFrame_Config["tt"]["theme"];
			__BUnitFrame_Create("BUFTargetTargetFrame", TargetFrame, "targettarget", __theme);
			BUFTargetTargetFrame.config_branch = "tt";
			BUFTargetTargetFrame.position = {"BOTTOMRIGHT", TargetFrame, "BOTTOMRIGHT", 0, -18};
			__BUnitFrame_SetPosition(BUFTargetTargetFrame);

			RegisterForSaveFrame(BUFTargetTargetFrame);
		end

		if (not BUFTargetTargetFrame.watched) then
			RegisterUnitWatch(BUFTargetTargetFrame, false);
			BUFTargetTargetFrame.watched = true;
		end
	else
		__RecoverSysTotFrame()
		if (BUFTargetTargetFrame and BUFTargetTargetFrame.watched) then
			UnregisterUnitWatch(BUFTargetTargetFrame);
			BUFTargetTargetFrame.watched = false;

			BUFTargetTargetFrame:Hide();
		end
	end

	if (__BUNITFRAME_ENABLED and BUnitFrame_Config["tt"]["enabled"] and BUnitFrame_Config["ttt"]["enabled"]) then
		if (not BUFTargetTargetTargetFrame) then
			local __theme = BUnitFrame_Config["ttt"]["theme"];
			__BUnitFrame_Create("BUFTargetTargetTargetFrame", BUFTargetTargetFrame, "targettargettarget", __theme);
			BUFTargetTargetTargetFrame.config_branch = "ttt";
			BUFTargetTargetTargetFrame.position = {"TOPLEFT", BUFTargetTargetFrame, "BOTTOMLEFT", 15, 4};
			__BUnitFrame_SetPosition(BUFTargetTargetTargetFrame);

			RegisterForSaveFrame(BUFTargetTargetTargetFrame);
		end

		if (not BUFTargetTargetTargetFrame.watched) then
			RegisterUnitWatch(BUFTargetTargetTargetFrame, false);
			BUFTargetTargetTargetFrame.watched = true;
		end
	else
		if (BUFTargetTargetTargetFrame and BUFTargetTargetTargetFrame.watched) then
			UnregisterUnitWatch(BUFTargetTargetTargetFrame);
			BUFTargetTargetTargetFrame.watched = false;

			BUFTargetTargetTargetFrame:Hide();
		end
	end

	-- if (__BUNITFRAME_ENABLED and BUnitFrame_Config["sysFocus_t"]["enabled"]) then
		-- if (not BFocusTargetFrame) then
			-- local __theme = BUnitFrame_Config["sysFocus_t"]["theme"];
			-- __BUnitFrame_Create("BFocusTargetFrame", FocusFrame, "focustarget", __theme);
			-- BFocusTargetFrame.config_branch = "sysFocus_t";
			-- BFocusTargetFrame.position = {"BOTTOMRIGHT", FocusFrame, "BOTTOMRIGHT", 0, -18};
			-- __BUnitFrame_SetPosition(BFocusTargetFrame);

			-- RegisterForSaveFrame(BFocusTargetFrame);
		-- end

		-- if (not BFocusTargetFrame.watched) then
			-- RegisterUnitWatch(BFocusTargetFrame, false);
			-- BFocusTargetFrame.watched = true;
		-- end
	-- else
		-- __RecoverSysTotFrame()
		-- if (BFocusTargetFrame and BFocusTargetFrame.watched) then
			-- UnregisterUnitWatch(BFocusTargetFrame);
			-- BFocusTargetFrame.watched = false;

			-- BFocusTargetFrame:Hide();
		-- end
	-- end

	if (__BUNITFRAME_ENABLED and BUnitFrame_Config["sysFocus_t"]["enabled"] and BUnitFrame_Config["sysFocus_tt"]["enabled"]) then
		if (not BFocusTargetTargetFrame) then
			local __theme = BUnitFrame_Config["sysFocus_tt"]["theme"];
			__BUnitFrame_Create("BFocusTargetTargetFrame", BFocusTargetFrame, "focustargettarget", __theme);
			BFocusTargetTargetFrame.config_branch = "sysFocus_tt";
			BFocusTargetTargetFrame.position = {"TOPLEFT", BFocusTargetFrame, "BOTTOMLEFT", 15, 4};
			__BUnitFrame_SetPosition(BFocusTargetTargetFrame);

			RegisterForSaveFrame(BFocusTargetTargetFrame);
		end

		if (not BFocusTargetTargetFrame.watched) then
			RegisterUnitWatch(BFocusTargetTargetFrame, false);
			BFocusTargetTargetFrame.watched = true;
		end
	else
		if (BFocusTargetTargetFrame and BFocusTargetTargetFrame.watched) then
			UnregisterUnitWatch(BFocusTargetTargetFrame);
			BFocusTargetTargetFrame.watched = false;

			BFocusTargetTargetFrame:Hide();
		end
	end

	-- if (__BUNITFRAME_ENABLED and BUnitFrame_Config["focus"]["enabled"]) then
		-- if (not BUFFocusFrame) then
			-- local __theme = BUnitFrame_Config["focus"]["theme"];
			-- local __frame = __BUnitFrame_Create("BUFFocusFrame", PlayerFrame, "focus", __theme);
			-- BUFFocusFrame.config_branch = "focus";
			-- BUFFocusFrame.position = {"TOPRIGHT", PlayerFrame, "BOTTOMLEFT", 54, 80};
			-- __BUnitFrame_SetPosition(BUFFocusFrame);

			-- RegisterForSaveFrame(BUFFocusFrame);
		-- end

		-- if (not BUFFocusFrame.watched) then
			-- RegisterUnitWatch(BUFFocusFrame, false);
			-- BUFFocusFrame.watched = true;
		-- end
	-- else
		-- if (BUFFocusFrame and BUFFocusFrame.watched) then
			-- UnregisterUnitWatch(BUFFocusFrame);
			-- BUFFocusFrame.watched = false;

			-- BUFFocusFrame:Hide();
		-- end
	-- end
end

function BUnitFrame_OnEnter(self)
	BigFoot_ShowNewbieTooltip(BUNTIFRAME_GAMETOOLTIP_HEADER, BUNTIFRAME_GAMETOOLTIP_DESC);
end

function BUnitFrame_OnLeave(self)
	GameTooltip:Hide();
end

function BUnitFrame_OnMouseDown(self, button)
	if (IsShiftKeyDown()) then
		self:StartMoving();
	end
end

function BUnitFrame_OnMouseUp(self, button)
	self:StopMovingOrSizing();
end

function BUnitFrame_OnLoad(self)
	self:RegisterEvent("PLAYER_TARGET_CHANGED");
	-- self:RegisterEvent("PLAYER_FOCUS_CHANGED");
	self:RegisterEvent("UNIT_NAME_UPDATE");
	self:RegisterEvent("UNIT_PORTRAIT_UPDATE");
	self:RegisterEvent("UNIT_DISPLAYPOWER");
	self:RegisterEvent("UNIT_HEALTH");
	self:RegisterEvent("UNIT_MAXHEALTH");
	self:RegisterEvent("UNIT_MANA");
	self:RegisterEvent("UNIT_POWER_UPDATE");
	self:RegisterEvent("UNIT_MAXPOWER");
	self:RegisterEvent("UNIT_AURA");
	self:RegisterEvent("RAID_TARGET_UPDATE");
	self:RegisterEvent("UNIT_SPELLCAST_START");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START");
	self:RegisterEvent("UNIT_SPELLCAST_FAILED");
	self:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED");
	self:RegisterEvent("UNIT_SPELLCAST_STOP");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP");
	self:RegisterEvent("UNIT_SPELLCAST_CHANNEL_UPDATE");
	self:RegisterEvent("UNIT_SPELLCAST_DELAYED");

	self.healthBar = getglobal(self:GetName().."HealthBar");
	self.manaBar = getglobal(self:GetName().."ManaBar");
	self.portrait = getglobal(self:GetName().."Portrait");
	self.portraitBackground = getglobal(self:GetName().."PortraitBackground");
	self.spellTexture = getglobal(self:GetName().."SpellTexture");
	self.background = getglobal(self:GetName().."Background");
	self.textureFrame = getglobal(self:GetName().."TextureFrame");
	self.artwork = getglobal(self:GetName().."TextureFrameTexture");
	self.raidIcon = getglobal(self:GetName().."TextureFrameRaidTargetIcon");
	self.name = getglobal(self:GetName().."TextureFrameName");
	self.deadText = getglobal(self:GetName().."TextureFrameDeadText");
	self.shine = getglobal(self:GetName().."ShineFrame");
	self.shineTexture = getglobal(self:GetName().."ShineFrameTexture");
	self.debuff = {};
	self.debuff[1] = getglobal(self:GetName().."Debuff1");
	self.debuff[2] = getglobal(self:GetName().."Debuff2");
	self.debuff[3] = getglobal(self:GetName().."Debuff3");
	self.debuff[4] = getglobal(self:GetName().."Debuff4");

	self.spellTexture:Hide();

	self:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	TargetofTargetFrame = TargetofTargetFrame or TargetFrameToT
end

function BUnitFrame_OnShow(self)
	__BUnitFrame_Update(self);
	if self.unit then
		BUnitFrame_UpdateDebuff(self);
	end
end

function BUnitFrame_OnHide(self)

end

function BUnitFrame_BeginShine(self)
	self.shine.stage = 1;
	self.shine.elapsed = 0;
	self.shine.shining = true;

	self.shine:Show();
end

function BUnitFrame_OnEvent(self, event, ...)
	if (not self.watched) then
		return;
	end

	local __unit = ...;

	if not __unit then __unit = "" end
	if not self.unit then self.unit = "" end

	-- 仅更新选择选定的unit
	if (string.sub(event, 1, 4) == "UNIT" and not UnitIsUnit(__unit, self.unit)) then
		return;
	end

	if (event == "PLAYER_TARGET_CHANGED" and string.sub(self.unit, 1, 6) == "target") then
		__BUnitFrame_Update(self);
	elseif (event == "PLAYER_FOCUS_CHANGED" and string.sub(self.unit, 1, 5) == "focus") then
		__BUnitFrame_Update(self);
	elseif (event == "RAID_TARGET_UPDATE") then
		__BUnitFrame_Update(self, "flag");
	elseif (event == "UNIT_HEALTH" or event == "UNIT_MAXHEALTH") then
		__BUnitFrame_Update(self, "health");
	elseif (event == "UNIT_MANA" or event == "UNIT_POWER_UPDATE" or event == "UNIT_MAXPOWER") then
		__BUnitFrame_Update(self, "power");
	elseif (event == "UNIT_NAME_UPDATE") then
		__BUnitFrame_Update(self, "name");
	elseif (event == "UNIT_PORTRAIT_UPDATE") then
		__BUnitFrame_Update(self, "portrait");
	elseif (event == "UNIT_DISPLAYPOWER") then
		__BUnitFrame_Update(self, "powertype");
	elseif (event == "UNIT_SPELLCAST_START" or event == "UNIT_SPELLCAST_CHANNEL_START") then
		local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID
		if (event == "UNIT_SPELLCAST_START") then
			name, text, texture, startTime, endTime, isTradeSkill = CastingInfo(self.unit);
			self.channeling = nil;
		else
			name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = ChannelInfo(self.unit);
			self.channeling = true;
		end
		self.startTime = startTime;
		self.endTime = endTime;

		if (BUnitFrame_Config["casting_icon"]) then
			self.portrait:Hide();
			self.spellTexture:SetTexture(texture);
			self.spellTexture:SetTexCoord(0.2, 0.8, 0.2, 0.8);
			self.spellTexture:Show();
		end

		self.manaBar:SetMinMaxValues(0, 100);
		self.manaBar:SetStatusBarColor(1.0, 1.0, 1.0);

		if (BUnitFrame_Config["casting_flash"]) then
			BUnitFrame_BeginShine(self);
		end

		self.casting = true;
	elseif ((event == "UNIT_SPELLCAST_CHANNEL_UPDATE" or event == "UNIT_SPELLCAST_DELAYED") and UnitIsUnit(__unit, self.unit)) then
		if (self.casting) then
			local name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID
			if (event == "UNIT_SPELLCAST_CHANNEL_UPDATE") then
				name, text, texture, startTime, endTime, isTradeSkill = ChannelInfo(self.unit);
			else
				name, text, texture, startTime, endTime, isTradeSkill, notInterruptible, spellID = CastingInfo(self.unit);
			end
			self.startTime = startTime;
			self.endTime = endTime;
		end
	elseif ((event == "UNIT_SPELLCAST_FAILED" or event == "UNIT_SPELLCAST_INTERRUPTED" or event == "UNIT_SPELLCAST_STOP" or event == "UNIT_SPELLCAST_CHANNEL_STOP") and UnitIsUnit(__unit, self.unit)) then
		local __mana = UnitPower(self.unit);
		local __manaMax = UnitPowerMax(self.unit);
		self.manaBar:SetValue(__mana);
		self.manaBar:SetMinMaxValues(0, __manaMax);
		local __type,__powerToken = UnitPowerType(self.unit);
		local __info;
		if not __powerToken then
			__info = __BUnitFrame_ManaBarColor[__type];
		else
			__info = PowerBarColor[__powerToken];
		end
		if __info then
			self.manaBar:SetStatusBarColor(__info.r, __info.g, __info.b);
		end

		self.portrait:Show();
		self.spellTexture:Hide();

		self.casting = nil;
	elseif (event == "UNIT_AURA") then
		if (self.unit and UnitIsUnit(__unit, self.unit)) then
			BUnitFrame_UpdateDebuff(self);
		end
	end
end

function BUnitFrame_UpdateDebuff(__frame)
	local color;
	local debuffCount;
	local name, icon, count, debuffType, duration, timeLeft;
	for __i = 1, 4, 1 do
		local button = __frame.debuff[__i];
		local debuffBorder = getglobal(__frame.debuff[__i]:GetName().."Border");
		local debuffIcon = getglobal(__frame.debuff[__i]:GetName().."Icon");
		local debuffCount = getglobal(__frame.debuff[__i]:GetName().."Count");
		local debuffCooldown = getglobal(__frame.debuff[__i]:GetName().."Cooldown");
		name, icon, count, debuffType, duration, timeLeft = UnitDebuff(__frame.unit, __i);
		if ( icon ) then
			debuffIcon:SetTexture(icon);
			if ( debuffType ) then
				color = DebuffTypeColor[debuffType];
			else
				color = DebuffTypeColor["none"];
			end
			if ( count > 1 ) then
				debuffCount:SetText(count);
				debuffCount:Show();
			else
				debuffCount:Hide();
			end

			-- Handle cooldowns
			if ( duration  ) then
				if ( duration > 0 ) then
					debuffCooldown:Show();
					startCooldownTime = GetTime()-(duration-timeLeft);
					CooldownFrame_Set(debuffCooldown, startCooldownTime, duration, 1);
				else
					debuffCooldown:Hide();
				end
			else
				debuffCooldown:Hide();
			end

			debuffBorder:SetVertexColor(color.r, color.g, color.b);
			button:Show();
		else
			button:Hide();
		end
	end
end

function BUnitFrame_OnUpdate(self, elapsed)
	if not self.startTime then
		return;
	end

	if (not self.last) then
		self.last = 0;
	end

	self.last = self.last + elapsed;
	if (self.last > __BUNITFRAME_UPDATE_INTERVAL) then
		self.last = 0;

		__BUnitFrame_Update(self);
		if self.unit then
			BUnitFrame_UpdateDebuff(self);
		end
	end

	if (self.casting) then
		local __time = GetTime() * 1000;
		local __percent = (__time - self.startTime)*100/(self.endTime - self.startTime);
		if (__percent > 100) then
			local __mana = UnitPower(self.unit);
			local __manaMax = UnitPowerMax(self.unit);
			self.manaBar:SetValue(__mana);
			self.manaBar:SetMinMaxValues(0, __manaMax);
			local __type,__powerToken = UnitPowerType(self.unit);
			local __info;
			if not __powerToken then
				__info = __BUnitFrame_ManaBarColor[__type];
			else
				__info = PowerBarColor[__powerToken];
			end
			if __info then
				self.manaBar:SetStatusBarColor(__info.r, __info.g, __info.b);
			end

			if (BUnitFrame_Config["casting_icon"]) then
				self.portrait:Show();
				self.spellTexture:Hide();
			end

			self.casting = nil;
		else
			self.manaBar:SetValue(__percent);
		end
	end

	if (BUnitFrame_Config["casting_flash"]) then
		if (self.shine.shining) then
			self.shine.elapsed = self.shine.elapsed + elapsed;
			if (self.shine.elapsed > __shine_themes[self.shine.stage].duration) then
				self.shine.elapsed = 0;
				self.shine.stage = self.shine.stage + 1;
				if (not __shine_themes[self.shine.stage]) then
					self.shine.shining = nil;
					self.shine:Hide();
					return;
				end
			end

			local __alpha = (__shine_themes[self.shine.stage].alphaEnd - __shine_themes[self.shine.stage].alphaStart) * self.shine.elapsed /__shine_themes[self.shine.stage].duration + __shine_themes[self.shine.stage].alphaStart;
			local __scale = (__shine_themes[self.shine.stage].scaleEnd - __shine_themes[self.shine.stage].scaleStart) * self.shine.elapsed / __shine_themes[self.shine.stage].duration + __shine_themes[self.shine.stage].scaleStart;
			self.shine:SetAlpha(__alpha);
			self.shineTexture:SetWidth(self.shine:GetWidth() * __scale);
			self.shineTexture:SetHeight(self.shine:GetHeight() * __scale);

			self.shine:Show();
		else
			self.shine:Hide();
		end
	else
		self.shine:Hide();
	end
end

function BUnitFrame_OnContextMenu(self)
	PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
	BUnitFrameDropDown.relative_frame = self;
	BToggleDropDownMenu(1, nil, BUnitFrameDropDown, self:GetName(), 0, 0);
end

function BUnitFrameDropDown_OnLoad(self)
	BDropDownMenu_Initialize(self, BUnitFrameDropDown_Initialize, "MENU");
	BDropDownMenu_SetWidth(self, 170);
end

function __BUnitFrame_Command_Classical_Theme()
	local __frame = BUnitFrameDropDown.relative_frame;
	__BUnitFrame_SetTheme(__frame, "classical");
	BUnitFrame_Config[__frame.config_branch]["theme"] = "classical";
end

function __BUnitFrame_Command_Vertical_Theme()
	local __frame = BUnitFrameDropDown.relative_frame;
	__BUnitFrame_SetTheme(__frame, "vertical");
	BUnitFrame_Config[__frame.config_branch]["theme"] = "vertical";
end

function __BUnitFrame_Command_Reset_Position()
	local __frame = BUnitFrameDropDown.relative_frame;
	__BUnitFrame_SetPosition(__frame);
	__frame:StopMovingOrSizing();
end

function BUnitFrameDropDown_Initialize()
	local __info;
	local __frame = BUnitFrameDropDown.relative_frame;

	-- "Theme" header
	__info = {};
	__info.text = BUNITFRAME_MENU_THEME_TEXT;
	__info.notClickable = 1;
	__info.isTitle = 1;
	__info.notCheckable = 1;
	BDropDownMenu_AddButton(__info);

	-- "Classical" theme
	__info = {};
	__info.text = BUNITFRAME_MENU_CLASSICAL_TEXT;
	if (__frame and __frame.theme == "classical") then
		__info.checked = true;
	end;
	__info.func = __BUnitFrame_Command_Classical_Theme;
	BDropDownMenu_AddButton(__info);

	-- "Vertical" theme
	__info = {};
	__info.text = BUNITFRAME_MENU_VERTICAL_TEXT;
	if (__frame and __frame.theme == "vertical") then
		__info.checked = true;
	end;
	__info.func = __BUnitFrame_Command_Vertical_Theme;
	BDropDownMenu_AddButton(__info);

	-- "Operation" header
	__info = {};
	__info.text = BUNITFRAME_MENU_OPERATION_TEXT;
	__info.notClickable = 1;
	__info.isTitle = 1;
	__info.notCheckable = 1;
	BDropDownMenu_AddButton(__info);

	-- "Reset position" comand
	__info = {};
	__info.text = BUNITFRAME_MENU_RESET_POSITION_TEXT;
	__info.func = __BUnitFrame_Command_Reset_Position;
	BDropDownMenu_AddButton(__info);
end

--隐藏系统的焦点框体
-- function ToggleDefaultFocusFrame(switch)
	-- if (switch) then
		-- FocusFrame:RegisterEvent("PLAYER_FOCUS_CHANGED");
		-- FocusFrame:RegisterEvent("PLAYER_FLAGS_CHANGED");
		-- FocusFrame:RegisterEvent("UNIT_CLASSIFICATION_CHANGED");
		-- TargetFrame_CheckFaction(FocusFrame)
		-- TargetFrame_CheckLevel(FocusFrame)
		-- TargetFrame_UpdateAuras(FocusFrame);
		-- TargetFrame_CheckDead(FocusFrame);
		-- UnitFrame_Update(FocusFrame);
		-- if BUFFocusFrame and BUFFocusFrame:IsShown() then
			-- FocusFrame:Show();
		-- end
	-- else
		-- FocusFrame:UnregisterAllEvents();
		-- FocusFrame:Hide();
	-- end
-- end

function BUnitFrame_CastingShining_Toggle(__switch)
	if (__switch) then
		BUnitFrame_Config["casting_flash"] = true;
	else
		BUnitFrame_Config["casting_flash"] = false;
	end
end

function BUnitFrame_CastingIcon_Toggle(__switch)
	if (__switch) then
		BUnitFrame_Config["casting_icon"] = true;
	else
		BUnitFrame_Config["casting_icon"] = false;
	end
end

function BUnitFrame_TargetTargetTargetFrame_Toggle(__switch)
	if (__switch) then
		BUnitFrame_Config["ttt"]["enabled"] = true;
		BUnitFrame_Config["sysFocus_tt"]["enabled"] = true;
	else
		BUnitFrame_Config["ttt"]["enabled"] = false;
		BUnitFrame_Config["sysFocus_tt"]["enabled"] = false;
	end

	BUnitFrame_UpdateOptions();
end

--目标的目标开关
function BUnitFrame_TargetTargetFrame_Toggle(__switch)
	if (__switch) then
		BUnitFrame_Config["tt"]["enabled"] = true;
		BUnitFrame_Config["sysFocus_t"]["enabled"] = true;
	else
		BUnitFrame_Config["tt"]["enabled"] = false;
		BUnitFrame_Config["sysFocus_t"]["enabled"] = false;
	end

	BUnitFrame_UpdateOptions();
end

--简单模式焦点目标开关
-- function BUnitFrame_FocusFrame_Toggle(__switch)
	-- if (__switch) then
		-- BUnitFrame_Config["focus"]["enabled"] = true;
		-- ToggleDefaultFocusFrame(false);
	-- else
		-- BUnitFrame_Config["focus"]["enabled"] = false;
		-- ToggleDefaultFocusFrame(true);
	-- end

	-- BUnitFrame_UpdateOptions();
-- end

--总开关
function BUnitFrame_Toggle(__switch)
	if (__switch) then
		__BUNITFRAME_ENABLED = true;
		BUEventor:RegisterEvent("CVAR_UPDATE")
	else
		__BUNITFRAME_ENABLED = false;
		BUEventor:UnregisterEvent("CVAR_UPDATE")
	end

	BUnitFrame_UpdateOptions();
end
