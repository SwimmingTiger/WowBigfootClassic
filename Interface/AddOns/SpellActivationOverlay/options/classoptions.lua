local AddonName, SAO = ...

local function createOptionFor(classFile, optionType, auraID, id)
    local default = true;
    if (SAO.defaults.classes[classFile] and SAO.defaults.classes[classFile][optionType] and SAO.defaults.classes[classFile][optionType][auraID]) then
        default = SAO.defaults.classes[classFile][optionType][auraID][id];
    end
    if (not SpellActivationOverlayDB.classes) then
        SpellActivationOverlayDB.classes = { [classFile] = { [optionType] = { [auraID] = { [id] = default } } } };
    elseif (not SpellActivationOverlayDB.classes[classFile]) then
        SpellActivationOverlayDB.classes[classFile] = { [optionType] = { [auraID] = { [id] = default } } };
    elseif (not SpellActivationOverlayDB.classes[classFile][optionType]) then
        SpellActivationOverlayDB.classes[classFile][optionType] = { [auraID] = { [id] = default } };
    elseif (not SpellActivationOverlayDB.classes[classFile][optionType][auraID]) then
        SpellActivationOverlayDB.classes[classFile][optionType][auraID] = { [id] = default };
    elseif (type (SpellActivationOverlayDB.classes[classFile][optionType][auraID][id]) == "nil") then
        SpellActivationOverlayDB.classes[classFile][optionType][auraID][id] = default;
    end
end

local function setSelectBoxEnabled(sb, enabled)
    if (sb) then
        local currentText = UIDropDownMenu_GetText(sb);
        if (enabled) then
            UIDropDownMenu_EnableDropDown(sb);
            if (currentText and currentText ~= "") then
                UIDropDownMenu_SetText(sb, currentText:gsub(":127:127:127|t",":255:255:255|t"));
            end
        else
            UIDropDownMenu_DisableDropDown(sb);
            if (currentText and currentText ~= "") then
                UIDropDownMenu_SetText(sb, currentText:gsub(":255:255:255|t",":127:127:127|t"));
            end
        end
    end
end

local function setSelectBoxValue(sb, subValues, value)
    if (sb) then
        if (value) then
            sb.currentValue = value;
            for _, obj in ipairs(subValues) do
                if (obj.value == value) then
                    UIDropDownMenu_SetText(sb, obj.text);
                    break;
                end
            end
        else
            local currentText = UIDropDownMenu_GetText(sb);
            if not currentText or currentText == "" then
                -- Find any value to put as default
                sb.currentValue = subValues[1].value;
                UIDropDownMenu_SetText(sb, subValues[1].text);
            end
        end
    end
end

