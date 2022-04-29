


function basic_physics_box_cast(objA, objB)
    local xd = math.abs((objA.px + objA.w*0.5) - (objB.px + objB.w*0.5))
    local yd = math.abs((objA.py + objA.h*0.5) - (objB.py + objB.h*0.5))

    local xs = (objA.w + objB.w)*0.5
    local ys = (objA.h + objB.h)*0.5

    if xd < xs and yd < ys then
        return true
    end
    return false
end