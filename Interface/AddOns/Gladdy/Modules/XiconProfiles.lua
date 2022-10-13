local Gladdy = LibStub("Gladdy")
local L = Gladdy.L

local XiconProfiles = Gladdy:NewModule("XiconProfiles", nil, {
})

local function applyProfile(profileString)
    local deserialized = Gladdy.modules["Export Import"]:Decode(profileString)
    if deserialized then
        Gladdy.modules["Export Import"]:ApplyImport(deserialized, Gladdy.db)
    end
    Gladdy:Reset()
    Gladdy:HideFrame()
    Gladdy:ToggleFrame(3)
    Gladdy.options.args.lock.name = Gladdy.db.locked and L["Unlock frame"] or L["Lock frame"]
    Gladdy.options.args.showMover.name = Gladdy.db.showMover and L["Hide Mover"] or L["Show Mover"]
    LibStub("AceConfigRegistry-3.0"):NotifyChange("Gladdy")
end
Gladdy_applyProfile = applyProfile	-- bf@178.com

function XiconProfiles:GetOptions()
    return {
        headerProfileBlizzard = {
            type = "header",
            name = "Blizzard " .. L["Profile"],
            order = 2,
        },
        blizzardProfile = {
            type = "execute",
            func = function()
                Gladdy.dbi:ResetProfile(Gladdy.dbi:GetCurrentProfile())
                applyProfile(Gladdy:GetBlizzardProfile())
            end,
            name = " ",
            desc = "Blizzard " .. L["Profile"],
            image = "Interface\\AddOns\\Gladdy\\Images\\BasicProfiles\\Blizz1.blp",
            imageWidth = 350,
            imageHeight = 175,
            width = "full",
            order = 3,
        },
        headerProfileClassic = {
            type = "header",
            name = "Classic " .. L["Profile"],
            order = 4,
        },
        classicProfile = {
            type = "execute",
            func = function()
                Gladdy.dbi:ResetProfile(Gladdy.dbi:GetCurrentProfile())
                applyProfile(Gladdy:GetClassicProfile())
            end,
            name = " ",
            desc = "Classic " .. L["Profile"],
            image = "Interface\\AddOns\\Gladdy\\Images\\BasicProfiles\\Classic1.blp",
            imageWidth = 350,
            imageHeight = 175,
            width = "full",
            order = 5,
        },
        headerProfileClassicNoPet = {
            type = "header",
            name = "Classic " .. L["Profile"] .. L[" No Pet"],
            order = 6,
        },
        classicProfileNoPet = {
            type = "execute",
            func = function()
                Gladdy.dbi:ResetProfile(Gladdy.dbi:GetCurrentProfile())
                applyProfile(Gladdy:GetClassicProfileNoPet())
            end,
            name = " ",
            desc = "Classic " .. L["Profile"] .. L[" No Pet"],
            image = "Interface\\AddOns\\Gladdy\\Images\\BasicProfiles\\Classic2.blp",
            imageWidth = 350,
            imageHeight = 175,
            width = "full",
            order = 7,
        },
        headerProfileKnall = {
            type = "header",
            name = "Knall's " .. L["Profile"],
            order = 8,
        },
        knallProfile = {
            type = "execute",
            func = function()
                Gladdy.dbi:ResetProfile(Gladdy.dbi:GetCurrentProfile())
                applyProfile(Gladdy:GetKnallProfile())
            end,
            name = " ",
            desc = "Knall's " .. L["Profile"],
            image = "Interface\\AddOns\\Gladdy\\Images\\BasicProfiles\\Knall1.blp",
            imageWidth = 350,
            imageHeight = 175,
            width = "full",
            order = 9,
        },
        headerProfileKlimp = {
            type = "header",
            name = "Klimp's " .. L["Profile"],
            order = 10,
        },
        klimpProfiles = {
            type = "execute",
            func = function()
                Gladdy.dbi:ResetProfile(Gladdy.dbi:GetCurrentProfile())
                applyProfile(Gladdy:GetKlimpProfile())
            end,
            image = "Interface\\AddOns\\Gladdy\\Images\\BasicProfiles\\Klimp1.blp",
            imageWidth = 350,
            imageHeight = 175,
            name = " ",
            desc = "Klimp's " .. L["Profile"],
            width = "full",
            order = 11,
        },
        headerProfileRukk = {
            type = "header",
            name = "Rukk1's " .. L["Profile"],
            order = 12,
        },
        rukkProfile = {
            type = "execute",
            func = function()
                Gladdy.dbi:ResetProfile(Gladdy.dbi:GetCurrentProfile())
                applyProfile(Gladdy:GetRukkProfile())
            end,
            name = " ",
            desc = "Rukk1's " .. L["Profile"],
            image = "Interface\\AddOns\\Gladdy\\Images\\BasicProfiles\\Rukk1.blp",
            imageWidth = 350,
            imageHeight = 175,
            width = "full",
            order = 13,
        },
        headerProfileMir = {
            type = "header",
            name = "Mir's " .. L["Profile"],
            order = 14,
        },
        mirProfile = {
            type = "execute",
            func = function()
                Gladdy.dbi:ResetProfile(Gladdy.dbi:GetCurrentProfile())
                applyProfile(Gladdy:GetMirProfile())
            end,
            name = " ",
            desc = "Mir's " .. L["Profile"],
            image = "Interface\\AddOns\\Gladdy\\Images\\BasicProfiles\\Mir1.blp",
            imageWidth = 350,
            imageHeight = 175,
            width = "full",
            order = 15,
        },
        headerProfileMirEdited = {
            type = "header",
            name = "Mir's " .. L["Profile"] .. " edited",
            order = 16,
        },
        mirProfileEdited = {
            type = "execute",
            func = function()
                Gladdy.dbi:ResetProfile(Gladdy.dbi:GetCurrentProfile())
                applyProfile(Gladdy:GetMirEditedProfile())
            end,
            name = " ",
            desc = "Mir's " .. L["Profile"],
            image = "Interface\\AddOns\\Gladdy\\Images\\BasicProfiles\\Mir1_edited.blp",
            imageWidth = 350,
            imageHeight = 175,
            width = "full",
            order = 17,
        },
    }
end