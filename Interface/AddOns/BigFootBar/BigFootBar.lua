MOVING_BIGFOOTBAR = nil
if (GetLocale() == "zhCN") then
    BIGFOOTBAR_WINDOWS = "窗口操作"
    BIGFOOTBAR_UNLOCK_BAR = "解锁动作条"
    BIGFOOTBAR_LOCK_BAR = "锁定动作条"
    BIGFOOTBAR_MINIMIZE_BAR = "最小化动作条"
    BIGFOOTBAR_RESTORE_BAR = "恢复动作条"
    BIGFOOTBAR_RESIZE = "缩放动作条"
    BIGFOOTBAR_CLOSE_BAR = "关闭动作条"
    BIGFOOTBAR_ARRANGEMENT = "排列方式"
    BIGFOOTBAR_ARRANGEMENT_HORIZONTAL = "横向排列"
    BIGFOOTBAR_ARRANGEMENT_VERTICAL = "纵向排列"
    BIGFOOTBAR_ARRANGEMENT_FUNNY = "趣味排列"
    BIGFOOTBAR_BUTTONS = "按钮操作"
    BIGFOOTBAR_INCREASE_BUTTON = "增加按钮"
    BIGFOOTBAR_DECREASE_BUTTON = "减少按钮"
    BIGFOOTBAR_MESSAGE_ERROR_NO_ENOUGH_ID = "没有可分配的动作按钮ID。"
    BIGFOOTBAR_CLOSE_BAR_INFO = "关闭动作条将使你所有的动作按钮信息失去，你真的想关闭动作按钮吗？"
    BIGFOOTBAR_ENABLE = "开启大脚动作条"
    BIGFOOTBAR_RESET = "按鍵綁定"
    BIGFOOTBAR_HIDE_TAB = "隐藏动作条标题头"
    BIGFOOTBAR_HIDE_GRID = "隐藏未用的动作按钮"
    BIGFOOTBAR_OTHERS = "其它操作"
    BIGFOOTBAR_CREATE_NEW_BAR = "创建新的动作条"
    BIGFOOTBAR_TAB_HELP_TEXT = "按住鼠标左键可对动作条进行拖动,\n单击鼠标右键弹出操作菜单。"
elseif (GetLocale() == "zhTW") then
    BIGFOOTBAR_WINDOWS = "視窗"
    BIGFOOTBAR_UNLOCK_BAR = "解鎖快捷列"
    BIGFOOTBAR_LOCK_BAR = "鎖定快捷列"
    BIGFOOTBAR_MINIMIZE_BAR = "最小化快捷列"
    BIGFOOTBAR_RESTORE_BAR = "恢復快捷列"
    BIGFOOTBAR_RESIZE = "縮放動作條"
    BIGFOOTBAR_CLOSE_BAR = "關閉快捷列"
    BIGFOOTBAR_ARRANGEMENT = "排列方式"
    BIGFOOTBAR_ARRANGEMENT_HORIZONTAL = "橫向排列"
    BIGFOOTBAR_ARRANGEMENT_VERTICAL = "縱向排列"
    BIGFOOTBAR_ARRANGEMENT_FUNNY = "趣味排列"
    BIGFOOTBAR_BUTTONS = "按鈕"
    BIGFOOTBAR_INCREASE_BUTTON = "增加按鈕"
    BIGFOOTBAR_DECREASE_BUTTON = "減少按鈕"
    BIGFOOTBAR_OTHERS = "其它操作"
    BIGFOOTBAR_CREATE_NEW_BAR = "创建新的动作条"
    BIGFOOTBAR_MESSAGE_ERROR_NO_ENOUGH_ID = "沒有可分配的動作按鈕ID。"
    BIGFOOTBAR_CLOSE_BAR_INFO = "關閉快捷列將失去你所有的動作按鈕訊息，你確定要關閉動作按鈕嗎？"
    BIGFOOTBAR_ENABLE = "開啟大腳快捷列"
    BIGFOOTBAR_RESET = "按鍵綁定"
    BIGFOOTBAR_HIDE_TAB = "隱藏快捷列標題"
    BIGFOOTBAR_HIDE_GRID = "隱藏未用的動作按鈕"
    BIGFOOTBAR_TAB_HELP_TEXT = "按住滑鼠左鍵可對快捷列進行拖曳,\n點選滑鼠右鍵彈出操作選單。"
else
    BIGFOOTBAR_WINDOWS = "Window"
    BIGFOOTBAR_UNLOCK_BAR = "Unlock"
    BIGFOOTBAR_LOCK_BAR = "Lock"
    BIGFOOTBAR_MINIMIZE_BAR = "Minimize"
    BIGFOOTBAR_RESTORE_BAR = "Restore"
    BIGFOOTBAR_RESIZE = "Resize Bar"
    BIGFOOTBAR_CLOSE_BAR = "Close"
    BIGFOOTBAR_ARRANGEMENT = "Arrangement"
    BIGFOOTBAR_ARRANGEMENT_HORIZONTAL = "Horizontal arrangement"
    BIGFOOTBAR_ARRANGEMENT_VERTICAL = "Vertical arragnement"
    BIGFOOTBAR_ARRANGEMENT_FUNNY = "Funny arrangement"
    BIGFOOTBAR_BUTTONS = "Button"
    BIGFOOTBAR_INCREASE_BUTTON = "Increase button"
    BIGFOOTBAR_DECREASE_BUTTON = "Decrease button"
    BIGFOOTBAR_OTHERS = "Other"
    BIGFOOTBAR_CREATE_NEW_BAR = "Create new bar"
    BIGFOOTBAR_MESSAGE_ERROR_NO_ENOUGH_ID = "No more button could be arragned."
    BIGFOOTBAR_CLOSE_BAR_INFO = "All button information you want to close will be lost, do you really want to do?"
    BIGFOOTBAR_ENABLE = "Enable BigFoot Bar"
    BIGFOOTBAR_RESET = "Key Binding"
    BIGFOOTBAR_HIDE_TAB = "Hide action bar headers"
    BIGFOOTBAR_HIDE_GRID = "Hide unused action buttons"
    BIGFOOTBAR_TAB_HELP_TEXT = "Hold mouse left button to move bar,\nRight click to popup menu."
end
BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c = 12
BigFootBar_13a3c67ee59d2b4a6a40c57847c95a42 = 1
BigFootBar_e2d5f352154387b81189558196c18e82 = 10
BigFootBar_72be2d2fba590211fe0f29e1a9832788 = 124
MAX_ACTIVE_BAR_COUNT = 10
BigFootBar_Info = {}
BigFootBar_3062be796f02383eadecd6c8e48ebc4b = nil
BigFootBar_f97a2a7812f94d4bb34fcf1f04f5711e = nil
StaticPopupDialogs["CLOSE_BAR"] = {
    text = BIGFOOTBAR_CLOSE_BAR_INFO,
    button1 = YES,
    button2 = NO,
    OnAccept = function(self, data)
        BigFootBar_503ed091c79944be5b7079c0602f8146(data, nil, true)
    end,
    OnCancel = function(self, BigFootBar_3a41fa2f33897b6c190993d845e6b222)
    end,
    showAlert = 1,
    timeout = 0,
    preferredIndex = STATICPOPUP_NUMDIALOGS,
}
function BigFootBarButton_OnLoad(self)
    self.buttonType = "BigFootBarFrame1ActionButton1"
    self.flashing = 0
    self.flashtime = 0
    self:SetAttribute("showgrid", 0)
    self:SetAttribute("type", "action")
    self:SetAttribute("checkselfcast", true)
    self:SetAttribute("checkfocuscast", true)
    self:SetAttribute("useparent-unit", true)
    self:SetAttribute("useparent-actionpage", true)
    self:RegisterForDrag("LeftButton", "RightButton")
    self:RegisterForClicks("AnyUp")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("ACTIONBAR_SHOWGRID")
    self:RegisterEvent("ACTIONBAR_HIDEGRID")
    self:RegisterEvent("ACTIONBAR_PAGE_CHANGED")
    self:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
    self:RegisterEvent("UPDATE_BINDINGS")
    self:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
    self:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
    ActionButton_UpdateAction(self)
    ActionButton_UpdateHotkeys(self, self.buttonType)
