function DirtTile(vid) : Tile(vid, false) constructor
{
	render = function(screen, level, xx, yy)
	{
		var col = Color.get(level.dirtColor, level.dirtColor, level.dirtColor - 111, level.dirtColor - 111);
		screen.render(xx * 16 + 0, yy * 16 + 0, 0, col, 0);
		screen.render(xx * 16 + 8, yy * 16 + 0, 1, col, 0);
		screen.render(xx * 16 + 0, yy * 16 + 8, 2, col, 0);
		screen.render(xx * 16 + 8, yy * 16 + 8, 3, col, 0);
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
					level.setTile(xt, yt, Tile.hole, 0);
					level.add(new ItemEntity(new ResourceItem(Resource.dirt), xt * 16 + prandom.NextInt(10) + 3, yt * 16 + prandom.NextInt(10) + 3));
					Sound.monsterHurt.play();
					return true;
				}
			}
			if (tool.type == ToolType.hoe)
			{
				if (player.payStamina(4 - tool.level))
				{
					level.setTile(xt, yt, Tile.farmland, 0);
					Sound.monsterHurt.play();
					return true;
				}
			}
		}
		return false;
	}
}
