--[[	Modern TargetFrame
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

--------------------------
--[[	Namespace	]]
--------------------------
local Name,AddOn=...;
local Title=select(2,GetAddOnInfo(Name)):gsub("%s*v?[%d%.]+$","");
local Version=GetAddOnMetadata(Name,"Version");
local Author=GetAddOnMetadata(Name,"Author");

--------------------------
--[[	Saved Variables	]]
--------------------------
AddOn.Options=AddOn.Options or {};
ModernTargetFrame_Options=AddOn.Options;

--------------------------
--[[	Options Panel	]]
--------------------------
local Panel=CreateFrame("Frame"); do
	Panel.name=Title;
	InterfaceOptions_AddCategory(Panel);--	Panel Registration

	do	local title=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalLarge");
		title:SetPoint("TOP",0,-12);
		title:SetText(Title);

		local author=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
		author:SetPoint("TOP",title,"BOTTOM",0,0);
		author:SetTextColor(1,0.5,0.25);
		author:SetFormattedText(AddOn.Localization.Options_ByAuthor_Format,Author);

		local ver=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
		ver:SetPoint("TOPLEFT",title,"TOPRIGHT",4,0);
		ver:SetTextColor(0.5,0.5,0.5);
		ver:SetText("v"..Version);
	end
end

local FeatureButtons={};
function Panel.refresh()
	for key,button in pairs(FeatureButtons) do button:SetChecked(AddOn.Options[key]); end
end

----------------------------------
--[[	Events & Scripts	]]
----------------------------------
Panel:RegisterEvent("ADDON_LOADED");
Panel:SetScript("OnEvent",function(self,event,...)
	if event=="ADDON_LOADED" and (...)==Name then
		local defaults,options=AddOn.Options,ModernTargetFrame_Options;
		if defaults~=options then--	Sync options
			AddOn.Options=options;

--			Trim/Fill Options
			for key,val in pairs(defaults) do if options[key]==nil then options[key]=val; end end
			for key,val in pairs(options) do if defaults[key]==nil then options[key]=nil; end end

--			Send updates to modules
			for key,button in pairs(FeatureButtons) do
				if defaults[key]~=nil then button.Callback(key,options[key]); end
			end
		end

--		Don't need this event anymore
		self:UnregisterEvent(event);
	end
end);

----------------------------------
--[[	Feature Registration	]]
----------------------------------
local FeatureCount=0;

local function FeatureButton_OnClick(self)
	local val=self:GetChecked();
	AddOn.Options[self.Key]=val;
	self.Callback(key,val);
end

function AddOn.RegisterFeature(key,callback)
	if FeatureButtons[key] then return; end--	Return button if exists

--	Create Button
	local button=CreateFrame("CheckButton",nil,Panel,"UICheckButtonTemplate");
	button:SetPoint("TOPLEFT",32,-48-(FeatureCount*24));

--	Initialize
	button.Key,button.Callback=key,callback;
	button.text:SetText(AddOn.Localization["Options_FeatureName_"..key]);
	button:SetScript("OnClick",FeatureButton_OnClick);

--	Link to Panel & Increment Counter
	FeatureButtons[key],FeatureCount=button,FeatureCount+1;
end
