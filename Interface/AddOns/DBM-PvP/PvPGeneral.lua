local mod	= DBM:NewMod("PvPGeneral", "DBM-PvP")
local L		= mod:GetLocalizedStrings()

local DBM = DBM
local GetPlayerFactionGroup = GetPlayerFactionGroup or UnitFactionGroup -- Classic Compat fix
local isClassic = WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2)
local isTBC = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5)

mod:SetRevision("20210815041049")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA",
	"LOADING_SCREEN_DISABLED",
	"PLAYER_ENTERING_WORLD",
	"PLAYER_DEAD",
	"START_TIMER",
	"AREA_POIS_UPDATED"
)

mod:AddBoolOption("HideBossEmoteFrame", false)
mod:AddBoolOption("AutoSpirit", false)
mod:AddBoolOption("ShowRelativeGameTime", true)

do
	local IsInInstance, RepopMe, GetSelfResurrectOptions = IsInInstance, RepopMe, C_DeathInfo.GetSelfResurrectOptions

	function mod:PLAYER_DEAD()
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" and #GetSelfResurrectOptions() == 0 and self.Options.AutoSpirit then
			RepopMe()
		end
	end
end

-- Utility functions
local CreateFrame, AlwaysUpFrame1, AlwaysUpFrame2 = CreateFrame, AlwaysUpFrame1, AlwaysUpFrame2
local scoreFrame1, scoreFrame2, scoreFrameToWin, scoreFrame1Text, scoreFrame2Text, scoreFrameToWinText

local function ShowEstimatedPoints()
	if AlwaysUpFrame1 and AlwaysUpFrame2 then
		if not scoreFrame1 then
			scoreFrame1 = CreateFrame("Frame", nil, AlwaysUpFrame1)
			scoreFrame1:SetHeight(10)
			scoreFrame1:SetWidth(100)
			scoreFrame1:SetPoint("LEFT", "AlwaysUpFrame1DynamicIconButton", "RIGHT", 4, 0)
			scoreFrame1Text = scoreFrame1:CreateFontString(nil, nil, "GameFontNormalSmall")
			scoreFrame1Text:SetAllPoints(scoreFrame1)
			scoreFrame1Text:SetJustifyH("LEFT")
		end
		if not scoreFrame2 then
			scoreFrame2 = CreateFrame("Frame", nil, AlwaysUpFrame2)
			scoreFrame2:SetHeight(10)
			scoreFrame2:SetWidth(100)
			scoreFrame2:SetPoint("LEFT", "AlwaysUpFrame2DynamicIconButton", "RIGHT", 4, 0)
			scoreFrame2Text = scoreFrame2:CreateFontString(nil, nil, "GameFontNormalSmall")
			scoreFrame2Text:SetAllPoints(scoreFrame2)
			scoreFrame2Text:SetJustifyH("LEFT")
		end
		scoreFrame1Text:SetText("")
		scoreFrame1:Show()
		scoreFrame2Text:SetText("")
		scoreFrame2:Show()
	end
end

local function ShowBasesToWin()
	if not AlwaysUpFrame2 then
		return
	end
	if not scoreFrameToWin then
		scoreFrameToWin = CreateFrame("Frame", nil, AlwaysUpFrame2)
		scoreFrameToWin:SetHeight(10)
		scoreFrameToWin:SetWidth(200)
		scoreFrameToWin:SetPoint("TOPLEFT", "AlwaysUpFrame2", "BOTTOMLEFT", 22, 2)
		scoreFrameToWinText = scoreFrameToWin:CreateFontString(nil, nil, "GameFontNormalSmall")
		scoreFrameToWinText:SetAllPoints(scoreFrameToWin)
		scoreFrameToWinText:SetJustifyH("LEFT")
	end
	scoreFrameToWinText:SetText("")
	scoreFrameToWin:Show()
end

