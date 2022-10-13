local select, pairs, tremove, tinsert, format, strsplit, tonumber, ipairs = select, pairs, tremove, tinsert, format, strsplit, tonumber, ipairs
local UnitExists, UnitIsUnit, UnitIsEnemy, UnitGUID = UnitExists, UnitIsUnit, UnitIsEnemy, UnitGUID
local C_NamePlate = C_NamePlate
local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local GetSpellInfo, CreateFrame = GetSpellInfo, CreateFrame
local totemData, npcIdToTotemData = Gladdy:GetTotemData()

---------------------------------------------------

-- Option Helpers

---------------------------------------------------

local function GetTotemColorDefaultOptions()
    local defaultDB = {}
    local options = {}
    local indexedList = {}
    for k,v in pairs(totemData) do
        tinsert(indexedList, {name = k, id = v.id, color = v.color, texture = v.texture})
    end
    table.sort(indexedList, function (a, b)
        return a.name < b.name
    end)
    for i=1,#indexedList do
        defaultDB["totem" .. indexedList[i].id] = {color = indexedList[i].color, enabled = true, alpha = 0.6, customText = ""}
        options["npTotemsHideDisabledTotems"] = {
            order = 1,
            name = L["Hide Disabled Totem Plates"],
            desc = L["Hide Disabled Totem Plates"],
            type = "toggle",
            width = "full",
            get = function() return Gladdy.dbi.profile.npTotemsHideDisabledTotems end,
            set = function(_, value)
                Gladdy.dbi.profile.npTotemsHideDisabledTotems = value
                Gladdy:UpdateFrame()
            end
        }
        options["totem" .. indexedList[i].id] = {
            order = i+1,
            name = select(1, GetSpellInfo(indexedList[i].id)),
            --inline = true,
            width  = "3.0",
            type = "group",
            icon = indexedList[i].texture,
            args = {
                headerTotemConfig = {
                    type = "header",
                    name = format("|T%s:20|t %s", indexedList[i].texture, select(1, GetSpellInfo(indexedList[i].id))),
                    order = 1,
                },
                enabled = {
                    order = 2,
                    name = L["Enabled"],
                    desc = "Enable " .. format("|T%s:20|t %s", indexedList[i].texture, select(1, GetSpellInfo(indexedList[i].id))),
                    type = "toggle",
                    width = "full",
                    get = function() return Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].enabled end,
                    set = function(_, value)
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].enabled = value
                        Gladdy:UpdateFrame()
                    end
                },
                color = {
                    type = "color",
                    name = L["Border color"],
                    desc = L["Color of the border"],
                    order = 3,
                    hasAlpha = true,
                    width = "full",
                    get = function()
                        return Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.r,
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.g,
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.b,
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.a
                    end,
                    set = function(_, r, g, b, a)
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.r,
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.g,
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.b,
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].color.a = r, g, b, a
                        Gladdy:UpdateFrame()
                    end,
                },
                alpha = {
                    type = "range",
                    name = L["Alpha"],
                    order = 4,
                    min = 0,
                    max = 1,
                    step = 0.1,
                    width = "full",
                    get = function()
                        return Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].alpha
                    end,
                    set = function(_, value)
                        Gladdy.dbi.profile.npTotemColors["totem" .. indexedList[i].id].alpha = value
                        Gladdy:UpdateFrame()
                    end
                },
                customText = {
                    type = "input",
                    name = L["Custom totem name"],
                    order = 5,
                    width = "full",
                    get = function() return Gladdy.db.npTotemColors["totem" .. indexedList[i].id].customText end,
                    set = function(_, value) Gladdy.db.npTotemColors["totem" .. indexedList[i].id].customText = value Gladdy:UpdateFrame() end
                },
            }
        }
    end
    return defaultDB, options, indexedList
end

---------------------------------------------------

-- Core

---------------------------------------------------

