-------------------------------------------
-- Package Animation Object for EASCDFrame
-------------------------------------------
EAEXF = {
	AlreadyAlert = false,
	FrameCount = 0,
	Prefraction = 0,
	totalTime = 0.6,		--動畫持續時間
	MaxCount = 19,			--最大張數
	FrameAnimTable = {},
	maxWidth = 256,
}
function EAEXF:AnimAlpha(fraction)
	
	local bgFilePath
	local EventAlert_Image_Path = "Interface/AddOns/EventAlertMod/images/"	
	
	local o = EAEXF	
	local iAlpha = self:GetAlpha()	
	local iSize = self:GetWidth()	
	local maxWidth = o.maxWidth
	local stepSize = maxWidth / o.MaxCount
	
	if o.Prefraction == 0 then 
		o.Prefraction = fraction 
	end
		
	if o.Prefraction >= fraction + (o.totalTime) / o.MaxCount then
		o.FrameCount = o.FrameCount + 1
		if o.FrameCount >= o.MaxCount then o.FrameCount = o.MaxCount end
		local extName = "BLP"
		-- local extName = "TGA"
		
		bgFilePath = EventAlert_Image_Path.."Seed"..o.FrameCount.."."..extName		
		
		Lib_ZYF:SetBackdrop(self, {bgFile = bgFilePath })		
		iAlpha = iAlpha - (1 / o.MaxCount)		
		self:SetSize(iSize + stepSize, iSize + stepSize)
		o.Prefraction = fraction
	end
	
	if iAlpha < 0 then iAlpha = 0 end
	return iAlpha
end
function EAEXF:AnimFinished()
	local o = EAEXF	
	self:SetSize(o.maxWidth, o.maxWidth)
	self:Hide()
end
function EAEXF:AnimateOut(frame)	
	local o = EAEXF
	self.FrameAnimTable = {
				totalTime = o.totalTime,				
				updateFunc = "SetAlpha",
				getPosFunc = self.AnimAlpha,
				}	
	SetUpAnimation(frame, self.FrameAnimTable, self.AnimFinished, true)
end
-------------------------------------------
-- Package Animation Object for EASCDFrame 
-------------------------------------------
EASCDFrame = {
		FrameAnimTable = {},
}
function EASCDFrame:AnimSize(fraction)
	local iAlpha = self:GetAlpha()
	local iSize = self:GetWidth()
	self:SetSize(iSize + 1, iSize + 1)
	return iAlpha - 0.02
end
-----------------------------------------------------------------
function EASCDFrame:AnimFinished()
	self:Hide()
end
-----------------------------------------------------------------
function EASCDFrame:AnimateOut(frame)
	self.FrameAnimTable = {
				totalTime = 0.5,
				updateFunc = "SetAlpha",
				getPosFunc = self.AnimSize
				}
	SetUpAnimation(frame, self.FrameAnimTable, self.AnimFinished, true)
end