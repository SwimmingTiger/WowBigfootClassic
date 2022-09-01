-- $Id: Atlas_BurningCrusade-koKR.lua 55 2022-02-02 17:13:50Z arithmandar $
--[[

	Atlas, a World of Warcraft instance map browser
	Copyright 2005 ~ 2010 - Dan Gilbert <dan.b.gilbert@gmail.com>
	Copyright 2010 - Lothaer <lothayer@gmail.com>, Atlas Team
	Copyright 2011 ~ 2022 - Arith Hsu, Atlas Team <atlas.addon at gmail dot com>

	This file is part of Atlas.

	Atlas is free software; you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation; either version 2 of the License, or
	(at your option) any later version.

	Atlas is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with Atlas; if not, write to the Free Software
	Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

--]]

local AceLocale = LibStub:GetLibrary("AceLocale-3.0");
local L = AceLocale:NewLocale("Atlas_BurningCrusade", "koKR", false);

-- Atlas Spanish Localization
if ( GetLocale() == "koKR" ) then
-- Define the leading strings to be ignored while sorting
-- Ex: The Stockade
AtlasSortIgnore = {
	--"the (.+)",
};

-- Syntax: ["real_zone_name"] = "localized map zone name"
AtlasZoneSubstitutions = {
--	["Ahn'Qiraj"] = "Templo de Ahn'Qiraj";
--	["The Temple of Atal'Hakkar"] = "El Templo de Atal'Hakkar";
--	["Throne of Tides"] = "Fauce Abisal: Trono de las Mareas";
};
end


