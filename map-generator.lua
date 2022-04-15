

map_level = {} -- mapa q vai ser desenhado

function create_tile(_name, _flag)
    
    local level_sprite = {
        flag = _flag,
        name = _name
    }

    return level_sprite
end



function level_generate(nomeTile, flag,_times) -- chamar no init uma unica vez
  
    map_level = {}          -- create the matrix
    for i=0,32 do
        map_level[i] = {}     -- create a new row
      for j=0,32 do
        map_level[i][j] = {}
      end
    end

    for i=0,_times,1 do
        x = math.random(0, 256)
        y = math.random(0, 256)
        
        x /= 8
        y /= 8
        map_level[math.floor(x)][math.floor(y)] = create_tile(nomeTile,flag)
        map_level[math.floor(x)+1][math.floor(y)] = create_tile(nomeTile,flag)
        map_level[math.floor(x)][math.floor(y)+1] = create_tile(nomeTile,flag)
        map_level[math.floor(x)+1][math.floor(y)+1] = create_tile(nomeTile,flag)
    end
    

  
    --table.insert(map_level,create_tile("agua",80)) -- cria um tile de agua a partir do tile 200

   
  
end

function draw_level()
    for i,n in ipairs(map_level) do 
        for j,m in ipairs(n) do 
            --tilePosition_x = math.abs(m.x / 8)
            --tilePosition_y = math.abs(m.y / 8)
            Tile ( i, j, m.name, 0, m.flag, false, false ) -- seta como obstaculo
        end
    end
end