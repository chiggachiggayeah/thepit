
--types
SNAKE, MONGOOSE = "SNAKE", "MONGOOSE"

--entities
function _Entity()
    local self = {}
    self.is_a = {"Entity"}

    return self
end

function Snake(...)
    local self = _Entity()

    --add all the component elements to self
    --register with relevant systems
    for i, c in ipairs(arg) do
        c.register(self)
        for k, v in pairs(c()) do
            self[k] = v
        end
    end

    table.insert(self.is_a, SNAKE)

    return self
end
--end entities

--components
--adding a component to an entity, should then let the relevant systems know about that component
function _Component()
    local self = {}
    
    function self.new()
        local o = {}
    end
end

Movable = setmetatable({}, {
    __call = function()
        return {
            pos = {
                x = 0,
                y = 0,
            },

            move = function()
            end,

            register = function()
            end
        }
    end
})

Collidable = setmetatable({}, {
    __call = function()
        return {
            pos = {
                x = 0,
                y = 0,
            },
            register = function()
            end

        }
    end
})

Controllable = setmetatable({},{
    __call = function()
        return {
            pos = {
                x = 0,
                y = 0,
            },
            register = function()
            end

        }
    end
})

Drawable = setmetatable({}, {
    __call = function()
        return {
            pos = {
                x = 0,
                y = 0,
            },
            register = function()
            end

        }
    end
})

Perishable = setmetatable({}, {
    __call = function()
        return {
            register = function()
            end
        }
    end
})
--end components

--systems
--collision system
--what about an ai system?
--physics system? for time steps and updating the world
--render system

--return system instances from various files so that you don't allow making additional systems
function _System()
    local self = {}

    
    return self
end
function _Physics()
    local self = _System()
    local registry = {}

    function self.register(entity)
        table.insert(registry, entity)  
    end

    function self.update()
        for i, v in registry do
        end
    end
end

function _RenderSystem()
    local self = _System()
    local registry = {}
    
    function self.register(entity)
        table.insert(registry, entity)
    end function self.update()
        for i, v in registry do
            if v.is_a == SNAKE then
                love.graphics.setColor(255, 255, 255, 255)
                love.graphics.rect(v.pos.x, v.pos.y, v.width, v.height)
            elseif v.is_a == MONGOOSE then
            end
        end
    end
end
--end systems

 


function love.load()

end

function love.update(dt)
end

function love.draw()
    --love.graphics.print("Hello world!", 400, 300)

end


