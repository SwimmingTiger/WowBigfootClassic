--[[--
	ALA@163UI
--]]--
local __version = 3;

_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __mapshare = __ala_meta__.__mapshare
if __mapshare ~= nil and __mapshare.__minor >= __version then
	return;
end
local __mapshare = __mapshare or CreateFrame('FRAME');
__mapshare.__minor = __version;
__ala_meta__.__mapshare = __mapshare;

local _G = _G;
do
	-- if __mapshare.__fenv == nil then
	-- 	__mapshare.__fenv = setmetatable({  },
	-- 			{
	-- 				__index = _G,
	-- 				__newindex = function(t, key, value)
	-- 					rawset(t, key, value);
	-- 					print("instlib assign global", key, value);
	-- 					return value;
	-- 				end,
	-- 			}
	-- 		);
	-- end
	-- setfenv(1, __mapshare.__fenv);
end

-->			upvalue
local strsplit, strsub = strsplit, strsub;
local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit;
local UnitPosition = UnitPosition;

__mapshare.ADDON_PREFIX = "AMSADD";
__mapshare.ADDON_MSG_MAP_PULL = "_pull_";
__mapshare.ADDON_MSG_MAP_PUSH = "_push_";
local function GetMapPosition()
	local map = C_Map_GetBestMapForUnit('player');
	local y, x, _z, instance = UnitPosition('player');
	if x ~= nil and y ~= nil then
		return map, x, y;
	end
end
local function CHAT_MSG_ADDON(_, _, prefix, msg, channel, sender)
	if prefix == __mapshare.ADDON_PREFIX then
		local control_code = strsub(msg, 1, ADDON_MSG_CONTROL_CODE_LEN);
		if control_code == __mapshare.ADDON_MSG_MAP_PULL then
			local map, x, y = GetMapPosition();
			if map == nil then
				map = -1;
				x, y = 0, 0;
			end
			SendAddonMessage(prefix, __mapshare.ADDON_MSG_MAP_PUSH .. map .. "#" .. x .. "#" .. y, "WHISPER", sender);
		elseif control_code == __mapshare.ADDON_MSG_MAP_PUSH then
			if __ala_meta__.____OnMapPositionReceived ~= nil then
				local map, x, y = strsplit("#", strsub(msg, ADDON_MSG_CONTROL_CODE_LEN + 1));
				if map ~= nil and x ~= nil and y ~= nil then
					map = tonumber(map);
					x = tonumber(x);
					y = tonumber(y);
					if map ~= nil and x ~= nil and y ~= nil then
						__ala_meta__.____OnMapPositionReceived(sender, map, x, y);
					end
				end
			end
		end
	end
end
function __mapshare.PullPosition(name)
	SendAddonMessage(__mapshare.ADDON_PREFIX, "_pull_", "WHISPER", Ambiguate(name, 'none'));
end

if RegisterAddonMessagePrefix(__mapshare.ADDON_PREFIX) then
	__mapshare:RegisterEvent("CHAT_MSG_ADDON");
	__mapshare:SetScript("OnEvent", CHAT_MSG_ADDON);
end
