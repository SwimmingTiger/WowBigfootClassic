local CTM, C, L, _ = unpack(select(2, ...))

-----------------------------
-- VARIABLES
-----------------------------
-- upvalues
local _G		= _G
local select	= _G.select
local unpack	= _G.unpack
local tonumber	= _G.tonumber
local type		= _G.type
local floor		= _G.math.floor
local strbyte	= _G.string.byte
local format	= _G.string.format
local strlen	= _G.string.len
local strsub	= _G.string.sub

local ipairs	= _G.ipairs
local pairs		= _G.pairs
local tinsert	= _G.table.insert
local tremove	= _G.table.remove
local sort		= _G.table.sort
local wipe		= _G.table.wipe

local GetNumGroupMembers	= _G.GetNumGroupMembers
local GetNumSubgroupMembers	= _G.GetNumSubgroupMembers
local GetInstanceInfo		= _G.GetInstanceInfo
local InCombatLockdown		= _G.InCombatLockdown
local IsInRaid				= _G.IsInRaid
local UnitAffectingCombat	= _G.UnitAffectingCombat
local UnitClass				= _G.UnitClass
local UnitExists			= _G.UnitExists
local UnitIsFriend			= _G.UnitIsFriend
local UnitIsPlayer			= _G.UnitIsPlayer
local UnitName				= _G.UnitName
local UnitReaction			= _G.UnitReaction

local FACTION_BAR_COLORS	= _G.FACTION_BAR_COLORS
local RAID_CLASS_COLORS		= _G.RAID_CLASS_COLORS

-- other
CTM.bars = {}
CTM.threatData = {}
CTM.colorFallback = {}
CTM.colorMarker = {}
CTM.threatColors = {}
CTM.numGroupMembers = 0
CTM.playerName = ""
CTM.playerTarget = ""

-----------------------------
-- WOW CLASSIC
-----------------------------
-- CTM.classic = _G.WOW_PROJECT_ID ~= _G.WOW_PROJECT_CLASSIC -- for testing in retail
CTM.classic = _G.WOW_PROJECT_ID == _G.WOW_PROJECT_CLASSIC

local ThreatLib = CTM.classic and LibStub:GetLibrary("ThreatClassic-1.0")

local UnitThreatSituation = CTM.classic and function(unit, mob)
	return ThreatLib:UnitThreatSituation(unit, mob)
end or _G.UnitThreatSituation

local UnitDetailedThreatSituation = CTM.classic and function(unit, mob)
	return ThreatLib:UnitDetailedThreatSituation(unit, mob)
end or _G.UnitDetailedThreatSituation

-----------------------------
-- FUNCTIONS
-----------------------------
local function CopyDefaults(t1, t2)
	if type(t1) ~= "table" then return {} end
	if type(t2) ~= "table" then t2 = {} end

	for k, v in pairs(t1) do
		if type(v) == "table" then
			t2[k] = CopyDefaults(v, t2[k])
		elseif type(v) ~= type(t2[k]) then
			t2[k] = v
		end
	end

	return t2
end

local function CreateBackdrop(parent, cfg)
	local f = CreateFrame("Frame", nil, parent)
	f:SetPoint("TOPLEFT", parent, "TOPLEFT", -cfg.inset, cfg.inset)
	f:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", cfg.inset, -cfg.inset)
	-- Backdrop Settings
	local backdrop = {
		bgFile = cfg.bgFile,
		edgeFile = cfg.edgeFile,
		tile = cfg.tile,
		tileSize = cfg.tileSize,
		edgeSize = cfg.edgeSize,
		insets = {
			left = cfg.inset,
			right = cfg.inset,
			top = cfg.inset,
			bottom = cfg.inset,
		},
	}
	f:SetBackdrop(backdrop)
	f:SetBackdropColor(unpack(cfg.bgColor))
	f:SetBackdropBorderColor(unpack(cfg.edgeColor))

	parent.backdrop = f
end

local function CreateFS(parent)
	local fs = parent:CreateFontString(nil, "ARTWORK")
	fs:SetFont(C.font.family, C.font.size, C.font.style)
	return fs
end

local function CreateStatusBar(parent, header)
	-- StatusBar
	local bar = CreateFrame("StatusBar", nil, parent)
	bar:SetMinMaxValues(0, 100)
	-- Backdrop
	CreateBackdrop(bar, C.backdrop)

	if not header then
		-- BG
		bar.bg = bar:CreateTexture(nil, "BACKGROUND", nil, -6)
		bar.bg:SetAllPoints(bar)
		-- Name
		bar.name = CreateFS(bar)
		bar.name:SetJustifyH("LEFT")
		-- Perc
		bar.perc = CreateFS(bar)
		bar.perc:SetJustifyH("RIGHT")
		-- Value
		bar.val = CreateFS(bar)
		bar.val:SetJustifyH("RIGHT")

		bar:Hide()
	end
	return bar
