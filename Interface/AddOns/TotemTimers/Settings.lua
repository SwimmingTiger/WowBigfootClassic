if select(2, UnitClass("player")) ~= "SHAMAN" then
    return
end

local TRACKER_START = 5
local TRACKER_END = 8
local Timers = XiTimers.timers

local SpellIDs = TotemTimers.SpellIDs
local SpellNames = TotemTimers.SpellNames
local AvailableSpells = TotemTimers.AvailableSpells

-- local TotemFrameScript = TotemFrame:GetScript("OnShow")

local LSM = LibStub:GetLibrary("LibSharedMedia-3.0", true)

--[[local TotemColors = {
    --[AIR_TOTEM_SLOT] = {0.7,0.7,1.0},
    [AIR_TOTEM_SLOT] = {1,1,1},
    [WATER_TOTEM_SLOT] = {0.4,0.4,1.0},
    [FIRE_TOTEM_SLOT] = {1.0,0.1,0.1},
    [EARTH_TOTEM_SLOT] = {0.7,0.5,0.3},
}]]
local TotemColors = TotemTimers.ElementColors

local SettingsFunctions

local PartyRangePositions = {
    ["TOP"] = { "BOTTOMLEFT", "TOPLEFT", "LEFT", "RIGHT", 1, 0 },
    ["LEFT"] = { "TOPRIGHT", "TOPLEFT", "TOP", "BOTTOM", 0, -1 },
    ["BOTTOM"] = { "TOPLEFT", "BOTTOMLEFT", "LEFT", "RIGHT", 1, 0 },
    ["RIGHT"] = { "TOPLEFT", "TOPRIGHT", "TOP", "BOTTOM", 0, -1 }
}

function TotemTimers.ProcessSetting(setting)
    if SettingsFunctions[setting] then
        SettingsFunctions[setting](TotemTimers.ActiveProfile[setting], XiTimers.timers)
    end
end

function TotemTimers.ProcessAllSettings()
    for k, v in pairs(TotemTimers.ActiveProfile) do
        TotemTimers.ProcessSetting(k)
    end
end

