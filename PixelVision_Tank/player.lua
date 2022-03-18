LoadScript("transformcomponent")
local max_dx = 2.0
local max_dy = 3.0

player = {
    x = 0,
    y = 0,
    flip = false,
    dx = 0,
    dy = 0,
    sprite = 1,
    acc = 0.5,
    boost = 4,
    w = 8,
    h = 8,
    landed = false,
    jumping = false,
    falling = false
}

function player.init()
    player.x = 67
    player.y = 69
end

function player.control_check()
    if Button(Buttons.Right) then player.dx += player.acc player.flip = false end
    if Button(Buttons.Left) then player.dx -= player.acc player.flip = true end
    if Button(Buttons.A) and player.landed then 
        player.dy -= player.boost 
        player.landed = false
    end

    if player.dy > 0 then
        player.falling = true
        player.landed = false
        player.jumping = false
        player.dy = clamp(-max_dy,player.dy,max_dy)
        if basic_physics.check_hit_box(player, "down", 0) then
            player.dy = 0
            player.falling = false
            player.landed = true
            player.y -=((player.y+player.h)%8)
        end
    elseif player.dy < 0 then
        player.jumping = true
        if basic_physics.check_hit_box(player, "up", 0) then
            player.dy = 0
        end
    end

    if player.dx < 0 then
        player.dx = clamp(-max_dx,player.dx,max_dx)
        if basic_physics.check_hit_box(player, "left", 0) then
            player.dx = 0
        end
    elseif player.dx > 0 then
        player.dx = clamp(-max_dx,player.dx,max_dx)
        if basic_physics.check_hit_box(player, "right", 0) then
            player.dx = 0
        end
    end

    player.x += player.dx
    player.y += player.dy
end
