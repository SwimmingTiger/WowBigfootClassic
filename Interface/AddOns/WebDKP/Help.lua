------------------------------------------------------------------------
-- HELP	
------------------------------------------------------------------------
-- Contains methods related to displaying help and the help frame to the
-- user. 
------------------------------------------------------------------------

-- The actual help content
local WebDKP_Help = {
    [1] = {
        ["Name"] = "欢迎",
        ["Text"] = "|cFFFF0000欢迎使用 WebDKP|r" ..
                "|n|n" ..
                "此插件怀旧服版本由Wowcat 60addons迭代开发"..
                "|n|n" ..
                "此插件旨在通过自动化或半自动化完成DKP操作,或手动操作,使管理dkp的任务更容易。 此插件能更好的查看公会成员的DKP和其详细日志。可以使用附带的同步工具或从网站控制中心上载日志文件，将游戏中所做的更改与http://webdkp.wowcat.net网站同步" ..
                "|n|n" ..
                "此帮助文档是为了指导你第一次使用插件,完成插件的基本和更高级的使用方法。"
    },
    [2] = {
        ["Name"] = "一般使用",
        ["Text"] = "|cFFFF0000一般使用|r" ..
                "|n|n" ..
                "首先,找到小地图金币按钮,左键打开主界面,右键设置" ..
                "|n|n" ..
                "左键小地图金币后,会出现一个DKP表主窗口,这个界面就是我们操作DKP的地方以及插件所有功能的所在。如果这是你第一次使用插件，那么插件的DKP表里肯定是空的,或者只有你一个人。这是因为列表默认只显示当前组中的人。你必须参加一个队伍或团队,才能在表里看到其他人。一般来说,等你开始活动开组后,这个表就会填满人! 你就可以根据需要进行排序了!" ..
                "|n|n" ..
                "DKP表主窗口右边的选项是插件进行加减DKP的所有功能所在的位置。此区域有4个主要选项卡供你使用：过滤,奖惩,物品,替补" ..
                "|n|n" ..
                "|cFFFF0000过滤|r 允许你筛选过滤DKP表中显示的玩家。你可以将表限制为指定的职业，从而更容易找到所需人员。在这里,你还可以通过勾选“替补”来显示当前表中的所有的替补人员。“其他”则是显示除了当前团队外的所有有DKP记录的人员,通常用于DKP管理在未活动时查看各个人员数据" ..
                "|n|n" ..
                "|cFFFF0000奖惩|r 这里是你主要进行加减DKP的地方, 注意,这仅用于奖惩DKP(如集合分,解散分,犯错扣分等等),千万不用于记录奖励物品。要奖励dkp,你只需从左侧选择要奖励的人员, 输入奖励的理由和分数, 然后点击'奖惩!'按钮。为了便于从列表中选择玩家，你可以在底部找到两个名为“|cFF33FF00全选|r”和“|cFF33FF00取消全选|r”的按钮。" ..
                "|n|n" ..
                "|cFFFF0000物品|r 在这里进行装备扣分,如果你没有从自动弹框中扣取别别人的装备分的话你就必须在这里进行扣分, 请从左侧选择一个玩家,然后输入DKP分数（正数）,SHIFT+左键装备填入到名称里,然后点击奖惩!. 如果你启用了“自动填充物品名”或“自动弹窗启用”（默认情况下为启用）,则会自动为你输入和记录此信息。" ..
                "|n|n" ..
                "|cFFFF0000替补|r 这里是你增加和删除替补人员的地方,如果你的团队有替补人员,你可以让他们M你'我要替补'命令, 他们就会自动进入DKP列表,你能很轻易地找到他们, 每次活动结束,用同步工具同步之后,这些临时替补会自动清空"..
                "|n|n" ..
                "在团队活动结束后,你必须保存文档,并上传到DKP网站 |cFFFF0000http://webdkp.wowcat.net|r ,建议使用我们的Webdkp同步工具哦! 操作更加方便"..
                "|n|n" ..
                "|cFFFF0000关于衰减DKP功能|r 允许你输入一个值衰减选取人员的dkp。例如,你输入|cFF33FF00.5|r,然后选择你想衰减的玩家,则会减去他的DKP总数的50%。PS:当玩家的dkp为负时，输入|cFF33FF00-.5|r的话则能增加50%的dkp。"

    },
    [3] = {
        ["Name"] = "设置相关",
        ["Text"] = "|cFFFF0000设置|r" ..
                "|n|n" ..
                "WebDKP有多种设置，允许你根据你的公会需要对其进行调整。通过右键“小地图金币”下拉列表中的“设置”选项,可以找到“设置”窗口。" ..
                "|n|n" ..
                "|cFFFF0000自动填充物品名|r 启用后,WebDKP将监视你的聊天窗口,监视是否有人接收到物品 (如: Qcat获得了: [一件紫装]) 这种系统黄字。当插件检测到它们时,它将自动选择dkp表中的接收玩家,并自动在“物品”选项上自动填写“物品名称”。如果你使用的是战利品表,系统还将自动填写DKP。 " ..
                "|n|n" ..
                "|cFFFF0000自动弹框品质|r 设置自动弹框的品质级别,需要'自动弹框启用'开启" ..
                "|n|n" ..
                "|cFFFF0000自动弹框启用|r 更进一步的自动填充。当启用后,当插件检测到一个物品被谁捡取后,插件将会自动弹出一个装备扣分框架。此弹出框将允许你输入物品的DKP成本,并自动将此信息记录在DKP表中。如果你使用的是战利品表,系统还将自动填写DKP" ..
                "|n|n" ..
                "|cFFFF0000零和DKP|r 零位DKP是一个DKP分数处理系统，当物品DKP处理完毕时才会被触发。如果你启用了零和DKP模式,那么无论是谁因为获取了装备而被扣的DKP分数都会平均分配给全团参与玩家,例如:你们是一个40人的团队,A获得了一件装备,被扣了40DKP,那么全团都会被奖励到1点DKP,在严格竞争下，一方的收益必然意味着另一方的损失，博弈各方的收益和损失相加总和永远为“零”，双方不存在合作的可能。所以,零和DKP系统是一个相对比较好的科学DKP模式" ..
                "|n|n" ..
                "|cFFFF0000自动BOSS击杀奖励|r 推荐使用此系统,开启后,系统将会自动检测Boss的击杀,你只需要在相应的副本选项里填入分数即可,例如,你们MC的Boss每个1分,就在MC|ONY的框里填写1。此系统开启后,将会和装备弹框一样弹出确认编辑框,如果你们的Boss分数不同,例如你们的MC1-9为1尾王为2,那么只需要在尾王击杀后在弹框中把1改为2即可" ..
                "|n|n" ..
                "|cFFFF0000自动BOSS击杀奖励 包含替补|r 顾名思义,需要启用自动Boss击杀,当你的团队内有替补时,并且你想同时给替补也加Boss击杀分时启用" ..
                "|n|n" ..
                "|cFFFF0000自动BOSS击杀奖励 忽略0分|r 有些团队不允许使用当前DKP,同时也想记录Boss击杀数据,那么就开启此选项" ..
                "|n|n" ..
                "|cFFFF0000非队伍/团队玩家屏蔽私聊|r 启用后,对于非队伍/团队玩家的查询命令也屏蔽,如'mydkp' '查询 zs'等等" ..
                "|n|n" ..
                "|cFFFF0000DKP封顶|r DKP封顶是一个机制,允许你设置封顶分数,任何玩家的DKP达到了该分数,那么他就无法再获取DKP了,只能扣分"


    },
    [4] = {
        ["Name"] = "私聊DKP",
        ["Text"] = "|cFFFF0000私聊DKP|r" ..
                "|n|n" ..
                "私聊DKP是插件的一个重要的内置功能,允许有分数的成员发送给你私聊,以查看他们当前的DKP。这项功能插件是默认对这些命令屏蔽的,对方能看得到插件的自动回复,而你是看不见的,所以你不会被这些信息刷屏。PS:某些插件可能不支持屏蔽,如Elvui,所以你还是会被刷屏" ..
                "|n|n" ..
                "要使用此功能,任何人都只需向你私聊发出以下命令：" ..
                "|n|n" ..
                "|cFFFF0000'mydkp'|r - 告诉玩家当前的DKP(取决于你所选定的哪张表)" ..
                "|n" ..
                "|cFFFF0000'查询'|r - 列出当前团队中所有人的DKP|n" ..
                "|n" ..
                "|cFFFF0000'查询 职业'|r - 列出当前团队中此职业的DKP,职业可以是中文,也可以是英文头字母缩写,如:" ..
                "|n|n" ..
                "|cFFFF0000'查询 战士'|r - 列出当前团队中所有战士的DKP|n" ..
                "|n" ..
                "|cFFFF0000查询 LR|r - 列出当前团队中所有猎人的DKP|n" ..
                "|n" ..
                "|cFFFF0000查询 LR QS|r - 列出当前团队中所有猎人和圣骑士的DKP"
    },
    [5] = {
        ["Name"] = "竞拍",
        ["Text"] = "|cFFFF0000竞拍|r" ..
                "|n|n" ..
                "一个自动竞拍功能,可供使用竞拍价来决定谁应该收到物品并且扣分。首先使用竞价窗口或聊天命令进行竞拍。你的raid中的玩家可以在私聊/团队/队伍聊天频道中发出消息说他们想出价多少(也可以是纯数字),这个竞拍模块会获取这些信息并显示在屏幕上。竞拍结束后，你可以选择获奖用户并单击奖惩。这将自动将此信息记录在DKP表中。" ..
                "|n|n" ..
                "想要使用此功能,点击拾取框快捷竞拍按钮(一个[拍]按钮)。然后，你可以输入要竞拍物品的低价以及竞拍持续时间的可选时间（秒）,(在此处输入0表示没有时间限制),单击“开始竞拍”。不想用快捷竞拍按钮的话也可以手动打开竞拍系统,手动输入相关,然后按开始竞拍" ..
                "|n|n" ..
                "玩家可以使用聊天信息或私聊出价:|n" ..
                "|cFFFF0000出价 #|r   (例如: 出价 20) , 也可以输入纯分数,最新版本中支持纯分数竞拍了" ..
                "|n|n" ..
                "|n|n" ..
                "你如果正在使用固定DKP系统,玩家也可以选择输入|cFFFF0000需求|r 和 |cFFFF0000贪婪|r 命令"

    },
    [5] = {
        ["Name"] = "战利品表集成系统",
        ["Text"] = "|cFFFF0000战利品表集成系统|r" ..
                "|n|n" ..
                "插件的一个方便的特性是让它与你在http://webdkp.wowcat.net上创建的战利品表集成在一起。在站点上创建战利品表（手动或通过选择一个模板）,编辑后上传,然后再同步工具上获取最新。然后你就能在游戏里启用这个战利品表了,无需手动开启,默认就是启用的" ..
                " 然后,插件可以以不同的方式查找这些信息，以使你的DKP管理更轻松。" ..
                "|n|n" ..
                "在一些地方你会看到使用的战利品表信息:" ..
                "|n|n" ..
                "|cFFFF0000奖惩物品|r|n如果你在“物品”选项卡中输入一个名称，将自动查找并填写DKP价格" ..
                "|n|n" ..
                "|cFFFF0000自动弹框|r|n如果你开启了自动弹框功能，弹出窗口将自动在“物品成本”字段中为你填写物品DKP" ..
                "|n|n" ..
                "|cFFFF0000固定竞拍|r|n如果你使用的是固定竞拍选项，当你奖励玩家时，物品成本将从战利品表中填写。（有关固定竞价的详细信息，请参见选项）"
    },
    [6] = {
        ["Name"] = "可用命令",
        ["Text"] = "|cFFFF0000可用命令|r" ..
                "|n|n" ..
                "下面是可以在游戏中使用的斜杠命令:" ..
                " 1.) /webdkp show table - 显示dkp表 " ..
                "|n|n" ..
                " 2.) /webdkp show bidding - 显示竞拍窗口." ..
                "|n|n" ..
                " 3.) /webdkp show synch - 显示游戏内同步设置" ..
                "|n|n" ..
                " 4.) /webdkp show options - 显示设置窗口" ..
                "|n|n" ..
                " 5.) /webdkp show timed - 显示时间分奖励窗口" ..
                "|n|n" ..
                " 6.) /webdkp show help - 显示帮助窗口" ..
                "|n|n" ..
                " 7.) /webdkp show log - 显示奖惩日志窗口" ..
                "|n|n" ..
                " 8.) /webdkp show raidlog - 显示团队日志窗口" ..
                "|n|n" ..
                " 9.) /webdkp show charlog - 显示角色团队日志窗口" ..
                "|n|n" ..
                "10.) /webdkp start raid - 团队日志内开始一个Raid" ..
                "|n|n" ..
                "11.) /webdkp end raid - 团队日志内结束一个Raid" ..
                "|n|n" ..
                "12.) /webdkp ignore list - 列出所有忽略的物品" ..
                "|n|n" ..
                "13.) /webdkp ignore add - 将物品添加到忽略列表" ..
                "|n|n" ..
                "14.) /webdkp ignore del - 从忽略列表中删除物品 (不能删除默认的)"
    },
    [7] = {
        ["Name"] = "忽略物品列表",
        ["Text"] = "|cFFFF0000忽略物品|r" ..
                "|n|n" ..
                "WebDKP允许你将物品添加到默认忽略列表. 默认忽略列表包含在WTF中的webdkp.lua中，无法从游戏中编辑。 以下是允许你在wow中列出、添加和删除忽略物品的命令" ..
                "|n|n" ..
                " 1.) 下面是一个如何列出已添加的所有物品的示例 " ..
                "     /webdkp ignore list" ..
                "|n|n" ..
                " 2.) 下面是如何将物品添加到忽略列表的示例" ..
                "     /webdkp ignore add 物品名, 如: /webdkp ignore add 亚麻布" ..
                "|n|n" ..
                " 3.) 下面是如何从忽略列表中删除物品的示例" ..
                "     /webdkp ignore del 物品名, 如: /webdkp ignore add 亚麻布"
    },
}