SettingsFunctions = {
    --[[ShowTimerBars =
    function(value, Timers)
        for _,timer in pairs(Timers) do
            timer.visibleTimerBars = value
            for n,t in pairs(timer.timers) do
                if t>0 and value then
                    timer:ShowTimerBar(n)
                else
                    timer.timerBars[n].background:Hide()
                    timer.timerBars[n]:SetValue(0)
                end
            end
        end
    end,]]

    FlashRed = function(value, Timers)
        for _, timer in pairs(Timers) do
            timer.flashRed = value
        end
    end,

    TimeStyle = function(value, Timers)
        for k, timer in pairs(Timers) do
            if timer ~= TotemTimers.ShieldTracker
                    and timer ~= TotemTimers.EarthShieldTracker
                    and timer ~= TotemTimers.FlameShockDuration
                    and timer ~= TotemTimers.Maelstrom
            then
                timer.timeStyle = value
            end
        end
    end,

    TimerSize = function(value, Timers)
        local v = value
        local scale = v / 36
        if TotemTimers_MultiSpell and Timers[1].button:GetParent() == TotemTimers_MultiSpell then
            scale = 1
        end
        for e = 1, 4 do
            Timers[e]:SetScale(scale)
        end
        if TotemTimers_MultiSpell then
            TotemTimers_MultiSpell:SetScale(v / 36)
        end
    end,

    TrackerSize = function(value, Timers)
        for e = TRACKER_START, TRACKER_END do
            Timers[e]:SetScale(value / 36)
        end
    end,

    TimerTimeHeight = function(value, Timers)
        for e = 1, 4 do
            Timers[e]:SetTimeHeight(value)
            Timers[e].button.time:SetFont(Timers[e].button.time:GetFont(), value + 5, "OUTLINE")
        end
    end,

    TrackerTimeHeight = function(value, Timers)
        for e = TRACKER_START, TRACKER_END do
            Timers[e]:SetTimeHeight(value)
            Timers[e].button.time:SetFont(Timers[e].button.time:GetFont(), value + 5, "OUTLINE")
        end
        --[[ for e=22, 23 do
            Timers[e]:SetTimeHeight(value)
            Timers[e].button.time:SetFont(Timers[e].button.time:GetFont(),value+5,"OUTLINE")
        end ]]
    end,

    TimerSpacing = function(value, Timers)
        for e = 1, 4 do
            Timers[e]:SetSpacing(value)
        end
    end,

    TrackerSpacing = function(value, Timers)
        for e = TRACKER_START, TRACKER_END do
            Timers[e]:SetSpacing(value)
        end
        --[[ for e=22, 23 do
            Timers[e]:SetSpacing(value)
        end ]]
    end,

    TimerTimeSpacing = function(value, Timers)
        for e = 1, 4 do
            Timers[e]:SetTimeSpacing(value)
        end
    end,

    TrackerTimeSpacing = function(value, Timers)
        for e = TRACKER_START, TRACKER_END do
            Timers[e]:SetTimeSpacing(value)
        end
        --[[ for e=22, 23 do
             Timers[e]:SetTimeSpacing(value)
         end ]]
    end,

    TimerTimePos = function(value, Timers)
        for e = 1, 4 do
            Timers[e]:SetTimerBarPos(value)
        end
    end,

    TrackerTimePos = function(value, Timers)
        for e = TRACKER_START, TRACKER_END do
            Timers[e]:SetTimerBarPos(value)
        end
    end,

    AnkhTracker = function(value, Timers)
        if value and AvailableSpells[SpellIDs.Ankh] then
            Timers[5]:Activate()
        else
            Timers[5]:Deactivate()
        end
        TotemTimers.OrderTrackers()
    end,

    ShieldTracker = function(value, Timers)
        Timers[6].ActiveWhileHidden = TotemTimers.ActiveProfile.ActivateHiddenTimers and not value
        if (value or TotemTimers.ActiveProfile.ActivateHiddenTimers) and (AvailableSpells[SpellIDs.LightningShield] or AvailableSpells[SpellIDs.WaterShield]) then
            Timers[6]:Activate()
        else
            Timers[6]:Deactivate()
        end
        TotemTimers.OrderTrackers()
    end,

    ShieldChargesOnly = function(value, Timers)
        TotemTimers.SetShieldUpdate()
    end,


    WeaponTracker = function(value, Timers)
        Timers[8].ActiveWhileHidden = TotemTimers.ActiveProfile.ActivateHiddenTimers and not value
        if (value or TotemTimers.ActiveProfile.ActivateHiddenTimers) and AvailableSpells[SpellIDs.RockbiterWeapon] then
            Timers[8]:Activate()
        else
            Timers[8]:Deactivate()
        end
        TotemTimers.OrderTrackers()
    end,

    LastWeaponEnchant = function(value, Timers)
        local button = TotemTimers.WeaponTracker.button

        if type(value) ~= "number" then
            value = select(7, GetSpellInfo(value))
        end

        if value and value >= 5 and value <= 7 then
            local ds1 = value == 7 and SpellIDs.FlametongueWeapon or SpellIDs.WindfuryWeapon
            local ds2 = value == 6 and SpellIDs.FrostbrandWeapon or SpellIDs.FlametongueWeapon

            button:SetAttribute("type1", "macro")
            button:SetAttribute("doublespell1", SpellNames[ds1])
            button:SetAttribute("doublespell2", SpellNames[ds2])
            button:SetAttribute("ds", 1)
            -- update rank and set macro from attribute because of ft-1/ft-button
            TotemTimers.UpdateRank(button)
        else
            if not GetSpellInfo(value) then
                value = SpellIDs.RockbiterWeapon
            end
            button:SetAttribute("type1", "spell")
            button:SetAttribute("spell1", value)
        end
    end,

    LastWeaponEnchant2 = function(value, Timers)
        if not value then
            return
        end
        local type = "spell2"
        if TotemTimers.ActiveProfile.WeaponMenuOnRightclick then
            type = "spell3"
        end
        if not GetSpellInfo(value) then
            value = SpellIDs.RockbiterWeapon
        end
        Timers[8].button:SetAttribute(type, value)
    end,

    Order = function(value, Timers)
        for i = 1, 4 do
            Timers[i] = _G["XiTimers_Timer" .. value[i]].timer
        end
        TotemTimers.OrderTimers()
    end,

    OpenOnRightclick = function(value, Timers)
        for i = 1, 4 do
            if value and not TotemTimers.ActiveProfile.MenusAlwaysVisible then
                Timers[i].button:SetAttribute("OpenMenu", "RightButton")
                Timers[i].button:SetAttribute("*type3", "macro")
                Timers[i].button:SetAttribute("*macrotext3", "/script XiTimers.timers[" .. i .. "].stopQuiet = true DestroyTotem(" .. Timers[i].nr .. ")")
                Timers[i].button:SetAttribute("*macrotext2", "")
            else
                Timers[i].button:SetAttribute("OpenMenu", "mouseover")
                Timers[i].button:SetAttribute("type2", "macro")
                Timers[i].button:SetAttribute("macrotext2", "/script XiTimers.timers[" .. i .. "].stopQuiet = true DestroyTotem(" .. Timers[i].nr .. ")")
                Timers[i].button:SetAttribute("type3", "spell")
                Timers[i].button:SetAttribute("spell3", SpellIDs.TotemicCall)
            end
        end
        if TotemTimers_MultiSpell then
            if value and not TotemTimers.ActiveProfile.MenusAlwaysVisible then
                TotemTimers_MultiSpell:SetAttribute("OpenMenu", "RightButton")
                TotemTimers_MultiSpell:SetAttribute("*type2", nil)
                TotemTimers_MultiSpell:SetAttribute("*spell2", nil)
            else
                TotemTimers_MultiSpell:SetAttribute("OpenMenu", "mouseover")
                TotemTimers_MultiSpell:SetAttribute("*type2", "spell")
                TotemTimers_MultiSpell:SetAttribute("*spell2", SpellIDs.TotemicCall)
            end
        end
    end,

    MenusAlwaysVisible = function(value, Timers)
        if value then
            for i = 1, 4 do
                Timers[i].button:SetAttribute("OpenMenu", "always")
            end
        end
        for i = 1, 4 do
            TTActionBars.bars[i]:SetAlwaysVisible(value)
        end
        if TotemTimers_MultiSpell then
            if value then
                TotemTimers_MultiSpell:SetAttribute("OpenMenu", "always")
            end
            TotemTimers_MultiSpell.actionBar:SetAlwaysVisible(value)
        end
    end,

    MiniIcons = function(value, Timers)
        for e = 1, 4 do
            if value then
                Timers[e].button.miniIconFrame:Show()
            else
                Timers[e].button.miniIconFrame:Hide()
            end
        end
    end,

    Lock = function(value, Timers)
        for k, v in pairs(Timers) do
            v.locked = value
        end
    end,

    Show = function(value, Timers)
        if value then
            for i = 1, 4 do
                if (Timers[i].nr == FIRE_TOTEM_SLOT and AvailableSpells[SpellIDs.Searing])
                        or (Timers[i].nr == EARTH_TOTEM_SLOT and (AvailableSpells[SpellIDs.Stoneskin] or AvailableSpells[SpellIDs.Earthbind] or AvailableSpells[SpellIDs.StoneBulwark]))
                        or (Timers[i].nr == WATER_TOTEM_SLOT and (AvailableSpells[SpellIDs.HealingStream] or AvailableSpells[SpellIDs.ManaSpring]))
                        or (Timers[i].nr == AIR_TOTEM_SLOT and (AvailableSpells[SpellIDs.Grounding] or AvailableSpells[SpellIDs.NatureResistance] or AvailableSpells[SpellIDs.Windfury])) then
                    Timers[i]:Activate()
                end
            end
            --TotemTimersFrame:Show()
            TotemTimers.OrderTimers()
        else
            for i = 1, 4 do
                Timers[i]:Deactivate()
            end
            --TotemTimersFrame:Hide()
        end
    end,

    ProcFlash = function(value, Timers)
        for i = 1, 4 do
            Timers[i].procFlash = value
        end
    end,

    TimeFont = function(value, Timers)
        local font = LSM:Fetch("font", value)
        if font then
            for _, timer in pairs(Timers) do
                timer:SetFont(font)
            end
        end
    end,

    TimerBarTexture = function(value, Timers)
        local texture = LSM:Fetch("statusbar", value)
        if texture then
            local maelstrom = TotemTimers.Maelstrom
            for _, timer in pairs(Timers) do
                if not maelstrom or maelstrom ~= timer then
                    timer:SetBarTexture(texture)
                end
            end
        end
    end,

    ColorTimerBars = function(value, Timers)
        for i = 1, #Timers do
            if value and i < 5 then
                Timers[i]:SetBarColor(TotemColors[Timers[i].nr].r, TotemColors[Timers[i].nr].g, TotemColors[Timers[i].nr].b, 1)
            elseif Timers[i] ~= TotemTimers.FlameShockDuration and (not TotemTimers.Maelstrom or Timers[i] ~= TotemTimers.Maelstrom) then
                Timers[i]:SetBarColor(TotemTimers.ActiveProfile.TimerBarColor.r, TotemTimers.ActiveProfile.TimerBarColor.g,
                        TotemTimers.ActiveProfile.TimerBarColor.b, TotemTimers.ActiveProfile.TimerBarColor.a)

            end
        end
    end,

    ShowCooldowns = function(value, Timers)
        if TotemTimers_IsSetUp then
            TotemTimers.OrderTimers()
            for i = 1, 4 do
                TotemTimers.TotemEvent(Timers[i].button, "SPELL_UPDATE_COOLDOWN", i)
            end
        end
    end,

    BarBindings = function(value, Timers)
        local actionBars = {}
        for i = 1, 4 do
            table.insert(actionBars, Timers[i].actionBar)
        end
        if TotemTimers_MultiSpell then
            table.insert(actionBars, TotemTimers_MultiSpell.actionBar)
        end

        for index, actionBar in pairs(actionBars) do
            local element = 0
            if index < 5 then
                element = Timers[index].nr
            end

            for j = 1, #actionBar.buttons do
                local button = actionBar.buttons[j]
                local key = GetBindingKey("TOTEMTIMERSCAST" .. element .. j)
                if TotemTimers.ActiveProfile.BarBindings and not TotemTimers.ActiveProfile.MenusAlwaysVisible then
                    if TotemTimers.ActiveProfile.ReverseBarBindings then
                        button.hotkey:SetText(key or tostring(10 - j))
                        button:SetAttribute("binding", tostring(10 - j))
                    else
                        button.hotkey:SetText(key or tostring(j))
                        button:SetAttribute("binding", tostring(j))
                    end
                else
                    button.hotkey:SetText(key or "")
                    button:SetAttribute("binding", nil)
                end
            end
        end
    end,

    TwistingTimer = function(value, Timers)
        if WOW_PROJECT_ID > WOW_PROJECT_BURNING_CRUSADE_CLASSIC then return end
        for i = 1, 4 do
            if XiTimers.timers[i].nr == AIR_TOTEM_SLOT then
                XiTimers.timers[i].twisting = value
            end
        end
    end,

    Tooltips = function(value, Timers)
        for i = 1, TRACKER_END do
            Timers[i].button:SetAttribute("tooltip", value)
        end
        for i = 1, TTActionBars.numbars do
            TTActionBars.bars[i]:SetTooltip(value)
        end
        if TotemTimers.LongCooldowns then
            for _, timer in pairs(TotemTimers.LongCooldowns) do
                timer.button:SetAttribute("tooltip", value)
            end
        end
    end,

    TotemTimerBarWidth = function(value, Timers)
        for i = 1, 4 do
            for j = 1, Timers[i].nrOfTimers do
                Timers[i].timerBars[j]:SetWidth(value)
            end
        end
    end,

    TrackerTimerBarWidth = function(value, Timers)
        for i = TRACKER_START, TRACKER_END do
            for j = 1, Timers[i].nrOfTimers do
                Timers[i].timerBars[j]:SetWidth(value)
            end
        end
        --[[ for i=22,23 do
            for j=1,Timers[i].nrOfTimers do
                Timers[i].timerBars[j]:SetWidth(value)
            end
        end ]]
    end,

    ActivateHiddenTimers = function(value, Timers)
        TotemTimers.ProcessSetting("ShieldTracker")
        TotemTimers.ProcessSetting("EarthShieldTracker")
        TotemTimers.ProcessSetting("WeaponTracker")
    end,

    ShowKeybinds = function(value, Timers)
        for _, t in pairs(Timers) do
            if value then
                t.button.hotkey:Show()
            else
                t.button.hotkey:Hide()
            end
        end
    end,

    FramePositions = function(value, Timers)
        for name, pos in pairs(value) do
            if _G[name] and pos and pos[1] then
                _G[name]:ClearAllPoints()
                _G[name]:SetPoint(pos[1], pos[2], pos[3], pos[4], pos[5])
            end
        end
    end,

    WeaponBarDirection = function(value, Timers)
        TotemTimers.WeaponTracker.actionBar:SetDirection(value, TotemTimers.ActiveProfile.TrackerArrange)
    end,

    WeaponMenuOnRightclick = function(value, Timers)
        if value then
            XiTimers.timers[8].button:SetAttribute("OpenMenu", "RightButton")
        else
            XiTimers.timers[8].button:SetAttribute("OpenMenu", "mouseover")
        end
        TotemTimers.ProcessSetting("LastWeaponEnchant2")
    end,

    OOCAlpha = function(value, Timers)
        for i = 1, 8 do
            Timers[i].OOCAlpha = value
        end
        XiTimers.invokeOOCFader()
        if TotemTimers_MultiSpell then
            TotemTimers_MultiSpell.OOCAlpha = value
        end
    end,


    TimersOnButtons = function(value, Timers)
        for i = 1, 8 do
            local timer = Timers[i]
            timer.timerOnButton = value
            if timer.timers[1] > 0 then
                timer:ShowTimer()
            end
            if timer.nrOfTimers > 1 and timer.timers[2] > 0 then
                timer:Start(2, timer.timers[2], timer.durations[1])
            end
        end
    end,


    TimeColor = function(value, Timers)
        for i = 1, #Timers do
            Timers[i].button.time:SetTextColor(value.r, value.g, value.b, value.a)
            Timers[i].timeColor = value
            for j = 1, #Timers[i].timerBars do
                Timers[i].timerBars[j].time:SetTextColor(value.r, value.g, value.b, value.a)
            end
        end
    end,

    CheckPlayerRange = function(value, Timers)
        local checkRaid = TotemTimers.ActiveProfile.CheckRaidRange
        if value then
            for i = 1, 4 do
                if Timers[i].active then
                    Timers[i].button:RegisterEvent("UNIT_AURA")
                    if Timers[i].timers[1] > 0 then
                        TotemTimers.TotemEvent(Timers[i].button, "UNIT_AURA", "player")
                    end
                end
            end
        else
            for i = 1, 4 do
                if not checkRaid then
                    Timers[i].button:UnregisterEvent("UNIT_AURA")
                end
                Timers[i].button.playerRange:Hide()
            end
        end
    end,

    CheckRaidRange = function(value, Timers)
        local checkPlayer = TotemTimers.ActiveProfile.CheckPlayerRange
        if value then
            C_ChatInfo.RegisterAddonMessagePrefix("WF_STATUS")
            for i = 1, 4 do
                local timer = Timers[i]
                if Timers[i].active then
                    Timers[i].button:RegisterEvent("UNIT_AURA")
                    Timers[i].button:RegisterEvent("GROUP_ROSTER_UPDATE")
                    if i == AIR_TOTEM_SLOT or i == FIRE_TOTEM_SLOT then
                        Timers[i].button:RegisterEvent("CHAT_MSG_ADDON")
                    end
                    if Timers[i].timers[1] > 0 then
                        for j = 1, 4 do
                            TotemTimers.TotemEvent(Timers[i].button, "UNIT_AURA", "party" .. j)
                        end
                    end
                end
            end
            TotemTimers.UpdateParty()
        else
            for i = 1, 4 do
                if not checkPlayer then
                    Timers[i].button:UnregisterEvent("UNIT_AURA")
                end
                Timers[i].button:UnregisterEvent("GROUP_ROSTER_UPDATE")
                Timers[i].button:UnregisterEvent("CHAT_MSG_ADDON")
                for j = 1, 4 do
                    Timers[i].button.partyRange[j]:Hide()
                end
            end
        end
    end,

    PartyRangePosition = function(value, Timers)
        if not PartyRangePositions[value] then
            return
        end
        for i = 1, 4 do
            local button = Timers[i].button
            button.partyRange[1]:ClearAllPoints();
            button.partyRange[1]:SetPoint(PartyRangePositions[value][1],
                    button,
                    PartyRangePositions[value][2],
                    PartyRangePositions[value][5],
                    PartyRangePositions[value][6]);
            for j = 2, 4 do
                button.partyRange[j]:ClearAllPoints();
                button.partyRange[j]:SetPoint(PartyRangePositions[value][3],
                        button.partyRange[j - 1],
                        PartyRangePositions[value][4],
                        PartyRangePositions[value][5],
                        PartyRangePositions[value][6]);
            end
        end
    end,


    --[[ HideInVehicle =
        function(value, Timers)
            if value then
                for k,v in pairs(Timers) do
                    RegisterStateDriver(v.button,"invehicle","[bonusbar:5]hide;show")
                end
                --RegisterStateDriver(TotemTimers.MB,"invehicle","[bonusbar:5]hide;show")
            else
                for k,v in pairs(Timers) do
                    UnregisterStateDriver(v.button,"invehicle")
                end
                --UnregisterStateDriver(TotemTimers.MB,"invehicle")
            end
        end, --]]

    StopPulse = function(value, Timers)
        for i = 1, 4 do
            Timers[i].StopPulse = value
        end
    end,
    TrackerStopPulse = function(value, Timers)
        for i = 6, 8 do
            Timers[i].StopPulse = value
        end
    end,


    Timer_Clickthrough = function(value, Timers)
        for i = 1, 4 do
            Timers[i].button:EnableMouse(not value)
        end
    end,

    Tracker_Clickthrough = function(value, Timers)
        for i = TRACKER_START, TRACKER_END do
            Timers[i].button:EnableMouse(not value)
        end
    end,

    CooldownAlpha = function(value, Timers)
        for i = 1, #Timers do
            Timers[i].button.cooldown:SetAlpha(value)
        end
        for i = 1, #TTActionBars.bars do
            local bar = TTActionBars.bars[i]
            for j = 1, #bar.buttons do
                bar.buttons[j].cooldown:SetAlpha(value)
            end
        end
    end,

    --[[ CrowdControlSize =
        function(value, Timers)
    		TotemTimers.CrowdControl[1]:SetScale(value/36)
    		TotemTimers.CrowdControl[2]:SetScale(value/36)
        end,
        
    CrowdControlTimePos =
        function(value, Timers)
  			TotemTimers.CrowdControl[1]:SetTimerBarPos(value)
			TotemTimers.CrowdControl[2]:SetTimerBarPos(value)
        end,
        
    CrowdControlClickthrough = 
        function(value, Timers)
            TotemTimers.CrowdControl[1].button:EnableMouse(not value)
			TotemTimers.CrowdControl[2].button:EnableMouse(not value)            
        end,
        
    CrowdControlEnable =
        function(value)
			local Timers = TotemTimers.CrowdControl
            if not value then				
                Timers[1]:Deactivate()
                Timers[2]:Deactivate()
                TotemTimers_CrowdControlFrame:Hide()
            else
                if TotemTimers.ActiveProfile.CrowdControlHex and AvailableSpells[SpellIDs.Hex] then Timers[1]:Activate() else Timers[1]:Deactivate() end
                if TotemTimers.ActiveProfile.CrowdControlBindElemental and AvailableSpells[SpellIDs.BindElemental] then Timers[2]:Activate() else Timers[2]:Deactivate() end
                TotemTimers_CrowdControlFrame:Show() 
            end
        end,
 ]]

}

