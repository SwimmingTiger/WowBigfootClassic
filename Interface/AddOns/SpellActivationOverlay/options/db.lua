local AddonName, SAO = ...

-- Load database and use default values if needed
function SAO.LoadDB(self)
    local currentversion = 060;
    local db = SpellActivationOverlayDB or {};

    if not db.alert then
        db.alert = {};
    end
    if (type(db.alert.enabled) == "nil" and type(db.alert.opacity) == "nil") then
        db.alert.enabled = true;
        db.alert.opacity = 1;
    elseif (type(db.alert.opacity) == "nil") then
        db.alert.opacity = db.alert.enabled and 1 or 0;
    elseif (type(db.alert.enabled) == "nil") then
        db.alert.enabled = db.alert.opacity > 0;
    end
    if (type(db.alert.offset) == "nil") then
        db.alert.offset = 0;
    end
    if (type(db.alert.scale) == "nil") then
        db.alert.scale = 1;
    end

    if not db.glow then
        db.glow = {};
    end
    if (type(db.glow.enabled) == "nil") then
        db.glow.enabled = true;
    end

    db.version = currentversion;
    SpellActivationOverlayDB = db;
end

-- Utility frame dedicated to react to variable loading
local loader = CreateFrame("Frame", "SpellActivationOverlayDBLoader");
loader:RegisterEvent("VARIABLES_LOADED");
loader:SetScript("OnEvent", function (event)
    SAO:LoadDB();
    SAO:ApplyAllVariables();
    SpellActivationOverlayOptionsPanel_Init(SAO.OptionsPanel);
    loader:UnregisterEvent("VARIABLES_LOADED");
end);
