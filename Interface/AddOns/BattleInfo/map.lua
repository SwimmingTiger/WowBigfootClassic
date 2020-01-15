local _, ADDONSELF = ...
local L = ADDONSELF.L
local RegEvent = ADDONSELF.regevent
local RegAddonLoaded = ADDONSELF.regaddonloaded

local RegisterKeyChangedCallback = ADDONSELF.RegisterKeyChangedCallback 

-- local SCALE = 1.5
-- local function ResizePin()
--     BattlefieldMapFrame.groupMembersDataProvider:SetUnitPinSize("player", BATTLEFIELD_MAP_PLAYER_SIZE * SCALE)

--     if BattlefieldMapOptions.showPlayers then
--         BattlefieldMapFrame.groupMembersDataProvider:SetUnitPinSize("party", BATTLEFIELD_MAP_PARTY_MEMBER_SIZE * SCALE)
--         BattlefieldMapFrame.groupMembersDataProvider:SetUnitPinSize("raid", BATTLEFIELD_MAP_RAID_MEMBER_SIZE * SCALE)
--     end
-- end

-- override system
-- UNIT_POSITION_FRAME_DEFAULT_USE_CLASS_COLOR = true
local UNIT_TEXTURE = 'Interface\\AddOns\\BattleInfo\\unit_icon.tga'

-- local 

local replaceTexture = false

local function ReplacePinTextureIfNeeded(pin)
    if not replaceTexture then
        return
    end

    pin:SetPinTexture("raid", UNIT_TEXTURE)
    pin:SetPinTexture("party", UNIT_TEXTURE)
end

local function UpdatePinTexture()
    if not BattlefieldMapFrame then
        return
    end

    if replaceTexture then
        for pin in BattlefieldMapFrame:EnumeratePinsByTemplate("GroupMembersPinTemplate") do
            pin:SetAppearanceField("party", "useClassColor", true)
            pin:SetAppearanceField("raid", "useClassColor", true)

            ReplacePinTextureIfNeeded(pin)
        end
    else
        for pin in BattlefieldMapFrame:EnumeratePinsByTemplate("GroupMembersPinTemplate") do
            pin:SetAppearanceField("party", "useClassColor", UNIT_POSITION_FRAME_DEFAULT_USE_CLASS_COLOR)
            pin:SetAppearanceField("raid", "useClassColor", UNIT_POSITION_FRAME_DEFAULT_USE_CLASS_COLOR)
            pin:UpdateAppearanceData()
        end
    end
end

RegAddonLoaded("Blizzard_BattlefieldMap", function()
    for pin in BattlefieldMapFrame:EnumeratePinsByTemplate("GroupMembersPinTemplate") do
        hooksecurefunc(pin, "UpdateAppearanceData", ReplacePinTextureIfNeeded)
    end

    UpdatePinTexture()
end)

RegEvent("ADDON_LOADED", function()
    RegisterKeyChangedCallback("map_unit_color", function(v)
        replaceTexture = v
        UpdatePinTexture()
    end)    
end)
