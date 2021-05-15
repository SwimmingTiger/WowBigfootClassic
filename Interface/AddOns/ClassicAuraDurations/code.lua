local addonName, addon = ...

local LibClassicDurations
local LibAuraTypes
local LibSpellLocks
local db

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...)
	return self[event](self, event, ...)
end)


local function SetupDefaults(t, defaults)
    for k,v in pairs(defaults) do
        if type(v) == "table" then
            if t[k] == nil then
                t[k] = CopyTable(v)
            else
                SetupDefaults(t[k], v)
            end
        else
            if t[k] == nil then t[k] = v end
        end
    end
end
local function RemoveDefaults(t, defaults)
    for k, v in pairs(defaults) do
        if type(t[k]) == 'table' and type(v) == 'table' then
            RemoveDefaults(t[k], v)
            if next(t[k]) == nil then
                t[k] = nil
            end
        elseif t[k] == v then
            t[k] = nil
        end
    end
    return t
end

local defaults = {
    portraitIcon = true,
    playerPortraitIcon = true,
    enemyBuffs = false,
    hookTargetFrame = true,
    verbosePortraitIcon = false,
    largePersonalDebuffs = false,
}

-- Redefining blizzard consts
local AURA_START_X = 5;
local AURA_START_Y = 32;
local AURA_OFFSET_Y = 1;
local LARGE_AURA_SIZE = 21;
local SMALL_AURA_SIZE = 17;
local AURA_ROW_WIDTH = 122;
local TOT_AURA_ROW_WIDTH = 101;
local NUM_TOT_AURA_ROWS = 2;

local largeBuffList = {};
local largeDebuffList = {};

local PLAYER_UNITS = {
	player = true,
	pet = true,
};


local function ShouldAuraBeLargePersonalDebuffs(caster)
    if not caster then
		return false;
	end

	for token, value in pairs(PLAYER_UNITS) do
		if UnitIsUnit(caster, token) then
			return value;
		end
	end
end

local function ShouldAuraBeLargeAlways(caster)
    return true
end

local ShouldAuraBeLarge = ShouldAuraBeLargeAlways



local UpdatePortraitIcon = function(frame, unit, maxPrio, maxPrioIndex, maxPrioFilter, targetType)
    local auraCD = frame.CADPortraitFrame
    local originalPortrait = auraCD.originalPortrait

    local isLocked = LibSpellLocks:GetSpellLockInfo(unit)

    local CUTOFF_AURA_TYPE = db.verbosePortraitIcon and "SPEED_BOOST" or "SILENCE"
    local PRIO_SILENCE = LibAuraTypes.GetAuraTypePriority(CUTOFF_AURA_TYPE, targetType)
    if isLocked and PRIO_SILENCE > maxPrio then
        maxPrio = PRIO_SILENCE
        maxPrioIndex = -1
    end

    if maxPrio >= PRIO_SILENCE then
        local name, icon, _, _, duration, expirationTime, caster, _,_, spellId
        if maxPrioIndex == -1 then
            spellId, name, icon, duration, expirationTime = LibSpellLocks:GetSpellLockInfo(unit)
        else
            name, icon, _, _, duration, expirationTime, caster, _,_, spellId = LibClassicDurations:UnitAura(unit, maxPrioIndex, maxPrioFilter)
            local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(unit, spellId, caster)
            if duration == 0 and durationNew then
                duration = durationNew
                expirationTime = expirationTimeNew
            end
        end
        SetPortraitToTexture(auraCD.texture, icon)
        auraCD:SetCooldown(expirationTime-duration, duration)
        auraCD:Show()
    else
        auraCD:Hide()
    end
end


