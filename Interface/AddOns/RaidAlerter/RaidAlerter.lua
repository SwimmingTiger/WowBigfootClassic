-- 使用 "LibThreatClassic2" 库提供的仇恨接口
local ThreatLib = LibStub("LibThreatClassic2", true)

local UnitThreatSituation = function (...)
    return ThreatLib:UnitThreatSituation (...)
end

local UnitDetailedThreatSituation = function (...)
    return ThreatLib:UnitDetailedThreatSituation (...)
end

-- provisional
UnitGroupRolesAssigned = UnitGroupRolesAssigned or function() return "" end


--初始设置
RaidAlerter_SET = {
OnOff = true,						--启用警报
RAIDMODE_MAX_GROUP = 5,				--团队模式
Party_Alerter = true,				--5人小队
OnlySelfCHAN = false,				--仅本机
OnlySelfSCR = false,				--仅本屏
SoundAlert = true,					--音效
TextMShow_OnOff = true,				--状态条
AF_Scale = 1,						--缩放比例
MAXRAM = 416,						--内存清理
BossHealthPecentOnOff = true,		--Boss血量
BossHealthPecent = 10,				--通报上限
BossKill = true,					--最后一击
TANK_DangerHealth = true,			--TANK血量
TANK_DangerHealthPecent = 30,		--危急上限
TANK_Death = true,					--TANK阵亡
TANK_ShieldWall = true,				--盾墙
TANK_LastStand = true,				--破釜沉舟
TANK_ShieldReflection = true,		--法术反射
ScrMsg = true,						--屏幕讯息
THREATCheck = true,					--仇恨提示
ToTCheck = true,					--目标提示
SpellIDAndCaster = true,			--法编和源
OT_OnOff = true,					--OT通告
OTM_OnOff = false,					--OT密语
OTMShow_OnOff = false,				--显示发送
Hunter_Mark = false,				--猎人标记
Hunter_Misdirection = true,			--猎人误导
Hunter_Shot = true,					--猎人宁神
TANK_Taunt = true,					--抵抗嘲讽
RES_DispelMagic = true,				--抵抗驱散
RES_Polymorph = true,				--抵抗变形
RES_MagicBreak = true,				--抵抗反制
RES_BuffStolen = true,				--抵抗法偷
Check_Poly = true,					--被控制
PolyDispel = true,					--解除控制
Break_Poly = true,					--打破控制
Dispel_Magic = true,				--魔法驱散
BuffStolen = true,					--法术偷取
Break_Magic = true,					--魔法打断
Check_Gem = true,					--战斗复活
Paladin_Intervention = true,		--神圣干涉
Check_Death_AtCombatEnd = true,		--阵亡通报
Nef_PriestDown = false,				--堕落(NEF)
Nef_TANKPoly = false,				--变形(NEF)
TAQ_Twin_AOEAdd = false,			--Add(双子)
ShowSysInfo = false,				--显示占用
cameraMax = false,					--增大镜头
RaidSpell = true,					--团队物件
};

RaidAlerter = {};
RAL = {};
RaidAlerter_UINameEN = "RaidAlerter";
RaidAlerter_Version = GetAddOnMetadata("RaidAlerter", "Version");
RaidAlerter_MainLabel = RaidAlerter_UINameEN.." |cFFDDDDDDv"..RaidAlerter_Version.."|r";

BINDING_HEADER_RaidAlerter_BINDING_TopTitle = RaidAlerter_UINameEN..RaidAlerter_UIName;
BINDING_NAME_RaidAlerter_BINDING_Title1 = RAL_TEXT_BINDING_1;
BINDING_NAME_RaidAlerter_BINDING_Title2 = RAL_TEXT_BINDING_2;
BINDING_NAME_RaidAlerter_BINDING_Title3 = RAL_TEXT_BINDING_3;
BINDING_NAME_RaidAlerter_BINDING_Title4 = RAL_TEXT_XML_1;
BINDING_NAME_RaidAlerter_BINDING_Title5 = RAL_TEXT_XML_3;
BINDING_NAME_RaidAlerter_BINDING_Title6 = RAL_TEXT_XML_12;
BINDING_NAME_RaidAlerter_BINDING_Title7 = RAL_TEXT_XML_15;

RaidAlerter_SYNC_SELECT_TMPPRA = 0;
RaidAlerter_SYNC_SELECT_TOME = 1;
RaidAlerter_SYNC_SELECT_SETTOME = 0;
RaidAlerter_SYNC_SELECT_NAME = "|cFFFF0000"..RAL_TEXT_SYNC_SELECT_NONE.."|r";
RaidAlerter_SYNC_SELECT_NAME_MSG = 0;
RaidAlerter_SYNC_CHECKVER = 0;
RaidAlerter_SYNC_CHECKVERCOUNT = 0;
RaidAlerter_SYNC_VerPOINT = 23;
RaidAlerter_SYNC_MyStatus = "FFF";
RaidAlerter_SYNC_MyStatus_Last = "TTT";

RAL_BlzTanks = {};
RAL_Tanks = {};

RAL_UIMSG_TIMELIMIT = 0.5;	--Debug
RAL_DEBUG = false;

RaidAlerter_Alerter_System	= {
	["lasticon"]	= "0",
	["maxcn"]	= 0,
	["stcn"]	= 0,
	["stcntmp"]	= 0,
	["ctmp"]	= 0,
	["counttmp"]	= 0,
	["BossHealthPecentTMP"]	= 100,
	};

RaidAlerter_SOUND_DATA = {
	[1]	= 566558,
	[2]	= 567482,
	[3]	= 566564,
	[4]	= 568582,
	[5]	= 569200,
};

RaidAlerter_Alerter_dangerHealth = {};
RaidAlerter_Alerter_BeControled = {};
RaidAlerter_Alerter_ErrorCure = {};
for i = -4, 40 do
	local unit = "";
	if i < 0 then
		unit = "party"..abs(i);
	elseif i == 0 then
		unit = "player";
	else
		unit = "raid"..i;
	end
	RaidAlerter_Alerter_dangerHealth[unit] = 0;
	RaidAlerter_Alerter_BeControled[unit] = 0;
	RaidAlerter_Alerter_ErrorCure[unit] = 0;
end

local _;
local _G = _G;
local TankingPlayer="";
local RaidAlerter_Raid_DeadMsg = false;
local RaidAlerter_RaidAllInCombat = false;
local RaidAlerter_RaidCombatEnd_CheckRAM = false;
local ManaPercent=0;
local CureManaPercent=0;
local DeadRaidmembers=0;
local OffLineRaidmembers=0;
local RaidNum = 0;
local RaidNumALL = 0;
local Attack_Frame_UPDATE_FREQ = 2;
local RaidAlerter_MT_Dead = {};
local GemName={};
local RaidAlerter_Check_CPU_DATA=0;
local RaidAlerter_Check_RAM_DATA=0;
local TempUnit1, TempUnit2, TempUnit3;
local Timer_NOW, Timer_START;
local subgroup = 9999;
local RaidAlerter_ChkMyHP = false;
local RaidAlerter_MyDangerHP = 30;
local RaidAlerter_BattleTime_This = 0;
local RaidAlerter_BattleTime_Last = 0;
local RaidAlerter_BattleTime_Record = false;
local AlertChan = "RAID";
local AlertWChan = "RAID_WARNING";
local SameIDPolyBreakCount = 0;
local LastPolyBreakID;
local ICONTEXT_unit;
local ICONTEXT_icon;
local ICONTEXT_icontext = "";
local TeamLevel = UnitLevel("player");
local RaidHPMAXAVG = UnitHealthMax("player");
local PartyHPMAXAVG = UnitHealthMax("player");
local BossHPMin = 999999999;
local DangerUnitHPMin = 666666666;
local MyLastThreatState = 0;
local FouTarISME = false;
local TarTarISME = false;
local ImTANK = false;
local RosterChanged = true;
local RAL_LootMethod 	= {
	["freeforall"]	= RAL_TEXT_LOOT_FREE_FOR_ALL,
	["roundrobin"]	= RAL_TEXT_LOOT_ROUND_ROBIN,
	["master"]	= RAL_TEXT_LOOT_MASTER_LOOTER,
	["group"]	= RAL_TEXT_LOOT_GROUP_LOOT,
	["needbeforegreed"]	= RAL_TEXT_LOOT_NEED_BEFORE_GREED,
	};
local RAL_LootMethod_SYS 	= {
	["freeforall"]	= LOOT_FREE_FOR_ALL,
	["roundrobin"]	= LOOT_ROUND_ROBIN,
	["master"]	= LOOT_MASTER_LOOTER,
	["group"]	= LOOT_GROUP_LOOT,
	["needbeforegreed"]	= LOOT_NEED_BEFORE_GREED,
	};
local RAL_NextUpdateTime = 0;
local RAL_UIMSG_PREFIX;
local RAL_UIMSG_MSG;
local RAL_UIMSG_CHAN;
local RAL_UIMSG_SENDED = true;
local SysDif = 1;
local EQDif = 1;
local DifText = "";
local instanceType, difficulty, maxPlayers, playerDifficulty, isDynamicInstance;
-- new add 增加 otherPara1,otherPara2
local timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, spellId, spellName, spellSchool, auraType, amount, otherPara1,otherPara2;
local srcName_bak,dstName_bak
local COOKFOODDUR = 0;
local BCC_Check_START = false;
local BCC_Check_timestamp;
local BCC_Check_spellName;
local BCC_Check_spellId;
local BCC_Check_dstGUID;

--3.2-4.0过渡
local UnitPower = UnitPower;
local UnitPowerMax = UnitPowerMax;

--事件注册
local RaidAlerter_EVENT_LIST = {
	"ADDON_LOADED",
	"VARIABLES_LOADED",
	"PLAYER_ENTERING_WORLD",
	"CHAT_MSG_ADDON",
	"CHAT_MSG_WHISPER_INFORM",
	"CHAT_MSG_WHISPER",
	"COMBAT_LOG_EVENT_UNFILTERED",
	-- "UNIT_THREAT_SITUATION_UPDATE",
	"PLAYER_REGEN_ENABLED",
	"GROUP_ROSTER_UPDATE",
	"UNIT_PHASE",
	"UPDATE_INSTANCE_INFO",
	-- "PLAYER_DIFFICULTY_CHANGED",
	"ZONE_CHANGED_NEW_AREA",
	};

-----------------------------------------------------------------------------
--Terry@bf
function BF_RaidAlerter_LoadPosition(self)
	self:ClearAllPoints();
	self:SetPoint(unpack(RaidAlerter_SET_AttackFramePosition))
end

function BF_RaidAlerter_SavePosition(self)
	local _point,rel,relp,xo,yo=self:GetPoint()
	RaidAlerter_SET_AttackFramePosition={_point,"UIParent",relp,xo,yo}
end
------------------------------------------------------------------------------

function RaidAlerter_OnEnter(self,action)
	GameTooltip:SetOwner(RaidAlerter_Attack_Frame, "ANCHOR_NONE");
	GameTooltip:SetText(RaidAlerter_UINameEN..RaidAlerter_UIName);
	GameTooltip:SetPoint("TOPLEFT", RaidAlerter_Attack_Frame, "BOTTOMLEFT", 0, 4);
	if GetNumGroupMembers()>0 then
		GameTooltip:AddLine(RAL_TEXT_TIP_35..": "..RaidAlerter_GetCurrentDifficulty(3));
		GameTooltip:AddLine(RaidAlerter_LootMethodTEXT(1));
		if RaidAlerter_BattleTime_Record then
			local m, s = RaidAlerter_SecondsToTime(RaidAlerter_GetTimer("BattleTime_Record"));
			if m == 0 then
				GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_1.." "..string.format(RAL_TEXT_TIP_4,"|cFFFFFFFF"..s.."|r"));
			else
				GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_1.." "..string.format(RAL_TEXT_TIP_5,"|cFFFFFFFF"..m.."|r","|cFFFFFFFF"..s.."|r"));
			end
		else
			if RaidAlerter_BattleTime_This == 0 then
				GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_2.." |cFFFFFFFF"..RAL_TEXT_NUL);
			else
				local m, s = RaidAlerter_SecondsToTime(RaidAlerter_BattleTime_This);
				if m == 0 then
					GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_2.." "..string.format(RAL_TEXT_TIP_4,"|cFFFFFFFF"..s.."|r"));
				else
					GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_2.." "..string.format(RAL_TEXT_TIP_5,"|cFFFFFFFF"..m.."|r","|cFFFFFFFF"..s.."|r"));
				end
			end
		end
		if RaidAlerter_BattleTime_Last == 0 then
			GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_3.." |cFFCCCCCC"..RAL_TEXT_NUL);
		else
			local m, s = RaidAlerter_SecondsToTime(RaidAlerter_BattleTime_Last);
			if m == 0 then
				GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_3.." "..string.format(RAL_TEXT_TIP_4,"|cFFCCCCCC"..s.."|r"));
			else
				GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_3.." "..string.format(RAL_TEXT_TIP_5,"|cFFCCCCCC"..m.."|r","|cFFCCCCCC"..s.."|r"));
			end
		end
		-- GameTooltip:AddLine(RaidAlerter_CheckPlayer("tip"));
		-- GameTooltip:AddLine(RaidAlerter_CheckPvP("tip"));
		-- GameTooltip:AddLine(RaidAlerter_CheckFlask("","tip"));
		-- GameTooltip:AddLine(RaidAlerter_CheckFlask("all","tip"));
		if not RaidAlerter_RaidAllInCombat then
			RaidAlerter_Check_SoulGemOn();
		end
		if #GemName==0 then
			GameTooltip:AddLine("|cFF99CCFF"..string.format(RAL_TEXT_TIP_6,"|cFFFF0000"..#GemName.."|cFF99CCFF").."|r");
		elseif #GemName<3 then
			GameTooltip:AddLine("|cFF99CCFF"..string.format(RAL_TEXT_TIP_6,"|cFFFFFFFF"..#GemName.."|cFF99CCFF")..": "..RaidAlerter_GetGemOnNames(1));
		else
			GameTooltip:AddLine("|cFF99CCFF"..string.format(RAL_TEXT_TIP_6,"|cFFFFFFFF"..#GemName.."|cFF99CCFF").."|r");
		end
		GameTooltip:AddLine(" ");
	elseif GetNumSubgroupMembers()>0 then
		GameTooltip:AddLine(RAL_TEXT_TIP_35..": "..RaidAlerter_GetCurrentDifficulty(3));
		GameTooltip:AddLine(RaidAlerter_LootMethodTEXT(1));
		GameTooltip:AddLine(RaidAlerter_CheckPlayer("tip"));
		GameTooltip:AddLine(" ");
	end

	GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_7.."|r");
	if IsControlKeyDown() then
		GameTooltip:AddLine(RAL_TEXT_TIP_8..": |cFFFFFFFF"..RAL_TEXT_TIP_14);
		GameTooltip:AddLine(RAL_TEXT_TIP_9..": |cFFFFFFFF"..RAL_TEXT_TIP_15);
		GameTooltip:AddLine(RAL_TEXT_TIP_10..": |cFFFFFFFF"..RAL_TEXT_TIP_16);
		GameTooltip:AddLine(RAL_TEXT_TIP_11.."+"..RAL_TEXT_TIP_8..": |cFFFFFFFF"..RAL_TEXT_TIP_17);
		GameTooltip:AddLine(RAL_TEXT_TIP_11.."+"..RAL_TEXT_TIP_9..": |cFFFFFFFF"..RAL_TEXT_TIP_18);
		GameTooltip:AddLine(RAL_TEXT_TIP_12.."+"..RAL_TEXT_TIP_8..": |cFFFFFFFF"..RAL_TEXT_TIP_19);
		GameTooltip:AddLine(RAL_TEXT_TIP_12.."+"..RAL_TEXT_TIP_9..": |cFFFFFFFF"..RAL_TEXT_TIP_20);
		GameTooltip:AddLine(RAL_TEXT_TIP_13.."+"..RAL_TEXT_TIP_8..": |cFFFFFFFF"..RAL_TEXT_TIP_21);
		GameTooltip:AddLine(RAL_TEXT_TIP_13.."+"..RAL_TEXT_TIP_9..": |cFFFFFFFF"..RAL_TEXT_TIP_22);
		GameTooltip:AddLine(RAL_TEXT_TIP_11.."+"..RAL_TEXT_TIP_12.."+"..RAL_TEXT_TIP_8..": |cFFFFFFFF"..RAL_TEXT_TIP_23);
	else
		GameTooltip:AddLine("|cFFFFFFFF"..RAL_TEXT_TIP_24);
	end
--显示系统资源占用。调试用
	if RaidAlerter_SET.ShowSysInfo then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_25.."|r");
		GameTooltip:AddLine(RaidAlerter_Check_RAM_CPU("tip"));
	end
	GameTooltip:Show();
end

function RaidAlerter_OnLoad(self)
	for K,valueB in pairs(RaidAlerter_EVENT_LIST) do
		self:RegisterEvent(valueB);
	end
	SLASH_RaidAlerter1 = "/raidalerter";
	SLASH_RaidAlerter2 = "/ral";
	SlashCmdList["RaidAlerter"] = function(msg)
		RaidAlerter_SlashCommand(msg);
	end
end

function RaidAlerter_SlashCommand(msg)
	msg = string.lower(msg);
	if ( not msg or msg == "") then
		RaidAlerter_Option_MainFrame_Show(self);
		return;
	elseif ( msg == "help" or msg == "?") then
		RaidAlerter.AddMsg("|cFF8000FF"..RaidAlerter_UINameEN.."|cFFFFFFFF"..RaidAlerter_UIName.." - |cFF5588FF"..RAL_TEXT_CMD_1..":", 1);
		RaidAlerter.AddMsg("/raidalerter "..RAL_TEXT_CMD_2.." /ral  |cFF5588FF"..RAL_TEXT_CMD_3, 1);
		RaidAlerter.AddMsg("/ral help "..RAL_TEXT_CMD_2.." /ral ?  |cFF5588FF"..RAL_TEXT_CMD_4, 1);
		RaidAlerter.AddMsg("/ral on|off  |cFF5588FF"..RAL_TEXT_CMD_5, 1);
--		RaidAlerter.AddMsg("/ral pa  |cFF5588FF"..RAL_TEXT_CMD_6, 1);
--		RaidAlerter.AddMsg("/ral ot  |cFF5588FF"..RAL_TEXT_CMD_7, 1);
--		RaidAlerter.AddMsg("/ral otm  |cFF5588FF"..RAL_TEXT_CMD_8, 1);
--		RaidAlerter.AddMsg("/ral otmshow  |cFF5588FF"..RAL_TEXT_CMD_9, 1);
--		RaidAlerter.AddMsg("/ral mark  |cFF5588FF"..RAL_TEXT_CMD_10, 1);
--		RaidAlerter.AddMsg("/ral show  |cFF5588FF"..RAL_TEXT_CMD_11, 1);
--		RaidAlerter.AddMsg("/ral resetshow  |cFF5588FF"..RAL_TEXT_CMD_12, 1);
--		RaidAlerter.AddMsg("/ral cp  |cFF5588FF"..RAL_TEXT_CMD_13, 1);
--		RaidAlerter.AddMsg("/ral pvp  |cFF5588FF"..RAL_TEXT_CMD_14, 1);
--		RaidAlerter.AddMsg("/ral gem  |cFF5588FF"..RAL_TEXT_CMD_15, 1);
		RaidAlerter.AddMsg("/ral hjjc "..RAL_TEXT_CMD_2.." /ral cb |cFF5588FF"..RAL_TEXT_CMD_16, 1);
		RaidAlerter.AddMsg("/ral tc "..RAL_TEXT_CMD_17.." |cFF5588FF"..RAL_TEXT_CMD_18, 1);
		RaidAlerter.AddMsg("/ral myhp  |cFF5588FF"..RAL_TEXT_CMD_19, 1);
		RaidAlerter.AddMsg("/ral showsysinfo  |cFF5588FF"..RAL_TEXT_CMD_20, 1);
		RaidAlerter.AddMsg("/ral cpustart  |cFF5588FF"..RAL_TEXT_CMD_21.." |cFFFF0000"..RAL_TEXT_CMD_22, 1);
		RaidAlerter.AddMsg("/ral cpustop  |cFF5588FF"..RAL_TEXT_CMD_23.." |cFFFF0000"..RAL_TEXT_CMD_22, 1);
--		RaidAlerter.AddMsg("/ral ramreset  |cFF5588FF"..RAL_TEXT_CMD_24, 1);
--		RaidAlerter.AddMsg("/ral reset  |cFF5588FF"..RAL_TEXT_CMD_25, 1);
		RaidAlerter.AddMsg("/ral status  |cFF5588FF"..RAL_TEXT_CMD_26, 1);
		return;
	end

	local cmd, param = msg:match("^([%w%-]+)%s*(.*)$");
	if ( cmd == "on" ) then
		RaidAlerter_SET_FUNC_OnOff(true);
	elseif ( cmd == "off" ) then
		RaidAlerter_SET_FUNC_OnOff(0);
	elseif ( cmd == "pa" ) then
		RaidAlerter_SET_FUNC_Party_Alerter("OnOff");
	elseif ( cmd == "ot" ) then
		RaidAlerter_SET_FUNC_OT_OnOff("OnOff");
	elseif ( cmd == "otm" ) then
		RaidAlerter_SET_FUNC_OTM_OnOff("OnOff");
	elseif ( cmd == "otmshow" ) then
		RaidAlerter_SET_FUNC_OTMShow_OnOff("OnOff");
	elseif ( cmd == "mark" ) then
		RaidAlerter_SET_FUNC_Hunter_Mark("OnOff");
	elseif ( cmd == "show" ) then
		RaidAlerter_SET_FUNC_TextMShow_OnOff("OnOff");
	elseif ( cmd == "resetshow" ) then
		RaidAlerter_SET_FUNC_TextMShow_Reset();
	elseif ( cmd == "cp" ) then
		RaidAlerter_CheckPlayer();
	elseif ( cmd == "pvp" ) then
		RaidAlerter_CheckPvP();
	elseif ( cmd == "gem" ) then
		RaidAlerter_CheckGem();
	elseif ( cmd == "hjjc" or cmd == "cb" or cmd == "checkbuff" or cmd == "checkflask" ) then
		RaidAlerter_CheckFlask(param);
	elseif ( cmd == "showsysinfo" ) then
		RaidAlerter_SET_FUNC_ShowSysInfo("OnOff");
	elseif ( cmd == "cpustart" ) then
		RaidAlerter_SET_FUNC_GTT_cpustart();
	elseif ( cmd == "cpustop" ) then
		RaidAlerter_SET_FUNC_GTT_cpustop();
	elseif ( cmd == "ramreset" ) then
		RaidAlerter_SET_FUNC_ResetRAM("reset");
	elseif ( cmd == "reset" ) then
		RaidAlerter_SET_FUNC_ResetToDefaut();
	elseif ( cmd == "status" ) then
		RaidAlerter_ListStatus();
		RaidAlerter_Check_CTRAORA_LA_TANKS();
	elseif ( cmd == "settome" ) then
		RaidAlerter_SET_FUNC_SYNC_SELECT_SETTOME();
	elseif ( cmd == "checkver") then
		if GetNumGroupMembers()>0 or UnitInRaid("player") or IsInInstance() then
			RaidAlerter_SYNC_CHECKVER = 1;
			RaidAlerter_SYNC_CHECKVERCOUNT = 0;
			RaidAlerter_StartTimer("SYNCCHECKVER");
			RaidAlerter.AddMsg(RAL_TEXT_SYNC_START_CHECK);
			RaidAlerter_SetAddonMessage("RAL_CHECKVER","startcheck");
		else
			RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTTEAM);
		end
	elseif ( cmd == "myhp" ) then
		RaidAlerter_SET_FUNC_CHK_MY_HP(param);
	elseif ( cmd == "tc" ) then
		RaidAlerter_Target_Check(param);
	else
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_CMD_27);
	end
end

function RaidAlerter_Option_MainFrame_Show(self)
	if (RaidAlerter_MainFrame:IsVisible()) then
		RaidAlerter_MainFrame:Hide();
		if GetNumGroupMembers()>0 or UnitInRaid("player") or IsInInstance() then
			RaidAlerter_SetAddonMessage("RAL_SELECT","startcheck");
			RaidAlerter_SYNC_SELECT_NAME_MSG = 1;
			RaidAlerter_StartTimer("SELECTNAMEMSG");
		end
	else
		RaidAlerter_MainFrame:Show();
		RaidAlerter_Option_MainFrame_Update();
		RaidAlerter_Check_CTRAORA_LA_TANKS();
	end
end

function RaidAlerter_Option_MainFrame_Update()
--更新选项菜单
	if (RaidAlerter_MainFrame:IsVisible()) then
		if RaidAlerter_SET.OnOff then RaidAlerterCheckLabel03_1:SetChecked(1) else RaidAlerterCheckLabel03_1:SetChecked(false) end
		if RaidAlerter_SET.Party_Alerter then RaidAlerterCheckLabel03_2:SetChecked(1) else RaidAlerterCheckLabel03_2:SetChecked(false) end
		if RaidAlerter_SET.OnlySelfCHAN then RaidAlerterCheckLabel03_3:SetChecked(1) else RaidAlerterCheckLabel03_3:SetChecked(false) end
		if RaidAlerter_SET.OnlySelfSCR then RaidAlerterCheckLabel03_4:SetChecked(1) else RaidAlerterCheckLabel03_4:SetChecked(false) end
		if RaidAlerter_SET.SoundAlert then RaidAlerterCheckLabel03_5:SetChecked(1) else RaidAlerterCheckLabel03_5:SetChecked(false) end
		if RaidAlerter_SET.ScrMsg then RaidAlerterCheckLabel03_6:SetChecked(1) else RaidAlerterCheckLabel03_6:SetChecked(false) end
		if RaidAlerter_SET.THREATCheck then RaidAlerterCheckLabel03_7:SetChecked(1) else RaidAlerterCheckLabel03_7:SetChecked(false) end
		if RaidAlerter_SET.ToTCheck then RaidAlerterCheckLabel03_8:SetChecked(1) else RaidAlerterCheckLabel03_8:SetChecked(false) end
		if RaidAlerter_SET.SpellIDAndCaster then RaidAlerterCheckLabel03_9:SetChecked(1) else RaidAlerterCheckLabel03_9:SetChecked(false) end
		if RaidAlerter_SET.MAXRAM then RaidAlerterCheckLabel04_1:SetValue(RaidAlerter_SET.MAXRAM); end
		if RaidAlerter_SET.TextMShow_OnOff then RaidAlerterCheckLabel05_1:SetChecked(1) else RaidAlerterCheckLabel05_1:SetChecked(false) end
		if RaidAlerter_SET.AF_Scale then RaidAlerterCheckLabel05_2:SetValue(RaidAlerter_SET.AF_Scale); end
		if RaidAlerter_SET.BossHealthPecentOnOff then RaidAlerterCheckLabel06_1:SetChecked(1) else RaidAlerterCheckLabel06_1:SetChecked(false) end
		if RaidAlerter_SET.BossHealthPecent then RaidAlerterCheckLabel06_2:SetValue(RaidAlerter_SET.BossHealthPecent); end
		if RaidAlerter_SET.BossKill then RaidAlerterCheckLabel06_3:SetChecked(1) else RaidAlerterCheckLabel06_3:SetChecked(false) end
		if RaidAlerter_SET.TANK_DangerHealth then RaidAlerterCheckLabel07_1:SetChecked(1) else RaidAlerterCheckLabel07_1:SetChecked(false) end
		if RaidAlerter_SET.TANK_DangerHealthPecent then RaidAlerterCheckLabel07_2:SetValue(RaidAlerter_SET.TANK_DangerHealthPecent); end
		if RaidAlerter_SET.TANK_Death then RaidAlerterCheckLabel07_3:SetChecked(1) else RaidAlerterCheckLabel07_3:SetChecked(false) end
		if RaidAlerter_SET.TANK_ShieldWall then RaidAlerterCheckLabel08_1:SetChecked(1) else RaidAlerterCheckLabel08_1:SetChecked(false) end
		if RaidAlerter_SET.TANK_LastStand then RaidAlerterCheckLabel09_1:SetChecked(1) else RaidAlerterCheckLabel09_1:SetChecked(false) end
		if RaidAlerter_SET.TANK_ShieldReflection then RaidAlerterCheckLabel10_1:SetChecked(1) else RaidAlerterCheckLabel10_1:SetChecked(false) end
		if RaidAlerter_SET.OT_OnOff then RaidAlerterCheckLabel11_1:SetChecked(1) else RaidAlerterCheckLabel11_1:SetChecked(false) end
		if RaidAlerter_SET.OTM_OnOff then RaidAlerterCheckLabel12_1:SetChecked(1);RaidAlerterCheckLabel13_1:Enable(); else RaidAlerterCheckLabel12_1:SetChecked();RaidAlerterCheckLabel13_1:Disable(); end
		if RaidAlerter_SET.OTMShow_OnOff then RaidAlerterCheckLabel13_1:SetChecked(1) else RaidAlerterCheckLabel13_1:SetChecked(false) end
		if RaidAlerter_SET.Hunter_Mark then RaidAlerterCheckLabel14_1:SetChecked(1) else RaidAlerterCheckLabel14_1:SetChecked(false) end
		if RaidAlerter_SET.Hunter_Misdirection then RaidAlerterCheckLabel08_2:SetChecked(1) else RaidAlerterCheckLabel08_2:SetChecked(false) end
		if RaidAlerter_SET.Hunter_Shot then RaidAlerterCheckLabel09_2:SetChecked(1) else RaidAlerterCheckLabel09_2:SetChecked(false) end
		if RaidAlerter_SET.TANK_Taunt then RaidAlerterCheckLabel10_2:SetChecked(1) else RaidAlerterCheckLabel10_2:SetChecked(false) end
		if RaidAlerter_SET.RES_DispelMagic then RaidAlerterCheckLabel11_2:SetChecked(1) else RaidAlerterCheckLabel11_2:SetChecked(false) end
		if RaidAlerter_SET.RES_Polymorph then RaidAlerterCheckLabel12_2:SetChecked(1) else RaidAlerterCheckLabel12_2:SetChecked(false) end
		if RaidAlerter_SET.RES_MagicBreak then RaidAlerterCheckLabel13_2:SetChecked(1) else RaidAlerterCheckLabel13_2:SetChecked(false) end
		if RaidAlerter_SET.RES_BuffStolen then RaidAlerterCheckLabel14_2:SetChecked(1) else RaidAlerterCheckLabel14_2:SetChecked(false) end
		if RaidAlerter_SET.Check_Poly then RaidAlerterCheckLabel08_3:SetChecked(1) else RaidAlerterCheckLabel08_3:SetChecked(false) end
		if RaidAlerter_SET.PolyDispel then RaidAlerterCheckLabel09_3:SetChecked(1) else RaidAlerterCheckLabel09_3:SetChecked(false) end
		if RaidAlerter_SET.Break_Poly then RaidAlerterCheckLabel10_3:SetChecked(1) else RaidAlerterCheckLabel10_3:SetChecked(false) end
		if RaidAlerter_SET.Dispel_Magic then RaidAlerterCheckLabel11_3:SetChecked(1) else RaidAlerterCheckLabel11_3:SetChecked(false) end
		if RaidAlerter_SET.BuffStolen then RaidAlerterCheckLabel12_3:SetChecked(1) else RaidAlerterCheckLabel12_3:SetChecked(false) end
		if RaidAlerter_SET.Break_Magic then RaidAlerterCheckLabel13_3:SetChecked(1) else RaidAlerterCheckLabel13_3:SetChecked(false) end
		if RaidAlerter_SET.Check_Gem then RaidAlerterCheckLabel14_3:SetChecked(1) else RaidAlerterCheckLabel14_3:SetChecked(false) end
		if RaidAlerter_SET.Paladin_Intervention then RaidAlerterCheckLabel08_4:SetChecked(1) else RaidAlerterCheckLabel08_4:SetChecked(false) end
		if RaidAlerter_SET.Check_Death_AtCombatEnd then RaidAlerterCheckLabel09_4:SetChecked(1) else RaidAlerterCheckLabel09_4:SetChecked(false) end
		if RaidAlerter_SET.Nef_PriestDown then RaidAlerterCheckLabel10_4:SetChecked(1) else RaidAlerterCheckLabel10_4:SetChecked(false) end
		if RaidAlerter_SET.Nef_TANKPoly then RaidAlerterCheckLabel11_4:SetChecked(1) else RaidAlerterCheckLabel11_4:SetChecked(false) end
		if RaidAlerter_SET.TAQ_Twin_AOEAdd then RaidAlerterCheckLabel12_4:SetChecked(1) else RaidAlerterCheckLabel12_4:SetChecked(false) end
		if RaidAlerter_SET.RaidSpell then RaidAlerterCheckLabel13_4:SetChecked(1) else RaidAlerterCheckLabel13_4:SetChecked(false) end
		if RaidAlerter_SET.cameraMax then RaidAlerterCheckLabel15_1:SetChecked(1) else RaidAlerterCheckLabel15_1:SetChecked(false) end
	end
end

function RaidAlerter_GetTFVarText(VariableID, SIMPLE)
	if VariableID then
		if SIMPLE then
			return RAL_TEXT_ON_SIMPLE;
		else
			return "|cFF20FF20"..RAL_TEXT_ON.."|r";
		end
	else
		if SIMPLE then
			return RAL_TEXT_OFF_SIMPLE;
		else
			return "|cFFFF2020"..RAL_TEXT_OFF.."|r";
		end
	end
end

--设置函数
function RaidAlerter_SET_FUNC_OnOff(checked)
	if checked then
		if checked =="OnOff" then
			RaidAlerter_SET.OnOff = not RaidAlerter_SET.OnOff;
		else
			RaidAlerter_SET.OnOff = true;
		end
	else
		RaidAlerter_SET.OnOff = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_1..RaidAlerter_GetTFVarText(RaidAlerter_SET.OnOff));
	RaidAlerter_Option_MainFrame_Update();
	RaidAlerter_SetAddonMessage("RAL_SELECT","startcheck");
end

function RaidAlerter_SET_FUNC_Party_Alerter(checked)
	if checked then
		RaidAlerter_SET.Party_Alerter = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Party_Alerter = not RaidAlerter_SET.Party_Alerter;
	else
		RaidAlerter_SET.Party_Alerter = false;
	end
	RaidAlerter.AddMsg("|cFFAAAAFF"..RAL_TEXT_FUNC_2..RaidAlerter_GetTFVarText(RaidAlerter_SET.Party_Alerter));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_OnlySelfCHAN(checked)
	if checked then
		RaidAlerter_SET.OnlySelfCHAN = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.OnlySelfCHAN = not RaidAlerter_SET.OnlySelfCHAN;
	else
		RaidAlerter_SET.OnlySelfCHAN = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_3..RaidAlerter_GetTFVarText(RaidAlerter_SET.OnlySelfCHAN));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_OnlySelfSCR(checked)
	if checked then
		RaidAlerter_SET.OnlySelfSCR = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.OnlySelfSCR = not RaidAlerter_SET.OnlySelfSCR;
	else
		RaidAlerter_SET.OnlySelfSCR = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_4..RaidAlerter_GetTFVarText(RaidAlerter_SET.OnlySelfSCR));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_SoundAlert(checked)
	if checked then
		RaidAlerter_SET.SoundAlert = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.SoundAlert = not RaidAlerter_SET.SoundAlert;
	else
		RaidAlerter_SET.SoundAlert = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_129..RaidAlerter_GetTFVarText(RaidAlerter_SET.SoundAlert));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_BossKill(checked)
	if checked then
		RaidAlerter_SET.BossKill = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.BossKill = not RaidAlerter_SET.BossKill;
	else
		RaidAlerter_SET.BossKill = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_5..RaidAlerter_GetTFVarText(RaidAlerter_SET.BossKill));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TANK_DangerHealth(checked)
	if checked then
		RaidAlerter_SET.TANK_DangerHealth = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.TANK_DangerHealth = not RaidAlerter_SET.TANK_DangerHealth;
	else
		RaidAlerter_SET.TANK_DangerHealth = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_6..RaidAlerter_GetTFVarText(RaidAlerter_SET.TANK_DangerHealth));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TANK_DangerHealthPecent(arg)
	if arg =="defaut" then
		RaidAlerter_SET.TANK_DangerHealthPecent = 30;
	else
		RaidAlerter_SET.TANK_DangerHealthPecent = arg;
	end
	RaidAlerter.AddMsg(string.format(RAL_TEXT_FUNC_7,"|cFFFF5555"..RaidAlerter_SET.TANK_DangerHealthPecent));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TANK_Death(checked)
	if checked then
		RaidAlerter_SET.TANK_Death = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.TANK_Death = not RaidAlerter_SET.TANK_Death;
	else
		RaidAlerter_SET.TANK_Death = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_8..RaidAlerter_GetTFVarText(RaidAlerter_SET.TANK_Death));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TANK_ShieldWall(checked)
	if checked then
		RaidAlerter_SET.TANK_ShieldWall = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.TANK_ShieldWall = not RaidAlerter_SET.TANK_ShieldWall;
	else
		RaidAlerter_SET.TANK_ShieldWall = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_58..RaidAlerter_GetTFVarText(RaidAlerter_SET.TANK_ShieldWall));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TANK_LastStand(checked)
	if checked then
		RaidAlerter_SET.TANK_LastStand = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.TANK_LastStand = not RaidAlerter_SET.TANK_LastStand;
	else
		RaidAlerter_SET.TANK_LastStand = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_60..RaidAlerter_GetTFVarText(RaidAlerter_SET.TANK_LastStand));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TANK_ShieldReflection(checked)
	if checked then
		RaidAlerter_SET.TANK_ShieldReflection = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.TANK_ShieldReflection = not RaidAlerter_SET.TANK_ShieldReflection;
	else
		RaidAlerter_SET.TANK_ShieldReflection = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_11..RaidAlerter_GetTFVarText(RaidAlerter_SET.TANK_ShieldReflection));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TANK_Taunt(checked)
	if checked then
		RaidAlerter_SET.TANK_Taunt = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.TANK_Taunt = not RaidAlerter_SET.TANK_Taunt;
	else
		RaidAlerter_SET.TANK_Taunt = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_12..RaidAlerter_GetTFVarText(RaidAlerter_SET.TANK_Taunt));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_RES_DispelMagic(checked)
	if checked then
		RaidAlerter_SET.RES_DispelMagic = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.RES_DispelMagic = not RaidAlerter_SET.RES_DispelMagic;
	else
		RaidAlerter_SET.RES_DispelMagic = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_13..RaidAlerter_GetTFVarText(RaidAlerter_SET.RES_DispelMagic));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_RES_Polymorph(checked)
	if checked then
		RaidAlerter_SET.RES_Polymorph = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.RES_Polymorph = not RaidAlerter_SET.RES_Polymorph;
	else
		RaidAlerter_SET.RES_Polymorph = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_14..RaidAlerter_GetTFVarText(RaidAlerter_SET.RES_Polymorph));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_RES_MagicBreak(checked)
	if checked then
		RaidAlerter_SET.RES_MagicBreak = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.RES_MagicBreak = not RaidAlerter_SET.RES_MagicBreak;
	else
		RaidAlerter_SET.RES_MagicBreak = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_15..RaidAlerter_GetTFVarText(RaidAlerter_SET.RES_MagicBreak));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_RES_BuffStolen(checked)
	if checked then
		RaidAlerter_SET.RES_BuffStolen = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.RES_BuffStolen = not RaidAlerter_SET.RES_BuffStolen;
	else
		RaidAlerter_SET.RES_BuffStolen = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_16..RaidAlerter_GetTFVarText(RaidAlerter_SET.RES_BuffStolen));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Hunter_Shot(checked)
	if checked then
		RaidAlerter_SET.Hunter_Shot = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Hunter_Shot = not RaidAlerter_SET.Hunter_Shot;
	else
		RaidAlerter_SET.Hunter_Shot = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_17..RaidAlerter_GetTFVarText(RaidAlerter_SET.Hunter_Shot));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Hunter_Mark(checked)
	if checked then
		RaidAlerter_SET.Hunter_Mark = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Hunter_Mark = not RaidAlerter_SET.Hunter_Mark;
	else
		RaidAlerter_SET.Hunter_Mark = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_18..RaidAlerter_GetTFVarText(RaidAlerter_SET.Hunter_Mark));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Hunter_Misdirection(checked)
	if checked then
		RaidAlerter_SET.Hunter_Misdirection = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Hunter_Misdirection = not RaidAlerter_SET.Hunter_Misdirection;
	else
		RaidAlerter_SET.Hunter_Misdirection = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_19..RaidAlerter_GetTFVarText(RaidAlerter_SET.Hunter_Misdirection));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Check_Poly(checked)
	if checked then
		RaidAlerter_SET.Check_Poly = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Check_Poly = not RaidAlerter_SET.Check_Poly;
	else
		RaidAlerter_SET.Check_Poly = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_20..RaidAlerter_GetTFVarText(RaidAlerter_SET.Check_Poly));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_PolyDispel(checked)
	if checked then
		RaidAlerter_SET.PolyDispel = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.PolyDispel = not RaidAlerter_SET.PolyDispel;
	else
		RaidAlerter_SET.PolyDispel = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_21..RaidAlerter_GetTFVarText(RaidAlerter_SET.PolyDispel));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Break_Poly(checked)
	if checked then
		RaidAlerter_SET.Break_Poly = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Break_Poly = not RaidAlerter_SET.Break_Poly;
	else
		RaidAlerter_SET.Break_Poly = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_22..RaidAlerter_GetTFVarText(RaidAlerter_SET.Break_Poly));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Check_Gem(checked)
	if checked then
		RaidAlerter_SET.Check_Gem = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Check_Gem = not RaidAlerter_SET.Check_Gem;
	else
		RaidAlerter_SET.Check_Gem = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_23..RaidAlerter_GetTFVarText(RaidAlerter_SET.Check_Gem));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Check_Death_AtCombatEnd(checked)
	if checked then
		RaidAlerter_SET.Check_Death_AtCombatEnd = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Check_Death_AtCombatEnd = not RaidAlerter_SET.Check_Death_AtCombatEnd;
	else
		RaidAlerter_SET.Check_Death_AtCombatEnd = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_24..RaidAlerter_GetTFVarText(RaidAlerter_SET.Check_Death_AtCombatEnd));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TAQ_Twin_AOEAdd(checked)
	if checked then
		RaidAlerter_SET.TAQ_Twin_AOEAdd = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.TAQ_Twin_AOEAdd = not RaidAlerter_SET.TAQ_Twin_AOEAdd;
	else
		RaidAlerter_SET.TAQ_Twin_AOEAdd = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_25..RaidAlerter_GetTFVarText(RaidAlerter_SET.TAQ_Twin_AOEAdd));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_RaidSpell(checked)
	if checked then
		RaidAlerter_SET.RaidSpell = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.RaidSpell = not RaidAlerter_SET.RaidSpell;
	else
		RaidAlerter_SET.RaidSpell = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_141..RaidAlerter_GetTFVarText(RaidAlerter_SET.RaidSpell));
	RaidAlerter_Option_MainFrame_Update();
