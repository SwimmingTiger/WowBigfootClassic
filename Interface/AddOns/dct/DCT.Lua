
DCT_Registered = 0
DCT_OnOption = false

dct_amount = nil
dct_school = nil
dct_resisted = nil
dct_blocked = nil
dct_absorbed = nil
dct_critical = nil
dct_glancing = nil
dct_crushing = nil
dct_spellId = nil
dct_spellName = nil
dct_spellSchool = nil
dct_missType = nil
dct_powerType = nil
dct_extraAmount = nil
dct_environmentalType = nil
dct_extraSpellId = nil
dct_extraSpellName = nil
dct_extraSpellSchool = nil
dct_auraType = nil
dct_icon = nil

dct_patch_block = nil
dct_patch_oi = nil
dct_patch_di = nil
dct_patch_oh = nil--过量治疗用
dct_patch_em = nil
dct_patch_ba = nil

dct_combatTime = 0

dct_ssc_number = false
dct_ssc_spellschool = false
dct_ssc_spell = false

local DCT_lowHealthFlag = false
local DCT_lowManaFlag = false
local DCT_optionsloaded = false

local DCT_ReflectTimestamp = {0,0,0}
local DCT_ReflectSpellID = {0,0,0}
local DCT_ReflectSourceID = {0,0,0}
local DCT_ReflectLastTimestamp = 0
local DCT_ReflectFlag = 1

--local DCT_lastMana = 0

local DCT_BuffFadeC = 0
local DCT_SpecSpellId = 0
local DCT_SpecSpellTime = 0

local DCT_FormatExPart = {}
local DCT_ModOptionList = {}
local DCT_BuffFadeList = {}

local DCT_PREFIXES = {
		["SWING"] = 1,
		["RANGE"] = 4,
		["SPELL"] = 4,
		["SPELL_PERIODIC"] = 4,
		["ENVIRONMENTAL"] = 2,
		["DAMAGE"] = 4,
}

local DCT_SAVEDATA_CLEAR = {
		"DCT_SHOWHIT_OT",
		"DCT_SHOWSPELL_OT",
		"DCT_SHOWPERIODIC_OT",
}

DCT_Player = nil
DCT_Font = nil

DCT_ANITYPE_DEFAULTCFG = {
	--弹出
	{param1 = 175,param2 = 150,param3 = 225,param4 = 50,param5 = -5,param6 = 30,param7 = 1},
	--HUD
	{param1 = 65,param2 = 200,param3 = 1,param4 = 1,param5 = 1},
	--静态
	{param1 = 3,param2 = 2,param3 = 1,param4 = 1,param5 = 1},
	--抛物线
	{param1 = 2.5,param2 = 100,param3 = 1,param4 = 1,param5 = 1},
	--水平
	{param1 = 200,param2 = 1,param3 = 1,param4 = 1,param5 = 1},
	--垂直
	{param1 = 200,param2 = 2,param3 = 1,param4 = 0,param5 = 1},
	--垂直
	{param1 = 1.5,param2 = 1,param3 = 1,param4 = 1,param5 = 2},
}

DCT_EVENT_FUNC = {

}

local DCT_warriorPath = false
local DCT_warriorIcon = {"a","a"}
local DCT_warriorName = {"a","a"}

--Blizzard APi calls
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitPower = UnitPower
local UnitPowerMax = UnitPowerMax
local UnitName = UnitName
local UnitGUID = UnitGUID
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local GetPlayerBuff = GetPlayerBuff
local GetPlayerBuffName = GetPlayerBuffName
local CombatLog_Object_IsA = CombatLog_Object_IsA

function DCT_Debug(msg)
	-- 移除调试信息
	-- Sharak@BigFoot
end

function DCT_ModLoad()
	for i = 1,GetNumAddOns() do
		local name, title, notes, enabled, loadable, reason, security = GetAddOnInfo(i)
		local loaded  = IsAddOnLoaded(i)
		local isondemand = IsAddOnLoadOnDemand(i)
		name = string.lower(name)

		if isondemand and not loaded and string.sub(name,1,3) == "dct" then
			if name ~= "dct_options" then
				LoadAddOn(name)
				DCT_Debug("Mod loaded: "..name)
			end
		end
	end
end

--[[
Arguments
(index or "name")
index
Integer - The index of the AddOn in the user's AddOn list. Note that you cannot access Blizzard-provided AddOns through this mechanism.
name
String - The name of the AddOn to be queried. You can access Blizzard-provided AddOns through this mechanism.
Returns
name, title, notes, enabled, loadable, reason, security
name
String - The name of the AddOn.
title
String - The title of the AddOn from its .toc file (presumably this is the appropriate localized one).
notes
String - The notes about the AddOn from its .toc file (presumably this is the appropriate localized one).
enabled
Flag - Indicates if the AddOn is currently enabled, 1 if it is, nil if it is not.
loadable
Flag - Indicates if the AddOn is eligible to be loaded, 1 if it is, nil if it is not.
reason
String - The reason why the AddOn cannot be loaded. This is nil if the addon is loadable, otherwise it contains a code indicating the reason. (Observed reason codes: "DISABLED" and "MISSING")
security
String - Indicates the security status of the AddOn. This is currently "INSECURE" for all user provided addons and "SECURE" for Blizzard_* AddOns.
]]
function DCT_OnLoad(self)
	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")

	DCT_EVENT_FUNC["COMBAT_LOG_EVENT_UNFILTERED"] = DCT_ProcCombatUnfiltered
	DCT_EVENT_FUNC["COMBAT_TEXT_UPDATE"] = DCT_ProcCombatTextUpdata
	DCT_EVENT_FUNC["UNIT_HEALTH"] = DCT_ProcHealth
	DCT_EVENT_FUNC["UNIT_POWER_UPDATE"] = DCT_ProcMana
	DCT_EVENT_FUNC["UNIT_POWER_FREQUENT"] = DCT_ProcCP
	DCT_EVENT_FUNC["PLAYER_REGEN_ENABLED"] = DCT_ProcLeaveCombat
	DCT_EVENT_FUNC["PLAYER_REGEN_DISABLED"] = DCT_ProcEnterCombat

	DCT_EVENT_FUNC["PLAYER_REGEN_ENABLED"] = DCT_ProcLeaveCombat

	DCT_EVENT_FUNC["SPELL_UPDATE_COOLDOWN"] = DCT_ProcCooldown

	DCT_EVENT_FUNC["VARIABLES_LOADED"] = DCT_OnEvent
	DCT_EVENT_FUNC["PLAYER_ENTERING_WORLD"] = DCT_OnEnteringWorld
	DCT_EVENT_FUNC["ADDON_LOADED"] = DCT_OnEvent
end

function DCT_ReLoadFrame()
	local flp = DCT_Get("DCT_FRAME_CONFIG")
	local i,c
	c = table.getn(flp)
	--如果flp内的Frame数没DCT_Ani_MaxFrame多则先要修补
	if c < DCT_Ani_MaxFrame then
		for i = c + 1,DCT_Ani_MaxFrame do
			flp[i] = {active = false}
		end
	end

	for i = 1 , DCT_Ani_MaxFrame do
		DCT_Ani_FrameDisable(i)
	end

	for i = 1 , c do
		if flp[i].active then
			DCT_Ani_FrameActive(i)
			DCT_Ani_FramePos(i,flp[i].x,flp[i].y)
			DCT_Ani_FrameSetAngle(i,flp[i].angle)
		end

	end
