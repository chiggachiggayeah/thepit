local _System = require "System"
local Settings = require "Settings"

function _PhysicsSystem()
    local self = _System()
    local registry = {}
    local lookup = {}
    local dtTotal = 0 

    local collision = function(entity1, entity2)
        -- could refactor this to check every segment for collision

        local e1x1 = entity1.pos.x
        local e1x2 = entity1.pos.x + entity1.width
        local e2x1 = entity2.pos.x
        local e2x2 = entity2.pos.x + entity2.width
        local e1y1 = entity1.pos.y
        local e1y2 = entity1.pos.y + entity1.height
        local e2y1 = entity2.pos.y
        local e2y2 = entity2.pos.y + entity2.height       

        local xCollision1 = e1x1 >= e2x1 and e1x1 <= e2x2
        local xCollision2 = e1x2 >= e2x1 and e1x2 <= e2x2
        local yCollision1 = e1y1 >= e2y1 and e1y1 <= e2y2
        local yCollision2 = e1y2 >= e2y1 and e1y2 <= e2y2

        return (xCollision1 or xCollision2) and (yCollision1 or yCollision2) 
    end

    function self.register(entity)
        for i, v in ipairs(registry) do
           table.insert(lookup, {v, entity}) 
        end
        table.insert(registry, entity)  
    end

    function self.update(dt)

        dtTotal = dtTotal + dt

        if dtTotal >= Settings.timestep then
            dtTotal = 0
            for i, v in ipairs(registry) do
                
                --v.pos.x = v.pos.x + v.heading.x
                --v.pos.y = v.pos.y + v.heading.y  

                v.step()
            end
            for i, v in ipairs(lookup) do
                while collision(v[1], v[2]) do
                    if v[1].revise ~= nil then v[1].revise() end
                    if v[2].revise ~= nil then v[2].revise() end

                    if v[1].step ~= nil then v[1].step() end
                    if v[2].step ~= nil then v[2].step() end
                end
            end

            --v.pos.x = v.pos.x + v.heading.x
            --v.pos.y = v.pos.y + v.heading.y
        end
    end

    return self
end

return _PhysicsSystem()


