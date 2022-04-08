basic_physics = {
    friction = 0.8,
    gravity = 0.3
}

function basic_physics.apply_friction(val)
    local result = val * basic_physics.friction
    return result
end

function basic_physics.apply_gravity(val)
    local result = val + basic_physics.gravity
    return result
end

function basic_physics.check_hit_box(obj, aim, flag)
    local x = obj.x
    local y = obj.y
    local w = obj.w
    local h = obj.h
    
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

  function basic_physics.box_cast(objA, objB)
    local xd = math.abs((objA.x + objA.w*0.5) - (objB.x + objB.w*0.5))
    local yd = math.abs((objA.y + objA.h*0.5) - (objB.y + objB.h*0.5))

    local xs = (objA.w + objB.w)*0.5
    local ys = (objA.h + objB.h)*0.5

    if xd < xs and yd < ys then
        return true
    end
    return false
  end