end

local function Compare(a, b)
	return a.scaledPercent > b.scaledPercent
end

local function NumFormat(v)
	if v > 1e10 then
		return (floor(v / 1e9)) .. "b"
	elseif v > 1e9 then
		return (floor((v / 1e9) * 10) / 10) .. "b"
	elseif v > 1e7 then
		return (floor(v / 1e6)) .. "m"
	elseif v > 1e6 then
		return (floor((v / 1e6) * 10) / 10) .. "m"
	elseif v > 1e4 then
		return (floor(v / 1e3)) .. "k"
	elseif v > 1e3 then
		return (floor((v / 1e3) * 10) / 10) .. "k"
	else
		return v
	end
end

local function TruncateString(str, i, ellipsis)
	if not str then return end
	local bytes = strlen(str)
	if bytes <= i then
		return str
	else
		local length, pos = 0, 1
		while (pos <= bytes) do
			length = length + 1
			local c = strbyte(str, pos)
			if c > 0 and c <= 127 then
				pos = pos + 1
			elseif c >= 192 and c <= 223 then
				pos = pos + 2
			elseif c >= 224 and c <= 239 then
				pos = pos + 3
			elseif c >= 240 and c <= 247 then
				pos = pos + 4
			end
			if length == i then break end
		end
		if length == i and pos <= bytes then
			return strsub(str, 1, pos - 1) .. (ellipsis and "..." or "")
		else
			return str
		end
	end
end

local function GetColor(unit)
	if unit then
		local colorUnit = {}
		if C.bar.marker and unit == "player" then
			return CTM.colorMarker
		elseif UnitIsPlayer(unit) then
			colorUnit = RAID_CLASS_COLORS[select(2, UnitClass(unit))]
		else
			colorUnit = FACTION_BAR_COLORS[UnitReaction(unit, "player")]
		end
		colorUnit = {colorUnit.r, colorUnit.g, colorUnit.b, C.bar.alpha}
		return colorUnit
	else
		return CTM.colorFallback
	end
end

function CTM:UpdateThreatBars()
	-- sort the threat table
	sort(self.threatData, Compare)

	-- update view
	for i = 1, C.bar.count do
		-- get values out of table
		local data = self.threatData[i]
		local bar = self.bars[i]
		if data and data.threatValue > 0 then
			if bar == self.bars[1] then data.scaledPercent = 100 end -- temporary?
			bar.name:SetText(UnitName(data.unit) or UNKNOWN)
			bar.val:SetText(NumFormat(data.threatValue))
			bar.perc:SetText(floor(data.scaledPercent).."%")
			bar:SetValue(data.scaledPercent)
			local color = GetColor(data.unit)
			bar:SetStatusBarColor(unpack(color))
			bar.bg:SetVertexColor(color[1] * C.bar.colorMod, color[2] * C.bar.colorMod, color[3] * C.bar.colorMod, C.bar.alpha)
			bar.backdrop:SetBackdropColor(unpack(C.backdrop.bgColor))
			bar.backdrop:SetBackdropBorderColor(unpack(C.backdrop.edgeColor))

			bar:Show()
		else
			bar:Hide()
		end
	end
end

local function CheckVisibility()
	local instanceType = select(2, GetInstanceInfo())
	local hide = (C.general.hideOOC and not InCombatLockdown()) or (C.general.hideSolo and CTM.numGroupMembers == 0) or (C.general.hideInPVP and (instanceType == "arena" or instanceType == "pvp"))

	if hide then
		return CTM.frame:Hide()
	else
		return CTM.frame:Show()
	end
end

local function UpdateThreatData(unit)
	if not UnitExists(unit) then return end
	local _, _, scaledPercent, _, threatValue = UnitDetailedThreatSituation(unit, CTM.playerTarget)
	if threatValue and threatValue < 0 then
		threatValue = threatValue + 410065408
	end
	tinsert(CTM.threatData, {
		unit			= unit,
		scaledPercent	= scaledPercent or 0,
		threatValue		= threatValue or 0,
	})
end

