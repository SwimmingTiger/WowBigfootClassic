--[[
	Brasilian Portuguese Localization
		***
--]]

local CONFIG, Config = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'ptBR')
if not L then return end

-- general
L.GeneralDesc = 'Configuração geral de ADDON'
L.Locked = 'Bloquear posição das janelas'
L.Fading = 'Efeitos de desvanecimento'
L.TipCount = 'Ativar contagem de itens nas dicas'
L.FlashFind = 'Ativar Flash Find'
L.EmptySlots = 'Mostrar fundo em espaços para itens vazios'
L.DisplayBlizzard = 'Mostrar janelas da Blizzard para sacos desligados'

-- frame
L.FrameSettings = 'Preferências de Janela'
L.FrameSettingsDesc = 'Configuração específica para uma janela de ADDON'
L.Frame = 'Janela'
L.Enabled = 'Ativar'
L.CharacterSpecific = 'Preferências Específicas por Personagem'
--L.ExclusiveReagent = 'Separate Reagent Bank'

L.BagToggle = 'Lista de sacos'
L.Money = 'Dinheiro'
L.Broker = 'DataBroker'
--L.Sort = 'Sort Button'
L.Search = 'Botão da pesquisa'
L.Options = 'Botão da configração'

L.Appearance = 'Aparência'
L.Layer = 'Camada'
L.BagBreak = 'Quebras entre os sacos'
L.ReverseBags = 'Inverter os sacos'
L.ReverseSlots = 'Inverter os itens'

L.Color = 'Cor de Fundo'
L.BorderColor = 'Cor do Bordo'

L.Strata = 'Camada'
L.Columns = 'Colunas'
L.Scale = 'Escala'
L.ItemScale = 'Escala os itens'
L.Spacing = 'Espaçamento'
L.Alpha = 'Transparência'

-- auto display
L.DisplaySettings = 'Exibição Automática'
L.DisplaySettingsDesc = 'Pereferências de exibição automática'
L.DisplayInventory = 'Mostrar mochila'
L.CloseInventory = 'Fechar mochila'

L.DisplayBank = 'quando visitar o banco'
L.DisplayAuction = 'quando visitar um leiloeiro'
L.DisplayTrade = 'quando trocar itens'
L.DisplayCraft = 'quando abrir janela de profissão'
L.DisplayMail = 'quando visitar uma caixa de correio'
L.DisplayGuildbank = 'quando visitar banco da guilda'
L.DisplayPlayer = 'quando abrir janela da personagem'
--L.DisplayGems = 'Socketing Items'

L.CloseCombat = 'quando entrar em combate'
L.CloseVehicle = 'quando entrar num veículo'
L.CloseBank = 'quando abandonar o banco'
L.CloseVendor = 'quando abandonar um vendedor'

-- colors
L.ColorSettings = 'Preferências de Cor'
L.ColorSettingsDesc = 'Preferências de cor para os compartimentos para itens'
L.GlowQuality = 'Realçar itens por qualidade' 
L.GlowNew = 'Realçar novos itens' 
L.GlowQuest = 'Realçar itens de missão'
L.GlowUnusable = 'Realçar itens inutilizáveis'
L.GlowSets = 'Realçar itens de conjunto'
L.ColorSlots = 'Colorir os espaços por tipo de saco'

L.NormalColor = 'Espaços normais'
L.LeatherColor = 'Bolsas de couraria'
L.InscribeColor = 'Bolsas de escrivania'
L.HerbColor = 'Bolsas de plantas'
L.EnchantColor = 'Bolsas de encantamento'
L.EngineerColor = 'Mochilas de engenharia'
L.GemColor = 'Bolsas de gemas'
L.MineColor = 'Bolsas de mineração'
L.TackleColor = 'Caixas de pesca'
L.RefrigeColor = 'Bolsas de cozinhar'
--L.ReagentColor = 'Reagent Bank Color'
L.GlowAlpha = 'Quantidade de brilho para realçar'