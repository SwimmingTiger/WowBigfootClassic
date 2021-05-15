-- Copyright © 2008 - 2012 Xianghar  <xian@zron.de>
-- All Rights Reserved.
-- This code is not to be modified or distributed without written permission by the author.
-- Current distribution permissions only include curse.com, wowinterface.com and their respective addon updaters

if select(2,UnitClass("player")) ~= "SHAMAN" then return end

local SpellIDs = TotemTimers.SpellIDs
local SpellTextures = TotemTimers.SpellTextures
local SpellNames = TotemTimers.SpellNames
local AvailableSpells = TotemTimers.AvailableSpells
local FlameShockID = SpellIDs.FlameShock
local FlameShockName = SpellNames[SpellIDs.FlameShock]
local LightningShieldName = SpellNames[SpellIDs.LightningShield]
local UnleashFlameName = SpellNames[SpellIDs.UnleashFlame]
local WaterShieldName = SpellNames[SpellIDs.WaterShield]

local cds = {}
--local spells = {SpellNames[SpellIDs.StormStrike], SpellNames[SpellIDs.EarthShock], SpellNames[SpellIDs.LavaLash], SpellNames[SpellIDs.FlameShock]}
local maelstrom = CreateFrame("StatusBar", "TotemTimers_MaelstromBar", UIParent, "XiTimersTimerBarTemplate, SecureActionButtonTemplate")
local maelstrombutton = CreateFrame("Button", "TotemTimers_MaelstromBarButton", TotemTimers_MaelstromBar, "ActionButtonTemplate, SecureActionButtonTemplate")
local playerName = UnitName("player")
local role = 2

local num_CD_Spells = {[2]=12,[1]=9,[3]=9,}
TotemTimers.num_CD_Spells = num_CD_Spells

local function NoUpdate()
end

local ShieldName = SpellNames[SpellIDs.LightningShield]

local CD_Spells = {
    [2] = {
    --[[    [1] = SpellIDs.StormStrike,
        [2] = SpellIDs.FlameShock,
        [3] = SpellIDs.LavaLash,
        [4] = SpellIDs.FireNova,
        [5] = SpellIDs.Searing,
        [6] = SpellIDs.ShamanisticRage,
        [7] = SpellIDs.WindShear,
        [8] = SpellIDs.LightningShield,
        [9] = SpellIDs.UnleashElements,
        [10] = SpellIDs.ElementalBlast,
		[11] = SpellIDs.SpiritWalk,
		[12] = SpellIDs.LiquidMagma,
        [21] = SpellIDs.FlameShock,
        [22] = SpellIDs.Maelstrom,
        ]]
    },
    [1] = {
    --[[    [1] = SpellIDs.FlameShock,
        [2] = SpellIDs.LavaBurst,
        [3] = SpellIDs.Thunderstorm,
        [4] = SpellIDs.Searing,
        [5] = SpellIDs.LightningShield,
        [6] = SpellIDs.WindShear,
        [7] = SpellIDs.UnleashFlameEle,
		[8] = SpellIDs.ElementalBlast,
		[9] = SpellIDs.LiquidMagma,
		]]
    },
    
    [3] = {
    --[[    [1] = SpellIDs.Riptide,
        [2] = SpellIDs.HealingRain,
        [3] = SpellIDs.WaterShield,
        [4] = SpellIDs.EarthShock,
        [5] = SpellIDs.WindShear,
        [6] = SpellIDs.UnleashLife,
        [7] = SpellIDs.PurifySpirit,
		[8] = SpellIDs.ElementalBlast,
		[9] = SpellIDs.ChainHeal,
		]]
    },
}

TotemTimers.CD_Spells = CD_Spells

local function ActivateCD(self)
    XiTimers.Activate(self)
end

   
local function ChangeCDOrder(self,spell)
    if InCombatLockdown() then return end
    if not spell then return end
    local _,spell1 = GetSpellBookItemInfo(spell, "BOOKTYPE_SPELL")
    local spell2 = self:GetAttribute("orderspell")    
    if not spell2 or not spell1 then return end
    local spellnum1, spellnum2 = nil,nil
    for i=1,num_CD_Spells[role] do
        if CD_Spells[role][i] == spell1 then spellnum1 = i end
        if CD_Spells[role][i] == spell2 then spellnum2 = i end        
    end
    if not spellnum1 or not spellnum2 then return end
    local order1, order2 = nil
    for i=1,#TotemTimers.ActiveProfile.EnhanceCDs_Order[role] do
        if TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i] == spellnum1 then order1 = i end
        if TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i] == spellnum2 then order2 = i end
    end
    if not order1 or not order2 then return end
    TotemTimers.ActiveProfile.EnhanceCDs_Order[role][order1], TotemTimers.ActiveProfile.EnhanceCDs_Order[role][order2] =
        TotemTimers.ActiveProfile.EnhanceCDs_Order[role][order2], TotemTimers.ActiveProfile.EnhanceCDs_Order[role][order1]
    TotemTimers.LayoutEnhanceCDs()
