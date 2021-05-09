NugRunningGUI = CreateFrame("Frame","NugRunningGUI")
local NugRunning = NugRunning
local L = NugRunning.L

-- NugRunningGUI:SetScript("OnEvent", function(self, event, ...)
    -- self[event](self, event, ...)
-- end)
-- NugRunningGUI:RegisterEvent("ADDON_LOADED")

local AceGUI = LibStub("AceGUI-3.0")
local COMBATLOG_OBJECT_AFFILIATION_PARTY_OR_RAID = COMBATLOG_OBJECT_AFFILIATION_RAID + COMBATLOG_OBJECT_AFFILIATION_PARTY

local LSM = LibStub("LibSharedMedia-3.0")

local newFeatureIcon = "|TInterface\\OptionsFrame\\UI-OptionsFrame-NewFeatureIcon:0:0:0:-1|t"

function NugRunningGUI.SlashCmd(msg)
    NugRunningGUI.frame:Show()
end

local sortfunc = function(a,b)
    if a.order == b.order then
        return a.value < b.value
    else
        return a.order < b.order
    end
end

function NugRunningGUI.GenerateCategoryTree(self, isGlobal, category)
    local _,class = UnitClass("player")
    local custom = isGlobal and NugRunningConfigCustom["GLOBAL"] or NugRunningConfigCustom[class]

    local t = {}

    for spellID, opts in pairs(NugRunningConfigMerged[category]) do
        if not NugRunningConfigMerged.spellClones[spellID] or category == "event_timers" then
            if (isGlobal and opts.global) or (not isGlobal and not opts.global) and not opts._hidden then
                -- local name = (opts.name == "" or not opts.name) and (GetSpellInfo(spellID) or "Unknown") or opts.name
                local name = GetSpellInfo(spellID) or opts.name or "Unknown"
                local custom_opts = custom[category] and custom[category][spellID]
                local status
                local order = 5
                if not custom_opts or not next(custom_opts) then
                    status = nil
                elseif custom_opts.disabled then
                    status = "|cffff0000[D] |r"
                    order = 6
                elseif not NugRunningConfig[category][spellID] then
                    status = "|cff33ff33[A] |r"
                    order = 1
                else
                    status = "|cffffaa00[M] |r"
                    order = 2
                end
                local text = status and status..name or name
                local texture = opts.isItem and select(5,GetItemInfoInstant(spellID)) or  GetSpellTexture(spellID)
                table.insert(t, {
                    value = spellID,
                    text = text,
                    icon = texture,
                    order = order,
                })
            end
        end
    end
    table.sort(t, sortfunc)
    return t
end


local SpellForm
local CooldownForm
local NewTimerForm


function NugRunningGUI.CreateNewTimerForm(self)
    local Form = AceGUI:Create("InlineGroup")
    Form:SetFullWidth(true)
    -- Form:SetHeight(0)
    Form:SetLayout("Flow")
    Form.opts = {}
    Form.controls = {}

    Form.ShowNewTimer = function(self, category)
        assert(category)
        local Frame = NugRunningGUI.frame
        local class = self.class

        Frame.rpane:Clear()
        if not SpellForm then
            SpellForm = NugRunningGUI:CreateSpellForm()
        end
        local opts = {}
        if class == "GLOBAL" then opts.global = true end
        NugRunningGUI:FillForm(SpellForm, class, category, nil, opts, true)
        Frame.rpane:AddChild(SpellForm)
    end

    local newspell = AceGUI:Create("Button")
    newspell:SetText(L"New Spell")
    newspell:SetFullWidth(true)
    newspell:SetCallback("OnClick", function(self, event)
        self.parent:ShowNewTimer("spells")
    end)
    Form:AddChild(newspell)
    Form.controls.newspell = newspell

    local newcooldown = AceGUI:Create("Button")
    newcooldown:SetText(L"New Cooldown")
    newcooldown:SetFullWidth(true)
    newcooldown:SetCallback("OnClick", function(self, event)
        self.parent:ShowNewTimer("cooldowns")
    end)
    Form:AddChild(newcooldown)
    Form.controls.newcooldown = newcooldown

    local newitemcooldown = AceGUI:Create("Button")
    newitemcooldown:SetText(L"New Item Cooldown")
    newitemcooldown:SetFullWidth(true)
    newitemcooldown:SetCallback("OnClick", function(self, event)
        self.parent:ShowNewTimer("itemcooldowns")
    end)
    Form:AddChild(newitemcooldown)
    Form.controls.newitemcooldown = newitemcooldown

    local newcast = AceGUI:Create("Button")
    newcast:SetText(L"New Cast")
    newcast:SetFullWidth(true)
    newcast:SetCallback("OnClick", function(self, event)
        self.parent:ShowNewTimer("casts")
    end)
    Form:AddChild(newcast)
    Form.controls.newcast = newcast

    local newevent = AceGUI:Create("Button")
    newevent:SetText(L"New Event Timer")
    newevent:SetFullWidth(true)
    newevent:SetCallback("OnClick", function(self, event)
        self.parent:ShowNewTimer("event_timers")
    end)
    Form:AddChild(newevent)
    Form.controls.newevent = newevent

    return Form
end

local tooltipOnEnter = function(self, event)
    GameTooltip:SetOwner(self.frame, "ANCHOR_TOPLEFT")
    GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, 1);
    GameTooltip:Show();
end
local tooltipOnLeave = function(self, event)
    GameTooltip:Hide();
end
local function AddTooltip(widget, tooltipText)
    widget.tooltipText = tooltipText
    widget:SetCallback("OnEnter", tooltipOnEnter)
    widget:SetCallback("OnLeave", tooltipOnLeave)
end

local clean = function(delta, default_opts, property, emptyValue)
    if delta[property] == emptyValue and default_opts[property] == nil then delta[property] = nil end
end

