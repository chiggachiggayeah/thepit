local Settings = require "Settings"
local Events = require "Events"

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
    local scaledHeight = (Settings.windowHeight / Settings.unit)
    local scaledWidth = (Settings.windowWidth / Settings.unit)
    snake = Snake({pos = {x = scaledWidth / 2, y = scaledHeight - Settings.unit}})
    snake2 = Snake({pos = {x =  scaledWidth / 2, y = Settings.unit}, heading = {x = -1, y = 0}})
    love.handlers['killit'] = function()
        print("Oh so you hit the k key, huh?")
    end

    Events.load()
end

function love.update(dt)
    System.PhysicsSystem.update(dt)
end

function love.keypressed(key)
    System.UserInputSystem.update(key)
    if key == 'k' then
        --love.event.push('killit')
    end
end

function love.draw()
    -- could loop through and call every system's update method
    System.RenderSystem.update()
end


