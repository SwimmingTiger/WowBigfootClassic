-- TreeView.lua
-- @Author : DengSir (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/20/2018, 4:28:53 PM

local ns = select(2, ...)
local UI = ns.UI

local setmetatable, ipairs, type, select = setmetatable, ipairs, type, select
local tinsert, tremove = table.insert, table.remove
local ceil, min, abs = math.ceil, math.min, math.abs
local coroutine = coroutine
local tIndexOf = tIndexOf

local CreateFrame, HybridScrollFrame_Update = CreateFrame, HybridScrollFrame_Update

local UIParent = UIParent

local WHERE_AFTER = 1
local WHERE_BEFORE = 2
local WHERE_IN = 3

local TreeStatus = UI:NewClass('TreeStatus')

function TreeStatus:Constructor()
    self.expend = setmetatable({}, {__mode = 'k'})
end

function TreeStatus:Iterate(start)
    local index = 0
    local function Iterate(tree, depth)
        for i, item in ipairs(tree) do
            index = index + 1
            if not start or index >= start then
                coroutine.yield(depth, item, i, tree)
            end
            if type(item) == 'table' and type(item.children) == 'table' and self.expend[item] then
                Iterate(item.children, depth + 1)
            end
        end
    end

    return coroutine.wrap(function()
        return Iterate(self.itemTree, 1)
    end)
end

function TreeStatus:GetCount()
    local function GetCount(tree, depth)
        local count = 0
        for i, item in ipairs(tree) do
            count = count + 1
            if type(item) == 'table' and type(item.children) == 'table' and self.expend[item] then
                count = count + GetCount(item.children, depth + 1)
            end
        end
        return count
    end
    return GetCount(self.itemTree, 1)
end

---@class TreeView: ScrollFrame
local TreeView = UI:NewClass('TreeView', UI.ScrollFrame)

LibStub('AceTimer-3.0'):Embed(TreeView)

function TreeView:Constructor()
    self.treeStatus = TreeStatus:New()
    self:SetCallback('OnItemCreated', self.OnItemCreated)
    self:SetCallback('OnItemDragStart', self.OnItemDragStart)
    self:SetCallback('OnItemDragStop', self.OnItemDragStop)
    self.mouseHolder = CreateFrame('Frame', nil, self)
    self.mouseHolder:SetPoint('TOPLEFT', -20, 20)
    self.mouseHolder:SetPoint('BOTTOMRIGHT', 20, -20)
end

local ITEM_SCRIPTS = setmetatable({}, {
    __index = function(t, script)
        local name = script:gsub('^On', 'OnItem')
        t[script] = function(button, ...)
            button.treeView:Fire(name, button, ...)
        end
        return t[script]
    end,
})

function TreeView:BindScript(button, ...)
    for i = 1, select('#', ...) do
        local script = select(i, ...)
        button:SetScript(script, ITEM_SCRIPTS[script])
    end
end

local function OnClick(button, click)
    if click == 'LeftButton' then
        button.treeView:Fire('OnItemClick', button)
    else
        button.treeView:Fire('OnItemRightClick', button)
    end
end

function TreeView:OnItemCreated(button)
    button.treeView = self
    button:RegisterForClicks('LeftButtonUp', 'RightButtonUp')
    button:SetScript('OnClick', OnClick)
    self:BindScript(button, 'OnDragStart', 'OnDragStop', 'OnEnter', 'OnLeave')
end

function TreeView:OnItemDragStart(button)
    local i = tIndexOf(self.buttons, button)
    if i then
        self.buttons[i] = nil
    end
    if button.index then
        tremove(button.parent, button.index)
    end
    self:Refresh()
    self:StartSorting(button)
end

function TreeView:OnItemDragStop()
    self:CommitSorting()
end

function TreeView:StartSorting(button)
    button:SetParent(UIParent)
    button:SetFrameStrata('DIALOG')
    button:StartMoving()
    button:LockHighlight()
    button:Show()
    GameTooltip:Hide()

    self.sortingButton = button
    self:ScheduleRepeatingTimer('OnTimer', 0.1)
    self:ScheduleRepeatingTimer('UpdateInsert', 0.03)
    self:UpdateInsert()
end

function TreeView:StopSorting()
    local button = self.sortingButton
    if not button then
        return
    end

    if self.inserter then
        self.inserter:Hide()
    end

    button:StopMovingOrSizing()
    button:UnlockHighlight()
    button:Hide()
    button:SetFrameStrata('MEDIUM')

    self.sortingButton = nil
    self:CancelAllTimers()
    tinsert(self.unused, button)
    self:Refresh()
end

function TreeView:CommitSorting()
    local button = self.sortingButton
    if not button then
        return
    end

    if self.putTarget then
        if self.putWhere == WHERE_BEFORE then
            tinsert(self.putTarget.parent, self.putTarget.index, button.item)
        elseif self.putWhere == WHERE_AFTER then
            tinsert(self.putTarget.parent, self.putTarget.index + 1, button.item)
        else
            local parent = self.putTarget.item
            parent.children = parent.children or {}
            tinsert(parent.children, button.item)
        end
        self.putWhere = nil
        self.putTarget = nil
    elseif button.parent and button.index then
        tinsert(button.parent, button.index, button.item)
    else
        self:StopSorting()
        return
    end
    self:StopSorting()
    self:Fire('OnListChanged')
end

function TreeView:OnTimer()
    local isOver = self.mouseHolder:IsMouseOver()
    if isOver then
        if self.sortingButton:GetTop() > self:GetTop() then
            self.scrollBar:SetValue(self.scrollBar:GetValue() - self.buttonHeight)
        elseif self.sortingButton:GetBottom() < self:GetBottom() then
            self.scrollBar:SetValue(self.scrollBar:GetValue() + self.buttonHeight)
        end
    else
        if self.sortingOver ~= isOver then
            self:Fire('OnSortingOut')
        end
    end
    self.sortingOver = isOver
end

function TreeView:UpdateInsert()
    local where, target, last
    if self.mouseHolder:IsMouseOver() then
        local top = self.sortingButton:GetTop()

        for _, button in ipairs(self.buttons) do
            if button:IsVisible() then
                local delta = button:GetTop() - top
                local canPutIn = self:Fire('OnCheckItemCanPutIn', self.sortingButton.item, button.item)
                local canPutInParent = self:Fire('OnCheckItemCanPutIn', self.sortingButton.item, button.parent)

                if abs(delta) < self.itemHeight / 5 and canPutIn then
                    target = button
                    where = WHERE_IN
                elseif delta < 0 and abs(delta) < self.itemHeight and canPutInParent then
                    target = button
                    where = WHERE_BEFORE
                elseif delta > 0 and delta < self.itemHeight * 2 / 3 and not self:IsItemExpend(button.item) and
                    canPutInParent then
                    target = button
                    where = WHERE_AFTER
                end

                if target then
                    break
                end
                last = button
            end
        end

        if not target and self.spacerButton and self.spacerButton:IsShown() then
            if abs(self.spacerButton:GetTop() - top) < self.itemHeight then
                where = WHERE_BEFORE
                target = self.spacerButton
            end
        end
    end

    if target then
        self.putTarget = target
        self.putWhere = where

        if not self.inserter then
            local inserter = CreateFrame('Frame', nil, self:GetScrollChild())
            inserter:SetSize(self:GetWidth(), 2)

            local bg = inserter:CreateTexture(nil, 'ARTWORK')
            bg:SetAllPoints(true)
            bg:SetColorTexture(0, 1, 1, 0.4)

            self.inserter = inserter
        end

        self.inserter:ClearAllPoints()
        self.inserter:SetWidth(self:GetWidth() - 5 - 16 - (target.depth - 1) * 20)
        self.inserter:Show()

        if where == WHERE_AFTER then
            self.inserter:SetPoint('TOPRIGHT', target, 'BOTTOMRIGHT', 0, 1.5)
            self.inserter:SetHeight(3)
        elseif where == WHERE_BEFORE then
            self.inserter:SetPoint('BOTTOMRIGHT', target, 'TOPRIGHT', 0, -1.5)
            self.inserter:SetHeight(3)
        else
            self.inserter:SetPoint('TOPRIGHT', target, 'TOPRIGHT')
            self.inserter:SetPoint('BOTTOMRIGHT', target, 'BOTTOMRIGHT')
        end
    else
        self.putTarget = nil
        self.putWhere = nil
        if self.inserter then
            self.inserter:Hide()
        end
    end
end

function TreeView:update()
    local offset = self:GetOffset()
    local buttons = self.buttons
    local treeStatus = self.treeStatus
    local containerHeight = self:GetHeight()
    local buttonHeight = self.buttonHeight
    local itemCount = treeStatus:GetCount()
    local maxCount = ceil(containerHeight / buttonHeight)
    local buttonCount = min(maxCount, itemCount)

    local iter = treeStatus:Iterate(offset + 1)
    local bottomButton

    for i = 1, buttonCount do
        local index = i + offset
        local button = buttons[i]
        if index > itemCount then
            button:Hide()
        else
            local depth, item, itemIndex, parent = iter()

            button.index = itemIndex
            button.parent = parent
            button.depth = depth
            button.item = item
            button.scrollFrame = self
            button:SetID(index)
            button:Show()
            self:Fire('OnItemFormatting', button, item, depth)

            if index == itemCount then
                bottomButton = button
            end
        end
    end

    if bottomButton then
        local button = self.spacerButton
        if not button then
            button = CreateFrame('Button', nil, self:GetScrollChild())
            button:SetHeight(self.itemHeight)
            button:Disable()
            self.spacerButton = button
        end

        button.depth = 1
        button.parent = self.treeStatus.itemTree
        button.index = #self.treeStatus.itemTree + 1

        button:ClearAllPoints()
        button:SetPoint('TOPLEFT', bottomButton, 'BOTTOMLEFT', 0, -3)
        button:SetPoint('TOPRIGHT', bottomButton, 'BOTTOMRIGHT', 0, -3)
        button:Show()
    elseif self.spacerButton then
        self.spacerButton:Hide()
    end

    for i = buttonCount + 1, #buttons do
        buttons[i]:Hide()
    end
    HybridScrollFrame_Update(self, itemCount * buttonHeight - self.itemSpacing + self.paddingTop + self.paddingBottom,
                             containerHeight)
end

function TreeView:SetItemTree(itemTree)
    self.treeStatus.itemTree = itemTree
    self:Refresh()
end

function TreeView:GetItemTree()
    return self.treeStatus.itemTree
end

function TreeView:ToggleItem(item)
    self.treeStatus.expend[item] = not self.treeStatus.expend[item] or nil
    self:Refresh()
end

function TreeView:IsItemExpend(item)
    return
        self.treeStatus.expend[item] and type(item) == 'table' and type(item.children) == 'table' and #item.children > 0
end
