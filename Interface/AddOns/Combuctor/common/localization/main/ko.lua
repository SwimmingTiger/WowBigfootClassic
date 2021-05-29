--[[
	Korean Localization
--]]

local ADDON = ...
local L = LibStub('AceLocale-3.0'):NewLocale(ADDON, 'koKR')
if not L then return end

--keybindings
L.ToggleBags = '소지품 온/오프'
L.ToggleBank = '은행 온/오프'
L.ToggleGuild = '길드 금고 온/오프'
L.ToggleVault = '공허 보관 온/오프'

--terminal
L.Commands = '명령어:'
L.CmdShowInventory = '소지품 온/오프'
L.CmdShowBank = '은행 온/오프'
L.CmdShowGuild = '길드 금고 온/오프'
L.CmdShowVault = '공허 보관 온/오프'
L.CmdShowVersion = '현재 버전 정보 출력'
L.CmdShowOptions = '설정메뉴 열기'
L.Updated = '업데이트 v%s'

--frame titles
L.TitleBags = '%s의 소지품'
L.TitleBank = '%s의 은행'
L.TitleVault = '%s의 공허'

--dropdowns
L.TitleFrames = '%s 프레임'
L.SelectCharacter = '캐릭터 선택'
L.ConfirmDelete = '%s의 캐시된 데이터를 삭제하시겠습니까?'

--interactions
L.Click = '클릭'
L.Drag = '<드래그>'
L.LeftClick = '<좌-클릭>'
L.RightClick = '<우-클릭>'
L.DoubleClick = '<더블-클릭>'
L.ShiftClick = '<쉬프트-클릭>'

--tooltips
L.Total = '합계'
L.GuildFunds = '길드 금고'
L.TipGoldOnRealm = '총 %s'
L.NumWithdraw = '%d 출금'
L.NumDeposit = '%d 입금'
L.NumRemainingWithdrawals = '출금 잔고 %d'

--action tooltips
L.TipChangePlayer = '다른 캐릭터의 아이템 보기'
L.TipCleanItems = '아이템을 정리하려면 %s'
L.TipConfigure = '이 창을 설정하려면 %s'
L.TipDepositReagents = '은행에 재료를 입금하려면 %s'
L.TipDeposit = '입금하려면 %s'
L.TipWithdraw = '출금하려면 %s (%s 남음).'
L.TipFrameToggle = '다른 창을 보려면 %s'
L.TipHideBag = '가방을 숨기려면 %s'
L.TipHideBags = '가방 표시를 숨기려면 %s'
L.TipHideSearch = '검색을 멈추려면 %s'
L.TipMove = '이동은 %s'
L.TipPurchaseBag = '은행 슬롯을 구매하려면 %s'
L.TipResetPlayer = '현재 캐릭터로 돌아가려면 %s'
L.TipShowBag = '가방을 보려면 %s'
L.TipShowBags = '가방을 표시하려면 %s'
L.TipShowBank = '은행을 보려면 %s'
L.TipShowInventory = '소지품을 보려면 %s'
L.TipShowOptions = '설정 메뉴를 열려면 %s'
L.TipShowSearch = '검색하려면 %s'

--itemcount tooltips
L.TipCountEquip = '착용: %d'
L.TipCountBags = '가방: %d'
L.TipCountBank = '은행: %d'
L.TipCountVault = '공허: %d'
L.TipCountGuild = '금고: %d'
L.TipDelimiter = '/'

--dialogs
L.AskMafia = '마피아에 문의'
L.ConfirmTransfer = '어떤 아이템든 보관하면 모든 수정 사항이 제거되고 거래 및 환불이 불가능합니다.|n|n계속 하시겠습니까?'
L.CannotPurchaseVault = '공허 보관 서비스를 해제할 충분한 금액이 없습니다.|n|n|cffff2020금액: %s|r'
L.PurchaseVault = '공허 보관 서비스를 해제할까요?|n|n|cffffd200금액:|r %s'
