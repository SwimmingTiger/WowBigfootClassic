local L = LibStub("AceLocale-3.0"):GetLocale("ClassicCodex")

CodexBrowserFavorites = {["units"] = {}, ["objects"] = {}, ["items"] = {}, ["quests"] = {}}

local tooltipLimit = 5
local searchLimit = 512

local items = CodexDB["items"]["data"]
local units = CodexDB["units"]["data"]
local objects = CodexDB["objects"]["data"]
local refloot = CodexDB["refloot"]["data"]
local quests = CodexDB["quests"]["data"]
local zones = CodexDB["zones"]["loc"]

-- result buttons
local function StartAndFinish(questData, startOrFinish, types)
    local strings = {["start"] = L["Quest Start"]..": ", ["end"] = L["Quest End"]..": "}
    for _, key in pairs(types) do
        if questData[startOrFinish] and questData[startOrFinish][key] then
            local typeName = {["U"] = "units", ["O"] = "objects", ["I"] = "items"}

            local entries = ""
            local first = true
            for _, id in pairs(questData[startOrFinish][key]) do
                if first == true then
                    entries = entries .. (CodexDB[typeName[key]]["loc"][id] or UNKNOWN)
                    first = false
                else
                    entries = entries .. ", " .. (CodexDB[typeName[key]]["loc"][id] or UNKNOWN)
                end
            end

            GameTooltip:AddDoubleLine(strings[startOrFinish], entries, 1, 1, 1, 1, 1, 0.8)
        end
    end
end

local function ResultButtonEnter(self)
    self.tex:SetColorTexture(1, 1, 1, 0.1)

    -- item
    if self.btype == "items" then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT", -10, -5)
        GameTooltip:SetHyperlink("item:" .. self.id .. ":0:0:0")
        GameTooltip:Show()

    -- quest
    elseif self.btype == "quests" then
        GameTooltip:SetOwner(self, "ANCHOR_LEFT", -10, -5)
        GameTooltip:SetText(self.name, 0.3, 1, 0.8)
        local questTexts = CodexDB[self.btype]["loc"][self.id]
        local questData = CodexDB[self.btype]["data"][self.id]
        GameTooltip:AddLine(" ")

        -- quest starter
        if questData["start"] or questData["end"] then
            StartAndFinish(questData, "start", {"U", "O", "I"})
            StartAndFinish(questData, "end", {"U", "O"})
        end

        -- objectives
        if questTexts["O"] and questTexts["O"] ~= "" then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(CodexDatabase:FormatQuestText(questTexts["O"]), 1, 1, 1, true)
        end

        -- details
        if questTexts["D"] and questTexts["D"] ~= "" then
            GameTooltip:AddLine(" ")
            GameTooltip:AddLine(CodexDatabase:FormatQuestText(questTexts["D"]), 0.6, 0.6, 0.6, true)
        end

        -- levels
        if questData.lvl or questData.min then
            GameTooltip:AddLine(" ")
        end
        if questData.lvl then
            local questLevel = tonumber(questData.lvl)
            local color = GetQuestDifficultyColor(questLevel)
            GameTooltip:AddLine("|cffffffff"..L["Quest Level"]..": |r" .. questLevel, color.r, color.g, color.b)
        end
        if questData.min then
            local questLevel = tonumber(questData.min)
            local color = GetQuestDifficultyColor(questLevel)
            GameTooltip:AddLine("|cffffffff"..L["Required Level"]..": |r" .. questLevel, color.r, color.g, color.b)
        end

        GameTooltip:Show()

    -- units / objects
    else
        local id = self.id
        local name = self.name
        local maps = {}
        GameTooltip:SetOwner(self, "ANCHOR_LEFT", -10, -5)
        GameTooltip:SetText(name, 0.3, 1, 0.8)
        if self.btype == "units" then
            local unitData = units[id]

            if unitData.lvl then
                GameTooltip:AddLine(" ")
                GameTooltip:AddDoubleLine("Level", unitData.lvl, 1, 1, 0.8, 1, 1, 1)
            end

            local reactionStringA = "|c00ff0000"..L["Hostile"].."|r"
            local reactionStringH = "|c00ff0000"..L["Hostile"].."|r"
            if unitData.fac then
              if unitData.fac == "AH" then
                reactionStringA = "|c0000ff00"..L["Friendly"].."|r"
                reactionStringH = "|c0000ff00"..L["Friendly"].."|r"
              elseif unitData.fac == "A" then
                reactionStringA = "|c0000ff00"..L["Friendly"].."|r"
              elseif unitData.fac == "H" then
                reactionStringH = "|c0000ff00"..L["Friendly"].."|r"
              end
            end
            GameTooltip:AddLine("\n"..L["Reaction"], 1, 1, 0.8)
            GameTooltip:AddDoubleLine(L["Alliance"], reactionStringA, 1, 1, 1, 0, 0, 0)
            GameTooltip:AddDoubleLine(L["Horde"], reactionStringH, 1, 1, 1, 0, 0, 0)
        end
        GameTooltip:AddLine("\n"..L["Location"], 1, 1, 0.8)
        if CodexDB[self.btype]["data"][id] and CodexDB[self.btype]["data"][id]["coords"] then
            for _, data in pairs(CodexDB[self.btype]["data"][id]["coords"]) do
                local zone = data[3]
                maps[zone] = maps[zone] and maps[zone] + 1 or 1
            end
        else
            GameTooltip:AddLine(UNKNOWN, 1, 0.5, 0.5)
        end
        for zone, count in pairs(maps) do
            GameTooltip:AddDoubleLine((zone and CodexMap:GetMapNameById(zone) or UNKNOWN), count .. "x", 1, 1, 1, 0.5, 0.5, 0.5)
        end
        GameTooltip:Show()
    end