end

-- Add by dugu@bigfoot
function DCT_Toggle(switch)
	local self = getglobal("DCT_TEXT");
	if (switch) then
		DCT_Set("DCT_Enable",1)
		DCT_Init(self);
	else
		DCT_Set("DCT_Enable",0)
		self:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
		self:UnregisterEvent("COMBAT_TEXT_UPDATE")
		self:UnregisterEvent("PLAYER_REGEN_ENABLED")
		self:UnregisterEvent("PLAYER_REGEN_DISABLED")
		self:UnregisterEvent("UNIT_POWER_FREQUENT")
		self:UnregisterEvent("UNIT_HEALTH")
		self:UnregisterEvent("UNIT_POWER_UPDATE")
		self:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
	end
end

function DCT_Init(self)
	if (DCT_Registered == 1) then return;end
	--DCT_Reset()
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("COMBAT_TEXT_UPDATE")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("UNIT_POWER_FREQUENT")
	self:RegisterEvent("UNIT_HEALTH")
	self:RegisterEvent("UNIT_POWER_UPDATE")

	--Cooldown
	self:RegisterEvent("SPELL_UPDATE_COOLDOWN")
	-- 版本控制
	if DCT_SAVE_PERCHAR and (not DCT_SAVE_PERCHAR["DCT_SaveVer"] or DCT_SAVE_PERCHAR["DCT_SaveVer"] < DCT_DEFAULT_CFG["DCT_SaveVer"]) then
		DCT_SAVE_PERCHAR = nil
		DCT_SAVE = nil
	end

	if not DCT_SAVE then
		DCT_SAVE = {}
		DCT_Debug("DCT_SAVE nil")
	end

	DCT_Player = DCT_Config_GetPlayer();
	DCT_DataFix(DCT_Player,DCT_DEFAULT_CFG)
	DCT_DataShowParamFix(DCT_Player,DCT_DEFAULT_CFG)

	local k,v
	for k,v in pairs(DCT_SAVE) do
		if DCT_SAVE[k]["DCT_SHOWHIT"] then
			DCT_Debug("The config:( "..k.." ) has been deleted! (version error)")
			DCT_SAVE[k] = nil
		end
	end

	-- 清除不需要的项目
	for k,v in pairs(DCT_SAVEDATA_CLEAR) do
		if DCT_Player[v] then DCT_Player[v] = nil;end
	end

	DCT_Registered = 1

	SlashCmdList["DCT"] = DCT_showMenu;
	SLASH_DCT1 = "/dct";

	DCT_Ani_Init()
	DCT_Ani_FrameInit()

	DCT_InitFont()
	DCT_CheckAllFont()

	DCT_ReLoadFrame()

	DCT_ModLoad()
end

function DCT_RegistModOptionButton(funcStr)
	if not DCT_ModOptionList[funcStr] then
		DCT_ModOptionList[funcStr] = false
	end

end

function DCT_showMenu()
	if not DCT_optionsloaded then
		DCT_optionsloaded = LoadAddOn("dct_options")
	end
	if DCT_optionsloaded then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPEN);

		local k,v
		for k,v in pairs(DCT_ModOptionList) do
			if v == false then
				local func = getglobal(k)
				func()
				DCT_ModOptionList[k] = true
			end
		end

		if not DCT_OnOption then
			DCT_Options:Show();
		end
		DCT_OnOption = true
	else
		DCT_Debug("None Menu");
	end
end

--Hide the Option Menu
function DCT_hideMenu()
	if DCT_Options then
		DCT_Options:Hide();
	end
end

function DCT_SetFrameAniDefault(fid)
	local fp = DCT_Get("DCT_FRAME_CONFIG")[fid]
	if fp then
		for key,val in pairs(DCT_ANITYPE_DEFAULTCFG[fp.aniType]) do
			fp[key] = val
		end
	end
end

function DCT_CheckAllFont()
	if DCT_Font then
		local c = table.getn(DCT_Font)
		local i
		local fobj = DCT_Ani_TextGet()
		for i = 4,c do
			if fobj:SetFont(DCT_Font[i].path, 16,"") then
				DCT_Font[i].active = true
			else
				DCT_Font[i].active = false
			end
		end
	end
end

function DCT_InitFont()
	if DCT_FONT_SAVE then
		local i
		for i = 1 , 3 do
			DCT_FONT_SAVE[i] = DCT_clone(DCT_FONT_DEFAULT[i])
		end
		for i = 4 , 12 do
			if (DCT_FONT_SAVE[i] and DCT_FONT_SAVE[i].avtive == false) or not DCT_FONT_SAVE[i] then
				DCT_FONT_SAVE[i] = DCT_clone(DCT_FONT_DEFAULT[i])
			end
		end
	else
		DCT_FONT_SAVE = DCT_clone(DCT_FONT_DEFAULT)
	end
	DCT_Font = DCT_FONT_SAVE
end

function DCT_Reset()
	DCT_SAVE_PERCHAR = nil
	DCT_Player = DCT_Config_GetPlayer()
	DCT_ReLoadFrame()
end

function DCT_Config_GetPlayer()
	if not DCT_SAVE_PERCHAR or type(DCT_SAVE_PERCHAR) ~= "table" then
		DCT_Config_NewPlayer()
	end
	return DCT_SAVE_PERCHAR
end

function DCT_Config_Load(data)
	if data then
		DCT_SAVE_PERCHAR = nil
		DCT_SAVE_PERCHAR = DCT_clone(data)
		DCT_Player = DCT_Config_GetPlayer()
		DCT_DataFix(DCT_Player,DCT_DEFAULT_CFG)
		DCT_DataShowParamFix(DCT_Player,DCT_DEFAULT_CFG)
		DCT_ReLoadFrame()
	end
end

--Set up a default config
function DCT_Config_NewPlayer()
	DCT_Debug("DCT: New Config")
	DCT_SAVE_PERCHAR = DCT_clone(DCT_DEFAULT_CFG)
end

function DCT_Get(option)
	if (DCT_Player ~= nil) and (DCT_Player[option] ~= nil) then
		return DCT_Player[option]
	else
		DCT_Player[option] = DCT_DEFAULT_CFG[option]
		return DCT_DEFAULT_CFG[option]
	end
end

function DCT_Set(option, newVal)
	if (DCT_Player ~= nil) then
		if ( option ) then
			DCT_Player[option] = newVal
		end
	end
end

function DCT_DataShowParamFix(a,b)
	local k,v
	for k,v in pairs(b) do
		if type(v) == "table" then
			if v.show and a[k].show then
				if table.getn(v.show) == 1 then
					a[k].show[2] = nil
				elseif table.getn(v.show) == 2 and table.getn(a[k].show) == 1 then
					a[k].show[2] = v.show[2]
				end
			end
			if v.sound and not a[k].sound then
				a[k].sound = v.sound
			end
			if not v.sound and a[k].sound then
				a[k].sound = nil
			end
		end
	end
