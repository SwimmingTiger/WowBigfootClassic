local Gladius = _G.Gladius
if not Gladius then
	DEFAULT_CHAT_FRAME:AddMessage(format("Module %s requires Gladius", "Class Icon"))
end
local L = Gladius.L
local LSM

-- Global Functions
local _G = _G
local pairs = pairs
local select = select
local strfind = string.find
local tonumber = tonumber
local tostring = tostring
local unpack = unpack

local CreateFrame = CreateFrame
local GetSpecializationInfoByID = GetSpecializationInfoByID
local GetSpellInfo = GetSpellInfo
local GetTime = GetTime
local UnitAura = UnitAura

local CLASS_BUTTONS = CLASS_ICON_TCOORDS

local IsClassic = WOW_PROJECT_ID >= WOW_PROJECT_CLASSIC

local function GetDefaultAuraList()
	local auraTable = {
		-- Higher Number is More Priority
		[GetSpellInfo(167152) or ""]   = 10,    -- Refreshment
		[GetSpellInfo(118358) or ""]   = 10,    -- Drink
		[GetSpellInfo(1784) or ""]     = 10,    -- Stealth
		[GetSpellInfo(5215) or ""]     = 10,    -- Prowl
		["198158"]               = 10.3,  -- Mass Invisibility
		[GetSpellInfo(215769) or ""]   = 10,    -- Spirit of the Redeemer
		[GetSpellInfo(45438) or ""]    = 10,    -- Ice Block
		["45182"]                = 10,    -- Cheating Death
		["116888"]               = 10,    -- Purgatory
		[GetSpellInfo(269513) or ""]   = 10,    -- Death from Above
		[GetSpellInfo(46924) or ""]    = 10,    -- Bladestorm fury
		[GetSpellInfo(227847) or ""]   = 10,    -- Bladestorm arms
		[GetSpellInfo(47585) or ""]    = 10,    -- Dispersion
		[GetSpellInfo(642) or ""]      = 10,    -- Divine Shield
		[GetSpellInfo(228050) or ""]   = 10.1,  -- Prot pala Party Bubble
		[GetSpellInfo(210918) or ""]   = 10,    -- Ethereal Form
		[GetSpellInfo(27827) or ""]    = 10,    -- Spirit of Redemption
		[GetSpellInfo(186265) or ""]   = 10,    -- Aspect of the Turtle
		[GetSpellInfo(196555) or ""]   = 10,    -- Netherwalk
		[GetSpellInfo(58984) or ""]    = 10,    -- Shadowmeld

		[GetSpellInfo(2094) or ""]      = 9.1,  -- Blind
		[GetSpellInfo(202274) or ""]    = 9.1,  -- Brew Breath
		[GetSpellInfo(207167) or ""]    = 9,    -- Blinding Sleet
		[GetSpellInfo(33786) or ""]     = 9.1,  -- Cyclone
		["221527"]                = 9.1,  -- Imprison talented
		[GetSpellInfo(605) or ""]       = 9,    -- Mind Control
		[GetSpellInfo(118699) or ""]    = 9,    -- Fear
		["226943"]                = 9,    -- Mind Bomb disorient
		[GetSpellInfo(236748) or ""]    = 9,    -- disorienting roar
		[GetSpellInfo(2637) or ""]      = 9,    -- Hibernate
		[GetSpellInfo(3355) or ""]      = 9.1,  -- Freezing Trap
		[GetSpellInfo(203337) or ""]    = 9.1,  -- Freezing Trap (talented)
		[GetSpellInfo(51514) or ""]     = 9,    -- Hex
		[GetSpellInfo(211004) or ""]    = 9,    -- Hex
		[GetSpellInfo(210873) or ""]    = 9,    -- Hex
		[GetSpellInfo(211015) or ""]    = 9,    -- Hex
		[GetSpellInfo(211010) or ""]    = 9,    -- Hex
		[GetSpellInfo(277784) or ""]    = 9,    -- Hex
		[GetSpellInfo(277778) or ""]    = 9,    -- Hex
		[GetSpellInfo(269352) or ""]    = 9,    -- Hex
		[GetSpellInfo(5246) or ""]      = 9,    -- Intimidating Shout
		[GetSpellInfo(6789) or ""]      = 9,    -- Mortal Coil
		[GetSpellInfo(118) or ""]       = 9,    -- Polymorph
		[GetSpellInfo(277787) or ""]    = 9,    -- Polymorph direhorn
		[GetSpellInfo(277792) or ""]    = 9,    -- Polymorph bumblebee
		[GetSpellInfo(28272) or ""]     = 9,    -- Polymorph pig
		[GetSpellInfo(61305) or ""]     = 9,    -- Polymorph black cat
		[GetSpellInfo(61721) or ""]     = 9,    -- Polymorph rabbit
		[GetSpellInfo(161372) or ""]    = 9,    -- Polymorph peacock
		[GetSpellInfo(28271) or ""]     = 9,    -- Polymorph turtle
		[GetSpellInfo(161355) or ""]    = 9,    -- Polymorph penguin
		[GetSpellInfo(61780) or ""]     = 9,    -- Polymorph turkey
		[GetSpellInfo(126819) or ""]    = 9,    -- Polymorph porcupine
		[GetSpellInfo(161353) or ""]    = 9,    -- Polymorph bear cup
		[GetSpellInfo(161354) or ""]    = 9,    -- Polymorph monkey
		[GetSpellInfo(105421) or ""]    = 9,    -- Blinding Light
		[GetSpellInfo(213691) or ""]    = 9,    -- Scatter Shot
		[GetSpellInfo(8122) or ""]      = 9,    -- Psychic Scream
		[GetSpellInfo(20066) or ""]     = 9,    -- Repentance
		[GetSpellInfo(82691) or ""]     = 9,    -- Ring of Frost
		[GetSpellInfo(6770) or ""]      = 9.1,  -- Sap
		[GetSpellInfo(107079) or ""]    = 9,    -- Quaking Palm
		[GetSpellInfo(6358) or ""]      = 9,    -- Seduction (Succubus)
		[GetSpellInfo(261589) or ""]    = 9,    -- Seduction (Player)
		[GetSpellInfo(1776) or ""]      = 9,    -- Gouge
		[GetSpellInfo(31661) or ""]     = 9,    -- Dragon's Breath

		[GetSpellInfo(207685) or ""]    = 8,    -- Sigil of Misery Disorient
		[GetSpellInfo(198909) or ""]    = 8,    -- Song of Chi-Ji
		[GetSpellInfo(221562) or ""]    = 8,    -- Asphyxiate blood
		[GetSpellInfo(108194) or ""]    = 8,    -- Asphyxiate frost/unholy
		[GetSpellInfo(210141) or ""]    = 8,    -- Zombie Explosion
		[GetSpellInfo(91797) or ""]     = 8,    -- transformed Gnaw
		[GetSpellInfo(91800) or ""]     = 8,    -- untransformed Gnaw
		[GetSpellInfo(89766) or ""]     = 8,    -- Axe Toss (Felguard)
		[GetSpellInfo(24394) or ""]     = 8,    -- Intimidation
		[GetSpellInfo(202244) or ""]    = 8,    -- Overrun bear stun
		[GetSpellInfo(1833) or ""]      = 8,    -- Cheap Shot
		[GetSpellInfo(205630) or ""]    = 8,    -- Illidan's Grasp 1
		[GetSpellInfo(208618) or ""]    = 8,    -- Illidan's Grasp 2
		[GetSpellInfo(213491) or ""]    = 8,    -- Demonic Trample knockdown
		[GetSpellInfo(199804) or ""]    = 8,    -- Between the Eyes
		[GetSpellInfo(235612) or ""]    = 8,    -- Frost DK stun
		[GetSpellInfo(287254) or ""]    = 8,    -- Remorseless Winter stun
		["77505"]                 = 8,    -- Earthquake
		[GetSpellInfo(213688) or ""]    = 8,    -- Fel Cleave
		[GetSpellInfo(853) or ""]       = 8,    -- Hammer of Justice
		[GetSpellInfo(200196) or ""]    = 8,    -- Holy Word: Chastise
		[GetSpellInfo(408) or ""]       = 8,    -- Kidney Shot
		[GetSpellInfo(202346) or ""]    = 8,    -- Keg Stun
		[GetSpellInfo(200200) or ""]    = 8,    -- Holy Word: Chastise
		[GetSpellInfo(119381) or ""]    = 8.2,  -- Leg Sweep
		[GetSpellInfo(179057) or ""]    = 8.1,  -- Chaos Nova
		[GetSpellInfo(211881) or ""]    = 8,    -- Fel Eruption
		[GetSpellInfo(204399) or ""]    = 8,    -- Earthfury
		[GetSpellInfo(255723) or ""]    = 8,    -- Bull Rush
		[GetSpellInfo(204437) or ""]    = 8,    -- Lightning Lasso
		[GetSpellInfo(197214) or ""]    = 8,    -- Sundering
		[GetSpellInfo(203123) or ""]    = 8,    -- Maim stun
		[GetSpellInfo(64044) or ""]     = 8,    -- Psychic Horror
		[GetSpellInfo(199085) or ""]    = 8,    -- Heroic Leap Stun
		[GetSpellInfo(5211) or ""]      = 8,    -- Mighty Bash
		[GetSpellInfo(118345) or ""]    = 8,    -- Pulverize (Primal Earth Elemental)
		[GetSpellInfo(30283) or ""]     = 8,    -- Shadowfury
		[GetSpellInfo(22703) or ""]     = 8,    -- Summon Infernal stun
		[GetSpellInfo(132168) or ""]    = 8,    -- Shockwave
		[GetSpellInfo(118905) or ""]    = 8,    -- Lightning Surge Totem
		[GetSpellInfo(132169) or ""]    = 8,    -- Storm Bolt
		[GetSpellInfo(20549) or ""]     = 8,    -- War Stomp
		[GetSpellInfo(87204) or ""]     = 8,    -- Sin and Punishment
		["117526"]                = 8,    -- Binding Shot
		["163505"]                = 8,    -- Rake stun
		[GetSpellInfo(48792) or ""]     = 8,    -- Icebound Fortitude
		[GetSpellInfo(287081) or ""]    = 8,    -- Lichborne
		[GetSpellInfo(115078) or ""]    = 8.1,  -- Paralysis
		["217832"]                = 8,    -- Imprison
		[GetSpellInfo(236025) or ""]    = 8,    -- Enraged Maim incap

		[GetSpellInfo(104773) or ""]    = 7.5,  -- Unending Resolve affli/demo/destro
		["77606"]                 = 7.4,  -- Dark Simulacrum
		["122470"]                = 7,    -- Touch of Karma debuff
		["125174"]                = 7,    -- Touch of Karma buff
		[GetSpellInfo(5277) or ""]      = 7.4,  -- Evasion
		[GetSpellInfo(213602) or ""]    = 7.4,  -- Greater Fade
		[GetSpellInfo(199027) or ""]    = 7.2,  -- Evasion2 post stealth
		[GetSpellInfo(199754) or ""]    = 7.3,  -- Riposte
		[GetSpellInfo(198144) or ""]    = 7.3,  -- Ice Form
		[GetSpellInfo(188499) or ""]    = 7.3,  -- Blade Dance
		[GetSpellInfo(210152) or ""]    = 7.3,  -- Death Sweep
		[GetSpellInfo(212800) or ""]    = 7.2,  -- Blur
		[GetSpellInfo(209426) or ""]    = 7.1,  -- Darkness
		["6940"]                  = 7.2,  -- Blessing of Sacrifice
		["199448"]                = 7.2,  -- Blessing of Sacrifice
		[GetSpellInfo(1022) or ""]      = 7.4,  -- Hand of Protection
		[GetSpellInfo(18499) or ""]     = 7.3,  -- Berserker Rage
		[GetSpellInfo(212704) or ""]    = 7.3,  -- The Beast Within
		["196364"]                = 7,    -- Unstable Affliction silence
		[GetSpellInfo(1330) or ""]      = 7,    -- Garrote (Silence)
		[GetSpellInfo(15487) or ""]     = 7,    -- Silence
		[GetSpellInfo(204490) or ""]    = 7,    -- Sigil of Silence
		[GetSpellInfo(217824) or ""]    = 7,    -- Prot Pala Silence
		[GetSpellInfo(236077) or ""]    = 7,    -- War Disarm
		[GetSpellInfo(207777) or ""]    = 7,    -- Dismantle
		[GetSpellInfo(233759) or ""]    = 7,    -- Grapple Weapon
		[GetSpellInfo(209749) or ""]    = 7,    -- Faerie Swarm disarm
		["202933"]                = 7,    -- Spider Sting
		[GetSpellInfo(47476) or ""]     = 7.5,  -- Strangulate
		[GetSpellInfo(81261) or ""]     = 7,    -- Solar Beam

		[GetSpellInfo(8178) or ""]      = 6.3,  -- Grounding Totem Effect
		[GetSpellInfo(91807) or ""]     = 6,    -- Shambling Rush (Ghoul)
		["116706"]                = 6,    -- Disable
		[GetSpellInfo(157997) or ""]    = 6,    -- Ice Nova
		[GetSpellInfo(228600) or ""]    = 6,    -- Glacial Spike
		[GetSpellInfo(198121) or ""]    = 6,    -- Frostbite
		[GetSpellInfo(233395) or ""]    = 6,    -- Frozen Center
		[GetSpellInfo(64695) or ""]     = 6,    -- Earthgrab Totem
		[GetSpellInfo(233582) or ""]    = 6,    -- Destro root
		[GetSpellInfo(285515) or ""]    = 6,    -- Frost Shock root (talent)
		[GetSpellInfo(339) or ""]       = 6,    -- Entangling Roots
		["162480"]                = 6,    -- Steel Trap root
		[GetSpellInfo(235963) or ""]    = 6,    -- Entangling Roots undispellable
		[GetSpellInfo(170855) or ""]    = 6,    -- Ironbark Entangling Roots
		[GetSpellInfo(45334) or ""]     = 6,    -- Immobilized (Wild Charge - Bear)
		[GetSpellInfo(33395) or ""]     = 6,    -- Freeze (Water Elemental)
		[GetSpellInfo(122) or ""]       = 6,    -- Frost Nova
		[GetSpellInfo(102359) or ""]    = 6,    -- Mass Entanglement
		[GetSpellInfo(190927) or ""]    = 6,    -- Harpoon
		["212638"]                = 6,    -- Tracker's Net (miss atks)
		[GetSpellInfo(105771) or ""]    = 6,    -- Charge root
		["204085"]                = 6,    -- Deathchill root

		["198222"]                = 5.9,  -- System Shock 90% slow
		[GetSpellInfo(48707) or ""]     = 5.2,  -- Anti-Magic Shell
		[GetSpellInfo(204018) or ""]    = 5.3,  -- Magic Bop
		[GetSpellInfo(212295) or ""]    = 5.2,  -- Nether Ward
		[GetSpellInfo(221705) or ""]    = 5.1,  -- Casting Circle
		[GetSpellInfo(234084) or ""]    = 5.1,  -- Boomy 70% kick reduc
		[GetSpellInfo(196773) or ""]    = 5.1,  -- inner focus
		[GetSpellInfo(290641) or ""]    = 5.1,  -- Ancestral Gift
		[GetSpellInfo(289655) or ""]    = 5.1,  -- Holy Word: Concentration
		[GetSpellInfo(209584) or ""]    = 5.1,  -- Zen Focus Tea
		[GetSpellInfo(116849) or ""]    = 5,    -- Life Cocoon
		[GetSpellInfo(110960) or ""]    = 5.1,  -- Greater Invisibility
		[GetSpellInfo(113862) or ""]    = 5,    -- Greater Invisibility
		[GetSpellInfo(108271) or ""]    = 5,    -- Astral Shift
		[GetSpellInfo(22812) or ""]     = 5,    -- Barkskin
		[GetSpellInfo(871) or ""]       = 5,    -- Shield Wall
		[GetSpellInfo(232707) or ""]    = 5.4,  -- Ray of Hope
		[GetSpellInfo(31224) or ""]     = 5.3,  -- Cloak of Shadows
		[GetSpellInfo(118038) or ""]    = 5.1,  -- Die by the Sword
		[GetSpellInfo(227744) or ""]    = 5,    -- Ravager parry
		[GetSpellInfo(81256) or ""]     = 5,    -- Dancing Rune weapon
		[GetSpellInfo(498) or ""]       = 5,    -- Divine Protection
		[GetSpellInfo(236321) or ""]    = 5,    -- War Banner
		[GetSpellInfo(199507) or ""]    = 5,    -- Spreading The Word: Protection
		[GetSpellInfo(205191) or ""]    = 5.1,  -- Eye for an Eye
		[GetSpellInfo(47788) or ""]     = 5,    -- Guardian Spirit
		[GetSpellInfo(207498) or ""]    = 5,    -- Ancestral Protection Totem
		[GetSpellInfo(66) or ""]        = 5,    -- Invisibility
		[GetSpellInfo(32612) or ""]     = 5,    -- Invisibility
		[GetSpellInfo(102342) or ""]    = 5,    -- Ironbark
		[GetSpellInfo(199038) or ""]    = 5,    -- Intercept 90% dmg reduc
		[GetSpellInfo(202748) or ""]    = 5,    -- survival tactics
		[GetSpellInfo(210256) or ""]    = 5,    -- Blessing of Sanctuary
		[GetSpellInfo(213610) or ""]    = 5,    -- Holy Ward
		[GetSpellInfo(122783) or ""]    = 5.1,  -- Diffuse Magic
		[GetSpellInfo(33206) or ""]     = 5,    -- Pain Suppression
		[GetSpellInfo(53480) or ""]     = 5,    -- Roar of Sacrifice
		[GetSpellInfo(192081) or ""]    = 5,    -- Ironfur
		[GetSpellInfo(31850) or ""]     = 5,    -- Ardent Defender
		[GetSpellInfo(86659) or ""]     = 5.3,  -- Prot Pala Wall
		[GetSpellInfo(184364) or ""]    = 5,    -- Enraged Regeneration
		[GetSpellInfo(207736) or ""]    = 5,    -- Shadowy Duel
		[GetSpellInfo(236273) or ""]    = 5,    -- Duel
		[GetSpellInfo(207756) or ""]    = 5,    -- Shadowy Duel
		[GetSpellInfo(210294) or ""]    = 5,    -- Divine Favor
		[GetSpellInfo(198111) or ""]    = 5,    -- Temporal Shield
		[GetSpellInfo(23920) or ""]     = 5.1,  -- Spell Reflection
		[GetSpellInfo(213915) or ""]    = 5.1,  -- Mass Spell Reflection
		[GetSpellInfo(147833) or ""]    = 5.2,  -- Intercepted Spell Redirect
		[GetSpellInfo(202248) or ""]    = 5.1,  -- zen meditation
		[GetSpellInfo(248519) or ""]    = 5.1,  -- Interlope (bm pet redirect)
		[GetSpellInfo(61336) or ""]     = 5,    -- Survival Instincts

		[GetSpellInfo(206803) or ""]    = 4.1,  -- Rain from Above
		[GetSpellInfo(206804) or ""]    = 4,    -- Rain from Above
		[GetSpellInfo(1044) or ""]      = 4,    -- Blessing of Freedom
		[GetSpellInfo(290500) or ""]    = 4,    -- Wind Waker
		[GetSpellInfo(199545) or ""]    = 4,    -- Steed of Glory
		[GetSpellInfo(48265) or ""]     = 4,    -- Death's Advance
		[GetSpellInfo(201447) or ""]    = 4,    -- Ride the Wind
		[GetSpellInfo(256948) or ""]    = 4,    -- Spatial Rift
		[GetSpellInfo(213664) or ""]    = 4,    -- Nimble Brew
		[GetSpellInfo(197003) or ""]    = 4,    -- Maneuverability
		[GetSpellInfo(198065) or ""]    = 4,    -- Prismatic Cloak
		[GetSpellInfo(54216) or ""]     = 4,    -- Master's Call
		[GetSpellInfo(115192) or ""]    = 4.1,  -- Subterfuge
		[GetSpellInfo(11327) or ""]     = 4,    -- Vanish

		[GetSpellInfo(12042) or ""]     = 3,    -- Arcane Power
		[GetSpellInfo(29166) or ""]     = 3,    -- Innervate
		[GetSpellInfo(114050) or ""]    = 3,    -- Ascendance ele
		[GetSpellInfo(208997) or ""]    = 3.1,  -- Counterstrike Totem
		["236696"]                = 3.1,  -- Thorns boomy/feral
		[GetSpellInfo(114051) or ""]    = 3,    -- Ascendance enha
		[GetSpellInfo(114052) or ""]    = 3,    -- Ascendance resto
		[GetSpellInfo(47536) or ""]     = 3.1,  -- Rapture
		[GetSpellInfo(198760) or ""]    = 3,    -- Intercept 30% dmg reduc
		[GetSpellInfo(231895) or ""]    = 3,    -- Crusade
		[GetSpellInfo(194249) or ""]    = 3,    -- Voidform
		[GetSpellInfo(204362) or ""]    = 3.3,  -- Heroism
		[GetSpellInfo(204361) or ""]    = 3.3,  -- Bloodlust
		[GetSpellInfo(12472) or ""]     = 3,    -- Icy Veins
		[GetSpellInfo(51690) or ""]     = 3.1,  -- Killing Spree
		[GetSpellInfo(33891) or ""]     = 3.1,  -- Incarnation: Treeform
		[GetSpellInfo(117679) or ""]    = 3,    -- Incarnation: Tree of Life
		[GetSpellInfo(102560) or ""]    = 3,    -- Incarnation: Chosen of Elune
		[GetSpellInfo(102543) or ""]    = 3,    -- Incarnation: King of the Jungle
		[GetSpellInfo(102558) or ""]    = 3,    -- Incarnation: Son of Ursoc
		[GetSpellInfo(19574) or ""]     = 3,    -- Bestial Wrath
		[GetSpellInfo(190319) or ""]    = 3,    -- Combustion
		[GetSpellInfo(266779) or ""]    = 3,    -- Coordinated Assault
		[GetSpellInfo(1719) or ""]      = 3,    -- Recklessness
		[GetSpellInfo(194223) or ""]    = 3,    -- Celestial Alignment
		["191427"]                = 3,    -- Metamorphosis talented
		["162264"]                = 3,    -- Metamorphosis
		["187827"]                = 3,    -- Metamorphosis (tank)
		[GetSpellInfo(152173) or ""]    = 3,    -- Serenity

		[GetSpellInfo(185422) or ""]    = 2.3,  -- Shadow Dance
		[GetSpellInfo(121471) or ""]    = 2.2,  -- Shadow Blades
		[GetSpellInfo(197871) or ""]    = 2.5,  -- Dark Archangel
		[GetSpellInfo(79140) or ""]     = 2.3,  -- Vendetta
		["198529"]                = 2.3,  -- Plunder Armor
		[GetSpellInfo(51271) or ""]     = 2.1,  -- Pillar of Frost
		[GetSpellInfo(107574) or ""]    = 2.1,  -- Avatar
		[GetSpellInfo(13750) or ""]     = 2.1,  -- Adrenaline Rush
		[GetSpellInfo(201318) or ""]    = 2.1,  -- Fortifying Brew (WW)
		[GetSpellInfo(243435) or ""]    = 2.1,  -- Fortifying Brew (MW)
		[GetSpellInfo(120954) or ""]    = 2.1,  -- Fortifying Brew (BM)
		[GetSpellInfo(55233) or ""]     = 2.2,  -- Vampiric Blood
		[GetSpellInfo(31884) or ""]     = 2.1,  -- Avenging Wrath
		[GetSpellInfo(207289) or ""]    = 2.1,  -- unholy frenzy
		[GetSpellInfo(216331) or ""]    = 2.1,  -- Avenging Crusader
		[GetSpellInfo(116014) or ""]    = 2,    -- Rune of Power
		[GetSpellInfo(1966) or ""]      = 2.1,  -- Feint
		[GetSpellInfo(288977) or ""]    = 2.1,  -- Transfusion
		[GetSpellInfo(213871) or ""]    = 2.1,  -- Bodyguard
		[GetSpellInfo(223658) or ""]    = 2.2,  -- Safeguard dmg reduc
		[GetSpellInfo(202162) or ""]    = 2.2,  -- Guard
		[GetSpellInfo(201633) or ""]    = 2.2,  -- Earthen Totem
		[GetSpellInfo(122278) or ""]    = 2.2,  -- Dampen Harm
		[GetSpellInfo(207498) or ""]    = 2.1,  -- Ancestral Protection
		[GetSpellInfo(206649) or ""]    = 2,    -- Eye of Leotheras

		[GetSpellInfo(116095) or ""]    = 1.1,  -- Disable
		[GetSpellInfo(221886) or ""]    = 1.1,  -- Divine Steed
		[GetSpellInfo(116841) or ""]    = 1,    -- Tiger's Lust
		[GetSpellInfo(286349) or ""]    = 1,    -- Gladiator's Maledict
		["286342"]                = 1,    -- Gladiator's Safeguard
		[GetSpellInfo(277187) or ""]    = 1,    -- Gladiator's Emblem
		[GetSpellInfo(97463) or ""]     = 1,    -- Rallying Cry
		[GetSpellInfo(12975) or ""]     = 1.3,  -- Last Stand
		[GetSpellInfo(202900) or ""]    = 1.3,  -- scorpid sting
		[GetSpellInfo(212552) or ""]    = 1.1,  -- Wraith Walk
		[GetSpellInfo(188501) or ""]    = 1,    -- Spectral Sight
		[GetSpellInfo(5384) or ""]      = 1,    -- Feign Death
		[GetSpellInfo(145629) or ""]    = 1,    -- Anti-Magic Zone
		[GetSpellInfo(81782) or ""]     = 1,    -- Disc Barrier
		[GetSpellInfo(204293) or ""]    = 1,    -- Spirit Link
		[GetSpellInfo(98007) or ""]     = 1,    -- Spirit Link Totem
		[GetSpellInfo(212183) or ""]    = 1,    -- Smoke Bomb
		[GetSpellInfo(202797) or ""]    = 1,    -- Viper Sting
		[GetSpellInfo(197690) or ""]    = 1,    -- Defensive Stance
		[GetSpellInfo(783) or ""]       = 1.1,  -- Travel form
		[GetSpellInfo(5487) or ""]      = 1.1,  -- Bear form
		[GetSpellInfo(768) or ""]       = 1.1,  -- Cat form
		[GetSpellInfo(197625) or ""]    = 1.1,  -- Moonkin form 1
		[GetSpellInfo(24858) or ""]     = 1.1,  -- Moonkin form 2
		[GetSpellInfo(199890) or ""]    = 1,    -- Curse of Tongues
		[GetSpellInfo(199892) or ""]    = 1,    -- Curse of Weakness
		[GetSpellInfo(199954) or ""]    = 1,    -- Curse of Fragility
		[GetSpellInfo(290786) or ""]    = 1,    -- Ultimate Retribution
		["205369"]                = 1,    -- Mind Bomb pre disorient
		[GetSpellInfo(200587) or ""]    = 1.2,  -- Fel Fissure
		["198819"]                = 1.2,  -- Sharpen Blade
		["199845"]                = 1.2,  -- Psyfiend
		["199483"]                = 1.2,  -- Camouflage
	}
	return auraTable
