local PhysicsSystem = require "PhysicsSystem"
local RenderSystem = require "RenderSystem"
local UserInputSystem = require "UserInputSystem"

local systems = {}

systems["PhysicsSystem"] = PhysicsSystem
systems["RenderSystem"] = RenderSystem
systems["UserInputSystem"] = UserInputSystem

return systems