f.SimpleTargetFrameHook = function(self)
    local frame, frameName;
    local frameIcon, frameCount, frameCooldown;
    local numBuffs = 0;
    -- local playerIsTarget = UnitIsUnit(PlayerFrame.unit, self.unit);
    local selfName = self:GetName();
    local unit = self.unit
    local targetType = UnitIsFriend(unit, "player") and "ALLY" or "ENEMY"
    --[[ PORTRAIT AURA ]]
    local maxPrio = 0
    local maxPrioFilter
    local maxPrioIndex = 1

    for i = 1, MAX_TARGET_BUFFS do
        local buffName, icon, count, debuffType, duration, expirationTime, caster, canStealOrPurge, _ , spellId, _, _, casterIsPlayer, nameplateShowAll = UnitBuff(unit, i, nil);
        if (buffName) then
            frameName = selfName.."Buff"..(i);
            frame = _G[frameName];

            -- Handle cooldowns
            frameCooldown = _G[frameName.."Cooldown"];
            local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(unit, spellId, caster)
            if duration == 0 and durationNew then
                duration = durationNew
                expirationTime = expirationTimeNew
            end
            CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

            --[[ PORTRAIT AURA ]]
            if db.portraitIcon then
                local prio, spellType = LibAuraTypes.GetAuraInfo(spellId, targetType)
                if prio and prio > maxPrio then
                    maxPrio = prio
                    maxPrioIndex = i
                    maxPrioFilter = "HELPFUL"
                end
            end
        else
            break;
        end
    end


    local numDebuffs = 0;
    local frameNum = 1;
    local index = 1;

    local maxDebuffs = self.maxDebuffs or MAX_TARGET_DEBUFFS;
    while ( frameNum <= maxDebuffs and index <= maxDebuffs ) do
        local debuffName, icon, count, debuffType, duration, expirationTime, caster, _, _, spellId, _, _, casterIsPlayer, nameplateShowAll = UnitDebuff(unit, index, "INCLUDE_NAME_PLATE_ONLY");
        if ( debuffName ) then
            if ( TargetFrame_ShouldShowDebuffs(self.unit, caster, nameplateShowAll, casterIsPlayer) ) then
                frameName = selfName.."Debuff"..frameNum;
                frame = _G[frameName];

                -- Handle cooldowns
                frameCooldown = _G[frameName.."Cooldown"];
                local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(self.unit, spellId, caster)
                if duration == 0 and durationNew then
                    duration = durationNew
                    expirationTime = expirationTimeNew
                end
                CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

                frameNum = frameNum + 1;

                --[[ PORTRAIT AURA ]]
                if db.portraitIcon then
                    local prio, spellType = LibAuraTypes.GetAuraInfo(spellId, targetType)
                    if prio and prio > maxPrio then
                        maxPrio = prio
                        maxPrioIndex = index
                        maxPrioFilter = "HARMFUL"
                    end
                end
            end
        else
            break;
        end
        index = index + 1;
    end

    --[[ PORTRAIT AURA ]]
    if db.portraitIcon then
        UpdatePortraitIcon(TargetFrame, self.unit, maxPrio, maxPrioIndex, maxPrioFilter, targetType)
    end
end

f:RegisterEvent("PLAYER_LOGOUT")
function f.PLAYER_LOGOUT(self, event)
    RemoveDefaults(ClassicAuraDurationsDB, defaults)
end

