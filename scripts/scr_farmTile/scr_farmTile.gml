function FarmTile(vid) : singleton_Tile(vid, false) constructor
{
	static render = function(screen, level, xx, yy)
	{
		var col = global.Color.get(level.dirtColor - 121, level.dirtColor - 11, level.dirtColor, level.dirtColor + 111);
		screen.render(xx * 16 + 0, yy * 16 + 0, 2 + 32, col, 1);
		screen.render(xx * 16 + 8, yy * 16 + 0, 2 + 32, col, 0);
		screen.render(xx * 16 + 0, yy * 16 + 8, 2 + 32, col, 0);
		screen.render(xx * 16 + 8, yy * 16 + 8, 2 + 32, col, 1);
	}
	static interact = function(level, xt, yt, player, item, attackDir)
	{
		if (is_instanceof(item, ToolItem))
		{
			var tool = item;
			if (tool.type == global.ToolType.shovel) 
			{
				if (player.payStamina(4 - tool.level))
				{
					level.setTile(xt, yt, global.Tile.dirt, 0);
					return true;
				}
			}
		}
		return false;
	}
	static tick = function(level, xt, yt)
	{
		var age = level.getData(xt, yt);
		if (age < 5)
			level.setData(xt, yt, age + 1);
	}
	static steppedOn = function(level, xt, yt, entity)
	{
		if (prandom.NextInt(60) != 0)
			return;
		if (level.getData(xt, yt) < 5)
			return;
		
		level.setTile(xt, yt, global.Tile.dirt, 0);
		
	}
}