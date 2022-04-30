function gameOver()
    DrawRect(7, 7, 240, 240, 13, DrawMode.TilemapCache)
    DrawText("The Winner is  "..winer , 32, 32,  DrawMode.SpriteAbove, "large", 15, -1)
    DrawText("Press R to play again...  " , 25, 50,  DrawMode.SpriteAbove, "large", 15, -1)
    

    if Key(Keys.R) then
        isGameStarted = false
        Init()
    end
end