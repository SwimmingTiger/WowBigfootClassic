
local IsClassic = WOW_PROJECT_ID >= WOW_PROJECT_CLASSIC

function TrinketMenu_Toggle(switch)
	if (switch) then
		TrinketMenuPerOptions.Visible = "ON"
		TrinketMenuOptions.ShowIcon = "ON"
		TrinketMenu.Initialize();

		TrinketMenu_MainFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
		TrinketMenu_MainFrame:RegisterEvent("PLAYER_REGEN_DISABLED");
		TrinketMenu_MainFrame:RegisterEvent("PLAYER_UNGHOST");
		TrinketMenu_MainFrame:RegisterEvent("PLAYER_ALIVE");
		TrinketMenu_MainFrame:RegisterEvent("UNIT_INVENTORY_CHANGED");
		TrinketMenu_MainFrame:RegisterEvent("PLAYER_EQUIPMENT_CHANGED");
		TrinketMenu_MainFrame:RegisterEvent("UPDATE_BINDINGS");
		TrinketMenu_MainFrame:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN");

		if not IsClassic then
			TrinketMenu_MainFrame:RegisterEvent("PET_BATTLE_OPENING_START");
			TrinketMenu_MainFrame:RegisterEvent("PET_BATTLE_CLOSE");
		end

		SlashCmdList["TrinketMenuCOMMAND"] = TrinketMenu.SlashHandler;
		SLASH_TrinketMenuCOMMAND1 = "/trinketmenu";
		SLASH_TrinketMenuCOMMAND2 = "/trinket";

	else
		TrinketMenu_MainFrame:Hide();
		TrinketMenu_IconFrame:Hide();

		TrinketMenu_MainFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
		TrinketMenu_MainFrame:UnregisterEvent("PLAYER_REGEN_DISABLED");
		TrinketMenu_MainFrame:UnregisterEvent("PLAYER_UNGHOST");
		TrinketMenu_MainFrame:UnregisterEvent("PLAYER_ALIVE");
		TrinketMenu_MainFrame:UnregisterEvent("UNIT_INVENTORY_CHANGED");
		TrinketMenu_MainFrame:UnregisterEvent("PLAYER_EQUIPMENT_CHANGED");
		TrinketMenu_MainFrame:UnregisterEvent("UPDATE_BINDINGS");
		TrinketMenu_MainFrame:UnregisterEvent("ACTIONBAR_UPDATE_COOLDOWN");
		TrinketMenu_MainFrame:UnregisterEvent("PET_BATTLE_OPENING_START");
		TrinketMenu_MainFrame:UnregisterEvent("PET_BATTLE_CLOSE");

		SlashCmdList["TrinketMenuCOMMAND"] = nil;
		SLASH_TrinketMenuCOMMAND1 = nil;
		SLASH_TrinketMenuCOMMAND2 = nil;
	end
end