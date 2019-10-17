if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local sink = LibStub("LibSink-2.0")
--[[if sink then
    TotemTimers.options.args.messages = sink.GetSinkAce3OptionsDataTable(TotemTimers)
else
    TotemTimers.options.args.messages = {}
end]]

--[[for k,v in pairs(TotemTimers.options.args.messages.args) do
    if v.order and v.order < 0 then v.order = v.order - 50 end
end]]

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

TotemTimers.options.args.messages = {
    type = "group",
    name = "Warnings",
    args = {
        ActivateHiddenTimers = {
            order = 0,
            type = "toggle",
            name = L["Show warnings of disabled trackers"],
            desc = L["disabled warnings desc"],
            set = function(info, val)
                      TotemTimers.ActiveProfile.ActivateHiddenTimers = val
                      TotemTimers.ProcessSetting("ActivateHiddenTimers")
                  end,
            get = function(info) return TotemTimers.ActiveProfile.ActivateHiddenTimers end,
        },
        Messages = {
            order = 1,
            type = "group",
            name = L["Warnings"],
            args = {
                output = sink.GetSinkAce3OptionsDataTable(TotemTimers),
                TotemWarningMsg = {
                    order = 1,
                    type = "group",
                    name = L["Totem Expiration Warning"],
                    desc = L["Totem Warning Desc"],
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.TotemWarning.enabled = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.TotemWarning.enabled end,
                        },
                        color =  {
                            order = 1,
                            type = "color",
                            name = L["Color"],
                            hasAlpha = false,
                            set = function(info, r,g,b)
                                TotemTimers.ActiveProfile.Warnings.TotemWarning.r = r
                                TotemTimers.ActiveProfile.Warnings.TotemWarning.g = g
                                TotemTimers.ActiveProfile.Warnings.TotemWarning.b = b
                            end,
                            get = function(info)
                                return TotemTimers.ActiveProfile.Warnings.TotemWarning.r,
                                       TotemTimers.ActiveProfile.Warnings.TotemWarning.g,
                                       TotemTimers.ActiveProfile.Warnings.TotemWarning.b, 1
                            end,
                        },
                        sound = {
                            order = 2,
                            type = "select",
                            name = L["Sound"],
                            values = AceGUIWidgetLSMlists.sound,
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.TotemWarning.sound = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.TotemWarning.sound end,
                            dialogControl = "LSM30_Sound",
                        },
                        nosound = {
                            order = 3,
                            type = "execute", 
                            name = L["No Sound"],
                            func = function(info) TotemTimers.ActiveProfile.Warnings.TotemWarning.sound = "" end,
                        },
                    },
                },
                TotemExpirationMsg = {
                    order = 2,
                    type = "group",
                    name = L["Totem Expiration Message"],
                    desc = L["Totem Expiration Desc"],
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.TotemExpiration.enabled = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.TotemExpiration.enabled end,
                        },
                        color =  {
                            order = 1,
                            type = "color",
                            name = L["Color"],
                            hasAlpha = false,
                            set = function(info, r,g,b)
                                TotemTimers.ActiveProfile.Warnings.TotemExpiration.r = r
                                TotemTimers.ActiveProfile.Warnings.TotemExpiration.g = g
                                TotemTimers.ActiveProfile.Warnings.TotemExpiration.b = b
                            end,
                            get = function(info)
                                return TotemTimers.ActiveProfile.Warnings.TotemExpiration.r,
                                       TotemTimers.ActiveProfile.Warnings.TotemExpiration.g,
                                       TotemTimers.ActiveProfile.Warnings.TotemExpiration.b, 1
                            end,
                        },
                        sound = {
                            order = 2,
                            type = "select",
                            name = L["Sound"],
                            values = AceGUIWidgetLSMlists.sound,
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.TotemExpiration.sound = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.TotemExpiration.sound end,
                            dialogControl = "LSM30_Sound",
                        },
                        nosound = {
                            order = 3,
                            type = "execute", 
                            name = L["No Sound"],
                            func = function(info) TotemTimers.ActiveProfile.Warnings.TotemExpiration.sound = "" end,
                        },
                    },
                },
                TotemDestroyedMsg = {
                    order = 3,
                    type = "group",
                    name = L["Totem Destruction Message"],
                    desc = L["Totem Desctruction Desc"],
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.TotemDestroyed.enabled = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.TotemDestroyed.enabled end,
                        },
                        color =  {
                            order = 1,
                            type = "color",
                            name = L["Color"],
                            hasAlpha = false,
                            set = function(info, r,g,b)
                                TotemTimers.ActiveProfile.Warnings.TotemDestroyed.r = r
                                TotemTimers.ActiveProfile.Warnings.TotemDestroyed.g = g
                                TotemTimers.ActiveProfile.Warnings.TotemDestroyed.b = b
                            end,
                            get = function(info)
                                return TotemTimers.ActiveProfile.Warnings.TotemDestroyed.r,
                                       TotemTimers.ActiveProfile.Warnings.TotemDestroyed.g,
                                       TotemTimers.ActiveProfile.Warnings.TotemDestroyed.b, 1
                            end,
                        },
                        sound = {
                            order = 2,
                            type = "select",
                            name = L["Sound"],
                            values = AceGUIWidgetLSMlists.sound,
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.TotemDestroyed.sound = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.TotemDestroyed.sound end,
                            dialogControl = "LSM30_Sound",
                        },
                        nosound = {
                            order = 3,
                            type = "execute", 
                            name = L["No Sound"],
                            func = function(info) TotemTimers.ActiveProfile.Warnings.TotemDestroyed.sound = "" end,
                        },
                    },
                },
                ShieldMsg = {
                    order = 4,
                    type = "group",
                    name = L["Shield expiration warnings"],
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.Shield.enabled = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.Shield.enabled end,
                        },
                        color =  {
                            order = 1,
                            type = "color",
                            name = L["Color"],
                            hasAlpha = false,
                            set = function(info, r,g,b, a) 
                                TotemTimers.ActiveProfile.Warnings.Shield.r = r
                                TotemTimers.ActiveProfile.Warnings.Shield.g = g
                                TotemTimers.ActiveProfile.Warnings.Shield.b = b
                            end,
                            get = function(info)
                                return TotemTimers.ActiveProfile.Warnings.Shield.r,
                                       TotemTimers.ActiveProfile.Warnings.Shield.g,
                                       TotemTimers.ActiveProfile.Warnings.Shield.b, 1
                            end,
                        },
                        sound = {
                            order = 2,
                            type = "select",
                            name = L["Sound"],
                            values = AceGUIWidgetLSMlists.sound,
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.Shield.sound = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.Shield.sound end,
                            dialogControl = "LSM30_Sound",
                        },
                        nosound = {
                            order = 3,
                            type = "execute", 
                            name = L["No Sound"],
                            func = function(info) TotemTimers.ActiveProfile.Warnings.Shield.sound = "" end,
                        },
                    },
                },
                --[[ EarthShieldMsg = {
                    order = 5,
                    type = "group",
                    name = L["EarthShield warnings"],
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.EarthShield.enabled = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.EarthShield.enabled end,
                        },
                        color =  {
                            order = 1,
                            type = "color",
                            name = L["Color"],
                            hasAlpha = false,
                            set = function(info, r,g,b)
                                TotemTimers.ActiveProfile.Warnings.EarthShield.r = r
                                TotemTimers.ActiveProfile.Warnings.EarthShield.g = g
                                TotemTimers.ActiveProfile.Warnings.EarthShield.b = b
                            end,
                            get = function(info)
                                return TotemTimers.ActiveProfile.Warnings.EarthShield.r,
                                       TotemTimers.ActiveProfile.Warnings.EarthShield.g,
                                       TotemTimers.ActiveProfile.Warnings.EarthShield.b, 1
                            end,
                        },
                        sound = {
                            order = 2,
                            type = "select",
                            name = L["Sound"],
                            values = AceGUIWidgetLSMlists.sound,
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.EarthShield.sound = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.EarthShield.sound end,
                            dialogControl = "LSM30_Sound",
                        },
                        nosound = {
                            order = 3,
                            type = "execute", 
                            name = L["No Sound"],
                            func = function(info) TotemTimers.ActiveProfile.Warnings.EarthShield.sound = "" end,
                        },
                    },
                }, --]]
                --[[ MaelstromMsg = {
                    order = 7,
                    type = "group",
                    name = L["Maelstrom notification"],
                    args = {
                        enable = {
                            order = 0,
                            type = "toggle",
                            name = L["Enable"],
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.Maelstrom.enabled = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.Maelstrom.enabled end,
                        },
                        color =  {
                            order = 1,
                            type = "color",
                            name = L["Color"],
                            hasAlpha = false,
                            set = function(info, r,g,b)
                                TotemTimers.ActiveProfile.Warnings.Maelstrom.r = r
                                TotemTimers.ActiveProfile.Warnings.Maelstrom.g = g
                                TotemTimers.ActiveProfile.Warnings.Maelstrom.b = b
                            end,
                            get = function(info)
                                return TotemTimers.ActiveProfile.Warnings.Maelstrom.r,
                                       TotemTimers.ActiveProfile.Warnings.Maelstrom.g,
                                       TotemTimers.ActiveProfile.Warnings.Maelstrom.b, 1
                            end,
                        },
                        sound = {
                            order = 2,
                            type = "select",
                            name = L["Sound"],
                            values = AceGUIWidgetLSMlists.sound,
                            set = function(info, val) TotemTimers.ActiveProfile.Warnings.Maelstrom.sound = val end,
                            get = function(info) return TotemTimers.ActiveProfile.Warnings.Maelstrom.sound end,
                            dialogControl = "LSM30_Sound",
                        },
                        nosound = {
                            order = 3,
                            type = "execute", 
                            name = L["No Sound"],
                            func = function(info) TotemTimers.ActiveProfile.Warnings.Maelstrom.sound = "" end,
                        },
                    },
                }, --]]
            },
        },
    },
}


local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Warnings"], "TotemTimers", "messages")
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")