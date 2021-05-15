-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local SpellIDs = TotemTimers.SpellIDs
local SpellNames = TotemTimers.SpellNames
local Version = 11.0

TotemTimers.DefaultGlobalSettings = {
	Version = 11.0,
    Profiles = {},
    Sink = {}
}

TotemTimers_Profiles = {
    ["default"] = {}
}
TotemTimers_GlobalSettings = {}

TotemTimers.DefaultProfile = {

    --General            
        Lock = false,
        FlashRed = true,
        ShowTimerBars = true,
        HideBlizzTimers = true,
        Tooltips = true,
        TooltipsAtButtons = true,
        TimeFont = "Friz Quadrata TT",
        TimeColor = {r=1,g=1,b=1},
        TimerBarTexture = "Blizzard",
        TimerBarColor = {r=0.5,g=0.5,b=1.0,a=1.0},
        ShowKeybinds = true,
        HideInVehicle = true,
        StopPulse = true,
        TimersOnButtons = false,
        LavaSurgeAura = true,
        LavaSurgeGlow = true,
        FulminationAura = true,
        FulminationGlow = true,
        
        LastTotems = {
            [WATER_TOTEM_SLOT] = SpellNames[SpellIDs.HealingStream],
            [FIRE_TOTEM_SLOT] = SpellNames[SpellIDs.Searing],
            [EARTH_TOTEM_SLOT] = SpellNames[SpellIDs.Stoneskin],
            [AIR_TOTEM_SLOT] = SpellNames[SpellIDs.Grounding],
        },
        
    --Timers 
        Show = true,
        Order = {1,2,3,4,},
        Arrange = "horizontal",
        TimeStyle = "mm:ss",
        TimerTimePos = "BOTTOM",   
        CastBarDirection = "auto",
        TimerSize = 32,
        TimerTimeHeight = 12,	
        TimerSpacing = 5,
        TimerTimeSpacing = 0,
        TotemTimerBarWidth = 36,
        TotemMenuSpacing = 0,
        OpenOnRightclick = false,
        MenusAlwaysVisible = false,
        BarBindings = true,
        ReverseBarBindings = false,    
        MiniIcons = true,
        ProcFlash = true,
        ColorTimerBars = false,
        ShowCooldowns = true,
        CheckPlayerRange = true,
        CheckRaidRange = true,	
        ShowRaidRangeTooltip = true,
        Timer_Clickthrough = false,
        
    --Trackers
        TrackerArrange = "horizontal",
        TrackerTimePos = "BOTTOM",
        TrackerSize = 30,
        TrackerTimeHeight=12,
        TrackerSpacing = 5,
        TrackerTimeSpacing = 0,
        TrackerTimerBarWidth = 36,
        AnkhTracker = true,
        ShieldTracker = true,
        WeaponTracker = true,
        WeaponBarDirection = "auto",
        WeaponMenuOnRightclick = false,
        LastWeaponEnchant = TotemTimers.SpellNames[TotemTimers.SpellIDs.RockbiterWeapon],
        EarthShieldTracker = true,
        EarthShieldLeftButton = "recast", 
        EarthShieldRightButton = "target",
        EarthShieldMiddleButton = "targettarget",
        EarthShieldButton4 = "player",
        ShieldLeftButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.LightningShield],
        ShieldRightButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.WaterShield],
        ShieldMiddleButton = TotemTimers.SpellNames[TotemTimers.SpellIDs.TotemicCall],
        EarthShieldTargetName = true,
        ESMainTankMenu = true,
        ESMainTankMenuDirection = "auto",
        ESChargesOnly = false,
        Tracker_Clickthrough = false,
        ShieldChargesOnly = true,
        
    --Warnings
        ActivateHiddenTimers = false,
        Warnings = {
            TotemWarning = {
                r = 1,
                g = 0,
                b = 0,
                a = 1,
                sound = "",
                text = "Totem Expiring",
                enabled = true,
            },
            TotemExpiration = {
                r = 1,
                g = 0,
                b = 0,
                a = 1,
                sound = "",
                text = "Totem Expired",            
                enabled = true,
            },
            TotemDestroyed = {
                r = 1,
                g = 0,
                b = 0,
                a = 1,
                sound = "",
                text = "Totem Destroyed",            
                enabled = true,
            },
            Shield = {
                r = 1,
                g = 0,
                b = 0,
                a = 1,
                sound = "",
                text = "Shield removed",            
                enabled = true,
            },
            EarthShield = {
                r = 1,
                g = 0,
                b = 0,
                a = 1,
                sound = "",
                text = "Shield removed",            
                enabled = true,
            },
            Maelstrom = {
                r = 1,
                g = 0,
                b = 0,
                a = 1,
                sound = "",
                text = "Maelstrom Notifier",            
                enabled = true,
            },
            Weapon = {
                r = 1,
                g = 0,
                b = 0,
                a = 1,
                sound = "",
                text = "Shield removed",
                enabled = true,
            }
        },
        
        LastMainEnchants = {},
        LastOffEnchants = {},

    --Totems
        TotemOrder = {},
        TotemSets = {},
        HiddenTotems = {},

    --CrowdControl
        CrowdControlEnable = true,
        CrowdControlArrange = "horizontal",
        CrowdControlTimePos = "BOTTOM",
        CrowdControlSize = 30,
        CrowdControlClickthrough = false,
		CrowdControlBindElemental = true,
		CrowdControlHex = true,

    --EnhanceCDs
        EnhanceCDs_Spells = {
            [2] = {
                [1] = true, --SpellIDs.StormStrike
                [2] = true, --SpellIDs.EarthShock
                [3] = true, --SpellIDs.LavaLash
                [4] = true, --SpellIDs.FireNova
                [5] = true, --SpellIDs.Magma
                [6] = true, --SpellIDs.ShamanisticRage
                [7] = true, --SpellIDs.WindShear
                [8] = true, --SpellIDs.LightningShield
                [9] = true, -- Unleash Elements,
                [10] = true, -- Spiritwalkers Grace
				[11] = true,
				[12] = true,
                [20] = true, --SpellIDs.FeralSpirit
                [21] = true, --SpellIDs.FlameShock
                [22] = true, --SpellIDs.Maelstrom
            },
            [1] = {
                [1] = true, --SpellIDs.FlameShock,
                [2] = true, --SpellIDs.LavaBurst,
                [3] = true, --SpellIDs.ChainLightning,
                [4] = true, --SpellIDs.Thunderstorm,
                [5] = true, --SpellIDs.ElementalMastery,            
                [6] = true, -- Searing
                [7] = true, --FireNova
                [8] = true, --Lightning Shield
                [9] = true, -- Wind Shear
                [10] = true, -- Unleash Elements,
                [11] = true, -- Spiritwalkers Grace
                [20] = true, -- Flame Shock duration
            },
            [3] = {
                [1] = true, --SpellIDs.Riptide,
                [2] = true, --SpellIDs.WaterShield,
                [3] = true, --SpellIDs.HealingRain,
                [4] = true, --SpellIDs.EarthShock
                [5] = true, -- Wind Shear
                [6] = true, -- Unleash Elements,
                [7] = true, -- Spiritwalkers Grace
                [20] = true, -- Flame Shock duration
            },
        },
        EnhanceCDs_Order = {
            [2] = {
                [1] = 1, --SpellIDs.StormStrike
                [2] = 2, --SpellIDs.EarthShock
                [3] = 3, --SpellIDs.LavaLash
                [4] = 4, --SpellIDs.FireNova
                [5] = 5, --SpellIDs.Magma
                [6] = 6, --SpellIDs.ShamanisticRage
                [7] = 7, --SpellIDs.WindShear
                [8] = 8, --SpellIDs.LightningShield
                [9] = 9, -- Unleash Elements
                [10] = 10, -- Spiritwalker's Grace
				[11] = 11,
				[12] = 12,
            },
            [1] = {
                [1] = 1, --SpellIDs.FlameShock,
                [2] = 2, --SpellIDs.LavaBurst,
                [3] = 3, --SpellIDs.ChainLightning,
                [4] = 4, --SpellIDs.Thunderstorm,
                [5] = 5, --SpellIDs.ElementalMastery,
                [6] = 6, -- Searing
                [7] = 7, --FireNova
                [8] = 8, -- Lightning Shield Counter
                [9] = 9, -- Wind Shear
                [10] = 10, -- Unleash Elements
                [11] = 11, -- Spiritwalker's Grace
            },
            [3] = {
                [1] = 1, 
                [2] = 2, 
                [3] = 3, 
                [4] = 4, -- Wind Shear
                [5] = 5, 
                [6] = 6,
                [7] = 7,
				[8] = 8,
				[9] = 9,
            },
        },
        EnhanceCDs = true,
        EnhanceCDsSize = 30,
        EnhanceCDsTimeHeight = 12,
        EnhanceCDsMaelstromHeight = 14,
        ShowOmniCCOnEnhanceCDs = true,
        EnhanceCDsOOCAlpha = 0.4,
        CDTimersOnButtons = true,
        FlameShockDurationOnTop = false,
        EnhanceCDs_Clickthrough = false,
		
		
		-- LongCooldowns = true,
		--[[ LongCooldownSpells = {
			[SpellIDs.Bloodlust] = true,
			[SpellIDs.Heroism] = true,
			[SpellIDs.AstralShift] = true,
			[SpellIDs.SpiritwalkersGrace] = true,
			[SpellIDs.AncestralGuidance] = true,
			[SpellIDs.CallOfElements] = true,
			[SpellIDs.ElementalMastery] = true,
			[SpellIDs.AncestralSwiftness] = true,
			[SpellIDs.Ascendance] = true,
			[SpellIDs.FeralSpirit] = true,
		}, ]]
		LongCooldownsArrange = "horizontal",
		CooldownSpacing = 5,
    
        FramePositions = {
            TotemTimersFrame = {"CENTER", nil, "CENTER", -200,0},
            TotemTimers_TrackerFrame = {"CENTER", nil, "CENTER", 50,0},
            TotemTimers_EnhanceCDsFrame = {"CENTER", nil, "CENTER", 0, -170},
            TotemTimers_CastBar1 = {"CENTER", nil, "CENTER", -200,-190},
            TotemTimers_CastBar2  = {"CENTER", nil, "CENTER", -200,-225},
            TotemTimers_CastBar3  = {"CENTER", nil, "CENTER", 50, -190},
            TotemTimers_CastBar4  = {"CENTER", nil, "CENTER", 50, -225}, 
            TotemTimers_CrowdControlFrame = {"CENTER", nil, "CENTER", -50, -50},
			TotemTimers_LongCooldownsFrame = {"CENTER", nil, "CENTER", 150, -80},
        },
        
        TimerPositions = { 
            [1] = {"CENTER", nil, "CENTER", -50,-40},
            [2] = {"CENTER", nil, "CENTER", -70,0},
            [3] = {"CENTER", nil, "CENTER", -30, 0},
            [4] = {"CENTER", nil, "CENTER", -50, 40}, 
        },

}

