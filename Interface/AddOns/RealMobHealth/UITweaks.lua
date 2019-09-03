--[[	RealMobHealth UI Tweaks Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145	]]
------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local Name,AddOn=...;
AddOn.API=AddOn.API or {};
AddOn.Options=AddOn.Options or {};

----------------------------------
--[[	Options Defaults	]]
----------------------------------
AddOn.Options.ShowTooltipText=true;
AddOn.Options.ShowStatusBarTextAdditions=true;
AddOn.Options.ModifyHealthBarText=true;
AddOn.Options.ShowNamePlateHealthText=true;

----------------------------------
--[[	Local References	]]
----------------------------------
local next=next;
local math_abs=math.abs;
local math_floor=math.floor;
local math_log10=math.log10;
local math_max=math.max;
local pairs=pairs;
local tostring=tostring
local UnitCanAttack=UnitCanAttack;
local unpack=unpack;

----------------------------------
--[[	Helper Functions	]]
----------------------------------
local NumberCaps={FIRST_NUMBER_CAP,SECOND_NUMBER_CAP};
local function AbbreviateNumber(val)--	Abbreviates large numbers
	local exp=math_max(0,math_floor(math_log10(math_abs(val))));--	Calculate exponent of 10 and clamp to zero
	if exp<3 then return tostring(math_floor(val)); end--	Less than 1k, return as-is

	local factor=math_floor(exp/3);--	Exponent factor of 1k
	local precision=math_max(0,2-exp%3);--	Dynamic precision based on how many digits we have (Returns numbers like 100k, 10.0k, and 1.00k)

--	Fallback to scientific notation if we run out of units
	return ((val<0 and "-" or "").."%0."..precision.."f%s"):format(val/1000^factor,NumberCaps[factor] or "e"..(factor*3));
end

----------------------------------
--[[	GameTooltip Tweaks	]]
----------------------------------
GameTooltip:HookScript("OnTooltipSetUnit",function(self)
	local _,unit=self:GetUnit();
	if AddOn.Options.ShowTooltipText and unit and UnitCanAttack("player",unit) and AddOn.IsUnitMob(unit) then
		if AddOn.UnitHasHealthData(unit) then self:AddLine("Recorded Health Data",0,1,0);
		elseif AddOn.IsBlacklistedUnit(unit) then self:AddLine("Blacklisted Mob",0.5,0.5,0.5);
		else self:AddLine("Missing Health Data",1,0,0); end
	end
end);

----------------------------------
--[[	Setup TargetFrame	]]
----------------------------------
local StatusBarTextAdditionsEnabled=true;
local StatusBarTextAdditions={};

local function SetupUFStatusBarText(parent,bar)--	Create strings for TextStatusBars
	local text,left,right=	parent:CreateFontString(nil,"OVERLAY","TextStatusBarText")
				,parent:CreateFontString(nil,"OVERLAY","TextStatusBarText")
				,parent:CreateFontString(nil,"OVERLAY","TextStatusBarText");
	StatusBarTextAdditions[bar]={text,left,right};

	bar.TextString,bar.LeftText,bar.RightText=text,left,right;
	text:SetPoint("CENTER",bar,"CENTER",0,0);
	left:SetPoint("LEFT",bar,"LEFT",2,0);
	right:SetPoint("RIGHT",bar,"RIGHT",-2,0);
end

--	TargetFrame doesn't have FontStrings for the health and mana bars
SetupUFStatusBarText(TargetFrameTextureFrame,TargetFrameManaBar);
SetupUFStatusBarText(TargetFrameTextureFrame,TargetFrameHealthBar);

AddOn.RegisterAddOnEvent("OPTIONS_UPDATE",function(_,option,value)
	if option==nil then option,value="ShowStatusBarTextAdditions",AddOn.Options.ShowStatusBarTextAdditions; end
	if option=="ShowStatusBarTextAdditions" then
		for bar,texts in pairs(StatusBarTextAdditions) do
			local text,left,right=unpack(texts);
			if value then
				bar.TextString,bar.LeftText,bar.RightText=text,left,right;
				TextStatusBar_UpdateTextString(bar);
			else
				bar.TextString,bar.LeftText,bar.RightText=nil,nil,nil;
				text:Hide(); left:Hide(); right:Hide();
			end
		end
	end
end);

