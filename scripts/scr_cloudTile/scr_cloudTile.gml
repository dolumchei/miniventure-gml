function CloudTile(vid) : singleton_Tile(vid, false) constructor
{	
	static render = function(screen, level, xx, yy)
	{
		var col = global.Color.get(444, 444, 555, 555);
		var transitionColor = global.Color.get(333, 444, 555, -1);

		var u = level.getTile(xx, yy - 1) == global.Tile.infiniteFall;
		var d = level.getTile(xx, yy + 1) == global.Tile.infiniteFall;
		var l = level.getTile(xx - 1, yy) == global.Tile.infiniteFall;
		var r = level.getTile(xx + 1, yy) == global.Tile.infiniteFall;

		var ul = level.getTile(xx - 1, yy - 1) == global.Tile.infiniteFall;
		var dl = level.getTile(xx - 1, yy + 1) == global.Tile.infiniteFall;
		var ur = level.getTile(xx + 1, yy - 1) == global.Tile.infiniteFall;
		var dr = level.getTile(xx + 1, yy + 1) == global.Tile.infiniteFall;

		if (!u && !l)
		{
			if (!ul)
				screen.render(xx * 16 + 0, yy * 16 + 0, 17, col, 0);
			else
				screen.render(xx * 16 + 0, yy * 16 + 0, 7 + 0 * 32, transitionColor, 3);
		} else
			screen.render(xx * 16 + 0, yy * 16 + 0, (l ? 6 : 5) + (u ? 2 : 1) * 32, transitionColor, 3);

		if (!u && !r)
		{
			if (!ur)
				screen.render(xx * 16 + 8, yy * 16 + 0, 18, col, 0);
			else
				screen.render(xx * 16 + 8, yy * 16 + 0, 8 + 0 * 32, transitionColor, 3);
		} 
		else
			screen.render(xx * 16 + 8, yy * 16 + 0, (r ? 4 : 5) + (u ? 2 : 1) * 32, transitionColor, 3);

		if (!d && !l)
		{
			if (!dl)
				screen.render(xx * 16 + 0, yy * 16 + 8, 20, col, 0);
			else
				screen.render(xx * 16 + 0, yy * 16 + 8, 7 + 1 * 32, transitionColor, 3);
		} 
		else
			screen.render(xx * 16 + 0, yy * 16 + 8, (l ? 6 : 5) + (d ? 0 : 1) * 32, transitionColor, 3);
		if (!d && !r)
		{
			if (!dr)
				screen.render(xx * 16 + 8, yy * 16 + 8, 19, col, 0);
			else
				screen.render(xx * 16 + 8, yy * 16 + 8, 8 + 1 * 32, transitionColor, 3);
		} 
		else
			screen.render(xx * 16 + 8, yy * 16 + 8, (r ? 4 : 5) + (d ? 0 : 1) * 32, transitionColor, 3);
	}
	static mayPass = function(level, xx, yy, e)
	{
		return true;
	}
	static interact = function(level, xt, yt, player, item, attackDir)
	{
		if (is_instanceof(item, ToolItem))
		{
			var tool = item;
			if (tool.type == global.ToolType.shovel)
			{
				if (player.payStamina(5))
				{
					var count = irandom(2) + 1;
					for (var i = 0; i < count; i++)
						level.add(new ItemEntity(new ResourceItem(global.Resource.cloud), xt * 16 + irandom(10) + 3, yt * 16 + irandom(10) + 3));
					return true;
				}
			}
		}
		return false;
	}
}