local L = LibStub("AceLocale-3.0"):GetLocale("ClassicCodex")

if not CodexUI then
    CodexUI = {
      ["api"] = {},
      ["cache"] = {},
      ["backdrop"] = {
        bgFile = "Interface\\Buttons\\WHITE8x8", tile = false, tileSize = 0,
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1,
        insets = {left = -1, right = -1, top = -1, bottom = -1},
      },
      ["backdrop_small"] = {
        bgFile = "Interface\\Buttons\\WHITE8x8", tile = false, tileSize = 0,
        edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1,
        insets = {left = 0, right = 0, top = 0, bottom = 0},
      },
      -- Different languages require different fonts, and 
      -- using inappropriate fonts will result in text not displaying correctly.
      -- So the choice of font needs to be localized.
      ["defaultFont"] = L["DEFAULT_FONT"],
     }
  
    CodexUIConfig = {
      ["appearance"] = {
        ["border"] = {
          ["background"] = "0,0,0,1",
          ["color"] = "0.2,0.2,0.2,1",
          ["default"] = "3",
        }
      },
      ["global"] = {
        ["fontSize"] = 12
      },
    }
  end
  
  -- Add API support non-CodexUI environments and for old CodexUI versions:
  -- strsplit, SanitizePattern, CreateBackdrop, SkinButton, CreateScrollFrame, CreateScrollChild
  if CodexUI.api and CodexUI.api.strsplit and CodexUI.api.CreateBackdrop and
     CodexUI.api.SkinButton and CodexUI.api.CreateScrollFrame and
     CodexUI.api.CreateScrollChild and CodexUI.api.SanitizePattern then
       return
  end
  
  function CodexUI.api.strsplit(delimiter, subject)
    if not subject then return nil end
    local delimiter, fields = delimiter or ":", {}
    local pattern = string.format("([^%s]+)", delimiter)
    string.gsub(subject, pattern, function(c) fields[table.getn(fields)+1] = c end)
    return unpack(fields)
  end
  
  local sanitize_cache = {}
  function CodexUI.api.SanitizePattern(pattern, dbg)
    if not sanitize_cache[pattern] then
      local ret = pattern
      -- escape magic characters
      ret = gsub(ret, "([%+%-%*%(%)%?%[%]%^])", "%%%1")
      -- remove capture indexes
      ret = gsub(ret, "%d%$","")
      -- catch all characters
      ret = gsub(ret, "(%%%a)","%(%1+%)")
      -- convert all %s to .+
      ret = gsub(ret, "%%s%+",".+")
      -- set priority to numbers over strings
      ret = gsub(ret, "%(.%+%)%(%%d%+%)","%(.-%)%(%%d%+%)")
      -- cache it
      sanitize_cache[pattern] = ret
    end
  
    return sanitize_cache[pattern]
  end
  
  function CodexUI.api.CreateBackdrop(f, inset, legacy, transp)
    -- exit if now frame was given
    if not f then return end
  
    -- use default inset if nothing is given
    local border = inset
    if not border then
      border = tonumber(CodexUIConfig.appearance.border.default)
    end
  
    -- bg and edge colors
    if not CodexUI.cache.br then
      local br, bg, bb, ba = CodexUI.api.strsplit(",", CodexUIConfig.appearance.border.background)
      local er, eg, eb, ea = CodexUI.api.strsplit(",", CodexUIConfig.appearance.border.color)
      CodexUI.cache.br, CodexUI.cache.bg, CodexUI.cache.bb, CodexUI.cache.ba = br, bg, bb, ba
      CodexUI.cache.er, CodexUI.cache.eg, CodexUI.cache.eb, CodexUI.cache.ea = er, eg, eb, ea
    end
  
    local br, bg, bb, ba =  CodexUI.cache.br, CodexUI.cache.bg, CodexUI.cache.bb, CodexUI.cache.ba
    local er, eg, eb, ea = CodexUI.cache.er, CodexUI.cache.eg, CodexUI.cache.eb, CodexUI.cache.ea
    if transp then ba = transp end
  
    -- use legacy backdrop handling
    if legacy then
      f:SetBackdrop(CodexUI.backdrop)
      f:SetBackdropColor(br, bg, bb, ba)
      f:SetBackdropBorderColor(er, eg, eb , ea)
      return
    end
  
    -- increase clickable area if available
    if f.SetHitRectInsets then
      f:SetHitRectInsets(-border,-border,-border,-border)
    end
  
    -- use new backdrop behaviour
    if not f.backdrop then
      f:SetBackdrop(nil)
  
      local border = tonumber(border) - 1
      local backdrop = CodexUI.backdrop
      if border < 1 then backdrop = CodexUI.backdrop_small end
        local b = CreateFrame("Frame", nil, f, BackdropTemplateMixin and "BackdropTemplate")
        b:SetPoint("TOPLEFT", f, "TOPLEFT", -border, border)
        b:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", border, -border)
  
      local level = f:GetFrameLevel()
      if level < 1 then
          --f:SetFrameLevel(level + 1)
        b:SetFrameLevel(level)
      else
        b:SetFrameLevel(level - 1)
      end
  
      f.backdrop = b
      b:SetBackdrop(backdrop)
    end
  
    local b = f.backdrop
    b:SetBackdropColor(br, bg, bb, ba)
    b:SetBackdropBorderColor(er, eg, eb , ea)
  end
  
  function CodexUI.api.SkinButton(button, cr, cg, cb)
    local b = getglobal(button)
    if not b then b = button end
    if not b then return end
    if not cr or not cg or not cb then
      _, class = UnitClass("player")
      local color = RAID_CLASS_COLORS[class]
      cr, cg, cb = color.r , color.g, color.b
    end
    CodexUI.api.CreateBackdrop(b, nil, true)
    b:SetNormalTexture(nil)
    b:SetHighlightTexture(nil)
    b:SetPushedTexture(nil)
    b:SetDisabledTexture(nil)
    local funce = b:GetScript("OnEnter")
    local funcl = b:GetScript("OnLeave")
    b:SetScript("OnEnter", function()
      if funce then funce() end
      CodexUI.api.CreateBackdrop(b, nil, true)
      b:SetBackdropBorderColor(cr,cg,cb,1)
    end)
    b:SetScript("OnLeave", function()
      if funcl then funcl() end
      CodexUI.api.CreateBackdrop(b, nil, true)
    end)
    b.font = b:CreateFontString("some string")
    b.font:SetFont(CodexUI.defaultFont, CodexUIConfig.global.fontSize, "OUTLINE")
    b:SetFontString(b.font)
  end
  
  function CodexUI.api.CreateScrollFrame(name, parent)
    local f = CreateFrame("ScrollFrame", name, parent)
  
    -- create slider
    f.slider = CreateFrame("Slider", nil, f)
    f.slider:SetOrientation('VERTICAL')
    f.slider:SetPoint("TOPLEFT", f, "TOPRIGHT", -7, 0)
    f.slider:SetPoint("BOTTOMRIGHT", 0, 0)
    f.slider:SetThumbTexture("Interface\\Buttons\\WHITE8x8")
    f.slider.thumb = f.slider:GetThumbTexture()
    f.slider.thumb:SetHeight(50)
    f.slider.thumb:SetColorTexture(.3,1,.8,.5)
  
    f.slider:SetScript("OnValueChanged", function(self)
      f:SetVerticalScroll(self:GetValue())
      f.UpdateScrollState()
    end)
  
    f.UpdateScrollState = function()
      f.slider:SetMinMaxValues(0, f:GetVerticalScrollRange())
      f.slider:SetValue(f:GetVerticalScroll())
  
      local m = f:GetHeight()+f:GetVerticalScrollRange()
      local v = f:GetHeight()
      local ratio = v / m
  
      if ratio < 1 then
        local size = math.floor(v * ratio)
        f.slider.thumb:SetHeight(size)
        f.slider:Show()
      else
        f.slider:Hide()
      end
    end
  
    f.Scroll = function(self, step)
      local step = step or 0
  
      local current = f:GetVerticalScroll()
      local max = f:GetVerticalScrollRange()
      local new = current - step
  
      if new >= max then
        f:SetVerticalScroll(max)
      elseif new <= 0 then
        f:SetVerticalScroll(0)
      else
        f:SetVerticalScroll(new)
      end
  
      f:UpdateScrollState()
    end
  
    f:EnableMouseWheel(1)
    f:SetScript("OnMouseWheel", function(self, arg1)
      self:Scroll(arg1*10)
    end)
  
    return f
  end
  
  function CodexUI.api.CreateScrollChild(name, parent)
    local f = CreateFrame("Frame", name, parent)
  
    -- dummy values required
    f:SetWidth(1)
    f:SetHeight(1)
    f:SetAllPoints(parent)
  
    parent:SetScrollChild(f)
  
    -- OnShow is fired too early, postpone to the first frame draw
    f:SetScript("OnUpdate", function(self)
      self:GetParent():Scroll()
      self:SetScript("OnUpdate", nil)
    end)
  
    return f
  end