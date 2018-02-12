local _System = require "System"
local Settings = require "Settings"
local g_types = require "GTypes"
local utils = require "utils"
local Events = require "Events"

function _PhysicsSystem()
    local self = _System()
    local registry = {}
    local lookup = {}
    local dtTotal = 0 
    local numSnakes = 0
    local numWinCollisions = 0
    local collision = function(entity1, entity2)
        -- could refactor this to check every segment for collision
        if entity1.segments ~= nil and entity2.segments ~= nil then
            for i, e1segment in ipairs(entity1.segments) do
                for j, e2segment in ipairs(entity2.segments) do
                    --local e1x1 = e1segment.x
                    --local e1x2 = e1segment.x + entity1.width
                    --local e2x1 = e2segment.x
                    --local e2x2 = e2segment.x + entity2.width
                    --local e1y1 = e1segment.y
                    --local e1y2 = e1segment.y + entity1.height
                    --local e2y1 = e2segment.y
                    --local e2y2 = e2segment.y + entity2.height       

                    local e1x1 = e1segment.x
                    local e1x2 = e1segment.x
                    local e2x1 = e2segment.x
                    local e2x2 = e2segment.x
                    local e1y1 = e1segment.y
                    local e1y2 = e1segment.y
                    local e2y1 = e2segment.y
                    local e2y2 = e2segment.y
 
                    
                    local xCollision1 = e1x1 >= e2x1 and e1x1 <= e2x2
                    local xCollision2 = e1x2 >= e2x1 and e1x2 <= e2x2
                    local yCollision1 = e1y1 >= e2y1 and e1y1 <= e2y2
                    local yCollision2 = e1y2 >= e2y1 and e1y2 <= e2y2
                    
                    --local xCollision1 = e1x1 == e2x1 and e1x1 == e2x2
                    --local xCollision2 = e1x2 == e2x1 and e1x2 == e2x2
                    --local yCollision1 = e1y1 == e2y1 and e1y1 == e2y2
                    --local yCollision2 = e1y2 == e2y1 and e1y2 == e2y2


                    if (xCollision1 or xCollision2) and (yCollision1 or yCollision2) then
                        return true
                    end
                end
            end
            return false
        else
            return false
        end
        
        --return (xCollision1 or xCollision2) and (yCollision1 or yCollision2) 
    end

    function self.register(entity)
        for i, v in ipairs(registry) do
           table.insert(lookup, {v, entity}) 
        end
        table.insert(registry, entity)  

        if entity.types[g_types.SNAKE] then
            numSnakes = numSnakes + 1
        end
    end

    function self.update(dt)

        dtTotal = dtTotal + dt
        
        numWinCollisions = 0 

        if dtTotal >= Settings.timestep then
            dtTotal = 0
            for i, v in ipairs(registry) do
                
                --v.pos.x = v.pos.x + v.heading.x
                --v.pos.y = v.pos.y + v.heading.y  

                v.step()

                if v.segments ~= nil then
                    for j, segment in ipairs(v.segments) do
                        if segment.x < 0 then
                            v.screenWrap("LEFT", segment)
                        elseif Settings.scale(segment.x) >= Settings.windowWidth then
                            v.screenWrap("RIGHT", segment)
                        elseif segment.y < 0 then
                            v.screenWrap("UP", segment)
                        elseif Settings.scale(segment.y) >= Settings.windowHeight then
                            v.screenWrap("DOWN", segment)
                        end
                    end
                else
                    if v.pos.x < 0 then
                        v.screenWrap("LEFT", v.pos)
                    elseif Settings.scale(v.pos.x) >= Settings.windowWidth then
                        v.screenWrap("RIGHT", v.pos)
                    elseif v.pos.y < 0 then
                        v.screenWrap("UP", v.pos)
                    elseif Settings.scale(v.pos.y) >= Settings.windowHeight then
                        v.screenWrap("DOWN", v.pos)
                    end
                end

            end

            local snakeColCount = 0

            for i, v in ipairs(lookup) do
                if collision(v[1], v[2]) and v[1].types[g_types.SNAKE] and v[2].types[g_types.SNAKE] then
                    -- "encircling event
                    if utils.posEqual(v[1].segments[1], v[2].segments[#v[2].segments]) and utils.posEqual(v[2].segments[1], v[1].segments[#v[1].segments]) then
                        snakeColCount = snakeColCount + 1 
                        if snakeColCount == numSnakes then
                            love.events.push(Events.WIN)
                        end
                    end
                end
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


