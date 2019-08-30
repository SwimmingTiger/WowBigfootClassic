
DCTSA_InitOk = false
DCTSA_GDB = nil
DCTSA_DB = nil

local DCTSA_BUFFERMAX = 30
local DCT_sa_caststartLogFlag = 0
local DCT_sa_caststartLog = {
	{objp = nil},
	{objp = nil},
	{objp = nil},
	{objp = nil},
	{objp = nil},
	{objp = nil},
	{objp = nil},
	{objp = nil},
	{objp = nil},
	{objp = nil},
}

local DCT_sa_castsuccessLogFlag = 0
local DCT_sa_castsuccessLog = {};

DCTSA_DEFAULT_GLOBAL_CONFIG = {
	["DCTSA_SAVEDATA_VER"] = 2001,

	["DCTSA_FILTER_CASTSTART"] = {filt = {},buffer = {}},
	["DCTSA_FILTER_BUFF"] = {filt = {},buffer = {}},
	["DCTSA_FILTER_DISPELLED"] = {filt = {},buffer = {}},
	["DCTSA_FILTER_CASTSUCCESS"] = {filt = {},buffer = {}},
	["DCTSA_FILTER_CASTSTART_SORT"] = {filt = {},buffer = {}},
	["DCTSA_FILTER_BUFF_SORT"] = {filt = {},buffer = {}},
	["DCTSA_FILTER_DISPELLED_SORT"] = {filt = {},buffer = {}},
	["DCTSA_FILTER_CASTSUCCESS_SORT"] = {filt = {},buffer = {}},
	["PROFILE"] = {},
}

--Blizzard APi calls
local UnitName = UnitName
local UnitGUID = UnitGUID
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime

function DCTSA_AddCaststartLog(objp,spellId,sourceGUID)
	DCT_sa_caststartLogFlag = DCT_sa_caststartLogFlag + 1
	if DCT_sa_caststartLogFlag > table.getn(DCT_sa_caststartLog) then DCT_sa_caststartLogFlag = 1;end
	DCT_sa_caststartLog[DCT_sa_caststartLogFlag].objp = objp
	DCT_sa_caststartLog[DCT_sa_caststartLogFlag].spellId = spellId
	DCT_sa_caststartLog[DCT_sa_caststartLogFlag].sourceGUID = sourceGUID
	DCT_sa_caststartLog[DCT_sa_caststartLogFlag].uid = objp.uid
end

function DCTSA_RefreshCaststartLog(text,color,spellId,sourceGUID)
	local i,p
	for i = 1,10 do
		p = DCT_sa_caststartLog[i]
		if p.objp then
			if not p.objp.active then
				p.objp = nil
			else
				if sourceGUID == p.sourceGUID and spellId == p.spellId then
					if p.objp.uid == p.uid then
						DCT_Ani_ObjSetExtraTextFont(p.objp,false)
						p.objp.extraTextP:SetTextColor(color[1],color[2],color[3])
						p.objp.extraTextP:SetText(text)
						p.objp.funcOther = nil
						if p.objp.castbarP then
							DCT_Ani_CastbarFree(p.objp.castbarP)
							p.objp.castbarP = nil
						end
						return
					end
				end
			end
		end
	end
end

function DCTSA_AddCastsuccessLog(objp,spellName,destGUID)
	DCT_sa_castsuccessLogFlag = DCT_sa_castsuccessLogFlag + 1
	if DCT_sa_castsuccessLogFlag > 5 then DCT_sa_castsuccessLogFlag = 1;end
	if not DCT_sa_castsuccessLog[DCT_sa_castsuccessLogFlag] then DCT_sa_castsuccessLog[DCT_sa_castsuccessLogFlag] = {};end
	DCT_sa_castsuccessLog[DCT_sa_castsuccessLogFlag].objp = objp
	DCT_sa_castsuccessLog[DCT_sa_castsuccessLogFlag].spellName = spellName
	DCT_sa_castsuccessLog[DCT_sa_castsuccessLogFlag].destGUID = destGUID
	DCT_sa_castsuccessLog[DCT_sa_castsuccessLogFlag].uid = objp.uid
	DCT_sa_castsuccessLog[DCT_sa_castsuccessLogFlag].stime = GetTime()
