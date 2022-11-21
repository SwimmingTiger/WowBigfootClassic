local AddonName, SAO = ...

function SAO.AddGlowingOption(self, talentID, spellID, glowID, talentSubText, spellSubText)
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
        local spellName, spellIcon;
        if (talentID) then
            spellName, _, spellIcon = GetSpellInfo(talentID);
            text = text.." |T"..spellIcon..":0|t "..spellName;
            if (talentSubText) then
                text = text.." ("..talentSubText..")";
            end
            text = text.." +"
        end

        -- Spell text
        spellName, _, spellIcon = GetSpellInfo(glowID);
        text = text.." |T"..spellIcon..":0|t "..spellName;
        if (spellSubText) then
            text = text.." ("..spellSubText..")";
        end

        -- Set final text to checkbox
        self.Text:SetText(text);

        if (enabled) then
            self.Text:SetTextColor(1, 1, 1);
        else
            self.Text:SetTextColor(0.5, 0.5, 0.5);
        end
    end

    local testFunc = function(start)
        local fakeOffset = 42000000;
        if (start) then
            self:AddGlow(fakeOffset+spellID, { GetSpellInfo(glowID) });
        else
            self:RemoveGlow(fakeOffset+spellID);
        end
    end

    self:AddOption("glow", spellID, glowID, nil, applyTextFunc, testFunc, { frame = SpellActivationOverlayOptionsPanelGlowingButtons, xOffset = 16, yOffset = 2 });
end

function SAO.AddGlowingLink(self, srcOption, dstOption)
    return self:AddOptionLink("glow", srcOption, dstOption);
end

function SAO.GetGlowingOptions(self, spellID)
    return self:GetOptions("glow", spellID);
end
