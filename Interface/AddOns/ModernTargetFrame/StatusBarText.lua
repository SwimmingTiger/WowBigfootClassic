--[[	Modern TargetFrame StatusBarText Module
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
AddOn.Options.StatusBarText=true;

--------------------------
--[[	TextStatusBars	]]
--------------------------
local StatusBarTextRegistry={};
local function SetupStatusBarText(bar,parent)
	if StatusBarTextRegistry[bar] then return; end
	local text,left,right=parent:CreateFontString(nil,"OVERLAY","TextStatusBarText")
		,parent:CreateFontString(nil,"OVERLAY","TextStatusBarText")
		,parent:CreateFontString(nil,"OVERLAY","TextStatusBarText");
	text:SetPoint("CENTER",bar,"CENTER");left:SetPoint("LEFT",bar,"LEFT",2,0);right:SetPoint("RIGHT",bar,"RIGHT",-2,0);
	bar.TextString,bar.LeftText,bar.RightText=text,left,right;
	StatusBarTextRegistry[bar]={text,left,right};
end

SetupStatusBarText(TargetFrameHealthBar,TargetFrameTextureFrame);
SetupStatusBarText(TargetFrameManaBar,TargetFrameTextureFrame);

----------------------------------
--[[	Feature Registration	]]
----------------------------------
AddOn.RegisterFeature("StatusBarText",function(_,enabled)
	for bar,entry in pairs(StatusBarTextRegistry) do
		local text,left,right;--	Init to nil if disabled
		if not enabled then
--			Attempt to hide
			if bar.TextString then bar.TextString:Hide(); end
			if bar.LeftText then bar.LeftText:Hide(); end
			if bar.RightText then bar.RightText:Hide(); end
		else text,left,right=unpack(entry); end--	Fetch text objects if enabled

		bar.TextString,bar.LeftText,bar.RightText=text,left,right;
		if enabled then TextStatusBar_UpdateTextString(bar); end
	end
end);
