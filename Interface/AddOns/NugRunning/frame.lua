local _, helpers = ...

local NugRunning = NugRunning
local LSM = LibStub("LibSharedMedia-3.0")

LSM:Register("statusbar", "Aluminium", [[Interface\AddOns\NugRunning\statusbar.tga]])
LSM:Register("font", "AlegreyaSans-Medium", [[Interface\AddOns\NugRunning\AlegreyaSans-Medium.ttf]],  GetLocale() ~= "enUS" and 15)

local isClassic = select(4,GetBuildInfo()) <= 19999
local UnitSpellHaste = isClassic and function() return 0 end or _G.UnitSpellHaste

local getStatusbar = function()
	if not NugRunningConfig.overrideTexture then
		return LSM:Fetch("statusbar", NugRunning.db.textureName)
	else return NugRunningConfig.texture end
end
local getFont = function(labelName)
	if not NugRunningConfig.overrideFonts then
		local s = NugRunning.db[labelName]
		return LSM:Fetch("font", s.font), s.size, s.alpha
	else
		local s = NugRunningConfig[labelName]
		return s.font, s.size, s.alpha
	end
end

local pixelperfect = helpers.pixelperfect

NugRunning.TimerBar = {}
local TimerBar = NugRunning.TimerBar


function TimerBar.SetName(self, name)
    self.spellText:SetText(name)
end

function TimerBar.SetColor(self,r,g,b)
    self.bar:SetStatusBarColor(r,g,b)
    self.bar.spark:SetVertexColor(r,g,b)
    self.bar.bg:SetVertexColor(r*.5, g*.5, b*.5)
end

function TimerBar.SetIcon(self, icon)
    self.icon:SetTexture(icon)
end

function TimerBar.SetCount(self,amount)
    if not amount then return end
    if self.opts.stackcolor then
        self:SetColor(unpack(self.opts.stackcolor[amount]))
    end
    if self.opts.glowstack then
        if self.glow then
            if amount >= self.opts.glowstack then
                if not self.glow:IsPlaying() then self.glow:Play() end
            else
                self.glow:Stop()
            end
        end
    end
    self.stacktext:SetText(amount)
    if amount > 1 then self.stacktext:Show()
    else self.stacktext:Hide() end
end

function TimerBar.SetTime(self, s,e, fixedoffset, animProgress)
    animProgress = animProgress or 1
    fixedoffset = fixedoffset or self.fixedoffset
    if not fixedoffset then fixedoffset = 0 end
    s = s or self.startTime
    e = e or self.endTime
    self.startTime = s
    self.endTime = e
    if not self._isMinimized then
        s = self.startTime + (fixedoffset*animProgress)
    end
    self._startTimeModified = s

    self.bar:SetMinMaxValues(s,e)
    self:UpdateMark()
end
local function getbarpos(timer, time)
    local duration = timer.endTime - (timer._startTimeModified or timer.startTime)
    if duration == 0 then return 0 end
    local progress
    if time >= 0 then
        progress = time / duration
    else
        progress = (duration+time) / duration
    end
    if progress > 1 then progress = 1 end
    return progress * timer.bar:GetWidth(), progress
end
helpers.getbarpos = getbarpos

function TimerBar.MoveMark(self, time)
    local pos, percent = getbarpos(self, time)
    self.mark:SetPoint("CENTER",self.bar,"LEFT",pos,0)
    if percent < 0.02 then
        self.mark:Hide()
        self.mark.texture:Hide()
    else
        self.mark:Show()
        self.mark.texture:Show()
    end
end

local function clear_overlay_point(p, self, ticktime)
    if type(p) == "string" then
        if p == "tick" then
            return ticktime
        elseif p == "tickend" then
            if not ticktime then return nil end
            return min(ticktime+self.tickPeriod, self.endTime-self.startTime)
        elseif p == "end" then
            return self.endTime-self.startTime
        elseif p == "gcd" then
            return (1.5/(1+(UnitSpellHaste("player")/100)))
        end
    else return p end
end

