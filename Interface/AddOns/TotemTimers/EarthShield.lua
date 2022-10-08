if select(2, UnitClass("player")) ~= "SHAMAN" then
    return
end

local _, TotemTimers = ...

local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures
local AvailableSpells = TotemTimers.AvailableSpells

local earthShieldTarget = UnitName("player")
local earthShieldTargetGUID = UnitGUID("player")


local earthshieldTimer = nil

local buttons = { "LeftButton", "RightButton", "MiddleButton", "Button4" }


local function splitString(ustring)
    local c = 0
    local s = ""
    for uchar in string.gmatch(ustring, "([%z\1-\127\194-\244][\128-\191]*)") do
        c = c + 1
        s = s .. uchar
        if c == 4 then
            break
        end
    end
    return s
end


function TotemTimers.CreateEarthShieldTracker()
    earthshieldTimer = XiTimers:new(1)

    earthshieldTimer.button.icons[1]:SetTexture(SpellTextures[SpellIDs.EarthShield])
    earthshieldTimer.button.anchorframe = TotemTimers_TrackerFrame
    earthshieldTimer.button:SetScript("OnEvent", TotemTimers.EarthShieldEvent)
    earthshieldTimer.events[1] = "COMBAT_LOG_EVENT_UNFILTERED"
    earthshieldTimer.events[2] = "UNIT_AURA"
    earthshieldTimer.events[3] = "GROUP_ROSTER_UPDATE"
    earthshieldTimer.events[4] = "PLAYER_REGEN_ENABLED"
    earthshieldTimer.events[5] = "PARTY_LEADER_CHANGED"
    earthshieldTimer.events[6] = "PLAYER_ENTERING_WORLD"
    earthshieldTimer.playerEvents[1] = "UNIT_SPELLCAST_SUCCEEDED"
    earthshieldTimer.events[7] = "UNIT_SPELLCAST_SENT"
    earthshieldTimer.timeStyle = "blizz"
    earthshieldTimer.button:SetAttribute("*type*", "spell")
    earthshieldTimer.Activate = function(self)
        XiTimers.Activate(self)
        self.button:SetAttribute("*spell*", SpellNames[SpellIDs.EarthShield])
        if not TotemTimers.ActiveProfile.EarthShieldTracker then
            self.button:Hide()
        end
    end
    earthshieldTimer.button:RegisterForClicks("LeftButtonDown", "RightButtonDown", "MiddleButtonDown", "Button4Down")
    earthshieldTimer.manaCheck = SpellNames[SpellIDs.EarthShield]
    earthshieldTimer.nameframe = CreateFrame("Frame", earthshieldTimer.button)
    earthshieldTimer.nameframe:SetParent(earthshieldTimer.button)
    earthshieldTimer.nameframe:SetPoint("TOPLEFT", earthshieldTimer.button)
    earthshieldTimer.nameframe:SetPoint("BOTTOMRIGHT", earthshieldTimer.button)
    earthshieldTimer.name = earthshieldTimer.nameframe:CreateFontString("TotemTimers_EarthShieldName")
    earthshieldTimer.name:SetPoint("TOP", earthshieldTimer.nameframe)
    earthshieldTimer.name:SetFont(earthshieldTimer.button.hotkey:GetFont())
    earthshieldTimer.nameframe:SetFrameLevel(10)

    earthshieldTimer.expirationMsgs[1] = "EarthShield"
    earthshieldTimer.earlyExpirationMsgs[1] = "EarthShield"
    earthshieldTimer.warningIcons[1] = SpellTextures[SpellIDs.EarthShield]
    earthshieldTimer.warningSpells[1] = SpellNames[SpellIDs.EarthShield]
    earthshieldTimer.warningPoint = 0

    earthshieldTimer.Stop = function(self, nr)
        XiTimers.Stop(self, nr)
        if earthShieldTarget then
            self.name:SetText(splitString(earthShieldTarget))
        end
    end

    earthshieldTimer.Start = function(self, nr, time, duration)
        XiTimers.Start(self, nr, time, duration)
        if earthShieldTarget then
            self.name:SetText(splitString(earthShieldTarget))
        end
    end

    --create maintank bar for es
    earthshieldTimer.actionBar = TTActionBars:new(4, earthshieldTimer.button, nil, TotemTimers_TrackerFrame)

    for i = 1, 4 do
        earthshieldTimer.button:WrapScript(earthshieldTimer.actionBar.buttons[i], "PostClick", [[
                local p = self:GetParent()
                local nr = p:GetAttribute("RecastButton")
                if nr then
                    p:SetAttribute("*unit"..nr, self:GetAttribute("*unit1"))
                    control:CallMethod("UpdateESName")
                end
        ]])
    end
    earthshieldTimer.button.UpdateESName = function(self)
        if self.timer.timers[1] <= 0 then
            local button = self:GetAttribute("RecastButton")
            if button then
                local unit = self:GetAttribute("*unit" .. button)
                if unit and UnitExists(unit) then
                    self.timer.name:SetText(splitString(UnitName(unit)))
                end
            end
        end
    end

    TotemTimers.SetEarthShieldMainTankList()

    earthshieldTimer.button:SetScript("OnDragStop", function(self)
        XiTimers.StopMoving(self)
        TotemTimers.ProcessSetting("ESMainTankMenuDirection")
        if not InCombatLockdown() then
            earthshieldTimer.button:SetAttribute("hide", true)
        end
    end)

    TotemTimers.EarthShieldTracker = earthshieldTimer
    TotemTimers.SetEarthShieldButtons()