end
   
function TotemTimers.CreateEnhanceCDs()
    for i = 1,12 do
        cds[i] = XiTimers:new(1)
        cds[i].events = {"SPELL_UPDATE_COOLDOWN"}
        cds[i].dontFlash = true
        cds[i].timeStyle = "sec"
        cds[i].button.anchorframe = TotemTimers_EnhanceCDsFrame
        cds[i].button:SetAttribute("*type*", "spell")
        --cds[i].activate = ActivateCD
        cds[i].reverseAlpha = true
        --cds[i].dontAlpha = true
        cds[i].button.icons[1]:SetAlpha(1)
        cds[i].button:SetScript("OnEvent", TotemTimers.EnhanceCDEvents)
        cds[i].button:RegisterForClicks("LeftButtonUp", "RightButtonUp", "MiddleButtonUp")
    end
    --cds[8].prohibitCooldown = true
    --cds[8].reverseAlpha = nil
    cds[13] = XiTimers:new(1)
    cds[13].button:Disable()
    cds[13].button.icons[1]:SetVertexColor(1,1,1)
	TotemTimers.fs = cds[13]
    cds[1].button.bar:SetStatusBarColor(1,0.2,0.2,0.8)
    cds[2].button.bar:SetStatusBarColor(1,0.2,0.2,0.8)
	
	TotemTimers.EnhanceCDs = cds

    
    maelstrom.icon = getglobal("TotemTimers_MaelstromBarIcon")
    maelstrom.background = getglobal("TotemTimers_MaelstromBarBackground")
    maelstrom.icon:SetTexture(SpellTextures[SpellIDs.Maelstrom])
    maelstrom.icon:Show()
    maelstrom.icon:SetPoint("RIGHT", maelstrom, "LEFT")
    maelstrom.background:Show()
    maelstrom.background:SetValue(1)
    maelstrom.background:SetWidth(100)
    maelstrom.background:SetStatusBarColor(1, 0, 0, 0.1)
    maelstrom:SetWidth(100)
    maelstrom:SetScript("OnEvent", TotemTimers.MaelstromEvent)
    maelstrom:SetScript("OnUpdate", TotemTimers.MaelstromBarUpdate)
    maelstrom.text = getglobal("TotemTimers_MaelstromBarTime")
    TotemTimers.maelstrom = maelstrom
    TotemTimers.maelstrombutton = maelstrombutton
    maelstrombutton:SetWidth(100)
    maelstrombutton:SetHeight(maelstrom.background:GetHeight())
    maelstrombutton:SetPoint("CENTER", maelstrom, "CENTER")
    maelstrombutton:SetNormalTexture(nil)
    maelstrombutton:SetHighlightTexture("Interface\\AddOns\\TotemTimers\\MaelstromHilight")
    maelstrombutton:SetPushedTexture("Interface\\AddOns\\TotemTimers\\MaelstromPushed")
    maelstrombutton:SetAttribute("*type*", "spell")
    maelstrombutton:RegisterForClicks("LeftButtonUp", "RightButtonUp")
    maelstrombutton:SetAttribute("*spell1", SpellNames[SpellIDs.LightningBolt])
    maelstrombutton:SetAttribute("*spell2", SpellNames[SpellIDs.ChainLightning])   

    local fs = cds[13]
    fs.button.icons[1]:SetTexture(SpellTextures[SpellIDs.FlameShock])
    fs.button.anchorframe = TotemTimers_EnhanceCDsFrame
    fs.dontAlpha = true
    fs.dontFlash = true
    fs.timeStyle = "sec"
    fs.button:SetAttribute("*type1", "spell")
    fs.button:SetAttribute("*spell1", SpellNames[SpellIDs.FlameShock])
    fs.Activate = ActivateCD
    fs.button.icons[1]:SetAlpha(1)
    -- fs.reverseAlpha = true
	fs.rangeCheck = SpellNames[SpellIDs.FlameShock]
	fs.manaCheck = SpellNames[SpellIDs.FlameShock]
    fs.button:SetScript("OnEvent", TotemTimers.FlameShockEvent)
    fs.events[1] = "COMBAT_LOG_EVENT_UNFILTERED"
    fs.events[2] = "UNIT_AURA"
    fs.events[3] = "PLAYER_REGEN_ENABLED"
    fs.events[4] = "PLAYER_REGEN_DISABLED"
    fs.events[5] = "PLAYER_TARGET_CHANGED"
	fs.forceBar = true
    fs:SetTimerBarPos("RIGHT")
    fs:SetTimeWidth(100)
    fs:SetBarColor(1,0.5,0)
	

    for i=1,11 do
        cds[i].button:SetAttribute("_ondragstart",[[if IsShiftKeyDown() and self:GetAttribute("orderspell")~=0 then
                                                    return "spell", self:GetAttribute("orderspell")
                                              else control:CallMethod("StartMove") end]])
        cds[i].button:SetAttribute("_onreceivedrag",[[ if kind == "spell" then
                                                   control:CallMethod("ChangeCDOrder", value, ...)
                                                    return "clear"
                                              end]])
        cds[i].button.ChangeCDOrder = ChangeCDOrder
    end
    
    cds[1].hasBorderTimer = true
    cds[2].hasBorderTimer = true