end

--用于修正Save文档，如果b表内的第一层键在a表不存在则添加,如果表b内第一层不存在的键在表a存在.则表a的也删除
function DCT_DataFix(a,b)
	local k,v
	for k,v in pairs(b) do
		if a[k] == nil or type(a[k]) ~= type(v) then
			if type(v) == "table" then
				a[k] = DCT_clone(v)
			else
				a[k] = v
			end
		end
	end
	for k,v in pairs(a) do
		if b[k] == nil then
			a[k] = nil
		end
	end

end

--将a内容和b比较，如果b表里存在项，而a表不存在，则将b表里的内容复制到a表
function DCT_Link(a,b)
	local k,v

	for k,v in pairs(b) do
		if a[k] == nil then
			if type(v) == "table" then
				a[k] = DCT_clone(v)
			else
				a[k] = v
			end
		else
			if type(v) == "table" then
				if type(a[k]) == "table" then
					DCT_Link(a[k],v)
				end
			end
		end
	end
end

--将b表合并入a表,b优先覆盖a
function DCT_Merge(a,b)
	local k,v
	for k,v in pairs(b) do
		if type(v) == "table" then
			if type(a[k]) == "table" then
				DCT_Merge(a[k],v)
			else
				a[k] = v
			end
		else
			if type(a[k]) == "table" then
				a[k] = nil
				a[k] = v
			else
				a[k] = v
			end
		end
	end
end

function DCT_clone(t)
  local new = {}
  local i, v = next(t, nil)
  while i do
  	if type(v)=="table" then
  		v=DCT_clone(v)
  	end
    new[i] = v
    i, v = next(t, i)
  end
  return new;
end

function DCT_ProcBlock()
	dct_patch_block = nil
	local en = DCT_Get("DCT_EnglishInfo")
	if dct_resisted then
		if en == 1 then
			dct_patch_block = dct_resisted.." Resist"
		else
			dct_patch_block = dct_resisted.." "..getglobal("RESIST")
		end
		dct_patch_ba = dct_resisted
		dct_missType = "RESIST"
	elseif dct_blocked then
		if en == 1 then
			dct_patch_block = dct_blocked.." Block"
		else
			dct_patch_block = dct_blocked.." "..getglobal("BLOCK")
		end
		dct_patch_ba = dct_blocked
		dct_missType = "BLOCK"
	elseif dct_absorbed then
		if en == 1 then
			dct_patch_block = dct_absorbed.." Absorb"
		else
			dct_patch_block = dct_absorbed.." "..getglobal("ABSORB")
		end
		dct_patch_ba = dct_absorbed
		dct_missType = "ABSORB"
	elseif dct_glancing then
		if en == 1 then
			dct_patch_block = "glance"
		else
			dct_patch_block = getglobal("DEFLECT")
		end
		dct_patch_ba = dct_patch_block
		dct_missType = "DEFLECT"
	elseif dct_crushing then
		if en == 1 then
			dct_patch_block = "Crush"
		else
			dct_patch_block = TEXT_MODE_A_STRING_RESULT_CRUSHING
		end
		dct_patch_ba = dct_patch_block
	end
end

function DCT_GetFormatText(showType,showId,saveP)
	if not saveP then saveP = DCT_Player;end
	if not saveP[showType] then return nil;end
	local p = saveP[showType]
	if not showId then showId = 1;end
	if not DCT_Ani_FrameIsActive(p.frame) or not p.show[showId] then return nil;end
	if string.len(p.show[showId]) < 1 then return nil;end
	return DCT_Format(p.show[showId],p.colorEx)
end

function DCT_AddText(showType,showId,crit,saveP)
	if not saveP then saveP = DCT_Player;end
	if saveP[showType] and saveP[showType].sound then
		if saveP[showType].frame ~= 0 and string.len(saveP[showType].sound) > 1 then
			PlaySoundFile(saveP[showType].sound)
		end
	end

	return DCT_SetText(showType,showId,crit,saveP,nil)
end

--设置指定obj的内容，如果obj为空则添加新的
function DCT_SetText(showType,showId,crit,saveP,obj)
	if not saveP then saveP = DCT_Player;end
	if not saveP[showType] then return nil;end
	local p = saveP[showType]
	if not showId then showId = 1;end
	if not DCT_Ani_FrameIsActive(p.frame) or not p.show[showId] then return nil;end
	if string.len(p.show[showId]) < 1 then return nil;end
	if obj ~= nil then
		DCT_Ani_ObjSetText(obj,DCT_Format(p.show[showId],p.colorEx),obj.fontEn,obj.fontCh,obj.fontSizeEn,obj.fontSizeCh,obj.fEff,p.color,nil)
		return obj
	else
		return DCT_Ani_FrameAddObject(p.frame,DCT_Format(p.show[showId],p.colorEx),p,crit,saveP,obj)
	end
end

function DCT_AddTextNoFormat(showType,text,crit,saveP)
	if not text then return nil;end
	if not saveP then saveP = DCT_Player;end
	if saveP[showType] and saveP[showType].sound then
		if saveP[showType].frame ~= 0 and string.len(saveP[showType].sound) > 1 then
			PlaySoundFile(saveP[showType].sound)
		end
	end

	return DCT_SetTextNoFormat(showType,text,crit,saveP,nil)
end

--设置指定obj的内容(不包含format)，如果obj为空则添加新的
function DCT_SetTextNoFormat(showType,text,crit,saveP,obj)
	if not text then return;end
	if not saveP then saveP = DCT_Player;end
	if not saveP[showType] then return nil;end
	local p = saveP[showType]
	if not DCT_Ani_FrameIsActive(p.frame) then return nil;end
	if obj ~= nil then
		DCT_Ani_ObjSetText(obj,text,obj.fontEn,obj.fontCh,obj.fontSizeEn,obj.fontSizeCh,obj.fEff,p.color,nil)
		return obj
	else
		return DCT_Ani_FrameAddObject(p.frame,text,p,crit,saveP,obj)
	end
end

function DCT_GenerateSpellSchoolColor(spellSchool)
    local color, count = {0,0,0}, 0;
    if not spellSchool then
        spellSchool = dct_spellSchool;
    end
    local k = 1;
    while k <= 64 do
        if bit.band(k, spellSchool) ~= 0 then
            local nc = DCT_Get("DCT_SSColor"..k).color;
            for i = 1, 3, 1 do
                color[i] = color[i] + nc[i];
            end
            count = count + 1;
        end
        k = k * 2;
    end
	if count == 0 then
		count = 1
	end
    for i = 1, 3, 1 do
        color[i] = color[i] / count;
    end
    return color;
end

function DCT_SpellSchoolColor(spellSchool,txt)
	local color = DCT_GenerateSpellSchoolColor(spellSchool);
	return DCT_ColorFlip(color[1],color[2],color[3])..txt.."|r"
end

function DCT_SSC_Format_Enable()
	if DCT_Get("DCT_SSC_Number") == 1 then dct_ssc_number = true;end
	if DCT_Get("DCT_SSC_SpellSchool") == 1 then dct_ssc_spellschool = true;end
	if DCT_Get("DCT_SSC_Spell") == 1 then dct_ssc_spell = true;end