function TimerBar.UpdateMark(self, time) -- time - usually closest tick time
    if self.timeless then
        self.overlay2:Hide()
        self.mark:Hide()
        self.mark.texture:Hide()
        return
    end
    if self.tickPeriod then
        if time then
            if time > 0 then
                local pos = getbarpos(self, time)
                self.mark:SetPoint("CENTER",self.bar,"LEFT",pos,0)
                self.mark:Show()
                self.mark.texture:Show()
            else
                self.mark:Hide()
                self.mark.texture:Hide()
            end
        end
    elseif self.opts.recast_mark then
        local rm = clear_overlay_point(self.opts.recast_mark, self, time)
        local pos = getbarpos(self, rm)
        self.mark:SetPoint("CENTER",self.bar,"LEFT",pos,0)
        self.mark.spark:CatchUp()
        self.mark:Show()
        self.mark.texture:Show()
    else
        self.mark:Hide()
        self.mark.texture:Hide()
    end

    local overlay2 = self.opts.overlay
    if overlay2 then

        local t1 = clear_overlay_point(overlay2[1], self, time)
        local t2 = clear_overlay_point(overlay2[2], self, time)

        local hastereduced = overlay2[4]
        if hastereduced then
            local duration = t2 - t1
            duration = (duration/(1+(UnitSpellHaste("player")/100)))
            t2 = t1 + duration
        end
        self.overlay2.t1 = t1
        self.overlay2.t2 = t2

        if not t1 or not t2 then
            return -- skip when point contains "tick" or "tickend", but it's not tick update call
        end
        local pos1 = getbarpos(self, t1)
        local pos2 = getbarpos(self, t2)
        local alpha = overlay2[3] or 0.2
        if pos2 > pos1 then
            self.overlay2:SetPoint("TOPLEFT", self.bar, "TOPLEFT", pos1, 0)
            self.overlay2:SetPoint("BOTTOMRIGHT", self.bar, "BOTTOMLEFT", pos2, 0)
            self.overlay2:SetVertexColor(0,0,0, alpha)
            self.overlay2:Show()
        else
            self.overlay2:Hide()
        end
    else
        self.overlay2:Hide()
    end
end
function TimerBar.SetMinMaxCharge(self, min, max)
    self.bar:SetMinMaxValues(min,max)
end
function TimerBar.SetCharge(self,val)
    self.bar:SetValue(val)
    if self.opts.stackcolor then
        self:SetColor(unpack(self.opts.stackcolor[val]))
    end
    if self.opts.glowstack then
        if self.glow then
            if val >= self.opts.glowstack then
                if not self.glow:IsPlaying() then self.glow:Play() end
            else
                self.glow:Stop()
            end
        end
    end
end


function TimerBar.ToInfinite(self)
    self.bar:SetMinMaxValues(0,100)
    self.bar:SetValue(100)
    self.startTime = GetTime()
    self.endTime = self.startTime + 1
    self.timeText:SetText("")
    self:UpdateMark()
end

function TimerBar.ToGhost(self)
    if self._isMinimized then
        local scale = self.opts.scale or 1
        self:VScale(scale)
    end
    self:SetColor(0.5,0,0)
    self.timeText:SetText("")
    self.bar:SetValue(0)
    if self.glow:IsPlaying() then self.glow:Stop() end
    --self:SetAlpha(0.8)
    self.mark:Hide()
    self.mark.texture:Hide()
end
do
    local hour, minute = 3600, 60
    local format = string.format
    local ceil = math.ceil
    function TimerBar.FormatTime(self, s)
        if s >= hour then
            return "%dh", ceil(s / hour)
        elseif s >= minute*2 then
            return "%dm", ceil(s / minute)
        elseif s >= 30 then
            return "%ds", floor(s)
        end
        return "%.1f", s
    end
end

function TimerBar.Update(self, beforeEnd)
    self.bar:SetValue(beforeEnd + (self._startTimeModified or self.startTime))
    self.timeText:SetFormattedText(self:FormatTime(beforeEnd))
end


function TimerBar.Resize1(self, width, height)
    self:SetWidth(width)
    self:SetHeight(height)
    self.mark:SetHeight(height*0.9)
    self.mark.spark:SetHeight(height*2.6)
    self.bar:SetWidth(width - self._height - 1)
    self.bar:SetHeight(height)
    self.bar.spark:SetHeight(height)
    self.bar.spark:SetWidth(height*2)
    self.spellText:SetWidth(self.bar:GetWidth()*0.8)
    self.spellText:SetHeight(height/2+1)