function NugRunningGUI.CreateCommonForm(self)
    local Form = AceGUI:Create("ScrollFrame")
    Form:SetFullWidth(true)
    -- Form:SetHeight(0)
    Form:SetLayout("Flow")
    Form.opts = {}
    Form.controls = {}




    local save = AceGUI:Create("Button")
    save:SetText(L"Save")
    save:SetRelativeWidth(0.5)
    save:SetCallback("OnClick", function(self, event)
        local p = self.parent
        local class = p.class
        local category = p.category
        local spellID = p.id
        local opts = p.opts

        if not spellID then -- make new timer
            spellID = tonumber(self.parent.controls.spellID:GetText())
            if not spellID or not tonumber(spellID) then
                --invalid spell id string
                return
            end

            if category == "itemcooldowns" then
                if not GetItemInfoInstant(spellID) then return end -- item doesn't exist
            else
                if not GetSpellInfo(spellID) then return end -- spell doesn't exist
            end

            if not opts.name then
                if opts.isItem then
                    opts.name = GetItemInfo(spellID) or "Item"
                else
                    opts.name = GetSpellInfo(spellID)
                end
            end
            if category == "spells" and not opts.duration then
                opts.duration = 3
            end
            if category == "event_timers" and not opts.duration then
                opts.duration = 3
            end

            opts.spellID = nil
        end

        if category == "event_timers" and (opts.event == "" or not opts.event) then
            return
        end

        local default_opts = NugRunningConfig[category][spellID]
        if default_opts then
            clean(opts, default_opts, "short", false)
            clean(opts, default_opts, "ghost", false)
            clean(opts, default_opts, "preghost", false)
            clean(opts, default_opts, "timeless", false)
            clean(opts, default_opts, "singleTarget", false)
            clean(opts, default_opts, "multiTarget", false)
            clean(opts, default_opts, "scale", 1)
            clean(opts, default_opts, "shine", false)
            clean(opts, default_opts, "shinerefresh", false)
            clean(opts, default_opts, "nameplates", false)
            clean(opts, default_opts, "group", "default")
            clean(opts, default_opts, "affiliation", COMBATLOG_OBJECT_AFFILIATION_MINE)
            clean(opts, default_opts, "fixedlen", false)
            clean(opts, default_opts, "priority", false)
            clean(opts, default_opts, "scale_until", false)
            clean(opts, default_opts, "hide_until", false)
            clean(opts, default_opts, "maxtimers", false)
            clean(opts, default_opts, "color2", false)
            clean(opts, default_opts, "arrow", false)
            clean(opts, default_opts, "overlay", false)
            clean(opts, default_opts, "tick", false)
            clean(opts, default_opts, "recast_mark", false)
            clean(opts, default_opts, "effect", "NONE")
            clean(opts, default_opts, "ghosteffect", "NONE")
            clean(opts, default_opts, "glowtime", false)
            clean(opts, default_opts, "glow2time", false)
            clean(opts, default_opts, "effecttime", false)
            clean(opts, default_opts, "clones", false)
            clean(opts, default_opts, "event", false)
            clean(opts, default_opts, "stackcolor", false)
        end
        if opts.overlay and (not default_opts or not default_opts.overlay) and (not opts.overlay[1] or not opts.overlay[2]) then opts.overlay = nil end
        -- PRESAVE = p.opts
        local delta = CopyTable(opts)
        delta.timer = nil -- important, clears runtime data

        -- remove clones of the previous version of the spell
        local oldOriginalSpell = NugRunningConfigMerged[category][spellID]
        if oldOriginalSpell and oldOriginalSpell.clones then
            for i, additionalSpellID in ipairs(oldOriginalSpell.clones) do
                NugRunningConfigMerged[category][additionalSpellID] = nil
                NugRunningConfigMerged.spellClones[additionalSpellID] = nil
            end
        end
        ----------

        if default_opts then
            if delta.clones then NugRunning.RemoveDefaultsPreserve(delta.clones, default_opts.clones) end
            NugRunning.RemoveDefaults(delta, default_opts)
            NugRunningConfigMerged[category][spellID] = CopyTable(default_opts)
            -- if delta.disabled then
                -- NugRunningConfigMerged[category][spellID] = nil
            -- else
            NugRunning.MergeTable(NugRunningConfigMerged[category][spellID], delta, true)
            -- end
        else
            NugRunningConfigMerged[category][spellID] = delta
            delta.isAdded = true
        end

        NugRunning:UpdateSpellNameToIDTable()

        -- fill up spell clones of the new version
        local originalSpell = NugRunningConfigMerged[category][spellID]
        if originalSpell.clones then
            for i, additionalSpellID in ipairs(originalSpell.clones) do
                NugRunningConfigMerged[category][additionalSpellID] = originalSpell
                NugRunningConfigMerged.spellClones[additionalSpellID] = true
            end
        end
        ----------

        NugRunningConfigCustom[class] = NugRunningConfigCustom[class] or {}
        NugRunningConfigCustom[class][category] = NugRunningConfigCustom[class][category] or {}
        if not next(delta) then delta = nil end
        NugRunningConfigCustom[class][category][spellID] = delta

        NugRunningGUI.frame.tree:UpdateSpellTree()
        NugRunningGUI.frame.tree:SelectByPath(class, category, spellID)
    end)
    Form:AddChild(save)

    local delete = AceGUI:Create("Button")
    delete:SetText(L"Delete")
    save:SetRelativeWidth(0.45)
    delete:SetCallback("OnClick", function(self, event)
        local p = self.parent
        local class = p.class
        local category = p.category
        local spellID = p.id
        -- local opts = p.opts
        if NugRunningConfigCustom[class][category] then
            NugRunningConfigCustom[class][category][spellID] = nil
        end
        NugRunningConfigMerged[category][spellID] = NugRunningConfig[category][spellID]

        NugRunningGUI.frame.tree:UpdateSpellTree()
        NugRunningGUI.frame.tree:SelectByPath(class, category, spellID)
    end)
    Form.controls.delete = delete
    Form:AddChild(delete)

    local spellID = AceGUI:Create("EditBox")
    spellID:SetLabel(L"Spell ID")
    spellID:SetDisabled(true)
    spellID:DisableButton(true)
    spellID:SetRelativeWidth(0.2)
    spellID:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if (v and v > 0 and GetSpellInfo(v)) or self.parent.opts.isItem then
            self.parent.opts["spellID"] = v
            self.editbox:SetTextColor(1,1,1)
        else
            self.editbox:SetTextColor(1,0,0)
        end
        if value == "" then self.parent.opts["spellID"] = nil end
    end)
    -- spellID:SetHeight(32)
    -- spellID.alignoffset = 30
    Form.controls.spellID = spellID
    Form:AddChild(spellID)

    local disabled = AceGUI:Create("CheckBox")
    disabled:SetLabel(L"Disabled")
    disabled:SetRelativeWidth(0.4)
    disabled:SetCallback("OnValueChanged", function(self, event, value)
        if value == false then value = nil end
        self.parent.opts["disabled"] = value
    end)
    -- disabled.alignoffset = 10
    -- disabled:SetHeight(36)
    Form.controls.disabled = disabled
    Form:AddChild(disabled)

    local short = AceGUI:Create("EditBox")
    short:SetLabel(L"Short Name")
    -- short:SetFullWidth(true)
    short:SetRelativeWidth(0.29)
    short:SetCallback("OnEnterPressed", function(self, event, value)
        if value == "" then
            self.parent.opts["short"] = false
        else
            self.parent.opts["short"] = value
        end
    end)
    -- short.alignoffset = 60
    -- short:SetHeight(32)
    Form.controls.short = short
    Form:AddChild(short)
    AddTooltip(short, "Shortened label, overrides full name")

    local name = AceGUI:Create("EditBox")
    name:SetLabel(L"Name")
    -- name:SetFullWidth(true)
    name:SetRelativeWidth(0.5)
    name:SetCallback("OnEnterPressed", function(self, event, value)
        self.parent.opts["name"] = value
    end)
    -- name:SetHeight(32)
    Form.controls.name = name
    Form:AddChild(name)
    AddTooltip(name, "Custom timer label.\nLeave blank to hide.")

    local duration = AceGUI:Create("EditBox")
    duration:SetLabel(L"Duration")
    duration:SetDisabled(true)
    duration:SetRelativeWidth(0.19)
    duration:DisableButton(true)
    duration:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v and v > 0 then
            self.parent.opts["duration"] = v
        elseif value == "" then
            self.parent.opts["duration"] = 3
            self:SetText("3")
        end
    end)
    Form.controls.duration = duration
    Form:AddChild(duration)
    AddTooltip(duration, "Duration to fallback to when it can't be retrieved from unit (very rare)")

    local fixedlen = AceGUI:Create("EditBox")
    fixedlen:SetLabel(L"Fixed Duration")
    fixedlen:SetRelativeWidth(0.2)
    fixedlen:DisableButton(true)
    fixedlen:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v and v > 0 then
            self.parent.opts["fixedlen"] = v
        elseif value == "" then
            self.parent.opts["fixedlen"] = false
            self:SetText("")
        end
    end)
    Form.controls.fixedlen = fixedlen
    Form:AddChild(fixedlen)
    AddTooltip(fixedlen, L"Set static timer max duration to align timer decay speed with other timers")


    local prio = AceGUI:Create("EditBox")
    prio:SetLabel(L"Priority")
    -- prio:SetFullWidth(true)
    prio:SetRelativeWidth(0.15)
    prio:DisableButton(true)
    prio:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v then
            self.parent.opts["priority"] = v
        elseif value == "" then
            self.parent.opts["priority"] = false
            self:SetText("")
        end
    end)
    -- prio:SetHeight(32)
    Form.controls.priority = prio
    Form:AddChild(prio)
    AddTooltip(prio, "Positive or negative numeric value.\nDefault priority is 0.\nTimers with equal priority sorted by remaining time.")

    local group = AceGUI:Create("Dropdown")
    group:SetLabel(L"Group")

    local groupList = {
        default = "Default"
    }
    local groupOrder = { "default" }
    -- for anchor,groups in pairs(NugRunningConfig.anchors) do
    --     for i, group in ipairs(groups) do
    --         local name = group.name
    --         if name ~= "player" and name ~= "target" and name ~= "offtargets" then
    --             groupList[name] = name
    --             table.insert(groupOrder, name)
    --         end
    --     end
    -- end
    for name, group in pairs(NugRunning.db.groups) do
        if name ~= "player" and name ~= "target" and name ~= "offtargets" then
            groupList[name] = name
            table.insert(groupOrder, name)
        end
    end


    group:SetList(groupList, groupOrder)
    group:SetRelativeWidth(0.30)
    group:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["group"] = value
    end)
    -- group:SetHeight(32)
    Form.controls.group = group
    Form:AddChild(group)
    AddTooltip(group, L"Assign to timer group")

    local scale = AceGUI:Create("Slider")
    scale:SetLabel(L"Scale")
    scale:SetSliderValues(0.3, 2, 0.05)
    scale:SetRelativeWidth(0.30)
    scale:SetCallback("OnValueChanged", function(self, event, value)
        local v = tonumber(value)
        if v and v >= 0.3 and v <= 2 then
            self.parent.opts["scale"] = v
        else
            self.parent.opts["scale"] = 1
            self:SetText(self.parent.opts.scale or "1")
        end
    end)
    Form.controls.scale = scale
    Form:AddChild(scale)
    AddTooltip(scale, L"Vertical timer scale")

    local scale_until = AceGUI:Create("EditBox")
    scale_until:SetLabel(L"Minimize Until")
    scale_until:SetRelativeWidth(0.22)
    scale_until:DisableButton(true)
    scale_until:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v then
            self.parent.opts["scale_until"] = v
        elseif value == "" then
            self.parent.opts["scale_until"] = false
            self:SetText("")
        end
    end)
    Form.controls.scale_until = scale_until
    Form:AddChild(scale_until)
    AddTooltip(scale_until, L"Minimize until duration is less than X")

    local color = AceGUI:Create("ColorPicker")
    color:SetLabel(L"Color")
    color:SetRelativeWidth(0.20)
    color:SetHasAlpha(false)
    color:SetCallback("OnValueConfirmed", function(self, event, r,g,b,a)
        self.parent.opts["color"] = {r,g,b}
    end)
    Form.controls.color = color
    Form:AddChild(color)

    local color2 = AceGUI:Create("ColorPicker")
    color2:SetLabel(L"End Color")
    color2:SetRelativeWidth(0.20)
    color2:SetHasAlpha(false)
    color2:SetCallback("OnValueConfirmed", function(self, event, r,g,b,a)
        self.parent.opts["color2"] = {r,g,b}
    end)
    Form.controls.color2 = color2
    Form:AddChild(color2)
    AddTooltip(color2, L"if present, timer color shifts from base color to end color as it's progressing")

    local c2r = AceGUI:Create("Button")
    c2r:SetText("X")
    c2r:SetRelativeWidth(0.1)
    c2r:SetCallback("OnClick", function(self, event)
        self.parent.opts["color2"] = false
        self.parent.controls.color2:SetColor(1,1,1,0)
    end)
    Form.controls.c2r = c2r
    Form:AddChild(c2r)
    AddTooltip(c2r, L"Remove End Color")

    local arrow = AceGUI:Create("ColorPicker")
    arrow:SetLabel(L"Highlight")
    arrow:SetRelativeWidth(0.20)
    arrow:SetHasAlpha(false)
    arrow:SetCallback("OnValueConfirmed", function(self, event, r,g,b,a)
        self.parent.opts["arrow"] = {r,g,b}
    end)
    Form.controls.arrow = arrow
    Form:AddChild(arrow)
    AddTooltip(arrow, L"Timer highlight mark color")

    local ar = AceGUI:Create("Button")
    ar:SetText("X")
    ar:SetRelativeWidth(0.1)
    ar:SetCallback("OnClick", function(self, event)
        self.parent.opts["arrow"] = false
        self.parent.controls.arrow:SetColor(1,1,1,0)
    end)
    Form.controls.ar = ar
    Form:AddChild(ar)
    AddTooltip(ar, L"Remove Highlight Color")

    local hide_until = AceGUI:Create("EditBox")
    hide_until:SetLabel(L"Hide Until")
    hide_until:SetRelativeWidth(0.17)
    hide_until:DisableButton(true)
    hide_until:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v then
            self.parent.opts["hide_until"] = v
        elseif value == "" then
            self.parent.opts["hide_until"] = false
            self:SetText("")
        end
    end)
    Form.controls.hide_until = hide_until
    Form:AddChild(hide_until)
    AddTooltip(hide_until, L"Hide until duration is less than X\n(Only for cooldowns)")



    local ghost = AceGUI:Create("EditBox")
    ghost:SetLabel(L"Ghost")
    ghost:SetRelativeWidth(0.17)
    ghost:DisableButton(true)
    ghost:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v then
            self.parent.opts["ghost"] = v
            if v == 3 then self.parent.opts["ghost"] = true end
        elseif value == "" then
            self.parent.opts["ghost"] = false
            self:SetText("")
        end
    end)
    Form.controls.ghost = ghost
    Form:AddChild(ghost)
    AddTooltip(ghost, L"Timer remains for X seconds after expiring")

    local preghost = AceGUI:Create("CheckBox")
    preghost:SetLabel(L"PreGhost")
    preghost:SetRelativeWidth(0.24)
    preghost:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["preghost"] = value
    end)
    Form.controls.preghost = preghost
    Form:AddChild(preghost)
    AddTooltip(preghost, L"Create empty bar when switching to target without existing timer")

    local shine = AceGUI:Create("CheckBox")
    shine:SetLabel(L"Shine")
    shine:SetRelativeWidth(0.24)
    shine:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["shine"] = value
    end)
    Form.controls.shine = shine
    Form:AddChild(shine)
    AddTooltip(shine, L"Shine when created")

    local shinerefresh = AceGUI:Create("CheckBox")
    shinerefresh:SetLabel(L"On Refresh")
    shinerefresh:SetRelativeWidth(0.24)
    shinerefresh:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["shinerefresh"] = value
    end)
    Form.controls.shinerefresh = shinerefresh
    Form:AddChild(shinerefresh)
    AddTooltip(shinerefresh, L"Shine when refreshed")




    local maxtimers = AceGUI:Create("EditBox")
    maxtimers:SetLabel(L"Max Timers")
    maxtimers:SetRelativeWidth(0.25)
    maxtimers:DisableButton(true)
    maxtimers:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v and v > 0 then
            self.parent.opts["maxtimers"] = v
            self.parent.controls.multiTarget:SetValue(false)
            self.parent.opts["multiTarget"] = false
            self.parent.controls.singleTarget:SetValue(false)
            self.parent.opts["singleTarget"] = false
        elseif value == "" then
            self.parent.opts["maxtimers"] = false
            self:SetText("")
        end
    end)
    Form.controls.maxtimers = maxtimers
    Form:AddChild(maxtimers)
    AddTooltip(maxtimers, L"Maximum amount of timers that can exist.\nUsed to prevent spam.")


    local singleTarget = AceGUI:Create("CheckBox")
    singleTarget:SetLabel(L"Single-Target")
    singleTarget:SetRelativeWidth(0.3)
    singleTarget:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["singleTarget"] = value
        if value then
            self.parent.controls.multiTarget:SetValue(false)
            self.parent.opts["multiTarget"] = false
            self.parent.controls.maxtimers:SetText("")
            self.parent.opts["maxtimers"] = false
        end
    end)
    Form.controls.singleTarget = singleTarget
    Form:AddChild(singleTarget)
    AddTooltip(singleTarget, L"Timer is only displayed if it's on the current target or you have no other target.\nUsed to prevent spam.")

    local multiTarget = AceGUI:Create("CheckBox")
    multiTarget:SetLabel(L"Multi-Target")
    multiTarget:SetRelativeWidth(0.3)
    multiTarget:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["multiTarget"] = value
        if value then
            self.parent.controls.singleTarget:SetValue(false)
            self.parent.opts["singleTarget"] = false
            self.parent.controls.maxtimers:SetText("")
            self.parent.opts["maxtimers"] = false
        end
    end)
    Form.controls.multiTarget = multiTarget
    Form:AddChild(multiTarget)
    AddTooltip(multiTarget, L"For AoE debuffs, condensing timers from multiple targets into one.\nUsed to prevent spam.")


    local affiliation = AceGUI:Create("Dropdown")
    affiliation:SetLabel(L"Affiliation")
    affiliation:SetList({
        [COMBATLOG_OBJECT_AFFILIATION_MINE] = "Player",
        [COMBATLOG_OBJECT_AFFILIATION_PARTY_OR_RAID] = "Raid",
        [COMBATLOG_OBJECT_AFFILIATION_OUTSIDER] = "Any"
    }, { 1, 6, 8})
    affiliation:SetRelativeWidth(0.40)
    affiliation:SetCallback("OnValueChanged", function(self, event, value)
        if value == COMBATLOG_OBJECT_AFFILIATION_MINE then value = nil end
        self.parent.opts["affiliation"] = value
    end)
    Form.controls.affiliation = affiliation
    Form:AddChild(affiliation)
    AddTooltip(affiliation, L"Limit events to self/raid/everyone")

    local nameplates = AceGUI:Create("CheckBox")
    nameplates:SetLabel(L"Show on Nameplates")
    nameplates:SetRelativeWidth(0.56)
    nameplates:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["nameplates"] = value
    end)
    Form.controls.nameplates = nameplates
    Form:AddChild(nameplates)
    AddTooltip(nameplates, L"Mirror timer on nameplates.\nMay need /reload to enable nameplate functionality.")




    local overlay_start = AceGUI:Create("EditBox")
    overlay_start:SetLabel(L"Overlay Start")
    overlay_start:SetRelativeWidth(0.20)
    -- overlay_start:DisableButton(true)
    overlay_start:SetCallback("OnEnterPressed", function(self, event, value)
        local v
        if value == "tick" or value == "tickend" or value ==  "end" or value == "gcd" then
            v = value
        else
            v = tonumber(value)
            if v and v < 0 then v = nil end
        end
        if v then
            if not self.parent.opts.overlay then
                self.parent.opts.overlay = {v, nil, 0.3, nil}
            else
                self.parent.opts.overlay[1] = v
            end
        else
            self.parent.opts["overlay"] = false
            self.parent.controls.overlay_start:SetText("")
            self.parent.controls.overlay_end:SetText("")
            self.parent.controls.overlay_haste:SetValue(false)
        end
    end)
    Form.controls.overlay_start = overlay_start
    Form:AddChild(overlay_start)
    AddTooltip(overlay_start, L"Overlay marks time intervals.\nSpecial values:".."\ngcd\ntick")

    local overlay_end = AceGUI:Create("EditBox")
    overlay_end:SetLabel(L"Overlay End")
    overlay_end:SetRelativeWidth(0.20)
    -- overlay_end:DisableButton(true)
    overlay_end:SetCallback("OnEnterPressed", function(self, event, value)
        local v
        if value == "tick" or value == "tickend" or value ==  "end" or value == "gcd" then
            v = value
        else
            v = tonumber(value)
            if v and v <= 0 then v = nil end
        end
        if v then
            if not self.parent.opts.overlay then
                self.parent.opts.overlay = {nil, v, 0.3, nil}
            else
                self.parent.opts.overlay[2] = v
            end
        else
            self.parent.opts["overlay"] = false
            self.parent.controls.overlay_start:SetText("")
            self.parent.controls.overlay_end:SetText("")
            self.parent.controls.overlay_haste:SetValue(false)
        end
    end)
    Form.controls.overlay_end = overlay_end
    Form:AddChild(overlay_end)
    AddTooltip(overlay_end, L"Overlay marks time intervals.\nSpecial values:".."\ntickend\nend")

	local overlay_haste = AceGUI:Create("CheckBox")
	overlay_haste:SetLabel(L"Haste Reduced")
	overlay_haste:SetDisabled(true)
	overlay_haste:SetRelativeWidth(0.3)
	overlay_haste:SetCallback("OnValueChanged", function(self, event, value)
		if not self.parent.opts.overlay then
			self.parent.opts.overlay = {nil, nil, 0.3, value}
		else
            self.parent.opts.overlay[4] = value
		end
	end)
	Form.controls.overlay_haste = overlay_haste
	Form:AddChild(overlay_haste)
	AddTooltip(overlay_haste, L"Overlay length is reduced by haste.")


	local pandemic = AceGUI:Create("Button")
	pandemic:SetText(L"Pandemic")
	pandemic:SetDisabled(true)
	pandemic:SetRelativeWidth(0.25)
	pandemic:SetCallback("OnClick", function(self, event)
		local duration = self.parent.opts.duration
		local m = duration*0.3 - 0.1
		self.parent.opts.overlay = {0, m, 0.25}
		self.parent.opts.recast_mark = m
		self.parent.controls.overlay_end:SetText(m)
		self.parent.controls.overlay_start:SetText(0)
		self.parent.controls.overlay_haste:SetValue(false)
		self.parent.controls.recast_mark:SetText(m)
	end)
	Form.controls.pandemic = pandemic
	Form:AddChild(pandemic)
	AddTooltip(pandemic, L"Calculate pandemic overlay from duration")

		----------------------------------
	--- STACKCOLOR
	----------------------------------

	local useStackcolor = AceGUI:Create("CheckBox")
	useStackcolor:SetLabel(L"Color By Stack")
	useStackcolor:SetRelativeWidth(0.3)
	useStackcolor:SetCallback("OnValueChanged", function(self, event, value)
		if value == false then
			self.parent.opts["stackcolor"] = false
			for i=1,5 do
				local widgetName = "stackcolor"..i
				self.parent.controls[widgetName]:SetDisabled(true)
				self.parent.controls[widgetName]:SetColor(0,0,0)
			end
		else
			self.parent.opts["stackcolor"] = {
				{ 1,1,1 },
				{ 1,1,1 },
				{ 1,1,1 },
				{ 1,1,1 },
				{ 1,1,1 },
			}
			for i=1,5 do
				local widgetName = "stackcolor"..i
				self.parent.controls[widgetName]:SetDisabled(false)
				self.parent.controls[widgetName]:SetColor(1,1,1)
			end
		end
	end)
	Form.controls.useStackcolor = useStackcolor
	Form:AddChild(useStackcolor)

	local AddStackColor = function(i)
		local stc1 = AceGUI:Create("ColorPicker")
		stc1:SetRelativeWidth(0.12)
		stc1.id = i
		stc1:SetHasAlpha(false)
		stc1:SetCallback("OnValueConfirmed", function(self, event, r,g,b,a)
			self.parent.opts["stackcolor"] = self.parent.opts["stackcolor"] or {}
			self.parent.opts["stackcolor"][self.id] = {r,g,b}
		end)
		local widgetName = "stackcolor"..i
		Form.controls[widgetName] = stc1
		Form:AddChild(stc1)
	end

	for i=1,5 do
		AddStackColor(i)
	end

	----------------------------------
	--- END STACKCOLOR
	----------------------------------

	local tick = AceGUI:Create("EditBox")
	tick:SetLabel(L"Tick")
	tick:SetRelativeWidth(0.15)
    tick:DisableButton(true)
    tick:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v then
            self.parent.opts["tick"] = v
            self.parent.opts["recast_mark"] = false
            self.parent.controls.recast_mark:SetText("")
        elseif value == "" then
            self.parent.opts["tick"] = false
            self:SetText("")
        end
    end)
    Form.controls.tick = tick
    Form:AddChild(tick)
    AddTooltip(tick, L"Tick length.\nLeave empty to disable ticks.\nMutually exclusive with recast mark.")

    local recast_mark = AceGUI:Create("EditBox")
    recast_mark:SetLabel(L"Recast Mark")
    recast_mark:SetRelativeWidth(0.15)
    recast_mark:DisableButton(true)
    recast_mark:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v and v > 0 then
            self.parent.opts["recast_mark"] = v
            self.parent.opts["tick"] = false
            self.parent.controls.tick:SetText("")
        elseif value == "" then
            self.parent.opts["recast_mark"] = false
            self:SetText("")
        end
    end)
    Form.controls.recast_mark = recast_mark
    Form:AddChild(recast_mark)
    AddTooltip(recast_mark, L"Place mark on a timer, that will shine when passed through")



    local effectsList = {
        ["NONE"] = "<NONE>"
    }
    local effectsOrder = { "NONE" }
    for k,v in pairs(NugRunningConfig.effects) do
        effectsList[k] = k
        table.insert(effectsOrder, k)
    end

    local effect = AceGUI:Create("Dropdown")
    effect:SetLabel(L"3D Effect")
    effect:SetList(effectsList, effectsOrder)
    effect:SetRelativeWidth(0.32)
    effect:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["effect"] = value
    end)
    Form.controls.effect = effect
    Form:AddChild(effect)
    AddTooltip(effect, L"Show 3D effect near timer")

    local ghosteffect = AceGUI:Create("Dropdown")
    ghosteffect:SetLabel(L"Ghost 3D Effect")
    ghosteffect:SetList(effectsList, effectsOrder)
    ghosteffect:SetRelativeWidth(0.32)
    ghosteffect:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["ghosteffect"] = value
    end)
    Form.controls.ghosteffect = ghosteffect
    Form:AddChild(ghosteffect)
    AddTooltip(ghosteffect, L"Effect during ghost phase")

    local glowtime = AceGUI:Create("EditBox")
    glowtime:SetLabel(L"Glow At")
    glowtime:SetRelativeWidth(0.15)
    glowtime:DisableButton(true)
    glowtime:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v then
            self.parent.opts["glowtime"] = v
        elseif value == "" then
            self.parent.opts["glowtime"] = false
            self:SetText("")
        end
    end)
    Form.controls.glowtime = glowtime
    Form:AddChild(glowtime)
    AddTooltip(glowtime, L"Time when timer starts glowing")

    local glow2time = AceGUI:Create("EditBox")
    glow2time:SetLabel(L"Spin At")
    glow2time:SetRelativeWidth(0.15)
    glow2time:DisableButton(true)
    glow2time:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v then
            self.parent.opts["glow2time"] = v
        elseif value == "" then
            self.parent.opts["glow2time"] = false
            self:SetText("")
        end
    end)
    Form.controls.glow2time = glow2time
    Form:AddChild(glow2time)
    AddTooltip(glow2time, L"Time when highlight starts spinning.\n(Requires highlight color enabled)")

    local effecttime = AceGUI:Create("EditBox")
    effecttime:SetLabel(L"Effect At")
    effecttime:SetRelativeWidth(0.20)
    effecttime:DisableButton(true)
    effecttime:SetCallback("OnTextChanged", function(self, event, value)
        local v = tonumber(value)
        if v then
            self.parent.opts["effecttime"] = v
        elseif value == "" then
            self.parent.opts["effecttime"] = false
            self:SetText("")
        end
    end)
    Form.controls.effecttime = effecttime
    Form:AddChild(effecttime)
    AddTooltip(effecttime, L"Time when 3D effect starts being shown")

    local timeless = AceGUI:Create("CheckBox")
    timeless:SetLabel(L"Infinite Timer")
    timeless:SetRelativeWidth(0.9)
    timeless:SetCallback("OnValueChanged", function(self, event, value)
        self.parent.opts["timeless"] = value
    end)
    Form.controls.timeless = timeless
    Form:AddChild(timeless)
    AddTooltip(timeless, L"Marks bar as infinite, for spells with indefinite duration.")

    local clones = AceGUI:Create("EditBox")
    clones:SetLabel(L"Additional Spell IDs")
    clones:SetRelativeWidth(0.9)
    clones:SetCallback("OnEnterPressed", function(self, event, value)
        local cloneList = {}
        for spellID in string.gmatch(value, "%d+") do
            table.insert(cloneList, tonumber(spellID))
        end
        if next(cloneList) then
            self.parent.opts["clones"] = cloneList
        else
            self.parent.opts["clones"] = false
            self:SetText("")
        end
    end)
    Form.controls.clones = clones
    Form:AddChild(clones)
    AddTooltip(clones, L"Spell ID list of clones / spell ranks" )

    local event = AceGUI:Create("EditBox")
    event:SetLabel(L"Combat Log Event")
    event:SetRelativeWidth(0.9)
    event:SetCallback("OnEnterPressed", function(self, event, value)
        if value == "" then
            self.parent.opts["event"] = false
        else
            self.parent.opts["event"] = value
        end
    end)
    Form.controls.event = event
    Form:AddChild(event)
    AddTooltip(event, L"Combat Log Event to track for a given ID. Ex:".."\n- SPELL_CAST_SUCCESS\n- SPELL_SUMMON" )

    -- Frame:AddChild(Form)
    -- Frame.top = Form
    return Form
