--[[--
	alex/ALA @ 163UI
--]]--
local __version = 1;

_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __coder = __ala_meta__.__coder;
if __coder ~= nil and __coder.__minor >= __version then
	return;
end

local DEVELOPER = {
	-- ["Player-4791-00891F9F"] = "B",	--	"碧空之歌.ALEX.WARRIOR"
	-- ["Player-4791-010E9724"] = "B",	--	"碧空之歌.ALEX.MAGE"
	["Player-4791-01680518"] = "B",	--	"碧空之歌.ALEX.WARLOCK"
	["Player-4791-01480730"] = "B",	--	"碧空之歌.ALEX.PALADIN"
	["Player-4791-010EBD53"] = "B",	--	"碧空之歌.ALEX.DRUID"
	["Player-4791-0136A10C"] = "B",	--	"碧空之歌.ALEX.ROGUE"
	["Player-4791-00E26C49"] = "B",	--	"碧空之歌.ALEX.HUNTER"
	["Player-4791-02840797"] = "B",	--	"碧空之歌.ALEX.WARRIOR.MINOR"
	["Player-4791-0088F6CB"] = "B",	--	"碧空之歌.ALEX.PALADIN.MINOR"
	-- ["Player-4791-0088F61D"] = "G",	--	"碧空之歌.ALEX.PRIEST"
	-- ["Player-4791-00DE4CF1"] = "G",	--	"碧空之歌.ALEX.HUNTER"
	["Player-4791-010B0B3C"] = "G",	--	"碧空之歌.ALEX.PALADIN"
	["Player-4791-0136A0D6"] = "G",	--	"碧空之歌.ALEX.ROGUE"
	["Player-4791-02139522"] = "G",	--	"碧空之歌.ALEX.MAGE"
	["Player-4791-02139923"] = "G",	--	"碧空之歌.ALEX.WARLOCK"
	--
	["Player-4497-0388473F"] = "B",	--	"碧玉矿洞.ALEX.WARRIOR"
	["Player-4497-0392FA91"] = "B",	--	"碧玉矿洞.ALEX.MAGE"
	["Player-4497-038D0E9A"] = "B",	--	"碧玉矿洞.ALEX.PALADIN"
	["Player-4497-038E14E4"] = "B",	--	"碧玉矿洞.ALEX.SHAMAN"
	["Player-4497-039DF9BC"] = "B",	--	"碧玉矿洞.ALEX.PRIEST.MINOR"
	["Player-4497-03985947"] = "G",	--	"碧玉矿洞.ALEX.PRIEST"
	["Player-4497-0395C790"] = "G",	--	"碧玉矿洞.ALEX.HUNTER"
	["Player-4497-03871A80"] = "G",	--	"碧玉矿洞.ALEX.SHAMAN"
	["Player-4497-03C3B443"] = "G",	--	"碧玉矿洞.ALEX.MAGE"
	["Player-4497-03CC89ED"] = "G",	--	"碧玉矿洞.ALEX.PALADIN"
	["Player-4497-03CD426F"] = "G",	--	"碧玉矿洞.ALEX.WARLOCK"
	--
	["Player-4497-0393B39E"] = "D",	--	"碧玉矿洞.NETEASEUI",
};
local TITLELIST = {
	B = IsAddOnLoaded("!!!163UI!!!") and "网易有爱开发者" or "夜空中最亮的星",
	G = IsAddOnLoaded("!!!163UI!!!") and "网易有爱开发者" or "宇宙无敌兔姐姐",
	D = "网易有爱开发者",
};
local FILELIST = {
	["*"] = { "spells/archimonde_fire.m2", 0, 0 ,0, 0.5, 0.0, },
	[1] = { "spells/blackmagic_precast_base.m2", 3, 0, 0.5, 1.0, 0.0, },
	[2] = { "spells/sunwell_fire_barrier_ext.m2", 0, 0, 10, 0.5, 1.0, },
	[3] = { "spells/archimonde_blue_fire.m2", 0, 0, 0, 0.5, 0.0, },
	[4] = { "spells/archimonde_fire.m2", 0, 0 ,0, 0.5, 0.0, },
};
local NUMFILE = #FILELIST;
local GETFILE = function()
	return FILELIST[random(1, NUMFILE)] or FILELIST["*"];
end

if __coder ~= nil then
	__coder:Update(DEVELOPER, TITLELIST, GETFILE);
	__coder.__minor = __version;
	return;
