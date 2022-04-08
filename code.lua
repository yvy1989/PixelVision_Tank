
 
local message = "EMPTY LUA \n\n\nThis is an empty  template.\n\n\nVisit 'www.pixelvision8.com' to learn more about creating games from scratch."


Player1_Orientation = "up" -- variavel que guarda a direcao do player1

local px = 67 
local py = 69 

local Player1_dx = 0;
local Player1_dy = 0;





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


  if Button(Buttons.Right) then
    
    Player1_Orientation = "right"
    if physics_check_hit_box(px,py,16,16,Player1_Orientation,0) then
      Player1_dx=0
    else
      Player1_dx = 1 
    end

  elseif Button(Buttons.Left) then
    
    Player1_Orientation = "left"
    if physics_check_hit_box(px,py,16,16,Player1_Orientation,0) then
      Player1_dx=0
    else
      Player1_dx = -1
    end

  elseif Button(Buttons.Up) then
    
    Player1_Orientation = "up"
    if physics_check_hit_box(px,py,16,16,Player1_Orientation,0) then
      Player1_dy=0
    else
      Player1_dy = -1
    end

  elseif Button(Buttons.Down) then
    
    Player1_Orientation = "down"
    if physics_check_hit_box(px,py,16,16,Player1_Orientation,0) then
      Player1_dy=0
    else
      Player1_dy = 1
    end

  else

    Player1_dx=0
    Player1_dy=0

  end

  
  if (Button(Buttons.Right) and Button(Buttons.Up)) or (Button(Buttons.Left) and Button(Buttons.Up)) or (Button(Buttons.Down) and Button(Buttons.Left)) or (Button(Buttons.Down) and Button(Buttons.Right))    then
    Player1_dx=0
    Player1_dy=0
  end


  px += Player1_dx
  py += Player1_dy


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



