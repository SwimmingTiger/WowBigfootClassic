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
    name = "Combat Cooldowns",
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
            set = function(info, val)
                TotemTimers.ActiveProfile.CDTimersOnButtons = val
                TotemTimers.ProcessSetting("CDTimersOnButtons")
                TotemTimers.LayoutEnhanceCDs()
            end,
            get = function(info) return TotemTimers.ActiveProfile.CDTimersOnButtons end,
        },  
        --[[HideEnhanceCDsOOC = {
            order = 12,
            type = "toggle",
            name = L["Hide out of combat"],
            desc = L["Hide OOC Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.HideEnhanceCDsOOC = val  TotemTimers.ProcessSetting("HideEnhanceCDsOOC") end,
            get = function(info) return TotemTimers.ActiveProfile.HideEnhanceCDsOOC end,
        },]]
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
                        TotemTimers.ActiveProfile.CooldownSpacing = val
                        TotemTimers.ProcessSetting("CooldownSpacing")
                        TotemTimers.LayoutEnhanceCDs()
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
            name = L["Button Size"] ,
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
            name = L["Time Size"],
            min = 6,
            max = 40,
            step = 1,
            set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsTimeHeight = val  TotemTimers.ProcessSetting("EnhanceCDsTimeHeight")	
                  end,
            get = function(info) return TotemTimers.ActiveProfile.EnhanceCDsTimeHeight end,
        },
        --[[maelstromheight = {
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
		},]]
        stoppulseheader = {
            order = 25,
            type = "header",
            name = "Stop Pulse",
        },
        stoppulse = {
            order = 26,
            type = "toggle",
            name = L["Stop Pulse Animation"],
            desc = L["Stop Pulse Desc"],
            set = function(info, val) TotemTimers.ActiveProfile.EnhanceCDsStopPulse = val TotemTimers.ProcessSetting("EnhanceCDsStopPulse") end,
            get = function(info) return TotemTimers.ActiveProfile.EnhanceCDsStopPulse end,
        },
		spells = {
			order = 29,
			type = "header",
			name = L["Spells"],
		},
        ["2"] = {
            order = 30,
            type = "group",
            name = GetTalentTabInfo(2) or "Enhancement",
            args = {
            },
        },
        ["1"] = {
            order = 40,
            type = "group",
            name = GetTalentTabInfo(1) or "Elemental",
            args = {
            },
        },
        ["3"] = {
            order = 50,
            type = "group",
            name = GetTalentTabInfo(3) or "Restoration",
            args = {
            },
        },
		--[[ ["4"] = {
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
		}, ]]
    },
}

for spec=1,3 do
    for index,spell in pairs(TotemTimers.EnhanceCDsSpells[spec]) do
        TotemTimers.options.args.enhancecds.args[tostring(spec)].args[tostring(index)] = {
            order = index,
            type = "toggle",
            name = TotemTimers.SpellNames[spell],
            width = "full",
            set = function(info, val)
                TotemTimers.ActiveProfile.EnhanceCDs_Spells[spec][index] = val
                TotemTimers.ConfigEnhanceCDs()
                TotemTimers.LayoutEnhanceCDs()
            end,
            get = function(info)
                return TotemTimers.ActiveProfile.EnhanceCDs_Spells[spec][index]
            end,
        }
    end
end
    
local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Combat Cooldowns"], "TotemTimers", "enhancecds")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")