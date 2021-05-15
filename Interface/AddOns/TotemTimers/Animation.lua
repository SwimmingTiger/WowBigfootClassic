if select(2,UnitClass("player")) ~= "SHAMAN" then return end


XiTimersAnimations = {}
XiTimersAnimations.animations = {}
XiTimersAnimations.__index = XiTimersAnimations

local NumAnimations = 0

function XiTimersAnimations:new(AnchoredButton)
	local self = {}
	setmetatable(self, XiTimersAnimations)
    NumAnimations = NumAnimations + 1
    self.button =  CreateFrame("CheckButton", "XiTimers_Animation"..NumAnimations, UIParent, "ActionButtonTemplate")
    self.icon = _G["XiTimers_Animation"..NumAnimations.."Icon"]
	self.button.normalTexture = _G["XiTimers_Animation"..NumAnimations.."NormalTexture"]
    self.button.normalTexture:Hide()
    self.icon:SetTexCoord(0.07,0.93,0.07,0.93)
    self.AnimGroup = self.button:CreateAnimationGroup()
    self.AnimGroup.button = self.button
    self.AnimGroup:SetLooping("NONE")
    self.AnimGroup:SetScript("OnFinished", function(self) self.button:Hide() end)
    self.AnimGroup:SetScript("OnPlay", function(self)
        self.button:Show()
    end)
    self.Translation = self.AnimGroup:CreateAnimation("Translation")
    self.Translation:SetDuration(0.7)
    self.Translation:SetOffset(200,200)
    self.Alpha = self.AnimGroup:CreateAnimation("Alpha")
    self.Alpha:SetDuration(0.7)
    --self.Alpha:SetChange(-1)
    self.Scale = self.AnimGroup:CreateAnimation("Scale")
    self.Scale:SetDuration(0.7)
    self.Scale:SetScale(10,10)
    self.AnchoredButton = AnchoredButton
    self.button:Hide()
	return self
end

function XiTimersAnimations:Play()
    self.button:ClearAllPoints()
    if self.AnchoredButton:IsVisible() then
        self.button:SetPoint("CENTER", self.AnchoredButton)
    else
        self.button:SetPoint("CENTER", UIParent)
    end
    local x,y = self.button:GetCenter()
    local uicx, uicy = UIParent:GetCenter()
    self.Translation:SetOffset(uicx-x, uicy+50-y)
    self.AnimGroup:Play()
end

function XiTimersAnimations:SetTexture(texture)
    self.icon:SetTexture(texture)
end

