-- ScrollFrame.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/20/2018, 7:46:03 PM

local ns = select(2, ...)

local function OnUpdate(self)
    self:SetScript('OnUpdate', nil)
    self:update()
end

local function OnSizeChanged(self, width, height)
    self:GetScrollChild():SetSize(width, height)
    self:Refresh()
end

local function Refresh(self)
    return self:SetScript('OnUpdate', OnUpdate)
end

function ns.ScrollFrameSetup(scrollFrame, opts)
    local buttonTemplate = opts.buttonTemplate

    scrollFrame.buttons = setmetatable({}, {
        __index = function(t, i)
            if type(i) ~= 'number' then
                return
            end
            local button = CreateFrame('Button', nil, scrollFrame:GetScrollChild(), buttonTemplate)
            t[i] = button
            if i == 1 then
                button:SetPoint('TOPLEFT')
                button:SetPoint('TOPRIGHT')
            else
                button:SetPoint('TOPLEFT', t[i - 1], 'BOTTOMLEFT')
                button:SetPoint('TOPRIGHT', t[i - 1], 'BOTTOMRIGHT')
            end
            return button
        end,
    })

    scrollFrame.buttonHeight = scrollFrame.buttons[1]:GetHeight()
    scrollFrame:SetScript('OnSizeChanged', OnSizeChanged)
    scrollFrame.scrollBar.doNotHide = true

    scrollFrame.update = opts.update or scrollFrame.update
    scrollFrame.Refresh = Refresh
end