end

local function ResultButtonUpdate(self)
    self.refreshCount = self.refreshCount + 1

    if not self.itemColor then
        -- Prevent item comparison window popup when item info loading
        if CodexBrowser.alwaysCompareItems then
            SetCVar('alwaysCompareItems', '0')
        end

        GameTooltip:SetHyperlink("item:" .. self.id .. ":0:0:0")
        GameTooltip:Hide()

        local _, _, itemQuality = GetItemInfo(self.id)
        if itemQuality then
            local r = ceil(ITEM_QUALITY_COLORS[itemQuality].r*255)
            local g = ceil(ITEM_QUALITY_COLORS[itemQuality].g*255)
            local b = ceil(ITEM_QUALITY_COLORS[itemQuality].b*255)
            self.itemColor = "|c" .. string.format("ff%02x%02x%02x", r, g, b)
        end
    end

    if self.itemColor then
        local idStr = (self.searchMode == 2 or CodexConfig.alwaysShowId) and string.format('|cff006a72#%d|r ', self.id) or ''
        self.text:SetText(idStr .. self.itemColor .. "|Hitem:" .. self.id .. ":0:0:0|h[" .. self.name .. "]|h|r")
        self.text:SetWidth(self.text:GetStringWidth())
    end

    if self.refreshCount > 10 or self.itemColor then
        self:SetScript("OnUpdate", nil)
        -- Chain loading to reduce stuttering
        if self.parent[self.index + 1] then
            self.parent[self.index + 1]:SetScript("OnUpdate", ResultButtonUpdate)
        end
        
        -- Item info loaded, restoring the CVar changed before
        if CodexBrowser.alwaysCompareItems then
            SetCVar('alwaysCompareItems', '1')
        end
    end
end

local function ResultButtonClick(self, arg1)
    local meta = {["addon"] = "CODEX"}

    if self.btype == "items" then
        local link = "item:" .. self.id .. ":0:0:0"
        local text = (self.itemColor or "|cffffffff") .. "|H" .. link .. "|h[" .. self.name .. "]|h|r"
        SetItemRef(link, text, arg1)
    elseif self.btype == "quests" then
        if IsShiftKeyDown() then
            ChatFrame1EditBox:Show()
            -- Task link cannot be sent to chat channel, send plain text instead.
            --ChatFrame1EditBox:Insert("|cffffff00|Hquest:" .. (self.id or 0) .. ":0:0:0|h[" .. self.name .. "]|h|r")
            ChatFrame1EditBox:Insert(self.name)
        elseif CodexBrowser.selectState then
            local maps = CodexDatabase:SearchQuestByName(self.name)
            CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        else
            local maps = CodexDatabase:SearchQuestById(self.id, meta)
            CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        end
    elseif self.btype == "units" then
        if IsShiftKeyDown() then
            ChatFrame1EditBox:Show()
            ChatFrame1EditBox:Insert(self.name)
        elseif CodexBrowser.selectState then
            local maps = CodexDatabase:SearchUnitByName(self.name, meta)
            CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        else
            local maps = CodexDatabase:SearchUnitById(self.id, meta)
            -- CodexMap:ShowMapId() will call CodexMap:UpdateNodes().
            --CodexMap:UpdateNodes()
            CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        end
    elseif self.btype == "objects" then
        if IsShiftKeyDown() then
            ChatFrame1EditBox:Show()
            ChatFrame1EditBox:Insert(self.name)
        elseif CodexBrowser.selectState then
            local maps = CodexDatabase:SearchObjectByName(self.name, meta)
            CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        else
            local maps = CodexDatabase:SearchObjectById(self.id, meta)
            -- CodexMap:ShowMapId() will call CodexMap:UpdateNodes().
            --CodexMap:UpdateNodes()
            CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
        end
    end
