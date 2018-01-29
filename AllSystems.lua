local PhysicsSystem = require "PhysicsSystem"
local RenderSystem = require "RenderSystem"

local systems = {}

systems["PhysicsSystem"] = PhysicsSystem
systems["RenderSystem"] = RenderSystem

return systems