local function CheckStatus()
	if C.frame.test then return end

	CheckVisibility()

	if UnitExists(CTM.playerTarget) then -- and UnitAffectingCombat(CTM.playerTarget) then
		-- wipe
		wipe(CTM.threatData)

		if IsInRaid() then
			for i = 1, CTM.numGroupMembers do
				UpdateThreatData(CTM.raidUnits[i])
				UpdateThreatData(CTM.raidPetUnits[i])
			end
		else
			if CTM.numGroupMembers > 0 then
				for i = 1, CTM.numGroupMembers do
					UpdateThreatData(CTM.partyUnits[i])
					UpdateThreatData(CTM.partyPetUnits[i])
				end
			end
			-- solo / party player & pet units
			UpdateThreatData("player")
			UpdateThreatData("pet")
		end

		CTM:UpdateThreatBars()

		-- set header unit name
		local targetName = (": " .. UnitName(CTM.playerTarget)) or ""
		targetName = TruncateString(targetName, floor(CTM.frame.header:GetWidth() / (C.font.size * 0.85)), true)
		CTM.frame.header.text:SetText(format("%s%s", L.gui_threat, targetName))
	else
		-- clear header text of unit name
		CTM.frame.header.text:SetText(format("%s%s", L.gui_threat, ""))
		-- hide bars when no target
		for i = 1, 40 do
			CTM.bars[i]:Hide()
		end
	end
end

-----------------------------
-- UPDATE FRAME
-----------------------------
local function SetPosition(f)
	local a1, _, a2, x, y = f:GetPoint()
	C.frame.position = {a1, "UIParent", a2, x, y}
end

local function OnDragStart(f)
	f = f:GetParent()
	f:StartMoving()
end

local function OnDragStop(f)
	f = f:GetParent()
	f:StopMovingOrSizing()
	SetPosition(f)
end

local function UpdateSize(f)
	C.frame.width = f:GetWidth() - 2
	C.frame.height = f:GetHeight()

	local maxBarCount = floor(C.frame.height / (C.bar.height + C.bar.padding)) + 1
	-- if C.bar.count > maxBarCount then C.bar.count = maxBarCount end
	C.bar.count = maxBarCount

	for i = 1, 40 do
		if i <= C.bar.count and CTM.threatData[i] then
			CTM.bars[i]:Show()
		else
			CTM.bars[i]:Hide()
		end
	end

	CTM:UpdateFrame()
end

local function OnMouseDown(f)
	f = f:GetParent()
	f:SetMinResize(64, 64)
	f:SetMaxResize(512, 1024)
	CTM.sizing = true
	f:SetScript("OnSizeChanged", UpdateSize)
	f:StartSizing()
end

local function OnMouseUp(f)
	f = f:GetParent()
	CTM.sizing = false
	f:SetScript("OnSizeChanged", nil)
	f:StopMovingOrSizing()
end

local function UpdateFont(fs)
	fs:SetFont(C.font.family, C.font.size, C.font.style)
	fs:SetVertexColor(unpack(C.font.color))
	fs:SetShadowOffset(C.font.shadow and 1 or 0, C.font.shadow and -1 or 0)
end

function CTM:UpdateFrame()
	local frame = self.frame

	if not CTM.sizing then
		frame:SetSize(C.frame.width + 2, C.frame.height)
	end
	frame:ClearAllPoints()
	frame:SetPoint(unpack(C.frame.position))
	frame:SetScale(C.frame.scale)
	frame:SetFrameStrata(strsub(C.frame.strata, 3))

	if not C.frame.locked then
		frame:SetMovable(true)
		frame:SetResizable(true)
		frame:SetClampedToScreen(true)

		frame.resize:Show()
		frame.resize:EnableMouse(true)
		frame.resize:SetMovable(true)
		frame.resize:RegisterForDrag("LeftButton")
		frame.resize:SetScript("OnDragStart", OnMouseDown)
		frame.resize:SetScript("OnDragStop", OnMouseUp)

		frame.header:SetMovable(true)
		frame.header:SetClampedToScreen(true)
		frame.header:RegisterForDrag("LeftButton")
		frame.header:SetScript("OnDragStart", OnDragStart)
		frame.header:SetScript("OnDragStop", OnDragStop)
	else
		frame:SetMovable(false)
		frame:SetResizable(false)
		frame.resize:Hide()
		frame.resize:SetMovable(false)
		frame.header:SetMovable(false)
	end

	-- Background
	frame.bg:SetAllPoints()
	frame.bg:SetVertexColor(unpack(C.frame.color))

	-- Header
	if C.frame.headerShow then
		frame.header:SetSize(C.frame.width + 2, C.bar.height)
		frame.header:SetStatusBarTexture(C.bar.texture)

		frame.header:SetPoint("TOPLEFT", frame, 0, C.bar.height - 1)
		frame.header:SetStatusBarColor(unpack(C.frame.headerColor))

		frame.header.backdrop:SetBackdropColor(0, 0, 0, 0) -- ugly, but okay for now
		frame.header.backdrop:SetBackdropBorderColor(0, 0, 0, C.frame.headerColor[4]) -- adjust alpha for border

		frame.header.text:SetText(format("%s%s", L.gui_threat, ""))

		UpdateFont(frame.header.text)

		frame.header:Show()
	else
		frame.header:Hide()
	end

	self:UpdateBars()