end

function NugRunningGUI.CreateSpellForm(self)
    local topgroup = NugRunningGUI:CreateCommonForm()

    return topgroup
end

local ReverseLookup = function(self, effect)
    if not effect then return end
    for k,v in pairs(self) do
        if v == effect then
            return k
        end
    end
end
local fillAlpha = function(rgb)
    local r,g,b,a = unpack(rgb)
    a = a or 1
    return r,g,b,a
end

function NugRunningGUI.FillForm(self, Form, class, category, id, opts, isEmptyForm)
    Form.opts = opts
    Form.class = class
    Form.category = category
    Form.id = id

    if category == "itemcooldowns" then
        opts.isItem = true
    end

    local controls = Form.controls
    controls.spellID:SetText(id or "")
    controls.spellID:SetDisabled(not isEmptyForm)
    controls.disabled:SetValue(opts.disabled)
    controls.disabled:SetDisabled(isEmptyForm)

    controls.name:SetText(opts.name or "")
    controls.priority:SetText(opts.priority)
    controls.group:SetValue(opts.group or "default")
    controls.short:SetText(opts.short)
    controls.duration:SetText((type(opts.duration) == "function" and "<func>") or opts.duration)
    controls.scale:SetValue(opts.scale or 1)
    controls.scale_until:SetText(opts.scale_until)
    controls.hide_until:SetText(opts.hide_until)
    controls.glowtime:SetText(opts.glowtime)
    controls.glow2time:SetText(opts.glow2time)
    controls.effecttime:SetText(opts.effecttime)
    controls.shine:SetValue(opts.shine)
    controls.shinerefresh:SetValue(opts.shinerefresh)

    if opts.ghost then
        local numeric = opts.ghost == true and 3 or opts.ghost
        controls.ghost:SetText(numeric)
    else
        controls.ghost:SetText()
    end
    controls.preghost:SetValue(opts.preghost)
    controls.maxtimers:SetText(opts.maxtimers)
    controls.singleTarget:SetValue(opts.singleTarget)
    controls.multiTarget:SetValue(opts.multiTarget)
    controls.timeless:SetValue(opts.timeless)

    controls.color:SetColor(fillAlpha(opts.color or {0.8, 0.1, 0.7} ))
    controls.color2:SetColor(fillAlpha(opts.color2 or {1,1,1,0} ))
    controls.arrow:SetColor(fillAlpha(opts.arrow or {1,1,1,0} ))

    if opts.stackcolor then
        controls.useStackcolor:SetValue(true)
        for i=1,5 do
            local widgetName = "stackcolor"..i
            controls[widgetName]:SetDisabled(false)
            if opts.stackcolor[i] then
                local r,g,b = unpack(opts.stackcolor[i])
                controls[widgetName]:SetColor(r,g,b)
            end
        end
    else
        controls.useStackcolor:SetValue(false)
        for i=1,5 do
            local widgetName = "stackcolor"..i
            controls[widgetName]:SetDisabled(true)
            controls[widgetName]:SetColor(0,0,0)
        end
    end

    controls.affiliation:SetValue(opts.affiliation or COMBATLOG_OBJECT_AFFILIATION_MINE)
    controls.nameplates:SetValue(opts.nameplates)

    controls.tick:SetText(opts.tick)
    controls.recast_mark:SetText(opts.recast_mark)
    controls.fixedlen:SetText(opts.fixedlen)

    if opts.overlay then
        controls.overlay_start:SetText(opts.overlay[1])
        controls.overlay_end:SetText(opts.overlay[2])
        controls.overlay_haste:SetValue(opts.overlay[4])
    else
        controls.overlay_start:SetText("")
        controls.overlay_end:SetText("")
        controls.overlay_haste:SetValue(false)
    end

    controls.effect:SetValue(opts.effect or "NONE")
	controls.ghosteffect:SetValue(opts.ghosteffect or "NONE")

	local clonesText
	if opts.clones then
		clonesText = table.concat(opts.clones, ", ")
	end
	controls.clones:SetText(clonesText)

	controls.event:SetText(opts.event)


	if id and not NugRunningConfig[category][id] then
		controls.delete:SetDisabled(false)
		controls.delete:SetText(L"Delete")
	elseif NugRunningConfigCustom[class] and  NugRunningConfigCustom[class][category] and NugRunningConfigCustom[class][category][id] then
		controls.delete:SetDisabled(false)
		controls.delete:SetText(L"Restore")
	else
		controls.delete:SetDisabled(true)
		controls.delete:SetText(L"Restore")
	end


	if category == "spells" then
		controls.duration:SetDisabled(false)
		controls.maxtimers:SetDisabled(false)
		controls.singleTarget:SetDisabled(true)
		controls.multiTarget:SetDisabled(false)
		controls.affiliation:SetDisabled(false)
		controls.nameplates:SetDisabled(false)
		controls.hide_until:SetDisabled(true)
		controls.clones:SetDisabled(false)
		controls.timeless:SetDisabled(false)
	else
		controls.duration:SetDisabled(true)
		controls.maxtimers:SetDisabled(true)
		controls.singleTarget:SetDisabled(true)
		controls.multiTarget:SetDisabled(true)
		controls.affiliation:SetDisabled(true)
		controls.nameplates:SetDisabled(true)
		controls.hide_until:SetDisabled(false)
		controls.clones:SetDisabled(true)
		controls.timeless:SetDisabled(true)
	end

	if category == "event_timers" then
		controls.event:SetDisabled(false)
		controls.clones:SetDisabled(false)
		controls.duration:SetDisabled(false)
		controls.affiliation:SetDisabled(false)
	else
		controls.event:SetDisabled(true)
	end

	if category == "event_timers" or category == "casts" then
		controls.useStackcolor:SetDisabled(true)
		for i=1,5 do
			local widgetName = "stackcolor"..i
			controls[widgetName]:SetDisabled(true)
		end
	else
		controls.useStackcolor:SetDisabled(false)
	end

	if category == "itemcooldowns" then
		controls.spellID:SetLabel(L"Item ID")
	else
		controls.spellID:SetLabel(L"Spell ID")
	end

