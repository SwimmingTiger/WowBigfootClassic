local SellerHelper_7791e0406167410020e5d23e998262f1 = {}
local SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088 = {}
local SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38 = {}
local SellerHelper_Item = {}
local SellerHelper_Label = {}
local SellerHelper_b4d13aa01848e942c4cc4672e8714da5 = 0
local SellerHelper_1ed65bfa533f75763175cd829669c91d = {}
local SellerHelper_b2ad00f99ad778081c12c273cf1a2dde = nil
local SellerHelper_b514a94828e9319cf8f7650f87eeea56 = nil
local SellerHelper_22cf46a9266b3e828ae5e0513a4cff32 = nil
local SellerHelper_c2d8057c3e11600a90261c4d32c84a4a = nil
local SellerHelper_f34319f4a82fcc8de70fa0a07e9714b3 = nil
local SellerHelper_0578af96a024f21f56a20439e6844571 = nil
local SellerHelper_742204bbb584d5b69598347fcb860ef4 = nil
local SellerHelper_915af80fddb3f139926f93ab40534dd1 = nil
local redColor = "|cffe00820"
local greenColor = "|cff20e000"
SELLER_HELPER_FRAME_ITEM_HEIGHT = 37
ITEMS_TO_DISPLAY = 8
SellerHelper_AutoSellList = {}
SellerHelper_AutobuyAddItemButton = {}
if (GetLocale() == "zhCN") then
    MOD_SELLER_HELPER_TITLE = {"售卖助手", "shoumaizhushou"}
    SELLER_HELPER_SHOW_TEXT = "交易助手>>"
    SELLER_HELPER_HIDE_TEXT = "交易助手<<"
    SELLER_HELPER_TITLE = "售卖助手"
    SELLER_HELPER_HELP_TEXT = "点击图标设置自动售卖列表，点击名称手动出售。"
    SELLER_HELPER_SET_HELP_TEXT = "拖动物品到列表添加不售卖列表，点击名称取消"
    SELLER_HELPER_SET_HELP_AUTOSELL_NOTICE = "自动售卖列表不能加斤灰色物品"
    SELLER_HELPER_SET_HELP_NOTSELL_NOTICE = "不售卖列表只能添加灰色物品"
    SELLER_HELPER_ADDNotSellList_TEXT = "请输入物品名字："
    SELLER_HELPER_ALREADYHAVE = "物品[%s]已经再列表中。"
    SELLER_HELPER_ADD = "物品[%s]已经添加到列表中。"
    SELLER_HELPER_DEL = "物品[%s]已经刪除。"
    SellerHelper_36d0ea6328b4880bb1cf1d5b98985e10 = "设为自动出售的物品"
    SellerHelper_0757a2ad28711b534d755f653dd912fe = "将要从自动售卖列表中移除：\n%s"
    SellerHelper_02fab265990c6eeebae0deb5ec386e4c = "将要从不自动售卖列表中移除：\n%s"
    SELLER_HELPER_COLLAPSE_ALL_TEXT = "开启售卖窗口时自动折叠所有类别"
    SELLER_HELPER_DIALOG_INFO1 = "%s\n将添加到自动售卖列表"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[0] = "粗糙物品"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[1] = "普通物品"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[2] = "优秀物品"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[3] = "稀有物品"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[4] = "史诗物品"
    SellerHelper_2f9c9a9a6ffd238bb4db49bd9dfd7eb7 = {
        ["艾格文的银币"] = true,
        ["安东尼达斯的银币"] = true,
        ["范达尔·鹿盔的银币"] = true,
        ["卡德加的银币"] = true,
        ["泰瑞纳斯·米奈希尔国王的银币"] = true,
        ["玛维·影歌的银币"] = true,
        ["穆拉丁·铜须的银币"] = true,
        ["农夫的银币"] = true,
        ["奥蕾莉亚的银币"] = true,
        ["奥术师杜安的银币"] = true,
        ["大工匠梅卡托克的银币"] = true,
        ["安纳斯特里亚·逐日者国王的银币"] = true,
        ["瓦里安·乌瑞恩国王的银币"] = true,
        ["麦迪文的银币"] = true,
        ["麦格尼·铜须王子的银币"] = true,
        ["阿隆索斯·法奥的铜币"] = true,
        ["阿图门的铜币"] = true,
        ["多尔南的亮晶晶的铜币"] = true,
        ["埃林·提亚斯的铜币"] = true,
        ["吉恩的铜币"] = true,
        ["克拉苏斯的铜币"] = true,
        ["兰德鲁·郎绍特的铜币"] = true,
        ["奔波尔霸的铜币"] = true,
        ["列兵马库斯·乔纳森的铜币"] = true,
        ["侍卫洛文的铜币"] = true,
        ["温蕾萨的铜币"] = true,
        ["安斯雷姆的铜币"] = true,
        ["达纳斯·托尔贝恩的铜币"] = true,
        ["伊崔格的铜币"] = true,
        ["弗斯塔德·蛮锤的铜币"] = true,
        ["英尼戈的铜币"] = true,
        ["克里尔的铜币"] = true,
        ["穆罗克的铜币"] = true,
        ["佳莉娅·米奈希尔公主的铜币"] = true,
        ["萨兰蒂亚的亮晶晶的铜币"] = true,
        ["斯塔文的铜币"] = true,
        ["瓦格斯的铜币"] = true
    }
    SellerHelper_736750c1332bc975f3cc046d1be5e554 = {["暗血矿工锄"] = true}
    SellerHelper_dbd5ea9bb789fc00cb59bb4cc2d1f71b = "自动出售了%s，价值为%s。"
    SellerHelper_84d25e649f5a462087e31d6020337cad = "出售物品总价为%s。"
    SellerHelper_36fc9e09faec37492abe1f014cc1f31e = "消费总价为%s。"
    SellerHelper_c5003e8fc4082807480e4235f6dc8eb7 = "本次售卖" .. redColor .. "花费%s。|r"
    SellerHelper_05f062a33b9407c43bde3f73a2745aa4 = "本次售卖" .. greenColor .. "收入%s。|r"
    SellerHelper_5f118e00562b43ca921367fa780a920a = "邮件总获利为%s。"
    SellerHelper_a22d97d711406d42118f1e941a68527e = "邮费支出为%s。"
    SellerHelper_2a42a6c7affee2d3450593e7bff4789c = "本次邮件操作" .. redColor .. "花费%s。|r"
    SellerHelper_5d51b9d73b7db1d6138565db91519e4f = "本次邮件操作" .. greenColor .. "收入%s。|r"
    SellerHelper_5365f09cf64de4e4ef6f85d61a2c7c38 = "金"
    SellerHelper_64c2a722159954204326f6d805f5135b = "银"
    SellerHelper_81cbcfba4fa033a3ccc8e05d05fb75e1 = "铜"
