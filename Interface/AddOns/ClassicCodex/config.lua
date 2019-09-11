CodexConfig = {}
CodexColors = {}

DefaultCodexConfig = {
    ["trackingMethod"] = 1, -- 1: All Quests; 2: Tracked Quests; 3: Manual; 4: Hide
    ["autoAccept"] = false, -- Auto-accept quests
    ["autoTurnin"] = false, -- Auto-turnin quests
    ["nameplateIcon"] = false, -- Show quest icon above nameplates
    ["allQuestGivers"] = true, -- Show available quest givers
    ["currentQuestGivers"] = true, -- Show current quest giver nodes
    ["showLowLevel"] = false, -- Show low level quest giver nodes
    ["showHighLevel"] = true, -- Show level+3 quest giver nodes
    ["showFestival"] = false, -- Show event quest giver nodes
    ["colorBySpawn"] = true,
    ["questMarkerSize"] = 15,
    ["spawnMarkerSize"] = 15,
}

function textFactory(parent, value, size)
    local text = parent:CreateFontString(nil, "ARTWORK")
    text:SetFont("Fonts/ARKai_T.ttf", size)
    text:SetJustifyV("CENTER")
    text:SetJustifyH("CENTER")
    text:SetText(value)
    return text
end

function checkboxFactory(parent, name, description, onClick)
    local checkbox = CreateFrame("CheckButton", name, parent, "ChatConfigCheckButtonTemplate")
    getglobal(checkbox:GetName() .. "Text"):SetText(name)
    checkbox.tooltip = description
    checkbox:SetScript("OnClick", function(self)
        onClick(self)
    end)
    checkbox:SetScale(1.1)
    return checkbox
end

function editBoxFactory(parent, name, width, height, onEnter)
    local editBox = CreateFrame("EditBox", nil, parent)
    editBox.title_text = textFactory(editBox, name, 12)
    editBox.title_text:SetPoint("TOP", 0, 12)
    editBox:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        tile = true,
        tileSize = 26,
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4}
    })
    editBox:SetBackdropColor(0,0,0,1)
    editBox:SetSize(width, height)
    editBox:SetMultiLine(false)
    editBox:SetAutoFocus(false)
    editBox:SetMaxLetters(6)
    editBox:SetJustifyH("CENTER")
	editBox:SetJustifyV("CENTER")
    editBox:SetFontObject(GameFontNormal)
    editBox:SetScript("OnEnterPressed", function(self)
        onEnter(self)
        self:ClearFocus()
    end)
    editBox:SetScript("OnEscapePressed", function(self)
        self:ClearFocus()
    end)
    return editBox
end

function sliderFactory(parent, name, title, minVal, maxVal, valStep, func)
    local slider = CreateFrame("Slider", name, parent, "OptionsSliderTemplate")
    local editBox = CreateFrame("EditBox", "$parentEditBox", slider, "InputBoxTemplate")
    slider:SetMinMaxValues(minVal, maxVal)
    slider:SetValueStep(valStep)
    slider.text = _G[name .. "Text"]
    slider.text:SetText(title)
    slider.textLow = _G[name .. "Low"]
    slider.textHigh = _G[name .. "High"]
    slider.textLow:SetText(floor(minVal))
    slider.textHigh:SetText(floor(maxVal))
    slider.textLow:SetTextColor(0.8,0.8,0.8)
    slider.textHigh:SetTextColor(0.8,0.8,0.8)
    slider:SetObeyStepOnDrag(true)
    editBox:SetSize(45,30)
    editBox:ClearAllPoints()
    editBox:SetPoint("LEFT", slider, "RIGHT", 15, 0)
    editBox:SetText(slider:GetValue())
    editBox:SetAutoFocus(false)
    slider:SetScript("OnValueChanged", function(self)
        editBox:SetText(tostring(self:GetValue()))
        func(self)
    end)
    editBox:SetScript("OnTextChanged", function(self)
        local val = self:GetText()
        if tonumber(val) then
            self:GetParent():SetValue(val)
        end
    end)
    editBox:SetScript("OnEnterPressed", function(self)
        local val = self:GetText()
        if tonumber(val) then
            self:GetParent():SetValue(val)
            self:ClearFocus()
        end
    end)
    slider.editBox = editBox
    return slider
end


