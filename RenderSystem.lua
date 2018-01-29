local _System = require "System"
local g_types = require "GTypes"

--template
local t = {}
t.colors = {
    white = {"255", "255", "255", "255"} 
}
t[g_types.SNAKE] = function(val)
    love.graphics.setColor(t.colors.white)
    love.graphics.rectangle("fill", val.pos.x, val.pos.y, val.width, val.height)
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
            for k, fn in pairs(template) do
                if v.is_a(k) then
                    fn(v)
                end
            end
        end
    end

    return self
end

return _RenderSystem(t)