end

function TimerBar.UpdateFonts(f)
    local nameFont, nameSize, nameAlpha = getFont("nameFont")
    f.spellText:SetFont(nameFont, nameSize)
    f.spellText:SetAlpha(nameAlpha or 1)

    local stackFont, stackSize, _stackAlpha = getFont("stackFont")
    f.stacktext:SetFont(stackFont, stackSize, "OUTLINE")

    local timeFont, timeSize, timeAlpha = getFont("timeFont")
    f.timeText:SetFont(timeFont, timeSize)
    f.timeText:SetJustifyH("RIGHT")
    f.timeText:SetAlpha(timeAlpha or 1)
end

function TimerBar.UpdateTexture(f)
    local texture = getStatusbar()
    f.bar:SetStatusBarTexture(texture)
	f.bar.bg:SetTexture(texture)
end

function NugRunning.UpdateAllFonts()
    for i,timer in ipairs(NugRunning.timers) do
        timer:UpdateFonts()
    end
end
function NugRunning.UpdateAllTextures()
    for i,timer in ipairs(NugRunning.timers) do
        timer:UpdateTexture()
    end
end
function NugRunning.UpdateAllNameplateTextures()
    for i,f in ipairs(NugRunning.nameplate_timers) do
        local texture = LSM:Fetch("statusbar", NugRunning.db.nptextureName)
        f:SetStatusBarTexture(texture)
        f.bg:SetTexture(texture)
    end
end

function TimerBar:UpdateFrameBorder(borderType)
    if self.border then self.border:Hide() end
    if self.backdrop then self.backdrop:Hide() end

    if borderType == "2PX" then
        self.backdrop = self.backdrop or self:CreateTexture(nil, "BACKGROUND", nil, -2)
        local backdrop = self.backdrop
        local offset = pixelperfect(2, self)
        backdrop:SetTexture("Interface\\BUTTONS\\WHITE8X8")
        backdrop:SetVertexColor(0,0,0, 0.5)
        backdrop:SetPoint("TOPLEFT", -offset, offset)
        backdrop:SetPoint("BOTTOMRIGHT", offset, -offset)
        backdrop:Show()

    elseif borderType == "1PX" then
        self.backdrop = self.backdrop or self:CreateTexture(nil, "BACKGROUND", nil, -2)
        local backdrop = self.backdrop
        local offset = pixelperfect(1, self)
        backdrop:SetTexture("Interface\\BUTTONS\\WHITE8X8")
        backdrop:SetVertexColor(0,0,0, 1)
        backdrop:SetPoint("TOPLEFT", -offset, offset)
        backdrop:SetPoint("BOTTOMRIGHT", offset, -offset)
        backdrop:Show()
    -- elseif borderType == "3PX" then
    --     self.border = self.border or CreateFrame("Frame", nil, self)
    --     local border = self.border
    --     local offset = pixelperfect(3)
    --     border:SetPoint("TOPLEFT", -offset, offset)
    --     border:SetPoint("BOTTOMRIGHT", offset, -offset)
    --     border:SetBackdrop({
    --         edgeFile = "Interface\\AddOns\\NugRunning\\border_3px", edgeSize = 8, tileEdge = false,
    --     })
    --     border:SetBackdropBorderColor(0.4,0.4,0.4)
    --     border:Show()
    end
end


function TimerBar.Remains(self)
    return self.endTime - GetTime()
end
function TimerBar:GetVScale()
    return self._scale
end
function TimerBar.VScale(self, scale)
    if scale == self._scale then return end
    if scale > 2 then scale = 2 end
    -- if not self._scale and scale == 1 then return end -- already at full size

    self._scale = scale
    local height = self._height * scale
    local width = self._width
    self:Resize1(width, height)

    if scale <= 1 then
        local x = 0.8 * (1-scale) * 0.5 -- half of the texcoord height * scale difference
        self.icon:SetTexCoord(.1, .9, .1+x, .9-x)
    elseif scale <=2 then
        local x = self._height/height * 0.4
        self.icon:SetTexCoord(.5-x, .5+x, .1, .9)
    end

    self.icon:GetParent():SetHeight(height)
    self.shine:GetParent():SetHeight(height*1.8)
    self.shine:Stop()
    self.shine.tex:SetAlpha(0)

    self._isMinimized = scale <= 0.4

    if scale < 0.7 then
        self.spellText:Hide()
        self.timeText:Hide()
    else
        self.spellText:Show()
        self.timeText:Show()
    end

    -- if scale == 1 then self._scale = nil end
