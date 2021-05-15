if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers_GUI", true)

local ACD = LibStub("AceConfigDialog-3.0")
local frame = ACD:AddToBlizOptions("TotemTimers", L["Profiles"], "TotemTimers", "profiles")

local SelectedProfile = "default"
local NameInput = ""
local CopyFrom = "default"
local CopyTo = "default"

local function CreateProfileList()
    local v = {}
    for k,_ in pairs(TotemTimers_Profiles) do
        v[k] = k
    end
    v["default"] = L["default"]
    return v
end

TotemTimers.options.args.profiles = {
    type = "group",
    name = "Profiles",
    args = {
        ["select"] = {
            order = 1,
            type = "group",
            name = L["Select Profiles"],
            args = {
                ["solo"] = {
                    type = "select",
                    name = L["Solo"],
                    values = CreateProfileList,
                    set = function(info, val)
                        TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].none = val
                        TotemTimers.SelectActiveProfile()
                        TotemTimers.ExecuteProfile()
                    end,
                    get = function(info) return TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].none end,
                },
                ["party"] = {
                    type = "select",
                    name = L["Party"],
                    values = CreateProfileList,
                    set = function(info, val)
                        TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].party = val
                        TotemTimers.SelectActiveProfile()
                        TotemTimers.ExecuteProfile()
                    end,
                    get = function(info) return TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].party end,
                },
                ["arena"] = {
                    type = "select",
                    name = L["Arena"],
                    values = CreateProfileList,
                    set = function(info, val)
                        TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].arena = val
                        TotemTimers.SelectActiveProfile()
                        TotemTimers.ExecuteProfile()
                    end,
                    get = function(info) return TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].arena end,
                },
                ["pvp"] = {
                    type = "select",
                    name = L["Battleground"],
                    values = CreateProfileList,
                    set = function(info, val)
                        TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].pvp = val
                        TotemTimers.SelectActiveProfile()
                        TotemTimers.ExecuteProfile()
                    end,
                    get = function(info) return TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].pvp end,
                },
                ["raid"] = {
                    type = "select",
                    name = L["Raid"],
                    values = CreateProfileList,
                    set = function(info, val)
                        TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].raid = val
                        TotemTimers.SelectActiveProfile()
                        TotemTimers.ExecuteProfile()
                    end,
                    get = function(info) return TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].raid end,
                },
                ["scenario"] = {
                    type = "select",
                    name = L["Scenario"],
                    values = CreateProfileList,
                    set = function(info, val)
                        TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].scenario = val
                        TotemTimers.SelectActiveProfile()
                        TotemTimers.ExecuteProfile()
                    end,
                    get = function(info) return TotemTimers_GlobalSettings.Profiles[UnitName("player")][2].scenario end,
                },
            },
        },
        ["manage"] = {
            order = 2,
            type = "group",
            name = L["Manage Profiles"],
            childGroups = "tab",
            args = {
                ["select"] = {
                    order = 1,
                    type = "select",
                    name = L["Profile"],
                    values = CreateProfileList,
                    set = function(info, val)
                        SelectedProfile = val
                    end,
                    get = function(info) return SelectedProfile end,
                },
                ["name"] = {
                    order = 2,
                    type = "input",
                    name = L["New Name"],
                    get = function(info) return NameInput end,
                    set = function(info, val) NameInput = val end,
                },
                ["create"] = {
                    order = 3,
                    type = "execute",
                    name = L["Create Profile"],
                    func = function(info) 
                        if NameInput ~= "" then
                            if TotemTimers_Profiles[NameInput] or NameInput == L["default"] then
                                print(L["Profile already exists."])
                            else
                                TotemTimers.CreateProfile(NameInput)
                                SelectedProfile = NameInput
                                frame:Show()
                            end
                        else
                            print(L["You need to enter a profile name first."])
                        end
                    end,
                },
                ["delete"] = {
                    order = 5,
                    type = "execute",
                    name = L["Delete Profile"],
                    func = function(info)
                        TotemTimers.DeleteProfile(SelectedProfile)
                        TotemTimers.SelectActiveProfile()
                        TotemTimers.ExecuteProfile()
                        SelectedProfile = "default"
                        frame:Show()
                    end,
                    confirm = true,
                    confirmText = L["Really delete profile?"],
                },
                ["reset"] = {
                    order = 6,
                    type = "execute",
                    name = L["Reset Profile"],
                    func = function(info) TotemTimers.ResetProfile(SelectedProfile) end,
                    confirm = true,
                    confirmText = L["Really reset profile?"],
                },
                ["resetFramePos"] = {
                    order = 7,
                    type = "execute",
                    name = L["Reset Frame Positions"],
                    func = function(info) TotemTimers.ResetProfilePositions(SelectedProfile) end,
                    confirm = true,
                    confirmText = L["Really reset frame positions?"],
                },
                ["h1"] = {
                    order = 8,
                    type = "header",
                    name = L["Copy Settings"],
                },
                copyFrom = {
                    order = 15,
                    type = "select",
                    name = L["Copy From"],
                    values = CreateProfileList,
                    set = function(info, val)
                        CopyFrom = val
                    end,
                    get = function(info) return CopyFrom end,
                },
                copyTo = {
                    order = 16,
                    type = "select",
                    name = L["Copy To"],
                    values = CreateProfileList,
                    set = function(info, val)
                        CopyTo = val
                    end,
                    get = function(info) return CopyTo end,
                },
                copyAll = {
                    order = 17,
                    type = "execute",
                    name = L["Copy All"],
                    func = function()
                        TotemTimers.CopyProfile(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end,
                },
                copyFramePos = {
                    order = 18,
                    type = "execute",
                    name = L["Copy Frame Positions"],
                    func = function()
                        TotemTimers.CopyFramePositions(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end,
                },
                copyGeneral = {
                    order = 19,
                    type = "execute",
                    name = L["Copy General Settings"],
                    func = function()
                        TotemTimers.CopyGeneralSettings(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end, 
                },
                copyTimer = {
                    order = 19,
                    type = "execute",
                    name = L["Copy Totem Timer Settings"],
                    func = function()
                        TotemTimers.CopyTimerSettings(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end,
                },
                copyTracker = {
                    order = 20,
                    type = "execute",
                    name = L["Copy Tracker Settings"],
                    func = function()
                        TotemTimers.CopyTrackerSettings(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end,
                },
                --[[ copyCD = {
                    order = 21,
                    type = "execute",
                    name = L["Copy EnhanceCDs Settings"],
                    func = function()
                        TotemTimers.CopyCDSettings(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end,
                }, ]]
                copyTotems = {
                    order = 22,
                    type = "execute",
                    name = L["Copy Totem Settings"],
                    func = function()
                        TotemTimers.CopyTotemSettings(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end,
                },
                --[[ copyCrowdControl = {
                     order = 23,
                    type = "execute",
                    name = L["Copy CC Settings"],
                    func = function()
                        TotemTimers.CopyCrowdControlSettings(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end,
                }, ]]
                copyWarnings = {
                     order = 24,
                    type = "execute",
                    name = L["Copy Warnings"],
                    func = function()
                        TotemTimers.CopyWarnings(CopyFrom, CopyTo)
                        TotemTimers.ExecuteProfile()
                    end,
                },
            },
        },
    },
}
    
frame:SetScript("OnEvent", function(self) InterfaceOptionsFrame:Hide() end)
frame:HookScript("OnShow", function(self) if InCombatLockdown() then InterfaceOptionsFrame:Hide() end TotemTimers.LastGUIPanel = self end)
frame:RegisterEvent("PLAYER_REGEN_DISABLED")