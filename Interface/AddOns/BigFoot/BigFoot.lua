--[[ BigFoot.lua 这里设置的主要是关于变量存储的数据 同时，一些简单的接口开关也设置在这里 同时一个主要的功能是 定义设置界面的接口 包括： BigFoot_SetModVariable BigFoot_GetModVariable BigFoot_ShowKeyBindingFrame 版本：1.15 更新时间：2004年10月24日 更新作者：Andy Xiao ]] if
    (GetLocale() == "zhCN")
 then
    BF_RELOADUI_CONFIRM = "该操作将会重新载入所有的插件，你确信要这么做吗？"
    BF_CENTER_TOOLTIP = "将信息提示放置在屏幕顶上"
    BF_URL_TEXT =
        '|cffffffff该功能将开启游戏外的网页，会导致当前任务切换到游戏外的IE浏览器。\n\n如果你想继续，请按"|cffffd100Ctrl+C|r"。\n|cff00ffff(该功能仅在客户端开启时才有效)|r|r'
    BF_HEADER = "大脚设置"
    BF_NAME = "大脚插件"
    TAB_OTHERS = "其它设置"
    TAB_ACTIONBAR = "动作条"
    TAB_GENERAL = "一般设置"
    START_LOADADDON = "|cff00e0e0大脚开始载入插件...|r"
    ALL_ADDON_LOADED = "|cff00e0e0全部插件载入完毕。|r"
    ON_ADDON_LOAD = "|cff00efe0插件【|r|c000EEE00%s|r|cff00efe0】载入成功 |r"
    ERR_FRIEND_ONLINE_SS = "|Hplayer:%s|h[%s]|h上线了。"
    BF_MINIBUTTON_TIP_TITLE = "大脚设置"
    BF_MINIBUTTON_TIP_TEXT = "◇左键单击按钮打开设置。\n◇右键单击按钮查看额外信息功能。\n◇按住按钮进行拖动，可以沿小地图外\n　沿改变按钮的位置。"
    BF_VERSION_PATTERN = "|cff00e0e0当前大脚插件的版本为：<%s>。|r"
    BF_BASIC_INFO = "基本信息"
    BF_VERSION_INFO = "版本信息"
    BF_SHUANGCAI = "双采"
    BF_FINDING_MINING = "寻找矿物"
    BF_FINDING_HERBS = "寻找草药"
elseif (GetLocale() == "zhTW") then
    BF_RELOADUI_CONFIRM = "該操作將會重新載入所有的插件，你確信要這麼做嗎？"
    BF_CENTER_TOOLTIP = "將訊息提示放置在螢幕頂端"
    BF_URL_TEXT =
        '|cffffffff該功能將開啟遊戲外的網頁，會導致當前任務切換到遊戲外的IE流覽器。\n\n如果你想繼續，請按"|cffffd100Ctrl+C|r"。\n|cff00ffff(該功能僅在用戶端開啟時才有效)|r|r'
    BF_HEADER = "大腳設置"
    BF_NAME = "大腳插件"
    TAB_OTHERS = "其它設置"
    TAB_ACTIONBAR = "快捷列"
    TAB_GENERAL = "一般設置"
    START_LOADADDON = "|cff00e0e0大腳開始載入插件... |r"
    ALL_ADDON_LOADED = "|cff00e0e0全部插件載入完畢。|r"
    ON_ADDON_LOAD = "|cff00efe0插件【|r|c000EEE00%s|r|cff00efe0】載入成功 |r"
    BF_MINIBUTTON_TIP_TITLE = "大腳設置"
    BF_MINIBUTTON_TIP_TEXT = "◇左鍵單擊按鈕打開設置。\n◇右鍵單擊按鈕查看額外資訊功能。\n◇按住按鈕進行拖動，可以沿小地圖外\n　沿改變按鈕的位置。"
    BF_VERSION_PATTERN = "|cff00e0e0當前大腳插件的版本為：<%s>。|r"
    BF_BASIC_INFO = "基本資訊"
    BF_VERSION_INFO = "版本資訊"
    BF_SHUANGCAI = "雙采"
    BF_FINDING_MINING = "尋找礦物"
    BF_FINDING_HERBS = "尋找草藥"
else
    BF_RELOADUI_CONFIRM = "This will reload all your AddOns, do you continue?"
    BF_CENTER_TOOLTIP = "Rearrange Tooltip"
    BF_URL_TEXT =
        '|cffffffThe function will open web page outside, it will change current task to Internet Explorer.\n\nIf you want to continue, press"|cffffd100Ctrl+C|r".\n|cff00ffff(Available when BigFoot Client is runing)|r|r'
    BF_HEADER = "BigFoot Menu"
    BF_NAME = "BigFoot"
    TAB_OTHERS = "Others"
    TAB_ACTIONBAR = "Action Bar"
    TAB_GENERAL = "General"
    START_LOADADDON = "START_LOADADDON"
    ALL_ADDON_LOADED = "ALL_ADDON_LOADED"
    BF_MINIBUTTON_TIP_TITLE = "BigFoot Settings"
    BF_MINIBUTTON_TIP_TEXT =
        "Left click to open settings window.\nRight click to view extra functions and information.\nDrag the button to change the position."
    BF_BUY_CONFIRM = "You will buy a new slot, are you sure?"
    BF_VERSION_PATTERN = "|cff00e0e0The current version is <%s>.|r"
    BF_ALL_ADDONS_LOADED = "|cff00e0e0All Addons loaded, time used:<%2.1f seconds.|r"
    BF_BASIC_INFO = "Basic Information"
    BF_VERSION_INFO = "Version Information"
    BF_SHUANGCAI = "Dual Finding"
    BF_FINDING_MINING = "Find Minerals"
    BF_FINDING_HERBS = "Find Herbs"
