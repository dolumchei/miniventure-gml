function Slime(lvl) : Mob() constructor
{
	xa = 0;
	ya = 0;
	jumpTime = 0;

	self.lvl = lvl;
	x = prandom.NextInt(64 * 16);
	y = prandom.NextInt(64 * 16);
	maxHealth = lvl * lvl * 5;
	healthValue = maxHealth;

	static tick = function()
	{
		mob_tick();

		var speedValue = 1;
		if (!move(xa * speedValue, ya * speedValue) || prandom.NextInt(40) == 0)
		{
			if (jumpTime <= -10)
			{
				xa = floor(prandom.NextInt(3) - 1);
				ya = floor(prandom.NextInt(3) - 1);

				if (level.player != undefined)
				{
					var xd = level.player.x - x;
					var yd = level.player.y - y;
					
					if (xd * xd + yd * yd < 50 * 50)
					{
						if (xd < 0)
							xa = -1;
						if (xd > 0)
							xa = 1;
						if (yd < 0)
							ya = -1;
						if (yd > 0)
							ya = 1;
					}

				}

				xa = floor(xa);
				ya = floor(ya);

				if (xa != 0 || ya != 0)
					jumpTime = 10;
			}
		}

		jumpTime--;
		if (jumpTime == 0)
		{
			xa = 0;
			ya = 0
		};
	}

	static die = function()
	{
		mob_die();

		var count = prandom.NextInt(2) + 1;
		for (var i = 0; i < count; i++)
			level.add(new ItemEntity(new ResourceItem(global.Resource.slime), x + prandom.NextInt(11) - 5, y + prandom.NextInt(11) - 5));

		if (level.player != undefined)
			level.player.scoreValue += 25 * lvl;
		
	}

	static render = function(screen)
	{
		var xt = 0;
		var yt = 18;

		var xo = x - 8;
		var yo = y - 11;

		if (jumpTime > 0)
		{
			xt += 2;
			yo -= 4;
		}

		var col = global.Color.get(-1, 10, 252, 555);
		if (lvl == 2)
			col = global.Color.get(-1, 100, 522, 555);
		if (lvl == 3)
			col = global.Color.get(-1, 111, 444, 555);
		if (lvl == 4)
			col = global.Color.get(-1, 000, 111, 224);

		if (hurtTime > 0)
			col = global.Color.get(-1, 555, 555, 555);

		screen.render(xo + 0, yo + 0, xt + yt * 32, col, 0);
		screen.render(xo + 8, yo + 0, xt + 1 + yt * 32, col, 0);
		screen.render(xo + 0, yo + 8, xt + (yt + 1) * 32, col, 0);
		screen.render(xo + 8, yo + 8, xt + 1 + (yt + 1) * 32, col, 0);
	}

	static touchedBy = function(entity)
	{
		if (is_instanceof(entity, Player))
			entity.hurt3(self, lvl, dir);
	}
}