end



function NugRunningGUI.Create(self, name, parent )
    -- Create a container frame
    -- local Frame = AceGUI:Create("Frame")
    -- Frame:SetTitle("NugRunningGUI")
    -- Frame:SetWidth(500)
    -- Frame:SetHeight(440)
    -- Frame:EnableResize(false)
    -- -- f:SetStatusText("Status Bar")
    -- -- Frame:SetParent(InterfaceOptionsFramePanelContainer)
    -- Frame:SetLayout("Flow")
    -- Frame:Hide()

    local Frame = AceGUI:Create("BlizOptionsGroup")
    Frame:SetName(name, parent)
    Frame:SetTitle(L"NugRunning Spell List")
    Frame:SetLayout("Fill")
    -- Frame:SetHeight(500)
    -- Frame:SetWidth(700)
    -- Frame:Show()



    -- local gr = AceGUI:Create("InlineGroup")
    -- gr:SetLayout("Fill")
    -- -- gr:SetWidth(600)
    -- -- gr:SetHeight(600)
    -- Frame:AddChild(gr)
    --
    -- local setcreate = AceGUI:Create("Button")
    -- setcreate:SetText("Save")
    -- -- setcreate:SetWidth(100)
    -- gr:AddChild(setcreate)
    -- if true then
        -- return Frame
    -- end


    -- local Frame = CreateFrame("Frame", "NugRunningOptions", UIParent) -- InterfaceOptionsFramePanelContainer)
    -- -- Frame:Hide()
    -- Frame.name = "NugRunningOptions"
    -- Frame.children = {}
    -- Frame:SetWidth(400)
    -- Frame:SetHeight(400)
    -- Frame:SetPoint("CENTER", UIParent, "CENTER",0,0)
    -- Frame.AddChild = function(self, child)
    -- 	table.insert(self.children, child)
    -- 	child:SetParent(self)
    -- end
    -- InterfaceOptions_AddCategory(Frame)


    -- local topgroup = AceGUI:Create("InlineGroup")
    -- topgroup:SetFullWidth(true)
    -- -- topgroup:SetHeight(0)
    -- topgroup:SetLayout("Flow")
    -- Frame:AddChild(topgroup)
    -- Frame.top = topgroup
    --
    -- local setname = AceGUI:Create("EditBox")
    -- setname:SetWidth(240)
    -- setname:SetText("NewSet1")F
    -- setname:DisableButton(true)
    -- topgroup:AddChild(setname)
    -- topgroup.label = setname
    --
    -- local setcreate = AceGUI:Create("Button")
    -- setcreate:SetText("Save")
    -- setcreate:SetWidth(100)
    -- setcreate:SetCallback("OnClick", function(self) NugRunningGUI:SaveSet() end)
    -- setcreate:SetCallback("OnEnter", function() Frame:SetStatusText("Create new/overwrite existing set") end)
    -- setcreate:SetCallback("OnLeave", function() Frame:SetStatusText("") end)
    -- topgroup:AddChild(setcreate)
    --
    -- local btn4 = AceGUI:Create("Button")
    -- btn4:SetWidth(100)
    -- btn4:SetText("Delete")
    -- btn4:SetCallback("OnClick", function() NugRunningGUI:DeleteSet() end)
    -- topgroup:AddChild(btn4)
    -- -- Frame.rpane:AddChild(btn4)
    -- -- Frame.rpane.deletebtn = btn4



    local treegroup = AceGUI:Create("TreeGroup") -- "InlineGroup" is also good
    -- treegroup:SetParent(InterfaceOptionsFramePanelContainer)
    -- treegroup.name = "NugRunningOptions"
    -- treegroup:SetFullWidth(true)
    -- treegroup:SetTreeWidth(200, false)
    -- treegroup:SetLayout("Flow")
    treegroup:SetFullHeight(true) -- probably?
    treegroup:SetFullWidth(true) -- probably?
    treegroup:EnableButtonTooltips(false)
    treegroup:SetCallback("OnGroupSelected", function(self, event, group)
        local path = {}
        for match in string.gmatch(group, '([^\001]+)') do
            table.insert(path, match)
        end

        local class, category, spellID = unpack(path)
        if not spellID or not category then
            Frame.rpane:Clear()
            if not NewTimerForm then
                NewTimerForm = NugRunningGUI:CreateNewTimerForm()
            end
            NewTimerForm.class = class
            Frame.rpane:AddChild(NewTimerForm)
            if class == "GLOBAL" then
                NewTimerForm.controls.newcooldown:SetDisabled(true)
                NewTimerForm.controls.newitemcooldown:SetDisabled(true)
                NewTimerForm.controls.newcast:SetDisabled(true)
            else
                NewTimerForm.controls.newcooldown:SetDisabled(false)
                NewTimerForm.controls.newitemcooldown:SetDisabled(false)
                NewTimerForm.controls.newcast:SetDisabled(false)
            end

			return
		end

		spellID = tonumber(spellID)
		local opts
		if not NugRunningConfigCustom[class] or not NugRunningConfigCustom[class][category] or not NugRunningConfigCustom[class][category][spellID] then
			opts = {}
		else
			opts = CopyTable(NugRunningConfigCustom[class][category][spellID])
		end
		NugRunning.SetupDefaults(opts, NugRunningConfig[category][spellID])

		-- if category == "spells" then
		Frame.rpane:Clear()
		if not SpellForm then
			SpellForm = NugRunningGUI:CreateSpellForm()
		end
		NugRunningGUI:FillForm(SpellForm, class, category, spellID, opts)
		Frame.rpane:AddChild(SpellForm)

		-- end
	end)

	Frame.rpane = treegroup
	Frame.tree = treegroup

	treegroup.UpdateSpellTree = function(self)
		local lclass, class = UnitClass("player")
		local classIcon = "Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes"
		local classCoords = CLASS_ICON_TCOORDS[class]

		local t = {
			{
				value = "GLOBAL",
				text = L"Global",
				icon = "Interface\\Icons\\spell_holy_resurrection",
				children = {
					{
						value = "spells",
						text = "Spells",
						icon = "Interface\\Icons\\spell_shadow_manaburn",
						children = NugRunningGUI:GenerateCategoryTree(true, "spells")
					},
					-- {
					-- 	value = "cooldowns",
					-- 	text = "Cooldowns",
					-- 	icon = "Interface\\Icons\\spell_nature_astralrecal",
					-- 	children = NugRunningGUI:GenerateCategoryTree(true, "cooldowns")
					-- },
					-- {
					-- 	value = "casts",
					-- 	text = "Casts",
					-- 	icon = "Interface\\Icons\\spell_deathvortex",
					-- 	children = NugRunningGUI:GenerateCategoryTree(true, "casts")
					-- },
				},
			},
			{
				value = class,
				text = lclass,
				icon = classIcon,
				iconCoords = classCoords,
				children = {
					{
						value = "spells",
						text = "Spells",
						icon = "Interface\\Icons\\spell_shadow_manaburn",
						children = NugRunningGUI:GenerateCategoryTree(false,"spells")
					},
					{
						value = "cooldowns",
						text = "Cooldowns",
						icon = "Interface\\Icons\\spell_nature_astralrecal",
						children = NugRunningGUI:GenerateCategoryTree(false,"cooldowns")
					},
					{
						value = "itemcooldowns",
						text = "Item Cooldowns",
						icon = 135882,
						children = NugRunningGUI:GenerateCategoryTree(false,"itemcooldowns")
					},
					{
						value = "casts",
						text = "Casts",
						icon = 135951,
						children = NugRunningGUI:GenerateCategoryTree(false,"casts")
					},
					{
						value = "event_timers",
						text = "Events",
						icon = 132096,
						children = NugRunningGUI:GenerateCategoryTree(false, "event_timers")
					}
				}
			},
		}
		self:SetTree(t)
		return t
	end


	local t = treegroup:UpdateSpellTree()

	Frame:AddChild(treegroup)



	local categories = {"spells", "cooldowns", "itemcooldowns", "casts", "event_timers"}
	for i,group in ipairs(t) do -- expand all groups
		if group.value ~= "GLOBAL" then
			treegroup.localstatus.groups[group.value] = true
			for _, cat in ipairs(categories) do
				treegroup.localstatus.groups[group.value.."\001"..cat] = true
			end
		end
	end
	-- TREEG = treegroup


	Frame.rpane.Clear = function(self)
		for i, child in ipairs(self.children) do
			child:SetParent(UIParent)
			child.frame:Hide()
		end
		table.wipe(self.children)
	end



	-- local commonForm = NugRunningGUI:CreateCommonForm()
	-- Frame.rpane:AddChild(commonForm)
	local _, class = UnitClass("player")
	Frame.tree:SelectByPath(class)



    -- Frame:Hide()

    return Frame
