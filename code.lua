

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



function player1.init()
  player1.px = 67
  player1.py = 69
end


local delay = 2000 -- delay para atirar


function Init() --igual ao start unity

  BackgroundColor( 0 )-- pega a cor de id 0 na paleta colors.png
  LoadTilemap('tilemap-0')

  player1.init()
  
  player1_bullets = {} -- lista onde vao ficar armazenadas a lista de balas
  
end


function Update(timeDelta)-- update unity

  delay = delay + timeDelta-- incremento do delay com o tempo de jogo para dar o tiro

  upgrade_and_check_bullets()

  control_check()

end

function fire()
	local b = {
		x = player1.px,
		y = player1.py,
    orientation = player1.orientation,
		vel = 0.5,
    isCollide = false
	}

	table.insert(player1_bullets,b)

end

function upgrade_and_check_bullets()
  for i,b in ipairs(player1_bullets) do
    if(b.orientation=="right") and b.isCollide == false then
      b.x+=b.vel
    end
    if(b.orientation=="left") and b.isCollide == false then
      b.x-=b.vel
    end
    if(b.orientation=="up") and b.isCollide == false then
      b.y-=b.vel
    end
    if(b.orientation=="down") and b.isCollide == false then
      b.y+=b.vel
    end   
    if physics_check_hit_box(b.x,b.y,2,2,b.orientation,0) and b.isCollide == false then
      DrawMetaSprite("shoot_collision",b.x,b.y,false,false,DrawMode.Sprite)
      PlaySound(1)
      b.isCollide = true
    end
  end
end

function Draw() -- redesenha

  --DrawText("Flag " .. Flag(player1.px/8, player1.py/8), 10, 50, DrawMode.Sprite, "large", 15)
  --DrawText(tostring(delay), 10, 40, DrawMode.Sprite, "large", 15)
  --DrawText(tostring(nextFire), 10, 50, DrawMode.Sprite, "large", 15)

  RedrawDisplay()--apaga a tela e redesenha o tilemap
  
  DrawMetaSprite("tank_" .. player1.orientation,player1.px,player1.py,false,false,DrawMode.Sprite)

  for i,b in ipairs(player1_bullets) do
    DrawMetaSprite("bullet_" .. b.orientation,b.x,b.y,false,false,DrawMode.Sprite)
  end

end


function control_check()

  if Button(Buttons.A) and delay >= 2000 then -- tiro do player1
    delay = 0;
    PlaySound(2)
    fire()
  end

  if Button(Buttons.Right) then
    
    player1.orientation = "right"
    if physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,0) then
      player1.dx=0
    else
      player1.dx = 1 
    end

  elseif Button(Buttons.Left) then
    
    player1.orientation = "left"
    if physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,0) then
      player1.dx=0
    else
      player1.dx = -1
    end

  elseif Button(Buttons.Up) then
    
    player1.orientation = "up"
    if physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,0) then
      player1.dy = 0
    else
      player1.dy = -1
    end

  elseif Button(Buttons.Down) then
    
    player1.orientation = "down"
    if physics_check_hit_box(player1.px,player1.py,player1.w,player1.h,player1.orientation,0) then
      player1.dy = 0
    else
      player1.dy = 1
    end

  else

    player1.dx = 0
    player1.dy = 0

  end

  
  if (Button(Buttons.Right) and Button(Buttons.Up)) or (Button(Buttons.Left) and Button(Buttons.Up)) or (Button(Buttons.Down) and Button(Buttons.Left)) or (Button(Buttons.Down) and Button(Buttons.Right))    then
    player1.dx = 0
    player1.dy = 0
  end


  player1.px += player1.dx
  player1.py += player1.dy


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

  if Flag(x1, y1) == flag
  or Flag(x1, y2) == flag
  or Flag(x2, y1) == flag
  or Flag(x2, y2) == flag then
      return true
  end

  return false
end



