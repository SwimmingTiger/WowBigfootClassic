local L = LibStub("AceLocale-3.0"):NewLocale("Spy", "ptBR")
if not L then return end
-- TOC Note: Detecta e alerta você da presença de jogadores inimigos.

-- Configuration
L["Spy"] = "Spy"
L["Version"] = "Versão"
L["Spy Option"] = "Spy"
L["Profiles"] = "Perfis"

-- About
L["About"] = "Info"
L["SpyDescription1"] = [[
Spy é um addon que vai alerta-lo da presença de jogadores inimigos nas proximidades. Estas são algumas das principais características.
]]
L["SpyDescription2"] = [[
|cffffd000Lista de Proximidades|cffffffff
A lista de Proximidades mostra qualquer inimigo detectado nas proximidades. Jogadores são removidos da lista se não forem mais detectados após um certo período de tempo.

|cffffd000Lista da Última Hora|cffffffff
Exibe todos os inimigos detectados em uma hora.

|cffffd000Lista de Ignorados|cffffffff
Jogadores que são adicionados à lista de Ignorados não serão reportados pelo Spy. Você pode adicionar ou remover jogadores dessa lista usando o menu de contexto ou segurando Ctrl enquanto clicando no botão.

|cffffd000Lista Negra|cffffffff
Jogadores que são adicionados à Lista Negra são reportados pelo Spy através de um alarme sonoro.  Você pode adicionar ou remover jogadores dessa lista usando o menu de contexto ou segurando Shift enquanto clica no botão.

O menu de contexto também permite que você justifique as razões que o levou a colocar determinada pessoa na Lista Negra. Se quiser colocar uma motivo especifico que não tenha na lista, em seguida, use "Digite seu próprio motivo..." em Outra lista.

|cffffd000Statistics Window|cffffffff
The Statistics Window contains a list of all enemy encounters which can be sorted by name, level, guild, wins, losses and the last time an enemy was detected. It also provides the ability to search for a specific enemy by name or guild and has filters to show only enemies that are marked as Kill on Sight, with a Win/Loss or entered Reasons. 

|cffffd000Kill On Sight Button|cffffffff
If enabled, this button will be located on the enemy players target frame. Clicking on this button will add/remove the enemy target to/from the Kill On Sight list. Right clicking on the button will allow you to enter Kill on Sight reasons.

|cffffd000Autor: Slipjack|cffffffff
]]

-- General Settings
L["GeneralSettings"] = "Configurações Gerais"
L["GeneralSettingsDescription"] = [[
Opções para quando o Spy está ativado ou desativado.
]]
L["EnableSpy"] = "Ativar Spy"
L["EnableSpyDescription"] = "Ativa ou desativa o Spy."
L["EnabledInBattlegrounds"] = "Ativar Spy em CB"
L["EnabledInBattlegroundsDescription"] = "Ativa ou desativa o Spy em Campos de Batalha."
L["EnabledInArenas"] = "Ativar Spy em Arenas"
L["EnabledInArenasDescription"] = "Ativa ou desativa o Spy em Arenas."
L["EnabledInWintergrasp"] = "Ativar Spy em Zonas de Combate"
L["EnabledInWintergraspDescription"] = "Ativa ou desativa o Spy em locais como Invérnia."
L["DisableWhenPVPUnflagged"] = "Desativar Spy quando JxJ estiver desativado"
L["DisableWhenPVPUnflaggedDescription"] = "Ativa ou desativa o Spy dependendo se o seu status de JxJ estiver ativado ou desativado."
L["DisabledInZones"] = "Desative o Spy enquanto estiver nesses locais"
L["DisabledInZonesDescription"]	= "Selecione locais onde o Spy será desativado"
L["Booty Bay"] = "Angra do Butim"
L["Everlook"] = "Visteterna"						
L["Gadgetzan"] = "Geringontzan"
L["Ratchet"] = "Vila Catraca"
L["The Salty Sailor Tavern"] = "Taberna do Lobo do Mar"
L["Shattrath City"] = "Shattrath"
L["Area 52"] = "Área 52"
L["Dalaran"] = "Dalaran"
L["Dalaran (Northrend)"] = "Dalaran (Nortúndria)"
L["Bogpaddle"] = "Brejo do Goblin"
L["The Vindicaar"] = "A Vindicaar"
L["Krasus' Landing"] = "Plataforma de Krasus"
L["The Violet Gate"] = "Portão Violeta"
L["Magni's Encampment"] = "Acampamento de Magni"
L["Silithus"] = "Silithus"
L["Chamber of Heart"] = "Câmara do Coração"
L["Hall of Ancient Paths"] = "Salão dos Antigos Caminhos"
L["Sanctum of the Sages"] = "Sacrário dos Sábios"

-- Display
L["DisplayOptions"] = "Exibição"
L["DisplayOptionsDescription"] = [[
Opções para a janela Spy e dicas de ferramentas.
]]
L["ShowOnDetection"] = "Mostrar Spy quando um inimigo for detectado"
L["ShowOnDetectionDescription"] = "Marque isso para que o Spy mostre a lista de Proximidades quando um inimigo for detectado."
L["HideSpy"] = "Esconder Spy quando nenhum inimigo for detectado"
L["HideSpyDescription"] = "Marque isso para que o Spy seja escondido quando a lista de Proximidades estiver sendo mostrada e ficar vazia. Spy não será escondido se você limpar a lista manualmente."
L["ShowOnlyPvPFlagged"] = "Mostrar apenas jogadores inimigos sinalizados para JxJ"
L["ShowOnlyPvPFlaggedDescription"] = "Defina isto para mostrar apenas jogadores inimigos marcados para JxJ na lista Proximidades.."
L["ShowKoSButton"] = "Mostrar o botão da lista negra no quadro alvo inimigo"
L["ShowKoSButtonDescription"] = "Defina isso para mostrar o botão da lista negra no quadro alvo do jogador inimigo."
L["Alpha"] = "Transparência"
L["AlphaDescription"] = "Defina a transparência da janela Spy."
L["AlphaBG"] = "Transparência em CB"
L["AlphaBGDescription"] = "Defina a transparência da janela Spy nos Campos de Batalha."
L["LockSpy"] = "Travar a janela do Spy"
L["LockSpyDescription"] = "Trava a janela para que ela não possa ser movida."
L["ClampToScreen"] = "Limitar na Tela"
L["ClampToScreenDescription"] = "Controla quando a janela do Spy pode ser arrastada para fora da tela."
L["InvertSpy"] = "Inverter a janela de Spy"
L["InvertSpyDescription"] = "Inverte a janela de Spy de cabeça para baixo."
L["Reload"] = "Recarregar UI"
L["ReloadDescription"] = "Necessário ao alterar a janela do Spy."
L["ResizeSpy"] = "Redimensionar janela do Spy automaticamente"
L["ResizeSpyDescription"] = "Marque isso para que a janela do Spy seja redimensionada a medida que novos jogadores são adicionados ou removidos."
L["ResizeSpyLimit"] = "Limite de lista"
L["ResizeSpyLimitDescription"] = "Limite o número de jogadores inimigos mostrados na janela do Spy."
L["DisplayTooltipNearSpyWindow"] = "Exibir dica de ferramenta perto da janela do Spy"
L["DisplayTooltipNearSpyWindowDescription"] = "Defina isso para exibir dicas de ferramentas perto da janela do Spy."
L["SelectTooltipAnchor"] = "Ponto de ancoragem da dica de ferramenta"
L["SelectTooltipAnchorDescription"] = "Selecione o ponto de ancoragem para a dica de ferramenta se a opção acima tiver sido marcada."
L["ANCHOR_CURSOR"] = "Cursor"
L["ANCHOR_TOP"] = "Acima"
L["ANCHOR_BOTTOM"] = "Debaixo"
L["ANCHOR_LEFT"] = "Esquerda"			
L["ANCHOR_RIGHT"] = "Direita"
L["TooltipDisplayWinLoss"] = "Mostar estastica de Vitória/Derrota nas dicas"
L["TooltipDisplayWinLossDescription"] = "Marque isso para que seja mostrado na dicas do jogador, as estasticas de Vitória/Derrota daquele um jogador."
L["TooltipDisplayKOSReason"] = "Mostrar motivos da Lista Negra nas dicas"
L["TooltipDisplayKOSReasonDescription"] = "Marque isso para que seja mostrado na dicas do jogador os motivos da Lista Negra daquele jogador."
L["TooltipDisplayLastSeen"] = "Mostrar detalhes da ultima vez visto nas dicas"
L["TooltipDisplayLastSeenDescription"] = "Marque isso para que seja mostrado nas dicas de jogador o ultimo local e hora em que aquele jogador foi visto."
L["DisplayListData"] = "Selecione os dados do inimigo para exibir"
L["Name"] = "Nome"
L["Class"] = "Classe"
L["SelectFont"] = "Selekt e Font"
L["SelectFontDescription"] = "Selecione um tipo de letra para a janela Spy."
L["RowHeight"] = "Selecione a altura da linha"
L["RowHeightDescription"] = "Selecione a altura da linha para a janela Spy."
L["Texture"] = "Textura"
L["TextureDescription"] = "Selecione a textura da janela Spy"