end

function DCT_SSC_Format_EnableAll()
	dct_ssc_number = true
	dct_ssc_spellschool = true
	dct_ssc_spell = true
end

function DCT_SSC_Format_DisableAll()
	dct_ssc_number = false
	dct_ssc_spellschool = false
	dct_ssc_spell = false
end

function DCT_OnEnteringWorld(self)
	--战士压制修正 spellID:7384,14895,17198,24407,32154,35892,37321,37529,43456,58516
	--战士复仇修正 spellID:6572,6574,7379,8602
	if select(2,UnitClass("player")) == "WARRIOR" then
		DCT_warriorPath = true
		DCT_warriorName[1],_,DCT_warriorIcon[1] = GetSpellInfo(7384)
		DCT_warriorName[2],_,DCT_warriorIcon[2] = GetSpellInfo(6572)
	end
	--[[
	local i
	for i = 1,65535 do
		if select(1,GetSpellInfo(i)) == "复仇" then
			DCT_Debug(""..i)
		end
	end]]
end

function DCT_OnEvent(self, event, addon, ...)
	if (event == "VARIABLES_LOADED") or ( event == "ADDON_LOADED" and string.lower(addon) == "dct" ) then
		DCT_Init(self)
	end
end

function DCT_PlayEventSound(event)
	if DCT_Get(event).frame ~= 0 and DCT_Get(event).sound then
		if string.len(DCT_Get(event).sound) > 1 then
			PlaySoundFile(DCT_Get(event).sound)
		end
	end
end

function DCT_ProcHealth(self, event, larg1)
	if (larg1 == "player") then
		if UnitHealth("player") / UnitHealthMax("player") < DCT_Get("DCT_SHOWLOWHEALTH").per / 100.0 then
			if DCT_lowHealthFlag then
				DCT_SSC_Format_DisableAll()
				DCT_AddText("DCT_SHOWLOWHEALTH",1,false,nil)
				DCT_lowHealthFlag = false
			end
		else
			DCT_lowHealthFlag = true
		end
	end
end

function DCT_ProcMana(self, event, larg1)
	if larg1 == "player" then
		if UnitPowerType("player") == 0 then
			if UnitPower("player") / UnitPowerMax("player") < DCT_Get("DCT_SHOWLOWMANA").per / 100.0 then
				if DCT_lowManaFlag then
					DCT_SSC_Format_DisableAll()
					DCT_AddText("DCT_SHOWLOWMANA",1,false,nil)
					DCT_lowManaFlag = false
				end
			else
				DCT_lowManaFlag = true
			end
		end
		--[[
		if DCT_lastMana ~= 0 and DCT_lastMana < UnitPowerMax("player") then
			DCT_SSC_Format_DisableAll()
			dct_powerType = UnitPowerType("player")
			DCT_AddText("DCT_SHOWPOWER",1,false,nil)
			return
		end
		DCT_lastMana = UnitPower("player")]]
	end
end

function DCT_ProcEnterCombat(self, event)
	dct_combatTime = GetTime()
	DCT_AddText("DCT_SHOWCOMBAT",1,false,nil)
	dct_inCombat = true
end

----------------------
--Player NoCombat
function DCT_ProcLeaveCombat(self, event)
	DCT_AddText("DCT_SHOWCOMBATLEAVE",1,false,nil)
	dct_inCombat = false
end

local old_comboPoints
function DCT_ProcCP(self, event, larg1)
	if (larg1 == "player") then
		dct_amount = GetComboPoints("player", "target")
		if dct_amount > 0 then
			if not old_comboPoints or old_comboPoints ~= dct_amount then
				old_comboPoints = dct_amount;
				DCT_SSC_Format_DisableAll()
				if dct_amount < 5 then
					DCT_AddText("DCT_SHOWCP",1,false,nil)
				else
					DCT_AddText("DCT_SHOWCP",2,false,nil)
				end
			end
		end
	end
end

function DCT_ProcCombatTextUpdata(self, event, larg1, larg2, larg3)
	local showType = nil
	local showId = 1

	if larg1 == "SPELL_ACTIVE" then
		if DCT_warriorPath and (DCT_warriorName[1] == larg2 or DCT_warriorName[2] == larg2) then return;end
		dct_spellName = larg2
		dct_icon = select(3, GetSpellInfo(larg2))
		showType = "DCT_SHOWACTIVE"
	elseif larg1 == "FACTION" then --shenwang
		dct_amount = larg3
		dct_spellName = larg2
		if dct_amount and dct_amount < 0 then
			showId = 2
			dct_amount = -dct_amount
		end
		showType = "DCT_SHOWFACTION"
	elseif larg1 == "HONOR_GAINED" then
		dct_amount = larg2
		if (not dct_amount or abs(dct_amount) < 1) then
			return;
		end
		dct_amount = floor(dct_amount);
		showType = "DCT_SHOWHONOR"
	elseif larg1 == "EXTRA_ATTACKS" then

	end

	if showType then
		DCT_SSC_Format_DisableAll()
		DCT_AddText(showType,showId,false,nil)
	end
	--[[
	it returns:
arg1
Combat message type. Known values include "DAMAGE", "SPELL_DAMAGE", "DAMAGE_CRIT", "HEAL", "PERIODIC_HEAL", "HEAL_CRIT", "MISS", "DODGE", "PARRY", "BLOCK", "RESIST", "SPELL_RESISTED", "ABSORB", "SPELL_ABSORBED", "MANA", "ENERGY", "RAGE", "FOCUS", "SPELL_ACTIVE", "COMBO_POINTS", "AURA_START", "AURA_END", "AURA_START_HARMFUL", "AURA_END_HARMFUL", "HONOR_GAINED", and "FACTION".
arg2
For damage, power gain and honor gains, this is the amount taken/gained. For heals, this is the healer name. For auras, the aura name. For block/resist/absorb messages where arg3 is not nil (indicating a partial block/resist/absorb) this is the amount taken. For faction gain, this is the faction name. For the SPELL_ACTIVE message, the name of the spell (abilities like Overpower and Riposte becoming active will trigger this message).
arg3
For heals, the amount healed. For block/resist/absorb messages, this is the amount blocked/resisted/absorbed, or nil if all damage was avoided. For faction gain, the amount of reputation gained.

What I need to know is this. As you can see on the arg1 you've got DAMAGE, SPELL_DAMAGE and DAMAGE_CRIT, initially I thought DAMAGE was melee, SPELL_DAMAGE was spell. But as you can see only DAMAGE_CRIT is there, no SPELL_DAMAGE_CRIT etc. So I wonder, is DAMAGE all damage including spell damage?
]]
end

function DCT_ProcCombatUnfiltered(self, gevent, ...)
    DCT_BattleLogAnalysis(self, gevent, CombatLogGetCurrentEventInfo())
end

