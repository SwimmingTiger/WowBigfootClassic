
---@class L
local L = LibStub('AceLocale-3.0'):NewLocale(..., 'zhCN')
if not L then
    return
end

-- @import@
L['Leave bank, pack cancel.'] = '离开银行，整理中止。'
L['Player enter combat, pack cancel.'] = '进入战斗，整理中止。'
L['Packing now'] = '正在整理'
L['Player is dead'] = '角色已死亡'
L['Player in combat'] = '正在战斗'
L['Please drop the item, money or skills.'] = '请放下鼠标上的东西'
L['Some slot is locked'] = '一些物品已锁定'
L['Pack finish.'] = '整理完成'

L['Reverse pack'] = '反向整理'
L['Enable chat message'] = '启用聊天窗口消息'
L['Character Specific Settings'] = '角色独立设置'

L['Left Click'] = '左键'
L['Right Click'] = '右键'

L['Bag button features'] = '背包按钮功能'
L['Bank button features'] = '银行按钮功能'
L['Reset sorting rules'] = '重置排序规则'
L['Are you sure to |cffff1919RESET|r sorting rules?'] = '你确定|cffff1919重置|r排序规则？'
L['Reset saving rules'] = '重置保存规则'
L['Are you sure to |cffff1919RESET|r saving rules?'] = '你确定|cffff1919重置|r保存规则？'

L['Already exists'] = '已经存在'
L['Add advance rule'] = '添加高级规则'
L['Are you sure |cffff191919DELETE|r rule and its |cffff1919SUBRULES|r?'] =
    '你确定|cffff1919删除|r规则和它的|cffff1919子规则|r吗？'
L['Are you sure |cffff191919DELETE|r rule?'] = '你确定|cffff1919删除|r规则吗？'

L['Root'] = '根'
L['Rule'] = '规则'
L['Put where?'] = '放在哪？'
L['Name (Optional)'] = '名称（可选）'
L['Select an icon (Optional)'] = '选择一个图标（可选）'
L['Sorting rules'] = '排序规则'
L['Saving rules'] = '保存规则'
L['Save to bank when default packing'] = '默认整理同时保存到银行'
L['Global'] = '全局'
L['Add extension filter to LibItemSearch-1.2'] = '将扩展的过滤器添加到LibItemSearch-1.2'

L['Help'] = '帮助'
L['Drag to modify the sorting order'] = '拖动以改变规则顺序'
L['Put in an item to add simple rule'] = '放下一个物品以添加简单规则'
L['Advancee rules use LibItemSearch-1.2'] = '高级规则使用LibItemSearch-1.2'
L['Enjoy!'] = '祝你愉快！'

-- for actions
L.None = '无'
L.SORT = '默认整理'
L.SORT_BAG = '整理背包'
L.SORT_BAG_ASC = '顺序整理背包'
L.SORT_BAG_DESC = '逆序整理背包'
L.SORT_BANK = '整理银行'
L.SORT_BANK_ASC = '顺序整理银行'
L.SORT_BANK_DESC = '逆序整理银行'
L.SORT_ASC = '顺序整理全部'
L.SORT_DESC = '逆序整理全部'
L.OPEN_RULE_OPTIONS = '打开规则设置'
L.OPEN_OPTIONS = '打开设置'
L.SAVE = '保存到银行'

-- rules comment
L.COMMENT_MOUNT = '坐骑'
L.COMMENT_CLASS = '职业物品'

-- for rules
L.KEYWORD_MOUNT = '使用： 召唤或解散'
L.KEYWORD_CLASS = '职业：'

L.Tools = '工具'

-- @end-import@
