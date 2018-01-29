local g_types = require "GTypes"

function _Snake(Entity)
    return function(overrides)
        local self = Entity({"Drawable"})

        --add all the component elements to self
        --register with relevant systems
        
        --table.insert(self.types, SNAKE)
        self.types[g_types.SNAKE] = true

        if overrides ~= nil then
            self.override(overrides)
        end

        return self
    end
end

return _Snake

