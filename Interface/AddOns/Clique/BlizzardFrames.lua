--[[-------------------------------------------------------------------------
-- BlizzardFrames.lua
--
-- This file contains the definitions of the blizzard frame integration
-- options. These settings will not apply until the user interface is
-- reloaded.
--
-- Events registered:
--   * ADDON_LOADED - To watch for loading of the ArenaUI
-------------------------------------------------------------------------]]--

local addonName, addon = ...
local L = addon.L

--[[---------------------------------------------------------------------------
--  Options panel definition
---------------------------------------------------------------------------]]--

local panel = CreateFrame("Frame")
panel.name = "Blizzard Frame Options"
panel.parent = addonName

addon.optpanels["BLIZZFRAMES"] = panel

panel:SetScript("OnShow", function(self)
    if not panel.initialized then
        panel:CreateOptions()
        panel.refresh()
    end
end)

local function make_checkbox(name, label)
    local frame = CreateFrame("CheckButton", "CliqueOptionsBlizzFrame" .. name, panel, "UICheckButtonTemplate")
    frame.text = _G[frame:GetName() .. "Text"]
    frame.type = "checkbox"
    frame.text:SetText(label)
    return frame
end

local function make_label(name, template)
    local label = panel:CreateFontString("OVERLAY", "CliqueOptionsBlizzFrame" .. name, template)
    label:SetWidth(panel:GetWidth())
    label:SetJustifyH("LEFT")
    label.type = "label"
    return label
end

function panel:CreateOptions()
    panel.initialized = true

    local bits = {}
    self.intro = make_label("Intro", "GameFontHighlightSmall")
    self.intro:SetText(L["These options control whether or not Clique automatically registers certain Blizzard-created frames for binding. Changes made to these settings will not take effect until the user interface is reloaded."])
    self.intro:SetPoint("RIGHT")
    self.intro:SetJustifyV("TOP")
    self.intro:SetHeight(40)

    self.PlayerFrame = make_checkbox("PlayerFrame", L["Player frame"])
    self.PetFrame = make_checkbox("PetFrame", L["Player's pet frame"])
    self.TargetFrame = make_checkbox("TargetFrame", L["Player's target frame"])
    self.TargetFrameToT = make_checkbox("TargetFrameToT", L["Target of target frame"])
    self.party = make_checkbox("Party", L["Party member frames"])
    self.compactraid = make_checkbox("CompactRaid", L["Compact raid frames"])
    self.boss = make_checkbox("BossTarget", L["Boss target frames"])

    self.FocusFrame = make_checkbox("FocusFrame", L["Player's focus frame"])
    self.FocusFrameToT = make_checkbox("FocusFrameToT", L["Target of focus frame"])
    self.arena = make_checkbox("ArenaEnemy", L["Arena enemy frames"])

    table.insert(bits, self.intro)
    table.insert(bits, self.PlayerFrame)
    table.insert(bits, self.PetFrame)
    table.insert(bits, self.TargetFrame)
	table.insert(bits, self.TargetFrameToT)

    if addon.compatRelease then
        table.insert(bits, self.FocusFrame)
        table.insert(bits, self.FocusFrameToT)
        table.insert(bits, self.arena)
    end

    -- Group these together
    bits[1]:SetPoint("TOPLEFT", 5, -5)

    for i = 2, #bits, 1 do
        bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", 0, 0)
    end

    local last = bits[#bits]

    table.wipe(bits)
    table.insert(bits, self.party)
    table.insert(bits, self.compactraid)
    table.insert(bits, self.boss)

    bits[1]:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -15)

    for i = 2, #bits, 1 do
        bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", 0, 0)
    end
end

function panel.refresh()
    xpcall(function()
    if not panel.initialized then
        panel:CreateOptions()
    end

    local opt = addon.settings.blizzframes

    panel.PlayerFrame:SetChecked(opt.PlayerFrame)
    panel.PetFrame:SetChecked(opt.PetFrame)
    panel.TargetFrame:SetChecked(opt.TargetFrame)
    panel.TargetFrameToT:SetChecked(opt.TargetFrameToT)

    if addon.compatRelease then
        panel.FocusFrame:SetChecked(opt.FocusFrame)
        panel.FocusFrameToT:SetChecked(opt.FocusFrameToT)
        panel.arena:SetChecked(opt.arena)
    end

    panel.party:SetChecked(opt.party)
    panel.compactraid:SetChecked(opt.compactraid)
    panel.boss:SetChecked(opt.boss)
    end, geterrorhandler())
end

