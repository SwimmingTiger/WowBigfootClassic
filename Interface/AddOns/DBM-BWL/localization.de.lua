if GetLocale() ~= "deDE" then return end
local L

-----------------
--  Razorgore  --
-----------------
L = DBM:GetModLocalization("Razorgore")

L:SetGeneralLocalization{
	name = "Feuerkralle der Ungezähmte"
}
L:SetTimerLocalization{
	TimerAddsSpawn	= "Adds erscheinen"
}
L:SetOptionLocalization{
	TimerAddsSpawn	= "Zeige Zeit bis die ersten Adds erscheinen"
}
L:SetMiscLocalization{
	Phase2Emote	= "flieht während die kontrollierenden Kräfte der Kugel schwinden.",
	YellPull 	= "Eindringlinge sind in die Brutstätte vorgestoßen! Schlagt Alarm! Beschützt die Eier um jeden Preis!"
}
-------------------
--  Vaelastrasz  --
-------------------
L = DBM:GetModLocalization("Vaelastrasz")

L:SetGeneralLocalization{
	name				= "Vaelastrasz der Verdorbene"
}

L:SetMiscLocalization{
	Event				= "Zu spät, Freunde! Nefarius üble Macht wirkt bereits... Ich habe mich nicht... nicht mehr unter Kontrolle.."
}
-----------------
--  Broodlord  --
-----------------
L = DBM:GetModLocalization("Broodlord")

L:SetGeneralLocalization{
	name	= "Brutwächter Dreschbringer"
}

L:SetMiscLocalization{
	Pull	= "Euresgleichen sollte nicht hier sein! Ich werde Euch vernichten!"
}

---------------
--  Firemaw  --
---------------
L = DBM:GetModLocalization("Firemaw")

L:SetGeneralLocalization{
	name = "Feuerschwinge"
}

---------------
--  Ebonroc  --
---------------
L = DBM:GetModLocalization("Ebonroc")

L:SetGeneralLocalization{
	name = "Schattenschwinge"
}

----------------
--  Flamegor  --
----------------
L = DBM:GetModLocalization("Flamegor")

L:SetGeneralLocalization{
	name = "Flammenmaul"
}

------------------
--  Chromaggus  --
------------------
L = DBM:GetModLocalization("Chromaggus")

L:SetGeneralLocalization{
	name = "Chromaggus"
}
L:SetWarningLocalization{
	WarnBreath		= "%s"
}
L:SetTimerLocalization{
	TimerBreathCD	= "%s CD"
}
L:SetOptionLocalization{
	WarnBreath		= "Zeige Warnung, wenn Chromaggus einen seiner Atem wirkt",
	TimerBreathCD	= "Abklingzeit der Atem anzeigen"
}
L:SetMiscLocalization{
	Breath1	= "Erster Atem",
	Breath2	= "Zweiter Atem"
}

----------------
--  Nefarian  --
----------------
L = DBM:GetModLocalization("Nefarian-Classic")

L:SetGeneralLocalization{
	name = "Nefarian"
}
L:SetWarningLocalization{
	WarnClassCall		= "%s Ruf"
}
L:SetTimerLocalization{
	TimerClassCall		= "%s Ruf endet"
}
L:SetOptionLocalization{
	TimerClassCall		= "Dauer der Klassenrufe anzeigen",
	WarnClassCall		= "Verkünde Klassenrufe"
}
L:SetMiscLocalization{
	YellP2		= "Sehr gut, meine Diener. Der Mut der Sterblichen scheint zu schwinden! Nun lasst uns sehen, wie sie sich gegen den wahren Herrscher des Schwarzfels behaupten werden!",
	YellP3		= "Unmöglich! Erhebt Euch, meine Diener! Kämpft erneut für Euren Meister!",
	YellShaman	= "Schamane, zeigt mir was eure Totems können!",
	YellPaladin	= "Paladine... ich habe gehört, dass Ihr viele Leben habt. Zeigt es mir.",
	YellDruid	= "Druiden und ihre lächerliche Gestaltwandlung. Zeigt mal was Ihr könnt!",
	YellPriest	= "Priester! Wenn Ihr weiterhin so heilt, können wir es auch gerne etwas interessanter gestalten!",
	YellWarrior	= "Krieger, Ich bin mir sicher, dass ihr kräftiger als das zuschlagen könnt!",
	YellRogue	= "Schurken? Kommt aus den Schatten und zeigt Euch!",
	YellWarlock	= "Hexenmeister, Ihr solltet nicht mit Magie spielen, die Ihr nicht versteht. Seht Ihr was ich meine?",--needs to be verified (wowhead-captured translation)
	YellHunter	= "Jäger und ihre lästigen Knallbüchsen!",
	YellMage	= "Auch Magier? Ihr solltet vorsichtiger sein, wenn Ihr mit Magie spielt...",
	YellDK		= "Todesritter... kommt hierher!",
	YellMonk	= "Mönche, macht Euch dieses Herumrollen denn nicht schwindlig?"--needs to be verified (wowhead-captured translation)
}