end
local BigFootBar_f40fe078ddd73cb3e7cc2600b489b79e = BLibrary("BScale")
local BigFootBar_Eventer = BLibrary("BEvent")
BigFootBar_Eventer:Init {name = "BigFootBar", func = function()
        BigFootBar_OnLoad()
    end}
function BigFootBar_OnLoad()
    ModManagement_RegisterCheckBox(
        "ActionBar",
        BIGFOOTBAR_ENABLE,
        nil,
        "Enable_BigFootBar",
        0,
        function(BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae)
            BigFootBar_Toggle(BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae)
        end
    )
    ModManagement_RegisterCheckBox(
        "ActionBar",
        BIGFOOTBAR_HIDE_TAB,
        nil,
        "HideTab",
        0,
        function(BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae)
            if (BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
                local __index
                for __index = 1, MAX_ACTIVE_BAR_COUNT, 1 do
                    local BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a = _G["BigFootBarFrame" .. __index .. "Tab"]
                    if (BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a) then
                        BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a:Hide()
                    end
                end
            else
                for __index = 1, MAX_ACTIVE_BAR_COUNT, 1 do
                    local BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a = _G["BigFootBarFrame" .. __index .. "Tab"]
                    if (BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a) then
                        BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a:Show()
                    end
                end
            end
        end,
        1
    )
    ModManagement_RegisterCheckBox(
        "ActionBar",
        BIGFOOTBAR_HIDE_GRID,
        nil,
        "HideGrid",
        0,
        function(BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae)
            if (BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
                BigFootBar_ToggleShowGrid(false)
            else
                BigFootBar_ToggleShowGrid(true)
            end
        end,
        1
    )
    ModManagement_RegisterButton(
        "ActionBar",
        BIGFOOTBAR_RESET,
        function()
            BigFoot_ShowKeyBindingFrame("HEADER_BIGFOOTBAR1")
        end,
        nil,
        1
    )
end
function BigFootBar_bceab2d4ca6bac097d8aac711b117e68()
    ActionBar_PageUp()
    ActionBar_PageDown()
end
function BigFootBar_Toggle(BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
        if (not BigFootBar_3062be796f02383eadecd6c8e48ebc4b) then
            BigFootBar_25b1d2fe6e14021d74f8def30b5d48bc()
            local page = GetActionBarPage()
            local new_page_offset
            if (page == 1) then
                new_page_offset = 1
            else
                new_page_offset = -1
            end
            ChangeActionBarPage(page + new_page_offset)
            ChangeActionBarPage(page)
            BigFootBar_3062be796f02383eadecd6c8e48ebc4b = 1
        end
    else
        if (BigFootBar_3062be796f02383eadecd6c8e48ebc4b) then
            local barsDB = BigFootBar_45eed77ae29ae5fa45c281c9f2e34a2b()
            for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, MAX_ACTIVE_BAR_COUNT, 1 do
                local BigFootBar_69072c73fde2ed407f863929fd1e7483 =
                    getglobal("BigFootBarFrame" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f)
                if
                    (BigFootBar_69072c73fde2ed407f863929fd1e7483 and
                        barsDB[BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName()])
                 then
                    BigFootBar_503ed091c79944be5b7079c0602f8146(nil, BigFootBar_69072c73fde2ed407f863929fd1e7483)
                end
                BigFootBar_ToggleDurabilityFrame()
            end
            BigFootBar_3062be796f02383eadecd6c8e48ebc4b = nil
        end
    end
end
function BigFootBar_ToggleShowGrid(switch)
    local BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f, BigFootBar_5e57ab95c762a48d9a126b104db1056f
    if (switch) then
        BigFootBar_f97a2a7812f94d4bb34fcf1f04f5711e = true
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, MAX_ACTIVE_BAR_COUNT, 1 do
            local BigFootBar_69072c73fde2ed407f863929fd1e7483 =
                getglobal("BigFootBarFrame" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f)
            if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_69072c73fde2ed407f863929fd1e7483:IsVisible()) then
                for BigFootBar_5e57ab95c762a48d9a126b104db1056f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
                    local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                        getglobal(
                        BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                            "ActionButton" .. BigFootBar_5e57ab95c762a48d9a126b104db1056f
                    )
                    BigFootActionButton_ShowGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
                    ActionButton_Update(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
                end
            end
        end
    else
        BigFootBar_f97a2a7812f94d4bb34fcf1f04f5711e = false
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, MAX_ACTIVE_BAR_COUNT, 1 do
            local BigFootBar_69072c73fde2ed407f863929fd1e7483 =
                getglobal("BigFootBarFrame" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f)
            if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_69072c73fde2ed407f863929fd1e7483:IsVisible()) then
                for BigFootBar_5e57ab95c762a48d9a126b104db1056f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
                    local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                        getglobal(
                        BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                            "ActionButton" .. BigFootBar_5e57ab95c762a48d9a126b104db1056f
                    )
                    BigFootActionButton_HideGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
                    ActionButton_Update(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
                end
            end
        end
    end
end
function BigFootBarFrame_OnLoad(self)
    self:SetClampedToScreen(true)
end
function BigFootBar_1ae1e0340b5317470a2ba1c35f0b58ef(
    BigFootBar_e336dc28c4d38435742089635936c144,
    BigFootBar_0db5ab7591386d733b59a51d951e85d0)
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_WINDOWS
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.isTitle = 1
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.notCheckable = 1
    BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
    local BigFootBar_69072c73fde2ed407f863929fd1e7483 =
        BigFootBar_e336dc28c4d38435742089635936c144:GetParent():GetParent()
    if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_69072c73fde2ed407f863929fd1e7483.isLocked) then
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_UNLOCK_BAR
    else
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_LOCK_BAR
    end
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_ToggleLock
    BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
    if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_69072c73fde2ed407f863929fd1e7483.minimized) then
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_RESTORE_BAR
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_f7b216cf55af9a4d5e1d6041d1932933
        BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
    else
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_MINIMIZE_BAR
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_4a8bce8af3e339e7256a76e8fd38aa73
        BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
    end
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_RESIZE
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_519dd29c57db397976fd839a096551aa
    BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
    if (BigFootBar_1db89d9f19df64198d6ec146695e73df() > 1) then
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_CLOSE_BAR
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = function()
            StaticPopup_Show("CLOSE_BAR", nil, nil, BigFootBar_69072c73fde2ed407f863929fd1e7483)
        end
        BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
    end
    if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and not BigFootBar_69072c73fde2ed407f863929fd1e7483.minimized) then
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_ARRANGEMENT
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.isTitle = 1
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.notCheckable = 1
        BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
        if (BigFootBar_69072c73fde2ed407f863929fd1e7483.arrangement ~= "horizontal") then
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_ARRANGEMENT_HORIZONTAL
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_53a0a7c289244b633760f09361be7083
            BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
        end
        if (BigFootBar_69072c73fde2ed407f863929fd1e7483.arrangement ~= "vertical") then
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_ARRANGEMENT_VERTICAL
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_c1a00077417bf72984105bce5124b1e3
            BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
        end
        if (BigFootBar_69072c73fde2ed407f863929fd1e7483.arrangement ~= "funny") then
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_ARRANGEMENT_FUNNY
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_b6dde4aa477f5f69115fd309799fe42a
            BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
        end
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_BUTTONS
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.isTitle = 1
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.notCheckable = 1
        BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_INCREASE_BUTTON
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_adc837400907e6939c88756a06372e72
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.disabled = 1
        if
            (BigFootBar_b740f76b158bf0246affe3865ebde2cf(BigFootBar_69072c73fde2ed407f863929fd1e7483) <
                BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c)
         then
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.disabled = nil
        end
        BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_DECREASE_BUTTON
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_127a3959268c57c6bc46738570b6fc07
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.disabled = 1
        if
            (BigFootBar_b740f76b158bf0246affe3865ebde2cf(BigFootBar_69072c73fde2ed407f863929fd1e7483) >
                BigFootBar_13a3c67ee59d2b4a6a40c57847c95a42)
         then
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.disabled = nil
        end
        BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
    end
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_OTHERS
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.isTitle = 1
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.notCheckable = 1
    BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.text = BIGFOOTBAR_CREATE_NEW_BAR
    BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFootBar_5d071f6d0710f0143d9058bcda4608e1
    if (BigFootBar_1db89d9f19df64198d6ec146695e73df() >= MAX_ACTIVE_BAR_COUNT) then
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.disabled = 1
    end
    BDropDownMenu_AddButton(BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa)
