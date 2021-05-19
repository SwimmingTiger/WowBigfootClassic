
-- obj:SetTexCoord(crop.left, crop.right, crop.top, crop.bottom)

local fraction, range, value, barsize, final

local function UpdateBar(self)
	range = self.MaxVal - self.MinVal 
	value = self.Value - self.MinVal
	
	barsize = self.Dim or 1

	local neutralSize = (self.NeutralMax - self.NeutralMin) / self.MaxVal
	local neutralLeft = barsize * ((self.NeutralMin) / self.MaxVal)
	local neutralRight = barsize * ((self.MaxVal -  self.NeutralMax) / self.MaxVal)
	
	if range > 0 and value > 0 and range >= value then
		fraction = value / range
	else fraction = .01 end
	if self.Orientation == "VERTICAL" then 
		self.Bar:SetHeight(barsize * fraction)
		final = self.Bottom - ((self.Bottom - self.Top) * fraction)		-- bottom = 1, top = 0
		self.Bar:SetTexCoord(self.Left, self.Right, final, self.Bottom)
		--self.Bar:SetTexCoord(0, 1, 1-fraction, 1)

		-- Set neutral zone size
		self.Neutral:ClearAllPoints()
		self.Neutral:SetPoint("BOTTOMLEFT", 0, neutralLeft)
		self.Neutral:SetPoint("TOPRIGHT", 0, -neutralRight)
	else 
		self.Bar:SetWidth(barsize * fraction)
		self.Neutral:SetWidth(barsize * neutralSize)
		final = ((self.Right - self.Left) * fraction) + self.Left
		self.Bar:SetTexCoord(self.Left, final, self.Top, self.Bottom)
		self.Neutral:SetTexCoord(self.Left, self.Right, self.Top, self.Bottom)

		-- Set neutral zone size
		self.Neutral:ClearAllPoints()
		self.Neutral:SetPoint("TOPLEFT", neutralLeft, 0)
		self.Neutral:SetPoint("BOTTOMRIGHT", -neutralRight, 0)
	end
	

end

local function UpdateSize(self)
	if self.Orientation == "VERTICAL" then self.Dim = self:GetHeight()
	else self.Dim = self:GetWidth() end
	UpdateBar(self)
end

local function SetValue(self, value) 
	if value >= self.MinVal and value <= self.MaxVal then self.Value = value end; 
	UpdateBar(self) 
end
	
local function SetStatusBarTexture(self, texture)
	self.Bar:SetTexture(texture)
	self.Neutral:SetTexture(texture)
end
local function SetStatusBarColor(self, r, g, b, a)
	a = a or 1
	self.Bar:SetVertexColor(r,g,b,a)
	self.Neutral:SetVertexColor(0,0,1,a/2)
end
local function SetStatusBarGradient(self, r1, g1, b1, a1, r2, g2, b2, a2) self.Bar:SetGradientAlpha(self.Orientation, r1, g1, b1, a1, r2, g2, b2, a2) end

--[[
local function SetStatusBarGradientAuto(self, r, g, b, a) 
	self.Bar:SetGradientAlpha(self.Orientation, .5+(r*1.1), g*.7, b*.7, a, r*.7, g*.7, .5+(b*1.1), a) 
end

local function SetStatusBarSmartGradient(self, r1, g1, b1, r2, g2, b2) 
	self.Bar:SetGradientAlpha(self.Orientation, r1, g1, b1, 1, r2 or r1, g2 or g1, b2 or b1, 1) 
end
--]]

local function SetAllColors(self, rBar, gBar, bBar, aBar, rBackdrop, gBackdrop, bBackdrop, aBackdrop) 
	self.Bar:SetVertexColor(rBar or 1, gBar or 1, bBar or 1, aBar or 1)
	self.Bar.color = {r = rBar or 1, g = gBar or 1, b = bBar or 1, a = aBar or 1}
	self.Neutral:SetVertexColor(rBar or 1, gBar or 1, bBar or 1, aBar or 1)
	self.Neutral.color = {r = rBar or 1, g = gBar or 1, b = bBar or 1, a = aBar or 1}
	self.Backdrop:SetVertexColor(rBackdrop or 1, gBackdrop or 1, bBackdrop or 1, aBackdrop or 1)
	self.Backdrop.color = {r = rBackdrop or 1, g = gBackdrop or 1, b = bBackdrop or 1, a = aBackdrop or 1}