-- ================================
-- Initializes the help menu to show the 
-- currently selected topic
-- ================================
function WebDKP_Help_Init()
    WebDKP_Help_DropDown_Init();
    WebDKP_Help_Frame_Text:SetText(WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Text"]);
end

-- ================================
-- Toggles the help frame on and off.
-- ================================
function WebDKP_Help_ToggleGUI()
    if (WebDKP_HelpFrame:IsShown()) then
        WebDKP_HelpFrame:Hide();
    else
        WebDKP_Help_Init();
        WebDKP_HelpFrame:Show();
    end
end


-- ================================
-- Invoked when the gui is down. Loads up the contents
-- of the help topic drop down. 
-- ================================
function WebDKP_Help_DropDown_OnLoad()
    UIDropDownMenu_Initialize(WebDKP_Help_DropDown, WebDKP_Help_DropDown_Init);
end

-- ================================
-- Invoked when the help menu drop down list is invoked. 
-- Runs through the help topics data structure and adds
-- a list of items. 
-- ================================
function WebDKP_Help_DropDown_Init()

    if (WebDKP_HelpFrame.helpChoice == nil) then
        WebDKP_HelpFrame.helpChoice = 1;
    end

    --WebDKP_Print(WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Name"]);
    local numHelpTopics = WebDKP_GetTableSize(WebDKP_Help);
    for i = 1, numHelpTopics do
        if (type(WebDKP_Help[i]) == "table") then
            local checked = (WebDKP_Help[i]["Name"] == WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Name"]);
            WebDKP_Add_HelpDropDownItem(self, WebDKP_Help[i]["Name"], i, checked);
        end
    end
    UIDropDownMenu_SetSelectedName(WebDKP_Help_DropDown, WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Name"]);
    UIDropDownMenu_SetWidth(WebDKP_Help_DropDown, 150, 10);
end

-- ================================
-- Helper method that adds individual entries into the help menu drop down
-- ================================
function WebDKP_Add_HelpDropDownItem(self, text, value, checked)
    local this = self;
    local info = { };
    info.text = text;
    info.value = value;
    info.owner = this;
    info.checked = checked;
    info.func = WebDKP_Help_DropDown_OnClick;
    UIDropDownMenu_AddButton(info);
end

-- ================================
-- Called when the user switches between
-- a different dkp table.
-- ================================
function WebDKP_Help_DropDown_OnClick(self)
    local this = self;
    WebDKP_HelpFrame.helpChoice = this.value;
    WebDKP_Help_DropDown_Init();
    WebDKP_Help_Frame_Text:SetText(WebDKP_Help[WebDKP_HelpFrame.helpChoice]["Text"]);
end

