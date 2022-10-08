if select(2,UnitClass("player")) ~= "SHAMAN" then return end

 masque = nil

-- Returns the x and y scale of a button.
local function GetScale(Button)
	local x = (Button:GetWidth() or 36) / 36
	local y = (Button:GetHeight() or 36) / 36
	return x, y
end


-- Returns a height and width.
local function GetSize(Width, Height, xScale, yScale)
	local w = (Width or 36) * xScale
	local h = (Height or 36) * yScale
	return w, h
end

-- Returns a set of texture coordinates.
local function GetTexCoords(Coords)
	if type(Coords) == "table" then
		return Coords[1] or 0, Coords[2] or 1, Coords[3] or 0, Coords[4] or 1
	else
		return 0, 1, 0, 1
	end
end

-- Apply Mask to 2nd icon
local function SkinMask(Region, Button, Skin, xScale, yScale)
	local ButtonMask = Button.__MSQ_Mask

	local SkinMask = Skin.Mask

    -- Button Mask
    if Skin.UseMask and ButtonMask and not SkinMask then
        if not Region.__MSQ_ButtonMask then
            Region:AddMaskTexture(ButtonMask)
            Region.__MSQ_ButtonMask = true
        end
    elseif Region.__MSQ_ButtonMask then
        Region:RemoveMaskTexture(ButtonMask)
        Region.__MSQ_ButtonMask = nil
    end
end

-- Function to apply Mask Skin to 2nd icon
local function SkinIcon(Region, Button, Skin, xScale, yScale)
	-- Skin
	local bType = Button.__MSQ_bType
	Skin = Skin[bType] or Skin

	--Region:SetParent(Button)
	Region:SetTexCoord(GetTexCoords(Skin.TexCoords))
	Region:SetDrawLayer(Skin.DrawLayer or "BACKGROUND", Skin.DrawLevel or 0)
	Region:SetSize(GetSize(Skin.Width, Skin.Height, xScale, yScale))

	-- Mask
	SkinMask(Region, Button, Skin, xScale, yScale)
end



function TotemTimers.SkinCallback(arg, SkinID)
    if SkinID then
        local skin = masque:GetSkin(SkinID)
        local buttons = {XiTimers.timers[8].button}
        local actionBarButtons = XiTimers.timers[8].actionBar.buttons

        for i = 1, #actionBarButtons do
            table.insert(buttons, actionBarButtons[i])
        end
        for k,button in pairs(buttons) do
            local xScale, yScale = GetScale(button)
            SkinIcon(button.icons[2], button, skin.Icon, xScale, yScale)
        end
    end
	if not SkinID or SkinID == "Default" then
		for k,v in pairs(XiTimers.timers) do
			--v.animation.button.normalTexture:Hide()
			v:HideNormalTexture()
		end
		TotemTimers.ApplySkin(false)
	else
        TotemTimers.ApplySkin(SkinID ~= nil)

		--for k,v in pairs(XiTimers.timers) do
			--v.animation.button.normalTexture:Show()
		--end
	end
end


function TotemTimers.InitMasque()
	if not LibStub then return end
	masque = LibStub("Masque", true)
	if masque then
		local group = masque:Group("TotemTimers", "Buttons")
		for k,v in pairs(XiTimers.timers) do
            group:AddButton(v.button)
            group:AddButton(v.animation.button)
        end
        for i = 1,#TTActionBars.bars do
            if TotemTimers.EarthShieldTracker
                    and TotemTimers.EarthShieldTracker.actionBar ~= TTActionBars.bars[i] then
                for j = 1,#TTActionBars.bars[i].buttons do
                    group:AddButton(TTActionBars.bars[i].buttons[j])
                end
            end
        end
        if TotemTimers_MultiSpell then group:AddButton(TotemTimers_MultiSpell) end
        group:SetCallback(TotemTimers.SkinCallback)
        --masque:Register("TotemTimers", TotemTimers.SkinCallback,nil)
        group:ReSkin()
	end
end