local TotemPlates = Gladdy:NewModule("Totem Plates", 2, {
    npTotems = true,
    npTotemsShowFriendly = true,
    npTotemsShowEnemy = true,
    npTotemPlatesBorderStyle = "Interface\\AddOns\\Gladdy\\Images\\Border_rounded_blp",
    npTotemPlatesSize = 40,
    npTotemPlatesWidthFactor = 1,
    npTremorFont = "DorisPP",
    npTremorFontSize = 10,
    npTremorFontXOffset = 0,
    npTremorFontYOffset = 0,
    npTotemPlatesAlpha = 0.6,
    npTotemPlatesAlphaAlways = false,
    npTotemPlatesAlphaAlwaysTargeted = false,
    npTotemColors = select(1, GetTotemColorDefaultOptions()),
    npTotemsHideDisabledTotems = false,
})

function TotemPlates.OnEvent(self, event, ...)
    TotemPlates[event](self, ...)
end

function TotemPlates:Initialize()
    self.numChildren = 0
    self.activeTotemNameplates = {}
    self.totemPlateCache = {}
    if Gladdy.db.npTotems then
        self:RegisterEvent("PLAYER_ENTERING_WORLD")
        self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
        self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
        self:RegisterEvent("PLAYER_TARGET_CHANGED")
        self:SetScript("OnEvent", TotemPlates.OnEvent)
    end
    if Gladdy.db.npTotems and Gladdy.db.npTotemsShowEnemy then
        SetCVar("nameplateShowEnemyTotems", true);
    end
    if Gladdy.db.npTotems and Gladdy.db.npTotemsShowFriendly then
        SetCVar("nameplateShowFriendlyTotems", true);
    end
    self.addon = "Blizzard"
    if (IsAddOnLoaded("Plater")) then
        self.addon = "Plater"
    elseif (IsAddOnLoaded("Kui_Nameplates")) then
        self.addon = "Kui_Nameplates"
    elseif (IsAddOnLoaded("NeatPlates")) then
        self.addon = "NeatPlates"
    elseif (IsAddOnLoaded("TidyPlates_ThreatPlates")) then
        self.addon = "TidyPlates_ThreatPlates"
    elseif (IsAddOnLoaded("Tukui")) then
        local _, C, _ = Tukui:unpack()
        if C.NamePlates.Enable then
            self.addon = "Tukui"
        end
    elseif (IsAddOnLoaded("ElvUI")) then
        local E = unpack(ElvUI)
        if E.private.nameplates.enable then
            self.addon = "ElvUI"
        end
    end
end

---------------------------------------------------

-- Events

---------------------------------------------------

function TotemPlates:PLAYER_ENTERING_WORLD()
    self.numChildren = 0
    self.activeTotemNameplates = {}
end

function TotemPlates:PLAYER_TARGET_CHANGED()
    for k,nameplate in pairs(self.activeTotemNameplates) do
        TotemPlates:SetTotemAlpha(nameplate.gladdyTotemFrame, k)
    end
end

function TotemPlates:NAME_PLATE_UNIT_ADDED(unitID)
    self:OnUnitEvent(unitID)
end

function TotemPlates:NAME_PLATE_UNIT_REMOVED(unitID)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitID)
    self.activeTotemNameplates[unitID] = nil
    --self:ToggleAddon(nameplate, true)
    if nameplate.gladdyTotemFrame then
        nameplate.gladdyTotemFrame:Hide()
        nameplate.gladdyTotemFrame:SetParent(nil)
        tinsert(self.totemPlateCache, nameplate.gladdyTotemFrame)
        nameplate.gladdyTotemFrame = nil
    end
end

---------------------------------------------------

-- Gladdy Call

---------------------------------------------------

