local _System = require "System"

function _UserInputSystem()
    local self = _System() 
    local registry = {} 

    function self.register(entity)
       table.insert(registry, entity)
    end

    
    function self.update(key)
        --check for keyboard input and apply it to all registered entities
        if key == 'space' then
            for i, v in ipairs(registry) do
               v.heading = v.rotateHeading(v.heading) 
            end
        end
    end

    return self
end

return _UserInputSystem()