end


function RaidAlerter_SET_FUNC_CloseRAL(checked)
	if checked then
		RaidAlerter_Attack_Frame:Hide();
	else
		RaidAlerter_Attack_Frame:Show();
	end
end

function RaidAlerter_SET_FUNC_BossHealthPecentOnOff(checked)
	if checked then
		RaidAlerter_SET.BossHealthPecentOnOff = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.BossHealthPecentOnOff = not RaidAlerter_SET.BossHealthPecentOnOff;
	else
		RaidAlerter_SET.BossHealthPecentOnOff = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_26..RaidAlerter_GetTFVarText(RaidAlerter_SET.BossHealthPecentOnOff)..", "..string.format(RAL_TEXT_FUNC_27,"|cFFFF5555"..RaidAlerter_SET.BossHealthPecent));
	RaidAlerter_Option_MainFrame_Update();
end


function RaidAlerter_SET_FUNC_BossHealthPecent(arg)
	if arg =="defaut" then
		RaidAlerter_SET.BossHealthPecent = 10;
	else
		RaidAlerter_SET.BossHealthPecent = arg;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_26..": "..string.format(RAL_TEXT_FUNC_27,"|cFFFF5555"..RaidAlerter_SET.BossHealthPecent));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_TextMShow_OnOff(checked)
	if checked then
		RaidAlerter_SET.TextMShow_OnOff = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.TextMShow_OnOff = not RaidAlerter_SET.TextMShow_OnOff;
	else
		RaidAlerter_SET.TextMShow_OnOff = false;
	end
	if RaidAlerter_SET.TextMShow_OnOff then
		RaidAlerter_Attack_Frame:Show();
		RaidAlerter_SET_FUNC_AF_Scale();
	else
		RaidAlerter_Attack_Frame:Hide();
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_28..RaidAlerter_GetTFVarText(RaidAlerter_SET.TextMShow_OnOff));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_ScrMsg(checked)
	if checked then
		RaidAlerter_SET.ScrMsg = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.ScrMsg = not RaidAlerter_SET.ScrMsg;
	else
		RaidAlerter_SET.ScrMsg = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_134..RaidAlerter_GetTFVarText(RaidAlerter_SET.ScrMsg));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_THREATCheck(checked)
	if checked then
		RaidAlerter_SET.THREATCheck = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.THREATCheck = not RaidAlerter_SET.THREATCheck;
	else
		RaidAlerter_SET.THREATCheck = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_126..RaidAlerter_GetTFVarText(RaidAlerter_SET.THREATCheck));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_ToTCheck(checked)
	if checked then
		RaidAlerter_SET.ToTCheck = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.ToTCheck = not RaidAlerter_SET.ToTCheck;
	else
		RaidAlerter_SET.ToTCheck = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_136..RaidAlerter_GetTFVarText(RaidAlerter_SET.ToTCheck));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_SpellIDAndCaster(checked)
	if checked then
		RaidAlerter_SET.SpellIDAndCaster = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.SpellIDAndCaster = not RaidAlerter_SET.SpellIDAndCaster;
	else
		RaidAlerter_SET.SpellIDAndCaster = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_143..RaidAlerter_GetTFVarText(RaidAlerter_SET.SpellIDAndCaster));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_OT_OnOff(checked)
	if checked then
		RaidAlerter_SET.OT_OnOff = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.OT_OnOff = not RaidAlerter_SET.OT_OnOff;
	else
		RaidAlerter_SET.OT_OnOff = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_29..RaidAlerter_GetTFVarText(RaidAlerter_SET.OT_OnOff));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_OTM_OnOff(checked)
	if checked then
		RaidAlerter_SET.OTM_OnOff = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.OTM_OnOff = not RaidAlerter_SET.OTM_OnOff;
	else
		RaidAlerter_SET.OTM_OnOff = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_30..RaidAlerter_GetTFVarText(RaidAlerter_SET.OTM_OnOff));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_OTMShow_OnOff(checked)
	if checked then
		RaidAlerter_SET.OTMShow_OnOff = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.OTMShow_OnOff = not RaidAlerter_SET.OTMShow_OnOff;
	else
		RaidAlerter_SET.OTMShow_OnOff = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_31..RaidAlerter_GetTFVarText(RaidAlerter_SET.OTMShow_OnOff));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Nef_PriestDown(checked)
	if checked then
		RaidAlerter_SET.Nef_PriestDown = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Nef_PriestDown = not RaidAlerter_SET.Nef_PriestDown;
	else
		RaidAlerter_SET.Nef_PriestDown = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_32..RaidAlerter_GetTFVarText(RaidAlerter_SET.Nef_PriestDown));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Nef_TANKPoly(checked)
	if checked then
		RaidAlerter_SET.Nef_TANKPoly = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Nef_TANKPoly = not RaidAlerter_SET.Nef_TANKPoly;
	else
		RaidAlerter_SET.Nef_TANKPoly = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_33..RaidAlerter_GetTFVarText(RaidAlerter_SET.Nef_TANKPoly));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Dispel_Magic(checked)
	if checked then
		RaidAlerter_SET.Dispel_Magic = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Dispel_Magic = not RaidAlerter_SET.Dispel_Magic;
	else
		RaidAlerter_SET.Dispel_Magic = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_34..RaidAlerter_GetTFVarText(RaidAlerter_SET.Dispel_Magic));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_BuffStolen(checked)
	if checked then
		RaidAlerter_SET.BuffStolen = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.BuffStolen = not RaidAlerter_SET.BuffStolen;
	else
		RaidAlerter_SET.BuffStolen = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_35..RaidAlerter_GetTFVarText(RaidAlerter_SET.BuffStolen));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Break_Magic(checked)
	if checked then
		RaidAlerter_SET.Break_Magic = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Break_Magic = not RaidAlerter_SET.Break_Magic;
	else
		RaidAlerter_SET.Break_Magic = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_36..RaidAlerter_GetTFVarText(RaidAlerter_SET.Break_Magic));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_Paladin_Intervention(checked)
	if checked then
		RaidAlerter_SET.Paladin_Intervention = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.Paladin_Intervention = not RaidAlerter_SET.Paladin_Intervention;
	else
		RaidAlerter_SET.Paladin_Intervention = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_37..RaidAlerter_GetTFVarText(RaidAlerter_SET.Paladin_Intervention));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_SYNC_SELECT_SETTOME(checked)
	if RaidAlerter_SYNC_SELECT_SETTOME == 0 then
		RaidAlerter_SYNC_SELECT_SETTOME = 1;
		RaidAlerter.AddMsg(RAL_TEXT_FUNC_38..":|cFFFF2020 "..RAL_TEXT_FUNC_39);
	elseif RaidAlerter_SYNC_SELECT_SETTOME ==1 then
		RaidAlerter_SYNC_SELECT_SETTOME = 2;
		RaidAlerter.AddMsg(RAL_TEXT_FUNC_38..":|cFFFF7711 "..RAL_TEXT_FUNC_40);
	else
		RaidAlerter_SYNC_SELECT_SETTOME = 0;
		RaidAlerter.AddMsg(RAL_TEXT_FUNC_38..":|cFF20FF20 "..RAL_TEXT_FUNC_41);
	end
	RaidAlerter_SetAddonMessage("RAL_SELECT","startcheck");
end

function RaidAlerter_SET_FUNC_CHK_MY_HP(param)
	if param == 1 then
		RaidAlerter_ChkMyHP = true;
	elseif param == 0 then
		RaidAlerter_ChkMyHP = false;
	elseif (not param) or (param=="") or (param=="onoff") then
		RaidAlerter_ChkMyHP = not RaidAlerter_ChkMyHP;
	else
		RaidAlerter_ChkMyHP = true;
		RaidAlerter_MyDangerHP = tonumber(param) or RaidAlerter_MyDangerHP;
		if RaidAlerter_MyDangerHP<1 then RaidAlerter_MyDangerHP=1; end
		if RaidAlerter_MyDangerHP>99 then RaidAlerter_MyDangerHP=99; end
	end
	RaidAlerter.AddMsg(string.format(RAL_TEXT_FUNC_42,RaidAlerter_GetTFVarText(RaidAlerter_ChkMyHP),"|cFFFF5555"..RaidAlerter_MyDangerHP));
end

function RaidAlerter_SET_FUNC_AF_Scale()
	if not RaidAlerter_SET.AF_Scale then RaidAlerter_SET.AF_Scale=1 end;
	RaidAlerter_Attack_Frame:SetScale(tonumber(RaidAlerter_SET.AF_Scale));
end

function RaidAlerter_SET_FUNC_TextMShow_Reset()
	RaidAlerter_Attack_Frame:ClearAllPoints();
	RaidAlerter_Attack_Frame:SetPoint("CENTER", "UIParent", "CENTER", 0, 60);
	RaidAlerter_SET.AF_Scale = 1
	RaidAlerterCheckLabel05_2:SetValue(RaidAlerter_SET.AF_Scale);
	RaidAlerter_SET_FUNC_AF_Scale();
	RaidAlerter.AddMsg(string.format(RAL_TEXT_FUNC_43,"|cFF20FF20"..string.format("%.2f", RaidAlerter_SET.AF_Scale)));
end

function RaidAlerter_SET_FUNC_ShowSysInfo(checked)
	if checked then
		RaidAlerter_SET.ShowSysInfo = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.ShowSysInfo = not RaidAlerter_SET.ShowSysInfo;
	else
		RRaidAlerter_SET.ShowSysInfo = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_44..RaidAlerter_GetTFVarText(RaidAlerter_SET.ShowSysInfo));
	RaidAlerter_Option_MainFrame_Update();
end

function RaidAlerter_SET_FUNC_cameraMax(checked)
	if checked then
		RaidAlerter_SET.cameraMax = true;
	elseif checked =="OnOff" then
		RaidAlerter_SET.cameraMax = not RaidAlerter_SET.cameraMax;
	else
		RaidAlerter_SET.cameraMax = false;
	end
	RaidAlerter.AddMsg(RAL_TEXT_XML_131..RaidAlerter_GetTFVarText(RaidAlerter_SET.cameraMax));
	if RaidAlerter_SET.cameraMax then
		RaidAlerter_SetCameraMaxToMax();
	else
		RaidAlerter_SetCameraMaxToDefaut();
		RaidAlerter.AddMsg("|cFF20FF20"..RAL_TEXT_FUNC_48);
		RaidAlerter.AddMsg("|cFFFF0000"..RAL_TEXT_XML_133);
	end
	RaidAlerter_Option_MainFrame_Update();
end

StaticPopupDialogs["RaidAlerter_RELOADUI"] = {preferredIndex = 3,
	text = "|cFFFFDD00"..RaidAlerter_UINameEN..RaidAlerter_UIName.."|r\n\n"..RAL_TEXT_CPUMSG_1,
	button1 = RAL_TEXT_CPUMSG_2,
	button2 = RAL_TEXT_CPUMSG_3,
	OnAccept = function()
		ReloadUI();
	end,
	timeout = 0,
	exclusive = 1,
	hideOnEscape = 1,
};

function RaidAlerter_SET_FUNC_GTT_cpustart()
	if (GetCVar("scriptProfile") == "1") then
		RaidAlerter.AddMsg(RAL_TEXT_FUNC_45.."|cFF20FF20"..RAL_TEXT_ON);
	else
		SetCVar("scriptProfile", "1");
		StaticPopup_Show("RaidAlerter_RELOADUI");
	end
end

function RaidAlerter_SET_FUNC_GTT_cpustop()
	if (GetCVar("scriptProfile") == "0") then
		RaidAlerter.AddMsg(RAL_TEXT_FUNC_45.."|cFFFF2020"..RAL_TEXT_OFF);
	else
		SetCVar("scriptProfile", "0");
		StaticPopup_Show("RaidAlerter_RELOADUI");
	end
end

function RaidAlerter_SET_FUNC_ResetRAM(arg)
	-- 老虎会游泳：禁用GC，避免卡顿
	--local OldRAM = gcinfo();
	RaidAlerter_ClearTimerDatas();
	if arg=="reset" then
		--collectgarbage("collect");
		--RaidAlerter.AddMsg(string.format(RAL_TEXT_FUNC_46, RAL.ToRed(OldRAM-gcinfo())));
	else
--		UpdateAddOnMemoryUsage();
		RaidAlerter_Check_RAM_CPU();
		if GetAddOnMemoryUsage("RaidAlerter")>arg then
			--collectgarbage("collect");
			--RaidAlerter.AddMsg(string.format(RAL_TEXT_FUNC_46, RAL.ToRed(OldRAM-gcinfo())));
		end
	end
end

function RaidAlerter_SET_FUNC_MsgTest()
	local PN = UnitName("player");
	local AlertMsg = {
		[1]	= {		--[仇恨!]
			["Raid"]=string.format(RAL_TEXT_ALERT_1,RaidAlerter_RAIDICON[8]..RAL_TEXT_UINTNAME_3,PN),
			["Scr"]=string.format(RAL_TEXT_ALERT_1,RaidAlerter_RAIDICON[8]..RAL.ToRed(RAL_TEXT_UINTNAME_3),RAL.ToPink(RAL_TEXT_YOU)),
			},
		[2]	= {		--偷取真言术：韧
			["Raid"]=string.format(RAL_TEXT_ALERT_30,PN,RaidAlerter_RAIDICON[8]..RAL_TEXT_UINTNAME_3,RAL.SpellIdToText(21562,1)),
			["Scr"]=string.format(RAL_TEXT_ALERT_30,RAL.ToPink(RAL_TEXT_YOU),RaidAlerter_RAIDICON[8]..RAL.ToRed(RAL_TEXT_UINTNAME_3),RAL.ToCyan(RAL.SpellIdToText(21562,0,1))),
			},
		[3]	= {		--嘲讽抵抗
			["Raid"]=string.format(RAL_TEXT_ALERT_31,PN,RAL.SpellIdToText(355,1),RaidAlerter_RAIDICON[8]..RAL_TEXT_UINTNAME_3),
			["Scr"]=string.format(RAL_TEXT_ALERT_31,RAL.ToPink(RAL_TEXT_YOU),RAL.ToCyan(RAL.SpellIdToText(355,0,1)),RaidAlerter_RAIDICON[8]..RAL.ToRed(RAL_TEXT_UINTNAME_3)),
			},
		[4]	= {		--嘲讽免疫
			["Raid"]=string.format(RAL_TEXT_ALERT_32,RaidAlerter_RAIDICON[8]..RAL_TEXT_UINTNAME_3,PN,RAL.SpellIdToText(355,1)),
			["Scr"]=string.format(RAL_TEXT_ALERT_32,RaidAlerter_RAIDICON[8]..RAL.ToRed(RAL_TEXT_UINTNAME_3),RAL.ToPink(RAL_TEXT_YOU),RAL.ToCyan(RAL.SpellIdToText(355,0,1))),
			},
		[5]	= {		--放鱼肉筵席
			["Raid"]=string.format(RAL_TEXT_ALERT_39,PN,RAL.SpellIdToText(57426,1)),
			["Scr"]=string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(PN),RAL.SpellIdToText(57426,0,1)),
			},
		[6]	= {
			["Raid"]=string.format(RAL_TEXT_ALERT_34,"",PN,RaidAlerter_RAIDICON[8]..RAL_TEXT_UINTNAME_3,RAL.SpellIdToText(13323,1)),
			["Scr"]=string.format(RAL_TEXT_ALERT_34,"",RAL.ToPink(RAL_TEXT_YOU),RaidAlerter_RAIDICON[8]..RAL.ToRed(RAL_TEXT_UINTNAME_3),RAL.ToCyan(RAL.SpellIdToText(13323,0,1))),
			},
	};
	local ToTMsg = {
		[1]	= string.format(RAL_TEXT_THREAT_INFO_05,RAL_TEXT_YOU),
		[2]	= string.format(RAL_TEXT_THREAT_INFO_03,RAL_TEXT_YOU),
	};
	local ThreatMsg = {
		[1]	= RAL_TEXT_THREAT_INFO_04,
		[2]	= RAL_TEXT_THREAT_INFO_01,
		[3]	= RAL_TEXT_THREAT_INFO_02,
	};
	RaidAlerter.AddMsg("|cFF00FF00"..RAL_TEXT_XML_139.."...");
	RaidAlerter.AddErrorMsg("|cFFFF7711<|r|cFFFFFF99"..RaidAlerter_UINameEN.."|r|cFFFF7711>|r".."|cFF00FF00"..RAL_TEXT_XML_139.."...");
	local i = 1;
	i = random(1, 6);
	RaidAlerter.AddMsg(AlertMsg[i]["Raid"]);
	RaidAlerter.AddSCRMsg(AlertMsg[i]["Scr"]);
	if RaidAlerter_SET.ToTCheck then
		i = random(1, 2);
		if i == 1 then
			RAL_TOT_Info:AddMessage(ToTMsg[i], 0.8, 0.8, 0.8);
		elseif i == 2 then
			RAL_TOT_Info:AddMessage(ToTMsg[i], 1, 0.9, 0);
		end
		RAL.SOUND(1);
	end
	if RaidAlerter_SET.THREATCheck then
		i = random(1, 3);
		if i == 1 then
			RAL_THREAT_Info:AddMessage(ThreatMsg[i], 1, 0.1, 1);
		elseif i == 2 then
			RAL_THREAT_Info:AddMessage(ThreatMsg[i], 1, 0.1, 0.1);
		elseif i == 3 then
			RAL_THREAT_Info:AddMessage(ThreatMsg[i], 0.1, 1, 0.1);
		end
		RAL.SOUND(1);
	end
end

function RaidAlerter_SET_FUNC_ResetToDefaut(arg)
	UIDropDownMenu_SetSelectedID(RaidAlerter_RAIDMODEList,4);
	RaidAlerter_RAIDMODE_MAX_GROUP_SETUP(5);
	RaidAlerter_SET.MAXRAM = 416;
	RaidAlerter.AddMsg(string.format(RAL_TEXT_FUNC_47,"|cFF44FF44"..RaidAlerter_SET.MAXRAM));
	RaidAlerter_SET.TANK_DangerHealthPecent = 30;
	RaidAlerter_SET.BossHealthPecent = 10;
	RaidAlerter_SET_FUNC_OnOff(true);
	RaidAlerter_SET_FUNC_Party_Alerter(true);
	RaidAlerter_SET_FUNC_OnlySelfCHAN();
	RaidAlerter_SET_FUNC_OnlySelfSCR();
	RaidAlerter_SET_FUNC_SoundAlert(true);
	RaidAlerter_SET_FUNC_TextMShow_OnOff(true);
	RaidAlerter_SET_FUNC_BossHealthPecentOnOff(true);
	RaidAlerter_SET_FUNC_BossHealthPecent(10);
	RaidAlerter_SET_FUNC_BossKill(true);
	RaidAlerter_SET_FUNC_TANK_DangerHealth(true);
	RaidAlerter_SET_FUNC_TANK_DangerHealthPecent(30);
	RaidAlerter_SET_FUNC_TANK_Death(true);
	RaidAlerter_SET_FUNC_TANK_ShieldWall(true);
	RaidAlerter_SET_FUNC_TANK_LastStand(true);
	RaidAlerter_SET_FUNC_TANK_ShieldReflection(true);
	RaidAlerter_SET_FUNC_ScrMsg(true);
	RaidAlerter_SET_FUNC_THREATCheck(true);
	RaidAlerter_SET_FUNC_ToTCheck(true);
	RaidAlerter_SET_FUNC_OT_OnOff(true);
	RaidAlerter_SET_FUNC_OTM_OnOff();
	RaidAlerter_SET_FUNC_OTMShow_OnOff();
	RaidAlerter_SET_FUNC_Hunter_Mark();
	RaidAlerter_SET_FUNC_Hunter_Misdirection(true);
	RaidAlerter_SET_FUNC_Hunter_Shot(true);
	RaidAlerter_SET_FUNC_TANK_Taunt(true);
	RaidAlerter_SET_FUNC_RES_DispelMagic(true);
	RaidAlerter_SET_FUNC_RES_Polymorph(true);
	RaidAlerter_SET_FUNC_RES_MagicBreak(true);
	RaidAlerter_SET_FUNC_RES_BuffStolen(true);
	RaidAlerter_SET_FUNC_Check_Poly(true);
	RaidAlerter_SET_FUNC_PolyDispel(true);
	RaidAlerter_SET_FUNC_Break_Poly(true);
	RaidAlerter_SET_FUNC_Dispel_Magic(true);
	RaidAlerter_SET_FUNC_BuffStolen(true);
	RaidAlerter_SET_FUNC_Break_Magic(true);
	RaidAlerter_SET_FUNC_Check_Gem(true);
	RaidAlerter_SET_FUNC_Paladin_Intervention(true);
	RaidAlerter_SET_FUNC_Check_Death_AtCombatEnd(true);
	RaidAlerter_SET_FUNC_Nef_PriestDown();
	RaidAlerter_SET_FUNC_Nef_TANKPoly();
	RaidAlerter_SET_FUNC_TAQ_Twin_AOEAdd();
	RaidAlerter_SET_FUNC_RaidSpell(true);
	RaidAlerter_SET_FUNC_CHK_MY_HP();
	RaidAlerter_SET_FUNC_SpellIDAndCaster(true);
--	RaidAlerter_Attack_Frame:Show()
	RaidAlerter_Check_CTRAORA_LA_TANKS();
	RaidAlerter.AddMsg("|cFF20FF20"..RAL_TEXT_FUNC_48);
end