if L then
L["\"Captain\" Kaftiz"] = "\"두목\" 카프티즈"
L["\"Slim\" <Shady Dealer>"] = "\"말라깽이\" <암거래상>"
L["Abbendis"] = "아벤디스"
--[[Translation missing --]]
--[[ L["AC"] = ""--]] 
L["Advance Scout Chadwick"] = "전위 정찰병 채드윅"
L["Aged Dalaran Wizard"] = "늙은 달라란 마술사"
--[[Translation missing --]]
--[[ L["Al'ar"] = ""--]] 
--[[Translation missing --]]
--[[ L["Alexston Chrome <Tavern of Time>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Alurmi <Keepers of Time Quartermaster>"] = ""--]] 
L["Aluyen <Reagents>"] = "알루엔 <마법 재료 상인>"
--[[Translation missing --]]
--[[ L["Alyson Antille"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ambassador Hellmaw"] = ""--]] 
L["Ambassador Pax'ivi"] = "대사 팍시비"
--[[Translation missing --]]
--[[ L["Anachronos <Keepers of Time>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Andormu <Keepers of Time>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Anzu"] = ""--]] 
L["Apoko"] = "아포코"
--[[Translation missing --]]
--[[ L["Apprentice Darius"] = ""--]] 
--[[Translation missing --]]
--[[ L["Arazmodu <The Scale of Sands>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Arca"] = ""--]] 
--[[Translation missing --]]
--[[ L["Archmage Alturus"] = ""--]] 
L["Archmage Leryda"] = "대마법사 레리다"
--[[Translation missing --]]
--[[ L["Arinoth"] = ""--]] 
L["Artificer Morphalius"] = "기술병 몰팔리우스"
--[[Translation missing --]]
--[[ L["Attumen the Huntsman"] = ""--]] 
--[[Translation missing --]]
--[[ L["Auch"] = ""--]] 
L["Avatar of the Martyred"] = "순교자의 화신"
--[[Translation missing --]]
--[[ L["Bakkalzu"] = ""--]] 
L["Barkeep Kelly <Bartender>"] = "바텐더 켈리 <바텐더>"
L["Barnes <The Stage Manager>"] = "반즈 <무대 관리인>"
L["Baron Rafe Dreuger"] = "남작 레이프 드류거"
L["Baroness Dorothea Millstipe"] = "남작부인 도로시아 밀스타이프"
L["Bennett <The Sergeant at Arms>"] = "벤네트 <경호원>"
L["Berthold <The Doorman>"] = "베르솔드 <문지기>"
--[[Translation missing --]]
--[[ L["BF"] = ""--]] 
L["Bilger the Straight-laced"] = "엄한 빌저"
--[[Translation missing --]]
--[[ L["Blackheart the Inciter"] = ""--]] 
--[[Translation missing --]]
--[[ L["Blindeye the Seer"] = ""--]] 
--[[Translation missing --]]
--[[ L["Blood Guard Hakkuz <Darkspear Elite>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Blood Guard Porung"] = ""--]] 
--[[Translation missing --]]
--[[ L["Bortega <Reagents & Poison Supplies>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Bota"] = ""--]] 
--[[Translation missing --]]
--[[ L["Brazen"] = ""--]] 
--[[Translation missing --]]
--[[ L["Broggok"] = ""--]] 
--[[Translation missing --]]
--[[ L["Broken Stairs"] = ""--]] 
--[[Translation missing --]]
--[[ L["Brutallus"] = ""--]] 
--[[Translation missing --]]
--[[ L["BT"] = ""--]] 
--[[Translation missing --]]
--[[ L["Cache of the Legion"] = ""--]] 
L["Calliard <The Nightman>"] = "칼리아드 <야경꾼>"
L["Captain Alina"] = "대장 앨리나"
L["Captain Boneshatter"] = "대장 본쉐터"
L["Captain Edward Hanes"] = "선장 에드워드 헤인즈"
L["Captain Sanders"] = "선장 샌더스"
L["Caza'rez"] = "카자레즈"
L["Charred Bone Fragment"] = "그을린 뼈 조각"
L["Chef Jessen <Speciality Meat & Slop>"] = "주방장 예센 <고기 및 특제 요리 상인>"
--[[Translation missing --]]
--[[ L["Chess Event"] = ""--]] 
L["Clarissa"] = "클라리사"
L["Commander Mograine"] = "사령관 모그레인"
--[[Translation missing --]]
--[[ L["Commander Sarannis"] = ""--]] 
--[[Translation missing --]]
--[[ L["Connection to Master's Terrace (Nightbane)"] = ""--]] 
--[[Translation missing --]]
--[[ L["CoT"] = ""--]] 
--[[Translation missing --]]
--[[ L["CoT1"] = ""--]] 
--[[Translation missing --]]
--[[ L["CoT2"] = ""--]] 
--[[Translation missing --]]
--[[ L["CoT3"] = ""--]] 
--[[Translation missing --]]
--[[ L["CR"] = ""--]] 
L["Cryo-Engineer Sha'heen"] = "극저온 기술자 샤힌"
--[[Translation missing --]]
--[[ L["Dalliah the Doomsayer"] = ""--]] 
--[[Translation missing --]]
--[[ L["Darkheart"] = ""--]] 
--[[Translation missing --]]
--[[ L["Darkweaver Syth"] = ""--]] 
L["Dealer Tariq <Shady Dealer>"] = "무역업자 타리크 <암거래상>"
L["Dealer Vijaad"] = "무역업자 비자드"
L["Don Carlos"] = "돈 카를로스"
L["D'ore"] = "도레"
--[[Translation missing --]]
--[[ L["Dorothee"] = ""--]] 
L["Draenei Spirit"] = "드레나이 영혼"
L["Drisella"] = "드리셀라"
--[[Translation missing --]]
--[[ L["Dust Covered Chest"] = ""--]] 
L["Earthbinder Rayge"] = "대지의 결속자 레이지"
L["Ebonlocke <The Noble>"] = "이본로크 <귀족>"
L["Echo of Medivh"] = "메디브의 메아리"
L["Ellrys Duskhallow"] = "엘리스 더스크할로우"
--[[Translation missing --]]
--[[ L["Entropius"] = ""--]] 
L["Eramas Brightblaze"] = "에라마스 브라이트블레이즈"
L["Erozion"] = "에로지온"
--[[Translation missing --]]
--[[ L["Essence of Anger"] = ""--]] 
--[[Translation missing --]]
--[[ L["Essence of Desire"] = ""--]] 
--[[Translation missing --]]
--[[ L["Essence of Suffering"] = ""--]] 
L["Ethereal Transporter Control Panel"] = "에테리얼 순간이동기 제어장치"
--[[Translation missing --]]
--[[ L["Eulinda <Reagents>"] = ""--]] 
L["Exarch Larethor"] = "총독 라레소르"
--[[Translation missing --]]
--[[ L["Exarch Maladaar"] = ""--]] 
L["Fairbanks"] = "페어뱅크스"
L["Farmer Kent"] = "농부 켄트"
--[[Translation missing --]]
--[[ L["Fathom-Lord Karathress"] = ""--]] 
L["Fel Crystals"] = "지옥 수정"
--[[Translation missing --]]
--[[ L["Felmyst"] = ""--]] 
--[[Translation missing --]]
--[[ L["Fenstalker"] = ""--]] 
L["Field Commander Mahfuun"] = "야전사령관 마푼"
L["First Fragment Guardian"] = "첫 번째 조각의 수호자"
L["Fizzle"] = "피즐"
--[[Translation missing --]]
--[[ L["Forest Frogs"] = ""--]] 
L["Frances Lin <Barmaid>"] = "프란세스 린 <바텐더>"
--[[Translation missing --]]
--[[ L["Galgrom <Provisioner>"] = ""--]] 
L["Garaxxas"] = "가락사스"
--[[Translation missing --]]
--[[ L["Gatewatcher Gyro-Kill"] = ""--]] 
--[[Translation missing --]]
--[[ L["Gatewatcher Iron-Hand"] = ""--]] 
--[[Translation missing --]]
--[[ L["Gathios the Shatterer"] = ""--]] 
--[[Translation missing --]]
--[[ L["Gazakroth"] = ""--]] 
--[[Translation missing --]]
--[[ L["GL"] = ""--]] 
L["Gradav <The Warlock>"] = "그라다브 <흑마법사>"
--[[Translation missing --]]
--[[ L["Grand Astromancer Capernian"] = ""--]] 
--[[Translation missing --]]
--[[ L["Grand Warlock Alythess"] = ""--]] 
--[[Translation missing --]]
--[[ L["Grand Warlock Nethekurse"] = ""--]] 
--[[Translation missing --]]
--[[ L["Grandmaster Vorpil"] = ""--]] 
L["Greatfather Aldrimus"] = "대부 알드리머스"
--[[Translation missing --]]
--[[ L["Gruul the Dragonkiller"] = ""--]] 
L["Guerrero"] = "게레로"
L["Gunny"] = "구니"
--[[Translation missing --]]
--[[ L["Gurtogg Bloodboil"] = ""--]] 
L["Hal McAllister"] = "할 맥알리스터"
L["Ha'lei"] = "할라이"
--[[Translation missing --]]
--[[ L["Harald <Food Vendor>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Harbinger Skyriss"] = ""--]] 
L["Hastings <The Caretaker>"] = "헤이스팅스 <관리인>"
--[[Translation missing --]]
--[[ L["Hazlek"] = ""--]] 
--[[Translation missing --]]
--[[ L["HC"] = ""--]] 
L["Helcular"] = "헬쿨라"
L["Herod the Bully"] = "골목대장 헤로드"
--[[Translation missing --]]
--[[ L["High Astromancer Solarian"] = ""--]] 
--[[Translation missing --]]
--[[ L["High Botanist Freywinn"] = ""--]] 
--[[Translation missing --]]
--[[ L["High King Maulgar"] = ""--]] 
--[[Translation missing --]]
--[[ L["High Nethermancer Zerevor"] = ""--]] 
--[[Translation missing --]]
--[[ L["High Warlord Naj'entus"] = ""--]] 
L["Horvon the Armorer <Armorsmith>"] = "방어구 제작자 하본 <방어구 제작자>"
--[[Translation missing --]]
--[[ L["Hyakiss the Lurker"] = ""--]] 
--[[Translation missing --]]
--[[ L["Hydromancer Thespia"] = ""--]] 
--[[Translation missing --]]
--[[ L["Hydross the Unstable"] = ""--]] 
--[[Translation missing --]]
--[[ L["Illidan Stormrage"] = ""--]] 
L["Indormi <Keeper of Ancient Gem Lore>"] = "인도르미 <고대 보석 지식의 수호자>"
L["Innkeeper Monica"] = "여관주인 모니카"
L["Isfar"] = "이스파르"
L["Isillien"] = "이실리엔"
L["Jay Lemieux"] = "제이 레미욱스"
L["Jerry Carter"] = "제리 카터"
L["Jonathan Revah"] = "조나단 레바"
--[[Translation missing --]]
--[[ L["Julianne"] = ""--]] 
L["Julie Honeywell"] = "줄리 허니웰"
--[[Translation missing --]]
--[[ L["Kael'thas Sunstrider"] = ""--]] 
L["Kagani Nightstrike"] = "카가니 나이트스트라이크"
--[[Translation missing --]]
--[[ L["Kaldrick"] = ""--]] 
--[[Translation missing --]]
--[[ L["Kalecgos"] = ""--]] 
L["Kamsis <The Conjurer>"] = "캄시스 <창조술사>"
--[[Translation missing --]]
--[[ L["Kara"] = ""--]] 
--[[Translation missing --]]
--[[ L["Kasha"] = ""--]] 
L["Keanna's Log"] = "킨나의 기록"
--[[Translation missing --]]
--[[ L["Keli'dan the Breaker"] = ""--]] 
--[[Translation missing --]]
--[[ L["Kiggler the Crazed"] = ""--]] 
--[[Translation missing --]]
--[[ L["Kil'jaeden"] = ""--]] 
--[[Translation missing --]]
--[[ L["Kil'rek"] = ""--]] 
L["Korag Proudmane"] = "코라그 프라우드메인"
--[[Translation missing --]]
--[[ L["Koragg"] = ""--]] 
L["Koren <The Blacksmith>"] = "코렌 <대장장이>"
--[[Translation missing --]]
--[[ L["Krosh Firehand"] = ""--]] 
L["Lady Catriona Von'Indi"] = "여군주 카트리오나 본인디"
L["Lady Jaina Proudmoore"] = "여군주 제이나 프라우드무어"
L["Lady Keira Berrybuck"] = "여군주 케이라 베리벅"
--[[Translation missing --]]
--[[ L["Lady Malande"] = ""--]] 
--[[Translation missing --]]
--[[ L["Lady Sacrolash"] = ""--]] 
--[[Translation missing --]]
--[[ L["Lady Vashj"] = ""--]] 
--[[Translation missing --]]
--[[ L["Laj"] = ""--]] 
L["Lakka"] = "라카"
--[[Translation missing --]]
--[[ L["Landing Spot"] = ""--]] 
--[[Translation missing --]]
--[[ L["Lenzo"] = ""--]] 
--[[Translation missing --]]
--[[ L["Leotheras the Blind"] = ""--]] 
L["Little Jimmy Vishas"] = "꼬마 지미 비샤스"
L["Lord Crispin Ference"] = "군주 크립핀 페렌스"
--[[Translation missing --]]
--[[ L["Lord Raadan"] = ""--]] 
L["Lord Robin Daris"] = "군주 로빈 다리스"
--[[Translation missing --]]
--[[ L["Lord Sanguinar"] = ""--]] 
--[[Translation missing --]]
--[[ L["Lydia Accoste"] = ""--]] 
L["Madrigosa"] = "마드리고사"
--[[Translation missing --]]
--[[ L["Mag"] = ""--]] 
L["Magistrate Henry Maleb"] = "집정관 헨리 말레브"
--[[Translation missing --]]
--[[ L["Magtheridon"] = ""--]] 
--[[Translation missing --]]
--[[ L["Maiden of Virtue"] = ""--]] 
--[[Translation missing --]]
--[[ L["Main Chambers Access Panel"] = ""--]] 
L["Mamdy the \"Ologist\""] = "\"전문가\" 맴디"
--[[Translation missing --]]
--[[ L["Master Engineer Telonicus"] = ""--]] 
--[[Translation missing --]]
--[[ L["MaT"] = ""--]] 
--[[Translation missing --]]
--[[ L["Mawago"] = ""--]] 
--[[Translation missing --]]
--[[ L["Mech"] = ""--]] 
--[[Translation missing --]]
--[[ L["Mechano-Lord Capacitus"] = ""--]] 
--[[Translation missing --]]
--[[ L["Meeting Stone of Hellfire Citadel"] = ""--]] 
--[[Translation missing --]]
--[[ L["Meeting Stone of Magtheridon's Lair"] = ""--]] 
--[[Translation missing --]]
--[[ L["Mekgineer Steamrigger"] = ""--]] 
--[[Translation missing --]]
--[[ L["Melasong"] = ""--]] 
--[[Translation missing --]]
--[[ L["Melissa"] = ""--]] 
--[[Translation missing --]]
--[[ L["Mennu the Betrayer"] = ""--]] 
--[[Translation missing --]]
--[[ L["Micah"] = ""--]] 
--[[Translation missing --]]
--[[ L["Midnight"] = ""--]] 
L["Millhouse Manastorm"] = "밀하우스 마나스톰"
--[[Translation missing --]]
--[[ L["Monk"] = ""--]] 
--[[Translation missing --]]
--[[ L["Moroes"] = ""--]] 
--[[Translation missing --]]
--[[ L["Morogrim Tidewalker"] = ""--]] 
L["Mortog Steamhead"] = "모르토그 스팀헤드"
--[[Translation missing --]]
--[[ L["Mother Shahraz"] = ""--]] 
--[[Translation missing --]]
--[[ L["MT"] = ""--]] 
--[[Translation missing --]]
--[[ L["Murmur"] = ""--]] 
--[[Translation missing --]]
--[[ L["M'uru"] = ""--]] 
--[[Translation missing --]]
--[[ L["Mysterious Bookshelf"] = ""--]] 
L["Nahuud"] = "나후우드"
L["Nat Pagle"] = "내트 페이글"
L["Nathanos Marris"] = "나타노스 매리스"
L["Naturalist Bite"] = "식물학자 바이트"
--[[Translation missing --]]
--[[ L["Nazan"] = ""--]] 
--[[Translation missing --]]
--[[ L["Nethermancer Sepethrea"] = ""--]] 
--[[Translation missing --]]
--[[ L["Netherspite"] = ""--]] 
L["Nexus-Prince Haramad"] = "연합왕자 하라매드"
--[[Translation missing --]]
--[[ L["Nexus-Prince Shaffar"] = ""--]] 
--[[Translation missing --]]
--[[ L["Nightbane"] = ""--]] 
--[[Translation missing --]]
--[[ L["Norkani"] = ""--]] 
--[[Translation missing --]]
--[[ L["Nozari <Keepers of Time>"] = ""--]] 
L["Okuno <Ashtongue Deathsworn Quartermaster>"] = "오쿠노 <잿빛혓바닥 결사단 병참장교>"
--[[Translation missing --]]
--[[ L["Olm the Summoner"] = ""--]] 
--[[Translation missing --]]
--[[ L["Omor the Unscarred"] = ""--]] 
--[[Translation missing --]]
--[[ L["Opera Hall"] = ""--]] 
L["Overcharged Manacell"] = "과충전된 마나저장소"
L["Overwatch Mark 0 <Protector>"] = "망꾼 0호 <경호원>"
--[[Translation missing --]]
--[[ L["Pandemonius"] = ""--]] 
--[[Translation missing --]]
--[[ L["Path to the Broken Stairs"] = ""--]] 
--[[Translation missing --]]
--[[ L["Path to the Hellfire Ramparts and Shattered Halls"] = ""--]] 
--[[Translation missing --]]
--[[ L["Pathaleon the Calculator"] = ""--]] 
--[[Translation missing --]]
--[[ L["Phin Odelic <The Kirin Tor>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Priestess Delrissa"] = ""--]] 
--[[Translation missing --]]
--[[ L["Prince Malchezaar"] = ""--]] 
--[[Translation missing --]]
--[[ L["Private Jacint"] = ""--]] 
--[[Translation missing --]]
--[[ L["Provisioner Tsaalt"] = ""--]] 
--[[Translation missing --]]
--[[ L["Quagmirran"] = ""--]] 
--[[Translation missing --]]
--[[ L["Raleigh the True"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ramdor the Mad"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ramp"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ramp down to the Gamesman's Hall"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ramp from Mezzanine to Balcony"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ramp to Guardian's Library"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ramp to Medivh's Chamber"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ramp to the Guest Chambers (Maiden)"] = ""--]] 
--[[Translation missing --]]
--[[ L["Ramp up to the Celestial Watch"] = ""--]] 
--[[Translation missing --]]
--[[ L["Randy Whizzlesprocket"] = ""--]] 
--[[Translation missing --]]
--[[ L["Red Riding Hood"] = ""--]] 
--[[Translation missing --]]
--[[ L["Reinforced Fel Iron Chest"] = ""--]] 
--[[Translation missing --]]
--[[ L["Reliquary of Souls"] = ""--]] 
--[[Translation missing --]]
--[[ L["Relissa"] = ""--]] 
--[[Translation missing --]]
--[[ L["Renault Mograine"] = ""--]] 
--[[Translation missing --]]
--[[ L["Rifleman Brownbeard"] = ""--]] 
--[[Translation missing --]]
--[[ L["Roar"] = ""--]] 
--[[Translation missing --]]
--[[ L["Rokad the Ravager"] = ""--]] 
--[[Translation missing --]]
--[[ L["Rokmar the Crackler"] = ""--]] 
--[[Translation missing --]]
--[[ L["Romulo"] = ""--]] 
--[[Translation missing --]]
--[[ L["Romulo & Julianne"] = ""--]] 
--[[Translation missing --]]
--[[ L["Rosa"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sa'at <Keepers of Time>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sally Whitemane"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sathrovarr the Corruptor"] = ""--]] 
--[[Translation missing --]]
--[[ L["Scout Orgarr"] = ""--]] 
--[[Translation missing --]]
--[[ L["Scrying Orb"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sebastian <The Organist>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Second Fragment Guardian"] = ""--]] 
--[[Translation missing --]]
--[[ L["Seer Kanai"] = ""--]] 
--[[Translation missing --]]
--[[ L["Seer Olum"] = ""--]] 
--[[Translation missing --]]
--[[ L["Selin Fireheart"] = ""--]] 
--[[Translation missing --]]
--[[ L["Servant Quarters"] = ""--]] 
--[[Translation missing --]]
--[[ L["Seth"] = ""--]] 
--[[Translation missing --]]
--[[ L["SH"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shade of Akama"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shade of Aran"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shadikith the Glider"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shadow Lord Xiraxis"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shattered Hand Executioner"] = ""--]] 
--[[Translation missing --]]
--[[ L["Shirrak the Dead Watcher"] = ""--]] 
--[[Translation missing --]]
--[[ L["Skar'this the Heretic"] = ""--]] 
--[[Translation missing --]]
--[[ L["SL"] = ""--]] 
--[[Translation missing --]]
--[[ L["Slither"] = ""--]] 
--[[Translation missing --]]
--[[ L["Sliver <Garaxxas' Pet>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Soridormi <The Scale of Sands>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Southshore Inn"] = ""--]] 
--[[Translation missing --]]
--[[ L["SP"] = ""--]] 
--[[Translation missing --]]
--[[ L["Spiral Stairs to Netherspace"] = ""--]] 
--[[Translation missing --]]
--[[ L["Spirit of Olum"] = ""--]] 
--[[Translation missing --]]
--[[ L["Spirit of Udalo"] = ""--]] 
--[[Translation missing --]]
--[[ L["Spy Grik'tha"] = ""--]] 
--[[Translation missing --]]
--[[ L["Spy To'gun"] = ""--]] 
--[[Translation missing --]]
--[[ L["SSC"] = ""--]] 
--[[Translation missing --]]
--[[ L["Staircase to the Ballroom (Moroes)"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stairs to Opera House Orchestra Level"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stairs to Underground Pond"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stairs to Underground Well"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stairs to Upper Stable"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stalvan Mistmantle"] = ""--]] 
--[[Translation missing --]]
--[[ L["Steps and path to the Blood Furnace"] = ""--]] 
--[[Translation missing --]]
--[[ L["Steward of Time <Keepers of Time>"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stone Guard Stok'ton"] = ""--]] 
--[[Translation missing --]]
--[[ L["Strawman"] = ""--]] 
--[[Translation missing --]]
--[[ L["SuP"] = ""--]] 
--[[Translation missing --]]
--[[ L["Supremus"] = ""--]] 
--[[Translation missing --]]
--[[ L["SV"] = ""--]] 
--[[Translation missing --]]
--[[ L["Taelan"] = ""--]] 
--[[Translation missing --]]
--[[ L["Talon King Ikiss"] = ""--]] 
--[[Translation missing --]]
--[[ L["Taretha"] = ""--]] 
--[[Translation missing --]]
--[[ L["Tavarok"] = ""--]] 
--[[Translation missing --]]
--[[ L["Terestian Illhoof"] = ""--]] 
--[[Translation missing --]]
--[[ L["Teron Gorefiend"] = ""--]] 
--[[Translation missing --]]
--[[ L["Thaladred the Darkener"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Big Bad Wolf"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Codex of Blood"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Crone"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Curator"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Eredar Twins"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Illidari Council"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Lurker Below"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Maker"] = ""--]] 
--[[Translation missing --]]
--[[ L["The Map of Zul'Aman"] = ""--]] 
L["The Master's Terrace"] = "주인의 테라스"
L["The Saga of Terokk"] = "테로크의 전설"
L["The Underspore"] = "쉬슬리스의 방주"
L["Third Fragment Guardian"] = "세 번째 조각의 수호자"
L["Thomas Yance <Travelling Salesman>"] = "토마스 얀스 <여행 중인 선원>"
--[[Translation missing --]]
--[[ L["Thorngrin the Tender"] = ""--]] 
L["Thrall"] = "스랄"
L["Thrall <Warchief>"] = "스랄 <대족장>"
--[[Translation missing --]]
--[[ L["Thurg"] = ""--]] 
--[[Translation missing --]]
--[[ L["Tinhead"] = ""--]] 
--[[Translation missing --]]
--[[ L["Tito"] = ""--]] 
--[[Translation missing --]]
--[[ L["TK"] = ""--]] 
L["Tormented Soulpriest"] = "고통받는 영혼사제"
--[[Translation missing --]]
--[[ L["Towards Illidan Stormrage"] = ""--]] 
--[[Translation missing --]]
--[[ L["Towards Reliquary of Souls"] = ""--]] 
--[[Translation missing --]]
--[[ L["Towards Teron Gorefiend"] = ""--]] 
L["T'shu"] = "트슈"
L["Tydormu <Keeper of Lost Artifacts>"] = "타이도르무 <잃어버린 유물의 수호자>"
--[[Translation missing --]]
--[[ L["Tyllan"] = ""--]] 
L["Tyrande Whisperwind <High Priestess of Elune>"] = "티란데 위스퍼윈드 <엘룬의 대여사제>"
L["Tyrith"] = "티리스"
--[[Translation missing --]]
--[[ L["UB"] = ""--]] 
L["Udalo"] = "우달로"
--[[Translation missing --]]
--[[ L["Vazruden the Herald"] = ""--]] 
--[[Translation missing --]]
--[[ L["Veras Darkshadow"] = ""--]] 
--[[Translation missing --]]
--[[ L["Vexallus"] = ""--]] 
--[[Translation missing --]]
--[[ L["Void Reaver"] = ""--]] 
--[[Translation missing --]]
--[[ L["Vol'jin"] = ""--]] 
--[[Translation missing --]]
--[[ L["Voodoo Pile"] = ""--]] 
--[[Translation missing --]]
--[[ L["Warbringer O'mrogg"] = ""--]] 
--[[Translation missing --]]
--[[ L["Warchief Kargath Bladefist"] = ""--]] 
--[[Translation missing --]]
--[[ L["Warden Mellichar"] = ""--]] 
--[[Translation missing --]]
--[[ L["Warlord Kalithresh"] = ""--]] 
L["Warlord Salaris"] = "장군 살라리스"
--[[Translation missing --]]
--[[ L["Warp Splinter"] = ""--]] 
L["Watcher Jhang"] = "감시자 쟝"
--[[Translation missing --]]
--[[ L["Watchkeeper Gargolmar"] = ""--]] 
L["Weeder Greenthumb"] = "약초학자 그린썸"
L["Windcaller Claw"] = "바람소환사 클로"
--[[Translation missing --]]
--[[ L["Witch Doctor T'wansi"] = ""--]] 
L["Wizard of Oz"] = "오즈의 마법사"
--[[Translation missing --]]
--[[ L["Wrath-Scryer Soccothrates"] = ""--]] 
L["Wravien <The Mage>"] = "레비엔 <마법사>"
--[[Translation missing --]]
--[[ L["Yarley <Armorer>"] = ""--]] 
L["Yazzai"] = "야자이"
--[[Translation missing --]]
--[[ L["Yor"] = ""--]] 
L["Young Blanchy"] = "망아지 블랑쉬"
L["Ythyar"] = "이스야르"
--[[Translation missing --]]
--[[ L["Zaladormu"] = ""--]] 
L["Zelfan"] = "젤판"
--[[Translation missing --]]
--[[ L["Zereketh the Unbound"] = ""--]] 
L["Zixil <Aspiring Merchant>"] = "직실 <야심찬 상인>"
--[[Translation missing --]]
--[[ L["Zungam"] = ""--]] 

end