end

local ClassIcon = Gladius:NewModule("ClassIcon", false, true, {
	classIconAttachTo = "Frame",
	classIconAnchor = "TOPRIGHT",
	classIconRelativePoint = "TOPLEFT",
	classIconAdjustSize = false,
	classIconSize = 40,
	classIconOffsetX = -1,
	classIconOffsetY = 0,
	classIconFrameLevel = 1,
	classIconGloss = true,
	classIconGlossColor = {r = 1, g = 1, b = 1, a = 0.4},
	classIconImportantAuras = true,
	classIconCrop = false,
	classIconCooldown = false,
	classIconCooldownReverse = false,
	classIconShowSpec = false,
	classIconDetached = false,
	classIconAuras = GetDefaultAuraList(),
})

function ClassIcon:OnEnable()
	self:RegisterEvent("UNIT_AURA")
	self.version = 1
	LSM = Gladius.LSM
	if not self.frame then
		self.frame = { }
	end
	Gladius.db.auraVersion = self.version
end

function ClassIcon:OnDisable()
	self:UnregisterAllEvents()
	for unit in pairs(self.frame) do
		self.frame[unit]:SetAlpha(0)
	end
end

function ClassIcon:GetAttachTo()
	return Gladius.db.classIconAttachTo
end

function ClassIcon:IsDetached()
	return Gladius.db.classIconDetached