function RaidAlerter_MainFrame_SetAllChecked()
	RaidAlerter_SET_FUNC_OnOff(true);
	RaidAlerter_SET_FUNC_Party_Alerter(true);
	RaidAlerter_SET_FUNC_SoundAlert(true);
	RaidAlerter_SET_FUNC_TextMShow_OnOff(true);
	RaidAlerter_SET_FUNC_BossHealthPecentOnOff(true);
	RaidAlerter_SET_FUNC_BossKill(true);
	RaidAlerter_SET_FUNC_TANK_DangerHealth(true);
	RaidAlerter_SET_FUNC_TANK_Death(true);
	RaidAlerter_SET_FUNC_TANK_ShieldWall(true);
	RaidAlerter_SET_FUNC_TANK_LastStand(true);
	RaidAlerter_SET_FUNC_TANK_ShieldReflection(true);
	RaidAlerter_SET_FUNC_ScrMsg(true);
	RaidAlerter_SET_FUNC_THREATCheck(true);
	RaidAlerter_SET_FUNC_ToTCheck(true);
	RaidAlerter_SET_FUNC_OT_OnOff(true);
	RaidAlerter_SET_FUNC_OTM_OnOff(true);
	RaidAlerter_SET_FUNC_OTMShow_OnOff(true);
	RaidAlerter_SET_FUNC_Hunter_Mark(true);
	RaidAlerter_SET_FUNC_Hunter_Misdirection(true);
	RaidAlerter_SET_FUNC_Hunter_Shot(true);
	RaidAlerter_SET_FUNC_TANK_Taunt(true);
	RaidAlerter_SET_FUNC_RES_DispelMagic(true);
	RaidAlerter_SET_FUNC_RES_Polymorph(true);
	RaidAlerter_SET_FUNC_RES_MagicBreak(true);
	RaidAlerter_SET_FUNC_RES_BuffStolen(true);
	RaidAlerter_SET_FUNC_Check_Poly(true);
	RaidAlerter_SET_FUNC_PolyDispel(true);
	RaidAlerter_SET_FUNC_Break_Poly(true);
	RaidAlerter_SET_FUNC_Dispel_Magic(true);
	RaidAlerter_SET_FUNC_BuffStolen(true);
	RaidAlerter_SET_FUNC_Break_Magic(true);
	RaidAlerter_SET_FUNC_Check_Gem(true);
	RaidAlerter_SET_FUNC_Paladin_Intervention(true);
	RaidAlerter_SET_FUNC_Check_Death_AtCombatEnd(true);
	RaidAlerter_SET_FUNC_Nef_PriestDown(true);
	RaidAlerter_SET_FUNC_Nef_TANKPoly(true);
	RaidAlerter_SET_FUNC_TAQ_Twin_AOEAdd(true);
	RaidAlerter_SET_FUNC_RaidSpell(true);
--	RaidAlerter_SET_FUNC_CHK_MY_HP(1);
end

function RaidAlerter_MainFrame_SetAllClean()
--	RaidAlerter_SET_FUNC_OnOff(0);
--	RaidAlerter_SET_FUNC_Party_Alerter(0);
	RaidAlerter_SET_FUNC_OnlySelfCHAN();
	RaidAlerter_SET_FUNC_OnlySelfSCR();
	RaidAlerter_SET_FUNC_SoundAlert();
	RaidAlerter_SET_FUNC_BossHealthPecentOnOff();
	RaidAlerter_SET_FUNC_BossKill();
	RaidAlerter_SET_FUNC_TANK_DangerHealth();
	RaidAlerter_SET_FUNC_TANK_Death();
	RaidAlerter_SET_FUNC_TANK_ShieldWall();
	RaidAlerter_SET_FUNC_TANK_LastStand();
	RaidAlerter_SET_FUNC_TANK_ShieldReflection();
	RaidAlerter_SET_FUNC_ScrMsg();
	RaidAlerter_SET_FUNC_THREATCheck();
	RaidAlerter_SET_FUNC_ToTCheck();
	RaidAlerter_SET_FUNC_OT_OnOff();
	RaidAlerter_SET_FUNC_OTM_OnOff();
	RaidAlerter_SET_FUNC_OTMShow_OnOff();
	RaidAlerter_SET_FUNC_Hunter_Mark();
	RaidAlerter_SET_FUNC_Hunter_Misdirection();
	RaidAlerter_SET_FUNC_Hunter_Shot();
	RaidAlerter_SET_FUNC_TANK_Taunt();
	RaidAlerter_SET_FUNC_RES_DispelMagic();
	RaidAlerter_SET_FUNC_RES_Polymorph();
	RaidAlerter_SET_FUNC_RES_MagicBreak();
	RaidAlerter_SET_FUNC_RES_BuffStolen();
	RaidAlerter_SET_FUNC_Check_Poly();
	RaidAlerter_SET_FUNC_PolyDispel();
	RaidAlerter_SET_FUNC_Break_Poly();
	RaidAlerter_SET_FUNC_Dispel_Magic();
	RaidAlerter_SET_FUNC_BuffStolen();
	RaidAlerter_SET_FUNC_Break_Magic();
	RaidAlerter_SET_FUNC_Check_Gem();
	RaidAlerter_SET_FUNC_Paladin_Intervention();
	RaidAlerter_SET_FUNC_Check_Death_AtCombatEnd();
	RaidAlerter_SET_FUNC_Nef_PriestDown();
	RaidAlerter_SET_FUNC_Nef_TANKPoly();
	RaidAlerter_SET_FUNC_TAQ_Twin_AOEAdd();
	RaidAlerter_SET_FUNC_RaidSpell();
--	RaidAlerter_SET_FUNC_CHK_MY_HP(0);
end

function RaidAlerter_ListStatus()
	RaidAlerter.AddMsg("|cFF5588FF"..RaidAlerter_UINameEN..RaidAlerter_UIName.." - "..RAL_TEXT_FUNC_49..":");
	RaidAlerter_Check_RAM_CPU();
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_50..": "..RaidAlerter_Version);
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_51..": ".."|cFFFFFFFF"..format("%.1f",RaidAlerter_Check_RAM_DATA).."|r".."K");
	RaidAlerter.AddMsg(string.format(RAL_TEXT_FUNC_52,"|cFF20FF20"..(RaidAlerter_SET.RAIDMODE_MAX_GROUP*5).."|r"));
	RaidAlerter.AddMsg(RAL_TEXT_FUNC_1..RaidAlerter_GetTFVarText(RaidAlerter_SET.OnOff));
end

--增加最大镜头距离
function RaidAlerter_SetCameraMaxToMax()
	if RaidAlerter_SET.cameraMax then
		-- SetCVar("cameraDistanceMax", 50);			--当前3.05版本极限=25，但不排除BLZ将来增大的可能，所以预留点空间
		-- SetCVar("cameraDistanceMaxFactor", 4);		--当前3.05版本极限=2
	end
end

function RaidAlerter_SetCameraMaxToDefaut()
	-- SetCVar("cameraDistanceMax", 15);
	-- SetCVar("cameraDistanceMaxFactor", 1);
end

function RaidAlerter_RAIDMODEList_OnClick(self,id)
	RaidAlerter_RAIDMODE_MAX_GROUP_SETUP((self:GetID()) + 1);
	UIDropDownMenu_SetSelectedID(RaidAlerter_RAIDMODEList, self:GetID());
end

function RaidAlerter_RAIDMODEList_Init(id)
	local info = {};
	local i = 1;
	while i <= 7 do
		info.text = RaidAlerter_RAIDMODE[i];
		info.func = RaidAlerter_RAIDMODEList_OnClick;
		info.value = i;
		info.checked = nil;
		UIDropDownMenu_AddButton(info);
		i = i + 1;
	end
end

function RaidAlerter_RAIDMODE_MAX_GROUP_SETUP(num)
	RaidAlerter_SET.RAIDMODE_MAX_GROUP = num;
	RaidAlerter.AddMsg(string.format(RAL_TEXT_FUNC_53,"|cFF20FF20"..(RaidAlerter_SET.RAIDMODE_MAX_GROUP*5).."|r"));
end

--变量检查，确保更新兼容
function RaidAlerter_Check_Variables()
	if RaidAlerter_SET.OnOff == nil then RaidAlerter_SET.OnOff = true; end
	if RaidAlerter_SET.RAIDMODE_MAX_GROUP == nil then RaidAlerter_SET.RAIDMODE_MAX_GROUP = 5; end
	if RaidAlerter_SET.Party_Alerter == nil then RaidAlerter_SET.Party_Alerter = true; end
	if RaidAlerter_SET.OnlySelfCHAN == nil then RaidAlerter_SET.OnlySelfCHAN = false; end
	if RaidAlerter_SET.OnlySelfSCR == nil then RaidAlerter_SET.OnlySelfSCR = false; end
	if RaidAlerter_SET.SoundAlert == nil then RaidAlerter_SET.SoundAlert = true; end
	if RaidAlerter_SET.TextMShow_OnOff == nil then RaidAlerter_SET.TextMShow_OnOff = true; end
	if RaidAlerter_SET.AF_Scale == nil then RaidAlerter_SET.AF_Scale = 1; end
	if RaidAlerter_SET.MAXRAM == nil then RaidAlerter_SET.MAXRAM = 416; end
	if RaidAlerter_SET.BossHealthPecentOnOff == nil then RaidAlerter_SET.BossHealthPecentOnOff = true; end
	if RaidAlerter_SET.BossHealthPecent == nil then RaidAlerter_SET.BossHealthPecent = 10; end
	if RaidAlerter_SET.BossKill == nil then RaidAlerter_SET.BossKill = true; end
	if RaidAlerter_SET.TANK_DangerHealth == nil then RaidAlerter_SET.TANK_DangerHealth = true; end
	if RaidAlerter_SET.TANK_DangerHealthPecent == nil then RaidAlerter_SET.TANK_DangerHealthPecent = 30; end
	if RaidAlerter_SET.TANK_Death == nil then RaidAlerter_SET.TANK_Death = true; end
	if RaidAlerter_SET.TANK_ShieldWall == nil then RaidAlerter_SET.TANK_ShieldWall = true; end
	if RaidAlerter_SET.TANK_LastStand == nil then RaidAlerter_SET.TANK_LastStand = true; end
	if RaidAlerter_SET.TANK_ShieldReflection == nil then RaidAlerter_SET.TANK_ShieldReflection = true; end
	if RaidAlerter_SET.ScrMsg == nil then RaidAlerter_SET.ScrMsg = true; end
	if RaidAlerter_SET.THREATCheck == nil then RaidAlerter_SET.THREATCheck = true; end
	if RaidAlerter_SET.ToTCheck == nil then RaidAlerter_SET.ToTCheck = true; end
	if RaidAlerter_SET.SpellIDAndCaster == nil then RaidAlerter_SET.SpellIDAndCaster = true; end
	if RaidAlerter_SET.OT_OnOff == nil then RaidAlerter_SET.OT_OnOff = true; end
	if RaidAlerter_SET.OTM_OnOff == nil then RaidAlerter_SET.OTM_OnOff = false; end
	if RaidAlerter_SET.OTMShow_OnOff == nil then RaidAlerter_SET.OTMShow_OnOff = false; end
	if RaidAlerter_SET.Hunter_Mark == nil then RaidAlerter_SET.Hunter_Mark = false; end
	if RaidAlerter_SET.Hunter_Misdirection == nil then RaidAlerter_SET.Hunter_Misdirection = true; end
	if RaidAlerter_SET.Hunter_Shot == nil then RaidAlerter_SET.Hunter_Shot = true; end
	if RaidAlerter_SET.TANK_Taunt == nil then RaidAlerter_SET.TANK_Taunt = true; end
	if RaidAlerter_SET.RES_DispelMagic == nil then RaidAlerter_SET.RES_DispelMagic = true; end
	if RaidAlerter_SET.RES_Polymorph == nil then RaidAlerter_SET.RES_Polymorph = true; end
	if RaidAlerter_SET.RES_MagicBreak == nil then RaidAlerter_SET.RES_MagicBreak = true; end
	if RaidAlerter_SET.RES_BuffStolen == nil then RaidAlerter_SET.RES_BuffStolen = true; end
	if RaidAlerter_SET.Check_Poly == nil then RaidAlerter_SET.Check_Poly = true; end
	if RaidAlerter_SET.PolyDispel == nil then RaidAlerter_SET.PolyDispel = true; end
	if RaidAlerter_SET.Break_Poly == nil then RaidAlerter_SET.Break_Poly = true; end
	if RaidAlerter_SET.Dispel_Magic == nil then RaidAlerter_SET.Dispel_Magic = true; end
	if RaidAlerter_SET.BuffStolen == nil then RaidAlerter_SET.BuffStolen = true; end
	if RaidAlerter_SET.Break_Magic == nil then RaidAlerter_SET.Break_Magic = true; end
	if RaidAlerter_SET.Check_Gem == nil then RaidAlerter_SET.Check_Gem = true; end
	if RaidAlerter_SET.Paladin_Intervention == nil then RaidAlerter_SET.Paladin_Intervention = true; end
	if RaidAlerter_SET.Check_Death_AtCombatEnd == nil then RaidAlerter_SET.Check_Death_AtCombatEnd = true; end
	if RaidAlerter_SET.Nef_PriestDown == nil then RaidAlerter_SET.Nef_PriestDown = false; end
	if RaidAlerter_SET.Nef_TANKPoly == nil then RaidAlerter_SET.Nef_TANKPoly = false; end
	if RaidAlerter_SET.TAQ_Twin_AOEAdd == nil then RaidAlerter_SET.TAQ_Twin_AOEAdd = false; end
	if RaidAlerter_SET.RaidSpell == nil then RaidAlerter_SET.RaidSpell = true; end
	if RaidAlerter_SET.ShowSysInfo == nil then RaidAlerter_SET.ShowSysInfo = false; end
	if RaidAlerter_SET.cameraMax == nil then RaidAlerter_SET.cameraMax = false; end
end

function RaidAlerter_Check_RAM_CPU(check)
	local smsg_tip = "";

	UpdateAddOnMemoryUsage();
	UpdateAddOnCPUUsage();

	local MEM_Cur = GetAddOnMemoryUsage("RaidAlerter");
	local CPU_Cur = GetAddOnCPUUsage("RaidAlerter");
	local GetTimer = RaidAlerter_GetTimer("RaidAlerter_Check_RAM_CPU");

	smsg_tip = smsg_tip..RAL_TEXT_TIP_26..": ".."|cFFFFFFFF"..format("%.1f",MEM_Cur).."|r".."K (".."|cFFFFFFFF"..format("%.2f",((MEM_Cur - RaidAlerter_Check_RAM_DATA)/GetTimer)).."|r".."K/"..RAL_TEXT_TIP_28..")";
	if(GetCVar("scriptProfile")=="1") then
		smsg_tip = smsg_tip.."\nCPU: ".."|cFFFFFFFF"..format("%.2f",((CPU_Cur - RaidAlerter_Check_CPU_DATA)/GetTimer)).."|r".."/"..RAL_TEXT_TIP_28;
	else
		smsg_tip = smsg_tip.."\nCPU: ".."|cFFFFFFFF".."N/A|r";
	end

	RaidAlerter_Check_RAM_DATA = MEM_Cur;
	RaidAlerter_Check_CPU_DATA = CPU_Cur;
	RaidAlerter_StartTimer("RaidAlerter_Check_RAM_CPU");
	RaidAlerter_StartTimer("RaidAlerter_GameTooltip");
	if check=="tip" then return smsg_tip end
end

--到位检查
function RaidAlerter_CheckPlayer(check)
	if UnitInRaid("player") or IsInInstance() then
		local RAL_UnVisiblePlayer = "";
		local RAL_DeadPlayer = "";
		local RAL_OfflinePlayer = "";
		local RAL_UnVisiblePlayerCount = 0;
		local RAL_DeadPlayerCount = 0;
		local RAL_OfflinePlayerCount = 0;
		local smsg = "["..RAL_TEXT_CHECK_1.."]";
		local smsg_tip = "|cFF00FF00"..RAL_TEXT_CHECK_1.."|r ";
		for i = 1,GetNumGroupMembers() do
			_, _, subgroup = GetRaidRosterInfo(i);
			if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
				local unit = "raid"..i;
				if UnitIsConnected(unit) then
					if not UnitIsDeadOrGhost(unit) then
						if not UnitIsVisible(unit) then
							RAL_UnVisiblePlayerCount = RAL_UnVisiblePlayerCount + 1;
							if RAL_UnVisiblePlayerCount>0 and RAL_UnVisiblePlayerCount<20 then
								RAL_UnVisiblePlayer = RAL_UnVisiblePlayer..UnitName(unit)..".";
							end
							if RAL_UnVisiblePlayerCount == 20 then
								RAL_UnVisiblePlayer = RAL_UnVisiblePlayer.." "..RAL_TEXT_ETC;
							end
						end
					else
						RAL_DeadPlayerCount = RAL_DeadPlayerCount + 1;
						if RAL_DeadPlayerCount>0 and RAL_DeadPlayerCount<10 then
							RAL_DeadPlayer = RAL_DeadPlayer..UnitName(unit)..".";
						end
						if RAL_DeadPlayerCount == 10 then
							RAL_DeadPlayer = RAL_DeadPlayer.." "..RAL_TEXT_ETC;
						end
					end
				else
					RAL_OfflinePlayerCount = RAL_OfflinePlayerCount + 1;
					if RAL_OfflinePlayerCount>0 and RAL_OfflinePlayerCount<10 then
						if UnitName(unit)~= nil then
							RAL_OfflinePlayer = RAL_OfflinePlayer..UnitName(unit)..".";
						end
					end
					if RAL_OfflinePlayerCount == 10 then
						RAL_OfflinePlayer = RAL_OfflinePlayer.." "..RAL_TEXT_ETC;
					end
				end
			end
		end
		if RAL_UnVisiblePlayerCount==0 and RAL_DeadPlayerCount==0 and RAL_OfflinePlayerCount==0 then
			smsg = smsg..string.format(RAL_TEXT_CHECK_2,RaidNum);
			smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_2,"|cFF5588FF"..RaidNum.."|r");
		else
			smsg = smsg..string.format(RAL_TEXT_CHECK_3,(RaidNum-RAL_OfflinePlayerCount-RAL_DeadPlayerCount-RAL_UnVisiblePlayerCount))..".";
			smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_3,"|cFFFFFFFF"..(RaidNum-RAL_OfflinePlayerCount-RAL_DeadPlayerCount-RAL_UnVisiblePlayerCount).."|r")..".";
			if RAL_OfflinePlayerCount>0 then
				smsg = smsg..string.format(RAL_TEXT_CHECK_4,RAL_OfflinePlayerCount)..":"..RAL_OfflinePlayer;
				smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_4,"|cFFEEEE20"..RAL_OfflinePlayerCount.."|r")..".";
			end
			if RAL_DeadPlayerCount>0 then
				smsg = smsg..string.format(RAL_TEXT_CHECK_5,RAL_DeadPlayerCount)..":"..RAL_DeadPlayer;
				smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_5,"|cFFFF2020"..RAL_DeadPlayerCount.."|r")..".";
			end
			if RAL_UnVisiblePlayerCount>0 then
				smsg = smsg..string.format(RAL_TEXT_CHECK_6,RAL_UnVisiblePlayerCount)..":"..RAL_UnVisiblePlayer;
				smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_6,"|cFFEEEE20"..RAL_UnVisiblePlayerCount.."|r")..".";
			end
		end
		if check=="tip" then
			return smsg_tip;
		else
			RAL.SendMSG(smsg,AlertChan,1);
		end
	elseif GetNumSubgroupMembers() > 0 then
		local RAL_UnVisiblePlayer = "";
		local RAL_DeadPlayer = "";
		local RAL_OfflinePlayer = "";
		local RAL_UnVisiblePlayerCount = 0;
		local RAL_DeadPlayerCount = 0;
		local RAL_OfflinePlayerCount = 0;
		local smsg = "["..RAL_TEXT_CHECK_1.."]";
		local smsg_tip = "|cFF00FF00"..RAL_TEXT_CHECK_1.."|r ";
		local i;
		local unit = "";
		local PartyNum = GetNumSubgroupMembers() + 1;
		for i = 0, GetNumSubgroupMembers() do
			if i == 0 then
				unit = "player";
			else
				unit = "party"..i;
			end
			if UnitIsConnected(unit) then
				if not UnitIsDeadOrGhost(unit) then
					if not UnitIsVisible(unit) then
						RAL_UnVisiblePlayerCount = RAL_UnVisiblePlayerCount + 1;
						if RAL_UnVisiblePlayerCount>0 and RAL_UnVisiblePlayerCount<20 then
							RAL_UnVisiblePlayer = RAL_UnVisiblePlayer..UnitName(unit)..".";
						end
						if RAL_UnVisiblePlayerCount == 20 then
							RAL_UnVisiblePlayer = RAL_UnVisiblePlayer.." "..RAL_TEXT_ETC;
						end
					end
				else
					RAL_DeadPlayerCount = RAL_DeadPlayerCount + 1;
					if RAL_DeadPlayerCount>0 and RAL_DeadPlayerCount<10 then
						RAL_DeadPlayer = RAL_DeadPlayer..UnitName(unit)..".";
					end
					if RAL_DeadPlayerCount == 10 then
						RAL_DeadPlayer = RAL_DeadPlayer.." "..RAL_TEXT_ETC;
					end
				end
			else
				RAL_OfflinePlayerCount = RAL_OfflinePlayerCount + 1;
				if RAL_OfflinePlayerCount>0 and RAL_OfflinePlayerCount<10 then
					if UnitName(unit)~= nil then
						RAL_OfflinePlayer = RAL_OfflinePlayer..UnitName(unit)..".";
					end
				end
				if RAL_OfflinePlayerCount == 10 then
					RAL_OfflinePlayer = RAL_OfflinePlayer.." "..RAL_TEXT_ETC;
				end
			end
		end
		if RAL_UnVisiblePlayerCount==0 and RAL_DeadPlayerCount==0 and RAL_OfflinePlayerCount==0 then
			smsg = smsg..string.format(RAL_TEXT_CHECK_2,PartyNum);
			smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_2,"|cFF5588FF"..PartyNum.."|r");
		else
			smsg = smsg..string.format(RAL_TEXT_CHECK_3,(PartyNum-RAL_OfflinePlayerCount-RAL_DeadPlayerCount-RAL_UnVisiblePlayerCount))..".";
			smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_3,"|cFFFFFFFF"..(PartyNum-RAL_OfflinePlayerCount-RAL_DeadPlayerCount-RAL_UnVisiblePlayerCount).."|r")..".";
			if RAL_OfflinePlayerCount>0 then
				smsg = smsg..string.format(RAL_TEXT_CHECK_4,RAL_OfflinePlayerCount)..":"..RAL_OfflinePlayer;
				smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_4,"|cFFEEEE20"..RAL_OfflinePlayerCount.."|r")..".";
			end
			if RAL_DeadPlayerCount>0 then
				smsg = smsg..string.format(RAL_TEXT_CHECK_5,RAL_DeadPlayerCount)..":"..RAL_DeadPlayer;
				smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_5,"|cFFFF2020"..RAL_DeadPlayerCount.."|r")..".";
			end
			if RAL_UnVisiblePlayerCount>0 then
				smsg = smsg..string.format(RAL_TEXT_CHECK_6,RAL_UnVisiblePlayerCount)..":"..RAL_UnVisiblePlayer;
				smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_6,"|cFFEEEE20"..RAL_UnVisiblePlayerCount.."|r")..".";
			end
		end
		if check=="tip" then
			return smsg_tip;
		else
			RAL.SendMSG(smsg,AlertChan,1);
		end
	else
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTTEAM);
		return;
	end
end

--PvP检查
function RaidAlerter_CheckPvP(check)

	if (not UnitInRaid("player")) and (not IsInInstance()) then
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTRAID);
		return;
	end
	-- new add 检测tank
	local RAL_checktanklistPlayer = "坦克: ";
	local RAL_checkHEALERlistPlayer = "";
	local RAL_checkHEALERlistPlayerNum = 0;
	-- new add end
	local RAL_PvPPlayer = "";
	local RAL_PvPPlayerCount = 0;
	local smsg = "["..RAL_TEXT_CHECK_7.."]";
	local smsg_tip = "|cFF00FF00"..RAL_TEXT_CHECK_7.."|r ";
	for i = 1,GetNumGroupMembers() do
		_, _, subgroup, _, class = GetRaidRosterInfo(i);
		if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
			local unit = "raid"..i;
			if UnitIsPVP(unit) and UnitIsConnected(unit) then
				RAL_PvPPlayerCount = RAL_PvPPlayerCount + 1;
			end
		end
	end

	if RAL_PvPPlayerCount<RaidNum/2 then
		RAL_PvPPlayerCount = 0;
		for i = 1,GetNumGroupMembers() do
			_, _, subgroup = GetRaidRosterInfo(i);
			if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
				local unit = "raid"..i;
				if UnitIsPVP(unit) and UnitIsConnected(unit) then
					RAL_PvPPlayerCount = RAL_PvPPlayerCount + 1;
					if RAL_PvPPlayerCount>0 then
						RAL_PvPPlayer = RAL_PvPPlayer..UnitName(unit)..".";
					end
				end
				-- new add 檢測tank列表报告
				local RolesAssigned = UnitGroupRolesAssigned(unit);
				if RolesAssigned == "TANK" or (RolesAssigned ~= "HEALER" and RolesAssigned ~= "DAMAGER" and RaidAlerter_CheckTank(UnitName(unit),class)) then
					RAL_checktanklistPlayer = RAL_checktanklistPlayer..UnitName(unit).."(HP:"..UnitHealthMax(unit)..").";
				end
				if RolesAssigned == "HEALER" then
					RAL_checkHEALERlistPlayer = RAL_checkHEALERlistPlayer..UnitName(unit)..".";
					-- .."(MP:"..UnitPowerMax(unit)..").";
					RAL_checkHEALERlistPlayerNum = RAL_checkHEALERlistPlayerNum + 1;
				end
				-- new add end
			end
		end
		-- new add start
		if check=="tip" then
		else
			if RAL_checktanklistPlayer ~= "TANK:" then
				RAL.SendMSG(RAL_checktanklistPlayer,AlertChan,1);
			end
			if RAL_checkHEALERlistPlayer ~= "" then
				RAL.SendMSG("治療"..RAL_checkHEALERlistPlayerNum.."名:　"..RAL_checkHEALERlistPlayer,AlertChan,1);
			end
		end
		-- new add end
		if RAL_PvPPlayerCount>0 then
			smsg = smsg..string.format(RAL_TEXT_CHECK_8,RAL_PvPPlayerCount)..":"..RAL_PvPPlayer;
			smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_8,"|cFFEEEE20"..RAL_PvPPlayerCount.."|r")..".";
			if check=="tip" then
				return smsg_tip;
			else
				RAL.SendMSG(smsg,AlertChan,1);
			end
		else
			smsg = smsg..RAL_TEXT_CHECK_9;
			smsg_tip = smsg_tip.."|cFF5588FF"..RAL_TEXT_CHECK_9.."|r";
			if check=="tip" then
				return smsg_tip;
			else
				RAL.SendMSG(smsg,AlertChan,1);
			end
		end
	else
		RAL_PvPPlayerCount = 0;
		for i = 1,GetNumGroupMembers() do
			_, _, subgroup = GetRaidRosterInfo(i);
			if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
				local unit = "raid"..i;
				if (not UnitIsPVP(unit)) and (UnitIsConnected(unit)) then
					RAL_PvPPlayerCount = RAL_PvPPlayerCount + 1;
					if RAL_PvPPlayerCount>0 then
						RAL_PvPPlayer = RAL_PvPPlayer..UnitName(unit)..".";
					end
				end
			end
		end
		if RAL_PvPPlayerCount>0 then
			smsg = smsg..string.format(RAL_TEXT_CHECK_10,RAL_PvPPlayerCount)..":"..RAL_PvPPlayer;
			smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_10,"|cFFEEEE20"..RAL_PvPPlayerCount.."|r")..".";
			if check=="tip" then
				return smsg_tip;
			else
				RAL.SendMSG(smsg,AlertChan,1);
			end
		else
			smsg = smsg..RAL_TEXT_CHECK_11;
			smsg_tip = smsg_tip.."|cFF5588FF"..RAL_TEXT_CHECK_11.."|r";
			if check=="tip" then
				return smsg_tip;
			else
				RAL.SendMSG(smsg,AlertChan,1);
			end
		end
	end
end

function RaidAlerter_CheckFlask(FlaskName, Show)
	if (not UnitInRaid("player")) and (not IsInInstance()) then
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTRAID);
		return;
	end

	local FlaskText = "";
	local SuperFlask = true;
	local FlaskDATA = {};
	if FlaskName then
		FlaskName = tostring(FlaskName);
		if (FlaskName ~= "") then
			SuperFlask = false;
		end
	end

	if SuperFlask then
		FlaskText = RAL_TEXT_CHECK_12;
		FlaskDATA = RaidAlerter_SuperFlask_TEXT;
	else
		if (FlaskName=="all" or FlaskName=="yj" or FlaskName=="force") then
			FlaskText = RAL_TEXT_CHECK_13;
			FlaskDATA = RaidAlerter_ForceFlask_TEXT;
		else
			FlaskText = FlaskName;
			RaidAlerter_Table_Update(FlaskDATA, FlaskName, "ADD");
		end
	end

	local RAL_FlaskPlayer = "";
	local RAL_FlaskPlayerCount = 0;
	local smsg = "["..FlaskText..RAL_TEXT_CHECK_14.."]";
	local smsg_tip = "|cFF00FF00"..FlaskText..RAL_TEXT_CHECK_14.."|r ";
	for i = 1,GetNumGroupMembers() do
		_, _, subgroup = GetRaidRosterInfo(i);
		if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
			local unit = "raid"..i;
			local j = 1;
			local has = 0;
			while ((UnitBuff(unit, j)) and (has == 0)) and UnitIsConnected(unit) do
				for k, v in pairs(FlaskDATA) do
					if string.find(UnitBuff(unit, j), v) then
						has = 1;
						RAL_FlaskPlayerCount = RAL_FlaskPlayerCount + 1;
						break;
					end
				end
				j = j + 1;
			end
		end
	end

	if RAL_FlaskPlayerCount<RaidNum/2 then
		RAL_FlaskPlayerCount = 0;
		for i = 1,GetNumGroupMembers() do
			_, _, subgroup = GetRaidRosterInfo(i);
			if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
				local unit = "raid"..i;
				local j = 1;
				local has = 0;
				while ((UnitBuff(unit, j)) and (has == 0)) and UnitIsConnected(unit) do
					for k, v in pairs(FlaskDATA) do
						if string.find(UnitBuff(unit, j), v) then
							has = 1;
							RAL_FlaskPlayerCount = RAL_FlaskPlayerCount + 1;
							RAL_FlaskPlayer = RAL_FlaskPlayer..UnitName(unit)..".";
							break;
						end
					end
					j = j + 1;
				end
			end
		end
		if RAL_FlaskPlayerCount>0 then
			smsg = smsg..string.format(RAL_TEXT_CHECK_15,RAL_FlaskPlayerCount,FlaskText)..": "..RAL_FlaskPlayer;
			smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_15,"|cFFFFFF99"..RAL_FlaskPlayerCount.."|r",FlaskText)..".";
			if Show=="tip" then
				return smsg_tip;
			else
				RAL.SendMSG(smsg,AlertChan,1);
			end
		else
			smsg = smsg..string.format(RAL_TEXT_CHECK_16,FlaskText);
			smsg_tip = smsg_tip.."|cFFFF5555"..string.format(RAL_TEXT_CHECK_16,FlaskText).."|r";
			if Show=="tip" then
				return smsg_tip;
			else
				RAL.SendMSG(smsg,AlertChan,1);
			end
		end
	else
		RAL_FlaskPlayerCount = 0;
		for i = 1,GetNumGroupMembers() do
			_, _, subgroup = GetRaidRosterInfo(i);
			if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
				local unit = "raid"..i;
				local j = 1;
				local has = 0;
				while ((UnitBuff(unit, j)) and (has == 0)) and UnitIsConnected(unit) do
					for k, v in pairs(FlaskDATA) do
						if string.find(UnitBuff(unit, j), v) then
							has = 1;
							break;
						end
					end
					j = j + 1;
					if (not(UnitBuff(unit, j)) and (has == 0)) then
						RAL_FlaskPlayerCount = RAL_FlaskPlayerCount + 1;
						RAL_FlaskPlayer = RAL_FlaskPlayer..UnitName(unit)..".";
					end
				end
			end
		end
		if RAL_FlaskPlayerCount>0 then
			smsg = smsg..string.format(RAL_TEXT_CHECK_17,RAL_FlaskPlayerCount,FlaskText)..": "..RAL_FlaskPlayer;
			smsg_tip = smsg_tip..string.format(RAL_TEXT_CHECK_17,"|cFFFF5555"..RAL_FlaskPlayerCount.."|r",FlaskText)..".";
			if Show=="tip" then
				return smsg_tip;
			else
				RAL.SendMSG(smsg,AlertChan,1);
			end
		else
			smsg = smsg..string.format(RAL_TEXT_CHECK_18,FlaskText);
			smsg_tip = smsg_tip.."|cFF5588FF"..string.format(RAL_TEXT_CHECK_18,FlaskText).."|r";
			if Show=="tip" then
				return smsg_tip;
			else
				RAL.SendMSG(smsg,AlertChan,1);
			end
		end
	end
end

