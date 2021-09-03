--[[--
	ALA@163UI
--]]--
local __version = 1;

_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __commlib = __ala_meta__.__commlib;
if __commlib ~= nil and __commlib.__minor >= __version then
	return;
end
if __commlib ~= nil then
	__commlib:UnregisterAllEvents();
	__commlib:SetScript("OnEvent", nil);
	if __commlib.Halt ~= nil then
		__commlib:Halt();
	end
else
	__commlib = CreateFrame('FRAME');
end
__commlib.__minor = __version;
__ala_meta__.__commlib = __commlib;

local _G = _G;
do
	-- if __commlib.__fenv == nil then
	-- 	__commlib.__fenv = setmetatable({  },
	-- 			{
	-- 				__index = _G,
	-- 				__newindex = function(t, key, value)
	-- 					rawset(t, key, value);
	-- 					print("commlib assign global", key, value);
	-- 					return value;
	-- 				end,
	-- 			}
	-- 		);
	-- end
	-- setfenv(1, __commlib.__fenv);
end

-->			upvalue
local time = time;
local strsub = strsub;
local _ = nil;
local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
local C_Timer_After = C_Timer.After;
local Ambiguate = Ambiguate;

__commlib.ADDON_MSG_CONTROL_CODE_LEN = 6;
__commlib.ADDON_PREFIX = "ALCOMM";
__commlib.ADDON_MSG_QUERY = "_q_tag";
__commlib.ADDON_MSG_REPLY = "_r_tag";
--
_, __commlib.CPlayerTAG = BNGetInfo();
__commlib.CPlayerGUID = UnitGUID('player');
__commlib.CPlayerName = UnitName('player');
__commlib.CRealmName = GetRealmName();
__commlib.CPlayerFullName = __commlib.CPlayerName .. "-" .. __commlib.CRealmName;

-->		NetBuffer
	local MAX_PER_SLICE = 11;
	local MAX_PER_BLOCK = 110;
	local LEN_SLICE = 0.5;
	local LEN_BLOCK = 10.0;
	local Buffer = {  };
	local Pos = 1;
	local Top = 0;
	--
	local BlockSent = MAX_PER_BLOCK;
	local isFlushBlockTimerIdle = true;
	local function _BlockFlush()
		BlockSent = MAX_PER_BLOCK;
		if Top >= Pos then
			C_Timer_After(LEN_BLOCK, _BlockFlush);
		else
			isFlushBlockTimerIdle = true;
		end
	end
	--
	local SliceSent = MAX_PER_SLICE;
	local isFlushSliceTimerIdle = true;
	local function _SliceFlush()
		SliceSent = MAX_PER_SLICE;
		if Top >= Pos then
			while BlockSent > 0 and SliceSent > 0 do
				local b = Buffer[Pos];
				Buffer[Pos] = nil;
				SendAddonMessage(__commlib.ADDON_PREFIX, b[1], b[2], b[3]);
				SliceSent = SliceSent - 1;
				BlockSent = BlockSent - 1;
				Pos = Pos + 1;
				if Top < Pos then
					Pos = 1;
					Top = 0;
					break;
				end
			end
		end
		if SliceSent > 0 then
			isFlushSliceTimerIdle = true;
		else
			C_Timer_After(LEN_SLICE, _SliceFlush);
		end
	end
	--
	local function _SendFunc(msg, channel, target)
		if BlockSent > 0 and SliceSent > 0 then
			SliceSent = SliceSent - 1;
			BlockSent = BlockSent - 1;
			SendAddonMessage(__commlib.ADDON_PREFIX, msg, channel, target);
		else
			Top = Top + 1;
			Buffer[Top] = { msg, channel, target, };
		end
		if isFlushSliceTimerIdle then
			isFlushSliceTimerIdle = false;
			C_Timer_After(LEN_SLICE, _SliceFlush);
		end
		if isFlushBlockTimerIdle then
			isFlushBlockTimerIdle = false;
			C_Timer_After(LEN_BLOCK, _BlockFlush);
		end
	end
	_SliceFlush();
-->
-->
local _TThrottle = {  };		--	1s lock
local function CHAT_MSG_ADDON(self, event, prefix, msg, channel, sender, target, zoneChannelID, localID, name, instanceID)
	if prefix == __commlib.ADDON_PREFIX then
		local name = Ambiguate(sender, 'none');
		local control_code = strsub(msg, 1, __commlib.ADDON_MSG_CONTROL_CODE_LEN);
		if control_code == __commlib.ADDON_MSG_QUERY then
			local now = time();
			local prev = _TThrottle[name];
			if prev ~= nil and now - prev <= 1 then
				return;
			end
			--
			if channel == "INSTANCE_CHAT" then
				local target = strsub(msg, __commlib.ADDON_MSG_CONTROL_CODE_LEN + 2, - 1);
				if target ~= __commlib.CPlayerFullName then
					return;
				end
			end
			_TThrottle[name] = now;
			local code = __commlib.CPlayerTAG .. "`" .. __commlib.CPlayerGUID .. "`" .. __commlib.CPlayerFullName;
			if channel == "INSTANCE_CHAT" then
				_SendFunc(__commlib.ADDON_MSG_REPLY .. code .. "`" .. sender, "INSTANCE_CHAT");
			else--if channel == "WHISPER" then
				_SendFunc(__commlib.ADDON_MSG_REPLY .. code, "WHISPER", sender);
			end
		end
	end
end

local function LOADING_SCREEN_DISABLED()
	__commlib:UnregisterEvent("LOADING_SCREEN_DISABLED");
	if RegisterAddonMessagePrefix(__commlib.ADDON_PREFIX) then
		__commlib:RegisterEvent("CHAT_MSG_ADDON");
		__commlib:SetScript("OnEvent", CHAT_MSG_ADDON);
	end
end
__commlib:RegisterEvent("LOADING_SCREEN_DISABLED");
__commlib:SetScript("OnEvent", LOADING_SCREEN_DISABLED);

function __commlib:Halt()
	Pos = 1;
	Top = 0;
end