f:RegisterEvent("PLAYER_LOGIN")
function f.PLAYER_LOGIN(self, event)
    ClassicAuraDurationsDB = ClassicAuraDurationsDB or {}
    SetupDefaults(ClassicAuraDurationsDB, defaults)
    db = ClassicAuraDurationsDB

    SLASH_CLASSICAURADURATIONS1= "/cad"
    SLASH_CLASSICAURADURATIONS2= "/classicauraduration"
    SlashCmdList["CLASSICAURADURATIONS"] = self.SlashCmd

    LibClassicDurations = LibStub("LibClassicDurations")
    LibClassicDurations:RegisterFrame(addon)

    LibAuraTypes = LibStub("LibAuraTypes")
    LibSpellLocks = LibStub("LibSpellLocks")

    LibSpellLocks.RegisterCallback(addon, "UPDATE_INTERRUPT", function(event, guid)
        if UnitGUID("target") == guid then
            TargetFrame_UpdateAuras(TargetFrame)
        end
    end)

    ShouldAuraBeLarge = db.largePersonalDebuffs and ShouldAuraBeLargePersonalDebuffs or ShouldAuraBeLargeAlways

    local makePortraitOverlay = function(frame, portraitGlobalName)
        local originalPortrait = _G[portraitGlobalName];

        local auraCD = CreateFrame("Cooldown", "CAD"..portraitGlobalName, frame, "CooldownFrameTemplate")
        auraCD:SetParent(frame)
        auraCD:SetFrameStrata("LOW")
        if frame == PlayerFrame then
            auraCD:SetFrameLevel(2)
        else
            auraCD:SetFrameLevel(1)
        end
        auraCD:SetDrawEdge(false);
        -- auraCD:SetHideCountdownNumbers(true);
        auraCD:SetReverse(true)
        auraCD:SetSwipeTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMaskSmall")
        auraCD:SetAllPoints(originalPortrait)
        frame.CADPortraitFrame = auraCD
        auraCD.originalPortrait = originalPortrait

        local auraIconTexture = auraCD:CreateTexture(nil, "BORDER", nil, 2)
        auraIconTexture:SetAllPoints(originalPortrait)
        -- auraIconTexture:Hide()
        -- SetPortraitToTexture(auraIconTexture, 136039)
        auraCD.texture = auraIconTexture
        auraCD:Hide()
    end
    makePortraitOverlay(TargetFrame, "TargetFramePortrait")
    makePortraitOverlay(PlayerFrame, "PlayerPortrait")

    if db.hookTargetFrame then
        if db.enemyBuffs then
            hooksecurefunc("TargetFrame_UpdateAuras", f.EnemyBuffsTargetFrameHook)
            LibClassicDurations.RegisterCallback(addon, "UNIT_BUFF", function(event, unit)
                TargetFrame_UpdateAuras(TargetFrame)
            end)
        else
            hooksecurefunc("TargetFrame_UpdateAuras", f.SimpleTargetFrameHook)
        end
    end

    hooksecurefunc("CompactUnitFrame_UtilSetBuff", function(buffFrame, unit, index, filter)
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId, canApplyAura = UnitBuff(unit, index, filter);
        local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(unit, spellId, unitCaster)
        if duration == 0 and durationNew then
            duration = durationNew
            expirationTime = expirationTimeNew
        end
        local enabled = expirationTime and expirationTime ~= 0;
        if enabled then
            local startTime = expirationTime - duration;
            CooldownFrame_Set(buffFrame.cooldown, startTime, duration, true);
        else
            CooldownFrame_Clear(buffFrame.cooldown);
        end
    end)

    hooksecurefunc("CompactUnitFrame_UtilSetDebuff", function(debuffFrame, unit, index, filter, isBossAura, isBossBuff)
        local name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId;
        if (isBossBuff) then
            name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId = UnitBuff(unit, index, filter);
        else
            name, icon, count, debuffType, duration, expirationTime, unitCaster, canStealOrPurge, _, spellId = UnitDebuff(unit, index, filter);
        end

        local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(unit, spellId, unitCaster)
        if duration == 0 and durationNew then
            duration = durationNew
            expirationTime = expirationTimeNew
        end

        local enabled = expirationTime and expirationTime ~= 0;
        if enabled then
            local startTime = expirationTime - duration;
            CooldownFrame_Set(debuffFrame.cooldown, startTime, duration, true);
        else
            CooldownFrame_Clear(debuffFrame.cooldown);
        end
    end)

    self:RegisterUnitEvent("UNIT_AURA", "player") -- for player portrait icon

    --[[
    -- fuck this, PartyDebuffFrameTemplate doesn't create PartyMemberFrame1Debuff1Cooldown, even on live
    -- ToT frame does ( and also using this), but it also just spams this function in some OnUpdate probably

    hooksecurefunc("RefreshDebuffs", function(frame, unit, numDebuffs, suffix, checkCVar)
        if not unit:find("party") then return end

        local frameName = frame:GetName();
        numDebuffs = numDebuffs or MAX_PARTY_DEBUFFS;
        suffix = suffix or "Debuff";
        local filter;
        if ( checkCVar and SHOW_DISPELLABLE_DEBUFFS == "1" and UnitCanAssist("player", unit) ) then
            filter = "RAID";
        end

        for i=1, numDebuffs do
            local name, icon, count, debuffType, duration, expirationTime, caster, _, _, spellId = UnitDebuff(unit, i, filter);

            local debuffName = frameName..suffix..i;
            print(unit, i, numDebuffs, name, spellId, caster)
            if ( icon and ( SHOW_CASTABLE_DEBUFFS == "0" or not isEnemy or caster == "player" ) ) then
                -- if we have an icon to show then proceed with setting up the aura

                print(name, spellId, caster)
                local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(unit, spellId, caster)
                if duration == 0 and durationNew then
                    duration = durationNew
                    expirationTime = expirationTimeNew


                    local cdname = debuffName.."Cooldown"
                    local coolDown = _G[debuffName.."Cooldown"];
                    print("got duration", coolDown, frameName, cdname)
                    if ( coolDown ) then
                        print("setting", coolDown, expirationTime - duration, duration)
                        CooldownFrame_Set(coolDown, expirationTime - duration, duration, true);
                    end
                end
            end
        end

    end)
    ]]

    local loader = CreateFrame('Frame', nil, InterfaceOptionsFrame)
        loader:SetScript('OnShow', function(self)
            self:SetScript('OnShow', nil)

            if not f.optionsPanel then
                f.optionsPanel = f:CreateGUI("ClassicAuraDurations")
                InterfaceOptions_AddCategory(f.optionsPanel);
            end
        end)
