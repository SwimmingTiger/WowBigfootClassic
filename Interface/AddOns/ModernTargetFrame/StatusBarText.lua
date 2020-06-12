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
local TextObjects={};
local AnchorSettings={--	Anchors copied from Modern WoW (Relative to TargetFrameTextureFrame)
	[TargetFrameHealthBar]={
		TextString={"CENTER",-50,3};
		LeftText={"LEFT",8,3};
		RightText={"RIGHT",-110,3};
	};
	[TargetFrameManaBar]={
		TextString={"CENTER",-50,-8};
		LeftText={"LEFT",8,-8};
		RightText={"RIGHT",-110,-8};
	};
};

for bar,anchorlist in pairs(AnchorSettings) do
	local tbl={};
	for key,anchor in pairs(anchorlist) do
		local text=TargetFrameTextureFrame:CreateFontString(nil,"OVERLAY","TextStatusBarText");
		text:SetPoint(unpack(anchor));
		tbl[key]=text;
	end
	TextObjects[bar]=tbl;
end

----------------------------------
--[[	Feature Registration	]]
----------------------------------
local function VerifyStatusBar(bar)
	local tbl=TextObjects[bar];
	if not tbl then return nil; end--	Not one of our bars

--	Scanner
	local valid=true;
	for key,obj in pairs(tbl) do
		local exist=bar[key];
		if exist and exist~=obj then valid=false; break; end
	end
	if valid then return true; end--	No further processing if valid

--	Invalid, do cleanup here
	TextObjects[bar]=nil;--	Remove from our objects list (UI objects can't be garbage-collected, this just orphans them)
	for key,obj in pairs(tbl) do
		if bar[key]==obj then bar[key]=nil; end--	Remove if still set (another object in the group was overwritten)
		obj:Hide();--	Hide object
	end

	TextStatusBar_UpdateTextString(bar);--	Update other addons' text
	return false;--	Return as invalid
end

AddOn.RegisterFeature("StatusBarText",function(optionkey,enabled)
	for bar,entry in pairs(TextObjects) do
		if VerifyStatusBar(bar) then
			for key,obj in pairs(entry) do
				if not enabled then obj:Hide(); end--	Hide if disabling (TextStatusBar_UpdateTextString() will autoshow when necessary)
				bar[key]=enabled and obj or nil;--	Apply if enabled
			end
			if enabled then TextStatusBar_UpdateTextString(bar); end--	Update text if enabled
		end
	end
end);

hooksecurefunc("TextStatusBar_UpdateTextStringWithValues",VerifyStatusBar);
