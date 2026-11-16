function HardRockTile(vid) : RockTile(vid) constructor
{
	mainColor = 334;
	darkColor = 001;
	t = self;
	
	hurt6 = function(level, xx, yy, source, dmg, attackDir)
	{
		hurt4(level, xx, yy, 0);
	}
	interact = function(level, xt, yt, player, item, attackDir)
	{
		if (is_instanceof(item, ToolItem))
		{
			var tool = item;
			if (tool.type == global.ToolType.pickaxe && tool.level == 4)
			{
				if (player.payStamina(4 - tool.level))
				{
					hurt4(level, xt, yt, prandom.NextInt(10) + (tool.level) * 5 + 10);
					return true;
				}
			}
		}
		return false;
	}
}