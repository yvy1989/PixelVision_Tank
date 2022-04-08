

 
LoadScript("basic_physics")

 
local message = "EMPTY LUA \n\n\nThis is an empty  template.\n\n\nVisit 'www.pixelvision8.com' to learn more about creating games from scratch."


Player1_Orientation = "up" -- variavel que guarda a direcao do player1

local px = 67 
local py = 69 

local Player1_dx = 0;
local Player1_dy = 0;
local Player1_friccao = 0.8
local Player1_aceleracao = 0.4




function Init() --igual ao start unity

  BackgroundColor( 5 )-- pega a cor de id 5 na paleta colors.png
  LoadTilemap('tilemap-0')

end


function Update(timeDelta)-- update unity

  control_check()

end


function Draw() -- redesenha

  DrawText("Flag " .. Flag(px/8, py/8), 10, 50, DrawMode.Sprite, "large", 15)

  RedrawDisplay()--apaga a tela e redesenha o tilemap
  
  DrawMetaSprite("tank_" .. Player1_Orientation,px,py,false,false,DrawMode.Sprite)

  

end


function control_check()
  Player1_dx *=Player1_friccao
  Player1_dy *=Player1_friccao

  if Button(Buttons.Right) then 
    Player1_dx += Player1_aceleracao 
    Player1_Orientation = "right"
  end


  if Button(Buttons.Left) then 
    Player1_dx -= Player1_aceleracao 
    Player1_Orientation = "left"
  end


  if Button(Buttons.Up) then 
    Player1_dy -= Player1_aceleracao 
    Player1_Orientation = "up"
  end


  if Button(Buttons.Down) 
  then Player1_dy += Player1_aceleracao 
    Player1_Orientation = "down"
  end

  px += Player1_dx
  py += Player1_dy


end



