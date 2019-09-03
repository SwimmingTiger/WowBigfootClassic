--[[	RealMobHealth Options Module
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145	]]
------------------------------------------------------------------

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
RealMobHealth_Options=AddOn.Options;

--------------------------
--[[	Local Variables	]]
--------------------------
local Defaults,Options;

----------------------------------
--[[	Local References	]]
----------------------------------
local AddOn_FireAddOnEvent=AddOn.FireAddOnEvent;

--------------------------
--[[	Event Scripts	]]
--------------------------
AddOn.RegisterGameEvent("ADDON_LOADED",function(event,name)
	if name==Name then
		Defaults,Options=AddOn.Options,RealMobHealth_Options;
		AddOn.Options=Options;

--		Trim/Fill Options
		for key,val in pairs(Defaults) do if Options[key]==nil then Options[key]=val; end end
		for key,val in pairs(Options) do if Defaults[key]==nil then Options[key]=nil; end end
		AddOn_FireAddOnEvent("OPTIONS_UPDATE");

		AddOn.UnregisterGameEvent(event);
	end
end);

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
		author:SetText("by "..Author);

		local ver=Panel:CreateFontString(nil,"OVERLAY","GameFontNormalSmall");
		ver:SetPoint("TOPLEFT",title,"TOPRIGHT",4,0);
		ver:SetTextColor(0.5,0.5,0.5);
		ver:SetText("v"..Version);
	end
end

--------------------------
--[[	Options Buttons	]]
--------------------------
local OptionsButtons={};
local CreateOptionsButton; do--	function(parent,key,<anchor>)
	local function OnClick(self)
		local val=self:GetChecked();
		Options[self.Key]=val;
		AddOn_FireAddOnEvent("OPTIONS_UPDATE",self.Key,val);
	end

	local function OnEnter(self)
		GameTooltip:SetOwner(self);
		GameTooltip:SetText(self.Name);
		if self.Description then
			for line in self.Description:gmatch("[^\r\n]+") do GameTooltip:AddLine(line,1,1,1); end
		end
		GameTooltip:Show();
	end

	function CreateOptionsButton(parent,key,...)
		local button=OptionsButtons[key];
		if button then return button; end--	Return button if exists

--		Create button
		button=CreateFrame("CheckButton",nil,parent or Panel,"UICheckButtonTemplate");
		button:SetPoint(...);

--		Set variables
		local name,title,desc=unpack(AddOn.Localization.Options_DynamicList[key]);
		button.Key,button.Name,button.Description=key,title or name,desc;
		button.text:SetText(name);

--		Scripts
		button:SetScript("OnEnter",OnEnter);
		button:SetScript("OnLeave",GameTooltip_Hide);
		button:SetScript("OnClick",OnClick);

--		Return
		OptionsButtons[key]=button;
		return button;
	end
end

CreateOptionsButton(Panel,"ShowTooltipText","TOPLEFT",32,-48);
CreateOptionsButton(Panel,"ShowStatusBarTextAdditions","TOPLEFT",32,-72);
CreateOptionsButton(Panel,"ModifyHealthBarText","TOPLEFT",32,-96);
CreateOptionsButton(Panel,"ShowNamePlateHealthText","TOPLEFT",32,-120);

----------------------------------
--[[	Cache Sub-Panels	]]
----------------------------------
local ContainerBackdropSettings={
	bgFile="Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile="Interface/Tooltips/UI-Tooltip-Border",
	tile=true,tileSize=16,edgeSize=16, 
	insets={left=5,right=5,top=5,bottom=5}
};
local ContainerBackdropBorderColor={0.6,0.6,0.6,1};

local function CachePanel_OnEnter(self)
	GameTooltip:SetOwner(self,"ANCHOR_CURSOR")
	GameTooltip:SetText(self.Name);
	GameTooltip:AddLine(self.Description,1,1,1);
	GameTooltip:Show();
end

do	local CachePanel=CreateFrame("Frame",nil,Panel);--	Health Cache Panel
	CachePanel:SetPoint("LEFT",32,0);
	CachePanel:SetPoint("BOTTOMRIGHT",Panel,"BOTTOM",-16,16);
	CachePanel:SetHeight(64);
	CachePanel:SetBackdrop(ContainerBackdropSettings);
	CachePanel:SetBackdropBorderColor(unpack(ContainerBackdropBorderColor));
	CachePanel:SetBackdropColor(0,0,0,0);

--	Tooltip setup & localization
	CachePanel.Name,CachePanel.Description=unpack(AddOn.Localization.Options_HealthCachePanel);
	CachePanel:SetScript("OnEnter",CachePanel_OnEnter);
	CachePanel:SetScript("OnLeave",GameTooltip_Hide);