end

function DCTSA_SearchCastsuccessLog(spellName,destGUID)
	local i,p
	local ctime = GetTime()
	for i = 1,10 do
		if DCT_sa_castsuccessLog[i] then
			p = DCT_sa_castsuccessLog[i]
			if destGUID == p.destGUID then
				if ctime - p.stime < 0.2 and spellName == p.spellName then
					if p.objp.uid == p.uid then
						return p.objp
					end
				end
			end
		end
	end
end

function DCTSA_Init()
	if DCTSA_InitOk then return;end

	if DCTSA_PERCONFIG and (not DCTSA_PERCONFIG["DCTSA_SAVEDATA_VER"] or DCTSA_PERCONFIG["DCTSA_SAVEDATA_VER"] < DCTSA_DEFAULT_CONFIG["DCTSA_SAVEDATA_VER"]) then
		DCTSA_PERCONFIG = nil
		DCTSA_PERCONFIG = DCT_clone(DCTSA_DEFAULT_CONFIG)
	end

	if not DCTSA_PERCONFIG or type(DCTSA_PERCONFIG) ~= "table" then
		DCTSA_PERCONFIG = nil
		DCTSA_PERCONFIG = DCT_clone(DCTSA_DEFAULT_CONFIG)
	end
	if not DCTSA_CONFIG or type(DCTSA_CONFIG) ~= "table" then
		DCTSA_CONFIG = nil
		DCTSA_CONFIG = {}
		DCTSA_CONFIG["DCTSA_SAVE"] = DCT_clone(DCTSA_DEFAULT_GLOBAL_CONFIG)
	end
	DCTSA_DB = DCTSA_PERCONFIG
	DCTSA_GDB = DCTSA_CONFIG["DCTSA_SAVE"]

	DCT_DataFix(DCTSA_DB,DCTSA_DEFAULT_CONFIG)
	DCT_DataFix(DCTSA_GDB,DCTSA_DEFAULT_GLOBAL_CONFIG)
	DCT_DataShowParamFix(DCTSA_DB,DCTSA_DEFAULT_CONFIG)
	DCT_DataShowParamFix(DCTSA_GDB,DCTSA_DEFAULT_GLOBAL_CONFIG)

	DCT_RegistModOptionButton("DCT_Opsa_RegistButton")

	DCTSA_InitOk = true
end