end

function TimerBar.Resize(self, width, height)
    width = pixelperfect(width)
    height = pixelperfect(height)

    self._width = width
    self._height = height

    self:Resize1(width, height)

    self.icon:GetParent():SetWidth(height)
    self.icon:GetParent():SetHeight(height)
    self.shine:GetParent():SetWidth(height*1.8)
    self.shine:GetParent():SetHeight(height*1.8)
end

function TimerBar.SetPowerStatus(self, status, powerdiff)
    if status == "HIGH" then
        self.status:SetTextColor(.5,1,.5)
        self.status:SetText("+"..powerdiff.."%")
        self.status:Show()
        self.status.bg:Show()
    elseif status == "LOW" then
        self.status:SetTextColor(1,.1,.1)
        self.status:SetText(powerdiff.."%")
        self.status:Show()
        self.status.bg:Show()
    else
        self.status:Hide()
        self.status.bg:Hide()
    end
end

function TimerBar.ShowOverlayGlow(self)
    local self = self.iconframe
	if ( self.overlay ) then
		if ( self.overlay.animOut:IsPlaying() ) then
			self.overlay.animOut:Stop();
			self.overlay.animIn:Play();
		end
	else
		self.overlay = ActionButton_GetOverlayGlow();
		local frameWidth, frameHeight = self:GetSize();
        -- print(frameWidth,frameHeight)
        -- self.overlay.animIn:Play();
		-- self.overlay.animIn:Stop();
		self.overlay:SetParent(self:GetParent());
		self.overlay:ClearAllPoints();
		--Make the height/width available before the next frame:
		self.overlay:SetSize(frameWidth * 1.4, frameHeight * 1.4);
		self.overlay:SetPoint("TOPLEFT", self, "TOPLEFT", -frameWidth * 0.2, frameHeight * 0.2);
		self.overlay:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", frameWidth * 0.2, -frameHeight * 0.2);
		self.overlay.animIn:Play();
	end
end

local Redraw = function(self)
    if not self.model_path then return end

    self:SetModelScale(1)
    -- self:ClearTransform()
    self:SetPosition(0,0,0)

    self:SetModel(self.model_path)

    self:SetModelScale(self.model_scale)
    self:SetPosition(self.ox, self.oy, self.oz)
    -- if self.transform then
    --     -- it's not working, probably because of the nextframe bullshit
    --     self:SetTransform(unpack(self.transform))
    -- end
end

local ResetTransformations = function(self)
    -- print(self:GetName(), "hiding", self:GetCameraDistance(), self:GetCameraPosition())
    self:SetModelScale(1)
    -- self:ClearTransform()
    self:SetPosition(0,0,0)
end

local SparkSetValue = function(self, v)
    local min, max = self:GetMinMaxValues()
    local total = max-min
    local p
    if total == 0 then
        p = 0
    else
        p = (v-min)/(max-min)
        if p > 1 then p = 1 end
    end
    local len = p*self:GetWidth()
    self.spark:SetPoint("CENTER", self, "LEFT", len, 0)
    return self:NormalSetValue(v)
end

function TimerBar.EnableSpark(self, isEnabled)
    if isEnabled then
        self.bar.spark:Show()
        self.bar.SetValue = SparkSetValue
    else
        self.bar.spark:Hide()
        self.bar.SetValue = self.bar.NormalSetValue
    end
end