end

local function ResultButtonClickFav(self)
    local parent = self:GetParent()

    -- Remove the quest from the manual hidden list
    if parent.searchMode == 4 then
        CodexHiddenQuests[parent.id] = nil
        self.icon:SetVertexColor(1, 1, 1, 0.1)
        parent:Hide()
        CodexQuest.updateQuestGivers = true
        return
    end

    if not CodexBrowserFavorites[parent.btype] then
        CodexBrowserFavorites[parent.btype] = {}
    end

    if CodexBrowserFavorites[parent.btype][parent.id] then
        CodexBrowserFavorites[parent.btype][parent.id] = nil
        self.icon:SetVertexColor(1, 1, 1, 0.1)
    else
        CodexBrowserFavorites[parent.btype][parent.id] = parent.name
        self.icon:SetVertexColor(1, 1, 1, 1)
    end
end

local function ResultButtonLeave(self)
    if CodexBrowser.selectState then
        CodexBrowser.selectState = "clean"
    end

    if self:GetID() % 2 == 1 then
        self.tex:SetColorTexture(1, 1, 1, 0.02)
    else
        self.tex:SetColorTexture(1, 1, 1, 0.04)
    end
    GameTooltip:Hide()
end

local function ResultButtonClickSpecial(self)
    local meta = {["addon"] = "CODEX"}
    local param = self:GetParent()[self.parameter]
    local maps = {}
    if self.buttonType == "O" or self.buttonType == "U" then
        if self.selectState then
            maps = CodexDatabase:SearchItemByName(self:GetParent().name, meta)
        else
            maps = CodexDatabase:SearchItemById(param, meta, nil, {[self.buttonType] = true})
        end
    elseif self.buttonType == "V" then
        maps = CodexDatabase:SearchVendorByItemName(param, meta)
    end
    -- CodexMap:ShowMapId() will call CodexMap:UpdateNodes().
    --CodexMap:UpdateNodes()
    CodexMap:ShowMapId(CodexDatabase:GetBestMap(maps))
end

local function ResultButtonEnterSpecial(self)
    local id = self:GetParent().id
    local count = 0
    local skip = false

    GameTooltip:SetOwner(CodexBrowser, "ANCHOR_CURSOR")

    -- unit
    if self.buttonType == "U" then
        if items[id]["U"] then
            GameTooltip:SetText(L["Looted from"], 0.3, 1, 0.8)
            for unitId, chance in pairs(items[id]["U"]) do
                count = count + 1
                if count > tooltipLimit then
                    skip = true
                end
                if units[unitId] and not skip then
                    local name = CodexDB.units.loc[unitId]
                    local zone = nil
                    if units[unitId].coords and units[unitId].coords[1] then
                        zone = units[unitId].coords[1][3]
                    end
                    GameTooltip:AddDoubleLine(name, (zone and CodexMap:GetMapNameById(zone) or UNKNOWN), 1, 1, 1, 0.5, 0.5, 0.5)
                end
            end

            -- reference tables
            if items[id]["R"] then
                for ref, chance in pairs(items[id]["R"]) do
                    if refloot[ref] and refloot[ref]["U"] then
                        for unit in pairs(refloot[ref]["U"]) do
                            count = count + 1
                            if count > tooltipLimit then
                                skip = true
                            end
                            if units[unit] and not skip then
                                local name = CodexDB.units.loc[unit]
                                local zone = nil
                                if units[unit].coords and units[unit].coords[1] then
                                    zone = units[unit].coords[1][3]
                                end
                                GameTooltip:AddDoubleLine(name, (zone and CodexMap:GetMapNameById(zone) or UNKNOWN), 1, 1, 1, 0.5, 0.5, 0.5)
                            end
                        end
                    end
                end
            end
        end
    -- object
    elseif self.buttonType == "O" then
        if items[id]["O"] then
            GameTooltip:SetText(L["Looted from"], 0.3, 1, 0.8)
            for objectId, chance in pairs(items[id]["O"]) do
                count = count + 1
                if count > tooltipLimit then
                    skip = true
                end
                if objects[objectId] and not skip then
                    local name = CodexDB.objects.loc[objectId] or objectId
                    local zone = nil
                    if objects[objectId].coords and objects[objectId].coords[1] then
                        zone = objects[objectId].coords[1][3]
                    end
                    GameTooltip:AddDoubleLine(name, (zone and CodexMap:GetMapNameById(zone) or UNKNOWN), 1, 1, 1, 0.5, 0.5, 0.5)
                end
            end

            -- reference tables
            if items[id]["R"] then
                for ref, chance in pairs(items[id]["R"]) do
                    if refloot[ref] and refloot[ref]["O"] then
                        for unit in pairs(refloot[ref]["O"]) do
                            count = count + 1
                            if count > tooltipLimit then
                                skip = true
                            end
                            if objects[unit] and not skip then
                                local name = CodexDB.objects.loc[unit]
                                local zone = nil
                                if objects[unit].coords and objects[unit].coords[1] then
                                    zone = objects[unit].coords[1][3]
                                end
                                GameTooltip:AddDoubleLine(name, (zone and CodexMap:GetMapNameById(zone) or UNKNOWN), 1, 1, 1, 0.5, 0.5, 0.5)
                            end
                        end
                    end
                end
            end
        end
    -- Vendor
    elseif self.buttonType == "V" then
        if items[id]["V"] then
            GameTooltip:SetText(L["Sold by"], 0.3, 1, 0.8)
            for unitId, sellCount in pairs(items[id]["V"]) do
                count = count + 1
                if count > tooltipLimit then
                    skip = true
                end
                if units[unitId] and not skip then
                    local name = CodexDB.units.loc[unitId]
                    if sellCount ~= 0 then name = name .. " (" .. sellCount .. ")" end
                    local zone = units[unitId].coords and units[unitId].coords[1] and units[unitId].coords[1][3]
                    GameTooltip:AddDoubleLine(name, (zone and CodexMap:GetMapNameById(zone) or UNKNOWN), 1, 1, 1, 0.5, 0.5, 0.5)
                end
            end
        end
    end
    
    if count > tooltipLimit then
        GameTooltip:AddLine("\n"..string.format(L["and %d others"], count - tooltipLimit), 0.8, 0.8, 0.8)
    end
    GameTooltip:Show()
