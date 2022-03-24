local DEFINE_AOE_SEARCH_DELAY = 0.2
DCTD_InitOk = false
DCTD_DB = nil
DCTD_GDB = nil

local dctd_formatpart_hits = 0
local dctd_formatpart_crits = 0

local dctd_aoeBuffer = {}

local dctd_aoeFlag = 0

local dctd_prefixes,dctd_suffixes

--Blizzard APi calls
local UnitHealth = UnitHealth
local UnitHealthMax = UnitHealthMax
local UnitName = UnitName
local UnitGUID = UnitGUID
local GetSpellInfo = GetSpellInfo

function DCTD_SearchAoe(damage,spellName,destId,isCrit)
	local k,v
	local t = GetTime()
	for k,v in pairs(dctd_aoeBuffer) do
		if v.spellName == spellName then
			if t - v.stime < DEFINE_AOE_SEARCH_DELAY then
				--如果是同一个目标，则伤害叠加
				local isAoe = false
				local redm = 0
				v.num = v.num + 1
				v.stime = t
				if isCrit then v.crits = v.crits + 1;end
				if destId == v.destId then
					--dct_amount = dct_amount + v.damage
					v.damage = dct_amount + v.damage
					redm = v.damage
				else--如果是不同目标，则伤害平均化
					v.damage = dct_amount + v.damage
					--dct_amount = floor(v.damage / v.num).." ("..v.num..DCTD_TEXT_AOECOUNT..")"
					if DCTD_DB["DCTD_AvgMulitHit"] == 1 then
						redm = floor(v.damage / v.num)
					else
						redm = v.damage
					end
					isAoe = true
				end
				return v,redm,isAoe
			end
		end
	end
	return nil
end

function DCTD_AddAoe(damage,spellName,spellId,spellSchool,destId,crit,eid,euid)
	local k,v
	local t = GetTime()
	for k,v in pairs(dctd_aoeBuffer) do
		if v.spellName == spellName and t - v.stime < 0.6 then
			return
		end
	end
	dctd_aoeFlag = dctd_aoeFlag + 1
	if dctd_aoeFlag > 5 then dctd_aoeFlag = 1;end
	if not dctd_aoeBuffer[dctd_aoeFlag] then dctd_aoeBuffer[dctd_aoeFlag] = {};end
	local p = dctd_aoeBuffer[dctd_aoeFlag]
	p.spellName = spellName
	p.spellId = spellId
	p.spellSchool = spellSchool
	p.stime = t
	p.destId = destId
	p.eid = eid
	p.euid = euid
	p.damage = damage
	p.num = 1
	if crit then
		p.crits = 1
	else
		p.crits = 0
	end
end

function DCTD_Init(self)
	if DCTD_InitOk then return;end
	if not DCTD_PERCONFIG or type(DCTD_PERCONFIG) ~= "table" then
		DCTD_PERCONFIG = nil
		DCTD_PERCONFIG = DCT_clone(DCTD_DEFAULT_CONFIG)
	end
	if not DCTD_CONFIG or type(DCTD_CONFIG) ~= "table" then
		DCTD_CONFIG = nil
		DCTD_CONFIG = {}
	end
	DCTD_DB = DCTD_PERCONFIG
	DCTD_GDB = DCTD_CONFIG
	DCT_DataFix(DCTD_DB,DCTD_DEFAULT_CONFIG)
	DCT_DataShowParamFix(DCTD_DB,DCTD_DEFAULT_CONFIG)

	DCT_Format_Register("ht",DCTD_FormatParam1)
	DCT_RegistModOptionButton("DCTD_RegistButton")
	DCTD_InitOk = true
end

function DCTD_OnLoad(self)
	self:SetParent(DCT_Options)
	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function DCTD_FormatParam1()
	if dctd_formatpart_crits > 0 then
		return dctd_formatpart_hits.." hits "..dctd_formatpart_crits.." crits"
	else
		return dctd_formatpart_hits.." hits"
	end
end

function DCTD_SetFixes(prefixes,suffixes)
	dctd_prefixes = prefixes
	dctd_suffixes = suffixes
	if dctd_prefixes == "DAMAGE" then
		dctd_prefixes = "SPELL"
		if dctd_suffixes == "SHIELD_MISSED" then
			dctd_suffixes = "MISSED"
		else
			dctd_suffixes = "DAMAGE"
		end
	end
end
local DCT_PREFIXES = {
		["SWING"] = 1,
		["RANGE"] = 4,
		["SPELL"] = 4,
		["SPELL_PERIODIC"] = 4,
		["ENVIRONMENTAL"] = 2,
		["DAMAGE"] = 4,
}