TotemTimers.ActiveProfile = TotemTimers_Profiles.default


local function copy(object) 
    if type(object) ~= "table" then
        return object
    else
        local newtable = {}
        for k,v in pairs(object) do
            newtable[k] = copy(v)
        end
        return newtable
    end
end




function TotemTimers.CreateProfile(name)
    if not TotemTimers_Profiles[name] then
        TotemTimers.ResetProfile(name)
        return true
    else
        return false
    end
end


function TotemTimers.DeleteProfile(name)
    if name == "default" then return end
    TotemTimers_Profiles[name] = nil
    for u,p in pairs(TotemTimers_GlobalSettings.Profiles) do
        for i = 1,3 do
            for _,v in pairs({"none","party","arena","pvp","raid"}) do
                if p[i][v] == name then
                    p[i][v] = "default"
                end
            end
        end
    end
end

function TotemTimers.ResetProfile(name)
    TotemTimers_Profiles[name] = copy(TotemTimers.DefaultProfile)
    if #TotemTimers_Profiles[name].TotemOrder == 0 then
		for i=1,4 do
			TotemTimers_Profiles[name].TotemOrder[i] = {}
		end
		for k,v in pairs(TotemData) do
			table.insert(TotemTimers_Profiles[name].TotemOrder[v.element], k)
		end
	end