end

function TotemTimers.ConfigEnhanceCDs() 
    role = GetSpecialization()
    if not role then role = 2 end
   
    
    for i=1,12 do
        cds[i]:Deactivate()
    end
    
    maelstrom:UnregisterAllEvents()
    maelstrom:Hide()
    
    if not TotemTimers.ActiveProfile.EnhanceCDs then return end

    if TotemTimers.AvailableSpells[SpellIDs.StormStrike] then --if Stormstrike not available yet show Primal Strike
        CD_Spells[2][1] = SpellIDs.StormStrike
    else
        CD_Spells[2][1] = SpellIDs.PrimalStrike
    end
	
    
    for i=1,num_CD_Spells[role] do
        cds[i].button.cdspell = CD_Spells[role][i]
        cds[i].button.icons[1]:SetTexture(SpellTextures[CD_Spells[role][i]])
        cds[i].button:SetAttribute("*spell1", SpellNames[CD_Spells[role][i]])
		cds[i].button:SetAttribute("*spell2", nil)
		cds[i].button:SetAttribute("*spell3", nil)
        cds[i].rangeCheck = SpellNames[CD_Spells[role][i]]
        cds[i].manaCheck = SpellNames[CD_Spells[role][i]]
        cds[i].button:SetScript("OnEvent", TotemTimers.EnhanceCDEvents)
        cds[i].Update = nil
        cds[i].prohibitCooldown = false
        cds[i].button:SetAttribute("orderspell", CD_Spells[role][i])
        cds[i].events = {"SPELL_UPDATE_COOLDOWN"}
		cds[i].playerEvents = {}
		cds[i].reverseAlpha = true
		cds[i].Stop = nil
    end
    
    if role == 2 then
        local es = cds[2]
        es.button.icons[1]:SetTexture(SpellTextures[SpellIDs.FlameShock])
        es.button:SetAttribute("*spell1", SpellNames[SpellIDs.FlameShock])
        es.button:SetAttribute("*spell2", SpellNames[SpellIDs.FrostShock])
        es.events[2] = "UNIT_AURA"
        es.button:SetScript("OnEvent", TotemTimers.UnleashFlameEvent)
    
        --Searing Totem Dur.
        cds[5].button:SetScript("OnEvent", TotemTimers.SearingTotemEvent)
		cds[5].button:SetAttribute("*spell2", SpellIDs.FireElemental)
		cds[5].button:SetAttribute("*spell3", SpellIDs.Magma)
        cds[5].events[2] = "PLAYER_TOTEM_UPDATE"  
		cds[5].Stop = TotemTimers.SearingTotemStop
        --cds[8].Update = NoUpdate
        cds[8].playerEvents[1] = "UNIT_AURA"
        cds[8].button:SetScript("OnEvent", TotemTimers.ShieldChargeEvent)
        --cds[8].prohibitCooldown = true
		cds[8].reverseAlpha = false
        ShieldName = SpellNames[SpellIDs.LightningShield]

    end
    
    if role == 1 then
	
	    local fs = cds[1]
        fs.button:SetAttribute("*spell1", SpellNames[SpellIDs.FlameShock])
        fs.button:SetAttribute("*spell2", SpellNames[SpellIDs.EarthShock])
        fs.button:SetAttribute("*spell3", SpellNames[SpellIDs.FrostShock])
    
        cds[1].playerEvents[1] = "UNIT_AURA"
		cds[1].events[2] = "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW"
		cds[1].events[3] = "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" 
		cds[1].button.glowSpell = SpellIDs.EarthShock
        cds[1].button:SetScript("OnEvent", TotemTimers.UnleashFlameEvent)
		
		cds[2].events[2] = "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW"
		cds[2].events[3] = "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" 
		cds[2].button.glowSpell = SpellIDs.LavaBurst
    
        
        --Searing Totem Dur.
        cds[4].button:SetScript("OnEvent", TotemTimers.SearingTotemEvent)
        cds[4].events[4] = "PLAYER_TOTEM_UPDATE"
		cds[4].button:SetAttribute("*spell2", SpellIDs.FireElemental)
		cds[4].button:SetAttribute("*spell3", SpellIDs.Magma)
		cds[4].Stop = TotemTimers.SearingTotemStop
        
        cds[5].Update = NoUpdate
        cds[5].button:SetScript("OnEvent", TotemTimers.ShieldChargeEvent)
        cds[5].playerEvents[1] = "UNIT_AURA"
        cds[5].prohibitCooldown = true
		cds[5].reverseAlpha = false
        ShieldName = SpellNames[SpellIDs.LightningShield]
    end
    
    if role == 3 then
	
		local fs = cds[4]
        fs.button:SetAttribute("*spell1", SpellNames[SpellIDs.EarthShock])
        fs.button:SetAttribute("*spell2", SpellNames[SpellIDs.FlameShock])
        fs.button:SetAttribute("*spell3", SpellNames[SpellIDs.FrostShock])
		-- hack for bugged isspellknown
		TotemTimers.AvailableSpells[SpellIDs.PurifySpirit] = true
		
        cds[3].button:SetScript("OnEvent", TotemTimers.ShieldChargeEvent)
        cds[3].playerEvents[1] = "UNIT_AURA"
        --cds[3].Update = NoUpdate
        --cds[3].prohibitCooldown = true
		cds[3].reverseAlpha = false
        ShieldName = SpellNames[SpellIDs.WaterShield]
    end
    
    if role == 2 and TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][22] and AvailableSpells[SpellIDs.Maelstrom] then
        maelstrom:RegisterUnitEvent("UNIT_AURA", "player")
        maelstrom:RegisterEvent("PLAYER_REGEN_ENABLED")
        maelstrom:RegisterEvent("PLAYER_REGEN_DISABLED")
		maelstrom:RegisterEvent("PET_BATTLE_OPENING_START")
		maelstrom:RegisterEvent("PET_BATTLE_CLOSE")
		maelstrom:RegisterUnitEvent("UNIT_ENTERED_VEHICLE", "player")
		maelstrom:RegisterUnitEvent("UNIT_EXITED_VEHICLE", "player")
        maelstrom:Show()
        if not InCombatLockdown() and TotemTimers.ActiveProfile.HideEnhanceCDsOOC then 
            maelstrom:Hide()
        end
    end
    
    
    if AvailableSpells[SpellIDs.FlameShock]
        and ((role == 2 and TotemTimers.ActiveProfile.EnhanceCDs_Spells[2][21])
          or (role == 1 and TotemTimers.ActiveProfile.EnhanceCDs_Spells[1][20])
          or (role == 3 and TotemTimers.ActiveProfile.EnhanceCDs_Spells[3][20]))
    then
        cds[13]:Activate()
    end
    
    for i=1,num_CD_Spells[role] do 
        if TotemTimers.ActiveProfile.EnhanceCDs_Spells[role][i] and AvailableSpells[CD_Spells[role][TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i]]] then
            cds[i]:Activate()
        end
    end
