local _System = require "System"
local g_types = require "GTypes"
local Settings = require "Settings"

--template
local t = {}
t.colors = {
    white = {"255", "255", "255", "255"} 
}
t[g_types.SNAKE] = function(val)
end
--

function _RenderSystem(template)
    local self = _System()
    local registry = {} 

    function self.register(entity)
        table.insert(registry, entity)
    end 
    
    function self.update()
        for i, v in ipairs(registry) do
            v.draw()
            --for k, val in pairs(v.types) do
            --    if template[k] ~= nil then
            --        template[k](v)
            --    end
            --end
            --for k, fn in pairs(template) do
            --    if v.is_a(k) then
            --        fn(v)
            --    end
            --end
        end
    end

    return self
end

return _RenderSystem(t)