end
function BigFootBar_ToggleLock()
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac()
    if (BigFootBar_3e285ebeedd19f2a00429a2614a093d7) then
        if (BigFootBar_3e285ebeedd19f2a00429a2614a093d7.isLocked) then
            BigFootBar_3e285ebeedd19f2a00429a2614a093d7.isLocked = nil
        else
            BigFootBar_3e285ebeedd19f2a00429a2614a093d7.isLocked = 1
        end
        BigFootBar_9bf8053183f37cc485e2dcebb062ab02(BigFootBar_3e285ebeedd19f2a00429a2614a093d7)
    end
end
function BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 =
        getglobal("BigFootBarFrame" .. BDropDownMenu_GetCurrentDropDown():GetParent():GetParent():GetID())
    if (not BigFootBar_3e285ebeedd19f2a00429a2614a093d7) then
        BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = getglobal("BigFootBarFrame" .. self:GetParent():GetID())
    end
    return BigFootBar_3e285ebeedd19f2a00429a2614a093d7
end
function BigFootBarTab_OnClick(self, BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 == "RightButton" and not InCombatLockdown()) then
        if (GetScreenWidth() - self:GetRight() < BigFootBar_72be2d2fba590211fe0f29e1a9832788 - 40) then
            BToggleDropDownMenu(
                1,
                nil,
                getglobal(self:GetName() .. "DropDown"),
                self:GetName(),
                10 - BigFootBar_72be2d2fba590211fe0f29e1a9832788,
                3
            )
        else
            BToggleDropDownMenu(1, nil, getglobal(self:GetName() .. "DropDown"), self:GetName(), 10, 3)
        end
        PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON)
        return
    end
    CloseDropDownMenus()
end
function BigFootBarDropDown_OnLoad(self)
    BDropDownMenu_Initialize(self, BigFootBar_1ae1e0340b5317470a2ba1c35f0b58ef, "MENU")
    BDropDownMenu_SetButtonWidth(self, 50)
    BDropDownMenu_SetWidth(self, 50)
end
function BigFootBar_adc837400907e6939c88756a06372e72(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    if (BigFootBar_3e285ebeedd19f2a00429a2614a093d7) then
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
            local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                getglobal(
                BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName() ..
                    "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
            )
            if
                (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 and
                    not BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.forceShow)
             then
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.forceShow = true
                BigFootActionButton_ShowGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            end
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.grid_timestamp = 0
            if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 and BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.hide) then
                BigFootBar_11e76fe10cb05184719f745e4db8a533(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
                local BigFootBar_bba564c01b4659989f8d87879ec9fe5e = BigFootBar_45eed77ae29ae5fa45c281c9f2e34a2b()
                if (BigFootBar_bba564c01b4659989f8d87879ec9fe5e[BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName()]) then
                    BigFootBar_bba564c01b4659989f8d87879ec9fe5e[BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName()].buttonCount =
                        BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
                end
                BigFootBar_bceab2d4ca6bac097d8aac711b117e68()
                break
            end
        end
        if (BigFootBar_3e285ebeedd19f2a00429a2614a093d7.arrangement == "funny") then
            BigFootBar_7817d76887ec66e3d20a7585faecddf9(BigFootBar_3e285ebeedd19f2a00429a2614a093d7, "funny")
        end
    end
end
function BigFootBar_127a3959268c57c6bc46738570b6fc07(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    if (BigFootBar_3e285ebeedd19f2a00429a2614a093d7) then
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
            local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                getglobal(
                BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName() ..
                    "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
            )
            if
                (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 and
                    not BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.forceShow)
             then
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.forceShow = true
                BigFootActionButton_ShowGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            end
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.grid_timestamp = 0
        end
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 2, -1 do
            local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                getglobal(
                BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName() ..
                    "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
            )
            if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 and not BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.hide) then
                BigFootBar_572bc203d168039d0b16ee8ebdfc9d3a(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
                local BigFootBar_bba564c01b4659989f8d87879ec9fe5e = BigFootBar_45eed77ae29ae5fa45c281c9f2e34a2b()
                if (BigFootBar_bba564c01b4659989f8d87879ec9fe5e[BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName()]) then
                    BigFootBar_bba564c01b4659989f8d87879ec9fe5e[BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName()].buttonCount =
                        BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f - 1
                end
                break
            end
        end
        if (BigFootBar_3e285ebeedd19f2a00429a2614a093d7.arrangement == "funny") then
            BigFootBar_7817d76887ec66e3d20a7585faecddf9(BigFootBar_3e285ebeedd19f2a00429a2614a093d7, "funny")
        end
    end
end
function BigFootBar_7817d76887ec66e3d20a7585faecddf9(
    BigFootBar_69072c73fde2ed407f863929fd1e7483,
    BigFootBar_0addda812f85f956e81ce69f2325e162)
    if (BigFootBar_0addda812f85f956e81ce69f2325e162 == "horizontal") then
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 2, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
            local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                getglobal(
                BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                    "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
            )
            local BigFootBar_9f4f14a4b6bb211896381263b4932758 =
                BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                "ActionButton" .. (BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f - 1)
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:ClearAllPoints()
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetPoint(
                "LEFT",
                BigFootBar_9f4f14a4b6bb211896381263b4932758,
                "RIGHT",
                6,
                0
            )
        end
        BigFootBar_69072c73fde2ed407f863929fd1e7483.arrangement = "horizontal"
    elseif (BigFootBar_0addda812f85f956e81ce69f2325e162 == "vertical") then
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 2, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
            local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                getglobal(
                BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                    "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
            )
            local BigFootBar_9f4f14a4b6bb211896381263b4932758 =
                BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                "ActionButton" .. (BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f - 1)
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:ClearAllPoints()
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetPoint(
                "TOP",
                BigFootBar_9f4f14a4b6bb211896381263b4932758,
                "BOTTOM",
                0,
                -6
            )
        end
        BigFootBar_69072c73fde2ed407f863929fd1e7483.arrangement = "vertical"
    elseif (BigFootBar_0addda812f85f956e81ce69f2325e162 == "funny") then
        local BigFootBar_d5559836e6861c025e096cb9c41eda8c =
            BigFootBar_b740f76b158bf0246affe3865ebde2cf(BigFootBar_69072c73fde2ed407f863929fd1e7483)
        BigFootBar_415fabcdc81ddd99a13581c4551bbcb5(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            BigFootBar_d5559836e6861c025e096cb9c41eda8c
        )
        BigFootBar_69072c73fde2ed407f863929fd1e7483.arrangement = "funny"
    end
    BigFootBar_9bf8053183f37cc485e2dcebb062ab02(BigFootBar_69072c73fde2ed407f863929fd1e7483)
end
function BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
    BigFootBar_69072c73fde2ed407f863929fd1e7483,
    __index,
    BigFootBar_0e2babf2e3097eec96cf9280d1412ab5,
    BigFootBar_00ae4bc475ffbcf97f789256a2e707de,
    BigFootBar_6599f8c6a1b53d0212dfbab04e14e329,
    BigFootBar_18bd17b74c56bfd23801044c9c9e8d4e,
    BigFootBar_a29776f66159eb25625ce8ff4969048f)
    local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
        getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. __index)
    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:ClearAllPoints()
    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetPoint(
        BigFootBar_0e2babf2e3097eec96cf9280d1412ab5,
        BigFootBar_00ae4bc475ffbcf97f789256a2e707de,
        BigFootBar_6599f8c6a1b53d0212dfbab04e14e329,
        BigFootBar_18bd17b74c56bfd23801044c9c9e8d4e,
        BigFootBar_a29776f66159eb25625ce8ff4969048f
    )
    return BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5
