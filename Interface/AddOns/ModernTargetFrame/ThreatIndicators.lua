--[[	Modern TargetFrame ThreatIndicators Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local AddOn=select(2,...);
AddOn.Options=AddOn.Options or {};

----------------------------------
--[[	Options Defaults	]]
----------------------------------
AddOn.Options.ThreatIndicatorNumber=true;
AddOn.Options.ThreatIndicatorGlow=true;

--------------------------
--[[	Local Variables	]]
--------------------------
local ThreatStatusColors={
	[0]={0.69,0.69,0.69};
	{1,1,0.47};
	{1,0.6,0};
	{1,0,0};
}

--------------------------
--[[	Threat Frames	]]
--------------------------
local CreateThreatIndicator; do--	function CreateThreatIndicator(unitframe)
	local function Indicator_Update(self)
		local unit=self.Unit;
		local EnableNumeric,EnableGlow=AddOn.Options.ThreatIndicatorNumber,AddOn.Options.ThreatIndicatorGlow;
		if (EnableNumeric or EnableGlow) and UnitExists(unit) then
			local tanking,status,_,percent=UnitDetailedThreatSituation("player",unit);
			local r,g,b=unpack(ThreatStatusColors[status or 0]);

			if EnableNumeric then
				if tanking then percent=UnitThreatPercentageOfLead("player",unit); end
				if percent and percent>0 then
					self.Text:SetFormattedText("%.0f%%",percent);
					self.Background:SetVertexColor(r,g,b);
					self:Show();
				else self:Hide(); end
			else self:Hide(); end

			if EnableGlow and status and status>0 then
				self.Glow:SetVertexColor(r,g,b);
				self.Glow:Show();
			else self.Glow:Hide(); end
		else self:Hide(); self.Glow:Hide(); end--	Inactive
		TargetFrame_UpdateAuras(self.Parent);--	Update buff offset
	end

	function CreateThreatIndicator(unitframe)
		local unit=unitframe.unit;

--		Numerical Threat
		local indicator=CreateFrame("Frame",nil,unitframe);
		indicator:SetPoint("BOTTOM",unitframe,"TOP",-50,-22);
		indicator:SetSize(49,18);
		indicator:Hide();

		indicator.Parent=unitframe;
		indicator.Unit=unit;
		indicator.Update=Indicator_Update;

		indicator.Background=indicator:CreateTexture(nil,"BACKGROUND");
		indicator.Background:SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
		indicator.Background:SetPoint("TOP",0,-3);
		indicator.Background:SetSize(37,14);

		indicator.Text=indicator:CreateFontString(nil,"BACKGROUND","GameFontHighlight");
		indicator.Text:SetDrawLayer("BACKGROUND",1);--	Raise the sublevel (Modern Default UI has this on the same layer and sublevel, but that may cause random Z-order issues)
		indicator.Text:SetPoint("TOP",0,-4);
		indicator.Text:SetText("0%");

		do	local border=indicator:CreateTexture(nil,"ARTWORK");
			border:SetTexture("Interface\\TargetingFrame\\NumericThreatBorder");
			border:SetTexCoord(0,0.765625,0,0.5625);
			border:SetAllPoints(indicator);
		end

--		Border Glow
		indicator.Glow=unitframe:CreateTexture(nil,"BACKGROUND");
		indicator.Glow:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
		indicator.Glow:SetTexCoord(0,0.9453125,0,select(4,GetBuildInfo())<20000 and 0.181640625 or 0.7265625);
		indicator.Glow:SetPoint("TOPLEFT",-24,0);
		indicator.Glow:SetSize(242,93);
		indicator.Glow:Hide();

--		Event Handling
		if unitframe==TargetFrame then indicator:RegisterEvent("PLAYER_TARGET_CHANGED"); end
		if unitframe==FocusFrame then indicator:RegisterEvent("PLAYER_FOCUS_CHANGED"); end
		indicator:RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE",unit);
		indicator:SetScript("OnEvent",Indicator_Update);

		return indicator;
	end
end

local ThreatIndicators={}; for _,unitframe in ipairs({TargetFrame,FocusFrame}) do
	ThreatIndicators[unitframe]=CreateThreatIndicator(unitframe);
end

----------------------------------
--[[	Buffs On Top Correction	]]
----------------------------------
--	Buff Update Hook
local AURA_START_X=5;--	Local constant in TargetFrame.lua
hooksecurefunc("TargetFrame_UpdateAuraPositions",function(self,basename,numauras,numother,_,_,_,_,flip)
	local indicator=ThreatIndicators[self];
	local prefix=self:GetName();

	if indicator and flip and numauras>0 and indicator:IsShown() then
		local friendly=UnitIsFriend("player",self.unit);
		if	(basename==prefix.."Buff" and (friendly or numother<=0))
		or	(basename==prefix.."Debuff" and not (friendly and numother>0))
		then
--			Y offset is static -15 plus self.threatNumericIndicator:GetHeight()
			_G[basename..1]:SetPoint("BOTTOMLEFT",self,"TOPLEFT",AURA_START_X,3);
		end
	end
end);

----------------------------------
--[[	Feature Registration	]]
----------------------------------
local function Options_OnChanged()
	for _,indicator in pairs(ThreatIndicators) do indicator:Update(); end
end

AddOn.RegisterFeature("ThreatIndicatorNumber",Options_OnChanged);
AddOn.RegisterFeature("ThreatIndicatorGlow",Options_OnChanged);