--Buff检查
function RaidAlerter_CheckRaidBuff()
	local SetChannel;
	if (not UnitInRaid("player")) and (not IsInInstance()) then
		 RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTRAID);
		 return;
	end

	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
		SetChannel = "INSTANCE_CHAT";
	else
		if IsInRaid() then
			SetChannel = "RAID";
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			SetChannel = "PARTY";
		end
	end

	local CLASS_INDEX = {
		[1]		= RAL_TEXT_DRUID,
		[2]		= RAL_TEXT_HUNTER,
		[3]		= RAL_TEXT_MAGE,
		[4]		= RAL_TEXT_PRIEST,
		[5]		= RAL_TEXT_ROGUE,
		[6]		= RAL_TEXT_WARLOCK,
		[7]		= RAL_TEXT_WARRIOR,
		[8]		= RAL_TEXT_SHAMAN,
		[9]		= RAL_TEXT_PALADIN,
		[10]	= RAL_TEXT_DEATHKNIGHT,
		[11]	= RAL_TEXT_MONK,
		};

	local CLASS_COUNT = {
		[1]		= 0,
		[2]		= 0,
		[3]		= 0,
		[4]		= 0,
		[5]		= 0,
		[6]		= 0,
		[7]		= 0,
		[8]		= 0,
		[9]		= 0,
		[10]	= 0,
		[11]	= 0,
		};

	local GROUP_COUNT = {
		[1]		= 0,
		[2]		= 0,
		[3]		= 0,
		[4]		= 0,
		[5]		= 0,
		[6]		= 0,
		[7]		= 0,
		[8]		= 0,
		};

	local Group_NoBuff_Name = {
		--耐,智,野性、精神按小队号记录
		[RAL_TEXT_MOP_BUFF_1] = {
			[1]	= {["name"]="",["count"]=0,},
			[2]	= {["name"]="",["count"]=0,},
			[3]	= {["name"]="",["count"]=0,},
			[4]	= {["name"]="",["count"]=0,},
			[5]	= {["name"]="",["count"]=0,},
			[6]	= {["name"]="",["count"]=0,},
			[7]	= {["name"]="",["count"]=0,},
			[8]	= {["name"]="",["count"]=0,},
			},
		[RAL_TEXT_MOP_BUFF_2] = {
			[1]	= {["name"]="",["count"]=0,},
			[2]	= {["name"]="",["count"]=0,},
			[3]	= {["name"]="",["count"]=0,},
			[4]	= {["name"]="",["count"]=0,},
			[5]	= {["name"]="",["count"]=0,},
			[6]	= {["name"]="",["count"]=0,},
			[7]	= {["name"]="",["count"]=0,},
			[8]	= {["name"]="",["count"]=0,},
			},
		[RAL_TEXT_MOP_BUFF_3] = {
			[1]	= {["name"]="",["count"]=0,},
			[2]	= {["name"]="",["count"]=0,},
			[3]	= {["name"]="",["count"]=0,},
			[4]	= {["name"]="",["count"]=0,},
			[5]	= {["name"]="",["count"]=0,},
			[6]	= {["name"]="",["count"]=0,},
			[7]	= {["name"]="",["count"]=0,},
			[8]	= {["name"]="",["count"]=0,},
			},
		[RAL_TEXT_MOP_BUFF_4] = {
			[1]	= {["name"]="",["count"]=0,},
			[2]	= {["name"]="",["count"]=0,},
			[3]	= {["name"]="",["count"]=0,},
			[4]	= {["name"]="",["count"]=0,},
			[5]	= {["name"]="",["count"]=0,},
			[6]	= {["name"]="",["count"]=0,},
			[7]	= {["name"]="",["count"]=0,},
			[8]	= {["name"]="",["count"]=0,},
			},
		[RAL_TEXT_MOP_BUFF_5] = {
			[1]	= {["name"]="",["count"]=0,},
			[2]	= {["name"]="",["count"]=0,},
			[3]	= {["name"]="",["count"]=0,},
			[4]	= {["name"]="",["count"]=0,},
			[5]	= {["name"]="",["count"]=0,},
			[6]	= {["name"]="",["count"]=0,},
			[7]	= {["name"]="",["count"]=0,},
			[8]	= {["name"]="",["count"]=0,},
			},
		[RAL_TEXT_MOP_BUFF_6] = {
			[1]	= {["name"]="",["count"]=0,},
			[2]	= {["name"]="",["count"]=0,},
			[3]	= {["name"]="",["count"]=0,},
			[4]	= {["name"]="",["count"]=0,},
			[5]	= {["name"]="",["count"]=0,},
			[6]	= {["name"]="",["count"]=0,},
			[7]	= {["name"]="",["count"]=0,},
			[8]	= {["name"]="",["count"]=0,},
			},
		};
	local LostFQBuff_NAME = "";		--记录未开正义之怒的防骑名字

	local HasPRIEST = false;
	local HasMAGE = false;
	local HasDRUID = false;
	local HasWARLOCK = false;
	local HasWARRIOR = false;
	local HasMONK = false;
	local HasPALADIN = false;
	local HasPALADIN2 = false;
	local HasDEATHKNIGHT = false;
	local HasSHAMAN = false;
	local NoBuffCount = 0;

	for i = 1,GetNumGroupMembers() do
		local _, _, subgroup, _, class, _, _, online = GetRaidRosterInfo(i);
		if online then
			if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
				if class == RAL_TEXT_DRUID then CLASS_COUNT[1] = CLASS_COUNT[1] + 1; HasDRUID = true; end
				if class == RAL_TEXT_HUNTER then CLASS_COUNT[2] = CLASS_COUNT[2] + 1; end
				if class == RAL_TEXT_MAGE then CLASS_COUNT[3] = CLASS_COUNT[3] + 1; HasMAGE = true; end
				if class == RAL_TEXT_PRIEST then CLASS_COUNT[4] = CLASS_COUNT[4] + 1; HasPRIEST = true; end
				if class == RAL_TEXT_ROGUE then CLASS_COUNT[5] = CLASS_COUNT[5] + 1; end
				if class == RAL_TEXT_WARLOCK then CLASS_COUNT[6] = CLASS_COUNT[6] + 1; HasWARLOCK = true; end
				if class == RAL_TEXT_WARRIOR then CLASS_COUNT[7] = CLASS_COUNT[7] + 1; HasWARRIOR = true; end
				if class == RAL_TEXT_SHAMAN then CLASS_COUNT[8] = CLASS_COUNT[8] + 1; HasSHAMAN = true; end
				if class == RAL_TEXT_PALADIN then
					CLASS_COUNT[9] = CLASS_COUNT[9] + 1;
					if UnitHealthMax("raid"..i) > (RaidHPMAXAVG*1.4) then
						HasFQ = true;			--高血量判定为FQ
					end
				end
				if class == RAL_TEXT_DEATHKNIGHT then CLASS_COUNT[10] = CLASS_COUNT[10] + 1; HasDEATHKNIGHT = true; end
				if class == RAL_TEXT_MONK then CLASS_COUNT[11] = CLASS_COUNT[11] + 1;HasMONK = true; end
				GROUP_COUNT[subgroup] = GROUP_COUNT[subgroup] + 1;
			end
		end
	end

	if CLASS_COUNT[9] >= 1 then HasPALADIN = true; end
	if CLASS_COUNT[9] >= 2 then HasPALADIN2 = true; end

	_, instanceType = GetInstanceInfo();
	if instanceType == "party" then
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTRAID);
		return;
	end

	for i = 1,GetNumGroupMembers() do
		local name, _, subgroup, _, class = GetRaidRosterInfo(i);
		if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
			local unit = "raid"..i;
			local j = 1;
			local HasBuff_1,HasBuff_2,HasBuff_3,HasBuff_4,HasBuff_5,HasBuff_6,HasFQBuff,IsFQ;
			local IsYD = false;
			local IsZQSM = false;
			HasBuff_1 = false;
			HasBuff_2 = false;
			HasBuff_3 = false;
			HasBuff_4 = false;
			HasBuff_5 = false;
			HasBuff_6 = false;
			HasFQBuff = false;
			IsFQ = false;
			if not UnitIsConnected(unit) then
				HasBuff_1 = true;
				HasBuff_2 = true;
				HasBuff_3 = true;
				HasBuff_4 = true;
				HasBuff_5 = true;
				HasBuff_6 = true;
				HasFQBuff = true;
				IsFQ = true;
				HasPRIEST_BUFF_1 = true;
				HasPRIEST_BUFF_2 = true;
				HasMAGE_BUFF = true;
				HasDRUID_BUFF = true;
				HasPALADIN_BUFF_12 = true;
				HasPALADIN_BUFF_14 = true;
				HasPALADIN_BUFF_16 = true;
				HasPALADIN_BUFF_18 = true;
				IsFQ = true;
				HasFQBuff = true;
				HasMONK_BUFF = true;
			end
			--new add 獲取玩家全部buffid列表
			local BuffidList = ",";
			local BuffTEXTList = ",";
			--new add end
			while UnitBuff(unit, j) do
				--local BuffTEXT = UnitBuff(unit, j);
				--new add 获取buffid
				local BuffTEXT,_,_,_,_,_,_,_,_,Buffid = UnitBuff(unit, j);
				BuffidList = BuffidList..Buffid..","
				BuffTEXTList = BuffTEXTList..BuffTEXT..","
				--new add end
				-- RAL.SendMSG("BuffTEXT:"..BuffTEXT,SetChannel,1);


				-- 低MP职业忽略法伤
				if UnitPowerMax(unit) < 250 then
					HasBuff_4 = true;
				end

				-- 高蓝类治疗或法系职业忽略强度检查
				if UnitPowerMax(unit) > 80000 then
					HasBuff_3 = true;
				end
				if class == RAL_TEXT_PALADIN then
				--检查FQ坦的正义之怒
				--new add判断坦克采用新的方式
					--if RaidAlerter_TestIsMtList(unit) then
					if (UnitGroupRolesAssigned(unit) == "TANK" or RaidAlerter_CheckTank(UnitName(unit))) and UnitPowerMax(unit) < 80000 then
						IsFQ = true;
						if string.find(BuffTEXT, RAL_TEXT_BUFF_21) then
							HasFQBuff = true;
						end
					end
				end

				--mop buff
				if string.find(RAL_TEXT_MOP_BUFF_1,","..BuffTEXT..",") then
					HasBuff_1 = true;
				end
				if string.find(RAL_TEXT_MOP_BUFF_2,","..BuffTEXT..",") then
					HasBuff_2 = true;
				end
				if string.find(RAL_TEXT_MOP_BUFF_3,","..BuffTEXT..",") then
					HasBuff_3 = true;
				end
				if string.find(RAL_TEXT_MOP_BUFF_4,","..BuffTEXT..",") then
					HasBuff_4 = true;
				end
				if string.find(RAL_TEXT_MOP_BUFF_5,","..BuffTEXT..",") then
					HasBuff_5 = true;
				end
				if string.find(RAL_TEXT_MOP_BUFF_6,","..BuffTEXT..",") then
					HasBuff_6 = true;
				end

				if HasBuff_2 == false or HasBuff_6 == false then
					if HasPALADIN == false and HasSHAMAN == false then
						HasBuff_2  = true;
						HasBuff_6 = true;
					end
					if HasPALADIN2 == false and HasSHAMAN == false then
						if HasBuff_2 == true then
							HasBuff_6 = true;
						end
						if HasBuff_6 == true then
							HasBuff_2 = true;
						end
					end
				end

--				if (HasPRIEST_BUFF_1 and HasPRIEST_BUFF_2 and HasMAGE_BUFF and HasDRUID_BUFF and HasPALADIN_BUFF_12 and HasPALADIN_BUFF_14
--				and HasPALADIN_BUFF_16 and HasPALADIN_BUFF_18 and ((IsFQ and HasFQBuff) or (not IsFQ))) then j = 99; end
				if (HasBuff_1 and HasBuff_2 and HasBuff_3 and HasBuff_4 and HasBuff_5 and HasBuff_6 and ((IsFQ and HasFQBuff) or (not IsFQ))) then j = 99;end
				j = j + 1;
			end

			--new add 特殊職業buff檢查
			--if class == RAL_TEXT_PALADIN then
				-- 检查圣印
			--	if not (string.find(BuffidList, ",31801,") or string.find(BuffidList, ",20165,") or string.find(BuffidList, ",20154,")) then
			--		RAL.SendMSG(string.format(RAL_TEXT_ALERT_100,UnitName(unit),RAL.SpellIdToText(31801,1).."或"..RAL.SpellIdToText(20165,1).."或"..RAL.SpellIdToText(20154,1)),SetChannel,1);
			--	end
			--end
			if class == RAL_TEXT_PRIEST then
				-- 检查心火
				if not (string.find(BuffidList, ",588,") or string.find(BuffidList, ",73413,") or string.find(BuffTEXTList, ","..RAL_MOP_BUFFSPECIAL_1..",")) then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_100,UnitName(unit),RAL.SpellIdToText(588,1).."或"..RAL.SpellIdToText(73413,1)),SetChannel,1);
				end
				-- NotifyInspect(unit);
				-- if UnitGroupRolesAssigned(unit) == "DAMAGER" then
				-- 	if not string.find(BuffidList, ",15286,") then
				-- 		RAL.SendMSG(string.format(RAL_TEXT_ALERT_100,UnitName(unit),RAL.SpellIdToText(15286,1)),SetChannel,1);
				-- 	end
				-- 	if not string.find(BuffidList, ",15473,") then
				-- 		RAL.SendMSG(string.format(RAL_TEXT_ALERT_100,UnitName(unit),RAL.SpellIdToText(15473,1)),SetChannel,1);
				-- 	end
				-- end
			end
			if class == RAL_TEXT_WARLOCK then
				-- if not (string.find(BuffidList, ",687,") or string.find(BuffidList, ",28176,")) then
				-- 	RAL.SendMSG(string.format(RAL_TEXT_ALERT_100,UnitName(unit),RAL.SpellIdToText(687,1).."或"..RAL.SpellIdToText(28176,1)),SetChannel,1);
				-- end
			end
			if class == RAL_TEXT_DEATHKNIGHT then
				-- 仅检测确定为坦克的
				-- NotifyInspect(unit);
				-- if GetSpecialization(true)==1 or UnitGroupRolesAssigned(unit) == "TANK" or (RolesAssigned ~= "HEALER" and RolesAssigned ~= "DAMAGER" and RaidAlerter_CheckTank(UnitName(unit))) then
				-- 	if not (string.find(BuffidList, ",48263,")) then
				-- 		RAL.SendMSG(string.format(RAL_TEXT_ALERT_100,UnitName(unit),RAL.SpellIdToText(48263,1)),SetChannel,1);
				-- 	end
				-- else
				-- 	-- 仅检测标记为dps的
				-- 	if GetSpecialization(true)==2 or GetSpecialization(true)==3 or UnitGroupRolesAssigned(unit) == "DAMAGER" then
				-- 		if not (string.find(BuffidList, ",48266,") or string.find(BuffidList, ",48265,")) then
				-- 			RAL.SendMSG(string.format(RAL_TEXT_ALERT_100,UnitName(unit),RAL.SpellIdToText(48266,1).."或"..RAL.SpellIdToText(48265,1)),SetChannel,1);
				-- 		end
				-- 	end
				-- end
			end
			if class == RAL_TEXT_MAGE then
				if not (string.find(BuffidList, ",6117,") or string.find(BuffidList, ",7303,") or string.find(BuffidList, ",7302,") or string.find(BuffidList, ",30482,")) then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_100,UnitName(unit),RAL.SpellIdToText(6117,1).."或"..RAL.SpellIdToText(7302,1).."或"..RAL.SpellIdToText(30482,1)),SetChannel,1);
				end
			end
			--new end

			if (not HasBuff_1) and (HasPRIEST or HasWARLOCK) then
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_1][subgroup]["name"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_1][subgroup]["name"]..name..".";
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_1][subgroup]["count"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_1][subgroup]["count"] + 1;
				NoBuffCount = NoBuffCount + 1;
			end
			if (not HasBuff_2) and (HasPALADIN or HasMONK or HasDRUID) then
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_2][subgroup]["name"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_2][subgroup]["name"]..name..".";
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_2][subgroup]["count"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_2][subgroup]["count"] + 1;
				NoBuffCount = NoBuffCount + 1;
			end
			if (not HasBuff_3) and (HasDEATHKNIGHT or HasWARRIOR) then
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_3][subgroup]["name"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_3][subgroup]["name"]..name..".";
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_3][subgroup]["count"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_3][subgroup]["count"] + 1;
				NoBuffCount = NoBuffCount + 1;
			end
			if (not HasBuff_4) and (HasMAGE or HasWARLOCK) then
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_4][subgroup]["name"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_4][subgroup]["name"]..name..".";
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_4][subgroup]["count"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_4][subgroup]["count"] + 1;
				NoBuffCount = NoBuffCount + 1;
			end
			if (not HasBuff_5) and (HasMAGE) then
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_5][subgroup]["name"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_5][subgroup]["name"]..name..".";
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_5][subgroup]["count"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_5][subgroup]["count"] + 1;
				NoBuffCount = NoBuffCount + 1;
			end
			if (not HasBuff_6) and (HasPALADIN2 or (HasPALADIN and (HasDRUID or HasMONK))) then
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_6][subgroup]["name"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_6][subgroup]["name"]..name..".";
				Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_6][subgroup]["count"] = Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_6][subgroup]["count"] + 1;
				NoBuffCount = NoBuffCount + 1;
			end

			if IsFQ and (not HasFQBuff) then
				LostFQBuff_NAME = LostFQBuff_NAME..name..".";
				NoBuffCount = NoBuffCount + 1;
				RaidAlerter_Whisper(name, RAL_TEXT_ALERT_42);
			end
		end
	end
	if NoBuffCount == 0 then
		RAL.SendMSG(RAL_TEXT_CHECK_19,SetChannel,1);
	else
		RAL.SendMSG(string.format(RAL_TEXT_CHECK_20,NoBuffCount),SetChannel,1);
		local msg = "";
		-- 10%耐
		if HasPRIEST or HasWARLOCK then
			msg = "";
			for i = 1, RaidAlerter_SET.RAIDMODE_MAX_GROUP do
				if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_1][i]["name"] ~= "" then
					if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_1][i]["count"] >= GROUP_COUNT[i] then
						Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_1][i]["name"] = RAL_TEXT_CHECK_21;
					end
					msg = msg..string.format(RAL_TEXT_CHECK_22,i,RaidAlerter_GetSimpleName(Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_1][i]["name"])).." ";
				end
			end
			if msg ~= "" then
				msg = RAL_MOP_BUFFCLASS_1..": "..msg;
				RAL.SendMSG(msg,SetChannel,1);
			end
		end
		-- 5%属性
		if HasDRUID or HasMONK or HasPALADIN then
			msg = "";
			for i = 1, RaidAlerter_SET.RAIDMODE_MAX_GROUP do
				if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_2][i]["name"] ~= "" then
					if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_2][i]["count"] >= GROUP_COUNT[i] then
						Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_2][i]["name"] = RAL_TEXT_CHECK_21;
					end
					msg = msg..string.format(RAL_TEXT_CHECK_22,i,RaidAlerter_GetSimpleName(Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_2][i]["name"])).." ";
				end
			end
			if msg ~= "" then
				msg = RAL_MOP_BUFFCLASS_2..": "..msg;
				RAL.SendMSG(msg,SetChannel,1);
			end
		end
		-- 10%攻强
		if HasDEATHKNIGHT or HasWARRIOR then
			msg = "";
			for i = 1, RaidAlerter_SET.RAIDMODE_MAX_GROUP do
				if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_3][i]["name"] ~= "" then
					if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_3][i]["count"] >= GROUP_COUNT[i] then
						Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_3][i]["name"] = RAL_TEXT_CHECK_21;
					end
					msg = msg..string.format(RAL_TEXT_CHECK_22,i,RaidAlerter_GetSimpleName(Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_3][i]["name"])).." ";
				end
			end
			if msg ~= "" then
				msg = RAL_MOP_BUFFCLASS_3..": "..msg;
				RAL.SendMSG(msg,SetChannel,1);
			end
		end
		-- 10%法伤
		if HasMAGE or HasWARLOCK then
			msg = "";
			for i = 1, RaidAlerter_SET.RAIDMODE_MAX_GROUP do
				if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_4][i]["name"] ~= "" then
					if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_4][i]["count"] >= GROUP_COUNT[i] then
						Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_4][i]["name"] = RAL_TEXT_CHECK_21;
					end
					msg = msg..string.format(RAL_TEXT_CHECK_22,i,RaidAlerter_GetSimpleName(Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_4][i]["name"])).." ";
				end
			end
			if msg ~= "" then
				msg = RAL_MOP_BUFFCLASS_4..": "..msg;
				RAL.SendMSG(msg,SetChannel,1);
			end
		end
		-- 5暴
		if HasMAGE then
			msg = "";
			for i = 1, RaidAlerter_SET.RAIDMODE_MAX_GROUP do
				if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_5][i]["name"] ~= "" then
					if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_5][i]["count"] >= GROUP_COUNT[i] then
						Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_5][i]["name"] = RAL_TEXT_CHECK_21;
					end
					msg = msg..string.format(RAL_TEXT_CHECK_22,i,RaidAlerter_GetSimpleName(Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_5][i]["name"])).." ";
				end
			end
			if msg ~= "" then
				msg = RAL_MOP_BUFFCLASS_5..": "..msg;
				RAL.SendMSG(msg,SetChannel,1);
			end
		end
		-- 精通
		if HasPALADIN then
			msg = "";
			for i = 1, RaidAlerter_SET.RAIDMODE_MAX_GROUP do
				if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_6][i]["name"] ~= "" then
					if Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_6][i]["count"] >= GROUP_COUNT[i] then
						Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_6][i]["name"] = RAL_TEXT_CHECK_21;
					end
					msg = msg..string.format(RAL_TEXT_CHECK_22,i,RaidAlerter_GetSimpleName(Group_NoBuff_Name[RAL_TEXT_MOP_BUFF_6][i]["name"])).." ";
				end
			end
			if msg ~= "" then
				msg = RAL_MOP_BUFFCLASS_6..": "..msg;
				RAL.SendMSG(msg,SetChannel,1);
			end
		end

		if LostFQBuff_NAME ~= "" then
			RAL.SendMSG(RAL_TEXT_ALERT_43..": "..LostFQBuff_NAME,SetChannel,1);
		end
		if RaidAlerter_GetTimer("COOKFOOD_CREAT") < (COOKFOODDUR-15) then		--若放置的团队烹饪食物还未消失，则检查进食充分buff
			RaidAlerter_CheckFlask(RAL_TEXT_BUFF_24);
		end
	end
end

--通报玩家目标锁定状况（默认检查MT）
function RaidAlerter_Target_Check(check)
	if (not UnitInRaid("player")) and (not IsInInstance()) then
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTRAID);
		return;
	end
	if ((not check) or check=="") then
		check = "MT";
	end
	local ICON_COUNT = {
			[1]	= 0,
			[2]	= 0,
			[3]	= 0,
			[4]	= 0,
			[5]	= 0,
			[6]	= 0,
			[7]	= 0,
			[8]	= 0,
						};
	local NAME_COUNT = {
			[1]	= "",
			[2]	= "",
			[3]	= "",
			[4]	= "",
			[5]	= "",
			[6]	= "",
			[7]	= "",
			[8]	= "",
						};
	local SAME_NUM = 0;
	local NONE_NUM = 0;
	local msgend = RAL_TEXT_CHECK_29;
	local msg2 = "";
	local msg3 = "";
	local MSG_NAME = "";
	local MSG_ICON = "";
	local MSG_TARNAME = "";
	if string.upper(check) == "MT" then
		if not RaidAlerter_TestMtHasSet() then
			RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_CHECK_24);
			return;
		end
		RAL.SendMSG(string.format(RAL_TEXT_CHECK_28,check),AlertChan,1);

		local i;
		for i = 1, 5 do
			if (RAL_Tanks[i]) then
				MSG_NAME = "("..i.."T)"..RAL_Tanks[i];
				local unit = RaidAlerter_NameToUnit(RAL_Tanks[i]);
				if (unit) then
					if UnitName(unit.."target") then
						MSG_TARNAME = UnitName(unit.."target");
						local icon = GetRaidTargetIndex(unit.."target");
						if icon then
							MSG_ICON = RaidAlerter_RAIDICON[icon];
							ICON_COUNT[icon] = ICON_COUNT[icon] + 1;
							NAME_COUNT[icon] = NAME_COUNT[icon]..UnitName(unit)..".";
						else
							MSG_ICON = "";
						end
						if not UnitIsEnemy("player", unit.."target") then
							NONE_NUM = NONE_NUM + 1;
							msg3 = msg3..UnitName(unit)..".";
						end
					else
						MSG_TARNAME = RAL_TEXT_CHECK_31;
						MSG_ICON = "";
						NONE_NUM = NONE_NUM + 1;
						msg3 = msg3..UnitName(unit)..".";
					end
					RAL.SendMSG(string.format(RAL_TEXT_CHECK_30,MSG_NAME,MSG_ICON,MSG_TARNAME),AlertChan,1);
				end
			end
		end
	else
		if (string.upper(check)=="XD" or string.upper(check)=="DLY") then check=RAL_TEXT_DRUID; end
		if (string.upper(check)=="LR") then check=RAL_TEXT_HUNTER; end
		if (string.upper(check)=="FS") then check=RAL_TEXT_MAGE; end
		if (string.upper(check)=="MS") then check=RAL_TEXT_PRIEST; end
		if (string.upper(check)=="DZ" or string.upper(check)=="QXZ") then check=RAL_TEXT_ROGUE; end
		if (string.upper(check)=="SS") then check=RAL_TEXT_WARLOCK; end
		if (string.upper(check)=="ZS") then check=RAL_TEXT_WARRIOR; end
		if (string.upper(check)=="SM" or string.upper(check)=="SMJS") then check=RAL_TEXT_SHAMAN; end
		if (string.upper(check)=="QS" or string.upper(check)=="SQS") then check=RAL_TEXT_PALADIN; end
		if (check==RAL_TEXT_DRUID) or (check==RAL_TEXT_HUNTER) or (check==RAL_TEXT_MAGE) or
		(check==RAL_TEXT_PRIEST) or (check==RAL_TEXT_ROGUE) or (check==RAL_TEXT_WARLOCK) or
		(check==RAL_TEXT_WARRIOR) or (check==RAL_TEXT_SHAMAN) or (check==RAL_TEXT_PALADIN) then
			RAL.SendMSG(string.format(RAL_TEXT_CHECK_28,check),AlertChan,1);

	_, instanceType = GetInstanceInfo();
	if instanceType == "party" then
		-- RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTRAID);
		return;
	end
			for i = 1,GetNumGroupMembers() do
				local _, _, subgroup, _, class = GetRaidRosterInfo(i);
				if (class == check) and (subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP) then
					local unit = "raid"..i;
					MSG_NAME = UnitName(unit);
					if UnitName(unit.."target") then
						MSG_TARNAME = UnitName(unit.."target");
						local icon = GetRaidTargetIndex(unit.."target");
						if icon then
							MSG_ICON = RaidAlerter_RAIDICON[icon];
							ICON_COUNT[icon] = ICON_COUNT[icon] + 1;
							NAME_COUNT[icon] = NAME_COUNT[icon]..UnitName(unit)..".";
						else
							MSG_ICON = "";
						end
						if not UnitIsEnemy("player", unit.."target") then
							NONE_NUM = NONE_NUM + 1;
							msg3 = msg3..UnitName(unit)..".";
						end
					else
						MSG_TARNAME = RAL_TEXT_CHECK_31;
						MSG_ICON = "";
						NONE_NUM = NONE_NUM + 1;
						msg3 = msg3..UnitName(unit)..".";
					end
					RAL.SendMSG(string.format(RAL_TEXT_CHECK_30,MSG_NAME,MSG_ICON,MSG_TARNAME),AlertChan,1);
				end
			end
		else
			RaidAlerter.AddMsg(string.format(RAL_TEXT_CHECK_32,"|cFFFF5555"..check.."|r"));
			return;
		end
	end

	if NONE_NUM > 0 then
		msgend = msgend..string.format(RAL_TEXT_CHECK_33,NONE_NUM)..msg3;
	end
	for i = 1, 8 do
		if ICON_COUNT[i] > 1 then
			SAME_NUM = SAME_NUM + ICON_COUNT[i];
			msg2 = msg2.."("..RaidAlerter_RAIDICON[i]..":"..NAME_COUNT[i]..") ";
		end
	end
	if msg2 ~= "" then
		msgend = msgend..string.format(RAL_TEXT_CHECK_34,SAME_NUM)..msg2;
	end
	RAL.SendMSG(msgend,AlertChan,1);
end

--通报灵魂石绑定状态
function RaidAlerter_CheckGem(check)
	if (not UnitInRaid("player")) and (not IsInInstance()) then
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_OUTRAID);
		return;
	end
	RAL.SendMSG(string.format(RAL_TEXT_TIP_6,#GemName)..": "..RaidAlerter_GetGemOnNames(),AlertChan,1);
end

function RaidAlerter_Check_CTRAORA_LA_TANKS()
	if (not (UnitInRaid("player"))) then
		if IsInInstance() then
			_, instanceType = GetInstanceInfo();
			if instanceType == "party" then
				return;
			end
		else
			return;
		end
	end
	if RaidAlerter_TestMtHasSet() then
		RaidAlerter.AddMsg(string.format(RAL_TEXT_CHECK_26,"|cFF20FF20"..RaidAlerter_TestMtHasSet().."|r"));
		for k, v in pairs(RAL_Tanks) do
			RaidAlerter.AddMsg(RAL.ToRed(k.."T")..RAL.ToGreen(RAL_TEXT_ARROW_R)..RaidAlerter_ToClassColorNameText(v));
		end
	else
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_CHECK_24);
	end
	if (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
		RaidAlerter.AddMsg("|cFF20FF20"..RAL_TEXT_CHECK_27);
	else
		RaidAlerter.AddMsg("|cFFFF5555"..RAL_TEXT_CHECK_25);
	end
end

function RaidAlerter_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local addon = ...;
		if addon ~= "RaidAlerter" then return end
		if RaidAlerter_SET.TextMShow_OnOff then
			RaidAlerter_Attack_Frame:Show();
			RaidAlerter_SET_FUNC_AF_Scale();
		else
			RaidAlerter_Attack_Frame:Hide()
		end
		RaidAlerter_Check_Variables();
		RaidAlerter_ChatFrame_Filter(self);
		C_ChatInfo.RegisterAddonMessagePrefix("RAL_CHECKVER");
		C_ChatInfo.RegisterAddonMessagePrefix("RAL_SELECT");
		C_ChatInfo.RegisterAddonMessagePrefix("RAL_SELECTREPLY");
		C_ChatInfo.RegisterAddonMessagePrefix("RAL_CHECKVERREPL");
		--bf@178.com[[
		RaidAlerter_MainFrame:SetClampedToScreen(true);
		RaidAlerter_Attack_Frame:SetClampedToScreen(true);
		RaidAlerter_SET_AttackFramePosition= RaidAlerter_SET_AttackFramePosition or {"TOP","UIParent","TOP",20,-12}
		BF_RaidAlerter_LoadPosition(RaidAlerter_Attack_Frame);
		RaidAlerter_SetCameraMaxToMax();
		RaidAlerter_Option_MainFrame_Update();
		--bf@178.com]]
		self:UnregisterEvent("ADDON_LOADED");
	elseif (event=="PLAYER_ENTERING_WORLD") then
		RaidAlerter_SetCameraMaxToMax();
		RaidAlerter_Option_MainFrame_Update();
	elseif (event=="CHAT_MSG_ADDON") then
		local ARG_1, ARG_2, ARG_3, ARG_4 = ...;
		if string.sub(ARG_1, 1, 4) == "RAL_" then
			if RAL_DEBUG then RaidAlerter.AddMsg(ARG_1.."↑"..ARG_2.."↑"..ARG_3.."↑"..ARG_4);end		--debug
			if ARG_3=="PARTY" or ARG_3=="RAID" or ARG_3=="BATTLEGROUND" or ARG_3=="INSTANCE_CHAT" then
				RaidAlerter_SYNC(ARG_1,ARG_2,ARG_3,ARG_4);
			end
		end
	elseif event == "UNIT_THREAT_SITUATION_UPDATE" then
		local ARG_1 = ...;
		RaidAlerter_THREAT_UPDATE(ARG_1);
	elseif event == "PLAYER_REGEN_ENABLED" then
		MyLastThreatState = 0;
		TarTarISME = false;
	elseif event == "GROUP_ROSTER_UPDATE" or event == "UNIT_PHASE" then
		RosterChanged = true;
	elseif event == "UPDATE_INSTANCE_INFO" or event == "PLAYER_DIFFICULTY_CHANGED" or event == "ZONE_CHANGED_NEW_AREA" then
		RaidAlerter_GetCurrentDifficulty();
		local CUR_MAX_GROUP = floor((maxPlayers+4)/5);
		if (instanceType == "pvp" and maxPlayers == 0) then CUR_MAX_GROUP = 8;end
--GetWintergraspWaitTime 4.06后失效
--		if (GetWintergraspWaitTime() == nil and GetZoneText() == RAL_TEXT_ZONE_5) then CUR_MAX_GROUP = 8;end
		if GetZoneText() == RAL_TEXT_ZONE_5 then CUR_MAX_GROUP = 8;end
		if CUR_MAX_GROUP > 1 then
			if CUR_MAX_GROUP ~= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
				UIDropDownMenu_SetSelectedID(RaidAlerter_RAIDMODEList, (CUR_MAX_GROUP-1));
				RaidAlerter_RAIDMODE_MAX_GROUP_SETUP(CUR_MAX_GROUP);
			end
		end
	end
end

function RaidAlerter_CombatLogEvent(self, ...)
	if RaidAlerter_SET.OnOff then
		-- new add 增加 otherPara1,otherPara2
		local timestamp, eventtype, _, srcGUID, srcName, srcFlags, tmpone, dstGUID, dstName, dstFlags, tmptwo, spellId, spellName, spellSchool, auraType, amount, otherPara1, otherPara2 = CombatLogGetCurrentEventInfo();
		local t1,t2;
		-- t1 = RaidAlerter_NameToUnit(srcName);
		-- t2 = RaidAlerter_NameToUnit(dstName)
		srcName_bak = srcName;
		dstName_bak = dstName;
		-- if t1 ~= nil then srcName = RaidAlerter_GetSimpleName(srcName) end;
		-- if t2 ~= nil then dstName = RaidAlerter_GetSimpleName(dstName) end;
		srcName = RaidAlerter_GetSimpleName(srcName);
		dstName = RaidAlerter_GetSimpleName(dstName);
		RaidAlerter_Raid_PARTY_Combat_Alerter();
	end
end

function RaidAlerter_GetSimpleName(name)

	if name == nil then
		return name;
	end
	if string.find(name,"-") then
		return string.sub(name,1,string.find(name,"-")-1);
	elseif string.find(name," ") then
		return string.sub(name,1,string.find(name," ")-1);
	else
		return name;
	end

end

function RaidAlerter_GetFullName(name)

	if name == nil then
		return name;
	end
	if string.find(name,"-") then
		return name;
	elseif string.find(name," ") then
		return string.sub(name,1,string.find(name," ")-1).."-"..string.sub(name,string.find(name," ")+1);
	else
		return name;
	end

end

function RaidAlerter_ChatFrame_Filter(self)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", function(self, event, msg)
		if not RaidAlerter_SET.OTMShow_OnOff then
			if msg:match("<RaidAlerter> ") then
				return true;
			end
		end
	end)
	ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", function(self, event, msg)
		if not RaidAlerter_SET.OTMShow_OnOff then
			if msg:match("<BWS>") and UnitAffectingCombat("player")==1 then
				return true;
			end
		end
	end)
