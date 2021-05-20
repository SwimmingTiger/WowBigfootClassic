-- if select(2,UnitClass("player")) ~= "SHAMAN" then return end
if not next(NugRunningConfig.totems) then return end

NugRunning.InitTotems = function(self)

    local active = NugRunning.active
    local free = NugRunning.free

    local totems = NugRunningConfig.totems

    local totemState = {
        { false, "", 0, 0, "" }, -- Fire
        { false, "", 0, 0, "" }, -- Earth
        { false, "", 0, 0, "" }, -- Water
        { false, "", 0, 0, "" }, -- Air
    }

    NugRunning.totems = CreateFrame("Frame",nil, NugRunning)

    local playerGUID = UnitGUID("player")

    -- NugRunning.totems.PLAYER_TOTEM_UPDATE = function (self, event)
    NugRunning.totems:SetScript("OnEvent", function(self,event)
        for index, totemInfo in ipairs(totemState) do
            local isActive, name, startTime, duration, iconID = GetTotemInfo(index)

            local wasActive, oldName, oldStartTime, oldDuration, oldIconID = unpack(totemInfo)

            -- print(isActive, name, startTime, duration, iconID)
            if wasActive ~= isActive then
                -- ACTIVATION/DEACTIVATION
                if isActive then
                    local opts = totems[iconID]
                    if opts then
                        local timer = NugRunning:ActivateTimer(playerGUID, playerGUID, UnitName("player"), nil, opts.spellID, name, opts, "TOTEM", duration)
                        timer:SetTime(startTime, startTime + duration)
                    end
                elseif wasActive then
                    local opts = totems[oldIconID]
                    if opts then
                        NugRunning:DeactivateTimer(playerGUID, playerGUID, opts.spellID, name, opts, "TOTEM")
                    end
                end
            elseif iconID ~= oldIconID or name ~= oldName then
                -- SWAP
                if oldIconID ~= "" then
                    local opts = totems[oldIconID]
                    if opts then
                        NugRunning:DeactivateTimer(playerGUID, playerGUID, opts.spellID, name, opts, "TOTEM")
                    end

                    opts = totems[iconID]
                    if opts then
                        local timer = NugRunning:ActivateTimer(playerGUID, playerGUID, UnitName("player"), nil, opts.spellID, name, opts, "TOTEM", duration)
                        timer:SetTime(startTime, startTime + duration)
                    end
                end
            elseif startTime ~= oldStartTime or duration ~= oldDuration then
                -- REFRESH
                local opts = totems[iconID]
                if opts then
                    local timer = NugRunning:RefreshTimer(playerGUID, playerGUID, UnitName("player"), nil, opts.spellID, name, opts, "TOTEM", duration)
                    timer:SetTime(startTime, startTime + duration)
                end
            end

            totemInfo[1] = isActive
            totemInfo[2] = name
            totemInfo[3] = startTime
            totemInfo[4] = duration
            totemInfo[5] = iconID
        end
    end)

    NugRunning.totems:RegisterEvent("PLAYER_TOTEM_UPDATE")
    NugRunning.totems:RegisterEvent("PLAYER_ENTERING_WORLD")

end