end

local active_cds = {}

local function ConvertCoords(frame1, frame2)
    return frame1:GetEffectiveScale()/frame2:GetEffectiveScale()
end


function TotemTimers.LayoutEnhanceCDs()
    wipe(active_cds)
    for i=1,num_CD_Spells[role] do
        if cds[TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i]].active then
            table.insert(active_cds,cds[TotemTimers.ActiveProfile.EnhanceCDs_Order[role][i]])
        end
    end
    for i=1,12 do 
        cds[i]:ClearAnchors()
        cds[i].button:ClearAllPoints()
    end
    maelstrom:ClearAllPoints()
    local xmove, xmovebottom = 0, 0
    local fsreltop = nil
    local fsrelbottom = nil
    if #active_cds == 0 then
        if cds[9].active then
            cds[9].button:SetPoint("TOPRIGHT", TotemTimers_EnhanceCDsFrame)
        else
            cds[9].button:SetPoint("BOTTOMRIGHT", TotemTimers_EnhanceCDsFrame)
        end
        if cds[10].active then
            cds[10].button:SetPoint("BOTTOM", TotemTimers_EnhanceCDsFrame)
        end
    elseif #active_cds == 1 then
        active_cds[1].button:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        fsreltop = active_cds[1].button
        fsrelbottom = active_cds[1].button
        xmovetop = -(TotemTimers.ActiveProfile.EnhanceCDsSize*3.5+5)
        xmovebottom = -(TotemTimers.ActiveProfile.EnhanceCDsSize*3.5+5)
    elseif #active_cds == 2 then
        active_cds[1].button:SetPoint("RIGHT", TotemTimers_EnhanceCDsFrame, "CENTER", -3, 0)
        active_cds[2]:Anchor(active_cds[1], "LEFT")
        fsreltop = active_cds[1].button
        fsrelbottom = active_cds[1].button
        xmovetop = -(TotemTimers.ActiveProfile.EnhanceCDsSize*2.5+5)
        xmovebottom = -(TotemTimers.ActiveProfile.EnhanceCDsSize*2.5+5)
    elseif #active_cds == 3 then
        active_cds[2].button:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[3]:Anchor(active_cds[2], "LEFT")
        fsreltop = active_cds[1].button
        fsrelbottom = active_cds[1].button
        xmovebottom = 0
        xmovetop = 0
    elseif #active_cds == 4 then 
        active_cds[2].button:SetPoint("RIGHT", TotemTimers_EnhanceCDsFrame, -3, 0)
        active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[3]:Anchor(active_cds[2], "LEFT")
        active_cds[4]:Anchor(active_cds[3], "LEFT")
        xmovebottom = (TotemTimers.ActiveProfile.EnhanceCDsSize*0.5+5)
        xmovetop = 0
        fsreltop = cds[1].button
        fsrelbottom = cds[1].button
    elseif #active_cds == 5 then
        active_cds[1].button:SetPoint("RIGHT", TotemTimers_EnhanceCDsFrame, "CENTER", -3, 0)
        active_cds[2]:Anchor(active_cds[1], "LEFT")
        active_cds[3]:Anchor(active_cds[1], "TOPRIGHT", "BOTTOM", true)
        active_cds[4]:Anchor(active_cds[3], "LEFT")
        active_cds[5]:Anchor(active_cds[4], "LEFT")
        fsreltop = cds[1].button
        fsrelbottom = cds[3].button
        xmovebottom = 0
        xmovetop = 0
    elseif #active_cds == 6 then
        active_cds[2].button:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[3]:Anchor(active_cds[2], "LEFT")
        active_cds[5]:Anchor(active_cds[2], "TOP", "BOTTOM")
        active_cds[4]:Anchor(active_cds[5],"RIGHT")
        active_cds[6]:Anchor(active_cds[5],"LEFT")
        fsreltop = cds[1].button
        fsrelbottom = cds[3].button
        xmovebottom = 0
        xmovetop = 0
    elseif #active_cds == 7 then
        active_cds[2].button:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[3]:Anchor(active_cds[2], "LEFT")
        active_cds[5]:Anchor(active_cds[2], "TOPRIGHT", "BOTTOM", true)
        active_cds[4]:Anchor(active_cds[5], "RIGHT")
        active_cds[6]:Anchor(active_cds[5], "LEFT")
        active_cds[7]:Anchor(active_cds[6], "LEFT")
        fsreltop = cds[1].button
        fsrelbottom = cds[3].button
        xmovebottom = 0
        xmovetop = 0
    elseif #active_cds == 8 then
        active_cds[2].button:SetPoint("RIGHT", TotemTimers_EnhanceCDsFrame, -3, 0)
        active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[3]:Anchor(active_cds[2], "LEFT")
        active_cds[4]:Anchor(active_cds[3], "LEFT")
        active_cds[5]:Anchor(active_cds[1], "TOP", "BOTTOM")
        active_cds[6]:Anchor(active_cds[2], "TOP", "BOTTOM")
        active_cds[7]:Anchor(active_cds[3], "TOP", "BOTTOM")
        active_cds[8]:Anchor(active_cds[4], "TOP", "BOTTOM")
        fsreltop = cds[1].button
        fsrelbottom = cds[3].button
        xmovebottom = 0
        xmovetop = 0
    elseif #active_cds == 9 then
        active_cds[2].button:SetPoint("RIGHT", TotemTimers_EnhanceCDsFrame, -3, 0)
        active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[3]:Anchor(active_cds[2], "LEFT")
        active_cds[4]:Anchor(active_cds[3], "LEFT")
        active_cds[6]:Anchor(active_cds[2], "TOPRIGHT", "BOTTOM", true)
        active_cds[5]:Anchor(active_cds[6], "RIGHT")
        active_cds[7]:Anchor(active_cds[6], "LEFT")
        active_cds[8]:Anchor(active_cds[7], "LEFT")
        active_cds[9]:Anchor(active_cds[8], "LEFT")
        fsreltop = cds[1].button
        fsrelbottom = cds[3].button
        xmovebottom = 0
        xmovetop = 0
    elseif #active_cds == 10 then
        active_cds[3].button:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        active_cds[2]:Anchor(active_cds[3], "RIGHT")
        active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[4]:Anchor(active_cds[3], "LEFT")
        active_cds[5]:Anchor(active_cds[4], "LEFT")
        active_cds[6]:Anchor(active_cds[1], "TOP", "BOTTOM")
        active_cds[7]:Anchor(active_cds[2], "TOP", "BOTTOM")
        active_cds[8]:Anchor(active_cds[3], "TOP", "BOTTOM")
        active_cds[9]:Anchor(active_cds[4], "TOP", "BOTTOM")
        active_cds[10]:Anchor(active_cds[5], "TOP", "BOTTOM")
        fsreltop = cds[1].button
        fsrelbottom = cds[3].button
        xmovebottom = 0
        xmovetop = 0
    elseif #active_cds == 11 then
        active_cds[3].button:SetPoint("CENTER", TotemTimers_EnhanceCDsFrame)
        active_cds[2]:Anchor(active_cds[3], "RIGHT")
        active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[4]:Anchor(active_cds[3], "LEFT")
        active_cds[5]:Anchor(active_cds[4], "LEFT")
        active_cds[6]:Anchor(active_cds[1], "TOPRIGHT", "BOTTOM", true)
        active_cds[7]:Anchor(active_cds[6], "LEFT")
        active_cds[8]:Anchor(active_cds[7], "LEFT")
        active_cds[9]:Anchor(active_cds[8], "LEFT")
        active_cds[10]:Anchor(active_cds[9], "LEFT")
        active_cds[11]:Anchor(active_cds[10], "LEFT")
        fsreltop = cds[1].button
        fsrelbottom = cds[3].button
        xmovebottom = 0
        xmovetop = 0
	elseif #active_cds == 12 then
	    active_cds[3].button:SetPoint("RIGHT", TotemTimers_EnhanceCDsFrame, -3, 0)
        active_cds[2]:Anchor(active_cds[3], "RIGHT")
		active_cds[1]:Anchor(active_cds[2], "RIGHT")
        active_cds[4]:Anchor(active_cds[3], "LEFT")
        active_cds[5]:Anchor(active_cds[4], "LEFT")
		active_cds[6]:Anchor(active_cds[5], "LEFT")
		active_cds[7]:Anchor(active_cds[1], "TOP", "BOTTOM")
        active_cds[8]:Anchor(active_cds[2], "TOP", "BOTTOM")
        active_cds[9]:Anchor(active_cds[3], "TOP", "BOTTOM")
        active_cds[10]:Anchor(active_cds[4], "TOP", "BOTTOM")
        active_cds[11]:Anchor(active_cds[5], "TOP", "BOTTOM")
		active_cds[12]:Anchor(active_cds[6], "TOP", "BOTTOM")

        fsreltop = cds[1].button
        fsrelbottom = cds[3].button
        xmovebottom = 0
        xmovetop = 0
    end
    local vertdist = not (TotemTimers.ActiveProfile.FlameShockDurationOnTop or TotemTimers.ActiveProfile.TimersOnButtons or
            TotemTimers.ActiveProfile.CDTimersOnButtons) and TotemTimers.ActiveProfile.EnhanceCDsTimeHeight or 0
    if #active_cds > 4 then vertdist = vertdist*2 end
    vertdist = vertdist*ConvertCoords(cds[9].timerBars[1], cds[13].button)
    vertdist = vertdist+0.5*cds[9].button:GetHeight()*ConvertCoords(cds[9].button,cds[13].button)
    if #active_cds > 4 and not TotemTimers.ActiveProfile.FlameShockDurationOnTop then vertdist = vertdist+(5+cds[9].button:GetHeight())*ConvertCoords(cds[9].button,cds[13].button) end
    vertdist = vertdist+5*ConvertCoords(cds[9].button, cds[13].button)
    if not TotemTimers.ActiveProfile.FlameShockDurationOnTop then vertdist = -vertdist end
    
    if not TotemTimers.ActiveProfile.FlameShockDurationOnTop then 
        cds[13].button:SetPoint("TOPRIGHT", TotemTimers_EnhanceCDsFrame, "CENTER", -(TotemTimers.ActiveProfile.EnhanceCDsSize*3.5+5), vertdist)
    else
        cds[13].button:SetPoint("BOTTOMRIGHT", TotemTimers_EnhanceCDsFrame, "CENTER", -(TotemTimers.ActiveProfile.EnhanceCDsSize*3.5+5), vertdist)
    end
    
    
    vertdist = 0
    if cds[13].active then
        vertdist = vertdist+(cds[13].button:GetHeight()+5)*ConvertCoords(cds[13].button, maelstrom)
    end
    if not TotemTimers.ActiveProfile.FlameShockDurationOnTop then
        maelstrom:SetPoint("TOPLEFT", cds[13].button, "TOPRIGHT", 0, -vertdist)
    else
        maelstrom:SetPoint("BOTTOMLEFT", cds[13].button, "BOTTOMRIGHT", 0, vertdist)
    end
    --maelstrom:SetPoint("TOPLEFT", cds[12].button, "BOTTOMRIGHT", 0, -5)