end
function BigFootBar_415fabcdc81ddd99a13581c4551bbcb5(
    BigFootBar_69072c73fde2ed407f863929fd1e7483,
    BigFootBar_3f50417fb16be9b1078eb68d24fa9c26)
    if (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 1) then
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 2) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "TOP",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            0,
            -6
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 3) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "TOPRIGHT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            -3,
            -6
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "TOPLEFT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            3,
            -6
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 4) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "TOPRIGHT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            -3,
            -6
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "TOPLEFT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            3,
            -6
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "TOP",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "BOTTOMRIGHT",
            3,
            -6
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 5) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "TOPRIGHT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOMLEFT",
            -3,
            -6
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "TOP",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "TOPLEFT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOMRIGHT",
            3,
            -6
        )
        local BigFootBar_47888b79d2e19ed3954133aecd2d3d13 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            5,
            "TOP",
            BigFootBar_a7af04fce99bafe185c44fd8033aac34:GetName(),
            "BOTTOM",
            0,
            -6
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 6) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "TOPRIGHT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            -3,
            -6
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "LEFT",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "TOPRIGHT",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "BOTTOM",
            -3,
            -6
        )
        local BigFootBar_47888b79d2e19ed3954133aecd2d3d13 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            5,
            "LEFT",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_6730b8c921a5f792f77bc21fef04de6b =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            6,
            "LEFT",
            BigFootBar_47888b79d2e19ed3954133aecd2d3d13:GetName(),
            "RIGHT",
            6,
            0
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 7) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "LEFT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "TOPRIGHT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            -3,
            -6
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "LEFT",
            BigFootBar_a7af04fce99bafe185c44fd8033aac34:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_47888b79d2e19ed3954133aecd2d3d13 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            5,
            "LEFT",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_6730b8c921a5f792f77bc21fef04de6b =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            6,
            "TOPLEFT",
            BigFootBar_a7af04fce99bafe185c44fd8033aac34:GetName(),
            "BOTTOM",
            3,
            -6
        )
        local BigFootBar_922b9b070b7dcf3e915e5ee7063da024 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            7,
            "LEFT",
            BigFootBar_6730b8c921a5f792f77bc21fef04de6b:GetName(),
            "RIGHT",
            6,
            0
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 8) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "TOPRIGHT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            -3,
            -6
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "LEFT",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "TOPRIGHT",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "BOTTOM",
            -3,
            -6
        )
        local BigFootBar_47888b79d2e19ed3954133aecd2d3d13 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            5,
            "LEFT",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_6730b8c921a5f792f77bc21fef04de6b =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            6,
            "LEFT",
            BigFootBar_47888b79d2e19ed3954133aecd2d3d13:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_922b9b070b7dcf3e915e5ee7063da024 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            7,
            "TOPLEFT",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "BOTTOM",
            3,
            -6
        )
        local BigFootBar_c09bcf10f0448d5c105fa0ef31956117 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            8,
            "LEFT",
            BigFootBar_922b9b070b7dcf3e915e5ee7063da024:GetName(),
            "RIGHT",
            6,
            0
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 9) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "LEFT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "LEFT",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "TOP",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_47888b79d2e19ed3954133aecd2d3d13 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            5,
            "LEFT",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_6730b8c921a5f792f77bc21fef04de6b =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            6,
            "LEFT",
            BigFootBar_47888b79d2e19ed3954133aecd2d3d13:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_922b9b070b7dcf3e915e5ee7063da024 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            7,
            "TOP",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_c09bcf10f0448d5c105fa0ef31956117 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            8,
            "LEFT",
            BigFootBar_922b9b070b7dcf3e915e5ee7063da024:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_dec7cba1852c1c686ea8ed81075ef1d5 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            9,
            "LEFT",
            BigFootBar_c09bcf10f0448d5c105fa0ef31956117:GetName(),
            "RIGHT",
            6,
            0
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 10) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "LEFT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "LEFT",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "TOPRIGHT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            -3,
            -6
        )
        local BigFootBar_47888b79d2e19ed3954133aecd2d3d13 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            5,
            "LEFT",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_6730b8c921a5f792f77bc21fef04de6b =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            6,
            "LEFT",
            BigFootBar_47888b79d2e19ed3954133aecd2d3d13:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_922b9b070b7dcf3e915e5ee7063da024 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            7,
            "LEFT",
            BigFootBar_6730b8c921a5f792f77bc21fef04de6b:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_c09bcf10f0448d5c105fa0ef31956117 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            8,
            "TOPLEFT",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "BOTTOM",
            3,
            -6
        )
        local BigFootBar_dec7cba1852c1c686ea8ed81075ef1d5 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            9,
            "LEFT",
            BigFootBar_c09bcf10f0448d5c105fa0ef31956117:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_df64fc302f6e608c524ab1613c38f587 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            10,
            "LEFT",
            BigFootBar_dec7cba1852c1c686ea8ed81075ef1d5:GetName(),
            "RIGHT",
            6,
            0
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 11) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "LEFT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "LEFT",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "TOP",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_6730b8c921a5f792f77bc21fef04de6b =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            6,
            "TOP",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_47888b79d2e19ed3954133aecd2d3d13 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            5,
            "RIGHT",
            BigFootBar_6730b8c921a5f792f77bc21fef04de6b:GetName(),
            "LEFT",
            -6,
            0
        )
        local BigFootBar_922b9b070b7dcf3e915e5ee7063da024 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            7,
            "LEFT",
            BigFootBar_6730b8c921a5f792f77bc21fef04de6b:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_c09bcf10f0448d5c105fa0ef31956117 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            8,
            "TOP",
            BigFootBar_6730b8c921a5f792f77bc21fef04de6b:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_df64fc302f6e608c524ab1613c38f587 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            10,
            "TOP",
            BigFootBar_c09bcf10f0448d5c105fa0ef31956117:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_dec7cba1852c1c686ea8ed81075ef1d5 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            9,
            "RIGHT",
            BigFootBar_df64fc302f6e608c524ab1613c38f587:GetName(),
            "LEFT",
            -6,
            0
        )
        local BigFootBar_527e9de525b5c4635499afc0f0f44840 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            11,
            "LEFT",
            BigFootBar_df64fc302f6e608c524ab1613c38f587:GetName(),
            "RIGHT",
            6,
            0
        )
    elseif (BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 == 12) then
        local BigFootBar_ad8436a5e203286daabf6371f7d4bbf5 =
            getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "ActionButton" .. 1)
        local BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            2,
            "LEFT",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_a7af04fce99bafe185c44fd8033aac34 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            3,
            "LEFT",
            BigFootBar_b3abf60b2e789016349d8a0c9ae9d78e:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_9dbccb7afb70e52ecdb47dd475db3042 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            4,
            "TOP",
            BigFootBar_ad8436a5e203286daabf6371f7d4bbf5:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_47888b79d2e19ed3954133aecd2d3d13 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            5,
            "LEFT",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_6730b8c921a5f792f77bc21fef04de6b =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            6,
            "LEFT",
            BigFootBar_47888b79d2e19ed3954133aecd2d3d13:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_922b9b070b7dcf3e915e5ee7063da024 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            7,
            "TOP",
            BigFootBar_9dbccb7afb70e52ecdb47dd475db3042:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_c09bcf10f0448d5c105fa0ef31956117 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            8,
            "LEFT",
            BigFootBar_922b9b070b7dcf3e915e5ee7063da024:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_dec7cba1852c1c686ea8ed81075ef1d5 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            9,
            "LEFT",
            BigFootBar_c09bcf10f0448d5c105fa0ef31956117:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_df64fc302f6e608c524ab1613c38f587 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            10,
            "TOP",
            BigFootBar_922b9b070b7dcf3e915e5ee7063da024:GetName(),
            "BOTTOM",
            0,
            -6
        )
        local BigFootBar_527e9de525b5c4635499afc0f0f44840 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            11,
            "LEFT",
            BigFootBar_df64fc302f6e608c524ab1613c38f587:GetName(),
            "RIGHT",
            6,
            0
        )
        local BigFootBar_428c0e6168551556f099cada47165338 =
            BigFootBar_37637622dabae2911e0a0b3c266c2ed4(
            BigFootBar_69072c73fde2ed407f863929fd1e7483,
            12,
            "LEFT",
            BigFootBar_527e9de525b5c4635499afc0f0f44840:GetName(),
            "RIGHT",
            6,
            0
        )
    end
