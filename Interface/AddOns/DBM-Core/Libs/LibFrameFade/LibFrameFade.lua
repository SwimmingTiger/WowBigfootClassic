local LIBFRAMEFADE_VERSION = 4;

if LibFrameFade and (LibFrameFade.VERSION or 0) >= LIBFRAMEFADE_VERSION then
    return;
end

local function RehashTable(tbl)
    local strkey = "LibFrameFade_RehashKey";
    local numkey = 2^32;

    tbl[strkey] = nil;

    repeat
        if tbl[numkey] == nil then
            tbl[numkey] = nil;
        end

        numkey = numkey + 1;
    until issecurevariable(tbl, strkey);
end

LibFrameFade = LibFrameFade or CreateFrame("Frame");

function LibFrameFade:OnLoad()
    if not self.closures then
        self.closures = {};
    end

    if not self.hooks then
        self.hooks = {};
    end

    if not self.faderPool then
        -- luacheck: no unused
        local creationFunc = function(pool) return self:CreateFader(); end;
        local resetterFunc = function(pool, fader) return self:ResetFader(fader); end;

        self.faderPool = CreateObjectPool(creationFunc, resetterFunc);
        self.faderPool:SetResetDisallowedIfNew(true);
    end

    if not self.frameFaders then
        self.frameFaders = {};
    end

    -- For v4+ hooks can be disabled later if needed. Any earlier version
    -- unfortunately can't have hooks removed - to accomodate, the booleans
    -- for 'isUIFrameFadeHooked' and 'isUIFrameFadeRemoveFrameHooked' are
    -- kept around on the library table if we need to detect this one day.

    self:SecureHook("UIFrameFade", self:GetOrCreateMethodClosure("ProcessGlobalFadeFrames"));
    self:SecureHook("UIFrameFadeRemoveFrame", self:GetOrCreateMethodClosure("StopFadingFrame"));

    -- When upgrading or initially loading we should take ownership of any
    -- active fades being handled by UIFrameFade.

    self:ProcessGlobalFadeFrames();
end

function LibFrameFade:OnFaderFinished(fader)
    local fadeInfo = self:GetFadeInfoForFader(fader);

    self:ReleaseFader(fader);

    -- Dispatching the on-finish function should be the last thing done as
    -- we need to be in a state to allow new fades to be started on the frame
    -- we just finished with.

    if fadeInfo and fadeInfo.finishedFunc then
        local arg1 = fadeInfo.finishedArg1;
        local arg2 = fadeInfo.finishedArg2;
        local arg3 = fadeInfo.finishedArg3;
        local arg4 = fadeInfo.finishedArg4;

        xpcall(fadeInfo.finishedFunc, CallErrorHandler, arg1, arg2, arg3, arg4);
    end
end

function LibFrameFade:OnFaderStopped(fader, requested)  -- luacheck: no unused (requested)
    self:ReleaseFader(fader);
end

function LibFrameFade:OnFaderUpdate(fader, elapsed)  -- luacheck: no unused (elapsed)
    local frame = self:GetFrameForFader(fader);

    if not frame then
        return;
    end

    -- The smooth progress value reflects the current alpha progress of the
    -- animation and isn't affected by any start or end delays.
    local alpha = fader.Anim:GetSmoothProgress();
    frame:SetAlpha(alpha);
end

function LibFrameFade:IsFadingFrame(frame)
    return self.frameFaders[frame] ~= nil;
end

function LibFrameFade:StartFadingFrame(frame, fadeInfo)
    -- Clean up any ongoing fade operations for this frame before continuing.

    if self:IsFadingFrame(frame) then
        self:StopFadingFrame(frame);
    end

    local fader = self.faderPool:Acquire();

    -- The '.startAlpha' field on the 'fadeInfo' table is explicitly ignored
    -- when configuring the from-alpha value for the animation in favor of
    -- the current alpha value of the frame.
    --
    -- The reason is that we need to support the case where animations are
    -- already in-progress via UIFrameFade. This may happen if we're loaded
    -- late, or in an edge case where addons are possibly writing directly
    -- to the FADEFRAMES global bypassing our hooks until something triggers
    -- them later.
    --
    -- This works fine for both the above cases and the normal case where
    -- we're called at the start of a fade request, since the UIFrameFade
    -- function that we've hooked guarantees that the alpha of 'frame' will
    -- be set to the '.startAlpha' value.

    local fromAlpha = frame:GetAlpha();
    local toAlpha = fadeInfo.endAlpha;
    local duration = fadeInfo.timeToFade;
    local elapsed = fadeInfo.fadeTimer or 0;
    local endDelay = fadeInfo.fadeHoldTime or 0;

    fader.Anim:SetTarget(frame);
    fader.Anim:SetFromAlpha(fromAlpha);
    fader.Anim:SetToAlpha(toAlpha);
    fader.Anim:SetDuration(duration - elapsed);
    fader.Anim:SetEndDelay(endDelay);

    if self:ShouldFrameReceiveAlphaUpdates(frame) then
        fader:SetScript("OnUpdate", self:GetOrCreateMethodClosure("OnFaderUpdate"));
    end

    fader:Play();

    self.frameFaders[frame] = fader;
