if select(2, UnitClass("player")) ~= "SHAMAN" then
    return
end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers")

local Timers = XiTimers.timers

local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures

local shield = nil

function TotemTimers.CreateShieldTracker()
    shield = XiTimers:new(1)
    shield.button.icons[1]:SetTexture(SpellTextures[SpellIDs.LightningShield])
    shield.button.anchorframe = TotemTimers_TrackerFrame
    shield.button:SetScript("OnEvent", TotemTimers.ShieldEvent)
    shield.events[1] = "UNIT_SPELLCAST_SUCCEEDED"
    shield.events[2] = "UNIT_AURA"
    shield.timeStyle = "blizz"
    shield.Activate = function(self)
        XiTimers.Activate(self)
        TotemTimers.ShieldEvent(self.button, "UNIT_AURA")
        if not TotemTimers.ActiveProfile.ShieldTracker then
            self.button:Hide()
        end
    end
    shield.button:SetAttribute("*type*", "spell")
    shield.button:SetAttribute("*unit*", "player")
    shield.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")

    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        shield.button:SetAttribute("*spell1", SpellIDs.LightningShield)
    else
        for k,v in pairs(TotemTimers.ShieldButtons) do
            shield.button:SetAttribute("*spell"..k, v)
        end
    end

    shield.button:SetScript("OnDragStop", function(self)
        XiTimers.StopMoving(self)
    end)

    TotemTimers.ShieldTracker = shield

    -- need empty earthshield timer in vanilla for compatibility
    if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
        XiTimers:new(1)
    end
end

table.insert(TotemTimers.Modules, TotemTimers.CreateShieldTracker)


local ShieldChargesOnly = false

local ShieldSpellNames = {}
for k,v in pairs(TotemTimers.ShieldSpells) do
    ShieldSpellNames[SpellNames[v]] = true
end

function TotemTimers.ShieldEvent(self, event, unit)
    if event == "UNIT_SPELLCAST_SUCCEEDED" and unit == "player" then
        local start, duration, enable = GetSpellCooldown(SpellIDs.LightningShield)
        if start and duration and (not self.timer.timerOnButton or self.timer.timers[1] <= 0) then
            CooldownFrame_Set(self.cooldown, start, duration, enable)
        end
    elseif unit == "player" then
        self.count:SetText("")
        local name, texture, count, duration, endtime
        local hasBuff = false
        for i = 1, 40 do
            name, texture, count, _, duration, endtime = UnitBuff("player", i)
            if ShieldSpellNames[name] then
                hasBuff = true
                local timeleft = endtime - GetTime()
                if name ~= self.shield
                 or (not ShieldChargesOnly and timeleft > self.timer.timers[1])
                 or ShieldChargesOnly
                  then
                    self.icons[1]:SetTexture(texture)
                    self.timer.expirationMsgs[1] = "Shield"
                    self.timer.earlyExpirationMsgs[1] = "Shield"
                    self.timer.warningIcons[1] = texture
                    self.timer.warningSpells[1] = name
                    self.shield = name
                    if not ShieldChargesOnly then
                        self.timer.warningPoint = 10
                        self.timer:Start(1, timeleft, duration)
                    else
                        self.timer.warningPoint = 0
                        self.timer:Start(1, count, 3)
                    end
                end
                if not ShieldChargesOnly then
                    if count and count > 0 then
                        self.count:SetText(count)
                    else
                        self.count:SetText("")
                    end
                end
                break
            end
        end
        if not hasBuff and self.timer.timers[1] > 0 then
            self.timer:Stop(1)
        end
    end
end

local function EmptyUpdate()
end

function TotemTimers.SetShieldUpdate()
    ShieldChargesOnly = TotemTimers.ActiveProfile.ShieldChargesOnly
    if ShieldChargesOnly then
        Timers[6].Update = EmptyUpdate
        Timers[6].prohibitCooldown = true
        Timers[6].timeStyle = "sec"
        Timers[6].button.count:SetText("")
    else
        Timers[6].Update = nil
        Timers[6].prohibitCooldown = false
        Timers[6].timeStyle = TotemTimers.ActiveProfile.TimeStyle --"blizz"
    end
    TotemTimers.ShieldEvent(Timers[6].button, "UNIT_AURA", "player")
end