end

local function MakeGeneralOptions()
    local opt = {
        type = 'group',
        name = L"NugRunning Settings",
        order = 1,
        args = {
            -- charspec = {
            --     type = 'toggle',
            --     name = "Character-specific",
            --     desc = "Switch between global/character configuration",
            --     width = "full",
            --     order = 0,
            --     get = function(info)
            --         local user = UnitName("player").."@"..GetRealmName()
            --         return NugRunning.db_Global.charspec[user]
            --     end,
            --     set = function( info, v )
            --         NugRunning.Commands.charspec()
            --     end
            -- },
            anchors = {
                type = "group",
                name = L"Anchors",
                guiInline = true,
                order = 1,
                args = {
                    unlock = {
                        name = L"Unlock",
                        type = "execute",
                        -- width = "half",
                        desc = "Unlock anchor for dragging",
                        func = function() NugRunning.Commands.unlock() end,
                        order = 1,
                    },
                    lock = {
                        name = L"Lock",
                        type = "execute",
                        -- width = "half",
                        desc = "Lock anchor",
                        func = function() NugRunning.Commands.lock() end,
                        order = 2,
                    },
                    reset = {
                        name = L"Reset",
                        type = "execute",
                        desc = "Reset anchor",
                        func = function() NugRunning.Commands.reset() end,
                        order = 3,
                    },
                },
            }, --
            sizeSettings = {
                type = "group",
                name = " ",
                guiInline = true,
                order = 2,
                args = {
                    texture = {
                        type = "select",
                        name = L"Texture",
                        order = 0.5,
                        desc = "Set the statusbar texture.",
                        get = function(info) return NugRunning.db.textureName end,
                        set = function(info, value)
                            NugRunning.db.textureName = value
                            NugRunning:UpdateAllTextures()
                        end,
                        values = LSM:HashTable("statusbar"),
                        dialogControl = "LSM30_Statusbar",
                    },
                    width = {
                        name = L"Width",
                        type = "range",
                        get = function(info) return NugRunning.db.width end,
                        set = function(info, v)
                            NugRunning.db.width = v
                            for i,timer in ipairs(NugRunning.timers) do
                                timer:Resize(NugRunning.db.width, NugRunning.db.height)
                            end
                        end,
                        min = 80,
                        max = 400,
                        step = 5,
                        order = 1,
                    },
                    height = {
                        name = L"Height",
                        type = "range",
                        get = function(info) return NugRunning.db.height end,
                        set = function(info, v)
                            NugRunning.db.height = v
                            for i,timer in ipairs(NugRunning.timers) do
                                timer:Resize(NugRunning.db.width, NugRunning.db.height)
                            end
                        end,
                        min = 10,
                        max = 50,
                        step = 1,
                        order = 2,
                    },
                    growth = {
                        name = L"Growth Direction",
                        type = 'select',
                        order = 3,
                        values = {
                            up = "Up",
                            down = "Down",
                        },
                        get = function(info) return NugRunning.db.growth end,
                        set = function( info, v )
                            NugRunning.db.growth = v
                            for i,timer in ipairs(NugRunning.timers) do
                                timer:ClearAllPoints()
                            end
                            NugRunning:SetupArrange()
                            NugRunning:ArrangeTimers()
                        end,
                    },
                },
            },
            nameplate_sizeSettings = {
                type = "group",
                name = L"Nameplate Bars",
                guiInline = true,
                order = 3,
                args = {
                    texture = {
                        type = "select",
                        name = L"Texture",
                        order = 0.5,
                        desc = "Set the statusbar texture.",
                        get = function(info) return NugRunning.db.nptextureName end,
                        set = function(info, value)
                            NugRunning.db.nptextureName = value
                            NugRunning:UpdateAllNameplateTextures()
                        end,
                        values = LSM:HashTable("statusbar"),
                        dialogControl = "LSM30_Statusbar",
                    },
                    width = {
                        name = L"Nameplate Width",
                        type = "range",
                        get = function(info) return NugRunning.db.np_width end,
                        set = function(info, v)
                            NugRunning.db.np_width = v
                            if NugRunningNameplates then NugRunningNameplates:Resize() end
                        end,
                        min = 50,
                        max = 200,
                        step = 1,
                        order = 1,
                    },
                    height = {
                        name = L"Nameplate Height",
                        type = "range",
                        get = function(info) return NugRunning.db.np_height end,
                        set = function(info, v)
                            NugRunning.db.np_height = v
                            if NugRunningNameplates then NugRunningNameplates:Resize() end
                        end,
                        min = 3,
                        max = 50,
                        step = 1,
                        order = 2,
                    },
                    xoffset = {
                        name = L"Nameplate X Offset",
                        type = "range",
                        get = function(info) return NugRunning.db.np_xoffset end,
                        set = function(info, v)
                            NugRunning.db.np_xoffset = v
                            if NugRunningNameplates then NugRunningNameplates:Resize() end
                        end,
                        min = -100,
                        max = 100,
                        step = 1,
                        order = 3,
                    },
                    yoffset = {
                        name = L"Nameplate Y Offset",
                        type = "range",
                        get = function(info) return NugRunning.db.np_yoffset end,
                        set = function(info, v)
                            NugRunning.db.np_yoffset = v
                            if NugRunningNameplates then NugRunningNameplates:Resize() end
                        end,
                        min = -100,
                        max = 100,
                        step = 1,
                        order = 3,
                    },
                },
            },
            fonts = {
                type = "group",
                name = L"Fonts",
                guiInline = true,
                order = 6,
                args = {
                    namefont = {
                        type = "select",
                        name = L"Name Font",
                        order = 1,
                        get = function(info) return NugRunning.db.nameFont.font end,
                        set = function(info, value)
                            NugRunning.db.nameFont.font = value
                            NugRunning:UpdateAllFonts()
                        end,
                        values = LSM:HashTable("font"),
                        dialogControl = "LSM30_Font",
                    },
                    nameSize = {
                        name = L"Name Size",
                        type = "range",
                        get = function(info) return NugRunning.db.nameFont.size end,
                        set = function(info, v)
                            NugRunning.db.nameFont.size = v
                            NugRunning:UpdateAllFonts()
                        end,
                        min = 3,
                        max = 40,
                        step = 1,
                        order = 2,
                    },
                    nameAlpha = {
                        name = L"Name Alpha",
                        type = "range",
                        get = function(info) return NugRunning.db.nameFont.alpha end,
                        set = function(info, v)
                            NugRunning.db.nameFont.alpha = v
                            NugRunning:UpdateAllFonts()
                        end,
                        min = 0,
                        max = 1,
                        step = 0.01,
                        order = 3,
                    },

                    timefont = {
                        type = "select",
                        name = L"Time Font",
                        order = 4,
                        get = function(info) return NugRunning.db.timeFont.font end,
                        set = function(info, value)
                            NugRunning.db.timeFont.font = value
                            NugRunning:UpdateAllFonts()
                        end,
                        values = LSM:HashTable("font"),
                        dialogControl = "LSM30_Font",
                    },
                    timeSize = {
                        name = L"Time Size",
                        type = "range",
                        get = function(info) return NugRunning.db.timeFont.size end,
                        set = function(info, v)
                            NugRunning.db.timeFont.size = v
                            NugRunning:UpdateAllFonts()
                        end,
                        min = 3,
                        max = 40,
                        step = 1,
                        order = 5,
                    },
                    timeAlpha = {
                        name = L"Time Alpha",
                        type = "range",
                        get = function(info) return NugRunning.db.timeFont.alpha end,
                        set = function(info, v)
                            NugRunning.db.timeFont.alpha = v
                            NugRunning:UpdateAllFonts()
                        end,
                        min = 0,
                        max = 1,
                        step = 0.01,
                        order = 6,
                    },

                    stackfont = {
                        type = "select",
                        name = L"Stack Font",
                        order = 7,
                        get = function(info) return NugRunning.db.stackFont.font end,
                        set = function(info, value)
                            NugRunning.db.stackFont.font = value
                            NugRunning:UpdateAllFonts()
                        end,
                        values = LSM:HashTable("font"),
                        dialogControl = "LSM30_Font",
                    },
                    stackSize = {
                        name = L"Stack Size",
                        type = "range",
                        get = function(info) return NugRunning.db.stackFont.size end,
                        set = function(info, v)
                            NugRunning.db.stackFont.size = v
                            NugRunning:UpdateAllFonts()
                        end,
                        min = 3,
                        max = 40,
                        step = 1,
                        order = 8,
                    },
                    stackAlpha = {
                        name = L"Stack Alpha",
                        type = "range",
                        get = function(info) return NugRunning.db.stackFont.alpha end,
                        set = function(info, v)
                            NugRunning.db.stackFont.alpha = v
                            NugRunning:UpdateAllFonts()
                        end,
                        min = 0,
                        max = 1,
                        step = 0.01,
                        order = 9,
                    },
                },
            },
            timerOptions = {
                type = "group",
                name = L"Timers",
                guiInline = true,
                order = 1.2,
                args = {

                    spellText = {
                        name = L"Show Spell Names",
                        type = "toggle",
                        desc = L"Display spell name on timers",
                        get = function(info) return NugRunning.db.spellTextEnabled end,
                        set = function(info, v) NugRunning.db.spellTextEnabled = not NugRunning.db.spellTextEnabled end,
                        order = 1,
                    },
                    localNames = {
                        name = L"Localized Spell Names",
                        type = "toggle",
                        desc = L"Ignore custom names and always show native spell names",
                        get = function(info) return NugRunning.db.localNames end,
                        set = function(info, v) NugRunning.db.localNames = not NugRunning.db.localNames end,
                        order = 2,
                    },
                    misses = {
                        name = L"Misses",
                        type = "toggle",
                        desc = L"Show short notification when spell is resisted/missed",
                        get = function(info) return NugRunning.db.missesEnabled end,
                        set = function(info, v) NugRunning.db.missesEnabled = not NugRunning.db.missesEnabled end,
                        order = 3,
                    },
                    nameplates = {
                        name = L"Nameplate Timers",
                        type = "toggle",
                        desc = L"Mirror flagged spell timers on nameplates",
                        confirm = true,
                        confirmText = "Warning: Requires UI reloading.",
                        get = function(info) return NugRunning.db.nameplates end,
                        set = function(info, v)
                            NugRunning.db.nameplates = not NugRunning.db.nameplates
                            ReloadUI()
                        end,
                        order = 4,
                    },
                    cooldowns = {
                        name = L"Cooldowns",
                        type = "toggle",
                        get = function(info) return NugRunning.db.cooldownsEnabled end,
                        set = function(info, v) NugRunning.Commands.cooldowns() end,
                        order = 6,
                    },
                    totems = {
                        name = L"Totems",
                        type = "toggle",
                        desc = L"Display timers for totems (or other similar summons)",
                        get = function(info) return NugRunning.db.totems end,
                        set = function(info, v) NugRunning.db.totems = not NugRunning.db.totems end,
                        order = 7,
                    },
                    drs = {
                        name = L"Diminishing Returns",
                        type = "toggle",
                        get = function(info) return NugRunning.db.drEnabled end,
                        set = function(info, v) NugRunning.db.drEnabled = not NugRunning.db.drEnabled end,
                        order = 7.5,
                    },
                    swapTargets = {
                        name = L"Fixed Target Group"..newFeatureIcon,
                        type = "toggle",
                        width = "full",
                        desc = L"Switch between target indicator or fixed position",
                        get = function(info) return NugRunning.db.swapTarget end,
                        set = function(info, v)
                            NugRunning.db.swapTarget = not NugRunning.db.swapTarget
                            NugRunning:SetupArrange()
                            NugRunning:ArrangeTimers()
                        end,
                        order = 8,
                    },
                },
            },
            debug = {
                name = L"Toggle Combat Log Data",
                type = "execute",
                width = "double",
                desc = L"Print occurring combat log events in chat",
                func = function() NugRunning.Commands.debug() end,
                order = 7,
            },
        },
    }

    local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
    AceConfigRegistry:RegisterOptionsTable("NugRunningGeneral", opt)

    local AceConfigDialog = LibStub("AceConfigDialog-3.0")
    local panelFrame = AceConfigDialog:AddToBlizOptions("NugRunningGeneral", "General", "NugRunning")

    return panelFrame
