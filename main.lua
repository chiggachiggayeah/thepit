
local System = require "AllSystems"
local _Component = require "Component"
local _Entity = require "Entity" 

local Component = _Component(System)
local Entity = _Entity(Component)

local _Snake = require "Snake"
local _Mongoose = require "Mongoose"

local Snake = _Snake(Entity)
local Mongoose = _Mongoose(Entity)

--the types could be encapsulated by a GameSystem, wherein, when entities are registered with it, the type is added if it hadn't already existed
--types

-- SNAKE, MONGOOSE, BUSH = "SNAKE", "MONGOOSE", "BUSH"
-- g_types = {SNAKE, MONGOOSE, BUSH}
--systems

--rendering template

--RenderSystem = _RenderSystem(t)
--PhysicsSystem = _PhysicsSystem()


--entities




--end entities

--components
--adding a component to an entity, should then let the relevant systems know about that component

--systems
--collision system
--what about an ai system?
--physics system? for time steps and updating the world
--render system

--return system instances from various files so that you don't allow making additional systems


function love.load()
    snake = Snake()
    snake2 = Snake({pos = {x = 100, y = 100}})
end

function love.update(dt)
end

function love.draw()
    --love.graphics.print("Hello world!", 400, 300) 
    System.RenderSystem.update()
end