end

function CTM:UpdateBars()
	for i = 1, 40 do
		if not self.bars[i] then
			self.bars[i] = CreateStatusBar(self.frame)
		end

		local bar = self.bars[i]

		if i == 1 then
			bar:SetPoint("TOP", 0, 0)
		else
			bar:SetPoint("TOP", self.bars[i - 1], "BOTTOM", 0, -C.bar.padding + 1)
		end
		bar:SetSize(C.frame.width + 2, C.bar.height)
		bar:SetStatusBarTexture(C.bar.texture)

		-- BG
		bar.bg:SetTexture(C.bar.texture)
		-- Name
		bar.name:SetPoint("LEFT", bar, 4, 0)
		UpdateFont(bar.name)
		-- Perc
		bar.perc:SetPoint("RIGHT", bar, -2, 0)
		UpdateFont(bar.perc)
		-- Value
		-- bar.val:SetPoint("RIGHT", bar, -40, 0)
		bar.val:SetPoint("RIGHT", bar, -(C.font.size * 3.5), 0)
		UpdateFont(bar.val)

		-- Adjust Name
		bar.name:SetPoint("RIGHT", bar.val, "LEFT", -10, 0) -- right point of name is left point of value
	end
end

-----------------------------
-- TEST MODE
-----------------------------
function CTM:TestMode()
	if InCombatLockdown() then return end

	C.frame.test = true
	wipe(CTM.threatData)
	for i = 1, C.bar.count do
		self.threatData[i] = {
			unit = self.playerName,
			scaledPercent = i / C.bar.count * 100,
			threatValue = i * 1e4,
		}
		tinsert(self.bars, i)
	end
	self:UpdateThreatBars()
end

-----------------------------
-- NAMEPLATES
-----------------------------
local function UpdateNameplateThreat(self)
	if not InCombatLockdown() or not C.general.nameplateThreat then return end
	local unit = self.unit
	if not unit then return end
	if not unit:match("nameplate%d?$") then return end
	if UnitIsPlayer(unit) or UnitIsFriend("player", unit) then return end -- prevent coloring player/friendly NPC nameplates
	local nameplate = C_NamePlate.GetNamePlateForUnit(unit)
	if not nameplate then return end
	local status = UnitThreatSituation("player", unit)
	if status then
		if C.general.invertColors then
			if status == 3 then
				status = 0
			elseif status == 0 then
				status = 3
			end
		end
		self.healthBar:SetStatusBarColor(unpack(CTM.threatColors[status]))
	end
end

if CTM.classic then
	-- since UNIT_THREAT_LIST_UPDATE isn't a thing in Classic, health color doesn't update nearly as frequently
	-- we'll instead hook the range check since it is OnUpdate - gross, but it works for now
	hooksecurefunc("CompactUnitFrame_UpdateInRange", UpdateNameplateThreat)
else
	hooksecurefunc("CompactUnitFrame_UpdateHealthColor", UpdateNameplateThreat)
	hooksecurefunc("CompactUnitFrame_UpdateAggroFlash", UpdateNameplateThreat)
end

-----------------------------
-- VERSION CHECK
-----------------------------
local group = {}
local groupSort = {}

local function CheckVersion(onlyOutdated)
	if onlyOutdated then
		print(L.version_list_outdated)
	else
		print(L.version_list)
	end
	local latestRevision = ThreatLib.latestSeenRevision
	local revisions = ThreatLib.partyMemberRevisions
	local agents = ThreatLib.partyMemberAgents
	for k, _ in pairs(group) do
		group[k] = nil
	end
	if CTM.numGroupMembers > 0 then
		local unit = IsInRaid() and "raid" or "party"
		for i = 1, CTM.numGroupMembers do
			local name = UnitName(unit .. i)
			if name then
				group[name] = true
			end
		end
		for i = 1, #groupSort do
			tremove(groupSort)
		end
		for k, _ in pairs(group) do
			tinsert(groupSort, k)
		end
		table.sort(groupSort)
		print(L.version_divider)
		for _, v in ipairs(groupSort) do
			if not onlyOutdated or (not revisions[v] or revisions[v] < (latestRevision or 0)) then
				print(("%s: %s / %s %s"):format(v, agents[v] or ("|cff666666" .. UNKNOWN .. "|r"), revisions[v] or ("|cff666666" .. UNKNOWN .. "|r"), ThreatLib:IsCompatible(v) and "" or " - |cffff0000" .. L.version_incompatible))
			end
		end
	end
end