end

local function SetOrientation(self, orientation) 
	if orientation == "VERTICAL" then
		self.Orientation = orientation
		self.Bar:ClearAllPoints()
		self.Bar:SetPoint("BOTTOMLEFT")
		self.Bar:SetPoint("BOTTOMRIGHT")
		self.Neutral:ClearAllPoints()
		self.Neutral:SetPoint("BOTTOMLEFT")
		self.Neutral:SetPoint("BOTTOMRIGHT")
	else
		self.Orientation = "HORIZONTAL"
		self.Bar:ClearAllPoints()
		self.Bar:SetPoint("TOPLEFT")
		self.Bar:SetPoint("BOTTOMLEFT")
		self.Neutral:ClearAllPoints()
		self.Neutral:SetPoint("TOPLEFT")
		self.Neutral:SetPoint("BOTTOMLEFT")
	end
	UpdateSize(self)
end

local function GetMinMaxValues(self)
	return self.MinVal, self.MaxVal
end


local function SetMinMaxValues(self, minval, maxval)
	if not (minval or maxval) then return end
	
	if maxval > minval then
		self.MinVal = minval
		self.MaxVal = maxval
	else 
		self.MinVal = 0
		self.MaxVal = 1
	end
	
	if self.Value > self.MaxVal then self.Value = self.MaxVal
	elseif self.Value < self.MinVal then self.Value = self.MinVal end
	
	UpdateBar(self) 
end

local function SetNeutralZone(self, minval, maxval, center, barmax)
	if not (minval or maxval) then return end

	if maxval > minval then
		self.NeutralMin = minval
		self.NeutralMax = maxval
	else 
		self.NeutralMin = 0
		self.NeutralMax = 0
	end

	self.NeutralCenter = center
	
	UpdateBar(self) 
end

local function SetTexCoord(self, left,right,top,bottom)		-- 0. 1. 0. 1
	self.Left, self.Right, self.Top, self.Bottom = left or 0, right or 1, top or 0, bottom or 1
	UpdateBar(self) 
end

local function SetBackdropTexCoord(self, left,right,top,bottom)		-- 0. 1. 0. 1
	self.Backdrop:SetTexCoord(left or 0, right or 1,top or 0, bottom or 1)
end

local function SetBackdropTexture(self, texture)		-- 0. 1. 0. 1
	self.Backdrop:SetTexture(texture)
end


function CreateNeatPlatesStatusbar(parent)
	local frame = CreateFrame("Frame", nil, parent, NeatPlatesBackdrop)
	--frame.Dim = 1
	frame:SetHeight(1)
	frame:SetWidth(1)
	frame.Value, frame.MinVal, frame.MaxVal, frame.Orientation = 1, 0, 1, "HORIZONTAL"
	frame.NeutralMin, frame.NeutralMax, frame.NeutralCenter = 0, 0, 0.5
	frame.Left, frame.Right, frame.Top, frame.Bottom = 0, 1, 0, 1
	frame.Bar = frame:CreateTexture(nil, "BORDER")
	frame.Backdrop = frame:CreateTexture(nil, "BACKGROUND")
	frame.Backdrop:SetAllPoints(frame)
	frame.Neutral = frame:CreateTexture(nil, "OVERLAY")
	frame.Neutral:Hide()
        
        --AddBorders(frame)
	
	frame.SetValue = SetValue
	frame.SetNeutralZone = SetNeutralZone
	frame.SetMinMaxValues = SetMinMaxValues
	frame.GetMinMaxValues = GetMinMaxValues
	frame.SetOrientation = SetOrientation
	frame.SetStatusBarColor = SetStatusBarColor
	frame.SetStatusBarGradient = SetStatusBarGradient
	--frame.SetStatusBarGradientAuto = SetStatusBarGradientAuto
	--frame.SetStatusBarSmartGradient = SetStatusBarSmartGradient
	frame.SetAllColors = SetAllColors
	frame.SetStatusBarTexture = SetStatusBarTexture
	frame.SetTexCoord = SetTexCoord
	frame.SetBackdropTexCoord = SetBackdropTexCoord
	frame.SetBackdropTexture = SetBackdropTexture
	
	frame:SetScript("OnSizeChanged", UpdateSize)
	UpdateSize(frame)
	return frame
end
