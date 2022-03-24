

 
local message = "EMPTY LUA GAME\n\n\nThis is an empty game template.\n\n\nVisit 'www.pixelvision8.com' to learn more about creating games from scratch."



local px1 = 67
local py1 = 69
local sprite1 = 2

local px2 = 74
local py2 = 69
local sprite2 = 3

local px3 = 67
local py3 = 76
local sprite3 = 18

local px4 = 74
local py4 = 76
local sprite4 = 19


local dx = 0;
local dy = 0;
local friccao = 0.8
local aceleracao = 0.4




function Init() --igual ao start unity

  BackgroundColor( 5 )-- pega a cor de id 5 na paleta colors.png
  LoadTilemap('tilemap-0')

end


function Update(timeDelta)-- update unity

  control_check()

end


function Draw() -- redesenha


  RedrawDisplay()--apaga a tela e redesenha o tilemap
  
  DrawSprite(sprite1,px1,py1,false,false,DrawMode.Sprite)
  DrawSprite(sprite2,px2,py2,false,false,DrawMode.Sprite)
  DrawSprite(sprite3,px3,py3,false,false,DrawMode.Sprite)
  DrawSprite(sprite4,px4,py4,false,false,DrawMode.Sprite)

end


function control_check()
  dx *=friccao
  dy *=friccao

  if Button(Buttons.Right) then dx += aceleracao end
  if Button(Buttons.Left) then dx -= aceleracao end

  if Button(Buttons.Up) then dy -= aceleracao end
  if Button(Buttons.Down) then dy += aceleracao end

  px1 += dx
  px2 += dx
  px3 += dx
  px4 += dx

  py1 += dy
  py2 += dy
  py3 += dy
  py4 += dy

end

