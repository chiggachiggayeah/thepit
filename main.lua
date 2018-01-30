local Settings = require "Settings"

local System = require "AllSystems"
local _Component = require "Component"
local _Entity = require "Entity" 

local Component = _Component(System)
local Entity = _Entity(Component)

local _Snake = require "Snake"
local _Mongoose = require "Mongoose"

local Snake = _Snake(Entity)
local Mongoose = _Mongoose(Entity)



function love.load()
    love.window.setMode(Settings.windowWidth, Settings.windowHeight, {})

    snake = Snake()
    snake2 = Snake({pos = {x = 10, y = 10}, heading = {x = -1, y = 0}})
end

function love.update(dt)
    System.PhysicsSystem.update(dt)
end

function love.keypressed(key)
    System.UserInputSystem.update(key)
end

function love.draw()
    -- could loop through and call every system's update method
    System.RenderSystem.update()
end


