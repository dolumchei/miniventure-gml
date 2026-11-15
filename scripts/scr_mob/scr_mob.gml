function Mob() : Entity() constructor
{
	walkDist = 0;
	dir = 0;
	hurtTime = 0;
	xKnockback = 0;
	yKnockback = 0; 
	maxHealth = 10;
	healthValue = maxHealth;
	swimTimer = 0;
	tickTime = 0;

	x = 8;
	y = 8;
	xr = 4;
	yr = 3;

	static tick = function() { mob_tick(); }
	static mob_tick = function()
	{
		tickTime++;
		if (level.getTile(x >> 4, y >> 4) == global.Tile.lava)
			hurt3(self, 4, dir ^ 1);

		if (healthValue <= 0)
			die();

		if (hurtTime > 0)
			hurtTime--;
	}
	static die = function() { mob_die(); }
	static mob_die = function()
	{
		remove();
	}
	static move = function(xa, ya)
	{
		if (isSwimming())
		{
			if (swimTimer++ % 2 == 0)
				return true;
		}
		if (xKnockback < 0)
		{
			move2(-1, 0);
			xKnockback++;
		}
		if (xKnockback > 0)
		{
			move2(1, 0);
			xKnockback--;
		}
		if (yKnockback < 0)
		{
			move2(0, -1);
			yKnockback++;
		}
		if (yKnockback > 0)
		{
			move2(0, 1);
			yKnockback--;
		}
		if (hurtTime > 0)
			return true;
		if (xa != 0 || ya != 0)
		{
			walkDist++;
			if (xa < 0)
				dir = 2;
			if (xa > 0)
				dir = 3;
			if (ya < 0)
				dir = 1;
			if (ya > 0)
				dir = 0;
		}
		return entity_move(xa, ya);
	}
	static isSwimming = function()
	{
		var tile = level.getTile(x >> 4, y >> 4);
		return tile == global.Tile.water || tile == global.Tile.lava;
	}
	static blocks = function(e)
	{
		return e.isBlockableBy(self);
	}
	static tile_hurt4 = function(tile, xx, yy, damage)
	{
		var attackDir = dir ^ 1;
		doHurt(damage, attackDir);
	}
	static hurt3 = function(mob, damage, attackDir)
	{
		doHurt(damage, attackDir);
	}
	static heal = function(heal)
	{
		if (hurtTime > 0)
			return;

		level.add(new TextParticle(string(heal), x, y, global.Color.get(-1, 50, 50, 50)));
		healthValue += heal;
		if (healthValue > maxHealth)
			healthValue = maxHealth;
	}
	static doHurt = function(damage, attackDir)
	{
		if (hurtTime > 0)
			return;

		if (level.player != undefined)
		{
			var xd = level.player.x - x;
			var yd = level.player.y - y;
			if (xd * xd + yd * yd < 80 * 80)
				global.Sound.monsterHurt.play();
		}
		level.add(new TextParticle(string(damage), x, y, global.Color.get(-1, 500, 500, 500)));
		healthValue -= damage;
		if (attackDir == 0)
			yKnockback = 6;
		if (attackDir == 1)
			yKnockback = -6;
		if (attackDir == 2)
			xKnockback = -6;
		if (attackDir == 3)
			xKnockback = 6;
		hurtTime = 10;
	}
	static findStartPos = function(level)
	{
		var vx = prandom.NextInt(level.w);
		var vy = prandom.NextInt(level.h);
		var xx = vx * 16 + 8;
		var yy = vy * 16 + 8;

		if (level.player != undefined)
		{
			var xd = level.player.x - xx;
			var yd = level.player.y - yy;
			if (xd * xd + yd * yd < 80 * 80)
				return false;
		}

		var r = level.monsterDensity * 16;
		if (array_length(level.getEntities(xx - r, yy - r, xx + r, yy + r)) > 0)
			return false;

		if (level.getTile(vx, vy).mayPass(level, vx, vy, self))
		{
			self.x = xx;
			self.y = yy;
			return true;
		}

		return false; 
	}
}
