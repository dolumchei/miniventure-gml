function TextParticle(msg, xx, yy, col) : Entity() constructor
{
	self.msg = msg; 
	self.x = xx; 
	self.y = yy; 
	self.col = col; 
	self.xx = xx; 
	self.yy = yy; 
	zz = 2; 
	xa = prandom.NextGaussian() * 0.3; 
	ya = prandom.NextGaussian() * 0.2; 
	za = prandom.NextFloat() * 0.7 + 2; 
	time = 0; 
	
	tick = function()
	{
		time++; 
		if (time > 60)
			remove(); 
		xx += xa; 
		yy += ya; 
		zz += za; 
		if (zz < 0)
		{ 
			zz = 0; 
			za *= -0.5; 
			xa *= 0.6; 
			ya *= 0.6; 
		}
		za -= 0.15; 
		x = round(xx); 
		y = round(yy); 
	}
	render = function(screen)
	{
		global.Font.draw(msg, screen, x - string_length(msg) * 4 + 1, y - round(zz) + 1, global.Color.get(-1, 0, 0, 0)); 
		global.Font.draw(msg, screen, x - string_length(msg) * 4, y - round(zz), col); 
	}
}