end

function ClassIcon:GetFrame(unit)
	return self.frame[unit]
end

function ClassIcon:UNIT_AURA(event, unit)
	if not Gladius:IsValidUnit(unit) then
		return
	end

	-- important auras
	self:UpdateAura(unit)
end

function ClassIcon:UpdateColors(unit)
	self.frame[unit].normalTexture:SetVertexColor(Gladius.db.classIconGlossColor.r, Gladius.db.classIconGlossColor.g, Gladius.db.classIconGlossColor.b, Gladius.db.classIconGloss and Gladius.db.classIconGlossColor.a or 0)
end

function ClassIcon:UpdateAura(unit)
	local unitFrame = self.frame[unit]

	if not unitFrame then
		return
	end

	if not Gladius.db.classIconAuras then
		return
	end

	local aura

	for _, auraType in pairs({'HELPFUL', 'HARMFUL'}) do
		for i = 1, 40 do
			local name, icon, _, _, duration, expires, _, _, _, spellid = UnitAura(unit, i, auraType)

			if not name then
				break
			end
			local auraList = Gladius.db.classIconAuras
			local priority = auraList[name] or auraList[tostring(spellid)]

			if priority and (not aura or aura.priority < priority)  then
				aura = {
					name = name,
					icon = icon,
					duration = duration,
					expires = expires,
					spellid = spellid,
					priority = priority
				}
			end
		end
	end

	if aura and (not unitFrame.aura or (unitFrame.aura.id ~= aura or unitFrame.aura.expires ~= aura.expires)) then
		self:ShowAura(unit, aura)
	elseif not aura then
		self.frame[unit].aura = nil
		self:SetClassIcon(unit)
	end