function TotemPlates:UpdateFrameOnce()
    if Gladdy.db.npTotems then
        self:RegisterEvent("PLAYER_ENTERING_WORLD")
        self:RegisterEvent("NAME_PLATE_UNIT_ADDED")
        self:RegisterEvent("NAME_PLATE_UNIT_REMOVED")
        self:RegisterEvent("PLAYER_TARGET_CHANGED")
        self:SetScript("OnEvent", TotemPlates.OnEvent)
    else
        self:UnregisterEvent("PLAYER_ENTERING_WORLD")
        self:UnregisterEvent("NAME_PLATE_UNIT_ADDED")
        self:UnregisterEvent("NAME_PLATE_UNIT_REMOVED")
        self:UnregisterEvent("PLAYER_TARGET_CHANGED")
        self:SetScript("OnEvent", nil)
    end

    if Gladdy.db.npTotems and Gladdy.db.npTotemsShowEnemy then
        SetCVar("nameplateShowEnemyTotems", true);
    end
    if Gladdy.db.npTotems and Gladdy.db.npTotemsShowFriendly then
        SetCVar("nameplateShowFriendlyTotems", true);
    end

    for k,nameplate in pairs(self.activeTotemNameplates) do
        local totemDataEntry = nameplate.gladdyTotemFrame.totemDataEntry
        nameplate.gladdyTotemFrame:SetWidth(Gladdy.db.npTotemPlatesSize * Gladdy.db.npTotemPlatesWidthFactor)
        nameplate.gladdyTotemFrame:SetHeight(Gladdy.db.npTotemPlatesSize)
        nameplate.gladdyTotemFrame.totemBorder:SetTexture(Gladdy.db.npTotemPlatesBorderStyle)
        nameplate.gladdyTotemFrame.totemBorder:SetVertexColor(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.r,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.g,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.b,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.a)
        nameplate.gladdyTotemFrame.totemName:SetPoint("TOP", nameplate.gladdyTotemFrame, "BOTTOM", Gladdy.db.npTremorFontXOffset, Gladdy.db.npTremorFontYOffset)
        nameplate.gladdyTotemFrame.totemName:SetFont(Gladdy:SMFetch("font", "npTremorFont"), Gladdy.db.npTremorFontSize, "OUTLINE")
        nameplate.gladdyTotemFrame.totemName:SetText(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].customText or "")
        self:SetTotemAlpha(nameplate.gladdyTotemFrame, k)

        if not Gladdy.db.npTotems then
            nameplate.gladdyTotemFrame:Hide()
            self:ToggleAddon(nameplate, true)
        else
            nameplate.gladdyTotemFrame:Show()
            self:ToggleAddon(nameplate)
        end
        local isEnemy = UnitIsEnemy("player", nameplate.gladdyTotemFrame.unitID)
        if Gladdy.db.npTotems and Gladdy.db.npTotemsShowEnemy and isEnemy then
            nameplate.gladdyTotemFrame:Show()
            self:ToggleAddon(nameplate)
        elseif Gladdy.db.npTotems and not Gladdy.db.npTotemsShowEnemy and isEnemy then
            nameplate.gladdyTotemFrame:Hide()
            self:ToggleAddon(nameplate, true)
        end
        if Gladdy.db.npTotems and Gladdy.db.npTotemsShowFriendly and not isEnemy then
            nameplate.gladdyTotemFrame:Show()
            self:ToggleAddon(nameplate)
        elseif not Gladdy.db.npTotemsShowFriendly and not isEnemy then
            nameplate.gladdyTotemFrame:Hide()
            self:ToggleAddon(nameplate, true)
        end
        if Gladdy.db.npTotems and Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].enabled then
            nameplate.gladdyTotemFrame:Show()
            self:ToggleAddon(nameplate)
        end
        if Gladdy.db.npTotems and not Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].enabled then
            nameplate.gladdyTotemFrame:Hide()
            self:ToggleAddon(nameplate, true)
        end
        if Gladdy.db.npTotems and not Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].enabled and Gladdy.db.npTotemsHideDisabledTotems then
            nameplate.gladdyTotemFrame:Hide()
            self:ToggleAddon(nameplate)
        end
    end
    for _,gladdyTotemFrame in ipairs(self.totemPlateCache) do
        gladdyTotemFrame:SetWidth(Gladdy.db.npTotemPlatesSize * Gladdy.db.npTotemPlatesWidthFactor)
        gladdyTotemFrame:SetHeight(Gladdy.db.npTotemPlatesSize)
        gladdyTotemFrame.totemBorder:SetTexture(Gladdy.db.npTotemPlatesBorderStyle)
        gladdyTotemFrame.totemName:SetFont(Gladdy:SMFetch("font", "npTremorFont"), Gladdy.db.npTremorFontSize, "OUTLINE")
        gladdyTotemFrame.totemName:SetPoint("TOP", gladdyTotemFrame, "BOTTOM", Gladdy.db.npTremorFontXOffset, Gladdy.db.npTremorFontYOffset)
    end
