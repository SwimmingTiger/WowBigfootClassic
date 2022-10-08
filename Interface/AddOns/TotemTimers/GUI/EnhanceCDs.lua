if select(2, UnitClass("player")) ~= "SHAMAN" then
    return
end

local _, TotemTimers = ...

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

local SpellIDs = TotemTimers.SpellIDs
local SpellNames = TotemTimers.SpellNames

function TotemTimers.OrderCDs(role)
    for i = 1, #TotemTimers.ActiveProfile.EnhanceCDs_Order[tonumber(role)] do
        if TotemTimers.options.args.enhancecds.args[role].args[tostring(TotemTimers.ActiveProfile.EnhanceCDs_Order[tonumber(role)][i])] then
            TotemTimers.options.args.enhancecds.args[role].args[tostring(TotemTimers.ActiveProfile.EnhanceCDs_Order[tonumber(role)][i])].order = i + 10
        end
    end
end

local function changeOrder(spell, dir, role)
    role = tonumber(role)
    for i = 1, TotemTimers.num_CD_Spells[role] do
        if TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i] == spell and i + dir > 0 and i + dir <= TotemTimers.num_CD_Spells[role] then
            TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i], TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i + dir] = TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i + dir], TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i]
            break
        end
    end
    TotemTimers.OrderCDs(tostring(role))
    TotemTimers.ProcessSetting("EnhanceCDs")
end