elseif (GetLocale() == "zhTW") then
    MOD_SELLER_HELPER_TITLE = {"售賣助手", "shoumaizhushou"}
    SELLER_HELPER_SHOW_TEXT = "交易助手>>"
    SELLER_HELPER_HIDE_TEXT = "交易助手<<"
    SELLER_HELPER_TITLE = "售賣助手"
    SELLER_HELPER_HELP_TEXT = "點擊圖標設置自動售賣列表，點擊名稱手動出售。"
    SELLER_HELPER_SET_HELP_TEXT = "拖动物品到列表添加不自動售賣列表，點擊名稱取消"
    SELLER_HELPER_SET_HELP_AUTOSELL_NOTICE = "自動售賣列表不能添加灰色物品"
    SELLER_HELPER_SET_HELP_NOTSELL_NOTICE = "不售賣列表只能添加灰色物品"
    SELLER_HELPER_ADDNotSellList_TEXT = "請輸入物品名字："
    SELLER_HELPER_ALREADYHAVE = "物品[%s]已經再列表中。"
    SELLER_HELPER_ADD = "物品[%s]已經添加到列表中。"
    SELLER_HELPER_DEL = "物品[%s]已經刪除。"
    SellerHelper_36d0ea6328b4880bb1cf1d5b98985e10 = "設為自動出售的物品"
    SellerHelper_0757a2ad28711b534d755f653dd912fe = "將要從自動售賣列裱中移除：\n%s"
    SellerHelper_02fab265990c6eeebae0deb5ec386e4c = "將要從不自動售賣列裱中移除：\n%s"
    SELLER_HELPER_COLLAPSE_ALL_TEXT = "開啟出售視窗時自動折疊所有類別"
    SELLER_HELPER_DIALOG_INFO1 = "%s\n將添加到自動售賣列裱"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[0] = "粗糙物品"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[1] = "普通物品"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[2] = "優秀物品"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[3] = "稀有物品"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[4] = "史詩物品"
    SellerHelper_2f9c9a9a6ffd238bb4db49bd9dfd7eb7 = {
        ["步卒的銅幣"] = true,
        ["安斯雷姆的銅幣"] = true,
        ["官達納斯的銅幣"] = true,
        ["伊崔格的銅幣"] = true,
        ["弗斯塔德·蠻錘的銅幣"] = true,
        ["伊尼哥的銅幣"] = true,
        ["克瑞爾的銅幣"] = true,
        ["穆羅克的銅幣"] = true,
        ["卡莉雅·米奈希爾公主的銅幣"] = true,
        ["瑟蘭德雅的閃亮銅幣"] = true,
        ["斯塔文的銅幣"] = true,
        ["瓦戈斯的銅幣"] = true,
        ["阿隆索斯·法奧的銅幣"] = true,
        ["阿圖曼的銅幣"] = true,
        ["朵娜的閃亮銅幣"] = true,
        ["伊林·提亞斯的銅幣"] = true,
        ["吉恩的銅幣"] = true,
        ["卡薩斯的銅幣"] = true,
        ["藍卓·長射的銅幣"] = true,
        ["莫奇的銅幣"] = true,
        ["士兵馬庫斯·喬納森的銅幣"] = true,
        ["侍從洛威的銅幣"] = true,
        ["凡蕾莎的銅幣"] = true,
        ["艾格文的銀幣"] = true,
        ["安東尼達斯的銀幣"] = true,
        ["范達爾·鹿盔的銀幣"] = true,
        ["卡德加的銀幣"] = true,
        ["泰瑞納斯·米奈希爾國王的銀幣"] = true,
        ["瑪翼夫·影歌的銀幣"] = true,
        ["穆拉丁·銅鬚的銀幣"] = true,
        ["農夫的銀幣"] = true,
        ["艾蘭里亞的銀幣"] = true,
        ["秘法師杜安的銀幣"] = true,
        ["大工匠梅卡托克的銀幣"] = true,
        ["安納斯提安·逐日者國王的銀幣"] = true,
        ["瓦里安·烏瑞恩國王的銀幣"] = true,
        ["麥迪文的銀幣"] = true,
        ["麥格尼·銅鬚王子的銀幣"] = true
    }
    SellerHelper_736750c1332bc975f3cc046d1be5e554 = {["暗血礦工鋤"] = true}
    SellerHelper_dbd5ea9bb789fc00cb59bb4cc2d1f71b = "自動出售了%s，價值為%s。"
    SellerHelper_84d25e649f5a462087e31d6020337cad = "出售物品總價為%s。"
    SellerHelper_36fc9e09faec37492abe1f014cc1f31e = "消費總價為%s。"
    SellerHelper_c5003e8fc4082807480e4235f6dc8eb7 = "本次售賣" .. redColor .. "花費%s。|r"
    SellerHelper_05f062a33b9407c43bde3f73a2745aa4 = "本次售賣" .. greenColor .. "收入%s。|r"
    SellerHelper_5f118e00562b43ca921367fa780a920a = "郵件總獲利%s。"
    SellerHelper_a22d97d711406d42118f1e941a68527e = "郵費支出為%s。"
    SellerHelper_2a42a6c7affee2d3450593e7bff4789c = "本次郵件操作" .. redColor .. "花費%s。|r"
    SellerHelper_5d51b9d73b7db1d6138565db91519e4f = "本次郵件操作" .. greenColor .. "收入%s。|r"
    SellerHelper_5365f09cf64de4e4ef6f85d61a2c7c38 = "金"
    SellerHelper_64c2a722159954204326f6d805f5135b = "銀"
    SellerHelper_81cbcfba4fa033a3ccc8e05d05fb75e1 = "銅"
else
    MOD_SELLER_HELPER_TITLE = "Sell Helper"
    SELLER_HELPER_SHOW_TEXT = "trade Helper>>"
    SELLER_HELPER_HIDE_TEXT = "trade Helper<<"
    SELLER_HELPER_TITLE = "Sell Helper"
    SELLER_HELPER_HELP_TEXT = "Click item icon to set the item to auto-sell item."
    SellerHelper_36d0ea6328b4880bb1cf1d5b98985e10 = "Auto Sell"
    SellerHelper_0757a2ad28711b534d755f653dd912fe = "Will be removed from auto-sell list:\n%s"
    SellerHelper_02fab265990c6eeebae0deb5ec386e4c = "Will be removed from Not-auto-sell list:\n%s"
    SELLER_HELPER_COLLAPSE_ALL_TEXT = "Collapse all items when showing"
    SELLER_HELPER_DIALOG_INFO1 = "%s\n Will been set to auto-sell item"
    SELLER_HELPER_ALREADYHAVE = "SELLER_HELPER_ALREADYHAVE[%s]"
    SELLER_HELPER_SET_HELP_AUTOSELL_NOTICE = "SELLER_HELPER_SET_HELP_AUTOSELL_NOTICE"
    SELLER_HELPER_SET_HELP_NOTSELL_NOTICE = "SELLER_HELPER_SET_HELP_NOTSELL_NOTICE"
    SELLER_HELPER_ADD = "SELLER_HELPER_ADD[%s]。"
    SELLER_HELPER_DEL = "SELLER_HELPER_DEL[%s]"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[0] = "Poor"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[1] = "Common"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[2] = "Uncommon"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[3] = "Rare"
    SellerHelper_1ed65bfa533f75763175cd829669c91d[4] = "Epic"
    SellerHelper_2f9c9a9a6ffd238bb4db49bd9dfd7eb7 = {
        ["Alonsus Faol's Copper Coin"] = true,
        ["Landro Longshot's Copper Coin"] = true,
        ["Molok's Copper Coin"] = true,
        ["Murky's Copper Coin"] = true,
        ["Princess Calia Menethil's Copper Coin"] = true,
        ["Private Marcus Jonathan's Copper Coin"] = true,
        ["Salandria's Shiny Copper Coin"] = true,
        ["Squire Rowe's Copper Coin"] = true,
        ["Stalvan's Copper Coin"] = true,
        ["Vareesa's Copper Coin"] = true,
        ["Kryll's Copper Coin"] = true,
        ["Krasus' Copper Coin"] = true,
        ["Ansirem's Copper Coin"] = true,
        ["Attumen's Copper Coin"] = true,
        ["Danath's Copper Coin"] = true,
        ["Dornaa's Shiny Copper Coin"] = true,
        ["Eitrigg's Copper Coin"] = true,
        ["Elling Trias' Copper Coin"] = true,
        ["Falstad Wildhammer's Copper Coin"] = true,
        ["Genn's Copper Coin"] = true,
        ["Inigo's Copper Coin"] = true,
        ["Vargoth's Copper Coin"] = true,
        ["Aegwynn's Silver Coin"] = true,
        ["Prince Magni Bronzebeard's Silver Coin"] = true,
        ["Muradin Bronzebeard's Silver Coin"] = true,
        ["Medivh's Silver Coin"] = true,
        ["Maiev Shadowsong's Silver Coin"] = true,
        ["King Varian Wrynn's Silver Coin"] = true,
        ["King Terenas Menethil's Silver Coin"] = true,
        ["King Anasterian Sunstrider's Silver Coin"] = true,
        ["Khadgar's Silver Coin"] = true,
        ["High Tinker Mekkatorque's Silver Coin"] = true,
        ["Fandral Staghelm's Silver Coin"] = true,
        ["Arcanist Doan's Silver Coin"] = true,
        ["Antonidas' Silver Coin"] = true,
        ["Alleria's Silver Coin"] = true,
        ["A Peasant's Silver Coin"] = true
    }
    SellerHelper_736750c1332bc975f3cc046d1be5e554 = {["Murkblood Miner's Pick"] = true}
    SellerHelper_dbd5ea9bb789fc00cb59bb4cc2d1f71b = "Sell %s for %s."
    SellerHelper_84d25e649f5a462087e31d6020337cad = "Total Sold: %s。"
    SellerHelper_36fc9e09faec37492abe1f014cc1f31e = "Total cost: %s。"
    SellerHelper_c5003e8fc4082807480e4235f6dc8eb7 = "Total " .. redColor .. "Lost: %s。|r"
    SellerHelper_05f062a33b9407c43bde3f73a2745aa4 = "Total " .. greenColor .. "Income: %s。|r"
    SellerHelper_5f118e00562b43ca921367fa780a920a = "Gold From Mail: %s。"
    SellerHelper_a22d97d711406d42118f1e941a68527e = "Expense at Mail: %s。"
    SellerHelper_2a42a6c7affee2d3450593e7bff4789c = "Spent " .. redColor .. "%s on Mail.|r"
    SellerHelper_5d51b9d73b7db1d6138565db91519e4f = "Receive " .. greenColor .. " %s on Mail.|r"
    SellerHelper_5365f09cf64de4e4ef6f85d61a2c7c38 = " Gold"
    SellerHelper_64c2a722159954204326f6d805f5135b = " Silver"
    SellerHelper_81cbcfba4fa033a3ccc8e05d05fb75e1 = " Copper"
end
StaticPopupDialogs["SellerHelper_ADDNotSellList"] = {
    text = SELLER_HELPER_ADDNotSellList_TEXT,
    button1 = ACCEPT,
    button2 = CANCEL,
    hasEditBox = 1,
    maxLetters = 24,
    OnAccept = function(self)
        local text = self.editBox:GetText()
        NotSellerHelper_OnAddItem(text)
    end,
    EditBoxOnEnterPressed = function(self)
        local text = self:GetParent().editBox:GetText()
        NotSellerHelper_OnAddItem(text)
        self:GetParent():Hide()
    end,
    OnShow = function(self)
        self.editBox:SetFocus()
    end,
    OnHide = function(self)
        ChatEdit_FocusActiveWindow()
        self.editBox:SetText("")
    end,
    timeout = 0,
    exclusive = 1,
    whileDead = 1,
    hideOnEscape = 1
}
SellerHelper_NotSellList = {}
function SellerHelper_LoadAutoSet()
    for k, v in pairs(SellerHelper_2f9c9a9a6ffd238bb4db49bd9dfd7eb7) do
        if v then
            table.insert(SellerHelper_NotSellList, k)
        end
    end
    for k, v in pairs(SellerHelper_736750c1332bc975f3cc046d1be5e554) do
        if v then
            table.insert(SellerHelper_NotSellList, k)
        end
    end