end

function ClassIcon:ShowAura(unit, aura)
	local unitFrame = self.frame[unit]
	unitFrame.aura = aura

	-- display aura
	unitFrame.texture:SetTexture(aura.icon)
	if Gladius.db.classIconCrop then
		unitFrame.texture:SetTexCoord(0.075, 0.925, 0.075, 0.925)
	else
		unitFrame.texture:SetTexCoord(0, 1, 0, 1)
	end

	local start

	if aura.expires then
		local timeLeft = aura.expires > 0 and aura.expires - GetTime() or 0
		start = GetTime() - (aura.duration - timeLeft)
	end

	Gladius:Call(Gladius.modules.Timer, "SetTimer", unitFrame, aura.duration, start)
end

function ClassIcon:SetClassIcon(unit)
	if not self.frame[unit] then
		return
	end
	Gladius:Call(Gladius.modules.Timer, "HideTimer", self.frame[unit])
	-- get unit class
	local class
	local specIcon
	if not Gladius.test then
		local frame = Gladius:GetUnitFrame(unit)
		class = frame.class
		specIcon = frame.specIcon
	else
		class = Gladius.testing[unit].unitClass
		if not IsClassic then
			local _, _, _, icon = GetSpecializationInfoByID(Gladius.testing[unit].unitSpecId)
			specIcon = icon
		end
	end
	if Gladius.db.classIconShowSpec and not IsClassic then
		if specIcon then
			self.frame[unit].texture:SetTexture(specIcon)
			local left, right, top, bottom = 0, 1, 0, 1
			-- Crop class icon borders
			if Gladius.db.classIconCrop then
				left = left + (right - left) * 0.075
				right = right - (right - left) * 0.075
				top = top + (bottom - top) * 0.075
				bottom = bottom - (bottom - top) * 0.075
			end
			self.frame[unit].texture:SetTexCoord(left, right, top, bottom)
		end
	else
		if class then
			self.frame[unit].texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
			local left, right, top, bottom = unpack(CLASS_BUTTONS[class])
			-- Crop class icon borders
			if Gladius.db.classIconCrop then
				left = left + (right - left) * 0.075
				right = right - (right - left) * 0.075
				top = top + (bottom - top) * 0.075
				bottom = bottom - (bottom - top) * 0.075
			end
			self.frame[unit].texture:SetTexCoord(left, right, top, bottom)
		end
	end
