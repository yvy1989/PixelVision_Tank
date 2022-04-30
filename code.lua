LoadScript("map-generator")
LoadScript("physics")
LoadScript("gameOver")

isGameStarted = false -- verifica se o jogo comecou
winer = nil -- variavel com o nome do ganhador


posFlagPLayer1 = {--posicao da bandeira do player 1
  x=120,
  y=225,
  w = 40,
  h = 10
}

posFlagPLayer2 = {--posicao da bandeira do player 2
  x=120,
  y=20,
  w = 40,
  h = 10
}

player1 = {
  orientation = "up",
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  w = 16,
  h = 16,
  life = 3,
  isFire = false, -- teste
  isDead = false
}
player2 = {
  orientation = "down",
  x = 0,
  y = 0,
  dx = 0,
  dy = 0,
  w = 16,
  h = 16,
  life = 3,
  isFire = false, -- teste
  isDead = false
}

local delay = 1500 -- delay para atirar - firerate do P1
local delay2 = 1500 -- delay para atirar - firerate do P2

function player1_init()
  player1.x = 90
  player1.y = 235
  player1.life = 3
  player1.isDead = false
end

function player2_init()
  player2.x = 90
  player2.y = 10
  player2.life = 3
  player2.isDead = false
end


function Init() --igual ao start unity
  
  BackgroundColor( 0 )-- pega a cor de id 0 na paleta colors.png
  LoadTilemap('tilemap-1') --carrega o tilemap do menu pcp
  PlaySong ( 0, true )
  

end

function startGame()

  LoadTilemap('tilemap-0')

  winer = nil
  player1_init()
  
  player2_init()
  
  player1_bullets = {} -- lista onde vao ficar armazenadas a lista de balas dp player1
  
  player2_bullets = {} -- lista onde vao ficar armazenadas a lista de balas dp player2
  
  -- cham a funcao de aleatorizar os tiles no mapa recebe o ID, a flag de colisao do sprite e qntas vezes vai ser spawnada
  level_generate(64,0,45)---colocar 50 na qtd de spawn

  PauseSong()
  isGameStarted = true
end


function Update(timeDelta)-- update unity

  if isGameStarted then
    if winer==nil then --se o player colidiu com bala
      delay = delay + timeDelta-- incremento do delay com o tempo de jogo para dar o tiro do P1
    
      delay2 = delay2 + timeDelta-- incremento do delay com o tempo de jogo para dar o tiro do P2
    
      upgrade_and_check_bullets(player1_bullets)
    
      upgrade_and_check_bullets(player2_bullets)
    
      control_check()
  
      check_bullet_collision(player1,player2_bullets,"player2")
    
      check_bullet_collision(player2,player1_bullets,"player1")
  
      check_player_status()
  
    else
      --print(winer)
      gameOver()
    end
    
  else
    if Key(Keys.Enter) then
      startGame()
      --PlaySong ( 1, true )
    end
  end

  

end

function check_bullet_collision(player,bullet_list,bullet_owner)
  for i,b in ipairs(bullet_list) do
    
    if basic_physics_box_cast(player, b) then --se o player colidiu com bala
      --print("colidiu")
      player.life -= 1
      PlaySound(1)
      table.remove(bullet_list,i)
    end

    if bullet_owner == "player1"  then
      if basic_physics_box_cast(posFlagPLayer2, b) then --se a bala do player 1 atingir a bandeira do player 2 
        --print("Atingiu a bandeira do player 2")
        winer = bullet_owner
        table.remove(bullet_list,i)
      end
    end

    if bullet_owner == "player2"  then
      if basic_physics_box_cast(posFlagPLayer1, b) then --se a bala do player 2 atingir a bandeira do player 1 
        --print("Atingiu a bandeira do player 1")
        winer = bullet_owner
        table.remove(bullet_list,i)
      end
    end

  end
end


