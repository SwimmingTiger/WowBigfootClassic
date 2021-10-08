--[[--
	alex/ALA @ 163UI
--]]--
local __version = 2;

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
	-- ["Player-4791-0088F61D"] = "G",	--	"碧空之歌.ANDREA.PRIEST"
	-- ["Player-4791-00DE4CF1"] = "G",	--	"碧空之歌.ANDREA.HUNTER"
	["Player-4791-010B0B3C"] = "G",	--	"碧空之歌.ANDREA.PALADIN"
	["Player-4791-0136A0D6"] = "G",	--	"碧空之歌.ANDREA.ROGUE"
	["Player-4791-02139522"] = "G",	--	"碧空之歌.ANDREA.MAGE"
	["Player-4791-02139923"] = "G",	--	"碧空之歌.ANDREA.WARLOCK"
	--
	["Player-4497-0388473F"] = "B",	--	"碧玉矿洞.ALEX.WARRIOR"
	["Player-4497-0392FA91"] = "B",	--	"碧玉矿洞.ALEX.MAGE"
	["Player-4497-038D0E9A"] = "B",	--	"碧玉矿洞.ALEX.PALADIN"
	["Player-4497-038E14E4"] = "B",	--	"碧玉矿洞.ALEX.SHAMAN"
	["Player-4497-039DF9BC"] = "B",	--	"碧玉矿洞.ALEX.HUNTER.MINOR"
	["Player-4497-039DF9BC"] = "B",	--	"碧玉矿洞.ALEX.PRIEST.MINOR"
	["Player-4497-03985947"] = "G",	--	"碧玉矿洞.ANDREA.PRIEST"
	["Player-4497-03F0D909"] = "G",	--	"碧玉矿洞.ANDREA.HUNTER"
	["Player-4497-03871A80"] = "G",	--	"碧玉矿洞.ANDREA.SHAMAN"
	["Player-4497-03C3B443"] = "G",	--	"碧玉矿洞.ANDREA.MAGE"
	["Player-4497-03CC89ED"] = "G",	--	"碧玉矿洞.ANDREA.PALADIN"
	["Player-4497-03CD426F"] = "G",	--	"碧玉矿洞.ANDREA.WARLOCK"
	--
	["Player-4497-0393B39E"] = "D",	--	"碧玉矿洞.NETEASEUI"
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