local function NotifyOldClients()
	if not ThreatLib:IsGroupOfficer("player") then
		print(L.message_leader)
		return
	end
	local latestRevision = ThreatLib.latestSeenRevision
	local revisions = ThreatLib.partyMemberRevisions
	local agents = ThreatLib.partyMemberAgents
	if CTM.numGroupMembers > 0 then
		local unit = IsInRaid() and "raid" or "party"
		for i = 1, CTM.numGroupMembers do
			local name = UnitName(unit .. i)
			if name then
				if ThreatLib:IsCompatible(name) then
					if revisions[name] and revisions[name] < latestRevision then
						SendChatMessage(L.message_outdated, "WHISPER", nil, name)
					end
				else
					SendChatMessage(L.message_incompatible, "WHISPER", nil, name)
				end
			end
		end
	end
end

--[[
local function CheckVersionOLD(self, event, prefix, msg, channel, sender)
	if event == "CHAT_MSG_ADDON" then
		if prefix ~= "CTMVer" or sender == playerName then return end
		if tonumber(msg) ~= nil and tonumber(msg) > tonumber(CTM.version) then
			print("|cffff0000"..L.outdated.."|r")
			self.frame:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		if IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
			C_ChatInfo.SendAddonMessage("CTMVer", tonumber(CTM.version), "INSTANCE_CHAT")
		elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
			C_ChatInfo.SendAddonMessage("CTMVer", tonumber(CTM.version), "RAID")
		elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
			C_ChatInfo.SendAddonMessage("CTMVer", tonumber(CTM.version), "PARTY")
		elseif IsInGuild() then
			C_ChatInfo.SendAddonMessage("CTMVer", tonumber(CTM.version), "GUILD")
		end
	end
end
--]]

-----------------------------
-- EVENTS
-----------------------------
CTM.frame = CreateFrame("Frame", CTM.addonName.."BarFrame", UIParent)

CTM.frame:RegisterEvent("PLAYER_LOGIN")
CTM.frame:SetScript("OnEvent", function(self, event, ...)
	return CTM[event] and CTM[event](CTM, event, ...)
end)

function CTM:PLAYER_ENTERING_WORLD(...)
	self.playerName = UnitName("player")

	self.numGroupMembers = IsInRaid() and GetNumGroupMembers() or GetNumSubgroupMembers()

	-- CheckVersionOLD(self, ...)
	CheckStatus()
end

function CTM:PLAYER_TARGET_CHANGED(...)
	self.playerTarget = UnitExists("target") and (UnitIsFriend("player", "target") and "targettarget" or "target")

	C.frame.test = false
	CheckStatus()
end

function CTM:GROUP_ROSTER_UPDATE(...)
	self.numGroupMembers = IsInRaid() and GetNumGroupMembers() or GetNumSubgroupMembers()

	-- CheckVersionOLD(self, ...)
	CheckStatus()
end

function CTM:PLAYER_REGEN_DISABLED(...)
	C.frame.test = false
	ThreatLib.RegisterCallback(self, "ThreatUpdated", CheckStatus)
	CheckStatus()
end

function CTM:PLAYER_REGEN_ENABLED(...)
	-- collectgarbage()
	C.frame.test = false
	ThreatLib.UnregisterCallback(self, "ThreatUpdated", CheckStatus)
	CheckStatus()
end

function CTM:UNIT_THREAT_LIST_UPDATE(...)
	C.frame.test = false
	CheckStatus()
end

function CTM:PLAYER_LOGIN()
	-- C_ChatInfo.RegisterAddonMessagePrefix("CTMVer")

	CTM_Options = CTM_Options or {}
	C = CopyDefaults(self.defaultConfig, CTM_Options)

	-- Minimum of 1 Row
	if not C.bar.count or C.bar.count < 1 then
		C.bar.count = 1
	end

	-- Adjust C.bar.count if it exceed the frame height
	local maxBarCount = floor(C.frame.height / (C.bar.height + C.bar.padding - 1))
	if C.bar.count > maxBarCount then C.bar.count = maxBarCount end

	-- Adjust fonts for CJK
	if self.locale == "koKR" or self.locale == "zhCN" or self.locale == "zhTW" then
		C.font.family = _G.STANDARD_TEXT_FONT
	end

	self:SetupUnits()
	self:SetupFrame()
	self:SetupMenu()

	-- Get Colors
	CTM.colorFallback = {0.8, 0, 0.8, C.bar.alpha}
	CTM.colorMarker = {0.8, 0, 0, C.bar.alpha}

	CTM.threatColors = {
		[0] = C.general.threatColors.good,
		[1] = C.general.threatColors.neutral,
		[2] = C.general.threatColors.neutral,
		[3] = C.general.threatColors.bad
	}

	-- Test Mode
	C.frame.test = false

	if C.general.welcome then
		print("|c00FFAA00"..self.addonName.." v"..self.version.." - "..L.message_welcome.."|r")
	end

	self.frame:RegisterEvent("PLAYER_ENTERING_WORLD")
	self.frame:RegisterEvent("GROUP_ROSTER_UPDATE")
	-- self.frame:RegisterEvent("CHAT_MSG_ADDON")
	self.frame:RegisterEvent("PLAYER_TARGET_CHANGED")
	self.frame:RegisterEvent("PLAYER_REGEN_DISABLED")
	self.frame:RegisterEvent("PLAYER_REGEN_ENABLED")

	if self.classic then
		ThreatLib.RegisterCallback(self, "Activate", CheckStatus)
		ThreatLib.RegisterCallback(self, "Deactivate", CheckStatus)
		ThreatLib.RegisterCallback(self, "ThreatUpdated", CheckStatus)
		ThreatLib:RequestActiveOnSolo(true)
	else
		self.frame:RegisterEvent("UNIT_THREAT_LIST_UPDATE")
	end

	-- Setup Config
	self:SetupConfig()

	self.frame:UnregisterEvent("PLAYER_LOGIN")
	self.PLAYER_LOGIN = nil
