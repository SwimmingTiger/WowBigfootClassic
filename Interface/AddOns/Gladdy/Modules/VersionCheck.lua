local tonumber, tostring, str_format = tonumber, tostring, string.format

local UnitName = UnitName
local IsInGroup, IsInRaid = IsInGroup, IsInRaid
local LE_PARTY_CATEGORY_HOME, LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_HOME, LE_PARTY_CATEGORY_INSTANCE

local Gladdy = LibStub("Gladdy")

local VersionCheck = Gladdy:NewModule("VersionCheck", 1, {
})
LibStub("AceComm-3.0"):Embed(VersionCheck)

function VersionCheck:Initialize()
    self.frames = {}

    self:RegisterMessage("JOINED_ARENA")
    self.playerName = UnitName("player")
end

function VersionCheck:Reset()
    self:UnregisterComm("GladdyVCheck")
end

function VersionCheck:JOINED_ARENA()
    self:RegisterComm("GladdyVCheck", VersionCheck.OnCommReceived)
    if IsInRaid(LE_PARTY_CATEGORY_HOME) then
        self:SendCommMessage("GladdyVCheck", str_format("%.2f", Gladdy.version_num), "RAID", self.playerName)
    elseif IsInGroup(LE_PARTY_CATEGORY_INSTANCE) or IsInRaid(LE_PARTY_CATEGORY_INSTANCE) then
        self:SendCommMessage("GladdyVCheck", str_format("%.2f", Gladdy.version_num), "INSTANCE_CHAT", self.playerName)
    elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
        self:SendCommMessage("GladdyVCheck", str_format("%.2f", Gladdy.version_num), "PARTY", self.playerName)
    end
end

function VersionCheck:Test(unit)
    if unit == "arena1" then
        self:RegisterComm("GladdyVCheck", VersionCheck.OnCommReceived)
        self:SendCommMessage("GladdyVCheck", tostring(Gladdy.version_num), "RAID", self.playerName)
    end
end

function VersionCheck.OnCommReceived(prefix, message, distribution, sender)
    if sender ~= VersionCheck.playerName then
        local addonVersion = str_format("%.2f", Gladdy.version_num)
        local message_num = tonumber(message) or 0
        if message and message_num <= Gladdy.version_num then
            --Gladdy:Print("Version", "\"".. addonVersion.."\"", "is up to date")
        else
            Gladdy:Warn("Current version", "\"".. addonVersion.."\"", "is outdated. Most recent version is", "\"".. message.."\"")
            Gladdy:Warn("Please download the latest Gladdy version at:")
            Gladdy:Warn("https://www.curseforge.com/wow/addons/gladdy-tbc or https://github.com/XiconQoo/Gladdy-TBC")
        end
    end
end

function VersionCheck:GetOptions()
    return nil
end