end

function f:UNIT_AURA(event, unit)
    if unit == "player" then
        local maxPrio = 0
        local maxPrioFilter
        local maxPrioIndex = 1
        if db.playerPortraitIcon then
            for index=1,100 do --debuffs
                local name, icon, count, debuffType, duration, expirationTime, caster, _, _, spellId, _, _, casterIsPlayer, nameplateShowAll = UnitAura(unit, index, "HARMFUL");
                if not name then break end

                local prio, spellType = LibAuraTypes.GetAuraInfo(spellId, "ALLY")
                if prio and prio > maxPrio then
                    maxPrio = prio
                    maxPrioIndex = index
                    maxPrioFilter = "HARMFUL"
                end
            end

            for index=1,100 do --buffs
                local name, icon, count, debuffType, duration, expirationTime, caster, _, _, spellId, _, _, casterIsPlayer, nameplateShowAll = UnitAura(unit, index, "HELPFUL");
                if not name then break end

                local prio, spellType = LibAuraTypes.GetAuraInfo(spellId, "ALLY")
                if prio and prio > maxPrio then
                    maxPrio = prio
                    maxPrioIndex = index
                    maxPrioFilter = "HELPFUL"
                end
            end

            UpdatePortraitIcon(PlayerFrame, unit, maxPrio, maxPrioIndex, maxPrioFilter, "ALLY")
        end
    end
end

local function MakeCheckbox(name, parent)
    local cb = CreateFrame("CheckButton", name, parent, "UICheckButtonTemplate")
    cb:SetWidth(25)
    cb:SetHeight(25)
    cb:Show()

    local cblabel = cb:CreateFontString(nil, "OVERLAY")
    cblabel:SetFontObject("GameFontHighlight")
    cblabel:SetPoint("LEFT", cb,"RIGHT", 5,0)
    cb.label = cblabel
    return cb
end

local tooltipOnEnter = function(self, event)
    GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT")
    GameTooltip:SetText(self.tooltipText, nil, nil, nil, nil, false);
    GameTooltip:Show();
end
local tooltipOnLeave = function(self, event)
    GameTooltip:Hide();
end
local function AddTooltip(widget, tooltipText)
    widget.tooltipText = tooltipText
    widget:SetScript("OnEnter", tooltipOnEnter)
    widget:SetScript("OnLeave", tooltipOnLeave)
end

