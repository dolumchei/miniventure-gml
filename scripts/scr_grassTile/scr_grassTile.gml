function GrassTile(vid) : singleton_Tile(vid, false) constructor 
{
	connectsToGrass = true;
	
	static render = function(screen, level, xx, yy)
	{ grass_render(screen, level, xx, yy); }
	static grass_render = function(screen, level, xx, yy)
	{
		var col = global.Color.get(level.grassColor, level.grassColor, level.grassColor + 111, level.grassColor + 111);
		var transitionColor = global.Color.get(level.grassColor - 111, level.grassColor, level.grassColor + 111, level.dirtColor);

		var u = !level.getTile(xx, yy - 1).connectsToGrass;
		var d = !level.getTile(xx, yy + 1).connectsToGrass;
		var l = !level.getTile(xx - 1, yy).connectsToGrass;
		var r = !level.getTile(xx + 1, yy).connectsToGrass;

		if (!u && !l)
			screen.render(xx * 16 + 0, yy * 16 + 0, 0, col, 0);
		else
			screen.render(xx * 16 + 0, yy * 16 + 0, (l ? 11 : 12) + (u ? 0 : 1) * 32, transitionColor, 0);

		if (!u && !r)
			screen.render(xx * 16 + 8, yy * 16 + 0, 1, col, 0);
		else
			screen.render(xx * 16 + 8, yy * 16 + 0, (r ? 13 : 12) + (u ? 0 : 1) * 32, transitionColor, 0);

		if (!d && !l) 
			screen.render(xx * 16 + 0, yy * 16 + 8, 2, col, 0);
		else
			screen.render(xx * 16 + 0, yy * 16 + 8, (l ? 11 : 12) + (d ? 2 : 1) * 32, transitionColor, 0);
		
		if (!d && !r)
			screen.render(xx * 16 + 8, yy * 16 + 8, 3, col, 0);
		else
			screen.render(xx * 16 + 8, yy * 16 + 8, (r ? 13 : 12) + (d ? 2 : 1) * 32, transitionColor, 0);
	}
	static tick = function(level, xt, yt)
	{
		var xn = xt;
		var yn = yt;

		if (prandom.NextBoolean())
			xn += prandom.NextInt(2) * 2 - 1;
		else
			yn += prandom.NextInt(2) * 2 - 1;

		if (level.getTile(xn, yn) == global.Tile.dirt)
			level.setTile(xn, yn, self, 0);
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
					global.Sound.monsterHurt.play();
					var seed_chance = prandom.NextInt(5);
					if (seed_chance == 0)
					{
						level.add(new ItemEntity(new ResourceItem(global.Resource.seeds), xt * 16 + prandom.NextInt(10) + 3, yt * 16 + prandom.NextInt(10) + 3));
						return true;
					}
				}
			}
			
			if (tool.type == global.ToolType.hoe)
			{
				if (player.payStamina(4 - tool.level))
				{
					global.Sound.monsterHurt.play();
					var seed_chance = prandom.NextInt(5);
					if (seed_chance == 0)
					{
						level.add(new ItemEntity(new ResourceItem(global.Resource.seeds), xt * 16 + prandom.NextInt(10) + 3, yt * 16 + prandom.NextInt(10) + 3));
						return true;
					}
					level.setTile(xt, yt, global.Tile.farmland, 0);
					return true;
				}
			}
		}
		return false;

	}
}