function panel.okay()
    xpcall(function()
    local opt = addon.settings.blizzframes
    opt.PlayerFrame = not not panel.PlayerFrame:GetChecked()
    opt.PetFrame = not not panel.PetFrame:GetChecked()
    opt.TargetFrame = not not panel.TargetFrame:GetChecked()
    opt.TargetFrameToT = not not panel.TargetFrameToT:GetChecked()

    if addon.compatRelease then
        opt.FocusFrame = not not panel.FocusFrame:GetChecked()
        opt.FocusFrameToT = not not panel.FocusFrameToT:GetChecked()
        opt.arena = not not panel.arena:GetChecked()
    end

    opt.party = not not panel.party:GetChecked()
    opt.compactraid = not not panel.compactraid:GetChecked()
    opt.boss = not not panel.boss:GetChecked()
    end, geterrorhandler())
end

InterfaceOptions_AddCategory(panel, addon.optpanels.ABOUT)

--[[---------------------------------------------------------------------------
--  Blizzard Frame integration code
---------------------------------------------------------------------------]]--
local function enable(frame)
    if type(frame) == "string" then
        local frameName = frame
        frame = _G[frameName]
        if not frame then
            print("Clique: error registering frame: " .. tostring(frameName))
        end
    end

    -- don't try to register anything that isn't "buttonish"
    if frame and not frame.RegisterForClicks then
        return
    end

    -- skip the nameplates, they're TEHBROKEN
    if frame and frame.GetName and frame:GetName():match("^NamePlate") then
        return
    end

    ClickCastFrames[frame] = true
end

function addon:Enable_BlizzCompactUnitFrames()
    if not addon.settings.blizzframes.compactraid then
        return
    end

    hooksecurefunc("CompactUnitFrame_SetUpFrame", function(frame, ...)
        -- For the moment we cannot handle 'forbidden' frames
        if frame.IsForbidden and frame:IsForbidden() then
            return
        end

        local name = frame and frame.GetName and frame:GetName()
        for i = 1, 3 do
            local buff = _G[name .. "Buff" .. i]
            local debuff = _G[name .. "Debuff" .. i]
            local dispel = _G[name .. "DispelDebuff" .. i]
			local statusIcon = _G[name .. "CenterStatusIcon" .. i]

            if buff then enable(buff) end
            if debuff then enable(debuff) end
            if dispel then enable(dispel) end
			if statusIcon then enable(statusIcon) end
        end
        enable(frame)
    end)
end

function addon:Enable_BlizzArenaFrames()
    if not addon.settings.blizzframes.arena then
        return
    end

    if not addon.compatRelease then
        return
    end

    local frames = {
        "ArenaEnemyFrame1",
        "ArenaEnemyFrame2",
        "ArenaEnemyFrame3",
        "ArenaEnemyFrame4",
        "ArenaEnemyFrame5",
    }
    for idx, frame in ipairs(frames) do
        enable(frame)
    end
end

function addon:Enable_BlizzSelfFrames()
    local frames = {
        "PlayerFrame",
        "PetFrame",
        "TargetFrame",
        "TargetFrameToT",
    }

    if addon.compatRelease then
        table.insert(frames, "FocusFrame")
        table.insert(frames, "FocusFrameToT")
    end

    for idx, frame in ipairs(frames) do
        if addon.settings.blizzframes[frame] then
            enable(frame)
        end
    end
end

function addon:Enable_BlizzPartyFrames()
    if not addon.settings.blizzframes.party then
        return
    end

    local frames = {
        "PartyMemberFrame1",
		"PartyMemberFrame2",
		"PartyMemberFrame3",
		"PartyMemberFrame4",
        --"PartyMemberFrame5",
		"PartyMemberFrame1PetFrame",
		"PartyMemberFrame2PetFrame",
		"PartyMemberFrame3PetFrame",
        "PartyMemberFrame4PetFrame",
        --"PartyMemberFrame5PetFrame",
    }
    for idx, frame in ipairs(frames) do
        enable(frame)
    end
end


function addon:Enable_BlizzBossFrames()
    if not addon.settings.blizzframes.boss then
        return
    end

    local frames = {
        "Boss1TargetFrame",
        "Boss2TargetFrame",
        "Boss3TargetFrame",
        "Boss4TargetFrame",
    }
    for idx, frame in ipairs(frames) do
        enable(frame)
    end
end


function addon:EnableBlizzardFrames()
    self:Enable_BlizzCompactUnitFrames()
    self:Enable_BlizzSelfFrames()
    self:Enable_BlizzPartyFrames()
    self:Enable_BlizzBossFrames()

    local waitForAddon = {}

    if addon.compatRelease then
        if IsAddOnLoaded("Blizzard_ArenaUI") then
            self:Enable_BlizzArenaFrames()
        else
            waitForAddon["Blizzard_ArenaUI"] = "Enable_BlizzArenaFrames"
        end
    end

    if next(waitForAddon) then
        local frame = CreateFrame("Frame")
        frame:RegisterEvent("ADDON_LOADED")
        frame:SetScript("OnEvent", function(frame, event, ...)
            if waitForAddon[...] then
                self[waitForAddon[...]](self)
            end
        end)

        if not next(waitForAddon) then
            frame:UnregisterEvent("ADDON_LOADED")
            frame:SetScript("OnEvent", nil)
        end
    end
end
