local TC2, C, L, _ = unpack(select(2, ...))
if TC2.locale ~= "ptBR" and TC2.locale ~= "ptPT" then return end

-----------------------------
--	ptBR and ptPT clients
-----------------------------
L.gui_threat = "Ameaça"
L.gui_config = "Abrir Config"

-- quadro de configuração
L.reset = "Redefinir para os valores padrão"

-- mensagens
L.message_welcome = "Digite /tc2 para opções."
L.message_leader = "Você deve ser o líder do grupo ou ter um assistente para fazer isso."
L.message_outdated = "|cFFFBB709ThreatClassic2:|r Uma nova versão está disponível! Por favor, atualize."
L.message_incompatible = "|cFFFBB709ThreatClassic2|r está desatualizado e incompatível com as versões anteriores. Atualize imediatamente!"

L.general = "Geral"
L.general_welcome = "Mostrar uma mensagem de boas-vindas ao fazer conecte-se."
L.general_rawPercent = "Use a porcentagem de ameaça bruta (agro em 110% corpo a corpo /130% alcance)"
L.general_downscaleThreat = "Escala os valores da ameaça (então 1 dano é igual a 1 ameaça antes dos modificadores)"
L.general_downscaleThreatDesc = "A API da ameaça Blizzard usa 100 ameaças para 1 dano. Esta configuração reduz os números da API de ameaças para o que usávamos antes do patch 1.13.5"
L.general_updateFreq = "Tempo mínimo (em segundos) entre as atualizações."
L.general_updateFreq_desc = "Esta configuração tem como objetivo limitar o consumo de CPU, quando tc2 é atualizado em intervalos (por exemplo, quando no modo targettarget). Em geral, os valores de ameaça não podem ser atualizados mais rápido como a API da Blizzard os fornece. "
L.general_test = "Ativar modo de teste."
L.general_minimap = "Alternar o ícone do minimapa."
L.general_ignorePets = "Ignore a ameaça dos animais de estimação dos jogadores."

L.visibility = "Visibilidade"
L.visibility_hideOOC = "Ocultar quadro quando fora de combate."
L.visibility_hideSolo = "Ocultar quadro quando não estiver no grupo."
L.visibility_hideInPvP = "Ocultar quadro quando em campos de batalha."
L.visibility_hideOpenWorld = "Ocultar moldura quando não estiver em uma sala (também oculta chefes do mundo!)."
L.visibility_hideAlways = "Ocultar quadro sempre. /toggle Tc2"

L.profiles = "Perfis"

L.color = "Cores"

L.appearance = "Aparência"

L.frame = "Quadro"
L.frame_header = "Cabeçalho"
L.frame_bg = "Fundo"
L.frame_test = "Modo de teste"
L.frame_strata = "Strata"
L.frame_scale = "Escala"
L.frame_lock = "Bloquear"
L.frame_headerShow = "Mostrar cabeçalho"
L.frame_headerColor = "Cor do cabeçalho"
L.frame_position = "Posição"
L.frame_width = "Largura"
L.frame_height = "Altura"
L.frame_xOffset = "Compensação X"
L.frame_yOffset = "Compensação Y"

L.bar = "Barras"
L.bar_descend = "Crescimento reverso"
L.bar_height = "Altura"
L.bar_padding = "Preenchimento"
L.bar_texture = "Textura"
L.bar_alpha = "Barra alfa (cores padrão)"
L.bar_showThreatValue = "Mostrar valor da ameaça"
L.bar_showThreatPercentage = "Mostrar porcentagem de ameaça"
L.bar_showIgniteIndicator = "Mostrar indicador de ignição"
L.bar_showIgniteIndicator_desc = "Mostrar um pequeno ícone de incendiar ao lado do nome do jogador, que atualmente possui a incendiar."

L.igniteIndicator = "Indicador de incendiar"
L.igniteIndicator_makeRound = "Faça o ícone circular"
L.igniteIndicator_makeRound_desc = "Requer /recarregar para recriar a textura."
L.igniteIndicator_size = "Tamanho"

L.customBarColors = "Cores de barra personalizadas"
L.customBarColorsPlayer_enabled = "Ativar cor personalizada do player"
L.customBarColorsPlayer_desc = "Esta opção define uma cor fixa para o jogador, independentemente das outras opções de cor."
L.customBarColorsActiveTank_enabled = "Ativar cor personalizada do tanque ativo"
L.customBarColorsOtherUnit_enabled = "Ativar outra cor de unidade personalizada"
L.customBarColorsIgnite_enabled = "Ativar cor de incendiar"
L.customBarColorsIgnite_desc = "Isso mudará a cor da barra se a unidade tiver ignição no alvo. As cores do jogador e do tanque têm precedência."
L.customBarColorsPlayer_color = "Cor do jogador"
L.customBarColorsActiveTank_color = "Cor do tanque ativo"
L.customBarColorsOtherUnit_color = "Cor da outra unidade"
L.customBarColorsIgnite_color = "Cor da unidade de incendiar"

L.font = "Fonte"
L.font_name = "Nome"
L.font_size = "Tamanho"
L.font_style = "Estilo"
L.NONE = "NENHUM"
L.OUTLINE = "CONTORNO"
L.THICKOUTLINE = "CONTORNOGROSSO"
L.font_shadow = "Dropshadow"

L.warnings = "Avisos"
L.warnings_flash = "Ativar tela piscando."
L.warnings_sound = "Ativar sons"
L.warnings_threshold = "Limite de aviso (100% = agro)"
L.warnings_minThreatAmount = "Ameaça mínima para acionar avisos"
L.warnings_minThreatAmount_desc = "O valor depende da configuração 'Geral -> Escala dos valores da ameaça' e corresponde à ameaça exibida. Números maiores podem ser configurados com a caixa de entrada."

L.warnings_soundFile = "Arquivo de som"
L.warnings_soundChannel = "Canal de som"

L.soundChannel_master = "Mestre"
L.soundChannel_sfx = "SFX"
L.soundChannel_ambience = "Ambiente"
L.soundChannel_music = "Música"
