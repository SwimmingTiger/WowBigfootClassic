local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent

RegEvent("ADDON_LOADED", function()
    if not BatteInfoSettings then
        BatteInfoSettings = {}
    end
end)

local defs = {}
local function GetConfigOrDefault(key, def)
    defs[key] = def

    local config = BatteInfoSettings

    if config[key] == nil then
        config[key] = def
    end

    return config[key]
end

local changedcb = {}
local function RegisterKeyChangedCallback(key, cb)
    if not changedcb[key] then
        changedcb[key] = {}
    end

    table.insert(changedcb[key] , cb)
end
ADDONSELF.RegisterKeyChangedCallback = RegisterKeyChangedCallback

local function triggerCallback(key, value)
    for _, cb in pairs(changedcb[key] or {}) do
        cb(value)
    end
end

local function SetConfig(key, value)
    BatteInfoSettings[key] = value

    triggerCallback(key, value)
end


local f = CreateFrame("Frame", nil, UIParent)
f.name = L["BattleInfo"]
InterfaceOptions_AddCategory(f)

do
    local t = f:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    t:SetText(L["BattleInfo"])
    t:SetPoint("TOPLEFT", f, 15, -15)
end

do
    local t = f:CreateFontString(nil, "ARTWORK", "GameFontHighlight")
    t:SetText(L["Feedback"] .. "  farmer1992@gmail.com")
    t:SetPoint("TOPLEFT", f, 15, -50)
end

local function createCheckbox(title, key, def)
    local b = CreateFrame("CheckButton", nil, f, "UICheckButtonTemplate")
    b.text = b:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    b.text:SetPoint("LEFT", b, "RIGHT", 0, 1)
    b.text:SetText(title)
    b:SetScript("OnClick", function()
        SetConfig(key, b:GetChecked())
    end)

    RegisterKeyChangedCallback(key, function(v)
        b:SetChecked(v)
    end)

    triggerCallback(key, GetConfigOrDefault(key, def))
    return b
end

RegEvent("PLAYER_LOGIN", function()

    f.default = function()
        for k, v in pairs(defs) do
            SetConfig(k, v)
        end
    end

    f.refresh = function()
    end

    local base = -50
    local nextpos = function(offset)
        if not offset then
            offset = 30
        end
        base = base - offset
        return base
    end

    do
        local b = createCheckbox(L["Show Spirit heal AE Timer"], "show_spirit_heal", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Show Battleground time elapsed"], "show_time_elapsed", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Show team number next to faction crest"], "show_number", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Show Alterac Valley score bar created by BattleInfo"], "show_alterac", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Replace Enter Battle Button with count down"], "replace_enter_battle", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Replace Hide Button with CTRL+Hide=Leave"], "replace_hide_battle", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Auto focus on Quick Join Text box"], "focus_quickjoin", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local s = CreateFrame("Slider", f, f, "OptionsSliderTemplate")
        s:SetOrientation('HORIZONTAL')
        s:SetHeight(14)
        s:SetWidth(160)
        s:SetMinMaxValues(1, 120)
        s:SetValueStep(1)
        s.Low:SetText(SecondsToTime(1))
        s.High:SetText(SecondsToTime(120))

        local l = s:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        l:SetPoint("RIGHT", s, "LEFT", -20, 1)
        l:SetText(L["Auto Leave battle ground when game ends in"])
        
        s:SetPoint("TOPLEFT", f, 40 + l:GetStringWidth(), nextpos(45))

        local key = "auto_leave_bg_time"

        s:SetScript("OnValueChanged", function(self, value)
            s.Text:SetText(SecondsToTime(value))
            SetConfig(key, value)
        end)

        RegisterKeyChangedCallback(key, function(v)
            s:SetValue(v)
        end)
    
        triggerCallback(key, GetConfigOrDefault(key, 3))
    end

    do
        local b = createCheckbox(L["Flash Icon taskbar when battle ground is ready to join"], "flash_icon", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end

    do
        local b = createCheckbox(L["Battle Mini Map unit color"], "map_unit_color", true)
        b:SetPoint("TOPLEFT", f, 15, nextpos())
    end    

    do
        local b = CreateFrame("Button", nil, f, "GameMenuButtonTemplate")
        b:SetWidth(200)
        b:SetHeight(25)
        b:SetPoint("BOTTOMLEFT", 15, 10)
        b:SetText(L["Reset score bar position"])
        b:SetScript("OnClick", function()
            UIWidgetTopCenterContainerFrame:SetUserPlaced(false)
            C_UI.Reload()
        end)
    end

end)
