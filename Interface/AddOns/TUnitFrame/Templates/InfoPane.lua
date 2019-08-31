
--[[
	Module\Templates\InfoPane.lua
	Provide InfoPane templates for others to use
	Terry@bf
	2010 - 9 - 30

]]

local T = LibStub("AceAddon-3.0"):GetAddon("TUnitFrame")
if not T then return end

T.Templates = T.Templates or {}
-------------------------
---- code for info pane
-------------------------
AceOO = AceLibrary("AceOO-2.0")
if not AceOO then return end

local InfoPaneClass = AceOO.Class()

local __HealthBarColor = {};
__HealthBarColor[0] = { r = 0.0, g = 1.0, b = 0.0 };
__HealthBarColor[1] = { r = 1.0, g = 0.7, b = 0.2 };
__HealthBarColor[2] = { r = 1.0, g = 0.0, b = 0.0 };

local __ManaBarColor = {};
__ManaBarColor[0] = { r = 0.0, g = 1.0, b = 1.0 };	-- 纯蓝色太暗, 看起来太费力
__ManaBarColor[1] = PowerBarColor["RAGE"];
__ManaBarColor[2] = PowerBarColor["FOCUS"];
__ManaBarColor[3] = PowerBarColor["ENERGY"];
__ManaBarColor[4] = PowerBarColor["HAPPINESS"];
__ManaBarColor[5] = PowerBarColor["RUNES"];
__ManaBarColor[6] = PowerBarColor["RUNIC_POWER"];

local healthText,healthPercent
local manaText,__Enable_Colorize_HealthBar

local function __GetFormattedNumber(number)
	local style
	if number > 1000000 then
		style = "%.1fM"
		return style:format(number/1000000)
	end
	if number >100000 then
		style = "%.1fW"
		return style:format(number/10000)
	end
	return number
end

local function __GetRealUnit(unit)
	if unit=="vehicle" then return "player" end
	return unit:gsub("pet","")
end

local function __GetOnVehicleUnit(unit)
	if unit =="player" then return "vehicle" end
	if unit:find("pet") then return unit end
	return unit:gsub("(%a+)(%d?)","%1pet%2")
end

local function __UpdateUnit(unit)
	if UnitUsingVehicle(__GetRealUnit(unit)) then
		return __GetOnVehicleUnit(unit)
	else
		return __GetRealUnit(unit)
	end
end

---update a unit's mana type text color
local function __UpdateManaType(text, __unit)
	if not __unit then
		__unit = "player"
	end
	local info = __ManaBarColor[UnitPowerType(__unit)];
	if info then
		text:SetTextColor(info.r,info.g,info.b)
	end
end

local function __UpdateMana(manaText,__unit,formatFlag)
	if not __unit then
		__unit = "player"
	end
	if not UnitExists(__unit) then return end
	local __power = UnitPower(__unit);
	local __powerMax = UnitPowerMax(__unit);
	if formatFlag then
		manaText:SetText(__GetFormattedNumber(__power).."/"..__GetFormattedNumber(__powerMax));
	else
		manaText:SetText(__power.."/"..__powerMax);
	end
end

local function __OnBarValueChanged(self,value)
	if __Enable_Colorize_HealthBar then
		local __min, __max = self:GetMinMaxValues();
		local __val = self:GetValue();
		local __prop = __val/__max;

		if ( self ) then
			if ( __prop > 0.5 ) then
				self:SetStatusBarColor(__HealthBarColor[0].r, __HealthBarColor[0].g, __HealthBarColor[0].b);
			elseif ( __prop > 0.25 ) then
				self:SetStatusBarColor(__HealthBarColor[1].r, __HealthBarColor[1].g, __HealthBarColor[1].b);
			else
				self:SetStatusBarColor(__HealthBarColor[2].r, __HealthBarColor[2].g, __HealthBarColor[2].b);
			end
		end
	end
end