function colorPickerFactory(parent, name, r, g, b, text, onClick)
    local colorPicker = CreateFrame("Button", name, parent)
    colorPicker:SetSize(15, 15)
    colorPicker.normal = colorPicker:CreateTexture(nil, "BACKGROUND")
    colorPicker.normal:SetColorTexture(1, 1, 1, 1)
    colorPicker.normal:SetPoint("TOPLEFT", -1, 1)
    colorPicker.normal:SetPoint("BOTTOMRIGHT", 1, -1)
    colorPicker.r = r
    colorPicker.g = g
    colorPicker.b = b
    colorPicker.foreground = colorPicker:CreateTexture(nil, "OVERLAY")
    colorPicker.foreground:SetColorTexture(colorPicker.r, colorPicker.g, colorPicker.b, 1)
    colorPicker.foreground:SetAllPoints()
    colorPicker:SetNormalTexture(colorPicker.normal)
    colorPicker:SetScript("OnClick", onClick)
    colorPicker.text = textFactory(colorPicker, text, 12)
    colorPicker.text:SetPoint("LEFT", 20, 0)
    
    return colorPicker
end

function LoadConfig()
    if not CodexConfig then CodexConfig = {} end

    for key, val in pairs(DefaultCodexConfig) do
        if CodexConfig[key] == nil then
            if key == "colorList" then
                CodexConfig[key] = {unpack(val)}
            else
                CodexConfig[key] = val
            end
        end
    end
end

function UpdateConfigPanel(configPanel)
    configPanel.autoAcceptQuestsCheckbox:SetChecked(CodexConfig.autoAccept)
    configPanel.autoTurninQuestsCheckbox:SetChecked(CodexConfig.autoTurnin)
    configPanel.nameplateIconCheckbox:SetChecked(CodexConfig.nameplateIcon)
    configPanel.allQuestGiversCheckbox:SetChecked(CodexConfig.allQuestGivers)
    configPanel.currentQuestGiversCheckbox:SetChecked(CodexConfig.currentQuestGivers)
    configPanel.showLowLevelCheckbox:SetChecked(CodexConfig.showLowLevel)
    configPanel.showHighLevelCheckbox:SetChecked(CodexConfig.showHighLevel)
    configPanel.showFestivalCheckbox:SetChecked(CodexConfig.showFestival)
    configPanel.colorBySpawnCheckbox:SetChecked(CodexConfig.colorBySpawn)

    configPanel.questMarkerSizeSlider:SetValue(CodexConfig.questMarkerSize)
    configPanel.questMarkerSizeSlider.editBox:SetCursorPosition(0)

    configPanel.spawnMarkerSizeSlider:SetValue(CodexConfig.spawnMarkerSize)
    configPanel.spawnMarkerSizeSlider.editBox:SetCursorPosition(0)

    -- for k, v in pairs(colorListPickers) do
    --     r, g, b = unpack(CodexConfig.colorList[k])
    --     v.r = r
    --     v.g = g
    --     v.b = b
    --     v.foreground:SetColorTexture(r, g, b)
    -- end

    -- r, g, b = unpack(CodexConfig.searchColor)
    -- configPanel.searchColorPicker.r = r
    -- configPanel.searchColorPicker.g = g
    -- configPanel.searchColorPicker.b = b
    -- configPanel.searchColorPicker.foreground:SetColorTexture(r, g, b)
end

