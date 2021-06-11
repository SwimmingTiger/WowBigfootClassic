-- Exclude quests with specific IDs from auto accept and auto turnin
-- to prevent unexpected and irreversible choices.
CodexDB["exclude"]["quests"]={
    [10551] = true, -- Allegiance to the Aldor
    [10552] = true, -- Allegiance to the Scryers
}