end
local _
local ISVARIABLESLoaded, bNewBigfoot
local BigfootConfigVersion = 20120927
local START_LOADADDON_BIAOSHI = "|cff00e0e0***********************|r"
local CallTab = {}
local LaterTab = {}
local bigfoot_DisableTab = {}
local configCollector = {}
local BigFoot_54712cfd3a2c182c0e5e07016c830ccb = {}
local BigFoot_472174287cb12dced3487a304239203f = {}
BigFoot_SysTemSetTab = {BigFoot_LoadBefore = 1}
BigFoot_Config = {}
BigFoot_Error = {}
BigFoot_Character = {}
StaticPopupDialogs["RELOADUI_CONFIRM"] = {
    preferredIndex = STATICPOPUP_NUMDIALOGS,
    text = BF_RELOADUI_CONFIRM,
    button1 = YES,
    button2 = NO,
    OnAccept = function()
        ReloadUI()
    end,
    showAlert = 1,
    timeout = 0,
    hideOnEscape = 1
}
local function BigFoot_fff18c914a5b3a8d509f2dff0f3fc382()
    local BigFoot_9e83872083ad957c8f380801be754171
    for BigFoot_e914904fab9d05d3f54d52bfc31a0f3f = 1, 4, 1 do
        BigFoot_9e83872083ad957c8f380801be754171 =
            getglobal("PartyMemberFrame" .. BigFoot_e914904fab9d05d3f54d52bfc31a0f3f)
        BigFoot_9e83872083ad957c8f380801be754171.virtual_frames = {}
        BigFoot_9e83872083ad957c8f380801be754171.UpdateAnchorFrames = function(self)
            self.virtual_width = 0
            for BigFoot_e914904fab9d05d3f54d52bfc31a0f3f = 9, 1, -1 do
                if (self.virtual_frames[BigFoot_e914904fab9d05d3f54d52bfc31a0f3f]) then
                    for BigFoot_5e57ab95c762a48d9a126b104db1056f, BigFoot_2e00ffac12aadb3a1fd865993ec505b9 in ipairs(
                        self.virtual_frames[BigFoot_e914904fab9d05d3f54d52bfc31a0f3f]
                    ) do
                        BigFoot_2e00ffac12aadb3a1fd865993ec505b9.frame:SetPoint(
                            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.point,
                            self,
                            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.rpoint,
                            self.virtual_width + BigFoot_2e00ffac12aadb3a1fd865993ec505b9.x,
                            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.y
                        )
                        self.virtual_width = self.virtual_width + BigFoot_2e00ffac12aadb3a1fd865993ec505b9.width
                    end
                end
            end
        end
        BigFoot_9e83872083ad957c8f380801be754171.RegisterAnchorFrame = function(
            self,
            BigFoot_411b8aa6d5954c6020f0b9c9e80e847a,
            BigFoot_8e2d4ef9193eed09cc6ce5849fad1f0a,
            BigFoot_7dce5c33f0d4836b30c14f18b2fc43f7,
            BigFoot_7c8715eaf85fa16b3da6112f58ebd62d,
            BigFoot_b254e387cf58e982ba24fcb3e8a63995,
            BigFoot_a0f453fd098c0b0fda780f69cda6ffbf,
            BigFoot_aacf928ffa23e474a000b1b6292d02a9)
            if (not self.virtual_frames[BigFoot_8e2d4ef9193eed09cc6ce5849fad1f0a]) then
                self.virtual_frames[BigFoot_8e2d4ef9193eed09cc6ce5849fad1f0a] = {}
            end
            for BigFoot_e914904fab9d05d3f54d52bfc31a0f3f, BigFoot_2e00ffac12aadb3a1fd865993ec505b9 in ipairs(
                self.virtual_frames[BigFoot_8e2d4ef9193eed09cc6ce5849fad1f0a]
            ) do
                if (BigFoot_2e00ffac12aadb3a1fd865993ec505b9.frame == BigFoot_411b8aa6d5954c6020f0b9c9e80e847a) then
                    BigFoot_2e00ffac12aadb3a1fd865993ec505b9.width = BigFoot_aacf928ffa23e474a000b1b6292d02a9
                    BigFoot_2e00ffac12aadb3a1fd865993ec505b9.point = BigFoot_7dce5c33f0d4836b30c14f18b2fc43f7
                    BigFoot_2e00ffac12aadb3a1fd865993ec505b9.rpoint = BigFoot_7c8715eaf85fa16b3da6112f58ebd62d
                    BigFoot_2e00ffac12aadb3a1fd865993ec505b9.x = BigFoot_b254e387cf58e982ba24fcb3e8a63995
                    BigFoot_2e00ffac12aadb3a1fd865993ec505b9.y = BigFoot_a0f453fd098c0b0fda780f69cda6ffbf
                    self:UpdateAnchorFrames()
                    return
                end
            end
            local BigFoot_2e00ffac12aadb3a1fd865993ec505b9 = {}
            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.frame = BigFoot_411b8aa6d5954c6020f0b9c9e80e847a
            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.width = BigFoot_aacf928ffa23e474a000b1b6292d02a9
            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.point = BigFoot_7dce5c33f0d4836b30c14f18b2fc43f7
            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.rpoint = BigFoot_7c8715eaf85fa16b3da6112f58ebd62d
            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.x = BigFoot_b254e387cf58e982ba24fcb3e8a63995
            BigFoot_2e00ffac12aadb3a1fd865993ec505b9.y = BigFoot_a0f453fd098c0b0fda780f69cda6ffbf
            table.insert(
                self.virtual_frames[BigFoot_8e2d4ef9193eed09cc6ce5849fad1f0a],
                BigFoot_2e00ffac12aadb3a1fd865993ec505b9
            )
            self:UpdateAnchorFrames()
        end
        BigFoot_9e83872083ad957c8f380801be754171.UnregisterAnchorFrame = function(
            self,
            BigFoot_411b8aa6d5954c6020f0b9c9e80e847a)
            for BigFoot_e914904fab9d05d3f54d52bfc31a0f3f = 1, 9, 1 do
                if (self.virtual_frames[BigFoot_e914904fab9d05d3f54d52bfc31a0f3f]) then
                    for BigFoot_5e57ab95c762a48d9a126b104db1056f, BigFoot_2e00ffac12aadb3a1fd865993ec505b9 in ipairs(
                        self.virtual_frames[BigFoot_e914904fab9d05d3f54d52bfc31a0f3f]
                    ) do
                        if (BigFoot_2e00ffac12aadb3a1fd865993ec505b9.frame == BigFoot_411b8aa6d5954c6020f0b9c9e80e847a) then
                            table.remove(
                                self.virtual_frames[BigFoot_e914904fab9d05d3f54d52bfc31a0f3f],
                                BigFoot_5e57ab95c762a48d9a126b104db1056f
                            )
                            self:UpdateAnchorFrames()
                            return
                        end
                    end
                end
            end
        end
    end