function fire(player)
  if player == "player1" then
    local b1 = {
      x = player1.x,
      y = player1.y,
      w=4,
      h=4,
      orientation = player1.orientation,
      vel = 0.8,
      isCollide = false
    }
  
    table.insert(player1_bullets,b1)
  end
  if player == "player2" then
    local b2 = {
      x = player2.x,
      y = player2.y,
      w=4,
      h=4,
      orientation = player2.orientation,
      vel = 0.8,
      isCollide = false
    }
  
    table.insert(player2_bullets,b2)
  end
end


function upgrade_and_check_bullets(bullets_List)
  for i,b in ipairs(bullets_List) do
    if(b.orientation=="right") then
      b.x+=b.vel
    end
    if(b.orientation=="left") then
      b.x-=b.vel
    end
    if(b.orientation=="up") then
      b.y-=b.vel
    end
    if(b.orientation=="down") then
      b.y+=b.vel
    end 
    
    
    if physics_check_hit_box(b.x,b.y,8,8,b.orientation,0) then
      DrawMetaSprite("shoot_collision",b.x,b.y,false,false,DrawMode.Sprite)
      
      tilePosition_x = math.floor(b.x / 8)
      tilePosition_y = math.floor(b.y / 8)
      if(b.orientation=="right") then
        map_level[tilePosition_x+1][tilePosition_y+1] = create_tile(88, -1)
      end
      if(b.orientation=="left") then
        map_level[tilePosition_x-1][tilePosition_y+1] = create_tile(88, -1)
      end
      if(b.orientation=="up") then
        map_level[tilePosition_x+1][tilePosition_y-1] = create_tile(88, -1)
      end
      if(b.orientation=="down") then
        map_level[tilePosition_x+1][tilePosition_y+1] = create_tile(88, -1)
      end 
      
      
      PlaySound(1)
      table.remove(bullets_List,i) -- remove a bala da lista e do jogo
      
    end
    if physics_check_hit_box(b.x,b.y,8,8,b.orientation,1) then
      PlaySound(1)
      table.remove(bullets_List,i)
    end
  end
end


function Draw() -- redesenha
  
  RedrawDisplay()

  
  if isGameStarted then
    draw_level()
    RedrawDisplay()--apaga a tela e redesenha o tilemap
  
    DrawText("P2 Life = "..player2.life , 15, 15, DrawMode.TilemapCache, "large", 9, -2) --Player2 life

    DrawText("P1 Life = "..player1.life, 15, 239, DrawMode.TilemapCache, "large", 10, -2) --Player1 life


    DrawMetaSprite("tank_" .. player1.orientation,player1.x,player1.y,false,false,DrawMode.Sprite)
    DrawMetaSprite("tank2_" .. player2.orientation,player2.x,player2.y,false,false,DrawMode.Sprite)
    for i,b in ipairs(player1_bullets) do
      DrawMetaSprite("bullet_" .. b.orientation,b.x,b.y,false,false,DrawMode.Sprite)
    end
    for i,b in ipairs(player2_bullets) do
      DrawMetaSprite("bullet_" .. b.orientation,b.x,b.y,false,false,DrawMode.Sprite)
    end
  else
    DrawText("Press ENTER to START  ", 58, 162,  DrawMode.UI, "large", 15, -1)
  end
  ----------------------DEBUG AREA-------------------------------
  ----------SHOW MOUSE POSITION-----------------------------------
  --pos = MousePosition()
  --DrawRect(pos.x, pos.y, 8, 8, 5, DrawMode.Sprite)
  --DrawText("X = " .. pos.x .. ", Y = ".. pos.y, 8, 32, DrawMode.Sprite, "large", 15)
  -----------------------------------------------------------------

  
end

function check_player_status()
  if player1.life<=0 then
    player1.isDead = true
    winer = "player 2"
  end

  if player2.life<=0 then
    player2.isDead = true
    winer = "player 1"
  end
end

function control_check()
  control_player1()
  control_player2()
end