end
function BigFootBar_53a0a7c289244b633760f09361be7083(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    BigFootBar_7817d76887ec66e3d20a7585faecddf9(BigFootBar_3e285ebeedd19f2a00429a2614a093d7, "horizontal")
end
function BigFootBar_c1a00077417bf72984105bce5124b1e3(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    BigFootBar_7817d76887ec66e3d20a7585faecddf9(BigFootBar_3e285ebeedd19f2a00429a2614a093d7, "vertical")
end
function BigFootBar_b6dde4aa477f5f69115fd309799fe42a(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    BigFootBar_7817d76887ec66e3d20a7585faecddf9(BigFootBar_3e285ebeedd19f2a00429a2614a093d7, "funny")
end
function BigFootBar_b740f76b158bf0246affe3865ebde2cf(BigFootBar_69072c73fde2ed407f863929fd1e7483)
    for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
        local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
            getglobal(
            BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
        )
        if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 and BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.hide) then
            return BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f - 1
        end
    end
    return BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c
end
function BigFootBar_1db89d9f19df64198d6ec146695e73df()
    local BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 = 0
    for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, MAX_ACTIVE_BAR_COUNT, 1 do
        local BigFootBar_69072c73fde2ed407f863929fd1e7483 =
            getglobal("BigFootBarFrame" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f)
        if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_69072c73fde2ed407f863929fd1e7483:IsVisible()) then
            BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 = BigFootBar_3f50417fb16be9b1078eb68d24fa9c26 + 1
        end
    end
    return BigFootBar_3f50417fb16be9b1078eb68d24fa9c26
end
function BigFootActionButton_OnEvent(self, event, ...)
    if (event == "ACTIONBAR_SHOWGRID") then
        BigFootActionButton_ShowGrid(self)
    elseif (event == "ACTIONBAR_HIDEGRID") then
        BigFootActionButton_HideGrid(self)
    else
        ActionButton_OnEvent(self, event, ...)
    end
end
function BigFootActionButton_ShowGrid(button)
    if (not InCombatLockdown()) then
        button:SetAttribute("showgrid", button:GetAttribute("showgrid") + 1)
        BigFootActionButton_UpdateGrid(button)
    end
end
function BigFootActionButton_HideGrid(button)
    if (not InCombatLockdown()) then
        local BigFootBar_7c92a639261d1e1015d3449a288a5933 = button:GetAttribute("showgrid")
        BigFootBar_7c92a639261d1e1015d3449a288a5933 = BigFootBar_7c92a639261d1e1015d3449a288a5933 - 1
        if (button.forceShow) then
            button.forceShow = nil
            BigFootBar_7c92a639261d1e1015d3449a288a5933 = BigFootBar_7c92a639261d1e1015d3449a288a5933 - 1
        end
        if (BigFootBar_7c92a639261d1e1015d3449a288a5933 < 0) then
            BigFootBar_7c92a639261d1e1015d3449a288a5933 = 0
        end
        button:SetAttribute("showgrid", BigFootBar_7c92a639261d1e1015d3449a288a5933)
        BigFootActionButton_UpdateGrid(button)
    end
end
function BigFootActionButton_UpdateGrid(button)
    if (button:GetAttribute("statehidden")) then
        button:Hide()
    elseif (HasAction(button:GetAttribute("action"))) then
        button:Show()
    elseif (button:GetAttribute("showgrid") >= 1) then
        button:Show()
    else
        button:Hide()
    end
end
function BigFootBarFrame_OnUpdate(self, elapsed)
    local BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89
    for BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89 = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
        local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
            getglobal(self:GetName() .. "ActionButton" .. BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89)
        if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.forceShow) then
            if (not BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.grid_timestamp) then
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.grid_timestamp = 0
            end
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.grid_timestamp =
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.grid_timestamp + elapsed
            if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.grid_timestamp > 5) then
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.forceShow = nil
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute(
                    "showgrid",
                    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:GetAttribute("showgrid") - 1
                )
            end
            BigFootActionButton_UpdateGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
        else
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.grid_timestamp = 0
        end
        if (not BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.bookFrameShow and SpellBookFrame:IsShown()) then
            BigFootActionButton_ShowGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.bookFrameShow = true
        elseif (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.bookFrameShow and not SpellBookFrame:IsShown()) then
            BigFootActionButton_HideGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.bookFrameShow = false
        end
    end
end
function BigFootBar_11e76fe10cb05184719f745e4db8a533(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    local BigFootBar_9248008bbb6d0ee7ce13f6ee45680051 =
        getglobal(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:GetName() .. "NormalTexture")
    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.hide = nil
    BigFootBar_9248008bbb6d0ee7ce13f6ee45680051:SetAlpha(0.3)
    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute("statehidden", nil)
    BigFootActionButton_UpdateGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    return true
end
function BigFootBar_572bc203d168039d0b16ee8ebdfc9d3a(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.hide = 1
    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute("statehidden", true)
    BigFootActionButton_UpdateGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
end
function BigFootBar_0e936090b47108f0fd0bb6b4fb2b5c65(BigFootBar_69072c73fde2ed407f863929fd1e7483)
    BigFootBar_69072c73fde2ed407f863929fd1e7483:ClearAllPoints()
    BigFootBar_69072c73fde2ed407f863929fd1e7483:SetPoint("CENTER", "UIParent", "CENTER", 0, 60)
end
function BigFootBar_18944ab3c3e030c1bfeaaffe49a94415()
    for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, MAX_ACTIVE_BAR_COUNT, 1 do
        local BigFootBar_69072c73fde2ed407f863929fd1e7483 =
            getglobal("BigFootBarFrame" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f)
        if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_69072c73fde2ed407f863929fd1e7483:IsVisible()) then
            BigFootBar_0e936090b47108f0fd0bb6b4fb2b5c65(BigFootBar_69072c73fde2ed407f863929fd1e7483)
        end
    end
end
function BigFootBar_9d9ae0ea8d213958f106e815d1c56b12()
end
function BigFootBar_97237904d4ede6ad5c9e57f69f2ac71d(BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e)
    local BigFootBar_69072c73fde2ed407f863929fd1e7483 =
        CreateFrame("Frame", BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e, UIParent, "BigFootBarFrameTemplate")
    BigFootBar_0e936090b47108f0fd0bb6b4fb2b5c65(BigFootBar_69072c73fde2ed407f863929fd1e7483)
    return BigFootBar_69072c73fde2ed407f863929fd1e7483
end
function BigFootBar_8255b0f6448dd3de248a67e8c53eec6b(BigFootBar_69072c73fde2ed407f863929fd1e7483)
    BigFootBar_69072c73fde2ed407f863929fd1e7483:Hide()
    for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
        local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
            getglobal(
            BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
        )
        BigFootBar_572bc203d168039d0b16ee8ebdfc9d3a(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    end
end
function BigFootBar_4c34961ddb1a82e3dabee32d55e91d31(BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e)
    local BigFootBar_65e6a9c457b63f1f4e18b37f608f2807 = BigFootBar_1db89d9f19df64198d6ec146695e73df()
    if (BigFootBar_65e6a9c457b63f1f4e18b37f608f2807 > MAX_ACTIVE_BAR_COUNT) then
        return
    end
    local BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
    local BigFootBar_69072c73fde2ed407f863929fd1e7483
    if (BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e) then
        local BigFootBar_6e4d0db7491d6883f86de390d20dbe5b,
            BigFootBar_a2f3972c23a0aa3bd7fb0e9823d918f2,
            BigFootBar_8d0febf2348ea712b2b375ae95601d5f =
            string.find(BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e, "^BigFootBarFrame(%d+)$")
        BigFootBar_69072c73fde2ed407f863929fd1e7483 = getglobal(BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e)
        if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_6e4d0db7491d6883f86de390d20dbe5b) then
            BigFootBar_69072c73fde2ed407f863929fd1e7483:Show()
            return BigFootBar_69072c73fde2ed407f863929fd1e7483
        else
            BigFootBar_69072c73fde2ed407f863929fd1e7483 =
                BigFootBar_97237904d4ede6ad5c9e57f69f2ac71d(BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e)
            BigFootBar_69072c73fde2ed407f863929fd1e7483:SetID(BigFootBar_8d0febf2348ea712b2b375ae95601d5f)
            local titile = getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "TabTitle")
            titile:SetText(BigFootBar_8d0febf2348ea712b2b375ae95601d5f)
            BigFootBar_69072c73fde2ed407f863929fd1e7483:Show()
            return BigFootBar_69072c73fde2ed407f863929fd1e7483
        end
    end
    for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, MAX_ACTIVE_BAR_COUNT, 1 do
        BigFootBar_69072c73fde2ed407f863929fd1e7483 =
            getglobal("BigFootBarFrame" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f)
        if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and not BigFootBar_69072c73fde2ed407f863929fd1e7483:IsVisible()) then
            BigFootBar_69072c73fde2ed407f863929fd1e7483:Show()
            return BigFootBar_69072c73fde2ed407f863929fd1e7483
        end
    end
    for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, MAX_ACTIVE_BAR_COUNT, 1 do
        BigFootBar_69072c73fde2ed407f863929fd1e7483 =
            getglobal("BigFootBarFrame" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f)
        if (not BigFootBar_69072c73fde2ed407f863929fd1e7483) then
            BigFootBar_69072c73fde2ed407f863929fd1e7483 =
                BigFootBar_97237904d4ede6ad5c9e57f69f2ac71d(
                "BigFootBarFrame" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
            )
            BigFootBar_69072c73fde2ed407f863929fd1e7483:SetID(BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f)
            local titile = getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "TabTitle")
            titile:SetText(BigFootBar_8d0febf2348ea712b2b375ae95601d5f)
            BigFootBar_69072c73fde2ed407f863929fd1e7483:Show()
            return BigFootBar_69072c73fde2ed407f863929fd1e7483
        end
    end
