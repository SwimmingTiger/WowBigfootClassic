local ADDONNAME, ADDONSELF = ...

local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")

local m = {}
local a = {}

f:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local name = select(1, ...)

        local cbs = a[name]
        if cbs then
            for _, cb in pairs(cbs) do
                cb(...)
            end
        end

        if ADDONNAME ~= name then
            return
        end
    end

    local cbs = m[event]
    if cbs then
        for _, cb in pairs(cbs) do
            cb(...)
        end
    end
end)

ADDONSELF.regevent = function(event, cb)
    if not m[event] then
        m[event] = {}
    end

    f:RegisterEvent(event)
    table.insert(m[event] , cb)
end

ADDONSELF.regaddonloaded = function(addon, cb)
    if not a[addon] then
        a[addon] = {}
    end

    table.insert(a[addon] , cb)
end
