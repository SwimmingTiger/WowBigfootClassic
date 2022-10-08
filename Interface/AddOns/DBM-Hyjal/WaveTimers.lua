local mod	= DBM:NewMod("HyjalWaveTimers", "DBM-Hyjal")
local L		= mod:GetLocalizedStrings()

mod:SetRevision("20220923022829")

mod:RegisterEvents(
	"GOSSIP_SHOW",
	"QUEST_PROGRESS",
	"UPDATE_UI_WIDGET",
	"UNIT_DIED",
	"SPELL_AURA_APPLIED"
)
mod.noStatistics = true

local warnWave			= mod:NewAnnounce("WarnWave", 1)
local warnCannibalize	= mod:NewSpellAnnounce(31538, 2)

local timerWave			= mod:NewTimer(125, "TimerWave", nil, nil, nil, 1)

mod:AddBoolOption("DetailedWave")

local lastWave = 0
local boss = 0
local bossNames = {
	[0] = L.GeneralBoss,
	[1] = L.RageWinterchill,
	[2] = L.Anetheron,
	[3] = L.Kazrogal,
	[4] = L.Azgalor
}

function mod:GOSSIP_SHOW()
	if  GetRealZoneText() ~= L.HyjalZoneName then return end
	local target = UnitName("target")
	if target == L.Thrall or target == L.Jaina then
		local table = C_GossipInfo and C_GossipInfo.GetOptions and C_GossipInfo.GetOptions()
		local selection
		if table and table[1] and table[1].name then
			selection = table[1].name
		else
			selection = GetGossipOptions()
		end
		if selection then
			if selection == L.RageGossip then
				boss = 1
				self:SendSync("boss", 1)
			elseif selection == L.AnetheronGossip then
				boss = 2
				self:SendSync("boss", 2)
			elseif selection == L.KazrogalGossip or (L.KazrogalGossipF and selection == L.KazrogalGossipF) then
				boss = 3
				self:SendSync("boss", 3)
			elseif selection == L.AzgalorGossip or (L.AzgalorGossipF and selection == L.AzgalorGossipF) then
				boss = 4
				self:SendSync("boss", 4)
			end
		end
	end
end
mod.QUEST_PROGRESS = mod.GOSSIP_SHOW

function mod:UPDATE_UI_WIDGET(table)
	local id = table.widgetID
	if not (id == 528 or id == 3121) then return end
	local widgetInfo = C_UIWidgetManager.GetIconAndTextWidgetVisualizationInfo(id)
	local text = widgetInfo.text
	if not text then return end
	local currentWave = text:match("(%d)")
	if not currentWave then
		currentWave = 0
	end
	self:WaveFunction(currentWave)
end

function mod:OnSync(msg, arg, sender)
	if msg == "boss" and sender then
		boss = tonumber(arg)
	end
end

function mod:UNIT_DIED(args)
	local cid = self:GetCIDFromGUID(args.destGUID)
	if cid == 17852 or cid == 17772 then
		lastWave = 0
		timerWave:Cancel()
	elseif cid == 17767 then
		self:SendSync("boss", 2)
	elseif cid == 17808 then
		self:SendSync("boss", 3)
	elseif cid == 17888 then
		self:SendSync("boss", 4)
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 31538 then
		warnCannibalize:Show()
	end
end

