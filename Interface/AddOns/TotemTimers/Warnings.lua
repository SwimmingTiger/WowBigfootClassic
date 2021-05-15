if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local L = LibStub("AceLocale-3.0"):GetLocale("TotemTimers", true)
local Sink = LibStub:GetLibrary("LibSink-2.0")
local LSM = LibStub:GetLibrary("LibSharedMedia-3.0", true)

local Warnings = nil

local lastWarning = nil
local lastWarningTime = nil

function XiTimers.InitWarnings(newwarnings)
    Warnings = newwarnings
end


function XiTimers.PlayWarning(self, warning, spell, icon)
    if not Warnings[warning].enabled or (warning == lastWarning and GetTime()-lastWarningTime < 1) then return end
    lastWarning = warning
    lastWarningTime = GetTime()
    local text = L[Warnings[warning].text]
    if spell then text = string.format(text,spell) end
    if Sink then
        Sink:Pour(TotemTimers, text, Warnings[warning].r,Warnings[warning].g, Warnings[warning].b,
            nil,nil,nil,nil,nil,icon)
    end
    local sound = LSM:Fetch("sound", Warnings[warning].sound)
    if sound then PlaySoundFile(sound, "Master") end
end