end
SellerHelper_LoadAutoSet()
SellerHelper_b2934d26ac4ac33a460ee88438199323 = {
    [0] = {r = 157, g = 157, b = 157},
    [1] = {r = 255, g = 255, b = 255},
    [2] = {r = 30, g = 255, b = 0},
    [3] = {r = 0, g = 112, b = 221},
    [4] = {r = 163, g = 53, b = 238}
}
local SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce = BLibrary("BInfo", "chat", SELLER_HELPER_TITLE)
StaticPopupDialogs["AUTOSELL_ADD_ITEM"] = {
    text = SELLER_HELPER_DIALOG_INFO1,
    button1 = OKAY,
    button2 = CANCEL,
    OnAccept = function()
        if (SellerHelper_b514a94828e9319cf8f7650f87eeea56) then
            SellerHelper_fc344f6b0eb7958de65eab08097aedae()
            local SellerHelper_1f194f793e9150819d886c66d5bc23b5 =
                StaticPopupDialogs["AUTOSELL_ADD_ITEM"].context["name"]
            SellerHelper_e205e429d177472b51a3579e9e1c9684(SellerHelper_1f194f793e9150819d886c66d5bc23b5)
            SellerHelper_d268f454999a803b6b5aaa9eafeb4fe4(SellerHelper_1f194f793e9150819d886c66d5bc23b5)
            SellerHelper_c085327b81635de930c56021ae8b42ab()
            SellerHelper_Update()
        else
            SellerHelper_fc344f6b0eb7958de65eab08097aedae()
            SellerHelper_Update()
        end
    end,
    showAlert = 1,
    timeout = 0,
    hideOnEscape = 1
}
StaticPopupDialogs["AUTOSELL_REMOVE_ITEM"] = {
    text = SellerHelper_0757a2ad28711b534d755f653dd912fe,
    button1 = OKAY,
    button2 = CANCEL,
    OnAccept = function()
        SellerHelper_9d9b7a69f49f6a037c9785362ca46a17()
    end,
    showAlert = 1,
    timeout = 0,
    hideOnEscape = 1
}
StaticPopupDialogs["AUTONOTSELL_REMOVE_ITEM"] = {
    text = SellerHelper_02fab265990c6eeebae0deb5ec386e4c,
    button1 = OKAY,
    button2 = CANCEL,
    OnAccept = function(Name, aa)
        SellerHelper_6221906a1d0d40a4c770f8cabc09a1b0(Name, aa)
    end,
    showAlert = 1,
    timeout = 0,
    hideOnEscape = 1
}
function SellerHelper_50cf45b94a10b7bdc8ae915538dd90d6(
    SellerHelper_45d3d4ac2d1ffdc6f36613ad11674205,
    SellerHelper_9d6e906d7d9e06fa730d3e838967cda1)
    SellerHelper_0578af96a024f21f56a20439e6844571 = 0
    SellerHelperTooltip:SetBagItem(
        SellerHelper_45d3d4ac2d1ffdc6f36613ad11674205,
        SellerHelper_9d6e906d7d9e06fa730d3e838967cda1
    )
    return SellerHelper_0578af96a024f21f56a20439e6844571
end
function SellerHelper_b19b27a0d162fb09455d3db0009cdd1e(
    SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50,
    SellerHelper_1f194f793e9150819d886c66d5bc23b5)
    for SellerHelper_71bbf5556026689cd8be9c620976a063, SellerHelper_6c5560108ad7aaf47e811081394a00b4 in pairs(
        SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50
    ) do
        SellerHelper_6c5560108ad7aaf47e811081394a00b4[SellerHelper_1f194f793e9150819d886c66d5bc23b5] = nil
    end
end
function SellerHelper_67eacaeaebcaf5c5fbbfed0aaa269c0e(
    SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50,
    SellerHelper_1f194f793e9150819d886c66d5bc23b5,
    SellerHelper_9248008bbb6d0ee7ce13f6ee45680051,
    SellerHelper_e92be00eafc11562d2cc29c723b2b467,
    SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f,
    SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395,
    SellerHelper_15ad1e501e228eb80be1cc7800ab967d)
    if (not SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f]) then
        SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f] = {}
    end
    if
        (not SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f][
            SellerHelper_1f194f793e9150819d886c66d5bc23b5
        ])
     then
        SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f][
                SellerHelper_1f194f793e9150819d886c66d5bc23b5
            ] = {}
        SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f][
                SellerHelper_1f194f793e9150819d886c66d5bc23b5
            ]["count"] = 0
    end
    SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f][
            SellerHelper_1f194f793e9150819d886c66d5bc23b5
        ]["icon"] = SellerHelper_9248008bbb6d0ee7ce13f6ee45680051
    SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f][
            SellerHelper_1f194f793e9150819d886c66d5bc23b5
        ]["count"] =
        SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f][
        SellerHelper_1f194f793e9150819d886c66d5bc23b5
    ]["count"] + SellerHelper_e92be00eafc11562d2cc29c723b2b467
    SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f][
            SellerHelper_1f194f793e9150819d886c66d5bc23b5
        ]["price"] = SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395
    SellerHelper_7bc8579c0219e9fbb9e69f6c640b0b50[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f][
            SellerHelper_1f194f793e9150819d886c66d5bc23b5
        ]["link"] = SellerHelper_15ad1e501e228eb80be1cc7800ab967d
end
function SellerHelper_c085327b81635de930c56021ae8b42ab()
    local __index
    SellerHelper_7791e0406167410020e5d23e998262f1 = {}
    for __index = SellerHelper_b4d13aa01848e942c4cc4672e8714da5, table.getn(
        SellerHelper_1ed65bfa533f75763175cd829669c91d
    ) do
        if (SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088[__index]) then
            table.sort(SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088[__index])
            local SellerHelper_2e00ffac12aadb3a1fd865993ec505b9 = {}
            SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["name"] =
                SellerHelper_1ed65bfa533f75763175cd829669c91d[__index]
            SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["header"] = 1
            SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["color"] =
                SellerHelper_b2934d26ac4ac33a460ee88438199323[__index]
            if
                (not SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38[
                    SellerHelper_1ed65bfa533f75763175cd829669c91d[__index]
                ])
             then
                SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["expanded"] = 1
            end
            table.insert(SellerHelper_7791e0406167410020e5d23e998262f1, SellerHelper_2e00ffac12aadb3a1fd865993ec505b9)
            if
                (not SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38[
                    SellerHelper_1ed65bfa533f75763175cd829669c91d[__index]
                ])
             then
                for SellerHelper_1f194f793e9150819d886c66d5bc23b5, SellerHelper_2361bab8b48b1041ad740bb561b21aee in pairs(
                    SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088[__index]
                ) do
                    SellerHelper_2e00ffac12aadb3a1fd865993ec505b9 = {}
                    SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["name"] =
                        SellerHelper_1f194f793e9150819d886c66d5bc23b5
                    SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["icon"] =
                        SellerHelper_2361bab8b48b1041ad740bb561b21aee["icon"]
                    SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["count"] =
                        SellerHelper_2361bab8b48b1041ad740bb561b21aee["count"]
                    SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["price"] =
                        SellerHelper_2361bab8b48b1041ad740bb561b21aee["price"]
                    SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["quality"] = __index
                    SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["link"] =
                        SellerHelper_2361bab8b48b1041ad740bb561b21aee["link"]
                    table.insert(
                        SellerHelper_7791e0406167410020e5d23e998262f1,
                        SellerHelper_2e00ffac12aadb3a1fd865993ec505b9
                    )
                end
            end
        end
    end
    local SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 = 0
    for __index in pairs(SellerHelper_AutoSellList) do
        SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 = SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 + 1
    end
    if (SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 > 0) then
        local SellerHelper_2e00ffac12aadb3a1fd865993ec505b9 = {}
        SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["name"] = SellerHelper_36d0ea6328b4880bb1cf1d5b98985e10
        SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["header"] = 1
        SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["color"] = {r = 255, g = 255, b = 0}
        if (not SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38[SellerHelper_36d0ea6328b4880bb1cf1d5b98985e10]) then
            SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["expanded"] = 1
        end
        table.insert(SellerHelper_7791e0406167410020e5d23e998262f1, SellerHelper_2e00ffac12aadb3a1fd865993ec505b9)
        if (not SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38[SellerHelper_36d0ea6328b4880bb1cf1d5b98985e10]) then
            for SellerHelper_1f194f793e9150819d886c66d5bc23b5, SellerHelper_2361bab8b48b1041ad740bb561b21aee in pairs(
                SellerHelper_AutoSellList
            ) do
                SellerHelper_2e00ffac12aadb3a1fd865993ec505b9 = {}
                SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["name"] = SellerHelper_1f194f793e9150819d886c66d5bc23b5
                SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["icon"] =
                    SellerHelper_2361bab8b48b1041ad740bb561b21aee["icon"]
                SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["count"] =
                    SellerHelper_2361bab8b48b1041ad740bb561b21aee["count"]
                SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["price"] =
                    SellerHelper_2361bab8b48b1041ad740bb561b21aee["price"]
                SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["quality"] =
                    SellerHelper_2361bab8b48b1041ad740bb561b21aee["quality"]
                SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["link"] =
                    SellerHelper_2361bab8b48b1041ad740bb561b21aee["link"]
                table.insert(
                    SellerHelper_7791e0406167410020e5d23e998262f1,
                    SellerHelper_2e00ffac12aadb3a1fd865993ec505b9
                )
            end
        end
    end
