-- This point will store the current tile's position
 tilePosition = NewPoint()

-- This will store the current flag ID
 flagID = -1


function ShowFlagMouse()

  -- Get the current mouse position
  tilePosition = MousePosition()

  -- Check to see if the mouse is out of bounds
  if(tilePosition.X < 0 or tilePosition.X > Display().X or tilePosition.Y < 0 or tilePosition.Y >= Display().Y) then

      -- Set all of the values to -1
      tilePosition.X = -1;
      tilePosition.Y = -1;
      flagID = -1;

      -- Return before the position and flag are calculated
      return

  end

  -- Convert the mouse position to the tilemap's correct column and row
  tilePosition.x = math.floor(tilePosition.x / 8)
  tilePosition.y = math.floor(tilePosition.y / 8)

  -- Get the flag value of the current tile
  flagID = Flag(tilePosition.x, tilePosition.y)

end