-- Alerts
L["AlertOptions"] = "Alertas"
L["AlertOptionsDescription"] = [[
Opções para alertas, anúncios e avisos quando jogadores inimigos são detectados.
]]
L["SoundChannel"] = "Selecionar canal de som"
L["Master"] = "Geral"
L["SFX"] = "Efeitos sonoros"
L["Music"] = "Musica"
L["Ambience"] = "Ambiência"
L["Announce"] = "Anunciar Para:"
L["None"] = "Ninguem"
L["NoneDescription"] = "Não anunciar quando jogadores inimigos forem detectados."
L["Self"] = "Você"
L["SelfDescription"] = "Anunciar para si mesmo quando jogadores inimigos forem detectados"
L["Party"] = "Grupo"
L["PartyDescription"] = "Anunciar para o grupo quando jogadores inimigos forem detectados."
L["Guild"] = "Guilda"
L["GuildDescription"] = "Anunciar para a guilda quando jogadores inimigos forem detectados."
L["Raid"] = "Raide"
L["RaidDescription"] = "Anunciar para a raide quando jogadores inimigos forem detectados."
L["LocalDefense"] = "Defesa Local"
L["LocalDefenseDescription"] = "Anunciar para a Defesa Local quando jogadores inimigos forem detectados."
L["OnlyAnnounceKoS"] = "Anunciar inimigos da Lista Negra"
L["OnlyAnnounceKoSDescription"] = "Marque isso para anunciar apenas inimigos que estejam na Lista Negra."
L["WarnOnStealth"] = "Alertar ao detectar invisibilidade"
L["WarnOnStealthDescription"] = "Marque isso para alertar com texto e som quando um inimigo ficar invisivel."
L["WarnOnKOS"] = "Alertar ao detectar inimigos da Lista Negra"
L["WarnOnKOSDescription"] = "Marque isso para alertar com texto e som quando um inimigo da Lista Negra for detectado."
L["WarnOnKOSGuild"] = "Alertar ao detectar Guildie de Lista Negra"
L["WarnOnKOSGuildDescription"] = "Marque isso para alertar com texto e som quando for detectado um integrante da guilda de alguem que esteja na Lista Negra."
L["WarnOnRace"] = "Avisar após a detecção raça"
L["WarnOnRaceDescription"] = "Defina esta opção para soar um alerta quando a raça selecionada é detectado."
L["SelectWarnRace"] = "Selecione Raça para a detecção"
L["SelectWarnRaceDescription"] = "Selecione uma raça para alerta de áudio."
L["WarnRaceNote"] = "Nota: Você deve atingir o inimigo, pelo menos uma vez para que sua raça pode ser adicionado ao banco de dados. Na próxima detecção um alerta será emitido. Isso não funciona o mesmo que detectar os inimigos próximos em combate."
L["DisplayWarningsInErrorsFrame"] = "Mostrar alertas no campo de erros"
L["DisplayWarningsInErrorsFrameDescription"] = "Marque isso para usar o campo de erros para mostrar alertas ao invés de usar os popups graficos."
L["DisplayWarnings"] = "Selecione o local da mensagem de avisos"
L["Default"] = "padrão"
L["ErrorFrame"] = "Quadro de erro"
L["Moveable"] = "móvel"
L["EnableSound"] = "Ativar alertas sonoros"
L["EnableSoundDescription"] = "marque isso para ativar alertas sonoros quando um inimigo for detectado. Os sons são diferentes para Lista Negra e inimigos que ficam invisiveis."
L["OnlySoundKoS"] = "Somente alertas sonoros de áudio para a lista Negra"
L["OnlySoundKoSDescription"] = "Defina esta opção para reproduzir apenas alertas de áudio quando forem detectados jogadores inimigos na lista Negra."
L["StopAlertsOnTaxi"] = "Desativar alertas enquanto estiver em uma rota de vôo"
L["StopAlertsOnTaxiDescription"] = "Interrompa todos os novos alertas e avisos enquanto estiver em uma rota de vôo."

-- Nearby List
L["ListOptions"] = "Lista de Proximidades"
L["ListOptionsDescription"] = [[
Você pode configurar como o Spy adiciona e remove inimigos da lista de Proximidades.
]]
L["RemoveUndetected"] = "Remover jogadores não detectados da lista de Proximidades após:"
L["1Min"] = "1 minuto"
L["1MinDescription"] = "Remove jogadores que não forem mais detectados após 1 minuto."
L["2Min"] = "2 minutos"
L["2MinDescription"] = "Remove jogadores que não forem mais detectados após 2 minutos."
L["5Min"] = "5 minutos"
L["5MinDescription"] = "Remove jogadores que não forem mais detectados após 5 minutos."
L["10Min"] = "10 minutos"
L["10MinDescription"] = "Remove jogadores que não forem mais detectados após 10 minutos."
L["15Min"] = "15 minutos"
L["15MinDescription"] = "Remove jogadores que não forem mais detectados após 15 minutos."
L["Never"] = "Nunca Remover"
L["NeverDescription"] = "Nunca remover jogadores inimigos. A lista de Proximidades ainda pode ser limpa manualmente."
L["ShowNearbyList"] = "Trocar para a lista de Proximidades ao detectar jogador inimigo"
L["ShowNearbyListDescription"] = "Marque isso para que ao detectar jogadores inimigos, seja mostrada a lista de Proximidades se já não estiver sendo mostrada."
L["PrioritiseKoS"] = "Piorizar inimigos da Lista Negra na lista de Proximidades"
L["PrioritiseKoSDescription"] = "Marque isso para sempre motrar primeiro inimigos da Lista Negra na lista de Proximidades."

-- Map
L["MapOptions"] = "Mapa"
L["MapOptionsDescription"] = [[
Opções para mapa-múndi e minimapa, incluindo ícones e dicas de ferramentas.
]]
L["MinimapDetection"] = "Ativar detecção de minimapa"
L["MinimapDetectionDescription"] = "Rolar o cursor sobre jogadores inimigos conhecidos detectados no minimapa os adicionará à lista de Proximidades."
L["MinimapNote"] = "          Nota: Funciona apenas para jogadores que podem rastrear humanoides."
L["MinimapDetails"] = "Mostrar detalhes de level/classe nas dicas"
L["MinimapDetailsDescription"] = "Marque isso para atualizar as dicas do mapa para que o level e a classe sejam mostrados juntamente com o nome dos inimigos."
L["DisplayOnMap"] = "Exibir ícones no mapa"
L["DisplayOnMapDescription"] = "Exiba ícones de mapa para a localização de outros usuários do SPY em seu grupo, invasão e guilda quando detectar inimigos."
L["SwitchToZone"] = "Mudar para o mapa actual zona de detecção de inimigo"
L["SwitchToZoneDescription"] = "Mude o mapa para o mapa da zona atual do jogador quando inimigos forem detectados."
L["MapDisplayLimit"] = "Limitar icones mostrados no mapa para:"
L["LimitNone"] = "Todos os lugares"
L["LimitNoneDescription"] = "Mostrar no mapa todos os inimigos detectados independente da sua atual localização."
L["LimitSameZone"] = "Mesma Zona"
L["LimitSameZoneDescription"] = "Mostrar no mapa somente inimigos que estejam na mesma zona que você."
L["LimitSameContinent"] = "Mesmo Continente"
L["LimitSameContinentDescription"] = "Mostrar no mapa somente inimigos que estejam no mesmo continente que você."

