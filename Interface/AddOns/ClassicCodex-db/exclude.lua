-- Exclude quests with specific IDs from auto accept and auto turnin
-- to prevent unexpected and irreversible choices.
CodexDB["exclude"]["quests"]={
    -- Choice a faction in Shattrath City
    [10551] = true, -- Allegiance to the Aldor
    [10552] = true, -- Allegiance to the Scryers

    -- Reputation reward of Brood of Nozdormu
    [8747] = true, -- The Path of the Protector
    [8752] = true, -- The Path of the Conqueror
    [8757] = true, -- The Path of the Invoker

    -- Re-choice the reputation reward of Brood of Nozdormu
    [8764] = true, -- The Changing of Paths - Protector No More
    [8765] = true, -- The Changing of Paths - Invoker No More
    [8766] = true, -- The Changing of Paths - Conqueror No More

    -- Reputation reward of Violet Eye
    [10733] = true, -- Down the Violet Path
    [10734] = true, -- Down the Violet Path
    [10735] = true, -- Down the Violet Path
    [10736] = true, -- Down the Violet Path

    -- Re-choice the reputation reward of Violet Eye
    [11031] = true, -- Archmage No More
    [11032] = true, -- Protector No More
    [11033] = true, -- Assassin No More
    [11034] = true, -- Restorer No More

    -- Reputation reward of the Scale of Sands
    [10460] = true, -- Defender's Pledge
    [10461] = true, -- Restorer's Pledge
    [10462] = true, -- Champion's Pledge
    [10463] = true, -- Sage's Pledge

    -- Re-choice the reputation reward of the Scale of Sands
    [11103] = true, -- Sage No More
    [11104] = true, -- Restorer No More
    [11105] = true, -- Champion No More
    [11106] = true, -- Defender No More
}
