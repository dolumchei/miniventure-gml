function OreTile(vid, toDrop) : Tile(vid, false) constructor
{
	self.toDrop = toDrop;
	color = toDrop.color;

	render = function(screen, level, xx, yy)
	{
		color = Color.get(level.dirtColor, toDrop.color[1], toDrop.color[2], toDrop.color[3]);
		
		screen.render(xx * 16 + 0, yy * 16 + 0, 17 + 1 * 32, color, 0);
		screen.render(xx * 16 + 8, yy * 16 + 0, 18 + 1 * 32, color, 0);
		screen.render(xx * 16 + 0, yy * 16 + 8, 17 + 2 * 32, color, 0);
		screen.render(xx * 16 + 8, yy * 16 + 8, 18 + 2 * 32, color, 0);
	}	
	mayPass = function(level, xx, yy, e)
	{
		return false;
	}
	hurt6 = function(level, xx, yy, source, dmg, attackDir)
	{
		hurt4(level, xx, yy, 0);
	}
	interact = function(level, xt, yt, player, item, attackDir)
	{
		if (is_instanceof(item, ToolItem))
		{
			var tool = item;
			if (tool.type == ToolType.pickaxe)
			{
				if (player.payStamina(6 - tool.level))
				{
					hurt4(level, xt, yt, 1);
					return true;
				}
			}
		}
		return false;
	}
	hurt4 = function(level, xx, yy, dmg)
	{
		var damage = level.getData(xx, yy) + 1;
		level.add(new SmashParticle(xx * 16 + 8, yy * 16 + 8));
		level.add(new TextParticle(string(dmg), xx * 16 + 8, yy * 16 + 8, Color.get(-1, 500, 500, 500)));
		if (dmg > 0)
		{
			var count = prandom.NextInt(2);
			if (damage >= prandom.NextInt(10) + 3)
			{
				level.setTile(xx, yy, Tile.dirt, 0);
				count += 2;
			} 
			else
				level.setData(xx, yy, damage);
			for (var i = 0; i < count; i++)
				level.add(new ItemEntity(new ResourceItem(toDrop), xx * 16 + prandom.NextInt(10) + 3, yy * 16 + prandom.NextInt(10) + 3));
		}
	}
	bumpedInto = function(level, xx, yy, entity)
	{
		if (entity != undefined)
			entity.tile_hurt4(self, xx, yy, 3);
	}
}