end

function TotemTimers.ActivateEnhanceCDs()
    TotemTimers.ConfigEnhanceCDs()
    TotemTimers.LayoutEnhanceCDs()
end

function TotemTimers.DeactivateEnhanceCDs()
    for k,v in pairs(cds) do
        v:Deactivate()
    end
    maelstrom:UnregisterEvent("UNIT_AURA")
    maelstrom:UnregisterEvent("PLAYER_REGEN_ENABLED")
    maelstrom:UnregisterEvent("PLAYER_REGEN_DISABLED")
    maelstrom:Hide()
end

function TotemTimers.EnhanceCDEvents(self, event, spell)
    local settings = TotemTimers.ActiveProfile
    if event == "SPELL_UPDATE_COOLDOWN" and AvailableSpells[self.cdspell] then
		local start, duration, enable = GetSpellCooldown(self.cdspell)
        if (not start and not duration) then --or (duration <= 1.5 and not InCombatLockdown()) then 			
            self.timer:Stop(1)					
        else
            if duration <= 1.5 then
                self.timer:Stop(1)
            elseif duration > 1.5 then
                self.timer:Start(1,start+duration-GetTime(),duration)
            end
            CooldownFrame_Set(self.cooldown, start, duration, enable)
        end 
    elseif event == "SPELL_ACTIVATION_OVERLAY_GLOW_SHOW" then 
		if spell == self.glowSpell then
			ActionButton_ShowOverlayGlow(self)			
		end
	elseif event == "SPELL_ACTIVATION_OVERLAY_GLOW_HIDE" then		
		if spell == self.glowSpell then
			ActionButton_HideOverlayGlow(self)
		end		
	end