end

function RaidAlerter_GetUnitCasterColorName(unit)
	local PartyUnitID = unit:match("^party(%d+)$");
	local RaidUnitID = unit:match("^raid(%d+)$");
	local PartyPetID = unit:match("^partypet(%d+)$");
	local RaidPetID = unit:match("^raidpet(%d+)$");
	local text = RaidAlerter_UnitToColorText(unit);
	if unit == "vehicle" then
		text = text..format("(%s)", RaidAlerter_UnitToColorText("player"));
	elseif unit == "target" then
		text = text..format("(%s)", RAL.ToWhite(TARGET));
	elseif PartyUnitID then
		text = text..format("(%s)", RAL.ToWhite(RAL_TEXT_SELFGROUP));
	elseif RaidUnitID then
		text = text..format("(%s"..RAL_TEXT_GROUP..")", RAL.ToWhite(select(3,GetRaidRosterInfo(RaidUnitID))));
	elseif PartyPetID then
		text = text..format("(%s:%s)", RAL.ToWhite(RAL_TEXT_SELFGROUP), RaidAlerter_UnitToColorText("party"..PartyPetID));
	elseif RaidPetID then
		text = text..format("(%s"..RAL_TEXT_GROUP..":%s)", RAL.ToWhite(select(3,GetRaidRosterInfo(RaidPetID))), RaidAlerter_UnitToColorText("raid"..RaidPetID));
	end
	return text;
end

function RaidAlerter_UnitToColorText(unit)
	local ClassColor = RAID_CLASS_COLORS[select(2,UnitClass(unit))] or NORMAL_FONT_COLOR;
	if (not UnitIsPlayer(unit)) then ClassColor = NORMAL_FONT_COLOR end;
	return format("|cFF%s%s|r",format("%02X%02X%02X",ClassColor.r*255,ClassColor.g*255,ClassColor.b*255),UnitName(unit));
end

--显示法术ID和来源：取自SpellID插件并改进
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self,...)
	if RaidAlerter_SET.SpellIDAndCaster then
		local _,_,_,_,_,_,unitCaster,_,_,id = UnitBuff(...);
		if id then
			if unitCaster then
				self:AddDoubleLine("|cFF00FF00"..RAL_TEXT_TIP_38..": |cFF71D5FF"..id.."|r","|cFF00FF00Buff"..RAL_TEXT_TIP_39..": "..RaidAlerter_GetUnitCasterColorName(unitCaster));
			else
				self:AddLine("|cFF00FF00"..RAL_TEXT_TIP_38..": |cFF71D5FF"..id.."|r");
			end
			self:Show();
		end
	end
end)
hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self,...)
	if RaidAlerter_SET.SpellIDAndCaster then
		local _,_,_,_,_,_,unitCaster,_,_,id = UnitDebuff(...);
		if id then
			if unitCaster then
				self:AddDoubleLine("|cFF00FF00"..RAL_TEXT_TIP_38..": |cFF71D5FF"..id.."|r","|cFF00FF00Debuff"..RAL_TEXT_TIP_39..": "..RaidAlerter_GetUnitCasterColorName(unitCaster));
			else
				self:AddLine("|cFF00FF00"..RAL_TEXT_TIP_38..": |cFF71D5FF"..id.."|r");
			end
			self:Show();
		end
	end
end)
hooksecurefunc(GameTooltip, "SetUnitAura", function(self,...)
	if RaidAlerter_SET.SpellIDAndCaster then
		local _,_,_,_,_,_,unitCaster,_,_,id = UnitAura(...);
		if id then
			if unitCaster then
				self:AddDoubleLine("|cFF00FF00"..RAL_TEXT_TIP_38..": |cFF71D5FF"..id.."|r","|cFF00FF00Aura"..RAL_TEXT_TIP_39..": "..RaidAlerter_GetUnitCasterColorName(unitCaster));
			else
				self:AddLine("|cFF00FF00"..RAL_TEXT_TIP_38..": |cFF71D5FF"..id.."|r");
			end
			self:Show();
		end
	end
end)
hooksecurefunc("SetItemRef", function(link, text, button, chatFrame)
	if RaidAlerter_SET.SpellIDAndCaster then
		if string.find(link,"^spell:") then
			local id = string.sub(link,7);
			ItemRefTooltip:AddLine("|cFF00FF00"..RAL_TEXT_TIP_38..": |cFF71D5FF"..id.."|r");
			ItemRefTooltip:Show();
		end
	end
end)
GameTooltip:HookScript("OnTooltipSetSpell", function(self)
	if RaidAlerter_SET.SpellIDAndCaster then
		local id = select(2,self:GetSpell());
		if id then
			self:AddLine("|cFF00FF00"..RAL_TEXT_TIP_38..": |cFF71D5FF"..id.."|r");
			self:Show();
		end
	end
end)

function RaidAlerter_SYNC(ARG_1,ARG_2,ARG_3,ARG_4)
	ARG_1 = string.sub(ARG_1, 1, 16);	--为"RAL_CHECKVERREPLY"兼容
	if ARG_1=="RAL_SELECT" then
		local RAL_SYNC_PAR = "";

		local SETONCOUNT = 0;
		--传递设置参数，优先取用开启警报项目较全者为报警方（基于默认设定项目）
		if RaidAlerter_SET.BossHealthPecentOnOff then SETONCOUNT = SETONCOUNT + 1;end
		if RaidAlerter_SET.BossKill then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.TANK_DangerHealth then SETONCOUNT = SETONCOUNT + 1;end
		if RaidAlerter_SET.TANK_Death then SETONCOUNT = SETONCOUNT + 1;end
		if RaidAlerter_SET.TANK_ShieldWall then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.TANK_LastStand then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.TANK_ShieldReflection then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.Hunter_Misdirection then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.Hunter_Shot then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.TANK_Taunt then SETONCOUNT = SETONCOUNT + 1;end
		if RaidAlerter_SET.RES_DispelMagic then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.RES_Polymorph then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.RES_MagicBreak then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.RES_BuffStolen then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.Check_Poly then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.PolyDispel then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.Break_Poly then SETONCOUNT = SETONCOUNT + 1;end
		if RaidAlerter_SET.Dispel_Magic then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.BuffStolen then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.Break_Magic then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.Check_Gem then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.Paladin_Intervention then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.Check_Death_AtCombatEnd then SETONCOUNT = SETONCOUNT + 0.5;end
		if RaidAlerter_SET.OT_OnOff then SETONCOUNT = SETONCOUNT + 1;end
		if RaidAlerter_SET.RaidSpell then SETONCOUNT = SETONCOUNT + 1;end

		--不适宜做警报方的检测修正
		if not(oRA or oRA3 or CT_RA_MainTanks) then SETONCOUNT = SETONCOUNT - 2;end		--无团队助手

		SETONCOUNT = floor(SETONCOUNT);
		if SETONCOUNT<1 then SETONCOUNT = 1;end
		if SETONCOUNT>16 then SETONCOUNT = 16;end

		if RaidAlerter_SYNC_SELECT_SETTOME == 0 then
			SETONCOUNT = SETONCOUNT + RaidAlerter_SYNC_VerPOINT;
		end
		if RaidAlerter_SYNC_SELECT_SETTOME == 2 then
			SETONCOUNT = 1;
		end
		if RaidAlerter_SYNC_SELECT_SETTOME == 1 then
			SETONCOUNT = 99;
		end
		if (UnitInRaid("player")) or IsInInstance() then
			if RaidAlerter_NameToGroup(UnitName("player")) > RaidAlerter_SET.RAIDMODE_MAX_GROUP then	--自己属于替补
				SETONCOUNT = 1;
			end
		end
		if UnitIsGhost("player") then	--灵魂中
			SETONCOUNT = 1;
		end

		SETONCOUNT = 97; -- new add
		if UnitIsGroupLeader("player") then
			SETONCOUNT = SETONCOUNT + 2;
		end
		if UnitIsGroupAssistant("player") then
			SETONCOUNT = SETONCOUNT + 1;
		end

		RAL_SYNC_PAR = SETONCOUNT..RAL_SYNC_PAR;

		--附加传递性能参数，大者为优。若开启警报项目数量一致则取游戏性能较好的玩家为报警方
		local _,_,RAL_SYNC_latency = GetNetStats();
		RAL_SYNC_PAR = RAL_SYNC_PAR..format("%012d",((10000/(RAL_SYNC_latency+10))+((GetFramerate()/10) + (random(100)/100)))*1000000);

		RaidAlerter_SetAddonMessage("RAL_SELECTREPLY", RAL_SYNC_PAR);
		return;
	end
	if ARG_1=="RAL_SELECTREPLY" then
		if RaidAlerter_GetTimer("SYNCSELECT")<3 then		--有效响应时间：3秒内
			if tonumber(ARG_2) >= RaidAlerter_SYNC_SELECT_TMPPRA then
				if ARG_4 == UnitName("player") or RaidAlerter_GetFullName(UnitFullName("player")) == ARG_4 or RaidAlerter_GetSimpleName(ARG_4) == UnitName("player") then
					RaidAlerter_SYNC_SELECT_TOME = 1;
				else
					RaidAlerter_SYNC_SELECT_TOME = 0;
				end
				RaidAlerter_SYNC_SELECT_TMPPRA = tonumber(ARG_2);
				RaidAlerter_SYNC_SELECT_NAME = ARG_4;
			end
		end
		return;
	end
	if ARG_1=="RAL_CHECKVER" then
		local _,_,RAL_SYNC_latency = GetNetStats();
		RaidAlerter_SetAddonMessage("RAL_CHECKVERREPLY", RaidAlerter_Version.."("..RaidAlerter_GetTFVarText(RaidAlerter_SET.OnOff,1)..")  "..RAL_SYNC_latency.."ms, "..format("%.1f",GetFramerate()).."FPS");
		return;
	end
	if ARG_1=="RAL_CHECKVERREPL" then
		if RaidAlerter_SYNC_CHECKVER==1 then
			RaidAlerter.AddMsg(ARG_4..": "..RAL_TEXT_FUNC_50..ARG_2, 1);
			RaidAlerter_SYNC_CHECKVERCOUNT = RaidAlerter_SYNC_CHECKVERCOUNT + 1;
		end
		return;
	end
end

--OnUpdate事件
function RaidAlerter_Frame_OnUpdate(self)
--	if RaidAlerter_GetTimer("RaidAlerter_Update")>0.25 then	--每秒检测大约4次
	if GetTime() > RAL_NextUpdateTime then
		RaidAlerter_SendAddonMessage();
		--每9秒检查一次自己的组队和LA状态是否变更，若有变化（如加入团队或被提升）则发起选择报警方请求
		if (RaidAlerter_GetTimer("RaidAlerter_SYNC_MyStatus_Check")>9) and (RosterChanged) then
			local PR="";
			local PP="";
			local PA="";
			if UnitInRaid("player") or IsInInstance() then PR="T" else PR="F" end
			if (not (UnitInRaid("player") or IsInInstance())) and (GetNumGroupMembers()>0) then PP="T" else PP="F" end
			if (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then PA="T" else PA="F" end
			RaidAlerter_SYNC_MyStatus = PR..PP..PA;
			if RaidAlerter_SYNC_MyStatus_Last ~= RaidAlerter_SYNC_MyStatus then
				RaidAlerter_SYNC_SELECT_TOME = 1;
				RaidAlerter_SetAddonMessage("RAL_SELECT","startcheck");
				RaidAlerter_SYNC_MyStatus_Last = RaidAlerter_SYNC_MyStatus;
				RaidAlerter_StartTimer("RaidAlerter_SYNC_MyStatus_Check");
			end
			ImTANK = RaidAlerter_TestIsMtList("player");		--检查自己是否TANK
			RosterChanged = false;
		end

		if RaidAlerter_SYNC_CHECKVER == 1 then
			if RaidAlerter_GetTimer("SYNCCHECKVER")>3 then		--版本检查：等待3秒
				RaidAlerter.AddMsg(string.format(RAL_TEXT_SYNC_END_CHECK,"|cFF20FF20"..RaidAlerter_SYNC_CHECKVERCOUNT.."|r"));
				RaidAlerter_SYNC_CHECKVER = 0;
				RaidAlerter_SYNC_CHECKVERCOUNT = 0;
			end
		end

		if RaidAlerter_SYNC_SELECT_NAME_MSG == 1 then
			if RaidAlerter_GetTimer("SELECTNAMEMSG")>3 then		--显示报警发送方选择：等待3秒
				RaidAlerter.AddMsg(RAL_TEXT_SYNC_SELECT_FINISH..RaidAlerter_ToClassColorNameText(RaidAlerter_SYNC_SELECT_NAME));
				RaidAlerter_SYNC_SELECT_NAME_MSG = 0;
			end
		end

		RaidAlerter_TOT_CHECK();

		if UnitInRaid("player") or IsInInstance() then					--In RAID
			RaidAlerter_Attack_Frame_OnUpdate();		--更新状态条参数
			RaidAlerter_Check_MyHP();

			if RaidAlerter_GetTimer("RaidAlerter_Boss_Record")>5 then		--RAID中每5秒更新一次worldboss表
				RaidAlerter_Boss_Record();
				RaidAlerter_StartTimer("RaidAlerter_Boss_Record");
			end

			if not RaidAlerter_SET.OnOff then
				RaidAlerter_StartTimer("RaidAlerter_Update");
				return;
			end

			RaidAlerter_TestAllRaidAffectingCombat();		--更新RaidAlerter_RaidAllInCombat参数

			if RaidAlerter_RaidAllInCombat then
				RaidAlerter_Raid_DeadMsg = true;
				RaidAlerter_RaidCombatEnd_CheckRAM = true;
				if not RaidAlerter_BattleTime_Record then
					RaidAlerter_BattleTime_Record = true;
					RaidAlerter_StartTimer("BattleTime_Record");
				end
				RaidAlerter_Check_BossHealthPecent(RaidAlerter_GetIsTargetBossUnit());
				RaidAlerter_Check_T_health();
				-- RaidAlerter_Check_P_BeControled();
			else
				if (RaidAlerter_Alerter_System["lasticon"] ~= "0") then
					SetRaidTargetIcon(RaidAlerter_NameToUnit(RaidAlerter_Alerter_System["lasticon"]), 0);
					RaidAlerter_Alerter_System["lasticon"] = "0";
					if (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
						RaidAlerter.AddMsg(RAL_TEXT_ICON_CLEAR);
					end
				end
				--自动回收垃圾内存机制：RAID中若RaidAlerter内存占用超过设定界限（默认416K）则在战斗结束时予以回收
				if RaidAlerter_RaidCombatEnd_CheckRAM then
					RaidAlerter_SET_FUNC_ResetRAM(RaidAlerter_SET.MAXRAM);
					RaidAlerter_RaidCombatEnd_CheckRAM = false;
				end

				if RaidAlerter_Raid_DeadMsg then
					if (DeadRaidmembers > 0) and RaidAlerter_SET.OnOff then
						if RaidAlerter_SET.Check_Death_AtCombatEnd then
							if (RaidAlerter_Alerter_System["stcn"]>0) then
								if UnitName("raid"..RaidAlerter_Alerter_System["stcn"])~=nil then
									RaidAlerter.AddMsg(string.format(RAL_TEXT_ALERT_11,RaidAlerter_ToClassColorNameText(UnitName("raid"..RaidAlerter_Alerter_System["stcn"]))));
								end
							end

							if ((not UnitIsGhost("player")) and (GetRealZoneText()~=RAL_TEXT_ZONE_4)) then
								local CENDSCMSG="**";
								if (DeadRaidmembers >= ((RaidNum - OffLineRaidmembers)*0.5)) then
									CENDSCMSG=CENDSCMSG..string.format(RAL_TEXT_ALERT_12,DeadRaidmembers);
									CENDSCMSG=CENDSCMSG..", "..string.format(RAL_TEXT_ALERT_13,#GemName)..":"..RaidAlerter_GetGemOnNames();
								else
									CENDSCMSG=CENDSCMSG..string.format(RAL_TEXT_ALERT_12,DeadRaidmembers);
									if ManaPercent<60 then
										CENDSCMSG=CENDSCMSG..", "..string.format(RAL_TEXT_ALERT_14,ManaPercent);
									end
									if CureManaPercent<60 then
										CENDSCMSG=CENDSCMSG..", "..string.format(RAL_TEXT_ALERT_15,CureManaPercent);
									end
								end
								CENDSCMSG=CENDSCMSG.."**";
								RAL.SendMSG(CENDSCMSG,AlertChan);
							end
						end
						RaidAlerter_Raid_DeadMsg = false;
					end
				else
					RaidAlerter_Check_SoulGemOn();
				end

				if RaidAlerter_BattleTime_Record then
					local timetmp = RaidAlerter_GetTimer("BattleTime_Record");
					if timetmp > 30 then						--只记录持续30秒以上的战斗时间（排除一些特例）
						RaidAlerter_BattleTime_Last = RaidAlerter_BattleTime_This;
						RaidAlerter_BattleTime_This = timetmp;
					end
					RaidAlerter_BattleTime_Record = false;

					if (not UnitIsGhost("player")) then
						local m, s = RaidAlerter_SecondsToTime(timetmp);
						if m == 0 then
							if RaidAlerter_Alerter_System.BossHealthPecentTMP < 99 then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_9,s),AlertChan);
							else
								RaidAlerter.AddMsg("|cFF00FF00"..string.format(RAL_TEXT_ALERT_9,"|cFFFFFFFF"..s.."|cFF00FF00"));
							end
						else
							if RaidAlerter_Alerter_System.BossHealthPecentTMP < 99 then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_10,m,s),AlertChan);
							else
								RaidAlerter.AddMsg("|cFF00FF00"..string.format(RAL_TEXT_ALERT_10,"|cFFFFFFFF"..m.."|cFF00FF00","|cFFFFFFFF"..s.."|cFF00FF00"));
							end
						end
					end
					RaidAlerter_Alerter_System["stcn"] = 0;
					RaidAlerter_Alerter_System["maxcn"] = 0;
					TankingPlayer = "";
				end
				RaidAlerter_Alerter_System.BossHealthPecentTMP = 100;
			end
			--OT监测（团队）
			if DeadRaidmembers < ((RaidNum - OffLineRaidmembers)*0.5) then		--死亡人数过多视为AG，停报OT
				RaidAlerter_MemberThreatCheck(RaidAlerter_GetDangerUnit());
			end
		else
			--非RAID状态下，在非战斗状态时每200秒检测一次内存占用。若内存占用超过设定界限（默认416K）则启动清理
			if UnitAffectingCombat("player")~=1 and RaidAlerter_GetTimer("RaidAlerter_SOLO_Party_CheckRAM")>200 then
				RaidAlerter_SET_FUNC_ResetRAM(RaidAlerter_SET.MAXRAM);
				RaidAlerter_StartTimer("RaidAlerter_SOLO_Party_CheckRAM");
			end
			if GetNumGroupMembers()>0 then		--In Party
				if RaidAlerter_SET.OnOff then
					if RaidAlerter_SYNC_SELECT_TOME == 1 then
						RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_2, "|cFF20FF20"..RAL_TEXT_FRAME_ON.."|r", RAL.ToOrange(GetNumGroupMembers()+1), RaidAlerter_GetCurrentDifficulty(2), RaidAlerter_LootMethodTEXT(2)));
					else
						RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_2, "|cFFFFDD00"..RAL_TEXT_FRAME_ON.."|r", RAL.ToOrange(GetNumGroupMembers()+1), RaidAlerter_GetCurrentDifficulty(2), RaidAlerter_LootMethodTEXT(2)));
					end
				else
					RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_2, "|cFFFF2020"..RAL_TEXT_FRAME_OFF.."|r", RAL.ToOrange(GetNumGroupMembers()+1), RaidAlerter_GetCurrentDifficulty(2), RaidAlerter_LootMethodTEXT(2)));
				end
				if RaidAlerter_GetTimer("RaidAlerter_Boss_Record")>5 then		--5人小队中每5秒更新一次boss表
					RaidAlerter_Boss_Record_Party();
					RaidAlerter_StartTimer("RaidAlerter_Boss_Record");
				end
				if not (RaidAlerter_SET.OnOff and RaidAlerter_SET.Party_Alerter) then
					RaidAlerter_StartTimer("RaidAlerter_Update");
					return;
				end
				if (UnitAffectingCombat("player")==1 or UnitIsDead("player")) then
					RaidAlerter_Check_Party_health();
					RaidAlerter_Check_BossHealthPecent_Party(RaidAlerter_GetIsTargetBossUnit_Party());
					-- RaidAlerter_Check_P_BeControled_Party();
				end
				--OT监测（5人小队）
				RaidAlerter_MemberThreatCheck(RaidAlerter_GetDangerUnit());
			else		--SOLO
				if RaidAlerter_SET.OnOff then
					RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_1,"|cFF20FF20"..RAL_TEXT_FRAME_ON.."|r"));
				else
					RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_1,"|cFFFF2020"..RAL_TEXT_FRAME_OFF.."|r"));
				end
			end
		end
		RAL_NextUpdateTime = GetTime() + 0.15;			--每秒检测大约6次
--		RaidAlerter_StartTimer("RaidAlerter_Update");
	end
end

--名称按玩家职业着色，非玩家着色为红色
function RaidAlerter_ToClassColorNameText(name)
	name = name or NONE;
	local SELECT_UNIT = RaidAlerter_NameToUnit(name);
	if not SELECT_UNIT then return "|cFFFF0000"..name.."|r";end
	local ClassColor = RAID_CLASS_COLORS[select(2,UnitClass(SELECT_UNIT))] or NORMAL_FONT_COLOR;
	return format("|cFF%s%s|r",format("%02X%02X%02X",ClassColor.r*255,ClassColor.g*255,ClassColor.b*255),name);
end

--数值着色
function RaidAlerter_ToSafeColorText(num,safe,mid,danger)
	local r, g, b;
	if safe > danger then					--规则1：大值安全
		if num >= safe then
			r = 0.0; g = 1.0; b = 0.0;		--安全，绿色
		elseif num <= danger then
			r = 1.0; g = 0.0; b = 0.0;		--危险，红色
		else
			if num >= mid then				--中值，黄色
				r = 1-((num-mid)/(safe-mid)); g = 1.0; b = 0.0;
			else
				r = 1.0; g = 1-((mid-num)/(mid-danger)); b = 0.0;
			end
		end
	else									--规则2：小值安全
		if num <= safe then
			r = 0.0; g = 1.0; b = 0.0;
		elseif num >= danger then
			r = 1.0; g = 0.0; b = 0.0;
		else
			if num <= mid then
				r = 1-((mid-num)/(mid-safe)); g = 1.0; b = 0.0;
			else
				r = 1.0; g = 1-((num-mid)/(danger-mid)); b = 0.0;
			end
		end
	end
	return format("|cFF%s%d|r",format("%02X%02X%02X",r*255,g*255,b*255),num);
end

--更新状态条（团队时）
function RaidAlerter_Attack_Frame_OnUpdate()
	if Attack_Frame_UPDATE_FREQ >= 2 then				--更新频率0.25x2=0.5秒
		RaidAlerter_Get_RaidState();					--更新团队参数
		RaidAlerter_UpdateTanks();						--更新主坦克表
		local RAL_AllMP = RaidAlerter_ToSafeColorText(ManaPercent,95,50,20);
		local RAL_HealMP = RaidAlerter_ToSafeColorText(CureManaPercent,95,50,20);
		local RAL_DeadN = RaidAlerter_ToSafeColorText(DeadRaidmembers,0,RaidNum/4,RaidNum/2);
		local AFrame_TEXT = "";
		if IsInInstance() or RaidAlerter_RaidAllInCombat then
			if RaidAlerter_SET.OnOff then
				if RaidAlerter_SYNC_SELECT_TOME == 1 then
					RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_3, "|cFF20FF20"..RAL_TEXT_FRAME_ON.."|r",RAL_AllMP, RAL_HealMP, RAL_DeadN));
				else
					RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_3, "|cFFFFDD00"..RAL_TEXT_FRAME_ON.."|r",RAL_AllMP, RAL_HealMP, RAL_DeadN));
				end
			else
				RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_3, "|cFFFF2020"..RAL_TEXT_FRAME_OFF.."|r",RAL_AllMP, RAL_HealMP, RAL_DeadN));
			end
		else
			if RaidAlerter_SET.OnOff then
				if RaidAlerter_SYNC_SELECT_TOME == 1 then
					RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_4, "|cFF20FF20"..RAL_TEXT_FRAME_ON.."|r",RAL.ToOrange(GetNumGroupMembers()), RaidAlerter_GetCurrentDifficulty(1), RaidAlerter_LootMethodTEXT(2)));
				else
					RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_4, "|cFFFFDD00"..RAL_TEXT_FRAME_ON.."|r",RAL.ToOrange(GetNumGroupMembers()), RaidAlerter_GetCurrentDifficulty(1), RaidAlerter_LootMethodTEXT(2)));
				end
			else
				RaidAlerter_Attack_Frame_Text:SetText(string.format(RAL_TEXT_FRAME_4, "|cFFFF2020"..RAL_TEXT_FRAME_OFF.."|r",RAL.ToOrange(GetNumGroupMembers()), RaidAlerter_GetCurrentDifficulty(1), RaidAlerter_LootMethodTEXT(2)));
			end
		end
		Attack_Frame_UPDATE_FREQ = 0;
	end
	Attack_Frame_UPDATE_FREQ = Attack_Frame_UPDATE_FREQ + 1;
end

--团队状态条快捷键操作
function RaidAlerter_RaidState(self, button)
	if button=="LeftButton" then
		if (IsControlKeyDown() and IsAltKeyDown()) then
			RaidAlerter_SET_FUNC_CHK_MY_HP();
			return;
		end
		if IsShiftKeyDown() then
			RaidAlerter_CheckRaidBuff();
		elseif IsAltKeyDown() then
			RaidAlerter_Target_Check("MT");
		elseif IsControlKeyDown() then
			RaidAlerter_CheckPlayer();
		else
			RaidAlerter_SET_FUNC_OnOff("OnOff");
		end
	elseif button=="RightButton" then
		if IsShiftKeyDown() then
			RaidAlerter_SET_FUNC_ResetRAM("reset");
		elseif IsAltKeyDown() then
			RaidAlerter_CheckFlask("all");
		elseif IsControlKeyDown() then
			RaidAlerter_CheckFlask();
		else
			RaidAlerter_Option_MainFrame_Show(self);
		end
	end
end

