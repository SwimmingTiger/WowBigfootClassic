local AddonName, SAO = ...

SAO.defaults = {
    classes = {
        ["DEATHKNIGHT"] = {
            alert = {
                [59052] = { -- Rime
                    [0] = true,
                },
                [51124] = { -- Killing Machine
                    [0] = true,
                },
            },
            glow = {
                [56815] = { -- Rune Strike
                    [56815] = true, -- Rune Strike
                },
                [59052] = { -- Rime
                    [49184] = true, --  Howling Blast
                },
                [51124] = { -- Killing Machine
                    [45477] = true, -- Icy Touch
                    [49143] = true, -- Frost Strike
                    [49184] = true, -- Howling Blast
                },
            }
        },
        ["DRUID"] = {
            alert = {
                [16870] = { -- Omen of Clarity
                    [0] = true,
                },
                [48518] = { -- Eclipse (Lunar)
                    [0] = true,
                },
                [48517] = { -- Eclipse (Solar)
                    [0] = true,
                },
                [69369] = { -- Predatory Strikes
                    [0] = true,
                },
            },
            glow = {
                [2912] = { -- Starfire
                    [2912] = true, -- Starfire
                },
                [5176] = { -- Wrath
                    [5176] = true, --  Wrath
                },
                [69369] = { -- Predatory Strikes
                    [8936]  = false, -- Regrowth
                    [5185]  = true,  -- Healing Touch
                    [50464] = false, -- Nourish
                    [20484] = false, -- Rebirth
                    [5176]  = false, -- Wrath
                    [339]   = false, -- Entangling Roots
                    [33786] = true,  -- Cyclone
                    [2637]  = false, -- Hibernate
                },
            }
        },
        ["HUNTER"] = {
            alert = {
                [53220] = { -- Improved Steady Shot
                    [0] = true,
                },
                [56453] = { -- Lock and Load
                    [0] = true, -- any stacks
                },
            },
            glow = {
                [53351] = { -- Kill Shot
                    [53351] = true, -- Kill Shot
                },
                [19306] = { -- Counterattack
                    [19306] = true, -- Counterattack
                },
                [53220] = { -- Improved Steady Shot
                    [19434] = true, --  Aimed Shot
                    [3044]  = true, --  Arcane Shot
                    [53209] = true, --  Chimera Shot
                },
                [56453] = { -- Lock and Load
                    [3044]  = true, --  Arcane Shot
                    [53301] = true, --  Explosive Shot
                },
            }
        },
        ["MAGE"] = {
            alert = {
                [44401] = { -- Missile Barrage
                    [0] = true,
                },
                [48107] = { -- Heating Up (not an actual buff)
                    [0] = true,
                },
                [48108] = { -- Hot Streak
                    [0] = true,
                },
                [64343] = { -- Impact
                    [0] = true,
                },
                [54741] = { -- Firestarter
                    [0] = true,
                },
                [74396] = { -- Fingers of Frost
                    [0] = true, -- any stacks
                },
                [57761] = { -- Brain Freeze
                    [0] = true,
                },
            },
            glow = {
                [44401] = { -- Missile Barrage
                    [5143] = true, -- Arcane Missiles
                },
                [48108] = { -- Hot Streak
                    [11366] = true, -- Pyroblast
                },
                [64343] = { -- Impact
                    [2136] = true, -- Fire Blast
                },
                [54741] = { -- Firestarter
                    [2120] = true, -- Flamestrike
                },
                [57761] = { -- Brain Freeze
                    [133]   = true, -- Fireball
                    [44614] = true, -- Frostfire Bolt
                },
            },
        },
        ["PALADIN"] = {
            alert = {
                [54149] = { -- Infusion of Light (2/2)
                    [0] = true,
                },
                [59578] = { -- The Art of War (2/2)
                    [0] = true,
                },
            },
            glow = {
                [24275] = { -- Hammer of Wrath
                    [24275] = true, -- Hammer of Wrath
                },
                [54149] = { -- Infusion of Light (2/2)
                    [19750] = true, -- Flash of Light
                    [635]   = true, -- Holy Light
                },
                [59578] = { -- The Art of War (2/2)
                    [879]   = true, -- Exorcism
                    [19750] = true, -- Flash of Light
                },
            },
        },
        ["PRIEST"] = {
            alert = {
                [33151] = {  -- Surge of Light
                    [0] = true,
                },
                [63734] = { -- Serendipity
                    [3] = true,  -- 3 stacks
                    [0] = false, -- any stacks but 3
                },
            },
            glow = {
                [33151] = { -- Surge of Light
                    [585]  = true, -- Smite
                    [2061] = true, -- Flash Heal
                },
                [63734] = { -- Serendipity 3/3
                    [2060] = true, -- Greater Heal
                    [596]  = true, -- Prayer of Healing
                },
            },
        },
        ["ROGUE"] = {
            alert = {
                [14251] = { -- Riposte
                    [0] = true,
                },
            },
            glow = {
                [14251] = { -- Riposte
                    [14251] = true, -- Riposte
                },
            },
        },
        ["SHAMAN"] = {
            alert = {
                [16246] = {  -- Elemental Focus
                    [0] = true, -- any stacks
                },
                [53817] = { -- Maelstorm Weapon
                    [5] = true, -- 5 stacks
                    [0] = true, -- any stacks but 5
                },
            },
            glow = {
                [53817] = { -- Maelstorm Weapon
                    [403]   = false, -- Lightning Bolt
                    [421]   = false, -- Chain Lightning
                    [8004]  = false, -- lesser Healing Wave
                    [331]   = false, -- Healing Wave
                    [1064]  = false, -- Chain Heal
                    [51514] = false, -- Hex
                },
            },
        },
        ["WARLOCK"] = {
            alert = {
                [17941] = { -- Nightfall
                    [0] = true,
                },
                [34936] = { -- Backlash
                    [0] = true,
                },
                [71165] = { -- Molten Core
                    [0] = true, -- any stacks
                },
                [63167] = { -- Decimation
                    [0] = true,
                },
                [47283] = { -- Empowered Imp
                    [0] = true,
                },
            },
            glow = {
                [17941] = { -- Nightfall
                    [686] = true, -- Shadow Bolt
                },
                [34936] = { -- Backlash
                    [686]   = true, -- Shadow Bolt
                    [29722] = true, -- Incinerate
                },
                [71165] = { -- Molten Core
                    [29722] = true, -- Incinerate
                    [6353]  = true, -- Soul Fire
                },
                [63167] = { -- Decimation
                    [6353] = true, -- Soul Fire
                },
            },
        },
        ["WARRIOR"] = {
            alert = {
                [52437] = { -- Sudden Death
                    [0] = true,
                },
                [46916] = { -- Bloodsurge
                    [0] = true,
                },
                [50227] = { -- Sword and Board
                    [0] = true,
                },
            },
            glow = {
                [7384] = { -- Overpower
                    [7384] = true, -- Overpower
                },
                [6572] = { -- Revenge
                    [6572] = true, -- Revenge
                },
                [34428] = { -- Victory Rush
                    [34428] = true, -- Victory Rush
                },
                [5308] = { -- Execute
                    [5308] = true, -- Execute
                },
                [52437] = { -- Sudden Death
                    [5308] = true, -- Execute
                },
                [46916] = { -- Bloodsurge
                    [1464] = true, -- Slam
                },
                [50227] = { -- Sword and Board
                    [23922] = true, -- Shield Slam
                },
            },
        },
    }
}