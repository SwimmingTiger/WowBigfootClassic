local L = DBM_GUI_L
local generalWarningPanel = DBM_GUI.Cat_Alerts:CreateNewPanel(L.Tab_GeneralMessages, "option")

local generalCoreArea = generalWarningPanel:CreateArea(L.CoreMessages)
generalCoreArea:CreateCheckButton(L.ShowPizzaMessage, true, nil, "ShowPizzaMessage")
generalCoreArea:CreateCheckButton(L.ShowAllVersions, true, nil, "ShowAllVersions")
generalCoreArea:CreateCheckButton(L.ShowReminders, true, nil, "ShowReminders")

local generalMessagesArea = generalWarningPanel:CreateArea(L.CombatMessages)
generalMessagesArea:CreateCheckButton(L.ShowEngageMessage, true, nil, "ShowEngageMessage")
generalMessagesArea:CreateCheckButton(L.ShowDefeatMessage, true, nil, "ShowDefeatMessage")
generalMessagesArea:CreateCheckButton(L.ShowGuildMessages, true, nil, "ShowGuildMessages")
generalMessagesArea:CreateCheckButton(L.ShowGuildMessagesPlus, true, nil, "ShowGuildMessagesPlus")

local generalExtraAlerts = generalWarningPanel:CreateArea(L.Area_ChatAlerts)
generalExtraAlerts:CreateCheckButton(L.WorldBossAlert, true, nil, "WorldBossAlert")
generalExtraAlerts:CreateCheckButton(L.WorldBuffAlert, true, nil, "WorldBuffAlert")

local generalBugsAlerts = generalWarningPanel:CreateArea(L.Area_BugAlerts)
generalBugsAlerts:CreateCheckButton(L.BadTimerAlert, true, nil, "BadTimerAlert")
generalBugsAlerts:CreateCheckButton(L.BadIDAlert, true, nil, "BadIDAlert")
