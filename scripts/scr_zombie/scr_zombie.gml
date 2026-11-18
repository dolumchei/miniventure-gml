function Zombie(lvl) : Mob() constructor
{
	xa = 0;
	ya = 0;
	randomWalkTime = 0;

	self.lvl = lvl;
	x = prandom.nextInt(64 * 16);
	y = prandom.nextInt(64 * 16);
	maxHealth = lvl * lvl * 10;
	healthValue = maxHealth;

	tick = function()
	{
		mob_tick();

		if (level.player != undefined && randomWalkTime == 0)
		{
			var xd = floor(level.player.x - x);
			var yd = floor(level.player.y - y);
			if (xd * xd + yd * yd < 50 * 50)
			{
				xa = 0;
				ya = 0;
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

		var speedValue = tickTime & 1;
		if (!move(xa * speedValue, ya * speedValue) || prandom.nextInt(200) == 0)
		{
			randomWalkTime = 60;
			xa = (prandom.nextInt(3) - 1) * prandom.nextInt(2);
			ya = (prandom.nextInt(3) - 1) * prandom.nextInt(2);
		}
		if (randomWalkTime > 0)
			randomWalkTime--;
	}

	render = function(screen)
	{
		var xt = 0;
		var yt = 14;

		var flip1 = (walkDist >> 3) & 1;
		var flip2 = (walkDist >> 3) & 1;
		
		if (dir == 1)
			xt += 2;
		if (dir > 1)
		{

			flip1 = 0;
			flip2 = ((walkDist >> 4) & 1);
			if (dir == 2)
				flip1 = 1;
			xt += 4 + ((walkDist >> 3) & 1) * 2;
		}

		var xo = x - 8;
		var yo = y - 11;

		var col = Color.get(-1, 10, 252, 050);
		if (lvl == 2)
			col = Color.get(-1, 100, 522, 050);
		if (lvl == 3)
			col = Color.get(-1, 111, 444, 050);
		if (lvl == 4) 
			col = Color.get(-1, 000, 111, 020);
		if (hurtTime > 0)
			col = Color.get(-1, 555, 555, 555);

		screen.render(xo + 8 * flip1, yo + 0, xt + yt * 32, col, flip1);
		screen.render(xo + 8 - 8 * flip1, yo + 0, xt + 1 + yt * 32, col, flip1);
		screen.render(xo + 8 * flip2, yo + 8, xt + (yt + 1) * 32, col, flip2);
		screen.render(xo + 8 - 8 * flip2, yo + 8, xt + 1 + (yt + 1) * 32, col, flip2);
	}

	touchedBy = function(entity)
	{
		if (is_instanceof(entity, Player))
			entity.hurt3(self, lvl + 1, dir);
	}

	die = function()
	{
		mob_die();

		var count = prandom.nextInt(2) + 1;
		for (var i = 0; i < count; i++)
			level.add(new ItemEntity(new ResourceItem(Resource.cloth), x + prandom.nextInt(11) - 5, y + prandom.nextInt(11) - 5));

		if (level.player != undefined)
			level.player.scoreValue += 50 * lvl;
	}

}