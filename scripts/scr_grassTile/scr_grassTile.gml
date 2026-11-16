function GrassTile(vid) : Tile(vid, false) constructor 
{
	connectsToGrass = true;
	
	render = function(screen, level, xx, yy)
	{ grass_render(screen, level, xx, yy); }
	grass_render = function(screen, level, xx, yy)
	{
		var col = Color.get(level.grassColor, level.grassColor, level.grassColor + 111, level.grassColor + 111);
		var transitionColor = Color.get(level.grassColor - 111, level.grassColor, level.grassColor + 111, level.dirtColor);

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
	tick = function(level, xt, yt)
	{
		var xn = xt;
		var yn = yt;

		if (prandom.NextBoolean())
			xn += prandom.NextInt(2) * 2 - 1;
		else
			yn += prandom.NextInt(2) * 2 - 1;

		if (level.getTile(xn, yn) == Tile.dirt)
			level.setTile(xn, yn, self, 0);
	}
	interact = function(level, xt, yt, player, item, attackDir)
	{
		if (is_instanceof(item, ToolItem))
		{
			var tool = item;
			
			if (tool.type == ToolType.shovel)
			{
				if (player.payStamina(4 - tool.level))
				{
					level.setTile(xt, yt, Tile.dirt, 0);
					Sound.monsterHurt.play();
					var seed_chance = prandom.NextInt(5);
					if (seed_chance == 0)
					{
						level.add(new ItemEntity(new ResourceItem(Resource.seeds), xt * 16 + prandom.NextInt(10) + 3, yt * 16 + prandom.NextInt(10) + 3));
						return true;
					}
				}
			}
			
			if (tool.type == ToolType.hoe)
			{
				if (player.payStamina(4 - tool.level))
				{
					Sound.monsterHurt.play();
					var seed_chance = prandom.NextInt(5);
					if (seed_chance == 0)
					{
						level.add(new ItemEntity(new ResourceItem(Resource.seeds), xt * 16 + prandom.NextInt(10) + 3, yt * 16 + prandom.NextInt(10) + 3));
						return true;
					}
					level.setTile(xt, yt, Tile.farmland, 0);
					return true;
				}
			}
		}
		return false;

	}
}