end
function SellerHelper_CollapseHeader(SellerHelper_d7284badcef25da2d384806a56a36197)
    if (SellerHelper_d7284badcef25da2d384806a56a36197 == 0) then
        local __index
        for __index in pairs(SellerHelper_7791e0406167410020e5d23e998262f1) do
            if (SellerHelper_7791e0406167410020e5d23e998262f1[__index]["header"]) then
                local SellerHelper_1f194f793e9150819d886c66d5bc23b5 =
                    SellerHelper_79565399380689e9328a491897ebbe1a(__index)
                SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38[SellerHelper_1f194f793e9150819d886c66d5bc23b5] = 1
            end
        end
    else
        local SellerHelper_1f194f793e9150819d886c66d5bc23b5, SellerHelper_bd58786d94a7654001104ccaba82bfed =
            SellerHelper_79565399380689e9328a491897ebbe1a(SellerHelper_d7284badcef25da2d384806a56a36197)
        if (SellerHelper_bd58786d94a7654001104ccaba82bfed) then
            SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38[SellerHelper_1f194f793e9150819d886c66d5bc23b5] = 1
        end
    end
    SellerHelper_c085327b81635de930c56021ae8b42ab()
end
function SellerHelper_ExpandHeader(SellerHelper_d7284badcef25da2d384806a56a36197)
    if (SellerHelper_d7284badcef25da2d384806a56a36197 == 0) then
        SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38 = {}
    else
        local SellerHelper_1f194f793e9150819d886c66d5bc23b5, SellerHelper_bd58786d94a7654001104ccaba82bfed =
            SellerHelper_79565399380689e9328a491897ebbe1a(SellerHelper_d7284badcef25da2d384806a56a36197)
        if (SellerHelper_bd58786d94a7654001104ccaba82bfed) then
            SellerHelper_ac64ce3b65b6736e55d5eebb1bbc5e38[SellerHelper_1f194f793e9150819d886c66d5bc23b5] = nil
        end
    end
    SellerHelper_c085327b81635de930c56021ae8b42ab()
end
function SellerHelper_dc9491265f0380fade93d88e9491df4d(
    SellerHelper_1f194f793e9150819d886c66d5bc23b5,
    SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f)
    if (SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f == 0 and SellerHelper_b2ad00f99ad778081c12c273cf1a2dde) then
        for k, v in pairs(SellerHelper_NotSellList) do
            if SellerHelper_1f194f793e9150819d886c66d5bc23b5 == v then
                return false
            end
        end
        return true
    elseif (SellerHelper_AutoSellList[SellerHelper_1f194f793e9150819d886c66d5bc23b5]) then
        return true
    end
    return false
end
function SellerHelper_ffc6f36e205c615c838d2b0370235e96(
    SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
    SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d,
    SellerHelper_e54ec4f67fb7705c3bc9a361838b5d01)
    local SellerHelper_15ad1e501e228eb80be1cc7800ab967d =
        GetContainerItemLink(
        SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
        SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d
    )
    if (SellerHelper_15ad1e501e228eb80be1cc7800ab967d) then
        local SellerHelper_1f194f793e9150819d886c66d5bc23b5,
            SellerHelper_15ad1e501e228eb80be1cc7800ab967d,
            SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f,
            SellerHelper_5b2b9385dc5869461473771f275680cd,
            SellerHelper_0db5ab7591386d733b59a51d951e85d0,
            SellerHelper_93d846d0f1d4a30fd23de1c033b0a0ab,
            SellerHelper_101530567acd38edafbca0b9a62d647b,
            SellerHelper_96740f5a57dad2b0bc9410bc76c32e26,
            SellerHelper_f5cb07751fccdf339be4192634943a73,
            SellerHelper_9248008bbb6d0ee7ce13f6ee45680051 =
            GetItemInfo(
            GetContainerItemLink(
                SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d
            )
        )
        if (SellerHelper_e54ec4f67fb7705c3bc9a361838b5d01) then
            return SellerHelper_1f194f793e9150819d886c66d5bc23b5
        else
            local _, SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 =
                GetContainerItemInfo(
                SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d
            )
            local SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 =
                SellerHelper_50cf45b94a10b7bdc8ae915538dd90d6(
                SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d
            )
            return SellerHelper_1f194f793e9150819d886c66d5bc23b5, SellerHelper_9248008bbb6d0ee7ce13f6ee45680051, SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395, SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f, SellerHelper_3f50417fb16be9b1078eb68d24fa9c26, SellerHelper_15ad1e501e228eb80be1cc7800ab967d
        end
    end
end
local function SellerHelper_39fe79b7a363e068ea5f1634f9bd086f(SellerHelper_26680bc9dbe567f417efe78d31655797)
    SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088 = {}
    SellerHelper_7791e0406167410020e5d23e998262f1 = {}
    local SellerHelper_53deb98915b6ed554816b3579eb8b299 = {}
    local SellerHelper_1f194f793e9150819d886c66d5bc23b5,
        SellerHelper_9248008bbb6d0ee7ce13f6ee45680051,
        SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395,
        SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f,
        SellerHelper_3f50417fb16be9b1078eb68d24fa9c26,
        SellerHelper_15ad1e501e228eb80be1cc7800ab967d
    for SellerHelper_96ec47e10d09a5d0491fe767488c7fab = 0, NUM_BAG_FRAMES, 1 do
        local SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed =
            GetContainerNumSlots(SellerHelper_96ec47e10d09a5d0491fe767488c7fab)
        if (SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed and SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed > 0) then
            for SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d = SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed, 1, -1 do
                SellerHelper_1f194f793e9150819d886c66d5bc23b5,
                    SellerHelper_9248008bbb6d0ee7ce13f6ee45680051,
                    SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395,
                    SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f,
                    SellerHelper_3f50417fb16be9b1078eb68d24fa9c26,
                    SellerHelper_15ad1e501e228eb80be1cc7800ab967d =
                    SellerHelper_ffc6f36e205c615c838d2b0370235e96(
                    SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                    SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d,
                    false
                )
                if (SellerHelper_1f194f793e9150819d886c66d5bc23b5) then
                    if (SellerHelper_26680bc9dbe567f417efe78d31655797) then
                        if
                            (SellerHelper_dc9491265f0380fade93d88e9491df4d(
                                SellerHelper_1f194f793e9150819d886c66d5bc23b5,
                                SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f
                            ) and SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 > 0)
                         then
                            if MerchantFrame:IsVisible() then
                                UseContainerItem(
                                    SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                                    SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d
                                )
                                SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce:Print(
                                    string.format(
                                        SellerHelper_dbd5ea9bb789fc00cb59bb4cc2d1f71b,
                                        SellerHelper_15ad1e501e228eb80be1cc7800ab967d,
                                        SellerHelper_20b9ea8773553d7b7fc3d0570f339246(
                                            SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395
                                        )
                                    )
                                )
                            end
                        else
                            if
                                (SellerHelper_1f194f793e9150819d886c66d5bc23b5 and
                                    SellerHelper_9248008bbb6d0ee7ce13f6ee45680051 and
                                    SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 and
                                    SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 and
                                    SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 > 0)
                             then
                                SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 =
                                    SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 /
                                    SellerHelper_3f50417fb16be9b1078eb68d24fa9c26
                                SellerHelper_67eacaeaebcaf5c5fbbfed0aaa269c0e(
                                    SellerHelper_53deb98915b6ed554816b3579eb8b299,
                                    SellerHelper_1f194f793e9150819d886c66d5bc23b5,
                                    SellerHelper_9248008bbb6d0ee7ce13f6ee45680051,
                                    SellerHelper_3f50417fb16be9b1078eb68d24fa9c26,
                                    SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f,
                                    SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395,
                                    SellerHelper_15ad1e501e228eb80be1cc7800ab967d
                                )
                            end
                        end
                    else
                        if
                            (SellerHelper_1f194f793e9150819d886c66d5bc23b5 and
                                SellerHelper_9248008bbb6d0ee7ce13f6ee45680051 and
                                SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 and
                                SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 and
                                SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 > 0)
                         then
                            SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 =
                                SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 /
                                SellerHelper_3f50417fb16be9b1078eb68d24fa9c26
                            SellerHelper_67eacaeaebcaf5c5fbbfed0aaa269c0e(
                                SellerHelper_53deb98915b6ed554816b3579eb8b299,
                                SellerHelper_1f194f793e9150819d886c66d5bc23b5,
                                SellerHelper_9248008bbb6d0ee7ce13f6ee45680051,
                                SellerHelper_3f50417fb16be9b1078eb68d24fa9c26,
                                SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f,
                                SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395,
                                SellerHelper_15ad1e501e228eb80be1cc7800ab967d
                            )
                        end
                    end
                end
            end
        end
    end
    SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088 = SellerHelper_53deb98915b6ed554816b3579eb8b299
    SellerHelper_c085327b81635de930c56021ae8b42ab()