----------------------------------
--[[	HealthBar Tweaks	]]
----------------------------------
local HookedHealthBars={};
hooksecurefunc("UnitFrameHealthBar_Update",function(self,unit)
	if not HookedHealthBars[self] then
		HookedHealthBars[self]=true;
		TextStatusBar_UpdateTextString(self);--	Runs our hook below
	end
end);

--	Replace health text with our own values
local TextStatusBar_UpdateTextStringWithValues=TextStatusBar_UpdateTextStringWithValues;--	Local cache so we don't run our own hook indefinitely
hooksecurefunc("TextStatusBar_UpdateTextStringWithValues",function(bar,txt,val,min,max)
	if AddOn.Options.ModifyHealthBarText and HookedHealthBars[bar] and bar.unit and AddOn.IsUnitMob(bar.unit) then--	Run only on bars we've noted, can run on uninitialized ones
		local val,max,curspec,maxspec=AddOn.GetUnitHealth(bar.unit);--	Returns 3 and 4 are nil if we don't have enough data for speculation (Don't update in that case)
		if curspec~=nil or maxspec~=nil then TextStatusBar_UpdateTextStringWithValues(bar,txt,val,min,max); end
	end
end);

--	Event registration
AddOn.RegisterAddOnEvent("HEALTH_UPDATE",function(_,creaturekey)
	for bar in next,HookedHealthBars do
		if bar.unit and (not creaturekey or creaturekey==AddOn.GetUnitCreatureKey(bar.unit)) then TextStatusBar_UpdateTextString(bar); end--	Re-run our hook
	end
end);

AddOn.RegisterAddOnEvent("OPTIONS_UPDATE",function(_,option)
	if option==nil or option=="ModifyHealthBarText" then
		for bar in next,HookedHealthBars do TextStatusBar_UpdateTextString(bar); end
	end
end);

----------------------------------
--[[	Nameplate Tweaks	]]
----------------------------------
local ShowNamePlateHealthText=AddOn.Options.ShowNamePlateHealthText;--	Cache for settings
local NamePlateHealthText={};
hooksecurefunc(NamePlateDriverFrame,"OnNamePlateCreated",function(self,base)--	Hook Nameplate creation
	local unitframe=base.UnitFrame;

	local health=unitframe.healthBar:CreateFontString(nil,"OVERLAY");--"NumberFontNormalSmall");
	health:SetFont("Fonts\\ArialN.ttf",10,"THICKOUTLINE");--	Fonts are easier to read when made from scratch rather than resizing an inherited one
	health:SetPoint("LEFT",0,0);
	health:SetTextColor(0,1,0);
	health:SetShown(ShowNamePlateHealthText);--	Show/Hide based on options

	NamePlateHealthText[unitframe]=health;
end);

--	Updates text
local function UpdateNamePlateHealthText(unitframe)
	local health=AddOn.GetUnitHealth(unitframe.displayedUnit);
	NamePlateHealthText[unitframe]:SetText(AbbreviateNumber(health));
end

--	Hook text set
hooksecurefunc("CompactUnitFrame_UpdateHealth",function(self)--	This is a shared function with other UnitFrames
	if not NamePlateHealthText[self] then return; end
	UpdateNamePlateHealthText(self);
end);

--	Event registration
AddOn.RegisterAddOnEvent("HEALTH_UPDATE",function(_,creaturekey)
	for unitframe in next,NamePlateHealthText do
		if unitframe.displayedUnit and (not creaturekey or creaturekey==AddOn.GetUnitCreatureKey(unitframe.displayedUnit)) then
			UpdateNamePlateHealthText(unitframe);
		end
	end
end);

AddOn.RegisterAddOnEvent("OPTIONS_UPDATE",function(_,option,value)
	if option==nil then option,value="ShowNamePlateHealthText",AddOn.Options.ShowNamePlateHealthText; end
	if option=="ShowNamePlateHealthText" then
		ShowNamePlateHealthText=value;--	Update cache
		for _,text in pairs(NamePlateHealthText) do text:SetShown(value); end--	Show/Hide based on options
	end
end);