end

-----------------------------
-- SETUP
-----------------------------
function CTM:SetupUnits()
	self.partyUnits = {}
	self.partyPetUnits = {}
	self.raidUnits = {}
	self.raidPetUnits = {}
	for i = 1, 4 do
		self.partyUnits[i] = format("party%d", i)
		self.partyPetUnits[i] = format("partypet%d", i)
	end
	for i = 1, 40 do
		self.raidUnits[i] = format("raid%d", i)
		self.raidPetUnits[i] = format("raidpet%d", i)
	end
end

function CTM:SetupFrame()
	self.frame:SetFrameLevel(1)
	self.frame:ClearAllPoints()
	self.frame:SetPoint(unpack(C.frame.position))

	self.frame.bg = self.frame:CreateTexture(nil, "BACKGROUND", nil, -8)
	self.frame.bg:SetColorTexture(1, 1, 1, 1)

	self.frame.resize = CreateFrame("Frame", self.addonName.."Resize", self.frame)
	self.frame.resize:SetPoint("BOTTOMRIGHT", self.frame, "BOTTOMRIGHT", 0, 0)
	self.frame.resize:SetSize(12, 12)
	self.frame.resizeTexture = self.frame.resize:CreateTexture()
	self.frame.resizeTexture:SetTexture([[Interface\ChatFrame\UI-ChatIM-SizeGrabber-Up]])
	self.frame.resizeTexture:SetDesaturated(true)
	self.frame.resizeTexture:SetPoint("TOPLEFT", self.frame.resize)
	self.frame.resizeTexture:SetPoint("BOTTOMRIGHT", self.frame.resize, "BOTTOMRIGHT", 0, 0)

	-- Setup Header
	self.frame.header = CreateStatusBar(self.frame, true)
	self.frame.header:SetScript("OnMouseUp", function(self, button)
		if button == "RightButton" then
			EasyMenu(CTM.menuTable, CTM.menu, "cursor", 0, 0, "MENU")
		end
	end)
	self.frame.header:EnableMouse(true)

	self.frame.header.text = CreateFS(self.frame.header)
	self.frame.header.text:SetPoint("LEFT", self.frame.header, 4, -1)
	self.frame.header.text:SetJustifyH("LEFT")

	self:UpdateFrame()
end

function CTM:SetupMenu()
	self.menu = CreateFrame("Frame", self.addonName.."MenuFrame", UIParent, "UIDropDownMenuTemplate")

	CTM.menuTable = {
		{text = L.frame_lock, notCheckable = false, checked = function() return C.frame.locked end, func = function()
			C.frame.locked = not C.frame.locked
			CTM:UpdateFrame()
		end},
		{text = L.frame_test, notCheckable = false, checked = function() return C.frame.test end, func = function()
			C.frame.test = not C.frame.test
			if C.frame.test then
				CTM:TestMode()
			else
				CheckStatus()
			end
		end},
		{text = L.version_check_all, notCheckable = true, func = function()
			CheckVersion()
		end},
		{text = L.version_check, notCheckable = true, func = function()
			CheckVersion(true)
		end},
		{text = L.gui_config, notCheckable = true, func = function()
			LibStub("AceConfigDialog-3.0"):Open("ClassicThreatMeter")
		end},
	}
end