end

local function ResultButtonLeaveSpecial()
    GameTooltip:Hide()
end

local function ResultButtonReload(self)
    self.idText:SetText("ID: " .. self.id)

    self.idText:Hide()

    self.itemColor = nil

    -- update faction
    if self.btype ~= "items" then
        self.factionA:Hide()
        self.factionH:Hide()

        local raceMask = CodexDatabase:GetRaceMaskById(self.id, self.btype)
        if (bit.band(77, raceMask) > 0)  or (raceMask == 0 and self.btype == "quests") then
            self.factionA:Show()
        end
        if (bit.band(178, raceMask) > 0)  or (raceMask == 0 and self.btype == "quests") then
            self.factionH:Show()
        end
    end

    -- activate fav buttons if needed
    if (self.searchMode == 4) or (CodexBrowserFavorites and CodexBrowserFavorites[self.btype] and CodexBrowserFavorites[self.btype][self.id]) then
        self.fav.icon:SetVertexColor(1, 1, 1, 1)
    else
        self.fav.icon:SetVertexColor(1, 1, 1, 0.1)
    end

    local idStr = (self.searchMode == 2 or CodexConfig.alwaysShowId) and string.format('|cff006a72#%d|r ', self.id) or ''

    -- actions by search type
    if self.btype == "quests" then
        self.name = CodexDB[self.btype]["loc"][self.id]["T"]
        self.text:SetText(idStr .. "|cffffcc00|Hquest:0:0:0:0|h[" .. self.name .. "]|h|r")
    elseif self.btype == "units" or self.btype == "objects" then
        local level = CodexDB[self.btype]["data"][self.id] and CodexDB[self.btype]["data"][self.id]["lvl"] or ""
        if level and level ~= "" then level = " (" .. level .. ")" end
        self.text:SetText(idStr .. self.name .. "|cffaaaaaa" .. level)

        if CodexDB[self.btype]["data"][self.id] and CodexDB[self.btype]["data"][self.id]["coords"] then
            self.text:SetTextColor(1, 1, 1)
        else
            self.text:SetTextColor(0.5, 0.5, 0.5)
        end
    elseif self.btype == "items" then
        for _, key in pairs({"U", "O", "V"}) do
            if items[self.id] and items[self.id][key] then
                self[key]:Show()
            else
                self[key]:Hide()
            end
        end

        self.text:SetText(idStr .. "|cffff5555[?] |cffffffff" .. self.name)

        self.refreshCount = 0
        -- Chain loading to reduce stuttering
        if self.index == 1 then
            self:SetScript("OnUpdate", ResultButtonUpdate)
        end
    end
    
    self.text:SetWidth(self.text:GetStringWidth())
    self:Show()
end