function DCT_BattleLogAnalysis(self, gevent, timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)
	if DCT_Registered ~= 1 then return;end
	if DCT_Get("DCT_Enable") ~= 1 then return;end
	if not combatevent then return;end
	if type(combatevent) ~= "string" then return;end
	if DCT_OnOption then return;end

	--盾反的补充
	if math.abs(DCT_ReflectLastTimestamp - timestamp) < 5 then
		local i
		for i = 1,3 do
			if math.abs(DCT_ReflectTimestamp[i] - timestamp) < 4 then
				if sourceGUID == destGUID and DCT_ReflectSourceID[i] == sourceGUID then
					dct_spellId, dct_spellName, dct_spellSchool = select(1,...)
					if DCT_ReflectSpellID[i] == dct_spellId then
						if string.sub(combatevent,1,5) == "SPELL" then
							dct_amount, dct_over,dct_school, dct_resisted, dct_blocked, dct_absorbed, dct_critical, dct_glancing, dct_crushing = select(4,...)
							if DCTD_ReflectActive then
								dct_patch_oi = sourceName
								DCTD_ReflectActive()
							end
							return
						end
					end
				end
			end
		end
	end

	--目标或者焦点的特定Buff/Debuff获得
	if (bit.band(destFlags, COMBATLOG_OBJECT_FOCUS) == COMBATLOG_OBJECT_FOCUS) or (bit.band(destFlags, COMBATLOG_OBJECT_TARGET) == COMBATLOG_OBJECT_TARGET) then
		if combatevent == "SPELL_AURA_APPLIED" or combatevent == "SPELL_AURA_REMOVED" then
			dct_spellId, dct_spellName, dct_spellSchool,dct_auraType = select(1,...)
			local tmpShow,tmpP
			if combatevent == "SPELL_AURA_APPLIED" then
				tmpShow = "DCT_SHOWSPECTARGET"..dct_auraType
				tmpP = DCT_Player["DCT_SPECTARGETBUFF"]
			else
				tmpShow = "DCT_SHOWSPECTARGET"..dct_auraType.."FADE"
				tmpP = DCT_Player["DCT_SPECTARGETBUFFFADE"]
			end
			if DCT_Ani_FrameIsActive(DCT_Player[tmpShow].frame) then
				if tmpP[dct_spellName] then
					dct_icon = dct_spellId
					local id = 1
					if bit.band(destFlags, COMBATLOG_OBJECT_FOCUS) == COMBATLOG_OBJECT_FOCUS then id = 2;end
					DCT_SSC_Format_DisableAll()
					dct_patch_oi = destName
					DCT_AddText(tmpShow,id,false,nil)
				end
			end
		end
	end

	if DCTSA_ProcCombatUnfiltered and DCTSA_ProcCombatUnfiltered(gevent, timestamp,combatevent, hideCaster,  sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...) then return;end

	local fromPlayer,toPlayer,fromPet
	fromPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)
    toPlayer = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MINE)
	fromPet = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)

	if not fromPlayer and not toPlayer and not fromPet then return;end

	local prefixes, suffixes

	local underline = -1;
	underline = string.find(combatevent, "_")

	if underline == -1 then return end

	prefixes = string.sub(combatevent,1,underline - 1)
	suffixes = string.sub(combatevent,underline + 1,string.len(combatevent))

	if string.sub(suffixes,1,8) == "PERIODIC" then
		prefixes = prefixes.."_PERIODIC"
		suffixes = string.sub(suffixes,10,string.len(suffixes))
	end

	if not prefixes or not suffixes then return;end

	DCT_SSC_Format_DisableAll()

	local showType = nil
	local showId = 1
	local crit = false
	dct_spellId, dct_spellName, dct_spellSchool = select(1,...)
	dct_patch_oi = sourceName
	if combatevent == "PARTY_KILL" then
		if fromPlayer or fromPet then
			dct_patch_di = destName
			DCT_AddText("DCT_SHOWKILLBLOW",1,false,nil)
		end
		return
	end

	if fromPlayer and DCT_warriorPath then
		if suffixes == "MISSED"  then
			dct_missType = select(DCT_PREFIXES[prefixes],...)
			if dct_missType == "DODGE" then
				dct_spellName = DCT_warriorName[1]
				dct_icon = DCT_warriorIcon[1]
				DCT_AddText("DCT_SHOWACTIVE",1,false,nil)
			end
		end
	end

	if toPlayer then
		if suffixes == "DAMAGE" or suffixes == "SPLIT" then
			dct_amount, dct_over, dct_school, dct_resisted, dct_blocked, dct_absorbed, dct_critical, dct_glancing, dct_crushing = select(DCT_PREFIXES[prefixes],...)
			if prefixes == "SWING" then
				showType = "DCT_SHOWHIT"
			elseif prefixes == "RANGE" then
				showType = "DCT_SHOWHIT"
			elseif prefixes == "SPELL"then
				showType = "DCT_SHOWSPELL"
				dct_icon = dct_spellId
			elseif prefixes == "SPELL_PERIODIC" then
				showType = "DCT_SHOWPERIODIC"
				dct_icon = dct_spellId
			elseif prefixes == "ENVIRONMENTAL" then
				showType = "DCT_SHOWENVIRONMENTAL"
				dct_environmentalType = dct_spellId
			end

			if prefixes == "DAMAGE" then--"DAMAGE_SPLIT"
				showType = "DCT_SHOWSPELL"
				dct_icon = dct_spellId
			end

			DCT_ProcBlock()
			if dct_patch_block then
				showId = 2
			end
			if dct_amount ~= 0 then
				if dct_critical then
					crit = true
					if showType == "DCT_SHOWHIT" or showType == "DCT_SHOWSPELL" then showType = showType.."CRIT";end
				end
				if showType and DCT_Get(showType).per then
					if dct_amount < DCT_Get(showType).per then showType = nil;end
				end
				if prefixes == "SPELL" or prefixes == "SPELL_PERIODIC" then
					DCT_SSC_Format_Enable()
				end
			else
				showType = "DCT_SHOW"..dct_missType
				if prefixes == "SPELL" or prefixes == "SPELL_PERIODIC" then
					showId = 2
					dct_icon = dct_spellId
					DCT_SSC_Format_Enable()
				end
			end
		elseif suffixes == "MISSED" then
			dct_missType = select(DCT_PREFIXES[prefixes],...)
			if prefixes == "SPELL" or prefixes == "SPELL_PERIODIC" then
				showId = 2
				dct_icon = dct_spellId
				DCT_SSC_Format_Enable()
			end
			showType = "DCT_SHOW"..dct_missType

			if dct_missType == "REFLECT" then
				if prefixes ~= "SWING" then
					DCT_ReflectSpellID[DCT_ReflectFlag] = dct_spellId
					DCT_ReflectSourceID[DCT_ReflectFlag] = sourceGUID
					DCT_ReflectTimestamp[DCT_ReflectFlag] = timestamp
					DCT_ReflectLastTimestamp = timestamp
					DCT_ReflectFlag = DCT_ReflectFlag + 1
					if DCT_ReflectFlag > 3 then DCT_ReflectFlag = 1;end
				end
			end

			if DCT_warriorPath and (dct_missType == "BLOCK" or dct_missType == "DODGE" or dct_missType == "PARRY") then
				dct_spellName = DCT_warriorName[2]
				dct_icon = DCT_warriorIcon[2]
				DCT_AddText("DCT_SHOWACTIVE",1,false,nil)
			end
		elseif suffixes == "HEAL" then
			dct_amount, dct_over, dct_absorbed, dct_critical = select(DCT_PREFIXES[prefixes],...)
			showType = "DCT_SHOWHEAL"
			if prefixes == "SPELL_PERIODIC" then
				showType = "DCT_SHOWPERIODICHEAL"
			end
			dct_icon = dct_spellId

			--过量治疗处理
			if dct_amount - dct_over == 0 and DCT_Get("DCT_ZeroHp_off") == 1 then return;end
			if dct_over ~= 0 then
				dct_patch_oh = dct_over
				dct_amount = dct_amount - dct_over
				showId = 2
			end
			local ch,mh;

			if dct_critical then crit = true;end
			if showType and DCT_Get(showType).per then
				if dct_amount < DCT_Get(showType).per then showType = nil;end
			end
			if DCT_Get("DCT_HealSelfNoneName") == 1 and sourceGUID == destGUID then dct_spellName = "";end
			if DCT_Get("DCT_ManaSelfNoneName") == 1 and sourceGUID == destGUID then dct_patch_oi = "";end
		elseif suffixes == "ENERGIZE" then
			dct_amount, dct_powerType = select(DCT_PREFIXES[prefixes],...)
			if dct_powerType >= 0 and dct_powerType <= 4 then
				dct_icon = dct_spellId
				showType = "DCT_SHOWPOWER"
				if DCT_Get(showType).per then
					if dct_amount < DCT_Get(showType).per then showType = nil end
				end
				if DCT_Get("DCT_ManaSelfNoneName") == 1 and sourceGUID == destGUID then dct_patch_oi = "";end
			end
		elseif suffixes == "AURA_APPLIED" then
			dct_auraType = select(DCT_PREFIXES[prefixes],...)
			showType = "DCT_SHOW"..dct_auraType
			dct_icon = dct_spellId
			if dct_auraType == "BUFF" then
				if DCT_Get("DCT_SHOWBUFFFADE").per > 0 then
					DCT_AddBuffFadeRecord(dct_spellName,DCT_Get("DCT_SHOWBUFFFADE").per)
				elseif DCT_Get("DCT_SHOWSPECBUFFFADE").per > 0 and DCT_Get("DCT_SPECBUFFFADE")[dct_spellName] then
					DCT_AddBuffFadeRecord(dct_spellName,DCT_Get("DCT_SHOWSPECBUFFFADE").per)
				end
			end

			if DCT_Get("DCT_SHOWSPECBUFF").frame ~= 0 then
				if DCT_Get("DCT_SPECBUFF")[dct_spellName] then
					showType = "DCT_SHOWSPECBUFF"
					if dct_auraType == "DEBUFF" then
						showId = 2
					end
				end
			end
		elseif suffixes == "AURA_REMOVED" then
			dct_auraType = select(DCT_PREFIXES[prefixes],...)
			showType = "DCT_SHOW"..dct_auraType.."FADE"
			if dct_auraType == "BUFF" then
				if DCT_Get("DCT_SHOWSPECBUFFFADE").frame ~= 0 and DCT_Get("DCT_SPECBUFFFADE")[dct_spellName] then
					showType = "DCT_SHOWSPECBUFFFADE"
				end
			else
				if DCT_Get("DCT_SHOWSPECDEBUFFFADE").frame ~= 0 and DCT_Get("DCT_SPECBUFFFADE")[dct_spellName] then
					showType = "DCT_SHOWSPECDEBUFFFADE"
				end
			end
			dct_icon = dct_spellId
		elseif suffixes == "DRAIN" or suffixes == "LEECH" then
			dct_amount,dct_powerType,dct_extraAmount = select(DCT_PREFIXES[prefixes],...)
			dct_icon = dct_spellId
			if dct_powerType >= 0 and dct_powerType <= 4 then
				showType = "DCT_SHOWDRAIN"
			end
		elseif suffixes == "SHIELD" then
			if prefixes == "DAMAGE" then
				dct_amount, dct_over, dct_school, dct_resisted, dct_blocked, dct_absorbed, dct_critical, dct_glancing, dct_crushing = select(DCT_PREFIXES[prefixes],...)
				dct_icon = dct_spellId
				DCT_SSC_Format_Enable()
				showType = "DCT_SHOWSHIELD"
			end
		elseif suffixes == "SPLIT" then
			if prefixes == "DAMAGE" then
				dct_amount, dct_over, dct_school, dct_resisted, dct_blocked, dct_absorbed, dct_critical, dct_glancing, dct_crushing = select(DCT_PREFIXES[prefixes],...)
				dct_icon = dct_spellId
				DCT_SSC_Format_Enable()
				showType = "DCT_SHOWSPELL"
			end
		elseif suffixes == "DISPEL" then
			dct_spellId, dct_spellName, dct_spellSchool,dct_auraType = select(DCT_PREFIXES[prefixes],...)
			if dct_auraType == "BUFF" then
				dct_icon = dct_spellId
				showType = "DCT_SHOWDISPELLED"
			end
		elseif suffixes == "STOLEN" then
			dct_spellId, dct_spellName, dct_spellSchool = select(DCT_PREFIXES[prefixes],...)
			dct_icon = dct_spellId
			showType = "DCT_SHOWDISPELLED"
			showId = 2
		elseif suffixes == "AURA_APPLIED_DOSE" then
			dct_auraType,dct_amount = select(DCT_PREFIXES[prefixes],...)
			if dct_amount > 1 then
				dct_icon = dct_spellId
				showType = "DCT_SHOW"..dct_auraType.."DOSE"
			end
		elseif suffixes == "AURA_REMOVED_DOSE" then
			dct_auraType,dct_amount = select(DCT_PREFIXES[prefixes],...)
			if dct_amount > 1 then
				dct_icon = dct_spellId
				showType = "DCT_SHOW"..dct_auraType.."DOSE"
				showId = 2
			end
		elseif suffixes == "EXTRA_ATTACKS" then
			dct_amount = select(DCT_PREFIXES[prefixes],...)
			dct_icon = dct_spellId
			showType = "DCT_SHOWEXTRAATTACKS"
		end
	elseif fromPlayer then
		if suffixes == "DRAIN" or suffixes == "LEECH" then
			dct_amount,dct_powerType,dct_extraAmount = select(DCT_PREFIXES[prefixes],...)
			dct_icon = dct_spellId
			if dct_extraAmount then
				if dct_powerType >= 0 and dct_powerType <= 4 then
					dct_amount = dct_extraAmount

					showType = "DCT_SHOWPOWER"
				end
			end
		elseif suffixes == "CAST_SUCCESS" then
			if DCT_Get("DCT_SHOWSPELLSUCCESS").frame ~= 0 then
				if DCT_Get("DCT_SPECSPELLSUCCESS")[dct_spellName] then
					DCT_SpecSpellId = dct_spellId
					DCT_SpecSpellTime = GetTime()
				end
			end
		elseif suffixes == "MISSED" then
			dct_icon = dct_spellId
			if DCT_Get("DCT_SPECSPELLFAILED")[dct_spellName] then
				DCT_AddText("DCT_SHOWSPELLFAILED",1,false,nil)
			end
			if dct_spellId == DCT_SpecSpellId then
				DCT_SpecSpellId = 0
			end
		end
	end

	if DCT_Get("DCT_ScaleOnCrit") == 0 then crit = false;end

	if showType == nil and (fromPlayer or fromPet) then
		if DCTD_SetFixes then
			DCTD_SetFixes(prefixes,suffixes)
			if DCTD_ProcCombatUnfiltered(gevent, timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...) then
				return
			end
		end
	end

	if showType then DCT_AddText(showType,showId,crit,nil) end