SettingsFunctions.ReverseBarBindings = SettingsFunctions.BarBindings

if WOW_PROJECT_ID > WOW_PROJECT_CLASSIC then

    SettingsFunctions.ShieldLeftButton = function(value, Timers)
        value = TotemTimers.UpdateSpellRank(value)
        Timers[6].button:SetAttribute("*spell1", value)
        Timers[6].manaCheck = value
    end

    SettingsFunctions.ShieldRightButton = function(value, Timers)
        value = TotemTimers.UpdateSpellRank(value)
        Timers[6].button:SetAttribute("*spell2", value)
    end

    SettingsFunctions.ShieldMiddleButton = function(value, Timers)
        value = TotemTimers.UpdateSpellRank(value)
        Timers[6].button:SetAttribute("*spell3", value)
    end

    SettingsFunctions.EarthShieldTracker = function(value, Timers)
        Timers[7].ActiveWhileHidden = TotemTimers.ActiveProfile.ActivateHiddenTimers and not value
        if (value or TotemTimers.ActiveProfile.ActivateHiddenTimers) and AvailableSpells[SpellIDs.EarthShield] then
            Timers[7]:Activate()
        else
            Timers[7]:Deactivate()
        end
        TotemTimers.OrderTrackers()
    end

    SettingsFunctions.ESChargesOnly = function(value, Timers)
        TotemTimers.SetEarthShieldUpdate()
    end

    SettingsFunctions.EarthShieldTargetName = function(value, Timers)
        if value then
            Timers[7].nameframe:Show()
        else
            Timers[7].nameframe:Hide()
        end
    end

    SettingsFunctions.ESMainTankMenuDirection = function(value, Timers)
        TotemTimers.EarthShieldTracker.actionBar:SetDirection(value, TotemTimers.ActiveProfile.TrackerArrange)
    end

    SettingsFunctions.CooldownSpacing = function(value, Timers)
        for _, t in pairs({ TotemTimers.EnhanceCDs, TotemTimers.LongCooldowns }) do
            for k, v in pairs(t) do
                v:SetSpacing(value)
            end
        end
    end

    SettingsFunctions.EnhanceCDsSize = function(value)
        for _, t in pairs({ TotemTimers.EnhanceCDs, TotemTimers.LongCooldowns }) do
            for _, timer in pairs(t) do
                timer:SetScale(value / 36)
            end
        end
        TotemTimers.FlameShockDuration:SetScale(value / 36)
        if TotemTimers.Maelstrom then
            TotemTimers.Maelstrom:SetScale(value / 36)
        end
        --TotemTimers.LayoutEnhanceCDs()
        --TotemTimers.LayoutLongCooldowns()
    end

    SettingsFunctions.EnhanceCDsTimeHeight = function(value)
        for _, t in pairs({ TotemTimers.EnhanceCDs, TotemTimers.LongCooldowns }) do
            for _, timer in pairs(t) do
                timer:SetTimeHeight(value)
                local font = timer.button.time:GetFont()
                timer.button.time:SetFont(font, value + 5, "OUTLINE")
            end
        end

        --[[local fs = TotemTimers.FlameShockDuration

        fs:SetTimeHeight(value * 1.2)
        local font = fs.timerBars[1].time:GetFont()
        fs.timerBars[1].time:SetFont(font, value, "OUTLINE")
        fs.button:SetSize(value * 1.2, value * 1.2)
        fs.button.icons[1]:SetAllPoints(fs.button)]]

        --TotemTimers.LayoutEnhanceCDs()
        --TotemTimers.LayoutLongCooldowns()
    end

    SettingsFunctions.FlameShockDurationSize = function(value)
        TotemTimers.FlameShockDuration.size = value
    end

    SettingsFunctions.FlameShockDurationStopPulse = function(value)
        TotemTimers.FlameShockDuration.StopPulse = value
    end

    --[[SettingsFunctions.EnhanceCDsMaelstromHeight =
        function(value, Timers)
            TotemTimers.maelstrom:SetHeight(value)
            TotemTimers.maelstrom.background:SetHeight(value)
            TotemTimers.maelstrombutton:SetHeight(value)
            TotemTimers.maelstrom.icon:SetWidth(value)
            TotemTimers.maelstrom.icon:SetHeight(value)
            Timers[21]:SetScale(value/36)
            Timers[21]:SetTimeHeight(value)
            Timers[21].timerBars[1]:SetScale(36/value)
            local font = TotemTimers.maelstrom.text:GetFont()
            local outline
            if Timers[9].timerOnButton then outline = "OUTLINE" end
            TotemTimers.maelstrom.text:SetFont(font, value, outline)
            local font, value = _G["XiTimers_TimerBar17_1Time"]:GetFont()
            _G["XiTimers_TimerBar17_1Time"]:SetFont(font, value, outline)
            TotemTimers.LayoutEnhanceCDs()
        end, --]]

    SettingsFunctions.CDTimersOnButtons = function(value, Timers)
        for _, t in pairs({ TotemTimers.EnhanceCDs, TotemTimers.LongCooldowns }) do
            for _, timer in pairs(t) do
                timer.timerOnButton = value
                if timer.timers[1] > 0 then
                    timer:ShowTimer()
                end
            end
        end
        --TotemTimers.ProcessSetting("EnhanceCDsMaelstromHeight")
    end

    SettingsFunctions.EnhanceCDsOOCAlpha = function(value)
        for _, t in pairs({ TotemTimers.EnhanceCDs, TotemTimers.LongCooldowns }) do
            for _, timer in pairs(t) do
                timer.OOCAlpha = value
            end
        end
        if TotemTimers.Maelstrom then TotemTimers.Maelstrom.OOCAlpha = value end
        TotemTimers.FlameShockDuration.OOCAlpha = value
        XiTimers.invokeOOCFader()
    end

    SettingsFunctions.HideEnhanceCDsOOC = function(value)
        for _, t in pairs({ TotemTimers.EnhanceCDs, TotemTimers.LongCooldowns }) do
            for _, timer in pairs(t) do
                timer.HideOOC = value
                timer.button:SetAttribute("HideOOC", value)
            end
        end
        TotemTimers.FlameShockDuration.HideOOC = value
        TotemTimers.FlameShockDuration.button:SetAttribute("HideOOC", value)

        if TotemTimers.Maelstrom then
            TotemTimers.Maelstrom.HideOOC = value
            TotemTimers.Maelstrom.button:SetAttribute("HideOOC", value)
        end

        TotemTimers.ConfigEnhanceCDs()
    end

    SettingsFunctions.EnhanceCDsStopPulse = function(value, Timers)
        for _, timer in pairs(TotemTimers.EnhanceCDs) do
            timer.StopPulse = value
        end
    end

    SettingsFunctions.LongCooldownsStopPulse = function(value, Timers)
        for _, timer in pairs(TotemTimers.LongCooldowns) do
            timer.StopPulse = value
        end
    end

    SettingsFunctions.EnhanceCDs_Clickthrough = function(value)
        for _, t in pairs({ TotemTimers.EnhanceCDs, TotemTimers.LongCooldowns }) do
            for _, timer in pairs(t) do
                timer.button:EnableMouse(not value)
            end
        end
        if TotemTimers.Maelstrom then
            TotemTimers.Maelstrom.button:EnableMouse(not value)
            TotemTimers.MaelstromButton:EnableMouse(not value)
        end
    end

    SettingsFunctions.EnhanceCDs = function(value)
        if value then
            TotemTimers.ActivateEnhanceCDs()
        else
            TotemTimers.DeactivateEnhanceCDs()
        end
    end

    SettingsFunctions.HideBlizzTimers = function(value)
        if value then
            TotemFrame:UnregisterEvent("PLAYER_TOTEM_UPDATE")
            TotemFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
            TotemFrame:SetScript("OnShow", function()
                TotemFrame:Hide()
            end)
            TotemFrame:Hide()
        else
            TotemFrame:RegisterEvent("PLAYER_TOTEM_UPDATE")
            TotemFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
            TotemFrame:Show()
            TotemFrame:SetScript("OnShow", TotemFrameScript)
        end
    end

    SettingsFunctions.LongCooldowns = function(value, Timers)
        TotemTimers.ActivateLongCooldowns(value)
    end

    SettingsFunctions.LongCooldownsArrange = function(value, Timers)
        TotemTimers.LayoutLongCooldowns()
    end

    if LE_EXPANSION_LEVEL_CURRENT > LE_EXPANSION_BURNING_CRUSADE then
        SettingsFunctions.MultiCast = function(value)
            TotemTimers.MultiSpellActivate()
        end

        SettingsFunctions.MaelstromSize = function(value)
            TotemTimers.Maelstrom.size = value
        end

        SettingsFunctions.MaelstromStopPulse = function(value)
            TotemTimers.Maelstrom.StopPulseOn5 = value
        end

        SettingsFunctions.MaelstromStopPulse = function(value)
            TotemTimers.Maelstrom.StopPulseOn5 = value
        end

        SettingsFunctions.MaelstromNumberOnly = function(value)
            if value then
                TotemTimers.Maelstrom.timerBars[1].time:Show()
            else
                TotemTimers.Maelstrom.timerBars[1].time:Hide()
            end
            TotemTimers.Maelstrom.NumberOnly = value
        end

    end
end