--报警监视
function RaidAlerter_Raid_PARTY_Combat_Alerter()
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
		--SetChannel = "BATTLEGROUND";
		AlertChan = "INSTANCE_CHAT";
		AlertWChan = "INSTANCE_CHAT";
	else
		if IsInRaid() then
			AlertChan = "RAID";
			AlertWChan = "RAID_WARNING";
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			AlertChan = "PARTY";
			AlertWChan = "PARTY";
		end
	end
	--if UnitInRaid("player") then
		--不开启战场频道
		--if GetBattlefieldInstanceRunTime()>0 then
		--	AlertChan = "BATTLEGROUND";
		--	AlertWChan = "BATTLEGROUND";
		--else
		--	AlertChan = "RAID";
		--	AlertWChan = "RAID_WARNING";
		--end
	--elseif GetNumGroupMembers()>0 then
	--	if not RaidAlerter_SET.Party_Alerter then return; end
	--	AlertChan = "PARTY";
	--	AlertWChan = "PARTY_RW";
	--else
	--	return;
	--end

	if eventtype == "SPELL_AURA_APPLIED" then
		if RaidAlerter_SET.Break_Poly then
			if (spellName == RAL_TEXT_SPELL_9 or spellName == RAL_TEXT_BUFF_11 or spellName == RAL_TEXT_SPELL_10 or spellName == RAL_TEXT_SPELL_11 or spellName == RAL_TEXT_SPELL_12) then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				TempUnit2 = RaidAlerter_GUIDToUnit(dstGUID);
				if TempUnit2 then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_7,dstName,srcName,RAL.SpellIdToText(spellId, 1)),AlertChan);
				end
			end
		end
		-- 113075 共生树皮
		if RaidAlerter_SET.TANK_ShieldWall then
			if spellName == RAL_TEXT_SPELL_1 or spellName == RAL_TEXT_SPELL_30 or spellName == RAL_TEXT_SPELL_33
			or spellName == RAL_TEXT_SPELL_34 or spellId == 22812 or spellId == 86659 or spellId == 113075 then
				TempUnit1 = RaidAlerter_GUIDToUnit(dstGUID);
				if TempUnit1 then
					-- new add 只有坦克并且不是精通光环
					if RaidAlerter_CheckTank(dstName) then
						RAL.SendMSG(string.format(RAL_TEXT_ALERT_16,dstName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
					end
				end
				return;
			end
		end
		if RaidAlerter_SET.TANK_LastStand then
			-- 22842 狂怒恢复（熊½½¢态）
			if spellName == RAL_TEXT_SPELL_2 or spellName == RAL_TEXT_SPELL_31 or spellName == RAL_TEXT_SPELL_36 or spellId == 22842 then
				TempUnit1 = RaidAlerter_GUIDToUnit(dstGUID);
				if TempUnit1 then
					-- new add 只有坦克才警报
					if RaidAlerter_CheckTank(dstName) then
						RAL.SendMSG(string.format(RAL_TEXT_ALERT_16,dstName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
					end
				end
				return;
			end
		end


		-- new add start
		if RaidAlerter_SET.TANK_ShieldWall then
			-- if spellName == RAL_TEXT_SPELL_60 then
			-- 	TempUnit1 = RaidAlerter_NameToUnit(srcName);
			-- 	TempUnit2 = RaidAlerter_NameToUnit(dstName);
			-- 	if (TempUnit1 == TempUnit2 or srcName == dstName) and TempUnit1 then
			-- 		RAL.SendMSG(string.format(RAL_TEXT_ALERT_17,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
			-- 	end
			-- 	return;
			-- end
			-- 31850:忠诚防御者 110696 共生寒冰
			if spellId == 642 or spellId == 45438 or spellId == 31850 or spellId == 110696 then
				TempUnit1 = RaidAlerter_NameToUnit(srcName);
				TempUnit2 = RaidAlerter_NameToUnit(dstName);

				if TempUnit1 then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_17,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
				end
				return;
			end
		end

		if RaidAlerter_SET.TANK_ShieldWall then
			if spellId == 50720 or spellId == 49016 then
				TempUnit1 = RaidAlerter_NameToUnit(srcName);
				TempUnit2 = RaidAlerter_NameToUnit(dstName);
				if TempUnit1 then
					-- RAL.SendMSG(string.format(RAL_TEXT_ALERT_61,srcName,dstName,amount,RAL.SpellIdToText(spellId, 1)), AlertChan);
				end
				return;
			end
		end

		-- new add end


		if spellName == RAL_TEXT_SPELL_3 then
			TempUnit1 = RaidAlerter_GUIDToUnit(dstGUID);
			if TempUnit1 then
				if RaidAlerter_SET.Check_Gem then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_44,RAL.SpellIdToText(spellId, 1),srcName,dstName), AlertChan);
				end
				if RaidAlerter_RaidAllInCombat then
					RaidAlerter_Table_Update(GemName, dstName, "ADD");
				else
					RaidAlerter_Check_SoulGemOn();
				end
			end
			return;
		end
		if spellName == RAL_TEXT_SPELL_98 then
			TempUnit1 = RaidAlerter_NameToUnit(srcName);
			TempUnit2 = RaidAlerter_NameToUnit(dstName);

			if dstName~= nil and srcName~= nil and srcName ~= dstName then
				RAL.SendMSG(string.format(RAL_TEXT_ALERT_60,RAL.SpellIdToText(spellId, 1),srcName,dstName), AlertChan);
				if RaidAlerter_SET.Nef_PriestDown then
					if RaidAlerter_SYNC_SELECT_TOME == 1 then
						SendChatMessage(string.format(RAL_TEXT_ALERT_60,RAL.SpellIdToText(spellId, 1),srcName_bak,"你"),"WHISPER",nil,dstName_bak);
					end
				end
			end
			return;
		end
		return;
	end

	if eventtype == "SPELL_CAST_START" then		--4.x药锅只产生SPELL_CAST_START事件（感谢NGA-夙夙 帮助测试）
		if not RaidAlerter_RaidAllInCombat then			--只在非团队战斗状态检测
			if RaidAlerter_SET.RaidSpell then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					for i, v in pairs(RAL_TEXT_RAIDSPELL_3) do
						if v["MATCH"] == 0 then
							if string.find(spellName, v["TEXT"]) then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan, 0, 10, "RAIDSPELL"..srcGUID);	--刷屏限制：10秒
								if UnitInRaid("player") then
									RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(srcName),RAL.SpellIdToText(spellId, 0, 1)));
								end
								if v["TYPE"] == "COOKFOOD" then
									RaidAlerter_StartTimer("COOKFOOD_CREAT");
									COOKFOODDUR = v["DUR"];
								end
								return;
							end
						elseif v["MATCH"] == 1 then
							if spellName == v["TEXT"] then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan, 0, 10, "RAIDSPELL"..srcGUID);	--刷屏限制：10秒
								if UnitInRaid("player") then
									RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(srcName),RAL.SpellIdToText(spellId, 0, 1)));
								end
								if v["TYPE"] == "COOKFOOD" then
									RaidAlerter_StartTimer("COOKFOOD_CREAT");
									COOKFOODDUR = v["DUR"];
								end
								return;
							end
						end
					end
				end
			end
		end
		return;
	end

	if eventtype == "SPELL_CREATE" then
		if not RaidAlerter_RaidAllInCombat then			--只在非团队战斗状态检测
			if RaidAlerter_SET.RaidSpell then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					for i, v in pairs(RAL_TEXT_RAIDSPELL_1) do
						if v["MATCH"] == 0 then
							if string.find(spellName, v["TEXT"]) then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan, 0, 10, "RAIDSPELL"..srcGUID);	--刷屏限制：10秒
								if UnitInRaid("player") then
									RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(srcName),RAL.SpellIdToText(spellId, 0, 1)));
								end
								if v["TYPE"] == "COOKFOOD" then
									RaidAlerter_StartTimer("COOKFOOD_CREAT");
									COOKFOODDUR = v["DUR"];
								end
								return;
							end
						elseif v["MATCH"] == 1 then
							if spellName == v["TEXT"] then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan, 0, 10, "RAIDSPELL"..srcGUID);	--刷屏限制：10秒
								if UnitInRaid("player") then
									RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(srcName),RAL.SpellIdToText(spellId, 0, 1)));
								end
								if v["TYPE"] == "COOKFOOD" then
									RaidAlerter_StartTimer("COOKFOOD_CREAT");
									COOKFOODDUR = v["DUR"];
								end
								return;
							end
						end
					end
				end
			end
		end
		return;
	end

	if eventtype == "SPELL_CAST_SUCCESS" then
		if not RaidAlerter_RaidAllInCombat then			--只在非团队战斗状态检测
			if RaidAlerter_SET.RaidSpell then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					for i, v in pairs(RAL_TEXT_RAIDSPELL_2) do
						if v["MATCH"] == 0 then
							if string.find(spellName, v["TEXT"]) then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan, 0, 10, "RAIDSPELL"..srcGUID);	--刷屏限制：10秒
								if UnitInRaid("player") then
									RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(srcName),RAL.SpellIdToText(spellId, 0, 1)));
								end
								return;
							end
						elseif v["MATCH"] == 1 then
							if spellName == v["TEXT"] then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan, 0, 10, "RAIDSPELL"..srcGUID);	--刷屏限制：10秒
								if UnitInRaid("player") then
									RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(srcName),RAL.SpellIdToText(spellId, 0, 1)));
								end
								return;
							end
						end
					end
				end
			end
		end
		if RaidAlerter_SET.TANK_ShieldWall then
			--武僧坦技能
			if spellName == RAL_TEXT_SPELL_93 or spellName == RAL_TEXT_SPELL_94 or spellName == RAL_TEXT_SPELL_95 then
				TempUnit1 = RaidAlerter_GUIDToUnit(dstGUID);
				if TempUnit1 then
					-- new add 只有坦克并且不是精通光环
					if RaidAlerter_CheckTank(dstName) then
						RAL.SendMSG(string.format(RAL_TEXT_ALERT_16,dstName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
					end
				end
				return;
			end
		end
		-- if spellName == RAL_TEXT_SPELL_37 then		--专注魔法：只在本机显示提示，玩家属于无关人员则不于显示
		-- 	if not(UnitIsGroupLeader("player") or UnitIsGroupAssistant("player") or (UnitPowerType("player")==0 and (UnitClass("player")~=RAL_TEXT_HUNTER))) then
		-- 		return;
		-- 	end
		-- 	TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
		-- 	if TempUnit1 then
		-- 		if srcName == UnitName("player") then
		-- 			RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_44,RAL.SpellIdToText(spellId, 1, 1),RAL.ToPink(RAL_TEXT_YOU),RaidAlerter_ToClassColorNameText(dstName)), nil, true);
		-- 		elseif dstName == UnitName("player") then
		-- 			RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_44,RAL.SpellIdToText(spellId, 1, 1),RaidAlerter_ToClassColorNameText(srcName),RAL.ToPink(RAL_TEXT_YOU)), nil, true);
		-- 		else
		-- 			RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_44,RAL.SpellIdToText(spellId, 1, 1),RaidAlerter_ToClassColorNameText(srcName),RaidAlerter_ToClassColorNameText(dstName)), nil, true);
		-- 		end
		-- 	end
		-- 	return;
		-- end
		-- 114018,潜伏帷幕 ,31821 虔诚光环 ， 114207 战旗 15286 吸血鬼拥抱
		--武僧还魂术等
		if spellId == 15286 or spellId == 31821 or spellId == 114018 or spellName == RAL_TEXT_SPELL_96 or spellId == 114207 or spellId == 114203 or spellId == 114192 then
			TempUnit1 = RaidAlerter_NameToUnit(srcName);
			TempUnit2 = RaidAlerter_NameToUnit(dstName);

			if TempUnit1 then
				RAL.SendMSG(string.format(RAL_TEXT_ALERT_17,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
			end
			return;
		end

		if spellName == RAL_TEXT_SPELL_4 or spellName == RAL_TEXT_SPELL_4_SPEC_1 then
			if RaidAlerter_SET.Hunter_Misdirection then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					if srcName == UnitName("player") then
						RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_44,RAL.SpellIdToText(spellId, 0, 1),RAL.ToPink(RAL_TEXT_YOU),RaidAlerter_ToClassColorNameText(dstName)));
					elseif dstName == UnitName("player") then
						RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_44,RAL.SpellIdToText(spellId, 0, 1),RaidAlerter_ToClassColorNameText(srcName),RAL.ToPink(RAL_TEXT_YOU)));
					end
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_44,RAL.SpellIdToText(spellId, 1),srcName,dstName), AlertChan);
				end
			end
			return;
		end
		if spellName == RAL_TEXT_SPELL_5 or spellId == 2908 then
			if RaidAlerter_SET.Hunter_Shot then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_20,srcName,RaidAlerter_GUIDTOICONTEXT(dstGUID)..dstName,RAL.SpellIdToText(spellId, 1)), AlertChan);
				end
			end
			return;
		end
		if spellName == RAL_TEXT_SPELL_6 then
			if RaidAlerter_SET.Hunter_Mark then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_21,srcName,RaidAlerter_GUIDTOICONTEXT(dstGUID)..dstName), AlertChan);
				end
			end
			return;
		end
		if spellName == RAL_TEXT_SPELL_7 then
			if RaidAlerter_SET.Paladin_Intervention then
				TempUnit1 = RaidAlerter_GUIDToUnit(dstGUID);
				if TempUnit1 then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_22,RAL.SpellIdToText(spellId, 1),srcName,dstName), AlertWChan);
				end
			end
			return;
		end


		--new add start
		-- 54646:专注魔法 80398:黑暗意图 10060删除此技能只能给牧师自己 108968 牧师虚空转移 114039 纯净之手
		if spellName == RAL_TEXT_SPELL_97 or spellId == 47788 or spellId == 633 or spellId == 114039 or spellId == 1022 or spellId == 6940 or spellId == 1038 or spellId == 29166 or spellId == 20484 or spellId == 50720 or spellId == 49016 or spellId == 33206 or spellId == 6346 or spellId == 3411 or spellId == 54646 or spellId == 80398 or spellId == 108968 or spellId == 102342 then
			if RaidAlerter_SET.Paladin_Intervention then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					if dstName~= nil and srcName~= nil then
						RAL.SendMSG(string.format(RAL_TEXT_ALERT_60,RAL.SpellIdToText(spellId, 1),srcName,dstName), AlertChan);
					end
					if dstName~= nil and srcName~= dstName and RaidAlerter_SET.Nef_PriestDown then
						if RaidAlerter_SYNC_SELECT_TOME == 1 then
							SendChatMessage(string.format(RAL_TEXT_ALERT_60,RAL.SpellIdToText(spellId, 1),srcName_bak,"你"),"WHISPER",nil,dstName_bak);
						end
					end
				end
			end
			return;
		end

		-- 英勇和嗜血及法师猎人宠物加速,神性牺牲,
		-- 集结呐喊 97462  武僧坦技能: 115203 盾 spellId 酒 106922 乌索克之力 740宁静 108280治疗之泉 120668 风暴之X
		if spellId == 97462 or spellId == 62618 or spellId == 16190 or spellId == 32182 or spellId == 2825 or spellId == 80353 or spellId == 90355 or spellId == 70940 or spellId == 64843 or spellId == 64901 or spellId == 115203 or spellId == 115295 or spellId == 106922 or spellId == 740 or spellId == 108280 or spellId == 120668 then
			TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
			if TempUnit1 then
				if srcName~= nil then
					--仅通报坦
					if spellId == 115203 then
						if RaidAlerter_CheckTank(srcName) then
							RAL.SendMSG(string.format(RAL_TEXT_ALERT_17,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
						end
					else
						RAL.SendMSG(string.format(RAL_TEXT_ALERT_17,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
					end
				end
			end
		end

		--new add end

		if spellName == RAL_TEXT_SPELL_8 then
			if (RaidAlerter_SET.Nef_TANKPoly and GetRealZoneText() == RAL_TEXT_ZONE_1) then
				TempUnit1 = RaidAlerter_GUIDToUnit(dstGUID);
				if TempUnit1 then
						local playerClass = UnitClass(TempUnit1);
						if(playerClass==RAL_TEXT_WARRIOR or playerClass==RAL_TEXT_ROGUE) then
						RAL.SendMSG(string.format(RAL_TEXT_ALERT_23,srcName,dstName), AlertWChan);
					end
				end
			end
			return;
		end
		return;
	end

	-- new add start 复生 复活盟友 灵魂石复活
	if eventtype == "SPELL_RESURRECT" then
		if spellId == 20484 or spellId == 61999 or spellId == 95750 or spellId == 20707 then
			if dstName~= nil and srcName~= nil then
				RAL.SendMSG(string.format(RAL_TEXT_ALERT_60,RAL.SpellIdToText(spellId, 1),srcName,dstName), AlertChan);
			end
			if dstName~= nil and srcName~= dstName and RaidAlerter_SET.Nef_PriestDown then
				if RaidAlerter_SYNC_SELECT_TOME == 1 then
					SendChatMessage(string.format(RAL_TEXT_ALERT_60,RAL.SpellIdToText(spellId, 1),srcName_bak,"你"),"WHISPER",nil,dstName_bak);
				end
			end
			return;
		end
	end
	-- new add end

	--引自游云 开始
	if eventtype == "SPELL_AURA_REMOVED" then		--增加SPELL_AURA_REMOVED判定以解决4.1大部分情况下的破羊警报，SWING_DAMAGE前置问题观望中
		if (spellId == 2637 or spellName == RAL_TEXT_SPELL_9 or spellName == RAL_TEXT_BUFF_11 or spellName == RAL_TEXT_SPELL_10 or spellName == RAL_TEXT_SPELL_11 or spellName == RAL_TEXT_SPELL_12) then
			if RaidAlerter_SET.Break_Poly then
				BCC_Check_START = true;
				BCC_Check_timestamp = timestamp;
				BCC_Check_spellName = spellName;
				BCC_Check_spellId = spellId;
				BCC_Check_dstGUID = dstGUID;
			end
			return;
		end
		return;
	end
	if BCC_Check_START then
		if eventtype == "SPELL_DAMAGE" or eventtype == "SWING_DAMAGE" or eventtype == "RANGE_DAMAGE" or eventtype == "SPELL_PERIODIC_DAMAGE" then
			if dstGUID == BCC_Check_dstGUID then
				if (timestamp - BCC_Check_timestamp) > 0.1 then
					BCC_Check_START = false;
					return;
				end
				BCC_Check_START = false;
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				TempUnit2 = RaidAlerter_GUIDToUnit(dstGUID);
				if not TempUnit2 then
					local DeText = "";
					local PolymorphTactic = false;
					if (BCC_Check_spellName == RAL_TEXT_SPELL_9 or BCC_Check_spellName == RAL_TEXT_BUFF_11) then DeText = RAL_TEXT_ALERT_24; end
					if (BCC_Check_spellName == RAL_TEXT_SPELL_10) then DeText = RAL_TEXT_ALERT_25; end
					if (BCC_Check_spellName == RAL_TEXT_SPELL_11 or BCC_Check_spellId == 2637) then DeText = RAL_TEXT_ALERT_26; end
					if (BCC_Check_spellName == RAL_TEXT_SPELL_12) then DeText = RAL_TEXT_ALERT_27; end
					local bccSpell;
					if eventtype == "SWING_DAMAGE" then
						bccSpell = RAL_TEXT_SPELL_29;
					else
						bccSpell = RAL.SpellIdToText(spellId, 1);
					end
					if TempUnit1 then
						if BCC_Check_spellName == RAL_TEXT_SPELL_9 or BCC_Check_spellName == RAL_TEXT_BUFF_11 then
							if LastPolyBreakID == dstGUID then
								SameIDPolyBreakCount = SameIDPolyBreakCount + 1;
							else
								SameIDPolyBreakCount = 0;
								LastPolyBreakID = dstGUID;
							end
							if SameIDPolyBreakCount >= 3 then		--队员重复3次以上打同一只羊，若其血量已低于95%，则认为是刷羊战术，不报警
								TempUnit3 = RaidAlerter_GetTarIsGUIDUnit(dstGUID);
								if TempUnit3 then
									local P_unit = TempUnit3.."target";
									local P_health, P_healthmax = UnitHealth(P_unit), UnitHealthMax(P_unit);
									local P_healthPercent = floor(P_health/P_healthmax*100+0.5);
									if P_healthPercent < 95 then
										PolymorphTactic = true;
									end
								end
							end
						end
						if not PolymorphTactic then
							RAL.SendMSG(string.format(RAL_TEXT_ALERT_28,DeText,srcName,RaidAlerter_GetPetMaster(srcGUID),RaidAlerter_GUIDTOICONTEXT(dstGUID)..dstName,bccSpell), AlertChan, 0, 1, "BC"..dstGUID);	--刷屏限制：1秒
							RAL.SOUND(2);
						end
					elseif srcName then
						if (UnitAffectingCombat("player")==1 or UnitIsDead("player")) then
							RAL.SendMSG(string.format(RAL_TEXT_ALERT_28,DeText,srcName,RaidAlerter_GetPetMaster(srcGUID),RaidAlerter_GUIDTOICONTEXT(dstGUID)..dstName,bccSpell), AlertChan, 0, 1, "BC"..dstGUID);	--刷屏限制：1秒
							RAL.SOUND(2);
						end
					end
				end
			end
			return;
		end
		return;
	end
	--引自游云 结束

	if eventtype == "SPELL_DISPEL" or eventtype == "SPELL_AURA_DISPELLED" then
		if (spellName == RAL_TEXT_SPELL_13 or spellName == RAL_TEXT_SPELL_14 or spellName == RAL_TEXT_SPELL_15 or spellId == 4987 or spellId == 2782 or spellId == 51886 or spellId == 527 or spellId == 528 or spellId == 52025 or spellId == 475 or spellId == 32375 or spellId == 115450 or spellId == 88423) then
			if RaidAlerter_SET.Dispel_Magic then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				TempUnit2 = RaidAlerter_GUIDToUnit(dstGUID);
				-- new add 队友的也做警报, 只限buff.
				-- if (TempUnit1 and (not TempUnit2)) then
				if (TempUnit1 and otherPara2 == "BUFF") or RaidAlerter_SET.Nef_TANKPoly then
				--if TempUnit1 then
					local icon = RaidAlerter_GUIDTOICONTEXT(dstGUID);
					if srcName == UnitName("player") then
						RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_29,RAL.SpellIdToText(spellId, 1),RAL.ToPink(RAL_TEXT_YOU),icon..RAL.ToRed(dstName),RAL.ToCyan(RAL.SpellIdToText(auraType, 0, 1))));
					end
					--RAL.SendMSG(string.format(RAL_TEXT_ALERT_29,RAL.SpellIdToText(spellId, 1),srcName,icon..dstName,RAL.SpellIdToText(auraType, 1)..otherPara2), AlertChan, 0, 0.5, "DM"..srcGUID);		--防止未来版本战斗记录可能改变导致的群驱刷屏
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_29,RAL.SpellIdToText(spellId, 1),srcName,icon..dstName,RAL.SpellIdToText(auraType, 1)..otherPara2), AlertChan);
				end
			end
			return;
		end

		-- 盗和解狂暴
		if spellName == RAL_TEXT_SPELL_91 or spellName == RAL_TEXT_SPELL_92 or spellId == 2908 or spellId == 5940 or spellName == RAL_TEXT_SPELL_5 then
			if RaidAlerter_SET.Hunter_Shot then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					-- RAL.SendMSG(string.format(RAL_TEXT_ALERT_20,srcName,RaidAlerter_GUIDTOICONTEXT(dstGUID)..dstName,RAL.SpellIdToText(spellId, 1)), AlertChan);
					local icon = RaidAlerter_GUIDTOICONTEXT(dstGUID);
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_29,RAL.SpellIdToText(spellId, 1),srcName,icon..dstName,RAL.SpellIdToText(auraType, 1)..otherPara2), AlertChan);
				end
			end
			return;
		end
		return;
	end

	if eventtype == "SPELL_STOLEN" or eventtype == "SPELL_AURA_STOLEN" then
		if spellName == RAL_TEXT_SPELL_16 then
			if RaidAlerter_SET.BuffStolen then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				TempUnit2 = RaidAlerter_GUIDToUnit(dstGUID);
				if (TempUnit1 and (not TempUnit2)) then
					local icon = RaidAlerter_GUIDTOICONTEXT(dstGUID);
					if srcGUID == UnitGUID("player") then
						RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_30,RAL.ToPink(RAL_TEXT_YOU),icon..RAL.ToRed(dstName),RAL.ToCyan(RAL.SpellIdToText(auraType, 0, 1))));
					end
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_30,srcName,icon..dstName,RAL.SpellIdToText(auraType, 1)), AlertChan);
				end
			end
			return;
		end
		return;
	end

	-- new add RAL_TEXT_SPELL_81 清算之手
	if eventtype == "SPELL_MISSED" then
		if (spellName == RAL_TEXT_SPELL_17 or spellName == RAL_TEXT_SPELL_18 or spellName == RAL_TEXT_SPELL_19 or spellName == RAL_TEXT_SPELL_32
		or spellName == RAL_TEXT_SPELL_9 or spellName == RAL_TEXT_SPELL_20 or spellName == RAL_TEXT_SPELL_16 or spellName == RAL_TEXT_SPELL_13
		or spellName == RAL_TEXT_SPELL_14 or spellName == RAL_TEXT_SPELL_21 or spellName == RAL_TEXT_SPELL_5 or spellId == 62124) then
			if ((not RaidAlerter_SET.TANK_Taunt) and (spellName == RAL_TEXT_SPELL_17 or spellName == RAL_TEXT_SPELL_18
			or spellName == RAL_TEXT_SPELL_19 or spellName == RAL_TEXT_SPELL_32 or spellId == 62124)) then return; end
			if ((not RaidAlerter_SET.RES_DispelMagic) and (spellName == RAL_TEXT_SPELL_13 or spellName == RAL_TEXT_SPELL_14 or spellName == RAL_TEXT_SPELL_5)) then return; end
			if ((not RaidAlerter_SET.RES_Polymorph) and (spellName == RAL_TEXT_SPELL_9 or spellName == RAL_TEXT_SPELL_20)) then return; end
			if ((not RaidAlerter_SET.RES_MagicBreak) and (spellName == RAL_TEXT_SPELL_21)) then return; end
			if ((not RaidAlerter_SET.RES_BuffStolen) and (spellName == RAL_TEXT_SPELL_16)) then return; end
			TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
			if TempUnit1 then
				if auraType == "MISS" or auraType == "RESIST" then
					local icon = RaidAlerter_GUIDTOICONTEXT(dstGUID);
					if srcGUID == UnitGUID("player") then
						RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_31,RAL.ToPink(RAL_TEXT_YOU),RAL.ToCyan(RAL.SpellIdToText(spellId, 0, 1)),icon..RaidAlerter_ToClassColorNameText(dstName)));
					end
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_31,srcName,RAL.SpellIdToText(spellId, 1),icon..dstName), AlertChan);
				elseif auraType == "IMMUNE" then
					local icon = RaidAlerter_GUIDTOICONTEXT(dstGUID);
					if srcGUID == UnitGUID("player") then
						RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_32,icon..RaidAlerter_ToClassColorNameText(dstName),RAL.ToPink(RAL_TEXT_YOU),RAL.ToCyan(RAL.SpellIdToText(spellId, 0, 1))));
					end
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_32,icon..dstName,srcName,RAL.SpellIdToText(spellId, 1)), AlertChan);
				end
			end
			return;
		end
		if RaidAlerter_SET.TANK_ShieldReflection then
			if auraType == "REFLECT" then
				TempUnit1 = RaidAlerter_GUIDToUnit(dstGUID);
				if TempUnit1 then
					local icon = RaidAlerter_GUIDTOICONTEXT(srcGUID);
					if dstGUID == UnitGUID("player") then
						RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_33,RAL.ToPink(RAL_TEXT_YOU),RAL.ToCyan(RAL.SpellIdToText(spellId, 0, 1)),icon..RaidAlerter_ToClassColorNameText(srcName)));
					end
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_33,dstName,RAL.SpellIdToText(spellId, 1),icon..srcName), AlertChan);
					return;
				end
			end
		end
		return;
	end

	if eventtype == "SPELL_INTERRUPT" then
		if RaidAlerter_SET.Break_Magic then
			TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
			if TempUnit1 then
				local icon = RaidAlerter_GUIDTOICONTEXT(dstGUID);
				if srcGUID == UnitGUID("player") then
					RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_34,RAL.ToCyan(RAL.SpellIdToText(spellId, 0, 1)),RAL.ToPink(RAL_TEXT_YOU),icon..RaidAlerter_ToClassColorNameText(dstName),RAL.ToCyan(RAL.SpellIdToText(auraType, 0, 1))));
				end
				-- RAL.SendMSG(string.format(RAL_TEXT_ALERT_34,RAL.SpellIdToText(spellId, 1),srcName,icon..dstName,RAL.SpellIdToText(auraType, 1)), AlertChan, 0, 0.5, "BM"..srcGUID);		--防DZ刀扇刷屏
				RAL.SendMSG(string.format(RAL_TEXT_ALERT_34,RAL.SpellIdToText(spellId, 1),srcName,icon..dstName,RAL.SpellIdToText(auraType, 1)), AlertChan);		--防DZ刀扇刷屏
				return;
			end
		end
		return;
	end

	if eventtype == "PARTY_KILL" then
		if RaidAlerter_SET.BossKill then
			TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
			TempUnit2 = RaidAlerter_GUIDToUnit(dstGUID);
			if (TempUnit1 and (not TempUnit2)) then
				for k, v in pairs(RaidAlerter_Bosses) do
					if dstName == v then
						RAL.SendMSG(string.format(RAL_TEXT_ALERT_35,RaidAlerter_GUIDTOICONTEXT(dstGUID)..dstName,srcName), AlertChan);
						return;
					end
				end
			end
		end
		return;
	end

	if eventtype == "SPELL_SUMMON" then
		if RaidAlerter_SET.TANK_ShieldWall then
			-- new add 光束泉
			-- 98008灵魂链接图腾
			if spellName == RAL_TEXT_SPELL_35 or spellId == 724 or spellId == 98008 then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan);
				end
				return;
			end
		end
		-- 餐车检查
		if not RaidAlerter_RaidAllInCombat then			--只在非团队战斗状态检测
			if RaidAlerter_SET.RaidSpell then
				TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
				if TempUnit1 then
					for i, v in pairs(RAL_TEXT_RAIDSPELL_1) do
						if v["MATCH"] == 0 then
							if string.find(spellName, v["TEXT"]) then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan, 0, 10, "RAIDSPELL"..srcGUID);	--刷屏限制：10秒
								if UnitInRaid("player") then
									RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(srcName),RAL.SpellIdToText(spellId, 0, 1)));
								end
								if v["TYPE"] == "COOKFOOD" then
									RaidAlerter_StartTimer("COOKFOOD_CREAT");
									COOKFOODDUR = v["DUR"];
								end
								return;
							end
						elseif v["MATCH"] == 1 then
							if spellName == v["TEXT"] then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_39,srcName,RAL.SpellIdToText(spellId, 1)), AlertWChan, 0, 10, "RAIDSPELL"..srcGUID);	--刷屏限制：10秒
								if UnitInRaid("player") then
									RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_39,RaidAlerter_ToClassColorNameText(srcName),RAL.SpellIdToText(spellId, 0, 1)));
								end
								if v["TYPE"] == "COOKFOOD" then
									RaidAlerter_StartTimer("COOKFOOD_CREAT");
									COOKFOODDUR = v["DUR"];
								end
								return;
							end
						end
					end
				end
			end
		end
		return;
	end

--	if (eventtype == "SWING_DAMAGE"or eventtype == "RANGE_DAMAGE" or eventtype == "SPELL_DAMAGE") then
	if eventtype == "SPELL_DAMAGE" then
		if RaidAlerter_SET.TAQ_Twin_AOEAdd then
			if GetRealZoneText() == RAL_TEXT_ZONE_2 then
				if (spellName == RAL_TEXT_SPELL_22 or spellName == RAL_TEXT_SPELL_23 or spellName == RAL_TEXT_SPELL_24
				or spellName == RAL_TEXT_SPELL_25 or spellName == RAL_TEXT_SPELL_26 or spellName == RAL_TEXT_SPELL_27) then
					if (dstName == RAL_TEXT_UINTNAME_1 or dstName == RAL_TEXT_UINTNAME_2) then
						RAL.SendMSG(string.format(RAL_TEXT_ALERT_36,srcName,RAL.SpellIdToText(spellId, 1),dstName), AlertChan);
						RAL.SOUND(3);
					end
				end
			end
			return;
		end
		return;
	end

	if eventtype == "SPELL_PERIODIC_DAMAGE" then
		if RaidAlerter_SET.Nef_PriestDown then
			if GetRealZoneText() == RAL_TEXT_ZONE_1 then
				if spellName == RAL_TEXT_SPELL_28 then
					TempUnit1 = RaidAlerter_GUIDToUnit(srcGUID);
					TempUnit2 = RaidAlerter_GUIDToUnit(dstGUID);
					if (TempUnit1 and TempUnit2)then
						RaidAlerter_Alerter_ErrorCure[TempUnit1] = RaidAlerter_Alerter_ErrorCure[TempUnit1] + 1;
						RaidAlerter_Alerter_ErrorCure[TempUnit2] = RaidAlerter_Alerter_ErrorCure[TempUnit2] + auraType;
						if ( RaidAlerter_Alerter_ErrorCure[TempUnit1] > 5) then
							RaidAlerter_Alerter_ErrorCure[TempUnit1] = 0;
						elseif ( RaidAlerter_Alerter_ErrorCure[TempUnit1] == 1)then
							RAL.SendMSG(string.format(RAL_TEXT_ALERT_37,srcName,dstName,RaidAlerter_Alerter_ErrorCure[TempUnit2]), AlertChan);
						end
					end
				end
				return;
			end
		end
		return;
	end
end

--TANK血量监视
function RaidAlerter_Check_T_health()
	local i;
	for i = 1, 5 do
		if (RAL_Tanks[i]) then
			local unit = RaidAlerter_NameToUnit(RAL_Tanks[i]);
			if (unit) then
				if (UnitIsConnected(unit)) then
					if RaidAlerter_SET.TANK_Death then
						if (UnitIsDeadOrGhost(unit)) then
							if RaidAlerter_MT_Dead[unit] == nil then
								RaidAlerter_MT_Dead[unit] = 0;
							end
							if ( RaidAlerter_MT_Dead[unit] == 0) then
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_5,i.."T",RAL_Tanks[i]),"RAID_WARNING");
								RaidAlerter_MT_Dead[unit] = 1;
							end
--							return;
						else
							RaidAlerter_MT_Dead[unit] = 0;
						end
					end

					local health, healthmax, mana, manamax = UnitHealth(unit), UnitHealthMax(unit), UnitPower(unit), UnitPowerMax(unit);
					local healthPercent = floor(health/healthmax*100+0.5)

					if RaidAlerter_SET.TANK_DangerHealth then
						if (healthPercent <= RaidAlerter_SET.TANK_DangerHealthPecent) and (not UnitIsDeadOrGhost(unit)) then
							RaidAlerter_Alerter_dangerHealth[unit] = RaidAlerter_Alerter_dangerHealth[unit] + 1;
							if ( RaidAlerter_Alerter_dangerHealth[unit] > 40) then
								RaidAlerter_Alerter_dangerHealth[unit] = 0;
							elseif ( RaidAlerter_Alerter_dangerHealth[unit] == 1)then
								if RaidAlerter_GetTimer("RH"..RAL_Tanks[i])>3 then		--同一人3秒内只报一次
									RAL.SendMSG(string.format(RAL_TEXT_ALERT_4,i.."T",RAL_Tanks[i],healthPercent),"RAID_WARNING");
									RAL.SOUND(3);
									RaidAlerter_StartTimer("RH"..RAL_Tanks[i]);
								end
							end