function DCTSA_OnLoad(self)
	self:SetParent(DCT_Options)
	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function DCTSA_ProcCombatUnfiltered(gevent, timestamp, combatevent, hideCaster,  sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)
	if not DCTSA_InitOk then return end
	if DCTSA_DB["DCTSA_ENABLE"] == 0 then return end
	if DCTSA_DB["DCTSA_ENABLE_ONCOMBAT"] == 1 and not dct_inCombat then return end

	local isSourceEnemy = (bit.band(sourceFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE)
	local isDestEnemy = (bit.band(destFlags, COMBATLOG_OBJECT_REACTION_HOSTILE) == COMBATLOG_OBJECT_REACTION_HOSTILE)
	if not isDestEnemy and not isSourceEnemy then return end

	local showType = nil
	local showId = 1
	local re = false
	local needTimer = false

	local isSourceFocus = (bit.band(sourceFlags, COMBATLOG_OBJECT_FOCUS) == COMBATLOG_OBJECT_FOCUS)
	local isDestFocus = (bit.band(destFlags, COMBATLOG_OBJECT_FOCUS) == COMBATLOG_OBJECT_FOCUS)

	if DCTSA_DB["DCTSA_ENABLE_ONPVP"] == 1 then
		--local pvpType, isFFA, faction = GetZonePVPInfo()
		local pvpType = select(1,GetZonePVPInfo())
		if (--[[pvpType == "friendly" or]]pvpType == "sanctuary") then return end
	end

	local dct_spellId, dct_spellName, dct_spellSchool
	if combatevent == "SPELL_INTERRUPT" then
		local dct_extraSpellID,dct_extraSpellName = select(4,...)
		DCTSA_RefreshCaststartLog(INTERRUPTED,{0,1,0},dct_extraSpellID,destGUID)
		return
	end

	if combatevent == "SPELL_CAST_START" then
		if isSourceEnemy then
			dct_spellId, dct_spellName, dct_spellSchool = select(1,...)
			if DCTSA_FilterPass("DCTSA_FILTER_CASTSTART",dct_spellName) then
				dct_patch_oi = sourceName
				dct_icon = select(3, GetSpellInfo(dct_spellId))

				if isSourceFocus then
					showType = "DCTSA_SHOW_CASTSTART_FOCUS"
				elseif sourceGUID == UnitGUID("target") then
					showType = "DCTSA_SHOW_CASTSTART_YOURTARGET"
				else
					showType = "DCTSA_SHOW_CASTSTART"
				end
				DCTSA_FilterAddSmart("DCTSA_FILTER_CASTSTART",dct_spellName)
				needTimer = true
			end
		end
		re = true
	elseif combatevent == "SPELL_CAST_SUCCESS" then
		if isSourceEnemy then
			if DCTSA_DB["DCTSA_CASTSUCCESS_ONLYTOYOU"] == 1 and destGUID ~= UnitGUID("player") then
				return true
			end
			dct_spellId, dct_spellName, dct_spellSchool = select(1,...)
			if DCTSA_FilterPass("DCTSA_FILTER_CASTSUCCESS",dct_spellName) then
				dct_patch_oi = sourceName
				if CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MINE) then
					dct_patch_di = DCT_SA_YOU
				elseif sourceGUID == destGUID then
					dct_patch_di = DCT_SA_SELF
				else
					dct_patch_di = destName
				end
				dct_icon = select(3, GetSpellInfo(dct_spellId))

				if isSourceFocus then
					showType = "DCTSA_SHOW_CASTSUCCESS_FOCUS"
				elseif sourceGUID == UnitGUID("target") then
					showType = "DCTSA_SHOW_CASTSUCCESS_YOURTARGET"
				else
					showType = "DCTSA_SHOW_CASTSUCCESS"
				end
				DCTSA_FilterAddSmart("DCTSA_FILTER_CASTSUCCESS",dct_spellName)
			end
		end
	elseif combatevent == "SPELL_AURA_APPLIED" and isDestEnemy and select(4,...) == "BUFF" then
		dct_spellId, dct_spellName, dct_spellSchool = select(1,...)
		if DCTSA_FilterPass("DCTSA_FILTER_BUFF",dct_spellName) then
			dct_patch_oi = destName
			dct_icon = select(3, GetSpellInfo(dct_spellId))
			if isDestFocus then
				showType = "DCTSA_SHOW_BUFFGET_FOCUS"
			elseif destGUID == UnitGUID("target") then
				showType = "DCTSA_SHOW_BUFFGET_YOURTARGET"
			else
				showType = "DCTSA_SHOW_BUFFGET"
			end
			DCTSA_FilterAddSmart("DCTSA_FILTER_BUFF",dct_spellName)
		end
		re = true
	elseif combatevent == "SPELL_AURA_REMOVED" and isDestEnemy and select(4,...) == "BUFF" then
		dct_spellId, dct_spellName, dct_spellSchool = select(1,...)
		if DCTSA_FilterPass("DCTSA_FILTER_BUFF",dct_spellName) then
			dct_patch_oi = destName
			dct_icon = select(3, GetSpellInfo(dct_spellId))
			showType = "DCTSA_SHOW_BUFFFADE"
			if isDestFocus then
				showType = "DCTSA_SHOW_BUFFFADE_FOCUS"
			elseif destGUID == UnitGUID("target") then
				showType = "DCTSA_SHOW_BUFFFADE_YOURTARGET"
			else
				showType = "DCTSA_SHOW_BUFFFADE"
			end
			DCTSA_FilterAddSmart("DCTSA_FILTER_BUFF",dct_spellName)
		end
		re = true
	elseif combatevent == "SPELL_DISPEL" and isDestEnemy then
		dct_spellId, dct_spellName, dct_spellSchool = select(4,...)
		if DCTSA_FilterPass("DCTSA_FILTER_DISPELLED",dct_spellName) then
			dct_patch_oi = destName
			dct_icon = select(3, GetSpellInfo(dct_spellId))
			showType = "DCTSA_SHOW_DISPELLED"
			if isSourceFocus then
				showType = "DCTSA_SHOW_DISPELLED_FOCUS"
			elseif sourceGUID == UnitGUID("target") then
				showType = "DCTSA_SHOW_DISPELLED_YOURTARGET"
			else
				showType = "DCTSA_SHOW_DISPELLED"
			end
			DCTSA_FilterAddSmart("DCTSA_FILTER_DISPELLED",dct_spellName)
		end
		if sourceGUID == UnitGUID("player") then
			re = false
		else
			re = true
		end
	end

	if showType then
		if DCTSA_DB["DCTSA_SSC_Spell"] == 1 then
			DCT_SSC_Format_EnableAll()
		else
			DCT_SSC_Format_DisableAll()
		end
		if string.sub(showType,12,18) == "BUFFGET" and DCTSA_DB["DCTSA_MERGE_CASTSUCCESS_AND_BUFFGET"] == 1 then
			--如果之前有怪物对同一个目标有同名的“施放了”技能，则覆盖那次"施放了"的文字
			local obj = DCTSA_SearchCastsuccessLog(dct_spellName,destGUID)
			if obj then
				DCT_SetText(showType,showId,false,DCTSA_DB,obj)
				return true
			end
		end
		local obj = DCT_AddText(showType,showId,false,DCTSA_DB)
		if obj and needTimer then
			obj.castStartTime = GetTime()
			-- local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(spellId or spellName or spellLink)
			obj.castTime = (select(4,GetSpellInfo(dct_spellId)) or 0) / 1000
			obj.SpellId = dct_spellId
			obj.sourceGUID = sourceGUID
			--为obj增加一个计时的text
			DCT_Ani_ObjAddExtraText(obj)

			obj.extraTextP:SetTextColor(1,1,1)
			obj.funcOther = DCTSA_ObjectCastTimeProc
			DCTSA_AddCaststartLog(obj,dct_spellId,sourceGUID)

			if DCT_Player["DCT_UseCastBar"] == 1 then
				DCT_Ani_ObjAddCastbar(obj)
				if obj.castbarP then
					DCT_CastBar_Setup(obj.castbarP,0,DCT_GenerateSpellSchoolColor(dct_spellSchool))
				end
			end
		end
		if obj and string.sub(showType,12,22) == "CASTSUCCESS" then
			DCTSA_AddCastsuccessLog(obj ,dct_spellName,destGUID)
		end
		return re
	end
	return re
