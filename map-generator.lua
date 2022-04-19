

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
        ::continue::

        x = math.random(8, 235)
        y = math.random(8, 235)
        
        x /= 8
        y /= 8


        if x>=9 and x<=21 and y>=26  then -- verifica se esta na posicao onde fica a bandeira do player1 se sim volta e randomiza denovo
            goto continue
            --print("("..math.floor(x) .. " ".. math.floor(y)..")")
        end

        if x>=9 and x<=21 and y<=6  then -- verifica se esta na posicao onde fica a bandeira do player2 se sim volta e randomiza denovo
            goto continue
            --print("("..math.floor(x) .. " ".. math.floor(y)..")")
        end
        map_level[math.floor(x)][math.floor(y)] = create_tile(nomeTile,flag)
        map_level[math.floor(x)+1][math.floor(y)] = create_tile(nomeTile,flag)
        map_level[math.floor(x)][math.floor(y)+1] = create_tile(nomeTile,flag)
        map_level[math.floor(x)+1][math.floor(y)+1] = create_tile(nomeTile,flag)
    end
    

   
  
end

function draw_level()
    for i,n in ipairs(map_level) do 
        for j,m in ipairs(n) do 
            Tile ( i, j, m.name, 0, m.flag, false, false ) -- seta como obstaculo
            --print("("..i .. " ".. j..")")
        end
    end
end