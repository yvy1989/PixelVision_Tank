LoadScript("map-generator")




player1 = {
  orientation = "up",
  px = 0,
  py = 0,
  dx = 0,
  dy = 0,
  w = 16,
  h = 16,
  isFire = false, -- teste
  isDead = false
}


player2 = {
  orientation = "down",
  px = 0,
  py = 0,
  dx = 0,
  dy = 0,
  w = 16,
  h = 16,
  isFire = false, -- teste
  isDead = false
}

function player1_init()
  player1.px = 90
  player1.py = 235
end

function player2_init()
  player2.px = 90
  player2.py = 10
end


local delay = 1500 -- delay para atirar - firerate do P1
local delay2 = 1500 -- delay para atirar - firerate do P2


function Init() --igual ao start unity

  BackgroundColor( 0 )-- pega a cor de id 0 na paleta colors.png
  LoadTilemap('tilemap-0')

  player1_init()
  
  player2_init()
  
  player1_bullets = {} -- lista onde vao ficar armazenadas a lista de balas dp player1
  
  player2_bullets = {} -- lista onde vao ficar armazenadas a lista de balas dp player2

  
  -- cham a funcao de aleatorizar os tiles no mapa recebe o ID, a flag de colisao do sprite e qntas vezes vai ser spawnada
  level_generate(64,0,60)
  
end


function Update(timeDelta)-- update unity

  delay = delay + timeDelta-- incremento do delay com o tempo de jogo para dar o tiro do P1
  delay2 = delay2 + timeDelta-- incremento do delay com o tempo de jogo para dar o tiro do P2

  upgrade_and_check_bullets(player1_bullets)
  upgrade_and_check_bullets(player2_bullets)
  

  control_check()



end

function fire(player)

  if player == "player1" then
    local b1 = {
      x = player1.px,
      y = player1.py,
      orientation = player1.orientation,
      vel = 0.5,
      isCollide = false
    }
  
    table.insert(player1_bullets,b1)
  end

  if player == "player2" then
    local b2 = {
      x = player2.px,
      y = player2.py,
      orientation = player2.orientation,
      vel = 0.5,
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

  draw_level()


  RedrawDisplay()--apaga a tela e redesenha o tilemap
  
  DrawMetaSprite("tank_" .. player1.orientation,player1.px,player1.py,false,false,DrawMode.Sprite)

  DrawMetaSprite("tank2_" .. player2.orientation,player2.px,player2.py,false,false,DrawMode.Sprite)

  for i,b in ipairs(player1_bullets) do
    DrawMetaSprite("bullet_" .. b.orientation,b.x,b.y,false,false,DrawMode.Sprite)
  end

  for i,b in ipairs(player2_bullets) do
    DrawMetaSprite("bullet_" .. b.orientation,b.x,b.y,false,false,DrawMode.Sprite)
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
    if physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,0) or physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,1) then
      player1.dx=0
    else
      player1.dx = 1 
    end

  elseif Key(Keys.A) then
    
    player1.orientation = "left"
    if physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,0) or physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,1)  then
      player1.dx=0
    else
      player1.dx = -1
    end

  elseif Key(Keys.W) then
    
    player1.orientation = "up"
    if physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,0) or physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,1) then
      player1.dy = 0
    else
      player1.dy = -1
    end

  elseif Key(Keys.S) then
    
    player1.orientation = "down"
    if physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,0) or physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,1) then
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


  player1.px += player1.dx
  player1.py += player1.dy
end

function control_player2()---------------------------------------------------------controle player 2
  if Key(Keys.RightShift) and delay2 >= 2000 then -- tiro do player2
    delay2 = 0;
    PlaySound(2)
    fire("player2")
  end

  if Button(Buttons.Right) then
    
    player2.orientation = "right"
    if physics_check_hit_box(player2.px,player2.py,player2.w,player2.h,player2.orientation,0) or physics_check_hit_box(player2.px,player2.py,player2.w,player2.h,player2.orientation,1) then
      player2.dx=0
    else
      player2.dx = 1 
    end

  elseif Button(Buttons.Left) then
    
    player2.orientation = "left"
    if physics_check_hit_box(player2.px,player2.py,player2.w,player2.h,player2.orientation,0) or physics_check_hit_box(player2.px,player2.py,player2.w,player2.h,player2.orientation,1)  then
      player2.dx=0
    else
      player2.dx = -1
    end

  elseif Button(Buttons.Up) then
    
    player2.orientation = "up"
    if physics_check_hit_box(player2.px,player2.py,player2.w,player2.h,player2.orientation,0) or physics_check_hit_box(player2.px,player2.py,player2.w,player2.h,player2.orientation,1) then
      player2.dy = 0
    else
      player2.dy = -1
    end

  elseif Button(Buttons.Down) then
    
    player2.orientation = "down"
    if physics_check_hit_box(player2.px,player2.py,player2.w,player2.h,player2.orientation,0) or physics_check_hit_box(player2.px,player2.py,player2.w,player2.h,player2.orientation,1) then
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


  player2.px += player2.dx
  player2.py += player2.dy
end




function physics_check_hit_box(p_x,p_y,w,h, aim, flag)
  local x = p_x
  local y = p_y
  local w = w
  local h = h
  
  local x1 = 0.0
  local x2 = 0.0
  local y1 = 0.0
  local y2 = 0.0
  
  if aim == 'left' then
    x1 = x - 1
    x2 = x
    y1 = y
    y2 = y + h - 1
  end
  
  if aim == 'right' then
    x1 = x + w - 1
    x2 = x + w
    y1 = y
    y2 = y + h - 1
  end
  
  if aim == 'up' then
    x1 = x + 2
    x2 = x + w - 3
    y1 = y - 1
    y2 = y
  end
  
  if aim == 'down' then
    x1 = x + 2
    x2 = x + w - 3
    y1 = y + h
    y2 = y + h
  end

  x1 /= 8
  x2 /= 8
  y1 /= 8
  y2 /= 8

  --print("("..x1 .. " ".. y1..")")
  --print("("..x1 .. " ".. y2..")")
  --print("("..x2 .. " ".. y1..")")
  --print("("..x2 .. " ".. y2..")")
  
  
  if Flag(x1, y1) == flag
  or Flag(x1, y2) == flag
  or Flag(x2, y1) == flag
  or Flag(x2, y2) == flag then
      return true
  end

  return false
end