end

function ClassIcon:CreateFrame(unit)
	local button = Gladius.buttons[unit]
	if not button then
		return
	end
	-- create frame
	self.frame[unit] = CreateFrame("CheckButton", "Gladius"..self.name.."Frame"..unit, button, "ActionButtonTemplate")
	self.frame[unit]:EnableMouse(false)
	self.frame[unit]:SetNormalTexture("Interface\\AddOns\\Gladius\\Images\\Gloss")
	self.frame[unit].texture = _G[self.frame[unit]:GetName().."Icon"]
	self.frame[unit].normalTexture = _G[self.frame[unit]:GetName().."NormalTexture"]
	self.frame[unit].cooldown = _G[self.frame[unit]:GetName().."Cooldown"]

	-- secure
	local secure = CreateFrame("Button", "Gladius"..self.name.."SecureButton"..unit, button, "SecureActionButtonTemplate")
	secure:RegisterForClicks("AnyUp")
	self.frame[unit].secure = secure
end

function ClassIcon:Update(unit)
	-- TODO: check why we need this >_<
	self.frame = self.frame or { }

	-- create frame
	if not self.frame[unit] then
		self:CreateFrame(unit)
	end

	local unitFrame = self.frame[unit]

	-- update frame
	unitFrame:ClearAllPoints()
	local parent = Gladius:GetParent(unit, Gladius.db.classIconAttachTo)
	unitFrame:SetPoint(Gladius.db.classIconAnchor, parent, Gladius.db.classIconRelativePoint, Gladius.db.classIconOffsetX, Gladius.db.classIconOffsetY)
	-- frame level
	unitFrame:SetFrameLevel(Gladius.db.classIconFrameLevel)
	if Gladius.db.classIconAdjustSize then
		local height = false
		-- need to rethink that
		--[[for _, module in pairs(Gladius.modules) do
			if module:GetAttachTo() == self.name then
				height = false
			end
		end]]
		if height then
			unitFrame:SetWidth(Gladius.buttons[unit].height)
			unitFrame:SetHeight(Gladius.buttons[unit].height)
		else
			unitFrame:SetWidth(Gladius.buttons[unit].frameHeight)
			unitFrame:SetHeight(Gladius.buttons[unit].frameHeight)
		end
	else
		unitFrame:SetWidth(Gladius.db.classIconSize)
		unitFrame:SetHeight(Gladius.db.classIconSize)
	end

	-- Secure frame
	if self.IsDetached() then
		unitFrame.secure:SetAllPoints(unitFrame)
		unitFrame.secure:SetHeight(unitFrame:GetHeight())
		unitFrame.secure:SetWidth(unitFrame:GetWidth())
		unitFrame.secure:Show()
	else
		unitFrame.secure:Hide()
	end

	unitFrame.texture:SetTexture("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes")
	-- set frame mouse-interactable area
	local left, right, top, bottom = Gladius.buttons[unit]:GetHitRectInsets()
	if self:GetAttachTo() == "Frame" and not self:IsDetached() then
		if strfind(Gladius.db.classIconRelativePoint, "LEFT") then
			left = - unitFrame:GetWidth() + Gladius.db.classIconOffsetX
		else
			right = - unitFrame:GetWidth() + - Gladius.db.classIconOffsetX
		end
		-- search for an attached frame
		--[[for _, module in pairs(Gladius.modules) do
			if (module.attachTo and module:GetAttachTo() == self.name and module.frame and module.frame[unit]) then
				local attachedPoint = module.frame[unit]:GetPoint()
				if (strfind(Gladius.db.classIconRelativePoint, "LEFT") and (not attachedPoint or (attachedPoint and strfind(attachedPoint, "RIGHT")))) then
					left = left - module.frame[unit]:GetWidth()
				elseif (strfind(Gladius.db.classIconRelativePoint, "LEFT") and (not attachedPoint or (attachedPoint and strfind(attachedPoint, "LEFT")))) then
					right = right - module.frame[unit]:GetWidth()
				end
			end
		end]]
		-- top / bottom
		if unitFrame:GetHeight() > Gladius.buttons[unit]:GetHeight() then
			bottom = -(unitFrame:GetHeight() - Gladius.buttons[unit]:GetHeight()) + Gladius.db.classIconOffsetY
		end
		Gladius.buttons[unit]:SetHitRectInsets(left, right, 0, 0)
		Gladius.buttons[unit].secure:SetHitRectInsets(left, right, 0, 0)
	end
	-- style action button
	unitFrame.normalTexture:SetHeight(unitFrame:GetHeight() + unitFrame:GetHeight() * 0.4)
	unitFrame.normalTexture:SetWidth(unitFrame:GetWidth() + unitFrame:GetWidth() * 0.4)
	unitFrame.normalTexture:ClearAllPoints()
	unitFrame.normalTexture:SetPoint("CENTER", 0, 0)
	unitFrame:SetNormalTexture("Interface\\AddOns\\Gladius\\Images\\Gloss")
	unitFrame.texture:ClearAllPoints()
	unitFrame.texture:SetPoint("TOPLEFT", unitFrame, "TOPLEFT")
	unitFrame.texture:SetPoint("BOTTOMRIGHT", unitFrame, "BOTTOMRIGHT")
	unitFrame.normalTexture:SetVertexColor(Gladius.db.classIconGlossColor.r, Gladius.db.classIconGlossColor.g, Gladius.db.classIconGlossColor.b, Gladius.db.classIconGloss and Gladius.db.classIconGlossColor.a or 0)
	unitFrame.texture:SetTexCoord(left, right, top, bottom)

	-- cooldown
	unitFrame.cooldown.isDisabled = not Gladius.db.classIconCooldown
	unitFrame.cooldown:SetReverse(Gladius.db.classIconCooldownReverse)
	Gladius:Call(Gladius.modules.Timer, "RegisterTimer", unitFrame, Gladius.db.classIconCooldown)

	-- hide
	unitFrame:SetAlpha(0)
	self.frame[unit] = unitFrame
