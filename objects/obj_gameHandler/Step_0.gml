tick();

if (global.config_debugKeys)
{
	if (!is_undefined(level))
	{
		if (!is_undefined(player))
		{
			var playerX = player.x;
			var playerY = player.y;
			
			var playerX_Tile = playerX >> 4;
			var playerY_Tile = playerY >> 4; 
			
			var player_Tile = level.getTile(playerX_Tile, playerY_Tile);
			
			if (keyboard_check_pressed(vk_f1) && currentLevel == 3)
				level.setTile(playerX_Tile + 1, playerY_Tile, global.Tile.stairsUp);	
			if (keyboard_check_pressed(vk_f2) && currentLevel > 0)
				level.setTile(playerX_Tile + 1, playerY_Tile, global.Tile.stairsDown);
			if (keyboard_check_pressed(vk_f3) && currentLevel < 3)
				level.setTile(playerX_Tile - 1, playerY_Tile, global.Tile.ironOre);
		}
	}
}

if (keyboard_check_pressed(ord("Z")) && global.config_debugMenu)
{
	if (is_undefined(menu) && !is_undefined(player))
		setMenu(new DebugMenu(player));
}