end
function SellerHelper_ee69a130e7dd49ae2c9aff17ae0adb79()
    local __index
    local SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 = 0
    for __index, SellerHelper_2361bab8b48b1041ad740bb561b21aee in pairs(SellerHelper_7791e0406167410020e5d23e998262f1) do
        SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 = SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 + 1
    end
    return SellerHelper_3f50417fb16be9b1078eb68d24fa9c26
end
function SellerHelper_79565399380689e9328a491897ebbe1a(__index)
    if (not SellerHelper_7791e0406167410020e5d23e998262f1[__index]) then
        return
    end
    local SellerHelper_1f194f793e9150819d886c66d5bc23b5
    local SellerHelper_bd58786d94a7654001104ccaba82bfed
    local SellerHelper_07f389c707dd8c0179da4f0fd4e323e6
    local SellerHelper_51bbc6646cac6748cc62569220600b52
    local SellerHelper_3f50417fb16be9b1078eb68d24fa9c26
    local SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395
    local SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f
    SellerHelper_1f194f793e9150819d886c66d5bc23b5 = SellerHelper_7791e0406167410020e5d23e998262f1[__index]["name"]
    SellerHelper_bd58786d94a7654001104ccaba82bfed = SellerHelper_7791e0406167410020e5d23e998262f1[__index]["header"]
    SellerHelper_9325045d34c8f750ba82fafceb0f981e = SellerHelper_7791e0406167410020e5d23e998262f1[__index]["expanded"]
    SellerHelper_51bbc6646cac6748cc62569220600b52 = SellerHelper_7791e0406167410020e5d23e998262f1[__index]["icon"]
    SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 = SellerHelper_7791e0406167410020e5d23e998262f1[__index]["count"]
    SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 = SellerHelper_7791e0406167410020e5d23e998262f1[__index]["price"]
    if (SellerHelper_bd58786d94a7654001104ccaba82bfed) then
        SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f = SellerHelper_7791e0406167410020e5d23e998262f1[__index]["color"]
    else
        SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f =
            SellerHelper_7791e0406167410020e5d23e998262f1[__index]["quality"]
    end
    return SellerHelper_1f194f793e9150819d886c66d5bc23b5, SellerHelper_bd58786d94a7654001104ccaba82bfed, SellerHelper_9325045d34c8f750ba82fafceb0f981e, SellerHelper_51bbc6646cac6748cc62569220600b52, SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f, SellerHelper_3f50417fb16be9b1078eb68d24fa9c26, SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395
end
function SellerHelper_Update()
    local SellerHelper_b7f0e0107e2c8b96e78550265859f2e5 = SellerHelper_ee69a130e7dd49ae2c9aff17ae0adb79()
    local SellerHelper_98b436aae97b9941de81152428c81208 = FauxScrollFrame_GetOffset(SellerHelperFrameScrollFrame) + 1
    local __index = 1
    for SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f = SellerHelper_98b436aae97b9941de81152428c81208, SellerHelper_98b436aae97b9941de81152428c81208 +
        ITEMS_TO_DISPLAY -
        1 do
        if (SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f <= SellerHelper_b7f0e0107e2c8b96e78550265859f2e5) then
            SellerHelper_4984ccfd34962510bfb20a43b7d3dc05(__index, SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f)
        else
            break
        end
        __index = __index + 1
    end
    SellerHelperFrameExpandFrame.isExpanded = 1
    SellerHelperFrameExpandFrame:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
    for SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f = 1, SellerHelper_b7f0e0107e2c8b96e78550265859f2e5 do
        local SellerHelper_8e472a6cc9210c695fafcc64d6c32787,
            SellerHelper_bd58786d94a7654001104ccaba82bfed,
            SellerHelper_fb589c8c57c15b2b8a06e4e9dd82804a =
            SellerHelper_79565399380689e9328a491897ebbe1a(SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f)
        if (SellerHelper_bd58786d94a7654001104ccaba82bfed) then
            if (not SellerHelper_fb589c8c57c15b2b8a06e4e9dd82804a) then
                SellerHelperFrameExpandFrame.isExpanded = nil
                SellerHelperFrameExpandFrame:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
                break
            end
        end
    end
    for SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f = __index, ITEMS_TO_DISPLAY do
        getglobal("SellerHelperItem" .. SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f):Hide()
        getglobal("SellerHelperLabel" .. SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f):Hide()
    end
    FauxScrollFrame_Update(
        SellerHelperFrameScrollFrame,
        SellerHelper_b7f0e0107e2c8b96e78550265859f2e5,
        ITEMS_TO_DISPLAY,
        SELLER_HELPER_FRAME_ITEM_HEIGHT
    )
end
function SellerHelper_4984ccfd34962510bfb20a43b7d3dc05(
    SellerHelper_4ebb33fe1a91777ac0e40216c245fdc6,
    SellerHelper_d7284badcef25da2d384806a56a36197)
    local SellerHelper_1f194f793e9150819d886c66d5bc23b5,
        SellerHelper_bd58786d94a7654001104ccaba82bfed,
        SellerHelper_fb589c8c57c15b2b8a06e4e9dd82804a,
        SellerHelper_51bbc6646cac6748cc62569220600b52,
        SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f,
        SellerHelper_3f50417fb16be9b1078eb68d24fa9c26,
        SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 =
        SellerHelper_79565399380689e9328a491897ebbe1a(SellerHelper_d7284badcef25da2d384806a56a36197)
    local SellerHelper_c849af697908d71da9fcd029e49e1761 =
        getglobal("SellerHelperItem" .. SellerHelper_4ebb33fe1a91777ac0e40216c245fdc6)
    local SellerHelper_0758ea0b1555cf4b39b738c5fcd15be8 =
        getglobal(SellerHelper_c849af697908d71da9fcd029e49e1761:GetName() .. "ItemIconTexture")
    local SellerHelper_1d87702d483140724d7dadab6e0b0e4c =
        getglobal(SellerHelper_c849af697908d71da9fcd029e49e1761:GetName() .. "Name")
    local SellerHelper_e92be00eafc11562d2cc29c723b2b467 =
        getglobal(SellerHelper_c849af697908d71da9fcd029e49e1761:GetName() .. "ItemCount")
    local SellerHelper_5bb26e4710b1d0df6da03a441a4a35f6 =
        getglobal(SellerHelper_c849af697908d71da9fcd029e49e1761:GetName() .. "Money")
    local SellerHelper_c87a80f2abe53e8b17226fedfd2c599e =
        getglobal("SellerHelperLabel" .. SellerHelper_4ebb33fe1a91777ac0e40216c245fdc6)
    if (SellerHelper_1f194f793e9150819d886c66d5bc23b5 == "") then
        SellerHelper_c849af697908d71da9fcd029e49e1761:Hide()
        SellerHelper_c87a80f2abe53e8b17226fedfd2c599e:Hide()
    end
    if (SellerHelper_bd58786d94a7654001104ccaba82bfed) then
        SellerHelper_c87a80f2abe53e8b17226fedfd2c599e:Show()
        SellerHelper_c87a80f2abe53e8b17226fedfd2c599e:SetText(
            SellerHelper_1f194f793e9150819d886c66d5bc23b5,
            SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f.r / 255,
            SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f.g / 255,
            SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f.b / 255
        )
        SellerHelper_c87a80f2abe53e8b17226fedfd2c599e.itemIndex = SellerHelper_d7284badcef25da2d384806a56a36197
        SellerHelper_c849af697908d71da9fcd029e49e1761:Hide()
        local SellerHelper_1f07aaf496fd15582e110c4b2364dc62 =
            getglobal("SellerHelperLabel" .. SellerHelper_4ebb33fe1a91777ac0e40216c245fdc6 .. "NormalTexture")
        if (SellerHelper_fb589c8c57c15b2b8a06e4e9dd82804a) then
            SellerHelper_c87a80f2abe53e8b17226fedfd2c599e:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-Up")
            SellerHelper_c87a80f2abe53e8b17226fedfd2c599e.isExpanded = 1
        else
            SellerHelper_c87a80f2abe53e8b17226fedfd2c599e:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-Up")
            SellerHelper_c87a80f2abe53e8b17226fedfd2c599e.isExpanded = nil
        end
        return
    else
        SellerHelper_c87a80f2abe53e8b17226fedfd2c599e:Hide()
        SellerHelper_c849af697908d71da9fcd029e49e1761:Show()
    end
    SellerHelper_c849af697908d71da9fcd029e49e1761.itemIndex = SellerHelper_d7284badcef25da2d384806a56a36197
    SellerHelper_0758ea0b1555cf4b39b738c5fcd15be8:SetTexture(SellerHelper_51bbc6646cac6748cc62569220600b52)
    SellerHelper_1d87702d483140724d7dadab6e0b0e4c:SetText(SellerHelper_1f194f793e9150819d886c66d5bc23b5)
    SellerHelper_1d87702d483140724d7dadab6e0b0e4c:SetTextColor(
        SellerHelper_b2934d26ac4ac33a460ee88438199323[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f].r / 255,
        SellerHelper_b2934d26ac4ac33a460ee88438199323[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f].g / 255,
        SellerHelper_b2934d26ac4ac33a460ee88438199323[SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f].b / 255
    )
    if (SellerHelper_3f50417fb16be9b1078eb68d24fa9c26 > 1) then
        SellerHelper_e92be00eafc11562d2cc29c723b2b467:SetText(SellerHelper_3f50417fb16be9b1078eb68d24fa9c26)
    else
        SellerHelper_e92be00eafc11562d2cc29c723b2b467:SetText("")
    end
    MoneyFrame_Update(
        SellerHelper_5bb26e4710b1d0df6da03a441a4a35f6:GetName(),
        SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 * SellerHelper_3f50417fb16be9b1078eb68d24fa9c26
    )
