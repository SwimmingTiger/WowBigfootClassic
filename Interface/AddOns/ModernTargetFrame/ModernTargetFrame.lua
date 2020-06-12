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
local Defaults,Options=AddOn.Options,{};
ModernTargetFrame_Options=Options;

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

----------------------------------
--[[	Events & Scripts	]]
----------------------------------
local FeatureButtons={};

Panel:RegisterEvent("ADDON_LOADED");
Panel:SetScript("OnEvent",function(self,event,...)
	if event=="ADDON_LOADED" and (...)==Name then
		Defaults,Options=AddOn.Options,ModernTargetFrame_Options;
		AddOn.Options=Options;--	Sync options

--		Trim/Fill Options
		for key,val in pairs(Defaults) do if Options[key]==nil then Options[key]=val; end end
		for key,val in pairs(Options) do if Defaults[key]==nil then Options[key]=nil; end end

--		Send updates to modules
		local errhnd=geterrorhandler();
		for key,button in pairs(FeatureButtons) do xpcall(button.Callback,errhnd,key,Options[key]); end

--		Don't need this event anymore
		self:UnregisterEvent(event);
	end
end);

function Panel.refresh()--	Runs on show
	for key,button in pairs(FeatureButtons) do button:SetChecked(Options[key]); end
end

function Panel.default()--	Write Defaults to Options (Panel.refresh() runs afterward)
	local errhnd=geterrorhandler();
	for key,val in pairs(Defaults) do
		Options[key]=val;

		local button=FeatureButtons[key];
		if button then xpcall(button.Callback,errhnd,key,val); end
	end
end

function Panel.okay()--	Changes stored in :SetChecked() state, save to Options
	local errhnd=geterrorhandler();
	for key,button in pairs(FeatureButtons) do
		local val=button:GetChecked();
		Options[key]=val;
		xpcall(button.Callback,errhnd,key,val);
	end
end

function Panel.cancel()--	Fire callbacks with Options values (OnShow runs Panel.refresh())
	local errhnd=geterrorhandler();
	for key,button in pairs(FeatureButtons) do xpcall(button.Callback,errhnd,key,Options[key]); end
end

----------------------------------
--[[	Feature Registration	]]
----------------------------------
local FeatureCount=0;

local function FeatureButton_OnClick(self) xpcall(self.Callback,geterrorhandler(),self.Key,self:GetChecked()); end

function AddOn.RegisterFeature(key,callback)
	if FeatureButtons[key] then return; end--	Return button if exists

--	Create Button
	local button=CreateFrame("CheckButton",nil,Panel,"UICheckButtonTemplate");
	button:SetPoint("TOPLEFT",32,-48-(FeatureCount*24));

--	Initialize
	button.Key,button.Callback=key,callback;
	button:SetFontString(button.text);
	button:SetNormalFontObject(GameFontNormalSmall);
	button:SetDisabledFontObject(GameFontDisableSmall);
	button:SetText(AddOn.Localization["Options_FeatureName_"..key]);
	button:SetScript("OnClick",FeatureButton_OnClick);

--	Link to Panel & Increment Counter
	FeatureButtons[key],FeatureCount=button,FeatureCount+1;
	return button;
end
