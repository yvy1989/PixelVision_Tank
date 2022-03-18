---@diagnostic disable: undefined-global
    --[[
  Pixel Vision 8 - New Template Script
  Copyright (C) 2017, Pixel Vision 8 (@pixelvision8)
  Created by Jesse Freeman (@jessefreeman)

  This project was designed to display some basic instructions when you create
  a new game.  Simply delete the following code and implement your own Init(),
  Update() and Draw() logic.

  Learn more about making Pixel Vision 8 games at
  https://www.pixelvision8.com/getting-started
]]--

--[[
  This this is an empty game, we will the following text. We combined two sets
  of fonts into the default.font.png. Use uppercase for larger characters and
  lowercase for a smaller one.
]]--
local message = "EMPTY LUA GAME\n\n\nThis is an empty game template.\n\n\nVisit 'www.pixelvision8.com' to learn more about creating games from scratch."

--[[
  The Init() method is part of the game's lifecycle and called a game starts.
  We are going to use this method to configure background color,
  ScreenBufferChip and draw a text box.
]]--
LoadScript("basic_physics")
LoadScript("player")

local entities = {}

function Init()
  BackgroundColor(5)
  LoadTilemap('tilemap-0')
  player.init()
end
--[[
  The Update() method is part of the game's life cycle. The engine calls
  Update() on every frame before the Draw() method. It accepts one argument,
  timeDelta, which is the difference in milliseconds since the last frame.
]]--
function Update(timeDelta)
  player.dy = basic_physics.apply_gravity(player.dy)
  player.dx = basic_physics.apply_friction(player.dx)
  player.control_check()
end

function Draw()
  RedrawDisplay()
  DrawSprite(player.sprite, player.x, player.y, player.flip, false, DrawMode.Sprite)
end

function clamp(min, val, max)
  if val > max then return max end
  if val < min then return min end
  return val
end