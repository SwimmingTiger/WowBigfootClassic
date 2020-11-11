if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z1803", "DBM-PvP")

mod:SetRevision("20201018212526")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents("ZONE_CHANGED_NEW_AREA")

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

do
	local knownAzerite = {}
	local azeriteNames = {
		["0.47:0.28"] = "Tar Pits",
		["0.53:0.40"] = "Bonfire",
		["0.39:0.75"] = "Overlook",
		["0.57:0.26"] = "Temple",
		["0.60:0.55"] = "Shipwreck",
		["0.45:0.58"] = "Ridge",
		["0.60:0.36"] = "Tide Pools",
		["0.25:0.43"] = "Ruins",
		["0.29:0.77"] = "Crash Site",
		["0.35:0.25"] = "Tower",
		["0.39:0.43"] = "Plunge",
		["0.29:0.56"] = "Waterfall"
	}

	local function round(num)
		return math.floor(num * 10 ^ 2 + 0.5) / 10 ^ 2
	end

	local ipairs = ipairs
	local C_VignetteInfo = C_VignetteInfo
	local spawnTimer = mod:NewTimer(30, "TimerSpawn", "1864730") -- interface/lfgframe/lfgicon-seethingshore.blp

	function mod:VIGNETTES_UPDATED()
		local checkedThisRound = {}
		local vignetteids = C_VignetteInfo.GetVignettes()
		for i = 1, #vignetteids do
			local vignette = C_VignetteInfo.GetVignetteInfo(vignetteids[i])
			if vignette and vignette.vignetteGUID then
				local poss = C_VignetteInfo.GetVignettePosition(vignette.vignetteGUID, 907)
				if not poss then
					return
				end
				local pos = round(poss.x) .. ":" .. round(poss.y)
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
		end
		for _, v in ipairs(knownAzerite) do
			if not checkedThisRound[v] then
				knownAzerite[v] = false
			end
		end
	end
end