-- Data Management
L["DataOptions"] = "Gerenciamento de Dados"
L["DataOptionsDescription"] = [[
Opções sobre como o Spy mantém e reúne dados.
]]
L["PurgeData"] = "Limpar dados de inimigos não detectados após:"
L["OneDay"] = "1 dia"
L["OneDayDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 1 dia."
L["FiveDays"] = "5 dias"
L["FiveDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 5 dias dias."
L["TenDays"] = "10 dias"
L["TenDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 10 dias."
L["ThirtyDays"] = "30 dias"
L["ThirtyDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 30 dias."
L["SixtyDays"] = "60 dias"
L["SixtyDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 60 dias."
L["NinetyDays"] = "90 dias"
L["NinetyDaysDescription"] = "Limpa os dados de inimigos que não foram detectados a mais de 90 dis."
L["PurgeKoS"] = "Purgar jogadores Lista Negra com base no tempo sem ser detectado."
L["PurgeKoSDescription"] = "Defina esta opção para purgar os jogadores da Lista Negra que foram não detectados com base nas configurações de tempo para os jogadores não detectados."
L["PurgeWinLossDate"] = "Eliminar dados win / perda com base no tempo sem ser detectado."
L["PurgeWinLossDateDescription"] = "Defina esta opção para limpar os dados win / perda de seu inimigo encontros com base nas configurações de tempo para os jogadores não detectados."
L["ShareData"] = "Compartilhar dados com outros usuários do Spy"
L["ShareDataDescription"] = "Marque isso para compartilhar os dados dos inimigos encontrados com outros usuários do Spy em seu grupo, raide e guilda."
L["UseData"] = "Usar dados de outros usuários do Spy"
L["UseDataDescription"] = "Marque isso para usar dados coletados por outros usuários do Spy em seu grupo, raide e guilda."
L["ShareKOSBetweenCharacters"] = "Compartilhar Lista Negra entre todos os seus personagens"
L["ShareKOSBetweenCharactersDescription"] = "Marque isso para que a Lista Negra seja compartilhada entre todos os seus personagens do mesmo reino e facção."

-- Commands
L["SlashCommand"] = "Slash Command"
L["SpySlashDescription"] = "Esses botões executam as mesmas funções que aquelas vistas no slash command /spy"
L["Enable"] = "Enable"
L["EnableDescription"] = "Permite que o Spy e mostra a janela principal."
L["Show"] = "Mostrar"
L["ShowDescription"] = "Mostra a janela principal."
L["Hide"] = "Esconder "
L["HideDescription"] = "Oculta a janela principal."
L["Reset"] = "Reset"
L["ResetDescription"] = "Reseta a posição e aparencia da janela principal."
L["ClearSlash"] = "Limpar"
L["ClearSlashDescription"] = "Limpa a lista de inimigos detectados."
L["Config"] = "Config"
L["ConfigDescription"] = "Abre a janela de configuração do Spy."
L["KOS"] = "Lista Negra"
L["KOSDescription"] = "Adicionar/remover jogadores na Lista Negra."
L["InvalidInput"] = "Entrada Inválida"
L["Ignore"] = "Ignore"
L["IgnoreDescription"] = "Adicionar/remover um jogador de/para a lista de ignorados."
L["Test"] = "Test"
L["TestDescription"] = "Exibe um aviso para que você possa reposicioná-lo."

-- Lists
L["Nearby"] = "Proximidades"
L["LastHour"] = "Ultima Hora"
L["Ignore"] = "Ignorados"
L["KillOnSight"] = "Lista Negra"

--Stats
L["Won"] = "Ganhou"
L["Lost"] = "Perdeu"
L["Time"] = "Tempo"	
L["List"] = "Lista"	
L["Filter"] = "Filtro"
L["Show Only"] = "Spenas Mostrar"
L["KOS"] = "Lista Negra"
L["Won/Lost"] = "Ganhou/Perdeu"
L["Reason"] = "Motivo"
L["HonorKills"] = "Honra Mata"
L["PvPDeaths"] = "Mortes JxJ"	

-- Output Messages
L["VersionCheck"] = "|cffc41e3aAtenção! A versão errada do Spy está instalada. Remova esta versão e instale o Spy Classic."
L["SpyEnabled"] = "|cff9933ffSpy addon ativado."
L["SpyDisabled"] = "|cff9933ffSpy addon desativado. Digite |cffffffff/spy show|cff9933ff para ativar."
L["UpgradeAvailable"] = "|cff9933ffA nova versão do Spy está disponivel. Baixe-o em:\n|cffffffffhttps://www.curseforge.com/wow/addons/spy-classic"
L["AlertStealthTitle"] = "Jogador invisivel detectado!"
L["AlertKOSTitle"] = "Jogador na Lista Negra detectado!"
L["AlertKOSGuildTitle"] = "Guildie de Lista Negra detectado!"
L["AlertTitle_kosaway"] = "Jogador na Lista Negra localizado por "
L["AlertTitle_kosguildaway"] = "Guildie de Lista Negra localizado por "
L["StealthWarning"] = "|cff9933ffJogador invisivel detectado: |cffffffff"
L["KOSWarning"] = "|cffff0000Jogador na Lista Negra detectado: |cffffffff"
L["KOSGuildWarning"] = "|cffff0000Guildie de Lista Negra detectado: |cffffffff"
L["SpySignatureColored"] = "|cff9933ff[Spy] "
L["PlayerDetectedColored"] = "Jogador detectado: |cffffffff"
L["PlayersDetectedColored"] = "Jogadores detectados: |cffffffff"
L["KillOnSightDetectedColored"] = "Jogador na Lista Negra detectado: |cffffffff"
L["PlayerAddedToIgnoreColored"] = "Jogador adicionado à lista de Ignorados: |cffffffff"
L["PlayerRemovedFromIgnoreColored"] = "Jogador removido da lista de Ignorados: |cffffffff"
L["PlayerAddedToKOSColored"] = "Jogador adicionado à Lista Negra: |cffffffff"
L["PlayerRemovedFromKOSColored"] = "Jogador removido da Lista Negra: |cffffffff"
L["PlayerDetected"] = "[Spy] Jogador Detectado: "
L["KillOnSightDetected"] = "[Spy] Jogador na Lista Negra detectado: "
L["Level"] = "Level"
L["LastSeen"] = "Visto há"
L["LessThanOneMinuteAgo"] = "menos de um minuto"
L["MinutesAgo"] = "minutos atrás"
L["HoursAgo"] = "hóras atrás"
L["DaysAgo"] = "dias atrás"
L["Close"] = "Fechar"
L["CloseDescription"] = "|cffffffffEsconde a janela do Spy. Por defeito ela irá ser mostrada novamante quando um jogador inimigo for detectado."
L["Left/Right"] = "Direita/Esquerda"
L["Left/RightDescription"] = "|cffffffffNavega entre as listas de Proximidades, Ultima Hora, Ignorados e Lista Negra."
L["Clear"] = "Limpar"
L["ClearDescription"] = "|cffffffffLimpa a lista de inimigos detectados. Ctrl e click Inicia / Para  o Spy. Shift e Click liga / desliga todo o som."
L["SoundEnabled"] = "Alertas de áudio ativados"
L["SoundDisabled"] = "Alertas de áudio desativados"
L["NearbyCount"] = "Contador de Inimigos"
L["NearbyCountDescription"] = "|cffffffffContatdor de inimigos nas proximidades."
L["Statistics"] = "Estatística"
L["StatsDescription"] = "|cffffffffMostra uma lista de jogadores inimigos encontrados, registros de vitória / perda e onde eles foram vistos pela última vez"
L["AddToIgnoreList"] = "Adicionar à lista de Ignorados"
L["AddToKOSList"] = "Adicionar à Lista Negra"
L["RemoveFromIgnoreList"] = "Remover da lista de Ignorados"
L["RemoveFromKOSList"] = "Remover da Lista Negra"
L["RemoveFromStatsList"] = "Remover da Lista de Estatísticas"   --++
L["AnnounceDropDownMenu"] = "Anunciar"
L["KOSReasonDropDownMenu"] = "Determinar motivo de estar na Lista Negra"
L["PartyDropDownMenu"] = "Grupo"
L["RaidDropDownMenu"] = "Raide"
L["GuildDropDownMenu"] = "Guilda"
L["LocalDefenseDropDownMenu"] = "Defesa Local"
L["Player"] = " (Jogador)"
L["KOSReason"] = "Lista Negra"
L["KOSReasonIndent"] = "    "
L["KOSReasonOther"] = "Digite seu próprio motivo..."
L["KOSReasonClear"] = "Limpar motivo"
L["StatsWins"] = "|cff40ff00Vitórias: "
L["StatsSeparator"] = "  "
L["StatsLoses"] = "|cff0070ddDerrotas: "
L["Located"] = "localizado:"
L["Yards"] = "jardas"
L["LocalDefenseChannelName"] = "DefesaLocal"

Spy_KOSReasonListLength = 6
Spy_KOSReasonList = {
	[1] = {
		["title"] = "Iniciou combate";
		["content"] = {
			"Me atacou sem motivos",
			"Me atacou no recrutador", --++
			"Me atacou enquanto eu lutava com NPCs",
			"Me atacou enquanto eu estava perto de uma masmorra",
			"Me atacou quando eu estava LDT",
			"Me atacou enquanto eu estava montado/voando",
			"Me atacou enquanto eu tinha pouca vida/mana",
		};
	},
	[2] = {
		["title"] = "Estilo de Combate";
		["content"] = {
			"Me emboscou",
			"Ataca sempre que me vê",
			"Me matou com um personagem de nível superior", 
			"Me massacrou junto de vários inimigos",
			"Só ataca em bando",
			"Sempre pede ajuda",
			"Usa muito controle de multidão",
		};
	},
	[3] = {
		["title"] = "Campando";
		["content"] = {
			"Me campou",
			"Campou meu alt",
			"Campou low levels",
			"Campou ficando invisivel",
			"Campou membros da guilda",
			"Campou NPCs/Objetivos",
			"Campou Cidade/Local",
		};
	},
	[4] = {
		["title"] = "Quests";
		["content"] = {
			"Me atacou enquanto eu fazia quests",
			"Me atacou depois que eu ajudei ele com uma quest",
			"Interferiu com os objetivos da quest",
			"Iniciou uma quest que eu queria fazer",
			"Matou NPCs da minha facção",
			"Matou um NPC de quest",
		};
	},
	[5] = {
		["title"] = "Ladrão de recursos";
		["content"] = {
			"Colheu erva que eu queria",
			"Minerou minério que eu queria",
			"Pegou recursos que eu queria",
			"Me matou e roubou meu alvo/raro NPC",
			"Esfolou mobs que eu matei",
			"Resgatou os mobs que eu matei",
			"Pescou na minha lagoa",
		};
	},
	[6] = {
		["title"] = "Outros";
		["content"] = {
			"Ta com o JxJ ativado",
			"Me empurrou de um penhasco",
			"Usa truques de egenharia",
			"Sempre consegue escapar",
			"Usa itens e skills pra fugir",
 			"Burla as mecanicas do jogo",
			"Digite seu próprio motivo...",
		};
	},
}

StaticPopupDialogs["Spy_SetKOSReasonOther"] = {
	preferredIndex=STATICPOPUPS_NUMDIALOGS,  -- http://forums.wowace.com/showthread.php?p=320956
	text = "Motivos para colocar %s na Lista Negra:",
	button1 = "Pronto",
	button2 = "Cancelar",
	timeout = 20,
	hasEditBox = 1,
	editBoxWidth = 260,		
	whileDead = 1,
	hideOnEscape = 1,
	OnShow = function(self)
		self.editBox:SetText("");
	end,
    OnAccept = function(self)
		local reason = self.editBox:GetText()
		Spy:SetKOSReason(self.playerName, "Digite seu próprio motivo...", reason)
	end,
};

-- Class descriptions
L["UNKNOWN"] = "Desconhecido"
L["DRUID"] = "Druida"
L["HUNTER"] = "Caçador"
L["MAGE"] = "Mago"
L["PALADIN"] = "Paladino"
L["PRIEST"] = "Sacerdote"
L["ROGUE"] = "Ladino"
L["SHAMAN"] = "Xamã"
L["WARLOCK"] = "Bruxo"
L["WARRIOR"] = "Guerreiro"
L["DEATHKNIGHT"] = "Cavaleiro da Morte"
L["MONK"] = "Monge"
L["DEMONHUNTER"] = "Caçador de Demonios"

--++ Race descriptions
L["Human"] = "Humano"
L["Orc"] = "Orc"
L["Dwarf"] = "Anão"
L["Tauren"] = "Tauren"
L["Troll"] = "Troll"
L["Night Elf"] = "Elfo Noturno"
L["Undead"] = "Morto-vivo"
L["Gnome"] = "Gnomo"
L["Blood Elf"] = "Elfo Sangrento"
L["Draenei"] = "Draenei"
L["Goblin"] = "Goblin"
L["Worgen"] = "Worgen"
L["Pandaren"] = "Pandaren"
L["Highmountain Tauren"] = "Tauren Altamontês"
L["Lightforged Draenei"] = "Draenei Forjado a Luz"
L["Nightborne"] = "Filho da Noite"
L["Void Elf"] = "Void Elf"	
L["Dark Iron Dwarf"] = "Anão Ferro Negro"
L["Mag'har Orc"] = "Orc Mag'har"
L["Kul Tiran"] = "Kultireno"
L["Zandalari Troll"] = "Troll Zandalari"
L["Mechagnome"] = "Gnomecânico"
L["Vulpera"] = "Vulpera"

-- Stealth abilities
L["Stealth"] = "Furtividade"
L["Prowl"] = "Espreitar"

-- Minimap color codes
L["MinimapGuildText"] = "|cffffffff"
L["MinimapClassTextUNKNOWN"] = "|cff191919"
L["MinimapClassTextDRUID"] = "|cffff7c0a"
L["MinimapClassTextHUNTER"] = "|cffaad372"
L["MinimapClassTextMAGE"] = "|cff68ccef"
L["MinimapClassTextPALADIN"] = "|cfff48cba"
L["MinimapClassTextPRIEST"] = "|cffffffff"
L["MinimapClassTextROGUE"] = "|cfffff468"
L["MinimapClassTextSHAMAN"] = "|cff2359ff"
L["MinimapClassTextWARLOCK"] = "|cff9382c9"
L["MinimapClassTextWARRIOR"] = "|cffc69b6d"
L["MinimapClassTextDEATHKNIGHT"] = "|cffc41e3a"
L["MinimapClassTextMONK"] = "|cff00ff96"
L["MinimapClassTextDEMONHUNTER"] = "|cffa330c9"

Spy_AbilityList = {
-----------------------------------------------------------
-- Allows an estimation of the race, class and level of a
-- player based on the abilities observed in the combat log.
-----------------------------------------------------------

--++ Racial Traits ++	
	["Fusão Sombria"]={ race = "Night Elf", level = 1, },
	["Fúria Sangrenta"]={ race = "Orc", level = 1, },
	["Determinação dos Renegados"]={ race = "Undead", level = 1, },
	["Forma de Pedra"]={ race = "Dwarf", level = 1, },
	["Berserk"]={ race = "Troll", level = 1, },
	["Robustez"]={ race = "Orc", level = 1, },
	["Especialização em Espada"]={ race = "Human", level = 1, },
	["Artista da Fuga"]={ race = "Gnome", level = 1, },
	["O Espírito Humano"]={ race = "Human", level = 1, },
	["Regeneração"]={ race = "Troll", level = 1, },
	["Percepção"]={ race = "Human", level = 1, },
	["Resistência"]={ race = "Tauren", level = 1, },
	["Especialização em Arco"]={ race = "Troll", level = 1, },
	["Cultivo"]={ race = "Tauren", level = 1, },
	["Especialização em Engenharia"]={ race = "Gnome", level = 1, },
	["Pisada de Guerra"]={ race = "Tauren", level = 1, },
	["Matança de Feras"]={ race = "Troll", level = 1, },
	["Localizar Tesouros"]={ race = "Dwarf", level = 1, },
	["Especialização em Machado"]={ race = "Orc", level = 1, },
	["Canibalizar"]={ race = "Undead", level = 1, },
	["Diplomacia"]={ race = "Human", level = 1, },
	["Rapidez"]={ race = "Night Elf", level = 1, },
	["Especialização em Arremessar"]={ race = "Troll", level = 1, },
	["Especialização em Maça"]={ race = "Human", level = 1, },
	["Especialização em Arma de Fogo"]={ race = "Dwarf", level = 1, },
	["Respiração Subaquática"]={ race = "Undead", level = 1, },
	["Comando"]={ race = "Orc", level = 1, },
	["Resistência à Natureza"]={ race = "Night Elf", level = 1, },
	["Resistência ao Gelo"]={ race = "Dwarf", level = 1, },
	["Resistência à Sombra"]={ race = "Undead", level = 1, },
	["Resistência ao Arcano"]={ race = "Gnome", level = 1, },
	["Espírito de Fogo-fátuo"]={ race = "Night Elf", level = 1, },

--++ Druid Abilities ++	
	["Toque de Cura"]={ class = "DRUID", level = 1, },
	["Ira"]={ class = "DRUID", level = 1, },
	["Fogo Lunar"]={ class = "DRUID", level = 4, },
	["Raízes Enredantes"]={ class = "DRUID", level = 8, },
	["Forma de Urso"]={ class = "DRUID", level = 10, },
	["Rugido Desmoralizante"]={ class = "DRUID", level = 10, },
	["Rosnar"]={ class = "DRUID", level = 10, },
	["Malho"]={ class = "DRUID", level = 10, },
	["Teleporte: Clareira da Lua"]={ class = "DRUID", level = 10, },
	["Enfurecer"]={ class = "DRUID", level = 12, },
	["Recrescimento"]={ class = "DRUID", level = 12, },
	["Trombar"]={ class = "DRUID", level = 14, },
	["Forma Aquática"]={ class = "DRUID", level = 16, },
	["Patada"]={ class = "DRUID", level = 16, },
	["Fogo Feérico"]={ class = "DRUID", level = 18, },
	["Hibernar"]={ class = "DRUID", level = 18, },
	["Forma de Felino"]={ class = "DRUID", level = 20, },
	["Garra"]={ class = "DRUID", level = 20, },
	["Espreitar"]={ class = "DRUID", level = 20, },
	["Renascimento"]={ class = "DRUID", level = 20, },
	["Rasgar"]={ class = "DRUID", level = 20, },
	["Fogo Estelar"]={ class = "DRUID", level = 20, },
	["Despedaçar"]={ class = "DRUID", level = 22, },
	["Acalmar Animal"]={ class = "DRUID", level = 22, },
	["Estraçalhar"]={ class = "DRUID", level = 24, },
	["Remover Maldição"]={ class = "DRUID", level = 24, },
	["Fúria do Tigre"]={ class = "DRUID", level = 24, },
	["Abolir Veneno"]={ class = "DRUID", level = 26, },
	["Arremetida"]={ class = "DRUID", level = 26, },
	["Rugido Desafiador"]={ class = "DRUID", level = 28, },
	["Acovardar"]={ class = "DRUID", level = 28, },
	["Forma de Viagem"]={ class = "DRUID", level = 30, },
	["Mordida Feroz"]={ class = "DRUID", level = 32, },
	["Assolar"]={ class = "DRUID", level = 32, },
	["Regeneração Frenética"]={ class = "DRUID", level = 36, },
	["Pulo do Gato"]={ class = "DRUID", level = 36, },
	["Forma de Urso Hediondo"]={ class = "DRUID", level = 40, },
--++ Druid Talents ++	
	["Enredamento"]={ class = "DRUID", level = 10, },
	["Investida Feral"]={ class = "DRUID", level = 20, },
	["Nuvem de Insetos"]={ class = "DRUID", level = 20, },
	["Presságio de Clareza"]={ class = "DRUID", level = 20, },
	["Fogo Feérico (Feral)"]={ class = "DRUID", level = 30, },
--++ Hunter Abilities ++	
	["Prontidão"]={ class = "HUNTER", level = 1, },
	["Tiro Automático"]={ class = "HUNTER", level = 1, },
	["Golpe do Raptor"]={ class = "HUNTER", level = 1, },
	["Rastrear Feras"]={ class = "HUNTER", level = 1, },
	["Aspecto do Macaco"]={ class = "HUNTER", level = 4, },
	["Picada de Serpente"]={ class = "HUNTER", level = 4, },
	["Tiro Arcano"]={ class = "HUNTER", level = 6, },
	["Marca do Caçador"]={ class = "HUNTER", level = 6, },
	["Tiro de Concussão"]={ class = "HUNTER", level = 8, },
	["Aspecto do Falcão"]={ class = "HUNTER", level = 10, },
	["Chamar Ajudante"]={ class = "HUNTER", level = 10, },
	["Dispensar Ajudante"]={ class = "HUNTER", level = 10, },
	["Alimentar Ajudante"]={ class = "HUNTER", level = 10, },
	["Reviver Ajudante"]={ class = "HUNTER", level = 10, },
	["Domar Fera"]={ class = "HUNTER", level = 10, },
	["Tiro Distrativo"]={ class = "HUNTER", level = 12, },
	["Curar Ajudante"]={ class = "HUNTER", level = 12, },
	["Cortar Asas"]={ class = "HUNTER", level = 12, },
	["Olho de Águia"]={ class = "HUNTER", level = 14, },
	["Olhos da Fera"]={ class = "HUNTER", level = 14, },
	["Assustar Fera"]={ class = "HUNTER", level = 14, },
	["Armadilha Imolante"]={ class = "HUNTER", level = 16, },
	["Mordida de Mangusto"]={ class = "HUNTER", level = 16, },
	["Tiro Múltiplo"]={ class = "HUNTER", level = 18, },
	["Rastrear Mortos-vivos"]={ class = "HUNTER", level = 18, },
	["Aspecto do Guepardo"]={ class = "HUNTER", level = 20, },
	["Desvencilhar"]={ class = "HUNTER", level = 20, },
	["Armadilha Congelante"]={ class = "HUNTER", level = 20, },
	["Picada de Escorpídeo"]={ class = "HUNTER", level = 22, },
	["Tradição das Feras"]={ class = "HUNTER", level = 24, },
	["Rastrear Furtivos"]={ class = "HUNTER", level = 24, },
	["Tiro Rápido"]={ class = "HUNTER", level = 26, },
	["Rastrear Elementais"]={ class = "HUNTER", level = 26, },
	["Armadilha Gélida"]={ class = "HUNTER", level = 28, },
	["Aspecto da Fera"]={ class = "HUNTER", level = 30, },
	["Fingir de Morto"]={ class = "HUNTER", level = 30, },
	["Sinalizador"]={ class = "HUNTER", level = 32, },
	["Rastrear Demônios"]={ class = "HUNTER", level = 32, },
	["Armadilha Explosiva"]={ class = "HUNTER", level = 34, },
	["Picada de Víbora"]={ class = "HUNTER", level = 36, },
	["Aspecto da Matilha"]={ class = "HUNTER", level = 40, },
	["Rastrear Gigantes"]={ class = "HUNTER", level = 40, },
	["Salva"]={ class = "HUNTER", level = 40, },
	["Aspecto do Indomado"]={ class = "HUNTER", level = 46, },
	["Rastrear Draconianos"]={ class = "HUNTER", level = 50, },
	["Tiro Tranquilizante"]={ class = "HUNTER", level = 60, },
--++ Hunter Talents ++	
	["Tiro Certo"]={ class = "HUNTER", level = 20, },
	["Coibição"]={ class = "HUNTER", level = 20, },
	["Contra-ataque"]={ class = "HUNTER", level = 30, },
	["Intimidação"]={ class = "HUNTER", level = 30, },
	["Tiro de Dispersão"]={ class = "HUNTER", level = 30, },
	["Ira Bestial"]={ class = "HUNTER", level = 40, },
	["Picada de Mantícora"]={ class = "HUNTER", level = 40, },
--++ Mage Abilities ++	
	["Bola de Fogo"]={ class = "MAGE", level = 1, },
	["Armadura Gélida"]={ class = "MAGE", level = 1, },
	["Seta de Gelo"]={ class = "MAGE", level = 4, },
	["Conjurar Água"]={ class = "MAGE", level = 4, },
	["Impacto de Fogo"]={ class = "MAGE", level = 6, },
	["Conjurar Comida"]={ class = "MAGE", level = 6, },
	["Mísseis Arcanos"]={ class = "MAGE", level = 8, },
	["Polimorfia"]={ class = "MAGE", level = 8, },
	["Nova Congelante"]={ class = "MAGE", level = 10, },
	["Explosão Arcana"]={ class = "MAGE", level = 14, },
	["Detectar Magia"]={ class = "MAGE", level = 16, },
	["Golpe Flamejante"]={ class = "MAGE", level = 16, },
	["Remover Maldição Inferior"]={ class = "MAGE", level = 18, },
	["Lampejo"]={ class = "MAGE", level = 20, },
	["Nevasca"]={ class = "MAGE", level = 20, },
	["Evocação"]={ class = "MAGE", level = 20, },
	["Proteção contra Fogo"]={ class = "MAGE", level = 20, },
	["Escudo de Mana"]={ class = "MAGE", level = 20, },
	["Teleporte: Altaforja"]={ class = "MAGE", level = 20, },
	["Teleporte: Orgrimmar"]={ class = "MAGE", level = 20, },
	["Teleporte: Ventobravo"]={ class = "MAGE", level = 20, },
	["Teleporte: Cidade Baixa"]={ class = "MAGE", level = 20, },
	["Proteção contra Gelo"]={ class = "MAGE", level = 22, },
	["Calcinar"]={ class = "MAGE", level = 22, },
	["Contrafeitiço"]={ class = "MAGE", level = 24, },
	["Cone de Frio"]={ class = "MAGE", level = 26, },
	["Conjurar Ágata de Mana"]={ class = "MAGE", level = 28, },
	["Armadura de Gelo"]={ class = "MAGE", level = 30, },
	["Teleporte: Darnassus"]={ class = "MAGE", level = 30, },
	["Teleporte: Penhasco do Trovão"]={ class = "MAGE", level = 30, },
	["Armadura de Mago"]={ class = "MAGE", level = 34, },
	["Conjurar Jade de Mana"]={ class = "MAGE", level = 38, },
	["Portal: Altaforja"]={ class = "MAGE", level = 40, },
	["Portal: Orgrimmar"]={ class = "MAGE", level = 40, },
	["Portal: Ventobravo"]={ class = "MAGE", level = 40, },
	["Portal: Cidade Baixa"]={ class = "MAGE", level = 40, },
	["Conjurar Citrino de Mana"]={ class = "MAGE", level = 48, },
	["Portal: Darnassus"]={ class = "MAGE", level = 50, },
	["Portal: Penhasco do Trovão"]={ class = "MAGE", level = 50, },
	["Inteligência Arcana"]={ class = "MAGE", level = 56, },
	["Conjurar Rubi de Mana"]={ class = "MAGE", level = 58, },
	["Polimorfia: Vaca"]={ class = "MAGE", level = 60, },
	["Polimorfia"]={ class = "MAGE", level = 60, },
	["Polimorfia"]={ class = "MAGE", level = 60, },
--++ Mage Talents ++	
	["Ruptura do Gelo"]={ class = "MAGE", level = 20, },
	["Ignimpacto"]={ class = "MAGE", level = 20, },
	["Onda de Impacto"]={ class = "MAGE", level = 30, },
	["Bloco de Gelo"]={ class = "MAGE", level = 30, },
	["Presença de Espírito"]={ class = "MAGE", level = 30, },
	["Poder Arcano"]={ class = "MAGE", level = 40, },
	["Combustão"]={ class = "MAGE", level = 40, },
	["Barreira de Gelo"]={ class = "MAGE", level = 40, },
--++ Paladin Abilities ++	
	["Luz Sagrada"]={ class = "PALADIN", level = 1, },
	["Selo da Retidão"]={ class = "PALADIN", level = 1, },
	["Julgamento"]={ class = "PALADIN", level = 4, },
	["Proteção Divina"]={ class = "PALADIN", level = 6, },
	["Selo do Cruzado"]={ class = "PALADIN", level = 6, },
	["Martelo da Justiça"]={ class = "PALADIN", level = 8, },
	["Purificar"]={ class = "PALADIN", level = 8, },
	["Impor as Mãos"]={ class = "PALADIN", level = 10, },
	["Redenção"]={ class = "PALADIN", level = 12, },
	["Fúria Íntegra"]={ class = "PALADIN", level = 16, },
	["Exorcismo"]={ class = "PALADIN", level = 20, },
	["Clarão de Luz"]={ class = "PALADIN", level = 20, },
	["Detectar Morto-vivo"]={ class = "PALADIN", level = 20, },
	["Selo da Justiça"]={ class = "PALADIN", level = 22, },
	["Esconjurar Morto-vivo"]={ class = "PALADIN", level = 24, },
	["Bênção da Salvação"]={ class = "PALADIN", level = 26, },
	["Intervenção Divina"]={ class = "PALADIN", level = 30, },
	["Selo da Luz"]={ class = "PALADIN", level = 30, },
	["Escudo Divino"]={ class = "PALADIN", level = 34, },
	["Selo da Sabedoria"]={ class = "PALADIN", level = 38, },
	["Bênção de Luz"]={ class = "PALADIN", level = 40, },
	["Evocar Cavalo de Guerra"]={ class = "PALADIN", level = 40, },
	["Purificação"]={ class = "PALADIN", level = 42, },
	["Martelo da Ira"]={ class = "PALADIN", level = 44, },
	["Ira Sagrada"]={ class = "PALADIN", level = 50, },
	["Evocar Corcel"]={ class = "PALADIN", level = 60, },
--++ Paladin Talents ++	
	["Consagração"]={ class = "PALADIN", level = 20, },
	["Selo de Comando"]={ class = "PALADIN", level = 20, },
	["Favorecimento Divino"]={ class = "PALADIN", level = 30, },
	["Escudo Sagrado"]={ class = "PALADIN", level = 40, },
	["Choque Sagrado"]={ class = "PALADIN", level = 40, },
	["Contrição"]={ class = "PALADIN", level = 40, },
--++ Priest Abilities ++	
	["Cura Inferior"]={ class = "PRIEST", level = 1, },
	["Punição"]={ class = "PRIEST", level = 1, },
	["Palavra Sombria: Dor"]={ class = "PRIEST", level = 4, },
	["Desvanecer"]={ class = "PRIEST", level = 8, },
	["Prece Desesperada"]={ class = "PRIEST", level = 10, },
	["Bagata da Fraqueza"]={ class = "PRIEST", level = 10, },
	["Impacto Mental"]={ class = "PRIEST", level = 10, },
	["Ressurreição"]={ class = "PRIEST", level = 10, },
	["Fragmentos Estelares"]={ class = "PRIEST", level = 10, },
	["Toque de Fraqueza"]={ class = "PRIEST", level = 10, },
	["Fogo Interior"]={ class = "PRIEST", level = 12, },
	["Grito Psíquico"]={ class = "PRIEST", level = 14, },
	["Cura"]={ class = "PRIEST", level = 16, },
	["Dissipar Magia"]={ class = "PRIEST", level = 18, },
	["Peste Devoradora"]={ class = "PRIEST", level = 20, },
	["A graça de Eluna"]={ class = "PRIEST", level = 20, },
	["Ciclo Elétrico"]={ class = "PRIEST", level = 20, },
	["Cura Célere"]={ class = "PRIEST", level = 20, },
	["Fogo Sagrado"]={ class = "PRIEST", level = 20, },
	["Reconforto Mental"]={ class = "PRIEST", level = 20, },
	["Agrilhoar Morto-vivo"]={ class = "PRIEST", level = 20, },
	["Guarda Sombrio"]={ class = "PRIEST", level = 20, },
	["Visão da Mente"]={ class = "PRIEST", level = 22, },
	["Exaurir Mana"]={ class = "PRIEST", level = 24, },
	["Controle Mental"]={ class = "PRIEST", level = 30, },
	["Prece de Cura"]={ class = "PRIEST", level = 30, },
	["Abolir Doença"]={ class = "PRIEST", level = 32, },
	["Levitar"]={ class = "PRIEST", level = 34, },
	["Cura Maior"]={ class = "PRIEST", level = 40, },
--++ Priest Talents ++	
	["Nova Sagrada"]={ class = "PRIEST", level = 20, },
	["Concentração Interior"]={ class = "PRIEST", level = 20, },
	["Açoite Mental"]={ class = "PRIEST", level = 20, },
	["Silêncio"]={ class = "PRIEST", level = 30, },
	["Fonte de Luz"]={ class = "PRIEST", level = 40, },
	["Forma de Sombra"]={ class = "PRIEST", level = 40, },
--++ Rogue Abilities ++	
	["Eviscerar"]={ class = "ROGUE", level = 1, },
	["Abrir Fechadura"]={ class = "ROGUE", level = 1, },
	["Golpe Sinistro"]={ class = "ROGUE", level = 1, },
	["Furtividade"]={ class = "ROGUE", level = 1, },
	["Punhalada pelas Costas"]={ class = "ROGUE", level = 4, },
	["Bater Carteira"]={ class = "ROGUE", level = 4, },
	["Esfaquear"]={ class = "ROGUE", level = 6, },
	["Evasão"]={ class = "ROGUE", level = 8, },
	["Aturdir"]={ class = "ROGUE", level = 10, },
	["Retalhar"]={ class = "ROGUE", level = 10, },
	["Disparada"]={ class = "ROGUE", level = 10, },
	["Chute"]={ class = "ROGUE", level = 12, },
	["Expor Armadura"]={ class = "ROGUE", level = 14, },
	["Garrote"]={ class = "ROGUE", level = 14, },
	["Finta"]={ class = "ROGUE", level = 16, },
	["Emboscar"]={ class = "ROGUE", level = 18, },
	["Venenos"]={ class = "ROGUE", level = 20, },
	["Ruptura"]={ class = "ROGUE", level = 20, },
	["Veneno Debilitante"]={ class = "ROGUE", level = 20, },
	["Veneno Instantâneo"]={ class = "ROGUE", level = 20, },
	["Distração"]={ class = "ROGUE", level = 22, },
	["Sumir"]={ class = "ROGUE", level = 22, },
	["Detectar Armadilhas"]={ class = "ROGUE", level = 24, },
	["Veneno Entorpecente"]={ class = "ROGUE", level = 24, },
	["Golpe Baixo"]={ class = "ROGUE", level = 26, },
	["Desarmar Armadilha"]={ class = "ROGUE", level = 30, },
	["Golpe no Rim"]={ class = "ROGUE", level = 30, },
	["Veneno Mortal"]={ class = "ROGUE", level = 30, },
	["Veneno Ferino"]={ class = "ROGUE", level = 32, },
	["Cegar"]={ class = "ROGUE", level = 34, },
	["Pó Cegante"]={ class = "ROGUE", level = 34, },
	["Queda Segura"]={ class = "ROGUE", level = 40, },
--++ Rogue Talents ++	
	["Golpe Fantasmagórico"]={ class = "ROGUE", level = 20, },
	["Ripostar"]={ class = "ROGUE", level = 20, },
	["Rajada de Lâminas"]={ class = "ROGUE", level = 30, },
	["Sangue Frio"]={ class = "ROGUE", level = 30, },
	["Hemorragia"]={ class = "ROGUE", level = 30, },
	["Preparação"]={ class = "ROGUE", level = 30, },
	["Adrenalina"]={ class = "ROGUE", level = 40, },
	["Premeditação"]={ class = "ROGUE", level = 40, },
--++ Shaman Abilities ++	
	["Onda Curativa"]={ class = "SHAMAN", level = 1, },
	["Raio"]={ class = "SHAMAN", level = 1, },
	["Arma Trinca-pedra"]={ class = "SHAMAN", level = 1, },
	["Choque Terreno"]={ class = "SHAMAN", level = 4, },
	["Totem Litopele"]={ class = "SHAMAN", level = 4, },
	["Totem de Prisão Terrena"]={ class = "SHAMAN", level = 6, },
	["Escudo de Raios"]={ class = "SHAMAN", level = 8, },
	["Totem da Garra de Pedra"]={ class = "SHAMAN", level = 8, },
	["Choque Flamejante"]={ class = "SHAMAN", level = 10, },
	["Arma de Labaredas"]={ class = "SHAMAN", level = 10, },
	["Totem Calcinante"]={ class = "SHAMAN", level = 10, },
	["Totem da Força da Terra"]={ class = "SHAMAN", level = 10, },
	["Espírito Ancestral"]={ class = "SHAMAN", level = 12, },
	["Totem de Nova de Fogo"]={ class = "SHAMAN", level = 12, },
	["Expurgar"]={ class = "SHAMAN", level = 12, },
	["Totem Sísmico"]={ class = "SHAMAN", level = 18, },
	["Choque Gélido"]={ class = "SHAMAN", level = 20, },
	["Arma da Marca Gélida"]={ class = "SHAMAN", level = 20, },
	["Lobo Fantasma"]={ class = "SHAMAN", level = 20, },
	["Totem de Torrente Curativa"]={ class = "SHAMAN", level = 20, },
	["Onda Curativa Menor"]={ class = "SHAMAN", level = 20, },
	["Totem Antiveneno"]={ class = "SHAMAN", level = 22, },
	["Totem de Resistência ao Gelo"]={ class = "SHAMAN", level = 24, },
	["Visão Distante"]={ class = "SHAMAN", level = 26, },
	["Totem de Magma"]={ class = "SHAMAN", level = 26, },
	["Totem de Fonte de Mana"]={ class = "SHAMAN", level = 26, },
	["Totem de Resistência ao Fogo"]={ class = "SHAMAN", level = 28, },
	["Totem de Labaredas"]={ class = "SHAMAN", level = 28, },
	["Revocação Astral"]={ class = "SHAMAN", level = 30, },
	["Totem de Aterramento"]={ class = "SHAMAN", level = 30, },
	["Totem de Resistência à Natureza"]={ class = "SHAMAN", level = 30, },
	["Reencarnação"]={ class = "SHAMAN", level = 30, },
	["Arma de Fúria dos Ventos"]={ class = "SHAMAN", level = 30, },
	["Cadeia de Raios"]={ class = "SHAMAN", level = 32, },
	["Totem de Fúria dos Ventos"]={ class = "SHAMAN", level = 32, },
	["Totem-sentinela"]={ class = "SHAMAN", level = 34, },
	["Totem da Barreira de Vento"]={ class = "SHAMAN", level = 36, },
	["Totem de Purificação de Doença"]={ class = "SHAMAN", level = 38, },
	["Cura Encadeada"]={ class = "SHAMAN", level = 40, },
	["Totem da Graça do Ar"]={ class = "SHAMAN", level = 42, },
	["Totem do Ar Sereno"]={ class = "SHAMAN", level = 50, },
--++ Shaman Talents ++	
	["Aparar"]={ class = "SHAMAN", level = 30, },
	["Mestre dos Elementos"]={ class = "SHAMAN", level = 40, },
	["Totem de Vagalhão de Mana"]={ class = "SHAMAN", level = 40, },
	["Ataque da Tempestade"]={ class = "SHAMAN", level = 40, },
--++ Warlock Abilities ++	
	["Pele de Demônio"]={ class = "WARLOCK", level = 1, },
	["Imolação"]={ class = "WARLOCK", level = 1, },
	["Seta Sombria"]={ class = "WARLOCK", level = 1, },
	["Evocar Diabrete"]={ class = "WARLOCK", level = 1, },
	["Corrupção"]={ class = "WARLOCK", level = 4, },
	["Maldição da Fraqueza"]={ class = "WARLOCK", level = 4, },
	["Conversão de Vida"]={ class = "WARLOCK", level = 6, },
	["Maldição da Agonia"]={ class = "WARLOCK", level = 8, },
	["Medo"]={ class = "WARLOCK", level = 8, },
	["Criar Pedra de Vida (Menor)"]={ class = "WARLOCK", level = 10, },
	["Drenar Alma"]={ class = "WARLOCK", level = 10, },
	["Evocar Emissário do Caos"]={ class = "WARLOCK", level = 10, },
	["Funil de Vida"]={ class = "WARLOCK", level = 12, },
	["Maldição da Temeridade"]={ class = "WARLOCK", level = 14, },
	["Drenar Vida"]={ class = "WARLOCK", level = 14, },
	["Fôlego Interminável"]={ class = "WARLOCK", level = 16, },
	["Dor Lancinante"]={ class = "WARLOCK", level = 18, },
	["Criar Pedra da Alma (Menor)"]={ class = "WARLOCK", level = 18, },
	["Armadura Demoníaca"]={ class = "WARLOCK", level = 20, },
	["Chuva de Fogo"]={ class = "WARLOCK", level = 20, },
	["Ritual de Evocação"]={ class = "WARLOCK", level = 20, },
	["Evocar Súcubo"]={ class = "WARLOCK", level = 20, },
	["Criar Pedra de Vida (Inferior)"]={ class = "WARLOCK", level = 22, },
	["Olho de Kilrogg"]={ class = "WARLOCK", level = 22, },
	["Drenar Mana"]={ class = "WARLOCK", level = 24, },
	["Detectar Demônios"]={ class = "WARLOCK", level = 24, },
	["Maldição de Línguas"]={ class = "WARLOCK", level = 26, },
	["Detectar Invisibilidade Inferior"]={ class = "WARLOCK", level = 26, },
	["Banir"]={ class = "WARLOCK", level = 28, },
	["Criar Pedra de Fogo (Inferior)"]={ class = "WARLOCK", level = 28, },
	["Escravizar Demônio"]={ class = "WARLOCK", level = 30, },
	["Fogo do Inferno"]={ class = "WARLOCK", level = 30, },
	["Evocar Caçador Vil"]={ class = "WARLOCK", level = 30, },
	["Criar Pedra da Alma (Inferior)"]={ class = "WARLOCK", level = 30, },
	["Maldição dos Elementos"]={ class = "WARLOCK", level = 32, },
	["Proteção contra Sombra"]={ class = "WARLOCK", level = 32, },
	["Criar Pedra de Vida"]={ class = "WARLOCK", level = 34, },
	["Criar Pedra de Fogo"]={ class = "WARLOCK", level = 36, },
	["Criar Pedra Mágica"]={ class = "WARLOCK", level = 36, },
	["Detectar Invisibilidade"]={ class = "WARLOCK", level = 38, },
	["Uivo do Terror"]={ class = "WARLOCK", level = 40, },
	["Evocar Corcel Vil"]={ class = "WARLOCK", level = 40, },
	["Criar Pedra da Alma"]={ class = "WARLOCK", level = 40, },
	["Espiral da Morte"]={ class = "WARLOCK", level = 42, },
	["Maldição da Sombra"]={ class = "WARLOCK", level = 44, },
	["Criar Pedra de Vida (Maior)"]={ class = "WARLOCK", level = 46, },
	["Criar Pedra de Fogo (Maior)"]={ class = "WARLOCK", level = 46, },
	["Fogo d'Alma"]={ class = "WARLOCK", level = 48, },
	["Criar Pedra Mágica (Maior)"]={ class = "WARLOCK", level = 48, },
	["Detectar Invisibilidade Maior"]={ class = "WARLOCK", level = 50, },
	["Inferno"]={ class = "WARLOCK", level = 50, },
	["Criar Pedra da Alma (Maior)"]={ class = "WARLOCK", level = 50, },
	["Criar Pedra de Fogo (Elevada)"]={ class = "WARLOCK", level = 56, },
	["Criar Pedra de Vida (Elevada)"]={ class = "WARLOCK", level = 58, },
	["Maldição da Ruína"]={ class = "WARLOCK", level = 60, },
	["Ritual de Fatalidade"]={ class = "WARLOCK", level = 60, },
	["Evocar Corcel Medonho"]={ class = "WARLOCK", level = 60, },
	["Criar Pedra da Alma (Elevada)"]={ class = "WARLOCK", level = 60, },
	["Criar Pedra Mágica (Elevada)"]={ class = "WARLOCK", level = 60, },
--++ Warlock Talents ++	
	["Amplificar Maldição"]={ class = "WARLOCK", level = 20, },
	["Dominância Vil"]={ class = "WARLOCK", level = 20, },
	["Sombra Ardente"]={ class = "WARLOCK", level = 20, },
	["Maldição da Exaustão"]={ class = "WARLOCK", level = 30, },
	["Sacrifício Demoníaco"]={ class = "WARLOCK", level = 30, },
	["Sifão de Vida"]={ class = "WARLOCK", level = 30, },
	["Conflagrar"]={ class = "WARLOCK", level = 40, },
	["Pacto Sombrio"]={ class = "WARLOCK", level = 40, },
	["Vínculo Anímico"]={ class = "WARLOCK", level = 40, },
--++ Warrior Abilities ++	
	["Postura de Batalha"]={ class = "WARRIOR", level = 1, },
	["Golpe Heroico"]={ class = "WARRIOR", level = 1, },
	["Murro Aprimorado"]={ class = "WARRIOR", level = 1, },
	["Investida"]={ class = "WARRIOR", level = 4, },
	["Dilacerar"]={ class = "WARRIOR", level = 4, },
	["Trovoada"]={ class = "WARRIOR", level = 6, },
	["Cortar Tendão"]={ class = "WARRIOR", level = 8, },
	["Fúria Sanguinária"]={ class = "WARRIOR", level = 10, },
	["Postura de Defesa"]={ class = "WARRIOR", level = 10, },
	["Fender Armadura"]={ class = "WARRIOR", level = 10, },
	["Provocar"]={ class = "WARRIOR", level = 10, },
	["Subjugar"]={ class = "WARRIOR", level = 12, },
	["Trombada com Escudo"]={ class = "WARRIOR", level = 12, },
	["Brado Desmoralizador"]={ class = "WARRIOR", level = 14, },
	["Revanche"]={ class = "WARRIOR", level = 14, },
	["Golpe Zombeteiro"]={ class = "WARRIOR", level = 16, },
	["Levantar Escudo"]={ class = "WARRIOR", level = 16, },
	["Desarmar"]={ class = "WARRIOR", level = 18, },
	["Cutilada"]={ class = "WARRIOR", level = 20, },
	["Retaliação"]={ class = "WARRIOR", level = 20, },
	["Brado Intimidador"]={ class = "WARRIOR", level = 22, },
	["Executar"]={ class = "WARRIOR", level = 24, },
	["Brado Desafiador"]={ class = "WARRIOR", level = 26, },
	["Muralha de Escudos"]={ class = "WARRIOR", level = 28, },
	["Postura de Berserker"]={ class = "WARRIOR", level = 30, },
	["Interceptar"]={ class = "WARRIOR", level = 30, },
	["Batida"]={ class = "WARRIOR", level = 30, },
	["Raiva Incontrolada"]={ class = "WARRIOR", level = 32, },
	["Redemoinho"]={ class = "WARRIOR", level = 36, },
	["Murro"]={ class = "WARRIOR", level = 38, },
	["Temeridade"]={ class = "WARRIOR", level = 50, },
--++ Warrior Talents ++	
	["Último Recurso"]={ class = "WARRIOR", level = 20, },
	["Uivo Perfurante"]={ class = "WARRIOR", level = 20, },
	["Pancada de Concussão"]={ class = "WARRIOR", level = 30, },
	["Desejo de Matar"]={ class = "WARRIOR", level = 30, },
	["Golpes a Esmo"]={ class = "WARRIOR", level = 30, },
	["Sede de Sangue"]={ class = "WARRIOR", level = 40, },
	["Golpe Mortal"]={ class = "WARRIOR", level = 40, },
	["Escudada"]={ class = "WARRIOR", level = 40, },
};

Spy_IgnoreList = {
	["Caixa de Correio"]=true, 
	["Baú do Tesouro"]=true,
	["Baú do Tesouro Pequeno"]=true,
};