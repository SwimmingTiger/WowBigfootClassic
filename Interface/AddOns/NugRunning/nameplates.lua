local _, helpers = ...

local NugRunning = NugRunning
local LSM = LibStub("LibSharedMedia-3.0")


local all_np_timers = {}
NugRunning.nameplate_timers = all_np_timers

function NugRunning:DoNameplates()

local next = next
local table_remove = table.remove

local makeicon = true
local confignp = NugRunningConfig.nameplates

local np_xoffset = 0
local np_yoffset = 0

local oldTargetGUID
local guidmap = {}

local GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit

NugRunningNameplates = CreateFrame("Frame", "NugRunningNameplates", UIParent)
local NugRunningNameplates = NugRunningNameplates


NugRunningNameplates:RegisterEvent("NAME_PLATE_CREATED")
NugRunningNameplates:RegisterEvent("NAME_PLATE_UNIT_ADDED")
NugRunningNameplates:RegisterEvent("NAME_PLATE_UNIT_REMOVED")

local playerNameplate
local activeNameplates = {}

function NugRunningNameplates.NAME_PLATE_CREATED(self, event, frame)
    frame.timers = {}
    if frame.UnitFrame and frame.UnitFrame.BuffFrame then
        frame.UnitFrame.BuffFrame:Hide()
    end
end

function NugRunningNameplates.NAME_PLATE_UNIT_ADDED(self, event, unit)
    activeNameplates[unit] = true
    local pGUID = UnitGUID(unit)
    local frame = GetNamePlateForUnit(unit)
    if pGUID == UnitGUID("player") then playerNameplate = frame end
    local guidTimers = NugRunning:GetTimersByDstGUID(pGUID)
    NugRunningNameplates:UpdateNPTimers(frame, guidTimers)
end

function NugRunningNameplates.NAME_PLATE_UNIT_REMOVED(self, event, unit)
    activeNameplates[unit] = nil
    local frame = GetNamePlateForUnit(unit)
    for _, timer in ipairs(frame.timers) do
        timer:Hide()
    end
end

local MiniOnUpdate = function(self, time)
    self._elapsed = self._elapsed + time
    if self._elapsed < 0.02 then return end
    self._elapsed = 0

    local endTime = self.endTime
    local beforeEnd = endTime - GetTime()

    self.bar:SetValue(beforeEnd + self.startTime)
end

