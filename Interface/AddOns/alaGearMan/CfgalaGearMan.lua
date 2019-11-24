U1RegisterAddon("alaGearMan", {
    title = "一键换装",
    tags = { TAG_INTERFACE, },
    desc = "提供与正式服类似的一键换装功能，并创建一个屏幕按钮。\n按住CTRL拖动可以移动位置。",
    load = "NORMAL",
    defaultEnable = 1,
    nopic = 1,
    --minimap = 'LibDBIcon10_alaTalentEmu', 
    icon = [[interface\paperdollinfoframe\ui-gearmanager-button]],

    -- {
    --     text = "配置选项",
    --     callback = function(cfg, v, loading)
    --             -- InterfaceOptionsFrame_Show();
    --             -- InterfaceOptionsFrame_OpenToCategory("alaChat_Classic");
    --     end
    -- }
});

