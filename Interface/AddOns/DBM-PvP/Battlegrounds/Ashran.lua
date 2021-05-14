if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	return
end
local mod	= DBM:NewMod("z1191", "DBM-PvP")

mod:SetRevision("20210419223508")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA"
)

mod:AddBoolOption("AutoTurnIn")

do
	local bgzone = false

	local function Init(self)
		local zoneID = DBM:GetCurrentArea()
		if not bgzone and zoneID == 1191 then
			bgzone = true
			self:RegisterShortTermEvents(
				"GOSSIP_SHOW",
				"QUEST_PROGRESS",
				"QUEST_COMPLETE"
			)
		elseif bgzone and zoneID ~= 1191 then
			bgzone = false
			self:UnregisterShormTermEvents()
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
	local UnitGUID, GetCurrencyInfo, GetNumGossipOptions, SelectGossipOption = UnitGUID, C_CurrencyInfo.GetCurrencyInfo, C_GossipInfo.GetNumOptions, C_GossipInfo.SelectOption

	function mod:GOSSIP_SHOW()
		if not self.Options.AutoTurnIn then
			return
		end
		local cid = self:GetCIDFromGUID(UnitGUID("target") or "")
		if cid == 81870 or cid == 82204 then -- Anenga (Alliance) | Atomik (Horde)
			local _, currency = GetCurrencyInfo(944) -- Artifact Fragment
			if currency > 0 and GetNumGossipOptions() == 3 then -- If boss isn't already summoned
				SelectGossipOption(1)
			end
		end
	end
end