end
function BigFootBar_5d071f6d0710f0143d9058bcda4608e1()
    local BigFootBar_69072c73fde2ed407f863929fd1e7483 = BigFootBar_4c34961ddb1a82e3dabee32d55e91d31()
    local BigFootBar_9c289060f01bdfd0d82b46cc13ae58a1
    if (BigFootBar_69072c73fde2ed407f863929fd1e7483) then
        local titile = getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "TabTitle")
        titile:SetText(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetID())
        BigFootBar_69072c73fde2ed407f863929fd1e7483.isLocked = nil
        BigFootBar_69072c73fde2ed407f863929fd1e7483.minimized = nil
        BigFootBar_69072c73fde2ed407f863929fd1e7483.sonID = 1
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
            local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                getglobal(
                BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                    "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
            )
            local BigFootBar_8d0febf2348ea712b2b375ae95601d5f =
                BigFootBar_69072c73fde2ed407f863929fd1e7483.sonID +
                (10 - BigFootBar_69072c73fde2ed407f863929fd1e7483:GetID()) * BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetScript(
                "OnEvent",
                function(self, event, ...)
                    BigFootActionButton_OnEvent(self, event, ...)
                end
            )
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute(
                "action",
                BigFootBar_8d0febf2348ea712b2b375ae95601d5f
            )
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.bookFrameShow = nil
            BigFootBar_11e76fe10cb05184719f745e4db8a533(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            BigFootBar_69072c73fde2ed407f863929fd1e7483.sonID = BigFootBar_69072c73fde2ed407f863929fd1e7483.sonID + 1
            BigFootBar_9c289060f01bdfd0d82b46cc13ae58a1 = true
            if (BigFootBar_f97a2a7812f94d4bb34fcf1f04f5711e) then
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute("showgrid", 1)
            else
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute("showgrid", 0)
            end
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.forceShow = true
            BigFootActionButton_ShowGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            BigFootActionButton_UpdateGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
        end
        for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = BigFootBar_e2d5f352154387b81189558196c18e82 + 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
            local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                getglobal(
                BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                    "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
            )
            BigFootBar_572bc203d168039d0b16ee8ebdfc9d3a(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
        end
        BigFootBar_7817d76887ec66e3d20a7585faecddf9(BigFootBar_69072c73fde2ed407f863929fd1e7483, "vertical")
        BigFootBar_9bf8053183f37cc485e2dcebb062ab02(BigFootBar_69072c73fde2ed407f863929fd1e7483)
        if (not BigFootBar_9c289060f01bdfd0d82b46cc13ae58a1) then
            BigFootBar_503ed091c79944be5b7079c0602f8146(BigFootBar_69072c73fde2ed407f863929fd1e7483)
        end
        BigFootBar_bceab2d4ca6bac097d8aac711b117e68()
    end
end
function BigFootBar_503ed091c79944be5b7079c0602f8146(self, BigFootBar_69072c73fde2ed407f863929fd1e7483, destroy)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7
    if (BigFootBar_69072c73fde2ed407f863929fd1e7483) then
        BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_69072c73fde2ed407f863929fd1e7483
    else
        BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    end
    BigFootBar_9bf8053183f37cc485e2dcebb062ab02(BigFootBar_3e285ebeedd19f2a00429a2614a093d7, destroy)
    BigFootBar_8255b0f6448dd3de248a67e8c53eec6b(BigFootBar_3e285ebeedd19f2a00429a2614a093d7)
end
function BigFootBar_45eed77ae29ae5fa45c281c9f2e34a2b()
    local BigFootBar_8983c60d66c8593ec7165ea9dbedb584 = UnitName("Player")
    if
        (not BigFootBar_8983c60d66c8593ec7165ea9dbedb584 or BigFootBar_8983c60d66c8593ec7165ea9dbedb584 == UNKNOWNOBJECT or
            BigFootBar_8983c60d66c8593ec7165ea9dbedb584 == UKNOWNBEING)
     then
        return nil
    end
    if (not BigFootBar_Info[BigFootBar_8983c60d66c8593ec7165ea9dbedb584]) then
        BigFootBar_Info[BigFootBar_8983c60d66c8593ec7165ea9dbedb584] = {}
    end
    return BigFootBar_Info[BigFootBar_8983c60d66c8593ec7165ea9dbedb584]
end
function BigFootBar_39617e6afb8c5b386f4220eb9cedc482(BigFootBar_69072c73fde2ed407f863929fd1e7483)
    if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_69072c73fde2ed407f863929fd1e7483:IsVisible()) then
        local BigFootBar_bba564c01b4659989f8d87879ec9fe5e = BigFootBar_45eed77ae29ae5fa45c281c9f2e34a2b()
        local BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa =
            BigFootBar_bba564c01b4659989f8d87879ec9fe5e[BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName()]
        if (BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa and BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.region) then
            BigFootBar_69072c73fde2ed407f863929fd1e7483.arrangement =
                BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.arrangement
            BigFootBar_69072c73fde2ed407f863929fd1e7483.isLocked = BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.isLocked
            BigFootBar_69072c73fde2ed407f863929fd1e7483.minimized =
                BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.minimized
            BigFootBar_69072c73fde2ed407f863929fd1e7483.scale = BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.scale
            BigFootBar_69072c73fde2ed407f863929fd1e7483.toggleDurabilityFrame =
                BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.toggleDurabilityFrame
            if (BigFootBar_69072c73fde2ed407f863929fd1e7483.scale) then
                BigFootBar_f40fe078ddd73cb3e7cc2600b489b79e:SetScale(
                    BigFootBar_69072c73fde2ed407f863929fd1e7483,
                    BigFootBar_69072c73fde2ed407f863929fd1e7483.scale
                )
            end
            BigFootBar_69072c73fde2ed407f863929fd1e7483:ClearAllPoints()
            BigFootBar_69072c73fde2ed407f863929fd1e7483:SetPoint(
                "TOPLEFT",
                "UIParent",
                "BOTTOMLEFT",
                BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.region.left,
                BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.region.top
            )
            BigFootBar_7817d76887ec66e3d20a7585faecddf9(
                BigFootBar_69072c73fde2ed407f863929fd1e7483,
                BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.arrangement
            )
            if (BigFootBar_69072c73fde2ed407f863929fd1e7483.toggleDurabilityFrame) then
                BigFootBar_ToggleDurabilityFrame(1)
            end
        end
    end
end
function BigFootBar_25b1d2fe6e14021d74f8def30b5d48bc()
    local BigFootBar_c685f4925ec02e7e5f0d12a9e63db683 = BigFootBar_45eed77ae29ae5fa45c281c9f2e34a2b()
    if (not BigFootBar_c685f4925ec02e7e5f0d12a9e63db683) then
        BigFoot_DelayCall(BigFootBar_25b1d2fe6e14021d74f8def30b5d48bc, 2)
        return
    end
    local BigFootBar_ff4467bc8864d2ea7b10717bedfa5445 = nil
    local __index
    for __index = 1, MAX_ACTIVE_BAR_COUNT, 1 do
        local BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e = "BigFootBarFrame" .. __index
        if (BigFootBar_c685f4925ec02e7e5f0d12a9e63db683[BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e]) then
            local BigFootBar_69072c73fde2ed407f863929fd1e7483 = getglobal(BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e)
            if (not BigFootBar_69072c73fde2ed407f863929fd1e7483) then
                BigFootBar_69072c73fde2ed407f863929fd1e7483 =
                    BigFootBar_4c34961ddb1a82e3dabee32d55e91d31(BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e)
            else
                BigFootBar_69072c73fde2ed407f863929fd1e7483:Show()
            end
            BigFootBar_69072c73fde2ed407f863929fd1e7483.keyframe = CreateFrame("Frame", nil, UIParent)
            BigFootBar_69072c73fde2ed407f863929fd1e7483.sonID = 1
            local BigFootBar_d5559836e6861c025e096cb9c41eda8c =
                BigFootBar_c685f4925ec02e7e5f0d12a9e63db683[BigFootBar_a089a0b53f3ee0ef6a00560e0ec5f20e].buttonCount
            if (not BigFootBar_d5559836e6861c025e096cb9c41eda8c) then
                BigFootBar_d5559836e6861c025e096cb9c41eda8c = BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c
            end
            for BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89 = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
                local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                    getglobal(
                    BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                        "ActionButton" .. BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89
                )
                local BigFootBar_8d0febf2348ea712b2b375ae95601d5f =
                    BigFootBar_69072c73fde2ed407f863929fd1e7483.sonID +
                    (10 - BigFootBar_69072c73fde2ed407f863929fd1e7483:GetID()) *
                        BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute(
                    "action",
                    BigFootBar_8d0febf2348ea712b2b375ae95601d5f
                )
                BigFootBar_69072c73fde2ed407f863929fd1e7483.sonID =
                    BigFootBar_69072c73fde2ed407f863929fd1e7483.sonID + 1
                BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetScript(
                    "OnEvent",
                    function(self, event, ...)
                        BigFootActionButton_OnEvent(self, event, ...)
                    end
                )
                if (BigFootBar_f97a2a7812f94d4bb34fcf1f04f5711e) then
                    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute("showgrid", 1)
                else
                    BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5:SetAttribute("showgrid", 0)
                end
            end
            for BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89 = 1, BigFootBar_d5559836e6861c025e096cb9c41eda8c, 1 do
                local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                    getglobal(
                    BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                        "ActionButton" .. BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89
                )
                BigFootBar_11e76fe10cb05184719f745e4db8a533(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            end
            for BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89 = BigFootBar_d5559836e6861c025e096cb9c41eda8c + 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
                local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                    getglobal(
                    BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                        "ActionButton" .. BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89
                )
                BigFootBar_572bc203d168039d0b16ee8ebdfc9d3a(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            end
            for BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89 = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
                local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
                    getglobal(
                    BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() ..
                        "ActionButton" .. BigFootBar_3a8b5e464751a955ba4c6d2e5a20ec89
                )
                BigFootActionButton_UpdateGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
            end
            BigFootBar_39617e6afb8c5b386f4220eb9cedc482(BigFootBar_69072c73fde2ed407f863929fd1e7483)
            local titile = getglobal(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName() .. "TabTitle")
            titile:SetText(BigFootBar_69072c73fde2ed407f863929fd1e7483:GetID())
            if (BigFootBar_69072c73fde2ed407f863929fd1e7483.minimized) then
                BigFootBar_4a8bce8af3e339e7256a76e8fd38aa73(BigFootBar_69072c73fde2ed407f863929fd1e7483)
            end
            BigFootBar_ff4467bc8864d2ea7b10717bedfa5445 = true
        end
    end
    if (not BigFootBar_ff4467bc8864d2ea7b10717bedfa5445) then
        BigFootBar_5d071f6d0710f0143d9058bcda4608e1()
    end
end
function BigFootBar_d7613b704685de240b505fbb41cef8ca(
    BigFootBar_6d5e7d83d8358745ae4dcf61d16bd1f3,
    BigFootBar_eed0be1c2d5f65980b06b5094460c3c5)
    if (BigFootBar_6d5e7d83d8358745ae4dcf61d16bd1f3 == "Error") then
        ChatFrame1:AddMessage(BigFootBar_eed0be1c2d5f65980b06b5094460c3c5, 1.0, 0.0, 0.0)
    elseif (BigFootBar_6d5e7d83d8358745ae4dcf61d16bd1f3 == "Info") then
        ChatFrame1:AddMessage(BigFootBar_eed0be1c2d5f65980b06b5094460c3c5, 1.0, 1.0, 0.0)
    end
end
function BigFootBar_b426b0ee17555ad80167ab19c3adbf2d(BigFootBar_69072c73fde2ed407f863929fd1e7483)
    local BigFootBar_9112dfed749d840c7819e10f55f2697b = {}
    BigFootBar_9112dfed749d840c7819e10f55f2697b.left = BigFootBar_69072c73fde2ed407f863929fd1e7483:GetLeft()
    BigFootBar_9112dfed749d840c7819e10f55f2697b.right = BigFootBar_69072c73fde2ed407f863929fd1e7483:GetRight()
    BigFootBar_9112dfed749d840c7819e10f55f2697b.top = BigFootBar_69072c73fde2ed407f863929fd1e7483:GetTop()
    BigFootBar_9112dfed749d840c7819e10f55f2697b.bottom = BigFootBar_69072c73fde2ed407f863929fd1e7483:GetBottom()
    if
        (not BigFootBar_9112dfed749d840c7819e10f55f2697b.left or not BigFootBar_9112dfed749d840c7819e10f55f2697b.right or
            not BigFootBar_9112dfed749d840c7819e10f55f2697b.top or
            not BigFootBar_9112dfed749d840c7819e10f55f2697b.bottom)
     then
        return nil
    end
    BigFootBar_9112dfed749d840c7819e10f55f2697b.left =
        math.floor(BigFootBar_9112dfed749d840c7819e10f55f2697b.left + 0.5)
    BigFootBar_9112dfed749d840c7819e10f55f2697b.right =
        math.floor(BigFootBar_9112dfed749d840c7819e10f55f2697b.right + 0.5)
    BigFootBar_9112dfed749d840c7819e10f55f2697b.top = math.floor(BigFootBar_9112dfed749d840c7819e10f55f2697b.top + 0.5)
    BigFootBar_9112dfed749d840c7819e10f55f2697b.bottom =
        math.floor(BigFootBar_9112dfed749d840c7819e10f55f2697b.bottom + 0.5)
    return BigFootBar_9112dfed749d840c7819e10f55f2697b
end
function BigFootBar_9bf8053183f37cc485e2dcebb062ab02(BigFootBar_69072c73fde2ed407f863929fd1e7483, destroy)
    local BigFootBar_bba564c01b4659989f8d87879ec9fe5e = BigFootBar_45eed77ae29ae5fa45c281c9f2e34a2b()
    if (BigFootBar_69072c73fde2ed407f863929fd1e7483 and BigFootBar_bba564c01b4659989f8d87879ec9fe5e) then
        if destroy then
            BigFootBar_bba564c01b4659989f8d87879ec9fe5e[BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName()] = nil
        else
            local BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa = {}
            local BigFootBar_9112dfed749d840c7819e10f55f2697b =
                BigFootBar_b426b0ee17555ad80167ab19c3adbf2d(BigFootBar_69072c73fde2ed407f863929fd1e7483)
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.region = BigFootBar_9112dfed749d840c7819e10f55f2697b
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.arrangement =
                BigFootBar_69072c73fde2ed407f863929fd1e7483.arrangement
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.isLocked = BigFootBar_69072c73fde2ed407f863929fd1e7483.isLocked
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.minimized =
                BigFootBar_69072c73fde2ed407f863929fd1e7483.minimized
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.scale = BigFootBar_69072c73fde2ed407f863929fd1e7483.scale
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.toggleDurabilityFrame =
                BigFootBar_69072c73fde2ed407f863929fd1e7483.toggleDurabilityFrame
            BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.buttonCount =
                BigFootBar_b740f76b158bf0246affe3865ebde2cf(BigFootBar_69072c73fde2ed407f863929fd1e7483)
            BigFootBar_bba564c01b4659989f8d87879ec9fe5e[BigFootBar_69072c73fde2ed407f863929fd1e7483:GetName()] =
                BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa
        end
    end
end
function BigFootBar_519dd29c57db397976fd839a096551aa(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    local BigFootBar_6230e23f021dec637edabaa368556c06 = BigFootBar_3e285ebeedd19f2a00429a2614a093d7.scale
    if (not BigFootBar_6230e23f021dec637edabaa368556c06) then
        BigFootBar_6230e23f021dec637edabaa368556c06 = 1
    end
    local BigFootBar_b4d3314490a868cf61f5fbd057900b0b =
        getglobal(BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName() .. "Tab")
    local BigFootBar_0694c14294eb642e50750f9964155ae0 =
        BigFootBar_b4d3314490a868cf61f5fbd057900b0b:GetTop() *
        BigFootBar_b4d3314490a868cf61f5fbd057900b0b:GetEffectiveScale()
    local BigFootBar_92fc56267c7e14d288fbcf74f912203d =
        BigFootBar_b4d3314490a868cf61f5fbd057900b0b:GetLeft() *
        BigFootBar_b4d3314490a868cf61f5fbd057900b0b:GetEffectiveScale()
    BigFootBarOpacitySlider.frame = nil
    BigFootBarOpacitySlider:SetAlpha(1)
    BigFootBarOpacitySlider:ClearAllPoints()
    BigFootBarOpacitySlider:SetPoint(
        "TOPLEFT",
        "UIParent",
        "BOTTOMLEFT",
        BigFootBar_92fc56267c7e14d288fbcf74f912203d - 20,
        BigFootBar_0694c14294eb642e50750f9964155ae0
    )
    BigFootBarOpacitySlider:Show()
    BigFootBarOpacitySlider:SetMinMaxValues(50, 150)
    BigFootBarOpacitySlider:SetValueStep(10)
    if (BigFootBar_3e285ebeedd19f2a00429a2614a093d7.scale) then
        BigFootBarOpacitySlider:SetValue(BigFootBar_3e285ebeedd19f2a00429a2614a093d7.scale * 100)
    else
        BigFootBarOpacitySlider:SetValue(100)
    end
    BigFootBarOpacitySlider.frame = BigFootBar_3e285ebeedd19f2a00429a2614a093d7
end
function BigFootBar_4a8bce8af3e339e7256a76e8fd38aa73(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
        local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
            getglobal(
            BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName() ..
                "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
        )
        if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5) then
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.minimized = 1
            BigFootBar_572bc203d168039d0b16ee8ebdfc9d3a(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
        end
    end
    BigFootBar_3e285ebeedd19f2a00429a2614a093d7.minimized = 1
    BigFootBar_9bf8053183f37cc485e2dcebb062ab02(BigFootBar_3e285ebeedd19f2a00429a2614a093d7)
end
function BigFootBar_f7b216cf55af9a4d5e1d6041d1932933(self)
    local BigFootBar_3e285ebeedd19f2a00429a2614a093d7 = BigFootBar_f629400f4fd6783f76cae53198dfd8ac(self)
    for BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f = 1, BigFootBar_d349b5a445bb2bc464bbb5e31d411f4c, 1 do
        local BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 =
            getglobal(
            BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName() ..
                "ActionButton" .. BigFootBar_e914904fab9d05d3f54d52bfc31a0f3f
        )
        if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 and BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.hide) then
            BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5.minimized = nil
            BigFootBar_11e76fe10cb05184719f745e4db8a533(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
        end
        ActionButton_UpdateState(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
        BigFootActionButton_UpdateGrid(BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    end
    BigFootBar_3e285ebeedd19f2a00429a2614a093d7.minimized = nil
    local BigFootBar_bba564c01b4659989f8d87879ec9fe5e = BigFootBar_45eed77ae29ae5fa45c281c9f2e34a2b()
    local BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa =
        BigFootBar_bba564c01b4659989f8d87879ec9fe5e[BigFootBar_3e285ebeedd19f2a00429a2614a093d7:GetName()]
    BigFootBar_7817d76887ec66e3d20a7585faecddf9(
        BigFootBar_3e285ebeedd19f2a00429a2614a093d7,
        BigFootBar_a44ecbf575d7f2eca081a0592e8d84fa.arrangement
    )
    BigFootBar_9bf8053183f37cc485e2dcebb062ab02(BigFootBar_3e285ebeedd19f2a00429a2614a093d7)
end
function BigFootBar_ToggleDurabilityFrame(BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (BigFootBar_7739b813d90aed43ab9d0eb84ec1c1ae) then
        DurabilityFrame:SetPoint("TOP", "MinimapCluster", "BOTTOM", -20, 15)
    else
        DurabilityFrame:SetPoint("TOP", "MinimapCluster", "BOTTOM", 40, 15)
    end
end
function BigFootBar_OnMouseDown(self, BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    if (BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5 ~= "LeftButton") then
        return
    end
    local BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a = self:GetParent()
    if
        (not BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a.isLocked and
            not BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a.inCombat)
     then
        BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a:StartMoving()
        BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a.moving = true
        MOVING_BIGFOOTBAR = BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a
    end
end
function BigFootBar_OnMouseUp(self, BigFootBar_99f3cf2c6f1fdfadb0fd4ab6e0843bf5)
    local BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a = self:GetParent()
    if (BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a.moving or InCombatLockdown()) then
        BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a:StopMovingOrSizing()
        BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a.moving = false
        MOVING_BIGFOOTBAR = nil
        BigFootBar_9bf8053183f37cc485e2dcebb062ab02(BigFootBar_411b8aa6d5954c6020f0b9c9e80e847a)
    end
end
function BigFootBarTab_OnEnter(self)
    self:GetParent().isFading = nil
    self:GetParent().locking = true
    GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
    GameTooltip:SetText(BIGFOOTBAR_TAB_HELP_TEXT)
    GameTooltip:Show()
end
function BigFootBarTab_OnLeave(self)
    local dropdown = getglobal(self:GetName() .. "DropDown")
    if (BDropDownMenu_GetCurrentDropDown() ~= dropdown) then
        self:GetParent().locking = nil
    end
    self:GetParent().lastLeave = GetTime()
    GameTooltip:Hide()
end
function BigFootBarOpacitySlider_OnValueChanged(self, value)
    getglobal(self:GetName() .. "Text"):SetText(math.floor(value) .. "%")
    if (self.frame) then
        BigFootBar_f40fe078ddd73cb3e7cc2600b489b79e:SetScale(self.frame, value / 100)
        self.frame.scale = value / 100
        BigFootBar_9bf8053183f37cc485e2dcebb062ab02(self.frame)
    end
end
local function BigFootBar_3132bb65521790fe81fb039758b0f1f0()
    if (BigFootBarOpacitySlider.Leave) then
        BigFootBarOpacitySlider:Hide()
    end
end
local function BigFootBar_d4c4d4c5dde2baa01c763775a64361ff()
    if (BigFootBarOpacitySlider.Leave) then
        UIFrameFadeIn(BigFootBarOpacitySlider, 0.5, 1, 0)
        BigFoot_DelayCall(BigFootBar_3132bb65521790fe81fb039758b0f1f0, 0.5)
    end
end
function BigFootBarOpacitySlider_OnEnter(self)
    BigFootBarOpacitySlider.Leave = nil
end
function BigFootBarOpacitySlider_OnLeave(self)
    if (BigFootBarOpacitySlider.frame) then
        BigFootBarOpacitySlider.Leave = 1
    end
    BigFoot_DelayCall(BigFootBar_d4c4d4c5dde2baa01c763775a64361ff, 2)
end
