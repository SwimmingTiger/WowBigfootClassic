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
AddOn.RegisterFeature("StatusBarText",function(_,enabled)
	for bar,entry in pairs(TextObjects) do
		for key,obj in pairs(entry) do
			local exist=bar[key];
			if not exist or exist==obj then--	Only apply if untouched by other addons
				if not enabled then obj:Hide(); end--	Hide if already shown and disabling (TextStatusBar_UpdateTextString() will autoshow when necessary)
				bar[key]=enabled and obj or nil;
			end
		end
		TextStatusBar_UpdateTextString(bar);--	Update text, including other addons' when disabling
	end
end);
