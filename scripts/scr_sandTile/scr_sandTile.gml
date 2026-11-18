function SandTile(vid) : Tile(vid, false) constructor
{
	connectsToSand = true;
	
	render = function(screen, level, xx, yy)
	{
		var col = Color.get(level.sandColor + 2, level.sandColor, level.sandColor - 110, level.sandColor - 110);
		var transitionColor = Color.get(level.sandColor - 110, level.sandColor, level.sandColor - 110, level.dirtColor);

		var u = !level.getTile(xx, yy - 1).connectsToSand;
		var d = !level.getTile(xx, yy + 1).connectsToSand;
		var l = !level.getTile(xx - 1, yy).connectsToSand;
		var r = !level.getTile(xx + 1, yy).connectsToSand;

		var steppedOn = level.getData(xx, yy) > 0;

		if (!u && !l)
		{
			if (!steppedOn)
				screen.render(xx * 16 + 0, yy * 16 + 0, 0, col, 0);
			else
				screen.render(xx * 16 + 0, yy * 16 + 0, 3 + 1 * 32, col, 0);
		} 
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
		{
			if (!steppedOn)
				screen.render(xx * 16 + 8, yy * 16 + 8, 3, col, 0);
			else
				screen.render(xx * 16 + 8, yy * 16 + 8, 3 + 1 * 32, col, 0);

		} 
		else
			screen.render(xx * 16 + 8, yy * 16 + 8, (r ? 13 : 12) + (d ? 2 : 1) * 32, transitionColor, 0);
	}
	tick = function(level, xx, yy)
	{
		var d = level.getData(xx, yy);
		if (d > 0) 
			level.setData(xx, yy, d - 1);
	}
	steppedOn = function(level, xx, yy, entity)
	{
		if (is_instanceof(entity, Mob))
			level.setData(xx, yy, 10);
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
					
					level.add(new ItemEntity(new ResourceItem(Resource.sand), xt * 16 + prandom.nextInt(10) + 3, yt * 16 + prandom.nextInt(10) + 3));
					return true;
				}
			}
		}
		return false;
	}
}
