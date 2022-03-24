if WOW_PROJECT_ID ~= (WOW_PROJECT_MAINLINE or 1) then -- Added in Legion
	return
end
local mod	= DBM:NewMod("z1803", "DBM-PvP")

mod:SetRevision("20220126115338")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA"
)

do
	local bgzone = false

	local function Init(self)
		local zoneID = DBM:GetCurrentArea()
		if not bgzone and zoneID == 1803 then
			bgzone = true
			self:RegisterShortTermEvents("VIGNETTES_UPDATED")
		elseif bgzone and zoneID ~= 1803 then
			bgzone = false
			self:UnregisterShortTermEvents()
			self:Stop()
		end
	end

	function mod:LOADING_SCREEN_DISABLED()
		self:Schedule(1, Init, self)
	end
	mod.ZONE_CHANGED_NEW_AREA	= mod.LOADING_SCREEN_DISABLED
	mod.PLAYER_ENTERING_WORLD	= mod.LOADING_SCREEN_DISABLED
	mod.OnInitialize			= mod.LOADING_SCREEN_DISABLED
end

do
	local knownAzerite = {}
	local azeriteNames = {
		["0.47:0.28"] = "Tar Pits",
		["0.53:0.4"] = "Bonfire",
		["0.39:0.75"] = "Overlook",
		["0.57:0.26"] = "Temple",
		["0.6:0.55"] = "Shipwreck",
		["0.45:0.58"] = "Ridge",
		["0.6:0.36"] = "Tide Pools",
		["0.25:0.43"] = "Ruins",
		["0.29:0.77"] = "Crash Site",
		["0.35:0.25"] = "Tower",
		["0.39:0.43"] = "Plunge",
		["0.29:0.56"] = "Waterfall"
	}

	local ipairs, mfloor = ipairs, math.floor
	local C_VignetteInfo = C_VignetteInfo

	local spawnTimer = mod:NewTimer(30, "TimerSpawn", "1864730") -- interface/lfgframe/lfgicon-seethingshore.blp

	local function Round(num)
		return mfloor(num * 10 ^ 2 + 0.5) / 10 ^ 2
	end

	function mod:VIGNETTES_UPDATED()
		local checkedThisRound = {}
		for _, v in ipairs(C_VignetteInfo.GetVignettes()) do
			local vignette = C_VignetteInfo.GetVignetteInfo(v)
			if vignette and vignette.vignetteGUID then
				local poss = C_VignetteInfo.GetVignettePosition(vignette.vignetteGUID, 907)
				if not poss or poss.x == 0 or poss.y == 0 then
					DBM:Debug(("Hello? Vignette position is empty. X: %f, Y: %f"):format(poss.x or "nil", poss.y or "nil"))
					return
				end
				local pos = Round(poss.x) .. ":" .. Round(poss.y)
				if not azeriteNames[pos] then
					DBM:Debug(("Found azerite at position unknown: (%s) %f, %f"):format(pos, poss.x, poss.y))
				end
				checkedThisRound[pos] = true
				if not knownAzerite[pos] then
					knownAzerite[pos] = true
					local atlasName = vignette.atlasName
					if atlasName == "AzeriteSpawning" then
						spawnTimer:Start(30, azeriteNames[pos])
					elseif atlasName == "AzeriteReady" then
						spawnTimer:Stop(azeriteNames[pos])
					end
				end
			end
		end
		for k, _ in pairs(knownAzerite) do
			if not checkedThisRound[k] then
				knownAzerite[k] = nil
			end
		end
	end
end