local function HideEstimatedPoints()
	if scoreFrame1 and scoreFrame2 then
		scoreFrame1:Hide()
		scoreFrame2:Hide()
	end
end

local function HideBasesToWin()
	if scoreFrameToWin then
		scoreFrameToWin:Hide()
	end
end

local getGametime, updateGametime
do
	local time, GetTime, GetBattlefieldInstanceRunTime = time, GetTime, GetBattlefieldInstanceRunTime
	local gameTime = 0

	function updateGametime()
		gameTime = time()
	end

	function getGametime()
		if mod.Options.ShowRelativeGameTime then
			local sysTime = GetBattlefieldInstanceRunTime()
			if sysTime and sysTime > 0 then
				return sysTime / 1000
			end
			return time() - gameTime
		end
		return GetTime()
	end
end

local subscribedMapID, prevAScore, prevHScore, warnAtEnd, hasWarns = 0, 0, 0, {}, false
local numObjectives, objectivesStore

function mod:SubscribeAssault(mapID, objectsCount)
	self:AddBoolOption("ShowEstimatedPoints", true, nil, function()
		if self.Options.ShowEstimatedPoints then
			ShowEstimatedPoints()
		else
			HideEstimatedPoints()
		end
	end)
	self:AddBoolOption("ShowBasesToWin", false, nil, function()
		if self.Options.ShowBasesToWin then
			ShowBasesToWin()
		else
			HideBasesToWin()
		end
	end)
	if self.Options.ShowEstimatedPoints then
		ShowEstimatedPoints()
	end
	if self.Options.ShowBasesToWin then
		ShowBasesToWin()
	end
	self:RegisterShortTermEvents(
		"AREA_POIS_UPDATED",
		"UPDATE_UI_WIDGET",
		"CHAT_MSG_BG_SYSTEM_NEUTRAL"
	)
	subscribedMapID = mapID
	objectivesStore = {}
	numObjectives = objectsCount
	updateGametime()
end

function mod:SubscribeFlags()
	self:RegisterShortTermEvents(
		"CHAT_MSG_BG_SYSTEM_ALLIANCE",
		"CHAT_MSG_BG_SYSTEM_HORDE",
		"CHAT_MSG_BG_SYSTEM_NEUTRAL"
	)
end

do
	local pairs = pairs
	local IsInInstance, SendAddonMessage, GetMapInfo = IsInInstance, C_ChatInfo.SendAddonMessage, C_Map.GetMapInfo
	local bgzone = false

	local function Init(self)
		local _, instanceType = IsInInstance()
		if instanceType == "pvp" or instanceType == "arena" then
			if not bgzone then
				SendAddonMessage(isTBC and "D4BC" or isClassic and "D4C" or "D4", "H", "INSTANCE_CHAT")
				self:Schedule(3, DBM.RequestTimers, DBM)
				if self.Options.HideBossEmoteFrame then
					DBM:HideBlizzardEvents(1, true)
				end
			end
			bgzone = true
		elseif bgzone then
			bgzone = false
			if hasWarns then
				local map = GetMapInfo(subscribedMapID)
				DBM:AddMsg("DBM-PvP missing data, please report to our discord.")
				DBM:AddMsg("Battleground: " .. (map and map.name or "Unknown"))
				for k, v in pairs(warnAtEnd) do
					DBM:AddMsg(v .. "x " .. k)
				end
				DBM:AddMsg("Thank you for making DBM-PvP a better addon.")
			end
			self:UnregisterShortTermEvents()
			self:Stop()
			warnAtEnd = {}
			hasWarns = false
			HideEstimatedPoints()
			HideBasesToWin()
			subscribedMapID = 0
			prevAScore, prevHScore = 0, 0
			if mod.Options.HideBossEmoteFrame then
				DBM:HideBlizzardEvents(0, true)
			end
		end
	end

	function mod:LOADING_SCREEN_DISABLED()
		self:Schedule(0.5, Init, self)
	end
	mod.ZONE_CHANGED_NEW_AREA	= mod.LOADING_SCREEN_DISABLED
	mod.PLAYER_ENTERING_WORLD	= mod.LOADING_SCREEN_DISABLED
	mod.OnInitialize			= mod.LOADING_SCREEN_DISABLED
