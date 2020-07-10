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

----------------------------------
--[[	Numerical Threat Frame	]]
----------------------------------
local ThreatFrame=CreateFrame("Frame",nil,TargetFrame);
ThreatFrame:SetPoint("BOTTOM",TargetFrame,"TOP",-30,-21);
ThreatFrame:SetSize(50,22);
ThreatFrame:Hide();

ThreatFrame.Background=ThreatFrame:CreateTexture(nil,"BACKGROUND");
ThreatFrame.Background:SetTexture("Interface\\TargetingFrame\\UI-StatusBar");
ThreatFrame.Background:SetPoint("TOP",0,-3);
ThreatFrame.Background:SetSize(37,14);

ThreatFrame.Text=ThreatFrame:CreateFontString(nil,"BACKGROUND","GameFontHighlight");
ThreatFrame.Text:SetDrawLayer("BACKGROUND",1);--	Raise the sublevel (Modern Default UI has this on the same layer and sublevel, but that may cause random Z-order issues)
ThreatFrame.Text:SetPoint("TOP",0,-4);
ThreatFrame.Text:SetText("0%");

do	local border=ThreatFrame:CreateTexture(nil,"ARTWORK");
	border:SetTexture("Interface\\TargetingFrame\\NumericThreatBorder");
	border:SetTexCoord(0,0.765625,0,0.5625);
	border:SetAllPoints(ThreatFrame);
end

----------------------------------
--[[	Threat Border Glow	]]
----------------------------------
local ThreatGlow=TargetFrame:CreateTexture(nil,"BACKGROUND");
ThreatGlow:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Flash");
ThreatGlow:SetTexCoord(0,0.9453125,0,0.181640625);
ThreatGlow:SetPoint("TOPLEFT",-24,0);
ThreatGlow:SetSize(242,93);
ThreatGlow:Hide();

--------------------------------------------------
--[[	Update Functions, Hooks, & Callbacks	]]
--------------------------------------------------
--	Threat Update Function
local function TargetFrame_UpdateThreat()
	local EnableNumeric,EnableGlow=AddOn.Options.ThreatIndicatorNumber,AddOn.Options.ThreatIndicatorGlow;
	if (EnableNumeric or EnableGlow) and UnitExists("target") then
		local tanking,status,_,percent=UnitDetailedThreatSituation("player","target");
		local r,g,b=unpack(ThreatStatusColors[status or 0]);

		if EnableNumeric then
			if tanking then percent=UnitThreatPercentageOfLead("player","target"); end
			if percent and percent>0 then
				ThreatFrame.Text:SetFormattedText("%.0f%%",percent);
				ThreatFrame.Background:SetVertexColor(r,g,b);
				ThreatFrame:Show();
			else ThreatFrame:Hide(); end
		else ThreatFrame:Hide(); end

		if EnableGlow and status and status>0 then
			ThreatGlow:SetVertexColor(r,g,b);
			ThreatGlow:Show();
		else ThreatGlow:Hide(); end
	else ThreatFrame:Hide(); ThreatGlow:Hide(); end--	Inactive
	TargetFrame_UpdateAuras(TargetFrame);--	Update buff offset
end

--	Target Update Event
ThreatFrame:RegisterEvent("PLAYER_TARGET_CHANGED");
ThreatFrame:RegisterUnitEvent("UNIT_THREAT_LIST_UPDATE","target");
ThreatFrame:SetScript("OnEvent",TargetFrame_UpdateThreat);

--	Buff Update Hook
local AURA_START_X=5;--	Local constant in TargetFrame.lua
hooksecurefunc("TargetFrame_UpdateAuraPositions",function(self,basename,numauras,numother,_,_,_,_,flip)
	if self==TargetFrame and flip and numauras>0 and ThreatFrame:IsShown() then
		local friendly=UnitIsFriend("player",self.unit);
		if	(basename=="TargetFrameBuff" and (friendly or numother<=0))
		or	(basename=="TargetFrameDebuff" and not (friendly and numother>0))
		then
--			Y offset is static -15 plus self.threatNumericIndicator:GetHeight()
			_G[basename..1]:SetPoint("BOTTOMLEFT",self,"TOPLEFT",AURA_START_X,3);
		end
	end
end);

----------------------------------
--[[	Feature Registration	]]
----------------------------------
AddOn.RegisterFeature("ThreatIndicatorNumber",TargetFrame_UpdateThreat);
AddOn.RegisterFeature("ThreatIndicatorGlow",TargetFrame_UpdateThreat);
