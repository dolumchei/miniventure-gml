function AirWizard() : Mob() constructor
{
	xa = 0;
	ya = 0;;
	randomWalkTime = 0;
	attackDelay = 0;
	attackTime = 0;
	attackType = 0;

	x = prandom.NextInt(64 * 16);
	y = prandom.NextInt(64 * 16);
	maxHealth = 2000;
	healthValue = maxHealth;
	
	tick = function()
	{
		mob_tick();
		
		if (attackDelay > 0)
		{
			dir = (attackDelay - 45) / 4 % 4;
			dir = (dir * 2 % 4) + (dir / 2);
			if (attackDelay < 45)
				dir = 0;

			attackDelay--;
			if (attackDelay == 0)
			{
				attackType = 0;
				if (healthValue < 1000)
					attackType = 1;
				if (healthValue < 200)
					attackType = 2;
				attackTime = 60 * 2;
			}
			return;
		}


		if (attackTime > 0)
		{
			attackTime--;
			var dir = attackTime * 0.25 * (attackTime % 2 * 2 - 1);
			var speedValue = (0.7) + attackType * 0.2;
			level.add(new Spark(self, cos(dir) * speedValue, sin(dir) * speedValue));
			return;
		}

		if (level.player != undefined && randomWalkTime == 0)
		{
			var xd = level.player.x - x;
			var yd = level.player.y - y;
			if (xd * xd + yd * yd < 32 * 32)
			{
				xa = 0;
				ya = 0;
				if (xd < 0)
					xa = 1;
				if (xd > 0)
					xa = -1;
				if (yd < 0)
					ya = 1;
				if (yd > 0)
					ya = -1;
			}
			else if (xd * xd + yd * yd > 80 * 80)
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

		var speedValue = (tickTime % 4) == 0 ? 0 : 1;
		if (!move(xa * speedValue, ya * speedValue) || prandom.NextInt(100) == 0)
		{
			randomWalkTime = 30;
			xa = (prandom.NextInt(3) - 1);
			ya = (prandom.NextInt(3) - 1);
		}
		if (randomWalkTime > 0)
		{
			randomWalkTime--;
			if (level.player != undefined && randomWalkTime == 0)
			{
				var xd = level.player.x - x;
				var yd = level.player.y - y;
				
				if (prandom.NextInt(4) == 0 && xd * xd + yd * yd < 50 * 50)
				{
					if (attackDelay == 0 && attackTime == 0)
						attackDelay = 60 * 2;
				}
			}
		}
	}
	render = function(screen)
	{
		var xt = 8;
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

		var col1 = Color.get(-1, 100, 500, 555);
		var col2 = Color.get(-1, 100, 500, 532);
		if (healthValue < 200)
		{
			if (tickTime / 3 % 2 == 0)
			{
				col1 = Color.get(-1, 500, 100, 555);
				col2 = Color.get(-1, 500, 100, 532);
			}
		}
		else if (healthValue < 1000)
		{
			if (tickTime / 5 % 4 == 0)
			{
				col1 = Color.get(-1, 500, 100, 555);
				col2 = Color.get(-1, 500, 100, 532);
			}
		}
		if (hurtTime > 0)
		{
			col1 = Color.get(-1, 555, 555, 555);
			col2 = Color.get(-1, 555, 555, 555);
		}

		screen.render(xo + 8 * flip1, yo + 0, xt + yt * 32, col1, flip1);
		screen.render(xo + 8 - 8 * flip1, yo + 0, xt + 1 + yt * 32, col1, flip1);
		screen.render(xo + 8 * flip2, yo + 8, xt + (yt + 1) * 32, col2, flip2);
		screen.render(xo + 8 - 8 * flip2, yo + 8, xt + 1 + (yt + 1) * 32, col2, flip2);
	}

	touchedBy = function(entity)
	{
		if (is_instanceof(entity, Player))
			entity.hurt3(self, 3, dir);
	}
	die = function()
	{
		mob_die();
		if (level.player != undefined)
		{
			level.player.scoreValue += 1000;
			level.player.gameWon();
		}
		Sound.bossdeath.play();
	}

}