end
function SellerItemButton_OnClick(self)
    local SellerHelper_d7284badcef25da2d384806a56a36197 = self.itemIndex
    local SellerHelper_1f194f793e9150819d886c66d5bc23b5 =
        SellerHelper_79565399380689e9328a491897ebbe1a(SellerHelper_d7284badcef25da2d384806a56a36197) or
        StaticPopupDialogs["AUTOSELL_ADD_ITEM"].context["name"]
    SellerHelper_e205e429d177472b51a3579e9e1c9684(SellerHelper_1f194f793e9150819d886c66d5bc23b5)
    SellerHelper_d268f454999a803b6b5aaa9eafeb4fe4(SellerHelper_1f194f793e9150819d886c66d5bc23b5)
    SellerHelper_c085327b81635de930c56021ae8b42ab()
    SellerHelper_Update()
end
function SellerHelper_e205e429d177472b51a3579e9e1c9684(SellerHelper_a7e918ced59f8351b3a92133d2c7768e)
    local SellerHelper_1f194f793e9150819d886c66d5bc23b5
    for SellerHelper_96ec47e10d09a5d0491fe767488c7fab = 0, NUM_BAG_FRAMES, 1 do
        local SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed =
            GetContainerNumSlots(SellerHelper_96ec47e10d09a5d0491fe767488c7fab)
        if (SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed and SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed > 0) then
            for SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d = SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed, 1, -1 do
                SellerHelper_1f194f793e9150819d886c66d5bc23b5 =
                    SellerHelper_ffc6f36e205c615c838d2b0370235e96(
                    SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                    SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d,
                    true
                )
                if (SellerHelper_1f194f793e9150819d886c66d5bc23b5 == SellerHelper_a7e918ced59f8351b3a92133d2c7768e) then
                    UseContainerItem(
                        SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                        SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d
                    )
                end
            end
        end
    end
end
function SellerHelper_d268f454999a803b6b5aaa9eafeb4fe4(SellerHelper_1f194f793e9150819d886c66d5bc23b5)
    local __index
    for __index = SellerHelper_b4d13aa01848e942c4cc4672e8714da5, table.getn(
        SellerHelper_1ed65bfa533f75763175cd829669c91d
    ) do
        if (SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088[__index]) then
            if (SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088[__index][SellerHelper_1f194f793e9150819d886c66d5bc23b5]) then
                SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088[__index][SellerHelper_1f194f793e9150819d886c66d5bc23b5] =
                    nil
                for SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f, SellerHelper_8d0644c92128c1ff68223fd74ba63b56 in pairs(
                    SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088[__index]
                ) do
                    return
                end
                SellerHelper_31e5a0db12dd55bae58bbaa9d0eec088[__index] = nil
            end
        end
    end