function NugRunningNameplates:CreateNameplateTimer(frame)
    local parented = confignp.parented
    local f = CreateFrame("Frame")

    np_xoffset = NugRunning.db.np_xoffset
    np_yoffset = NugRunning.db.np_yoffset

    local w = NugRunning.db.np_width
    local h = NugRunning.db.np_height
    f:SetWidth(w+2*h+1)
    f:SetHeight(h)

    table.insert(all_np_timers, f)

    if parented then
        if TidyPlates then
            f:SetParent(frame.extended)
        elseif KuiNameplates then
            f:SetParent(frame.kui)
        else
            f:SetParent(frame)
        end
    end

    local bar = CreateFrame("StatusBar", nil, f)
    local texture = LSM:Fetch("statusbar", NugRunning.db.nptextureName)
    bar:SetStatusBarTexture(texture)
    bar:SetPoint("TOPRIGHT")
    bar:SetSize(w,h)
    f.bar = bar

    local bg = f:CreateTexture("BACKGROUND", nil, -5)
    bg:SetTexture(texture)
    bg:SetAllPoints(bar)
    bar.bg = bg

    local icon = f:CreateTexture("ARTWORK")
    icon:SetTexCoord(.1, .9, .3, .7)
    icon:SetHeight(h); icon:SetWidth(2*h)
    icon:SetPoint("TOPLEFT", f, "TOPLEFT",0,0)
    f.icon = icon

    local border = f:CreateTexture(nil, "BACKGROUND", nil, -7)
    local offset = 1
    border:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    border:SetVertexColor(0,0,0, 0.5)
    border:SetPoint("TOPLEFT", -offset, offset)
    border:SetPoint("BOTTOMRIGHT", offset, -offset)
    border:Show()

    --[[
    local overlay = bar:CreateTexture(nil, "OVERLAY", nil, 6)
    overlay:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    overlay:SetVertexColor(0,0,0, 0.2)
    overlay:Hide()
    f.overlay = overlay
    ]]


    f._elapsed = 0
    f:SetScript("OnUpdate", MiniOnUpdate)

    if not next(frame.timers) then
        f:SetPoint("BOTTOM", frame, "TOP", np_xoffset,-7+np_yoffset)
    else
        local prev = frame.timers[#frame.timers]
        f:SetPoint("BOTTOM", prev, "TOP", 0,1)
    end
    table.insert(frame.timers, f)
    return f
end

function NugRunningNameplates:Resize()
    np_xoffset = NugRunning.db.np_xoffset
    np_yoffset = NugRunning.db.np_yoffset

    for _,npt in ipairs(all_np_timers) do
        local w = NugRunning.db.np_width
        local h = NugRunning.db.np_height
        npt:SetWidth(w+2*h+1)
        npt:SetHeight(h)
        npt.icon:SetHeight(h)
        npt.icon:SetWidth(2*h)
        npt.bar:SetSize(w,h)
    end

    for unit in pairs(activeNameplates) do
        local np = GetNamePlateForUnit(unit)
        if np then
            local firstTimer = np.timers[1]
            if firstTimer then
                firstTimer:SetPoint("BOTTOM", np, "TOP", np_xoffset,-7+np_yoffset)
            end
        end
    end
end

function NugRunningNameplates:Update(targetTimers, guidTimers, targetSwapping)
    if targetSwapping then
        local tGUID = UnitGUID("target")
        if tGUID then
            guidTimers[tGUID] = targetTimers
        end
    end

    for unit in pairs(activeNameplates) do
        local np = GetNamePlateForUnit(unit)
        if np then
            local guid = UnitGUID(unit)
            local optUnit
            if guid == UnitGUID("target") then optUnit = "target" end
            local nrunTimers = guidTimers[guid]
            self:UpdateNPTimers(np, nrunTimers, optUnit)
        end
    end
end

function NugRunningNameplates:UpdateNPTimers(np, nrunTimers, nameplateUnit)
    if nrunTimers then
        local i = 1
        while i <= #nrunTimers do
            local timer = nrunTimers[i]
            if not timer.opts.nameplates or timer.isGhost then
                table_remove(nrunTimers, i)
            else
                i = i + 1
            end
        end

        local max = math.max(#nrunTimers, #np.timers)
        for i=1, max do
            local npt = np.timers[i]
            local nrunt = nrunTimers[i]
            if not npt then npt = self:CreateNameplateTimer(np) end
            if not nrunt  then
                npt:Hide()
            else
                npt.startTime = nrunt._startTimeModified or nrunt.startTime
                npt.endTime = nrunt.endTime
                npt.bar:SetMinMaxValues(nrunt.bar:GetMinMaxValues())
                local r,g,b = nrunt.bar:GetStatusBarColor()
                npt.bar:SetStatusBarColor(r,g,b)
                npt.bar.bg:SetVertexColor(r*0.4,g*0.4,b*0.4)
                npt.icon:SetTexture(nrunt.icon:GetTexture())

                --[[
                local nrutnOverlay = nrunt.overlay2
                if nrutnOverlay.t1 and nrutnOverlay.t2 then
                    local pos1 = helpers.getbarpos(npt, nrutnOverlay.t1)
                    local pos2 = helpers.getbarpos(npt, nrutnOverlay.t2)
                    local alpha = 0.2
                    if pos2 > pos1 then
                        npt.overlay:SetPoint("TOPLEFT", npt.bar, "TOPLEFT", pos1, 0)
                        npt.overlay:SetPoint("BOTTOMRIGHT", npt.bar, "BOTTOMLEFT", pos2, 0)
                        npt.overlay:SetVertexColor(0,0,0, alpha)
                        -- npt.overlay:SetDrawLayer("OVERLAY", 6)
                        npt.overlay:Show()
                    else
                        npt.overlay:Hide()
                    end
                else
                    npt.overlay:Hide()
                end
                ]]

                npt:Show()

                if i == 1 then
                    npt:SetPoint("BOTTOM", np, "TOP", np_xoffset,-7+np_yoffset)
                end
            end

        end
    else
        for _, timer in ipairs(np.timers) do
            timer:Hide()
        end
    end
end


NugRunningNameplates:SetScript("OnEvent", function(self, event, ...)
    return self[event](self, event, ...)
end)


end