end

---------------------------------------------------

-- TotemPlates Frame

---------------------------------------------------

function TotemPlates:CreateTotemFrame(nameplate)
    nameplate.gladdyTotemFrame = CreateFrame("Frame")
    nameplate.gladdyTotemFrame:SetFrameLevel(1)
    nameplate.gladdyTotemFrame:SetIgnoreParentAlpha(true)
    nameplate.gladdyTotemFrame:SetWidth(Gladdy.db.npTotemPlatesSize * Gladdy.db.npTotemPlatesWidthFactor)
    nameplate.gladdyTotemFrame:SetHeight(Gladdy.db.npTotemPlatesSize)
    nameplate.gladdyTotemFrame.totemIcon = nameplate.gladdyTotemFrame:CreateTexture(nil, "BACKGROUND")
    nameplate.gladdyTotemFrame.totemIcon:SetMask("Interface\\AddOns\\Gladdy\\Images\\mask")
    nameplate.gladdyTotemFrame.totemIcon:ClearAllPoints()
    nameplate.gladdyTotemFrame.totemIcon:SetPoint("TOPLEFT", nameplate.gladdyTotemFrame, "TOPLEFT")
    nameplate.gladdyTotemFrame.totemIcon:SetPoint("BOTTOMRIGHT", nameplate.gladdyTotemFrame, "BOTTOMRIGHT")
    nameplate.gladdyTotemFrame.totemBorder = nameplate.gladdyTotemFrame:CreateTexture(nil, "BORDER")
    nameplate.gladdyTotemFrame.totemBorder:ClearAllPoints()
    nameplate.gladdyTotemFrame.totemBorder:SetPoint("TOPLEFT", nameplate.gladdyTotemFrame, "TOPLEFT")
    nameplate.gladdyTotemFrame.totemBorder:SetPoint("BOTTOMRIGHT", nameplate.gladdyTotemFrame, "BOTTOMRIGHT")
    nameplate.gladdyTotemFrame.totemBorder:SetTexture(Gladdy.db.npTotemPlatesBorderStyle)
    nameplate.gladdyTotemFrame.totemName = nameplate.gladdyTotemFrame:CreateFontString(nil, "OVERLAY")
    nameplate.gladdyTotemFrame.totemName:SetFont(Gladdy:SMFetch("font", "npTremorFont"), Gladdy.db.npTremorFontSize, "OUTLINE")
    nameplate.gladdyTotemFrame.totemName:SetPoint("TOP", nameplate.gladdyTotemFrame, "BOTTOM", Gladdy.db.npTremorFontXOffset, Gladdy.db.npTremorFontYOffset)
    nameplate.gladdyTotemFrame.selectionHighlight = nameplate.gladdyTotemFrame:CreateTexture(nil, "OVERLAY")
    nameplate.gladdyTotemFrame.selectionHighlight:SetTexture("Interface/TargetingFrame/UI-TargetingFrame-BarFill")
    nameplate.gladdyTotemFrame.selectionHighlight:SetAlpha(0)
    nameplate.gladdyTotemFrame.selectionHighlight:SetBlendMode("ADD")
    nameplate.gladdyTotemFrame.selectionHighlight:SetIgnoreParentAlpha(true)
    nameplate.gladdyTotemFrame.selectionHighlight:SetPoint("TOPLEFT", nameplate.gladdyTotemFrame, "TOPLEFT", Gladdy.db.npTotemPlatesSize/16, -Gladdy.db.npTotemPlatesSize/16)
    nameplate.gladdyTotemFrame.selectionHighlight:SetPoint("BOTTOMRIGHT", nameplate.gladdyTotemFrame, "BOTTOMRIGHT", -Gladdy.db.npTotemPlatesSize/16, Gladdy.db.npTotemPlatesSize/16)
    nameplate.gladdyTotemFrame:SetScript('OnUpdate', TotemPlates.OnUpdate)
    nameplate.gladdyTotemFrame:SetScript("OnHide", function(self)
        self.parent = nil
        self:SetParent(nil)
    end)
