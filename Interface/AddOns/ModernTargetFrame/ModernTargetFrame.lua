--[[	Modern TargetFrame
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

----------------------------------
--[[	Target Classification	]]
----------------------------------
hooksecurefunc("TargetFrame_CheckClassification",function(self,lock)
	if not lock and UnitClassification(self.unit)=="rareelite" then
		self.borderTexture:SetTexture("Interface\\TargetingFrame\\UI-TargetingFrame-Rare-Elite");
	end
end);

--------------------------
--[[	TextStatusBars	]]
--------------------------
local function SetupStatusBarText(bar,parent)
	local text,left,right=parent:CreateFontString(nil,"OVERLAY","TextStatusBarText")
		,parent:CreateFontString(nil,"OVERLAY","TextStatusBarText")
		,parent:CreateFontString(nil,"OVERLAY","TextStatusBarText");
	text:SetPoint("CENTER",bar,"CENTER");left:SetPoint("LEFT",bar,"LEFT",2,0);right:SetPoint("RIGHT",bar,"RIGHT",-2,0);
	bar.TextString,bar.LeftText,bar.RightText=text,left,right;
end

SetupStatusBarText(TargetFrameHealthBar,TargetFrameTextureFrame);
SetupStatusBarText(TargetFrameManaBar,TargetFrameTextureFrame);