end

function DCTSA_ObjectCastTimeProc(obj)
	if DCTSA_DB["DCTSA_CASTTIME"] ~= 1 then return;end
	local ctime = obj.castTime - GetTime() + obj.castStartTime
	if obj.castTime ==0 then
		obj.castTime=1
	end
	if obj.castbarP then
		DCT_CastBar_Setup(obj.castbarP,1 - ctime / obj.castTime)
	else
		if ctime <= 0 then
			obj.extraTextP:SetText("-:-")
		else
			obj.extraTextP:SetText(floor(ctime)..":"..floor((ctime - floor(ctime))* 10))
			if ctime < 1 then obj.extraTextP:SetTextColor(1,0,0);end
		end
	end
end

--如果不存在则增加，如果存在则设置新值
function DCTSA_BufferSet(saType,spellId,val)
	if not DCTSA_GDB[saType].buffer[spellId] then
		local fp = DCTSA_GDB[saType].buffer
		local ip = DCTSA_GDB[saType.."_SORT"].buffer
		fp[spellId] = val
		table.insert(ip,1,spellId)
		local c = table.getn(ip)
		if  c > DCTSA_BUFFERMAX then
			fp[ip[c]] = nil
			ip[c] = nil
		end
	else
		DCTSA_GDB[saType].buffer[spellId] = val
	end
end