end

---------------------------------------------------

-- Nameplate functions

---------------------------------------------------

function TotemPlates:GetAddonFrame(nameplate)
    if self.addon == "Blizzard" then
        if nameplate.UnitFrame then
            return nameplate.UnitFrame
        end
    elseif self.addon == "Plater" or self.addon == "Tukui" or self.addon == "ElvUI" then
        if nameplate.unitFrame then
            return nameplate.unitFrame
        end
    elseif self.addon == "Kui_Nameplates" then
        if nameplate.kui then
            return nameplate.kui
        end
    elseif self.addon == "NeatPlates" then
        if nameplate.extended or nameplate.carrier then
            return nameplate.extended , nameplate.carrier
        end
    elseif self.addon == "TidyPlates_ThreatPlates" then
        if nameplate.TPFrame then
            return nameplate.TPFrame
        end
    end
end



function TotemPlates:ToggleAddon(nameplate, show)
    local addonFrames = { self:GetAddonFrame(nameplate) }
    if addonFrames and #addonFrames > 0 then
        if show then
            for _,v in ipairs(addonFrames) do
                if nameplate.unitFrame and nameplate.unitFrame.UpdateAllElements then
                    Gladdy:Debug("INFO", "TotemPlates:ToggleAddon - NAME_PLATE_UNIT_ADDED - nameplate.unitFrame:UpdateAllElements")
                    nameplate.unitFrame:UpdateAllElements("NAME_PLATE_UNIT_ADDED")
                else
                    Gladdy:Debug("INFO", "TotemPlates:ToggleAddon - NAME_PLATE_UNIT_ADDED - Show")
                    v:Show()
                end
            end
        else
            for _,v in ipairs(addonFrames) do
                if nameplate.unitFrame and nameplate.unitFrame.UpdateAllElements then
                    Gladdy:Debug("INFO", "TotemPlates:ToggleAddon - NAME_PLATE_UNIT_REMOVED - nameplate.unitFrame:UpdateAllElements")
                    nameplate.unitFrame:UpdateAllElements("NAME_PLATE_UNIT_REMOVED")
                else
                    Gladdy:Debug("INFO", "TotemPlates:ToggleAddon - NAME_PLATE_UNIT_REMOVED - Hide")
                    v:Hide()
                end
            end
        end
    end
end

function TotemPlates.OnUpdate(self)
    if (UnitIsUnit("mouseover", self.unitID) or UnitIsUnit("target", self.unitID)) and Gladdy.db.npTotemColors["totem" .. self.totemDataEntry.id].alpha > 0 then
        self.selectionHighlight:SetAlpha(.25)
    else
        self.selectionHighlight:SetAlpha(0)
    end
    if (TotemPlates.addon == "Plater" or TotemPlates.addon == "Tukui" or TotemPlates.addon == "ElvUI") and self.parent and self.parent.unitFrame then
        self.parent.unitFrame:Hide()
    end
end