local function __ColorizeHealth(__healthText,__healthPerc,__healthBar,unit)
	local __health = UnitHealth(unit)
	local __healthMax = UnitHealthMax(unit)
	local perc = __health/__healthMax
	if perc >0.5 then
		if __healthText then
			__healthText:SetTextColor(__HealthBarColor[0].r,
				__HealthBarColor[0].g,
				__HealthBarColor[0].b)
		end
		if __healthPerc then
			__healthPerc:SetTextColor(__HealthBarColor[0].r,
				__HealthBarColor[0].g,
				__HealthBarColor[0].b)
		end
		if __healthBar then
			__healthBar:SetStatusBarColor(__HealthBarColor[0].r,
				__HealthBarColor[0].g,
				__HealthBarColor[0].b)
		end
	elseif perc > 0.25 then
		if __healthText then
			__healthText:SetTextColor(__HealthBarColor[1].r,
				__HealthBarColor[1].g,
				__HealthBarColor[1].b)
		end
		if __healthPerc then
			__healthPerc:SetTextColor(__HealthBarColor[1].r,
				__HealthBarColor[1].g,
				__HealthBarColor[1].b)
		end
		if __healthBar then
			__healthBar:SetStatusBarColor(__HealthBarColor[1].r,
				__HealthBarColor[1].g,
				__HealthBarColor[1].b)
		end
	else
		if __healthText then
			__healthText:SetTextColor(__HealthBarColor[2].r,
				__HealthBarColor[2].g,
				__HealthBarColor[2].b)
		end
		if __healthPerc then
			__healthPerc:SetTextColor(__HealthBarColor[2].r,
				__HealthBarColor[2].g,
				__HealthBarColor[2].b)
		end
		if __healthBar then
			__healthBar:SetStatusBarColor(__HealthBarColor[2].r,
				__HealthBarColor[2].g,
				__HealthBarColor[2].b)
		end
	end
end

local function __RecoverHealthColor(__healthText,__healthPerc,__healthBar)
	__healthText:SetTextColor(__HealthBarColor[0].r,
		__HealthBarColor[0].g,
		__HealthBarColor[0].b)
	if __healthPerc then
		__healthPerc:SetTextColor(__HealthBarColor[0].r,
			__HealthBarColor[0].g,
			__HealthBarColor[0].b)
	end
	if __healthBar then
		__healthBar:SetStatusBarColor(__HealthBarColor[0].r,
			__HealthBarColor[0].g,
			__HealthBarColor[0].b);
	end
end

local function __UpdateHealth(__healthText,__healthPercent,__unit,formatFlag)
	if not __unit then
		__unit = "player"
	end
	local __health = UnitHealth(__unit)
	local __healthMax = UnitHealthMax(__unit)
	local __percent = math.floor(__health*100/__healthMax).."%";
	if formatFlag then
		__healthText:SetText(__GetFormattedNumber(__health).."/"..__GetFormattedNumber(__healthMax));
	else
		__healthText:SetText(__health.."/"..__healthMax);
	end
	if __healthPercent then
		__healthPercent:SetText(__percent);
	end
end

function InfoPaneClass.prototype:UpdateUnitMana(unit)
	if not self.manaText then return end
	if self.unit ==unit or self.infoPane.unit==unit then
		__UpdateMana(self.manaText,unit,self.formatText)
	end
end

function InfoPaneClass.prototype:UpdateUnitManaType(unit)
	if not self.manaText then return end
	if self.unit ==unit or self.infoPane.unit==unit then
		__UpdateManaType(self.manaText,unit)
	end
end

function InfoPaneClass.prototype:UpdateUnitHealth(unit)
	--if unit health data wrong, do not update
	if not unit then return end
	if  UnitHealthMax(unit) <= 0 then return end

	if self.unit ==unit or self.infoPane.unit==unit then
		__UpdateHealth(self.healthText,self.healthPercent,unit,self.formatText)
		-- if self.colorize then
			__ColorizeHealth(self.healthText,self.healthPercent,self.healthBar,unit)
		-- else
			-- __RecoverHealthColor(self.healthText,self.healthPercent,self.healthBar)
		-- end
	end
end

function InfoPaneClass.prototype:SetPoint(...)
	self.infoPane:ClearAllPoints()
	self.infoPane:SetPoint(...)
end

function InfoPaneClass.prototype:SetScale(scale)
	self.infoPane:SetScale(scale)
end

function InfoPaneClass.prototype:RegisterEvent(event)
	self.infoPane:RegisterEvent(event)
end

function InfoPaneClass.prototype:UnregisterAllEvents()
	self.infoPane:UnregisterAllEvents()
end

--开关
function InfoPaneClass.prototype:SwitchColorize(flag)
	self.colorize = flag
	__Enable_Colorize_HealthBar = flag
	self:UpdateUnitHealth(self.unit)
end

function InfoPaneClass.prototype:SwitchInfoBar(flag)
	if flag then
		self.infoPane:Show()
	else
		self.infoPane:Hide()
	end
end