--							return;
						else
							RaidAlerter_Alerter_dangerHealth[unit] = 0;
						end
					end

					if healthPercent > RaidAlerter_SET.TANK_DangerHealthPecent then
						RaidAlerter_Alerter_dangerHealth[unit] = 0;
					end
				end
			end
		end
	end
	return true;
end

--小队血量监视（非团队）
function RaidAlerter_Check_Party_health()
	local i;
	local unit = "";
	for i = 0, GetNumSubgroupMembers() do
		if i == 0 then
			unit = "player";
		else
			unit = "party"..i;
		end
		if UnitIsConnected(unit) then
			if (UnitIsDeadOrGhost(unit)) then
				if RaidAlerter_MT_Dead[unit] == nil then
					RaidAlerter_MT_Dead[unit] = 0;
				end
				if ( RaidAlerter_MT_Dead[unit] == 0) then
					if unit == "player" then
						if RaidAlerter_SET.TANK_Death then
							RAL.SendMSG(RAL_TEXT_ALERT_6,"PARTY",1);
						end
					end
					RaidAlerter_MT_Dead[unit] = 1;
				end
				return;
			else
				RaidAlerter_MT_Dead[unit] = 0;
			end

			local health, healthmax, mana, manamax = UnitHealth(unit), UnitHealthMax(unit), UnitPower(unit), UnitPowerMax(unit);
			local healthPercent = floor(health/healthmax*100+0.5);
			local playerClass = UnitClass(unit);

			if (healthPercent <= RaidAlerter_SET.TANK_DangerHealthPecent) and (not UnitIsDeadOrGhost(unit)) then
				RaidAlerter_Alerter_dangerHealth[unit] = RaidAlerter_Alerter_dangerHealth[unit] + 1;
				if ( RaidAlerter_Alerter_dangerHealth[unit] > 40) then
					RaidAlerter_Alerter_dangerHealth[unit] = 0;
				elseif ( RaidAlerter_Alerter_dangerHealth[unit] == 1)then
					if RaidAlerter_GetTimer("PH"..UnitName(unit))>3 then		--同一人3秒内只报一次
						if RaidAlerter_SET.TANK_DangerHealth then
							RAL.SendMSG(string.format(RAL_TEXT_ALERT_4,playerClass,UnitName(unit),healthPercent),"PARTY_RW");
							RAL.SOUND(3);
						end
						RaidAlerter_StartTimer("PH"..UnitName(unit));
					end
				end
				return;
			else
				RaidAlerter_Alerter_dangerHealth[unit] = 0;
			end

			if healthPercent > RaidAlerter_SET.TANK_DangerHealthPecent then
				RaidAlerter_Alerter_dangerHealth[unit] = 0;
			end
		end
	end
	return true;
end

--Boss血量报警（团队）
function RaidAlerter_Check_BossHealthPecent(unit)
	if RaidAlerter_SET.BossHealthPecentOnOff then
		if unit then
			local health, healthmax = UnitHealth(unit.."target"), UnitHealthMax(unit.."target");
			local healthPercent = floor(health/healthmax*100+0.5);
			if (healthPercent - RaidAlerter_Alerter_System.BossHealthPecentTMP >=2) then
				RaidAlerter_Alerter_System.BossHealthPecentTMP = healthPercent;
			end
			if (healthPercent > 0) then
				if (RaidAlerter_Alerter_System.BossHealthPecentTMP - healthPercent >= 1) then
					if (healthPercent <= RaidAlerter_SET.BossHealthPecent) then
						RAL.SendMSG("**["..healthPercent.."%]"..UnitName(unit.."target").."**", AlertChan, 0, 1.5, "BossHPP");
						RaidAlerter_Alerter_System.BossHealthPecentTMP = healthPercent;
						return;
					else
						if (floor((RaidAlerter_Alerter_System.BossHealthPecentTMP-1)/10)-floor((healthPercent-1)/10)>=1) then
							if RaidAlerter_BattleTime_Record then
								local m, s = RaidAlerter_SecondsToTime(RaidAlerter_GetTimer("BattleTime_Record"));
								if m == 0 then
									RAL.SendMSG("**["..healthPercent.."%]"..UnitName(unit.."target").." ("..string.format(RAL_TEXT_TIP_4,s)..")**", AlertChan);
								else
									RAL.SendMSG("**["..healthPercent.."%]"..UnitName(unit.."target").." ("..string.format(RAL_TEXT_TIP_5,m,s)..")**", AlertChan);
								end
							else
								RAL.SendMSG("**["..healthPercent.."%]"..UnitName(unit.."target").."**", AlertChan, 0, 1.5, "BossHPP");
							end
							RaidAlerter_Alerter_System.BossHealthPecentTMP = healthPercent;
							return;
						end
					end
				end
			end
		end
	end
end

--Boss血量报警（5人小队）
function RaidAlerter_Check_BossHealthPecent_Party(unit)
	if RaidAlerter_SET.BossHealthPecentOnOff then
		if unit then
			local health, healthmax = UnitHealth(unit.."target"), UnitHealthMax(unit.."target");
			local healthPercent = floor(health/healthmax*100+0.5);
			if (healthPercent - RaidAlerter_Alerter_System.BossHealthPecentTMP >=2) then
				RaidAlerter_Alerter_System.BossHealthPecentTMP = healthPercent;
			end
			if (healthPercent > 0) then
				if (RaidAlerter_Alerter_System.BossHealthPecentTMP - healthPercent >= 1) then
--					if (healthPercent <= RaidAlerter_SET.BossHealthPecent) then
					if (healthPercent <= 5) then		--逐一通报界限固定为5%，不受选项控制
						RAL.SendMSG("**["..healthPercent.."%]"..UnitName(unit.."target").."**", "PARTY", 0, 1.5, "BossHPP");
						RaidAlerter_Alerter_System.BossHealthPecentTMP = healthPercent;
						return;
					else
						if (floor((RaidAlerter_Alerter_System.BossHealthPecentTMP-1)/10)-floor((healthPercent-1)/10)>=2) then		--间隔通报血量报警间隔20%（RAID是10%）
							RAL.SendMSG("**["..healthPercent.."%]"..UnitName(unit.."target").."**", "PARTY", 0, 1.5, "BossHPP");
							RaidAlerter_Alerter_System.BossHealthPecentTMP = healthPercent;
							return;
						end
					end
				end
			end
		end
	end
end

--仇恨提示：自己的仇恨信息
function RaidAlerter_THREAT_UPDATE(unit)
	if RaidAlerter_SET.THREATCheck then
		if (GetNumSubgroupMembers()>0 or GetNumGroupMembers()>0) then
			if unit == "player" then
				local state = UnitThreatSituation(unit);
				if (state == nil) then state = 0;end
				local MYTARstate = 0;
				local MYTARthreatValue = 0;
				if UnitExists("target") then
					_,MYTARstate,_,_,MYTARthreatValue = UnitDetailedThreatSituation("player", "target");
					if MYTARstate == nil then MYTARstate = 0;end
					if MYTARthreatValue == nil then MYTARthreatValue = 0;end
				end
				if (state >= 2) and (MyLastThreatState < 2) then		--OT
					RAL_THREAT_Info:AddMessage(RAL_TEXT_THREAT_INFO_01, 1, 0.1, 0.1);
					if (MYTARstate >= 2) and (MYTARthreatValue > 50000) then
						if not ImTANK then
							RAL.SOUND(1);
						end
					end
					MyLastThreatState = 2;
				elseif (state == 1) and (MyLastThreatState < 1) then		--高仇恨：快OT了（>100%）
					RAL_THREAT_Info:AddMessage(RAL_TEXT_THREAT_INFO_04, 1, 0.1, 1);
					MyLastThreatState = 1;
					if (MYTARstate == 1) and (MYTARthreatValue > 50000) then
						if not ImTANK then
							RAL.SOUND(4);
						end
					end
				else		--仇恨安全
					if MyLastThreatState > 0 then
						RAL_THREAT_Info:AddMessage(RAL_TEXT_THREAT_INFO_02, 0.1, 1, 0.1);
						if ImTANK then
							RAL.SOUND(1);
						end
						MyLastThreatState = 0;
					end
				end
			end
		end
	end
end

--TOT监测
function RaidAlerter_TOT_CHECK()
	if RaidAlerter_SET.ToTCheck then
		if (GetNumSubgroupMembers()>0 or GetNumGroupMembers()>0) then
			if UnitExists("focus") and UnitExists("focustarget") then
				if (UnitIsUnit("focustarget", "player") and UnitCanAttack("player", "focus")) then
					if not FouTarISME then
						RAL_TOT_Info:AddMessage(string.format(RAL_TEXT_THREAT_INFO_05,RAL_TEXT_YOU), 0.8, 0.8, 0.8);
						if not ImTANK then
							RAL.SOUND(1);
						end
						FouTarISME = true;
					end
				else
					FouTarISME = false;
				end
			else
				FouTarISME = false;
			end
			if UnitExists("target") and UnitExists("targettarget") then
				if (UnitIsUnit("targettarget", "player") and UnitCanAttack("player", "target")) then
					if not TarTarISME then
						RAL_TOT_Info:AddMessage(string.format(RAL_TEXT_THREAT_INFO_03,RAL_TEXT_YOU), 1, 0.9, 0);
						if not ImTANK then
							RAL.SOUND(1);
						end
						TarTarISME = true;
					end
				else
					TarTarISME = false;
				end
			else
				TarTarISME = false;
			end
		end
	end
end

--OT和仇恨监测
function RaidAlerter_MemberThreatCheck(unit)
	if not unit then return;end
	if RaidAlerter_SET.OT_OnOff or RaidAlerter_SET.OTM_OnOff then
		if UnitExists(unit.."target") then
			local state = UnitThreatSituation(unit.."target", unit);
			if (state == nil) then state = 0;end
			if state >= 2 then
				if TankingPlayer ~= UnitName(unit.."target") then
					if not RaidAlerter_TestIsMtList(unit.."target") then
						RaidAlerter_OTAlert(UnitName(unit), UnitName(unit.."target"), RaidAlerter_GetUnitICONTEXT(unit));
					end
					TankingPlayer = UnitName(unit.."target");
				end
			end
		end
		if RaidAlerter_GetTimer("BossDangerThreatCheck") > 5 then
			if RaidAlerter_IsBossUnit(unit) then
				local state, threatValue;
				local DangerNames = "";
				local BossICON = RaidAlerter_GetUnitICONTEXT(unit);
				local Bossname = UnitName(unit);
				if UnitInRaid("player") then
					for i=1, GetNumGroupMembers() do
						_,state,_,_,threatValue = UnitDetailedThreatSituation("raid"..i, unit);
						if (state ~= nil) and (threatValue ~= nil) then
							if (state == 1) and (threatValue > 400000) then
								if not RaidAlerter_TestIsMtList("raid"..i) then
									DangerNames = DangerNames..UnitName("raid"..i)..".";
									if RaidAlerter_SET.OTM_OnOff then
										RaidAlerter_Whisper(UnitName("raid"..i), string.format(RAL_TEXT_ALERT_40, BossICON..Bossname));
									end
								end
							end
						end
					end
				elseif GetNumSubgroupMembers() > 0 then
					for i=0, GetNumSubgroupMembers() do
						local punit = "";
						if i == 0 then
							punit = "player";
						else
							punit = "party"..i;
						end
						_,state,_,_,threatValue = UnitDetailedThreatSituation(punit, unit);
						if (state ~= nil) and (threatValue ~= nil) then
							if (state == 1) and (threatValue > 200000) then
								if not RaidAlerter_TestIsMtList(punit) then
									DangerNames = DangerNames..UnitName(punit)..".";
									if RaidAlerter_SET.OTM_OnOff then
										RaidAlerter_Whisper(UnitName(punit), string.format(RAL_TEXT_ALERT_40, BossICON..Bossname));
									end
								end
							end
						end
					end
				end
				if DangerNames ~= "" and RaidAlerter_SET.OT_OnOff then
					RAL.SendMSG(string.format(RAL_TEXT_ALERT_41, DangerNames, BossICON..Bossname), AlertChan);
				end
			end
			RaidAlerter_StartTimer("BossDangerThreatCheck");
		end
	end
end

--OT警报
function RaidAlerter_OTAlert(Bossname, OTname, BossICON)
	if RaidAlerter_SET.OT_OnOff then
		RAL.SendMSG(string.format(RAL_TEXT_ALERT_1, BossICON..Bossname, OTname), AlertChan);		--"RAID"在PARTY时会自动置换
		if (UnitName("player") == OTname) then
			RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_1, BossICON..RAL.ToRed(Bossname), RAL.ToPink(RAL_TEXT_YOU)));
			RAL.SOUND(3);
		else
			RAL.SOUND(1);
		end
	end
	if RaidAlerter_SET.OTM_OnOff then
		if RaidAlerter_NameToUnit(OTname) then
			RaidAlerter_Whisper(OTname, string.format(RAL_TEXT_ALERT_3, BossICON..Bossname));
		end
	end
end

--玩家自身血量危急自动喊话（需在团队状态并属于正常队员）
function RaidAlerter_Check_MyHP()
	if RaidAlerter_ChkMyHP then
		if UnitAffectingCombat("player") then
			local healthPercent = floor(UnitHealth("player")/UnitHealthMax("player")*100+0.5);
			if (healthPercent < RaidAlerter_MyDangerHP) and (not UnitIsDeadOrGhost("player")) then
				local MyGroup = RaidAlerter_NameToGroup(UnitName("player"));
				if MyGroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
					if RaidAlerter_GetTimer("MyHPDanger")>6 then
						RaidAlerter.AddSCRMsg(string.format(RAL_TEXT_ALERT_4, "", RAL.ToPink(RAL_TEXT_YOU), RAL.ToRed(healthPercent)));
						SendChatMessage(string.format(RAL_TEXT_ALERT_38,healthPercent,MyGroup,UnitClass("player")),"YELL");
						RaidAlerter_StartTimer("MyHPDanger");
					end
				end
			end
		end
	end
end

--更新主坦克表
function RaidAlerter_UpdateTanks()
	RAL_Tanks = {};
	if (oRA3) then
		if oRA3.GetSortedTanks then
			RAL_Tanks = oRA3.GetSortedTanks();
			local i = 1;
			while RAL_Tanks[i] do
				local found = false;
				for k, v in pairs(RAL_BlzTanks) do
					if v == RAL_Tanks[i] then
						found = true;
						break;
					end
				end
				if not found then
					table.remove(RAL_Tanks,i);
					i = i - 1;
				end
				i = i + 1;
			end
		end
	elseif (oRA) then		--oRA2
		if oRA.maintanktable then
			for i=1, 5 do
				if (oRA.maintanktable[i]) then
					RaidAlerter_Table_Update(RAL_Tanks, oRA.maintanktable[i], "ADD");
				end
			end
		end
	elseif (CT_RA_MainTanks) then
		for i=1, 5 do
			if (CT_RA_MainTanks[i]) then
				RaidAlerter_Table_Update(RAL_Tanks, CT_RA_MainTanks[i], "ADD");
			end
		end
	end
	if #RAL_Tanks == 0 then
		RAL_Tanks = RAL_BlzTanks;
	end
end

--TANK判定
function RaidAlerter_TestIsMtList(inameunit)
	if oRA or CT_RA_MainTanks then		--oRA2和CTA下的RAL_Tanks未作判定，可能会属于替补
		if (UnitInRaid("player") or IsInInstance()) then
			if RaidAlerter_NameToGroup(UnitName(inameunit)) > RaidAlerter_SET.RAIDMODE_MAX_GROUP then
				return false;
			end
		end
	end
	if RaidAlerter_TestMtHasSet() then
		local i;
		for i = 1, 5 do
			if RAL_Tanks[i] then
				if RaidAlerter_NameToUnit(RAL_Tanks[i]) then
					if RAL_Tanks[i] == UnitName(inameunit) then
						return true;
					end
				end
			end
		end
		return false;
	else
		if UnitGroupRolesAssigned("player") == "TANK" then
			return true;
		end
		local playerClass = UnitClass(inameunit);
		if (playerClass==RAL_TEXT_WARRIOR) or (playerClass==RAL_TEXT_DEATHKNIGHT) then
			if UnitInRaid("player") or IsInInstance() then
				if UnitHealthMax(inameunit) > (RaidHPMAXAVG*1.4) then
					return true;			--高血量判定为TANK（考虑未设定TANK的情况）
				end
				return false;				--RAID中应避免DPS板甲职业OT的情况
			else
				return true;				--PARTY中DPS板甲职业也可视为TANK
			end
		elseif (playerClass==RAL_TEXT_DRUID) then		--熊德
			if UnitInRaid("player") or IsInInstance() then
				if UnitHealthMax(inameunit) > (RaidHPMAXAVG*1.4) then
					return true;			--高血量判定为TANK（考虑未设定TANK的情况）
				end
				return false;
			else
				local i = 1;
				while (UnitBuff(inameunit, i)) do
					if (string.find(UnitBuff(inameunit, i), RAL_TEXT_BUFF_3)) then
						return true;
					end
					i = i + 1;
				end
				return false;
			end
		elseif (playerClass==RAL_TEXT_PALADIN) then		--防骑
			if UnitInRaid("player") or IsInInstance() then
				if UnitHealthMax(inameunit) > (RaidHPMAXAVG*1.4) then
					return true;			--高血量判定为TANK（考虑未设定TANK的情况）
				end
				return false;
			else
				local i = 1;
				while (UnitBuff(inameunit, i)) do
					if (string.find(UnitBuff(inameunit, i), RAL_TEXT_BUFF_21)) then
						return true;		--考虑PARTY中开了正义之怒的QS客串TANK
					end
					i = i + 1;
				end
				return false;
			end
		end
	end
	return false;
end

--TANK检测
function RaidAlerter_TestMtHasSet()
	if #RAL_Tanks >= 1 then
		return #RAL_Tanks;
	else
		return false;
	end
end


-- new add 检测是否是tank,插件设定或是血量大于17W.
function RaidAlerter_CheckTank(tk,class)
	if not RaidAlerter_NameToUnit(tk) then
		return false;
	end

	if UnitGroupRolesAssigned(RaidAlerter_NameToUnit(tk)) == "TANK" then
		return true;
	end

	-- if UnitHealthMax(tk) > 170000 then
	--  	return true;
	-- end
	local i;
	for i = 1, 5 do
		if (RAL_Tanks[i]) then
			local unit = RaidAlerter_NameToUnit(RAL_Tanks[i]);
			if (unit) then
				if RAL_Tanks[i] == tk then
					return true;
				end
			end
		end
	end

	return false;
end
-- new add end

--MT战斗状态判定
--[[
function RaidAlerter_TestRaidAffectingCombat()
	if (RAL_Tanks[1]) then
		local unit = RaidAlerter_NameToUnit(RAL_Tanks[1]);
		if(UnitAffectingCombat(unit)==1) then
			return true;
		end
	end
	return false;
end
]]

--原版团队战斗判定
--[[
function RaidAlerter_TestAllRaidAffectingCombat()
	local MeZone;
	for id=1, GetNumGroupMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(id);
		if UnitName("player") == name then
			MeZone=zone;
		end
	end
	for id=1, GetNumGroupMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(id);
		if(UnitAffectingCombat("raid"..id)==1) and (MeZone==zone) then
			return true;
		end
	end
	return false;
end
]]

--团队全局战斗判定
function RaidAlerter_TestAllRaidAffectingCombat()
	local MeZone = GetRealZoneText();
	RaidAlerter_Alerter_System["ctmp"] = 0;
	for id=1, GetNumGroupMembers() do
		local name, rank, subgroup, level, class, fileName, zone, online = GetRaidRosterInfo(id);
		if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
			if(UnitAffectingCombat("raid"..id)==1) and (MeZone==zone) then
				RaidAlerter_Alerter_System["ctmp"] = RaidAlerter_Alerter_System["ctmp"] + 1;
				RaidAlerter_Alerter_System["stcntmp"] = id;
			end
		end
	end
	RaidAlerter_Alerter_System["counttmp"] = RaidAlerter_Alerter_System["counttmp"] + 1;
	if RaidAlerter_Alerter_System["counttmp"] >4 then
		RaidAlerter_Alerter_System["counttmp"]=0;
	end
	if (RaidAlerter_Alerter_System["counttmp"] ==4) and (RaidAlerter_Alerter_System["maxcn"]==1) then
--		if not RaidAlerter_Check_BloodRageUp(RaidAlerter_Alerter_System["stcntmp"]) then	--WOW2.2后血性狂暴已不再触发战斗状态，此判定废止
			RaidAlerter_Alerter_System["stcn"] = RaidAlerter_Alerter_System["stcntmp"];
			RaidAlerter_Alerter_System["stcntmp"] = 0;
--		end
	end
	if ( RaidAlerter_Alerter_System["maxcn"] < RaidAlerter_Alerter_System["ctmp"] ) then
		RaidAlerter_Alerter_System["maxcn"] = RaidAlerter_Alerter_System["ctmp"];
	end
--	ManaPercent,CureManaPercent,DeadRaidmembers,OffLineRaidmembers = RaidAlerter_Get_RaidState();
	if (RaidAlerter_Alerter_System["maxcn"] > ((RaidNum - DeadRaidmembers - OffLineRaidmembers)/4) and RaidAlerter_Alerter_System["ctmp"] > 0) then
		RaidAlerter_RaidAllInCombat = true;
		return true;
	else
		if (RaidAlerter_Alerter_System["ctmp"]==0) and ( (RaidAlerter_Alerter_System["maxcn"]>0) and (RaidAlerter_Alerter_System["maxcn"] <= ((RaidNum - DeadRaidmembers - OffLineRaidmembers)/4))) then
		RaidAlerter_Alerter_System["stcn"] = 0;
		RaidAlerter_Alerter_System["maxcn"] = 0;
		end
		RaidAlerter_RaidAllInCombat = false;
		return false;
	end
	RaidAlerter_RaidAllInCombat = false;
	return false;
end

--查找目标锁定Boss的ID
function RaidAlerter_GetIsTargetBossUnit()
	for k, v in pairs(RaidAlerter_Bosses) do
		if UnitName("playertarget") == v then
			return "player";
		else
			for i=1, GetNumGroupMembers() do
				if UnitName("raid"..i.."target") == v then
					return "raid"..i;
				end
			end
		end
	end
	return false;
end

--查找目标为指定GUID的unit
function RaidAlerter_GetTarIsGUIDUnit(GUID)
	if ((not GUID) or GUID == "NuL" or GUID == "") then
		return false;
	elseif (GUID == UnitGUID("playertarget")) then
		return "player";
	elseif (GUID == UnitGUID("party1target")) then
		return "party1";
	elseif (GUID == UnitGUID("party2target")) then
		return "party2";
	elseif (GUID == UnitGUID("party3target")) then
		return "party3";
	elseif (GUID == UnitGUID("party4target")) then
		return "party4";
	else
		RaidNumALL = GetNumGroupMembers();
		if (RaidNumALL > 0) then
			-- we are in a raid
			for i=1, RaidNumALL do
				if (GUID == UnitGUID("raid"..i.."target")) then
					return "raid"..i;
				end
			end
		end
	end
	return false;
end

--获取PET的主人名称，直接用于"打破控制"报警
function RaidAlerter_GetPetMaster(GUID)
	if ((not GUID) or GUID == "NuL" or GUID == "") then
		return "";
	elseif (GUID == UnitGUID("pet")) then
		return "("..UnitName("player")..")";
	elseif (GUID == UnitGUID("partypet1")) then
		return "("..UnitName("party1")..")";
	elseif (GUID == UnitGUID("partypet2")) then
		return "("..UnitName("party2")..")";
	elseif (GUID == UnitGUID("partypet3")) then
		return "("..UnitName("party3")..")";
	elseif (GUID == UnitGUID("partypet4")) then
		return "("..UnitName("party4")..")";
	else
		RaidNumALL = GetNumGroupMembers();
		if (RaidNumALL > 0) then
			-- we are in a raid
			for i=1, RaidNumALL do
				if (GUID == UnitGUID("raidpet"..i)) then
					return "("..UnitName("raid"..i)..")";
				end
			end
		end
	end
	return "";
end

--获取Unit的标记符号
function RaidAlerter_GetUnitICONTEXT(unit)
	ICONTEXT_icontext = "";
	if unit then
		ICONTEXT_icon = GetRaidTargetIndex(unit);
		if ICONTEXT_icon then
			ICONTEXT_icontext = RaidAlerter_RAIDICON[ICONTEXT_icon];
		end
	end
	return ICONTEXT_icontext;
end

--获取怪物GUID的标记符号
function RaidAlerter_GUIDTOICONTEXT(GUID)
	ICONTEXT_unit = RaidAlerter_GetTarIsGUIDUnit(GUID);
	if ICONTEXT_unit then
		return RaidAlerter_GetUnitICONTEXT(ICONTEXT_unit.."target");
	else
		return "";
	end
end

--查找目标锁定Boss的ID（5人小队）
function RaidAlerter_GetIsTargetBossUnit_Party()
	for k, v in pairs(RaidAlerter_Bosses) do
		if UnitName("playertarget") == v then
			return "player";
		end
	end
	for i=1, GetNumSubgroupMembers() do
		for k, v in pairs(RaidAlerter_Bosses) do
			if UnitName("party"..i.."target") == v then
				return "party"..i;
			end
		end
	end
	return false;
end

--获取当次RAID的boss名单
function RaidAlerter_Boss_Record()
	local n = 0;
--	if not RaidAlerter_RaidAllInCombat then		--考虑极远带怪时未看到boss就全副本进战斗的状况，取消此限定
		for i=1, GetNumGroupMembers() do
			if RaidAlerter_IsBossUnit("raid"..i.."target") then
				RaidAlerter_Bosses_TableUpdate(UnitName("raid"..i.."target"));
				n=n+1;
				if n>3 then		--4次中断以提高运行效率
					return;
				end
			end
		end
--	end
end

--获取当次PARTY的boss名单
function RaidAlerter_Boss_Record_Party()
	local n = 0;
	if RaidAlerter_IsBossUnit("playertarget") then
		if not RaidAlerter_Bosses_TableUpdate_EXC(UnitName("playertarget")) then		--Boss表排除某些特定小怪
			RaidAlerter_Bosses_TableUpdate(UnitName("playertarget"));
			n=n+1;
		end
	end
	for i=1, GetNumSubgroupMembers() do
		if RaidAlerter_IsBossUnit("party"..i.."target") then
			if not RaidAlerter_Bosses_TableUpdate_EXC(UnitName("party"..i.."target")) then		--Boss表排除某些特定小怪
				RaidAlerter_Bosses_TableUpdate(UnitName("party"..i.."target"));
				n=n+1;
			end
			if n>1 then		--2次中断以提高运行效率
				return;
			end
		end
	end
end

function RaidAlerter_LootMethodTEXT(TipTextMode)	--1全 2简
	if TipTextMode == 1 then
		return RaidAlerter_GetColoredText(_G["ITEM_QUALITY_COLORS"][GetLootThreshold()], RAL_LootMethod_SYS[GetLootMethod()]);
	else
		return RaidAlerter_GetColoredText(_G["ITEM_QUALITY_COLORS"][GetLootThreshold()], RAL_LootMethod[GetLootMethod()]);
	end
end

function RaidAlerter_GetColoredText(color, text)
	if (color and text) then
		return format("|cFF%s%s|r",format("%02X%02X%02X",color.r*255,color.g*255,color.b*255),text);
	else
		return "";
	end
end

function RaidAlerter_GetCurrentDifficulty(TipTextMode)		--副本难度返回值：1=普通  2=英雄
	SysDif = 1;	--小队：1=普通 2=英雄		团队：1=10人  2=25人  3=10人(英雄)  4=25人(英雄)
	EQDif = 1;	--副本难度：1=普通  2=英雄
	DifText = "";
	_, instanceType, difficulty, _, maxPlayers, playerDifficulty, isDynamicInstance = GetInstanceInfo();
	if instanceType == "raid" then				--在副本时直接读取副本参数
		SysDif = difficulty;
		if difficulty > 2 then EQDif = 2;end
	elseif instanceType == "party" then			--在副本时直接读取副本参数
		SysDif = difficulty;
		EQDif = SysDif;
	else										--不在副本时读取团队设定值
		if UnitInRaid("player") or IsInInstance() then
			-- SysDif = GetRaidDifficultyID();
			-- if SysDif > 2 then EQDif = 2;end
		elseif GetNumSubgroupMembers() > 0 then
			-- SysDif = GetDungeonDifficultyID();
			EQDif = SysDif;
		end
	end

	if isDynamicInstance then			--可动态调整难度的副本
		if playerDifficulty == 1 then
			EQDif = 2;
		end
	end

	if TipTextMode then
		--字串处理
		if instanceType == "party" or instanceType == "raid" then			--在副本时
			if EQDif == 1 then
				DifText = string.format(RAL_TEXT_TIP_36, RAL.ToWhite(maxPlayers), RAL.ToGreen(RAL_TEXT_TIP_33));
			else
				DifText = string.format(RAL_TEXT_TIP_36, RAL.ToWhite(maxPlayers), RAL.ToRed(RAL_TEXT_TIP_34));
			end
		else		--不在副本
			if UnitInRaid("player") or IsInInstance() then
				if SysDif == 1 then DifText = RAL.ToWhite(RAL_TEXT_TIP_31)..RAL.ToGreen(RAL_TEXT_TIP_33) end;
				if SysDif == 2 then DifText = RAL.ToWhite(RAL_TEXT_TIP_32)..RAL.ToGreen(RAL_TEXT_TIP_33) end;
				if SysDif == 3 then DifText = RAL.ToWhite(RAL_TEXT_TIP_31)..RAL.ToRed(RAL_TEXT_TIP_34) end;
				if SysDif == 4 then DifText = RAL.ToWhite(RAL_TEXT_TIP_32)..RAL.ToRed(RAL_TEXT_TIP_34) end;
			elseif GetNumSubgroupMembers() > 0 then
				DifText = RAL.ToWhite(RAL_TEXT_TIP_30);
				if SysDif == 1 then
					DifText = DifText..RAL.ToGreen(RAL_TEXT_TIP_33);
				else
					DifText = DifText..RAL.ToRed(RAL_TEXT_TIP_34);
				end
			end
		end
		if TipTextMode == 1 then			--1完整彩色文本如：25人英雄
			return DifText;
		elseif TipTextMode == 2 then		--2仅难度如：英雄
			if EQDif == 1 then
				return RAL.ToGreen(RAL_TEXT_TIP_33);
			elseif EQDif == 2 then
				return RAL.ToRed(RAL_TEXT_TIP_34);
			else
				return "";
			end
		elseif TipTextMode == 3 then		--3(用于tip显示)完整彩色文本并显示动态如：25人英雄(动态)
			if isDynamicInstance then
				return DifText.."("..RAL.ToYellow(RAL_TEXT_TIP_37)..")";
			else
				return DifText;
			end
		end
	else
		return EQDif;
	end
end

function RaidAlerter_IsBossUnit(unit)
	if UnitExists(unit) then
		if (UnitClassification(unit) == "worldboss") then
			return true;
		end
		BossHPMin = 999999999;
		if UnitInRaid("player") or IsInInstance() then
			if (RaidNum - OffLineRaidmembers) > 14 then
				BossHPMin = RaidHPMAXAVG*200;		--25RAID
			else
				BossHPMin = RaidHPMAXAVG*80;		--10RAID
			end
		elseif GetNumSubgroupMembers() > 0 then
			TeamLevel = UnitLevel("player");
			PartyHPMAXAVG = UnitHealthMax("player");
			for i=1, GetNumSubgroupMembers() do
				TeamLevel = TeamLevel + UnitLevel("party"..i);
				PartyHPMAXAVG = PartyHPMAXAVG + UnitHealthMax("party"..i);
			end
			TeamLevel = TeamLevel/(GetNumSubgroupMembers()+1);
			PartyHPMAXAVG = PartyHPMAXAVG/(GetNumSubgroupMembers()+1);
			BossHPMin = PartyHPMAXAVG*15;			--PARTY
		end
		if EQDif >= 2 then
			BossHPMin = BossHPMin*1.35;
		end
		if (UnitHealth(unit) > BossHPMin) then
			return true;
		end
		return false;
	end
	return false;
end