function DCTD_SSC_Format_Enable()
	if DCTD_DB["DCTD_SSC_Number"] == 1 then dct_ssc_number = true;end
	if DCTD_DB["DCTD_SSC_SpellSchool"] == 1 then dct_ssc_spellschool = true;end
	if DCTD_DB["DCTD_SSC_Spell"] == 1 then dct_ssc_spell = true;end
end

function DCTD_ProcCombatUnfiltered(gevent, timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceFlags2, destGUID, destName, destFlags, destFlags2, ...)
	if not DCTD_InitOk then return false;end
	if DCTD_DB["DCTD_ENABLE"] == 0 then return false;end

	local showType = nil
	local showId = 1
	local crit = false
	local aoeFix = false

	local fromPlayer,toPlayer,fromPet
	fromPlayer = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE)
	fromPet = CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MY_PET)
    toPlayer = CombatLog_Object_IsA(destFlags, COMBATLOG_FILTER_MINE)

	DCT_SSC_Format_DisableAll()

	dct_patch_di = destName
	if dctd_suffixes == "DAMAGE" then
		if toPlayer then return false;end
		dct_amount, dct_over, dct_school, dct_resisted, dct_blocked, dct_absorbed, dct_critical, dct_glancing, dct_crushing = select(DCT_PREFIXES[dctd_prefixes],...)
		if dctd_prefixes == "SWING" then
			showType = "DCTD_SHOWHIT"
		elseif dctd_prefixes == "RANGE" then
			showType = "DCTD_SHOWHIT"
			dct_icon = dct_spellId
			DCTD_SSC_Format_Enable()
			aoeFix = true
		elseif dctd_prefixes == "SPELL"then
			showType = "DCTD_SHOWSPELL"
			dct_icon = dct_spellId
			DCTD_SSC_Format_Enable()
			aoeFix =  true
		elseif dctd_prefixes == "SPELL_PERIODIC" then
			showType = "DCTD_SHOWPERIODIC"
			dct_icon = dct_spellId
			DCTD_SSC_Format_Enable()
			aoeFix = true
		end

		DCT_ProcBlock()
		if dct_patch_block then
			showId = 2
		end
		if dct_amount ~= 0 then
			if dct_critical and showType then
				crit = true
				if showType ~= "DCTD_SHOWPERIODIC" then
					if DCTD_DB[showType.."CRIT"].frame ~= 0 then
						showType = showType.."CRIT"
					end
				end
			end
		else
			showType = "DCTD_SHOWMISS"
			if dctd_prefixes == "SPELL" or dctd_prefixes == "SPELL_PERIODIC" then
				showId = 2
				dct_icon = dct_spellId
			end
		end
	elseif dctd_suffixes == "MISSED" then
		dct_missType = select(DCT_PREFIXES[dctd_prefixes],...)
		if dctd_prefixes == "SPELL" or dctd_prefixes == "SPELL_PERIODIC" then
			showId = 2
			dct_icon = dct_spellId
			DCTD_SSC_Format_Enable()
		end
		showType = "DCTD_SHOWMISS"
	elseif dctd_suffixes == "SHIELD" then
		if dctd_prefixes == "DAMAGE" then
			dct_amount, dct_over, dct_school, dct_resisted, dct_blocked, dct_absorbed, dct_critical, dct_glancing, dct_crushing = select(DCT_PREFIXES[dctd_prefixes],...)
			dct_icon = dct_spellId
			showType = "DCTD_SHOWSHIELD"
		end
	elseif dctd_suffixes == "SPLIT" then
		if dctd_prefixes == "DAMAGE" then
			dct_amount, dct_over, dct_school, dct_resisted, dct_blocked, dct_absorbed, dct_critical, dct_glancing, dct_crushing = select(DCT_PREFIXES[dctd_prefixes],...)
			dct_icon = dct_spellId
			DCTD_SSC_Format_Enable()
			aoeFix =  true
			showType = "DCTD_SHOWSPELL"

			DCT_ProcBlock()
			if dct_patch_block then
				showId = 2
			end
			if dct_amount ~= 0 then
				if dct_critical then
					crit = true
					if DCTD_DB[showType.."CRIT"].frame ~= 0 then
						showType = "DCTD_SHOWSPELLCRIT"
					end
				end
			else
				showType = "DCTD_SHOWMISS"
				showId = 2
				dct_icon = dct_spellId
			end
		end
	elseif dctd_suffixes == "HEAL" then
		--if toPlayer then return false;end
		dct_amount, dct_over,dct_absorbed,dct_critical = select(DCT_PREFIXES[dctd_prefixes],...)
		showType = "DCTD_SHOWHEAL"
		if dctd_prefixes == "SPELL_PERIODIC" then
			showType = "DCTD_SHOWPERIODICHEAL"
		else
			aoeFix = true
		end
		dct_icon = dct_spellId

		--过量治疗处理
		if dct_over ~= 0 then
			--存在过量治疗
			dct_patch_oh = dct_over
			dct_amount = dct_amount - dct_over
			showId = 2
		end

		if dct_critical then
			crit = true
			if showType == "DCTD_SHOWHEAL" then
				if DCTD_DB[showType.."CRIT"].frame ~= 0 then
					showType = showType.."CRIT"
				end
			end
		end
	elseif dctd_suffixes == "INTERRUPT" then
		dct_spellId, dct_spellName, dct_spellSchool = select(DCT_PREFIXES[dctd_prefixes],...);
		dct_icon = dct_spellId
		showType = "DCTD_SHOWINTERRUPT"
	elseif dctd_suffixes == "DISPEL" then
		dct_spellId, dct_spellName, dct_spellSchool = select(DCT_PREFIXES[dctd_prefixes],...);
		dct_icon = dct_spellId
		showId = 2
		showType = "DCTD_SHOWINTERRUPT"
	end

	if DCTD_DB["DCTD_CritScale"] == 0 then crit = false;end

	if fromPet then
		if showType then showType = showType.."_PET";end
	end

	if showType and DCTD_DB[showType] and DCTD_DB[showType].per then
		if dct_amount < DCTD_DB[showType].per then showType = nil;end
	end

	if fromPet then
		if showType then
			DCT_AddText(showType,showId,crit,DCTD_DB)
		end
	else
		local eId,eUID
		if showType == "DCTD_SHOWSPELL" or showType == "DCTD_SHOWSPELLCRIT" then
			local p,d,isAoe
			local tmpShowType
			p,d,isAoe = DCTD_SearchAoe(dct_amount,dct_spellName,destGUID,dct_critical)
			if p then
				if isAoe then
					tmpShowType = "DCTD_SHOWAOE"
				elseif (p.crits > 0 or dct_critical) then
					tmpShowType = "DCTD_SHOWCOMBOHITCRIT"
				else
					tmpShowType = "DCTD_SHOWCOMBOHIT"
				end
				if DCTD_DB[tmpShowType].frame ~= 0  then
					dct_amount = d
					dct_spellName = p.spellName
					dct_icon = p.spellId
					dct_spellSchool = p.spellSchool
					dctd_formatpart_hits = p.num
					dctd_formatpart_crits = tonumber(p.crits)
					DCTD_SSC_Format_Enable()

					DCT_EBox_Lock()

					local ep = DCT_EBox_GetEventP(p.eid,p.euid)
					if ep then
						if tmpShowType == "DCTD_SHOWAOE" then
							ep.cr = false
						else
							ep.cr = p.crits or dct_critical
						end
						ep.ty = tmpShowType
						ep.tx = DCT_GetFormatText(tmpShowType,1,DCTD_DB)
					end

					DCT_Ebox_UnLock()
					return true
				end
			end
		end
		if showType == "DCTD_SHOWHEAL" or showType == "DCTD_SHOWHEALCRIT" then
			local p,d
			p,d = DCTD_SearchAoe(dct_amount,dct_spellName,destGUID,dct_critical)
			if p and DCTD_DB["DCTD_SHOWAOEHEAL"].frame ~= 0 then
				dct_amount = d
				dct_spellName = p.spellName
				dct_icon = p.spellId
				dct_spellSchool = p.spellSchool
				dctd_formatpart_hits = p.num
				dctd_formatpart_crits = tonumber(p.crits)

				DCT_EBox_Lock()

				local ep = DCT_EBox_GetEventP(p.eid,p.euid)
				if ep then
					ep.cr = false
					ep.ty = "DCTD_SHOWAOEHEAL"
					ep.tx = DCT_GetFormatText("DCTD_SHOWAOEHEAL",1,DCTD_DB)
				end

				DCT_Ebox_UnLock()

				return true
			end
		end

		if showType then
			eId,eUID = DCT_EBox_AddEvent(showType,DCT_GetFormatText(showType,showId,DCTD_DB),crit,DCTD_DB,dct_icon,DEFINE_AOE_SEARCH_DELAY)
		end

		if aoeFix then
			if eId and eUID then
				DCTD_AddAoe(dct_amount,dct_spellName,dct_spellId,dct_spellSchool,destGUID,dct_critical,eId,eUID)
			end
		end
		if showType then return true;end
	end
	return false
end

function DCTD_ReflectActive()
	DCT_SSC_Format_Enable()
	dct_icon = dct_spellId
	DCT_AddText("DCTD_SHOWSHIELD",1,false,DCTD_DB);
end