--	Cache count text
	local CacheCountText;
	do	local title=CachePanel:CreateFontString(nil,"OVERLAY","GameFontNormal");
		title:SetPoint("TOP",0,-12);
		title:SetText(CachePanel.Name);

		local count=CachePanel:CreateFontString(nil,"OVERLAY","GameFontWhiteSmall");
		count:SetPoint("BOTTOMLEFT",12,12);
		count:SetText(AddOn.Localization.Options_CacheSizeLabel);

		CacheCountText=CachePanel:CreateFontString(nil,"OVERLAY","NumberFontNormalSmall");
		CacheCountText:SetPoint("LEFT",count,"RIGHT",2,-1);
	end

	local CacheClearButton=CreateFrame("Button",nil,CachePanel,"UIPanelButtonTemplate");
	CacheClearButton:SetSize(96,22);
	CacheClearButton:SetPoint("BOTTOMRIGHT",-8,8);
	CacheClearButton:SetText(AddOn.Localization.Options_ClearCacheButtonText);

	CacheClearButton.Name,CacheClearButton.Description=AddOn.Localization.Options_ClearHealthCacheTTText,AddOn.Localization.Options_ClearCacheWarning;
	CacheClearButton:SetMotionScriptsWhileDisabled(true);
	CacheClearButton:SetScript("OnEnter",CachePanel_OnEnter);
	CacheClearButton:SetScript("OnLeave",GameTooltip_Hide);
	CacheClearButton:SetScript("OnClick",function() AddOn.WipeHealthData(); end);

	AddOn.RegisterAddOnEvent("HEALTHCACHE_UPDATE",function(_,count)
		CacheClearButton:SetEnabled(count>0);
		CacheCountText:SetText(count);
	end);
end

do	local CachePanel=CreateFrame("Frame",nil,Panel);--	Peer Cache Panel
	CachePanel:SetPoint("RIGHT",-32,0);
	CachePanel:SetPoint("BOTTOMLEFT",Panel,"BOTTOM",16,16);
	CachePanel:SetHeight(64);
	CachePanel:SetBackdrop(ContainerBackdropSettings);
	CachePanel:SetBackdropBorderColor(unpack(ContainerBackdropBorderColor));
	CachePanel:SetBackdropColor(0,0,0,0);

	CreateOptionsButton(CachePanel,"EnablePeerCache","TOPLEFT",4,-4);

--	Tooltip setup & localization
	CachePanel.Name,CachePanel.Description=unpack(AddOn.Localization.Options_PeerCachePanel);
	CachePanel:SetScript("OnEnter",CachePanel_OnEnter);
	CachePanel:SetScript("OnLeave",GameTooltip_Hide);

--	Cache count text
	local CacheCountText;
	do	local title=CachePanel:CreateFontString(nil,"OVERLAY","GameFontNormal");
		title:SetPoint("TOP",0,-12);
		title:SetText(CachePanel.Name);

		local count=CachePanel:CreateFontString(nil,"OVERLAY","GameFontWhiteSmall");
		count:SetPoint("BOTTOMLEFT",12,12);
		count:SetText(AddOn.Localization.Options_CacheSizeLabel);

		CacheCountText=CachePanel:CreateFontString(nil,"OVERLAY","NumberFontNormalSmall");
		CacheCountText:SetPoint("LEFT",count,"RIGHT",2,-1);
	end

	local CacheClearButton=CreateFrame("Button",nil,CachePanel,"UIPanelButtonTemplate");
	CacheClearButton:SetSize(96,22);
	CacheClearButton:SetPoint("BOTTOMRIGHT",-8,8);
	CacheClearButton:SetText(AddOn.Localization.Options_ClearCacheButtonText);

	CacheClearButton.Name,CacheClearButton.Description=AddOn.Localization.Options_ClearPeerCacheTTText,AddOn.Localization.Options_ClearCacheWarning;
	CacheClearButton:SetMotionScriptsWhileDisabled(true);
	CacheClearButton:SetScript("OnEnter",CachePanel_OnEnter);
	CacheClearButton:SetScript("OnLeave",GameTooltip_Hide);
	CacheClearButton:SetScript("OnClick",function() AddOn.WipePeerData(); end);

	AddOn.RegisterAddOnEvent("PEERCACHE_UPDATE",function(_,count)
		CacheClearButton:SetEnabled(count>0);
		CacheCountText:SetText(count);
	end);
end

--------------------------
--[[	Panel Functions	]]
--------------------------
function Panel.refresh()
	for key,button in pairs(OptionsButtons) do button:SetChecked(Options[key]); end
end