end

local function RemoveHyperLinks(text)
	text = string.gsub(text, "|H.-|h(.-)|h", "%1")
	text = string.gsub(text, "|c%w%w%w%w%w%w%w%w(.-)|r", "%1")
	return text
end

local function CleanName(name)
	if name then
		local rname = select(1, string.split("-", RemoveHyperLinks(name)))
		return rname
	else
		return name
	end
end

--为DCT_Format函数注册额外的处理 part:两个字母的字串  func:处理函数指针
function DCT_Format_Register(part,func)
	if not DCT_FormatExPart[part] then
		DCT_FormatExPart[part] = func
	end
end

function DCT_GetEnTxt(txt)
	local len = string.len(txt)
	return string.upper(string.sub(txt,1,1))..string.lower(string.sub(txt,2,len))
end

--am:数值 sn:技能名 bt:格挡等类型 ms:miss类型 pt:power类型 ea:额外数值 et:环境类型 es:额外技能名 at:光环类型 oi:from hp: HP mp:MP
function DCT_Format(str,colorEx)
--colorEx: {{r,g,b},{r,g,b}}  r,g,b: 0~1
	if not str then return;end
	local len = string.len(str)
	if len < 1 then return;end
	local i,s,e,param,add,b
	local out = ""
	i = 0
	s = 1
	add = 1
	while i + add <= len do
		i = i + add
		b = string.byte(str,i)
		if b < 128 then
			add = 1
		else
			add = 3
		end
		if b == 35 then
			out = out..string.sub(str,s,i - 1)

			s = i + 3

			param = string.sub(str,i + 1,i + 2)
			if DCT_FormatExPart[param] then
				out = out..DCT_FormatExPart[param]()
			elseif param == "am" then
				if dct_amount then
					if dct_ssc_number and DCT_SPELLSCHOOL_TRAN[dct_spellSchool] then
						out = out..DCT_SpellSchoolColor(dct_spellSchool,dct_amount)
					else
						out = out..dct_amount
					end
				end
			elseif param == "sn" then
				if dct_spellName then
					if dct_ssc_spell and DCT_SPELLSCHOOL_TRAN[dct_spellSchool] then
						out = out..DCT_SpellSchoolColor(dct_spellSchool,dct_spellName)
					else
						out = out..dct_spellName
					end
				end
			elseif param == "bt" then
				if dct_patch_block then out = out..dct_patch_block;end
			elseif param == "ba" then
				if dct_patch_ba then out = out..dct_patch_ba;end
			elseif param == "ms" then
				if dct_missType then
					local ms
					if DCT_Get("DCT_EnglishInfo") == 1 then
						ms = DCT_GetEnTxt(dct_missType)
					else
						ms = getglobal(dct_missType)
					end
					out = out..ms
				end
			elseif param == "pt" then
				if dct_powerType then out = out..dct_powerType;end
			elseif param == "ss" then
				if dct_spellSchool and DCT_SPELLSCHOOL_TRAN[dct_spellSchool] then
					if dct_ssc_spellschool then
						local color = DCT_GenerateSpellSchoolColor(dct_spellSchool);
						out = out..DCT_ColorFlip(color[1],color[2],color[3])..DCT_SPELLSCHOOL_TRAN[dct_spellSchool][DCT_Get("DCT_EnglishInfo") + 1].."|r"
					else
						out = out..DCT_SPELLSCHOOL_TRAN[dct_spellSchool][DCT_Get("DCT_EnglishInfo") + 1]
					end
				end
			elseif param == "oh" then
				if dct_patch_oh then out = out..dct_patch_oh;end
			elseif param == "ea" then
				if dct_extraAmount then out = out..dct_extraAmount;end
			elseif param == "et" then
				if dct_environmentalType then
					if DCT_Get("DCT_EnglishInfo") == 1 then
						out = out..DCT_GetEnTxt(dct_environmentalType)
					else
						out = out..getglobal("ACTION_ENVIRONMENTAL_DAMAGE_".. string.upper(dct_environmentalType))
					end
				end
			elseif param == "em" then
				if dct_patch_em then out = out..dct_patch_em;end
			elseif param == "es" then
				if dct_extraSpellName then
					out = out..dct_extraSpellName
				end
			elseif param == "oi" then
				if dct_patch_oi then out = out..CleanName(dct_patch_oi);end
			elseif param == "hp" then
				out = out..UnitHealth("player")
			elseif param == "mp" then
				out = out..UnitPower("player")
			elseif param == "di" then
				if dct_patch_di then out = out..dct_patch_di;end
			elseif param == "cs" then
				if dct_spellSchool and DCT_SPELLSCHOOL_TRAN[dct_spellSchool] then
					local color = DCT_GenerateSpellSchoolColor(dct_spellSchool);
					out = out..DCT_ColorFlip(color[1],color[2],color[3])
				end
			elseif param == "c1" then
				out = out..DCT_ColorFlip(colorEx[1][1],colorEx[1][2],colorEx[1][3])
			elseif param == "c2" then
				out = out..DCT_ColorFlip(colorEx[2][1],colorEx[2][2],colorEx[2][3])
			elseif param == "ce" then
				out = out.."|r"
			elseif param == "ti" then
				local t = GetTime() - dct_combatTime
				if t > 0 then
					out = out..(floor(t)).."."..((floor(t * 10)) % 10)
				end
			else
				out = out..string.sub(str,i,i + 2)
			end

			i = i + 2
		end
	end

	if s <= len then
		out = out..string.sub(str,s,len)
	end
	return out