end


function TotemTimers.SearingTotemEvent(self,event,...)
    local element = ...
    if event == "PLAYER_TOTEM_UPDATE" then
        if element == 1 then
            local _, totem, startTime, duration, icon = GetTotemInfo(1)
            if (icon == SpellTextures[SpellIDs.Searing] or icon == SpellTextures[SpellIDs.Magma] or icon == SpellTextures[SpellIDs.FireElemental]) and duration > 0 then
				self.icon:SetTexture(icon)
                self.timer:Start(1, duration)
            elseif self.timer.timers[1] > 0 then 
                self.timer:Stop(1)
            end
        end
    elseif event ~= "SPELL_UPDATE_COOLDOWN" then
        TotemTimers.EnhanceCDEvents(self,event,...)
    end
end

function TotemTimers.SearingTotemStop(self, ...)
	self.button.icon:SetTexture(SpellTextures[SpellIDs.Searing])
	XiTimers.Stop(self, ...)
end


function TotemTimers.ShieldChargeEvent(self, event, ...)
	if event == "UNIT_AURA" and select(1,...) =="player" then
		local name,_,texture,count,_,duration,endtime = UnitAura("player", ShieldName)
		if name then
			if role == 1 then
				self.timer:Start(1, count, 15)
			else
				self.timer:Start(1, endtime-GetTime(), duration)
			end
		elseif self.timer.timers[1]>0 then
			self.timer:Stop(1)
		end
	elseif event ~= "SPELL_UPDATE_COOLDOWN" then
        TotemTimers.EnhanceCDEvents(self,event,...)
    end
