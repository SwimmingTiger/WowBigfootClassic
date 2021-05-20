---@type ns
local ns = select(2, ...)
local L = ns.L

local BINDING_KEY = 'MEETINGHORN_TOGGLE'

local Options = ns.Addon:NewClass('UI.Options', 'Frame')

function Options:Constructor()
    local function createGroup(name, opt)
        local group = LibStub('AceGUI-3.0'):Create('BlizOptionsGroup')
        group.frame:ClearAllPoints()
        group.frame:SetParent(self)
        group.frame:Show()
        group:SetCallback('OnShow', function()
            LibStub('AceConfigDialog-3.0'):Open(name, group)
        end)
        group:SetCallback('OnHide', function()
            group:ReleaseChildren()
        end)

        LibStub('AceConfigRegistry-3.0'):RegisterOptionsTable(name, opt)
        return group
    end

    local order = 0
    local function orderGen()
        order = order + 1
        return order
    end

    local function toggle(name)
        return {type = 'toggle', width = 'full', name = name, order = orderGen()}
    end

    local options = {
        type = 'group',
        name = ' ',
        get = function(item)
            return self:GetOption(item[#item])
        end,
        set = function(item, value)
            return self:SetOption(item[#item], value)
        end,
        args = { --
            databroker = toggle(L['Show data broker']),
            chatfilter = toggle(L['Hide activity in chat frame']),
            activityfilter = toggle(L['启用关键字过滤']),
            key = {
                type = 'keybinding',
                name = L['Toggle MeetingHorn key binding'],
                width = 'full',
                order = orderGen(),
                get = function()
                    return GetBindingKey(BINDING_KEY)
                end,
                set = function(info, key)
                    for _, key in ipairs({GetBindingKey(BINDING_KEY)}) do
                        SetBinding(key, nil)
                    end
                    SetBinding(key, BINDING_KEY)
                    AttemptToSaveBindings(GetCurrentBindingSet())
                end,
                confirm = function(info, key)
                    local action = GetBindingAction(key)
                    if action ~= '' and action ~= BINDING_KEY then
                        return L['按键已绑定到|cffffd100%s|r，你确定要覆盖吗？']:format(
                                   _G['BINDING_NAME_' .. action] or action)
                    end
                end,
            },
        },
    }

    local optionsGroup = createGroup(L['Options'], options)
    optionsGroup.frame:SetPoint('TOPLEFT', 10, 30)
    optionsGroup.frame:SetPoint('BOTTOMRIGHT', -10, 10)
    optionsGroup.frame:SetWidth(400)

    self.Title:SetText(L['Options'])
end

function Options:GetOption(key)
    return ns.Addon.db.profile.options[key]
end

function Options:SetOption(key, value)
    ns.Addon.db.profile.options[key] = value
    self:SendMessage('MEETINGHORN_OPTION_CHANGED_' .. key:upper(), value)
end