end

	--[[
	Prefixes

The Parameters listed with prefixes are numbered in the order they come after the base 8 parameters.
Prefix	1st Parameter	2nd Paramater	3rd Parameter
SWING
RANGE	dct_spellId	dct_spellName	dct_spellSchool
SPELL	dct_spellId	dct_spellName	dct_spellSchool
SPELL_PERIODIC	dct_spellId	dct_spellName	dct_spellSchool
ENVIRONMENTAL	dct_environmentalType
[edit] Suffixes

The Parameters listed with suffixes are numbered in the order they come after the prefix parameters.
Suffix	1st Param	2nd Param	3rd Param	4th Param	5th Param	6th Param	7th Param	8th Param
_DAMAGE	dct_amount	dct_school	dct_resisted	dct_blocked	dct_absorbed	dct_critical	dct_glancing	dct_crushing
_MISSED	dct_missType
_HEAL	dct_amount	dct_critical
_ENERGIZE	dct_amount	dct_powerType
_DRAIN	dct_amount	dct_powerType	dct_extraAmount
_LEECH	dct_amount	dct_powerType	dct_extraAmount
_INTERRUPT	extraSpellID	dct_extraSpellName	dct_extraSpellSchool
_DISPEL_FAILED	extraSpellID	dct_extraSpellName	dct_extraSpellSchool
_AURA_DISPELLED	extraSpellID	dct_extraSpellName	dct_extraSpellSchool	dct_auraType
_AURA_STOLEN	extraSpellID	dct_extraSpellName	dct_extraSpellSchool
_EXTRA_ATTACKS	dct_amount
_AURA_APPLIED	dct_auraType
_AURA_REMOVED	dct_auraType
_AURA_APPLIED_DOSE	dct_auraType	dct_amount
_AURA_REMOVED_DOSE	dct_auraType	dct_amount
_CAST_START
_CAST_SUCCESS
_CAST_FAILED	failedType
_INSTAKILL
_DURABILITY_DAMAGE
_DURABILITY_DAMAGE_ALL
_CREATE
_SUMMON
	]]