end

function ClassIcon:Show(unit)
	local testing = Gladius.test
	-- show frame
	self.frame[unit]:SetAlpha(1)
	-- set class icon
	self:UpdateAura(unit)
end

function ClassIcon:Reset(unit)
	-- reset frame
	self.frame[unit].aura = nil
	self.frame[unit]:SetScript("OnUpdate", nil)
	-- reset cooldown
	self.frame[unit].cooldown:SetCooldown(0, 0)
	-- reset texture
	self.frame[unit].texture:SetTexture("")
	-- hide
	self.frame[unit]:SetAlpha(0)
end

function ClassIcon:ResetModule()
	Gladius.db.classIconAuras = { }
	Gladius.db.classIconAuras = GetDefaultAuraList()
	local newAura = Gladius.options.args[self.name].args.auraList.args.newAura
	Gladius.options.args[self.name].args.auraList.args = {
		newAura = newAura,
	}
	for aura, priority in pairs(Gladius.db.classIconAuras) do
		if priority then
			local isNum = tonumber(aura) ~= nil
			local name = isNum and GetSpellInfo(aura) or aura
			Gladius.options.args[self.name].args.auraList.args[aura] = self:SetupAura(aura, priority, name)
		end
	end
end

function ClassIcon:Test(unit)
	if not Gladius.db.classIconImportantAuras then
		return
	end
	if unit == "arena1" then
		self:ShowAura(unit, {
			icon = select(3, GetSpellInfo(45438)),
			duration = 10
		})
	elseif unit == "arena2" then
		self:ShowAura(unit, {
			icon = select(3, GetSpellInfo(19263)),
			duration = 5
		})
	end
