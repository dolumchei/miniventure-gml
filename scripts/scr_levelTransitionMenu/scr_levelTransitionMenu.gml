function LevelTransitionMenu(dir) : Menu() constructor
{
	self.dir = dir; 
	time = 0; 

	static tick = function()
	{
		time += 2; 
		if (time == 30)
			game.changeLevel(dir); 
		if (time == 60)
			game.setMenu(undefined); 
	}
	
	static render = function(screen)
	{
		for (var xv = 0; xv < (WIDTH / 3); xv++)
		{ 
			for (var yv = 0; yv < (HEIGHT / 3); yv++)
			{ 
				var dd = (yv + xv % 2 * 2 + xv / 3) - time; 
				if (dd < 0 && dd > -30)
				{
					if (dir > 0)
						screen.render(xv * 8, yv * 8, 0, global.Color.get(0, 0, 0, 0), 0); 
					else
						screen.render(xv * 8, screen.h - yv * 8 - 8, 0, global.Color.get(0, 0, 0, 0), 0); 
				}
			}
		}
	}
}