function TotemPlates:OnUnitEvent(unitID)
    local isEnemy = UnitIsEnemy("player", unitID)
    local nameplate = C_NamePlate.GetNamePlateForUnit(unitID)
    if not nameplate then
        return
    end
    if not Gladdy.db.npTotems then
        self:ToggleAddon(nameplate, true)
        return
    end
    if not Gladdy.db.npTotemsShowEnemy and isEnemy then
        self:ToggleAddon(nameplate, true)
        return
    end
    if not Gladdy.db.npTotemsShowFriendly and not isEnemy then
        self:ToggleAddon(nameplate, true)
        return
    end
    local npcType, _, _, _, _, npcId = strsplit("-", UnitGUID(unitID))
    if npcType ~= "Creature" then
        return
    end
    local totemDataEntry = npcIdToTotemData[tonumber(npcId)]
    if not totemDataEntry then
        return
    end
    if totemDataEntry and Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].enabled then-- modify this nameplates
        if #self.totemPlateCache > 0 then
            nameplate.gladdyTotemFrame = tremove(self.totemPlateCache, #self.totemPlateCache)
        else
            self:CreateTotemFrame(nameplate)
        end
        nameplate.gladdyTotemFrame.unitID = unitID
        nameplate.gladdyTotemFrame.totemDataEntry = totemDataEntry
        nameplate.gladdyTotemFrame.parent = nameplate
        nameplate.gladdyTotemFrame:SetParent(nameplate)
        nameplate.gladdyTotemFrame:ClearAllPoints()
        nameplate.gladdyTotemFrame:SetPoint("CENTER", nameplate, "CENTER", 0, 0)
        nameplate.gladdyTotemFrame.totemIcon:SetTexture(totemDataEntry.texture)
        nameplate.gladdyTotemFrame.totemBorder:SetVertexColor(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.r,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.g,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.b,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.a)
        nameplate.gladdyTotemFrame.totemName:SetText(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].customText or "")
        nameplate.gladdyTotemFrame.parent = nameplate
        nameplate.gladdyTotemFrame:Show()
        TotemPlates:SetTotemAlpha(nameplate.gladdyTotemFrame, unitID)
        self:ToggleAddon(nameplate)
        self.activeTotemNameplates[unitID] = nameplate
    elseif totemDataEntry and not Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].enabled and Gladdy.db.npTotemsHideDisabledTotems then
        if nameplate.gladdyTotemFrame then
            nameplate.gladdyTotemFrame:Hide()
            nameplate.gladdyTotemFrame:SetParent(nil)
            tinsert(self.totemPlateCache, nameplate.gladdyTotemFrame)
            nameplate.gladdyTotemFrame = nil
        end
        self:ToggleAddon(nameplate)
    else
        self:ToggleAddon(nameplate, true)
    end
end

function TotemPlates:SetTotemAlpha(gladdyTotemFrame, unitID)
    local targetExists = UnitExists("target")
    local totemDataEntry = gladdyTotemFrame.totemDataEntry
    if targetExists then
        if (UnitIsUnit(unitID, "target")) then -- is target
            if Gladdy.db.npTotemPlatesAlphaAlwaysTargeted then
                gladdyTotemFrame:SetAlpha(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].alpha)
            else
                gladdyTotemFrame:SetAlpha(1)
            end
        else -- is not target
            gladdyTotemFrame:SetAlpha(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].alpha)
        end
    else -- no target
        if Gladdy.db.npTotemPlatesAlphaAlways then
            gladdyTotemFrame:SetAlpha(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].alpha)
        else
            gladdyTotemFrame:SetAlpha(0.95)
        end
    end
end

---------------------------------------------------

-- Test

---------------------------------------------------