function DCTSA_FiltSet(saType,spellId,val)
	if not DCTSA_GDB[saType].filt[spellId] then
		local fp = DCTSA_GDB[saType].filt
		local ip = DCTSA_GDB[saType.."_SORT"].filt
		fp[spellId] = val
		table.insert(ip,1,spellId)
	else
		DCTSA_GDB[saType].filt[spellId] = val
	end
end

function DCTSA_BufferDelete(saType,spellId)
	if DCTSA_GDB[saType].buffer[spellId] then
		local fp = DCTSA_GDB[saType].buffer
		local ip = DCTSA_GDB[saType.."_SORT"].buffer
		fp[spellId] = nil
		local c = table.getn(ip)
		for i = 1,c do
			if ip[i] == spellId then
				table.remove(ip,i)
				return
			end
		end
	end
end

function DCTSA_FiltDelete(saType,spellId)
	if DCTSA_GDB[saType].filt[spellId] then
		local fp = DCTSA_GDB[saType].filt
		local ip = DCTSA_GDB[saType.."_SORT"].filt
		fp[spellId] = nil
		local c = table.getn(ip)
		local i
		for i = 1,c do
			if ip[i] == spellId then
				table.remove(ip,i)
				return
			end
		end
	end
end

function DCTSA_FilterAddSmart(saType,spellId)
	if DCTSA_FilterAdd(saType,spellId) then
		if DCTSA_DB["DCTSA_FILTER_MODE"] == 1 then
			DCTSA_FilterMoveTofilt(saType,spellId)
		end
	end
end

function DCTSA_FilterAdd(saType,spellId)
	if DCTSA_DB["DCTSA_FILTER_ENABLE"] == 0 then return false;end
	if not DCTSA_GDB[saType].buffer[spellId] and not DCTSA_GDB[saType].filt[spellId] then
		DCTSA_BufferSet(saType,spellId,0)
		return true
	end
	return false
end

function DCTSA_FilterPass(saType,spellId)
	if DCTSA_DB["DCTSA_FILTER_ENABLE"] == 0 then return true;end

	if DCTSA_DB["DCTSA_FILTER_MODE"] == 0 then
		if DCTSA_GDB[saType].filt[spellId] then
			return false
		else
			return true
		end
	else
		if DCTSA_GDB[saType].filt[spellId] then
			return true
		else
			return false
		end
	end
end

function DCTSA_FilterMoveTofilt(saType,spellId)
	if not DCTSA_GDB[saType].buffer[spellId] then
		return
	else
		DCTSA_BufferDelete(saType,spellId)
		DCTSA_FiltSet(saType,spellId,1)
	end
end

function DCTSA_FilterMoveToBuffer(saType,spellId)
	if not DCTSA_GDB[saType].filt[spellId] then
		return
	else
		DCTSA_FiltDelete(saType,spellId)
		DCTSA_BufferSet(saType,spellId,0)
	end
end

--[[
API GetSpellInfo
From WoWWiki
Jump to: navigation, search
Main Menu
WoW API
Widget API
Lua functions
User Functions
Events
Changes

--------------------------------------------------------------------------------

HOWTOs
UI Tech.
XML UI

--------------------------------------------------------------------------------

Category nav.


→ WoW APIGet information about a spell.

name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange
= GetSpellInfo(spellId or spellName or spellLink)



Arguments
(spellId or spellName or spellLink
spellId
Integer - The global spell number, found on wowhead or through COMBAT_LOG_EVENT.
spellName
String - The Name of the spell.
spellLink
String - The formatted link to the spell



Returns
name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange
name
String - The name of the spell.
rank
String - The rank of the spell. Returns as an empty string if there is no rank.
icon
String - The interface path to the icon texture.
cost
Number - The cost of the spell in Mana/Rage/Energy/Focus.
isFunnel
Boolean - Returns true if the spell is a health funnel effect. Returns false 99% of the time.
powerType
Number - The power type required:
0 for Mana
1 for Rage
2 for Focus (hunter pets)
3 for Energy
4 for Happiness
castTime
Number - The cast time, in milliseconds.
minRange
Number - The minimum range of the spell.
maxRange
Number - The maximum range of the spell.
]]