function RaidAlerter_IsDangerUnit(unit)
	if UnitExists(unit) then
		if (not UnitIsDead(unit)) and UnitCanAttack("player", unit) then
			if (UnitClassification(unit) == "worldboss") then
				return true;
			end
			DangerUnitHPMin = 666666666;
			if UnitInRaid("player") or IsInInstance() then
				if (RaidNum - OffLineRaidmembers) > 14 then
					DangerUnitHPMin = RaidHPMAXAVG*20;		--25RAID
				else
					DangerUnitHPMin = RaidHPMAXAVG*8;		--10RAID
				end
			elseif GetNumSubgroupMembers() > 0 then
				DangerUnitHPMin = PartyHPMAXAVG*3;			--PARTY
			end
			if EQDif >= 2 then
				DangerUnitHPMin = DangerUnitHPMin*1.35;
			end
			if (UnitLevel(unit)-TeamLevel) >= 3 then
				DangerUnitHPMin = DangerUnitHPMin*0.75;
			elseif (UnitLevel(unit)-TeamLevel) >= 2 then
				DangerUnitHPMin = DangerUnitHPMin*0.85;
			end
			if (UnitClassification(unit) == "normal") then
				DangerUnitHPMin = DangerUnitHPMin*3;
			end
			if (UnitHealthMax(unit) > DangerUnitHPMin) then
				return true;
			end
			return false;
		end
	end
	return false;
end

--查找危险怪物的ID
function RaidAlerter_GetDangerUnit()
	if RaidAlerter_IsDangerUnit("playertarget") then
		return "playertarget";
	elseif UnitInRaid("player") or IsInInstance() then
		for i=1, GetNumGroupMembers() do
			if RaidAlerter_IsDangerUnit("raid"..i.."target") then
				return "raid"..i.."target";
			end
		end
	elseif GetNumSubgroupMembers() > 0 then
		for i=1, GetNumSubgroupMembers() do
			if RaidAlerter_IsDangerUnit("party"..i.."target") then
				return "party"..i.."target";
			end
		end
	end
	return false;
end

--无重复数据的表单数据更新
function RaidAlerter_Table_Update(TableName, Data, ACT)
	ACT = string.upper(ACT);
	if ACT == "ADD" then
		local samed = 0;
		for k, v in pairs(TableName) do
			if v == Data then
				samed = 1;
				return;
			end
		end
		if samed == 0 then
			table.insert(TableName,Data);
		end
	elseif ACT == "DEL" then
		for k, v in pairs(TableName) do
			if v == Data then
				table.remove(TableName,k);
				return;
			end
		end
	else
		return false;
	end
end

--更新Boss表
function RaidAlerter_Bosses_TableUpdate(bname)
	local bnsamed = 0;
	for k, v in pairs(RaidAlerter_Bosses) do
		if v == bname then
			bnsamed = 1;
			return;
		end
	end
	if bnsamed == 0 then
		table.insert(RaidAlerter_Bosses,bname);
	end
end

--Boss表排除特例
function RaidAlerter_Bosses_TableUpdate_EXC(bname)
	for k, v in pairs(RaidAlerter_Bosses_EXC) do
		if v == bname then
			return true;
		end
	end
	return false;
end

--灵魂石检测
function RaidAlerter_Check_SoulGemOn()
	GemName = {};
	for id=1, GetNumGroupMembers() do
		_, _, subgroup = GetRaidRosterInfo(id);
		if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
			local i = 1;
			while (UnitBuff("raid"..id, i)) do
				if (string.find(UnitBuff("raid"..id, i), RAL_TEXT_BUFF_1)) then
					RaidAlerter_Table_Update(GemName, UnitName("raid"..id), "ADD");
				end
			i = i + 1;
			end
		end
	end
end

--获取已保存灵魂石的玩家列表字串
function RaidAlerter_GetGemOnNames(SetClassColor)
	if #GemName == 0 then return "";end
	local GemMSG = "";
	for id=1, #GemName do
		if SetClassColor == 1 then
			GemMSG = GemMSG..RaidAlerter_ToClassColorNameText(GemName[id])..".";
		else
			GemMSG = GemMSG..GemName[id]..".";
		end
	end
	return GemMSG;
end

--变形检测
function RaidAlerter_Check_P_BeControled_ButIsPolyUp(unit)
	local i = 1;
	while (UnitDebuff(unit, i)) do
		if (string.find(UnitDebuff(unit, i), RAL_TEXT_BUFF_10) or string.find(UnitDebuff(unit, i), RAL_TEXT_BUFF_11)) then
			return true;
		end
		i = i + 1;
	end
	return false;
end

--判断是否自己被控制（团队）
function RaidAlerter_TestEnemyIsMe()
	local Enemy_control_Count = 0;
	for id=1, GetNumGroupMembers() do
		if (UnitIsFriend("player", "raid"..id) and UnitIsEnemy("player", "raid"..id)) then
			Enemy_control_Count = Enemy_control_Count + 1;
		end
	end
	if (Enemy_control_Count > RaidNum/2 ) then
		return true;
	else
		return false;
	end
end

--判断是否自己被控制（5人小队）
function RaidAlerter_TestEnemyIsMe_Party()
	local Enemy_control_Count = 0;
	for id=1, GetNumSubgroupMembers() do
		if (UnitIsFriend("player", "party"..id) and UnitIsEnemy("player", "party"..id)) then
			Enemy_control_Count = Enemy_control_Count + 1;
		end
	end
	if (Enemy_control_Count > GetNumSubgroupMembers()/2 ) then
		return true;
	else
		return false;
	end
end

--控制警报（团队）
function RaidAlerter_Check_P_BeControled()
	local BC_count = 0;
	local DEP_count = 0;
	for id=1, GetNumGroupMembers() do
		if (BC_count >= 3) or (DEP_count >= 3) then return; end			--一次最多只报3人，防刷屏
		local unit = "raid"..id;
		if (unit) then
			if (UnitIsFriend("player", "raid"..id) and UnitIsEnemy("player", "raid"..id)) then
				if RaidAlerter_Check_P_BeControled_ButIsPolyUp("raid"..id) then
					RaidAlerter_Alerter_BeControled[unit] = 0;
				else
					RaidAlerter_Alerter_BeControled[unit] = RaidAlerter_Alerter_BeControled[unit] + 1;
				end
				if ( RaidAlerter_Alerter_BeControled[unit] > 40) then
					RaidAlerter_Alerter_BeControled[unit] = 0;
				elseif ( RaidAlerter_Alerter_BeControled[unit] == 1)then
					if RaidAlerter_SET.Check_Poly then
						if RaidAlerter_TestEnemyIsMe() then
							if RaidAlerter_GetTimer("BC"..UnitName("player"))>5 then		--同一人5秒内只报一次
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_7,UnitName("player")),"RAID_WARNING");
								RaidAlerter_StartTimer("BC"..UnitName("player"));
								SetRaidTargetIcon("player", 8);
								RaidAlerter_Alerter_System["lasticon"] = UnitName("player");
								if BC_count == 0 then
									RAL.SOUND(5);
								end
								BC_count = BC_count + 1;
							end
						else
							if RaidAlerter_GetTimer("BC"..UnitName("raid"..id))>5 then		--同一人5秒内只报一次
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_7,UnitName("raid"..id)),"RAID_WARNING");
								RaidAlerter_StartTimer("BC"..UnitName("raid"..id));
								SetRaidTargetIcon("raid"..id, 8);
								RaidAlerter_Alerter_System["lasticon"] = UnitName("raid"..id);
								if BC_count == 0 then
									RAL.SOUND(5);
								end
								BC_count = BC_count + 1;
							end
						end
					end
				end
--				return;
			else
				if ( RaidAlerter_Check_P_BeControled_ButIsPolyUp("raid"..id) and RaidAlerter_TestIsMtList(unit) and UnitIsFriend("player", "raid"..id) ) then
					RaidAlerter_Alerter_BeControled[unit] = RaidAlerter_Alerter_BeControled[unit] + 1000;
					if ( RaidAlerter_Alerter_BeControled[unit] > 40000) then
						RaidAlerter_Alerter_BeControled[unit] = 0;
					elseif ( RaidAlerter_Alerter_BeControled[unit] == 1000)then
						if RaidAlerter_SET.PolyDispel then
							if RaidAlerter_GetTimer("DEP"..UnitName("raid"..id))>5 then		--同一人5秒内只报一次
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_8,UnitName("raid"..id)),AlertChan);
								SetRaidTargetIcon("raid"..id, 8);
								RaidAlerter_Alerter_System["lasticon"] = UnitName("raid"..id);
								RaidAlerter_StartTimer("DEP"..UnitName("raid"..id));
								DEP_count = DEP_count + 1;
							end
						end
					end
				else
					RaidAlerter_Alerter_BeControled[unit] = 0;
				end
			end
		end
	end
	return true;
end

--控制警报（5人小队）
function RaidAlerter_Check_P_BeControled_Party()
	local unit = "";
	local BC_count = 0;
	local DEP_count = 0;
	for id=0, GetNumSubgroupMembers() do
		if (BC_count >= 3) or (DEP_count >= 3) then return; end			--一次最多只报3人，防刷屏
		if id==0 then unit="player" else unit="party"..id end
		if (unit) then
			if (UnitIsFriend("player", unit) and UnitIsEnemy("player", unit)) then
				if RaidAlerter_Check_P_BeControled_ButIsPolyUp(unit) then
					RaidAlerter_Alerter_BeControled[unit] = 0;
				else
					RaidAlerter_Alerter_BeControled[unit] = RaidAlerter_Alerter_BeControled[unit] + 1;
				end
				if ( RaidAlerter_Alerter_BeControled[unit] > 40) then
					RaidAlerter_Alerter_BeControled[unit] = 0;
				elseif ( RaidAlerter_Alerter_BeControled[unit] == 1)then
					if RaidAlerter_SET.Check_Poly then
						if RaidAlerter_TestEnemyIsMe_Party() then
							if RaidAlerter_GetTimer("BC"..UnitName("player"))>5 then		--同一人5秒内只报一次
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_7,UnitName("player")),"PARTY_RW");
								RaidAlerter_StartTimer("BC"..UnitName("player"));
								if BC_count == 0 then
									RAL.SOUND(5);
								end
								BC_count = BC_count + 1;
							end
						else
							if RaidAlerter_GetTimer("BC"..UnitName(unit))>5 then		--同一人5秒内只报一次
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_7,UnitName(unit)),"PARTY_RW");
								RaidAlerter_StartTimer("BC"..UnitName(unit));
								if BC_count == 0 then
									RAL.SOUND(5);
								end
								BC_count = BC_count + 1;
							end
						end
					end
				end
--				return;
			else
				if ( RaidAlerter_Check_P_BeControled_ButIsPolyUp(unit) and RaidAlerter_TestIsMtList(unit) and UnitIsFriend("player", unit) ) then
					RaidAlerter_Alerter_BeControled[unit] = RaidAlerter_Alerter_BeControled[unit] + 1000;
					if ( RaidAlerter_Alerter_BeControled[unit] > 40000) then
						RaidAlerter_Alerter_BeControled[unit] = 0;
					elseif ( RaidAlerter_Alerter_BeControled[unit] == 1000)then
						if RaidAlerter_SET.PolyDispel then
							if RaidAlerter_GetTimer("DEP"..UnitName(unit))>5 then		--同一人5秒内只报一次
								RAL.SendMSG(string.format(RAL_TEXT_ALERT_8,UnitName(unit)),"PARTY");
--								SetRaidTargetIcon(unit, 8);
--								RaidAlerter_Alerter_System["lasticon"] = UnitName(unit);
								RaidAlerter_StartTimer("DEP"..UnitName(unit));
								DEP_count = DEP_count + 1;
							end
						end
					end
				else
					RaidAlerter_Alerter_BeControled[unit] = 0;
				end
			end
		end
	end
	return true;
end

--玩家名称转换为ID
function RaidAlerter_NameToUnit(Name)
	if (not Name) then
		return false;
	end
	Name = Name:match("(.+)%-(.+)") or Name;
	if (Name == UnitName("player")) then
		return "player";
	elseif (Name == UnitName("party1")) then
		return "party1";
	elseif (Name == UnitName("party2")) then
		return "party2";
	elseif (Name == UnitName("party3")) then
		return "party3";
	elseif (Name == UnitName("party4")) then
		return "party4";
	else
		RaidNumALL = GetNumGroupMembers();
		if (RaidNumALL > 0) then
			-- we are in a raid
			for i=1, RaidNumALL do
				if Name == GetRaidRosterInfo(i) then
					return "raid"..i;
				end
			end
		end
	end
	return false;
end

--玩家GUID转换为ID
function RaidAlerter_GUIDToUnit(GUID)
	if (not GUID) then
		return false;
	elseif (GUID == UnitGUID("player")) then
		return "player";
	elseif (GUID == UnitGUID("party1")) then
		return "party1";
	elseif (GUID == UnitGUID("party2")) then
		return "party2";
	elseif (GUID == UnitGUID("party3")) then
		return "party3";
	elseif (GUID == UnitGUID("party4")) then
		return "party4";
	else
		RaidNumALL = GetNumGroupMembers();
		if (RaidNumALL > 0) then
			-- we are in a raid
			for i=1, RaidNumALL do
				if GUID == UnitGUID("raid"..i) then
					return "raid"..i;
				end
			end
		end
	end
	return false;
end

--查找玩家的小队号（团队）
function RaidAlerter_NameToGroup(CheckName)
	for i=1, GetNumGroupMembers() do
		local name, _, subgroup = GetRaidRosterInfo(i);
		if ( name == CheckName) then
			return subgroup;
		end
	end
	return 9999;
end

--团队参数更新：DPS和治疗法力、死亡、离线、有效人数，平均等级
function RaidAlerter_Get_RaidState()
	DeadRaidmembers = 0;
	OffLineRaidmembers = 0;
	RaidNum = 0;
	local totalmana = 0;
	local totalmanamax = 0;
	local totalcuremana = 0;
	local totalcuremanamax = 0;
	local playerClass;
	local level;
	local totallevel = 0;
	local totalhpmax = 0;
	local role = "";
	RAL_BlzTanks = {};

	for id=1, GetNumGroupMembers() do
		_, _, subgroup, level, playerClass, _, _, _, _, role = GetRaidRosterInfo(id);
		if subgroup <= RaidAlerter_SET.RAIDMODE_MAX_GROUP then
			local unit = "raid"..id;
			if UnitGroupRolesAssigned(unit) == "TANK" or role == "MAINTANK" then
				RaidAlerter_Table_Update(RAL_BlzTanks, UnitName(unit), "ADD");
			end
			if (UnitIsConnected(unit)) then
				if (UnitIsDeadOrGhost(unit)) then
					DeadRaidmembers = DeadRaidmembers + 1;
				else
					if (UnitPowerType(unit) == 0) then
						if (playerClass==RAL_TEXT_PRIEST) or (playerClass==RAL_TEXT_SHAMAN) or
						(playerClass==RAL_TEXT_DRUID) or (playerClass==RAL_TEXT_PALADIN)then
							totalcuremana = totalcuremana + UnitPower(unit);
							totalcuremanamax = totalcuremanamax + UnitPowerMax(unit);
						else
							totalmana = totalmana + UnitPower(unit);
							totalmanamax = totalmanamax + UnitPowerMax(unit);
						end
					end
				end
				totalhpmax = totalhpmax + UnitHealthMax(unit);
			else
				OffLineRaidmembers = OffLineRaidmembers + 1;
			end
			totallevel = totallevel + level;
			RaidNum = RaidNum + 1;
		end
	end
	if totalcuremana ~= 0 then
		CureManaPercent = floor(totalcuremana/totalcuremanamax*100+0.5);
	else
		CureManaPercent = 0;
	end
	if totalmana ~=0 then
		ManaPercent = floor(totalmana/totalmanamax*100+0.5);
	else
		ManaPercent = 0;
	end
	TeamLevel = totallevel/RaidNum;
	if RaidNum > OffLineRaidmembers then
		RaidHPMAXAVG = totalhpmax/(RaidNum-OffLineRaidmembers);
	end
--	return ManaPercent,CureManaPercent,DeadRaidmembers,OffLineRaidmembers,RaidNum,TeamLevel;
end

function RaidAlerter_Whisper(playerName, Message)
	if (RaidAlerter_SYNC_SELECT_TOME==1) and (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
		return SendChatMessage("<RaidAlerter> "..Message, "WHISPER", nil, playerName);
	end
end

local RaidAlerterTimerDatas = {
		{
		["Name"] = "RaidAlerter_Update",
		["Time"] = 0,
		},
};

function RaidAlerter_StartTimer(id)
	for k, v in pairs(RaidAlerterTimerDatas) do
		if(id == v["Name"]) then
			v["Time"] = GetTime();
			return;
		end
	end
	table.insert(RaidAlerterTimerDatas,
		{
		["Name"] = id,
		["Time"] = GetTime(),
		});
end

function RaidAlerter_GetTimer(id)
	for k, v in pairs(RaidAlerterTimerDatas) do
		if(id == v["Name"]) then
			Timer_NOW = GetTime();
			Timer_START = v["Time"];
			return (Timer_NOW - Timer_START), Timer_START, Timer_NOW;
		end
	end
	return 9999;
end

function RaidAlerter_ClearTimerDatas()
	for id = #RaidAlerterTimerDatas, 1, -1 do
		if RaidAlerterTimerDatas[id] then
			if (RaidAlerterTimerDatas[id]["Name"] ~= "RaidAlerter_Update" and RaidAlerterTimerDatas[id]["Name"] ~= "RaidAlerter_Check_RAM_CPU" and RaidAlerterTimerDatas[id]["Name"] ~= "BattleTime_Record") then
				if (GetTime() - RaidAlerterTimerDatas[id]["Time"]) > 360 then	--清除过期时间记录以提高效率
					table.remove(RaidAlerterTimerDatas,id);
				end
			end
		end
	end
end

function RaidAlerter_SecondsToTime(seconds, returntype)
	local m, s;
	if not tonumber(seconds) then
		return 0, 0;
	else
		seconds = tonumber(seconds);
		seconds = floor(seconds);
	end
	m = floor(seconds/60);
	s = seconds - (m*60);
	if s == 60 then
		s = 0;
		m = m + 1;
	end
	return m, s;
end

function RaidAlerter_Inspect(self, check)
	local unit = "player";
 	if UnitExists("mouseover") then unit="mouseover";end
 	if UnitExists("target") then
		if (not UnitIsPlayer("target")) and (UnitExists("mouseover") and UnitIsPlayer("mouseover"))then
			unit="mouseover";
		else
			unit="target";
		end
	end
	if InspectFrame then
		if InspectFrame:IsVisible() and unit=="player" then
			HideUIPanel(InspectFrame);
			return;
		end
	end
	if SuperInspectFrame then
		if(SuperInspectFrame:IsVisible()) and unit=="player" then
			HideUIPanel(SuperInspectFrame);
			return;
		end
	end
	InspectUnit(unit);
end

function RaidAlerter.AddMsg(msg, NoPrefix)
	if DEFAULT_CHAT_FRAME then
		if not NoPrefix then
			DEFAULT_CHAT_FRAME:AddMessage("|cFFFF7711<|r|cFFFFFF99"..RaidAlerter_UINameEN.."|r|cFFFF7711>|r"..tostring(msg).."|r", 1, 1, 0.8);
		elseif NoPrefix == 1 then
			DEFAULT_CHAT_FRAME:AddMessage(tostring(msg), 1, 1, 0.8);
		end
	end
end

function RaidAlerter.AddErrorMsg(msg)
	if UIErrorsFrame then
		UIErrorsFrame:AddMessage(tostring(msg), 1, 1, 0.8);
	end
end

function RaidAlerter.AddSCRMsg(msg, iconsize, WithChatFrameMSG)
	if RaidAlerter_SET.ScrMsg then
		if not iconsize then iconsize = 0;end
		for index,value in pairs(RaidAlerter_RAIDICON) do
			msg = string.gsub(msg,value,"|T".."Interface\\TargetingFrame\\UI-RaidTargetingIcon_"..index..":"..iconsize.."|t");
		end
		msg = string.gsub(msg,RAL_TEXT_ARROW_L,RAL.ToOrange(RAL_TEXT_ARROW_L));
		msg = string.gsub(msg,RAL_TEXT_ARROW_R,RAL.ToOrange(RAL_TEXT_ARROW_R));
		msg = string.gsub(msg,"%*%*",RAL.ToGreen("**"));
		RAL_SCRInfo:AddMessage(tostring(msg), 1.0, 1.0, 0.7);
		if WithChatFrameMSG then
			RaidAlerter.AddMsg(msg);
		end
	end
end

function RaidAlerter_SetAddonMessage(ARG_1,msg)
	if not ARG_1 then return; end
	if not msg then return; end
	if (ARG_1=="RAL_SELECTREPLY") and ((not RaidAlerter_SET.OnOff) or RaidAlerter_SET.OnlySelfCHAN or RaidAlerter_SET.OnlySelfSCR) then
		return;
	end

	if ARG_1=="RAL_SELECT" or ARG_1=="RAL_SELECTREPLY" then
		if RaidAlerter_GetTimer("SYNCSELECT")>4 then		--4秒前的传递参数视为过期，重置
			RaidAlerter_SYNC_SELECT_TMPPRA = 0;
			RaidAlerter_SYNC_SELECT_NAME = "|cFFFF0000"..RAL_TEXT_SYNC_SELECT_NONE.."|r";
			RaidAlerter_StartTimer("SYNCSELECT");
		end
	end

	local SendAddonMSG = false;
	local SendAddonMSGCHAN = "";

	if ARG_1=="RAL_CHECKVER" or ARG_1=="RAL_CHECKVERREPLY" then SendAddonMSG = true;end

	if (UnitInRaid("player")) then
		if ARG_1=="RAL_SELECT" or ARG_1=="RAL_CHECKVER" or ARG_1=="RAL_CHECKVERREPLY" then
			SendAddonMSG = true;
			SendAddonMSGCHAN = AlertChan;
		end
		if (UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) then
			SendAddonMSG = true;
			SendAddonMSGCHAN = AlertChan;
		end
	elseif GetNumGroupMembers()>0 then
		if (ARG_1=="RAL_SELECTREPLY") and (not RaidAlerter_SET.Party_Alerter) then
			return;
		end
		SendAddonMSG = true;
		SendAddonMSGCHAN = AlertChan;
	end

	if SendAddonMSG and SendAddonMSGCHAN~="" then
--		SendAddonMessage(ARG_1,msg,SendAddonMSGCHAN);
		RAL_UIMSG_PREFIX = ARG_1;
		RAL_UIMSG_MSG = msg;
		RAL_UIMSG_CHAN = SendAddonMSGCHAN;
		RAL_UIMSG_SENDED = false;
	end
end

function RaidAlerter_SendAddonMessage()
	if not RAL_UIMSG_SENDED then
		if RaidAlerter_GetTimer("RAL_UIMSG_TIME") >= RAL_UIMSG_TIMELIMIT then		--4.0后SendAddonMessage()使用频率限制?
			C_ChatInfo.SendAddonMessage(RAL_UIMSG_PREFIX,RAL_UIMSG_MSG,RAL_UIMSG_CHAN);
			RAL_UIMSG_SENDED = true;
			RaidAlerter_StartTimer("RAL_UIMSG_TIME");
		end
	end
end

function RAL.SendMSG(msg, chan, ForceSend, CheckTime, MsgID)
	if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) and IsInInstance() then
		AlertChan = "INSTANCE_CHAT";
		AlertWChan = "INSTANCE_CHAT";
	else
		if IsInRaid() then
			AlertChan = "RAID";
			AlertWChan = "RAID_WARNING";
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			AlertChan = "PARTY";
			AlertWChan = "PARTY";
		else
			return; --屏蔽此行则允许单人状态发送消息
		end
	end
	local inautoparty = false;
	if IsInInstance() then
		_, instanceType = GetInstanceInfo();
		if instanceType == "party" then
			inautoparty = true;
		end
	end
	if not msg then return; end
	if not chan then chan="MYCHAN"; end

	if CheckTime and MsgID then
		if RaidAlerter_GetTimer("MSG"..MsgID) < CheckTime then
			return;
		else
			RaidAlerter_StartTimer("MSG"..MsgID);
		end
	end

	chan = string.upper(chan);
	if chan == "S" then chan = "SAY" end
	if chan == "Y" then chan = "YELL" end
	if chan == "RA" then chan = "RAID" end
	if chan == "RW" then chan = "RAID_WARNING" end

	if RaidAlerter_SET.OnlySelfCHAN then chan = "MYCHAN" end
	if RaidAlerter_SET.OnlySelfSCR then chan = "MYSCR" end
	if (RaidAlerter_SET.OnlySelfCHAN and RaidAlerter_SET.OnlySelfSCR) then chan = "MYCHANandSCR" end

	if not(chan=="MYCHAN" or chan=="INSTANCE_CHAT" or chan=="MYSCR" or chan=="MYCHANandSCR" or chan=="SAY" or chan=="YELL" or chan=="PARTY" or chan=="PARTY_RW" or chan=="RAID" or chan=="RAID_WARNING" or chan=="BATTLEGROUND") then
		return;
	end
	if not UnitInRaid("player") then
		-- if (chan=="RAID") then chan = "PARTY";end
		-- if (chan=="RAID_WARNING") then chan = "PARTY_RW";end
	end

	if chan =="PARTY" or (inautoparty == true and chan=="INSTANCE_CHAT") then
		if (RaidAlerter_SYNC_SELECT_TOME==1) or (ForceSend == 1) then
			SendChatMessage(msg,chan);
		end
		RaidAlerter.AddSCRMsg(msg);
		return;
	end
	if chan =="PARTY_RW" then
		if RaidAlerter_SYNC_SELECT_TOME==1 then
			SendChatMessage(msg,"PARTY");
			RaidAlerter.AddSCRMsg(msg);
		else
			RaidAlerter.AddSCRMsg(msg);
		end
		return;
	end
	if (chan=="RAID" or chan=="RAID_WARNING" or (chan=="INSTANCE_CHAT" and inautoparty == false)) then
		if not (select(2, IsInInstance()) == "pvp") then -- 战场禁用
			if ((UnitIsGroupLeader("player") or UnitIsGroupAssistant("player")) and (RaidAlerter_SYNC_SELECT_TOME==1)) or ((chan=="RAID" or chan=="INSTANCE_CHAT") and ForceSend == 1) then
				if (chan=="RAID_WARNING") then
					chan = "RAID";
				end
				SendChatMessage(msg,chan);
				return;
			elseif RaidAlerter_SYNC_SELECT_NAME == "|cFFFF0000"..RAL_TEXT_SYNC_SELECT_NONE.."|r" then
				if chan=="RAID_WARNING" then
					RaidAlerter.AddSCRMsg(msg);
				end
				if chan=="INSTANCE_CHAT" and RaidAlerter_SYNC_SELECT_TOME==1 then
					SendChatMessage(msg,chan);
				else
					RaidAlerter.AddMsg(msg);
				end
				return;
			end
		end
	end
	if chan =="MYCHAN" then
		RaidAlerter.AddMsg(msg);
		return;
	end
	if chan =="MYSCR" then
		RaidAlerter.AddSCRMsg(msg);
		return;
	end
	if chan =="MYCHANandSCR" then
		RaidAlerter.AddMsg(msg);
		RaidAlerter.AddSCRMsg(msg);
		return;
	end
	if (chan=="SAY" or chan=="YELL" or chan=="BATTLEGROUND") then
		SendChatMessage(msg,chan);
		return;
	end
end

function RAL.SOUND(i)
	if RaidAlerter_SET.SoundAlert then
		PlaySoundFile(RaidAlerter_SOUND_DATA[i]);
	end
end

function RAL.SpellIdToText(id, ToHlink, AddIcon)
	local name, _, icon = GetSpellInfo(id);
	local text = "";
	if name then
		text = name;
		if ToHlink == 1 then
			-- text = "|cff71d5ff|Hspell:"..id.."|h["..text.."]|h|r";
			text = GetSpellLink(id)
		end
		if AddIcon == 1 then
			text = "|T"..icon..":0|t"..text;
		end
	end
	return text;
end

function RAL.SpellToLink(id, name)
	if id and name then
		return "|cff71d5ff|Hspell:"..id.."|h["..name.."]|h|r";
	elseif id then
		return "|cff71d5ff|Hspell:"..id.."|h["..select(1,GetSpellInfo(id)).."]|h|r";
	elseif name then
		return name;
	else
		return "";
	end
end

function RAL.SpellWithIcon(id, name)
	if id and name then
		return "|T"..select(3,GetSpellInfo(id))..":0|t"..name;
	elseif id then
		return "|T"..select(3,GetSpellInfo(id))..":0|t"..select(1,GetSpellInfo(id));
	elseif name then
		return name;
	else
		return "";
	end
end

function RAL.ToWhite(text)
	if (not text) or (text==nil) then return "";end
	return "|cFFFFFFFF"..tostring(text).."|r";
end
function RAL.ToRed(text)
	if (not text) or (text==nil) then return "";end
	return "|cFFFF0000"..tostring(text).."|r";
end
function RAL.ToGreen(text)
	if (not text) or (text==nil) then return "";end
	return "|cFF00FF00"..tostring(text).."|r";
end
function RAL.ToBlue(text)
	if (not text) or (text==nil) then return "";end
	return "|cFF0000FF"..tostring(text).."|r";
end
function RAL.ToYellow(text)
	if (not text) or (text==nil) then return "";end
	return "|cFFFFFF00"..tostring(text).."|r";
end
function RAL.ToCyan(text)
	if (not text) or (text==nil) then return "";end
	return "|cFF00FFFF"..tostring(text).."|r";
end
function RAL.ToPink(text)
	if (not text) or (text==nil) then return "";end
	return "|cFFFF00FF"..tostring(text).."|r";
end
function RAL.ToOrange(text)
	if (not text) or (text==nil) then return "";end
	return "|cFFFF9900"..tostring(text).."|r";
end


--下面提供可用于宏的增强讯息函数
function RAL.MSG(msg,Repeattime,mychan,latencytime,PREF)
	if not msg then
		--游戏里键入/run RAL.MSG()可查看到帮助
		RaidAlerter.AddMsg(RAL_TEXT_MARCO_1.."|cFF5588FF"..RAL_TEXT_MARCO_3);
		RaidAlerter.AddMsg(RAL_TEXT_MARCO_2.."|cFF5588FF"..RAL_TEXT_MARCO_4);
		return;
	end
	if not Repeattime then Repeattime=1 end
	Repeattime = floor(Repeattime);
	if not mychan then mychan="SAY" end
	if not latencytime then latencytime=3 end

	mychan = string.upper(mychan);
	if not(mychan=="SAY" or mychan=="YELL" or mychan=="PARTY" or mychan=="RAID" or mychan=="RAID_WARNING") then
		if mychan == "S" then
			mychan = "SAY";
		elseif mychan == "Y" then
			mychan = "YELL";
		elseif mychan == "P" then
			mychan = "PARTY";
		elseif mychan == "RA" then
			mychan = "RAID";
		elseif mychan == "RW" then
			mychan = "RAID_WARNING";
		else
			mychan = "SAY";
		end
	end

	if not PREF then
		PREF = "MyMSG";
		if UnitName("target") then
			PREF = PREF..UnitName("target");
		else
			PREF = PREF..UnitName("player");
		end
	end
	if RaidAlerter_GetTimer(PREF)>latencytime then
		for i=1,Repeattime do
			SendChatMessage(msg,mychan);
		end
		RaidAlerter_StartTimer(PREF);
	end
end

function RAL.W(msg,Repeattime,name,latencytime,PREF)
	if not msg then
		--游戏里键入/run RAL.W()可查看到帮助
		RaidAlerter.AddMsg(RAL_TEXT_MARCO_1.."|cFF5588FF"..RAL_TEXT_MARCO_5);
		RaidAlerter.AddMsg(RAL_TEXT_MARCO_2.."|cFF5588FF"..RAL_TEXT_MARCO_6);
		return;
	end
	if not Repeattime then Repeattime=1 end
	Repeattime = floor(Repeattime);
	if not name then
		if UnitName("target") then
			name=UnitName("target");
		else
			name=UnitName("player");
		end
	end
	if not latencytime then latencytime=3 end
	if not PREF then
		PREF = "MyW";
		if UnitName("target") then
			PREF = PREF..UnitName("target");
		else
			PREF = PREF..UnitName("player");
		end
	end
	if RaidAlerter_GetTimer(PREF)>latencytime then
		for i=1,Repeattime do
			SendChatMessage(msg, "WHISPER", nil, name);
		end
		RaidAlerter_StartTimer(PREF);
	end
end

function RAL.GI(unit)
	if not unit then
		if UnitName("target") then
			unit="target";
		else
			return "";
		end
	end
	if GetRaidTargetIndex(unit) then
		return RaidAlerter_RAIDICON[GetRaidTargetIndex(unit)];
	else
		return "";
	end
end

function RAL.GG(unit)
	if not unit then
		if UnitName("target") then
			unit="target";
		else
			return "";
		end
	end
	for i=1, GetNumGroupMembers() do
		local name, _, subgroup = GetRaidRosterInfo(i);
		if (name == UnitName(unit)) then
			return subgroup;
		end
	end
	return "";
end