else
	__coder = {  };
	__coder.__minor = __version;
	__ala_meta__.__coder = __coder;
end


local C_Timer_After = C_Timer.After;
local UnitGUID, UnitIsPlayer = UnitGUID, UnitIsPlayer;
local GameTooltip = GameTooltip;
local _Wrap = nil;

local function _Wrap_OnUpdate(_F, elasped)
	local _, unit = GameTooltip:GetUnit();
	if unit == nil then
		_Wrap:Hide();
	else
		local GUID = UnitGUID(unit);
		if DEVELOPER[GUID] == nil or not UnitIsPlayer(unit) then
			_Wrap:Hide();
		end
	end
end
local function _LF_CheckTip(tip)
	local _, unit = tip:GetUnit();
	if unit ~= nil then
		local GUID = UnitGUID(unit);
		local key = DEVELOPER[GUID];
		if key ~= nil and UnitIsPlayer(unit) and tip:IsVisible() then
			tip:AddLine(TITLELIST[key] or "", 1, 0, 1);
			if not tip.fadeOut then
				tip:Show();
			end
			_Wrap:Show();
			_Wrap:SetModelFile(GETFILE());
		end
	end
end
local function _LF_Create_Wrap()
	_Wrap = CreateFrame('FRAME', nil, GameTooltip);
	_Wrap:SetAllPoints();
	_Wrap:SetAlpha(1.0);
	_Wrap:Hide();
	_Wrap:SetFrameLevel(9999);
	_Wrap:SetScript("OnUpdate", _Wrap_OnUpdate);
	local _Model = CreateFrame('PLAYERMODEL', nil, _Wrap);
	_Model:SetAllPoints();
	_Model:SetKeepModelOnHide(true);
	_Model:SetPortraitZoom(1.0);
	_Model:Show();
	function _Wrap:SetModelFile(file)
		local _Model = self._Model;
		_Model:SetModel(file[1]);
		_Model:SetPosition(file[2], file[3], file[4]);
		_Model:SetAlpha(file[5]);
		_Model:SetFacing(file[6]);
	end
	--
	-- local _L = _Model:CreateTexture(nil, "OVERLAY");
	-- _L:SetColorTexture(1.0, 0.5, 0.0, 1.0);
	-- _L:SetPoint("TOPLEFT", 0, 0);
	-- _L:SetPoint("BOTTOMLEFT", 0, 0);
	-- _L:SetWidth(4);
	-- local _R = _Model:CreateTexture(nil, "OVERLAY");
	-- _R:SetColorTexture(1.0, 0.5, 0.0, 1.0);
	-- _R:SetPoint("TOPRIGHT", 0, 0);
	-- _R:SetPoint("BOTTOMRIGHT", 0, 0);
	-- _R:SetWidth(4);
	-- local _T = _Model:CreateTexture(nil, "OVERLAY");
	-- _T:SetColorTexture(1.0, 0.5, 0.0, 1.0);
	-- _T:SetPoint("TOPLEFT", 2, 0);
	-- _T:SetPoint("TOPRIGHT", -2, 0);
	-- _T:SetWidth(4);
	_Wrap._Model = _Model;
	__coder._Wrap = _Wrap;
end

local _DelayAgent = CreateFrame('FRAME');
local function _LF_OnUpdate_DelayAgent(self)
	self:SetScript("OnUpdate", nil);
	_LF_CheckTip(GameTooltip);
end
local function _LF_Hook_OnTooltipSetUnit(tip)
	_DelayAgent:SetScript("OnUpdate", _LF_OnUpdate_DelayAgent);
end
local function _LF_Hook_SetScript(tip, method)
	if method == "OnTooltipSetUnit" then
		tip:HookScript("OnTooltipSetUnit", _LF_Hook_OnTooltipSetUnit);
	end
end
_DelayAgent:SetScript(
	"OnEvent",
	function(self, event)
		if __ala_meta__.__initcoder == nil then
			__ala_meta__.__initcoder = true;
			hooksecurefunc(GameTooltip, "SetScript", _LF_Hook_SetScript);
			GameTooltip:HookScript("OnTooltipSetUnit", _LF_Hook_OnTooltipSetUnit);
			_LF_Create_Wrap();
		end
	end
);
_DelayAgent:RegisterEvent("LOADING_SCREEN_DISABLED");

function __coder:Update(D, T, G)
	DEVELOPER = D or DEVELOPER;
	TITLELIST = T or TITLELIST;
	GETFILE = G or GETFILE;
end