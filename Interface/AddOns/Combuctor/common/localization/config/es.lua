--[[
    Spanish Localization
        Credits/Blame: Phanx, Woopy, a14219
--]]

local CONFIG, Config = ...
local L = LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'esES') or LibStub('AceLocale-3.0'):NewLocale(CONFIG, 'esMX')
if not L then return end

-- general
L.GeneralOptionsDesc = 'Funciones generales que puedes aplicar según tus preferencias.'
L.Locked = 'Bloquear posiciones'
L.Fading = 'Efectos de desvanecimiento'
L.TipCount = 'Contador de objetos en tooltips'
L.FlashFind = 'Activar búsqueda rápida'
L.DisplayBlizzard = 'Mostrar ventanas de Blizzard para bolsas desactivadas'
L.DisplayBlizzardTip = 'Si se activa, se mostrará la interfaz por defecto de Blizzard para bolsas ocultas del inventario o del banco.\n\n|cffff1919Requiere reiniciar la interfaz (UI Reload).|r'
L.ConfirmGlobals = '¿Estás seguro de que quieres desactivar la configuración específica para este personaje? Se perderán todos los ajustes guardados.'
L.CharacterSpecific = 'Ajustes del personaje'

-- frame
L.FrameOptions = 'Opciones de ventana'
L.FrameOptionsDesc = 'Estos son ajustes específicos para la ventana %s.'
L.Frame = 'Ventana'
L.Enabled = 'Activar esta ventana'
L.EnabledTip = 'Si se desactiva, se mostrará la ventana por defecto de Blizzard.\n\n|cffff1919Requiere reiniciar la interfaz (UI Reload).|r'
L.ActPanel = 'Actuar como panel estándar'
L.ActPanelTip = [[
Si está activado, este panel se posicionará automáticamente
a sí mismo igual que los paneles estándar, como el |cffffffffLibro de hechizos|r
o el |cffffffffBuscador de mazmorras|r, y no se podrá mover.]]

L.BagToggle = 'Mostrar bolsas'
L.Money = 'Dinero'
L.Broker = 'Panel de información'
L.Sort = 'Botón para ordenar'
L.Search = 'Botón para buscar'
L.Options = 'Botón para opciones'
L.LeftTabs = 'Pestañas a la izquierda'
L.LeftTabsTip = [[
Si está activado, las pestañas laterales
se mostrarán en el lado izquierdo del panel.]]


L.Appearance = 'Apariencia'
L.Layer = 'Capa'
L.BagBreak = 'Espacio entre bolsas'
L.ReverseBags = 'Invertir bolsas'
L.ReverseSlots = 'Invertir ranuras'

L.Color = 'Color de fondo'
L.BorderColor = 'Color de borde'

L.Strata = 'Nivel de superposición'
L.Columns = 'Columnas'
L.Scale = 'Escala'
L.ItemScale = 'Escala de objetos'
L.Spacing = 'Espacio'
L.Alpha = 'Opacidad'

-- auto display
L.DisplayOptions = 'Abrir automáticamente'
L.DisplayOptionsDesc = 'Estos ajustes permiten configurar si tu inventario se muestra o se oculta automáticamente en repuesta a ciertos eventos del juego.'
L.DisplayInventory = 'Mostrar inventario'
L.CloseInventory = 'Cerrar inventario'

L.DisplayBank = 'Al visitar el banco'
L.DisplayGuildbank = 'Al abrir el banco de hermandad'
L.DisplayAuction = 'Al visitar la casa de subastas'
L.DisplayMail = 'Al abrir el buzón'
L.DisplayTrade = 'Al comerciar'
L.DisplayScrapping = 'Al reciclar equipo'
L.DisplayGems = 'Al insertar gemas'
L.DisplayCraft = 'Al abrir una ventana de profesión'
L.DisplayPlayer = 'Al abrir el panel del personaje'

L.CloseCombat = 'Al entrar en combate'
L.CloseVehicle = 'Al entrar en un vehículo'
L.CloseBank = 'Al salir del banco'
L.CloseVendor = 'Al salir de un vendedor'
L.CloseMap = 'Al abrir el mapa del mundo'

-- colors
L.ColorOptions = 'Opciones de color'
L.ColorOptionsDesc = 'Estas opciones te permite cambiar los colores de las ranuras en las ventanas de %s.'
L.GlowQuality = 'Colorear según la calidad'
L.GlowQuest = 'Colorear objetos de misión'
L.GlowUnusable = 'Colorear objetos inutilizables'
L.GlowSets = 'Colorear conjuntos de equipamiento'
L.GlowNew = 'Resaltar objetos nuevos'
L.GlowPoor = 'Resaltar chatarra'
L.GlowAlpha = 'Opacidad del resaltado'

L.EmptySlots = 'Mostrar fondo de ranuras vacías'
L.ColorSlots = 'Colorear ranuras vacías según tipo de bolsa'
L.NormalColor = 'Bolsa normal'
L.KeyColor = 'Bolsa de llaves'
L.QuiverColor = 'Carcaj'
L.SoulColor = 'Bolsa de almas'
L.ReagentColor = 'Banco de componentes'
L.LeatherColor = 'Bolsa de peletería'
L.InscribeColor = 'Bolsa de inscripción'
L.HerbColor = 'Bolsa de hierbas'
L.EnchantColor = 'Bolsa de encantamiento'
L.EngineerColor = 'Bolsa de ingeniería'
L.GemColor = 'Bolsa de gemas'
L.MineColor = 'Bolsa de minería'
L.TackleColor = 'Caja de aparejos'
L.FridgeColor = 'Bolsa de cocina'

-- rulesets
L.RuleSettings = 'Reglas de objetos'
L.RuleSettingsDesc = 'Estos ajustes permiten establecer qué reglas se aplican y en qué orden.'
