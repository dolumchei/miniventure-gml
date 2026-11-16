function SmashParticle(xx, yy) : Entity() constructor
{
	time = 0; 
	self.x = xx; 
	self.y = yy; 
	global.Sound.monsterHurt.play(); 

	tick = function()
	{
		time++; 
		if (time > 10)
			remove(); 
	}
	render = function(screen)
	{
		var col = global.Color.get(-1, 555, 555, 555);
		screen.render(x - 8, y - 8, 5 + 12 * 32, col, 2); 
		screen.render(x - 0, y - 8, 5 + 12 * 32, col, 3); 
		screen.render(x - 8, y - 0, 5 + 12 * 32, col, 0); 
		screen.render(x - 0, y - 0, 5 + 12 * 32, col, 1); 
	}
}