end

function LibFrameFade:StopFadingFrame(frame)
    local fader = self:GetFaderForFrame(frame);

    if not fader then
        return;
    end

    -- Note that because SetToFinalAlpha is in effect here the final alpha
    -- value on 'frame' after stopping the animation will be set according to
    -- its progress, which aligns with the behavior of UIFrameFadeRemoveFrame.

    fader:Stop();
end

function LibFrameFade:GetFaderForFrame(frame)
    return self.frameFaders[frame];
end

function LibFrameFade:GetFadeInfoForFrame(frame)
    return frame.fadeInfo;
end

function LibFrameFade:GetFadeInfoForFader(fader)
    local frame = self:GetFrameForFader(fader);
    local fadeInfo = frame and self:GetFadeInfoForFrame(frame) or nil;

    return fadeInfo;
end

function LibFrameFade:GetFrameForFader(fader)
    local frame = fader.Anim:GetTarget();

    -- 'self' is used as a sentinel value for target to indicate that there
    -- is no frame actively being faded by the fader. 'self' in particular
    -- is used because it's the default target on construction of the
    -- animation, and because we can't call 'Anim:SetTarget(nil)'.
    --
    -- As such if the target is 'self', redirect it to always be nil when
    -- queried.

    if frame == self then
        frame = nil;
    end

    return frame;
end

function LibFrameFade:CreateFader()
    local fader = self:CreateAnimationGroup();
    fader:SetScript("OnFinished", self:GetOrCreateMethodClosure("OnFaderFinished"));
    fader:SetScript("OnStop", self:GetOrCreateMethodClosure("OnFaderStopped"));
    fader:SetToFinalAlpha(true);

    fader.Anim = fader:CreateAnimation("Alpha");
    fader.Anim:SetOrder(1);

    return fader;
end

function LibFrameFade:ResetFader(fader)
    fader.Anim:SetTarget(self);  -- See GetFrameForFader for why we use 'self'.
    fader:SetScript("OnUpdate", nil);
end

function LibFrameFade:ReleaseFader(fader)
    local frame = self:GetFrameForFader(fader);

    if frame then
        self.frameFaders[frame] = nil;
    end

    if self.faderPool:IsActive(fader) then
        self.faderPool:Release(fader);
    end
end

function LibFrameFade:ProcessGlobalFadeFrames()
    local frames = FADEFRAMES;

    for index, frame in ipairs_reverse(frames) do
        local fadeInfo = self:GetFadeInfoForFrame(frame);

        self:StartFadingFrame(frame, fadeInfo);
        table.remove(frames, index);
    end

    -- Rehash the table to prevent taint due to UIFrameFade accessing
    -- keys directly as part of its loops.

    RehashTable(frames);
end

function LibFrameFade:ShouldFrameReceiveAlphaUpdates(frame)
    -- By rewriting the UIFrameFade system to be animation based, one defect
    -- that occurs is that SetAlpha is no longer called on each frame, which
    -- can interfere with other addons. One example is ElvUI's chat tabs
    -- which rely on a hook to prevent the tabs from fading out.
    --
    -- To work around this, if a SetAlpha method is present on the frame
    -- directly - instead of just being part of the metatable - we'll
    -- trigger a SetAlpha call every frame while the frame is fading.

    if rawget(frame, "SetAlpha") ~= nil then
        return true;
    else
        return false;
    end
end

function LibFrameFade:GetOrCreateMethodClosure(funcName, ...)
    local func = self.closures[funcName];

    if not func then
        func = GenerateClosure(function(...) return self[funcName](self, ...); end, ...);
        self.closures[funcName] = func;
    end

    return func;
end

function LibFrameFade:SecureHook(funcName, func)
    local isHookInstalled = (self.hooks[funcName] ~= nil);
    local isHookBeingRemoved = (func == nil);

    if not isHookInstalled and isHookBeingRemoved then
        return;  -- No hook is installed, thus there's nothing to remove.
    end

    -- All secure hooks go through a layer of indirection via our 'hooks'
    -- table to ensure that, if later required, we can disable them on
    -- upgrades.

    if isHookBeingRemoved then
        self.hooks[funcName] = nop;
    else
        self.hooks[funcName] = func;
    end

    if not isHookInstalled then
        hooksecurefunc(funcName, function(...) return self.hooks[funcName](...); end);
    end
end

function LibFrameFade:SecureUnhook(funcName)
    self:SecureHook(funcName, nil);
end

-- The UIFrameIsFading function is relied upon by a few addons and needs to
-- return correct results, which it won't due to our mucking around with
-- the FADEFRAMES table.
--
-- This function is unused by Blizzard in any live or test client for all
-- game flavors as of 9.1.0, 2.5.2, and 1.14.0 - as a result it should be
-- a safe replacement, despite tainting.

function UIFrameIsFading(frame)
    return LibFrameFade:IsFadingFrame(frame);
end

LibFrameFade:OnLoad();
LibFrameFade.VERSION = LIBFRAMEFADE_VERSION;
