--[[--
	alex/ALA @ 163UI
--]]--

_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;

local _;

if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	__ala_meta__.MAX_LEVEL = 60;
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
	__ala_meta__.MAX_LEVEL = 70;
else
	__ala_meta__.MAX_LEVEL = GetMaxLevelForExpansionLevel(GetExpansionLevel()) or 60;
end
_, __ala_meta__.CPlayerTAG = BNGetInfo();
__ala_meta__.CPlayerGUID = UnitGUID('player');
__ala_meta__.CPlayerName = UnitName('player');
__ala_meta__.CRealmName = GetRealmName();
__ala_meta__.CPlayerFullName = __ala_meta__.CPlayerName .. "-" .. __ala_meta__.CRealmName;
__ala_meta__.CPlayerFullName_Len = #(__ala_meta__.CPlayerFullName);
__ala_meta__.CPlayerFactionGroup = UnitFactionGroup('player');
__ala_meta__.CPlayerClass = UnitClassBase('player');
__ala_meta__.CPlayerClassUpper = strupper(__ala_meta__.CPlayerClass);
__ala_meta__.CPlayerClassLower = strlower(__ala_meta__.CPlayerClass);


local _, name, desc, loadable, reason, security, newversion = GetAddOnInfo("!!!!!DebugMe");
__ala_meta__.__SYNC = {
	REALTIME = name ~= nil,
	ONLOGIN = false,
	ONLOGOUT = false,
};
__ala_meta__.__SYNCREALTIME = name ~= nil;
__ala_meta__.__SYNCONLOGIN = false;
__ala_meta__.__SYNCONLOGOUT = false;

