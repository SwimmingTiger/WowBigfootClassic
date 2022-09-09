--[[--
	alex/ALA @ 163UI
--]]--
local __version = 220824.0;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;
if __ala_meta__.__minor ~= nil and __ala_meta__.__minor >= __version then
	return;
end
__ala_meta__.__minor = __version;


local _patch_version, _build_number, _build_date, _toc_version = GetBuildInfo();

__ala_meta__.TOC_VERSION = _toc_version;
if _toc_version < 20000 then
	__ala_meta__.MAX_LEVEL = 60;
	__ala_meta__.BUILD = "CLASSIC";
elseif _toc_version < 30000 then
	__ala_meta__.MAX_LEVEL = 70;
	__ala_meta__.BUILD = "BCC";
elseif _toc_version < 40000 then
	__ala_meta__.MAX_LEVEL = 80;
	__ala_meta__.BUILD = "WRATH";
elseif _toc_version < 50000 then
	__ala_meta__.MAX_LEVEL = 85;
	__ala_meta__.BUILD = "CATA";
elseif _toc_version < 60000 then
	__ala_meta__.MAX_LEVEL = 90;
	__ala_meta__.BUILD = "PANDARIA";
elseif _toc_version < 70000 then
	__ala_meta__.MAX_LEVEL = 100;
	__ala_meta__.BUILD = "DRAENOR";
elseif _toc_version < 80000 then
	__ala_meta__.MAX_LEVEL = 110;
	__ala_meta__.BUILD = "LEGION";
elseif _toc_version > 90000 then
	__ala_meta__.MAX_LEVEL = 60;
	__ala_meta__.BUILD = "RETAIL";
else
	__ala_meta__.MAX_LEVEL = GetMaxLevelForExpansionLevel(GetExpansionLevel()) or 60;
	__ala_meta__.BUILD = "UNKNOWN";
end
__ala_meta__.SELFBNTAG = select(2, BNGetInfo());
__ala_meta__.SELFGUID = UnitGUID('player');
__ala_meta__.SELFNAME = UnitName('player');
__ala_meta__.SELFREALM = GetRealmName();
__ala_meta__.SELFFULLNAME = __ala_meta__.SELFNAME .. "-" .. __ala_meta__.SELFREALM;
__ala_meta__.SELFFULLNAME_LEN = #(__ala_meta__.SELFFULLNAME);
__ala_meta__.SELFFACTION = UnitFactionGroup('player');
__ala_meta__.SELFLCLASS, __ala_meta__.SELFCLASS = UnitClass('player');

local _, name, desc, loadable, reason, security, newversion = GetAddOnInfo("!!!!!DebugMe");
__ala_meta__.__SYNC = {
	REALTIME = name ~= nil,
	ONLOGIN = false,
	ONLOGOUT = false,
};
__ala_meta__.__SYNCREALTIME = name ~= nil;
__ala_meta__.__SYNCONLOGIN = false;
__ala_meta__.__SYNCONLOGOUT = false;

do return end

local unpack = unpack;
local inext = ipairs({  });
local type = type;
local strsplit = string.split;
local strlower = string.lower;
local gsub = string.gsub;
local max = math.max;
local Font, FontSize = GameFontNormal:GetFont();

local _alamodulecommand = __ala_meta__.__alamodulecommand or {  };
__ala_meta__.__alamodulecommand = _alamodulecommand;
_G.SLASH_ALAMODULE1 = "/alamodule";
_G.SLASH_ALAMODULE2 = "/alamod";
_G.SLASH_ALAMODULE3 = "/alamdl";
SlashCmdList["ALAMODULE"] = function(msg)
	if msg == "" then
		local command = _alamodulecommand[""];
		if command ~= nil then
			return command();
		end
	else
		msg = gsub(msg, " [ ]+", " ");
		local chain = { strsplit(" ", msg) };
		local command = _alamodulecommand[strlower(chain[1])];
		if command ~= nil then
			return command(unpack(chain, 2));
		end
	end
