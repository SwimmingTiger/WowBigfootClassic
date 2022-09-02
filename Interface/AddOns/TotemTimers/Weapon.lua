if select(2, UnitClass("player")) ~= "SHAMAN" then
    return
end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers")

local Timers = XiTimers.timers

local SpellNames = TotemTimers.SpellNames
local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures
local AvailableSpells = TotemTimers.AvailableSpells
local AvailableTalents = TotemTimers.AvailableTalents
local NameToSpellID = TotemTimers.NameToSpellID

local weapon = nil

function TotemTimers.CreateWeaponTracker()
    weapon = XiTimers:new(2)

    weapon.button.icons[1]:SetTexture(SpellTextures[SpellIDs.RockbiterWeapon])
    if TotemTimers.ActiveProfile.LastWeaponEnchant == 5 or TotemTimers.ActiveProfile.LastWeaponEnchant == 6 then
        weapon.button.icons[1]:SetTexture(SpellTextures[SpellIDs.WindfuryWeapon])
        weapon.button.icons[2]:SetTexture(SpellTextures[TotemTimers.ActiveProfile.LastWeaponEnchant == 5 and SpellIDs.FlametongueWeapon or SpellIDs.FrostbrandWeapon])
    else
        if TotemTimers.ActiveProfile.LastWeaponEnchant then
            local enchantID = tonumber(TotemTimers.ActiveProfile.LastWeaponEnchant)
            if not enchantID then
                enchantID = NameToSpellID[TotemTimers.StripRank(TotemTimers.ActiveProfile.LastWeaponEnchant)]
            end
            local texture = GetSpellTexture(enchantID)
            weapon.button.icons[1]:SetTexture(texture)
            weapon.button.icons[2]:SetTexture(texture)
        end
    end

    weapon.button.anchorframe = TotemTimers_TrackerFrame
    weapon.timeStyle = "blizz"
    weapon.button:SetAttribute("*type*", "spell")
    weapon.button:SetAttribute("ctrl-spell1", ATTRIBUTE_NOOP)
    weapon.Update = TotemTimers.WeaponUpdate
    weapon.button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    weapon.timerBars[1]:SetMinMaxValues(0, 1800)
    weapon.flashall = true
    weapon.Activate = function(self)
        XiTimers.Activate(self)
        if not TotemTimers.ActiveProfile.WeaponTracker then
            self.button:Hide()
        end
    end
    TotemTimers.SetNumWeaponTimers()

    weapon.actionBar = TTActionBars:new(7, weapon.button, nil, TotemTimers_TrackerFrame, "weapontimer")

    weapon.button.tooltip = TotemTimers.Tooltips.WeaponTimer:new(weapon.button)

    weapon.button.SaveLastEnchant = function(self, name)
        if name == "spell1" then
            TotemTimers.ActiveProfile.LastWeaponEnchant = self:GetAttribute("spell1")
        elseif name == "spell2" or name == "spell3" then
            TotemTimers.ActiveProfile.LastWeaponEnchant2 = self:GetAttribute("spell2") or elf:GetAttribute("spell3")
        elseif name == "doublespell2" then
            local ds2 = self:GetAttribute("doublespell2")
            if ds2 then
                if ds2 == SpellNames[SpellIDs.FlametongueWeapon] then
                    TotemTimers.ActiveProfile.LastWeaponEnchant = 5
                elseif ds2 == SpellNames[SpellIDs.FrostbrandWeapon] then
                    TotemTimers.ActiveProfile.LastWeaponEnchant = 6
                end
            end
        end
    end

    weapon.button:SetAttribute("_onattributechanged", [[ if name == "spell1" or name == "doublespell1" or name == "doublespell2" or name == "spell2" or name == "spell3" then
                                                             control:CallMethod("SaveLastEnchant", name)
                                                         end]])

    weapon.button:WrapScript(weapon.button, "PostClick", [[ if button == "LeftButton" then
                                                                 local ds1 = self:GetAttribute("doublespell1")
                                                                 if ds1 then
                                                                     if IsControlKeyDown() or self:GetAttribute("ds") ~= 1 then
                                                                         self:SetAttribute("macrotext", "/cast "..ds1)
 																		self:SetAttribute("ds",1)
                                                                     else
                                                                         self:SetAttribute("macrotext", "/cast "..self:GetAttribute("doublespell2"))
 																		self:SetAttribute("ds",2)
                                                                     end
                                                                 end
                                                            end]])

    weapon.button:SetAttribute("ctrl-type1", "cancelaura")
    weapon.button:SetAttribute("ctrl-target-slot1", GetInventorySlotInfo("MainHandSlot"))
    weapon.button:SetAttribute("ctrl-type2", "cancelaura")
    weapon.button:SetAttribute("ctrl-target-slot2", GetInventorySlotInfo("SecondaryHandSlot"))
    weapon.button:SetScript("OnDragStop", function(self)
        XiTimers.StopMoving(self)
        if not InCombatLockdown() then
            --self:SetAttribute("hide", true)
        end
        TotemTimers.ProcessSetting("WeaponBarDirection")
    end)
    weapon.nobars = true
    weapon.Stop = function(self, timer)
        XiTimers.Stop(self, timer)
        self.button.bar:Show()
    end
    weapon.button.bar:Show()
    weapon.button.bar:SetStatusBarColor(0.7, 1, 0.7, 0.7)

    weapon.Start = function(self, ...)
        XiTimers.Start(self, ...)
        self.running = 1
    end
    weapon.Stop = function(self, ...)
        XiTimers.Stop(self, ...)
        self.running = 1
    end
    weapon.running = 1

    TotemTimers.WeaponTracker = weapon
