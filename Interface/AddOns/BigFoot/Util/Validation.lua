
if (GetLocale() == "zhCN") then
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 您的大脚版本已过期，请用大脚客户端更新，最新版本为:%s，大脚插件由178游戏网(www.178.com)制作.|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 您的大脚版本错误，请重新用大脚客户端更新，大脚插件由178游戏网(www.178.com)制作.|r"
elseif (GetLocale() == "zhTW") then
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 您的大腳版本已過期，請用大腳客戶端更新，最新版本為:%s，大腳插件由178游戲網(www.178.com)制作。|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 您的大脚版本錯誤，请重新用大脚客户端更新，大脚插件由178游戏网(www.178.com)制作.|r"
else
	BF_TEXT_UPDATETOVERSION = "|CFFFFD000 Your BigFoot version is outdated, please upgrade to current version %s|r"
	BF_TEXT_WRONGVERSION = "|CFFFFD000 Your BigFoot version is incorrect, please download again.|r"
end

StaticPopupDialogs["BFUPDATE"] = {
	button1 = OKAY,
	OnAccept = function()
	end,
	showAlert = 1,
	timeout = 9,
    preferredIndex = STATICPOPUP_NUMDIALOGS,
};

local e = BLibrary("BEvent")
local BMath = BLibrary("BMathClass")

local function sameLocale(a,b)
	local localea = a:match("[a-zA-Z]+")
	local localeb = b:match("[a-zA-Z]+")
	if not localea or not localeb then return true end
	--to be compatible with old version
	if localea ~= localeb then
		return false
	else
		return true
	end
end

local function larger(a,b)
	local adt = {}
	local bdt = {}
	local ad,bd
	for ad in a:gmatch("%d+") do
		tinsert(adt,tonumber(ad))
	end
	for bd in b:gmatch("%d+") do
		tinsert(bdt,tonumber(bd))
	end

	for i = 1,4 do
		-- for classic check
		if i == 1 then
			if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
				if adt[i] ~= 1 or bdt[i] ~= 1 then
					BigFoot_Config["BIGFOOT_VERSION_NEW"] = BIGFOOT_VERSION
					return;
				end
			elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
				if adt[i] ~= 2 or bdt[i] ~= 2 then
					BigFoot_Config["BIGFOOT_VERSION_NEW"] = BIGFOOT_VERSION
					return;
				end
			end
		end
		
		if adt[i] > bdt[i] then return true end
	end
	return false
end

local function printVersion(version)
	BigFoot_Print(format(BF_TEXT_UPDATETOVERSION,version))
	StaticPopupDialogs["BFUPDATE"].text = format(BF_TEXT_UPDATETOVERSION,version)
	StaticPopup_Show("BFUPDATE");
end

local function printWrongVersion()
	BigFoot_Print(BF_TEXT_WRONGVERSION)
	StaticPopupDialogs["BFUPDATE"].text = BF_TEXT_WRONGVERSION
	StaticPopup_Show("BFUPDATE");
end

local function checkVersion(message)
	if not BigFoot_Config["BIGFOOT_VERSION_NEW"] then
		BigFoot_Config["BIGFOOT_VERSION_NEW"] = BIGFOOT_VERSION
	elseif sameLocale(BigFoot_Config["BIGFOOT_VERSION_NEW"],BIGFOOT_VERSION) and larger(BIGFOOT_VERSION,BigFoot_Config["BIGFOOT_VERSION_NEW"]) then
		BigFoot_Config["BIGFOOT_VERSION_NEW"] = BIGFOOT_VERSION
	end
	if(sameLocale(BigFoot_Config["BIGFOOT_VERSION_NEW"],message) and larger(message,BigFoot_Config["BIGFOOT_VERSION_NEW"])) then
		BigFoot_Config["BIGFOOT_VERSION_NEW"] = message;
	end
end

local function isValid(message)
	local i = 1;
	local checksum,version
	for word in string.gmatch(message,"([^|]+)") do
		if i == 1 then
			checksum = word
		elseif i == 2 then
			version = word
		end
		i = i + 1;
	end
	if checksum and version and checksum == BMath:LRC(version) then return true end
	return false
end

-- 老虎会游泳：禁用大脚版本检查
--e:RegisterEvent("PLAYER_LOGIN");

function e:PLAYER_LOGIN()
	if not isValid(BF_VERSION_CHECKSUM.."|"..BIGFOOT_VERSION) then
		printWrongVersion();
		return;
	else
		C_ChatInfo.RegisterAddonMessagePrefix("BF_VER_CHK");
		self:RegisterEvent("CHAT_MSG_ADDON");
		self:RegisterEvent("GROUP_ROSTER_UPDATE")
	end
	if not BigFoot_Config["BIGFOOT_VERSION_NEW"] then
		BigFoot_Config["BIGFOOT_VERSION_NEW"] = BIGFOOT_VERSION
	elseif not sameLocale(BigFoot_Config["BIGFOOT_VERSION_NEW"],BIGFOOT_VERSION) then
		BigFoot_Config["BIGFOOT_VERSION_NEW"] = BIGFOOT_VERSION
	elseif larger(BIGFOOT_VERSION,BigFoot_Config["BIGFOOT_VERSION_NEW"]) then
		BigFoot_Config["BIGFOOT_VERSION_NEW"] = BIGFOOT_VERSION
	end
	if sameLocale(BigFoot_Config["BIGFOOT_VERSION_NEW"],BIGFOOT_VERSION) and larger(BigFoot_Config["BIGFOOT_VERSION_NEW"],BIGFOOT_VERSION) then
		printVersion(BigFoot_Config["BIGFOOT_VERSION_NEW"])
	end
