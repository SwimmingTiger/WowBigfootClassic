
-------------------------------------
-- InspectCore Author: M
-------------------------------------

local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local LibSchedule = LibStub:GetLibrary("LibSchedule.7000")
local LibItemInfo = LibStub:GetLibrary("LibItemInfo.1000")

local guids, inspecting = {}, false

-- Global API
function GetInspectInfo(unit, timelimit, checkhp)
    local guid = UnitGUID(unit)
    if (not guid or not guids[guid]) then return end
    if (checkhp and UnitHealthMax(unit) ~= guids[guid].hp) then return end
    if (not timelimit or timelimit == 0) then
        return guids[guid]
    end
    if (guids[guid].timer > time()-timelimit) then
        return guids[guid]
    end
end

-- Global API
function GetInspecting()
    if (InspectFrame and InspectFrame.unit) then
        local guid = UnitGUID(InspectFrame.unit)
        return guids[guid] or { inuse = true }
    end
    if (inspecting and inspecting.expired > time()) then
        return inspecting
    end
end

-- Global API @trigger UNIT_REINSPECT_READY
function ReInspect(unit)
    local guid = UnitGUID(unit)
    if (not guid) then return end
    local data = guids[guid]
    if (not data) then return end
    local ilevel, weaponLevel, maxLevel = LibItemInfo:GetUnitItemLevel(unit)
    data.timer = time()
    data.ilevel = ilevel
    data.weaponLevel = weaponLevel
    data.maxLevel = maxLevel
    LibEvent:trigger("UNIT_REINSPECT_READY", data)
end

-- Global API @todo
function GetInspectSpec(unit)
    
end

-- Clear
hooksecurefunc("ClearInspectPlayer", function()
    inspecting = false
end)

-- @trigger UNIT_INSPECT_STARTED
hooksecurefunc("NotifyInspect", function(unit)
    local guid = UnitGUID(unit)
    if (not guid) then return end
    local data = guids[guid]
    if (data) then
        data.unit = unit
        data.name, data.realm = UnitName(unit)
    else
        data = {
            unit   = unit,
            guid   = guid,
            class  = select(2, UnitClass(unit)),
            level  = UnitLevel(unit),
            ilevel = -1,
            spec   = nil,
            hp     = UnitHealthMax(unit),
            timer  = time(),
        }
        data.name, data.realm = UnitName(unit)
        guids[guid] = data
    end
    if (not data.realm) then
        data.realm = GetRealmName()
    end
    data.expired = time() + 3
    inspecting = data
    LibEvent:trigger("UNIT_INSPECT_STARTED", data)
end)

-- @trigger UNIT_INSPECT_READY
LibEvent:attachEvent("INSPECT_READY", function(this, guid)
    local data = guids[guid]
    if (not data) then return end
    LibSchedule:AddTask({
        identity  = guid,
        timer     = 0.5,
        elasped   = 0.8,
        expired   = GetTime() + 3,
        data      = data,
        onTimeout = function(self) inspecting = false end,
        onExecute = function(self)
            local ilevel, weaponLevel, maxLevel = LibItemInfo:GetUnitItemLevel(self.data.unit)
            self.data.timer = time()
            self.data.name = UnitName(self.data.unit)
            self.data.class = select(2, UnitClass(self.data.unit))
            self.data.ilevel = ilevel
            self.data.weaponLevel = weaponLevel
            self.data.maxLevel = maxLevel
            self.data.spec = GetInspectSpec(self.data.unit)
            self.data.hp = UnitHealthMax(self.data.unit)
            LibEvent:trigger("UNIT_INSPECT_READY", self.data)
            inspecting = false
            return true
        end,
    })
end)
