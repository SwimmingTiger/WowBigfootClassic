if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

local SpellIDs = TotemTimers.SpellIDs
local SpellNames = TotemTimers.SpellNames


function TotemTimers.OrderCDs(role)
    for i = 1,#TotemTimers.ActiveProfile.EnhanceCDs_Order[tonumber(role)] do
        if TotemTimers.options.args.enhancecds.args[role].args[tostring(TotemTimers.ActiveProfile.EnhanceCDs_Order[tonumber(role)][i])] then
            TotemTimers.options.args.enhancecds.args[role].args[tostring(TotemTimers.ActiveProfile.EnhanceCDs_Order[tonumber(role)][i])].order = i+10
        end
    end
end

local function changeOrder(spell, dir, role)
    role = tonumber(role)
    for i=1,TotemTimers.num_CD_Spells[role] do
        if TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i] == spell and i+dir>0 and i+dir<=TotemTimers.num_CD_Spells[role] then
            TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i],TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i+dir] =
                    TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i+dir],TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i]
            break
        end
    end
    TotemTimers.OrderCDs(tostring(role))
    TotemTimers.ProcessSetting("EnhanceCDs")
end

TotemTimers.options.args.enhancecds = {
    type = "group",
    name = "enhancecds",
    args = {
        enable = {
            order = 0,
            type = "toggle",
            name = L["Enable"],
            set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
            get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs end,
        },
       --[[ header = {
            order = 10,
            type = "header",
            name = "",
        }, ]]   
        clickthrough = {
            order = 1,
            type = "toggle", 
            name = L["Clickthrough"],
            desc = L["Clickthrough Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Clickthrough = val  TotemTimers.ProcessSetting("EnhanceCDs_Clickthrough") end,
            get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Clickthrough end,
        },
        CDTimersOnButtons = {
            order = 11,
            type = "toggle",
            name = L["Timers On Buttons"],
            set = function(info, val) TotemTimers.ActiveProfile.CDTimersOnButtons = val
                        TotemTimers.ProcessSetting("TimersOnButtons") end,
            get = function(info) return TotemTimers.ActiveProfile.CDTimersOnButtons end,
        },  
        HideEnhanceCDsOOC = {
            order = 12,
            type = "toggle",
            name = L["Hide out of combat"],
            desc = L["Hide OOC Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.HideEnhanceCDsOOC = val  TotemTimers.ProcessSetting("HideEnhanceCDsOOC") end,
            get = function(info) return TotemTimers.ActiveProfile.HideEnhanceCDsOOC end,
        }, 
        FlameShockOnTop = {
            order = 12,
            type = "toggle", 
            name = L["Flame Shock on top"],
            desc = L["Flame Shock on top desc"],
            set = function(info, val) TotemTimers.ActiveProfile.FlameShockDurationOnTop = val  TotemTimers.LayoutEnhanceCDs() end,
            get = function(info) return TotemTimers.ActiveProfile.FlameShockDurationOnTop end, 
        },
		spacing = {
            order = 13,
            type = "range",
            name = L["Spacing"] ,
            desc = L["Sets the space between timer buttons"],
            min = 0,
            max = 20,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.CooldownSpacing = val  TotemTimers.ProcessSetting("CooldownSpacing")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.CooldownSpacing end,
        },
        OOCAlpha = {
            order = 13,
            type="range",
            min = 0,
            max = 1,
            step = 0.1,
            name = L["OOC Alpha"], 
            desc = L["OOC Alpha Desc"],
            set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsOOCAlpha = val  TotemTimers.ProcessSetting("EnhanceCDsOOCAlpha")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.EnhanceCDsOOCAlpha end,
        },
        --[[scaling = {
            order = 20,
            type = "header",
            name = "Scaling",
        },]]
        ECDSize = {
            order = 21,
            type = "range",
            name = L["ECD Button Size"] ,
            min = 16,
            max = 96,
            step = 1,
            bigStep = 2,
            set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsSize = val  TotemTimers.ProcessSetting("EnhanceCDsSize")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.EnhanceCDsSize end,
        },
        ECDfontSize = {
            order = 22,
            type = "range",
            name = L["ECD Font Size"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsTimeHeight = val  TotemTimers.ProcessSetting("EnhanceCDsTimeHeight")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.EnhanceCDsTimeHeight end,
        },
        maelstromheight = {
            order = 23,
            type = "range",
            name = L["Maelstrom Bar Height"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsMaelstromHeight = val  TotemTimers.ProcessSetting("EnhanceCDsMaelstromHeight")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.EnhanceCDsMaelstromHeight end,
        },
		lc = {
			order = 24,
			type = "header",
			name = L["Long Cooldowns"],
		},
		lcenable = {
			order = 25,
			type = "toggle",
			name = L["Enable"],
			set = function(info, val)
				TotemTimers.ActiveProfile.LongCooldowns = val TotemTimers.ProcessSetting("LongCooldowns")
			end,
			get = function(info) return TotemTimers.ActiveProfile.LongCooldowns end
		},
		lcarrange = {
			order = 26,
			type = "select",
            name = L["Arrangement"],
            values = {vertical = L["vertical"], horizontal = L["horizontal"],},
            set = function(info, val)
                        TotemTimers.ActiveProfile.LongCooldownsArrange = val
                        TotemTimers.LayoutLongCooldowns()
                  end,
            get = function(info) return TotemTimers.ActiveProfile.LongCooldownsArrange end,
		},
		spells = {
			order = 29,
			type = "header",
			name = L["Spells"],
		},
        ["2"] = {
            order = 30,
            type = "group",
            name = select(2,GetSpecializationInfo(2)) or "Enhancement",
            args = {
                stormstrike = {
                    order = 1,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.StormStrike),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][1] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][1] end,
                },
                earthshock = {
                    order = 2,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FlameShock).."/"..GetSpellInfo(SpellIDs.FrostShock),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][2] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][2] end,
                },
                lavalash = {
                    order = 3,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.LavaLash),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][3] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][3] end,
                },
                firenova = {
                    order = 4,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FireNova),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][4] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][4] end,
                },
                Searing = {
                    order = 5,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.Searing),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][5] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][5] end,
                },
                shamanisticrage = {
                    order = 6,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.ShamanisticRage),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][6] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][6] end,
                },
                windshear = {
                    order = 7,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.WindShear),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][7] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][7] end,
                },
                lightningshield = {
                    order = 8,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.LightningShield),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][8] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][8] end,
                },
                unleashelements = {
                    order = 9,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.UnleashElements),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][9] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][9] end,
                },
				elementalblast = {
                    order = 10,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.ElementalBlast),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][10] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][10] end,
                },
				spiritwalk = {
                    order = 11,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.SpiritWalk),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][11] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][11] end,
                },
                flameshock = {
                    order = 29,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FlameShock).." ("..L["Duration"]..")",
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][21] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][21] end,
                }, 
                maelstrom = {
                    order = 31,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.Maelstrom),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][22] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][22] end,
                }, 
				liquidmagma = {
                    order = 32,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.LiquidMagma),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][12] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][12] end,
                }, 
            },
        },
        ["1"] = {
            order = 40,
            type = "group",
            name = select(2,GetSpecializationInfo(1)) or "Elemental",
            args = {
                flameshock = {
                    order = 1,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FlameShock).."/"..GetSpellInfo(SpellIDs.EarthShock),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][1] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][1] end,
                },
                lavaburst = {
                    order = 2,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.LavaBurst),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][2] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][2] end,
                },
                thunderstorm = {
                    order = 3,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.Thunderstorm),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][3] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][3] end,
                },
                searing = {
                    order = 4,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.Searing),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][4] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][4] end,
                },
                lightningshield = {
                    order = 5,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.LightningShield),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][5] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][5] end,
                },
                windshear = {
                    order = 6,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.WindShear),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][6] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][6] end,
                },
                unleashflame = {
                    order = 7,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.UnleashFlameEle),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][7] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][7] end,
                },
				elementalblast = {
                    order = 8,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.ElementalBlast),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][8] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][8] end,
                },
				liquidmagma = {
                    order = 9,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.LiquidMagma),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][9] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][9] end,
                },
                flameshockduration = {
                    order = 30,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FlameShock).." ("..L["Duration"]..")",
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][20] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][20] end,
                }, 
            },
        },
        ["3"] = {
            order = 50,
            type = "group",
            name = select(2,GetSpecializationInfo(3)) or "Restoration",
            args = {
                riptide = {
                    order = 1,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.Riptide),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][1] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][1] end,
                },
                healingrain = {
                    order = 2,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.HealingRain),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][2] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][2] end,
                },
                watershield = {
                    order = 3,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.WaterShield),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][3] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][3] end,
                },
                earthshock = {
                    order = 4,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.EarthShock),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][4] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][4] end,
                },
                windshear = {
                    order = 5,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.WindShear),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][5] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][5] end,
                },
                unleashelements = {
                    order = 6,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.UnleashLife),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][6] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][6] end,
                },
				purifyspirit = {
                    order = 7,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.PurifySpirit),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][7] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][7] end,
                },
				elementalblast = {
                    order = 8,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.ElementalBlast),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][8] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][8] end,
                },
				chainheal = {
                    order = 9,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.ChainHeal),
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][9] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][9] end,
                },
                flameshockduration = {
                    order = 30,
                    type = "toggle",
                    name = GetSpellInfo(SpellIDs.FlameShock).." ("..L["Duration"]..")",
                    set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][20] = val  TotemTimers.ProcessSetting("EnhanceCDs") end,
                    get = function(info) return TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][20] end,
                }, 
            },
        },
		["4"] = {
			order = 60,
			type="group",
			name = L["Long Cooldowns"],
			args = {
				bloodlust = {
                    order = 1,
                    type = "toggle",
                    name = SpellNames[SpellIDs.Bloodlust].."/"..SpellNames[SpellIDs.Heroism],
                    set = function(info, val) TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.Bloodlust] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.Bloodlust] end,
                },
				spiritwalkersgrace = {
                    order = 3,
                    type = "toggle",
                    name = SpellNames[SpellIDs.SpiritwalkersGrace],
                    set = function(info, val) TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.SpiritwalkersGrace] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.SpiritwalkersGrace] end,
                },
				astralshift = {
                    order = 7,
                    type = "toggle",
                    name = SpellNames[SpellIDs.AstralShift],
                    set = function(info, val) TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.AstralShift] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.AstralShift] end,
                },
				AncestralGuidance = {
                    order = 4,
                    type = "toggle",
                    name = SpellNames[SpellIDs.AncestralGuidance],
                    set = function(info, val) TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.AncestralGuidance] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.AncestralGuidance] end,
                },
				CallOfElements = {
                    order = 5,
                    type = "toggle",
                    name = SpellNames[SpellIDs.CallOfElements],
                    set = function(info, val) TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.CallOfElements] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.CallOfElements] end,
                },
				ElementalMastery = {
                    order = 6,
                    type = "toggle",
                    name = SpellNames[SpellIDs.ElementalMastery],
                    set = function(info, val) TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.ElementalMastery] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.ElementalMastery] end,
                },
				AncestralSwiftness = {
                    order = 7,
                    type = "toggle",
                    name = SpellNames[SpellIDs.AncestralSwiftness],
                    set = function(info, val) TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.AncestralSwiftness] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.AncestralSwiftness] end,
                },
				Ascendance = {
                    order = 2,
                    type = "toggle",
                    name = SpellNames[SpellIDs.Ascendance],
                    set = function(info, val) TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.Ascendance] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.Ascendance] end,
                },
				feralspirit = {
                    order = 9,
                    type = "toggle",
                    name = SpellNames[SpellIDs.FeralSpirit],
                    set = function(info, val)TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.FeralSpirit] = val  TotemTimers.ProcessSetting("LongCooldowns") end,
                    get = function(info) return TotemTimers.ActiveProfile.LongCooldownSpells[SpellIDs.FeralSpirit] end,
                }, 
			},
		},
    },
}
    
local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Cooldowns"], "TotemTimers", "enhancecds")    
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")