function createConfigPanel(parent)
    local config = CreateFrame("Frame", nil, parent)
    local settings = 0

    -- Title
    config.titleText = textFactory(config, "Configuration", 20)
    config.titleText:SetPoint("TOPLEFT", 0, 0)
    config.titleText:SetTextColor(1, 0.9, 0, 1)
    
    -- Auto-Accept Quests
    config.autoAcceptQuestsCheckbox = checkboxFactory(config, "自动接任务", "开启/关闭自动接任务", function(self)
        CodexConfig.autoAccept = self:GetChecked()
    end)
    config.autoAcceptQuestsCheckbox:SetPoint("TOPLEFT", 10, -35)

    -- Auto-Turnin Quests
    config.autoTurninQuestsCheckbox = checkboxFactory(config, "自动交任务", "开启/关闭自动交任务", function(self)
        CodexConfig.autoTurnin = self:GetChecked()
    end)
    config.autoTurninQuestsCheckbox:SetPoint("TOPLEFT", 10, -70)

    -- Quest Icon on Nameplate
    config.nameplateIconCheckbox = checkboxFactory(config, "姓名板任务图标", "在任务怪姓名板上方显示任务感叹号", function(self)
        CodexConfig.nameplateIcon = self:GetChecked()
    end)
    config.nameplateIconCheckbox:SetPoint("TOPLEFT", 10, -105)

    config.allQuestGiversCheckbox = checkboxFactory(config, "显示所有可接任务", "选中后，在地图和小地图上显示可接任务的图标", function(self)
        CodexConfig.allQuestGivers = self:GetChecked()
        CodexQuest:ResetAll()
    end)
    config.allQuestGiversCheckbox:SetPoint("TOPLEFT", 10, -140)

    config.currentQuestGiversCheckbox = checkboxFactory(config, "显示当前任务NPC", "选中后，可交付当前任务的NPC或物体会显示在地图上", function(self)
        CodexConfig.currentQuestGivers = self:GetChecked()
        CodexQuest:ResetAll()
    end)
    config.currentQuestGiversCheckbox:SetPoint("TOPLEFT", 10, -175)

    config.showLowLevelCheckbox = checkboxFactory(config, "显示低等级任务", "选中后，地图上的低等级任务(比玩家等级低10级)不再被隐藏", function(self)
        CodexConfig.showLowLevel = self:GetChecked()
        CodexQuest:ResetAll()
    end)
    config.showLowLevelCheckbox:SetPoint("TOPLEFT", 10, -210)

    config.showHighLevelCheckbox = checkboxFactory(config, "显示高等级任务", "选中后，可接等级比玩家等级高3级的任务也会显示在地图上", function(self)
        CodexConfig.showHighLevel = self:GetChecked()
        CodexQuest:ResetAll()
    end)
    config.showHighLevelCheckbox:SetPoint("TOPLEFT", 10, -245)

    config.showFestivalCheckbox = checkboxFactory(config, "显示节日任务", "选中后，节日相关任务会被显示在地图上", function(self)
        CodexConfig.showFestival = self:GetChecked()
        CodexQuest:ResetAll()
    end)
    config.showFestivalCheckbox:SetPoint("TOPLEFT", 10, -280)

    config.colorBySpawnCheckbox = checkboxFactory(config, "按任务怪类型标记颜色", "选中后，不同任务怪的地图标记颜色不同。如果未选中，则一个任务的所有任务怪都是同一个颜色。", function(self)
        CodexConfig.colorBySpawn = self:GetChecked()
        CodexQuest:ResetAll()
    end)
    config.colorBySpawnCheckbox:SetPoint("TOPLEFT", 10, -315)

    config.questMarkerSizeSlider = sliderFactory(config, "questMarkerSize", "任务标记大小", 10, 25, 1, function(self)
        CodexConfig.questMarkerSize = tonumber(self:GetValue())
        CodexMap:UpdateNodes()
    end)
    config.questMarkerSizeSlider:SetPoint("TOPLEFT", 45, -400)

    config.spawnMarkerSizeSlider = sliderFactory(config, "spawnMarkerSize", "怪物标记大小", 6, 20, 1, function(self)
        CodexConfig.spawnMarkerSize = tonumber(self:GetValue())
        CodexMap:UpdateNodes()
    end)
    config.spawnMarkerSizeSlider:SetPoint("TOPLEFT", 325, -400)

    -- Marker Colors
    -- config.markerColorsTitle = textFactory(config, "Map Marker Colors", 20)
    -- config.markerColorsTitle:SetPoint("TOPLEFT", 0, -350)
    -- config.markerColorsTitle:SetTextColor(1, 0.9, 0, 1)

    -- config.restoreColorsButton = CreateFrame("Button", nil, config)
    -- config.restoreColorsButton:SetPoint("TOPLEFT", 190, -349)
    -- config.restoreColorsButton:SetSize(190, 35)
    -- config.restoreColorsButton:SetNormalTexture("Interface/Buttons/UI-Panel-Button-Up")
    -- config.restoreColorsButton:SetHighlightTexture("Interface/Buttons/UI-Panel-Button-Highlight")
    -- config.restoreColorsButton:SetPushedTexture("Interface/Buttons/UI-Panel-Button-Down")
    -- local font = config.restoreColorsButton:CreateFontString()
    -- font:SetFont("Fonts/ARKai_T.TTF", 12)
    -- font:SetPoint("TOPLEFT", config.restoreColorsButton, "TOPLEFT", 10, -6)
    -- font:SetText("Restore Defaults")
    -- config.restoreColorsButton:SetFontString(font)
    -- config.restoreColorsButton:SetScript("OnClick", function(self)
    --     CodexConfig.colorList = {unpack(DefaultCodexConfig.colorList)}
    --     CodexQuest:ResetAll()
    --     UpdateConfigPanel(config)
    -- end)

    -- for k, v in pairs(CodexConfig.colorList) do
    --     local colorPickerFrame = colorPickerFactory(config, "Color " .. k, v[1], v[2], v[3], "Color " .. k, function(self)
    --         local function func(restore)
    --             if restore then
    --                 r, g, b = unpack(restore)
    --             else
    --                 r, g, b = ColorPickerFrame:GetColorRGB()
    --             end
    --             CodexConfig.colorList[k] = {r, g, b}

    --             self.r, self.g, self.b = r, g, b
    --             self.foreground:SetColorTexture(r, g, b, 1)
    --             CodexQuest:ResetAll()
    --         end

    --         ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = func, func, func
    --         ColorPickerFrame:SetColorRGB(self.r, self.g, self.b)
    --         ColorPickerFrame.opacity = 1
    --         ColorPickerFrame.previousValues = {self.r, self.g, self.b}
    --         ColorPickerFrame:Show()
    --     end)

    --     colorPickerFrame:SetPoint("TOPLEFT", ((k - 1) % 6) * 85 + 10, -385 - math.floor((k - 1) / 6) * 25)

    --     table.insert(colorListPickers, colorPickerFrame)
    -- end

    -- Search Color
    -- config.searchColorTitle = textFactory(config, "Search Marker Color", 20)
    -- config.searchColorTitle:SetPoint("TOPLEFT", 0, -525)
    -- config.searchColorTitle:SetTextColor(1, 0.9, 0, 1)

    -- config.searchColorPicker = colorPickerFactory(config, "Search Color", CodexConfig.searchColor[1], CodexConfig.searchColor[2], CodexConfig.searchColor[3], "Search Color", function(self)
    --     local function func(restore)
    --         if restore then
    --             r, g, b = unpack(restore)
    --         else
    --             r, g, b = ColorPickerFrame:GetColorRGB()
    --         end
    --         CodexConfig.searchColor = {r, g, b}

    --         self.r, self.g, self.b = r, g, b
    --         self.foreground:SetColorTexture(r, g, b, 1)
    --         CodexQuest.ResetAll()
    --     end

    --     ColorPickerFrame.func, ColorPickerFrame.opacityFunc, ColorPickerFrame.cancelFunc = func, func, func
    --     ColorPickerFrame:SetColorRGB(self.r, self.g, self.b)
    --     ColorPickerFrame.opacity = 1
    --     ColorPickerFrame.previousValues = {self.r, self.g, self.b}
    --     ColorPickerFrame:Show()
    -- end)
    -- config.searchColorPicker:SetPoint("TOPLEFT", 10, -560)

    return config