--传入Buff 名字，获得其index，如果返回0　说明失败
function DCT_GetBuffIndex(buffName)
	local index, untilCancelled
	for i = 1,40 do
		index, untilCancelled = GetPlayerBuff(i, "HELPFUL")
		if index > 0 and untilCancelled == 0 then
			if GetPlayerBuffName(index) == buffName then
				return index
			end
		end
	end
	return 0
end

function DCT_GetBuffTimeLeft(buffName)
	for i = 1,BUFF_MAX_DISPLAY do
		local name, _, _, _, _, expirationTime = UnitAura("player", i, "HELPFUL")
		if buffName == name then
			if expirationTime then
				return expirationTime - GetTime()
			else
				return 0
			end
		end
	end
	return 0
end

function DCT_AddBuffFadeRecord(spellName,per)
	local i

	for i = 1,DCT_BuffFadeC do
		if DCT_BuffFadeList[i].spellName == spellName then return;end
	end
	--检查当前Buff列表是否存在对应的spellName
	DCT_BuffFadeC = DCT_BuffFadeC + 1
	DCT_BuffFadeList[DCT_BuffFadeC] = {}
	local p = DCT_BuffFadeList[DCT_BuffFadeC]
	p.init = 0
	p.icon = dct_icon
	p.spellName = spellName
	p.castStartTime = GetTime()
	p.per = per
end

function DCT_DeleteBuffFadeRecord(tid)
	table.remove(DCT_BuffFadeList,tid)
	DCT_BuffFadeC = table.getn(DCT_BuffFadeList)
end

function DCT_ProcBuffFadeRecord()
	local i,p
	local altime = 0
	for i = 1,DCT_BuffFadeC do
		p = DCT_BuffFadeList[i]
		altime = DCT_Get("DCT_SHOWSPECBUFFFADE").per
		if p.init == 0 then
			if GetTime() - p.castStartTime > 2 then
				DCT_DeleteBuffFadeRecord(i)
				return
			end
			local timeleft = DCT_GetBuffTimeLeft(p.spellName)
			if timeleft ~= 0 then
				if timeleft < 181 and timeleft > 3 then
					p.castStartTime = GetTime()
					p.casttime = timeleft
					p.init = 1
				else
					DCT_DeleteBuffFadeRecord(i)
				end
				return
			end
		elseif p.init == 1 then
			if p.casttime - GetTime() + p.castStartTime < altime then
				--再检查一次是否真的到了倒计时时间,如果距离倒计时时间还很远，那么重置init，让其重新更新
				local timeleft = DCT_GetBuffTimeLeft(p.spellName)
				if timeleft ~= 0 then
					if timeleft - altime < 0.5 then
						dct_icon = p.icon
						dct_spellName = p.spellName
						DCT_SSC_Format_DisableAll()
						--确实开始计时
						local obj = nil
						if DCT_Get("DCT_SHOWSPECBUFFFADE").frame ~= 0 and DCT_Get("DCT_SPECBUFFFADE")[p.spellName] then
							obj = DCT_AddText("DCT_SHOWSPECBUFFFADE",2,false,nil)
						else
							obj = DCT_AddText("DCT_SHOWBUFFFADE",2,false,nil)
						end
						if obj then
							obj.castStartTime = p.castStartTime
							obj.castTime = p.casttime
							obj.altime = altime
							if DCT_Player["DCT_UseCastBar"] == 1 then
								DCT_Ani_ObjAddCastbar(obj)
							else
								DCT_Ani_ObjAddExtraText(obj)
								obj.extraTextP:SetTextColor(1,1,1)
							end
							obj.funcOther = DCT_ObjectCastTimeProc
						end
						p.init = 2
					else
						p.init = 0
						p.castStartTime = GetTime()
					end
				else
					DCT_DeleteBuffFadeRecord(i)
					return
				end
			end
		elseif p.init == 2 then
			--计时到时了，如果Buff的确接近消失，则删除，否则说明Buff被重新更新了时间
			if p.casttime - GetTime() + p.castStartTime <= 0 then
				local timeleft = DCT_GetBuffTimeLeft(p.spellName)
				if timeleft ~= 0 then
					if timeleft > 2 then
						--到这里说明Buff时间被更新过增加了
						p.init = 0
						p.castStartTime = GetTime()
					else
						DCT_DeleteBuffFadeRecord(i)
						return
					end
				else
					DCT_DeleteBuffFadeRecord(i)
					return
				end
			else

			end

		end
	end
end

function DCT_ObjectCastTimeProc(obj)
	local ctime = obj.castTime - GetTime() + obj.castStartTime
	if obj.castbarP then
		DCT_CastBar_Setup(obj.castbarP,ctime / obj.altime,{1,1,0})
	else
		if ctime <= 0 then
			obj.extraTextP:SetText("-:-")
		else
			obj.extraTextP:SetText(floor(ctime)..":"..floor((ctime - floor(ctime))* 10))
			if ctime < 1 then obj.extraTextP:SetTextColor(1,0,0);end
		end
	end
end

function DCT_GameUpdate()
	if DCT_BuffFadeC > 0 then
		DCT_ProcBuffFadeRecord()
	end
	if DCT_SpecSpellId ~= 0 then
		if GetTime() - DCT_SpecSpellTime > 0.25 then
			DCT_SSC_Format_DisableAll()
			dct_spellId = DCT_SpecSpellId
			dct_spellName = select(1,GetSpellInfo(dct_spellId))
			dct_icon = dct_spellId
			DCT_AddText("DCT_SHOWSPELLSUCCESS",1,false,nil)
			DCT_SpecSpellId = 0
		end
	end
	DCT_CooldownOnUpdata()

	DCT_EBox_UpdataEvent()

	DCT_Ani_FrameUpdata()
end

local DCT_HEX_LIST = {"0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f","f"}
local function DCT_ToHEX(a)
	if a < 0 then a = 0;end
	if a > 1 then a = 1;end
	local a = a * 255;
	return ""..DCT_HEX_LIST[floor(a / 16) + 1]..DCT_HEX_LIST[floor(a % 16) + 1];
end

function DCT_ColorFlip(r,g,b)
	return "|cff"..DCT_ToHEX(r)..DCT_ToHEX(g)..DCT_ToHEX(b);
end
