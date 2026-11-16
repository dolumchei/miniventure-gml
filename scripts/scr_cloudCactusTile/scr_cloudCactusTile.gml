function CloudCactusTile(vid) : singleton_Tile(vid, false) constructor
{
	render = function(screen, level, xx, yy)
	{
		var color = global.Color.get(444, 111, 333, 555); 
		screen.render(xx * 16 + 0, yy * 16 + 0, 17 + 1 * 32, color, 0);
		screen.render(xx * 16 + 8, yy * 16 + 0, 18 + 1 * 32, color, 0);
		screen.render(xx * 16 + 0, yy * 16 + 8, 17 + 2 * 32, color, 0);
		screen.render(xx * 16 + 8, yy * 16 + 8, 18 + 2 * 32, color, 0);
	}
	mayPass = function(level, xx, yy, e)
	{
		if (is_instanceof(e, AirWizard))
			return true;
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
			if (tool.type == global.ToolType.pickaxe)
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
		level.add(new TextParticle(string(dmg), xx * 16 + 8, yy * 16 + 8, global.Color.get(-1, 500, 500, 500)));
		if (dmg > 0)
		{
			if (damage >= 10)
				level.setTile(xx, yy, global.Tile.cloud, 0);
			else
				level.setData(xx, yy, damage);
		}
	}
	bumpedInto = function(level, xx, yy, entity)
	{
		if (is_undefined(entity))
			return;
		if (is_instanceof(entity, AirWizard))
			return;
			
		entity.tile_hurt4(self, xx, yy, 3);
	}
}