local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local Database = ADDONSELF.db


local f = CreateFrame("Frame", nil, UIParent)
f.name = L["Raid Ledger"]
InterfaceOptions_AddCategory(f)

do
    local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    t:SetText(L["Raid Ledger"])
    t:SetPoint("TOPLEFT", f, 20, -15)
end

do
    local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    t:SetText(L["Feedback"] .. "  farmer1992@gmail.com")
    t:SetPoint("TOPLEFT", f, 20, -50)
end

RegEvent("ADDON_LOADED", function()
    -- dropbox filter
    do
        local t = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
        t:SetPoint("TOPLEFT", f, 5, -100)

        local tt = t:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        tt:SetPoint("BOTTOMLEFT", t, "TOPLEFT", 20, 0)
        tt:SetText(L["Auto record quality"])

        local onclick = function(self)
            UIDropDownMenu_SetSelectedValue(t, self.value)
            Database:SetConfig("filterlevel", self.value)
        end

        UIDropDownMenu_Initialize(t, function()
            local info = UIDropDownMenu_CreateInfo()
            info.text = ALL
            info.value = -1
            info.func = onclick
            info.classicChecks = true
            UIDropDownMenu_AddButton(info)
            for i = 0, getn(ITEM_QUALITY_COLORS)-4  do
                info.text = _G["ITEM_QUALITY"..i.."_DESC"]
                info.value = i
                info.func = onclick
                info.checked = nil
                UIDropDownMenu_AddButton(info)
            end
        end)

        UIDropDownMenu_SetSelectedValue(t, Database:GetConfigOrDefault("filterlevel", LE_ITEM_QUALITY_RARE))
    end

    -- autoadd filter
    do
        -- TODO const
        local AUTOADDLOOT_TYPE_ALL = 0
        -- local AUTOADDLOOT_TYPE_PARTY = 1
        local AUTOADDLOOT_TYPE_RAID = 1
        local AUTOADDLOOT_TYPE_DISABLE = 2

        local t = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
        t:SetPoint("TOPLEFT", f, 150, -100)

        local tt = t:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        tt:SetPoint("BOTTOMLEFT", t, "TOPLEFT", 20, 0)
        tt:SetText(L["Auto recording loot"])

        local onclick = function(self)
            UIDropDownMenu_SetSelectedValue(t, self.value)
            Database:SetConfig("autoaddloot", self.value)
        end

        UIDropDownMenu_Initialize(t, function()
            do
                local info = UIDropDownMenu_CreateInfo()
                info.text = ALL
                info.value = 0
                info.func = onclick
                UIDropDownMenu_AddButton(info)
            end

            do
                local info = UIDropDownMenu_CreateInfo()
                info.text = L["In Raid Only"]
                info.value = 1
                info.func = onclick
                UIDropDownMenu_AddButton(info)
            end

            do
                local info = UIDropDownMenu_CreateInfo()
                info.text = NONE
                info.value = 2
                info.func = onclick
                UIDropDownMenu_AddButton(info)
            end
        end)

        UIDropDownMenu_SetSelectedValue(t, Database:GetConfigOrDefault("autoaddloot", AUTOADDLOOT_TYPE_RAID))
    end

    local editDebitTemplate
    do
        local t = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
        t:SetPoint("TOPLEFT", f, 25, -180)
        t:SetWidth(550)
        t:SetHeight(200)
        t:SetBackdrop({ 
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
            edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
            tile = true,
            tileEdge = true,
            tileSize = 16,
            edgeSize = 16,
            insets = { left = 2, right = 2, top = 2, bottom = 2 },    
        })
        t:SetBackdropColor(0, 0, 0);
    

        local edit = CreateFrame("EditBox", nil, t)
        edit.cursorOffset = 0
        edit:SetTextInsets(20, 20, 20, 20)
        edit:SetWidth(500)
        edit:SetHeight(150)
        edit:SetAutoFocus(false)
        edit:EnableMouse(true)
        edit:SetMaxLetters(99999999)
        edit:SetMultiLine(true)
        edit:SetFontObject(GameTooltipText)
        edit:SetScript("OnTextChanged", function(self)
            ScrollingEdit_OnTextChanged(self, t)
        end)
        edit:SetScript("OnCursorChanged", ScrollingEdit_OnCursorChanged)
        edit:SetScript("OnEscapePressed", edit.ClearFocus)

        t:SetScrollChild(edit)

        editDebitTemplate = edit
    end    

    do
        local t = CreateFrame("Frame", nil, f, "UIDropDownMenuTemplate")
        t:SetPoint("TOPLEFT", f, 5, -150)

        local tt = t:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        tt:SetPoint("BOTTOMLEFT", t, "TOPLEFT", 20, 0)
        tt:SetText(L["Debit Template"])

        local templates = Database:GetConfigOrDefault("debittemplates", {})

        ADDONSELF.GetCurrentDebitTemplate = function()
            local idx = UIDropDownMenu_GetSelectedValue(t) or "NOTEXISTS"
            local s = templates[idx] and templates[idx].value or ""
            local output = {}

            s = string.gsub(s,"(#.[^\n]*\n)", "")

            for _, line in ipairs({strsplit("\n", s)}) do
                line = strtrim(line)
                if line ~= nil and line ~= "" then
                    local x = {strsplit(" ", line)}
                    if #x >= 3 then
                        (function()
                            local costtype = x[#x]
                            table.remove(x, #x)
                            local cost = tonumber(x[#x])
                            table.remove(x, #x)
                            local reason = strtrim(table.concat(x, " "))

                            if costtype == "G" then
                                costtype = "GOLD"
                            elseif costtype == "%" then
                                costtype = "PROFIT_PERCENT"
                            elseif costtype == "*" then
                                costtype = "MUL_AVG"
                            else
                                return
                            end

                            if not cost then
                                return
                            end

                            if reason == "" then
                                return
                            end

                            table.insert( output, 1, {
                                costtype = costtype,
                                cost = cost,
                                reason = reason,
                            } )
                        end)()
                    end

                end

            end

            return output
        end

        local onclick = function(self)
            local idx = self.value
            UIDropDownMenu_SetSelectedValue(t, idx)
            Database:SetConfig("debittemplateidx", idx)

            local n = templates[idx] and templates[idx].name or ""
            UIDropDownMenu_SetText(t, n)

            local v = templates[idx] and templates[idx].value or ""
            editDebitTemplate:SetText(v)
        end

        local create = function(name)
            local template = {
                name = name
            }
            table.insert(templates, template)

            local info = UIDropDownMenu_CreateInfo()
            info.text = template.name
            info.value = #templates
            info.func = onclick
            UIDropDownMenu_AddButton(info)
        end

        local save = function(force)
            local c = UIDropDownMenu_GetSelectedValue(t)
            local v = editDebitTemplate:GetText()
            if not force and v == "" then
                return
            end
            if (not c) or (not templates[c]) then
                create(date())
                UIDropDownMenu_SetSelectedValue(t, #templates)
                c = #templates
            end

            templates[c].value = v
        end
        editDebitTemplate:SetScript("OnTextChanged", function() save(false) end)

        UIDropDownMenu_Initialize(t, function()
            for i, template in pairs(templates) do
                -- print(template.name)
                local info = UIDropDownMenu_CreateInfo()
                info.text = template.name
                info.value = i
                info.func = onclick
                UIDropDownMenu_AddButton(info)
            end
        end)

        do
            local idx = Database:GetConfigOrDefault("debittemplateidx", nil)
            UIDropDownMenu_SetSelectedValue(t, idx)    
            onclick({value = idx})
        end

        local popctx = {}

        StaticPopupDialogs["RAIDLEDGER_DEBIT_TEMPLATE_NAME"].OnShow = function(self)
            local c = popctx.current

            if c and templates[c] then
                self.editBox:SetText(templates[c].name or "")
            end
        end


        StaticPopupDialogs["RAIDLEDGER_DEBIT_TEMPLATE_NAME"].OnAccept = function(self)
            local c = popctx.current

            -- if c then rename
            if c and templates[c] then
                local n = self.editBox:GetText()
                if n ~= "" then
                    templates[c].name = n
                    UIDropDownMenu_SetText(t, n)
                end
                return
            end

            create(self.editBox:GetText())
            onclick({value = #templates})
        end

        do
            local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
            b:SetWidth(70)
            b:SetHeight(25)
            b:SetPoint("TOPLEFT", t, 160, 0)
            b:SetText(NEW)
            b:SetScript("OnClick", function()
                popctx.current = nil
                StaticPopup_Show("RAIDLEDGER_DEBIT_TEMPLATE_NAME")
            end)
        end

        do
            local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
            b:SetWidth(70)
            b:SetHeight(25)
            b:SetPoint("TOPLEFT", t, 235, 0)
            b:SetText(SAVE)
            b:SetScript("OnClick", function() save(true) end)
        end

        do
            local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
            b:SetWidth(70)
            b:SetHeight(25)
            b:SetPoint("TOPLEFT", t, 310, 0)
            b:SetText(DELETE)
            b:SetScript("OnClick", function()
                local c = UIDropDownMenu_GetSelectedValue(t)

                if c then
                    table.remove( templates, c)
                end

                if #templates == 0 then
                    UIDropDownMenu_SetSelectedValue(t, nil)
                    UIDropDownMenu_SetText(t, "")
                    editDebitTemplate:SetText("")
                else
                    onclick({value = #templates})
                end
            end)
        end
       
        do
            local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
            b:SetWidth(70)
            b:SetHeight(25)
            b:SetPoint("TOPLEFT", t, 385, 0)
            b:SetText(L["Rename"])
            b:SetScript("OnClick", function()
                local c = UIDropDownMenu_GetSelectedValue(t)

                if c and templates[c] then
                    popctx.current = c
                    StaticPopup_Show("RAIDLEDGER_DEBIT_TEMPLATE_NAME")
                end
            end)
        end

        do
            local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
            b:SetWidth(125)
            b:SetHeight(25)
            b:SetPoint("TOPLEFT", t, 460, 0)
            b:SetText(L["Import from ledger"])
            b:SetScript("OnClick", function()
                local items = Database:GetCurrentLedger()["items"]
                local all = {}
                local s = ""

                for _, item in pairs(items or {}) do
                    local c = item["cost"] or 0
                    local t = item["type"]
                    local ct = item["costtype"] or "GOLD"
                    local d = item["detail"]["displayname"] or ""

                    if t == "DEBIT" then
                        local x
                        if ct == "GOLD" then
                            x = d .. " " .. c .. " G"
                        elseif ct == "PROFIT_PERCENT" then
                            x = d .. " " .. c .. " %"
                        elseif ct == "MUL_AVG" then
                            x = d .. " " .. c .. " *"
                        end
                        s = x .. "\r\n" .. s
                        all[x] = true
                    end
                end

                editDebitTemplate:SetText(strtrim(editDebitTemplate:GetText() .. "\r\n" .. s))
                save()
            end)
        end

          
    end

end)



StaticPopupDialogs["RAIDLEDGER_DEBIT_TEMPLATE_NAME"] = {
    text = L["Name of Debit template"],
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = true,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    multiple = 0,
    OnAccept = function()
    end,
    OnShow = function()
    end,
}
