if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z1803", "DBM-PvP")

mod:SetRevision("20190908230518")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)

mod:RegisterEvents(
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false

	function mod:OnInitialize()
		if DBM:GetCurrentArea() == 1803 then
			bgzone = true
			self:RegisterShortTermEvents("VIGNETTES_UPDATED")
		elseif bgzone then
			bgzone = false
			self:UnregisterShortTermEvents()
			self:Stop()
		end
	end

	function mod:ZONE_CHANGED_NEW_AREA()
		self:ScheduleMethod(1, "OnInitialize")
	end
end

local knownAzerite = {}
local azeriteNames = {
	["0.47092604637146:0.28263652324677"] = "Tar Pits",
	["0.52734065055847:0.40052092075348"] = "Bonfire",
	["0.39050829410553:0.74987065792084"] = "Overlook",
	["0.57185626029968:0.26327902078629"] = "Temple",
	["0.59859085083008:0.55294859409332"] = "Shipwreck",
	["0.44978791475296:0.57673597335815"] = "Ridge",
	["0.59923923015594:0.35815006494522"] = "Tide Pools",
	["0.25294327735901:0.4272882938385"] = "Ruins",
	["0.28562754392624:0.76878190040588"] = "Crash Site",
	["0.34885621070862:0.25247144699097"] = "Tower",
	["0.38610309362411:0.43347764015198"] = "Plunge",
	["0.28985452651978:0.55555701255798"] = "Waterfall"
}

local ipairs = ipairs
local C_VignetteInfo = C_VignetteInfo
local spawnTimer = mod:NewTimer(30, "TimerSpawn", "1864730") -- interface/lfgframe/lfgicon-seethingshore.blp

function mod:VIGNETTES_UPDATED()
	local checkedThisRound = {}
	local vignetteids = C_VignetteInfo.GetVignettes()
	for i = 1, #vignetteids do
		local vignette = C_VignetteInfo.GetVignetteInfo(vignetteids[i])
		local x, y = C_VignetteInfo.GetVignettePosition(vignette.vignetteGUID, 1803):GetXY()
		local pos = x .. ":" .. y
		checkedThisRound[pos] = true
		if not knownAzerite[pos] then
			knownAzerite[pos] = true
			local atlasName = vignette.atlasName
			if atlasName == "AzeriteSpawning" then
				spawnTimer:Start(nil, azeriteNames[pos])
			elseif atlasName == "AzeriteReady" then
				spawnTimer:Stop(azeriteNames[pos])
			end
		end
	end
	for _, v in ipairs(knownAzerite) do
		if not checkedThisRound[v] then
			knownAzerite[v] = false
		end
	end
end
