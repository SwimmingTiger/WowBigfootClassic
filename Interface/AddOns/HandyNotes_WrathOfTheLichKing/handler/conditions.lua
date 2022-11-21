local myname, ns = ...
local Class = ns.Class

local GetPlayerAuraBySpellID = C_UnitAuras and C_UnitAuras.GetPlayerAuraBySpellID or _G.GetPlayerAuraBySpellID

ns.conditions = {}

--[[
API:
condition = ns.Condition.GarrisonTalent(1912, 4)

condition:Matched() -> bool
condition:Label() -> string
]]

local Condition = Class{
    Initialize = function(self, id) self.id = id end,
    Label = function(self) return ('{%s:%d}'):format(self.type, self.id) end,
    Matched = function() return false end,
}
local Negated = function(parent) return {
    __parent = parent,
    Matched = function(self) return not self.__parent.Matched(self) end,
} end

ns.conditions.Achievement = Class{
    __parent = Condition,
    type = 'achievement',
    Matched = function(self) return (select(4, GetAchievementInfo(self.id))) end,
}

ns.conditions.AuraActive = Class{
    __parent = Condition,
    type = 'spell',
    Matched = function(self) return GetPlayerAuraBySpellID(self.id) end,
}
ns.conditions.AuraInactive = Class(Negated(ns.conditions.AuraActive))

ns.conditions.Covenant = Class{
    __parent = Condition,
    type = 'covenant',
    Matched = function(self) return self.id == C_Covenants.GetActiveCovenantID() end,
}

ns.conditions.GarrisonTalent = Class{
    __parent = Condition,
    type = 'garrisontalent',
    Initialize = function(self, id, rank)
        self.id = id
        self.rank = rank
    end,
    Label = function(self)
        local info = C_Garrison.GetTalentInfo(self.id)
        local name = info and info.name and ("{garrisontalent:%d}"):format(self.id) or UNKNOWN
        if self.rank then
            return AZERITE_ESSENCE_TOOLTIP_NAME_RANK:format(name, self.rank)
        else
            return name
        end
    end,
    Matched = function(self)
        local info = C_Garrison.GetTalentInfo(self.id)
        return info and info.researched and (not self.rank or info.talentRank >= self.rank)
    end
}

ns.conditions.Item = Class{
    __parent = Condition,
    type = 'item',
    Initialize = function(self, id, count)
        self.id = id
        self.count = count
    end,
    Label = function(self)
        if self.count and self.count > 1 then
            return ("{item:%d} x%d"):format(self.id, self.count)
        end
        return self.__parent.Label(self)
    end,
    Matched = function(self) return GetItemCount(self.id, true) >= (self.count or 1) end,
}

ns.conditions.QuestComplete = Class{
    __parent = Condition,
    type = 'quest',
    Matched = function(self) return C_QuestLog.IsQuestFlaggedCompleted(self.id) end,
}
ns.conditions.QuestIncomplete = Class(Negated(ns.conditions.QuestComplete))

ns.conditions.WorldQuestActive = Class{
    __parent = Condition,
    type = 'worldquest',
    Matched = function(self) return C_TaskQuest.IsActive(self.id) or C_QuestLog.IsQuestFlaggedCompleted(self.id) end,
}

ns.conditions.Vignette = Class{
    __parent = Condition,
    type = 'vignette',
    FindVignette = function(self)
        local vignettes = C_VignetteInfo.GetVignettes()
        for _, vignetteGUID in ipairs(vignettes) do
            local vignetteInfo = C_VignetteInfo.GetVignetteInfo(vignetteGUID)
            if vignetteInfo and vignetteInfo.vignetteID == self.id then
                return vignetteInfo
            end
        end
        return false
    end,
    Matched = function(self) return self:FindVignette() end,
    Label = function(self)
        local vignetteInfo = self:FindVignette()
        if vignetteInfo and vignetteInfo.name then
            return vignetteInfo.name
        end
        return self.__parent.Label(self)
    end,
}

-- Helpers:

do
    local function check(cond) return cond:Matched() end
    ns.conditions.check = function(conditions)
        return ns.doTest(check, conditions)
    end

    local t = {}
    ns.conditions.summarize = function(conditions)
        -- ERR_USE_LOCKED_WITH_ITEM_S
        table.wipe(t)
        if type(conditions) == "table" and not conditions.__parent then
            for _, condition in ipairs(conditions) do
                table.insert(t, condition:Label())
            end
            return ERR_USE_LOCKED_WITH_ITEM_S:format(string.join(', ', unpack(t)))
        end
        return ERR_USE_LOCKED_WITH_ITEM_S:format(conditions:Label())
    end
end