function TotemPlates:TestOnce()
    if not self.testFrame then
        self.testFrame = CreateFrame("Frame", nil, UIParent)
        self.testFrame:SetWidth(1)
        self.testFrame:SetHeight(32)
        self.testFrame:SetPoint("CENTER", UIParent, "CENTER", 0, -140)
        self.testFrame:SetIgnoreParentScale(true)
    end
    local totemDataEntry = npcIdToTotemData[5913]
    self.testFrame:Show()
    if not self.testFrame.gladdyTotemFrame then
        if #self.totemPlateCache > 0 then
            self.testFrame.gladdyTotemFrame = tremove(self.totemPlateCache, #self.totemPlateCache)
        else
            self:CreateTotemFrame(self.testFrame)
            self.testFrame.gladdyTotemFrame:SetScript("OnHide", nil)
            self.testFrame.gladdyTotemFrame:SetScript("OnUpdate", nil)
        end
    end
    if Gladdy.db.npTotems then
        self.testFrame.gladdyTotemFrame.unitID = "player"
        self.testFrame.gladdyTotemFrame.totemDataEntry = totemDataEntry
        self.testFrame.gladdyTotemFrame.parent = self.testFrame
        self.testFrame.gladdyTotemFrame:SetParent(self.testFrame)
        self.testFrame.gladdyTotemFrame:ClearAllPoints()
        self.testFrame.gladdyTotemFrame:SetPoint("CENTER", self.testFrame, "CENTER", 0, 0)
        self.testFrame.gladdyTotemFrame.totemIcon:SetTexture(totemDataEntry.texture)
        self.testFrame.gladdyTotemFrame.totemBorder:SetVertexColor(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.r,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.g,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.b,
                Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].color.a)
        self.testFrame.gladdyTotemFrame.totemName:SetText(Gladdy.db.npTotemColors["totem" .. totemDataEntry.id].customText or "")
        self.testFrame.gladdyTotemFrame.parent = self.testFrame
        self.testFrame.gladdyTotemFrame:Show()
        self.activeTotemNameplates["player"] = self.testFrame
    else
        self.testFrame.gladdyTotemFrame:Hide()
    end
end

function TotemPlates:Reset()
    if self.testFrame then
        if self.testFrame.gladdyTotemFrame then
            self.testFrame.gladdyTotemFrame:Hide()
            self.testFrame.gladdyTotemFrame:SetParent(nil)
            tinsert(self.totemPlateCache, self.testFrame.gladdyTotemFrame)
            self.testFrame.gladdyTotemFrame = nil
        end
        self.testFrame:Hide()
        self.activeTotemNameplates["player"] = nil
    end
end

---------------------------------------------------

-- Interface options

---------------------------------------------------