end

function e:CHAT_MSG_ADDON(...)
	local filter,message,_,sender =...
	if(filter == "BF_VER_CHK") then
		if sender and not sender:find(UnitName("player")) then
			if not isValid(message)then return end
			local version = string.sub(message, string.find(message, "|(.+)")+1)
			checkVersion(version)
		end
	end
end

local hasSend;
function e:GROUP_ROSTER_UPDATE()
	if IsInRaid() then
		if not hasSend then
			BigFoot_DelayCall(function()
				C_ChatInfo.SendAddonMessage("BF_VER_CHK",BF_VERSION_CHECKSUM.."|"..BIGFOOT_VERSION,(IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "RAID")
			end,1);
			hasSend = true;
		end
	else
		if not hasSend and GetNumSubgroupMembers() >= 1 then
			BigFoot_DelayCall(function()
				C_ChatInfo.SendAddonMessage("BF_VER_CHK",BF_VERSION_CHECKSUM.."|"..BIGFOOT_VERSION,(IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and "INSTANCE_CHAT") or "PARTY")
			end,1);
			hasSend = true;
		elseif GetNumSubgroupMembers() == 0 then
			hasSend = nil;
		end
	end
end

----also put ace validation here
local _LibStubVersion = 2

local __AceVersionTable = {
	["AceLibrary"] = 91091,
	["AceOO-2.0"] = 91091,
	["AceEvent-2.0"] = 91097,
	["AceDB-2.0"] = 91094,
	["AceDebug-2.0"] = 91091,
	["AceLocale-2.2"] = 91094,
	["AceConsole-2.0"] = 91094,
	["AceAddon-2.0"] = 91100,
	["AceHook-2.1"] = 91091,
	["AceModuleCore-2.0"] = 91091,
	["CallbackHandler-1.0"] = 5,

	["AceAddon-3.0"] = 5,
	["AceEvent-3.0"] = 3,
	["AceTimer-3.0"] = 5,
	["AceBucket-3.0"] = 3,
	["AceHook-3.0"] = 5,
	["AceDB-3.0"] = 21,
	["AceDBOptions-3.0"] = 12,
	["AceLocale-3.0"] = 2,
	["AceConsole-3.0"] = 7,
	["AceGUI-3.0"] = 33,
	["AceConfig-3.0"] = 2,
	["AceConfigRegistry-3.0"] = 12,
	["AceConfigTab-3.0"] = 1,
	["AceConfigCmd-3.0"] = 12,
	["AceConfigDialog-3.0"] = 49,
	["AceComm-3.0"] = 6,
	["AceTab-3.0"] = 8,
	["AceSerializer-3.0"] = 3,
	["AceGUISharedMediaWidgets-1.0"] = 32,


	["Abacus-2.0"] = 92247000,
	["LibCrayon-3.0"] = 91800,
	["LibQuixote-2.0"] = 90180,
	["LibBossIDs-1.0"] = 44,
	["Dewdrop-2.0"] = 90320,
	["FuBarPlugin-MinimapContainer-2.0"] = 90003,
	["LibAboutPanel"] = 1,
	["Roster-2.1"] = 90092,
	["LibBabble-Boss-3.0"] = 90298,
	["LibBabble-Class-3.0"] = 90050,
	["LibBabble-3.0"] = 2,
	["LibBabble-Inventory-3.0"] = 90101,
	["LibDBIcon-1.0"] = 11,
	["LibAbacus-3.0"] = 92247,
	["Waterfall-1.0"] = 90130,

	["Gratuity-2.0"] = 70090039,
	["CandyBar-2.0"] = 90154,
	["LibGraph-2.0"] = 90041,
	["Tablet-2.0"] = 90216,
	["LibStatLogic-1.1"] = 92,
	["LibGratuity-3.0"] = 90039,
	["LibDualSpec-1.0"] = 4,
	["LibPeriodicTable-3.1"] = 90006,
	["LibBabble-Zone-3.0"] = 90279,
	["LibTourist-3.0"] = 90098,
	["LibSink-2.0"] = 90063,
	["LibDataBroker-1.1"] = 4,
	["LibBabble-Spell-3.0"] = 90123,
	["LibSimpleFrame-1.0"] = 90046,
	["LibSharedMedia-3.0"] = 90058,
	["Window-1.0"] = 90034,
	["LibBanzai-2.0"] = 90040,
	["LibTipHooker-1.1"] = 11,
	["LibHealComm-4.0"] = 66,
	["Crayon-2.0"] = 91800000,
	["FuBarPlugin-2.0"] = 90003,

}

local function existAssert(_libName)
	if _G[_libName] or LibStub:GetLibrary(_libName,true) then return true end
	print(("|cffff0000<Version Check>|r%s does not exist!"):format(_libName))
	return false
end

local function versionAssert(_exp,_act,_libName)
	if not _exp == _act then
		print (("|cffff0000<Version Check>|r %s version incorrect! expect: %s, found: %s !"):format(_libName,_exp,_act))
	end
end

function ValidateAceLibs()
	local _versionExp,_versionAct

	--check LibStub
	if not existAssert("LibStub") then return end
	versionAssert(_LibStubVersion,LibStub.minor,"LibStub")

	for _major,minorExp in pairs(__AceVersionTable) do
		if existAssert(_major) then
			local _,_minorAct = LibStub:GetLibrary(_major,true);
			versionAssert(_minorAct,minorExp,_major)
		end
	end
	print("|cff00FF00<Version Check>|r Validation passed, All AceLibs are in correct versions!")
end
