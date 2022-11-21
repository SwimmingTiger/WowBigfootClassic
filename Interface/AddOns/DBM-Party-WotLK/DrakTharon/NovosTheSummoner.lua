local mod	= DBM:NewMod(589, "DBM-Party-WotLK", 4, 273)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20221013055519")
mod:SetCreatureID(26631)
mod:SetEncounterID(1976)

mod:RegisterCombat("yell", L.YellPull)--Also started by ES
mod:RegisterKill("yell", L.YellKill)
mod:SetWipeTime(25)

mod:RegisterEventsInCombat(
	"CHAT_MSG_MONSTER_YELL"
)

local WarnCrystalHandler, timerCrystalHandler
if mod:IsClassic() then
	WarnCrystalHandler			= mod:NewAddsLeftAnnounce(49179, 2, 59910)
	timerCrystalHandler 		= mod:NewNextTimer(15.5, 49179, nil, nil, nil, 1, 59910, DBM_COMMON_L.DAMAGE_ICON)
else
	WarnCrystalHandler			= mod:NewAddsLeftAnnounce("ej6378", 2, 59910)
	timerCrystalHandler 		= mod:NewNextTimer(15.5, "ej6378", nil, nil, nil, 1, 59910, DBM_COMMON_L.DAMAGE_ICON)
end
local warnPhase2				= mod:NewPhaseAnnounce(2)

mod.vb.CrystalHandlers = 4

function mod:OnCombatStart(delay)
	timerCrystalHandler:Start(15.9-delay)
	self.vb.CrystalHandlers = 4
end

function mod:CHAT_MSG_MONSTER_YELL(msg)
	if msg == L.HandlerYell then
		self.vb.CrystalHandlers = self.vb.CrystalHandlers - 1
		WarnCrystalHandler:Show(self.vb.CrystalHandlers)
		if self.vb.CrystalHandlers > 0 then
			timerCrystalHandler:Start()
		end
	elseif msg == L.Phase2 then
		warnPhase2:Show()
	end
end