local function ResultButtonCreate(i, resultType)
    local f = CreateFrame("Button", nil, CodexBrowser.tabs[resultType].list)
    f:SetPoint("TOPLEFT", CodexBrowser.tabs[resultType].list, "TOPLEFT", 10, -i * 30 + 5)
    f:SetPoint("BOTTOMRIGHT", CodexBrowser.tabs[resultType].list, "TOPRIGHT", 10, -i * 30 - 15)
    f:Hide()
    f:SetID(i)

    f.btype = resultType
    f.codexResultButton = true

    f.tex = f:CreateTexture("BACKGROUND")
    f.tex:SetAllPoints(f)
    f.tex:SetColorTexture(1, 1, 1, (i % 2 == 1 and .02 or .04))
    -- f.tex:SetVertexColor(1, 1, 1, 0.02)

    -- text properties
    f.text = f:CreateFontString("Caption", "LOW", "GameFontWhite")
    f.text:SetFont(CodexUI.defaultFont, CodexUIConfig.global.fontSize, "OUTLINE")
    f.text:SetAllPoints(f)
    f.text:SetJustifyH("CENTER")
    f.idText = f:CreateFontString("ID", "LOW", "GameFontDisable")
    f.idText:SetPoint("LEFT", f, "LEFT", 30, 0)

    -- favorite button
    f.fav = CreateFrame("Button", nil, f)
    f.fav:SetHitRectInsets(-3, -3, -3, -3)
    f.fav:SetPoint("LEFT", 0, 0)
    f.fav:SetWidth(16)
    f.fav:SetHeight(16)
    f.fav.icon = f.fav:CreateTexture("OVERLAY")
    f.fav.icon:SetTexture("Interface\\Addons\\ClassicCodex\\img\\fav")
    f.fav.icon:SetAllPoints(f.fav)

    -- faction icons
    if resultType ~= "items" then
        f.factionA = f:CreateTexture("OVERLAY")
        f.factionA:SetTexture("Interface\\Addons\\ClassicCodex\\img\\icon_alliance")
        f.factionA:SetWidth(16)
        f.factionA:SetHeight(16)
        f.factionA:SetPoint("RIGHT", -5, 0)
        f.factionH = f:CreateTexture("OVERLAY")
        f.factionH:SetTexture("Interface\\Addons\\ClassicCodex\\img\\icon_horde")
        f.factionH:SetWidth(16)
        f.factionH:SetHeight(16)
        f.factionH:SetPoint("RIGHT", -24, 0)
    end

    -- drop, loot, vendor buttons
    if resultType == "items" then
        local buttons = {
          ["U"] = { ["offset"] = -5,  ["icon"] = "icon_npc",    ["parameter"] = "id",   },
          ["O"] = { ["offset"] = -24, ["icon"] = "icon_object", ["parameter"] = "id",   },
          ["V"] = { ["offset"] = -43, ["icon"] = "icon_vendor", ["parameter"] = "name", },
        }
    
        for button, settings in pairs(buttons) do
          f[button] = CreateFrame("Button", nil, f)
          f[button]:SetHitRectInsets(-3,-3,-3,-3)
          f[button]:SetPoint("RIGHT", settings.offset, 0)
          f[button]:SetWidth(16)
          f[button]:SetHeight(16)
    
          f[button].buttonType = button
          f[button].parameter = settings.parameter
    
          f[button].icon = f[button]:CreateTexture("OVERLAY")
          f[button].icon:SetAllPoints(f[button])
          f[button].icon:SetTexture("Interface\\Addons\\ClassicCodex\\img\\" .. settings.icon)
    
          f[button]:SetScript("OnEnter", ResultButtonEnterSpecial)
          f[button]:SetScript("OnLeave", ResultButtonLeaveSpecial)
          f[button]:SetScript("OnClick", ResultButtonClickSpecial)
        end
    end

    -- bind functions
    f.Reload = ResultButtonReload
    f:SetScript("OnLeave", ResultButtonLeave)
    f:SetScript("OnEnter", ResultButtonEnter)
    f:SetScript("OnClick", ResultButtonClick)
    f.fav:SetScript("OnClick", ResultButtonClickFav)

    return f
end

local function SelectView(view)
    for id, frame in pairs(CodexBrowser.tabs) do
        local font = CreateFont("Unselected_ButtonFont")
        font:SetFontObject(GameFontNormal)
        font:SetTextColor(1, 1, 1, 0.7)
        frame.button:SetNormalFontObject(font)
        frame:Hide()
    end
    local font = CreateFont("Selected_ButtonFont")
    font:SetFontObject(GameFontNormal)
    font:SetTextColor(0.2, 1, 0.8, 1)
    view.button:SetNormalFontObject(font)
    view.button:Hide()
    view.button:Show()
    view:Show()
end

