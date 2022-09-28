local AddonName, Private = ...

-- Credits to WeakAuras for listing these textures https://github.com/WeakAuras
local mapping =
{
    ["449486"]	= "Arcane Missiles",
    ["1027131"]	= "Arcane Missiles 1",
    ["1027132"]	= "Arcane Missiles 2",
    ["1027133"]	= "Arcane Missiles 3",
    ["450913"] 	= "Art of War",
    ["801266"] 	= "Backlash Green",
    ["460830"] 	= "Backlash",
    ["1030393"]	= "Bandits Guile",
    ["510822"] 	= "Berserk",
    ["511104"] 	= "Blood Boil",
    ["449487"] 	= "Blood Surge",
    ["449488"] 	= "Brain Freeze",
    ["603338"] 	= "Dark Tiger",
    ["461878"] 	= "Dark Transformation",
    ["459313"] 	= "Daybreak",
    ["511469"] 	= "Denounce",
    ["1057288"]	= "Echo of the Elements",
    ["450914"] 	= "Eclipse Moon",
    ["450915"] 	= "Eclipse Sun",
    ["450916"] 	= "Focus Fire",
    ["449489"] 	= "Frozen Fingers",
    ["467696"] 	= "Fulmination",
    ["460831"] 	= "Fury of Stormrage",
    ["450917"] 	= "Generic Arc 1",
    ["450918"] 	= "Generic Arc 2",
    ["450919"] 	= "Generic Arc 3",
    ["450920"] 	= "Generic Arc 4",
    ["450921"] 	= "Generic Arc 5",
    ["450922"] 	= "Generic Arc 6",
    ["450923"] 	= "Generic Top 1",
    ["450924"] 	= "Generic Top 2",
    ["450925"] 	= "Grand Crusader",
    ["459314"] 	= "Hand of Light",
    ["449490"] 	= "Hot Streak",
    ["801267"] 	= "Imp Empowerment Green",
    ["449491"] 	= "Imp Empowerment",
    ["457658"] 	= "Impact",
    ["458740"] 	= "Killing Machine",
    ["450926"] 	= "Lock and Load",
    ["1028136"]	= "Maelstrom Weapon 1",
    ["1028137"]	= "Maelstrom Weapon 2",
    ["1028138"]	= "Maelstrom Weapon 3",
    ["1028139"]	= "Maelstrom Weapon 4",
    ["450927"] 	= "Maelstrom Weapon",
    ["450928"] 	= "Master Marksman",
    ["801268"] 	= "Molten Core Green",
    ["458741"] 	= "Molten Core",
    ["1001511"]	= "Monk Blackout Kick",
    ["1028091"]	= "Monk Ox 2",
    ["1028092"]	= "Monk Ox 3",
    ["623950"] 	= "Monk Ox",
    ["623951"] 	= "Monk Serpent",
    ["1001512"]	= "Monk Tiger Palm",
    ["623952"] 	= "Monk Tiger",
    ["450929"] 	= "Nature's Grace",
    ["511105"] 	= "Necropolis",
    ["449492"] 	= "Nightfall",
    ["510823"] 	= "Feral OmenOfClarity",
    ["898423"] 	= "Predatory Swiftness",
    ["962497"] 	= "Raging Blow",
    ["450930"] 	= "Rime",
    ["469752"] 	= "Serendipity",
    ["656728"] 	= "Shadow Word Insanity",
    ["627609"] 	= "Shadow of Death",
    ["463452"] 	= "Shooting Stars",
    ["450931"] 	= "Slice and Dice",
    ["424570"] 	= "Spell Activation Overlay 0",
    ["449493"] 	= "Sudden Death",
    ["450932"] 	= "Sudden Doom",
    ["592058"] 	= "Surge of Darkness",
    ["450933"] 	= "Surge of Light",
    ["449494"] 	= "Sword and Board",
    ["1029138"]	= "Thrill of the Hunt 1",
    ["1029139"]	= "Thrill of the Hunt 2",
    ["1029140"]	= "Thrill of the Hunt 3",
    ["774420"] 	= "Tooth and Claw",
    ["627610"] 	= "Ultimatum",
    ["603339"] 	= "White Tiger",
}

Private.TexName = {}
for retailTexture, classicTexture in pairs(mapping) do
  -- For now, all textures are copied locally in the addon's texture folder
  local fullTextureName = "Interface\\Addons\\SpellActivationOverlay\\textures\\"..classicTexture:gsub(" ", "_"):gsub("'", "");
  Private.TexName[retailTexture] = fullTextureName;
  Private.TexName[tonumber(retailTexture,10)] = fullTextureName;
  Private.TexName[strlower(classicTexture)] = fullTextureName;
  Private.TexName[strlower(classicTexture):gsub(" ", "_"):gsub("'", "")] = fullTextureName;
end