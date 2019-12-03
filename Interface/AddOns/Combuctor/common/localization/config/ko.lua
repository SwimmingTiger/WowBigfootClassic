--[[
	ADDON Config Localization: Korean
--]]

local CONFIG, Config = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'koKR')
if not L then return end

-- general
L.GeneralDesc = '환경 설정에 따라 설정을 전환 할 수 있는 일반적인 기능입니다.'
L.Locked = '창 위치 잠금'
L.Fading = '창 사라짐 효과 사용'
L.TipCount = '아이템 갯수를 툴팁에 표시'
L.FlashFind = '빠른 찾기 사용'
L.EmptySlots = '빈 칸 배경 표시'
L.DisplayBlizzard = '숨겨진 가방을 보기 위해 블리자드 프레임을 표시합니다.'

-- frame
L.FrameSettings = '창 설정'
L.FrameSettingsDesc = 'ADDON 프레임에 특화된 설정'
L.Frame = '창'
L.Enabled = '애드온 사용'
L.CharacterSpecific = '캐릭터 개별 설정'
L.ExclusiveReagent = '재료 은행 별도 표시'

L.BagToggle = '가방 표시'
L.Money = '소지금 표시'
L.Broker = 'Databroker 플러그인 표시'
L.Sort = '정리 버튼 표시'
L.Search = '검색 버튼 표시'
L.Options = '설정 버튼 표시'

L.Appearance = '모양'
L.Layer = '레이어'
L.BagBreak = '가방 별로 구분하여 표시'
L.ReverseBags = '가방 순서 반대로'
L.ReverseSlots = '칸 순서 반대로'

L.Color = '배경 색상'
L.BorderColor = '테두리 색상'

L.Strata = '프레임 레이어'
L.Columns = '칸 수'
L.Scale = '크기 비율'
L.ItemScale = '아이템 크기 비율'
L.Spacing = '간격'
L.Alpha = '불투명도'

-- auto display
L.DisplaySettings = '자동 표시'
L.DisplaySettingsDesc = '이 설정은 게임 이벤트에 따라 가방을 자동으로 열거나 닫게 해줍니다.'
L.DisplayInventory = '가방 표시'
L.CloseInventory = '가방 닫기'

L.DisplayBank = '은행 창 열 때 가방 열기'
L.DisplayAuction = '경매 창 열 때 가방 열기'
L.DisplayTrade = '거래 시 가방 열기'
L.DisplayCraft = '제작 시 가방 열기'
L.DisplayMail = '우편함 열 때 가방 열기'
L.DisplayGuildbank = '길드 은행 열 때 가방 열기'
L.DisplayPlayer = '캐릭터 창 열 때 가방 열기'
L.DisplayGems = '보석 장착시 가방 열기'

L.CloseCombat = '전투 시 가방 닫기'
L.CloseVehicle = '차량 탑승 시 가방 닫기'
L.CloseBank = '은행 창을 닫을 때 가방 닫기'
L.CloseVendor = '상인을 떠날 때 가방 닫기'

-- colors
L.ColorSettings = '색상 설정'
L.ColorSettingsDesc = '이 설정은 아이템의 변화 상황을 쉽게 구분할 수 있도록 표시합니다.'
L.GlowQuality = '품질에 따라 아이템 강조' 
L.GlowNew = '새로 획득한 아이템 강조'
L.GlowQuest = '퀘스트 아이템 강조'
L.GlowUnusable = '사용할 수 없는 아이템 강조'
L.GlowSets = '장비 관리 구성 아이템 강조'
L.ColorSlots = '가방 종류에 따라 빈 칸 색상 표시'

L.NormalColor = '일반 칸 색상'
L.LeatherColor = '가죽세공 가방 칸 색상'
L.InscribeColor = '주문각인 가방 칸 색상'
L.HerbColor = '약초 가방 칸 색상'
L.EnchantColor = '마법부여 가방 칸 색상'
L.EngineerColor = '기계공학 가방 칸 색상'
L.GemColor = '보석 가방 칸 색상'
L.MineColor = '채광 자루 칸 색상'
L.TackleColor = '낚시상자 칸 색상'
L.RefrigeColor = '요리 가방 칸 색상'
L.ReagentColor = '재료 은행 칸 색상'
L.GlowAlpha = '강조 색상 밝기'
