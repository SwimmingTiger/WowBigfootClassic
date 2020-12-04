-- Backdrop.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/16/2020, 10:43:49 PM

local MAJOR, MINOR = 'Backdrop', 1
local GUI = LibStub('tdGUI-1.0')
local View, oldminor = GUI:NewEmbed(MAJOR, MINOR)
if not View then return end

if GUI.Retail then
    local function Setup(obj)
        Mixin(obj, BackdropTemplateMixin)
        BackdropTemplateMixin:OnBackdropLoaded(obj)
        obj:HookScript('OnSizeChanged', BackdropTemplateMixin.OnBackdropSizeChanged)
    end

    local mixins = {}

    local function SetupMethod(name)
        View[name] = function(self, ...)
            Setup(self)
            return self[name](self, ...)
        end
        tinsert(mixins, name)
    end

    SetupMethod('SetBackdrop')
    SetupMethod('SetBackdropColor')
    SetupMethod('SetBackdropBorderColor')

    View.Embed = GUI:EmbedFactory(View, mixins)
else
    View.Embed = nop
end