end


local AuraGUID = nil
local FSName, FSEv, FSSource, FSTarget, FSSpell, FSBuffType, FSDuration, FSExpires, FSID = nil

local function CheckFSBuff(self, unit)
	local _
	local fsFound = false	
	FSName = ""
	for i=1,40 do
        FSName,_,_,_,_,FSDuration,FSExpires,FSSource,_,_,FSID = UnitDebuff(unit, FlameShockName)
        if FSID == FlameShockID and FSDuration and FSSource == "player" then 
			self.timer:Start(1, -1 * GetTime() + FSExpires, FSDuration)
			fsFound = true
			break
        end		
	end
	if not fsFound then
		self.timer:Stop(1)
	end
end

function TotemTimers.FlameShockEvent(self,event,unit,...)
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
		local _
        FSEv, _, _, FSSource, _, _, FSTarget, _, _, _, FSSpell = ...
		if FSEv == "UNIT_DIED" then
            if AuraGUID and FSTarget == AuraGUID then
                self.timer:Stop(1)
                AuraGUID = nil
            end
        end
    elseif (event == "PLAYER_TARGET_CHANGED" and UnitExists("target"))
	  or (event == "UNIT_AURA" and unit == "target") then
        AuraGUID = UnitGUID("target")
        CheckFSBuff(self, "target")
	elseif event == "PET_BATTLE_OPENING_START" then
		if self:IsShown() then
			self.shownBeforePet = true
			self:Hide()
		end
	elseif event == "PET_BATTLE_CLOSE" then
		if self.shownBeforePet then
			self:Show()
			self.shownBeforePet = false
		end
    end