end

table.insert(TotemTimers.Modules, TotemTimers.CreateEarthShieldTracker)


local earthShieldRecast = false

function TotemTimers.SetEarthShieldButtons()
    local Settings = TotemTimers.ActiveProfile
    local recastbutton = nil
    local menubutton = nil
    earthShieldRecast = false
    earthshieldTimer.button:SetAttribute("OpenMenu", nil)
    earthshieldTimer.button:SetAttribute("RecastButton", nil)

    for k,v in pairs({"EarthShieldLeftButton", "EarthShieldRightButton", "EarthShieldMiddleButton", "EarthShieldButton4"}) do
        if Settings[v] == "recast" then
            recastbutton = k
            earthShieldRecast = true
            earthshieldTimer.button:SetAttribute("*spell"..k, SpellNames[SpellIDs.EarthShield])
        elseif Settings[v] == "menu" and not menubutton then
            menubutton = k
            earthshieldTimer.button:SetAttribute("*spell"..k, nil)
        else
            earthshieldTimer.button:SetAttribute("*unit"..k, Settings[v])
            earthshieldTimer.button:SetAttribute("*spell"..k, SpellNames[SpellIDs.EarthShield])
        end
    end

    if not menubutton and Settings.ESMainTankMenu then
        earthshieldTimer.button:SetAttribute("OpenMenu", "mouseover")
    end
    if menubutton then
        earthshieldTimer.button:SetAttribute("OpenMenu", buttons[menubutton])
    end
    earthshieldTimer.button:SetAttribute("RecastButton", recastbutton)
end


-- This frame is activated if the class of a unit cannot be determined at the time the unit enters the group
local MainTankUpdateTimer = 5
local MainTankListUpdateFrame = CreateFrame("Frame")
MainTankListUpdateFrame:Hide()
MainTankListUpdateFrame:SetScript("OnShow", function(self)
    MainTankUpdateTimer = 5
end)
MainTankListUpdateFrame:SetScript("OnUpdate", function(self, elapsed)
    MainTankUpdateTimer = MainTankUpdateTimer - elapsed
    if MainTankUpdateTimer <= 0 then
        if InCombatLockdown() then
            MainTankUpdateTimer = 5
        else
            self:Hide()
            TotemTimers.SetEarthShieldMainTankList()
        end
    end
end)

local function SetUnit(unit, button)
    button:SetAttribute("*unit1", unit)
    button.hotkey:SetText(splitString(UnitName(unit)))
    local _, class = UnitClass(unit)
    if class then
        if RAID_CLASS_COLORS[class] then
            button.hotkey:SetTextColor(RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b)
        end
        button.icon:SetTexture("Interface\\TargetingFrame\\UI-Classes-Circles")
        button.icon:SetTexCoord(unpack(CLASS_ICON_TCOORDS[class]))
    else
        MainTankListUpdateFrame:Show()
    end
end

function TotemTimers.SetEarthShieldMainTankList()
    earthshieldTimer.actionBar:ResetSpells()

    if GetNumGroupMembers() > 0 then
        local b = 0
        for i = 1, 40 do
            local unit = "raid" .. i
            if b < 4 and UnitExists(unit) then
                if GetPartyAssignment("MAINTANK", unit)
                        or UnitGroupRolesAssigned(unit) == "TANK" then
                    b = b + 1
                    earthshieldTimer.actionBar:AddSpell(SpellNames[SpellIDs.EarthShield])
                    SetUnit(unit, earthshieldTimer.actionBar.buttons[b])
                end
            end
        end
        if b < 4 then
            earthshieldTimer.actionBar:AddSpell(SpellNames[SpellIDs.EarthShield])
            SetUnit("player", earthshieldTimer.actionBar.buttons[b + 1])
        end
    else
        earthshieldTimer.actionBar:AddSpell(SpellNames[SpellIDs.EarthShield])
        SetUnit("player", earthshieldTimer.actionBar.buttons[1])
    end