end




local function MakeHelp()
    local opt = {
        type = 'group',
        name = "Help",
        order = 1,
        args = {
            msg = {
                name = L"NugRunning provides commands to list spellIDs of all current auras.\n/nrun listauras target\n/nrun listauras player\n/nrun debug - toggle combat log event display in chat\nSpell ID next to SPELL_CAST_SUCCESS is the one to use for cooldowns\nWoW Classic doesn't have spell IDs in combat log",
                type = "description",
                fontSize = "medium",
                width = "full",
                order = 1,
            },
            msg2 = {
                name = L"To move timer groups to different anchors use '/nrun groupset' command. /nrun help for more info",
                type = "description",
                fontSize = "medium",
                width = "full",
                order = 2,
            },
        },
    }
    local AceConfigRegistry = LibStub("AceConfigRegistry-3.0")
    AceConfigRegistry:RegisterOptionsTable("NugRunningHelp", opt)

    local AceConfigDialog = LibStub("AceConfigDialog-3.0")
    local panelFrame = AceConfigDialog:AddToBlizOptions("NugRunningHelp", "Help", "NugRunning")

    return panelFrame
end



do
    local f = CreateFrame('Frame', "NugRunningOptions", InterfaceOptionsFrame)
    f.name = "NugRunning"
    InterfaceOptions_AddCategory(f);

    f.general = MakeGeneralOptions()
    f.help = MakeHelp()

    NugRunningGUI.frame = NugRunningGUI:Create("Spell List", "NugRunning")
    f.spell_list = NugRunningGUI.frame.frame
    InterfaceOptions_AddCategory(f.spell_list);

    f:Hide()
    f:SetScript("OnShow", function(self)
            self:Hide();
            local list = self.spell_list
            InterfaceOptionsFrame_OpenToCategory (list)
            InterfaceOptionsFrame_OpenToCategory (list)
    end)
end