end
function __ala_meta__._RegisterModuleCommand(module, command)
	if type(module) == 'string' and type(command) == 'function' then
		_alamodulecommand[strlower(module)] = command;
	end
end


local GetAddOnInfo = GetAddOnInfo;
local IsAddOnLoaded = IsAddOnLoaded;
local GetAddOnEnableState = GetAddOnEnableState;
local _AddOnList = {
	"ElvUI",
	"Tukui",
	"NDui",
	"BigFoot",
	"!!!163UI!!!",
	"163UI_Config",
	"Duowan",
	"rLib",
	"ShestakUI",
	"!!!EaseAddonController",
	"_ShiGuang",
	"alaCalendar",
	"alaChat", "alaChat_Classic",
	"alaGearMan",
	"alaMisc",
	"alaTalentEmu", "TalentEmu",
	"alaTradeSkill",
	"alaTrade",
	"alaUnitFrame",
	"CodexLite",
	"InstanceLockeddownTimer",
};
local _LibList = {
	{ "uireimp",		"__ala_meta__", "uireimp", "__minor", },
	{ "fix",			"__ala_meta__", "__fixminor", },
	{ "coder",			"__ala_meta__", "__coder", "__minor", },
	{ "commlib",		"__ala_meta__", "__commlib", "__minor", },
	{ "alaDropMenu",	"alaDropMenu", "__minor", },
	{ "alaPopup",		"alaPopup", "__minor", },
	{ "instlib",		"__ala_meta__", "__instlib", "__minor", },
	{ "alaScrollList",	"alaScrollList", "__minor", },
	{ "emulib",			"__ala_meta__", "__emulib", "__minor", },
};
local DisplayPanel = nil;
local function dev()
	if DisplayPanel == nil then
		local Lines = {  };
		local Num = 0;
		local Cur = 0;
		local Width = 16;
		--
		DisplayPanel = CreateFrame('FRAME');
		DisplayPanel:SetSize(512, 512);
		DisplayPanel:SetPoint("CENTER");
		__ala_meta__.uireimp._SetSimpleBackdrop(DisplayPanel, 0, 1, 0.0, 0.0, 0.0, 0.9, 1.0, 1.0, 1.0, 0.25);
		do		--	Edit
			local Edit = CreateFrame('EDITBOX', nil, DisplayPanel);
			Edit:SetFont(Font, FontSize);
			Edit:SetAutoFocus(false);
			Edit:SetMultiLine(true);
			Edit:SetPoint("BOTTOMLEFT");
			Edit:SetPoint("TOPRIGHT", 0, -12);
			Edit:Hide();
			Edit:SetScript("OnEscapePressed", function(self)
				self:ClearFocus();
			end);
			__ala_meta__.uireimp._SetSimpleBackdrop(Edit, 0, 1, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 0.25);
			DisplayPanel.Edit = Edit;
		end
		do		--	Close
			local Close = CreateFrame('BUTTON', nil, DisplayPanel);
			Close:SetSize(8, 8);
			Close:SetPoint("TOPRIGHT", -2, -2);
			local N = Close:CreateTexture(nil, "ARTWORK"); N:SetAllPoints(); Close:SetNormalTexture(N);
			local P = Close:CreateTexture(nil, "ARTWORK"); P:SetAllPoints(); Close:SetPushedTexture(P);
			local H = Close:CreateTexture(nil, "HIGHLIGHT"); H:SetAllPoints(); Close:SetHighlightTexture(H);
			local D = Close:CreateTexture(nil, "ARTWORK"); D:SetAllPoints(); Close:SetDisabledTexture(D);
			N:SetColorTexture(0.5, 0.5, 0.5, 0.9);
			P:SetColorTexture(0.75, 0.75, 0.75, 0.9);
			H:SetColorTexture(0.5, 0.5, 0.5, 0.9);
			D:SetColorTexture(0.25, 0.25, 0.25, 0.9);
			Close:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:AddLine("close");
				GameTooltip:Show();
			end);
			Close:SetScript("OnLeave", function(self)
				GameTooltip:Hide();
			end);
			Close:SetScript("OnClick", function(self)
				DisplayPanel:Hide();
			end);
			DisplayPanel.Close = Close;
		end
		do		--	Copy
			local Copy = CreateFrame('BUTTON', nil, DisplayPanel);
			Copy:SetSize(8, 8);
			Copy:SetPoint("TOPLEFT", 2, -2);
			local N = Copy:CreateTexture(nil, "ARTWORK"); N:SetAllPoints(); Copy:SetNormalTexture(N);
			local P = Copy:CreateTexture(nil, "ARTWORK"); P:SetAllPoints(); Copy:SetPushedTexture(P);
			local H = Copy:CreateTexture(nil, "HIGHLIGHT"); H:SetAllPoints(); Copy:SetHighlightTexture(H);
			local D = Copy:CreateTexture(nil, "ARTWORK"); D:SetAllPoints(); Copy:SetDisabledTexture(D);
			N:SetColorTexture(0.5, 0.5, 0.5, 0.9);
			P:SetColorTexture(0.75, 0.75, 0.75, 0.9);
			H:SetColorTexture(0.5, 0.5, 0.5, 0.9);
			D:SetColorTexture(0.25, 0.25, 0.25, 0.9);
			Copy:SetScript("OnEnter", function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
				GameTooltip:AddLine("copy");
				GameTooltip:Show();
			end);
			Copy:SetScript("OnLeave", function(self)
				GameTooltip:Hide();
			end);
			Copy:SetScript("OnClick", function()
				local Edit = DisplayPanel.Edit;
				if Edit:IsShown() then
					Edit:Hide();
				else
					local ret = "";
					for index = 1, Cur do
						local Line = Lines[index];
						local Text1, Text2, Text3 = Line[1]:GetText(), Line[2]:GetText(), Line[3]:GetText();
						if Text1 ~= nil then
							ret = ret .. Text1;
							if Text2 ~= nil then
								ret = ret .. " " .. Text2;
							end
							if Text3 ~= nil then
								ret = ret .. " " .. Text3;
							end
							ret = ret .. "\n";
						elseif Text2 ~= nil then
							ret = ret .. Text2;
							if Text3 ~= nil then
								ret = ret .. " " .. Text3;
							end
							ret = ret .. "\n";
						elseif Text3 ~= nil then
							ret = ret .. Text3 .. "\n";
						end
					end
					if ret ~= "" then
						Edit:Show();
						Edit:SetText(ret);
						Edit:SetFocus();
						Edit:HighlightText();
					end
				end
			end);
			DisplayPanel.Copy = Copy;
		end
		--
		local function CreateLine()
			Num = Num + 1;
			local L = DisplayPanel:CreateFontString(nil, "ARTWORK");
			L:SetPoint("TOPLEFT", 8, 8 - 20 * Num);
			L:SetFont(Font, FontSize);
			L:SetTextColor(1.0, 1.0, 1.0);
			local M = DisplayPanel:CreateFontString(nil, "ARTWORK");
			M:SetPoint("TOP", 0, 8 - 20 * Num);
			M:SetFont(Font, FontSize);
			M:SetTextColor(1.0, 1.0, 1.0);
			local R = DisplayPanel:CreateFontString(nil, "ARTWORK");
			R:SetPoint("TOPRIGHT", -8, 8 - 20 * Num);
			R:SetFont(Font, FontSize);
			R:SetTextColor(1.0, 1.0, 1.0);
			local Line = { L, M, R, };
			Lines[Num] = Line;
			return Line;
		end
		function DisplayPanel:AddLeftLine(Text1, r1, g1, b1)
			Cur = Cur + 1;
			local Line = Lines[Cur] or CreateLine();
			Line[1]:SetText(Text1);
			if r1 == nil and g1 == nil and b1 == nil then
				Line[1]:SetTextColor(1.0, 1.0, 1.0);
			else
				Line[1]:SetTextColor(r1 or 0.0, g1 or 0.0, b1 or 0.0);
			end
			Width = max(Width, Line[1]:GetWidth());
		end
		function DisplayPanel:AddMiddleLine(Text2, r2, g2, b2)
			Cur = Cur + 1;
			local Line = Lines[Cur] or CreateLine();
			Line[2]:SetText(Text2);
			if r2 == nil and g2 == nil and b2 == nil then
				Line[2]:SetTextColor(1.0, 1.0, 1.0);
			else
				Line[2]:SetTextColor(r2 or 0.0, g2 or 0.0, b2 or 0.0);
			end
			Width = max(Width, Line[2]:GetWidth());
		end
		function DisplayPanel:AddRightLine(Text3, r3, g3, b3)
			Cur = Cur + 1;
			local Line = Lines[Cur] or CreateLine();
			Line[3]:SetText(Text3);
			if r3 == nil and g3 == nil and b3 == nil then
				Line[3]:SetTextColor(1.0, 1.0, 1.0);
			else
				Line[3]:SetTextColor(r3 or 0.0, g3 or 0.0, b3 or 0.0);
			end
			Width = max(Width, Line[3]:GetWidth());
		end
		function DisplayPanel:AddDoubleLine(Text1, Text3, r1, g1, b1, r3, g3, b3)
			Cur = Cur + 1;
			local Line = Lines[Cur] or CreateLine();
			Line[1]:SetText(Text1);
			if r1 == nil and g1 == nil and b1 == nil then
				Line[1]:SetTextColor(1.0, 1.0, 1.0);
			else
				Line[1]:SetTextColor(r1 or 0.0, g1 or 0.0, b1 or 0.0);
			end
			Line[3]:SetText(Text3);
			if r3 == nil and g3 == nil and b3 == nil then
				Line[3]:SetTextColor(1.0, 1.0, 1.0);
			else
				Line[3]:SetTextColor(r3 or 0.0, g3 or 0.0, b3 or 0.0);
			end
			Width = max(Width, Line[1]:GetWidth() + 8 + Line[3]:GetWidth());
		end
		function DisplayPanel:Clear()
			Cur = 0;
			for index = 1, Cur do
				local Line = Lines[index];
				Line[1]:SetText(nil);
				Line[2]:SetText(nil);
				Line[3]:SetText(nil);
			end
		end
		function DisplayPanel:Render()
			self:SetWidth(Width + 16);
			self:SetHeight(Cur * 20 + 20);
		end
	end
	DisplayPanel:Show();
	DisplayPanel.Edit:Hide();
	DisplayPanel:Clear();
	local FirstAddon = true;
	for _, addon in inext, _AddOnList, 0 do
		if IsAddOnLoaded(addon) then
			local version = GetAddOnMetadata(addon, "Version");
			if FirstAddon then
				FirstAddon = false;
				DisplayPanel:AddMiddleLine("****|cffff00ffAddOnList|r****");
			end
			if version ~= nil and version ~= "" then
				DisplayPanel:AddDoubleLine(addon, "#|cffffff00" .. version .. "|r");
			else
				version = GetAddOnMetadata(addon, "X-163UI-Version");
				if version ~= nil and version ~= "" then
					DisplayPanel:AddDoubleLine(addon, "#|cffff7f00" .. version .. "|r");
				else
					DisplayPanel:AddLeftLine("|cffff0000" .. addon .. "|r");
				end
			end
		end
	end
	local FirstLib = true;
	for _, TalentDef in inext, _LibList, 0 do
		local val = _G;
		for index = 2, #TalentDef do
			val = val[TalentDef[index]];
			if val == nil then
				break;
			end
		end
		if val ~= nil then
			if FirstLib then
				FirstLib = false;
				DisplayPanel:AddMiddleLine("****|cffff00ffLibList|r****");
			end
			DisplayPanel:AddDoubleLine(TalentDef[1], "#|cffff7f00" .. val .. "|r");
		end
	end
	DisplayPanel:Render();
end
__ala_meta__._RegisterModuleCommand("dev", dev);
__ala_meta__._RegisterModuleCommand("", dev);
