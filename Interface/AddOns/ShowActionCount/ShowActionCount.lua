-- local resourceList = {}
local reagentsString = GetText('SPELL_REAGENTS')..'(.+)'
local reagentsString2 = GetText('SPELL_REAGENTS')..'|cffff2020(.+)|r'
local SACTooltip = CreateFrame("GameTooltip", "SACTooltip", UIParent, "GameTooltipTemplate")
SACTooltip:SetOwner(UIParent, "ANCHOR_NONE")
local function ShowActionCount_UpdateCount(actionButton)
    local text = actionButton.Count
    local action = actionButton.action
    if not IsItemAction(action) and GetActionCount(action) == 0 then
        -- 暴雪屏蔽了技能材料的GetActionCount获取
        local texture = GetActionTexture(action)
        if texture then
            local type, spellId = GetActionInfo(action)
            SACTooltip:ClearLines()
            SACTooltip:SetAction(action)
            for i=1, SACTooltip:NumLines() do
                local lineStr = _G['SACTooltipTextLeft'..i]:GetText()
                local rs, ers = string.find(lineStr, reagentsString), string.find(lineStr, reagentsString2)
                if  lineStr and ( rs or ers )then
                    local out = ers and gsub(lineStr, reagentsString2, '%1') or gsub(lineStr, reagentsString, '%1')
                    -- resourceList[spellId] = out
                    local count = GetItemCount(out)
                    if ( count > (actionButton.maxDisplayCount or 9999 ) ) then
                        text:SetText("*")
                    else
                        text:SetText(count)
                    end
                end
            end
        end
    end
    -- print(GetText('SPELL_REAGENTS'))
    -- for k,v in pairs(resourceList) do
    --     print(k,v)
    -- end
end

local function ShowActionCount_Init()
    hooksecurefunc("ActionButton_UpdateCount", ShowActionCount_UpdateCount)
end

ShowActionCount_Init()