-- sets the browser result values when they change
local function RefreshView(i, key, caption)
    CodexBrowser.tabs[key].list:Hide()
    CodexBrowser.tabs[key].list:SetHeight(i * 30 )
    CodexBrowser.tabs[key].list:Show()
    CodexBrowser.tabs[key].list:GetParent():SetScrollChild(CodexBrowser.tabs[key].list)
    CodexBrowser.tabs[key].list:GetParent():SetVerticalScroll(0)
    CodexBrowser.tabs[key].list:GetParent():UpdateScrollState()
  
    if not CodexBrowser.tabs[key].list.warn then
      CodexBrowser.tabs[key].list.warn = CodexBrowser.tabs[key].list:CreateFontString("Caption", "LOW", "GameFontWhite")
      CodexBrowser.tabs[key].list.warn:SetTextColor(1,.2,.2,1)
      CodexBrowser.tabs[key].list.warn:SetJustifyH("CENTER")
      CodexBrowser.tabs[key].list.warn:SetPoint("TOP", 5, -5)
      CodexBrowser.tabs[key].list.warn:SetText("!! |cffffffff"..string.format(L["Too many entries. Results shown: %d"], searchLimit).."|r !!")
    end
  
    if i >= searchLimit then
      CodexBrowser.tabs[key].list.warn:Show()
    else
      CodexBrowser.tabs[key].list.warn:Hide()
    end
  
    -- caption: "Units", "Objects", "Items" or "Quests"
    CodexBrowser.tabs[key].button:SetText(L[caption] .. " " .. "|cffaaaaaa(" .. (i >= searchLimit and "*" or i) .. ")")
    for j=i+1, table.getn(CodexBrowser.tabs[key].buttons) do
        if CodexBrowser.tabs[key].buttons[j] then
            CodexBrowser.tabs[key].buttons[j]:Hide()
            CodexBrowser.tabs[key].buttons[j].id = nil
            CodexBrowser.tabs[key].buttons[j].name = nil
        end
    end
end

-- sets up all the browse windows and their activation buttons
local function CreateBrowseWindow(fname, name, parent, anchor, x, y)
    if not parent.tabs then parent.tabs = {} end
    parent.tabs[fname] = CodexUI.api.CreateScrollFrame(name, parent)
    parent.tabs[fname]:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -65)
    parent.tabs[fname]:SetPoint("BOTTOMRIGHT", parent, "BOTTOMRIGHT", -10, 45)
    parent.tabs[fname].buttons = { }
  
    parent.tabs[fname].backdrop = CreateFrame("Frame", name .. "Backdrop", parent.tabs[fname], BackdropTemplateMixin and "BackdropTemplate")
    parent.tabs[fname].backdrop:SetFrameLevel(1)
    parent.tabs[fname].backdrop:SetPoint("TOPLEFT", parent.tabs[fname], "TOPLEFT", -5, 5)
    parent.tabs[fname].backdrop:SetPoint("BOTTOMRIGHT", parent.tabs[fname], "BOTTOMRIGHT", 5, -5)
    CodexUI.api.CreateBackdrop(parent.tabs[fname].backdrop, nil, true)
  
    parent.tabs[fname].button = CreateFrame("Button", name .. "Button", parent, BackdropTemplateMixin and "BackdropTemplate")
    parent.tabs[fname].button:SetPoint(anchor, x, y)
    parent.tabs[fname].button:SetWidth(153)
    parent.tabs[fname].button:SetHeight(30)
    parent.tabs[fname].button:SetScript("OnClick", function()
      SelectView(parent.tabs[fname])
    end)
  
    CodexUI.api.SkinButton(parent.tabs[fname].button)
    parent.tabs[fname].list = CodexUI.api.CreateScrollChild(name .. "Scroll", parent.tabs[fname])
    parent.tabs[fname].list:SetWidth(600)
  
    parent.tabs[fname]:Hide()
end   

--minimap icon
CodexBrowserIcon = CreateFrame("Button", "CodexBrowserIcon", Minimap)
CodexBrowserIcon:SetClampedToScreen(true)
CodexBrowserIcon:SetMovable(true)
CodexBrowserIcon:EnableMouse(true)
CodexBrowserIcon:RegisterForDrag("LeftButton")
CodexBrowserIcon:RegisterForClicks("LeftButtonUp")
CodexBrowserIcon:SetScript("OnDragStart", function(self)
    if IsShiftKeyDown() then
        self:StartMoving()
    end
end)
CodexBrowserIcon:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
end)
CodexBrowserIcon:SetScript("OnClick", function()
    if CodexBrowser:IsShown() then
        CodexBrowser:Hide()
        CodexBrowser:RestoreCVars()
    else
        CodexBrowser:SaveCVars()
        CodexBrowser:Show()
    end
end)