end

function TotemTimers.ResetAllProfiles()
    TotemTimers_Profiles = {
        ["default"] = {}
    }
    TotemTimers.ResetProfile("default")
end

function TotemTimers.SelectActiveProfile()
    local player = UnitName("player")
    local specialization -- = GetSpecialization()
    if not specialization then specialization = 2 end
    local _,instance = IsInInstance()
	if not instance then instance = "party" end
    TotemTimers.ActiveProfile = TotemTimers_Profiles[TotemTimers_GlobalSettings.Profiles[player][specialization][instance]] or TotemTimers_Profiles.default
end


function TotemTimers.ExecuteProfile()
    TotemTimers.ProcessAllSettings()
    TotemTimers.SetCastButtonSpells()
    TotemTimers.ProgramSetButtons()
    TotemTimers.SetWeaponTrackerSpells()
	XiTimers.InitWarnings(TotemTimers.ActiveProfile.Warnings)
end

local SettingsConverters = {
}

	
function TotemTimers.UpdateProfiles()

    if not TotemTimers_Profiles then TotemTimers_Profiles = {default={}} end
    
	if not TotemTimers_GlobalSettings.Version or TotemTimers_GlobalSettings.Version < 11.0 then
		DEFAULT_CHAT_FRAME:AddMessage("TotemTimers: Pre-11.0 or no saved settings found, loading defaults...")
        TotemTimers_GlobalSettings = {}
		TotemTimers.ResetAllProfiles()
	elseif TotemTimers_GlobalSettings.Version ~= Version then
        if not SettingsConverters[TotemTimers_GlobalSettings.Version] then
            DEFAULT_CHAT_FRAME:AddMessage("TotemTimers: Unknown settings found, loading defaults...")
            TotemTimers_GlobalSettings = {}
            TotemTimers.ResetAllProfiles()
        else
            while SettingsConverters[TotemTimers_GlobalSettings.Version] do
                SettingsConverters[TotemTimers_GlobalSettings.Version]()
            end
        end
    end


	for k,v in pairs(TotemTimers.DefaultProfile) do
        for _,profile in pairs(TotemTimers_Profiles) do
            if profile[k] == nil then
                profile[k] = copy(v)
            end
        end
	end
	for _,profile in pairs(TotemTimers_Profiles) do
		for i,j in pairs(TotemTimers.DefaultProfile.FramePositions) do
			if not profile.FramePositions[i] then
				profile.FramePositions[i] = copy(j)
			end
		end
	end
    
    for _,profile in pairs(TotemTimers_Profiles) do 
        if #profile.TotemOrder == nil or #profile.TotemOrder < 4 then -- create totemorder array
            for i=1,4 do
                profile.TotemOrder[i] = {}
            end			
            --[[for k,v in pairs(TotemData) do
                table.insert(profile.TotemOrder[v.element], k)
            end]]
        end
		
		local totems = {} -- add missing totems to order if old settings exist
		for i=1,4 do
			for t=1,#profile.TotemOrder[i] do
				totems[profile.TotemOrder[i][t]] = true
			end
		end
		for k,v in pairs(TotemData) do
			if not totems[k] then table.insert(profile.TotemOrder[v.element], k) end
		end

		
		for i = 1,3 do
			for k,v in pairs(TotemTimers.DefaultProfile.EnhanceCDs_Spells[i]) do
				if profile.EnhanceCDs_Spells[i][k] == nil then
					profile.EnhanceCDs_Spells[i][k] = v
				end
			end
			for k,v in pairs(TotemTimers.DefaultProfile.EnhanceCDs_Order[i]) do
				if profile.EnhanceCDs_Order[i][k] == nil then
					profile.EnhanceCDs_Order[i][k] = v
				end
			end
		end
		--[[ for k,v in pairs(TotemTimers.DefaultProfile.LongCooldownSpells) do
			if profile.LongCooldownSpells[k] == nil then
				profile.LongCooldownSpells[k] = v
			end
		end ]]
    end
    
    for k,v in pairs(TotemTimers.DefaultGlobalSettings) do
        if TotemTimers_GlobalSettings[k] == nil then
            TotemTimers_GlobalSettings[k] = copy(v)
        end
    end
    
    local player = UnitName("player")
    if not TotemTimers_GlobalSettings.Profiles[player] then
        TotemTimers_GlobalSettings.Profiles[player] = {
            [1] = {none="default",pvp="default",arena="default",party="default",raid="default",scenario="default"},
            [2] = {none="default",pvp="default",arena="default",party="default",raid="default",scenario="default"},
            [3] = {none="default",pvp="default",arena="default",party="default",raid="default",scenario="default"},
        }
    end
	for i=1,3 do
		if not TotemTimers_GlobalSettings.Profiles[player][i].scenario then
			TotemTimers_GlobalSettings.Profiles[player][i].scenario = "default"
		end
	end
