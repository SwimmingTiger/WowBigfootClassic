-- Backdrop.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 10/16/2020, 10:43:49 PM
local MAJOR, MINOR = 'Backdrop', 2
local GUI = LibStub('tdGUI-1.0')
local View, oldminor = GUI:NewEmbed(MAJOR, MINOR)
if not View then
    return
end

local LibClass = LibStub('LibClass-2.0')

if BackdropTemplateMixin then
    local function InitWidget(obj)
        obj:OnBackdropLoaded()
        obj:HookScript('OnSizeChanged', BackdropTemplateMixin.OnBackdropSizeChanged)
    end

    function View:Embed(target)
        if LibClass:IsClass(target) and LibClass:IsUIClass(target) then
            Mixin(target, BackdropTemplateMixin)

            local ctor = target.Constructor
            target.Constructor = function(obj, ...)
                ctor(obj, ...)
                InitWidget(obj)
            end

        elseif LibClass:IsWidget(target) then
            Mixin(target, BackdropTemplateMixin)
            InitWidget(target)
        else
            error('error target')
        end
    end
else
    function View:Embed(target)
        if LibClass:IsWidget(target) then
            if target.backdropInfo then
                target:SetBackdrop(target.backdropInfo)
            end
            if target.backdropColor then
                target:SetBackdropColor(target.backdropColor:GetRGB())
            end
            if target.backdropBorderColor then
                target:SetBackdropBorderColor(target.backdropBorderColor:GetRGB())
            end
        end
    end
end