CodexBrowserIcon:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_BOTTOMLEFT")
    GameTooltip:SetText("ClassicCodex")
    GameTooltip:AddDoubleLine(L["Left-Click"], L["Open Browser"], 1, 1, 1, 1, 1, 1)
    GameTooltip:AddDoubleLine(L["Shift-Click"], L["Move Button"], 1, 1, 1, 1, 1, 1)
    GameTooltip:Show()
end)

CodexBrowserIcon:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

CodexBrowserIcon:SetFrameStrata('LOW')
CodexBrowserIcon:SetWidth(31)
CodexBrowserIcon:SetHeight(31)
CodexBrowserIcon:SetFrameLevel(9)
CodexBrowserIcon:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')
CodexBrowserIcon:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

CodexBrowserIcon.overlay = CodexBrowserIcon:CreateTexture(nil, 'OVERLAY')
CodexBrowserIcon.overlay:SetWidth(53)
CodexBrowserIcon.overlay:SetHeight(53)
CodexBrowserIcon.overlay:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder')
CodexBrowserIcon.overlay:SetPoint('TOPLEFT', 0,0)

CodexBrowserIcon.icon = CodexBrowserIcon:CreateTexture(nil, 'BACKGROUND')
CodexBrowserIcon.icon:SetWidth(15)
CodexBrowserIcon.icon:SetHeight(15)
CodexBrowserIcon.icon:SetTexture("Interface\\Addons\\ClassicCodex\\img\\logo")
CodexBrowserIcon.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
CodexBrowserIcon.icon:SetPoint('CENTER',1,1)

-- Browser window
CodexBrowser = CreateFrame("Frame", "CodexBrowser", UIParent, BackdropTemplateMixin and "BackdropTemplate")
CodexBrowser:Hide()
CodexBrowser:SetWidth(640)
CodexBrowser:SetHeight(480)
CodexBrowser:SetPoint("CENTER", 0, 0)
CodexBrowser:SetFrameStrata("FULLSCREEN_DIALOG")
CodexBrowser:SetMovable(true)
CodexBrowser:EnableMouse(true)
CodexBrowser:SetScript("OnMouseDown",function(self)
  self:StartMoving()
end)

CodexBrowser:SetScript("OnMouseUp",function(self)
  self:StopMovingOrSizing()
end)

CodexBrowser:SetScript("OnUpdate", function(self)
  -- multi-select handling
  if not self.selectState and IsControlKeyDown() and GetMouseFocus() and GetMouseFocus().codexResultButton then
    for id, frame in pairs(CodexBrowser.tabs) do
      for id, button in pairs(frame.buttons) do
        if button.name == GetMouseFocus().name then
          button.tex:SetColorTexture(.3,1,.8,.4)
        end
      end
    end
    self.selectState = "active"

  elseif self.selectState and (self.selectState == "clean" or not IsControlKeyDown()) then
    for id, frame in pairs(CodexBrowser.tabs) do
      for id, button in pairs(frame.buttons) do
        if button:GetID() % 2 == 1 then
          button.tex:SetColorTexture(1,1,1,.02)
        else
          button.tex:SetColorTexture(1,1,1,.04)
        end
      end
    end
    self.selectState = nil
  end
end)

function CodexBrowser:SaveCVars()
    -- Save some CVars to restore after the search is complete
    self.alwaysCompareItems = GetCVar('alwaysCompareItems') == '1'
end

function CodexBrowser:RestoreCVars()
    -- Restore CVars
    if self.alwaysCompareItems then
        SetCVar('alwaysCompareItems', '1')
    end
end

function CodexBrowser:OpenView(viewName)
    SelectView(self.tabs[viewName])
    self:Show()
end

CodexUI.api.CreateBackdrop(CodexBrowser, nil, true, 0.75)
table.insert(UISpecialFrames, "CodexBrowser")

CodexBrowser.title = CodexBrowser:CreateFontString("Status", "LOW", "GameFontNormal")
CodexBrowser.title:SetFontObject(GameFontWhite)
CodexBrowser.title:SetPoint("TOP", CodexBrowser, "TOP", 0, -8)
CodexBrowser.title:SetJustifyH("LEFT")
CodexBrowser.title:SetFont(CodexUI.defaultFont, 14)
CodexBrowser.title:SetText(L["ClassicCodex"])

CodexBrowser.close = CreateFrame("Button", "CodexBrowserClose", CodexBrowser, BackdropTemplateMixin and "BackdropTemplate")
CodexBrowser.close:SetPoint("TOPRIGHT", -5, -5)
CodexBrowser.close:SetHeight(12)
CodexBrowser.close:SetWidth(12)
CodexBrowser.close.texture = CodexBrowser.close:CreateTexture("codexQuestionDialogCloseTex")
CodexBrowser.close.texture:SetTexture("Interface\\Addons\\ClassicCodex\\img\\close")
CodexBrowser.close.texture:ClearAllPoints()
CodexBrowser.close.texture:SetAllPoints(CodexBrowser.close)
CodexBrowser.close.texture:SetVertexColor(1,.25,.25,1)
CodexUI.api.SkinButton(CodexBrowser.close, 1, .5, .5)
CodexBrowser.close:SetScript("OnClick", function(self)
    self:GetParent():Hide()
    self:GetParent():RestoreCVars()
end)