function f:CreateGUI(name, parent)
    local frame = CreateFrame("Frame", nil, InterfaceOptionsFrame)
    frame:Hide()

    frame.parent = parent
    frame.name = name

    frame:SetScript("OnShow", function(self)
        self.content.enemyBuffs:SetChecked(db.enemyBuffs)
        self.content.portraitIcon:SetChecked(db.portraitIcon)
        self.content.hookTargetFrame:SetChecked(db.hookTargetFrame)
        self.content.verbosePortraitIcon:SetChecked(db.verbosePortraitIcon)
        self.content.playerPortraitIcon:SetChecked(db.playerPortraitIcon)
        self.content.largePersonalDebuffs:SetChecked(db.largePersonalDebuffs)
        self.content.largePersonalDebuffs:UpdateDisabled()
    end)
    -- frame:SetScript("OnHide", function(self) print("onHide") end)

    local label = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	label:SetPoint("TOPLEFT", 10, -15)
	label:SetPoint("BOTTOMRIGHT", frame, "TOPRIGHT", 10, -45)
	label:SetJustifyH("LEFT")
    label:SetJustifyV("TOP")

    label:SetText(name)

	local content = CreateFrame("Frame", "CADOptionsContent", frame)
	content:SetPoint("TOPLEFT", 10, -10)
    content:SetPoint("BOTTOMRIGHT", -10, 10)

    frame.content = content

    -- local warning = content:CreateFontString(nil, "OVERLAY")
    -- warning:SetFontObject("GameFontHighlightSmall")
    -- warning:SetPoint("TOPLEFT", 10, -40)
    -- warning:SetText("If you're getting 'Script ran too long' errors consider turning enemy buffs off or switching to non-standard unitframes")

    local htt = MakeCheckbox(nil, content)
    htt.label:SetText("Hook Target Frame")
    htt:SetPoint("TOPLEFT", 10, -60)
    content.hookTargetFrame = htt
    htt:SetScript("OnClick",function(self,button)
        f.Commands.hooktarget()
    end)
    AddTooltip(htt, "Enable aura durations on target frame")

    local ebt = MakeCheckbox(nil, content)
    ebt.label:SetText("Full Aura Replacement")
    ebt:SetPoint("TOPLEFT", 10, -90)
    content.enemyBuffs = ebt
    ebt:SetScript("OnClick",function(self,button)
        f.Commands.enemybuffs()
        self.content.largePersonalDebuffs:UpdateDisabled()
    end)
    AddTooltip(ebt, [=[As opposed to only adding cooldown swipes, completely duplicates default aura handling.
This allows to display large personal debuffs and some enemy buffs.
May cause 'Script ran too long errors'
]=])

    local pit = MakeCheckbox(nil, content)
    pit.label:SetText("Show Portrait Icon")
    pit:SetPoint("TOPLEFT", 10, -120)
    content.portraitIcon = pit
    pit:SetScript("OnClick",function(self,button)
        f.Commands.portraiticon()
    end)
    AddTooltip(pit, "Show CCs and other effects in the portrait")

    local vpi = MakeCheckbox(nil, content)
    vpi.label:SetText("Verbose Portrait Icon")
    vpi:SetPoint("TOPLEFT", 10, -150)
    content.verbosePortraitIcon = vpi
    vpi:SetScript("OnClick",function(self,button)
        f.Commands.verboseicon()
    end)
    AddTooltip(vpi, "Lowers the threshold of effects for portrait display. Will include slows and anything remotely important")

    local ppi = MakeCheckbox(nil, content)
    ppi.label:SetText("Player Portrait Icon")
    ppi:SetPoint("TOPLEFT", 10, -180)
    content.playerPortraitIcon = ppi
    ppi:SetScript("OnClick",function(self,button)
        f.Commands.playericon()
    end)
    AddTooltip(ppi, "Show icon on Player Frame")

    local lpd = MakeCheckbox(nil, content)
    lpd.label:SetText("Large Personal Debuffs")
    lpd:SetPoint("TOPLEFT", 10, -210)
    content.largePersonalDebuffs = lpd
    lpd:SetScript("OnClick",function(self,button)
        f.Commands.largepersonal()
    end)
    lpd.UpdateDisabled = function(self)
        if not db.enemyBuffs then
            self:Disable()
            self.label:SetTextColor(0.5, 0.5, 0.5)
        else
            self:Enable()
            self.label:SetTextColor(1,1,1)
        end
    end
    AddTooltip(lpd, "Auras that aren't casted by player will be smaller. Lower OmniCC size threshold to still see numeric display on them.")
    ebt.content = content

    return frame
end


f.Commands = {
    ["portraiticon"] = function(v)
        db.portraitIcon = not db.portraitIcon
    end,
    ["playericon"] = function(v)
        db.playerPortraitIcon = not db.playerPortraitIcon
    end,
    ["verboseicon"] = function(v)
        db.verbosePortraitIcon = not db.verbosePortraitIcon
    end,
    ["largepersonal"] = function(v)
        db.largePersonalDebuffs = not db.largePersonalDebuffs
        ShouldAuraBeLarge = db.largePersonalDebuffs and ShouldAuraBeLargePersonalDebuffs or ShouldAuraBeLargeAlways
    end,
    ["enemybuffs"] = function(v)
        db.enemyBuffs = not db.enemyBuffs
        ReloadUI()
    end,
    ["hooktarget"] = function(v)
        db.hookTargetFrame = not db.hookTargetFrame
        ReloadUI()
    end,
}