NugRunning.ConstructTimerBar = function(width, height)
    local f = CreateFrame("Frame",nil,UIParent)
    Mixin(f, TimerBar)

    f:SetWidth(width)
    f:SetHeight(height)

    f:UpdateFrameBorder("2PX")

    local ic = CreateFrame("Frame",nil,f)
    ic:SetPoint("TOPLEFT",f,"TOPLEFT", 0, 0)
    ic:SetWidth(height)
    ic:SetHeight(height)
    ic:SetFrameLevel(1)
    local ict = ic:CreateTexture(nil,"ARTWORK",0)
    ict:SetTexCoord(.1, .9, .1, .9)
    ict:SetAllPoints(ic)
    f.icon = ict
    f.iconframe = ic

    f.stacktext = ic:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    f.stacktext:SetTextColor(1,1,1)
    local stackFont, stackSize, _stackAlpha = getFont("stackFont")
    f.stacktext:SetFont(stackFont, stackSize, "OUTLINE")
    f.stacktext:SetJustifyH("RIGHT")
    f.stacktext:SetVertexColor(1,1,1)
    f.stacktext:SetPoint("RIGHT", ic, "RIGHT",1,-5)

    local bar = CreateFrame("StatusBar",nil,f)
    bar:SetFrameStrata("MEDIUM")
    local texture = getStatusbar()
    bar:SetStatusBarTexture(texture)
    bar:GetStatusBarTexture():SetDrawLayer("ARTWORK")
    bar:SetHeight(height)
    bar:SetWidth(width - height - 1)
    bar:SetPoint("TOPRIGHT",f,"TOPRIGHT",0,0)

    bar.bg = bar:CreateTexture(nil, "BORDER")
	bar.bg:SetAllPoints(bar)
    bar.bg:SetTexture(texture)

    local spark = bar:CreateTexture(nil, "ARTWORK", nil, 4)
    spark:SetBlendMode("ADD")
    spark:SetTexture([[Interface\AddOns\NugRunning\spark.tga]])
    spark:SetSize(bar:GetHeight()*2, bar:GetHeight())
    spark:SetPoint("CENTER", bar, "TOP",0,0)
    spark:Hide()

    bar.spark = spark

    f.bar = bar

    bar.NormalSetValue = bar.SetValue
    bar.SparkSetValue = SparkSetValue

    f.timeText = f.bar:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
    f.timeText:SetTextColor(1,1,1)
    local timeFont, timeSize, timeAlpha = getFont("timeFont")
    f.timeText:SetFont(timeFont, timeSize)
    f.timeText:SetJustifyH("RIGHT")
    f.timeText:SetAlpha(timeAlpha or 1)
    f.timeText:SetVertexColor(1,1,1)
    f.timeText:SetPoint("RIGHT", f.bar, "RIGHT",-6,0)

    f.spellText = f.bar:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    f.spellText:SetTextColor(1,1,1)
    local nameFont, nameSize, nameAlpha = getFont("nameFont")
    f.spellText:SetFont(nameFont, nameSize)
    f.spellText:SetWidth(f.bar:GetWidth()*0.8)
    f.spellText:SetHeight(height/2+1)
    f.spellText:SetJustifyH("CENTER")
    f.spellText:SetAlpha(nameAlpha or 1)
    f.spellText:SetPoint("LEFT", f.bar, "LEFT",6,0)

    local overlay = f.bar:CreateTexture(nil, "ARTWORK", nil, 3)
    overlay:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    overlay:SetVertexColor(0,0,0, 0.2)
    overlay:Hide()
    f.overlay2 = overlay


    local arrow = f:CreateTexture(nil, "ARTWORK",nil,3)
    arrow:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    arrow:SetHeight(height)
    arrow:SetWidth(height/4)
    arrow:SetPoint("TOPRIGHT", f, "TOPLEFT",-3, 0)
    arrow:SetPoint("BOTTOMRIGHT", f, "BOTTOMLEFT",-3, 0)
    -- arrow:SetPoint("RIGHT", f, "LEFT",0,-5)
    arrow:SetVertexColor(1,0,0)
    arrow:Hide()

    local glow2 = arrow:CreateAnimationGroup()
    local g2a1 = glow2:CreateAnimation("Rotation")
    -- g2a1:SetChange(0.5)
    g2a1:SetDegrees(360)
    g2a1:SetSmoothing("IN_OUT")
    g2a1:SetDuration(1)
    g2a1:SetOrder(1)
    glow2:SetLooping("BOUNCE")
    f.arrowglow = glow2
    f.arrow = arrow

    -- local arrow = f.bar:CreateTexture(nil, "ARTWORK", nil, 5)
    -- arrow:SetSize(11, 10)
    -- arrow:SetTexture("Interface\\AddOns\\NugRunning\\arrows")
    -- -- arrow:SetTexCoord(0, 26/32, 0, 23/64)
    -- arrow:SetTexCoord(0, 26/32, 41/64, 1)
    -- -- arrow:SetVertexColor(0.3,1,0.3)
    -- arrow:SetVertexColor(1,0.3,0.3)
    -- arrow:SetPoint("RIGHT", f.bar, "RIGHT",-30,1)
    -- arrow:Hide()

    -- local status = f.bar:CreateTexture(nil, "ARTWORK", nil, 5)
    -- status:SetTexture("Interface\\BUTTONS\\WHITE8X8")
    -- -- status:SetPoint("TOPRIGHT", f.icon, "TOPLEFT", -2,0)
    -- -- status:SetPoint("BOTTOMLEFT", f.icon, "BOTTOMLEFT",-5,0)
    -- status:SetSize(width/2,height)
    -- status:SetPoint("TOPLEFT", f.bar, "TOPLEFT",0,0)
    -- -- status:SetPoint("TOPRIGHT", f.icon, "BOTTOMLEFT", 5,5)
    -- -- status:SetPoint("BOTTOMLEFT", f.icon, "BOTTOMLEFT",-1,-1)
    -- -- status:SetVertexColor(0, 0.8, 0, 1)
    -- status:Hide()

    -- local status = CreateFrame("Frame", nil, f.bar)

    local powertext = f.bar:CreateFontString()
    powertext:SetFont(nameFont, nameSize)
    powertext:SetPoint("BOTTOMLEFT", f.bar, "BOTTOMLEFT",13,0)

    local sbg = f.bar:CreateTexture(nil, "ARTWORK", nil, 5)
    sbg:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
    sbg:SetVertexColor(0,0,0, 0.6)
    sbg:SetAllPoints(powertext)
    powertext.bg = sbg
    f.status = powertext


    local at = ic:CreateTexture(nil,"OVERLAY")
    at:SetTexture([[Interface\SpellActivationOverlay\IconAlert]])
    at:SetTexCoord(0.00781250,0.50781250,0.27734375,0.52734375)
    --at:SetTexture([[Interface\AchievementFrame\UI-Achievement-IconFrame]])
    --at:SetTexCoord(0,0.5625,0,0.5625)
    at:SetWidth(height*1.8)
    at:SetHeight(height*1.8)
    at:SetPoint("CENTER",f.icon,"CENTER",0,0)
    at:SetAlpha(0)

    local sag = at:CreateAnimationGroup()
    local sa1 = sag:CreateAnimation("Alpha")
    sa1:SetFromAlpha(0)
    sa1:SetToAlpha(1)
    sa1:SetDuration(0.3)
    sa1:SetOrder(1)
    local sa2 = sag:CreateAnimation("Alpha")
    sa2:SetFromAlpha(1)
    sa2:SetToAlpha(0)
    sa2:SetDuration(0.5)
    sa2:SetOrder(2)

    -- sag:SetScript("OnFinished",function(self)
        -- self:GetParent():SetAlpha(0)
    -- end)

    f.shine = sag
    f.shine.tex = at



    local pmf = CreateFrame("PlayerModel", nil, f )
    pmf:SetFrameLevel(0)
    pmf:SetPoint("CENTER", ic, "LEFT", 0,0)
    pmf:SetSize(height*4, height*4)

    -- local ebg = pmf:CreateTexture(nil, "BACKGROUND")
    -- ebg:SetTexture("Interface\\AddOns\\NugRunning\\effect_bg.tga")
    -- ebg:SetPoint("RIGHT", f, "LEFT", -2, 0)
    -- ebg:SetVertexColor(0,0,0, 0.7)
    -- ebg:SetSize(height*1, height*1.5)

    pmf.model_scale = 1
    pmf.ox = 0
    pmf.oy = 0
    pmf.oz = 0

    pmf.SetEffect = function(self, effect)
        if effect == self._effect_name then return end
        self._effect_name = effect
        if type(effect) == "string" then
            effect = NugRunningConfig.effects[effect]
        end
        if not effect then return self:Hide() end
        self.model_path = effect.path
        self.model_scale = effect.model_scale or 1
        self.ox = effect.ox or 0
        self.oy = effect.oy or 0
        self.oz = effect.oz or 0
        -- self.transform = effect.transform
        local scale = effect.scale or 1
        self:SetSize(height*scale, height*scale)
        local x = effect.x or 0
        local y = effect.y or 0
        pmf:SetPoint("CENTER", ic, "LEFT", x, y)
        self:Hide()
    end

    pmf:SetScript("OnHide", ResetTransformations)
    pmf:SetScript("OnShow", Redraw)
    pmf.Redraw = Redraw
    pmf.ResetTransformations = ResetTransformations
    pmf:Hide()

    f.effect = pmf

    -- local shineglow = at:CreateAnimationGroup()
    -- local sg1 = sag:CreateAnimation("Alpha")
    -- sg1:SetFromAlpha(0)
    -- sg1:SetToAlpha(1)
    -- sg1:SetDuration(0.3)
    -- sg1:SetOrder(1)
    -- local sg2 = sag:CreateAnimation("Alpha")
    -- sg2:SetFromAlpha(1)
    -- sg2:SetToAlpha(0)
    -- sg2:SetDuration(0.3)
    -- sg2:SetOrder(2)
    -- shineglow:SetLooping("BOUNCE")
    -- f.shineglow = shineglow


    local aag = f:CreateAnimationGroup()
    local aa1 = aag:CreateAnimation("Scale")
    aa1:SetOrigin("BOTTOM",0,0)
    aa1:SetScale(1,0.1)
    aa1:SetDuration(0)
    aa1:SetOrder(1)
    local aa2 = aag:CreateAnimation("Scale")
    aa2:SetOrigin("BOTTOM",0,0)
    aa2:SetScale(1,10)
    aa2:SetDuration(0.15)
    aa2:SetOrder(2)

    local glow = f:CreateAnimationGroup()
    local ga1 = glow:CreateAnimation("Alpha")
    ga1:SetFromAlpha(1)
    ga1:SetToAlpha(0.5)
    ga1:SetDuration(0.25)
    ga1:SetOrder(1)
    glow:SetLooping("BOUNCE")
    f.glow = glow

    f.animIn = aag

    local m = CreateFrame("Frame",nil, f)
    m:SetParent(f)
    m:SetWidth(8)
    m:SetHeight(f:GetHeight()*0.9)
    m:SetFrameLevel(4)
    m:SetAlpha(0.6)
    m:SetPoint("CENTER",f.bar,"LEFT",10,0)

    local texture = m:CreateTexture(nil, "OVERLAY")
    texture:SetTexture("Interface\\AddOns\\NugRunning\\mark")
    texture:SetVertexColor(1,1,1,0.5)
    texture:SetAllPoints(m)
    m.texture = texture

    local spark = f.bar:CreateTexture(nil, "OVERLAY", nil, 2)
    spark:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
    spark:SetAlpha(0)
    spark:SetWidth(20)
    spark:SetHeight(16*4)
    -- spark:SetPoint("CENTER",m)
    spark:SetBlendMode('ADD')
    spark.mark = m
    spark.CatchUp = function(self)
        local p1, f, p2, x, y = self.mark:GetPoint()
        self:SetPoint(p1, f, p2, x, y)
    end
    spark:CatchUp()
    m.spark = spark

    local ag = spark:CreateAnimationGroup()
    local a1 = ag:CreateAnimation("Alpha")
    a1:SetFromAlpha(0)
    a1:SetToAlpha(1)
    a1:SetDuration(0.2)
    a1:SetOrder(1)
    local a2 = ag:CreateAnimation("Alpha")
    a2:SetFromAlpha(1)
    a2:SetToAlpha(0)
    a2:SetDuration(0.4)
    a2:SetOrder(2)

    ag:SetScript("OnFinished", function(self)
        self:GetParent():CatchUp()
    end)

    m.shine = ag

    f.mark = m

    return f
end
