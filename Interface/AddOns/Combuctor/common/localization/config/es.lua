--[[
    Spanish Localization
		Credits/Blame: Phanx
--]]

local CONFIG, Config = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'esES') or LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'esMX')
if not L then return end

-- general
L.GeneralDesc = 'Funciones generales que se puedan activados o desactivados como tu prefieras.'
L.Locked = 'Bloquear posiciones de marcos'
L.Fading = 'Activar efeitos de desaparición'
L.TipCount = 'Mostrar recuento de objetos en tooltips'
L.FlashFind = 'Activar Flash Find'
L.EmptySlots = 'Mostrar un fondo para las ranuras de objetos vacías'
L.DisplayBlizzard = 'Mostrar ventanas de Blizzard para bolsas desactivadas'

-- frame
L.FrameSettings = 'Opciones de ventana'
L.FrameSettingsDesc = 'Opciones específicas para una ventana de ADDON'
L.Frame = 'Ventana'
L.Enabled = 'Activar esta ventana'
L.CharacterSpecific = 'Ajustes del personaje'
L.ExclusiveReagent = 'Banco de componentes independiente'

L.BagToggle = 'Bolsas'
L.Money = 'Dinero'
L.Broker = 'DataBroker'
L.Sort = 'Botón para ordenar'
L.Search = 'Botón para buscar'
L.Options = 'Botón de opciones'

L.Appearance = 'Aparencia'
L.Layer = 'Estrato'
L.BagBreak = 'Descansos entre bolsas'
L.ReverseBags = 'Bolsas al revés'
L.ReverseSlots = 'Ranuras al revés'

L.Color = 'Color del fondo'
L.BorderColor = 'Color del borde'

L.Strata = 'Estrato'
L.Columns = 'Columnas'
L.Scale = 'Escala'
L.ItemScale = 'Escala de objetos'
L.Spacing = 'Espacio'
L.Alpha = 'Opacidad'

-- auto display
L.DisplaySettings = 'Exhibición automática'
L.DisplaySettingsDesc = 'Estas opciones te permite configurar si tu inventario se muestra o se oculta automáticamente en repuesta a ciertos eventos.'
L.DisplayInventory = 'Mostrar inventario'
L.CloseInventory = 'Ocultar inventario'

L.DisplayBank = 'al visitar el banco'
L.DisplayAuction = 'al visitar a la casa de subastas'
L.DisplayTrade = 'cuando el comercio'
L.DisplayCraft = 'al abrir la ventana de profesión'
L.DisplayMail = 'al visitar la buzón'
L.DisplayGuildbank = 'al visitar el banco de hermandad'
L.DisplayPlayer = 'al abrir el panel del personaje'
L.DisplayGems = 'al insertar gemas'

L.CloseCombat = 'al entrar en combate'
L.CloseVehicle = 'al entrar en un vehículo'
L.CloseBank = 'al salir del banco'
L.CloseVendor = 'al salir de un vendedor'

-- colors
L.ColorSettings = 'Opciones de color'
L.ColorSettingsDesc = 'Estas opciones te permite cambiar cómo se coloren las ranuras para facilitar la identificación.'
L.GlowQuality = 'Resalte objetos por calidad'
L.GlowNew = 'Resalte objetos nuevos' 
L.GlowQuest = 'Resalte objetos de misiones'
L.GlowUnusable = 'Resalte objetos inutilizables'
L.GlowSets = 'Resalte objetos en equipamientos'
L.ColorSlots = 'Colorear ranuras vacías por tipo de bolsa'

L.NormalColor = 'Bolsas normales'
L.LeatherColor = 'Bolsas de peletería'
L.InscribeColor = 'Bolsas de inscripción'
L.HerbColor = 'Bolsas de hierbas'
L.EnchantColor = 'Bolsas de encantamiento'
L.EngineerColor = 'Bolsas de ingeniería'
L.GemColor = 'Bolsas de gemas'
L.MineColor = 'Bolsas de minería'
L.TackleColor = 'Caja de aparejos'
L.RefrigeColor = 'Bolsas de cocina'
L.ReagentColor = 'Banco de componentes'
L.GlowAlpha = 'Opacidad del resaltado'