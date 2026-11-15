function FlowerTile(vid) : GrassTile(vid) constructor
{
	connectsToGrass = true;
	
	static render = function(screen, level, xx, yy)
	{
		grass_render(screen, level, xx, yy);

		var data = level.getData(xx, yy);
		var shape = (data / 16) % 2;
		var flowerCol = global.Color.get(10, level.grassColor, 555, 440);

		if (shape == 0)
			screen.render(xx * 16 + 0, yy * 16 + 0, 1 + 1 * 32, flowerCol, 0);
		if (shape == 1)
			screen.render(xx * 16 + 8, yy * 16 + 0, 1 + 1 * 32, flowerCol, 0);
		if (shape == 1)
			screen.render(xx * 16 + 0, yy * 16 + 8, 1 + 1 * 32, flowerCol, 0);
		if (shape == 0)
			screen.render(xx * 16 + 8, yy * 16 + 8, 1 + 1 * 32, flowerCol, 0);
	}
	static interact = function(level, xx, yy, player, item, attackDir)
	{
		if (is_instanceof(item, ToolItem))
		{
			var tool = item;
			if (tool.type == global.ToolType.shovel)
			{
				if (player.payStamina(4 - tool.level))
				{
					level.add(new ItemEntity(new ResourceItem(global.Resource.flower), xx * 16 + prandom.NextInt(10) + 3, yy * 16 + prandom.NextInt(10) + 3));
					level.add(new ItemEntity(new ResourceItem(global.Resource.flower), xx * 16 + prandom.NextInt(10) + 3, yy * 16 + prandom.NextInt(10) + 3));
					level.setTile(xx, yy, global.Tile.grass, 0);
					return true;
				}
			}
		}
		return false;
	}
	static hurt6 = function(level, xx, yy, source, dmg, attackDir)
	{
		var count = prandom.NextInt(2) + 1;
		for (var i = 0; i < count; i++)
			level.add(new ItemEntity(new ResourceItem(global.Resource.flower), xx * 16 + prandom.NextInt(10) + 3, yy * 16 + prandom.NextInt(10) + 3));
		level.setTile(xx, yy, global.Tile.grass, 0);
	}
}