

 


 
local message = "EMPTY LUA \n\n\nThis is an empty  template.\n\n\nVisit 'www.pixelvision8.com' to learn more about creating games from scratch."

Player1_Positions = {
  player_up = {
    sprite1 = 2,
    sprite2 = 3,
    sprite3 = 18,
    sprite4 = 19
  },
  player_down = {
    sprite1 = 8,
    sprite2 = 9,
    sprite3 = 24,
    sprite4 = 25
  },
  player_left = {
    sprite1 = 4,
    sprite2 = 5,
    sprite3 = 20,
    sprite4 = 21
  },
  player_right = {
    sprite1 = 12,
    sprite2 = 13,
    sprite3 = 28,
    sprite4 = 29
  }
}

player_up = {
  sprite1 = 2,
  sprite2 = 3,
  sprite3 = 18,
  sprite4 = 19
}


Player1_Orientation = "up" -- variavel que guarda a direcao do player1



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
  
  if Player1_Orientation == "down"
  then 
    DrawSprite(Player1_Positions.player_down.sprite1,px1,py1,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_down.sprite2,px2,py2,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_down.sprite3,px3,py3,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_down.sprite4,px4,py4,false,false,DrawMode.Sprite)  
  end

  if Player1_Orientation == "up"
  then 
    DrawSprite(Player1_Positions.player_up.sprite1,px1,py1,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_up.sprite2,px2,py2,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_up.sprite3,px3,py3,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_up.sprite4,px4,py4,false,false,DrawMode.Sprite)  
  end

  if Player1_Orientation == "left"
  then 
    DrawSprite(Player1_Positions.player_left.sprite1,px1,py1,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_left.sprite2,px2,py2,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_left.sprite3,px3,py3,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_left.sprite4,px4,py4,false,false,DrawMode.Sprite)  
  end

  if Player1_Orientation == "right"
  then 
    DrawSprite(Player1_Positions.player_right.sprite1,px1,py1,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_right.sprite2,px2,py2,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_right.sprite3,px3,py3,false,false,DrawMode.Sprite)
    DrawSprite(Player1_Positions.player_right.sprite4,px4,py4,false,false,DrawMode.Sprite)  
  end

  
  

end


function control_check()
  dx *=friccao
  dy *=friccao

  if Button(Buttons.Right) then 
    dx += aceleracao 
    Player1_Orientation = "right"
  end


  if Button(Buttons.Left) then 
    dx -= aceleracao 
    Player1_Orientation = "left"
  end


  if Button(Buttons.Up) then 
    dy -= aceleracao 
    Player1_Orientation = "up"
  end


  if Button(Buttons.Down) 
  then dy += aceleracao 
    Player1_Orientation = "down"
  end

  px1 += dx
  px2 += dx
  px3 += dx
  px4 += dx

  py1 += dy
  py2 += dy
  py3 += dy
  py4 += dy

end