function control_player1()---------------------------------------------------------controle player 1
  if Key(Keys.Space) and delay >= 2000 then -- tiro do player1
    delay = 0;
    PlaySound(2)
    fire("player1")
  end
  if Key(Keys.D) then
    
    player1.orientation = "right"
    if physics_check_hit_box(player1.x,player1.y,player1.w,player1.h,player1.orientation,0) or physics_check_hit_box(player1.x,player1.y,player1.w,player1.h,player1.orientation,1) then
      player1.dx=0
    else
      player1.dx = 1 
    end
  elseif Key(Keys.A) then
    
    player1.orientation = "left"
    if physics_check_hit_box(player1.x,player1.y,player1.w,player1.h,player1.orientation,0) or physics_check_hit_box(player1.x,player1.y,player1.w,player1.h,player1.orientation,1)  then
      player1.dx=0
    else
      player1.dx = -1
    end
  elseif Key(Keys.W) then
    
    player1.orientation = "up"
    if physics_check_hit_box(player1.x,player1.y,player1.w,player1.h,player1.orientation,0) or physics_check_hit_box(player1.x,player1.y,player1.w,player1.h,player1.orientation,1) then
      player1.dy = 0
    else
      player1.dy = -1
    end
  elseif Key(Keys.S) then
    
    player1.orientation = "down"
    if physics_check_hit_box(player1.x,player1.y,player1.w,player1.h,player1.orientation,0) or physics_check_hit_box(player1.x,player1.y,player1.w,player1.h,player1.orientation,1) then
      player1.dy = 0
    else
      player1.dy = 1
    end
  else
    player1.dx = 0
    player1.dy = 0
  end


  if (Key(Keys.D) and Key(Keys.W)) or (Key(Keys.A) and Key(Keys.W)) or (Key(Keys.S) and Key(Keys.A)) or (Key(Keys.S) and Key(Keys.D))    then
    player1.dx = 0
    player1.dy = 0
  end

    
  player1.x += player1.dx
  player1.y += player1.dy
end


function control_player2()---------------------------------------------------------controle player 2
  if Key(Keys.RightShift) and delay2 >= 2000 then -- tiro do player2
    delay2 = 0;
    PlaySound(2)
    fire("player2")
  end
  if Button(Buttons.Right) then
    
    player2.orientation = "right"
    if physics_check_hit_box(player2.x,player2.y,player2.w,player2.h,player2.orientation,0) or physics_check_hit_box(player2.x,player2.y,player2.w,player2.h,player2.orientation,1) then
      player2.dx=0
    else
      player2.dx = 1 
    end
  elseif Button(Buttons.Left) then
    
    player2.orientation = "left"
    if physics_check_hit_box(player2.x,player2.y,player2.w,player2.h,player2.orientation,0) or physics_check_hit_box(player2.x,player2.y,player2.w,player2.h,player2.orientation,1)  then
      player2.dx=0
    else
      player2.dx = -1
    end
  elseif Button(Buttons.Up) then
    
    player2.orientation = "up"
    if physics_check_hit_box(player2.x,player2.y,player2.w,player2.h,player2.orientation,0) or physics_check_hit_box(player2.x,player2.y,player2.w,player2.h,player2.orientation,1) then
      player2.dy = 0
    else
      player2.dy = -1
    end
  elseif Button(Buttons.Down) then
    
    player2.orientation = "down"
    if physics_check_hit_box(player2.x,player2.y,player2.w,player2.h,player2.orientation,0) or physics_check_hit_box(player2.x,player2.y,player2.w,player2.h,player2.orientation,1) then
      player2.dy = 0
    else
      player2.dy = 1
    end
  else
    player2.dx = 0
    player2.dy = 0
  end
  
  if (Button(Buttons.Right) and Button(Buttons.Up)) or (Button(Buttons.Left) and Button(Buttons.Up)) or (Button(Buttons.Down) and Button(Buttons.Left)) or (Button(Buttons.Down) and Button(Buttons.Right))    then
    player2.dx = 0
    player2.dy = 0
  end
  player2.x += player2.dx
  player2.y += player2.dy
end