TotemTimers.options.args.enhancecds = {
    type = "group",
    name = "Combat Cooldowns",
    childGroups = "tab",
    args = {
        options = {
            order = 1,
            type = "group",
            name = "Combat Cooldowns",
            args = {
                enable = {
                    order = 0,
                    type = "toggle",
                    name = L["Enable"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDs = val
                        TotemTimers.ProcessSetting("EnhanceCDs")
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.EnhanceCDs
                    end,
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
                    set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDs_Clickthrough = val
                        TotemTimers.ProcessSetting("EnhanceCDs_Clickthrough")
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.EnhanceCDs_Clickthrough
                    end,
                },
                CDTimersOnButtons = {
                    order = 5,
                    type = "toggle",
                    name = L["Timers On Buttons"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.CDTimersOnButtons = val
                        TotemTimers.ProcessSetting("CDTimersOnButtons")
                        TotemTimers.LayoutEnhanceCDs()
                        TotemTimers.LayoutLongCooldowns()
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.CDTimersOnButtons
                    end,
                },
                OOCAlpha = {
                    order = 6,
                    type = "range",
                    min = 0,
                    max = 1,
                    step = 0.1,
                    name = L["OOC Opacity"],
                    desc = L["OOC Opacity Desc"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsOOCAlpha = val
                        TotemTimers.ProcessSetting("EnhanceCDsOOCAlpha")
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.EnhanceCDsOOCAlpha
                    end,
                },
                HideEnhanceCDsOOC = {
                    order = 7,
                    type = "toggle",
                    name = L["Hide out of combat"],
                    desc = L["Hide OOC Desc"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.HideEnhanceCDsOOC = val
                        TotemTimers.ProcessSetting("HideEnhanceCDsOOC")
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.HideEnhanceCDsOOC
                    end,
                },

                scalingheader = {
                    order = 10,
                    type = "header",
                    name = L["Scaling"],
                },
                ECDSize = {
                    order = 11,
                    type = "range",
                    name = L["Button Size"],
                    min = 16,
                    max = 96,
                    step = 1,
                    bigStep = 2,
                    set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsSize = val
                        TotemTimers.ProcessSetting("EnhanceCDsSize")
                        TotemTimers.LayoutEnhanceCDs()
                        TotemTimers.LayoutLongCooldowns()
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.EnhanceCDsSize
                    end,
                },
                ECDFontSize = {
                    order = 12,
                    type = "range",
                    name = L["Time Size"],
                    min = 6,
                    max = 40,
                    step = 1,
                    set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsTimeHeight = val
                        TotemTimers.ProcessSetting("EnhanceCDsTimeHeight")
                        TotemTimers.LayoutEnhanceCDs()
                        TotemTimers.LayoutLongCooldowns()
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.EnhanceCDsTimeHeight
                    end,
                },
                spacing = {
                    order = 13,
                    type = "range",
                    name = L["Spacing"],
                    desc = L["Sets the space between timer buttons"],
                    min = 0,
                    max = 20,
                    step = 1,
                    set = function(info, val)
                        TotemTimers.ActiveProfile.CooldownSpacing = val
                        TotemTimers.ProcessSetting("CooldownSpacing")
                        TotemTimers.LayoutEnhanceCDs()
                        TotemTimers.LayoutLongCooldowns()
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.CooldownSpacing
                    end,
                },

                stoppulseheader = {
                    order = 20,
                    type = "header",
                    name = "Stop Pulse",
                },
                stoppulse = {
                    order = 21,
                    type = "toggle",
                    name = L["Stop Pulse Animation"],
                    desc = L["Stop Pulse Desc"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.EnhanceCDsStopPulse = val
                        TotemTimers.ProcessSetting("EnhanceCDsStopPulse")
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.EnhanceCDsStopPulse
                    end,
                },
                stoppulsedemo = {
                    order = 22,
                    type = "execute",
                    name = L["Demo"],
                    func = function()
                        local timer = nil
                        for _, t in pairs(TotemTimers.EnhanceCDs) do
                            if t.active then
                                timer = t
                                break
                            end
                        end
                        timer.animation:SetTexture(timer.button.icons[1]:GetTexture())
                        timer.animation:Play()
                    end
                },

                flameshockheader = {
                    order = 30,
                    type = "header",
                    name = SpellNames[SpellIDs.FlameShock],
                },
                FlameShockDuration = {
                    order = 31,
                    type = "description",
                    name = "Flame shock duration is now changed for each spec in spells section below",
                },
                FlameShockOnTop = {
                    order = 32,
                    type = "toggle",
                    name = L["Flame Shock on top"],
                    desc = L["Flame Shock on top desc"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.FlameShockDurationOnTop = val
                        TotemTimers.LayoutEnhanceCDs()
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.FlameShockDurationOnTop
                    end,
                },
                FlameShockSize = {
                    order = 33,
                    type = "range",
                    name = L["Size"],
                    min = 1,
                    max = 3,
                    step = 1,
                    set = function(info, val)
                        TotemTimers.ActiveProfile.FlameShockDurationSize = val
                        TotemTimers.ProcessSetting("FlameShockDurationSize")
                        TotemTimers.LayoutEnhanceCDs()
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.FlameShockDurationSize
                    end,
                },
                FlameShockStopPulse = {
                    order = 33,
                    type = "toggle",
                    name = L["Stop Pulse Animation"],
                    desc = L["Stop Pulse Desc"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.FlameShockDurationStopPulse = val
                        TotemTimers.ProcessSetting("FlameShockDurationStopPulse")
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.FlameShockDurationStopPulse
                    end,
                },

                lc = {
                    order = 50,
                    type = "header",
                    name = L["Long Cooldowns"],
                },
                lcenable = {
                    order = 51,
                    type = "toggle",
                    name = L["Enable"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.LongCooldowns = val
                        TotemTimers.ProcessSetting("LongCooldowns")
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.LongCooldowns
                    end
                },
                lcarrange = {
                    order = 52,
                    type = "select",
                    name = L["Arrangement"],
                    values = { vertical = L["vertical"], horizontal = L["horizontal"], },
                    set = function(info, val)
                        TotemTimers.ActiveProfile.LongCooldownsArrange = val
                        TotemTimers.LayoutLongCooldowns()
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.LongCooldownsArrange
                    end,
                },
                lcnewline = {
                    order = 53,
                    type = "description",
                    name = "",
                },
                lcstoppulse = {
                    order = 54,
                    type = "toggle",
                    name = L["Stop Pulse Animation"],
                    desc = L["Stop Pulse Desc"],
                    set = function(info, val)
                        TotemTimers.ActiveProfile.LongCooldownsStopPulse = val
                        TotemTimers.ProcessSetting("LongCooldownsStopPulse")
                    end,
                    get = function(info)
                        return TotemTimers.ActiveProfile.LongCooldownsStopPulse
                    end,
                },
                lcstoppulsedemo = {
                    order = 55,
                    type = "execute",
                    name = L["Demo"],
                    func = function()
                        local timer = nil
                        for _, t in pairs(TotemTimers.LongCooldowns) do
                            if t.active then
                                timer = t
                                break
                            end
                        end
                        timer.animation:SetTexture(timer.button.icons[1]:GetTexture())
                        timer.animation:Play()
                    end
                },

            },
        },


        ["2"] = {
            order = 71,
            type = "group",
            name = GetTalentTabInfo(2) or "Enhancement",
            args = {
            },
        },
        ["1"] = {
            order = 72,
            type = "group",
            name = GetTalentTabInfo(1) or "Elemental",
            args = {
            },
        },
        ["3"] = {
            order = 73,
            type = "group",
            name = GetTalentTabInfo(3) or "Restoration",
            args = {
            },
        },
        ["4"] = {
            order = 74,
            type = "group",
            name = L["Long Cooldowns"],
            args = {},
        },
    },
}

for spec = 1, 3 do
    for index, spell in pairs(TotemTimers.CombatCooldownSpells[spec]) do
        TotemTimers.options.args.enhancecds.args[tostring(spec)].args[tostring(index)] = {
            order = 10 + index,
            type = "toggle",
            name = SpellNames[spell],
            width = "normal",
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
    TotemTimers.options.args.enhancecds.args[tostring(spec)].args.FlameShockDuration = {
        order = 0,
        type = "toggle",
        name = L["Flame Shock duration"],
        width = "full",
        set = function(info, val)
            TotemTimers.ActiveProfile.EnhanceCDsFlameShockDuration_Specialization[spec] = val
            TotemTimers.ConfigEnhanceCDs()
            TotemTimers.LayoutEnhanceCDs()
        end,
        get = function(info)
            return TotemTimers.ActiveProfile.EnhanceCDsFlameShockDuration_Specialization[spec]
        end,
    }
end

if WOW_PROJECT_ID > WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
    local MaelstromName = GetSpellInfo(53817)

    TotemTimers.options.args.enhancecds.args.options.args.MaelstromHeader = {
        order = 40,
        type = "header",
        name = MaelstromName,
    }

    TotemTimers.options.args.enhancecds.args.options.args.Maelstrom = {
        order = 41,
        type = "toggle",
        name = MaelstromName,
        set = function(info, val)
            TotemTimers.ActiveProfile.EnhanceCDsMaelstrom = val
            TotemTimers.ConfigEnhanceCDs()
            TotemTimers.LayoutEnhanceCDs()
        end,
        get = function(info)
            return TotemTimers.ActiveProfile.EnhanceCDsMaelstrom
        end,
    }

    TotemTimers.options.args.enhancecds.args.options.args.MaelstromSize = {
        order = 44,
        type = "range",
        name = L["Size"],
        min = 1,
        max = 3,
        step = 1,
        set = function(info, val)
            TotemTimers.ActiveProfile.MaelstromSize = val
            TotemTimers.ProcessSetting("MaelstromSize")
            TotemTimers.LayoutEnhanceCDs()
        end,
        get = function(info)
            return TotemTimers.ActiveProfile.MaelstromSize
        end,
    }

    TotemTimers.options.args.enhancecds.args.options.args.MaelstromStopPulse = {
        order = 43,
        type = "toggle",
        name = L["Stop Pulse Animation"],
        desc = L["Large animation on 5 stacks"],
        set = function(info, val)
            TotemTimers.ActiveProfile.MaelstromStopPulse = val
            TotemTimers.ProcessSetting("MaelstromStopPulse")
        end,
        get = function(info)
            return TotemTimers.ActiveProfile.MaelstromStopPulse
        end,
    }

    TotemTimers.options.args.enhancecds.args.options.args.MaelstromNumberOnly = {
        order = 42,
        type = "toggle",
        name = L["Show Number Only"],
        desc = L["MaelstromNumberOnlyDesc"],
        set = function(info, val)
            TotemTimers.ActiveProfile.MaelstromNumberOnly = val
            TotemTimers.ProcessSetting("MaelstromNumberOnly")
            if TotemTimers.Maelstrom.active then
                TotemTimers.MaelstromEvent(TotemTimers.Maelstrom.button, "UNIT_AURA")
            end
        end,
        get = function(info)
            return TotemTimers.ActiveProfile.MaelstromNumberOnly
        end,
    }

    for i,lc in pairs(TotemTimers.LongCooldownSpells) do
        local spellID = lc.spell
        TotemTimers.options.args.enhancecds.args["4"].args[tostring(spellID)] = {
            order = i,
            type = "toggle",
            name = SpellNames[spellID],
            set = function(info, val)
                TotemTimers.ActiveProfile.LongCooldownSpells[spellID] = val
                TotemTimers.ProcessSetting("LongCooldowns")
            end,
            get = function()
                local val = TotemTimers.ActiveProfile.LongCooldownSpells[spellID]
                return val == nil or val
            end
        }
    end
end

local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Combat Cooldowns"], "TotemTimers", "enhancecds")
frame:SetScript("OnEvent", function(self)
    InterfaceOptionsFrame:Hide()
end)
frame:HookScript("OnShow", function(self)
    if InCombatLockdown() then
        InterfaceOptionsFrame:Hide()
    end
    TotemTimers.LastGUIPanel = self
end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")