end
function BigFoot_OnInit(self)
    RegisterCVar("BFClient")
    if (GetCVar("BFClient") == "1") then
        BFClient_Running = true
        SetCVar("BFClient", "0")
    else
        BFClient_Running = false
    end
    self:RegisterEvent("PLAYER_LOGIN")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
    self:RegisterEvent("VARIABLES_LOADED")
    if GameMenuButtonHelp then
        GameMenuButtonHelp:SetPoint("TOP", "BigFootMenuButtonOptions", "BOTTOM", 0, -1)
    else
        GameMenuButtonOptions:SetPoint("TOP", "BigFootMenuButtonOptions", "BOTTOM", 0, -1)
    end
    GameMenuFrame:HookScript(
        "OnShow",
        function()
            GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + 25)
        end
    )
    SlashCmdList["BIGFOOT"] = function()
        ShowUIPanel(ModManagementFrame)
    end
    SLASH_BIGFOOT1, SLASH_BIGFOOT2 = "/bigfoot", "/bf"
    BigFoot_fff18c914a5b3a8d509f2dff0f3fc382()
end
local factionTable = {["Alliance"] = 0, ["Horde"] = 1, ["Neutral"] = 2}
local function BiFoot_CheckSaveVersion(BFVersion)
    if not BigFoot_Config.BFVersion or BigFoot_Config.BFVersion < BFVersion then
        BigFoot_Config = {}
        BigFoot_Config.BFVersion = BFVersion
    end
end
local function BigFoot_ClearCollector()
    configCollector = nil
end
local function BigFoot_3642cae1c6eab3d6780c1e5e3fb0cf78()
    if BFNew_GetNewFrameState and BFNew_GetNewFrameState() then
        local m_table = BFNew_GetAddonEnableConfig()
        for k, v in pairs(m_table) do
            if v == 1 then
                EnableAddOn(k)
            elseif v == -1 then
                if bigfoot_DisableTab[k] then
                    EnableAddOn(k)
                end
            end
        end
    else
        if BFNew_GetNewFrameChangeState and BFNew_GetNewFrameChangeState() then
            local revision
            for i = 1, GetNumAddOns() do
                revision = GetAddOnMetadata(i, "X-Revision")
                if revision == "BigFoot" then
                    EnableAddOn(i)
                end
            end
        else
            for k, v in pairs(bigfoot_DisableTab) do
                EnableAddOn(k)
            end
        end
        BigFoot_RegistAll()
        BigFoot_ClearCollector()
    end
    bigfoot_IsEnableDisssabbedAddon = true
    bigfoot_DisableTab = {}
end
local function BigFoot_38050ee3c376a78c7553c2ca1f2b8f70()
    if GetLocale() ~= "zhCN" then
        return
    end
    BigFoot_Character["Region"] = "cn0"
    BigFoot_Character["Realm"] = BFU_GetServerName()
    BigFoot_Character["Name"] = BFU_GetName()
    BigFoot_Character["Gender"] = BFU_GetGender() - 1
    BigFoot_Character["Faction"] = factionTable[BFU_GetFaction()]
    BigFoot_Character["Class"] = BFU_GetClass()
    BigFoot_Character["Race"] = BFU_GetRace()
    BigFoot_Character["Level"] = BFU_GetLvl()
    BigFoot_Character["VCode"] =
        BMath:MD5(BigFoot_Character["Region"] .. BigFoot_Character["Realm"] .. BigFoot_Character["Name"] .. "bf-client")