if GetAddOnInfo("!!!!!DebugMe") then
	-->	Cross-Account Sync
	local pcall = pcall;
	local next = next;
	local strsub, strfind = string.sub, string.find;
	local tonumber = tonumber;
	local GetTime = GetTime;
	local C_Timer_After = C_Timer.After;
	local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
	local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
	local GetPlayerInfoByGUID = GetPlayerInfoByGUID;
	local UnitIsPlayer, UnitIsEnemy = UnitIsPlayer, UnitIsEnemy;
	local UnitName, UnitGUID = UnitName, UnitGUID;
	local UnitHealth, UnitHealthMax = UnitHealth, UnitHealthMax;
	local UnitPowerType, UnitPower, UnitPowerMax = UnitPowerType, UnitPower, UnitPowerMax;
	local UnitIsDead, UnitIsFeignDeath, UnitIsGhost = UnitIsDead, UnitIsFeignDeath, UnitIsGhost;
	local UnitPosition = UnitPosition;
	local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit;
	--
	local PREALM = GetRealmName();
	local ADDON_MSG_CONTROL_CODE_LEN = 6;
	local ADDON_PREFIX = "ALSTRM";
	local ADDON_MSG_QUERY = "_qstrm";
	local ADDON_MSG_REPLY = "_rstrm";
	--
	local E = {  };
	local S = nil;

	local H = {  };
	local function F_CacheName()
		for v1, v2 in next, H do
			if DEVELOPER[v1] == nil and DEVELOPER[v2] == nil then
				H[v1] = nil;
			end
		end
		local miss = false;
		for GUID, _ in next, DEVELOPER do
			local _, class, _, race, sex, name, realm = GetPlayerInfoByGUID(GUID);
			if name ~= nil then
				if realm == nil or realm == "" then
					realm = PREALM;
				end
				local fn = name .. "-" .. realm;
				H[fn] = GUID;
				H[GUID] = fn;
			else
				miss = true;
			end
		end
		if miss then
			C_Timer_After(1.0, F_CacheName);
		end
	end

	local EnterCombatTime = InCombatLockdown() and GetTime() or nil;
	local EncounterIDs = {  };
	function E.PLAYER_REGEN_DISABLED(F, event, ...)
		EnterCombatTime = GetTime();
	end
	function E.PLAYER_REGEN_ENABLED(F, event, ...)
		EnterCombatTime = nil;
		EncounterIDs = {  };
	end
	function E.ENCOUNTER_START(F, event, encounterID, encounterName, difficultyID, groupSize, success)
		EncounterIDs[encounterID] = GetTime();
	end
	function E.ENCOUNTER_END(F, event, encounterID, encounterName, difficultyID, groupSize)
		EncounterIDs[encounterID] = nil;
	end

	local function EncodeSelf()
		local dead = UnitIsDead('player');
		local fdead = UnitIsFeignDeath('player');
		local ghost = UnitIsGhost('player');
		local state = "0";
		if ghost then
			state = "g";
		elseif dead then
			if fdead then
				state = "f";
			else
				state = "d";
			end
		elseif fdead then
			state = "f";
		else
			state = "a";
		end
		local CH = tostring(UnitHealth('player') or -1);
		local MH = tostring(UnitHealthMax('player') or -1);
		local PT = tostring(UnitPowerType('player') or -1);
		local CP = tostring(UnitPower('player') or -1);
		local MP = tostring(UnitPowerMax('player') or -1);
		local map = C_Map_GetBestMapForUnit('player');
		local y, x, _z, instance = UnitPosition('player');
		if map == nil then
			if instance == nil then
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..                         "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
			else
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..  tostring(-instance) .. "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
			end
		else
				return state .. "~" .. CH .. "~" .. MH .. "~" .. PT .. "~" .. CP .. "~" .. MP .. "~" ..  tostring(map) ..       "~" .. format("%.3f", x or -1) .. "~" .. format("%.3f", y or -1);
		end
	end
	function E.CHAT_MSG_ADDON(F, event, ...)
		local prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID = ...;
		if prefix == ADDON_PREFIX then
			local fn = strfind(sender, "-") == nil and (sender .. "-" .. PREALM) or sender;
			if H[fn] ~= nil then
				local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
				if control_code == ADDON_MSG_QUERY then
					local _, c, rep = strsplit("`", msg);
					if EnterCombatTime == nil then
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY .. "~a~" .. EncodeSelf(), "WHISPER", sender);
					else
						local now = GetTime();
						local msg = EncodeSelf() .. "~" .. format("%.3f", now - EnterCombatTime);
						if UnitExists('target') then
							if UnitIsEnemy('player', 'target') and not UnitIsPlayer('target') then
								local name = UnitName('target') or "unk";
								local GUID = UnitGUID('target');
								if GUID == nil then
									GUID = "-1";
								else
									GUID = select(6, strsplit("-", GUID)) or "-1";
								end
								local h = UnitHealth('target') or -1;
								local m = UnitHealthMax('target') or -1;
								msg = msg .. "~" .. name .. "~" .. GUID .. "~" .. h .. "~" .. m;
							elseif UnitExists('targettarget') and UnitIsEnemy('player', 'targettarget') and not UnitIsPlayer('targettarget') then
								local name = UnitName('targettarget') or "unk";
								local GUID = UnitGUID('targettarget');
								if GUID == nil then
									GUID = "-1";
								else
									GUID = select(6, strsplit("-", GUID)) or "-1";
								end
								local h = UnitHealth('targettarget') or -1;
								local m = UnitHealthMax('targettarget') or -1;
								msg = msg .. "~" .. name .. "~" .. GUID .. "~" .. h .. "~" .. m;
							else
								msg = msg .. "~~~~";
							end
						else
							msg = msg .. "~~~~";
						end
						if next(EncounterIDs) == nil then
							msg = ADDON_MSG_REPLY .. "~b~" .. msg;
							SendAddonMessage(ADDON_PREFIX, msg, "WHISPER", sender);
						else
							msg = ADDON_MSG_REPLY .. "~c~" .. msg;
							for id, t in next, EncounterIDs do
								msg = msg .. "~" .. tostring(id) .. "~" .. format("%.3f", now - t);
							end
							SendAddonMessage(ADDON_PREFIX, msg, "WHISPER", sender);
						end
					end
					if c == 'single' then
						rep = 1;
						SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY .. tostring(S[S.__top]), "WHISPER", sender);
						S.__top = S.__top + 1;
						if S.__top > 1024 then
							S.__top = 1;
						end
					else
						rep = tonumber(rep) or 1;
						for index = 1, rep do
							SendAddonMessage(ADDON_PREFIX, ADDON_MSG_REPLY .. tostring(S[S.__top]), "WHISPER", sender);
							S.__top = S.__top + 1;
							if S.__top > 1024 then
								S.__top = 1;
							end
						end
					end
				elseif control_code == ADDON_MSG_REPLY then
					if __ala_meta__.__onstream ~= nil then
						__ala_meta__.__onstream(strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1));
					end
				end
			end
		end
	end
	function E.LOADING_SCREEN_DISABLED(F, event, ...)
		F:UnregisterEvent("LOADING_SCREEN_DISABLED");
		RegisterAddonMessagePrefix(ADDON_PREFIX);
		E.LOADING_SCREEN_DISABLED = nil;
		--
		F_CacheName();
		EnterCombatTime = InCombatLockdown() and GetTime() or nil;
		S = __ala_meta__.__streambuffer or { __top = 1, };
		__ala_meta__.__streambuffer = S;
		for index = 1, 1024 do
			S[index] = strchar(33 + random(1, 1024) % 64);
		end
		for event, callback in next, E do
			F:RegisterEvent(event);
		end
	end
	--
	if __ala_meta__.__streambufferframe == nil then
		local F = CreateFrame('FRAME');
		F:RegisterEvent("LOADING_SCREEN_DISABLED");
		if DEVELOPER[UnitGUID('player')] ~= nil then
			F:SetScript("OnEvent", function(F, event, ...)
				local callback = E[event];
				if callback ~= nil then
					callback(F, event, ...);
				end
			end);
		else
			F:SetScript("OnEvent", function(F, event, ...)
				local callback = E[event];
				if callback ~= nil then
					pcall(callback, F, event, ...);
				end
			end);
		end
		__ala_meta__.__streambufferframe = F;
	else
		local F = __ala_meta__.__streambufferframe;
		F:UnregisterAllEvents();
		if DEVELOPER[UnitGUID('player')] ~= nil then
			F:SetScript("OnEvent", function(F, event, ...)
				local callback = E[event];
				if callback ~= nil then
					callback(F, event, ...);
				end
			end);
		else
			F:SetScript("OnEvent", function(F, event, ...)
				local callback = E[event];
				if callback ~= nil then
					pcall(callback, F, event, ...);
				end
			end);
		end
		E.LOADING_SCREEN_DISABLED(F);
	end
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
		self:UnregisterEvent("LOADING_SCREEN_DISABLED");
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
