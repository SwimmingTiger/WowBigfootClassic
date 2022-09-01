-------------------------
--Import modules.
-------------------------
---@type QuestieOptions
local QuestieOptions = QuestieLoader:ImportModule("QuestieOptions");
---@type QuestieOptionsDefaults
local QuestieOptionsDefaults = QuestieLoader:ImportModule("QuestieOptionsDefaults");
---@type QuestieOptionsUtils
local QuestieOptionsUtils = QuestieLoader:ImportModule("QuestieOptionsUtils");
---@type QuestieNameplate
local QuestieNameplate = QuestieLoader:ImportModule("QuestieNameplate");
---@type l10n
local l10n = QuestieLoader:ImportModule("l10n")

QuestieOptions.tabs.nameplate = {...}
local optionsDefaults = QuestieOptionsDefaults:Load()


function QuestieOptions.tabs.nameplate:Initialize()
    return {
        name = function() return l10n('Nameplates'); end,
        type = "group",
        order = 14,
        args = {
            nameplate_options = {
                type = "header",
                order = 1,
                name = function() return l10n('Nameplate Icon Options'); end,
            },
            nameplateEnabled = {
                type = "toggle",
                order = 1.1,
                name = function() return l10n('Enable Nameplate Quest Objectives'); end,
                desc = function() return l10n('Enable or disable the quest objective icons over creature nameplates.'); end,
                width = "full",
                get = function(info) return QuestieOptions:GetGlobalOptionValue(info); end,
                set = function (info, value)
                    QuestieOptions:SetGlobalOptionValue(info, value)

                    -- on false, hide current nameplates
                    if not value then
                        QuestieNameplate:HideCurrentFrames();
                    end
                end,
            },
            Spacer_A = QuestieOptionsUtils:Spacer(1.2),
            nameplateX = {
                type = "range",
                order = 1.3,
                name = function() return l10n('Icon Position X'); end,
                desc = function() return l10n('Where on the X axis the nameplate icon should be. ( Default: %s )', optionsDefaults.global.nameplateX ); end,
                width = "normal",
                min = -200,
                max = 200,
                step = 1,
                disabled = function() return not Questie.db.global.nameplateEnabled; end,
                get = function(info) return QuestieOptions:GetGlobalOptionValue(info); end,
                set = function (info, value)
                    QuestieNameplate:RedrawIcons()
                    QuestieOptions:SetGlobalOptionValue(info, value)
                end,
            },
            nameplateY = {
                type = "range",
                order = 1.4,
                name = function() return l10n('Icon Position Y'); end,
                desc = function() return l10n('Where on the Y axis the nameplate icon should be. ( Default: %s )', optionsDefaults.global.nameplateY); end,
                width = "normal",
                min = -200,
                max = 200,
                step = 1,
                disabled = function() return not Questie.db.global.nameplateEnabled; end,
                get = function(info) return QuestieOptions:GetGlobalOptionValue(info); end,
                set = function (info, value)
                    QuestieNameplate:RedrawIcons()
                    QuestieOptions:SetGlobalOptionValue(info, value)
                end,
            },
            nameplateScale = {
                type = "range",
                order = 1.5,
                name = function() return l10n('Nameplate Icon Scale'); end,
                desc = function() return l10n('Scale the size of the quest icons on creature nameplates. ( Default: %s )', optionsDefaults.global.nameplateScale); end,
                width = "double",
                min = 0.01,
                max = 4,
                step = 0.01,
                disabled = function() return not Questie.db.global.nameplateEnabled; end,
                get = function(info) return QuestieOptions:GetGlobalOptionValue(info); end,
                set = function (info, value)
                    QuestieOptions:SetGlobalOptionValue(info, value)
                    QuestieNameplate:RedrawIcons()
                end,

            },
            Spacer_B = QuestieOptionsUtils:Spacer(1.6),
            nameplateReset = {
                type = "execute",
                order = 1.7,
                name = function() return l10n('Reset Nameplates'); end,
                desc = function() return l10n('Reset to default nameplate position and scale.'); end,
                disabled = function() return not Questie.db.global.nameplateEnabled; end,
                func = function (info, value)
                    Questie.db.global.nameplateX = optionsDefaults.global.nameplateX;
                    Questie.db.global.nameplateY = optionsDefaults.global.nameplateY;
                    Questie.db.global.nameplateScale = optionsDefaults.global.nameplateScale;
                    QuestieNameplate:RedrawIcons();
                end,
            },
            Spacer_C = QuestieOptionsUtils:Spacer(1.9),
            targetframe_header = {
                type = "header",
                order = 2,
                name = function() return l10n('Target Frame Icon Options'); end,
            },
            nameplateTargetFrameEnabled = {
                type = "toggle",
                order = 2.1,
                name = function() return l10n('Enable Target Frame Quest Objectives'); end,
                desc = function() return l10n('Enable or disable the quest objective icons over creature target frame.'); end,
                width = "full",
                get = function(info) return QuestieOptions:GetGlobalOptionValue(info); end,
                set = function (info, value)
                    QuestieOptions:SetGlobalOptionValue(info, value)

                    -- on false, hide current nameplates
                    if not value then
                        QuestieNameplate:HideCurrentTargetFrame();
                    else
                        QuestieNameplate:DrawTargetFrame();
                    end
                end,
            },
            Spacer_E = QuestieOptionsUtils:Spacer(2.2),
            nameplateTargetFrameX  = {
                type = "range",
                order = 2.3,
                name = function() return l10n('Icon Position X'); end,
                desc = function() return l10n('Where on the X axis the nameplate icon should be. ( Default: %s )', optionsDefaults.global.nameplateTargetFrameX); end,
                width = "normal",
                min = -200,
                max = 200,
                step = 1,
                disabled = function() return not Questie.db.global.nameplateTargetFrameEnabled; end,
                get = function(info) return QuestieOptions:GetGlobalOptionValue(info); end,
                set = function (info, value)
                    QuestieNameplate:RedrawFrameIcon()
                    QuestieOptions:SetGlobalOptionValue(info, value)
                end,
            },
            nameplateTargetFrameY  = {
                type = "range",
                order = 2.4,
                name = function() return l10n('Icon Position Y'); end,
                desc = function() return l10n('Where on the Y axis the nameplate icon should be. ( Default: %s )', optionsDefaults.global.nameplateTargetFrameY); end,
                width = "normal",
                min = -200,
                max = 200,
                step = 1,
                disabled = function() return not Questie.db.global.nameplateTargetFrameEnabled; end,
                get = function(info) return QuestieOptions:GetGlobalOptionValue(info); end,
                set = function (info, value)
                    QuestieNameplate:RedrawFrameIcon()
                    QuestieOptions:SetGlobalOptionValue(info, value)
                end,
            },
            nameplateTargetFrameScale  = {
                type = "range",
                order = 2.5,
                name = function() return l10n('Nameplate Icon Scale'); end,
                desc = function() return l10n('Scale the size of the quest icons on creature nameplates. ( Default: %s )', optionsDefaults.global.nameplateTargetFrameScale); end,
                width = "double",
                min = 0.01,
                max = 4,
                step = 0.01,
                disabled = function() return not Questie.db.global.nameplateTargetFrameEnabled; end,
                get = function(info) return QuestieOptions:GetGlobalOptionValue(info); end,
                set = function (info, value)
                    QuestieOptions:SetGlobalOptionValue(info, value)
                    QuestieNameplate:RedrawFrameIcon()
                end,

            },
            Spacer_F = QuestieOptionsUtils:Spacer(2.6),
            targetFrameReset = {
                type = "execute",
                order = 2.7,
                name = function() return l10n('Reset Target Frame'); end,
                desc = function() return l10n('Reset to default target frame position and scale.'); end,
                disabled = function() return not Questie.db.global.nameplateTargetFrameEnabled; end,
                func = function (info, value)
                    Questie.db.global.nameplateTargetFrameX = optionsDefaults.global.nameplateTargetFrameX;
                    Questie.db.global.nameplateTargetFrameY = optionsDefaults.global.nameplateTargetFrameY;
                    Questie.db.global.nameplateTargetFrameScale = optionsDefaults.global.nameplateTargetFrameScale;
                    QuestieNameplate:RedrawFrameIcon();
                end,
            },
        },
    }
end