-----------------------------
-- CONFIG
-----------------------------
function CTM:SetupConfig()
	LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(CTM.addonName, self.configTable)

	local ACD = LibStub("AceConfigDialog-3.0")
	self.config = {}
	self.config.general = ACD:AddToBlizOptions(CTM.addonName, CTM.addonName, nil, "general")
	self.config.appearance = ACD:AddToBlizOptions(CTM.addonName, L.appearance, CTM.addonName, "appearance")
	-- self.config.warnings = ACD:AddToBlizOptions(CTM.addonName, L.warnings, CTM.addonName, "warnings")
	self.config.version = ACD:AddToBlizOptions(CTM.addonName, L.version, CTM.addonName, "version")
end

CTM.configTable = {
	type = "group",
	name = CTM.addonName,
	get = function(info)
		return C[info[1]][info[2]]
	end,
	set = function(info, value) C[info[1]][info[2]] = value end,
	args = {
		general = {
			order = 1,
			type = "group",
			name = L.general,
			args = {
				general = {
					order = 1,
					name = L.general,
					type = "header",
				},
				welcome = {
					order = 2,
					name = L.general_welcome,
					type = "toggle",
					width = "full",
				},
				--[[
				minimap = {
					order = 3,
					name = L.general_test,
					type = "toggle",
					width = "full",
				},
				--]]
				--[[
				ignorePets = {
					order = 4,
					name = L.general_ignorePets,
					type = "toggle",
					width = "full",
				},
				--]]
				visibility = {
					order = 5,
					name = L.visibility,
					type = "header",
				},
				hideOOC = {
					order = 6,
					name = L.visibility_hideOOC,
					type = "toggle",
					width = "full",
					set = function(info, value)
						C[info[1]][info[2]] = value
						CheckStatus()
					end,
				},
				hideSolo = {
					order = 7,
					name = L.visibility_hideSolo,
					type = "toggle",
					width = "full",
					set = function(info, value)
						C[info[1]][info[2]] = value
						CheckStatus()
					end,
				},
				hideInPVP = {
					order = 8,
					name = L.visibility_hideInPvP,
					type = "toggle",
					width = "full",
					set = function(info, value)
						C[info[1]][info[2]] = value
						CheckStatus()
					end,
				},
				nameplates = {
					order = 9,
					name = L.nameplates,
					type = "header",
				},
				nameplateThreat = {
					order = 10,
					name = L.nameplates_enable,
					type = "toggle",
					width = "full",
				},
				invertColors = {
					order = 11,
					name = L.nameplates_invert,
					type = "toggle",
					width = "full",
				},
				threatColors = {
					order = 12,
					name = L.nameplates_colors,
					type = "group",
					inline = true,
					get = function(info)
						return unpack(C[info[1]][info[2]][info[3]])
					end,
					set = function(info, r, g, b)
						local cfg = C[info[1]][info[2]][info[3]]
						cfg[1] = r
						cfg[2] = g
						cfg[3] = b
					end,

					args = {
						good = {
							order = 1,
							name = L.color_good,
							type = "color",
							hasAlpha = false,
						},
						neutral = {
							order = 2,
							name = L.color_neutral,
							type = "color",
							hasAlpha = false,
						},
						bad = {
							order = 3,
							name = L.color_bad,
							type = "color",
							hasAlpha = false,
						},
					},
				},
			},
		},
		appearance = {
			order = 2,
			type = "group",
			name = L.appearance,
			get = function(info)
				return C[info[2]][info[3]]
			end,
			set = function(info, value)
				C[info[2]][info[3]] = value
				C.frame.height = ((C.bar.height + C.bar.padding - 1) * C.bar.count) - C.bar.padding
				CTM:UpdateFrame()
			end,
			args = {
				frame = {
					order = 1,
					name = L.frame,
					type = "group",
					inline = true,
					args = {
						test = {
							order = 1,
							name = L.frame_test,
							type = "execute",
							func = function(info, value)
								C.frame.test = not C.frame.test
								if C.frame.test then
									CTM:TestMode()
								else
									CheckStatus()
								end
							end,
						},
						locked = {
							order = 2,
							name = L.frame_lock,
							type = "toggle",
						},
						strata = {
							order = 3,
							name = L.frame_strata,
							type = "select",
							values = {
								["1-BACKGROUND"] = "BACKGROUND",
								["2-LOW"] = "LOW",
								["3-MEDIUM"] = "MEDIUM",
								["4-HIGH"] = "HIGH",
								["5-DIALOG"] = "DIALOG",
								["6-FULLSCREEN"] = "FULLSCREEN",
								["7-FULLSCREEN_DIALOG"] = "FULLSCREEN_DIALOG",
								["8-TOOLTIP"] = "TOOLTIP",
							},
							style = "dropdown",
						},
						-- width here
						headerShow = {
							order = 4,
							name = L.frame_headerShow,
							type = "toggle",
						},
						scale = {
							order = 5,
							name = L.frame_scale,
							type = "range",
							min = 50,
							max = 300,
							step = 1,
							bigStep = 10,
							get = function(info)
								return C[info[2]][info[3]] * 100
							end,
							set = function(info, value)
								C[info[2]][info[3]] = value / 100
								CTM:UpdateFrame()
							end,
						},
						frameColors = {
							order = 6,
							name = L.color,
							type = "group",
							inline = true,
							get = function(info)
								return unpack(C[info[2]][info[4]])
							end,
							set = function(info, r, g, b, a)
								local cfg = C[info[2]][info[4]]
								cfg[1] = r
								cfg[2] = g
								cfg[3] = b
								cfg[4] = a
								CTM:UpdateFrame()
							end,

							args = {
								color = {
									order = 1,
									name = L.frame_bg,
									type = "color",
									hasAlpha = true,
								},
								headerColor = {
									order = 2,
									name = L.frame_header,
									type = "color",
									hasAlpha = true,
								},
							},
						},
					},
				},
				bar = {
					order = 2,
					name = L.bar,
					type = "group",
					inline = true,
					args = {
						count = {
							order = 1,
							name = L.bar_count,
							type = "range",
							min = 1,
							max = 40,
							step = 1,
							set = function(info, value)
								local prev = C[info[2]][info[3]]
								C[info[2]][info[3]] = value
								if prev > value then
									for i = value + 1, prev do
										CTM.bars[i]:Hide()
									end
								end
								C.frame.height = ((C.bar.height + C.bar.padding - 1) * C.bar.count) - C.bar.padding
								CTM:UpdateFrame()
							end,
						},
						-- growth direction
						height = {
							order = 3,
							name = L.bar_height,
							type = "range",
							min = 6,
							max = 64,
							step = 1,
						},
						padding = {
							order = 4,
							name = L.bar_padding,
							type = "range",
							min = 0,
							max = 16,
							step = 1,
						},
						-- marker
						-- texture
						-- custom color / class color
						-- alpha (for when using class colors)
						-- color / colormod
					},
				},
				font = {
					order = 3,
					name = L.font,
					type = "group",
					inline = true,
					args = {
						-- name
						size = {
							order = 2,
							name = L.font_size,
							type = "range",
							min = 6,
							max = 64,
							step = 1,
						},
						style = {
							order = 3,
							name = L.font_style,
							type = "select",
							values = {
								[""] = "NONE",
								["OUTLINE"] = "OUTLINE",
								["THICKOUTLINE"] = "THICKOUTLINE",
							},
							style = "dropdown",
						},
						shadow = {
							order = 4,
							name = L.font_shadow,
							type = "toggle",
							width = "full",
						},
					},
				},
				reset = {
					order = 4,
					name = L.reset,
					type = "execute",
					func = function(info, value)
						CTM_Options = {}
						C = CopyDefaults(CTM.defaultConfig, CTM_Options)
						CTM:UpdateFrame()
					end,
				},
			},
		},
		--[[
		warnings = {
			order = 3,
			type = "group",
			name = L.warnings,
			args = {
				visual = {
					order = 1,
					name = L.warnings_visual,
					type = "toggle",
					width = "full",
				},
				sounds = {
					order = 2,
					name = L.warnings_sounds,
					type = "toggle",
					width = "full",
				},
				threshold = {
					order = 3,
					name = L.warnings_threshold,
					type = "range",
					min = 50,
					max = 100,
					step = 1,
					bigStep = 10,
					-- get / set
				},
				warningFile = {
					order = 4,
					name = L.sound_warningFile,
					type = "toggle",
					width = "full",
				},
				pulledFile = {
					order = 5,
					name = L.sound_pulledFile,
					type = "toggle",
					width = "full",
				},
			},
		},
		--]]
		version = {
			order = 4,
			type = "group",
			name = L.version,
			args = {
				version = {
					order = 1,
					name = L.version,
					type = "header",
				},
				version_check = {
					order = 2,
					name = L.version_check,
					type = "execute",
					func = function(info, value)
						CheckVersion()
					end,
				},
				version_check_all = {
					order = 3,
					name = L.version_check_all,
					type = "execute",
					func = function(info, value)
						CheckVersion(true)
					end,
				},
				version_notify = {
					order = 4,
					name = L.version_notify,
					type = "execute",
					func = function(info, value)
						NotifyOldClients()
					end,
				},
			},
		},
	},
}

SLASH_CLASSICTHREATMETER1 = "/ctm"
SLASH_CLASSICTHREATMETER2 = "/threat"
SLASH_CLASSICTHREATMETER3 = "/classicthreatmeter"
SlashCmdList["CLASSICTHREATMETER"] = function()
	LibStub("AceConfigDialog-3.0"):Open("ClassicThreatMeter")
end
