local AddonName, SAO = ...

-- Add a checkbox for an overlay
-- talentID is the spell ID of the associated talent
-- auraID is the spell ID that triggers the overlay; it must match a spell ID of an aura registered with RegisterAura
-- count is the number of stacks expected for this option; use 0 is aura has no stacks or for "any stacks"
-- talentSubText is a string describing the specificity of this option
-- variants optional variant object that tells which are sub-options and how to use them
-- testStacks if defined, forces the number of stacks for the test function
-- testAuraID optional spell ID used to test the aura in lieu of auraID
function SAO.AddOverlayOption(self, talentID, auraID, count, talentSubText, variants, testStacks, testAuraID)
    local className = self.CurrentClass.Intrinsics[1];
    local classFile = self.CurrentClass.Intrinsics[2];

    local applyTextFunc = function(self)
        local enabled = self:IsEnabled();

        -- Class text
        local classColor;
        if (enabled) then
            classColor = select(4,GetClassColor(classFile));
        else
            local dimmedClassColor = CreateColor(0.5*RAID_CLASS_COLORS[classFile].r, 0.5*RAID_CLASS_COLORS[classFile].g, 0.5*RAID_CLASS_COLORS[classFile].b);
            classColor = dimmedClassColor:GenerateHexColor();
        end
        local text = WrapTextInColorCode(className, classColor);

        -- Talent text
        local spellName, _, spellIcon = GetSpellInfo(talentID);
        text = text.." |T"..spellIcon..":0|t "..spellName;
        if (count and count > 0) then
            text = text .. " ("..string.format(STACKS, count)..")";
        end
        if (talentSubText) then
            text = text.." ("..talentSubText..")";
        end

        -- Set final text to checkbox
        self.Text:SetText(text);

        if (enabled) then
            self.Text:SetTextColor(1, 1, 1);
        else
            self.Text:SetTextColor(0.5, 0.5, 0.5);
        end
    end

    local testFunc = function(start, cb, sb)
        local auras = self.RegisteredAurasBySpellID[testAuraID or auraID];
        if (not auras) then
            return
        end

        SpellActivationOverlayFrame_SetForceAlpha2(start);

        local fakeOffset = 42000000;
        if (start) then
            local stacks = testStacks or count or 0;
            if (not auras[stacks]) then
                return;
            end

            for _, aura in ipairs(auras[stacks]) do
                if (type(variants) == 'table' and type(variants.transformer) == 'function') then
                    self:ActivateOverlay(stacks, fakeOffset+(testAuraID or auraID), variants.transformer(cb, sb, select(4,unpack(aura))));
                else
                    self:ActivateOverlay(stacks, fakeOffset+(testAuraID or auraID), select(4,unpack(aura)));
                end
            end
        else
            self:DeactivateOverlay(fakeOffset+(testAuraID or auraID));
        end
    end

    self:AddOption("alert", auraID, count or 0, type(variants) == 'table' and variants.values, applyTextFunc, testFunc, { frame = SpellActivationOverlayOptionsPanelSpellAlertLabel, xOffset = 4, yOffset = -4 });
end

function SAO.AddOverlayLink(self, srcOption, dstOption)
    return self:AddOptionLink("alert", srcOption, dstOption);
end

function SAO.GetOverlayOptions(self, auraID)
    return self:GetOptions("alert", auraID);
end
