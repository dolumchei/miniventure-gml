function StairsTile(vid, leadsUp) : singleton_Tile(vid, false) constructor {
	self.leadsUp = leadsUp;

	render = function(screen, level, xx, yy)
	{
		var color = global.Color.get(level.dirtColor, 000, 333, 444);
		var xt = 0;
		if (leadsUp)
			xt = 2;
		screen.render(xx * 16 + 0, yy * 16 + 0, xt + 2 * 32, color, 0);
		screen.render(xx * 16 + 8, yy * 16 + 0, xt + 1 + 2 * 32, color, 0);
		screen.render(xx * 16 + 0, yy * 16 + 8, xt + 3 * 32, color, 0);
		screen.render(xx * 16 + 8, yy * 16 + 8, xt + 1 + 3 * 32, color, 0);
	}
}
