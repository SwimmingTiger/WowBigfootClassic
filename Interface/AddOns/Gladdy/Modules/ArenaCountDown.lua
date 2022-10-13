local str_find, pairs = string.find, pairs
local CreateFrame = CreateFrame

local Gladdy = LibStub("Gladdy")
local L = Gladdy.L
local ACDFrame = Gladdy:NewModule("Arena Countdown", nil, {
    countdown = true,
    arenaCountdownSize = 256,
    arenaCountdownFrameStrata = "HIGH",
    arenaCountdownFrameLevel = 50,
})

function ACDFrame:OnEvent(event, ...)
    self[event](self, ...)
end

function ACDFrame:Initialize()
    self.locale = Gladdy:GetArenaTimer()
    self.countdown = -1
    self.texturePath = "Interface\\AddOns\\Gladdy\\Images\\Countdown\\";

    local ACDNumFrame = CreateFrame("Frame", "ACDNumFrame", UIParent)
    self.ACDNumFrame = ACDNumFrame
    self.ACDNumFrame:EnableMouse(false)
    self.ACDNumFrame:SetHeight(Gladdy.db.arenaCountdownSize)
    self.ACDNumFrame:SetWidth(Gladdy.db.arenaCountdownSize)
    self.ACDNumFrame:SetPoint("CENTER", 0, 128)
    self.ACDNumFrame:Hide()

    local ACDNumTens = ACDNumFrame:CreateTexture("ACDNumTens", "HIGH")
    self.ACDNumTens = ACDNumTens
    self.ACDNumTens:SetWidth(Gladdy.db.arenaCountdownSize)
    self.ACDNumTens:SetHeight(Gladdy.db.arenaCountdownSize)
    self.ACDNumTens:SetPoint("CENTER", self.ACDNumFrame, "CENTER", -(Gladdy.db.arenaCountdownSize/8 + Gladdy.db.arenaCountdownSize/8/2), 0)

    local ACDNumOnes = ACDNumFrame:CreateTexture("ACDNumOnes", "HIGH")
    self.ACDNumOnes = ACDNumOnes
    self.ACDNumOnes:SetWidth(Gladdy.db.arenaCountdownSize)
    self.ACDNumOnes:SetHeight(Gladdy.db.arenaCountdownSize)
    self.ACDNumOnes:SetPoint("CENTER", self.ACDNumFrame, "CENTER", (Gladdy.db.arenaCountdownSize/8 + Gladdy.db.arenaCountdownSize/8/2), 0)

    local ACDNumOne = ACDNumFrame:CreateTexture("ACDNumOne", "HIGH")
    self.ACDNumOne = ACDNumOne
    self.ACDNumOne:SetWidth(Gladdy.db.arenaCountdownSize)
    self.ACDNumOne:SetHeight(Gladdy.db.arenaCountdownSize)
    self.ACDNumOne:SetPoint("CENTER", self.ACDNumFrame, "CENTER", 0, 0)

    if Gladdy.db.countdown then
        self:RegisterMessage("JOINED_ARENA")
        self:RegisterMessage("ENEMY_SPOTTED")
        self:RegisterMessage("UNIT_SPEC")
    end
    self.faction = UnitFactionGroup("player")
    self:SetScript("OnEvent", ACDFrame.OnEvent)
end

function ACDFrame:UpdateFrameOnce()
    if Gladdy.db.countdown then
        self:RegisterMessage("JOINED_ARENA")
        self:RegisterMessage("ENEMY_SPOTTED")
        self:RegisterMessage("UNIT_SPEC")
    else
        self:UnregisterAllMessages()
    end
    self.ACDNumFrame:SetFrameStrata(Gladdy.db.arenaCountdownFrameStrata)
    self.ACDNumFrame:SetFrameLevel(Gladdy.db.arenaCountdownFrameLevel)

    self.ACDNumFrame:SetHeight(Gladdy.db.arenaCountdownSize)
    self.ACDNumFrame:SetWidth(Gladdy.db.arenaCountdownSize)
    self.ACDNumFrame:SetPoint("CENTER", 0, 128)

    self.ACDNumTens:SetWidth(Gladdy.db.arenaCountdownSize)
    self.ACDNumTens:SetHeight(Gladdy.db.arenaCountdownSize)
    self.ACDNumTens:SetPoint("CENTER", self.ACDNumFrame, "CENTER", -(Gladdy.db.arenaCountdownSize/8 + Gladdy.db.arenaCountdownSize/8/2), 0)

    self.ACDNumOnes:SetWidth(Gladdy.db.arenaCountdownSize)
    self.ACDNumOnes:SetHeight(Gladdy.db.arenaCountdownSize)
    self.ACDNumOnes:SetPoint("CENTER", self.ACDNumFrame, "CENTER", (Gladdy.db.arenaCountdownSize/8 + Gladdy.db.arenaCountdownSize/8/2), 0)

    self.ACDNumOne:SetWidth(Gladdy.db.arenaCountdownSize)
    self.ACDNumOne:SetHeight(Gladdy.db.arenaCountdownSize)
    self.ACDNumOne:SetPoint("CENTER", self.ACDNumFrame, "CENTER", 0, 0)