end

do
	local pairs, strsplit, tostring, format, twipe = pairs, strsplit, tostring, string.format, table.wipe
	local UnitGUID, UnitHealth, UnitHealthMax, SendAddonMessage, RegisterAddonMessagePrefix, IsAddonMessagePrefixRegistered, NewTicker = UnitGUID, UnitHealth, UnitHealthMax, C_ChatInfo.SendAddonMessage, C_ChatInfo.RegisterAddonMessagePrefix, C_ChatInfo.IsAddonMessagePrefixRegistered, C_Timer.NewTicker
	local healthScan, trackedUnits, trackedUnitsCount, syncTrackedUnits = nil, {}, 0, {}

	local function updateInfoFrame()
		local lines, sortedLines = {}, {}
		for cid, health in pairs(syncTrackedUnits) do
			if trackedUnits[cid] then
				lines[trackedUnits[cid]] = health .. "%"
				sortedLines[#sortedLines + 1] = trackedUnits[cid]
			end
		end
		return lines, sortedLines
	end

	local function healthScanFunc()
		local syncs, syncCount = {}, 0
		for i = 1, 40 do
			if syncCount >= trackedUnitsCount then -- We've already scanned all our tracked units, exit out to save CPU
				break
			end
			local target = "raid" .. i .. "target"
			local guid = UnitGUID(target)
			if guid then
				local cid = mod:GetCIDFromGUID(guid)
				if trackedUnits[cid] and not syncs[cid] then
					syncs[cid] = true
					syncCount = syncCount + 1
					SendAddonMessage("DBM-PvP", format("%s:%.1f", cid, UnitHealth(target) / UnitHealthMax(target) * 100), "INSTANCE_CHAT")
				end
			end
		end
	end

	function mod:TrackHealth(cid, name)
		if not healthScan then
			healthScan = NewTicker(1, healthScanFunc)
			RegisterAddonMessagePrefix("DBM-PvP")
			if not IsAddonMessagePrefixRegistered("Capping") then
				RegisterAddonMessagePrefix("Capping") -- Listen to capping for extra data
			end
		end
		trackedUnits[tostring(cid)] = L[name] or name
		trackedUnitsCount = trackedUnitsCount + 1
		self:RegisterShortTermEvents("CHAT_MSG_ADDON")
		if not DBM.InfoFrame:IsShown() then
			DBM.InfoFrame:SetHeader(L.InfoFrameHeader)
			DBM.InfoFrame:Show(42, "function", updateInfoFrame, false, false)
			DBM.InfoFrame:SetColumns(1)
		end
	end

	function mod:StopTrackHealth()
		if healthScan then
			healthScan:Cancel()
			healthScan = nil
		end
		twipe(trackedUnits)
		twipe(syncTrackedUnits)
		self:UnregisterShortTermEvents()
		DBM.InfoFrame:Hide()
	end

	function mod:CHAT_MSG_ADDON(prefix, msg, channel)
		if channel ~= "INSTANCE_CHAT" or (prefix ~= "DBM-PvP" and prefix ~= "Capping") then -- Lets listen to capping as well, for extra data.
			return
		end
		local cid, hp = strsplit(":", msg)
		syncTrackedUnits[cid] = hp
	end
end

do
	local tonumber, ipairs = tonumber, ipairs
	local TimerTracker, IsInInstance, GetIconAndTextWidgetVisualizationInfo = TimerTracker, IsInInstance, C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo
	local FACTION_ALLIANCE = FACTION_ALLIANCE

	local flagTimer			= mod:NewTimer(12, "TimerFlag", "132483") -- Interface\\icons\\inv_banner_02.blp
	local startTimer		= mod:NewTimer(120, "TimerStart", GetPlayerFactionGroup("player") == "Alliance" and "132486" or "132485") -- Interface\\Icons\\INV_BannerPVP_02.blp || Interface\\Icons\\INV_BannerPVP_01.blp
	local remainingTimer	= mod:NewTimer(780, "TimerRemaining", GetPlayerFactionGroup("player") == "Alliance" and "132486" or "132485") -- Interface\\Icons\\INV_BannerPVP_02.blp || Interface\\Icons\\INV_BannerPVP_01.blp
	local vulnerableTimer, timerShadow, timerDamp
	if not isClassic and not isTBC then
		vulnerableTimer	= mod:NewNextTimer(60, 46392)
		timerShadow		= mod:NewNextTimer(90, 34709)
		timerDamp		= mod:NewCastTimer(300, 110310)
	end

	function mod:START_TIMER(timerType, timeSeconds)
		if timerType ~= 1 then -- Only capture type 1 events (PvP)
			return
		end
		local _, instanceType = IsInInstance()
		if not self.Options.TimerRemaining or (instanceType ~= "pvp" and instanceType ~= "arena" and instanceType ~= "scenario") then
			if TimerTracker then
				for _, bar in ipairs(TimerTracker.timerList) do
					bar.bar:Hide()
				end
			end
			if not startTimer:IsStarted() then
				startTimer:Update(timeSeconds, 120)
			end
			self:Schedule(timeSeconds + 1, function()
				if not isClassic and not isTBC and instanceType == "arena" then
					timerShadow:Start()
					timerDamp:Start()
				end
				local info = GetIconAndTextWidgetVisualizationInfo(6)
				if info and info.state == 1 and self.Options.TimerRemaining then
					local minutes, seconds = info.text:match("(%d+):(%d+)")
					if minutes and seconds then
						remainingTimer:Update(119 - tonumber(seconds) - (tonumber(minutes) * 60), 120)
					end
				end
			end, self)
		end
	end

	local function updateflagcarrier(_, msg)
		if msg == L.ExprFlagCaptured or msg:match(L.ExprFlagCaptured) then
			flagTimer:Start()
			if msg:find(FACTION_ALLIANCE) then
				flagTimer:SetColor({r=0, g=0, b=1})
				flagTimer:UpdateIcon("132486") -- Interface\\Icons\\INV_BannerPVP_02.blp
			else
				flagTimer:SetColor({r=1, g=0, b=0})
				flagTimer:UpdateIcon("132485") -- Interface\\Icons\\INV_BannerPVP_01.blp
			end
			if not isClassic and not isTBC then
				vulnerableTimer:Cancel()
			end
		end
	end

	function mod:CHAT_MSG_BG_SYSTEM_ALLIANCE(...)
		updateflagcarrier(self, ...)
	end

	function mod:CHAT_MSG_BG_SYSTEM_HORDE(...)
		updateflagcarrier(self, ...)
	end

	function mod:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
		if msg == L.BgStart120 or msg:find(L.BgStart120) then
			remainingTimer:Update(isClassic and 1.5 or 0, 120)
		elseif msg == L.BgStart60 or msg:find(L.BgStart60) then
			remainingTimer:Update(isClassic and 61.5 or 60, 120)
		elseif msg == L.BgStart30 or msg:find(L.BgStart30) then
			remainingTimer:Update(isClassic and 91.5 or 90, 120)
		elseif not isClassic and (msg == L.Vulnerable1 or msg == L.Vulnerable2 or msg:find(L.Vulnerable1) or msg:find(L.Vulnerable2)) then
			vulnerableTimer:Start()
		end
	end
end

do
	local ipairs, pairs, tonumber, type, mfloor, mmin, sformat, smatch = ipairs, pairs, tonumber, type, math.floor, math.min, string.format, string.match
	local GetAreaPOIInfo, GetAreaPOITimeLeft, GetAreaPOIForMap, GetDoubleStatusBarWidgetVisualizationInfo, GetIconAndTextWidgetVisualizationInfo, GetDoubleStateIconRowVisualizationInfo = C_AreaPoiInfo.GetAreaPOIInfo, C_AreaPoiInfo.GetAreaPOITimeLeft, C_AreaPoiInfo.GetAreaPOIForMap, C_UIWidgetManager.GetDoubleStatusBarWidgetVisualizationInfo, C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo, C_UIWidgetManager.GetDoubleStateIconRowVisualizationInfo
	local FACTION_HORDE, FACTION_ALLIANCE = FACTION_HORDE, FACTION_ALLIANCE

	local winTimer = mod:NewTimer(30, "TimerWin", GetPlayerFactionGroup("player") == "Alliance" and "132486" or "132485") -- Interface\\Icons\\INV_BannerPVP_02.blp || Interface\\Icons\\INV_BannerPVP_01.blp
	local resourcesPerSec = {
		[3] = {1e-300, 0.5, 1.5, 2}, -- Gilneas
		[4] = {1e-300, 1, 1.5, 2, 6}, -- TempleOfKotmogu/EyeOfTheStorm
		[5] = {1e-300, 1, 1.5, 2, 3.5, 30} -- Arathi/Deepwind
	}

	if isClassic or isTBC then
		-- 2014 values seem ok https://github.com/DeadlyBossMods/DBM-PvP/blob/843a882eae2276c2be0646287c37b114c51fcffb/DBM-PvP/Battlegrounds/Arathi.lua#L32-L39
		resourcesPerSec[5] = {1e-300, 10/12, 10/9, 10/6, 10/3, 30}
	end

	function mod:UpdateWinTimer(maxScore, allianceScore, hordeScore, allianceBases, hordeBases)
		local resPerSec = resourcesPerSec[numObjectives]
		-- Start debug
		if prevAScore ~= allianceScore then
			if resPerSec[allianceBases + 1] == 1000 then
				local key = sformat("%d,%d", allianceScore - prevAScore, allianceBases)
				local warnCount = warnAtEnd[key] or 0
				warnAtEnd[key] = warnCount + 1
				if warnCount > 2 then
					hasWarns = true
				end
			end
			if allianceScore < maxScore then
				DBM:Debug(sformat("Alliance: +%d (%d)", allianceScore - prevAScore, allianceBases), 3)
			end
			prevAScore = allianceScore
		end
		if prevHScore ~= hordeScore then
			if resPerSec[hordeBases + 1] == 1000 then
				local key = sformat("%d,%d", hordeScore - prevHScore, hordeBases)
				local warnCount = warnAtEnd[key] or 0
				warnAtEnd[key] = warnCount + 1
				if warnCount > 2 then
					hasWarns = true
				end
			end
			if hordeScore < maxScore then
				DBM:Debug(sformat("Horde: +%d (%d)", hordeScore - prevHScore, hordeBases), 3)
			end
			prevHScore = hordeScore
		end
		-- End debug
		local gameTime = getGametime()
		local allyTime = mfloor(mmin(maxScore, (maxScore - allianceScore) / resPerSec[allianceBases + 1]))
		local hordeTime = mfloor(mmin(maxScore, (maxScore - hordeScore) / resPerSec[hordeBases + 1]))
		if allyTime == hordeTime or allyTime == 0 or hordeTime == 0 then
			winTimer:Stop()
			if scoreFrame1Text then
				scoreFrame1Text:SetText("")
				scoreFrame2Text:SetText("")
			end
		elseif allyTime > hordeTime then
			if scoreFrame1Text and scoreFrame2Text then
				scoreFrame1Text:SetText("(" .. mfloor(mfloor(((hordeTime * resPerSec[allianceBases + 1]) + allianceScore) / 10) * 10) .. ")")
				scoreFrame2Text:SetText("(" .. maxScore .. ")")
			end
			winTimer:Update(gameTime, gameTime + hordeTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(FACTION_HORDE))
			winTimer:SetColor({r=1, g=0, b=0})
			winTimer:UpdateIcon("132485") -- Interface\\Icons\\INV_BannerPVP_01.blp
		elseif hordeTime > allyTime then
			if scoreFrame1Text and scoreFrame2Text then
				scoreFrame2Text:SetText("(" .. mfloor(mfloor(((allyTime * resPerSec[hordeBases + 1]) + hordeScore) / 10) * 10) .. ")")
				scoreFrame1Text:SetText("(" .. maxScore .. ")")
			end
			winTimer:Update(gameTime, gameTime + allyTime)
			winTimer:DisableEnlarge()
			winTimer:UpdateName(L.WinBarText:format(FACTION_ALLIANCE))
			winTimer:SetColor({r=0, g=0, b=1})
			winTimer:UpdateIcon("132486") -- Interface\\Icons\\INV_BannerPVP_02.blp
		end
		if self.Options.ShowBasesToWin then
			local friendlyLast, enemyLast, friendlyBases, enemyBases
			if GetPlayerFactionGroup("player") == "Alliance" then
				friendlyLast = allianceScore
				enemyLast = hordeScore
				friendlyBases = allianceBases
				enemyBases = hordeBases
			else
				friendlyLast = hordeScore
				enemyLast = allianceScore
				friendlyBases = hordeBases
				enemyBases = allianceBases
			end
			if (maxScore - friendlyLast) / resPerSec[friendlyBases + 1] > (maxScore - enemyLast) / resPerSec[enemyBases + 1] then
				local enemyTime, friendlyTime, baseLowest, enemyFinal, friendlyFinal
				for i = 1, numObjectives do
					enemyTime = (maxScore - enemyLast) / resPerSec[numObjectives - i]
					friendlyTime = (maxScore - friendlyLast) / resPerSec[i]
					baseLowest = friendlyTime < enemyTime and friendlyTime or enemyTime
					enemyFinal = mfloor((enemyLast + mfloor(baseLowest * resPerSec[numObjectives - 3] + 0.5)) / 10) * 10
					friendlyFinal = mfloor((friendlyLast + mfloor(baseLowest * resPerSec[i] + 0.5)) / 10) * 10
					if friendlyFinal >= maxScore and enemyFinal < maxScore then
						scoreFrameToWinText:SetText(L.BasesToWin:format(i))
						break
					end
				end
			else
				scoreFrameToWinText:SetText("")
			end
		end
	end

	local ignoredAtlas = {
		[112]   = true,
		[397]   = true
	}
	local overrideTimers = {
		-- retail av
		[91]    = 243,
		-- classic av
		[1459]  = WOW_PROJECT_ID == (WOW_PROJECT_BURNING_CRUSADE_CLASSIC or 5) and 243 or 304,
		-- korrak
		[1537]  = 243
	}
	local State = {
		["ALLY_CONTESTED"]      = 1,
		["ALLY_CONTROLLED"]     = 2,
		["HORDE_CONTESTED"]     = 3,
		["HORDE_CONTROLLED"]    = 4
	}
	local icons = {
		-- Graveyard
		[(isClassic or isTBC) and 3 or 4]      = State.ALLY_CONTESTED,
		[(isClassic or isTBC) and 14 or 15]    = State.ALLY_CONTROLLED,
		[(isClassic or isTBC) and 13 or 14]    = State.HORDE_CONTESTED,
		[(isClassic or isTBC) and 12 or 13]    = State.HORDE_CONTROLLED,
		-- Tower/Lighthouse
		[(isClassic or isTBC) and 8 or 9]      = State.ALLY_CONTESTED,
		[(isClassic or isTBC) and 10 or 11]    = State.ALLY_CONTROLLED,
		[(isClassic or isTBC) and 11 or 12]    = State.HORDE_CONTESTED,
		[(isClassic or isTBC) and 9 or 10]     = State.HORDE_CONTROLLED,
		-- Mine/Quarry
		[17]                        = State.ALLY_CONTESTED,
		[18]                        = State.ALLY_CONTROLLED,
		[19]                        = State.HORDE_CONTESTED,
		[20]                        = State.HORDE_CONTROLLED,
		-- Lumber
		[22]                        = State.ALLY_CONTESTED,
		[23]                        = State.ALLY_CONTROLLED,
		[24]                        = State.HORDE_CONTESTED,
		[25]                        = State.HORDE_CONTROLLED,
		-- Blacksmith/Waterworks
		[27]                        = State.ALLY_CONTESTED,
		[28]                        = State.ALLY_CONTROLLED,
		[29]                        = State.HORDE_CONTESTED,
		[30]                        = State.HORDE_CONTROLLED,
		-- Farm
		[32]                        = State.ALLY_CONTESTED,
		[33]                        = State.ALLY_CONTROLLED,
		[34]                        = State.HORDE_CONTESTED,
		[35]                        = State.HORDE_CONTROLLED,
		-- Stables
		[37]                        = State.ALLY_CONTESTED,
		[38]                        = State.ALLY_CONTROLLED,
		[39]                        = State.HORDE_CONTESTED,
		[40]                        = State.HORDE_CONTROLLED,
		-- Workshop
		[137]                       = State.ALLY_CONTESTED,
		[138]                       = State.ALLY_CONTROLLED,
		[139]                       = State.HORDE_CONTESTED,
		[140]                       = State.HORDE_CONTROLLED,
		-- Hangar
		[142]                       = State.ALLY_CONTESTED,
		[143]                       = State.ALLY_CONTROLLED,
		[144]                       = State.HORDE_CONTESTED,
		[145]                       = State.HORDE_CONTROLLED,
		-- Docks
		[147]                       = State.ALLY_CONTESTED,
		[148]                       = State.ALLY_CONTROLLED,
		[149]                       = State.HORDE_CONTESTED,
		[150]                       = State.HORDE_CONTROLLED,
		-- Refinery
		[152]                       = State.ALLY_CONTESTED,
		[153]                       = State.ALLY_CONTROLLED,
		[154]                       = State.HORDE_CONTESTED,
		[155]                       = State.HORDE_CONTROLLED,
		-- Market
		[208]                       = State.ALLY_CONTESTED,
		[205]                       = State.ALLY_CONTROLLED,
		[209]                       = State.HORDE_CONTESTED,
		[206]                       = State.HORDE_CONTROLLED,
		-- Ruins
		[213]                       = State.ALLY_CONTESTED,
		[210]                       = State.ALLY_CONTROLLED,
		[214]                       = State.HORDE_CONTESTED,
		[211]                       = State.HORDE_CONTROLLED,
		-- Shrine
		[218]                       = State.ALLY_CONTESTED,
		[215]                       = State.ALLY_CONTROLLED,
		[219]                       = State.HORDE_CONTESTED,
		[216]                       = State.HORDE_CONTROLLED
	}
	local capTimer = mod:NewTimer((isTBC or isClassic) and 64 or 60, "TimerCap", "136002") -- Interface\\icons\\spell_misc_hellifrepvphonorholdfavor.blp

	function mod:AREA_POIS_UPDATED(widget)
		local allyBases, hordeBases = 0, 0
		local widgetID = widget and widget.widgetID
		if subscribedMapID ~= 0 then
			local isAtlas = false
			for _, areaPOIID in ipairs(GetAreaPOIForMap(subscribedMapID)) do
				local areaPOIInfo = GetAreaPOIInfo(subscribedMapID, areaPOIID)
				local infoName, atlasName, infoTexture = areaPOIInfo.name, areaPOIInfo.atlasName, areaPOIInfo.textureIndex
				if infoName then
					local isAllyCapping, isHordeCapping
					if atlasName then
						isAtlas = true
						isAllyCapping = atlasName:find('leftIcon')
						isHordeCapping = atlasName:find('rightIcon')
					elseif infoTexture then
						isAllyCapping = icons[infoTexture] == State.ALLY_CONTESTED
						isHordeCapping = icons[infoTexture] == State.HORDE_CONTESTED
					end
					if objectivesStore[infoName] ~= (atlasName and atlasName or infoTexture) then
						capTimer:Stop(infoName)
						objectivesStore[infoName] = (atlasName and atlasName or infoTexture)
						if not ignoredAtlas[subscribedMapID] and (isAllyCapping or isHordeCapping) then
							local capTime = GetAreaPOITimeLeft and GetAreaPOITimeLeft(areaPOIID) and GetAreaPOITimeLeft(areaPOIID) * 60 or overrideTimers[subscribedMapID] or 60
							if capTime ~= 0 then
								capTimer:Start(GetAreaPOITimeLeft and GetAreaPOITimeLeft(areaPOIID) and GetAreaPOITimeLeft(areaPOIID) * 60 or overrideTimers[subscribedMapID] or 60, infoName)
							end
							if isAllyCapping then
								capTimer:SetColor({r=0, g=0, b=1}, infoName)
								capTimer:UpdateIcon("132486", infoName) -- Interface\\Icons\\INV_BannerPVP_02.blp
							else
								capTimer:SetColor({r=1, g=0, b=0}, infoName)
								capTimer:UpdateIcon("132485", infoName) -- Interface\\Icons\\INV_BannerPVP_01.blp
							end
						end
					end
				end
			end
			if isAtlas then
				for _, v in pairs(objectivesStore) do
					if type(v) ~= "string" then
						-- Do nothing
					elseif v:find('leftIcon') then
						allyBases = allyBases + 1
					elseif v:find('rightIcon') then
						hordeBases = hordeBases + 1
					end
				end
			else
				for _, v in pairs(objectivesStore) do
					if icons[v] == State.ALLY_CONTROLLED then
						allyBases = allyBases + 1
					elseif icons[v] == State.HORDE_CONTROLLED then
						hordeBases = hordeBases + 1
					end
				end
			end
			if widgetID == 1671 or widgetID == 2074 then -- Standard battleground score predictor: 1671. Deepwind rework: 2074
				local info = GetDoubleStatusBarWidgetVisualizationInfo(widgetID)
				self:UpdateWinTimer(info.leftBarMax, info.leftBarValue, info.rightBarValue, allyBases, hordeBases)
			end
			if widgetID == 1893 or widgetID == 1894 then -- Classic Arathi Basin
				self:UpdateWinTimer(2000, tonumber(smatch(GetIconAndTextWidgetVisualizationInfo(1893).text, '(%d+)/2000')), tonumber(smatch(GetIconAndTextWidgetVisualizationInfo(1894).text, '(%d+)/2000')), allyBases, hordeBases)
			end
		elseif widgetID == 1683 then -- Temple Of Kotmogu
			local widgetInfo = GetDoubleStateIconRowVisualizationInfo(1683)
			for _, v in pairs(widgetInfo.leftIcons) do
				if v.iconState == 1 then
					allyBases = allyBases + 1
				end
			end
			for _, v in pairs(widgetInfo.rightIcons) do
				if v.iconState == 1 then
					hordeBases = hordeBases + 1
				end
			end
			local info = GetDoubleStatusBarWidgetVisualizationInfo(1689)
			self:UpdateWinTimer(info.leftBarMax, info.leftBarValue, info.rightBarValue, allyBases, hordeBases)
		end
	end
	mod.UPDATE_UI_WIDGET = mod.AREA_POIS_UPDATED
end