function InfoPaneClass.prototype:SwitchBarText(flag)
	if GetCVar(self.cvar)=="1" then
		TextStatusBar_UpdateTextString(self.healthBar)
		TextStatusBar_UpdateTextString(self.manaBar)
	end
end

--指定信息条针对的单位和父框体
function InfoPaneClass.prototype:Create(infoType,parent,index)
	self.infoPane = _G["TUF_"..infoType.."InfoPane"..(index or "")] or
		CreateFrame("Frame",
			"TUF_"..infoType.."InfoPane"..(index or ""),
			parent,
			"TUF_InfoPane"..infoType.."Template")
	self.infoPane:SetBackdropColor(.6, .6, .6, 1);
	self.cvar = infoType:lower().."StatusText"
	self.healthText = _G[self.infoPane:GetName().."HealthText"]
	self.healthPercent = _G[self.infoPane:GetName().."HealthPercentText"]
	self.manaText = _G[self.infoPane:GetName().."ManaText"]
	-- if _G[parent:GetName().."HealthBar"] then
		-- self.healthBar = _G[parent:GetName().."HealthBar"]
		-- self.healthBar:HookScript("OnValueChanged",__OnBarValueChanged)
	-- end

	if _G[parent:GetName().."ManaBar"] then
		self.manaBar = _G[parent:GetName().."ManaBar"]
	end
	self.unit = infoType:lower()..(index or "")
	self.infoPane.unit = self.unit or "player"
	self.infoPane:SetScript("OnUpdate",function(frame,elapsed)
			if (not frame.interval) then
				frame.interval = 0
			end

			frame.interval = frame.interval + elapsed
			if frame.interval < 0.1 then return end
			self:UpdateUnitMana(self.unit)
			frame.interval = 0;
		end)

	self.UNIT_HEALTH = self.UpdateUnitHealth
	self.UNIT_MANA = self.UpdateUnitMana
	self.UNIT_POWER_UPDATE = self.UpdateUnitMana

	self.UNIT_MAXPOWER = self.UpdateUnitMana
	self.UNIT_MAXHEALTH = self.UpdateUnitHealth

	self.UNIT_DISPLAYPOWER = self.UpdateUnitManaType

	-- self.UNIT_EXITED_VEHICLE = function()
		-- self.unit = __UpdateUnit(self.unit)
		-- self:UpdateUnitMana(self.unit)
		-- self:UpdateUnitHealth(self.unit)
		-- self:UpdateUnitManaType(self.unit)
	-- end

	self.GROUP_ROSTER_UPDATE = function()
		self:UpdateUnitMana(self.unit)
		self:UpdateUnitHealth(self.unit)
		self:UpdateUnitManaType(self.unit)
	end

	-- self.UNIT_ENTERED_VEHICLE = function()
		-- self.unit = __UpdateUnit(self.unit)
		-- self:UpdateUnitMana(self.unit)
		-- self:UpdateUnitHealth(self.unit)
		-- self:UpdateUnitManaType(self.unit)
	-- end


	self.infoPane:SetScript("OnEvent",function(pane,event,...)
		if self[event] then
			self[event](self,...)
		end
	end
	)

end

function InfoPaneClass.prototype:SetAlpha(alpha)
	self.infoPane:SetBackdropColor(0.6,0.6,0.6,alpha)
	if self.healthText then
		self.healthText:SetAlpha(alpha)
	end
	if self.healthPercent then
		self.healthPercent:SetAlpha(alpha)
	end
end

function InfoPaneClass.prototype:ToggleFormattedText(flag)
	self.formatText = flag
	self:UpdateUnitMana(self.unit)
	self:UpdateUnitHealth(self.unit)
end

function InfoPaneClass.prototype:Enable()
	if self.enabled then return end
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_MANA")
	self:RegisterEvent("UNIT_POWER_UPDATE")
	self:RegisterEvent("GROUP_ROSTER_UPDATE")

	self:RegisterEvent("UNIT_MAXPOWER");
	self:RegisterEvent("UNIT_MAXHEALTH");

	self:RegisterEvent("UNIT_DISPLAYPOWER")
	-- self:RegisterEvent("UNIT_ENTERED_VEHICLE");
	-- self:RegisterEvent("UNIT_EXITED_VEHICLE");

	--- call all update functions once to get start value
	self:UpdateUnitMana(self.unit)
	self:UpdateUnitHealth(self.unit)
	self:UpdateUnitManaType(self.unit)
	self.enabled = true
end

function InfoPaneClass.prototype:Disable()
	self:UnregisterAllEvents()

end

T.Templates.InfoPane = InfoPaneClass