local helpMessage = {
    "|cff00ff00/cad portraiticon|r",
    "|cff00ff00/cad enemybuffs|r",
    "|cff00ff00/cad hooktarget|r",
}

function f.SlashCmd(msg)
    local k,v = string.match(msg, "([%w%+%-%=]+) ?(.*)")
    if not k or k == "help" then
        print("Usage:")
        for k,v in ipairs(helpMessage) do
            print(" - ",v)
        end
    end
    if f.Commands[k] then
        f.Commands[k](v)
    end
end


f.EnemyBuffsTargetFrameHook = function(self)
    local frame, frameName;
    local frameIcon, frameCount, frameCooldown;
    local numBuffs = 0;
    local playerIsTarget = UnitIsUnit(PlayerFrame.unit, self.unit);
    local selfName = self:GetName();
    local canAssist = UnitCanAssist("player", self.unit);


    local unit = self.unit
    local targetType = UnitIsFriend(unit, "player") and "ALLY" or "ENEMY"
    --[[ PORTRAIT AURA ]]
    local maxPrio = 0
    local maxPrioFilter
    local maxPrioIndex = 1

    for i = 1, MAX_TARGET_BUFFS do
        local buffName, icon, count, debuffType, duration, expirationTime, caster, canStealOrPurge, _ , spellId, _, _, casterIsPlayer, nameplateShowAll = LibClassicDurations:UnitAura(self.unit, i, "HELPFUL");
        if (buffName) then
            frameName = selfName.."Buff"..(i);
            frame = _G[frameName];
            if ( not frame ) then
                if ( not icon ) then
                    break;
                else
                    frame = CreateFrame("Button", frameName, self, "TargetBuffFrameTemplate");
                    frame.unit = self.unit;
                end
            end
            if ( icon and ( not self.maxBuffs or i <= self.maxBuffs ) ) then
                frame:SetID(i);

                -- set the icon
                frameIcon = _G[frameName.."Icon"];
                frameIcon:SetTexture(icon);

                -- set the count
                frameCount = _G[frameName.."Count"];
                if ( count > 1 and self.showAuraCount ) then
                    frameCount:SetText(count);
                    frameCount:Show();
                else
                    frameCount:Hide();
                end

                -- Handle cooldowns
                frameCooldown = _G[frameName.."Cooldown"];
                local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(self.unit, spellId, caster)
                if duration == 0 and durationNew then
                    duration = durationNew
                    expirationTime = expirationTimeNew
                end
                CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

                --[[ PORTRAIT AURA ]]
                if db.portraitIcon then
                    local prio, spellType = LibAuraTypes.GetAuraInfo(spellId, targetType)
                    if prio and prio > maxPrio then
                        maxPrio = prio
                        maxPrioIndex = i
                        maxPrioFilter = "HELPFUL"
                    end
                end

                -- Show stealable frame if the target is not the current player and the buff is stealable.
                local frameStealable = _G[frameName.."Stealable"];
                if ( not playerIsTarget and canStealOrPurge ) then
                    frameStealable:Show();
                else
                    frameStealable:Hide();
                end

                -- set the buff to be big if the buff is cast by the player or his pet
                numBuffs = numBuffs + 1;
                largeBuffList[numBuffs] = true--ShouldAuraBeLarge(caster);

                frame:ClearAllPoints();
                frame:Show();
            else
                frame:Hide();
            end
        else
            break;
        end
    end

    for i = numBuffs + 1, MAX_TARGET_BUFFS do
        local frame = _G[selfName.."Buff"..i];
        if ( frame ) then
            frame:Hide();
        else
            break;
        end
    end

    local color;
    local frameBorder;
    local numDebuffs = 0;

    local frameNum = 1;
    local index = 1;

    local maxDebuffs = self.maxDebuffs or MAX_TARGET_DEBUFFS;
    while ( frameNum <= maxDebuffs and index <= maxDebuffs ) do
        local debuffName, icon, count, debuffType, duration, expirationTime, caster, _, _, spellId, _, _, casterIsPlayer, nameplateShowAll = UnitDebuff(self.unit, index, "INCLUDE_NAME_PLATE_ONLY");
        if ( debuffName ) then
            if ( TargetFrame_ShouldShowDebuffs(self.unit, caster, nameplateShowAll, casterIsPlayer) ) then
                frameName = selfName.."Debuff"..frameNum;
                frame = _G[frameName];
                if ( icon ) then
                    if ( not frame ) then
                        frame = CreateFrame("Button", frameName, self, "TargetDebuffFrameTemplate");
                        frame.unit = self.unit;
                    end
                    frame:SetID(index);

                    -- set the icon
                    frameIcon = _G[frameName.."Icon"];
                    frameIcon:SetTexture(icon);

                    -- set the count
                    frameCount = _G[frameName.."Count"];
                    if ( count > 1 and self.showAuraCount ) then
                        frameCount:SetText(count);
                        frameCount:Show();
                    else
                        frameCount:Hide();
                    end

                    -- Handle cooldowns
                    frameCooldown = _G[frameName.."Cooldown"];
                    local durationNew, expirationTimeNew = LibClassicDurations:GetAuraDurationByUnit(self.unit, spellId, caster)
                    if duration == 0 and durationNew then
                        duration = durationNew
                        expirationTime = expirationTimeNew
                    end
                    CooldownFrame_Set(frameCooldown, expirationTime - duration, duration, duration > 0, true);

                    --[[ PORTRAIT AURA ]]
                    if db.portraitIcon then
                        local prio, spellType = LibAuraTypes.GetAuraInfo(spellId, targetType)
                        if prio and prio > maxPrio then
                            maxPrio = prio
                            maxPrioIndex = index
                            maxPrioFilter = "HARMFUL"
                        end
                    end

                    -- set debuff type color
                    if ( debuffType ) then
                        color = DebuffTypeColor[debuffType];
                    else
                        color = DebuffTypeColor["none"];
                    end
                    frameBorder = _G[frameName.."Border"];
                    frameBorder:SetVertexColor(color.r, color.g, color.b);

                    -- set the debuff to be big if the buff is cast by the player or his pet
                    numDebuffs = numDebuffs + 1;
                    largeDebuffList[numDebuffs] = ShouldAuraBeLarge(caster);

                    frame:ClearAllPoints();
                    frame:Show();

                    frameNum = frameNum + 1;
                end
            end
        else
            break;
        end
        index = index + 1;
    end

    for i = frameNum, MAX_TARGET_DEBUFFS do
        local frame = _G[selfName.."Debuff"..i];
        if ( frame ) then
            frame:Hide();
        else
            break;
        end
    end

    self.auraRows = 0;

    local mirrorAurasVertically = false;
    if ( self.buffsOnTop ) then
        mirrorAurasVertically = true;
    end
    local haveTargetofTarget;
    if ( self.totFrame ) then
        haveTargetofTarget = self.totFrame:IsShown();
    end
    self.spellbarAnchor = nil;
    local maxRowWidth;
    -- update buff positions
    maxRowWidth = ( haveTargetofTarget and self.TOT_AURA_ROW_WIDTH ) or AURA_ROW_WIDTH;
    TargetFrame_UpdateAuraPositions(self, selfName.."Buff", numBuffs, numDebuffs, largeBuffList, TargetFrame_UpdateBuffAnchor, maxRowWidth, 3, mirrorAurasVertically);
    -- update debuff positions
    maxRowWidth = ( haveTargetofTarget and self.auraRows < NUM_TOT_AURA_ROWS and self.TOT_AURA_ROW_WIDTH ) or AURA_ROW_WIDTH;
    TargetFrame_UpdateAuraPositions(self, selfName.."Debuff", numDebuffs, numBuffs, largeDebuffList, TargetFrame_UpdateDebuffAnchor, maxRowWidth, 3, mirrorAurasVertically);
    -- update the spell bar position
    if ( self.spellbar ) then
        Target_Spellbar_AdjustPosition(self.spellbar);
    end

    --[[ PORTRAIT AURA ]]
    if db.portraitIcon then
        UpdatePortraitIcon(TargetFrame, self.unit, maxPrio, maxPrioIndex, maxPrioFilter, targetType)
    end
end