end
local SellerHelper_Eventer = BLibrary("BEvent")
function SellHelper_EnableToggle(SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
        SellerHelper_Eventer:RegisterEvent("MERCHANT_SHOW", SellerHelperFrame_OnEvent)
        SellerHelper_Eventer:RegisterEvent("MAIL_SHOW", SellerHelperFrame_OnEvent)
        SellerHelper_Eventer:RegisterEvent("MAIL_CLOSED", SellerHelperFrame_OnEvent)
        SellerHelper_Eventer:RegisterEvent("MERCHANT_CLOSED", SellerHelperFrame_OnEvent)
        SellerHelper_Eventer:RegisterEvent("PLAYER_MONEY", SellerHelperFrame_OnEvent)
        SellerHelper_Eventer:RegisterEvent("BAG_UPDATE", SellerHelperFrame_OnEvent)
        SellerHelperTooltip:SetScript("OnTooltipAddMoney", SellerHelper_c5a2cde61a2517c7a30909912cb1e510)
    else
        SellerHelper_Eventer:UnregisterAllEvent()
    end
end
function SellHelper_SellGrayToggle(SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
        SellerHelper_b2ad00f99ad778081c12c273cf1a2dde = 1
    else
        SellerHelper_b2ad00f99ad778081c12c273cf1a2dde = nil
    end
end
function SellHelper_SellAcceptToggle(SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
        SellerHelper_b514a94828e9319cf8f7650f87eeea56 = 1
    else
        SellerHelper_b514a94828e9319cf8f7650f87eeea56 = nil
    end
end
function SellHelper_SellAnnounceToggle(SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
        SellerHelper_915af80fddb3f139926f93ab40534dd1 = 1
    else
        SellerHelper_915af80fddb3f139926f93ab40534dd1 = nil
    end
end
function SellHelper_KeepDalarancoin(SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
        SellerHelper_c2d8057c3e11600a90261c4d32c84a4a = 1
    else
        SellerHelper_c2d8057c3e11600a90261c4d32c84a4a = nil
    end
end
function SellHelper_KeepMiningToggle(SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae)
    if (SellerHelper_7739b813d90aed43ab9d0eb84ec1c1ae == 1) then
        SellerHelper_f34319f4a82fcc8de70fa0a07e9714b3 = 1
    else
        SellerHelper_f34319f4a82fcc8de70fa0a07e9714b3 = nil
    end
end
function SellerHelperFrame_OnLoad(self)
    local lastBtn, lastLab
    for i = 1, ITEMS_TO_DISPLAY do
        SellerHelper_Item[i] = CreateFrame("Button", "SellerHelperItem" .. i, self, "SellerHelperItemTemplate")
        SellerHelper_Item[i]:SetID(i)
        if (i == 1) then
            SellerHelper_Item[i]:SetPoint("TOPLEFT", self, "TOPLEFT", 38, -80)
        else
            SellerHelper_Item[i]:SetPoint("TOPLEFT", lastBtn, "BOTTOMLEFT", 0, -3)
        end
        lastBtn = SellerHelper_Item[i]
        SellerHelper_Label[i] = CreateFrame("Button", "SellerHelperLabel" .. i, self, "SellerHelperLabelTemplate")
        SellerHelper_Label[i]:SetID(i)
        if (i == 1) then
            SellerHelper_Label[i]:SetPoint("TOPLEFT", self, "TOPLEFT", 38, -80)
        else
            SellerHelper_Label[i]:SetPoint("TOPLEFT", lastLab, "BOTTOMLEFT", 0, -3)
        end
        lastLab = SellerHelper_Label[i]
    end
end
local function startMoneyWatching()
    BF_SH_PlayerMoney = GetMoney()
    BF_SH_SellEarn = 0
    BF_SH_TradeCost = 0
end
local function finishMoneyWatching(atMail)
    if BF_SH_SellEarn and BF_SH_SellEarn > 0 or BF_SH_TradeCost and BF_SH_TradeCost > 0 then
        if SellerHelper_915af80fddb3f139926f93ab40534dd1 then
            local incomestring = ""
            if BF_SH_SellEarn > BF_SH_TradeCost then
                if atMail then
                    incomestring =
                        incomestring ..
                        string.format(
                            SellerHelper_5d51b9d73b7db1d6138565db91519e4f,
                            SellerHelper_20b9ea8773553d7b7fc3d0570f339246(BF_SH_SellEarn - BF_SH_TradeCost)
                        )
                else
                    incomestring =
                        incomestring ..
                        string.format(
                            SellerHelper_05f062a33b9407c43bde3f73a2745aa4,
                            SellerHelper_20b9ea8773553d7b7fc3d0570f339246(BF_SH_SellEarn - BF_SH_TradeCost)
                        )
                end
                SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce:Print(incomestring)
            elseif BF_SH_SellEarn < BF_SH_TradeCost then
                if atMail then
                    incomestring =
                        incomestring ..
                        string.format(
                            SellerHelper_2a42a6c7affee2d3450593e7bff4789c,
                            SellerHelper_20b9ea8773553d7b7fc3d0570f339246(BF_SH_TradeCost - BF_SH_SellEarn)
                        )
                else
                    incomestring =
                        incomestring ..
                        string.format(
                            SellerHelper_c5003e8fc4082807480e4235f6dc8eb7,
                            SellerHelper_20b9ea8773553d7b7fc3d0570f339246(BF_SH_TradeCost - BF_SH_SellEarn)
                        )
                end
                SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce:Print(incomestring)
            end
        end
    end
    BF_SH_PlayerMoney = nil
    BF_SH_SellEarn = 0
    BF_SH_TradeCost = 0
end
function SellerHelperFrame_OnEvent(...)
    local event = ...
    if (event == "MERCHANT_SHOW") then
        startMoneyWatching()
        local SellerHelper_b38cf36bca2d5be52ee0b9d4c3dd8fde = BigFoot_GetModVariable("SellerHelper", "keepShow")
        if (SellerHelper_b38cf36bca2d5be52ee0b9d4c3dd8fde) then
            SellerHelper_39fe79b7a363e068ea5f1634f9bd086f(true)
            SellerHelper_Update()
            SellerHelperFrame_Show()
        else
            SellerHelper_39fe79b7a363e068ea5f1634f9bd086f(true)
        end
    elseif (event == "MERCHANT_CLOSED") then
        finishMoneyWatching()
        SellerHelperParentFrame:Hide()
    elseif (event == "MAIL_SHOW") then
        startMoneyWatching()
    elseif (event == "MAIL_CLOSED") then
        finishMoneyWatching(true)
    elseif (event == "BAG_UPDATE" and MerchantFrame:IsVisible()) then
        SellerHelper_39fe79b7a363e068ea5f1634f9bd086f()
        SellerHelper_Update()
    elseif (event == "PLAYER_MONEY") then
        if BF_SH_PlayerMoney then
            local money = GetMoney() - BF_SH_PlayerMoney
            if money > 0 then
                BF_SH_SellEarn = BF_SH_SellEarn + money
            else
                BF_SH_TradeCost = BF_SH_TradeCost - money
            end
            BF_SH_PlayerMoney = GetMoney()
        end
    end
end
function SellerHelper_c5a2cde61a2517c7a30909912cb1e510(self, amount)
    if (InRepairMode()) then
        return
    end
    SellerHelper_0578af96a024f21f56a20439e6844571 = amount
end
function SellerHelperFrame_Show()
    SellerHelperParentFrame:Show()
    BigFoot_SetModVariable("SellerHelper", "keepShow", 1)
    CloseAllBags()
    SellerHelper_30b397836a502f55a547ab89a0c2c8f6 = OpenAllBags
    OpenAllBags = function()
    end
    BigFoot_DelayCall(
        function()
            OpenAllBags = SellerHelper_30b397836a502f55a547ab89a0c2c8f6
        end,
        0.5
    )
end
function SellerHelperFrame_Hide()
    SellerHelperFrame:Hide()
    SellHelper_Button:SetText(SELLER_HELPER_SHOW_TEXT)
    BigFoot_SetModVariable("SellerHelper", "keepShow", nil)
end
function SellerHelperFrame_OnShow()
    if (SellerHelper_22cf46a9266b3e828ae5e0513a4cff32) then
        SellerHelper_CollapseHeader(0)
    end
    PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
    SetPortraitTexture(SellerHelperParentFramePortrait, "player")
    SellerHelperFrame:Show()
    SellerHelper_39fe79b7a363e068ea5f1634f9bd086f(true)
    SellerHelper_Update()
end
function SellerHelperItem_ShowTooltip(SellerHelper_2e00ffac12aadb3a1fd865993ec505b9)
    local SellerHelper_1f194f793e9150819d886c66d5bc23b5
    for SellerHelper_96ec47e10d09a5d0491fe767488c7fab = 0, NUM_BAG_FRAMES, 1 do
        local SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed =
            GetContainerNumSlots(SellerHelper_96ec47e10d09a5d0491fe767488c7fab)
        if (SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed and SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed > 0) then
            for SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d = SellerHelper_ac9c41ad14396e03f5c5d6bf1534eaed, 1, -1 do
                SellerHelper_1f194f793e9150819d886c66d5bc23b5 =
                    SellerHelper_ffc6f36e205c615c838d2b0370235e96(
                    SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                    SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d,
                    true
                )
                if (SellerHelper_1f194f793e9150819d886c66d5bc23b5 == SellerHelper_2e00ffac12aadb3a1fd865993ec505b9) then
                    GameTooltip:SetBagItem(
                        SellerHelper_96ec47e10d09a5d0491fe767488c7fab,
                        SellerHelper_5690c3a7efc9d7d57a9a8567658fcf5d
                    )
                    return
                end
            end
        end
    end
end
function SellerHelperItem_OnEnter(self)
    GameTooltip:SetOwner(self, "ANCHOR_LEFT")
    local SellerHelper_1f194f793e9150819d886c66d5bc23b5,
        SellerHelper_bd58786d94a7654001104ccaba82bfed,
        SellerHelper_fb589c8c57c15b2b8a06e4e9dd82804a,
        SellerHelper_51bbc6646cac6748cc62569220600b52,
        SellerHelper_5fb35c5c169c804bc82bd7f93ad8e32f,
        SellerHelper_3f50417fb16be9b1078eb68d24fa9c26,
        SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 =
        SellerHelper_79565399380689e9328a491897ebbe1a(self:GetParent().itemIndex)
    SellerHelperItem_ShowTooltip(SellerHelper_1f194f793e9150819d886c66d5bc23b5)
    local i = 1
    if (getglobal("GameTooltipMoneyFrame" .. i)) then
        if (SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395) then
            MoneyFrame_Update(
                "GameTooltipMoneyFrame" .. i,
                SellerHelper_153c09d58f6a5f5b4e49d6f46f5b1395 * SellerHelper_3f50417fb16be9b1078eb68d24fa9c26
            )
        end
    end
    GameTooltip:Show()
end
function SellerHelperItem_OnLeave()
    GameTooltip:Hide()
end
function SellerHelperItem_OnClick(self)
    if (SellerHelper_742204bbb584d5b69598347fcb860ef4 == 1) then
        local SellerHelper_2e00ffac12aadb3a1fd865993ec505b9 =
            SellerHelper_7791e0406167410020e5d23e998262f1[self:GetParent().itemIndex]
        local name, link, quality, iLevel = GetItemInfo(SellerHelper_2e00ffac12aadb3a1fd865993ec505b9.link)
        if quality == 0 then
            SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce:Print(SELLER_HELPER_SET_HELP_AUTOSELL_NOTICE)
        else
            if (SellerHelper_AutoSellList[SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["name"]]) then
                StaticPopupDialogs["AUTOSELL_REMOVE_ITEM"].context = SellerHelper_2e00ffac12aadb3a1fd865993ec505b9
                StaticPopup_Show("AUTOSELL_REMOVE_ITEM", SellerHelper_2e00ffac12aadb3a1fd865993ec505b9.link)
            else
                StaticPopupDialogs["AUTOSELL_ADD_ITEM"].context = SellerHelper_2e00ffac12aadb3a1fd865993ec505b9
                StaticPopup_Show("AUTOSELL_ADD_ITEM", SellerHelper_2e00ffac12aadb3a1fd865993ec505b9.link)
            end
        end
    elseif (SellerHelper_742204bbb584d5b69598347fcb860ef4 == 2) then
        return
    end
end
function SellerHelper_fc344f6b0eb7958de65eab08097aedae()
    local SellerHelper_2e00ffac12aadb3a1fd865993ec505b9 = StaticPopupDialogs["AUTOSELL_ADD_ITEM"].context
    SellerHelper_AutoSellList[SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["name"]] =
        SellerHelper_2e00ffac12aadb3a1fd865993ec505b9
    SellerHelper_39fe79b7a363e068ea5f1634f9bd086f()
end
function SellerHelper_9d9b7a69f49f6a037c9785362ca46a17()
    local SellerHelper_2e00ffac12aadb3a1fd865993ec505b9 = StaticPopupDialogs["AUTOSELL_REMOVE_ITEM"].context
    SellerHelper_AutoSellList[SellerHelper_2e00ffac12aadb3a1fd865993ec505b9["name"]] = nil
    SellerHelper_39fe79b7a363e068ea5f1634f9bd086f()
    SellerHelper_Update()
end
function SellerHelper_OnScroll(self, offset)
    if (SellerHelper_742204bbb584d5b69598347fcb860ef4 == 1) then
        FauxScrollFrame_OnVerticalScroll(self, offset, SELLER_HELPER_FRAME_ITEM_HEIGHT, SellerHelper_Update)
    elseif (SellerHelper_742204bbb584d5b69598347fcb860ef4 == 2) then
        FauxScrollFrame_OnVerticalScroll(self, offset, SELLER_HELPER_FRAME_ITEM_HEIGHT, AR_UpdatePanel)
    end
end
function SellHelper_Button_OnClick(self)
    if (SellerHelperParentFrame:IsShown()) then
        self:SetText(SELLER_HELPER_SHOW_TEXT)
        SellerHelperParentFrame:Hide()
    else
        self:SetText(SELLER_HELPER_HIDE_TEXT)
        SellerHelperParentFrame:Show()
        SellerHelperParentFrameTab_OnClick(nil, nil, 1)
    end
end
function SellerHelper_20b9ea8773553d7b7fc3d0570f339246(SellerHelper_2361bab8b48b1041ad740bb561b21aee)
    local SellerHelper_f4e13e8ecf20422833dd2d694a22bf40 = tonumber(SellerHelper_2361bab8b48b1041ad740bb561b21aee)
    local SellerHelper_c073decd77f86a53128a189abe1f48ec = ""
    if (SellerHelper_f4e13e8ecf20422833dd2d694a22bf40 == nil) then
        return nil
    end
    local SellerHelper_e8b199d6656a0d100a2cef18cd77aef5 =
        math.floor(SellerHelper_f4e13e8ecf20422833dd2d694a22bf40 / 10000)
    SellerHelper_f4e13e8ecf20422833dd2d694a22bf40 =
        SellerHelper_f4e13e8ecf20422833dd2d694a22bf40 - SellerHelper_e8b199d6656a0d100a2cef18cd77aef5 * 10000
    local SellerHelper_24a4201c549bfbd7ba558ebfca17c262 =
        math.floor(SellerHelper_f4e13e8ecf20422833dd2d694a22bf40 / 100)
    SellerHelper_f4e13e8ecf20422833dd2d694a22bf40 =
        SellerHelper_f4e13e8ecf20422833dd2d694a22bf40 - SellerHelper_24a4201c549bfbd7ba558ebfca17c262 * 100
    local SellerHelper_1212036899db090a683c1f070e6c4196 = SellerHelper_f4e13e8ecf20422833dd2d694a22bf40
    if (SellerHelper_e8b199d6656a0d100a2cef18cd77aef5 > 0) then
        SellerHelper_c073decd77f86a53128a189abe1f48ec =
            SellerHelper_e8b199d6656a0d100a2cef18cd77aef5 .. SellerHelper_5365f09cf64de4e4ef6f85d61a2c7c38
    end
    if (SellerHelper_24a4201c549bfbd7ba558ebfca17c262 > 0) then
        SellerHelper_c073decd77f86a53128a189abe1f48ec =
            SellerHelper_c073decd77f86a53128a189abe1f48ec ..
            SellerHelper_24a4201c549bfbd7ba558ebfca17c262 .. SellerHelper_64c2a722159954204326f6d805f5135b
    end
    if (SellerHelper_1212036899db090a683c1f070e6c4196 > 0) then
        SellerHelper_c073decd77f86a53128a189abe1f48ec =
            SellerHelper_c073decd77f86a53128a189abe1f48ec ..
            SellerHelper_1212036899db090a683c1f070e6c4196 .. SellerHelper_81cbcfba4fa033a3ccc8e05d05fb75e1
    end
    return SellerHelper_c073decd77f86a53128a189abe1f48ec
end
function SellerHelperParentFrame_OnLoad(self)
    PanelTemplates_SetNumTabs(self, 2)
    PanelTemplates_SetTab(self, 1)
    SellerHelper_742204bbb584d5b69598347fcb860ef4 = 1
    for i = 1, 10 do
        SellerHelper_AutobuyAddItemButton[i] =
            CreateFrame(
            "Button",
            "SellerHelperAutoBuyAddItemButton" .. i,
            _G["MerchantItem" .. i .. "ItemButton"],
            "SellerHelperAutoBuyAddItemButtonTemplate"
        )
        SellerHelper_AutobuyAddItemButton[i]:SetID(i)
        SellerHelper_AutobuyAddItemButton[i]:SetFrameLevel(_G["MerchantItem" .. i .. "ItemButton"]:GetFrameLevel() + 2)
    end
end
function SellerHelperParentFrameTab_OnClick(self, button, id)
    local id = id or self:GetID()
    PanelTemplates_SetTab(SellerHelperParentFrame, id)
    if (id == 1) then
        SellerHelperFrame:Show()
        AutoRechargeFrame:Hide()
        SellerHelper_742204bbb584d5b69598347fcb860ef4 = 1
    elseif (id == 2) then
        SellerHelperFrame:Hide()
        AutoRechargeFrame:Show()
        SellerHelper_742204bbb584d5b69598347fcb860ef4 = 2
    end
end
function SellerHelperSetFrame_OnLoad(self)
    self:RegisterForDrag("LeftButton")
    self:SetMovable(true)
    SellerHelperSetFramePortrait:SetTexture([[Interface\AddOns\BigFoot\Media\footico.tga]])
    SellerHelperSetFramePortrait:SetTexCoord(0.0119531, 0.1380375, 0.0119531, 0.2725)
end
function SellerHelperSetFrame_OnKeyDown(self, key)
    if (GetBindingFromClick(key) == "TOGGLEGAMEMENU") then
        SellerHelperSetFrame:Hide()
    end
end
function SellerHelperSetFrame_OnMouseDown(self, button)
    self:StartMoving()
end
function SellerHelperSetFrame_OnMouseUp(self, button)
    self:StopMovingOrSizing()
end
function SellerHelperSetFrameSetFrame_OnLoad(self)
    local lastBtn, lastLab, Crframe
    for i = 1, ITEMS_TO_DISPLAY do
        Crframe = CreateFrame("Button", "SellerHelperNotSellItem" .. i, self, "SellerHelperNotSellItemTemplate")
        Crframe:SetID(i)
        if (i == 1) then
            Crframe:SetPoint("TOPLEFT", self, "TOPLEFT", 38, -5)
        else
            Crframe:SetPoint("TOPLEFT", lastBtn, "BOTTOMLEFT", 0, -3)
        end
        Crframe:Show()
        _G[Crframe:GetName() .. "Name"]:SetText("物品名字" .. i)
        lastBtn = Crframe
    end
end
local lastclTime = 0
function SellerHelper_6221906a1d0d40a4c770f8cabc09a1b0(Self)
    local name = Self.data
    if name then
        for k, v in pairs(SellerHelper_NotSellList) do
            if v == name then
                table.remove(SellerHelper_NotSellList, k)
                SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce:Print(string.format(SELLER_HELPER_DEL, name))
                break
            end
        end
    end
    NotSellerHelper_Update()
end
function NotSellerItemButton_OnClick(self)
    if not (lastclTime and GetTime() - lastclTime > 1) then
        lastclTime = GetTime()
        return
    end
    lastclTime = GetTime()
    local type, data, subType = GetCursorInfo()
    if type and data and subType then
        if type == "item" then
            local name, link, quality, iLevel = GetItemInfo(subType)
            if quality and quality == 0 then
                NotSellerHelper_OnAddItem(name)
                ClearCursor()
            else
                SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce:Print(SELLER_HELPER_SET_HELP_NOTSELL_NOTICE)
            end
        end
    else
        local name = _G[self:GetName() .. "Name"]
        if name then
            name = name:GetText()
        end
        if name then
            local dialog = StaticPopup_Show("AUTONOTSELL_REMOVE_ITEM", name)
            if (dialog) then
                dialog.data = name
            end
        end
    end
end
function NotSellerHelper_OnAddItemClick()
    StaticPopup_Show("SellerHelper_ADDNotSellList")
end
function NotSellerHelper_OnAddItem(name)
    if name and name ~= "" then
        local Bhave = false
        for k, v in pairs(SellerHelper_NotSellList) do
            if v == name then
                Bhave = true
                break
            end
        end
        if Bhave then
            SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce:Print(string.format(SELLER_HELPER_ALREADYHAVE, name))
        else
            table.insert(SellerHelper_NotSellList, name)
            SellerHelper_a4ed2c6153d1a73ae298b67f0bcbabce:Print(string.format(SELLER_HELPER_ADD, name))
        end
    end
    NotSellerHelper_Update()
end
function NotSellerHelper_OnScroll(self, offset)
    FauxScrollFrame_OnVerticalScroll(self, offset, SELLER_HELPER_FRAME_ITEM_HEIGHT, NotSellerHelper_Update)
end
function SellerHelper_6eb9bbcd5c6bab709e84305100277dd3()
    return SellerHelper_NotSellList
end
function SellerHelper_e44fc91a3f0fa1df3ceee987fd5f6e15(__index, itemName)
    local Item = getglobal("SellerHelperNotSellItem" .. __index)
    if Item then
        Item:Show()
        getglobal("SellerHelperNotSellItem" .. __index .. "Name"):SetText(itemName)
    end
end
function NotSellerHelperFrame_OnShow()
    PlaySound(SOUNDKIT.IG_BACKPACK_OPEN)
    NotSellerHelper_Update()
end
function NotSellerHelper_Update()
    local NotSellTab = SellerHelper_6eb9bbcd5c6bab709e84305100277dd3()
    local SellerHelper_b7f0e0107e2c8b96e78550265859f2e5 = #NotSellTab
    local SellerHelper_98b436aae97b9941de81152428c81208 =
        FauxScrollFrame_GetOffset(SellerHelperSetFrameSetFrameScrollFrame) + 1
    local __index = 1
    for SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f = SellerHelper_98b436aae97b9941de81152428c81208, SellerHelper_98b436aae97b9941de81152428c81208 +
        ITEMS_TO_DISPLAY -
        1 do
        if (SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f <= SellerHelper_b7f0e0107e2c8b96e78550265859f2e5) then
            SellerHelper_e44fc91a3f0fa1df3ceee987fd5f6e15(
                __index,
                NotSellTab[SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f]
            )
        else
            break
        end
        __index = __index + 1
    end
    for SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f = __index, ITEMS_TO_DISPLAY do
        getglobal("SellerHelperNotSellItem" .. SellerHelper_e914904fab9d05d3f54d52bfc31a0f3f):Hide()
    end
    FauxScrollFrame_Update(
        SellerHelperSetFrameSetFrameScrollFrame,
        SellerHelper_b7f0e0107e2c8b96e78550265859f2e5,
        ITEMS_TO_DISPLAY,
        SELLER_HELPER_FRAME_ITEM_HEIGHT
    )
end
