
---@type ns
local ns = select(2, ...)

---@class ListView: ScrollFrame
---@field private scrollBar Slider
---@field private _buttons Button[]
---@field private _itemList any[]
---@field private _itemTemplate string
local ListView = ns.Addon:NewClass('UI.ListView', 'ScrollFrame')

function ListView:Constructor()
    assert(self.scrollBar)
    assert(self.scrollChild)

    self.buttonHeight = 1
    self.scrollBar.doNotHide = true
    self.scrollBar:SetMinMaxValues(0, 1)
    self.scrollBar:SetValue(0)

    self:SetScript('OnSizeChanged', self.OnSizeChanged)
    self._buttons = {}
end

function ListView:OnSizeChanged(width, height)
    self:GetScrollChild():SetSize(width, height)
    self:Refresh()
end

function ListView:update()
    local offset = HybridScrollFrame_GetOffset(self)
    local itemList = self._itemList or {}
    local containerHeight = self:GetHeight()
    local buttonHeight = self.buttonHeight or self:GetButton(1):GetHeight() + 2
    local itemCount = itemList.count or #itemList
    local maxCount = ceil(containerHeight / buttonHeight)
    local buttonCount = min(maxCount, itemCount)

    for i = 1, buttonCount do
        local index = i + offset
        local button = self:GetButton(i)
        if index > itemCount then
            button:Hide()
        else
            local item = itemList[index]
            button.item = item
            button:SetID(index)
            button:Show()
            self:Fire('OnItemFormatting', button, item)
        end
    end

    for i = buttonCount + 1, #self._buttons do
        self._buttons[i]:Hide()
    end
    HybridScrollFrame_Update(self, itemCount * buttonHeight, containerHeight)
end

function ListView:SetItemList(itemList)
    self._itemList = itemList
    self:Refresh()
end

function ListView:GetItemList()
    return self._itemList
end

function ListView:SetItemTemplate(itemTemplate)
    self._itemTemplate = itemTemplate
    self.buttonHeight = self:GetButton(1):GetHeight() + 2
end

function ListView:GetItemTemplate()
    return self._itemTemplate
end

function ListView:Refresh()
    self:SetScript('OnUpdate', self.OnUpdate)
end

function ListView:OnUpdate()
    self:SetScript('OnUpdate', nil)
    self:update()
end

local function ButtonOnEnter(button)
    button.scrollFrame:Fire('OnItemEnter', button, button.item)
end

local function ButtonOnLeave(button)
    button.scrollFrame:Fire('OnItemLeave', button, button.item)
end

local function ButtonOnDoubleClick(button)
    button.scrollFrame:Fire('OnItemDoubleClick', button, button.item)
end

local function ButtonOnClick(button, clicked)
    if clicked == 'LeftButton' then
    else
        button.scrollFrame:Fire('OnItemRightClick', button, button.item)
    end
end

function ListView:GetButton(index)
    if not self._buttons[index] then
        local button = CreateFrame('Button', nil, self:GetScrollChild(), self._itemTemplate)
        if index == 1 then
            button:SetPoint('TOPLEFT')
            button:SetPoint('TOPRIGHT')
        else
            button:SetPoint('TOPLEFT', self._buttons[index - 1], 'BOTTOMLEFT', 0, -2)
            button:SetPoint('TOPRIGHT', self._buttons[index - 1], 'BOTTOMRIGHT', 0, -2)
        end
        button.scrollFrame = self
        button:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
        button:SetScript('OnEnter', ButtonOnEnter)
        button:SetScript('OnLeave', ButtonOnLeave)
        button:SetScript('OnClick', ButtonOnClick)
        button:SetScript('OnDoubleClick', ButtonOnDoubleClick)
        self:Fire('OnItemCreated', button)
        self._buttons[index] = button
    end
    return self._buttons[index]
end

-- local function JumpToItem(self, item)
--     local index = tIndexOf(self._itemList, item)
--     if index then
--         local buttonHeight = self.buttonHeight or self.buttons[1]:GetHeight()
--         local maxCount = ceil(self:GetHeight() / buttonHeight)
--         local height = math.max(0, math.floor(buttonHeight * (index - maxCount / 2)))
--         HybridScrollFrame_SetOffset(self, height)
--         self.scrollBar:SetValue(height)
--     end
-- end