end

table.insert(TotemTimers.Modules, TotemTimers.CreateWeaponTracker)


function TotemTimers.SetWeaponTrackerSpells()
    weapon.actionBar:ResetSpells()
    if AvailableSpells[SpellIDs.WindfuryWeapon] then
        weapon.actionBar:AddSpell(SpellNames[SpellIDs.WindfuryWeapon])
    end
    if AvailableSpells[SpellIDs.RockbiterWeapon] then
        weapon.actionBar:AddSpell(SpellNames[SpellIDs.RockbiterWeapon])
    end
    if AvailableSpells[SpellIDs.FlametongueWeapon] then
        weapon.actionBar:AddSpell(SpellNames[SpellIDs.FlametongueWeapon])
    end
    if AvailableSpells[SpellIDs.FrostbrandWeapon] then
        weapon.actionBar:AddSpell(SpellNames[SpellIDs.FrostbrandWeapon])
    end

    if AvailableTalents.DualWield then
        if AvailableSpells[SpellIDs.WindfuryWeapon] and AvailableSpells[SpellIDs.FlametongueWeapon] then
            weapon.actionBar:AddDoubleSpell(SpellIDs.WindfuryWeapon, SpellIDs.FlametongueWeapon)
        end
        if AvailableSpells[SpellIDs.WindfuryWeapon] and AvailableSpells[SpellIDs.FrostbrandWeapon] then
            weapon.actionBar:AddDoubleSpell(SpellIDs.WindfuryWeapon, SpellIDs.FrostbrandWeapon)
        end
    end
end

local mainMsg = ""
local offMsg = ""

local WeaponEnchants = TotemTimers.WeaponEnchants
local GetWeaponEnchantInfo = GetWeaponEnchantInfo

local handsToCheck = 1

function TotemTimers.WeaponUpdate(self, elapsed)
    local enchant, expiration, _, mainID, offenchant, offExpiration, _, offID = GetWeaponEnchantInfo()
    local enchants = { { enchant, expiration, mainID }, { offenchant, offExpiration, offID } }

    for hand = 1,handsToCheck do
        local checkEnchant = enchants[hand]
        if checkEnchant[1] then
            if checkEnchant[2] / 1000 > self.timers[hand] then
                local texture, spell
                self:Start(hand, checkEnchant[2] / 1000, 1800)
                if WeaponEnchants[checkEnchant[3]] then
                    texture = SpellTextures[WeaponEnchants[checkEnchant[3]]]
                    spell = SpellNames[WeaponEnchants[checkEnchant[3]]]
                else
                    spell, _, _, _, _, _, _, _, _, texture = GetItemInfo(GetInventoryItemID("player", 15 + hand))
                end

                self["enchant"..hand] = spell
                self.button.icons[hand]:SetTexture(texture)
                self.warningIcons[hand] = texture
                self.warningSpells[hand] = spell
                self.expirationMsgs[hand] = "Weapon"
                self.earlyExpirationMsgs[hand] = "Weapon"
            end
            if checkEnchant[2] == 0 then
                self:Stop(hand)
            else
                self.timers[hand] = checkEnchant[2] / 1000
            end
        elseif self.timers[hand] > 0 then
            self:Stop(hand)
        end
    end
    XiTimers.Update(self, 0)
end

function TotemTimers.SetNumWeaponTimers()
    handsToCheck = AvailableTalents.DualWield and 2 or 1
    TotemTimers.SetDoubleTexture(weapon.button,  AvailableTalents.DualWield, true)
    weapon.numtimers = AvailableTalents.DualWield and 2 or 1
    weapon:SetTimerBarPos(weapon.timerBarPos)
    if not AvailableTalents.DualWield then weapon:Stop(2) end
end

table.insert(TotemTimers.SpellUpdaters, TotemTimers.SetNumWeaponTimers)