end

function ClassIcon:GetOptions()
	local options = {
		general = {
			type = "group",
			name = L["General"],
			order = 1,
			args = {
				widget = {
					type = "group",
					name = L["Widget"],
					desc = L["Widget settings"],
					inline = true,
					order = 1,
					args = {
						classIconImportantAuras = {
							type = "toggle",
							name = L["Class Icon Important Auras"],
							desc = L["Show important auras instead of the class icon"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							order = 5,
						},
						classIconCrop = {
							type = "toggle",
							name = L["Class Icon Crop Borders"],
							desc = L["Toggle if the class icon borders should be cropped or not."],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 6,
						},
						sep = {
							type = "description",
							name = "",
							width = "full",
							order = 7,
						},
						classIconCooldown = {
							type = "toggle",
							name = L["Class Icon Cooldown Spiral"],
							desc = L["Display the cooldown spiral for important auras"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 10,
						},
						classIconCooldownReverse = {
							type = "toggle",
							name = L["Class Icon Cooldown Reverse"],
							desc = L["Invert the dark/bright part of the cooldown spiral"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 15,
						},
						classIconShowSpec = {
							type = "toggle",
							name = L["Class Icon Spec Icon"],
							desc = L["Shows the specialization icon instead of the class icon"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 16,
						},
						sep2 = {
							type = "description",
							name = "",
							width = "full",
							order = 17,
						},
						classIconGloss = {
							type = "toggle",
							name = L["Class Icon Gloss"],
							desc = L["Toggle gloss on the class icon"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 20,
						},
						classIconGlossColor = {
							type = "color",
							name = L["Class Icon Gloss Color"],
							desc = L["Color of the class icon gloss"],
							get = function(info)
								return Gladius:GetColorOption(info)
							end,
							set = function(info, r, g, b, a)
								return Gladius:SetColorOption(info, r, g, b, a)
							end,
							hasAlpha = true,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 25,
						},
						sep3 = {
							type = "description",
							name = "",
							width = "full",
							order = 27,
						},
						classIconFrameLevel = {
							type = "range",
							name = L["Class Icon Frame Level"],
							desc = L["Frame level of the class icon"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							min = 1,
							max = 5,
							step = 1,
							width = "double",
							order = 30,
						},
					},
				},
				size = {
					type = "group",
					name = L["Size"],
					desc = L["Size settings"],
					inline = true,
					order = 2,
					args = {
						classIconAdjustSize = {
							type = "toggle",
							name = L["Class Icon Adjust Size"],
							desc = L["Adjust class icon size to the frame size"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							order = 5,
						},
						classIconSize = {
							type = "range",
							name = L["Class Icon Size"],
							desc = L["Size of the class icon"],
							min = 10,
							max = 100,
							step = 1,
							disabled = function()
								return Gladius.dbi.profile.classIconAdjustSize or not Gladius.dbi.profile.modules[self.name]
							end,
							order = 10,
						},
					},
				},
				position = {
					type = "group",
					name = L["Position"],
					desc = L["Position settings"],
					inline = true,
					order = 3,
					args = {
						classIconAttachTo = {
							type = "select",
							name = L["Class Icon Attach To"],
							desc = L["Attach class icon to given frame"],
							values = function()
								return Gladius:GetModules(self.name)
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 5,
						},
						classIconDetached = {
							type = "toggle",
							name = L["Detached from frame"],
							desc = L["Detach the cast bar from the frame itself"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							order = 6,
						},
						classIconPosition = {
							type = "select",
							name = L["Class Icon Position"],
							desc = L["Position of the class icon"],
							values={ ["LEFT"] = L["Left"], ["RIGHT"] = L["Right"] },
							get = function()
								return strfind(Gladius.db.classIconAnchor, "RIGHT") and "LEFT" or "RIGHT"
							end,
							set = function(info, value)
								if (value == "LEFT") then
									Gladius.db.classIconAnchor = "TOPRIGHT"
									Gladius.db.classIconRelativePoint = "TOPLEFT"
								else
									Gladius.db.classIconAnchor = "TOPLEFT"
									Gladius.db.classIconRelativePoint = "TOPRIGHT"
								end
								Gladius:UpdateFrame(info[1])
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return Gladius.db.advancedOptions
							end,
							order = 7,
						},
						sep = {
							type = "description",
							name = "",
							width = "full",
							order = 8,
						},
						classIconAnchor = {
							type = "select",
							name = L["Class Icon Anchor"],
							desc = L["Anchor of the class icon"],
							values = function()
								return Gladius:GetPositions()
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
							order = 10,
						},
						classIconRelativePoint = {
							type = "select",
							name = L["Class Icon Relative Point"],
							desc = L["Relative point of the class icon"],
							values = function()
								return Gladius:GetPositions()
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							hidden = function()
								return not Gladius.db.advancedOptions
							end,
						order = 15,
						},
							sep2 = {
							type = "description",
							name = "",
							width = "full",
							order = 17,
						},
						classIconOffsetX = {
							type = "range",
							name = L["Class Icon Offset X"],
							desc = L["X offset of the class icon"],
							min = - 100, max = 100, step = 1,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							order = 20,
						},
						classIconOffsetY = {
							type = "range",
							name = L["Class Icon Offset Y"],
							desc = L["Y offset of the class icon"],
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name]
							end,
							min = - 50,
							max = 50,
							step = 1,
							order = 25,
						},
					},
				},
			},
		},
		auraList = {
			type = "group",
			name = L["Auras"],
			childGroups = "tree",
			order = 3,
			args = {
				newAura = {
					type = "group",
					name = L["New Aura"],
					desc = L["New Aura"],
					inline = true,
					order = 1,
					args = {
						name = {
							type = "input",
							name = L["Name"],
							desc = L["Name of the aura"],
							get = function()
								return self.newAuraName or ""
							end,
							set = function(info, value)
								self.newAuraName = value
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name] or not Gladius.db.classIconImportantAuras
							end,
							order = 1,
						},
						priority = {
							type = "range",
							name = L["Priority"],
							desc = L["Select what priority the aura should have - higher equals more priority"],
							get = function()
								return self.newAuraPriority or 0
							end,
							set = function(info, value)
								self.newAuraPriority = value
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name] or not Gladius.db.classIconImportantAuras
							end,
							min = 0,
							max = 20,
							step = 1,
							order = 2,
						},
						add = {
							type = "execute",
							name = L["Add new Aura"],
							func = function(info)
								if not self.newAuraName or self.newAuraName == "" then
									return
								end
								if not self.newAuraPriority then
									self.newAuraPriority = 0
								end
								local isNum = tonumber(self.newAuraName) ~= nil
								local name = isNum and GetSpellInfo(self.newAuraName) or self.newAuraName
								Gladius.options.args[self.name].args.auraList.args[self.newAuraName] = self:SetupAura(self.newAuraName, self.newAuraPriority, name)
								Gladius.db.classIconAuras[self.newAuraName] = self.newAuraPriority
								self.newAuraName = ""
							end,
							disabled = function()
								return not Gladius.dbi.profile.modules[self.name] or not Gladius.db.classIconImportantAuras or not self.newAuraName or self.newAuraName == ""
							end,
							order = 3,
						},
					},
				},
			},
		},
	}
	for aura, priority in pairs(Gladius.db.classIconAuras) do
		if priority then
			local isNum = tonumber(aura) ~= nil
			local name = isNum and GetSpellInfo(aura) or aura
			options.auraList.args[aura] = self:SetupAura(aura, priority, name)
		end
	end
	return options
end

local function setAura(info, value)
	if info[#(info)] == "name" then
		if info[#(info) - 1] == value then
			return
		end
		-- create new aura
		Gladius.db.classIconAuras[value] = Gladius.db.classIconAuras[info[#(info) - 1]]
		-- delete old aura
		Gladius.db.classIconAuras[info[#(info) - 1]] = nil
		local newAura = Gladius.options.args["ClassIcon"].args.auraList.args.newAura
		Gladius.options.args["ClassIcon"].args.auraList.args = {
			newAura = newAura,
		}
		for aura, priority in pairs(Gladius.db.classIconAuras) do
			if priority then
				local isNum = tonumber(aura) ~= nil
				local name = isNum and GetSpellInfo(aura) or aura
				Gladius.options.args["ClassIcon"].args.auraList.args[aura] = ClassIcon:SetupAura(aura, priority, name)
			end
		end
	else
		Gladius.dbi.profile.classIconAuras[info[#(info) - 1]] = value
	end
end

local function getAura(info)
	if info[#(info)] == "name" then
		return info[#(info) - 1]
	else
		return Gladius.dbi.profile.classIconAuras[info[#(info) - 1]]
	end
end

function ClassIcon:SetupAura(aura, priority, name)
	local name = name or aura
	return {
		type = "group",
		name = name,
		desc = name,
		get = getAura,
		set = setAura,
		args = {
			name = {
				type = "input",
				name = L["Name or ID"],
				desc = L["Name or ID of the aura"],
				order = 1,
				disabled = function()
					return not Gladius.dbi.profile.modules[self.name] or not Gladius.db.classIconImportantAuras
				end,
			},
			priority = {
				type = "range",
				name = L["Priority"],
				desc = L["Select what priority the aura should have - higher equals more priority"],
				min = 0,
				max = 20,
				step = 1,
				order = 2,
				disabled = function()
					return not Gladius.dbi.profile.modules[self.name] or not Gladius.db.classIconImportantAuras
				end,
			},
			delete = {
				type = "execute",
				name = L["Delete"],
				func = function(info)
					local defaults = GetDefaultAuraList()
					if defaults[info[#(info) - 1]] then
						Gladius.db.classIconAuras[info[#(info) - 1]] = false
					else
						Gladius.db.classIconAuras[info[#(info) - 1]] = nil
					end
					local newAura = Gladius.options.args[self.name].args.auraList.args.newAura
					Gladius.options.args[self.name].args.auraList.args = {
						newAura = newAura,
					}
					for aura, priority in pairs(Gladius.db.classIconAuras) do
						if priority then
							local isNum = tonumber(aura) ~= nil
							local name = isNum and GetSpellInfo(aura) or aura
							Gladius.options.args[self.name].args.auraList.args[aura] = self:SetupAura(aura, priority, name)
						end
					end
				end,
				disabled = function()
					return not Gladius.dbi.profile.modules[self.name] or not Gladius.db.classIconImportantAuras
				end,
				order = 3,
			},
			reset = {
				type = "execute",
				name = L["Reset Auras"],
				func = function(info)
					self:ResetModule()
				end,
				disabled = function()
					return not Gladius.dbi.profile.modules[self.name] or not Gladius.db.classIconImportantAuras
				end,
				order = 4,
			},
		},
	}
end