end

function TotemTimers.ChangeEarthShieldTarget()
    for k, v in pairs(buttons) do
        if TotemTimers.ActiveProfile["EarthShield" .. v] == "recast" then
            earthshieldTimer.button:SetAttribute("*unit" .. k, earthShieldTarget)
        end
    end
end

local EarthShieldSpellName = SpellNames[SpellIDs.EarthShield]

local ESChargesOnly = false

local function checkESBuff(self)
    local unit = earthShieldTarget

    if UnitGUID("target") == earthShieldTargetGUID then
        unit = "target"
    elseif UnitGUID("focus") == earthShieldTargetGUID then
        unit = "focus"
    end

    local hasBuff = false

    for i = 1, 40 do
        local name, _, count, _, duration, endtime, source = UnitBuff(unit, i)

        if name == EarthShieldSpellName and source == "player" then
            hasBuff = true
            local timeleft = endtime - GetTime()
            if not ESChargesOnly then
                self.count:SetText(count)
            end
            if timeleft - self.timer.timers[1] > 0.1 or ESChargesOnly then
                self.timer.expirationMsgs[1] = "EarthShield"
                self.timer.earlyExpirationMsgs[1] = "EarthShield"
                if not ESChargesOnly then
                    self.timer:Start(1, timeleft, duration)
                else
                    self.timer:Start(1, count, 9)
                end
            end
            break
        end
    end
    if not hasBuff and self.timer.timers[1] > 0 then
        self.timer:Stop(1)
        self.count:SetText("")
    end
end

local lastESCastGUID = nil
local lastESCastTarget = nil
local lastESCastUnitGUID = nil
local changeEarthShieldRecast = nil


function TotemTimers.EarthShieldEvent(self, event, ...)
    if not AvailableSpells[SpellIDs.EarthShield] then
        return
    end
    if event == "UNIT_SPELLCAST_SENT" then
        local _, target, castGUID, spellID = ...
        local spellName = GetSpellInfo(spellID)

        if spellName == EarthShieldSpellName then
            lastESCastTarget = target
            lastESCastGUID = castGUID
            lastESCastUnitGUID = UnitGUID(target)

            if not lastESCastUnitGUID then
                if target == UnitName("target") then lastESCastUnitGUID = UnitGUID("target")
                elseif target == UnitName("focus") then lastESCastUnitGUID = UnitGUID("focus") end
            end
        end
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        local start, duration, enable = GetSpellCooldown(EarthShieldSpellName)
        if start and duration and (not self.timer.timerOnButton or self.timer.timers[1] <= 0) then
            CooldownFrame_Set(self.cooldown, start, duration, enable)
        end
        local _, castGUID = ...
        if castGUID == lastESCastGUID then
            earthShieldTarget = lastESCastTarget
            earthShieldTargetGUID = lastESCastUnitGUID

            if earthShieldRecast then
                if not InCombatLockdown() then
                    TotemTimers.ChangeEarthShieldTarget()
                else
                    changeEarthShieldRecast = true
                end
            end
        end
    elseif event == "UNIT_AURA" and earthShieldTargetGUID then
        local unit = ...
        if UnitGUID(unit) == earthShieldTargetGUID then
            checkESBuff(self)
        end
    elseif event == "PLAYER_REGEN_ENABLED" and earthShieldRecast and changeEarthShieldRecast then
        TotemTimers.ChangeEarthShieldTarget()
    elseif (event == "GROUP_ROSTER_UPDATE" or event == "PLAYER_ENTERING_WORLD") then
        if earthShieldRecast and earthShieldTarget then
            if InCombatLockdown() then
                changeEarthShieldRecast = true
            else
                TotemTimers.ChangeEarthShieldTarget()
            end
        end
        if not InCombatLockdown() then
            TotemTimers.SetEarthShieldMainTankList()
        else
            MainTankListUpdateFrame:Show()
        end
    end
end

local function EmptyESUpdate()
end

function TotemTimers.SetEarthShieldUpdate()
    ESChargesOnly = TotemTimers.ActiveProfile.ESChargesOnly
    if TotemTimers.ActiveProfile.ESChargesOnly then
        earthshieldTimer.Update = EmptyESUpdate
        earthshieldTimer.prohibitCooldown = true
        earthshieldTimer.timeStyle = "sec"
    else
        earthshieldTimer.Update = nil
        earthshieldTimer.prohibitCooldown = false
        earthshieldTimer.timeStyle = "blizz"
    end
    if earthShieldTarget then
        TotemTimers.EarthShieldEvent(earthshieldTimer.button, "UNIT_AURA", earthShieldTarget)
    end
end

