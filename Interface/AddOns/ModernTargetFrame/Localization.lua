--[[	Modern TargetFrame Localization
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

----------------------------------
--[[	Localization Table	]]
----------------------------------
local Localization={
	enUS={--	Native locale by SDPhantom
--		Options Panel
		Options_ByAuthor_Format="by %s";

--		Options Panel (Feature List)
		Options_FeatureName_StatusBarText="Show Health & Mana Text";
		Options_FeatureName_ClassificationTexture="Enable Rare-Elite Texture";
		Options_FeatureName_ThreatIndicatorGlow="Enable Threat Glow";
		Options_FeatureName_ThreatIndicatorNumber="Enable Threat Numeric Display";
	};

	deDE={--	Translated by xFl0w21
--		Options Panel
		Options_ByAuthor_Format="erstellt von %s";

--		Options Panel (Feature List)
		Options_FeatureName_StatusBarText="Zeige Lebens- & Manatext";
		Options_FeatureName_ClassificationTexture="Aktiviere Rare-Elite Zielrahmen";
		Options_FeatureName_ThreatIndicatorGlow="Aktiviere visuelle Warnung für Bedrohung (Threat)";
		Options_FeatureName_ThreatIndicatorNumber="Aktiviere numerische Anzeige für Bedrohung (Threat)";
	};
	frFR={--	Translated by Arektor
--		Options Panel
		Options_ByAuthor_Format="par %s";

--		Options Panel (Feature List)
		Options_FeatureName_StatusBarText="Afficher les points de vie et de mana";
		Options_FeatureName_ClassificationTexture="Activer la bordure des élites rares";
		Options_FeatureName_ThreatIndicatorGlow="Activer l'alerte visuelle d'aggro";
		Options_FeatureName_ThreatIndicatorNumber="Afficher les quantités de menace";
	};
	ruRU={--	Translated by AmetistoFF
--		Options Panel
		Options_ByAuthor_Format="от %s";

--		Options Panel (Feature List)
		Options_FeatureName_StatusBarText="Отображать значение Жизни и Маны";
		Options_FeatureName_ClassificationTexture="Отображать портреты Редких-Элитных мобов";
		Options_FeatureName_ThreatIndicatorGlow="Отображать свечение от угрозы";
		Options_FeatureName_ThreatIndicatorNumber="Отображать показатель угрозы";
	};
	zhCN={--	Translated by Junlin Zhou
--		Options Panel
		Options_ByAuthor_Format="作者 %s";

--		Options Panel (Feature List)
		Options_FeatureName_StatusBarText="显示生命值和法力值";
		Options_FeatureName_ClassificationTexture="显示稀有/精英边框";
		Options_FeatureName_ThreatIndicatorGlow="启用仇恨提示";
		Options_FeatureName_ThreatIndicatorNumber="显示仇恨数值";
	};
}

----------------------------------
--[[	Localization Loader	]]--	Nothing to localize below this line
----------------------------------
local AddOn=select(2,...);
AddOn.Localization=Localization[GetLocale()] or Localization.enUS;
if AddOn.Localization~=Localization.enUS then setmetatable(AddOn.Localization,{__index=Localization.enUS}); end