function mod:WaveFunction(currentWave)
	local timer = 0
	currentWave = tonumber(currentWave)
	if currentWave > lastWave then
		if boss == 0 then--unconfirmed
			timer = 125
			warnWave:Show(L.WarnWave_0:format(currentWave))
		elseif boss == 1 or boss == 2 then
			timer = 125
			if currentWave == 8 then
				timer = 140
			end
			if self.Options.DetailedWave and boss == 1 then
				if currentWave == 1 then
					warnWave:Show(L.WarnWave_1:format(currentWave, 10, L.Ghoul))
				elseif currentWave == 2 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 10, L.Ghoul, 2, L.Fiend))
				elseif currentWave == 3 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 6, L.Ghoul, 6 , L.Fiend))
				elseif currentWave == 4 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 6, L.Ghoul, 4, L.Fiend, 2, L.Necromancer))
				elseif currentWave == 5 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 2, L.Ghoul, 6, L.Fiend, 4, L.Necromancer))
				elseif currentWave == 6 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 6, L.Ghoul, 6, L.Abomination))
				elseif currentWave == 7 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 4, L.Ghoul, 4, L.Abomination, 4, L.Necromancer))
				elseif currentWave == 8 then
					warnWave:Show(L.WarnWave_4:format(currentWave, 6, L.Ghoul, 4, L.Fiend, 2, L.Abomination, 2, L.Necromancer))
				end
			elseif self.Options.DetailedWave and boss == 2 then
				if currentWave == 1 then
					warnWave:Show(L.WarnWave_1:format(currentWave, 10, L.Ghoul))
				elseif currentWave == 2 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 8, L.Ghoul, 4, L.Abomination))
				elseif currentWave == 3 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 4, L.Ghoul, 4, L.Fiend, 4, L.Necromancer))
				elseif currentWave == 4 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 6, L.Fiend, 4, L.Necromancer, 2, L.Banshee))
				elseif currentWave == 5 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 6, L.Ghoul, 4, L.Banshee, 2, L.Necromancer))
				elseif currentWave == 6 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 6, L.Ghoul, 2, L.Abomination, 4, L.Necromancer))
				elseif currentWave == 7 then
					warnWave:Show(L.WarnWave_4:format(currentWave, 2, L.Ghoul, 4, L.Fiend, 4, L.Abomination, 4, L.Banshee))
				elseif currentWave == 8 then
					warnWave:Show(L.WarnWave_5:format(currentWave, 3, L.Ghoul, 3, L.Fiend, 4, L.Abomination, 2, L.Necromancer, 2, L.Banshee))
				end
			else
				warnWave:Show(L.WarnWave_0:format(currentWave))
			end
			self:SendSync("boss", boss)
		elseif boss == 3 or boss == 4 then
			timer = 135
			if currentWave == 2 or currentWave == 4 then
				timer = 165
			elseif currentWave == 3 then
				timer = 160
			elseif currentWave == 7 then
				timer = 195
			elseif currentWave == 8 then
				timer = 225
			end
			if self.Options.DetailedWave and boss == 3 then
				if currentWave == 1 then
					warnWave:Show(L.WarnWave_4:format(currentWave, 4, L.Ghoul, 4, L.Abomination, 2, L.Necromancer, 2, L.Banshee))
				elseif currentWave == 2 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 4, L.Ghoul, 10, L.Gargoyle))
				elseif currentWave == 3 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 6, L.Ghoul, 6, L.Fiend, 2, L.Necromancer))
				elseif currentWave == 4 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 6, L.Fiend, 2, L.Necromancer, 6, L.Gargoyle))
				elseif currentWave == 5 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 4, L.Ghoul, 6, L.Abomination, 4, L.Necromancer))
				elseif currentWave == 6 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 8, L.Gargoyle, 1, L.Wyrm))
				elseif currentWave == 7 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 6, L.Ghoul, 4, L.Abomination, 1, L.Wyrm))
				elseif currentWave == 8 then
					warnWave:Show(L.WarnWave_5:format(currentWave, 6, L.Ghoul, 2, L.Fiend, 4, L.Abomination, 2, L.Necromancer, 2, L.Banshee))
				end
			elseif self.Options.DetailedWave and boss == 4 then
				if currentWave == 1 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 6, L.Abomination, 6, L.Necromancer))
				elseif currentWave == 2 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 5, L.Ghoul, 8, L.Gargoyle, 1, L.Wyrm))
				elseif currentWave == 3 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 6, L.Ghoul, 8, L.Infernal))
				elseif currentWave == 4 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 6, L.Stalker, 8, L.Infernal))
				elseif currentWave == 5 then
					warnWave:Show(L.WarnWave_3:format(currentWave, 4, L.Abomination, 4, L.Necromancer, 6, L.Stalker))
				elseif currentWave == 6 then
					warnWave:Show(L.WarnWave_2:format(currentWave, 6, L.Necromancer, 6, L.Banshee))
				elseif currentWave == 7 then
					warnWave:Show(L.WarnWave_4:format(currentWave, 2, L.Ghoul, 2, L.Fiend, 2, L.Stalker, 8, L.Infernal))
				elseif currentWave == 8 then
					warnWave:Show(L.WarnWave_5:format(currentWave, 4, L.Abomination, 4, L.Fiend, 2, L.Necromancer, 2, L.Stalker, 4, L.Banshee))
				end
			else
				warnWave:Show(L.WarnWave_0:format(currentWave))
			end
			self:SendSync("boss", boss)
		end
		timerWave:Start(timer)
		lastWave = currentWave
	elseif lastWave > currentWave then
		if lastWave == 8 then
			warnWave:Show(bossNames[boss])
		end
		timerWave:Cancel()
		lastWave = currentWave
	end
end