CodexBrowser.clean = CreateFrame("Button", "CodexBrowserClean", CodexBrowser, BackdropTemplateMixin and "BackdropTemplate")
CodexBrowser.clean:SetPoint("TOPLEFT", CodexBrowser, "TOPLEFT", 545, -30)
CodexBrowser.clean:SetPoint("BOTTOMRIGHT", CodexBrowser, "TOPRIGHT", -5, -55)
CodexBrowser.clean:SetScript("OnClick", function()
    -- Users should not want to "clear" all their quest markers with this button.
    -- CodexMap:DeleteNode("CODEX")
    -- CodexMap:UpdateNodes()
    CodexQuest:ResetAll()
end)
CodexBrowser.clean.text = CodexBrowser.clean:CreateFontString("Caption", "LOW", "GameFontWhite")
CodexBrowser.clean.text:SetAllPoints(CodexBrowser.clean)
CodexBrowser.clean.text:SetFont(CodexUI.defaultFont, CodexUIConfig.global.fontSize, "OUTLINE")
CodexBrowser.clean.text:SetText(L["Clean Map"])
CodexUI.api.SkinButton(CodexBrowser.clean)

CreateBrowseWindow("units", "CodexBrowserUnits", CodexBrowser, "BOTTOMLEFT", 5, 5)
CreateBrowseWindow("objects", "CodexBrowserObjects", CodexBrowser, "BOTTOMLEFT", 164, 5)
CreateBrowseWindow("items", "CodexBrowserItems", CodexBrowser, "BOTTOMRIGHT", -164, 5)
CreateBrowseWindow("quests", "CodexBrowserQuests", CodexBrowser, "BOTTOMRIGHT", -5, 5)

SelectView(CodexBrowser.tabs["units"])

CodexBrowser.input = CreateFrame("EditBox", "CodexBrowserSearch", CodexBrowser, BackdropTemplateMixin and "BackdropTemplate")
CodexBrowser.input:SetFont(CodexUI.defaultFont, CodexUIConfig.global.fontSize, "OUTLINE")
CodexBrowser.input:SetAutoFocus(false)
CodexBrowser.input:SetText(L["Search"])
CodexBrowser.input:SetJustifyH("LEFT")
CodexBrowser.input:SetPoint("TOPLEFT", CodexBrowser, "TOPLEFT", 5, -30)
CodexBrowser.input:SetPoint("BOTTOMRIGHT", CodexBrowser, "TOPRIGHT", -100, -55)
CodexBrowser.input:SetTextInsets(10,10,5,5)
CodexBrowser.input:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)
CodexBrowser.input:SetScript("OnEditFocusGained", function(self)
    if self:GetText() == L["Search"] then self:SetText("") end
end)

CodexBrowser.input:SetScript("OnEditFocusLost", function(self)
  if self:GetText() == "" then self:SetText(L["Search"]) end
end)

-- This script updates all the search tabs when the search text changes
function CodexBrowser.input:Search()
    local text = self:GetText()
    if (text == L["Search"]) then text = "" end
  
    for _, caption in pairs({"Units","Objects","Items","Quests"}) do
      local searchType = strlower(caption)
  
      local data, count, searchMode = CodexDatabase:BrowserSearch(text, searchType, searchLimit)
      if count == -1 then
          data = CodexBrowserFavorites[searchType]
      end
  
      local i = 0
      if data then
          for id, text in pairs(data) do
          i = i + 1
  
          if i >= searchLimit then break end
          CodexBrowser.tabs[searchType].buttons[i] = CodexBrowser.tabs[searchType].buttons[i] or ResultButtonCreate(i, searchType)
          CodexBrowser.tabs[searchType].buttons[i].id = id
          CodexBrowser.tabs[searchType].buttons[i].name = text
          CodexBrowser.tabs[searchType].buttons[i].searchMode = searchMode
          CodexBrowser.tabs[searchType].buttons[i].index = i
          CodexBrowser.tabs[searchType].buttons[i].parent = CodexBrowser.tabs[searchType].buttons
          CodexBrowser.tabs[searchType].buttons[i]:Reload()
          end
      end
  
      RefreshView(i, searchType, caption)
    end
end
CodexBrowser.input:SetScript("OnTextChanged", function(self)
    self:Search()
end)

CodexUI.api.CreateBackdrop(CodexBrowser.input, nil, true)