end

function TotemTimers.ResetProfilePositions(name)
    TotemTimers_Profiles[name].FramePositions = copy(TotemTimers.DefaultProfile.FramePositions)
    TotemTimers_Profiles[name].TimerPositions = copy(TotemTimers.DefaultProfile.TimerPositions)
    TotemTimers.ProcessSetting("FramePositions")
end

function TotemTimers.CopyProfile(p1,p2)
    TotemTimers_Profiles[p2] = copy(TotemTimers_Profiles[p1])
end

function TotemTimers.CopyFramePositions(p1, p2)
    TotemTimers_Profiles[p2].FramePositions = copy(TotemTimers_Profiles[p1].FramePositions)
    TotemTimers_Profiles[p2].TimerPositions = copy(TotemTimers_Profiles[p2].TimerPositions)
end


local GeneralList = {
    Lock, FlashRed, ShowTimerBars,
    HideBlizzTimers, Tooltips, TooltipsAtButtons,
    TimeFont, TimeColor, TimerBarTexture,
    TimerBarColor, ShowKeybinds, HideInVehicle,
    StopPulse, TimersOnButtons, LavaSurgeAura,
    LavaSurgeGlow, FulminationAura, FulminationGlow,
}

function TotemTimers.CopyGeneralSettings(p1,p2)
    for k,v in pairs(GeneralList) do
        TotemTimers_Profiles[p2][v] = copy(TotemTimers_Profiles[p1][v])
    end