end
local function BigFoot_7c7fb5c3deb6c5b442fc7437e8ae1dd7()
    BF_LogonInfo = BF_LogonInfo or {}
    if #BF_LogonInfo > 0 then
        if date("%x", BF_LogonInfo[#BF_LogonInfo]) ~= date("%x", time()) then
            table.insert(BF_LogonInfo, time())
        end
    else
        table.insert(BF_LogonInfo, time())
    end
end
local function BigFoot_709b607aba2aaef09caa9948506fcce9()
    local name, reason, bLoadOnDemand
    for i = 1, GetNumAddOns() do
        name, _, _, _, reason = GetAddOnInfo(i)
        bLoadOnDemand = IsAddOnLoadOnDemand(i)
        if reason ~= "DISABLED" and not bLoadOnDemand then
            LoadAddOn(i)
        end
    end
end
local function BigFoot_c2e43d0675bf091ec9935c796897fe65()
    print(ALL_ADDON_LOADED)
    BigFoot_CreatFrame()
end
local function BigFoot_693c84ed6b785fb86d40e671d28c8afa(UsedTab)
    if UsedTab.init and type(UsedTab.init) == "function" then
        pcall(UsedTab.init, UsedTab.value)
    end
end
local function BigFoot_3d5cb72c22f8737d5d716905794979cb(UsedTab)
    if bNewBigfoot then
        BFNew_OnCallBack(UsedTab)
    else
        BigFoot_693c84ed6b785fb86d40e671d28c8afa(UsedTab)
    end
end
local function BigFoot_5cce98c7af8139064e065c4da9901881(BLoadBefore)
    local m_CallTab = CallTab
    local UsedTimw = 0
    local bReSet = false
    local Bdones = false
    local m_LoadAddon = 0
    while (#m_CallTab > 0) do
        local UsedTab = table.remove(m_CallTab, 1)
        if InCombatLockdown() then
            table.insert(LaterTab, UsedTab)
        else
            if BLoadBefore then
                if not Bdones then
                    Bdones = true
                end
                BigFoot_3d5cb72c22f8737d5d716905794979cb(UsedTab)
            else
                local m_Time1 = GetTime()
                if not Bdones then
                    Bdones = true
                end
                BigFoot_3d5cb72c22f8737d5d716905794979cb(UsedTab)
                UsedTimw = GetTime() - m_Time1 + UsedTimw
                m_LoadAddon = m_LoadAddon + 0.4 / 20
                if UsedTimw > 0.2 or m_LoadAddon > 0.2 then
                    BigFoot_DelayCall(BigFoot_5cce98c7af8139064e065c4da9901881, 0.4)
                    bReSet = true
                    break
                end
            end
        end
    end
    if #LaterTab > 0 and not bReSet then
        CallTab = LaterTab
        LaterTab = {}
        BigFoot_DelayCall(BigFoot_5cce98c7af8139064e065c4da9901881, 0.4)
    end
    if #CallTab == 0 and #LaterTab == 0 and Bdones then
        BigFoot_c2e43d0675bf091ec9935c796897fe65()
    end
end
local function BigFoot_4d4c88ef0a5be670351a330d0e7b5696()
    local m_CallTab = {}
    if BFNew_GetNewFrameState and BFNew_GetNewFrameState() then
        m_CallTab = BFNew_ApplyUserAddonConfig()
    else
        m_CallTab = BigFoot_6d1761d16117a98a566f1b4b36cbc7ed()
    end
    return m_CallTab
end
local function BigFoot_a11c665559fd4fce273df28ca6f92415(BLoadBefore)
    if ISVARIABLESLoaded then
        BigFoot_709b607aba2aaef09caa9948506fcce9()
        CallTab = BigFoot_4d4c88ef0a5be670351a330d0e7b5696()
        print(START_LOADADDON_BIAOSHI)
        print(START_LOADADDON)
        print(START_LOADADDON_BIAOSHI)
        if BLoadBefore then
            BigFoot_5cce98c7af8139064e065c4da9901881(BLoadBefore)
        else
            BigFoot_DelayCall(BigFoot_5cce98c7af8139064e065c4da9901881, 4)
        end
    else
        BigFoot_DelayCall(BigFoot_a11c665559fd4fce273df28ca6f92415, 1, BLoadBefore)
    end
end
local Bdone
function BigFoot_OnEvent(self, BigFoot_d0708241b607c9a9dd1953c812fadfb7, ...)
    if (BigFoot_d0708241b607c9a9dd1953c812fadfb7 == "VARIABLES_LOADED") then
        if BigfootConfigVersion then
            BiFoot_CheckSaveVersion(BigfootConfigVersion)
        end
        BigFoot_7c7fb5c3deb6c5b442fc7437e8ae1dd7()
        BigFoot_3642cae1c6eab3d6780c1e5e3fb0cf78()
        ISVARIABLESLoaded = true
    elseif (BigFoot_d0708241b607c9a9dd1953c812fadfb7 == "PLAYER_LOGIN") then
        if (BigFoot_SysTemSetTab.BigFoot_LoadBefore == 1) then
            Bdone = true
            BigFoot_a11c665559fd4fce273df28ca6f92415(1)
        end
    elseif (BigFoot_d0708241b607c9a9dd1953c812fadfb7 == "PLAYER_ENTERING_WORLD") then
        if (not (BigFoot_SysTemSetTab.BigFoot_LoadBefore == 1)) and not Bdone then
            Bdone = true
            BigFoot_a11c665559fd4fce273df28ca6f92415()
        end
        BigFoot_DelayCall(BigFoot_38050ee3c376a78c7553c2ca1f2b8f70, 3)
    end
end
function BigFoot_GetModVariable(__mod, BigFoot_be741bd2030ad8ad70d14fb34b673ab8)
    local BigFoot_051cc0cd78a11469a8f78d2062970ca9 = BigFoot_Config[__mod]
    if (not BigFoot_051cc0cd78a11469a8f78d2062970ca9) then
        BigFoot_22055e427df00b6ded4c974381125d87(__mod)
        BigFoot_051cc0cd78a11469a8f78d2062970ca9 = BigFoot_Config[__mod]
    end
    if (not BigFoot_051cc0cd78a11469a8f78d2062970ca9) then
        return nil
    end
    if (not BigFoot_051cc0cd78a11469a8f78d2062970ca9[BigFoot_be741bd2030ad8ad70d14fb34b673ab8]) then
        if (BigFoot_be741bd2030ad8ad70d14fb34b673ab8) then
            BigFoot_051cc0cd78a11469a8f78d2062970ca9[BigFoot_be741bd2030ad8ad70d14fb34b673ab8] =
                ModManagement_GetDefaultValue(__mod, BigFoot_be741bd2030ad8ad70d14fb34b673ab8)
        end
    end
    return BigFoot_051cc0cd78a11469a8f78d2062970ca9[BigFoot_be741bd2030ad8ad70d14fb34b673ab8]
end
function BigFoot_SetModVariable(
    __mod,
    BigFoot_be741bd2030ad8ad70d14fb34b673ab8,
    BigFoot_2361bab8b48b1041ad740bb561b21aee)
    if (not BigFoot_Config[__mod]) then
        BigFoot_Config[__mod] = {}
    end
    BigFoot_Config[__mod][BigFoot_be741bd2030ad8ad70d14fb34b673ab8] = BigFoot_2361bab8b48b1041ad740bb561b21aee
end
function BigFoot_FindTableValue(BigFoot_49ccc92cd1bef60d860c1c7f84aaab89, BigFoot_2361bab8b48b1041ad740bb561b21aee)
    for BigFoot_413bf9c15ce77baa8ebf1cda4cbf4887, BigFoot_536473f22dedf9f29b94b1004a62b8a0 in pairs(
        BigFoot_49ccc92cd1bef60d860c1c7f84aaab89
    ) do
        if (BigFoot_2361bab8b48b1041ad740bb561b21aee == BigFoot_536473f22dedf9f29b94b1004a62b8a0) then
            return BigFoot_413bf9c15ce77baa8ebf1cda4cbf4887
        end
    end
    return nil
end
function BigFoot_22055e427df00b6ded4c974381125d87(__mod)
    if (__mod) then
        if (not BigFoot_ModOptionConfig or not BigFoot_ModOptionConfig[__mod]) then
            return
        end
        BigFoot_Config[__mod] = {}
        local __index, BigFoot_2361bab8b48b1041ad740bb561b21aee
        for __index, BigFoot_2361bab8b48b1041ad740bb561b21aee in pairs(BigFoot_ModOptionConfig[__mod]) do
            if (BigFoot_2361bab8b48b1041ad740bb561b21aee.variable) then
                BigFoot_Config[__mod][BigFoot_2361bab8b48b1041ad740bb561b21aee.variable] =
                    BigFoot_2361bab8b48b1041ad740bb561b21aee.default
            end
        end
    else
        BigFoot_Config = {}
        local BigFoot_7c2206e66bf7b5bacd2aa77f76bf4ff2, BigFoot_3bb367e1f150a93c099e99df8d49e180
        for BigFoot_7c2206e66bf7b5bacd2aa77f76bf4ff2, BigFoot_3bb367e1f150a93c099e99df8d49e180 in pairs(
            BigFoot_ModOptionConfig
        ) do
            if (not BigFoot_Config[BigFoot_7c2206e66bf7b5bacd2aa77f76bf4ff2]) then
                BigFoot_Config[BigFoot_7c2206e66bf7b5bacd2aa77f76bf4ff2] = {}
            end
            local __index, BigFoot_2361bab8b48b1041ad740bb561b21aee
            for __index, BigFoot_2361bab8b48b1041ad740bb561b21aee in pairs(BigFoot_ModOptionConfig[__mod]) do
                if (BigFoot_2361bab8b48b1041ad740bb561b21aee.variable) then
                    BigFoot_Config[BigFoot_7c2206e66bf7b5bacd2aa77f76bf4ff2][
                            BigFoot_2361bab8b48b1041ad740bb561b21aee.variable
                        ] = BigFoot_2361bab8b48b1041ad740bb561b21aee.default
                end
            end
        end
    end
end
function Save_fault_info(message)
    BigFoot_Config = BigFoot_Config or {}
    BigFoot_Config.ErrorMessage = BigFoot_Config.ErrorMessage or {}
    tinsert(BigFoot_Config.ErrorMessage, message)
end
function BigFoot_6d1761d16117a98a566f1b4b36cbc7ed()
    local __mod, BigFoot_3bb367e1f150a93c099e99df8d49e180
    local BigFoot_e914904fab9d05d3f54d52bfc31a0f3f, BigFoot_2361bab8b48b1041ad740bb561b21aee
    local m_Tab = {}
    local m_CallTab = {}
    for __mod, BigFoot_3bb367e1f150a93c099e99df8d49e180 in pairs(BigFoot_ModOptionConfig) do
        table.insert(m_Tab, BigFoot_3bb367e1f150a93c099e99df8d49e180)
    end
    table.sort(
        m_Tab,
        function(left, right)
            if left and right and left[1] and right[1] and left[1].mod and right[1].mod then
                return left[1].mod < right[1].mod
            end
        end
    )
    for k, v in pairs(m_Tab) do
        if v and type(v) == "table" then
            for BigFoot_e914904fab9d05d3f54d52bfc31a0f3f, BigFoot_2361bab8b48b1041ad740bb561b21aee in ipairs(v) do
                if
                    (BigFoot_2361bab8b48b1041ad740bb561b21aee.init and
                        BigFoot_2361bab8b48b1041ad740bb561b21aee.type ~= "BUTTON")
                 then
                    local tag, message
                    if
                        BigFoot_2361bab8b48b1041ad740bb561b21aee.indent > 0 and
                            BigFoot_2361bab8b48b1041ad740bb561b21aee.parent
                     then
                        table.insert(
                            m_CallTab,
                            {
                                mod = BigFoot_2361bab8b48b1041ad740bb561b21aee.mod,
                                variable = BigFoot_2361bab8b48b1041ad740bb561b21aee.variable,
                                init = BigFoot_2361bab8b48b1041ad740bb561b21aee.init,
                                value = BigFoot_GetModVariable(
                                    BigFoot_2361bab8b48b1041ad740bb561b21aee.mod,
                                    BigFoot_2361bab8b48b1041ad740bb561b21aee.parent
                                ) == 1 and
                                    BigFoot_GetModVariable(
                                        BigFoot_2361bab8b48b1041ad740bb561b21aee.mod,
                                        BigFoot_2361bab8b48b1041ad740bb561b21aee.variable
                                    )
                            }
                        )
                    else
                        table.insert(
                            m_CallTab,
                            {
                                mod = BigFoot_2361bab8b48b1041ad740bb561b21aee.mod,
                                variable = BigFoot_2361bab8b48b1041ad740bb561b21aee.variable,
                                init = BigFoot_2361bab8b48b1041ad740bb561b21aee.init,
                                value = BigFoot_GetModVariable(
                                    BigFoot_2361bab8b48b1041ad740bb561b21aee.mod,
                                    BigFoot_2361bab8b48b1041ad740bb561b21aee.variable
                                )
                            }
                        )
                    end
                end
            end
        end
    end
    return m_CallTab
end
function BigFoot_ShowKeyBindingFrame(BigFoot_7739b813d90aed43ab9d0eb84ec1c1ae)
    KeyBindingFrame_LoadUI()
    if (BigFoot_7739b813d90aed43ab9d0eb84ec1c1ae == nil) then
        ShowUIPanel(KeyBindingFrame)
        return
    end
    for i, v in pairs(KeyBindingFrame.categoryList.buttons) do
        if (v.element and v.element.category and type(v.element.category) == "table") then
            local currCategory = v.element.category
            for eleNo, eleVal in pairs(currCategory) do
                local BigFoot_d28056e4bcd8f214a25daeabfe052d6e = GetBinding(eleVal)
                if (BigFoot_d28056e4bcd8f214a25daeabfe052d6e == BigFoot_7739b813d90aed43ab9d0eb84ec1c1ae) then
                    ShowUIPanel(KeyBindingFrame)
                    v:OnClick("LeftButton")
                    KeyBindingFrameScrollFrameScrollBar:SetValue((eleNo - 1) * KEY_BINDING_HEIGHT)
                end
            end
        end
    end
end
function BigFoot_DisableAllAddons()
    local name, revision, reason, bLoadOnDemand
    for i = 1, GetNumAddOns() do
        name, _, _, _, reason = GetAddOnInfo(i)
        bLoadOnDemand = IsAddOnLoadOnDemand(i)
        revision = GetAddOnMetadata(i, "X-Revision")
        if
            name:lower() ~= "bigfoot" and name:lower() ~= "acp" and name:lower() ~= "bigfootbot" and
                revision == "BigFoot" and
                reason ~= "DISABLED" and
                not string.find(name, "AtlasLootClassic") and
                not string.find(name, "ClassicCodex")
         then
            if bLoadOnDemand then
                bigfoot_DisableTab[name] = true
                DisableAddOn(i)
            end
        end
    end
    bigfoot_IsEnableDisssabbedAddon = false
end
function BigFoot_786b766d1fd0bf879fd94c1f876cd079(self)
    if (BigFoot_44494375213dfd73e10daddf227fe7fd) then
        OpenAllBags()
    end
end
function BigFoot_f044c02de3e35387101ef8bf33fca114(self)
    if (BigFoot_44494375213dfd73e10daddf227fe7fd) then
        CloseAllBags()
    end
end
function BigFoot_a9ccdced48307818b972a7083516c3dd(
    BigFoot_e6955c64cf39bdb23dc86de1a9ec2117,
    BigFoot_0e2babf2e3097eec96cf9280d1412ab5,
    BigFoot_00ae4bc475ffbcf97f789256a2e707de,
    BigFoot_6599f8c6a1b53d0212dfbab04e14e329,
    BigFoot_18bd17b74c56bfd23801044c9c9e8d4e,
    BigFoot_a29776f66159eb25625ce8ff4969048f,
    BigFoot_fe4d4227ea1d91e3a69c7b2a27e8150f,
    BigFoot_ff9ac8c817fb600a8633bbac91acd135,
    BigFoot_d2a75f7d621ef7006d92cec86286568b)
    local BigFoot_71ac8c04e9eae3efc1f0b8abcf51fc4c = BigFoot_GenCheckSum(BigFoot_e6955c64cf39bdb23dc86de1a9ec2117)
    BigFoot_Error[BigFoot_71ac8c04e9eae3efc1f0b8abcf51fc4c] = BigFoot_e6955c64cf39bdb23dc86de1a9ec2117
    BigFoot_7e509fa6eb57f1a7c21df230042b0a81(
        BigFoot_e6955c64cf39bdb23dc86de1a9ec2117,
        BigFoot_0e2babf2e3097eec96cf9280d1412ab5,
        BigFoot_00ae4bc475ffbcf97f789256a2e707de,
        BigFoot_6599f8c6a1b53d0212dfbab04e14e329,
        BigFoot_18bd17b74c56bfd23801044c9c9e8d4e,
        BigFoot_a29776f66159eb25625ce8ff4969048f,
        BigFoot_fe4d4227ea1d91e3a69c7b2a27e8150f,
        BigFoot_ff9ac8c817fb600a8633bbac91acd135,
        BigFoot_d2a75f7d621ef7006d92cec86286568b
    )
end
function BigFoot_GenCheckSum(BigFoot_6e4d0db7491d6883f86de390d20dbe5b)
    if (BigFoot_6e4d0db7491d6883f86de390d20dbe5b == nil) then
        return nil
    end
    local __len = string.len(BigFoot_6e4d0db7491d6883f86de390d20dbe5b)
    local BigFoot_b38a7bb9216803102fdc3d9f7a3d2e84 = 0
    local BigFoot_05a435746a4fa320ec7c59ba02cf6c6a = 0
    for __index = 1, __len, 1 do
        if (mod(__index, 2) == 0) then
            BigFoot_05a435746a4fa320ec7c59ba02cf6c6a =
                BigFoot_05a435746a4fa320ec7c59ba02cf6c6a +
                string.byte(BigFoot_6e4d0db7491d6883f86de390d20dbe5b, __index)
        else
            BigFoot_b38a7bb9216803102fdc3d9f7a3d2e84 =
                BigFoot_b38a7bb9216803102fdc3d9f7a3d2e84 +
                string.byte(BigFoot_6e4d0db7491d6883f86de390d20dbe5b, __index)
        end
    end
    return (BigFoot_b38a7bb9216803102fdc3d9f7a3d2e84 * BigFoot_05a435746a4fa320ec7c59ba02cf6c6a)
end
BigFoot_7e509fa6eb57f1a7c21df230042b0a81 = message
message = BigFoot_a9ccdced48307818b972a7083516c3dd
function BigFoot_f5b6f344e3abaf8220ddb46306cf34fc()
    BigFoot_Print(string.format(BF_VERSION_PATTERN, BIGFOOT_VERSION))
end
function BigFoot_97401a5bc610241b41f9546a71f92484()
    BigFootReader_ShowBook(BF_CHANGELOG_TEXT)
end
local function BigFoot_b5d3fbbb39737107d19770a6601568c8()
    local BigFoot_a44ecbf575d7f2eca081a0592e8d84fa = {}
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa = {}
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa.text = BF_BASIC_INFO
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa.isTitle = 1
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa.notCheckable = 1
    BDropDownMenu_AddButton(BigFoot_a44ecbf575d7f2eca081a0592e8d84fa)
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa = {}
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa.text = BF_VERSION_INFO
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFoot_f5b6f344e3abaf8220ddb46306cf34fc
    BDropDownMenu_AddButton(BigFoot_a44ecbf575d7f2eca081a0592e8d84fa)
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa = {}
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa.text = BF_CHANGELOG_TEXT
    BigFoot_a44ecbf575d7f2eca081a0592e8d84fa.func = BigFoot_97401a5bc610241b41f9546a71f92484
    BDropDownMenu_AddButton(BigFoot_a44ecbf575d7f2eca081a0592e8d84fa)
end
function BigFootMiniButtonDropDown_OnLoad(self)
    BDropDownMenu_Initialize(self, BigFoot_b5d3fbbb39737107d19770a6601568c8, "MENU")
    BDropDownMenu_SetButtonWidth(self, 50)
    BDropDownMenu_SetWidth(self, 50)
end
function IsConfigurableAddOn(BigFoot_8983c60d66c8593ec7165ea9dbedb584)
    if
        (GetAddOnMetadata(BigFoot_8983c60d66c8593ec7165ea9dbedb584, "X-Revision") ~= "BigFoot") or
            not BigFoot_472174287cb12dced3487a304239203f[BigFoot_8983c60d66c8593ec7165ea9dbedb584]
     then
        return false
    end
    local BigFoot_8983c60d66c8593ec7165ea9dbedb584, _, _, _, BigFoot_82a3188377d673bfd578b4a1954a3b2c =
        GetAddOnInfo(BigFoot_472174287cb12dced3487a304239203f[BigFoot_8983c60d66c8593ec7165ea9dbedb584])
    local originEnabled = GetAddOnEnableState(UnitName("player"), BigFoot_8983c60d66c8593ec7165ea9dbedb584) >= 2
    if
        BigFoot_82a3188377d673bfd578b4a1954a3b2c == "DISABLED" or
            BigFoot_82a3188377d673bfd578b4a1954a3b2c == "DEP_DISABLED" or
            not originEnabled
     then
        return false
    end
    return true
end
function BigFoot_IsFramePlacedByUser(BigFoot_411b8aa6d5954c6020f0b9c9e80e847a)
    assert(BigFoot_411b8aa6d5954c6020f0b9c9e80e847a)
    BigFoot_8d0febf2348ea712b2b375ae95601d5f = BigFoot_411b8aa6d5954c6020f0b9c9e80e847a:GetName()
    return BigFoot_411b8aa6d5954c6020f0b9c9e80e847a.BigFoot_22682cb060092ed963ec91a4859bd63b
end
function BigFoot_RequestReloadUI(onCancelled)
    StaticPopupDialogs["RELOADUI_CONFIRM"].OnCancel = onCancelled
    StaticPopup_Show("RELOADUI_CONFIRM")
end
function BigFoot_LoadAddOn(BigFoot_1652701c940a7445a6e43b954d36ec9b)
    if (not BigFoot_IsAddOnLoaded(BigFoot_1652701c940a7445a6e43b954d36ec9b)) then
        LoadAddOn(BigFoot_1652701c940a7445a6e43b954d36ec9b)
        BigFoot_54712cfd3a2c182c0e5e07016c830ccb[BigFoot_1652701c940a7445a6e43b954d36ec9b] = true
    end
    return BigFoot_IsAddOnLoaded(BigFoot_1652701c940a7445a6e43b954d36ec9b)
end
function BigFoot_IsAddOnLoaded(BigFoot_1652701c940a7445a6e43b954d36ec9b)
    return IsAddOnLoaded(BigFoot_1652701c940a7445a6e43b954d36ec9b)
end
function BigFoot_IsAddOnLoadedFromBigFoot(BigFoot_1652701c940a7445a6e43b954d36ec9b)
    if (IsAddOnLoaded(BigFoot_1652701c940a7445a6e43b954d36ec9b)) then
        if (BigFoot_54712cfd3a2c182c0e5e07016c830ccb[BigFoot_1652701c940a7445a6e43b954d36ec9b]) then
            return true
        end
    end
    return false
end
function BigFoot_IsAddOnLoadedFromOther(BigFoot_1652701c940a7445a6e43b954d36ec9b)
    if (IsAddOnLoaded(BigFoot_1652701c940a7445a6e43b954d36ec9b)) then
        if (BigFoot_54712cfd3a2c182c0e5e07016c830ccb[BigFoot_1652701c940a7445a6e43b954d36ec9b]) then
            return false
        end
        return true
    end
    return false
end
function BigFoot_HasAddon(name)
    if (not name or type(name) ~= "string") then
        return false
    end
    if BigFoot_472174287cb12dced3487a304239203f[name] then
        return true
    end
    return false
end --[[解决新旧界面切换问题 ]]
function BigFoot_AddCollector(func)
    table.insert(configCollector, func)
end
function BigFoot_RegistAll()
    for k, v in pairs(configCollector) do
        bOK, reason = pcall(v)
        if not bOK and BigFoot_Error and BigFoot_Error.debug_Mod and G__BIGFOOT_ERRORMESSAGE then
            G__BIGFOOT_ERRORMESSAGE(reason)
        end
    end
end
function BigFoot_GetBattlePetData(petOwner, petIndex)
    local attack = C_PetBattles.GetPower(petOwner, petIndex)
    local speed = C_PetBattles.GetSpeed(petOwner, petIndex)
    local name, speciesName = C_PetBattles.GetName(petOwner, petIndex)
    local health = C_PetBattles.GetHealth(petOwner, petIndex)
    local maxHealth = C_PetBattles.GetMaxHealth(petOwner, petIndex)
    local level = C_PetBattles.GetLevel(petOwner, petIndex)
    local enemyPetType =
        C_PetBattles.GetPetType(
        PetBattleUtil_GetOtherPlayer(petOwner),
        C_PetBattles.GetActivePet(PetBattleUtil_GetOtherPlayer(petOwner))
    )
    local PetType = C_PetBattles.GetPetType(petOwner, petIndex)
    local StyPetType = _G["BATTLE_PET_DAMAGE_NAME_" .. PetType]
    return name, speciesName, level, health, maxHealth, attack, speed, enemyPetType, PetType, StyPetType
end
function GetInterfaceInfo()
    return select(4, GetBuildInfo())
end
function BigFoot_IsClientRunning()
    return BFClient_Running
end
do
    local BigFoot_564cf5717713a1f65b5876c6ee4e8681
    for i = 1, GetNumAddOns() do
        BigFoot_564cf5717713a1f65b5876c6ee4e8681 = GetAddOnInfo(i)
        BigFoot_472174287cb12dced3487a304239203f[BigFoot_564cf5717713a1f65b5876c6ee4e8681] = i
    end
end
function IsModelCanWork()
    return bfModeChangeLoaded
end
function GetEntryDisplayID()
    return BfGetDisplayID("player")
end
function GetOriginEntryDisplayID()
    return BfGetOriginDisplayID("player")
end
function SetEntryDisplayID(BigFoot_814f5240ecbd46cfa7cc9f88bf3a095d, rate)
    BfSetDisplayID("player", BigFoot_814f5240ecbd46cfa7cc9f88bf3a095d, true)
    BfUpdateModel("player")
    if BigFoot_814f5240ecbd46cfa7cc9f88bf3a095d ~= 0 then
        if rate then
            BfSetRate("player", rate)
        else
            BfSetRate("player", 1)
        end
    end
end
function GetChangeMountDisplayID()
    return BfGetMountDisplayID("player")
end
function SetMountDisplayID(BigFoot_bfe2fa6c53e4455d8b1417a2d940cc1f)
    BfSetMountDisplayID("player", BigFoot_bfe2fa6c53e4455d8b1417a2d940cc1f)
end