end

function ACDFrame:HideAll()
    self.ACDNumFrame:Hide()
    self.ACDNumTens:Hide()
    self.ACDNumOnes:Hide()
    self.ACDNumOne:Hide()
end

function ACDFrame:CreateTicker(countdown)
    self.countdown = countdown
    if self.ticker and not self.ticker:IsCancelled() then
        self.ticker:Cancel()
    end
    self.ticker = C_Timer.NewTicker(1, ACDFrame.Ticker)
end

function ACDFrame.Ticker()
    local self = ACDFrame
    if (Gladdy.db.countdown) then
        self.ACDNumFrame:Show()
        if (self.countdown and self.countdown >= 10 and self.countdown <= 60) then
            -- Display has 2 digits
            local ones = self.countdown % 10
            local tens = (self.countdown / 10) % 10
            self.ACDNumOne:Hide()
            self.ACDNumTens:Show()
            self.ACDNumOnes:Show()

            self.ACDNumTens:SetTexture(self.texturePath .. tens)
            self.ACDNumOnes:SetTexture(self.texturePath .. ones)
            self.ACDNumFrame:SetScale(0.7)
        elseif (self.countdown and self.countdown < 10 and self.countdown > -1) then
            -- Display has 1 digit
            local path = self.countdown <= 0 and self.faction or self.countdown
            self.ACDNumOne:Show()
            self.ACDNumOne:SetTexture(self.texturePath .. path)
            self.ACDNumOnes:Hide()
            self.ACDNumTens:Hide()
            self.ACDNumFrame:SetScale(1.0)
        else
            ACDFrame:HideAll()
            if (self.countdown and self.countdown < -1) then
                self.ticker:Cancel()
            end
        end
        self.countdown = self.countdown and self.countdown - 1
    else
        ACDFrame:HideAll()
    end
end

function ACDFrame:JOINED_ARENA()
    if Gladdy.db.countdown then
        self:CreateTicker(nil)
        self:RegisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
    end
end

function ACDFrame:Reset()
    if self.ticker and not self.ticker:IsCancelled() then
        self.ticker:Cancel()
    end
    self.countdown = nil
    self:UnregisterEvent("CHAT_MSG_BG_SYSTEM_NEUTRAL")
    ACDFrame:HideAll()
end

function ACDFrame:ENEMY_SPOTTED()
    if not Gladdy.frame.testing then
        ACDFrame:Reset()
    end
end

function ACDFrame:UNIT_SPEC()
    if not Gladdy.frame.testing then
        ACDFrame:Reset()
    end
end

function ACDFrame:CHAT_MSG_BG_SYSTEM_NEUTRAL(msg)
    for k,v in pairs(self.locale) do
        if str_find(msg, v) then
            if self.countdown and self.countdown == 0 then
                return
            end
            self.countdown = k
        end
    end
end

function ACDFrame:TestOnce()
    self:CreateTicker(30)
end

function ACDFrame:GetOptions()
    return {
        headerArenaCountdown = {
            type = "header",
            name = L["Arena Countdown"],
            order = 2,
        },
        countdown = Gladdy:option({
            type = "toggle",
            name = L["Enabled"],
            desc = L["Turns countdown before the start of an arena match on/off."],
            order = 3,
            width = "full",
        }),
        arenaCountdownSize = Gladdy:option({
            type = "range",
            name = L["Size"],
            order = 4,
            min = 64,
            max = 512,
            step = 16,
            width = "full",
            disabled = function() return not Gladdy.db.countdown end,
        }),
        headerAuraLevel = {
            type = "header",
            name = L["Frame Strata and Level"],
            order = 5,
        },
        arenaCountdownFrameStrata = Gladdy:option({
            type = "select",
            name = L["Frame Strata"],
            order = 6,
            values = Gladdy.frameStrata,
            sorting = Gladdy.frameStrataSorting,
            disabled = function() return not Gladdy.db.countdown end,
        }),
        arenaCountdownFrameLevel = Gladdy:option({
            type = "range",
            name = L["Frame Level"],
            min = 0,
            max = 500,
            step = 1,
            order = 7,
            width = "full",
            disabled = function() return not Gladdy.db.countdown end,
        }),
    }
end
