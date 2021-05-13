local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local RegisterKeyChangedCallback = ADDONSELF.RegisterKeyChangedCallback 

RegEvent("BATTLEFIELDS_SHOW", function()
    BattlefieldFrameNameHeader:SetText(BATTLEFIELD_NAME .. " " .. TOTAL .. " " ..  GetNumBattlefields())
end)

RegEvent("ADDON_LOADED", function()
    do
        local toidx = function(txt)
            local n = tonumber(txt)
            if n == 0 then
                return 0
            end
            for i = 1, GetNumBattlefields()  do
                local instanceID = GetBattlefieldInstanceInfo(i)
                if n == instanceID then
                    return i
                end
            end

            return nil
        end

        local t = CreateFrame("EditBox", nil, BattlefieldFrame, "InputBoxTemplate")
        t:SetWidth(50)
        t:SetHeight(25)
        t:SetPoint("BOTTOMRIGHT", BattlefieldFrame, -50, 100)

        RegisterKeyChangedCallback("focus_quickjoin", function(v)
            t:SetAutoFocus(v)
        end)

        t:SetMaxLetters(6)
        t:SetNumeric(true)
        t:SetScript("OnTextChanged", function()
            local n = t:GetText()

            if n == "" then
                SetSelectedBattlefield(0)
                BattlefieldListScrollFrame:SetVerticalScroll(0)
                return
            end

            local mapName = GetBattlegroundInfo()
            local b = mapName .. " " .. n

            GameTooltip:SetOwner(t, "ANCHOR_TOP")

            local idx = toidx(n)
            if idx then
                FauxScrollFrame_SetOffset(BattlefieldListScrollFrame, idx)
                local z,c = BattlefieldListScrollFrame:GetVerticalScrollRange(), GetNumBattlefields()
                BattlefieldListScrollFrame:SetVerticalScroll(z * idx / (c-9))
                SetSelectedBattlefield(idx)
                BattlefieldFrame_Update()
            else
                b = RED_FONT_COLOR:WrapTextInColorCode(b)

                GameTooltip:SetText(L["Cannot find battleground %s"]:format(b))
            end

            GameTooltip:Show()
        end)
        -- t:SetScript("OnEnterPressed", function()
        --     local idx = toidx(t:GetText())
            
        --     if idx then
        --         BattlefieldFrameJoinButton_OnClick()
        --     end
        -- end)
        t:SetScript("OnShow", function() 
            t:SetText("0")
        end)
        t:SetScript("OnEscapePressed", function() HideUIPanel(BattlefieldFrame) end)

        local l = t:CreateFontString(nil, "ARTWORK", "GameFontNormal")
        l:SetPoint("TOPRIGHT", t, "TOPLEFT", -10, -5)
        l:SetJustifyH("RIGHT")
        l:SetText(L["Quick select"])

    end


    do
        local b = CreateFrame("Button", nil, BattlefieldFrame, "GameMenuButtonTemplate")
        b:SetWidth(120)
        b:SetHeight(20)
        b:SetPoint("BOTTOMLEFT", 25, 102)
        b:SetText("BattleInfo " .. OPTIONS)
        b:SetScript("OnClick", function()
            InterfaceOptionsFrame_OpenToCategory(L["BattleInfo"])
            InterfaceOptionsFrame_OpenToCategory(L["BattleInfo"])
        end)
    end
end) 