end


local TimerList = {
    Show, Order, Arrange, TimeStyle,
    TimerTimePos, CastBarDirection, TimerSize, TimerTimeHeight,
    TimerSpacing, TimerTimeSpacing, TotemTimerBarWidth, TotemMenuSpacing,
    OpenOnRightclick, MenusAlwaysVisible, BarBindings, ReverseBarBindings,
    MiniIcons, ProcFlash, ColorTimerBars, ShowCooldowns, 
    CheckPlayerRange, CheckRaidRange, ShowRaidRangeTooltip, Timer_Clickthrough,
}

function TotemTimers.CopyTimerSettings(p1,p2)
    for k,v in pairs(TimerList) do
        TotemTimers_Profiles[p2][v] = copy(TotemTimers_Profiles[p1][v])
    end
end

local TrackerList = {
    TrackerArrange, TrackerTimePos, TrackerSize, TrackerTimeHeight,
    TrackerSpacing, TrackerTimeSpacing, TrackerTimerBarWidth, AnkhTracker,
    ShieldTracker, EarthShieldTracker, 
    EarthShieldLeftButton, EarthShieldRightButton, EarthShieldMiddleButton,
    EarthShieldButton4, ShieldLeftButton, ShieldRightButton, ShieldMiddleButton,
    EarthShieldTargetName, ESMainTankMenu, ESMainTankMenuDirection, ESChargesOnly,
    Tracker_Clickthrough, WeaponTracker, WeaponBarDirection,
    WeaponMenuOnRightclick, LastWeaponEnchant,
}

function TotemTimers.CopyTrackerSettings(p1,p2)
    for k,v in pairs(TrackerList) do
        TotemTimers_Profiles[p2][v] = copy(TotemTimers_Profiles[p1][v])
    end
end


--[[ local CDSettings = {
    EnhanceCDs_Spells, EnhanceCDs_Order, EnhanceCDs, EnhanceCDsSize,
    EnhanceCDsTimeHeight, EnhanceCDsMaelstromHeight, ShowOmniCCOnEnhanceCDs,
    EnhanceCDsOOCAlpha, CDTimersOnButtons, FlameShockDurationOnTop, EnhanceCDs_Clickthrough,
	LongCooldowns, LongCooldownSpells,	LongCooldownsArrange, CooldownSpacing,
}

function TotemTimers.CopyCDSettings(p1,p2)
    for k,v in pairs(CDList) do
        TotemTimers_Profiles[p2][v] = copy(TotemTimers_Profiles[p1][v])
    end
end ]]


local TotemSettings = {
    TotemOrder, HiddenTotems, TotemSets,
}

function TotemTimers.CopyTotemSettings(p1,p2)
    for k,v in pairs(TotemList) do
        TotemTimers_Profiles[p2][v] = copy(TotemTimers_Profiles[p1][v])
    end
end


local CCList = {
    CrowdControlEnable, CrowdControlArrange, CrowdControlTimePos, 
    CrowdControlSize, CrowdControlClickthrough,
}

function TotemTimers.CopyCrowdControlSettings(p1,p2)
    for k,v in pairs(CCList) do
        TotemTimers_Profiles[p2][v] = copy(TotemTimers_Profiles[p1][v])
    end
end


local WarningsList = {
    ActivateHiddenTimers, Warnings,
}

function TotemTimers.CopyWarnings(p1,p2)
    for k,v in pairs(WarningsList) do
        TotemTimers_Profiles[p2][v] = copy(TotemTimers_Profiles[p1][v])
    end
end