end

codexConfig = CreateFrame("Frame", "codexConfig", UIParent)
codexConfig:RegisterEvent("ADDON_LOADED")
codexConfig.name = "ClassicCodex"
codexConfig.default = setDefaults
InterfaceOptions_AddCategory(codexConfig)

local scrollFrame = CreateFrame("ScrollFrame", nil, codexConfig)
scrollFrame:SetPoint('TOPLEFT', 5, -5)
scrollFrame:SetPoint('BOTTOMRIGHT', -5, 5)
scrollFrame:EnableMouseWheel(true)
scrollFrame:SetScript('OnMouseWheel', function(self, direction)
    if direction == 1 then
        scrollValue = math.max(self:GetVerticalScroll() - 50, 1)
        self:SetVerticalScroll(scrollValue)
        self:GetParent().scrollBar:SetValue(scrollValue) 
    elseif direction == -1 then
        scrollValue = math.min(self:GetVerticalScroll() + 50, 250)
        self:SetVerticalScroll(scrollValue)
        self:GetParent().scrollBar:SetValue(scrollValue)
    end
end)
codexConfig.scrollFrame = scrollFrame

local scrollBar = CreateFrame("Slider", nil, scrollFrame, "UIPanelScrollBarTemplate")
scrollBar:SetPoint("TOPLEFT", codexConfig, "TOPRIGHT", -20, -20) 
scrollBar:SetPoint("BOTTOMLEFT", codexConfig, "BOTTOMRIGHT", -20, 20) 
scrollBar:SetMinMaxValues(1, 250) 
scrollBar:SetValueStep(1) 
scrollBar.scrollStep = 1 
scrollBar:SetValue(0) 
scrollBar:SetWidth(16) 
scrollBar:SetScript("OnValueChanged", function (self, value)
    self:GetParent():SetVerticalScroll(value) 
end) 
local scrollBackground = scrollBar:CreateTexture(nil, "BACKGROUND") 
scrollBackground:SetAllPoints(scrollBar) 
scrollBackground:SetColorTexture(0, 0, 0, 0.6) 
codexConfig.scrollBar = scrollBar

local content = CreateFrame("Frame", nil, scrollFrame)
content:SetSize(1, 1)
scrollFrame.content = content
scrollFrame:SetScrollChild(content)


codexConfig:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "ClassicCodex" then
        LoadConfig()

        -- Add main panel
        content.panel = createConfigPanel(content)
        content.panel:SetPoint("TOPLEFT", 10, -10)
        content.panel:SetSize(1, 1)
        
        UpdateConfigPanel(content.panel)
    end
end)