end



local maelstromname = SpellNames[SpellIDs.Maelstrom]

function TotemTimers.MaelstromEvent(self, event, unit) 
    if event == "UNIT_AURA" and unit == "player"  then
        local name,_,_,count,_,duration,endtime = UnitBuff("player", maelstromname)
        self:SetValue(count or 0)
        self.text:SetText(tostring(count or ""))
        self.count = count
        if count then
            self:SetStatusBarColor(5-count, -0.33+count*0.33, 0, 1.0)
            self.background:SetStatusBarColor(1-count*0.2, count*0.2, 0, 0.1)
        else
            self:SetStatusBarColor(1, 0, 0, 1.0)
            self.background:SetStatusBarColor(1, 0, 0, 0.1)
        end
	elseif event == "PLAYER_REGEN_ENABLED" then
        if TotemTimers.ActiveProfile.HideEnhanceCDsOOC then
            self:Hide()
        end
        self:SetAlpha(TotemTimers.ActiveProfile.EnhanceCDsOOCAlpha)
    elseif event == "PLAYER_REGEN_DISABLED" then 
        if not self:IsVisible() then
            self:Show()
        end
        self:SetAlpha(1)
	elseif event == "PET_BATTLE_OPENING_START" or (event == "UNIT_ENTERED_VEHICLE" and not InCombatLockdown()) then 
		self:Hide()
	elseif event == "PET_BATTLE_CLOSE" or (event == "UNIT_EXITED_VEHICLE" and not InCombatLockdown()) then
		if not TotemTimers.ActiveProfile.HideEnhanceCDsOOC then
			self:Show()
		end
    end
end

function TotemTimers.MaelstromBarUpdate(self, ...)
    if self.count == 5 then
        self:SetStatusBarColor(1-BuffFrame.BuffAlphaValue, BuffFrame.BuffAlphaValue, 0, 1)
    end
end


function TotemTimers.UnleashFlameEvent(self, event, unit, ...)
    if event == "UNIT_AURA" and unit == "player" then
        local name,_,_,_,_,duration,endtime = UnitAura("player", UnleashFlameName)
		if name then
            local timeleft = endtime - GetTime()
			self.timer:StartBarTimer(timeleft, duration)
		elseif self.timer.barTimer>0 then
			self.timer:StopBarTimer() 
        end
    else
        TotemTimers.EnhanceCDEvents(self, event, unit, ...)
    end
end