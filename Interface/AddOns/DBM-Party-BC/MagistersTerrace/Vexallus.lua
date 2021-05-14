local mod = DBM:NewMod(531, "DBM-Party-BC", 16, 249)
local L = mod:GetLocalizedStrings()


mod:SetRevision("20210401043939")

mod:SetCreatureID(24744)
mod:SetEncounterID(1898)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"CHAT_MSG_RAID_BOSS_EMOTE"
)

--TODO, see if TW matters enough to rotate dps for this warning. In original BC dps took turns because killing spark applies debuff/dot
local specWarnEnergy	= mod:NewSpecialWarningSwitch("ej5085", "-Healer", nil, 3, 1, 2)

--[[
	"<11.24 20:39:02> [UNIT_SPELLCAST_SUCCEEDED] Vexallus(Omegal) [target:Summon Pure Energy::0:46154]", -- [22]
	"<11.25 20:39:02> [UNIT_SPELLCAST_SUCCEEDED] Vexallus(Omegal) [target:Summon Pure Energy::0:46159]", -- [23]
	"<11.27 20:39:02> [CHAT_MSG_RAID_BOSS_EMOTE] Vexallus discharges pure energy!#Vexallus#####0#0##0#675#nil#0#false#false#false#false", -- [24]
	"<11.27 20:39:02> [RAID_BOSS_EMOTE] Vexallus discharges pure energy!#Vexallus#0#true", -- [25]
	"<11.27 20:39:02> [CHAT_MSG_MONSTER_YELL] Un...con...tainable.#Vexallus#####0#0##0#676#nil#0#false#false#false#false", -- [26]
--]]
--Should be good enough,no translation. He doesn't emote anything else
function mod:CHAT_MSG_RAID_BOSS_EMOTE(msg)
	if self:AntiSpam(5, 1) then
		specWarnEnergy:Show()
		specWarnEnergy:Play("killmob")
	end
end
