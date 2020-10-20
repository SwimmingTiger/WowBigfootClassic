----------------------------------------------------------------------------------------------------
------------------------------------------AddOn NAMESPACE-------------------------------------------
----------------------------------------------------------------------------------------------------

local FOLDER_NAME, private = ...
local addon = LibStub("AceAddon-3.0"):GetAddon(FOLDER_NAME)
local L = private.locale

----------------------------------------------------------------------------------------------------
-------------------------------------------DEV CONFIG TAB-------------------------------------------
----------------------------------------------------------------------------------------------------

-- activates the devmode ["dev"] = true,

local function devmode()
    private.config.options.args["DEV"] = {
        type = "group",
        name = L["dev_config_tab"],
--      desc = L[""],
        order = 2,
        args = {
                force_nodes = {
                    type = "toggle",
                    name = L["dev_config_force_nodes"],
                    desc = L["dev_config_force_nodes_desc"],
                    order = 0,
                },
                show_prints = {
                    type = "toggle",
                    name = L["dev_config_show_prints"],
                    desc = L["dev_config_show_prints_desc"],
                    order = 1,
                },
        },
    }

    SLASH_TGREFRESH1 = "/tgrefresh"
    SlashCmdList["TGREFRESH"] = function(msg)
        addon:Refresh()
        print("TravelGuide refreshed")
    end

    SLASH_TGWARFRONTS1 = "/tgwarfronts"
    SlashCmdList["TGWARFRONTS"] = function(msg)
        print("~~~~~~~~~~~~~~~~~~~~~~")
        print("TravelGuide: Warfronts")
        print("Arathi: "..C_ContributionCollector.GetState(11)) --Battle for Stromgarde
        print("Darkshore: "..C_ContributionCollector.GetState(118)) --Battle for Darkshore
        print("~~~~~~~~~~~~~~~~~~~~~~")
    end
end

private.devmode = devmode