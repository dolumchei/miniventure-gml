function WheatTile(vid) : Tile(vid, false) constructor
{
	render = function(screen, level, xx, yy)
	{
		var age = level.getData(xx, yy);
		var col = Color.get(level.dirtColor - 121, level.dirtColor - 11, level.dirtColor, 50);
		var icon = age div 10;
		if (icon >= 3)
		{
			col = Color.get(level.dirtColor - 121, level.dirtColor - 11, 50 + (icon) * 100, 40 + (icon - 3) * 2 * 100);
			if (age == 50)
				col = Color.get(0, 0, 50 + (icon) * 100, 40 + (icon - 3) * 2 * 100);
			icon = 3;
		}

		screen.render(xx * 16 + 0, yy * 16 + 0, 4 + 3 * 32 + icon, col, 0);
		screen.render(xx * 16 + 8, yy * 16 + 0, 4 + 3 * 32 + icon, col, 0);
		screen.render(xx * 16 + 0, yy * 16 + 8, 4 + 3 * 32 + icon, col, 1);
		screen.render(xx * 16 + 8, yy * 16 + 8, 4 + 3 * 32 + icon, col, 1);
	}
	tick = function(level, xt, yt)
	{
		if (prandom.nextBoolean() == false)
			return;

		var age = level.getData(xt, yt);
		if (age < 50)
		level.setData(xt, yt, age + 1);
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
					return true;
				}
			}
		}
		return false;
	}
	steppedOn = function(level, xt, yt, entity)
	{
		if (prandom.nextInt(60) != 0)
			return;
		if (level.getData(xt, yt) < 2)
			return;
		harvest(level, xt, yt);
	}
	hurt6 = function(level, xx, yy, source, dmg, attackDir)
	{
		harvest(level, xx, yy);
	}
	harvest = function(level, xx, yy)
	{
		var age = level.getData(xx, yy);

		var count = prandom.nextInt(2);
		for (var i = 0; i < count; i++)
			level.add(new ItemEntity(new ResourceItem(Resource.seeds), xx * 16 + prandom.nextInt(10) + 3, yy * 16 + prandom.nextInt(10) + 3));

		count = 0;
		if (age == 50)
			count = prandom.nextInt(3) + 2;
		else if (age >= 40)
			count = prandom.nextInt(2) + 1;

		for (var i = 0; i < count; i++)
			level.add(new ItemEntity(new ResourceItem(Resource.wheat), xx * 16 + prandom.nextInt(10) + 3, yy * 16 + prandom.nextInt(10) + 3));

		level.setTile(xx, yy, Tile.dirt, 0);
	}
}