local function createSelectBox(self, cb, classFile, optionType, auraID, id, subValues)
    local sb = CreateFrame("Frame", "OptionSubValues_"..optionType.."_"..auraID.."_"..id, SpellActivationOverlayOptionsPanel, "UIDropDownMenuTemplate");

    UIDropDownMenu_Initialize(sb, function()
        local info = UIDropDownMenu_CreateInfo();
        info.func = function(self, arg1)
            setSelectBoxValue(sb, subValues, arg1);
            SpellActivationOverlayDB.classes[classFile][optionType][auraID][id] = arg1;
            CloseDropDownMenus();
        end
        for _, obj in ipairs(subValues) do
            info.text = obj.text;
            info.arg1 = obj.value;
            info.checked = SpellActivationOverlayDB.classes[classFile][optionType][auraID][id] == obj.value;
            UIDropDownMenu_AddButton(info);
        end
    end);

    -- Compute an appropriate width; it may not be perfect but should help having something neither too wide nor too narrow
    local widestText = 4;
    for _, obj in ipairs(subValues) do
        if (#obj.text > widestText) then
            widestText = obj.width;
        end
    end
    UIDropDownMenu_SetWidth(sb, widestText*8+12);

    -- Initialize the value and text from config
    setSelectBoxValue(sb, subValues, SpellActivationOverlayDB.classes[classFile][optionType][auraID][id]);

    sb:SetPoint("TOP", cb, "TOP", 0, 4);
    sb:SetPoint("LEFT", cb.Text, "RIGHT", -12, 0);

    return sb;
end

function SAO.AddOption(self, optionType, auraID, id, subValues, applyTextFunc, testFunc, firstAnchor)
    local classFile = self.CurrentClass.Intrinsics[2];
    local cb = CreateFrame("CheckButton", nil, SpellActivationOverlayOptionsPanel, "InterfaceOptionsCheckButtonTemplate");

    local sb = nil;
    if (type(subValues) == 'table') then
        sb = createSelectBox(self, cb, classFile, optionType, auraID, id, subValues);
    end

    cb.ApplyText = applyTextFunc;

    cb.ApplyParentEnabling = function()
        -- Enable/disable the checkbox if the parent (i.e. main option) is enabled or not
        if (SpellActivationOverlayDB[optionType].enabled) then
            cb:SetEnabled(true);
            cb:ApplyText();
            setSelectBoxEnabled(sb, true);
        else
            cb:SetEnabled(false);
            cb:ApplyText();
            setSelectBoxEnabled(sb, false);
        end
    end

    cb.ApplyValue = function()
        createOptionFor(classFile, optionType, auraID, id); -- Safety call, in case the value is not defined in defaults
        local value = SpellActivationOverlayDB.classes[classFile][optionType][auraID][id];
        cb:SetChecked(not not value);
        setSelectBoxEnabled(sb, not not value);
        setSelectBoxValue(sb, subValues, value);
    end

    -- Init
    cb:ApplyParentEnabling();
    cb:ApplyValue();

    cb:SetScript("PostClick", function()
        local checked = cb:GetChecked();
        if (sb) then
            SpellActivationOverlayDB.classes[classFile][optionType][auraID][id] = checked and sb.currentValue;
            setSelectBoxEnabled(sb, checked);
        else
            SpellActivationOverlayDB.classes[classFile][optionType][auraID][id] = checked;
        end
    end);

    cb:SetSize(20, 20);

    if (testFunc) then
        cb.hoverFrame = CreateFrame("Frame", nil, cb)
        cb.hoverFrame:SetAllPoints();
        cb.hoverFrame:SetPoint("RIGHT", cb.Text, "RIGHT");
        cb.hoverFrame:SetScript("OnEnter", function() testFunc(true, cb, sb) end);
        cb.hoverFrame:SetScript("OnLeave", function() testFunc(false) end);
        -- Setting scripts for OnEnter/OnLeave automatically enables the mouse
        -- Enabling the mouse catches motion (which we want) but also catches clicks (which we don't want)
        cb.hoverFrame:SetMouseClickEnabled(false); -- Let clicks go through hoverFrame to reach cb
    end

    if (type(SpellActivationOverlayOptionsPanel.additionalCheckboxes[optionType]) == "nil") then
        -- The first additional checkbox is anchored an initial widget
        cb:SetPoint("TOPLEFT", firstAnchor.frame, "BOTTOMLEFT", firstAnchor.xOffset or 0, firstAnchor.yOffset or 0);
        SpellActivationOverlayOptionsPanel.additionalCheckboxes[optionType] = { cb };
    else
        -- Each subsequent checkbox is anchored to the previous one
        local lastCheckBox = SpellActivationOverlayOptionsPanel.additionalCheckboxes[optionType][#SpellActivationOverlayOptionsPanel.additionalCheckboxes[optionType]];
        cb:SetPoint("TOPLEFT", lastCheckBox, "BOTTOMLEFT", 0, 0);
        table.insert(SpellActivationOverlayOptionsPanel.additionalCheckboxes[optionType], cb);
    end

    return cb;
end

function SAO.AddOptionLink(self, optionType, srcOption, dstOption)
    if (not self.OptionLinks) then
        self.OptionLinks = { [optionType] = { [dstOption] = srcOption } };
    elseif (not self.OptionLinks[optionType]) then
        self.OptionLinks[optionType] = { [dstOption] = srcOption };
    else
        self.OptionLinks[optionType][dstOption] = srcOption;
    end
end

function SAO.GetOptions(self, optionType, auraID)
    if (self.CurrentClass) then
        local classFile = self.CurrentClass.Intrinsics[2];
        local classOptions = SpellActivationOverlayDB and SpellActivationOverlayDB.classes and SpellActivationOverlayDB.classes[classFile];
        if (classOptions and classOptions[optionType]) then
            if (self.OptionLinks and self.OptionLinks[optionType] and self.OptionLinks[optionType][auraID]) then
                return classOptions[optionType][self.OptionLinks[optionType][auraID]];
            else
                return classOptions[optionType][auraID];
            end
        end
    end
end