function TotemPlates:GetOptions()
    return {
        headerTotems = {
            type = "header",
            name = L["Totem Plates"],
            order = 2,
        },
        npTotems = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["Turns totem icons instead of nameplates on or off."],
            order = 3,
            width = 0.9,
        }),
        npTotemsShowFriendly = Gladdy:option({
            type = "toggle",
            name = L["Show friendly"],
            desc = L["Turns totem icons instead of nameplates on or off."],
            disabled = function() return not Gladdy.db.npTotems end,
            order = 4,
            width = 0.65,
        }),
        npTotemsShowEnemy = Gladdy:option({
            type = "toggle",
            name = L["Show enemy"],
            desc = L["Turns totem icons instead of nameplates on or off."],
            disabled = function() return not Gladdy.db.npTotems end,
            order = 5,
            width = 0.6,
        }),
        group = {
            type = "group",
            childGroups = "tree",
            name = L["Frame"],
            disabled = function() return not Gladdy.db.npTotems end,
            order = 4,
            args = {
                icon = {
                    type = "group",
                    name = L["Icon"],
                    order = 1,
                    args = {
                        header = {
                            type = "header",
                            name = L["Icon"],
                            order = 1,
                        },
                        npTotemPlatesSize = Gladdy:option({
                            type = "range",
                            name = L["Totem size"],
                            desc = L["Size of totem icons"],
                            order = 5,
                            min = 20,
                            max = 100,
                            step = 1,
                            width = "full",
                        }),
                        npTotemPlatesWidthFactor = Gladdy:option({
                            type = "range",
                            name = L["Icon Width Factor"],
                            desc = L["Stretches the icon"],
                            order = 6,
                            min = 0.5,
                            max = 2,
                            step = 0.05,
                            width = "full",
                        }),
                    },
                },
                font = {
                    type = "group",
                    name = L["Font"],
                    order = 2,
                    args = {
                        header = {
                            type = "header",
                            name = L["Font"],
                            order = 1,
                        },
                        npTremorFont = Gladdy:option({
                            type = "select",
                            name = L["Font"],
                            desc = L["Font of the custom totem name"],
                            order = 11,
                            dialogControl = "LSM30_Font",
                            values = AceGUIWidgetLSMlists.font,
                        }),
                        npTremorFontSize = Gladdy:option({
                            type = "range",
                            name = L["Size"],
                            desc = L["Scale of the font"],
                            order = 12,
                            min = 1,
                            max = 50,
                            step = 0.1,
                            width = "full",
                        }),
                        npTremorFontXOffset = Gladdy:option({
                            type = "range",
                            name = L["Horizontal offset"],
                            desc = L["Scale of the font"],
                            order = 13,
                            min = -300,
                            max = 300,
                            step = 1,
                            width = "full",
                        }),
                        npTremorFontYOffset = Gladdy:option({
                            type = "range",
                            name = L["Vertical offset"],
                            desc = L["Scale of the font"],
                            order = 14,
                            min = -300,
                            max = 300,
                            step = 1,
                            width = "full",
                        }),
                    },
                },
                alpha = {
                    type = "group",
                    name = L["Alpha"],
                    order = 4,
                    args = {
                        header = {
                            type = "header",
                            name = L["Alpha"],
                            order = 1,
                        },
                        npTotemPlatesAlphaAlways = Gladdy:option({
                            type = "toggle",
                            name = L["Apply alpha when no target"],
                            desc = L["Always applies alpha, even when you don't have a target. Else it is 1."],
                            width = "full",
                            order = 21,
                        }),
                        npTotemPlatesAlphaAlwaysTargeted = Gladdy:option({
                            type = "toggle",
                            name = L["Apply alpha when targeted"],
                            desc = L["Always applies alpha, even when you target the totem. Else it is 1."],
                            width = "full",
                            order = 22,
                        }),
                        npAllTotemAlphas = {
                            type = "range",
                            name = L["All totem border alphas (configurable per totem)"],
                            min = 0,
                            max = 1,
                            step = 0.1,
                            width = "full",
                            order = 23,
                            get = function()
                                local alpha, i = nil, 1
                                for _,v in pairs(Gladdy.dbi.profile.npTotemColors) do
                                    if i == 1 then
                                        alpha = v.alpha
                                        i = i + 1
                                    else
                                        if v.alpha ~= alpha then
                                            return ""
                                        end
                                    end
                                end
                                return alpha
                            end,
                            set = function(_, value)
                                for _,v in pairs(Gladdy.dbi.profile.npTotemColors) do
                                    v.alpha = value
                                end
                                Gladdy:UpdateFrame()
                            end,
                        },
                    },
                },
                border = {
                    type = "group",
                    name = L["Border"],
                    order = 5,
                    args = {
                        header = {
                            type = "header",
                            name = L["Border"],
                            order = 1,
                        },
                        npTotemPlatesBorderStyle = Gladdy:option({
                            type = "select",
                            name = L["Totem icon border style"],
                            order = 41,
                            values = Gladdy:GetIconStyles()
                        }),
                        npAllTotemColors = {
                            type = "color",
                            name = L["All totem border color"],
                            order = 42,
                            hasAlpha = true,
                            get = function()
                                local color
                                local i = 1
                                for _,v in pairs(Gladdy.dbi.profile.npTotemColors) do
                                    if i == 1 then
                                        color = v.color
                                        i = i + 1
                                    else
                                        if v.color.r ~= color.r or v.color.g ~= color.g or v.color.b ~= color.b or v.color.a ~= color.a then
                                            return 0, 0, 0, 0
                                        end
                                    end
                                end
                                return color.r, color.g, color.b, color.a
                            end,
                            set = function(_, r, g, b, a)
                                for _,v in pairs(Gladdy.dbi.profile.npTotemColors) do
                                    v.color.r = r
                                    v.color.g = g
                                    v.color.b = b
                                    v.color.a = a
                                end
                                Gladdy:UpdateFrame()
                            end,
                        },
                    },
                },
            },
        },
        npTotemColors = {
            order = 50,
            name = L["Customize Totems"],
            type = "group",
            childGroups = "tree",
            disabled = function() return not Gladdy.db.npTotems end,
            args = select(2, GetTotemColorDefaultOptions())
        },
    }
end