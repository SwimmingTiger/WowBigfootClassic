local AddonName, SAO = ...

-- Load database and use default values if needed
function SAO.LoadDB(self)
    local currentversion = 070;
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

    if not db.classes then
        -- The first time, deep copy classes from defaults
        db.classes = CopyTable(SAO.defaults.classes);
    else
        -- Subsequent initializations will deep-merge from defaults
        for classFile, classData in pairs(SAO.defaults.classes) do
            if (not db.classes[classFile]) then
                db.classes[classFile] = CopyTable(classData);
            else
                for optionType, optionData in pairs(classData) do
                    if (not db.classes[classFile][optionType]) then
                        db.classes[classFile][optionType] = CopyTable(optionData);
                    else
                        for auraID, auraData in pairs(optionData) do
                            if (not db.classes[classFile][optionType][auraID]) then
                                db.classes[classFile][optionType][auraID] = CopyTable(auraData);
                            else
                                for id, value in pairs(auraData) do
                                    if (type(db.classes[classFile][optionType][auraID][id]) == "nil") then
                                        db.classes[classFile][optionType][auraID][id] = value;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    db.version = currentversion;
    SpellActivationOverlayDB = db;

    -- At the very end, register the class
    -- This must be done after db init because registering may need options from db
    if (self.CurrentClass) then
        self.CurrentClass.Register(SAO);
    end
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
