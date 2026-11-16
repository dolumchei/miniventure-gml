function Spark(owner, xa, ya) : Entity() constructor
{
	time = 0;

	self.owner = owner;
	
	xx = owner.x;
	yy = owner.y;
	
	self.x = owner.x;
	self.y = owner.y;
	
	xr = 0;
	yr = 0;

	self.xa = xa;
	self.ya = ya;

	lifeTime = 60 * 10 + prandom.NextInt(30);
	
	tick = function()
	{
		time++;
		if (time >= lifeTime)
		{
			remove();
			return;
		}
		xx += xa;
		yy += ya;
		x = round(xx);
		y = round(yy);
		var toHit = level.getEntities(x, y, x, y);
		for (var i = 0; i < array_length(toHit); i++)
		{
			var e = toHit[i];
			if (is_instanceof(e, Mob) && !is_instanceof(e, AirWizard))
				e.hurt3(owner, 1, (e).dir ^ 1);
		}
	}
	isBlockableBy = function(mob)
	{
		return false;
	}
	render = function(screen)
	{
		if (time >= lifeTime - 6 * 20)
		{
			if (time / 6 % 2 == 0)
				return;
		}

		var xt = 8;
		var yt = 13;

		screen.render(x - 4, y - 4 - 2, xt + yt * 32, global.Color.get(-1, 555, 555, 555), prandom.NextInt(4));
		screen.render(x - 4, y - 4 + 2, xt + yt * 32, global.Color.get(-1, 000, 000, 000), prandom.NextInt(4));
	}
}
